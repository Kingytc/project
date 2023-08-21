package com.sai.laps.ejb.MsmeDigitalAppInterface;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.jfree.util.Log;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.sai.laps.ejb.DigitalAppInterface.DigitalAppInterfaceBean;
import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MsmeDigitalAppInterfaceBean", mappedName = "MsmeDigitalAppInterfaceHome")
@Remote (MsmeDigitalAppInterfaceRemote.class)
public class MsmeDigitalAppInterfaceBean  extends BeanAdapter{
	
	static Logger log = Logger.getLogger(MsmeDigitalAppInterfaceBean.class);
	
	public HashMap updateMsmeLarService(HashMap hshValues)  
	{
		
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		ResultSet rs=null,rs1=null;
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
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));;				
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
			else if(strleadgenId.equals("") && (strleadConvertedBy.equals("")) )
			{
				strCanvassedby="NP";
			}


			
			
				
				InwardRegisterBean inwardreg=new InwardRegisterBean();
				strInwardno=inwardreg.getMaxInwardno(strSolid);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_msmelarappinward");
				arrValues.add(strInwardno);//1 inward_no
				arrValues.add("c");//2 inward_sector
				
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
			//	arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));//
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
			throw new EJBException("Error in MsmeDigitalAppInterface Bean updateMsmeLarService..."+e.toString());
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
				throw new EJBException("Error in MsmeDigitalAppInterface Bean updateMsmeLarService closing Connection ..."+e.toString());
			}
		}
		return hshValues;		
	}

	public HashMap renewalProposal(HashMap hshValues)  
	{
		
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		ResultSet rs=null,rs1=null,rs2=null,rs4=null;
		HashMap hshValue = new HashMap();
		String strrenwaldate="",strQuery="",strcustomerID="",proposalID="",facilityID="",productCode="",sanctionedDate="",straccountOpeningDate="",tenor="",
		dueDate="",companyName="",sanctionedAmount="",ORG_SCODE="",strConstitutionCode="",strMisClassificationCode="",FACILITY_ID=""; 
		HashMap hshValue1 = new HashMap();
		HashMap hshValue2 = new HashMap();
		ArrayList arrValue =new ArrayList();
		ArrayList arrValue1 =new ArrayList();
		hshValues.put("dataExist", "No");	
		ArrayList arrValue2 =new ArrayList();

		try
		{
			strrenwaldate=(correctNull((String)hshValues.get("strrenwaldate")));
			String strcustId=(correctNull((String)hshValues.get("strcustId")));
			
			if(!strcustId.equals("")){
				strQuery = SQLParser.getSqlQuery("sel_renewal_proposal_cbsid^"+strcustId);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshValues.put("dataExist", "Yes");	
					
					strcustomerID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
					proposalID=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
					facilityID=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
					productCode=Helper.correctNull((String)rs.getString("facdesc"));
					sanctionedDate=Helper.correctNull((String)rs.getString("APP_PROCESSDATE"));
					straccountOpeningDate=Helper.correctNull((String)rs.getString("LAPS_HANDOFF_TIME"));
					tenor=Helper.correctNull((String)rs.getString("facility_months"));
					dueDate=Helper.correctNull((String)rs.getString("FACILITY_DUEDATE"));
					companyName=Helper.correctNull((String)rs.getString("COMAPP_COMPANYNAME"));
					sanctionedAmount=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
					ORG_SCODE=Helper.correctNull((String)rs.getString("scode"));
					FACILITY_ID=Helper.correctNull((String)rs.getString("FACILITY_ID"));
					
					
					arrValue2=new ArrayList();
					
					strQuery = SQLParser.getSqlQuery("sel_supplementry_renewal_proposal^"+proposalID+"^"+facilityID);
					rs4 = DBUtils.executeQuery(strQuery);
					while(rs4.next())
					{
						hshValue2=new HashMap();
						hshValue2.put("customerID", Helper.correctNull((String)rs4.getString("PERAPP_CBSID")));
						hshValue2.put("proposalID", Helper.correctNull((String)rs4.getString("FACILITY_APPNO")));
						hshValue2.put("facilityID", Helper.correctNull((String)rs4.getString("FACILITY_SNO")));
						hshValue2.put("productCode", Helper.correctNull((String)rs4.getString("facdesc")));
						hshValue2.put("sanctionedDate", Helper.correctNull((String)rs4.getString("APP_PROCESSDATE")));
						hshValue2.put("accountOpeningDate", Helper.correctNull((String)rs4.getString("LAPS_HANDOFF_TIME")));
						hshValue2.put("tenor", Helper.correctNull((String)rs4.getString("facility_months")));
						hshValue2.put("dueDate", Helper.correctNull((String)rs4.getString("FACILITY_DUEDATE")));
						hshValue2.put("sanctionedAmount", Helper.correctNull((String)rs4.getString("FACILITY_SANCAMT")));
						hshValue2.put("companyName", Helper.correctNull((String)rs4.getString("COMAPP_COMPANYNAME")));
						hshValue2.put("sol_id", Helper.correctNull((String)rs4.getString("scode")));
						hshValue2.put("facilitytype", Helper.correctNull((String)rs4.getString("FACILITY_ID")));
						arrValue2.add(hshValue2);
					}	
					
					
					
					hshValue1=new HashMap();
					hshValue1.put("strcustomerID", strcustomerID);
					hshValue1.put("proposalID", proposalID);
					hshValue1.put("facilityID", facilityID);
					hshValue1.put("productCode", productCode);
					hshValue1.put("sanctionedDate", sanctionedDate);
					hshValue1.put("accountOpeningDate", straccountOpeningDate);
					hshValue1.put("tenor", tenor);
					hshValue1.put("dueDate", dueDate);
					hshValue1.put("sanctionedAmount", sanctionedAmount);
					hshValue1.put("companyName", companyName);
					hshValue1.put("sol_id", ORG_SCODE);
					hshValue1.put("facilitytype", FACILITY_ID);
					hshValue1.put("sublimit",arrValue2);			
					arrValue.add(hshValue1);			
				}
				
			}else{
				
				strQuery = SQLParser.getSqlQuery("sel_renewal_proposal^"+strrenwaldate);
				rs = DBUtils.executeQuery(strQuery);
				 
				while(rs.next())
				{
					hshValues.put("dataExist", "Yes");	
					
					strcustomerID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
					proposalID=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
					facilityID=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
					productCode=Helper.correctNull((String)rs.getString("facdesc"));
					sanctionedDate=Helper.correctNull((String)rs.getString("APP_PROCESSDATE"));
					straccountOpeningDate=Helper.correctNull((String)rs.getString("LAPS_HANDOFF_TIME"));
					tenor=Helper.correctNull((String)rs.getString("facility_months"));
					dueDate=Helper.correctNull((String)rs.getString("FACILITY_DUEDATE"));
					companyName=Helper.correctNull((String)rs.getString("COMAPP_COMPANYNAME"));
					sanctionedAmount=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
					ORG_SCODE=Helper.correctNull((String)rs.getString("scode"));
					FACILITY_ID=Helper.correctNull((String)rs.getString("FACILITY_ID"));

					arrValue2=new ArrayList();
					strQuery = SQLParser.getSqlQuery("sel_supplementry_renewal_proposal^"+proposalID+"^"+facilityID);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						hshValue2=new HashMap();
						hshValue2.put("customerID", Helper.correctNull((String)rs1.getString("PERAPP_CBSID")));
						hshValue2.put("proposalID", Helper.correctNull((String)rs1.getString("FACILITY_APPNO")));
						hshValue2.put("facilityID", Helper.correctNull((String)rs1.getString("FACILITY_SNO")));
						hshValue2.put("productCode", Helper.correctNull((String)rs1.getString("facdesc")));
						hshValue2.put("sanctionedDate", Helper.correctNull((String)rs1.getString("APP_PROCESSDATE")));
						hshValue2.put("accountOpeningDate", Helper.correctNull((String)rs1.getString("LAPS_HANDOFF_TIME")));
						hshValue2.put("tenor", Helper.correctNull((String)rs1.getString("facility_months")));
						hshValue2.put("dueDate", Helper.correctNull((String)rs1.getString("FACILITY_DUEDATE")));
						hshValue2.put("sanctionedAmount", Helper.correctNull((String)rs1.getString("FACILITY_SANCAMT")));
						hshValue2.put("companyName", Helper.correctNull((String)rs1.getString("COMAPP_COMPANYNAME")));
						hshValue2.put("sol_id", Helper.correctNull((String)rs1.getString("scode")));
						hshValue2.put("facilitytype", Helper.correctNull((String)rs4.getString("FACILITY_ID")));
						arrValue2.add(hshValue2);
					}	
					
					
					
					hshValue1=new HashMap();
					hshValue1.put("strcustomerID", strcustomerID);
					hshValue1.put("proposalID", proposalID);
					hshValue1.put("facilityID", facilityID);
					hshValue1.put("productCode", productCode);
					hshValue1.put("sanctionedDate", sanctionedDate);
					hshValue1.put("accountOpeningDate", straccountOpeningDate);
					hshValue1.put("tenor", tenor);
					hshValue1.put("dueDate", dueDate);
					hshValue1.put("sanctionedAmount", sanctionedAmount);
					hshValue1.put("companyName", companyName);
					hshValue1.put("sol_id", ORG_SCODE);
					hshValue1.put("facilitytype", FACILITY_ID);
					hshValue1.put("sublimit",arrValue2);			
					arrValue.add(hshValue1);			
				}
			}
			hshValues.put("strrenewalProposals", arrValue);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in MsmeDigitalAppInterface Bean renewalProposal Service..."+e.toString());
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
				throw new EJBException("Error in MsmeDigitalAppInterface Bean renewalProposal Service closing Connection ..."+e.toString());
			}
		}
		return hshValues;		
	}
	
	public HashMap msmeDedupeCheckService(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="";
		HashMap hshValue1 = new HashMap();
		HashMap hshValue2 = new HashMap();
		ArrayList arrValue =new ArrayList();
		ArrayList arrValue1 =new ArrayList();
		hshValues.put("dataExist", "No");	
		ArrayList arrValue2 =new ArrayList();
		try
		{
			
		String strPANno=Helper.correctNull((String)hshValues.get("strPANno"));
		String strCBSid=Helper.correctInt((String)hshValues.get("strCBSid"));
		String strApplExist="N";

		String strCusName="",strCusCBSID="",strCusFatherName="",strCustDOB="",strCustPANno="",strAppno="",strAppStatus="",strmobileno="",strBIRdate="",strappcreatedate="",
		proposalID="",strcustomerID="",facilityID="",productCode="",sanctionedDate="",straccountOpeningDate="",tenor="",dueDate="",companyName="",sanctionedAmount="";
		String applicationStatus="",facilityDesc="";
		
		if(!strPANno.equals(""))
		{
		strQuery = SQLParser.getSqlQuery("sel_mainlimit_dedupe_check^"+strPANno);
			rs = DBUtils.executeQuery(strQuery);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("sel_dedupe_cbsid^"+strCBSid);
			rs = DBUtils.executeQuery(strQuery);
		}
		//rs=DBUtils.executeLAPSQuery("sel_mainlimit_dedupe_check^"+strPANno);
		while(rs.next())
		{
			hshValues.put("dataExist", "Yes");	
			
			strcustomerID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			proposalID=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
			facilityID=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
			productCode=Helper.correctNull((String)rs.getString("facdesc"));
			sanctionedDate=Helper.correctNull((String)rs.getString("APP_PROCESSDATE"));
			straccountOpeningDate=Helper.correctNull((String)rs.getString("LAPS_HANDOFF_TIME"));
			tenor=Helper.correctNull((String)rs.getString("facility_months"));
			dueDate=Helper.correctNull((String)rs.getString("FACILITY_DUEDATE"));
			companyName=Helper.correctNull((String)rs.getString("COMAPP_COMPANYNAME"));
			sanctionedAmount=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
			applicationStatus=Helper.correctNull((String)rs.getString("FACILITY_STATUS"));
			facilityDesc=Helper.correctNull((String)rs.getString("COM_FACDESC"));
			
			arrValue2=new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_sublimit_dedupe_check^"+proposalID+"^"+facilityID);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshValue2=new HashMap();
				hshValue2.put("customerID", Helper.correctNull((String)rs1.getString("PERAPP_CBSID")));
				hshValue2.put("proposalID", Helper.correctNull((String)rs1.getString("FACILITY_APPNO")));
				hshValue2.put("facilityID", Helper.correctNull((String)rs1.getString("FACILITY_SNO")));
				hshValue2.put("productCode", Helper.correctNull((String)rs1.getString("facdesc")));
				hshValue2.put("sanctionedDate", Helper.correctNull((String)rs1.getString("APP_PROCESSDATE")));
				hshValue2.put("accountOpeningDate", Helper.correctNull((String)rs1.getString("LAPS_HANDOFF_TIME")));
				hshValue2.put("tenor", Helper.correctNull((String)rs1.getString("facility_months")));
				hshValue2.put("dueDate", Helper.correctNull((String)rs1.getString("FACILITY_DUEDATE")));
				hshValue2.put("sanctionedAmount", Helper.correctNull((String)rs1.getString("FACILITY_SANCAMT")));
				hshValue2.put("companyName", Helper.correctNull((String)rs1.getString("COMAPP_COMPANYNAME")));
				hshValue2.put("applicationStatus", Helper.correctNull((String)rs1.getString("FACILITY_STATUS")));
				hshValue2.put("facilityDesc", Helper.correctNull((String)rs1.getString("COM_FACDESC")));
				arrValue2.add(hshValue2);
			}	
			
			
			
			hshValue1=new HashMap();
			hshValue1.put("strcustomerID", strcustomerID);
			hshValue1.put("proposalID", proposalID);
			hshValue1.put("facilityID", facilityID);
			hshValue1.put("productCode", productCode);
			hshValue1.put("sanctionedDate", sanctionedDate);
			hshValue1.put("accountOpeningDate", straccountOpeningDate);
			hshValue1.put("tenor", tenor);
			hshValue1.put("dueDate", dueDate);
			hshValue1.put("sanctionedAmount", sanctionedAmount);
			hshValue1.put("companyName", companyName);
			hshValue1.put("sublimit",arrValue2);			
			hshValue1.put("applicationStatus",applicationStatus);		
			hshValue1.put("facilityDesc",facilityDesc);		
			arrValue.add(hshValue1);			
		}
		
		hshValues.put("strProposals", arrValue);
		}

		catch(Exception e)
		{
			throw new EJBException("Error in MsmeDigitalAppInterface Bean msmeDedupeCheck..."+e.toString());
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
				throw new EJBException("Error in msmeDigitalAppInterface Bean msmeDedupeCheck in  closing connection ..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	
	
	

	public HashMap msmeCustomerCreation(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="",stridDoc="",strIdNumber="",crifReportDate="";
		int querycount=0;
		try
		{
			String currdate=Helper.getCurrentDateTime();
			//dedupe
			String strDedupeFlag="N";
			String lapsoldID="",lapsID="";
			String strPANno=correctNull((String)hshValues.get("strPANNo"));
			strQuery = SQLParser.getSqlQuery("sel_dedupe_customerprofile^"+strPANno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//strDedupeFlag="Y";
				//lapsID=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			
			String strCBSid=Helper.correctNull((String)hshValues.get("strCBSID"));
			if(rs!=null)
			{   rs.close(); }
			if(!strCBSid.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCBSid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDedupeFlag="Y";
					lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
					lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
				}
			}
			
			//if(!strDedupeFlag.equals("Y"))
			{
					
				//new cust id
				String strNewLAPSid="",stroldLAPSid="",strRenewFlag="";
				rs=DBUtils.executeLAPSQuery("mastgetAppid");			 
				if(rs.next())
				{
					strNewLAPSid=Helper.correctNull((String)rs.getString(1));
				}
				
				if(strDedupeFlag.equals("Y"))
				{
					stroldLAPSid=lapsoldID;
					strRenewFlag="n";
					
					// update renew column in perapplicant table
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					querycount++;
					arrValues.add("y");
					arrValues.add(lapsID);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perapplicantupdaterenew");
					hshQueryValues.put(String.valueOf(querycount),hshQuery);
				}
				else
				{
					stroldLAPSid=strNewLAPSid;
					strRenewFlag="";
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_msmeLAPS_CustomerProfile_extAppl");
				arrValues.add(stroldLAPSid); //oldid
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strCBSID")));
				arrValues.add(correctNull((String)hshValues.get("strTitle")));
				arrValues.add(correctNull((String)hshValues.get("strFullName")));
				arrValues.add(correctNull((String)hshValues.get("strShortName")));
				arrValues.add(correctNull((String)hshValues.get("strConstitution")));
				arrValues.add(correctNull((String)hshValues.get("strDOB")));
				arrValues.add(correctNull((String)hshValues.get("strPANNo")));
				arrValues.add(correctNull((String)hshValues.get("strGender")));
				arrValues.add(correctNull((String)hshValues.get("strMaritalStatus")));
				arrValues.add(correctNull((String)hshValues.get("strStatus")));
				arrValues.add(correctNull((String)hshValues.get("strTaxSlab")));
				//arrValues.add(correctNull((String)hshValues.get("strBorrStatus")));
				arrValues.add(correctNull((String)hshValues.get("strEmployment")));
				arrValues.add(correctNull((String)hshValues.get("strBanking")));
				arrValues.add(correctNull((String)hshValues.get("strBorrowerSince")));
				arrValues.add(correctNull((String)hshValues.get("strSatisfactory")));
				arrValues.add(correctNull((String)hshValues.get("strStaffRelation")));
				arrValues.add(correctNull((String)hshValues.get("strIntroStatus")));
				arrValues.add(correctNull((String)hshValues.get("strBranchCode")));
				arrValues.add(correctNull((String)hshValues.get("strConstitution")));
				arrValues.add("Y");
				arrValues.add(correctNull((String)hshValues.get("strAddressChangeFlag")));
				arrValues.add(correctNull((String)hshValues.get("strPANflag")));
				arrValues.add(correctNull((String)hshValues.get("strfiAddressFlag")));
				arrValues.add(correctNull((String)hshValues.get("strfiEmploymentFlag")));
				arrValues.add(correctNull((String)hshValues.get("strfiBankStatFlag")));
				arrValues.add(correctNull((String)hshValues.get("stremandateEmiFlag")));//Sunil
				arrValues.add(correctNull((String)hshValues.get("stremanbankacc")));
				arrValues.add(correctNull((String)hshValues.get("stremanbankname")));
				
				if(correctNull((String)hshValues.get("strAddressChangeFlag")).equals("Y") || correctNull((String)hshValues.get("strPANflag")).equals("Y")
				|| correctNull((String)hshValues.get("strfiAddressFlag")).equals("Y") || correctNull((String)hshValues.get("strfiEmploymentFlag")).equals("Y")
				|| correctNull((String)hshValues.get("strfiBankStatFlag")).equals("Y") || correctNull((String)hshValues.get("stremandateEmiFlag")).equals("Y")
				|| correctNull((String)hshValues.get("strPermAddChangeFlag")).equals("Y") || correctNull((String)hshValues.get("strItrFlag")).equals("Y")
				|| correctNull((String)hshValues.get("strBusinessProofFlag")).equals("Y") || correctNull((String)hshValues.get("strOfficeAddFlag")).equals("Y")
				)
				{
					arrValues.add("N");
				}
				else
				{
					arrValues.add("Y");
				}
				
				arrValues.add(correctNull((String)hshValues.get("strPermAddChangeFlag")));
				
				if(Helper.correctNull((String)hshValues.get("strAddressChangeFlag")).equals("Y") ||
					Helper.correctNull((String)hshValues.get("strPermAddChangeFlag")).equals("Y") ||
					Helper.correctNull((String)hshValues.get("strPANflag")).equals("Y")
					)
				{	
					arrValues.add("Y");
				}
				else 
				{
					arrValues.add("N");
				}
				
				if( correctNull((String)hshValues.get("strfiAddressFlag")).equals("Y") || correctNull((String)hshValues.get("strfiEmploymentFlag")).equals("Y")
						|| correctNull((String)hshValues.get("strfiBankStatFlag")).equals("Y")||correctNull((String)hshValues.get("strItrFlag")).equals("Y")
						||correctNull((String)hshValues.get("strBusinessProofFlag")).equals("Y") || correctNull((String)hshValues.get("strOfficeAddFlag")).equals("Y"))
				{
					arrValues.add("Y");
				}
				else 
				{
					arrValues.add("N");
				}
				
				if(Helper.correctNull((String)hshValues.get("stremandateEmiFlag")).equals("Y"))
				{	
					arrValues.add("Y");
				}
				else 
				{
					arrValues.add("N");
				}
				arrValues.add(correctNull((String)hshValues.get("strfathername")));
				arrValues.add(correctNull((String)hshValues.get("strItrFlag")));
				arrValues.add(correctNull((String)hshValues.get("strBusinessProofFlag")));
				arrValues.add(correctNull((String)hshValues.get("strOfficeAddFlag")));
				arrValues.add(strRenewFlag);
				arrValues.add(correctNull((String)hshValues.get("strintroducerName")));
				arrValues.add(correctNull((String)hshValues.get("strshareholdingByWomen")));
				
				arrValues.add(correctNull((String)hshValues.get("strnetworthBorrower")));
				arrValues.add(correctNull((String)hshValues.get("stridenificationNo")));
				arrValues.add(correctNull((String)hshValues.get("strleiExpiryDate")));
				arrValues.add(correctNull((String)hshValues.get("strudyogAadharNumber")));
				arrValues.add(correctNull((String)hshValues.get("strmseRegNumber")));
				
				arrValues.add(correctNull((String)hshValues.get("strPartnershipDetails")));
				arrValues.add(correctNull((String)hshValues.get("strPartnershipDeed")));
				arrValues.add(correctNull((String)hshValues.get("strPartnershipRegNo")));
				arrValues.add(correctNull((String)hshValues.get("strudyamRegistrationNumber")));
				arrValues.add(correctNull((String)hshValues.get("strsalesTurnOverApplicant")));
				arrValues.add(correctNull((String)hshValues.get("strsalesTurnOverDate")));
				arrValues.add(correctNull((String)hshValues.get("strcriteriaforSalesTurnover")));
				arrValues.add(correctNull((String)hshValues.get("strudyamRegistrationClassification")));
				arrValues.add(correctNull((String)hshValues.get("strudyamDate")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_msmeindividual_info_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strResidentStatus")));
				arrValues.add(correctNull((String)hshValues.get("strReligion")));
				arrValues.add(correctNull((String)hshValues.get("strCaste")));
				arrValues.add(correctNull((String)hshValues.get("strChildDep")));
				arrValues.add(correctNull((String)hshValues.get("strOtherDep")));
				arrValues.add(correctNull((String)hshValues.get("strEarningMem")));
				arrValues.add(correctNull((String)hshValues.get("strFamilyIncome")));
				arrValues.add(correctNull((String)hshValues.get("strPhysicalChgd")));
				arrValues.add(correctNull((String)hshValues.get("strsel_Blind")));
				arrValues.add(correctNull((String)hshValues.get("strstafflag")));
				arrValues.add(correctNull((String)hshValues.get("streduqualification")));
				arrValues.add(correctNull((String)hshValues.get("strbankingArrangemnt")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
				 
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_msme_contact_info_common_customer_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strComAddress1")));
				arrValues.add(correctNull((String)hshValues.get("strComAddress2")));
				arrValues.add(correctNull((String)hshValues.get("strComCity")));
				arrValues.add(correctNull((String)hshValues.get("strComDistrict")));
				arrValues.add(correctNull((String)hshValues.get("strComState")));
				arrValues.add(correctNull((String)hshValues.get("strComCountry")));
				arrValues.add(correctNull((String)hshValues.get("strComPincode")));
				
				arrValues.add(correctNull((String)hshValues.get("strcorpAddress")));
				arrValues.add(correctNull((String)hshValues.get("strcorpCity")));
				arrValues.add(correctNull((String)hshValues.get("strcorpDistrict")));
				arrValues.add(correctNull((String)hshValues.get("strcorpState")));
				arrValues.add(correctNull((String)hshValues.get("strcorpCountry")));
				arrValues.add(correctNull((String)hshValues.get("strcorpPinCode")));
				arrValues.add(correctNull((String)hshValues.get("strResidentType")));
				String noofyears=correctNull((String)hshValues.get("strNoofYearsPresAdd"));
				arrValues.add(noofyears+"~0");
				arrValues.add(correctNull((String)hshValues.get("mobileNumber")));
				arrValues.add(correctNull((String)hshValues.get("customerEmail")));
				
				arrValues.add(correctNull((String)hshValues.get("strcorpVillage")));
				arrValues.add(correctNull((String)hshValues.get("strcorpPhoneNo")));
				arrValues.add(correctNull((String)hshValues.get("strcorpFaxNo")));
				arrValues.add(correctNull((String)hshValues.get("strcorpEMail")));
				arrValues.add(correctNull((String)hshValues.get("stradminAddress")));
				arrValues.add(correctNull((String)hshValues.get("stradminvillage")));
				arrValues.add(correctNull((String)hshValues.get("stradmincity")));
				arrValues.add(correctNull((String)hshValues.get("stradminDistric")));
				arrValues.add(correctNull((String)hshValues.get("stradminState")));
				arrValues.add(correctNull((String)hshValues.get("stradminPinCode")));
				arrValues.add(correctNull((String)hshValues.get("stradminCountry")));
				arrValues.add(correctNull((String)hshValues.get("stradminPhoneNo")));
				arrValues.add(correctNull((String)hshValues.get("stradminFaxNo")));
				arrValues.add(correctNull((String)hshValues.get("stradminwebsite")));
				
				arrValues.add(correctNull((String)hshValues.get("strAdminAddressLine2")));
				arrValues.add(correctNull((String)hshValues.get("strCorpAddressLine2")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				String emptype="";
				
				if(correctNull((String)hshValues.get("strEmployment")).equals("1")|| correctNull((String)hshValues.get("strEmployment")).equals("01"))
					emptype="Employee";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("2")||correctNull((String)hshValues.get("strEmployment")).equals("02"))
				emptype="Business Man";

				else if(correctNull((String)hshValues.get("strEmployment")).equals("3") || correctNull((String)hshValues.get("strEmployment")).equals("03"))
					emptype="Professionals";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("4")|| correctNull((String)hshValues.get("strEmployment")).equals("04"))
						emptype="Agriculture and allied activities";
						
				else if(correctNull((String)hshValues.get("strEmployment")).equals("6")|| correctNull((String)hshValues.get("strEmployment")).equals("06"))
					emptype="Trading";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("7") || correctNull((String)hshValues.get("strEmployment")).equals("07")) 
					emptype="Services";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("8") || correctNull((String)hshValues.get("strEmployment")).equals("08"))	
					emptype="Manufacturing";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("9") || correctNull((String)hshValues.get("strEmployment")).equals("09"))
					emptype="Pensioner";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("10"))	
					emptype="Student";
				
				else if(correctNull((String)hshValues.get("strEmployment")).equals("11"))
					emptype="Others";
					
				else if(correctNull((String)hshValues.get("strEmployment")).equals("0"))
					emptype="Select";			
					
				
				
			    
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strCBSid);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
					if(rs.next())
					{
					stridDoc=Helper.correctNull((String)rs.getString("id_doc"));
					strIdNumber=Helper.correctNull((String)rs.getString("id_number"));
					}
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strCBSid);
					rs=DBUtils.executeQuery(strQuery); 
					if(rs.next())
					{
					 stridDoc=Helper.correctNull((String)rs.getString("id_doc"));
				     strIdNumber=Helper.correctNull((String)rs.getString("id_number"));
					}
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_appKYCnorms_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strCustomerOccupation")));
				
				if(strDedupeFlag.equals("Y"))
				{
				arrValues.add(stridDoc);
				arrValues.add(strIdNumber);
				}
				else
				{
				arrValues.add(correctNull((String)hshValues.get("strIDprooftype")));
				arrValues.add(correctNull((String)hshValues.get("strIDref")));
				}
				arrValues.add(correctNull((String)hshValues.get("strRiskCat")));
				arrValues.add(correctNull((String)hshValues.get("strResidentProof")));
				arrValues.add(correctNull((String)hshValues.get("strResidentIDref")));
				arrValues.add(correctNull((String)hshValues.get("strNatureActivity")));
				arrValues.add(correctNull((String)hshValues.get("strResidentIDdate")));
				arrValues.add(emptype);
				arrValues.add(correctNull((String)hshValues.get("stridProoofExpDate")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				//rating
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_cusrating_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add("2");
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
			/*	hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_defaulter_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);*/
				
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_cibil_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strWhrRefCIBIL")));
				arrValues.add(correctNull((String)hshValues.get("strCIBILscore")));
				arrValues.add(correctNull((String)hshValues.get("strCIBILdetails")));
				arrValues.add("N");
				//arrValues.add("N");
				arrValues.add(correctNull((String)hshValues.get("strWhrRefCRIF")));
				arrValues.add(correctNull((String)hshValues.get("strcrifScore")));
				arrValues.add(correctNull((String)hshValues.get("strcrifDetails")));
				arrValues.add(correctNull((String)hshValues.get("crifReportedDate")));
				if(!(correctNull((String)hshValues.get("strcibilDate")).equalsIgnoreCase("")))
				{
				arrValues.add(correctNull((String)hshValues.get("strcibilDate")));
				}else{
				arrValues.add(currdate);	
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_incomeexp_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strPrimaryIncome")));
				arrValues.add(correctNull((String)hshValues.get("strGrossIncome")));
				arrValues.add(correctNull(Integer.toString(Integer.parseInt(((String)hshValues.get("strGrossIncome")))*12)));
				arrValues.add(correctNull(Integer.toString(Integer.parseInt(((String)hshValues.get("strGrossIncome")))*12)));
				arrValues.add(correctNull((String)hshValues.get("strIncomeTaxDet")));
				arrValues.add(correctNull((String)hshValues.get("strincomeITR")));
				arrValues.add(correctNull((String)hshValues.get("strDocCollected")));
				arrValues.add("Y");
				arrValues.add("A");
				if(correctNull((String)hshValues.get("strEmployment")).equals("1") || correctNull((String)hshValues.get("strEmployment")).equals("01")){
				arrValues.add(correctNull(Integer.toString(Integer.parseInt(((String)hshValues.get("strGrossIncome")))*12)));
				}else{
					arrValues.add(correctNull((String)hshValues.get("strincomeITR")));
				}
				arrValues.add(correctNull((String)hshValues.get("strincomeYearEnded")));
				arrValues.add(correctNull((String)hshValues.get("stritrFillingDate")));
				arrValues.add(correctNull((String)hshValues.get("strIncomeYearEndPreviousYear")));
				arrValues.add(correctNull((String)hshValues.get("strItrFillDatePreviousYear")));
				arrValues.add(correctNull((String)hshValues.get("stritrSalaryPreviousYear")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				String strdateJoining=correctNull((String)hshValues.get("strdateJoining"));
				if(strdateJoining.equals(""))
				{
					strdateJoining=correctNull((String)hshValues.get("strcommencementDate"));
				}
				String strexperinceYears=correctNull((String)hshValues.get("strexperinceYears"));
				if(strexperinceYears.equals(""))
				{
					strexperinceYears=correctNull((String)hshValues.get("stryearsCurrentActivity"));
				}
				
				String retirdate=correctNull((String)hshValues.get("strretirementDate"));
				 Date mycurrentdate=new Date();
				 SimpleDateFormat date=new SimpleDateFormat("dd/MM/yyyy");
				 Date mycurrdate=date.parse(currdate);
				 //Date retDate=date.parse(retdate); 
				 
			
				 /*
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					Date date=sdf.parse(strDateOfBirth);
				 
				 */
	//var retdate=document.forms[0].txtperemp_retdate.value;
	//Date retiredate=new Date(retdate.substring(6,10),Integer.parseInt((retdate.substring(3,5)))-1,retdate.substring(0,2));
		String currentdate[]=currdate.split("/");
		String retdate[]=retirdate.split("/");
		String retyear=retdate[2];
	String curryear=currentdate[2];
	String retmonth=retdate[1];
	String currmonth=currentdate[1];
	int txt_servicemonths = 0;
	int txtserviceleft= 0;
	int serv_month=0;
	int serv_left;
	if(Integer.parseInt(retyear)<Integer.parseInt(curryear))
	{
		 txt_servicemonths=0;
		 txtserviceleft=0;
	}
	else if(Integer.parseInt(retyear)>Integer.parseInt(curryear))
	{
		if(Integer.parseInt(retmonth)>Integer.parseInt(currmonth))
		{
			serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
	  		txt_servicemonths=serv_month;
	  		 serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
	  		txtserviceleft=serv_left;
		}
		else if(Integer.parseInt(retmonth) < Integer.parseInt(currmonth))
		{
			 serv_month=Integer.parseInt(retmonth)+12-Integer.parseInt(currmonth);
	  		txt_servicemonths=serv_month;
	  		serv_left=(Integer.parseInt(retyear)-1)-Integer.parseInt(curryear);
	  		txtserviceleft=serv_left;
		}
		else
		{
			if(Integer.parseInt(retmonth)>= Integer.parseInt(currmonth))
			{
				 serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
	  			txt_servicemonths=serv_month;
	  			 serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
	  			txtserviceleft=serv_left;
			}
			else
			{
				serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth)+11;
	  			txt_servicemonths=serv_month;
	  			serv_left=(Integer.parseInt(retyear)-1)-Integer.parseInt(curryear);
	  			txtserviceleft=serv_left;
			}
		}
	}
	else if(Integer.parseInt(retyear)==Integer.parseInt(curryear))
	{
		if(Integer.parseInt(retmonth)>=Integer.parseInt(currmonth))
		{
			 serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
	  		txt_servicemonths=serv_month;
	  		 serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
	  	txtserviceleft=serv_left;
		}
		else
		{
			txt_servicemonths=0;
			txtserviceleft=0;
		}
	}
				
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_employer_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strcompanyName")));
				arrValues.add(correctNull((String)hshValues.get("strcompAddress")));
				arrValues.add(correctNull((String)hshValues.get("strcompCity")));
				arrValues.add(correctNull((String)hshValues.get("strcompState")));
				arrValues.add(correctNull((String)hshValues.get("strcompPincode")));
				arrValues.add(correctNull((String)hshValues.get("strcompPhoneno")));
				arrValues.add(correctNull((String)hshValues.get("stremployeeID")));
				arrValues.add(strexperinceYears);
				arrValues.add(strdateJoining);
				arrValues.add(correctNull((String)hshValues.get("strretirementDate")));
				arrValues.add(correctNull((String)hshValues.get("strconfirmedEmployee")));
				arrValues.add(correctNull((String)hshValues.get("strlistedCompany")));
				arrValues.add(correctNull((String)hshValues.get("strsalaryReceiptDate")));
				arrValues.add("Y");
				arrValues.add(String.valueOf(txt_servicemonths));
				arrValues.add(String.valueOf(txtserviceleft));
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_msme_company_info_common_customer_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add("N");
				arrValues.add(correctNull((String)hshValues.get("strwhetherFirmMif")));
				arrValues.add(correctNull((String)hshValues.get("strwhetherBelongsScSt")));
			
				arrValues.add(correctNull((String)hshValues.get("strrocNumber")));
				arrValues.add(correctNull((String)hshValues.get("strtin")));
				arrValues.add(correctNull((String)hshValues.get("strindustryType")));
				arrValues.add(correctNull((String)hshValues.get("strtotalEmployees")));
				arrValues.add(correctNull((String)hshValues.get("strwhetherBelongsMinorityComm")));
				arrValues.add(correctNull((String)hshValues.get("strtypeOfOwnership")));
				arrValues.add(correctNull((String)hshValues.get("strgroupName")));
				arrValues.add(correctNull((String)hshValues.get("strcompanyIdNo")));
				
				if(correctNull((String)hshValues.get("strgstin")).equals(""))
					arrValues.add("Not Applicable");
				else
					arrValues.add(correctNull((String)hshValues.get("strgstin")));
				
				if(correctNull((String)hshValues.get("strgstin")).equals(""))
				{
					arrValues.add("N");
				}
				else
				{
					arrValues.add("Y");
				}
				arrValues.add(correctNull((String)hshValues.get("strDOB")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_cusdefaulter");
				arrValues.add(strNewLAPSid); 
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
                hshQueryValues.put("size",String.valueOf(querycount));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				ArrayList mgmntlist=new ArrayList();
				ArrayList managementarry= new ArrayList();
				
				
				
				mgmntlist=(ArrayList) hshValues.get("arrMngmnt");
				int mgmntSize=mgmntlist.size(),j=1;
				if(mgmntSize>0)
				{
					hshQuery = new HashMap();
					for(int i=0;i<mgmntSize;i++)
					{
				managementarry=(ArrayList) mgmntlist.get(i);
				querycount++;
				
				arrValues = new ArrayList();
				
				arrValues.add(managementarry.get(13));
				arrValues.add(managementarry.get(14));
				arrValues.add(managementarry.get(1));
				arrValues.add(managementarry.get(15));
				arrValues.add(managementarry.get(4));
				arrValues.add(managementarry.get(10));
				arrValues.add(managementarry.get(0));
				arrValues.add(managementarry.get(12));
				arrValues.add(managementarry.get(9));
				arrValues.add(managementarry.get(11));
				arrValues.add(managementarry.get(8));
				arrValues.add(managementarry.get(7));
				arrValues.add(managementarry.get(6));
				arrValues.add(managementarry.get(5));
				arrValues.add(strNewLAPSid);
				arrValues.add(managementarry.get(2));
				arrValues.add(managementarry.get(3));
				arrValues.add(stroldLAPSid);
				arrValues.add(Integer.toString(j));
				j+=1;
				arrValues.add(managementarry.get(16));
				arrValues.add(managementarry.get(17));

				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_com_company_division");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
				}	
				
				
				//other bank facilities
				
				ArrayList arrExistFaclty=new ArrayList();
				ArrayList arrExistFacltyValues=new ArrayList();
				arrExistFaclty=(ArrayList) hshValues.get("existingFacility");
				int existFacLenth=arrExistFaclty.size();
				if(existFacLenth>0)
				{
					for(int i=0;i<existFacLenth;i++)
					{		
						arrExistFacltyValues=(ArrayList) arrExistFaclty.get(i);
						
						String nameOfBank=Helper.correctNull((String)arrExistFacltyValues.get(0));
						String type=Helper.correctNull((String)arrExistFacltyValues.get(1));
						String facility=Helper.correctNull((String)arrExistFacltyValues.get(2));
						String purposeOfLaon=Helper.correctNull((String)arrExistFacltyValues.get(3));
						String typeOfFacility=Helper.correctNull((String)arrExistFacltyValues.get(4));
						String limit=Helper.correctNull((String)arrExistFacltyValues.get(5));
						String outstanding =Helper.correctNull((String)arrExistFacltyValues.get(6));
						String outstandingDate=Helper.correctNull((String)arrExistFacltyValues.get(7));
						String bankingType =Helper.correctNull((String)arrExistFacltyValues.get(8));
						String interestType =Helper.correctNull((String)arrExistFacltyValues.get(9));
						String spreadValue =Helper.correctNull((String)arrExistFacltyValues.get(10));
						String repaymentType =Helper.correctNull((String)arrExistFacltyValues.get(11));
						String dueDate=Helper.correctNull((String)arrExistFacltyValues.get(12)); 
						String securityDesc=Helper.correctNull((String)arrExistFacltyValues.get(13));
						String securityValue=Helper.correctNull((String)arrExistFacltyValues.get(14));
						String whetherLitigation=Helper.correctNull((String)arrExistFacltyValues.get(15));
						String natureOfLitigation=Helper.correctNull((String)arrExistFacltyValues.get(16));
						String dateOfLitigation=Helper.correctNull((String)arrExistFacltyValues.get(17));
						String claimAmount=Helper.correctNull((String)arrExistFacltyValues.get(18));
						String otherClaim=Helper.correctNull((String)arrExistFacltyValues.get(19));
						
						String presentPosition=Helper.correctNull((String)arrExistFacltyValues.get(20));
											
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_otherbank_exist_fac");
						arrValues.add(strNewLAPSid);
						arrValues.add(stroldLAPSid);
						arrValues.add(nameOfBank);
						arrValues.add(type);
						arrValues.add(facility);
						arrValues.add(purposeOfLaon);
						arrValues.add(typeOfFacility);
						arrValues.add(limit);
						arrValues.add(outstanding);
						arrValues.add(outstandingDate);
						arrValues.add(bankingType);
						arrValues.add(interestType);
						arrValues.add(spreadValue);
						arrValues.add(repaymentType);
						arrValues.add(dueDate);
						arrValues.add(securityDesc);
						arrValues.add(securityValue);
						arrValues.add(whetherLitigation);
						arrValues.add(natureOfLitigation);
						arrValues.add(dateOfLitigation);
						arrValues.add(claimAmount);
						arrValues.add(otherClaim);
						arrValues.add(presentPosition);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
		
		/*	else
			{
				//MastApplicantBean mastbean=new MastApplicantBean();
				//hshValues.put("hidOldAppId", lapsID);
				//hshValues.put("OldAppId", lapsID);
				//hshRecord=mastbean.renewApplicantData(hshValues);
				
				
				hshValues.put("strDedupeFlag", strDedupeFlag); 
				hshValues.put("strNewLAPSid", lapsID);
				hshValues.put("strResponseCode", "LAPS-1009");
				hshValues.put("strResponseMsg", "LAPS Customer Profile already Exist");
			}*/
			
			//For inserting in Finacial(corp_fin_year table,com_finance,COM_FINAPPVALUES)
			String strOldFinID="",strNewFinID="",strAppCodeper="",strAppCode="",strlapmaxsoldID = "";
			Connection connectDB	= null;
			CallableStatement callableStmt = null;
			/*if(rs != null)rs.close();
			rs=DBUtils.executeLAPSQuery("mastgetAppid");			 
			if(rs.next())
			{
				strAppCodeper=rs.getString(1);
			}
			strAppCode=strAppCodeper;*/
			
			if(rs1 != null)rs1.close();
            strQuery=SQLParser.getSqlQuery("selmaxlapsidofcustid^"+strCBSid);
           rs1=DBUtils.executeQuery(strQuery);
            if(rs1.next())
            {
            	strlapmaxsoldID = (Helper.correctNull(rs1.getString("maxperappid")));
            }

            
			if(!lapsoldID.equalsIgnoreCase("") && !strlapmaxsoldID.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selfinancerenew^"+strlapmaxsoldID);
				if(rs != null)rs.close();
				rs=DBUtils.executeQuery(strQuery);
			    while(rs.next())
				{
					strOldFinID=(Helper.correctNull(rs.getString("fin_financeid")));
					if(!strOldFinID.equals(""))
					{
					
						strQuery=SQLParser.getSqlQuery("maxfinanceid");
						if(rs1 != null)rs1.close();
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strNewFinID=(Helper.correctNull(rs1.getString("fin_financeid")));
						}
						
					connectDB = ConnectionFactory.getConnection();
					callableStmt=connectDB.prepareCall("call PROC_FIN_CUSTRENEW(?,?,?)");
					callableStmt.setString(1,correctNull(strNewFinID));
					callableStmt.setString(2,correctNull(strOldFinID));
					callableStmt.setString(3,correctNull(strNewLAPSid));
					callableStmt.execute();
					callableStmt.clearParameters();
					
					connectDB.close();
					
					log.info("insert into financials completed. Finance id ===="+strNewFinID);
					System.out.println("insert into financials completed. Finance id ===="+strNewFinID);
					
					}
				}
			}
			hshValues.put("strNewLAPSid", strNewLAPSid);
			hshValues.put("strResponseCode", "LAPS-3004");
			hshValues.put("strResponseMsg", "LAPS Customer Profile Created Successfully");
			}
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean customerCreation..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean customerCreation in closing connection..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	
	public HashMap basicInformationCustomer(HashMap hshValues)  
	{

		ResultSet rs=null,rs1=null,rs2=null,rs4=null,rs5=null;
		String strQuery="",strfinanceId="",strYear="", strFinType="", strSno="";
		String fName="",cbstype="",facSno="",relationship="",lapsid="",type="",strmodule="", govtSchema="",solId="",birdate="";
		HashMap hshRecord= new HashMap();
		HashMap hshRecord3= new HashMap();
		HashMap hshRecord4= new HashMap();
		HashMap hshRecord5= new HashMap();
		HashMap hshRecord6= new HashMap();
		HashMap hshRecord7= new HashMap();
		HashMap hshRecord8= new HashMap();
		HashMap hshRecord9= new HashMap();
		HashMap hshRecord10= new HashMap();
		ArrayList arrval=new ArrayList();
		ArrayList arrval3=new ArrayList();
		ArrayList arrval5=new ArrayList();
		ArrayList arrval6=new ArrayList();
		ArrayList arrval7=new ArrayList();
		ArrayList arrval8=new ArrayList();
		ArrayList arrval9=new ArrayList();
		ArrayList arrval10=new ArrayList();
		try
		{
			
			String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
			String strProposalID=Helper.correctNull((String)hshValues.get("strProposalID"));
			String strFacilityID=Helper.correctNull((String)hshValues.get("strFacilityID"));
			String strFlag=Helper.correctNull((String)hshValues.get("strFlag"));
			
			//Enterprise Information:
			strQuery = SQLParser.getSqlQuery("sel_digi_msme_basicinfo1^"+strCustomerID);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("NameofEnterprise",Helper.correctNull((String)rs.getString("PERAPP_FNAME")));
				hshRecord.put("RegisteredOfficeAddress",Helper.correctNull((String)rs.getString("REGISTERED_ADDRESS")));
				hshRecord.put("TelephoneNo",Helper.correctNull((String)rs.getString("CON_COMPHONE")));
				hshRecord.put("MobileNumber",Helper.correctNull((String)rs.getString("CON_MOBILE")));
				hshRecord.put("EmailAddress",Helper.correctNull((String)rs.getString("CON_EMAIL")));
				hshRecord.put("Constitution",Helper.correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
				hshRecord.put("PANcard",Helper.correctNull((String)rs.getString("PERAPP_PANNO")));
				hshRecord.put("RegistrationNumber",Helper.correctNull((String)rs.getString("COMINFO_ROC_NUMBER")));
				hshRecord.put("DateofRegistration","");
				hshRecord.put("DateofIncorporation",Helper.correctNull((String)rs.getString("COMINFO_INCORPORATION_DATE")));
				hshRecord.put("DateofCommencementofBusiness",Helper.correctNull((String)rs.getString("COMINFO_COMMENCEMENT_DATE")));
				hshRecord.put("CIN",Helper.correctNull((String)rs.getString("COMINFO_CIN")));
				hshRecord.put("TIN",Helper.correctNull((String)rs.getString("COMINFO_TIN")));
				hshRecord.put("IEC",Helper.correctNull((String)rs.getString("cominfo_iec")));
				hshRecord.put("IndustryType",Helper.correctNull((String)rs.getString("cominfo_industry_type")));
				hshRecord.put("LEI",Helper.correctNull((String)rs.getString("perapp_legal_entityid")));
				hshRecord.put("NatureOfBusiness",Helper.correctNull((String)rs.getString("KYC_KYCACTIVITY")));
				hshRecord.put("PIN",Helper.correctNull((String)rs.getString("con_comzip")));

			}
			
			//mis
			if (rs != null) 
			{ 	rs.close();	 }
			
			if(strProposalID.equals("")|| strFacilityID.equals(""))
			{
				hshRecord.put("CityCreditUtilization","");
				hshRecord.put("DistrictCreditUtilization","");
				hshRecord.put("StateCreditUtilization","");
				hshRecord.put("FacilityAvailingBranch","");
			}
			else{
			strQuery = SQLParser.getSqlQuery("sel_digi_msme_basicinfo2^"+strProposalID+"^"+strFacilityID);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("CityCreditUtilization",Helper.correctNull((String)rs.getString("CITY_NAME")));
				hshRecord.put("DistrictCreditUtilization",Helper.correctNull((String)rs.getString("DISTRICT_DESC")));
				hshRecord.put("StateCreditUtilization",Helper.correctNull((String)rs.getString("STATE_NAME")));
				hshRecord.put("FacilityAvailingBranch",Helper.correctNull((String)rs.getString("LOANDISBBRANCH")));
			}
			}
			//Associate Concerns 
			if (rs != null) 
			{ 	rs.close();	 }
			strQuery = SQLParser.getSqlQuery("sel_digi_msme_basicinfo4^"+strCustomerID);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord4=new HashMap();
				hshRecord4.put("NameofAssociateConcern",Helper.correctNull((String)rs.getString("PERAPP_FNAME")));
				hshRecord4.put("CustID",Helper.correctNull((String)rs.getString("PERAPP_CBSID")));
				hshRecord4.put("AddressofAssociateConcern",Helper.correctNull((String)rs.getString("ADDRESS")));
				hshRecord4.put("NatureofAssociation",Helper.correctNull((String)rs.getString("KYC_ACTIVITY")));
				hshRecord4.put("Activity",Helper.correctNull((String)rs.getString("KYC_KYCACTIVITY")));
				hshRecord4.put("concernType",Helper.correctNull((String)rs.getString("COMAPP_DIVISIONTYPE")));
				arrval.add(hshRecord4);
			}
			
			
			//Individual Information
			if (rs != null) 
			{ 	rs.close();	 }
			strQuery = SQLParser.getSqlQuery("sel_digi_msme_basicinfo3^"+strCustomerID);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord3=new HashMap();
				hshRecord3.put("Name",Helper.correctNull((String)rs.getString("PERAPP_FNAME")));
				hshRecord3.put("CustomerID",Helper.correctNull((String)rs.getString("PERAPP_CBSID")));
				hshRecord3.put("Gender",Helper.correctNull((String)rs.getString("PERAPP_SEX")));
				hshRecord3.put("DoB",Helper.correctNull((String)rs.getString("PERAPP_DOB")));
				hshRecord3.put("FatherName",Helper.correctNull((String)rs.getString("PERAPP_FATNAME")));
				hshRecord3.put("AcademicQualification",Helper.correctNull((String)rs.getString("INDINFO_EDU_QUAL")));
				hshRecord3.put("Category",Helper.correctNull((String)rs.getString("CASTE")));
				hshRecord3.put("ExperienceLineofActivity",Helper.correctNull((String)rs.getString("EXPYEAR")));
				hshRecord3.put("PANno",Helper.correctNull((String)rs.getString("PERAPP_PANNO")));
				hshRecord3.put("Aadhaarno",Helper.correctNull((String)rs.getString("PERAPP_AADHAAR")));
				hshRecord3.put("Address",Helper.correctNull((String)rs.getString("ADDRESS")));
				hshRecord3.put("Mobile",Helper.correctNull((String)rs.getString("CON_COMPHONE")));
				hshRecord3.put("Telephone",Helper.correctNull((String)rs.getString("CON_MOBILE")));
				hshRecord3.put("Email",Helper.correctNull((String)rs.getString("CON_EMAIL")));
				hshRecord3.put("BankRelationship",Helper.correctNull((String)rs.getString("BANKRELATION")));
				hshRecord3.put("IDProofType",Helper.correctNull((String)rs.getString("IDPROOFTYPE")));
				hshRecord3.put("IDProof",Helper.correctNull((String)rs.getString("IDPROOF")));
				hshRecord3.put("AddressProofType",Helper.correctNull((String)rs.getString("resprooftype")));
				hshRecord3.put("AddressProof",Helper.correctNull((String)rs.getString("resproof")));
				hshRecord3.put("DocumentExecutant",Helper.correctNull((String)rs.getString("COMAPP_DOCEXECUTANT")));
				hshRecord3.put("concernType",Helper.correctNull((String)rs.getString("COMAPP_DIVISIONTYPE")));
				hshRecord3.put("NetIncome",Helper.correctNull((String)rs.getString("PERINC_MONSALARY")));
				hshRecord3.put("MartialStatus",Helper.correctNull((String)rs.getString("perapp_marstat")));
				
				arrval3.add(hshRecord3);
			}
			
			
			//existing facilities
									
			if(rs!=null)
			{ rs.close(); }
			
			if(strFlag.equalsIgnoreCase("LAPS")){
				strQuery = SQLParser.getSqlQuery("sel_customer_applications_laps^"+strCustomerID+"^"+strCustomerID+"^"+strCustomerID);
			}else{
				strQuery = SQLParser.getSqlQuery("sel_customer_applications_cbs^"+strCustomerID+"^"+strCustomerID+"^"+strCustomerID);						
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord5=new HashMap();
				hshRecord5.put("ProposalNumber",Helper.correctNull((String)rs.getString("APPNO")));
				hshRecord5.put("FacilityID",Helper.correctNull((String)rs.getString("FAC_SNO")));
				hshRecord5.put("FacilityType",Helper.correctNull((String)rs.getString("FACILITY_TYPE")));
				hshRecord5.put("SanctionedDate",Helper.correctNull((String)rs.getString("APDT")));
				hshRecord5.put("Tenor",Helper.correctNull((String)rs.getString("TENOR")));
				hshRecord5.put("DueDate",Helper.correctNull((String)rs.getString("DUEDATE")));
				hshRecord5.put("InterestRate",Helper.correctNull((String)rs.getString("ROI")));
				hshRecord5.put("RepaymentType",Helper.correctNull((String)rs.getString("REPAYTYPE")));
				hshRecord5.put("LimitType",Helper.correctNull((String)rs.getString("LIMITTYPE")));
				hshRecord5.put("Module",Helper.correctNull((String)rs.getString("MODULE")));
				hshRecord5.put("FacilityPurpose",Helper.correctNull((String)(Helper.CLOBToString(rs.getClob("facility_purpose"))) ));
				hshRecord5.put("BankingArrangement",Helper.correctNull((String)rs.getString("FACILITY_PROPBANKTYPE")));
				hshRecord5.put("SanctionLimit",Helper.correctNull((String)rs.getString("FACILITY_SANCAMT")));
				hshRecord5.put("description",Helper.correctNull((String)rs.getString("description")));
				hshRecord5.put("AccountNumber",Helper.correctNull((String)rs.getString("ACNUM")));
				
				/*hshRecord5.put("liability",Helper.correctNull((String)rs.getString("liability")));
				hshRecord5.put("cbs_limit",Helper.correctNull((String)rs.getString("cbs_limit")));
				hshRecord5.put("disbursement",Helper.correctNull((String)rs.getString("disbursement")));*/
				
				hshRecord5.put("FacilityHeadCategory",Helper.correctNull((String)rs.getString("fachead")));
				hshRecord5.put("LoanEmi",Helper.correctNull((String)rs.getString("loan_emi")));
				hshRecord5.put("LoanPeriodiCity",Helper.correctNull((String)rs.getString("LOAN_PERIODICITY")));
				hshRecord5.put("NonEmiAmOunt",Helper.correctNull((String)rs.getString("TL_INSTAMT")));
				if(!strFlag.equalsIgnoreCase("LAPS")){
					hshRecord5.put("liability",Helper.correctNull((String)rs.getString("liability")));
					hshRecord5.put("cbs_limit",Helper.correctNull((String)rs.getString("cbs_limit")));
					hshRecord5.put("disbursement",Helper.correctNull((String)rs.getString("disbursement")));
					}

				
				
				//incomeR
				String appno=Helper.correctNull((String)rs.getString("APPNO"));
				String FIN_COMAPPID="",FIN_CMANO="0",FIN_FINANCEID="0",FIN_VALUESAREIN="";
				String FacilityID=Helper.correctNull((String)rs.getString("FAC_SNO"));
				String strFinancialModel="",strGuaCovered="";

				if (rs1 != null) 
				{ 	rs1.close();	 }
				strQuery = SQLParser.getSqlQuery("sel_demo_finance_cmano^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					FIN_COMAPPID=Helper.correctNull((String)rs1.getString("FIN_COMAPPID"));
					FIN_CMANO=Helper.correctInt((String)rs1.getString("FIN_CMANO"));
					FIN_FINANCEID=Helper.correctInt((String)rs1.getString("FIN_FINANCEID"));
					FIN_VALUESAREIN=Helper.correctNull((String)rs1.getString("FIN_VALUESAREIN"));
				}
				
				String COM_SNO="0";
				
				if (rs1 != null) 
				{ 	rs1.close();	 }
				strQuery = SQLParser.getSqlQuery("sel_financial_audityear^"+FIN_FINANCEID+"^"+FIN_FINANCEID);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					COM_SNO=Helper.correctInt((String)rs1.getString("COM_SNO"));
				}
				
				double profitamount=0.00;

				if (rs1 != null) 
				{ 	rs1.close();	 }
				strQuery = SQLParser.getSqlQuery("sel_financial_audited_profit^"+FIN_FINANCEID+"^"+COM_SNO+"^"+FIN_CMANO);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					profitamount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FIN_AUDIT")));
					
					if(FIN_VALUESAREIN.equals("L"))		
					{
						profitamount=profitamount*100000;
					}
					else if(FIN_VALUESAREIN.equals("C"))
					{
						profitamount=profitamount*10000000;
					}
					else
					{
						profitamount=profitamount*1;
					}
				}
				
				
				//financial cma category
				if (rs1 != null) 
				{ 	rs1.close();	 }
				strQuery = SQLParser.getSqlQuery("comfinance_finappid^"+FIN_FINANCEID);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strFinancialModel=Helper.correctNull((String)rs1.getString("CMA_FORMAT_DESC"));
				}
				
				hshRecord5.put("FinancialModel",strFinancialModel);
				hshRecord5.put("income",String.valueOf(profitamount));
				
				//guarantee covered
				if (rs1 != null) 
				{ 	rs1.close();	 }
				strQuery = SQLParser.getSqlQuery("sel_misappdetails^"+appno+"^"+FacilityID);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strGuaCovered=Helper.correctNull((String)rs1.getString("app_guarantee"));
				}
				
				hshRecord5.put("GuaranteeCovered",strGuaCovered);
				
				strQuery = SQLParser.getSqlQuery("sel_solId^"+appno);
				rs4 = DBUtils.executeQuery(strQuery);
				if(rs4.next()){
					
					 solId=(Helper.correctNull((String)rs4.getString("ORG_SCODE")));	
				}
				if (rs4 != null) 
				{ 	rs4.close();	 }
				
				
				hshRecord5.put("SolId",solId);
				
				strQuery = SQLParser.getSqlQuery("sel_per_bir^"+appno);
				rs4 = DBUtils.executeQuery(strQuery);
				if(rs4.next()){
					
					 birdate=(Helper.correctNull((String)rs4.getString("BIR_PROCESSDATE")));	
				}
				hshRecord5.put("birDate",birdate);
				
				if (rs4 != null) 
				{ 	rs4.close();	 }
				
				arrval8=new ArrayList();
				//coapplicant
				 strmodule=Helper.correctNull((String)rs.getString("MODULE"));
					if(strmodule.equalsIgnoreCase("Agriculture")|| strmodule.equalsIgnoreCase("Corporate"))
					{
						strQuery = SQLParser.getSqlQuery("basic_info_coapplicant_facility^"+appno+"^"+FacilityID);
						rs1 = DBUtils.executeQuery(strQuery);	
						while(rs1.next())
						{
							hshRecord8= new HashMap();
							hshRecord8.put("coapplicantName", Helper.correctNull((String)rs1.getString("com_compdtfname")));
							hshRecord8.put("coapplicantType",Helper.correctNull((String)rs1.getString("com_compdttype")));
							hshRecord8.put("coappldicantRelation",Helper.correctNull((String)rs1.getString("com_comprelationship")));
							hshRecord8.put("coapplicantCBStype",Helper.correctNull((String)rs1.getString("com_cbsrelationtype")));
							hshRecord8.put("coapplicantFacsno",Helper.correctNull((String)rs1.getString("com_facility_sno")));
							hshRecord8.put("coapplicantLAPSID",Helper.correctNull((String)rs1.getString("com_compdtappid")));
							hshRecord8.put("coapplicantCBSID",Helper.correctNull((String)rs1.getString("PERAPP_CBSID")));
							arrval8.add(hshRecord8);
							
						}
						
						strQuery = SQLParser.getSqlQuery("sel_govtscheme_info^"+appno+"^"+FacilityID);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							govtSchema=Helper.correctNull((String)rs1.getString("facility_govtsponschem"));
						}
						if(govtSchema.equals("1"))
							hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-SHISHU");	
						else if(govtSchema.equals("2"))
						hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-KISHORE");	
						else if(govtSchema.equals("3"))
							 hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-TARUN");
						else
							 hshRecord5.put("govtsponserScheme","");
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("getcoappguarantor^"+appno);
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
								hshRecord8= new HashMap();
								hshRecord8.put("coapplicantName", Helper.correctNull((String)rs1.getString("appname")));
								hshRecord8.put("coapplicantType",Helper.correctNull((String)rs1.getString("demo_type")));
								hshRecord8.put("coappldicantRelation",Helper.correctNull((String)rs1.getString("demo_relation")));
								hshRecord8.put("coapplicantCBStype",Helper.correctNull((String)rs1.getString("DEMO_CBSRELATIONTYPE")));
								hshRecord8.put("coapplicantFacsno","1");
								hshRecord8.put("coapplicantLAPSID",Helper.correctNull((String)rs1.getString("demo_appid")));
								hshRecord8.put("coapplicantCBSID",Helper.correctNull((String)rs1.getString("perapp_cbsid")));
								arrval8.add(hshRecord8);
						}
						strQuery = SQLParser.getSqlQuery("sel_loan_amtreqd_app^"+appno);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							govtSchema=Helper.correctNull((String)rs1.getString("govt_scheme"));
						}
						if(govtSchema.equals("1"))
							hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-SHISHU");	
						else if(govtSchema.equals("2"))
						hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-KISHORE");	
						 else if(govtSchema.equals("3"))
							 hshRecord5.put("GovernmentAnnouncedScheme","MUDRA-TARUN");
						 else
							 hshRecord5.put("GovernmentAnnouncedScheme","");		
						
					
					}
				
					//industry type
					if (rs1 != null) 
					{ 	rs1.close();	 }
					String MIS_STATIC_DATA_DESC="";
					strQuery = SQLParser.getSqlQuery("sel_misstatic_industrytype^"+appno+"^"+FacilityID);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						MIS_STATIC_DATA_DESC=Helper.correctNull((String)rs1.getString("MIS_STATIC_DATA_DESC"));
					}
					
					hshRecord5.put("IndustryType",MIS_STATIC_DATA_DESC);
					
					
					//securities
					arrval9=new ArrayList();
					if (rs1 != null) 
					{ 	rs1.close();	 }
					strQuery = SQLParser.getSqlQuery("sel_sec_securitytype_digi^"+appno+"^"+FacilityID);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
							hshRecord8= new HashMap();
							hshRecord8.put("SecurityID", Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
							hshRecord8.put("SecurityType",Helper.correctNull((String)rs1.getString("APP_SEC_SECURITYTYPE")));
							//hshRecord8.put("SecurityValue",Helper.correctNull((String)rs1.getString("APP_SEC_SECURITYVALUE")));
							
							
							
							if (rs5 != null) 
							{ 	rs5.close();	}
							strQuery = SQLParser.getSqlQuery("select_security_calssification^"+Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
							rs5 = DBUtils.executeQuery(strQuery);
							if(rs5.next())
							{
								hshRecord8.put("SecurityValue",Helper.correctNull((String)rs5.getString("CUS_SEC_NETSECURITY")));
								hshRecord8.put("SecurityMainType",Helper.correctNull((String)rs5.getString("CUS_SEC_TYPE")));
								hshRecord8.put("SecuritySubType",Helper.correctNull((String)rs5.getString("CUS_SEC_CLASSIFICATION")));
								hshRecord8.put("ValuationDate",Helper.correctNull((String)rs5.getString("CUS_SEC_VALUATION_DATE")));
								
							}
							
							if (rs5 != null) 
							{ 	rs5.close();	}
							String sec_vehicletype="";
							strQuery = SQLParser.getSqlQuery("sel_security_vehicle^"+Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
							rs5 = DBUtils.executeQuery(strQuery);
							if(rs5.next())
							{
								sec_vehicletype=Helper.correctNull((String)rs5.getString("sec_vehicletype"));
								if(sec_vehicletype.equals("1"))
									sec_vehicletype="New";
								else if(sec_vehicletype.equals("2"))
									sec_vehicletype="Old";
								else
									sec_vehicletype="";
							}
							if (rs5 != null) 
							{ 	rs5.close();	}
							strQuery = SQLParser.getSqlQuery("sel_plantmachinery^"+Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
							rs5 = DBUtils.executeQuery(strQuery);
							if(rs5.next())
							{
								sec_vehicletype=Helper.correctNull((String)rs5.getString("SEC_MACHINERY_TYPE"));
							}
							
							hshRecord8.put("Vintage",sec_vehicletype);
							
							if (rs5 != null) 
							{ 	rs5.close();}
							String secaddress="",secaddress1="",secCity="",secDist="",secState="",secZip="";
							strQuery = SQLParser.getSqlQuery("sel_address_sec_land^"+Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
							rs5 = DBUtils.executeQuery(strQuery);
							if(rs5.next())
							{
								
								if(strFlag.equalsIgnoreCase("LAPS")){
									secCity =Helper.correctNull((String)rs5.getString("DSEC_CITY"));
									secDist= Helper.correctNull((String)rs5.getString("DSEC_DISTRICT"));
									secState=Helper.correctNull((String)rs5.getString("DSEC_STATE"));
									}else{
										secCity =Helper.correctNull((String)rs5.getString("SEC_CITY"));
										secDist= Helper.correctNull((String)rs5.getString("SEC_DISTRICT"));
										secState=Helper.correctNull((String)rs5.getString("SEC_STATE"));	
									}
									secaddress=Helper.correctNull((String)rs5.getString("SEC_ADDRESS"));
									secaddress1=Helper.correctNull((String)rs5.getString("SEC_ADDRESS1"));
									secZip =Helper.correctNull((String)rs5.getString("SEC_ZIP"));
								}
							
							hshRecord8.put("AddressLine1",secaddress);
							hshRecord8.put("AddressLine2",secaddress1);
							hshRecord8.put("City",secCity);
							hshRecord8.put("District",secDist);
							hshRecord8.put("State",secState);
							hshRecord8.put("ZipCode",secZip);
							
							if(strFlag.equalsIgnoreCase("LAPS")){
								arrval10=new ArrayList();
								if (rs5 != null) 
								{ 	rs5.close();}
								strQuery = SQLParser.getSqlQuery("sel_SecjointHolders^"+Helper.correctNull((String)rs1.getString("APP_SEC_SECID")));
								rs5 = DBUtils.executeQuery(strQuery);
								while(rs5.next())
								{
									hshRecord9= new HashMap();
									hshRecord9.put("JointHolderName",Helper.correctNull((String)rs5.getString("perapp_fname")));
									hshRecord9.put("JointHolderCBSID",Helper.correctNull((String)rs5.getString("perapp_cbsid")));
									arrval10.add(hshRecord9);
								}
								hshRecord8.put("JointHolders",arrval10);
								}
								arrval9.add(hshRecord8);
							}
					
				
					hshRecord5.put("CoApplicant",arrval8);
					hshRecord5.put("AttachedSecurites",arrval9);
					arrval5.add(hshRecord5);
			
				
			}
			

			if (rs != null) 
			{ 	rs.close();	 }
				
			
			
			hshValues.put("AssociateConcerns", arrval);
			hshValues.put("IndividualInformation", arrval3);
			hshValues.put("EnterpriseInformation", hshRecord);
			hshValues.put("ExistingFacilities", arrval5);
			
	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in MsmeDigitalAppInterface Bean basicInformationCustomer Service..."+e.toString());
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
				throw new EJBException("Error in MsmeDigitalAppInterface Bean basicInformationCustomer Service closing Connection ..."+e.toString());
			}
		}
		
		return hshValues;	
	}

		public HashMap msmecollateralsecurity(HashMap hshValues)  
		{
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
			String strQuery="",proposalID="",securitytype="";
			
			ArrayList arrValue =new ArrayList();
			HashMap hshValue2 = new HashMap();
			arrValue=new ArrayList();
			ArrayList jointholder =new ArrayList();
			ArrayList arrValue33 =new ArrayList();
			HashMap hshValue33 = new HashMap();
			try
			{
				String strCbsID=correctNull((String)hshValues.get("strCbsId"));
				strQuery = SQLParser.getSqlQuery("sel_customer_applications_cbs^"+strCbsID+"^"+strCbsID+"^"+strCbsID);
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
				ArrayList arrValue2 =new ArrayList();
				String facSno=Helper.correctNull((String)rs.getString("FAC_SNO"));
				String proposalNo=Helper.correctNull((String)rs.getString("APPNO"));
				String PRDDE=Helper.correctNull((String)rs.getString("PRDDE"));
				//String strpin=Helper.correctNull((String)rs.getString("con_comzip"));
				//String strDist=Helper.correctNull((String)rs.getString("con_comdist"));
				//String strstate=Helper.correctNull((String)rs.getString("con_comstate"));
				String FACILITY_SANCAMT=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
				String liability=Helper.correctNull((String)rs.getString("liability"));
				String cbs_limit=Helper.correctNull((String)rs.getString("cbs_limit"));
				String disbursement=Helper.correctNull((String)rs.getString("disbursement"));
				String FacilityHeadCategory=Helper.correctNull((String)rs.getString("fachead"));
				String FacilityType=Helper.correctNull((String)rs.getString("FACILITY_TYPE"));
				
				
				strQuery = SQLParser.getSqlQuery("select_security_details^"+proposalNo+"^"+facSno);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String owner_Name="";
					hshValue2=new HashMap();
					
					String securityId=Helper.correctNull((String)rs1.getString("app_sec_secid"));
					strQuery = SQLParser.getSqlQuery("select_security_calssification^"+securityId);
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
					hshValue2.put("SubType", Helper.correctNull((String)rs2.getString("CUS_SEC_CLASSIFICATION")));	
				//	hshValue2.put("SecurityDesc", Helper.correctNull((String)rs2.getString("SEC_NAME")));
					hshValue2.put("NetSecurityValue", Helper.correctNull((String)rs2.getString("CUS_SEC_NETSECURITY")));
					hshValue2.put("NatureOfCharge", Helper.correctNull((String)rs2.getString("CUS_SEC_NATUREOFCHARGE")));
					hshValue2.put("SecurityValuationDate", Helper.correctNull((String)rs2.getString("CUS_SEC_VALUATION_DATE")));
					hshValue2.put("SecurityType",Helper.correctNull((String)rs2.getString("CUS_SEC_TYPE")));
					}
					//hshValue2.put("facilityName", Helper.correctNull((String)rs1.getString("")));
					hshValue2.put("SecurityId",securityId);
					hshValue2.put("CollateralType",Helper.correctNull((String)rs1.getString("APP_SEC_SECURITYTYPE")));

					
					//security attached to other proposals
					if (rs2 != null) 
					{	rs2.close(); 		}
					arrValue33 =new ArrayList();
					hshValue33 = new HashMap(); 
					strQuery = SQLParser.getSqlQuery("sel_secproposal_digi^"+securityId+"^"+securityId);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						hshValue33 = new HashMap(); 
						String APP_SEC_APPNO=Helper.correctNull((String)rs2.getString("APP_SEC_APPNO"));
						String APP_SEC_FACSNO=Helper.correctNull((String)rs2.getString("APP_SEC_FACSNO"));
						String PERAPP_CBSID=Helper.correctNull((String)rs2.getString("PERAPP_CBSID"));
						
						
						if (rs5 != null) 
						{	rs5.close();  }
						strQuery = SQLParser.getSqlQuery("sel_secproposal_appno_digi^"+APP_SEC_APPNO+"^"+APP_SEC_APPNO+"^"+APP_SEC_FACSNO);
						rs5 = DBUtils.executeQuery(strQuery);
						if(rs5.next())
						{	
							hshValue33.put("facilityDescription",Helper.correctNull((String)rs5.getString("prd_desc")));
							hshValue33.put("facilityID",Helper.correctNull((String)rs5.getString("facilityID")));
							hshValue33.put("module",Helper.correctNull((String)rs5.getString("module")));
							hshValue33.put("CBSaccountno",Helper.correctNull((String)rs5.getString("CBS_ACCOUNTNO")));
							hshValue33.put("facSanctionLimit",Helper.correctNull((String)rs5.getString("FACILITY_SANCAMT")));
						}
						
						String strliability="",strcbs_limit="",strdisbursement="",strFacilityType="",strFacilityHeadCategory="";
						if (rs5 != null) 
						{	rs5.close();  }
						strQuery = SQLParser.getSqlQuery("sel_customer_applications_cbs_accno^"+APP_SEC_APPNO+"^"+APP_SEC_APPNO+"^"+APP_SEC_FACSNO);
						rs5 = DBUtils.executeQuery(strQuery);
						if(rs5.next())
						{	
							strliability=Helper.correctNull((String)rs5.getString("liability"));
							strcbs_limit=Helper.correctNull((String)rs5.getString("cbs_limit"));
							strdisbursement=Helper.correctNull((String)rs5.getString("disbursement"));
							strFacilityType=Helper.correctNull((String)rs5.getString("FACILITY_TYPE"));
							strFacilityHeadCategory=Helper.correctNull((String)rs5.getString("fachead"));
						}
						
						if (rs5 != null) 
						{	rs5.close();  }
						
						hshValue33.put("liability",strliability);
						hshValue33.put("cbs_limit",strcbs_limit);
						hshValue33.put("disbursement",strdisbursement);
						hshValue33.put("FacilityType",strFacilityType);
						hshValue33.put("FacilityHeadCategory",strFacilityHeadCategory);

						hshValue33.put("facilityAppno",APP_SEC_APPNO);
						hshValue33.put("facilityslno",APP_SEC_FACSNO);
						hshValue33.put("customerID",PERAPP_CBSID);
						
						arrValue33.add(hshValue33);
					}
					
					if (rs2 != null) 
					{	rs2.close();  }
					
					//hshValue2.put("AttachedSecurityValue", Helper.correctNull((String)rs1.getString("APP_SEC_SECURITYVALUE")));
					//hshValue2.put("Margin", Helper.correctNull((String)rs1.getString("app_sec_margin")));
					
					strQuery = SQLParser.getSqlQuery("select_owner_name^"+securityId);
					rs3 = DBUtils.executeQuery(strQuery);
					
					if(rs3.next())
						
					owner_Name=Helper.correctNull((String)rs3.getString("perapp_fname"));
					hshValue2.put("OwnerName",owner_Name);
					
					if (rs3 != null) 
					{	rs3.close();  }
					
					
					strQuery = SQLParser.getSqlQuery("sel_joint_holder_name^"+securityId);
					rs4 = DBUtils.executeQuery(strQuery);
					jointholder =new ArrayList();
					while(rs4.next())
					{
					 
					jointholder.add(Helper.correctNull((String)rs4.getString("perapp_fname")));
					
					}
					hshValue2.put("JointHolderName", jointholder);
					hshValue2.put("facilityMapped", arrValue33);
					arrValue2.add(hshValue2);
					if (rs4 != null) 
					{	rs4.close();  }
				}
				
				if (rs1 != null) 
				{	rs1.close();  }
				
				hshRecord=new HashMap();
				hshRecord.put("proposalNo", proposalNo);
				hshRecord.put("SerialNo",facSno );
				hshRecord.put("facilityDescription",PRDDE);
				hshRecord.put("facilitySanctionLimit",FACILITY_SANCAMT);
				hshRecord.put("liability",liability);
				hshRecord.put("cbs_limit",cbs_limit);
				hshRecord.put("disbursement",disbursement);
				hshRecord.put("FacilityType",FacilityType);
				hshRecord.put("FacilityHeadCategory",FacilityHeadCategory);
				
				
				hshRecord.put("security", arrValue2);
			
				
				arrValue.add(hshRecord);			
				
				}
				hshValues.put("proposalDetails", arrValue);
			
			}
			catch(Exception e)
				{
					throw new EJBException("Error in MsmeDigitalAppInterface Bean collateralSecurity Service..."+e.toString());
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
						throw new EJBException("Error in MsmeDigitalAppInterface Bean collateralSecurity Service closing Connection ..."+e.toString());
					}
			}
			return hshValues;
			
		}

		
		public HashMap msmeRenewalDedupeCheckService(HashMap hshValues)  
		{
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null;
			String strQuery="",strInwardno="";
			HashMap hshValue1 = new HashMap();
			HashMap hshValue2 = new HashMap();
			ArrayList arrValue =new ArrayList();
			ArrayList arrValue1 =new ArrayList();
			hshValues.put("dataExist", "No");	
			ArrayList arrValue2 =new ArrayList();
			try
			{
				
			String strProposalID=Helper.correctNull((String)hshValues.get("strProposalID"));
			String strFacilityID=Helper.correctInt((String)hshValues.get("strFacilityID"));
			String strApplExist="N";


			String strFACILITY_APPNO="",strFACILITY_SNO="",strFACILITY_DATE="",strFACILITY_OLDAPPNO="",strFACILITY_OLDAPPSNO="",strFACILITY_STATUS="";
			
			strQuery = SQLParser.getSqlQuery("sel_digi_renewalDedupe^"+strProposalID+"^"+strFacilityID);
				rs = DBUtils.executeQuery(strQuery);
			
			//rs=DBUtils.executeLAPSQuery("sel_mainlimit_dedupe_check^"+strPANno);
			while(rs.next())
			{
				hshValues.put("dataExist", "Yes");	
				
				strFACILITY_APPNO=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
				strFACILITY_SNO=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
				strFACILITY_DATE=Helper.correctNull((String)rs.getString("FACILITY_DATE"));
				strFACILITY_OLDAPPNO=Helper.correctNull((String)rs.getString("FACILITY_OLDAPPNO"));
				strFACILITY_OLDAPPSNO=Helper.correctNull((String)rs.getString("FACILITY_OLDAPPSNO"));
				strFACILITY_STATUS=Helper.correctNull((String)rs.getString("FACILITY_STATUS"));
				
				hshValue1=new HashMap();
				hshValue1.put("ProposalNumber", strFACILITY_APPNO);
				hshValue1.put("FacilitySerialNumber", strFACILITY_SNO);
				hshValue1.put("FacilityDate", strFACILITY_DATE);
				hshValue1.put("OldProposalNumber", strFACILITY_OLDAPPNO);
				hshValue1.put("OldFacilitySerialNumber", strFACILITY_OLDAPPSNO);
				hshValue1.put("FacilityStatus", strFACILITY_STATUS);
				arrValue.add(hshValue1);			
			}
			
			String strOldProposalNum="",strOldProposalsno="";
			
			ArrayList arrappref=new ArrayList();
			HashMap hashappref=new HashMap();
			int j=0;
			
			for(int i=1;i<100;i++)	
			{
				if(strProposalID.equals("0"))
				{
					strQuery = SQLParser.getSqlQuery("sel_FacilityIdLimit^"+strProposalID+"^"+strFacilityID);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strOldProposalNum=Helper.correctNull((String)rs.getString("facility_oldappno"));
						strOldProposalsno=Helper.correctNull((String)rs.getString("facility_oldappsno"));
						
						strProposalID=Helper.correctInt(strOldProposalNum);
						strFacilityID=Helper.correctInt(strOldProposalsno);
						
						//arrappref=new ArrayList();
						
						hashappref=new HashMap();
						hashappref.put("Reference_serialno", String.valueOf(i));
						hashappref.put("Proposal_ref", strProposalID);
						hashappref.put("Proposalsno_ref", strFacilityID);
						arrappref.add(hashappref);
						

					}
					else
					{
						break;
					}
				}
				else
				{
					break;
				}
		
			
			}
			
			
			
			hshValues.put("strProposals", arrValue);
			hshValues.put("strRefProposals", arrappref);
			
			}
			catch(Exception e)
			{
				throw new EJBException("Error in MsmeDigitalAppInterface Bean msmeRenewalDedupeCheckService..."+e.toString());
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
					throw new EJBException("Error in msmeDigitalAppInterface Bean msmeRenewalDedupeCheckService in  closing connection ..."+e.toString());
				}
			}
			
			return hshValues;
			
		}
	
		public HashMap msmeFinancialCMAService(HashMap hshValues)  
		{
			
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
			
			String strQuery="",strfinanceId="",strYear="", strFinType="", strSno="",strCmaNo="",strfinmodel="",strUnit="",strUnitDesc="",strAppid="",
				   strProposalNumber="",strperfiosmap="";

			
			HashMap hshRecord3= new HashMap();
			HashMap hshRecord4= new HashMap();
			HashMap hshRecord5= new HashMap();
			HashMap hshRecord6= new HashMap();
			HashMap hshRecord7= new HashMap();
			HashMap finCma= new HashMap();
			HashMap hshLiabilities= new HashMap();
			HashMap hshAssets= new HashMap();
			HashMap hshRecord10= new HashMap();
			HashMap hshRecord11= new HashMap();
			

			ArrayList arrval=new ArrayList();
			ArrayList arrval3=new ArrayList();
			ArrayList arrval5=new ArrayList();
			ArrayList arrval6=new ArrayList();
			ArrayList arrval7=new ArrayList();
			ArrayList arrval8=new ArrayList();
			ArrayList arrval9=new ArrayList();
			ArrayList arrval10=new ArrayList();
			ArrayList arrLiability=new ArrayList();
			ArrayList arrAssets=new ArrayList();
			
			try
			{
				
				String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
				String strProposalID=Helper.correctNull((String)hshValues.get("strProposalID"));
				String strFacilityID=Helper.correctNull((String)hshValues.get("strFacilityID"));
				String strfinYears=Helper.correctNull((String)hshValues.get("strfinYears"));
				
				//String[] split_values = strfinYears.split("','");
						
				strQuery = SQLParser.getSqlQuery("sel_appid_perapplicant^"+strCustomerID);
				rs4 = DBUtils.executeQuery(strQuery);
				if(rs4.next())
				{
				    strAppid=Helper.correctNull((String)rs4.getString("perapp_id"));
				
				}
				if (rs != null) 
				{ 	rs.close();	 }
				strQuery = SQLParser.getSqlQuery("sel_financial_finid^"+strCustomerID);
				rs3 = DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
				rs3.previous();
				if(rs3.next())
				{
				    strfinanceId=Helper.correctNull((String)rs3.getString("FIN_FINANCEID"));
					strCmaNo=Helper.correctNull((String)rs3.getString("FIN_CMANO"));
					strUnit=Helper.correctNull((String)rs3.getString("FIN_VALUESAREIN"));
					//strProposalNumber=Helper.correctNull((String)rs3.getString("DEMO_APPNO"));

					 arrval7=new ArrayList();
					
				
					
				
				if (rs != null) 
				{ 	rs.close();	 }
				
				
				if(strUnit.equalsIgnoreCase("L"))
					strUnitDesc="LAKHS";
				else if(strUnit.equalsIgnoreCase("C"))
					strUnitDesc="CRORES";
				else if(strUnit.equalsIgnoreCase("R"))
					strUnitDesc="RUPEES";
				else
					strUnitDesc="";
				
				strQuery = SQLParser.getSqlQuery("com_cma_master_selectdesc^"+strCmaNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				    strfinmodel=Helper.correctNull((String)rs.getString("cma_format_desc"));
				}
				
				if (rs != null) 
				{ 	rs.close();	 }
				
				 
				//shiva
				
				
				/*System.out.println(split_values);*/
				System.out.println(strfinYears);
				strQuery = SQLParser.getSqlQuery("sel_financialType^"+strfinanceId+"^"+strfinYears); //SHIVA COM_FINYEAR
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{ arrval6=new ArrayList();
				 arrLiability=new ArrayList();
				 arrAssets=new ArrayList();
					//hshRecord7=new HashMap();
				 strYear=Helper.correctNull((String)rs.getString("com_finyear"));
				 strFinType=Helper.correctNull((String)rs.getString("com_fintype"));
				 strSno=Helper.correctNull((String)rs.getString("com_sno"));

				strQuery = SQLParser.getSqlQuery("sel_financialData^"+strfinanceId+"^"+strSno);
				rs1 = DBUtils.executeQuery(strQuery);
			
				while(rs1.next())
				{	
					hshRecord6=new HashMap();
					 hshLiabilities= new HashMap();
					 hshAssets= new HashMap();
					String strDesc="";
					String strTabName="";
					strQuery = SQLParser.getSqlQuery("sel_financialDescription^"+strCmaNo+"^"+Helper.correctNull((String)rs1.getString("FIN_ROWID")));
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						
					strDesc=Helper.correctNull((String)rs2.getString("FIN_ROWDESC"));
					strTabName=Helper.correctNull((String)rs2.getString("FIN_TABNAME"));
					strperfiosmap=Helper.correctNull((String)rs2.getString("FIN_PERFIOS_MAPPINGCODE"));

					}
					if(strTabName.equalsIgnoreCase("PROFIT AND LOSS ACCOUNT"))
					{
					if(!strDesc.equals(""))
					{
					hshRecord6.put("description",strDesc); 
					hshRecord6.put("perfiosmappingcode",strperfiosmap); 
					if(strFinType.equalsIgnoreCase("AUDITED"))
						hshRecord6.put("value",Helper.correctNull((String)rs1.getString("fin_audit")));
					else if(strFinType.equalsIgnoreCase("UNAUDITED"))
						hshRecord6.put("value",Helper.correctNull((String)rs1.getString("fin_unaudit")));
					else if(strFinType.equalsIgnoreCase("ESTIMATED"))
						hshRecord6.put("value",Helper.correctNull((String)rs1.getString("fin_estimated")));
					else if(strFinType.equalsIgnoreCase("PROJECTION"))
						hshRecord6.put("value",Helper.correctNull((String)rs1.getString("fin_projection")));
					else 
						hshRecord6.put("value","");
					
					
					arrval6.add(hshRecord6);	
					}	
					//arrval6.add("PROFIT AND LOSS ACCOUNT");
					}
					else if(strTabName.equalsIgnoreCase("LIABILITIES"))
					{
					
						if(!strDesc.equals(""))
						{
							hshLiabilities.put("description",strDesc); 
							hshLiabilities.put("perfiosmappingcode",strperfiosmap); 
						if(strFinType.equalsIgnoreCase("AUDITED"))
							hshLiabilities.put("value",Helper.correctNull((String)rs1.getString("fin_audit")));
						else if(strFinType.equalsIgnoreCase("UNAUDITED"))
							hshLiabilities.put("value",Helper.correctNull((String)rs1.getString("fin_unaudit")));
						else if(strFinType.equalsIgnoreCase("ESTIMATED"))
							hshLiabilities.put("value",Helper.correctNull((String)rs1.getString("fin_estimated")));
						else if(strFinType.equalsIgnoreCase("PROJECTION"))
							hshLiabilities.put("value",Helper.correctNull((String)rs1.getString("fin_projection")));
						else 
							hshLiabilities.put("value","");	
						
						
						arrLiability.add(hshLiabilities);
						}
						
						
						//arrLiability.add("LIABILITIES");
					
					
					}
					else if(strTabName.equalsIgnoreCase("ASSETS"))
					{
					
						if(!strDesc.equals(""))
						{
							hshAssets.put("description",strDesc); 
							hshAssets.put("strperfiosmap",strperfiosmap); 
						if(strFinType.equalsIgnoreCase("AUDITED"))
							hshAssets.put("value",Helper.correctNull((String)rs1.getString("fin_audit")));
						else if(strFinType.equalsIgnoreCase("UNAUDITED"))
							hshAssets.put("value",Helper.correctNull((String)rs1.getString("fin_unaudit")));
						else if(strFinType.equalsIgnoreCase("ESTIMATED"))
							hshAssets.put("value",Helper.correctNull((String)rs1.getString("fin_estimated")));
						else if(strFinType.equalsIgnoreCase("PROJECTION"))
							hshAssets.put("value",Helper.correctNull((String)rs1.getString("fin_projection")));
						else 
							hshAssets.put("value","");
						
						arrAssets.add(hshAssets);
						
						}
						
						
						//arrAssets.add("ASSETS");
					}

				}
				hshRecord10=new HashMap();
				hshRecord7=new HashMap();
				hshRecord11=new HashMap();
				
				hshRecord10.put("Year",strYear);
				hshRecord10.put("FinancialType",strFinType);
				hshRecord10.put("ProfitAndLossAcc",arrval6);
				hshRecord10.put("Liability",arrLiability);
				hshRecord10.put("Assets",arrAssets);
				//hshRecord7.put("FinancialData",hshRecord10);
				//hshRecord7.put("Unit",strUnitDesc);
				
				arrval7.add(hshRecord10);
				
				}
				//
				hshRecord11.put("FinanceId",strfinanceId);
				hshRecord11.put("Unit",strUnitDesc);
				hshRecord11.put("FinancialData",arrval7);
				hshRecord11.put("FinancialModel",strfinmodel);
				//hshRecord11.put("ProposalNumber",strProposalNumber);
				
				//arrval9.add(hshRecord11);
				//arrval9.add();
				//arrval7.add(hshRecord11);
				arrval10.add(hshRecord11);
				arrval9.add(arrval10);
				

				}
			
				hshValues.put("FinancialCMA", arrval10);
				
				//hshValues.put("Unit",strUnitDesc);
				//hshValues.put("arrval8",arrval8);	
				}	else{
					hshValues.put("FinancialModel",strfinmodel);
					hshValues.put("Unit","");
					hshValues.put("FinancialCMA", arrval10);
				}
			}
		
			catch(Exception e)
			{
				throw new EJBException("Error in MsmeDigitalAppInterface Bean FinancialCMA Service..."+e.toString());
			}
			finally 
			{
				try
				{
					
				}
				catch (Exception e) 
				{
					throw new EJBException("Error in MsmeDigitalAppInterface Bean FinancialCMA Service Service closing Connection ..."+e.toString());
				}
			}
			
			return hshValues;	
		
		}
		
		
		

		public HashMap CorpProposalCreation(HashMap hshValues)  
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
				String strType="C";//mck
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
				arrValues.add("C");
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
				arrValues.add("PC");
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
					arrValues.add("C");
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
					arrValues.add("C");
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
								 arrValues.add(arrayappValue.get(15));			//shiva
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
							if(arrdscrValues.get(15).equals("a"))
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
							
							if(arrdscrValues.get(15).equals("p"))
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
							if(arrdscrsensValues.get(15).equals("a"))
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
						arrValues.add("P");
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
		
		public HashMap msmeUpdateSanctionDetails(HashMap hshValues)  
		{
			ResultSet rs=null,rs1=null,rs3=null,rs2=null;
			String strAppno=Helper.correctNull((String) hshValues.get("strappno"));
			if(strAppno.equals(""))
			{
				strAppno=Helper.correctNull((String) hshValues.get("appno"));
			}
			if(strAppno.equals(""))
			{
				strAppno=Helper.correctNull((String) hshValues.get("hidProposalNum"));
			}
			String strAction=Helper.correctNull((String) hshValues.get("hidAction"));
			String strUserId=Helper.correctNull((String) hshValues.get("strUserId"));
			String orgscode=Helper.correctNull((String) hshValues.get("strOrgShortCode"));
			String strUserClass=Helper.correctNull((String) hshValues.get("strUserClass"));
			String hidKYCChk=Helper.correctNull((String) hshValues.get("hidKYCChk"));
			String strAdd=Helper.correctNull((String) hshValues.get("sel_add"));
			String strEmpl=Helper.correctNull((String) hshValues.get("sel_employment"));
			String strBnkstmt=Helper.correctNull((String) hshValues.get("sel_bankstat"));
			String strappid=Helper.correctNull((String) hshValues.get("hidapplicantid"));
			//String strchkpan=Helper.correctNull((String) hshValues.get("hid_PANuser"));
			String strcustflag=Helper.correctNull((String) hshValues.get("strcbscustflag"));
			String strfipending=Helper.correctNull((String) hshValues.get("hid_FIPEND_FLAG"));
			String strkycPending=Helper.correctNull((String) hshValues.get("hid_KYCPEND_FLAG"));
			String stremanPending=Helper.correctNull((String) hshValues.get("hid_EMANPEND_FLAG"));
			String strpermobtaind=Helper.correctNull((String)hshValues.get("perm_obtaind"));
			String strdevrefnum=Helper.correctNull((String)hshValues.get("dev_refnum"));
			String strdevremarks=Helper.correctNull((String)hshValues.get("dev_remarks"));
			String strFinancailPending="Y";
			String strOthersPending="Y";
			
			String str_sms_flag="";
			
			
			String strQuery="",strMessage="",perappCbsId="";
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			CommWorkflowBean commwrkfko=new CommWorkflowBean();

			try
			{
				if(strAction.equalsIgnoreCase("Submit"))
				{
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_userid_appl^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strUserId=Helper.correctNull((String)rs.getString("USR_ID"));
						orgscode=Helper.correctNull((String)rs.getString("ORG_SCODE"));
						strUserClass=Helper.correctNull((String)rs.getString("USR_CLASS"));
					}
					String strusrid="";
					if(Helper.correctNull((String) hshValues.get("apisanc")).equals("Y"))
					{
						strusrid="SYSUSR";
					}
					else
					{
						strusrid=strUserId;
					}
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","commworkflowupddigi");
					arrValues.add("pa");
					arrValues.add(strusrid);
					arrValues.add(orgscode);
					arrValues.add(strUserClass);
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "updinwardappstatus");
					if(strAction.equalsIgnoreCase("approve"))
					{
						arrValues.add("pa");
					}
					else
					{
						arrValues.add("pr");
					}
					arrValues.add(strInwardno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			
					//sms service
					hshValues=updateSubmitData(hshValues);
					
					//sanction reference numnber
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
						hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
						hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
						hshValues.put("strUserDepartment",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
						//hshValues.put("strUserId",strUserId);
					}
					hshValues.put("hidAction", "approve");
					hshValues.put("sessionModuleType", "RET");
					hshValues.put("strApplicationType", "F");
					hshValues.put("digiloan", "Y");

					String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
					
					hshValues.put("strReferenceno", strReferenceno);
					hshValues.put("strSanctionDate", Helper.getCurrentDateTime());
					
					if(!Helper.correctNull((String) hshValues.get("apisanc")).equals("Y"))
					{
						hshValues=commwrkfko.getHistory(hshValues);
					}
					
				}
				else if(strAction.equalsIgnoreCase("undo"))
				{
					hshQueryValues=new HashMap();
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","commworkflowundo1");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add("Y");
					arrValues.add(strAppno);
					hshQuery.put("strQueryId", "updreferencenum");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strUserId);
					arrValues.add("Y");
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","upd_undousrdet");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("op");
					arrValues.add(strInwardno);
					hshQuery.put("strQueryId","updinwardappstatus");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4",hshQuery);
					
					
					hshQueryValues.put("size", "4");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshValues=commwrkfko.getHistory(hshValues);
					
				}
				else if(strAction.equalsIgnoreCase("reject"))
				{
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "updinwardappstatus");
					arrValues.add("pr");
					arrValues.add(strInwardno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","commworkflowupddigi");
					arrValues.add("pr");
					arrValues.add(strUserId);
					arrValues.add(orgscode);
					arrValues.add(strUserClass);
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshValues=commwrkfko.getHistory(hshValues);
				}
				
				else if(strAction.equalsIgnoreCase("Savehl"))
				{
				hshQueryValues=new HashMap();
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_verifydocument");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(!hidKYCChk.equalsIgnoreCase(""))
				{
					String[] hidKYCChkSplit=hidKYCChk.split("~");
					for(int i=0;i<hidKYCChkSplit.length;i++)
					{
						String appid=(hidKYCChkSplit[i]);  
						String strhlfipending="Y";
						

						
						if(hidKYCChkSplit[i].contains("BNK")&& hidKYCChkSplit[i].contains("ITR"))
						{
							strhlfipending="N";
						}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_perapp_fi_pending");
					arrValues.add(strhlfipending);
					arrValues.add(appid.split("@")[0]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						
						if(hidKYCChkSplit[i].contains("BPV") &&hidKYCChkSplit[i].contains("RV")&& hidKYCChkSplit[i].contains("PAN") && hidKYCChkSplit[i].contains("UAN"))
						{
						
							strkycPending="N";
							
						}
						else
						strkycPending="Y";	
						
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_perapp_kyc_pending");
						arrValues.add(strkycPending);
						arrValues.add(appid.split("@")[0]);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
					//0 BPV  1 RV  2 PAN   3 CV  4 BNK 5 ITR 6 GSTIN   7 UAN   8 BS        9 TPL   	10	SFFS  11 CLC  12 CLI 13 DOC			
						
						if(hidKYCChkSplit[i].contains("BS") &&hidKYCChkSplit[i].contains("TPL")&&hidKYCChkSplit[i].contains("SFFS"))
						{
							strFinancailPending="N";
						}
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_perapp_financial_pending");
						arrValues.add(strFinancailPending);
						arrValues.add(appid.split("@")[0]);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						
						if(hidKYCChkSplit[i].contains("CLC"))
						{
							strOthersPending="N";
						}
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_perapp_others_pending");
						arrValues.add(strOthersPending);
						arrValues.add(appid.split("@")[0]);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						
						
						
						String[] hidKYCChkSplitVal=hidKYCChkSplit[i].split("@");
						if(!hidKYCChkSplitVal.equals(""))
						{
							String StrDocVal=hidKYCChkSplitVal[1]+"@"+hidKYCChkSplitVal[4]+"@"+hidKYCChkSplitVal[7]+"@"+hidKYCChkSplitVal[10]+"@"+hidKYCChkSplitVal[13]+"@"+hidKYCChkSplitVal[16]+"@"+hidKYCChkSplitVal[19]+"@"+hidKYCChkSplitVal[22]+"@"+hidKYCChkSplitVal[25]+"@"+hidKYCChkSplitVal[28]+"@"+hidKYCChkSplitVal[31]+"@"+hidKYCChkSplitVal[34]+"@"+hidKYCChkSplitVal[37]+"@"+hidKYCChkSplitVal[40]+"@";//+hidKYCChkSplitVal[28]+"@";//+hidKYCChkSplitVal[31]+"@";
							String StrDocDate=hidKYCChkSplitVal[2]+"@"+hidKYCChkSplitVal[5]+"@"+hidKYCChkSplitVal[8]+"@"+hidKYCChkSplitVal[11]+"@"+hidKYCChkSplitVal[14]+"@"+hidKYCChkSplitVal[17]+"@"+hidKYCChkSplitVal[20]+"@"+hidKYCChkSplitVal[23]+"@"+hidKYCChkSplitVal[26]+"@"+hidKYCChkSplitVal[29]+"@"+hidKYCChkSplitVal[32]+"@"+hidKYCChkSplitVal[35]+"@"+hidKYCChkSplitVal[38]+"@"+hidKYCChkSplitVal[41]+"@";//+hidKYCChkSplitVal[29]+"@";//+hidKYCChkSplitVal[32]+"@";
							String StrDocUser=hidKYCChkSplitVal[3]+"@"+hidKYCChkSplitVal[6]+"@"+hidKYCChkSplitVal[9]+"@"+hidKYCChkSplitVal[12]+"@"+hidKYCChkSplitVal[15]+"@"+hidKYCChkSplitVal[18]+"@"+hidKYCChkSplitVal[21]+"@"+hidKYCChkSplitVal[24]+"@"+hidKYCChkSplitVal[27]+"@"+hidKYCChkSplitVal[30]+"@"+hidKYCChkSplitVal[33]+"@"+hidKYCChkSplitVal[36]+"@"+hidKYCChkSplitVal[39]+"@"+hidKYCChkSplitVal[42]+"@";//+hidKYCChkSplitVal[30]+"@";//+hidKYCChkSplitVal[33]+"@";
							
							hshQueryValues=new HashMap();
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_verifydocument");
							arrValues.add(strAppno);
							arrValues.add(String.valueOf(hidKYCChkSplitVal[0]));
							arrValues.add(String.valueOf(StrDocVal));
							arrValues.add(StrDocDate);
							arrValues.add(StrDocUser);
							arrValues.add(strAdd);
							arrValues.add(strEmpl);
							arrValues.add(strBnkstmt);
							arrValues.add(str_sms_flag);
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add(strpermobtaind);
							arrValues.add(strdevrefnum);
							arrValues.add(strdevremarks);
							arrValues.add("");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}

					}
				}
				}
			
				
				else if(strAction.equalsIgnoreCase("updateCBS"))
				{
						
				if(!hidKYCChk.equalsIgnoreCase("")){
					String strInwrdNo="";
					 strQuery = SQLParser.getSqlQuery("compropform6^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strInwrdNo = Helper.correctNull((String)rs.getString("APP_INWARDNO"));			
						}
				
					String cbsId[]=hidKYCChk.split("@");
					String strCustomerID = cbsId[1];
					String strApplicantID = cbsId[0];

					
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_perappname^" + strCustomerID);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						String perapp = Helper.correctNull(rs.getString("PERAPP_ID"));
						String perappolid = Helper.correctNull(rs.getString("perapp_oldid"));
						
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_ucicrenew");
						arrValues.add("y");//PERAPP_RENEW
						arrValues.add(perappolid);//PERAPP_OLDID
						arrValues.add(strApplicantID);//PERAPP_ID
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_ucicrenewold");
						arrValues.add(perappolid);//perapp_oldid
						arrValues.add("n");//PERAPP_RENEW
						arrValues.add("Y");//perapp_dedupeflag
						arrValues.add("Y");//perapp_ucicflag
						arrValues.add(strCustomerID);//perapp_cbsid
						arrValues.add(strApplicantID);//perapp_id
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);
						hshQueryValues.put("size","2");
						
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("selcomdemo^" + strApplicantID);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_uciccomdemo");
						arrValues.add(perappolid);//demo_oldappid
						arrValues.add(strAppno);//demo_appno
						arrValues.add(strApplicantID);//demo_appid
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("3",hshQuery);
						hshQueryValues.put("size","3");
						}else{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_uciccomcompanydet");
							arrValues.add(perappolid);//demo_oldappid
							arrValues.add(strAppno);//demo_appno
							arrValues.add(strApplicantID);//demo_appid
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("3",hshQuery);
							hshQueryValues.put("size","3");	
						}
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_cbsid_inwardreg");
						arrValues.add(strCustomerID);//INWARD_CBSCUSTID
						arrValues.add(strInwrdNo);//INWARD_NO
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("4",hshQuery);
						hshQueryValues.put("size","4");
						
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("selcomdemo^" + strApplicantID);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}else{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_cbsid_perapp");
					arrValues.add(cbsId[1]);
					arrValues.add(cbsId[0]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				
					strQuery = SQLParser.getSqlQuery("sel_appId_comdemo^"+cbsId[0]+"^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "upd_cbsid_inwardreg");
							arrValues.add(cbsId[1]);
							arrValues.add(strInwrdNo);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
					}	
					
				}	
				
				}
				
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException("Error in DigitalAppInterface Bean updateSanctionDetails..."+e.toString());
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
					throw new EJBException("Error in DigitalAppInterface Bean updateSanctionDetails in clossing connection..."+e.toString());
				}
			}

		return hshValues;
		}

		public HashMap msmeGetDigiDecisionDetail(HashMap hshValues)  
		{
			ResultSet rs=null,rs1=null;
			String strAppno=Helper.correctNull((String) hshValues.get("strappno"));
			if(strAppno.equals(""))
			{
				strAppno=Helper.correctNull((String) hshValues.get("appno"));
			}
			String strQuery="";
			try
			{
				ArrayList arrcol=new ArrayList();
				ArrayList arrrow=new ArrayList();
				
				//applicant coapplicant cibil score
				if (rs != null) 
					rs.close();
				int cnt=0;
				rs = DBUtils.executeLAPSQuery("sel_corp_appl_cibildetails^" + strAppno);
				if(rs.next())
				{ cnt=cnt+1;
					arrcol=new ArrayList();
					arrcol.add(Helper.correctNull((String)rs.getString("perapp_fname")));//0
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//1
					arrcol.add(Helper.correctNull((String)rs.getString("CIBIL_SCORE")));//2
					arrcol.add("a");//3
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ADDRESSCHANGE_FLAG")));//4
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PAN_FLAG")));//5
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIADDRESS_FLAG")));//6
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIEMP_FLAG")));//7
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIBANKSTAT_FLAG")));//8
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ID")));//9
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMPLOYMENT")));//10
					arrcol.add("0");//11
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKNAME")));//12
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKACC")));//13
					
					String strphoto="",strsign="",strmanualcheck="";
					
					if(!Helper.correctNull((String)rs.getString("PERAPP_ID")).equalsIgnoreCase(""))
					{
						rs1 = DBUtils.executeLAPSQuery("sel_verifydocument^" + strAppno+"^"+Helper.correctNull((String)rs.getString("PERAPP_ID")));
						if(rs1.next())
						{
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_CHKBOX_VALUE")));//14     
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_CHKBOX_DATE")));//15     
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_USERID")));//16      
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_ADDRESS")));//17
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_EMPLOYMENT")));//18
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_BANKSTAT")));//19
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_SMS_SENT_FLAG")));//20
						
							strphoto=Helper.correctNull((String)rs1.getString("VERI_PHOTOGRAPH"));
							strsign=Helper.correctNull((String)rs1.getString("VERI_SPECIMEN_SIGN"));
							strmanualcheck=Helper.correctNull((String)rs1.getString("VERI_MANCHECK_COMPLETED"));
							
						}
						else
						{
							arrcol.add("");//14
							arrcol.add("");//15
							arrcol.add("");//16
							arrcol.add("");//17
							arrcol.add("");//18
							arrcol.add("");//19
							arrcol.add("");//20
						}
					}
					else
					{
						arrcol.add("");//14
						arrcol.add("");//15
						arrcol.add("");//16
						arrcol.add("");//17
						arrcol.add("");//18
						arrcol.add("");//19
						arrcol.add("");//20
					}
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PERM_ADDRESSCHANGE_FLAG")));//21
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMANDATE_FLAG")));//22
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSCUSTFLAG")));//23
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_KYCPEND_FLAG")));//24
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIPEND_FLAG")));//25
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMANPEND_FLAG")));//26
					
					arrcol.add(strphoto);//27
					arrcol.add(strsign);//28
					arrcol.add(strmanualcheck);//29
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BUSINESSPROOF_FLAG")));//30
					arrcol.add(Helper.correctNull((String)rs.getString("PER_ITR_FLAG")));//31
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_OFFICEADDRESS_FLAG")));//32
				
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_COLLATERAL_FLAG")));//33
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_RESIDENCE_VISIT_FLAG")));//34
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BUSINESS_VISIT_FLAG")));//35
					arrcol.add(Helper.correctNull((String)rs.getString("PEAPP_GSTIN_FLAG")));//36
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_UAN_FLAG")));//37
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BALANCESHEET_FLAG")));//38
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_TRADING_ACC_FLAG")));//39
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FINANCIAL_FLAG")));//40
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_LITIGATION_CORP_FLAG")));//41
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_LITIGATION_IND_FLAG")));//42
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_DOC_SUBMITTED_FLAG")));//43
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FINANCIAL_PEND_FLAG")));//44
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_OTHERS_PEND_FLAG")));//45
					arrrow.add(arrcol);
				}
				
				if (rs != null) 
					rs.close();
				
				rs = DBUtils.executeLAPSQuery("sel_corp_coappl_cibildetails^" + strAppno);
				while(rs.next())
				{
					cnt=cnt+1;
					arrcol=new ArrayList();
					arrcol.add(Helper.correctNull((String)rs.getString("perapp_fname")));//0
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//1
					arrcol.add(Helper.correctNull((String)rs.getString("CIBIL_SCORE")));//2
					arrcol.add(Helper.correctNull((String)rs.getString("COM_COMPDTTYPE")));//3
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ADDRESSCHANGE_FLAG")));//4
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PAN_FLAG")));//5
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIADDRESS_FLAG")));//6
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIEMP_FLAG")));//7
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIBANKSTAT_FLAG")));//8
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ID")));//9
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMPLOYMENT")));//10
					arrcol.add("0");//11
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKNAME")));//12
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKACC")));//13
					
					String strphoto="",strsign="",strmanualcheck="";
					
					if(!Helper.correctNull((String)rs.getString("PERAPP_ID")).equalsIgnoreCase(""))
					{
						rs1 = DBUtils.executeLAPSQuery("sel_verifydocument^" + strAppno+"^"+Helper.correctNull((String)rs.getString("PERAPP_ID")));
						if(rs1.next())
						{
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_CHKBOX_VALUE")));//14     
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_CHKBOX_DATE")));//15     
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_USERID")));//16      
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_ADDRESS")));//17
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_EMPLOYMENT")));//18
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_FI_BANKSTAT")));//19
							arrcol.add(Helper.correctNull((String)rs1.getString("VERI_SMS_SENT_FLAG")));//20
						
							strphoto=Helper.correctNull((String)rs1.getString("VERI_PHOTOGRAPH"));
							strsign=Helper.correctNull((String)rs1.getString("VERI_SPECIMEN_SIGN"));
							strmanualcheck=Helper.correctNull((String)rs1.getString("VERI_MANCHECK_COMPLETED"));
							
						}
						else
						{
							arrcol.add("");//14
							arrcol.add("");//15
							arrcol.add("");//16
							arrcol.add("");//17
							arrcol.add("");//18
							arrcol.add("");//19
							arrcol.add("");//20
						}
					}
					else
					{
						arrcol.add("");//14
						arrcol.add("");//15
						arrcol.add("");//16
						arrcol.add("");//17
						arrcol.add("");//18
						arrcol.add("");//19
						arrcol.add("");//20
					}
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PERM_ADDRESSCHANGE_FLAG")));//21
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMANDATE_FLAG")));//22
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSCUSTFLAG")));//23
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_KYCPEND_FLAG")));//24
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIPEND_FLAG")));//25
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMANPEND_FLAG")));//26
					
					arrcol.add(strphoto);//27
					arrcol.add(strsign);//28
					arrcol.add(strmanualcheck);//29
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BUSINESSPROOF_FLAG")));//30
					arrcol.add(Helper.correctNull((String)rs.getString("PER_ITR_FLAG")));//31
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_OFFICEADDRESS_FLAG")));//32
				
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_COLLATERAL_FLAG")));//33
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_RESIDENCE_VISIT_FLAG")));//34
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BUSINESS_VISIT_FLAG")));//35
					arrcol.add(Helper.correctNull((String)rs.getString("PEAPP_GSTIN_FLAG")));//36
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_UAN_FLAG")));//37
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_BALANCESHEET_FLAG")));//38
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_TRADING_ACC_FLAG")));//39
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FINANCIAL_FLAG")));//40
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_LITIGATION_CORP_FLAG")));//41
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_LITIGATION_IND_FLAG")));//42
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_DOC_SUBMITTED_FLAG")));//43
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FINANCIAL_PEND_FLAG")));//44
					arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_OTHERS_PEND_FLAG")));//45
					arrrow.add(arrcol);
				}
				
				hshValues.put("cibilarrrow", arrrow);
				
				//appplication score
				if (rs != null) 
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_digi_deviationdet^"+ strAppno+"^S");
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					hshValues.put("ApplicationScore", Helper.correctNull((String)rs.getString("DIGI_DEV_CIBIL")) );
				}
				
				//valuation
				if (rs != null) 
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_check_valuationentry^" + strAppno);
				if(rs.next())
				{
					hshValues.put("ValuationEntryFlag","Y");
					hshValues.put("valuationAmount", Helper.correctNull((String)rs.getString("ESTI_VAL_FORCE")));
				}
				else
				{
					hshValues.put("ValuationEntryFlag","N");
				}
				
				//deviation
				if (rs != null) 
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_check_digiDeviation^" + strAppno);
				if(rs.next())
				{
					hshValues.put("digideviationFlag","Y");
				}
				else
				{
					hshValues.put("digideviationFlag","N");
				}
				
				//loan amount
				if (rs != null) 
					rs.close();
				rs = DBUtils.executeLAPSQuery("getloanterms^" + strAppno);
				if(rs.next())
				{
					hshValues.put("loan_recmdamt", Helper.correctNull((String)rs.getString("loan_recmdamt")));
					hshValues.put("LOAN_DIGI_TOT_PROCESSINGFEE", Helper.correctNull((String)rs.getString("LOAN_DIGI_TOT_PROCESSINGFEE")));
					hshValues.put("LOAN_DIGI_PROCESSINGFEEPAID", Helper.correctNull((String)rs.getString("LOAN_DIGI_PROCESSINGFEEPAID")));
					
				}
				if(Helper.correctNull((String) hshValues.get("hidAction")).equalsIgnoreCase("Submit"))
				{
					hshValues.put("Submitstatus", "Sucess");
				}
				if(Helper.correctNull((String) hshValues.get("hidAction")).equalsIgnoreCase("reject"))
				{
					hshValues.put("rejectstatus", "Sucess");
				}
				
				
				String strAppHolder="";
				strQuery = SQLParser.getSqlQuery("sel_cbsaccno^" + strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					strAppHolder = correctNull((String) rs1.getString("app_applnholder"));
				}
				hshValues.put("strAppHolder", strAppHolder);
				hshValues.put("cnt", String.valueOf(cnt));
				
				strQuery = SQLParser.getSqlQuery("sel_amberCheck^" + strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strVERIPERMOBT", Helper.correctNull((String)rs1.getString("VERI_PERM_OBT")));
					hshValues.put("strVERIDEVREFNUM", Helper.correctNull((String)rs1.getString("VERI_DEVREF_NUM")));
					hshValues.put("strVERIDEVREMARK", Helper.correctNull((String)rs1.getString("VERI_DEV_REMARK")));

				}
				strQuery = SQLParser.getSqlQuery("sel_app_perm_no^" + strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strAPPAMBEREXISTS", Helper.correctNull((String)rs1.getString("APP_AMBER_EXISTS")));

				}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in MsmeDigitalAppInterface Bean msmeGetDigiDecisionDetail..."+e.toString());
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
					throw new EJBException("Error in MsmeDigitalAppInterface Bean msmeGetDigiDecisionDetail in closing connection..."+e.toString());
				}
			}
			return hshValues;
		
		}	
		
		public HashMap updateSubmitData(HashMap hshValues) 
		{
			//SMS Service for 
			String strAction = "", application_flag="", strAppno = "", strModuleType = "", strInwardno ="";
			ResultSet rs = null;
			HashMap hshQuery = new HashMap(); 
			HashMap hshQueryValues = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			
			strAction=(String)hshValues.get("hidAction");
			strAppno=(String)hshValues.get("appno");
			strModuleType=correctNull((String)hshValues.get("hidCategoryType"));
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			try {
				
				
				
				
				//--------------Start For Getting Application Status from Database---------------
				rs=DBUtils.executeLAPSQuery("commworkflowsel2^"+strAppno);
				if(rs.next())
				{
					//appstatus1 = correctNull((String)rs.getString("app_status"));
					application_flag=Helper.correctNull((String)rs.getString("app_renew_flag"));
				}
				
				//--------------End For Getting Application Status from Database---------------
				//logic for SMS Services
				if((strAction.equalsIgnoreCase("Submit")||strAction.equalsIgnoreCase("reject"))&& ApplicationParams.getSMSFlag().equalsIgnoreCase("TRUE") &&
						!application_flag.equalsIgnoreCase("P"))
				{
					boolean bflag=false,bdflag=false;
					String strAgentID="";
					if(rs!=null)
						rs.close();
					
					rs=DBUtils.executeLAPSQuery("sel_inwarddetails^"+strInwardno);
					if(rs.next())
					{
						if((Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("6"))
//								&&(Helper.correctNull(rs.getString("inward_bankscheme")).equalsIgnoreCase("003")||Helper.correctNull(rs.getString("inward_bankscheme")).equalsIgnoreCase("102"))
								)
						{
							bflag=true;
						}
						strAgentID=Helper.correctNull(rs.getString("INWARD_AGENTID"));
						if(Helper.correctNull(rs.getString("INWARD_CANVASSEDBYSTAFF")).equalsIgnoreCase("N") && !strAgentID.equalsIgnoreCase(""))
							bdflag=true;
					}
					
					if(bflag)
					{
						String strMessage="",strMobileno="",strRejReason="";
						if(rs!=null)
							rs.close();
						
						rs=DBUtils.executeLAPSQuery("sel_sms_master");
						if(rs.next())
						{
							if(strAction.equalsIgnoreCase("Submit"))
								strMessage=Helper.correctNull(rs.getString("sms_approved"));
							else
								strMessage=Helper.correctNull(rs.getString("sms_reject"));
						}
						
						if(rs!=null)
							rs.close();
						
						rs=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strAppno);
						if(rs.next())
						{
							strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("perapp_fname")));
							strMessage=strMessage.replaceAll("@SAMT", Helper.correctDouble(rs.getString("loan_recmdamt")));
							strMobileno=Helper.correctNull(rs.getString("con_mobile"));
						}
						
						if(strAction.equalsIgnoreCase("reject"))
						{
							if(rs!=null)
								rs.close();
							int a=1;
							rs=DBUtils.executeLAPSQuery("sel_rejdesc^"+strAppno);
							while(rs.next())
							{
								strRejReason=strRejReason+(a++)+") "+Helper.correctNull(rs.getString("rej_desc"))+"\n";
							}
						}
						
						strMessage=strMessage.replaceAll("@LARNO", strInwardno).replaceAll("@REJRSON", strRejReason);
						
						if(!strMobileno.equalsIgnoreCase(""))
						{
							//log.info("================== Message Service================");
							String charset="UTF-8",strFileIds="";
							
							String query = null;
							URLConnection conn = null;
							
							try{
								query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
										ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
												ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
												.encode(strMobileno, charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
												URLEncoder.encode(strMessage, charset));
								
								//log.info("==================Invoking Service in Try Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
								conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
								//log.info("================== Service Ended================");
								
								
							}catch(Exception e)
							{
								query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+strMobileno+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
								//log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
								conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
								//log.info("================== Service Ended================");
								
							}
							
							conn.setDoOutput(true);
							conn.setRequestProperty("Accept-Charset", charset);
							BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
							String output ="";
							while ((output = br.readLine()) != null) {
								strFileIds = output;
							}
							
							
							hshQuery = new HashMap();
							hshQueryValues = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strMobileno);
							arrValues.add(strMessage);
							arrValues.add(strFileIds);
							arrValues.add(strInwardno);
							hshQuery.put("strQueryId", "ins_smshistroy");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
							
						}
					
					
					} 
				} 
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("Exception in SMS Services ");
				e.printStackTrace();
				throw new EJBException("Exception in SMS Services ==="+e.getMessage());
			}
			return hshValues;
		} 	
		

		public HashMap financialCreation(HashMap hshValues) 
				{
					
					String strAction = "", application_flag="", strAppno = "", strModuleType = "", strInwardno ="",strappid="";
					ResultSet rs = null;
					HashMap hshQuery = new HashMap(); 
					HashMap hshQueryValues = new HashMap();
					ArrayList arrValues = new ArrayList();	
				

					String strcma="",finFormat="",strRowId="0",strSno="",valuearein;
					int intmaxfinid=0;
					String  liabilityLen=(String) hshValues.get("jsonLValueLen");
					//int intliabilityLen=Integer.valueOf(liabilityLen);
				try{

					
					
					ArrayList arrliabilities=new ArrayList();
					ArrayList arrliabilitiesval=new ArrayList();
					ArrayList arrmapvalues=new ArrayList();
					HashMap values = new HashMap();
					arrliabilities=(ArrayList) hshValues.get("arrliabilities");
					String  strcbsid=(String) hshValues.get("strcbsId"); 
					
					finFormat=(String) hshValues.get("strfinancialFormat");
					valuearein=(String) hshValues.get("strvaluesAreIn");
					rs=DBUtils.executeLAPSQuery("sel_cmano_master^"+finFormat);
					if(rs.next())
					{
						strcma=Helper.correctNull(rs.getString("CMA_NO"));
		//						
						
						}
					
					rs=DBUtils.executeLAPSQuery("sel_appid_perapp^"+strcbsid);
					if(rs.next())
					{
						strappid=Helper.correctNull(rs.getString("perapp_id"));
							
						
						}
					
					
					rs=DBUtils.executeLAPSQuery("maxfinanceid^"+strappid);
					if(rs.next())
					{
						intmaxfinid=rs.getInt(("fin_financeid"));
		//						
						
						}
					
					//strappid="483522";//need to  change
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strappid);
					arrValues.add(strcma);
					arrValues.add("0");
					arrValues.add("N");
					arrValues.add(String.valueOf(intmaxfinid));
					arrValues.add("N");
					arrValues.add("");
					arrValues.add(valuearein);
					hshQuery.put("strQueryId", "comfinance_appid_insert_valuesin");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
														
					HashMap arrLiableDate=new HashMap();
					ArrayList arrMap=new ArrayList();
					int arrliabilitiesLen=arrliabilities.size();
					int increment=0,intDate=0,liablequeryinc=0,liafinSno=1;
					
				if(arrliabilitiesLen>0)
				{
				while(increment<arrliabilitiesLen)
					
				{
					
					liablequeryinc=1;
					for(int i=0;i<Integer.valueOf(liabilityLen);i++)
						{
							strRowId="0";
							arrLiableDate=new  HashMap();
							arrliabilitiesval=(ArrayList) arrliabilities.get(increment);
			
							arrLiableDate=((HashMap)arrliabilitiesval.get(0));
							arrMap=((ArrayList)arrliabilitiesval.get(1));
							String strtab=(String) arrLiableDate.get("tab");
							
							
							int arrMaplength=arrMap.size();
							
		
									arrmapvalues=(ArrayList) arrMap.get(i);
									
									
									
									rs=DBUtils.executeLAPSQuery("sel_finmaster_rowid^"+strtab+"^"+strcma+"^"+arrmapvalues.get(1));
									if(rs.next())
									{
										strRowId=Helper.correctInt(rs.getString("FIN_ROWID")); 
									
										
									}
									
									//strRowId="1212";
									if((arrLiableDate.get("type")).equals("AUDITED"))
									{
										values.put("Audited", arrmapvalues.get(0));
										hshQuery = new HashMap();
										arrValues = new ArrayList();
										arrValues.add(String.valueOf(intmaxfinid));
										arrValues.add(values.get("Audited"));
										arrValues.add(strRowId);
										arrValues.add((String)arrLiableDate.get("endperiod"));
										arrValues.add(String.valueOf(liafinSno));
										arrValues.add("0");
										arrValues.add("0");
										arrValues.add("0");
										arrValues.add("0");
										hshQuery.put("strQueryId", "ins_finappVaues_financial_audited");
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put(String.valueOf(liablequeryinc), hshQuery);
										hshQueryValues.put("size", String.valueOf(liablequeryinc));
									}
										else if((arrLiableDate.get("type")).equals("UNAUDITED"))
										{
											values.put("Unaudited", arrmapvalues.get(0));
									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									arrValues.add(String.valueOf(intmaxfinid));
									arrValues.add(values.get("Unaudited"));
									arrValues.add(strRowId);
									arrValues.add((String)arrLiableDate.get("endperiod"));
									arrValues.add(String.valueOf(liafinSno));
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									hshQuery.put("strQueryId", "ins_finappVaues_financial_unaudited");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(String.valueOf(liablequeryinc), hshQuery);
									hshQueryValues.put("size", String.valueOf(liablequeryinc));
									
						}
										else if((arrLiableDate.get("type")).equals("ESTIMATED"))
										{
											values.put("Estimated", arrmapvalues.get(0));
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									arrValues.add(String.valueOf(intmaxfinid));
									arrValues.add(values.get("Estimated"));
									arrValues.add(strRowId);
									arrValues.add((String)arrLiableDate.get("endperiod"));
									arrValues.add(String.valueOf(liafinSno));
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									hshQuery.put("strQueryId", "ins_finappVaues_financial_estimated");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(String.valueOf(liablequeryinc), hshQuery);
									hshQueryValues.put("size", String.valueOf(liablequeryinc));
										
										}if((arrLiableDate.get("type")).equals("PROJECTION"))
										 {
											values.put("Projected", arrmapvalues.get(0));
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									arrValues.add(String.valueOf(intmaxfinid));
									arrValues.add(values.get("Projected"));
									arrValues.add(strRowId);
									arrValues.add((String)arrLiableDate.get("endperiod"));
									arrValues.add(String.valueOf(liafinSno));
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									hshQuery.put("strQueryId", "ins_finappVaues_financial_projected");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(String.valueOf(liablequeryinc), hshQuery);
									hshQueryValues.put("size", String.valueOf(liablequeryinc));
										 }
								
									liablequeryinc+=1;
								
						}
						
						
						increment+=1;
						//intDate=1;
						liafinSno+=1;
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
				
				
					}
				
				ArrayList arrAssts=new ArrayList();
				String  asstsLength=(String) hshValues.get("jsonAValueLen");
				arrAssts=(ArrayList) hshValues.get("arrassets");
				/*ArrayList arrAssets =new ArrayList();
				arrAssets= (ArrayList) hshValues.get("arrassets");	*/
				int arrAssetssize=arrAssts.size();
				String strAssetsSno="";
				ArrayList arrassetsValues=new ArrayList();
				HashMap arrAssetsdate=new  HashMap();
				ArrayList arrAssetsMap=new ArrayList();
				int intAssets=0,intAssetsDate=0,assetsqueryinc=0,assetsSno=1,yearinc=1;
				ArrayList arrAssetsmapvalues=new ArrayList();
				int asstesincrement=0,finsno=1;
				if(arrAssetssize>0)
				{	
				while(intAssets<arrAssetssize)
				{
					
					//assetsSno=0;
					asstesincrement=0;
					assetsqueryinc=0;
					assetsqueryinc+=1;
					intAssetsDate=0;
					
					for(int i=0;i<Integer.valueOf(asstsLength);i++)
					{  
						strRowId="0";
						arrAssetsdate=new  HashMap();
						arrassetsValues=(ArrayList) arrAssts.get(intAssets);
						arrAssetsdate=((HashMap)arrassetsValues.get(0));
						arrAssetsMap=((ArrayList)arrassetsValues.get(1));
						String strAssetstab=(String) arrAssetsdate.get("tab");
						
						
						int arrAssetsMaplength=arrAssetsMap.size();
						
						
						
							/*for(int j=0;j<arrliabilitiesLen;j++)
							{*/
								arrAssetsmapvalues=(ArrayList) arrAssetsMap.get(i);
								
								
								
								rs=DBUtils.executeLAPSQuery("sel_finmaster_rowid^"+strAssetstab+"^"+strcma+"^"+arrAssetsmapvalues.get(1));
				
								if(rs.next())
								{
									strRowId=Helper.correctInt(rs.getString("FIN_ROWID")); 
								
									
								}
				
								if(intAssets==i)
								{
								
								hshQuery = new HashMap();
								//hshQueryValues = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(assetsSno));
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(arrAssetsdate.get("type"));
								arrValues.add("0");
								arrValues.add(arrAssetsdate.get("endperiod"));
								arrValues.add(arrAssetsdate.get("startingPeriod"));
								hshQuery.put("strQueryId", "ins_corp_year_date");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(assetsqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(assetsqueryinc));
								//EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								assetsqueryinc+=1;
								assetsSno+=1;
								}
								
								if((arrAssetsdate.get("type")).equals("AUDITED"))
								{
									values.put("Audited", arrAssetsmapvalues.get(0));
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									arrValues.add(String.valueOf(intmaxfinid));
									arrValues.add(values.get("Audited"));
									arrValues.add(strRowId);
									arrValues.add((String)arrAssetsdate.get("endperiod"));
									arrValues.add(String.valueOf(finsno));
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									hshQuery.put("strQueryId", "ins_finappVaues_financial_audited");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(String.valueOf(assetsqueryinc), hshQuery);
									hshQueryValues.put("size", String.valueOf(assetsqueryinc));
								}
									else if((arrAssetsdate.get("type")).equals("UNAUDITED"))
									{
										values.put("Unaudited", arrAssetsmapvalues.get(0));
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Unaudited"));
								arrValues.add(strRowId);
								arrValues.add((String)arrAssetsdate.get("endperiod"));
								arrValues.add(String.valueOf(finsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_unaudited");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(assetsqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(assetsqueryinc));
								
					}
									else if((arrAssetsdate.get("type")).equals("ESTIMATED"))
									{
										values.put("Estimated", arrAssetsmapvalues.get(0));
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Estimated"));
								arrValues.add(strRowId);
								arrValues.add((String)arrAssetsdate.get("endperiod"));
								arrValues.add(String.valueOf(finsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_estimated");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(assetsqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(assetsqueryinc));
									
									}if((arrAssetsdate.get("type")).equals("PROJECTION"))
									 {
										values.put("Projected", arrAssetsmapvalues.get(0));
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Projected"));
								arrValues.add(strRowId);
								arrValues.add((String)arrAssetsdate.get("endperiod"));
								arrValues.add(String.valueOf(finsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_projected");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(assetsqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(assetsqueryinc));
									 }
										
		
									assetsqueryinc+=1;
									intAssetsDate+=1;
								
					}
					
					//strRowId="12202";//need to change
					
					
					
					
					intAssets+=1;
					asstesincrement+=1;
					
					finsno+=1;
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				}
			

				
				
				
				String  strPLlenth=(String) hshValues.get("jsonPLValueLen");
				ArrayList arrpolo =new ArrayList();
				arrpolo= (ArrayList) hshValues.get("arrprofitLossAcc");	
				int intpllength=arrpolo.size();
				String strplSno="";
				ArrayList arrplvalues=new ArrayList();
				HashMap arrpldate=new  HashMap();
				ArrayList arrplMap=new ArrayList();
				ArrayList arrplMapValue=new ArrayList();
				int plincrement=0,intPlDate=0,plqueryinc=0,plfinsno=1;
				int arrplincrement=0;
				if(intpllength>0)
				{	
				while(plincrement<intpllength)
				{
					
					plqueryinc=1;
					for(int i=0;i<Integer.valueOf(strPLlenth);i++)
					{
						strRowId="0";
						arrpldate=new  HashMap();
						arrplvalues=(ArrayList) arrpolo.get(plincrement);
		
						arrpldate=((HashMap)arrplvalues.get(0));
						arrplMap=((ArrayList)arrplvalues.get(1));
						String strpltab=(String) arrpldate.get("tab");
						
						
						int arrPLMapLength=arrplMap.size();
						
		
						arrplMapValue=(ArrayList) arrplMap.get(i);
								
								
								
								rs=DBUtils.executeLAPSQuery("sel_finmaster_rowid^"+strpltab+"^"+strcma+"^"+arrplMapValue.get(1));
				
								if(rs.next())
								{
									strRowId=Helper.correctInt(rs.getString("FIN_ROWID")); 
								
									
								}
								
							
								//strRowId="1231";
					
								if((arrpldate.get("type")).equals("AUDITED"))
								{
									values.put("Audited", arrplMapValue.get(0));
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									arrValues.add(String.valueOf(intmaxfinid));
									arrValues.add(values.get("Audited"));
									arrValues.add(strRowId);
									arrValues.add((String)arrpldate.get("endperiod"));
									arrValues.add(String.valueOf(plfinsno));
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									arrValues.add("0");
									hshQuery.put("strQueryId", "ins_finappVaues_financial_audited");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(String.valueOf(plqueryinc), hshQuery);
									hshQueryValues.put("size", String.valueOf(plqueryinc));
								}
									else if((arrpldate.get("type")).equals("UNAUDITED"))
									{
										values.put("Unaudited", arrplMapValue.get(0));
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Unaudited"));
								arrValues.add(strRowId);
								arrValues.add((String)arrpldate.get("endperiod"));
								arrValues.add(String.valueOf(plfinsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_unaudited");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(plqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(plqueryinc));
								
					}
									else if((arrpldate.get("type")).equals("ESTIMATED"))
									{
										values.put("Estimated", arrplMapValue.get(0));
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Estimated"));
								arrValues.add(strRowId);
								arrValues.add((String)arrpldate.get("endperiod"));
								arrValues.add(String.valueOf(plfinsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_estimated");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(plqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(plqueryinc));
									
									}if((arrpldate.get("type")).equals("PROJECTION"))
									 {
										values.put("Projected", arrplMapValue.get(0));
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(String.valueOf(intmaxfinid));
								arrValues.add(values.get("Projected"));
								arrValues.add(strRowId);
								arrValues.add((String)arrpldate.get("endperiod"));
								arrValues.add(String.valueOf(plfinsno));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("strQueryId", "ins_finappVaues_financial_projected");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(plqueryinc), hshQuery);
								hshQueryValues.put("size", String.valueOf(plqueryinc));
									 }	
									
									plqueryinc+=1;	
								
					}
					
					
				
					arrplincrement+=1;
					plincrement+=1;
					//intPlDate=1;
					plfinsno+=1;
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
				
				}
				rs = DBUtils
				.executeLAPSQuery("sel_comfinRowId^" + String.valueOf(intmaxfinid));
		while (rs.next()) { 
			

			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_com_finappValues");
				arrValues.add(String.valueOf(intmaxfinid));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		}
				hshValues.put("financeId",(String.valueOf(intmaxfinid)));
		
				}
		 catch (Exception e) {
			
			System.out.println("Exception in financial Creation Service");
			e.printStackTrace();
			throw new EJBException("Exception in financial Creation Service === "+e.getMessage());
		}
		return hshValues;	
	}			


		
		public HashMap CorpRenewalProposalCreation(HashMap hshValues)  
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
			String strLimitId="",strMsg="",mclrtabcode="",mclrtype="";
		
				
			try
			{ String strRowId="0";
				
				String strBorrowId=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
				String strCustomerID=Helper.correctNull((String)hshValues.get("strcbsId"));
				String strSolid=Helper.correctNull((String)hshValues.get("strapplicationBranch"));
				//strfinId=Helper.correctNull((String)hshValues.get("strfinId"));
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
				String strType="C";//mck
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
				String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="",strissaral="",strFinancialReq="",strUserDepartment="",strRLPFUser="",stramberExits="";
				String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
				String	strlarNo= Helper.correctNull((String)hshValues.get("strlarNo"));
				stramberExits= Helper.correctNull((String)hshValues.get("stramberExits"));
				
				strQuery = SQLParser.getSqlQuery("sel_orghead_rolevel^"+strSolid);
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
				
				//application table
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","insapplications_digi");
				arrValues.add(strAppno);
				arrValues.add(strLimitId);
				arrValues.add(strUserId);
				arrValues.add(strOrgCode);
				arrValues.add("C");
				arrValues.add(strlarNo);
				arrValues.add("R");
				arrValues.add((strOrgLevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrgLevel);
				arrValues.add(strUserId);
				arrValues.add("Y");
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(strFinancialReq);
				arrValues.add("PC");
				arrValues.add(stramberExits);
				arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
				arrValues.add("");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","updatefacilityrenewflag");
				arrValues.add("R");//Renew
				arrValues.add(correctNull(strAppno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				String strFinStd="0",strIndType="",strIndRating="";
		/*
				if(rs!=null)rs.close();
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
			
				
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","commworkflowins");
					arrValues.add(strAppno);
					arrValues.add(strUserId);
					arrValues.add(strUserId);
					arrValues.add("1");
					arrValues.add("1");
					arrValues.add("C");
					
					arrValues.add(strOrgScode);
					if(correctNull(strOrgLevel).equalsIgnoreCase("C"))
						arrValues.add(strUserDepartment);
					else if(correctNull(strOrgLevel).equalsIgnoreCase("D"))
						arrValues.add(strRLPFUser);
					else
						arrValues.add("");
					
					arrValues.add(strOrgScode);
					if(correctNull(strOrgLevel).equalsIgnoreCase("C"))
						arrValues.add(strUserDepartment);
					else if(correctNull(strOrgLevel).equalsIgnoreCase("D"))
						arrValues.add(strRLPFUser);
					else
						arrValues.add("");
					
					hshQuery.put("arrValues",arrValues);
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
				
					
					String strLoanAmt=Helper.correctNull((String)hshValues.get("strproopsedLimit"));
					
					//loandetails table
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
					
					
					String strFacHead="",strSubFac="";
					if(rs!=null)rs.close();
					rs=DBUtils.executeLAPSQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strLimitId);
					if(rs.next())
					{
					strFacHead = Helper.correctNull((String)rs.getString("com_headfac"));
						strSubFac = Helper.correctNull((String)rs.getString("com_subfac"));
					
					}
					
					String intfacMonths=Helper.correctInt((String)hshValues.get("strtenor"));
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
					String strMetLifeInsurance=Helper.correctNull((String)hshValues.get("strsinglePremium"));
		
					
					//Proposal values
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","insprosalvaluesin");
					arrValues.add(correctNull(strAppno));
					arrValues.add("R");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
										
					//basic info tab
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_basicinfo_digicorp");
					arrValues.add(correctNull(strAppno));
					arrValues.add(Helper.correctNull((String)hshValues.get("proposalFormat")));
					arrValues.add("01");//COM_SANCAUTHORITY
					arrValues.add("007");//COM_SANCDEPT
					arrValues.add("02");//COM_SACTIONLEVEL
					arrValues.add(Helper.correctNull((String)hshValues.get("prioritysector")));
					arrValues.add("R");//COM_AMOUNTVALUE
					arrValues.add(Helper.correctNull((String)hshValues.get("cfrVerified")));
					arrValues.add("N");//COM_CFR_BORNAME
					arrValues.add(Helper.correctNull((String)hshValues.get("cersaiChecked")));
					arrValues.add(Helper.correctNull((String)hshValues.get("processingCharges")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
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
							String strfinacletype="";
							if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("c"))
							{
								strfinacletype="J";
							}
							else
							{
								strfinacletype=Helper.correctNull((String)arrcoappval.get(1));
							}
							
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
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
							arrValues.add(strfinacletype.toUpperCase());
							arrValues.add(Helper.correctNull((String)arrcoappval.get(7)));
							arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					}
										
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comments");
					arrValues.add(strAppno);
					arrValues.add("1");
					arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryProcesnote")));
					arrValues.add("brief");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comments");
					arrValues.add(strAppno);
					arrValues.add("2");
					arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryAnnexure")));
					arrValues.add("brief1");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comments");
					arrValues.add(strAppno);
					arrValues.add("3");
					arrValues.add(Helper.correctNull((String)hshValues.get("briefHistorySourcing")));
					arrValues.add("brief2");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("3", hshQuery);
					hshQueryValues.put("size", "3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
					
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
							hshQuery.put("strQueryId", "ins_comments");
							arrValues.add(strAppno);
							arrValues.add(arrManginfoval.get(0));
							arrValues.add(arrManginfoval.get(1));
							arrValues.add("MangementInfo");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put(String.valueOf(i+1), hshQuery);
						}
						hshQueryValues.put("size", String.valueOf(arrManginfolen));
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}
					
					
					if(Helper.correctNull((String)hshValues.get("strBirRequired")).equalsIgnoreCase("Y"))
					{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","ins_per_bir_facility_prop");
					arrValues.add(strAppno);
					arrValues.add("Y");
					arrValues.add(Helper.correctNull((String)hshValues.get("strSubmissionDate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("strReceiptDate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("strBirReportDate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("strBirCharges")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}
					
					else
					{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","ins_per_bir_facility_prop");
					arrValues.add(strAppno);
					arrValues.add("N");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}
					
		
		
					strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strReferenceType")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					}
					
					 mclrtype=Helper.correctNull((String)hshValues.get("strReferenceType"))+"@"+Helper.correctDouble(Helper.correctNull((String)hshValues.get("strFixedSpread"))+"@"+mclrtabcode);
						//FACILITY_APPNO,FACILITY_MCLRTYPE,MCLR_CRP_TOTAL,MCLR_SPREAD,MCLR_MSME
					 /*	hshQuery = new HashMap();
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
						if(turnoverlength>0)
						{
							for(int i=0;i<turnoverlength;i++)
							{
								arrayturnoverval=(ArrayList) arrayturnover.get(i);
								 hshQuery = new HashMap();
								arrValues = new ArrayList();
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
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
								
								
							}					
						}
						if(turnoverlength>0){
						int balTurnoverlength=5-turnoverlength;
						if(balTurnoverlength>0)
						{
							turnoverlength++;
							for(int j=0;j<balTurnoverlength;j++)
							{
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();
								arrValues = new ArrayList();
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
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
							}
						}
						}
						ArrayList arrayexpnd=new ArrayList();
						ArrayList arrayexpndvalue=new ArrayList();
						arrayexpnd=(ArrayList) hshValues.get("arrayexpenditure");
						int axpenditureLength=arrayturnover.size();
						if(axpenditureLength>0)
						{
							for(int i=0;i<axpenditureLength;i++)
							{
								arrayexpndvalue=(ArrayList) arrayexpnd.get(i);
								 hshQuery = new HashMap();
									arrValues = new ArrayList();
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
									hshQueryValues.put("1", hshQuery);
									hshQueryValues.put("size", "1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
							}
						}	
						if(axpenditureLength>0){
						int balExpditureLength=5-axpenditureLength;
						if(balExpditureLength>0)
						{
							axpenditureLength++;
							for(int j=0;j<balExpditureLength;j++)
							{
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();
								arrValues = new ArrayList();
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
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
							}
						}
						}
						
						ArrayList arrayFacilityDetails=new ArrayList();
						ArrayList arrayFacilityDetailsval=new ArrayList();
						arrayFacilityDetails=(ArrayList) hshValues.get("arrayFacilityDetails");
						
						
						hshQueryValues = new HashMap();
						int intFacilityDetails=arrayFacilityDetails.size();
						int iFacilitySno=0;
						int incrementquery=0;
						
						//main limit data copy
						if(intFacilityDetails>0)
						{
							Connection connectDB2 = ConnectionFactory.getConnection();
							for(int i=0;i<intFacilityDetails;i++)
							{
									arrayFacilityDetailsval=(ArrayList) arrayFacilityDetails.get(i);
									String oldFacNumber=(String) arrayFacilityDetailsval.get(0);
									String oldFacSerialNumber=(String) arrayFacilityDetailsval.get(1);
									
									if (rs != null) 
									{  	rs.close(); }
									strQuery = SQLParser.getSqlQuery("sel_facility_appnosno^"+oldFacNumber+"^0");
									rs = DBUtils.executeQuery(strQuery);
									while(rs.next())
									{
										++iFacilitySno;
										CallableStatement callableStmt2 = connectDB2.prepareCall("call RENEW_APPLICATION_FACSNONEW(?,?,?,?)");
										callableStmt2.setString(1, (String) arrayFacilityDetailsval.get(0));
										callableStmt2.setString(2,Helper.correctNull(strAppno));
										callableStmt2.setString(3,(String) arrayFacilityDetailsval.get(1));
										callableStmt2.setString(4,(String) arrayFacilityDetailsval.get(1));
										callableStmt2.execute();
										callableStmt2.clearParameters();
										callableStmt2.close();
										
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										incrementquery++;
										hshQuery.put("strQueryId","upd_facility_sancamt_digi");								
										arrValues.add(Helper.correctNull((String)hshValues.get(""))); //old proposal sanc amount
										arrValues.add((String) arrayFacilityDetailsval.get(0)); //old proposal no
										arrValues.add((String) arrayFacilityDetailsval.get(1)); //old proposal sno
										arrValues.add("Y"); //renew_flag
										arrValues.add(strAppno); //new appno
										arrValues.add((String) arrayFacilityDetailsval.get(1)); //new fac sno
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(incrementquery));
										hshQueryValues.put(Integer.toString(incrementquery), hshQuery);
		
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										incrementquery++;
										hshQuery.put("strQueryId","updaterenewfacility");
										arrValues.add("Y");
										arrValues.add((String) arrayFacilityDetailsval.get(0)); //old proposal number
										arrValues.add((String) arrayFacilityDetailsval.get(1)); //old proposal sno
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(incrementquery));
										hshQueryValues.put(Integer.toString(incrementquery), hshQuery);
									}
					
									
							}
							connectDB2.close();
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
						}
						
						
						incrementquery=0;
						//sub limit data copy
						if(intFacilityDetails>0)
						{
							Connection connectDB2 = ConnectionFactory.getConnection();
							for(int i=0;i<intFacilityDetails;i++)
							{
									arrayFacilityDetailsval=(ArrayList) arrayFacilityDetails.get(i);
									String oldFacNumber=(String) arrayFacilityDetailsval.get(0);
									String oldFacSerialNumber=(String) arrayFacilityDetailsval.get(1);
									
									if (rs != null) 
									{  	rs.close(); }
									
									strQuery = SQLParser.getSqlQuery("sel_facility_appnosno^"+oldFacNumber+"^"+oldFacSerialNumber);
									rs = DBUtils.executeQuery(strQuery);
									while(rs.next())
									{
										String oldSubLimitProposalnum=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
										String oldSubLimitProposalsno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
										
										++iFacilitySno;
										CallableStatement callableStmt2 = connectDB2.prepareCall("call RENEW_APPLICATION_FACSNONEW(?,?,?,?)");
										callableStmt2.setString(1,oldSubLimitProposalnum);
										callableStmt2.setString(2,Helper.correctNull(strAppno));
										callableStmt2.setString(3,oldSubLimitProposalsno);
										callableStmt2.setString(4,oldSubLimitProposalsno);
										callableStmt2.execute();
										callableStmt2.clearParameters();
										callableStmt2.close();
										
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										incrementquery++;
										hshQuery.put("strQueryId","upd_facility_sancamt_digi");								
										arrValues.add(Helper.correctNull((String)hshValues.get(""))); //old proposal sanc amount
										arrValues.add(oldSubLimitProposalnum); //old proposal no
										arrValues.add(oldSubLimitProposalsno); //old proposal sno
										arrValues.add("Y"); //renew_flag
										arrValues.add(strAppno); //new appno
										arrValues.add(oldSubLimitProposalsno); //new fac sno
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(incrementquery));
										hshQueryValues.put(Integer.toString(incrementquery), hshQuery);
		
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										incrementquery++;
										hshQuery.put("strQueryId","updaterenewfacility");
										arrValues.add("Y");
										arrValues.add(oldSubLimitProposalnum); //old proposal number
										arrValues.add(oldSubLimitProposalsno); //old proposal sno
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(incrementquery));
										hshQueryValues.put(Integer.toString(incrementquery), hshQuery);
									}
							}
							connectDB2.close();
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
						}
						
						
						//update new data
						intUpdatesize=0;
						if(intFacilityDetails>0)
						{
							hshQueryValues=new HashMap();
							for(int i=0;i<intFacilityDetails;i++)
							{
								arrayFacilityDetailsval=(ArrayList) arrayFacilityDetails.get(i);
								String oldFacNumber=(String) arrayFacilityDetailsval.get(0);
								String oldFacSerialNumber=(String) arrayFacilityDetailsval.get(1);
						
								strLimitId=(String) arrayFacilityDetailsval.get(24);
								
								if(rs!=null)rs.close();
								strQuery = SQLParser.getSqlQuery("sel_corpdigiprd_tenor^"+strLimitId+"^"+arrayFacilityDetailsval.get(6)+"^"+arrayFacilityDetailsval.get(33));
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strLimitId=Helper.correctNull((String)rs.getString("COM_FACID"));
								}
								
								String strFacilityDetails="";
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
								
								
								// facility table
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize++;
								hshQuery.put("strQueryId","updfacility_new");								
								arrValues.add(correctNull(strFacHead));//2
								arrValues.add(correctNull(strSubFac));//3
								arrValues.add(correctNull(strBorrowId));//4
								arrValues.add("0.00");//5
								arrValues.add((String) arrayFacilityDetailsval.get(14));//6
								arrValues.add("0");//7
								//arrValues.add(correctNull(strIntadjust));
								arrValues.add(strFacilityDetails);//10
								arrValues.add("");//1
								arrValues.add((String) arrayFacilityDetailsval.get(6));//12	
								//arrValues.add(correctNull(strInterest));//mck
								arrValues.add("");//13
								//arrValues.add(correctNull(strMargin));
								arrValues.add((String) arrayFacilityDetailsval.get(19));//added by suresh for inserting BPLR 14
								//arrValues.add(correctNull(strDP));
								//arrValues.add(correctNull(strOutstanding));
								//arrValues.add(correctNull(strSecurity));
								//arrValues.add(correctNull(strcbsaccno));
								//arrValues.add(correctNull(strfacilityintremarks));
								arrValues.add(Helper.getCurrentDateTime());//15
								//arrValues.add(correctNull(strExistbnktype));
								arrValues.add((String) arrayFacilityDetailsval.get(7));//16
								arrValues.add((String) arrayFacilityDetailsval.get(20));//17
								//added by bhaskar								
								arrValues.add((String) arrayFacilityDetailsval.get(5));//18							
								arrValues.add((String) arrayFacilityDetailsval.get(13));//19
								arrValues.add("");//20
								arrValues.add("");//21
								arrValues.add("");	//22
								arrValues.add("");//23
								arrValues.add((String) arrayFacilityDetailsval.get(20));//24
								arrValues.add(correctNull(strLimitId));//25
								arrValues.add("");//26strFacDetails
								arrValues.add("");//27stragrSchemeType
								arrValues.add((String) arrayFacilityDetailsval.get(17));//28	
								arrValues.add("n");//29
								arrValues.add("");//30
								arrValues.add((String) arrayFacilityDetailsval.get(10));//31
								arrValues.add((String) arrayFacilityDetailsval.get(8));//32								
								arrValues.add((String) arrayFacilityDetailsval.get(25));//33
								arrValues.add("");	//34
								arrValues.add((String) arrayFacilityDetailsval.get(9));//35
								arrValues.add((String) arrayFacilityDetailsval.get(16));//36
								arrValues.add("");
								arrValues.add("");//38
								arrValues.add("");//37
								arrValues.add((String) arrayFacilityDetailsval.get(19));//40
								arrValues.add((String) arrayFacilityDetailsval.get(14));//41
								arrValues.add("2");//42
								arrValues.add("N");//43
								arrValues.add((String) arrayFacilityDetailsval.get(19));//44
								arrValues.add("");//45
								arrValues.add("");
								arrValues.add("");
								arrValues.add("N");
								arrValues.add("R");	
								arrValues.add("");
								arrValues.add((String) arrayFacilityDetailsval.get(22));
								arrValues.add("0");
								arrValues.add("");
								arrValues.add("F");	
								arrValues.add("");
								arrValues.add("Y");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("N");
								arrValues.add((String) arrayFacilityDetailsval.get(27));
								arrValues.add("");
								arrValues.add((String) arrayFacilityDetailsval.get(28));
								arrValues.add((String) arrayFacilityDetailsval.get(29));
								arrValues.add("");
								arrValues.add((String) arrayFacilityDetailsval.get(15));
								arrValues.add((String) arrayFacilityDetailsval.get(26));
								arrValues.add(correctNull(strAppno));//1
								arrValues.add(oldFacSerialNumber);//1
								//strMetLifeInsurance	
								//ended
								if(rs != null)
								{
									rs.close();
								}	
								
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery); 
								
							}
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
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
								
								 hshQuery.put("strQueryId","ins_verification_perapplicant");
								 arrValues.add(arrayappValue.get(0));
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
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
								
							
							}
						}
						
						

			}
			catch(Exception e)
			{
				throw new EJBException("Error in MsmeDigitalAppInterface Bean Renewal Corp ProposalCreation method..."+e.toString());
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
					throw new EJBException("Error in MsmeDigitalAppInterface Bean Renewal Corp ProposalCreation method..."+e.toString());
				}
			}
			
			return hshValues;	
			
		}

		public HashMap CAMService(HashMap hshValues)  
		{
			
			ResultSet rs=null,rs1=null,rs2=null;
			
	
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			HashMap hshRecord=  new HashMap();
			
			try
			{
				ArrayList bureauFresh = new ArrayList();
				bureauFresh=(ArrayList) hshValues.get("arrfresh");
				ArrayList bureaurenewal = new ArrayList();
				bureaurenewal=(ArrayList) hshValues.get("arrrenwal");
				
				
				for(int i=0;i<5;i++)
				{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				hshQuery.put("strQueryId", "ins_consumer_bureau");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(String.valueOf(i+1));
				arrValues.add(((ArrayList) bureauFresh.get(0)).get(i));
				arrValues.add(((ArrayList) bureauFresh.get(1)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(2)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(3)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(4)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(5)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(6)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(7)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(8)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(9)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(10)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(11)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(12)).get(i));
				arrValues.add(((ArrayList)bureauFresh.get(13)).get(i));
								
				arrValues.add(((ArrayList) bureaurenewal.get(0)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(1)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(2)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(3)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(4)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(5)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(6)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(7)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(8)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(9)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(10)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(11)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(12)).get(i));
				arrValues.add(((ArrayList)bureaurenewal.get(13)).get(i));
				
				
				/*arrValues.add(Helper.correctNull((String) hshValues.get("strcmrRank")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strwilfulDafaulter")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsuitFiledProgress")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsuitfiledLessThan3Years")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strlast5MonthNPA")));
				*/
				
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				}
				
				
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_cust_details");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcustomerName")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strconstitution")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strindustry")));
				arrValues.add(Helper.correctNull((String) hshValues.get("streTBorNTB")));
				arrValues.add(Helper.correctNull((String) hshValues.get("streTBYearOfRelationWithKBL")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcreditScore")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strproposedFacilityRequestType")));
				arrValues.add(Helper.correctNull((String) hshValues.get("stroverDraft")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcreditLetter")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbankGuarantee")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strwcdpn")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcustomerExposerWithKBL")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strproposedLimitRequested")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strproposedNPAStatus")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strproposedLimitUtilisation")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcustomerMSMEexposure")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strotherFacilityRequestType")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strotherNPAStatus")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strotherPreLimitUtilisation")));
				//arrValues.add(Helper.correctNull((String) hshValues.get("strotherPreLimitUtilisation")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strappRefNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strpanNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcustId")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strappDate")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strtransitionDate")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strincorporateBusinessDate")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_comm_bureau");
				
				 bureauFresh = new ArrayList();
				bureauFresh=(ArrayList) hshValues.get("arrfresh");
				bureaurenewal = new ArrayList();
				bureaurenewal=(ArrayList) hshValues.get("arrrenwal");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcmrRank")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strwilfulDafaulter")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsuitFiledProgress")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsuitfiledLessThan3Years")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strlast5MonthNPA")));
				arrValues.add((String)bureauFresh.get(14));
				arrValues.add((String)bureauFresh.get(15));
				arrValues.add((String)bureauFresh.get(16));
				arrValues.add((String)bureauFresh.get(17));
				arrValues.add((String)bureauFresh.get(18));
				arrValues.add((String)bureauFresh.get(19));
				arrValues.add((String)bureauFresh.get(20));
				arrValues.add((String)bureauFresh.get(21));
				arrValues.add((String)bureauFresh.get(22));
				arrValues.add((String)bureauFresh.get(23));
				arrValues.add((String)bureauFresh.get(24));
				
				arrValues.add((String) bureaurenewal.get(14));
				arrValues.add((String) bureaurenewal.get(15));
				arrValues.add((String) bureaurenewal.get(16));
				arrValues.add((String) bureaurenewal.get(17));
				arrValues.add((String) bureaurenewal.get(18));
				arrValues.add((String) bureaurenewal.get(19));
				arrValues.add((String) bureaurenewal.get(20));
				arrValues.add((String) bureaurenewal.get(21));
				arrValues.add((String) bureaurenewal.get(22));
				arrValues.add((String) bureaurenewal.get(23));
				
	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				

				

				//ArrayList bureauFresh = new ArrayList();
				//bureauFresh=(ArrayList) (hshValues.get("arrfresh"));

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_finance_variable");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcurrentRatio")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strnetWorkingCapital")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strtOLOrTNW")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strdaysReceivable")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcashAccrual")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strnetWorth")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strinterestorEBIT")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcashBankBalance")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcurrentLiabilities")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strdebitOrEquity")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsalesOrPAT")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strreturnAssets")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strreturnCapitalEmployeed")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strreturnEquity")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strsalesWorkCapitalLimit")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_bank_frsh");	
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbusinessCreditDeviationFresh")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbusinessDebitDeviationFresh")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strchequeReturnLast9Month")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strvariationcreditCountt6Month")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strcredtDebitRatio6Months")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_bank_renwl");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbusinessCreditDeviationRenewal")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbusinessDebitDeviationRenewal")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strUtilisationODLimit"))); 
				arrValues.add(Helper.correctNull((String) hshValues.get("strchequeReturnLast12Month")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strvariationCreditMonthly")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strvariationDebitMonthly")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strdaysOverutilisation6Months")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			

				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_cam_summary");
				
				arrValues.add(Helper.correctNull((String) hshValues.get("appNo")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strCommercialScoreCardSummary")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strConsumerScorecardSummary")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strbankODScoreCardSummary")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strfinancialScoreSummary")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strdemogScoreCardSummary")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				
				
			}
			
			catch(Exception e)
			{
				throw new EJBException("Error in CAMService..."+e.toString());
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
					throw new EJBException("Error in CAMService..."+e.toString());
				}
			}
			
			return hshValues;	
	
}

		public HashMap cbsIDCreationServiceNonInd(HashMap hshValues)  {
			String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = "", strInputXMLRequest = "", strRes = "", strCustDesc = "", strEntity = "", strService = "", strRetCustAdd_CustomData = "", strStatus = "", strSalutation = "", strFirstName = "", strBirthDt = "", strBirthMonth = "", strBirthYear = "", strDateOfBirth = "", strGender = "", strStaffEmployeeId = "", strPhoneNum = "", strPhoneNumLocalCode = "", strLastName = "", strShortName = "", strComAddrLine1 = "", strComAddrLine2 = "", strComCity = "", strComState = "", strComCountry = "", strComPostalCode = "", strPerAddrLine1 = "", strPerAddrLine2 = "", strPerCity = "", strPerState = "", strPerCountry = "", strPerPostalCode = "", strNameOfIntroducer = "", strStatusCodeOfIntroducer = "", strPAN = "", strEmploymentStatus = "", strMaritalStatus = "", strServiceRequestVersion = "", strChannelId = "", strBankId = "", strRequestUUID = ""
			   ,strEntityType = "", strMessageDateTime = "", strCreatedBySystemId ="", strRelationshipOpeningDt = "", strType ="";

			ResultSet rs = null,rs1=null;
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			HashMap hshForVerification = null;
			HashMap hshCbsAlmFields=null;
			HashMap hshPanMod=null;
			HashMap hshCbsUnderVer=null;
			String strExp="$";
			String PERAPP_BRANCHCODE="",kyc_occupationcode="",idprooftype="",KYC_IDPROOFREF="",streduqua="",stremail="",strresidenttype="",strcommunity="";
			String  strempadd1="",strempadd2="",strempcity="",strempstate="",strempzip="",stremphone="",strempemail="",strempname="",dateOfBirth="",strPERAPP_CONSTITUTION="",strTaxslab="",strKYC_ID_VALID="",strCustFlag="",strDemoType="";
			String requestUUID="",MessageDateTime="",address_line1="",address_line2="",date1="",phonenolocalcode="",FreeText1="",start_date="",zip="",
			state="",city="",corporate_name="",date_of_incorporation="",relationship_startdate="",docIssueDate="",DocCode="",PlaceOfIssue="",referenceNumber="",
			registration_number="",short_name="";
			try {
			strActiontype = Helper.correctNull((String) hshValues.get("hidSelChk"));
			String strApplicantID =Helper.correctNull((String) hshValues.get("hidborrowerid"));  

			String strappno = Helper.correctNull((String) hshValues.get("appno"));
			double strincome=0.00;
			rs = DBUtils
			.executeLAPSQuery("sel_non_ind_cust^" + strApplicantID);
			if (rs.next()) {
			strSalutation = Helper.correctNull((String) rs.getString("PERAPP_TITLE"));
			strFirstName = Helper.correctNull((String) rs.getString("PERAPP_FNAME"));
			strDateOfBirth = Helper.correctNull((String) rs.getString("PERAPP_DOB"));
			strStaffEmployeeId = Helper.correctNull((String) rs.getString("PERAPP_RELAT_STAFFID"));
			strPhoneNum = Helper.correctNull((String) rs.getString("CON_MOBILE"));
			strPhoneNumLocalCode = Helper.correctNull((String) rs.getString("CON_MOBILE"));
			strLastName = Helper.correctNull((String) rs.getString("PERAPP_LNAME"));
			strGender = Helper.correctNull((String) rs.getString("PERAPP_SEX"));
			strShortName = Helper.correctNull((String) rs.getString("PERAPP_FNAME"));

			strComAddrLine1 = Helper.correctNull((String) rs.getString("CON_COMADDR1"));
			strComAddrLine2 = Helper.correctNull((String) rs.getString("CON_COMADDR2"));
			strComCity = Helper.correctNull((String) rs.getString("CON_COMCITY"));
			strComState = Helper.correctNull((String) rs.getString("CON_COMSTATE"));
			strComCountry = Helper.correctNull((String) rs.getString("CON_COMCOUNTRY"));
			strComPostalCode = Helper.correctNull((String) rs.getString("CON_COMZIP"));

			strPerAddrLine1 = Helper.correctNull((String) rs.getString("CON_PERMADDR1"));
			strPerAddrLine2 = Helper.correctNull((String) rs.getString("CON_PERMADDR2"));
			strPerCity = Helper.correctNull((String) rs.getString("CON_PERMCITY"));
			strPerState = Helper.correctNull((String) rs.getString("CON_PERMSTATE"));
			strPerCountry = Helper.correctNull((String) rs.getString("CON_PERMCOUNTRY"));
			strPerPostalCode = Helper.correctNull((String) rs .getString("CON_PERMZIP"));

			strNameOfIntroducer = Helper.correctNull((String) rs .getString("PERAPP_INTRONAME"));
			strStatusCodeOfIntroducer = Helper.correctNull((String) rs .getString("PERAPP_INTROSTATUS"));
			strPAN = Helper.correctNull((String) rs .getString("PERAPP_PANNO"));
			strEmploymentStatus = Helper.correctNull((String) rs .getString("PERAPP_EMPLOYMENT"));
			strMaritalStatus = Helper.correctNull((String) rs .getString("PERAPP_MARSTAT"));
			PERAPP_BRANCHCODE = Helper.correctNull((String) rs .getString("PERAPP_BRANCHCODE"));
			kyc_occupationcode = Helper.correctNull((String) rs .getString("kyc_occupationcode"));
			idprooftype = Helper.correctNull((String) rs .getString("idprooftype"));
			KYC_IDPROOFREF = Helper.correctNull((String) rs .getString("KYC_IDPROOFREF"));
			streduqua=Helper.correctNull((String) rs .getString("INDINFO_EDU_QUAL"));
			strincome =Double.parseDouble(Helper.correctDouble((String) rs .getString("PERINC_MONSALARY")));
			strincome=strincome*12;
			stremail=Helper.correctNull((String) rs .getString("CON_EMAIL"));
			strresidenttype=Helper.correctNull((String) rs .getString("CON_RESTYPE"));
			if(strresidenttype.equals("1") || strresidenttype.equals("3"))
			{
			strresidenttype="Lease Rental";
			}
			else if(strresidenttype.equals("2"))
			{
			strresidenttype="Own";
			}
			else if(strresidenttype.equals("4"))
			{
			strresidenttype="Parent Owned";
			}
			else if(strresidenttype.equals("5"))
			{
			strresidenttype="Company Provided";
			}
			else
			{
			strresidenttype="Lease Rental";
			}

			strempadd1=Helper.correctNull((String) rs .getString("PEREMP_ADDRESS1"));
			strempadd2=Helper.correctNull((String) rs .getString("PEREMP_ADDRESS2"));
			strempcity=Helper.correctNull((String) rs .getString("PEREMP_CITY"));
			strempstate=Helper.correctNull((String) rs .getString("PEREMP_STATE"));
			strempzip=Helper.correctNull((String) rs .getString("PEREMP_ZIP"));
			stremphone=Helper.correctNull((String) rs .getString("PEREMP_PHONE"));
			strempemail=Helper.correctNull((String) rs .getString("PEREMP_EMAIL"));
			strempname=Helper.correctNull((String) rs .getString("PEREMP_NAME"));

			strPERAPP_CONSTITUTION = Helper.correctNull((String) rs.getString("PERAPP_CONSTITUTION"));
			strTaxslab = Helper.correctNull((String) rs.getString("PERAPP_TAXSLAB"));
			strKYC_ID_VALID = Helper.correctNull((String) rs.getString("KYC_ID_VALID"));
			strcommunity=Helper.correctNull((String) rs.getString("indinfo_religion"));
			//strCustFlag=Helper.correctNull((String) rs.getString("PERAPP_CBSID_VER_FLAG"));

			date_of_incorporation=Helper.correctNull((String) rs.getString("cominfo_incorporation_date"));
			docIssueDate=Helper.correctNull((String) rs.getString("KYC_DOC_DATE"));
			registration_number=Helper.correctNull((String) rs.getString("perapp_regno"));



			}



			if(strPERAPP_CONSTITUTION.equalsIgnoreCase("01")){
				
				DigitalAppInterfaceBean digitalAppInterfaceBean=new DigitalAppInterfaceBean();
				hshValues=digitalAppInterfaceBean.cbsIDCreationService(hshValues);

			}	
			
			else{
			
			String freecode10="";
			if(strPAN.equals(""))
			 freecode10="FRM60";


			String dob[] = strDateOfBirth.split("-");
			strBirthYear = dob[0];
			strBirthMonth = dob[1];
			strBirthDt = dob[2];

			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date date=sdf.parse(strDateOfBirth);
			dateOfBirth=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(date);

			if(!strKYC_ID_VALID.equals(""))
			{
			Date date2=sdf.parse(strKYC_ID_VALID);
			strKYC_ID_VALID=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(date2);
			}


			SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
			strMessageDateTime=simpledateformat.format(new Date());

			strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
			strServiceRequestVersion = "10.2";
			strChannelId = "CRM";
			strBankId = "01";
			strEntityType = "";
			//strMessageDateTime = Helper.getCurrentDateTime();

			if(strEmploymentStatus.equals("1"))
			{
			strEmploymentStatus="Salaried";
			}
			else
			{
			strEmploymentStatus="Self employed";
			}


			strCreatedBySystemId = strChannelId;

			strRelationshipOpeningDt = Helper.getCurrentDateTime();
			SimpleDateFormat simpleDateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
			strRelationshipOpeningDt=simpleDateformat.format(new Date());


			//strType = "CURRENCY";

			String TypeCode="";
			String strexpdateTag="";

			if(idprooftype.equals("PANGIR"))
			{
			TypeCode="ID PROOF RETAIL";
			}
			else
			{
			TypeCode="BOTH RETAIL";
			strexpdateTag="<ExpDt>"+strKYC_ID_VALID+"</ExpDt>";

			if(idprooftype.equals("R04") || idprooftype.equals("ADHAAR"))
			{
			strexpdateTag="";
			}
			}

			rs1 = DBUtils.executeLAPSQuery("sel_applications_dtls^" + strappno);
			if (rs1.next()) {

			start_date= Helper.correctNull((String) rs1.getString("app_createdate"));
			FreeText1= Helper.correctNull((String) rs1.getString("app_usrid"));
			}//: "2019-01-28"
			SimpleDateFormat sDF=new SimpleDateFormat("yyyy-MM-dd");
			Date str_date=sDF.parse(start_date);
			start_date=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(str_date);
			Date doc_date=sDF.parse(docIssueDate);
			docIssueDate=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(doc_date);

			strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.finacle.com/fixml createCorporateCustomer.xsd'>"+
			"<Header><RequestHeader><MessageKey><RequestUUID>Req_"+requestUUID+"</RequestUUID><ServiceRequestId>createCorporateCustomer</ServiceRequestId>"+
			"<ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>SSO</ChannelId><LanguageId/></MessageKey><RequestMessageInfo><BankId>01</BankId>"+
			"<TimeZone/><EntityId/><EntityType/><ArmCorrelationId/><MessageDateTime>"+MessageDateTime+"</MessageDateTime></RequestMessageInfo>" +
			"<Security><Token><PasswordToken><UserId/><Password/></PasswordToken></Token><FICertToken/><RealUserLoginSessionId/><RealUser/>" +
			"<RealUserPwd/><SSOTransferToken/></Security></RequestHeader></Header><Body><createCorporateCustomerRequest><CorpCustDetails>" +
			"<corpCustomerDtlsData><corpCustomerData> <corpAddressData> <address_line1>"+strComAddrLine1+"</address_line1>" +
			" <address_line2>"+strComAddrLine2+"</address_line2> <address_line3/> <addresscategory>Registered</addresscategory>" +
			"<city>"+strPerCity+"</city><country>IN</country><state>"+strPerState+"</state> <preferredAddress>Y</preferredAddress><FreeTextLabel>.</FreeTextLabel>" +
			"<preferredFormat>FREE_TEXT_FORMAT</preferredFormat> <start_date>"+start_date+"</start_date><zip>"+strComPostalCode+"</zip>" +
			"<holdMailFlag>N</holdMailFlag></corpAddressData><corpAddressData><address_line1>"+strPerAddrLine1+"</address_line1>" +
			"<address_line2>"+strComAddrLine2+"</address_line2><address_line3/><addresscategory>Mailing</addresscategory> <city>"+city+"</city>" +
			"<country>IN</country><state>"+state+"</state><preferredAddress>N</preferredAddress> <FreeTextLabel>.</FreeTextLabel>" +
			" <preferredFormat>FREE_TEXT_FORMAT</preferredFormat> <start_date>"+start_date+"</start_date> <zip>"+zip+"</zip>" +
			" <holdMailFlag>N</holdMailFlag></corpAddressData><corporate_name>"+corporate_name+"</corporate_name>" +
			"<isEbankingEnabled>N</isEbankingEnabled><corpPhoneEmailData> <phoneemailtype>CELLPH</phoneemailtype> <phoneno>"+phonenolocalcode+"</phoneno>" +
			" <phonenocountrycode>91</phonenocountrycode> <phonenolocalcode>"+phonenolocalcode+"</phonenolocalcode> <phoneoremail>PHONE</phoneoremail>" +
			" <preferredflag>Y</preferredflag></corpPhoneEmailData><createdBySystemID>COR</createdBySystemID><crncy_Code>INR</crncy_Code>" +
			"<cust_hlth>01</cust_hlth><principle_placeoperation>IN</principle_placeoperation><date_of_incorporation>"+date_of_incorporation+"</date_of_incorporation>" +
			"<defaultaddresstype>Registered</defaultaddresstype><entity_type>Customer</entity_type><health_desc>01</health_desc>" +
			"<islamic_banking_customer>N</islamic_banking_customer><lang_desc>INFENG</lang_desc><legalentity_type>32</legalentity_type>" +
			"<keycontact_personname>TEST</keycontact_personname><notes>NIL</notes><business_type>101</business_type>" +
			"<nativeLangCode>INFENG</nativeLangCode><primary_service_center>524</primary_service_center><average_annualincome/>" +
			"<primaryRM_ID>UBSADMIN</primaryRM_ID><primaryRMLOGIN_ID>UBSADMIN</primaryRMLOGIN_ID><region>Others</region>" +
			"<relationship_type>New</relationship_type><sector>99999</sector><subsector>75</subsector><entity_create_flg>Y</entity_create_flg>" +
			"<taxid>.</taxid><entityclass>MIGR</entityclass><source_of_funds>BUSINESS</source_of_funds><priority>Normal</priority>" +
			"<registration_number>"+registration_number+"</registration_number><registration_number>Not Registered</registration_number>" +
			"<relationship_createdby>DUMMY</relationship_createdby><relationship_startdate>"+strRelationshipOpeningDt+"</relationship_startdate>" +
			"<segment>Class A</segment><short_name>"+short_name+"</short_name><startdate>"+start_date+"</startdate>" +
			"<subsegment>Sub Class A</subsegment><trade_services_availed>N</trade_services_availed><cust_const>174</cust_const>" +
			"<status>099</status></corpCustomerData></corpCustomerDtlsData><corpRelatedData><corpEntityDocumentData><CountryOfIssue>IN</CountryOfIssue>" +
			"<DocCode>CIN</DocCode><docIssueDate>"+docIssueDate+"</docIssueDate><docTypeCode>ID PROOF CORPORATE</docTypeCode>" +
			"<PlaceOfIssue>"+strPerCity+"</PlaceOfIssue><docRemarks>KBL</docRemarks><referenceNumber>"+KYC_IDPROOFREF+"</referenceNumber>" +
			"<preferredUniqueId>N</preferredUniqueId></corpEntityDocumentData><preferencesData><corpPrefMiscData> <date1>"+strKYC_ID_VALID+"</date1>" +
			" <str1>INR</str1> <type>CURRENCY</type></corpPrefMiscData></preferencesData></corpRelatedData></CorpCustDetails>" +
			"<createCorporateCustomer_CustomData><FreeCode5>99999</FreeCode5><FreeText1>"+FreeText1+"</FreeText1>" +
			"</createCorporateCustomer_CustomData></createCorporateCustomerRequest></Body></FIXML>";

			log.info("################@@@@@@@@@@@@@ CBS Customer Creation request @@@@@@@@@@@@@################"+ strInputXMLRequest);
			URL url = new URL(ApplicationParams.getStrCBSIDCreation());
			log.info("cbsIdCreationService Url========== "+url);
			HttpsURLConnection urlcon = (HttpsURLConnection) url.openConnection();
			urlcon.setRequestProperty("User-Agent", "");
			urlcon.setDoInput(true);
			urlcon.setDoOutput(true);
			urlcon.setRequestMethod("POST");
			urlcon.setRequestProperty("Content-Type",
			"application/xml;charset=UTF-8");
			urlcon.setRequestProperty("Authorization", "Basic");
			OutputStream outputStream = urlcon.getOutputStream();
			OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");

			BufferedWriter bWriter = new BufferedWriter(osw);
			bWriter.write(strInputXMLRequest);
			bWriter.close();

			InputStream inputStream = urlcon.getInputStream();
			InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");

			BufferedReader rd = new BufferedReader(isreader);
			if (rd != null) {
			StringBuffer result = new StringBuffer();
			while ((line = rd.readLine()) != null) {
			result.append(line);
			}
			log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
			+ result.toString());

			try {

			String responseCbs = result.toString();
			              responseCbs=responseCbs.replace("^([\\W]+)<","<");
			               responseCbs=responseCbs.replace("utf-16","utf-8");
			                       
			              int nodesize=0;
			              DocumentBuilderFactory docbuildfactory = DocumentBuilderFactory.newInstance();    
			              DocumentBuilder docBuilder = docbuildfactory.newDocumentBuilder();                
			              Document doc = docBuilder.parse(new ByteArrayInputStream(responseCbs.getBytes()));
			              doc.getDocumentElement().normalize();
			             
			             NodeList nodesListheader = doc.getElementsByTagName("HostTransaction");
			             strStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue(); 
			             
			             NodeList nodesList = doc.getElementsByTagName("Body");
			             if(strStatus.equalsIgnoreCase("SUCCESS"))
			             {
			             strCustId=(String)((Element)nodesList.item(0)).getElementsByTagName("cifid").item(0).getChildNodes().item(0).getNodeValue();
			             strCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("desc").item(0).getChildNodes().item(0).getNodeValue();
			             strStatus=(String)((Element)nodesList.item(0)).getElementsByTagName("status").item(0).getChildNodes().item(0).getNodeValue(); 
			             }
			             else
			             {
			                     strCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("ErrorDesc").item(0).getChildNodes().item(0).getNodeValue();
			             }
			             
			   if(!strStatus.equalsIgnoreCase("Success"))
			{
			    hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_cbs_api_error_status");
			arrValues = new ArrayList();
			arrValues.add(strCustId);
			arrValues.add(strCustDesc);//appraised by
			arrValues.add(strappno);
			arrValues.add("CBS Id creation"); 
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			}

			   hshValues.put("apistatus",strStatus);
			hshValues.put("apistatusdesc",strCustDesc);
			hshValues.put("hidapplicantid",strApplicantID);
			hshValues.put("strappno",strappno);
			} 
			catch (Exception e) 
			{
			System.out.println("Exception.....................cbsIDCreationServicenonInd");
			throw new EJBException("Exception in cbsIDCreationServicenonInd ==="+e.getMessage());
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
			throw new EJBException("Error in cbsIDCreationServicenonInd in closing Connection "+e.getMessage());
			}
			}

			   if(strStatus.equalsIgnoreCase("Success"))
			   {
			hshValues.put("newCustId", strCustId);

			   hshForVerification = this.msmecustIdVerification(hshValues);
			   
			   String strResCifId = Helper.correctNull((String)hshForVerification.get("strResCifId"));
			   String strResDesc = Helper.correctNull((String)hshForVerification.get("strResDesc"));
			   String strResStatus = Helper.correctNull((String)hshForVerification.get("strResStatus"));

			   hshValues.put("apistatus", strResStatus);
			hshValues.put("apistatusdesc", strResDesc);
			if(strResStatus.equalsIgnoreCase("SUCCESS"))
			{ 
			//hshCbsAlmFields=this.cbsAmlFields(hshValues);

			/*if(!TypeCode.equals("ID PROOF RETAIL"))
			{
			hshPanMod=custIdPanModification(hshValues);
			}
			*/
			  //logic for sms service
			   
			// if(strResStatus.equalsIgnoreCase("SUCCESS"))  
			 //{
			hshValues.put("apistatusdesc", strCustDesc);

			  String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			  if(strAppno.equals(""))
			  {
			   strAppno=Helper.correctNull((String)hshValues.get("strappno"));
			  }
			   
			if(rs!=null)
			rs.close();

			//if(bflag)
			{
			String strMessage="",strMobileno="",strRejReason="";
			if(rs!=null)
			rs.close();

			rs=DBUtils.executeLAPSQuery("sel_sms_master");
			if(rs.next())
			{
			strMessage=Helper.correctNull(rs.getString("SMS_CBS_ID_CREATION"));
			}

			if(rs!=null)
			rs.close();

			rs=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strAppno);
			if(rs.next())
			{
			strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("perapp_fname")));
			strMessage=strMessage.replaceAll("@SAMT", Helper.correctDouble(rs.getString("loan_recmdamt")));
			strMobileno=Helper.correctNull(rs.getString("con_mobile"));
			}

			if(!strMobileno.equalsIgnoreCase(""))
			{
			log.info("================== Message Service================");
			String charset="UTF-8",strFileIds="";

			String query = null;
			URLConnection conn = null;

			try{
			query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
					ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
			ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
			.encode(strMobileno, charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
			URLEncoder.encode(strMessage, charset));

			log.info("==================Invoking Service in Try Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
			conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
			log.info("================== Service Ended================");


			}catch(Exception e)
			{
			query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+strMobileno+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
			log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
			conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
			log.info("================== Service Ended================");
			throw new EJBException("Exception in cbsIDCreationServicenonInd ==="+e.getMessage()); 
			}
			}
			}

			   
			   //sms service logic ended


			   String strLARnumber="";
			   rs=DBUtils.executeLAPSQuery("comfunsel1^"+strappno);
			if(rs.next())
			{
			strLARnumber = Helper.correctNull((String) rs.getString("app_inwardno"));

			}
			 
			   
			   //LAR
			if(strDemoType.equalsIgnoreCase("a"))
			{
			   hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_cbscustid_lar");
			arrValues.add(strResCifId);
			arrValues.add(strLARnumber);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

			//customer profile
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_cbscustid_cp");
			arrValues.add(strResCifId);
			arrValues.add("Y");
			arrValues.add(strApplicantID);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			hshQueryValues.put("size", "2");
			}
			else
			{
			   hshQueryValues = new HashMap();
			   hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_cbscustid_cp");
			arrValues.add(strResCifId);
			arrValues.add("Y");
			arrValues.add(strApplicantID);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			//FI/KYC completed sms service
			String strMessage="",strMobileno="";

			if(rs!=null)
			rs.close();

			rs=DBUtils.executeLAPSQuery("sel_sms_master");
			if(rs.next())
			{
			strMessage=Helper.correctNull(rs.getString("FIELD_INVESTIGATION_COMPLETED"));
			}

			if(rs!=null)
			rs.close();
			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+strAppno);
			if(rs.next())
			{
			strMessage=strMessage.replaceAll("@Branch", Helper.correctDouble(rs.getString("ORG_NAME")));
			}

			if(rs!=null)
			rs.close();
			rs=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strAppno);
			if(rs.next())
			{
			strMobileno=Helper.correctNull(rs.getString("con_mobile"));
			strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("perapp_fname")));
			}

			// strMessage= "Dear customer, Your field investigation checklist is completed";
			String query = null;
			URLConnection conn = null;
			String charset="UTF-8";
			try{
			query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
					ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
			ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
			.encode(strMobileno, charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
			URLEncoder.encode(strMessage, charset));

			log.info("==================Invoking Service in Try Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
			conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();

			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "updt_sms_flag");
			arrValues.add("Yes");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			log.info("================== Service Ended================");
			}
			catch(Exception e)
			{
			query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+strMobileno+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
			log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
			conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
			log.info("================== Service Ended================");
			throw new EJBException("Exception in viewDocumentData ==="+e.getMessage());
			}
			   
			}
			   
			   
			   hshValues.put("strResCifId", strResCifId);
			   hshValues.put("strResDesc", strResDesc);
			   hshValues.put("strResStatus", strResStatus);
			   
			   }
			   
			}
			hshValues=msmeGetDigiDecisionDetail(hshValues);

			} 
			} catch (Exception ex) {
			// .LogWriter.log(LAPSLogLevel.ERROR,""+"Exception in cbsIDCreationService"
			// + ex);
			throw new EJBException("Error in cbsIDCreationServicenonInd"+ex.toString());
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
			return hshValues;
			}



