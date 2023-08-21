package com.sai.laps.ejb.AgriDigitalAppInterface;

import org.apache.log4j.Logger;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.AgriDigitalAppInterface.AgriDigitalAppInterfaceRemote;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgriDigitalAppInterfaceBean", mappedName = "AgriDigitalAppInterfaceHome")
@Remote (AgriDigitalAppInterfaceRemote.class)
public class AgriDigitalAppInterfaceBean extends BeanAdapter {

	 static Logger log = Logger.getLogger(AgriDigitalAppInterfaceBean.class);

public HashMap UpdateAgriLarService(HashMap hshValues)	{
		
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		ResultSet rs=null, rs1=null;
		String strQuery="",strInwardno="";
		String strAction=Helper.correctNull((String)hshValues.get("strInwardAction"));

		try
		{
			
			//userid from organisation
			String strUserId="";
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));				
			}
			//system user
			String strSystemUserId="SYSUSR";
			String strleadgenId=correctNull((String)hshValues.get("strleadGeneratedAgentId"));
			String strbsadsaname="",strorgscode="",strCanvassedby="",bsaordsa="";
			String strleadConvertedBy=correctNull((String)hshValues.get("strleadConvertedBy"));
			/*String banbkscheme=Helper.correctNull((String)hshValues.get("sel_bankscheme"));
			if(banbkscheme.equals("003"))
			{
				if(strleadgenId.equals(""))
					strCanvassedby="Y";
				else
					strCanvassedby="N";
			}
			else
			{
				strCanvassedby="NP";
			}
			*/
			if(!strleadgenId.equals(""))
			{
				bsaordsa=strleadgenId.substring(0,3);
				strQuery = SQLParser.getSqlQuery("sel_BSADSA_agentname^"+strleadgenId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 strbsadsaname = Helper.correctNull((String)rs.getString("BSADSA_NAME"));			
				}
				String [] strname=strbsadsaname.split("-");
				String regionname=strname[1].trim();
				strQuery = SQLParser.getSqlQuery("sel_orgscode_RO^"+regionname);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strorgscode = Helper.correctNull((String)rs.getString("org_scode"));				
				}
				strCanvassedby="N";
			}
			else if( strleadgenId.equals("") && !strleadConvertedBy.equals(""))
			{
				strCanvassedby="Y";
			}
			else if(strleadgenId.equals("") && (strleadConvertedBy.equals("")))
			{
				strCanvassedby="NP";
			}


				InwardRegisterBean inwardreg=new InwardRegisterBean();
				strInwardno=inwardreg.getMaxInwardno(strSolid);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_msmelarappinward");
				arrValues.add(strInwardno);//1 inward_no
				arrValues.add("a");//2 inward_sector
				
				arrValues.add(correctNull((String)hshValues.get("txt_appdate")));//4 inward_appliedon
				arrValues.add(correctNull((String)hshValues.get("strFname")).toUpperCase());//5 inward_custname
				arrValues.add(correctNull((String)hshValues.get("selcusttype")));//6 inward_borrowertype --> new/old
				arrValues.add(correctNull((String)hshValues.get("txt_cbscustid")));//7 inward_cbscustid 
				
				arrValues.add(correctNull((String)hshValues.get("txt_comcustadd1")));//8 inward_add1
				arrValues.add(correctNull((String)hshValues.get("txt_comcustadd2")));//9 inward_add2
				arrValues.add(correctNull((String)hshValues.get("hidcity")));// 10 inward_city
				arrValues.add(correctNull((String)hshValues.get("hid_state")));//11 inward_states
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_zip")));//12 inward_zipcode
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_phone")));//13 inward_phone
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_mobile")));//15 inward_mobile
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_email")));//16 inward_email
				arrValues.add(correctNull((String)hshValues.get("strbussnissdate")));//17 inward_dob
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_pan")).toUpperCase());//18 inward_pantan
				arrValues.add(correctNull((String)hshValues.get("txt_comloanpur")).toLowerCase());//19 inward_purpose 
				//arrValues.add(correctNull((String)hshValues.get("txtret_ftf")));//21 inward_termloanamt
				arrValues.add(correctNull((String)hshValues.get("txt_receidate")));//25 inward_docreceivedon
				arrValues.add(correctNull((String)hshValues.get("seldocrecd")));//26 inward_docreceived
				arrValues.add(correctNull((String)hshValues.get("strapplProcessLoc")));//27 inward_applnprocessat --> 1�Branch/6�RLPC 

				arrValues.add(strSolid);//28 inward_orgscode
				arrValues.add(strSystemUserId);//29 inward_usrid
				arrValues.add("A");//30 inward_valuesin
				arrValues.add(strSystemUserId);//31 inward_modifiedby
				//arrValues.add("13/08/2019");
				arrValues.add("N");//33 inward_appliedfor
				arrValues.add("C");//34 inward_proptype
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));//39 District

				arrValues.add(correctNull((String)hshValues.get("selapplstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_rejreason")));
				//arrValues.add("t");// Term loan
				//arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));//
				arrValues.add("2"); //Govt sponser scheme -> default no
				arrValues.add(strCanvassedby); //Canvasasedby -not appllicable
				arrValues.add(correctNull((String)hshValues.get("selborrowerstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_leadno")).toUpperCase());
				arrValues.add("Y");
				//arrValues.add(correctNull((String)hshValues.get("strAddchangeFlag")));
				//arrValues.add(correctNull((String)hshValues.get("strschemeDesc")));

				arrValues.add(correctNull((String)hshValues.get("strdigiAppNo")));
				arrValues.add(bsaordsa);
				arrValues.add(strorgscode);
				arrValues.add(strleadgenId);
				arrValues.add(correctNull((String)hshValues.get("strleadConvertedBy")));
				arrValues.add(correctNull((String)hshValues.get("strleadStaffId")));
				
				arrValues.add(correctNull((String)hshValues.get("workingCapital")));
				arrValues.add(correctNull((String)hshValues.get("whetherTinyInd")));
				arrValues.add(correctNull((String)hshValues.get("whetherSSI")));
				arrValues.add(correctNull((String)hshValues.get("termLoan")));
				arrValues.add(correctNull((String)hshValues.get("nonFundBased")));
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				hshValues.put("strInwardno", strInwardno);
				hshValues.put("strResponseCode", "LAPS-3006");
				hshValues.put("strResponseMsg", "LAR Created Successfully");

		}
		catch(Exception e)
		{
			throw new EJBException("Error in AgriDigitalAppInterface Bean UpdateAgriLarService..."+e.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
			} catch (Exception e) 
			{
				throw new EJBException("Error in AgriDigitalAppInterface Bean UpdateAgriLarService closing Connection ..."+e.toString());
			}
		}
		return hshValues;		
	}


