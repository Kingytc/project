package com.sai.laps.ejb.ramtolaps;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RamToLapsBean", mappedName = "RamToLapsHome")
@Remote (RamToLapsRemote.class)
public class RamToLapsBean extends BeanAdapter

{

	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(RamToLapsBean.class);

	SimpleDateFormat sd = null;

	SimpleDateFormat sdt = null;

	
	/**
	 * @author : R.MURALIDHARAN and S.SATHYA MOORTHY
	 * @PURPOSE: REPORT 105/106 
	 * @Modified By : G.Sureshkumar
	 * @since : 17 March 2009
	 */

	public HashMap RAMtoLAPS_REPORT(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		
		ResultSet rs = null;	
		String strQuery="";
		ArrayList arrValues= new ArrayList();
		HashMap hshmap=new HashMap();
		
		FileReader filereader1 = null;
		BufferedReader reader1 = null;
		
		File selectfile =null;
		File movefile=null;
		String[] FILELIST = null;		
		
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		
		String str_Exception="$";
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String rootPath = "";
		String LOGFileName="";
		FileWriter flog=null;	
		String strDatafolder="Data\\";
		String FolderName = "CorporateReports\\";//map the folder as per your requirement
		String FolderName1="";
		
		try   
		{	
			if(new File(strIRBPath1).exists())
			{
				rootPath=strIRBPath1+ FolderName;
			}
			else if(new File(strIRBPath2).exists())
			{
				rootPath=strIRBPath2+ FolderName;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing 105 REPORT Flat File !!";
				throw new Exception(str_Exception);
			}
	
			selectfile = new File(rootPath+strDatafolder);
			LOGFileName=rootPath+"Log\\";
			
			if (!selectfile.exists())
				selectfile.mkdirs();
	
			FILELIST = selectfile.list();			

		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}
		
		String Path = "";
		String ReportNo="";
		String Company_code="";
		String Application_No="";
		String Date="";
		String Time="";
		int intUpdatesize=0;
		String filenames="";
		String badFileName="";
		String appno="";
		int CompanyCode=0;
		String filedata="";
		try 
		{
			appno= Helper.correctNull((String)hshValues.get("appno"));
			
			String strDate="";
			String strTime="";
			
			
			sd = new SimpleDateFormat("ddMMyyyy");
			sdt = new SimpleDateFormat("HHmmss");
			
			strDate=sd.format(new Date());
			strTime=sdt.format(new Date());
			LOGFileName=LOGFileName+appno+"_"+strDate+"_"+strTime+".txt";
			
			flog = new FileWriter(LOGFileName);
			BufferedWriter bufWriterlog=new BufferedWriter(flog);
			
			 /* FILE NAME FORMAT
			 * {PREFIX}105/106_COMPANYCODE(LAPSID)_APPLICATIONNO_ ddmmyyyy_hhmmss.txt
			 */
			
			for (int filecounter = 0; filecounter < FILELIST.length; filecounter++)
			{
				int dflag = 0;
				filenames = FILELIST[filecounter];
				filecount=FILELIST.length;
				
				Path = rootPath +  strDatafolder+"\\" + filenames;
				
				badFileName = filenames;
				
				if (!new File(rootPath + strDatafolder+ "\\" + filenames).isFile())
					continue;
				// End of selecting file			
			
				filereader1 = new FileReader(Path);
				reader1 = new BufferedReader(filereader1);
				//ArrayList arrayList = new ArrayList();	
				StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
				
				
				
				
				while (tokenizer1.hasMoreTokens()) 
				{
					ReportNo=correctNull((String)tokenizer1.nextToken()).trim();
					
					bufWriterlog.write("File Name :: "+filenames);
					bufWriterlog.newLine();
					bufWriterlog.write("Report Name ::  "+ReportNo);
					bufWriterlog.newLine();
					
					
					if(ReportNo.equalsIgnoreCase("ExecutiveSummary"))
					{
						bufWriterlog.write("It is not correct file so exiting");
						bufWriterlog.newLine();
						break;
					}
					Company_code=correctNull((String)tokenizer1.nextToken()).trim();
					Application_No=correctNull((String)tokenizer1.nextToken()).trim();
					Date=((String)tokenizer1.nextToken()).trim();
					Time=((String)tokenizer1.nextToken()).trim();
				}
				if(!Company_code.equalsIgnoreCase(""))
				{			
					CompanyCode=Integer.parseInt(Company_code);			
					Company_code=Integer.toString(CompanyCode);
				}
			
				bufWriterlog.write("Application Number ::  "+Application_No);
				bufWriterlog.newLine();
				
				if(ReportNo.equalsIgnoreCase("REPORT105") && Application_No.equalsIgnoreCase(appno))
				{
				
					
					String strParameters[]={"BranchName","RegionName","CompanyName - CompanyCode(LAPSID)",
							"DateofFinalisation","LastRatedDate(BaseModel)","LastRating(BaseModel)",
							"LastScore(BaseModel)","LastGradeDefinition (BaseModel)","LastRatedDate(DynamicModel)",
							"LastRating (DynamicModel)","LastScore(DynamicModel)","LastGradeDefinition(DynamicModel)",
							"LastCombinedRating(DynamicModel)","CurrentRatingDate(BaseModel)",
							"CurrentRating(BaseModel)","CurrentScore(BaseModel)","CurrentGradeDefinition(BaseModel)",
							"CurrentRatingDate(DynamicModel)","CurrentRating(DynamicModel)","CurrentScore(DynamicModel)",
							"CurrentGradeDefinition(DynamicModel)","Current Combined Rating(DynamicModel)",
							"RatingRationale","RatingPoolRemarks"};
					/* FORMAT 105:
					 * BranchName~RegionName~CompanyName - CompanyCode(LAPSID)~
					 * DateofFinalisation~LastRatedDate(BaseModel)~
					 * LastRating(BaseModel)~LastScore(BaseModel)~
					 * LastGradeDefinition (BaseModel)~LastRatedDate(DynamicModel)~
					 * LastRating (DynamicModel)~LastScore(DynamicModel)~
					 * LastGradeDefinition(DynamicModel)~LastCombinedRating(DynamicModel)~ 
					 * CurrentRatingDate(BaseModel)~CurrentRating(BaseModel)~
					 * CurrentScore(BaseModel)~CurrentGradeDefinition(BaseModel)~
					 * CurrentRatingDate(DynamicModel)~CurrentRating(DynamicModel)~
					 * CurrentScore(DynamicModel)~CurrentGradeDefinition(DynamicModel)~
					 * Current Combined Rating(DynamicModel)~RatingRationale~RatingPoolRemarks 		
					 * Total : 24 items
					 */						
					
					while (true) 
					{
						String read = reader1.readLine();				
						if (read == null || read.equals("null"))
							break;
						if(filedata.equals(""))
						{
							filedata=read;
						}
						else
						{
							filedata=filedata+"<br>"+read;
						}
					}
					if(!filedata.equalsIgnoreCase(""))
					{
						//String strValues[] = read.split("~");
						String strValues[] = new String[24];
						//int TotalParametersinFile=0;
						try
						{
							int j=0;
							for(int l=0; l<24; l++)
							{
								int k=0;
								
								if(l==23)
								{
									k=filedata.length();
								}
								else
								{
									k=filedata.indexOf("~",j);
								}
								strValues[l]=filedata.substring(j,k);
								j=++k;
								if(filedata.length()==j && l<22)
								{
									bufWriterlog.write("Parameters Missing in LAS 105 Reports");
									bufWriterlog.newLine();
									moveFile(rootPath,"bad",filenames);
									str_Exception = str_Exception + "Error Occured While Importing 105 REPORT Flat File..!! Due to Insufficient Datas !!! ";
									throw new Exception(str_Exception);
								}
								log.info("File Length   : "+filedata.length()+"    readed value   :  "+j);
							}
						}
						catch(Exception e)
						{
							throw new EJBException(e.toString());
						}				
						/*
						 * If Application already exists in table RAMTOLAPS105 its first deleted and then
						 * inserted
						 * 
						 * else values are inserted directly into the table RAMTOLAPS105
						 * 
						 * PRIMARY KEY: Application Number
						 */
						if(rs!=null)
						{
							rs=null;
						}
						
						intUpdatesize =0;
						strQuery=SQLParser.getSqlQuery("getramrating105details^"+Application_No);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							bufWriterlog.write("Old datas are deleting ::  ");
							bufWriterlog.newLine();
							
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","delreport105");
							arrValues.add(Application_No);
							hshQuery.put("arrValues",arrValues);				
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}			
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","insreport105");
						arrValues.add(Application_No);
						for(int i=0;i<24;i++)
						{
							if(i==2)
							{
								String strCompanyName[] = strValues[i].split("-");
								arrValues.add(strCompanyName[0].trim());
								arrValues.add(strCompanyName[1].trim());
								bufWriterlog.write(strParameters[i]+"  ::  "+strValues[i]);
								bufWriterlog.newLine();
							}
							else
							{
								bufWriterlog.write(strParameters[i]+"  ::  "+strValues[i]);
								bufWriterlog.newLine();
								arrValues.add(strValues[i]);								
							}
						}					
						hshQuery.put("arrValues",arrValues);				
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						dflag=1;
					}
				}	
				else if(ReportNo.equalsIgnoreCase("REPORT105"))
				{
					dflag=2;
				}
				else if(ReportNo.equalsIgnoreCase("ExecutiveSummary"))
				{
					dflag=2;
				}
				
				//Assigning Folder name bad and done folders.
				FolderName1="CorporateReports";
				
				
				//After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{

					++goodfile;
					movefile=new File(rootPath+"Done\\");
					
					if (!movefile.exists())
					{
						movefile.mkdir();
					}
					
					FileReader fr2 = new FileReader(Path);
					BufferedReader br2 = new BufferedReader(fr2);

					// Moving the Success file to succeeded folder....
					new File(rootPath +  "\\Done\\" + filenames);
					FileWriter fw2 = new FileWriter(rootPath + "\\Done\\" + filenames);
					BufferedWriter bw2 = new BufferedWriter(fw2);

					while (true)
					{
						String tempString = br2.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw2.write(tempString);
					}

					br2.close();
					bw2.close();
					fr2.close();
					fw2.close();
					filereader1.close();
					reader1.close();
				
					File dfile = new File(Path);
					if (dfile.exists())
					{
						if(!dfile.delete())
						{
							dfile.delete();
						}
						else
						{
							dfile.delete();
						}
					}
				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					movefile=new File(rootPath+"Bad\\");
					
					if (!movefile.exists())
					{
						movefile.mkdir();
					}
					
					new File(rootPath + FolderName1 + "\\Bad\\" + filenames);
	
					FileWriter fw = new FileWriter(rootPath + FolderName1 + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);
	
					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
					}
	
					br1.close();
					bw.close();
					fr1.close();
					fw.close();
					filereader1.close();
					reader1.close();
					
					File dfile = new File(Path);
					if (dfile.exists())
					{
						dfile.delete();
					}

				}// end of if
				bufWriterlog.write("=======================================================================");
				bufWriterlog.newLine();
				bufWriterlog.newLine();
			}//end of for loop
			
			bufWriterlog.close();
		}//end of try
		
		
		catch (Exception e) 
		{
			try
			{
				reader1.close();
			}
			catch(Exception ee)
			{
				ee.printStackTrace();
			}			
			log.error(e.getMessage());
			log.error("Error in RAMtoLAPS_REPORT105  :: "+hshValues);
			throw new EJBException("Error in RAMtoLAPS_REPORT105 "+e.getMessage());
		}
		
		finally 
		{
			try 
			{
				if (filereader1 != null) 
				{
					filereader1.close();
				}
				if (reader1 != null) 
				{
					reader1.close();
				}
				if (rs != null)
				{
					rs = null;
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in RAMtoLAPS_REPORT105 "+e.getMessage());
			}
		}
		
		hshmap.put("nofiles",new Integer(filecount).toString());
		hshmap.put("badfile",new Integer(badfile).toString());
		hshmap.put("goodfile",new Integer(goodfile).toString());
		hshmap.put("badrow",new Integer(rowcount).toString());
		hshmap.put("type","Importing REPORT 105 FROM IRB");
		hshmap.put("appno",appno);
		
		return hshmap;
		
	}	
	
	
	public HashMap RAMtoLAPS_REPORT_IRBID(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		
		ResultSet rs = null;	
		String strQuery="";
		ArrayList arrValues= new ArrayList();
		HashMap hshmap=new HashMap();
		
		FileReader filereader1 = null;
		BufferedReader reader1 = null;
		
		File selectfile =null;
		File movefile=null;
		String[] FILELIST = null;		
		
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		
		String str_Exception="$";
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String rootPath = "";
		String LOGFileName="";
		FileWriter flog=null;	
		String strDatafolder="Data\\";
		String FolderName = "CorporateReports\\";//map the folder as per your requirement
		String FolderName1="";
		
		try   
		{	
			if(new File(strIRBPath1).exists())
			{
				rootPath=strIRBPath1+ FolderName;
			}
			else if(new File(strIRBPath2).exists())
			{
				rootPath=strIRBPath2+ FolderName;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing 105 REPORT Flat File !!";
				throw new Exception(str_Exception);
			}
	
			selectfile = new File(rootPath+strDatafolder);
			LOGFileName=rootPath+"Log\\";
			
			if (!selectfile.exists())
				selectfile.mkdirs();
	
			FILELIST = selectfile.list();			

		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}
		
		String Path = "";
		String ReportNo="";
		//String Company_code="";
		String IRBCustid="";
		String Date="";
		String Time="";
		int intUpdatesize=0;
		String filenames="";
		String badFileName="";
		String strIRBID="";
		String appno="";
		//int CompanyCode=0;
		String filedata="";
		try 
		{
			appno= Helper.correctNull((String)hshValues.get("appno"));
			
			String strDate="";
			String strTime="";
			String strCompanyname="";
			
			
			sd = new SimpleDateFormat("ddMMyyyy");
			sdt = new SimpleDateFormat("HHmmss");
			
			strDate=sd.format(new Date());
			strTime=sdt.format(new Date());
			LOGFileName=LOGFileName+appno+"_"+strDate+"_"+strTime+".txt";
			
			flog = new FileWriter(LOGFileName);
			BufferedWriter bufWriterlog=new BufferedWriter(flog);
			
			
			
			strQuery=SQLParser.getSqlQuery("sel_comapp_irbid^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strIRBID=correctNull(rs.getString("comapp_irbid"));
				strCompanyname=correctNull(rs.getString("comapp_companyname"));
			}
			 /* FILE NAME FORMAT
			 * {PREFIX}105/106_COMPANYCODE(LAPSID)_APPLICATIONNO_ ddmmyyyy_hhmmss.txt
			 */
			if(!strIRBID.equals(""))
			{
				for (int filecounter = 0; filecounter < FILELIST.length; filecounter++)
				{
					int dflag = 0;
					filenames = FILELIST[filecounter];
					filecount=FILELIST.length;
					
					Path = rootPath +  strDatafolder+"\\" + filenames;
					
					badFileName = filenames;
					
					if (!new File(rootPath + strDatafolder+ "\\" + filenames).isFile())
						continue;
					// End of selecting file			
				
					filereader1 = new FileReader(Path);
					reader1 = new BufferedReader(filereader1);
					//ArrayList arrayList = new ArrayList();
					
					log.info(filenames);
					StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
					
					
					if(tokenizer1.hasMoreTokens()) 
					{
						ReportNo=correctNull((String)tokenizer1.nextToken()).trim();
						
						bufWriterlog.write("File Name :: "+filenames);
						bufWriterlog.newLine();
						bufWriterlog.write("Report Name ::  "+ReportNo);
						bufWriterlog.newLine();
						
						
						if(ReportNo.equalsIgnoreCase("ExecutiveSummary"))
						{
							bufWriterlog.write("It is not correct file so exiting");
							bufWriterlog.newLine();
							//break;
						}
						//Company_code=correctNull((String)tokenizer1.nextToken()).trim();
						IRBCustid=correctNull((String)tokenizer1.nextToken()).trim();
						Date=((String)tokenizer1.nextToken()).trim();
						Time=((String)tokenizer1.nextToken()).trim();
					}
					/*if(!Company_code.equalsIgnoreCase(""))
					{			
						CompanyCode=Integer.parseInt(Company_code);			
						Company_code=Integer.toString(CompanyCode);
					}*/
				
					bufWriterlog.write("Application Number ::  "+IRBCustid);
					bufWriterlog.newLine();
					
					if(ReportNo.equalsIgnoreCase("REPORT105") && IRBCustid.equalsIgnoreCase(strIRBID))
					{
					
						
						String strParameters[]={"BranchName","RegionName","CompanyName - CompanyCode(LAPSID)",
								"DateofFinalisation","LastRatedDate(BaseModel)","LastRating(BaseModel)",
								"LastScore(BaseModel)","LastGradeDefinition (BaseModel)","LastRatedDate(DynamicModel)",
								"LastRating (DynamicModel)","LastScore(DynamicModel)","LastGradeDefinition(DynamicModel)",
								"LastCombinedRating(DynamicModel)","CurrentRatingDate(BaseModel)",
								"CurrentRating(BaseModel)","CurrentScore(BaseModel)","CurrentGradeDefinition(BaseModel)",
								"CurrentRatingDate(DynamicModel)","CurrentRating(DynamicModel)","CurrentScore(DynamicModel)",
								"CurrentGradeDefinition(DynamicModel)","Current Combined Rating(DynamicModel)",
								"RatingRationale","RatingPoolRemarks"};
						/* FORMAT 105:
						 * BranchName~RegionName~CompanyName - CompanyCode(LAPSID)~
						 * DateofFinalisation~LastRatedDate(BaseModel)~
						 * LastRating(BaseModel)~LastScore(BaseModel)~
						 * LastGradeDefinition (BaseModel)~LastRatedDate(DynamicModel)~
						 * LastRating (DynamicModel)~LastScore(DynamicModel)~
						 * LastGradeDefinition(DynamicModel)~LastCombinedRating(DynamicModel)~ 
						 * CurrentRatingDate(BaseModel)~CurrentRating(BaseModel)~
						 * CurrentScore(BaseModel)~CurrentGradeDefinition(BaseModel)~
						 * CurrentRatingDate(DynamicModel)~CurrentRating(DynamicModel)~
						 * CurrentScore(DynamicModel)~CurrentGradeDefinition(DynamicModel)~
						 * Current Combined Rating(DynamicModel)~RatingRationale~RatingPoolRemarks 		
						 * Total : 24 items
						 */						
						
						while (true) 
						{
							String read = reader1.readLine();				
							if (read == null || read.equals("null"))
								break;
							if(filedata.equals(""))
							{
								filedata=read;
							}
							else
							{
								filedata=filedata+"<br>"+read;
							}
						}
						if(!filedata.equalsIgnoreCase(""))
						{
							//String strValues[] = read.split("~");
							String strValues[] = new String[24];
							//int TotalParametersinFile=0;
							try
							{
								int j=0;
								for(int l=0; l<24; l++)
								{
									int k=0;
									
									if(l==23)
									{
										k=filedata.length();
									}
									else
									{
										k=filedata.indexOf("~",j);
									}
									strValues[l]=filedata.substring(j,k);
									j=++k;
									if(filedata.length()==j && l<22)
									{
										bufWriterlog.write("Parameters Missing in LAS 105 Reports");
										bufWriterlog.newLine();
										moveFile(rootPath,"bad",filenames);
										str_Exception = str_Exception + "Error Occured While Importing File..!! Due to Insufficient Datas !!! ";
										throw new Exception(str_Exception);
									}
									if(l==2)
									{
										String strCompanyName[] = strValues[2].split("-");
										/*if(!strCompanyName[1].equals(strIRBID))
										{
											bufWriterlog.write("IRB Companycode differs");
											bufWriterlog.newLine();
											moveFile(rootPath,"bad",filenames);
											str_Exception = str_Exception + "Error Occured While Importing 105 REPORT Flat File..!! IRB Companycode differs !!! ";
											throw new Exception(str_Exception);
										}*/
										if(!strCompanyName[0].equals(strCompanyname))
										{
											bufWriterlog.write("Company name is different");
											bufWriterlog.newLine();
											moveFile(rootPath,"bad",filenames);
											str_Exception = str_Exception + "Error Occured While Importing ..!! Company name is different !!! ";
											throw new Exception(str_Exception);
										}
									}
									/*if(l==0)
									{
										if(!strValues[0].equals(hshValues.get("strOrgName")))
										{
											bufWriterlog.write("Branch Name is not matching");
											bufWriterlog.newLine();
											moveFile(rootPath,"bad",filenames);
											str_Exception = str_Exception + "Error Occured While Importing File..!! Branch Name is not matching !!! ";
											throw new Exception(str_Exception);
										}
									}*/
									log.info("File Length   : "+filedata.length()+"    readed value   :  "+j);
								}
							}
							catch(Exception e)
							{
								throw new EJBException(e.toString());
							}				
							/*
							 * If Application already exists in table RAMTOLAPS105 its first deleted and then
							 * inserted
							 * 
							 * else values are inserted directly into the table RAMTOLAPS105
							 * 
							 * PRIMARY KEY: Application Number
							 */
							if(rs!=null)
							{
								rs=null;
							}
							
							intUpdatesize =0;
							strQuery=SQLParser.getSqlQuery("getramrating105details^"+appno);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								bufWriterlog.write("Old datas are deleting ::  ");
								bufWriterlog.newLine();
								
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","delreport105");
								arrValues.add(appno);
								hshQuery.put("arrValues",arrValues);				
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							}			
							
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues=new HashMap();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","insreport105");
							arrValues.add(appno);
							for(int i=0;i<24;i++)
							{
								if(i==2)
								{
									String strCompanyName[] = strValues[i].split("-");
									arrValues.add(strCompanyName[0].trim());
									arrValues.add(strCompanyName[1].trim());
									bufWriterlog.write(strParameters[i]+"  ::  "+strValues[i]);
									bufWriterlog.newLine();
								}
								else
								{
									bufWriterlog.write(strParameters[i]+"  ::  "+strValues[i]);
									bufWriterlog.newLine();
									arrValues.add(strValues[i]);								
								}
							}					
							hshQuery.put("arrValues",arrValues);				
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
							dflag=1;
						}
					}	
					else if(ReportNo.equalsIgnoreCase("REPORT105"))
					{
						dflag=2;
					}
					else if(ReportNo.equalsIgnoreCase("ExecutiveSummary"))
					{
						dflag=2;
					}
					
					//Assigning Folder name bad and done folders.
					FolderName1="CorporateReports";
					
					
					//After success insertion Moving File to SuccessFolder
					if (dflag == 1)
					{
	
						++goodfile;
						movefile=new File(rootPath+"Done\\");
						
						if (!movefile.exists())
						{
							movefile.mkdir();
						}
						
						FileReader fr2 = new FileReader(Path);
						BufferedReader br2 = new BufferedReader(fr2);
	
						// Moving the Success file to succeeded folder....
						new File(rootPath +  "\\Done\\" + filenames);
						FileWriter fw2 = new FileWriter(rootPath + "\\Done\\" + filenames);
						BufferedWriter bw2 = new BufferedWriter(fw2);
	
						while (true)
						{
							String tempString = br2.readLine();
							if (tempString == null || tempString.equals("null"))
							{
								break;
							}
							bw2.write(tempString);
						}
	
						br2.close();
						bw2.close();
						fr2.close();
						fw2.close();
						filereader1.close();
						reader1.close();
					
						File dfile = new File(Path);
						if (dfile.exists())
						{
							if(!dfile.delete())
							{
								dfile.delete();
							}
							else
							{
								dfile.delete();
							}
						}
					}
	
					// Moving the bad file to Failed Folder
					if (dflag == 0)
					{
						++badfile;
						movefile=new File(rootPath+"Bad\\");
						
						if (!movefile.exists())
						{
							movefile.mkdir();
						}
						
						new File(rootPath + FolderName1 + "\\Bad\\" + filenames);
		
						FileWriter fw = new FileWriter(rootPath + FolderName1 + "\\Bad\\" + filenames);
						BufferedWriter bw = new BufferedWriter(fw);
						FileReader fr1 = new FileReader(Path);
						BufferedReader br1 = new BufferedReader(fr1);
		
						while (true)
						{
							String tempString = br1.readLine();
							if (tempString == null || tempString.equals("null"))
							{
								dflag = 0;
								break;
							}
							bw.write(tempString);
						}
		
						br1.close();
						bw.close();
						fr1.close();
						fw.close();
						filereader1.close();
						reader1.close();
						
						File dfile = new File(Path);
						if (dfile.exists())
						{
							dfile.delete();
						}
	
					}// end of if
					bufWriterlog.write("=======================================================================");
					bufWriterlog.newLine();
					bufWriterlog.newLine();
				}//end of for loop
			}
			bufWriterlog.close();
		}//end of try
		
		
		catch (Exception e) 
		{
			try
			{
				reader1.close();
			}
			catch(Exception ee)
			{
				ee.printStackTrace();
			}			
			log.error(e.getMessage());
			log.error("Error in RAMtoLAPS_REPORT105  :: "+hshValues);
			throw new EJBException("Error in RAMtoLAPS_REPORT105 "+e.getMessage());
		}
		
		finally 
		{
			try 
			{
				if (filereader1 != null) 
				{
					filereader1.close();
				}
				if (reader1 != null) 
				{
					reader1.close();
				}
				if (rs != null)
				{
					rs = null;
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in RAMtoLAPS_REPORT105 "+e.getMessage());
			}
		}
		
		hshmap.put("nofiles",new Integer(filecount).toString());
		hshmap.put("badfile",new Integer(badfile).toString());
		hshmap.put("goodfile",new Integer(goodfile).toString());
		hshmap.put("badrow",new Integer(rowcount).toString());
		hshmap.put("type","Importing REPORT 105 FROM IRB");
		hshmap.put("appno",appno);
		
		return hshmap;
		
	}
	
	private boolean moveFile(String strDir,String strFolder, String strFilename)
	{
		boolean boolresult=false;
		File movefile=null;
		
		try{
			String strDataPath=strDir+"Data"+File.separatorChar+strFilename;
			String strDestPath=strDir +File.separatorChar+strFolder+File.separatorChar+ strFilename;
			movefile=new File(strDir+strFolder);
			
			if (!movefile.exists())
			{
				movefile.mkdir();
			}
		
			FileWriter fw = new FileWriter(strDestPath);
			BufferedWriter bw = new BufferedWriter(fw);
			FileReader fr1 = new FileReader(strDataPath);
			BufferedReader br1 = new BufferedReader(fr1);

			while (true)
			{	
				String tempString = br1.readLine();
				if (tempString == null || tempString.equals("null"))
				{
					break;
				}
				bw.write(tempString);
			}
			
			br1.close();
			bw.close();
			fr1.close();
			fw.close();
			boolresult=true;
		
			File dfile = new File(strDataPath);
			if (dfile.exists())
			{
				dfile.delete();
			}
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in Moving the File :: "+ex.toString());
		}
		return boolresult;
	}
	
	/**
	 * @author :S.SATHYA MOORTHY
	 * @PURPOSE: SECTOR MASTER FOR INTERFACE
	 * 
	 * @param hashMap
	 * @throws Exception
	 */

	public HashMap ramtolaps_sectormaster(HashMap hashMap) 
	{

		String rootPath = "";
		String FolderName = "Masters\\Sector\\Data";
		String Path = "";
		String badFileName = "";
		HashMap hshReturn=new HashMap();
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;	
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String str_Exception="$";
		try{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1;
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
		}catch(Exception e)
		{
			
			throw new EJBException(e.toString());
		}
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{

			for (int i = 0; i < FILELIST.length; i++)
			{
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "\\" + filenames).isFile())
					continue;
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);
			

				while (true)
				{
						String read = br.readLine();
						if (read == null || read.equals("null"))
							break;
				
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
						String strValues[] = read.split("~");
												
						int k=strValues.length;
						++rowcount;
						
						if(k>=1)
						{
							if(strValues[0].equals(""))
							{
								dflag=0;
								break;
								
							}
							else
							{
								arrValues.add(strValues[0]);
							}
						}
												
						if(k>=2)
						{	
							if(strValues[1].equals(""))
							{ 
								dflag=0;
								break;
							}
							else 
								arrValues.add(strValues[1]);
         				}
						
						if(k>=3)
						{
							if(strValues[2].equals(""))
							{ 
								strValues[2]="n";
								arrValues.add(strValues[2]);
							}
							else arrValues.add(strValues[2]);
						}
						else
							arrValues.add("n");
						
						if(k>=4)
						{
							if(strValues[3].equals(""))
							{ 
								strValues[3]=" ";
								arrValues.add(strValues[3]);
							}
							else 
								arrValues.add(strValues[3]);
						}
						else
							arrValues.add("null");
							
						if(arrValues.size()==4)
						{
							//Delete
							
							ArrayList arr1=new ArrayList();
							arr1.add(strValues[0]);
							hshQuery.put("strQueryId", "ramtolaps_sectormaster_delete");
							hshQuery.put("arrValues", arr1);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");						
							
							//Insert 
							
							hshQuery.put("strQueryId", "ramtolaps_sectormaster");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
							dflag = 1;
						}
						else
						{
							dflag = 0;
							break;
						}
				}

				br.close();

				// After success insertion Moving File to SuccessFolder
				FolderName = "Masters/Sector";
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + FolderName + "\\Done");

					if (!movefile.exists())
					{
						movefile.mkdir();

					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
					new File(rootPath + FolderName + "\\Done\\" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Done\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + FolderName + "\\Bad");

					if (!movefile1.exists())
					{
						movefile1.mkdir();

					}

					new File(rootPath + FolderName + "\\Bad\\" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if
				

			}// end of for file selecting loop

			/**
			 * 
			 * END OF SELECTION CODING
			 */

		}
		catch (Exception e)
		{

			try
			{
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName + "\\Bad").exists())
					new File(rootPath + FolderName + "\\Bad").mkdirs();
				new File(rootPath + FolderName + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}

				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
			}

		}
		hshReturn.put("nofiles",new Integer(filecount).toString());
		hshReturn.put("goodfile",new Integer(goodfile).toString());
		hshReturn.put("badfile",new Integer(badfile).toString());
		hshReturn.put("badrow",new Integer(rowcount).toString());
		hshReturn.put("type","Importing SECTOR MASTER");
		return hshReturn;

	}

	/**
	 * @author S.SATHYA MOORTHY
	 * @PURPOSE: MARKET SEGMENT MASTER.
	 * 
	 */

	public HashMap ramtolaps_marketsegmentmaster(HashMap hashMap) 
	{

		String rootPath = "";
		String FolderName = "Masters\\Segment\\Data";
		String Path = "";
		String badFileName = "";
	    int filecount=0;
	    int goodfile=0;
	    int badfile=0;
	    int rowcount=0;
	    HashMap hshReturn=new HashMap();
	    
	    String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String str_Exception="$";
		try{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1;
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
		}catch(Exception e)
		{
			
			throw new EJBException(e.toString());
		}
		
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{

			for (int i = 0; i < FILELIST.length; i++)
			{
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "\\" + filenames).isFile())
					continue;
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);

				while (true)
				{
					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					String strValues[] = read.split("~");
					int j=0;
				
					if (strValues != null && strValues.length > 1)
					{
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
					
						++rowcount;
						
						for(j=0; j<strValues.length;j++)
							arrValues.add(strValues[j]);
						
						if(strValues[0].equals(""))
						{
								dflag=0;
								break;
						}			
																		
						if(strValues[1].equals(""))
						{ 
								dflag=0;
								break;
						}
						        							
							
						//DELETE
						ArrayList arr1=new ArrayList();
						arr1.add(strValues[0]);						
						hshQuery.put("strQueryId", "ramtolaps_marketsegmaster_delete");
						hshQuery.put("arrValues", arr1);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						//INSERT
						hshQuery=new HashMap();
						hshQueryValues=new HashMap();						
						hshQuery.put("strQueryId", "ramtolaps_marketsegmaster");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						dflag = 1;

					}
				}

				br.close();
				
				FolderName = "Masters/Segment";
				// After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + FolderName + "\\Done");

					if (!movefile.exists())
					{
						movefile.mkdir();

					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
					new File(rootPath + FolderName + "\\Done\\" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Done\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + FolderName + "\\Bad");

					if (!movefile1.exists())
					{
						movefile1.mkdir();

					}

					new File(rootPath + FolderName + "\\Bad\\" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if
				

			}// end of for file selecting loop

			/**
			 * 
			 * END OF SELECTION CODING
			 */

		}
		catch (Exception e)
		{

			try
			{
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName + "\\Bad").exists())
					new File(rootPath + FolderName + "\\Bad").mkdirs();
				new File(rootPath + FolderName + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}

				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
			}

		}
		
		hshReturn.put("nofiles",new Integer(filecount).toString());
		hshReturn.put("goodfile",new Integer(goodfile).toString());
		hshReturn.put("badfile",new Integer(badfile).toString());
		hshReturn.put("type","Importing MARKET SEGMENT MASTER");
		hshReturn.put("badrow",new Integer(rowcount).toString());
		return hshReturn;

	}

	/**
	 * @author S.SATHYA MOORTHY
	 * @PURPOSE: ASSET CLASS MASTER.
	 * 
	 */

	public HashMap ramtolaps_assetclassmaster(HashMap hashMap) 
	{

		String rootPath = "";
		String FolderName = "Masters\\Asset\\Data";
		String Path = "";
		String badFileName = "";
		HashMap hshReturn =new HashMap();
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;

		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String str_Exception="$";
		try{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1;
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
		}catch(Exception e)
		{
			
			throw new EJBException(e.toString());
		}
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{

			for (int i = 0; i < FILELIST.length; i++)
			{
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "\\" + filenames).isFile())
					continue;
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);

				while (true)
				{

					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					String strValues[] = read.split("~");
					int j=0;
					if (strValues!=null && strValues.length>0)
					{
							
						++rowcount;
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();

						for(j=0; j<strValues.length;j++)
							arrValues.add(strValues[j]);
						
						for(; j<9;j++)
							arrValues.add(null);
						
						if(strValues[0].equals(""))
						{
								dflag=0;
								break;
						}			
																		
						if(strValues[1].equals(""))
						{ 
								dflag=0;
								break;
						}
						        							
							
						//DELETE
						ArrayList arr1=new ArrayList();
						arr1.add(strValues[0]);						
						hshQuery.put("strQueryId", "ramtolaps_assetclassmaster_delete");
						hshQuery.put("arrValues", arr1);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						//INSERT
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						hshQuery.put("strQueryId", "ramtolaps_assetclassmaster");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						dflag = 1;

					}
				}

				br.close();
				
				FolderName = "\\Masters\\Asset";
				// After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + FolderName + "\\Done");

					if (!movefile.exists())
					{
						movefile.mkdir();

					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
					new File(rootPath + FolderName + "\\Done\\" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Done\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw.write(tempString);

					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + FolderName + "\\Bad");

					if (!movefile1.exists())
					{
						movefile1.mkdir();

					}

					new File(rootPath + FolderName + "\\Bad\\" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if

			}// end of for file selecting loop
			/**
			 * 
			 * END OF SELECTION CODING
			 */

		}
		catch (Exception e)
		{

			try
			{
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName + "\\Bad").exists())
					new File(rootPath + FolderName + "\\Bad").mkdirs();
				new File(rootPath + FolderName + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}

				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
			}

		}
		hshReturn.put("nofiles",new Integer(filecount).toString());
		hshReturn.put("badfile",new Integer(badfile).toString());
		hshReturn.put("goodfile",new Integer(goodfile).toString());
		hshReturn.put("type","Importing ASSET CLASSIFICATION MASTER");
		hshReturn.put("badrow",new Integer(rowcount).toString());
		return hshReturn;

	}

	/**
	 * @author S.SATHYA MOORTHY
	 * @PURPOSE: COUNTRY MASTER.
	 * 
	 */

	public HashMap ramtolaps_countrymaster(HashMap hashMap) 
	{

		String rootPath = "";
		String FolderName = "Masters\\Country\\Data";
		String Path = "";
		String badFileName = "";
		HashMap hshReturn =new HashMap();
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String str_Exception="$";
		try{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1;
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
		}catch(Exception e)
		{
			
			throw new EJBException(e.toString());
		}
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{

			for (int i = 0; i < FILELIST.length; i++)
			{
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "\\" + filenames).isFile())
					continue;
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);

				while (true)
				{

					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					//StringTokenizer tokenizer = new StringTokenizer(read, "~");
					String strValues[] = read.split("~");
					int j=0;

					if (strValues!=null && strValues.length>0)
					{
						++rowcount;
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
						
						for(j=0; j<strValues.length;j++)
							arrValues.add(strValues[j]);
						
						for(; j<5;j++)
							arrValues.add(null);
						
						if(strValues[0].equals(""))
						{
								dflag=0;
								break;
						}			
																		
						if(strValues[1].equals(""))
						{ 
								dflag=0;
								break;
						}
						        							
							
						//DELETE
						ArrayList arr1=new ArrayList();
						arr1.add(strValues[0]);						
						hshQuery.put("strQueryId", "ramtolaps_countrymaster_delete");
						hshQuery.put("arrValues", arr1);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						//INSERT
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();												
						hshQuery.put("strQueryId", "ramtolaps_countrymaster");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						dflag = 1;

					}
				}

				br.close();
				
				FolderName = "Masters\\Country";
				
				// After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + FolderName + "\\Done");

					if (!movefile.exists())
					{
						movefile.mkdir();

					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
					new File(rootPath + FolderName + "\\Done\\" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Done\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + FolderName + "\\Bad" );

					if (!movefile1.exists())
					{
						movefile1.mkdir();

					}

					new File(rootPath + FolderName + "\\Bad\\" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if

				
			}// end of for file selecting loop

			/**
			 * 
			 * END OF SELECTION CODING
			 */

		}
		catch (Exception e)
		{

			try
			{
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName + "\\Bad").exists())
					new File(rootPath + FolderName + "\\Bad").mkdirs();
				new File(rootPath + FolderName + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}

				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
			}

		}
		hshReturn.put("nofiles",new Integer(filecount).toString());
		hshReturn.put("badfile",new Integer(badfile).toString());
		hshReturn.put("goodfile",new Integer(goodfile).toString());
		hshReturn.put("badrow",new Integer(rowcount).toString());
		hshReturn.put("type","Importing COUNTRY MASTER");
		return hshReturn;
	}

	/**
	 * @author S.SATHYA MOORTHY
	 * @PURPOSE: COUNTRY MASTER.
	 * 
	 */

	public HashMap ramtolaps_RBIindustrymaster(HashMap hashMap) 
	{

		String rootPath = "";
		String FolderName = "Masters\\Ascrom\\Data";
		String Path = "";
		String badFileName = "";
		HashMap hshReturn=new HashMap();		
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;

		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String str_Exception="$";
		try{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1;
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
		}catch(Exception e)
		{
			
			throw new EJBException(e.toString());
		}
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{

			for (int i = 0; i < FILELIST.length; i++)
			{
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "\\" + filenames).isFile())
					continue;
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);

				while (true)
				{

					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					String strValues[] = read.split("~");
					
					if (strValues!=null && strValues.length>0)
					{

						++rowcount;
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
						
						arrValues.add((strValues.length>=1)?strValues[0]:null);
						arrValues.add((strValues.length>=2)?strValues[1]:null);
						arrValues.add(null); //In Datafile Deleted flag value  is not provided.  Hence null value.
						arrValues.add((strValues.length>=3)?strValues[2]:null);
						
						if(strValues[0].equals(""))
						{
								dflag=0;
								break;
						}			
																		
						if(strValues[1].equals(""))
						{ 
								dflag=0;
								break;
						}
						        							
							
						//DELETE
						ArrayList arr1=new ArrayList();
						arr1.add(strValues[0]);						
						hshQuery.put("strQueryId", "ramtolaps_RBIindustrymaster_delete");
						hshQuery.put("arrValues", arr1);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
						//INSERT
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();	
						hshQuery.put("strQueryId", "ramtolaps_RBIindustrymaster");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						dflag = 1;

					}
				}

				br.close();
				
				FolderName = "Masters\\Ascrom";
				// After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + FolderName + "\\Done");

					if (!movefile.exists())
					{
						movefile.mkdir();

					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
					new File(rootPath + FolderName + "\\Done\\" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Done\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + FolderName + "\\Bad");

					if (!movefile1.exists())
					{
						movefile1.mkdir();

					}

					new File(rootPath + FolderName + "\\Bad\\" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if
		

			}// end of for file selecting loop

			/**
			 * 
			 * END OF SELECTION CODING
			 */

		}
		catch (Exception e)
		{

			try
			{
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName + "\\Bad").exists())
					new File(rootPath + FolderName + "\\Bad").mkdirs();
				new File(rootPath + FolderName + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}

				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
			}

		}
		hshReturn.put("nofiles",new Integer(filecount).toString());
		hshReturn.put("badfile",new Integer(badfile).toString());
		hshReturn.put("goodfile",new Integer(goodfile).toString());
		hshReturn.put("badrow",new Integer(rowcount).toString());
		hshReturn.put("type","Importing RBI INDUSTRY MASTER");
		return hshReturn;
	}
	
	
	
	public HashMap ramtolaps_retailscoring(HashMap map) 
	{		
		HashMap hshmap=new HashMap();
	
		//String rootPath = ApplicationParams.getDRIVEURL();
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String rootPath="";
		String FolderName = "RetailReports\\Data";
		String FolderName1 = "";
		String Path = "";
		String badFileName = "";
		ResultSet rs=null;
		ResultSet rs1=null;
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		FileReader filereader = null;
		BufferedReader reader = null;
		//String Path1=rootPath+FolderName;
		File Directory = null;	
		String Exception_flag="false";
		try
		{				
		   /* if(new File(rootPath).exists())
		    {
				Directory = new File(Path1);		
					
				if (!Directory.exists())
				{
					Directory.mkdirs();
				}
		    }
		    else
		    {
		    	Exception_flag="true";
		    }*/
			
			log.info("FolderName::::---->  " + FolderName + "\n \n");
			log.info("strIRBPath1:::---->"+strIRBPath1+"\n \n");
			log.info("strIRBPath2:::---->"+strIRBPath2+"\n \n");
			if((new File(strIRBPath1)).exists())
            {
				rootPath=strIRBPath1;
				log.info("RootPath in IRBPath1  ::::---->  " + rootPath  + "\n \n");
				Path = rootPath + FolderName;
				log.info("Path::::------>" + Path  + "\n \n");
                Directory = new File(Path);
                if(!Directory.exists())
                {
                    Directory.mkdirs();
                }
            }
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2;
				log.info("RootPath in IRBPath2  ::::---->  " + rootPath  + "\n \n");
				Path = rootPath + FolderName;
				log.info("Path::::------>" + Path  + "\n \n");
                Directory = new File(Path);
                if(!Directory.exists())
                {
                    Directory.mkdirs();
                }
			}
			else
            {
                Exception_flag="true";
            }
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}
		String strappno = Helper.correctNull((String)map.get("appno"));
		/*if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("appno1"));
		}*/
		
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("strappno"));
		}
		
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		try
		{
			if(Exception_flag.equalsIgnoreCase("false"))
			{
				for (int i = 0; i < FILELIST.length; i++)
				{
					int dflag = 0;
					filecount=FILELIST.length;
					filenames = FILELIST[i];
					
					Path = rootPath + FolderName + "/" + filenames;
					badFileName = filenames;
					if (!new File(rootPath + FolderName + "/" + filenames).isFile())
						continue;
					
					
					// End of selecting file
	
					fr = new FileReader(Path);
					br = new BufferedReader(fr);
					String strQuery="";
					String ReportNo="";
					String Application_No="";
					String Date="";
					String Time="";	
					
					
					filereader = new FileReader(Path);
					reader = new BufferedReader(filereader);			
					StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
					
					while (tokenizer1.hasMoreTokens()) 
					{
						ReportNo=correctNull((String)tokenizer1.nextToken()).trim();
						Application_No=correctNull((String)tokenizer1.nextToken()).trim();
						Date=((String)tokenizer1.nextToken()).trim();
						Time=((String)tokenizer1.nextToken()).trim();
					}
					
					if(!Application_No.equalsIgnoreCase("") && strappno.equalsIgnoreCase(Application_No))
					{
						while(true)
						{
							String read = br.readLine();
							if (read == null || read.equals("null"))
								break;
		
							String strValues[] = read.split("~");
							int j=0;
						
						
							if (strValues!=null && strValues.length>0)
							{
								++rowcount;							
								ArrayList arrValues = new ArrayList();
								HashMap hshQuery = new HashMap();
								HashMap hshQueryValues = new HashMap();
	
								for(j=0; j<strValues.length;j++)
								{
									arrValues.add(strValues[j]);	
								}							
							    strQuery=SQLParser.getSqlQuery("ramtolaps_checkretailscoringselect^"+strValues[0]);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{								
									ArrayList arr=new ArrayList();								
									hshQuery.put("strQueryId", "ramtolaps_retailscoringdelete");
									arr.add(strValues[0]);
									hshQuery.put("arrValues", arr);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
														
									hshQuery.put("strQueryId", "ramtolaps_retailscoringinsert");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
									dflag = 1;
								}
								else
								{								
									hshQuery.put("strQueryId", "ramtolaps_retailscoringinsert");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
									dflag = 1;								
								}						
							}
						}
					
	
					br.close();
					
					FolderName1 = "RetailReports";
					// After success insertion Moving File to SuccessFolder
					if (dflag == 1)
					{
						++goodfile;
						File movefile = new File(rootPath + FolderName1 + "/Done");
	
						if (!movefile.exists())
						{
							movefile.mkdirs();
	
						}
						
						FileReader fr1 = new FileReader(Path);
						BufferedReader br1 = new BufferedReader(fr1);
	
						// Moving the Success file to succeeded folder....
							
							new File(rootPath + FolderName1 + "/Done/" + filenames);
							//if(!fx.exists())
							FileWriter fw = new FileWriter(rootPath + FolderName1 + "/Done/" + filenames);
							BufferedWriter bw = new BufferedWriter(fw);
							
								while (true)
								{
									String tempString = br1.readLine();
									if (tempString == null || tempString.equals("null"))
									{
										break;
									}
									bw.write(tempString);
									bw.newLine();
			
								}
							fr.close();
							br.close();
							filereader.close();
							reader.close();
							br1.close();
							bw.close();
							fr1.close();
							fw.close();
							File dfile = new File(Path);
							if (dfile.exists())
								dfile.delete();
						
					}
	
					// Moving the bad file to Failed Folder
					if (dflag == 0)
					{
						++badfile;
						File movefile1 = new File(rootPath + FolderName1 + "/Bad");
	
						if (!movefile1.exists())
						{
							movefile1.mkdirs();
	
						}
	
						new File(rootPath + FolderName1 + "/Bad/" + filenames);
						//if(!fx1.exists())throw new Exception("$ Cannot create the folder !plz check the access rights");
						FileWriter fw = new FileWriter(rootPath + FolderName1 + "/Bad/" + filenames);
						BufferedWriter bw = new BufferedWriter(fw);
						FileReader fr1 = new FileReader(Path);
						BufferedReader br1 = new BufferedReader(fr1);
	
						while (true)
						{
							String tempString = br1.readLine();
							if (tempString == null || tempString.equals("null"))
							{
								dflag = 0;
								break;
							}
							bw.write(tempString);
							bw.newLine();
	
						}
	
						fr.close();
						br.close();
						filereader.close();
						reader.close();
						br1.close();
						bw.close();
						fr1.close();
						fw.close();
						File dfile = new File(Path);
						if (dfile.exists())
							dfile.delete();
						
	
					}// end of if
				
				}	
				}// end of for file selecting loop
			}	
				
		}
		catch (Exception e)
		{

			try
			{
				br.close();
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				
				FileReader fr1 = new FileReader(rootPath + FolderName1 + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName1 + "/Bad").exists())
					new File(rootPath + FolderName1 + "/Bad").mkdirs();
				
				new File(rootPath + FolderName1 + "/Bad/" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName1 + "/Bad/" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);

				}
				fr.close();
				br.close();
				filereader.close();
				reader.close();
				br1.close();
				
				fr1.close();
				fw1.close();
				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
					
				}
				catch (Exception e1)
				{
					log.error("File Error" + e1.toString());
				}

			}
			catch (Exception exce)
			{
				log.error("File Error" + exce.toString());
			}

		}
		/*try
		{			
			hshRecord=(HashMap) EJBInvoker.executeStateLess("appraisal",map,"getloandetails");
		}
		catch (Exception e1)
		{
			Logger.log("Error in fetching Loan details from Appraisal Bean" + e1.toString());
		}*/
		
		hshmap.put("nofiles",new Integer(filecount).toString());
		hshmap.put("badfile",new Integer(badfile).toString());
		hshmap.put("goodfile",new Integer(goodfile).toString());
		hshmap.put("badrow",new Integer(rowcount).toString());
		hshmap.put("type","Importing RETAIL SCORING FROM IRB");
		hshmap.put("READSENT_FLAG",Exception_flag);
		
		return hshmap;
		
		
	}
	
	
	public HashMap ramtolaps_IRBRating(HashMap map) 
	{		
		HashMap hshmap=new HashMap();
	
		String rootPath = "";
		String FolderName = "CorporateReports\\";
		String strDataFolder="Data\\";
		String strBadFolder="Bad\\";
		String strDoneFolder="Done\\";
		String strLogFolder="Log\\";
		//String FolderName1 = "CorporateReports\\Data\\";
		String Path = "";
		String str_Exception="$";
		String badFileName = "", chkvalue="";
		ResultSet rs=null;
		ResultSet rs1=null;
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		FileReader filereader = null;
		BufferedReader reader = null;
		String[] FILELIST = null;
		String LOGFileName="";
		FileWriter flog=null;	
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		
		String strappno = Helper.correctNull((String)map.get("appno"));
		/*if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("appno1"));
		}*/
		
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("strappno"));
		}
		
		File selectfile = new File(rootPath + FolderName);
		try
		{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1+FolderName;
				//selectfile = new File(rootPath + FolderName);
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2+FolderName;
				//selectfile = new File(rootPath + FolderName);
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
			
			selectfile = new File(rootPath + strDataFolder);
			LOGFileName=rootPath+"Log\\";
			
			if (!selectfile.exists())
				selectfile.mkdirs();

			 FILELIST = selectfile.list();	
		}	
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}

		

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;
		ArrayList arrRow = null;
		ArrayList arrRow2 = null;
		ArrayList arrCol = null;
		ArrayList arrCol2 = null;

		try
		{

			String strDate="";
			String strTime="";
			
			sd = new SimpleDateFormat("ddMMyyyy");
			sdt = new SimpleDateFormat("HHmmss");
			
			strDate=sd.format(new Date());
			strTime=sdt.format(new Date());
			LOGFileName=LOGFileName+"ESlog"+strappno+"_"+strDate+"_"+strTime+".txt";
			
			flog = new FileWriter(LOGFileName);
			BufferedWriter bufWriterlog=new BufferedWriter(flog);
			
			for (int i = 0; i < FILELIST.length; i++)
			{
				arrRow = new ArrayList();
				arrRow2 = new ArrayList();
				chkvalue="";
				int dflag = 0;
				filecount=FILELIST.length;
				filenames = FILELIST[i];
				
				Path = rootPath + strDataFolder + "\\" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + strDataFolder + "\\" + filenames).isFile())
					continue;
				
				
				// End of selecting file

				fr = new FileReader(Path);
				br = new BufferedReader(fr);
				String ReportNo="",ReportName="",CompanyCode="";
				String Application_No="";
				String Date="";
				String Time="";	
				String modelflag="0";
				String repFlag="1";

				
				
				filereader = new FileReader(Path);
				reader = new BufferedReader(filereader);			
				StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
				
				while (tokenizer1.hasMoreTokens()) 
				{
					ReportName=correctNull((String)tokenizer1.nextToken()).trim();
					
					bufWriterlog.write(" File Name :: "+filenames);
					bufWriterlog.newLine();
					
					bufWriterlog.write(" Report Name :: "+ReportName);
					bufWriterlog.newLine();
					
					if(ReportName.equalsIgnoreCase("REPORT105"))
					{	
						bufWriterlog.write(" It is not correct text file so exit");
						bufWriterlog.newLine();
						repFlag="1";
						break;
					}
					ReportNo=correctNull((String)tokenizer1.nextToken()).trim();
					CompanyCode=correctNull((String)tokenizer1.nextToken()).trim();
					Application_No=correctNull((String)tokenizer1.nextToken()).trim();
					Date=((String)tokenizer1.nextToken()).trim();
					Time=((String)tokenizer1.nextToken()).trim();
					repFlag="0";
					
				}
				bufWriterlog.write(" Application Number :: "+Application_No);
				bufWriterlog.newLine();
				
				bufWriterlog.write(" ReportNo :: "+ ReportNo);
				bufWriterlog.newLine();
				
				if(!Application_No.equalsIgnoreCase("") && strappno.equalsIgnoreCase(Application_No) && repFlag.equalsIgnoreCase("0"))
				{
						if(ReportNo.equalsIgnoreCase("Model I") || ReportNo.equalsIgnoreCase("Model II") || ReportNo.equalsIgnoreCase("Model III") || ReportNo.equalsIgnoreCase("Union Trade Scheme I")
								|| ReportNo.equalsIgnoreCase("Union Trade Scheme II") || ReportNo.equalsIgnoreCase("UBI NBFC- Bank"))
						{	
							while(true)
							{
								modelflag="1";
								String read = br.readLine();
								if (read == null || read.equals("null"))
									break;
			
								//String strValues[] = read.split("~");
								String strValues[] = new String[3];
								int j=0;
								for(int l=0; l<3; l++)
								{
									int k=0;
									if(l==2)
									{
										k=read.length();
									}
									else
									{
										k=read.indexOf("~",j);
									}
									strValues[l]=read.substring(j,k);
									j=++k;
								}
								
								j=0;
							
							
								if (strValues!=null && strValues.length>0)
								{
									if(!strValues[0].equalsIgnoreCase(""))
									{										
										++rowcount;							
										arrCol = new ArrayList();
										
										for(j=0; j<strValues.length;j++)
										{
											arrCol.add(strValues[j]);	
										}	
										arrRow.add(arrCol);
									}
									else
									{
										chkvalue="false";
										break;
									}
									
								} 
							} 
						}
						
						if(ReportNo.equalsIgnoreCase("Model IV"))
						{	
							int x=0;
							String typeflag="";
							String score="";
							boolean rateflag=false;
							while(true)
							{
								modelflag="2";
								String read = br.readLine();
								if (read == null || read.equals("null"))
									break;
								//Logger.log("\n"+read);
								//read
								String strValues[] = new String[3];
								int j=0;
								for(int l=0; l<3; l++)
								{
									int k=0;
									if(l==2)
									{
										k=read.length();
									}
									else
									{
										k=read.indexOf("~",j);
									}
									strValues[l]=read.substring(j,k);
									j=++k;
								}
								
								//{,read.substring(5,7),read.substring(7,9)};//read.split("~");
								j=0;
								
							
							
								if (strValues!=null && strValues.length>0)
								{
									if(!strValues[0].equalsIgnoreCase(""))
									{
										
										++rowcount;							
										arrCol = new ArrayList();
										 arrCol2 = new ArrayList();
										
										for(j=0; j<strValues.length;j++)
										{
											if(strValues[j].equalsIgnoreCase("Rating of the Borrower") && rateflag)
											{
												x=j;
												typeflag="Y";
												break;
											}
											else
											{	
												if(!typeflag.equalsIgnoreCase("Y"))
												{
													if(strValues[j].equalsIgnoreCase("Rating of the Borrower"))
														rateflag=true;
													arrCol.add(strValues[j]);
												}												
											}
											
										}	
										if(typeflag.equalsIgnoreCase("Y") && !strValues[0].equalsIgnoreCase("Rating of the Borrower"))
										{
											for(j=x; j<strValues.length;j++)
											{
												arrCol2.add(strValues[j]);
												
												
											}
											if(!strValues[0].equalsIgnoreCase(""))
											{
												score=getMODEL4ScoreValue(strValues[0]);
												arrCol2.add(score);
											}
										}	
										arrRow.add(arrCol);
										
										arrRow2.add(arrCol2);
									}
									else
									{
										chkvalue="false";
										break;
									}
									
								} 
							} 
						}
			
					
				
					if(!chkvalue.equalsIgnoreCase("false") && modelflag.equals("1"))
					{
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
						ArrayList arrValues = new ArrayList();
						hshQuery.put("strQueryId", "del_IRBRating1");
						arrValues.add(strappno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						for(int r=0; r<arrRow.size(); r++)
						{
							arrValues = new ArrayList();
							arrCol = (ArrayList) arrRow.get(r);
							arrValues.add(strappno);
							arrValues.add(Integer.toString(r+1));
							arrValues.add(arrCol.get(0));
							arrValues.add(arrCol.get(1));
							arrValues.add(arrCol.get(2));
							
							bufWriterlog.write(arrCol.get(0) +" :: "+ arrCol.get(1)+"  :: "+arrCol.get(2));
							bufWriterlog.newLine(); 
							
							hshQuery.put("strQueryId", "ins_IRBRating1");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							dflag = 1;
						}
						
					}
					
					if(!chkvalue.equalsIgnoreCase("false") && modelflag.equals("2"))
					{
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();
						ArrayList arrValues = new ArrayList();
						arrCol = new ArrayList();
						arrCol2 = new ArrayList();
						
						hshQuery.put("strQueryId", "del_IRBRating1");
						arrValues.add(strappno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						for(int r=0; r<arrRow.size(); r++)
						{
							arrCol = (ArrayList) arrRow.get(r);
							if(arrCol!=null && arrCol.size()>0)
							{
								arrValues = new ArrayList();
								
								
								arrValues.add(strappno);
								arrValues.add(Integer.toString(r+1));
								arrValues.add(arrCol.get(0));
								arrValues.add(arrCol.get(1));
								arrValues.add(arrCol.get(2));
								
								bufWriterlog.write(arrCol.get(0) +" :: "+ arrCol.get(1)+"  :: "+arrCol.get(2));
								bufWriterlog.newLine(); 
								
								hshQuery.put("strQueryId", "ins_IRBRating1");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
								dflag = 1;
							}	
						}
						
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						arrValues = new ArrayList();
						
						hshQuery.put("strQueryId", "del_IRBRating2");
						arrValues.add(strappno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", "1");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						for(int r=0; r<arrRow2.size(); r++)
						{
							arrCol2 = (ArrayList) arrRow2.get(r);
							if(arrCol2!=null && arrCol2.size()>0)
							{
								arrValues = new ArrayList();
								
								
								arrValues.add(strappno);
								arrValues.add(Integer.toString(r+1));
								arrValues.add(arrCol2.get(0));
								arrValues.add(arrCol2.get(1));
								arrValues.add(arrCol2.get(2));
								arrValues.add(arrCol2.get(3));
								
								hshQuery.put("strQueryId", "ins_IRBRating2");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
								dflag = 1;
							}	
						}
						
					}
				br.close();
				
				//FolderName1 = "CorporateReports";
				// After success insertion Moving File to SuccessFolder
				if (dflag == 1)
				{
					++goodfile;
					File movefile = new File(rootPath + strDoneFolder);

					if (!movefile.exists())
					{
						movefile.mkdirs();

					}
					
					bufWriterlog.write(" Moving to Done Folder");
					bufWriterlog.newLine();
					
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to succeeded folder....
						
						new File(rootPath + strDoneFolder + filenames);
						//if(!fx.exists())
						FileWriter fw = new FileWriter(rootPath + strDoneFolder+ filenames);
						BufferedWriter bw = new BufferedWriter(fw);
						
							while (true)
							{
								String tempString = br1.readLine();
								if (tempString == null || tempString.equals("null"))
								{
									break;
								}
								bw.write(tempString);
								bw.newLine();
		
							}
						fr.close();
						br.close();
						filereader.close();
						reader.close();
						br1.close();
						bw.close();
						fr1.close();
						fw.close();
						File dfile = new File(Path);
						if (dfile.exists())
							dfile.delete();
					
				}

				// Moving the bad file to Failed Folder
				if (dflag == 0)
				{
					++badfile;
					File movefile1 = new File(rootPath + strBadFolder);

					if (!movefile1.exists())
					{
						movefile1.mkdirs();
					}

					bufWriterlog.write(" Moving to Bad Folder");
					bufWriterlog.newLine();
					
					new File(rootPath + strBadFolder + filenames);
					//if(!fx1.exists())throw new Exception("$ Cannot create the folder !plz check the access rights");
					FileWriter fw = new FileWriter(rootPath + strBadFolder + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true)
					{
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null"))
						{
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					fr.close();br.close();
					filereader.close();reader.close();
					br1.close();bw.close();fr1.close();fw.close();					
					fw.flush();bw.flush();
					
					File dfile = new File(Path);
					
					if (dfile.exists())
						dfile.delete();
					

				}// end of if
				bufWriterlog.write("====================================================");
				bufWriterlog.newLine();
			}	
				bufWriterlog.write("====================================================");
				bufWriterlog.newLine();	
			}// end of for file selecting loop
			bufWriterlog.close();
			
		}
		catch (Exception e)
		{

			try
			{
				br.close();
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				
				/*FileReader fr1 = new FileReader(rootPath + FolderName1 + filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				FolderName1 = "CorporateReports";
				if (!new File(rootPath + FolderName1 + "\\Bad").exists())
					new File(rootPath + FolderName1 + "\\Bad").mkdirs();
				
				new File(rootPath + FolderName1 + "\\Bad\\" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName1 + "\\Bad\\" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true)
				{
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null"))
					{
						break;
					}
					bw1.write(tempString);
					bw1.newLine();

				}
				fr.close();
				br.close();
				filereader.close();
				reader.close();
				br1.close();
				
				fr1.close();
				fw1.close();
				fr1.close();
				bw1.close();
				try
				{
					if (new File(Path).exists())
						new File(Path).delete();
					
				}
				catch (Exception e1)
				{
					Logger.log("File Error" + e1.toString());
				}*/

			}
			catch (Exception exce)
			{
				log.error("File Error" + exce.toString());
			}

		}
		
		hshmap.put("nofiles",new Integer(filecount).toString());
		hshmap.put("badfile",new Integer(badfile).toString());
		hshmap.put("goodfile",new Integer(goodfile).toString());
		hshmap.put("badrow",new Integer(rowcount).toString());
		hshmap.put("type","Importing IRB RATING FROM IRB");
		
		return hshmap;
		
		
	}
	
	public HashMap ramtolaps_IRBRating_IRBID(HashMap map) 
	{		
		HashMap hshmap=new HashMap();
	
		String rootPath = "";
		String FolderName = "CorporateReports\\";
		String strDataFolder="Data\\";
		String strBadFolder="Bad\\";
		String strDoneFolder="Done\\";
		String strLogFolder="Log\\";
		String irbcustid="";
		String strIRBID="";
		//String FolderName1 = "CorporateReports\\Data\\";
		String Path = "";
		String str_Exception="$";
		String badFileName = "", chkvalue="";
		ResultSet rs=null;
		ResultSet rs1=null;
		int filecount=0;
		int goodfile=0;
		int badfile=0;
		int rowcount=0;
		FileReader filereader = null;
		BufferedReader reader = null;
		String[] FILELIST = null;
		String LOGFileName="";
		FileWriter flog=null;	
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		
		String strappno = Helper.correctNull((String)map.get("appno"));
		/*if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("appno1"));
		}*/
		
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)map.get("strappno"));
		}
		
		File selectfile = new File(rootPath + FolderName);
		try
		{
			if((new File(strIRBPath1)).exists())
			{
				rootPath=strIRBPath1+FolderName;
				//selectfile = new File(rootPath + FolderName);
			}
			else if((new File(strIRBPath2)).exists())
			{
				rootPath=strIRBPath2+FolderName;
				//selectfile = new File(rootPath + FolderName);
			}
			else
			{
				str_Exception = str_Exception + "Network Connectivity Error Occured While Importing IRBRating Flat File !!";
				throw new Exception(str_Exception);
			}
			
			selectfile = new File(rootPath + strDataFolder);
			LOGFileName=rootPath+"Log\\";
			
			if (!selectfile.exists())
				selectfile.mkdirs();

			 FILELIST = selectfile.list();	
		}	
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}

		

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;
		ArrayList arrRow = null;
		ArrayList arrRow2 = null;
		ArrayList arrCol = null;
		ArrayList arrCol2 = null;

		try
		{

			String strDate="";
			String strTime="";
			String strQuery="";
			sd = new SimpleDateFormat("ddMMyyyy");
			sdt = new SimpleDateFormat("HHmmss");
			
			strDate=sd.format(new Date());
			strTime=sdt.format(new Date());
			LOGFileName=LOGFileName+"ESlog"+strappno+"_"+strDate+"_"+strTime+".txt";
			
			flog = new FileWriter(LOGFileName);
			BufferedWriter bufWriterlog=new BufferedWriter(flog);
			
			
			strQuery=SQLParser.getSqlQuery("sel_comapp_irbid^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strIRBID=correctNull(rs.getString("comapp_irbid"));
			}
			if(!strIRBID.equals(""))
			{
				boolean recordflag=false;
				strQuery=SQLParser.getSqlQuery("getramrating105details^"+strappno);
				rs = DBUtils.executeQuery(strQuery);
				recordflag=rs.next();
				if(recordflag)
				{
					for (int i = 0; i < FILELIST.length; i++)
					{
						arrRow = new ArrayList();
						arrRow2 = new ArrayList();
						chkvalue="";
						int dflag = 0;
						filecount=FILELIST.length;
						filenames = FILELIST[i];
						
						Path = rootPath + strDataFolder + "\\" + filenames;
						badFileName = filenames;
						if (!new File(rootPath + strDataFolder + "\\" + filenames).isFile())
							continue;
						
						
						// End of selecting file
		
						fr = new FileReader(Path);
						br = new BufferedReader(fr);
						String ReportNo="",ReportName="";//,CompanyCode="";
						//String Application_No="";
						String Date="";
						String Time="";	
						String modelflag="0";
						String repFlag="1";
		
						
						
						filereader = new FileReader(Path);
						reader = new BufferedReader(filereader);	
						log.info(filenames);
						StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
						
						if (tokenizer1.hasMoreTokens()) 
						{
							ReportName=correctNull((String)tokenizer1.nextToken()).trim();
							
							bufWriterlog.write(" File Name :: "+filenames);
							bufWriterlog.newLine();
							
							bufWriterlog.write(" Report Name :: "+ReportName);
							bufWriterlog.newLine();
							
							if(ReportName.equalsIgnoreCase("REPORT105"))
							{	
								bufWriterlog.write(" It is not correct text file so exit");
								bufWriterlog.newLine();
								repFlag="2";
								//break;
							}
							if(repFlag.equalsIgnoreCase("1"))
							{
								ReportNo=correctNull((String)tokenizer1.nextToken()).trim();
								//CompanyCode=correctNull((String)tokenizer1.nextToken()).trim();
								irbcustid=correctNull((String)tokenizer1.nextToken()).trim();
								Date=((String)tokenizer1.nextToken()).trim();
								Time=((String)tokenizer1.nextToken()).trim();
								//bufWriterlog.write()
								repFlag="0";
							}
						}
						bufWriterlog.write(" Application Number :: "+irbcustid);
						bufWriterlog.newLine();
						
						bufWriterlog.write(" ReportNo :: "+ ReportNo);
						bufWriterlog.newLine();
						
						if(!irbcustid.equalsIgnoreCase("") && strIRBID.equalsIgnoreCase(irbcustid) && repFlag.equalsIgnoreCase("0"))
						{
								if(ReportNo.equalsIgnoreCase("Model I") || ReportNo.equalsIgnoreCase("Model II") || ReportNo.equalsIgnoreCase("Model III") || ReportNo.equalsIgnoreCase("Union Trade Scheme I")
										|| ReportNo.equalsIgnoreCase("Union Trade Scheme II") || ReportNo.equalsIgnoreCase("UBI NBFC- Bank"))
								{	
									while(true)
									{
										modelflag="1";
										String read = br.readLine();
										if (read == null || read.equals("null"))
											break;
					
										//String strValues[] = read.split("~");
										String strValues[] = new String[3];
										int j=0;
										for(int l=0; l<3; l++)
										{
											int k=0;
											if(l==2)
											{
												k=read.length();
											}
											else
											{
												k=read.indexOf("~",j);
											}
											strValues[l]=read.substring(j,k);
											j=++k;
										}
										
										j=0;
									
									
										if (strValues!=null && strValues.length>0)
										{
											if(!strValues[0].equalsIgnoreCase(""))
											{										
												++rowcount;							
												arrCol = new ArrayList();
												
												for(j=0; j<strValues.length;j++)
												{
													arrCol.add(strValues[j]);	
												}	
												arrRow.add(arrCol);
											}
											else
											{
												chkvalue="false";
												break;
											}
											
										} 
									} 
								}
								
								if(ReportNo.equalsIgnoreCase("Model IV"))
								{	
									int x=0;
									String typeflag="";
									String score="";
									boolean rateflag=false;
									while(true)
									{
										modelflag="2";
										String read = br.readLine();
										if (read == null || read.equals("null"))
											break;
										//Logger.log("\n"+read);
										//read
										String strValues[] = new String[3];
										int j=0;
										for(int l=0; l<3; l++)
										{
											int k=0;
											if(l==2)
											{
												k=read.length();
											}
											else
											{
												k=read.indexOf("~",j);
											}
											strValues[l]=read.substring(j,k);
											j=++k;
										}
										
										j=0;
										
									
									
										if (strValues!=null && strValues.length>0)
										{
											if(!strValues[0].equalsIgnoreCase(""))
											{
												
												++rowcount;							
												arrCol = new ArrayList();
												 arrCol2 = new ArrayList();
												
												for(j=0; j<strValues.length;j++)
												{
													if(strValues[j].equalsIgnoreCase("Rating of the Borrower") && rateflag)
													{
														x=j;
														typeflag="Y";
														break;
													}
													else
													{	
														if(!typeflag.equalsIgnoreCase("Y"))
														{
															if(strValues[j].equalsIgnoreCase("Rating of the Borrower"))
																rateflag=true;
															arrCol.add(strValues[j]);
														}												
													}
													
												}	
												if(typeflag.equalsIgnoreCase("Y") && !strValues[0].equalsIgnoreCase("Rating of the Borrower"))
												{
													for(j=x; j<strValues.length;j++)
													{
														arrCol2.add(strValues[j]);
														
														
													}
													if(!strValues[0].equalsIgnoreCase(""))
													{
														score=getMODEL4ScoreValue(strValues[0]);
														arrCol2.add(score);
													}
												}	
												arrRow.add(arrCol);
												
												arrRow2.add(arrCol2);
											}
											else
											{
												chkvalue="false";
												break;
											}
											
										} 
									} 
								}
					
							
						
							if(!chkvalue.equalsIgnoreCase("false") && modelflag.equals("1"))
							{
								HashMap hshQuery = new HashMap();
								HashMap hshQueryValues = new HashMap();
								ArrayList arrValues = new ArrayList();
								hshQuery.put("strQueryId", "del_IRBRating1");
								arrValues.add(strappno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
								for(int r=0; r<arrRow.size(); r++)
								{
									arrValues = new ArrayList();
									arrCol = (ArrayList) arrRow.get(r);
									arrValues.add(strappno);
									arrValues.add(Integer.toString(r+1));
									arrValues.add(arrCol.get(0));
									arrValues.add(arrCol.get(1));
									arrValues.add(arrCol.get(2));
									
									bufWriterlog.write(arrCol.get(0) +" :: "+ arrCol.get(1)+"  :: "+arrCol.get(2));
									bufWriterlog.newLine(); 
									
									hshQuery.put("strQueryId", "ins_IRBRating1");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "1");
									hshQueryValues.put("1", hshQuery);
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
									dflag = 1;
								}
								
							}
							
							if(!chkvalue.equalsIgnoreCase("false") && modelflag.equals("2"))
							{
								HashMap hshQuery = new HashMap();
								HashMap hshQueryValues = new HashMap();
								ArrayList arrValues = new ArrayList();
								arrCol = new ArrayList();
								arrCol2 = new ArrayList();
								
								hshQuery.put("strQueryId", "del_IRBRating1");
								arrValues.add(strappno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
								for(int r=0; r<arrRow.size(); r++)
								{
									arrCol = (ArrayList) arrRow.get(r);
									if(arrCol!=null && arrCol.size()>0)
									{
										arrValues = new ArrayList();
										
										
										arrValues.add(strappno);
										arrValues.add(Integer.toString(r+1));
										arrValues.add(arrCol.get(0));
										arrValues.add(arrCol.get(1));
										arrValues.add(arrCol.get(2));
										
										bufWriterlog.write(arrCol.get(0) +" :: "+ arrCol.get(1)+"  :: "+arrCol.get(2));
										bufWriterlog.newLine(); 
										
										hshQuery.put("strQueryId", "ins_IRBRating1");
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size", "1");
										hshQueryValues.put("1", hshQuery);
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
										dflag = 1;
									}	
								}
								
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								arrValues = new ArrayList();
								
								hshQuery.put("strQueryId", "del_IRBRating2");
								arrValues.add(strappno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
								for(int r=0; r<arrRow2.size(); r++)
								{
									arrCol2 = (ArrayList) arrRow2.get(r);
									if(arrCol2!=null && arrCol2.size()>0)
									{
										arrValues = new ArrayList();
										
										
										arrValues.add(strappno);
										arrValues.add(Integer.toString(r+1));
										arrValues.add(arrCol2.get(0));
										arrValues.add(arrCol2.get(1));
										arrValues.add(arrCol2.get(2));
										arrValues.add(arrCol2.get(3));
										
										hshQuery.put("strQueryId", "ins_IRBRating2");
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size", "1");
										hshQueryValues.put("1", hshQuery);
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
										dflag = 1;
									}	
								}
								
							}
						br.close();
						
						//FolderName1 = "CorporateReports";
						// After success insertion Moving File to SuccessFolder
						if (dflag == 1)
						{
							++goodfile;
							File movefile = new File(rootPath + strDoneFolder);
		
							if (!movefile.exists())
							{
								movefile.mkdirs();
		
							}
							
							bufWriterlog.write(" Moving to Done Folder");
							bufWriterlog.newLine();
							
							FileReader fr1 = new FileReader(Path);
							BufferedReader br1 = new BufferedReader(fr1);
		
							// Moving the Success file to succeeded folder....
								
								new File(rootPath + strDoneFolder + filenames);
								//if(!fx.exists())
								FileWriter fw = new FileWriter(rootPath + strDoneFolder+ filenames);
								BufferedWriter bw = new BufferedWriter(fw);
								
									while (true)
									{
										String tempString = br1.readLine();
										if (tempString == null || tempString.equals("null"))
										{
											break;
										}
										bw.write(tempString);
										bw.newLine();
				
									}
								fr.close();
								br.close();
								filereader.close();
								reader.close();
								br1.close();
								bw.close();
								fr1.close();
								fw.close();
								File dfile = new File(Path);
								if (dfile.exists())
									dfile.delete();
							
						}
		
						// Moving the bad file to Failed Folder
						if (dflag == 0)
						{
							++badfile;
							File movefile1 = new File(rootPath + strBadFolder);
		
							if (!movefile1.exists())
							{
								movefile1.mkdirs();
							}
		
							bufWriterlog.write(" Moving to Bad Folder");
							bufWriterlog.newLine();
							
							new File(rootPath + strBadFolder + filenames);
							//if(!fx1.exists())throw new Exception("$ Cannot create the folder !plz check the access rights");
							FileWriter fw = new FileWriter(rootPath + strBadFolder + filenames);
							BufferedWriter bw = new BufferedWriter(fw);
							FileReader fr1 = new FileReader(Path);
							BufferedReader br1 = new BufferedReader(fr1);
		
							while (true)
							{
								String tempString = br1.readLine();
								if (tempString == null || tempString.equals("null"))
								{
									dflag = 0;
									break;
								}
								bw.write(tempString);
								bw.newLine();
		
							}
		
							fr.close();br.close();
							filereader.close();reader.close();
							br1.close();bw.close();fr1.close();fw.close();					
							fw.flush();bw.flush();
							
							File dfile = new File(Path);
							
							if (dfile.exists())
								dfile.delete();
							
		
						}// end of if
						bufWriterlog.write("====================================================");
						bufWriterlog.newLine();
					}	
						bufWriterlog.write("====================================================");
						bufWriterlog.newLine();	
					}// end of for file selecting loop
				}//recordflag
				else
				{
					bufWriterlog.write(" 105 not uploaded ");
					bufWriterlog.newLine();
					String strExp="$";
					strExp=strExp+"First IMPORT RATING DETAILS";
					throw new Exception(strExp);
				}
			}
			bufWriterlog.close();
			
		}
		catch (Exception e)
		{

			try
			{
				br.close();
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
			}
			catch (Exception exce)
			{
				log.error("File Error" + exce.toString());
			}
			throw new EJBException("========================>"+e.toString());
		}
		
		hshmap.put("nofiles",new Integer(filecount).toString());
		hshmap.put("badfile",new Integer(badfile).toString());
		hshmap.put("goodfile",new Integer(goodfile).toString());
		hshmap.put("badrow",new Integer(rowcount).toString());
		hshmap.put("type","Importing IRB RATING FROM IRB");
		
		return hshmap;
		
		
	}



	private String getMODEL4ScoreValue(String string)
	{		
		String value="";
		if(string.equals("Financial Risk"))
		{
			value="";
		}
		if(string.equals("Debt Equity Ratio"))
		{
			value="3";
		}
		if(string.equals("Ratio of Total Outside Liability to Tangible Networth"))
		{
			value="3";
		}
		if(string.equals("Current Ratio-Liquidity ratio"))
		{
			value="5";
		}
		if(string.equals("Return on Capital Employed"))
		{
			value="4";
		}
		if(string.equals("Net Sales- Sales V/s Actual Projections"))
		{
			value="3";
		}
		if(string.equals("Interest Service Coverage Ratio"))
		{
			value="3";
		}
		if(string.equals("Debt Service Coverage Ratio"))
		{
			value="3";
		}
		if(string.equals("Growth in Net sales"))
		{
			value="3";
		}
		if(string.equals("Growth in Net Profit"))
		{
			value="3";
		}
		
		if(string.equals("Cash Flow related parameters"))
		{
			value="";
		}
		
		if(string.equals("Net Cash from Operations to sales"))
		{
			value="3";
		}
		if(string.equals("Net Cash from operations to Long Term Debts"))
		{
			value="3";
		}
		
		if(string.equals("Management Risk"))
		{
			value="";
		}
		
		if(string.equals("Experience of the management personnel in the industry"))
		{
			value="3";
		}
		
		if(string.equals("Management Initiatives"))
		{
			value="2";
		}
		
		if(string.equals("Honouring Financial Commitments"))
		{
			value="3";
		}
		
		if(string.equals("Concentration of Management"))
		{
			value="2";
		}
		
		if(string.equals("Labour Management in the past"))
		{
			value="2";
		}
		
		if(string.equals("Affiliate Concerns Performance"))
		{
			value="2";
		}
		
		if(string.equals("Market Reputation of the Promoters/Management"))
		{
			value="2";
		}
		
		if(string.equals("Support from Promoters/Management"))
		{
			value="1";
		}
		
		if(string.equals("Succession Planning in key business areas"))
		{
			value="1";
		}
		
		if(string.equals("Balance Sheet Practices"))
		{
			value="2";
		}
		
		if(string.equals("Statutory Compliance"))
		{
			value="2";
		}
		
		if(string.equals("Market-Industry Risk"))
		{
			value="";
		}
		
		if(string.equals("Market Potential/Demand Situation"))
		{
			value="2";
		}
		
		if(string.equals("Diversification among different Consumer segments"))
		{
			value="2";
		}
		
		if(string.equals("Competitive Situation"))
		{
			value="3";
		}
		
		if(string.equals("Inputs / Raw materials availability"))
		{
			value="2";
		}
		
		if(string.equals("Locational Issues"))
		{
			value="2";
		}
		
		if(string.equals("Technology (T.O. findings)"))
		{
			value="2";
		}
		
		if(string.equals("Manufacturing efficiency / Capacity Utilisation"))
		{
			value="3";
		}
		
		if(string.equals("Cyclicality / Seasonality"))
		{
			value="2";
		}
		if(string.equals("Rating of the Facility"))
		{
			value="";
		}
		
		if(string.equals("Compliance of Sanction Terms"))
		{
			value="2";
		}
		if(string.equals("Submission of Stock Statements/QPR"))
		{
			value="2";
		}
		if(string.equals("Submission of BS & P/L  A/c & Financial Data in CMA forms"))
		{
			value="2";
		}
		
		if(string.equals("Repayment Schedule for Term Loans only"))
		{
			value="2";
		}
		
		if(string.equals("Operations in the Account-Turnover"))
		{
			value="3";
		}
		
		if(string.equals("Operations in the Account-Excess over limits"))
		{
			value="3";
		}
		
		if(string.equals("Commitments under DGPL/TL & payment of Interest on CC/OD"))
		{
			value="3";
		}
		
		if(string.equals("Margin given on Term Loan"))
		{
			value="3";
		}
		
		if(string.equals("Business Considerations"))
		{
			value="";
		}
		if(string.equals("Length of Relationship"))
		{
			value="2";
		}
		if(string.equals("Income Value to the Bank"))
		{
			value="2";
		}
		return value;
	}

}// End of Class