public HashMap msmecustIdVerification(HashMap hshValues){
			
			String line = "", strInputXMLRequest = "", strcifId = "", strResCifId=""
					      , strDecision = "", strEntityName = "", strResDesc="", strResStatus=""
	               		, strRequestUUID = "", strServiceRequestVersion = "", strChannelId = ""
			           , strBankId = "", strEntityType = "", strMessageDateTime = "";

			ResultSet rs = null;
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();

			try {
				//String strAppId=Helper.correctNull((String) hshValues.get("hid_appid"));		
				strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
				//strServiceRequestVersion = "10.2";
				//strChannelId = "CRM";
				//strBankId = "01";
				//strEntityType = "";
				//strMessageDateTime = Helper.getCurrentDateTime();
				SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
				strMessageDateTime=simpledateformat.format(new Date());
				
				strcifId = Helper.correctNull((String) hshValues.get("newCustId"));
				
				strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.finacle.com/fixml verifyCustomerDetails.xsd'>" +
							"<Header><RequestHeader><MessageKey><RequestUUID>Req_"+strRequestUUID+"</RequestUUID><ServiceRequestId>verifyCustomerDetails</ServiceRequestId>" +
							"<ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>CRM</ChannelId><LanguageId/></MessageKey><RequestMessageInfo><BankId>01</BankId>" +
							"<TimeZone/><EntityId/><EntityType/><ArmCorrelationId/><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo>" +
							"<Security><Token><PasswordToken><UserId/><Password/></PasswordToken></Token><FICertToken/><RealUserLoginSessionId/><RealUser/><RealUserPwd/>" +
							"<SSOTransferToken/></Security></RequestHeader></Header><Body><verifyCustomerDetailsRequest><CustomerVerifyRq><cifId>"+strcifId+"</cifId>" +
							"<decision>Approve</decision><entityName>CorporateCustomer</entityName></CustomerVerifyRq></verifyCustomerDetailsRequest></Body></FIXML>";
					
					// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@ CHM & CIBIL Request @@@@@@@@@@@@@################"+
					// strInputXMLRequest);
					log.info("################@@@@@@@@@@@@@ Cust ID Verification Request @@@@@@@@@@@@@################"
									+ strInputXMLRequest);
					String strUrl = ApplicationParams.getStrCUSTIDVerification();
					URL url = new URL(strUrl);
						log.info("CustIdVerification Url======"+url);
						HttpsURLConnection urlcon = (HttpsURLConnection) url.openConnection();
							
					urlcon.setRequestProperty("User-Agent", "");
					urlcon.setDoInput(true);
					urlcon.setDoOutput(true);
					urlcon.setRequestMethod("POST");
					urlcon.setRequestProperty("Content-Type","application/xml;charset=UTF-8");
					urlcon.setRequestProperty("Authorization", "Basic");
					OutputStream outputStream = urlcon.getOutputStream();
					OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF-8");
							
					BufferedWriter bWriter = new BufferedWriter(osw);
					bWriter.write(strInputXMLRequest);
					bWriter.close();

					InputStream inputStream = urlcon.getInputStream();
					InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");
					BufferedReader rd = new BufferedReader(isreader);
			
						StringBuffer result = new StringBuffer();
						while ((line = rd.readLine()) != null) {
							result.append(line);
						}
						log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
										+ result.toString());
						// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
						// + result.toString());

						try {

							    String responseCbs = result.toString();
			                    responseCbs=responseCbs.replace("^([\\W]+)<","<");
			                    responseCbs=responseCbs.replace("utf-16","utf-8");
			                        
			                        int nodesize=0;
			                        DocumentBuilderFactory docbuildfactory = DocumentBuilderFactory.newInstance();    
			                        DocumentBuilder docBuilder = docbuildfactory.newDocumentBuilder();                
			                        Document doc = docBuilder.parse(new ByteArrayInputStream(responseCbs.getBytes()));
			                        doc.getDocumentElement().normalize();
			                        
			                        NodeList nodesListheader = doc.getElementsByTagName("HostTransaction");
			                        strResStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							
				  		              
				  		              NodeList nodesList = doc.getElementsByTagName("Body");
				  		              if(strResStatus.equalsIgnoreCase("SUCCESS"))
				  		              {
				  		            	strResCifId=(String)((Element)nodesList.item(0)).getElementsByTagName("cifId").item(0).getChildNodes().item(0).getNodeValue();
				  		            	strResDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("desc").item(0).getChildNodes().item(0).getNodeValue();
				  		            	strResStatus=(String)((Element)nodesList.item(0)).getElementsByTagName("status").item(0).getChildNodes().item(0).getNodeValue();							
				  		              }
				  		              else
				  		              {
				  		            	strResDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("ErrorDesc").item(0).getChildNodes().item(0).getNodeValue();
				  		              }
							
							   if(!strResStatus.equalsIgnoreCase("Success"))
								{
							    	hshQueryValues = new HashMap();
									hshQuery = new HashMap();
									hshQuery.put("strQueryId", "ins_cbs_api_error_status");
									arrValues = new ArrayList();
									arrValues.add(strResCifId);
									arrValues.add(strResDesc);//appraised by
									arrValues.add(strRequestUUID);
									arrValues.add("CBS ID Verification");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);
									hshQueryValues.put("size", "1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								}
						} 
						catch (Exception e) {
							System.out.println("Exception.....................");
							e.printStackTrace();
							throw new EJBException("Exception==="+e.getMessage());
						}
					if(strResDesc.contains("MSGEXC0107"))
						strResStatus="SUCCESS";
						
					hshValues.put("strResCifId", strResCifId);
					hshValues.put("strResDesc", strResDesc);
					hshValues.put("strResStatus", strResStatus);	
					
			} 
			catch (Exception ex) 
			{
				ex.printStackTrace();
				throw new EJBException("Error in MsmeCustIdVerification");
			}

			finally 
			{
				try {
					if (rs != null) {
						rs.close();
					}
				} catch (Exception e) 
				{
					throw new EJBException("Error in closing Connection "+e.getMessage());
				}
			}
			return hshValues;
			
			}



