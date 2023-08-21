package com.sai.laps.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Hashtable;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;
 
/**
*@author:S.SATHYA MOORTHY
*@PURPOSE:READING THE FILE FROM REQUEST HEADER
*@USAGE:THIS FILE SHOULD BE CALLED FROM CONTROLLER SERVLET WITH MULTIPART REQUEST.
**/
public class FileManager
{

	
	
	public FileManager() {
		super();
		// TODO Auto-generated constructor stub
	}

/**
 * 
 *@author : S.SATHYA MOORTHY
 *@date   :Apr 7, 2009 :12:50:47 PM
 *@param mrequest
 *@param hshRequestValues
 *@return
 *@purpose:
 *@description :
 *@todo :
 */
	public static boolean readClientFileByStream(MultipartFormDataRequest mrequest,HashMap hshRequestValues){
		String strFileName=""; 
		try{
			if (mrequest != null)
			{
				Hashtable files = mrequest.getFiles();
				if ((files != null)){ 
				if(!files.isEmpty()){			
					UploadFile file = (UploadFile) files.get(Constants.HTML_FILE_CONTROL);
					strFileName = Helper.correctNull((String) file.getFileName());
					if (!strFileName.trim().equalsIgnoreCase(""))
					{
						InputStream din = file.getInpuStream();											
						InputStream inputStream=din;
							
						byte[] byFileName=new byte[inputStream.available()];
						hshRequestValues.put(Constants.UPLOAD_FILE_STREAM_KEY,byFileName);	
					}
				}
				}	
			}
			
		}catch(Exception e){
			Logger.log(" Exception in AttachDoc " + e.toString());
		}
		return true;
	}

	/**
	 * 
	 *@author: S.SATHYA MOORTHY
	 *@date   :Apr 2, 2009 :1:39:12 PM
	 *@param mrequest
	 *@param strPath
	 *@return
	 *@purpose:
	 *@description :
	 *@todo :
	 */	
	public static boolean readAndSave(MultipartFormDataRequest mrequest,HashMap hshRequestValues,String strPath){
			String strFileName=null;
			try{
				if (mrequest != null)
				{
					Hashtable files = mrequest.getFiles();
					if ((files != null)){ 
						if (!files.isEmpty())
					{
						UploadFile file = (UploadFile) files.get(Constants.HTML_FILE_CONTROL);
						
						
						
						strFileName = Helper.correctNull((String) file.getFileName());
						if (!strFileName.trim().equalsIgnoreCase(""))
						{
							InputStream din = file.getInpuStream();
							byte[] byFileName = new byte[din.available()];
							String tempFileName=strFileName;
							String tempExt="";
							tempExt=tempFileName.substring(tempFileName.lastIndexOf("."),tempFileName.length());
							String tempFileName1=tempFileName.substring(0,tempFileName.lastIndexOf("."));
							strFileName=tempFileName1+tempExt;
							File dir=new File(Helper.correctNull(strPath));
							if(!dir.exists())dir.mkdirs();
							File f1=new File(Helper.correctNull(strPath)+"/"+Helper.correctNull(strFileName));
							FileOutputStream fout=new FileOutputStream(f1);
							fout.write(byFileName);
							fout.flush();
							fout.close();
							Logger.log("File has been Uploaded Successfully:: From the User ::"+ " Path:: "+strPath+"/"+strFileName);
							
							
							hshRequestValues.put(Constants.UPLOAD_FILE_NAME, Helper.correctNull(strFileName));
							hshRequestValues.put(Constants.UPLOAD_FILE_EXT,tempExt);
							hshRequestValues.put(Constants.UPLOAD_FILE_LOCATION,Helper.correctNull(strPath)+Constants.FILE_SEPERATOR+Helper.correctNull(strFileName));
							
						}
						
							
					}
					}	
				}
				
			}catch(Exception e){
				Logger.log("Exception Occurred while Upload the File " + e.toString());
			}
			return true;
		}
	
