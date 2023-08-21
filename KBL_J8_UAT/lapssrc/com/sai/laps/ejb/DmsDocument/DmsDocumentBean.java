package com.sai.laps.ejb.DmsDocument;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.sai.laps.ejb.DigitalAppInterface.DigitalAppInterfaceBean;
import com.sai.laps.ejb.DmsDocument.DmsDocumentRemote;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

import sun.misc.BASE64Encoder;

@Stateless(name = "DmsDocumentBean", mappedName = "DmsDocumentHome")
@Remote (DmsDocumentRemote.class)
public class DmsDocumentBean extends BeanAdapter {
	
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
	
public HashMap getDocumentURLs(HashMap hshValues) throws Exception
	 {

	HashMap hshRecord=new HashMap();	
	ResultSet rs=null,rs1=null;
	String strAppno="",strQuery="",docpagetype="";
	ArrayList arrCol=new ArrayList();
	ArrayList arrAppRow=new ArrayList();
	ArrayList arrBankRow=new ArrayList();
	ArrayList arrOtherRow=new ArrayList();
	
	JSONObject objOuter = new JSONObject();
	JSONObject data = new JSONObject();
	JSONObject objTable = new JSONObject();
	
	String line = "", strGeneratedFlag = "", strCustId = "", strActiontype = ""
			, strInputJSONRequest = "", strRes = "", strCustDesc = "", strEntity = ""
			, strApplicationNo = "", strFileName = ""
			, strUserId = "", strCreatedDate = "", strSNo = "", strDelFlag = "", strDelUseId =""
			, strDelDate = "", strDocFacslNo ="",strdigiprop="",strDmsRefNo="",strcredentials="",strstatus="";

	HashMap hshQueryValues = new HashMap();
	HashMap hshVal = new HashMap();
	ArrayList arrValue = null;
	ArrayList arrValues = null;
	HashMap hshValue = new HashMap();
	HashMap hshValue1 = new HashMap();
	HashMap hshQuery = new HashMap();
	
	try
	{
		
		strApplicationNo = Helper.correctNull((String)hshValues.get("appno"));
		strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		
		
		if(rs!=null)
			rs.close();
		
		strQuery=SQLParser.getSqlQuery("sel_appstatus^"+strApplicationNo);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strdigiprop=Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));
			strstatus=Helper.correctNull((String)rs.getString("app_status"));

		}
		if(strdigiprop.equalsIgnoreCase("") && strstatus.equalsIgnoreCase("op"))
		{
		//---------General STARTS--------------------//
			strQuery=SQLParser.getSqlQuery("sel_leadnumber_appno^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strDmsRefNo=Helper.correctNull((String)rs.getString("inward_no"));
    		}

    		String applicantIn="{" +
			"\"LARNumber\":\""+strDmsRefNo+""+"\"}";
    		
    		System.out.print(applicantIn);
			log.info("################@@@@@@@@@@@@@ GENERAL LOAN DOCUMENT REQUEST @@@@@@@@@@@@@################ "+applicantIn);
			
			URL Docdms_url = new URL(ApplicationParams.getStrgenDocupdurl());
			log.info("GENERAL LOAN DOCUMENT URL=========== "+Docdms_url);
			HttpURLConnection Docdms_urlcon = (HttpURLConnection) Docdms_url.openConnection();
			Docdms_urlcon.setRequestProperty("User-Agent", "");
			Docdms_urlcon.setDoInput(true);
			Docdms_urlcon.setDoOutput(true);
			Docdms_urlcon.setRequestMethod("POST");
			Docdms_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
			
			strcredentials=ApplicationParams.getStrgenDocupdun()+":"+ApplicationParams.getStrgenDocupdpd();
			String strcredentialss= new BASE64Encoder().encode(strcredentials.getBytes());
			Docdms_urlcon.setRequestProperty("Authorization","Basic" +strcredentialss);
			log.info("GENERAL LOAN DOCUMENT CREDENTIALS=========== "+strcredentialss);

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
							
							System.out.println("TEST-1");
							//delete doc attachmennts
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strApplicationNo);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "del_appdoc_genappl");
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
//							System.out.println("TEST-2");	//shiva
							
							//delete external appplication document
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strApplicationNo);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "del_docattach_genappl");
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							

							int doclistlength=jsonArray3.length();
							if(doclistlength>0)
							{
								ArrayList arrtemp=new ArrayList();
								int sno=0;
								for(int i=0;i<doclistlength;i++)
								{
									
									JSONObject jsonObjectForValues = jsonArray3.getJSONObject(i);
									
									String strResDocCode = jsonObjectForValues.getString("DocCode");
//									System.out.println("Testing"+strResDocCode); //shiva
									String strUrl = jsonObjectForValues.getString("Docurl");
//									System.out.println("Testing"+strUrl);	//shiva
									String generatedUrl = jsonObjectForValues.getString("Docurl");
//									System.out.println("Testing"+generatedUrl); 	//shiva
									String strDocType= "";

									String strFile = jsonObjectForValues.getString("Docname");
//									System.out.println("Testing"+strFile);
									
									
									String strdoctype="",strdocid="";
									rs = DBUtils.executeLAPSQuery("sel_documentdetails_doccode^" + strResDocCode);
									
									if(rs.next())
									{
										strdoctype=Helper.correctNull((String)rs.getString("doc_doctype"));
										strdocid=Helper.correctNull((String)rs.getString("Document_ID"));
									}
									
//															
//									System.out.println("TEST-3");	//shiva
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
//										System.out.println("TEST-4");	//shiva
										arrtemp.add(strResDocCode);
									}
//									System.out.println("TEST-5");	//shiva
									SimpleDateFormat dateFormat= new SimpleDateFormat("dd/MM/yyyy"); 
						            Calendar calendar = Calendar.getInstance();
						            calendar.add(Calendar.DATE,90);
						            String strDay = dateFormat.format(calendar.getTime());
//						            System.out.println("Testing"+strDay); //shiva
									
						            sno++;
//						            System.out.println("Testing"+sno);	//shiva
//						            System.out.println("TEST-6");
									hshQueryValues = new HashMap();
									hshQuery=new HashMap();
									arrValues = new ArrayList();
									arrValues.add(strApplicationNo);
									arrValues.add(strdoctype);
									arrValues.add(strResDocCode);
									arrValues.add(strFile);//
									arrValues.add(strUserId);//User id
									arrValues.add(String.valueOf(sno));
									arrValues.add(""); //ref no
									arrValues.add(strDay);
									arrValues.add(strUrl);//
									arrValues.add(""); //doc size
									arrValues.add(generatedUrl);//
									arrValues.add(strDmsRefNo);//dms reference no
									arrValues.add("");
									hshQuery.put("arrValues", arrValues);
									hshQuery.put("strQueryId", "ins_appdocattachments_proposalapi");
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//									System.out.println("TEST-7");
								}
							}
							
						}
					}
			
		
		//---------General Ends--------------------//
		}
	
	}
	catch(Exception e)
	{
		 e.printStackTrace();
		 throw new EJBException("Exception in getDocumentDetails ========"+e.getMessage());
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

public HashMap getDocumentDetails(HashMap hshValues)
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
	
	
	String StrIBMUN = ApplicationParams.getStrIbmUN();
//    String strurlibmUN= new BASE64Encoder().encode(StrIBMUN.getBytes());
    hshRecord.put("encubmurlun", StrIBMUN);
    
	String StrIBMPass = ApplicationParams.getStrlogintoibmPass();
//	String strurlibm= new BASE64Encoder().encode(StrIBMPass.getBytes());
    hshRecord.put("encubmurl", StrIBMPass);
	

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

	

}
