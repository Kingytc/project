package com.sai.laps.ejb.attachphoto;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.Key;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.ejb.EJBException;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;



import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;

//import com.sai.fw.business.entities.User;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.bulkexcel.upload.ExceluploadSHGBean;
import com.sai.laps.ejb.commdocument.CommDocumentBean;

public class AttachPhotoBean
{
	static Logger log=Logger.getLogger(AttachPhotoBean.class);
	public String attachPhoto(MultipartFormDataRequest mrequest)
	{
		String strAttachSuccess = "";
		boolean retval = false;
		boolean doc_scan = false;
		boolean pdfdoc = false;
		
		HashMap hshValues=new HashMap();
		try
		{
			
			String strApplicationNo = FwHelper.correctNull((String) mrequest.getParameter("hidApplicantionNo"));
			String strDocumentCode = FwHelper.correctNull((String) mrequest.getParameter("hidDocumentCode"));
			String hidType = FwHelper.correctNull((String) mrequest.getParameter("hidType"));
			
			if (mrequest != null)
			{
				long lngApplicantId = FwHelper.parseLong((String) mrequest.getParameter("hidApplicantId"));
				Hashtable files = mrequest.getFiles();
				if ((files != null) || (!files.isEmpty()))
				{
					UploadFile file = (UploadFile) files.get("filePhoto");
					String strFileName = "";					
					strFileName = Helper.correctNull((String) file.getFileName());
					
					if (!strFileName.trim().equalsIgnoreCase(""))
					{
						if(hidType.equalsIgnoreCase("photo"))
						{
							MastApplicantBean mastApplicantBean = new MastApplicantBean();
							InputStream din = file.getInpuStream();
							byte[] byFileName = new byte[din.available()];
							int i = din.read(byFileName);
							hshValues.put("byteimg",byFileName);
							hshValues.put("filename",strFileName);
							hshValues.put("appscan_appno",strApplicationNo);
							hshValues.put("doc_code",strDocumentCode);
							hshValues.put("lngApplicantId",Long.toString(lngApplicantId));
							
							retval=mastApplicantBean.updateDemographicsApplicantPhoto(hshValues);
						}
						if(hidType.equalsIgnoreCase("document"))
						{
							CommDocumentBean CommDocumentBean = new CommDocumentBean();
							InputStream din = file.getInpuStream();
							byte[] byFileName = new byte[din.available()];
							int i = din.read(byFileName);
							hshValues.put("byteimg",byFileName);
							hshValues.put("filename",strFileName);
							hshValues.put("appscan_appno",strApplicationNo);
							hshValues.put("doc_code",strDocumentCode);
							hshValues.put("lngApplicantId",Long.toString(lngApplicantId));
							
							doc_scan=CommDocumentBean.updateAttachedDocument(hshValues);
						}
						if(hidType.equalsIgnoreCase("pdfdocument"))
						{
							CommDocumentBean CommDocumentBean = new CommDocumentBean();
							InputStream din = file.getInpuStream();
							byte[] byFileName = new byte[din.available()];
							int i = din.read(byFileName);
							hshValues.put("byteimg",byFileName);
							hshValues.put("filename",strFileName);
							hshValues.put("appscan_appno",strApplicationNo);
							hshValues.put("doc_code",strDocumentCode);
							hshValues.put("lngApplicantId",Long.toString(lngApplicantId));
							
							pdfdoc=CommDocumentBean.updateAttachedPdfDocument(hshValues);
						}
					}
				}
			}
		
			if(hidType.equalsIgnoreCase("photo"))
			{
				if(retval)
					strAttachSuccess="success";
				else
					strAttachSuccess="failed";
			}
			
			if(hidType.equalsIgnoreCase("document"))
			{
				if(doc_scan)
					strAttachSuccess="success";
				else
					strAttachSuccess="failed";
			}
			if(hidType.equalsIgnoreCase("pdfdocument"))
			{
				if(pdfdoc)
					strAttachSuccess="success";
				else
					strAttachSuccess="failed";
			}
			
		}
		catch (Exception e)
		{
			log.error(" Exception in Attaching Image " + e.toString());

		}
		return strAttachSuccess;
	}

	
	