	/**
	 * 
	 *@author : S.SATHYA MOORTHY
	 *@date   :May 4, 2009 :10:37:49 AM
	 *@param mrequest
	 *@param hshRequestValues
	 *@param strPath
	 *@param strMode
	 *@return
	 *@throws Exception
	 *@purpose:
	 *@description :
	 *@todo :
	 */
	public static boolean importClientFile(MultipartFormDataRequest mrequest,HashMap hshRequestValues,String strPath,final String strMode,final String strUploadType)throws Exception {
		
	
		String strFilePath=Helper.correctNull(strPath);
		String strDrive = strFilePath.substring(0, strFilePath.indexOf(":"));
		if(mrequest==null)throw new Exception("NOT A MULITPART REQUEST");
		if(strPath==null|| strPath.equals(""))throw new Exception("DRIVE IS EMPTY");
		if(strMode==null || strMode.equals(""))throw new Exception("UPLOAD MODE IS EMPTY");
		if(strUploadType==null || strUploadType.equals(""))throw new Exception ("UPLOAD TYPE IS EMPTY");
		
		
		//ASSIGN THE DIRECTORY WHERE WE WANT TO SAVE THE FILE.
		
		if(Helper.correctNull(strUploadType).equals(Constants.UPLOAD_FOR_DUE_DILIGENCE))
		strPath=strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_DATA_DIR;
		else throw new Exception ("Please verify the Upload Type");
		
		//ADDING NECESSARY INFORMATION TO THE HASHMAP
		hshRequestValues.put(Constants.UPLOAD_FILE_DRIVE, strDrive);
		
		
		if(Helper.correctNull(strMode).equals(Constants.IMPORT_FILE_BY_BINARY_STREAM))
		{
			    readClientFileByStream(mrequest,hshRequestValues);
		}
		else if(Helper.correctNull(strMode).equals(Constants.IMPORT_FILE_FROM_REQUEST))
		{
			readAndSave(mrequest,hshRequestValues, strPath);
		}
		else if(Helper.correctNull(strMode).equals(Constants.IMPORT_FILE_BY_REQUEST_AND_STREAM)) {
			readClientFileByStream(mrequest,hshRequestValues);
			readAndSave(mrequest,hshRequestValues, strPath);	
		}
			
		return true;
	}
	
	
	
	
	/**
	 *@author : S.SATHYA MOORTHY
	 *@date   :May 4, 2009 :11:19:41 AM
	 *@param Path
	 *@return
	 *@purpose:CREATING THE FOLDERS IN THE GIVEN PATH
	 *@description :
	 *@todo :
	 */
	public static boolean createFolders(String Path)
	{
		
		boolean status=false;
		File directory=new File(Helper.correctNull(Path));
	try
	{
		
		if(!directory.exists())
		{
			directory.mkdirs();
			status=true;
			Logger.log("Folder Created In the path ::"+Path);
		}
		else
		{
			status=false;
			Logger.log("Folder Already Exists::"+Path);
		}
	}	
		catch(Exception e)
		{
			Logger.log("Exception Occurs Unable to Create The Supportive FOLDERS FOR LAPS \n" +	"Please check the Folder rights"+e.toString());
			Logger.log("Remote File Reader.createFolders() PROBLEM OCCURS WHILE CREATING THE FOLDER"+e.toString());
			
		}
		finally
		{
			directory=null;
		}
		
		return status;
	}
	
	
	/**
	 * 
	 *@author: S.SATHYA MOORTHY
	 *@date   :May 4, 2009 :11:20:52 AM
	 *@param Path
	 *@return
	 *@purpose:REMOVING ALL THE FILES IN THE GIVEN PATH
	 *@description :
	 *@todo :
	 */
	public static boolean resetFolder(String Path)
	{
		
		boolean status=false;
		File directory=new File(Helper.correctNull(Path));
	try
	{
		
		if(directory.exists())
		{
			
			String files[]=directory.list();
			for (int i=0;i<files.length;i++)
			{
				FileManager.removeFile(Helper.correctNull(Path+"/"+files[i]));
			}
			status=true;
			Logger.log("Folder Reseted::"+Helper.correctNull(Path));
		}
		
	}	
		catch(Exception e)
		{
			Logger.log("Exception Occurs Unable to reset the Supportive FOLDERS FOR LAPS \n" +
					"Please check the Folder rights"+e.toString());
			Logger.log("Remote File Reader.resetFolders()PROBLEM OCCURS WHILE RESET THE FOLDER"+e.toString());
			
		}
		finally
		{
			directory=null;
		}
		
		return status;
	}
	
