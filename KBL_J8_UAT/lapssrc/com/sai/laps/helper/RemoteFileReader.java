package com.sai.laps.helper;

import java.io.*;

//import  javax.servlet.http.HttpServletRequest;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;
import java.io.InputStream;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

 
/**
*@author:S.SATHYA MOORTHY
*@PURPOSE:READING THE FILE FROM CLIENT
*@USAGE:THIS FILE SHOULD BE CALLED FROM CONTROLLER SERVLET WITH HttpServletRequest reference.
**/


public class RemoteFileReader
{

	/**
	*@author:S.SATHYA MOORTHY
	*@PURPOSE:READING THE FILE FROM CLIENT
	*@RETURN BOOLEAN.
	*@USAGE:THIS FILE SHOULD BE CALLED FROM CONTROLLER SERVLET WITH HttpServletRequest reference.
	*@ARG:HTTPSERVLETREQUEST REFERENCE.
	**/
	static Logger log=Logger.getLogger(RemoteFileReader.class);
//public static boolean readRemoteFile(HttpServletRequest request)
//{
	
	//FileInputStream returnFIS=null;
	//String savePath = "", filepath = "";
	//String  filename = "";  
	//String contentType = "";
	//String fileData = "", strLocalFileName = "";  
	//int startPos = 0, endPos = 0;  
	//int BOF = 0, EOF = 0;  
	//ServletContext application=null;
	//boolean boolReturn=false;
	//try
	//{
	//contentType = request.getContentType();  
	//String serverFileLoc="D:\\";
	//String fileName=
	//File newFile = new File(serverFileLoc, fileName);
	//temp = request.getParameterValues("fileInput");
	//File origFile = new File(temp);

	//InputStream ins = new FileInputStream(origFile);
	//OutputStream outs = new FileOutputStream(newFile);

	//byte[] buf = new byte[1024];
	//int len;
	//while ((len = ins.read(buf)) > 0)
	//{
	//outs.write(buf, 0, len);
	//}
	//ins.close();
	//outs.close();
	
	/*Logger.log("Content type of The Uploading File is ::" +contentType);  
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))   
	{  
		DataInputStream in = new DataInputStream(request.getInputStream());  
		DataInputStream in1 = in;  
		int formDataLength = request.getContentLength();  
		byte dataBytes[] = new byte[formDataLength];  
		int byteRead = 0;  
		int totalBytesRead = 0;  
		while (totalBytesRead < formDataLength)  
		{	  
			byteRead = in1.read(dataBytes, totalBytesRead, formDataLength);  
			totalBytesRead += byteRead;  
		}  
		Logger.log("totalBytesRead : " + totalBytesRead + ":formDataLength =" + formDataLength);  
		  
		byte[] line = new byte[128];  
		if (totalBytesRead < 3)	  
		{  
			boolReturn=false;
		  throw new Exception(" Uploading  file length is not sufficiently large");  
		}  
  
		String boundary = "";  
		String s = "";  
		int count = 0;		  
		int pos = 0;  
		  
		//loop for extracting boundry of file  
		//could also be extracted from request.getContentType()  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("Content-Disposition: form-data; name=\""); //set the file name  
			if(pos != -1)  
			endPos = pos;  
		}while(pos == -1);  
		boundary = fileData.substring(startPos, endPos);  
  
		//loop for extracting filename  
		startPos = endPos;  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("filename=\"", startPos); //set the file name  
			if(pos != -1)  
				startPos = pos;  
		}while(pos == -1);					  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;  
			pos = fileData.indexOf("Content-Type: ", startPos);  
			if(pos != -1)  
				endPos = pos;						  
		}while(pos == -1);  
		filename = fileData.substring(startPos + 10, endPos - 3);	//to eliminate " from start & end  
		strLocalFileName = filename;  
		int index = filename.lastIndexOf("\\");  
		if(index != -1)  
			filename = filename.substring(index + 1);  
		else  
			filename = filename;  
		  
		//loop for extracting ContentType  
		boolean blnNewlnFlag = false;  
		startPos = endPos;	//added length of "Content-Type: "  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;			  
			pos = fileData.indexOf("\n", startPos);  
			if(pos != -1)  
			{  
				if(blnNewlnFlag == true)  
					endPos = pos;					  
				else  
				{  
					blnNewlnFlag = true;  
					pos = -1;  
				}  
			}  
		}while(pos == -1);  
		contentType = fileData.substring(startPos + 14, endPos);  
		  
		//loop for extracting actual file data (any type of file)  
		BOF = count + 1;  
		do  
		{  
			copyByte(dataBytes, line, count ,1);	//read 1 byte at a time  
			count+=1;  
			s = new String(line, 0, 1);  
			fileData = fileData + s;
			//if(fileData.length()==dataBytes.length)pos=1;else pos=-1;
			pos = fileData.indexOf(boundary, startPos);	//check for end of file data i.e boundry value			  
		}while(pos == -1);  
		EOF = count - boundary.length();  
		//file data extracted  
  
		Logger.log("<br><br>0. Local File Name = " + strLocalFileName);  
		Logger.log("<br><br>1. filename = " + filename);  
		Logger.log("<br>2. contentType = " + contentType);  
		Logger.log("<br>3. startPos = " + BOF);  
		Logger.log("<br>4. endPos = " + EOF);  
		Logger.log("<br>5. boundary = " + boundary);  
  
		//create destination path & save file there
		
		FileOutputStream fileOut = new FileOutputStream("d:/"+filename);  
		
		fileOut.write(dataBytes, BOF, (EOF - BOF));  
		fileOut.flush();  
		fileOut.close();  
		boolReturn=true;
  
	}  
	else  
	{  
		boolReturn=false;
		throw new Exception("$"+"Exception Occurred While Uploading the File");
		  
	} */
	