public HashMap scorecardDetails(HashMap hshValues){
	
	
	ResultSet rs = null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList months = new ArrayList();

	try {
		
		String 	strAppno="",strCreateDate="",strdate="";
		strAppno=Helper.correctNull((String) hshValues.get("appno"));
		rs=DBUtils.executeLAPSQuery("com_applications_value_sel^"+strAppno);
		if(rs.next())
		{
			 strCreateDate = Helper.correctNull((String) rs.getString("APP_CREATEDATE"));
			
		}	

		
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal=Calendar.getInstance();
		Calendar prevYear=Calendar.getInstance();
		Calendar nextYear=Calendar.getInstance();
		
		cal.setTime(df.parse(strCreateDate));
		for(int i=1;i<=12;i++)
		{
			String monthName=df.format(cal.getTime());
			//[2013-09-17, 2013-08-17, 2013-07-17, 2013-06-17, 2013-05-17, 2013-04-17, 2013-03-17, 2013-02-17, 2013-01-17, 2012-12-17]
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date date=sdf.parse(monthName);
			String strmonthName=new SimpleDateFormat("MMM yyyy").format(date);
			
			String monthYear[]=strmonthName.split(" ");
			//monthName.s
			months.add(monthYear[0]+"\' "+monthYear[1]);
			
			cal.add(Calendar.MONTH, -1);
		}
		
		if(Calendar.MONTH<3)
				{
		prevYear.add(Calendar.YEAR, -2);
				}
		prevYear.add(Calendar.YEAR, -1);
		nextYear.add(Calendar.YEAR, +1);
		hshValues.put("prevYear","FY "+(String.valueOf(prevYear.get(Calendar.YEAR))));
		
		
		/*Date date=df.parse(strCreateDate);
		String strDate=date.toString();
		strdate=new SimpleDateFormat("MMM-yyyy").format(date);*/
		hshValues.put("lastmonth1",months.get(0));
		hshValues.put("lastmonth2",months.get(1));
		hshValues.put("lastmonth3",months.get(2));
		hshValues.put("lastmonth4",months.get(3));
		hshValues.put("lastmonth5",months.get(4));
		hshValues.put("lastmonth6",months.get(5));
		hshValues.put("lastmonth7",months.get(6));
		hshValues.put("lastmonth8",months.get(7));
		hshValues.put("lastmonth9",months.get(8));
		hshValues.put("lastmonth10",months.get(9));
		hshValues.put("lastmonth11",months.get(10));
		hshValues.put("lastmonth12",months.get(11));
		
	} 
	catch (Exception ex) 
	{
		ex.printStackTrace();
		throw new EJBException("Error in scoreCardDetails");
	}

	finally 
	{
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) 
		{
			throw new EJBException("Error in closing Connection "+e.getMessage());
		}
	}
	return hshValues;
	
	}