// AGRICULTURE PROPOSAL CREATION 

public HashMap AgriProposalCreation(HashMap hshValues)  
{
	
	ResultSet rs=null,rs1=null,rs2=null;
	HashMap hshformula =  new HashMap();//mck

	String strAppno="",strQuery="";
	String strLAPSid="",strperappOldID="";
		int intUpdatesize=0;
		HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshRecord=  new HashMap();
	String strLimitId="",strMsg="",mclrtabcode="",mclrtype="",strFACILITY_SANCAMT="",strCBS_ACCOUNTNO="";
	ArrayList arrRepaySchedule=new ArrayList();
	ArrayList arrrescheduleData=new  ArrayList();
	
		
	try
	{
		
		String strBorrowId=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
		String strCustomerID=Helper.correctNull((String)hshValues.get("strcbsId"));
		String strSolid=Helper.correctNull((String)hshValues.get("strapplicationBranch"));
		
		Date date1;
		Date date2;
		String strDate = ApplicationParams.getStrCLPCdate();
		SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
		date1 = CLPCdate.parse(strDate);
		String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		date2 = CLPCdate.parse(NOwCalender);
		String strsolidMang = strSolid,strsolidOf850="";
		
		if (date1.before(date2))
		{
			strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strSolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strsolidorg  = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strQuery = SQLParser.getSqlQuery("sel_scode^"+strsolidorg);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
					strsolidOf850  = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					if (strsolidOf850.equalsIgnoreCase("850")){
						strsolidMang="600";}
					}
			}
		}
		
		//strlapsCustomerId
		strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
			strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
		}
		
		if(strLAPSid.equals(""))
		{
			strLAPSid=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
			strperappOldID=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
		}
		
		
		// appno generation
		String strType="A";//mck     //shiva change "C" to "A"
		hshformula.put("comapp_id",strBorrowId);//mck
		hshformula.put("apptype",strType);//mck
		hshformula.put("strSolid",strSolid);//mck
		strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
		hshValues.put("appno",strAppno);	
		
		
		
		strLimitId=Helper.correctNull((String)hshValues.get("FacilityDescription"));
		
		
		if(rs!=null)rs.close();
		strQuery = SQLParser.getSqlQuery("sel_corpdigiprd^"+strLimitId);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLimitId=Helper.correctNull((String)rs.getString("COM_FACID"));
		}
		
		
		//system user
		String strSysteUserId="SYSUSR";
		String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="",strissaral="",strFinancialReq="",strUserDepartment="",strRLPFUser="",stramberExits="",
		strUserIdClpu="",strOrgLevelClpu="",strscheme="",STRCLPHAV="";
		String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
		String	strlarNo= Helper.correctNull((String)hshValues.get("strlarNo"));
		stramberExits= Helper.correctNull((String)hshValues.get("stramberExits"));
		strscheme= Helper.correctNull((String)hshValues.get("strscheme"));
		
		strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strSolid);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			strUserDepartment = Helper.correctNull((String)rs.getString("USR_DEPARTMENT"));
			strRLPFUser = Helper.correctNull((String)rs.getString("USR_RLPFTYPE"));
			
		}
		
		if(!strscheme.equalsIgnoreCase(""))
		{
			strQuery = SQLParser.getSqlQuery("sel_staticclph^"+strscheme);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				STRCLPHAV = Helper.correctNull((String)rs.getString("STATIC_SENDTOCLPH"));
			}
		}
		
		if(STRCLPHAV.equalsIgnoreCase("Y"))
		{
		strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strsolidMang);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgLevelClpu = Helper.correctNull((String)rs.getString("ORG_LEVEL"));
			strUserIdClpu = Helper.correctNull((String)rs.getString("USR_ID"));
		}
		}else{
		
		strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strUserIdClpu = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	

		}
		}
		
		//application table
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		intUpdatesize = intUpdatesize+1;
		hshQuery.put("strQueryId","insapplications_digi");
		arrValues.add(strAppno);
		arrValues.add(strLimitId);
		arrValues.add(strSysteUserId);
		arrValues.add(strOrgCode);
		arrValues.add("A");			//shiva change "C" to "A"
		arrValues.add(strlarNo);
		arrValues.add("R");
		//arrValues.add((strOrgLevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrgLevel);
		arrValues.add(strOrgLevel);
		arrValues.add(strUserIdClpu);
		arrValues.add("Y");
		arrValues.add(null);
		arrValues.add(null);
		arrValues.add(null);
		arrValues.add(strFinancialReq);
		arrValues.add("PA");			//shiva change "PC" to "PA"
		arrValues.add(stramberExits);
		arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
		arrValues.add("");

		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size",Integer.toString(intUpdatesize));
		hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
		
		
		/*hshQuery = new HashMap();
		arrValues=new ArrayList();
		intUpdatesize = intUpdatesize+1;
		hshQuery.put("strQueryId","updatefacilityrenewflag");
		arrValues.add("F");
		arrValues.add(correctNull(strAppno));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size",Integer.toString(intUpdatesize));
		hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
		
		String strFinStd="0",strIndType="",strIndRating="";

	/*	if(rs!=null)rs.close();
		rs=DBUtils.executeLAPSQuery("selcmabycomappid^"+strBorrowId);
		if(rs.next())
		{
			strFinStd =rs.getString("cma_no");
		}*/
		
		strFinStd=Helper.correctNull((String)hshValues.get("strfinId"));
		
		// Starts updation for com_demographics table
		hshQuery = new HashMap();
		arrValues=new ArrayList();
		intUpdatesize = intUpdatesize+1;
		hshQuery.put("strQueryId","commapplicantloanins2");
		arrValues.add(strAppno);


		if(strBorrowId.trim().equals(""))
		{
			strBorrowId="0";
		}
		arrValues.add(strperappOldID);
		arrValues.add(strFinStd);
		arrValues.add(strIndType);
		arrValues.add(strIndRating);
		arrValues.add("N");
		arrValues.add(strLAPSid);//for inserting customer new renewal id added by tharani for solving modify probelm
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size",Integer.toString(intUpdatesize));
		hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
		
			
			SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
            Calendar calendar = Calendar.getInstance();
            String strDay = dateFormat.format(calendar.getTime());
            
			//workflow Mailbox
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strAppno);
			arrValues.add(strSysteUserId);
			arrValues.add(strSysteUserId);
			arrValues.add("1");
			arrValues.add("1");
			arrValues.add(strDay);
			arrValues.add("A");				//shiva change "C" to "A"
			arrValues.add("001");
			arrValues.add("");
			arrValues.add("001");
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			calendar.add(Calendar.SECOND,5);
	        strDay = dateFormat.format(calendar.getTime());
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strAppno);
			arrValues.add(strSysteUserId);
			arrValues.add(strUserIdClpu);
			arrValues.add("1");
			arrValues.add("2");
			arrValues.add(strDay);
			arrValues.add("A");						//shiva change "C" to "A"
			arrValues.add("001");
			arrValues.add("");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
		
			//For Updating in inward register

			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add("op");
			arrValues.add(strlarNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			String strLoanAmt=Helper.correctNull((String)hshValues.get("strproopsedLimit"));
			
			//loandetails table
			
			
			
			
		/*	String intfacMonths=Helper.correctInt((String)hshValues.get("strtenor"));
			String strBPLR=Helper.correctNull((String)hshValues.get("strinterestRate"));
			String strPropbnktype=Helper.correctNull((String)hshValues.get("strproposedBankArrngmnt"));
			String strPurpose=Helper.correctNull((String)hshValues.get("strpuropse"));
			String strIntType=Helper.correctNull((String)hshValues.get("strinterestType"));
			String strGovtsponsschem=Helper.correctNull((String)hshValues.get("strgovtSponserScheme"));
			String strRepayType=Helper.correctNull((String)hshValues.get("strpaymentMode"));
			String strHolidayPeriod=Helper.correctNull((String)hshValues.get("strinitialHoliday"));
			String strMarginTerms=Helper.correctNull((String)hshValues.get("strmargin"));
			String strModeOfPay=Helper.correctNull((String)hshValues.get("strpaymentMode"));
			String strOperativeAccountNo=Helper.correctNull((String)hshValues.get("stroperativeAccNumber"));
			String strPerInstall=Helper.correctNull((String)hshValues.get("strperiodInstallment"));
			String strfacSubIntType=Helper.correctNull((String)hshValues.get("strinterestSubType"));
			String strdisplaydesc=Helper.correctNull((String)hshValues.get("strprocessNoteDesc"));
			String strMetLifeInsurance=Helper.correctNull((String)hshValues.get("strsinglePremium"));*/
			// facility table
								
			ArrayList facilityDetails=new ArrayList();
			ArrayList arrfacilitydetails=new ArrayList();
			facilityDetails=(ArrayList) hshValues.get("arrayFacilityDetails");
			
			int arrfacLen=facilityDetails.size();
			
			if(arrfacLen>0)
			{
				for(int i=0;i<arrfacLen;i++)
				{
					arrfacilitydetails=(ArrayList) facilityDetails.get(i);						
					
					strLimitId=(String) arrfacilitydetails.get(22);
					String repayType=arrfacilitydetails.get(16)+"@";
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_corpdigiprd_tenor^"+strLimitId+"^"+arrfacilitydetails.get(4)+"^"+arrfacilitydetails.get(33)+"^"+repayType);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLimitId=Helper.correctNull((String)rs.getString("COM_FACID"));
					}
					if(rs!=null)rs.close();
					if(arrfacilitydetails.get(0).equals("2"))
					{
						strQuery = SQLParser.getSqlQuery("sel_ExtSancAmnt^"+arrfacilitydetails.get(36)+"^"+arrfacilitydetails.get(37));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFACILITY_SANCAMT=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
							strCBS_ACCOUNTNO=Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
						}
					}
					
					String strFacHead="",strSubFac="",strFacilityDetails="",strComFacNAture="",strcomLoanAcc="";
					if(rs!=null)rs.close();
					rs=DBUtils.executeLAPSQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strLimitId);
					if(rs.next())
					{
						strFacHead = Helper.correctNull((String)rs.getString("com_headfac"));
						strSubFac = Helper.correctNull((String)rs.getString("com_subfac"));		
						strFacilityDetails=Helper.correctNull((String)rs.getString("COM_FACID"))+"-"+
											Helper.correctNull((String)rs.getString("COM_RANGEFROM"))+"-"+Helper.correctNull((String)rs.getString("COM_RANGETO"))+"-"+
											Helper.correctNull((String)rs.getString("COM_MINREPAYPERIOD"))+"-"+Helper.correctNull((String)rs.getString("COM_MAXREPAYPERIOD"));
											
					}
							if(rs!=null)rs.close();
							rs=DBUtils.executeLAPSQuery("sel_FacNat_loanacc^"+strLimitId);
							if(rs.next())
							{
								strComFacNAture=Helper.correctNull((String)rs.getString("com_facnature"));
								strcomLoanAcc=Helper.correctNull((String)rs.getString("com_loanacc"));
							}
