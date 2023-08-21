package com.sai.laps.ejb.DigitalAppInterface;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.ArrayList;

//import com.ctc.wstx.stax.WstxOutputFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonAnyFormatVisitor;
import com.inet.pool.m;
import com.sai.fw.business.entities.User;
import com.sai.fw.management.log.LogWriter;
import com.sai.laps.ejb.BureauLink.BureauLinkBean;
import com.sai.laps.ejb.FinacleBean.FinacleInterfaceBean;
import com.sai.laps.ejb.bankappfi.BankAppFIBean;
import com.sai.laps.ejb.dataaccess.DataAccessBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.ejb.mis.MisBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.Constants;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;
import com.sun.glass.ui.Size;
import com.sun.jndi.toolkit.url.Uri;
import com.sun.org.apache.bcel.internal.generic.DLOAD;
import com.sun.xml.internal.fastinfoset.util.StringArray;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;

import oracle.jdbc.pool.OracleDataSource;
import sun.misc.BASE64Encoder;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.sai.laps.ejb.FinacleBean.FinacleInterfaceBean;
import com.sai.laps.ejb.bankappfi.BankAppFIBean;
import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.ejb.perlimitofloan.LimitofLoanBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.w3c.dom.*;

@Stateless(name = "DigitalAppInterfaceBean", mappedName = "DigitalAppInterfaceHome")
@Remote (DigitalAppInterfaceRemote.class)
public class DigitalAppInterfaceBean extends BeanAdapter{
	
	
	static Logger log = Logger.getLogger(DigitalAppInterfaceBean.class);
	
	static
	{
		try {
			createSslSocketFactory();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	private static void createSslSocketFactory() throws Exception {
		try
	    {
			System.out.println("<==========inside createSslSocketFactory===========>");
        TrustManager[] byPassTrustManagers = new TrustManager[] { new X509TrustManager() {
            public X509Certificate[] getAcceptedIssuers() {
               // return new X509Certificate[0];
            	return null;
            }
            public void checkClientTrusted(X509Certificate[] chain, String authType) {
            }
            public void checkServerTrusted(X509Certificate[] chain, String authType) {
            }
        } };
        SSLContext sslContext = SSLContext.getInstance("SSL");
       sslContext.init(null, byPassTrustManagers, new java.security.SecureRandom());
       HttpsURLConnection.setDefaultSSLSocketFactory(sslContext.getSocketFactory()); 
       
       HostnameVerifier allHostsValid = new HostnameVerifier(){
           public boolean verify(String hostname, SSLSession session) {
        	   return true;
           }
       };
       HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
        //return;
       System.out.println("<==========outside createSslSocketFactory===========>");
       
    // Install the all-trusting trust manager
       
       // Now you can access an https URL without having the certificate in the truststore
       
    }
		catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    } catch (KeyManagementException e) {
	        e.printStackTrace();
	    }
	
	}


	public HashMap updateInwardDetails(HashMap hshValues)  
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
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));				
			}
			//system user
			String strSystemUserId="SYSUSR";
			

			String strleadgenId=correctNull((String)hshValues.get("strleadGeneratedAgentId"));
			String strbsadsaname="",strorgscode="",strCanvassedby="",bsaordsa="";
			
			String banbkscheme=Helper.correctNull((String)hshValues.get("sel_bankscheme"));
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
					strorgscode = Helper.correctNull((String)rs.getString("org_scode"));;				
				}
			}


			
			if(strAction.equals("M"))
			{
				strInwardno=Helper.correctNull((String)hshValues.get("strLARnumber"));

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_LAR_DigitalAppl");
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
				arrValues.add(correctNull((String)hshValues.get("strDOB")));//17 inward_dob
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_pan")).toUpperCase());//18 inward_pantan
				arrValues.add(correctNull((String)hshValues.get("txt_comloanpur")).toLowerCase());//19 inward_purpose 
				arrValues.add(correctNull((String)hshValues.get("txtret_ftf")));//21 inward_termloanamt
				arrValues.add(correctNull((String)hshValues.get("txt_receidate")));//25 inward_docreceivedon
				arrValues.add(correctNull((String)hshValues.get("seldocrecd")));//26 inward_docreceived
				arrValues.add(correctNull((String)hshValues.get("strapplProcessLoc")));//27 inward_applnprocessat --> 1�Branch/6�RLPC 
				arrValues.add(strSolid);//28 inward_orgscode
				arrValues.add(strSystemUserId);//29 inward_usrid
				arrValues.add("A");//30 inward_valuesin
				arrValues.add(strSystemUserId);//31 inward_modifiedby
				arrValues.add("N");//33 inward_appliedfor
				arrValues.add("C");//34 inward_proptype
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));//39 District
				arrValues.add(correctNull((String)hshValues.get("selapplstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_rejreason")));
				String strloanType = correctNull((String)hshValues.get("strloanType"));
				if(strloanType.equalsIgnoreCase(""))
				{
				arrValues.add("t");// Term loan
				}else{
					arrValues.add(strloanType);// Term loan
				}
				arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));//
				arrValues.add("2"); //Govt sponser scheme -> default no
				arrValues.add(strCanvassedby); //Canvasasedby -not appllicable
				arrValues.add(correctNull((String)hshValues.get("selborrowerstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_leadno")).toUpperCase());
				arrValues.add("Y"); //External Application
				arrValues.add(correctNull((String)hshValues.get("strAddchangeFlag")));
				arrValues.add(correctNull((String)hshValues.get("strschemeDesc")));
				arrValues.add(correctNull((String)hshValues.get("strdigiAppNo")));
				arrValues.add(bsaordsa);
				arrValues.add(strorgscode);
				arrValues.add(strleadgenId);
				arrValues.add(correctNull((String)hshValues.get("strleadConvertedBy")));
				arrValues.add(correctNull((String)hshValues.get("strleadStaffId")));
				arrValues.add(strInwardno);//1 inward_no
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
					
				hshValues.put("strInwardno", strInwardno);
				hshValues.put("strResponseCode", "LAPS-1001");
				hshValues.put("strResponseMsg", "LAR Updated Successfully");
				
			}
			else
			{
				
				InwardRegisterBean inwardreg=new InwardRegisterBean();
				strInwardno=inwardreg.getMaxInwardno(strSolid);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_LAR_DigitalAppl");
				arrValues.add(strInwardno);//1 inward_no
				arrValues.add("p");//2 inward_sector
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
				arrValues.add(correctNull((String)hshValues.get("strDOB")));//17 inward_dob
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_pan")).toUpperCase());//18 inward_pantan
				arrValues.add(correctNull((String)hshValues.get("txt_comloanpur")).toLowerCase());//19 inward_purpose 
				arrValues.add(correctNull((String)hshValues.get("txtret_ftf")));//21 inward_termloanamt
				arrValues.add(correctNull((String)hshValues.get("txt_receidate")));//25 inward_docreceivedon
				arrValues.add(correctNull((String)hshValues.get("seldocrecd")));//26 inward_docreceived
				arrValues.add(correctNull((String)hshValues.get("strapplProcessLoc")));//27 inward_applnprocessat --> 1�Branch/6�RLPC 
				arrValues.add(strSolid);//28 inward_orgscode
				arrValues.add(strSystemUserId);//29 inward_usrid
				arrValues.add("A");//30 inward_valuesin
				arrValues.add(strSystemUserId);//31 inward_modifiedby
				arrValues.add("N");//33 inward_appliedfor
				arrValues.add("C");//34 inward_proptype
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));//39 District
				arrValues.add(correctNull((String)hshValues.get("selapplstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_rejreason")));
				String strloanType = correctNull((String)hshValues.get("strloanType"));
				if(strloanType.equalsIgnoreCase(""))
				{
				arrValues.add("t");// Term loan
				}else{
					arrValues.add(strloanType);// Term loan
				}
				arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));//
				arrValues.add(correctNull((String)hshValues.get("strgovtSponserScheme")));
				arrValues.add(strCanvassedby); //Canvasasedby -not appllicable
				arrValues.add(correctNull((String)hshValues.get("selborrowerstatus")));
				arrValues.add(correctNull((String)hshValues.get("txt_leadno")).toUpperCase());
				arrValues.add("Y");
				arrValues.add(correctNull((String)hshValues.get("strAddchangeFlag")));
				arrValues.add(correctNull((String)hshValues.get("strschemeDesc")));
				arrValues.add(correctNull((String)hshValues.get("strdigiAppNo")));
				arrValues.add(bsaordsa);
				arrValues.add(strorgscode);
				arrValues.add(strleadgenId);
				arrValues.add(correctNull((String)hshValues.get("strleadConvertedBy")));
				arrValues.add(correctNull((String)hshValues.get("strleadStaffId")));
				
				arrValues.add(correctNull((String)hshValues.get("strschemeType")));
				arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
				arrValues.add(correctNull((String)hshValues.get("stragencyName")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				hshValues.put("strInwardno", strInwardno);
				hshValues.put("strResponseCode", "LAPS-1000");
				hshValues.put("strResponseMsg", "LAR Created Successfully");
			}
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean updateInwardDetails..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean updateInwardDetails closing Connection ..."+e.toString());
			}
		}
		return hshValues;		
	}
	
	
	
	public HashMap dedupeCheck(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="";
		
		try
		{
			
		String strPANno=Helper.correctNull((String)hshValues.get("strPANno"));
		String strCBSid=Helper.correctInt((String)hshValues.get("strCBSid"));
		String strApplExist="N";

		String strCusName="",strCusCBSID="",strCusFatherName="",strCustDOB="",strCustPANno="",strAppno="",strAppStatus="",strmobileno="",strBIRdate="",strappcreatedate="";
		
		rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_panno^"+strPANno);
		if(rs.next())
		{
			strApplExist="Y";
			strCusName=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
			strCusCBSID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			strCusFatherName=Helper.correctNull((String)rs.getString("PERAPP_FATNAME"));
			strCustDOB=Helper.correctNull((String)rs.getString("PERAPP_DOB"));
			strCustPANno=Helper.correctNull((String)rs.getString("PERAPP_PANNO"));
			strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
			strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			strmobileno=Helper.correctNull((String)rs.getString("CON_MOBILE"));
			
			if(strAppStatus.equals("op"))
			{
				strAppStatus="Open";
			}
			else if(strAppStatus.equals("pa"))
			{
				strAppStatus="Approved";
			}
			
			else if(strAppStatus.equals("pr"))
			{
				strAppStatus="Rejected";
			}
					
			rs1=DBUtils.executeLAPSQuery("sel_per_bir^"+strAppno);
			if(rs1.next())
			{
				strBIRdate=Helper.correctNull((String)rs1.getString("bir_processdate"));
			}
		}		
			
		if(rs!=null)
			rs.close();
		if(rs1!=null)
			rs1.close();
		
		rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_cbsid^"+strCBSid);
		if(rs.next())
		{
			strApplExist="Y";
			strCusName=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
			strCusCBSID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			strCusFatherName=Helper.correctNull((String)rs.getString("PERAPP_FATNAME"));
			strCustDOB=Helper.correctNull((String)rs.getString("PERAPP_DOB"));
			strCustPANno=Helper.correctNull((String)rs.getString("PERAPP_PANNO"));
			strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
			strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			if(strAppStatus.equals("op"))
			{
				strAppStatus="Open";
			}
			else if(strAppStatus.equals("pa"))
			{
				strAppStatus="Approved";
			}
			
			else if(strAppStatus.equals("pr"))
			{
				strAppStatus="Rejected";
			}
			
			strmobileno=Helper.correctNull((String)rs.getString("CON_MOBILE"));
			rs1=DBUtils.executeLAPSQuery("sel_per_bir^"+strAppno);
			if(rs1.next())
			{
				strBIRdate=Helper.correctNull((String)rs1.getString("bir_processdate"));
			}
		}
		
		if(strApplExist.equals("N"))
		{
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_cbsid_BIR^"+strCBSid);
			if(rs.next())
			{
				strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
				strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
				strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
				
				if(strAppStatus.equals("op"))
				{
					strAppStatus="Open";
				}
				else if(strAppStatus.equals("pa"))
				{
					strAppStatus="Approved";
				}
				
				else if(strAppStatus.equals("pr"))
				{
					strAppStatus="Rejected";
				}
				
				strappcreatedate=Helper.correctNull((String)rs.getString("APP_CREATEDATE"));

			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_panno_BIR^"+strPANno);
			if(rs.next())
			{
				strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
				strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
				strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
				if(strAppStatus.equals("op"))
				{
					strAppStatus="Open";
				}
				else if(strAppStatus.equals("pa"))
				{
					strAppStatus="Approved";
				}
				
				else if(strAppStatus.equals("pr"))
				{
					strAppStatus="Rejected";
				}
				
				strappcreatedate=Helper.correctNull((String)rs.getString("APP_CREATEDATE"));
			}
			
		}
		
				
		hshValues.put("strApplExist", strApplExist);
		hshValues.put("strCusName",strCusName );
		hshValues.put("strCusCBSID",strCusCBSID );
		hshValues.put("strCusFatherName", strCusFatherName);
		hshValues.put("strCustDOB", strCustDOB);
		hshValues.put("strCustPANno", strCustPANno);
		hshValues.put("strAppno", strAppno);
		hshValues.put("strAppStatus", strAppStatus);
		hshValues.put("strmobileno", strmobileno);
		hshValues.put("strBIRdate", strBIRdate);
		hshValues.put("strappcreatedate", strappcreatedate);
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean dedupeCheck..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean dedupeCheck in  closing connection ..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	
	
	public HashMap customerCreation(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="",stridDoc="",strIdNumber="";
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
				
				String strIntroducerStatus="",strLAPSIntroducerType="",strIntroducerName="";
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strCBSid);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
					if(rs.next())
					{
					stridDoc=Helper.correctNull((String)rs.getString("id_doc"));
					strIdNumber=Helper.correctNull((String)rs.getString("id_number"));
					strIntroducerStatus=Helper.correctNull((String)rs.getString("cust_introd_stat_code"));
					strIntroducerName = (String) Helper.correctNull(rs.getString("cust_introd_name"));//done
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
						strIntroducerStatus=Helper.correctNull((String)rs.getString("cust_introd_stat_code"));
						strIntroducerName = (String) Helper.correctNull(rs.getString("cust_introd_name"));//done
					}
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^6^"+strIntroducerStatus);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strLAPSIntroducerType=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
				}
				
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_LAPS_CustomerProfile_extAppl");
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
				if(!strCBSid.equals(""))
				{
					arrValues.add(correctNull((String)hshValues.get("strLAPSIntroducerType")));
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("strIntroStatus")));
				}
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
				if(!strCBSid.equals(""))
				{
					arrValues.add(correctNull((String)hshValues.get("strIntroducerName")));
					arrValues.add(correctNull((String)hshValues.get("strIntroducerStatus")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("strnetworthBorrower")));
				arrValues.add(correctNull((String)hshValues.get("strproforma")));
				arrValues.add(correctNull((String)hshValues.get("strResidenceProof")));
				arrValues.add(correctNull((String)hshValues.get("strudyamRegistrationNumber")));
				arrValues.add(correctNull((String)hshValues.get("strsalesTurnOverApplicant")));
				arrValues.add(correctNull((String)hshValues.get("strsalesTurnOverDate")));
				arrValues.add(correctNull((String)hshValues.get("strcriteriaforSalesTurnover")));
				arrValues.add(correctNull((String)hshValues.get("strudyamRegistrationClassification")));
				arrValues.add(correctNull((String)hshValues.get("strudyamDate")));
				String strIDprooftype = correctNull((String)hshValues.get("strIDprooftype"));
				if(strIDprooftype.equalsIgnoreCase("ADHAAR")){
				arrValues.add(correctNull((String)hshValues.get("strIDref")));
				}else{
					arrValues.add("");
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_individual_info_extAppl");
				arrValues.add(strNewLAPSid);//newid
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
				arrValues.add(correctNull((String)hshValues.get("strSpouseName")));
				arrValues.add(correctNull((String)hshValues.get("strMotherName")));
				String strReligion="",strMinority="",strComState="";
				strReligion = correctNull((String)hshValues.get("strReligion"));
				strComState = correctNull((String)hshValues.get("strComState"));
				if(strReligion.equalsIgnoreCase("1"))
				{
					strMinority="N";
				}else if(!strReligion.equalsIgnoreCase("1") && !strReligion.equalsIgnoreCase("4"))
				{
					strMinority="Y";
				}else if(strReligion.equalsIgnoreCase("4") && strComState.equalsIgnoreCase("PB"))
				{
					strMinority="N";
				}else
				{
					strMinority="N";
				}
				arrValues.add(strMinority);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				 
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_contact_info_common_customer_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strComAddress1")));
				arrValues.add(correctNull((String)hshValues.get("strComAddress2")));
				arrValues.add(correctNull((String)hshValues.get("strComCity")));
				arrValues.add(correctNull((String)hshValues.get("strComDistrict")));
				arrValues.add(correctNull((String)hshValues.get("strComState")));
				arrValues.add(correctNull((String)hshValues.get("strComCountry")));
				arrValues.add(correctNull((String)hshValues.get("strComPincode")));
				arrValues.add(correctNull((String)hshValues.get("strComAddress1")));
				arrValues.add(correctNull((String)hshValues.get("strComAddress2")));
				arrValues.add(correctNull((String)hshValues.get("strComCity")));
				arrValues.add(correctNull((String)hshValues.get("strComDistrict")));
				arrValues.add(correctNull((String)hshValues.get("strComState")));
				arrValues.add(correctNull((String)hshValues.get("strComCountry")));
				arrValues.add(correctNull((String)hshValues.get("strComPincode")));
				arrValues.add(correctNull((String)hshValues.get("strResidentType")));
				String noofyears=correctNull((String)hshValues.get("strNoofYearsPresAdd"));
				arrValues.add(noofyears+"~0");
				arrValues.add(correctNull((String)hshValues.get("mobileNumber")));
				arrValues.add(correctNull((String)hshValues.get("customerEmail")));
				
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
					
							
				
			    
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_appKYCnorms_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strCustomerOccupation")));
				
				if(!strCBSid.equals(""))
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
				arrValues.add("N");
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
				
				double annualGrossIncome=0.00;
				annualGrossIncome=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strGrossIncome")))*12;
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_incomeexp_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strPrimaryIncome")));
				arrValues.add(String.valueOf(Helper.correctDouble((String)hshValues.get("strGrossIncome"))));
				arrValues.add(String.valueOf(annualGrossIncome));
				arrValues.add(String.valueOf(annualGrossIncome));
				arrValues.add(correctNull((String)hshValues.get("strIncomeTaxDet")));
				arrValues.add(correctNull((String)hshValues.get("strincomeITR")));
				arrValues.add(correctNull((String)hshValues.get("strDocCollected")));
				arrValues.add("Y");
				arrValues.add("A");
				if(correctNull((String)hshValues.get("strEmployment")).equals("1") || correctNull((String)hshValues.get("strEmployment")).equals("01")){
				arrValues.add(String.valueOf(annualGrossIncome));//perappactualincome
				}else{
					arrValues.add(correctNull((String)hshValues.get("strincomeITR")));
				}
				arrValues.add(correctNull((String)hshValues.get("strincomeYearEnded")));//perinc_yearend1
				arrValues.add(correctNull((String)hshValues.get("stritrFillingDate")));//perinc_itrdate1
				arrValues.add(correctNull((String)hshValues.get("strIncomeYearEndPreviousYear")));//PERINC_YEAREND2
				arrValues.add(correctNull((String)hshValues.get("itrFillDatePreviousYear")));//PERINC_ITRDATE2
				arrValues.add(correctNull((String)hshValues.get("stritrSalaryPreviousYear")));//PERINC_YEAR2_INCOME
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
				arrValues.add(correctNull((String)hshValues.get("strComAddressLine2"))); 
				arrValues.add(correctNull((String)hshValues.get("strComAddressLine3")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_company_info_common_customer_extAppl");
				arrValues.add(strNewLAPSid); //newid
				arrValues.add(correctNull((String)hshValues.get("strDOB")));
				
				if(correctNull((String)hshValues.get("strgstin")).equals("")){
					arrValues.add("Not Applicable");
					arrValues.add("N");
				}
				else{
					arrValues.add(correctNull((String)hshValues.get("strgstin")));
					arrValues.add("Y");
				}
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
				
				//other Bank Facilities
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
				
				
				ArrayList arrLandhold=new ArrayList();
				ArrayList arrLandholdValues=new ArrayList();
				arrLandhold=(ArrayList) hshValues.get("landHolding");
				int landholdLenth=arrLandhold.size();
				if(landholdLenth>0)
				{
					for(int i=0;i<landholdLenth;i++)
					{		
						arrLandholdValues=(ArrayList) arrLandhold.get(i);
						
						String landHold =Helper.correctNull((String)arrLandholdValues.get(0));
						String surveyNo =Helper.correctNull((String)arrLandholdValues.get(1));
						String ownedOrLeased =Helper.correctNull((String)arrLandholdValues.get(2));
						String farmCat =Helper.correctNull((String)arrLandholdValues.get(3));
						String labourType =Helper.correctNull((String)arrLandholdValues.get(4));
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_landhold_details");
						arrValues.add(strNewLAPSid);
						arrValues.add(landHold);
						arrValues.add(surveyNo);
						arrValues.add(ownedOrLeased);
						arrValues.add(farmCat);
						arrValues.add(labourType);					
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
					}
				}
					String strlapmaxsoldID="",strOldFinID="",strNewFinID="";
					if(rs1 != null)rs1.close();
		            strQuery=SQLParser.getSqlQuery("selmaxlapsidofcustid^"+strCBSid);
		           rs1=DBUtils.executeQuery(strQuery);
		            if(rs1.next())
		            {
		            	strlapmaxsoldID = (Helper.correctNull(rs1.getString("maxperappid")));
		            }
					if(!lapsoldID.equalsIgnoreCase("") && !strlapmaxsoldID.equalsIgnoreCase(""))
					{
						Connection connectDB	= null;
						CallableStatement callableStmt = null;
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
				hshValues.put("strResponseCode", "LAPS-1008");
				hshValues.put("strResponseMsg", "LAPS Customer Profile Created Successfully");
			
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
	

	public HashMap ProposalCreation(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		HashMap hshlockvalues=new HashMap();
		
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strApplicationNo="",strLAPSid="";
		String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
		String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
		int intUpdatesize=0;
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	
		try
		{
			Date date1;
			Date date2;
			String strDate = ApplicationParams.getStrCLPCdate();
			SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
			date1 = CLPCdate.parse(strDate);
			String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
			date2 = CLPCdate.parse(NOwCalender);
			String strsolidMang = strsolid;
			
			if (date1.before(date2))
			{
				if (strsolid.equalsIgnoreCase("850")){
					strsolidMang="600";
				}
			}
			//userid from organisation
			String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strUserClass="",strorg_branchin="";
			
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolidMang);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
				strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
				strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
				strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
				strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
			//system user
			String strSysteUserId="SYSUSR";
			
			if (rs != null) 
			{
				rs.close();
			}
			String strperappOldID="";
			strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
				strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
			}
			if(strLAPSid.equals(""))
			{
				strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
				strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
			}
			
			
				String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
			 
				String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
			
				//new Application Number
				hshlockvalues = new HashMap();
				hshlockvalues.put("apptype", "P");
				hshlockvalues.put("comapp_id", strLAPSid);
				hshlockvalues.put("strSolid", strsolid);
				strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

				//applications table
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strPrdCode);
				arrValues.add(strSysteUserId);
				arrValues.add(strOrgCode);									
				arrValues.add("P"); //Digital retail
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				arrValues.add("R");
				arrValues.add(strOrgLevel);
				arrValues.add(strUserId);
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("N");
				arrValues.add("PR");
				arrValues.add("N");
				arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
				arrValues.add(correctNull((String) hshValues.get("strstpType")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insapplications_digi");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//demographic table 
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strLAPSid);
				arrValues.add("a");
				arrValues.add("");
				arrValues.add("2");
				arrValues.add(strperappOldID);
				arrValues.add("");
				arrValues.add("a");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsdemoins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//inward register
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","updinwardappatached");
				arrValues.add("Y");
				arrValues.add("op");
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				 
				String mclrtype="",mclrtabcode="",mclrbaserate="";
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
				}
				
				//loandetails
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;//
				hshQuery.put("strQueryId", "ins_loandetails_extAppl");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
				arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
				String intype=correctNull((String) hshValues.get("strInterestType"));
				if(intype.equals("1"))
				{
					intype="Fixed";
				}
				else if(intype.equals("2"))
				{
					intype="Floating";
				}
				arrValues.add(intype);
				arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
				//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
				arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
				arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
				//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
				arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
				arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
				arrValues.add(correctNull((String) hshValues.get("strTakeover")));
				arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
				//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
				arrValues.add(mclrtabcode);
				arrValues.add(mclrtype);
				arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
				arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
				arrValues.add(mclrbaserate);
				arrValues.add("0");//prd_busstrategicpremium
				arrValues.add("0");//prd_creditrskpremium
				if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
				{
					arrValues.add("1"); //interest charged 
				}
				else
				{
					arrValues.add("2");  //interest charged 
				}
				arrValues.add("C");
				arrValues.add(correctNull((String) hshValues.get("strmargin")));
				arrValues.add("Y");
				arrValues.add("N");
				arrValues.add("S");

				//if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
					
		/*	else
				arrValues.add("NC");*/
				arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
				//else
					//arrValues.add("NC");
				
					arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
					//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
					arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
					

		
				arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
				arrValues.add(strsolid);
				arrValues.add(correctNull((String) hshValues.get("strEMIamount")));

				arrValues.add(correctNull((String)hshValues.get("strschemeType")));
				arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
				arrValues.add(correctNull((String)hshValues.get("stragencyName")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
				arrValues.add("N");
				arrValues.add("");
				arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
				arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
				arrValues.add(correctNull((String) hshValues.get("")));
				arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
				arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
				arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
				arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
	            Calendar calendar = Calendar.getInstance();
	            String strDay = dateFormat.format(calendar.getTime());
	            
				//workflow Mailbox
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins_extappl");
				arrValues.add(strApplicationNo);
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
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
	            calendar.add(Calendar.SECOND,5);
	            strDay = dateFormat.format(calendar.getTime());
	            
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins_extappl");
				arrValues.add(strApplicationNo);
				arrValues.add(strSysteUserId);
				arrValues.add(strUserId);
				arrValues.add("1");
				arrValues.add("2");
				arrValues.add(strDay);
				arrValues.add("C");
				arrValues.add("001");
				arrValues.add("");
				arrValues.add(strOrgScode);
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//per loan secure
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
				arrValues.add("u"); //unsecured
				arrValues.add("0"); //secured amt
				arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);					
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				//Coapplicant
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
						hshQuery.put("strQueryId", "perloandetailsdemoins");
						arrValues = new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(perapppid);//appid
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
						arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
						arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
						arrValues.add(strOldid);//oldid
						arrValues.add(strfinacletype.toUpperCase());//relationtype
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
					}
				}
				
				String strSysUsrOrg="";
				
				if (rs != null) 
				{  rs.close(); 	}
				strQuery = SQLParser.getSqlQuery("setuserssel^"+strSysteUserId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			strSysUsrOrg = Helper.correctNull((String) rs.getString("usr_orgcode"));
	    		}
				
				//Security - Clean
				SecurityMasterBean secMasBean =new SecurityMasterBean();
				String strSecurityId = secMasBean.getOldAppidWithSno(strLAPSid);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_securities_details");	
				arrValues.add(strSecurityId);
				arrValues.add("1"); //Type
				arrValues.add("25"); //classification
				arrValues.add("N"); //charged to bank
				arrValues.add("0"); //nature of charge
				arrValues.add(""); 
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("Clean Security"); 
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("Y");
				arrValues.add("N");
				arrValues.add(strSysteUserId);
				arrValues.add(strSysUsrOrg);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_ownership_securities");	
				arrValues.add(strSecurityId);
				arrValues.add(strperappOldID);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_birdata");	
				arrValues.add(strApplicationNo);
				arrValues.add("N");
				arrValues.add("0.00");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				
				String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
				
				strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
				}
				//security attachment
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strSecurityId);
				arrValues.add("1");
				arrValues.add(strLAPSid);
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("F");
				arrValues.add(strLoanType);//loantype
				arrValues.add("1");
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add("1");
				arrValues.add(strLAPSid);
				arrValues.add("0.00");
				arrValues.add(strPrdCode);
				arrValues.add("P");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(strperappOldID);
				arrValues.add("F");
				arrValues.add("");
				//arrValues.add("M");
				hshQuery.put("strQueryId","ins_securitydetails_digi");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
							
				//security Freeze
				BankAppFIBean bankappfi=new BankAppFIBean();
				hshValues.put("appno", strApplicationNo);
				hshValues.put("hidapplicantid", strLAPSid);
				hshValues.put("hidapplicantnewid", strLAPSid);

				bankappfi.getSecCollateralCoverageRetail(hshValues);
				
				
				//terms and conditions
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
				
				//Coapplicant Freeze
				hshValues.put("appno", strApplicationNo);
				PerApplicantBean perApplicantBean = new PerApplicantBean();
				perApplicantBean.getFreezeData(hshValues);
				
				//Credit Facilities Freeze
				BankAppFIBean appFIBean = new BankAppFIBean();
				appFIBean.updateFreezeData(hshValues);
			
			
				//misdata
				String strperappcity="",strperappstate="",strperappdistrict="";
				strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
					strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
					strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
				}	
				
				//MIS Activity
				HashMap hshMISstatic = new HashMap();
				HashMap hshMISSubActivity = new HashMap();
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
					String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
					hshMISstatic.put(strSlcode,strPrdDesc);
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
					String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
					hshMISSubActivity.put(strSubcode,strSubPrdDesc);
				}
				
				
				
				
				
										
				String strActivity = " and mac.ACT_ACTIVITYCODE in (";
				String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
				String stractivitycode=strActCode;
				if(rs1!=null)
				{	  rs1.close();		}
				strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{ 
					hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
					hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
					hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
					hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
					hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
					hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
					hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
					hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
					hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
					hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
					hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
					hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
					hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
					hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
					hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
					String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
					String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
					if(strMainActivityCode.length()>0)
					{
						hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
					}
					
					if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
					{
						String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
						hshValues.put("strMainSubActivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
					}
					
					hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
					hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
					
					hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
					hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
					hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
				}
				
				double dblTotLim=0.00;
				double dblTotLimAgr=0.00;
				double dblTotLimSer=0.00;
				
				MisBean misbean=new MisBean();
				
				dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
				dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strApplicationNo);
				dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strApplicationNo);
				
				int querycount=0;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
				arrValues.add("N");//Whether under Service Area Approach
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
				arrValues.add(strperappcity);
				arrValues.add(strperappdistrict);
				arrValues.add(strperappstate);
				arrValues.add(strorg_branchin);//Place - Meteor
				arrValues.add("N"); //Does repayments depend purely on the asset financed
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
				arrValues.add("00");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
				arrValues.add(strActCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
				arrValues.add("1"); //Asset Classification
				arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
				arrValues.add("1"); //fac serial no
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_sharebroker")));
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				String strQueryAgr="";
				strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
				MISLogger.UpdateLogger(strQueryAgr);
				rs1=DBUtils.executeQuery(strQueryAgr);
				if(rs1.next())
				{
					hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
					hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
					hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
					hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
					hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
					hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
				}
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
				arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
				arrValues.add("1");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
				MISLogger.UpdateLogger(strQuery);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
					{
						if(rs!=null)
							rs.close();
						strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshQueryValues.put("size","5");
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							querycount++;
							hshQuery.put("strQueryId","upd_cbsdetails");
							arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
							arrValues.add(strApplicationNo);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(querycount),hshQuery);
						}
					}
				}
				hshQueryValues.put("size",String.valueOf(querycount));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				String strAppStatus="";
				String strPriorityType="";
				String strPrioritySubsector="";
				String strWeakerSectionSubSector="";
				String strAgriIndConfig="";
				String strTwentyPointPgm="";
				String strSensitiveSector="";
				String strInfracode="";
				String strGovtAnnounceScheme="";
				String strClassiMaster_Sno="";
				String strActivityCode="";
				String strActivitySno="";
				HashMap hshPriority=new HashMap();
				String strFacilitySno="1";
				String strStandUpIndia="";

				hshValues.put("strFacilitySno",strFacilitySno);
				hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
				hshValues.put("strHOLIDAYPERIOD","0");
				hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
				hshValues.put("hidapplicantnewid",strLAPSid);
				hshValues.put("strAppType","P");
				
				 hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
				 
				 	hshQueryValues=new HashMap();
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_misappclassification_digi");
					arrValues.add(strApplicationNo);
					arrValues.add(strAgriIndConfig);
					arrValues.add(strPriorityType);
					arrValues.add(strPrioritySubsector);
					arrValues.add(strSensitiveSector);
					arrValues.add(strWeakerSectionSubSector);
					arrValues.add(strTwentyPointPgm);
					arrValues.add(strInfracode);
					arrValues.add(strGovtAnnounceScheme);
					arrValues.add(strClassiMaster_Sno);
					arrValues.add(strFacilitySno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
				// mis end
					
					
				//CBS Details
				 
				if(rs != null)
				   rs.close(); 	 
				String strAppend="",strmodeofadv="";
				strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
				strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
				}

				if(rs!=null)
				rs.close();
				String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
				strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
					freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
					freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
					freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
					finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
					finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
					
				}
				
				
				
				if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
				{
					strLoanType="LAA";
				}
				else if(strLoanType.equalsIgnoreCase("OD"))
				{
					strLoanType="ODA";
				}
				strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
				}
 				
				String strGLSubHeadCode="";
				strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strPrioritySubsector+"@^@"+strPrioritySubsector+"@");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGLSubHeadCode=Helper.correctNull((String)rs.getString("sch_datadescription"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(freeCode6);
				arrValues.add(freeCode7);
				arrValues.add(freeCode8);
				arrValues.add("01");//strModeOfOperation
				arrValues.add("E");//strDrawingPowerInd
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
				arrValues.add("N"); // Account Handoff
				arrValues.add("03");//strAdvanceNature
				arrValues.add(strAdvanceType);
				arrValues.add(strmodeofadv);
				arrValues.add("10"); //default 10
				arrValues.add("999"); //default 999
				arrValues.add(strsolid);
				arrValues.add(""); //Security Code
				arrValues.add(strintratefrq);
				arrValues.add(finfreeCode7);
				arrValues.add(finfreeCode8);
				arrValues.add(strlbrcode);
				arrValues.add(strFacilitySno);
				arrValues.add("Clean Security");
				arrValues.add("TGAQ"); //facilityschemecode
				arrValues.add(strGLSubHeadCode); //facility_glsubheadcode
				arrValues.add("99"); //laps free code 1
				arrValues.add("99"); //laps free code 2
				arrValues.add("99"); //laps free code 3
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_cbsdetails");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				//documents 
				hshValues.put("strUserId", strUserId);
				hshValues.put("app_no", strApplicationNo);
				//hshValues=getDocumentURLs(hshValues);
				
				//APPRAISALSANCTION table
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strSysteUserId);//appraised by
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
				arrValues.add("Y");//appraisal flag
				arrValues.add("02");//sanclevel
				arrValues.add("51");//sancauth
				arrValues.add("016");//sancdepart
				arrValues.add("RET");//sancbranch
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				//security freeze
				hshQueryValues=new HashMap();
    			hshQuery=new HashMap();
    			arrValues=new ArrayList();
    			arrValues.add("Y");
    			arrValues.add(strApplicationNo);
    			hshQuery.put("arrValues",arrValues);
    			hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
    			hshQueryValues.put("size","1");
    			hshQueryValues.put("1",hshQuery);
    			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				//sanction
				if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("sanction"))
				{
						
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updapplicationsfinalsanction");
					arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "updinwardappstatus");
					arrValues.add("pa");
					arrValues.add(strInwardno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					//userclass
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","commworkflowupddigi");
					arrValues.add("pa");
					arrValues.add(strSysteUserId);
					arrValues.add(strsolid);
					arrValues.add(strUserClass);
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					hshQueryValues.put("size","3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					//sanction reference numnber
					CommWorkflowBean commwrkfko=new CommWorkflowBean();
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
						hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
						hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
						hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
					}
					hshValues.put("hidAction", "approve");
					hshValues.put("sessionModuleType", "RET");
					hshValues.put("strApplicationType", "F");
					hshValues.put("digiloan", "Y");

					String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
					
					hshValues.put("strReferenceno", strReferenceno);
					hshValues.put("strSanctionDate", Helper.getCurrentDateTime());
					
				} else if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("Manual Check"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();   
					hshQuery.put("strQueryId","ins_Veri_ManualCheck");
					arrValues.add(strApplicationNo);
					arrValues.add(strLAPSid);
					arrValues.add("MC");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_specialMargin");
				arrValues.add(correctNull((String) hshValues.get("strmargin")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   
				hshQuery.put("strQueryId","ins_retailcomments");
				arrValues.add(strApplicationNo);
				arrValues.add("LoanProd");
				arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
				
				hshValues.put("strApplication", strApplicationNo);
				hshValues.put("strResponseCode", "LAPS-1010");
				hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean ProposalCreation..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean ProposalCreation..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	
	
	public HashMap preApprovedOfferServiceApp(HashMap hshValues) 
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="";
		
		try
		{
			
		String strAccountNo=Helper.correctNull((String)hshValues.get("strAccountNo"));
		String strCustomerID=Helper.correctInt((String)hshValues.get("strCustomerID"));
		String strApplExist="N";

		String strCustID="",strAccNo="",strCustLoanAmt="",strCustROI="",strCustTenure="",strProcessingFee="",strBureauScore="",strBreScore="",strEMIlimit="",strSalary="",strBIRdate="";
		
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("sel_preApprovedOffer_extApp^"+strCustomerID+"^"+strAccountNo);
		if(rs.next())
		{
			strApplExist="Y";
			strCustID=Helper.correctNull((String)rs.getString("KBL_CUST_ID"));
			strAccNo=Helper.correctNull((String)rs.getString("KBL_ACC_NUMBER"));
			strCustLoanAmt=Helper.correctNull((String)rs.getString("KBL_LOAN_AMOUNT"));
			strCustROI=Helper.correctNull((String)rs.getString("KBL_ROI"));
			strCustTenure=Helper.correctNull((String)rs.getString("KBL_TENURE"));
			strProcessingFee=Helper.correctNull((String)rs.getString("KBL_PROCESSING_FEE"));
			strBureauScore=Helper.correctNull((String)rs.getString("KBL_BUREAU_SCORE"));
			strBreScore=Helper.correctNull((String)rs.getString("KBL_BRE_SCORE"));
			strEMIlimit=Helper.correctNull((String)rs.getString("KBL_EMI_LIMIT"));
			strSalary=Helper.correctNull((String)rs.getString("KBL_SALARY"));
			
		}		
		
		if(rs!=null)
			rs.close();
		String strdebitscore="";
		strQuery=SQLParser.getSqlQuery("sel_kbletb_debitscore^"+strCustomerID);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strdebitscore=Helper.correctNull((String)rs.getString("KBL_ETB_DEBITSCORE"));
		}
		if(strdebitscore.equals(""))
			strdebitscore="0";	
		
		 rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_cbsid_BIR^"+strCustomerID);
			if(rs.next())
			{
				strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
			
			}
		if(rs!=null)
			rs.close();
		
		hshValues.put("strApplExist", strApplExist);
		hshValues.put("strCustID",strCustID );
		hshValues.put("strAccNo",strAccNo );
		hshValues.put("strCustLoanAmt", strCustLoanAmt);
		hshValues.put("strCustROI", strCustROI);
		hshValues.put("strCustTenure", strCustTenure);
		hshValues.put("strProcessingFee", strProcessingFee);
		hshValues.put("strBureauScore", strBureauScore);
		hshValues.put("strBreScore", strBreScore);
		hshValues.put("strEMIlimit", strEMIlimit);
		hshValues.put("strSalary", strSalary);
		hshValues.put("strdebitscore", strdebitscore);
		hshValues.put("strbirdate", strBIRdate);
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean preApprovedOfferServiceApp..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean preApprovedOfferServiceApp closing connection..."+e.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap proposalCreationForHL(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshQueryValues= new HashMap();
		HashMap hshlockvalues=new HashMap();
		HashMap hshRecord=new HashMap();

		ArrayList arrValues= new ArrayList();
		
		ResultSet rs=null,rs1=null;
		String strQuery="",strApplicationNo="",strLAPSid="", strperappOldID="",strsolidOf850="";
		
		String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
		String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
		int intUpdatesize=0;
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	
    	
		try
		{
			
			Date date1;
			Date date2;
			String strDate = ApplicationParams.getStrCLPCdate();
			SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
			date1 = CLPCdate.parse(strDate);
			String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
			date2 = CLPCdate.parse(NOwCalender);
			String strsolidMang = strsolid;
			
			if (date1.before(date2))
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strsolid);
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

			//userid from organisation
			String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="",STRCLPHAV="";
			String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
			String strscheme =Helper.correctNull((String)hshValues.get("strScheme"));
			
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
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
				strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
				strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
				strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
			}else{
				strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			
			if (rs != null) 
			{	rs.close();	 }
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
			
			//system user
			String strSysteUserId="SYSUSR";
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);	
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
				strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
			}
			
			if(strLAPSid.equals(""))
			{
				strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
				strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
			}
			
			String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
			
			
				//new Application Number
				hshlockvalues = new HashMap();
				hshlockvalues.put("apptype", "P");
				hshlockvalues.put("comapp_id", strLAPSid);
				hshlockvalues.put("strSolid", strsolid);
				strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

				//applications table
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strPrdCode);
				arrValues.add(strSysteUserId);
				arrValues.add(strOrgCode);									
				arrValues.add("P"); //Digital retail
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				arrValues.add("R");
				arrValues.add(strOrgLevel);
				arrValues.add(strUserId);
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("N");
				arrValues.add("PR");
				arrValues.add("N");
				arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
				arrValues.add(correctNull((String) hshValues.get("strstpType")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insapplications_digi");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//demographic table 
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strLAPSid);
				arrValues.add("a");
				arrValues.add("");
				arrValues.add("2");
				arrValues.add(strperappOldID);
				arrValues.add("");
				arrValues.add("a");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsdemoins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				//inward register
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","updinwardappatached");
				arrValues.add("Y");
				arrValues.add("op");
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				 
				String mclrtype="",mclrtabcode="",mclrbaserate="",prdpupose="";
				double intrate=0.00;
				/* Home Connect MCLR not REquired */
				String strloanpurpose=Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose"));
				if(!strloanpurpose.equals("HC"))
				{
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
					mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
				}
				
				//interest rate calculation
				
				intrate=Double.parseDouble(mclrbaserate)+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")))
						+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
				}
				else{
					 intrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
				}
				//credit risk and business premium
				/*if (rs != null) 
				{ 	 rs.close();	}
				String strLesser = ">=";
				String strGreater = "<=";
				String strTerms=correctNull((String) hshValues.get("strLoanTenor"));
				String strRecAmt=correctNull((String) hshValues.get("strAmountRequested"));
				double prd_creditrskpremium=0.00,prd_busstrategicpremium=0.00;
				
				strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^floating^" + strPrdCode + "^" + strGreater + "^"
						+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^O^" + strGreater + "^" + strTerms + "^"
						+ strLesser + "^" + strTerms );
				
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 prd_creditrskpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")));
					 prd_busstrategicpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")));
				}
				
				double strintrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
				prd_busstrategicpremium=strintrate-(Double.parseDouble(Helper.correctDouble(mclrbaserate))-prd_creditrskpremium);*/
				
				//margin calculation
				//String strloanpurpose=Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose"));
				int strpremisesage=Integer.parseInt(Helper.correctInt((String) hshValues.get("strpremisesAge")));
				
				
				String instlmntAmountforNonEmi="";
				if(correctNull((String) hshValues.get("strRepaymentType")).equalsIgnoreCase("2"))
					{
					ArrayList arrRepayScheduleforNonEmi=new ArrayList();
					ArrayList arrrepayforNonEmiValue=new ArrayList();
					arrRepayScheduleforNonEmi=(ArrayList) hshValues.get("arrRepaymentSchedule");
					int arrrepayScheduleforNonEmiSize=arrRepayScheduleforNonEmi.size();
					if(arrrepayScheduleforNonEmiSize>0)
					{
						for(int i=0;i<arrrepayScheduleforNonEmiSize;i++)
						{
					arrrepayforNonEmiValue=(ArrayList) arrRepayScheduleforNonEmi.get(i);
					instlmntAmountforNonEmi=Helper.correctInt((String)arrrepayforNonEmiValue.get(1));
						}
					}
					}
				
				int margin=0;
				if(rs1!=null)
					rs1.close();
				String desc="";
				if(strloanpurpose.equalsIgnoreCase("H"))
					desc=String.valueOf(strpremisesage);
				else
					desc=correctNull((String) hshValues.get("strAmountRequested"));
				
				rs1 = DBUtils.executeLAPSQuery("sel_prdmargin_appl^"+ strPrdCode+"^"+desc);
				if(rs1.next())
				{
					margin=Integer.parseInt(Helper.correctInt((String)rs1.getString("MARGIN_PERCT")));
				}
			
				if(strloanpurpose.equalsIgnoreCase("H"))
				{	
					if(strpremisesage>10)
					{
						margin=30;
					}
					else
					{
						double reqamt=Double.parseDouble(Helper.correctDouble((String) hshValues.get("strAmountRequested")));
						
						if((reqamt > 1.00) && (reqamt <= 3000000.00))
						{
							margin=10;
						}
						else if((reqamt > 3000000.00) && (reqamt <= 7500000.00))
						{
							margin=20;
						}
						else if((reqamt > 7500000.00) && (reqamt <= 30000000.00))
						{							
							margin=25;
						}
					}
				}
				
				//loandetails
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;//
				hshQuery.put("strQueryId", "ins_loandetails_extAppl");
				arrValues.add(strApplicationNo);
				arrValues.add(String.valueOf(jtn.format(intrate)));
				arrValues.add(String.valueOf(jtn.format(intrate)));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
				String intype=correctNull((String) hshValues.get("strInterestType"));
				if(intype.equals("1"))
				{
					intype="Fixed";
				}
				else if(intype.equals("2"))
				{
					intype="Floating";
				}
				arrValues.add(intype);
				arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
				//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
				arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
				arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
				//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
				arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
				arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
				arrValues.add(correctNull((String) hshValues.get("strTakeover")));
				if(correctNull((String) hshValues.get("strRepaymentType")).equalsIgnoreCase("2"))
				{
					arrValues.add(instlmntAmountforNonEmi);
				}else{
				arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
				}
				//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
				arrValues.add(mclrtabcode);
				arrValues.add(mclrtype);
				arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
				arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
				arrValues.add(mclrbaserate);
				arrValues.add(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
				if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
				{
					arrValues.add("1"); //interest charged 
				}
				else
				{
					arrValues.add("2");  //interest charged 
				}
				arrValues.add("C");
				arrValues.add(correctNull((String)hshValues.get("strmargin")));
				arrValues.add("Y");
				arrValues.add("N");
				arrValues.add("S");
				/*if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
						arrValues.add("METLIFE");
				else
					arrValues.add("NC");*/
					arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
					arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
					//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
					arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
					
				arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
				arrValues.add("");
				if(correctNull((String) hshValues.get("strRepaymentType")).equalsIgnoreCase("2"))
				{
					arrValues.add(instlmntAmountforNonEmi);
				}else{
				arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
				}
				
				arrValues.add(correctNull((String)hshValues.get("strschemeType")));
				arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
				arrValues.add(correctNull((String)hshValues.get("stragencyName")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
				arrValues.add(correctNull((String)hshValues.get("strdeviation")));
				arrValues.add(correctNull((String)hshValues.get("strResidualvalue")));
				arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
				arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
				arrValues.add(correctNull((String) hshValues.get("strDigiAppNo")));
				arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
				arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
				arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
				arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
	            Calendar calendar = Calendar.getInstance();
	            String strDay = dateFormat.format(calendar.getTime());
	            
				//workflow Mailbox
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins_extappl");
				arrValues.add(strApplicationNo);
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
				hshQueryValues.put(""+intUpdatesize, hshQuery);

				calendar.add(Calendar.SECOND,5);
		        strDay = dateFormat.format(calendar.getTime());
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","commworkflowins_extappl");
				arrValues.add(strApplicationNo);
				arrValues.add(strSysteUserId);
				arrValues.add(strUserId);
				arrValues.add("1");
				arrValues.add("2");
				arrValues.add(strDay);
				arrValues.add("C");
				arrValues.add("001");
				arrValues.add("");
				arrValues.add(strOrgScode);
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);

				//per loan secure
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
				arrValues.add("s"); //unsecured
				arrValues.add("0"); //secured amt
				arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put(""+intUpdatesize, hshQuery);	
				
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				//Coapplicant
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
						hshQuery.put("strQueryId", "perloandetailsdemoins");
						arrValues = new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(perapppid);//appid
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
						arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
						arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
						arrValues.add(strOldid);//oldid
						arrValues.add(strfinacletype.toUpperCase());//relationtype
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
					}
				}
				
				String strperappcity="",strperappstate="",strperappdistrict="";
				strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
					strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
					strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
				}					
				
				//terms and conditions
				ArrayList arrTerms=new ArrayList();
				ArrayList arrTermsId=new ArrayList();
				ArrayList arrTermsType=new ArrayList();  
				int k=0,sno =1;;
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
						hshQuery.put("strQueryId","apptermscondinsdigi");
						arrValues=new ArrayList();
						arrValues.add(strApplicationNo);//app_termappno
						arrValues.add(String.valueOf(i));//app_termid
						arrValues.add(correctNull((String)arrTerms.get(i)));//app_termscontent
						arrValues.add("P");//app_termstype
						arrValues.add("N");//app_termsdel
						arrValues.add("S");//app_general_terms_type
						arrValues.add("");//terms_prepost
						arrValues.add("N");//terms_supportdoc
						arrValues.add(correctNull((String)arrTermsType.get(i)));//terms_prdcode
						arrValues.add(String.valueOf(sno));
						sno++;
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
						k=i;	
					}
					if(arrTermsId.size()>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				
				if(!correctNull((String) hshValues.get("strtermCond")).isEmpty())
				{	
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","apptermscondinsdigi");
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(String.valueOf(k+1));
				arrValues.add(correctNull((String) hshValues.get("strtermCond")));
				arrValues.add("A");
				arrValues.add("N");
				arrValues.add("P");
				arrValues.add("");
				arrValues.add("N");
				arrValues.add("");
				arrValues.add(String.valueOf(sno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				//Coapplicant Freeze
				hshValues.put("appno", strApplicationNo);
				PerApplicantBean perApplicantBean = new PerApplicantBean();
				perApplicantBean.getFreezeData(hshValues);
				
				//Credit Facilities freeze
				BankAppFIBean appFIBean = new BankAppFIBean();
				appFIBean.updateFreezeData(hshValues);
			
				//MIS Activity
				HashMap hshMISstatic = new HashMap();
				HashMap hshMISSubActivity = new HashMap();
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
					String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
					hshMISstatic.put(strSlcode,strPrdDesc);
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
					String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
					hshMISSubActivity.put(strSubcode,strSubPrdDesc);
				}
				
				
				String strActivity = " and mac.ACT_ACTIVITYCODE in (";
				String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
				String stractivitycode=strActCode;
				if(rs1!=null)
				{	  rs1.close();		}
				strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{ 
					hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
					hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
					hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
					hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
					hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
					hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
					hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
					hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
					hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
					hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
					hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
					hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
					hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
					hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
					hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
					String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
					String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
					if(strMainActivityCode.length()>0)
					{
						hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
					}
					
					if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
					{
						String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
						hshValues.put("strMainSubA/ctivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
					}
					
					hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
					hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
					
					hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
					hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
					hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
				}
				
				double dblTotLim=0.00;
				double dblTotLimAgr=0.00;
				double dblTotLimSer=0.00;
				
				MisBean misbean=new MisBean();
				
				dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
				dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strApplicationNo);
				dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strApplicationNo);
				
				int querycount=0;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
				arrValues.add("N");//Whether under Service Area Approach
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
				arrValues.add(strperappcity);
				arrValues.add(strperappdistrict);
				arrValues.add(strperappstate);
				arrValues.add(strorg_branchin);//Place - Metro
				arrValues.add("N"); //Does repayment depend purely on the asset financed
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
				arrValues.add("00");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
				arrValues.add(strActCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
				arrValues.add("1"); //Asset Classification
				arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
				arrValues.add("1"); //fac serial no
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sharebroker")));
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				String strQueryAgr="";
				strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
				MISLogger.UpdateLogger(strQueryAgr);
				rs1=DBUtils.executeQuery(strQueryAgr);
				if(rs1.next())
				{
					hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
					hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
					hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
					hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
					hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
					hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
				}
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				querycount++;
				hshQuery.put("strQueryId","ins_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
				arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
				arrValues.add("1");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(querycount),hshQuery);
				
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
				MISLogger.UpdateLogger(strQuery);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
					{
						if(rs!=null)
							rs.close();
						strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshQueryValues.put("size","5");
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							querycount++;
							hshQuery.put("strQueryId","upd_cbsdetails");
							arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
							arrValues.add(strApplicationNo);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(querycount),hshQuery);
						}
					}
				}
				hshQueryValues.put("size",String.valueOf(querycount));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				String strAppStatus="";
				String strPriorityType="";
				String strPrioritySubsector="";
				String strWeakerSectionSubSector="";
				String strAgriIndConfig="";
				String strTwentyPointPgm="";
				String strSensitiveSector="";
				String strInfracode="";
				String strGovtAnnounceScheme="";
				String strClassiMaster_Sno="";
				String strActivityCode="";
				String strActivitySno="";
				HashMap hshPriority=new HashMap();
				String strFacilitySno="1";
				String strStandUpIndia="";

				hshValues.put("strFacilitySno",strFacilitySno);
				hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
				//hshValues.put("strHOLIDAYPERIOD","0");
				hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
				hshValues.put("hidapplicantnewid",strLAPSid);
				hshValues.put("strAppType","P");
				
				hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
				 
				 	hshQueryValues=new HashMap();
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_misappclassification_digi");
					arrValues.add(strApplicationNo);
					arrValues.add(strAgriIndConfig);
					arrValues.add(strPriorityType);
					arrValues.add(strPrioritySubsector);
					arrValues.add(strSensitiveSector);
					arrValues.add(strWeakerSectionSubSector);
					arrValues.add(strTwentyPointPgm);
					arrValues.add(strInfracode);
					arrValues.add(strGovtAnnounceScheme);
					arrValues.add(strClassiMaster_Sno);
					arrValues.add(strFacilitySno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
				// mis end

					
				//CBS Details
				 
				if(rs != null)
				   rs.close(); 	 
				String strAppend="",strmodeofadv="";
				strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
				strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
				}

				if(rs!=null)
				rs.close();
				String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
				strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
					freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
					freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
					freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
					finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
					finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
				}
				
				
				
				String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
				
				strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
				}
				if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
				{
					strLoanType="LAA";
				}
				else if(strLoanType.equalsIgnoreCase("OD"))
				{
					strLoanType="ODA";
				}
				strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
				}
 				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(freeCode6);
				arrValues.add(freeCode7);
				arrValues.add(freeCode8);
				arrValues.add("01");//strModeOfOperation
				arrValues.add("E");//strDrawingPowerInd
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
				arrValues.add("N"); // Account Handoff
				arrValues.add("01");//strAdvanceNature
				arrValues.add(strAdvanceType);
				arrValues.add(strmodeofadv);
				arrValues.add("10"); //default 10
				arrValues.add("999"); //default 999
				arrValues.add(strsolid);
				arrValues.add(""); //Security Code
				arrValues.add(strintratefrq);
				arrValues.add(finfreeCode7);
				arrValues.add(finfreeCode8);
				arrValues.add(strlbrcode);
				arrValues.add(strFacilitySno);
				arrValues.add("Residential Property");
				arrValues.add(""); //facilityschemecode
				arrValues.add(""); //facility_glsubheadcode
				arrValues.add("99"); //laps free code 1
				arrValues.add("99"); //laps free code 2
				arrValues.add("99"); //laps free code 3
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_cbsdetails");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
				
		  	//deviation Details
		  		ArrayList arrdevdet=new ArrayList();
				ArrayList arrdevdetval=new ArrayList();
				arrdevdet=(ArrayList) hshValues.get("arrdevdet");
				
				int arrdevdetlen=arrdevdet.size();
				if(arrdevdetlen>0)
				{
					for(int i=0;i<arrdevdetlen;i++)
					{
						arrdevdetval=(ArrayList) arrdevdet.get(i);
						
						//amber rules
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "upd_demogra_amberrules");
						arrValues = new ArrayList();
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(7)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(8)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(9)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(10)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(13)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(11)));
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(12)));
						arrValues.add(strApplicationNo);
						arrValues.add(Helper.correctNull((String)arrdevdetval.get(1))); 
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}
				}	
					// score details
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "upd_Loandetails_deviation_bre");
					arrValues = new ArrayList();
					arrValues.add(correctNull((String) hshValues.get("deviationROI"))); 
					arrValues.add(correctNull((String) hshValues.get("digiFOIR"))); 
					arrValues.add(correctNull((String) hshValues.get("deviationLoanAmount"))); 
					arrValues.add(correctNull((String) hshValues.get("digiMaxEmi"))); 
					arrValues.add(correctNull((String) hshValues.get("digiNMI"))); 
					arrValues.add(correctNull((String) hshValues.get("digiNMImultiplier"))); 
					arrValues.add(correctNull((String) hshValues.get("stramrtOverride")));
					arrValues.add(correctNull((String) hshValues.get("stramrtOverrideLoanAmount")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				if(Helper.correctNull((String)hshValues.get("strdeviation")).equalsIgnoreCase("Y"))
				{
					int intupdatesize=0;

					if(!Helper.correctNull((String)hshValues.get("deviationROI")).equals(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strApplicationNo);
						arrValues.add("IR");//txt_interestdivtype
						arrValues.add(String.valueOf(jtn.format(intrate))); //txt_interestrateold
						arrValues.add(correctNull((String) hshValues.get("deviationROI")));
						arrValues.add("Y");//sel_interestrate
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					if(!Helper.correctNull((String)hshValues.get("deviationFOIR")).equals(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strApplicationNo);
						arrValues.add("RC");//
						arrValues.add("60");
						arrValues.add(Helper.correctNull((String)hshValues.get("deviationFOIR")));
						arrValues.add("N");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					if(!Helper.correctNull((String)hshValues.get("deviationFOIR")).equals(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strApplicationNo);
						arrValues.add("RC");//
						arrValues.add("60");
						arrValues.add(Helper.correctNull((String)hshValues.get("deviationFOIR")));
						arrValues.add("Y");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					if(!Helper.correctNull((String)hshValues.get("deviationLoanAmount")).equals(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strApplicationNo);
						arrValues.add("LA");
						arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
						arrValues.add(correctNull((String) hshValues.get("deviationLoanAmount")));
						arrValues.add("Y");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_amount_loandetails");
						intupdatesize++;
						arrValues.add(Helper.correctDouble((String) hshValues.get("deviationLoanAmount")));
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);		
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_BREupdate_flag");
					intupdatesize++;
					arrValues.add("Y");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQueryValues.put("size",Integer.toString(intupdatesize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				}
				
				/*hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_birdata");	
				arrValues.add(strApplicationNo);
				arrValues.add("N");
				arrValues.add("0.00");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				
				//documents 

				hshValues.put("strUserId", strUserId);
				hshValues.put("app_no", strApplicationNo);
				//hshValues=getDocumentURLs(hshValues);
				
				//APPRAISALSANCTION table
				/*hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strUserId);//appraised by
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
				arrValues.add("Y");//appraisal flag
				arrValues.add("02");//sanclevel
				arrValues.add("51");//sancauth
				arrValues.add("016");//sancdepart
				arrValues.add("RET");//sancbranch
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				
				//sanction
				if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equals("sanction"))
				{
						
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updapplicationsfinalsanction");
					arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "updinwardappstatus");
					arrValues.add("pa");
					arrValues.add(strInwardno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","commworkflowupddigi");
					arrValues.add("pa");
					arrValues.add(strUserId);
					arrValues.add(strOrgScode);
					arrValues.add("");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					hshQueryValues.put("size","3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
					//sanction reference numnber
					CommWorkflowBean commwrkfko=new CommWorkflowBean();
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
						hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
						hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
						hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
					}
					hshValues.put("hidAction", "approve");
					hshValues.put("sessionModuleType", "RET");
					hshValues.put("strApplicationType", "F");
					hshValues.put("digiloan", "Y");

					String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
					
					hshValues.put("strReferenceno", strReferenceno);
					hshValues.put("strSanctionDate", Helper.getCurrentDateTime());

				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_specialMargin");
				arrValues.add(correctNull((String) hshValues.get("strmargin")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   
				hshQuery.put("strQueryId","ins_retailcomments");
				arrValues.add(strApplicationNo);
				arrValues.add("LoanProd");
				arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
				
				
				
				
				if((correctNull((String) hshValues.get("strTakeover"))).equalsIgnoreCase("Y"))
				{
				String installamt_transbank="",
				 overdue_install="",
				 overdue_interest="",
				 tot_overdue="",
				 takeover_amtpaid ="",
				 tot_liability ="",
				 loanamt_transbank ="",
				 str_shifting_reason ="",
				 str_holiday_period ="",
				 str_rate_of_interest ="",
				 str_prevbank_opinion ="",
				 str_stmt_dt_from ="",
				 str_stmt_dt_to ="",
				 str_stmt_comments ="",
				 str_due_due ="";
		    		
				installamt_transbank = correctNull((String) hshValues.get("strStallmentStipulated"));
				if (installamt_transbank.equals(""))
				{
					installamt_transbank = "0.00";
				}
				loanamt_transbank = Helper.correctDouble((String) hshValues.get("strLoanAmntTransferBank"));
				if (loanamt_transbank .equals(""))
				{
					loanamt_transbank  = "0.00";
				}
				String loan_frombank = Helper.correctDouble((String) hshValues.get("strLoanAmntTransferBank"));
				if (loan_frombank .equals(""))
				{
					loan_frombank = "0.00";
				}
				overdue_install = correctNull((String) hshValues.get(""));
				if (overdue_install.equals(""))
				{
					overdue_install = "0.00";
				}
				overdue_interest = correctNull((String) hshValues.get(""));//need to change
				if (overdue_interest.equals(""))
				{
					overdue_interest = "0.00";
				}
				tot_overdue = correctNull((String) hshValues.get("strOverdueAmount"));
				if (tot_overdue.equals(""))
				{
					tot_overdue = "0.00";
				}
				takeover_amtpaid = correctNull((String) hshValues.get("strAmountPaidTransfer"));
				if (takeover_amtpaid .equals(""))
				{
					takeover_amtpaid  = "0.00";
				}
				tot_liability = correctNull((String) hshValues.get("strTotalLiability"));
				if (tot_liability  .equals(""))
				{
					tot_liability   = "0.00";
				}
				str_shifting_reason=Helper.correctNull((String)hshValues.get("strReasonShiftBank"));
				str_holiday_period=Helper.correctNull((String)hshValues.get("strHolidayperiod"));
				str_rate_of_interest=Helper.correctNull((String)hshValues.get("strInterestRateTakeOver"));
				str_prevbank_opinion=Helper.correctNull((String)hshValues.get("strOpinionDetails"));
				str_stmt_dt_from=Helper.correctNull((String)hshValues.get("strAccountStatementFrom"));
				str_stmt_dt_to=Helper.correctNull((String)hshValues.get("strAccountStatementTo"));
				str_stmt_comments=Helper.correctNull((String)hshValues.get("strComments"));
				//str_due_due=Helper.correctNull((String)hshValues.get("strAsOnDateOvrdue"));
				str_due_due=Helper.correctNull((String)hshValues.get("strInstallmentLastDate"));
				
				
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(loan_frombank);
					arrValues.add(correctNull((String) hshValues.get("strLoanFromBank")));
					arrValues.add(loanamt_transbank);
					arrValues.add(installamt_transbank);
					arrValues.add(correctNull((String) hshValues.get("strRepaymentPeriod")));
					String avail_date=Helper.correctNull((String) hshValues.get("strLateOfAvailing"));
					if(avail_date.equalsIgnoreCase(""))
					{
						avail_date="01/01/1900";
					}
					arrValues.add(avail_date);
					String fromdate=Helper.correctNull((String) hshValues.get("strInstallmentStartDate"));
					if(fromdate.equalsIgnoreCase(""))
					{
						fromdate="01/01/1900";
					}
					arrValues.add(fromdate);
					arrValues.add(tot_liability );
					arrValues.add(correctNull((String) hshValues.get("strNoOfInstallmentPaid")));
					
					String ason_date=Helper.correctNull((String) hshValues.get("strAsOnDateOvrdue"));
					if(ason_date.equalsIgnoreCase(""))
					{
						ason_date="01/01/1900";
					}
					arrValues.add(ason_date);	
					String uptodate=Helper.correctNull((String) hshValues.get("strUptoDate"));
					if(uptodate.equalsIgnoreCase(""))
					{
						uptodate="01/01/1900";
					}
					
						
					arrValues.add(uptodate);	
					arrValues.add(Helper.correctNull((String) hshValues.get("strRegularLoanAcc")));
					arrValues.add(overdue_install);
					arrValues.add(overdue_interest);
					arrValues.add(tot_overdue);
					arrValues.add(takeover_amtpaid );
					arrValues.add(Helper.correctNull((String) hshValues.get("strInstallmentTrnsBank")));
					String Overason_date=Helper.correctNull((String) hshValues.get("strAsOnDateOvrdue"));
					if(Overason_date.equalsIgnoreCase(""))
					{
						Overason_date="01/01/1900";
					}
					arrValues.add(Overason_date);
					arrValues.add(str_shifting_reason);
					arrValues.add(str_holiday_period);
					arrValues.add(str_rate_of_interest);
					arrValues.add(str_prevbank_opinion);
					arrValues.add(str_stmt_dt_from);
					arrValues.add(str_stmt_dt_to);
					arrValues.add(str_stmt_comments);
					arrValues.add(str_due_due);
					arrValues.add("");
					hshQueryValues.put("size", "1");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "takeoverins");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				//RepaymentSchedule	
				ArrayList arrRepaySchedule=new ArrayList();
				ArrayList arrrepayValue=new ArrayList();
				arrRepaySchedule=(ArrayList) hshValues.get("arrRepaymentSchedule");
				int arrrepayScheduleSize=arrRepaySchedule.size();
				int serialNo=0;
				int facCode=1;
				if(arrrepayScheduleSize>0)
				{
					for(int i=0;i<arrrepayScheduleSize;i++)
					{
				serialNo++;	
				arrrepayValue=(ArrayList) arrRepaySchedule.get(i);
				
				
				String frequency=correctNull((String)arrrepayValue.get(0));
				String instlmntAmount=Helper.correctInt((String)arrrepayValue.get(1));
				String noInstlmnt=Helper.correctInt((String)arrrepayValue.get(2));
				String totalAmnt=Helper.correctInt((String)arrrepayValue.get(3));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_repaymnt_schdule");
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(String.valueOf(serialNo));
				arrValues.add(String.valueOf(facCode));
				arrValues.add(frequency);
				arrValues.add(instlmntAmount);
				arrValues.add(noInstlmnt);
				arrValues.add(totalAmnt);
				arrValues.add("P");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
					}
					}
				
				//home comfort,topup loan and Home connect
				if(strloanpurpose.equalsIgnoreCase("F") || strloanpurpose.equalsIgnoreCase("T")|| strloanpurpose.equalsIgnoreCase("HC"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "updcomworkflowappamt");
					arrValues = new ArrayList();
					arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
					if(strloanpurpose.equalsIgnoreCase("F"))
					{
						arrValues.add("75");
					}
					else
					{
						arrValues.add("");
					}
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				}
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "upd_emioldval");
				arrValues = new ArrayList();
				if(correctNull((String) hshValues.get("strRepaymentType")).equalsIgnoreCase("2"))
				{
					arrValues.add(instlmntAmountforNonEmi);
				}else{
				arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
				}
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				hshValues.put("strApplication", strApplicationNo);
				hshValues.put("strResponseCode", "LAPS-1010");
				hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForHL..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForHL in closing connection..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	
	
	public HashMap updateSecurityDetails(HashMap hshValues)  
	{
		HashMap hshQuery = null;
		ArrayList arrValues= null;
		HashMap hshQueryValues= new HashMap();
		
		String strSolid=Helper.correctNull((String)hshValues.get("strsolID"));
		ResultSet rs=null,rs1=null;
		String strQuery="",strSecurityId="", strLapsId="",strOldLapsId="";
		

		try
		{
			strLapsId = Helper.correctNull((String)hshValues.get("strLapsId"));	
			
			if (rs != null) 
			{  	rs.close();  }
			strQuery = SQLParser.getSqlQuery("select_perappoldid^"+strLapsId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strOldLapsId = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
			
    		String strSysUser="SYSUSR",strusrorg="";
			
			if (rs != null) 
			{  rs.close(); 	}
			/*strQuery = SQLParser.getSqlQuery("setuserssel^"+strSysUser);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strusrorg = Helper.correctNull((String) rs.getString("usr_orgcode"));
    		}*/
		
			String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="";
			
			String strvehicleCatogery=Helper.correctNull((String)hshValues.get("strvehicleCatogery"));

			
			/*if(strvehicleCatogery.equalsIgnoreCase("3"))
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strSolid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					 if(strOrgScode.equalsIgnoreCase("888") || strOrgScode.equalsIgnoreCase("250") || strOrgScode.equalsIgnoreCase("450"))
						{
								strOrgScode = "888";
						}else if (strOrgScode.equalsIgnoreCase("950") || strOrgScode.equalsIgnoreCase("500") || strOrgScode.equalsIgnoreCase("350") 
									|| strOrgScode.equalsIgnoreCase("650"))	
						{
							strOrgScode = "950";
						}else{
							strOrgScode = "600";
						}
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			else*/
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					//strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			
    		
    		SecurityMasterBean secMasBean =new SecurityMasterBean();
			strSecurityId = secMasBean.getOldAppidWithSno(strOldLapsId);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_securities_details");	
			arrValues.add(strSecurityId);
			arrValues.add(correctNull((String)hshValues.get("strSecurityType")));
			arrValues.add(correctNull((String)hshValues.get("strSecurityClassification")));
			arrValues.add(correctNull((String)hshValues.get("strAlChrgdToOtherBanks")));
			arrValues.add(correctNull((String)hshValues.get("strNatureOfCharge")));
			arrValues.add(correctNull((String)hshValues.get("strValuerName"))); 
			arrValues.add(correctNull((String)hshValues.get("strDateOfSubmissionForValuation")));
			arrValues.add(correctNull((String)hshValues.get("strDateOfReceiptOfValuation")));
			arrValues.add(correctNull((String)hshValues.get("strDateOfValuation")));
			arrValues.add(correctNull((String)hshValues.get("strSecurityDescription"))); 
			arrValues.add(correctNull((String)hshValues.get("strCollateralStartDate")));
			arrValues.add(correctNull((String)hshValues.get("strCollateralEndDate")));
			arrValues.add(String.valueOf(Helper.correctDouble((String)hshValues.get("strTotalSecurityValue"))));
			arrValues.add(String.valueOf(Helper.correctDouble((String)hshValues.get("strTotalSecurityValue"))));
			arrValues.add("Y");
			arrValues.add("V");
			arrValues.add(strSysUser);
			arrValues.add(strOrgCode);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_vehicleloan_property_details");
			arrValues.add(strSecurityId);
			arrValues.add(correctNull((String)hshValues.get("strvehicleType")));
			arrValues.add(correctNull((String)hshValues.get("strvehicleCatogery")));
			arrValues.add(correctNull((String)hshValues.get("strmodel")));
			arrValues.add(correctNull((String)hshValues.get("strvehicleAge")));
			arrValues.add(correctNull((String)hshValues.get("strbookValue")));
			arrValues.add(correctNull((String)hshValues.get("strpurchasePrice")));
			arrValues.add(correctNull((String)hshValues.get("strengineNo")));
			arrValues.add(correctNull((String)hshValues.get("strregState")));
			arrValues.add(correctNull((String)hshValues.get("strdealerName")));
			arrValues.add(correctNull((String)hshValues.get("strcontactNo")));
			arrValues.add(correctNull((String)hshValues.get("strdealerAddress")));
			arrValues.add(correctNull((String)hshValues.get("strdealerCity")));
			arrValues.add(correctNull((String)hshValues.get("strdealerDistrict")));
			arrValues.add(correctNull((String)hshValues.get("strdealerCountry")));
			arrValues.add(correctNull((String)hshValues.get("strdealerpinCode")));
			arrValues.add(correctNull((String)hshValues.get("strdealerCode")));
			arrValues.add(correctNull((String)hshValues.get("strdealerGstNo")));
			arrValues.add(correctNull((String)hshValues.get("strbelongingTo")));
			arrValues.add(correctNull((String)hshValues.get("strdoorNo")));
			arrValues.add(correctNull((String)hshValues.get("strparkingAddress")));
			arrValues.add(correctNull((String)hshValues.get("strparkingCity")));
			arrValues.add(correctNull((String)hshValues.get("strparkingState")));
			arrValues.add(correctNull((String)hshValues.get("strparkingCountry")));
			arrValues.add(correctNull((String)hshValues.get("strparkingPinCode")));
			arrValues.add(correctNull((String)hshValues.get("strcompany")));
			arrValues.add(correctNull((String)hshValues.get("strDealeraddress2")));
			arrValues.add(correctNull((String)hshValues.get("strMake")));
			arrValues.add(correctNull((String)hshValues.get("strOwneraddress2")));
			arrValues.add(correctNull((String)hshValues.get("strOwnersalutation")));
			arrValues.add(correctNull((String)hshValues.get("strdealerState")));
			
			/*arrValues.add(correctNull((String)hshValues.get("strPropertyType")));
			arrValues.add(correctNull((String)hshValues.get("strPlotNo")));
			arrValues.add(correctNull((String)hshValues.get("strStreetNo")));
			arrValues.add(correctNull((String)hshValues.get("strWardNo")));
			arrValues.add(correctNull((String)hshValues.get("strAddress"))); 
			arrValues.add(correctNull((String)hshValues.get("strCity")));
			arrValues.add(correctNull((String)hshValues.get("strDistrict")));
			arrValues.add(correctNull((String)hshValues.get("strState")));
			arrValues.add(correctNull((String)hshValues.get("strPinCode")));
			arrValues.add(correctNull((String)hshValues.get("strTotalArea")));
			arrValues.add(correctNull((String)hshValues.get("strExtentOfBuilding")));
			arrValues.add(correctNull((String)hshValues.get("strValueAsPerValuation")));
			arrValues.add(correctNull((String)hshValues.get("strForcedSaleValue")));
			arrValues.add(correctNull((String)hshValues.get("strTitleDeedsBranch")));
			arrValues.add(correctNull((String)hshValues.get("strSurveyNo")));
			arrValues.add(correctNull((String)hshValues.get("strPropertyAcquisition")));
			arrValues.add(correctNull("3"));
			arrValues.add(correctNull("3"));*/
			
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
		
			/*
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_legalopinion_details");
			arrValues.add(strSecurityId);
			arrValues.add(correctNull((String)hshValues.get("strLegalAdviserName")));
			arrValues.add(correctNull((String)hshValues.get("strDateOfSubmissionForLegalOpinion")));
			arrValues.add(correctNull((String)hshValues.get("strDateOfReceiptOfLegalOpinion")));
			arrValues.add(correctNull((String)hshValues.get("strDateOfLegalOpinion"))); 
			arrValues.add(correctNull((String)hshValues.get("strFlowOfTitle")));
			arrValues.add(correctNull((String)hshValues.get("strECObtained")));
			arrValues.add(correctNull((String)hshValues.get("strLatestTaxPaidYear")));
			arrValues.add(correctNull((String)hshValues.get("strFlowOfTitleSearchFromProp")));
			arrValues.add(correctNull((String)hshValues.get("strPeriodOfEC")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
			hshQueryValues.put("size","3");	*/
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_ownership_securities");
			arrValues.add(strSecurityId);
			arrValues.add(strOldLapsId);
			arrValues.add("1");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
			
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_sec_inbox_new");
			arrValues.add(strSecurityId);
			arrValues.add(strSysUser);
			arrValues.add("N");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("4",hshQuery);
			hshQueryValues.put("size", "4");
			
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshValues.put("strSecurityId", strSecurityId);
			hshValues.put("strResponseCode", "LAPS-1012");
			hshValues.put("strResponseMsg", "Security Details Created Successfully");			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean updateSecurityDetails..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean updateSecurityDetails in closing connection..."+e.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap cbsIDCreationService(HashMap hshValues)  {
		String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = "", strInputXMLRequest = "", strRes = "", strCustDesc = "", strEntity = "", strService = "", strRetCustAdd_CustomData = "", strStatus = "", strSalutation = "", strFirstName = "", strBirthDt = "", strBirthMonth = "", strBirthYear = "", strDateOfBirth = "", strGender = "", strStaffEmployeeId = "", strPhoneNum = "", strPhoneNumLocalCode = "", strLastName = "", strShortName = "", strComAddrLine1 = "", strComAddrLine2 = "", strComCity = "", strComState = "", strComCountry = "", strComPostalCode = "", strPerAddrLine1 = "", strPerAddrLine2 = "", strPerCity = "", strPerState = "", strPerCountry = "", strPerPostalCode = "", strNameOfIntroducer = "", strStatusCodeOfIntroducer = "", strPAN = "", strEmploymentStatus = "", strMaritalStatus = "", strServiceRequestVersion = "", strChannelId = "", strBankId = "", strRequestUUID = ""
	        , strEntityType = "", strMessageDateTime = "", strCreatedBySystemId ="", strRelationshipOpeningDt = "", strType ="";

	ResultSet rs = null;
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
	
	try {
		strActiontype = Helper.correctNull((String) hshValues.get("hidSelChk"));
		String strApplicantID =Helper.correctNull((String) hshValues.get("hidborrowerid"));  
		
		String strappno = Helper.correctNull((String) hshValues.get("strappno"));
		double strincome=0.00;
		rs = DBUtils
				.executeLAPSQuery("sel_cbsIdCreation^" + strApplicantID);
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
			strDemoType=Helper.correctNull((String) rs.getString("demo_type"));
		
		}
		/*if(strCustFlag.equalsIgnoreCase("V"))
			hshCbsUnderVer=this.cbsIdUnderVerification(hshValues);
		else*/
		{
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
			Date date1=sdf.parse(strKYC_ID_VALID);
			strKYC_ID_VALID=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(date1);
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
		
		//strRelationshipOpeningDt = Helper.getCurrentDateTime();
		/*SimpleDateFormat simpleDateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		strRelationshipOpeningDt=simpleDateformat.format(new Date());*/
		
		
		strType = "CURRENCY";
		
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
		
		
			
			
			strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML  xsi:schemaLocation='http://www.finacle.com/fixml RetCustAdd.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'><Header>" +
					"<RequestHeader><MessageKey><RequestUUID>Req_"+strRequestUUID+"</RequestUUID><ServiceRequestId>RetCustAdd</ServiceRequestId>" +
					"<ServiceRequestVersion>"+strServiceRequestVersion+"</ServiceRequestVersion><ChannelId>"+strChannelId+"</ChannelId>" +
						"<LanguageId></LanguageId></MessageKey><RequestMessageInfo><BankId>01</BankId><TimeZone></TimeZone><EntityId></EntityId>" +
					"<EntityType></EntityType><ArmCorrelationId></ArmCorrelationId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime>"+										
						"</RequestMessageInfo><Security><Token><PasswordToken><UserId></UserId><Password></Password></PasswordToken>" +
						"</Token><FICertToken></FICertToken><RealUserLoginSessionId></RealUserLoginSessionId><RealUser></RealUser>" +
						"<RealUserPwd></RealUserPwd><SSOTransferToken></SSOTransferToken></Security></RequestHeader></Header>" +
						"<Body><RetCustAddRequest><RetCustAddRq><CustDtls><CustData><CreatedBySystemId>"+strCreatedBySystemId+"</CreatedBySystemId>" +
						"<PrimarySolId>"+PERAPP_BRANCHCODE+"</PrimarySolId><Salutation>"+strSalutation+"</Salutation>" +
						"<FirstName></FirstName><BirthDt>"+strBirthDt+"</BirthDt><BirthMonth>"+strBirthMonth+"</BirthMonth>" +
						"<BirthYear>"+strBirthYear+"</BirthYear><DateOfBirth>"+dateOfBirth+"</DateOfBirth><StaffFlag>N</StaffFlag><StaffEmployeeId></StaffEmployeeId>" +
						"<CombinedStmtFlag>N</CombinedStmtFlag><Community>"+strcommunity+"</Community><CustStatusChangeDt>"+strMessageDateTime+"</CustStatusChangeDt>" +
						"<PhoneEmailDtls><PhoneOrEmail>PHONE</PhoneOrEmail><PhoneNum>"+strPhoneNum+"</PhoneNum>" +
						"<PrefFlag>Y</PrefFlag><PhoneEmailType>COMMPH1</PhoneEmailType><PhoneNumCountryCode>91</PhoneNumCountryCode><PhoneNumLocalCode>"+strPhoneNumLocalCode+"</PhoneNumLocalCode>" +
						"</PhoneEmailDtls><PhoneEmailDtls><PhoneOrEmail>PHONE</PhoneOrEmail><PhoneNum>"+strPhoneNum+"</PhoneNum><PrefFlag>N</PrefFlag>" +
						"<PhoneEmailType>CELLPH</PhoneEmailType><PhoneNumCountryCode>91</PhoneNumCountryCode><PhoneNumLocalCode>"+strPhoneNum+"</PhoneNumLocalCode>" +
						"</PhoneEmailDtls><NationalIdCardNum></NationalIdCardNum><Language>INFENG</Language><LastName>"+strFirstName+"</LastName>" +
						"<IsMinor>N</IsMinor><IsCustNRE>N</IsCustNRE><GuardianName></GuardianName><DefaultAddrType>Mailing</DefaultAddrType>" +
						"<Gender>"+strGender+"</Gender><Manager>UBSADMIN</Manager><NativeLanguage>INFENG</NativeLanguage><NativeLanguageCode>INFENG</NativeLanguageCode>" +
						"<Status></Status><Occupation>"+kyc_occupationcode+"</Occupation><PrefName>"+strFirstName+"</PrefName><Region>OTHERS</Region>" +
						"<RelationshipOpeningDt>"+strMessageDateTime+"</RelationshipOpeningDt><SegmentationClass>CLSA</SegmentationClass>" +
						"<ShortName>"+strLastName+"</ShortName><StaffFlag>N</StaffFlag><SubSegment>Sub Class A</SubSegment><AddrDtls><Telex></Telex><PagerNum></PagerNum><AddrCategory>Home</AddrCategory>" +
						"<FreeTextLabel>Home</FreeTextLabel><PrefAddr>N</PrefAddr><PrefFormat>FREE_TEXT_FORMAT</PrefFormat><StartDt>"+strMessageDateTime+"</StartDt>" +
						"<AddrLine1>"+strComAddrLine1+"</AddrLine1><AddrLine2>"+strComAddrLine2+"</AddrLine2><City>"+strComCity+"</City>" +
						"<State>"+strComState+"</State><Country>"+strPerCountry+"</Country><PostalCode>"+strComPostalCode+"</PostalCode><EndDt>2099-01-01T00:00:00.000</EndDt>" +
						"<HoldMailFlag>N</HoldMailFlag><Suburb>"+strComPostalCode+"-001</Suburb></AddrDtls><AddrDtls><Telex></Telex><PagerNum></PagerNum><AddrCategory>Mailing</AddrCategory><FreeTextLabel>Mailing</FreeTextLabel>" +
						"<PrefFormat>FREE_TEXT_FORMAT</PrefFormat><PrefAddr>Y</PrefAddr><AddrLine1>"+strPerAddrLine1+"</AddrLine1>" +
						"<AddrLine2>"+strPerAddrLine2+"</AddrLine2><City>"+strComCity+"</City><State>"+strPerState+"</State><Country>"+strPerCountry+"</Country><PostalCode>"+strPerPostalCode+"</PostalCode>" +
						"<StartDt>"+strMessageDateTime+"</StartDt><EndDt>2099-01-01T00:00:00.000</EndDt><HoldMailFlag>N</HoldMailFlag><Suburb>"+strPerPostalCode+"-001</Suburb></AddrDtls>" +
						"<SalutationCodeOfIntroducer></SalutationCodeOfIntroducer><NameOfIntroducer></NameOfIntroducer><TradeFinFlag>N</TradeFinFlag>" +
						"<TaxDeductionTable>"+strTaxslab+"</TaxDeductionTable><IsEbankingEnabled>N</IsEbankingEnabled><PAN></PAN><CustType>01</CustType></CustData></CustDtls><RelatedDtls><DemographicData><DemographicMiscData><Type>Employed</Type>" +
						"<strtext2>194</strtext2><EntityCreFlag>Y</EntityCreFlag><Type>CURRENT_EMPLOYMENT</Type></DemographicMiscData><EmploymentStatus>"+strEmploymentStatus+"</EmploymentStatus>" +
						"<MaritalStatus>"+strMaritalStatus+"</MaritalStatus><SourceOfIncome>03</SourceOfIncome><Nationality>INDIAN</Nationality><NationalityCode>IND</NationalityCode>" +
						"</DemographicData><EntityDoctData><CountryOfIssue>IN</CountryOfIssue><DocCode>"+idprooftype+"</DocCode>"+strexpdateTag+"<IssueDt>"+strMessageDateTime+"</IssueDt>" +
						"<TypeCode>"+TypeCode+"</TypeCode><PlaceOfIssue>"+strPerCity+"</PlaceOfIssue><ReferenceNum>"+KYC_IDPROOFREF+"</ReferenceNum><preferredUniqueId>Y</preferredUniqueId>" +
						"</EntityDoctData><PsychographicData><PsychographMiscData><EntityCreFlag>Y</EntityCreFlag><StrText10>INR</StrText10><Type>"+strType+"</Type><DTDt1>2099-12-31T00:00:00.000</DTDt1></PsychographMiscData>" +
						"<SegmentationClass>CLSA</SegmentationClass><preferred_Locale>en_US</preferred_Locale><PrefName>Y</PrefName></PsychographicData></RelatedDtls><RetCustAdd_CustomData><EnableCRMAlerts>N</EnableCRMAlerts>" +
						"<FreeCode5>99999</FreeCode5><FreeCode10>"+freecode10+"</FreeCode10><Constitution_Code>"+strPERAPP_CONSTITUTION+"</Constitution_Code><Cust_Type>"+strPERAPP_CONSTITUTION+"</Cust_Type><AddressDet isMultiRec='Y'><userfield1>"+strPerPostalCode+"--001</userfield1></AddressDet>" +
						"<AddressDet isMultiRec='Y'><userfield1>"+strPerPostalCode+"--001</userfield1></AddressDet><AddressDet isMultiRec='Y'><userfield1>"+strPerPostalCode+"--001</userfield1></AddressDet><PurgeFlag>Y</PurgeFlag>" +
						"<MiscellaneousInfoDet isMultiRec='Y'><dbFloat3>0</dbFloat3></MiscellaneousInfoDet><MiscellaneousInfoDet isMultiRec='Y'><dbFloat3>0</dbFloat3></MiscellaneousInfoDet>" +
						"<MiscellaneousInfoDet isMultiRec='Y'><dbFloat3>0</dbFloat3></MiscellaneousInfoDet></RetCustAdd_CustomData></RetCustAddRq></RetCustAddRequest></Body></FIXML>";
							
			
			
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
			InputStreamReader isreader = new InputStreamReader(inputStream,
					"UTF-8");

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
	            	  strCustId=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId").item(0).getChildNodes().item(0).getNodeValue();
	            	  strCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("Desc").item(0).getChildNodes().item(0).getNodeValue();
	            	  strStatus=(String)((Element)nodesList.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							
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
				  /*  else
				    {/*
				    	OracleDataSource dataSource = new OracleDataSource();
				    	dataSource.setUser(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[1]);
						dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[2]);
						dataSource.setURL(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[0]);
						Connection con = dataSource.getConnection();
						PreparedStatement ps=null;
						
						ps=con.prepareStatement("update PERAPPLICANT set PERAPP_CBSID=?,PERAPP_CBSID_VER_FLAG=? where PERAPP_ID=?");
				    
						ps.setString(1,strCustId);//1
						ps.setString(2,"V");
						ps.setString(3,strApplicantID);
						ps.executeUpdate();
				    
						
						if (ps != null)
						{
							ps.close();
						}
						
						if (con != null)
						{
							con.close();
						}


				    */

				    
				    hshValues.put("apistatus", strStatus);
					hshValues.put("apistatusdesc", strCustDesc);
					hshValues.put("hidapplicantid", strApplicantID);
					hshValues.put("strappno", strappno);
				} 
				catch (Exception e) 
				{
					System.out.println("Exception.....................cbsIDCreationService");
					throw new EJBException("Exception in cbsIDCreationService ==="+e.getMessage());
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
						throw new EJBException("Error in cbsIDCreationService in closing Connection "+e.getMessage());
					}
				}

			    if(strStatus.equalsIgnoreCase("Success"))
			    {
					hshValues.put("newCustId", strCustId);

				    hshForVerification = this.custIdVerification(hshValues);
				    
				    String strResCifId = Helper.correctNull((String)hshForVerification.get("strResCifId"));
				    String strResDesc = Helper.correctNull((String)hshForVerification.get("strResDesc"));
				    String strResStatus = Helper.correctNull((String)hshForVerification.get("strResStatus"));
			
				    hshValues.put("apistatus", strResStatus);
					hshValues.put("apistatusdesc", strResDesc);
					if(strResStatus.equalsIgnoreCase("SUCCESS"))
					{	
						hshCbsAlmFields=this.cbsAmlFields(hshValues);
						
					if(!TypeCode.equals("ID PROOF RETAIL"))
					{
					hshPanMod=custIdPanModification(hshValues);
					}
					
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
									throw new EJBException("Exception in CbsIdCreationService ==="+e.getMessage());	
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
			hshValues=getDigiDecisionDetail(hshValues);
		}
				    
	} catch (Exception ex) {
		// .LogWriter.log(LAPSLogLevel.ERROR,""+"Exception in cbsIDCreationService"
		// + ex);
		throw new EJBException("Error in cbsIDCreationService"+ex.toString());
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
	
	public HashMap cbsIdModificationService(HashMap hshValues)
			 {
		String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = "", strInputXMLRequest = "", strRes = "", strCustDesc = "", strEntity = "", strService = "", strRetCustAdd_CustomData = "", strStatus = "", strSalutation = "", strFirstName = "", strBirthDt = "", strBirthMonth = "", strBirthYear = "", strDateOfBirth = "", strGender = "", strStaffEmployeeId = "", strPhoneNum = "", strPhoneNumLocalCode = "", strLastName = "", strShortName = "", strComAddrLine1 = "", strComAddrLine2 = "", strComCity = "", strComState = "", strComCountry = "", strComPostalCode = "", strPerAddrLine1 = "", strPerAddrLine2 = "", strPerCity = "", strPerState = "", strPerCountry = "", strPerPostalCode = "", strNameOfIntroducer = "", strStatusCodeOfIntroducer = "", strPAN = "", strEmploymentStatus = "", strMaritalStatus = "", strServiceRequestVersion = "", strChannelId = "", strBankId = "", strRequestUUID = ""
	        , strEntityType = "", strMessageDateTime = "", strCreatedBySystemId ="", strRelationshipOpeningDt = "", strType ="",dateOfBirth="";

		ResultSet rs = null; 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strResCustId="",strResCustDesc="",strResEntity="",strResService="",strResStatus="",strAddressFlag="",strPANflag="";
		String  strempadd1="",strempadd2="",strempcity="",strempstate="",strempzip="",stremphone="",strempemail="",strempname="";
		String PERAPP_BRANCHCODE="",kyc_occupationcode="",idprooftype="",KYC_IDPROOFREF="",streduqua="",stremail="",strresidenttype="",strAddressFlagperm="";
		double strincome=0.00;
		String strExp="$";

		try {
		
			SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
			strMessageDateTime=simpledateformat.format(new Date());
			
			
			String strApplicantID =Helper.correctNull((String) hshValues.get("hidborrowerid"));  
			strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));

			rs = DBUtils
					.executeLAPSQuery("sel_cbsIdCreation^" + strApplicantID);
			if (rs.next()) { 
				

				strSalutation = Helper.correctNull((String) rs.getString("PERAPP_TITLE"));
				strFirstName = Helper.correctNull((String) rs.getString("PERAPP_FNAME"));
				strDateOfBirth = Helper.correctNull((String) rs.getString("PERAPP_DOB"));
				strStaffEmployeeId = Helper.correctNull((String) rs.getString("PERAPP_RELAT_STAFFID"));
				strPhoneNum = Helper.correctNull((String) rs.getString("CON_COMPHONE"));
				strPhoneNumLocalCode = Helper.correctNull((String) rs.getString("CON_COMPHONE"));
				strLastName = Helper.correctNull((String) rs.getString("PERAPP_LNAME"));
				strGender = Helper.correctNull((String) rs.getString("PERAPP_SEX"));
				strShortName = Helper.correctNull((String) rs.getString("PERAPP_LNAME"));

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
				kyc_occupationcode = Helper.correctNull((String) rs .getString("PERAPP_BRANCHCODE"));
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
				
				
				strAddressFlag=Helper.correctNull((String) rs .getString("PERAPP_ADDRESSCHANGE_FLAG"));
				strPANflag=Helper.correctNull((String) rs .getString("PERAPP_PAN_FLAG"));
				strCustId=Helper.correctNull((String) rs .getString("PERAPP_CBSID"));
				strAddressFlagperm=Helper.correctNull((String) rs .getString("PERAPP_PERM_ADDRESSCHANGE_FLAG"));
				
			}
			
			if(strAddressFlag.equals("Y") || strAddressFlagperm.equals("Y"))
			{
				//strInputXMLRequest = strReqWriter.getBuffer().toString();
		
				strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xsi:schemaLocation='http://www.finacle.com/fixml RetCustMod.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>" +
						"<Header><RequestHeader><MessageKey><RequestUUID>"+strRequestUUID+"</RequestUUID><ServiceRequestId>RetCustMod</ServiceRequestId>" +
						"<ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>CRM</ChannelId><LanguageId></LanguageId></MessageKey><RequestMessageInfo>" +
						"<BankId>01</BankId><TimeZone></TimeZone><EntityId></EntityId><EntityType></EntityType><ArmCorrelationId></ArmCorrelationId>" +
						"<MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo><Security><Token><PasswordToken><UserId></UserId>" +
						"<Password></Password></PasswordToken></Token><FICertToken></FICertToken><RealUserLoginSessionId></RealUserLoginSessionId><RealUser></RealUser><RealUserPwd></RealUserPwd>" +
						"<SSOTransferToken></SSOTransferToken></Security></RequestHeader></Header><Body><RetCustModRequest><RetCustModRq><RetCustModMainData><CustModData>" +
						"<CustId>"+strCustId+"</CustId><RetAddrModDtls><AddrCategory>Mailing</AddrCategory><PrefFormat>FREE_TEXT_FORMAT</PrefFormat>" +
						"<PrefAddr>Y</PrefAddr><AddrLine1>"+strComAddrLine1+"</AddrLine1><AddrLine2>"+strComAddrLine2+"</AddrLine2>" +
						"<City>"+strComCity+"</City><State>"+strComState+"</State><Country>"+strPerCountry+"</Country>" +
						"<PostalCode>"+strComPostalCode+"</PostalCode><StartDt>"+strMessageDateTime+"</StartDt><EndDt>2099-01-01T00:00:00.000</EndDt><HoldMailFlag>N</HoldMailFlag>" +
						"</RetAddrModDtls></CustModData></RetCustModMainData></RetCustModRq></RetCustModRequest></Body></FIXML>";
				
				log.info("################@@@@@@@@@@@@@ CBS ID Modification Request @@@@@@@@@@@@@################"
								+ strInputXMLRequest);
				URL url = new URL(ApplicationParams.getStrCBSIDModification());
				log.info("cbsIdModificationService Url========== "+url);		
				HttpsURLConnection urlcon = (HttpsURLConnection) url.openConnection();
						
				urlcon.setRequestProperty("User-Agent", "");
				urlcon.setDoInput(true);
				urlcon.setDoOutput(true);
				urlcon.setRequestMethod("POST");
				urlcon.setRequestProperty("Content-Type","application/xml;charset=UTF-8");
				urlcon.setRequestProperty("Authorization", "Basic");
				OutputStream outputStream = urlcon.getOutputStream();
				OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
						
				BufferedWriter bWriter = new BufferedWriter(osw);
				bWriter.write(strInputXMLRequest);
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
					log.info("################@@@@@@@@@@@@@ CBS ID Modification Response @@@@@@@@@@@@@################"
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
		  		              strResStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							

		  		              NodeList nodesList = doc.getElementsByTagName("Body");
		  		              if(strResStatus.equalsIgnoreCase("SUCCESS"))
		  		              {
		                        strCustId=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId").item(0).getChildNodes().item(0).getNodeValue();
		                        strResCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("Desc").item(0).getChildNodes().item(0).getNodeValue();
		                        strResStatus=(String)((Element)nodesList.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							
		  		              }
		  		              else
		  		              {
		  		            	strResCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("ErrorDesc").item(0).getChildNodes().item(0).getNodeValue();
		  		              }
		                        
						if(!strResStatus.equalsIgnoreCase("Success"))
						{
						    	hshQueryValues = new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "ins_cbs_api_error_status");
								arrValues = new ArrayList();
								arrValues.add(strCustId);
								arrValues.add(strResCustDesc);//appraised by
								arrValues.add(strRequestUUID);
								arrValues.add("CBS Id modification");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} 
					catch (Exception e) 
					{
						System.out.println("Exception.....................");
						e.printStackTrace();
						throw new EJBException("Exception in ParserConfiguratio ==="+e.getMessage());
					}
				}
			}
			else
			{
				strResStatus="SUCCESS";
			}

			String  strpanAPIstatus="",strPanResCustDesc="";
			if(strPANflag.equals("Y"))
			{
				hshValues=custIdPanModification(hshValues);
				strpanAPIstatus=Helper.correctNull((String)hshValues.get("strResStatus"));
				strPanResCustDesc=Helper.correctNull((String)hshValues.get("strResDesc"));
			}
			else
			{
				strpanAPIstatus="SUCCESS";
			}
				
			//customer profile
			if(strResStatus.equalsIgnoreCase("Success") && strpanAPIstatus.equalsIgnoreCase("SUCCESS"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_cbscustid_cp_mod");
				arrValues.add("Y");
				arrValues.add(strApplicantID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
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
				rs=DBUtils.executeLAPSQuery("selBranchCityName^"+strRequestUUID);
				if(rs.next())
				{
					 strMessage=strMessage.replaceAll("@Branch", Helper.correctDouble(rs.getString("ORG_NAME")));
				}
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strRequestUUID);
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
					arrValues.add(strRequestUUID);
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
			if(!strResStatus.equalsIgnoreCase("SUCCESS"))
			{
			hshValues.put("apistatus", strResStatus);
			hshValues.put("apistatusdesc", strResCustDesc);
			}
			else if(!strpanAPIstatus.equalsIgnoreCase("SUCCESS"))
			{
			hshValues.put("apistatus", strpanAPIstatus);
			hshValues.put("apistatusdesc", strPanResCustDesc);	
			}
			else
			{
			hshValues.put("apistatus", strResStatus);
			hshValues.put("apistatusdesc", strResCustDesc);
			}
			hshValues=getDigiDecisionDetail(hshValues);
		} 
		catch (Exception ex) 
		{
			throw new EJBException("Error in cbsIdModificationService"+ex.toString());
		}
		
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new EJBException("Error in cbsIdModificationService closing Connection "+e.getMessage());
			}
		}
		return hshValues;
	}
	
	public String genrateURL(String docurl,String strDocType){
		String urlAdd = ApplicationParams.getStrdmsurl();
		//URI uri = URI.create(urlAdd);
		URI uri = null;
		String url = "";
		try {
			uri = new URI(urlAdd);
			int port = uri.getPort();
			String ip = uri.getHost();
			
			url = checkAllURLPerformence(ip, port, "imaging", docurl, strDocType);
			log.info("@@@@@@@ genrateURL->url "+url);
		} catch (URISyntaxException e) {
			System.out.println("generateURL Exception");
			e.printStackTrace();
			throw new EJBException("Exception in generateURL ==="+e.getMessage());
		}
		
        return url;
	}
	
	private String checkAllURLPerformence(String ip, int port, String baseurl, String docurl, String strDocType)
    {
        int statuscode = 0;
        String statusdone = "";
        String reqbaseurl = "", md5hashval = "";
        
        //reqbaseurl = "http://" + ip + (port > 0 ? ":" + port : "") + "/" + baseurl;
        //reqbaseurl=ApplicationParams.getStrdmsurl();
        reqbaseurl="";
        statusdone = httpimageserverurlops(docurl, 0, reqbaseurl, 1296000,  statuscode, md5hashval, strDocType );
        log.info("@@@@@@@@ checkAllURLPerformence->statusdone "+statusdone);

        return statusdone;
    }

    private String httpimageserverurlops(String url, int pageno, String baseurl, int timeout,  int statuscode, String md5hash, String strDocType)
    {
        String urlwithpage = url + "/page/" + pageno;
        String appendstr = buildimgrepourl(urlwithpage, timeout);
        String HttpURL = baseurl + urlwithpage + "&" + appendstr + "&filetype=" + strDocType;
        return HttpURL;
    }

    private String buildimgrepourl(String urlwithpage, int timeout)
    {
        String httpmethod = "GET";
        String imageurl = urlwithpage; //url + "/page/" + pageno;
        
        
        Calendar calendar = Calendar.getInstance();
        // Date date1 = calendar.getTime();
        // String currDate = dateFormat.format(date1);
        calendar.add(Calendar.SECOND, timeout);
        Date date2 = calendar.getTime();
       
        
        String strYear = String.valueOf(calendar.get(Calendar.YEAR));
        String strMonth = String.valueOf(calendar.get(Calendar.MONTH)+1);
        String strDay = String.valueOf(calendar.get(Calendar.DATE));
        String strHours = String.valueOf(calendar.get(Calendar.HOUR));
        String strMinutes = String.valueOf(calendar.get(Calendar.MINUTE));
        String strSeconds = String.valueOf(calendar.get(Calendar.SECOND));
         
        String datetime = strYear +"-"+ strMonth +"-"+ strDay + "T" + strHours +":"+ strMinutes +":"+ strSeconds;
        String randomstr = "1234567890abcdef";
        String keystr = "filename_here";
        
        
        String checksum = httpmethod + ";" + imageurl + ";" + datetime + ";" + randomstr + ";" + keystr;
        
        
        String hashvalue = sha256(checksum);
        String appendstr = "validuntil=" + datetime + "&" + "nonce=" + randomstr + "&" + "checksum=" + hashvalue;
        log.info("@@@@@@@@ buildimgrepourl->appendstr "+appendstr);
        return appendstr;
    }

    private String sha256(String password)
    {
    	String hash ="";
    	MessageDigest messageDigest = null;
		try {
			messageDigest = MessageDigest.getInstance("SHA-256");
			
			byte[] crypto = messageDigest.digest(password.getBytes());
	    	
	        BigInteger bigInteger = new BigInteger(1, crypto);
	        
	        hash = bigInteger.toString(16);

			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			throw new EJBException("Exception in checkAllURLPerformence ==="+e.getMessage());
		}
        return hash;
    }
    

    
    public HashMap preApprovedOfferService(HashMap hshValues) 
	{
		ArrayList arrValue = new ArrayList();
		//ArrayList arrValues = null;
		HashMap hshValue = new HashMap();
		HashMap hshValue1 = null;
		HashMap hshQueryValues = new HashMap();
		
		ResultSet rs = null, rs1 = null;
		String strQuery = "", strInwardno = "";

		try {

			String strCustomerID = Helper.correctInt((String) hshValues.get("strCustomerID"));
					
			String strApplExist = "N";
			int intUpdateSize = 0;
			String strCustID = "", strAccNo = "", strCustLoanAmt = "", strCustROI = "", strCustTenure = "", strProcessingFee = "", strBureauScore = "", strBreScore = "", strEMIlimit = "",strSalary="",strBIRdate="";

			
			if(rs!=null)
				rs.close();
			String strdebitscore="";
			strQuery=SQLParser.getSqlQuery("sel_kbletb_debitscore^"+strCustomerID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strdebitscore=Helper.correctNull((String)rs.getString("KBL_ETB_DEBITSCORE"));
			}
			if(strdebitscore.equals(""))
				strdebitscore="0";
			
			
			
			  rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_cbsid_BIR^"+strCustomerID);
			if(rs.next())
			{
				strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
			
			}
		/*	rs1=DBUtils.executeLAPSQuery("sel_per_bir^"+strAppno);
			if(rs1.next())	
			{
				strBIRdate=Helper.correctNull((String)rs1.getString("bir_processdate"));
			}*/
			
			if(rs!=null)
				rs.close();
			
			
			rs = DBUtils.executeLAPSQuery("sel_preApprovedOffer_ext^"+ strCustomerID);
					
			while (rs.next()) {
				strApplExist = "Y";
				strCustID = Helper.correctNull((String) rs
						.getString("KBL_CUST_ID"));
				strAccNo = Helper.correctNull((String) rs
						.getString("KBL_ACC_NUMBER"));
				strCustLoanAmt = Helper.correctNull((String) rs
						.getString("KBL_LOAN_AMOUNT"));
				strCustROI = Helper.correctNull((String) rs
						.getString("KBL_ROI"));
				strCustTenure = Helper.correctNull((String) rs
						.getString("KBL_TENURE"));
				strProcessingFee = Helper.correctNull((String) rs
						.getString("KBL_PROCESSING_FEE"));
				strBureauScore = Helper.correctNull((String) rs
						.getString("KBL_BUREAU_SCORE"));
				strBreScore = Helper.correctNull((String) rs
						.getString("KBL_BRE_SCORE"));
				strEMIlimit = Helper.correctNull((String) rs
						.getString("KBL_EMI_LIMIT"));
				strSalary= Helper.correctNull((String) rs
						.getString("KBL_SALARY"));
				
				hshValue1 = new HashMap();
				hshValue1.put("strApplExist", strApplExist);
				hshValue1.put("strCustID", strCustID);
				hshValue1.put("strAccNo", strAccNo);
				hshValue1.put("strCustLoanAmt", strCustLoanAmt);
				hshValue1.put("strCustROI", strCustROI);
				hshValue1.put("strCustTenure", strCustTenure);
				hshValue1.put("strProcessingFee", strProcessingFee);
				hshValue1.put("strBureauScore", strBureauScore);
				hshValue1.put("strBreScore", strBreScore);
				hshValue1.put("strEMIlimit", strEMIlimit);
				hshValue1.put("strSalary", strSalary);
				hshValues.put("strdebitscore", strdebitscore);
				arrValue.add(hshValue1);
				
			}
			
			hshValue.put("arrValue", arrValue);
			
			hshValue.put("strdebitscore", strdebitscore);
			hshValue.put("strbirdate", strBIRdate);
			
			
			

			
		} catch (Exception e) {
			throw new EJBException("Error in DigitalAppInterface Bean preApprovedOfferService..."+ e.toString());		
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in DigitalAppInterface Bean preApprovedOfferService in closing connection exception..."+ e.toString());			
			}
		}
		return hshValue;
    	
	}
    
 
    public void pushDocumentService(HashMap hshVal)  {
		
		JSONObject objOuter = new JSONObject();
		JSONObject jsonObject1 = new JSONObject();
		JSONObject jsonObject2 = new JSONObject();
		JSONObject jsonObject3 = new JSONObject();
		JSONObject jsonObject4 = new JSONObject();
		JSONObject jsonObject5 = new JSONObject();
		JSONObject jsonObject6 = new JSONObject();
		JSONObject jsonObjectForData = new JSONObject();
		
		
		JSONArray jsonArray1 = new JSONArray();
		JSONArray jsonArray2 = new JSONArray();
		JSONArray jsonArray3 = new JSONArray();
		
		String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = ""
						, strInputJSONRequest = "", strRes = "", strCustDesc = "", strEntity = "";

		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		HashMap hshValForDoc = new HashMap(); 
		
		try {
			
			if(hshVal!=null){
				hshValForDoc = this.uploadFileToServer(hshVal); //in hshVal obj MultipartFormDataRequest class obj should be present
			}
			String strImageId = Helper.correctNull((String)hshValForDoc.get("strImageId"));
			
			String extension="";
			String filename=Helper.correctNull((String)hshValForDoc.get("strfilename"));
			String doccode=Helper.correctNull((String)hshValForDoc.get("strDocCode"));
			String strFileSize=Helper.correctNull((String)hshValForDoc.get("strFileSize"));
			String strappno=Helper.correctNull((String)hshValForDoc.get("strAppNo"));
			String strUserID=Helper.correctNull((String)hshValForDoc.get("strUserID"));
			
			String strdoctype="",strdocid="",strdocName="",strdoccode="";
				rs = DBUtils.executeLAPSQuery("sel_documentdetails_doccode^" + doccode);
				if(rs.next())
				{
					strdoctype=Helper.correctNull((String)rs.getString("doc_doctype"));
					strdocid=Helper.correctNull((String)rs.getString("Document_ID"));
					strdocName=Helper.correctNull((String)rs.getString("Document_Name"));
					strdoccode=Helper.correctNull((String)rs.getString("Document_Code"));
					
				}
				
			
			int i= filename.lastIndexOf('.');
			if(i>=0)
			{
				extension= filename.substring(i+1);
			}
			
			jsonObject6.put("DOCDESC", strdocName);
			jsonObject6.put("DOCCODE", strdoccode);
			jsonObject6.put("FILE", filename);
			jsonObject6.put("CustIndex", 1);
			jsonObject6.put("url", "");
			
			jsonArray3.put(0, jsonObject6);
			
			jsonObjectForData.put("Kind", "LOAN_WI");
			jsonObjectForData.put("LEADNUMBER", strappno);
			jsonObjectForData.put("SIZE", strFileSize);  
			jsonObjectForData.put("DOCUMENTS", jsonArray3);
			
			String strData = jsonObjectForData.toString();
			//String mimetype=Helper.correctNull((String)hshVal.get("mimetype"));
			jsonObject4.put("TYPE", "ADDITION");
			jsonObject4.put("QUEUEFILTER4", 1);
			jsonObject4.put("WORKQUEUELOGDATA", "CSTAGE=Creation;NSTAGE=MQPublish");
			jsonObject4.put("PROPOSALNO", "");
			jsonObject4.put("BUSINESSGROUPID", 1);
			
			if(extension.equalsIgnoreCase("pdf"))
			{
			jsonObject4.put("MIMETYPE","Application/pdf");
			}
			if(extension.equalsIgnoreCase("text"))
			{
				jsonObject4.put("MIMETYPE","Application/plain");
			}
			if(extension.equalsIgnoreCase("xlsx"))
			{
			jsonObject4.put("MIMETYPE","Application/xlsx");
			}
			if(extension.equalsIgnoreCase("jpg"))
			{
			jsonObject4.put("MIMETYPE","Application/jpg");	
			}
			if(extension.equalsIgnoreCase("png"))
			{
			jsonObject4.put("MIMETYPE","Application/png");	
			}
			jsonObject5.put("ID", 0);
			
			//request id number 
			if(rs!=null)
				rs.close();
				
			String strPatternRequestID="",strfilecount="";
			rs = DBUtils.executeLAPSQuery("sel_docattachcount^" + strappno);
			if(rs.next())
			{
				strfilecount=Helper.correctNull((String)rs.getString("filecount") );
			}
			
			strPatternRequestID="LAPS-"+strappno+"/"+strfilecount;
			
			
			jsonObject5.put("APPDATA1", strPatternRequestID); ///////reference number
			jsonObject5.put("APPDATA2", "STAGE=MQPublish;SourceSystem=LAPS;");
			jsonObject5.put("APPDATA3", 0);
			jsonObject5.put("DATA", strData);
			jsonObject5.put("NOTEPAD", "");
			jsonObject5.put("FILEID",strImageId); 
			jsonObject5.put("WORKITEMTYPE", 3);
			jsonObject5.put("WORKITEMCATEGORY", 2);
			jsonObject5.put("WORKITEMSOURCE", 8);
			jsonObject5.put("PROCESSINGUNIT", 0);
			jsonObject5.put("PARENTID", 0);
			jsonObject5.put("WORKITEMGROUP", -1);
			jsonObject5.put("BRANCH", 8);
			jsonObject5.put("PRIORITY", 1);
			jsonObject5.put("USERASSIGNMENT", 0);
			jsonObject5.put("ARCHIVEID", 0);
			
			jsonObject3.put("ATTRIBUTES", jsonObject4);
			jsonObject3.put("FIELD", jsonObject5);
			
			jsonArray2.put(0, jsonObject3);
			
			jsonObject2.put("NAME", "WORKINFO");
			jsonObject2.put("RECORD", jsonArray2);
			
			jsonArray1.put(0, jsonObject2);
			
			jsonObject1.put("SECTION", jsonArray1);
			
			objOuter.put("SessionKey", "1403072309_3caf1ce0-29e7-4522-9f0f-2ee68aae6f29");
			objOuter.put("ParentId", 0);
			objOuter.put("WorkId", 0);
			objOuter.put("WorkItemType", 3);
			objOuter.put("FileListId", strImageId);
			objOuter.put("PageId1", 0);
			objOuter.put("PageId2", 0);
			objOuter.put("FileSize", 0);
			objOuter.put("FileFormat", 2);
			objOuter.put("FileType", 2);
			objOuter.put("Status", 3);
			objOuter.put("Option", 0);
			objOuter.put("DATA", jsonObject1);
			
			log.info("######################### jsonRequest for pushDocumentService $$$$$$$$$$$$$$$$$$$$$$$$  "+objOuter);			
			log.info("######################### jsonRequest for pushDocumentService $$$$$$$$$$$$$$$$$$$$$$$$  "+objOuter);			

			
			
			strInputJSONRequest = objOuter.toString();
			// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@ CHM & CIBIL Request @@@@@@@@@@@@@################"+
			// strInputXMLRequest);
			log.info("################@@@@@@@@@@@@@ pushDocumentService Json Request @@@@@@@@@@@@@################"
							+ strInputJSONRequest);
			log.info("######################### jsonRequest for pushDocumentService @@@@@@@@@@@@@################  "+strInputJSONRequest);			

			// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
			// ApplicationParams.getstrCHMCIBILURL());
			// System.out.println("################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
			// ApplicationParams.getstrCHMCIBILURL());
			
		
			URL url = new URL(ApplicationParams.getStrPushDocumentService());
			log.info("puchDocumentService Url=========== "+url);
			
			HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
					
			urlcon.setRequestProperty("User-Agent", "");
			urlcon.setDoInput(true);
			urlcon.setDoOutput(true);
			urlcon.setRequestMethod("POST");
			urlcon.setRequestProperty("Content-Type","multipart/form-data");
			urlcon.setRequestProperty("Authorization","Basic "+ ApplicationParams.getStrAuthValue());
			
			
			
	
			
			
			
			OutputStreamWriter osw = new OutputStreamWriter(urlcon.getOutputStream(), "UTF-8");
			osw.write(strInputJSONRequest);
			osw.close();
			
			InputStream inputStream = urlcon.getInputStream();
			InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");	
			BufferedReader br = new BufferedReader(isreader);
			
			StringBuffer jsonString = new StringBuffer();
			if (br != null) {
				
				while ((line = br.readLine()) != null) {
					jsonString.append(line);
					//Logger.log("jsonString================="+jsonString);
					//Loggser.log("INSIDE WHILE LOOP OF JSON CONENCTION ######################################### ");
				}
				
			}
			log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
			log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
			br.close();
			urlcon.disconnect();
			
			
			
			String strResponse	 = String.valueOf(jsonString);
			JSONObject jsonResponseObj	 = 	new JSONObject(strResponse);
			
			JSONArray jsonResArray1 = jsonResponseObj.getJSONArray("SECTION");
			JSONObject jsonResObject1 = jsonResArray1.getJSONObject(0);
			JSONArray jsonResArray2 = jsonResObject1.getJSONArray("RECORD");
			JSONObject jsonResObjectForStatus = jsonResArray2.getJSONObject(0);
			
			String status = jsonResObjectForStatus.getString("STATUS");
			JSONObject jsonResObjectForData = jsonResObjectForStatus.getJSONObject("FIELD");
			String strActualData = jsonResObjectForData.getString("Data");
			
			if(status.equalsIgnoreCase("Success")){
				System.out.println("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
				log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
			}else{
				throw new EJBException("STATUS: "+status);
			}
			
			// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
			// + result.toString());
		
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_appdocattachments_proposalapi");
			arrValues.add(strappno);
			arrValues.add(strdoctype);
			arrValues.add(strdoccode);
			arrValues.add(filename);
			arrValues.add(strUserID);
			arrValues.add("1");
			arrValues.add(strPatternRequestID);
			arrValues.add(""); //genurldate
			arrValues.add("");	//docurl
			arrValues.add(strFileSize);	
			arrValues.add("");	//genurl
			arrValues.add("");	//leadnumber
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}catch (JSONException e) {
			log.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ JSONException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
			e.printStackTrace();
			throw new EJBException("Exception in JSON ==="+e.getMessage());
		}catch (MalformedURLException e) {
			log.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ MalformedURLException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
			e.printStackTrace();
			throw new EJBException("Malfunction URL Exception ==="+e.getMessage());	
		}catch (IOException e) {
			log.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ IOException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
			e.printStackTrace();
			throw new EJBException("Input Output Exception ==="+e.getMessage());	
		}catch (Exception e) {
			e.printStackTrace();
			throw new EJBException(" Exception ==="+e.getMessage());	
		}	
	}//pushDocumentService()
	

public HashMap uploadFileToServer(HashMap hshValues){
	
	JSONObject jsonObject = new JSONObject();
	
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strImageId = "", strFileName = "", strFileNameWithExt = "";
	long strFileSize=0;
	final String boundary = "---------------------------------" + System.currentTimeMillis();
	final String LINE_FEED = "\r\n";
	PrintWriter writer = null;
	
	byte[] docInBytes = null;
	MultipartFormDataRequest multipartFormDataRequest = null;
	InputStream inputStream = null;
	OutputStream outputStream = null;

	
	try {
		multipartFormDataRequest = (MultipartFormDataRequest) hshValues.get("multiPartFormDataRequest");
		if (multipartFormDataRequest != null)
		{
			Hashtable files = multipartFormDataRequest.getFiles();
			
			if ((files != null) || (!files.isEmpty()))
			{
				UploadFile file = (UploadFile) files.get("fileAttach");						
				strFileNameWithExt = Helper.correctNull((String) file.getFileName());
				strFileSize=file.getFileSize();
				if (!strFileNameWithExt.trim().equalsIgnoreCase(""))
				{
					 strFileName = strFileNameWithExt.substring(0,strFileNameWithExt.indexOf("."));
					/* File resultfile			= new File(str_FileDirectory);
					 if(!resultfile.exists())
					 {
						 resultfile.mkdirs();
					 }*/
					 
					 inputStream = file.getInpuStream();
				
					/* byte[] byFileName = new byte[is.available()];
					 int i = din.read(byFileName);
					 String strArray[] = null;
					 docInBytes	= (byte[])byFileName;*/
				}
			}
		}
		
		
		jsonObject.put("SessionKey", "1103155243_294fda4e-92e7-46b0-b657-f43bcefca247"); 
		jsonObject.put("Option", 0);
		jsonObject.put("FileSize", 0);
		jsonObject.put("HashType", 0);
		String strInputJSONRequest = jsonObject.toString();
		
		log.info("################@@@@@@@@@@@@@ UploadFile to Server API Json Request @@@@@@@@@@@@@################"
				+ strInputJSONRequest);
		log.info("###############=#@@@@@@@@@@@@@ UploadFile to Server API Json Request @@@@@@@@@@@@@################"+ strInputJSONRequest);
		
		URL url = new URL(ApplicationParams.getStrUploadFileToServer());
		 log.info("uploadFileToServer Url=========== "+url);
		
		 HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
		
		urlcon.setRequestProperty("User-Agent", "");
		urlcon.setDoInput(true);
		urlcon.setDoOutput(true);
		urlcon.setRequestMethod("POST");
		urlcon.setRequestProperty("Content-Type","multipart/form-data; boundary=" + boundary);
		urlcon.setRequestProperty("Authorization","Basic "+ApplicationParams.getStrAuthValue());	
		
		
		DataOutputStream dos = new DataOutputStream(urlcon.getOutputStream());
		dos.writeBytes("Content-Disposition: form-data; data=\""+strInputJSONRequest + "\";file=" + strFileName + LINE_FEED);
		dos.writeBytes(LINE_FEED);
		dos.write(docInBytes);
		dos.writeBytes(LINE_FEED);
		
		
		outputStream = urlcon.getOutputStream();
		writer = new PrintWriter(new OutputStreamWriter(outputStream), true);
		
	    try {
	    	
	    	// For json text request
	    	writer.append("--" + boundary).append(LINE_FEED);
	        writer.append("Content-Disposition: form-data; name=\"" + "data" + "\"")
	                .append(LINE_FEED);
	        writer.append("Content-Type: text/plain; charset=" + "UTF-8").append(
	                LINE_FEED);
	        writer.append(LINE_FEED);
	        writer.append(strInputJSONRequest).append(LINE_FEED);
	        writer.flush();
	    	
	        // For attached file request 
	        writer.append("--" + boundary).append(LINE_FEED);
	        writer.append(
	                "Content-Disposition: form-data; name=\"" + "file"
	                        + "\"; filename=\"" + strFileName + "\"")
	                .append(LINE_FEED);
	        writer.append(
	                "Content-Type: "
	                        + URLConnection.guessContentTypeFromName(strFileName))
	                .append(LINE_FEED);
	        writer.append("Content-Transfer-Encoding: binary").append(LINE_FEED);
	        writer.append(LINE_FEED);
	        writer.flush();
	
	        // FileInputStream inputStream = new FileInputStream(uploadFile);
	        byte[] buffer = new byte[4096];
	        int bytesRead = -1;
	        while ((bytesRead = inputStream.read(buffer)) != -1) {
	            outputStream.write(buffer, 0, bytesRead);
	        }
	        outputStream.flush();
	        writer.append(LINE_FEED);
	        writer.flush();
	    } 
	    catch (Exception e)
		{
			throw new EJBException("Error in uploadFileToServer json file attachment block" + e.getMessage());
		}
	    finally {
	        inputStream.close();
	    }
	    writer.flush();
	    writer.close();
		
	
		InputStream inputStreamForRes = urlcon.getInputStream();
		InputStreamReader isreader = new InputStreamReader(inputStreamForRes,"UTF-8");	
		BufferedReader br = new BufferedReader(isreader);
		
		StringBuffer jsonString = new StringBuffer();
		if (br != null) {
			
			String line = "";
			while ((line  = br.readLine()) != null) {
				jsonString.append(line);
			}
			
		}
		System.out.println("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
		br.close();
		urlcon.disconnect();
		
		
		String strResponse	 = String.valueOf(jsonString);
		JSONObject jsonResponseObj	 = 	new JSONObject(strResponse);
		
		int imageId = jsonResponseObj.getInt("IMAGEID");
		
		strImageId = String.valueOf(imageId);
		
		hshValues.put("strImageId", strImageId);
		hshValues.put("strfilename", strFileNameWithExt);
		hshValues.put("strFileSize", String.valueOf(strFileSize));
		
		
		
		//urlcon.disconnect();
		
		}catch (Exception e) {
			e.printStackTrace();
			throw new EJBException("Error in uploadFileToServer " + e.getMessage());
		}	
		
		return hshValues;
	}

public HashMap readTableFromServer(HashMap hshValues) {
	
	JSONObject objOuter = new JSONObject();
	JSONObject data = new JSONObject();
	JSONObject objTable = new JSONObject();
	
	String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = ""
			, strInputJSONRequest = "", strRes = "", strCustDesc = "", strEntity = ""
			, strApplicationNo = "",strFileName = ""
			, strUserId = "", strCreatedDate = "", strSNo = "", strDelFlag = "", strDelUseId =""
			, strDelDate = "", strDocFacslNo ="";

	ResultSet rs = null;
	HashMap hshQueryValues = null;
	HashMap hshVal = new HashMap();
	ArrayList arrValue = null;
	ArrayList arrValue1 = null;
	ArrayList arrValues = null;
	HashMap hshValue = new HashMap();
	HashMap hshValue1 = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrCol= new ArrayList();
	ArrayList arrRow= new ArrayList();
	
	try {
		strApplicationNo = Helper.correctNull((String)hshValues.get("app_no"));
		arrValue1 = (ArrayList)hshValues.get("arrValueForDocCode");
		
		if(strApplicationNo.equals(""))
		{
			strApplicationNo=correctNull((String)hshValues.get("appno"));			
		}
		String strDocType    = correctNull((String)hshValues.get("DocType"));
		String strDocCode    = correctNull((String)hshValues.get("DocCode"));
		String strHitPortion = correctNull((String)hshValues.get("hitportion"));
		String strCBSID = correctNull((String)hshValues.get("strCBSID"));
		String strfacslno = Helper.correctInt((String)hshValues.get("strfacslno"));
		String strModuleType = correctNull((String)hshValues.get("sessionModuleType"));
		if(strModuleType.equals(""))
		{
			  strModuleType = correctNull((String)hshValues.get("cattype"));
		}
				
				if(rs!=null)	
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_readTableFromServerByDocCode^" + strApplicationNo+"^"+strDocCode);
			
				while(rs.next()){
					String strurl=Helper.correctNull((String)rs.getString("APA_DOCURL"));
					String strgendate=Helper.correctNull(rs.getString("APA_GENURL_EXPDATE"));
					SimpleDateFormat dateFormats= new SimpleDateFormat("dd/MM/yyyy"); 
					Date date1=dateFormats.parse(strgendate);
					Date date2=dateFormats.parse(dateFormats.format(System.currentTimeMillis()));
					String strgeneratedurl=Helper.correctNull(rs.getString("APA_GENERATED_URL"));
					String strsno=Helper.correctNull(rs.getString("apa_sno"));
					

					
					
					if(strurl.equals(""))
					{
						//readTable API removed
					}
					else if( !strurl.equals("") & (date1.compareTo(date2))<0)
					{
						String strDmsRefNo = Helper.correctNull((String) rs.getString("APA_DMS_REFNO"));
						String strurls=Helper.correctNull((String)rs.getString("APA_DOCURL"));
						String strdoctype=Helper.correctNull((String)rs.getString("APA_DOC_MIMETYPE"));
						String generatedUrls = this.genrateURL(strurls,strdoctype);
						
						strgeneratedurl=generatedUrls;
						
						arrValues=new ArrayList();
						hshValue=new HashMap();
						hshQueryValues=new HashMap();
						//Calendar calendar = Calendar.getInstance();
						SimpleDateFormat dateFormat= new SimpleDateFormat("dd/MM/yyyy"); 
			            Calendar calendar = Calendar.getInstance();
			            calendar.add(Calendar.DATE,90);
			            String strDay = dateFormat.format(calendar.getTime());
			            
						arrValues.add(generatedUrls);
						arrValues.add(strDay);
						arrValues.add(strApplicationNo);
						arrValues.add(strsno);
						hshQuery.put("strQueryId", "upd_url_date_docattachments");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
					}
				    
					arrCol = new ArrayList();
					arrCol.add(Helper.correctInt(rs.getString("apa_sno")));
					arrCol.add(Helper.correctNull(rs.getString("apa_filename")));
					arrCol.add(Helper.correctNull(rs.getString("apa_userid")));
					arrCol.add(strgeneratedurl);
					arrRow.add(arrCol);		
					
				} //while(rs.next()) loop end

				rs.close();
				hshValue.put("arrRow",arrRow);
				
				if(rs!=null)
					rs.close();
			    rs=DBUtils.executeLAPSQuery("seldeviateduser^"+strApplicationNo);
				if(rs.next())
				{
					hshValue.put("strAppHolder", Helper.correctNull(rs.getString("app_applnholder")));
				}
				
	}
	catch (Exception e) {
		System.out.println("$$$$$$$$$$$$ Exception in readTableFromServer &&&&&&&&&&&&");
		e.printStackTrace();
		throw new EJBException("Exception in readTableFromServer ==="+e.getMessage());
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
			throw new EJBException("Error in readTableFromServer in closing Connection "+e.getMessage());
		}
	}
			
	return hshValue;			
		
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
		
		public HashMap custIdPanModification(HashMap hshValues){
			
			String line                     = "", strInputXMLRequest = "", strCustId = "", strTds_cust_id = "", strPan = ""
												, strTaxDeductionTable ="", strModBySystemId = "", strResCustId="", strResEntity=""
					                            , strDemographicModData = "", strEntityDocumentId = "", strCountryOfIssue = "", strDocCode = ""
					                            , strIssueDt = "", strTypeCode = "", strPlaceOfIssue = "", strReferenceNum = ""
					                            , strPreferredUniqueId = "", strResDesc="", strResStatus="", strResService=""
					                            , strRequestUUID ="", strServiceRequestVersion = "", strChannelId = "", strBankId = ""
					                            , strEntityType = "", strMessageDateTime = "";
					                            
					                            

			ResultSet rs = null;
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strExp="$";

			try {
						
				String strApplicantID =Helper.correctNull((String) hshValues.get("hidapplicantid"));  
				rs = DBUtils.executeLAPSQuery("sel_cbsIdCreation^" + strApplicantID);
						
				if (rs.next()) {
					strPan = Helper.correctNull((String) rs.getString("PERAPP_PANNO"));
					strCustId = Helper.correctNull((String) rs.getString("PERAPP_CBSID"));
					strPlaceOfIssue = Helper.correctNull((String) rs.getString("CON_COMCITY"));
				
				}
				if(strCustId.isEmpty())
				strTds_cust_id=Helper.correctNull((String) hshValues.get("newCustId"));
				else
				strTds_cust_id=strCustId;
				
				strTaxDeductionTable = "TDSGE";
				strModBySystemId = "TDS";
				strEntityDocumentId = "";
				strIssueDt = "";
				
				strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
				strServiceRequestVersion = "10.2";
				strChannelId = "CRM";
				strBankId = "01";
				strEntityType = "";
				//strMessageDateTime = Helper.getCurrentDateTime();
				SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
				strMessageDateTime=simpledateformat.format(new Date());
				
						strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xsi:schemaLocation='http://www.finacle.com/fixml RetCustMod.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>" +
							"<Header><RequestHeader><MessageKey><RequestUUID>"+strRequestUUID+"</RequestUUID><ServiceRequestId>RetCustMod</ServiceRequestId>" +
							"<ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>"+strChannelId+"</ChannelId><LanguageId></LanguageId></MessageKey><RequestMessageInfo>" +
							"<BankId>"+strBankId+"</BankId><TimeZone></TimeZone><EntityId></EntityId><EntityType>"+strEntityType+"</EntityType><ArmCorrelationId></ArmCorrelationId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime>" +
							"</RequestMessageInfo><Security><Token><PasswordToken><UserId></UserId><Password></Password></PasswordToken></Token>" +
							"<FICertToken></FICertToken><RealUserLoginSessionId></RealUserLoginSessionId><RealUser></RealUser><RealUserPwd></RealUserPwd><SSOTransferToken></SSOTransferToken>" +
							"</Security></RequestHeader></Header><Body><RetCustModRequest><RetCustModRq><RetCustModMainData><CustModData><CustId>"+strTds_cust_id+"</CustId><tds_cust_id>"+strTds_cust_id+"</tds_cust_id>" +
							"<Pan>"+strPan+"</Pan><TaxDeductionTable>"+strTaxDeductionTable+"</TaxDeductionTable><ModBySystemId>"+strModBySystemId+"</ModBySystemId>" +
							"</CustModData></RetCustModMainData><RetailCustModRelatedData><DemographicModData></DemographicModData><EntityDocModData>"+
							"<CountryOfIssue>IN</CountryOfIssue><DocCode>PANGIR</DocCode><IssueDt>"+strMessageDateTime+"</IssueDt><TypeCode>ID PROOF RETAIL</TypeCode><PlaceOfIssue>"+strPlaceOfIssue+"</PlaceOfIssue>" +
							"<ReferenceNum>"+strPan+"</ReferenceNum><preferredUniqueId>N</preferredUniqueId></EntityDocModData></RetailCustModRelatedData></RetCustModRq>" +
							"</RetCustModRequest></Body></FIXML>";
				
					log.info("################@@@@@@@@@@@@@ Cust ID PAN Modification Request @@@@@@@@@@@@@################"+ strInputXMLRequest);
					
					URL url = new URL(ApplicationParams.getStrCUSTIDPANModification());
					log.info("custIdPanModification========"+url);
					
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
					if (rd != null) {
						StringBuffer result = new StringBuffer();
						while ((line = rd.readLine()) != null) {
							result.append(line);
						}
						log.info("################@@@@@@@@@@@@@ Cust ID PAN Modification Response @@@@@@@@@@@@@################"
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
			                        strResStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							

				  		              NodeList nodesList = doc.getElementsByTagName("Body");
				  		              if(strResStatus.equalsIgnoreCase("SUCCESS"))
				  		              {
				  		            	strResCustId=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId").item(0).getChildNodes().item(0).getNodeValue();
				  		            	strResDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("Desc").item(0).getChildNodes().item(0).getNodeValue();
				  		            	strResStatus=(String)((Element)nodesList.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							
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
									arrValues.add(strResCustId);
									arrValues.add(strResDesc);//appraised by
									arrValues.add(strRequestUUID);									
									arrValues.add("Cust Id PAN Modification");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);
									hshQueryValues.put("size", "1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								}
						} 
						catch (Exception e) 
						{
							System.out.println("Exception.....................");
							e.printStackTrace();
							throw new EJBException("Exception in custid pan ==="+e.getMessage());
						}
					}
				
					hshValues.put("strResStatus", strResStatus);
					hshValues.put("strResDesc", strResDesc);
			} catch (Exception ex) {
				throw new EJBException("Error in custIdPanModification"+ex.toString());
			}

			finally {
				try {
					if (rs != null) {
						rs.close();
					}
				} catch (Exception e) 
				{
					e.printStackTrace();
					throw new EJBException("Error in closing Connection "+e.getMessage());
				}
			}
			return hshValues;
		}
		
		public HashMap custIdVerification(HashMap hshValues){
			
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
				strServiceRequestVersion = "10.2";
				strChannelId = "CRM";
				strBankId = "01";
				strEntityType = "";
				//strMessageDateTime = Helper.getCurrentDateTime();
				SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
				strMessageDateTime=simpledateformat.format(new Date());
				
				strcifId = Helper.correctNull((String) hshValues.get("newCustId"));
				
					strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xsi:schemaLocation='http://www.finacle.com/fixml verifyCustomerDetails.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>" +
							"<Header><RequestHeader><MessageKey><RequestUUID>Req_"+strRequestUUID+"</RequestUUID><ServiceRequestId>verifyCustomerDetails</ServiceRequestId>" +
							"<ServiceRequestVersion>"+strServiceRequestVersion+"</ServiceRequestVersion><ChannelId>"+strChannelId+"</ChannelId><LanguageId></LanguageId></MessageKey><RequestMessageInfo><BankId>"+strBankId+"</BankId>" +
							"<TimeZone></TimeZone><EntityId></EntityId><EntityType>"+strEntityType+"</EntityType><ArmCorrelationId></ArmCorrelationId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime>"+												
							"</RequestMessageInfo><Security><Token><PasswordToken><UserId></UserId><Password></Password></PasswordToken></Token>" +
							"<FICertToken></FICertToken><RealUserLoginSessionId></RealUserLoginSessionId><RealUser></RealUser><RealUserPwd></RealUserPwd>" +
							"<SSOTransferToken></SSOTransferToken></Security></RequestHeader></Header><Body><verifyCustomerDetailsRequest>" +
							"<CustomerVerifyRq><cifId>"+strcifId+"</cifId><decision>Approve</decision><entityName>RetailCustomer</entityName>" +
							"</CustomerVerifyRq></verifyCustomerDetailsRequest></Body></FIXML>";
					
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
				throw new EJBException("Error in custIdVerification");
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
public HashMap handleStatusDetails(HashMap hshValues) {
			
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null;
			String strQuery="",strInwardno="";
			String mclrbaserate="",chkValue="",streman="",stremanpendflag="";

			try
			{
				
			String strLapsProposalNumber = Helper.correctNull((String)hshValues.get("strLapsProposalNumber"));
			String strAppReferenceNumber = Helper.correctNull((String)hshValues.get("strAppReferenceNumber"));
			
			String strApplExists = "", strSantionRefNumber = "", strSantionDate =""
					, strAccNumber = "", strCBSId = "", strAccountOpeningDate = "",strAppstatus="",strAppstatusCode="";
			String BIR_reportdate="",strSanctioncheck="";

			if(!strLapsProposalNumber.equals(""))
			{
				if (rs != null) 
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_statuscheckAPI^"+strLapsProposalNumber);
				if(rs.next())
				{
					strApplExists="Y";
					strSantionRefNumber = Helper.correctNull((String)rs.getString("SANCTIONREFNO"));
					strSantionDate = Helper.correctNull((String)rs.getString("APP_PROCESSDATE"));
					strAccNumber = Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
					strCBSId = Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
					strAccountOpeningDate = "";
					strAppstatusCode = Helper.correctNull((String)rs.getString("APP_STATUS"));
					stremanpendflag=Helper.correctNull((String)rs.getString("PERAPP_EMANDATE_FLAG"));
					if(strAppstatusCode.equals("op"))
						strAppstatus = "Open/In-Principle Sanction";
					else if(strAppstatusCode.equals("pa"))
						strAppstatus = "Processed/Approved";
					else if(strAppstatusCode.equals("pr"))
						strAppstatus = "Rejected";
					
					strSanctioncheck=Helper.correctNull((String)rs.getString("PERAPP_CBSCUSTFLAG"));
				}		
				
				
				//BIR Date
				if (rs != null) 
				{
					rs.close();
				}
				
				rs=DBUtils.executeLAPSQuery("sel_per_bir^"+strLapsProposalNumber);
				if(rs.next())
				{
					BIR_reportdate = Helper.correctNull((String)rs.getString("bir_processdate"));
				}
				
				
				//mclrrate
				
				if (rs != null) 
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^H");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrbaserate=Helper.correctNull((String)rs.getString("MCLR_BASERATESPREAD"));
				}
				
				
				String manualcheck="";
				rs = DBUtils.executeLAPSQuery("select_verifydocument^" + strLapsProposalNumber);
				if(rs.next())
				{
					chkValue = Helper.correctNull((String)rs.getString("VERI_CHKBOX_VALUE"));		
					manualcheck = Helper.correctNull((String)rs.getString("VERI_MANCHECK_COMPLETED"));						
				}
				
				
				if(stremanpendflag.equals("N"))
					streman="C";
				else
				{
					if(chkValue.contains("EMAN"))
						streman="C";
					else
						streman="NC";
				}
				
				if(strAppstatusCode.equals("op") || strAppstatusCode.equals("pa"))
				{
					if(!(manualcheck.equalsIgnoreCase("on")|| manualcheck.equalsIgnoreCase("")))
					{
						strSanctioncheck="N";
					}
				}else{
					strSanctioncheck="N";
				}
			
			}
	
			/*if(!strAppReferenceNumber.equals(""))
			{
				if (rs != null) 
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("^"+strLapsProposalNumber);
				if(rs.next())
				{
					strApplExists="Y";
					strSantionRefNumber = Helper.correctNull((String)rs.getString(""));
					strSantionDate = Helper.correctNull((String)rs.getString(""));
					strAccNumber = Helper.correctNull((String)rs.getString(""));
					strCBSId = Helper.correctNull((String)rs.getString(""));
					strAccountOpeningDate = Helper.correctNull((String)rs.getString(""));
					
					
				}	
				
				strApplExists="Y";
				strSantionRefNumber="01234";
				strSantionDate="20-03-2019";
				strAccNumber="1234567890"; 
				strCBSId="23456";
				strAccountOpeningDate="20-02-2019";
			}*/
			
			
			
			
			
			hshValues.put("strApplExists", strApplExists);
			hshValues.put("strSantionRefNumber", strSantionRefNumber);
			hshValues.put("strSantionDate",strSantionDate );
			hshValues.put("strAccNumber",strAccNumber );
			hshValues.put("strCBSId", strCBSId);
			hshValues.put("strAccountOpeningDate", strAccountOpeningDate);
			hshValues.put("strAppstatus", strAppstatus);
			hshValues.put("strAppstatusCode", strAppstatusCode);
			hshValues.put("BIR_reportdate", BIR_reportdate);
			hshValues.put("mclrbaserate", mclrbaserate);
			hshValues.put("proceedSanction", strSanctioncheck);
			hshValues.put("strEman", streman);
				
			}
			catch(Exception e)
			{
				throw new EJBException("Error in DigitalAppInterfaceBean handleStatusDetails..."+e.toString());
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
					throw new EJBException("Error in DigitalAppInterfaceBean handleStatusDetails..."+e.toString());
				}
			}
			return hshValues;
		}
	

	public HashMap updateDigiDeviationDetail(HashMap hshValues)  
	{
		ResultSet rs=null,rs1=null;
		String strAppno=Helper.correctNull((String) hshValues.get("strappno"));
		String strQuery="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();

		try
		{
			ArrayList arrcol=new ArrayList();
			ArrayList arrrow=new ArrayList();
			String[] strapptype=null,strcibilscore=null,strcibilcom=null,strselcibil=null,strincome=null,strincomecom=null,strselincome=null;
			int intsize=0;

			if(hshValues.get("hid_apptype") instanceof String[])
			{
				strapptype=(String[])hshValues.get("hid_apptype");
				strcibilscore=(String[])hshValues.get("txt_cibilscore");
				strcibilcom=(String[])hshValues.get("txt_cibilcomments");
				strselcibil=(String[])hshValues.get("select_cibil");
				strincome=(String[])hshValues.get("txt_income");
				strincomecom=(String[])hshValues.get("txt_incomecomments");
				strselincome=(String[])hshValues.get("select_income");
				
				for(int j=0;j<strapptype.length;j++)
				{
					String cibiluserid="";
					if(strselcibil[j].equals("S"))
						cibiluserid="";
					else
						cibiluserid=Helper.correctNull((String)hshValues.get("strUserId"));
					
					String incomeuserid="";
					if(strselincome[j].equals("S"))
						incomeuserid="";
					else
						incomeuserid=Helper.correctNull((String)hshValues.get("strUserId"));
					
					if(!strapptype[j].equalsIgnoreCase(""))
					{
						++intsize;
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strcibilcom[j]);
						arrValues.add(strselcibil[j]);
						arrValues.add(cibiluserid);
						arrValues.add(strincomecom[j]);
						arrValues.add(strselincome[j]);
						arrValues.add(incomeuserid);
						arrValues.add(strAppno);							
						arrValues.add(strapptype[j]);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_digi_devdetail");
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						hshQueryValues.put("size",String.valueOf(intsize));
					}
				}
			}
			else
			{
				String cibiluserid="";
				if(strselcibil.equals("S"))
					cibiluserid="";
				else
					cibiluserid=Helper.correctNull((String)hshValues.get("strUserId"));
				
				String incomeuserid="";
				if(strselincome.equals("S"))
					incomeuserid="";
				else
					incomeuserid=Helper.correctNull((String)hshValues.get("strUserId"));
				
				++intsize;
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cibilcomments")));
				arrValues.add(Helper.correctNull((String)hshValues.get("select_cibil")));
				arrValues.add(cibiluserid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_incomecomments")));
				arrValues.add(Helper.correctNull((String)hshValues.get("select_income")));
				arrValues.add(incomeuserid);
				arrValues.add(strAppno);							
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_apptype")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_digi_devdetail");
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
				hshQueryValues.put("size",String.valueOf(intsize));
				
			}
			
			String cibiluserid="";
			if(Helper.correctNull((String)hshValues.get("select_appscorestat")).equals("S"))
				cibiluserid="";
			else
				cibiluserid=Helper.correctNull((String)hshValues.get("strUserId"));
			
			++intsize;
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_appscorecomments")));
			arrValues.add(Helper.correctNull((String)hshValues.get("select_appscorestat")));
			arrValues.add(cibiluserid);
			arrValues.add(strAppno);							
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_digi_devdetail_appscore");
			hshQueryValues.put(String.valueOf(intsize),hshQuery);
			hshQueryValues.put("size",String.valueOf(intsize));
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean updateDigiDeviationDetail..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean updateDigiDeviationDetail in closing connection..."+e.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap getDigiDeviationDetail(HashMap hshValues)  
	{
		ResultSet rs=null,rs1=null;
		String strAppno=Helper.correctNull((String) hshValues.get("strappno"));
		String strQuery="";
		try
		{
			ArrayList arrcol=new ArrayList();
			ArrayList arrrow=new ArrayList();
			
			
			if(rs!=null){rs.close();}
			String desc="a','c";
			strQuery = SQLParser.getSqlQuery("sel_digi_deviationdet^"+strAppno+"^"+desc);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				arrcol=new ArrayList();
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_APPTYPE")));//0
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_LAPSID")));//1
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_CIBIL")));//2
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_CIBILCOMMENTS")));//3
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_INCOME")));//4
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_INCOMECOMMENTS")));//5
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_CBSID")));//6
				
				rs1 = DBUtils.executeLAPSQuery("sel_appliname_perapplicant^" + Helper.correctInt((String)rs.getString("DIGI_DEV_LAPSID")));
				if(rs1.next())
				{ 
					arrcol.add(Helper.correctNull((String)rs1.getString("perapp_fname")));//7
				}
				else
				{
					arrcol.add("");//7
				}
				
				
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_APPROVALSTAT_CIBIL")));//8
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_DEV_APPROVALSTAT_INCOME")));//9
				
				if (rs1 != null) 
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selectusername^" + Helper.correctInt((String)rs.getString("DIGI_DEV_APPROVEDBY_CIBIL")));
				if(rs1.next())
					arrcol.add(Helper.correctNull((String)rs1.getString("name")));//10
				else
					arrcol.add("");//10
				
				if (rs1 != null) 
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selectusername^" + Helper.correctInt((String)rs.getString("DIGI_DEV_APPROVEDBY_INCOME")));
				if(rs1.next())
					arrcol.add(Helper.correctNull((String)rs1.getString("name")));//11
				else
					arrcol.add("");//11

				
				arrrow.add(arrcol);
			}
			
			hshValues.put("arrdevdet", arrrow);
			
			
			desc="S";
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_digi_deviationdet^"+strAppno+"^"+desc);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("appscore",Helper.correctNull((String)rs.getString("DIGI_DEV_CIBIL")));
				hshValues.put("appscorecomments",Helper.correctNull((String)rs.getString("DIGI_DEV_CIBILCOMMENTS")));
				hshValues.put("appscorestat",Helper.correctNull((String)rs.getString("DIGI_DEV_APPROVALSTAT_CIBIL")));
				
				if (rs1 != null) 
					rs1.close();
				
				rs1 = DBUtils.executeLAPSQuery("selectusername^" + Helper.correctInt((String)rs.getString("DIGI_DEV_APPROVEDBY_CIBIL")));
				if(rs1.next())
				{
					hshValues.put("appscoreapproved",Helper.correctNull((String)rs1.getString("name")));
				}
					
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean getDigiDeviationDetail..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean getDigiDeviationDetail in closing connection..."+e.toString());
			}
		}	
		return hshValues;
	}
	
	
	public HashMap getDigiDecisionDetail(HashMap hshValues)  
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strphoto="",strsign="",strmanualcheck="",strBranchRec="",strHeadOfficeRec="",strAmber="",strgstcheck="",
		digiAppNo="",perRefNo="",strPerConstution="";
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
			
			rs = DBUtils.executeLAPSQuery("sel_appl_cibildetails^" + strAppno);
			int cnt=0;
			while(rs.next())
			{
				cnt=cnt+1;
				arrcol=new ArrayList();
				arrcol.add(Helper.correctNull((String)rs.getString("fname")));//0
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));//1
				arrcol.add(Helper.correctNull((String)rs.getString("CIBIL_SCORE")));//2
				arrcol.add(Helper.correctNull((String)rs.getString("DEMO_TYPE")));//3
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ADDRESSCHANGE_FLAG")));//4
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PAN_FLAG")));//5
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIADDRESS_FLAG")));//6
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIEMP_FLAG")));//7
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_FIBANKSTAT_FLAG")));//8
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_ID")));//9
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMPLOYMENT")));//10
				arrcol.add(Helper.correctNull((String)rs.getString("DEMO_INCLUDEINCOME")));//11
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKNAME")));//12
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_EMAN_BANKACC")));//13
				
				
				
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
						strBranchRec=Helper.correctNull((String)rs1.getString("VERI_BRANCH_RECOMMEND"));
						strHeadOfficeRec=Helper.correctNull((String)rs1.getString("VERI_HO_RECOMMEND"));
						hshValues.put("strgstcheck",Helper.correctNull((String)rs1.getString("VERI_GSTCHECK_AUTO")));
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
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID_VER_FLAG")));//33
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PROFORMA_INVOICE")));//34
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_RESIDENCE_PROOF")));//35
					
					
				String strAMBERRULES=Helper.correctNull((String)rs.getString("DEMO_DIGI_AMBERRULES"));
				String[] strarrAmberRules=strAMBERRULES.split("@");
				ArrayList arrAmberRow=new ArrayList();
				
				int amberlength=strarrAmberRules.length;
				if(amberlength>0)
				{
					for(int i=0;i<amberlength;i++)
					{
						if (rs1 != null) 
							rs1.close();
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^" + "232"+"^"+strarrAmberRules[i]);
						if(rs1.next())
						{
							arrAmberRow.add(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
						}
					}
				}
				if(!arrAmberRow.isEmpty())
					strAmber="AmberExist";
				arrcol.add(arrAmberRow);//36
				
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_HUNTERSCORE")));//37
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_HUNTER_RULEMATCH")));//38
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_JOCATA_MATCH")));//39
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_CFR_MATCH")));//40
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_THICKSCORE")));//41
				arrcol.add(Helper.correctNull((String)rs.getString("DIGI_THINSCORE")));//42
				
				rs2 = DBUtils.executeLAPSQuery("sel_approve^" + strAppno+"^"+Helper.correctNull((String)rs.getString("PERAPP_ID")));
				if(rs2.next())
				{
					arrcol.add(Helper.correctNull((String)rs2.getString("DEMO_AMBER_APPROVAL")));//43
				}
				else{
					arrcol.add("");//43
				}
				arrcol.add(Helper.correctNull((String)rs.getString("perapp_dedupeflag")));//44
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_PANNO")));//45
				arrcol.add(Helper.correctNull((String)rs.getString("PERAPP_AADHAAR")));//46
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
			
			//loan amount
			if (rs != null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("getloanterms^" + strAppno);
			if(rs.next())
			{
				hshValues.put("loan_recmdamt", Helper.correctNull((String)rs.getString("loan_recmdamt")));
				hshValues.put("LOAN_DIGI_TOT_PROCESSINGFEE", Helper.correctNull((String)rs.getString("LOAN_DIGI_TOT_PROCESSINGFEE")));
				hshValues.put("LOAN_DIGI_PROCESSINGFEEPAID", Helper.correctNull((String)rs.getString("LOAN_DIGI_PROCESSINGFEEPAID")));
				hshValues.put("loan_Digi_deviation", Helper.correctNull((String)rs.getString("loan_Digi_deviation")));
				hshValues.put("LOAN_UPFRONTFEE", Helper.correctNull((String)rs.getString("LOAN_UPFRONTFEE"))); //upfront fee
				hshValues.put("LOAN_UPFRONTFEECOL", Helper.correctNull((String)rs.getString("LOAN_UPFRONTFEECOL"))); //upfront fee collected
			}
			if(Helper.correctNull((String) hshValues.get("hidAction")).equalsIgnoreCase("Submit"))
			{
				hshValues.put("Submitstatus", "Sucess");
			}
			if(Helper.correctNull((String) hshValues.get("hidAction")).equalsIgnoreCase("reject"))
			{
				hshValues.put("rejectstatus", "Sucess");
			}
			
			
			rs=DBUtils.executeLAPSQuery("sel_autoLoan_verfication^"+strAppno);
			if(rs.next())
			{
				digiAppNo=Helper.correctNull((String)rs.getString("DIGI_APP_NO"));
				perRefNo=Helper.correctNull((String)rs.getString("PER_REF_NO"));
			}
			hshValues.put("digiAppNo",digiAppNo);
			hshValues.put("perRefNo",perRefNo);
			hshValues.put("strBranchRec", strBranchRec);
			hshValues.put("strHeadOfficeRec", strHeadOfficeRec);
			hshValues.put("amberExist", strAmber);

			
			String strSetupClassForOtherDev="",strOtherDevFlag="";
			String strSetupClassForModfInt="",strModIntFlag="",strprdcode="",strUserClass="";
			
			strQuery = SQLParser.getSqlQuery("selprodinfo^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strprdcode = correctNull((String) rs.getString("app_prdcode"));
			}

			strQuery=SQLParser.getSqlQuery("sel_deviationauthorityuser^"+correctNull((String) hshValues.get("strUserId")));
			rs1=DBUtils.executeQuery(strQuery);
 			if(rs1.next())
			{
				strUserClass = correctNull(rs1.getString("usr_class"));
			}
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
				
			hshValues.put("strOtherDevFlag", strOtherDevFlag);
			hshValues.put("strModIntFlag", strModIntFlag);
		
			
			
			strQuery = SQLParser.getSqlQuery("seleligibileconst^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strPerConstution = correctNull((String) rs.getString("perapp_constitution"));
			}
			
			hshValues.put("strPerConstution", strPerConstution);
			
			String strAppHolder="";
			strQuery = SQLParser.getSqlQuery("sel_cbsaccno^" + strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				strAppHolder = correctNull((String) rs1.getString("app_applnholder"));
			}
			hshValues.put("strAppHolder", strAppHolder);
			hshValues.put("Appcnt", String.valueOf(cnt));//Integer.toString
			
			
			if (rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_demodata^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!correctNull((String) rs.getString("DEMO_DIGI_AMBERRULES")).equalsIgnoreCase(""))
				{
					hshValues.put("AMBER_APPROVAL", Helper.correctNull((String)rs.getString("DEMO_AMBER_APPROVAL")) );
					hshValues.put("AMBER_APPROVAL_ID", Helper.correctNull((String)rs.getString("DEMO_USERID")) );
					hshValues.put("DEMO_AMBER_APPROVAL", Helper.correctNull((String)rs.getString("DEMO_AMBER_APPROVAL")) );
					hshValues.put("DEMO_AMBER_DATE", Helper.correctNull((String)rs.getString("DEMO_AMBER_DATE")) );
				}
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean getDigiDecisionDetail..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean getDigiDecisionDetail in closing connection..."+e.toString());
			}
		}
		return hshValues;
	
	}
	public HashMap updateSanctionDetails(HashMap hshValues)  
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
		String strRecHeadOffice=Helper.correctNull((String) hshValues.get("txt_recHeadOffice"));
		String strBranch=Helper.correctNull((String) hshValues.get("txt_recBranch"));
		//String strchrper=Helper.correctNull((String) hshValues.get("chk_busineess_proof"));
		String str_sms_flag="";
		
		
		String strQuery="",strMessage="";
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
				orgscode="001";//LSRR Report for Xpress cash coming Branch. Need to change to Processcode to Head Office 001.
				
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
				arrValues.add("pa");
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
			else if(strAction.equalsIgnoreCase("Save"))
			{
				
				strQuery=SQLParser.getSqlQuery("select_verifydocument^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					str_sms_flag=Helper.correctNull(rs1.getString("VERI_SMS_SENT_FLAG"));
				}
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_verifydocument");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//need to update
				if(hidKYCChk.contains("PAP")&&hidKYCChk.contains("PAN")&&hidKYCChk.contains("PAC"))
				{
				
					strkycPending="N";
					
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_perapp_kyc_pending");
				arrValues.add(strkycPending);
				arrValues.add(strappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				if(strAdd.equalsIgnoreCase("4")&& strEmpl.equalsIgnoreCase("4") && strBnkstmt.equalsIgnoreCase("4") )
				{
					strfipending="N";
					
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_perapp_fi_pending");
				arrValues.add(strfipending);
				arrValues.add(strappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
				if(hidKYCChk.contains("EMAN"))
				{
					
					stremanPending="N";
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_perapp_eman_pending");
				arrValues.add(stremanPending);
				arrValues.add(strappid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
							
				if(!str_sms_flag.equals("Yes"))
				{
					
					if(strAdd.equalsIgnoreCase("4")&& strEmpl.equalsIgnoreCase("4") && strBnkstmt.equalsIgnoreCase("4") )
				{
				
				//str_sms_flag="Yes";
					
				String strMobileno="";

				//fi completed but kyc not completed
				if(!str_sms_flag.equals("No")&& strkycPending.equals("Y"))
				{
					if(strkycPending.equals("Y"))
					{
						rs=DBUtils.executeLAPSQuery("sel_sms_master");
						if(rs.next())
						{
							strMessage=Helper.correctNull(rs.getString("KYC_NOT_COMPLETED"));
						}
						
						str_sms_flag="No";
					}
					/*else
					{
						
						str_sms_flag="Yes";
					}*/
				//end
				
				
				if(rs!=null)
				rs.close();
							
				
							
				rs2=DBUtils.executeLAPSQuery("selBranchCityName^"+strAppno);
				if(rs2.next())
				{
				strMessage=strMessage.replaceAll("@Branch", Helper.correctDouble(rs2.getString("ORG_NAME")));
				
				}
							
				rs1=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strAppno);
				if(rs1.next())
				{
				strMobileno=Helper.correctNull(rs1.getString("con_mobile"));
				strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs1.getString("perapp_fname")));
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
					log.info("================== Service Ended================");
					
									
				}catch(Exception e)
				
				{
					query = "dcode="+ApplicationParams.getStrSMSDCode()+"&userid="+ApplicationParams.getStrSMSUserID()+"&pwd="+ApplicationParams.getStrSMSPassword()+"&sender="+ApplicationParams.getStrSMSSender()+"&pno="+strMobileno+"&msgtype="+ApplicationParams.getStrSMSTypeFlag()+"&msgtxt="+strMessage;
					log.info("==================Invoking Service in Catch Block================"+ApplicationParams.getStrSMSURL() + "?" + query);
					conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
					log.info("================== Service Ended================");

					throw new EJBException("Exception in updatesanctiondetails ==="+e.getMessage());
				}
				}
				
				}
				}
				
				
				if(!hidKYCChk.equalsIgnoreCase(""))
				{
					String[] hidKYCChkSplit=hidKYCChk.split("~");
					for(int i=0;i<hidKYCChkSplit.length;i++)
					{
						String[] hidKYCChkSplitVal=hidKYCChkSplit[i].split("@");
						if(!hidKYCChkSplitVal.equals(""))
						{
							String StrDocVal=hidKYCChkSplitVal[1]+"@"+hidKYCChkSplitVal[4]+"@"+hidKYCChkSplitVal[7]+"@"+hidKYCChkSplitVal[10]+"@";//+hidKYCChkSplitVal[13]+"@"+hidKYCChkSplitVal[16]+"@";
							String StrDocDate=hidKYCChkSplitVal[2]+"@"+hidKYCChkSplitVal[5]+"@"+hidKYCChkSplitVal[8]+"@"+hidKYCChkSplitVal[11]+"@";//+hidKYCChkSplitVal[14]+"@"+hidKYCChkSplitVal[17]+"@";
							String StrDocUser=hidKYCChkSplitVal[3]+"@"+hidKYCChkSplitVal[6]+"@"+hidKYCChkSplitVal[9]+"@"+hidKYCChkSplitVal[12]+"@";//+hidKYCChkSplitVal[15]+"@"+hidKYCChkSplitVal[18]+"@";
							
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
							arrValues.add(Helper.correctNull((String) hshValues.get("chk_photograph")));
							arrValues.add(Helper.correctNull((String) hshValues.get("chk_specimen")));
							arrValues.add(Helper.correctNull((String) hshValues.get("chk_physicalcompleted")));
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}

					}
				}
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
					
					
					if(hidKYCChkSplit[i].contains("POA")&& hidKYCChkSplit[i].contains("BP")&& hidKYCChkSplit[i].contains("BNK")&& hidKYCChkSplit[i].contains("PRA")&& hidKYCChkSplit[i].contains("ITR")&&hidKYCChkSplit[i].contains("EMP"))
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
					
					
					if(hidKYCChkSplit[i].contains("PCA") &&hidKYCChkSplit[i].contains("PPA")&&hidKYCChkSplit[i].contains("PAN"))
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
					
					
					
					String[] hidKYCChkSplitVal=hidKYCChkSplit[i].split("@");
					if(!hidKYCChkSplitVal.equals(""))
					{
						String StrDocVal=hidKYCChkSplitVal[1]+"@"+hidKYCChkSplitVal[4]+"@"+hidKYCChkSplitVal[7]+"@"+hidKYCChkSplitVal[10]+"@"+hidKYCChkSplitVal[13]+"@"+hidKYCChkSplitVal[16]+"@"+hidKYCChkSplitVal[19]+"@"+hidKYCChkSplitVal[22]+"@"+hidKYCChkSplitVal[25]+"@";//+hidKYCChkSplitVal[28]+"@";//+hidKYCChkSplitVal[31]+"@";
						String StrDocDate=hidKYCChkSplitVal[2]+"@"+hidKYCChkSplitVal[5]+"@"+hidKYCChkSplitVal[8]+"@"+hidKYCChkSplitVal[11]+"@"+hidKYCChkSplitVal[14]+"@"+hidKYCChkSplitVal[17]+"@"+hidKYCChkSplitVal[20]+"@"+hidKYCChkSplitVal[23]+"@"+hidKYCChkSplitVal[26]+"@";//+hidKYCChkSplitVal[29]+"@";//+hidKYCChkSplitVal[32]+"@";
						String StrDocUser=hidKYCChkSplitVal[3]+"@"+hidKYCChkSplitVal[6]+"@"+hidKYCChkSplitVal[9]+"@"+hidKYCChkSplitVal[12]+"@"+hidKYCChkSplitVal[15]+"@"+hidKYCChkSplitVal[18]+"@"+hidKYCChkSplitVal[21]+"@"+hidKYCChkSplitVal[24]+"@"+hidKYCChkSplitVal[27]+"@";//+hidKYCChkSplitVal[30]+"@";//+hidKYCChkSplitVal[33]+"@";
						
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
						arrValues.add(strRecHeadOffice);
						arrValues.add(strBranch);
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}

				}
			}
			}
			else if(strAction.equalsIgnoreCase("SaveAL"))	
			
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
						
						
						if(hidKYCChkSplit[i].contains("POA")&& hidKYCChkSplit[i].contains("BP")&& hidKYCChkSplit[i].contains("BNK")&& hidKYCChkSplit[i].contains("PRA")&& hidKYCChkSplit[i].contains("ITR")&&hidKYCChkSplit[i].contains("EMP")&&hidKYCChkSplit[i].contains("PI")&&hidKYCChkSplit[i].contains("POR"))
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
						
						
						if(hidKYCChkSplit[i].contains("PCA") &&hidKYCChkSplit[i].contains("PPA")&&hidKYCChkSplit[i].contains("PAN"))
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
												
						
						String[] hidKYCChkSplitVal=hidKYCChkSplit[i].split("@");
						if(!hidKYCChkSplitVal.equals(""))
						{
							String StrDocVal=hidKYCChkSplitVal[1]+"@"+hidKYCChkSplitVal[4]+"@"+hidKYCChkSplitVal[7]+"@"+hidKYCChkSplitVal[10]+"@"+hidKYCChkSplitVal[13]+"@"+hidKYCChkSplitVal[16]+"@"+hidKYCChkSplitVal[19]+"@"+hidKYCChkSplitVal[22]+"@"+hidKYCChkSplitVal[25]+"@"+hidKYCChkSplitVal[28]+"@"+hidKYCChkSplitVal[31]+"@";
							String StrDocDate=hidKYCChkSplitVal[2]+"@"+hidKYCChkSplitVal[5]+"@"+hidKYCChkSplitVal[8]+"@"+hidKYCChkSplitVal[11]+"@"+hidKYCChkSplitVal[14]+"@"+hidKYCChkSplitVal[17]+"@"+hidKYCChkSplitVal[20]+"@"+hidKYCChkSplitVal[23]+"@"+hidKYCChkSplitVal[26]+"@"+hidKYCChkSplitVal[29]+"@"+hidKYCChkSplitVal[32]+"@";
							String StrDocUser=hidKYCChkSplitVal[3]+"@"+hidKYCChkSplitVal[6]+"@"+hidKYCChkSplitVal[9]+"@"+hidKYCChkSplitVal[12]+"@"+hidKYCChkSplitVal[15]+"@"+hidKYCChkSplitVal[18]+"@"+hidKYCChkSplitVal[21]+"@"+hidKYCChkSplitVal[24]+"@"+hidKYCChkSplitVal[27]+"@"+hidKYCChkSplitVal[30]+"@"+hidKYCChkSplitVal[33]+"@";
							
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
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add(Helper.correctNull((String) hshValues.get("chk_gstverification")));
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
	
		String cbsId[]=hidKYCChk.split("@");
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "upd_cbsid_perapp");
		arrValues.add(cbsId[1]);
		arrValues.add(cbsId[0]);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		String demoAppType="",demoAppNo="",strInwrdNo="";
	
		strQuery = SQLParser.getSqlQuery("sel_appId_perdemo^"+cbsId[0]);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			 demoAppType = Helper.correctNull((String)rs.getString("demo_type"));				
			 demoAppNo = Helper.correctNull((String)rs.getString("DEMO_APPNO"));		 
		}	
		
		if(demoAppType.equalsIgnoreCase("a")){
		
			
			strQuery = SQLParser.getSqlQuery("compropform6^"+demoAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strInwrdNo = Helper.correctNull((String)rs.getString("APP_INWARDNO"));			
			}
			
			
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

	
 public HashMap loanAccountCreationService(HashMap hshValues)  {
		 
		 String line="",strRequestUuid="",strInputXMLRequest="",strRes="",strServiceReqId="",
		strServiceReqVersion="",strChannelId="",strBankId="",strMsgDateTim="",strRequestId="",strInputVal="",
		strstatus="",strMessage="",strMobileno="",strresultmsg="",strMessageDateTime="",strQuery="";
		ResultSet rs= null,rs1=null,rs2=null,rs3=null;
		String strAccountno="";
		HashMap accountFlat = new HashMap();

		 try
	{
			
			 String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
			String appno=Helper.correctNull((String)hshValues.get("appno"));
			String mobilebanking=Helper.correctNull((String)hshValues.get("strmobilebankingtype"));

			 if(hidAction.equals("manualCBS"))
			 {
				 	strQuery=SQLParser.getSqlQuery("sel_AccountHandOffDetails^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					
					strQuery=SQLParser.getCBSSqlQuery("sel_cbs_accno_fromfinacle_newconnection^"+appno);
					rs1=DBUtils.executeQueryCBSConnection(strQuery);
					
					if(!(rs.next() && rs1.next()))
					{
						hshValues.put("moduleType", "RETDIGI");
						strQuery=SQLParser.getSqlQuery("sel_depositmanualcreation^"+appno);
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{//aif
							hshValues.put("strPrdType", Helper.correctNull((String)rs2.getString("prd_type")));
							hshValues.put("strdigiType", Helper.correctNull((String)rs2.getString("APP_LOANSUBTYPE_DIGI")));			
							}
						if(rs2!=null){
							rs2.close();
						}
						FinacleInterfaceBean getAccountFlatFileReportObj=new FinacleInterfaceBean();
						accountFlat=getAccountFlatFileReportObj.getOtherFlatFileReport(hshValues);
						
						log.info("Loan Account Trigger Service ========== Data Pushed to Staging Table");
					}
			 }
				
			
			 
			 log.info("Loan Account Trigger Service ========== CBS Account Creation API Started");

	
	HashMap hshQueryValues 	= new HashMap();
	HashMap hshQuery 		= new HashMap();
	ArrayList arrValues		= new ArrayList();

	
	String strSolID="";
	strQuery=SQLParser.getSqlQuery("sel_cbsdetails^"+appno+"^1");
	rs=DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		strSolID=Helper.correctNull((String)rs.getString("LOANDISBBRANCH"));
	}
	
	SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	strMessageDateTime=simpledateformat.format(new Date());
	
	log.info("Loan Account Trigger Service ========== Request Generation");
	String strloanprdtype="";
	String strdigiloansubtype="";
	strQuery=SQLParser.getSqlQuery("sel_depositmanualcreation^"+appno);
	rs3=DBUtils.executeQuery(strQuery);
	if(rs3.next())
	{//aif
		strloanprdtype= Helper.correctNull((String)rs3.getString("prd_type"));
		strdigiloansubtype=Helper.correctNull((String)rs3.getString("APP_LOANSUBTYPE_DIGI"));			
		}
	
	
/*	StringWriter strReqWriter = new StringWriter();
	XMLOutputFactory xOPFactory = XMLOutputFactory.newInstance();
	XMLStreamWriter xReqStreamWriter = xOPFactory.createXMLStreamWriter(strReqWriter);

	xReqStreamWriter.writeStartDocument("UTF-8", "1.0");
	xReqStreamWriter.writeStartElement("FIXML");
	xReqStreamWriter.writeAttribute("xsi","http://www.finacle.com/fixml", "schemaLocation","http://www.finacle.com/fixml RetCustInq.xsd");
	xReqStreamWriter.writeAttribute("xmlns","http://www.finacle.com/fixml");
	xReqStreamWriter.writeAttribute("xmlns","http://www.finacle.com/fixml", "xsi","http://www.w3.org/2001/XMLSchema-instance");
	xReqStreamWriter.writeStartElement("Header");
	xReqStreamWriter.writeStartElement("RequestHeader");
	xReqStreamWriter.writeStartElement("MessageKey");
	xReqStreamWriter.writeStartElement("RequestUUID");
	xReqStreamWriter.writeCharacters("Req_"+appno);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ServiceRequestId");
	xReqStreamWriter.writeCharacters("executeFinacleScript");
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ServiceRequestVersion");
	xReqStreamWriter.writeCharacters("10.2");
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ChannelId");
	xReqStreamWriter.writeCharacters("COR");
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();   // end tag messagekey
	
	xReqStreamWriter.writeStartElement("RequestMessageInfo");
	xReqStreamWriter.writeStartElement("BankId");
	xReqStreamWriter.writeCharacters("01");
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("MessageDateTime");
	xReqStreamWriter.writeCharacters(strMessageDateTime);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement(); //end tag for reqmsginfo
	xReqStreamWriter.writeEndElement();   // end tag RequestHeader
	xReqStreamWriter.writeEndElement();   // end tag Header
	
	xReqStreamWriter.writeStartElement("Body");
	xReqStreamWriter.writeStartElement("executeFinacleScriptRequest");
	xReqStreamWriter.writeStartElement("ExecuteFinacleScriptInputVO");
	xReqStreamWriter.writeStartElement("requestId");
	xReqStreamWriter.writeCharacters("lnodopn_digiloan.scr");
	xReqStreamWriter.writeEndElement(); 
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("executeFinacleScript_CustomData");
	xReqStreamWriter.writeStartElement("InputVal");
	xReqStreamWriter.writeCharacters(appno+"1"+strSolID);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement(); 
	xReqStreamWriter.writeEndElement(); //body
	xReqStreamWriter.writeEndElement(); //fixml
	
	xReqStreamWriter.flush();
	xReqStreamWriter.close();*/

	//strInputXMLRequest = strReqWriter.getBuffer().toString();
	if(strloanprdtype.equalsIgnoreCase("pR") && mobilebanking.equalsIgnoreCase("Y")){
		strInputXMLRequest="<?xml version=\"1.0\" encoding=\"UTF-8\"?><FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml RetCustInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
				"<Header><RequestHeader><MessageKey><RequestUUID> Req_"+appno+" </RequestUUID><ServiceRequestId>executeFinacleScript" +
				"</ServiceRequestId><ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>COR</ChannelId></MessageKey>" +
				"<RequestMessageInfo><BankId>01</BankId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo>" +
						"</RequestHeader></Header><Body><executeFinacleScriptRequest>" +
						"<ExecuteFinacleScriptInputVO><requestId>lnodopn_dl.scr</requestId></ExecuteFinacleScriptInputVO>" +
						"<executeFinacleScript_CustomData><InputVal>"+appno+"1"+strSolID+"</InputVal></executeFinacleScript_CustomData></executeFinacleScriptRequest></Body></FIXML>";
	}else if((strloanprdtype.equalsIgnoreCase("pR")||strloanprdtype.equalsIgnoreCase("pG"))&&(strdigiloansubtype.equalsIgnoreCase(""))){
	strInputXMLRequest="<?xml version=\"1.0\" encoding=\"UTF-8\"?><FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml RetCustInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
			"<Header><RequestHeader><MessageKey><RequestUUID> Req_"+appno+" </RequestUUID><ServiceRequestId>executeFinacleScript" +
			"</ServiceRequestId><ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>COR</ChannelId></MessageKey>" +
			"<RequestMessageInfo><BankId>01</BankId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo>" +
					"</RequestHeader></Header><Body><executeFinacleScriptRequest>" +
					"<ExecuteFinacleScriptInputVO><requestId>lnodopn_gldl.scr</requestId></ExecuteFinacleScriptInputVO>" +
					"<executeFinacleScript_CustomData><InputVal>"+appno+"1"+strSolID+"</InputVal></executeFinacleScript_CustomData></executeFinacleScriptRequest></Body></FIXML>";
	}else{
		strInputXMLRequest="<?xml version=\"1.0\" encoding=\"UTF-8\"?><FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml RetCustInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
		"<Header><RequestHeader><MessageKey><RequestUUID> Req_"+appno+" </RequestUUID><ServiceRequestId>executeFinacleScript" +
		"</ServiceRequestId><ServiceRequestVersion>10.2</ServiceRequestVersion><ChannelId>COR</ChannelId></MessageKey>" +
		"<RequestMessageInfo><BankId>01</BankId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo>" +
				"</RequestHeader></Header><Body><executeFinacleScriptRequest>" +
				"<ExecuteFinacleScriptInputVO><requestId>lnodopn_digiloan.scr</requestId></ExecuteFinacleScriptInputVO>" +
				"<executeFinacleScript_CustomData><InputVal>"+appno+"1"+strSolID+"</InputVal></executeFinacleScript_CustomData></executeFinacleScriptRequest></Body></FIXML>";
	
	}
	// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@ CHM & CIBIL Request @@@@@@@@@@@@@################"+
	// strInputXMLRequest);
	log.info("################@@@@@@@@@@@@@ Loan Account Creation Requet @@@@@@@@@@@@@################"+ strInputXMLRequest);
			
			
	// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
	// ApplicationParams.getstrCHMCIBILURL());
	// System.out.println("################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
	// ApplicationParams.getstrCHMCIBILURL());
	URL url = new URL(ApplicationParams.getStrCBSIDCreation());
	log.info("Loan Account Creation URL ===> "+url);		
	//HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
	HttpsURLConnection  urlcon = (HttpsURLConnection) url.openConnection();
			
	urlcon.setRequestProperty("User-Agent", "");
	urlcon.setDoInput(true);
	urlcon.setDoOutput(true);
	urlcon.setRequestMethod("POST");
	urlcon.setRequestProperty("Content-Type","application/xml;charset=UTF-8");
			
	OutputStreamWriter osw = new OutputStreamWriter(urlcon.getOutputStream(),"UTF-8");
									
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
		log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ result.toString());
		// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
		// + result.toString());
		strRes = result.toString();
		System.out.println(strRes);
		
		
		try {
			 
			String responseCbs = result.toString();
            responseCbs=responseCbs.replace("^([\\W]+)<","<");
            responseCbs=responseCbs.replace("utf-16","utf-8");
                     
            int nodesize=0;
            DocumentBuilderFactory docbuildfactory = DocumentBuilderFactory.newInstance();    
            DocumentBuilder docBuilder = docbuildfactory.newDocumentBuilder();                
            Document doc = docBuilder.parse(new ByteArrayInputStream(responseCbs.getBytes()));
            doc.getDocumentElement().normalize();
           
           String strStatus="";
           NodeList nodesListheader = doc.getElementsByTagName("executeFinacleScript_CustomData");
           strStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("SuccessOrFailure").item(0).getChildNodes().item(0).getNodeValue();							

           
           NodeList nodesList = doc.getElementsByTagName("Body");
           if(strStatus.equalsIgnoreCase("Y"))
           {
        	   strresultmsg=(String)((Element)nodesList.item(0)).getElementsByTagName("RESULT_MSG").item(0).getChildNodes().item(0).getNodeValue();
        	   strAccountno=(String)((Element)nodesList.item(0)).getElementsByTagName("RESULT_MSG1").item(0).getChildNodes().item(0).getNodeValue();
        	   strstatus="Success";
           }
           else
           {
        	   strresultmsg=(String)((Element)nodesList.item(0)).getElementsByTagName("Error_1").item(0).getChildNodes().item(0).getNodeValue();
        	  if(strresultmsg.contains("already opened in FINACLE"))
        		  strAccountno=(String)((Element)nodesList.item(0)).getElementsByTagName("Error_2").item(0).getChildNodes().item(0).getNodeValue();
        	   strstatus="Failure";
           }
           
           
           hshValues.put("resultmsg", strresultmsg);
           hshValues.put("strstatus", strstatus);
           hshValues.put("strAccountno", strAccountno);
           
           if(strstatus.equalsIgnoreCase("Success"))
           {
        		hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "upd_cbs_accno_laps");
				arrValues = new ArrayList();
				arrValues.add(strAccountno);
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");   
           }
				  
           if(!strstatus.equalsIgnoreCase("SUCCESS"))
           {
        	   	hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_cbs_api_error_status");
				arrValues = new ArrayList();
				arrValues.add("");
				arrValues.add(strresultmsg);//appraised by
				arrValues.add(appno);
				arrValues.add("Loan Account Creation");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");   
           }
           
			if(strstatus.equalsIgnoreCase("SUCCESS"))
			{
				String strAppno=(String)hshValues.get("appno");
				
				rs=DBUtils.executeLAPSQuery("sel_sms_master");
				if(rs.next())
				{
						strMessage=Helper.correctNull(rs.getString("SMS_CBS_ACCOUNT_CREATION"));
				}
				
				rs=DBUtils.executeLAPSQuery("sel_appdetails_sms^"+strAppno);
				if(rs.next())
				{
					strMessage=strMessage.replaceAll("@CName", Helper.correctNull(rs.getString("perapp_fname")));
					strMessage=strMessage.replaceAll("@SAMT", Helper.correctDouble(rs.getString("loan_recmdamt")));
					strMobileno=Helper.correctNull(rs.getString("con_mobile"));
				}
				
				String query = null;
				URLConnection conn = null;
				String charset="UTF-8";
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
				
					throw new EJBException("Exception in viewDocumentData ==="+e.getMessage());
				}
				
			}
			
			
				if(hidAction.equals("manualCBS"))
				{
					CommWorkflowBean comm=new CommWorkflowBean();
					hshValues=comm.getHistory(hshValues);
				}
			
			}
		
				
			 catch (ParserConfigurationException pce) {
				System.out
						.println("ParserConfigurationException............");
				pce.printStackTrace();
				throw new EJBException("Exception in ParserConfiguratio ==="+pce.getMessage());
			} catch (SAXException se) {
				System.out.println("SAXException.....................");
				se.printStackTrace();
				throw new EJBException("Exception in SAX ==="+se.getMessage());

			} catch (IOException ioe) {
				System.out.println("IOException.....................");
				ioe.printStackTrace();
				throw new EJBException("Exception in Input Output ==="+ioe.getMessage());

			} catch (Exception e) {
				System.out.println("Exception.....................");
				e.printStackTrace();
				throw new EJBException("Exception in Input Output ==="+e.getMessage());

			}
			
	
	}	
	/* if(hidAction.equals("manualCBS"))
	 {
		 CommWorkflowBean cmmwrkflow=new CommWorkflowBean();
		 hshValues=cmmwrkflow.getHistory(hshValues);
	 }*/
		 
		
	}
	 catch (Exception ex) {
			// .LogWriter.log(LAPSLogLevel.ERROR,""+"Exception in updateCHMCIBILreport"
			// + ex);
			ex.printStackTrace();
			throw new EJBException("Error in loanAccountCreationService"+ex.getMessage());
			
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
			
	
		 return  hshValues;
 }
	
	
 public HashMap getDocumentURLs(HashMap hshValues)  
 {
	 JSONObject objOuter = new JSONObject();
		JSONObject data = new JSONObject();
		JSONObject objTable = new JSONObject();
		
		String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = ""
				, strInputJSONRequest = "", strRes = "", strCustDesc = "", strEntity = ""
				, strApplicationNo = "", strFileName = ""
				, strUserId = "", strCreatedDate = "", strSNo = "", strDelFlag = "", strDelUseId =""
				, strDelDate = "", strDocFacslNo ="",strQuery="";

		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshVal = new HashMap();
		ArrayList arrValue = null;
		ArrayList arrValues = null;
		HashMap hshValue = new HashMap();
		HashMap hshValue1 = new HashMap();
		HashMap hshQuery = new HashMap();
		try {
			
			strApplicationNo = Helper.correctNull((String)hshValues.get("app_no"));
			if(strApplicationNo.equals(""))
			{
				strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
			
			
			
			//delete doc attachmennts
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_appdoc_extappl");
			hshQueryValues.put("1",hshQuery);
			
			//delete external appplication document
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_docattach_extappl");
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			String strDmsRefNo="";
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_leadnumber_appno^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strDmsRefNo=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));
    		}
					
    		String applicantIn="{" +
			"\"LeadNumber\":\""+strDmsRefNo+""+"\"}";
	
			System.out.print(applicantIn);
			log.info("################@@@@@@@@@@@@@ DIGI LOAN DOCUMENT REQUEST @@@@@@@@@@@@@################ "+applicantIn);
			
			URL Docdms_url = new URL(ApplicationParams.getStrReadTableFromServer());
			log.info("DIGI LOAN DOCUMENT URL=========== "+Docdms_url);
			HttpURLConnection Docdms_urlcon = (HttpURLConnection) Docdms_url.openConnection();
			Docdms_urlcon.setRequestProperty("User-Agent", "");
			Docdms_urlcon.setDoInput(true);
			Docdms_urlcon.setDoOutput(true);
			Docdms_urlcon.setRequestMethod("POST");
			Docdms_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
			
			OutputStream Docdms_outputStream = Docdms_urlcon.getOutputStream();
			OutputStreamWriter Docdms_osw = new OutputStreamWriter(Docdms_outputStream, "UTF8");
			
			BufferedWriter Docdms_bWriter = new BufferedWriter(Docdms_osw);
			Docdms_bWriter.write(applicantIn);
			Docdms_bWriter.close();
	
	
						
						InputStream Docdms_inputStream = Docdms_urlcon.getInputStream();
						InputStreamReader Docdms_isreader = new InputStreamReader(Docdms_inputStream,"UTF-8");
						
						BufferedReader Docdms_rd = new BufferedReader(Docdms_isreader);
				
						if (Docdms_rd != null) {
							StringBuffer Docdms_result = new StringBuffer();
							while ((line = Docdms_rd.readLine()) != null) {
								Docdms_result.append(line);
							}
						log.info("################@@@@@@@@@@@@@ Response document list api Response @@@@@@@@@@@@@################"
									+ Docdms_result.toString());
				
						
						if(!Docdms_result.toString().equalsIgnoreCase("")){
							JSONObject jsonReadTableResponseObj	 = 	new JSONObject(Docdms_result.toString());
							JSONArray jsonArray3 = jsonReadTableResponseObj.getJSONArray("output");

							int doclistlength=jsonArray3.length();
							if(doclistlength>0)
							{
								ArrayList arrtemp=new ArrayList();
								int sno=0;
								for(int i=0;i<doclistlength;i++)
								{
									
									JSONObject jsonObjectForValues = jsonArray3.getJSONObject(i);
									
									String strResDocCode = jsonObjectForValues.getString("DocCode");
									String strUrl = jsonObjectForValues.getString("Docurl");
									String strMimetype= jsonObjectForValues.getString("DocType");
									String generatedUrl = jsonObjectForValues.getString("Docurl");
									String strDocType= jsonObjectForValues.getString("DocType");

									String strFile = jsonObjectForValues.getString("Docname");
									
									
									String strdoctype="",strdocid="";
									rs = DBUtils.executeLAPSQuery("sel_documentdetails_doccode^" + strResDocCode);
									if(rs.next())
									{
										strdoctype=Helper.correctNull((String)rs.getString("doc_doctype"));
										strdocid=Helper.correctNull((String)rs.getString("Document_ID"));
									}
									
									if(!arrtemp.contains(strResDocCode))
									{
										hshQuery=new HashMap();
										arrValues = new ArrayList();
										arrValues.add(strApplicationNo);
										arrValues.add("Y");
										arrValues.add(strdoctype);
										arrValues.add(strdocid);
										arrValues.add(strUserId);
										arrValues.add(strDmsRefNo);
										hshQuery.put("arrValues", arrValues);
										hshQuery.put("strQueryId", "ins_appdocuments_proposalapi");
										hshQueryValues.put("1",hshQuery);
										hshQueryValues.put("size","1");
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

										arrtemp.add(strResDocCode);
									}
							
									SimpleDateFormat dateFormat= new SimpleDateFormat("dd/MM/yyyy"); 
						            Calendar calendar = Calendar.getInstance();
						            calendar.add(Calendar.DATE,90);
						            String strDay = dateFormat.format(calendar.getTime());
									
						            sno++;
						            
									hshQuery=new HashMap();
									arrValues = new ArrayList();
									arrValues.add(strApplicationNo);
									arrValues.add(strdoctype);
									arrValues.add(strResDocCode);
									arrValues.add(strFile);//
									arrValues.add(strUserId);
									arrValues.add(String.valueOf(sno));
									arrValues.add(""); //ref no
									arrValues.add(strDay);
									arrValues.add(strUrl);//
									arrValues.add(""); //doc size
									arrValues.add(generatedUrl);//
									arrValues.add(strDmsRefNo);
									arrValues.add(strDocType);
									hshQuery.put("arrValues", arrValues);
									hshQuery.put("strQueryId", "ins_appdocattachments_proposalapi");
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								}
							}
							
						}
					}
		}
	catch (Exception ex) {
		ex.printStackTrace();
		throw new EJBException("Error in getDocumentURLs"+ex.toString());
		
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

	 return  hshValues;
	 }
 
	public HashMap getDocumentDetailsdigi(HashMap hshValues)
	{
	HashMap hshRecord=new HashMap();	
	ResultSet rs=null,rs1=null;
	String strAppno="",strQuery="",docpagetype="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrAppRow=new ArrayList();
	ArrayList arrBankRow=new ArrayList();
	ArrayList arrOtherRow=new ArrayList();
	try
	{
		String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		docpagetype=Helper.correctNull((String)hshValues.get("docpagetype"));
		if(docpagetype.equals("post"))
		{
			strQuery=SQLParser.getSqlQuery("sel_documentdetails_postsanc^"+strAppno+"^"+strAppno+"^post^"+strAppno+"^post");
		}
		else
		{
			strQuery=SQLParser.getSqlQuery("sel_documentdetails^"+strAppno+"^"+strAppno+"^pre^"+strAppno+"^pre");
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol=new ArrayList();
			arrCol.add(Helper.correctNull(rs.getString("doc_jspname")));//0
			arrCol.add(Helper.correctNull(rs.getString("doc_docname")));//1
			arrCol.add(Helper.correctNull(rs.getString("doc_id")));//2
			arrCol.add(Helper.correctNull(rs.getString("APDOC_FAC_SLNO")));//3
			if(Helper.correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("A"))
			{
				if(Helper.correctNull(rs.getString("DOC_DOCSUBTYPE")).equalsIgnoreCase("post"))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_docattachcnt^"+strAppno+"^A^"+Helper.correctNull(rs.getString("doc_jspname")));
					if(rs1.next())
						arrCol.add(Helper.correctNull(rs1.getString("cnt")));//4
					else
						arrCol.add("0");
				}
				arrAppRow.add(arrCol);
			}
			else if(Helper.correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("I"))
				arrBankRow.add(arrCol);
			else if(Helper.correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("O"))
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_docattachcnt^"+strAppno+"^O^"+Helper.correctNull(rs.getString("doc_jspname")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("cnt")));//4
				else
					arrCol.add("0");
				arrOtherRow.add(arrCol);
			}
		}
		hshRecord.put("arrAppRow", arrAppRow);
		hshRecord.put("arrBankRow", arrBankRow);
		hshRecord.put("arrOtherRow", arrOtherRow);
		
		if(rs!=null)
			rs.close();
		if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
		{
			strQuery=SQLParser.getSqlQuery("sel_applicantcbsid_corp^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strCBSID", Helper.correctNull(rs.getString("perapp_cbsid")));
			}
			
		}
		else
		{
			strQuery=SQLParser.getSqlQuery("sel_applicantcbsid_retail^a^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strCBSID", Helper.correctNull(rs.getString("perapp_cbsid")));
			}
		}
		if(rs!=null)
		{
			rs.close();
		}	
		strQuery=SQLParser.getSqlQuery("get_Appstatus^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("app_orgcode", Helper.correctNull(rs.getString("app_orgcode")));
			hshRecord.put("strAppType",Helper.correctNull(rs.getString("app_renew_flag")));
			hshRecord.put("strMigrationflag",Helper.correctNull(rs.getString("app_migration")));
		}
		hshRecord.put("appholder", Helper.correctNull((String)hshValues.get("appholder")));
		hshRecord.put("strUserId", Helper.correctNull((String)hshValues.get("strUserId")));
		hshRecord.put("strOrgCode", Helper.correctNull((String)hshValues.get("strOrgCode")));

		if(rs!=null){rs.close();}
		String inwardBranchCity="";
		ArrayList arrdisbBranch=new ArrayList();
		rs=DBUtils.executeLAPSQuery("selworkflow^"+strAppno);		 
		if(rs.next())
		{
			hshRecord.put("inward_orgcode", Helper.correctNull(rs.getString("org_code")));
		}
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("sel_cbsloandisbbranch^"+strAppno);		 
		if(rs.next())
		{
			arrdisbBranch.add(Helper.correctNull(rs.getString("org_code")));
		}
		
		String app_orgcode=Helper.correctNull((String)hshRecord.get("app_orgcode"));
		String inward_orgcode=Helper.correctNull((String)hshRecord.get("inward_orgcode"));
		String appholder=Helper.correctNull((String)hshValues.get("appholder"));
		String UserId=Helper.correctNull((String)hshValues.get("strUserId"));
		String OrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		
		int docAttCount=0;
		if(inward_orgcode.equals(OrgCode))
		{
			docAttCount++;
		}
		else if(arrdisbBranch.contains(OrgCode))
		{
			docAttCount++;
		}
		else if(appholder.equals(UserId))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("D") && (inward_orgcode.substring(0, 9)).equals(OrgCode.substring(0, 9)))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("R") && (inward_orgcode.substring(0, 6)).equals(OrgCode.substring(0, 6)))
		{
			docAttCount++;
		}
		else if(strOrgLevel.equalsIgnoreCase("C"))
		{
			docAttCount++;
		}
		
		hshRecord.put("docAttCount", Integer.toString(docAttCount));
		
		
	//	  String StrIBMUN = ApplicationParams.getStrlogintoibmdigi();
		String StrIBMUN = ApplicationParams.getStrIbmUN();
    //    String strurlibmUN= new BASE64Encoder().encode(StrIBMUN.getBytes());
        hshRecord.put("encubmurlundigi", StrIBMUN);
        
		String StrIBMPass = ApplicationParams.getStrlogintoibmPassdigi();
	//	  String strurlibm= new BASE64Encoder().encode(StrIBMPass.getBytes());
        hshRecord.put("encubmurldigi", StrIBMPass);
		
	
	}
	catch(Exception e)
	{
		throw new EJBException("Exception in getDocumentDetailsdigi ========"+e.getMessage());
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
 
 
	public HashMap getdigi_FIKYCpending(HashMap hshValues)
	{
	HashMap hshRecord=new HashMap();	
	ResultSet rs=null,rs1=null;
	String strAppno="",strQuery="",docpagetype="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrAppRow=new ArrayList();
	ArrayList arrBankRow=new ArrayList();
	ArrayList arrOtherRow=new ArrayList();
	String areacheckval="",catval="",desc="",bownameval="",subj="",absPosition="";
	String area2="",area3="",area4="",area5="",glptotlevel="",pagetype="",ddesc="";

	try
	{

		String hidcategoryType=Helper.correctNull((String)hshValues.get("hidCategoryType"));
		String strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
		strQuery = SQLParser.getSqlQuery("glpoption");
		rs =DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			glptotlevel = (String)Helper.correctNull(rs.getString(1));						
		}
		pagetype= correctNull((String)hshValues.get("link"));
		absPosition=correctNull((String)hshValues.get("hid_rowcount"));
		area2 = correctNull((String)hshValues.get("area2"));
		area3 = correctNull((String)hshValues.get("area3"));
		area4 = correctNull((String)hshValues.get("area4"));
		area5 = correctNull((String)hshValues.get("area5"));
		
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
			areacheckval="001%%%%%%%%%%%%";	
		}
		/*if(areacheckval.equalsIgnoreCase(""))
		{
			if(strOrgLevel.equalsIgnoreCase("C"))
			{
				areacheckval="001";
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				areacheckval=strOrgCode.substring(0, 6);
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				areacheckval=strOrgCode.substring(0, 9);
			}

		}*/
		
		if(rs != null)
			rs.close();
		
		String strqueryType=Helper.correctNull((String)hshValues.get("hidqueryType"));

		if(strqueryType.equals("ALL"))
		{
				strQuery = SQLParser.getSqlQuery("sel_digi_ALLpend_appl^"+areacheckval+"^"+areacheckval);
		}
		else if(strqueryType.equals("KYC"))
		{
			
				strQuery = SQLParser.getSqlQuery("sel_digi_kycpend_appl^"+areacheckval);
		}
		else if(strqueryType.equals("FI"))
		{
				strQuery = SQLParser.getSqlQuery("sel_digi_FIpend_appl^"+areacheckval);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("sel_digi_ALLpend_appl^"+areacheckval+"^"+areacheckval);
		}
		rs =DBUtils.executeQuery(strQuery);
	
		String tempstr="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		while(rs.next())
		{
			vecval =  new ArrayList();
			vecval.add(rs.getString("APP_NO"));//1		
			vecval.add(rs.getString("PERAPP_FNAME"));//2
			vecval.add(rs.getString("APP_APPLNHOLDER"));//3 
			vecval.add(rs.getString("APP_CREATEDATE"));//4		
			vecval.add("");//5		
			vecval.add("");//5	
			vecdata.add(vecval);
		}
		hshValues.put("vecval",vecdata);		
		hshValues.put("strqueryType",strqueryType);		
	
	}
	catch(Exception e)
	{
		throw new EJBException("Exception in getdigi_FIKYCpending ========"+e.getMessage());
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
	return hshValues;
	}
	
	public HashMap cbsBreService(HashMap hshValues)
	
	{
		JSONObject data = new JSONObject();
		JSONObject objTable = new JSONObject();	
		JSONObject dateofsavingdata = new JSONObject();
		
		HashMap hshVal = new HashMap();
		ArrayList arrValue = null;
		
		ArrayList atmwitwralarrValues=null;
		HashMap hshValue = new HashMap();
		HashMap hshValue1 = new HashMap();
		
		ArrayList atmwdeposarrValues=null;
		
		ArrayList balancedata= new ArrayList();
		ArrayList totaltxn=new ArrayList();
		ArrayList cashdeposit=new ArrayList();
		ArrayList cashwithdraw=new ArrayList();
		ArrayList totalcredit=new ArrayList();
		ArrayList totaldebit=new ArrayList();

		
	HashMap hshRecord=new HashMap();	
	ResultSet rs=null,rs1=null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strRequestUUID, strServiceRequestVersion,strChannelId,RetCustAdd,strBankId,strMessageDateTime,strRequestId,strInputVal,
	strInputXMLRequest="",strStatus="", line="",strfdrdflg="",strbalance="",strcredittxn="",strcashcredit="",strcashdebit="",
	strtotaldebit="",strtotalcredit="",strbal="",strtotaltxn="",strrdflg="",strfdflg="",straccopendate="",strdebitscore="",strMessageDate="";
	
	
	try
	{
	String strCbsID=Helper.correctInt((String)hshValues.get("strCustomerID"));
	strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
	strServiceRequestVersion = "10.2";
	strChannelId = "COR";
	RetCustAdd="executeFinacleScript";
	strBankId="01";
	strRequestId="custom_bre.scr";
	
	SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	strMessageDateTime=simpledateformat.format(new Date());
	
	
	/*StringWriter strReqWriter = new StringWriter();
	XMLOutputFactory xOPFactory = XMLOutputFactory.newInstance();
	XMLStreamWriter xReqStreamWriter = xOPFactory
			.createXMLStreamWriter(strReqWriter);
	
	xReqStreamWriter.writeStartDocument("UTF-8", "1.0");
	xReqStreamWriter.writeStartElement("FIXML");
	xReqStreamWriter.writeAttribute("xsi","http://www.finacle.com/fixml", "schemaLocation","http://www.finacle.com/fixml RetCustInq.xsd");
	xReqStreamWriter.writeAttribute("xmlns","http://www.finacle.com/fixml");
	xReqStreamWriter.writeAttribute("xmlns","http://www.finacle.com/fixml", "xsi","http://www.w3.org/2001/XMLSchema-instance");
	
	xReqStreamWriter.writeStartElement("Header");
	xReqStreamWriter.writeStartElement("RequestHeader");
	xReqStreamWriter.writeStartElement("MessageKey");
	xReqStreamWriter.writeStartElement("RequestUUID");
	xReqStreamWriter.writeCharacters(strRequestUUID);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ServiceRequestId");
	xReqStreamWriter.writeCharacters(RetCustAdd);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ServiceRequestVersion");
	xReqStreamWriter.writeCharacters(strServiceRequestVersion);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("ChannelId");
	xReqStreamWriter.writeCharacters(strChannelId);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();//end messagekey tag
	
	
	xReqStreamWriter.writeStartElement("RequestMessageInfo");
	xReqStreamWriter.writeStartElement("BankId");
	xReqStreamWriter.writeCharacters(strBankId);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("MessageDateTime");
	xReqStreamWriter.writeCharacters(strMessageDateTime);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();//end RequestMessageInfo tag
	xReqStreamWriter.writeEndElement(); //end header tag
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeStartElement("Body");
	xReqStreamWriter.writeStartElement("executeFinacleScriptRequest");
	xReqStreamWriter.writeStartElement("ExecuteFinacleScriptInputVO");
	xReqStreamWriter.writeStartElement("requestId");
	xReqStreamWriter.writeCharacters(strRequestId);
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();//end ExecuteFinacleScriptInputVO tag
	xReqStreamWriter.writeStartElement("executeFinacleScript_CustomData");
	xReqStreamWriter.writeStartElement("InputVal");			
	xReqStreamWriter.writeCharacters("strInputVal");
	xReqStreamWriter.writeEndElement();
	xReqStreamWriter.writeEndElement();//end of executeFinacleScript_CustomData tag
	xReqStreamWriter.writeEndElement();//end of executeFinacleScriptRequest tag
	xReqStreamWriter.writeEndElement();//end of body tag
	xReqStreamWriter.writeEndElement();// end of FIXML Tag
	
	xReqStreamWriter.writeEndDocument();
	xReqStreamWriter.flush();
	xReqStreamWriter.close();
	
	
	strInputXMLRequest = strReqWriter.getBuffer().toString();*/
	
	
	strInputXMLRequest="<?xml version=\"1.0\" encoding=\"UTF-8\"?><FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml RetCustInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
	"<Header><RequestHeader><MessageKey><RequestUUID>Req_"+strCbsID+"</RequestUUID><ServiceRequestId>"+RetCustAdd+"</ServiceRequestId>" +
	"<ServiceRequestVersion>"+strServiceRequestVersion+"</ServiceRequestVersion><ChannelId>"+strChannelId+"</ChannelId></MessageKey><RequestMessageInfo>" +
	"<BankId>01</BankId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo></RequestHeader>" +
	"</Header><Body><executeFinacleScriptRequest><ExecuteFinacleScriptInputVO><requestId>"+strRequestId+"</requestId>" +
	"</ExecuteFinacleScriptInputVO><executeFinacleScript_CustomData><InputVal>"+strCbsID+"</InputVal></executeFinacleScript_CustomData>" +
	"</executeFinacleScriptRequest></Body></FIXML>";
	
	log.info("################@@@@@@@@@@@@@ CBS BRE Service request @@@@@@@@@@@@@################"+ strInputXMLRequest);
	
	// System.out.println("################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
	URL url = new URL(ApplicationParams.getCbsIntegration());
	log.info("CbsBreService Url=========== "+url);
	HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
	urlcon.setRequestProperty("User-Agent", "");
	urlcon.setDoInput(true);
	urlcon.setDoOutput(true);
	urlcon.setRequestMethod("POST");
	urlcon.setRequestProperty("Content-Type","application/xml;charset=UTF-8");
	urlcon.setRequestProperty("Authorization", "Basic");
	OutputStream outputStream = urlcon.getOutputStream();
	OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
		
	BufferedWriter bWriter = new BufferedWriter(osw);
	bWriter.write(strInputXMLRequest);
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

		log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
						+ result.toString());
		
		// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
		// + result.toString());
	
		

			/*DocumentBuilderFactory factory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			
			InputSource inputSource = new InputSource(
					new StringReader(result.toString()));
			Document doc = builder.parse(inputSource);
			
			XPath xpath = XPathFactory.newInstance().newXPath();
					
			NodeList children = doc.getElementsByTagName("ResponseHeader");
			if (children.getLength() > 0) {
			
				strStatus=xpath.compile("HostTransaction/Status").evaluate(doc);*/
			

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
      

			if(strStatus.equalsIgnoreCase("Success"))
			{
				
			//	NodeList tagchildren = doc.getElementsByTagName("executeFinacleScriptResponse");
				strfdflg=(String)((Element)nodesList.item(0)).getElementsByTagName("FDFLG").item(0).getChildNodes().item(0).getNodeValue();
				strrdflg=(String)((Element)nodesList.item(0)).getElementsByTagName("RDFLG").item(0).getChildNodes().item(0).getNodeValue();
				straccopendate=(String)((Element)nodesList.item(0)).getElementsByTagName("actopndt").item(0).getChildNodes().item(0).getNodeValue();
				strbalance=(String)((Element)nodesList.item(0)).getElementsByTagName("BALANCE").item(0).getChildNodes().item(0).getNodeValue();
				strcredittxn=(String)((Element)nodesList.item(0)).getElementsByTagName("totcashtxn").item(0).getChildNodes().item(0).getNodeValue();
				strcashcredit=(String)((Element)nodesList.item(0)).getElementsByTagName("cashcredit").item(0).getChildNodes().item(0).getNodeValue();
				strcashdebit=(String)((Element)nodesList.item(0)).getElementsByTagName("cashdebit").item(0).getChildNodes().item(0).getNodeValue();
				strtotalcredit=(String)((Element)nodesList.item(0)).getElementsByTagName("totalcredit").item(0).getChildNodes().item(0).getNodeValue();
				strtotaldebit=(String)((Element)nodesList.item(0)).getElementsByTagName("totdebit").item(0).getChildNodes().item(0).getNodeValue();
				
				/*strfdflg=xpath.compile("executeFinacleScript_CustomData/FDFLG").evaluate(doc);
				strrdflg=xpath.compile("executeFinacleScript_CustomData/RDFLG").evaluate(doc);
				straccopendate=xpath.compile("executeFinacleScript_CustomData/actopndt").evaluate(doc);
				strbalance=xpath.compile("executeFinacleScript_CustomData/BALANCE").evaluate(doc);
				strcredittxn=xpath.compile("executeFinacleScript_CustomData/totcredittxn").evaluate(doc);
				strcashcredit=xpath.compile("executeFinacleScript_CustomData/cashcredit").evaluate(doc);
				strcashdebit=xpath.compile("executeFinacleScript_CustomData/cashdebit").evaluate(doc);
				strtotalcredit=xpath.compile("executeFinacleScript_CustomData/totalcredit").evaluate(doc);
				strtotaldebit=xpath.compile("executeFinacleScript_CustomData/totdebit").evaluate(doc);*/
			
				/* 
				 	strfdrdflag=xpath.compile("executeFinacleScript_CustomData/FDRDFLG").evaluate(doc);
					strbal=xpath.compile("executeFinacleScript_CustomData/BALANCE").evaluate(doc);
					strtotaltxn=xpath.compile("executeFinacleScript_CustomData/totcredittxn").evaluate(doc);
					strcashcredit=xpath.compile("executeFinacleScript_CustomData/cashcredit").evaluate(doc);
					strcashdebit=xpath.compile("executeFinacleScript_CustomData/cashcredit").evaluate(doc);
					strtotalcredit=xpath.compile("executeFinacleScript_CustomData/totalcredit").evaluate(doc);
					strtotaldebit=xpath.compile("executeFinacleScript_CustomData/totdebit").evaluate(doc);
					*/
				/*
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_digicbsbre");
				
				arrValues.add(strfdrdflg);
				arrValues.add(strbalance);
				arrValues.add(strcredittxn);
				arrValues.add(strcashcredit);
				arrValues.add(strcashdebit);
				arrValues.add(strtotalcredit);
				arrValues.add(strtotaldebit);

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
			
			
			
				}
			
	
			
			
				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				Date date=sdf.parse(straccopendate);
				strMessageDate=new SimpleDateFormat("yyyy-MM-dd").format(date);
			
			
			
			
				String[] strbalance_tag=strbalance.split("~");
				
				/*balancedata.add((strbalance_tag[0].split("~"))[1]);
				balancedata.add((strbalance_tag[1].split("~"))[2]);
				balancedata.add((strbalance_tag[2].split("~"))[2]);
				balancedata.add((strbalance_tag[3].split("~"))[2]);*/
				
				balancedata.add(strbalance_tag[1]);
				balancedata.add(strbalance_tag[3]);
				balancedata.add(strbalance_tag[5]);
				balancedata.add(strbalance_tag[7]);
				
				
				
				
				String [] totaltxn_tag=strtotaltxn.split(",");
				for(int i=0;i<=4;i++)
				{
					totaltxn.add((totaltxn_tag[i].split("~"))[1]);
				}
//				totaltxn.add((totaltxn_tag[1].split("~"))[2]);
//				totaltxn.add((totaltxn_tag[2].split("~"))[2]);
//				totaltxn.add((totaltxn_tag[3].split("~"))[2]);
				
				
				
				String[] cashstrdeposit_tag=strcashcredit.split(",");
				for(int i=1;i<cashstrdeposit_tag.length;i++)
				{
					cashdeposit.add((cashstrdeposit_tag[i].split("~"))[1]);
				}
				
				
				/*cashdeposit.add(cashstrdeposit_tag[4]);
				cashdeposit.add(cashstrdeposit_tag[10]);
				cashdeposit.add(cashstrdeposit_tag[16]);*/
				
			
			String[] cashwithdraw_tag=strcashdebit.split(",");
				for(int i=1;i<cashwithdraw_tag.length;i++)
				{
					cashwithdraw.add((cashwithdraw_tag[i].split("~"))[1]);
				}
				//CD,2019-Q4~31100,2019-Q3~0,2019-Q2~9000,2019-Q1~0
				/*cashwithdraw.add((cashwithdraw_tag[1].split("~"))[2]);
				cashwithdraw.add((cashwithdraw_tag[2].split("~"))[2]);
				cashwithdraw.add((cashwithdraw_tag[3].split("~"))[2]);*/
				
				String[] totalcredit_tag=strtotalcredit.split(",");
				for(int i=1;i<=4;i++)
				{
					totalcredit.add((totalcredit_tag[i].split("~"))[1]);
				}
				
				//TC,2019-Q4~467749.06,2019-Q3~390968.55,2019-Q2~389100.56,2019-Q1~511678.94
				/*totalcredit.add((totalcredit_tag[1].split("~"))[2]);
				totalcredit.add((totalcredit_tag[2].split("~"))[2]);
				totalcredit.add((totalcredit_tag[3].split("~"))[2]);
				totalcredit.add((totalcredit_tag[4].split("~"))[2]);*/
				
				
				String [] totaldebit_tag=strtotaldebit.split(",");
				
				for(int i=1;i<totaldebit_tag.length;i++)
				{
					totaldebit.add((totaldebit_tag[i].split("~"))[1]);
				}
				//TB,2019-Q4~452409.76,2019-Q3~376478.92,2019-Q2~325116.13,2019-Q1~667126.59
				
			/*	totaldebit.add((totaldebit_tag[1].split("~"))[3]);
				totaldebit.add((totaldebit_tag[2].split("~"))[3]);
				totaldebit.add((totaldebit_tag[3].split("~"))[3]);
				totaldebit.add((totaldebit_tag[4].split("~"))[3]);
				*/
				
				
				String strStringrequest="{\"DAJSONDocument\": {\"OCONTROL\": {\"ALIAS\": {\"data_type\": \"text\",\"value\": \"KBPL\"},\"SIGNATURE\": {\"data_type\": \"text\",\"value\": \"KBPL\"}},\"KBPLIN\": {\"APPLICATIONIN\": {\"SOURCINGDETAILS\": {\"BUSINESSDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PRODUCTCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"PORTFOLIO\": {\"data_type\": \"text\",\"value\": \"X\"},\"SUBPRODUCT\": {\"data_type\": \"text\",\"value\": \"X\"},\"SCHEME\": {\"data_type\": \"text\",\"value\": \"X\"},\"SUBSCHEME\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLIEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0}},\"LOANDETAILS\": {\"TENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"EMI\": {\"data_type\": \"numeric\",\"value\": 0},\"RATEOFINTEREST\": {\"data_type\": \"numeric\",\"value\": 0}},\"REFERENCEDETAILS\": {\"CONTACTNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"PINCODE\": {\"data_type\": \"numeric\",\"value\": 0},\"RELATIONSHIPWITHBORROWER\": {\"data_type\": \"text\",\"value\": \"X\"},\"REFERENCEDOCUMENTED\": {\"data_type\": \"text\",\"value\": \"X\"},\"CONTACTABLITY\": {\"data_type\": \"text\",\"value\": \"X\"},\"REFERENCEDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"REFERENCEDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"}},\"INCOMEASSESMENT\": {\"INCOMEASSESMENTAPPROACH\": {\"data_type\": \"text\",\"value\": \"X\"},\"INCOMEASSESMENTMETHOD\": {\"data_type\": \"text\",\"value\": \"X\"}},\"APPLICATIONINDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY5\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY6\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY7\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY8\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY9\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY10\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY11\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY12\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY13\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY14\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY16\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY17\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY18\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY19\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY20\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY21\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY22\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY23\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY24\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY25\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY26\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY27\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY28\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONINDUMMY29\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY30\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY31\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY32\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY33\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY34\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY35\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY36\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONINDUMMY37\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY38\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY39\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONINDUMMY40\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"LOANDETAIL\": {\"SANCTIONEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"GST\": {\"data_type\": \"numeric\",\"value\": 0},\"NETMONTHLYINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"PREAPPROVED\": {\"data_type\": \"text\",\"value\": \"1\"}}},\"APPLICANTIN\": {\"APPLICANTDETAILS\": {\"CCCID\": {\"data_type\": \"text\",\"value\": \"1558117435770\"},\"APPLICANTCATEGORY\": {\"data_type\": \"text\",\"value\": \"SALARIED\"},\"FINANCIALAPPLICANT\": {\"data_type\": \"text\",\"value\": \"Y\"},\"PRIMARYAPPLICANT\": {\"data_type\": \"text\",\"value\": \"X\"},\"CUSTOMERFNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"CUSTOMERMNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"CUSTOMERLNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOB\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"FATHERNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"MOTHERNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"SPOUSENAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"NATIONALITY\": {\"data_type\": \"text\",\"value\": \"X\"},\"RELATIONSHIP\": {\"data_type\": \"text\",\"value\": \"X\"},\"GENDER\": {\"data_type\": \"text\",\"value\": \"X\"},\"MARITALSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"NOOFDEPENDENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CONSTITUTION\": {\"data_type\": \"text\",\"value\": \"X\"},\"INDUSTRY\": {\"data_type\": \"text\",\"value\": \"X\"},\"CAUTIONPROFILE\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"SALACCOUNTINKBL\": {\"data_type\": \"text\",\"value\": \"X\"},\"ETB\": {\"data_type\": \"text\",\"value\": \"X\"},\"IDV\": {\"INCIDENTNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"DATEOFOCCURRENCE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATEOFDETECTION\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"REPORTEDBY\": {\"data_type\": \"text\",\"value\": \"X\"},\"PRODUCTTYPE\": {\"data_type\": \"numeric\",\"value\": 0},\"COMPLAINTTOLAWENFORCEMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"ACCOUNTNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"DATEOFCOMPLAINTFILED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"INCIDENTSTATUS\": {\"data_type\": \"numeric\",\"value\": 0},\"RELATIONSHIPTOINSTITUTION\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTINVOLVED\": {\"data_type\": \"numeric\",\"value\": 0},\"INCIDENTDESCRIPTION\": {\"data_type\": \"numeric\",\"value\": 0},\"RELATIONSHIPTOINCIDENT\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTRECOVERED\": {\"data_type\": \"numeric\",\"value\": 0},\"COMPLAINTORFIRNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"NAMEOFCBIOFFICEPOLICEOFFICEBRANCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"PAN\": {\"data_type\": \"numeric\",\"value\": 0},\"VOTERID\": {\"data_type\": \"numeric\",\"value\": 0},\"PASSPORT\": {\"data_type\": \"numeric\",\"value\": 0},\"DRIVINGLICENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"RATIONCARD\": {\"data_type\": \"numeric\",\"value\": 0},\"UIDNUMBER\": {\"data_type\": \"numeric\",\"value\": 0},\"DATEOFBIRTH\": {\"data_type\": \"numeric\",\"value\": 0},\"GENDER\": {\"data_type\": \"numeric\",\"value\": 0},\"MOBILENUMBER\": {\"data_type\": \"numeric\",\"value\": 0},\"RESIDENCEPHONENUMBER\": {\"data_type\": \"numeric\",\"value\": 0},\"DETECTMATCHRESULT\": {\"data_type\": \"text\",\"value\": \"X\"},\"MISMATCHALERTS\": {\"data_type\": \"text\",\"value\": \"X\"},\"INVALIDIDALERT\": {\"data_type\": \"text\",\"value\": \"X\"},\"MULTIPLEIDALERT\": {\"data_type\": \"text\",\"value\": \"X\"},\"DETECTALERT\": {\"data_type\": \"text\",\"value\": \"X\"},\"WILFULDEFAULTERMATCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"SUITFILEDMATCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"WILFULDEFAULTERSUITFILEDMATCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"ENQUIRYCONVERSIONRATE\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSMATCH\": {\"data_type\": \"numeric\",\"value\": 0}},\"KBACCOPENDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"SALARIEDSINCE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"CALLSEGMENTATION\": {\"data_type\": \"numeric\",\"value\": 9},\"KBSTAFF\": {\"data_type\": \"text\",\"value\": \"X\"},\"THICKSCORE\": {\"data_type\": \"numeric\",\"value\": \"X\"},\"THINSCORE\": {\"data_type\": \"numeric\",\"value\": \"X\"},\"DEBITSCORE\": {\"data_type\": \"numeric\",\"value\": \"X\"}},\"ADDRESSDETAILS\": {\"value\": [{\"ADDRESSCAT\": {\"data_type\": \"text\",\"value\": 0},\"MICROLOCATION\": {\"data_type\": \"text\",\"value\": \"X\"},\"STATE\": {\"data_type\": \"text\",\"value\": \"X\"},\"CITY\": {\"data_type\": \"text\",\"value\": \"X\"},\"PINCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"RESIDENCETYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"STABILITYYEARS\": {\"data_type\": \"numeric\",\"value\": 0},\"STABILITYMONTHS\": {\"data_type\": \"numeric\",\"value\": 0},\"OWNERSHIPPROOF\": {\"data_type\": \"text\",\"value\": \"X\"},\"PERMANENTADDRESSPROOF\": {\"data_type\": \"text\",\"value\": \"X\"},\"RENTAGREEMENTPROOF\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"}}]},\"KYCDETAIL\": {\"OFFICEMOBILE\": {\"data_type\": \"text\",\"value\": \"X\"},\"OFFICELANDLINE\": {\"data_type\": \"text\",\"value\": \"X\"},\"RESIDENCEMOBILE\": {\"data_type\": \"text\",\"value\": \"X\"},\"RESIDENCELANDLINE\": {\"data_type\": \"text\",\"value\": \"X\"},\"PANNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"AADHAARNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"DRIVINGLICENSE\": {\"data_type\": \"text\",\"value\": \"X\"},\"VOTERIDCARD\": {\"data_type\": \"text\",\"value\": \"X\"},\"PASSPORTNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"RATIONCARD\": {\"data_type\": \"text\",\"value\": \"X\"},\"UTILITYBILL60DAYS\": {\"data_type\": \"text\",\"value\": \"X\"},\"KYCDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"KYCDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"KYCDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"KYCDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"}},\"DOCUMENT\": {\"DOCUMENTNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"ISDOCUMENTDIGITALLYUPLOADED\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOCUMENTSVERIFICATION\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOCUMENTSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"VATGST\": {\"data_type\": \"text\",\"value\": \"X\"},\"BANKACCOUNTL6M\": {\"data_type\": \"text\",\"value\": \"X\"},\"PREVIOUSEMPLOYERSALARYSLIP\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPOINTMENTLETTER\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOCUMENTDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOCUMENTDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"DOCUMENTDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"DOCUMENTDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0}},\"EMPLOYMENTDETAILS\": {\"EMPLOYMENTTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"EMPLOYER\": {\"data_type\": \"text\",\"value\": \"X\"},\"DATEOFESTABLISHMNT\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"EMPLOYEDFROM\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"WORKEXPINYEARSCUR\": {\"data_type\": \"numeric\",\"value\": 0},\"WORKEXPINMONTHCUR\": {\"data_type\": \"numeric\",\"value\": 0},\"OVERALLWORKEXPINYEARS\": {\"data_type\": \"numeric\",\"value\": 0},\"OVERALLWORKEXPINMONTHS\": {\"data_type\": \"numeric\",\"value\": 0},\"EMPLOYERCATEGORY\": {\"data_type\": \"text\",\"value\": \"X\"},\"NEWSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"EMPLOYMENTDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"EMPLOYMENTDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"EMPLOYMENTDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"EMPLOYMENTDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0}},\"BANKING\": {\"BANKACCOUNTNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"TOBECONSDEREDINCOMEELIGIBILITY\": {\"data_type\": \"text\",\"value\": \"X\"},\"TOBECONSIDERREPAYMENT\": {\"data_type\": \"text\",\"value\": \"X\"},\"FREQUENCY\": {\"data_type\": \"text\",\"value\": \"X\"},\"BRANCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"AVERAGEBANKBALANCEL3M\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBANKBALANCEL6M\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBANKBALANCEL12M\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEMONTHLYCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"COOPERATIVEBANK\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTTYPESBCACCOD\": {\"data_type\": \"text\",\"value\": \"X\"},\"INFLOWS\": {\"data_type\": \"numeric\",\"value\": 0},\"BANKNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"NODEBITS\": {\"data_type\": \"numeric\",\"value\": 0},\"NOCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"INWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"OUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NOOFTRANSACTIONSL12M\": {\"data_type\": \"numeric\",\"value\": 0},\"BANKDUMMY1\": {\"data_type\": \"numeric\",\"value\": 0},\"BANKDUMMY2\": {\"data_type\": \"numeric\",\"value\": 0},\"BANKDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"BANKDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"}},\"INCOME\": {\"RENTALINCOMECURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"RENTALINCOMEPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"FREQUENCY\": {\"data_type\": \"text\",\"value\": \"X\"},\"CASHPROFITCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHPROFITPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"ITRINCOMECURRENTYR\": {\"data_type\": \"numeric\",\"value\": 0},\"ITRINCOMEPREVIOUSTYR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTINCOMEFDCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTINCOMEFDPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSRECIEPTPREVIOUSYR\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSRECEIPTCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INDUSTRYMARGIN\": {\"data_type\": \"numeric\",\"value\": 0},\"ANNUALINTERESTSERVICECURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"ANNUALINTERESTSERVICEPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSPROFITCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSPROFITPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSTURNOVERYEAR1\": {\"data_type\": \"numeric\",\"value\": 0},\"GROSSTURNOVERYEAR2\": {\"data_type\": \"numeric\",\"value\": 0},\"PATCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"PATPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"PBTCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"PBTPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"DEPRECIATIONCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"DEPRECIATIONPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTSALARYPARTNERDIRECTORCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTSALARYPARTNERDIRECTORPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTPAIDCURRENTYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTPAIDPREVIOUSYEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"MONTHLYTURNOVER\": {\"data_type\": \"numeric\",\"value\": [0]},\"TURNOVERGST\": {\"data_type\": \"numeric\",\"value\": [0]},\"OTHERINCOMEYR1\": {\"data_type\": \"numeric\",\"value\": 0},\"OTHERINCOMEYR2\": {\"data_type\": \"numeric\",\"value\": 0},\"CONSULTINGINCOME\": {\"data_type\": \"numeric\",\"value\": [0]},\"ITRYR1DATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"ITRYR2DATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"ESTIMATEDORDECLAREDINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"NETSALARYMONTHLY\": {\"data_type\": \"numeric\",\"value\": [0]},\"VARIABLEPAY\": {\"data_type\": \"numeric\",\"value\": [0]},\"LTA\": {\"data_type\": \"numeric\",\"value\": [0]},\"PERFORMANCEBONUS\": {\"data_type\": \"numeric\",\"value\": [0]},\"FIXEDBONUS\": {\"data_type\": \"numeric\",\"value\": [0]},\"FINANCIALDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"FINANCIALDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"FINANCIALDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"FINANCIALDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0}},\"DEDUPE\": {\"DEDUPEMATCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEDUPEDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DEDUPECUSTOMERID\": {\"data_type\": \"text\",\"value\": \"X\"},\"SANCTIONDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"LOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"LOANSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"TENUREDEDUPE\": {\"data_type\": \"numeric\",\"value\": 0},\"DEDUPEEMI\": {\"data_type\": \"numeric\",\"value\": 0},\"EMIOUTSTANDING\": {\"data_type\": \"numeric\",\"value\": 0},\"NOEMIOUTSTANDING\": {\"data_type\": \"numeric\",\"value\": 0},\"DPDDEDUPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"CHEQUEBOUNCECOUNTL6M\": {\"data_type\": \"numeric\",\"value\": 0},\"DEDUPEAMOUNTOVERDUE\": {\"data_type\": \"numeric\",\"value\": 0},\"DEDUPEBANKACCOUNTNO\": {\"data_type\": \"text\",\"value\": \"X\"},\"INSTALLMENTPAIDBY\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEDUPEDUMMY1\": {\"data_type\": \"numeric\",\"value\": 0},\"DEDUPEDUMMY2\": {\"data_type\": \"numeric\",\"value\": 0},\"DEDUPEDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEDUPEDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"}},\"CIBILOUT\": {\"SCOREDETAIL\": {\"SCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"SCOREDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"SCORECARDNAME\": {\"data_type\": \"text\",\"value\": \"X\"}},\"ENQUIRYDETAIL\": {\"value\": [{\"DATEOFENQUIRY\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"ENQUIRYPURPOSE\": {\"data_type\": \"text\",\"value\": \"X\"},\"ENQIURYAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ENQUIRINGMEMBERSHORTNAME\": {\"data_type\": \"text\",\"value\": \"X\"}}]},\"ADDRESSDETAIL\": {\"value\": [{\"PINCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSCATEGORY\": {\"data_type\": \"numeric\",\"value\": 0},\"ADDRESSLINE1\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSLINE2\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSLINE3\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSLINE4\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESSLINE5\": {\"data_type\": \"text\",\"value\": \"X\"},\"STATECODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"RESIDENCECODE\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"TRADELINEDETAIL\": {\"value\": [{\"ACCOUNTNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"OWNERSHIPINDICATOR\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DATEOPENEDORDISBURSED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"CREDITLIMIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHLIMIT\": {\"data_type\": \"numeric\",\"value\": 0},\"HIGHCREDITORSANCTIONEDAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"PAYMENTHISTORY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"LASTREPORTEDDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PAYMENTHISTORYSTARTDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PAYMENTHISTORYENDDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"CURRENTBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOVERDUE\": {\"data_type\": \"numeric\",\"value\": 0},\"DATEREPORTEDANDCERTIFIED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATECLOSED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATEOFLASTPAYMENT\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"SUITFILEDORWILFULDEFAULT\": {\"data_type\": \"text\",\"value\": \"X\"},\"WRITTENOFFANDSETTLEDSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"SETTLEMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"VALUEOFCOLLATERAL\": {\"data_type\": \"numeric\",\"value\": 0},\"TYPEOFCOLLATERAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"WRITTENOFFAMOUNTTOTAL\": {\"data_type\": \"numeric\",\"value\": 0},\"WRITTENOFFAMOUNTPRINCIPAL\": {\"data_type\": \"numeric\",\"value\": 0},\"RATEOFINTEREST\": {\"data_type\": \"numeric\",\"value\": 0},\"REPAYMENTTENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"PAYMENTFREQUENCY\": {\"data_type\": \"text\",\"value\": \"X\"},\"EMIAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ACTUALPAYMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"EMPLOYMENTDETAIL\": {\"value\": [{\"INCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"OCCUPATIONCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"NETGROSSINCOMEINDICATOR\": {\"data_type\": \"text\",\"value\": \"X\"},\"MONTHLYANNUALINCOMEINDICATOR\": {\"data_type\": \"text\",\"value\": \"X\"}}]},\"CIBILSPFIELD1\": {\"data_type\": \"text\",\"value\": \"X\"},\"CIBILSPFIELD2\": {\"data_type\": \"text\",\"value\": \"X\"},\"CIBILSPFIELD3\": {\"data_type\": \"text\",\"value\": \"X\"},\"CIBILSPFIELD4\": {\"data_type\": \"text\",\"value\": \"X\"},\"CIBILSPFIELD5\": {\"data_type\": \"text\",\"value\": \"X\"},\"CIBILSPFIELD6\": {\"data_type\": \"numeric\",\"value\": 0},\"CIBILSPFIELD7\": {\"data_type\": \"numeric\",\"value\": 0},\"CIBILSPFIELD8\": {\"data_type\": \"numeric\",\"value\": 0},\"CIBILSPFIELD9\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"CIBILSPFIELD10\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"}},\"LOANOBLIGATION\": {\"value\": [{\"REFINANCED\": {\"data_type\": \"text\",\"value\": \"X\"},\"TOBECONSIDEREDELIGIBILITY\": {\"data_type\": \"text\",\"value\": \"X\"},\"TENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"BOUNCEL12M\": {\"data_type\": \"numeric\",\"value\": 0},\"ACCOUNTTYPE\": {\"data_type\": \"numeric\",\"value\": 0},\"MOB\": {\"data_type\": \"numeric\",\"value\": 0},\"LOANTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"OUTSTANDINGAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"BOUNCEL6M\": {\"data_type\": \"numeric\",\"value\": 0},\"EMI\": {\"data_type\": \"numeric\",\"value\": 0},\"DPD\": {\"data_type\": \"text\",\"value\": \"X\"},\"NOOFINSTALLMENTPAID\": {\"data_type\": \"numeric\",\"value\": 0},\"OVERDUE\": {\"data_type\": \"numeric\",\"value\": 0},\"EMIBOUNCEL6M\": {\"data_type\": \"numeric\",\"value\": 0},\"PREVIOUSLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"PREVIOUSLOANEMI\": {\"data_type\": \"numeric\",\"value\": 0},\"TENURESTARTDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"TENUREENDDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PRINCIPALOUTSTANDING\": {\"data_type\": \"numeric\",\"value\": 0},\"LOANOBLIGATIONDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"LOANOBLIGATIONDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"LOANOBLIGATIONDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"LOANOBLIGATIONDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"EDUCATIONDETAIL\": {\"QUALIFICATION\": {\"data_type\": \"text\",\"value\": \"X\"},\"COLLEGE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEGREE\": {\"data_type\": \"text\",\"value\": \"X\"},\"FULLTIME\": {\"data_type\": \"text\",\"value\": \"X\"},\"IMADEGREE\": {\"data_type\": \"text\",\"value\": \"X\"},\"EDUCATIONDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"EDUCATIONDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"EDUCATIONDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"EDUCATIONDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0}},\"PERFIOS\": {\"value\": [{\"NAMEOFTHEACCOUNTHOLDER\": {\"data_type\": \"text\",\"value\": \"X\"},\"ADDRESS\": {\"data_type\": \"text\",\"value\": \"X\"},\"EMAIL\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTTYPE\": {\"data_type\": \"text\",\"value\": \"X\"},\"NAMEOFTHEBANK\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTNUMBER\": {\"data_type\": \"numeric\",\"value\": 0},\"MONTH\": {\"value\": [{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 34054.47},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}},{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 34044.47},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}},{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 32865.88},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}},{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 36475.84},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}},{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 35790.84},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}},{\"OPENINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 7402.19},\"CLOSINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON5TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON15TH\": {\"data_type\": \"numeric\",\"value\": 0},\"BALANCEASON25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCEOF5TH15THAND25TH\": {\"data_type\": \"numeric\",\"value\": 0},\"AVERAGEBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"FUNDTRANSFER\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INVESTMENTEXPENSE\": {\"data_type\": \"numeric\",\"value\": 0},\"PERCENTAGEOFINWARDBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SALARY\": {\"data_type\": \"numeric\",\"value\": 36040.84},\"ESTIMATEDSALARY\": {\"data_type\": \"numeric\",\"value\": 0},\"REIMBURSEMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALLOANCREDITSCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTCHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"UTILITYPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALAMOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFOUTWARDCHEQUERETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFECSBOUNCES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFEMILOANPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"STOPPAYMENT\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALNOOFINWARDRETURNS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFINTERESTCREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALAMOUNTOFCREDITCARDPAYMENTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHWITHDRAWALCOUNTDEBIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSITCOUNTCREDIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CHEQUEDEPOSITCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"IMMEDIATEBIGDEBITAFTERSALCREDIT\": {\"data_type\": \"text\",\"value\": \"X\"},\"RECURRINGDEBITS\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"PAN\": {\"data_type\": \"text\",\"value\": \"X\"},\"MOBILENUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"SALARYIDENTIFIED\": {\"data_type\": \"text\",\"value\": \"X\"},\"FORM26ASEXTRACTED\": {\"data_type\": \"text\",\"value\": \"X\"},\"NOOFTDSENTRIES\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALTDSAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"NOOFOCCURANCES\": {\"data_type\": \"numeric\",\"value\": 0},\"SECTION192\": {\"data_type\": \"text\",\"value\": \"X\"},\"LASTASSESSMENTYEAR\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEDUCTORNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"TAN\": {\"data_type\": \"text\",\"value\": \"X\"},\"TOTALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"HIGHVALUECREDITS\": {\"data_type\": \"numeric\",\"value\": 0},\"HIGHVALUEDEBITS\": {\"data_type\": \"numeric\",\"value\": [0]},\"RECURRINGCREDITS\": {\"data_type\": \"numeric\",\"value\": [0]},\"ECSEMIDEBITS\": {\"data_type\": \"numeric\",\"value\": [0]}}]},\"EXISTINGBORROWER\": {\"PREVIOUSLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"PREVIOUSLOANPROGRAM\": {\"data_type\": \"text\",\"value\": \"X\"},\"PREVIOUSLOANEMI\": {\"data_type\": \"numeric\",\"value\": 0},\"TENURESTARTDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"TENUREENDDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PRINCIPALOUTSTANDING\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFINSTALLMENTPAID\": {\"data_type\": \"numeric\",\"value\": 0}},\"EXPERIAN\": {\"SCOREDETAILS\": {\"SCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"SCOREDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"}},\"ACCOUNTSUMMARY\": {\"value\": [{\"NOOFACCOUNTS\": {\"data_type\": \"numeric\",\"value\": 0},\"NOOFACTIVEACCOUNTS\": {\"data_type\": \"numeric\",\"value\": 0},\"NOOFDEFAULTACCOUNTS\": {\"data_type\": \"numeric\",\"value\": 0},\"CADSUITFILEDCURRENTBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"OUTSTANDINGBALANCESECURED\": {\"data_type\": \"numeric\",\"value\": 0},\"OUTSTANDINGBALANCEUNSECURED\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALOUTSTANDINGBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"OUTSTANDINGBALANCESECUREDPERCENTAGE\": {\"data_type\": \"numeric\",\"value\": 0},\"OUTSTANDINGBALANCEUNSECUREDPERCENTAGE\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"ACCOUNTDETAILS\": {\"value\": [{\"SUBSCRIBERNAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTTYPE\": {\"data_type\": \"text\",\"value\": \"1\"},\"DATEOPENED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"HIGHCREDITSANCTIONEDAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"TERMSDURATION\": {\"data_type\": \"numeric\",\"value\": 0},\"TERMFREQUENCY\": {\"data_type\": \"text\",\"value\": \"X\"},\"SCHEDULEDMONTHLYPAYMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ACCOUNTSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"CURRENTBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"PASTDUEAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ORIGINALCHARGEOFFAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"DATEREPORTED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATEOFFIRSTDELIQUENCY\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATECLOSED\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DATEOFLASTPAYMENT\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"DEFAULTSTATUSDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"LITIGATIONSTATUSDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"WRITEOFFSTATUSDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"SUITFILEDWILLFULDEFAULTWRITTENOFFSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"SUITFILEDWILFULDEFAULT\": {\"data_type\": \"text\",\"value\": \"X\"},\"WRITTENOFFSETTLEDSTATUS\": {\"data_type\": \"text\",\"value\": \"X\"},\"VALUEOFCREDITSLASTMONTH\": {\"data_type\": \"numeric\",\"value\": 0},\"OCCUPATIONCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"SETTLEMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"VALUEOFCOLLATERAL\": {\"data_type\": \"numeric\",\"value\": 0},\"TYPEOFCOLLATERAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"WRITTENOFFAMTTOTAL\": {\"data_type\": \"numeric\",\"value\": 0},\"WRITTENOFFAMTPRINCIPAL\": {\"data_type\": \"numeric\",\"value\": 0},\"RATEOFINTEREST\": {\"data_type\": \"numeric\",\"value\": 0},\"REPAYMENTTENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"INCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"INCOMEINDICATOR\": {\"data_type\": \"text\",\"value\": \"X\"},\"ACCOUNTHOLDERTYPECODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"PAYMENTHISTORY48MONTHS\": {\"value\": [{\"YEAR\": {\"data_type\": \"numeric\",\"value\": 0},\"MONTH\": {\"data_type\": \"numeric\",\"value\": 0},\"DAYSPASTDUE\": {\"data_type\": \"numeric\",\"value\": 0},\"ASSETCLASSIFICATION\": {\"data_type\": \"numeric\",\"value\": 0},\"HIGHCREDITSANCTIONEDAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHLIMIT\": {\"data_type\": \"numeric\",\"value\": 0},\"CREDITLIMITAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ACTUALPAYMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"EMIAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CURRENTBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTPASTDUE\": {\"data_type\": \"numeric\",\"value\": 0}}]}}]},\"ENQUIRYSUMMARY\": {\"value\": [{\"TOTALENQUIRIESLAST7DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALENQUIRIESLAST30DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALENQUIRIESLAST90DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"TOTALENQUIRIESLAST180DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"CAPSLAST7DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"CAPSLAST30DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"CAPSLAST90DAYS\": {\"data_type\": \"numeric\",\"value\": 0},\"CAPSLAST180DAYS\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"ENQUIRYDETAILS\": {\"value\": [{\"DATEOFREQUEST\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"REPORTNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"ENQUIRYREASON\": {\"data_type\": \"text\",\"value\": \"X\"},\"FINANCEPURPOSE\": {\"data_type\": \"text\",\"value\": \"X\"},\"AMOUNTFINANCED\": {\"data_type\": \"numeric\",\"value\": 0},\"DURATIONOFAGREEMENT\": {\"data_type\": \"numeric\",\"value\": 0}}]}},\"FIWAIVER\": {\"KARZAOUTPUT\": {\"data_type\": \"text\",\"value\": \"X\"},\"BIRDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"PERFIOSOUTPUT\": {\"data_type\": \"text\",\"value\": \"X\"}},\"DEBITSCOREINPUT\": {\"JOINTACCOUNTFLAG\": {\"data_type\": \"text\",\"value\": \"X\"},\"JOINTACCOUNTRELATIONSHIP\": {\"data_type\": \"text\",\"value\": \"X\"},\"NOMINEEACCOUNTFLAG\": {\"data_type\": \"text\",\"value\": \"X\"},\"DATEOFSAVINGSACCOUNTOPENING\": {\"data_type\": \"date\",\"value\": \""+strMessageDate+"\",\"date_format\": \"yyyy-MM-dd\"},\"OCCUPATION_SALARIED\": {\"data_type\": \"text\",\"value\": \"X\"},\"INCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"QUARTER\": {\"value\": [{\"AVERAGEBANKBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totaldebit.get(3)+"},\"NUMBEROFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totalcredit.get(3)+"},\"MINDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MINCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSIT\": {\"data_type\": \"numeric\",\"value\": "+cashdeposit.get(3)+"},\"CASHWITHDRAWAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"NETBANKINGAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"NETBANKINGCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"FD\": {\"data_type\": \"text\",\"value\": \"Y\"},\"RD\": {\"data_type\": \"text\",\"value\": \"N\"}},{\"AVERAGEBANKBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totaldebit.get(2)+"},\"NUMBEROFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totalcredit.get(2)+"},\"MINDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MINCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSIT\": {\"data_type\": \"numeric\",\"value\": "+cashdeposit.get(2)+"},\"CASHWITHDRAWAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"NETBANKINGAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"NETBANKINGCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"FD\": {\"data_type\": \"text\",\"value\": \"Y\"},\"RD\": {\"data_type\": \"text\",\"value\": \"N\"}},{\"AVERAGEBANKBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totaldebit.get(1)+"},\"NUMBEROFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totalcredit.get(1)+"},\"MINDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MINCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSIT\": {\"data_type\": \"numeric\",\"value\": "+cashdeposit.get(1)+"},\"CASHWITHDRAWAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"NETBANKINGAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"NETBANKINGCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"FD\": {\"data_type\": \"text\",\"value\": \"Y\"},\"RD\": {\"data_type\": \"text\",\"value\": \"N\"}},{\"AVERAGEBANKBALANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFINWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFOUTWARDCHEQUEBOUNCE\": {\"data_type\": \"numeric\",\"value\": 0},\"NUMBEROFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFDEBITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totaldebit.get(0)+"},\"NUMBEROFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": 0},\"AMOUNTOFCREDITTRANSACTIONS\": {\"data_type\": \"numeric\",\"value\": "+totalcredit.get(0)+"},\"MINDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXDEBITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MINCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXCREDITTRANSACTIONAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ATMWITHDRAWALCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"CASHDEPOSIT\": {\"data_type\": \"numeric\",\"value\": "+cashdeposit.get(0)+"},\"CASHWITHDRAWAL\": {\"data_type\": \"text\",\"value\": \"X\"},\"NETBANKINGAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"NETBANKINGCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"FD\": {\"data_type\": \"text\",\"value\": \"Y\"},\"RD\": {\"data_type\": \"text\",\"value\": \"N\"}}]},\"MONTHLY\": {\"value\": [{\"EODBALANCEASON1ST\": {\"data_type\": \"numeric\",\"value\": "+balancedata.get(0)+"},\"EODBALANCEASON10TH\": {\"data_type\": \"numeric\",\"value\": "+balancedata.get(1)+"},\"EODBALANCEASON20TH\": {\"data_type\": \"numeric\",\"value\": "+balancedata.get(2)+"},\"EODBALANCEASON30TH\": {\"data_type\": \"numeric\",\"value\": "+balancedata.get(3)+"}}]}},\"HUNTER\": {\"TOTALMATCHSCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"SCORE\": {\"value\": [{\"data_type\": \"text\",\"value\": \"X\"}]},\"SCHEMEID\": {\"data_type\": \"numeric\",\"value\": 0},\"WARNINGVALUE\": {\"value\": [{\"data_type\": \"text\",\"value\": \"X\"}]},\"ERRORCOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"MATCHSCHEMECOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"RULEID\": {\"value\": [{\"data_type\": \"text\",\"value\": \"X\"}]},\"WARNINGNUMBER\": {\"data_type\": \"text\",\"value\": \"X\"},\"WARNINGMESSAGE\": {\"data_type\": \"text\",\"value\": \"X\"},\"MATCH\": {\"data_type\": \"text\",\"value\": \"X\"},\"TOTALRULECOUNT\": {\"data_type\": \"text\",\"value\": \"X\"}},\"APPLICANTINDUMMYFIELD1\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD2\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD3\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD4\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD5\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD6\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD7\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD8\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD9\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD10\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD11\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD12\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD13\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD14\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD16\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD17\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD18\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD19\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD20\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD21\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD22\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD23\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD24\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD25\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD26\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD27\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD28\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTINDUMMYFIELD29\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD30\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD31\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD32\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD33\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD34\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD35\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD36\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTINDUMMYFIELD37\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD38\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD39\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTINDUMMYFIELD40\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"}}},\"KBPLOUT\": {\"APPLICATIONOUT\": {\"APPLIEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"EMI\": {\"data_type\": \"numeric\",\"value\": 0},\"TENUREAPPLIED\": {\"data_type\": \"numeric\",\"value\": 0},\"METRONONMETRO\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISION\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONREASONCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONCATEGORY\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONCOMPONENTTREENAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONSETTERNAME\": {\"data_type\": \"text\",\"value\": []},\"SORTEDREASONCODETABLE\": {\"data_type\": \"text\",\"value\": []},\"SORTEDDECISIONTABLE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEVIATIONLEVEL\": {\"data_type\": \"text\",\"value\": []},\"DEVIATIONLEVELTABLE\": {\"data_type\": \"text\",\"value\": []},\"DEVIATIONCODE\": {\"data_type\": \"numeric\",\"value\": 0},\"DSCRIMPUTEDINCOME\": {\"data_type\": \"text\",\"value\": \"X\"},\"DSCRELIGIBLEINCOME\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPSCORE\": {\"data_type\": \"text\",\"value\": []},\"APPSCOREBAND\": {\"data_type\": \"text\",\"value\": []},\"APPSCORECARDELEMENT\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPSCORINGRESULTTABLE\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTY\": {\"INCOMEMETHOD\": {\"data_type\": \"text\",\"value\": \"X\"},\"ELIGIBLEINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILELOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"LOANAMOUNTCALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"FOIRCALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXFOIR\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBLEFOIR\": {\"data_type\": \"numeric\",\"value\": 0},\"EMICALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY1\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY2\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0},\"TENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTRATE\": {\"data_type\": \"numeric\",\"value\": 0}},\"APPLICATIONOUTDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY5\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY6\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY7\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY8\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY9\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY10\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY11\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY12\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY13\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY14\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY16\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY17\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY18\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY19\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY20\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY21\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY22\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY23\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY24\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY25\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY26\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY27\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY28\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICATIONOUTDUMMY29\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY30\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY31\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY32\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY33\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY34\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY35\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY36\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTDUMMY37\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY38\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY39\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICATIONOUTDUMMY40\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"CHARGES\": {\"PROCESSINGFEE\": {\"data_type\": \"numeric\",\"value\": 0},\"PRECLOSURECHARGES\": {\"data_type\": \"numeric\",\"value\": 0},\"PRECLOSUREWAIVER\": {\"data_type\": \"text\",\"value\": \"X\"},\"CHEQUEBOUNCEPERINSTANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"EMIBOUNCEPERINSTANCE\": {\"data_type\": \"numeric\",\"value\": 0},\"PENALINTERESTPERMONTHPERCENT\": {\"data_type\": \"numeric\",\"value\": 0},\"PRECLOSURECHARGES12M\": {\"data_type\": \"numeric\",\"value\": 0},\"PRECLOSURECHARGES60M\": {\"data_type\": \"numeric\",\"value\": 0}}},\"APPLICANTOUT\": {\"CCCID\": {\"data_type\": \"text\",\"value\": \"X\"},\"PROFILE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISION\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONREASONCODE\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONCATEGORY\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONCOMPONENTTREENAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"DECISIONSETTERNAME\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"SORTEDREASONCODETABLE\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"SORTEDDECISIONTABLE\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"DEVIATIONLEVEL\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"DEVIATIONLEVELTABLE\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"DEVIATIONCODE\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY1\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY2\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY3\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY4\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY5\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY6\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY7\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY8\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY9\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY10\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY11\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY12\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY13\": {\"data_type\": \"text\",\"value\": \"X\"},\"APPLICANTOUTDUMMY14\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY16\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY17\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY18\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY19\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY20\": {\"data_type\": \"date\",\"value\": \"1900-01-01\",\"date_format\": \"yyyy-MM-dd\"},\"APPLICANTOUTDUMMY21\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY22\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY23\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY24\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY25\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY26\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY27\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY28\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY29\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY30\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY31\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY32\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY33\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"APPLICANTOUTDUMMY34\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY35\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY36\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY37\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY38\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY39\": {\"data_type\": \"numeric\",\"value\": [0]},\"APPLICANTOUTDUMMY40\": {\"data_type\": \"date\",\"value\": [\"1900-01-01\"],\"date_format\": \"yyyy-MM-dd\"},\"SCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"SCORENAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"SCORINGRESULTTABLE\": {\"data_type\": \"text\",\"value\": [\"X\"]},\"FIADDRESSWAIVER\": {\"data_type\": \"text\",\"value\": \"X\"},\"FIEMPLOYMENTWAIVER\": {\"data_type\": \"text\",\"value\": \"X\"},\"DEBITSCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"THINSCORE\": {\"data_type\": \"numeric\",\"value\": 0},\"THINSCORENAME\": {\"data_type\": \"text\",\"value\": \"X\"},\"THINSCORINGRESULTTABLE\": {\"data_type\": \"text\",\"value\": \"X\"}}}}}";		
				
					
					//JSONObject request= new JSONObject();		
					//request.put("DAJSONDocument",kbpl);
				//	request.toString();
					System.out.print(strStringrequest);

			
				
			
				URL bre_url = new URL(ApplicationParams.getStrbreurl());
				log.info("CbsBreService Url=========== "+bre_url);
				HttpURLConnection bre_urlcon = (HttpURLConnection) bre_url.openConnection();
				bre_urlcon.setRequestProperty("User-Agent", "");
				bre_urlcon.setDoInput(true);
				bre_urlcon.setDoOutput(true);
				bre_urlcon.setRequestMethod("POST");
				bre_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
				bre_urlcon.setRequestProperty("Authorization", "Basic");
				OutputStream bre_outputStream = bre_urlcon.getOutputStream();
				OutputStreamWriter bre_osw = new OutputStreamWriter(bre_outputStream, "UTF8");
					
				BufferedWriter bre_bWriter = new BufferedWriter(bre_osw);
				bre_bWriter.write(strStringrequest);
				bre_bWriter.close();

				InputStream bre_inputStream = bre_urlcon.getInputStream();
				InputStreamReader bre_isreader = new InputStreamReader(bre_inputStream,"UTF-8");
				
				
				
				BufferedReader bre_rd = new BufferedReader(bre_isreader);

				if (bre_rd != null) {
					StringBuffer bre_result = new StringBuffer();
					while ((line = bre_rd.readLine()) != null) {
						bre_result.append(line);
					}
					log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
									+ bre_result.toString());
					// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
					// + result.toString());

					

					
					String bre_responseCbs = bre_result.toString();
					bre_responseCbs=bre_responseCbs.replace("^([\\W]+)<","<");
					bre_responseCbs=bre_responseCbs.replace("utf-16","utf-8");
			                
			       int bre_nodesize=0;
			       DocumentBuilderFactory bre_factory = DocumentBuilderFactory.newInstance();    
			       DocumentBuilder bre_docBuilder = bre_factory.newDocumentBuilder();                
			       Document bre_doc = bre_docBuilder.parse(new ByteArrayInputStream(bre_responseCbs.getBytes()));
			       bre_doc.getDocumentElement().normalize();
			     
			       NodeList bre_nodesList = bre_doc.getElementsByTagName("DAJSONDocument/KBPLOUT/APPLICANTOUT");
			     
			       strdebitscore=(String)((Element)bre_nodesList.item(0)).getElementsByTagName("DEBITSCORE").item(0).getChildNodes().item(0).getNodeValue();
			       strStatus=(String)((Element)bre_nodesList.item(0)).getElementsByTagName("HostTransaction/Status").item(0).getChildNodes().item(0).getNodeValue();
			      
					
					
					
					/*	DocumentBuilderFactory bre_factory = DocumentBuilderFactory
								.newInstance();
						DocumentBuilder bre_builder = bre_factory.newDocumentBuilder();
						
						InputSource bre_inputSource = new InputSource(
								new StringReader(bre_result.toString()));
						Document bre_doc = bre_builder.parse(bre_inputSource);
						
						XPath bre_xpath = XPathFactory.newInstance().newXPath();
								
						NodeList bre_children = bre_doc.getElementsByTagName("DAJSONDocument/KBPLOUT/APPLICANTOUT");
						if (bre_children.getLength()>0){
						
						 strdebitscore=bre_xpath.compile("DEBITSCORE").evaluate(doc);
							
							//	strStatus=bre_xpath.compile("HostTransaction/Status").evaluate(doc);
*/						
						
				
				
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","del_debitscore");
						arrValues.add(strCbsID);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
												
						
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_debit_score");
						arrValues = new ArrayList();
						arrValues.add(strCbsID);
						arrValues.add(strdebitscore);//appraised by
					
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
				}		
	}
	}
	catch (ParserConfigurationException pce) {
			System.out
					.println("ParserConfigurationException.....................cbsBreSrevice");
			pce.printStackTrace();
			
			throw new EJBException("Exception in cbsBreSrevice ==="+pce.getMessage());

	
		} catch (SAXException se) {
			System.out.println("SAXException.....................cbsBreSrevice");
			se.printStackTrace();
			
			throw new EJBException("Exception in cbsBreSrevice ==="+se.getMessage());
		} catch (IOException ioe) {
			System.out.println("IOException.....................cbsBreSrevice");
			ioe.printStackTrace();
			throw new EJBException("Exception in cbsBreSrevice ==="+ioe.getMessage());
		} catch (Exception e) {
			System.out.println("Exception.....................cbsBreSrevice");
			e.printStackTrace();
			throw new EJBException("Exception in cbsBreSrevice ==="+e.getMessage());
			
		}
	
	return hshQuery;
	}
	


	
	 public void dmsNotificationService(HashMap hshVal)  {
			
			JSONObject objOuter = new JSONObject();
			JSONObject jsonObject1 = new JSONObject();
			JSONObject jsonObject2 = new JSONObject();
			JSONObject jsonObject3 = new JSONObject();
			JSONObject jsonObject4 = new JSONObject();
			JSONObject jsonObject5 = new JSONObject();
			JSONObject jsonObject6 = new JSONObject();
			JSONObject jsonObjectForData = new JSONObject();
			JSONObject loanDetailsdata = new JSONObject();
			JSONObject jsonObject8 = new JSONObject();
			
			
			JSONArray jsonArray1 = new JSONArray();
			JSONArray jsonArray2 = new JSONArray();
			JSONArray jsonArray3 = new JSONArray();
			JSONArray jsonArray4 = new JSONArray();
			JSONArray jsonArray5 = new JSONArray();
			JSONArray jsonArray6 = new JSONArray();
			
			
			String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = ""
							, strInputJSONRequest = "", strRes = "", strCustDesc = "", strEntity = "";

			ResultSet rs = null;
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			
			ArrayList arrValues = new ArrayList();
			HashMap hshValForDoc = new HashMap(); 
			
			try {
				
				if(hshVal!=null){
					hshValForDoc = this.uploadFileToServer(hshVal); //in hshVal obj MultipartFormDataRequest class obj should be present
				}
				String strImageId = Helper.correctNull((String)hshValForDoc.get("strImageId"));
				
				String extension="";
				String filename=Helper.correctNull((String)hshValForDoc.get("strfilename"));
				String doccode=Helper.correctNull((String)hshValForDoc.get("strDocCode"));
				String strFileSize=Helper.correctNull((String)hshValForDoc.get("strFileSize"));
				String strappno=Helper.correctNull((String)hshValForDoc.get("strAppNo"));
				String strUserID=Helper.correctNull((String)hshValForDoc.get("strUserID"));
				
				String strdoctype="",strdocid="",strdocName="",strdoccode="";
					rs = DBUtils.executeLAPSQuery("sel_documentdetails_doccode^" + doccode);
					if(rs.next())
					{
						strdoctype=Helper.correctNull((String)rs.getString("doc_doctype"));
						strdocid=Helper.correctNull((String)rs.getString("Document_ID"));
						strdocName=Helper.correctNull((String)rs.getString("Document_Name"));
						strdoccode=Helper.correctNull((String)rs.getString("Document_Code"));
						
					}
					
				
				int i= filename.lastIndexOf('.');
				if(i>=0)
				{
					extension= filename.substring(i+1);
				}
				
				
				
				jsonObject8.put("Name","");
				jsonObject8.put("CustomerId", "CUS-00009");
				jsonObject8.put("Relation", "APPLICANT");
				jsonObject8.put("UCICCode", "A100");
				jsonObject8.put("MobileNumber","" );
				
				 jsonArray6.put(0, jsonObject8);
				
				//jsonArray4.put(jsonArray6);
				
				
				
				jsonObject6.put("DOCDESC", strdocName);
				jsonObject6.put("DOCCODE", strdoccode);
				jsonObject6.put("FILE", filename);
				jsonObject6.put("CustIndex", 1);
				jsonObject6.put("url", "");
				
				jsonArray3.put(0, jsonObject6);
				
				loanDetailsdata.put("LeadNumber", strappno);
				loanDetailsdata.put("ProductCode","" );
				loanDetailsdata.put("BranchCode","" );
				loanDetailsdata.put("LoanStatus","");
				loanDetailsdata.put("ProposalNumber", "");
				loanDetailsdata.put("ApprovalDate", "");
				loanDetailsdata.put("DisbursalDate", "");
				loanDetailsdata.put("SourceSystemName", "MobileApp");
				loanDetailsdata.put("Customers", jsonArray6);

				


				
				
				jsonObjectForData.put("LoanDetails", loanDetailsdata);
				/*jsonObjectForData.put("LEADNUMBER", strappno);
				jsonObjectForData.put("SIZE", strFileSize);  
				jsonObjectForData.put("DOCUMENTS", jsonArray3);
				*/
				String strData = jsonObjectForData.toString();
				//String mimetype=Helper.correctNull((String)hshVal.get("mimetype"));
				jsonObject4.put("TYPE", "ADDITION");
				jsonObject4.put("QUEUEFILTER4", 1);
				jsonObject4.put("WORKQUEUELOGDATA", "CSTAGE=Creation;NSTAGE=MQPublish");
				jsonObject4.put("PROPOSALNO", "");
				jsonObject4.put("BUSINESSGROUPID", 1);
				
				if(extension.equalsIgnoreCase("pdf"))
				{
				jsonObject4.put("MIMETYPE","Application/pdf");
				}
				if(extension.equalsIgnoreCase("text"))
				{
					jsonObject4.put("MIMETYPE","Application/plain");
				}
				if(extension.equalsIgnoreCase("xlsx"))
				{
				jsonObject4.put("MIMETYPE","Application/xlsx");
				}
				if(extension.equalsIgnoreCase("jpg"))
				{
				jsonObject4.put("MIMETYPE","Application/jpg");	
				}
				if(extension.equalsIgnoreCase("png"))
				{
				jsonObject4.put("MIMETYPE","Application/png");	
				}
				
				
				//request id number 
				if(rs!=null)
					rs.close();
					
				String strPatternRequestID="",strfilecount="";
				rs = DBUtils.executeLAPSQuery("sel_docattachcount^" + strappno);
				if(rs.next())
				{
					strfilecount=Helper.correctNull((String)rs.getString("filecount") );
				}
				
				strPatternRequestID="LAPS-"+strappno+"/"+strfilecount;
				
				jsonObject5.put("ID", 0);
				jsonObject5.put("APPDATA1", strPatternRequestID); ///////reference number
				jsonObject5.put("APPDATA2", "ST	AGE=MQPublish;SourceSystem=LAPS;");
				jsonObject5.put("APPDATA3", "");
				jsonObject5.put("DATA", strData);
				jsonObject5.put("NOTEPAD", "");
				jsonObject5.put("FILEID",strImageId); 
				jsonObject5.put("WORKITEMTYPE", 3);
				jsonObject5.put("WORKITEMCATEGORY", 2);
				jsonObject5.put("WORKITEMSOURCE", 8);
				jsonObject5.put("PROCESSINGUNIT", 0);
				jsonObject5.put("PARENTID", 0);
				jsonObject5.put("WORKITEMGROUP", -1);
				jsonObject5.put("BRANCH", 8);
				jsonObject5.put("PRIORITY", 1);
				jsonObject5.put("USERASSIGNMENT", 0);
				jsonObject5.put("ARCHIVEID", 0);
				
				jsonObject3.put("ATTRIBUTES", jsonObject4);
				jsonObject3.put("FIELD", jsonObject5);
				
				jsonArray2.put(0, jsonObject3);
				
				jsonObject2.put("NAME", "WORKINFO");
				jsonObject2.put("RECORD", jsonArray2);
				
				jsonArray1.put(0, jsonObject2);
				
				jsonObject1.put("SECTION", jsonArray1);
				
				objOuter.put("SessionKey", "1403072309_3caf1ce0-29e7-4522-9f0f-2ee68aae6f29");
				objOuter.put("ParentId", 0);
				objOuter.put("WorkId", 0);
				objOuter.put("WorkItemType", 3);
				objOuter.put("FileListId", strImageId);  //need to change 
				objOuter.put("PageId1", 0);
				objOuter.put("PageId2", 0);
				objOuter.put("FileSize", 0);
				objOuter.put("FileFormat", 2);
				objOuter.put("FileType", 2);
				objOuter.put("Status", 1);
				objOuter.put("Option", 0);
				objOuter.put("DATA", jsonObject1);
				
				log.info("######################### jsonRequest for dmsNotificationService $$$$$$$$$$$$$$$$$$$$$$$$  "+objOuter);			
			
				
				
				strInputJSONRequest = objOuter.toString();
				// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@ CHM & CIBIL Request @@@@@@@@@@@@@################"+
				// strInputXMLRequest);
				log.info("################@@@@@@@@@@@@@ dmsNotificationService Json Request @@@@@@@@@@@@@################"
								+ strInputJSONRequest);
				// LogWriter.log(LAPSLogLevel.ERROR,""+"################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
				// ApplicationParams.getstrCHMCIBILURL());
				// System.out.println("################@@@@@@@@@@@@@    Service URL      @@@@@@@@@@@@@################"+
				// ApplicationParams.getstrCHMCIBILURL());
				
			
				URL url = new URL(ApplicationParams.getStrPushDocumentService());
				log.info("dmsNotificationService Url=========== "+url);
				
				HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
						
				urlcon.setRequestProperty("User-Agent", "");
				urlcon.setDoInput(true);
				urlcon.setDoOutput(true);
				urlcon.setRequestMethod("POST");
				urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
				urlcon.setRequestProperty("Authorization","Basic "+ ApplicationParams.getStrAuthValue());
				
				
				
		
				
				
				
				OutputStreamWriter osw = new OutputStreamWriter(urlcon.getOutputStream(), "UTF-8");
				osw.write(strInputJSONRequest);
				osw.close();
				
				InputStream inputStream = urlcon.getInputStream();
				InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");	
				BufferedReader br = new BufferedReader(isreader);
				
				StringBuffer jsonString = new StringBuffer();
				if (br != null) {
					
					while ((line = br.readLine()) != null) {
						jsonString.append(line);
						//Logger.log("jsonString================="+jsonString);
						//Logger.log("INSIDE WHILE LOOP OF JSON CONENCTION ######################################### ");
					}
					
				}
				log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ jsonString.toString());
				br.close();
				urlcon.disconnect();
				
				
				
				
				String strResponse	 = String.valueOf(jsonString);
				JSONObject jsonResponseObj	 = 	new JSONObject(strResponse);
				
				JSONArray jsonResArray1 = jsonResponseObj.getJSONArray("SECTION");
				JSONObject jsonResObject1 = jsonResArray1.getJSONObject(0);
				JSONArray jsonResArray2 = jsonResObject1.getJSONArray("RECORD");
				JSONObject jsonResObjectForStatus = jsonResArray2.getJSONObject(0);
				
				String status = jsonResObjectForStatus.getString("STATUS");
			/*	JSONObject jsonResObjectForData = jsonResObjectForStatus.getJSONObject("FIELD");
				String strActualData = jsonResObjectForData.getString("Data");
				*/
				if(status.equalsIgnoreCase("Success")){
					System.out.println("################@@@@@@@@@@@@@ STATUS @@@@@@@@@@@@@################"+ status);
				}else{
					throw new EJBException("STATUS: "+status);
				}
				
				// LogWriter.log(LAPSLogLevel.ERROR,""+"############@@@@@@@@@@@@@  Response  @@@@@@@@@@@@@############"
				// + result.toString());
			
			/*	hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_appdocattachments_proposalapi");
				arrValues.add(strappno);
				arrValues.add(strdoctype);
				arrValues.add(strdoccode);
				arrValues.add(filename);
				arrValues.add(strUserID);
				arrValues.add("1");
				arrValues.add(strPatternRequestID);
				arrValues.add(""); //genurldate
				arrValues.add("");	//docurl
				arrValues.add(strFileSize);	
				arrValues.add("");	//genurl
				arrValues.add("");	//leadnumber
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				*/
			}catch (JSONException e) {
				System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ JSONException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
				e.printStackTrace();
				throw new EJBException("Exception in JSON ==="+e.getMessage());
			}catch (MalformedURLException e) {
				System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ MalformedURLException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
				e.printStackTrace();
				throw new EJBException("Malfunction URL Exception ==="+e.getMessage());	
			}catch (IOException e) {
				System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ IOException &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
				e.printStackTrace();
				throw new EJBException("Input Output Exception ==="+e.getMessage());	
			}catch (Exception e) {
				e.printStackTrace();
				throw new EJBException(" Exception ==="+e.getMessage());	
			}	
		}//pushDocumentService()
		
	
	
 public HashMap cbsAmlFields(HashMap hshValues){
		
	 String strInputXMLRequest="",strRequestUUID="",strServiceRequestVersion="",strChannelId="",strBankId="",strEntityType="",strMessageDateTime="",strpan="",
	 		strFatherName="",strPAN="",strEmploymentStatus="",streduqua="",stremployeer="",strNewCustId="",line="",strResStatus="",strResCustID="",strResDesc="",strdocid="",
	 		strspouseName="",strmotherName="",strCast="",strdocecode="",strIdType="",strIdRef="",strMotherName="",strMothNameTag="",strspousTag=""; 
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
ResultSet rs = null;
try {
strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
strNewCustId=Helper.correctNull((String) hshValues.get("newCustId"));
String hidborrowerid=Helper.correctNull((String) hshValues.get("hidborrowerid"));
if(hidborrowerid.equals(""))
{
	hidborrowerid=Helper.correctNull((String) hshValues.get("hidapplicantnewid"));
}
if(hidborrowerid.equals(""))
{
	hidborrowerid=Helper.correctNull((String) hshValues.get("hidapplicantid"));
}
strServiceRequestVersion = "10.2";
strChannelId = "COR";
strBankId = "01";
strEntityType = "";
SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
strMessageDateTime=simpledateformat.format(new Date());
double strincome=0.00,monincome=0.00;
rs = DBUtils.executeLAPSQuery("sel_cbsIdCreation^" + hidborrowerid);
if (rs.next()) {
	
	strFatherName = Helper.correctNull((String) rs.getString("perapp_fatname"));
	strPAN = Helper.correctNull((String) rs .getString("PERAPP_PANNO"));
	strEmploymentStatus = Helper.correctNull((String) rs .getString("PERAPP_EMPLOYMENT"));
	streduqua=Helper.correctNull((String) rs .getString("INDINFO_EDU_QUAL"));
	strincome =Double.parseDouble(Helper.correctDouble((String) rs .getString("PERAPPACTUALINCOME")));
	stremployeer=Helper.correctNull((String) rs .getString("PEREMP_NAME"));
	strspouseName=Helper.correctNull((String) rs .getString("indinfo_spouse_name"));
	strCast=Helper.correctNull((String) rs .getString("indinfo_caste"));
	
	if(strincome!=0.00 || strincome!=0.0)
	{
		monincome=strincome/12;
	}
	
	if(strEmploymentStatus.equals("1"))
	{
		strEmploymentStatus="119";
	}
	else
	{
		strEmploymentStatus="122";
	}
	strIdType=Helper.correctNull((String) rs .getString("idprooftype"));
	strIdRef=Helper.correctNull((String) rs .getString("KYC_IDPROOFREF"));
}	

if(!strMotherName.equals(""))
	 strMothNameTag="<mname>"+strMotherName+"</mname>";
if(!strspouseName.equals(""))
	strspousTag="<spouse>"+strspouseName+"</spouse>";
	
if(!stremployeer.equals(""))
{
	if(stremployeer.length()>40)
	{
		stremployeer=stremployeer.substring(0, 39);
	}
}

		strInputXMLRequest="<?xml version='1.0' encoding='UTF-8'?><FIXML xsi:schemaLocation='http://www.finacle.com/fixml RetCustInq.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'><Header><RequestHeader>"+
		"<MessageKey><RequestUUID>Req_"+strRequestUUID+"</RequestUUID><ServiceRequestId>executeFinacleScript</ServiceRequestId><ServiceRequestVersion>"+strServiceRequestVersion+"</ServiceRequestVersion>"+
		" <ChannelId>"+strChannelId+"</ChannelId> </MessageKey><RequestMessageInfo><BankId>"+strBankId+"</BankId><MessageDateTime>"+strMessageDateTime+"</MessageDateTime></RequestMessageInfo>"+
		"</RequestHeader></Header><Body> <executeFinacleScriptRequest> <ExecuteFinacleScriptInputVO> <requestId>custom_fi_custupd.scr</requestId> </ExecuteFinacleScriptInputVO><executeFinacleScript_CustomData>"+
		strspousTag+strMothNameTag+"<custcaste>"+strCast+"</custcaste><custid>"+strNewCustId+"</custid><doccode>99</doccode><docid>"+strIdRef+"</docid><prof>"+strEmploymentStatus+"</prof><fname>"+strFatherName+"</fname> <eduq>"+streduqua+"</eduq> <empname>"+stremployeer+"</empname> <anninc>"+strincome+"</anninc> <income>"+monincome+"</income>"+
		"</executeFinacleScript_CustomData> </executeFinacleScriptRequest></Body></FIXML>";
		
		log.info("################@@@@@@@@@@@@@ CBS ALM FIELDS Request @@@@@@@@@@@@@################"
				+ strInputXMLRequest);
String strUrl = ApplicationParams.getStrCUSTIDVerification();
URL url = new URL(strUrl);
	log.info("CBS AML Url======"+url);
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
if (rd != null) {
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
		              if(!strResStatus.equalsIgnoreCase("SUCCESS"))
		              {
		             strResDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("ErrorDesc").item(0).getChildNodes().item(0).getNodeValue();
		            	 
		    	hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_cbs_api_error_status");
				arrValues = new ArrayList();
				arrValues.add(strNewCustId);
				arrValues.add(strResDesc);
				arrValues.add(strRequestUUID);
				arrValues.add("CBS AML FIELDS");
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
		

}
} 
catch (Exception ex) 
{
	ex.printStackTrace();
	throw new EJBException("Error in cbsAmlFields");
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

	public HashMap autoLoanDedupeCheck(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="",strInwardno="";
		
		try
		{
			
		String strPANno=Helper.correctNull((String)hshValues.get("strPANno"));
		String strCBSid=Helper.correctInt((String)hshValues.get("strCBSid"));
		String strApplExist="N";
		
		String strCusName="",strCusCBSID="",strCusFatherName="",strCustDOB="",strCustPANno="",strAppno="",strAppStatus="",strmobileno="",strBIRdate="",strappcreatedate="",strdigiappno="";
		
		rs=DBUtils.executeLAPSQuery("sel_autolaon_dedupe_extnAppl_panno^"+strPANno);
		if(rs.next())
		{
			strApplExist="Y";
			strCusName=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
			strCusCBSID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			strCusFatherName=Helper.correctNull((String)rs.getString("PERAPP_FATNAME"));
			strCustDOB=Helper.correctNull((String)rs.getString("PERAPP_DOB"));
			strCustPANno=Helper.correctNull((String)rs.getString("PERAPP_PANNO"));
			strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
			strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			strmobileno=Helper.correctNull((String)rs.getString("CON_MOBILE"));
			if(strAppStatus.equals("op"))
			{
				strAppStatus="Open";
			}
			else
			{
				strAppStatus="Approved";
			}
			
			/*rs1=DBUtils.executeLAPSQuery("sel_per_bir^"+strAppno);
			if(rs1.next())
			{
				strBIRdate=Helper.correctNull((String)rs1.getString("bir_processdate"));
			}*/
			strdigiappno=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));

		}		
			
		if(rs!=null)
			rs.close();
		if(rs1!=null)
			rs1.close();
		
		rs=DBUtils.executeLAPSQuery("sel_autolaon_dedupe_extnAppl_cbsid^"+strCBSid);
		if(rs.next())
		{
			strApplExist="Y";
			strCusName=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
			strCusCBSID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			strCusFatherName=Helper.correctNull((String)rs.getString("PERAPP_FATNAME"));
			strCustDOB=Helper.correctNull((String)rs.getString("PERAPP_DOB"));
			strCustPANno=Helper.correctNull((String)rs.getString("PERAPP_PANNO"));
			strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
			strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			if(strAppStatus.equals("op"))
			{
				strAppStatus="Open";
			}
			else
			{
				strAppStatus="Approved";
			}
			strmobileno=Helper.correctNull((String)rs.getString("CON_MOBILE"));
			/*rs1=DBUtils.executeLAPSQuery("sel_per_bir^"+strAppno);
			if(rs1.next())
			{
				strBIRdate=Helper.correctNull((String)rs1.getString("bir_processdate"));
			}*/
			strdigiappno=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));
		}
		
		if(strApplExist.equals("N"))
		{
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_cbsid_BIR^"+strCBSid);
			if(rs.next())
			{
				//strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
				strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
				strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
				if(strAppStatus.equals("op"))
				{
					strAppStatus="Open";
				}
				else
				{
					strAppStatus="Approved";
				}
				strappcreatedate=Helper.correctNull((String)rs.getString("APP_CREATEDATE"));

			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_dedupe_extnAppl_panno_BIR^"+strPANno);
			if(rs.next())
			{
				//strBIRdate=Helper.correctNull((String)rs.getString("bir_processdate"));
				strAppno=Helper.correctNull((String)rs.getString("APP_NO"));
				strAppStatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
				if(strAppStatus.equals("op"))
				{
					strAppStatus="Open";
				}
				else
				{
					strAppStatus="Approved";
				}
				strappcreatedate=Helper.correctNull((String)rs.getString("APP_CREATEDATE"));
			}
			
		}
			
		hshValues.put("strApplExist", strApplExist);
		hshValues.put("strCusName",strCusName );
		hshValues.put("strCusCBSID",strCusCBSID );
		hshValues.put("strCusFatherName", strCusFatherName);
		hshValues.put("strCustDOB", strCustDOB);
		hshValues.put("strCustPANno", strCustPANno);
		hshValues.put("strAppno", strAppno);
		hshValues.put("strAppStatus", strAppStatus);
		hshValues.put("strmobileno", strmobileno);
		//hshValues.put("strBIRdate", strBIRdate);
		hshValues.put("strappcreatedate", strappcreatedate);
		hshValues.put("strdigiappno", strdigiappno);
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean autoloandedupeCheck..."+e.toString());
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
				throw new EJBException("Error in DigitalAppInterface Bean autoLaondedupeCheck in  closing connection ..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
	

	public HashMap autoLoanproposalCreation(HashMap hshValues)  
	{
		HashMap hshQuery= new HashMap();
		HashMap hshQueryValues= new HashMap();
		HashMap hshlockvalues=new HashMap();
		HashMap hshRecord=new HashMap();

		ArrayList arrValues= new ArrayList();
		ArrayList arrValue= new ArrayList();
		
		ResultSet rs=null,rs1=null,rs2=null,rs3=null;
		String strQuery="",strApplicationNo="",strLAPSid="", strperappOldID="",strsolidOf850="";
		
		String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
		String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
		int intUpdatesize=0;
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	
		try
		{			
			String strcategoryLoanPurpose=Helper.correctNull((String)hshValues.get("strcategoryLoanPurpose"));
			
			Date date1;
			Date date2;
			String strDate = ApplicationParams.getStrCLPCdate();
			SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
			date1 = CLPCdate.parse(strDate);
			String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
			date2 = CLPCdate.parse(NOwCalender);
			String strsolidMang = strsolid;

			if (date1.before(date2))
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strsolid);
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
			
			//userid from organisation
			String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="",STRCLPHAV="";
			String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
			String strscheme =Helper.correctNull((String)hshValues.get("strScheme"));
			
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
			if(strcategoryLoanPurpose.equalsIgnoreCase("N")|| strcategoryLoanPurpose.equalsIgnoreCase("U"))
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strsolidMang);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			else 
			{
				strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			}else{
				strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
					strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
					strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
					strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
					strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
				}
			}
			
			if (rs != null) 
			{	rs.close();	 }
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
			
			
			//system user
			String strSysteUserId="SYSUSR";
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);	
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
				strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
			}
			
			if(strLAPSid.equals(""))
			{
				strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
				strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
			}
			
			String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
			
			
				//new Application Number
				hshlockvalues = new HashMap();
				hshlockvalues.put("apptype", "P");
				hshlockvalues.put("comapp_id", strLAPSid);
				hshlockvalues.put("strSolid", strsolid);
				strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

				//applications table
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strPrdCode);
				arrValues.add(strSysteUserId);
				arrValues.add(strOrgCode);									
				arrValues.add("P"); //Digital retail
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				arrValues.add("R");
				arrValues.add(strOrgLevel);
				arrValues.add(strUserId);
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("N");
				arrValues.add("PR");
				arrValues.add("N");
				arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
				arrValues.add(correctNull((String) hshValues.get("strstpType")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insapplications_digi");
				//hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				//demographic table 
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(strLAPSid);
				arrValues.add("a");
				arrValues.add("");
				arrValues.add("2");
				arrValues.add(strperappOldID);
				arrValues.add("");
				arrValues.add("a");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsdemoins");
				//hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				//inward register
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","updinwardappatached");
				arrValues.add("Y");
				arrValues.add("op");
				arrValues.add(correctNull((String) hshValues.get("strLARno")));
				hshQuery.put("arrValues",arrValues);
				//hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				String mclrtype="",mclrtabcode="",mclrbaserate="";
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
					mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
				}
				
				//interest rate calculation
				
				double intrate=0.00;
				intrate=Double.parseDouble(mclrbaserate)+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")))
						+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
				
				//credit risk and business premium
				/*if (rs != null) 
				{ 	 rs.close();	}
				String strLesser = ">=";
				String strGreater = "<=";
				String strTerms=correctNull((String) hshValues.get("strLoanTenor"));
				String strRecAmt=correctNull((String) hshValues.get("strAmountRequested"));
				double prd_creditrskpremium=0.00,prd_busstrategicpremium=0.00;
				
				strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^floating^" + strPrdCode + "^" + strGreater + "^"
						+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^O^" + strGreater + "^" + strTerms + "^"
						+ strLesser + "^" + strTerms );
				
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 prd_creditrskpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")));
					 prd_busstrategicpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")));
				}
				
				double strintrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
				prd_busstrategicpremium=strintrate-(Double.parseDouble(Helper.correctDouble(mclrbaserate))-prd_creditrskpremium);*/
				
				//margin calculation
				int margin=0;
				if(rs1!=null)
					rs1.close();
				String desc=correctNull((String) hshValues.get("strAmountRequested"));
				
				/*rs1 = DBUtils.executeLAPSQuery("sel_prdmargin_appl^"+ strPrdCode+"^"+desc);
				if(rs1.next())
				{
					margin=Integer.parseInt(Helper.correctInt((String)rs1.getString("MARGIN_PERCT")));
				}
			*/
				
				//loandetails
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;//
				hshQuery.put("strQueryId", "ins_loandetails_extAppl");
				arrValues.add(strApplicationNo);
				arrValues.add(String.valueOf(jtn.format(intrate)));
				arrValues.add(String.valueOf(jtn.format(intrate)));
				
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
				String intype=correctNull((String) hshValues.get("strInterestType"));
				if(intype.equals("1"))
				{
					intype="Fixed";
				}
				else if(intype.equals("2"))
				{
					intype="Floating";
				}
				arrValues.add(intype);
				arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
				//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
				arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
				arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
				//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
				arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
				arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
				arrValues.add(correctNull((String) hshValues.get("strTakeover")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("strEMIamount")));
				//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
				arrValues.add(mclrtabcode);
				arrValues.add(mclrtype);
				arrValues.add(Helper.correctDouble((String) hshValues.get("strProcessingFee")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("strprocesssingFeeCollected")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
				arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
				arrValues.add(mclrbaserate);
				arrValues.add(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
				if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
				{
					arrValues.add("1"); //interest charged 
				}
				else
				{
					arrValues.add("2");  //interest charged 
				}
				arrValues.add("C");
				arrValues.add(correctNull((String) hshValues.get("strMargin")));
				arrValues.add("Y");
				arrValues.add("N");
				arrValues.add("S");
				//if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
					arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
				//else
					//arrValues.add("NC");
					arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
					//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
					arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
					arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
					arrValues.add(strsolid);
					arrValues.add(correctNull((String) hshValues.get("strEMIamount")));

				arrValues.add(correctNull((String)hshValues.get("strschemeType")));
				arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
				arrValues.add(correctNull((String)hshValues.get("stragencyName")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
				arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));	
				//arrValues.add("N");
				arrValues.add("N");
				arrValues.add("");
				arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
				arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
				arrValues.add(correctNull((String) hshValues.get("")));
				arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
				arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
				arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
				arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
				arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));

				hshQuery.put("arrValues", arrValues);
			//	hshQueryValues.put(""+intUpdatesize, hshQuery);
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
				arrValues.add(strApplicationNo);
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
				arrValues.add(strApplicationNo);
				arrValues.add(strSysteUserId);
				arrValues.add(strUserId);
				arrValues.add("1");
				arrValues.add("2");
				arrValues.add(strDay);
				arrValues.add("C");
				arrValues.add("001");
				arrValues.add("");
				arrValues.add(strOrgScode);
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
			//	hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				//per loan secure
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
				arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
				arrValues.add("s"); //unsecured
				arrValues.add("0"); //secured amt
				arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				//hshQueryValues.put(""+intUpdatesize, hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
			/*	hshQueryValues.put("size",String.valueOf(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				
				//Coapplicant
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
						
						//hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						intUpdatesize++;
						hshQuery.put("strQueryId", "perloandetailsdemoins");
						arrValues = new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(perapppid);//appid
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
						arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
						arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
						arrValues.add(strOldid);//oldid
						arrValues.add(strfinacletype.toUpperCase());//relationtype
						arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
						hshQuery.put("arrValues", arrValues);
						/*hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					}
				}
				
				String strperappcity="",strperappstate="",strperappdistrict="";
				strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
					strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
					strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
				}					
				
				//terms and conditions
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
					// hshQueryValues = new HashMap();
					 hshQuery = new HashMap();
					 arrValues = null;
					for(int i=0;i<arrTermsId.size();i++)
					{
						//hshQueryValues.put("size",String.valueOf(++intSize));
						hshQuery=new HashMap();
						intUpdatesize++;
						hshQuery.put("strQueryId","apptermscondins1");
						arrValues=new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(String.valueOf(i));
						arrValues.add(correctNull((String)arrTerms.get(i)));
						arrValues.add("P");
						arrValues.add("N");
						arrValues.add("S");
						arrValues.add("");
						arrValues.add("N");
						arrValues.add(correctNull((String)arrTermsType.get(i)));
						hshQuery.put("arrValues",arrValues);
						//hshQueryValues.put(String.valueOf(intSize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					/*if(arrTermsId.size()>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				}
				
				//Coapplicant Freeze
				hshValues.put("appno", strApplicationNo);
				PerApplicantBean perApplicantBean = new PerApplicantBean();
				perApplicantBean.getFreezeData(hshValues);
				
				//Credit Facilities freeze
				BankAppFIBean appFIBean = new BankAppFIBean();
				appFIBean.updateFreezeData(hshValues);
			
				//MIS Activity
				HashMap hshMISstatic = new HashMap();
				HashMap hshMISSubActivity = new HashMap();
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
					String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
					hshMISstatic.put(strSlcode,strPrdDesc);
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
				rs1= DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
					String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
					hshMISSubActivity.put(strSubcode,strSubPrdDesc);
				}
				
				
				String strActivity = " and mac.ACT_ACTIVITYCODE in (";
				String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
				String stractivitycode=strActCode;
				if(rs1!=null)
				{	  rs1.close();		}
				strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{ 
					hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
					hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
					hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
					hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
					hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
					hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
					hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
					hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
					hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
					hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
					hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
					hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
					hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
					hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
					hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
					String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
					String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
					if(strMainActivityCode.length()>0)
					{
						hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
					}
					
					if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
					{
						String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
						hshValues.put("strMainSubA/ctivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
					}
					
					hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
					hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
					
					hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
					hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
					hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
				}
				
				double dblTotLim=0.00;
				double dblTotLimAgr=0.00;
				double dblTotLimSer=0.00;
				
				MisBean misbean=new MisBean();
				
				dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
				dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strApplicationNo);
				dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strApplicationNo);
				
				int querycount=0;
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				//hshQueryValues.put(String.valueOf(querycount),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				//querycount++;
				intUpdatesize++;
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add("1"); //facility serialno
				hshQuery.put("arrValues",arrValues);
				//hshQueryValues.put(String.valueOf(querycount),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				/*hshQuery = new HashMap();
				arrValues=new ArrayList();
				//querycount++;
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
				arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
				arrValues.add("N");//Whether under Service Area Approach
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
				arrValues.add(strperappcity);
				arrValues.add(strperappdistrict);
				arrValues.add(strperappstate);
				arrValues.add(strorg_branchin);//Place - Metro
				arrValues.add("N"); //Does repayment depend purely on the asset financed
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
				arrValues.add("00");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
				arrValues.add(strActCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
				arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
				arrValues.add("1"); //Asset Classification
				arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
				arrValues.add("1"); //fac serial no
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sharebroker")));
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
				
				String strQueryAgr="";
				strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
				MISLogger.UpdateLogger(strQueryAgr);
				rs1=DBUtils.executeQuery(strQueryAgr);
				if(rs1.next())
				{
					hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
					hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
					hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
					hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
					hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
					hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
				}
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				//querycount++;
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
				arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
				arrValues.add("1");
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				//hshQueryValues.put(String.valueOf(querycount),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
				MISLogger.UpdateLogger(strQuery);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
					{
						if(rs!=null)
							rs.close();
						strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							//hshQueryValues.put("size","5"); SUnil
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;//querycount++;
							hshQuery.put("strQueryId","upd_cbsdetails");
							arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
							arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
							arrValues.add(strApplicationNo);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							//hshQueryValues.put(String.valueOf(querycount),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					}
				}
				/*hshQueryValues.put("size",String.valueOf(querycount));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				
				/*String strAppStatus="";
				String strPriorityType="";
				String strPrioritySubsector="";
				String strWeakerSectionSubSector="";
				String strAgriIndConfig="";
				String strTwentyPointPgm="";
				String strSensitiveSector="";
				String strInfracode="";
				String strGovtAnnounceScheme="";
				String strClassiMaster_Sno="";
				String strActivityCode="";
				String strActivitySno="";
				HashMap hshPriority=new HashMap();
				String strFacilitySno="1";
				String strStandUpIndia="";

				hshValues.put("strFacilitySno",strFacilitySno);
				hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
				//hshValues.put("strHOLIDAYPERIOD","0");
				hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
				hshValues.put("hidapplicantnewid",strLAPSid);
				hshValues.put("strAppType","P");
				
				hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
				 
				 	//hshQueryValues=new HashMap();
					//hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;
					hshQuery.put("strQueryId","ins_misappclassification_digi");
					arrValues.add(strApplicationNo);
					arrValues.add(strAgriIndConfig);
					arrValues.add(strPriorityType);
					arrValues.add(strPrioritySubsector);
					arrValues.add(strSensitiveSector);
					arrValues.add(strWeakerSectionSubSector);
					arrValues.add(strTwentyPointPgm);
					arrValues.add(strInfracode);
					arrValues.add(strGovtAnnounceScheme);
					arrValues.add(strClassiMaster_Sno);
					arrValues.add(strFacilitySno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);*/
				// mis end

					
				//CBS Details
				 
					/*if(rs != null)
				   rs.close(); 	 
			

				if(rs!=null)
				rs.close();
				String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
				strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
					freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
					freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
					freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
					finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
					finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
				}
				
				
				
				String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
				
				strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
				}
				if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
				{
					strLoanType="LAA";
				}
				else if(strLoanType.equalsIgnoreCase("OD"))
				{
					strLoanType="ODA";
				}
				/*
				strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
				}
 				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(freeCode6);
				arrValues.add(freeCode7);
				arrValues.add(freeCode8);
				arrValues.add("01");//strModeOfOperation
				arrValues.add("E");//strDrawingPowerInd
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
				arrValues.add("N"); // Account Handoff
				arrValues.add("01");//strAdvanceNature
				arrValues.add(strAdvanceType);//TYPEOFADV
				arrValues.add(strmodeofadv);//MODEOFADV
				arrValues.add("10"); //default 10
				arrValues.add("999"); //default 999
				arrValues.add(strsolid);
				arrValues.add(""); //Security Code
				arrValues.add(strintratefrq);//INTRATEFREQ
				arrValues.add(finfreeCode7);
				arrValues.add(finfreeCode8);
				arrValues.add(strlbrcode);
				arrValues.add(strFacilitySno);
				arrValues.add("Vehicle");
				arrValues.add(""); //facilityschemecode
				arrValues.add(""); //facility_glsubheadcode
				arrValues.add("99"); //laps free code 1
				arrValues.add("99"); //laps free code 2
				arrValues.add("99"); //laps free code 3
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_cbsdetails");
				//hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				/*hshQueryValues.put("1",hshQuery);
		  		//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				//hshQueryValues.put("size",Integer.toString(intUpdatesize));
			//	hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
					
					
			/*	hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_birdata");	
				arrValues.add(strApplicationNo);
				arrValues.add("N");
				arrValues.add("0.00");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				
				//documents 

				hshValues.put("strUserId", strUserId);
				hshValues.put("app_no", strApplicationNo);
				//hshValues=getDocumentURLs(hshValues);
				
				//APPRAISALSANCTION table
				/*hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strUserId);//appraised by
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
				arrValues.add("Y");//appraisal flag
				arrValues.add("02");//sanclevel
				arrValues.add("51");//sancauth
				arrValues.add("016");//sancdepart
				arrValues.add("RET");//sancbranch
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
				
				//sanction
				if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equals("sanction"))
				{
						
					//hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","updapplicationsfinalsanction");
					arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					/*hshQueryValues.put("1",hshQuery);*/
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					String strInwardno="";
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId", "updinwardappstatus");
					arrValues.add("pa");
					arrValues.add(strInwardno);
					hshQuery.put("arrValues", arrValues);
					//hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","commworkflowupddigi");
					arrValues.add("pa");
					arrValues.add(strUserId);
					arrValues.add(strOrgScode);
					arrValues.add("");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					//hshQueryValues.put("3",hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					/*hshQueryValues.put("size","3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				
					//sanction reference numnber
					CommWorkflowBean commwrkfko=new CommWorkflowBean();
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
						hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
						hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
						hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
					}
					hshValues.put("hidAction", "approve");
					hshValues.put("sessionModuleType", "RET");
					hshValues.put("strApplicationType", "F");
					hshValues.put("digiloan", "Y");

					String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
					
					hshValues.put("strReferenceno", strReferenceno);
					hshValues.put("strSanctionDate", Helper.getCurrentDateTime());

				}
				
				
				//security Attachment
				
				String secId="",strLoanType="";
				
				ArrayList arraSecId=new ArrayList();
				arraSecId=(ArrayList) hshValues.get("arrSecID");
				
				int arrdSecIdLen=arraSecId.size();
				if(arrdSecIdLen>0)
				{
					for(int i=0;i<arrdSecIdLen;i++)
					{
				
				secId=(String) arraSecId.get(i);
				
				String SecValue="",CUS_SEC_SECURITY_DESCRIPTION="";
				strQuery = SQLParser.getSqlQuery("sel_sec_vehicle^"+secId);	
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					SecValue=Helper.correctNull((String)rs.getString("CUS_SEC_NETSECURITY"));
					CUS_SEC_SECURITY_DESCRIPTION=Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"));
				}
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				arrValues.add(strApplicationNo);
				arrValues.add(secId); // security id
				arrValues.add("1");
				arrValues.add(strperappOldID);
				arrValues.add(SecValue); //CUS_SEC_NETSECURITY
				arrValues.add("0.00"); //CUS_SEC_REIDUALVAL
				arrValues.add("F"); //fresh
				arrValues.add(strLoanType); //loantype
				arrValues.add("1"); //primary sec
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); 
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				arrValues.add("1"); //primary sec
				arrValues.add(strperappOldID);
				arrValues.add(correctNull((String) hshValues.get("strMargin")));
				arrValues.add(strPrdCode);
				arrValues.add("P");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(strperappOldID);
				arrValues.add("F");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(CUS_SEC_SECURITY_DESCRIPTION);//description
				arrValues.add("");
				//arrValues.add("");
				hshQuery.put("strQueryId","ins_securitydetailsrenew_digi");
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/	
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				//security Freeze
				BankAppFIBean bankappfi=new BankAppFIBean();
				hshValues.put("appno", strApplicationNo);
				hshValues.put("hidapplicantid", strLAPSid);
				hshValues.put("hidapplicantnewid", strLAPSid);
				
				bankappfi.getSecCollateralCoverageRetail(hshValues);
				
				int srlnmbr=0,snmbr=0;
				
				rs1 = DBUtils.executeLAPSQuery("sel_vehiclemaxsno^"+strApplicationNo);
	   	   		if(rs1.next())
	   	   		{
	   	   			srlnmbr=Integer.parseInt(Helper.correctInt(rs1.getString("sno")));
	   	   		}
				
		   	   	rs1 = DBUtils.executeLAPSQuery("sel_valuationmaxsno^"+strApplicationNo);
	   	   		if(rs1.next())
	   	   		{
	   	   			snmbr=Integer.parseInt(Helper.correctInt(rs1.getString("sno")));
	   	   		}
				
		   	   	hshQuery=new HashMap();
				arrValue=new ArrayList();   
				intUpdatesize++;
				arrValue.add(strApplicationNo);	
				arrValue.add(secId);	    					
				hshQuery.put("arrValues",arrValue);
				hshQuery.put("strQueryId","del_proposedasset_vehicle_sec");
				/*hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
	   	   		
				hshQuery=new HashMap();
				arrValue=new ArrayList();   
				intUpdatesize++;
				arrValue.add(strApplicationNo);	
				arrValue.add(secId);	    					
				hshQuery.put("arrValues",arrValue);
				hshQuery.put("strQueryId","del_proposedasset_valuationEntry_sec");
				/*hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	   	   		
				// Proposed offered asset
				strQuery = SQLParser.getSqlQuery("sel_sec_vehicle^"+secId);	
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strApplicationNo);	    					
					arrValues.add(secId);
					arrValues.add(String.valueOf(++srlnmbr));	
					arrValues.add("N");	    					
					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_NATUREOFCHARGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLETYPE")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_COMPANY")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLECAT")));	    
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MAKE")));	
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MODEL")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_REGNO")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_HPNO")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_CHASSISNO")));
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERNAME")));
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS1")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS2")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCITY")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERSTATE")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERPIN")));	    					
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCONT")));
					arrValues.add("N");	
					arrValues.add("A");	
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PURCHASEVALUE")));
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_AGE")));
					arrValues.add(Helper.correctNull((String)rs.getString("SEC_BOOKVALUE")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_proposedasset_vehicle");
					/*hshQueryValues.put("1", hshQuery);					    					
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
					}}
				
				// valuation entry
			/*	if (rs3 != null) 
				{ 	 rs3.close(); 	}
				rs3 = DBUtils.executeLAPSQuery("sel_sec_vehicle^"+secId);
				if(rs3.next())
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();   
					arrValues.add(strApplicationNo);	
					arrValues.add(secId);
					arrValues.add(String.valueOf(++snmbr));	
					arrValues.add(Helper.correctNull((String)rs3.getString("CUS_VALSUBMITTEDDATE")));	    					
					arrValues.add(Helper.correctNull((String)rs3.getString("CUS_VALRECVDATE")));	    					
					arrValues.add(Helper.correctNull((String)rs3.getString("CUS_SEC_VALUATION_DATE")));	    					
					arrValues.add(Helper.correctNull((String)rs3.getString("CUS_SEC_VALUER_NAME")));
					//arrValues.add(rs3.getInt("cus_sec_totalsecvalue"));
					arrValues.add(Helper.correctNull((String)rs3.getString("cus_sec_totalsecvalue")));
					arrValues.add("Y");
					arrValues.add("N");	
					arrValues.add(Helper.correctNull((String)rs3.getString("CUS_SEC_VALUERCODE")));
					//arrValues.add(rs3.getInt("CUS_SEC_VALUERCODE"));
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_proposedasset_valuationEntry_veh");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/	
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList(); 
				intUpdatesize++;
				hshQuery.put("strQueryId","updt_per_auto_offerred_assets");
				arrValues.add(correctNull((String) hshValues.get("strVehiclePurchase")));
				arrValues.add(correctNull((String) hshValues.get("strVehicleCost")));
				arrValues.add(correctNull((String) hshValues.get("strTax")));
				arrValues.add(correctNull((String) hshValues.get("strOtherCharges")));
				arrValues.add(correctNull((String) hshValues.get("strAccessoriesPrice")));
				arrValues.add(correctNull((String) hshValues.get("strInsurance")));
				arrValues.add(correctNull((String) hshValues.get("strDiscount")));
				arrValues.add(correctNull((String) hshValues.get("strTotalCost")));
				arrValues.add(correctNull((String) hshValues.get("strVerificationDoneBy")));
				arrValues.add(correctNull((String) hshValues.get("strfuelUsed")));
				arrValues.add(strApplicationNo);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				/*hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	*/
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","upd_specialMargin");
				arrValues.add(correctNull((String) hshValues.get("strMargin")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList(); 
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_perverification_doneby");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("strVerificationDoneBy")));
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();  
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_per_sourcemargin");
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String) hshValues.get("strCostAlreadyIncurred")));
				arrValues.add(correctNull((String) hshValues.get("strOwnSavingAndDisposalInvest")));
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				

				//hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_retailcomments");
				arrValues.add(strApplicationNo);
				arrValues.add("LoanProd");
				arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				
				//hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList(); 
				intUpdatesize++;
				hshQuery.put("strQueryId","update_digiApp_refNo");
				arrValues.add(correctNull((String)hshValues.get("strDigiAppno")));
				arrValues.add(correctNull((String)hshValues.get("strPerRefNo")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				/*hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
					//RepaymentSchedule	
				ArrayList arrRepaySchedule=new ArrayList();
				ArrayList arrrepayValue=new ArrayList();
				arrRepaySchedule=(ArrayList) hshValues.get("arrRepaymentSchedule");
				int arrrepayScheduleSize=arrRepaySchedule.size();
				int serialNo=0;
				int facCode=1;
				if(arrrepayScheduleSize>0)
				{
					for(int i=0;i<arrrepayScheduleSize;i++)
					{
				serialNo++;	
				arrrepayValue=(ArrayList) arrRepaySchedule.get(i);
				
				
				String frequency=correctNull((String)arrrepayValue.get(0));
				String instlmntAmount=Helper.correctInt((String)arrrepayValue.get(1));
				String noInstlmnt=Helper.correctInt((String)arrrepayValue.get(2));
				String totalAmnt=Helper.correctInt((String)arrrepayValue.get(3));
				
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				intUpdatesize++;
				hshQuery.put("strQueryId", "ins_repaymnt_schdule");
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
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
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
					
					}
					}
				
				
				ArrayList arrayDigiRate=new ArrayList();
				arrayDigiRate=(ArrayList) hshValues.get("arradigiratingValue");
				
				int arrdigiLen=arrayDigiRate.size();
				
				if(arrdigiLen>0)
				{
				
				 hshQuery = new HashMap();
				 arrValues = new ArrayList();
				 intUpdatesize++;//added
				 hshQuery.put("strQueryId","ins_digi_rate_score_al");
				 arrValues.add(strApplicationNo);
				 arrValues.add(arrayDigiRate.get(0));
				 arrValues.add(arrayDigiRate.get(1));
				 arrValues.add(arrayDigiRate.get(2));
				 arrValues.add(arrayDigiRate.get(3));
				 arrValues.add(arrayDigiRate.get(4));
				 arrValues.add(arrayDigiRate.get(5));
				 arrValues.add(arrayDigiRate.get(6));
				 arrValues.add(arrayDigiRate.get(7));
				 arrValues.add(arrayDigiRate.get(8));
				 hshQuery.put("arrValues", arrValues);
				
				 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				}
				
				
			
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData"); //added

				 
				 String strSchemeCode = "",strAdvanceType="",strintratefrq="";
				 	
				 hshQuery = new HashMap();
					arrValues=new ArrayList();
					//querycount++;
					intUpdatesize++;
					hshQuery.put("strQueryId","ins_misappdetails");
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
					arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
					arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
					arrValues.add("N");//Whether under Service Area Approach
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
					arrValues.add(strperappcity);
					arrValues.add(strperappdistrict);
					arrValues.add(strperappstate);
					arrValues.add(strorg_branchin);//Place - Metro
					arrValues.add("N"); //Does repayment depend purely on the asset financed
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
					arrValues.add("00");
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
					arrValues.add(strActCode);
					arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
					arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
					arrValues.add("1"); //Asset Classification
					arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
					arrValues.add("1"); //fac serial no
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_sharebroker")));
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
					strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
						strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
						strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
					}
					if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
					{
						strLoanType="LAA";
					}
					else if(strLoanType.equalsIgnoreCase("OD"))
					{
						strLoanType="ODA";
					}
					strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
					}
	 				
					String strAppStatus="";
					String strPriorityType="";
					String strPrioritySubsector="";
					String strWeakerSectionSubSector="";
					String strAgriIndConfig="";
					String strTwentyPointPgm="";
					String strSensitiveSector="";
					String strInfracode="";
					String strGovtAnnounceScheme="";
					String strClassiMaster_Sno="";
					String strActivityCode="";
					String strActivitySno="";
					HashMap hshPriority=new HashMap();
					String strFacilitySno="1";
					String strStandUpIndia="";

					hshValues.put("strFacilitySno",strFacilitySno);
					hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
					//hshValues.put("strHOLIDAYPERIOD","0");
					hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
					hshValues.put("hidapplicantnewid",strLAPSid);
					hshValues.put("strAppType","P");
					
					hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
					 
					 	//hshQueryValues=new HashMap();
						//hshQueryValues.put("size","1");
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						intUpdatesize++;
						hshQuery.put("strQueryId","ins_misappclassification_digi");
						arrValues.add(strApplicationNo);
						arrValues.add(strAgriIndConfig);
						arrValues.add(strPriorityType);
						arrValues.add(strPrioritySubsector);
						arrValues.add(strSensitiveSector);
						arrValues.add(strWeakerSectionSubSector);
						arrValues.add(strTwentyPointPgm);
						arrValues.add(strInfracode);
						arrValues.add(strGovtAnnounceScheme);
						arrValues.add(strClassiMaster_Sno);
						arrValues.add(strFacilitySno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
				  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
						
					String strAppend="",strmodeofadv="";
					strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
					strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
					}
					
					if(rs!=null)
						rs.close();
						String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
						strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
							freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
							freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
							freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
							finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
							finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
						}
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add(freeCode6);
					arrValues.add(freeCode7);
					arrValues.add(freeCode8);
					arrValues.add("01");//strModeOfOperation
					arrValues.add("E");//strDrawingPowerInd
					arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
					arrValues.add("N"); // Account Handoff
					arrValues.add("01");//strAdvanceNature
					arrValues.add(strAdvanceType);
					arrValues.add(strmodeofadv);
					arrValues.add("10"); //default 10
					arrValues.add("999"); //default 999
					arrValues.add(strsolid);
					arrValues.add(""); //Security Code
					arrValues.add(strintratefrq);
					arrValues.add(finfreeCode7);
					arrValues.add(finfreeCode8);
					arrValues.add(strlbrcode);
					arrValues.add(strFacilitySno);
					arrValues.add("Vehicle");
					arrValues.add(""); //facilityschemecode
					arrValues.add(""); //facility_glsubheadcode
					arrValues.add("99"); //laps free code 1
					arrValues.add("99"); //laps free code 2
					arrValues.add("99"); //laps free code 3
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_cbsdetails");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					//hshQueryValues.put("size",Integer.toString(intUpdatesize));
					//hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			  		
		
			  		
			  		
			  		if(Helper.correctNull((String) hshValues.get("strgstVerification")).equalsIgnoreCase("Y"))
					{
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();   
						hshQuery.put("strQueryId","ins_Veri_GSTVerifi");
						arrValues.add(strApplicationNo);
						arrValues.add(strLAPSid);
						arrValues.add("MC");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);	
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
					}
				 
				 
				 
				hshValues.put("strApplication", strApplicationNo);
				hshValues.put("strResponseCode", "LAPS-1010");
				hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForAutoLoan..."+e.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null) 
				{
					rs1.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
				if (rs3 != null) 
				{
					rs3.close();
				}
			} catch (Exception e) 
			{
				throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForAutoLoan in closing connection..."+e.toString());
			}
		}
		
		return hshValues;
		
	}
		
		public HashMap userOrganisationDetail(HashMap hshValues)  
		{
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null;
			String strQuery="",strInwardno="";
			
			try
			{	
				String strloginUserID=Helper.correctNull((String)hshValues.get("strloginUserID"));
				String struserorgcode="0";
				
				
				ArrayList arrappref4=new ArrayList();
				HashMap hashappref4=new HashMap();
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("setuserssel2^"+strloginUserID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("user_name",Helper.correctNull((String)rs.getString("usr_fname")));
					hshRecord.put("user_function",Helper.correctNull((String)rs.getString("usr_function")));
					hshRecord.put("user_designation",Helper.correctNull((String)rs.getString("user_designation")));
					hshRecord.put("user_department",Helper.correctNull((String)rs.getString("usr_department")));
					hshRecord.put("user_classpower",Helper.correctNull((String)rs.getString("usr_class")));
					hshRecord.put("user_group",Helper.correctNull((String)rs.getString("usr_grpid")));
					hshRecord.put("user_solid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					
					struserorgcode=Helper.correctNull((String)rs.getString("usr_orgcode"));
					
					if(!struserorgcode.equals("0"))
					{
						if(rs!=null){rs.close();}
						strQuery=SQLParser.getSqlQuery("setbrnchcheckuser^"+struserorgcode);
						rs=DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							hashappref4=new HashMap();
							hashappref4.put("Branchuser_name",Helper.correctNull((String)rs.getString("usr_fname")));
							hashappref4.put("Branchuser_function",Helper.correctNull((String)rs.getString("usr_function")));
							hashappref4.put("Branchuser_designation",Helper.correctNull((String)rs.getString("user_designation")));
							hashappref4.put("Branchuser_department",Helper.correctNull((String)rs.getString("usr_department")));
							hashappref4.put("Branchuser_classpower",Helper.correctNull((String)rs.getString("usr_class")));
							hashappref4.put("Branchuser_group",Helper.correctNull((String)rs.getString("usr_grpid")));
							hashappref4.put("Branchuser_solid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
							arrappref4.add(hashappref4);

						}
					}
				}

				ArrayList arrappref2=new ArrayList();
				ArrayList arrappref=new ArrayList();
				ArrayList arrappref3=new ArrayList();
				
				if(!struserorgcode.equals("0"))
				{
					HashMap hashappref=new HashMap();
				
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_org^"+struserorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						hashappref=new HashMap();
						hashappref.put("roUser_id", Helper.correctNull((String)rs.getString("USR_ID")));
						hashappref.put("roUser_name", Helper.correctNull((String)rs.getString("USR_FNAME")));
						hashappref.put("roUser_designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
						hashappref.put("roUser_classpower", Helper.correctNull((String)rs.getString("USR_CLASS")));
						hashappref.put("roUser_function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
						hashappref.put("roUser_department", Helper.correctNull((String)rs.getString("usr_department")));

						arrappref.add(hashappref);
					}
					
					HashMap hashappref2=new HashMap();
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_rlpc_delegatedauthoirty_org^"+struserorgcode.substring(0,6));
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						hashappref2=new HashMap();
						hashappref2.put("rlpcUser_id", Helper.correctNull((String)rs.getString("USR_ID")));
						hashappref2.put("rlpcUser_name", Helper.correctNull((String)rs.getString("USR_FNAME")));
						hashappref2.put("rlpcUser_designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
						hashappref2.put("rlpcUser_classpower", Helper.correctNull((String)rs.getString("USR_CLASS")));
						hashappref2.put("rlpcUser_function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
						hashappref2.put("rlpcUser_department", Helper.correctNull((String)rs.getString("usr_department")));

						arrappref2.add(hashappref2);
					}
					
					
					HashMap hashappref3=new HashMap();
					if(rs!=null){rs.close();}
					strQuery=SQLParser.getSqlQuery("sel_HO_delegatedauthoirty_org");
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						hashappref3=new HashMap();
						hashappref3.put("HOUser_id", Helper.correctNull((String)rs.getString("USR_ID")));
						hashappref3.put("HOUser_name", Helper.correctNull((String)rs.getString("USR_FNAME")));
						hashappref3.put("HOUser_designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
						hashappref3.put("HOUser_classpower", Helper.correctNull((String)rs.getString("USR_CLASS")));
						hashappref3.put("HOUser_function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
						hashappref3.put("HOUser_department", Helper.correctNull((String)rs.getString("usr_department")));

						arrappref3.add(hashappref3);
					}
					
					
					
					hshValues.put("user_details", hshRecord);
					hshValues.put("Branch_details", arrappref4);
					hshValues.put("RO_users", arrappref);
					hshValues.put("RLPC_users", arrappref2);
					hshValues.put("HO_users", arrappref3);
				
				}
				else
				{
					hshValues.put("user_details", "Data not found");
					hshValues.put("RO_users", arrappref);
					hshValues.put("RLPC_users", arrappref2);
					hshValues.put("HO_users", arrappref3);
				}
				

				

				
			
			}
			catch(Exception e)
			{
				throw new EJBException("Error in DigitalAppInterface Bean userOrganisationDetail..."+e.toString());
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
					throw new EJBException("Error in DigitalAppInterface Bean userOrganisationDetail in  closing connection ..."+e.toString());
				}
			}
			
			return hshValues;
		}
	

		
public HashMap hunterService(HashMap hshValues)  
		{
			HashMap hshQuery= new HashMap();
			HashMap hshRecord=new HashMap();
			ArrayList arrValues= new ArrayList();
			HashMap hshQueryValues= new HashMap();
			ResultSet rs=null,rs1=null,rs2=null,rs3=null;
			String	strInputJSONRequest="",line="",appid="",strClassificaton="",strDate="",strIdentifier="",strProduct="",strPan="",strFname="",
			strMacaAddr="",strMacaCity="",strMacaPin="",strMacaState="",strMapmaAddr="",strMapmaCity="",strMapmaState="",strMamtTelno="",strMabtTelno="",
			strMaemaEmail="",strMaiddocno="",strDocType="",strMapmaPin="",strCurrentDateTime="",appno="",strPrdCode="",strAppDate="";
			String strQuery="",strPerAppid="",brappno="",strdob="",strPanno="",strAadharNo="",defid="",cus_def_id="", values="",strDob="";
			appid=Helper.correctNull((String)hshValues.get("txt_cbscustid"));
			appno=Helper.correctNull((String)hshValues.get("")); 
			brappno=Helper.correctNull((String)hshValues.get("hidBRappno"));
	try{
		
		strQuery = SQLParser.getSqlQuery("getBureaudetails^"+brappno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strAppDate=Helper.correctNull((String)rs.getString("CREATED_DATE"));
			strPan=Helper.correctNull((String)rs.getString("BUR_PANNO"));
			strFname=Helper.correctNull((String)rs.getString("BUR_FNAME"));
			strdob=Helper.correctNull((String)rs.getString("BUR_DOB"));
			strMacaAddr=Helper.correctNull((String)rs.getString("BUR_ADDRESS1"));
			strMacaCity=Helper.correctNull((String)rs.getString("BUR_CITY"));
			strMacaPin=Helper.correctNull((String)rs.getString("BUR_ZIP"));
			strMacaState=Helper.correctNull((String)rs.getString("BUR_STATE"));
			strMapmaAddr=Helper.correctNull((String)rs.getString("BUR_ADDRESS2"));
			strMapmaCity=Helper.correctNull((String)rs.getString("BUR_CITY"));
			strMapmaState=Helper.correctNull((String)rs.getString("BUR_STATE"));
			strMamtTelno=Helper.correctNull((String)rs.getString("bur_mobile"));
			strMabtTelno=Helper.correctNull((String)rs.getString("bur_mobile"));
			strMaemaEmail=Helper.correctNull((String)rs.getString("BUR_EMAIL"));
			strMaiddocno=Helper.correctNull((String)rs.getString("BUR_PANNO"));
			strMapmaPin=Helper.correctNull((String)rs.getString("BUR_ZIP"));
			//strPrdCode=Helper.correctNull((String)rs.getString("app_prdcode"));
		}
			
		SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
		Date date=sdf.parse(strAppDate);
		String strAppdate=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(date);
		
		SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
		strCurrentDateTime=simpledateformat.format(new Date());
		
		SimpleDateFormat dob=new SimpleDateFormat("dd/MM/yyyy");
		Date dobdate=dob.parse(strdob);
		strDob=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dobdate);
		
		strQuery = SQLParser.getSqlQuery("sel_cbsid_per^"+appid);
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			strPerAppid=Helper.correctNull((String)rs2.getString("PERAPP_ID"));
		}
		
			strInputJSONRequest="{\"batchXml\": {\"header\": {\"count\": 1,\"originator\": \"KRNTK\"}, \"submissions\": {\"submission\": [ {\"appdte\": \""+strAppdate+"\",\"classification\": \"UNKNOWN\", \"date\": \""+strCurrentDateTime+"\", \"identifier\": \""+brappno+"\", \"product\": \"HL_D_IND\","+
			"\"ma\": {\"pan\": \""+strPan+"\", \"fstnme\": \""+strFname+"\",\"midnme\":\"\",\"lstnme\": \"\", \"dob\": \""+strDob+"\",\"age\": 0, \"gndr\": \"\", \"qual\": \"\", \"natcde\": \"\",\"maca\": {\"add\": \""+strMacaAddr+"\","+
			"\"ctry\": \"IND\",\"cty\": \""+strMacaCity+"\",\"pin\": \""+strMacaPin+"\",\"ste\": \""+strMacaState+"\"},\"mapma\": {\"add\": \""+strMapmaAddr+"\",\"ctry\": \"IND\",\"cty\": \""+strMapmaCity+"\",\"pin\": \""+strMapmaPin+"\",\"ste\": \""+strMapmaState+"\""+
			"},\"mamt\": {\"telno\": \""+strMamtTelno+"\"},\"mabt\": {\"telno\": \""+strMabtTelno+"\"},\"maema\": [{\"donam\": \"\",\"emaadd\": \""+strMaemaEmail+"\",\"usradd\": \"\"}],\"maid\": [{\"ackno\": \"\","+
			"\"cntryiss\": \"\",\"cotan\": \"\",\"docac\": \"\",\"docno\": \""+strPan+"\",\"doctyp\": \"PAN CARD\",\"ercpt\": \"\",\"expdt\": \"\",\"fhnme\": \"\",\"iddob\": \"\",\"issdt\": \"\","+
			"\"plciss\":\"\",\"subdte\": \"\"}],\"maemp\": [{\"empind\": \"\",\"empno\": \"\",\"empstrtdt\": \"\",\"empstt\": \"\",\"jobtitle\": \"\",\"orgnme\": \"orgname\"}]}}]}}}";

log.info("################@@@@@@@@@@@@@ hunterService Service request @@@@@@@@@@@@@################"+strInputJSONRequest);



// System.out.println("################@@@@@@@@@@@@@   Hunter Service URL  @@@@@@@@@@@@@################"+
URL url = new URL(ApplicationParams.getStrhunterurl());
log.info("Hunter Url=========== "+url);

HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
urlcon.setRequestProperty("User-Agent", "");
urlcon.setDoInput(true);
urlcon.setDoOutput(true);
urlcon.setRequestMethod("POST");
urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
urlcon.setRequestProperty("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsYXBzYXBwIjoidXBkYXRlZWxpZ2liaWxpdHlhcGkiLCJ0b2tlbiI6Im1nVlZOd0RIUnNSVUhweUVDemI4NXlTMkhLZzlqZWVqRER1WXVlQklLS2IyciIsImlhdCI6MTU3MTAzMDc4N30.CmTaWBsr1SxVzJrBHEZNLlcI5hUs5FRKn5kx9RxFYK4");
OutputStream outputStream = urlcon.getOutputStream();
OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");

BufferedWriter bWriter = new BufferedWriter(osw);
bWriter.write(strInputJSONRequest);
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

	log.info("################@@@@@@@@@@@@@ HunterService Response @@@@@@@@@@@@@################ "+ result.toString());
	
	
	JSONObject json = new JSONObject(result.toString());
	JSONObject matchSummary = json.getJSONObject("matchSummary");
	if(!(((String)matchSummary.get("totalMatchScore"))).equals("0"))
	{
	JSONObject errorWarnings = json.getJSONObject("errorWarnings");
	JSONObject warnings = errorWarnings.getJSONObject("warnings");
	
	JSONObject warning = warnings.getJSONObject("warning");
	String number=(String) warning.get("number");
	if(number.equals("102009"))
	{
	JSONObject submissionScores = matchSummary.getJSONObject("submissionScores");
	JSONObject scoreType = submissionScores.getJSONObject("scoreType");
	JSONObject scoreValue = scoreType.getJSONObject("scoreValue");
	 values=(String) scoreValue.get("value");

	hshQuery=new HashMap();
	arrValues=new ArrayList();
	
	hshQuery.put("strQueryId","upd_bureau_inwardreg");
	arrValues.add(values);
	arrValues.add(brappno);
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1", hshQuery);
	hshQueryValues.put("size","1");
	EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","upd_cus_defaulter");
	arrValues.add(values);
	arrValues.add(strPerAppid);
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1", hshQuery);
	hshQueryValues.put("size","1");
	EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	}	
	if(number.equals("104001"))
	{
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		values="0";
		hshQuery.put("strQueryId","upd_bureau_inwardreg");
		arrValues.add(values);
		arrValues.add(brappno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","upd_cus_defaulter");
		arrValues.add(values);
		arrValues.add(strPerAppid);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
	}
	}
	hshValues.put("strtotalScore", values);
	hshValues.put("alertFlag", "Y");
}

	BureauLinkBean burlink=new BureauLinkBean();
	hshValues=burlink.getBureauData(hshValues);

} 
 catch (Exception e) {
		System.out.println("Exception.....................HunterService");
		e.printStackTrace();
		throw new EJBException("Exception in hunterService ==="+e.getMessage());
		
	}
return hshValues;
}	
	
public HashMap updateEligibility(HashMap hshValues)  
{//updateEligibility
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null;
	String strQuery="",strInputJSONRequest="",strappid="",strresidualage="",strvaluationcost="",strtenor="",strmclr="",mllsamount="",strmclrtype="",
	line="",appno="",strrecalculatedloan="",strappliedloanamount="",stremi="",strtenure="",strroi="",strholidayperiod="",strprpoage="",mclrtabcode="",
	mclrtype="",strcreditrsikrate="",strfixedrate="";
	appno=Helper.correctNull((String)hshValues.get("appno"));
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	
 try{
	
	strQuery = SQLParser.getSqlQuery("sel_update_eligibility^"+appno);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		strappid=Helper.correctNull((String)rs.getString("inward_digiappno"));
		strvaluationcost=Helper.correctNull((String)rs.getString("phpa_site_valuation_cost"));
		strresidualage=Helper.correctNull((String)rs.getString("phpa_residual_life"));
		strtenor=Helper.correctNull((String)rs.getString("loan_premium_tenor"));
		mllsamount=Helper.correctNull((String)rs.getString("loan_premium_loan_amount"));
		strmclrtype=Character.toString(((Helper.correctNull((String)rs.getString("LOAN_MCLRTYPE"))).charAt(0)));
		strprpoage=Helper.correctNull((String)rs.getString("PHPA_PREMISES_AGE"));
	}
	strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+strmclrtype);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
	strmclr=Helper.correctNull((String)rs.getString("MCLR_BASERATESPREAD"));
	mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
	mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
	}
	
	strInputJSONRequest="\"{ \"applicationid\":\""+strappid+"\", \"propertyresidualage\":"+strresidualage+",\"valutationcost\":"+strvaluationcost+
	",�\"tenor\":"+strtenor+", �\"mclr\":"+strmclr+", \"mllsamount\":"+mllsamount+", \"propertyage\":"+strprpoage+"}\"";

		
		log.info("################@@@@@@@@@@@@@ Update Eligibility Service request @@@@@@@@@@@@@################"+strInputJSONRequest);
		
		//System.out.println("################@@@@@@@@@@@@@   Update Eligibility URL  @@@@@@@@@@@@@################"+
		URL url = new URL(ApplicationParams.getStrcalceligibilityurl());
		log.info("Update Eligibility Url=========== "+url);
		HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
		urlcon.setRequestProperty("User-Agent", "");
		urlcon.setDoInput(true);
		urlcon.setDoOutput(true);
		urlcon.setRequestMethod("POST");
		urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
		urlcon.setRequestProperty("Authorization","Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsYXBzYXBwIjoidXBkYXRlZWxpZ2lia WxpdHlhcGkiLCJ0b2tlbiI6Im1nVlZOd0RIUnNSVUhweUVDemI4NXlTMkhLZzlqZW VqRER1WXVlQklLS2IyciIsImlhdCI6MTU3MTAzMDc4N30.CmTaWBsr1SxVzJrBHE ZNLlcI5hUs5FRKn5kx9RxFYK4" );
		OutputStream outputStream = urlcon.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
		
		BufferedWriter bWriter = new BufferedWriter(osw);
		bWriter.write(strInputJSONRequest);
		bWriter.close();
		
		InputStream inputStream = urlcon.getInputStream();
		InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");
		BufferedReader rd = new BufferedReader(isreader);
		
		if (rd != null) {
		StringBuffer result = new StringBuffer();
		while ((line = rd.readLine()) != null) {
		result.append(line);
		}
		
		log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ result.toString());
		
		JSONObject json = new JSONObject(result);
		JSONArray loandetails=json.getJSONArray("loandetails");
		JSONObject recalculatedloan=loandetails.getJSONObject(0);
		JSONObject recalculatedloanValue=recalculatedloan.getJSONObject("Recalculatedloan");
		 strrecalculatedloan=recalculatedloanValue.toString();
		
		JSONObject appliedamnt=loandetails.getJSONObject(1);
		JSONObject appliedloanamount=appliedamnt.getJSONObject("appliedloanamount");
		 strappliedloanamount=appliedloanamount.toString();
		
		JSONObject emi=loandetails.getJSONObject(2);
		JSONObject emivalue=emi.getJSONObject("emi");
		 stremi=emivalue.toString();
		
		JSONObject tenure=loandetails.getJSONObject(3);
		JSONObject tenureValue=tenure.getJSONObject("tenure");
		 strtenure=tenureValue.toString();
		
		JSONObject roi=loandetails.getJSONObject(4);
		JSONObject roiValue=roi.getJSONObject("roi");
		 strroi=roiValue.toString();
		
		JSONObject holidayperiod=loandetails.getJSONObject(5);
		JSONObject holidayperiodValue=holidayperiod.getJSONObject("holidayperiodValue");
		 strholidayperiod=holidayperiodValue.toString();
		
		 JSONObject creditriskrate=loandetails.getJSONObject(6);
		 JSONObject creditriskratevalue=creditriskrate.getJSONObject("creditriskrate");
		  strcreditrsikrate=creditriskratevalue.toString();
		
		  JSONObject fixedrate=loandetails.getJSONObject(7);
		  JSONObject fixedrateValue=creditriskrate.getJSONObject("fixedrate");
		  strfixedrate=fixedrateValue.toString();
		  
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		hshQuery.put("strQueryId","updt_loan_dtls");
		arrValues.add(strrecalculatedloan);
		arrValues.add(strappliedloanamount);
		arrValues.add(stremi);
		arrValues.add(stremi);
		arrValues.add(strtenure);
		arrValues.add(strroi);
		arrValues.add("Y");
		arrValues.add(mclrtabcode);
		arrValues.add(mclrtype);
		arrValues.add(strcreditrsikrate);
		arrValues.add(strfixedrate);
		arrValues.add(appno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","updt_loan_secure_holiday");
		arrValues.add(strholidayperiod);
		arrValues.add(appno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		hshQueryValues.put("size","2");
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","updt_appraisalsanc_sanc_amnt");
		arrValues.add(strrecalculatedloan);
		arrValues.add(appno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("3",hshQuery);
		hshQueryValues.put("size","3");
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","updt_mpbf_eligibleamnt");
		arrValues.add(strrecalculatedloan);
		arrValues.add(appno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("4",hshQuery);
		hshQueryValues.put("size","4");
		
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		} 
		catch (Exception e) {
		System.out.println("Exception.....................Update Eligibility Service");
		e.printStackTrace();
		throw new EJBException("Exception in Update Eligibility ==="+e.getMessage());
		
		}
		return hshValues;
		}	


public HashMap cbsIdUnderVerification(HashMap hshValues)  
{

	
	ResultSet rs = null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	HashMap hshForVerification = null;
	HashMap hshCbsAlmFields=null;
	HashMap hshPanMod=null;
	String TypeCode="",idprooftype="",strCustId="";
	
	
	try
	{
		String strApplicantID=Helper.correctNull((String)hshValues.get("hidborrowid"));
		String strappno=Helper.correctNull((String)hshValues.get("strappno"));
		
		rs=DBUtils.executeLAPSQuery("sel_cbsIdCreation^"+strApplicantID);
		
		if(rs.next())
		{
				strCustId=Helper.correctNull(rs.getString("PERAPP_CBSID"));
				idprooftype=Helper.correctNull(rs.getString("idprooftype"));
		}
		if(idprooftype.equals("PANGIR"))
		{
			TypeCode="ID PROOF RETAIL";
		}
		else
		{
			TypeCode="BOTH RETAIL";
		
		
		
		
		hshValues.put("newCustId", strCustId);

				    hshForVerification = this.custIdVerification(hshValues);
				    
				    String strResCifId = Helper.correctNull((String)hshForVerification.get("strResCifId"));
				    String strResDesc = Helper.correctNull((String)hshForVerification.get("strResDesc"));
				    String strResStatus = Helper.correctNull((String)hshForVerification.get("strResStatus"));
			
				    hshValues.put("apistatus", strResStatus);
					hshValues.put("apistatusdesc", strResDesc);
					if(strResStatus.equalsIgnoreCase("SUCCESS"))
					{	
						hshCbsAlmFields=this.cbsAmlFields(hshValues);
						
					if(!TypeCode.equals("ID PROOF RETAIL"))
					{
					hshPanMod=custIdPanModification(hshValues);
					}
					
			   //logic for sms service
			    
			// if(strResStatus.equalsIgnoreCase("SUCCESS"))  
			  //{
		

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
									throw new EJBException("Exception in CbsIdCreationService ==="+e.getMessage());	
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
				    
				
			    
			    
			    hshValues.put("strResCifId", strResCifId);
			    hshValues.put("strResDesc", strResDesc);
			    hshValues.put("strResStatus", strResStatus);
			    
			    
			    	
			}
			hshValues=getDigiDecisionDetail(hshValues);
		
}		
	}catch (Exception ex) {
		// .LogWriter.log(LAPSLogLevel.ERROR,""+"Exception in cbsIDCreationService"
		// + ex);
		throw new EJBException("Error in cbsIDCreationService"+ex.toString());
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


public HashMap breCallFourService(HashMap hshValues)

{
	
	JSONObject data = new JSONObject();
	JSONObject objTable = new JSONObject();
	JSONObject dateofsavingdata = new JSONObject();
	
	HashMap hshVal = new HashMap();
	ArrayList arrValue = null;
	
	ArrayList atmwitwralarrValues=null;
	HashMap hshValue = new HashMap();
	HashMap hshValue1 = new HashMap();	
	HashMap applicantin = new HashMap();
	HashMap loanLimit = new HashMap();
	ArrayList appliedAmnt=new ArrayList();
	ArrayList netMonthlyIncome=new ArrayList();
	ArrayList propertytype=new ArrayList();
	ArrayList ageofproperty=new ArrayList();
	ArrayList valuationcost=new ArrayList();
	ArrayList applicantdetails=new ArrayList();
	
HashMap hshRecord=new HashMap();	
ResultSet rs=null,rs1=null,rs3=null;
HashMap hshQueryValues = new HashMap();
HashMap hshQuery = new HashMap();
ArrayList arrValues = new ArrayList();
String strRequestUUID,strMessageDateTime,strRequestId,strInputXMLRequest="",strStatus="",strMessageDate="",line="",loanAmnt="";

String lapsemi="",residenceType="",refId="",dob="",noOfDependent="",appCategory="",thickScore="",manualEmi="",cccId="",finApplican="",applicantType="",
 		thinScor="",borrowerRelation="",addCategory="",manualCheck="",moratoriumPeriod="", propertyAge="0",propertyType="",
 		benchMark="0",appliedLoanAmnt="",valuationCost="0", schemeType="",sanctionAmnt="", ownerShip="",recAmount="",demoId="",strMclrtype="",strTenure="",
 		loanServiced="",deviationFlag="",dateOfBirth="",applicanttype="",strDeviationReqLa="",strDeviationReqTr="",sanctionLoanAmnt="",morotoriumPeriod="",cifId="",
 		strthickScore="",strThinscore="",score="", strDeviationReqRC="",strDeviationReqIR="",strDeviationReqOC="",strDeviationReqMN="",strDeviationReqTR="",strDeviationReqRA="",strDeviationReqPF="";
int intmoratoriumPeriod=0,retirementAge=70,i=0,carpetArea=0,tenure=0;
double lapsRoi=0.00,incomeSum=0.00,loan_emi=0.00;
	String DIGI_NMI="",foir="0",nmimultiplier="60",roiPenalty="";
	String strmclr[]=null;

try
{
	//String strCbsID=Helper.correctInt((String)hshValues.get("strCustomerID"));
	/*SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	strMessageDateTime=simpledateformat.format(new Date());*/
	
	strRequestUUID =Helper.correctNull((String) hshValues.get("strappno"));
	
	rs3=DBUtils.executeLAPSQuery("sel_demotype^"+strRequestUUID);
	while(rs3.next())
	{

		demoId=Helper.correctNull((String)rs3.getString("DEMO_APPID"));
		applicanttype=Helper.correctNull((String)rs3.getString("demo_type"));
		finApplican=Helper.correctNull((String)rs3.getString("demo_includeincome"));
		strthickScore=Helper.correctDouble((String)rs3.getString("DIGI_THICKSCORE"));
		strThinscore=Helper.correctDouble((String)rs3.getString("DIGI_THINSCORE"));
		
		if(sanctionAmnt.equals("")){
		sanctionAmnt=appliedLoanAmnt;
		}
	
		//applicantdetails=new ArrayList();
		
		rs1=DBUtils.executeLAPSQuery("select_cuscibildetails^"+demoId);
		if(rs1.next())
		{	
			score=Helper.correctInt((String)rs1.getString("cibil_score"));
		}
		
		rs=DBUtils.executeLAPSQuery("sel_restype^"+demoId);
		if(rs.next())
		{
			residenceType=Helper.correctNull((String)rs.getString("con_restype"));
		}

	
	rs=DBUtils.executeLAPSQuery("sel_loan_details^"+strRequestUUID);
	if(rs.next())
	{
		lapsemi=Helper.correctNull(String.valueOf(rs.getString("DIGI_LAPSEMI")));
		lapsRoi=Double.parseDouble(Helper.correctDouble((String)(rs.getString("DIGI_DEVIATION_ROI_PENALTY"))));
	}
	
	if(lapsRoi==0.00)
		roiPenalty="N";	
	
	else
		roiPenalty="Y";
	
	if(applicanttype.equalsIgnoreCase("a")){
		applicantType="APPLICANT";
	}
	else if(applicanttype.equalsIgnoreCase("c")){
		applicantType="CO-APPLICANT";
		lapsemi="0";
		}
	else if(applicanttype.equalsIgnoreCase("g")){
		
		applicantType="GUARANTOR";
		lapsemi="0";
	}

	if(finApplican.equals("2")){
		finApplican="Y";
	}
	else if(finApplican.equals("1"))
		finApplican="N";

	if(residenceType.equals("1") || residenceType.equals("3"))
	{
		residenceType="Lease Rental";
	}
	else if(residenceType.equals("2"))
	{
		residenceType="Own";
	}
	else if(residenceType.equals("4"))
	{
		residenceType="Parent Owned";
	}
	else if(residenceType.equals("5"))
	{
		residenceType="Company Provided";
	}
	else
	{
		residenceType="Lease Rental";
	}
	
	rs=DBUtils.executeLAPSQuery("sel_perapp_dob^"+demoId);
	if(rs.next()){
		dateOfBirth=Helper.correctNull((String)rs.getString("PERAPP_DOB"));
		appCategory=Helper.correctNull((String)rs.getString("PERAPP_EMPLOYMENT"));
	}
	
/*	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yy");
	Date date=sdf.parse(dob);//yyyy-MM-dd
	dateOfBirth=new SimpleDateFormat("yyyy-MM-dd").format(date);*/
	//12-10-88

	if(appCategory.equals("1"))
	{
		appCategory="SALARIED";
	}
	else
	{
		appCategory="SEMP";
	}

	
	rs=DBUtils.executeLAPSQuery("sel_refid^"+strRequestUUID);
	if(rs.next()){
		cifId=Helper.correctNull((String)rs.getString("inward_digiappno"));
	}
		Date date=new Date();
		long milliTime=date.getTime();
		
	String applicantIn="{\"APPLICANTDETAILS\": {\"APPLICANTTYPE\": {\"data_type\": \"text\",\"value\": \""+applicantType+"\"}," +
			"\"CCCID\": {\"data_type\": \"text\",\"value\": \""+milliTime+"\"},\"FINANCIALAPPLICANT\": {\"data_type\": \"text\",\"value\": \""+finApplican+"\"}," +
			"\"NOOFDEPENDENTS\": {\"data_type\": \"numeric\",\"value\": 1},\"THICKSCORE\": {\"data_type\": \"numeric\",\"value\": "+strthickScore+"}," +
			"\"THINSCORE\": {\"data_type\": \"numeric\",\"value\": "+strThinscore+"},\"APPLICANTCATEGORY\": {\"data_type\": \"text\",\"value\": \""+appCategory+"\"}," +
			"\"DOB\": {\"data_type\": \"date\",\"date_format\": \"yyyy-MM-dd\",\"value\": \""+dateOfBirth+"\"},\"REFID\": {\"data_type\": \"text\",\"value\": \""+cifId+"\"},\"LAPSEMI\": { \"data_type\": \"numeric\",\"value\": "+lapsemi+"}," +
			"\"RELATIONSHIPWITHBORROWER\": {\"data_type\": \"text\",\"value\": \"\"},\"MANUALCHECK\": {\"data_type\": \"text\",\"value\": \"Y\"}," +
			"\"MANUALEMI\": {\"data_type\": \"numeric\",\"value\": 0.00}},\"CIBILOUT\": {\"TRADELINEDETAIL\": {\"value\": [{\"ACCOUNTTYPE\": {\"data_type\": \"text\",\"value\": \"\"}," +
			"\"DATEOPENEDORDISBURSED\": {\"data_type\": \"date\",\"value\": \"01011900\",\"date_format\": \"ddMMyyyy\"},\"HIGHCREDITORSANCTIONEDAMOUNT\": " +
			"{\"data_type\": \"numeric\",\"value\": 0},\"DATECLOSED\": {\"data_type\": \"date\",\"value\": \"01011900\",\"date_format\": \"ddMMyyyy\"}," +
			"\"SETTLEMENTAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"RATEOFINTEREST\": {\"data_type\": \"numeric\",\"value\": 0}," +
			"\"REPAYMENTTENURE\": {\"data_type\": \"numeric\",\"value\": 0},\"EMIAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0}}]}," +
			"\"SCOREDETAIL\": {\"SCORE\": {\"data_type\": \"numeric\",\"value\": "+score+"}}},\"PERFIOS\": {\"value\": [{}]},\"ITRFORM1\": {\"value\": [{   \"TOTALINCOME\": {\"data_type\": \"numeric\",\"value\": 0}}]}," +
			"\"ITRFORM2\": {\"value\": [{\"TOTALINCOME\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"ITRFORM3\": {\"value\": [{\"AGGREGATEINCOME\":" +
			" {\"data_type\": \"numeric\",\"value\": 0}   }]},\"ITRFORM4\": {\"value\": [{\"TOTALINCOME\": {\"data_type\": \"numeric\",\"value\": 0}," +
			"\"TOTALTAX\": {\"data_type\": \"numeric\",\"value\": 0}}]},\"EXPERIAN\": {\"ACCOUNTDETAILS\": {\"value\": [{   \"ACCOUNTTYPE\":" +
			" {\"data_type\": \"text\",\"value\": \"\"},\"DATEOPENED\": {\"data_type\": \"date\",\"date_format\": \"yyyyMMdd\",\"value\": \"19000101\"}  }]}}," +
			"\"ADDRESSDETAILS\": {\"ADDRESSCATEGORY\": {\"data_type\": \"text\",\"value\": \"SEMI_URBAN\"},\"RESIDENCETYPE\": {\"data_type\": \"text\",\"value\": \""+residenceType+"\"}}," +
			"\"FIWAIVER\": {\"ROIPENALTYFLAG\": {\"data_type\": \"text\",\"value\": \""+roiPenalty+"\"}}," +
			"\"LOANOBLIGATION\": {\"value\": [{\"EMI\": {\"data_type\": \"numeric\",\"value\":0},\"TENUREENDDATE\": {\"data_type\": \"date\",\"value\": \"1900-01-01\"}}   ]}}";
			applicantdetails.add(applicantIn);			
	}
		
	rs=DBUtils.executeLAPSQuery("sel_loan_details^"+strRequestUUID);
	if(rs.next())
	{
		appliedLoanAmnt=Helper.correctNull(String.valueOf(rs.getString("LOAN_AMTREQD")));
		strTenure=Helper.correctInt((String)(rs.getString("loan_reqterms")));
		lapsRoi=Double.parseDouble(Helper.correctDouble((String)(rs.getString("DIGI_DEVIATION_ROI_PENALTY"))));
		lapsemi=Helper.correctNull(String.valueOf(rs.getString("DIGI_LAPSEMI")));
		loan_emi=Double.parseDouble((Helper.correctDouble((String)(rs.getString("loan_emi")))));
		valuationCost=Helper.correctNull((String)rs.getString("LOAN_COSTLOANPRD"));
		DIGI_NMI=Helper.correctDouble((String)rs.getString("DIGI_NMI"));
		//propertyType=Helper.CLOBToString(rs.getClob("loan_purposeofloan"));
	}

	incomeSum=Double.parseDouble(DIGI_NMI);
	
	netMonthlyIncome=new ArrayList();
	
	netMonthlyIncome.add(incomeSum);
	netMonthlyIncome.add(0);
	netMonthlyIncome.add(0);
	netMonthlyIncome.add(0);
	netMonthlyIncome.add(0);
		
	rs=DBUtils.executeLAPSQuery("sel_emiandgrossrent^"+strRequestUUID);
	if(rs.next()){		
		strMclrtype=Helper.correctNull((String)rs.getString("loan_mclrtype"));		
	}
	
	strmclr=strMclrtype.split("@");
	rs=DBUtils.executeLAPSQuery("sel_mclrmaster_type^"+strmclr[0]);
	if(rs.next()){
		benchMark=Helper.correctDouble((String)rs.getString("MCLR_BASERATESPREAD"));
	}

	
	rs=DBUtils.executeLAPSQuery("securesel^"+strRequestUUID);
	if(rs.next()){
		moratoriumPeriod=Helper.correctNull((String)rs.getString("loan_noofinstallment"));
		 loanServiced=Helper.correctNull((String)rs.getString("loan_servised"));
	}
	 
	
	rs=DBUtils.executeLAPSQuery("sel_appdev_loan_det^"+strRequestUUID+"TR");
	if(rs.next())
	{
		strTenure=Helper.correctInt(String.valueOf(rs.getString("DEVIATION_NEWVALUE")));
		
		if(loanServiced.equalsIgnoreCase("y"))
		{
			// tenure=Integer.parseInt(strTenure)-Integer.parseInt(moratoriumPeriod);
			tenure=Integer.parseInt(strTenure);
			moratoriumPeriod="0";
		}
		else if(loanServiced.equalsIgnoreCase("n")|| loanServiced.equalsIgnoreCase("NA"))
		{
			tenure=Integer.parseInt(strTenure);
		}
		else
		{
			tenure=Integer.parseInt(strTenure);
		}
	}	
	else
	{
		if(loanServiced.equalsIgnoreCase("y"))
		{
			// tenure=Integer.parseInt(strTenure)-Integer.parseInt(moratoriumPeriod);
			tenure=Integer.parseInt(strTenure);
			moratoriumPeriod="0";
		}
		else if(loanServiced.equalsIgnoreCase("n")|| loanServiced.equalsIgnoreCase("NA"))
		{
			tenure=Integer.parseInt(strTenure);
		}
		else
		{
			tenure=Integer.parseInt(strTenure);
		}
	}
	
	
	rs=DBUtils.executeLAPSQuery("sel_appdev_loan_det^"+strRequestUUID+"^LA");
	if(rs.next())
	{
		sanctionAmnt=Helper.correctNull(String.valueOf(rs.getString("DEVIATION_NEWVALUE")));
	}	
	else
	{
		sanctionAmnt=appliedLoanAmnt;
	}
	

	rs = DBUtils.executeLAPSQuery("sel_appdev_loan_det^"+ strRequestUUID+"^RC");
	if(rs.next()){

			foir=(Helper.correctInt((String)rs.getString("DEVIATION_NEWVALUE")));
	}
	else
	{
		rs=DBUtils.executeLAPSQuery("sel_loan_details^"+strRequestUUID);
		if(rs.next())
		{
			foir=(Helper.correctInt((String)rs.getString("DIGI_DEVIATION_FOIR")));
		}
	}

	rs = DBUtils.executeLAPSQuery("sel_appdev_loan_det^"+ strRequestUUID+"^OC");
	if(rs.next()){

		nmimultiplier=(Helper.correctInt((String)rs.getString("DEVIATION_NEWVALUE")));
	}
	else
	{
		rs=DBUtils.executeLAPSQuery("sel_loan_details^"+strRequestUUID);
		if(rs.next())
		{		
			nmimultiplier=(Helper.correctInt((String)rs.getString("DIGI_NMI_MULTIPLIER")));	
		}
	}
	
	rs = DBUtils.executeLAPSQuery("sel_appdev_loan_det^"+ strRequestUUID+"^RA");
	if(rs.next()){
		retirementAge=Integer.parseInt(Helper.correctInt((String)rs.getString("DEVIATION_NEWVALUE")));
	}
	else
	{
		retirementAge=70;
	}
	
	rs=DBUtils.executeLAPSQuery("sel_ownership^"+strRequestUUID);
	if(rs.next()){
		ownerShip=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
	}
	

	rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+strRequestUUID);
	if(rs.next()){
		
		propertyAge=Helper.correctNull((String)rs.getString("PHPA_PREMISES_AGE"));
			//propertyType=Helper.correctNull((String)rs.getString("phpa_loan_purpose"));
			carpetArea=Integer.parseInt(Helper.correctInt((String)rs.getString("PHPA_FLOORSPACE_AREA")));
	}

	
	rs=DBUtils.executeLAPSQuery("sel_purpose_products^"+strRequestUUID);
	if(rs.next()){
		
		
			propertyType=Helper.correctNull((String)rs.getString("prd_purpose"));
			
	}
	
	
	if(propertyType.equals("C"))
	{
		propertyType="CONSTRUCTION";
	}
	else if(propertyType.equals("S"))
	{
		propertyType="SITE AND CONSTRUCTION";
	}
	else if(propertyType.equals("H"))
	{
		propertyType="READY HOME/FLAT";
	}
	else if(propertyType.equals("R"))
	{
		propertyType="RENOVATION";
	}
	
	
	rs = DBUtils.executeLAPSQuery("sel_devreq^"+ strRequestUUID);
	if(rs.next()){
		deviationFlag=Helper.correctNull((String)rs.getString("DEVIATION_REQ"));
	}
	deviationFlag="Y";
	
	
	
	

	String strStringrequest="{\"DAJSONDocument\": {\"OCONTROL\": {\"ALIAS\": {\"data_type\": \"text\",\"value\": \"KBHL\"},\"SIGNATURE\": {\"data_type\": \"text\",\"value\": \"KBHL\"}," +
			"\"EDITION\": {\"data_type\": \"numeric\",\"value\": 142},\"OBJECTIVE\": {\"data_type\": \"text\",\"value\": \"KBHL MAIN FLOW\"}," +
			"\"EDITIONDATE\": {\"data_type\": \"date\",\"value\": \"2020-02-04\"},\"ERRORCOUNT\": {\"data_type\": \"text\",\"value\": \"0\"}},\"KBHLIN\":" +
			" {\"APPLICANTIN\": {\"value\":"+applicantdetails+" },\"APPLICATIONIN\": {	\"NMIMULTIPLIER\": {\"data_type\": \"numeric\",\"value\": "+nmimultiplier+"},	 \"LAPSDEVIATIONFLAG\": {\"data_type\": \"text\",\"value\": \""+deviationFlag+"\"},	 \"FOIR\": {\"data_type\": \"numeric\",\"value\": "+foir+"}, \"LAPSROI\": {\"data_type\": \"numeric\",\"value\": "+lapsRoi+"},	 \"RETIREMENTAGE\": {\"data_type\": \"numeric\",\"value\":"+retirementAge+"},	 \"LAPSTENURE\": {\"data_type\": \"numeric\",\"value\": "+tenure+"},\"CALLSEGMENTATION\": {\"value\": 4,\"data_type\": \"numeric\"},\"LOANDETAIL\": {\"SANCTIONEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": "+sanctionAmnt+"},\"NETMONTHLYINCOME\": {\"data_type\": \"numeric\",\"value\":"+netMonthlyIncome+"},\"BENCHMARK\": {\"data_type\": \"numeric\",\"value\": "+benchMark+"},\"MORATORIUMPERIOD\": {\"data_type\": \"numeric\",\"value\": "+moratoriumPeriod+"},\"SCHEMETYPE\": {\"data_type\": \"text\",\"value\": \"GENERAL\"},\"HOUSEHOLDINCOME\": {\"data_type\": \"numeric\",\"value\": 0}},\"PROPERTYMASTER\": {\"CARPETAREA\": {\"data_type\": \"numeric\",\"value\": "+carpetArea+"},\"OWNERSHIP\": {\"data_type\": \"text\",\"value\": \""+ownerShip+"\"},\"PROPERTYTYPE\": {\"data_type\": \"text\",\"value\": \""+propertyType+"\"},\"AGEOFPROPERTY\": {\"data_type\": \"numeric\",\"value\": "+propertyAge+"}, \"VALUATIONCOST\": {\"data_type\": \"numeric\",\"value\": "+valuationCost+"}},\"SOURCINGDETAILS\": {\"APPLIEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": "+appliedLoanAmnt+"}   }}},\"KBHLOUT\": {\"APPLICANTOUT\": {\"value\": [{\"ADDITIONALINCOMEERROR\": {\"data_type\": \"text\",\"value\": []},\"APPLICANTCATEGORY\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY1\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY10\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY11\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY12\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY13\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY14\": {\"data_type\": \"numeric\",\"value\": 2},\"APPLICANTOUTDUMMY15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY16\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY17\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY18\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY19\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY2\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY20\": {\"data_type\": \"date\",\"date_format\": \"yyyy-MM-dd\",\"value\": \"2019-04-24\"},\"APPLICANTOUTDUMMY21\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY22\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY23\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY24\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY25\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY26\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY27\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY28\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY29\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY3\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY30\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY31\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY32\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY33\": {\"data_type\": \"text\",\"value\": \"\"},\"EXISTING_EMI\": {\"value\": []},\"APPLICANTOUTDUMMY35\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY36\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY37\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY38\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY39\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICANTOUTDUMMY4\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY40\": {\"data_type\": \"date\",\"date_format\": \"yyyy-MM-dd\",\"value\": \"2019-04-24\"},\"APPLICANTOUTDUMMY5\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY6\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY7\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY8\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICANTOUTDUMMY9\": {\"data_type\": \"text\",\"value\": \"\"},\"CCCID\": {\"value\": \"Z\"},\"DECISION\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONCATEGORY\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONCOMPONENTTREENAME\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONREASONCODE\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONSETTERNAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"DEVIATIONCODE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"DEVIATIONLEVEL\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"DEVIATIONLEVELTABLE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"FIADDRESSWAIVER\": {\"value\": [\"\",\"\",\"\",\"\",\"\"]},\"FIEMPLOYMENTWAIVER\": {\"value\": [\"\",\"\",\"\",\"\",\"\"]},\"INDEXTABLECOMPONENTNAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"INDEXTABLECOMPONENTTREENAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"INDIVIDUALAPPLICANTERROR\": {\"data_type\": \"text\",\"value\": \"\"},\"ITRPANERROR\": {\"data_type\": \"text\",\"value\": []},\"ITRPERCSHAREERROR\": {\"data_type\": \"text\",\"value\": []},\"ITRREMUNERATIONERROR\": {\"data_type\": \"text\",\"value\": []},\"LIVINGEXPERROR\": {\"data_type\": \"text\",\"value\": \"\"},\"NETMONTHLYINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"SORTEDDECISIONTABLE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"SORTEDREASONCODETABLE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THICKSCORE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THICKSCORENAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THICKSCORINGRESULTTABLE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THINSCORE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THINSCORENAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"THINSCORINGRESULTTABLE\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"VALUESETTERCOMPONENTNAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"VALUESETTERCOMPONENTTREENAME\": {\"value\": [\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"EXISTINGEMI\": {\"data_type\": \"text\",\"value\": [\"6602.37\",\"0\"]}}]},\"APPLICATIONOUT\": {\"APPLICATIONOUTOUTDUMMY1\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY10\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY11\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY12\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY13\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY14\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY15\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY16\": {\"data_type\": \"numeric\",\"value\": 6602.37},\"APPLICATIONOUTOUTDUMMY17\": {\"data_type\": \"numeric\",\"value\": 6602},\"APPLICATIONOUTOUTDUMMY18\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY19\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY2\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY20\": {\"data_type\": \"date\",\"date_format\": \"yyyy-MM-dd\",\"value\": \"2019-04-24\"},\"APPLICATIONOUTOUTDUMMY21\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY22\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY23\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY24\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY25\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY26\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY27\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY28\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY29\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY3\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY30\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY31\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY32\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY33\": {\"data_type\": \"text\",\"value\": \"2.15\"},\"APPLICATIONOUTOUTDUMMY34\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY35\": {\"data_type\": \"numeric\",\"value\": 0},\"APPLICATIONOUTOUTDUMMY36\": {\"data_type\": \"numeric\",\"value\": 0.6},\"APPLICATIONOUTOUTDUMMY37\": {\"data_type\": \"numeric\",\"value\": 1},\"APPLICATIONOUTOUTDUMMY38\": {\"data_type\": \"numeric\",\"value\": 2},\"APPLICATIONOUTOUTDUMMY39\": {\"data_type\": \"numeric\",\"value\": 2057011.86},\"APPLICATIONOUTOUTDUMMY4\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY40\": {\"data_type\": \"date\",\"date_format\": \"yyyy-MM-dd\",\"value\": \"2019-04-24\"},\"APPLICATIONOUTOUTDUMMY5\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY6\": {\"data_type\": \"text\",\"value\": \"39260\"},\"APPLICATIONOUTOUTDUMMY7\": {\"data_type\": \"text\",\"value\": \"Y\"},\"APPLICATIONOUTOUTDUMMY8\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLICATIONOUTOUTDUMMY9\": {\"data_type\": \"text\",\"value\": \"\"},\"APPLIEDLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"APPSCORE\": {\"data_type\": \"text\",\"value\": \"\"},\"APPSCOREBAND\": {\"data_type\": \"text\",\"value\": \"\"},\"APPSCORECARDELEMENT\": {\"data_type\": \"text\",\"value\": \"\"},\"APPSCORINGRESULTTABLE\": {\"data_type\": \"numeric\",\"value\": 0},\"DECISION\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONCATEGORY\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONCOMPONENTTREENAME\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONREASONCODE\": {\"data_type\": \"text\",\"value\": \"\"},\"DECISIONSETTERNAME\": {\"data_type\": \"text\",\"value\": \"\"},\"DEVIATIONCODE\": {\"data_type\": \"text\",\"value\": \"\"},\"DEVIATIONLEVEL\": {\"data_type\": \"text\",\"value\": \"\"},\"DEVIATIONLEVELTABLE\": {\"data_type\": \"text\",\"value\": \"\"},\"DSCRELIGIBLEINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"DSCRIMPUTEDINCOME\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILITY\": {\"ELIGIBILELOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY1\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY2\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY3\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBILTYDUMMY4\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBLEFOIR\": {\"data_type\": \"numeric\",\"value\": 0},\"ELIGIBLEINCOME\": {\"data_type\": \"numeric\",\"value\": 16953.54},\"EMICALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"FOIRCALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"INCOMEMETHOD\": {\"data_type\": \"text\",\"value\": \"\"},\"LOANAMOUNTCALCULATED\": {\"data_type\": \"numeric\",\"value\": 0},\"INTERESTRATE\": {\"data_type\": \"numeric\",\"value\": 8.78},\"MAXFOIR\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXLOANAMOUNT\": {\"data_type\": \"numeric\",\"value\": 2057011.86},\"MARGIN\": {\"data_type\": \"numeric\",\"value\": 4000000},\"MORATORIUMPERIOD\": {\"data_type\": \"numeric\",\"value\": 0},\"TENURE\": {\"data_type\": \"numeric\",\"value\": 300},\"MARGINPERCENTAGE\": {\"data_type\": \"numeric\",\"value\": 58.86}},\"EMI\": {\"data_type\": \"numeric\",\"value\": 0},\"FULLPROCESSINGFEE\": {\"data_type\": \"numeric\",\"value\": 0},\"METRONONMETRO\": {\"data_type\": \"text\",\"value\": \"\"},\"PARTIALPROCESSINGFEE\": {\"data_type\": \"numeric\",\"value\": 0},\"SORTEDDECISIONTABLE\": {\"data_type\": \"text\",\"value\": \"\"},\"SORTEDREASONCODETABLE\": {\"data_type\": \"text\",\"value\": \"\"},\"TENUREAPPLIED\": {\"data_type\": \"numeric\",\"value\": 0},\"MAXEMISOURCE\": {\"data_type\": \"text\",\"value\": [\"<APPLICANT1>EMI: 6602.37;EMISOURCE: CIBIL<TRADELINES>ACCOUNTTYPE: 02;DATEOPENED: 20160208;DATECLOSED: 19000101;OWNERSHIPINDICATOR: 3;ROI: 0;TENURE: 168;SANCTIONEDAMOUNT: 1700000;CURRENTBALANCE: 1459618;EMIBUREAU: 0;EMI: </TRADELINES> <TRADELINES>ACCOUNTTYPE: 06;DATEOPENED: 20181025;DATECLOSED: 19000101;OWNERSHIPINDICATOR: 1;ROI: 0;TENURE: 144;SANCTIONEDAMOUNT: 375000;CURRENTBALANCE: 364309;EMIBUREAU: 0;EMI: 5628.29</TRADELINES> <TRADELINES>ACCOUNTTYPE: 10;DATEOPENED: 20170428;DATECLOSED: 19000101;OWNERSHIPINDICATOR: 1;ROI: 0;TENURE: 0;SANCTIONEDAMOUNT: 36030;CURRENTBALANCE: 5893;EMIBUREAU: 0;EMI: </TRADELINES> <TRADELINES>ACCOUNTTYPE: 05;DATEOPENED: 20160127;DATECLOSED: 19000101;OWNERSHIPINDICATOR: 1;ROI: 0;TENURE: 48;SANCTIONEDAMOUNT: 35000;CURRENTBALANCE: 7298;EMIBUREAU: 0;EMI: 974.08</TRADELINES> <TRADELINES>ACCOUNTTYPE: 06;DATEOPENED: 20150805;DATECLOSED: 20181023;OWNERSHIPINDICATOR: 1;ROI: 0;TENURE: 120;SANCTIONEDAMOUNT: 68000;CURRENTBALANCE: 0;EMIBUREAU: 0;EMI: </TRADELINES> \",\"<APPLICANT2>EMI: 0;EMISOURCE: \"]},\"CATEGORY\": {\"data_type\": \"text\",\"value\": \"\"},\"PMAYBIR\": {\"data_type\": \"text\",\"value\": \"\"}}}}}";
		
	System.out.print(strStringrequest);
	log.info("################@@@@@@@@@@@@@ BRE call4 Request @@@@@@@@@@@@@################ "+strStringrequest);
	URL bre_url = new URL(ApplicationParams.getStrbreurl());
	log.info("BRE call4 Url=========== "+bre_url);
	HttpURLConnection bre_urlcon = (HttpURLConnection) bre_url.openConnection();
	bre_urlcon.setRequestProperty("User-Agent", "");
	bre_urlcon.setDoInput(true);
	bre_urlcon.setDoOutput(true);
	bre_urlcon.setRequestMethod("POST");
	bre_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
	bre_urlcon.setRequestProperty("Authorization", "Basic");
	OutputStream bre_outputStream = bre_urlcon.getOutputStream();
	OutputStreamWriter bre_osw = new OutputStreamWriter(bre_outputStream, "UTF8");
		
	BufferedWriter bre_bWriter = new BufferedWriter(bre_osw);
	bre_bWriter.write(strStringrequest);
	bre_bWriter.close();

	InputStream bre_inputStream = bre_urlcon.getInputStream();
	InputStreamReader bre_isreader = new InputStreamReader(bre_inputStream,"UTF-8");
		
	BufferedReader bre_rd = new BufferedReader(bre_isreader);

	if (bre_rd != null) {
		StringBuffer bre_result = new StringBuffer();
		while ((line = bre_rd.readLine()) != null) {
			bre_result.append(line);
		}
		log.info("################@@@@@@@@@@@@@ BRE Call4 Response @@@@@@@@@@@@@################"
						+ bre_result.toString());
       
	    JSONObject json= new  JSONObject(bre_result.toString());
	    JSONObject response= json.getJSONObject("DAJSONDocument");
	    JSONObject breresult= response.getJSONObject("KBHLOUT");
	    JSONObject applicationOut= breresult.getJSONObject("APPLICATIONOUT");
	    JSONObject eligibility= applicationOut.getJSONObject("ELIGIBILITY");
	   
	    JSONObject maxLoanAmount=eligibility.getJSONObject("MAXLOANAMOUNT");
	    
	    String maxLoanAmountValue=String.valueOf( maxLoanAmount.get("value"));
	    
	    JSONObject tenureobj=eligibility.getJSONObject("TENURE");
	    String tenureValue=String.valueOf(tenureobj.get("value"));
	     
	    Double dbltenor=Double.parseDouble(tenureValue);
	    
	    tenureValue=String.valueOf(dbltenor.intValue());
	    
	  //CALCULATEDMAXLOAN
	    JSONObject calculatedmaxloan=eligibility.getJSONObject("CALCULATEDMAXLOAN");
	    String calculatedmaxloanValue=String.valueOf(calculatedmaxloan.get("value"));
	    
	    
	   JSONObject marginpercentage=eligibility.getJSONObject("MINIMUMMARGIN");
	   String marginpercentageValue=String.valueOf(marginpercentage.get("value"));
	   
	   JSONObject repaymentemi=applicationOut.getJSONObject("REPAYMENTEMI");
	   String strrepaymentemi=String.valueOf(repaymentemi.get("value"));
	   
	   JSONObject maxEmi=applicationOut.getJSONObject("REPAYMENTEMI");
	   String maxEmiValue=String.valueOf(maxEmi.get("value"));
	   
	   JSONObject roiCsp=applicationOut.getJSONObject("APPLICATIONOUTOUTDUMMY34");
	   String roiCspValue=String.valueOf(roiCsp.get("value"));
	   
	   JSONObject roiMixed=applicationOut.getJSONObject("APPLICATIONOUTOUTDUMMY38");
	   String roiFixedValue=String.valueOf(roiMixed.get("value"));
	   
	   JSONObject foirObj=applicationOut.getJSONObject("APPLICATIONOUTOUTDUMMY36");
	   String foirValue=Helper.correctDouble(String.valueOf(foirObj.get("value")));
	   
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(0);
		nf.setMaximumFractionDigits(0);
		nf.setGroupingUsed(false);
	   
	   Double dblfoirValue=Double.parseDouble(foirValue);
	   dblfoirValue=dblfoirValue*100;
	   foirValue=nf.format(dblfoirValue);
	   
	   FinacleInterfaceBean getAccountFlatFileReportObj=new FinacleInterfaceBean();

	   LimitofLoanBean limitOfLoan=new LimitofLoanBean();
	   loanLimit= limitOfLoan.getData(hshValues);
   
	   hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_bre_loandetails");
		arrValues.add(maxEmiValue);
		arrValues.add(roiCspValue);
		arrValues.add(roiFixedValue);
		arrValues.add(strrepaymentemi);
		arrValues.add(calculatedmaxloanValue);
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	   	   
	  
rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^LA");
if (rs.next()) {
	strDeviationReqLa = Helper.correctNull((String) rs.getString("deviation_req"));		
}
if(strDeviationReqLa.equalsIgnoreCase("Y"))
{
	  hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_app_dev");
		arrValues.add(maxLoanAmountValue);
		arrValues.add("LA");
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
}
else
{
	
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("LA");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("LA");
	arrValues.add(loanLimit.get("amtreq"));
	arrValues.add(maxLoanAmountValue);
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}

rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^TR");
if (rs.next()) {
		strDeviationReqTR = Helper.correctNull((String) rs.getString("deviation_req"));
	}

	if(strDeviationReqTR.equalsIgnoreCase("Y"))
	{	
		
		if(loanServiced.equalsIgnoreCase("y"))
		{
			 tenure=Integer.parseInt(tenureValue)+Integer.parseInt((moratoriumPeriod));
		}
		else
		{
			tenure=Integer.parseInt(tenureValue);
		}
		
		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_app_dev");
		arrValues.add(String.valueOf(tenure));
		arrValues.add("TR");
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
}
else	
{
	if(loanServiced.equalsIgnoreCase("y"))
	{
		 tenure=Integer.parseInt(tenureValue)+Integer.parseInt((moratoriumPeriod));
	}
	else
	{
		tenure=Integer.parseInt(tenureValue);
	}
	
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("TR");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("TR");
	arrValues.add(loanLimit.get("loan_reqterms"));
	arrValues.add(String.valueOf(tenure));
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}
	
	
rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^MN");
if (rs.next()) {

	strDeviationReqMN = Helper.correctNull((String) rs.getString("deviation_req"));
}

if(strDeviationReqMN.equalsIgnoreCase("Y"))
{	
		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_app_dev");
		arrValues.add(marginpercentageValue);
		arrValues.add("MN");
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
}
else	
{
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("MN");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("MN");
	arrValues.add(Helper.correctInt((String)loanLimit.get("margin")));
	arrValues.add(marginpercentageValue);
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}

rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^OC");
if (rs.next()) {
	strDeviationReqOC = Helper.correctNull((String) rs.getString("deviation_req"));
}

if(!strDeviationReqOC.equalsIgnoreCase("Y"))
{
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("OC");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("OC");
	arrValues.add("60");
	arrValues.add("60");
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}

rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^RA");
if (rs.next()) 
	 {
			strDeviationReqRA = Helper.correctNull((String) rs.getString("deviation_req"));
		}

if(!strDeviationReqRA.equalsIgnoreCase("Y"))		
{
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("RA");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("RA");
	arrValues.add("70");
	arrValues.add("70");
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}
	
rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^PF");
if (rs.next()) 
	 {
			strDeviationReqPF = Helper.correctNull((String) rs.getString("deviation_req"));
		}

if(!strDeviationReqPF.equalsIgnoreCase("Y"))		
{
	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("PF");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("PF");
	arrValues.add(loanLimit.get("LOAN_DIGI_TOT_PROCESSINGFEE"));
	arrValues.add(loanLimit.get("LOAN_DIGI_TOT_PROCESSINGFEE"));
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}

rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^RC");
if (rs.next()) {
			strDeviationReqRC = Helper.correctNull((String) rs.getString("deviation_req"));
		}
if(strDeviationReqRC.equalsIgnoreCase("Y"))
{	
		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_app_dev");
		arrValues.add(foirValue);
		arrValues.add("RC");
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
}
else	
{

	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("RC");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("RC");
	arrValues.add(loanLimit.get("DIGI_DEVIATION_FOIR"));
	arrValues.add(foirValue);
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
}
	
	
	
	
	
 
rs = DBUtils.executeLAPSQuery("sel_deviationreq^" + strRequestUUID+"^IR");
if (rs.next()) {
	strDeviationReqIR = Helper.correctNull((String) rs.getString("deviation_req"));
}
		
	String mclrtype="",mclrtabcode="",strQuery="";
	double mclrbaserate=0.00;
	strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+strmclr[0]);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		mclrbaserate=(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
	}
	
	double tot_intrate=0.00;
	tot_intrate= (mclrbaserate) + Double.parseDouble(roiFixedValue) + Double.parseDouble(roiCspValue) + lapsRoi;

if(strDeviationReqIR.equalsIgnoreCase("Y"))
{	

		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_app_dev");
		arrValues.add(String.valueOf(tot_intrate));
		arrValues.add("IR");
		arrValues.add(strRequestUUID);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
}
else	
{

	hshQueryValues=new HashMap();
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","del_app_deviation");
	arrValues.add(strRequestUUID);
	arrValues.add("IR");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	
	hshQuery=new HashMap();
	arrValues=new ArrayList();
	hshQuery.put("strQueryId","ins_app_dev");
	arrValues.add(strRequestUUID);
	arrValues.add("IR");
	arrValues.add(loanLimit.get("loan_intrate"));
	arrValues.add(String.valueOf(tot_intrate));
	arrValues.add("N");
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("2",hshQuery);
	hshQueryValues.put("size","2");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
	
 }
	
	if(Helper.correctNull((String) hshValues.get("hidPageId")).equals("perloan"))
	{
		PerApplicantBean perapp=new PerApplicantBean();
		hshQuery=perapp.getLoanProducts(hshValues);
	}
	else
	{
		LimitofLoanBean limit=new LimitofLoanBean();
		hshQuery=limit.getData(hshValues);
	}
	hshQuery.put("alert", "Alert");
}

catch (ParserConfigurationException pce) {
		System.out
				.println("ParserConfigurationException.....................BRE call4");
		pce.printStackTrace();
		
		throw new EJBException("Exception in BRE call4 ==="+pce.getMessage());


	} catch (SAXException se) {
		System.out.println("SAXException.....................BRE call4");
		se.printStackTrace();
		
		throw new EJBException("Exception in BRE call4 ==="+se.getMessage());
	} catch (IOException ioe) {
		System.out.println("IOException.....................BRE call4");
		ioe.printStackTrace();
		throw new EJBException("Exception in BRE call4 ==="+ioe.getMessage());
	} catch (Exception e) {
		System.out.println("Exception.....................BRE call4");
		e.printStackTrace();
		throw new EJBException("Exception in BRE call4 ==="+e.getMessage());
		
	}

return hshQuery;	
}

public HashMap applicationDedupe(HashMap hshValues)

{
HashMap hshRecord=new HashMap();	
ResultSet rs=null,rs1=null;
String strPan="",strQuery="",docpagetype="",appId="";
ArrayList arrCol=new ArrayList();

String line="",appstatus="",applicationrefnumber="";

try
{
	 strPan=Helper.correctNull((String)hshValues.get("panNo"));
	 appId=Helper.correctNull((String)hshValues.get("appId"));

	 
String strStringrequest="{\"pan\":\""+strPan+"\",\"custid\":\""+appId+"\"}";	

log.info("################@@@@@@@@@@@@@ applicationDedupe Request @@@@@@@@@@@@@################ "+strStringrequest);
URL appDedupe_url = new URL(ApplicationParams.getStrcalceligibilityurl());
log.info(" applicationDedupe Url=========== "+appDedupe_url);
HttpURLConnection appDedupe_urlcon = (HttpURLConnection) appDedupe_url.openConnection();
appDedupe_urlcon.setRequestProperty("User-Agent", "");
appDedupe_urlcon.setDoInput(true);
appDedupe_urlcon.setDoOutput(true);
appDedupe_urlcon.setRequestMethod("POST");
appDedupe_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
appDedupe_urlcon.setRequestProperty("Authorization",ApplicationParams.getStrappdedupe());
OutputStream dedupe_outputStream = appDedupe_urlcon.getOutputStream();
OutputStreamWriter dedupe_osw = new OutputStreamWriter(dedupe_outputStream, "UTF8");
	
BufferedWriter dedupeWriter = new BufferedWriter(dedupe_osw);
dedupeWriter.write(strStringrequest);
dedupeWriter.close();

InputStream dedupeStream = appDedupe_urlcon.getInputStream();
InputStreamReader dedupe_isreader = new InputStreamReader(dedupeStream,"UTF-8");

BufferedReader dedupe_rd = new BufferedReader(dedupe_isreader);

if (dedupe_rd != null) {
	StringBuffer dedupe_result = new StringBuffer();
	while ((line = dedupe_rd.readLine()) != null) {
		dedupe_result.append(line);
	}
	log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"
					+ dedupe_result.toString());
   	
	
	JSONObject json= new  JSONObject(dedupe_result.toString());
	String responseStatus= (String) json.get("status");
	if(responseStatus.equals("APP_200"))
	{
		  appstatus= (String)json.get("appstatus");
		 applicationrefnumber=(String)json.get("applicationrefnumber");			
	}	
	else if(responseStatus.equals("APP_201"))
	{
		  appstatus= (String)json.get("status_msg");
	}
	hshValues.put("appstatus",appstatus);
	hshValues.put("applicationrefnumber",applicationrefnumber );
	
}
}

catch(Exception e)
{
	throw new EJBException("Exception in applicationDedupe ========"+e.getMessage());
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
return hshValues;
}
public HashMap amberRule(HashMap hshValues)
{
	String appNo="",appHolder="",line="",appId="",strQuery="",limit="",period="",benchmark="",creditrisk="",
	spread="",roi="",amberstatus="",approvedorrejectedby="",emi="",LOAN_NOOFINSTALLMENT="";
	ResultSet rs=null,rs1=null;
	HashMap hshQuery = new HashMap(); 
	HashMap hshQueryValues = new HashMap();
	ArrayList arrValues = new ArrayList();
	ArrayList approveValues = new ArrayList();
	try
	{
		String strCurrentDate=Helper.getCurrentDateTime();
		appNo=Helper.correctNull((String)hshValues.get("appno"));
		appHolder=Helper.correctNull((String)hshValues.get("strUserId"));
		amberstatus=Helper.correctNull((String) hshValues.get("hidAction"));
		//appId=Helper.correctNull((String)hshValues.get("hid_approved_appid"));
		hshQuery = new HashMap();
		hshQueryValues = new HashMap();
		arrValues = new ArrayList();
		
		rs=DBUtils.executeLAPSQuery("sel_loandetails_amber^"+appNo);
		if(rs.next())
		{ //loan_recmdamt,loan_reqterms,loan_baserate,LOAN_CREDITRSKVAL,loan_busstatval,LOAN_MODINTRATE,loan_emi
			limit=Helper.correctNull((String)rs.getString("LOAN_AMTREQD"));
			period=Helper.correctNull((String)rs.getString("loan_reqterms"));
			benchmark=Helper.correctNull((String)rs.getString("loan_baserate"));
			creditrisk=Helper.correctNull((String)rs.getString("LOAN_CREDITRSKVAL"));
			spread=Helper.correctNull((String)rs.getString("loan_busstatval"));
			roi=Helper.correctNull((String)rs.getString("LOAN_MODINTRATE"));
			emi=Helper.correctNull((String)rs.getString("loan_emi"));	
			LOAN_NOOFINSTALLMENT=Helper.correctNull((String)rs.getString("LOAN_NOOFINSTALLMENT"));	
			
		}
		
		
		if(!amberstatus.equalsIgnoreCase("UNDO"))
		{
		//amberstatus="Approved";
		approvedorrejectedby=appHolder;
		String request="{\"applicationrefnumber\":\""+appNo+"\",\"limit\":"+limit+",\"period\":"+period+",\"holidayperiod\":"+LOAN_NOOFINSTALLMENT+",\"benchmark\":"+benchmark+",\"creditrisk\":"+creditrisk+",\"spread\":"+spread+",\"roi\":"+roi+",\"amberstatus\":\""+amberstatus+"\",\"approvedorrejectedby\":\""+approvedorrejectedby+"\",\"emi\":"+emi+"}";
			
		System.out.print(request);
		log.info("################@@@@@@@@@@@@@ AmberRule Request @@@@@@@@@@@@@################ "+request);
		URL amber_url = new URL(ApplicationParams.getStramberrule());
		log.info("AmberRules  Url=========== "+amber_url);
		HttpURLConnection amber_urlcon = (HttpURLConnection) amber_url.openConnection();
		amber_urlcon.setRequestProperty("User-Agent", "");
		amber_urlcon.setDoInput(true);
		amber_urlcon.setDoOutput(true);
		amber_urlcon.setRequestMethod("POST");
		amber_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
		amber_urlcon.setRequestProperty("Authorization", ApplicationParams.getStramberauthvalue());
		OutputStream amber_outputStream = amber_urlcon.getOutputStream();
		OutputStreamWriter amber_osw = new OutputStreamWriter(amber_outputStream, "UTF8");
		BufferedWriter amber_bWriter = new BufferedWriter(amber_osw);
		amber_bWriter.write(request);
		amber_bWriter.close();
		
		InputStream amber_inputStream = amber_urlcon.getInputStream();
		InputStreamReader amber_isreader = new InputStreamReader(amber_inputStream,"UTF-8");
			
		BufferedReader amber_rd = new BufferedReader(amber_isreader);
		
		if (amber_rd != null) {
			StringBuffer amber_result = new StringBuffer();
			while ((line = amber_rd.readLine()) != null) {
				amber_result.append(line);
			}
			log.info("################@@@@@@@@@@@@@ Response @@@@@@@@@@@@@################"+ amber_result.toString());
	       		
				JSONObject json= new  JSONObject(amber_result.toString());
			   // JSONObject response= json.getJSONObject("status");
			    String status=String.valueOf(json.get("status"));
			    
		if(status.equalsIgnoreCase("HL-200"))
		{
		if(!amberstatus.equalsIgnoreCase("UNDO"))
		arrValues.add(appHolder);
		else
		arrValues.add("");
		if(amberstatus.equalsIgnoreCase("APPROVED"))
		arrValues.add("Y");
		else if(amberstatus.equalsIgnoreCase("REJECTED"))
		arrValues.add("N");
		else
		arrValues.add("");	//UNDO
		if(!amberstatus.equalsIgnoreCase("UNDO"))
		arrValues.add(strCurrentDate);
		else
		arrValues.add("");
		arrValues.add(appNo);
		//arrValues.add(appId);
		hshQuery.put("strQueryId", "updt_demographics_amber");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size", "1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();
		hshQuery.put("strQueryId", "upd_loan_digi_roi");
		arrValues = new ArrayList();
		arrValues.add("");
		arrValues.add("");
		arrValues.add(appNo);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size", "1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		
		
		}
		}
	}else{
		
		arrValues.add("");//appHolder
		arrValues.add("");//undo
		arrValues.add("");//date
		arrValues.add(appNo);
		hshQuery.put("strQueryId", "updt_demographics_amber");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size", "1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		
	}
	
	}
	catch(Exception e)
	{
		throw new EJBException("Exception in AmberRule ========"+e.getMessage());
	}
	
 return hshValues;
}
public HashMap proposalCreationForPB(HashMap hshValues)  
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	HashMap hshlockvalues=new HashMap();
	
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strApplicationNo="",strLAPSid="",strsolidOf850="";
	String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
	String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
	int intUpdatesize=0;
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	try
	{
		
		Date date1;
		Date date2;
		String strDate = ApplicationParams.getStrCLPCdate();
		SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
		date1 = CLPCdate.parse(strDate);
		String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		date2 = CLPCdate.parse(NOwCalender);
		String strsolidMang=strsolid;
		
		if (date1.before(date2))
		{
			if (strsolid.equalsIgnoreCase("850")){
				strsolidMang="600";
			}
		}
		
		//userid from organisation
		String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strUserClass="",strorg_branchin="",STRCLPHAV="";
		/*strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
			strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}*/
		
		String strscheme =Helper.correctNull((String)hshValues.get("strScheme"));
		
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
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}
		}else{
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
				strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
				strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
				strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
		}
		//system user
		String strSysteUserId="SYSUSR";
		
		if (rs != null) 
		{
			rs.close();
		}
		String strperappOldID="";
		strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
			strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
		}
		if(strLAPSid.equals(""))
		{
			strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
			strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
		}
		
		
			String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
		 
			String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
		
			//new Application Number
			hshlockvalues = new HashMap();
			hshlockvalues.put("apptype", "P");
			hshlockvalues.put("comapp_id", strLAPSid);
			hshlockvalues.put("strSolid", strsolid);
			strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

			//applications table
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strPrdCode);
			arrValues.add(strSysteUserId);
			arrValues.add(strOrgCode);									
			arrValues.add("P"); //Digital retail
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			arrValues.add("R");
			arrValues.add(strOrgLevel);
			arrValues.add(strUserId);
			arrValues.add("Y");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("N");
			arrValues.add("PR");
			arrValues.add("N");
			arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
			arrValues.add(correctNull((String) hshValues.get("strstpType")));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_digi");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//demographic table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLAPSid);
			arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add(strperappOldID);
			arrValues.add("");
			arrValues.add("a");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsdemoins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//inward register
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add("op");
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			 
			String mclrtype="",mclrtabcode="",mclrbaserate="",strRepaymentTypee="";
			strRepaymentTypee = correctNull((String) hshValues.get("strRepaymentType"));
			if(strRepaymentTypee.equals("12"))
			{
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
					mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
					mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
				}	
			}else{
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
				mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
			}
			}
			double intrate=0.00;
			String strloanpurpose=Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose"));
			
			/*strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
				mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
			}
			*/
			//interest rate calculation
			
			intrate=Double.parseDouble(mclrbaserate)+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")))
					+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
			
			//credit risk and business premium
			/*if (rs != null) 
			{ 	 rs.close();	}
			String strLesser = ">=";
			String strGreater = "<=";
			String strTerms=correctNull((String) hshValues.get("strLoanTenor"));
			String strRecAmt=correctNull((String) hshValues.get("strAmountRequested"));
			double prd_creditrskpremium=0.00,prd_busstrategicpremium=0.00;
			
			strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^floating^" + strPrdCode + "^" + strGreater + "^"
					+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^O^" + strGreater + "^" + strTerms + "^"
					+ strLesser + "^" + strTerms );
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 prd_creditrskpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")));
				 prd_busstrategicpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")));
			}
			
			double strintrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
			prd_busstrategicpremium=strintrate-(Double.parseDouble(Helper.correctDouble(mclrbaserate))-prd_creditrskpremium);*/
			
			//margin calculation
			int strpremisesage=Integer.parseInt(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			
			
			//loandetails
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;//
			hshQuery.put("strQueryId", "ins_loandetails_extAppl");
			arrValues.add(strApplicationNo);
			arrValues.add(String.valueOf(jtn.format(intrate)));
			arrValues.add(String.valueOf(jtn.format(intrate)));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
			String intype=correctNull((String) hshValues.get("strInterestType"));
			if(intype.equals("1"))
			{
				intype="Fixed";
			}
			else if(intype.equals("2"))
			{
				intype="Floating";
			}
			arrValues.add(intype);
			arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
			//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
			arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
			arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
			arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
			arrValues.add(correctNull((String) hshValues.get("strTakeover")));
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
			arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
			arrValues.add(mclrtabcode);
			arrValues.add(mclrtype);
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			arrValues.add(mclrbaserate);
			arrValues.add(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")));
			arrValues.add(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
			if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
			{
				arrValues.add("1"); //interest charged 
			}
			else
			{
				arrValues.add("2");  //interest charged 
			}
			arrValues.add("C");
			arrValues.add(correctNull((String)hshValues.get("strmargin")));
			arrValues.add("Y");
			arrValues.add("N");
			arrValues.add("S");
			/*if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
					arrValues.add("METLIFE");
			else
				arrValues.add("NC");*/
				arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
				arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
				//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
				
			arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
			arrValues.add("");
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			
			arrValues.add(correctNull((String)hshValues.get("strschemeType")));
			arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
			arrValues.add(correctNull((String)hshValues.get("stragencyName")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
			arrValues.add(correctNull((String)hshValues.get("strdeviation")));
			arrValues.add(correctNull((String)hshValues.get("strResidualvalue")));
			arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
			arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
			arrValues.add(correctNull((String) hshValues.get("")));
			arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
			arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
			arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
			arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
            Calendar calendar = Calendar.getInstance();
            String strDay = dateFormat.format(calendar.getTime());
            
			//workflow Mailbox
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
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
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
            calendar.add(Calendar.SECOND,5);
            strDay = dateFormat.format(calendar.getTime());
            
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);
			arrValues.add(strUserId);
			arrValues.add("1");
			arrValues.add("2");
			arrValues.add(strDay);
			arrValues.add("C");
			arrValues.add("001");
			arrValues.add("");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//per loan secure
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
			arrValues.add("s"); //unsecured
			arrValues.add("0"); //secured amt
			arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "secureins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);	
			
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//Coapplicant
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
					//Finacle relation type
					String strfinacletype="";
					if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("c"))
					{
						strfinacletype="J";
					}
					else if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("o"))
					{
						strfinacletype="C";
					}
					else if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("p"))
					{
						strfinacletype="A";
					}
					else 
					{
						strfinacletype=Helper.correctNull((String)arrcoappval.get(1));
					}
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "perloandetailsdemoins");
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(perapppid);//appid
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
					arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
					arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
					arrValues.add(strOldid);//oldid
					arrValues.add(strfinacletype.toUpperCase());//relationtype
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
			}
			
			String strSysUsrOrg="";
			
			if (rs != null) 
			{  rs.close(); 	}
			strQuery = SQLParser.getSqlQuery("setuserssel^"+strSysteUserId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strSysUsrOrg = Helper.correctNull((String) rs.getString("usr_orgcode"));
    		}
			
			
			
			//PB BIR NOT REQUIRED THROUGH PAYLOAD
			
			String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
			
			strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
			}


			
			//GST Return Details for Bussiness loan
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctNull((String) hshValues.get("strGSTyear1")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strGSTyear1amnt")));
			arrValues.add("1");
			hshQuery.put("strQueryId","ins_gstreturndetail_digi");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctNull((String) hshValues.get("strGSTyear2")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strGSTyear2amnt")));
			arrValues.add("2");
			hshQuery.put("strQueryId","ins_gstreturndetail_digi");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			//Retail Digi Rating
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
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
		
			//terms and conditions
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
			
			//Coapplicant Freeze
			hshValues.put("appno", strApplicationNo);
			PerApplicantBean perApplicantBean = new PerApplicantBean();
			perApplicantBean.getFreezeData(hshValues);
			
			/*//Credit Facilities Freeze
			BankAppFIBean appFIBean = new BankAppFIBean();
			appFIBean.updateFreezeData(hshValues);*/
		
		
			//mis not required for PB from API
				
			//documents 
			hshValues.put("strUserId", strUserId);
			hshValues.put("app_no", strApplicationNo);
			//hshValues=getDocumentURLs(hshValues);
			
			//APPRAISALSANCTION table
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);//appraised by
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
			arrValues.add("Y");//appraisal flag
			arrValues.add("02");//sanclevel
			arrValues.add("51");//sancauth
			arrValues.add("016");//sancdepart
			arrValues.add("RET");//sancbranch
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			//sanction
			if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("sanction"))
			{
					
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updapplicationsfinalsanction");
				arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				String strInwardno="";
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updinwardappstatus");
				arrValues.add("pa");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				//userclass
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","commworkflowupddigi");
				arrValues.add("pa");
				arrValues.add(strSysteUserId);
				arrValues.add(strsolid);
				arrValues.add(strUserClass);
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//sanction reference numnber
				CommWorkflowBean commwrkfko=new CommWorkflowBean();
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
					hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				}
				hshValues.put("hidAction", "approve");
				hshValues.put("sessionModuleType", "RET");
				hshValues.put("strApplicationType", "F");
				hshValues.put("digiloan", "Y");

				String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
				
				hshValues.put("strReferenceno", strReferenceno);
				hshValues.put("strSanctionDate", Helper.getCurrentDateTime());
				
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_specialMargin");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1", hshQuery);	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();   
			hshQuery.put("strQueryId","ins_retailcomments");
			arrValues.add(strApplicationNo);
			arrValues.add("LoanProd");
			arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
			
			String strType = correctNull((String) hshValues.get("strrenewType"));
			if(strType.equalsIgnoreCase("2"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add("Y");
				arrValues.add(correctNull((String) hshValues.get("strrenewProposalsNo")));
				hshQuery.put("strQueryId","renew_applicationflag");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add("R");
				arrValues.add(correctNull((String) hshValues.get("strrenewProposalsNo")));
				arrValues.add(strApplicationNo);
				hshQuery.put("strQueryId","upd_renew_retDigi");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			}
			
			hshValues.put("strApplication", strApplicationNo);
			hshValues.put("strResponseCode", "LAPS-1010");
			hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean ProposalCreation..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean proposalCreationForPB..."+e.toString());
		}
	}
	
	return hshValues;
	
}
/*public HashMap roiUpdateServices(HashMap hshValues)
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
	
try
{
	String strproposalnumber="",strloanamount="",strtenure="",strholidayperiod="",line="";
	strproposalnumber=Helper.correctNull((String)hshValues.get("appno"));
	
	strQuery = SQLParser.getSqlQuery("roiupdate^"+strproposalnumber);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		strloanamount=Helper.correctNull((String)rs.getString("loan_amtreqd"));	
		strtenure=Helper.correctNull((String)rs.getString("loan_reqterms"));	
		strholidayperiod=Helper.correctNull((String)rs.getString("loan_noofinstallment"));	
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
	String applicantIn="{" +
			"\"proposalnumber\":\""+strproposalnumber+"\"," +
					"\"loanamount\":"+strloanamount+"," +
							"\"tenure\":"+strtenure+"," +
									"\"holidayperiod\":"+strholidayperiod+"}";
	
	System.out.print(applicantIn);
	log.info("################@@@@@@@@@@@@@ ROI UPDATE REQUEST @@@@@@@@@@@@@################ "+applicantIn);
	URL roiupd_url = new URL(ApplicationParams.getStrroiupdurl());
	log.info("BRE call4 Url=========== "+roiupd_url);
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

	*//**************************Response********************************************//*
	
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
	JSONObject json= new  JSONObject(roi_result.toString());
	
	JSONObject STRRATEOFINTEREST=json.getJSONObject("interesttype");
    String STRRATEOFINTERESTVALUE=String.valueOf(STRRATEOFINTEREST.get("value"));
    
    JSONObject STRBASERATE=json.getJSONObject("benchmarkrate");
    String STRBASERATEVALUE=String.valueOf(STRBASERATE.get("value"));
    
    JSONObject STRFIXEDRATE=json.getJSONObject("fixedrate");
    String STRFIXEDRATEVALUE=String.valueOf(STRFIXEDRATE.get("value"));
    
    JSONObject STRCREDITRSKVAL=json.getJSONObject("creditriskpremium");
    String STRCREDITRSKVALVALUE=String.valueOf(STRCREDITRSKVAL.get("value"));
    
    JSONObject STRPENALINTEREST=json.getJSONObject("penalinterest");
    String STRPENALINTERESTVALUE=String.valueOf(STRPENALINTEREST.get("value"));
    
    JSONObject STRTOTALINTEREST=json.getJSONObject("totalinterest");
    String STRTOTALINTERESTVALUE=String.valueOf(STRTOTALINTEREST.get("value"));
    
    JSONObject STRMINMARGIN=json.getJSONObject("minimummargin");
    String STRMINMARGINVALUE=String.valueOf(STRMINMARGIN.get("value"));
	
    String mclrtype="",mclrtabcode="",mclrbaserate="";
	
	strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
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
	arrValues.add(STRCREDITRSKVALVALUE);//loan_creditrskval
	arrValues.add(STRFIXEDRATEVALUE);//loan_busstatval
	arrValues.add(mclrtabcode);//LOAN_MCLRTABCODE
	arrValues.add(mclrtype);//LOAN_MCLRTYPE
	arrValues.add("Y");//LOAN_UPDROI_FLAG
	arrValues.add(STRMINMARGINVALUE);//Loan_margin
	arrValues.add(STRPENALINTERESTVALUE);//digi_deviation_roi_penalty
	arrValues.add(strproposalnumber);
	hshQuery.put("arrValues",arrValues);
	hshQueryValues.put("1",hshQuery);
	hshQueryValues.put("size","1");
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
}

catch(Exception e) {
	throw new EJBException("Error in getConfirmedService "+e.getMessage());

	}
return hshValues;	
}*/


public HashMap valuerListService(HashMap hshValues)
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ResultSet rs=null,rs1=null;
	String strQuery="",strOrgCode="",strscode="", solCode="";
	
try
{	
	ArrayList arrValuerList = new ArrayList();
	HashMap valuerList = new HashMap();
	String strValouedLoc=Helper.correctNull((String)hshValues.get("strValuerLoc"));
	strQuery = SQLParser.getSqlQuery("sel_valuerlist^"+strValouedLoc);
	rs = DBUtils.executeQuery(strQuery);
	while(rs.next())
		
	{
		valuerList = new HashMap();
		strOrgCode=Helper.correctNull((String)rs.getString("org_code"));
		
		if(strOrgCode.contains("@")){
			String[] orgcode=strOrgCode.split("@");
		
			for(int i=0;i<orgcode.length;i++){
			
			strQuery = SQLParser.getSqlQuery("sel_scode^"+orgcode[i]);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{		
				solCode=Helper.correctNull((String)rs1.getString("ORG_SCODE"));
				strscode=strscode+solCode;
			if(i!=orgcode.length-1)
				strscode=strscode+"@";
		}
		}
		valuerList.put("SolId",strscode);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("sel_scode^"+strOrgCode);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())	
				 solCode=Helper.correctNull((String)rs1.getString("ORG_SCODE"));
			
			valuerList.put("SolId",solCode);
		}
			if(rs1!=null)
				rs1.close();
		
		valuerList.put("Code",Helper.correctNull((String)rs.getString("valuers_code")));
		valuerList.put("Name",Helper.correctNull((String)rs.getString("valuers_name")));
		valuerList.put("MobileNo",Helper.correctNull((String)rs.getString("valuers_res_mobno")));
		valuerList.put("EmailId",Helper.correctNull((String)rs.getString("valuers_email")));
		valuerList.put("CategoryCode",(Helper.correctNull((String)rs.getString("VALUER_CATEGORYCODE"))));
		valuerList.put("ValuationNature",Helper.correctNull((String)rs.getString("VALUER_VALUATIONNATURE")));
		arrValuerList.add(valuerList);
	}
	hshValues.put("ValuationDetails", arrValuerList);
	
}


catch(Exception e) {
	throw new EJBException("Error in ValuerList Service in DigitalAppInterfaceBean "+e.getMessage());

	}

return hshValues;
}

public HashMap larInwardreg(HashMap hshValues)
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	ResultSet rs=null;
	String strOrgsCode="",strInwardNo="",strcbsId="",strCustName="",strPanNo="",strMobNo="",strBankScheme="",strAppstatus="",strQuery="";
	String strSector="",strSchemeDesc="",strPropType="",strdigiappno="";
try
{	
	ArrayList arrLar = new ArrayList();
	HashMap larhashMap = new HashMap();
	String strLarNo=Helper.correctNull((String)hshValues.get("strLarNo"));
	
	
	strQuery=SQLParser.getSqlQuery("sel_ibm_inwardreg^"+strLarNo);
	MISLogger.UpdateLogger(strQuery);
	rs=DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		strOrgsCode=Helper.correctNull(rs.getString("INWARD_ORGSCODE"));
		strInwardNo=Helper.correctNull(rs.getString("INWARD_NO"));
		strcbsId=Helper.correctNull(rs.getString("INWARD_CBSCUSTID"));
		strCustName=Helper.correctNull(rs.getString("INWARD_CUSTNAME"));
		strPanNo=Helper.correctNull(rs.getString("INWARD_PANTAN"));
		strMobNo=Helper.correctNull(rs.getString("INWARD_MOBILE"));
		strBankScheme=Helper.correctNull(rs.getString("INWARD_BANKSCHEME"));
		strAppstatus=Helper.correctNull(rs.getString("APPSTATUS"));
		strSector=Helper.correctNull(rs.getString("SECTOR"));
		strSchemeDesc=Helper.correctNull(rs.getString("SCHEME_DESC"));
		strPropType=Helper.correctNull(rs.getString("PROP_TYPE"));
		strdigiappno=Helper.correctNull(rs.getString("INWARD_DIGIAPPNO"));
			
	}
	
	larhashMap.put("OrganisationCode", strOrgsCode);
	larhashMap.put("InwardNo", strInwardNo);
	larhashMap.put("CbsCustId",strcbsId );
	larhashMap.put("CustomerName", strCustName);
	larhashMap.put("PanNo",strPanNo );
	larhashMap.put("MobileNo", strMobNo);
	larhashMap.put("BankScheme",strBankScheme );
	larhashMap.put("AppStatus",strAppstatus);
	larhashMap.put("Sector",strSector);
	larhashMap.put("SchemeDesc",strSchemeDesc);
	larhashMap.put("ProposalType",strPropType);
	larhashMap.put("DigiProposalNo",strdigiappno);
	
	
	hshValues.put("InwardDetails", larhashMap);
	
}


catch(Exception e) {
	throw new EJBException("Error in larInwardDetails Service in DigitalAppInterfaceBean "+e.getMessage());

	}

return hshValues;
}

public HashMap renewalProposalRetails(HashMap hshValues)  
{
	
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	ResultSet rs=null,rs1=null;
	HashMap hshValue = new HashMap();
	String strrenwaldate="",strQuery="",strcustomerID="",proposalID="",facilityID="",productCode="",sanctionedDate="",straccountOpeningDate="",tenor="",
	dueDate="",companyName="",sanctionedAmount="",ORG_SCODE="",facilitytype=""; 
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
			strQuery = SQLParser.getSqlQuery("sel_renewal_details_cbsid^"+strcustId);
		}else{
			strQuery = SQLParser.getSqlQuery("sel_renewal_details^"+strrenwaldate);
		}
		rs = DBUtils.executeQuery(strQuery);
		 
		while(rs.next())
		{
			hshValues.put("dataExist", "Yes");	
			
			strcustomerID=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));
			proposalID=Helper.correctNull((String)rs.getString("app_no"));
			productCode=Helper.correctNull((String)rs.getString("facdesc"));
			sanctionedDate=Helper.correctNull((String)rs.getString("APP_PROCESSDATE"));
			straccountOpeningDate=Helper.correctNull((String)rs.getString("LAPS_HANDOFF_TIME"));
			tenor=Helper.correctNull((String)rs.getString("loan_reqterms"));
			dueDate=Helper.correctNull((String)rs.getString("loan_duedate"));
			companyName=Helper.correctNull((String)rs.getString("comapp_companyname"));
			sanctionedAmount=Helper.correctNull((String)rs.getString("LOAN_RECMDAMT"));
			ORG_SCODE=Helper.correctNull((String)rs.getString("scode"));
			facilitytype=Helper.correctNull((String)rs.getString("prd_catid"));
				
			
			hshValue1=new HashMap();
			hshValue1.put("strcustomerID", strcustomerID);
			hshValue1.put("proposalID", proposalID);
			hshValue1.put("facilityID", "1");
			hshValue1.put("productCode", productCode);
			hshValue1.put("sanctionedDate", sanctionedDate);
			hshValue1.put("accountOpeningDate", straccountOpeningDate);
			hshValue1.put("tenor", tenor);
			hshValue1.put("dueDate", dueDate);
			hshValue1.put("sanctionedAmount", sanctionedAmount);
			hshValue1.put("companyName", companyName);
			hshValue1.put("sol_id", ORG_SCODE);		
			hshValue1.put("facilitytype", facilitytype);			
			arrValue.add(hshValue1);			
		}
		
		hshValues.put("strrenewalProposals", arrValue);
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean renewalProposal Service..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean renewalProposal Service closing Connection ..."+e.toString());
		}
	}
	return hshValues;		
}

public HashMap fetchProposalsService(HashMap hshValues)
{
	ResultSet rs=null;
	String strQuery="";
	
try
{	
	String ApplicantType="",strpanno="",strdate="",strstartDate="",strmobileNumber="",strcbscustid="";
	HashMap fetchProposals = new HashMap();
	ArrayList fetchProposalsList = new ArrayList();
	strpanno=Helper.correctNull((String)hshValues.get("strpanno"));
	strstartDate=Helper.correctNull((String)hshValues.get("strstartDate"));
	strmobileNumber=Helper.correctNull((String)hshValues.get("strmobileNumber"));
	strcbscustid=Helper.correctNull((String)hshValues.get("strcbscustid"));

	if((strpanno.equals("") && !strstartDate.equals("")) || !(strpanno.equals("")|| strmobileNumber.equals("")))
	{
		strQuery = SQLParser.getSqlQuery("sel_mobnolist^"+strmobileNumber+"^"+strstartDate+"^"+strmobileNumber+"^"+strstartDate+"^"+strmobileNumber+"^"+strstartDate);

	}else if (strmobileNumber.equals("") && !strstartDate.equals(""))
	{
		strQuery = SQLParser.getSqlQuery("sel_pannolist^"+strpanno+"^"+strstartDate+"^"+strpanno+"^"+strstartDate+"^"+strpanno+"^"+strstartDate);

	}else if (!strcbscustid.equalsIgnoreCase(""))
	{
		strQuery = SQLParser.getSqlQuery("sel_cbscustid^"+strcbscustid+"^"+strcbscustid+"^"+strcbscustid);

	}
	
	rs = DBUtils.executeQuery(strQuery);
	while(rs.next())	
	{
		fetchProposals = new HashMap();
		fetchProposals.put("CBSID",Helper.correctNull((String)rs.getString("CBS")));
		fetchProposals.put("MODULE",Helper.correctNull((String)rs.getString("MODULE")));
		fetchProposals.put("PANNO",Helper.correctNull((String)rs.getString("PANNO")));
		fetchProposals.put("FIRST NAME",Helper.correctNull((String)rs.getString("ACNM")));
		fetchProposals.put("MOBILE NUMBER",Helper.correctNull((String)rs.getString("Mobileno")));
		fetchProposals.put("APPLICANT TYPE",Helper.correctNull((String)rs.getString("Type")));
		fetchProposals.put("APPNO",Helper.correctNull((String)rs.getString("APPNO")));
		fetchProposals.put("FACILITY SNO",Helper.correctNull((String)rs.getString("FAC_SNO")));
		fetchProposals.put("LIMIT TYPE",Helper.correctNull((String)rs.getString("LIMITTYPE")));
		fetchProposals.put("FACILITY CATEOGRY",Helper.correctNull((String)rs.getString("faccateogry")));
		fetchProposals.put("FACILITY TYPE",Helper.correctNull((String)rs.getString("FACILITYTYPE")));
		fetchProposals.put("PRODUCT Description",Helper.correctNull((String)rs.getString("PRDDE")));
		fetchProposals.put("LOAN AMOUNT",Helper.correctNull((String)rs.getString("LOANAMOUNT")));
		fetchProposals.put("APP PROCESSDATE",Helper.correctNull((String)rs.getString("APDT")));
		fetchProposals.put("CBS ACCOUNTNO",Helper.correctNull((String)rs.getString("ACNUM")));
		fetchProposals.put("BANK SCHEME",Helper.correctNull((String)rs.getString("MIS_STATIC_DATA_DESC")));
		fetchProposalsList.add(fetchProposals);
		hshValues.put("PanProposalDetails", fetchProposalsList);
	}
}
catch(Exception e) {
	throw new EJBException("Error in Fetch Proposals Service in DigitalAppInterfaceBean "+e.getMessage());

	}

return hshValues;
}
public HashMap proposalCreationForPM(HashMap hshValues)  
{
	HashMap hshQuery= new HashMap();
	HashMap hshQueryValues= new HashMap();
	HashMap hshlockvalues=new HashMap();
	HashMap hshRecord=new HashMap();

	ArrayList arrValues= new ArrayList();
	
	ResultSet rs=null,rs1=null;
	String strQuery="",strApplicationNo="",strLAPSid="", strperappOldID="",strsolidOf850="";
	
	String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
	String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
	int intUpdatesize=0;
	
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	
	try
	{
		
		Date date1;
		Date date2;
		String strDate = ApplicationParams.getStrCLPCdate();
		SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
		date1 = CLPCdate.parse(strDate);
		String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		date2 = CLPCdate.parse(NOwCalender);
		String strsolidMang = strsolid;
		
		if (date1.before(date2))
		{
			strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strsolid);
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

		//userid from organisation
		String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strorg_branchin="",STRCLPHAV="";
		String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));

		String strscheme =Helper.correctNull((String)hshValues.get("strScheme"));
		
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
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}
		}else{
			strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
				strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
				strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
				strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
				strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
			}
		}
		
		if (rs != null) 
		{	rs.close();	 }
		strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolid);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}
		
		//system user
		String strSysteUserId="SYSUSR";
		
		if (rs != null) 
		{
			rs.close();
		}
		
		strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
			strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
		}
		
		if(strLAPSid.equals(""))
		{
			strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
			strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
		}
		
		String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
		
		
			//new Application Number
			hshlockvalues = new HashMap();
			hshlockvalues.put("apptype", "P");
			hshlockvalues.put("comapp_id", strLAPSid);
			hshlockvalues.put("strSolid", strsolid);
			strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

			//applications table
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strPrdCode);
			arrValues.add(strSysteUserId);
			arrValues.add(strOrgCode);									
			arrValues.add("P"); //Digital retail
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			arrValues.add("R");
			arrValues.add(strOrgLevel);
			arrValues.add(strUserId);
			arrValues.add("Y");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("N");
			arrValues.add("PR");
			arrValues.add("N");
			arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
			arrValues.add(correctNull((String) hshValues.get("strstpType")));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_digi");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//demographic table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLAPSid);
			arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add(strperappOldID);
			arrValues.add("");
			arrValues.add("a");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsdemoins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//inward register
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add("op");
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			 
			String mclrtype="",mclrtabcode="",mclrbaserate="",prdpupose="";
			double intrate=0.00;
			/* Home Connect MCLR not REquired */
			String strloanpurpose=Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose"));
			if(!strloanpurpose.equals("HC"))
			{
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
				mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
			}
			
			//interest rate calculation
			
			intrate=Double.parseDouble(mclrbaserate)+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")))
					+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
			}
			else{
				 intrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
			}
			//credit risk and business premium
			/*if (rs != null) 
			{ 	 rs.close();	}
			String strLesser = ">=";
			String strGreater = "<=";
			String strTerms=correctNull((String) hshValues.get("strLoanTenor"));
			String strRecAmt=correctNull((String) hshValues.get("strAmountRequested"));
			double prd_creditrskpremium=0.00,prd_busstrategicpremium=0.00;
			
			strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^floating^" + strPrdCode + "^" + strGreater + "^"
					+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^O^" + strGreater + "^" + strTerms + "^"
					+ strLesser + "^" + strTerms );
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 prd_creditrskpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")));
				 prd_busstrategicpremium = Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")));
			}
			
			double strintrate= Double.parseDouble(Helper.correctDouble((String) hshValues.get("strInterestRate")));
			prd_busstrategicpremium=strintrate-(Double.parseDouble(Helper.correctDouble(mclrbaserate))-prd_creditrskpremium);*/
			
			//margin calculation
			//String strloanpurpose=Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose"));
			int strpremisesage=Integer.parseInt(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			
			int margin=0;
			if(rs1!=null)
				rs1.close();
			String desc="";
			if(strloanpurpose.equalsIgnoreCase("H"))
				desc=String.valueOf(strpremisesage);
			else
				desc=correctNull((String) hshValues.get("strAmountRequested"));
			
			rs1 = DBUtils.executeLAPSQuery("sel_prdmargin_appl^"+ strPrdCode+"^"+desc);
			if(rs1.next())
			{
				margin=Integer.parseInt(Helper.correctInt((String)rs1.getString("MARGIN_PERCT")));
			}
		
			if(strloanpurpose.equalsIgnoreCase("H"))
			{	
				if(strpremisesage>10)
				{
					margin=30;
				}
				else
				{
					double reqamt=Double.parseDouble(Helper.correctDouble((String) hshValues.get("strAmountRequested")));
					
					if((reqamt > 1.00) && (reqamt <= 3000000.00))
					{
						margin=10;
					}
					else if((reqamt > 3000000.00) && (reqamt <= 7500000.00))
					{
						margin=20;
					}
					else if((reqamt > 7500000.00) && (reqamt <= 30000000.00))
					{							
						margin=25;
					}
				}
			}
			
			//loandetails
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;//
			hshQuery.put("strQueryId", "ins_loandetails_extAppl");
			arrValues.add(strApplicationNo);
			arrValues.add(String.valueOf(jtn.format(intrate)));
			arrValues.add(String.valueOf(jtn.format(intrate)));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
			String intype=correctNull((String) hshValues.get("strInterestType"));
			if(intype.equals("1"))
			{
				intype="Fixed";
			}
			else if(intype.equals("2"))
			{
				intype="Floating";
			}
			arrValues.add(intype);
			arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
			//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
			arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
			arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
			arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
			arrValues.add(correctNull((String) hshValues.get("strTakeover")));
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
			arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
			arrValues.add(mclrtabcode);
			arrValues.add(mclrtype);
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			arrValues.add(mclrbaserate);
			arrValues.add(Helper.correctDouble((String) hshValues.get("strbusinessStrategicPremium")));
			arrValues.add(Helper.correctDouble((String) hshValues.get("strcreditRiskPremium")));
			if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
			{
				arrValues.add("1"); //interest charged 
			}
			else
			{
				arrValues.add("2");  //interest charged 
			}
			arrValues.add("C");
			arrValues.add(correctNull((String)hshValues.get("strmargin")));
			arrValues.add("Y");
			arrValues.add("N");
			arrValues.add("S");
			/*if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
					arrValues.add("METLIFE");
			else
				arrValues.add("NC");*/
				arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
				arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
				//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
				
			arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
			arrValues.add("");
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			
			arrValues.add(correctNull((String)hshValues.get("strschemeType")));
			arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
			arrValues.add(correctNull((String)hshValues.get("stragencyName")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
			arrValues.add(correctNull((String)hshValues.get("strdeviation")));
			arrValues.add(correctNull((String)hshValues.get("strResidualvalue")));
			arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
			arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
			arrValues.add(correctNull((String) hshValues.get("strDigiAppNo")));
			arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
			arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
			arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
			arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
            Calendar calendar = Calendar.getInstance();
            String strDay = dateFormat.format(calendar.getTime());
            
			//workflow Mailbox
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
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
			hshQueryValues.put(""+intUpdatesize, hshQuery);

			calendar.add(Calendar.SECOND,5);
	        strDay = dateFormat.format(calendar.getTime());
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);
			arrValues.add(strUserId);
			arrValues.add("1");
			arrValues.add("2");
			arrValues.add(strDay);
			arrValues.add("C");
			arrValues.add("001");
			arrValues.add("");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);

			//per loan secure
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
			arrValues.add("s"); //unsecured
			arrValues.add("0"); //secured amt
			arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "secureins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);	
			
			
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//Coapplicant
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
					hshQuery.put("strQueryId", "perloandetailsdemoins");
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(perapppid);//appid
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
					arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
					arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
					arrValues.add(strOldid);//oldid
					arrValues.add(strfinacletype.toUpperCase());//relationtype
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
			}
			
			String strperappcity="",strperappstate="",strperappdistrict="";
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
				strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
				strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
			}					
			
			//terms and conditions
			ArrayList arrTerms=new ArrayList();
			ArrayList arrTermsId=new ArrayList();
			ArrayList arrTermsType=new ArrayList();  
			int k=0;
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
				 int sno =1;
				 for(int i=0;i<arrTermsId.size();i++)
				{
					hshQueryValues.put("size",String.valueOf(++intSize));
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","apptermscondinsdigi");
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(String.valueOf(i));
					arrValues.add(correctNull((String)arrTerms.get(i)));
					arrValues.add("P");
					arrValues.add("N");
					arrValues.add("S");
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(correctNull((String)arrTermsType.get(i)));
					arrValues.add(String.valueOf(sno));
					sno++;
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					k=i;	
				}
				if(arrTermsId.size()>0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			if(!correctNull((String) hshValues.get("strtermCond")).isEmpty())
			{	
			hshQuery=new HashMap();
			hshQuery.put("strQueryId","apptermscondinsdigi");
			arrValues=new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(String.valueOf(k+1));
			arrValues.add(correctNull((String) hshValues.get("strtermCond")));
			arrValues.add("A");
			arrValues.add("N");
			arrValues.add("P");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("1");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			//Coapplicant Freeze
			hshValues.put("appno", strApplicationNo);
			PerApplicantBean perApplicantBean = new PerApplicantBean();
			perApplicantBean.getFreezeData(hshValues);
			
			//Credit Facilities freeze
			BankAppFIBean appFIBean = new BankAppFIBean();
			appFIBean.updateFreezeData(hshValues);
		
			//MIS Activity
			/*HashMap hshMISstatic = new HashMap();
			HashMap hshMISSubActivity = new HashMap();
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
				String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
				hshMISstatic.put(strSlcode,strPrdDesc);
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
				String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
				hshMISSubActivity.put(strSubcode,strSubPrdDesc);
			}
			
			
			String strActivity = " and mac.ACT_ACTIVITYCODE in (";
			String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
			String stractivitycode=strActCode;
			if(rs1!=null)
			{	  rs1.close();		}
			strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{ 
				hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
				hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
				hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
				hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
				hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
				hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
				hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
				hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
				hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
				hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
				hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
				hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
				hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
				hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
				hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
				String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
				String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
				if(strMainActivityCode.length()>0)
				{
					hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
				}
				
				if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
				{
					String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
					hshValues.put("strMainSubA/ctivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
				}
				
				hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
				hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
				
				hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
				hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
				hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
			}
			
			double dblTotLim=0.00;
			double dblTotLimAgr=0.00;
			double dblTotLimSer=0.00;
			
			MisBean misbean=new MisBean();
			
			dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
			dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R");
			dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R");
			
			int querycount=0;
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
			arrValues.add("N");//Whether under Service Area Approach
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
			arrValues.add(strperappcity);
			arrValues.add(strperappdistrict);
			arrValues.add(strperappstate);
			arrValues.add(strorg_branchin);//Place - Metro
			arrValues.add("N"); //Does repayment depend purely on the asset financed
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
			arrValues.add("00");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
			arrValues.add(strActCode);
			arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
			arrValues.add("1"); //Asset Classification
			arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
			arrValues.add("1"); //fac serial no
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_sharebroker")));
			arrValues.add("Y");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			String strQueryAgr="";
			strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
			MISLogger.UpdateLogger(strQueryAgr);
			rs1=DBUtils.executeQuery(strQueryAgr);
			if(rs1.next())
			{
				hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
				hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
				hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
				hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
				hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
				hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
			}
			
			/*hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
			arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
			arrValues.add("1");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			if(rs1!=null)
				rs1.close();
			strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
			MISLogger.UpdateLogger(strQuery);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQueryValues.put("size","5");
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						querycount++;
						hshQuery.put("strQueryId","upd_cbsdetails");
						arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
						arrValues.add(strApplicationNo);
						arrValues.add("1");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(querycount),hshQuery);
					}
				}
			}
			hshQueryValues.put("size",String.valueOf(querycount));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			String strAppStatus="";
			String strPriorityType="";
			String strPrioritySubsector="";
			String strWeakerSectionSubSector="";
			String strAgriIndConfig="";
			String strTwentyPointPgm="";
			String strSensitiveSector="";
			String strInfracode="";
			String strGovtAnnounceScheme="";
			String strClassiMaster_Sno="";
			String strActivityCode="";
			String strActivitySno="";
			HashMap hshPriority=new HashMap();
			String strFacilitySno="1";
			String strStandUpIndia="";

			hshValues.put("strFacilitySno",strFacilitySno);
			hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
			//hshValues.put("strHOLIDAYPERIOD","0");
			hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
			hshValues.put("hidapplicantnewid",strLAPSid);
			hshValues.put("strAppType","P");
			
			hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
			 
			 	hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_misappclassification_digi");
				arrValues.add(strApplicationNo);
				arrValues.add(strAgriIndConfig);
				arrValues.add(strPriorityType);
				arrValues.add(strPrioritySubsector);
				arrValues.add(strSensitiveSector);
				arrValues.add(strWeakerSectionSubSector);
				arrValues.add(strTwentyPointPgm);
				arrValues.add(strInfracode);
				arrValues.add(strGovtAnnounceScheme);
				arrValues.add(strClassiMaster_Sno);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
			// mis end

				
			//CBS Details
			 
			if(rs != null)
			   rs.close(); 	 
			String strAppend="",strmodeofadv="";
			strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
			strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
			}

			if(rs!=null)
			rs.close();
			String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
			strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
				freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
				freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
				freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
				finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
				finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
			}
			
			
			
			String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
			
			strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
			}
			if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
			{
				strLoanType="LAA";
			}
			else if(strLoanType.equalsIgnoreCase("OD"))
			{
				strLoanType="ODA";
			}
			strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
			}
				
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(freeCode6);
			arrValues.add(freeCode7);
			arrValues.add(freeCode8);
			arrValues.add("01");//strModeOfOperation
			arrValues.add("E");//strDrawingPowerInd
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
			arrValues.add("N"); // Account Handoff
			arrValues.add("01");//strAdvanceNature
			arrValues.add(strAdvanceType);
			arrValues.add(strmodeofadv);
			arrValues.add("10"); //default 10
			arrValues.add("999"); //default 999
			arrValues.add(strsolid);
			arrValues.add(""); //Security Code
			arrValues.add(strintratefrq);
			arrValues.add(finfreeCode7);
			arrValues.add(finfreeCode8);
			arrValues.add(strlbrcode);
			arrValues.add(strFacilitySno);
			arrValues.add("Residential Property");
			arrValues.add(""); //facilityschemecode
			arrValues.add(""); //facility_glsubheadcode
			arrValues.add("99"); //laps free code 1
			arrValues.add("99"); //laps free code 2
			arrValues.add("99"); //laps free code 3
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_cbsdetails");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	*/
				
				
			
	  	//deviation Details
	  		ArrayList arrdevdet=new ArrayList();
			ArrayList arrdevdetval=new ArrayList();
			arrdevdet=(ArrayList) hshValues.get("arrdevdet");
			
			int arrdevdetlen=arrdevdet.size();
			if(arrdevdetlen>0)
			{
				for(int i=0;i<arrdevdetlen;i++)
				{
					arrdevdetval=(ArrayList) arrdevdet.get(i);
					
					//amber rules
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "upd_demogra_amberrules");
					arrValues = new ArrayList();
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(7)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(8)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(9)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(10)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(13)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(11)));
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(12)));
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctNull((String)arrdevdetval.get(1))); 
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				}
			}	
				// score details
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "upd_Loandetails_deviation_bre");
				arrValues = new ArrayList();
				arrValues.add(correctNull((String) hshValues.get("deviationROI"))); 
				arrValues.add(correctNull((String) hshValues.get("digiFOIR"))); 
				arrValues.add(correctNull((String) hshValues.get("deviationLoanAmount"))); 
				arrValues.add(correctNull((String) hshValues.get("digiMaxEmi"))); 
				arrValues.add(correctNull((String) hshValues.get("digiNMI"))); 
				arrValues.add(correctNull((String) hshValues.get("digiNMImultiplier")));
				arrValues.add(correctNull((String) hshValues.get("stramrtOverride")));
				arrValues.add(correctNull((String) hshValues.get("stramrtOverrideLoanAmount")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			if(Helper.correctNull((String)hshValues.get("strdeviation")).equalsIgnoreCase("Y") )
			{
				int intupdatesize=0;

				if(!Helper.correctNull((String)hshValues.get("deviationROI")).equals("") )
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_app_deviation_digi");
					intupdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add("IR");//txt_interestdivtype
					arrValues.add(String.valueOf(jtn.format(intrate))); //txt_interestrateold
					arrValues.add(correctNull((String) hshValues.get("deviationROI")));
					arrValues.add("Y");//sel_interestrate
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(!Helper.correctNull((String)hshValues.get("deviationFOIR")).equals("") )
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_app_deviation_digi");
					intupdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add("RC");//
					arrValues.add("60");
					arrValues.add(Helper.correctNull((String)hshValues.get("deviationFOIR")));
					arrValues.add("N");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(!Helper.correctNull((String)hshValues.get("deviationFOIR")).equals("") )
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_app_deviation_digi");
					intupdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add("RC");//
					arrValues.add("60");
					arrValues.add(Helper.correctNull((String)hshValues.get("deviationFOIR")));
					arrValues.add("Y");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(!Helper.correctNull((String)hshValues.get("deviationLoanAmount")).equals("") )
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_app_deviation_digi");
					intupdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add("LA");
					arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
					arrValues.add(correctNull((String) hshValues.get("deviationLoanAmount")));
					arrValues.add("Y");
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_amount_loandetails");
					intupdatesize++;
					arrValues.add(Helper.correctDouble((String) hshValues.get("deviationLoanAmount")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);		
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_BREupdate_flag");
				intupdatesize++;
				arrValues.add("Y");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				
				hshQueryValues.put("size",Integer.toString(intupdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			}
			
			/*hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_birdata");	
			arrValues.add(strApplicationNo);
			arrValues.add("N");
			arrValues.add("0.00");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			
			//documents 

			hshValues.put("strUserId", strUserId);
			hshValues.put("app_no", strApplicationNo);
			//hshValues=getDocumentURLs(hshValues);
			
			//APPRAISALSANCTION table
			/*hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(strUserId);//appraised by
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
			arrValues.add("Y");//appraisal flag
			arrValues.add("02");//sanclevel
			arrValues.add("51");//sancauth
			arrValues.add("016");//sancdepart
			arrValues.add("RET");//sancbranch
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
			
			//sanction
			if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equals("sanction"))
			{
					
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updapplicationsfinalsanction");
				arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				String strInwardno="";
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updinwardappstatus");
				arrValues.add("pa");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","commworkflowupddigi");
				arrValues.add("pa");
				arrValues.add(strUserId);
				arrValues.add(strOrgScode);
				arrValues.add("");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
				//sanction reference numnber
				CommWorkflowBean commwrkfko=new CommWorkflowBean();
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
					hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				}
				hshValues.put("hidAction", "approve");
				hshValues.put("sessionModuleType", "RET");
				hshValues.put("strApplicationType", "F");
				hshValues.put("digiloan", "Y");

				String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
				
				hshValues.put("strReferenceno", strReferenceno);
				hshValues.put("strSanctionDate", Helper.getCurrentDateTime());

			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_specialMargin");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1", hshQuery);	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();   
			hshQuery.put("strQueryId","ins_retailcomments");
			arrValues.add(strApplicationNo);
			arrValues.add("LoanProd");
			arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
			
			
			
			
			if((correctNull((String) hshValues.get("strTakeover"))).equalsIgnoreCase("Y"))
			{
			String installamt_transbank="",
			 overdue_install="",
			 overdue_interest="",
			 tot_overdue="",
			 takeover_amtpaid ="",
			 tot_liability ="",
			 loanamt_transbank ="",
			 str_shifting_reason ="",
			 str_holiday_period ="",
			 str_rate_of_interest ="",
			 str_prevbank_opinion ="",
			 str_stmt_dt_from ="",
			 str_stmt_dt_to ="",
			 str_stmt_comments ="",
			 str_due_due ="";
	    		
			installamt_transbank = correctNull((String) hshValues.get("strStallmentStipulated"));
			if (installamt_transbank.equals(""))
			{
				installamt_transbank = "0.00";
			}
			loanamt_transbank = Helper.correctDouble((String) hshValues.get("strLoanAmntTransferBank"));
			if (loanamt_transbank .equals(""))
			{
				loanamt_transbank  = "0.00";
			}
			String loan_frombank = Helper.correctDouble((String) hshValues.get("strLoanAmntTransferBank"));
			if (loan_frombank .equals(""))
			{
				loan_frombank = "0.00";
			}
			overdue_install = correctNull((String) hshValues.get(""));
			if (overdue_install.equals(""))
			{
				overdue_install = "0.00";
			}
			overdue_interest = correctNull((String) hshValues.get(""));//need to change
			if (overdue_interest.equals(""))
			{
				overdue_interest = "0.00";
			}
			tot_overdue = correctNull((String) hshValues.get("strOverdueAmount"));
			if (tot_overdue.equals(""))
			{
				tot_overdue = "0.00";
			}
			takeover_amtpaid = correctNull((String) hshValues.get("strAmountPaidTransfer"));
			if (takeover_amtpaid .equals(""))
			{
				takeover_amtpaid  = "0.00";
			}
			tot_liability = correctNull((String) hshValues.get("strTotalLiability"));
			if (tot_liability  .equals(""))
			{
				tot_liability   = "0.00";
			}
			str_shifting_reason=Helper.correctNull((String)hshValues.get("strReasonShiftBank"));
			str_holiday_period=Helper.correctNull((String)hshValues.get("strHolidayperiod"));
			str_rate_of_interest=Helper.correctNull((String)hshValues.get("strInterestRateTakeOver"));
			str_prevbank_opinion=Helper.correctNull((String)hshValues.get("strOpinionDetails"));
			str_stmt_dt_from=Helper.correctNull((String)hshValues.get("strAccountStatementFrom"));
			str_stmt_dt_to=Helper.correctNull((String)hshValues.get("strAccountStatementTo"));
			str_stmt_comments=Helper.correctNull((String)hshValues.get("strComments"));
			//str_due_due=Helper.correctNull((String)hshValues.get("strAsOnDateOvrdue"));
			str_due_due=Helper.correctNull((String)hshValues.get("strInstallmentLastDate"));
			
			
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(loan_frombank);
				arrValues.add(correctNull((String) hshValues.get("strLoanFromBank")));
				arrValues.add(loanamt_transbank);
				arrValues.add(installamt_transbank);
				arrValues.add(correctNull((String) hshValues.get("strRepaymentPeriod")));
				String avail_date=Helper.correctNull((String) hshValues.get("strLateOfAvailing"));
				if(avail_date.equalsIgnoreCase(""))
				{
					avail_date="01/01/1900";
				}
				arrValues.add(avail_date);
				String fromdate=Helper.correctNull((String) hshValues.get("strInstallmentStartDate"));
				if(fromdate.equalsIgnoreCase(""))
				{
					fromdate="01/01/1900";
				}
				arrValues.add(fromdate);
				arrValues.add(tot_liability );
				arrValues.add(correctNull((String) hshValues.get("strNoOfInstallmentPaid")));
				
				String ason_date=Helper.correctNull((String) hshValues.get("strAsOnDateOvrdue"));
				if(ason_date.equalsIgnoreCase(""))
				{
					ason_date="01/01/1900";
				}
				arrValues.add(ason_date);	
				String uptodate=Helper.correctNull((String) hshValues.get("strUptoDate"));
				if(uptodate.equalsIgnoreCase(""))
				{
					uptodate="01/01/1900";
				}
				
					
				arrValues.add(uptodate);	
				arrValues.add(Helper.correctNull((String) hshValues.get("strRegularLoanAcc")));
				arrValues.add(overdue_install);
				arrValues.add(overdue_interest);
				arrValues.add(tot_overdue);
				arrValues.add(takeover_amtpaid );
				arrValues.add(Helper.correctNull((String) hshValues.get("strInstallmentTrnsBank")));
				String Overason_date=Helper.correctNull((String) hshValues.get("strAsOnDateOvrdue"));
				if(Overason_date.equalsIgnoreCase(""))
				{
					Overason_date="01/01/1900";
				}
				arrValues.add(Overason_date);
				arrValues.add(str_shifting_reason);
				arrValues.add(str_holiday_period);
				arrValues.add(str_rate_of_interest);
				arrValues.add(str_prevbank_opinion);
				arrValues.add(str_stmt_dt_from);
				arrValues.add(str_stmt_dt_to);
				arrValues.add(str_stmt_comments);
				arrValues.add(str_due_due);
				arrValues.add("");
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "takeoverins");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			//RepaymentSchedule	
			ArrayList arrRepaySchedule=new ArrayList();
			ArrayList arrrepayValue=new ArrayList();
			arrRepaySchedule=(ArrayList) hshValues.get("arrRepaymentSchedule");
			int arrrepayScheduleSize=arrRepaySchedule.size();
			int serialNo=0;
			int facCode=1;
			if(arrrepayScheduleSize>0)
			{
				for(int i=0;i<arrrepayScheduleSize;i++)
				{
			serialNo++;	
			arrrepayValue=(ArrayList) arrRepaySchedule.get(i);
			
			
			String frequency=correctNull((String)arrrepayValue.get(0));
			String instlmntAmount=Helper.correctInt((String)arrrepayValue.get(1));
			String noInstlmnt=Helper.correctInt((String)arrrepayValue.get(2));
			String totalAmnt=Helper.correctInt((String)arrrepayValue.get(3));
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_repaymnt_schdule");
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(String.valueOf(serialNo));
			arrValues.add(String.valueOf(facCode));
			arrValues.add(frequency);
			arrValues.add(instlmntAmount);
			arrValues.add(noInstlmnt);
			arrValues.add(totalAmnt);
			arrValues.add("P");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
				}
			
			//home comfort,topup loan and Home connect
			if(strloanpurpose.equalsIgnoreCase("F") || strloanpurpose.equalsIgnoreCase("T")|| strloanpurpose.equalsIgnoreCase("HC"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "updcomworkflowappamt");
				arrValues = new ArrayList();
				arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
				if(strloanpurpose.equalsIgnoreCase("F"))
				{
					arrValues.add("75");
				}
				else
				{
					arrValues.add("");
				}
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			}
			
			hshValues.put("strApplication", strApplicationNo);
			hshValues.put("strResponseCode", "LAPS-1010");
			hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForHL..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean ProposalCreationForHL in closing connection..."+e.toString());
		}
	}
	
	return hshValues;
	
}


/*public HashMap getDocURLs(HashMap hshValues)  
{
		ResultSet rs = null;
		String strQuery="",strApplicationNo="",strDmsRefNo="";
		ArrayList arrValues = null;
		HashMap hshRecord= new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();

		try {
			
			strApplicationNo = Helper.correctNull((String)hshValues.get("app_no"));
			if(strApplicationNo.equals(""))
			{
				strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			
			//delete doc attachmennts
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_appdoc_extappl");
			hshQueryValues.put("1",hshQuery);
			
			//delete external appplication document
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_docattach_extappl");
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			
			*//**************************Connection Establishing to ibm portal for the Documents********************************************//*
			
			System.out.println("################@@@@@@@@@@@@@ Login to IBM dms request  @@@@@@@@@@@@@################");
			log.info("################@@@@@@@@@@@@@ Request Login to IBM dms request  @@@@@@@@@@@@@################");
			
			URL logintoibm_url = new URL(ApplicationParams.getStrlogintoibm());
			HttpURLConnection logintoibm_urlcon = (HttpURLConnection) logintoibm_url.openConnection();
			logintoibm_urlcon.setRequestProperty("User-Agent", "");
			logintoibm_urlcon.setDoInput(true);
			logintoibm_urlcon.setDoOutput(true);
			logintoibm_urlcon.setRequestMethod("POST");
			logintoibm_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
			logintoibm_urlcon.setRequestProperty("Authorization", "Basic");
			
			//String url = System.getProperty("loginapi")+System.getProperty("loginuser")+"&password="+System.getProperty("loginpass");

			System.out.println("################@@@@@@@@@@@@@ Login to IBM dms Url  @@@@@@@@@@@@@################"+logintoibm_url);
			log.info("################@@@@@@@@@@@@@ Login to IBM dms Url  @@@@@@@@@@@@@################"+logintoibm_url);
			
			*//**************************Read the Documents********************************************//*
			
	        final SessionFactory factory = (SessionFactory)SessionFactoryImpl.newInstance();
	        final Map<String, String> parameter = new HashMap<String, String>();

	        strQuery = SQLParser.getSqlQuery("SEL_DIGI_DMS_CONNECTION");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
		        parameter.put("org.apache.chemistry.opencmis.user", Helper.correctNull((String)rs.getString("username")));
		        parameter.put("org.apache.chemistry.opencmis.password", Helper.correctNull((String)rs.getString("password")));
		        parameter.put("org.apache.chemistry.opencmis.binding.spi.type", BindingType.WEBSERVICES.value());
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.RepositoryService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.DiscoveryService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.ACLService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.MultiFilingService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.PolicyService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.RelationshipService",Helper.correctNull((String)rs.getString("wsdlservice")) );
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.ObjectService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.VersioningService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.binding.webservices.NavigationService", Helper.correctNull((String)rs.getString("wsdlservice")));
		        parameter.put("org.apache.chemistry.opencmis.session.repository.id", Helper.correctNull((String)rs.getString("repositoryId")));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_leadnumber_appno^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strDmsRefNo=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));
    		}
    		
	        System.out.println("Session creation");
	        org.apache.chemistry.opencmis.client.api.Session session = factory.createSession((Map)parameter);
	        List docurls = new ArrayList();
	        String queryString = "Select ID, cmis:objectTypeId,LOS_DocCode,cmis:name, DocumentTitle  from Document where LOS_Leadnumber = '" + strDmsRefNo +"'";
	        OperationContext opCon = session.createOperationContext();
	        opCon.setIncludeRelationships(IncludeRelationships.SOURCE);
	        ItemIterable<QueryResult> results = session.query(queryString, false);
	       // JSONObject docnode = new JSONObject();
	        for (QueryResult qResult : results) {
		    JSONObject docnode = new JSONObject();
	            String id = qResult.getPropertyValueByQueryName("ID");
	            id = id.substring(4,id.length());

	            String objectIdType = qResult.getPropertyValueByQueryName("cmis:objectTypeId");
	            String doccode = qResult.getPropertyValueByQueryName("LOS_DocCode");
	            String docType = qResult.getPropertyValueByQueryName("cmis:objectTypeId");
	            String docname = qResult.getPropertyValueByQueryName("cmis:name");
		    //docnode.put("Docurl","https://172.16.224.161:9443/navigator/bookmark.jsp?desktop=DigiLoan&repositoryId=icmcmtos&repositoryType=p8&docid={" + id + "}&template_name="+ objectIdType);
		    docnode.put("Docurl","https://icndba.ktkbank.com:9443/navigator/bookmark.jsp?desktop=DigiLoan&repositoryId=icmcmtos&repositoryType=p8&docid={" + id + "}&template_name="+ objectIdType);
	            docnode.put("Docname", docname);
	            docnode.put("DocCode",doccode); 
		    docnode.put("DocType",docType);
		    docurls.add(docnode.toString());
	           // docurls.add("https://172.16.224.161:9444/navigator/bookmark.jsp?desktop=baw&repositoryId=icmcmtos&repositoryType=p8&docid={" + id + "}&template_name="+ objectIdType);
	        }
			hshValues.put("DIGI_DMS_CONNECTION", parameter);

			
		}
	catch (Exception ex) {
		ex.printStackTrace();
		throw new EJBException("Error in getDocURLs"+ex.toString());
		
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

	 return  hshValues;
	 }*/
public HashMap fetchUserDetails(HashMap hshValues)  
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strorgCode="";
	
	try
	{	
		 strorgCode=Helper.correctNull((String)hshValues.get("strorgCode"));
		 String struserorgcode="0";
			 
			ArrayList arrappref=new ArrayList();
		
			if(rs!=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("SEL_USERORG^"+strorgCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				HashMap hashappref=new HashMap();
				
				hashappref.put("USR_FNAME", Helper.correctNull((String)rs.getString("USR_FNAME")));
				hashappref.put("ORG_SCODE", Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hashappref.put("ORG_NAME", Helper.correctNull((String)rs.getString("ORG_NAME")));
				hashappref.put("ORG_LEVEL", Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hashappref.put("USER_DESIGNATION", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
				hashappref.put("USR_CLASS", Helper.correctNull((String)rs.getString("USR_CLASS")));
				hashappref.put("USR_DEPARTMENT", Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				hashappref.put("USR_FUNCTION", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
				hashappref.put("USR_GRPID", Helper.correctNull((String)rs.getString("USR_GRPID")));
				hashappref.put("USR_ID", Helper.correctNull((String)rs.getString("USR_ID")));
				arrappref.add(hashappref);
				
				struserorgcode=Helper.correctNull((String)rs.getString("usr_orgcode"));
			}
			
			if(!struserorgcode.equals("0"))
			{
			hshValues.put("users", arrappref);
			}else{
				hshValues.put("users", "Data not found");
			}
		
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean fetchUserDetails..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean fetchUserDetails in  closing connection ..."+e.toString());
		}
	}
	
	return hshValues;
}
public HashMap UCICExecuteService(HashMap hshValues)  
{
	String strQuery="";
	ResultSet rs = null,rs1 = null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();

try {
	
	String strInputXMLRequest = "",strResStatus="",line="",strRequestUUID="",strbnkid="",strMessageDateTime="",strpano="",strMObnum="",strCustId = "",strResCustDesc="",strCustName = "",strCustDob="",strCustPan="",strCustMobNum="",strCustPassport=""
		,strCustVoterID="",strCustDrivingLicense="",strUID="",strNaregaCard="",strCustOther="",strCustId1="",strCustId2="",strCustId3="",strCustId4="",strAction="",strCustomerID="",strCustId5="",strCustName1="",strCustName2="",strCustName3="",strCustName4="",strCustName5="",strAadhId="";
	strRequestUUID = Helper.correctNull((String) hshValues.get("strappno"));
	if(strRequestUUID.equalsIgnoreCase("")){
	strRequestUUID = Helper.correctNull((String) hshValues.get("appno"));
	}
	String strApplicantID =Helper.correctNull((String) hshValues.get("hidborrowerid"));  
	strAction=Helper.correctNull((String) hshValues.get("hidAction"));
	strCustomerID=Helper.correctNull((String) hshValues.get("selctuciccbsid"));
	if(strCustomerID.equalsIgnoreCase("")){
		strCustomerID=Helper.correctNull((String) hshValues.get("chk_cbsid"));
	}
	
	String inwardno = Helper.correctNull((String) hshValues.get("inwardno"));
	if(inwardno.equalsIgnoreCase(""))
	{
	 strQuery = SQLParser.getSqlQuery("compropform6^"+strRequestUUID);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			inwardno = Helper.correctNull((String)rs.getString("APP_INWARDNO"));			
		}
	}
	
	if(strAction.equalsIgnoreCase("get")){
	SimpleDateFormat simpledateformat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	strMessageDateTime=simpledateformat.format(new Date());

	rs = DBUtils.executeLAPSQuery("sel_cbsIdCreation^" + strApplicantID);
	if (rs.next()) {
		strCustName = Helper.correctNull((String) rs.getString("PERAPP_FNAME"));
		strCustDob = Helper.correctNull((String) rs.getString("PERAPP_DOB"));
		strCustMobNum = Helper.correctNull((String) rs.getString("CON_MOBILE"));
		strCustPan = Helper.correctNull((String) rs.getString("PERAPP_PANNO"));
		if(strCustPan.equalsIgnoreCase("NOPAN")){
			strCustPan="";
		}
		strCustId = Helper.correctNull((String) rs.getString("PERAPP_CBSID"));
		strAadhId = Helper.correctNull((String) rs.getString("PERAPP_AADHAAR"));

	}
	
	
	
	
	strInputXMLRequest = "<?xml version='1.0' encoding='UTF-8'?>" +
			"<FIXML xsi:schemaLocation='http://www.finacle.com/fixml executeFinacleScript.xsd' xmlns='http://www.finacle.com/fixml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>" +
				"<Header>" +
				 	"<RequestHeader>" +
				 	  "<MessageKey>" +
						 	  	"<RequestUUID>"+strRequestUUID+"</RequestUUID>" +
					 	  		"<ServiceRequestId>executeFinacleScript</ServiceRequestId>" +
					 	  		"<ServiceRequestVersion>10.2</ServiceRequestVersion>" +
					 	  		"<ChannelId>COR</ChannelId><LanguageId/>" +
			 	  		"</MessageKey>" +
			 	  		"<RequestMessageInfo>" +
					 	  		"<BankId>"+strbnkid+"</BankId>" +
					 	  		"<TimeZone/>" +
					 	  		"<EntityId/><EntityType/>" +
					 	  		"<ArmCorrelationId/>" +
								"<MessageDateTime>"+strMessageDateTime+"</MessageDateTime>" +
						"</RequestMessageInfo>" +
							"<Security>" +
								"<Token>" +
									"<PasswordToken>" +
										"<UserId/>" +
										"<Password/>" +
									"</PasswordToken>" +
								"</Token>" +
						"<FICertToken/><RealUserLoginSessionId/>" +
						"<RealUser/><RealUserPwd/><SSOTransferToken/>" +
						"</Security></RequestHeader>" +
				"</Header>" +
						"<Body><executeFinacleScriptRequest>" +
							"<ExecuteFinacleScriptInputVO><requestId>Fi_GetCustId.scr</requestId>" +
										"</ExecuteFinacleScriptInputVO><executeFinacleScript_CustomData>" +
												"<panNo>"+strCustPan+"</panNo>" +
												"<aadharNo>"+strAadhId+"</aadharNo>" +
												"<passportNo></passportNo>" +
												"<mobileNo></mobileNo>" +
										"</executeFinacleScript_CustomData></executeFinacleScriptRequest>" +
						"</Body>" +
			"</FIXML>";
	
	log.info("################@@@@@@@@@@@@@ CBS ID UCIC Request @@@@@@@@@@@@@################"
					+ strInputXMLRequest);
	URL url = new URL(ApplicationParams.getStrCBSIDModification());
	log.info("cbsIdUCICService Url========== "+url);		
	HttpsURLConnection urlcon = (HttpsURLConnection) url.openConnection();
			
	urlcon.setRequestProperty("User-Agent", "");
	urlcon.setDoInput(true);
	urlcon.setDoOutput(true);
	urlcon.setRequestMethod("POST");
	urlcon.setRequestProperty("Content-Type","application/xml;charset=UTF-8");
	urlcon.setRequestProperty("Authorization", "Basic");
	OutputStream outputStream = urlcon.getOutputStream();
	OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
			
	BufferedWriter bWriter = new BufferedWriter(osw);
	bWriter.write(strInputXMLRequest);
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
		log.info("################@@@@@@@@@@@@@ CBS ID UCIC Response @@@@@@@@@@@@@################"
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
		              strResStatus=(String)((Element)nodesListheader.item(0)).getElementsByTagName("Status").item(0).getChildNodes().item(0).getNodeValue();							

		              NodeList nodesList = doc.getElementsByTagName("Body");
		              if(strResStatus.equalsIgnoreCase("SUCCESS"))
		              {
		            	  strCustId1=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId_1").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustId2=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId_2").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustId3=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId_3").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustId4=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId_4").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustId5=(String)((Element)nodesList.item(0)).getElementsByTagName("CustId_5").item(0).getChildNodes().item(0).getNodeValue();

		            	  strCustName1=(String)((Element)nodesList.item(0)).getElementsByTagName("CustName_1").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustName2=(String)((Element)nodesList.item(0)).getElementsByTagName("CustName_2").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustName3=(String)((Element)nodesList.item(0)).getElementsByTagName("CustName_3").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustName4=(String)((Element)nodesList.item(0)).getElementsByTagName("CustName_4").item(0).getChildNodes().item(0).getNodeValue();
		            	  strCustName5=(String)((Element)nodesList.item(0)).getElementsByTagName("CustName_5").item(0).getChildNodes().item(0).getNodeValue();

		            	  if(strCustId1.equalsIgnoreCase("NULL") && strCustId2.equalsIgnoreCase("NULL") && strCustId3.equalsIgnoreCase("NULL") && strCustId4.equalsIgnoreCase("NULL")
		            			  && strCustId5.equalsIgnoreCase("NULL"))
		            	  {
		            			
		            			hshQueryValues=new HashMap();
		            			hshQuery=new HashMap();
		            			arrValues=new ArrayList();
		            			hshQuery.put("strQueryId","update_ucicn_perapplicant");
		            			arrValues.add("N");//perapp_ucicflag
		            			arrValues.add(strApplicantID);//perapp_id
		            			hshQuery.put("arrValues",arrValues);
		            			hshQueryValues.put("1",hshQuery);
		            			hshQueryValues.put("size","1");
		            			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		            			
		            	  }
		            	  hshValues.put("strCustId1", strCustId1);
		            	  hshValues.put("strCustId2", strCustId2);
		            	  hshValues.put("strCustId3", strCustId3);
		            	  hshValues.put("strCustId4", strCustId4);
		            	  hshValues.put("strCustId5", strCustId5);
		            	  hshValues.put("strCustName1", strCustName1);
		            	  hshValues.put("strCustName2", strCustName2);
		            	  hshValues.put("strCustName3", strCustName3);
		            	  hshValues.put("strCustName4", strCustName4);
		            	  hshValues.put("strCustName5", strCustName5);
		              }
		              else
		              {
		            	strResCustDesc=(String)((Element)nodesList.item(0)).getElementsByTagName("ErrorDesc").item(0).getChildNodes().item(0).getNodeValue();
		              }
                    
			if(!strResStatus.equalsIgnoreCase("Success"))
			{
			    	hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "ins_cbs_api_error_status");
					arrValues = new ArrayList();
					arrValues.add(strCustId);
					arrValues.add(strResCustDesc);//appraised by
					arrValues.add(strRequestUUID);
					arrValues.add("CBS Id UCIC");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			}
		} 
		catch (Exception e) 
		{
			System.out.println("Exception.....................");
			e.printStackTrace();
			throw new EJBException("Exception in ParserConfiguratio ==="+e.getMessage());
		}
	}

		 if(strCustId1.equalsIgnoreCase("NULL") && strCustId2.equalsIgnoreCase("NULL") && strCustId3.equalsIgnoreCase("NULL") && strCustId4.equalsIgnoreCase("NULL")
   			  && strCustId5.equalsIgnoreCase("NULL"))
   	  {
   			
   			hshQueryValues=new HashMap();
   			hshQuery=new HashMap();
   			arrValues=new ArrayList();
   			hshQuery.put("strQueryId","update_ucicn_perapplicant");
   			arrValues.add("N");//perapp_ucicflag
   			arrValues.add(strApplicantID);//perapp_id
   			hshQuery.put("arrValues",arrValues);
   			hshQueryValues.put("1",hshQuery);
   			hshQueryValues.put("size","1");
   			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
   			
   	  }
   	  hshValues.put("strCustId1", strCustId1);
   	  hshValues.put("strCustId2", strCustId2);
   	  hshValues.put("strCustId3", strCustId3);
   	  hshValues.put("strCustId4", strCustId4);
   	  hshValues.put("strCustId5", strCustId5);
     
	}else if(strAction.equals("Save")){
	
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
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_ucicdemo");
			arrValues.add(perappolid);//demo_oldappid
			arrValues.add(strRequestUUID);//demo_appno
			arrValues.add(strApplicantID);//demo_appid
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
			hshQueryValues.put("size","3");
			
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("seleligibileconst^" + strRequestUUID);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_cbsid_inwardreg");
			arrValues.add(strCustomerID);//INWARD_CBSCUSTID
			arrValues.add(inwardno);//INWARD_NO
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("4",hshQuery);
			hshQueryValues.put("size","4");
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}else{
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","update_ucic_perapplicant");
			arrValues.add(strCustomerID);//perapp_cbsid
			arrValues.add("Y");//perapp_dedupeflag
			arrValues.add("Y");//perapp_ucicflag
			arrValues.add(strApplicantID);//perapp_id
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("seleligibileconst^" + strRequestUUID);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_cbsid_inwardreg");
			arrValues.add(strCustomerID);//INWARD_CBSCUSTID
			arrValues.add(inwardno);//INWARD_NO
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
}
rs = DBUtils.executeLAPSQuery("empstatus^" + strApplicantID);
if (rs.next()) {
	hshValues.put("strCustomerID", Helper.correctNull((String) rs.getString("PERAPP_CBSID")));
	hshValues.put("strcbscustflag", Helper.correctNull((String) rs.getString("PERAPP_CBSCUSTFLAG")));
	hshValues.put("strdedupflag", Helper.correctNull((String) rs.getString("perapp_dedupeflag")));
}
} 
catch (Exception ex) 
{
	throw new EJBException("Error in UCICExecuteService"+ex.toString());
}

finally {
	try {
		if (rs != null) {
			rs.close();
		}
	} catch (Exception e) {
		e.printStackTrace();
		throw new EJBException("Error in UCICExecuteService closing Connection "+e.getMessage());
	}
}
return hshValues;

}
public HashMap fetchUserOrganisationsDetails(HashMap hshValues)  
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null,rs2=null;
	String strQuery="";
	
	try
	{	
		String strloginUserID=Helper.correctNull((String)hshValues.get("strloginUserID"));
		String struserorgcode="0",strrousers="",strrousersmerge="",org_scode="";
		
		if(rs!=null){rs.close();}
		strQuery=SQLParser.getSqlQuery("setuserssel2^"+strloginUserID);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("user_name",Helper.correctNull((String)rs.getString("usr_fname")));
			hshRecord.put("user_function",Helper.correctNull((String)rs.getString("usr_function")));
			hshRecord.put("user_designation",Helper.correctNull((String)rs.getString("user_designation")));
			hshRecord.put("user_department",Helper.correctNull((String)rs.getString("usr_department")));
			hshRecord.put("user_classpower",Helper.correctNull((String)rs.getString("usr_class")));
			hshRecord.put("user_group",Helper.correctNull((String)rs.getString("usr_grpid")));
			hshRecord.put("user_solid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
			
			struserorgcode=Helper.correctNull((String)rs.getString("usr_orgcode"));
		}

		ArrayList arrappref2=new ArrayList();
		ArrayList arrappref=new ArrayList();
		ArrayList arrappref3=new ArrayList();
		
		if(!struserorgcode.equals("0"))
		{
			HashMap hashappref=new HashMap();
		
			if(rs!=null){rs.close();}
			strrousers = struserorgcode.substring(0,6);
			strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_mergeorg^"+strrousers+"^"+"R");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
				{
					org_scode = Helper.correctNull((String)rs.getString("org_scode"));
					 if(org_scode.equalsIgnoreCase("R888") || org_scode.equalsIgnoreCase("R250") || org_scode.equalsIgnoreCase("R450") || org_scode.equalsIgnoreCase("R800"))
					{
							org_scode = "R888";
					}else if (org_scode.equalsIgnoreCase("R950") || org_scode.equalsIgnoreCase("R500") || org_scode.equalsIgnoreCase("R350") 
								|| org_scode.equalsIgnoreCase("R650"))	
					{
						org_scode = "R950";
					}else{
						org_scode = "R600";
					}
						if(!org_scode.equalsIgnoreCase(""))
						{
							if(rs1!=null){rs1.close();}
							strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_mergeorg_scode^"+org_scode+"^"+"R");
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{ 
									strrousersmerge = Helper.correctNull((String)rs1.getString("org_code"));
							}		
									if(rs2!=null){rs2.close();}
									strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_org^"+strrousersmerge);
									rs2=DBUtils.executeQuery(strQuery);
									while(rs2.next())
									{
										hashappref=new HashMap();
										hashappref.put("roUser_id", Helper.correctNull((String)rs2.getString("USR_ID")));
										hashappref.put("roUser_name", Helper.correctNull((String)rs2.getString("USR_FNAME")));
										hashappref.put("roUser_designation", Helper.correctNull((String)rs2.getString("USER_DESIGNATION")));
										hashappref.put("roUser_classpower", Helper.correctNull((String)rs2.getString("USR_CLASS")));
										hashappref.put("roUser_function", Helper.correctNull((String)rs2.getString("USR_FUNCTION")));
										arrappref.add(hashappref);
									}
						}
					
			}
			HashMap hashappref2=new HashMap();
			if(rs!=null){rs.close();}
			
			strrousers = struserorgcode.substring(0,6);
			strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_mergeorg^"+strrousers+"^"+"D");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
				{
					org_scode = Helper.correctNull((String)rs.getString("org_scode"));
					 if(org_scode.equalsIgnoreCase("888") || org_scode.equalsIgnoreCase("250") || org_scode.equalsIgnoreCase("450") || org_scode.equalsIgnoreCase("800"))
					{
							org_scode = "888";
					}else if (org_scode.equalsIgnoreCase("950") || org_scode.equalsIgnoreCase("500") || org_scode.equalsIgnoreCase("350") 
								|| org_scode.equalsIgnoreCase("650"))	
					{
						org_scode = "950";
					}else{
						org_scode = "600";
					}
						if(!org_scode.equalsIgnoreCase(""))
						{
							if(rs1!=null){rs1.close();}
							strQuery=SQLParser.getSqlQuery("sel_delegatedAuthority_mergeorg_scode^"+org_scode+"^"+"D");
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{ 
									strrousersmerge = Helper.correctNull((String)rs1.getString("org_code"));
							}
							
							strrousersmerge = strrousersmerge.substring(0,6);
							strQuery=SQLParser.getSqlQuery("sel_rlpc_delegatedauthoirty_org^"+strrousersmerge);
							rs2=DBUtils.executeQuery(strQuery);
							while(rs2.next())
							{
								hashappref2=new HashMap();
								hashappref2.put("rlpcUser_id", Helper.correctNull((String)rs2.getString("USR_ID")));
								hashappref2.put("rlpcUser_name", Helper.correctNull((String)rs2.getString("USR_FNAME")));
								hashappref2.put("rlpcUser_designation", Helper.correctNull((String)rs2.getString("USER_DESIGNATION")));
								hashappref2.put("rlpcUser_classpower", Helper.correctNull((String)rs2.getString("USR_CLASS")));
								hashappref2.put("rlpcUser_function", Helper.correctNull((String)rs2.getString("USR_FUNCTION")));
								arrappref2.add(hashappref2);
							}
			
						}
				}
			HashMap hashappref3=new HashMap();
			if(rs!=null){rs.close();}
			strQuery=SQLParser.getSqlQuery("sel_HO_delegatedauthoirty_org");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hashappref3=new HashMap();
				hashappref3.put("HOUser_id", Helper.correctNull((String)rs.getString("USR_ID")));
				hashappref3.put("HOUser_name", Helper.correctNull((String)rs.getString("USR_FNAME")));
				hashappref3.put("HOUser_designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
				hashappref3.put("HOUser_classpower", Helper.correctNull((String)rs.getString("USR_CLASS")));
				hashappref3.put("HOUser_function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
				
				arrappref3.add(hashappref3);
			}
			
			
			
			
			hshValues.put("user_details", hshRecord);
			hshValues.put("RO_users", arrappref);
			hshValues.put("RLPC_users", arrappref2);
			hshValues.put("HO_users", arrappref3);
		
		}
		else
		{
			hshValues.put("user_details", "Data not found");
			hshValues.put("RO_users", arrappref);
			hshValues.put("RLPC_users", arrappref2);
			hshValues.put("HO_users", arrappref3);
		}
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean fetchUserOrganisationsDetails..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean fetchUserOrganisationsDetails in  closing connection ..."+e.toString());
		}
	}
	
	return hshValues;
}

public HashMap IFSCcodeCheck(HashMap hshValues)  
{
	String strQuery="",strBankname="",strifsccodecrop="",strFINBankname="";
	ResultSet rs=null;
	try{
		String strifsccode=correctNull((String)hshValues.get("ifsccode"));
		
		if(!strifsccode.equalsIgnoreCase("")){
			
			if (strifsccode.length() > 4) 
			{
				strifsccodecrop = strifsccode.substring(0, 4);
			} 
			
			strQuery=SQLParser.getSqlQuery("sel_enach_ifsc^"+strifsccodecrop);
	 		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBankname = Helper.correctInt((String)rs.getString("stat_data_desc"));
				hshValues.put("strBankname", strBankname);

			}
		
		
		strQuery=SQLParser.getSqlQuery("sel_ifsc_fin^"+strifsccode);
 		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strFINBankname = Helper.correctInt((String)rs.getString("Bank_name"));
			hshValues.put("strFINBankname", strFINBankname);

		}
		}
		
		
	}catch (Exception e)
	{
		log.error("Error occurred in updateDigiLoanProducts:: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
public HashMap IFSCcodeLapsCheck(HashMap hshValues)  
{
	String strQuery="",strBankname="",strifsccodecrop="",strFINBankname="",strBranchname="",strBankingname="";
	ResultSet rs=null;
	try{
		String strifsccode=correctNull((String)hshValues.get("ifsccode"));
		
		if(!strifsccode.equalsIgnoreCase("")){
			
			if (strifsccode.length() > 4) 
			{
				strifsccodecrop = strifsccode.substring(0, 4);
			} 
			
			strQuery=SQLParser.getSqlQuery("sel_enach_ifsc^"+strifsccodecrop);
	 		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBankname = Helper.correctInt((String)rs.getString("stat_data_desc"));
				hshValues.put("strBankname", strBankname);

			}
		
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getSqlQuery("sel_ifsc_laps_fin^"+strifsccode);
		 		rs=DBUtils.executeQuery(strQuery);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_ifsc_fin^"+strifsccode);
		 		rs=DBUtils.executeQuery(strQuery);
			}
		
		if(rs.next())
		{
			strFINBankname = Helper.correctInt((String)rs.getString("Bank_name"));
			hshValues.put("strFINBankname", strFINBankname);
			strBankingname=Helper.correctNull((String)rs.getString("Bank_name"));
			strBranchname=Helper.correctNull((String)rs.getString("br_name"));
			hshValues.put("strBankingname", strBankingname);
			hshValues.put("strBranchname", strBranchname);
		}
		}
		
		
	}catch (Exception e)
	{
		log.error("Error occurred in updateDigiLoanProducts:: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
public HashMap FinalInPrinciple(HashMap hshValues)  
{
	ResultSet rs=null,rs1=null;
	try{
		String strQuery="",strprocessFromDate="",strSchemeCode="",strflag="0",strdigiAppno="",strprocessToDate="";
		strprocessFromDate=Helper.correctNull((String)hshValues.get("strprocessFromDate"));
		strSchemeCode=Helper.correctNull((String)hshValues.get("strSchemeCode"));
		strdigiAppno=Helper.correctNull((String)hshValues.get("strdigiAppno"));
		strprocessToDate=Helper.correctNull((String)hshValues.get("strprocessToDate"));

			ArrayList arrappref=new ArrayList();
			ArrayList arrappref2=new ArrayList();
			ArrayList arrappref1=new ArrayList();

			if(rs!=null){rs.close();}
			if(!strdigiAppno.equalsIgnoreCase("")){
			strQuery=SQLParser.getSqlQuery("sel_final_retail_digiappno^"+strdigiAppno);
			}else{
			strQuery=SQLParser.getSqlQuery("sel_final_retail^"+strprocessFromDate+"^"+strprocessToDate+"^"+strSchemeCode);
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				HashMap hashappref1=new HashMap();
				arrappref=new ArrayList();
				String app_no = Helper.correctNull((String)rs.getString("app_no"));
				hashappref1.put("proposalNo", Helper.correctNull((String)rs.getString("app_no")));
				hashappref1.put("ApplicationRefNum", Helper.correctNull((String)rs.getString("inward_digiappno")));
				hashappref1.put("custId", Helper.correctNull((String)rs.getString("perapp_cbsid")));

				arrappref.add(hashappref1);

				arrappref2=new ArrayList();
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_final_ret^"+app_no);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
				HashMap hashappref2=new HashMap();
				
				hashappref2.put("SanctionAmount", Helper.correctNull((String)rs1.getString("LOAN_RECMDAMT")));
				hashappref2.put("InterestRate", Helper.correctNull((String)rs1.getString("LOAN_MODINTRATE")));
				/*String facilityStatus=Helper.correctNull((String)rs1.getString("FACILITY_SANCSTATUS"));
				String facStatus="";
				if(facilityStatus.equals("A"))
					facStatus="ACCEPTED";
				if(facilityStatus.equals("R"))
					facStatus="REJECTED";*/
				hashappref2.put("Status", "ACCEPTED");
				hashappref2.put("HolidayPeriod", Helper.correctNull((String)rs1.getString("LOAN_NOOFINSTALLMENT")));
				hashappref2.put("facilityTenor", Helper.correctNull((String)rs1.getString("LOAN_PREMIUM_TENOR")));
				hashappref2.put("facilityName", Helper.correctNull((String)rs1.getString("PRD_DESC")));
				hashappref2.put("loanAmount", Helper.correctNull((String)rs1.getString("LOAN_RECMDAMT")));
				//hashappref2.put("interestRec", Helper.correctNull((String)rs1.getString("FACILITY_INTERESTREC")));
				hashappref2.put("sancRefNo", Helper.correctNull((String)rs1.getString("SANCTIONREFNO")));
				hashappref2.put("approvedDate", Helper.correctNull((String)rs1.getString("APP_PROCESSDATE")));
				hashappref2.put("companyName", Helper.correctNull((String)rs1.getString("LOAN_INS_COMPANY_NAME")));
				hashappref2.put("processingFee", Helper.correctNull((String)rs1.getString("LOAN_PROFEE")));
				hashappref2.put("sanctionAuth", Helper.correctNull((String)rs1.getString("APPRAISAL_SANCAUTH")));
				hashappref2.put("CollartralAmount", Helper.correctNull((String)rs1.getString("LOAN_SECVALUE")));
				hashappref2.put("sanctionDept", Helper.correctNull((String)rs1.getString("APPRAISAL_DEPARTMENT")));
				hashappref2.put("Tenor", Helper.correctNull((String)rs1.getString("loan_reqterms")));
				hashappref2.put("interestRec", Helper.correctNull((String)rs1.getString("LOAN_SERVISED")));
				hashappref2.put("approvedDate", Helper.correctNull((String)rs1.getString("APP_PROCESSDATE")));
				hashappref2.put("ageofVehicle", Helper.correctNull((String)rs1.getString("LOAN_AGEOFVEH")));
				hashappref2.put("margin", Helper.correctNull((String)rs1.getString("LOAN_MARGIN")));
				hashappref2.put("costofproduct", Helper.correctNull((String)rs1.getString("LOAN_COSTLOANPRD")));
				hashappref2.put("FacilityId", "0");
				arrappref2.add(hashappref2);
				}
				arrappref.add(arrappref2);

				HashMap hashappref3=new HashMap();
				hashappref3.put("name", Helper.correctNull((String)rs.getString("USR_FNAME")));
				hashappref3.put("approvedBy", Helper.correctNull((String)rs.getString("APP_APPROVEDBY")));
				hashappref3.put("classPower", Helper.correctNull((String)rs.getString("USR_CLASS")));
				hashappref3.put("designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
				hashappref3.put("approvedorg", Helper.correctNull((String)rs.getString("APP_APPROVEDORGSCODE")));
				hashappref3.put("group", Helper.correctNull((String)rs.getString("USR_GRPID")));
				hashappref3.put("function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
				hashappref3.put("solid", Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hashappref3.put("department", Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				arrappref.add(hashappref3);
				
				arrappref1.add(arrappref);
				strflag="1";
				hshValues.put("FINALINPRICPAL", "Data found");
				}
			
			if(rs!=null){rs.close();}
			if(!strdigiAppno.equalsIgnoreCase("")){
				strQuery=SQLParser.getSqlQuery("sel_final_prop_MSME_digiappno^"+strdigiAppno);
				}else{
					strQuery=SQLParser.getSqlQuery("sel_final_prop_MSME^"+strprocessFromDate+"^"+strprocessToDate+"^"+strSchemeCode);
				}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				HashMap hashappref1=new HashMap();
				arrappref=new ArrayList();
				String app_no = Helper.correctNull((String)rs.getString("app_no"));
				hashappref1.put("proposalNo", Helper.correctNull((String)rs.getString("app_no")));
				hashappref1.put("ApplicationRefNum", Helper.correctNull((String)rs.getString("inward_digiappno")));
				hashappref1.put("custId", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				arrappref.add(hashappref1);

				arrappref2=new ArrayList();
				if(rs1!=null){rs1.close();}
				strQuery=SQLParser.getSqlQuery("sel_final_MSME^"+app_no);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
				HashMap hashappref2=new HashMap();
				hashappref2.put("FacilityId", Helper.correctNull((String)rs1.getString("FACILITY_ID")));
				hashappref2.put("SanctionAmount", Helper.correctNull((String)rs1.getString("FACILITY_SANCAMT")));
				hashappref2.put("InterestRate", Helper.correctNull((String)rs1.getString("FACILITY_SANCINTEREST")));
				String facilityStatus=Helper.correctNull((String)rs1.getString("FACILITY_SANCSTATUS"));
				String facStatus="";
				if(facilityStatus.equals("A"))
					facStatus="ACCEPTED";
				if(facilityStatus.equals("R"))
					facStatus="REJECTED";
				hashappref2.put("Status", facStatus);
				hashappref2.put("HolidayPeriod", Helper.correctNull((String)rs1.getString("FACILITY_HOLIDAYPERIOD")));
				hashappref2.put("Tenor", Helper.correctNull((String)rs1.getString("FACILITY_MONTHS")));
				hashappref2.put("facilityName", Helper.correctNull((String)rs1.getString("FACILITY_CODE")));
				hashappref2.put("loanAmount", Helper.correctNull((String)rs1.getString("FACILITY_SANCAMT")));
				hashappref2.put("interestRec", Helper.correctNull((String)rs1.getString("FACILITY_INTERESTREC")));
				hashappref2.put("sancRefNo", Helper.correctNull((String)rs1.getString("SANCTIONREFNO")));
				hashappref2.put("approvedDate", Helper.correctNull((String)rs1.getString("APP_PROCESSDATE")));
				hashappref2.put("companyName", Helper.correctNull((String)rs1.getString("FAC_INS_COMPANY_NAME")));
				hashappref2.put("processingFee", Helper.correctNull((String)rs1.getString("COM_PROCESSINGFEE")));
				hashappref2.put("sanctionAuth", Helper.correctNull((String)rs1.getString("COM_SANCAUTHORITY")));
				hashappref2.put("CollartralAmount", Helper.correctNull((String)rs1.getString("FACILITY_SECAMOUNT")));
				hashappref2.put("sanctionDept", Helper.correctNull((String)rs1.getString("COM_SANCDEPT")));
				hashappref2.put("facilityTenor", "");
				hashappref2.put("ageofVehicle", "");
				hashappref2.put("costofproduct", "");
				hashappref2.put("margin", "");


				arrappref2.add(hashappref2);
				}
				arrappref.add(arrappref2);

				HashMap hashappref3=new HashMap();
				hashappref3.put("name", Helper.correctNull((String)rs.getString("USR_FNAME")));
				hashappref3.put("approvedBy", Helper.correctNull((String)rs.getString("APP_APPROVEDBY")));
				hashappref3.put("classPower", Helper.correctNull((String)rs.getString("USR_CLASS")));
				hashappref3.put("designation", Helper.correctNull((String)rs.getString("USER_DESIGNATION")));
				hashappref3.put("approvedorg", Helper.correctNull((String)rs.getString("APP_APPROVEDORGSCODE")));
				hashappref3.put("group", Helper.correctNull((String)rs.getString("USR_GRPID")));
				hashappref3.put("function", Helper.correctNull((String)rs.getString("USR_FUNCTION")));
				hashappref3.put("solid", Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hashappref3.put("department", Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));

				arrappref.add(hashappref3);
				
				arrappref1.add(arrappref);
				strflag="1";
				hshValues.put("FINALINPRICPAL", "Data found");

			}
			
			hshValues.put("user_details", arrappref1);
			
			if(strflag.equals("0"))
			{
				hshValues.put("FINALINPRICPAL", "Data not found");
			}
			
			
	}catch (Exception e)
	{
		log.error("Error occurred in FinalInPrinciple: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}

public HashMap GenDmsUpd(HashMap hshValues)  
{
	String strQuery="";
	ResultSet rs=null;
	HashMap hshQuery = new HashMap(); 
	HashMap hshQueryValues = new HashMap();
	ArrayList arrValues = new ArrayList();
	try{
		
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();
		hshQuery.put("strQueryId", "upd_dms_inward");
		arrValues = new ArrayList();
		arrValues.add(correctNull((String) hshValues.get("dmsRferenceNumber")));
		arrValues.add(correctNull((String) hshValues.get("larNumber")));
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size", "1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
		
		
	}catch (Exception e)
	{
		log.error("Error occurred in GenDmsUpd: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
}
public HashMap organisationDetails(HashMap hshValues)  
{

	String strQuery="";
	ResultSet rs=null,rs1=null;
	ArrayList arrValues = new ArrayList();
	HashMap hshRecord=new HashMap();
	HashMap hshhoRecord=new HashMap();
	HashMap hshregRecord=new HashMap();
	HashMap hshclphRecord=new HashMap();
	HashMap hshbrRecord=new HashMap();

	
	try{	
		String strorganisationCode=Helper.correctNull((String)hshValues.get("strorganisationCode"));
		String strorgcode="",strorglevel="",desc ="";
		
		if(rs!=null){rs.close();}
		strQuery=SQLParser.getSqlQuery("selectorgname^"+strorganisationCode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strorgcode=Helper.correctNull((String)rs.getString("org_code"));
		}
		

		if(rs!=null){rs.close();}
		strQuery=SQLParser.getSqlQuery("repbankname^"+strorgcode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("ORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
			hshRecord.put("ORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
			hshRecord.put("ORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
			hshRecord.put("ORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
			hshRecord.put("ORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
			hshRecord.put("ORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
			hshRecord.put("ORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
			hshRecord.put("ORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
			hshRecord.put("ORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
			hshRecord.put("ORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
			strorglevel=Helper.correctNull((String)rs.getString("ORG_LEVEL"));
		}
		ArrayList arrho=new ArrayList();
		ArrayList arrro=new ArrayList();
		ArrayList arrclph=new ArrayList();
		ArrayList arrbr=new ArrayList();

		if(strorglevel.equalsIgnoreCase("C"))
		{
			if(rs!=null){rs.close();}
			//desc ="'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'R' and org_scode != "+strorganisationCode;
			desc ="'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'C'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshhoRecord=new HashMap();
				hshhoRecord.put("HOORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshhoRecord.put("HOORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshhoRecord.put("HOORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshhoRecord.put("HOORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshhoRecord.put("HOORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshhoRecord.put("HOORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshhoRecord.put("HOORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshhoRecord.put("HOORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshhoRecord.put("HOORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshhoRecord.put("HOORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrho.add(hshhoRecord);

			}
			
			if(rs!=null){rs.close();}
			//desc ="'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'R' and org_scode != "+strorganisationCode;
			desc ="'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'R'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshregRecord=new HashMap();
				hshregRecord.put("REGORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshregRecord.put("REGORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshregRecord.put("REGORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshregRecord.put("REGORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshregRecord.put("REGORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshregRecord.put("REGORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshregRecord.put("REGORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshregRecord.put("REGORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshregRecord.put("REGORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshregRecord.put("REGORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrro.add(hshregRecord);

			}
			if(rs!=null){rs.close();}
			desc = "'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'D'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshclphRecord=new HashMap();
				hshclphRecord.put("CLPHORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshclphRecord.put("CLPHORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshclphRecord.put("CLPHORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshclphRecord.put("CLPHORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshclphRecord.put("CLPHORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshclphRecord.put("CLPHORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshclphRecord.put("CLPHORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshclphRecord.put("CLPHORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrclph.add(hshclphRecord);
			}
			if(rs!=null){rs.close();}
			desc = "'"+strorgcode.substring(0,3)+"%'  and ORG_LEVEL = 'A'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshbrRecord=new HashMap();
				hshbrRecord.put("BRORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshbrRecord.put("BRORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshbrRecord.put("BRORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshbrRecord.put("BRORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshbrRecord.put("BRORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshbrRecord.put("BRORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshbrRecord.put("BRORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrbr.add(hshbrRecord);
			}
		}
		else if(strorglevel.equalsIgnoreCase("R"))
		{	
			arrho=new ArrayList();
			arrro=new ArrayList();
			arrclph=new ArrayList();
			arrbr=new ArrayList();
			if(rs!=null){rs.close();}
			desc ="'"+strorgcode.substring(0,6)+"%'  and ORG_LEVEL = 'R'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshregRecord=new HashMap();
				hshregRecord.put("REGORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshregRecord.put("REGORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshregRecord.put("REGORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshregRecord.put("REGORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshregRecord.put("REGORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshregRecord.put("REGORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshregRecord.put("REGORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshregRecord.put("REGORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshregRecord.put("REGORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshregRecord.put("REGORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrro.add(hshregRecord);
			}
			if(rs!=null){rs.close();}
			desc = "'"+strorgcode.substring(0,6)+"%'  and ORG_LEVEL = 'D'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshclphRecord=new HashMap();
				hshclphRecord.put("CLPHORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshclphRecord.put("CLPHORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshclphRecord.put("CLPHORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshclphRecord.put("CLPHORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshclphRecord.put("CLPHORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshclphRecord.put("CLPHORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshclphRecord.put("CLPHORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshclphRecord.put("CLPHORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrclph.add(hshclphRecord);
			}
			if(rs!=null){rs.close();}
			desc = "'"+strorgcode.substring(0,6)+"%'  and ORG_LEVEL = 'A'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshbrRecord=new HashMap();
				hshbrRecord.put("BRORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshbrRecord.put("BRORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshbrRecord.put("BRORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshbrRecord.put("BRORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshbrRecord.put("BRORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshbrRecord.put("BRORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshbrRecord.put("BRORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrbr.add(hshbrRecord);
			}
		
		}else if(strorglevel.equalsIgnoreCase("D"))
		{	
			String mergedec ="";
			if(rs1!=null){rs1.close();}
			if(strorganisationCode.equals("950")){
				mergedec = "'"+strorganisationCode+"','650','500','350'";
				}else if(strorganisationCode.equals("888")){
					mergedec = "'"+strorganisationCode+"','250','450','800'";
				}else if(strorganisationCode.equals("600")){
					mergedec = "'"+strorganisationCode+"','700','850','300','400','050'";
				}
			strQuery=SQLParser.getSqlQuery("selectorgnameplhmerg^"+mergedec);
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				strorgcode=Helper.correctNull((String)rs1.getString("org_code"));
				if(rs!=null){rs.close();}
				desc = "'"+strorgcode.substring(0,9)+"%'  and ORG_LEVEL = 'D'";
				strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshclphRecord=new HashMap();
					hshclphRecord.put("CLPHORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshclphRecord.put("CLPHORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshclphRecord.put("CLPHORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
					hshclphRecord.put("CLPHORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
					hshclphRecord.put("CLPHORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
					hshclphRecord.put("CLPHORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
					hshclphRecord.put("CLPHORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
					hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
					hshclphRecord.put("CLPHORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
					hshclphRecord.put("CLPHORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
					arrclph.add(hshclphRecord);
				}
				if(rs!=null){rs.close();}
				desc = "'"+strorgcode.substring(0,9)+"%'  and ORG_LEVEL = 'A'";
				strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshbrRecord=new HashMap();
					hshbrRecord.put("BRORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshbrRecord.put("BRORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshbrRecord.put("BRORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
					hshbrRecord.put("BRORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
					hshbrRecord.put("BRORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
					hshbrRecord.put("BRORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
					hshbrRecord.put("BRORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
					hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
					hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
					hshbrRecord.put("BRORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
					arrbr.add(hshbrRecord);
				}
			}
		
		}else if(strorglevel.equalsIgnoreCase("A"))
		{	
			if(rs!=null){rs.close();}
			desc = "'"+strorgcode.substring(0,12)+"%'  and ORG_LEVEL = 'A'";
			strQuery=SQLParser.getSqlQuery("sel_orgdetailcode^"+desc);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshbrRecord=new HashMap();
				hshbrRecord.put("BRORG_LEVEL",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
				hshbrRecord.put("BRORG_SCODE",Helper.correctNull((String)rs.getString("ORG_SCODE")));
				hshbrRecord.put("BRORG_NAME",Helper.correctNull((String)rs.getString("ORG_NAME")));
				hshbrRecord.put("BRORG_ADD1",Helper.correctNull((String)rs.getString("ORG_ADD1")));
				hshbrRecord.put("BRORG_ADD2",Helper.correctNull((String)rs.getString("ORG_ADD2")));
				hshbrRecord.put("BRORG_CITY",Helper.correctNull((String)rs.getString("ORG_CITY")));
				hshbrRecord.put("BRORG_ZIP",Helper.correctNull((String)rs.getString("ORG_ZIP")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_STATE",Helper.correctNull((String)rs.getString("ORG_STATE")));
				hshbrRecord.put("BRORG_HEAD",Helper.correctNull((String)rs.getString("ORG_HEAD")));
				arrbr.add(hshbrRecord);
			}
		
		}
		if(hshRecord.equals("") && hshregRecord.equals("") && hshclphRecord .equals("") && hshbrRecord.equals(""))
		{
			hshValues.put("org_details", "Data not found");
			hshValues.put("RO_org", "Data not found");
			hshValues.put("CLPC_org", "Data not found");
			hshValues.put("BRANCH_org", "Data not found");
			hshValues.put("BRANCH_org", "Data not found");
			
		}
		else
		{
			hshValues.put("org_details", hshRecord);
			hshValues.put("RO_org", arrro);
			hshValues.put("CLPC_org", arrclph);
			hshValues.put("BRANCH_org", arrbr);	
			hshValues.put("HO_org", arrho);
		}
		
	}catch (Exception e)
	{
		log.error("Error occurred in organisationDetails: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
}

public HashMap updateDMSAppNo(HashMap hshValues) 
{
	
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	String inwardno=Helper.correctNull((String)hshValues.get("strSolid"));
	ResultSet rs=null,rs1=null;
	String strQuery="",strInwardno="";
	String uniqppNo=Helper.correctNull((String)hshValues.get("strInwardAction"));

	try
	{
		
			
			hshValues.put("strInwardno", strInwardno);
			hshValues.put("strResponseCode", "LAPS-1000");
			hshValues.put("strResponseMsg", "LAR Created Successfully");
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean updateDMSAppNo..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean updateDMSAppNo closing Connection ..."+e.toString());
		}
	}
	return hshValues;		

	
}
public HashMap proposalCreationForPJ(HashMap hshValues) throws Exception  
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	HashMap hshlockvalues=new HashMap();
	
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strApplicationNo="",strLAPSid="";
	String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
	String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
		
	int intUpdatesize=0;
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	try
	{
		
		
		Date date1;
		Date date2;
		String strDate = ApplicationParams.getStrCLPCdate();
		SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
		date1 = CLPCdate.parse(strDate);
		String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		date2 = CLPCdate.parse(NOwCalender);
		String strsolidMang = strsolid;
		
		if (date1.before(date2))
		{
			if (strsolid.equalsIgnoreCase("850")){
				strsolidMang="600";
			}
		}
		//userid from organisation
		String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strUserClass="",strorg_branchin="";
		
		strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolidMang);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
			strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}
		//system user
		String strSysteUserId="SYSUSR";
		
		if (rs != null) 
		{
			rs.close();
		}
		String strperappOldID="";
		strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
			strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
		}
		if(strLAPSid.equals(""))
		{
			strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
			strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
		}
		
		
			String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
		 
			String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
		
			//new Application Number
			hshlockvalues = new HashMap();
			hshlockvalues.put("apptype", "P");
			hshlockvalues.put("comapp_id", strLAPSid);
			hshlockvalues.put("strSolid", strsolid);
			strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

			//applications table
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strPrdCode);
			arrValues.add(strSysteUserId);
			arrValues.add(strOrgCode);									
			arrValues.add("P"); //Digital retail
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			arrValues.add("R");
			arrValues.add(strOrgLevel);
			arrValues.add(strUserId);
			arrValues.add("Y");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("N");
			arrValues.add("PJ");
			arrValues.add("N");
			arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
			arrValues.add(correctNull((String) hshValues.get("strstpType")));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_digi");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//demographic table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLAPSid);
			arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add(strperappOldID);
			arrValues.add("");
			arrValues.add("a");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsdemoins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//inward register
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add("op");
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			 
			String mclrtype="",mclrtabcode="",mclrbaserate="";
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
			}
			
			//loandetails
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;//
			hshQuery.put("strQueryId", "ins_loandetails_extAppl_jwl");
			arrValues.add(strApplicationNo);
			arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
			arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
//			String intype=correctNull((String) hshValues.get("strInterestType"));
//			if(intype.equals("1"))
//			{
//				intype="Fixed";
//			}
//			else if(intype.equals("2"))
//			{
//				intype="Floating";
//			}
//			arrValues.add(intype);
			arrValues.add(correctNull((String) hshValues.get("strinttype")));    			// LOAN_INTTYPE
			arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
			//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
			arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
			arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
			arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
			arrValues.add(correctNull((String) hshValues.get("strTakeover")));
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
			arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
			arrValues.add(mclrtabcode);
			arrValues.add(mclrtype);
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			arrValues.add(mclrbaserate);
			arrValues.add(Helper.correctNull((String) hshValues.get("strbusinessStrategicPremium")));//prd_busstrategicpremium			
			arrValues.add(Helper.correctNull((String) hshValues.get("strcreditRiskPremium")));//prd_creditrskpremium	
			if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
			{
				arrValues.add("1"); //interest charged 
			}
			else
			{
				arrValues.add("2");  //interest charged 
			}
			arrValues.add("C");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strcfr_verified")));			// "Y"	previous data			
			arrValues.add(Helper.correctInt((String) hshValues.get("strCFR_borname")));				// "N" previous data
			arrValues.add(Helper.correctInt((String) hshValues.get("strcersai_check")));			// "S" previous data

			//if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
				
	/*	else
			arrValues.add("NC");*/
			arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
			//else
				//arrValues.add("NC");
			
				arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
				//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
				

	
			arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
			arrValues.add(strsolid);
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));

			arrValues.add(correctNull((String)hshValues.get("strschemeType")));
			arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
			arrValues.add(correctNull((String)hshValues.get("stragencyName")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
			arrValues.add("N");
			arrValues.add("");
			arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
			arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
			arrValues.add(correctNull((String) hshValues.get("")));
			arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
			arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
			arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
			arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
			arrValues.add(correctNull((String) hshValues.get("strdocRecAgri")));
			
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
            Calendar calendar = Calendar.getInstance();
            String strDay = dateFormat.format(calendar.getTime());
            
			//workflow Mailbox
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
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
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
            calendar.add(Calendar.SECOND,5);
            strDay = dateFormat.format(calendar.getTime());
            
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);
			arrValues.add(strUserId);
			arrValues.add("1");
			arrValues.add("2");
			arrValues.add(strDay);
			arrValues.add("C");
			arrValues.add("001");
			arrValues.add("");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			// goldOrnaments          
			ArrayList arrayDigiGold=new ArrayList();
			ArrayList arrDigiGoldValue=new ArrayList();
			arrayDigiGold=(ArrayList) hshValues.get("arrgoldOrnaments");
			int arrayDigiGoldSize=arrayDigiGold.size();
			int serialNo=0;
			
			if(arrayDigiGoldSize>0)
			{
				for(int i=0;i<arrayDigiGoldSize;i++)
					{
				serialNo++;	
				arrDigiGoldValue=(ArrayList) arrayDigiGold.get(i);
				
				String articleType=correctNull((String)arrDigiGoldValue.get(0));
				String grossWeight=Helper.correctInt((String)arrDigiGoldValue.get(1));
				String netWeight=Helper.correctInt((String)arrDigiGoldValue.get(2));
				String purity=Helper.correctInt((String)arrDigiGoldValue.get(3));
				String lastMarkertRate=Helper.correctInt((String)arrDigiGoldValue.get(4));
				String closingGoldRate=Helper.correctInt((String)arrDigiGoldValue.get(5));
				String estimatedValue=Helper.correctInt((String)arrDigiGoldValue.get(6));
				String quantity=Helper.correctInt((String)arrDigiGoldValue.get(7));
				String netValue=Helper.correctInt((String)arrDigiGoldValue.get(8));
				String articleTypeGO=Helper.correctInt((String)arrDigiGoldValue.get(9));
				
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);//AGR_ARTCATID
				arrValues.add(String.valueOf(serialNo));//AGR_ARTNO
				arrValues.add(articleType);//AGR_ARTDESC
				arrValues.add(grossWeight);//AGR_ARTGROSSWT
				arrValues.add(netWeight);//AGR_ARTNETWT
				arrValues.add(purity);//AGR_ARTQTYTOUCH
				arrValues.add(lastMarkertRate);//AGR_ARTMKTRATE
				arrValues.add(closingGoldRate);//AGR_ARTRATE
				arrValues.add(estimatedValue);//AGR_ESTRATE
				arrValues.add(estimatedValue);//AGR_BANKVALUE
				arrValues.add(quantity);//agr_quantity
				arrValues.add("");//agr_grsno
				arrValues.add("");//agr_secid
				
//				if(articleType.equalsIgnoreCase("Gold coins")){
//					arrValues.add("G");//agr_articletype
//				}else{
//					arrValues.add("O");//agr_articletype
//				}
				arrValues.add(articleTypeGO);  	//agr_articletype
				arrValues.add(netValue);//agr_netvalue
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "insgoldloan");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
			}
			
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","ins_appraiserdet");
			arrValues.add(strApplicationNo);
			arrValues.add(correctNull((String) hshValues.get("strappraiserName")));
			arrValues.add(correctNull((String) hshValues.get("strappraiseon")));
			arrValues.add(correctNull((String) hshValues.get("strappraisercomments")));
			arrValues.add(correctNull((String) hshValues.get("strappraisercbsid")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//per loan secure
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly
			arrValues.add(Helper.correctInt((String) hshValues.get("strloanSecure"))); //unsecured  //LOAN_SECURE  //"u" previous data
			arrValues.add("0"); //secured amt
			arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "secureins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);					
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//Coapplicant
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
					hshQuery.put("strQueryId", "perloandetailsdemoins");
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(perapppid);//appid
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
					arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
					arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
					arrValues.add(strOldid);//oldid
					arrValues.add(strfinacletype.toUpperCase());//relationtype
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
			}
			
			String strSysUsrOrg="";
			
			if (rs != null) 
			{  rs.close(); 	}
			strQuery = SQLParser.getSqlQuery("setuserssel^"+strSysteUserId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strSysUsrOrg = Helper.correctNull((String) rs.getString("usr_orgcode"));
    		}
			
			//Security - Clean
			SecurityMasterBean secMasBean =new SecurityMasterBean();
			String strSecurityId = secMasBean.getOldAppidWithSno(strLAPSid);
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_securities_details");	
			arrValues.add(strSecurityId);
			arrValues.add("1"); //Type
			arrValues.add("25"); //classification
			arrValues.add("N"); //charged to bank
			arrValues.add("0"); //nature of charge
			arrValues.add(""); 
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("Clean Security"); 
			arrValues.add(Helper.getCurrentDateTime());
			arrValues.add(Helper.getCurrentDateTime());
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add("Y");
			arrValues.add("N");
			arrValues.add(strSysteUserId);
			arrValues.add(strSysUsrOrg);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","ins_ownership_securities");	
			arrValues.add(strSecurityId);
			arrValues.add(strperappOldID);
			arrValues.add("1");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_birdata");	
			arrValues.add(strApplicationNo);
			arrValues.add("N");
			arrValues.add("0.00");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
			
			strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
			}
			//security attachment
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(strSecurityId);
			arrValues.add("1");
			arrValues.add(strLAPSid);
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add("F");
			arrValues.add(strLoanType);//loantype
			arrValues.add("1");
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add("1");
			arrValues.add(strLAPSid);
			arrValues.add("0.00");
			arrValues.add(strPrdCode);
			arrValues.add("P");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("A");
			arrValues.add("Y");
			arrValues.add("");
			arrValues.add(strperappOldID);
			arrValues.add("F");
			arrValues.add("");
			//arrValues.add("M");
			hshQuery.put("strQueryId","ins_securitydetails_digi");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
			//security Freeze
			BankAppFIBean bankappfi=new BankAppFIBean();
			hshValues.put("appno", strApplicationNo);
			hshValues.put("hidapplicantid", strLAPSid);
			hshValues.put("hidapplicantnewid", strLAPSid);

			bankappfi.getSecCollateralCoverageRetail(hshValues);
			
			
			//terms and conditions
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
			
			//Coapplicant Freeze
			hshValues.put("appno", strApplicationNo);
			PerApplicantBean perApplicantBean = new PerApplicantBean();
			perApplicantBean.getFreezeData(hshValues);
			
			//Credit Facilities Freeze
			BankAppFIBean appFIBean = new BankAppFIBean();
			appFIBean.updateFreezeData(hshValues);
		
		
			//misdata
			String strperappcity="",strperappstate="",strperappdistrict="";
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
				strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
				strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
			}	
			
			//MIS Activity
			HashMap hshMISstatic = new HashMap();
			HashMap hshMISSubActivity = new HashMap();
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
				String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
				hshMISstatic.put(strSlcode,strPrdDesc);
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
				String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
				hshMISSubActivity.put(strSubcode,strSubPrdDesc);
			}
			
			
			
			
			
									
			String strActivity = " and mac.ACT_ACTIVITYCODE in (";
			String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
			String stractivitycode=strActCode;
			if(rs1!=null)
			{	  rs1.close();		}
			strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{ 
				hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
				hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
				hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
				hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
				hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
				hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
				hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
				hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
				hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
				hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
				hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
				hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
				hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
				hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
				hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
				String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
				String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
				if(strMainActivityCode.length()>0)
				{
					hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
				}
				
				if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
				{
					String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
					hshValues.put("strMainSubActivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
				}
				
				hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
				hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
				
				hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
				hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
				hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
			}
			
			double dblTotLim=0.00;
			double dblTotLimAgr=0.00;
			double dblTotLimSer=0.00;
			
			MisBean misbean=new MisBean();
			
			dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
			dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strApplicationNo);
			dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strApplicationNo);
			
			int querycount=0;
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
			arrValues.add("N");//Whether under Service Area Approach
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
			arrValues.add(strperappcity);
			arrValues.add(strperappdistrict);
			arrValues.add(strperappstate);
			arrValues.add(strorg_branchin);//Place - Metro
			arrValues.add("N"); //Does repayment depend purely on the asset financed
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
			arrValues.add("00");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
			arrValues.add(strActCode);
			arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
			arrValues.add("1"); //Asset Classification
			arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
			arrValues.add("1"); //fac serial no
			arrValues.add(Helper.correctDouble((String)hshValues.get("sel_sharebroker")));
			arrValues.add("Y");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			String strQueryAgr="";
			strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
			MISLogger.UpdateLogger(strQueryAgr);
			rs1=DBUtils.executeQuery(strQueryAgr);
			if(rs1.next())
			{
				hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
				hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
				hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
				hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
				hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
				hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
			}
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
			arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
			arrValues.add("1");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			if(rs1!=null)
				rs1.close();
			strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
			MISLogger.UpdateLogger(strQuery);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQueryValues.put("size","5");
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						querycount++;
						hshQuery.put("strQueryId","upd_cbsdetails");
						arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
						arrValues.add(strApplicationNo);
						arrValues.add("1");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(querycount),hshQuery);
					}
				}
			}
			hshQueryValues.put("size",String.valueOf(querycount));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			String strAppStatus="";
			String strPriorityType="";
			String strPrioritySubsector="";
			String strWeakerSectionSubSector="";
			String strAgriIndConfig="";
			String strTwentyPointPgm="";
			String strSensitiveSector="";
			String strInfracode="";
			String strGovtAnnounceScheme="";
			String strClassiMaster_Sno="";
			String strActivityCode="";
			String strActivitySno="";
			HashMap hshPriority=new HashMap();
			String strFacilitySno="1";
			String strStandUpIndia="";

			hshValues.put("strFacilitySno",strFacilitySno);
			hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
			hshValues.put("strHOLIDAYPERIOD","0");
			hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
			hshValues.put("hidapplicantnewid",strLAPSid);
			hshValues.put("strAppType","P");
			
			 hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
			 
			 	hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_misappclassification_digi");
				arrValues.add(strApplicationNo);
				arrValues.add(strAgriIndConfig);
				arrValues.add(strPriorityType);
				arrValues.add(strPrioritySubsector);
				arrValues.add(strSensitiveSector);
				arrValues.add(strWeakerSectionSubSector);
				arrValues.add(strTwentyPointPgm);
				arrValues.add(strInfracode);
				arrValues.add(strGovtAnnounceScheme);
				arrValues.add(strClassiMaster_Sno);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
			// mis end
				
				
			//CBS Details
			 
			if(rs != null)
			   rs.close(); 	 
			String strAppend="",strmodeofadv="";
			strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
			strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
			}

			if(rs!=null)
			rs.close();
			String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
			strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
				freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
				freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
				freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
				finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
				finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
				
			}
			
			
			
			if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
			{
				strLoanType="LAA";
			}
			else if(strLoanType.equalsIgnoreCase("OD"))
			{
				strLoanType="ODA";
			}
			strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
			}
				
			String strGLSubHeadCode="";
			strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strPrioritySubsector+"@^@"+strPrioritySubsector+"@");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strGLSubHeadCode=Helper.correctNull((String)rs.getString("sch_datadescription"));
			}
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(freeCode6);
			arrValues.add(freeCode7);
			arrValues.add(freeCode8);
			arrValues.add("01");//strModeOfOperation
			arrValues.add(correctNull((String) hshValues.get("strDRAWING_PWR_IND")));//strDrawingPowerInd  //"E" PREVIOUS DATA
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
			arrValues.add("N"); // Account Handoff
			arrValues.add("03");//strAdvanceNature
			arrValues.add(strAdvanceType);
			arrValues.add(strmodeofadv);
			arrValues.add("10"); //default 10
			arrValues.add("999"); //default 999
			arrValues.add(strsolid);
			arrValues.add(""); //Security Code
			arrValues.add(strintratefrq);
			arrValues.add(finfreeCode7);
			arrValues.add(finfreeCode8);
			arrValues.add(strlbrcode);
			arrValues.add(strFacilitySno);
			arrValues.add(correctNull((String) hshValues.get("strGISTOFSECURITUES")));  //CER_GISTOFSECURITUES   //Clean Security  PREVIOUS DATA
			arrValues.add(correctNull((String) hshValues.get("strSchemecode"))); //facilityschemecode   //"TGAQ" PREVIOUS DATA
			arrValues.add(correctNull((String) hshValues.get("strGLSUBHEADCODE"))); //facility_glsubheadcode		//strGLSubHeadCode PREVIOUS DATA
			arrValues.add("99"); //laps free code 1
			arrValues.add("99"); //laps free code 2
			arrValues.add("99"); //laps free code 3
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_cbsdetails");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			//documents 
			hshValues.put("strUserId", strUserId);
			hshValues.put("app_no", strApplicationNo);
			//hshValues=getDocumentURLs(hshValues);
			
			//APPRAISALSANCTION table
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);//appraised by
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
			arrValues.add("Y");//appraisal flag
			arrValues.add(correctNull((String) hshValues.get("strSANCLEVEL")));//sanclevel  //"02"  PREVIOUS DATA			
			arrValues.add(correctNull((String) hshValues.get("strSANCAUTH")));//sancauth  //"51" PREVIOUS DATA				
			arrValues.add(correctNull((String) hshValues.get("strappraisaldepartment"))); //sancdepart //"016" PREVIOUS DATA
			arrValues.add("RET");//sancbranch
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//security freeze
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add("Y");
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			//sanction
			if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("sanction"))
			{
					
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updapplicationsfinalsanction");
				arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				String strInwardno="";
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updinwardappstatus");
				arrValues.add("pa");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				//userclass
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","commworkflowupddigi");
				arrValues.add("pa");
				arrValues.add(strSysteUserId);
				arrValues.add(strsolid);
				arrValues.add(strUserClass);
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//sanction reference numnber
				CommWorkflowBean commwrkfko=new CommWorkflowBean();
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
					hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				}
				hshValues.put("hidAction", "approve");
				hshValues.put("sessionModuleType", "RET");
				hshValues.put("strApplicationType", "F");
				hshValues.put("digiloan", "Y");

				String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
				
				hshValues.put("strReferenceno", strReferenceno);
				hshValues.put("strSanctionDate", Helper.getCurrentDateTime());
				
			} else if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("Manual Check"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   
				hshQuery.put("strQueryId","ins_Veri_ManualCheck");
				arrValues.add(strApplicationNo);
				arrValues.add(strLAPSid);
				arrValues.add("MC");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_specialMargin");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1", hshQuery);	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();   
			hshQuery.put("strQueryId","ins_retailcomments");
			arrValues.add(strApplicationNo);
			arrValues.add("LoanProd");
			arrValues.add(correctNull((String) hshValues.get("strcustomerBackgroundComments")));
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
			
			//financialcomments
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_financial_comments2");
			arrValues.add(strApplicationNo);
			arrValues.add("");
			arrValues.add("repaycomment");
			arrValues.add(correctNull((String)hshValues.get("strrepaymentterms")));	//fin_comments
			arrValues.add("");
			arrValues.add("");
			arrValues.add("1");
			arrValues.add("N");  // FIN_STAGEWISE_RELEASE
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
			
			
			// COM_DELEGATION table 01 & SYSUSR
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			String strSno="",USR_FNAME="",USER_DESIGNATION="",USR_ID="";
			hshQuery.put("strQueryId","ins_delegation");
			strQuery=SQLParser.getSqlQuery("delegationmax^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			 strSno = correctNull(rs.getString(1));				
			}
						
			if(rs!=null)
			{
			 rs.close();
			}
						
			strUserId = Helper.correctNull((String)hshValues.get("strAppriasedBy"));
			strQuery=SQLParser.getSqlQuery("Sel_name_desc^"+strUserId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			 {
			  
			  USR_FNAME = correctNull(rs.getString(1));
			  USER_DESIGNATION=correctNull(rs.getString(2));
							
			 }
			 arrValues.add(strApplicationNo); // COM_APPNO
			 arrValues.add(USR_FNAME);	//COM_USERID  & USR_FNAME
			 arrValues.add(USER_DESIGNATION);	//COM_USERDES & USR_DESIGNATION
			 arrValues.add(strSno);	// COM_SNO
			 arrValues.add(strUserId);
			 arrValues.add("A");		// COM_DETAILS
			 arrValues.add(Helper.getCurrentDateTime());	// COM_DATE

			 hshQuery.put("arrValues",arrValues);						
			 hshQueryValues.put("size","1");
			 hshQueryValues.put("1",hshQuery);
			 EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						
			//COM_DELEGATION table 02 & SanctionedBy ID
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","ins_delegation");
			
			strQuery=SQLParser.getSqlQuery("delegationmax^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSno = correctNull(rs.getString(1));				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			strUserId = Helper.correctNull((String)hshValues.get("strSanctionedBy"));
			strQuery=SQLParser.getSqlQuery("Sel_name_desc^"+strUserId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				USR_FNAME = correctNull(rs.getString(1));
				USER_DESIGNATION=correctNull(rs.getString(2));
				
			}
			arrValues.add(strApplicationNo); // COM_APPNO
			
			arrValues.add(USR_FNAME);	//COM_USERID  & USR_FNAME
			arrValues.add(USER_DESIGNATION);	//COM_USERDES & USR_DESIGNATION
			
			arrValues.add(strSno);	// COM_SNO
			arrValues.add(strUserId);	// COM_USER
			arrValues.add("S");		// COM_DETAILS
			arrValues.add(Helper.getCurrentDateTime());	// COM_DATE

			hshQuery.put("arrValues",arrValues);						
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			// APPRAISALQUEST table  
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","ins_app_test");
			
			arrValues.add(strApplicationNo);
			arrValues.add("1");
			arrValues.add("");
			arrValues.add("1");
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			hshValues.put("strApplication", strApplicationNo);
			hshValues.put("strResponseCode", "LAPS-1010");
			hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
		
	}
	catch(Exception e)
	{
		
//		if (rs != null) 
//		{rs.close();}
//		
//		hshQueryValues = new HashMap();
//		arrValues = new ArrayList();
//		hshQuery = new HashMap();
//		hshQuery.put("strQueryId","Del_Failed_proposalno");
//		arrValues.add(strApplicationNo);
//		arrValues.add(strApplicationNo);
//	
//		hshQuery.put("arrValues",arrValues);
//		hshQueryValues.put("size", "1");
//		hshQueryValues.put("1",hshQuery);
//		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
		
		throw new EJBException("Error in DigitalAppInterface Bean proposalCreationForPJ..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean proposalCreationForPJ..."+e.toString());
		}
	}
	
	return hshValues;
	
}
public HashMap proposalCreationForPD(HashMap hshValues) throws EJBException 
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	HashMap hshlockvalues=new HashMap();
	
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strApplicationNo="",strLAPSid="";
	String strsolid=Helper.correctNull((String)hshValues.get("strApplicationBranch"));
	String strCustomerID=Helper.correctNull((String)hshValues.get("strCustomerID"));
	int intUpdatesize=0;
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	try
	{
		Date date1;
		Date date2;
		String strDate = ApplicationParams.getStrCLPCdate();
		SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
		date1 = CLPCdate.parse(strDate);
		String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		date2 = CLPCdate.parse(NOwCalender);
		String strsolidMang = strsolid;
		String margin="";
		
		if (date1.before(date2))
		{
			if (strsolid.equalsIgnoreCase("850")){
				strsolidMang="600";
			}
		}
		//userid from organisation
		String strUserId="",strOrgLevel="",strOrgCode="",strOrgScode="",strUserClass="",strorg_branchin="";
		
		strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strsolidMang);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strUserId = Helper.correctNull((String)rs.getString("USR_ID"));
			strOrgLevel = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
			strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
			strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
			strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
			strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
		}
		//system user
		String strSysteUserId="SYSUSR";
		
		if (rs != null) 
		{
			rs.close();
		}
		String strperappOldID="";
		strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
			strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
		}
		if(strLAPSid.equals(""))
		{
			strLAPSid=Helper.correctNull((String)hshValues.get("strlapsID"));
			strperappOldID=Helper.correctNull((String)hshValues.get("strlapsID"));
		}
		
		
			String DigitalLoanType=Helper.correctNull((String)hshValues.get("strloanType"));
		 
			String	strPrdCode= Helper.correctNull((String)hshValues.get("strLoanProduct"));
		
			//new Application Number
			hshlockvalues = new HashMap();
			hshlockvalues.put("apptype", "P");
			hshlockvalues.put("comapp_id", strLAPSid);
			hshlockvalues.put("strSolid", strsolid);
			strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");

			//applications table
			intUpdatesize++;
			arrValues.add(strApplicationNo);//1
			arrValues.add(strPrdCode);//2
			arrValues.add(strSysteUserId);//3
			arrValues.add(strOrgCode);	//4								
			arrValues.add("P"); //Digital retail 5
			arrValues.add(correctNull((String) hshValues.get("strLARno")));//6
			arrValues.add("R");//7
			arrValues.add(strOrgLevel);//8
			arrValues.add(strUserId);//9
			arrValues.add("Y");//10
			arrValues.add("");//11
			arrValues.add("");//12
			arrValues.add("");//13
			arrValues.add("N");//14
			arrValues.add("PR");//15  PD loan changes previous PD
			arrValues.add("N");//16
			arrValues.add(correctNull((String) hshValues.get("strbussinessId")));
			arrValues.add(correctNull((String) hshValues.get("strstpType")));
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "insapplications_digi");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//demographic table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(strLAPSid);
			arrValues.add("a");
			arrValues.add("");
			arrValues.add("2");
			arrValues.add(strperappOldID);
			arrValues.add("");
			arrValues.add("a");
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "perloandetailsdemoins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			//inward register
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updinwardappatached");
			arrValues.add("Y");
			arrValues.add("op");
			arrValues.add(correctNull((String) hshValues.get("strLARno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			 
			String mclrtype="",mclrtabcode="",mclrbaserate="";
			if(!Helper.correctNull((String)hshValues.get("strmclrType")).equalsIgnoreCase(""))
			{
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strmclrType")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
				mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
			}
			}
			
             margin= correctNull((String) hshValues.get("strmargin"));
			
			String mini_margin =String.valueOf((((Double.parseDouble((Helper.correctNull((String) hshValues.get("strAmountRequested"))))) * Double.parseDouble((margin)))/100));
			//loandetails
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;//
			hshQuery.put("strQueryId", "ins_loandetails_extAppl_jwl");
			arrValues.add(strApplicationNo);
			arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
			arrValues.add(correctNull((String) hshValues.get("strInterestRate")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strProjectCost")));
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));
			arrValues.add(correctNull((String) hshValues.get("strLoanTenor")));
			String intype=correctNull((String) hshValues.get("strInterestType"));
			if(intype.equals("1"))
			{
				intype="Fixed";
			}
			else if(intype.equals("2"))
			{
				intype="Floating";
			}
			arrValues.add(intype);
			arrValues.add(correctNull((String) hshValues.get("strPurposeLoan")));
			//arrValues.add(correctNull((String) hshValues.get("loan_filedon"))); 
			arrValues.add(correctNull((String) hshValues.get("strRepaymentType")));
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			//arrValues.add(correctNull((String) hshValues.get("loan_receivedate")));
			arrValues.add(correctNull((String) hshValues.get("strPaymentMode")));
			arrValues.add(correctNull((String) hshValues.get("strgovtSponserScheme")));
			arrValues.add(correctNull((String) hshValues.get("strTakeover")));
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));
			//arrValues.add(correctNull((String) hshValues.get("loan_createddate")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strInsuranceAmount")));
			arrValues.add(correctNull((String) hshValues.get("strPartyFileno")));
			arrValues.add(mclrtabcode);
			arrValues.add(mclrtype);
			arrValues.add(correctNull((String) hshValues.get("strProcessingFee")));
			arrValues.add(correctNull((String) hshValues.get("strprocesssingFeeCollected")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strcategoryLoanPurpose")));
			arrValues.add(Helper.correctInt((String) hshValues.get("strpremisesAge")));
			arrValues.add(mclrbaserate);
			arrValues.add("0");//prd_busstrategicpremium
			arrValues.add("0");//prd_creditrskpremium
			if(Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("s") || Helper.correctNull((String) hshValues.get("strinterestCollected")).equals("y"))
			{
				arrValues.add("1"); //interest charged 
			}
			else
			{
				arrValues.add("2");  //interest charged 
			}
			arrValues.add("C");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add("Y");
			arrValues.add("N");
			arrValues.add("S");

			//if(correctNull((String) hshValues.get("strSinglePremium")).equalsIgnoreCase("Y"))
				
	/*	else
			arrValues.add("NC");*/
			arrValues.add(correctNull((String) hshValues.get("strInsuranceAmntFundedBy")));
			//else
				//arrValues.add("NC");
			
				arrValues.add(correctNull((String) hshValues.get("strPremiumTenor")));
				//arrValues.add(correctNull((String) hshValues.get("strInsuranceAmount")));
				arrValues.add(correctNull((String) hshValues.get("strLoanAmountCovered")));
				

	
			arrValues.add(correctNull((String) hshValues.get("strOperativeAccNo")));
			arrValues.add(strsolid);
			arrValues.add(correctNull((String) hshValues.get("strEMIamount")));

			arrValues.add(correctNull((String)hshValues.get("strschemeType")));
			arrValues.add(correctNull((String)hshValues.get("strsponsorAgency")));
			arrValues.add(correctNull((String)hshValues.get("stragencyName")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyAmount")));
			arrValues.add(correctNull((String)hshValues.get("strsubsidyType")));
			arrValues.add("N");
			arrValues.add("");
			arrValues.add(correctNull((String) hshValues.get("strpenalInterest")));
			arrValues.add(correctNull((String) hshValues.get("strinterestConcession")));
			arrValues.add(correctNull((String) hshValues.get("")));
			arrValues.add(correctNull((String) hshValues.get("strecsBankName")));
			arrValues.add(correctNull((String) hshValues.get("strecsAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsOperAccountType")));
			arrValues.add(correctNull((String) hshValues.get("strecsAuthunenticateMode")));
			arrValues.add(correctNull((String) hshValues.get("strecsIFSCCODE")));
			arrValues.add(correctNull((String) hshValues.get("strupfrontfee")));
			arrValues.add(correctNull((String) hshValues.get("strdocRecAgri")));
			
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
            Calendar calendar = Calendar.getInstance();
            String strDay = dateFormat.format(calendar.getTime());
            
			//workflow Mailbox
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
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
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
            calendar.add(Calendar.SECOND,5);
            strDay = dateFormat.format(calendar.getTime());
            
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","commworkflowins_extappl");
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);
			arrValues.add(strUserId);
			arrValues.add("1");
			arrValues.add("2");
			arrValues.add(strDay);
			arrValues.add("C");
			arrValues.add("001");
			arrValues.add("");
			arrValues.add(strOrgScode);
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			double security_val=0.0;
			ArrayList arrayDigiGold=new ArrayList();
			ArrayList arrDigiGoldValue=new ArrayList();
			arrayDigiGold=(ArrayList) hshValues.get("arrdepositdetails");
			int arrayDigiGoldSize=arrayDigiGold.size();
			int serialNo=0;
			String Accountno="";
			if(arrayDigiGoldSize>0)
			{
				for(int i=0;i<arrayDigiGoldSize;i++)
					{
				serialNo++;	
				arrDigiGoldValue=(ArrayList) arrayDigiGold.get(i);
				
				
				
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues = new ArrayList();
				arrValues.add(String.valueOf(serialNo));//1
				arrValues.add(strApplicationNo);//2
				arrValues.add(correctNull((String)arrDigiGoldValue.get(0)));//3
				arrValues.add(correctNull((String)arrDigiGoldValue.get(1)));//4
				arrValues.add(correctNull((String)arrDigiGoldValue.get(2)));//5
				Accountno=correctNull((String)arrDigiGoldValue.get(2));
				arrValues.add(correctNull((String)arrDigiGoldValue.get(3)));//6
				arrValues.add(correctNull((String)arrDigiGoldValue.get(4)));//7
				arrValues.add(correctNull((String)arrDigiGoldValue.get(5)));//8
				arrValues.add(correctNull((String)arrDigiGoldValue.get(6)));//9
				arrValues.add(correctNull((String)arrDigiGoldValue.get(7)));//10
				arrValues.add(correctNull((String)arrDigiGoldValue.get(8)));//11
				arrValues.add(correctNull((String)arrDigiGoldValue.get(9)));//12
				arrValues.add(correctNull((String)arrDigiGoldValue.get(10)));//13
				arrValues.add(correctNull((String)arrDigiGoldValue.get(11)));//14
				arrValues.add(correctNull((String)arrDigiGoldValue.get(12)));//15
				arrValues.add(correctNull((String)arrDigiGoldValue.get(13)));//16
				arrValues.add(correctNull((String)arrDigiGoldValue.get(14)));//17
				arrValues.add(correctNull((String)arrDigiGoldValue.get(15)));//18
				arrValues.add(correctNull((String)arrDigiGoldValue.get(16)));//19
				security_val+=Double.parseDouble(Helper.correctDouble((correctNull((String)arrDigiGoldValue.get(6)))));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "Ins_loanagainstdep");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
			}
			
			
			double margin_offered_by_borr=0.0;
			margin_offered_by_borr=security_val-(Double.parseDouble((Helper.correctNull((String) hshValues.get("strAmountRequested")))));
			
			/*hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","ins_appraiserdet");
			arrValues.add(strApplicationNo);
			arrValues.add(correctNull((String) hshValues.get("strappraiserName")));
			arrValues.add(correctNull((String) hshValues.get("strappraiseon")));
			arrValues.add(correctNull((String) hshValues.get("strappraisercomments")));
			arrValues.add(correctNull((String) hshValues.get("strappraisercbsid")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize, hshQuery);*/
			
			//per loan secure
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctInt((String) hshValues.get("strHolidayPeriod")));
			//arrValues.add(Helper.correctNull((String) hshValues.get("strPeriodicityInstallments"))); //monthly//madhu
			arrValues.add("n");
			arrValues.add("u"); //unsecured
			arrValues.add("0"); //secured amt
			arrValues.add(Helper.correctNull((String) hshValues.get("strinterestCollected"))); //Interest to be collected during Holiday 
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "secureins");
			hshQueryValues.put(""+intUpdatesize, hshQuery);					
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//Coapplicant
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
					hshQuery.put("strQueryId", "perloandetailsdemoins");
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add(perapppid);//appid
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
					arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));//relation
					arrValues.add(Helper.correctNull((String)arrcoappval.get(5)));//income
					arrValues.add(strOldid);//oldid
					arrValues.add(strfinacletype.toUpperCase());//relationtype
					arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//docprint
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
			}
			
			String strSysUsrOrg="";
			
			if (rs != null) 
			{  rs.close(); 	}
			strQuery = SQLParser.getSqlQuery("setuserssel^"+strSysteUserId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strSysUsrOrg = Helper.correctNull((String) rs.getString("usr_orgcode"));
    		}
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_birdata");	
			arrValues.add(strApplicationNo);
			arrValues.add("N");
			arrValues.add("0.00");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			String strSchemeCode = "",strAdvanceType="",strLoanType="",strintratefrq="";
			
			strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNo+"^op");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
			}
					
			//terms and conditions
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
			
			//Coapplicant Freeze
			hshValues.put("appno", strApplicationNo);
			PerApplicantBean perApplicantBean = new PerApplicantBean();
			perApplicantBean.getFreezeData(hshValues);
			
			//Credit Facilities Freeze
			/*BankAppFIBean appFIBean = new BankAppFIBean();
			appFIBean.updateFreezeData(hshValues);*/
		
		
			//misdata
			String strperappcity="",strperappstate="",strperappdistrict="";
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLAPSid);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strperappcity=Helper.correctNull((String)rs.getString("CON_COMCITY"));
				strperappdistrict=Helper.correctNull((String)rs.getString("CON_COMDIST"));
				strperappstate=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
			}	
			
			//MIS Activity
			HashMap hshMISstatic = new HashMap();
			HashMap hshMISSubActivity = new HashMap();
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc_new^"+"2");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSlcode = Helper.correctNull((String)rs1.getString("mis_static_data_code"));
				String strPrdDesc = Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
				hshMISstatic.put(strSlcode,strPrdDesc);
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_MISSubActivityDesc_new");
			rs1= DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				String strSubcode = Helper.correctNull((String)rs1.getString("mis_code"));
				String strSubPrdDesc = Helper.correctNull((String)rs1.getString("mis_subactdesc"));
				hshMISSubActivity.put(strSubcode,strSubPrdDesc);
			}
			
			
			
			
			
									
			String strActivity = " and mac.ACT_ACTIVITYCODE in (";
			String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
			String stractivitycode=strActCode;
			if(rs1!=null)
			{	  rs1.close();		}
			strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity+""+strActCode+")");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{ 
				hshValues.put("act_sno",Helper.correctNull((String)rs.getString("act_sno")));//0
				hshValues.put("act_mainactcode",Helper.correctNull((String)rs.getString("act_mainactcode")));//1
				hshValues.put("act_subactcode",Helper.correctNull((String)rs.getString("act_subactcode")));//2
				hshValues.put("act_purposecode",Helper.correctNull((String)rs.getString("act_purposecode")));//3
				hshValues.put("act_activitycode",Helper.correctNull((String)rs.getString("act_activitycode")));//4
				hshValues.put("act_bsrcode",Helper.correctNull((String)rs.getString("act_bsrcode")));//5
				hshValues.put("act_bsr1code",Helper.correctNull((String)rs.getString("act_bsr1code")));//6
				hshValues.put("act_displayscreen",Helper.correctNull((String)rs.getString("act_displayscreen")));//7
				hshValues.put("act_industrytype",Helper.correctNull((String)rs.getString("act_industrytype")));//8
				hshValues.put("act_show",Helper.correctNull((String)rs.getString("act_show")));//9
				hshValues.put("act_createdate",Helper.correctNull((String)rs.getString("act_createdate")));//10
				hshValues.put("act_modifieddate",Helper.correctNull((String)rs.getString("act_modifieddate")));//11
				hshValues.put("act_purposesno",Helper.correctNull((String)rs.getString("act_purposesno")));//12
				hshValues.put("mis_static_data_desc",Helper.correctNull((String)rs.getString("mis_static_data_desc")));//13
				hshValues.put("act_lbrcode",Helper.correctNull((String)rs.getString("act_lbrcode")));//14
				String strMainActivityCode = Helper.correctNull((String)rs.getString("act_mainactcode"));
				String strSubActivityCode = Helper.correctNull((String)rs.getString("act_subactcode"));
				if(strMainActivityCode.length()>0)
				{
					hshValues.put("strMainActivityCode",Helper.correctNull((String)hshMISstatic.get(strMainActivityCode)));//15
				}
				
				if(strMainActivityCode.length()>0 && strSubActivityCode.length()>0)
				{
					String strMainSubActivitycode = strMainActivityCode+"-"+strSubActivityCode;
					hshValues.put("strMainSubActivitycode",Helper.correctNull((String)hshMISSubActivity.get(strMainSubActivitycode)));//16  
				}
				
				hshValues.put("act_busruleid",Helper.correctNull((String)rs.getString("act_busruleid")));//17
				hshValues.put("act_schematicflag",Helper.correctNull((String)rs.getString("act_schematicflag")));//18
				
				hshValues.put("act_freecode6",Helper.correctNull(rs.getString("act_freecode6")));//19
				hshValues.put("act_freecode7",Helper.correctNull(rs.getString("act_freecode7")));//20
				hshValues.put("act_freecode8",Helper.correctNull(rs.getString("act_freecode8")));//21
			}
			
			double dblTotLim=0.00;
			double dblTotLimAgr=0.00;
			double dblTotLimSer=0.00;
			
			MisBean misbean=new MisBean();
			
			dblTotLim=misbean.getBorrowerTotalLimit(strLAPSid,"R");
			dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strApplicationNo);
			dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strApplicationNo);
			
			int querycount=0;
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","del_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add("1"); //facility serialno
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdetails");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLim)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimSer)));
			arrValues.add(Helper.correctDouble(String.valueOf(dblTotLimAgr)));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructFac")));
			arrValues.add("N");//Whether under Service Area Approach
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RestructUnder")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementRefNo")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_SettlementDate")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OldFacID")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txtarea_Reason")));
			arrValues.add(strperappcity);
			arrValues.add(strperappdistrict);
			arrValues.add(strperappstate);
			arrValues.add(strorg_branchin);//Place - Metro
			arrValues.add("N"); //Does repayment depend purely on the asset financed
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_RepaySource")));
			arrValues.add("00");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_GuarAmount")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_NewProjectFac")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_DCCO")));
			arrValues.add(strActCode);
			arrValues.add(Helper.correctNull((String)hshValues.get("act_sno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_mainactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_subactcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_purposecode"))+"_"+Helper.correctNull((String)hshValues.get("act_purposesno")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsrcode")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_bsr1code")));
			arrValues.add(Helper.correctNull((String)hshValues.get("act_industrytype")));
			arrValues.add("1"); //Asset Classification
			arrValues.add(Helper.correctNull((String)hshValues.get("act_displayscreen")));
			arrValues.add("1"); //fac serial no
			arrValues.add(Helper.correctDouble((String)hshValues.get("sel_sharebroker")));
			arrValues.add("Y");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			String strQueryAgr="";
			strQueryAgr=SQLParser.getSqlQuery("sel_landholdingMIS^"+strLAPSid);
			MISLogger.UpdateLogger(strQueryAgr);
			rs1=DBUtils.executeQuery(strQueryAgr);
			if(rs1.next())
			{
				hshValues.put("app_totland",Helper.correctNull((String)rs1.getString("land_acreage")));
				hshValues.put("app_totirrigatedland",Helper.correctDouble((String)rs1.getString("land_irrigsize")));
				hshValues.put("app_totnonirrigatedland",Helper.correctDouble((String)rs1.getString("land_nonirriga")));
				hshValues.put("app_totcultivatedland",Helper.correctDouble((String)rs1.getString("land_cultivatable")));
				hshValues.put("app_totnoncultivatedland",Helper.correctDouble((String)rs1.getString("land_noncultivatable")));
				hshValues.put("app_farmercategory",Helper.correctNull((String)rs1.getString("land_farmercategory")));
			}
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			querycount++;
			hshQuery.put("strQueryId","ins_misappdisplayscreen");
			arrValues.add(strApplicationNo);
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totcultivatedland")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland")));
			arrValues.add(Helper.correctNull((String)hshValues.get("app_farmercategory")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_CropInsu")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_KrishiCard")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PAIS")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Premium")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeName")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NomineeAge")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_NomineeRel")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PAISClaim")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_FinOutlays")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndGroups")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_MarginMoney")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OrigInvest")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_IndName")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_PublicDeposit")));
			arrValues.add(Helper.correctInt((String)hshValues.get("txt_NoOfHousing")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_OriginalInvest")));
			arrValues.add("1");
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_onwardlending")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("sel_Meritorious")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_cre_percnt")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_social_infra")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_anci")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_renew_energy_indv")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_agri_infra")));
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			arrValues.add("");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(String.valueOf(querycount),hshQuery);
			
			if(rs1!=null)
				rs1.close();
			strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strApplicationNo+"^"+"1");
			MISLogger.UpdateLogger(strQuery);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQueryValues.put("size","5");
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						querycount++;
						hshQuery.put("strQueryId","upd_cbsdetails");
						arrValues.add(Helper.correctNull(rs.getString("act_freecode6")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode7fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_freecode8fincode")));
						arrValues.add(Helper.correctNull(rs.getString("act_lbrcode")));
						arrValues.add(strApplicationNo);
						arrValues.add("1");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(querycount),hshQuery);
					}
				}
			}
			hshQueryValues.put("size",String.valueOf(querycount));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			String strAppStatus="";
			String strPriorityType="";
			String strPrioritySubsector="";
			String strWeakerSectionSubSector="";
			String strAgriIndConfig="";
			String strTwentyPointPgm="";
			String strSensitiveSector="";
			String strInfracode="";
			String strGovtAnnounceScheme="";
			String strClassiMaster_Sno="";
			String strActivityCode="";
			String strActivitySno="";
			HashMap hshPriority=new HashMap();
			String strFacilitySno="1";
			String strStandUpIndia="";

			hshValues.put("strFacilitySno",strFacilitySno);
			hshValues.put("strLoanAmt",Helper.correctNull((String) hshValues.get("strAmountRequested")));
			hshValues.put("strHOLIDAYPERIOD","0");
			hshValues.put("strReqTerms",Helper.correctNull((String) hshValues.get("strLoanTenor")));
			hshValues.put("hidapplicantnewid",strLAPSid);
			hshValues.put("strAppType","P");
			
			 hshPriority=(HashMap)misbean.getMISAppClassification(hshValues);
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
			 
			 	hshQueryValues=new HashMap();
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_misappclassification_digi");
				arrValues.add(strApplicationNo);
				arrValues.add(strAgriIndConfig);
				arrValues.add(strPriorityType);
				arrValues.add(strPrioritySubsector);
				arrValues.add(strSensitiveSector);
				arrValues.add(strWeakerSectionSubSector);
				arrValues.add(strTwentyPointPgm);
				arrValues.add(strInfracode);
				arrValues.add(strGovtAnnounceScheme);
				arrValues.add(strClassiMaster_Sno);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				MISLogger.UpdateLogger("Updated Data Values ==="+hshQueryValues);
			// mis end
				
				
			//CBS Details
			 
			if(rs != null)
			   rs.close(); 	 
			String strAppend="",strmodeofadv="";
			strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNo+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
			strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
			}

			if(rs!=null)
			rs.close();
			String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
			strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
				freeCode6=Helper.correctNull((String)rs.getString("act_freecode6"));
				freeCode7=Helper.correctNull((String)rs.getString("act_freecode7"));
				freeCode8=Helper.correctNull((String)rs.getString("act_freecode8"));
				finfreeCode7=Helper.correctNull((String)rs.getString("act_freecode7fincode"));
				finfreeCode8=Helper.correctNull((String)rs.getString("act_freecode8fincode"));
				
			}
			
			
			
			if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
			{
				strLoanType="LAA";
			}
			else if(strLoanType.equalsIgnoreCase("OD"))
			{
				strLoanType="ODA";
			}
			strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				  strAdvanceType=Helper.correctNull(rs.getString("sch_typeadv"));
			}
				
			String strGLSubHeadCode="";
			strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strPrioritySubsector+"@^@"+strPrioritySubsector+"@");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strGLSubHeadCode=Helper.correctNull((String)rs.getString("sch_datadescription"));
			}
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(freeCode6);
			arrValues.add(freeCode7);
			arrValues.add(freeCode8);
			arrValues.add("01");//strModeOfOperation
			arrValues.add("D");//strDrawingPowerInd
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
			arrValues.add("N"); // Account Handoff
			arrValues.add("01");//strAdvanceNature
			arrValues.add(strAdvanceType);
			arrValues.add(strmodeofadv);
			arrValues.add("10"); //default 10
			arrValues.add("999"); //default 999
			arrValues.add(strsolid);
			arrValues.add(""); //Security Code
			arrValues.add(strintratefrq);
			arrValues.add(finfreeCode7);
			arrValues.add(finfreeCode8);
			arrValues.add(strlbrcode);
			arrValues.add(strFacilitySno);
			arrValues.add("pledge of deposit Number "+Accountno);
			arrValues.add(""); //facilityschemecode AGDQ
			arrValues.add(strGLSubHeadCode); //facility_glsubheadcode
			arrValues.add("99"); //laps free code 1
			arrValues.add("99"); //laps free code 2
			arrValues.add("99"); //laps free code 3
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_cbsdetails");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			//documents 
			hshValues.put("strUserId", strUserId);
			hshValues.put("app_no", strApplicationNo);
			//hshValues=getDocumentURLs(hshValues);
			
			//APPRAISALSANCTION table
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
			arrValues = new ArrayList();
			arrValues.add(strApplicationNo);
			arrValues.add(strSysteUserId);//appraised by
			arrValues.add(correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
			arrValues.add("Y");//appraisal flag
			arrValues.add("02");//sanclevel
			arrValues.add("51");//sancauth
			arrValues.add("016");//sancdepart
			arrValues.add("RET");//sancbranch
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			//security freeze
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add("Y");
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(margin);
			arrValues.add(mini_margin);
			arrValues.add(String.valueOf(security_val));
			arrValues.add(String.valueOf(margin_offered_by_borr));
			arrValues.add("2");
			arrValues.add("N");
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updateloandetailsforod");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			//sanction
			if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("sanction"))
			{
					
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updapplicationsfinalsanction");
				arrValues.add(correctNull((String)hshValues.get("sel_finalsanction")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				String strInwardno="";
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInwardno=Helper.correctNull((String)rs.getString("app_inwardno"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updinwardappstatus");
				arrValues.add("pa");
				arrValues.add(strInwardno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				//userclass
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","commworkflowupddigi");
				arrValues.add("pa");
				arrValues.add(strSysteUserId);
				arrValues.add(strsolid);
				arrValues.add(strUserClass);
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//sanction reference numnber
				CommWorkflowBean commwrkfko=new CommWorkflowBean();
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("sel_userdet_userid^"+strUserId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("strSolid",Helper.correctNull((String)rs.getString("ORG_SCODE")));
					hshValues.put("strOrgLevel",Helper.correctNull((String)rs.getString("ORG_LEVEL")));
					hshValues.put("strOrgCode",Helper.correctNull((String)rs.getString("ORG_CODE")));
					hshValues.put("strUserDepartments",Helper.correctNull((String)rs.getString("USR_DEPARTMENT")));
				}
				hshValues.put("hidAction", "approve");
				hshValues.put("sessionModuleType", "RET");
				hshValues.put("strApplicationType", "F");
				hshValues.put("digiloan", "Y");

				String strReferenceno=commwrkfko.getSanctionRefernceNumber(hshValues);
				
				hshValues.put("strReferenceno", strReferenceno);
				hshValues.put("strSanctionDate", Helper.getCurrentDateTime());
				
			} else if(Helper.correctNull((String) hshValues.get("strsanctionStatus")).equalsIgnoreCase("Manual Check"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   
				hshQuery.put("strQueryId","ins_Veri_ManualCheck");
				arrValues.add(strApplicationNo);
				arrValues.add(strLAPSid);
				arrValues.add("MC");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","upd_specialMargin");
			arrValues.add(correctNull((String) hshValues.get("strmargin")));
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1", hshQuery);	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			
			// table: DIGI_RATING_SCORE 
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_digi_rate_score");
			arrValues.add(strApplicationNo);
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
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("Size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshValues.put("strApplication", strApplicationNo);
			hshValues.put("strResponseCode", "LAPS-1010");
			hshValues.put("strResponseMsg", "LAPS Application Created Successfully");
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean proposalCreationForPJ..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean proposalCreationForPJ..."+e.toString());
		}
	}
	
	return hshValues;
}

public HashMap Birdataapi(HashMap hshValues) throws EJBException // Birdata api
{
	
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	ResultSet rs=null,rs1=null;
	HashMap hshValue = new HashMap();
	String strrenwaldate="",strQuery="",strregioncode="",strId="",strName="",strScode="",stremailid="",strmobileno="",strtelephone="",strbranch="",
	strIfsc="",strexpirydate="",strpincode="";
	HashMap hshValue1 = new HashMap();
	HashMap hshValue2 = new HashMap();
	ArrayList arrValue =new ArrayList();
	ArrayList arrValue1 =new ArrayList();
	hshValues.put("dataExist", "No");	
	ArrayList arrValue2 =new ArrayList();

	try
	{
		strregioncode=(correctNull((String)hshValues.get("strregioncode")));
		
		
		if(!strregioncode.equals(""))
		{
			if(strregioncode.equals("001"))
			{
				strQuery = SQLParser.getSqlQuery("sel_birmastdataal^"+strregioncode);
				rs = DBUtils.executeQuery(strQuery);
			}else{
				
				strQuery = SQLParser.getSqlQuery("sel_birmastdata^"+strregioncode);
				rs = DBUtils.executeQuery(strQuery);
				
			}
		while(rs.next())
		{
			hshValues.put("dataExist", "Yes");	
			
			strId=Helper.correctNull((String)rs.getString("BIR_ID"));
			strName=Helper.correctNull((String)rs.getString("BIR_NAME"));
			strScode=Helper.correctNull((String)rs.getString("BIR_SCODE"));
			stremailid=Helper.correctNull((String)rs.getString("BIR_EMAILID"));
			strmobileno=Helper.correctNull((String)rs.getString("BIR_MOBILENON"));
			strtelephone=Helper.correctNull((String)rs.getString("BIR_TELEPHONENO"));
			strbranch=Helper.correctNull((String)rs.getString("BIR_BANKBRANCH"));
			strIfsc=Helper.correctNull((String)rs.getString("BIR_IFSC"));
			strexpirydate=Helper.correctNull((String)rs.getString("BIR_EXPIRY_DATE"));
			strpincode=Helper.correctNull((String)rs.getString("BIR_PINCODE"));
			
				
			
			hshValue1=new HashMap();
			hshValue1.put("strId", strId);
			hshValue1.put("strName", strName);
			hshValue1.put("strScode", strScode);
			hshValue1.put("stremailid", stremailid);
			hshValue1.put("strmobileno", strmobileno);
			hshValue1.put("strtelephone", strtelephone);
			hshValue1.put("strbranch", strbranch);
			hshValue1.put("strIfsc", strIfsc);
			hshValue1.put("strexpirydate", strexpirydate);
			hshValue1.put("strpincode", strpincode);
			arrValue.add(hshValue1);			
		}
		}
		hshValues.put("BIR_DATA", arrValue);			//strrenewalProposals
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean renewalProposal Service..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean renewalProposal Service closing Connection ..."+e.toString());
		}
	}
	return hshValues;		
}
public HashMap goldratedetails(HashMap hshValues) throws EJBException
{
	String strQuery="",goldrate="",goldavgrate="";
	ResultSet rs=null;
	try{
		String date=correctNull((String)hshValues.get("date"));
		
		if(!date.equalsIgnoreCase("")){
			
	
			
			strQuery=SQLParser.getSqlQuery("getgolddetails^"+date);
	 		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				goldrate = Helper.correctInt((String)rs.getString("PER_GOLDRATE"));
				goldavgrate= Helper.correctInt((String)rs.getString("PER_AVG_RATE"));
				hshValues.put("goldrate", goldrate);
				hshValues.put("goldavgrate", goldavgrate);

			}
	
		}
		
		
	}catch (Exception e)
	{
		log.error("Error occurred in goldratedetails:: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
public HashMap fetchjewelappraiserlist(HashMap hshValues) throws EJBException 
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strorgCode="";
	
	try
	{	
		 strorgCode=Helper.correctNull((String)hshValues.get("strcode"));
		 String getjewelappraiserlist="0";
			 
			ArrayList arrappref=new ArrayList();
		
			if(rs!=null){rs.close();}
			if(strorgCode.equalsIgnoreCase("all"))
			{
			strQuery=SQLParser.getSqlQuery("getalljewelappraiserslist");	
			}
			else
			{
			strQuery=SQLParser.getSqlQuery("getjewelappraiserslist^"+strorgCode);
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				HashMap hashappref=new HashMap();
				
				hashappref.put("CBSID", Helper.correctNull((String)rs.getString("valuer_cbsid")));
				hashappref.put("NAME", Helper.correctNull((String)rs.getString("valuers_name")));
				hashappref.put("EXPIRY_DATE", Helper.correctNull((String)rs.getString("VALUER_EXPIRYDATE")));
				hashappref.put("ORGSCODE", Helper.correctNull((String)rs.getString("ORG_SCODE")));
				arrappref.add(hashappref);
				
				getjewelappraiserlist=Helper.correctNull((String)rs.getString("ORG_SCODE"));
			}
			
			if(!getjewelappraiserlist.equals("0"))
			{
			hshValues.put("users", arrappref);
			}else{
				hshValues.put("users", "Data not found");
			}
		
		
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean fetchjewelappraiserlist..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean fetchUserDetails in  closing connection ..."+e.toString());
		}
	}
	
	return hshValues;
}
public HashMap dogoldreappraiser(HashMap hshValues) throws EJBException 
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	String strQuery="",strorgCode="";
	String cbsid="",reappraisedon="",appno="",scode="";
	
	try
	{	
		//system user
		String strSysteUserId="SYSUSR";
		String strGoldRate="";
		String appraisal="";
		String reappraisername="";
		int intUpdatesize=0;
		 strorgCode=Helper.correctNull((String)hshValues.get("orgcode"));
		 cbsid=Helper.correctNull((String)hshValues.get("strcbsid"));
		 reappraisedon=Helper.correctNull((String)hshValues.get("strreappraisedon"));
		 appno=Helper.correctNull((String)hshValues.get("strAppno"));
		 reappraisername=Helper.correctNull((String)hshValues.get("reappraisername"));
		 strQuery=SQLParser.getSqlQuery("selorgname^"+strorgCode);
		 ArrayList golddetails=new ArrayList();
			if(rs!=null)
			{ rs.close(); }
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				scode=Helper.correctNull((String) rs.getString("ORG_SCODE"));
			}
			strQuery=SQLParser.getSqlQuery("selectgoldpreviousdata^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			 while(rs.next())
				{
				   
				    hshQuery= new HashMap();
				    arrValues = new ArrayList();
				    intUpdatesize++;
				    
					hshQuery.put("strQueryId", "insdeluserid_goldREAPPRISAL_HISTORY");
					
					arrValues.add(Helper.correctNull(rs.getString("GOLD_APPNO")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_SLNO")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_DESC")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_QUANTITY")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_CURRMARVAL")));
					arrValues.add(Helper.CLOBToString(rs.getClob("GOLD_REMARKS")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRNAME")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPPDATE")));
					arrValues.add(scode);
					arrValues.add(Helper.correctNull(rs.getString("GOLD_USERID")));
					arrValues.add(Helper.correctNull(rs.getString("GOLD_REAPRCUSTID")));
					arrValues.add(strSysteUserId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
				}
			 if(rs!=null)
				{
					rs.close();
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("currentgoldrate_new^"+reappraisedon);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					strGoldRate=Helper.correctDouble((String)rs1.getString("PER_GOLDRATE"));
				}
				if(rs1!=null)
				{
					rs1.close();
				}
			
				hshQuery= new HashMap();
			    arrValues = new ArrayList();
			    intUpdatesize++;
				hshQuery.put("strQueryId", "del_Gold_rEApprasial");
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
				
				
				
				
				ArrayList arrayDigiGold=new ArrayList();
				ArrayList arrDigiGoldValue=new ArrayList();
				arrayDigiGold=(ArrayList) hshValues.get("arrgolddetails");
				int arrayDigiGoldSize=arrayDigiGold.size();
				int serialNo=0;
				
				if(arrayDigiGoldSize>0)
				{
					for(int i=0;i<arrayDigiGoldSize;i++)
						{
					serialNo++;	
					arrDigiGoldValue=(ArrayList) arrayDigiGold.get(i);
					
					
					HashMap hashappref=new HashMap();
					hshQuery = new HashMap();
					intUpdatesize++;
					arrValues = new ArrayList();
					arrValues.add(appno);//1
					arrValues.add(correctNull((String)arrDigiGoldValue.get(0)));//2
					hashappref.put("Article Number",correctNull((String)arrDigiGoldValue.get(0)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(1)));//3
					hashappref.put("Description of Articles", correctNull((String)arrDigiGoldValue.get(1)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(2)));//4
					hashappref.put("Quantity", correctNull((String)arrDigiGoldValue.get(2)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(3)));//5
					hashappref.put("Gross Weight in gms", correctNull((String)arrDigiGoldValue.get(3)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(4)));//6
					hashappref.put("Net Weight in gms", correctNull((String)arrDigiGoldValue.get(4)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(5)));//7
					hashappref.put("Purity", correctNull((String)arrDigiGoldValue.get(5)));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(6)));//8
					strGoldRate=correctNull((String)arrDigiGoldValue.get(6));
					arrValues.add(correctNull((String)arrDigiGoldValue.get(7)));//9
					arrValues.add(correctNull((String)arrDigiGoldValue.get(8)));//10
					hashappref.put("Estimated value in Rs.", correctNull((String)arrDigiGoldValue.get(8)));
					
					arrValues.add(reappraisername);//11	
					arrValues.add(reappraisedon);//12
					arrValues.add(strSysteUserId);//13
					arrValues.add("pa");//14
					arrValues.add(cbsid);//15
					arrValues.add(strSysteUserId);//16
					arrValues.add("Y");//17
		
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_Gold_rEApprasial_sysuser_new");
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					golddetails.add(hashappref);
					}
				}
				
				else
				{
				
				strQuery=SQLParser.getSqlQuery("sel_GoldRate_value_alreadyappoved^"+appno);				
				rs = DBUtils.executeQuery(strQuery);				
				while (rs.next())
				{
					
					HashMap hashappref=new HashMap();
					  intUpdatesize++;
					    hshQuery= new HashMap();
					    arrValues = new ArrayList();
					  
					hshQuery.put("strQueryId", "ins_Gold_rEApprasial_sysuser");
					arrValues.add(appno);//1	
					arrValues.add(Helper.correctNull(rs.getString("AGR_ARTNO")));//2
					hashappref.put("Article Number", Helper.correctNull(rs.getString("AGR_ARTNO")));
					arrValues.add(Helper.correctNull(rs.getString("AGR_ARTDESC")));//3
					hashappref.put("Description of Articles", Helper.correctNull(rs.getString("AGR_ARTDESC")));
					arrValues.add(Helper.correctNull(rs.getString("AGR_ARTGROSSWT")));//4
					hashappref.put("Gross Weight in gms", Helper.correctNull(rs.getString("AGR_ARTGROSSWT")));
					arrValues.add(Helper.correctNull(rs.getString("AGR_QUANTITY")));//5
					hashappref.put("Quantity", Helper.correctNull(rs.getString("AGR_QUANTITY")));
					arrValues.add(Helper.correctNull(rs.getString("AGR_ARTNETWT")));//6
					hashappref.put("Net Weight in gms", Helper.correctNull(rs.getString("AGR_ARTNETWT")));
					arrValues.add(strGoldRate);	//7
					arrValues.add("");//8 
					arrValues.add(reappraisername);	//9
					arrValues.add(reappraisedon);//10
					arrValues.add(strSysteUserId);//11
					arrValues.add("pa");//12
					arrValues.add(cbsid);//13
					arrValues.add(strSysteUserId);//14
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					golddetails.add(hashappref);
					
				}
				}
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshValues.put("Latest_Market_value", strGoldRate);
				hshValues.put("Gold_Details", golddetails);
		
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean fetchjewelappraiserlist..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean fetchUserDetails in  closing connection ..."+e.toString());
		}
	}
	
	return hshValues;
}
//vindhya begin
public HashMap usertransfer(HashMap hshValues) throws EJBException
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null;
	ResultSet rs1=null;
	StringBuilder sbolddata=new StringBuilder();
	String strActionData="";
	try{
		String struserid=correctNull((String)hshValues.get("struserid"));
		String strorg_code=correctNull((String)hshValues.get("strorg_code"));
		String strsol_id=correctNull((String)hshValues.get("strsol_id"));
		
		rs =DBUtils.executeLAPSQuery("setuserssel^"+struserid);			
		if(rs.next())
		{
			sbolddata.append("~ Login Name / Employee Code = "+Helper.correctNull((String)rs.getString("usr_id")));
			sbolddata.append("~ First Name = "+Helper.correctNull((String)rs.getString("usr_fname")));
			sbolddata.append("~ Last Name = "+Helper.correctNull((String)rs.getString("usr_lname")));
			sbolddata.append("~ Designation = "+Helper.correctNull((String)rs.getString("user_designation")));
			rs1 = DBUtils.executeLAPSQuery("selmailaddress^"+Helper.correctNull((String)rs.getString("usr_orgcode")));
			if(rs1.next())
			{
				sbolddata.append("~Location ="+Helper.correctNull((String)rs1.getString("org_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeLAPSQuery("setgroupssel_audit^"+Helper.correctNull((String)rs.getString("usr_grpid")));
			if(rs1.next())
			{
				sbolddata.append("~ Group = "+Helper.correctNull((String)rs1.getString("grp_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}					
			sbolddata.append("~ Class = "+Helper.correctNull((String)rs.getString("usr_class")));
			rs1 = DBUtils.executeLAPSQuery("selclasslist_workflow^7"+"^"+Helper.correctNull((String)rs.getString("usr_class")));
			if(rs1.next())
			{
				sbolddata.append("~ Class Description = "+Helper.correctNull((String)rs1.getString("stat_data_desc1")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			sbolddata.append("~ Availability = ");
			if(Helper.correctNull((String)rs.getString("usr_avail")).equalsIgnoreCase("a"))
			{
				sbolddata.append("Available");
			}
			else
			{
				sbolddata.append("Unavailable");
			}
			sbolddata.append("~ Function = "+Helper.correctNull((String)rs.getString("usr_function")));
		}	
		if(!struserid.equalsIgnoreCase("") && !strorg_code.equalsIgnoreCase("")){
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updateusersol_id");
			arrValues.add(strorg_code);	//1
			arrValues.add(struserid);	//2
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");			
			hshValues.put("Userid", struserid);
			if(rs1!=null)
			{
				rs1.close();
			}
			String Location="";
			rs1 = DBUtils.executeLAPSQuery("selmailaddress^"+Helper.correctNull((String)rs.getString("usr_orgcode")));
			if(rs1.next())
			{
				Location=Helper.correctNull((String)rs1.getString("org_name"));
			}
			strActionData="~ User Location updated as ~ "+ Location+"-"+strsol_id+" for User Id= "+struserid;
		}
		hshValues.put("hidAction", "update");
		hshValues.put("strUserId", "SYSUSER");
		hshValues.put("strClientIP", "SYSUSER");
		AuditTrial.auditNewLog(hshValues,"8","set",strActionData,sbolddata.toString());
		
	}catch (Exception e)
	{
		log.error("Error occurred in UserTransfer:: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
//for user closure
public HashMap useravailability(HashMap hshValues) throws EJBException
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null;
	ResultSet rs1=null;
	StringBuilder sbolddata=new StringBuilder();
	String strActionData="";
	try{
		String struserid=correctNull((String)hshValues.get("struserid"));
		
		rs =DBUtils.executeLAPSQuery("setuserssel^"+struserid);			
		if(rs.next())
		{
			sbolddata.append("~ Login Name / Employee Code = "+Helper.correctNull((String)rs.getString("usr_id")));
			sbolddata.append("~ First Name = "+Helper.correctNull((String)rs.getString("usr_fname")));
			sbolddata.append("~ Last Name = "+Helper.correctNull((String)rs.getString("usr_lname")));
			sbolddata.append("~ Designation = "+Helper.correctNull((String)rs.getString("user_designation")));
			rs1 = DBUtils.executeLAPSQuery("selmailaddress^"+Helper.correctNull((String)rs.getString("usr_orgcode")));
			if(rs1.next())
			{
				sbolddata.append("~Location ="+Helper.correctNull((String)rs1.getString("org_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeLAPSQuery("setgroupssel_audit^"+Helper.correctNull((String)rs.getString("usr_grpid")));
			if(rs1.next())
			{
				sbolddata.append("~ Group = "+Helper.correctNull((String)rs1.getString("grp_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}					
			sbolddata.append("~ Class = "+Helper.correctNull((String)rs.getString("usr_class")));
			rs1 = DBUtils.executeLAPSQuery("selclasslist_workflow^7"+"^"+Helper.correctNull((String)rs.getString("usr_class")));
			if(rs1.next())
			{
				sbolddata.append("~ Class Description = "+Helper.correctNull((String)rs1.getString("stat_data_desc1")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			sbolddata.append("~ Availability = ");
			if(Helper.correctNull((String)rs.getString("usr_avail")).equalsIgnoreCase("a"))
			{
				sbolddata.append("Available");
			}
			else
			{
				sbolddata.append("Unavailable");
			}
			sbolddata.append("~ Function = "+Helper.correctNull((String)rs.getString("usr_function")));
		}	
		if(!struserid.equalsIgnoreCase("")){
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updateuserclosure");			
			arrValues.add(struserid);	//1
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");			
			hshValues.put("Userid", struserid);
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strActionData="~ User Details modified as Unavailable for User Id ="+struserid;
		}
		hshValues.put("hidAction", "update");
		hshValues.put("strUserId", "SYSUSER");
		hshValues.put("strClientIP", "SYSUSER");
		AuditTrial.auditNewLog(hshValues,"8","set",strActionData,sbolddata.toString());
		
	}catch (Exception e)
	{
		log.error("Error occurred in UserAvailability:: " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
//for designation update
public HashMap userDesignationupdate(HashMap hshValues) throws EJBException
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null;
	ResultSet rs1=null;
	StringBuilder sbolddata=new StringBuilder();
	String strActionData="";
	String strgroupname="";
	try{
		String struserid=correctNull((String)hshValues.get("struserid"));
		String strdesignationcode=correctNull((String)hshValues.get("strdesignationcode"));		
		String strgroupcode=correctNull((String)hshValues.get("strgroupcode"));
		//String strclasscode=correctNull((String)hshValues.get("strclasscode"));
		
		rs =DBUtils.executeLAPSQuery("setuserssel^"+struserid);			
		if(rs.next())
		{
			sbolddata.append("~ Login Name / Employee Code = "+Helper.correctNull((String)rs.getString("usr_id")));
			sbolddata.append("~ First Name = "+Helper.correctNull((String)rs.getString("usr_fname")));
			sbolddata.append("~ Last Name = "+Helper.correctNull((String)rs.getString("usr_lname")));
			sbolddata.append("~ Designation = "+Helper.correctNull((String)rs.getString("user_designation")));
			rs1 = DBUtils.executeLAPSQuery("selmailaddress^"+Helper.correctNull((String)rs.getString("usr_orgcode")));
			if(rs1.next())
			{
				sbolddata.append("~Location ="+Helper.correctNull((String)rs1.getString("org_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeLAPSQuery("setgroupssel_audit^"+Helper.correctNull((String)rs.getString("usr_grpid")));
			if(rs1.next())
			{
				sbolddata.append("~ Group = "+Helper.correctNull((String)rs1.getString("grp_name")));
			}
			if(rs!=null)
			{
				rs1.close();
			}					
			sbolddata.append("~ Class = "+Helper.correctNull((String)rs.getString("usr_class")));
			rs1 = DBUtils.executeLAPSQuery("selclasslist_workflow^7"+"^"+Helper.correctNull((String)rs.getString("usr_class")));
			if(rs1.next())
			{
				sbolddata.append("~ Class Description = "+Helper.correctNull((String)rs1.getString("stat_data_desc1")));
			}
			if(rs!=null)
			{
				rs1.close();
			}
			sbolddata.append("~ Availability = ");
			if(Helper.correctNull((String)rs.getString("usr_avail")).equalsIgnoreCase("a"))
			{
				sbolddata.append("Available");
			}
			else
			{
				sbolddata.append("Unavailable");
			}
			sbolddata.append("~ Function = "+Helper.correctNull((String)rs.getString("usr_function")));
		}	
		if(!struserid.equalsIgnoreCase("")){
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","updatedesignationdetails");	
			arrValues.add(strdesignationcode);	//0 
			arrValues.add(strgroupcode);//1	
			//arrValues.add(strclasscode);//2	
			arrValues.add(struserid);	//3
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");			
			hshValues.put("Userid", struserid);
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeLAPSQuery("setgroupssel_audit^"+strgroupcode);
			if(rs1.next())
			{
				strgroupname="~ Group = "+Helper.correctNull((String)rs1.getString("grp_name"));
			}
			strActionData=" ~ User Details modified ~ Designation="+strdesignationcode+" "+strgroupname+" ~ for User Id "+struserid;
		}
		hshValues.put("hidAction", "update");
		hshValues.put("strUserId", "SYSUSER");
		hshValues.put("strClientIP", "SYSUSER");
		AuditTrial.auditNewLog(hshValues,"8","set",strActionData,sbolddata.toString());
		
	}catch (Exception e)
	{
		log.error("Error occurred in UserDesignationchange : " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}
//for user creation
public HashMap Usercreation(HashMap hshValues) throws EJBException
{
	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null;
	ResultSet rs1=null;
	StringBuilder sbolddata=new StringBuilder();
	String strActionData="";
	String strgroupname="";
	try{
		String struserid=correctNull((String)hshValues.get("struserid"));
		String strusergroupcode=correctNull((String)hshValues.get("strusergroupcode"));		
		String struser_solid=correctNull((String)hshValues.get("struser_solid"));
		String strorg_code=correctNull((String)hshValues.get("strorg_code"));
		String strfirstname=correctNull((String)hshValues.get("strfirstname"));
		String strlastname=correctNull((String)hshValues.get("strlastname"));
		String strpassword=correctNull((String)hshValues.get("strpassword"));
		String strclasscode=correctNull((String)hshValues.get("strclasscode"));
		String strdesignationcode=correctNull((String)hshValues.get("strdesignationcode"));
		String stremailid=correctNull((String)hshValues.get("stremailid"));
		String strdepartmentcode=correctNull((String)hshValues.get("strdepartmentcode"));		
			
		
		if(!struserid.equals("")||!strusergroupcode.equals("")||!struser_solid.equals("")||!strfirstname.equals("")
				||!strlastname.equals("")||!strpassword.equals("")||!strclasscode.equals("")||
				!strdesignationcode.equals(""))
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQueryValues.put("size","1");
		hshQuery.put("strQueryId","insertuser_api");
		arrValues.add(struserid);
		arrValues.add(strusergroupcode);
		arrValues.add(strorg_code);
		arrValues.add(strfirstname);
		arrValues.add("");
		arrValues.add(strlastname);
		arrValues.add(strpassword);
		arrValues.add(strclasscode);
		if(strclasscode.equals("50"))
		{
			arrValues.add("Processing");	
		}
		else
		{
			arrValues.add("Monitoring");
		}
		arrValues.add(strdesignationcode);
		arrValues.add(stremailid);
		arrValues.add(strdepartmentcode);
		/*arrValues.add(Helper.correctNull((String)hshValues.get("usr_supstatus")));
		arrValues.add(Helper.correctNull((String)hshValues.get("usr_avail")));
		arrValues.add(Helper.correctNull((String)hshValues.get("usr_function")));
		arrValues.add(Helper.correctNull((String)hshValues.get("usr_sanction")));
		arrValues.add(Helper.correctNull((String)hshValues.get("user_designation")));
		arrValues.add("Y");
		arrValues.add(Helper.correctNull((String)hshValues.get("usr_emailid")));
		arrValues.add(Helper.correctNull((String)hshValues.get("usr_department")));
		arrValues.add(Helper.correctNull((String)hshValues.get("sle_rmd")));				
		arrValues.add(Helper.correctNull((String)hshValues.get("sel_rlpftype")));	
		arrValues.add(Helper.correctNull((String)hshValues.get("hrms_des")));
		arrValues.add(Helper.correctNull((String)hshValues.get("hrms_jobCode")));*/
		hshQuery.put("arrValues",arrValues);
	   	hshQueryValues.put("1",hshQuery);
	   	hshValues.put("Userid", struserid);
	   	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		/*hshValues.put("hidAction", "update");
		hshValues.put("strUserId", "SYSUSER");
		hshValues.put("strClientIP", "SYSUSER");
		//AuditTrial.auditNewLog(hshValues,"8","set",strActionData,sbolddata.toString());*/
		
	}catch (Exception e)
	{
		log.error("Error occurred in Usercreation : " + e.getMessage());
		throw new EJBException(e);
	}
	return hshValues;
	
}

//vindhya end
public HashMap perappidcreation(HashMap hshValues) throws EJBException 
{

	HashMap hshQuery= new HashMap();
	HashMap hshRecord=new HashMap();
	ArrayList arrValues= new ArrayList();
	HashMap hshQueryValues= new HashMap();
	ResultSet rs=null,rs1=null;
	ResultSet rs5=null;
	String strQuery="",strorgCode="";
	String cbsid="";
	boolean boolMandatoryCBSFieldsFilled=true;

	Connection connectDB	= null;
	CallableStatement callableStmt = null;
	try
	{
		
		cbsid=Helper.correctNull((String)hshValues.get("strCBSID"));
		HashMap checkMandatoryFields= new HashMap();
		HashMap  hshCBSMandatoryList = new HashMap();
		HashMap hshResult= new HashMap();
		HashMap hshCBSData=new HashMap();
		checkMandatoryFields.put("hidDemoId", cbsid);

      String strLapsCustId="";
      String newstrLapsCustId="";
      String strCBSId="";
      String strCustomer="";
      
      if(rs5!=null)
		{
    	  rs5.close();
		}
		if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
		{
			strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+cbsid);
			rs5=DBUtils.executeQueryCBSConnection(strQuery);
		}
		else
		{
			strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+cbsid);
			rs5=DBUtils.executeQuery(strQuery); 
		}
		if (rs5.next()) {
			
		
		strQuery= SQLParser.getSqlQuery("perapplicant_selcbsid^"+cbsid);	//search by demo id
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			rs1 = DBUtils.executeLAPSQuery("perapplicant_selMaxAppId^"+cbsid);
			if(rs1.next())
			{
				strLapsCustId	=	correctNull(rs1.getString("perapp_maxid")); //Applicant id
				strCBSId= 	Helper.correctNull(rs.getString("perapp_cbsid")); //CBS customer ID	
				
				/*hshCBSMandatoryList=(HashMap)EJBInvoker.executeStateLess("cbsinterface",checkMandatoryFields,"checkMandatoryFieldsFromCBS");
				if(hshCBSMandatoryList.size()>0)
				{
					boolMandatoryCBSFieldsFilled=((Boolean)hshCBSMandatoryList.get("keyBoolMandatoryCBSFieldsFilled")).booleanValue();
					if(!boolMandatoryCBSFieldsFilled)
					{
						
						 hshQueryValues= new HashMap();
						 hshQuery= new HashMap();
						arrValues=new ArrayList();
						arrValues.add("N");
						arrValues.add(strLapsCustId);
						hshQueryValues.put("size","1");
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId", "perapplicant_updcbsdataflag");
						hshQueryValues.put("1",hshQuery);			
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						hshCBSMandatoryList.put("mandatorymissing", "Y");
						hshCBSMandatoryList.put("strResponseCode", "LAPS-404");
						hshCBSMandatoryList.put("strResponseMsg", "Cannot proceed the further kindly vist Branch");
						return hshCBSMandatoryList;
					}
				}
				hshQueryValues= new HashMap();
				hshQuery= new HashMap();
				arrValues=new ArrayList();
				arrValues.add("Y");
				arrValues.add(strLapsCustId);
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId", "perapplicant_updcbsdataflag");
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
			}
			strCustomer="existing";					
		}
		else
		{	
			
			/*hshCBSMandatoryList=(HashMap)EJBInvoker.executeStateLess("cbsinterface",checkMandatoryFields,"checkMandatoryFieldsFromCBS");
			if(hshCBSMandatoryList.size()>0)
			{
				boolMandatoryCBSFieldsFilled=((Boolean)hshCBSMandatoryList.get("keyBoolMandatoryCBSFieldsFilled")).booleanValue();
				if(!boolMandatoryCBSFieldsFilled)
				{
					hshCBSMandatoryList.put("mandatorymissing", "Y");
					hshCBSMandatoryList.put("strResponseCode", "LAPS-404");
					hshCBSMandatoryList.put("strResponseMsg", "Cannot proceed the further kindly vist the Branch");
					return hshCBSMandatoryList;
				}
			}*/
			
			
			
			
			MastApplicantBean mastApplicantBean=new MastApplicantBean();
			newstrLapsCustId = mastApplicantBean.getApplicantCode();	
			strCustomer="new";
			strLapsCustId=newstrLapsCustId;
			
			
			/*hshQueryValues= new HashMap();
			hshQuery= new HashMap();
			arrValues=new ArrayList();
			arrValues.add("Y");
			arrValues.add(strLapsCustId);
			hshQueryValues.put("size","1");
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId", "perapplicant_updcbsdataflag");
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
		}
		hshCBSData.put("custid",cbsid);
		hshCBSData.put("strLapscustid",strLapsCustId);
		hshCBSData.put("module","Retail");
		hshCBSData.put("strCustomer",strCustomer);
		hshResult=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshCBSData,"getCbsApplicantData");	
		
		
		
		
		
		
		boolean boolappstatus=false;
		
		if(strCustomer.equalsIgnoreCase("existing"))
		{
		
		if(rs!=null)
			rs.close();
		rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+strLapsCustId);				 
		if(rs.next())
		{
			boolappstatus=true;
		}
		
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp_cooapp^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_processAppl_solvency_newid^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_processAppl_bankers_newid^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_processAppl_kpower_newid^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		if(!boolappstatus)
		{
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_processApplmsmenewid^"+strLapsCustId);				 
			if(rs.next())
			{
				boolappstatus=true;
			}
		}
		
		
		
		
		
		
		
		
		
		
		if(boolappstatus==true)
		{
		String strAppCode="";
		MastApplicantBean mastApplicantBean=new MastApplicantBean();
		strAppCode = mastApplicantBean.getApplicantCode();
		String strOldAppId = strLapsCustId;

		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		
		/*
		 * The following code is hided by prakash. Because KBL required that the customer should have the 
		 * same perapp_oldid though the customer is renewed n number of times.
		 */
		/*if(OldAppId.equalsIgnoreCase(""))
		{
			arrValues.add(strOldAppId);	
		}
		else
		{
			arrValues.add(OldAppId);	
		}*/
		arrValues.add("n");
		arrValues.add(strOldAppId);		
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","perapplicantrenewodad_api");
		hshQueryValues.put("1",hshQuery);
		
		// update renew column in perapplicant table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add("y");
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","perapplicantupdaterenew");
		hshQueryValues.put("2",hshQuery);
		
		// insert data in to individual_info table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","individual_info_renew");
		hshQueryValues.put("3",hshQuery);
		
		// insert data in to company_info table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","company_info_renew");
		hshQueryValues.put("4",hshQuery);
		
		// insert data in to perincexpences table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","perincomerenew");
		hshQueryValues.put("5",hshQuery);
		
		// insert data in to peremployer table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","peremployerrenew");
		hshQueryValues.put("6",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();			
		arrValues.add(strOldAppId);
		arrValues.add(strAppCode);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","ins_perapplicant_idmap");
		hshQueryValues.put("7",hshQuery);
		
		// insert data in to KYC norms table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","kycnormsrenew");
		hshQueryValues.put("8",hshQuery);
		
		// insert data in to Communication Details table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","percomaddressrenew");
		hshQueryValues.put("9",hshQuery);
		
		// insert data in to Customer Rating table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","percusratingrenew");
		hshQueryValues.put("10",hshQuery);
		
		// insert data in to Customer Cibil Details Details table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","percuscibilrenew");
		hshQueryValues.put("11",hshQuery);
		
		// insert data in to Customer Defaulter Details table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","percusdefaultrenew");
		hshQueryValues.put("12",hshQuery);
		
		//insert for Other bank details by rajesh on 07/02/2014
		/*arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","perotherbankrenew");
		hshQueryValues.put("13",hshQuery);*/
		
		
		// Applicant New id updated to per_demographics table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","perdemographicsrenew");
		hshQueryValues.put("13",hshQuery);
		
		
		// Applicant New id updated to com_demographics table
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","comdemographicsrenew");
		hshQueryValues.put("14",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","agrlandholdingsrenew");
		hshQueryValues.put("15",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","comcompanydetailsrenew");
		hshQueryValues.put("16",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","updatecusgroupsmembersrenew");
		hshQueryValues.put("17",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","divisiondetailsrenew");
		hshQueryValues.put("18",hshQuery);
		
//		arrValues=new ArrayList();
//		hshQuery=new HashMap();
//		arrValues.add(strAppCode);
//		arrValues.add(strOldAppId);
//		hshQuery.put("arrValues",arrValues);
//		hshQuery.put("strQueryId","comapp_division_id_update");
//		hshQueryValues.put("19",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","renew_agrappshg");
		hshQueryValues.put("19",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","renew_agrappshg_member");
		hshQueryValues.put("20",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","renew_agrappshg_addtnlinfo");
		hshQueryValues.put("21",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","percusratingnewrenew");
		hshQueryValues.put("22",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","upd_solvency_idrenew");
		hshQueryValues.put("23",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","upd_kpower_idrenew");
		hshQueryValues.put("24",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","renew_com_Financialparticulars");
		hshQueryValues.put("25",hshQuery);
		
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);//0
		hshQuery.put("strQueryId","comapp_division_id_update");
		
		if(rs1!=null)
		{ rs1.close();}
		strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strOldAppId);//add query here
		rs1=DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{
			arrValues.add(correctNull(rs1.getString("PERAPP_FNAME")));//1
			if(Helper.correctNull(rs1.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
			{
				arrValues.add(correctNull(rs1.getString("CON_PERMADDR1"))+ " "+correctNull(rs1.getString("CON_PERMADDR2"))+ " "+correctNull(rs1.getString("CON_PERMVILLAGE")));//2
				arrValues.add(correctNull(rs1.getString("CON_PERMCITY")));//3
				arrValues.add(correctNull(rs1.getString("CON_PERMDIST")));//4
				arrValues.add(correctNull(rs1.getString("CON_PERMSTATE")));//5
				arrValues.add(correctNull(rs1.getString("CON_PERMZIP")));//6
				arrValues.add(correctNull(rs1.getString("CON_PERMPHONE")));//7
				arrValues.add(correctNull(rs1.getString("CON_PERMFAX")));//8
			}
			else
			{
				arrValues.add(correctNull(rs1.getString("CON_COMADDR1"))+ " "+correctNull(rs1.getString("CON_COMADDR2"))+ " "+correctNull(rs1.getString("CON_COMVILLAGE")));//2
				arrValues.add(correctNull(rs1.getString("CON_COMCITY")));//3
				arrValues.add(correctNull(rs1.getString("CON_COMDIST")));//4
				arrValues.add(correctNull(rs1.getString("CON_COMSTATE")));//5
				arrValues.add(correctNull(rs1.getString("CON_COMZIP")));//6
				arrValues.add(correctNull(rs1.getString("CON_COMPHONE")));//7
				arrValues.add(correctNull(rs1.getString("CON_COMFAX")));//8
			}
		}
		else
		{
			arrValues.add("");//1
			arrValues.add("");//2
			arrValues.add("");//3
			arrValues.add("");//4
			arrValues.add("");//5
			arrValues.add("");//6
			arrValues.add("");//7
			arrValues.add("");//8
		}
		arrValues.add(strOldAppId);//9
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("26",hshQuery);
		
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","renew_com_charge_assets");
		hshQueryValues.put("27",hshQuery);
		
		//svandidhi tab
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","ins_svanidhidetails_renew");
		hshQueryValues.put("28",hshQuery);
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","ins_per_familyDetails_renew");
		hshQueryValues.put("29",hshQuery);
					
		hshQueryValues.put("size","29");
		
		
		
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues.add(strAppCode);
		arrValues.add(strOldAppId);
		hshQuery.put("arrValues",arrValues);
		hshQuery.put("strQueryId","upd_bankercertificate_idrenew");
		hshQueryValues.put("30",hshQuery);
		
		hshQueryValues.put("size","30");
					
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		
		//For inserting in Finacial(corp_fin_year table,com_finance,COM_FINAPPVALUES)
		
		String strOldFinID="",strNewFinID="";
		
		
		strQuery=SQLParser.getSqlQuery("selfinancerenew^"+strOldAppId);
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
		callableStmt.setString(3,correctNull(strAppCode));
		callableStmt.execute();
		callableStmt.clearParameters();
		
		connectDB.close();
		
		}
		}
		/*rs1=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strOldAppId);
		if(rs1.next())
		{
			strcbsid=Helper.correctNull((String)rs1.getString("perapp_cbsid"));
		}
		hshval.put("custid",strcbsid);
		hshval.put("strLapscustid",strAppCode);
		hshval.put("strCustomer","existing");
		hshRecord=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshval,"getCbsApplicantData");*/
		
//========================================= Branch Counting================================================ 
	 rs = null;
		String OldAppidBrCode = "";
		String maxBranchCount = "";
		
	strQuery=SQLParser.getSqlQuery("sel_branchcode^"+strOldAppId);
		rs=DBUtils.executeQuery(strQuery);	
		if(rs.next())
		{
			OldAppidBrCode = Helper.correctNull((String)rs.getString("perapp_branchcode")); 
		}
		
		if(OldAppidBrCode.equalsIgnoreCase(Helper.correctNull((String)hshValues.get("strOrgShortCode"))))
		{
	
			strQuery=SQLParser.getSqlQuery("sel_branchcount^"+strOldAppId+"^"+Helper.correctNull((String)hshValues.get("strOrgShortCode")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				maxBranchCount = Helper.correctNull((String)rs.getString(1)); 
			}
			
		
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			hshQueryValues = new HashMap();
			arrValues.add(maxBranchCount);
			arrValues.add(strAppCode);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updBranchCount");
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
		}
		else
		{
			
			strQuery=SQLParser.getSqlQuery("sel_exiBranchcount^"+strOldAppId+"^"+Helper.correctNull((String)hshValues.get("strOrgShortCode")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				maxBranchCount = Helper.correctNull((String)rs.getString(1)); 
			}
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			hshQueryValues = new HashMap();
			arrValues.add(maxBranchCount);
			arrValues.add(strAppCode);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updBranchCount");
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			
			
			
		}
		
		
		hshValues.put("strNewLAPSid", strAppCode);
		hshValues.put("strResponseCode", "LAPS-1008");
		hshValues.put("strResponseMsg", "LAPS Customer Profile Created Successfully");
		
		}
		else
		{
			hshValues.put("strNewLAPSid", strLapsCustId);
			hshValues.put("strResponseCode", "LAPS-1008");
			hshValues.put("strResponseMsg", "LAPS Customer Profile Created Successfully");
		}
		
		
		
		
		
		}
		else
		{
			
			
			
			HashMap hshQuerynew = new HashMap();
			HashMap hshQuery1=new HashMap();
			ArrayList arrValues1=new ArrayList();
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			arrValues1.add(cbsid);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updateperapplicantmob");
			hshQuerynew.put("1",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updateindividualmob");
			hshQuerynew.put("2",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updatecompanyinfomob");
			hshQuerynew.put("3",hshQuery1);
			
			
			
			String diffyears="";
			String strSolid="";
			String districtcode="";
			String refid="";
			String strCusIDRef="";
			if(rs!=null)
			{
				rs.close();
			}
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+cbsid);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+cbsid);
				rs=DBUtils.executeQuery(strQuery); 
			}
			if (rs.next()) {
				diffyears= Helper.correctNull(rs.getString("years"))+"~"+"0";
				strSolid= Helper.correctNull(rs.getString("solid"));
				refid= Helper.correctNull(rs.getString("solid"));
				strCusIDRef=Helper.correctNull(rs.getString("id_number"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery= SQLParser.getSqlQuery("getdistinctcode^"+strSolid);
			rs=DBUtils.executeQuery(strQuery); 
			if(rs.next())
			{
				districtcode	= Helper.correctNull(rs.getString("ORG_DISTRICT"));
			}
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(diffyears);
			arrValues1.add(districtcode);
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updatecustcontactmob");
			hshQuerynew.put("4",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(strCusIDRef);
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updatekycnormsmob");
			hshQuerynew.put("5",hshQuery1);
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","insertcusratemob");
			hshQuerynew.put("6",hshQuery1);
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","insertcusdefaultermob");
			hshQuerynew.put("7",hshQuery1);
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","insertcuscibildetailsmob");
			hshQuerynew.put("8",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","perdelIncome");
			hshQuerynew.put("9",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","insertperincexpensesmob");
			hshQuerynew.put("10",hshQuery1);
			
			
			hshQuery1=new HashMap();
			arrValues1=new ArrayList();
			arrValues1.add(newstrLapsCustId);
			hshQuery1.put("arrValues",arrValues1);
			hshQuery1.put("strQueryId","updateprofilestatus");
			hshQuerynew.put("11",hshQuery1);
			
			
			hshQuerynew.put("size","11");
			
			EJBInvoker.executeStateLess("dataaccess",hshQuerynew,"updateData");	
			
			hshValues.put("strNewLAPSid", newstrLapsCustId);
		hshValues.put("strResponseCode", "LAPS-1008");
		hshValues.put("strResponseMsg", "LAPS Customer Profile Created Successfully");	
		}
		}
		else
		{
			hshValues.put("strResponseCode", "LAPS-1008");
			hshValues.put("strResponseMsg", "Given Custid is not present in Finacle");	
		}
	}
	catch(Exception e)
	{
		throw new EJBException("Error in DigitalAppInterface Bean fetchjewelappraiserlist..."+e.toString());
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
			throw new EJBException("Error in DigitalAppInterface Bean fetchUserDetails in  closing connection ..."+e.toString());
		}
	}
	
	return hshValues;

	
}

}