// PART FROM RAMtoLAPS_REPORT Method
//else if(ReportNo.equalsIgnoreCase("REPORT106") && Application_No.equalsIgnoreCase(appno))
//{
//		
//	/* FORMAT:
//	 * BranchName~ CompanyName-CompanyCode(LAPSID)~ DateofFinalisation~
//	 * Credit Rating by Rating Pool~Rating Pool Date~Rating Confirmed by CG~
//	 * CG Rating~CGRationale~
//	 * Risk Pricing based on rating[Multiple FacilityNames and Interest Rate seperated by hash(#)]~
//	 * Rating Review~CG Observations		
//	 * 
//	 * Total : 12 items
//	 */						
//	
//	
//	/* SAMPLE DATA:
//	 * 
//	 * Chakala~
//	 * TEST SME~
//	 * 000202~
//	 * 27/06/2007~
//	 * UBI 5~
//	 * 27/06/2007~
//	 * Y~
//	 * UBI 5~
//	 * Years of experience in the business needs to be captured in the scoring.~
//	 * Book Debts#14.50#Foreign Bills Purchased#15.00~
//	 * some factors need to be captured.~
//	 * company has received decent rating.				 *
//	 * 
//	 */
//	
//	
//	while (true) 
//	{					
//		String read = reader1.readLine();
//		if (read == null || read.equals("null"))
//			break;
//		
//		String strValues[] = read.split("~");
//		int TotalParametersinFile=0;
//		
//		try
//		{
//			TotalParametersinFile=strValues.length;
//			
//			str_Exception="$";
//			
//			if(TotalParametersinFile<=8)
//			{
//				str_Exception = str_Exception + "Error Occured While Importing 106 REPORT Flat File.. Risk Pricing based on Rating for Facilities not available in Flat File";
//				throw new Exception(str_Exception);
//			}
//		}
//		catch(Exception e)
//		{
//			throw new EJBException(e.toString());
//			
//		}
//		
//		
//		if (read == null || read.equals("null"))
//			break;
//		
//		if (true) 
//		{
//			hmap = new HashMap();
//			
//			hmap.put("BranchName",strValues[0].trim());					
//			CompanyName=strValues[1].trim();
//			
//			StringTokenizer tokenizer3 = new StringTokenizer(CompanyName, "-");
//			while (tokenizer3.hasMoreTokens()) 
//			{
//				hmap.put("CompanyName",((String) tokenizer3.nextToken()).trim());
//				hmap.put("CompanyCode",((String) tokenizer3.nextToken()).trim());
//			}	
//			
//			hmap.put("DateofFinalisation",strValues[2].trim());
//			hmap.put("CreditRatingbyRatingPool",strValues[3].trim());
//			hmap.put("RatingPoolDate",strValues[4].trim());
//			hmap.put("RatingConfirmedbyCG",strValues[5].trim());
//			hmap.put("CGRating",strValues[6].trim());
//			hmap.put("CGRationale",strValues[7].trim());						
//			RiskPricing=strValues[8].trim();
//			if(TotalParametersinFile == 9)
//			{
//				hmap.put("RatingReview","");
//				hmap.put("CGObservations","");
//			}
//			else if(TotalParametersinFile == 10)
//			{
//				hmap.put("RatingReview",strValues[9].trim());
//				hmap.put("CGObservations","");
//			}
//			else if(TotalParametersinFile == 11)
//			{
//				hmap.put("RatingReview",strValues[9].trim());
//				hmap.put("CGObservations",strValues[10].trim());
//			}
//			arrayList.add(hmap);	
//			
//		}	
//		
//		StringTokenizer tokenizer2 = new StringTokenizer(RiskPricing, "#");
//		while (tokenizer2.hasMoreTokens()) 
//		{
//			arrayFacility.add(((String) tokenizer2.nextToken()).trim());
//			arrayInterest.add(((String) tokenizer2.nextToken()).trim());
//		}
//		
//		 /*
//		  * If Application already exists in table RAMTOLAPS106 its first deleted and then
//		  * inserted
//		  * 
//		  * else values are inserted directly into the table RAMTOLAPS106
//		  * 
//		  * PRIMARY KEY: Application Number
//		  */
//		
//		if(rs!=null)
//		{
//			rs=null;
//		}
//		
//		if(!Application_No.equalsIgnoreCase(""))
//		{
//			intUpdatesize =0;
//			strQuery=SQLParser.getSqlQuery("ramtolaps_report106^"+Application_No);
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				hshQuery = new HashMap();
//				arrValues=new ArrayList();
//				intUpdatesize = intUpdatesize+1;
//				hshQuery.put("strQueryId","delreport106");
//				arrValues.add(Application_No);
//				hshQuery.put("arrValues",arrValues);				
//				hshQueryValues.put("size",Integer.toString(intUpdatesize));
//				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
//			}			
//			
//				arrsize=arrayFacility.size();
//				
//				for(int i=0;i<arrsize;i++)
//				{	
//					FacilityName="";
//					FacilitySchemeCode="";
//					FacilityParent="";
//					FacilityID="";
//					
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize = intUpdatesize+1;
//					hshQuery.put("strQueryId","insreport106");
//					arrValues.add(Application_No);
//					arrValues.add(Integer.toString(i+1));
//					arrValues.add(hmap.get("BranchName"));										
//					arrValues.add(hmap.get("CompanyName"));
//					if(!Company_code.equalsIgnoreCase(""))
//					{
//						arrValues.add(Company_code);
//					}
//					else
//					{
//						arrValues.add(hmap.get("CompanyCode"));
//					}
//					arrValues.add(hmap.get("DateofFinalisation"));
//					arrValues.add(hmap.get("CreditRatingbyRatingPool"));
//					arrValues.add(hmap.get("RatingPoolDate"));
//					arrValues.add(hmap.get("RatingConfirmedbyCG"));							
//					arrValues.add(hmap.get("CGRating"));
//					arrValues.add(hmap.get("CGRationale"));
//					arrValues.add(arrayFacility.get(i));							
//					arrValues.add(arrayInterest.get(i));
//					arrValues.add(hmap.get("RatingReview"));
//					arrValues.add(hmap.get("CGObservations"));
//					
//					if(rs!=null)
//					{
//						rs=null;
//					}
//					try
//					{
//						str_Exception="$";
//						FacilityName=Helper.correctNull(((String)arrayFacility.get(i)).trim());	
//						
//						if(!FacilityName.equalsIgnoreCase("") && !Application_No.equalsIgnoreCase(""))
//						{
//							strQuery=SQLParser.getSqlQuery("sel_facilityid_schemecode^"+FacilityName+"^"+Application_No);
//							rs = DBUtils.executeQuery(strQuery);
//							if(rs.next())
//							{
//								FacilityID=Helper.correctNull((String)rs.getString("facility_catid"));
//								FacilityParent=Helper.correctNull((String)rs.getString("facility_parent"));
//								FacilitySchemeCode=Helper.correctNull((String)rs.getString("facility_schemecode"));
//							}
//							else
//							{
//								str_Exception = str_Exception + "Error Occured While Importing 106 REPORT Flat File .. Facility Rated by IRB does not match with the Application";
//								throw new Exception(str_Exception);
//							}									
//						}
//					}
//					catch(Exception e)
//					{
//						throw new EJBException(e.toString());
//						
//					}
//					
//					arrValues.add(FacilityID);
//					arrValues.add(FacilityParent);
//					arrValues.add(FacilitySchemeCode);								
//					
//					hshQuery.put("arrValues",arrValues);				
//					hshQueryValues.put("size",Integer.toString(intUpdatesize));
//					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
//				}
//			
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
//				
//				dflag=1;
//		}	
//		else
//		{
//			dflag=0;
//		}
//	}
//}