	public HttpServletResponse getAttatchedPhoto(HttpServletResponse response,
			byte[] perapplicantVO)
	{
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try
		{
				byte docBytes[] = (byte[]) perapplicantVO;
				baos.write(docBytes);
				baos.writeTo(response.getOutputStream());
				baos.close();
		}
		catch (Exception e)
		{
			log.error(" Exception in Attaching Image " + e.toString());
		}

		return response;
	}

	public String getMimeType(String format)
	{
		if (format.equalsIgnoreCase("a")) 
			return "text/a";
		else if (format.equalsIgnoreCase("abs"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("ai"))
			return "application/postscript";
		else if (format.equalsIgnoreCase("aif"))
			return "audio/x-aiff";
		else if (format.equalsIgnoreCase("aifc"))
			return "audio/x-aiff";
		else if (format.equalsIgnoreCase("aiff"))
			return "audio/x-aiff";
		else if (format.equalsIgnoreCase("aim"))
			return "application/x-aim";
		else if (format.equalsIgnoreCase("art"))
			return "image/x-jg";
		else if (format.equalsIgnoreCase("asf"))
			return "video/x-ms-asf";
		else if (format.equalsIgnoreCase("asx"))
			return "video/x-ms-asf";
		else if (format.equalsIgnoreCase("au"))
			return "audio/basic";
		else if (format.equalsIgnoreCase("avi"))
			return "video/x-msvideo";
		else if (format.equalsIgnoreCase("avx"))
			return "video/x-rad-screenplay";
		else if (format.equalsIgnoreCase("bcpio"))
			return "application/x-bcpio";
		else if (format.equalsIgnoreCase("bin"))
			return "application/octet-stream";
		else if (format.equalsIgnoreCase("bmp"))
			return "image/bmp";
		else if (format.equalsIgnoreCase("body"))
			return "text/html";
		else if (format.equalsIgnoreCase("cdf"))
			return "application/x-cdf";
		else if (format.equalsIgnoreCase("cer"))
			return "application/x-x509-ca-cert";
		else if (format.equalsIgnoreCase("class"))
			return "application/java";
		else if (format.equalsIgnoreCase("cpio"))
			return "application/x-cpio";
		else if (format.equalsIgnoreCase("csh"))
			return "application/x-csh";
		else if (format.equalsIgnoreCase("css"))
			return "text/css";
		else if (format.equalsIgnoreCase("dib"))
			return "image/bmp";
		else if (format.equalsIgnoreCase("doc"))
			return "application/msword";
		else if (format.equalsIgnoreCase("docx"))
			return "application/msword";
		else if (format.equalsIgnoreCase("dtd"))
			return "text/plain";
		else if (format.equalsIgnoreCase("dv"))
			return "video/x-dv";
		else if (format.equalsIgnoreCase("dvi"))
			return "application/x-dvi";
		else if (format.equalsIgnoreCase("eps"))
			return "application/postscript";
		else if (format.equalsIgnoreCase("etx"))
			return "text/x-setext";
		else if (format.equalsIgnoreCase("exe"))
			return "application/octet-stream";
		else if (format.equalsIgnoreCase("gif"))
			return "image/gif";
		else if (format.equalsIgnoreCase("gtar"))
			return "application/x-gtar";
		else if (format.equalsIgnoreCase("gz"))
			return "application/x-gzip";
		else if (format.equalsIgnoreCase("hdf"))
			return "application/x-hdf";
		else if (format.equalsIgnoreCase("hqx"))
			return "application/mac-binhex40";
		else if (format.equalsIgnoreCase("htc"))
			return "text/x-component";
		else if (format.equalsIgnoreCase("htm"))
			return "text/html";
		else if (format.equalsIgnoreCase("html"))
			return "text/html";
		else if (format.equalsIgnoreCase("hqx"))
			return "application/mac-binhex40";
		else if (format.equalsIgnoreCase("ief"))
			return "image/ief";
		else if (format.equalsIgnoreCase("image_gif"))
			return "image/gif";
		else if (format.equalsIgnoreCase("image_jpeg"))
			return "image/jpeg";
		else if (format.equalsIgnoreCase("image_bmp"))
			return "image/bmp";
		else if (format.equalsIgnoreCase("image_x-png"))
			return "image/x-png";
		else if (format.equalsIgnoreCase("jad"))
			return "text/vnd.sun.j2me.app-descriptor";
		else if (format.equalsIgnoreCase("jar"))
			return "application/java-archive";
		else if (format.equalsIgnoreCase("java"))
			return "text/plain";
		else if (format.equalsIgnoreCase("jnlp"))
			return "application/x-java-jnlp-file";
		else if (format.equalsIgnoreCase("jpe"))
			return "image/jpeg";
		else if (format.equalsIgnoreCase("jpeg"))
			return "image/jpeg";
		else if (format.equalsIgnoreCase("jpg"))
			return "image/jpeg";
		else if (format.equalsIgnoreCase("js"))
			return "text/javascript";
		else if (format.equalsIgnoreCase("jsf"))
			return "text/plain";
		else if (format.equalsIgnoreCase("jspf"))
			return "text/plain";
		else if (format.equalsIgnoreCase("kar"))
			return "audio/x-midi";
		else if (format.equalsIgnoreCase("latex"))
			return "application/x-latex";
		else if (format.equalsIgnoreCase("m3u"))
			return "audio/x-mpegurl";
		else if (format.equalsIgnoreCase("mac"))
			return "image/x-macpaint";
		else if (format.equalsIgnoreCase("man"))
			return "application/x-troff-man";
		else if (format.equalsIgnoreCase("me"))
			return "application/x-troff-me";
		else if (format.equalsIgnoreCase("mid"))
			return "audio/x-midi";
		else if (format.equalsIgnoreCase("midi"))
			return "audio/x-midi";
		else if (format.equalsIgnoreCase("mif"))
			return "application/x-mif";
		else if (format.equalsIgnoreCase("mov"))
			return "video/quicktime";
		else if (format.equalsIgnoreCase("movie"))
			return "video/x-sgi-movie";
		else if (format.equalsIgnoreCase("mp1"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("mp2"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("mp3"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("mpa"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("mpe"))
			return "video/mpeg";
		else if (format.equalsIgnoreCase("mpeg"))
			return "video/mpeg";
		else if (format.equalsIgnoreCase("mpega"))
			return "audio/x-mpeg";
		else if (format.equalsIgnoreCase("mpg"))
			return "video/mpeg";
		else if (format.equalsIgnoreCase("mpv2"))
			return "video/mpeg2";
		else if (format.equalsIgnoreCase("ms"))
			return "application/x-wais-source";
		else if (format.equalsIgnoreCase("msdownload"))
			return "application/x-msdownload";
		else if (format.equalsIgnoreCase("nc"))
			return "application/x-netcdf";
		else if (format.equalsIgnoreCase("oda"))
			return "application/oda";
		else if (format.equalsIgnoreCase("pbm"))
			return "image/x-portable-bitmap";
		else if (format.equalsIgnoreCase("pct"))
			return "image/pict";
		else if (format.equalsIgnoreCase("pdf"))
			return "application/pdf";
		else if (format.equalsIgnoreCase("pgm"))
			return "image/x-portable-graymap";
		else if (format.equalsIgnoreCase("pic"))
			return "image/pict";
		else if (format.equalsIgnoreCase("pict"))
			return "image/pict";
		else if (format.equalsIgnoreCase("pls"))
			return "audio/x-scpls";
		else if (format.equalsIgnoreCase("png"))
			return "image/png";
		else if (format.equalsIgnoreCase("pnm"))
			return "image/x-portable-anymap";
		else if (format.equalsIgnoreCase("pnt"))
			return "image/x-macpaint";
		else if (format.equalsIgnoreCase("ppm"))
			return "image/x-portable-pixmap";
		else if (format.equalsIgnoreCase("ppt"))
			return "application/x-msdownload";
		else if (format.equalsIgnoreCase("pptx"))
			return "application/x-msdownload";
		else if (format.equalsIgnoreCase("ps"))
			return "application/postscript";
		else if (format.equalsIgnoreCase("psd"))
			return "image/x-photoshop";
		else if (format.equalsIgnoreCase("qt"))
			return "video/quicktime";
		else if (format.equalsIgnoreCase("qti"))
			return "image/x-quicktime";
		else if (format.equalsIgnoreCase("qtif"))
			return "image/x-quicktime";
		else if (format.equalsIgnoreCase("ras"))
			return "image/x-cmu-raster";
		else if (format.equalsIgnoreCase("rgb"))
			return "image/x-rgb";
		else if (format.equalsIgnoreCase("rm"))
			return "application/vnd.rn-realmedia";
		else if (format.equalsIgnoreCase("roff"))
			return "application/x-troff";
		else if (format.equalsIgnoreCase("rtf"))
			return "application/rtf";
		else if (format.equalsIgnoreCase("rtx"))
			return "text/richtext";
		else if (format.equalsIgnoreCase("sh"))
			return "application/x-sh";
		else if (format.equalsIgnoreCase("shar"))
			return "application/x-shar";
		else if (format.equalsIgnoreCase("smf"))
			return "audio/x-midi";
		else if (format.equalsIgnoreCase("sit"))
			return "application/x-stuffit";
		else if (format.equalsIgnoreCase("snd"))
			return "audio/basic";
		else if (format.equalsIgnoreCase("src"))
			return "application/x-wais-source";
		else if (format.equalsIgnoreCase("sv4cpio"))
			return "application/x-sv4cpio";
		else if (format.equalsIgnoreCase("sv4crc"))
			return "application/x-sv4crc";
		else if (format.equalsIgnoreCase("swf"))
			return "application/x-shockwave-flash";
		else if (format.equalsIgnoreCase("t"))
			return "application/x-troff";
		else if (format.equalsIgnoreCase("tar"))
			return "application/x-tar";
		else if (format.equalsIgnoreCase("tcl"))
			return "application/x-tcl";
		else if (format.equalsIgnoreCase("tex"))
			return "application/x-tex";
		else if (format.equalsIgnoreCase("texi"))
			return "application/x-texinfo";
		else if (format.equalsIgnoreCase("texinfo"))
			return "application/x-texinfo";
		else if (format.equalsIgnoreCase("tif"))
			return "image/tiff";
		else if (format.equalsIgnoreCase("tiff"))
			return "image/tiff";
		else if (format.equalsIgnoreCase("tr"))
			return "application/x-troff";
		else if (format.equalsIgnoreCase("tsv"))
			return "text/tab-separated-values";
		else if (format.equalsIgnoreCase("txt"))
			return "text/plain";
		else if (format.equalsIgnoreCase("ucc"))
			return "text/ucc";
		else if (format.equalsIgnoreCase("ulw"))
			return "audio/basic";
		else if (format.equalsIgnoreCase("ustar"))
			return "application/x-ustar";
		else if (format.equalsIgnoreCase("xbm"))
			return "image/x-xbitmap";
		else if (format.equalsIgnoreCase("xls"))
			return "application/vnd.ms-excel";
		else if (format.equalsIgnoreCase("xlsx"))
			return "application/vnd.ms-excel";
		else if (format.equalsIgnoreCase("xml"))
			return "text/xml";
		else if (format.equalsIgnoreCase("xpm"))
			return "image/x-xpixmap";
		else if (format.equalsIgnoreCase("xsl"))
			return "text/xml";
		else if (format.equalsIgnoreCase("xwd"))
			return "image/x-xwindowdump";
		else if (format.equalsIgnoreCase("wav"))
			return "audio/x-wav";
		else if (format.equalsIgnoreCase("svg"))
			return "image/svg+xml";
		else if (format.equalsIgnoreCase("svgz"))
			return "image/svg+xml";
		else if (format.equalsIgnoreCase("wbmp"))
			return "image/vnd.wap.wbmp";
		else if (format.equalsIgnoreCase("wml"))
			return "text/vnd.wap.wml";
		else if (format.equalsIgnoreCase("wmlc"))
			return "application/vnd.wap.wmlc";
		else if (format.equalsIgnoreCase("wmls"))
			return "text/vnd.wap.wmlscript";
		else if (format.equalsIgnoreCase("wmlscriptc"))
			return "application/vnd.wap.wmlscriptc";
		else if (format.equalsIgnoreCase("wrl"))
			return "x-world/x-vrml";
		else if (format.equalsIgnoreCase("Z"))
			return "application/x-compress";
		else if (format.equalsIgnoreCase("z"))
			return "application/x-compress";
		else if (format.equalsIgnoreCase("zip"))
			return "application/zip";
		else
			return "application/stream";
	}
	public HashMap uploadAttachment(MultipartFormDataRequest mrequest,String strDocType,String strDocCode,String strAppNo,String strUserID,String strCBSID,String strfacslno,String strCategory)
	{		
		boolean retval = false,bstate = false;
		HashMap hshValues=new HashMap();
		HashMap hshResult = new HashMap();
		String filePath="";
		String strFileName = "",str_Content="";	
		int intSize = 0;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String str_FileDirectory ="";
		
		byte[] bytePhoto 	= new byte[200000];
		String strZipFilePath = "",strAttachSuccess="";
		ResultSet rs=null;
		try
		{			
			try
			{
				
				String strOrgSCode="";
				rs=DBUtils.executeLAPSQuery("sel_apporg_scode^"+strAppNo);
				if(rs.next())
				{
					strOrgSCode = Helper.correctNull((String)rs.getString("ORG_SCODE"));				
				}else{
					rs=DBUtils.executeLAPSQuery("sel_msmedetails^"+strAppNo);
					if(rs.next())
					{
						strOrgSCode = Helper.correctNull((String)rs.getString("MSME_ORGSCODE"));
						strCBSID=Helper.correctNull((String)rs.getString("MSME_CBSID"));
					}
				}
				
				if(!strCBSID.equalsIgnoreCase(""))
					str_FileDirectory=ApplicationParams.getStrdoclocation()+"/"+strOrgSCode+"/"+strCBSID+"/"+strAppNo;
				else
					str_FileDirectory=ApplicationParams.getStrdoclocation()+"/"+strOrgSCode+"/"+strAppNo;
				
				log.info("Document Location===="+str_FileDirectory);
				if (mrequest != null)
				{
					Hashtable files = mrequest.getFiles();
					if ((files != null) || (!files.isEmpty()))
					{
						UploadFile file = (UploadFile) files.get("fileAttach");						
						strFileName = Helper.correctNull((String) file.getFileName());
						if (!strFileName.trim().equalsIgnoreCase(""))
						{
							 String strExt=strFileName.substring(0,strFileName.indexOf("."));
							 File resultfile			= new File(str_FileDirectory);
							 if(!resultfile.exists())
							 {
								 resultfile.mkdirs();
							 }
							 
							 InputStream din = file.getInpuStream();
							 byte[] byFileName = new byte[din.available()];
							 int i = din.read(byFileName);
							 String strArray[] = null;
							 bytePhoto	= (byte[])byFileName;
							 int intActualSize=0;
							 if(rs!=null)
								 rs.close();
							 
							 if(strCategory.equalsIgnoreCase("dev"))
								 rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^P001");
							 else
								 rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^107");
							 if(rs.next())
							 {
								 intActualSize=Integer.parseInt(Helper.correctInt(rs.getString("LOAN_PARAMVAL")));	
							 }
							 long intsize= file.getFileSize();
							 if(intsize>(intActualSize*1024))
							 {
								 	log.info("File Size More than "+intActualSize+" KB cannot be attached..");
									hshValues.put("strAttach","Failed : File Size More than "+intActualSize+" KB cannot be attached..");
									return hshValues;
							 }
								
							 strZipFilePath			= strExt+".zip";
							 
							long filelength;
							filelength=bytePhoto.length;
			
							if(filelength>0)
							{
								//resultfile.createNewFile();
								FileOutputStream fileout				= new FileOutputStream(str_FileDirectory+"/"+strZipFilePath);
								final ZipOutputStream zipOutputStream 	= new ZipOutputStream(fileout);
								
								//Compression
								ZipEntry zipEntry = new ZipEntry(strFileName);
								zipOutputStream.putNextEntry(zipEntry);
								
								/*Encryption*/
								
								//generating key
								byte secretKey[] 	= "KarnatakaBaKLAPS".getBytes();
								Key secretKeySpec 	= new SecretKeySpec(secretKey, "AES");

								//creating and initialising cipher and cipher streams
								Cipher encrypt 	= Cipher.getInstance("AES");
								encrypt.init(Cipher.ENCRYPT_MODE, secretKeySpec);
								
								//Encrypt or Decrypt data based on Cipher Initialization
								bytePhoto = encrypt.doFinal(bytePhoto);
								
//								Deflater df=new Deflater();
//								df.setLevel(Deflater.BEST_COMPRESSION);
//								df.setInput(bytePhoto);
//								df.finish();
//								
//								byte[] tmp=new byte[4*1024];
//								while(!df.finished())
//								{
//									int size=df.deflate(tmp);
//									zipOutputStream.write(tmp,0,size);
//								}
								
								//Write Encrypted bytes into FileStream
								zipOutputStream.write(bytePhoto);
								
								zipOutputStream.flush();
								zipOutputStream.closeEntry();
								zipOutputStream.close();
								fileout.close();
								strAttachSuccess = "S";
								log.info(strFileName+"Document Successfully Written in the Location ===="+str_FileDirectory);
								String strQuery="";
								if(strCategory.equals("CORP") || strCategory.equals("AGR"))
								{
									  strQuery=SQLParser.getSqlQuery("select_app_docattach_checker_fac^"+strAppNo+"^"+strDocType+"^"+strDocCode+"^"+strFileName+"^"+strfacslno);										
								}
								else
								{
									  strQuery=SQLParser.getSqlQuery("select_app_docattach_checker^"+strAppNo+"^"+strDocType+"^"+strDocCode+"^"+strFileName);										
								}
								rs=DBUtils.executeQuery(strQuery);
								bstate = rs.next();
								rs.close();
								
								if(bstate == false){
									String strSno = getMaxSno(strAppNo,strDocType,strDocCode); 				
									intSize ++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();				
									arrValues.add(strAppNo);
									arrValues.add(strDocType);
									arrValues.add(strDocCode);
									arrValues.add(strSno);
									arrValues.add(strFileName);
									arrValues.add(strUserID);	
									arrValues.add(strfacslno);			
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strQueryId","insert_app_docattach");
									hshQueryValues.put(Integer.toString(intSize),hshQuery);
									hshQueryValues.put("size",String.valueOf(intSize));
								 	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
								}
							}
						}
						else
						 {
							 strAttachSuccess = "F";
						 }
					}
					retval=true;
				}
				else
				{
					
				}
			if(strCategory.equalsIgnoreCase("MsmeDoc")){
				hshValues.put("strpageName",strCategory);
			}
			}
			catch(Exception e)
			{
				retval = false;
				log.error(" Exception in Attaching Image " + e.toString());
			}
			if(retval)
				hshValues.put("strAttach","Success");
			else
				hshValues.put("strAttach","Fail");
			
		}
		catch (Exception e)
		{
			log.error(" Exception in AttachDoc " + e.toString());
		}
		return hshValues;
	}
	private String getMaxSno(String strAppno,String strDocType,String strDocCode) throws Exception
	{		
		String strSno = "";
		ResultSet rs=null;
		try
		{ 
			String strQuery=SQLParser.getSqlQuery("select_app_docattach_maxid^"+strAppno+"^"+strDocType+"^"+strDocCode);										
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strSno = Helper.correctNull((String)rs.getString(1));
			}						
		}
		catch(Exception e)
		{
			throw e;
		}		
		return strSno;
	}
	
	public HashMap uploadPERMDOCAttachment(MultipartFormDataRequest mrequest,String strDocType,String strDocCode,String strAppNo,String strUserID,String strCBSID,String strfacslno,String strCategory)
	{		
		boolean retval = false,bstate = false;
		HashMap hshValues=new HashMap();
		HashMap hshResult = new HashMap();
		String filePath="";
		String strFileName = "",str_Content="";	
		int intSize = 0;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String str_FileDirectory ="";
		if(!strCBSID.equalsIgnoreCase(""))
			str_FileDirectory=ApplicationParams.getStrdoclocation()+"/"+strCBSID+"/"+strAppNo;
		else
			str_FileDirectory=ApplicationParams.getStrdoclocation()+"/"+strAppNo;
		byte[] bytePhoto 	= new byte[200000];
		String strZipFilePath = "",strAttachSuccess="";
		ResultSet rs=null;
		try
		{			
			try
			{
				log.info("Document Location===="+str_FileDirectory);
				if (mrequest != null)
				{
					Hashtable files = mrequest.getFiles();
					if ((files != null) || (!files.isEmpty()))
					{
						UploadFile file = (UploadFile) files.get("fileAttach");						
						strFileName = Helper.correctNull((String) file.getFileName());
						if (!strFileName.trim().equalsIgnoreCase(""))
						{
							 String strExt=strFileName.substring(0,strFileName.indexOf("."));
							 File resultfile			= new File(str_FileDirectory);
							 if(!resultfile.exists())
							 {
								 resultfile.mkdirs();
							 }
							 
							 InputStream din = file.getInpuStream();
							 byte[] byFileName = new byte[din.available()];
							 int i = din.read(byFileName);
							 String strArray[] = null;
							 bytePhoto	= (byte[])byFileName;
							 int intActualSize=0;
							 if(rs!=null)
								 rs.close();
							 rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^107");
							 if(rs.next())
							 {
								 intActualSize=Integer.parseInt(Helper.correctInt(rs.getString("LOAN_PARAMVAL")));	
							 }
							 long intsize= file.getFileSize();
							 if(intsize>(intActualSize*1024))
							 {
								 	log.info("File Size More than "+intActualSize+" KB cannot be attached..");
									hshValues.put("strAttach","Failed : File Size More than "+intActualSize+" KB cannot be attached..");
									return hshValues;
							 }
								
							 strZipFilePath			= strExt+".zip";
							 
							long filelength;
							filelength=bytePhoto.length;
			
							if(filelength>0)
							{
								//resultfile.createNewFile();
								FileOutputStream fileout				= new FileOutputStream(str_FileDirectory+"/"+strZipFilePath);
								final ZipOutputStream zipOutputStream 	= new ZipOutputStream(fileout);
								
								//Compression
								ZipEntry zipEntry = new ZipEntry(strFileName);
								zipOutputStream.putNextEntry(zipEntry);
								
								/*Encryption*/
								
								//generating key
								byte secretKey[] 	= "KarnatakaBaKLAPS".getBytes();
								Key secretKeySpec 	= new SecretKeySpec(secretKey, "AES");

								//creating and initialising cipher and cipher streams
								Cipher encrypt 	= Cipher.getInstance("AES");
								encrypt.init(Cipher.ENCRYPT_MODE, secretKeySpec);
								
								//Encrypt or Decrypt data based on Cipher Initialization
								bytePhoto = encrypt.doFinal(bytePhoto);
								
//								Deflater df=new Deflater();
//								df.setLevel(Deflater.BEST_COMPRESSION);
//								df.setInput(bytePhoto);
//								df.finish();
//								
//								byte[] tmp=new byte[4*1024];
//								while(!df.finished())
//								{
//									int size=df.deflate(tmp);
//									zipOutputStream.write(tmp,0,size);
//								}
								
								//Write Encrypted bytes into FileStream
								zipOutputStream.write(bytePhoto);
								
								zipOutputStream.flush();
								zipOutputStream.closeEntry();
								zipOutputStream.close();
								fileout.close();
								strAttachSuccess = "S";
								log.info(strFileName+"Document Successfully Written in the Location ===="+str_FileDirectory);
								String strQuery="";
								if(strCategory.equals("CORP") || strCategory.equals("AGR"))
								{
									  strQuery=SQLParser.getSqlQuery("select_app_docattach_checker_fac^"+strAppNo+"^"+strDocType+"^"+strDocCode+"^"+strFileName+"^"+strfacslno);										
								}
								else
								{
									  strQuery=SQLParser.getSqlQuery("select_app_docattach_checker^"+strAppNo+"^"+strDocType+"^"+strDocCode+"^"+strFileName);										
								}
								rs=DBUtils.executeQuery(strQuery);
								bstate = rs.next();
								rs.close();
								
								if(bstate == false){
									String strSno = getMaxSno(strAppNo,strDocType,strDocCode); 				
									intSize ++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();				
									arrValues.add(strAppNo);
									arrValues.add(strDocType);
									arrValues.add(strDocCode);
									arrValues.add(strSno);
									arrValues.add(strFileName);
									arrValues.add(strUserID);	
									arrValues.add(strfacslno);			
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strQueryId","insert_app_docattach");
									hshQueryValues.put(Integer.toString(intSize),hshQuery);
									hshQueryValues.put("size",String.valueOf(intSize));
								 	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
								}
							}
						}
						else
						 {
							 strAttachSuccess = "F";
						 }
					}
					retval=true;
				}
				else
				{
					
				}
			}
			catch(Exception e)
			{
				retval = false;
				log.error(" Exception in Attaching Image " + e.toString());
			}
			if(retval)
				hshValues.put("strAttach","Success");
			else
				hshValues.put("strAttach","Fail");
			
		}
		catch (Exception e)
		{
			log.error(" Exception in AttachDoc " + e.toString());
		}
		return hshValues;
	}
	
	
	public HashMap updateExcelDataBulkUpload(MultipartFormDataRequest mrequest,String usrid,String orgscode,String solid,String strOrgCode,String strnbfcname)
	{
		String strAttach = "";
		boolean retval = false;
		HashMap hshValues=new HashMap();
		HashMap hshResult = new HashMap();
		try
		{
			ExceluploadSHGBean bulkDataUploadBean = new ExceluploadSHGBean();
			try
			{
				if (mrequest != null)
				{	
					Hashtable files = mrequest.getFiles();
					if ((files != null) || (!files.isEmpty()))
					{
						UploadFile file = (UploadFile) files.get("fileAttach");
						String strFileName = "";
						strFileName = Helper.correctNull((String) file .getFileName());
						
						if (!strFileName.trim().equalsIgnoreCase(""))
						{
							InputStream din = file.getInpuStream();
							byte[] byFileName = new byte[din.available()];
							int i = din.read(byFileName);
							hshValues.put("byteimg",byFileName);
							hshValues.put("filename",strFileName);
							hshValues.put("strOrgscode",orgscode);
							hshValues.put("StrUsrid",usrid);
							hshValues.put("strSolid",solid);
							hshValues.put("strOrgCode",strOrgCode);
							hshValues.put("strnbfcname",strnbfcname);
							ExceluploadSHGBean shgobj= new ExceluploadSHGBean();
							hshResult=shgobj.doUploadBulkData(hshValues);
							hshValues.put("filename",strFileName);
							hshValues.put("strAppno",Helper.correctNull((String)hshResult.get("strAppno")));
							
							retval = true;
						}
					}
				}
			}
			catch(Exception e)
			{
				retval = false;
				throw new EJBException("Error in doUploadBulkData "+e.getMessage());	
			}
			if(retval)
				hshValues.put("strAttach","Success");
			else
				hshValues.put("strAttach","Fail");
			
		}
		catch (Exception e)
		{
			System.out.println(" Exception in AttachDocCreditRisk " + e.toString());
		}
		return hshValues;}	
	
}