	//}
	//catch(Exception e)
	//{
		//Logger.log(e.toString());
		
	//}
	//return boolReturn;
	//}//end of readRemoteFile method

	/**
	*AUTHOR:S.SATHYA MOORTHY.
	*@PURPOSE:COPYING THE DATA INTO THE ARRAY.(S.SATHYA MOORTHY).
	*@usage:Within this class.
	**/
	/*private static void  copyByte(byte [] fromBytes, byte [] toBytes, int start, int len)  
	{  
		for(int i=start;i<(start+len);i++)  
		{  
			toBytes[i - start] = fromBytes[i];  
		}  
	}*/ //end of copyByte method
	
	
	
	
	//###################################################################################################
	
	

	private static String getFileExt(String xPath){  
  
			int dotindex = 0;	//extension character position  
			dotindex = xPath.lastIndexOf('.');  
			  
			if (dotindex == -1){	// no extension	  
				return "";  
			}  
			  
			int slashindex = 0;	//seperator character position  
			slashindex = Math.max(xPath.lastIndexOf('/'),xPath.lastIndexOf('\\'));  
			  
			if (slashindex == -1){	// no seperator characters in string  
				return xPath.substring(dotindex);  
			}  
			  
			if (dotindex < slashindex){	//check last "." character is not before last seperator  
				return "";  
			}  
			return xPath.substring(dotindex);  

	}  

/**
	 * @author Priya
	 * @modified by Arunkumar Subramaniam 08-Jan-2008
	 * @since 20.12.2007
	 * To Upload a file and write it to a location in the server
	 * @param mrequest
	 * @return
**/
	public static boolean readClientFile(MultipartFormDataRequest mrequest,HashMap hshRequestValues){
		String strFileName="",strFilexls="",strQuery="";
		ResultSet rs=null;
		String strAppno=Helper.correctNull((String)hshRequestValues.get("strAppno"));
		String strFinUpload=Helper.correctNull((String)hshRequestValues.get("strFinUpload"));
		String strSpreadExcel=Helper.correctNull((String)hshRequestValues.get("strExcelUpload"));
		String strCMAdesc="",strComname="";
		String strXLCMAno="",strName="";
		String strXLCMAName="",strExisting="",strProposed="";
		String[] strValue = null;
		ArrayList test = new ArrayList();
		int tokcnt=0;
		try{
			if (mrequest != null)
			{
				Enumeration enumRequest = mrequest.getParameterNames();
				while (enumRequest.hasMoreElements()) {
					strName = (String) enumRequest.nextElement();
					strValue = mrequest.getParameterValues(strName);
					if (strValue.length == 1) {
						hshRequestValues.put(strName, strValue[0]);
					} else {
						hshRequestValues.put(strName, strValue);
					}
				}
				Hashtable files = mrequest.getFiles();
				if ((files != null) || (!files.isEmpty()))				{
					UploadFile file = (UploadFile) files.get("fileUpload");
					strFileName = Helper.correctNull((String) file.getFileName());
					if (strFinUpload.equalsIgnoreCase("YES"))
					{
						if(!strFileName.trim().equalsIgnoreCase(""))
						{
							strFilexls=strFileName.substring(strFileName.length()-3,strFileName.length());
						}
						else
						{
							hshRequestValues.put("CMAflag","$SELECT THE EXCEL SHEET TO UPLOAD!!!!");
						}
						if (strFilexls.equalsIgnoreCase("xls") || strFilexls.equalsIgnoreCase("ods"))
						{
							strFileName=strFileName.substring(0,(strFileName.length()-(strFilexls.length()+1)));
							StringTokenizer st = new StringTokenizer(strFileName,"_");
							tokcnt=st.countTokens();
							if(tokcnt==3)
							{
								strXLCMAName = ((String)st.nextToken()).trim();
								strXLCMAno = ((String)st.nextToken()).trim();
 								strComname = ((String)st.nextToken()).trim();
 								String strhidCMANo = Helper.correctNull((String)hshRequestValues.get("hidCMANo"));
 								if(!strhidCMANo.equalsIgnoreCase(""))
								{
									strQuery = SQLParser.getSqlQuery("com_cma_master_selectdesc^" + strhidCMANo);
									rs=DBUtils.executeQuery(strQuery);
									if(rs.next())
									{
										strCMAdesc=Helper.correctNull((String)rs.getString("cma_format_desc"));
									}
								}
								if(strXLCMAno.equalsIgnoreCase(strhidCMANo) && strXLCMAName.equalsIgnoreCase(strCMAdesc))
								{
									InputStream din = file.getInpuStream();											
									InputStream inputStream=din;
									byte[] byFileName=new byte[inputStream.available()];
									int i=din.read(byFileName);
									hshRequestValues.put("stream",byFileName);	
									hshRequestValues.put("CMAflag","SUCCESS");
								}
								else
								{
									hshRequestValues.put("CMAflag","$CMA IS NOT MATCHING WITH THE APPLICANT CMA!!!!");
								}
							}
							else
							{
								hshRequestValues.put("CMAflag","$INVALID FILE  NAME!!!!");
							}
						}
						else
						{
							hshRequestValues.put("CMAflag","$SELECT THE EXCEL SHEET TO UPLOAD!!!!");
						}
					}
					else if(strSpreadExcel.equalsIgnoreCase("YES"))
					{
						strFilexls=strFileName.substring(strFileName.length()-4,strFileName.length());
						
						if (strFilexls.equalsIgnoreCase("xlsx"))
						{
							strFileName=strFileName.substring(0,(strFileName.length()-(strFilexls.length()+1)));
							StringTokenizer st = new StringTokenizer(strFileName,"_");
							tokcnt=st.countTokens();
							if(tokcnt==3 && strFileName.length()==34)
							{
								String strXLName = ((String)st.nextToken()).trim();
								String strXLDate = ((String)st.nextToken()).trim();
								String strXLTime = ((String)st.nextToken()).trim();
 								
								if(strXLName.length()==20 && strXLDate.length()==8 && strXLTime.length()==4)
								{
									InputStream din = file.getInpuStream();											
									InputStream inputStream=din;
									byte[] byFileName=new byte[inputStream.available()];
									int i=din.read(byFileName);
									hshRequestValues.put("stream",byFileName);
									hshRequestValues.put("strFileName",strFileName);	
									hshRequestValues.put("strExcelflag","SUCCESS");
								}
								else
								{
									hshRequestValues.put("strExcelflag","$INVALID FILE  NAME!!!!");
								}
							}
							else
							{
								hshRequestValues.put("strExcelflag","$INVALID FILE  NAME!!!!");
							}
						}
						else
						{
							hshRequestValues.put("strExcelflag","$SELECT THE EXCEL SHEET TO UPLOAD!!!!");
						}
					}
					else 
					{
						if (!strFileName.trim().equalsIgnoreCase(""))
						{
							InputStream din = file.getInpuStream();											
							InputStream inputStream=din;
							byte[] byFileName=new byte[inputStream.available()];
							int i=din.read(byFileName);
							hshRequestValues.put("stream",byFileName);	
						}
					}
				}
			}
		}catch(Exception e){
			log.error(" Exception in AttachDoc " + e.toString());
		}
		return true;
	}

	
	//public static boolean readfilefromclient(MultipartFormDataRequest mrequest,HashMap hshRequestValues){
		//boolean boolstate=false;
		/*try{
			File movefile = new File("D:\\UBIUpload");

			if (!movefile.exists())
			{
				movefile.mkdir();
			}
			if (mrequest != null)
			{
				Hashtable files = mrequest.getFiles();
				if ((files != null) || (!files.isEmpty()))
				{
					
				}
			}
			FileReader fr2 = new FileReader(Path);
			BufferedReader br2 = new BufferedReader(fr2);

			// Moving the Success file to succeeded folder....
			new File(rootPath + FolderName1 + "\\Done\\" + filenames);
			FileWriter fw2 = new FileWriter(rootPath + FolderName1 + "\\Done\\" + filenames);
			BufferedWriter bw2 = new BufferedWriter(fw2);
			
		}catch(Exception e){
			Logger.log(" Exception in readfilefromclient " + e.toString());
		}*/
		