//select com_headfac,com_subfac,com_facdesc,com_facility_loantype,com_facdispdesc
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","insfacility_details");								
					arrValues.add(correctNull(strAppno));//1
					arrValues.add(correctNull(strFacHead));//2
					arrValues.add(correctNull(strSubFac));//3
					arrValues.add(correctNull(strperappOldID));//4
					if(arrfacilitydetails.get(0).equals("2"))
					{
						arrValues.add(strFACILITY_SANCAMT);//6facility_existing	
					}
					else{
						arrValues.add("0");//6facility_existing
					}
					arrValues.add(arrfacilitydetails.get(12));//6-facility_proposed
					arrValues.add("");//5
					
					
					//arrValues.add("0");//7
					//arrValues.add(correctNull(strIntadjust));
					arrValues.add(arrfacilitydetails.get(28));//8
					arrValues.add(arrfacilitydetails.get(29));//9
					arrValues.add(arrfacilitydetails.get(10));//10
					arrValues.add(arrfacilitydetails.get(1));//11
					arrValues.add(arrfacilitydetails.get(4));//12	
					/*
					arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("type"));//2
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("adhocType"));//3
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityOfAdhoc"));//4
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestType"));//5
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("tenor"));//6
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proposedBankArrngmnt"));//7
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("paymentMode"));//8
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("periodInstallment"));//9
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("margin"));//10
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("dueDate"));//11
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("irregularities"));//12
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("govtSponserScheme"));//13
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proopsedLimit"));//14
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("singlePremium"));//15
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestSubType"));//16
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("initialHoliday"));//17
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("repaymentType"));//18
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestRate"));//19
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("puropse"));//20
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("borrowerFreshLimit"));//21
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("processNoteDesc"));//22
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("detailsAsOn"));//23
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityDescription"));//24
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("operativeAccountNo"));//25
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmntFundedBy"));//26
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmount"));//27
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("premiumTenor"));//28
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("loanAmountCovered"));//29
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilitySno"));//30
		arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityGroup"));//31				
					*/
					
					//arrValues.add(correctNull(strInterest));//mck
					arrValues.add("");//13
					//arrValues.add(correctNull(strMargin));
					arrValues.add(arrfacilitydetails.get(17));//added by suresh for inserting BPLR 14
					//arrValues.add(correctNull(strDP));
					//arrValues.add(correctNull(strOutstanding));
					//arrValues.add(correctNull(strSecurity));
					//arrValues.add(correctNull(strcbsaccno));
					//arrValues.add(correctNull(strfacilityintremarks));
					arrValues.add(Helper.getCurrentDateTime());//15
					//arrValues.add(correctNull(strExistbnktype));
					arrValues.add((arrfacilitydetails.get(5)));//16
					arrValues.add(arrfacilitydetails.get(18));//17
					//added by bhaskar								
					arrValues.add(arrfacilitydetails.get(3));//18							
					arrValues.add((arrfacilitydetails.get(11)));//19
					arrValues.add("0");//20
					arrValues.add("0");//21
					arrValues.add("0");	//22
					arrValues.add("0");//23
					arrValues.add((arrfacilitydetails.get(16)));//24
					arrValues.add(correctNull(strLimitId));//25
					arrValues.add(strFacilityDetails);//26strFacDetails
					arrValues.add("");//27stragrSchemeType
					arrValues.add(arrfacilitydetails.get(15));//28	holidayPeriod
					arrValues.add(arrfacilitydetails.get(35));//29
					if(arrfacilitydetails.get(34).equals("s") || arrfacilitydetails.get(34).equals("y"))
					{
						arrValues.add("1"); //interest charged 
					}
					else
					{
						arrValues.add("2");  //interest charged 
					}
					arrValues.add((arrfacilitydetails.get(8)));//31
					arrValues.add(arrfacilitydetails.get(6));//32								
					arrValues.add(arrfacilitydetails.get(23));//33
					arrValues.add("");	//34
					arrValues.add(arrfacilitydetails.get(7));//35
					arrValues.add(arrfacilitydetails.get(14));//36
					arrValues.add(""); //37
					arrValues.add("");//38
					if(arrfacilitydetails.get(0).equals("2"))
					{
						arrValues.add(strCBS_ACCOUNTNO);//6	
					}
					else{
						arrValues.add("");//6
					}
					arrValues.add(arrfacilitydetails.get(17));//40
					arrValues.add(arrfacilitydetails.get(12));//41
					arrValues.add(strComFacNAture);//42
					arrValues.add("N");//43
					arrValues.add(arrfacilitydetails.get(17));//44
					arrValues.add("");//45
					arrValues.add(arrfacilitydetails.get(0));//46 sel_type
					arrValues.add(arrfacilitydetails.get(19));//47 borrowerfreshlimit
					arrValues.add(strcomLoanAcc);//48
					if(arrfacilitydetails.get(0).equals("2"))
					{
						arrValues.add("R");//49 FACILITY_TYPEFOR
					}
					else{
						arrValues.add("F");//49 FACILITY_TYPEFOR
					}
					//arrValues.add("F");	//49
					arrValues.add(""); //50
					arrValues.add(arrfacilitydetails.get(20)); //51
					arrValues.add("op"); //52
					if(arrfacilitydetails.get(0).equals("1"))
					{
						arrValues.add(""); //53
					}
					else
					{
						arrValues.add("Y"); //53
					}
					
					arrValues.add(""); //54
					arrValues.add("");	//FACILITY_CONVERSION_FAC
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(arrfacilitydetails.get(25));
					/*arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");*/
					arrValues.add("");
					arrValues.add(arrfacilitydetails.get(26));
					arrValues.add(arrfacilitydetails.get(27));
					arrValues.add("");
					arrValues.add(arrfacilitydetails.get(13));
					arrValues.add(arrfacilitydetails.get(24));
					arrValues.add(arrfacilitydetails.get(36));
					arrValues.add(arrfacilitydetails.get(37));
					arrValues.add("O");
					arrValues.add(arrfacilitydetails.get(38));
					arrValues.add(arrfacilitydetails.get(39));
					arrValues.add(arrfacilitydetails.get(40));
					arrValues.add(arrfacilitydetails.get(41));
					arrValues.add(arrfacilitydetails.get(42));
					
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
					//hshQueryValues.put(""+intUpdatesize, hshQuery);
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
					
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+arrfacilitydetails.get(32));
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
			}
			
			// mclrtype=Helper.correctNull((String)hshValues.get("strReferenceType"))+"@"+arrfacilitydetails.get(31)+"@"+mclrtabcode;

			 /*	hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_mclrspread_facility_prop");
				arrValues.add(strAppno);
				arrValues.add(mclrtype);
				arrValues.add(arrfacilitydetails.get(30));
				arrValues.add(arrfacilitydetails.get(31));
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
					 
			
				// arrRepaySchedule=new ArrayList();
				// arrrescheduleData=new  ArrayList();
				arrRepaySchedule.add(arrfacilitydetails.get(34));
				//arrrescheduleData.add(arrRepaySchedule);
	
				if(arrfacilitydetails.get(0).equals("2"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updaterenewfacility");
					arrValues.add("Y");
					arrValues.add((String) arrfacilitydetails.get(36)); //old proposal number
					arrValues.add((String) arrfacilitydetails.get(37)); //old proposal sno
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					//hshQueryValues.put(""+intUpdatesize, hshQuery);
				}
				String typeOfFac = (String)arrfacilitydetails.get(0);
				 if(typeOfFac.equals("2"))
					{
						hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updatefacilityrenewflag");
					arrValues.add("R"); //APP_RENEW_FLAG
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
		}
	}
			
			//strMetLifeInsurance	
			//ended
			if(rs != null)
			{
				rs.close();
			}	
			
			/*hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			*/
			//Proposal values

			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","commapplicantloanins3");
			arrValues.add(strAppno);
			arrValues.add("0");
			arrValues.add("0");
			arrValues.add(arrfacilitydetails.get(12));
			arrValues.add(arrfacilitydetails.get(12));
			arrValues.add(arrfacilitydetails.get(12));
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
			arrValues.add("R");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); added
			
			
			//basic info tab
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","ins_basicinfo_digicorp");
			arrValues.add(correctNull(strAppno));
			arrValues.add(Helper.correctNull((String)hshValues.get("proposalFormat")));
			arrValues.add("01");//COM_SANCAUTHORITY
			arrValues.add("s");//COM_SANCDEPT
			arrValues.add("02");//COM_SACTIONLEVEL
			arrValues.add(Helper.correctNull((String)hshValues.get("prioritysector")));
			arrValues.add("R");//COM_AMOUNTVALUE
			arrValues.add(Helper.correctNull((String)hshValues.get("cfrVerified")));
			arrValues.add("N");//COM_CFR_BORNAME
			arrValues.add(Helper.correctNull((String)hshValues.get("cersaiChecked")));
			arrValues.add(Helper.correctNull((String)hshValues.get("processingCharges")));
			hshQuery.put("arrValues",arrValues);
			/*hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//coapplicant/guarantor tab
			ArrayList arrcoapp=new ArrayList();
			ArrayList arrcoappval=new ArrayList();
			arrcoapp=(ArrayList) hshValues.get("arrcoapp");
			
			int arrcoapplen=arrcoapp.size();
			
			if(arrcoapplen>0)
			{
				for(int i=0;i<arrcoapplen;i++)
				{
					arrcoappval=(ArrayList) arrcoapp.get(i);
					
					String cbsid=Helper.correctInt((String)arrcoappval.get(3));
					String perapppid=Helper.correctInt((String)arrcoappval.get(2));
					String strOldid="";
					strQuery=SQLParser.getSqlQuery("perapplicant_selcbsid^"+cbsid);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strOldid=Helper.correctNull((String)rs.getString("perapp_oldid"));
						perapppid=Helper.correctNull((String)rs.getString("perapp_id"));
					}	
					if(strOldid.equals(""))
					{
						strOldid=perapppid;
					}
					
					String strfname="",strlname="",strgender="";
					String CON_COMADDR1="",CON_COMADDR2="",CON_COMCITY="",CON_COMSTATE="",CON_COMZIP="",CON_COMPHONE="",CON_MOBILE="",CON_EMAIL="";
					strQuery=SQLParser.getSqlQuery("sel_cbsIdCreation^"+perapppid);
					rs=DBUtils.executeQuery(strQuery);	
					if(rs.next())
					{
						strgender=Helper.correctNull((String)rs.getString("PERAPP_SEX"));
						strfname=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
						strlname=Helper.correctNull((String)rs.getString("PERAPP_LNAME"));
						CON_COMADDR1=Helper.correctNull((String)rs.getString("CON_COMADDR1"));
						CON_COMADDR2=Helper.correctNull((String)rs.getString("CON_COMADDR2"));
						CON_COMCITY=Helper.correctNull((String)rs.getString("CON_COMCITY"));
						CON_COMSTATE=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
						CON_COMZIP=Helper.correctNull((String)rs.getString("CON_COMZIP"));
						CON_COMPHONE=Helper.correctNull((String)rs.getString("CON_COMPHONE"));
						CON_MOBILE=Helper.correctNull((String)rs.getString("CON_MOBILE"));
						CON_EMAIL=Helper.correctNull((String)rs.getString("CON_EMAIL"));
					}
					
					//Finacle relation type
					/*String strfinacletype="";
					if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("c"))
					{
						strfinacletype="J";
					}
					else
					{
						strfinacletype=Helper.correctNull((String)arrcoappval.get(1));
					}*/
					
					//hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					intUpdatesize++;//added
					hshQuery.put("strQueryId", "ins_coapp_digi");
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(perapppid);
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
					arrValues.add(strfname);
					arrValues.add(strlname);
					arrValues.add(CON_COMADDR1);
					arrValues.add(CON_COMADDR2);
					arrValues.add(CON_COMCITY);
					arrValues.add(CON_COMSTATE);
					arrValues.add(CON_COMZIP);
					arrValues.add(CON_MOBILE);
					arrValues.add(CON_COMPHONE);
					arrValues.add(CON_EMAIL);
					arrValues.add(strgender);
					arrValues.add(perapppid);
					arrValues.add(strOldid);
					arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));
					arrValues.add(Helper.correctNull((String)arrcoappval.get(6)));
					arrValues.add(Helper.correctNull((String)arrcoappval.get(7)));
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));
					hshQuery.put("arrValues", arrValues);
					//hshQueryValues.put("1", hshQuery);
					//hshQueryValues.put(""+intUpdatesize, hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					/*hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				}
			}
			
			
			//hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;//added
			hshQuery.put("strQueryId", "ins_comments");
			arrValues.add(strAppno);
			arrValues.add("1");
			arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryProcesnote")));
			arrValues.add("brief");
			hshQuery.put("arrValues", arrValues);
			//hshQueryValues.put("1", hshQuery);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;//added
			hshQuery.put("strQueryId", "ins_comments");
			arrValues.add(strAppno);
			arrValues.add("2");
			arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryAnnexure")));
			arrValues.add("brief1");
			hshQuery.put("arrValues", arrValues);
			//hshQueryValues.put("2", hshQuery);
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;//added
			hshQuery.put("strQueryId", "ins_comments");
			arrValues.add(strAppno);
			arrValues.add("3");
			arrValues.add(Helper.correctNull((String)hshValues.get("briefHistorySourcing")));
			arrValues.add("brief2");
			hshQuery.put("arrValues", arrValues);
			/*hshQueryValues.put("3", hshQuery);
			hshQueryValues.put("size", "3");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			ArrayList arrManginfo=new ArrayList();
			ArrayList arrManginfoval=new ArrayList();
			arrManginfo=(ArrayList) hshValues.get("arrmanginfo");
			
			int arrManginfolen=arrManginfo.size();
			
			if(arrManginfolen>0)
			{
				for(int i=0;i<arrManginfolen;i++)
				{
					arrManginfoval=(ArrayList) arrManginfo.get(i);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId", "ins_comments");
					arrValues.add(strAppno);
					arrValues.add(arrManginfoval.get(0));
					arrValues.add(arrManginfoval.get(1));
					arrValues.add("MangementInfo");
					hshQuery.put("arrValues", arrValues);
					
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					//hshQueryValues.put(""+intUpdatesize, hshQuery);
					//hshQueryValues.put(String.valueOf(i+1), hshQuery); added
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				/*hshQueryValues.put("size", String.valueOf(arrManginfolen));added
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");added*/
			}
			
			
			if(Helper.correctNull((String)hshValues.get("strBirRequired")).equalsIgnoreCase("Y"))
			{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;//added
			hshQuery.put("strQueryId","ins_per_bir_facility_prop");
			arrValues.add(strAppno);
			arrValues.add("Y");
			arrValues.add(Helper.correctNull((String)hshValues.get("strSubmissionDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("strReceiptDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("strBirReportDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("strBirCharges")));
			hshQuery.put("arrValues", arrValues);
			/*hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			}
			
			else
			{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;//added
			hshQuery.put("strQueryId","ins_per_bir_facility_prop");
			arrValues.add(strAppno);
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQuery.put("arrValues", arrValues);
			/*hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			//hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			}
			


			/*strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strReferenceType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
			}
			
			 mclrtype=Helper.correctNull((String)hshValues.get("strReferenceType"))+"@"+Helper.correctDouble(Helper.correctNull((String)hshValues.get("strFixedSpread"))+"@"+mclrtabcode);
				//FACILITY_APPNO,FACILITY_MCLRTYPE,MCLR_CRP_TOTAL,MCLR_SPREAD,MCLR_MSME
			 hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_mclrspread_facility_prop");
				arrValues.add(strAppno);
				arrValues.add(mclrtype);
				arrValues.add(Helper.correctNull((String)hshValues.get("strCreditRiskPremium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strFixedSpread")));
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			 
			 
				ArrayList arrayturnover=new ArrayList();
				ArrayList arrayturnoverval=new ArrayList();
				arrayturnover=(ArrayList) hshValues.get("arrayturnover");
				int turnoverlength=arrayturnover.size();
				int turnoverSize=turnoverlength;
				if(turnoverlength>0)
				{
					for(int i=0;i<turnoverlength;i++)
					{
						arrayturnoverval=(ArrayList) arrayturnover.get(i);
						 hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_turnoverMethod");
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(i+1));
						arrValues.add(arrayturnoverval.get(0));	
						arrValues.add(arrayturnoverval.get(2));
						arrValues.add(arrayturnoverval.get(3));
						arrValues.add(arrayturnoverval.get(4));
						arrValues.add(arrayturnoverval.get(5));
						arrValues.add(arrayturnoverval.get(6));
						arrValues.add(arrayturnoverval.get(7));
						arrValues.add(arrayturnoverval.get(8));
						arrValues.add(arrayturnoverval.get(9));
						arrValues.add(arrayturnoverval.get(10));
						arrValues.add(arrayturnoverval.get(11));
						arrValues.add(arrayturnoverval.get(13));
						arrValues.add(arrayturnoverval.get(12));
						arrValues.add(arrayturnoverval.get(1));
						hshQuery.put("arrValues", arrValues);
						/*hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
						
					//	hshQueryValues.put(""+intUpdatesize, hshQuery);//added
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}					
				}
			
				int balTurnoverlength=5-turnoverlength;
				if(balTurnoverlength>0)
				{
					turnoverlength++;
					for(int j=0;j<balTurnoverlength;j++)
					{
						//hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_turnoverMethod");
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(turnoverlength++));
						arrValues.add("0.00");	
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("S");
						hshQuery.put("arrValues", arrValues);
						/*hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
						//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}
				}
				
				ArrayList arrayexpnd=new ArrayList();
				ArrayList arrayexpndvalue=new ArrayList();
				arrayexpnd=(ArrayList) hshValues.get("arrayexpenditure");
				int axpenditureLength=arrayexpnd.size();
				int axpenditureSize=axpenditureLength;
				if(axpenditureLength>0)
				{
					for(int i=0;i<axpenditureLength;i++)
					{
						arrayexpndvalue=(ArrayList) arrayexpnd.get(i);
						 hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;//added
							hshQuery.put("strQueryId","ins_expenditureMethod");
							arrValues.add(strAppno);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(arrayexpndvalue.get(0));
							arrValues.add(arrayexpndvalue.get(2));
							arrValues.add(arrayexpndvalue.get(3));
							arrValues.add(arrayexpndvalue.get(4));
							arrValues.add(arrayexpndvalue.get(5));
					    	arrValues.add(arrayexpndvalue.get(6));
							arrValues.add(arrayexpndvalue.get(7));
							arrValues.add(arrayexpndvalue.get(8));
							arrValues.add(arrayexpndvalue.get(1));
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}
				}	
				
				int balExpditureLength=5-axpenditureLength;
				if(balExpditureLength>0)
				{
					axpenditureLength++;
					for(int j=0;j<balExpditureLength;j++)
					{
						//hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_expenditureMethod");
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(axpenditureLength++));
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
				    	arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("0.00");
						arrValues.add("S");
						hshQuery.put("arrValues", arrValues);
					/*	hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
						//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}
				}
		
				ArrayList arrayapplicant=new ArrayList();
				ArrayList arrayappValue=new ArrayList();
				arrayapplicant=(ArrayList) hshValues.get("arrApplicant");
				int applicantlength=arrayapplicant.size();
				if(applicantlength>0)
				{
					for(int i=0;i<applicantlength;i++)
					{
						arrayappValue=(ArrayList) arrayapplicant.get(i);
						 hshQuery = new HashMap();
						 arrValues = new ArrayList();
						 intUpdatesize++;//added
						 hshQuery.put("strQueryId","updt_perapplicant_verification");
						 
						 arrValues.add(arrayappValue.get(1));
						 arrValues.add(arrayappValue.get(2));
						 arrValues.add(arrayappValue.get(3));
						 arrValues.add(arrayappValue.get(4));
						 arrValues.add(arrayappValue.get(5));
						 arrValues.add(arrayappValue.get(6));
						 arrValues.add(arrayappValue.get(7));
						 arrValues.add(arrayappValue.get(8));
						 arrValues.add(arrayappValue.get(9));
						 arrValues.add(arrayappValue.get(10));
						 arrValues.add(arrayappValue.get(11));
						 arrValues.add(arrayappValue.get(12));
						 arrValues.add(arrayappValue.get(13));
						 arrValues.add(arrayappValue.get(14));
						 arrValues.add(strSolid); 
						 arrValues.add(arrayappValue.get(15));
						 arrValues.add(arrayappValue.get(0));
						 hshQuery.put("arrValues", arrValues);
						/*hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
						// hshQueryValues.put(""+intUpdatesize, hshQuery);//added
						 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						
					
					}
				}
				/*String turnoverTo="",expenditureExp="",assessmentType="";
				if(turnoverSize>0){
				
					turnoverTo="TO@";
				}
				if(axpenditureSize>0){
					expenditureExp="Exp@";	
				}
				
				assessmentType=turnoverTo+expenditureExp;
				
				 hshQuery = new HashMap();
				 arrValues = new ArrayList();
				 hshQuery.put("strQueryId","com_assessmentselection_insert");
				 arrValues.add(strAppno);
				 arrValues.add(assessmentType);
				 hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				*/
				
				
				String rowId="";
				rs=DBUtils.executeLAPSQuery("sel_fin_rowid");			 
				if(rs.next())
				{
					rowId=Helper.correctNull((String)rs.getString("fin_rowid"));
				}
				
				ArrayList arrdscr=new ArrayList();
				ArrayList arrdscrValues=new ArrayList();
				arrdscr=(ArrayList) hshValues.get("arraydscr");
				int dscrLength=arrdscr.size();
				int dscrSize=dscrLength;
				if(dscrLength>0)
				{
					for(int i=0;i<dscrLength;i++)
					{	
					
					arrdscrValues=(ArrayList) arrdscr.get(i);	
					if(arrdscrValues.get(15).equals("a"))		//shiva change "C" to "A"  pending
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","ins_finDSCR");
						intUpdatesize++;//added
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
					}
				
					if(arrdscrValues.get(15).equals("u"))
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCR");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/	
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
					}	
					
					if(arrdscrValues.get(15).equals("e"))
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCR");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
					}	
					
					if(arrdscrValues.get(15).equals("p"))      //shiva change "P" to "A"  pending
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCR");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
				}	
					
					
			}	
		}
				
	
				
				ArrayList arrdscrsens=new ArrayList();
				ArrayList arrdscrsensValues=new ArrayList();
				arrdscrsens=(ArrayList) hshValues.get("arraydscrSens");
				int dscrsensLength=arrdscrsens.size();
				int dscrsensSize=dscrLength;
				if(dscrsensLength>0)
				{
					for(int i=0;i<dscrsensLength;i++)
					{	
					
						arrdscrsensValues=(ArrayList) arrdscrsens.get(i);	
					if(arrdscrsensValues.get(15).equals("a"))       		//shiva change "C" to "A" pending
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCRSensitivity");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
					}
				
					if(arrdscrsensValues.get(15).equals("u"))
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCRSensitivity");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
					}
					}	
					
					if(arrdscrsensValues.get(15).equals("e"))
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
						
					
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCRSensitivity");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add("0");
							
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}
					}	
					
					if(arrdscrsensValues.get(15).equals("p"))
					{
						for(int j=0;j<Integer.parseInt(rowId);j++)
						{
							String strRowId="";
						//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
						strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
						}
											
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;//added
						hshQuery.put("strQueryId","ins_finDSCRSensitivity");
						
							arrValues.add(strAppno);
							arrValues.add(arrdscrValues.get(14));
							arrValues.add(strRowId);
							
							arrValues.add("0");
							
							arrValues.add("0");
							arrValues.add("0");
							arrValues.add(arrdscrValues.get(j));
							arrValues.add(String.valueOf(j+1));
							arrValues.add("0");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							/*hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/	
							//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
					}
					}	
					
					
				}	
				}
				
	
				
				//RepaymentSchedule	
				//ArrayList arrRepayReschedule=new ArrayList();
				ArrayList arrrepayValue=new ArrayList();
				//arrRepayReschedule=(ArrayList) hshValues.get("arrRepaymentSchedule");
				int arrrepayScheduleSize=arrRepaySchedule.size();
				int serialNo=0;
				int facCode=1;
				for(int j=0;j<arrrepayScheduleSize;j++)
				{
				
				int repySheduleSize=((ArrayList) arrRepaySchedule.get(j)).size();
				ArrayList repayArray=new ArrayList();
				repayArray=(ArrayList) arrRepaySchedule.get(j);
				if(repySheduleSize>0)
				{
					for(int i=0;i<repySheduleSize;i++)
					{
				serialNo++;	
				arrrepayValue=(ArrayList) repayArray.get(i);
				
				
				String frequency=correctNull((String)arrrepayValue.get(0));
				String instlmntAmount=Helper.correctInt((String)arrrepayValue.get(1));
				String noInstlmnt=Helper.correctInt((String)arrrepayValue.get(2));
				String totalAmnt=Helper.correctInt((String)arrrepayValue.get(3));
				
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				intUpdatesize++;//added
				hshQuery.put("strQueryId", "ins_repaymnt_schdule");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(String.valueOf(serialNo));
				arrValues.add(String.valueOf(facCode));
				arrValues.add(frequency);
				arrValues.add(instlmntAmount);
				arrValues.add(noInstlmnt);
				arrValues.add(totalAmnt);
				arrValues.add("A");						//shiva change "P" to "A"
				hshQuery.put("arrValues", arrValues);
				/*hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));	
					}
					}		
				
				}
				
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;//added
				hshQuery.put("strQueryId","ins_assessment");
				
					arrValues.add(strAppno);
					arrValues.add("6");
					arrValues.add("<p>"+Helper.correctNull((String)hshValues.get("strAssessComment"))+"</p>");
					
					hshQuery.put("arrValues", arrValues);
					/*hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	*/		
					//hshQueryValues.put(""+intUpdatesize, hshQuery);//added
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					
					//Sunil 06/09/2020
					ArrayList arrayMicroMitra=new ArrayList();
					arrayMicroMitra=(ArrayList) hshValues.get("arraymicroMitraAssessmentValue");
			
					int arrmicroMitraiLen=arrayMicroMitra.size();
					String arrayMicroMitraDesc= "Details as on Date,Value of Stock (A),Value of Book Debt (B),Value of Creditors (C),Total of A+B-C (D),MPBF 75.0% of D (E),Loan amount applied (F),Least of E or F";
					String arrDesc[]=arrayMicroMitraDesc.split(",");
					if(arrmicroMitraiLen>0)
					{
						for(int i=0;i<arrmicroMitraiLen;i++){
						 hshQuery = new HashMap();
						 arrValues = new ArrayList();
						 intUpdatesize++;//added
						 hshQuery.put("strQueryId","ins_com_assesmentdetails");
						 arrValues.add(strAppno);
						 arrValues.add("MMithra"); 
						 arrValues.add(String.valueOf(i+1));
						 arrValues.add(arrDesc[i]);
						 arrValues.add(arrayMicroMitra.get(i));
						 arrValues.add("");
						 hshQuery.put("arrValues", arrValues);					
						 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						 hshQueryValues.put("size",Integer.toString(intUpdatesize));
							
						}
					}
					
					String turnoverTo="",expenditureExp="",assessmentType="",assessComments="",strDscr="",strMithra="",strotherAssessmentforWCDPNWCTL="",strWCDPNWCTL="";
					
					strotherAssessmentforWCDPNWCTL = Helper.correctNull((String)hshValues.get("strotherAssessmentforWCDPNWCTL"));
				
					if(turnoverSize>0){
					
						turnoverTo="TO@";
					}
					if(axpenditureSize>0){
						expenditureExp="Exp@";	
					}
					
					if(!(Helper.correctNull((String)hshValues.get("strAssessComment"))).equals(""))
						assessComments="AOA@";
					
					if(dscrSize>0)
						strDscr="DSCR@";
						
					if(arrmicroMitraiLen>0)
						strMithra="MMithra@";
					
					if(!(Helper.correctNull((String)hshValues.get("strotherAssessmentforWCDPNWCTL"))).equalsIgnoreCase(""))
						strWCDPNWCTL="AOW@";
						
					assessmentType=turnoverTo+expenditureExp+assessComments+strDscr+strMithra+strWCDPNWCTL;
					
					 hshQuery = new HashMap();
					 arrValues = new ArrayList();
					 intUpdatesize++;//added
					 hshQuery.put("strQueryId","com_assessmentselection_insert");
					 arrValues.add(strAppno);
					 arrValues.add(assessmentType);
					 hshQuery.put("arrValues", arrValues);
					/*hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
					// hshQueryValues.put(""+intUpdatesize, hshQuery);//added
					 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
					 //hshQueryValues.put("size",String.valueOf(intUpdatesize)); //added
						
						ArrayList arrayDigiRate=new ArrayList();
						arrayDigiRate=(ArrayList) hshValues.get("arradigiratingValue");
						
						int arrdigiLen=arrayDigiRate.size();
						
						if(arrdigiLen>0)
						{
						
						 hshQuery = new HashMap();
						 arrValues = new ArrayList();
						 intUpdatesize++;//added
						 hshQuery.put("strQueryId","ins_digi_rate_score");
						 arrValues.add(strAppno);
						 arrValues.add(arrayDigiRate.get(0));
						 arrValues.add(arrayDigiRate.get(1));
						 arrValues.add(arrayDigiRate.get(2));
						 arrValues.add(arrayDigiRate.get(3));
						 arrValues.add(arrayDigiRate.get(4));
						 arrValues.add(arrayDigiRate.get(5));
						 arrValues.add(arrayDigiRate.get(6));
						 arrValues.add(arrayDigiRate.get(7));
						 arrValues.add(arrayDigiRate.get(8));
						 arrValues.add(arrayDigiRate.get(9));
						 arrValues.add(arrayDigiRate.get(10));
						 hshQuery.put("arrValues", arrValues);
						
						 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
						
						}
						
						if(!strotherAssessmentforWCDPNWCTL.equalsIgnoreCase(""))
						{
						 hshQuery = new HashMap();
						 arrValues = new ArrayList();
						 intUpdatesize++;//added
						 hshQuery.put("strQueryId","ins_assessment");
						 arrValues.add(strAppno);
						 arrValues.add("20");
						 arrValues.add(strotherAssessmentforWCDPNWCTL);
						 hshQuery.put("arrValues", arrValues);
						
						 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						 hshQueryValues.put("size",Integer.toString(intUpdatesize));
						
						}
						
						ArrayList arraybussinessOperation=new ArrayList();
						ArrayList arraybussinessOperationval=new ArrayList();
						arraybussinessOperation=(ArrayList) hshValues.get("arraybussinessOperation");
						int turnbussinessOperation=arraybussinessOperation.size();
						if(turnbussinessOperation>0)
						{
							for(int i=0;i<turnbussinessOperation;i++)
							{
								
								
								 hshQuery = new HashMap();
								 arrValues = new ArrayList();
								 intUpdatesize++;//added
								 arraybussinessOperationval=(ArrayList) arraybussinessOperation.get(i);
								 hshQuery.put("strQueryId","ins_othercommentsdetails");
								 arrValues.add(strAppno);
								 arrValues.add(arraybussinessOperationval.get(0));
								 arrValues.add(arraybussinessOperationval.get(1));
								 arrValues.add(arraybussinessOperationval.get(2));
								 arrValues.add(arraybussinessOperationval.get(3));
								 arrValues.add(String.valueOf(i+1));
								 arrValues.add(arraybussinessOperationval.get(4));
								 arrValues.add(arraybussinessOperationval.get(5));
								 arrValues.add(arraybussinessOperationval.get(6));
								 arrValues.add(arraybussinessOperationval.get(7));
								 arrValues.add(arraybussinessOperationval.get(8));
								 hshQuery.put("arrValues", arrValues);
								 
								 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								 hshQueryValues.put("size",Integer.toString(intUpdatesize));
							}	
							
						}
						
						ArrayList arrayOdccLimits=new ArrayList();
						ArrayList arrayOdccLimitsval=new ArrayList();
						arrayOdccLimits=(ArrayList) hshValues.get("arrayOdccLimits");
						int OdccLimitslen=arrayOdccLimits.size();
						if(OdccLimitslen>0)
						{
							for(int i=0;i<OdccLimitslen;i++)
							{
								
								
								 hshQuery = new HashMap();
								 arrValues = new ArrayList();
								 intUpdatesize++;//added
								 arrayOdccLimitsval=(ArrayList) arrayOdccLimits.get(i);
								 hshQuery.put("strQueryId","ins_odcclimit");
								 arrValues.add(strAppno);//com_appno
								 arrValues.add(String.valueOf(i+1));//com_sno
								 arrValues.add(arrayOdccLimitsval.get(0));//com_sanclimit
								 arrValues.add(arrayOdccLimitsval.get(1));//com_crsummation
								 arrValues.add("");//com_drsummation
								 arrValues.add(arrayOdccLimitsval.get(2));//com_maxdrbal
								 arrValues.add(arrayOdccLimitsval.get(3));//com_mindrbal
								 arrValues.add(arrayOdccLimitsval.get(4));//com_maxcrbal
								 arrValues.add(arrayOdccLimitsval.get(5));//com_mincrbal
								 arrValues.add(arrayOdccLimitsval.get(6));//com_notimeexcess
								 arrValues.add(arrayOdccLimitsval.get(7));//com_noamtcheque
								 arrValues.add(arrayOdccLimitsval.get(8));//com_amount
								 arrValues.add(arrayOdccLimitsval.get(9));//COM_CREDITSUM
								 arrValues.add(arrayOdccLimitsval.get(10));//COM_DEBITSUM
								 arrValues.add(String.valueOf(i+1));//COM_YEAR_SNO
								 arrValues.add(arrayOdccLimitsval.get(11));//com_odcccomments
								 arrValues.add(arrayOdccLimitsval.get(12));//com_creditsumcomts
								 hshQuery.put("arrValues", arrValues);
								 
								 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								 hshQueryValues.put("size",Integer.toString(intUpdatesize));
							}	
							
						}
						
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData"); //added
					
	
	}
	catch(Exception e)
	{
		throw new EJBException("Error in MsmeDigitalAppInterface Bean CorpProposalCreation method..."+e.toString());
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
			throw new EJBException("Error in MsmeDigitalAppInterface Bean CorpProposalCreation closing Connection ..."+e.toString());
		}
	}
	
	return hshValues;	
	
}
	



	
}