public HashMap setScorecardDetails(HashMap hshValues){
	
	ResultSet rs = null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList months = new ArrayList();
	HashMap getDateFormat=null;
	try {
		//05130000001
		String 	strAppno="",strCreateDate="",strdate="",strAction="",strNetIncome="",strRevenue="",strExpenditure="",
		 business_credit1="",business_credit2="",business_credit3="",business_credit4="",business_credit5="",business_credit6="",business_credit7="",business_credit8="",
		business_credit9="",business_credit10="",business_credit11="",business_credit12="",Business_Debits1="",Business_Debits2="",Business_Debits3="",Business_Debits4="",Business_Debits5="",
		Business_Debits6="",Business_Debits7="",Business_Debits8="",Business_Debits9="",Business_Debits10="",Business_Debits11="",Business_Debits12="",Credit_Counts1="",Credit_Counts2="",
		Credit_Counts3="",Credit_Counts4="",Credit_Counts5="",Credits1="",Credits2="",Credits3="",Credits4="",Credits5="",Credits6="",Debit_Counts1="",Debit_Counts2="",Debit_Counts3="",Debit_Counts4="",Debit_Counts5="",Debit_Counts6="",Debits1="",Debits2="",
		Debits3="",Debits4="",Debits5="",Debits6="",credit_count_12month="",debit_Count_12months="",inward_return="",Earining1="",Earining2="",Earining3="",Credit_Counts6="";
		
		strAction=Helper.correctNull((String) hshValues.get("hidAction"));
		strAppno=Helper.correctNull((String) hshValues.get("appno"));
		

		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","del_digiScorecard");
		arrValues.add(strAppno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		
		
		strRevenue=Helper.correctNull((String) hshValues.get("revenue"));
		strExpenditure=Helper.correctNull((String) hshValues.get("expenditure"));
		strNetIncome=Helper.correctNull((String) hshValues.get("net_income"));
		business_credit1=Helper.correctNull((String) hshValues.get("business_credit1"));
		business_credit2=Helper.correctNull((String) hshValues.get("business_credit2"));
		business_credit3=Helper.correctNull((String) hshValues.get("business_credit3"));
		business_credit4=Helper.correctNull((String) hshValues.get("business_credit4"));
		business_credit5=Helper.correctNull((String) hshValues.get("business_credit5"));
		business_credit6=Helper.correctNull((String) hshValues.get("business_credit6"));
		business_credit7=Helper.correctNull((String) hshValues.get("business_credit7"));
		business_credit8=Helper.correctNull((String) hshValues.get("business_credit8"));
		business_credit9=Helper.correctNull((String) hshValues.get("business_credit9"));
		business_credit10=Helper.correctNull((String) hshValues.get("business_credit10"));
		business_credit11=Helper.correctNull((String) hshValues.get("business_credit11"));
		business_credit12=Helper.correctNull((String) hshValues.get("business_credit12"));
		
		Business_Debits1=Helper.correctNull((String) hshValues.get("Business_Debits1"));
		Business_Debits2=Helper.correctNull((String) hshValues.get("Business_Debits2"));
		Business_Debits3=Helper.correctNull((String) hshValues.get("Business_Debits3"));
		Business_Debits4=Helper.correctNull((String) hshValues.get("Business_Debits4"));
		Business_Debits5=Helper.correctNull((String) hshValues.get("Business_Debits5"));
		Business_Debits6=Helper.correctNull((String) hshValues.get("Business_Debits6"));
		Business_Debits7=Helper.correctNull((String) hshValues.get("Business_Debits7"));
		Business_Debits8=Helper.correctNull((String) hshValues.get("Business_Debits8"));
		Business_Debits9=Helper.correctNull((String) hshValues.get("Business_Debits9"));
		Business_Debits10=Helper.correctNull((String) hshValues.get("Business_Debits10"));
		Business_Debits11=Helper.correctNull((String) hshValues.get("Business_Debits11"));
		Business_Debits12=Helper.correctNull((String) hshValues.get("Business_Debits12"));
	
		
		
		Credit_Counts1=Helper.correctNull((String) hshValues.get("Credit_Counts1"));
		Credit_Counts2=Helper.correctNull((String) hshValues.get("Credit_Counts2"));
		Credit_Counts3=Helper.correctNull((String) hshValues.get("Credit_Counts3"));
		Credit_Counts4=Helper.correctNull((String) hshValues.get("Credit_Counts4"));
		Credit_Counts5=Helper.correctNull((String) hshValues.get("Credit_Counts5"));
		Credit_Counts6=Helper.correctNull((String) hshValues.get("Credit_Counts6"));
		Credits1=Helper.correctNull((String) hshValues.get("Credits1"));
		Credits2=Helper.correctNull((String) hshValues.get("Credits2"));
		Credits3=Helper.correctNull((String) hshValues.get("Credits3"));
		Credits4=Helper.correctNull((String) hshValues.get("Credits4"));
		Credits5=Helper.correctNull((String) hshValues.get("Credits5"));
		Credits6=Helper.correctNull((String) hshValues.get("Credits6"));
		Debit_Counts1=Helper.correctNull((String) hshValues.get("Debit_Counts1"));
		Debit_Counts2=Helper.correctNull((String) hshValues.get("Debit_Counts2"));
		Debit_Counts3=Helper.correctNull((String) hshValues.get("Debit_Counts3"));
		Debit_Counts4=Helper.correctNull((String) hshValues.get("Debit_Counts4"));
		Debit_Counts5=Helper.correctNull((String) hshValues.get("Debit_Counts5"));
		Debit_Counts6=Helper.correctNull((String) hshValues.get("Debit_Counts6"));
		
		
		
		
		Debits1=Helper.correctNull((String) hshValues.get("Debits1"));
		Debits2=Helper.correctNull((String) hshValues.get("Debits2"));
		Debits3=Helper.correctNull((String) hshValues.get("Debits3"));
		Debits4=Helper.correctNull((String) hshValues.get("Debits4"));
		Debits5=Helper.correctNull((String) hshValues.get("Debits5"));
		Debits6=Helper.correctNull((String) hshValues.get("Debits6"));
		credit_count_12month=Helper.correctNull((String) hshValues.get("credit_count_12month"));
		debit_Count_12months=Helper.correctNull((String) hshValues.get("debit_Count_12months"));
		inward_return=Helper.correctNull((String) hshValues.get("inward_return"));
		Earining1=Helper.correctNull((String) hshValues.get("Earining1"));
		
		
		
		
		if(strAction.equals("Save"))
		{
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","ins_rating_details");
			
			arrValues.add(Helper.correctInt(strAppno));
			arrValues.add(Helper.correctInt(strRevenue));
			arrValues.add(Helper.correctInt(strExpenditure));
			arrValues.add(Helper.correctInt(strNetIncome));
			arrValues.add(Helper.correctInt(business_credit1));
			arrValues.add(Helper.correctInt(business_credit2));
			arrValues.add(Helper.correctInt(business_credit3));
			arrValues.add(Helper.correctInt(business_credit4));
			arrValues.add(Helper.correctInt(business_credit5));
			arrValues.add(Helper.correctInt(business_credit6));
			arrValues.add(Helper.correctInt(business_credit7));
			arrValues.add(Helper.correctInt(business_credit8));
			arrValues.add(Helper.correctInt(business_credit9));
			arrValues.add(Helper.correctInt(business_credit10));
			arrValues.add(Helper.correctInt(business_credit11));
			arrValues.add(Helper.correctInt(business_credit12));
		
			
			arrValues.add(Helper.correctInt(Business_Debits1));
			arrValues.add(Helper.correctInt(Business_Debits2));
			arrValues.add(Helper.correctInt(Business_Debits3));
			arrValues.add(Helper.correctInt(Business_Debits4));
			arrValues.add(Helper.correctInt(Business_Debits5));
			arrValues.add(Helper.correctInt(Business_Debits6));
			arrValues.add(Helper.correctInt(Business_Debits7));
			arrValues.add(Helper.correctInt(Business_Debits8));
			arrValues.add(Helper.correctInt(Business_Debits9));
			arrValues.add(Helper.correctInt(Business_Debits10));
			arrValues.add(Helper.correctInt(Business_Debits11));
			arrValues.add(Helper.correctInt(Business_Debits12));
			
			arrValues.add(Helper.correctInt(Credit_Counts1));
			arrValues.add(Helper.correctInt(Credit_Counts2));
			arrValues.add(Helper.correctInt(Credit_Counts3));
			arrValues.add(Helper.correctInt(Credit_Counts4));
			arrValues.add(Helper.correctInt(Credit_Counts5));
			arrValues.add(Helper.correctInt(Credit_Counts6));
			
			arrValues.add(Helper.correctInt(Credits1));
			arrValues.add(Helper.correctInt(Credits2));
			arrValues.add(Helper.correctInt(Credits3));
			arrValues.add(Helper.correctInt(Credits4));
			arrValues.add(Helper.correctInt(Credits5));
			arrValues.add(Helper.correctInt(Credits6));
			
			arrValues.add(Helper.correctInt(Debit_Counts1));
			arrValues.add(Helper.correctInt(Debit_Counts2));
			arrValues.add(Helper.correctInt(Debit_Counts3));
			arrValues.add(Helper.correctInt(Debit_Counts4));
			arrValues.add(Helper.correctInt(Debit_Counts5));
			arrValues.add(Helper.correctInt(Debit_Counts6));
			
			arrValues.add(Helper.correctInt(Debits1));
			arrValues.add(Helper.correctInt(Debits2));
			arrValues.add(Helper.correctInt(Debits3));
			arrValues.add(Helper.correctInt(Debits4));
			arrValues.add(Helper.correctInt(Debits5));
			arrValues.add(Helper.correctInt(Debits6));
			
			arrValues.add(Helper.correctInt(credit_count_12month));
			arrValues.add(Helper.correctInt(debit_Count_12months));
			arrValues.add(Helper.correctInt(inward_return));
			
			arrValues.add(Helper.correctInt(Earining1));
			
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
	
			//getDateFormat = this.scorecardDetails(hshValues);	
		}
		
		
	} 
	catch (Exception ex) 
	{
		ex.printStackTrace();
		throw new EJBException("Error in setScorecardDetails");
	}

	finally 
	{
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) 
		{
			throw new EJBException("Error in closing Connection "+e.getMessage());
		}
	}
	return hshValues;
	
	}

