package com.sai.laps.ejb.nsdlapplication;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.lowagie.text.pdf.codec.Base64;
import com.sai.laps.ejb.attachphoto.AttachPhotoBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import javax.xml.stream.XMLEventFactory;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.Characters;
import javax.xml.stream.events.EndElement;
import javax.xml.stream.events.StartDocument;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

import org.apache.log4j.Logger;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;
import java.text.SimpleDateFormat;
import com.sai.laps.helper.ConnectionFactory;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Hashtable;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;

import net.lingala.zip4j.core.ZipFile;
import sun.misc.BASE64Decoder;
import java.io.ByteArrayInputStream;

@Stateless(name = "NsdlApplicationBean", mappedName = "NsdlApplicationHome")
@Remote (NsdlApplicationRemote.class)
public class NsdlApplicationBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(NsdlApplicationBean.class);	
	public HashMap getNsdlRecvApplication(HashMap hshValues) 
	{
		String strSearch		=	Helper.correctNull((String)hshValues.get("hid_nsdl_refid"));
		String strNsdlID		=	Helper.correctNull((String)hshValues.get("txt_nsdl_refid")).trim();
		String strOrgCode		=	Helper.correctNull((String)hshValues.get("strOrgCode"));
		String strQuery			=	"";
		ResultSet rs			=	null,rs1=null;
		String strSearchText	=	"";
		String strSearchGlbText	=	"and nsdl_ref_id is not null";
		ArrayList arrRecvRow		=	new ArrayList();
		ArrayList arrRecvCol		=	null;
		String strPage=Helper.correctNull((String)hshValues.get("strPage"));
		try
		{
			
			if(strNsdlID.length()>0)
			{
				if(strSearch.equalsIgnoreCase("nsdl_appid"))
				{
					strSearchText="and nsdl_appid ='"+strNsdlID+"'";
					strSearchGlbText="and nsdl_appid !='"+strNsdlID+"'";
				}
				else if(strSearch.equalsIgnoreCase("nsdl_refid"))
				{
					strSearchText="and nsdl_ref_id ='"+strNsdlID+"'";
					strSearchGlbText="and nsdl_ref_id !='"+strNsdlID+"'";
				}
				strQuery = SQLParser.getSqlQuery("sel_recv_nsdlapplnsearch^"+strSearchText);
				rs =DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("nsdl_recv_usrid")).equalsIgnoreCase(""))
					{
						arrRecvCol		=	new ArrayList();
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_ref_id")));		//0
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_appid")));			//1
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_appname")));		//2
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_app_panno")));		//3
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_app_adharcard")));	//4
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocated_usrid")));//5
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocated_date")));//6
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocation_orgcode")));//7
						arrRecvCol.add("");//8
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocation_flag")));//9
						arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_recv_flag")));//10
						arrRecvCol.add(Helper.correctNull(rs.getString("NSDL_LAPS_INWARDAPPNO")));//11
						arrRecvCol.add(Helper.correctNull(rs.getString("cus_dob")));//12
						
						arrRecvRow.add(arrRecvCol);
					}
					if(!Helper.correctNull(rs.getString("nsdl_laps_inwardappno")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						
						rs1=DBUtils.executeLAPSQuery("sel_orglevel_usinguserid^"+Helper.correctNull(rs.getString("nsdl_recv_usrid")));
						if(rs1.next())
						{
							hshValues.put("strAppHoldername",Helper.correctNull(rs1.getString("name")));
							hshValues.put("strAppHolderOrgName",Helper.correctNull(rs1.getString("org_name")));
						}
						
					}
				 }
			
			}
			
			if(rs!=null)
			{rs.close(); }
			strQuery = SQLParser.getSqlQuery("sel_recv_nsdlapplication^"+strOrgCode+"^"+strSearchGlbText);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					arrRecvCol		=	new ArrayList();
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_ref_id")));		//0
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_appid")));			//1
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_appname")));		//2
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_app_panno")));		//3
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_app_adharcard")));	//4
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocated_usrid")));//5
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocated_date")));//6
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocation_orgcode")));//7
					arrRecvCol.add("");//8
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_reallocation_flag")));//9
					arrRecvCol.add(Helper.correctNull(rs.getString("nsdl_recv_flag")));//10
					arrRecvCol.add(Helper.correctNull(rs.getString("NSDL_LAPS_INWARDAPPNO")));//11
					arrRecvCol.add(Helper.correctNull(rs.getString("cus_dob")));//12
					
					arrRecvRow.add(arrRecvCol);
					
					
			}
			hshValues.put("arrRecvRow",arrRecvRow);
			hshValues.put("strSearchValue",strNsdlID);
			hshValues.put("strRadioButValue",strSearch);
			
		}
		catch(Exception ex)
		{
			log.error("Exception in getNsdlRecvApplication"+ex);
		}
		
		return hshValues;
	}
	private static final long serialVersionUID = 1L;
	public HashMap getNSDLApplications(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		
		HashMap hshQuery=null, hshQueryValues=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try {
			
			String hidparam	=Helper.correctNull((String)hshValues.get("hidparam"));
			if(hidparam.equalsIgnoreCase("Realloc"))
			{
				strQuery = SQLParser.getSqlQuery("sel_reallocate_nsdlapplication");
				rs = DBUtils.executeQuery(strQuery);
			}
			else if(hidparam.equalsIgnoreCase("Update_App"))
			{
				strQuery = SQLParser.getSqlQuery("sel_reallocate_nsdlapplication_details");
				rs = DBUtils.executeQuery(strQuery);
			}
			while (rs.next()) 
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull( rs.getString("nsdl_ref_id")));
				arrCol.add(correctNull( rs.getString("nsdl_appid")));
				arrCol.add(correctNull(rs.getString("nsdl_appname")));
				arrCol.add(correctNull(rs.getString("nsdl_app_panno")));
				arrCol.add(correctNull(rs.getString("nsdl_file_upload_date"))); 
				arrCol.add(correctNull(rs.getString("ORG_SCODE"))); 
				arrCol.add(correctNull(rs.getString("ORG_NAME"))); 
				arrCol.add(correctNull(rs.getString("region_name"))); 
				
				arrCol.add(correctNull(rs.getString("NSDL_LAPS_INWARDAPPNO")));
				//arrCol.add(correctNull(rs.getString("NSDL_STATUS"))); 
				
				String AppStatus = Helper.correctNull(rs.getString("NSDL_STATUS"));
			    String str_status="";
			    
			    str_status = AppStatus.equals("02")? "InProcess" : AppStatus.equals("05")? "Need More Information" 
			    		   : AppStatus.equals("03") ? "Approved" : AppStatus.equals("06") ? "Disbursed" : AppStatus.equals("04") ? "Rejected" : str_status;
			    
			    arrCol.add(str_status); 
				arrCol.add(correctNull(rs.getString("NSDL_LAPSAPPNO"))); 
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			if(rs!=null){
				rs.close();
			}
			if(!Helper.correctNull((String)hshValues.get("hidReallocationFlag")).equalsIgnoreCase(""))
			{
				hshValues.put("status", "success");
			}
			
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e1) {
				throw new EJBException("Error closing connection..." + e1);
			}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
		}
		return hshValues;
	}
	public HashMap updateNSDLApplicationReallocation(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;	 
		ArrayList arrValues =null;
		ResultSet rs=null;
		String strUserId = null,strRefId="",strReallocationFlag="",strAppID="";
		int intUpdatesize=0;
		String strQuery="",strOrgCode="";
		try
		{
			strReallocationFlag=correctNull((String)hshValues.get("hidReallocationFlag"));
			strRefId=correctNull((String)hshValues.get("hidRefId"));
			strUserId=correctNull((String)hshValues.get("strUserId"));
			String strRef[]=strRefId.split("@");
			strAppID=correctNull((String)hshValues.get("hidApplicantID"));
			
			if(!correctNull((String)hshValues.get("org_scode")).equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("getorgcode^"+correctNull((String)hshValues.get("org_scode")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOrgCode=Helper.correctNull(rs.getString("org_code"));
				}
				if(rs!=null)
					rs.close();
			}
			if(strReallocationFlag.equalsIgnoreCase("SendtoHO"))
			{
				strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			}
			if(!strOrgCode.equalsIgnoreCase(""))
			{
				if(strReallocationFlag.equalsIgnoreCase("ReallocationBranch"))
				{
					
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","updNSDLApp_Reallocation");				
					arrValues.add("Y");
					arrValues.add(strOrgCode);
					arrValues.add(correctNull((String)hshValues.get("org_scode")));
					arrValues.add(strUserId);
					arrValues.add("N");
					arrValues.add(strRef[0]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",String.valueOf(intUpdatesize));
					hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					
				}
				else if(strReallocationFlag.equalsIgnoreCase("SendtoHO"))
				{
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_nsdl_sendtoho");				
					arrValues.add(Helper.correctNull((String)hshValues.get("refid")));
					arrValues.add(Helper.correctNull((String)hshValues.get("appid")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",String.valueOf(intUpdatesize));
					hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					
				}
				else
				{
					for(int i=0;i<strRef.length;i++)
					{
						intUpdatesize++;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","updNSDLApp_Reallocation");				
						arrValues.add("Y");
						arrValues.add(strOrgCode);
						arrValues.add(correctNull((String)hshValues.get("org_scode")));
						arrValues.add(strUserId);
						arrValues.add("N");
						arrValues.add(strRef[i]);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",String.valueOf(intUpdatesize));
						hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
		}
		catch (Exception ce)
		{
			log.error(ce);
			throw new EJBException("Error in updateNSDLApplicationReallocation..."+ce.toString());
		}
		return hshValues;
		
	}
	public HashMap getDocumentList(HashMap hshValues)  
	{
		String strRefId=Helper.correctNull((String)hshValues.get("strRefId"));
		ResultSet rs=null;
		ArrayList arrRow	=	new ArrayList();
		ArrayList arrCol	=	new ArrayList();
		
		try
		{
			String strQuery=SQLParser.getSqlQuery("sel_nsdldocumentlist^"+strRefId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				 arrCol	=	new ArrayList();
				 arrCol.add(Helper.correctNull(rs.getString("nd_ref_id")));
				 arrCol.add(Helper.correctNull(rs.getString("nd_docname")));
				 arrCol.add(Helper.correctNull(rs.getString("nd_sno")));
				 arrCol.add(Helper.correctNull(rs.getString("nd_doctype")));
				 arrCol.add(Helper.correctNull(rs.getString("nd_docflag")));
				 arrRow.add(arrCol);
			}
			
			if(rs!=null)
			{rs.close();}
			hshValues.put("arrRow",arrRow);
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in NSDLApplicationBean ===> getDocumentList"+ex.getMessage());
		}
		return hshValues;
	}
	public HashMap viewAttachedDocument(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery;	
		String strFileExtension="",strMimeType="";
		String strRefId=Helper.correctNull((String)hshValues.get("strRefId"));		
		String strSlno=Helper.correctNull((String)hshValues.get("hidSno"));	
		Connection connection = null;
		Statement statement = null;
		try
		{		
			strQuery=SQLParser.getSqlQueryWithoutCode("sel_nsdlviewdocument^"+strRefId+"^"+strSlno );			
			connection=ConnectionFactory.getConnection();    
			statement=connection.createStatement();
			rs=statement.executeQuery(strQuery);
			if(rs.next())
			{
				Blob blobData =rs.getBlob("nd_docinbytes");
				String strFileName = Helper.correctNull(rs.getString("nd_docname"));
				if(!strFileName.equals(""))
				{
					if(strFileName.length()>=4)
					{
						strFileExtension = strFileName.substring(strFileName.length() - 3, strFileName.length());
						AttachPhotoBean attatchPhotoBean = new AttachPhotoBean();
						strMimeType =attatchPhotoBean.getMimeType(strFileExtension.trim());
					}
					else
					{
						strMimeType = "application/stream";
					}
				}					
				if(blobData!=null && blobData.length()>0)
				{
	                byte[] byteDocData = blobData.getBytes(1, (int) blobData.length());
					if(byteDocData!=null)
					{
						ByteArrayOutputStream baos = new ByteArrayOutputStream();
						baos.write(byteDocData);
						hshResult.put("FILE_STREAM_NAME",strFileName);					
						hshResult.put("FILE_STREAM", byteDocData);
						hshResult.put("FILE_STREAM_TYPE",strMimeType);
					}
				}
				else
				{
					hshResult.put("Message","No Document Attached to view");
				}
			}
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in NSDLApplicationBean ===> viewAttachedDocument"+e.getMessage());		
		}
		finally
		{
			try
			{
				if (statement != null)
				{
					statement.close();
				}
				if (connection != null)
				{
					connection.close();
				}
				
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection (AttachDocumentBean ==> viewAttachedDocument)"+e.getMessage());
			}
		}
		return hshResult;
	}
	
	
	private String getApplicantCode() throws Exception
	{
		String strAppCode="";		 
		ResultSet rs=null;
		try
		{ 
			rs=DBUtils.executeLAPSQuery("mastgetAppid");			 
			if(rs.next())
			{
				strAppCode=rs.getString(1);
			}
		}
		catch(final Exception e)
		{
			throw e;
		}
		finally
		{
			if(rs!=null)
			{
				rs.close();				 
			}
		}
		return strAppCode;
	}
	public HashMap getNsdlShowApplicationDetails(HashMap hshValues) 
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		ResultSet rs=null;
		String strRefNo="",StrTemp="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		try
		{
			strRefNo=Helper.correctNull((String)hshValues.get("strRefId"));
			if(strRefNo.equalsIgnoreCase(""))
				strRefNo=Helper.correctNull((String)hshValues.get("hidRefNo"));	
			
			strQuery=SQLParser.getSqlQuery("selnsdl_appdetails^"+strRefNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("CUS_APPLICANTTYPE")));
				if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("1"))
					StrTemp="Mr.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("2"))
					StrTemp="Mrs.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("3"))
					StrTemp="Ms.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("4"))
					StrTemp="Shri.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("5"))
					StrTemp="Dr.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("6"))
					StrTemp="CA.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("7"))
					StrTemp="Er.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("8"))
					StrTemp="Prof.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("9"))
					StrTemp="Smt.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("10"))
					StrTemp="Kum.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("11"))
					StrTemp="Kumari.";
				else if(Helper.correctNull(rs.getString("CUS_TITLE_CODE")).equalsIgnoreCase("12"))
					StrTemp="Master.";
				else
					StrTemp="";
				arrCol.add(StrTemp+Helper.correctNull(rs.getString("name")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_FATHERHUSBNAME")));
				arrCol.add(Helper.correctNull(rs.getString("cusdob")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ADDRESS")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ADDRESS1")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ADDRESS2")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ADDRESSCITY")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ADDRESSPIN")));
				if(Helper.correctNull(rs.getString("CUS_GENDER")).equalsIgnoreCase("M"))
					arrCol.add("Male");
				else if(Helper.correctNull(rs.getString("CUS_GENDER")).equalsIgnoreCase("F"))
					arrCol.add("Female");
				else if(Helper.correctNull(rs.getString("CUS_GENDER")).equalsIgnoreCase("T"))
						arrCol.add("Transgender");
				else
					arrCol.add(" ");
					
				if(Helper.correctNull(rs.getString("CUS_MARITALSTATUS")).equalsIgnoreCase("M"))
					arrCol.add("Married");
				else if(Helper.correctNull(rs.getString("CUS_MARITALSTATUS")).equalsIgnoreCase("D"))
					arrCol.add("Divorced");
				else if(Helper.correctNull(rs.getString("CUS_MARITALSTATUS")).equalsIgnoreCase("S"))
					arrCol.add("Single");
				else if(Helper.correctNull(rs.getString("CUS_MARITALSTATUS")).equalsIgnoreCase("W"))
					arrCol.add("Widow");
				else
					arrCol.add("Others");
				arrCol.add(Helper.correctNull(rs.getString("CUS_QUALIFICATION")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_PAN")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_AADHAAR")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_MOBILE")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_EMAIL")));
				if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("1"))
				arrCol.add("Employee");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("2"))
				arrCol.add("Business (Self employed) ");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("3"))
					arrCol.add("Professional Doctor");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("4"))
					arrCol.add("Professional CA");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("5"))
					arrCol.add("Professional Others");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("6"))
					arrCol.add("Farmer / Agriculturist");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("7"))
					arrCol.add("Student");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("8"))
					arrCol.add("Unemployed");
				else if(Helper.correctNull(rs.getString("CUS_OCCUPATION")).equalsIgnoreCase("9"))
					arrCol.add("Retired");
				else
					arrCol.add(" ");
				arrCol.add(Helper.correctNull(rs.getString("CUS_INCOMESOURCES")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_BANKNAME")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_BRANCHNAME")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_ACCOUNTNUMBER")));
				if(Helper.correctNull(rs.getString("CUS_ACCTYPE")).equalsIgnoreCase("1"))
				arrCol.add("Savings Account");
				else if(Helper.correctNull(rs.getString("CUS_ACCTYPE")).equalsIgnoreCase("2"))
					arrCol.add("Current Account");
				else if(Helper.correctNull(rs.getString("CUS_ACCTYPE")).equalsIgnoreCase("3"))
					arrCol.add("Over Draft");
				else
					arrCol.add(" ");
				arrCol.add(Helper.correctNull(rs.getString("CUS_LIABILITY")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_BRANCHCODE")));
				arrCol.add(Helper.correctNull(rs.getString("CUST_IFSCCODE")));
				arrRow.add(arrCol);
				
			}
			
			hshValues.put("arrAppRow", arrRow);
			
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_nsdlloandetails^"+strRefNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("LN_STUDENT_ID", Helper.correctNull(rs.getString("LN_STUDENT_ID")));
				hshValues.put("LN_STUD_APPID", Helper.correctNull(rs.getString("LN_STUD_APPID")));
				hshValues.put("appdate", Helper.correctNull(rs.getString("appdate")));
				hshValues.put("LN_TENURE", Helper.correctNull(rs.getString("LN_TENURE")));
				hshValues.put("LN_EMI", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("LN_EMI")))));
				hshValues.put("LN_SCHEMECODE", Helper.correctNull(rs.getString("LN_SCHEMECODE")));
				hshValues.put("LN_REMARKS", Helper.correctNull(rs.getString("LN_REMARKS")));
				hshValues.put("LN_PROJECTCOST", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("LN_PROJECTCOST")))));
				hshValues.put("LN_REQUESTEDAMT", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("LN_REQUESTEDAMT")))));
				hshValues.put("LN_ASSESSMENT_VALUE", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("LN_ASSESSMENT_VALUE")))));
				if(Helper.correctNull(rs.getString("LN_IFBANKER")).equalsIgnoreCase("Y"))
					hshValues.put("LN_IFBANKER", "Yes");
				else
					hshValues.put("LN_IFBANKER", "No");
				hshValues.put("LN_RELATION", Helper.correctNull(rs.getString("LN_RELATION")));
				hshValues.put("LN_SECURITY", Helper.correctNull(rs.getString("LN_SECURITY")));
				hshValues.put("LN_BANKCODE", Helper.correctNull(rs.getString("LN_BANKCODE")));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_coursedetails^"+strRefNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("LN_INSTITUTIONNAME", Helper.correctNull(rs.getString("LN_INSTITUTIONNAME")));
				hshValues.put("LN_COURSENAME", Helper.correctNull(rs.getString("LN_COURSENAME")));
				if(Helper.correctNull(rs.getString("LN_ADMISSIONQUOTA")).equalsIgnoreCase("M"))
				hshValues.put("LN_ADMISSIONQUOTA", "Management");
				else if(Helper.correctNull(rs.getString("LN_ADMISSIONQUOTA")).equalsIgnoreCase("G"))
					hshValues.put("LN_ADMISSIONQUOTA", "Government");
				else
					hshValues.put("LN_ADMISSIONQUOTA", "Others");
				hshValues.put("LN_DURATION", Helper.correctNull(rs.getString("LN_DURATION")));
				hshValues.put("cuscourseDOJ", Helper.correctNull(rs.getString("cuscourseDOJ")));
				hshValues.put("cuscoursecompletion", Helper.correctNull(rs.getString("cuscoursecompletion")));
			}
			
			if(rs!=null)
				rs.close();
			
			
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_courseexp^"+strRefNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_TUTIONFEE")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_EXAMFEE")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_BOOKSANDSTATIONARY")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_EQUIPMENTCOMPUTER")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_HOSTELEXPENSES")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_SUNDRIESTRAVEL")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_OWNSOURCEAMOUNT")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT")))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CAF_YR_LOANREQUIRED")))));
				arrRow.add(arrCol);
			}
			hshValues.put("arrcourseExpRow", arrRow);
			hshValues.put("strRefNo",strRefNo);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("selnsdlapp_comments^"+strRefNo);
			if(rs.next())
			{
				hshValues.put("nsdl_remarks", Helper.correctNull(rs.getString("nsdl_remarks")));
			}
		}
		catch(Exception ex)
		{			
		}
		return hshValues;		
	}
	
	public void updateNSDLApplicationstatus(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;	 
		ArrayList arrValues =null;
		ResultSet rs=null;
		String strUserId = null,strRefId="",strAction="",strAppID="",strQuery="";
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strRefId=correctNull((String)hshValues.get("hidRefNo"));
			
			{
				StringBuilder strOldAudit=new StringBuilder();

				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_nsdlremarks^"+strRefId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAudit.append("NSDL Status =").append(correctNull(rs.getString("nsdl_status")))
					.append("~Remarks= ").append(correctNull(rs.getString("nsdl_remarks")));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","updNSDLAppStatus");	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_remarks")));
				arrValues.add(strRefId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				StringBuilder sbAuditTrial1=new StringBuilder();
				sbAuditTrial1.append("~Remarks= ").append(Helper.correctNull((String)hshValues.get("txt_remarks")));

				AuditTrial.auditNewLog(hshValues,"432",strRefId,sbAuditTrial1.toString(),strOldAudit.toString());
				
				
			}
		}
		catch (Exception ce)
		{
			log.error(ce);
			throw new EJBException("Error closing connection..."+ce.toString());
		}		
	}
	
	
	public HashMap generateXMLResponseFiles(final HashMap hshRequestValues) 
	{		
		ResultSet rs = null,rs1 = null;;
		HashMap hshRecord = new HashMap();	
		Calendar calender = null;
		String strCurrDate = null,strPageFrom = null,strFileName=null,NSDL_REF_ID="",DateAsOn="",UploadStatus="",strFileUploadedStatus="";
		try
		{	DateAsOn = Helper.correctNull((String)hshRequestValues.get("DateAsOn"));
			strPageFrom = Helper.correctNull((String)hshRequestValues.get("openpage"));
			strFileName = Helper.correctNull((String)hshRequestValues.get("strFileName"));
			UploadStatus = Helper.correctNull((String)hshRequestValues.get("UploadStatus"));
//			if(strPageFrom.equalsIgnoreCase("true")){
//		    	// For open NSDL response within a pop up window
//				
//				String strFile = strFileName;
//		    	strFileName = ApplicationParams.getstrNSDLResponseFilePath()+strFileName; 		
//		    	hshRecord.put("FlatFileValues",strFileName);
//		    	hshRecord.put("strFile",strFile);
//		    }else
		    {						
			calender = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyy");
			strFileName = sdf.format(calender.getTime());
			strCurrDate = strFileName;
			
			int iSeq = 0;
			String strQuery=SQLParser.getSqlQuery("selectFileNameSeqID^"+strCurrDate);
		    rs=DBUtils.executeQuery(strQuery); 				
			if(rs.next())
			{
				iSeq = Integer.parseInt(Helper.correctInt(rs.getString("MAXID")));
			}
			iSeq = iSeq + 1;
			
			strQuery=SQLParser.getSqlQuery("select_download_response");
		    rs1=DBUtils.executeQuery(strQuery); 				
			if(rs1.next())
			{
						
				HashMap hshQueryValues = new HashMap();
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();				
				arrValues.add(Integer.toString(iSeq));
				arrValues.add(strCurrDate);		
				if(iSeq == 1){
					hshQuery.put("strQueryId","ins_NSDL_Response");
				}else{
					arrValues.add(strCurrDate);		
					hshQuery.put("strQueryId","update_NSDL_Response");
				}
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");			
							
				strFileName = Integer.toString(iSeq);
				strFileName = strFileName.length() == 1?"000"+strFileName:strFileName;
				strFileName = strFileName.length() == 2?"00"+strFileName:strFileName;
				strFileName = strFileName.length() == 3?"0"+strFileName:strFileName;
				
				strFileName = "RKARB"+strCurrDate+strFileName+".xml";
				
				File file = new File(ApplicationParams.getstrNSDLResponseFilePath());
				if(!file.exists()){
					file.mkdir();
				}
				
				XMLOutputFactory outputFactory = XMLOutputFactory.newInstance();
				XMLEventWriter eventWriter = outputFactory.createXMLEventWriter(new FileOutputStream(ApplicationParams.getstrNSDLResponseFilePath()+strFileName));			
			    XMLEventFactory eventFactory = XMLEventFactory.newInstance();
			    XMLEvent end = eventFactory.createDTD("\n");
			    StartDocument startDocument = eventFactory.createStartDocument();
			    eventWriter.add(startDocument);
			    eventWriter.add(end);
			    StartElement configStartElement = eventFactory.createStartElement("","","BankResponseDtlsAbstract");
			    eventWriter.add(configStartElement);
			    eventWriter.add(end);
			    createNode(eventWriter, "BankCode","KARB"); 
				strQuery=SQLParser.getSqlQuery("select_download_response");
			    rs=DBUtils.executeQuery(strQuery); 	
			    final String events[]={"BankResponseAbstract","StudentAppID","BankRefID","AppStatus","Remarks","DisbursedAmount","DisbursementDate"};
				while(rs.next())
				{	int i=0;				 		
				     eventWriter.add(eventFactory.createStartElement("","",events[i++]));
				     eventWriter.add(end);
				     NSDL_REF_ID = Helper.correctNull(rs.getString("NSDL_REF_ID"));
				     createNode(eventWriter, events[i++], Helper.correctNull(rs.getString("NSDL_APPID")));
				     createNode(eventWriter, events[i++], Helper.correctNull(rs.getString("NSDL_REF_ID")));
				     String AppStatus = Helper.correctNull(rs.getString("STATUS"));
				     String Remarks=Helper.correctNull(rs.getString("NSDL_REMARKS"));
				    
				     //Remarks = AppStatus.equals("02")? "InProcess" :(AppStatus.equals("03") || AppStatus.equals("05") || AppStatus.equals("08") || AppStatus.equals("04"))? rs.getString("NSDL_REMARKS")
				    		  // : AppStatus.equals("06") ? "Approved" : AppStatus.equals("07") ? "Disbursed" :Remarks;
				    
				    createNode(eventWriter, events[i++], Helper.correctNull(AppStatus));		  
					createNode(eventWriter, events[i++],Helper.correctNull(Remarks));
					
					if(AppStatus.equalsIgnoreCase("07"))
					{
						createNode(eventWriter, events[i++], Helper.correctNull(rs.getString("nsdl_disb_amt")));		  
						createNode(eventWriter, events[i++],Helper.correctNull(rs.getString("nsdl_disb_date")));
					}
					
				    eventWriter.add(eventFactory.createEndElement("", "",  events[0]));
				    eventWriter.add(end);
				    
				    hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(NSDL_REF_ID);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "upd_resfiledate");
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	
				    
				    
				 }
				eventWriter.add(eventFactory.createEndElement("", "", "BankResponseDtlsAbstract"));
			    eventWriter.add(end);
			    eventWriter.add(eventFactory.createEndDocument());
			    eventWriter.close();
				 
				if(UploadStatus.equals(""))
				{
					strFileUploadedStatus = uploadNSDLResponseFile(new File(ApplicationParams.getstrNSDLResponseFilePath()+strFileName),hshRequestValues);
				}
			    
	  	        String strResponse = "Response XML file has been Successfully downloaded. Note the response file details. "+ApplicationParams.getstrNSDLResponseFilePath()+strFileName; 
			    hshRecord.put("SuccessStatus", strResponse);
			    hshRecord.put("strFileName", strFileName);
			    hshRecord.put("strFileUploadedStatus", strFileUploadedStatus);
			}
			else
			{
				 hshRecord.put("SuccessStatus", "No Records to update");
			}
		    }
		    
		    
		}
		catch(final Exception e)
		{
			log.error("Error occurred in generateXMLResponseFiles:: " + e.getMessage());
			throw new EJBException(e);
		}
		finally
		{
			try
			{
				if(rs != null){
					rs.close();					 
				}
			}
			catch(final Exception cf){
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	private void createNode(XMLEventWriter eventWriter, String name,
		      String value) throws XMLStreamException {
		    XMLEventFactory eventFactory = XMLEventFactory.newInstance();
		    XMLEvent end = eventFactory.createDTD("\n");
		    XMLEvent tab = eventFactory.createDTD("\t");
		    // create Start node
		    StartElement sElement = eventFactory.createStartElement("", "", name);
		    eventWriter.add(tab);
		    eventWriter.add(sElement);
		    // create Content
		    Characters characters = eventFactory.createCharacters(value);
		    eventWriter.add(characters);
		    // create End node
		    EndElement eElement = eventFactory.createEndElement("", "", name);
		    eventWriter.add(eElement);
		    eventWriter.add(end);
	}
	public HashMap downloadByFileID(HashMap hshValues) 
	{
		ResultSet rs=null;		
		String strQuery="",StringRefNo="",chkBoxValue="";
		String param1="",param2="",param3="",param4="",param5="",param6="",param7="",param8="",param9="";
		HashMap hshRecord = new HashMap();
		String strFileName="", strFileIDs="", strUnzipFileLocation="", strUnzipXMLFileLocation="";
		String[] chkBoxValueSplit={};
		int chboxLen=1;
		try
		{		
			param1 = "NSDL_DOWNLOAD_FILE";	
			param8 = "NSDL_DOWNLOAD_FILE_APP";	
			param2 = Helper.correctNull((String)hshValues.get("strUserId"));			
			param3 = "";
			chkBoxValue = Helper.correctNull((String)hshValues.get("chkBoxValue"));
			strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param4 = Helper.correctNull(rs.getString("nsdl_url_info"));
				param5 = Helper.correctNull(rs.getString("nsdl_username"));
				param6 = Helper.correctNull(rs.getString("nsdl_password"));
			}
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param1);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param7 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
			}
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param8);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param9 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
			}
			
			if(chkBoxValue.equals(""))
			{
				chkBoxValue=Helper.correctNull((String)hshValues.get("fileid"));
			}
			if(!chkBoxValue.equals("")){
				chkBoxValueSplit = chkBoxValue.split(",");
				chboxLen = chkBoxValueSplit.length;
			}
		
			for(int chkBx=0;chkBx<chboxLen;chkBx++)
			{
				
				if(!chkBoxValue.equals("")){
					param3 = chkBoxValueSplit[chkBx];
				}
				
				strFileIDs = strFileIDs +","+ param3;
				
			String strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
			String charset = "UTF-8";																																		
			String query = String.format("METHOD=%s&USERID=%s&FILEID=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s&PATH=%s",						  
		    URLEncoder.encode(param1,charset),
		    URLEncoder.encode(param2,charset),
		    URLEncoder.encode(param3,charset),
		    URLEncoder.encode(param4,charset),
		    URLEncoder.encode(param5,charset),
		    URLEncoder.encode(param6,charset),
		    URLEncoder.encode(param7,charset)
		    );
			
			URLConnection connection = new URL(strURL+ "?" + query ).openConnection();
			connection.setDoOutput(true);
			connection.setRequestProperty("Accept-Charset", charset);			
			
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));	
			StringBuilder strAllString=new StringBuilder();
			String strLine="";
			while((strLine=br.readLine())!=null)
			{
				strAllString.append(strLine);
			}
			strFileName=	connection.getHeaderField("rhlFile");
			log.info("br.readLine()  :===================>\n"+br.readLine());
			if(!strFileName.equals(""))
			{
				if(!strAllString.toString().equals(""))
				{
					String strFilePath = param9;
					File unzipfile= new File(strFilePath);
					if(!unzipfile.exists()){
						unzipfile.mkdir();
		        	}
					String uploadedUNZIPFileLocation =strFilePath+strFileName;
					log.info("Base64.decode(strAllString.toString())  :===================>\n"+Base64.decode(strAllString.toString()));
					
	                InputStream is=new ByteArrayInputStream((new BASE64Decoder().decodeBuffer(strAllString.toString())));
					writeToFile(is, uploadedUNZIPFileLocation);
					hshRecord.put("NSDLFileName", strFileName);
					
					String os=System.getProperty("os.name");
					
					log.info("strFilePath  :===================>\n"+strFilePath);
					log.info("strFileName  :===================>\n"+strFileName);

					String uploadedFileLocation =strFilePath+strFileName;
					
					log.info("uploadedFileLocation 1 :===================>\n"+uploadedFileLocation);
					if(rs != null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+"NSDL_FILE_UNZIP");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strUnzipFileLocation = Helper.correctNull(rs.getString("nsdl_folder_loc"));
					}
					log.info(" UN ZIP FOLDER PATH  :===================>\n"+strUnzipFileLocation);
					log.info(" uploadedFileLocation 2 :===================>\n"+uploadedFileLocation);
					File file = new File(uploadedFileLocation);
					if(file.exists())
					{
						hshRecord.put("NSDLFileDownloaded", "Y");
						hshRecord.put("NSDLFileDownloadedLocation", strFilePath);
						
						ZipFile zipfile = new ZipFile(uploadedFileLocation);
						zipfile.extractAll(strUnzipFileLocation);
						if(rs != null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+"NSDL_XML_FILE");
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strUnzipXMLFileLocation = Helper.correctNull(rs.getString("nsdl_folder_loc"));
						}
						
						String strXml_file_name = strFileName.substring(0, strFileName.length()-4);
						File xml_file = new File(strUnzipFileLocation+strXml_file_name);
						if(xml_file.exists())
						{
							xml_file.renameTo(new File(strUnzipXMLFileLocation+xml_file.getName()));
						/*	InputStream din = new FileInputStream(xml_file);											
							InputStream inputStream=din;
							byte[] byFileName=new byte[inputStream.available()];
							int i=din.read(byFileName);
							String strFileContent=new String(byFileName);
							strFileContent=strFileContent.replace("&","");
							FileOutputStream fileOut = new FileOutputStream(strUnzipXMLFileLocation+xml_file.getName());
							fileOut.write(strFileContent.getBytes());
							fileOut.flush();
							if(fileOut!=null)fileOut.close();*/
						}
					
					}
					else
					{
						log.info("uploadedFileLocation 3:===================>\n"+uploadedFileLocation);
						hshRecord.put("NSDLFileDownloaded", "N");
					}
					
				}
			}
		  }
			
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();				
			arrValues.add(strFileIDs);	
			arrValues.add(param2);
			hshQuery.put("strQueryId","ins_downloadStatus");
			hshQuery.put("arrValues",arrValues);			
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

		}
		catch(Exception e)
		{
			e.printStackTrace();
			log.error("ERROR IN DOWNLOADBYFILEID METHOD :===================>\n"+e.toString());
			hshRecord.put("NSDLFileDownloaded", "N");
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
			catch(final Exception cf){
				throw new EJBException("Error closing the connection in downloadbyfileid"+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	private static void writeToFile(InputStream uploadedInputStream,String uploadedFileLocation) {

        try {
        	
        	InputStream din = uploadedInputStream;											
			InputStream inputStream=din;
			byte[] byFileName=new byte[inputStream.available()];
			int i=din.read(byFileName);
			
        	FileOutputStream fileOut = new FileOutputStream(new File(uploadedFileLocation));
			fileOut.write(byFileName);
			fileOut.close();
             /*  OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
               int read = 0;
              byte[] bytes = new byte[uploadedInputStream.available()];
               out = new FileOutputStream(new File(uploadedFileLocation));
               while ((read = uploadedInputStream.read(bytes)) != -1) {
                     out.write(bytes, 0, read);
               }
               out.flush();
               out.close();*/
        } catch (IOException e) {

               e.printStackTrace();
        }

 }
	
	public String uploadNSDLResponse(MultipartFormDataRequest mrequest) 
	{
		ResultSet rs=null;		
		String strQuery="",StringRefNo="";
		String param1="",param2="", param3="",param4="",param5="";
		String strFileName="", strResponseFile="", strResponseFileID="", strResponseStatus="", strFileUploadedStatus="";
		try
		{		
			param1 = "NSDL_RESPONSE_UPLOAD";
			
			strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param2 = Helper.correctNull(rs.getString("nsdl_url_info"));
				param3 = Helper.correctNull(rs.getString("nsdl_username"));
				param4 = Helper.correctNull(rs.getString("nsdl_password"));
			}
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param1);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param5 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
			}
			
			if (mrequest != null)
			{
				Hashtable files = mrequest.getFiles();
				UploadFile file = (UploadFile) files.get("fileNsdl");
				strFileName = Helper.correctNull((String) file.getFileName());
			}
			
			String strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
			String charset = "UTF-8";																																		
			String query = String.format("METHOD=%s&FILENAME=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s&PATH=%s",						  
		    URLEncoder.encode(param1,charset),
		    URLEncoder.encode(strFileName,charset),
		    URLEncoder.encode(param2,charset),
		    URLEncoder.encode(param3,charset),
		    URLEncoder.encode(param4,charset),
		    URLEncoder.encode(param5,charset)
		    );
			
			String boundaryString = "----SomeRandomText";
			String filePath=ApplicationParams.getstrNSDLResponseFilePath()+strFileName;
			File fileToUpload = new File(filePath);
			URL url = new URL(strURL+ "?" + query ); 
			HttpURLConnection connection =(HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setRequestProperty("Accept-Charset", charset);	
			connection.setRequestMethod("POST");
			connection.addRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundaryString);
			
			OutputStream outputStreamToRequestBody = connection.getOutputStream();
			BufferedWriter httpsRequestBodyWriter = new BufferedWriter(new OutputStreamWriter(outputStreamToRequestBody));
			
			//httpsRequestBodyWriter.write("\n\n--" + boundaryString + "\n");
			//httpsRequestBodyWriter.write("Content-Disposition: form-data; name=\"fileDescription\"");
			//httpsRequestBodyWriter.write("\n\n");
			//httpsRequestBodyWriter.write("Response file for "+ new java.util.Date());
			
		//	httpsRequestBodyWriter.write("\n--" + boundaryString + "\n");
			//httpsRequestBodyWriter.write("Content-Disposition: form-data;" 
										//+ "name=\"file\";"
										//+ "filename=\""+ fileToUpload.getName() +"\""
										//+ "\nContent-Type: text/plain\n\n");
			//httpsRequestBodyWriter.flush();
			
			FileInputStream inputStreamToFile = new FileInputStream(fileToUpload);
			int bytesRead;
			byte[] dataBuffer = new byte[inputStreamToFile.available()];
			while((bytesRead = inputStreamToFile.read(dataBuffer)) != -1) {
			    outputStreamToRequestBody.write(dataBuffer, 0, bytesRead);
			}
			outputStreamToRequestBody.flush();
			
			//httpsRequestBodyWriter.write("\n--" + boundaryString + "--\n");
			httpsRequestBodyWriter.flush();
						 
			outputStreamToRequestBody.close();
			inputStreamToFile.close();
			httpsRequestBodyWriter.close();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));	
			
			while((strResponseFile = br.readLine()) != null)
			{
				if(!strResponseFile.equalsIgnoreCase(""))
				{
					if(!strResponseFile.contains("already"))
					{
						strResponseFileID = strResponseFile;
						param1 = "CHECK_UPLOAD_STATUS";
						
						strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							param2 = Helper.correctNull(rs.getString("nsdl_url_info"));
							param3 = Helper.correctNull(rs.getString("nsdl_username"));
							param4 = Helper.correctNull(rs.getString("nsdl_password"));
						}
						
						if(rs != null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param1);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							param5 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
						}
						
						strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
						charset = "UTF-8";																																		
						query = String.format("METHOD=%s&FILEID=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s&PATH=%s",						  
					    URLEncoder.encode(param1,charset),
					    URLEncoder.encode(strResponseFileID,charset),
					    URLEncoder.encode(param2,charset),
					    URLEncoder.encode(param3,charset),
					    URLEncoder.encode(param4,charset),
					    URLEncoder.encode(param5,charset)
					    );
						
						URLConnection connection_1 = new URL(strURL+ "?" + query ).openConnection();
						connection_1.setDoOutput(true);
						connection_1.setRequestProperty("Accept-Charset", charset);			
						br = new BufferedReader(new InputStreamReader(connection_1.getInputStream()));
						
						while((strResponseStatus = br.readLine()) != null)
						{
							System.out.println(strResponseStatus);
							
							if(strResponseStatus.equalsIgnoreCase("File Uploaded"))
							{
								strFileUploadedStatus = "File Uploaded Successfully";
							}
							else{
								strFileUploadedStatus = "Error occured. Please see the error log in "+param5;
							}
						}
					}
					else
					{
						strFileUploadedStatus = strResponseFile;
					}
				}
			}
		}
		catch(Exception e)
		{
			log.error("ERROR IN UPLOADNSDLRESPONSE METHOD :===================>\n"+e.toString());
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
			catch(final Exception cf){
				throw new EJBException("Error closing the connection in uploadNSDLResponse"+cf.getMessage());						
			}
		}
		return strFileUploadedStatus;
	}
	public HashMap downloadRequestFiles(HashMap hshValues) 
	{
		ResultSet rs=null;		
		String strQuery="",StringRefNo="";
		String param1="",param2="", param3="",param4="",param5="";
		HashMap hshRecord = new HashMap();
		String strNSDLFileIds="",strID="";
		try
		{		
			param1 = "NSDL_DOWNLOAD";			
			param2 = Helper.correctNull((String)hshValues.get("strUserId"));
			
			strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				param3 = Helper.correctNull(rs.getString("nsdl_url_info"));
				param4 = Helper.correctNull(rs.getString("nsdl_username"));
				param5 = Helper.correctNull(rs.getString("nsdl_password"));
			}
			
			String strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
			String charset = "UTF-8";																																		
			String query = String.format("METHOD=%s&USERID=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s",						  
		    URLEncoder.encode(param1,charset),
		    URLEncoder.encode(param2,charset),
		    URLEncoder.encode(param3,charset),
		    URLEncoder.encode(param4,charset),
		    URLEncoder.encode(param5,charset)
		    );
			
			URLConnection connection = new URL(strURL+ "?" + query ).openConnection();
			connection.setDoOutput(true);
			connection.setRequestProperty("Accept-Charset", charset);			
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));	
		
			while((strNSDLFileIds = br.readLine()) != null)
				{
					if(strNSDLFileIds.length() > 0)
					{
						hshRecord.put("NSDLFileIds", strNSDLFileIds);
						strID=strNSDLFileIds;
					}
				}
			
			if(Helper.correctNull((String)hshValues.get("strSchedularFlag")).equalsIgnoreCase("Y"))
			{
				if(strID!=null && strID.length()>2)
					strID=strID.substring(1, strID.length()-1);
				hshRecord.put("fileid", strID.replaceAll("\"", ""));
				downloadByFileID(hshRecord);
			}
			
		
		}
		catch(Exception e)
		{
			log.error("ERROR IN DOWNLOADREQUESTFILES METHOD :===================>\n"+e.toString());
			throw new EJBException("ERROR IN DOWNLOADREQUESTFILES METHOD :===================>\n"+e.toString());
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
			catch(final Exception cf){
				throw new EJBException("Error closing the connection in downloadRequestFiles"+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	private String uploadNSDLResponseFile(File files,HashMap hshRequestValues)
	{
	ResultSet rs=null;		
	String strQuery="",StringRefNo="";
	String param1="",param2="", param3="",param4="",param5="";
	String strFileName="", strResponseFile="", strResponseFileID="", strResponseStatus="", strFileUploadedStatus="";
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strRefid="";
	try
	{	
		strFileName = Helper.correctNull((String) files.getName());
		param1 = "NSDL_RESPONSE_UPLOAD";
		
		strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			param2 = Helper.correctNull(rs.getString("nsdl_url_info"));
			param3 = Helper.correctNull(rs.getString("nsdl_username"));
			param4 = Helper.correctNull(rs.getString("nsdl_password"));
		}
		
		if(rs != null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param1);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			param5 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
		}
	
		String strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
		String charset = "UTF-8";																																		
		String query = String.format("METHOD=%s&FILENAME=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s&PATH=%s",						  
	    URLEncoder.encode(param1,charset),
	    URLEncoder.encode(strFileName,charset),
	    URLEncoder.encode(param2,charset),
	    URLEncoder.encode(param3,charset),
	    URLEncoder.encode(param4,charset),
	    URLEncoder.encode(param5,charset)
	    );
		String boundaryString = "----SomeRandomText";
		String filePath=ApplicationParams.getstrNSDLResponseFilePath()+strFileName;
		File fileToUpload = new File(filePath);
		URL url = new URL(strURL+ "?" + query );
		HttpURLConnection connection =(HttpURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setRequestProperty("Accept-Charset", charset);	
		connection.setRequestMethod("POST");
		connection.addRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundaryString);
		
		OutputStream outputStreamToRequestBody = connection.getOutputStream();
		BufferedWriter httpsRequestBodyWriter = new BufferedWriter(new OutputStreamWriter(outputStreamToRequestBody));
		
		//httpsRequestBodyWriter.write("\n\n--" + boundaryString + "\n");
		//httpsRequestBodyWriter.write("Content-Disposition: form-data; name=\"fileDescription\"");
		//httpsRequestBodyWriter.write("\n\n");
		//httpsRequestBodyWriter.write("Response file for "+ new java.util.Date());
		
		//httpsRequestBodyWriter.write("\n--" + boundaryString + "\n");
		//httpsRequestBodyWriter.write("Content-Disposition: form-data;" 
									/*+ "name=\"file\";"
									+ "filename=\""+ fileToUpload.getName() +"\""
									+ "\nContent-Type: text/plain\n\n");*/
		//httpsRequestBodyWriter.flush();
		
		FileInputStream inputStreamToFile = new FileInputStream(fileToUpload);
		int bytesRead;
		byte[] dataBuffer = new byte[inputStreamToFile.available()];
		while((bytesRead = inputStreamToFile.read(dataBuffer)) != -1) {
		    outputStreamToRequestBody.write(dataBuffer, 0, bytesRead);
		}
		outputStreamToRequestBody.flush();
		
		//httpsRequestBodyWriter.write("\n--" + boundaryString + "--\n");
		//httpsRequestBodyWriter.flush();
					 
		outputStreamToRequestBody.close();
		inputStreamToFile.close();
		//httpsRequestBodyWriter.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));	
		
		while((strResponseFile = br.readLine()) != null)
		{
			if(!strResponseFile.equalsIgnoreCase(""))
			{
				if(!strResponseFile.contains("already"))
				{
					strResponseFileID = strResponseFile;
					param1 = "CHECK_UPLOAD_STATUS";
					
					strQuery = SQLParser.getSqlQuery("getNSDLParameters^"+param1);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						param2 = Helper.correctNull(rs.getString("nsdl_url_info"));
						param3 = Helper.correctNull(rs.getString("nsdl_username"));
						param4 = Helper.correctNull(rs.getString("nsdl_password"));
					}
					
					if(rs != null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("getNSDLFolder^"+param1);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						param5 = Helper.correctNull(rs.getString("nsdl_folder_loc"));
					}
					
					strURL = "http://"+ApplicationParams.getStrNsdlConnector()+"/lapsservices/controllerservlet";
					charset = "UTF-8";																																		
					query = String.format("METHOD=%s&FILEID=%s&URLINFO=%s&LOGINUSER=%s&PASSWORD=%s&PATH=%s",						  
				    URLEncoder.encode(param1,charset),
				    URLEncoder.encode(strResponseFileID,charset),
				    URLEncoder.encode(param2,charset),
				    URLEncoder.encode(param3,charset),
				    URLEncoder.encode(param4,charset),
				    URLEncoder.encode(param5,charset)
				    );
					
					URLConnection connection_1 = new URL(strURL+ "?" + query ).openConnection();
					connection_1.setDoOutput(true);
					connection_1.setRequestProperty("Accept-Charset", charset);			
					br = new BufferedReader(new InputStreamReader(connection_1.getInputStream()));
					
					while((strResponseStatus = br.readLine()) != null)
					{
						System.out.println(strResponseStatus);
						
						if(strResponseStatus.equalsIgnoreCase("File Uploaded"))
						{
							strFileUploadedStatus = "File Uploaded Successfully";
							
						}
						else{
							strFileUploadedStatus = "Error occured. Please see the error log in "+param5;
						}
					}
				}
				else
				{
					strFileUploadedStatus = "Error.";
				}
			}
		}
		//strResponseFile=strResponseFile;
		System.out.println(strResponseFile);
	}
	catch(Exception e)
	{
		log.error("ERROR IN UPLOADNSDLRESPONSE METHOD :===================>\n"+e.toString());
	}
	return strFileUploadedStatus;
	}
 
}//Bean End