	/**
	 *@author : S.SATHYA MOORTHY
	 *@date   :May 4, 2009 :11:23:19 AM
	 *@param strFilePath
	 *@return
	 *@throws IOException
	 *@purpose:FOR REMOVING THE FILE FROM SPECIFIED PATH
	 *@description :
	 *@todo :
	 */
	public static boolean removeFile(String strFilePath)throws IOException
	{
		boolean returnFlag=false;
		File dfile=new File(Helper.correctNull(strFilePath));
		try
		{
		
		
		
		if(
		(dfile.exists()) &&
		(dfile.isFile()) &&
		(dfile.isAbsolute()) &&
		(dfile.canRead()) &&
		(dfile.canWrite())
		)
		{				
		 returnFlag=dfile.delete();
		 Logger.log("The File Has Been Deleted From the Path ::"+strFilePath);
		}
		else
		{
			Logger.log("Cannot Delete the File From the Path ::"+strFilePath);
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{ 
		   dfile=null;
		}
		
		return returnFlag;
		
	}
	
	
    
	
	/**
	 *@author: S.SATHYA MOORTHY
	 *@date   :May 4, 2009 :11:27:30 AM
	 *@return
	 *@throws Exception
	 *@purpose: CREATING THE TEMPORARY FOLDER AT SERVER START UP
	 *@description :
	 *@todo :
	 */
	public static boolean createFoldersAtStartup(String strSourcePath) throws Exception{
		
		String strFilePath=Helper.correctNull(strSourcePath);
		String strDrive = Helper.correctNull(strFilePath.substring(0, strFilePath.indexOf(":")));
		
		
		//FOR DUE DILIGENCE SUPPORTIVE FOLDERS
		createFolders(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_DATA_DIR);
		createFolders(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_LOG_DIR);
		createFolders(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_DONE_DIR);
		createFolders(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_BAD_DIR);
		//FOR LAPS MAIL ATTACHMENTS
		createFolders(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.MAIL_ATTACHMENT_DIR);
		
		
		
		
		
		
		return true;
	}
	
	/**
	 *@author : S.SATHYA MOORTHY 
	 *@integrated by: S.SATHYA MOORTHY
	 *@date   :May 8, 2009 :12:36:46 PM
	 *@param strSourcePath
	 *@return
	 *@throws Exception
	 *@purpose:FOR CLEARING THE FOLDERS AT STARTUP IF UNWANTED FILES PRESENT IN PREVIOUS DEPLOYMENTS AND FILEOPERATIONS
	 *@description :
	 *@todo :
	 */
	public static boolean clearFoldersAtStartup(String strSourcePath) throws Exception{
		
		String strFilePath=Helper.correctNull(strSourcePath);
		String strDrive = Helper.correctNull(strFilePath.substring(0, strFilePath.indexOf(":")));
		
		
		//FOR DUE DILIGENCE SUPPORTIVE FOLDERS
		resetFolder(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_DATA_DIR);
		resetFolder(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_LOG_DIR);
		resetFolder(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_DONE_DIR);
		resetFolder(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.UPLOAD_FILE_DD_BAD_DIR);
		
		//FOR LAPS MAIL ATTACHMENTS
		resetFolder(strDrive+Constants.DRIVE_SPECIFIER+Constants.UPLOAD_FILE_DD_FILE_SEPERATOR+Constants.MAIL_ATTACHMENT_DIR);
		
		return true;
	}
	
	/**
	 * MIME TYPE
	 * @param format
	 * @return
	 */
	public static String getMimeType(String format)
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
}//end of class