public HashMap getScorecardDetails(HashMap hshValues){
	
	ResultSet rs = null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList months = new ArrayList();

	try {
		//05130000001
		String 	strAppno="",strCreateDate="",strdate="",strAction="",strNetIncome="",strRevenue="",strExpenditure="",
		 business_credit1="",business_credit2="",business_credit3="",business_credit4="",business_credit5="",business_credit6="",
		 business_credit7="",business_credit8="",business_credit9="",business_credit10="",business_credit11="",business_credit12="",
		 Business_Debits1="",Business_Debits2="",Business_Debits3="",Business_Debits4="",Business_Debits5="",
		Business_Debits6="",Business_Debits7="",Business_Debits8="",Business_Debits9="",Business_Debits10="",Business_Debits11="",
		Business_Debits12="",Credit_Counts1="",Credit_Counts2="",Credit_Counts3="",Credit_Counts4="",Credit_Counts5="",
		Credit_Counts6="",Credits1="",Credits2="",Credits3="",Credits4="",Credits5="",Credits6="",
		Debit_Counts1="",Debit_Counts2="",Debit_Counts3="",Debit_Counts4="",Debit_Counts5="",Debit_Counts6="",Debits1="",Debits2="",
		Debits3="",Debits4="",Debits5="",Debits6="",credit_count_12month="",debit_Count_12months="",inward_return="",Earining1="",
		Earining2="",Earining3="";
		
		strAction=Helper.correctNull((String) hshValues.get("hidAction"));
		strAppno=Helper.correctNull((String) hshValues.get("appno"));
		hshValues.put("strAppno",strAppno);
		
		/*
			strAppno=Helper.correctNull((String) hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("com_applications_value_sel^"+strAppno);
			if(rs.next())
			{
				 strCreateDate = Helper.correctNull((String) rs.getString("APP_CREATEDATE"));
				
			}	

			
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal=Calendar.getInstance();
			Calendar prevYear=Calendar.getInstance();
			Calendar nextYear=Calendar.getInstance();
			
			cal.setTime(df.parse(strCreateDate));
			for(int i=1;i<=12;i++)
			{
				String monthName=df.format(cal.getTime());
				//[2013-09-17, 2013-08-17, 2013-07-17, 2013-06-17, 2013-05-17, 2013-04-17, 2013-03-17, 2013-02-17, 2013-01-17, 2012-12-17]
				
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date date=sdf.parse(monthName);
				String strmonthName=new SimpleDateFormat("MMM yyyy").format(date);
				
				String monthYear[]=strmonthName.split(" ");
				//monthName.s
				months.add(monthYear[0]+"\' "+monthYear[1]);
				
				cal.add(Calendar.MONTH, -1);
			}
			
			if(Calendar.MONTH<3)
					{
			prevYear.add(Calendar.YEAR, -2);
					}
			prevYear.add(Calendar.YEAR, -1);
			nextYear.add(Calendar.YEAR, +1);
			hshValues.put("prevYear","FY "+(String.valueOf(prevYear.get(Calendar.YEAR)))+"-"+(String.valueOf(prevYear.get(Calendar.YEAR)+1)));
			hshValues.put("earningYear",(String.valueOf(prevYear.get(Calendar.YEAR))));
			
			Date date=df.parse(strCreateDate);
			String strDate=date.toString();
			strdate=new SimpleDateFormat("MMM-yyyy").format(date);
			

		
		rs = DBUtils.executeLAPSQuery("sel_digital_rating^" + strAppno);
		if(rs.next())
		{
		
			//String creditMon1=Helper.correctNull((String)rs.getNString("DIGI_BUSINESS_CR_MON1"));
			
			//Helper.correctNull((String)rs.getNString("DIGI_BUSINESS_CR_MON1"));
			strNetIncome=Helper.correctNull(String.valueOf(rs.getInt("DIGI_ITR_GROSSTOT_INCOME")));
			strRevenue=Helper.correctNull(String.valueOf(rs.getInt("DIGI_ITR_OPR_REV")));
			strExpenditure=Helper.correctNull(String.valueOf(rs.getInt("DIGI_ITR_OPR_EXPENDR")));
		business_credit1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON1")));
		business_credit2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON2")));
		business_credit3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON3")));
		business_credit4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON4")));
		business_credit5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON5")));
		business_credit6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON6")));
		business_credit7=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON7")));
		business_credit8=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON8")));
		business_credit9=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON9")));
		business_credit10=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON10")));
		business_credit11=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON11")));
		business_credit12=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_CR_MON12")));
		Business_Debits1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON1")));
		Business_Debits2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON2")));
		
		Business_Debits3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON3")));
		Business_Debits4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON4")));
		Business_Debits5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON5")));
		Business_Debits6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON6")));
		Business_Debits7=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON7")));
		Business_Debits8=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON8")));
		Business_Debits9=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON9")));
		Business_Debits10=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON10")));
		Business_Debits11=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON11")));
		Business_Debits12=Helper.correctNull(String.valueOf(rs.getInt("DIGI_BUSINESS_DB_MON12")));
		Credit_Counts1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON1")));
		Credit_Counts2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON2")));
		Credit_Counts3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON3")));
		Credit_Counts4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON4")));
		Credit_Counts5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON5")));
		Credit_Counts6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_COUNT_MON6")));
		Credits1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON1")));
		
	
		
		
		
		Credits2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON2")));
		Credits3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON3")));
		Credits4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON4")));
		Credits5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON5")));
		Credits6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_CR_VALUE_MON6")));
		Debit_Counts1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON1")));
		Debit_Counts2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON2")));
		Debit_Counts3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON3")));
		Debit_Counts4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON4")));
		Debit_Counts5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON5")));
		Debit_Counts6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_COUNT_MON6")));
		Debits1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON1")));
		Debits2=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON2")));
		Debits3=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON3")));
		
		
		
		Debits4=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON4")));
		Debits5=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON5")));
		Debits6=Helper.correctNull(String.valueOf(rs.getInt("DIGI_DB_VALUE_MON6")));
		credit_count_12month=Helper.correctNull(String.valueOf(rs.getInt("DIGI_TOTALCR_COUNT")));
		debit_Count_12months=Helper.correctNull(String.valueOf(rs.getInt("DIGI_TOTALDB_COUNT")));
		inward_return=Helper.correctNull(String.valueOf(rs.getInt("DIGI_TOTAL_INWRD_RETN")));
		Earining1=Helper.correctNull(String.valueOf(rs.getInt("DIGI_FINYR_EBIT_YR1")));
		
		
		}
		
		hshValues.put("strNetIncome", strNetIncome);
		hshValues.put("strRevenue", strRevenue);
		hshValues.put("strExpenditure", strExpenditure);
		
		hshValues.put("business_credit1", business_credit1);
		hshValues.put("business_credit2", business_credit2);
		hshValues.put("business_credit3", business_credit3);
		hshValues.put("business_credit4", business_credit4);
		hshValues.put("business_credit5", business_credit5);
		hshValues.put("business_credit6", business_credit6);
		hshValues.put("business_credit7", business_credit7);
		hshValues.put("business_credit8", business_credit8);
		hshValues.put("business_credit9", business_credit9);
		hshValues.put("business_credit10", business_credit10);
		hshValues.put("business_credit11", business_credit11);
		hshValues.put("business_credit12", business_credit12);
		hshValues.put("Business_Debits1", Business_Debits1);
		hshValues.put("Business_Debits2", Business_Debits2);
		hshValues.put("Business_Debits3", Business_Debits3);
		hshValues.put("Business_Debits4", Business_Debits4);
		hshValues.put("Business_Debits5", Business_Debits5);		
		hshValues.put("Business_Debits6", Business_Debits6);
		hshValues.put("Business_Debits7", Business_Debits7);
		hshValues.put("Business_Debits8", Business_Debits8);
		hshValues.put("Business_Debits9", Business_Debits9);
		hshValues.put("Business_Debits10", Business_Debits10);
		hshValues.put("Business_Debits11", Business_Debits11);
		hshValues.put("Business_Debits12", Business_Debits12);
		hshValues.put("Credit_Counts1", Credit_Counts1);
		hshValues.put("Credit_Counts2", Credit_Counts2);
		hshValues.put("Credit_Counts3", Credit_Counts3);
		hshValues.put("Credit_Counts4", Credit_Counts4);
		hshValues.put("Credit_Counts5", Credit_Counts5);
		hshValues.put("Credit_Counts6", Credit_Counts6);
		hshValues.put("Credits1", Credits1);
		hshValues.put("Credits2", Credits2);
		hshValues.put("Credits3", Credits3);
		hshValues.put("Credits4", Credits4);
		hshValues.put("Credits5", Credits5);
		hshValues.put("Credits6", Credits6);
		hshValues.put("Debit_Counts1", Debit_Counts1);
		hshValues.put("Debit_Counts2", Debit_Counts2);
		hshValues.put("Debit_Counts3", Debit_Counts3);
		hshValues.put("Debit_Counts4", Debit_Counts4);
		hshValues.put("Debit_Counts5", Debit_Counts5);
		hshValues.put("Debit_Counts6", Debit_Counts6);
		hshValues.put("Debits1", Debits1);
		hshValues.put("Debits2", Debits2);
		hshValues.put("Debits3", Debits3);
		hshValues.put("Debits4", Debits4);
		hshValues.put("Debits5", Debits5);
		hshValues.put("Debits6", Debits6);
		hshValues.put("credit_count_12month", credit_count_12month);
		hshValues.put("debit_Count_12months", debit_Count_12months);
		hshValues.put("inward_return", inward_return);
		hshValues.put("Earining1", Earining1);
		
		
		hshValues.put("lastmonth1",months.get(0));
		hshValues.put("lastmonth2",months.get(1));
		hshValues.put("lastmonth3",months.get(2));
		hshValues.put("lastmonth4",months.get(3));
		hshValues.put("lastmonth5",months.get(4));
		hshValues.put("lastmonth6",months.get(5));
		hshValues.put("lastmonth7",months.get(6));
		hshValues.put("lastmonth8",months.get(7));
		hshValues.put("lastmonth9",months.get(8));
		hshValues.put("lastmonth10",months.get(9));
		hshValues.put("lastmonth11",months.get(10));
		hshValues.put("lastmonth12",months.get(11));
		*/
		rs=DBUtils.executeLAPSQuery("selfacratingflagmain^"+strAppno);
		if (rs.next()) 
		{
			hshValues.put("com_whtdigiprd", correctNull(rs.getString("com_whtdigiprd")));
			hshValues.put("com_whtdigiprdRat", correctNull(rs.getString("com_whtdigiprdRat")));
		}
		
		rs=DBUtils.executeLAPSQuery("sel_digi_rate_score^"+strAppno);
		if (rs.next()) 
		{//CONSUMER_PARTY_SCORE,OD_ACCOUNT_SCORE,
			//CURRENT_ACCOUNT_SCORE,FSA_SCORE,BAND_RATING,BAND_PATH,KB_RATING
			hshValues.put("COMMERCIAL_BUREAU_SCORE", correctNull(rs.getString("COMMERCIAL_BUREAU_SCORE")));
			hshValues.put("CONSUMER_IND_SCORE", correctNull(rs.getString("CONSUMER_IND_SCORE")));
			hshValues.put("CONSUMER_PARTY_SCORE", correctNull(rs.getString("CONSUMER_PARTY_SCORE")));
			hshValues.put("OD_ACCOUNT_SCORE", correctNull(rs.getString("OD_ACCOUNT_SCORE")));
			hshValues.put("CURRENT_ACCOUNT_SCORE", correctNull(rs.getString("CURRENT_ACCOUNT_SCORE")));
			hshValues.put("FSA_SCORE", correctNull(rs.getString("FSA_SCORE")));
			hshValues.put("BAND_RATING", correctNull(rs.getString("BAND_RATING")));
			hshValues.put("BAND_PATH", correctNull(rs.getString("BAND_PATH")));
			hshValues.put("KB_RATING", correctNull(rs.getString("KB_RATING")));
			hshValues.put("FINANCIAL_TYPE", correctNull(rs.getString("FINANCIAL_TYPE")));
			hshValues.put("FINANCIAL_YEAR", correctNull(rs.getString("FINANCIAL_YEAR")));

		}
		
		
		rs=DBUtils.executeLAPSQuery("seldigiprd_appl^"+strAppno);
		if (rs.next()) 
		{
			hshValues.put("APP_LOANSUBTYPE_DIGI", correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
			
		}
		
	} 
	catch (Exception ex) 
	{
		ex.printStackTrace();
		throw new EJBException("Error in getScorecardDetails");
	}

	finally 
	{
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) 
		{
			throw new EJBException("Error in closing Connection "+e.getMessage());
		}
	}
	return hshValues;
	
	}