		//return boolstate;
	//}
	
	/**
	 * @author Priya
	 * @modified by:S.SATHYA MOORTHY
	 * @since 20.12.2007
	 * To Upload a file and write it to a location in the server
	 * @param mrequest
	 * @return
**/
//	public static boolean readRemoteFile(MultipartFormDataRequest mrequest,String strPath,String strUserId){
//		String strFileName="";
//		try{
//			if (mrequest != null)
//			{
//				Hashtable files = mrequest.getFiles();
//				if ((files != null) || (!files.isEmpty()))
//				{
//					UploadFile file = (UploadFile) files.get("fileUpload");
//					strFileName = Helper.correctNull((String) file.getFileName());
//					if (!strFileName.trim().equalsIgnoreCase(""))
//					{
//						InputStream din = file.getInpuStream();
//						byte[] byFileName = new byte[din.available()];
//						int i = din.read(byFileName);
//						
//						/** to avoiding the file locking (dead lock).file renamed based on userid:: added by s.sathya moorthy**/
//						String tempFileName=strFileName;
//						String tempExt="";
//						tempExt=tempFileName.substring(tempFileName.lastIndexOf("."),tempFileName.length());
//						String tempFileName1=tempFileName.substring(0,tempFileName.lastIndexOf("."));
//						strFileName=tempFileName1+Helper.correctNull(strUserId)+tempExt;//concating the filename+userid+fileextension
//						
//						File dir=new File(Helper.correctNull(strPath));
//						if(!dir.exists())dir.mkdirs();
//						File f1=new File(Helper.correctNull(strPath)+"/"+Helper.correctNull(strFileName));
//						FileOutputStream fout=new FileOutputStream(f1);
//						fout.write(byFileName);
//						fout.flush();
//						fout.close();
//						Logger.log("File has been Uploaded Successfully:: From the User ::"+ strUserId +" Path:: "+strPath+"/"+strFileName);
//					}
//				}
//			}
//			
//		}catch(Exception e){
//			SLogger.log" Exception in AttachDoc " + e.toString());
//		}
//		return true;
//	}
	
	
		
	/**
	 * @author:S.SATHYA MOORTHY
	 * @PURPOSE:DELETING THE FILE
	 * @ARG:PATH and FILENAME WITH EXTENSION.
	 * @since :01/12/2008
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
		 log.info("The File Has Been Deleted From the Path ::"+strFilePath);
		}
		else
		{
			log.info("Cannot Delete the File From the Path ::"+strFilePath);
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
	 * @author :S.SATHYA MOORTHY.
	 * @USAGE: CONTROLLER SERVLET.
	 * @since :17/03/2008
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
				log.info("Folder Created In the path ::"+Path);
			}
			else
			{
				status=false;
				log.info("Folder Already Exists::"+Path);
			}
		}	
		catch(Exception e)
		{
			log.error("Exception Occurs Unable to Create The Supportive FOLDERS FOR LAPS \n" +
					"Please check the Folder rights"+e.toString());
			log.error("Remote File Reader.createFolders() PROBLEM OCCURS WHILE CREATING THE FOLDER"+e.toString());
			
		}
		finally
		{
			directory=null;
		}
		
		return status;
	}
	
	
	
		
}//end of class









