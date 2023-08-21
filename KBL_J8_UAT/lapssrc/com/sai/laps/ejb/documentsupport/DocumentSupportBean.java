package com.sai.laps.ejb.documentsupport;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.documentresults.DocumentResultsBean;
import com.sai.laps.ejb.documentresults.DocumentResultsRemote;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "DocumentSupportBean", mappedName = "DocumentSupportHome")
@Remote (DocumentSupportRemote.class)
public class DocumentSupportBean extends BeanAdapter
{	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DocumentSupportBean.class);

	public HashMap getData(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord1 = new HashMap();
		HashMap hshRiskRating = new HashMap();

		HashMap hshRecord = new HashMap();


		

		String strQuery="";
		String strAppno="";

		String strEditlockflag = null;



		ArrayList arrToAmount = new ArrayList();
		ArrayList arrInterest = new ArrayList();



		DecimalFormat dc=new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);

		try
		{	
			
			strEditlockflag = (String)hshValues.get("hideditflag");
			
			hshRecord = new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery = SQLParser.getSqlQuery("selappraisalsanc^"+strAppno);
			
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{   
				hshRecord1.put("applname",correctNull(rs.getString("applname")));
				hshRecord1.put("app_createdate",correctNull(rs.getString("app_createdate")));
				hshRecord1.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
				hshRecord1.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
				hshRecord1.put("perapp_city",correctNull(rs.getString("perapp_city")));
				hshRecord1.put("perapp_state",correctNull(rs.getString("perapp_state")));
				hshRecord1.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
				hshRecord1.put("catdesc",correctNull(rs.getString("catdesc")));
				hshRecord1.put("subcatdesc",correctNull(rs.getString("subcatdesc")));
				hshRecord1.put("loan_modintrate",correctNull(rs.getString("loan_modintrate")));
				hshRecord1.put("loan_inttype",correctNull(rs.getString("loan_inttype")));
				hshRecord1.put("loan_costloanprd",correctNull(rs.getString("loan_costloanprd")));
				hshRecord1.put("loan_emi",correctNull(rs.getString("loan_emi")));
				hshRecord1.put("loan_reqterms",correctNull(rs.getString("loan_reqterms")));
				hshRecord1.put("loan_recmdamt",correctNull(rs.getString("loan_recmdamt")));
				hshRecord1.put("loan_purposeofloan",correctNull(rs.getString("prd_desc")));
				
				//hshRecord1.put("terms_content",correctNull(rs.getString("terms_content")));
				hshRecord1.put("prd_desc",correctNull(rs.getString("prd_desc")));
				
				hshRecord1.put("prdcode",correctNull(rs.getString("prd_code")));
				hshRecord1.put("recamt",correctNull(rs.getString("loan_recmdamt")));				
				hshRecord1.put("terms",correctNull(rs.getString("loan_reqterms")));
				hshRecord1.put("inttype",correctNull(rs.getString("loan_inttype")));
				hshRecord1.put("loan_filedon",correctNull(rs.getString("loan_filedon")));
				hshRecord1.put("orgcity",correctNull(rs.getString("org_city")));
			}
			try
			{	if(rs != null)
					rs.close();			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the ResultSet1 "+cf.getMessage());
			}
			
			/// for finding Interest above/below  BOBPLTR 

			
			
			hshRecord1.put("appno",strAppno);
			
			if(((String)hshRecord1.get("loan_inttype")).equalsIgnoreCase("fixed") || ((String)hshRecord1.get("loan_inttype")).equalsIgnoreCase("floating"))
			{			
						

				hshRiskRating=(HashMap)EJBInvoker.executeStateLess("perapplicant",hshRecord1,"getInterestRate");
				hshRecord1.put("interesttype",correctNull((String)hshRiskRating.get("interesttype")));
				hshRecord1.put("prd_interestid",correctNull((String)(hshRiskRating.get("prd_interestid"))));
				
				String loan_modintrate = Helper.correctDouble((String)hshRecord1.get("loan_modintrate"));
				String prd_baserate = Helper.correctDouble((String)hshRiskRating.get("prd_baserate"));
				String strprdadjust="0.00";
				if(Double.parseDouble(loan_modintrate) >= Double.parseDouble(prd_baserate))
				{
					hshRecord1.put("adjustBOBPLTR","above");
					strprdadjust = Helper.formatDoubleValue(Double.parseDouble(loan_modintrate)-Double.parseDouble(prd_baserate));
				}
				if(Double.parseDouble(loan_modintrate) < Double.parseDouble(prd_baserate))
				{
					hshRecord1.put("adjustBOBPLTR","below");
					strprdadjust = Helper.formatDoubleValue(Double.parseDouble(prd_baserate) - Double.parseDouble(loan_modintrate));
				}
				
				hshRecord1.put("prd_adjust",(String)strprdadjust);
				
				 /*strprdadjust= (String)hshRiskRating.get("prd_adjust");
				if(strprdadjust == null)
				{strprdadjust = "0.00";}				
				 adjust= (String)(hshRiskRating.get("prd_adjust"));
				if(adjust == null)
				{adjust = "0.00";}
				 adjustinterest1 = Double.parseDouble(adjust);
				String strTemp ="";
				if(adjustinterest1<0.00)
				{	strTemp =strprdadjust.substring(1,strprdadjust.length());
					hshRecord1.put("prd_adjust",(String)strTemp);
				}else
				{hshRecord1.put("prd_adjust",(String)strprdadjust);}				
				double adjustinterest =0.00;
				 adjust= (String)(hshRiskRating.get("prd_adjust"));
				 if(adjust == null){adjust = "0.00";}
				adjustinterest = Double.parseDouble(adjust);
				if(adjustinterest >= 0.00){hshRecord1.put("adjustBOBPLTR","above");}
				else if(adjustinterest < 0.00){hshRecord1.put("adjustBOBPLTR","below");	}
				*/
				
				String strIntID ="";				
				strIntID=correctNull((String)hshRecord1.get("prd_interestid"));
				if(strIntID == "")
				{
					strIntID = "0";
				}
				
				strQuery = SQLParser.getSqlQuery("selintdescription^"+strIntID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{   
					hshRecord1.put("int_intdesc",correctNull(rs.getString("int_intdesc")));		

				}
				try
				{	if(rs != null)
						rs.close();			
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the ResultSet1 "+cf.getMessage());
				}
			}

			else
			{	
				hshRiskRating=(HashMap)EJBInvoker.executeStateLess("perapplicant",hshRecord1,"getStepupRate");

			    arrToAmount = (ArrayList)hshRiskRating.get("toamt");
				arrInterest = (ArrayList)hshRiskRating.get("prd_interest");
				hshRecord1.put("toamt",(ArrayList)arrToAmount);
				hshRecord1.put("prd_interest",(ArrayList)arrInterest);
				hshRecord1.put("interesttype",hshRiskRating.get("interesttype"));				
			}

			hshRecord.put("hshRecord1",hshRecord1);
			

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login AppraisalSanction "+ce.toString());
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
	
	public HashMap getdueReport(HashMap hshValues) 
	{
		String strQuery =null;
		ResultSet rs = null,rs1=null;
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String hidDemoId=Helper.correctNull((String)hshValues.get("hidDemoId"));
		String strDemoID = Helper.correctNull((String) hshValues.get("hidDemoId"));
		String sessionModuleType= Helper.correctInt((String) hshValues.get("sessionModuleType"));
		String strNewId=Helper.correctInt((String) hshValues.get("hidapplicantid"));
		
		if(strDemoID.equals(""))
		{
			strDemoID = Helper.correctInt((String) hshValues.get("hidapplicantid"));
		}
		if(hidDemoId.equals(""))
		{
			hidDemoId = Helper.correctInt((String) hshValues.get("hidapplicantid"));
		}
		
		try
		{
			boolean newflag=false;
			
			if(!strDemoID.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("selrenewappid^"+strDemoID);
				if(rs.next())
				{
					strNewId=Helper.correctNull(rs.getString("perapp_id"));
				}
				if(rs!=null)
					rs.close();
			}
			
				strQuery = SQLParser.getSqlQuery("due_report_sel^"+appno+"^"+strDemoID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())		
			{
				newflag=true;
				hshValues.put("DUEDILIG_APPNO",correctNull(rs.getString("DUEDILIG_APPNO")));
				hshValues.put("DUEDILIG_APPID",correctNull(rs.getString("DUEDILIG_APPID")));
				hshValues.put("DDR_BANKWITHUS",correctNull(rs.getString("DDR_BANKWITHUS")));
				hshValues.put("DDR_ACC_CONDUCT",correctNull(rs.getString("DDR_ACC_CONDUCT")));
				hshValues.put("DDR_REPUT_INTRODUCER",correctNull(rs.getString("DDR_REPUT_INTRODUCER")));
				hshValues.put("DDR_SELFINTRO_DOC",correctNull(rs.getString("DDR_SELFINTRO_DOC")));
				hshValues.put("DDR_WHT_PHYINSP",correctNull(rs.getString("DDR_WHT_PHYINSP")));
				hshValues.put("DDR_PHYINSP_USERID",correctNull(rs.getString("DDR_PHYINSP_USERID")));
				hshValues.put("DDR_PHYINSP_USERNAME",correctNull(rs.getString("DDR_PHYINSP_USERNAME")));
				hshValues.put("DDR_PHYINSP_USERDESIG",correctNull(rs.getString("DDR_PHYINSP_USERDESIG")));
				hshValues.put("DDR_PHYINSP_REASON",correctNull(rs.getString("DDR_PHYINSP_REASON")));
				String DDR_PASSPORT_DET = correctNull(rs.getString("DDR_PASSPORT_DET"));
				if(!DDR_PASSPORT_DET.equals(""))
				{
					String[] temppassport=DDR_PASSPORT_DET.split("@");
					hshValues.put("passportNum", temppassport[0]);
					hshValues.put("passportdate", temppassport[1]);
					hshValues.put("passportplace", temppassport[2]);
				}
				String DDR_DRIVINGLICENCE_DET = correctNull(rs.getString("DDR_DRIVINGLICENCE_DET"));
				if(!DDR_DRIVINGLICENCE_DET.equals(""))
				{
					String[] tempDL=DDR_DRIVINGLICENCE_DET.split("@");
					hshValues.put("drivinglicNum", tempDL[0]);
					hshValues.put("drivinglicdate", tempDL[1]);
					hshValues.put("drivinglicplace", tempDL[2]);
				}
				String DDR_ELECTIONCARD_DET = correctNull(rs.getString("DDR_ELECTIONCARD_DET"));
				if(!DDR_ELECTIONCARD_DET.equals(""))
				{
					String[] tempelection=DDR_ELECTIONCARD_DET.split("@");
					hshValues.put("electionNum", tempelection[0]);
					hshValues.put("electiondate", tempelection[1]);
					hshValues.put("electionplace", tempelection[2]);
				}
				String DDR_OTHERDOC1_DET = correctNull(rs.getString("DDR_OTHERDOC1_DET"));
				if(!DDR_OTHERDOC1_DET.equals(""))
				{
					String[] tempother1=DDR_OTHERDOC1_DET.split("@");
					hshValues.put("otherdoc1Name", tempother1[0]);
					hshValues.put("otherdoc1Num", tempother1[1]);
					hshValues.put("otherdoc1date", tempother1[2]);
					hshValues.put("otherdoc1place", tempother1[3]);
				}
				String DDR_OTHERDOC2_DET = correctNull(rs.getString("DDR_OTHERDOC2_DET"));
				if(!DDR_OTHERDOC2_DET.equals(""))
				{
					String[] tempother2=DDR_OTHERDOC2_DET.split("@");
					hshValues.put("otherdoc2Name", tempother2[0]);
					hshValues.put("otherdoc2Num", tempother2[1]);
					hshValues.put("otherdoc2date", tempother2[2]);
					hshValues.put("otherdoc2place", tempother2[3]);
				}
				String DDR_OTHERDOC3_DET = correctNull(rs.getString("DDR_OTHERDOC3_DET"));
				if(!DDR_OTHERDOC3_DET.equals(""))
				{
					String[] tempother3=DDR_OTHERDOC3_DET.split("@");
					hshValues.put("otherdoc3Name", tempother3[0]);
					hshValues.put("otherdoc3Num", tempother3[1]);
					hshValues.put("otherdoc3date", tempother3[2]);
					hshValues.put("otherdoc3place", tempother3[3]);
				}
				hshValues.put("DDR_APPRESIDENCE",correctNull(rs.getString("DDR_APPRESIDENCE")));
				hshValues.put("DD_BRNAMENEARBYCODE",correctNull(rs.getString("DDR_APP_NEARBRANCH")));
				if(!correctNull(rs.getString("DDR_APP_NEARBRANCH")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
					rs1.close();
					
					rs1=DBUtils.executeLAPSQuery("selectorgname^"+correctNull(rs.getString("DDR_APP_NEARBRANCH")));
					if(rs1.next())
					{
						hshValues.put("DD_BRNAMENEARBYNAME",correctNull(rs1.getString("org_name")));
					}
				}
				hshValues.put("DD_KYC_DONEBYCODE",correctNull(rs.getString("DDR_KYC_COMPLIEDBY")));
				if(!correctNull(rs.getString("DDR_KYC_COMPLIEDBY")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selusername^"+correctNull(rs.getString("DDR_KYC_COMPLIEDBY")));
					if(rs1.next())
					{
						hshValues.put("DD_KYC_DONEBYNAME",correctNull(rs1.getString("usr_fname")));
					}
				}
				
				hshValues.put("DDR_PRESBANK_code",correctNull(rs.getString("DDR_PRESBANK_NAME")));
				
				String tempbankcode=correctNull(rs.getString("DDR_PRESBANK_NAME"));
				String tempbankname="";
				if(!tempbankcode.equals(""))
				{
					if(tempbankcode.contains("@"))
					{
						String[] temp=tempbankcode.split("@");
						for(int i=0;i<temp.length;i++)
						{
							if(rs1!=null)
								rs1.close();
							rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+temp[i]);
							if(rs1.next())
							{
								tempbankname=tempbankname+Helper.correctNull(rs1.getString("STAT_DATA_DESC1"))+"@";
							}
						}
					}
					else
					{
						if(rs1!=null)
							rs1.close();
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+tempbankcode);
						if(rs1.next())
						{
							tempbankname=Helper.correctNull(rs1.getString("STAT_DATA_DESC1"));
						}
					}
					
				}
				hshValues.put("DDR_PRESBANK_name",tempbankname);
				hshValues.put("DDR_PRESBANK_ADDRESS",correctNull(rs.getString("DDR_PRESBANK_ADDRESS")));
				hshValues.put("DDR_PRESBANK_BANKSINCE",correctNull(rs.getString("DDR_PRESBANK_BANKSINCE")));
				hshValues.put("DDR_PRESBANK_ACCVER_FROM",correctNull(rs.getString("DDR_PRESBANK_ACCVER_FROM")));
				hshValues.put("DDR_PRESBANK_ACCVER_TO",correctNull(rs.getString("DDR_PRESBANK_ACCVER_TO")));
				hshValues.put("DDR_PRESBANK_CHEQUERETURN",correctNull(rs.getString("DDR_PRESBANK_CHEQUERETURN")));
				hshValues.put("DDR_PRESBANK_MAXBAL",correctNull(rs.getString("DDR_PRESBANK_MAXBAL")));
				hshValues.put("DDR_PRESBANK_MINBAL",correctNull(rs.getString("DDR_PRESBANK_MINBAL")));
				hshValues.put("DDR_PRESBANK_TOTCTO",correctNull(rs.getString("DDR_PRESBANK_TOTCTO")));
				hshValues.put("DDR_PRESBANK_DIFINSALES",correctNull(rs.getString("DDR_PRESBANK_DIFINSALES")));
				hshValues.put("DDR_PRESBANK_VARIATIONRSN",correctNull(rs.getString("DDR_PRESBANK_VARIATIONRSN")));
				hshValues.put("DDR_PRESBANK_WHT_CONFREPOBT",correctNull(rs.getString("DDR_PRESBANK_WHT_CONFREPOBT")));
				hshValues.put("DDR_PRESBANK_CONFREPDATE",correctNull(rs.getString("DDR_PRESBANK_CONFREPDATE")));
				hshValues.put("DDR_PRESBANK_RSN_CONFREPOBT",correctNull(rs.getString("DDR_PRESBANK_RSN_CONFREPOBT")));
				
				hshValues.put("DD_FARM_VISITDATE",correctNull(rs.getString("DDR_AGR_FARMVISITDATE")));
				hshValues.put("DD_EXTENDOFLAND",correctNull(rs.getString("DDR_AGR_LANDEXTEND")));
				hshValues.put("DD_STAND_CROPSDETAILS",correctNull(rs.getString("DDR_AGR_STANDINGCROPS")));
				hshValues.put("DD_CROPS_GROWNDETAILS",correctNull(rs.getString("DDR_AGR_CROPGROWN")));
				hshValues.put("DD_LIAB_PACS",correctNull(rs.getString("DDR_AGR_LIAB_PACS")));
				hshValues.put("DD_NOC_RECVDDATE",correctNull(rs.getString("DDR_AGR_NOCOBTDATE")));
				hshValues.put("DD_STAT_VERIFIED_FROM",correctNull(rs.getString("DDR_AGR_PACSVERI_FROM")));
				hshValues.put("DD_STAT_VERIFIED_TO",correctNull(rs.getString("DDR_AGR_PACSVERI_TO")));
				hshValues.put("DD_STAT_ACC",correctNull(rs.getString("DDR_AGR_ACCSTATUS")));
				hshValues.put("DD_FNO60DETAILS",correctNull(rs.getString("DDR_AGR_FNO60_OBT")));
				hshValues.put("DD_FNO60OBTAINEDON",correctNull(rs.getString("DDR_AGR_FNO60_DATE")));
				
				hshValues.put("DD_SALES_TURNOVER",correctNull(rs.getString("DDR_SALEMP_SALESTUENOVER")));
				hshValues.put("DD_SALES_PROFIT",correctNull(rs.getString("DDR_SALEMP_PROFIT")));
				hshValues.put("DD_SAL_CREDITED_BANK_CODE",correctNull(rs.getString("DDR_SALEMP_BANKNAME")));
				if(!correctNull(rs.getString("DDR_SALEMP_BANKNAME")).equals(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+Helper.correctInt((String)rs.getString("DDR_SALEMP_BANKNAME")));
					if(rs1.next())
					{
						hshValues.put("DD_SAL_CREDITED_BANK_NAME",correctNull(rs1.getString("STAT_DATA_DESC1")));
					}
				}
				hshValues.put("DD_SAL_CREDITED_BRANCH_NAME",correctNull(rs.getString("DDR_SALEMP_BRANCHNAME")));
				hshValues.put("DD_SAL_CREDITED_ACC_NUM",correctNull(rs.getString("DDR_SALEMP_ACCOUNTNUM")));
				hshValues.put("DD_DETAILSOFINSTALLMENT",correctNull(rs.getString("DDR_SALEMP_INTSERV_ACC")));
				hshValues.put("DD_INSTITUTION_PERM_RFNO",correctNull(rs.getString("DDR_SALEMP_PERMSN_REFNO")));
				hshValues.put("DD_SAL_BANK_ACC",correctNull(rs.getString("DDR_SALEMP_SAL_BANKACC")));
				hshValues.put("DD_REASONFORSALARYVARIATION",correctNull(rs.getString("DDR_SALEMP_RSN_VARIATION")));
				hshValues.put("DDR_SALEMP_EMPCONT_DATE",correctNull(rs.getString("DDR_SALEMP_EMPCONT_DATE")));
				hshValues.put("DDR_SALEMP_EMPCONT_NAME",correctNull(rs.getString("DDR_SALEMP_EMPCONT_NAME")));
				hshValues.put("DDR_SALEMP_EMPCONT_DESIGN",correctNull(rs.getString("DDR_SALEMP_EMPCONT_DESIGN")));
				hshValues.put("DDR_SALEMP_EMPCONT_NUM",correctNull(rs.getString("DDR_SALEMP_EMPCONT_NUM")));

				hshValues.put("DD_SF_BRANCHNEARBYCODE",correctNull(rs.getString("DDR_SELFEMP_NEARBRANCH")));
				if(!correctNull(rs.getString("DDR_SELFEMP_NEARBRANCH")).equals(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selectorgname^"+Helper.correctInt((String)rs.getString("DDR_SELFEMP_NEARBRANCH")));
					if(rs1.next())
					{
						hshValues.put("DD_SF_BRANCHNEARBYNAME",correctNull(rs1.getString("org_name")));
					}
				}
				hshValues.put("DD_CARRYINGACTIVITYIN",correctNull(rs.getString("DDR_SELFEMP_APPACTIVITY")));
				hshValues.put("DD_BUSINESSADDRESS",correctNull(rs.getString("DDR_SELFEMP_ADDRESS")));
				hshValues.put("DD_DATE_VISIT_OFC",correctNull(rs.getString("DDR_SELFEMP_VISITDATE")));
				hshValues.put("DDR_LISTEDEMPLOYER",correctNull(rs.getString("DDR_LISTEDEMPLOYER")));
				hshValues.put("DDR_STOCKEXCHANGENAME",correctNull(rs.getString("DDR_STOCKEXCHANGENAME")));
				hshValues.put("DDR_VERIFIED_BY",correctNull(rs.getString("DDR_VERIFIED_BY")));
				if(!Helper.correctNull(rs.getString("DDR_VERIFIED_BY")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("DDR_VERIFIED_BY")));
					if(rs1.next())
					{
						hshValues.put("DDR_verified_name",Helper.correctNull(rs1.getString("name")));	
					}
				}
				hshValues.put("DDR_VERIFIED_DATE",correctNull(rs.getString("DDR_VERIFIED_DATE")));
				
				
				
				
				
				
			}
			if(newflag==false)
			{
				String strCBSID="";
				if(!hidDemoId.equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					
					strQuery=SQLParser.getSqlQuery("findBorrowerOrgCom^"+hidDemoId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strCBSID=Helper.correctNull(rs.getString("perapp_cbsid"));
					}
				}
				if(rs!=null)
					rs.close();
				
				if(!strCBSID.equalsIgnoreCase(""))
				{
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strCBSID);
						rs=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strCBSID);
						rs=DBUtils.executeQuery(strQuery); 
					}
					if(rs.next())
					{
						hshValues.put("passportNum", correctNull((String)rs.getString("psprt_num")));
						hshValues.put("passportdate", correctNull((String)rs.getString("psprt_issu_date")));
						if(Helper.correctNull((String)rs.getString("ID_DOC")).equals("3"))
						{
							hshValues.put("drivinglicNum", correctNull((String)rs.getString("id_number")));
						}
					}
				}
			}
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_customerdetail^"+strDemoID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strArr[]=Helper.correctNull(rs.getString("CON_YEARS")).split("~");
				if(strArr!=null && strArr.length>1)
				hshValues.put("CON_YEARS", strArr[0]);
			}
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("mastgetdemographics^"+strNewId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("perapp_panno", correctNull((String)rs.getString("perapp_panno")));
				hshValues.put("perapp_employment", correctNull((String)rs.getString("perapp_employment")));

			}
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_serviceleft^"+strNewId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("PEREMP_SALARYROUTED", correctNull((String)rs.getString("PEREMP_SALARYROUTED")));

			}
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_due_diligence_reportnew^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(!rs.next())
			{
				if(rs1!=null)
					rs1.close();
				
				strQuery = SQLParser.getSqlQuery("sel_previousDDReport^"+appno+"^"+appno+"^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strDDRRecordFlag", "N");
				}
			}
			
			
			
			
			hshValues.put("DemoId", hidDemoId);
			
		}
		catch (Exception e) {
			throw new EJBException("Exception caught in getdueReport Method ===" + e.getMessage());
		}
		
		return hshValues;
	}
	public void updatedueReport(HashMap hshValues) 
	{
		ResultSet rs = null,rs1=null;
		String strQuery = "";
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();	
		ArrayList arrValues = new ArrayList();
		String strFlag = Helper.correctNull((String) hshValues.get("hidAction"));
		String strAppno = Helper.correctNull((String) hshValues.get("appno"));
		String strDemoID = Helper.correctNull((String) hshValues.get("hidDemoId"));
		String sessionModuleType= Helper.correctInt((String) hshValues.get("sessionModuleType"));
		try
		{
			if(strFlag.equalsIgnoreCase("I"))
			{
		
			String passportdet=Helper.correctNull((String) hshValues.get("txt_passport_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_passport_expdate"))+" @ "+ Helper.correctNull((String) hshValues.get("txt_passport_place"));
			String DrivingLicdet=Helper.correctNull((String) hshValues.get("txt_DL_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_DL_expdate"))+" @ "+Helper.correctNull((String) hshValues.get("txt_DL_place"));
			String electiondet=Helper.correctNull((String) hshValues.get("txt_ElectionCard_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_ElectionCard_expdate"))+" @ "+Helper.correctNull((String) hshValues.get("txt_ElectionCard_place"));
			String otherDoc1det=Helper.correctNull((String) hshValues.get("txt_otherdoc1_name"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc1_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc1_expdate"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc1_place"));
			String otherDoc2det=Helper.correctNull((String) hshValues.get("txt_otherdoc2_name"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc2_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc2_expdate"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc2_place"));
			String otherDoc3det=Helper.correctNull((String) hshValues.get("txt_otherdoc3_name"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc3_number"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc3_expdate"))+" @ "+Helper.correctNull((String) hshValues.get("txt_otherDoc3_place"));
			
			String bankname="", bank_address="",txt_prebankSince="",txt_accverified_From="",txt_accverified_to="",txt_noofcheques="",txt_maxBalance="",txt_minBalance="";
			String txt_TotCredit_turnover="", txt_difin_sales="",reason_for_variations="",sel_wht_confiReportObt="",txt_confiRepObt_date="",reason_ConfRepObt="";
			
			if(hshValues.get("txt_Bank") instanceof String[])
			{
				String[] strbankname=(String[]) hshValues.get("hid_LeadBank");
				String[] bankaddress=(String[]) hshValues.get("bank_address");
				String[] txtprebankSince=(String[]) hshValues.get("txt_prebankSince");
				String[] txt_accverifiedfrom=(String[]) hshValues.get("txt_accverified_From");
				String[] txt_accverifiedto=(String[]) hshValues.get("txt_accverified_to");
				String[] noofcheques=(String[]) hshValues.get("txt_noofcheques");
				String[] maxBalance=(String[]) hshValues.get("txt_maxBalance");
				String[] minBalance=(String[]) hshValues.get("txt_minBalance");
				String[] TotCredit_turnover=(String[]) hshValues.get("txt_TotCredit_turnover");
				String[] difin_sales=(String[]) hshValues.get("txt_difin_sales");
				String[] reasonforvariations=(String[]) hshValues.get("reason_for_variations");
				String[] wht_confiReportObt=(String[]) hshValues.get("sel_wht_confiReportObt");
				String[] confiRepObt_date=(String[]) hshValues.get("txt_confiRepObt_date");
				String[] reasonConfRepObt=(String[]) hshValues.get("reason_ConfRepObt");
	
				for(int i=0;i<strbankname.length;i++)
				{
					bankname=bankname+"@"+strbankname[i];
					bank_address=bank_address+"@"+bankaddress[i];
					txt_prebankSince=txt_prebankSince+"@"+txtprebankSince[i];
					txt_accverified_From=txt_accverified_From+"@"+txt_accverifiedfrom[i];
					txt_accverified_to=txt_accverified_to+"@"+txt_accverifiedto[i];
					txt_noofcheques=txt_noofcheques+"@"+noofcheques[i];
					txt_maxBalance=txt_maxBalance+"@"+maxBalance[i];
					txt_minBalance=txt_minBalance+"@"+minBalance[i];
					txt_TotCredit_turnover=txt_TotCredit_turnover+"@"+TotCredit_turnover[i];
					txt_difin_sales=txt_difin_sales+"@"+difin_sales[i];
					reason_for_variations=reason_for_variations+"@"+reasonforvariations[i];
					sel_wht_confiReportObt=sel_wht_confiReportObt+"@"+wht_confiReportObt[i];
					txt_confiRepObt_date=txt_confiRepObt_date+"@"+confiRepObt_date[i];
					reason_ConfRepObt=reason_ConfRepObt+"@"+reasonConfRepObt[i];
				}
				
				bankname=bankname.replaceFirst("@", "");
				bank_address=bank_address.replaceFirst("@", "");
				txt_prebankSince=txt_prebankSince.replaceFirst("@", "");
				txt_accverified_From=txt_accverified_From.replaceFirst("@", "");
				txt_accverified_to=txt_accverified_to.replaceFirst("@", "");
				txt_noofcheques=txt_noofcheques.replaceFirst("@", "");
				txt_maxBalance=txt_maxBalance.replaceFirst("@", "");
				txt_minBalance=txt_minBalance.replaceFirst("@", "");
				txt_TotCredit_turnover=txt_TotCredit_turnover.replaceFirst("@", "");
				txt_difin_sales=txt_difin_sales.replaceFirst("@", "");
				reason_for_variations=reason_for_variations.replaceFirst("@", "");
				sel_wht_confiReportObt=sel_wht_confiReportObt.replaceFirst("@", "");
				txt_confiRepObt_date=txt_confiRepObt_date.replaceFirst("@", "");
				reason_ConfRepObt=reason_ConfRepObt.replaceFirst("@", "");
			}
			else
			{
				bankname=Helper.correctNull((String) hshValues.get("hid_LeadBank"));
				bank_address=Helper.correctNull((String) hshValues.get("bank_address"));
				txt_prebankSince=Helper.correctNull((String) hshValues.get("txt_prebankSince"));
				txt_accverified_From=Helper.correctNull((String) hshValues.get("txt_accverified_From"));
				txt_accverified_to=Helper.correctNull((String) hshValues.get("txt_accverified_to"));
				txt_noofcheques=Helper.correctNull((String) hshValues.get("txt_noofcheques"));
				txt_maxBalance=Helper.correctNull((String) hshValues.get("txt_maxBalance"));
				txt_minBalance=Helper.correctNull((String) hshValues.get("txt_minBalance"));
				txt_TotCredit_turnover=Helper.correctNull((String) hshValues.get("txt_TotCredit_turnover"));
				txt_difin_sales=Helper.correctNull((String) hshValues.get("txt_difin_sales"));
				reason_for_variations=Helper.correctNull((String) hshValues.get("reason_for_variations"));
				sel_wht_confiReportObt=Helper.correctNull((String) hshValues.get("sel_wht_confiReportObt"));
				txt_confiRepObt_date=Helper.correctNull((String) hshValues.get("txt_confiRepObt_date"));
				reason_ConfRepObt=Helper.correctNull((String) hshValues.get("reason_ConfRepObt"));
			}

			
			
				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strDemoID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery.put("strQueryId","due_report_del");	

				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strDemoID);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_since_bank")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_cond_acc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_rep_stat")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_self_intro")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_phyinsp")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_phyinsp_Userid")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_phyinsp_username")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_phyinsp_design")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_Phy_no")));
				arrValues.add(passportdet);
				arrValues.add(DrivingLicdet);
				arrValues.add(electiondet);
				arrValues.add(otherDoc1det);
				arrValues.add(otherDoc2det);
				arrValues.add(otherDoc3det);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_app_residing")));
				arrValues.add(Helper.correctNull((String) hshValues.get("hid_LoanDisbBranch")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_staffid")));
				arrValues.add(bankname);
				arrValues.add(bank_address);
				arrValues.add(txt_prebankSince);
				arrValues.add(txt_accverified_From);
				arrValues.add(txt_accverified_to);
				arrValues.add(txt_noofcheques);
				arrValues.add(txt_maxBalance);
				arrValues.add(txt_minBalance);
				arrValues.add(txt_TotCredit_turnover);
				arrValues.add(txt_difin_sales);
				arrValues.add(reason_for_variations);
				arrValues.add(sel_wht_confiReportObt);
				arrValues.add(txt_confiRepObt_date);
				arrValues.add(reason_ConfRepObt);
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_farm_visit")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_extend_land")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_stand_crops")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_crops_grown")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_liab_pacs")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_noc_pacs")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_pacsvari_from")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_pacsvari_to")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_status_acc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_fno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_sel_fno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_empsal_turnover")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_empsal_profit")));
				arrValues.add(Helper.correctNull((String) hshValues.get("hid_LeadBankcode")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_salbrnch_name")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_salacc_num")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_inst_laonacc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_refno_credit")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_sal_bankstat")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_vari_salslip_bankacc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_empContacted_Date")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_contact_person")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_contact_persondesign")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_contact_number")));
				arrValues.add(Helper.correctNull((String) hshValues.get("hid_LoanDisbBranch1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_appnt_act")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_addr_place")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_visit_unit")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_stocexchange")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_exchange")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_convertedid")));
				arrValues.add(Helper.correctNull((String) hshValues.get("ddrverifidate")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQuery.put("strQueryId","due_report_ins");
				hshQueryValues.put("size", "2");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}	
		else if(strFlag.equalsIgnoreCase("D"))
		{
			arrValues.add(strAppno);
			arrValues.add(strDemoID);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQuery.put("strQueryId","due_report_del");
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
			
		}
		else if(strFlag.equalsIgnoreCase("C"))
		{
			if(rs!=null)
			rs.close();
			int intSize=0;
			if(sessionModuleType.equalsIgnoreCase("RET"))
			{
				strQuery=SQLParser.getSqlQuery("sel_JointApplicants^"+strAppno+"^a','c','g','o");
				rs=DBUtils.executeQuery(strQuery);
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("sel_corpagriappid^"+strAppno+"^"+strAppno);
			}
			while(rs.next())
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_ddrcopy^"+Helper.correctNull(rs.getString("demo_oldappid")));
				if(rs1.next())
				{
					++intSize;
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull(rs.getString("demo_oldappid")));
					arrValues.add(Helper.correctNull(rs1.getString("DUEDILIG_APPID")));
					arrValues.add(Helper.correctNull(rs1.getString("DUEDILIG_APPNO")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					hshQuery.put("strQueryId","ins_ddrcopy");
					hshQueryValues.put("size", String.valueOf(intSize));
					
				}
				
			}
			
			if(intSize>0)
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
			
		}
		catch (Exception e) {
			throw new EJBException("Exception caught in "+e.getMessage());
		}

}

	public HashMap getdueReportprint(HashMap hshValues) 
	{
		String strQuery =null;
		ResultSet rs2 = null,rs1=null,rs=null,rs3=null;
		String phyinsp="",partship="",trust="",fno="",deal="",appnt="",appbank="",strrestype="",DD_Strsatis="",Strperapp_id="";
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		//nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		String sessionModuleType="";//Helper.correctNull((String) hshValues.get("sessionModuleType"));

		try
		{
			//if(sessionModuleType.equalsIgnoreCase(""))
				sessionModuleType= Helper.correctNull((String) hshValues.get("StrModule"));
				
			ArrayList arrcol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			if(sessionModuleType.equals("RET"))
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC^"+ appno);
			
			else
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC_corp^"+ appno+"^"+appno+"^"+appno);
			
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrcol = new ArrayList();
				arrcol.add(correctNull(rs.getString("PERAPP_FNAME"))); //1
				if(correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
				{
					arrcol.add(correctNull(rs.getString("CON_COMADDR1")));//2
					arrcol.add(correctNull(rs.getString("CON_COMADDR2")));//3
					arrcol.add(correctNull(rs.getString("CON_CITY")));//4
					arrcol.add(correctNull(rs.getString("CON_STATE")));//5
					arrcol.add(correctNull(rs.getString("CON_COMPHONE")));//6
					arrcol.add(correctNull(rs.getString("CON_EMAIL")));//7
					arrcol.add(correctNull(rs.getString("CON_MOBILE")));//8
				}
				else
				{
					arrcol.add(correctNull(rs.getString("CON_PERMADDR1")));//2
					arrcol.add(correctNull(rs.getString("CON_PERMADDR2")));//3
					arrcol.add(correctNull(rs.getString("perm_city")));//4
					arrcol.add(correctNull(rs.getString("PERM_STATE")));//5
					arrcol.add(correctNull(rs.getString("CON_PERMPHONE")));//6
					arrcol.add(correctNull(rs.getString("CON_PEREMAIL")));//7
					arrcol.add(correctNull(rs.getString("CON_MOBILE")));//8
				}
				arrcol.add(correctNull(rs.getString("AS_PERAPP_CONSTITUTION")));//9
				arrcol.add(correctNull(rs.getString("perapp_cbsid")));//10
				arrcol.add(correctNull(rs.getString("CIBIL_SCORE")));//11
				arrcol.add(correctNull(rs.getString("PERAPP_AADHAAR")));//12
				arrcol.add(correctNull(rs.getString("PERAPP_PANNO")));//13
				arrcol.add(correctNull(rs.getString("demo_type")));//14
				arrcol.add(correctNull(rs.getString("PERAPP_BANKSINCE")));//15
				if((correctNull(rs.getString("PERAPP_SATISFACTORY")).trim()).equalsIgnoreCase("Y"))
				{				
					arrcol.add(" - SATISFACTORY");//16
				}
				else if((correctNull(rs.getString("PERAPP_SATISFACTORY")).trim()).equalsIgnoreCase("N"))
				{
					arrcol.add(" - UNSATISFACTORY <br>"+Helper.correctNull(Helper.CLOBToString((rs.getClob("PERAPP_JUST_DETAILS"))))+"");//16
				}
				else
				{
					arrcol.add("");
				}
				arrcol.add(correctNull(rs.getString("PERAPP_INTRONAME")));//17
				arrcol.add(correctNull(rs.getString("DDR_BANKWITHUS")));//18
				arrcol.add(correctNull(rs.getString("DDR_ACC_CONDUCT")));//19
				arrcol.add(correctNull(rs.getString("DDR_REPUT_INTRODUCER")));//20
				arrcol.add(correctNull(rs.getString("DDR_SELFINTRO_DOC")));//21
				if(correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("2"))
					arrcol.add(correctNull(rs.getString("PERAPP_INTROCBSID")));//22
				else if(correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("1"))
					arrcol.add(correctNull(rs.getString("PERAPP_INTROSTAFFID")));//22
				else
					arrcol.add("");//22

				
				
				arrRow.add(arrcol);
			}
			hshValues.put("arrKYCDet", arrRow);
			
			
			ArrayList arrcol2 = new ArrayList();
			ArrayList arrRow2 = new ArrayList();
			if(sessionModuleType.equals("RET"))
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC^"+ appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC_corp^"+ appno+"^"+appno+"^"+appno);
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrcol2 = new ArrayList();
				arrcol2.add(correctNull(rs.getString("PERAPP_FNAME"))); //0
				arrcol2.add(correctNull(rs.getString("demo_type")));//1
				arrcol2.add(correctNull(rs.getString("DDR_WHT_PHYINSP")));//2
				arrcol2.add(correctNull(rs.getString("DDR_PHYINSP_USERID")));//3
				arrcol2.add(correctNull(rs.getString("DDR_PHYINSP_USERNAME")));//4
				arrcol2.add(correctNull(rs.getString("DDR_PHYINSP_USERDESIG")));//5
				arrcol2.add(correctNull(rs.getString("DDR_PHYINSP_REASON")));//6
				arrcol2.add(correctNull(rs.getString("DDR_PASSPORT_DET")));//7
				arrcol2.add(correctNull(rs.getString("DDR_DRIVINGLICENCE_DET")));//8
				arrcol2.add(correctNull(rs.getString("DDR_ELECTIONCARD_DET")));//9
				arrcol2.add(correctNull(rs.getString("DDR_OTHERDOC1_DET")));//10
				arrcol2.add(correctNull(rs.getString("DDR_OTHERDOC2_DET")));//11
				arrcol2.add(correctNull(rs.getString("DDR_OTHERDOC3_DET")));//12
				if(correctNull(rs.getString("CON_RESTYPE")).equalsIgnoreCase("1"))
				{
					strrestype="Rented";
				}
				else if(correctNull(rs.getString("CON_RESTYPE")).equalsIgnoreCase("2"))
				{
					strrestype="Owned";
				}
				else if(correctNull(rs.getString("CON_RESTYPE")).equalsIgnoreCase("3"))
				{
					strrestype="Leased";
				}
				else if(correctNull(rs.getString("CON_RESTYPE")).equalsIgnoreCase("4"))
				{
					strrestype="Family";					
				}
				else if(correctNull(rs.getString("CON_RESTYPE")).equalsIgnoreCase("5"))
				{
					strrestype="Employer";
				}
				else
				{
					strrestype="";
				}
				arrcol2.add(strrestype); //13
				String strArr[]=Helper.correctNull(rs.getString("CON_YEARS")).split("~");
				if(strArr!=null && strArr.length>1)
					arrcol2.add(strArr[0]);
				else
					arrcol2.add("0");//14
				arrcol2.add(correctNull(rs.getString("DDR_APPRESIDENCE")));//15
				if(!correctNull(rs.getString("DDR_APP_NEARBRANCH")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
					rs1.close();
					rs1=DBUtils.executeLAPSQuery("selectorgname^"+Helper.correctInt(rs.getString("DDR_APP_NEARBRANCH")));
					if(rs1.next())
					{
						arrcol2.add(correctNull(rs1.getString("org_name")));//16
					}
					else
					{
						arrcol2.add("");
					}
				}
				else
				{
					arrcol2.add(""); //16
				}
				
				if(!correctNull(rs.getString("KYC_RESIPROOFTYPE")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
					rs1.close();
					rs1=DBUtils.executeLAPSQuery("getstaticdata_soldid^55^"+Helper.correctInt(rs.getString("KYC_RESIPROOFTYPE")));
					if(rs1.next())
					{
						arrcol2.add(correctNull(rs1.getString("stat_data_desc1")));//16
					}
					else
					{
						arrcol2.add("");
					}
				}
				else
				{
					arrcol2.add("");
				}
				arrcol2.add(correctNull(rs.getString("KYC_DOC_DATE")));//18
				if(!correctNull(rs.getString("DDR_KYC_COMPLIEDBY")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selusername^"+correctNull(rs.getString("DDR_KYC_COMPLIEDBY")));
					if(rs1.next())
					{
						arrcol2.add(correctNull(rs1.getString("usr_fname"))+" - "+correctNull(rs.getString("DDR_KYC_COMPLIEDBY")));//19
					}
					else
					{
						arrcol2.add("");
					}
				}
				else
				{
					arrcol2.add(""); //19
				}
				
				String tempbankcode=correctNull(rs.getString("DDR_PRESBANK_NAME"));
				String tempbankname="";
				if(!tempbankcode.equals(""))
				{
					if(tempbankcode.contains("@"))
					{
						String[] temp=tempbankcode.split("@");
						for(int i=0;i<temp.length;i++)
						{
							if(rs1!=null)
								rs1.close();
							rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+temp[i]);
							if(rs1.next())
							{
								tempbankname=tempbankname+Helper.correctNull(rs1.getString("STAT_DATA_DESC1"))+"@";
							}
						}
					}
					else
					{
						if(rs1!=null)
							rs1.close();
						rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+tempbankcode);
						if(rs1.next())
						{
							tempbankname=Helper.correctNull(rs1.getString("STAT_DATA_DESC1"));
						}
					}
				}
				arrcol2.add(tempbankname); //20
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_ADDRESS")));//21
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_BANKSINCE")));//22
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_ACCVER_FROM")));//23
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_ACCVER_TO")));//24
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_CHEQUERETURN")));//25
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_MAXBAL")));//26
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_MINBAL")));//27
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_TOTCTO")));//28
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_DIFINSALES")));//29
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_VARIATIONRSN")));//30
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_WHT_CONFREPOBT")));//31
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_CONFREPDATE")));//32
				arrcol2.add(correctNull(rs.getString("DDR_PRESBANK_RSN_CONFREPOBT")));//33

				arrRow2.add(arrcol2);
			}
			hshValues.put("arrVerifiDet", arrRow2);

			
			

			ArrayList arrcol3 = new ArrayList();
			ArrayList arrRow3 = new ArrayList();
			if(sessionModuleType.equals("RET"))
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC^"+ appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC_corp^"+ appno+"^"+appno+"^"+appno);
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrcol3 = new ArrayList();
				arrcol3.add(correctNull(rs.getString("PERAPP_FNAME"))); //0
				arrcol3.add(correctNull(rs.getString("demo_type")));//1
				arrcol3.add(correctNull(rs.getString("PERAPP_PARTNERSHIP_DET"))); //2
				arrcol3.add(correctNull(rs.getString("PERAPP_PARTNERSHIP_DEEDDATE"))); //3

				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selborrowerdet_company^"+correctNull(rs.getString("perapp_id")));
				if(rs1.next())
				{
					arrcol3.add(correctNull(rs1.getString("cominfo_cin"))); //4
				}
				else
				{
					arrcol3.add(""); //4
				}
				
				arrcol3.add(correctNull(rs.getString("PERAPP_COM_SEARCHREPDATE"))); //5
				arrcol3.add(correctNull(rs.getString("PERAPP_COM_AUTHCAPTAL"))); //6
				arrcol3.add(correctNull(rs.getString("PERAPP_COM_PAIDUPCAP"))); //7
				arrcol3.add(correctNull(rs.getString("PERAPP_COM_MOAVERIFIED"))); //8
				arrcol3.add(correctNull(rs.getString("PERAPP_COM_AMENDEDMOA"))); //9
				String temp="";
				int i=1;
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_comapp_Divisions_directors^"+correctNull(rs.getString("perapp_id")));
				while(rs1.next())
				{
					temp=temp+i+". "+correctNull(rs1.getString("COMAPP_DIV_NAME"))+" <br> DIN Number: "+ correctNull(rs1.getString("COMAPP_DINNUMBER"))+"<br>"; 
					i++;
				}
				arrcol3.add(temp); //10
				
				arrcol3.add(correctNull(rs.getString("PERAPP_TRUST_DEEDDATE"))); //11
				arrcol3.add(correctNull(rs.getString("PERAPP_TRUST_REGTYPE"))); //12
				arrcol3.add(correctNull(rs.getString("PERAPP_TRUST_PERMREFNO"))); //13
				
				
				ArrayList temp1=new ArrayList();
				ArrayList temp2=new ArrayList();
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_kartaname^"+correctNull(rs.getString("perapp_id"))+"^K^001");
				while(rs1.next())
				{
					temp1=new ArrayList();
					temp1.add(correctNull(rs1.getString("name"))); 
					temp1.add(correctNull(rs1.getString("PERAPP_ID"))); 
					temp1.add(correctNull(rs1.getString("PERAPP_PANNO")));
					temp1.add(correctNull(rs1.getString("PERAPP_AADHAAR")));
					temp2.add(temp1);
				}
				arrcol3.add(temp2); //14
				
				ArrayList temp3=new ArrayList();
				ArrayList temp4=new ArrayList();
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_kartaname^"+correctNull(rs.getString("perapp_id"))+"^K^002");
				while(rs1.next())
				{
					temp3=new ArrayList();
					temp3.add(correctNull(rs1.getString("name"))); 
					temp3.add(correctNull(rs1.getString("PERAPP_ID"))); 
					temp3.add(correctNull(rs1.getString("PERAPP_PANNO")));
					temp3.add(correctNull(rs1.getString("PERAPP_AADHAAR")));
					temp4.add(temp3);
				}
				arrcol3.add(temp4); //15
				
				arrcol3.add(correctNull(rs.getString("PERINC_CAPITALGAIN"))); //16
				arrcol3.add(correctNull(rs.getString("PERINC_OTHERS"))); //17
				arrcol3.add(correctNull(rs.getString("PERINC_PROFITBUSINESS1"))); //18
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_incproof^"+correctNull(rs.getString("PERINC_INC_SUPPORTDOC")));
				if(rs1.next())
					arrcol3.add(correctNull(rs1.getString("STAT_DATA_DESC1"))); //19
				else
					arrcol3.add("");//19
				
				arrcol3.add(correctNull(rs.getString("perinc_yearsalary"))); //20
				
				arrcol3.add(correctNull(rs.getString("DDR_AGR_FARMVISITDATE"))); //21
				arrcol3.add(correctNull(rs.getString("DDR_AGR_LANDEXTEND"))); //22
				arrcol3.add(correctNull(rs.getString("DDR_AGR_STANDINGCROPS"))); //23
				arrcol3.add(correctNull(rs.getString("DDR_AGR_CROPGROWN"))); //24
				arrcol3.add(correctNull(rs.getString("DDR_AGR_LIAB_PACS"))); //25
				arrcol3.add(correctNull(rs.getString("DDR_AGR_NOCOBTDATE"))); //26
				arrcol3.add(correctNull(rs.getString("DDR_AGR_PACSVERI_FROM"))); //27
				arrcol3.add(correctNull(rs.getString("DDR_AGR_PACSVERI_TO"))); //28
				arrcol3.add(correctNull(rs.getString("DDR_AGR_ACCSTATUS"))); //29
				arrcol3.add(correctNull(rs.getString("DDR_AGR_FNO60_OBT"))); //30
				arrcol3.add(correctNull(rs.getString("DDR_AGR_FNO60_DATE"))); //31
				arrcol3.add(correctNull(rs.getString("PERAPP_PANNO"))); //32

				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^2^"+Helper.correctInt(rs.getString("perapp_constitutionnew")));
				if(rs1.next())
				{
					arrcol3.add(Helper.correctNull(rs1.getString("cbs_static_sanc_refno")));//33
				}
				else
				{
					arrcol3.add("");	//33
				}
				
				arrcol3.add(correctNull(rs.getString("PERAPP_EMPLOYMENT"))); //34
				
				strQuery= SQLParser.getSqlQuery("sel_com_assetcharg^"+Helper.correctNull(rs.getString("perapp_id")));
				ArrayList arrAssetDet = new ArrayList();
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					ArrayList arrcol4 = new ArrayList();
					arrcol4.add(correctNull(rs1.getString("COM_ASSET_NAME")));//1
					arrcol4.add(correctNull(rs1.getString("COM_CHARG_HOLDER")));//2
					arrcol4.add(correctNull(rs1.getString("COM_CHARG_DATE")));//3
					arrAssetDet.add(arrcol4);			
				}
				
				arrcol3.add(arrAssetDet);//35
				arrcol3.add(correctNull(rs.getString("PERAPP_PARTNERSHIP_REGNO")));//36
				
				arrRow3.add(arrcol3);
			}
			hshValues.put("arrConstDet", arrRow3);
			
			
			arrRow3 = new ArrayList();
			if(sessionModuleType.equals("RET"))
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC^"+ appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_ddr_report_KYC_corp^"+ appno+"^"+appno+"^"+appno);
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strEmpDesignation="",strCommencementYr="";
				arrcol3 = new ArrayList();
				arrcol3.add(correctNull(rs.getString("PERAPP_FNAME"))); //0
				arrcol3.add(correctNull(rs.getString("demo_type")));//1
			

				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("sel_employeraddress^"+correctNull(rs.getString("perapp_id")));
				if(rs1.next())
				{
					arrcol3.add(correctNull(rs1.getString("PEREMP_NAME")));//2
					arrcol3.add(correctNull(rs1.getString("PEREMP_ADDRESS1"))+", "+correctNull(rs1.getString("PEREMP_ADDRESS2"))+", "+correctNull(rs1.getString("PEREMP_ADDRESS3")));//3
					arrcol3.add(correctNull(rs1.getString("peremp_city")));//4
					arrcol3.add(correctNull(rs1.getString("peremp_state")));//5
					arrcol3.add(correctNull(rs1.getString("peremp_phone")));//6
					arrcol3.add(correctNull(rs1.getString("PEREMP_EMAIL")));//7
					strEmpDesignation=correctNull(rs1.getString("peremp_design"));
					strCommencementYr=correctNull(rs1.getString("commencementyr"));
				}
				else
				{
					arrcol3.add(""); 
					arrcol3.add("");
					arrcol3.add("");
					arrcol3.add("");
					arrcol3.add("");
					arrcol3.add("");
				}
				
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_SALESTUENOVER")));//8			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_PROFIT")));//9
				
				if(!correctNull(rs.getString("DDR_SALEMP_BANKNAME")).equals(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+Helper.correctInt(rs.getString("DDR_SALEMP_BANKNAME")));
					if(rs1.next())
					{
						arrcol3.add(correctNull(rs1.getString("STAT_DATA_DESC1")));//10
					}
					else
					{
						arrcol3.add("");
					}
				}
				else
				{
					arrcol3.add("");
				}
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_BRANCHNAME")));//11			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_ACCOUNTNUM")));//1	2		
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_INTSERV_ACC")));//13			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_PERMSN_REFNO")));//14			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_SAL_BANKACC")));//15			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_RSN_VARIATION")));//16			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_EMPCONT_DATE")));//17			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_EMPCONT_NAME")));//18			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_EMPCONT_DESIGN")));//19			
				arrcol3.add(correctNull(rs.getString("DDR_SALEMP_EMPCONT_NUM")));//20
				
				if(!correctNull(rs.getString("DDR_SELFEMP_NEARBRANCH")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selectorgappl^"+correctNull(rs.getString("DDR_SELFEMP_NEARBRANCH")));
					if(rs1.next())
					{
						arrcol3.add(correctNull(rs1.getString("org_name")));//21
					}
					else
					{
						arrcol3.add("");//21
					}
				}
				else
				{
					arrcol3.add("");//21
				}
				arrcol3.add(correctNull(rs.getString("DDR_SELFEMP_APPACTIVITY")));//22			
				arrcol3.add(correctNull(rs.getString("DDR_SELFEMP_ADDRESS")));//23
				arrcol3.add(correctNull(rs.getString("PERAPP_EMPLOYMENT"))); //24
				arrcol3.add(correctNull(rs.getString("DDR_SELFEMP_VISITDATE")));//25
				arrcol3.add(strEmpDesignation);//26
				arrcol3.add(strCommencementYr);//27
				arrcol3.add(correctNull(rs.getString("PERINC_MONSALARY")));//28
				arrcol3.add(correctNull(rs.getString("DDR_LISTEDEMPLOYER")));//29
				arrcol3.add(correctNull(rs.getString("DDR_STOCKEXCHANGENAME")));//30
				arrRow3.add(arrcol3);
			}
			hshValues.put("arrEmpDet", arrRow3);
			
			
			//General Info
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_ddr_generalinfo^"+ appno);
			if(rs.next())
			{
				hshValues.put("strMarketReport",Helper.correctNull(rs.getString("ddr_marketreport")));
				hshValues.put("strEnquiremadewith",Helper.correctNull(rs.getString("ddr_enquiredwith")));
				hshValues.put("strContactno",Helper.correctNull(rs.getString("ddr_contactno")));
				hshValues.put("stropionionabtbor",Helper.correctNull(rs.getString("ddr_opinionabtbor")));
				hshValues.put("strDDRcontactedby",Helper.correctNull(rs.getString("ddr_contactedby")));
				
				if(!Helper.correctNull(rs.getString("ddr_contactedby")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("ddr_contactedby")));
					if(rs1.next())
					{
						hshValues.put("strDDRcontactedbyName",Helper.correctNull(rs1.getString("name")));	
						
						if(!Helper.correctNull(rs1.getString("user_designation")).equalsIgnoreCase(""))
						{
							if(rs2!=null)
								rs2.close();
							rs2=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^27^"+Helper.correctNull(rs1.getString("user_designation")));
							if(rs2.next())
							{
								hshValues.put("strDDRUserDesignation",Helper.correctNull(rs2.getString("CBS_STATIC_DATA_DESC")));	
							}
						}
						
					}
				}
			}
			
			
			if(rs2!=null)
				rs2.close();
			
			ArrayList arrVehDet=new ArrayList();
			ArrayList arrPropDet=new ArrayList();
			ArrayList arrCol=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_ddrsecdetails^"+appno);
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("securities_sel^"+Helper.correctNull(rs2.getString("sec_id")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
				String strArea="";
				arrCol=new ArrayList();
					if(Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("18"))
					{
						if(rs!=null)
							rs.close();
						
						strQuery = SQLParser.getSqlQuery("sel_security_vehicle^"+Helper.correctNull(rs2.getString("sec_id")));
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrCol.add(Helper.correctNull(rs.getString("sec_dealername")));//0
							arrCol.add(Helper.correctNull(rs.getString("sec_dealeraddress1"))+","+Helper.correctNull(rs.getString("sec_dealeraddress2")));//1
							
							if(!Helper.correctNull(rs.getString("sec_dealercity")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_dealercity")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("city_name")));//2
								else
									arrCol.add("");//2
							}
							else
							{
								arrCol.add("");//2
							}
							if(!Helper.correctNull(rs.getString("sec_dealercity")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_dealercity")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("city_name")));//3
								else
									arrCol.add("");//3
							}
							else
							{
								arrCol.add("");//3
							}
							if(!Helper.correctNull(rs.getString("sec_dealerstate")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("sec_dealerstate")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("state_name")));//4
								else
									arrCol.add("");//4
							}
							else
							{
								arrCol.add("");//4
							}
							if(!Helper.correctNull(rs.getString("sec_dealercountry")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("sec_dealercountry")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("con_country")));//5
								else
									arrCol.add("");//5
							}
							else
							{
								arrCol.add("");//5
							}
							arrCol.add(Helper.correctNull(rs.getString("sec_dealerpin")));//6
							arrCol.add(Helper.correctNull(rs.getString("sec_dealermail")));//7
							arrCol.add(Helper.correctNull(rs.getString("sec_dealercont")));//8
							arrCol.add(Helper.correctNull(rs.getString("sec_Dealercode")));//9
							arrCol.add(Helper.correctNull(rs.getString("sec_Dealertinno")));//10
							arrCol.add(Helper.correctNull(rs.getString("sec_regno")));//11
							arrCol.add(Helper.correctNull(rs.getString("sec_taxpaid")));//12
							arrCol.add(Helper.correctNull(rs.getString("sec_insvalid")));//13
							arrCol.add(Helper.correctNull(rs.getString("SEC_DOCS")));//14
						}
						else
						{
							arrCol.add("");//0
							arrCol.add("");//1
							arrCol.add("");//2
							arrCol.add("");//3
							arrCol.add("");//4
							arrCol.add("");//5
							arrCol.add("");//6
							arrCol.add("");//7
							arrCol.add("");//8
							arrCol.add("");//9
							arrCol.add("");//10
							arrCol.add("");//11
							arrCol.add("");//12
							arrCol.add("");//13
							arrCol.add("");//14
						}
					}
					else if(Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("19"))
					{
						if(rs!=null)
							rs.close();
						
						strQuery = SQLParser.getSqlQuery("sel_plantmachinery^"+Helper.correctNull(rs2.getString("sec_id")));
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrCol.add(Helper.correctNull(rs.getString("sec_dealername")));//0
							arrCol.add(Helper.correctNull(rs.getString("sec_dealeraddress1"))+","+Helper.correctNull(rs.getString("sec_dealeraddress2")));//1
							
							if(!Helper.correctNull(rs.getString("sec_dealerdistrict")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("sec_dealerdistrict")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("district_desc")));//2
								else
									arrCol.add("");//2
							}
							else
							{
								arrCol.add("");//2
							}
							if(!Helper.correctNull(rs.getString("sec_dealercity")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_dealercity")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("city_name")));//3
								else
									arrCol.add("");//3
							}
							else
							{
								arrCol.add("");//3
							}
							if(!Helper.correctNull(rs.getString("sec_dealerstate")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("sec_dealerstate")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("state_name")));//4
								else
									arrCol.add("");//4
							}
							else
							{
								arrCol.add("");//4
							}
							if(!Helper.correctNull(rs.getString("sec_dealercountry")).equalsIgnoreCase(""))
							{
								rs3=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("sec_dealercountry")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("con_country")));//5
								else
									arrCol.add("");//5
							}
							else
							{
								arrCol.add("");//5
							}
							arrCol.add(Helper.correctNull(rs.getString("sec_dealerpin")));//6
							arrCol.add(Helper.correctNull(rs.getString("sec_dealermail")));//7
							arrCol.add(Helper.correctNull(rs.getString("sec_dealercont")));//8
							arrCol.add(Helper.correctNull(rs.getString("sec_Dealercode")));//9
							arrCol.add(Helper.correctNull(rs.getString("sec_Dealertinno")));//10
							arrCol.add("");//11
							arrCol.add("");//12
							arrCol.add("");//13
							arrCol.add("");//14
						}
						else
						{
							arrCol.add("");//0
							arrCol.add("");//1
							arrCol.add("");//2
							arrCol.add("");//3
							arrCol.add("");//4
							arrCol.add("");//5
							arrCol.add("");//6
							arrCol.add("");//7
							arrCol.add("");//8
							arrCol.add("");//9
							arrCol.add("");//10
							arrCol.add("");//11
							arrCol.add("");//12
							arrCol.add("");//13
							arrCol.add("");//14
						}
					}
					else
					{
						
						arrCol.add(Helper.correctNull(rs1.getString("cus_sec_netsecurity")));//0
						arrCol.add(Helper.correctNull(rs1.getString("CUS_SEC_VALUATION_DATE")));//1
						
						if(rs3 !=null)
							rs3.close();
						rs3 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs1.getString("cus_sec_type")));
						if(rs3.next())
						{
							arrCol.add(correctNull(rs3.getString("sec_name")));//2
						}
						else
						{
							arrCol.add("");//21
						}
						
						if(rs3!=null)
							rs3.close();
						strQuery = SQLParser.getSqlQuery("sel_valmasater_name^"+Helper.correctInt(rs1.getString("CUS_SEC_VALUERCODE")));
						rs3 = DBUtils.executeQuery(strQuery);
						if(rs3.next())
						{
							arrCol.add(correctNull(rs3.getString("VALUERS_NAME")));//3
							arrCol.add(correctNull(rs3.getString("valuers_expdateofsanc")));//4
						}
						else
						{
							arrCol.add(correctNull(rs1.getString("CUS_SEC_Valuer_Name")));//3
							arrCol.add("");//4
						}
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("selseclegalopinion^"+Helper.correctNull(rs2.getString("sec_id")));
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{  	
							arrCol.add(correctNull(rs.getString("SEC_PL_LAWNAME")));//5
							arrCol.add(correctNull(rs.getString("SEC_PL_LEGOPDATE")));//6
							arrCol.add(correctNull(rs.getString("SEC_PL_SEARCHFROM_PROP")));//7
							arrCol.add(correctNull(rs.getString("sec_pl_legsubmitteddate")));//8
						}
						else
						{
							arrCol.add("");//4
							arrCol.add("");//5
							arrCol.add("");//6
							arrCol.add("");//7
						}
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("selsecpropdet^"+Helper.correctNull(rs2.getString("sec_id")));
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrCol.add(correctNull(rs.getString("SEC_PROPACQUISITION")));//9
							arrCol.add(correctNull(rs.getString("SEC_PROPACQUISITION_OTHERS")));//10
							arrCol.add(correctNull(rs.getString("sec_plotno")));//11
							arrCol.add(correctNull(rs.getString("sec_surveyno")));//12
							arrCol.add(correctNull(rs.getString("sec_streetno")));//13
							arrCol.add(correctNull(rs.getString("sec_wardno")));//14
							arrCol.add(Helper.correctDouble(correctNull(rs.getString("sec_totalarea"))));//15
							arrCol.add(Helper.CLOBToString(rs.getClob("sec_east")));//16
							arrCol.add(Helper.CLOBToString(rs.getClob("sec_west")));//17
							arrCol.add(Helper.CLOBToString(rs.getClob("sec_north")));//18
							arrCol.add(Helper.CLOBToString(rs.getClob("sec_south")));//19
							arrCol.add(correctNull(rs.getString("sec_ageofbuilding")));//20
							arrCol.add(Helper.correctDouble(correctNull(rs.getString("sec_saleamount"))));//21
							arrCol.add(correctNull(rs.getString("sec_buildername")));//22
							arrCol.add(correctNull(rs.getString("sec_refnoapprov")));//23
							arrCol.add(correctNull(rs.getString("sec_nofloor")));//24
							
							strArea=Helper.correctNull(rs.getString("sec_measurement"));
							
						}
						else
						{
							arrCol.add("");//8
							arrCol.add("");//9
							arrCol.add("");//10
							arrCol.add("");//11
							arrCol.add("");//12
							arrCol.add("");//13
							arrCol.add("");//14
							arrCol.add("");//15
							arrCol.add("");//16
							arrCol.add("");//17
							arrCol.add("");//18
							arrCol.add("");//19
							arrCol.add("");//20
							arrCol.add("");//21
							arrCol.add("");//22
							arrCol.add("");//23
						}
						
					}
					
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_ddr_securitydetails^"+appno+"^"+Helper.correctNull(rs2.getString("sec_id")));
					if(rs.next())
					{
						if(Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("18") || Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("19"))
						{
							arrCol.add(Helper.correctNull(rs.getString("ddr_authorised_dealer")));//15
							arrCol.add(Helper.correctNull(rs.getString("ddr_invoicedate")));//16
							arrCol.add(Helper.correctNull(rs.getString("ddr_subdealer")));//17
							arrCol.add(Helper.correctNull(rs.getString("ddr_maindealername")));//18
							arrCol.add(Helper.correctNull(rs.getString("ddr_maindealeraddress")));//19
							arrCol.add(Helper.correctNull(rs.getString("ddr_confirmadateofsubdealer")));//20
							arrCol.add(Helper.correctNull(rs.getString("ddr_subdealertinno")));//21
							arrCol.add(Helper.correctNull(rs.getString("ddr_modeofrepay")));//22
							arrCol.add(Helper.correctNull(rs.getString("ddr_verificationofveh")));//23
						}
						else
						{
							arrCol.add(Helper.correctNull(rs.getString("ddr_cersaiobser")));//24
							arrCol.add(Helper.correctNull(rs.getString("ddr_propdesc_val")));//25
							arrCol.add(Helper.correctNull(rs.getString("ddr_propdesc_law")));//26
							arrCol.add(Helper.correctNull(rs.getString("ddr_propdesc_variationcmt")));//27
							if(!Helper.correctNull(rs.getString("ddr_officerid_acc")).equalsIgnoreCase(""))
							{
								if(rs3!=null)
									rs3.close();
								rs3=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("ddr_officerid_acc")));
								if(rs3.next())
									arrCol.add(Helper.correctNull(rs3.getString("name"))+" - "+Helper.correctNull(rs.getString("ddr_officerid_acc")));//28
								else
									arrCol.add("");//28
							}
							else
							{
								arrCol.add("");//28
							}
							
							if(!strArea.equalsIgnoreCase(""))
							{
								if(rs3!=null)
									rs3.close();
								strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^135^"+strArea);
								rs3 = DBUtils.executeQuery(strQuery);
								if(rs3.next())
									arrCol.add(correctNull(rs3.getString("stat_data_desc1")));//30
								else
									arrCol.add("");//25
							}
							else
								arrCol.add("");//25
								
						}
					}
					else
					{
						if(Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("18") || Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("19"))
						{
							arrCol.add("");//15
							arrCol.add("");//16
							arrCol.add("");//17
							arrCol.add("");//18
							arrCol.add("");//19
							arrCol.add("");//20
							arrCol.add("");//21
							arrCol.add("");//22
							arrCol.add("");//23
						}
						else
						{
							arrCol.add("");//25
							arrCol.add("");//26
							arrCol.add("");//27
							arrCol.add("");//28
							arrCol.add("");//29
							arrCol.add("");//30
						}
					}
					
					arrCol.add(Helper.correctNull(rs2.getString("sec_id")));//30 -> Prop 24 -> Veh
					if(Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("18") || Helper.correctNull(rs1.getString("cus_sec_type")).equalsIgnoreCase("19"))
						arrVehDet.add(arrCol);
					else
						arrPropDet.add(arrCol);
				}
				
			}
			
			hshValues.put("arrPropDet",arrPropDet);
			hshValues.put("arrVehDet",arrVehDet);
			
			

		}
		catch (Exception e) 
		{
			throw new EJBException("Exception caught in getdueReportPrint Method ===" + e.getMessage());
		}
		
		
		return hshValues;
	}
	public HashMap getdueReportGeneralInfo(HashMap hshRequestValues) 
	{
			String strQuery =null;
			ResultSet rs = null,rs1=null,rs2=null,rs3=null;
			HashMap hshValues = new HashMap();
			ArrayList arrPropSec=new ArrayList();
			ArrayList arrVehSec=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
				
				strQuery=SQLParser.getSqlQuery("sel_ddrsecdetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_ddr_securitydetails^"+strAppno+"^"+Helper.correctNull(rs.getString("sec_id")));
					if(rs1.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("sec_id")));//0
						if(Helper.correctNull(rs.getString("cus_sec_type")).equalsIgnoreCase("18") || Helper.correctNull(rs.getString("cus_sec_type")).equalsIgnoreCase("19"))
						{
							arrCol.add("V");//1
							arrCol.add(Helper.correctNull(rs1.getString("ddr_authorised_dealer")));//2
							arrCol.add(Helper.correctNull(rs1.getString("ddr_invoicedate")));//3
							arrCol.add(Helper.correctNull(rs1.getString("ddr_subdealer")));//4
							arrCol.add(Helper.correctNull(rs1.getString("ddr_maindealername")));//5
							arrCol.add(Helper.correctNull(rs1.getString("ddr_maindealeraddress")));//6
							arrCol.add(Helper.correctNull(rs1.getString("ddr_confirmadateofsubdealer")));//7
							arrCol.add(Helper.correctNull(rs1.getString("ddr_subdealertinno")));//8
							arrCol.add(Helper.correctNull(rs1.getString("ddr_modeofrepay")));//9
							arrCol.add(Helper.correctNull(rs1.getString("ddr_verificationofveh")));//10
							arrVehSec.add(arrCol);
						}
						else
						{
							arrCol.add("P");//1
							arrCol.add(Helper.correctNull(rs1.getString("ddr_cersaiobser")));//2
							arrCol.add(Helper.correctNull(rs1.getString("ddr_propdesc_val")));//3
							arrCol.add(Helper.correctNull(rs1.getString("ddr_propdesc_law")));//4
							arrCol.add(Helper.correctNull(rs1.getString("ddr_propdesc_variationcmt")));//5
							arrCol.add(Helper.correctNull(rs1.getString("ddr_officerid_acc")));//6
							if(!Helper.correctNull(rs1.getString("ddr_officerid_acc")).equalsIgnoreCase(""))
							{
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs1.getString("ddr_officerid_acc")));
								if(rs2.next())
								{
									arrCol.add(Helper.correctNull(rs2.getString("name")));//7
								}
								else
								{
									arrCol.add("");//7
								}
								
							}
							else
							{
								arrCol.add("");//7
							}
							
							arrPropSec.add(arrCol);
						}
					}
					else
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("sec_id")));
						if(Helper.correctNull(rs.getString("cus_sec_type")).equalsIgnoreCase("18") || Helper.correctNull(rs.getString("cus_sec_type")).equalsIgnoreCase("19"))
						{
							arrCol.add("V");//1
							arrCol.add("");//2
							arrCol.add("");//3
							arrCol.add("");//4
							arrCol.add("");//5
							arrCol.add("");//6
							arrCol.add("");//7
							arrCol.add("");//8
							arrCol.add("");//9
							arrCol.add("");//10
							arrVehSec.add(arrCol);
						}
						else
						{
							arrCol.add("P");//1
							arrCol.add("");//2
							arrCol.add("");//3
							arrCol.add("");//4
							arrCol.add("");//5
							arrCol.add("");//6
							arrCol.add("");//7
							arrPropSec.add(arrCol);
						}
					}
				}
				hshValues.put("arrVehSec",arrVehSec);
				hshValues.put("arrPropSec",arrPropSec);
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_ddr_generalinfo^"+strAppno);
				if(rs.next())
				{
					hshValues.put("strMarketReport",Helper.correctNull(rs.getString("ddr_marketreport")));
					hshValues.put("strEnquiremadewith",Helper.correctNull(rs.getString("ddr_enquiredwith")));
					hshValues.put("strContactno",Helper.correctNull(rs.getString("ddr_contactno")));
					hshValues.put("stropionionabtbor",Helper.correctNull(rs.getString("ddr_opinionabtbor")));
					hshValues.put("strDDRcontactedby",Helper.correctNull(rs.getString("ddr_contactedby")));
					
					if(!Helper.correctNull(rs.getString("ddr_contactedby")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("ddr_contactedby")));
						if(rs1.next())
						{
							hshValues.put("strDDRcontactedbyName",Helper.correctNull(rs1.getString("name")));	
						}
					}
				}
				
				
			}catch (Exception e) {
				throw new EJBException("Exception caught in getdueReportGeneralInfo Method ===" + e.getMessage());
			}
			
			return hshValues;
	}
	public void updatedueReportGeneralInfo(HashMap hshValues) 
	{
			String strQuery = "";
			HashMap hshQuery=new HashMap();
			HashMap hshQueryValues=new HashMap();
			ArrayList arrValues=new ArrayList();
			int intSize=0;
			try
			{
			String strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String strhidAction = Helper.correctNull((String) hshValues.get("hidAction"));
			
			if(strhidAction.equalsIgnoreCase("I"))
			{
			++intSize;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			hshQueryValues.put("size",String.valueOf(intSize));
			hshQuery.put("strQueryId","del_ddr_securitydetails");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(String.valueOf(intSize),hshQuery);
			
			++intSize;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			hshQueryValues.put("size",String.valueOf(intSize));
			hshQuery.put("strQueryId","del_ddr_generalinfo");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(String.valueOf(intSize),hshQuery);
			
			++intSize;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_market_report")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_enq_name")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_enq_contactno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_opin_borr")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_convertedid")));
			hshQueryValues.put("size",String.valueOf(intSize));
			hshQuery.put("strQueryId","ins_ddr_generalinfo");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(String.valueOf(intSize),hshQuery);
			
			if(Integer.parseInt(Helper.correctInt((String)hshValues.get("hidPropCnt")))>0)
			{
				String[] strSecID=null; 
				String[] strSecFlag=null; 
				String[] strCERSAI=null; 
				String[] strSecDescVal=null; 
				String[] strSecDescLegal=null; 
				String[] strSecDescVariation=null; 
				String[] strStaffID=null; 
				
				if(hshValues.get("hid_propsecid") instanceof String[])
				{
					
					strSecID=(String[])hshValues.get("hid_propsecid");
					strSecFlag=(String[])hshValues.get("hid_propsectype");
					strCERSAI=(String[])hshValues.get("txt_cersai_verification");
					strSecDescVal=(String[])hshValues.get("txt_propdesc_vr");
					strSecDescLegal=(String[])hshValues.get("txt_propdesc_lo");
					strSecDescVariation=(String[])hshValues.get("txt_propdesc_diff");
					strStaffID=(String[])hshValues.get("txt_staffidaccompanied");
					
				}else{
					
					strSecID= new String[1];
					strSecID[0]=(String)hshValues.get("hid_propsecid");
					
					strSecFlag= new String[1];
					strSecFlag[0]=(String)hshValues.get("hid_propsectype");
					
					strCERSAI= new String[1];
					strCERSAI[0]=(String)hshValues.get("txt_cersai_verification");
					
					strSecDescVal= new String[1];
					strSecDescVal[0]=(String)hshValues.get("txt_propdesc_vr");
					
					strSecDescLegal= new String[1];
					strSecDescLegal[0]=(String)hshValues.get("txt_propdesc_lo");
					
					strSecDescVariation= new String[1];
					strSecDescVariation[0]=(String)hshValues.get("txt_propdesc_diff");
					
					strStaffID= new String[1];
					strStaffID[0]=(String)hshValues.get("txt_staffidaccompanied");
				}
				
				
				for(int i=0;i<strSecID.length;i++)
				{
					if(strSecID[i]!="")
					{
						++intSize;
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("strQueryId","ins_ddrpropdetails");
						arrValues.add(strAppno);
						arrValues.add(strSecID[i]);	
						arrValues.add(strSecFlag[i]);	
						arrValues.add(strCERSAI[i]);
						arrValues.add(strSecDescVal[i]);
						arrValues.add(strSecDescLegal[i]);
						arrValues.add(strSecDescVariation[i]);
						arrValues.add(strStaffID[i]);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				
			}
			if(Integer.parseInt(Helper.correctInt((String)hshValues.get("hidVehCnt")))>0)
			{
				String[] strSecID=null; 
				String[] strSecFlag=null; 
				String[] strAuthDealer=null; 
				String[] strInvoiceDt=null; 
				String[] strSubDealer=null; 
				String[] strMainDealerName=null; 
				String[] strMainDealerAddress=null; 
				String[] strConfirmationDt=null; 
				String[] strTINNo=null; 
				String[] strRepayment=null; 
				String[] strVerification=null; 
				
				if(hshValues.get("hid_vehsecid") instanceof String[])
				{
					strSecID=(String[])hshValues.get("hid_vehsecid");
					strSecFlag=(String[])hshValues.get("hid_vehsectype");
					strAuthDealer=(String[])hshValues.get("sel_authoriseddealer");
					strInvoiceDt=(String[])hshValues.get("txt_invoicerecptdt");
					strSubDealer=(String[])hshValues.get("sel_subdealer");
					strMainDealerName=(String[])hshValues.get("txt_dealername");
					strMainDealerAddress=(String[])hshValues.get("txt_dealeraddress");
					strConfirmationDt=(String[])hshValues.get("txt_dealerconfirmdate");
					strTINNo=(String[])hshValues.get("txt_tinno");
					strRepayment=(String[])hshValues.get("txt_modeofrepayment");
					strVerification=(String[])hshValues.get("txt_verificationdate");
					
				}else{
					
					strSecID= new String[1];
					strSecID[0]=(String)hshValues.get("hid_vehsecid");
					
					strSecFlag= new String[1];
					strSecFlag[0]=(String)hshValues.get("hid_vehsectype");
					
					strAuthDealer= new String[1];
					strAuthDealer[0]=(String)hshValues.get("sel_authoriseddealer");
					
					strInvoiceDt= new String[1];
					strInvoiceDt[0]=(String)hshValues.get("txt_invoicerecptdt");
					
					strSubDealer= new String[1];
					strSubDealer[0]=(String)hshValues.get("sel_subdealer");
					
					strMainDealerName= new String[1];
					strMainDealerName[0]=(String)hshValues.get("txt_dealername");
					
					strMainDealerAddress= new String[1];
					strMainDealerAddress[0]=(String)hshValues.get("txt_dealeraddress");
					
					strConfirmationDt= new String[1];
					strConfirmationDt[0]=(String)hshValues.get("txt_dealerconfirmdate");
					
					strTINNo= new String[1];
					strTINNo[0]=(String)hshValues.get("txt_tinno");
					
					strRepayment= new String[1];
					strRepayment[0]=(String)hshValues.get("txt_modeofrepayment");
					
					strVerification= new String[1];
					strVerification[0]=(String)hshValues.get("txt_verificationdate");
					
				}
				
				
				for(int i=0;i<strSecID.length;i++)
				{
					if(strSecID[i]!="")
					{
						++intSize;
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("strQueryId","ins_ddrvehdetails");
						arrValues.add(strAppno);
						arrValues.add(strSecID[i]);	
						arrValues.add(strSecFlag[i]);	
						arrValues.add(strAuthDealer[i]);
						arrValues.add(strInvoiceDt[i]);
						arrValues.add(strSubDealer[i]);
						arrValues.add(strMainDealerName[i]);
						arrValues.add(strMainDealerAddress[i]);
						arrValues.add(strConfirmationDt[i]);
						arrValues.add(strTINNo[i]);
						arrValues.add(strRepayment[i]);
						arrValues.add(strVerification[i]);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				
			}
			
			
			if(intSize>0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strhidAction.equalsIgnoreCase("D"))
			{
				++intSize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				hshQueryValues.put("size",String.valueOf(intSize));
				hshQuery.put("strQueryId","del_ddr_securitydetails");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(intSize),hshQuery);
				
				++intSize;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				hshQueryValues.put("size",String.valueOf(intSize));
				hshQuery.put("strQueryId","del_ddr_generalinfo");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(intSize),hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			}
			catch (Exception e) {
				throw new EJBException("Exception caught in "+e.getMessage());
			}

	}
	public void updateQueryData(HashMap hshValues) 
	{
			String strQuery = "",strSno="0",strQuery1="";
			ResultSet rs=null,rs1=null;
			HashMap hshQuery=new HashMap();
			HashMap hshQueryValues=new HashMap();
			ArrayList arrValues=new ArrayList();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			StringBuilder sbOldAudit = new StringBuilder();
			 ArrayList arrOldAudit=new ArrayList();
		     ArrayList arrOldAudit1=new ArrayList();
			int intSize=0;
			try
			{
			String strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String strhidAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strSno=Helper.correctInt((String)hshValues.get("hidsno"));
			
			/***
			 * For Audit Trial Old Data
			 */
			rs=DBUtils.executeLAPSQuery("sel_app_querydetails1^"+strAppno+"^"+strSno);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("aq_sno")));//0
				arrCol.add(Helper.correctNull(rs.getString("aq_orgcode")));//1
				arrCol.add(Helper.correctNull(rs.getString("aq_orgdept")));//2
				arrCol.add(Helper.correctNull(rs.getString("aq_query")));//3

				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_raisedby")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("username")));//4
				else
					arrCol.add("");//4
				arrCol.add(Helper.correctNull(rs.getString("aq_createdon")));//5
				arrCol.add(Helper.correctNull(rs.getString("aq_raisedby")));//6
				arrCol.add(Helper.correctNull(rs.getString("aq_status")));//7
				arrCol.add(Helper.correctNull(rs.getString("aq_raisedon")));//8
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("selorgname^"+Helper.correctNull(rs.getString("aq_orgcode")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("org_name")));//9
				else
					arrCol.add("");//9
				arrCol.add(Helper.correctNull(rs.getString("aq_repliedby")));//10
				arrCol.add(Helper.correctNull(rs.getString("aq_repliedon")));//11
				arrCol.add(Helper.correctNull(rs.getString("aq_closedby")));//12
				arrCol.add(Helper.correctNull(rs.getString("aq_closeddate")));//13
				arrCol.add(Helper.correctNull(rs.getString("aq_reply")));//14        add here
				
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_repliedby")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("username")));//16
				else
					arrCol.add("");//16
				arrRow.add(arrCol);
			}
			
			if((arrRow!=null)&&(arrRow.size()>0))
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrOldAudit=new ArrayList();
					arrOldAudit=(ArrayList)arrRow.get(i);
					String strValOldAudit=Helper.correctNull((String)arrOldAudit.get(7));
					String strValDescOldAudit="";
					if(strValOldAudit.equalsIgnoreCase("QE"))
					{
						strValDescOldAudit="Query Entered";
						sbOldAudit.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
						.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
						.append("~Query Status = ").append(strValDescOldAudit);
					}
					else if(strValOldAudit.equalsIgnoreCase("QS"))
					{
						strValDescOldAudit="Query Send";
						sbOldAudit.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
						.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
						.append("~Query Status = ").append(strValDescOldAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
						.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9)));
					}
					else if(strValOldAudit.equalsIgnoreCase("QO"))
					{
						strValDescOldAudit="Query ReOpened";
						sbOldAudit.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
						.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~ReCreated On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
						.append("~Query Status = ").append(strValDescOldAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
						.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9)));
					}
				}
			}
			/***
			 * End - Audit Trial Old Data
			 */
			if(strhidAction.equalsIgnoreCase("insert"))
			{
				rs=DBUtils.executeLAPSQuery("sel_maxsno_query^"+strAppno);
				if(rs.next())
				{
					strSno=Helper.correctNull(rs.getString("sno"));
				}
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				if(correctNull((String)hshValues.get("sel_level")).equalsIgnoreCase("001000000000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment")));
				else if(!(correctNull((String)hshValues.get("sel_level")).substring(6, 9)).equalsIgnoreCase("000")&&
						(correctNull((String)hshValues.get("sel_level")).substring(9,15)).equalsIgnoreCase("000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment1")));
				else
					arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("txt_query")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add("QE");
				arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				arrValues.add("0");
				hshQuery.put("strQueryId","ins_app_querydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strhidAction.equalsIgnoreCase("update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				String level=Helper.correctNull((String)hshValues.get("sel_level"));
				if(correctNull((String)hshValues.get("sel_level")).equalsIgnoreCase("001000000000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment")));
				else if(!(correctNull((String)hshValues.get("sel_level")).substring(6, 9)).equalsIgnoreCase("000")&&
						(correctNull((String)hshValues.get("sel_level")).substring(9,15)).equalsIgnoreCase("000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment1")));
				else
					arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("txt_query")));
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("strQueryId","upd_app_querydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strhidAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("strQueryId","del_app_querydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strhidAction.equalsIgnoreCase("SendQuery"))
			{
				
//				String strOrgScode="",strDept="",strSendOrgLevel="",strSendOrgCode="";
//				strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+Helper.correctNull((String)hshValues.get("hidmail_tousrid")));
//				rs=DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					strOrgScode=Helper.correctNull(rs.getString("org_scode"));
//					if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
//						strDept=Helper.correctNull(rs.getString("usr_department"));
//					else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
//						strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
//					strSendOrgLevel=Helper.correctNull(rs.getString("org_level"));
//					strSendOrgCode=Helper.correctNull(rs.getString("org_code"));
//				}
//				
//				arrValues=new ArrayList();
//				hshQuery=new HashMap();
//				arrValues.add(strAppno);
//				arrValues.add(strSno);
//				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
//				arrValues.add(Helper.correctNull((String)hshValues.get("hidmail_tousrid")));
//				arrValues.add("C");
//				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
//				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
//					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
//				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
//					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
//				else
//					arrValues.add("");
//				arrValues.add(strOrgScode);
//				arrValues.add(strDept);
//				hshQuery.put("strQueryId","ins_QUERY_APPMAILBOX");
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
				String level=Helper.correctNull((String)hshValues.get("sel_level"));
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add("QS");
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("strQueryId","upd_querydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				
				/*int intsize=2;
				//Query CC Copy
				String strMinClass="0",strMaxClass="0";
				if(rs!=null)
					rs.close();
				if(strSendOrgLevel.equalsIgnoreCase("C") && strDept.equalsIgnoreCase("001"))
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^P002");
				else if(strSendOrgLevel.equalsIgnoreCase("C") && strDept.equalsIgnoreCase("002"))
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^P003");
				else if(strSendOrgLevel.equalsIgnoreCase("A"))
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^P004");
				else
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^P005");
				
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMinClass=Helper.correctInt(rs.getString("LOAN_PARAMVAL"));
					strMaxClass=Helper.correctInt(rs.getString("LOAN_PARAMVAL1"));
				}
				
				if(rs!=null)
					rs.close();
				if(strSendOrgLevel.equalsIgnoreCase("C"))
					strQuery=SQLParser.getSqlQuery("sel_mailcc_entry^001%"+"^"+strMinClass+"^"+strMaxClass+"^ and USR_DEPARTMENT='"+strDept+"'");
				else if(strSendOrgLevel.equalsIgnoreCase("A"))
					strQuery=SQLParser.getSqlQuery("sel_mailcc_entry^"+strSendOrgCode+"^"+strMinClass+"^"+strMaxClass+"^ ");
				else
					strQuery=SQLParser.getSqlQuery("sel_mailcc_entry^"+strSendOrgCode.subSequence(0, 6)+"%^"+strMinClass+"^"+strMaxClass+"^ and ((org_level='D' and USR_RLPFTYPE='"+strDept+"') or org_level='R')");
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!Helper.correctNull(rs.getString("usr_id")).equalsIgnoreCase(Helper.correctNull((String)hshValues.get("hidmail_tousrid"))))
					{
						intsize++;
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strAppno);
						arrValues.add(strSno);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(Helper.correctNull(rs.getString("usr_id")));
						arrValues.add("CC");
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						arrValues.add(Helper.correctNull(rs.getString("org_scode")));
						if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
							arrValues.add(Helper.correctNull(rs.getString("USR_DEPARTMENT")));
						else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
							arrValues.add(Helper.correctNull(rs.getString("USR_RLPFTYPE")));
						else
							arrValues.add("");
						hshQuery.put("strQueryId","ins_QUERY_APPMAILBOX");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						hshQueryValues.put("size",String.valueOf(intsize));
					}
				}*/
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(rs!=null)
				rs.close();
				String strMessage="",strheadmob="",strabmno="";
				rs=DBUtils.executeLAPSQuery("sel_sms_master");
				if(rs.next())
				{
					strMessage=Helper.correctNull(rs.getString("SMS_ABMQUERY"));
				}
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_AppRefNo^"+strAppno);
				if(rs.next())
				{
					strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("INWARD_CUSTNAME"))).replaceAll("@PRono", strAppno);
				}else
				{
					rs=DBUtils.executeLAPSQuery("sel_name_sms_permissionmodule^"+strAppno);
					if(rs.next())
					{
						strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("PG_APPLIANTNAME"))).replaceAll("@PRono", strAppno);
					}
				}
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("get_mobileno_ABM_sendSMS^"+strAppno+"^"+strSno);
				if(rs.next())
				{
					strMessage=strMessage.replaceAll("@DAteTime", Helper.correctNull(rs.getString("datepart"))+"-"+ Helper.correctNull(rs.getString("timepart")));
					strheadmob=Helper.correctNull(rs.getString("ORG_MANAGER_CTNUM"));
					HashMap hshTemp = new HashMap();
					hshTemp.put("strMobileno", strheadmob);
					hshTemp.put("strMessage", strMessage);
					hshTemp.put("strAppno", strAppno);
					Helper.sendSMSFromVariousPlace(hshTemp);
					log.info("1 st SMS trigger sucessfully");
					strabmno=Helper.correctNull(rs.getString("ORG_ABMMOBILE"));
					if(!strabmno.equalsIgnoreCase(""))
					{
						hshTemp = new HashMap();
						hshTemp.put("strMobileno", strabmno);
						hshTemp.put("strMessage", strMessage);
						hshTemp.put("strAppno", strAppno);
						Helper.sendSMSFromVariousPlace(hshTemp);
					}
				}
				if(rs!=null)
					rs.close();
			}
			else if(strhidAction.equalsIgnoreCase("ReplyQuery"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Reply_query")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("strQueryId","upd_queryreplydetails_udpate");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strhidAction.equalsIgnoreCase("CloseQuery"))
			{
				
			}
			else if(strhidAction.equalsIgnoreCase("ReOpenQuery"))
			{
				String hid_parentid=Helper.correctNull((String)hshValues.get("hid_parentid"));
				String hidslno="";
				if(!hid_parentid.equals("0"))
				{
					hidslno=hid_parentid;
				}
				else
				{
					hidslno=Helper.correctNull((String)hshValues.get("hidsno"));
				}
				 
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add("QO");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("strQueryId","upd_querydetails_reopen");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				rs=DBUtils.executeLAPSQuery("sel_maxsno_query_reopen^"+strAppno+"^"+hidslno);
				if(rs.next())
				{
					strSno=Helper.correctNull(rs.getString("sno"));
				}
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(strAppno);
				if(strSno.equalsIgnoreCase("0.1")){
					double a=Double.parseDouble(hidslno)+Double.parseDouble(strSno);
					arrValues.add(Helper.formatDoubleValue(a));
				}
				else
					arrValues.add(strSno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				if(correctNull((String)hshValues.get("sel_level")).equalsIgnoreCase("001000000000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment")));
				else if(!(correctNull((String)hshValues.get("sel_level")).substring(6, 9)).equalsIgnoreCase("000")&&
						(correctNull((String)hshValues.get("sel_level")).substring(9,15)).equalsIgnoreCase("000000"))
					arrValues.add(correctNull((String)hshValues.get("seldepartment1")));
				else
					arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("txt_query")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add("QE");
				arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
				else
					arrValues.add("");
				arrValues.add(hidslno); 
				hshQuery.put("strQueryId","ins_app_querydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
			// for new audit trail
					StringBuilder sbAuditTrial=new StringBuilder();
								String strValDescnewAudit="";
								if(strhidAction.equalsIgnoreCase("insert") || strhidAction.equalsIgnoreCase("update") ||strhidAction.equalsIgnoreCase("delete"))
								{	
									strValDescnewAudit="Query Entered";
									sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)hshValues.get("strOrgCode"))).append("~Query = ").append(Helper.correctNull((String)hshValues.get("txt_query")))
									.append("~Query Created By = ").append((Helper.correctNull((String)hshValues.get("strUserId")))+"-"+Helper.correctNull((String)hshValues.get("strUserName"))).append("~Created On = ").append(Helper.getCurrentDateTime())
									.append("~Query Status = ").append(strValDescnewAudit);
								}
								else if(strhidAction.equalsIgnoreCase("SendQuery"))
								{
									strValDescnewAudit="Query Send";
									sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)hshValues.get("strOrgCode"))).append("~Query = ").append(Helper.correctNull((String)hshValues.get("txt_query")))
									.append("~Query Created By = ").append((Helper.correctNull((String)hshValues.get("strUserId")))+"-"+Helper.correctNull((String)hshValues.get("strUserName"))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
									.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.getCurrentDateTime())
									.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9)));
								}
								else if(strhidAction.equalsIgnoreCase("ReOpenQuery"))
								{
									strValDescnewAudit="Query ReOpened";
									sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)hshValues.get("strOrgCode"))).append("~Query = ").append(Helper.correctNull((String)hshValues.get("txt_query")))
									.append("~Query ReCreated By = ").append((Helper.correctNull((String)hshValues.get("strUserId")))+"-"+Helper.correctNull((String)hshValues.get("strUserName"))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
									.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.getCurrentDateTime())
									.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9)));
								
								}
								else if(strhidAction.equalsIgnoreCase("ReplyQuery"))
								{
									strValDescnewAudit="Reply";
									sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
									.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
									.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
									.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9))).append("~Reply = ").append(Helper.correctNull((String)hshValues.get("txt_Reply_query")))
									.append("~Query Replied By = ").append((Helper.correctNull((String)hshValues.get("strUserId")))+"-"+Helper.correctNull((String)hshValues.get("strUserName"))).append("~Query Replied On = ").append(Helper.getCurrentDateTime());
							
									
								}
								/*sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)hshValues.get("strOrgCode"))).append("~Query = ").append(Helper.correctNull((String)hshValues.get("txt_query")))
								.append("~Query Created By = ").append(Helper.correctNull((String)hshValues.get("strUserId"))).append("~Created On = ").append(Helper.getCurrentDateTime())
								.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.correctNull((String)hshValues.get("")))
								.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)hshValues.get(""))).append("~Reply = ").append(Helper.correctNull((String)hshValues.get("txt_Reply_query")))
								.append("~Query Replied By = ").append(Helper.correctNull((String)hshValues.get("txt_repliedby"))).append("~Query Replied On = ").append(Helper.correctNull((String)hshValues.get("txt_repliedon")))
								.append("~Query Closed By = ").append(Helper.correctNull((String)hshValues.get("txt_closedby"))).append("~Query Closed On = ").append(Helper.correctNull((String)hshValues.get("txt_closedon")));*/
							
			/*if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}*/
			AuditTrial.auditNewLog1(hshValues,"555",strAppno,sbAuditTrial.toString(),sbOldAudit.toString(),strSno);	
			
			}
			catch (Exception e) {
				throw new EJBException("Exception caught in updateQueryData"+e.getMessage());
			}

	}
	public HashMap getQueryData(HashMap hshRequestValues) 
	{
			String strQuery =null;
			ResultSet rs = null,rs1=null,rs2=null,rs3=null;
			HashMap hshValues = new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
				rs=DBUtils.executeLAPSQuery("sel_app_querydetails_parent^"+strAppno+"^0");
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("aq_sno")));//0
					arrCol.add(Helper.correctNull(rs.getString("aq_orgcode")));//1
					arrCol.add(Helper.correctNull(rs.getString("aq_orgdept")));//2
					arrCol.add(Helper.correctNull(rs.getString("aq_query")));//3

					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_raisedby")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("username")));//4
					else
						arrCol.add("");//4
					arrCol.add(Helper.correctNull(rs.getString("aq_createdon")));//5
					arrCol.add(Helper.correctNull(rs.getString("aq_raisedby")));//6
					arrCol.add(Helper.correctNull(rs.getString("aq_status")));//7
					arrCol.add(Helper.correctNull(rs.getString("aq_raisedon")));//8
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selorgname^"+Helper.correctNull(rs.getString("aq_orgcode")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("org_name")));//9
					else
						arrCol.add("");//9
					arrCol.add(Helper.correctNull(rs.getString("aq_repliedby")));//10
					arrCol.add(Helper.correctNull(rs.getString("aq_repliedon")));//11
					arrCol.add(Helper.correctNull(rs.getString("aq_closedby")));//12
					arrCol.add(Helper.correctNull(rs.getString("aq_closeddate")));//13
					arrCol.add(Helper.correctNull(rs.getString("aq_reply")));//14
					
					if((Helper.correctNull(rs.getString("org_level"))).equalsIgnoreCase("C"))
					{
						if((Helper.correctNull(rs.getString("org_code"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode"))) && (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strUserDepartment"))))
						{
							strQuery="";
							String strParam="P";
							strParam=strParam.concat(Helper.correctNull(rs.getString("aq_sentorgdept")));
							//if((Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("001")|| (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("011"))
								//strQuery=SQLParser.getSqlQuery("selloanagainstparams^"+strParam);
							//else if((Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("009") || (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("010")
									//|| (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("012"))
								strQuery=SQLParser.getSqlQuery("selloanagainstparams^"+strParam);
							
							if(!strQuery.equalsIgnoreCase(""))
							{
								if(rs1!=null)
									rs1.close();
								rs1=DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									if((Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
											(Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
										arrCol.add("Y");//15
									else
										arrCol.add("N");//15
								}
								else
								{
									arrCol.add("N");//15
								}
							}
							else
							{
								arrCol.add("N");//15
							}
						}
						else
						{
							arrCol.add("N");
						}
					}
					else if((Helper.correctNull(rs.getString("org_level"))).equalsIgnoreCase("A"))
					{
						if((Helper.correctNull(rs.getString("org_code"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode"))))
						{
							strQuery=SQLParser.getSqlQuery("selloanagainstparams^P004");
							if(rs1!=null)
								rs1.close();
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								if((Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
										(Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
									arrCol.add("Y");//15
								else
									arrCol.add("N");//15
							}
							else
							{
								arrCol.add("N");//15
							}
						}
						else
						{
							arrCol.add("N");//15
						}
					}
					else if((Helper.correctNull(rs.getString("org_code")).substring(0, 6)).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode")).substring(0, 6)))
					{
						strQuery=SQLParser.getSqlQuery("selloanagainstparams^P005");
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							if((Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
									(Integer.parseInt(Helper.correctInt(rs1.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
								arrCol.add("Y");//15
							else
								arrCol.add("N");//15
						}
						else
						{
							arrCol.add("N");//15
						}
					}
					else
					{
						arrCol.add("N");//15
					}
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_repliedby")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("username")));//16
					else
						arrCol.add("");//16
					
					if(Helper.correctNull(rs.getString("aq_status")).equalsIgnoreCase("QE"))
						hshRequestValues.put("strQueryFlag","Y");	
					
					if(Helper.correctNull(rs.getString("aq_status")).equalsIgnoreCase("QS"))
						hshRequestValues.put("strReplyFlag","Y");	
					
					arrCol.add(Helper.correctNull(rs.getString("AQ_PARENTID")));//17
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_closedby")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("username")));//18
					else
						arrCol.add("");//4
					
					/*if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("chk_querydetails_parent^"+strAppno+"^"+Helper.correctNull(rs.getString("AQ_PARENTID"))+"^"+Helper.correctInt((String)rs.getString("aq_sno")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("cnt")));//19*/	
				if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("chk_querydetails_parent^"+strAppno+"^"+Helper.correctNull(rs.getString("AQ_PARENTID"))+"^"+Helper.correctInt((String)rs.getString("aq_sno")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("cnt")));//19
					
					arrCol.add(Helper.correctNull(rs.getString("aq_sentorgcode")));//20
					
					arrRow.add(arrCol);
					
					String intGroup=Helper.correctInt((String)rs.getString("aq_sno"));
					
					if(Helper.correctNull(rs.getString("aq_status")).equals("QE"))
						hshRequestValues.put("strCreatedUser",Helper.correctNull(rs.getString("aq_raisedby")));
					else if(Helper.correctNull(rs.getString("aq_status")).equals("QS"))
						hshRequestValues.put("strRepliedUser",Helper.correctNull(rs.getString("aq_repliedby")));
					
					if(rs2!=null)
						rs2.close();
					rs2=DBUtils.executeLAPSQuery("sel_app_querydetails_parent^"+strAppno+"^"+intGroup);
					while(rs2.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs2.getString("aq_sno")));//0
						arrCol.add(Helper.correctNull(rs2.getString("aq_orgcode")));//1
						arrCol.add(Helper.correctNull(rs2.getString("aq_orgdept")));//2
						arrCol.add(Helper.correctNull(rs2.getString("aq_query")));//3
						
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs2.getString("aq_raisedby")));
						if(rs3.next())
							arrCol.add(Helper.correctNull(rs3.getString("username")));//4
						else
							arrCol.add("");//4
						arrCol.add(Helper.correctNull(rs2.getString("aq_createdon")));//5
						arrCol.add(Helper.correctNull(rs2.getString("aq_raisedby")));//6
						arrCol.add(Helper.correctNull(rs2.getString("aq_status")));//7
						arrCol.add(Helper.correctNull(rs2.getString("aq_raisedon")));//8
						
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("selorgname^"+Helper.correctNull(rs2.getString("aq_orgcode")));
						if(rs3.next())
							arrCol.add(Helper.correctNull(rs3.getString("org_name")));//9
						else
							arrCol.add("");//9
						arrCol.add(Helper.correctNull(rs2.getString("aq_repliedby")));//10
						arrCol.add(Helper.correctNull(rs2.getString("aq_repliedon")));//11
						arrCol.add(Helper.correctNull(rs2.getString("aq_closedby")));//12
						arrCol.add(Helper.correctNull(rs2.getString("aq_closeddate")));//13
						arrCol.add(Helper.correctNull(rs2.getString("aq_reply")));//14
						
						if((Helper.correctNull(rs2.getString("org_level"))).equalsIgnoreCase("C"))
						{
							if((Helper.correctNull(rs2.getString("org_code"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode"))) && (Helper.correctNull(rs2.getString("aq_sentorgdept"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strUserDepartment"))))
							{
								strQuery="";
								String strParam="P";
								strParam=strParam.concat(Helper.correctNull(rs.getString("aq_sentorgdept")));
								//if((Helper.correctNull(rs2.getString("aq_sentorgdept"))).equalsIgnoreCase("001")|| (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("011"))
									//strQuery=SQLParser.getSqlQuery("selloanagainstparams^"+strParam);
								//else if((Helper.correctNull(rs2.getString("aq_sentorgdept"))).equalsIgnoreCase("009") || (Helper.correctNull(rs2.getString("aq_sentorgdept"))).equalsIgnoreCase("010")
									//	|| (Helper.correctNull(rs.getString("aq_sentorgdept"))).equalsIgnoreCase("012"))
									strQuery=SQLParser.getSqlQuery("selloanagainstparams^"+strParam);
								
								if(!strQuery.equalsIgnoreCase(""))
								{
									if(rs3!=null)
										rs3.close();
									rs3=DBUtils.executeQuery(strQuery);
									if(rs3.next())
									{
										if((Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
												(Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
											arrCol.add("Y");//15
										else
											arrCol.add("N");//15
									}
									else
									{
										arrCol.add("N");//15
									}
								}
								else
								{
									arrCol.add("N");//15
								}
							}
							else
							{
								arrCol.add("N");
							}
						}
						else if((Helper.correctNull(rs2.getString("org_level"))).equalsIgnoreCase("A"))
						{
							if((Helper.correctNull(rs2.getString("org_code"))).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode"))))
							{
								strQuery=SQLParser.getSqlQuery("selloanagainstparams^P004");
								if(rs3!=null)
									rs3.close();
								rs3=DBUtils.executeQuery(strQuery);
								if(rs3.next())
								{
									if((Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
											(Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
										arrCol.add("Y");//15
									else
										arrCol.add("N");//15
								}
								else
								{
									arrCol.add("N");//15
								}
							}
							else
							{
								arrCol.add("N");//15
							}
						}
						else if((Helper.correctNull(rs2.getString("org_code")).substring(0, 6)).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("strOrgCode")).substring(0, 6)))
						{
							strQuery=SQLParser.getSqlQuery("selloanagainstparams^P005");
							if(rs3!=null)
								rs3.close();
							rs3=DBUtils.executeQuery(strQuery);
							if(rs3.next())
							{
								if((Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL")))<=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass")))&&
										(Integer.parseInt(Helper.correctInt(rs3.getString("LOAN_PARAMVAL1")))>=Integer.parseInt(Helper.correctInt((String)hshRequestValues.get("strUserClass"))))))
									arrCol.add("Y");//15
								else
									arrCol.add("N");//15
							}
							else
							{
								arrCol.add("N");//15
							}
						}
						else
						{
							arrCol.add("N");//15
						}
						
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs2.getString("aq_repliedby")));
						if(rs3.next())
							arrCol.add(Helper.correctNull(rs3.getString("username")));//16
						else
							arrCol.add("");//16
						
						if(Helper.correctNull(rs2.getString("aq_status")).equals("QE"))
							hshRequestValues.put("strCreatedUser",Helper.correctNull(rs2.getString("aq_raisedby")));
						else if(Helper.correctNull(rs2.getString("aq_status")).equals("QS"))
							hshRequestValues.put("strRepliedUser",Helper.correctNull(rs2.getString("aq_repliedby")));
						
						if(Helper.correctNull(rs2.getString("aq_status")).equalsIgnoreCase("QE"))
							hshRequestValues.put("strQueryFlag","Y");	
						else if(Helper.correctNull(rs2.getString("aq_status")).equalsIgnoreCase("QS"))
							hshRequestValues.put("strReplyFlag","Y");	
						
						arrCol.add(Helper.correctNull(rs2.getString("AQ_PARENTID")));//17
						
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs2.getString("aq_closedby")));
						if(rs3.next())
							arrCol.add(Helper.correctNull(rs3.getString("username")));//18
						else
							arrCol.add("");//4
						//arrCol.add("1");//19
						if(rs3!=null)
							rs3.close();
						rs3=DBUtils.executeLAPSQuery("chk_querydetails_parent^"+strAppno+"^"+Helper.correctNull(rs2.getString("AQ_PARENTID"))+"^"+Helper.correctInt((String)rs2.getString("aq_sno")));
						if(rs3.next())
							arrCol.add(Helper.correctNull(rs3.getString("cnt")));//19
						arrCol.add(Helper.correctNull(rs2.getString("aq_sentorgcode")));//20
						arrRow.add(arrCol);
					}
				}
				
				hshRequestValues.put("arrRow", arrRow);
				

				if(rs!=null)
					rs.close();
				
				 rs=DBUtils.executeLAPSQuery("sel_app_perm_no^"+ strAppno);			 
					if(rs.next()) 
					{
						hshRequestValues.put("StrDigiLoanType", Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")));
					}
			}catch (Exception e) {
				throw new EJBException("Exception caught in getQueryData Method ===" + e.getMessage());
			}
			
			return hshRequestValues;
	}
	public HashMap getQueryDetails(HashMap hshRequestValues) 
	{
			ResultSet rs = null;
			HashMap hshValues = new HashMap();
			try
			{
				String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
				String strSno=Helper.correctNull((String)hshRequestValues.get("hidsno"));
				rs=DBUtils.executeLAPSQuery("select_app_querydetails_sno^"+strAppno+"^"+strSno);
				if(rs.next())
				{
					hshValues.put("aq_appno", Helper.correctNull(rs.getString("aq_appno")));
					hshValues.put("aq_sno", Helper.correctNull(rs.getString("aq_sno")));
					hshValues.put("aq_query", Helper.correctNull(rs.getString("aq_query")));
					hshValues.put("aq_reply", Helper.correctNull(rs.getString("aq_reply")));
					hshValues.put("aq_raisedby", Helper.correctNull(rs.getString("aq_raisedby")));
					hshValues.put("aq_raisedon", Helper.correctNull(rs.getString("aq_raisedon")));
					hshValues.put("aq_repliedby", Helper.correctNull(rs.getString("aq_repliedby")));
					hshValues.put("aq_repliedon", Helper.correctNull(rs.getString("aq_repliedon")));
				}
				
				hshValues.put("strUserId", Helper.correctNull((String)hshRequestValues.get("strUserId")));
				
			}catch (Exception e) {
				throw new EJBException("Exception caught in getQueryDetails Method ===" + e.getMessage());
			}
			
			return hshValues;
	}
	public HashMap UpdateQueryDetails(HashMap hshRequestValues) 
	{
			HashMap hshValues = new HashMap();
			ArrayList arrValues=new ArrayList();
			HashMap hshQuery=new HashMap();
			HashMap hshQueryValues=new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			StringBuilder sbOldAudit = new StringBuilder();
			 ArrayList arrOldAudit=new ArrayList();
		     ArrayList arrOldAudit1=new ArrayList();
		     String strQuery = "",strQuery1="";
				ResultSet rs=null,rs1=null;
				StringBuilder sbAuditTrial=new StringBuilder();
				String strValDescnewAudit="";
				String strValDescOldAudit="";
			try
			{
				String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
				String strSno=Helper.correctNull((String)hshRequestValues.get("hidsno"));
				String strhidAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));/***
				 * For Audit Trial Old Data
				 */
				rs=DBUtils.executeLAPSQuery("sel_app_querydetails1^"+strAppno+"^"+strSno);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("aq_sno")));//0
					arrCol.add(Helper.correctNull(rs.getString("aq_orgcode")));//1
					arrCol.add(Helper.correctNull(rs.getString("aq_orgdept")));//2
					arrCol.add(Helper.correctNull(rs.getString("aq_query")));//3

					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_raisedby")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("username")));//4
					else
						arrCol.add("");//4
					arrCol.add(Helper.correctNull(rs.getString("aq_createdon")));//5
					arrCol.add(Helper.correctNull(rs.getString("aq_raisedby")));//6
					arrCol.add(Helper.correctNull(rs.getString("aq_status")));//7
					arrCol.add(Helper.correctNull(rs.getString("aq_raisedon")));//8
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selorgname^"+Helper.correctNull(rs.getString("aq_orgcode")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("org_name")));//9
					else
						arrCol.add("");//9
					arrCol.add(Helper.correctNull(rs.getString("aq_repliedby")));//10
					arrCol.add(Helper.correctNull(rs.getString("aq_repliedon")));//11
					arrCol.add(Helper.correctNull(rs.getString("aq_closedby")));//12
					arrCol.add(Helper.correctNull(rs.getString("aq_closeddate")));//13
					arrCol.add(Helper.correctNull(rs.getString("aq_reply")));//14        add here
					
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_username^"+Helper.correctNull(rs.getString("aq_repliedby")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("username")));//15
					else
						arrCol.add("");//16
					arrRow.add(arrCol);
				}
				
				if((arrRow!=null)&&(arrRow.size()>0))
				{
					for(int i=0;i<arrRow.size();i++)
					{
						arrOldAudit=new ArrayList();
						arrOldAudit=(ArrayList)arrRow.get(i);
						String strValOldAudit=Helper.correctNull((String)arrOldAudit.get(7));
						
						if(strValOldAudit.equalsIgnoreCase("QR"))
						{
							strValDescOldAudit="Query Replied";
							sbOldAudit.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
							.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
							.append("~Query Status = ").append(strValDescOldAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
							.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9))).append("~Reply = ").append(Helper.correctNull((String)arrOldAudit.get(14)))
							.append("~Query Replied By = ").append((Helper.correctNull((String)arrOldAudit.get(10)))+"-"+ Helper.correctNull((String)arrOldAudit.get(15))).append("~Query Replied On = ").append(Helper.correctNull((String)arrOldAudit.get(11)));
							
						}
						else if(strValOldAudit.equalsIgnoreCase("QC"))
						{
							strValDescOldAudit="Query Closed";
						
						sbOldAudit.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
						.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
						.append("~Query Status = ").append(strValDescOldAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
						.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9))).append("~Reply = ").append(Helper.correctNull((String)arrOldAudit.get(14)))
						.append("~Query Replied By = ").append((Helper.correctNull((String)arrOldAudit.get(10)))+"-"+ Helper.correctNull((String)arrOldAudit.get(15))).append("~Query Replied On = ").append(Helper.correctNull((String)arrOldAudit.get(11)))
						.append("~Query Closed By = ").append(Helper.correctNull((String)arrOldAudit.get(12))).append("~Query Closed On = ").append(Helper.correctNull((String)arrOldAudit.get(13)));
					}
					}
				}
				/***
				 * End - Audit Trial Old Data
				 */
				
				if(strhidAction.equalsIgnoreCase("reply"))
				{
					
					int queryint=1;
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add("QR");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Reply_query")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("strQueryId","upd_queryreplydetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+queryint,hshQuery);
					
					
					
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("chkquerypending^"+strAppno+"^"+strSno);
					if(rs1.next())
					{
						++queryint;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","updmailbxnoofdays");
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(""+queryint,hshQuery);
						
					
					}
					hshQueryValues.put("size", String.valueOf(queryint));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
					sbAuditTrial=new StringBuilder();
					strValDescnewAudit="Query Replied";
					sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
					.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
					.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
					.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9))).append("~Reply = ").append(Helper.correctNull((String)hshRequestValues.get("txt_Reply_query")))
					.append("~Query Replied By = ").append((Helper.correctNull((String)hshRequestValues.get("strUserId")))+"-"+Helper.correctNull((String)hshRequestValues.get("strUserName"))).append("~Query Replied On = ").append(Helper.getCurrentDateTime());
					
				}
				else if(strhidAction.equalsIgnoreCase("CloseQuery"))
				{
					String hid_parentid=Helper.correctNull((String)hshRequestValues.get("hid_parentid"));
					String hidslno="";
					if(!hid_parentid.equals("0"))
					{
						strSno=Helper.correctNull((String)hshRequestValues.get("hid_parentid"));
					}
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add("QC");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("strQueryId","upd_queryclosedetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					sbAuditTrial=new StringBuilder();
					strValDescnewAudit="Query Closed";	
					sbAuditTrial.append("~Organisation Code = ").append(Helper.correctNull((String)arrOldAudit.get(1))).append("~Query = ").append(Helper.correctNull((String)arrOldAudit.get(3)))
					.append("~Query Created By = ").append((Helper.correctNull((String)arrOldAudit.get(6)))+"-"+ Helper.correctNull((String)arrOldAudit.get(4))).append("~Created On = ").append(Helper.correctNull((String)arrOldAudit.get(5)))
					.append("~Query Status = ").append(strValDescnewAudit).append("~Query Raised On = ").append(Helper.correctNull((String)arrOldAudit.get(8)))
					.append("~Query Raised to Organisation = ").append(Helper.correctNull((String)arrOldAudit.get(9))).append("~Reply = ").append(Helper.correctNull((String)arrOldAudit.get(14)))
					.append("~Query Replied By = ").append((Helper.correctNull((String)arrOldAudit.get(10)))+"-"+ Helper.correctNull((String)arrOldAudit.get(15))).append("~Query Replied On = ").append(Helper.correctNull((String)arrOldAudit.get(11)))
					.append("~Query Closed By = ").append((Helper.correctNull((String)hshRequestValues.get("strUserId")))+"-"+Helper.correctNull((String)hshRequestValues.get("strUserName"))).append("~Query Closed On = ").append(Helper.getCurrentDateTime());

					
					if(!hid_parentid.equals("0"))
					{
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add("QC");
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("strQueryId","upd_queryclosedetails_child");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
				}
				else if(strhidAction.equalsIgnoreCase("ReOpenQuery"))
				{
					
					
					
				}
				
				hshRequestValues=getQueryData(hshRequestValues);
				
				if(strhidAction.equalsIgnoreCase("reply"))
					hshValues.put("strStatus", "Reply");
				else if(strhidAction.equalsIgnoreCase("CloseQuery"))
					hshValues.put("strStatus", "CloseQuery");
				else if(strhidAction.equalsIgnoreCase("ReOpenQuery"))
					hshValues.put("strStatus", "ReOpenQuery");
				
				AuditTrial.auditNewLog1(hshValues,"555",strAppno,sbAuditTrial.toString(),sbOldAudit.toString(),strSno);	
			}catch (Exception e) {
				throw new EJBException("Exception caught in UpdateQueryDetails Method ===" + e.getMessage());
			}
			
			return hshValues;
	}
	
}