public HashMap financialdigiratingCreation(HashMap hshValues) 
{
	
	String strAction = "", strApp="",lapsid="",strcbsid="",strorgscode="",strorgcode="";
	ResultSet rs = null;
	HashMap hshQuery = new HashMap(); 
	HashMap hshQueryValues = new HashMap();
	ArrayList arrValues = new ArrayList();	

try{
	hshQuery = new HashMap();
	arrValues = new ArrayList();
	arrValues.add(Helper.correctNull((String) hshValues.get("strLapsProposalNumber")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strcommercialBureauScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strconsumerIndScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strconsumerPartyScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strodAccountScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strcurrentAccountScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strfsaScore")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strbandRating")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strbandPath")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strkbRating")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strfindigitype")));
	arrValues.add(Helper.correctNull((String) hshValues.get("strfindigiyear")));
	hshQuery.put("strQueryId","ins_digi_rate_score");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	hshQueryValues.put("size","1");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
	
	
	if(rs!=null)
		rs.close();		
	strcbsid = Helper.correctNull((String) hshValues.get("strCbsId"));
	rs=DBUtils.executeLAPSQuery("sel_lapsidfromcbsid^"+strcbsid);
	if(rs.next())
	{
		lapsid = correctNull(rs.getString("perapp_id"));
	}
	strorgscode = Helper.correctNull((String) hshValues.get("strorgscode"));
	if(rs!=null)
		rs.close();		
	rs=DBUtils.executeLAPSQuery("setorgselectapp^"+strorgscode);
	if(rs.next())
	{
		strorgcode = correctNull(rs.getString("org_code"));
	}
	

    
	hshQuery = new HashMap();
	arrValues = new ArrayList();
	arrValues.add(Helper.correctNull((String) hshValues.get("strLapsProposalNumber")));//fin_ratappno
	arrValues.add(strcbsid);//fin_cbsid
	arrValues.add(lapsid);//fin_appid
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinanceId")));//fin_finid
	arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));//fin_usrid
	arrValues.add(Helper.correctNull((String) hshValues.get("strCMAMastId")));//fin_bussid
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinStatus")));//fin_status 
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinComments")));//fin_comments
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinAppHolder")));//fin_appholder
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinAppname")));//fin_appname
	arrValues.add(strorgcode);//fin_orgcode
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinPartyFile")));//fin_partyfiledet
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinProcessedOn")));//fin_digi_processedon
	arrValues.add(Helper.correctNull((String) hshValues.get("strFinProcessBy")));//fin_digi_processedby
	arrValues.add("Y");//fin_digi_flag
	hshQuery.put("strQueryId","ins_finrating_digi");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	hshQueryValues.put("size","1");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
	
	
	//appmailbox_financialrating
	hshQuery = new HashMap();
	arrValues = new ArrayList();
	arrValues.add(Helper.correctNull((String) hshValues.get("strLapsProposalNumber")));//af_appno
	arrValues.add("SYSUSR");//af_fromuserid
	arrValues.add("SYSUSR");//af_touserid
	arrValues.add("C");//af_type
	arrValues.add("");//af_fromorgdept
	arrValues.add("");//af_toorgcode
	arrValues.add("");//af_toorgdept
	arrValues.add("");
	hshQuery.put("strQueryId","insert_appmailbox");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	hshQueryValues.put("size","1");
	
	//appmailbox_financialrating
	hshQuery = new HashMap();
	arrValues = new ArrayList();
	arrValues.add(Helper.correctNull((String) hshValues.get("strLapsProposalNumber")));//af_appno
	arrValues.add("SYSUSR");//af_fromuserid
	arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));//af_touserid
	arrValues.add("C");//af_type
	arrValues.add("");//af_fromorgdept
	arrValues.add("");//af_toorgcode
	arrValues.add("");//af_toorgdept
	arrValues.add("");
	hshQuery.put("strQueryId","insert_appmailbox");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
	
	//af_appno,af_fromuserid,af_touserid,af_type,af_date,af_fromorgcode,af_fromorgdept,af_toorgcode,af_toorgdept
	
	hshValues.put("strResponseCode", "LAPS-2013");
	hshValues.put("strResponseMsg", "Financials Rating Created Successfully");
	
}
catch (Exception e) {
	
	System.out.println("Exception in FINANCIALS DIGI RATING Creation Service");
	e.printStackTrace();
	throw new EJBException("Exception in FINANCIALS DIGI RATING Creation Service === "+e.getMessage());
}
return hshValues;	
}
public HashMap getRatingHistory(HashMap hshValues) 
{
	ResultSet rs = null; 
	ArrayList arrValues = new ArrayList();
	ArrayList arrRows= new ArrayList();
	HashMap hshRecord = new HashMap();
	
	try{

		if(rs!=null)
			rs.close();		
		String strappno = Helper.correctNull((String) hshValues.get("strAppno"));
		if(strappno.equals(""))
		{
			strappno = Helper.correctNull((String) hshValues.get("AppNO"));
		}
		rs=DBUtils.executeLAPSQuery("sel_his_rating^"+strappno);
		while(rs.next())
		{
			arrValues = new ArrayList();
			arrValues.add(Helper.correctNull(rs.getString(1)));
			arrValues.add(Helper.correctNull(rs.getString(2)));
			arrValues.add(Helper.correctNull(rs.getString(3)));
			arrValues.add(Helper.correctNull(rs.getString(4)));
			arrValues.add(Helper.correctNull(rs.getString(5)));
			arrRows.add(arrValues);
		}
		
		hshRecord.put("arrRows",arrRows);
		hshRecord.put("strappno",strappno);
		
	}catch(Exception e){
		System.out.println("Exception in getRatingHistory");
		e.printStackTrace();
		throw new EJBException("Exception in getRatingHistory === "+e.getMessage());
	}
	return hshRecord;
}




}
