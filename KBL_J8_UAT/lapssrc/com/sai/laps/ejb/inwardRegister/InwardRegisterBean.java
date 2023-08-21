package com.sai.laps.ejb.inwardRegister;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.ejb.mis.MisBean;
import com.sai.laps.ejb.perDeviationBean.PerDeviationBean;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "InwardRegisterBean", mappedName = "InwardRegisterHome")
@Remote (InwardRegisterRemote.class)

public class InwardRegisterBean extends BeanAdapter
{
	private static final long serialVersionUID = 5829027702615765979L;
	static Logger log=Logger.getLogger(InwardRegisterBean.class);	

	public HashMap updatedata(HashMap hsh)
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		String strAction=correctNull((String)hsh.get("hidAction"));
		String strInwardno=correctNull((String)hsh.get("txt_inwardno"));
		String strSolid=correctNull((String)hsh.get("strSolid"));
		StringBuilder sbOldAudit = new StringBuilder();
		ResultSet rs=null,rs1=null;
		String strQuery="";
		String strCityDescOldAudit="";
		String strDistDescOldAudit="";
		String strStateDescOldAudit="";
		String strExp= "$";
		try
		{
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 17/09/2013
			 */
			if(!strAction.equals("new"))
			{
			strQuery=SQLParser.getSqlQuery("selinwardreg^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strCityCodeOldAudit=Helper.correctNull((String)rs.getString("inward_city"));
				String strDistCodeOldAudit=Helper.correctNull((String)rs.getString("inward_dist"));
				String strStateCodeOldAudit=Helper.correctNull((String)rs.getString("inward_state"));
				MastApplicantBean MAB=new MastApplicantBean();
				strCityDescOldAudit=MAB.getCityDistrictStateDesc("city", strCityCodeOldAudit);
				strDistDescOldAudit=MAB.getCityDistrictStateDesc("district", strDistCodeOldAudit);
				strStateDescOldAudit=MAB.getCityDistrictStateDesc("state", strStateCodeOldAudit);
				String strAllDocs=Helper.correctNull((String)rs.getString("inward_docreceived"));
				String strAllDocsDesc="";
				if(strAllDocs.equalsIgnoreCase("Y"))
				{
					strAllDocsDesc="Yes";
				}
				else if(strAllDocs.equalsIgnoreCase("N"))
				{
					strAllDocsDesc="No";
				}
				String strApplnProcessAt=Helper.correctNull((String)rs.getString("inward_applnprocessat"));
				String strApplnProcessAtDesc="";
				if(strApplnProcessAt.equalsIgnoreCase("1"))
				{
					strApplnProcessAtDesc="Branch";
				}
				sbOldAudit.append("Sectors =").append(ApplicantParams.getApplicantParams("SECTOR",Helper.correctNull((String)rs.getString("inward_sector"))))
				.append(" ~ Application No =").append(Helper.correctNull((String)rs.getString("inward_no")))
				.append(" ~ Date =").append(Helper.correctNull((String)rs.getString("inward_createdon")))
				.append(" ~ Name =").append(Helper.correctNull((String)rs.getString("inward_custname")))
				.append(" ~ Date of Birth /Date of commencement of Business /Date of Incorporation =")
				.append(Helper.correctNull((String)rs.getString("inward_dob")));
				if(Helper.correctNull((String)rs.getString("inward_borrowertype")).equalsIgnoreCase("N"))
				{
					sbOldAudit.append(" ~ Type of Borrower = New Connection");
				}
				else
				{
					sbOldAudit.append(" ~ Type of Borrower = Existing Customer")
					.append(" ~ CBS Cust ID=").append(Helper.correctNull((String)rs.getString("inward_cbscustid")));
				}
				sbOldAudit.append(" ~ PAN/TAN No.=").append(Helper.correctNull((String)rs.getString("inward_pantan")))
				.append(" ~ Address =").append(Helper.correctNull((String)rs.getString("inward_add1"))).append(" ")
				.append(Helper.correctNull((String)rs.getString("inward_add2")))
				.append(" ~ City=").append(strCityDescOldAudit)
				.append(" ~ District=").append(strDistDescOldAudit)
				.append(" ~ State =").append(strStateDescOldAudit)
				.append(" ~ Pin code=").append(Helper.correctNull((String)rs.getString("inward_zipcode")))
				.append(" ~ E-mail =").append(Helper.correctNull((String)rs.getString("inward_email")))
				.append(" ~ Phone No. =").append(Helper.correctNull((String)rs.getString("inward_phone")))
				.append(" ~ Mobile No =").append(Helper.correctNull((String)rs.getString("inward_mobile")))
				.append(" ~ Application Received Date =")
				.append(Helper.correctNull((String)rs.getString("inward_appliedon")))
				.append(" ~ Amount =").append(Helper.correctNull((String)rs.getString("inward_termloanamt")))
				.append(" ~ Fund Based Scheme Description=")
				.append(Helper.correctNull((String)rs.getString("inward_scheme")))
				.append(" ~ Additional details / requirements to be submitted =")
				.append(Helper.correctNull((String)rs.getString("inward_additionaldetails")))
				.append(" ~ Whether Application is received with all required documents =")
				.append(strAllDocsDesc)
				.append(" ~ Date of receipt of additional documents as mentioned above =")
				.append(Helper.correctNull((String)rs.getString("inward_docreceivedon")))
				.append(" ~ The application creation and processing will take place in =")
				.append(strApplnProcessAtDesc)
				.append(" ~ Lead No =")
				.append(Helper.correctNull(rs.getString("inw_leadno")));
			}
			}
			/***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equals("new"))
			{
				
				if(rs!=null)
					rs.close();
				
				strQuery=SQLParser.getSqlQuery("sel_inwardchkstatus^"+correctNull((String)hsh.get("txt_cbscustid"))+"^"+correctNull((String)hsh.get("sel_bankscheme")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Helper.correctNull((String)rs.getString("INDINFO_IS_STAFF")).equalsIgnoreCase("01"))
					{
						strExp=strExp+"The Applicant already have a pending LAR Under this Bank Scheme,You cannot create for the same";
						throw new Exception(strExp);
					}
				}
				
				if(rs!=null)
					rs.close();
				
				/*strQuery=SQLParser.getSqlQuery("chk_leadnumber^"+correctNull((String)hsh.get("txt_leadno")).toUpperCase());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strExp=strExp+"The Lead Number already attached with Application Number - "+Helper.correctNull(rs.getString("inward_no")+".Please Proceed with another Lead Number");
					throw new Exception(strExp);
				}*/
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","insinwardreg");
				strInwardno=getMaxInwardno(strSolid);
				arrValues.add(strInwardno);//1 inward_no
				arrValues.add(correctNull((String)hsh.get("hidtype")));//2 inward_sector
				arrValues.add(correctNull((String)hsh.get("txt_appdate")));//4 inward_appliedon
				arrValues.add(correctNull((String)hsh.get("txt_comncustame")).toUpperCase());//5 inward_custname
				arrValues.add(correctNull((String)hsh.get("selcusttype")));//6 inward_borrowertype
				arrValues.add(correctNull((String)hsh.get("txt_cbscustid")));//7 inward_cbscustid
				arrValues.add(correctNull((String)hsh.get("txt_comcustadd1")));//8 inward_add1
				arrValues.add(correctNull((String)hsh.get("txt_comcustadd2")));//9 inward_add2
				arrValues.add(correctNull((String)hsh.get("hidcity")));// 10 inward_city
				arrValues.add(correctNull((String)hsh.get("hid_state")));//11 inward_states
				arrValues.add(correctNull((String)hsh.get("txtcomcust_zip")));//12 inward_zipcode
				arrValues.add(correctNull((String)hsh.get("txtcomcust_phone")));//13 inward_phone
				arrValues.add(correctNull((String)hsh.get("selpurpose")));//14 inward_enquirypurpose
				arrValues.add(correctNull((String)hsh.get("txtcomcust_mobile")));//15 inward_mobile
				arrValues.add(correctNull((String)hsh.get("txtcomcust_email")));//16 inward_email
				arrValues.add(correctNull((String)hsh.get("txt_comDOB")));//17 inward_dob
				arrValues.add(correctNull((String)hsh.get("txtcomcust_pan")).toUpperCase());//18 inward_pantan
				arrValues.add(correctNull((String)hsh.get("txt_comloanpur")).toLowerCase());//19 inward_purpose 
				arrValues.add(correctNull((String)hsh.get("txt_retschemedesc1")));//20 inward_scheme
				if(correctNull((String)hsh.get("hidtype")).equals("p"))
				{
					arrValues.add(correctNull((String)hsh.get("txtret_ftf")));//21 inward_termloanamt
				}
				else
				{
					arrValues.add(correctNull((String)hsh.get("txtcomcust_ftf")));//21 inward_termloanamt
				}
				arrValues.add(correctNull((String)hsh.get("txtcomcust_fwc")));//22 inward_wcloanamt
				arrValues.add(correctNull((String)hsh.get("txtcomcust_nf")));//23 inward_nonwcloanamt
				arrValues.add(correctNull((String)hsh.get("area_details")));//24 inward_ADDITIONALDETAILS
				arrValues.add(correctNull((String)hsh.get("txt_receidate")));//25 inward_docreceivedon
				arrValues.add(correctNull((String)hsh.get("seldocrecd")));//26 inward_docreceived
				arrValues.add(correctNull((String)hsh.get("selappcreation")));//27 inward_applnprocessat
				arrValues.add(correctNull((String)hsh.get("strOrgShortCode")));//28 inward_orgscode
				arrValues.add(correctNull((String)hsh.get("strUserId")));//29 inward_usrid
				arrValues.add(correctNull((String)hsh.get("hidtype")).equals("c")?"L":"A");//30 inward_valuesin
				arrValues.add(correctNull((String)hsh.get("strUserId")));//31 inward_modifiedby
				arrValues.add(correctNull((String)hsh.get("selapplied")));//33 inward_appliedfor
				arrValues.add("C");//34 inward_proptype
				arrValues.add(correctNull((String)hsh.get("txtcomcust_passno")));//35 inward_passportnumber
				arrValues.add(correctNull((String)hsh.get("txtcomcust_voterid")));//36 inward_voterid
				arrValues.add(correctNull((String)hsh.get("selgender")));// 37 inward_gender
				arrValues.add(correctNull((String)hsh.get("sel_cibilreport")));// 38 inward_cibilreport
				arrValues.add(correctNull((String)hsh.get("hid_dist")));//39 District
				arrValues.add(correctNull((String)hsh.get("selapplstatus")));

				arrValues.add(correctNull((String)hsh.get("txt_rejreason")));
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("P")){
				arrValues.add(correctNull((String)hsh.get("sel_scheme")));//added by rajesh on 21/02/2014
				arrValues.add(correctNull((String)hsh.get("sel_bankscheme")));//added by rajesh on 21/02/2014
				}
				else{
				arrValues.add("0");
				arrValues.add("");
				}
				//added by bhaskar fro govt sponser
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("P") || correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("C"))
				{
				arrValues.add(correctNull((String)hsh.get("selectgovtmain")));
				arrValues.add(correctNull((String)hsh.get("schemetypemain")));
				arrValues.add(correctNull((String)hsh.get("submainamnt")));
				arrValues.add(correctNull((String)hsh.get("sel_sponser_agencymain")));
				arrValues.add(correctNull((String)hsh.get("sel_subsidytypemain")));
				arrValues.add(correctNull((String)hsh.get("txt_agency")));	
				}
				else
				{
				arrValues.add("2");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("");
				}
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("C"))
				{
				arrValues.add(correctNull((String)hsh.get("sel_SSI")));
				arrValues.add(correctNull((String)hsh.get("sel_tiny")));
				}
				else{
				arrValues.add("");
				arrValues.add("");
				}
				
				arrValues.add(correctNull((String)hsh.get("txt_clpreceivedate")));
				arrValues.add(correctNull((String)hsh.get("selcanvassedbystaff")));
				arrValues.add(correctNull((String)hsh.get("txt_staffid")));
				arrValues.add(correctNull((String)hsh.get("selborrowerstatus")));
				arrValues.add(correctNull((String)hsh.get("txtnsdlrefno")));
				arrValues.add(correctNull((String)hsh.get("txt_leadno")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("sel_leadgenby")));
				arrValues.add(correctNull((String)hsh.get("hidAgentID")));
				arrValues.add(correctNull((String)hsh.get("txt_convertedid")));
				arrValues.add(correctNull((String)hsh.get("sel_leadregion")));
				
				arrValues.add(correctNull((String)hsh.get("unirefid")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("sourceby")));
				arrValues.add(correctNull((String)hsh.get("sourcebyreason")));

				//ended
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				if(!Helper.correctNull((String)hsh.get("txtnsdlrefno")).equalsIgnoreCase(""))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nsdl_recv_status");				
					arrValues.add("Y");
					arrValues.add(correctNull((String)hsh.get("strUserId")));
					arrValues.add(Helper.correctNull((String)hsh.get("strOrgCode")));
					arrValues.add(Helper.correctNull((String)hsh.get("strOrgShortCode")));
					arrValues.add(strInwardno);
					arrValues.add(Helper.correctNull((String)hsh.get("txtnsdlrefno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","2");
					hshQueryValues.put("2", hshQuery);
				}
				
			}
			else if(strAction.equals("edit"))
			{
				
				if(rs!=null)
					rs.close();
				
				/*strQuery=SQLParser.getSqlQuery("chk_leadnumber^"+correctNull((String)hsh.get("txt_leadno")).toUpperCase());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!correctNull((String)hsh.get("txt_inwardno")).equalsIgnoreCase(Helper.correctNull(rs.getString("inward_no"))))
					{
						strExp=strExp+"The Lead Number already attached with Application Number - "+Helper.correctNull(rs.getString("inward_no")+".Please Proceed with another Lead Number");
						throw new Exception(strExp);
					}
				}*/
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updinwardreg");
				
				arrValues.add(correctNull((String)hsh.get("hidtype")));
				arrValues.add(correctNull((String)hsh.get("txt_appdate")));
				arrValues.add(correctNull((String)hsh.get("txt_comncustame")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("selcusttype")));
				arrValues.add(correctNull((String)hsh.get("txt_cbscustid")));
				arrValues.add(correctNull((String)hsh.get("txt_comcustadd1")));
				arrValues.add(correctNull((String)hsh.get("txt_comcustadd2")));
				arrValues.add(correctNull((String)hsh.get("hidcity")));
				arrValues.add(correctNull((String)hsh.get("hid_state")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_zip")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_phone")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_mobile")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_email")));
				arrValues.add(correctNull((String)hsh.get("txt_comDOB")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_pan")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("txt_comloanpur")).toLowerCase());
				arrValues.add(correctNull((String)hsh.get("txt_retschemedesc1")));
				if(correctNull((String)hsh.get("hidtype")).equals("p"))
				{
					arrValues.add(correctNull((String)hsh.get("txtret_ftf")));
				}
				else
				{
					arrValues.add(correctNull((String)hsh.get("txtcomcust_ftf")));
				}
				arrValues.add(correctNull((String)hsh.get("txtcomcust_fwc")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_nf")));
				arrValues.add(correctNull((String)hsh.get("area_details")));
				arrValues.add(correctNull((String)hsh.get("txt_receidate")));
				arrValues.add(correctNull((String)hsh.get("seldocrecd")));
				arrValues.add(correctNull((String)hsh.get("selappcreation")));
				arrValues.add(correctNull((String)hsh.get("hidtype")).equals("c")?"L":"A");
				arrValues.add(correctNull((String)hsh.get("strUserId")));
				arrValues.add(correctNull((String)hsh.get("selapplied")));
				arrValues.add("C");	
				arrValues.add(correctNull((String)hsh.get("txtcomcust_passno")));
				arrValues.add(correctNull((String)hsh.get("txtcomcust_voterid")));
				arrValues.add(correctNull((String)hsh.get("selpurpose")));
				arrValues.add(correctNull((String)hsh.get("selgender")));
				arrValues.add(correctNull((String)hsh.get("sel_cibilreport")));
				arrValues.add(correctNull((String)hsh.get("hid_dist")));
				arrValues.add(correctNull((String)hsh.get("selapplstatus")));
				
				arrValues.add(correctNull((String)hsh.get("txt_rejreason")));
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("P")){
				arrValues.add(correctNull((String)hsh.get("sel_scheme")));//added by rajesh on 21/02/2014
				arrValues.add(correctNull((String)hsh.get("sel_bankscheme")));//added by rajesh on 21/02/2014
				}
				else{
				arrValues.add("0");
				arrValues.add("");
				}
				//added by bhaskar for govt sponser
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("P") || correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("C"))
				{
				arrValues.add(correctNull((String)hsh.get("selectgovtmain")));
				arrValues.add(correctNull((String)hsh.get("schemetypemain")));
				arrValues.add(correctNull((String)hsh.get("submainamnt")));
				arrValues.add(correctNull((String)hsh.get("sel_sponser_agencymain")));
				arrValues.add(correctNull((String)hsh.get("sel_subsidytypemain")));
				arrValues.add(correctNull((String)hsh.get("txt_agency")));	
				}
				else
				{
				arrValues.add("2");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("");
				}
				
				//end				
				if(correctNull((String)hsh.get("hidtype")).equalsIgnoreCase("C"))
				{
				arrValues.add(correctNull((String)hsh.get("sel_SSI")));
				arrValues.add(correctNull((String)hsh.get("sel_tiny")));
				}
				else{
				arrValues.add("");
				arrValues.add("");
				}
				arrValues.add(correctNull((String)hsh.get("txt_clpreceivedate")));
				arrValues.add(correctNull((String)hsh.get("selcanvassedbystaff")));
				arrValues.add(correctNull((String)hsh.get("txt_staffid")));
				arrValues.add(correctNull((String)hsh.get("selborrowerstatus")));
				arrValues.add(correctNull((String)hsh.get("txt_leadno")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("sel_leadgenby")));
				arrValues.add(correctNull((String)hsh.get("hidAgentID")));
				arrValues.add(correctNull((String)hsh.get("txt_convertedid")));
				arrValues.add(correctNull((String)hsh.get("sel_leadregion")));
				arrValues.add(correctNull((String)hsh.get("unirefid")).toUpperCase());
				arrValues.add(correctNull((String)hsh.get("sourceby")));
				arrValues.add(correctNull((String)hsh.get("sourcebyreason")));
				
				arrValues.add(correctNull((String)hsh.get("txt_inwardno")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
			}
			else if(strAction.equals("delete"))
			{
				hshQuery.put("strQueryId","upd_appinward_delflag");
				arrValues.add(correctNull((String)hsh.get("txt_inwardno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				if(!Helper.correctNull((String)hsh.get("txtnsdlrefno")).equalsIgnoreCase(""))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nsdl_recv_statusundo");				
					arrValues.add(Helper.correctNull((String)hsh.get("txtnsdlrefno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","2");
					hshQueryValues.put("2", hshQuery);
				}
			}
			else if(strAction.equals("assign"))
			{
				hshQuery.put("strQueryId","inwardasignuser");
				arrValues.add(correctNull((String)hsh.get("hidmail_tousrid")));
				arrValues.add(correctNull((String)hsh.get("inwardno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","inssaralmailbox");
				arrValues.add(correctNull((String)hsh.get("inwardno")));
				arrValues.add(correctNull((String)hsh.get("strUserId")));
				arrValues.add(correctNull((String)hsh.get("hidmail_tousrid")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			// for audit trial
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 17/09/2013
			 */
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("new") || strAction.equalsIgnoreCase("edit"))
			{
				sbAuditTrial.append("Sectors =").append(ApplicantParams.getApplicantParams("SECTOR",correctNull((String )hsh.get("hidtype"))))
				.append(" ~ Application No =").append(correctNull((String )hsh.get("inwardno")));
				sbAuditTrial.append(" ~ Date =").append(correctNull((String )hsh.get("txt_date1")));
				if(correctNull((String )hsh.get("hidtype")).trim().equalsIgnoreCase("C"))
				{
					sbAuditTrial.append(" ~ Proposal Type =").append(ApplicantParams.getApplicantParams("PROPOSALTYPE",correctNull((String )hsh.get("prop_type"))));
				}
				sbAuditTrial.append(" ~ Name =").append(correctNull((String )hsh.get("txt_comncustame")));
				//sbAuditTrial.append(" ~ Gender =").append(ApplicantParams.getApplicantParams("apptype",correctNull((String )hsh.get("selgender"))));
				/*if(correctNull((String )hsh.get("sel_cibilreport")).equals("1"))
				{
					sbAuditTrial.append(" ~ Whether CIBIL report required? =").append("Yes");
				}
				else if(correctNull((String )hsh.get("sel_cibilreport")).equals("2")) 
				{
					sbAuditTrial.append(" ~ Whether CIBIL report required? =").append("No");
				}
				else
				{
					sbAuditTrial.append(" ~ Whether CIBIL report required? =").append("");
				}*/
				sbAuditTrial.append(" ~ Date of Birth /Date of commencement of Business /Date of Incorporation =").append(correctNull((String )hsh.get("txt_comDOB")));
				
				if(correctNull((String)hsh.get("selcusttype")).trim().equalsIgnoreCase("N"))
				{
					sbAuditTrial.append(" ~ Type of Borrower = New Connection");
				}
				else
				{
					sbAuditTrial.append(" ~ Type of Borrower = Existing Customer");
					sbAuditTrial.append(" ~ CBS Cust ID=").append(correctNull((String )hsh.get("txt_cbscustid")));
				}
				sbAuditTrial
				.append(" ~ PAN/TAN No.=").append(correctNull((String )hsh.get("txtcomcust_pan")))
				//.append(" ~ Passport Number=").append(correctNull((String )hsh.get("txtcomcust_passno")))
				//.append(" ~ Voter ID =").append(correctNull((String )hsh.get("txtcomcust_voterid")))
				.append(" ~ Address =").append(correctNull((String )hsh.get("txt_comcustadd1"))).append("&nbsp;&nbsp;").append(correctNull((String )hsh.get("txt_comcustadd2")))
				.append(" ~ City=").append(correctNull((String )hsh.get("txt_comcustcity")))
				.append(" ~ District=").append(correctNull((String )hsh.get("txt_comndist")))
				.append(" ~ State =").append(correctNull((String )hsh.get("txtcomcust_state")))
				.append(" ~ Pin code=").append(correctNull((String )hsh.get("txtcomcust_zip")))
				.append(" ~ E-mail =").append(correctNull((String )hsh.get("txtcomcust_email")))
				.append(" ~ Phone No. =").append(correctNull((String )hsh.get("txtcomcust_phone")))
				.append(" ~ Mobile No =").append(correctNull((String )hsh.get("txtcomcust_mobile")))
				.append(" ~ Application Received Date =").append(correctNull((String )hsh.get("txt_appdate")));
				if(!(correctNull((String )hsh.get("hidtype")).trim().equalsIgnoreCase("c"))&&
						!(correctNull((String )hsh.get("hidtype")).trim().equalsIgnoreCase("t")))
				{
					sbAuditTrial.append(" ~ Amount =").append(correctNull((String )hsh.get("txtret_ftf")));
					sbAuditTrial.append(" ~ Fund Based Scheme Description=").append(correctNull((String )hsh.get("txt_retschemedesc1")));
					/*if(correctNull((String )hsh.get("hidpurpose")).equalsIgnoreCase("")||correctNull((String )hsh.get("hidpurpose")).equalsIgnoreCase("<---Select--->"))
					{
						sbAuditTrial.append(" ~ Enquiry Purpose =").append("");
					}else{
						sbAuditTrial.append(" ~ Enquiry Purpose =").append(correctNull((String )hsh.get("hidpurpose")));
					}*/
				}
				if(correctNull((String )hsh.get("hidtype")).trim().equalsIgnoreCase("t"))
				{
					if(correctNull((String )hsh.get("hidpurpose")).equalsIgnoreCase("")||correctNull((String )hsh.get("hidpurpose")).equalsIgnoreCase("<---Select--->"))
					{
						sbAuditTrial.append(" ~ Enquiry Purpose =").append("");
					}else{
						sbAuditTrial.append(" ~ Enquiry Purpose =").append(correctNull((String )hsh.get("hidpurpose")));
					}
					sbAuditTrial.append(" ~ Fund Based a. Working Capital =").append(correctNull((String )hsh.get("txtcomcust_fwc")));
					sbAuditTrial.append(" ~ Fund Based b. Term loan =").append(correctNull((String )hsh.get("txtcomcust_ftf")));
					sbAuditTrial.append(" ~ Non Fund Based =").append(correctNull((String )hsh.get("txtcomcust_nf")));
				}
				sbAuditTrial.append(" ~ Additional details / requirements to be submitted =").append(correctNull((String )hsh.get("area_details")));
				
				String strdocuments="";
				if(correctNull((String )hsh.get("seldocrecd")).equalsIgnoreCase("Y"))
				{
					strdocuments="Yes";
				}
				else
				{
					strdocuments="No";
				}
				String strappcreation="";
				if(correctNull((String )hsh.get("selappcreation")).equalsIgnoreCase("1")){
					strappcreation="Branch";
				}
				/*else if(correctNull((String )hsh.get("selappcreation")).equalsIgnoreCase("2")){
					strappcreation="SARAL";
				}*/
				else
				{
					strappcreation="";
				}
				sbAuditTrial.append(" ~ Whether Application is received with all required documents =").append(strdocuments).append("~Date of receipt of additional documents as mentioned above =").append(correctNull((String )hsh.get("txt_receidate")))
				.append(" ~ The application creation and processing will take place in =").append(strappcreation)
				.append(" ~ Lead No =").append(correctNull((String)hsh.get("txt_leadno")).toUpperCase());
				
				if (strAction.equalsIgnoreCase("New"))
				{
					hsh.remove("hidAction");
					hsh.put("hidAction","insert");
				}
				else if(strAction.equalsIgnoreCase("Edit"))
				{
					hsh.remove("hidAction");
					hsh.put("hidAction","update");
				}
			}
			AuditTrial.auditNewLog(hsh,"220",strInwardno,sbAuditTrial.toString(),sbOldAudit.toString());
			/***
			 * End - Audit Trial Old Data
			 */
			hsh.put("inwardno",strInwardno);
			
			if(strAction.equals("edit")||strAction.equals("new"))
			{
				if(Helper.correctNull((String)hsh.get("seldocrecd")).equalsIgnoreCase("N")||Helper.correctNull((String)hsh.get("selapplstatus")).equalsIgnoreCase("2"))
				{
					
					StringBuilder strOldAudit=new StringBuilder();
					
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("sel_nsdlremarks^"+Helper.correctNull((String)hsh.get("txtnsdlrefno")));
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strOldAudit.append("NSDL Status =").append(correctNull(rs.getString("nsdl_status")))
						.append("~Remarks= ").append(correctNull(rs.getString("nsdl_remarks")));
					}
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updNSDLAppStatusRemarks");	
					if(Helper.correctNull((String)hsh.get("selapplstatus")).equalsIgnoreCase("2"))
					{
						arrValues.add(Helper.correctNull((String)hsh.get("txt_rejreason")));
						arrValues.add("04");
					}
					else
					{
						arrValues.add(Helper.correctNull((String)hsh.get("hidnsdlremarks")));
						arrValues.add("05");
					}
					arrValues.add(Helper.correctNull((String)hsh.get("txtnsdlrefno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
					StringBuilder sbAuditTrial1=new StringBuilder();
					sbAuditTrial1.append("NSDL Status = ").append(correctNull((String)arrValues.get(1)))
						.append("~Remarks= ").append(correctNull((String)arrValues.get(0)));
					
					AuditTrial.auditNewLog(hsh,"432",Helper.correctNull((String)hsh.get("txtnsdlrefno")),sbAuditTrial1.toString(),strOldAudit.toString());
				}
			}
			hshRecord=getdata(hsh);
			
			if(strAction.equals("new") && Helper.correctNull((String)hsh.get("selappcreation")).equalsIgnoreCase("6"))
			{
				String strMessage="";
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_sms_master");
				if(rs.next())
				{
					strMessage=Helper.correctNull(rs.getString("sms_process"));
				}
				
				strMessage=strMessage.replaceAll("@CName", Helper.correctNull((String)hsh.get("txt_comncustame"))).replace("@LARNO", strInwardno);
				
				if(Helper.correctNull((String)hsh.get("selapplstatus")).equalsIgnoreCase("1") && 
						ApplicationParams.getSMSFlag().equalsIgnoreCase("TRUE") 
//						&&(Helper.correctNull((String)hsh.get("sel_bankscheme")).equalsIgnoreCase("003")
//								||Helper.correctNull((String)hsh.get("sel_bankscheme")).equalsIgnoreCase("102"))
								)
				{
					log.info("================== Message Service================");
					String charset="UTF-8",strFileIds="";
					
					String query = null;
					URLConnection conn = null;
					
					try{
						query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
								ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
										ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
										.encode(Helper.correctNull((String)hsh.get("txtcomcust_mobile")), charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
										URLEncoder.encode(strMessage, charset));
						
						log.info("==================Invoking Service in Try Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
						conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
						log.info("================== Service Ended================");
						
						
					}catch(Exception e)
					{
						query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+Helper.correctNull((String)hsh.get("txtcomcust_mobile"))+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
						log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
						conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
						log.info("================== Service Ended================");
						
					}
					
					conn.setDoOutput(true);
					conn.setRequestProperty("Accept-Charset", charset);
					BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					String output;
					while ((output = br.readLine()) != null) {
						strFileIds = output;
					}
					
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(Helper.correctNull((String)hsh.get("txtcomcust_mobile")));
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
			boolean bflag=true;
			if(rs!=null)
				rs.close();

			if(!(Helper.correctNull((String)hsh.get("sel_leadgenby")).equalsIgnoreCase("")||Helper.correctNull((String)hsh.get("sel_leadgenby")).equalsIgnoreCase("BSA")||Helper.correctNull((String)hsh.get("sel_leadgenby")).equalsIgnoreCase("DSA")))
			{
				rs=DBUtils.executeLAPSQuery("selstatdatabyiddesc^218^"+Helper.correctNull((String)hsh.get("sel_leadgenby")));
				if(rs.next())
				{
					if(!Helper.correctNull(rs.getString("stat_data_value")).equalsIgnoreCase("Y"))
						bflag=false;
				}
			}
			
			//BSA/DSA - SMS service
			if(strAction.equals("new") && Helper.correctNull((String)hsh.get("selcanvassedbystaff")).equalsIgnoreCase("N") && !Helper.correctNull((String)hsh.get("hidAgentID")).equalsIgnoreCase("")&&bflag)
			{
				String strMessage="",strMobile="",strName="";
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_sms_master_others^"+Helper.correctNull((String)hsh.get("sel_leadgenby")));
				if(rs.next())
				{
					strMessage=Helper.correctNull(rs.getString("sms_inprocess"));
				}
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_BSADSA_agentname^"+Helper.correctNull((String)hsh.get("hidAgentID")));
				if(rs.next())
				{
					strMobile=Helper.correctNull(rs.getString("BSADSA_MOBILENON"));
					strName=Helper.correctNull(rs.getString("BSADSA_NAME"));
					
					if(!strName.equalsIgnoreCase(""))
					{
						strName=(strName.split("-"))[0];
					}
				}
				
				
				strMessage=strMessage.replaceAll("@CName", Helper.correctNull((String)hsh.get("txt_comncustame"))).replace("@LARNO", strInwardno).replace("@AgentName", strName);
				
				if(Helper.correctNull((String)hsh.get("selapplstatus")).equalsIgnoreCase("1") && 
						ApplicationParams.getSMSFlag().equalsIgnoreCase("TRUE")&& !strMobile.equalsIgnoreCase(""))
				{
					log.info("================== Message Service for BSA/DSA================");
					String charset="UTF-8",strFileIds="";
					
					String query = null;
					URLConnection conn = null;
					
					try{
						query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
								ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
										ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
										.encode(strMobile, charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
										URLEncoder.encode(strMessage, charset));
						
						
						log.info("==================Invoking Service in Try Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
						conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
						log.info("================== Service Ended================");
						
						
					}catch(Exception e)
					{
						query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+strMobile+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
						log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
						conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
						log.info("================== Service Ended================");
						
					}
					
					conn.setDoOutput(true);
					conn.setRequestProperty("Accept-Charset", charset);
					BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					String output;
					while ((output = br.readLine()) != null) {
						strFileIds = output;
					}
					
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strMobile);
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
			
			if(strAction.equals("edit"))
			{
				if(rs!=null)
					rs.close();
				
				strQuery=SQLParser.getSqlQuery("sel_inwardstatus^"+correctNull((String)hsh.get("inwardno")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strGovtSponsorSch="";
					if(Helper.correctNull((String)hshRecord.get("category")).equalsIgnoreCase("p"))
					{
						rs1=DBUtils.executeLAPSQuery("getlreq^"+Helper.correctNull(rs.getString("app_no")));
						if(rs1.next())
						{
							strGovtSponsorSch=Helper.correctNull(rs1.getString("GOVT_SCHEME"));
						}
						
						
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_loandetails_govtscheme");
						arrValues.add(correctNull((String)hsh.get("selectgovtmain")));
						arrValues.add(correctNull((String)hsh.get("submainamnt")));
						arrValues.add(correctNull((String)hsh.get("schemetypemain")));
						arrValues.add(correctNull((String)hsh.get("sel_sponser_agencymain")));
						arrValues.add(correctNull((String)hsh.get("sel_subsidytypemain")));
						arrValues.add(correctNull((String)hsh.get("txt_agency")));
						arrValues.add(Helper.correctNull(rs.getString("app_no")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						
						if(strGovtSponsorSch.equalsIgnoreCase("078") || strGovtSponsorSch.equalsIgnoreCase("079"))
						{
							if(!strGovtSponsorSch.equalsIgnoreCase(correctNull((String)hsh.get("schemetypemain"))))
							{
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_pmay_desc");
								arrValues.add(Helper.correctNull(rs.getString("app_no")));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("2",hshQuery);
								hshQueryValues.put("size","2");
							}
						}
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			
			if(strAction.equals("assign"))
				hshRecord.put("status","DATASUCCESS");
			if(strAction.equalsIgnoreCase("edit"))
			{
				Deleterecordes(hsh);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updatedata..."+e.toString());
		}
		return hshRecord;
	}

	public HashMap getdata(HashMap hsh)
	{
		String strQuery="";
		String strInwardno="";
		ResultSet rs=null;
		ResultSet rs3=null;
		HashMap hshValues=new HashMap();
		strInwardno=correctNull((String)hsh.get("txt_inwardno"));
		if(strInwardno.equals(""))
			strInwardno=correctNull((String)hsh.get("inwardno"));
		String strUser = correctNull((String) hsh.get("strUserId"));
		String ISorghead="N";
		String IsSaralhead="N"; 
		String strDistcode="";
   	 	String strDistDesc="";
		try
		{	
			if(!strInwardno.equals(""))
			{
				if(rs!=null)
					rs=null;
				strQuery = SQLParser.getSqlQuery("selinwardreg^"+strInwardno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("inwardno",correctNull(rs.getString("inward_no")));//0
					hshValues.put("createdon",correctNull(rs.getString("inward_createdon")));//1
					hshValues.put("appliedon",correctNull(rs.getString("inward_appliedon")));//2
					hshValues.put("customername",correctNull(rs.getString("inward_custname")));//3
					hshValues.put("customeradd1",correctNull(rs.getString("inward_add1")));//4
					hshValues.put("customeradd2",correctNull(rs.getString("inward_add2")));//5
					hshValues.put("customercitycode",correctNull(rs.getString("inward_city")));//6
					hshValues.put("customerstatecode",correctNull(rs.getString("inward_state")));//7
					hshValues.put("customerpin",correctNull(rs.getString("inward_zipcode")));//8
					hshValues.put("customerphone",correctNull(rs.getString("inward_phone")));//9
					hshValues.put("customermobile",correctNull(rs.getString("inward_mobile")));//10
					hshValues.put("customeremail",correctNull(rs.getString("inward_email")));//11
					hshValues.put("customerDOB",correctNull(rs.getString("inward_dob")));//12
					hshValues.put("customerpan",correctNull(rs.getString("inward_pantan")));//13
					hshValues.put("loanpurpose",correctNull(rs.getString("inward_purpose")));//14
					hshValues.put("schemedesc",correctNull(rs.getString("inward_scheme")));//15
					hshValues.put("fundtermloan",correctNull(rs.getString("inward_termloanamt")));//16
					hshValues.put("fundworkingcapital",correctNull(rs.getString("inward_wcloanamt")));//17
					hshValues.put("nonfund",correctNull(rs.getString("inward_nonwcloanamt")));//18
					hshValues.put("additional_details",correctNull(rs.getString("inward_ADDITIONALDETAILS")));//19
					hshValues.put("docreceiveddate",correctNull(rs.getString("inward_docreceivedon")));//20
					hshValues.put("docreceived",correctNull(rs.getString("inward_docreceived")));//21
					hshValues.put("processedat",correctNull(rs.getString("inward_applnprocessat")));//22
					hshValues.put("category",correctNull(rs.getString("inward_sector")));//23
					hshValues.put("customercity",correctNull(rs.getString("custcity")));//24
					hshValues.put("customerstate",correctNull(rs.getString("custstate")));//25
					hshValues.put("orgscode",correctNull(rs.getString("inward_orgscode")));//26
					hshValues.put("orgname",correctNull(rs.getString("org_name")));//27
					hshValues.put("orgadd1",correctNull(rs.getString("org_add1")));
					hshValues.put("orgadd2",correctNull(rs.getString("org_add2")));
					hshValues.put("orgcity",correctNull(rs.getString("city_name")));
					hshValues.put("orgstate",correctNull(rs.getString("state_name")));
					hshValues.put("orgzip",correctNull(rs.getString("org_zip")));
					hshValues.put("orgphone",correctNull(rs.getString("org_phone")));
					hshValues.put("cbscustid",correctNull(rs.getString("inward_cbscustid")));
					hshValues.put("borrowertype",correctNull(rs.getString("inward_borrowertype")));
					hshValues.put("inward_appliedfor",correctNull(rs.getString("inward_appliedfor")));
					hshValues.put("inward_proptype",correctNull(rs.getString("inward_proptype")));
					hshValues.put("status",correctNull(rs.getString("INWARD_BRSTATUS")));
					hshValues.put("assignusrid",correctNull(rs.getString("INWARD_ASSIGNUSRID")));
					hshValues.put("appatached",correctNull(rs.getString("INWARD_APPATACHED")));
					hshValues.put("valuesin",correctNull(rs.getString("INWARD_VALUESIN")));				
					hshValues.put("sectordesc",correctNull(rs.getString("sectordesc")));
					hshValues.put("dataexists","Y");
					hshValues.put("customerpassport",correctNull(rs.getString("INWARD_PASSPORTNUMBER")));
					hshValues.put("customervoterid",correctNull(rs.getString("INWARD_VOTERID")));
					hshValues.put("INWARD_ENQUIRYPURPOSE",correctNull(rs.getString("INWARD_ENQUIRYPURPOSE")));
					hshValues.put("INWARD_GENDER",correctNull(rs.getString("inward_gender")));
					hshValues.put("INWARD_CIBILREPORT",correctNull(rs.getString("inward_cibilreport")));	

					strDistcode = Helper.correctNull((String)rs.getString("INWARD_DIST"));
					if(!strDistcode.equalsIgnoreCase(""))
					{				
					if(rs3!=null)
					{
						rs3.close();
					}
					rs3=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
					if(rs3.next())
					{
						
						strDistDesc = Helper.correctNull((String)rs3.getString("district_desc"));//15					
					}
					}
					hshValues.put("INWARD_DIST", strDistDesc);
					hshValues.put("INWARD_DISTCODE",strDistcode);
					hshValues.put("inward_appstatus",correctNull(rs.getString("inward_appstatus")));
					hshValues.put("inward_rejreason",correctNull(rs.getString("inward_rejreason")));
					hshValues.put("inward_schemedesc",correctNull(rs.getString("inward_schemedesc")));
					hshValues.put("inward_bankscheme",correctNull(rs.getString("inward_bankscheme")));
					//added by bhaskar
					hshValues.put("inward_govtspons",correctNull(rs.getString("inward_govtspons")));
					hshValues.put("inward_schmetype",correctNull(rs.getString("inward_schmetype")));
					hshValues.put("inward_subsamount",correctNull(rs.getString("inward_subsamount")));
					hshValues.put("inward_sponagency",correctNull(rs.getString("inward_sponagency")));
					hshValues.put("inward_subsdtype",correctNull(rs.getString("inward_subsdtype")));
					hshValues.put("inward_otheragency",correctNull(rs.getString("inward_otheragency")));
					hshValues.put("INWARD_SSI",correctNull(rs.getString("INWARD_SSI")));
					hshValues.put("INWARD_TINY",correctNull(rs.getString("INWARD_TINY")));
					hshValues.put("inward_clpudate",correctNull(rs.getString("inward_clpudate")));
					hshValues.put("inward_canvassedbystaff",correctNull(rs.getString("inward_canvassedbystaff")));
					hshValues.put("inward_staffid",correctNull(rs.getString("inward_staffid")));
					hshValues.put("inward_borrowerstatus",correctNull(rs.getString("inward_borrowerstatus")));
					hshValues.put("inw_leadno",correctNull(rs.getString("inw_leadno")));
					if(!correctNull(rs.getString("inward_staffid")).equalsIgnoreCase(""))
					{				
						if(rs3!=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeLAPSQuery("selectusername^"+correctNull(rs.getString("inward_staffid")));
						if(rs3.next())
						{
							
							hshValues.put("inward_staffname",correctNull(rs3.getString("name")));				
						}
					}
					hshValues.put("inward_nsdlrefno",correctNull(rs.getString("inward_nsdlrefno")));
					//end	
					
					if(!correctNull(rs.getString("inward_nsdlrefno")).equalsIgnoreCase(""))
					{				
					if(rs3!=null)
					{
						rs3.close();
					}
					rs3=DBUtils.executeLAPSQuery("sel_nsdlapplication^"+correctNull(rs.getString("inward_nsdlrefno")));
					if(rs3.next())
					{
						
						hshValues.put("strAppname",Helper.correctNull(rs3.getString("nsdl_appname")));					
						hshValues.put("strAppDOB",Helper.correctNull(rs3.getString("cus_dob")));					
						hshValues.put("strRemarks",Helper.correctNull(rs3.getString("nsdl_remarks")));					
					}
					}
					
					{				
						if(rs3!=null)
						{
							rs3.close();
						}
						/*rs3=DBUtils.executeLAPSQuery("selectusername^"+correctNull(rs.getString("inward_usrid")));
						if(rs3.next())
						{
							
							hshValues.put("usr_rlpftype",correctNull(rs3.getString("usr_rlpftype")));				
						}*/
					}
					
					if(!correctNull(rs.getString("INWARD_AGENTID")).equalsIgnoreCase(""))
					{				
						if(rs3!=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeLAPSQuery("sel_BSADSA_agentname^"+correctNull(rs.getString("INWARD_AGENTID")));
						if(rs3.next())
						{
							hshValues.put("INWARD_AGENTname",Helper.correctNull(rs3.getString("BSADSA_NAME")));					
						}
					}
					hshValues.put("INWARD_AGENTID",correctNull(rs.getString("INWARD_AGENTID")));
					hshValues.put("INWARD_LEADGENBY",correctNull(rs.getString("INWARD_LEADGENBY")));
					
					
					if(!correctNull(rs.getString("INWARD_CONVERTEDBY")).equalsIgnoreCase(""))
					{				
						if(rs3!=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeLAPSQuery("selectusername^"+correctNull(rs.getString("INWARD_CONVERTEDBY")));
						if(rs3.next())
						{
							
							hshValues.put("INWARD_CONVERTEDBYname",correctNull(rs3.getString("name")));				
						}
					}
					hshValues.put("INWARD_CONVERTEDBY",correctNull(rs.getString("INWARD_CONVERTEDBY")));
					hshValues.put("INWARD_EXTERNALAPP_FLAG",correctNull(rs.getString("INWARD_EXTERNALAPP_FLAG")));					

					hshValues.put("INWARD_EXTERNALAPP_FLAG",correctNull(rs.getString("INWARD_EXTERNALAPP_FLAG")));
					hshValues.put("INWARD_ADDRESSCHANGE_FLAG",correctNull(rs.getString("INWARD_ADDRESSCHANGE_FLAG")));
					hshValues.put("INWARD_CIBILSCORE",correctNull(rs.getString("INWARD_CIBILSCORE")));
					hshValues.put("INWARD_CIBILDETAILS",correctNull(rs.getString("INWARD_CIBILDETAILS")));
					hshValues.put("INWARD_LEADREGION",correctNull(rs.getString("INWARD_LEADREGION")));
					
					
					hshValues.put("UNIQUEID",correctNull(rs.getString("UNIQUEID")));
					hshValues.put("SOURCE_BY",correctNull(rs.getString("SOURCE_BY")));
					hshValues.put("REASON_JS",correctNull(rs.getString("REASON_JS")));
					
					
				}
				if(correctNull((String)hsh.get("strOrgLevel")).equals("A"))
		 		{
					strQuery=SQLParser.getSqlQuery("setorgselect^"+ correctNull((String)hsh.get("strOrgCode")));
					if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(correctNull(rs.getString("org_head")).equals(strUser))
						{
							ISorghead="Y";
						}
					}
		 		}
				else if(correctNull((String)hsh.get("strOrgLevel")).equals("D"))
				{
					strQuery=SQLParser.getSqlQuery("setorgselect^"+
		 					correctNull((String)hsh.get("strOrgCode")));
					if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{ 
						if(correctNull(rs.getString("org_saralhead")).equals(strUser))
						{
							IsSaralhead="Y";
						}
					}
				}
				
				if(Helper.correctNull((String)hshValues.get("appatached")).equalsIgnoreCase("Y"))
				{
					if(rs!=null)
			 			 rs.close();
					strQuery=SQLParser.getSqlQuery("sel_inwardstatus^"+strInwardno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{ 
						hshValues.put("created_date", correctNull((String)rs.getString("created_date")));
						//if(correctNull(rs.getString("app_nprefid")).equalsIgnoreCase(" "))
						//{
						if(correctNull(rs.getString("app_status")).equalsIgnoreCase("op"))
						{
							hshValues.put("appatached", "N");
							if(correctNull(rs.getString("app_nprefid")).equalsIgnoreCase(""))
								{
							       hshValues.put("appattachFlag", "Y");
						        }
						}
						//}
						if(correctNull(rs.getString("app_loantype")).equalsIgnoreCase("P"))
						{
							if(rs3!=null)
							{
								rs3.close();
							}
							rs3=DBUtils.executeLAPSQuery("sel_loan_amtreqd_app^"+correctNull(rs.getString("app_no")));
							if(rs3.next())
							{
								
								hshValues.put("strLoanAmount",Helper.correctDouble(rs3.getString("loan_amtreqd")));				
							}
						}
						else if(correctNull(rs.getString("app_loantype")).equalsIgnoreCase("A")||correctNull(rs.getString("app_loantype")).equalsIgnoreCase("C"))
						{
							if(rs3!=null)
							{
								rs3.close();
							}
							rs3=DBUtils.executeLAPSQuery("sel_facilityproposedsum^"+correctNull(rs.getString("app_no")));
							if(rs3.next())
							{
								
								hshValues.put("strLoanAmount",Helper.correctDouble(rs3.getString("facility_proposed")));				
							}
						}
					}
				}
				
			}
			hshValues.put("IsSaralhead",IsSaralhead);
			hshValues.put("ISorghead",ISorghead);
			
			rs = DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"32^OMNIDOCS");
			if(rs.next())
			{
				hshValues.put("ipaddress",correctNull((String)rs.getString("stat_data_desc1")));
			}
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"32^DMSUpload");
			if(rs.next())
			{
				hshValues.put("DMSUPLOAD",correctNull((String)rs.getString("stat_data_desc1")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^122");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("strLMSAvail",Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_inwardrlpc^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("strRlpcFlag","Y");
			}
			//vindhya begin PAN check
			java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			double dblchecklimit = 0.0;
			 double dblchecklimit3 = 0.0;
			 String strQuery11="";
			 String strQuery12="";
			 String sector = correctNull((String) hsh.get("hidtype"));
			 if(sector.equalsIgnoreCase(""))
			 { 
			 strQuery11 = SQLParser.getSqlQuery("getinwardsector^"+strInwardno);
				rs = DBUtils.executeQuery(strQuery11);
				if (rs.next()) {
					sector = Helper.correctNull(rs.getString("inward_sector"));
				}
			 }	
			 if (sector.equalsIgnoreCase("A")) {
			 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
				rs = DBUtils.executeQuery(strQuery11);
				if (rs.next()) {
					dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
				}
				
			 }
			 else if (sector.equalsIgnoreCase("C")) {
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
			
			 hshValues.put("strChecklimit", jtn.format(dblchecklimit));
			 
			 String strPanCheck="";
			 if (rs != null)
					rs.close();

				strQuery = SQLParser
						.getSqlQuery("sel_lapsapplicationparameters^132"); 
				rs = DBUtils.executeQuery(strQuery);
				/*strQuery = SQLParser
						.getSqlQuery("getPANparameters^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);*/
				
				if (rs.next()) {
					strPanCheck = Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
					hshValues.put("strPanCheck", strPanCheck);
				}
			//vindhya begin PAN check
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
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
		return hshValues;
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
	
	public HashMap  getInwardnoSearchList(HashMap hshValues) 
	{			
		ResultSet rs = null,rs1=null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		
		try
		{
			String name = correctNull((String)hshValues.get("txt_ackname"));
			String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			String strCategory=correctNull((String)hshValues.get("Category"));
			String strCategory1=correctNull((String)hshValues.get("Category"));
			String strCBSid=correctNull((String)hshValues.get("CBSid"));
			if(strCBSid.equalsIgnoreCase(""))
			{
				strCBSid=correctNull((String)hshValues.get("hidCBSid"));
			}
			String strCusprofile=correctNull((String)hshValues.get("Cusprofile"));
			String strUser=correctNull((String)hshValues.get("strUserId"));
			String proposal=correctNull((String)hshValues.get("proposal"));
			String radiobutton=correctNull((String)hshValues.get("rdovalue"));
			
			if(proposal.equalsIgnoreCase(""))
			{
				proposal = "C";
			}
			strCategory=strCategory.equals("LAD")?"'p','a'":"'"+strCategory+"'";
			String strQuery="",strCbsid="",strCbsSec="",strDocrecev="";
			boolean skipflag=true;
			
			if(radiobutton.equalsIgnoreCase("name"))
			{
				skipflag=false;
				strQuery=SQLParser.getSqlQuery("sel_inwardchkby_name^"+name+"^"+strCategory1);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					strCbsid=Helper.correctNull(rs1.getString("INWARD_CBSCUSTID"));
					if(strCBSid.equalsIgnoreCase(strCbsid))
					{
						skipflag=true;
						continue;
					}
				}
				if(!skipflag)
				{
					hshRecord.put("strCbsidchk","N");
				}
			}else if(radiobutton.equalsIgnoreCase("inward"))
			{
				strQuery=SQLParser.getSqlQuery("sel_inwardchkby_inwardno^"+name);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strCbsSec=Helper.correctNull(rs1.getString("INWARD_SECTOR"));
					strCbsid=Helper.correctNull(rs1.getString("INWARD_CBSCUSTID"));
					strDocrecev=Helper.correctNull(rs1.getString("inward_docreceived"));
					if(!(strCBSid.equalsIgnoreCase(strCbsid)))
					{
						hshRecord.put("strCbsidchk","N");
						skipflag=false;
					}
					if(!(strCategory1.equalsIgnoreCase(strCbsSec)))
					{
						hshRecord.put("strSecchk","N");
						skipflag=false;
					}
					if(strDocrecev.equalsIgnoreCase("N"))
					{
						hshRecord.put("strDocrecv","N");
						//skipflag=false;
					}
				}
			}
			else if(!strCBSid.equalsIgnoreCase(""))
			{
				radiobutton="cbscustid";
				name=strCBSid;
//				strQuery=SQLParser.getSqlQuery("sel_inwardchkby_cbscustid^"+name+"^"+strCategory1);
//				rs1 = DBUtils.executeQuery(strQuery);
//				if(rs1.next())
//				{
//					strCbsSec=Helper.correctNull(rs1.getString("INWARD_SECTOR"));
//					strCbsid=Helper.correctNull(rs1.getString("INWARD_CBSCUSTID"));
//					strDocrecev=Helper.correctNull(rs1.getString("inward_docreceived"));
//					String strInwardNo=Helper.correctNull(rs1.getString("inward_no"));
//					
//					if(!(strCBSid.equalsIgnoreCase(strCbsid)))
//					{
//						hshRecord.put("strCbsidchk","N");
//						skipflag=false;
//					}
//					if(!(strCategory1.equalsIgnoreCase(strCbsSec)))
//					{
//						hshRecord.put("strSecchk","N");
//						skipflag=false;
//					}
//					if(strDocrecev.equalsIgnoreCase("N"))
//					{
//						hshRecord.put("strDocrecv","N");
//						skipflag=false;
//					}
//					
//				}
			} 
			strQuery="";
			if(skipflag)
			{
				if(!(name.trim().equalsIgnoreCase("")))
				{
				if(strOrglevel.equals("A"))
				{
					if(radiobutton.equalsIgnoreCase("name"))
					{
						if(strCategory.equals("'c'") || strCategory.equals("'a'"))
						{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist^"+strOrgSelect+"^"+name+"^and inward_proptype='"+proposal+"'^1^"+strCategory+"^"+strCBSid);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist^"+strOrgSelect+"^"+name+"^ ^1^"+strCategory+"^"+strCBSid);
						}
					}else if(radiobutton.equalsIgnoreCase("inward")){
						if(strCategory.equals("'c'") || strCategory.equals("'a'")) 
						{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_srchno^"+strOrgSelect+"^"+name+"^and inward_proptype='"+proposal+"'^1^"+strCategory+"^"+strCBSid);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_srchno^"+strOrgSelect+"^"+name+"^ ^1^"+strCategory+"^"+strCBSid);
						}
					}else if(radiobutton.equalsIgnoreCase("cbscustid")){ //Added by Kishan
						if(strCategory.equals("'c'") || strCategory.equals("'a'")) 
						{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_cbs^"+strOrgSelect+"^and inward_proptype='"+proposal+"'^1^"+strCategory+"^"+name);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_cbs^"+strOrgSelect+"^ ^1^"+strCategory+"^"+name);
						}
					}
				}  
				else if(strOrglevel.equals("D")||strOrglevel.equals("C"))
				{
					String strInwardCreated="";
					if(strOrglevel.equals("C"))
						strInwardCreated="5";
					else if(strOrglevel.equals("D") && Helper.correctNull((String)hshValues.get("strRLPFUser")).equalsIgnoreCase("012"))
						strInwardCreated="6";
					else if(strOrglevel.equals("D"))
						strInwardCreated="3";
					if(strOrglevel.equals("C"))
					strOrgSelect=strOrgSelect.substring(0,3);
					else
					strOrgSelect=strOrgSelect.substring(0,4);
					if(radiobutton.equalsIgnoreCase("name")){
						if(strCategory.equals("'c'") || strCategory.equals("'a'")){
							strQuery=SQLParser.getSqlQuery("sel_inwardlist^"+strOrgSelect+"^"+name+"^ and inward_proptype='"+proposal+"'^"+strInwardCreated+"^"+strCategory+"^"+strCBSid);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist^"+strOrgSelect+"^"+name+"^ ^"+strInwardCreated+"^"+strCategory+"^"+strCBSid);
						}
					}else if(radiobutton.equalsIgnoreCase("inward")){
						if(strCategory.equals("'c'") || strCategory.equals("'a'")) {
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_srchno^"+strOrgSelect+"^"+name+"^  and inward_proptype='"+proposal+"'^"+strInwardCreated+"^"+strCategory+"^"+strCBSid);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_srchno^"+strOrgSelect+"^"+name+"^ ^"+strInwardCreated+"^"+strCategory+"^"+strCBSid);
						}
					}else if(radiobutton.equalsIgnoreCase("cbscustid")){
						if(strCategory.equals("'c'") || strCategory.equals("'a'")) {
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_cbs^"+strOrgSelect+"^and inward_proptype='"+proposal+"'^"+strInwardCreated+"^"+strCategory+"^"+name);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_inwardlist_cbs^"+strOrgSelect+"^ ^"+strInwardCreated+"^"+strCategory+"^"+name);
						}
					}
				}
				rs = DBUtils.executeQuery(strQuery);
				if(strCusprofile.equalsIgnoreCase("CUSPROFILE"))
				{
					while(rs.next()){
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("inward_no")));//0
						arrCol.add(Helper.correctNull((String)rs.getString("inward_custname")));//1
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_ADD1")));//2
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_ADD2")));//3
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_CITY")));//4
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_STATE")));//5
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_ZIPCODE")));//6
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_PHONE")));//7
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_MOBILE")));//8
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_EMAIL")));//9
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_DOB")));//10
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_PANTAN")));//11
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_PASSPORTNUMBER")));//12
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_VOTERID")));//13
						arrCol.add(Helper.correctNull((String)rs.getString("INWARD_GENDER")));//14
						arrCol.add(Helper.correctNull((String)rs.getString("city_name")));//15
						arrCol.add(Helper.correctNull((String)rs.getString("state_name")));//16
						arrValue.add(arrCol);
					}
				}
				else{
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("inward_no")));//0
						arrCol.add(correctNull(rs.getString("inward_custname")));//1
						arrCol.add(correctNull(rs.getString("inward_docreceived")));//2
						arrCol.add(correctNull(rs.getString("inward_appliedon")));//3
						arrCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt")))+
								Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt")))+
								Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt")))));//4
						arrCol.add(correctNull(rs.getString("inward_govtspons")));//5
						arrCol.add(correctNull(rs.getString("inward_schmetype")));//6
						arrCol.add(correctNull(rs.getString("inward_subsdtype")));//7
						arrCol.add(correctNull(rs.getString("inward_otheragency")));//8
						arrCol.add(correctNull(rs.getString("inward_subsamount")));//9
						arrCol.add(correctNull(rs.getString("inward_sponagency")));//10
						arrCol.add(correctNull(rs.getString("inward_bankscheme")));//11
						if(!correctNull(rs.getString("inward_nsdlrefno")).equalsIgnoreCase(""))
							arrCol.add("Y");
						else
							arrCol.add("N");
						arrCol.add(correctNull(rs.getString("inward_nsdlrefno")));//13
						arrCol.add(correctNull(rs.getString("inward_docreceivedon")));//14
						arrCol.add(correctNull(rs.getString("bankScheme")));//15
						arrCol.add(correctNull(rs.getString("INWARD_CREATEDON")));//16
						arrValue.add(arrCol);
					}	
				}
				}
			}
			
			hshRecord.put("arrCust",arrValue);
			hshRecord.put("Category",strCategory);
			hshRecord.put("Cusprofile",strCusprofile);
			hshRecord.put("strCBSid",strCBSid);
			hshRecord.put("reqpagefrom",Helper.correctNull((String)hshValues.get("reqpagefrom")));
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardnoSearchList ::  "+ce.toString());
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
	
	public HashMap getInwardnoList(HashMap hshValues)
	{
		ResultSet rs = null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		
		try
		{
			String name=correctNull((String)hshValues.get("txt_value"));
			String val=correctNull((String)hshValues.get("hidvalue"));
			String strorgscode=correctNull((String)hshValues.get("strOrgShortCode"));
			if(val.equals("name"))
			{
				rs = DBUtils.executeLAPSQuery("sel_acknamelist^"+name+"^"+strorgscode);
			}
			else if(val.equals("no"))
			{
				rs = DBUtils.executeLAPSQuery("sel_acknolist^"+name+"^"+strorgscode);
			}
	       	while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("inward_no")));//0
				arrCol.add(correctNull(rs.getString("inward_createdon")));//1
				arrCol.add(correctNull(rs.getString("inward_appliedon")));//2
				arrCol.add(correctNull(rs.getString("inward_custname")));//3
				arrCol.add(correctNull(rs.getString("inward_add1")));//4
				arrCol.add(correctNull(rs.getString("inward_add2")));//5
				arrCol.add(correctNull(rs.getString("inward_city")));//6
				arrCol.add(correctNull(rs.getString("inward_state")));//7
				arrCol.add(correctNull(rs.getString("inward_zipcode")));//8
				arrCol.add(correctNull(rs.getString("inward_phone")));//9
				arrCol.add(correctNull(rs.getString("inward_mobile")));//10
				arrCol.add(correctNull(rs.getString("inward_email")));//11
				arrCol.add(correctNull(rs.getString("inward_dob")));//12
				arrCol.add(correctNull(rs.getString("inward_pantan")));//13
				arrCol.add(correctNull(rs.getString("inward_purpose")));//14
				arrCol.add(correctNull(rs.getString("inward_scheme")));//15
				arrCol.add(correctNull(rs.getString("inward_termloanamt")));//16
				arrCol.add(correctNull(rs.getString("inward_wcloanamt")));//17
				arrCol.add(correctNull(rs.getString("inward_nonwcloanamt")));//18
				arrCol.add(correctNull(rs.getString("inward_ADDITIONALDETAILS")));//19
				arrCol.add(correctNull(rs.getString("inward_docreceivedon")));//20
				arrCol.add(correctNull(rs.getString("inward_docreceived")));//21
				arrCol.add(correctNull(rs.getString("inward_applnprocessat")));//22
				arrCol.add(correctNull(rs.getString("inward_sector")));//23
				arrCol.add(correctNull(rs.getString("city_name")));//24
				arrCol.add(correctNull(rs.getString("state_name")));//25
				arrCol.add(correctNull(rs.getString("inward_appatached")));//26
				arrCol.add(correctNull(rs.getString("inward_brstatus")));//27
				arrCol.add(correctNull(rs.getString("inward_borrowertype")));//28
				arrCol.add(correctNull(rs.getString("inward_cbscustid")));//29
				arrCol.add(correctNull(rs.getString("inward_orgscode")));//30
				arrCol.add(correctNull(rs.getString("org_name")));//31
				arrCol.add(correctNull(rs.getString("inward_appliedfor")));//32
				arrValue.add(arrCol);
			}	
	       	hshValues.put("arrCust",arrValue);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardnoList ::  "+ce.toString());
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
		return hshValues;
	}
	
	public HashMap checkBranchworks(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrMessages=new ArrayList();
		String strInwardno="";
		String strQuery="";
		String strsector="";
		String strappliedfor="";
		String strproposal="";
		
		try {
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strsector=correctNull((String)hshValues.get("sector"));
			strappliedfor=correctNull((String)hshValues.get("appliedfor"));
			strproposal=correctNull((String)hshValues.get("proposal"));
			
			if(strsector.equalsIgnoreCase("Corporate"))
			{
				/*********************************************
				 * For checking the data available in the Presanction report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				if(strproposal.equals("C") ) //For avoiding Adhoc  short term, short term review Extension proposal
				{	
					strQuery=SQLParser.getSqlQuery("sel_comInspectionbyinwardno^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						arrMessages.add("Presanction Inspection Report Not Prepared");
					}
				}
				/*********************************************
				 * For checking the data available in the Due Diligence report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
			
				if(strproposal.equals("C")) //For avoiding Adhoc  short term, short term review Extension proposal
				{	
					strQuery=SQLParser.getSqlQuery("sel_duediligencecertificatebyinwardno^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						arrMessages.add("Due Diligence Not Prepared");
					}
				}
			}
			else if(strsector.equalsIgnoreCase("Tertiary"))
			{
				/*********************************************
				 * For checking the data available in the Presanction report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("selops_inspectionreportbyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Presanction Inspection Report Not Prepared");
				}
				
				strQuery=SQLParser.getSqlQuery("selcreditreportnames^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Credit Report Not Prepared");
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("selcrtotalmeansbyinwardno^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						arrMessages.add("Credit Report Not Prepared");
					}
				}
				
			}
			else if(strsector.equalsIgnoreCase("Retail"))
			{
				String flagsalary="Y",flagother="Y";
				/*********************************************
				 * For checking the data available in the Presanction report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("selpreinspectionvisitbyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Inspection Report Not Prepared");
				}
				

				strQuery=SQLParser.getSqlQuery("selcreditreportnames^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Credit Report Not Prepared");
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("selcrtotalmeansbyinwardno^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						arrMessages.add("Credit Report Not Prepared");
					}
				}
				
				strQuery=SQLParser.getSqlQuery("selbrrecmd^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Recommendations Not Given");
				}
				/*********************************************
				 * For checking the data available in the Due Diligence report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("selduediligencebyinward^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					flagsalary="N";
				}
				
				strQuery=SQLParser.getSqlQuery("sel_duediligencecertificatebyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					//arrMessages.add("Due Diligence Certificate Not Prepared");
					flagother="N";
				}
				if((flagsalary.equalsIgnoreCase("N")) && flagother.equalsIgnoreCase("N"))
				{
					arrMessages.add("Due Diligence Certificate Not Prepared");
				}
			}
			else if(strsector.equalsIgnoreCase("Agricultue"))
			{
				/*********************************************
				 * For checking the data available in the Presanction report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("sel_presanctionbyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Presanction Inspection Report Not Prepared");
				}
				
				/*********************************************
				 * For checking the data available in the Due Diligence report is 
				 * prepared or not prepared, if not prepared then the message to 
				 * be shown to user and ask to prepare it.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("selagrduediligencereportbyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Due Diligence Report Not Prepared");
				}
			}
			
			/*********************************************
			 * For checking the data available in the Credit report is 
			 * prepared or not prepared, if not prepared then the message to 
			 * be shown to user and ask to prepare it.
			 ************************************/
			if(strproposal.equals("C")) //For avoiding Adhoc proposal
			{	
				strQuery=SQLParser.getSqlQuery("selcreditreportnames^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Credit Report Not Prepared");
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("selcrtotalmeansbyinwardno^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
					if(!rs.next())
					{
						arrMessages.add("Credit Report Not Prepared");
					}
				}
			}
			/************************************************
			 * This is for New applications 
			 * 
			 ****************************************************/
			//if(strappliedfor.equalsIgnoreCase("N"))
			{
				/*********************************************
				 * For checking the data available in the Recommendations for Facility 
				 * if not prepared then the message to be shown.
				 ************************************/
				strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^0");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Recommendations for Facility not given");
				}
				/*********************************************************************
				 * For checking the data available in the Recommendations for Security i
				 * f not prepared then the message to be shown.
				 **********************************************************************/
				strQuery=SQLParser.getSqlQuery("selbrrecmdsecurity^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Security Details not given");
				}
			}
			
			strQuery=SQLParser.getSqlQuery("selbrrecmd^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			if(!rs.next())
			{
				arrMessages.add("Recommendations not given");
			}
			/************************************************
			 * This is for Renewal applications 
			 * 
			 ****************************************************/
			/*else if(strappliedfor.equalsIgnoreCase("R"))
			{
				/*********************************************
				 * For checking the data available in the Recommendations for Account Operational 
				 * if not prepared then the message to be shown.
				 ************************************/
				/*strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyinwardno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Account Operational Details not given");
				}
				/*********************************************************************
				 * For checking the data available in the Recommendations for Business Operations
				 * if not prepared then the message to be shown.
				 **********************************************************************/
				/*	strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno^"+strInwardno+"^"+"BP");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Business Operations Details not given");
				}
				/*********************************************************************
				 * For checking the data available in the Recommendations for Adverse Features
				 * if not prepared then the message to be shown.
				 **********************************************************************//*
				strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno^"+strInwardno+"^"+"AF");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Adverse Features Details not given");
				}
				*//*********************************************************************
				 * For checking the data available in the Recommendations for Defaults in Installments
				 * if not prepared then the message to be shown.
				 **********************************************************************//*
				strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno^"+strInwardno+"^"+"DI");
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Defaults in Installments Details not given");
				}*/
				
				/*********************************************************************
				 * For checking the data available in the Recommendations for Comments
				 * if not prepared then the message to be shown.
				 **********************************************************************/
				/*strQuery=SQLParser.getSqlQuery("sel_brrecmdcommentsbyinwarddno^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					arrMessages.add("Comments not given");
				}
			}*/
				
			hshRecord=new HashMap();
			if(arrMessages.size()>0)
			{
				hshRecord.put("Message",arrMessages);
				hshRecord.put("Status","FAILED");
			}
			else
			{
				hshRecord.put("Status","SUCCESS");
				hshRecord.put("inwardno",strInwardno);
			}
		}
		catch(Exception Ex)
		{
			throw new EJBException("Error in checkBranchWorks :: "+Ex.toString());
		}
		finally
		{
			try {
				if(rs!=null)rs.close();
			}
			catch(Exception Ex)
			{
				throw new EJBException("Error in Closing Connection in checkBranchWorks :: "+Ex.toString());
			}
		}
		return hshRecord;
	}
	
	public HashMap ActionInward(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshQuery= new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		String strAction="";
		int intUpdatesize=0;
		String strInwardno="";
		String strQuery="";
		String strAppno="";
		String strExp="$";
		String strSector="";
		String strFromuser="";
		String strSaralhead="";
		String strOrghead="";
		ResultSet rs=null;
		try {
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strSector=correctNull((String)hshValues.get("sector"));
			strFromuser=correctNull((String)hshValues.get("strUserId"));
			
			strQuery = SQLParser.getSqlQuery("orgnamebyinward^"+strInwardno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSaralhead=correctNull(rs.getString("saralhead"));
				strOrghead=correctNull(rs.getString("orghead"));
			}
			if(strAction.equalsIgnoreCase("send"))
			{
				/****
				 * From Branch to SARAL
				 * For insert in the appinward table
				 * to store that the inward is complete in all respects
				 */
				if(correctNull((String)hshValues.get("strOrgLevel")).equals("A"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updinwardstatus");
					arrValues.add("P");
					arrValues.add(strInwardno);
				
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","inssaralmailbox");
					arrValues.add(strInwardno);
					arrValues.add(strFromuser);
					arrValues.add(strSaralhead);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else
				{
					/****
					 * From SARAL USER to SARAL HEAD
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					
					hshQuery.put("strQueryId","inwardasignuser");
					arrValues.add(correctNull((String)hshValues.get("hidmail_tousrid")));
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","inssaralmailbox");
					arrValues.add(strInwardno);
					arrValues.add(strFromuser);
					arrValues.add(correctNull((String)hshValues.get("hidmail_tousrid")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
			}
			else if(strAction.equalsIgnoreCase("accept"))
			{
				/*************************************************************
				 * Check whether application is created or not if not created 
				 * throw a alert to branch user and stop the activity, or else
				 * attach to the application by getting the appno
				 ***************************************************************/
				strQuery=SQLParser.getSqlQuery("selappnoinwardnowise^"+strInwardno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppno=correctNull(rs.getString("app_no"));
				}
				else
				{
					strExp = strExp + " Application not yet generated by SARAL, so you can't accept the reports";
					throw new Exception(strExp);
				}
				
				/****
				 * For updating the datas of the Recommendation
				 * with the inward number
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","updbrrecmdfacappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","updbrrecmdsecappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				//1
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upacctoperappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				//2
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upBusOperappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			    //3
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upbrrecmdcommappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
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
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				/****
				 * For updating the datas of the credit 
				 * with the inward number
				 */

				/****
				 * For updating the datas of the presanction 
				 * with the inward number
				 */
				if(strSector.equalsIgnoreCase("Corporate"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updpresanctioninwardwise");//Inspection Report
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligenceinwardwise");//Details of Property(ies) Offered as Security 
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomcreditlimitsoughtbyinward");//Credit Limit sought 
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligencecertificatebyinward");//Due Diligence Report 
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateauditobservationbyinward"); //for audit observation
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updaterocdetailsbyinward"); //for roc details
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strSector.equalsIgnoreCase("Tertiary"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updinspectionreportinwardwise");//Inspection Report
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateinspectionfacilityinwardwise");//Inspection Report
					arrValues.add(strAppno);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}				
				else if(strSector.equalsIgnoreCase("Retail"))
				{
					/****
					 *  To update Inspection report of retail the inward number
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updatepreinspectionvisitbyinward");//Inspection report
					arrValues.add(strAppno);
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strSector.equalsIgnoreCase("Agricultue"))
				{
					/****
					 *  To update Inspection report of Agricultue the inward number
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updagrpresanctionreportbyinwardno");//Inspection Report
					arrValues.add(strAppno);
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);
					
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
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);					
				}
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","inssaralmailbox");
				arrValues.add(strInwardno);
				arrValues.add(strFromuser);
				arrValues.add(strFromuser);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equalsIgnoreCase("reject"))
			{
				/****
				 * resend the data to the brach
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","updinwardstatus");
				arrValues.add("O");
				arrValues.add(strInwardno);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","inssaralmailbox");
				arrValues.add(strInwardno);
				arrValues.add(strFromuser);
				arrValues.add(strOrghead);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				if(strSector.equalsIgnoreCase("Corporate"))
				{
					/****
					 * For updating the datas of the presanction 
					 * with the inward number to make the appno so that
					 * the datas will be separated from the application
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updpresanctioninwardwise");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				
					/****
					 *  For updating the datas of the Credit 
					 * with the inward number to make the appno so that
					 * the datas will be separated from the application
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditinwardwise");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total Means for Corporate
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcredittotmeansbyinwardno");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total ASSETS for Corporate
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditassestsbyinwardno");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//1 due
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligenceinwardwise");					
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//2 due					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomcreditlimitsoughtbyinward");					
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//3due					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligencecertificatebyinward");					
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateauditobservationbyinward"); //for audit observation
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updaterocdetailsbyinward"); //for roc details
					arrValues.add(null);
					arrValues.add(strInwardno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
			    }
				else if(strSector.equalsIgnoreCase("Tertiary"))
				{
					//Inspection Report for Tertiary (1 st Table)
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updinspectionreportinwardwise");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Inspection Report for Tertiary (2nd Table)
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateinspectionfacilityinwardwise");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report for Tertiary 
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditinwardwise");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total Means for Tertiary
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcredittotmeansbyinwardno");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total ASSETS for Tertiary
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditassestsbyinwardno");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strSector.equalsIgnoreCase("Retail"))
				{
					/****
					 *  To update Inspection report of retail the inward number
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updatepreinspectionvisitbyinward");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/**
					 * To update Due Diligence report of retail the inward number -Due Diligence Report - Salaried 
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateduediligencereportinwardwise");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/**
					 * To update Due Diligence report of retail the inward number -Due Diligence Report - Others   
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligencecertificatebyinward");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/**
					 * To update Due Diligence report of retail the inward number -Credit Limit sought  
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomcreditlimitsoughtbyinward");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/**
					 * To update Due Diligence report of retail the inward number - Details of Property(ies) Offered as Security 
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcomduediligenceinwardwise");
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report for Retail 
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditinwardwise");					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total Means for Retail
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcredittotmeansbyinwardno");
					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//Credit Report Total ASSETS for Retail
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditassestsbyinwardno");
					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
				else if(strSector.equalsIgnoreCase("Agricultue"))
				{
					
					/****
					 *  To update Inspection report of Agricultue the inward number
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updagrpresanctionreportbyinwardno");//Inspection Report
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/****
					 *  To update Inspection report1 of Agricultue the inward number
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updagrpresanctionreport1byinwardno");//Inspection Report
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					
					
					/**
					 * To update Due Diligence report of Agricultue the inward number
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updateduediligencereportinwardwise");//Due Diligence
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/*
					 * Credit Report for Agricultue 
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditinwardwise");
					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/*
					 * Credit Report Total Means for Agricultue
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcredittotmeansbyinwardno");
					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					/*
					 * Credit Report Total ASSETS for Agricultue
					 */
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updcreditassestsbyinwardno");
					
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strInwardno);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
				
				/****

				 * For updating the datas of the Recommendation
				 * with the inward number
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","updbrrecmdfacappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","updbrrecmdsecappno");
				arrValues.add(strAppno);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
//				1
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upacctoperappno");
				arrValues.add(null);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				//2
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upBusOperappno");
				arrValues.add(null);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			    //3
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upbrrecmdcommappno");
				arrValues.add(null);
				arrValues.add(strInwardno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				
				/****
				 * For insert in the inwardworkflow table
				 * to store that the datas are sent to RO
				 * to make history
				 */
				/*hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);*/
				
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		//	if(strAction.equals("send"))
				hshRecord.put("status","DATASUCCESS");
		}
		catch(Exception Ex)
		{
			throw new EJBException("Error in ActionInward :: "+Ex.toString());
		}
		finally
		{
			try {
				if(rs!=null)rs.close();
			}
			catch(Exception Ex)
			{
				throw new EJBException("Error in Closing Connection in ActionInward :: "+Ex.toString());
			}
		}
	return hshRecord;
		
	}

	public void updatebrrecmdfacility(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strAction=(String)hshValues.get("hidAction");
		String strInwardno="";
		int intUpdateSize=0;
		
		String strSno="";
		String strFactype="";
		String strFacnature="";
		String strFacility="";
		String strlimitapplied="";
		String strPurpose="";
		String strlimitrecmd="";
		String strFacilitygroup="0";
		String strexistlimit="";
		String strQuery="";
		ResultSet rs = null,rs1 = null;
		StringBuilder sbolddata=new StringBuilder();
		
		try
		{
			
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strSno=correctNull((String)hshValues.get("hidsno"));
			strFactype=correctNull((String)hshValues.get("hidfactype"));
			
			//for old data--audi trial
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("Delete"))
			{
				//sel_ter_facility_audittrial
				strQuery = SQLParser.getSqlQuery("sel_ter_facility_audittrial^"+strInwardno+"^"+strSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Nature of facility = ");
					if(Helper.correctNull((String)rs.getString("BRRECMD_FACNATURE")).equalsIgnoreCase("1"))
					{
						strOldAudit.append("Contingent Limits");
					}
					else if(Helper.correctNull((String)rs.getString("BRRECMD_FACNATURE")).equalsIgnoreCase("2"))
					{
						strOldAudit.append("Working capital Limits");
					}
					else if(Helper.correctNull((String)rs.getString("BRRECMD_FACNATURE")).equalsIgnoreCase("3"))
					{
						strOldAudit.append("Term Loan/DPGL Limits");
					}
					strOldAudit.append("~Facility Type = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BRRECMD_FACTYPE")));
					strOldAudit.append("~Existing limits = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BRRECMD_LIMITEXIST")));
					strOldAudit.append("~Limits applied for = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BRRECMD_LIMITAPPLIED")));
					strOldAudit.append("~Purpose  = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BRRECMD_PURPOSE")));
					strOldAudit.append("~Limits Recommended = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("BRRECMD_LIMITRECMD")));
				}
			}
			//end
			if(strFactype.equals("sublimit"))
			{
				strFacnature=correctNull((String)hshValues.get("selsubnaturefac"));
				strFacility=correctNull((String)hshValues.get("txt_subfacility"));
				strlimitapplied=Helper.correctDouble((String)hshValues.get("txt_sublimitapplied"));
				strPurpose=correctNull((String)hshValues.get("txt_subpurpose"));
				strlimitrecmd=Helper.correctDouble((String)hshValues.get("txt_sublimitrecomd"));
				strFacilitygroup=correctNull((String)hshValues.get("hidfacgrp"));
				strexistlimit=correctNull((String)hshValues.get("txt_sublimitexist"));
			}
			else
			{
				strFacnature=correctNull((String)hshValues.get("selnaturefac"));
				strFacility=correctNull((String)hshValues.get("txt_facility"));
				strlimitapplied=Helper.correctDouble((String)hshValues.get("txt_limitapplied"));
				strPurpose=correctNull((String)hshValues.get("txt_purpose"));
				strlimitrecmd=Helper.correctDouble((String)hshValues.get("txt_limitrecomd"));
				strexistlimit=correctNull((String)hshValues.get("txt_limitexist"));
			}
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery.put("strQueryId","delbrrecmdfacility");
				arrValues.add(strInwardno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				
				hshQuery.put("strQueryId","insbrrecmdfacility");
				arrValues.add(strInwardno);
				arrValues.add(getMaxfacilitySecurityId("Facility",strInwardno));
				arrValues.add(strFacnature);
				arrValues.add(strFacility);
				arrValues.add(strlimitapplied);	
				arrValues.add(strPurpose);	
				arrValues.add(strlimitrecmd);
				arrValues.add("");
				arrValues.add(strFacilitygroup);
				arrValues.add(strexistlimit);
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","updbrrecmdfacility");				
				arrValues.add(strFacnature);
				arrValues.add(strFacility);
				arrValues.add(strlimitapplied);				
				arrValues.add(strPurpose);
				arrValues.add(strlimitrecmd);
				arrValues.add(strFacilitygroup);
				arrValues.add(strexistlimit);
				arrValues.add(strInwardno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
			}
			hshQueryValues.put("size",""+intUpdateSize);
			hshQueryValues.put(""+intUpdateSize,hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
			//for new values-----audit trial
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Insert")){
				strNewAudit.append("~Nature of facility = ");
				if(strFacnature.equalsIgnoreCase("1"))
				{
					strNewAudit.append("Contingent Limits");
				}
				else if(strFacnature.equalsIgnoreCase("2"))
				{
					strNewAudit.append("Working capital Limits");
				}
				else if(strFacnature.equalsIgnoreCase("3"))
				{
					strNewAudit.append("Term Loan/DPGL Limits");
				}
				strNewAudit.append("~Facility Type = ");
				strNewAudit.append(strFacility);
				strNewAudit.append("~Existing limits = ");
				strNewAudit.append(strexistlimit);
				strNewAudit.append("~Limits applied for = ");
				strNewAudit.append(strlimitapplied);
				strNewAudit.append("~Purpose  = ");
				strNewAudit.append(strPurpose);
				strNewAudit.append("~Limits Recommended = ");
				strNewAudit.append(strlimitrecmd);
			}
			AuditTrial.auditNewLog(hshValues,"351",strInwardno,strNewAudit.toString(),strOldAudit.toString());
			//end
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
	}
	private String getMaxfacilitySecurityId(String facsectype,String Inwardno)
	{
		String strSno="";
		ResultSet rs=null;
		try
		{
			if(facsectype.equals("Facility"))
			{
				rs=DBUtils.executeLAPSQuery("selmaxbrrecmdfacility^"+Inwardno);
				if(rs.next())
				{
					strSno = correctNull(rs.getString("srno"));
				}
			}
			else if(facsectype.equals("Security"))
			{
				rs=DBUtils.executeLAPSQuery("selmaxbrrecmdsecurity^"+Inwardno);
				if(rs.next())
				{
					strSno = correctNull(rs.getString("srno"));
				}
			}
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
		return strSno;
	}
	public void updatebrrecmdsecurity(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strsno ="";
		String strAction="";
		String strInwardno="";
		int intUpdatesize=0;
		ResultSet rs = null;
		try
		{
			strAction=(String)hshValues.get("hidAction");
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strsno=correctNull((String)hshValues.get("hidsno"));
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete"))
			{
				//sel_inward_security_audittrial
				String strQuery = SQLParser.getSqlQuery("sel_inward_security_audittrial^"+strInwardno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Type of Security =");
					if(Helper.correctNull((String)rs.getString("BRRECMD_SECTYPE")).equals("1")){
					strOldAudit.append("Primary");
					}else if(Helper.correctNull((String)rs.getString("BRRECMD_SECTYPE")).equals("2")){
					strOldAudit.append("Collateral");
					}
					strOldAudit.append("~Present Value =");
					strOldAudit.append(ApplicationParams.getCurrency()+ " "+Helper.correctNull((String)rs.getString("BRRECMD_SECVALUE")));
				}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId","delbrrecmdsecurity");
				arrValues.add(strInwardno);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				arrValues.add(strInwardno);
				arrValues.add(getMaxfacilitySecurityId("Security",strInwardno));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_presentval")));	
				arrValues.add(correctNull((String)hshValues.get("txt_secdesc")));
				arrValues.add("");
				
				hshQuery.put("strQueryId","insbrrecmdsecurity");
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_presentval")));				
				arrValues.add(correctNull((String)hshValues.get("txt_secdesc")));	
				arrValues.add(strInwardno);
				arrValues.add(strsno);
				
				hshQuery.put("strQueryId","updbrrecmdsecurity");	
				hshQuery.put("arrValues",arrValues);
						
			}
			hshQueryValues.put("size",""+intUpdatesize);
			hshQueryValues.put(""+intUpdatesize,hshQuery);				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
			
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Insert"))
			{
				strNewAudit.append("~Type of Security =");
			if(Helper.correctNull((String)hshValues.get("selsectype")).equals("1")){
				strNewAudit.append("Primary");
			}else if(Helper.correctNull((String)hshValues.get("selsectype")).equals("2")){
				strNewAudit.append("Collateral");
			}
			strNewAudit.append("~Present Value =");
			strNewAudit.append(ApplicationParams.getCurrency()+ " "+Helper.correctNull((String)hshValues.get("txt_presentval")));
			}
		
			AuditTrial.auditNewLog(hshValues, "342", strInwardno, strNewAudit.toString(), strOldAudit.toString());
					
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in updatebrrecmdsecurity :: "+e1.getMessage());
		}
	}
	
	public void updatebrrecmd(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strAction="";
		String strInwardno="";
		int intUpdatesize=0;
		try
		{
			strAction=(String)hshValues.get("hidAction");
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId","delbrrecmd");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);
				hshQueryValues.put(""+intUpdatesize,hshQuery);		
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId","delbrrecmd");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);
				hshQueryValues.put(""+intUpdatesize,hshQuery);		
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				arrValues.add(strInwardno);
				arrValues.add(correctNull((String)hshValues.get("txt_brrecomd")));
				arrValues.add(correctNull((String)hshValues.get("txt_major")));
				arrValues.add(correctNull((String)hshValues.get("txt_utilization")));
				arrValues.add(correctNull((String)hshValues.get("txt_reviewfrom")));
				arrValues.add(correctNull((String)hshValues.get("txt_reviewto")));
				
				hshQuery.put("strQueryId","insbrrecmd");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);
				hshQueryValues.put(""+intUpdatesize,hshQuery);		
			}
			
					
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
					
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in updatebrrecmd :: "+e1.getMessage());
		}
	}
	
	public HashMap getbrrecmdfacility(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strInwardno="";
		String strQuery="";
		String strAppno="";
		String strSaral="";
		String strtyp="";
		String strApplied="";
		try
		{
			strInwardno= correctNull((String)hshValues.get("inwardno"));	
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));
			strtyp=correctNull((String)hshValues.get("link"));
			
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^0");
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdfacbyappno^"+strAppno+"^0");
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("brrecmd_facnature")));//0
				arrCol.add(correctNull(rs.getString("brrecmd_factype")));//1
				arrCol.add(Helper.correctDouble(rs.getString("brrecmd_limitapplied")));//2
				arrCol.add(correctNull(rs.getString("brrecmd_purpose")));//3
				arrCol.add(Helper.correctDouble(rs.getString("brrecmd_limitrecmd")));//4
				String strFacgrp=correctNull(rs.getString("brrecmd_facsno"));
				arrCol.add(strFacgrp);//5
				arrCol.add(correctNull(rs.getString("brrecmd_facgroup")));//6
				arrCol.add(correctNull(rs.getString("brrecmd_limitexist")));//7
				arrRow.add(arrCol);
				
				strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^"+strFacgrp);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("brrecmd_facnature")));//0
					arrCol.add(correctNull(rs1.getString("brrecmd_factype")));//1
					arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitapplied")));//2
					arrCol.add(correctNull(rs1.getString("brrecmd_purpose")));//3
					arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitrecmd")));//4
					arrCol.add(correctNull(rs1.getString("brrecmd_facsno")));//5
					arrCol.add(correctNull(rs1.getString("brrecmd_facgroup")));//6
					arrCol.add(correctNull(rs1.getString("brrecmd_limitexist")));//7
					arrRow.add(arrCol);
				}
				
				
			}
			
			hshRecord.put("arrRow",arrRow);
			
			if(strtyp.equals("ADC")||strtyp.equals("STL")||strtyp.equals("SRE"))
			{
			strQuery=SQLParser.getSqlQuery("com_selectinwardcusttype^"+strAppno);			
			rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strApplied=correctNull(rs.getString("inward_borrowertype"));
				}
				hshRecord.put("appliedfor",strApplied);
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
		return hshRecord;
	}
	public HashMap getbrrecmdsecurity(HashMap hshValues)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strInwardno="";
		String strSaral="";
		String strAppno="";
		String strQuery="";
		try
		{
			strInwardno= correctNull((String)hshValues.get("inwardno"));		
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdsecurity^"+strInwardno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdsecbyappno^"+strAppno);
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("brrecmd_sectype")));//0
				arrCol.add(""+rs.getDouble("brrecmd_secvalue"));//1
				arrCol.add(correctNull(rs.getString("brrecmd_secdesc")));//2
				arrCol.add(correctNull(rs.getString("brrecmd_secsno")));//3
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow",arrRow);
			
			
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getbrrecmdsecurity :: "+e1.getMessage());
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
	
	public HashMap getbrrecmd(HashMap hshValues)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strInwardno="";
		String strSaral="";
		String strAppno="";
		String strQuery="";
		try
		{
			strInwardno= correctNull((String)hshValues.get("inwardno"));		
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmd^"+strInwardno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdbyappno^"+strAppno);
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("brrecomdations",correctNull(rs.getString("brrecmd_recmdations")));
				hshRecord.put("brrecmdmajor",correctNull(rs.getString("brrecmd_major")));
				hshRecord.put("brrecmdutilization",correctNull(rs.getString("brrecmd_utilization")));
				hshRecord.put("brrecmdreviewfrom",correctNull(rs.getString("brrecmd_reviewfrom")));
				hshRecord.put("brrecmdreviewto",correctNull(rs.getString("brrecmd_reviewto")));
			}			
			
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getbrrecmd :: "+e1.getMessage());
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
	
	public HashMap getRecommendationPrint(HashMap hshValues)
	{
		HashMap hshRecord=null;
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strInwardno="";
		//String strAppno="";
		String strQuery="";
		
		ArrayList arrCLApplied=null;
		ArrayList arrWCApplied=null;
		ArrayList arrTLApplied=null;
		ArrayList arrCLRecmd=null;
		ArrayList arrWCRecmd=null;
		ArrayList arrTLRecmd=null;
		ArrayList arrRow=null;
		ArrayList arrCol=null;
		ArrayList arrCol1=null;
		try{
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			hshRecord=new HashMap();
			
			strQuery=SQLParser.getSqlQuery("orgnamebyinward^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("appname",correctNull(rs.getString("inward_custname")));
				hshRecord.put("branchname",correctNull(rs.getString("branchname")));
				hshRecord.put("regionalname",correctNull(rs.getString("regionalname")));
			}
			
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery("selbrrecmdsecurity^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("brrecmd_sectype")));
				arrCol.add(""+rs.getDouble("brrecmd_secvalue"));
				arrCol.add(correctNull(rs.getString("brrecmd_secdesc")));
				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow",arrRow);
			
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			arrCLApplied=new ArrayList();
			arrCLRecmd=new ArrayList();
			arrTLApplied=new ArrayList();
			arrTLRecmd=new ArrayList();
			arrWCApplied=new ArrayList();
			arrWCRecmd=new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol1 = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("brrecmd_factype")));
				arrCol.add(Helper.correctDouble(rs.getString("brrecmd_limitapplied")));
				arrCol.add(correctNull(rs.getString("brrecmd_purpose")));
				arrCol.add(correctNull(rs.getString("brrecmd_facgroup")));
				arrCol.add(correctNull(rs.getString("brrecmd_facnature")));
				String strFacgrp=correctNull(rs.getString("brrecmd_facsno"));
				
				arrCol1.add(correctNull(rs.getString("brrecmd_factype")));
				arrCol1.add(Helper.correctDouble(rs.getString("brrecmd_limitrecmd")));
				arrCol1.add(correctNull(rs.getString("brrecmd_facgroup")));
				arrCol1.add(correctNull(rs.getString("brrecmd_facnature")));
			
				if(rs.getString("brrecmd_facnature").equals("1"))
				{
					arrCLApplied.add(arrCol);
					arrCLRecmd.add(arrCol1);
					
					strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^"+strFacgrp);
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrCol = new ArrayList();
						arrCol1 = new ArrayList();
						
						arrCol.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitapplied")));
						arrCol.add(correctNull(rs1.getString("brrecmd_purpose")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrCol1.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol1.add(Helper.correctDouble(rs1.getString("brrecmd_limitrecmd")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrCLApplied.add(arrCol);
						arrCLRecmd.add(arrCol1);
					}
				}
				if(rs.getString("brrecmd_facnature").equals("2"))
				{
					arrWCApplied.add(arrCol);
					arrWCRecmd.add(arrCol1);
					
					strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^"+strFacgrp);
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrCol = new ArrayList();
						arrCol1 = new ArrayList();
						
						arrCol.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitapplied")));
						arrCol.add(correctNull(rs1.getString("brrecmd_purpose")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrCol1.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol1.add(Helper.correctDouble(rs1.getString("brrecmd_limitrecmd")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrWCApplied.add(arrCol);
						arrWCRecmd.add(arrCol1);
					}
				}
				if(rs.getString("brrecmd_facnature").equals("3"))
				{
					arrTLApplied.add(arrCol);
					arrTLRecmd.add(arrCol1);
					
					strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^"+strFacgrp);
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					
					while(rs1.next())
					{
						arrCol = new ArrayList();
						arrCol1 = new ArrayList();
						
						arrCol.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitapplied")));
						arrCol.add(correctNull(rs1.getString("brrecmd_purpose")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrCol1.add(correctNull(rs1.getString("brrecmd_factype")));
						arrCol1.add(Helper.correctDouble(rs1.getString("brrecmd_limitrecmd")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facgroup")));
						arrCol1.add(correctNull(rs1.getString("brrecmd_facnature")));
						
						arrTLApplied.add(arrCol);
						arrTLRecmd.add(arrCol1);
					}
				}
			}
			
			hshRecord.put("arrCLApplied",arrCLApplied);
			hshRecord.put("arrCLRecmd",arrCLRecmd);
			hshRecord.put("arrWCApplied",arrWCApplied);
			hshRecord.put("arrWCRecmd",arrWCRecmd);
			hshRecord.put("arrTLApplied",arrTLApplied);
			hshRecord.put("arrTLRecmd",arrTLRecmd);
			
			strQuery=SQLParser.getSqlQuery("selbrrecmd^"+strInwardno);

			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("brrecomdations",correctNull(rs.getString("brrecmd_recmdations")));
			}	
			
			
		}catch(Exception Ex)
		{
			throw new EJBException("Error in getRecommendationPrint :: "+Ex.getMessage());
		}finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error closing the connection "+ex.getMessage());
			}
		}
		
		return hshRecord;
	}
	
	public HashMap getInwardremarks(HashMap hshValues)
	{

		String strQuery="";
		String strInwardno="";
		String strAction="";
		ResultSet rs=null;
		HashMap hshRecords=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		
		try
		{	
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strQuery = SQLParser.getSqlQuery("orgnamebyinward^"+strInwardno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecords.put("orghead",correctNull(rs.getString("orghead")));//0
				hshRecords.put("saralhead",correctNull(rs.getString("saralhead")));//1
			}
			if(rs!=null)
				rs=null;
			strQuery = SQLParser.getSqlQuery("sel_saralcomments^"+strInwardno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("SARALMAIL_INWARDNO")));//0
				arrCol.add(correctNull(rs.getString("SARALMAIL_COMMENTS")));//1
				arrCol.add(correctNull(rs.getString("SARALMAIL_FROMUSER")));//2
				arrCol.add(correctNull(rs.getString("SARALMAIL_DATE")));//3
				arrCol.add(correctNull(rs.getString("SARALMAIL_TOUSER")));//4
				arrCol.add(correctNull(rs.getString("fromuser")));//5
				arrCol.add(correctNull(rs.getString("touser")));//6
				arrCol.add(correctNull(rs.getString("sendersdesign")));//7
				arrCol.add(correctNull(rs.getString("receviersdesign")));//8
				arrRow.add(arrCol);
			}	
			hshRecords.put("arrRow",arrRow);
			hshRecords.put("strAction",strAction);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardremarks "+ce.toString());
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
		return hshRecords;
	}
	public void updateInwardremarks(HashMap hshValues)
	{

		HashMap hshQuery= new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		String strAction="";
		String strTouser="";
		try
		{
			
			strAction=correctNull((String)hshValues.get("hidAction"));
			strTouser=correctNull((String)hshValues.get("hidmail_tousrid"));
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_saralcomments");
				
			arrValues.add(correctNull((String)hshValues.get("inwardno")));
			arrValues.add(correctNull((String)hshValues.get("comments")));
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			if(strTouser.equals(""))
			{
				if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				{
					arrValues.add(correctNull((String)hshValues.get("hidorghead")));
				}
				else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A"))
				{
					arrValues.add(correctNull((String)hshValues.get("hidsaralhead")));
				}
				else
				{
					arrValues.add("");	
				}
			}
			else
			{
				arrValues.add(strTouser);
			}
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
						
			hshQueryValues.put("size","1");
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateInwardremarks..."+e.toString());
		}
	}
	
	public HashMap getAccountOperationalDetails(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strInwardno="";
		String strQuery="";
		String strAppno="";
		String strSaral="";
		boolean recordflag=false;
		try
		{
			
			strInwardno= correctNull((String)hshValues.get("inwardno"));	
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyinwardno^"+strInwardno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyappno^"+strAppno);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("accoprationalappno")));//0
				arrCol.add(correctNull(rs.getString("accoprationalslno")));//1
				arrCol.add(correctNull(rs.getString("accoprationalinwardno")));//2
				
				arrCol.add(correctNull(rs.getString("accoprationalfacility")));//3
				arrCol.add(Helper.correctDouble(rs.getString("accoprationallimit")));//4
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalOutStanding")));//5
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalsecurity")));//6
				
				arrCol.add(Helper.correctDouble(rs.getString("accoprationaldrawingpower")));//7
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalmaxavailment")));//8
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalminavailment")));//9
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalturnoverdebit")));//10
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalturnovercredit")));//11
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalavgutilization")));//12
				
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalamtcommission")));//13
				arrCol.add(Helper.correctDouble(rs.getString("accoprationaloverdues")));//14
				
				arrCol.add(correctNull(rs.getString("accoprationalcbsno")));//15
				hshRecord.put("accoprationalasondate",correctNull(rs.getString("accoprationalasondate")));//16
				hshRecord.put("accntoper_fromdate",correctNull(rs.getString("accntoper_fromdate")));//17
				hshRecord.put("accntoper_todate",correctNull(rs.getString("accntoper_todate")));//18
				arrRow.add(arrCol);
				recordflag=true;
			}			
			hshRecord.put("arrRow",arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getAccountOperationalDetails"+e.getMessage());
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
	
	public void updateAccountOperationalDetails(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strAction=(String)hshValues.get("hidAction");
		String strInwardno="";
		String strSno="";
		String strSaral="";
		String strappno="";
		int intUpdateSize=0;
		ResultSet rs=null;
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strSaral = correctNull((String)hshValues.get("hidsaral"));	
			strappno =  correctNull((String)hshValues.get("appno"));
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyinwardno_sno^"+strInwardno+"^"+correctNull((String)hshValues.get("hidsno")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("As on =").append(correctNull(rs.getString("accoprationalasondate")))
					.append(" ~Facility=").append(correctNull(rs.getString("accoprationalfacility")))
					.append(" ~CBS AccountNo =").append(correctNull(rs.getString("accoprationalcbsno")))
					.append(" ~Limit =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationallimit")))))
					.append(" ~Outstanding =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalOutStanding")))))
					.append(" ~Total Value of Security =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalsecurity")))))
					.append(" ~Drawing Power =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationaldrawingpower")))))
					.append(" ~Present Overdues/ Excess =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationaloverdues")))))
					.append(" ~From Date =").append(correctNull(rs.getString("accntoper_fromdate")))
					.append(" ~To Date =").append(correctNull(rs.getString("accntoper_todate")))
					.append(" ~Maximum Availment=").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalmaxavailment")))))
					.append(" ~Minimum Availment =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalminavailment")))))
					.append(" ~Turnover Debit =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalturnoverdebit")))))
					.append(" ~Turnover Credit =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalturnovercredit")))))
					.append(" ~Average Utilization =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalavgutilization")))))
					.append(" ~Amount of Income/ Commission =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalamtcommission")))));
				}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","del_accountoprationalbyinwardno");
					arrValues.add(strInwardno);
				}
				else
				{
					hshQuery.put("strQueryId","del_accountoprationalbyappno");
					arrValues.add(strappno);
				}
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdateSize);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				if(strSaral.equals("saral"))
				{
					rs=DBUtils.executeLAPSQuery("selmaxaccountoprationalbyinwardno^"+strInwardno);
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("selmaxaccountoprationalbyappno^"+strappno);
				}
					
					if(rs.next())
					{
						strSno = correctNull(rs.getString("srno"));
					}
				
				hshQuery.put("strQueryId","ins_accountoprational");
				
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strInwardno);
				
				arrValues.add(correctNull((String)hshValues.get("txt_factype")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstanding")));	
				arrValues.add(correctNull((String)hshValues.get("txt_stock")));	
				arrValues.add(correctNull((String)hshValues.get("txt_drawingpower")));
				arrValues.add(correctNull((String)hshValues.get("txt_maxavailment")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_minavailment")));
				arrValues.add(correctNull((String)hshValues.get("txt_turnoverdebit")));
				arrValues.add(correctNull((String)hshValues.get("txt_turnovercredit")));
				arrValues.add(correctNull((String)hshValues.get("txt_avgutil")));
				arrValues.add(correctNull((String)hshValues.get("txt_amtcommission")));
				arrValues.add(correctNull((String)hshValues.get("txt_overdue")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_cbsaccno")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdateSize);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","upd_accountoprationalbyinwardno");
				}
				else
				{
					hshQuery.put("strQueryId","upd_accountoprationalbyappno");
				}
				arrValues.add(correctNull((String)hshValues.get("txt_factype")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_outstanding")));	
				arrValues.add(correctNull((String)hshValues.get("txt_stock")));	
				arrValues.add(correctNull((String)hshValues.get("txt_drawingpower")));
				arrValues.add(correctNull((String)hshValues.get("txt_maxavailment")));
				
				arrValues.add(correctNull((String)hshValues.get("txt_minavailment")));
				arrValues.add(correctNull((String)hshValues.get("txt_turnoverdebit")));
				arrValues.add(correctNull((String)hshValues.get("txt_turnovercredit")));
				arrValues.add(correctNull((String)hshValues.get("txt_avgutil")));
				arrValues.add(correctNull((String)hshValues.get("txt_amtcommission")));
				arrValues.add(correctNull((String)hshValues.get("txt_overdue")));
				arrValues.add(correctNull((String)hshValues.get("txt_cbsaccno")));
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);
				}
				else
				{
					arrValues.add(strappno);
				}
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdateSize);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
			}
			
			if(!(strAction.equalsIgnoreCase("delete")))
			{
				intUpdateSize++;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","upd_accountoprationalasondate");
				}
				else
				{
					hshQuery.put("strQueryId","upd_accntopernalasonappno");
				}
				arrValues.add(correctNull((String)hshValues.get("txt_asondate")));
				arrValues.add(correctNull((String)hshValues.get("txt_fromdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_todate")));
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);
				}
				else
				{
					arrValues.add(strappno);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdateSize);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
			}
			
				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert")){
			sbAuditTrial
			.append("As on =").append(correctNull((String )hshValues.get("txt_asondate")))
			.append("~Facility=").append(correctNull((String )hshValues.get("txt_factype")))
			.append("~CBS AccountNo =").append(correctNull((String )hshValues.get("txt_cbsaccno")))
			.append("~Limit =").append(correctNull((String )hshValues.get("txt_limit")))
			.append("~Outstanding = ").append(correctNull((String )hshValues.get("txt_outstanding")))
			.append("~Total Value of Security =").append(correctNull((String )hshValues.get("txt_stock")))
			.append("~Drawing Power =").append(correctNull((String )hshValues.get("txt_drawingpower")))
			.append("~Present Overdues/ Excess =").append(correctNull((String )hshValues.get("txt_overdue")))
			.append(" ~From Date =").append(correctNull((String )hshValues.get("txt_fromdate")))
			.append(" ~To Date =").append(correctNull((String )hshValues.get("txt_todate")))
			.append("~Maximum Availment=").append(correctNull((String )hshValues.get("txt_maxavailment")))
			.append("~Minimum Availment =").append(correctNull((String )hshValues.get("txt_minavailment")))
			.append("~Turnover Debit =").append(correctNull((String )hshValues.get("txt_turnoverdebit")))
			.append("~Turnover Credit =").append(correctNull((String )hshValues.get("txt_turnovercredit")))
			.append("~Average Utilization =").append(correctNull((String )hshValues.get("txt_avgutil")))
			.append("~Amount of Income/ Commission =").append(correctNull((String )hshValues.get("txt_amtcommission")));
			}
			if(strSaral.equals("saral"))
			{
				strappno=strInwardno;
			}
			
			AuditTrial.auditNewLog(hshValues,"283",strappno,sbAuditTrial.toString(),sbolddata.toString());
					
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateAccountOperationalDetails" +e.getMessage());
		}
	}
	
	
	
	public HashMap getBusinessOperationsDetails(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strInwardno="";
		String strQuery="";
		String strAppno="";
		String strSaral="";
		String strbustype="",strslno="";
		boolean recordflag=false;
		try
		{
			
			strInwardno= correctNull((String)hshValues.get("inwardno"));	
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			strbustype= correctNull((String)hshValues.get("hidbustype"));
		
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno^"+strInwardno+"^"+strbustype);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyappno^"+strAppno+"^"+strbustype);
			}
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("businessoperationsappno")));//0
				arrCol.add(correctNull(rs.getString("businessoperationsslno")));//1
				arrCol.add(correctNull(rs.getString("businessoperationsinwardno")));//2
				arrCol.add(correctNull(rs.getString("businessoperations")));//3
				arrCol.add(Helper.correctNull(rs.getString("businessoperationsno")));//4
				arrCol.add(Helper.correctDouble(rs.getString("businessoperationsamt")));//5
				hshRecord.put("bussoprns_fromdate",correctNull(rs.getString("bussoprns_fromdate")));
				hshRecord.put("bussoprns_todate",correctNull(rs.getString("bussoprns_todate")));
				arrRow.add(arrCol);
				recordflag=true;
			}			
			hshRecord.put("arrRow",arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getBusinessOperationsDetails"+e.getMessage());
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
	
	public void updateBusinessOperationsDetails(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strAction="";
		String strInwardno="";
		String strSno="";
		String strSaral="";
		String strappno="";
		String strbustype="";
		int intUpdateSize=0;
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs=null;
		String strHiddenNo = "";
		try
		{
			strInwardno = correctNull((String)hshValues.get("inwardno"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strSaral = correctNull((String)hshValues.get("hidsaral"));	
			strappno =  correctNull((String)hshValues.get("appno"));
			strbustype= correctNull((String)hshValues.get("hidbustype"));
			strHiddenNo = correctNull((String)hshValues.get("hidsno"));
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno_at^"+strInwardno+"^"+strbustype+"^"+strHiddenNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("BP"))
					{
					sbolddata.append("~From Date  =").append(correctNull(rs.getString("bussoprns_fromdate")))
							 .append("~To Date  =").append(correctNull(rs.getString("bussoprns_todate")));	
					sbolddata.append("~Business Operations =").append(correctNull(rs.getString("businessoperations")));
					if(correctNull(rs.getString("businessoperations")).equalsIgnoreCase("Any Others"))
					{
						sbolddata.append("~Please Specify  =").append(correctNull((String)hshValues.get("txt_others")));
					}
					sbolddata.append("~Number  =").append(correctNull(rs.getString("businessoperationsno")))
					.append("~Amount  =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("businessoperationsamt")))));					
				}
					else if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("AF"))
					{
						sbolddata.append("~From Date  =").append(correctNull(rs.getString("bussoprns_fromdate")))
								 .append("~To Date  =").append(correctNull(rs.getString("bussoprns_todate")));
						sbolddata.append("~Business Operations =").append(correctNull(rs.getString("businessoperations")));
						if(correctNull(rs.getString("businessoperations")).equalsIgnoreCase("Any Others"))
						{
							sbolddata.append("~Please Specify  =").append(correctNull((String)hshValues.get("txt_others")));
						}
						sbolddata.append("~Number  =").append(correctNull(rs.getString("businessoperationsno")))
						.append("~Amount  =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("businessoperationsamt")))));		
					}
					else if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("DI"))
					{
						sbolddata.append("Particular =").append(correctNull(rs.getString("businessoperations")));
						sbolddata.append("~Number  =").append(correctNull(rs.getString("businessoperationsno")))
						.append("~Amount  =").append(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("businessoperationsamt")))));
					}
			}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","del_businessoperationsbyinwardno");
					arrValues.add(strInwardno);
					arrValues.add(strbustype);
					
				}
				else
				{
					hshQuery.put("strQueryId","del_businessoperationsbyappno");
					arrValues.add(strappno);
					arrValues.add(strbustype);
					
				}
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				if(strSaral.equals("saral"))
				{
					rs=DBUtils.executeLAPSQuery("selmaxbusinessoperations^"+strInwardno+"^"+strbustype);
					if(rs.next())
					{
						strSno = correctNull(rs.getString("srno"));
					}
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("selmaxbusinessoperationsbyappno^"+strappno+"^"+strbustype);
					if(rs.next())
					{
						strSno = correctNull(rs.getString("srno"));
					}
				}
				hshQuery.put("strQueryId","ins_businessoperations");
				
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strInwardno);
				if(correctNull((String)hshValues.get("busOperation")).equalsIgnoreCase("Any Others"))
				{
					arrValues.add(correctNull((String)hshValues.get("txt_others")));
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("busOperation")));
				}
				arrValues.add(correctNull((String)hshValues.get("txt_number")));
				arrValues.add(correctNull((String)hshValues.get("txt_amt")));	
				arrValues.add(correctNull((String)hshValues.get("hidbustype")));	
				hshQuery.put("arrValues",arrValues);
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","upd_businessoperationsbyinwardno");
				}
				else
				{
					hshQuery.put("strQueryId","upd_businessoperationsbyappno");
				}
				if(correctNull((String)hshValues.get("busOperation")).equalsIgnoreCase("Any Others"))
				{
					arrValues.add(correctNull((String)hshValues.get("txt_others")));
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("busOperation")));
				}
				arrValues.add(correctNull((String)hshValues.get("txt_number")));
				arrValues.add(correctNull((String)hshValues.get("txt_amt")));	
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);
				}
				else
				{
					arrValues.add(strappno);
				}
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				arrValues.add(correctNull((String)hshValues.get("hidbustype")));	
				hshQuery.put("arrValues",arrValues);
			}
			hshQueryValues.put("size",""+intUpdateSize);
			hshQueryValues.put(""+intUpdateSize,hshQuery);	
			
			if(!(strAction.equalsIgnoreCase("delete")))
			{
				intUpdateSize++;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","upd_bussopernsdatebyinwardno");
				}
				else
				{
					hshQuery.put("strQueryId","upd_bussopernsdatebyappno");
				}
				
				arrValues.add(correctNull((String)hshValues.get("txt_fromdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_todate")));
				arrValues.add(correctNull((String)hshValues.get("hidbustype")));
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);
				}
				else
				{
					arrValues.add(strappno);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdateSize);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			StringBuilder sbAuditTrial=new StringBuilder();
			
			if(strSaral.equals("saral"))
			{
				strappno=strInwardno;
			}
		
			if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("BP"))
			{
				if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert")){
				sbAuditTrial.append("~From Date  =").append(correctNull((String )hshValues.get("txt_fromdate")))
				            .append("~To Date  =").append(correctNull((String )hshValues.get("txt_todate")));
				sbAuditTrial.append("~Business Operations =").append(correctNull((String )hshValues.get("busOperation_text")));
				if(correctNull((String )hshValues.get("busOperation_text")).equalsIgnoreCase("Any Others"))
				{
					sbAuditTrial.append("~Please Specify  =").append(correctNull((String )hshValues.get("txt_others")));
				}
				sbAuditTrial.append("~Number  =").append(correctNull((String )hshValues.get("txt_number")))
				.append("~Amount  =").append(correctNull((String )hshValues.get("txt_amt")));
				}
				AuditTrial.auditNewLog(hshValues,"285",strappno,sbAuditTrial.toString(),sbolddata.toString());
			}
			else if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("AF"))
			{
				if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert")){
				sbAuditTrial.append("~From Date  =").append(correctNull((String )hshValues.get("txt_fromdate")))
							.append("~To Date  =").append(correctNull((String )hshValues.get("txt_todate")));
				sbAuditTrial.append("~Business Operations =").append(correctNull((String )hshValues.get("busOperation")));
				if(correctNull((String )hshValues.get("busOperation_text")).equalsIgnoreCase("Any Others"))
				{
					sbAuditTrial.append("~Please Specify  =").append(correctNull((String )hshValues.get("txt_others")));
				}
				sbAuditTrial.append("~Number  =").append(correctNull((String )hshValues.get("txt_number")))
				.append("~Amount  =").append(correctNull((String )hshValues.get("txt_amt")));
				}
				AuditTrial.auditNewLog(hshValues,"284",strappno,sbAuditTrial.toString(),sbolddata.toString());
			}
			else if(correctNull((String)hshValues.get("hidbustype")).equalsIgnoreCase("DI"))
			{
				if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert")){
				sbAuditTrial.append("Particular =").append(correctNull((String )hshValues.get("busOperation")))
				.append("~Number  =").append(correctNull((String )hshValues.get("txt_number")))
				.append("~Amount  =").append(correctNull((String )hshValues.get("txt_amt")));
				}
				AuditTrial.auditNewLog(hshValues,"286",strappno,sbAuditTrial.toString(),sbolddata.toString());
			}
			
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateBusinessOperationsDetails" +e.getMessage());
		}
	}
	
	
	public HashMap getRecdComments(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs = null;
		
		String strAppno="";
		String strQuery="";
		String strInwardno="";
		String strSaral="";
		
		try
		{
			strInwardno= correctNull((String)hshValues.get("inwardno"));	
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("sel_brrecmdcommentsbyinwarddno^"+strInwardno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_brrecmdcommentsbyappno^"+strAppno);
			}
			rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("brrecmdcommentsappno",correctNull((String)rs.getString("brrecmdcommentsappno")));
					hshResult.put("businessoperationsinwardno",correctNull((String)rs.getString("businessoperationsinwardno")));
					hshResult.put("brrecmdcommentsmajor",correctNull((String)rs.getString("brrecmdcommentsmajor")));
					hshResult.put("brrecmdcommentsutilization",correctNull((String)rs.getString("brrecmdcommentsutilization")));
					hshResult.put("brrecmdcommentsreviewfrom",correctNull((String)rs.getString("brrecmdcommentsreviewfrom")));
					hshResult.put("brrecmdcommentsreviewto",correctNull((String)rs.getString("brrecmdcommentsreviewto")));
					hshResult.put("brrecmdcommentrecommendation",correctNull((String)rs.getString("brrecmdcommentrecommendation")));
				}
		
				if(rs!=null)
					rs.close();
		
		}catch (Exception exp){
			throw new EJBException("Error in getRecdComments"+ exp.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getRecdComments "+ exp.toString()); 
			}
		}
		hshResult.put("appno",strAppno);
		return hshResult;
	}
	
	public void updateRecdComments(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		
		String strAppno="" ;
		String strAction = "";
		String strInwardno="";
		String strSaral="";
		try
		{
			strInwardno = correctNull((String)hshValues.get("inwardno"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno = correctNull((String)hshValues.get("appno"));	
			
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","del_brrecmdcommentsbyinwardno");
					arrValues.add(strInwardno);
				}
				else
				{
					hshQuery.put("strQueryId","del_brrecmdcommentsbyappno");
					arrValues.add(strAppno);
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_brrecmdcomments");
				arrValues.add("");
     			arrValues.add(strInwardno);
				arrValues.add(correctNull((String)hshValues.get("txt_major")));
				arrValues.add(correctNull((String)hshValues.get("txt_utilization")));
				arrValues.add(correctNull((String)hshValues.get("txt_reviewfrom")));
				arrValues.add(correctNull((String)hshValues.get("txt_reviewto")));
				arrValues.add(correctNull((String)hshValues.get("txt_recommendation")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				if(strSaral.equals("saral"))
				{
					hshQuery.put("strQueryId","del_brrecmdcommentsbyinwardno");
					arrValues.add(strInwardno);
				}
				else
				{
					hshQuery.put("strQueryId","del_brrecmdcommentsbyappno");
					arrValues.add(strAppno);
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}catch (Exception e)
		{
			throw new EJBException("Error in updateRecdComments " + e.getMessage());
		} 
	}
	
	public HashMap getRenewalLimitsRecommendationPrint(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null; 
		String strInwardno="";
		String strQuery="";
		String strSaral="";
		String strAppno="";
		ArrayList arrCol = null;
		ArrayList arrRow = null;
		String[] bustype={"BP","AF","DI"};
		try
		{
			strInwardno= correctNull((String)hshValues.get("inwardno"));
			strAppno= correctNull((String)hshValues.get("appno"));
			strSaral= correctNull((String)hshValues.get("hidsaral"));
			strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyinwardno^"+strInwardno);
			arrRow = new ArrayList();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("accoprationalappno")));//0
				arrCol.add(correctNull(rs.getString("accoprationalslno")));//1
				arrCol.add(correctNull(rs.getString("accoprationalinwardno")));//2
				
				arrCol.add(correctNull(rs.getString("accoprationalfacility")));//3
				arrCol.add(Helper.correctDouble(rs.getString("accoprationallimit")));//4
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalOutStanding")));//5
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalsecurity")));//6
				
				arrCol.add(Helper.correctDouble(rs.getString("accoprationaldrawingpower")));//7
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalmaxavailment")));//8
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalminavailment")));//9
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalturnoverdebit")));//10
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalturnovercredit")));//11
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalavgutilization")));//12
				
				arrCol.add(Helper.correctDouble(rs.getString("accoprationalamtcommission")));//13
				arrCol.add(Helper.correctDouble(rs.getString("accoprationaloverdues")));//14
				
				hshRecord.put("accoprationalasondate",correctNull(rs.getString("accoprationalasondate")));
				hshRecord.put("accoprationalfromdate",correctNull(rs.getString("accntoper_fromdate")));
				hshRecord.put("accoprationaltodate",correctNull(rs.getString("accntoper_todate")));
				arrRow.add(arrCol);
			}			
			hshRecord.put("OperationalDetails",arrRow);
			
			
			for (int i=0;i<3;i++)
			{
				strQuery=SQLParser.getSqlQuery("sel_businessoperationsbyinwardno^"+strInwardno+"^"+bustype[i]);
				rs=DBUtils.executeQuery(strQuery);
				arrRow = new ArrayList();
				while(rs.next())
				{
					
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("businessoperationsappno")));//0
					arrCol.add(correctNull(rs.getString("businessoperationsslno")));//1
					arrCol.add(correctNull(rs.getString("businessoperationsinwardno")));//2
					arrCol.add(correctNull(rs.getString("businessoperations")));//3
					arrCol.add(correctNull(rs.getString("businessoperationsno")));//4
					arrCol.add(correctNull(rs.getString("businessoperationsamt")));//5
					if("BP".equals(bustype[i]))
					{
						hshRecord.put("bussoprns_fromdate",correctNull(rs.getString("bussoprns_fromdate")));
						hshRecord.put("bussoprns_todate",correctNull(rs.getString("bussoprns_todate")));
					}
					else if("AF".equals(bustype[i]))
					{
						hshRecord.put("advfeatures_fromdate",correctNull(rs.getString("bussoprns_fromdate")));
						hshRecord.put("advfeatures_todate",correctNull(rs.getString("bussoprns_todate")));
					}	
					arrRow.add(arrCol);
				}
				if(bustype[i].equalsIgnoreCase("BP"))
				{
					hshRecord.put("BusinessOperation",arrRow);
				}
				else if(bustype[i].equalsIgnoreCase("AF"))
				{
					hshRecord.put("AdverseFeatures",arrRow);
				}
				else if(bustype[i].equalsIgnoreCase("DI"))
				{
					hshRecord.put("DefaultsInstallment",arrRow);
				}
			}
			
			
			
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmd^"+strInwardno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selbrrecmdbyappno^"+strAppno);
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("brrecomdations",correctNull(rs.getString("brrecmd_recmdations")));
				hshRecord.put("brrecmdmajor",correctNull(rs.getString("brrecmd_major")));
				hshRecord.put("brrecmdutilization",correctNull(rs.getString("brrecmd_utilization")));
				hshRecord.put("brrecmdreviewfrom",correctNull(rs.getString("brrecmd_reviewfrom")));
				hshRecord.put("brrecmdreviewto",correctNull(rs.getString("brrecmd_reviewto")));
			}
		
				if(rs!=null)
					rs.close();
		
				if(rs!=null)rs.close();
				/*if(strInwardno.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("selBranchCityName^"+strappno);
					
				}
				else
				{*/
					strQuery = SQLParser.getSqlQuery("selinwardreg^"+strInwardno);
				/*}*/
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("orgname",correctNull(rs.getString("org_name")));
					hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
					hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
					hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
					hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
					hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
				}
				
				
				 if(strSaral.equals("saral"))
					{
						strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^0");
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("selbrrecmdfacbyappno^"+strAppno+"^0");
					}
					rs=DBUtils.executeQuery(strQuery);
					arrRow = new ArrayList();
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("brrecmd_facnature")));//0
						arrCol.add(correctNull(rs.getString("brrecmd_factype")));//1
						arrCol.add(Helper.correctDouble(rs.getString("brrecmd_limitapplied")));//2
						arrCol.add(correctNull(rs.getString("brrecmd_purpose")));//3
						arrCol.add(Helper.correctDouble(rs.getString("brrecmd_limitrecmd")));//4
						String strFacgrp=correctNull(rs.getString("brrecmd_facsno"));
						arrCol.add(strFacgrp);//5
						arrCol.add(correctNull(rs.getString("brrecmd_facgroup")));//6
						arrCol.add(correctNull(rs.getString("brrecmd_limitexist")));//7
						arrRow.add(arrCol);
						
						strQuery=SQLParser.getSqlQuery("selbrrecmdfacility^"+strInwardno+"^"+strFacgrp);
						
						if(rs1!=null)
							rs1.close();
						
						rs1=DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							arrCol = new ArrayList();
							arrCol.add(correctNull(rs1.getString("brrecmd_facnature")));//0
							arrCol.add(correctNull(rs1.getString("brrecmd_factype")));//1
							arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitapplied")));//2
							arrCol.add(correctNull(rs1.getString("brrecmd_purpose")));//3
							arrCol.add(Helper.correctDouble(rs1.getString("brrecmd_limitrecmd")));//4
							arrCol.add(correctNull(rs1.getString("brrecmd_facsno")));//5
							arrCol.add(correctNull(rs1.getString("brrecmd_facgroup")));//6
							arrCol.add(correctNull(rs1.getString("brrecmd_limitexist")));//7
							arrRow.add(arrCol);
						}
						
						
					}			
					hshRecord.put("arrRow",arrRow);
		
		}
		catch(Exception Ex)
		{
			throw new EJBException("Error in getRenewalLimitsRecommendationPrint :: "+Ex.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ex)
			{
				throw new EJBException("Error closing the connection "+ex.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getHistorydata(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strInwardno="";
		String strQuery="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try{
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strQuery=SQLParser.getSqlQuery("getsaralmailbox^"+strInwardno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(correctNull(rs.getString("mail_fromuser")));
				arrCol.add(correctNull(rs.getString("mail_date")));
				arrCol.add(correctNull(rs.getString("mail_touser")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}catch(Exception ex)
		{
			throw new EJBException("Error in getHistorydata of Inwardregisterbean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing connection getHistorydata of Inwardregisterbean :: "+ex.toString());
			}
		}
		
		return hshRecord;
	}
	
	private void Deleterecordes(HashMap hsh)
	{
		
		ResultSet rs=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intUpdatesize = 0;
		String Inwardno="";
		String Sectors="";
		String oldSectors="";
		String Applied="";
		String oldApplied="";
		String processat="";
		String oldprocessat="";
		
		
		
		
		try
		{
			 Inwardno = Helper.correctNull((String)hsh.get("inwardno"));
			 Sectors = Helper.correctNull((String)hsh.get("hidtype"));
			 oldSectors = Helper.correctNull((String)hsh.get("hidoldtype"));
			 Applied = Helper.correctNull((String)hsh.get("selapplied"));
			 oldApplied = Helper.correctNull((String)hsh.get("hidoldapplied"));
			 processat = Helper.correctNull((String)hsh.get("selappcreation"));
			 oldprocessat = Helper.correctNull((String)hsh.get("hidoldappcreation"));
			
			/*****************************
			 * 
			 * This is for deleting records when the processing at is SARAL  
			 * 
			 * 
			 ********************************/
			
			if((processat.equals(oldprocessat)) && (oldprocessat.equals("2")))
			{
				/*****************************
				 * 
				 * This is for deleting records when the SECTOR is changed 
				 * 
				 * 
				 ********************************/
				
				if(!(Sectors.equalsIgnoreCase(oldSectors)))
				{
					if(oldSectors.equalsIgnoreCase("c")) //Croporate
					{
						/*
						 * Corp Inspection Report
						 * 
						 */
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_comInspectionbyinwardno");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Corp Due Dilgence
						 * 
						 */
						//1
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_duediligencecertificatebyinwardno");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
	     				//2
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_creditlimitsought");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						//3
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_comduediligence");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
					}
					else if(oldSectors.equalsIgnoreCase("t")) //Tery
					{
						/*
						 * Tery  Inspection Report
						 * 
						 */
						//1
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delops_inspectionreportbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						//2
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delops_inspectionfacilitybyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
					}
					else if(oldSectors.equalsIgnoreCase("a")) //Agri
					{
						/*
						 * Agri Inspection Report
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delpresanctionbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Agri Due Dilgence
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delduediligencereportbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
					} 
					else if(oldSectors.equalsIgnoreCase("p")) //Retail
					{
						/*
						 * 
						 * Retail Pre-Sanction
						 * 
						 */
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delpreinspectionvisitbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Retail Due Dilgence
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delduediligencebyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						
						//1
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_duediligencecertificatebyinwardno");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
	     				//2
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_creditlimitsought");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						//3
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_comduediligence");
						arrValues.add(Inwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
					
					hshQueryValues.put("size",""+intUpdatesize);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				/********************************************************
				 * 
				 * End of Sector
				 * 
				 *******************************************************/
				
				/********************************************************
				 * 
				 * This is for deleting records when the VALUE IN Applied for is changed
				 * 
				 * 
				 ***********************************************************/
				
				if(!(Applied.equalsIgnoreCase(oldApplied)))
				{
					hshQueryValues=new HashMap();
					intUpdatesize = 0;
					if(oldApplied.equalsIgnoreCase("R"))
					{
						/*
						 * Operational Details
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_accountoprational");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Business Details
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_businessoperations");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Comments
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","del_brrecmdcommentsbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
					}
					else if(oldApplied.equalsIgnoreCase("N"))
					{
						/*
						 * Facility Details
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delbrrecmdfacilitybyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						/*
						 * Security Details
						 * 
						 */
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delbrrecmdsecuritybyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
					}
					hshQueryValues.put("size",""+intUpdatesize);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			
			/********************************************************
			 * 
			 *  END 
			 * 
			 *******************************************************/
			
			/*****************************
			 * 
			 * This is for deleting the records all entries when the processed at is changed from
			 * SARAL TO BRANCH
			 * 
			 ********************************/
			
			else if(!(processat.equals(oldprocessat)) && (oldprocessat.equals("2")))
			{
				hshQueryValues=new HashMap();
				intUpdatesize = 0;
				
				//if(oldprocessat.equals("2"))
			//	{
					if(oldSectors.equalsIgnoreCase("c"))
					{
							/*
							 * Corp Inspection Report
							 * 
							 */
							
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_comInspectionbyinwardno");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							/*
							 * Corp Due Dilgence
							 * 
							 */
							//1
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_duediligencecertificatebyinwardno");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
		     				//2
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_creditlimitsought");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							//3
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_comduediligence");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					}
					else if(oldSectors.equalsIgnoreCase("t"))
					{
						/*
						 * Inspection 
						 * 
						 */
						//1
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delops_inspectionreportbyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						//2
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","delops_inspectionfacilitybyinwardno");
						arrValues.add(Inwardno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
					}
					else if(oldSectors.equalsIgnoreCase("p"))
					{
						/*
						 * Retail Due Dilgence
						 * 
						 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","delduediligencebyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							
							//1
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_duediligencecertificatebyinwardno");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
		     				//2
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_creditlimitsought");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							//3
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_comduediligence");
							arrValues.add(Inwardno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
					else if(oldSectors.equalsIgnoreCase("a"))
					{
							/*
							 * Agri Inspection Report
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","delpresanctionbyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							/*
							 * Agri Due Dilgence
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","delduediligencereportbyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
					/*
					 * Recommdation
					 * 
					 */
					if(oldApplied.equalsIgnoreCase("R"))
					{
							/*
							 * Operational Details
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_accountoprational");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							/*
							 * Business Details
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_businessoperations");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							/*
							 * Comments
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","del_brrecmdcommentsbyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
					else if(oldApplied.equalsIgnoreCase("N"))
					{
							/*
							 * Facility Details
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","delbrrecmdfacilitybyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
							
							/*
							 * Security Details
							 * 
							 */
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","delbrrecmdsecuritybyinwardno");
							arrValues.add(Inwardno);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
					
					/*
					 * Credit Report
					 * 
					 */
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","delcreditreportbyappno");
					arrValues.add(Inwardno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","delcreditassets");
					arrValues.add(Inwardno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","delcredittotmeans");
					arrValues.add(Inwardno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQueryValues.put("size",""+intUpdatesize);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				//}
			}
			/**
			 * 
			 * End of if
			 * 
			 */
			
			else if((processat.equals(oldprocessat)) && (oldprocessat.equals("1")))
			{
			/***************************************************
			 * 
			 * IS BLOCK IS FOR DELETEING THE RECORDS WHEN THE PROCESSAT IS AT BRANCH
			 * NO TABLES TO DELETE SINCE THEIR WILL BE NO ENTERIES IN THE TABLES
			 * 
			 * 
			 ****************************************************/	
			}
			
			else if(!(processat.equals(oldprocessat)) && (oldprocessat.equals("1")))
			{
				/***************************************************************
				 * 
				 * IS BLOCK IS FOR DELETEING THE RECORDS WHEN THE PROCESSAT IS BEING CHAGNED FROM BRANCH TO SARAL
				 * NO TABLES TO DELETE SINCE THEIR WILL BE NO ENTERIES IN THE TABLES
				 * 
				 ****************************************************************/
			}
			
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
	
	public HashMap  getInwardnoSearch(HashMap hshValues) 
	{			
		ResultSet rs = null;
		ResultSet rs1 = null,rs3=null;
		HashMap hshRecord =new HashMap();
		String areacheckval="",strQuery="",strQuery1="",strQuery2="";
		String area1="",area2="",area3="",area4="",area5="",glptotlevel="",absPosition="";
		String IsSaralhead="N";
		String ISorghead="N";
		String inward_assignusrid="",strCBSIDflag="";
		String inward_usrid="",strCategorytype="",str_statuscust="",strCusCBSStatus="",str_statuscompkyc="",str_statuscompincexp="";
		String strAppstatus="";
		try
		{
			strCBSIDflag="N";
			strCategorytype=correctNull((String)hshValues.get("hidCategoryType"));
			String orgSelCode = Helper.correctNull((String)hshValues.get("strOrgSelect"));
			String strUser = correctNull((String) hshValues.get("strUserId"));
			String name=correctNull((String)hshValues.get("search"));
			orgSelCode = orgSelCode+"%"; 
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));
		 	area1= correctNull((String)hshValues.get("area1"));
			area2= correctNull((String)hshValues.get("area2"));
			area3 = correctNull((String)hshValues.get("area3"));
			area4 = correctNull((String)hshValues.get("area4"));
			area5 = correctNull((String)hshValues.get("area5"));
			String val=correctNull((String)hshValues.get("hidvalue"));
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
			if(rs!=null)
				rs.close();
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			if(correctNull((String)hshValues.get("strOrgLevel")).equals("A"))
	 		{
				strQuery1=SQLParser.getSqlQuery("setorgselect^"+
	 					correctNull((String)hshValues.get("strOrgCode")));
				if(rs1!=null)
		 			 rs1.close();
				rs1 = DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					if(correctNull(rs1.getString("org_head")).equals(strUser))
					{
						ISorghead="Y";
					}
				}
	 		}
			else if(correctNull((String)hshValues.get("strOrgLevel")).equals("D"))
			{
				strQuery1=SQLParser.getSqlQuery("setorgselect^"+correctNull((String)hshValues.get("strOrgCode")));
				if(rs1!=null)
		 			 rs1.close();
				rs1 = DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{ 
					if(correctNull(rs1.getString("org_saralhead")).equals(strUser))
					{
						IsSaralhead="Y";
					}
				}
			}
			if(rs1!=null)
				rs1.close();
			if (!areacheckval.equals(""))
			{
				if(val.equals("name"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchbyname^"+areacheckval+"^"+name);
				}
				else if(val.equals("no"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchbyno^"+areacheckval+"^"+name);
				}
				else if(val.equals("CBSID"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchby_cbsid^"+name);
				}
			}
			else if(areacheckval.equals(""))
			{
				if(val.equals("name"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchbyname^"+orgSelCode+"^"+name);
				}
				else if(val.equals("no"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchbyno^"+orgSelCode+"^"+name);
				}
				else if(val.equals("CBSID"))
				{
					strQuery = SQLParser.getSqlQuery("inwardsearchby_cbsid^"+name);
				}
			}
			ArrayList arrval =  new ArrayList();
			ArrayList arrdata =  new ArrayList();
			rs = DBUtils.executeQuery(strQuery);
		    rs.last();
			int RowCount = rs.getRow();
			rs.beforeFirst();
			if(RowCount != 0)
			{
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			while(rs.next())
			{
				arrval =  new ArrayList();
				arrval.add(correctNull(rs.getString(1)));//0inward_no
				arrval.add(correctNull(rs.getString(2)));//1inward_custname
				arrval.add(correctNull(rs.getString(3)));//2sector
				arrval.add(correctNull(rs.getString(8)));//3org_name
				arrval.add(correctNull(rs.getString(5)));//4
				arrval.add(correctNull(rs.getString("INWARD_BORROWERTYPE")));//5
				arrval.add(correctNull(rs.getString(4)));//6inward_brstatus
				inward_assignusrid = correctNull(rs.getString(5));
				arrval.add(inward_assignusrid);//7inward_assignusrid
				arrval.add(correctNull(rs.getString(6)));//8inward_appatached
				arrval.add(correctNull(rs.getString(7)));//9inward_valuesin
				arrval.add(correctNull(rs.getString("inward_applnprocessat")));//10
				arrval.add(IsSaralhead);//11
				arrval.add(ISorghead);//12
				arrval.add(correctNull(rs.getString("org_scode")));//13
				inward_usrid = correctNull(rs.getString("inward_usrid"));
				arrval.add(inward_usrid);//14
				if(inward_assignusrid.equals(""))
				{
					arrval.add(correctNull(rs.getString("inward_assignusrname")));//15
				}
				else
				{
					arrval.add(correctNull(rs.getString("inward_usrname")));//15
				}
				arrval.add(correctNull(rs.getString("inward_applnprocessat")));//16
				arrval.add(correctNull(rs.getString("inward_appstatus")));//17
				
				if(rs1!=null)
		 			 rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selectappinwardno^"+correctNull(rs.getString(1)));
				if(rs1.next())
				{
					arrval.add(correctNull(rs1.getString("app_no")));//18
					
					if(Helper.correctNull((String)rs1.getString("app_delflag")).equalsIgnoreCase("Y"))
					{
						strAppstatus="Deleted";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("pr")&&
							Helper.correctNull((String)rs1.getString("app_autorej")).equalsIgnoreCase("Y"))
					{
						strAppstatus="Auto Rejected";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("pr"))
					{
						strAppstatus="Processed/Rejected";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("pa"))
					{
						strAppstatus="Processed/Approved";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("ca"))
					{
						strAppstatus="Closed/Approved";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("op"))
					{
						strAppstatus="Open/Pending";
					}
					else if(Helper.correctNull((String)rs1.getString("app_status")).equalsIgnoreCase("ol"))
					{
						strAppstatus="Open/Lodged";
					}
					
				}
				else
				{
					arrval.add("");//18
				}
				arrval.add(strAppstatus);//19
				strQuery = SQLParser.getSqlQuery("sel_inwardclphchk^"+correctNull(rs.getString(1)));
		 		rs3 = DBUtils.executeQuery(strQuery);
		 		if(rs3.next()){
		 			arrval.add(correctNull(rs3.getString("ORGLEVEL")));//20
		 		}else{
		 			arrval.add("");//20
		 		}
				arrdata.add(arrval);
			}
			
			hshRecord.put("arrval",arrdata);	
			hshRecord.put("strCBSIDflag",strCBSIDflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardnoSearch ::  "+ce.toString());
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
		return hshRecord;
	}
	
	
	public void updateCibilaccountInfo(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strAction=(String)hshValues.get("hidAction");
		String strInwardno="";
		int intUpdateSize=0;
		ResultSet rs=null;
		String strsId="";
		String strQuery = "",strHid_no="";
		try
		{
			strInwardno=correctNull((String)hshValues.get("inwardno"));
			strHid_no=correctNull((String)hshValues.get("hid_slno"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			StringBuilder strOldAudit =new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete"))
			{
				strQuery = SQLParser.getSqlQuery("sel_specific_cibilaccountinfo_audittrial^"+strInwardno+"^"+strHid_no);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAudit.append("Account No. / credit Card No.=");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ca_acc_creditcard_no")));
				}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strInwardno);
				arrValues.add(correctNull((String)hshValues.get("hid_slno")));
				
				hshQuery.put("strQueryId","del_cibilaccountinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				
				rs=DBUtils.executeLAPSQuery("selmax_cibilaccountinfo^" +strInwardno);
				if(rs.next())
				{
					strsId = correctNull((String)rs.getString("ca_slno"));
				}
				else
				{
					strsId = "1";
				}
				
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_cibilaccountinfo");
				arrValues.add(strInwardno);
				arrValues.add(correctNull((String)hshValues.get("acc_number")));
				arrValues.add(strsId);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_cibilaccountinfo");
				
				arrValues.add(correctNull((String)hshValues.get("acc_number")));
				arrValues.add(strInwardno);
				arrValues.add(correctNull((String)hshValues.get("hid_slno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Insert"))
			{
				strNewAudit.append("Account No. / credit Card No.=");
				strNewAudit.append(Helper.correctNull((String)hshValues.get("acc_number")));
				
			}
			AuditTrial.auditNewLog(hshValues, "341", strInwardno, strNewAudit.toString(), strOldAudit.toString());
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
	}
	
	
	public 	HashMap getDateCibilaccountInfo(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrCol=null;
		ArrayList arrValue = new ArrayList();
		String inwardno = correctNull((String) hshValues.get("inwardno"));
		
		try
			{
				strQuery = SQLParser.getSqlQuery("sel_cibilaccountinfo^"+inwardno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("ca_inwardno")));//0
					arrCol.add(correctNull((String)rs.getString("ca_acc_creditcard_no")));//1
					arrCol.add(correctNull((String)rs.getString("ca_slno")));//2
					arrValue.add(arrCol);
				}
				hshValues.put("arrCibilaccountInfo",arrValue);
			}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDateCibilaccountInfo "+ce.toString());
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
		
		return hshValues;
		
	}
	public HashMap getCibilReportData(HashMap hshValues) 
	{
		HashMap hshCreditData = new HashMap();
		HashMap hshBorrowerData = new HashMap();
		HashMap hshAddressData = new HashMap();
		String strQuery = "";
		ResultSet rs = null,rs1= null;
		String strInward_no = "";
		String strAddress = "";
		try
		{
			ArrayList arrCustAddCol = new ArrayList();
			ArrayList arrCustAddRow = new ArrayList();
			strInward_no = Helper.correctNull((String)hshValues.get("InwardNo"));
			//to get the Borrower details
			strQuery = SQLParser.getSqlQuery("sel_borrowerdet_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				hshBorrowerData.put("app_name", Helper.correctNull((String)rs.getString("pn_consname1"))+" "+
						Helper.correctNull((String)rs.getString("pn_consname2"))+" "+
						Helper.correctNull((String)rs.getString("pn_consname3"))+" "+
						Helper.correctNull((String)rs.getString("pn_consname4"))+" "+
						Helper.correctNull((String)rs.getString("pn_consname5")));
				hshBorrowerData.put("app_dob", Helper.correctNull((String)rs.getString("pn_dob")));
				hshBorrowerData.put("app_gender", Helper.correctNull((String)rs.getString("pn_gender")));
				hshBorrowerData.put("app_panno", Helper.correctNull((String)rs.getString("pn_panno")));
				hshBorrowerData.put("app_passportno", Helper.correctNull((String)rs.getString("pn_passportno")));
				hshBorrowerData.put("app_voterid", Helper.correctNull((String)rs.getString("pn_voterid")));
				hshBorrowerData.put("app_additionalid", Helper.correctNull((String)rs.getString("pn_additionalid")));
				hshBorrowerData.put("app_telephoneno", Helper.correctNull((String)rs.getString("pn_telephone")));
				hshBorrowerData.put("app_responseno", Helper.correctNull((String)rs.getString("pn_response_sno")));
			}
			hshCreditData.put("hshBorrowerData", hshBorrowerData);
			if(rs!=null){
				rs.close();
			}
			
			//to get the address of the borrower
			strQuery = SQLParser.getSqlQuery("sel_address_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				arrCustAddCol = new ArrayList();
				if(!Helper.correctNull((String)rs.getString("pa_addr1")).equalsIgnoreCase(""))
				{
					strAddress = Helper.correctNull((String)rs.getString("pa_addr1"));
				}
				if(!Helper.correctNull((String)rs.getString("pa_addr2")).equalsIgnoreCase(""))
				{
					strAddress = strAddress+ " , " +Helper.correctNull((String)rs.getString("pa_addr2"));
				}
				if(!Helper.correctNull((String)rs.getString("pa_addr2")).equalsIgnoreCase(""))
				{
					strAddress = strAddress+ " , " +Helper.correctNull((String)rs.getString("pa_addr2"));
				}
				if(!Helper.correctNull((String)rs.getString("pa_addr3")).equalsIgnoreCase(""))
				{
					strAddress = strAddress+ " , " +Helper.correctNull((String)rs.getString("pa_addr3"));
				}
				if(!Helper.correctNull((String)rs.getString("pa_addr4")).equalsIgnoreCase(""))
				{
					strAddress = strAddress+ " , " +Helper.correctNull((String)rs.getString("pa_addr4"));
				}
				if(!Helper.correctNull((String)rs.getString("pa_addr5")).equalsIgnoreCase(""))
				{
					strAddress = strAddress+ " , " +Helper.correctNull((String)rs.getString("pa_addr5"));
				}
				arrCustAddCol.add(strAddress);
				strQuery = SQLParser.getSqlQuery("sel_stateflex_name^"+Helper.correctNull((String)rs.getString("pa_statecode")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCustAddCol.add(Helper.correctNull((String)rs1.getString("state_name")));
				}
				else
				{
					arrCustAddCol.add("");
				}
				arrCustAddCol.add(Helper.correctNull((String)rs.getString("pa_pincode")));
				arrCustAddCol.add(Helper.correctNull((String)rs.getString("pa_datereported")));
				arrCustAddRow.add(arrCustAddCol);
			}
			hshAddressData.put("arrCustAddRow", arrCustAddRow);
			hshCreditData.put("hshAddressData", hshAddressData);
			if(rs!=null){
				rs.close();
			}
			
			//to get the enquiry details
			ResultSet rs2 = null;
			ArrayList arrEnquiryCol = new ArrayList();
			ArrayList arrEnquiryRow = new ArrayList();
			HashMap hshEnquirydata = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_enquiry_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				 arrEnquiryCol = new ArrayList();
				 arrEnquiryCol.add(Helper.correctNull((String)rs.getString("iq_enqmemshortname")));
				 arrEnquiryCol.add(Helper.correctNull((String)rs.getString("iq_enquirydate")));
				 	strQuery = SQLParser.getSqlQuery("sel_enquirypurpose_cibilreport^"+Helper.correctNull((String)rs.getString("iq_enquirypurpose")));
				 	rs2 = DBUtils.executeQuery(strQuery);
				 	if(rs2.next()){
				 		arrEnquiryCol.add(Helper.correctNull((String)rs2.getString("mc_acctype")));
				 	}
				 	else
				 	{
				 		arrEnquiryCol.add("");
				 	}
				 arrEnquiryCol.add(Helper.correctNull((String)rs.getString("iq_enquiryamount")));
				 arrEnquiryRow.add(arrEnquiryCol);
			}
			hshEnquirydata.put("arrEnquiryRow", arrEnquiryRow);
			hshCreditData.put("hshEnquirydata", hshEnquirydata);
			if(rs!=null)
			{
				rs.close();
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			//to get the account Information
			ArrayList arrAccountCol = new ArrayList();
			ArrayList arrAccountRow = new ArrayList();
			HashMap hshAccountData = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_account_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				arrAccountCol = new ArrayList();
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_repmemshortname")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_accountnumber")));
				strQuery = SQLParser.getSqlQuery("sel_enquirypurpose_cibilreport^"+Helper.correctNull((String)rs.getString("tl_accounttype")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		arrAccountCol.add(Helper.correctNull((String)rs2.getString("mc_acctype")));
			 	}
			 	else
			 	{
			 		arrAccountCol.add("");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			 	strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"80"+"^"+Helper.correctNull((String)rs.getString("tl_ownershipind")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		arrAccountCol.add(Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		arrAccountCol.add("");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_dateopendisb")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_datelastpay")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_dateclosed")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_datereported")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_highcrdsancamt")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_currentbalance")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_amountovd")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_payhistory1")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_payhistory2")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_payhiststrtdate")));
				arrAccountCol.add(Helper.correctNull((String)rs.getString("tl_payhistenddate")));
				strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"82"+"^"+Helper.correctNull((String)rs.getString("tl_status")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		arrAccountCol.add(Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		arrAccountCol.add("");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
				arrAccountRow.add(arrAccountCol);
			}
			hshAccountData.put("arrAccountRow", arrAccountRow);
			hshCreditData.put("hshAccountData", hshAccountData);
			if(rs!=null)
			{
				rs.close();
			}
			
			//to get the score information of the applicant
			HashMap hshScoreData = new HashMap();
			ArrayList arrScoreExclusionData = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_score_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshScoreData.put("score_date", Helper.correctNull((String)rs.getString("sc_scoredate")));
				hshScoreData.put("score_obtained", Helper.correctNull((String)rs.getString("sc_score")));
				
				//for exclusion code
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode1")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode2")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode3")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode4")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode5")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode6")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode7")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode8")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode9")));
				arrScoreExclusionData.add(Helper.correctNull((String)rs.getString("sc_exclusioncode10")));
				
				
				//for reason code
				strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"78"+"^"+Helper.correctNull((String)rs.getString("sc_responsecode1")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		hshScoreData.put("score_reason_1",Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		hshScoreData.put("score_reason_1","");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			 	strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"78"+"^"+Helper.correctNull((String)rs.getString("sc_responsecode2")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		hshScoreData.put("score_reason_2",Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		hshScoreData.put("score_reason_2","");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			 	strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"78"+"^"+Helper.correctNull((String)rs.getString("sc_responsecode3")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		hshScoreData.put("score_reason_3",Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		hshScoreData.put("score_reason_3","");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			 	strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"78"+"^"+Helper.correctNull((String)rs.getString("sc_responsecode4")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		hshScoreData.put("score_reason_4",Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		hshScoreData.put("score_reason_4","");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			 	strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"78"+"^"+Helper.correctNull((String)rs.getString("sc_responsecode5")));
			 	rs2 = DBUtils.executeQuery(strQuery);
			 	if(rs2.next()){
			 		hshScoreData.put("score_reason_5",Helper.correctNull((String)rs2.getString("stat_data_desc1")));
			 	}
			 	else
			 	{
			 		hshScoreData.put("score_reason_5","");
			 	}
			 	if(rs2!=null)
			 	{
			 		rs2.close();
			 	}
			}
			hshScoreData.put("arrScoreExclusionData",arrScoreExclusionData);
			hshCreditData.put("hshScoreData", hshScoreData);
			if(rs!=null)
			{
				rs.close();
			}
			
			//to get the general details of the applicant
			String strProcess_Time= "";
			HashMap hshGeneralData = new HashMap();
			strQuery = SQLParser.getSqlQuery("sel_general_cibilreport^"+strInward_no);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshGeneralData.put("mem_shortcode", Helper.correctNull((String)rs.getString("TUEF_ENQMEMCODE")));
				hshGeneralData.put("mem_refno", Helper.correctNull((String)rs.getString("tuef_refnum")));
				hshGeneralData.put("mem_control_no", Helper.correctNull((String)rs.getString("TUEF_CONTROL_NUMBER")));
				hshGeneralData.put("mem_date", Helper.correctNull((String)rs.getString("tuef_date")));
				hshGeneralData.put("mem_time", Helper.correctNull((String)rs.getString("tuef_time")));
			}
			hshCreditData.put("hshGeneralData", hshGeneralData);
			if(rs!=null)
			{
				rs.close();
			}
		}
		catch(Exception e)
		{
			LogWriter.log("Error occured in getCibilReportData........."+e.getMessage());
		}
		return hshCreditData;
	} 
	
	
	//Added by Suganya.K on 29/08/2011 to get cbsid 
	public  HashMap getCBSIDHelp(HashMap hshValues) 
	{
		String strQuery	= "";
		ResultSet rs 	= null;
		ResultSet rs1 	= null;
		HashMap hshRecord 	= new HashMap();
		ArrayList arrRow 	= new ArrayList();
		ArrayList arrCol 	= null;
		
		String id		= correctNull((String)hshValues.get("txt_cbsid"));
		String StrCbs	= correctNull((String)hshValues.get("RD_CBS"));
		String address_type = "",strCityCode="",strStateCode="",strCityName="",strStateName="",strStateId="",strDistrictCode="",strDistrictName="";
		String strPageFrom=correctNull((String)hshValues.get("hidPagename"));
		String strActivityCode="",strCBSID="";
		
		try
		{
			if(StrCbs.equalsIgnoreCase("NO"))
			{
				
				//By Guhan - Since the customer details should come from LAPS
//				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
//				{
//					strQuery		= SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+id.trim());
//					rs				= DBUtils.executeQueryCBSConnection(strQuery);
//				}
//				else
//				{
//					if(StrCbs.equalsIgnoreCase("NAME"))
//					{
//						strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_selectName^"+id.trim());
//						rs 			= DBUtils.executeQuery(strQuery);
//					}
//					else
//					{
//						strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_select^"+id.trim());
//						rs 			= DBUtils.executeQuery(strQuery);
//					}
//				}
				if(strPageFrom.equalsIgnoreCase("appdocumentsinter"))
				strQuery 	= SQLParser.getSqlQuery("selectCBSID_LAPS^"+id.trim()+"^  and indinfo_is_staff='02'");
				else if(strPageFrom.equalsIgnoreCase("UCIC"))
				strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_selectCBSID_LAPS^ ^"+id.trim());
				else
				strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_selectCBSID_LAPS^perapp_profilestatus='Y' and ^"+id.trim());
				rs 			= DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{	
					strStateName="";strStateId="";strCityName="";strDistrictName="";
					strActivityCode="";
					arrCol 			= new ArrayList();
					strCBSID	= correctNull(rs.getString("perapp_cbsid"));
					arrCol.add(correctNull(rs.getString("perapp_cbsid")));//0
					arrCol.add(correctNull(rs.getString("perapp_fname")));//1
					if(correctNull(rs.getString("perapp_constitution")).equalsIgnoreCase("01")||correctNull(rs.getString("perapp_constitution")).equalsIgnoreCase("02"))
					{
						arrCol.add(correctNull(rs.getString("perapp_dob")));//2
					}
					else
					{
						arrCol.add(correctNull(rs.getString("perapp_dob")));//2
					}
					
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
					{
						arrCol.add(correctNull(rs.getString("con_permaddr1")));//3
						strCityCode		= correctNull((String)rs.getString("con_permcity"));
						strStateCode	= correctNull((String)rs.getString("con_permstate"));
						strDistrictCode		= correctNull((String)rs.getString("con_permdist"));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("con_comaddr1")));//3
						strCityCode		= correctNull((String)rs.getString("con_comcity"));
						strStateCode	= correctNull((String)rs.getString("con_comstate"));
						strDistrictCode		= correctNull((String)rs.getString("con_comdist"));
					}
					strQuery = SQLParser.getSqlQuery("sel_statename^"+strStateCode.trim());
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strStateName	= correctNull((String)rs1.getString("state_name"));
						strStateId		= correctNull((String)rs1.getString("state_id"));
					}
					strQuery = SQLParser.getSqlQuery("selcityname^"+strStateId.trim()+"^"+strCityCode);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strCityName		= correctNull((String)rs1.getString("city_name"));
					}
					
					arrCol.add(strCityName);//4
					arrCol.add(strStateName);//5	
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
					{
					arrCol.add(correctNull(rs.getString("con_permzip")));//6	
					arrCol.add(correctNull(rs.getString("con_permphone")));//7
					arrCol.add(correctNull(rs.getString("con_permaddr2")));//8
					}
					else
					{
						arrCol.add(correctNull(rs.getString("con_comzip")));//6	
						arrCol.add(correctNull(rs.getString("con_permphone")));//7
						arrCol.add(correctNull(rs.getString("con_comaddr2")));//8
					}
					arrCol.add(correctNull(rs.getString("con_peremail")));//9
					String strPanno	= correctNull(rs.getString("perapp_panno"));
					
					if(strPanno.equalsIgnoreCase(""))
					{
						strPanno="NOPAN";
					}
					arrCol.add(strPanno);//10
					arrCol.add(strCityCode);//11
					arrCol.add(strStateCode);//12
					
//					if(rs1!=null){rs1.close();}
//					strQuery = SQLParser.getSqlQuery("selappinwarddist^"+strCBSID);
//					rs1 = DBUtils.executeQuery(strQuery);
//					if(rs1.next())
//					{
//						strDistrictCode		= correctNull((String)rs1.getString("district_code"));
//					}
					if(!strDistrictCode.equalsIgnoreCase(""))
					{
						if(rs1!=null){rs1.close();}
						strQuery 	= SQLParser.getSqlQuery("sel_appdistrictname^"+strDistrictCode+"^"+strStateId.trim());
						rs1 		= DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strDistrictName	= correctNull((String)rs1.getString("district_desc"));
						}
					}
					arrCol.add(strDistrictCode);//13
					arrCol.add(strDistrictName);//14
					arrCol.add(correctNull(rs.getString("con_mobile")));//15
					arrCol.add(correctNull(rs.getString("perapp_panno")));//16
					arrCol.add(correctNull(rs.getString("PERAPP_NETWORTH")));//17
					arrCol.add(correctNull(rs.getString("perapp_id")));//18
					String strCountry="";
					
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
						strCountry=correctNull(rs.getString("con_permcountry"));
					else
						strCountry=correctNull(rs.getString("con_comcountry"));
					arrCol.add(strCountry);//19
					
					if(!strCountry.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						rs1.close();
						
						rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strCountry);
						if(rs1.next())
						{
							arrCol.add(correctNull(rs1.getString("con_country")));
						}
						else
						{
							arrCol.add("");
						}
					}
					else
					{
						arrCol.add("");
					}
					arrCol.add(correctNull(rs.getString("con_comphone1")));//21
					arrCol.add(correctNull(rs.getString("PERAPP_OLDID")));//22 
					arrCol.add(correctNull(rs.getString("PERAPP_TITLE")));//23		
					arrCol.add(correctNull(rs.getString("perapp_constitution")));//24		
					
					if(rs1!=null)
						rs1.close();
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(rs1.next())
					{
						strActivityCode=Helper.correctNull(rs1.getString("cust_occp_code"));
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+Helper.correctNull(rs.getString("perapp_id")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("kyc_kycActivity")));//25
						if(!strActivityCode.equalsIgnoreCase("MIGR"))
						strActivityCode=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
					else
					{
						arrCol.add("");
					}
						
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_processAppl_demoid^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID")));
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrCol.add("Y");//26
						}
						else
						{
							arrCol.add("N");//26
						}
						arrCol.add(correctNull(rs.getString("PERAPP_SEX")));//27
						arrCol.add(correctNull(rs.getString("PERAPP_FATNAME")));//28
						arrCol.add(correctNull(rs.getString("PERAPP_AADHAAR")));//29
						arrCol.add(correctNull(rs.getString("PERAPP_MARSTAT")));//30
						arrCol.add(strActivityCode);//31
					arrRow.add(arrCol);
					
					if(!strCBSID.equalsIgnoreCase("")){
						
						strQuery = SQLParser.getSqlQuery("app_bereaucheck^"+strCBSID+"^"+strCBSID+"^"+strCBSID);
						rs1 = DBUtils.executeQuery(strQuery);
						while (rs1.next()) {
							
							hshRecord.put("appno",Helper.correctNull((String)rs1.getString("APP_NO")));
							hshRecord.put("appstatus","Y");
						}
						}
				}	
			}
			else if(StrCbs.equalsIgnoreCase("NAME"))
			{
				if(strPageFrom.equalsIgnoreCase("appdocumentsinter"))
					strQuery 	= SQLParser.getSqlQuery("selectName_LAPS^"+id.trim());
				else if(strPageFrom.equalsIgnoreCase("UCIC"))
					strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_selectName_LAPS^ ^"+id.trim());
				else
					strQuery 	= SQLParser.getSqlQuery("cbs_custdetails_selectName_LAPS^perapp_profilestatus='Y' and ^"+id.trim());
				rs 			= DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{	
					strStateName="";strStateId="";strCityName="";strDistrictName="";strActivityCode="";
					arrCol 			= new ArrayList();
					strCBSID	= correctNull(rs.getString("perapp_cbsid"));
					arrCol.add(correctNull(rs.getString("perapp_cbsid")));//0
					arrCol.add(correctNull(rs.getString("perapp_fname"))+" "+correctNull(rs.getString("perapp_lname")));//1
					if(correctNull(rs.getString("perapp_constitution")).equalsIgnoreCase("01")||correctNull(rs.getString("perapp_constitution")).equalsIgnoreCase("02"))
					{
						arrCol.add(correctNull(rs.getString("perapp_dob")));//2
					}
					else
					{
						arrCol.add(correctNull(rs.getString("perapp_dob")));//2
					}
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
					{
						arrCol.add(correctNull(rs.getString("con_permaddr1")));//3
						strCityCode		= correctNull((String)rs.getString("con_permcity"));
						strStateCode	= correctNull((String)rs.getString("con_permstate"));
						strDistrictCode		= correctNull((String)rs.getString("con_permdist"));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("con_comaddr1")));//3
						strCityCode		= correctNull((String)rs.getString("con_comcity"));
						strStateCode	= correctNull((String)rs.getString("con_comstate"));
						strDistrictCode		= correctNull((String)rs.getString("con_comdist"));
					}
					
					strQuery = SQLParser.getSqlQuery("sel_statename^"+strStateCode.trim());
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strStateName	= correctNull((String)rs1.getString("state_name"));
						strStateId		= correctNull((String)rs1.getString("state_id"));
					}
					strQuery = SQLParser.getSqlQuery("selcityname^"+strStateId.trim()+"^"+strCityCode);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strCityName		= correctNull((String)rs1.getString("city_name"));
					}
					
					arrCol.add(strCityName);//4
					arrCol.add(strStateName);//5	
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
					{
						arrCol.add(correctNull(rs.getString("con_permzip")));//6	
						arrCol.add(correctNull(rs.getString("con_permphone")));//7
						arrCol.add(correctNull(rs.getString("con_permaddr2")));//8
					}
					else
					{
						arrCol.add(correctNull(rs.getString("con_comzip")));//6	
						arrCol.add(correctNull(rs.getString("con_permphone")));//7
						arrCol.add(correctNull(rs.getString("con_comaddr2")));//8
					}
					arrCol.add(correctNull(rs.getString("con_peremail")));//9
					String strPanno	= correctNull(rs.getString("perapp_panno"));
					
					if(strPanno.equalsIgnoreCase(""))
					{
						strPanno="NOPAN";
					}
					arrCol.add(strPanno);//10
					arrCol.add(strCityCode);//11
					arrCol.add(strStateCode);//12
					
//					if(rs1!=null){rs1.close();}
//					strQuery = SQLParser.getSqlQuery("selappinwarddist^"+strCBSID);
//					rs1 = DBUtils.executeQuery(strQuery);
//					if(rs1.next())
//					{
//						strDistrictCode		= correctNull((String)rs1.getString("district_code"));
//					}
					if(!strDistrictCode.equalsIgnoreCase(""))
					{
						if(rs1!=null){rs1.close();}
						strQuery 	= SQLParser.getSqlQuery("sel_appdistrictname^"+strDistrictCode+"^"+strStateId.trim());
						rs1 		= DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strDistrictName	= correctNull((String)rs1.getString("district_desc"));
						}
					}
					arrCol.add(strDistrictCode);//13
					arrCol.add(strDistrictName);//14
					arrCol.add(correctNull(rs.getString("con_mobile")));//15
					arrCol.add(correctNull(rs.getString("perapp_panno")));//16
					arrCol.add(correctNull(rs.getString("PERAPP_NETWORTH")));//17
					arrCol.add(correctNull(rs.getString("perapp_id")));//18
					String strCountry="";
					
					if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
						strCountry=correctNull(rs.getString("con_permcountry"));
					else
						strCountry=correctNull(rs.getString("con_comcountry"));
					arrCol.add(strCountry);//19
					
					if(!strCountry.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						rs1.close();
						
						rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strCountry);
						if(rs1.next())
						{
							arrCol.add(correctNull(rs1.getString("con_country")));
						}
						else
						{
							arrCol.add("");
						}
					}
					else
					{
						arrCol.add("");
					}
					arrCol.add(correctNull(rs.getString("con_comphone1")));//21
					arrCol.add(correctNull(rs.getString("PERAPP_OLDID")));//22
					arrCol.add(correctNull(rs.getString("PERAPP_TITLE")));//23
					arrCol.add(correctNull(rs.getString("perapp_constitution")));//24		
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+Helper.correctNull(rs.getString("perapp_id")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("kyc_kycActivity")));//25
						strActivityCode=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
					else
					{
						arrCol.add("");
					}
						
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_processAppl_demoid^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID")));
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrCol.add("Y");//26
						}
						else
						{
								arrCol.add("N");
						}
						arrCol.add(correctNull(rs.getString("PERAPP_SEX")));//27
						arrCol.add(correctNull(rs.getString("PERAPP_FATNAME")));//28
						arrCol.add(correctNull(rs.getString("PERAPP_AADHAAR")));//29
						arrCol.add(correctNull(rs.getString("PERAPP_MARSTAT")));//30
						arrCol.add(strActivityCode);//31
						if(rs1 !=null){
							rs1.close();
						}
						if(!strCBSID.equalsIgnoreCase("")){
							
						strQuery = SQLParser.getSqlQuery("app_bereaucheck^"+strCBSID+"^"+strCBSID+"^"+strCBSID);
						rs1 = DBUtils.executeQuery(strQuery);
						while (rs1.next()) {
							
							hshRecord.put("appno",Helper.correctNull((String)rs1.getString("APP_NO")));
							hshRecord.put("appstatus","Y");
						}
						
						}
					arrRow.add(arrCol);
				}	
			}
			
			hshRecord.put("arrRow",arrRow);	
			hshRecord.put("hidStrCbs",StrCbs);			

			hshRecord.put("varSno",Helper.correctNull((String)hshValues.get("varSno")));
			
			hshRecord.put("pagename",Helper.correctNull((String)hshValues.get("hidPagename")));

			hshRecord.put("strAppVar",Helper.correctNull((String)hshValues.get("hidstrAppVar")));
			

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCBSIDHelp: "+ce.toString());
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
	
	//Added by harish on 16/11/2015 to get application for cbsid 
	public  HashMap getCBSapplHelp(HashMap hshValues) 
	{
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery	= "";
		ResultSet rs 	= null;
		ResultSet rs1 	= null;
		HashMap hshRecord 	= new HashMap();
		ArrayList arrRow 	= new ArrayList();
		ArrayList arrCol 	= null;
		
		String id		= correctNull((String)hshValues.get("cbsid"));
		String StrCbs	= correctNull((String)hshValues.get("RD_CBS"));
		String strPageFrom=correctNull((String)hshValues.get("hidPagename"));
		
		try
		{
				int statuscount=0;
				strQuery 	= SQLParser.getSqlQuery("sel_ucicappl^"+id.trim()+"^"+id.trim()+"^"+id.trim()+"^"+id.trim()+"^"+id.trim()+"^"+id.trim()+"^"+id.trim());
				rs 			= DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					arrCol 			= new ArrayList();
					arrCol.add(correctNull(rs.getString("APP_NO")));//1
					arrCol.add(correctNull(rs.getString("SNO")));//2
					arrCol.add(correctNull(rs.getString("CBS_ACCOUNTNO")));//3
					arrCol.add(correctNull(rs.getString("DESC1")));//4
					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_RECMDAMT")))));//5
					arrCol.add(correctNull(rs.getString("MODULETYPE")));//6
					arrCol.add(correctNull(rs.getString("PROCESSDATE")));//7
					arrCol.add(correctNull(rs.getString("FACTYPE")));//8
					arrCol.add(correctNull(rs.getString("STATUS")));//10
					String appStatusFlag=Helper.correctNull(rs.getString("STATUS"));
					if(appStatusFlag.equalsIgnoreCase("Open/Pending")||appStatusFlag.equalsIgnoreCase("Open/Lodged"))
					{
						statuscount++;
					}
					arrRow.add(arrCol);
				}
				                                                      
			hshRecord.put("arrRow",arrRow);	
			hshRecord.put("hidStrCbs",StrCbs);	
			hshRecord.put("statuscount",String.valueOf(statuscount));	
			hshRecord.put("varSno",Helper.correctNull((String)hshValues.get("varSno")));
			hshRecord.put("pagename",Helper.correctNull((String)hshValues.get("hidPagename")));
			hshRecord.put("strAppVar",Helper.correctNull((String)hshValues.get("hidstrAppVar")));
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCBSapplHelp: "+ce.toString());
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
	
	public  HashMap getCBSValidateData(HashMap hshValues) 
	{
		String strQuery	= "";
		ResultSet rs 	= null;
		ResultSet rs1 	= null;
		HashMap hshRecord 	= new HashMap();
		ArrayList arrRow 	= new ArrayList();
		ArrayList arrCol 	= null;
		
		String newid	= correctNull((String)hshValues.get("txt_cbsid"));
		String oldid 	= correctNull((String)hshValues.get("oldcbsid"));
		String newpanno="",oldpanno="",newdob="",olddob="",newaadhar="",oldaadhar="",newpassportno="",oldpassportno="";
		try
		{
				strQuery = SQLParser.getSqlQuery("selectCBSID_LAPS^"+newid.trim()+"^ ");
				rs 		 = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshRecord.put("perappid", Helper.correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("perapp_fname", Helper.correctNull((String) rs.getString("perapp_fname")));
					newpanno = Helper.correctNull((String) rs.getString("perapp_panno"));
					newdob = Helper.correctNull((String) rs.getString("perapp_dob"));
					newaadhar = Helper.correctNull((String) rs.getString("PERAPP_AADHAAR"));
					newpassportno = Helper.correctNull((String) rs.getString("APPNRI_PASSPORT_NO"));
				}
				
				if(rs != null){rs.close();}
				strQuery = SQLParser.getSqlQuery("selOldLAPSID^"+oldid.trim());
				rs 		 = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshRecord.put("perappid", Helper.correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("perapp_fname", Helper.correctNull((String) rs.getString("perapp_fname")));
					oldpanno = Helper.correctNull((String) rs.getString("perapp_panno"));
					olddob = Helper.correctNull((String) rs.getString("perapp_dob"));
					oldaadhar = Helper.correctNull((String) rs.getString("PERAPP_AADHAAR"));
					oldpassportno = Helper.correctNull((String) rs.getString("APPNRI_PASSPORT_NO"));
				}
				if(((!newdob.equals("")) && newdob.equals(olddob))&&(!newpanno.equals("")) && newpanno.equals(oldpanno))
				{
					hshRecord.put("validateflag", "Y");
				}
				else if(((!newdob.equals("")) && newdob.equals(olddob))&&(!newaadhar.equals("")) && newaadhar.equals(oldaadhar))
				{
					hshRecord.put("validateflag", "Y");
				}
				else if(((!newdob.equals("")) && newdob.equals(olddob))&&(!newpassportno.equals("")) && newpassportno.equals(oldpassportno))
				{
					hshRecord.put("validateflag", "Y");
				}
				else
				{
					hshRecord.put("validateflag", "N");
				}
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCBSValidateData: "+ce.toString());
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
	
	public HashMap updateUCICcustid(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		int intUpdatesize=0;
		String strQuery	= "";
		ResultSet rs 	= null;
		ResultSet rs1 	= null;
		HashMap hshQueryValues1=new HashMap();
		HashMap hshQuery1=new HashMap();
		ArrayList arrValues=new ArrayList();
		String oldid=Helper.correctNull((String)hshValues.get("txt_extcustid"));
		String newid=Helper.correctNull((String)hshValues.get("txt_newcustid"));
		String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
		String ucicRemarks=Helper.correctNull((String)hshValues.get("ucicremarks"));
		String newlapsid="",oldlapsid="";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selectCBSID_LAPS^"+newid.trim()+"^ ");
			rs 		 = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				newlapsid=Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
			}
			if(rs!=null){ rs.close(); }
			strQuery = SQLParser.getSqlQuery("selOldLAPSID^"+oldid.trim());
			rs 		 = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				oldlapsid=Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
			}
			String maxno="";
			if(rs!=null){ rs.close(); }
			strQuery = SQLParser.getSqlQuery("sel_maxsno_ucicprocess");
			rs 		 = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				maxno=Helper.correctNull((String)rs.getString("maxsno"));
			}
			
			if(rs!=null) { rs.close(); }
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_perdemo");
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_facilit");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_comdemo");
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_cussec");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_appsecdet1");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_appsecdet2");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_appsecdet3");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_appborrow");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_comcompdet");
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_combank");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_comgroupconcern");
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_solvency");
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_addkbowerdet");
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_finrating");
			arrValues.add(newid);
			arrValues.add(newlapsid);
			arrValues.add(oldlapsid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_cusgroupmem");
			arrValues.add(newid);
			arrValues.add(newlapsid);
			arrValues.add(newlapsid);
			arrValues.add(oldid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_ucic_comappcom");
			arrValues.add(newid);
			arrValues.add(newlapsid);
			arrValues.add(oldid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","upd_deviation_cbsid");
			arrValues.add(newid);
			arrValues.add(oldid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","ins_ucicprocess");
			arrValues.add(maxno);
			arrValues.add(strUserId);
			arrValues.add(oldid);
			arrValues.add(newid);
			arrValues.add(ucicRemarks);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			
		 	EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			hshValues.put("maxslno", maxno);
			hshValues.put("ucicprocess", "Y");
	
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in updateUCICcustid "+ae.getMessage());
		}
		
		return hshValues;
		
	}
	
	public HashMap getInwardLeadnoCheck(HashMap hshValues)
	{
		String strQuery	= "",strLmsCheck="";
		ResultSet rs 	= null;
		boolean bflag=true;
		ArrayList arrParam=new ArrayList();
		try
		{
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_lapsapplicationparameters^122");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLmsCheck=Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
			}
			if(strLmsCheck.equalsIgnoreCase("Y"))
			{
				if(rs!=null)
					rs.close();
				arrParam.add(correctNull((String)hshValues.get("leadnum")).toUpperCase());
				if(ApplicationParams.getStrLMSConnection().equalsIgnoreCase("TRUE"))
					rs=DBUtils.executeLMSQuery("chk_leadstatus1", arrParam);
				else
					rs=DBUtils.executeLAPSQuery("chk_leadstatus^"+correctNull((String)hshValues.get("leadnum")).toUpperCase());
				if(rs.next())
				{
						hshValues.put("strLeadStatus", Helper.correctNull(rs.getString("lead_status")));
						
				}
				else
				{
					hshValues.put("strLeadStatus","N");
				}
			}
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("chk_leadnumber^"+correctNull((String)hshValues.get("leadnum")).toUpperCase());
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!Helper.correctNull((String)hshValues.get("strLeadno")).equalsIgnoreCase(Helper.correctNull(rs.getString("inward_no"))))
				{
					if(Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase("")||(!Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase("")
					&& !Helper.correctNull(rs.getString("app_delflag")).equalsIgnoreCase("Y")))
					{
						hshValues.put("existig_leadnum_inward", Helper.correctNull(rs.getString("inward_no")));
						bflag=false;
					}
				}
			}
			
			if(bflag)
			{
				hshValues.put("existig_leadnum_inward", "N");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardLeadnoCheck: "+ce.toString());
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
		
		return hshValues;
	}
	
	public HashMap getUCICcustid(HashMap hshValues)
	{
		String strQuery	= "";
		ResultSet rs 	= null;
		ResultSet rs1 	= null;
		HashMap hshRecord 	= new HashMap();
		
		try
		{
			
			
			
			
			
			
			
			
			
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUCICcustid: "+ce.toString());
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
		
		return hshValues;
	}
	
	
public void updateOdCcLimits(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		HashMap hshQueryValues1=new HashMap();
		HashMap hshQuery1=new HashMap();
		ArrayList arrValues=new ArrayList();
		ArrayList arrValues1=new ArrayList();
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String StrAppno = Helper.correctNull((String)hshValues.get("appno"));
		String sel_product = Helper.correctNull((String)hshValues.get("sel_product"));
		String hidsno = Helper.correctNull((String)hshValues.get("hidsno"));
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strSno="";
		int intSno1=0;
		if(StrAppno.equalsIgnoreCase(""))
		{
			StrAppno = Helper.correctNull((String)hshValues.get("appno"));
		}
		strSno = Integer.toString(getMaxIdOdCcLimits(StrAppno));
		
		StringBuilder sbolddata = new StringBuilder();
		ResultSet rs = null;
		
		try
		{	
			if(strAction.equalsIgnoreCase("insert"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_odcclimit");
				arrValues.add(StrAppno);
				arrValues.add(strSno);				
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("com_creditsum")));
				arrValues.add(Helper.correctNull((String)hshValues.get("com_debitsum")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_maxdr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mindr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_maxcr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mincr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_notimeexcess")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noamtcheque")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amt")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_creditsumtn")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_debitsumtn")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_date")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("com_odcccomments")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("com_creditsummationcmts")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_odcclimit");		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("com_creditsum")));
				arrValues.add(Helper.correctNull((String)hshValues.get("com_debitsum")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_maxdr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mindr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_maxcr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mincr")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_notimeexcess")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noamtcheque")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amt")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_creditsumtn")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_debitsumtn")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_date")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("com_odcccomments")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("com_creditsummationcmts")));
				arrValues.add(StrAppno);
				arrValues.add(hidsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_odcclimit");
				hshQuery.put("arrValues",arrValues);
				arrValues.add(StrAppno);
				arrValues.add(hidsno);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
			}
			
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in UpdateOdCcLimits"+ae.getMessage());
		}
	}
	public HashMap  getOdCcLimits(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String strQuery= null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow= new ArrayList();
		HashMap hshContent=new HashMap();
		
		try
		{
			String StrAppno = Helper.correctNull((String)hshValues.get("appno"));
			String strhidsno=Helper.correctNull((String)hshValues.get(""));
			if(StrAppno.equalsIgnoreCase(""))
			{
				StrAppno = Helper.correctNull((String)hshValues.get("strappno"));
			}
				strQuery=SQLParser.getSqlQuery("sel_odcclimit^"+StrAppno);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next()) 				
				{

					arrCol = new ArrayList();
					arrCol.add(Helper.correctDouble((String)rs.getString("com_sanclimit")));//0
					arrCol.add(Helper.CLOBToString(rs.getClob("com_crsummation")));//1
					arrCol.add(Helper.CLOBToString(rs.getClob("com_drsummation")));//2	
					arrCol.add(Helper.correctDouble((String)rs.getString("com_maxdrbal")));//3
					arrCol.add(Helper.correctDouble((String)rs.getString("com_mindrbal")));//4
					arrCol.add(Helper.correctDouble((String)rs.getString("com_maxcrbal")));//5
					arrCol.add(Helper.correctDouble((String)rs.getString("com_mincrbal")));//6
					arrCol.add(Helper.correctDouble((String)rs.getString("com_notimeexcess")));//7
					arrCol.add(Helper.correctDouble((String)rs.getString("com_noamtcheque")));//8
					arrCol.add(Helper.correctDouble((String)rs.getString("com_amount")));//9
					arrCol.add(Helper.correctDouble((String)rs.getString("com_sno")));//10
					arrCol.add(Helper.correctDouble((String)rs.getString("com_creditsum")));//11
					arrCol.add(Helper.correctDouble((String)rs.getString("com_debitsum")));//12
					arrCol.add(Helper.correctDouble((String)rs.getString("com_year_sno")));//13
					arrCol.add(Helper.CLOBToString(rs.getClob("com_odcccomments")));//14
					arrCol.add(Helper.CLOBToString(rs.getClob("com_creditsumcomts")));//15
					arrRow.add(arrCol);
				}
				hshRecord.put("arryRow", arrRow);
		}
		
		catch(Exception ce)
		{
			throw new EJBException("Error in getOdCcLimits "+ce.toString());
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
	
	private int getMaxIdOdCcLimits(String appno)
	{
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("selectMaxidodcclimit^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1));
				}
				else
				{
					termId = 1;
				}
			}
			if(rs!=null)rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return termId;
	}

	public void updateOtherDetails(HashMap hshValues)
	{
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		ResultSet rs = null;
		ArrayList arrfromDate=new ArrayList();
		ArrayList arrtoDate=new ArrayList();
		String strAppno="" ;
		String strAction = "";
		String strInwardno="";
		String strSaral="";
	    String Flag="";
	    String strExp="$";
	    String strQuery="";
		try
		{
			strInwardno = correctNull((String)hshValues.get("inwardno"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno = correctNull((String)hshValues.get("appno"));	
			rs=DBUtils.executeLAPSQuery("selothercommentsdetails^"+strAppno);
			while(rs.next())
			{
				
				arrfromDate.add(Helper.correctNull((String)rs.getString("COM_FROMDATE")));
				arrtoDate.add(Helper.correctNull((String)rs.getString("COM_TODATE")));
			
			}
			String strfromDate=Helper.correctNull((String)hshValues.get("txt_frmdate"));
			String strtoDate1=Helper.correctNull((String)hshValues.get("txt_todate"));
			
			if(!arrfromDate.equals(""))
				{
		     	if(arrfromDate.contains(strfromDate))
				  {
					 Flag="FD";
					
					 hshValues.put("strExpFrmdate",Flag);
				   }
			}
				
				if(!arrtoDate.equals(""))
				{
				if(arrtoDate.contains(strtoDate1))
				{
					 Flag="TD";
					 
					 hshValues.put("strExpTOdate",Flag);
					
				}
				}
		
	
			if(strAction.equalsIgnoreCase("insert"))
			{	
				strQuery=SQLParser.getSqlQuery("sel_busiTurnover^"+strAppno+"^"+strfromDate+"^"+strtoDate1+"^"+strfromDate+"^"+strtoDate1+"^"+strfromDate+"^"+strtoDate1);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(rs.getInt(1)!=0)
					{
						strExp = strExp + " Date already exist ";
						throw new Exception(strExp);
					}
				}
				
				String strMaxid = "";
				strQuery = SQLParser.getSqlQuery("sel_maxothercomments^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMaxid = Helper.correctNull((String)rs.getString("maxsno"));
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();			
				hshQuery.put("strQueryId","ins_othercommentsdetails");
				arrValues.add(strAppno);     			
				arrValues.add(correctNull((String)hshValues.get("txt_int")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_frmdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_todate")));
				arrValues.add(strMaxid);
				arrValues.add(correctNull((String)hshValues.get("txt_recoverystatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_odinterest")));
				arrValues.add(correctNull((String)hshValues.get("txt_forexincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_tlintincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherfacincome")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("update"))
			{	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();			
				hshQuery.put("strQueryId","upd_othercommentsdetails");    			
				arrValues.add(correctNull((String)hshValues.get("txt_int")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_frmdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_todate")));
				arrValues.add(correctNull((String)hshValues.get("txt_recoverystatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_odinterest")));
				arrValues.add(correctNull((String)hshValues.get("txt_forexincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_tlintincome")));
				arrValues.add(correctNull((String)hshValues.get("txt_otherfacincome")));
				arrValues.add(strAppno); 
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
	    
	
	if(strAction.equalsIgnoreCase("delete"))
	{
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();
				
		hshQuery.put("strQueryId","del_othercommentsdetails");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
	
		arrValues = new ArrayList();	
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","del_odcclimit1");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		
		arrValues = new ArrayList();	
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","del_packingcredit1");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("3",hshQuery);
		
		arrValues = new ArrayList();	
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","del_billspurchased1");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("4",hshQuery);
		
		arrValues = new ArrayList();	
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","del_com_nonfundloanlc1");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("5",hshQuery);
		
		hshQueryValues.put("size","5");		
		

		arrValues = new ArrayList();	
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","del_com_nonfundloanothers1");
		arrValues.add(strAppno);	
		arrValues.add(correctNull((String)hshValues.get("hidsno")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("6",hshQuery);
		
		hshQueryValues.put("size","6");	
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
			
		}catch (Exception e)
		{
			throw new EJBException(e.toString());
		} 
		finally{
			hshQueryValues=null;
			arrValues=null;
			hshQuery=null;
			
		}
		
	}
	public HashMap getOthersDetails(HashMap hshValues)
	{
		
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery="";
	String strAppno = correctNull((String)hshValues.get("appno"));
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	try
		{
		    rs=DBUtils.executeLAPSQuery("selothercommentsdetails^"+strAppno);
			while(rs.next())
			{	
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("COM_INTEREST")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("COM_OTHERINCOME")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("COM_FROMDATE")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("COM_TODATE")));//3
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SNO")));//4
				arrCol.add(Helper.CLOBToString(rs.getClob("COM_RECOVERYSTATUS")));//5
				arrCol.add(Helper.correctNull((String)rs.getString("com_odinterest")));//6
				arrCol.add(Helper.correctNull((String)rs.getString("com_forexincome")));//7
				arrCol.add(Helper.correctNull((String)rs.getString("com_tlinterest")));//8
				arrCol.add(Helper.correctNull((String)rs.getString("com_otherfacincome")));//9
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			hshResult.put("strExpFrmdate",Helper.correctNull((String)hshValues.get("strExpFrmdate")));
			hshResult.put("strExpTOdate",Helper.correctNull((String)hshValues.get("strExpTOdate")));
			
		}
	catch(Exception ce)
	{
		throw new EJBException("Error in getOthersDetails "+ce.toString());
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

	public void updatePackingCredit(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		
		String strAppno="" ;
		String strAction = "";
		String strInwardno="";
		String strSaral="",strseltype="",strSno="";
		String strQuery="";
		ResultSet rs = null;
		try
		{
			strInwardno = correctNull((String)hshValues.get("inwardno"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno = correctNull((String)hshValues.get("appno"));	
			strseltype= correctNull((String)hshValues.get("sel_type"));	
			strQuery = SQLParser.getSqlQuery("maxpackingcredit^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSno =rs.getString(1);
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_packingcredit");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_packingcredit");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_type")));
				arrValues.add(correctNull((String)hshValues.get("txt_sancamt")));
				if(strseltype.equalsIgnoreCase("1"))
				{
				arrValues.add(correctNull((String)hshValues.get("txt_nos")));
				arrValues.add(correctNull((String)hshValues.get("txt_amt")));
				arrValues.add(correctNull((String)hshValues.get("txt_nosret")));
				arrValues.add(correctNull((String)hshValues.get("txt_amtret")));
				}
				else if(strseltype.equalsIgnoreCase("2"))
				{
				arrValues.add(correctNull((String)hshValues.get("txt_loannos")));
				arrValues.add(correctNull((String)hshValues.get("txt_loanamt")));
				arrValues.add(correctNull((String)hshValues.get("txt_agrno")));
				arrValues.add(correctNull((String)hshValues.get("txt_agramt")));
				}
				arrValues.add(correctNull((String)hshValues.get("txt_remarks")));
				arrValues.add(strSno);
				arrValues.add(correctNull((String)hshValues.get("sel_date")));
				arrValues.add(correctNull((String)hshValues.get("txt_excesspermitted")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_packingcredit");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno1")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","update_packingcredit");
				arrValues.add(strAppno);
     			arrValues.add(correctNull((String)hshValues.get("sel_type")));
				arrValues.add(correctNull((String)hshValues.get("txt_sancamt")));
				if(strseltype.equalsIgnoreCase("1"))
				{
				arrValues.add(correctNull((String)hshValues.get("txt_nos")));
				arrValues.add(correctNull((String)hshValues.get("txt_amt")));
				arrValues.add(correctNull((String)hshValues.get("txt_nosret")));
				arrValues.add(correctNull((String)hshValues.get("txt_amtret")));
				}
				else if(strseltype.equalsIgnoreCase("2"))
				{
				arrValues.add(correctNull((String)hshValues.get("txt_loannos")));
				arrValues.add(correctNull((String)hshValues.get("txt_loanamt")));
				arrValues.add(correctNull((String)hshValues.get("txt_agrno")));
				arrValues.add(correctNull((String)hshValues.get("txt_agramt")));
				}
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_remarks")));
				arrValues.add(strSno);
				arrValues.add(correctNull((String)hshValues.get("sel_date")));
				arrValues.add(correctNull((String)hshValues.get("txt_excesspermitted")));
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno1")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}catch (Exception e)
		{
			throw new EJBException("Error in updatePackingCredit " + e.getMessage());
		} 
	}
	public HashMap getPackingCredit(HashMap hshValues)
	{
		
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery="";
	ArrayList arrCol= new ArrayList();
	ArrayList arrRow= new ArrayList();
	ArrayList arrValue = new ArrayList();
	String strAppno = correctNull((String)hshValues.get("appno"));
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	try
		{
			rs=DBUtils.executeLAPSQuery("sel_packingcredit^"+strAppno);
			while(rs.next())
			{	
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("pc_appno")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("pc_seltype")));//1
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("pc_sancamt")))));//2
				arrCol.add(Helper.correctNull((String)rs.getString("pc_cheno")));//3
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("pc_cheamt")))));//4
				arrCol.add(Helper.correctNull((String)rs.getString("pc_retno")));//5
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("pc_retamt")))));//6
				String strclob = Helper.CLOBToString(rs.getClob("pc_remarks"));
				arrCol.add(strclob);//7
				arrCol.add(Helper.correctNull((String)rs.getString("pc_sno")));//8
				arrCol.add(Helper.correctNull((String)rs.getString("pc_year_sno")));//9
				arrCol.add(Helper.correctNull((String)rs.getString("com_excesspermitted")));//10
				hshResult.put("sno",Helper.correctNull((String)rs.getString("pc_sno")));
				hshResult.put("remarks",Helper.correctNull(Helper.CLOBToString(rs.getClob("pc_remarks"))));
				arrRow.add(arrCol);
			}	
			hshResult.put("arrRow",arrRow);	
			
		}
	catch(Exception ce)
	{
		throw new EJBException("Error in getPackingCredit "+ce.toString());
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
	public  HashMap getBillsPurchasedDetails(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strAppno = correctNull((String)hshValues.get("appno"));
		String strInlandexp = correctNull((String)hshValues.get("sel_Inlandexp"));
		//String strdescLen = correctNull((String)hshValues.get("hiddisclength"));

		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		try
		{
			
			if(!strInlandexp.equalsIgnoreCase(""))
			{
			strQuery = SQLParser.getSqlQuery("sel_billspurchasedinlandexp^"+strAppno+"^"+strInlandexp);	
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("BP_APPNO")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("BP_SNO")));//1
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_SANCTIONAMT")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER1")));//3
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT1")));//4
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER2")));//5
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT2")));//6
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER3")));//7
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT3")));//8
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER4")));//9
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT4")));//10
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER5")));//11
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT5")));//12
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER6")));//13
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT6")));//14
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER7")));//15
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT7")));//16
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER8")));//17
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT8")));//18
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER9")));//19
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT9")));//20
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER10")));//21
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT10")));//22
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER11")));//23
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT11")));//24
				arrCol.add(Helper.correctNull((String)rs.getString("BP_EXCESS")));//25
				arrCol.add(Helper.correctNull((String)rs.getString("BP_COMMENTS")));//26
				arrCol.add(Helper.correctNull((String)rs.getString("BP_YEAR_SNO")));//27
				arrCol.add(Helper.correctNull((String)rs.getString("Bp_Inlandexpbills")));//28 added by ganesan for Inland/ Export Bills 
				arrCol.add(Helper.CLOBToString(rs.getClob("bp_advancecmts")));//29
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER12")));//30
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT12")));//31
				arrCol.add(Helper.correctNull((String)rs.getString("BP_NUMBER13")));//32
				arrCol.add(Helper.correctDouble((String)rs.getString("BP_AMOUNT13")));//33
				arrCol.add(Helper.CLOBToString(rs.getClob("bd_idpmscnts")));//34
				arrRow.add(arrCol);
			}
			}
			hshResult.put("arrRow",arrRow);	
			hshResult.put("strInlandexp",strInlandexp);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBillsPurchaseDetails "+ce.toString());
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
	public void updateBillsPurchasedDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSno="";
		String strAppno="" ;
		String strAction = "";
		String strDescLen="";
		String strInlandexp="";
			
		ResultSet rs = null;
		try
		{
			strAction = correctNull((String)hshValues.get("hidAction1"));
			strAppno = correctNull((String)hshValues.get("appno"));	
			strDescLen = correctNull((String)hshValues.get("hiddisclength"));	
			strInlandexp=Helper.correctNull((String)hshValues.get("sel_Inlandexp"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("hidAppno"));
			}
						
			if(strAction.equalsIgnoreCase("insert"))
			{
				String StrQuery1 = SQLParser.getSqlQuery("sel_maxbillsno^"+strAppno);
				ResultSet rs1= DBUtils.executeQuery(StrQuery1);
				if(rs1.next())
					strSno = Helper.correctNull((String)rs1.getString("sno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_billspurchased");
				arrValues.add(strAppno);
				arrValues.add(strSno);
     			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sanc_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_number1")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount1")));
				arrValues.add(correctNull((String)hshValues.get("txt_number2")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount2")));
				arrValues.add(correctNull((String)hshValues.get("txt_number3")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount3")));
				arrValues.add(correctNull((String)hshValues.get("txt_number4")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount4")));
				arrValues.add(correctNull((String)hshValues.get("txt_number5")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount5")));
				arrValues.add(correctNull((String)hshValues.get("txt_number6")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount6")));
				arrValues.add(correctNull((String)hshValues.get("txt_number7")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount7")));
				arrValues.add(correctNull((String)hshValues.get("txt_number8")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount8")));
				arrValues.add(correctNull((String)hshValues.get("txt_number9")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount9")));
				arrValues.add(correctNull((String)hshValues.get("txt_number10")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount10")));
				arrValues.add(correctNull((String)hshValues.get("txt_number11")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount11")));
				if(strInlandexp.equalsIgnoreCase("1"))
				{
					arrValues.add(correctNull((String)hshValues.get("txt_excess")));
				}else{
					arrValues.add(correctNull((String)hshValues.get("txt_Expexcess")));
				}
				arrValues.add(correctNull((String)hshValues.get("txtar_comments")));
				arrValues.add(correctNull((String)hshValues.get("sel_date")));
				arrValues.add(strInlandexp);//added by ganesan 
				arrValues.add(correctNull((String)hshValues.get("txtadvpayment_comments")));
				arrValues.add(correctNull((String)hshValues.get("txt_number12")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount12")));
				arrValues.add(correctNull((String)hshValues.get("txt_number13")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount13")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtidpms_comments")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_billspurchased");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_billspurchased");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sanc_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_number1")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount1")));
				arrValues.add(correctNull((String)hshValues.get("txt_number2")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount2")));
				arrValues.add(correctNull((String)hshValues.get("txt_number3")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount3")));
				arrValues.add(correctNull((String)hshValues.get("txt_number4")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount4")));
				arrValues.add(correctNull((String)hshValues.get("txt_number5")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount5")));
				arrValues.add(correctNull((String)hshValues.get("txt_number6")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount6")));
				arrValues.add(correctNull((String)hshValues.get("txt_number7")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount7")));
				arrValues.add(correctNull((String)hshValues.get("txt_number8")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount8")));
				arrValues.add(correctNull((String)hshValues.get("txt_number9")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount9")));
				arrValues.add(correctNull((String)hshValues.get("txt_number10")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount10")));
				arrValues.add(correctNull((String)hshValues.get("txt_number11")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount11")));
				if(strInlandexp.equalsIgnoreCase("1"))
				{
					arrValues.add(correctNull((String)hshValues.get("txt_excess")));
				}else{
					arrValues.add(correctNull((String)hshValues.get("txt_Expexcess")));
				}
				arrValues.add(correctNull((String)hshValues.get("txtar_comments")));
				arrValues.add(correctNull((String)hshValues.get("sel_date")));
				arrValues.add(strInlandexp);
				arrValues.add(correctNull((String)hshValues.get("txtadvpayment_comments")));
				arrValues.add(correctNull((String)hshValues.get("txt_number12")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount12")));
				arrValues.add(correctNull((String)hshValues.get("txt_number13")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount13")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtidpms_comments")));
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatePackingCredit " + e.getMessage());
		} 
	}
	
	public HashMap getmsmeproposal(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery = "";
		HashMap hshRequestValues = null;
		String areacheckval="",strQuery1="",strQuery2="";
		String area1="",area2="",area3="",area4="",area5="",glptotlevel="",absPosition="";
		try {
			hshRecord = new HashMap();
			arr = new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				arr.add(Helper.correctNull(rs.getString(1)));
				arr.add(Helper.correctNull(rs.getString(2)));
				arr.add(Helper.correctNull(rs.getString(3)));
				arr.add(Helper.correctNull(rs.getString(4)));
				arr.add(Helper.correctNull(rs.getString(5)));
				arr.add(Helper.correctNull(rs.getString(6)));
			}
			hshValues.put("arr", arr);

		} catch (Exception ce) {
			throw new EJBException("Error in getmsmeproposal ::  "
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
		return hshValues;
	}
	
	public HashMap getmsmeproposalSearch(HashMap hshValues)  {
		
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		String strQuery="",areacheckval="",desc="",bownameval="";
		String area1="",area2="",area3="",area4="",area5="" ,glptotlevel="",absPosition="";
		String strCategorytype="",str_statuscust=""
		,str_statuscompkyc="",str_statuscompincexp="";
		String strCusCBSStatus="N";
		String strradioValues="",strSearchText="";
		String strQuery1="";
		ArrayList arr =  new ArrayList();
		try
		{
			hshRecord = new HashMap(); 
			arr = new ArrayList();
			strCategorytype=correctNull((String)hshValues.get("hidCategoryType"));
			String orgSelCode = Helper.correctNull((String)hshValues.get("strOrgSelect"));
			String strUser = correctNull((String) hshValues.get("strUserId"));
			String search=correctNull((String)hshValues.get("search"));
			orgSelCode = orgSelCode+"%"; 
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));
		 	area1= correctNull((String)hshValues.get("area1"));
			area2= correctNull((String)hshValues.get("area2"));
			area3 = correctNull((String)hshValues.get("area3"));
			area4 = correctNull((String)hshValues.get("area4"));
			area5 = correctNull((String)hshValues.get("area5"));
			String val=correctNull((String)hshValues.get("hidvalue"));
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
	        absPosition = correctNull((String)hshValues.get("hid_rowcount"));
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
					areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			if (!search.equals("") ) 
			{
				if(!areacheckval.equals(""))
				{

			if(val.equalsIgnoreCase("name"))
			{
				desc= "(upper(perapp_fname) like upper('%"+search+"%'))" ;
				
				strQuery1 = SQLParser.getSqlQuery("sel_msmesearchbyname^"+desc+"^"+areacheckval);

			}
				}
				else
				{
			 if(val.equalsIgnoreCase("CBSID"))
			{
				desc=search;
				
				strQuery1 = SQLParser.getSqlQuery("sel_msmesearchbycbsid^"+desc);
				
			}
			
			
			else 
			{
				//No Function;
			}
			}
		}
			if(!strQuery1.equalsIgnoreCase(""))
			{
			rs = DBUtils.executeQuery(strQuery1);

			while(rs.next())
			{
				ArrayList arrval =  new ArrayList();
				arrval.add(Helper.correctNull((String)rs.getString("perappname")));//1
				arrval.add(Helper.correctNull((String)rs.getString("perapp_cbsid")));//0
				arrval.add(Helper.correctNull((String)rs.getString("org_name")));//2
				arrval.add(Helper.correctNull((String)rs.getString("perapp_oldid")));//2
				arr.add(arrval);
				
			}
		}
			hshValues.put("arrRow",arr);
			hshValues.put("search",search);
			hshValues.put("val",val);

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getmsmeproposalSearch  "+ce.toString());
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
		
		return hshValues;
	}
	public HashMap getmsmeproposalresult(HashMap hshValues)  {

		 
		ResultSet rs = null;
		ResultSet rs1=null,rs2=null,rs4=null,rs3=null,rs5=null;	
		HashMap hshRecord = new HashMap();
		String strQuery="",status="",strappid="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String strCBSID="";
		String str_statuscompkyc=null;
		String appno="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow1 = new ArrayList();
		String strAppno="",strscode="",strorgname="",strmsmeorgname="",strmsmeusername="",strOrgLevel="";
        String Strnewperappid="";
			
		try
		{			
			
			
			hshRecord = new HashMap();
			strappid = correctNull((String)hshValues.get("hidappid"));	
			strCBSID=correctNull((String)hshValues.get("hidcbsid"));
			String strborrowername=correctNull((String)hshValues.get("hidname"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strscode=correctNull((String)hshValues.get("strOrgShortCode"));
			strorgname=correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel=correctNull((String)hshValues.get("strOrgLevel"));
			String strperappid="";
			if(strAppno.equalsIgnoreCase(""))
				strAppno=correctNull((String)hshValues.get("hidappno"));
			

			if((strappid.equalsIgnoreCase(""))||(strappid.equalsIgnoreCase("undefined")))
			{
				strappid = correctNull((String)hshValues.get("id"));	
			}
			if(!strappid.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strappid);
					
			rs =DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				strCBSID=correctNull(rs.getString("perapp_cbsid"));
				Strnewperappid=correctNull(rs.getString("perapp_id"));
				strborrowername=correctNull(rs.getString("PERAPP_FNAME"));
			}
			}else{
				if(!strAppno.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("sel_msmeApproval^"+strAppno);
					
					rs =DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						strCBSID=correctNull(rs.getString("MSME_CBSID"));
						
					}
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			//strQuery = SQLParser.getSqlQuery("sel_retmispropcbs^"+strappid+"^"+appno);
			/*strQuery = SQLParser.getSqlQuery("sel_retmsmefech^"+strCBSID);
			rs= DBUtils.executeQuery(strQuery);
			while(rs.next()){
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("ProposalNo")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("FacilitySlNo")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("FacilityName")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("Amount")));//3
				arrCol.add(Helper.correctNull((String)rs.getString("ActivityCode")));//4
				
				if(rs1!=null)
				{
				  rs1.close();				  
				}
				rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("app_agriculture")));
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//5
				}
				else
				{
					arrCol.add("");//5	
				}
				
				
				arrCol.add(Helper.correctNull((String)rs.getString("EquipmentValue")));//6
				arrCol.add(Helper.correctNull((String)rs.getString("APP_PLANTVAL")));//7
				arrCol.add(Helper.correctNull((String)rs.getString("StatusOfFacility")));//8
				arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//9
				arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_FNAME")));//10
				arrCol.add(Helper.correctNull((String)rs.getString("perapp_oldid")));//11
				String strSector=Helper.correctNull((String)rs.getString("app_sector"));
				if(strSector.equalsIgnoreCase("01") || strSector.equalsIgnoreCase("1"))
				{					
					arrCol.add("Priority Sector");
				}
				else if(strSector.equalsIgnoreCase("02") || strSector.equalsIgnoreCase("2"))
				{
					arrCol.add("Non Priority Sector");	
				}
				else
				{
					arrCol.add("");	
				}
				if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
					arrCol.add("Yes");
				else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
					arrCol.add("No");
				else
					arrCol.add("");
				
				if(rs1!=null)
				{
				  rs1.close();				  
				}
				rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"23"+"^"+Helper.correctNull((String)rs.getString("APP_GOVTANNOUNCESCHEME")));
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
				}
				else
				{
					arrCol.add("Nil");	
				}
				if(rs1!=null)
				{
				  rs1.close();				  
				}
				arrCol.add(Helper.correctNull((String)rs.getString("APP_PROCESSDATE")));
				arrRow.add(arrCol);
			}
			
*/			String strStatus="",strFlag="";
			if(rs!=null){
				rs.close();
			}
			if(!strAppno.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()){
					strStatus=correctNull((String)rs.getString("MSME_APPSTATUS"));
					strFlag=correctNull((String)rs.getString("MSME_DELETED_FLAG"));
					strperappid=correctNull(rs.getString("MSME_PERAPPID"));
			}}
			if(rs!=null){
				rs.close();
			}
			if(("pa").equalsIgnoreCase(strStatus) || (("op").equalsIgnoreCase(strStatus) && !("Y").equalsIgnoreCase(strFlag) ) 
					|| (("rb").equalsIgnoreCase(strStatus) && !("Y").equalsIgnoreCase(strFlag)) || (("sb").equalsIgnoreCase(strStatus) && !("Y").equalsIgnoreCase(strFlag)) || strAppno.equalsIgnoreCase("")  ){
			if(("pa").equalsIgnoreCase(strStatus))
			strQuery = SQLParser.getSqlQuery("sel_msmeproposalall^"+strAppno);
			else
			strQuery = SQLParser.getSqlQuery("sel_corpandretmsme^"+strCBSID+"^"+strCBSID);

				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()){
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("ProposalNo")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("FacilitySlNo")));//1
					arrCol.add(Helper.correctNull((String)rs.getString("FacilityName")));//2
					arrCol.add(Helper.correctNull((String)rs.getString("Amount")));//3
					arrCol.add(Helper.correctNull((String)rs.getString("ActivityCode")));//4
					if(rs1!=null)
					{
					  rs1.close();				  
					}
					rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("app_agriculture")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//5
					}
					else
					{
						arrCol.add("");//5	
					}
					arrCol.add(Helper.correctNull((String)rs.getString("EquipmentValue")));//6
					arrCol.add(Helper.correctNull((String)rs.getString("APP_PLANTVAL")));//7
					arrCol.add(Helper.correctNull((String)rs.getString("StatusOfFacility")));//8
					if(("pa").equalsIgnoreCase(strStatus)){
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
					}else{
					arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//9
					arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_FNAME")));//10
					arrCol.add(Helper.correctNull((String)rs.getString("perapp_oldid")));//11
					}
					String strSector=Helper.correctNull((String)rs.getString("app_sector"));
					if(strSector.equalsIgnoreCase("01") || strSector.equalsIgnoreCase("1"))
					{					
						arrCol.add("Priority Sector");
					}
					else if(strSector.equalsIgnoreCase("02") || strSector.equalsIgnoreCase("2"))
					{
						arrCol.add("Non Priority Sector");	
					}
					else
					{
						arrCol.add("");
					}
					if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
						arrCol.add("Yes");
					else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
						arrCol.add("No");
					else
						arrCol.add("");
					
					if(rs1!=null)
					{
					  rs1.close();				  
					}
					rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"23"+"^"+Helper.correctNull((String)rs.getString("APP_GOVTANNOUNCESCHEME")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
					}
					else
					{
						arrCol.add("Nil");	
					}
					if(rs1!=null)
					{
					  rs1.close();				  
					}
					arrCol.add(Helper.correctNull((String)rs.getString("APP_PROCESSDATE")));
					arrRow.add(arrCol);
				}}
				if(rs!=null){
					rs.close();
				}
				if(!strAppno.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
	
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						hshRecord.put("MSME_SALES_TURNOVER", Helper.correctNull((String)rs.getString("MSME_SALES_TURNOVER")));
						hshRecord.put("MSME_SALES_DATE", Helper.correctNull((String)rs.getString("MSME_SALES_DATE")));
						hshRecord.put("MSME_CRITERIA_SALES", Helper.correctNull((String)rs.getString("MSME_CRITERIA_SALES")));
						hshRecord.put("MSME_EQUIP_VAL", Helper.correctNull((String)rs.getString("MSME_EQUIP_VAL")));
						hshRecord.put("MSME_CLASSI_DATE", Helper.correctNull((String)rs.getString("MSME_CLASSI_DATE")));
						hshRecord.put("MSME_ORGCODE", Helper.correctNull((String)rs.getString("MSME_ORGCODE")));
						hshRecord.put("MSME_INITIATE_FLAG", Helper.correctNull((String)rs.getString("MSME_INITIATE_FLAG")));
						hshRecord.put("MSME_APPROVEDBY", Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")));
						hshRecord.put("MSME_ORGSCODE", Helper.correctNull((String)rs.getString("MSME_ORGSCODE")));
						hshRecord.put("MSME_APPNO", Helper.correctNull((String)rs.getString("MSME_APPNO")));
						hshRecord.put("MSME_CREATED_BY", Helper.correctNull((String)rs.getString("MSME_CREATED_BY")));
						hshRecord.put("MSME_APPSTATUS", Helper.correctNull((String)rs.getString("MSME_APPSTATUS")));
						hshRecord.put("msme_remarks", Helper.correctNull((String)rs.getString("msme_remarks")));
						hshRecord.put("MSME_REJECT_REMARKS", Helper.correctNull((String)rs.getString("MSME_REJECT_REMARKS")));
						
						hshRecord.put("MSME_INVESTMENT_DATE", Helper.correctNull((String)rs.getString("MSME_INVESTMENT_DATE")));
						hshRecord.put("MSME_CRITERIA_INVESTMENT", Helper.correctNull((String)rs.getString("MSME_CRITERIA_INVESTMENT")));
						hshRecord.put("MSME_DELETED_FLAG", Helper.correctNull((String)rs.getString("MSME_DELETED_FLAG")));
												if(rs2!=null)
						{
							rs2.close();
						}
						String rev_remarks="";
						strQuery = SQLParser.getSqlQuery("sel_msmeremarks^"+strAppno);
						rs2= DBUtils.executeQuery(strQuery);
						while(rs2.next()){
							String flag=Helper.correctNull((String)rs2.getString("MSME_FALG"));
							String cus_id= Helper.correctNull((String)rs2.getString("MSME_USRID"));
							String remarks= Helper.correctNull((String)rs2.getString("MSME_REMARKS"));
							String date=Helper.correctNull((String)rs2.getString("MSME_ACTIONDATE"));
							String action=Helper.correctNull((String)rs2.getString("MSME_FALG"));
							if((!("").equals(remarks) && ("revert").equalsIgnoreCase(flag)) || (!("").equals(remarks) && ("verified").equalsIgnoreCase(flag)) || (!("").equals(remarks) && ("rejected").equalsIgnoreCase(flag) || ("rollback").equalsIgnoreCase(flag) ) ){
							rev_remarks=rev_remarks+"User ID: "+cus_id +" Remarks: "+remarks+" Action: "+action +" Date: "+date +"\n";
							}
						}
						hshRecord.put("MSME_REVERT_REMARKS", Helper.correctNull(rev_remarks));

						
						String strorgscode=Helper.correctNull((String)rs.getString("MSME_ORGSCODE"));
						if(!strorgscode.equals(""))
						{
							if(correctNull((String)hshValues.get("strOrgShortCode")).equals(strorgscode))
							{
							hshRecord.put("strpropmodificationchk", "Y");

							}
							else
							{
								hshRecord.put("strpropmodificationchk", "N");

							}
							
						}
						strQuery = SQLParser.getSqlQuery("sel_msmeorgtemp^"+strAppno);
						
						rs4 = DBUtils.executeQuery(strQuery);
						if(rs4.next()){
							hshRecord.put("msmeorgsocde", Helper.correctNull((String)rs4.getString("ORG_SCODE")));
							hshRecord.put("msmeorgname", Helper.correctNull((String)rs4.getString("ORG_NAME")));
						}
						if(rs3!=null){
							rs3.close();
						}if(rs5!=null){
							rs5.close();
						}
						strQuery = SQLParser.getSqlQuery("sel_msmeorgval^"+Helper.correctNull((String)rs.getString("MSME_ApprovedOrg")));
						rs3 = DBUtils.executeQuery(strQuery);
						if(rs3.next()){
							strmsmeorgname=Helper.correctNull((String)rs3.getString("ORG_NAME"));
						}
						strQuery = SQLParser.getSqlQuery("selectusername^"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")));
						rs5 = DBUtils.executeQuery(strQuery);
						if(rs5.next()){
							strmsmeusername=Helper.correctNull((String)rs5.getString("name"));
						}
						if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (correctNull((String)rs.getString("MSME_INITIATE_FLAG")).equalsIgnoreCase("Y")&&(Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase(""))))
							hshRecord.put("strstatus","Sent for Verification"+"-( " +strmsmeorgname+")");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("rb") &&correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			hshRecord.put("strstatus","Revert Back");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("sb") &&correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			hshRecord.put("strstatus","Roll Back");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("pa") && correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			hshRecord.put("strstatus","Processed/Approved");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("pr")&&correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			hshRecord.put("strstatus","Processed/Rejected");
				 		else if(correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y"))
				 			hshRecord.put("strstatus","Deleted");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (!Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase("")))
				 			hshRecord.put("strstatus","Verification Pending with "+"-"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY"))+"-"+strmsmeusername);
				 		else
				 			hshRecord.put("strstatus","Open/Pending");//9
					}
					
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_msmenewpropsearch^"+strCBSID);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next()){
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("ProposalNo")));//0
						arrCol.add(Helper.correctNull((String)rs.getString("FacilitySlNo")));//1
						arrCol.add(Helper.correctNull((String)rs.getString("Amount")));//2
						arrCol.add(Helper.correctNull((String)rs.getString("MSME_SALES_DATE")));//3
						arrCol.add(Helper.correctNull((String)rs.getString("MSME_CRITERIA_SALES")));//4
						arrCol.add(Helper.correctNull((String)rs.getString("EquipmentValue")));//5
						arrCol.add(Helper.correctNull((String)rs.getString("MSME_CLASSI_DATE")));//6
						//arrCol.add(Helper.correctNull((String)rs.getString("StatusOfFacility")));//7
						strQuery = SQLParser.getSqlQuery("sel_msmeorgval^"+Helper.correctNull((String)rs.getString("MSME_ApprovedOrg")));
						rs3 = DBUtils.executeQuery(strQuery);
						if(rs3.next()){
							strmsmeorgname=Helper.correctNull((String)rs3.getString("ORG_NAME"));
						}
						strQuery = SQLParser.getSqlQuery("selectusername^"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")));
						rs5 = DBUtils.executeQuery(strQuery);
						if(rs5.next()){
							strmsmeusername=Helper.correctNull((String)rs5.getString("name"));
						}
						if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (correctNull((String)rs.getString("MSME_INITIATE_FLAG")).equalsIgnoreCase("Y")&&(Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase(""))))
							arrCol.add("Sent for Verification"+"-( " +strmsmeorgname+")");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("rb")&&correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			arrCol.add("Revert Back");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("sb")&&correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			arrCol.add("Roll Back");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("pa") && correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			arrCol.add("Processed/Approved");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("pr") && correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
				 			arrCol.add("Processed/Rejected");
				 		else if(correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y"))
				 			arrCol.add("Deleted");
				 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (!Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase("")))
							arrCol.add("Verification Pending with "+"-"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY"))+"-"+strmsmeusername);
				 		else
				 			arrCol.add("Open/Pending");//9
						hshRecord.put("strmsmestatus",correctNull((String)rs.getString("MSME_APPSTATUS")));
						if(Helper.correctNull((String)rs.getString("StatusOfFacility")).equalsIgnoreCase("Open/Pending")&&(!Helper.correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y")))
						{
							hshRecord.put("strPendingFlag","Y");
						}
						String strorgscode=Helper.correctNull((String)rs.getString("MSME_ORGSCODE"));
						if(!strorgscode.equals(""))
						{
							if(correctNull((String)hshValues.get("strOrgShortCode")).equals(strorgscode))
							{
								arrCol.add("Y");
								arrCol.add(strorgscode);
							}
							else
							{
								arrCol.add("N");	
								arrCol.add(strorgscode);
							}
							
						}
						if(Helper.correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y"))
						{
							hshRecord.put("strdeletingFlag","Y");
						}
						if(rs4!=null){
							rs4.close();
						}
                        strQuery = SQLParser.getSqlQuery("sel_msmeorgtemp^"+Helper.correctNull((String)rs.getString("ProposalNo")));
						
						rs4 = DBUtils.executeQuery(strQuery);
						if(rs4.next()){
							hshRecord.put("msmeorgsocde", Helper.correctNull((String)rs4.getString("ORG_SCODE")));
							hshRecord.put("msmeorgname", Helper.correctNull((String)rs4.getString("ORG_NAME")));
							arrCol.add(Helper.correctNull((String)rs4.getString("ORG_NAME")));//7

						}else{
							arrCol.add("");//7

						}
						arrRow1.add(arrCol);
					}
					
				}
				String strMSMEMinpower="";
				if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^M"+Helper.correctNull((String)hshValues.get("strUserDepartment")));
				else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("R"))
					strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M006");
				else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
					strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M005");
				else 
					strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M004");
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 	if(rs.next())
			 	{
			 		hshRecord.put("strMSMEMinpower", Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
			 		strMSMEMinpower=Helper.correctNull(rs.getString("LOAN_PARAMVAL"));

			 	}
				
				hshRecord.put("strMSMEMinpower", strMSMEMinpower);

				hshRecord.put("arrRow", arrRow);
				hshRecord.put("arrRow1", arrRow1);
				hshRecord.put("strborrowername", strborrowername);
				hshRecord.put("strCBSID", strCBSID);
				hshRecord.put("strappid", strappid);
				hshRecord.put("strscode", strscode);
				hshRecord.put("strorgname", strorgname);
                hshRecord.put("Strnewperappid", Strnewperappid);
		System.out.println("***************************Strnewperappid********************************"+Strnewperappid);
		System.out.println("***************************Stroldperappid********************************"+strappid);
		System.out.println("********************************strQuery**********************************"+strQuery);
			if(rs1 != null)
			{rs1.close();}
			if(!strAppno.equalsIgnoreCase(""))
			{
			 strQuery=SQLParser.getSqlQuery("sel_perm_documentdetails_postsanc^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				String strmsmedoccheck="N";
				while(rs.next())
				{
					strmsmedoccheck="Y";
				}
				hshRecord.put("strmsmedoccheck", strmsmedoccheck);
				hshRecord.put("appno", strAppno);
			
			}
			if(rs != null)
			{rs.close();}
			if(!strappid.equalsIgnoreCase("")){
				if(!("").equalsIgnoreCase(strperappid) ){
					Strnewperappid=strperappid;
				}

			rs=DBUtils.executeLAPSQuery("sel_common_customer^"+Strnewperappid);				 
			if(rs.next())
			{
				hshRecord.put("majority_member",Helper.correctNull(rs.getString("COMINFO_MAJORITYMEMBER")));
				hshRecord.put("stake_held",Helper.correctNull(rs.getString("perapp_stakeheld_women")));
				hshRecord.put("constitutionnew",Helper.correctNull((String)rs.getString("perapp_constitutionnew")));
				hshRecord.put("indinfo_caste",Helper.correctNull((String)rs.getString("indinfo_caste")));
				hshRecord.put("perapp_sex",Helper.correctNull((String)rs.getString("perapp_sex")));
				hshRecord.put("strempasondate",Helper.correctNull((String)rs.getString("cominfo_employees_asondate")));
				hshRecord.put("strtotalemp",Helper.correctNull((String)rs.getString("cominfo_total_employees")));
				hshRecord.put("COMINFO_GSTINREG",Helper.correctNull((String)rs.getString("COMINFO_GSTINREG")));
				hshRecord.put("COMINFO_GST_EXEMPTED",Helper.correctNull((String)rs.getString("COMINFO_GST_EXEMPTED")));
				hshRecord.put("indinfo_minority",Helper.correctNull((String)rs.getString("indinfo_minority")));
				hshRecord.put("PERAPP_UDYAM_REGNO",Helper.correctNull((String)rs.getString("PERAPP_UDYAM_REGNO")));
				hshRecord.put("PERAPP_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER")));
				hshRecord.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER_DATE")));
				hshRecord.put("PERAPP_CRITERIA_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_CRITERIA_SALES_TURNOVER")));
				hshRecord.put("cominfo_minority_community",Helper.correctNull((String)rs.getString("cominfo_minority_community")));
				hshRecord.put("indinfo_religion",Helper.correctNull((String)rs.getString("indinfo_religion")));
				hshRecord.put("perapp_religion",Helper.correctNull((String)rs.getString("perapp_religion")));
				
			}
		}
			boolean boolappstatus=false;
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+Strnewperappid);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
			
			if(!boolappstatus)
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp^"+Strnewperappid);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
			}
			if(!boolappstatus)
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp_cooapp^"+Strnewperappid);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
			}
			if(!boolappstatus)
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_processAppl_solvency_newid^"+Strnewperappid);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
			}
			if(!boolappstatus)
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_processAppl_kpower_newid^"+Strnewperappid);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
			}
			if(!boolappstatus)
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_processApplmsmenewid^"+Strnewperappid);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
			}
			MastApplicantBean mb=new MastApplicantBean(); 
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",Strnewperappid);
			profile=(HashMap)mb.getCustomerProfileStatus(prof);
			
			String strProfilestatus="";
			hshRecord.put("appstatus",""+boolappstatus);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+Strnewperappid);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			}
			hshRecord.put("strProfilestatus",strProfilestatus);
			
			String noproposal="";
			if(("A").equals(strOrgLevel)){
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("getloandisbranch^"+strCBSID+"^"+strscode+"^"+strCBSID+"^"+strscode);
				if(rs.next())
				{
					noproposal="Y";
				}else{
					noproposal="N";
				}
			}
			hshRecord.put("strnoproposal",noproposal);
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
	public String getMSMEPROPSEQ(HashMap hshValues)
	{
		String strOrgShortCode="";
		ResultSet rs=null;
		String strAppno="";
		long longAppno=0;
		String strQuery="",strExp="$";
		int intLen=0;
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(6);
		nf.setGroupingUsed(false);
		try
		{	
			
			strOrgShortCode=strSolid;
			strOrgShortCode = strOrgShortCode.trim();
			int scodeLength=strOrgShortCode.length();
			if(strOrgShortCode.equals(""))
			{
				strExp =strExp + "There is no organisation attached with user";
				throw new Exception(strExp);
			}
			else{
				if(scodeLength==1){
					strOrgShortCode="000"+strOrgShortCode;
				}
				if(scodeLength==2){
					strOrgShortCode="00"+strOrgShortCode;
				}
				if(scodeLength==3){
					strOrgShortCode="0"+strOrgShortCode;
				}
			}
			intLen=strOrgShortCode.length();
			strQuery=SQLParser.getSqlQuery("getMSMEAppno^"+(intLen+2)+"^"+intLen+"^"+strOrgShortCode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				longAppno=(rs.getLong(1));
			}
			longAppno++;
			strAppno=strOrgShortCode+"M"+nf.format(longAppno);
			
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getMSMEPROPSEQ "+ce.toString());
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
		return strAppno;
	}
	public HashMap updatemsmeproposal(HashMap hshRequestValues)  {

		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null,rs1 = null;
		String strQuery = "";
		String appno="",strSno="",Strnewperappid="";		
		String strAppid = correctNull((String) hshRequestValues.get("hidDemoId"));
		String strAction = correctNull((String) hshRequestValues.get("hidAction"));
		String strUserId=correctNull((String) hshRequestValues.get("strUserId"));
		String strCBSID="";
		strCBSID=Helper.correctNull((String) hshRequestValues.get("hidCBSID"));
	    if(strCBSID.equalsIgnoreCase("")){
	    strCBSID=Helper.correctNull((String) hshRequestValues.get("hidcbsid"));
	    }
	    if(strAppid.equalsIgnoreCase("")){
	    	strAppid = correctNull((String) hshRequestValues.get("hidappid"));
	    	
	    }
		String strorgname="",strorgscode="";
		strorgname=correctNull((String)hshRequestValues.get("strOrgName"));
		appno=correctNull((String) hshRequestValues.get("hidappno"));

		try {
			if(!strAppid.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strAppid);
						
				rs =DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strCBSID=correctNull(rs.getString("perapp_cbsid"));
					Strnewperappid=correctNull(rs.getString("perapp_id"));
				}
				}
			// MSME DETAILS
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				if(appno.equalsIgnoreCase(""))
				{
					hshQuery.put("strQueryId", "ins_msmedetails");
					appno=getMSMEPROPSEQ(hshRequestValues);
					arrValues.add(appno);
					arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnover")));
					arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnoverdate")));
					arrValues.add(correctNull((String) hshRequestValues.get("hidsel_sales_turnover")));
					arrValues.add(correctNull((String) hshRequestValues.get("txt_equipval")));
					arrValues.add(Helper.correctNull((String) hshRequestValues.get("txt_effdate")));
					arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
					arrValues.add(strCBSID);
					arrValues.add(correctNull((String) hshRequestValues.get("strUserDepartment")));
					arrValues.add(correctNull((String) hshRequestValues.get("strOrgShortCode")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_investDate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_criteria_invest")));
					arrValues.add(Strnewperappid);
					arrValues.add("op");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}
				else
				{
					hshQuery.put("strQueryId", "upd_msmedetails");
					arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnover")));
					arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnoverdate")));
					arrValues.add(correctNull((String) hshRequestValues.get("hidsel_sales_turnover")));
					arrValues.add(correctNull((String) hshRequestValues.get("txt_equipval")));
					arrValues.add(Helper.correctNull((String) hshRequestValues.get("txt_effdate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_investDate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_criteria_invest")));
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_msmehisdetails");
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnover")));
				arrValues.add(correctNull((String) hshRequestValues.get("hid_sales_turnoverdate")));
				arrValues.add(correctNull((String) hshRequestValues.get("hidsel_sales_turnover")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_equipval")));
				arrValues.add(Helper.correctNull((String) hshRequestValues.get("txt_effdate")));
				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String) hshRequestValues.get("strOrgCode")));
				arrValues.add(strCBSID);
				arrValues.add(strorgname);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_investDate")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_criteria_invest")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			
			if (strAction.equalsIgnoreCase("Initiate")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "update_msmeappdetails");
				arrValues.add("Y");
				arrValues.add("op");
				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String) hshRequestValues.get("hid_Branch")));
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "update_msmeappdetailsdeletion");
				arrValues.add("Y");
				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
				
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			
			hshRequestValues.put("appno", appno);
			hshQueryValues=getmsmeproposalresult(hshRequestValues);
			
			
			
		} catch (Exception e1) {
			log.error(e1.toString());
			throw new EJBException("Error closing in updatemsmeproposal"
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing in updatemsmeproposal"
						+ cf.getMessage());
			}
		}
		return hshQueryValues;
}
	 public HashMap updateMsmeApproval(HashMap hshRequestValues){
	    	ResultSet rs=null,rs1=null,rs2=null,rs4=null,rs3=null,rs6=null,rs5=null,rs7=null,rs8=null;
	    	HashMap hshResult=new HashMap();
	    	HashMap hshQueryValues=new HashMap();
	    	HashMap hshQuery=new HashMap();
	    	HashMap hshMap=new HashMap();
	    	HashMap hshValues=new HashMap();
	    	HashMap hshPriority=new HashMap();
	    	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);
			nf.setGroupingUsed(false);
			ArrayList arrValues=new ArrayList();
	    	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
	    	String strUserID=Helper.correctNull((String)hshRequestValues.get("strUserId"));
	    	String strAppno=Helper.correctNull((String)hshRequestValues.get("hidappno"));
	    	String strQuery="",strExcep="";
	    	StringBuilder strBuff=new StringBuilder();
	    	boolean bFlag=true;
	    	
			MastApplicantBean MAB=new MastApplicantBean();
	    	HashMap hshQueryValuesmsme=new HashMap();
	    	String strAppOldID="";
	    	HashMap hshQueryValuesmsme1=new HashMap();
	    	HashMap hshQueryValuesmsme2=new HashMap();
	    	HashMap hshQueryValuesmsme3=new HashMap();
	    	
	    	try
	    	{
	    		if(strAction.equalsIgnoreCase("receive"))
				{
	    			hshQueryValues.put("size","1");
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strUserID);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_msme_receiveflag");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				} 
	    		else if(strAction.equalsIgnoreCase("revert"))
				{
	    			String msme_createdID="";
					
	    			hshQueryValues.put("size","1");
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("");
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_msme_revert");
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "msme_reverthisdata");
					arrValues.add(strAppno);
					arrValues.add(strUserID);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strOrgCode")));
					strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
					arrValues.add(Helper.correctNull((String)rs.getString("MSME_INITIATEDON")));
					msme_createdID=Helper.correctNull((String)rs.getString("MSME_CREATED_BY"));
					}else{
					arrValues.add("");
					}
					arrValues.add("revert");
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size", "2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				} 
	    		else if(strAction.equalsIgnoreCase("rollback"))
				{
	    			
					
	    			hshQueryValues.put("size","1");
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_msme_rollback");
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "msme_reverthisdata");
					arrValues.add(strAppno);
					arrValues.add(strUserID);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strOrgCode")));
					strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
					arrValues.add(Helper.correctNull((String)rs.getString("MSME_INITIATEDON")));
					}else{
					arrValues.add("");
					}
					arrValues.add("rollback");
					arrValues.add("");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size", "2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				} 
	    		
	    		else if(strAction.equalsIgnoreCase("approve"))
	    		{
	    			
	    			if(rs!=null)
	    				rs.close();
	    			rs = DBUtils.executeLAPSQuery("selMSMEapprovecheck^"+Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
	    			if(rs.next()) 
	    			{
	    				if(Integer.parseInt(Helper.correctInt(rs.getString("datediff")))<0)
	    				{
	    					bFlag=false;
	    					strExcep=strExcep+"Effective Date validation expired.";
							throw new Exception(strExcep);
	    				}
	    			}
	    			
	    			int hshqrySize=1;
	    			
	    			/*hshQueryValues.put("size",String.valueOf(hshqrySize));
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("pa");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
					arrValues.add(correctNull((String) hshRequestValues.get("strOrgShortCode")));
					arrValues.add(correctNull((String) hshRequestValues.get("strUserDepartment")));
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_msme_approveflag");
					hshQueryValues.put(String.valueOf(hshqrySize),hshQuery);*/	
					
	    			
	    			rs1=DBUtils.executeLAPSQuery("sel_msmedetails^"+strAppno);
	    			if(rs1.next())
	    			{
	    				rs=DBUtils.executeLAPSQuery("sel_msmeproposals_new^"+Helper.correctNull(rs1.getString("MSME_CBSID"))+"^"+Helper.correctNull(rs1.getString("MSME_CBSID")));
	    				while(rs.next())
	    				{
	    					StringBuilder sbActionData=new StringBuilder();
	    					StringBuilder sbOldAudit=new StringBuilder();
	    					String strProcessedDate=Helper.correctNull(rs.getString("APP_PROCESSDATE"));
	    					String strActivityCode="",strSector="",strSubSector="",strSensitiveSector="",strAgriculture="",strGovtAnnounced="",strStandupIndia="",strDispScreen="",strweakersection="";
	    					String strtwintypgm="";
	    					String strinfrastrcuture="",str_classification_sno="";
	    					double dblTotLimold=0.00,dblTotLimAgrold=0.00,dblTotLimSerold=0.00,dblTotSocialInfraold=0.00,dblTotAgriAnciold=0.00,dblTotRenewEnergyold=0.00,dblTotRenewEnergyIndvold=0.00,dblAgriInfraold=0.00;
	    					if(rs2!=null)
	    						rs2.close();
	    					rs2=DBUtils.executeLAPSQuery("sel_misclassification^"+Helper.correctNull(rs.getString("APP_NO"))+"^"+Helper.correctNull(rs.getString("FacilitySlNo")));
	    					if(rs2.next())
	    					{
	    						strActivityCode=Helper.correctNull(rs2.getString("app_activitycode"));
	    						strSector=Helper.correctNull(rs2.getString("APP_SECTOR"));
	    						strSubSector=Helper.correctNull(rs2.getString("APP_SUBSECTOR"));
	    						strSensitiveSector=Helper.correctNull(rs2.getString("APP_SENSITIVESECTOR"));
	    						strAgriculture=Helper.correctNull(rs2.getString("APP_AGRICULTURE"));
	    						strGovtAnnounced=Helper.correctNull(rs2.getString("APP_GOVTANNOUNCESCHEME"));
	    						strStandupIndia=Helper.correctNull(rs2.getString("APP_STANDUP_INDIA"));//
	    						strDispScreen=Helper.correctNull(rs2.getString("app_dispscreen"));
	    						strweakersection=Helper.correctNull(rs2.getString("APP_WEAKERSEC"));
	    						strinfrastrcuture=Helper.correctNull(rs2.getString("APP_INFRASTRCODE"));
	    						str_classification_sno=Helper.correctNull(rs2.getString("APP_MISMASTER_SNO"));
	    						 strtwintypgm=Helper.correctNull(rs2.getString("APP_TWENTYPOINTPGM"));
	    					}
	    					
	    					rs5=DBUtils.executeLAPSQuery("sel_misappdetails^"+Helper.correctNull(rs.getString("APP_NO"))+"^"+Helper.correctNull(rs.getString("FacilitySlNo")));
	    					if(rs5.next())
	    					{
	    						dblTotLimold=Double.parseDouble(Helper.correctDouble((String)rs5.getString("app_totlim")));
	    						dblTotLimSerold=Double.parseDouble(Helper.correctDouble((String)rs5.getString("app_totlimser")));
	    						dblTotLimAgrold=Double.parseDouble(Helper.correctDouble((String)rs5.getString("app_totlimagri")));
	    					}
	    					
	    					rs7=DBUtils.executeLAPSQuery("sel_misappdisplayscreen^"+Helper.correctNull(rs.getString("APP_NO"))+"^"+Helper.correctNull(rs.getString("FacilitySlNo")));
	    					if(rs7.next())
	    					{
	    						dblTotSocialInfraold=Double.parseDouble(Helper.correctDouble((String)rs7.getString("APP_SOCIALINFRA")));
	    						dblTotAgriAnciold=Double.parseDouble(Helper.correctDouble((String)rs7.getString("APP_AGRIANCIACTIVITY")));
	    						dblTotRenewEnergyold=Double.parseDouble(Helper.correctDouble((String)rs7.getString("APP_RENEWENERGY")));
	    						dblTotRenewEnergyIndvold=Double.parseDouble(Helper.correctDouble((String)rs7.getString("APP_RENEWENERGY_INDV")));
	    						dblAgriInfraold=Double.parseDouble(Helper.correctDouble((String)rs7.getString("APP_AGRIINFRA")));
	    						
	    					}
	    					if(rs4!=null){
    							rs4.close();
    						}
    						rs4 = DBUtils.executeLAPSQuery("sel_activitydescription^"+ strActivityCode);
    						if (rs4.next()) {
    							strDispScreen=Helper.correctNull(rs4.getString("ACT_DISPLAYSCREEN"));
    						}

	    					String strGovernmentDesc=MAB.getMasterDesc("MISMast", "23", strGovtAnnounced);
	    					String strWeakerSectionDesc=MAB.getMasterDesc("MISMast","09",strweakersection);

	    					String strStandupIndiaDesc="";
	    					if(strStandupIndia.equalsIgnoreCase("Y"))
	    						strStandupIndiaDesc="Yes";
	    					else if(strStandupIndia.equalsIgnoreCase("N"))
	    						strStandupIndiaDesc="No";
	    					else
	    						strStandupIndiaDesc="Select";
	    					
	    					String strSectorDesc="";
	    					if(strSector.equalsIgnoreCase("01"))
	    					{
	    						strSectorDesc="Priority Sector";
	    					}
	    					else if(strSector.equalsIgnoreCase("02"))
	    					{
	    						strSectorDesc="Non Priority Sector";
	    					}
	    					String strSubSectorDesc=MAB.getMasterDesc("MISMast","7",strSubSector);
	    					if(strSubSectorDesc.equalsIgnoreCase(""))
	    					{
	    						strSubSectorDesc=MAB.getMasterDesc("MISMast","8",strSubSector);
	    					}
	    					String strCatTypeDesc=MAB.getMasterDesc("MISMast", "12", strAgriculture);
	    					String strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",strSensitiveSector);
	    					String strWeakerSectionDesc1=MAB.getMasterDesc("MISMast","09",strweakersection);
	    					String strTwentyPointPgmDesc=MAB.getMasterDesc("MISMast","10",strtwintypgm);
	    					sbOldAudit.append("~Agriculture/Industry/Service Category type = ").append(strCatTypeDesc)
	    					.append("~Sector = ").append(strSectorDesc)
	    					.append("~Sub Sector = ").append(strSubSectorDesc)
	    					.append("~Sensitive sector = ").append(strSensitiveSectorDesc)
	    					.append("~Weaker Section = ").append(strWeakerSectionDesc1)
	    					.append("~Twenty Point Program = ").append(strTwentyPointPgmDesc)
	    					.append("~Infrastructure Credit Type = ").append(strinfrastrcuture)
	    					.append("~Government announced scheme = ").append(strGovernmentDesc)// New
	    					.append("~StandUp India = ").append(strStandupIndiaDesc);
	    					/*if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("op")){*/
	    					HashMap hshQueryDetails=new HashMap();
	    					//hshqrySize++;
	    					//hshQueryValues.put("size",Integer.toString(hshqrySize));
	    					hshQuery=new HashMap();
	    					arrValues=new ArrayList();
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_SALES_TURNOVER")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_SALES_DATE")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CRITERIA_SALES")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CLASSI_DATE")));
	    					arrValues.add(Helper.getCurrentDateTime());
	    					if(strDispScreen.contains("fixedinvestment"))
	    						arrValues.add(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
	    					else
	    						arrValues.add(Helper.correctNull(rs.getString("EquipmentValue")));
	    					if(strDispScreen.contains("industry"))
		    					arrValues.add(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
		    				else
		    					arrValues.add(Helper.correctNull(rs.getString("APP_PLANTVAL")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_INVESTMENT_DATE")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CRITERIA_INVESTMENT")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
	    					arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
	    					hshQuery.put("arrValues", arrValues);				
	    					hshQuery.put("strQueryId","upd_mis_appdisplayscreen");
	    					hshQueryDetails.put("1", hshQuery);
	    					hshQueryDetails.put("size","1");
	    					EJBInvoker.executeStateLess("dataaccess", hshQueryDetails, "updateData");
	    					 
	    					
	    					
	    					
	    					 
	    					
	    					sbOldAudit.append("~Sales Turnover of the Applicant=").append(Helper.correctDouble((String)rs1.getString("MSME_SALES_TURNOVER")));
	    					
	    					sbOldAudit.append("~Sales Turnover As on Date=").append(Helper.correctNull(rs1.getString("MSME_SALES_DATE")));
	    					
	    						String strcriteriasales="";
	    						if(rs4!=null){
	    							rs4.close();
	    						}
	    						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^243^"+ Helper.correctNull((String)rs1.getString("MSME_CRITERIA_SALES")));
	    						if (rs4.next()) {
	    							strcriteriasales=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
	    						}
	    					sbOldAudit.append("~Criteria for Sales Turnover=").append(strcriteriasales);
	    					
	    					sbOldAudit.append("~New Classification date=").append(Helper.correctNull(rs1.getString("MSME_CLASSI_DATE")));
	    					if(strDispScreen.contains("fixedinvestment")){
	    					sbOldAudit.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
	    					}else{
		    					sbOldAudit.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs.getString("EquipmentValue")));

	    					}
	    					if(strDispScreen.contains("industry")){
		    					sbOldAudit.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
		    					}else{
			    					sbOldAudit.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs.getString("APP_PLANTVAL")));

		    					}	
	    					sbOldAudit.append("~Facility Sno=").append(Helper.correctNull(rs.getString("FacilitySlNo")));
	    					strQuery=SQLParser.getSqlQuery("select_perappoldid^"+Helper.correctNull(rs.getString("perapp_id")));
	    	    			rs6=DBUtils.executeQuery(strQuery);
	    	    			if(rs6.next())
	    	    			{
	    	    				strAppOldID=Helper.correctNull((String)rs6.getString("perapp_oldid"));
	    	    			}
	    	    			
	    					hshMap=new HashMap();
	    					hshMap.put("appno", Helper.correctNull(rs.getString("APP_NO")));
	    					hshMap.put("sel_facilitysno", Helper.correctNull(rs.getString("FacilitySlNo")));
	    					hshMap.put("apploantype", Helper.correctNull(rs.getString("app_loantype")));
	    					hshMap.put("hidapplicantnewid", Helper.correctNull(rs.getString("perapp_id")));
	    					//hshMap.put("strClassifyBasedOn", Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
	    					//hshMap.put("strReclassify", "Y");
	    					MisBean MB=new MisBean();
	    					//hshMap=MB.getMISDetails(hshMap);
	    					
	    					if(Helper.correctNull(rs.getString("app_loantype")).equalsIgnoreCase("P"))
	    					{
	    						strQuery=SQLParser.getSqlQuery("selLoanAmt^"+Helper.correctNull(rs.getString("APP_NO")));
	    						MISLogger.UpdateLogger(strQuery);
	    						rs2=DBUtils.executeQuery(strQuery);
	    						if(rs2.next())
	    						{
	    							hshMap.put("strLoanAmt",Helper.correctDouble(rs2.getString("loanamt")));
	    							hshMap.put("strReqTerms",Helper.correctInt(rs2.getString("LOAN_REQTERMS")));
	    						}
								sbOldAudit.append("~Loan Amount=").append(Helper.correctDouble(rs2.getString("loanamt")));

	    						if(rs2!=null)
	    						{
	    							rs2.close();
	    						}
	    						strQuery=SQLParser.getSqlQuery("securesel^"+Helper.correctNull(rs.getString("APP_NO")));
	    						rs2=DBUtils.executeQuery(strQuery);
	    						if(rs2.next())
	    						{
	    							hshMap.put("strHOLIDAYPERIOD",Helper.correctInt(rs2.getString("LOAN_NOOFINSTALLMENT")));
	    						}

	    					}
	    					else
	    					{
	    						strQuery=SQLParser.getSqlQuery("sel_proposedLimit^"+Helper.correctNull(rs.getString("APP_NO"))+"^"+Helper.correctNull(rs.getString("FacilitySlNo")));
	    						MISLogger.UpdateLogger(strQuery);
	    						rs2=DBUtils.executeQuery(strQuery);
	    						if(rs2.next())
	    						{
	    							hshMap.put("strLoanAmt",Helper.correctDouble(rs2.getString("facility_proposed")));
	    							hshMap.put("strReqTerms",Helper.correctInt(rs2.getString("facility_months")));
	    							hshMap.put("strHOLIDAYPERIOD",Helper.correctNull(rs2.getString("FACILITY_HOLIDAYPERIOD")));
	    						}
								sbOldAudit.append("~Loan Amount=").append(Helper.correctDouble(rs2.getString("facility_proposed")));

	    					}
	    					String strPriorityType="",strPrioritySubsector="",strWeakerSectionSubSector="",strAgriIndConfig="",strTwentyPointPgm="",strInfracode="",strGovtAnnounceScheme="",strClassiMaster_Sno="",strStandUpIndia="";
	    					double dblTotLim=0.00,dblTotLimAgr=0.00,dblTotLimSer=0.00,dblTotSocialInfra=0.00,dblTotAgriAnci=0.00,dblTotRenewEnergy=0.00,dblTotRenewEnergyIndv=0.00,dblAgriInfra=0.00;
							String strAppValuesin="";
	    					{
	    						
	    						/***********************/
	    						
	    						
    							
    							
    							//if(rs !=null){rs.close();}
    							strQuery=SQLParser.getSqlQuery("getagrvaluesin^"+Helper.correctNull(rs.getString("APP_NO")));
    							MISLogger.UpdateLogger(strQuery);
    							rs3=DBUtils.executeQuery(strQuery);
    							if(rs3.next())
    							{
    								strAppValuesin=Helper.correctNull((String)rs3.getString("app_valuesin"));
    							}
    							
    							if(("").equalsIgnoreCase(strProcessedDate)){
    								strProcessedDate=Helper.correctNull(rs1.getString("MSME_CLASSI_DATE"));
    							}
    							dblTotLim=getBorrowerTotalLimit(Helper.correctNull(rs.getString("perapp_id")),strAppValuesin,strProcessedDate,strAppno);
    							dblTotLimAgr=getBorrowerTotalAgriLimit(Helper.correctNull(rs.getString("perapp_id")),strAppValuesin,Helper.correctNull(rs.getString("APP_NO")),strProcessedDate);
    							dblTotLimSer=getBorrowerTotalServiceLimit(Helper.correctNull(rs.getString("perapp_id")),strAppValuesin,Helper.correctNull(rs.getString("APP_NO")),strProcessedDate);
    							
    							dblTotSocialInfra = getClassiActivityMasterSum(Helper.correctNull(rs.getString("perapp_id")),"MIS_SOCIAL_INFRA","",Helper.correctNull(rs.getString("APP_NO")));
    							dblTotAgriAnci = getClassiActivityMasterSum(Helper.correctNull(rs.getString("perapp_id")),"MIS_AGRI_ANCI_ACTIVITY","1",Helper.correctNull(rs.getString("APP_NO")));
    							dblTotRenewEnergy = getClassiActivityMasterSum(Helper.correctNull(rs.getString("perapp_id")),"MIS_RENEW_ENERGY","",Helper.correctNull(rs.getString("APP_NO")));
    							dblTotRenewEnergyIndv = getClassiActivityMasterSum(Helper.correctNull(rs.getString("perapp_id")),"MIS_RENEW_ENERGY_INDV","",Helper.correctNull(rs.getString("APP_NO")));
    							dblAgriInfra = getClassiActivityMasterSum(Helper.correctNull(rs.getString("perapp_id")),"MIS_AGRI_INFRA","2",Helper.correctNull(rs.getString("APP_NO")));
    							sbOldAudit.append("~Total Limit of the Borrower=").append(nf.format((dblTotLim)))
    							.append("~Total Limit of the Borrower(Under Service Category)=").append(nf.format((dblTotLimSer)))
    							.append("~Total Limit of the Borrower(Under Agriculture Category)=").append(nf.format((dblTotLimAgr)));
    							 /*if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("op")){*/
    							hshQueryValuesmsme2=new HashMap();
    							hshQueryValuesmsme2.put("size","1");
    							hshQuery = new HashMap();
    							arrValues=new ArrayList();
    							hshQuery.put("strQueryId","upd_agrservlimit1");
    							arrValues.add(Helper.roundVal((String.valueOf(dblTotLim))));
    							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimAgr))));
    							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimSer))));
    							arrValues.add(strDispScreen);
    							
    							arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
    							arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
    							hshQuery.put("arrValues",arrValues);
    							hshQueryValuesmsme2.put("1",hshQuery);
    							EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme2,"updateData");
    							

    							hshQueryValuesmsme3=new HashMap();
    							hshQueryValuesmsme3.put("size","1");
    							hshQuery = new HashMap();
    							arrValues=new ArrayList();
    							hshQuery.put("strQueryId","upd_classiActivityList");
    							arrValues.add(String.valueOf(dblTotSocialInfra));
    							arrValues.add(String.valueOf(dblTotAgriAnci));
    							arrValues.add(String.valueOf(dblTotRenewEnergy));
    							arrValues.add(String.valueOf(dblTotRenewEnergyIndv));
    							arrValues.add(String.valueOf(dblAgriInfra));
    							arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
    							arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
    							hshQuery.put("arrValues",arrValues);
    							hshQueryValuesmsme3.put("1",hshQuery);
    							EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme3,"updateData");
    							/* }*/
	    						/***********************/

	    						
	    						
	    						hshValues.put("strFacilitySno",Helper.correctNull(rs.getString("FacilitySlNo")));
	    						hshValues.put("strLoanAmt",Helper.correctNull((String)hshMap.get("strLoanAmt")));
	    						hshValues.put("strHOLIDAYPERIOD",Helper.correctNull((String)hshMap.get("strHOLIDAYPERIOD")));
	    						hshValues.put("strReqTerms",Helper.correctNull((String)hshMap.get("strReqTerms")));
	    						hshValues.put("strReclassification","Y");
	    						hshValues.put("strReclassifDate",Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
	    						hshValues.put("strappno",Helper.correctNull(rs.getString("APP_NO")));
	    						hshValues.put("strAppID",Helper.correctNull(rs.getString("perapp_id")));
	    						hshValues.put("hidapplicantnewid",Helper.correctNull(rs.getString("perapp_id")));
	    						hshValues.put("hidapplicantid",strAppOldID);
	    						hshValues.put("strClassiMaster_Sno",str_classification_sno);
	    						
	    						
	    						hshPriority=(HashMap)MB.getMISAppClassification(hshValues);
	    						 strPriorityType=Helper.correctNull((String)hshPriority.get("prioritytype"));
	    						 strPrioritySubsector=Helper.correctNull((String)hshPriority.get("subsector"));
	    						 strWeakerSectionSubSector=Helper.correctNull((String)hshPriority.get("strWeakerSectionSubSector"));
	    						 strAgriIndConfig=Helper.correctNull((String)hshPriority.get("strAgriIndConfig"));
	    						 strTwentyPointPgm=Helper.correctNull((String)hshPriority.get("strTwentyPointPgm"));
	    						 strSensitiveSector=Helper.correctNull((String)hshPriority.get("strSensitiveSector"));
	    						 strInfracode=Helper.correctNull((String)hshPriority.get("strInfracode"));
	    						 strGovtAnnounceScheme=Helper.correctNull((String)hshPriority.get("strGovtAnnounceScheme"));
	    						 strClassiMaster_Sno=Helper.correctNull((String)hshPriority.get("strClassiMaster_Sno"));
	    						 strStandUpIndia=Helper.correctNull((String)hshPriority.get("strStandUpIndia"));
	    						 /*if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("op")){*/
	    						 hshQueryValuesmsme1=new HashMap();
	    						 hshQueryValuesmsme1.put("size","1");
		    						hshQuery = new HashMap();
		    						arrValues=new ArrayList();
		    						hshQuery.put("strQueryId","del_misappclassification");
		    						arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
		    						arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
		    						hshQuery.put("arrValues",arrValues);
		    						hshQueryValuesmsme1.put("1",hshQuery);
		    						EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme1,"updateData");
		    					    
		    						String gvtScheme="23/04/2015",standUp="05/04/2015";
		    						if(!("").equalsIgnoreCase(strProcessedDate)){
	    								 String Pattern="dd/MM/yyyy";
	    									DateFormat df=new SimpleDateFormat(Pattern);
	    									Date appprocessedDate=df.parse(strProcessedDate);
	    									Date gvtSchemedate=df.parse(gvtScheme);
	    									Date standUpdate=df.parse(standUp);

	    									if(appprocessedDate.before(gvtSchemedate) )
	    									{
	    										strGovtAnnounceScheme="";	
	    									}
	    									if(appprocessedDate.before(standUpdate) )
	    									{
	    										strStandUpIndia="";	
	    									}
	    						       }
	    								
	    						 hshQueryValuesmsme=new HashMap();
	    						 hshQueryValuesmsme.put("size","1");
	    							arrValues=new ArrayList();
	    							hshQuery = new HashMap();
	    							hshQuery.put("strQueryId","ins_misappclassification");
	    							arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
	    							arrValues.add(strAgriculture);
	    							arrValues.add(strPriorityType);
	    							arrValues.add(strPrioritySubsector);
	    							arrValues.add(strSensitiveSector);
	    							arrValues.add(strWeakerSectionSubSector);
	    							arrValues.add(strTwentyPointPgm);
	    							arrValues.add(strInfracode);	    							
	    							arrValues.add(strGovtAnnounceScheme);
	    							arrValues.add(strClassiMaster_Sno);
	    							arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
	    							arrValues.add(strStandUpIndia);
	    							hshQuery.put("arrValues",arrValues);
	    							hshQueryValuesmsme.put("1",hshQuery);
	    							EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme,"updateData");
	    							
	    						 
	    						
	    					}
	    					hshQueryValuesmsme2=new HashMap();
							hshQueryValuesmsme2.put("size","1");
	    					hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_misappdetailsclass");							
	    					
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidsel_minority")));
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidsel_religion")));
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidsel_firm_minority")));
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidsel_corp_religion")));
							
							arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
							arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValuesmsme2.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme2,"updateData");
	    					
							hshQueryValuesmsme2=new HashMap();
							hshQueryValuesmsme2.put("size","1");
	    					hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_misapp_classification");							
							arrValues.add(Helper.correctNull((String)hshPriority.get("strAgriIndConfig")));							
							arrValues.add(Helper.correctNull((String)hshPriority.get("prioritytype")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("subsector")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strSensitiveSector")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strWeakerSectionSubSector")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strTwentyPointPgm")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strInfracode")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strGovtAnnounceScheme")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strClassiMaster_Sno")));
							arrValues.add(Helper.correctNull((String)hshPriority.get("strStandUpIndia")));
							
							arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
							arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValuesmsme2.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValuesmsme2,"updateData");
	    					
							
	    					hshQueryValues.put("size",String.valueOf(hshqrySize));
	    					hshQuery=new HashMap();
	    					arrValues=new ArrayList();
	    					arrValues.add("pa");
	    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
	    					arrValues.add(correctNull((String) hshRequestValues.get("strOrgCode")));
	    					arrValues.add(correctNull((String) hshRequestValues.get("strUserDepartment")));
	    					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
	    					arrValues.add(strAppno);
	    					hshQuery.put("arrValues", arrValues);				
	    					hshQuery.put("strQueryId","upd_msme_approveflag");
	    					hshQueryValues.put(String.valueOf(hshqrySize),hshQuery);
	    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    					
	    					
	    					hshqrySize++;
	    					hshQueryValues.put("size",Integer.toString(hshqrySize));
	    					hshQuery=new HashMap();
	    					arrValues=new ArrayList();
	    					arrValues.add(strAppno);
	    					arrValues.add(Helper.correctNull(rs.getString("APP_NO")));
	    					arrValues.add(Helper.correctNull(rs.getString("FacilitySlNo")));
	    					if(strDispScreen.contains("fixedinvestment"))
	    						arrValues.add(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
	    					else
	    						arrValues.add(Helper.correctNull(rs.getString("EquipmentValue")));
	    					if(strDispScreen.contains("industry"))
		    					arrValues.add(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
		    				else
		    					arrValues.add(Helper.correctNull(rs.getString("APP_PLANTVAL")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_SALES_TURNOVER")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_SALES_DATE")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CRITERIA_SALES")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CLASSI_DATE")));
	    					arrValues.add(Helper.correctNull(rs.getString("EquipmentValue")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_PLANTVAL")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_SALETURNOVER")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_SALESTURNOVER_DATE")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_CRITERIA_SALESTURNOVER")));
	    					
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("prioritytype")));
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("subsector")));
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strSensitiveSector")));
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strGovtAnnounceScheme")));
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strStandUpIndia")));
	    					
	    					arrValues.add(strSector);
	    					arrValues.add(strSubSector);
	    					arrValues.add(strSensitiveSector);
	    					arrValues.add(strGovtAnnounced);
	    					arrValues.add(strStandupIndia);
	    					arrValues.add(strActivityCode);
	    					arrValues.add(strAgriculture);
	    					arrValues.add(strActivityCode);
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strAgriIndConfig")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_INVESTMENT_DATE")));
	    					arrValues.add(Helper.correctNull(rs1.getString("MSME_CRITERIA_INVESTMENT")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_INVESTMENT_DATE")));
	    					arrValues.add(Helper.correctNull(rs.getString("APP_CRITERIA_INVESTMENT")));
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strWeakerSectionSubSector")));
	    					arrValues.add(strweakersection);
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strTwentyPointPgm")));	    					
	    					arrValues.add(strTwentyPointPgm);
	    					arrValues.add(Helper.correctNull((String)hshPriority.get("strInfracode")));
							arrValues.add(strInfracode);
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLim))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimSer))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimAgr))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimSerold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotLimAgrold))));
							
							arrValues.add(Helper.roundVal((String.valueOf(dblTotSocialInfra))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotAgriAnci))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotRenewEnergy))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotRenewEnergyIndv))));
							arrValues.add(Helper.roundVal((String.valueOf(dblAgriInfra))));
							
							arrValues.add(Helper.roundVal((String.valueOf(dblTotSocialInfraold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotAgriAnciold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotRenewEnergyold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblTotRenewEnergyIndvold))));
							arrValues.add(Helper.roundVal((String.valueOf(dblAgriInfraold))));
							
							if(rs8!=null){
    							rs8.close();
    						}
							rs8 = DBUtils.executeLAPSQuery("sel_corp_msmedetails^"+Helper.correctNull(rs.getString("APP_NO"))+"^"+Helper.correctNull(rs.getString("FacilitySlNo")) );
    						if (rs8.next()) {
    							arrValues.add(Helper.roundVal(rs8.getString("AMOUNT")));
    							arrValues.add(Helper.correctNull(rs8.getString("PRD_DESC")));
    							arrValues.add(Helper.correctNull(rs8.getString("APP_STATUS")));
    							arrValues.add(Helper.correctNull(rs8.getString("APP_PROCESSDATE")));
    							
    						}else{
    							if(rs8!=null){
        							rs8.close();
        						}
    							rs8 = DBUtils.executeLAPSQuery("sel_retail_msmedetails^"+Helper.correctNull(rs.getString("APP_NO")) );
        						if (rs8.next()) {
        							arrValues.add(Helper.roundVal(rs8.getString("AMOUNT")));
        							arrValues.add(Helper.correctNull(rs8.getString("PRD_DESC")));
        							arrValues.add(Helper.correctNull(rs8.getString("APP_STATUS")));
        							arrValues.add(Helper.correctNull(rs8.getString("APP_PROCESSDATE")));
        							
        							
        							
        						}
        						else{
        							arrValues.add("");
        							arrValues.add("");
        							arrValues.add("");
        							arrValues.add("");
        						}
    						}
    						
	    					hshQuery.put("arrValues", arrValues);				
	    					hshQuery.put("strQueryId","ins_msme_proposalupdate");
	    					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
	    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    					
	    					strGovernmentDesc=MAB.getMasterDesc("MISMast", "23",strGovtAnnounced);
	    					if(strStandupIndia.equalsIgnoreCase("Y"))
	    						strStandupIndia="Yes";
	    					else if(strStandupIndia.equalsIgnoreCase("N"))
	    						strStandupIndia="No";
	    					else
	    						strStandupIndia="Select";
	    					
	    					 strSectorDesc="";
	    					if(strSector.equalsIgnoreCase("01"))
	    					{
	    						strSectorDesc="Priority Sector";
	    					}
	    					else if(strSector.equalsIgnoreCase("02"))
	    					{
	    						strSectorDesc="Non Priority Sector";
	    					}
	    					 strSubSectorDesc=MAB.getMasterDesc("MISMast","7",strSubSector);
	    					if(strSubSectorDesc.equalsIgnoreCase(""))
	    					{
	    						strSubSectorDesc=MAB.getMasterDesc("MISMast","8",strSubSector);
	    					}
	    					 strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",strSensitiveSector);
	    						String strWeakerSectionDescnew=MAB.getMasterDesc("MISMast","09",strweakersection);
	    						String strTwentyPointPgmDesc1=MAB.getMasterDesc("MISMast","10",strTwentyPointPgm);
	    					 sbActionData.append("~Activity Code=").append(strActivityCode).append("~sector=").append(strSectorDesc)
		    					.append("~Sub Sector=").append(strSubSectorDesc)
		    					.append("~Sensitive Sector=").append(strSensitiveSectorDesc)
		    					.append("~Government announced scheme = ").append(strGovernmentDesc)
						        .append("~Standup India = ").append(strStandupIndia);
	    					 sbActionData.append("~Sales Turnover of the Applicant=").append(Helper.correctNull(rs1.getString("MSME_SALES_TURNOVER")));
		    					
	    					 sbActionData.append("~Sales Turnover As on Date=").append(Helper.correctNull(rs1.getString("MSME_SALES_DATE")));
		    					
		    						if(rs4!=null){
		    							rs4.close();
		    						}
		    						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^243^"+ Helper.correctNull((String)rs1.getString("MSME_CRITERIA_SALES")));
		    						if (rs4.next()) {
		    							strcriteriasales=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
		    						}
		    						sbActionData.append("~Criteria for Sales Turnover=").append(strcriteriasales);
		    					
		    						sbActionData.append("~New Classification date=").append(Helper.correctNull(rs1.getString("MSME_CLASSI_DATE")));
		    					if(strDispScreen.contains("fixedinvestment")){
		    						sbActionData.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
		    					}else{
		    						sbActionData.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs.getString("EquipmentValue")));

		    					}
		    					if(strDispScreen.contains("industry")){
		    						sbActionData.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs1.getString("MSME_EQUIP_VAL")));
			    					}else{
			    						sbActionData.append("~ Investment in Plant & Machineries/Equipments=").append(Helper.correctNull(rs.getString("APP_PLANTVAL")));

			    					}
		    					 sbActionData.append("~weaker section =").append(strTwentyPointPgmDesc1).
		    					 append("~Twenty Point Program = ").append(strTwentyPointPgmDesc).append("~Total Limit of the Borrower=").append(dblTotLim)
		    						.append("~Total Limit of the Borrower(Under Service Category)=").append(dblTotLimSer)
		    						.append("~Total Limit of the Borrower(Under Agriculture Category)=").append(dblTotLimAgr)
		    						;
		    					sbActionData.append("~Facility Sno=").append(Helper.correctNull(rs.getString("FacilitySlNo")));
		    					AuditTrial.auditNewLog1(hshRequestValues,"232",Helper.correctNull(rs.getString("APP_NO")),sbActionData.toString(),sbOldAudit.toString(),Helper.correctNull(rs.getString("FacilitySlNo")));	

		    					MISLogger.UpdateLogger("Audit Table:::::::::::::::::::::::PAGE ID=232:::::::::::: Application No:"+strAppno+" Action ="+Helper.correctNull((String)hshRequestValues.get("hidAction"))+" Old Values==="+sbOldAudit.toString()+"===New Values ===="+sbActionData.toString());
		    					
		    					
	    				}
	    				hshQuery=new HashMap();
    					arrValues=new ArrayList();
    					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidperappid")));
    					arrValues.add(strAppno);
    					
    					hshQuery.put("arrValues", arrValues);				
    					hshQuery.put("strQueryId","upd_perappmsme");
    					hshQueryValues.put("1", hshQuery);
    					hshQueryValues.put("size","1");
    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    			}
	    			
	    			hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "msme_reverthisdata");
					arrValues.add(strAppno);
					arrValues.add(strUserID);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strOrgCode")));
					strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
					arrValues.add(Helper.correctNull((String)rs.getString("MSME_INITIATEDON")));
					}else{
					arrValues.add("");
					}
					arrValues.add("verified");
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
					
	    		} 
	    		else if(strAction.equalsIgnoreCase("reject"))
	    		{
	    			int hshqrySize=1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("pr");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_effdate")));
					arrValues.add(correctNull((String) hshRequestValues.get("strOrgCode")));
					arrValues.add(correctNull((String) hshRequestValues.get("strUserDepartment")));
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_msme_rejectflag");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "msme_reverthisdata");
					arrValues.add(strAppno);
					arrValues.add(strUserID);
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("strOrgCode")));
					strQuery = SQLParser.getSqlQuery("sel_msmedetails^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
					arrValues.add(Helper.correctNull((String)rs.getString("MSME_INITIATEDON")));
					}else{
					arrValues.add("");
					}
					arrValues.add("rejected");
					arrValues.add(correctNull((String) hshRequestValues.get("txt_remarks")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size", "2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
					
				}	
					
	    		

	    			return hshResult;
	        		
	    		}
	    	catch(Exception e)
	    	{
	    		System.out.println("*************msme existing proposal update************"+e.toString());
				throw new EJBException(e.getMessage());
				
			}
	    	finally
	    	{
	    		try{ 			
	    			hshResult=getMsmeApproval(hshRequestValues);
	    			if(bFlag)
	    			{
		        		if(strAction.equalsIgnoreCase("revert"))
		        		{
		        			hshResult.put("strStatus","Revert");
		        		}
		        		if(strAction.equalsIgnoreCase("approve"))
		        		{
		        			hshResult.put("strStatus","Approve");
		        		}
		        		if(strAction.equalsIgnoreCase("reject"))
		        		{
		        			hshResult.put("strStatus","Reject");
		        		}
		        		if(strAction.equalsIgnoreCase("rollback"))
		        		{
		        			hshResult.put("strStatus","rollback");
		        		}
		        		
		        		
	    			}
	    			else
	    			{
	    				hshResult.put("strError",strExcep);
	    			}
	    			
	    			return hshResult;
	        		
	    		}
	    		catch(Exception ce)
	    		{
	    			
	    		}
	    	}
	    	}
	   public HashMap getMsmeApproval(HashMap hshRequestValues)
	    {
	    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
	    	
	    	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs5=null;
	    	String strQuery="",strUserID="", strappno=null,strAction="",strCBSID="",strmsmeorgname="",strmsmeusername="";
	    	strappno = Helper.correctNull((String)hshRequestValues.get("hidappno"));
	    	strUserID = Helper.correctNull((String)hshRequestValues.get("strUserId"));
	    	strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
	    	ArrayList arrCol=new ArrayList();
	    	ArrayList arrRow=new ArrayList();
	    	String strinitiateflag = Helper.correctNull((String)hshRequestValues.get("strinitiate"));	
	    	String Strnewperappid="",strappid="",strborrowername="";
	    	strappid = correctNull((String)hshRequestValues.get("hidappid"));
	    	String perappid="";
	    	try
	    	{
		    	strQuery=SQLParser.getSqlQuery("sel_msmeApproval^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRequestValues.put("MSME_SALES_TURNOVER",(Helper.correctNull(rs.getString("MSME_SALES_TURNOVER"))));//0
					hshRequestValues.put("MSME_SALES_DATE",correctNull(rs.getString("MSME_SALES_DATE")));//1
					hshRequestValues.put("MSME_CRITERIA_SALES",Helper.correctNull(rs.getString("MSME_CRITERIA_SALES")));//2
					hshRequestValues.put("MSME_EQUIP_VAL",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MSME_EQUIP_VAL")))));//3
					hshRequestValues.put("MSME_CLASSI_DATE",correctNull(rs.getString("MSME_CLASSI_DATE")));//4
					hshRequestValues.put("MSME_CREATED_BY",Helper.correctNull(rs.getString("MSME_CREATED_BY")));//5
					hshRequestValues.put("MSME_APPROVEDBY",Helper.correctNull(rs.getString("MSME_APPROVEDBY")));//6
					hshRequestValues.put("strRemarks",Helper.correctNull(rs.getString("msme_remarks")));//6
					if(!Helper.correctNull(rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase("")&& Helper.correctNull(rs.getString("MSME_APPROVEDBY")).equals(strUserID))
						hshRequestValues.put("strapproveflag","Y");//7
					else
						hshRequestValues.put("strapproveflag","N");//8
					
					strCBSID=Helper.correctNull(rs.getString("MSME_CBSID"));
					hshRequestValues.put("strCBSID",Helper.correctNull(rs.getString("MSME_CBSID")));
					perappid=Helper.correctNull(rs.getString("MSME_PERAPPID"));
					if(rs2!=null)
					{
						rs2.close();
					}
					String rev_remarks="";
					strQuery = SQLParser.getSqlQuery("sel_msmeremarks^"+strappno);
					rs2= DBUtils.executeQuery(strQuery);
					while(rs2.next()){
						String flag=Helper.correctNull((String)rs2.getString("MSME_FALG"));
						String cus_id= Helper.correctNull((String)rs2.getString("MSME_USRID"));
						String remarks= Helper.correctNull((String)rs2.getString("MSME_REMARKS"));
						String date=Helper.correctNull((String)rs2.getString("MSME_ACTIONDATE"));
						String action=Helper.correctNull((String)rs2.getString("MSME_FALG"));
						if((!("").equals(remarks) && ("revert").equalsIgnoreCase(flag)) || (!("").equals(remarks) && ("verified").equalsIgnoreCase(flag)) || (!("").equals(remarks) && ("rejected").equalsIgnoreCase(flag) || ("rollback").equalsIgnoreCase(flag) ) ){
						rev_remarks=rev_remarks+"User ID: "+cus_id +" Remarks: "+remarks+" Action: "+action +" Date: "+date +"\n";
						}
					}
					hshRequestValues.put("strComments",Helper.correctNull(rev_remarks));//6
					
					if(rs1!=null)
						rs1.close();
					
					rs1=DBUtils.executeLAPSQuery("sel_lapsidfromcbsid^"+strCBSID);
					if(rs1.next())
					{
						hshRequestValues.put("strBorrowerName",Helper.correctNull(rs1.getString("perapp_fname")));
					}
					
					if(rs1!=null)
						rs1.close();
					
					rs1=DBUtils.executeLAPSQuery("setorgselectapp^"+Helper.correctNull(rs.getString("MSME_ORGSCODE")));
					if(rs1.next())
					{
						hshRequestValues.put("strCROrgName",Helper.correctNull(rs1.getString("org_name")));
						
						hshRequestValues.put("strBRName",Helper.correctNull(rs.getString("MSME_ORGSCODE"))+"-"+Helper.correctNull(rs1.getString("org_name")));
					}
					
					hshRequestValues.put("MSME_INVESTMENT_DATE", Helper.correctNull((String)rs.getString("MSME_INVESTMENT_DATE")));
					hshRequestValues.put("MSME_CRITERIA_INVESTMENT", Helper.correctNull((String)rs.getString("MSME_CRITERIA_INVESTMENT")));
					if(rs3!=null){
			 			rs3.close();
			 		}
			 		strQuery = SQLParser.getSqlQuery("sel_msmeorgval^"+Helper.correctNull((String)rs.getString("MSME_ApprovedOrg")));
					rs3 = DBUtils.executeQuery(strQuery);
					if(rs3.next()){
						strmsmeorgname=Helper.correctNull((String)rs3.getString("ORG_NAME"));
					}
					strQuery = SQLParser.getSqlQuery("selectusername^"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next()){
						strmsmeusername=Helper.correctNull((String)rs5.getString("name"));
					}
					if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (correctNull((String)rs.getString("MSME_INITIATE_FLAG")).equalsIgnoreCase("Y")&&(Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase(""))))
						hshRequestValues.put("strstatus","Sent for Verification"+"-( " +strmsmeorgname+")");

			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("rb"))
			 			hshRequestValues.put("strstatus","Revert Back");
			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("sb"))
			 			hshRequestValues.put("strstatus","Roll Back");
			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (!Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase("")))
			 			hshRequestValues.put("strstatus","Verification Pending with "+"-"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY"))+"-"+strmsmeusername);
			 		else if(correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y"))
			 			hshRequestValues.put("strstatus","Deleted");
			 		else
			 			hshRequestValues.put("strstatus","Open/Pending");
				}
				
				if(!strCBSID.equalsIgnoreCase(""))
				{
					/*strQuery = SQLParser.getSqlQuery("sel_retmsmefech^"+strCBSID);
					rs= DBUtils.executeQuery(strQuery);
					while(rs.next()){
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("ProposalNo")));//0
						arrCol.add(Helper.correctNull((String)rs.getString("FacilitySlNo")));//1
						arrCol.add(Helper.correctNull((String)rs.getString("FacilityName")));//2
						arrCol.add(Helper.correctNull((String)rs.getString("Amount")));//3
						arrCol.add(Helper.correctNull((String)rs.getString("ActivityCode")));//4
						
						if(rs1!=null)
						{
						  rs1.close();				  
						}
						rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("app_agriculture")));
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//5
						}
						else
						{
							arrCol.add("");//5	
						}
						
						
						arrCol.add(Helper.correctNull((String)rs.getString("EquipmentValue")));//6
						arrCol.add(Helper.correctNull((String)rs.getString("APP_PLANTVAL")));//7
						arrCol.add(Helper.correctNull((String)rs.getString("StatusOfFacility")));//8
						arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//9
						arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_FNAME")));//10
						arrCol.add(Helper.correctNull((String)rs.getString("perapp_oldid")));//11
						String strSector=Helper.correctNull((String)rs.getString("app_sector"));
						if(strSector.equalsIgnoreCase("01") || strSector.equalsIgnoreCase("1"))
						{					
							arrCol.add("Priority Sector");
						}
						else if(strSector.equalsIgnoreCase("02") || strSector.equalsIgnoreCase("2"))
						{
							arrCol.add("Non Priority Sector");	
						}
						else{
							arrCol.add("");
						}
						if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
							arrCol.add("Yes");
						else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
							arrCol.add("No");
						else
							arrCol.add("");
						
						if(rs1!=null)
						{
						  rs1.close();				  
						}
						rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"23"+"^"+Helper.correctNull((String)rs.getString("APP_GOVTANNOUNCESCHEME")));
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
						}
						else
						{
							arrCol.add("Nil");	
						}
						if(rs1!=null)
						{
						  rs1.close();				  
						}
						arrCol.add(Helper.correctNull((String)rs.getString("APP_PROCESSDATE")));
						arrRow.add(arrCol);
					}
					*/if(rs!=null){
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_corpandretmsme^"+strCBSID+"^"+strCBSID);

						rs = DBUtils.executeQuery(strQuery);
						while(rs.next()){
							arrCol = new ArrayList();
							arrCol.add(Helper.correctNull((String)rs.getString("ProposalNo")));//0
							arrCol.add(Helper.correctNull((String)rs.getString("FacilitySlNo")));//1
							arrCol.add(Helper.correctNull((String)rs.getString("FacilityName")));//2
							arrCol.add(Helper.correctNull((String)rs.getString("Amount")));//3
							arrCol.add(Helper.correctNull((String)rs.getString("ActivityCode")));//4
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("app_agriculture")));
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));//5
							}
							else
							{
								arrCol.add("");//5	
							}
							arrCol.add(Helper.correctNull((String)rs.getString("EquipmentValue")));//6
							arrCol.add(Helper.correctNull((String)rs.getString("APP_PLANTVAL")));//7
							arrCol.add(Helper.correctNull((String)rs.getString("StatusOfFacility")));//8
							arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//9
							arrCol.add(Helper.correctNull((String)rs.getString("PERAPP_FNAME")));//10
							arrCol.add(Helper.correctNull((String)rs.getString("perapp_oldid")));//11
							String strSector=Helper.correctNull((String)rs.getString("app_sector"));
							if(strSector.equalsIgnoreCase("01") || strSector.equalsIgnoreCase("1"))
							{					
								arrCol.add("Priority Sector");
							}
							else if(strSector.equalsIgnoreCase("02") || strSector.equalsIgnoreCase("2"))
							{
								arrCol.add("Non Priority Sector");	
							}
							else{
								arrCol.add("");
							}
							if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
								arrCol.add("Yes");
							else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
								arrCol.add("No");
							else
								arrCol.add("");
							
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"23"+"^"+Helper.correctNull((String)rs.getString("APP_GOVTANNOUNCESCHEME")));
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
							}
							else
							{
								arrCol.add("Nil");	
							}
							if(rs1!=null)
							{
							  rs1.close();				  
							}
							arrCol.add(Helper.correctNull((String)rs.getString("APP_PROCESSDATE")));
							arrRow.add(arrCol);
						}
						hshRequestValues.put("arrRow", arrRow);
				}
				if(!strappid.equalsIgnoreCase("")){
					strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strappid);
							
					rs =DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						strCBSID=correctNull(rs.getString("perapp_cbsid"));
						Strnewperappid=correctNull(rs.getString("perapp_id"));
						strborrowername=correctNull(rs.getString("PERAPP_FNAME"));
					}
					if(rs != null)
					{rs.close();}
				

					rs=DBUtils.executeLAPSQuery("sel_common_customer^"+perappid);				 
					if(rs.next())
					{
						hshRequestValues.put("majority_member",Helper.correctNull(rs.getString("COMINFO_MAJORITYMEMBER")));
						hshRequestValues.put("stake_held",Helper.correctNull(rs.getString("perapp_stakeheld_women")));
						hshRequestValues.put("constitutionnew",Helper.correctNull((String)rs.getString("perapp_constitutionnew")));
						hshRequestValues.put("indinfo_caste",Helper.correctNull((String)rs.getString("indinfo_caste")));
						hshRequestValues.put("perapp_sex",Helper.correctNull((String)rs.getString("perapp_sex")));
						hshRequestValues.put("strempasondate",Helper.correctNull((String)rs.getString("cominfo_employees_asondate")));
						hshRequestValues.put("strtotalemp",Helper.correctNull((String)rs.getString("cominfo_total_employees")));
						hshRequestValues.put("COMINFO_GSTINREG",Helper.correctNull((String)rs.getString("COMINFO_GSTINREG")));
						hshRequestValues.put("COMINFO_GST_EXEMPTED",Helper.correctNull((String)rs.getString("COMINFO_GST_EXEMPTED")));
						hshRequestValues.put("indinfo_minority",Helper.correctNull((String)rs.getString("indinfo_minority")));
						hshRequestValues.put("PERAPP_UDYAM_REGNO",Helper.correctNull((String)rs.getString("PERAPP_UDYAM_REGNO")));
						hshRequestValues.put("PERAPP_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER")));
						hshRequestValues.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER_DATE")));
						hshRequestValues.put("PERAPP_CRITERIA_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_CRITERIA_SALES_TURNOVER")));
						hshRequestValues.put("cominfo_minority_community",Helper.correctNull((String)rs.getString("cominfo_minority_community")));
						hshRequestValues.put("indinfo_religion",Helper.correctNull((String)rs.getString("indinfo_religion")));
						hshRequestValues.put("perapp_religion",Helper.correctNull((String)rs.getString("perapp_religion")));
						
					}
					hshRequestValues.put("Strnewperappid1", perappid);
					
					}
				log.info("<<<<<<<<<<<<===============arrRow=================>>>>>>>>>>"+arrRow);
				hshRequestValues.put("strinitiateflag", strinitiateflag);
				
	    	}
	    	catch(Exception e)
	    	{
				throw new EJBException("Error in getMsmeApproval "+e.toString());
			}
	    	finally
	    	{
	    		try
	    		{
	    			if(rs!=null)
	    				rs.close();
	    		}
	    		catch(Exception ef)
	    		{
	    			throw new EJBException("Error in getMsmeApproval "+ef.getMessage());
	    			
	    		}     		
	    	}
	    	return hshRequestValues;
	    }
	   private double getBorrowerTotalLimit(String strAppID, String strValuesin,String strAppDate,String strAppno) 
   	{
   		ResultSet rs=null;
   		String strQuery="";
   		String strTotalLimit="";
   		String strAppOldID="";
   		String desc="",appstatus="";
   		double dblTotAmount=0.00;
   		try
   		{
   			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
   			rs=DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
   			}
   			if(!strAppOldID.equalsIgnoreCase(""))
   			{
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				log.info("strAppno========>>>>>>>" + strAppno);
   				strQuery = SQLParser.getSqlQuery("getagrvaluesin^"+strAppno);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					appstatus=Helper.correctNull((String)rs.getString("app_status"));
   					log.info("appstatus==========="+appstatus);
   				}
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				
   				if(appstatus.equalsIgnoreCase("pa") || appstatus.equalsIgnoreCase("ca"))
   					desc="APP_PROCESSDATE";
   				else
   					desc="APP_CREATEDATE";
   				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimit1^"+strAppOldID+"^"+desc+"^"+strAppDate);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("seltotliability1^"+strAppOldID+"^"+desc);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   			}
   				strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
   		}
   		catch(Exception ce)
   		{
   			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
   		return Double.parseDouble(strTotalLimit);
   	}
   	private double getBorrowerTotalAgriLimit(String strAppID, String strValuesin,String strAppno,String strAppDate) 
   	{
   		ResultSet rs=null;
   		String strQuery="";
   		String strTotalLimit="";
   		String strAppOldID="";
   		String strAgriCode="'1','2','26','27','28'";
   		double dblTotAmount=0.00;
   		String appprocessDate="",appstatus="";
		String desc="";
   		try
   		{
   			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
   			rs=DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
   			}
   			if(!strAppOldID.equalsIgnoreCase(""))
   			{
   				if(rs!=null)
				{
					rs.close();
				}
   			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				appstatus=Helper.correctNull((String)rs.getString("app_status"));
				if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
				{
					appprocessDate=strAppDate;
				}
				else
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
				}
			}
			desc="and APP_CREATEDATE <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				
   				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimitagr_agri1^"+strAppOldID+"^"+strAgriCode+"^"+desc);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=Double.parseDouble((String)Helper.correctDouble("0"));
   				}
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("seltotagriliability_agri1^"+strAppOldID+"^"+strAgriCode+"^"+desc);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   			}
   			strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
   		}
   		catch(Exception ce)
   		{
   			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
   		return Double.parseDouble(strTotalLimit);
   	}
   	private double getBorrowerTotalServiceLimit(String strAppID, String strValuesin,String strAppno,String AppDate) 
   	{
   		ResultSet rs=null;
   		String strQuery="";
   		String strTotalLimit="";
   		String strAppOldID="";
   		String strAgriCode="'11','12','14','15','18','19','20','21','26','27','28','29'";
   		double dblTotAmount=0.00;
   		String appprocessDate="",appstatus="";
		String desc="";
   		try
   		{
   			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
   			rs=DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
   			}
   			if(rs!=null)
				{
					rs.close();
				}
   			strQuery=SQLParser.getSqlQuery("sel_productcode^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				appstatus=Helper.correctNull((String)rs.getString("app_status"));
				if(Helper.correctNull((String)rs.getString("app_status")).equals("op")||Helper.correctNull((String)rs.getString("app_status")).equals("ol"))
				{
					appprocessDate=AppDate;
				}
				else
				{
					appprocessDate=Helper.correctNull((String)rs.getString("app_processdate"));	
				}
			}
			desc="and APP_CREATEDATE <=(to_date('"+appprocessDate+"','dd/mm/yyyy')+1)";
   			if(!strAppOldID.equalsIgnoreCase(""))
   			{
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("sel_borrowertotallimitagr_serv1^"+strAppOldID+"^"+strAgriCode+"^"+desc);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("seltotagriliability_serv1^"+strAppOldID+"^"+strAgriCode+"^"+desc);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotAmount=dblTotAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   			}
   			strTotalLimit=Helper.convertSetupToApplicationValues(strValuesin,dblTotAmount);
   		}
   		catch(Exception ce)
   		{
   			throw new EJBException("Error in getBorrowerTotalLimit "+ce.toString());
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
   		return Double.parseDouble(strTotalLimit);
   	}
   	private double getClassiActivityMasterSum(String strAppID, String strType, String strPurpose,String strAppNo) throws Exception
   	{
   		String strQuery = "";
   		ResultSet rs = null;
   		String strAppOldID="";
   		String strActivityList="";
   		 
   		double dblTotalAmount = 0.00;
   		try
   		{
   			strQuery = SQLParser.getSqlQuery("sel_classi_activity_master^"+strType);
   			rs = DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				StringTokenizer st = new StringTokenizer(Helper.correctNull((String)rs.getString(1)),"@");
   				while(st.hasMoreElements())
   				{
   					if(strActivityList.equalsIgnoreCase(""))
   						strActivityList = "'"+(String)st.nextElement()+"'";
   					else
   						strActivityList = strActivityList+",'"+(String)st.nextElement()+"'";
   				}
   			}
   			
   			if(rs!=null) rs.close();
   			
   			strQuery=SQLParser.getSqlQuery("select_perappoldid^"+strAppID);
   			rs=DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
   			}
   			
   			if(!strAppOldID.equalsIgnoreCase("") && !strActivityList.equalsIgnoreCase(""))
   			{
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("sel_ClassiActivityLimit^"+strAppOldID+"^"+strActivityList);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotalAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   				if(rs!=null)
   				{
   					rs.close();
   				}
   				strQuery=SQLParser.getSqlQuery("sel_ClassiActivityLimit_CorpAgri^"+strAppOldID+"^"+strActivityList);
   				rs=DBUtils.executeQuery(strQuery);
   				if(rs.next())
   				{
   					dblTotalAmount=dblTotalAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
   				}
   				
   				if(!strPurpose.equalsIgnoreCase(""))
   				{
   					if(rs!=null)rs.close();
   					strQuery = SQLParser.getSqlQuery("sel_otherbankliab_MIS^"+strAppID+"^"+strPurpose);
   					rs = DBUtils.executeQuery(strQuery);
   					if(rs.next())
   					{
   						dblTotalAmount=dblTotalAmount+Double.parseDouble((String)Helper.correctDouble(rs.getString("PERBANK_LIMIT")));
   					}
   				}
   			}
   		}
   		catch(Exception ce)
   		{
   			throw new EJBException("Error in getClassiActivityMasterSum "+String.valueOf(ce));
   		}
   		return dblTotalAmount;
   	}
}
