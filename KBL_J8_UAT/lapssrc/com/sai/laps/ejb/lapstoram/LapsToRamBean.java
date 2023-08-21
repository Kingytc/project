/**
 *@author : S.SATHYA MOORTHY. 
 * @PURPOSE: CREATING FLAT FILE FOR RETAIL
 * @FLOW   : LAPS TO CRISIL RAM
 * @NUMBER OF FUNCTIONS : 2
 * @DATE OF CREATION :18/06/2007
 * 
 **/

package com.sai.laps.ejb.lapstoram;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
//import java.rmi.RemoteException;
import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import sun.misc.BASE64Encoder;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.IRB_Encryption;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.ApplicationParams;

/**
 * 1)LAPS TO RAM (RETAIL CUSTOMER PROFILE BEFORE APPROVAL FLAT FILE GENERATION) WITH 3 MODELS.
 * 2)LAPS TO RAM (RETAIL EDUCATION LOAN DETAILS FLAT FILE GENERATION.
 * 
 * 
 * 
 * 
 * @author S.SATHYA MOORTHY.
 *
 */
@Stateless(name = "LapsToRamBean", mappedName = "LapsToRamHome")
@Remote (LapsToRamRemote.class)
public class LapsToRamBean extends BeanAdapter 

{
	static Logger log=Logger.getLogger(LapsToRamBean.class);
	private static final long serialVersionUID = 1L;

	SimpleDateFormat sd = null;

	SimpleDateFormat sdt = null;
	boolean allocationFlag=false;
	boolean libalityflag=false;
	
	
	
	/*
	 * VARIABLE DECLARATIONS FOR UNION MILES AND UNION COMFORT
	 * */
	
	String margin="";
	String emi="";
	String gmonthlyincome="";
	String coapp_gmonthlyincome="";
	String totmonthlyinstall="";
	String monthlyincome="";
	String coapp_monthlyincome="";
	String totloanos="";
	String totannualincome="";
	String appother_deduction1="";
	String appother_deduction2="";
	String appinsurance="";
	String coapp_other_deduction1="";
	String coapp_other_deduction2="";
	String coapp_insurance="";
	String app_totannualincome="";
	String coapp_totannualincome="";
	String coapptotloanos="";
	String incometype="";
	String neworoldflagforunionmiles="false";
	String demo_includeincome="";
	
	String edu_studyplace="";
	String edu_time="";
	String edu_course="";
	String grossmonthlyincome="";
	String prodtype="";
	
	
	
	
	
	
	
	/**
	 * VAIRABLE DECLARATION FOR EDUCATION LOAN
	 * 
	 * 
	 */
		String costofloanproduct="";
		
		String loansought="";String totalcostofeducation="";
		String totalinstallmentdue="";
		
		
		
		
		//------------------------------------------------------------------------------------------------------------------------------
		 
		
		
		public HashMap startInterface(HashMap hashmap) 
		{
			
 			HashMap hshReturn=new HashMap();
			HashMap Return=new HashMap();
			
			hshReturn=industryMaster(hashmap);			
			Return.put("industrymaster","1");
			Return.put("ind_rowcount",(hshReturn.get("industrymaster_tot_row")));
			Return.put("ind_filewrite",(hshReturn.get("industrymaster_isfileWrited")));
			Return.put("ind_totalfilewrite","1");		
			
			
			hshReturn=groupMaster(hashmap);
		
			Return.put("groupmaster","1");
			Return.put("group_rowcount",(hshReturn.get("groupmaster_tot_row")));
			Return.put("group_filewrite",(hshReturn.get("groupmaster_isfileWrited")));
			Return.put("group_totalfilewrite","1");		
		
			
		return Return;	
		}
	
//---------------------------------------------------------------------------------------------------------------------------------------------------	
	
	
	
	/**
	 * 
	 * 								1)		START OF RETAIL CUSTOMER FLAT FILE CREATION **
	 */
	
	
		
								public HashMap createRCustomerFlatFile(HashMap hshValues) 
								{
									File Directory = null;
									
									ResultSet rs = null;
									String strIRBPath1=ApplicationParams.getDRIVEURL();
									String strIRBPath2=ApplicationParams.getDRIVEURL1();
									String rootPath="";
									String FolderName= "Retail\\Data";
									String Exception_flag="false";
									String property_flag="false";
									//String str_Exception="$";
									String Path ="";
									
									try 
									{String strApplicationNumber = "";
									strApplicationNumber = correctNull((String)hshValues.get("appno"));
									if(strApplicationNumber.equals(""))
									{
										strApplicationNumber = correctNull((String)hshValues.get("applicationnumber"));
									}
									log.info("Application Number::::----->" + strApplicationNumber);
						           // str_Exception = "$";
									
						            
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
						            
						            
						            
						            
						            rs = null;
						            if(Exception_flag.equalsIgnoreCase("false"))
						            {
						                HashMap arg = new HashMap();
						                arg = hshValues;
						                arg.put("applicationnumber", strApplicationNumber);
						                boolean result = checkmandatoryfields(arg);
						                if(result)
						                {
						                    property_flag = "false";
						                } else
						                {
						                    property_flag = "true";
						                }
						                log.info("property_flag:::::------->" + property_flag);
						            }
						            if(Exception_flag.equalsIgnoreCase("false") && property_flag.equalsIgnoreCase("false"))
						            {
						                HashMap arg = new HashMap();
						                arg = hshValues;
						                arg.put("applicationnumber", strApplicationNumber);
						                log.info("Exception_flag================++++++++++++retailCompanyMaster" + Exception_flag);
						                retailCompanyMaster(arg);
						                String query = SQLParser.getSqlQuery("retail_lapstoram_customerfilecreation^" + strApplicationNumber);
						                rs = DBUtils.executeQuery(query);
						                rs.beforeFirst();
						                log.info("rs================++++++++++++createRetailCustomerFlatFile" + rs);
						                createRetailCustomerFlatFile(rs, hshValues, Path, strApplicationNumber);
						            }} 
									catch (Exception e) 
									{
										e.printStackTrace();
									} 
									
									hshValues.put("SENT_FLAG",Exception_flag);	
									hshValues.put("propertyflag",property_flag);	
							 		return hshValues;
								}
		
									//************************************************************************
								
		
								/**
								 * Method for creating Flat File with companycode,modulename,application no ,date and time.
								 * @author S.SATHYA MOORTHY.
								 * @param rs
								 * @param writer
								 * @
								 */
								public void createRetailCustomerFlatFile(ResultSet rs,HashMap hmap,String Path,String ApplicationNumber) 
								{
									
									String prefix="RET";
									String companycode="";
									String OldCustomerID="";
									
									String modelname="";
									String strDate="";
									String strTime="";
									
									
									sd = new SimpleDateFormat("ddMMyyyy");
									sdt = new SimpleDateFormat("HHmmss");
									
									strDate=sd.format(new Date());
									strTime=sdt.format(new Date());
									
									FileWriter fout = null;									
									
									try
									{
											
											ResultSetMetaData rsmd = null;
											rsmd = rs.getMetaData();
											rsmd.getColumnCount();
											
											if(rs.next())
											{
												for (int i = 1; i <= rsmd.getColumnCount(); i++) 
												{
					 								if(rsmd.getColumnName(i).equalsIgnoreCase("prd_type"))//checking for product Type
													{
														
														String prodtype=(String)rs.getString(i);
														if(prodtype.equalsIgnoreCase("pA"))modelname="UNION MILES";
														else if(prodtype.equalsIgnoreCase("pD"))modelname="UNION COMFORT";
														else if(prodtype.equalsIgnoreCase("pH")) modelname="UNION HOME";
														else if(prodtype.equalsIgnoreCase("pM"))modelname="UNION MORTGAGE";
														else if(prodtype.equalsIgnoreCase("pE"))modelname="UNION EDUCATION";
														else
														{															
															throw new Exception ("Flat File is  Not Applicable this Model(Cannot Generate)");
														}
													}
					 								
					 								
												 }//end of for loop
																			
											}//end of rs.next()
											
											if(rs!=null)
											{
												rs.close();
											}
											String query=SQLParser.getSqlQuery("perselappid^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query);
											if(rs.next())
											{
												companycode=Helper.correctNull(rs.getString("demo_appid"));
											}
											
											if(rs!=null)
											{
												rs.close();
											}
											
											query=SQLParser.getSqlQuery("seloldrefidforapp^"+companycode);
											rs = DBUtils.executeQuery(query);
											if(rs.next())
											{
												OldCustomerID=Helper.correctNull(rs.getString("perapp_oldid"));
											}
											
											if(!OldCustomerID.equalsIgnoreCase(""))
											{
												companycode=OldCustomerID;
											}
										
											
											//creation of Flat File
											
											
											String FlatFileName="";
											//setting up the path and file name for the flat file to generate.....
											int queryFlag=0;
											FlatFileName=Path+"/"+prefix+companycode+"_"+ApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
											log.info("FlatFileName in createRetailCustomerFlatFile:::::--------->"+FlatFileName);							
																					
											fout = new FileWriter(FlatFileName);
											log.info("fout in createRetailCustomerFlatFile:::::--------->"+fout);	
											BufferedWriter bWriter = new BufferedWriter(fout);
											rs=null;
											
																				
//											executing query for First one...
											String query1=SQLParser.getSqlQuery("retail_lapstoram_customer1^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query1);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=1);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//executing query for second one...
											String query2=SQLParser.getSqlQuery("retail_lapstoram_customer2^"+ApplicationNumber);
 											rs = DBUtils.executeQuery(query2);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=2);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//executing query for third one
											String query3=SQLParser.getSqlQuery("retail_lapstoram_customer3^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query3);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=3);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											
//											executing query for third one for applicant
											String query31=SQLParser.getSqlQuery("retail_lapstoram_customer31^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query31);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=31);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											
											//executing query for third one for co-applicant
											String query32=SQLParser.getSqlQuery("retail_lapstoram_customer32^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query32);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=32);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
																					
											if(neworoldflagforunionmiles.equalsIgnoreCase("false"))
											{
											//executing query for fourth one
											String query4=SQLParser.getSqlQuery("retail_lapstoram_customer4^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query4);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=4);  //calling the getTablevalues to write the flat file ......
											rs=null;
											}
																					
											if(neworoldflagforunionmiles.equalsIgnoreCase("true"))
											{
											//executing query for fourth one
											String query4=SQLParser.getSqlQuery("retail_lapstoram_customer41^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query4);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=4);  //calling the getTablevalues to write the flat file ......
											rs=null;
											}										
											//executing query for fifth one
											String query5=SQLParser.getSqlQuery("retail_lapstoram_customer5^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query5);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=5);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											String query51=SQLParser.getSqlQuery("retail_lapstoram_customer51^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query51);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=51);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//excuting query for sixth one
											String query6=SQLParser.getSqlQuery("retail_lapstoram_customer6^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query6);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=6);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//excuting query for sixth one for co-applicant
											String query61=SQLParser.getSqlQuery("retail_lapstoram_customer61^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query61);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=61);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//executing query for eighth one
											
											String query8=SQLParser.getSqlQuery("retail_lapstoram_customer8^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query8);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=8);  //calling the getTablevalues to write the flat file ......
											rs=null;
											String query81=SQLParser.getSqlQuery("retail_lapstoram_customer81^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query81);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=81);  //calling the getTablevalues to write the flat file ......
											rs=null;
											
											//executing query for eighth one
											
											String query9=SQLParser.getSqlQuery("retail_lapstoram_customer9^"+ApplicationNumber);
											rs = DBUtils.executeQuery(query9);
											getRetailCustomerTablevalues(rs,bWriter,queryFlag=9);  //calling the getTablevalues to write the flat file ......
											rs=null;	
											
											
										
										
									}
									catch(Exception e)
									{
										
										e.printStackTrace();
									}
									finally 
									{
										try 
										{
											if(fout!=null)
											{
												fout.close();
											}
										} 
										catch (IOException e) 
										{
											e.printStackTrace();
										}
									}
								
									
								}//end of createFlatFileMethod;
								
									
		
								/**
								 * @Method for reading datas from the database and Writing to Flat File.
								 * @athor S.SATHYA MOORTHY.
								 * @param rs
								 * @param writer
								 * @
								 */	
								
								
								
		 
							private void getRetailCustomerTablevalues(ResultSet rs, BufferedWriter writer,int queryFlag)
							 
							{
								
								
							
								
						try {
							
							/*DecimalFormat nf = new DecimalFormat();
							nf.setGroupingUsed(false);
							nf.setMaximumFractionDigits(2);
						    nf.setMinimumFractionDigits(2);	*/
							BufferedWriter bWriter = writer;
							ResultSetMetaData rsmd = rs.getMetaData();
						
							String strResultSetData="";
							
							//local variable Decalarations for below process
							
							String strDobDate="";
							SimpleDateFormat stz=new SimpleDateFormat("dd/MM/yyyy");
							SimpleDateFormat stz1=new SimpleDateFormat("yyyy");
							
							boolean flag=false;
							flag=rs.next();
							
	  						if (flag)
							{	  							
	  							
	 							for (int i = 1; i <= rsmd.getColumnCount(); i++) 
								{	 								
									
									strResultSetData=Helper.correctNull(rs.getString(i));	 								
	 								
	 								
	  								if(rsmd.getColumnName(i).equalsIgnoreCase("ApplicantID"))//checking for application id
									{
	 									strResultSetData=Helper.correctNull(rs.getString(i));
	 									bWriter.write(strResultSetData);
	 									bWriter.write("~");
									}
	 								
	 								if(rsmd.getColumnName(i).equalsIgnoreCase("demo_appno"))//checking for application Number;
									{
	 									strResultSetData=Helper.correctNull(rs.getString(i));
	 									bWriter.write(strResultSetData);
	 									bWriter.write("~");
									}
	 										
									if(rsmd.getColumnName(i).equalsIgnoreCase("prd_type"))//checking for product Type
									{
										prodtype=Helper.correctNull(rs.getString(i));
										if(prodtype.equalsIgnoreCase("pA"))
										{
											strResultSetData="UNION MILES"; 
											neworoldflagforunionmiles="true";
										}
										else
										{
											neworoldflagforunionmiles="false";
										}
										if(prodtype.equalsIgnoreCase("pD"))strResultSetData="UNION COMFORT";
										if(prodtype.equalsIgnoreCase("pH"))strResultSetData="UNION HOME";
										if(prodtype.equalsIgnoreCase("pM"))strResultSetData="UNION MORTGAGE";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_dob"))//Getting age from the dob
									{
										strDobDate=Helper.correctNull(rs.getString(i));
										String date=stz.format(new Date());
										int c_day=0;int c_month=0;int c_year=0;
										int d_day=0;int d_month=0;int d_year=0;
										//strDobDate="12/02/1984";
										StringTokenizer st1=new StringTokenizer(strDobDate,"/");
											if(st1.hasMoreElements())
											{
	 											d_day=Integer.parseInt((String)st1.nextElement());
												d_month=Integer.parseInt((String)st1.nextElement());
												d_year=Integer.parseInt((String)st1.nextElement());
																			
											}
											
										StringTokenizer st2=new StringTokenizer(date,"/");
											if(st2.hasMoreElements())
											{
												c_day=Integer.parseInt((String)st2.nextElement());
												c_month=Integer.parseInt((String)st2.nextElement());
												c_year=Integer.parseInt((String)st2.nextElement());
											}
											
											//Getting the age by subracting the year;
											
											strResultSetData=new Integer((c_year-d_year)).toString();
											bWriter.write(strResultSetData);
											bWriter.write("~");
											
																		
									}
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_education"))//getting perapp Education
									{
										String education=Helper.correctNull(rs.getString(i));
										if(education.equals("1")|| education.equals("2")||education.equals("3")||education.equals("4")||education.equals("5")||education.equals("13"))strResultSetData="Professional";
										if(education.equals("6"))strResultSetData="Post-graduate";
										if(education.equals("7"))strResultSetData="Graduate";
										if(education.equals("8"))strResultSetData="Under-graduate";
										if(education.equals("9")||education.equals("10")||education.equals("11")||education.equals("12")||education.equals("14"))strResultSetData="SSC";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_employment"))//getting perapp Education
									{
										String occupation=Helper.correctNull(rs.getString(i));
										if(occupation.equals("2")|| occupation.equals("3"))
										{
											strResultSetData="Business/Professional";
										}
										else if(occupation.equals("4"))
										{
											strResultSetData="Farmers";
										}
										else if(occupation.equals("1"))
										{
											strResultSetData="Salaried";
										}
										else if(occupation.equals("9"))
										{
											strResultSetData="Retired";
										}
										else
										{
											strResultSetData="Others";
										}
										
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									/*if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_employment"))//getting perapp Employment
									{
										String occ=Helper.correctNull(rs.getString(i));
										if(occ.equals("1")||occ.equals("5")||occ.equals("6")||occ.equals("7")||occ.equals("8"))strResultSetData="Salaried";
										if(occ.equals("4"))strResultSetData="Farmers";
										if(occ.equals("2")||occ.equals("3"))strResultSetData="Business/Proffesional";
										if(occ.equals("9"))strResultSetData="Retired";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}*/
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_yrsexp"))//getting years of employment.
									{
											String ddate=Helper.correctNull(rs.getString(i));
											if(ddate.equals(""))ddate="0";
											if(ddate.equals("0.0"))ddate="0";
											String tempdate=stz1.format(new Date());
											//double checkdate=Double.parseDouble(ddate);
											
											//strResultSetData=String.valueOf(Integer.parseInt(tempdate)-Integer.parseInt(ddate));
											strResultSetData=String.valueOf(Integer.parseInt(ddate));
											//strResultSetData=new Integer((int)Math.ceil(checkdate)).toString();
													if(ddate.equals("0"))strResultSetData="0";							
											bWriter.write(strResultSetData);
											bWriter.write("~");
									}
									
																	
									
	 								if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_car"))//getting perapp lifestyle car
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										
										bWriter.write(strResultSetData);
										bWriter.write("~");
										
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_scooter"))//getting perapp lifestyle scooter
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";	
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
	 								if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_fridge"))//getting perapp life style fridge
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_telephone"))//getting perapp lifestyle telephone
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_computer"))//getting perapp lifestyle computer
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_mobile"))//getting perapp lifestyle mobile
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_washing_machine"))//getting perapp lifestyle washing machine
									{
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_television"))//getting perapp lifestyle Television
									{										
										if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
										else strResultSetData="N";
										bWriter.write(strResultSetData);
										bWriter.write("~");										
									}
									
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("loan_costloanprd"))//getting loandetails loan margin;
									{
										costofloanproduct=Helper.correctNull(rs.getString(i));
									}																	
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("offeredmargin"))//getting loandetails loan margin;
									{
										String margin=Helper.correctNull(rs.getString(i));
										
										if(!(margin.equals("")&& costofloanproduct.equals("")))
										{
										double CostofLoanProduct=Double.parseDouble(costofloanproduct);
										double Margin=Double.parseDouble(margin);
										double result1=0;
										
										if(CostofLoanProduct!=0)
										{											
											result1=Margin/CostofLoanProduct;
											result1=result1*100;
											strResultSetData=Helper.formatDoubleValue(result1);
										}
										else
										{
											strResultSetData="0";
										}
										
									}
										
										bWriter.write(strResultSetData);
										bWriter.write("~");
																										
										
									}
										
									if(rsmd.getColumnName(i).equalsIgnoreCase("loan_emi"))//getting loandetails loan EMI;
									{
										emi=Helper.correctNull(rs.getString(i));
										
									}
								if(rsmd.getColumnName(i).equalsIgnoreCase("perinctype"))//getting type from perinc&expenses loan EMI;
									{
										incometype=Helper.correctNull(rs.getString(i));
										
									}
									
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_monsalary"))//getting loandetails loan margin;
									{
										gmonthlyincome=Helper.correctNull(rs.getString(i));
										if(gmonthlyincome.equals(""))gmonthlyincome="0";
									}
									
									//perinc---MonthGrossIncome
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_perinc_monsalary"))//getting loandetails loan margin;
									{
										coapp_gmonthlyincome=Helper.correctNull(rs.getString(i));
										
										if(coapp_gmonthlyincome.equals(""))coapp_gmonthlyincome="0";
										if(emi.equals(""))emi="0";
										
										//calculation of emi of loan sought/gross monthly income
										
										double Emi=Double.parseDouble(Helper.correctDouble(emi));
										double Gmi=Double.parseDouble(Helper.correctDouble(gmonthlyincome));
										double coapp_Gmi=Double.parseDouble(Helper.correctDouble(coapp_gmonthlyincome));
										double denomonth=0.00;
										/*if(incometype.equalsIgnoreCase("1"))
										{*/
										denomonth=Gmi+coapp_Gmi;
										//}
										/*else
										{
											denomonth=(Gmi+coapp_Gmi)*12;
										}	*/
										
										
										if(Gmi!=0.0)
										{
											
										double stempresult=(Emi/denomonth);
										stempresult=stempresult*100;
										if(stempresult>100)
										{
											stempresult=100;
										}
										strResultSetData=Helper.formatDoubleValue(stempresult);
										}
										else
										{
											strResultSetData="0";
										}
									
										bWriter.write(strResultSetData);
										bWriter.write("~");
																																		
										
									}
									
									
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("prop_type1"))//getting perapp Property Type.
									{
										String strPropertyType=rs.getString(i);
										if(strPropertyType.trim().equals("1"))
										{
											strResultSetData="NEW";
										}
										else 
										{
											strResultSetData="SECOND HAND";
										}
										bWriter.write(strResultSetData);
										bWriter.write("~");
										
									}
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("prop_age"))//getting perapp Property Type.
									{
										String strPropertyType=rs.getString(i);
										
										if(strPropertyType.length()>3)
										{
											int tempdate=Integer.parseInt(strPropertyType);
											int date=Integer.parseInt(stz1.format(new Date()));
											int result=0;
											result=date-tempdate;
											strPropertyType=String.valueOf(result);
											
										}
										
										bWriter.write(strPropertyType);
										bWriter.write("~");
									}
									
									
									
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("liab_balance"))//mapping the Allocation of existing resource
									{
															
										
										totloanos=Helper.correctNull(rs.getString(i));
										if(totloanos.equals(""))totloanos="0";
										
										
										
									}
									/*if(rsmd.getColumnName(i).equalsIgnoreCase("demo_includeincome"))//mapping the Allocation of existing resource
									{
															
										
										demo_includeincome=Helper.correctNull(rs.getString(i));
										if(demo_includeincome.equals(""))totloanos="0";
										
										
										
									}*/
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_liab_balance"))//mapping the Allocation of existing resource
									{
										coapptotloanos=Helper.correctNull(rs.getString(i));
										if(coapptotloanos.equals(""))coapptotloanos="0";
										if(totloanos.equals(""))totloanos="0";
										double appoutbal=Double.parseDouble(totloanos);
										
										double coappoutbal=Double.parseDouble(coapptotloanos);
										double totoutbalance=0.00;
										if(coappoutbal!=0.0)
										{
											totoutbalance=coappoutbal;
										}
										else
										{
											totoutbalance=appoutbal+coappoutbal;
										}	
										
										
											if(totoutbalance!=0)
											{
												strResultSetData="Y";
											}
											else
											{
												strResultSetData="N";
											}
											bWriter.write(strResultSetData);
											bWriter.write("~");
									}
									
									//Total instalments due / monthly income.start
									if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_autoloanexp"))
									{
										totmonthlyinstall=Helper.correctNull(rs.getString(i));
										if(totmonthlyinstall.equals(""))totmonthlyinstall="0";
									
									}
									//takehome 
									if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_takehome"))
									{
										
										monthlyincome=Helper.correctNull(rs.getString(i));
										if(monthlyincome.equals(""))monthlyincome="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_perinc_takehome"))
									{
										coapp_monthlyincome=Helper.correctNull(rs.getString(i));	
										if(monthlyincome.equals(""))monthlyincome="0";
										if(totmonthlyinstall.equals(""))totmonthlyinstall="0";
										if(coapp_monthlyincome.equals(""))coapp_monthlyincome="0";
										if(totloanos.equals(""))totloanos="0";
										
										double monthlyinstall=Double.parseDouble(Helper.correctDouble(totmonthlyinstall));
										double minc=Double.parseDouble(monthlyincome);
										double coappminc=Double.parseDouble(coapp_monthlyincome);
										double outstandamount=Double.parseDouble(totloanos);
										double tottakehome=0.00;
										double totmonthinstall=0.00;
										//yearinstall=monthlyinstall*12;
										if(incometype.equalsIgnoreCase("2"))
										{
											tottakehome=minc+coappminc;
										}
										else
										{
											tottakehome=(minc+coappminc)/12;
										}
										
										if(outstandamount!=0 && outstandamount!=0.00)
										{
										if(minc!=0)	
											{
												totmonthinstall=(monthlyinstall/tottakehome)*100;
												if(totmonthinstall>100)
												{
													totmonthinstall=100;
												}
												strResultSetData=Helper.formatDoubleValue(totmonthinstall);
											}
										
											else
											{
												strResultSetData="0";
											}
										}
										else
											{
												strResultSetData="0";
											}
										bWriter.write(strResultSetData);
										bWriter.write("~");
																			
									}
									//end
									
	 								//1.Other monthly outgo from income start
									if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_otherexp"))
									{
										appother_deduction2=Helper.correctNull(rs.getString(i));
										if(appother_deduction2.equals(""))appother_deduction2="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("appother_deduction1"))
									{
										appother_deduction1=Helper.correctNull(rs.getString(i));
										if(appother_deduction1.equals(""))appother_deduction1="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("appinsurance"))
									{
										appinsurance=Helper.correctNull(rs.getString(i));
										if(appinsurance.equals(""))appinsurance="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_other_deduction2"))
									{
										coapp_other_deduction2=Helper.correctNull(rs.getString(i));
										if(coapp_other_deduction2.equals(""))coapp_other_deduction2="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_other_deduction1"))
									{
										coapp_other_deduction1=Helper.correctNull(rs.getString(i));
										if(coapp_other_deduction1.equals(""))coapp_other_deduction1="0";
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_insurance"))
									{
										coapp_insurance=Helper.correctNull(rs.getString(i));
										if(coapp_insurance.equals(""))coapp_insurance="0";
										
									
										
										double deduc1=Double.parseDouble(appother_deduction1);
										double deduc2=Double.parseDouble(appother_deduction2);
										double insur=Double.parseDouble(appinsurance);
										double tempdedu1=0.00;
										tempdedu1=deduc1+deduc2+insur;
										double codeduc1=Double.parseDouble(coapp_other_deduction1);
										double codeduc2=Double.parseDouble(coapp_other_deduction2);
										double coinsur=Double.parseDouble(coapp_insurance);
										double temp1=0.00;
										double tempdedu2=0.00;
										tempdedu2=codeduc1+codeduc2+coinsur;
										temp1=tempdedu1+tempdedu2;
										double minc=Double.parseDouble(monthlyincome);
										double coappminc=Double.parseDouble(coapp_monthlyincome);
										String result="";
										
										double temp2=0.00;
										if(incometype.equalsIgnoreCase("2"))
										{
											temp2=minc+coappminc;
										}
										else
										{
											temp2=(minc+coappminc)/12;
										}
										
										
										if(temp2!=0 && temp2!=0.00)
										{
										double result1=0.00;
										result1=temp1/temp2;
										result=Helper.formatDoubleValue(result1*100);
										bWriter.write(result);
										}
										else
										{
											bWriter.write("0.0");
										}
	  								    bWriter.write("~");
																			
									}
									
								//end	
									
									//1.Total loan O/S /Total annual income start
									if(rsmd.getColumnName(i).equalsIgnoreCase("coapps_perinc_monsalary"))
									{
										double Gmi=Double.parseDouble(Helper.correctDouble(gmonthlyincome));
										double coapp_Gmi=Double.parseDouble(Helper.correctDouble(coapp_gmonthlyincome));
										double denomonth=0.00;
										/*if(incometype.equalsIgnoreCase("1"))
										{
											denomonth=Gmi+coapp_Gmi;
										}*/
										/*else
										{*/
											denomonth=(Gmi+coapp_Gmi)*12;
										//}
										//coapp_totannualincome=Helper.correctNull(rs.getString(i));
									
										/*if(app_totannualincome.equals("")) app_totannualincome="0";
										if(coapp_totannualincome.equals("")) coapp_totannualincome="0";
										if(totloanos.equals(""))totloanos="0";
										double appannualincome=0.00; 
										double coappannualincome=0.00;
										appannualincome=Double.parseDouble(app_totannualincome);
										coappannualincome=Double.parseDouble(coapp_totannualincome);*/
										
										
										double TOTALINCOME=denomonth;
										double coapptotloanincome=0.00;
										double appannualincome=0.00; 
										appannualincome=Double.parseDouble(totloanos);
										coapptotloanincome=Double.parseDouble(coapptotloanos);
										
										double TOTALLOANOS=0.00;
										
										TOTALLOANOS=appannualincome+coapptotloanincome;
											
										
										if(TOTALLOANOS!=0)
										strResultSetData=Helper.formatDoubleValue(((TOTALLOANOS/TOTALINCOME)*100)>100?101:((TOTALLOANOS/TOTALINCOME)*100));
										else
										strResultSetData="0.0";
										bWriter.write(strResultSetData);
										bWriter.write("~");
									}
								//end	
									
									if(rsmd.getColumnName(i).equalsIgnoreCase("app_usrid"))
									{
										strResultSetData=Helper.correctNull(rs.getString(i));
										bWriter.write(strResultSetData);
										bWriter.write("~");
										
									}
									if(rsmd.getColumnName(i).equalsIgnoreCase("app_createdate"))
									{
										strResultSetData=Helper.correctNull(rs.getString(i));
										
										bWriter.write(strResultSetData);
										
										
									}
												
									//if(!rsmd.getColumnName(i).equalsIgnoreCase("demo_appid"))
									//bWriter.write("~");//rowwise Delimiter
												
									//bWriter.write(strResultSetData);
									bWriter.flush();
						   }
	 							
					}
	  						else
	  						{
	  							if(queryFlag==2)//lifestyle
	  							{ 
	  								bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");bWriter.write("N");
	  								bWriter.write("~");
	  							}
	  							
	  							
	  							if(queryFlag==3)//loan margin and emi
	  							{
	  								bWriter.write("0.0");bWriter.write("~");
	  								bWriter.write("0");bWriter.write("~");
	  							}
	  							
	  							if(queryFlag==31)
	  							{
	  								bWriter.write("0.0");bWriter.write("~");
	  							}
	  							
	  							if(queryFlag==4)//asset type and age 
	  							{
	  								if(prodtype.equalsIgnoreCase("pD"))
	  								{
	  									bWriter.write("NEW");bWriter.write("~");
	  								}
	  								else
	  								{
	  									bWriter.write("");bWriter.write("~");
	  								}
	  								bWriter.write("0");bWriter.write("~");	  								
	  							}
	  							
	  							
	   							if(queryFlag==5)
	  							{
	  								//bWriter.write("N");bWriter.write("~");
	  							}
	   							if(queryFlag==51)
	  							{
	  								bWriter.write("N");bWriter.write("~");
	  							}
	  							
	  							if(queryFlag==6)
	  							{
	  								bWriter.write("0");bWriter.write("~");
	  							}
	  							if(queryFlag==61)
	  							{
	  								bWriter.write("0");bWriter.write("~");
	  							}
	  							if(queryFlag==7)
	  							{
	  								//bWriter.write("0");bWriter.write("~");
	  							
	  							}
	  							if(queryFlag==8)
	  							{
	  								bWriter.write("0");	bWriter.write("~");
	  							}	
	  							if(queryFlag==81)
	  							{
	  								bWriter.write("0");	bWriter.write("~");
	  							}	
	  							
	  							bWriter.flush();
	  							
	  						}
	  						
							
						} 
						catch (SQLException e) 
						{
							e.printStackTrace();
						} 
						catch (IOException e) 
						{
							e.printStackTrace();
						}
						finally 
						{						
							if (rs != null) 
							{
								try 
								{
									rs.close();
									if(queryFlag==9)writer.close();
								} 
								catch (Exception e) 
								{
									e.printStackTrace();
								}
							}
						}
						
					
				}//end of method.
							
		
							
		/**
		 * 
		 * END OF RETAIL CUSTOMER FLAT FILE GENERATION **
		 */					
	
							
							public HashMap createELoanModelFlatFile(HashMap hshValues) 
							{
								File Directory = null;								
								ResultSet rs = null;
								String Exception_flag="false";
								String property_flag="false";
								HashMap hm = new HashMap();
								String strIRBPath1=ApplicationParams.getDRIVEURL();
								String strIRBPath2=ApplicationParams.getDRIVEURL1();
								String rootPath="";
								String FolderName="Retail\\Data";								
								String Path="";
								try 
								{									
									String strApplicationNumber=correctNull((String)hshValues.get("appno"));
									if(strApplicationNumber.equals(""))strApplicationNumber=correctNull((String)hshValues.get("strappno"));
									if(strApplicationNumber.equals(""))strApplicationNumber=correctNull((String)hshValues.get("appno1"));	
									//if(strApplicationNumber.equals(""))strApplicationNumber=correctNull((String)hshValues.get("applicationnumber"));
									
									//strApplicationNumber="9990000017";
									
									
									
									//String Path=rootPath+FolderName;
									log.info("strIRBPath1:::---->"+strIRBPath1+"\n \n");
									log.info("strIRBPath2:::---->"+strIRBPath2+"\n \n");
									try
									{		
										log.info("FolderName::::---->  " + FolderName + "\n \n");
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
									if(Exception_flag.equalsIgnoreCase("false"))
									{
										HashMap arg=new HashMap();
										arg=hshValues;
										arg.put("applicationnumber",strApplicationNumber);
										boolean result=checkmandatoryfields(arg);
										if(result)
										{
											property_flag="false";	
										}
										else
										{
											property_flag="true";	
										}
									}
									if(Exception_flag.equalsIgnoreCase("false") && property_flag.equalsIgnoreCase("false"))
									{
										HashMap arg=new HashMap();
										arg=hshValues;
										arg.put("applicationnumber",strApplicationNumber);
										retailCompanyMaster(arg);
										
										String query=SQLParser.getSqlQuery("retail_lapstoram_customerfilecreation^"+strApplicationNumber);
										rs = DBUtils.executeQuery(query);
										hshValues.put("filesuccess","1");
										createELoanFlatFile(rs,hshValues,Path,strApplicationNumber);
									}
									
								} 
								catch (Exception e) 
								{
									e.printStackTrace();
								} 
								
								hm.put("SENT_FLAG",Exception_flag);
								hm.put("propertyflag",property_flag);	
						 		
								return hm;
							}
							
							
							
							//*****************************************************************************
							
							
							public void createELoanFlatFile(ResultSet rs,HashMap hmap,String Path,String ApplicationNumber)
							{
								
								
								String prefix="RET";
								//String companycode=Helper.correctNull((String)hmap.get("comappid"));
								String companycode="";
								String applicationno=ApplicationNumber;
								String modelname="",OldCustomerID="";
								String strDate="";
								String strTime="";
								
								sd = new SimpleDateFormat("ddMMyyyy");
								sdt = new SimpleDateFormat("HHmmss");								
								strDate=sd.format(new Date());
								strTime=sdt.format(new Date());								
								FileWriter fout = null;
								
								
								try
								{
									ResultSetMetaData rsmd = rs.getMetaData();
									
										if(rs.next())
										{
											for (int i = 1; i <= rsmd.getColumnCount(); i++) 
											{
				 								if(i==1)//checking for product Type
												{												
													String prodtype=(String)rs.getString(i);
													if(prodtype.equalsIgnoreCase("pE"))modelname="EDUCATION LOAN";												
																								
												}
				 								
				 								
											 }//end of for loop
																		
										}//end of rs.next()
										
										
										//creation of Flat File
										
										if(rs!=null)
										{
											rs.close();
										}
										String query=SQLParser.getSqlQuery("perselappid^"+applicationno);
										rs = DBUtils.executeQuery(query);
										if(rs.next())
										{
											companycode=Helper.correctNull(rs.getString("demo_appid"));
										}
										
										if(rs!=null)
										{
											rs.close();
										}
										
										query=SQLParser.getSqlQuery("seloldrefidforapp^"+companycode);
										rs = DBUtils.executeQuery(query);
										if(rs.next())
										{
											OldCustomerID=Helper.correctNull(rs.getString("perapp_oldid"));
										}
										
										if(!OldCustomerID.equalsIgnoreCase(""))
										{
											companycode=OldCustomerID;
										}
										
										
										String FlatFileName="";
										//setting up the path and file name for the flat file to generate.....
										
										FlatFileName=Path+"/"+prefix+companycode+"_"+ApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																				
										new File(FlatFileName);
																				
										fout = new FileWriter(FlatFileName);
										BufferedWriter bWriter = new BufferedWriter(fout);																			
										
										int queryFlag=0;
										rs=null;
										//calling tables started here....
																			
										
										String query1=SQLParser.getSqlQuery("retail_lapstoram_edu1^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query1);
										getEducationLoanModel(rs,bWriter,queryFlag=1);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										//executing query for second one...
										String query2=SQLParser.getSqlQuery("retail_lapstoram_edu2^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query2);
										getEducationLoanModel(rs,bWriter,queryFlag=2);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										//executing query for third one
										String query3=SQLParser.getSqlQuery("retail_lapstoram_edu3^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query3);
										getEducationLoanModel(rs,bWriter,queryFlag=3);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										//executing query for fourth one
										String query4=SQLParser.getSqlQuery("retail_lapstoram_edu4^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query4);
										getEducationLoanModel(rs,bWriter,queryFlag=4);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										//executing query for fifth one
										String query5=SQLParser.getSqlQuery("retail_lapstoram_edu5^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query5);
										getEducationLoanModel(rs,bWriter,queryFlag=5);  //calling the getTablevalues to write the flat file ......
										rs=null;
										//excuting query for sixth one
										String query6=SQLParser.getSqlQuery("retail_lapstoram_edu6^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query6);
										getEducationLoanModel(rs,bWriter,queryFlag=6);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
//										excuting query for sixth one
										String query61=SQLParser.getSqlQuery("retail_lapstoram_edu61^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query61);
										getEducationLoanModel(rs,bWriter,queryFlag=61);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										String query71=SQLParser.getSqlQuery("retail_lapstoram_edu71^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query71);
										getEducationLoanModel(rs,bWriter,queryFlag=71);
											
										//calling the getTablevalues to write the flat file ......
										
										rs=null;
										
										//executing query for eighth one
										
										String query8=SQLParser.getSqlQuery("retail_lapstoram_edu8^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query8);
										getEducationLoanModel(rs,bWriter,queryFlag=8);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										//executing query for eighth one
										
										String query9=SQLParser.getSqlQuery("retail_lapstoram_edu9^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query9);
										getEducationLoanModel(rs,bWriter,queryFlag=9);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query10=SQLParser.getSqlQuery("retail_lapstoram_edu10^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query10);
										getEducationLoanModel(rs,bWriter,queryFlag=10);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query11=SQLParser.getSqlQuery("retail_lapstoram_edu11^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query11);
										getEducationLoanModel(rs,bWriter,queryFlag=11);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query12=SQLParser.getSqlQuery("retail_lapstoram_edu12^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query12);
										getEducationLoanModel(rs,bWriter,queryFlag=12);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query121=SQLParser.getSqlQuery("retail_lapstoram_edu121^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query121);
										getEducationLoanModel(rs,bWriter,queryFlag=121);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query13=SQLParser.getSqlQuery("retail_lapstoram_edu13^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query13);
										getEducationLoanModel(rs,bWriter,queryFlag=13);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query14=SQLParser.getSqlQuery("retail_lapstoram_edu14^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query14);
										getEducationLoanModel(rs,bWriter,queryFlag=14);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query15=SQLParser.getSqlQuery("retail_lapstoram_edu15^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query15);
										getEducationLoanModel(rs,bWriter,queryFlag=15);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										String demotype="";
										
										String query151=SQLParser.getSqlQuery("retail_lapstoram_edu151^"+ApplicationNumber+"^"+"c");
										rs = DBUtils.executeQuery(query151);
										if(rs.next() && rs.getInt(1)!=0) 
										{
											 demotype="c";
										}
										/*else
										{
											rs=null;
											query151=SQLParser.getSqlQuery("retail_lapstoram_edu151^"+ApplicationNumber+"^"+"g");
											rs = DBUtils.executeQuery(query151);
											
											if(rs.next() && rs.getInt(1)!=0)
											{
												 demotype="g";
											}
											else
											{
												demotype="";
											}
										}*/
										rs=null;
										
										String query152=SQLParser.getSqlQuery("retail_lapstoram_edu152^"+ApplicationNumber+"^"+demotype);
										rs = DBUtils.executeQuery(query152);
										getEducationLoanModel(rs,bWriter,queryFlag=152);  //calling the getTablevalues to write the flat file ......
										rs=null;										
										
										String query16=SQLParser.getSqlQuery("retail_lapstoram_edu16^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query16);
										getEducationLoanModel(rs,bWriter,queryFlag=16);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query161=SQLParser.getSqlQuery("retail_lapstoram_edu161^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query161);
										getEducationLoanModel(rs,bWriter,queryFlag=161);  //calling the getTablevalues to write the flat file ......
										rs=null;	
										
										String query17=SQLParser.getSqlQuery("retail_lapstoram_edu17^"+ApplicationNumber+"^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query17);
										getEducationLoanModel(rs,bWriter,queryFlag=17);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										String query171=SQLParser.getSqlQuery("retail_lapstoram_edu171^"+ApplicationNumber+"^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query171);
										getEducationLoanModel(rs,bWriter,queryFlag=171);  //calling the getTablevalues to write the flat file ......
										rs=null;
										
										String query18=SQLParser.getSqlQuery("retail_lapstoram_edu18^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query18);
										getEducationLoanModel(rs,bWriter,queryFlag=18);  //calling the getTablevalues to write the flat file ......
										rs=null;
										String query19=SQLParser.getSqlQuery("retail_lapstoram_edu19^"+ApplicationNumber);
										rs = DBUtils.executeQuery(query19);
										getEducationLoanModel(rs,bWriter,queryFlag=19);  //calling the getTablevalues to write the flat file ......
										rs=null;
								}
								catch(Exception e)
								{									
									e.printStackTrace();
								}
						
								finally 
								{
									try 
									{
										if(fout!=null)
										{
											fout.close();
										}
									} 
									catch (IOException e) 
									{
										e.printStackTrace();
									}

								}
								
						}
					
							/**
							 * @author S.SATHYA MOORTHY.
							 * @lOCAL METHOD FOR RETREVING VALUES FOR EDUCATION LOAN MODEL.
							 * @param rs
							 * @param writer
							 * @
							 */
							private void getEducationLoanModel(ResultSet rs, BufferedWriter writer,int  queryFlag)
							 
							{
								try 
								{
										BufferedWriter bWriter = writer;
										ResultSetMetaData rsmd = rs.getMetaData();
										String strResultSetData="";
										
										//local variable Decalarations for below process
										
										DecimalFormat nf = new DecimalFormat();
										nf.setGroupingUsed(false);
										nf.setMaximumFractionDigits(2);
									    nf.setMinimumFractionDigits(2);	
										
										SimpleDateFormat stz=new SimpleDateFormat("dd/MM/yy");
									    boolean flag=false;
										flag=rs.next();
																		
										if (flag)
										{
											for (int i = 1; i <= rsmd.getColumnCount(); i++) 
											{
												if(rsmd.getColumnName(i).equalsIgnoreCase("ApplicantID"))//checking for application id
												{
						 							strResultSetData=Helper.correctNull(rs.getString(i));
						 							bWriter.write(strResultSetData);
						 							bWriter.write("~");
						 						}
						 						if(rsmd.getColumnName(i).equalsIgnoreCase("demo_appno"))//checking for application Number;
												{
						 							strResultSetData=Helper.correctNull(rs.getString(i));
						 							bWriter.write(strResultSetData);
						 							bWriter.write("~");
												}
						 						if(rsmd.getColumnName(i).equalsIgnoreCase("prd_type"))//checking for product Type
												{
													String prodtype=Helper.correctNull(rs.getString(i));
													
													if(prodtype.equalsIgnoreCase("pE"))
													{
														strResultSetData="EDUCATION LOAN";
														bWriter.write(strResultSetData);
						 								bWriter.write("~");
													}
												}
												if(rsmd.getColumnName(i).equalsIgnoreCase("edu_age"))//Getting age from the dob
												{														
													strResultSetData=Helper.correctNull(rs.getString(i));
													bWriter.write(strResultSetData);
							 						bWriter.write("~");		
												}
												if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_education"))//getting perapp Education
												{
													String education=Helper.correctNull(rs.getString(i));
													if(education.equals("1")|| education.equals("2")||education.equals("3")||education.equals("4")||education.equals("5")||education.equals("13"))strResultSetData="Professional";
													if(education.equals("6"))strResultSetData="Post-graduate";
													if(education.equals("7"))strResultSetData="Graduate";
													if(education.equals("8"))strResultSetData="Under-graduate";
													if(education.equals("9")||education.equals("10")||education.equals("11")||education.equals("12")||education.equals("14"))strResultSetData="SSC";
															
															bWriter.write(strResultSetData);
						 									bWriter.write("~");																
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_marks"))//Getting percentage of marks
														{																													
																strResultSetData=Helper.correctNull(rs.getString(i));
																if(strResultSetData.equals(""))strResultSetData="0.0";
																bWriter.write(strResultSetData);
							 									bWriter.write("~");		
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_no_of_years")&& queryFlag==6)//getting perapp type of proffession
														{
																strResultSetData=Helper.correctNull(rs.getString(i));
																if(strResultSetData.equals(""))	strResultSetData="0";
																if(strResultSetData.equals("0.0"))strResultSetData="0";
																/*SimpleDateFormat stzx=new SimpleDateFormat("yyyy");
																int tempdate=Integer.parseInt(stzx.format(new Date()));*/
														        int pyears=Integer.parseInt(strResultSetData);// HOT CODED HERE ..................###############
																//strResultSetData=String.valueOf(tempdate-pyears);
																if(pyears==0)strResultSetData="0";
																bWriter.write(strResultSetData);
							 									bWriter.write("~");
														}
														
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_employment"))//getting perapp Employment
														{
															String education=Helper.correctNull(rs.getString(i));
															if(education.equals("2")|| education.equals("3"))
															{
																strResultSetData="Business/Professional";
															}
															else if(education.equals("4"))
															{
																strResultSetData="Farmers";
															}
															else if(education.equals("1"))
															{
																strResultSetData="Salaried";
															}
															else if(education.equals("9"))
															{
																strResultSetData="Retired";
															}
															else
															{
																strResultSetData="Others";
															}
															
															bWriter.write(strResultSetData);
															bWriter.write("~");
															
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_typeofprof"))//getting perapp type of proffession
														{
																strResultSetData=Helper.correctNull(rs.getString(i));
																if(strResultSetData.equals(""))	strResultSetData="0";
																
																//bWriter.write(strResultSetData);
							 									//bWriter.write("~");
							 							}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_yrsexp")&& queryFlag==8)//getting perapp type of proffession
														{
																strResultSetData=Helper.correctNull(rs.getString(i));
																if(strResultSetData.equals(""))	strResultSetData="0";
																//SimpleDateFormat stzx=new SimpleDateFormat("yyyy");
																
																	//Integer.parseInt(strResultSetData);
																	int pyears=Integer.parseInt(strResultSetData);// HARD CODED HERE ..................###############
																	
																//strResultSetData=String.valueOf(tempdate-pyears);
																strResultSetData=String.valueOf(pyears);
																if(pyears==0)strResultSetData="0";
																bWriter.write(strResultSetData);
							 									bWriter.write("~");
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_residencetype"))//getting residence type
														{
															String occ=Helper.correctNull(rs.getString(i));
															
															if(occ.equals("1"))strResultSetData="Rented";
															if(occ.equals("0"))strResultSetData="Rented";
															if(occ.equals("4"))strResultSetData="Ancestral home";
															if(occ.equals("2"))strResultSetData="Owned";
															if(occ.equals("5")|| occ.equals("3"))strResultSetData="Company Acco/lease";
															
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
																												
														if(rsmd.getColumnName(i).equalsIgnoreCase("perapp_yrsinpresadd"))//getting years in address
														{
															String yrsinpresadd=Helper.correctNull(rs.getString(i));
															if(yrsinpresadd.equals("1"))strResultSetData="6";
															if(yrsinpresadd.equals("2"))strResultSetData="3";
															if(yrsinpresadd.equals("3"))strResultSetData="1";
															
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
																				
														
						 								if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_car"))//getting perapp lifestyle car
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
																													
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_scooter"))//getting perapp lifestyle scooter
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";	
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
						 								if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_fridge"))//getting perapp life style fridge
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_telephone"))//getting perapp lifestyle telephone
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_computer"))//getting perapp lifestyle computer
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_mobile"))//getting perapp lifestyle mobile
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_washing_machine"))//getting perapp lifestyle washing machine
														{
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
															
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("lifestyle_television"))//getting perapp lifestyle Television
														{
															
															if(Helper.correctNull(rs.getString(i)).equals("1"))strResultSetData="Y";
															else strResultSetData="N";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
														}														
													
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("totalcost"))//getting loandetails loan margin;
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
																	if(strResultSetData.equals(""))strResultSetData="0";												
															 totalcostofeducation=strResultSetData;																							
															
														}
														
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("amtreq"))//getting loandetails loan margin;
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
																													
															 loansought=strResultSetData;
															 
															double temp1=Double.parseDouble(totalcostofeducation);
															double temp2=Double.parseDouble(loansought);
															 double temp3=0;
															 if(!(temp1==0))
															 {	 
															 temp3=temp2/temp1;
															 temp3=temp3*100;
															 }
															 else
															 {
																 temp3=0;
															 }
															 strResultSetData=nf.format(temp3>100?100:temp3);
															 bWriter.write(strResultSetData);
															 bWriter.write("~");
															 
														}
														
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_studies_in"))
														{
															edu_studyplace=Helper.correctNull(rs.getString(i));
															if(edu_studyplace.equals(""))
															{
																edu_studyplace="0";
															}
														}
															
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_qual_proposed"))
														{
															edu_time=Helper.correctNull(rs.getString(i));
															if(edu_time.equalsIgnoreCase(""))
															{
																edu_time="0";
															}
															
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_partfull"))
														{
															edu_course=Helper.correctNull(rs.getString(i));
															if(edu_course.equalsIgnoreCase(""))
															{
																edu_course="0";
															}
															//in india
															if(edu_studyplace.equalsIgnoreCase("1"))
															{
																if(edu_time.equalsIgnoreCase("1"))
																{
																	strResultSetData="Others";
																}
																if(edu_time.equalsIgnoreCase("2"))
																{
																	if(edu_course.equalsIgnoreCase("1"))
																	{
																		strResultSetData="Recognized institution in India";
																	}
																	else if(edu_course.equalsIgnoreCase("2") || edu_course.equalsIgnoreCase("3") )
																	{
																		strResultSetData="Local Institution for Grad/Post-Grad studies";
																	}
																	else
																	{
																		strResultSetData="Others";
																	}
																}
																if(edu_time.equalsIgnoreCase("3"))
																{
																	strResultSetData="Others";
																}
																if(edu_time.equalsIgnoreCase("4"))
																{
																	strResultSetData="Others";
																}
																if(edu_time.equalsIgnoreCase("5"))
																{
																	strResultSetData="Vocational course institute";
																}
															}
															
															//abroad
															if(edu_studyplace.equalsIgnoreCase("2"))
															{
																if(edu_time.equalsIgnoreCase("1"))
																{
																	if(edu_course.equalsIgnoreCase("1"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else if(edu_course.equalsIgnoreCase("2"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else
																	{
																		strResultSetData="Others";
																	}
																}
																if(edu_time.equalsIgnoreCase("2"))
																{
																	if(edu_course.equalsIgnoreCase("1"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else if(edu_course.equalsIgnoreCase("2"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else
																	{
																		strResultSetData="Others";
																	}
																}
																if(edu_time.equalsIgnoreCase("3"))
																{
																	if(edu_course.equalsIgnoreCase("1"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else if(edu_course.equalsIgnoreCase("2"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else
																	{
																		strResultSetData="Others";
																	}
																}
																if(edu_time.equalsIgnoreCase("4"))
																{
																	strResultSetData="Others";
																}
																if(edu_time.equalsIgnoreCase("5"))
																{
																	if(edu_course.equalsIgnoreCase("1"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else if(edu_course.equalsIgnoreCase("2"))
																	{
																		strResultSetData="Accredited, based abroad";
																	}
																	else
																	{
																		strResultSetData="Others";
																	}
																}
															}
															
															bWriter.write(strResultSetData);
															bWriter.write("~");
															
															
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("edu_amount"))//getting SCHOLAR SHIP
														{
															strResultSetData=Helper.formatDoubleValue(rs.getDouble(i));
															if(!strResultSetData.equals(""))strResultSetData="Y";
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
															
														}
														
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("tenor"))//getting loandetails loan margin;
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
															
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("perinctype"))//getting type from perinc&expenses loan EMI;
														{
															incometype=Helper.correctNull(rs.getString(i));
															
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("loan_emi"))//getting loandetails loan EMI;
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															emi=strResultSetData;
															
														}
														
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("PERINC_MONSALARY"))//getting loandetails loan EMI;
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															 grossmonthlyincome=strResultSetData;
															if(grossmonthlyincome.equals(""))
															{
																grossmonthlyincome="0";
															}
															if(emi.equals(""))emi="0";
															double temp1=Double.parseDouble(emi);
															double temp2=Double.parseDouble(grossmonthlyincome);
															double temp3=0.00;
															double temp4=0.00;
															
															/*if(incometype.equalsIgnoreCase("1"))
															{*/
																temp3=temp2;
															/*}
															else
															{
																temp3=temp2*12;
															}*/
															
																if(temp3!=0)
																{
																 temp4=temp1/temp3;
																 temp4=temp4*100;
																strResultSetData=nf.format(temp4);	
																	}
																else
																{
																	strResultSetData="0";
																}
																															
															
															bWriter.write(strResultSetData);
															bWriter.write("~");
															
														}														
														if(rsmd.getColumnName(i).equalsIgnoreCase("liab_balance"))//mapping the Allocation of existing resource
														{
																				
															
															totloanos=Helper.correctNull(rs.getString(i));
															if(totloanos.equals(""))totloanos="0";
															
															
															
														}
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_liab_balance"))//mapping the Allocation of existing resource
														{
															coapptotloanos=Helper.correctNull(rs.getString(i));
															if(coapptotloanos.equals(""))coapptotloanos="0";
															double coappoutbal=Double.parseDouble(coapptotloanos);
															double totoutbalance=0.00;
															
															totoutbalance=coappoutbal;
															
																if(totoutbalance!=0)
																{
																strResultSetData="Y";
																}
																else
																	{
																	strResultSetData="N";
																	}
																bWriter.write(strResultSetData);
																bWriter.write("~");
														}
//														Total instalments due / monthly income.start
														if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_autoloanexp"))
														{
															totmonthlyinstall=Helper.correctNull(rs.getString(i));
															if(totmonthlyinstall.equals(""))totmonthlyinstall="0";
														
														}
														//takehome 
														if(rsmd.getColumnName(i).equalsIgnoreCase("perinc_takehome"))
														{
															
															monthlyincome=Helper.correctNull(rs.getString(i));
															if(monthlyincome.equals(""))monthlyincome="0";
															
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("coapp_perinc_takehome"))
														{
															coapp_monthlyincome=Helper.correctNull(rs.getString(i));	
															if(monthlyincome.equals(""))monthlyincome="0";
															if(totmonthlyinstall.equals(""))totmonthlyinstall="0";
															if(coapp_monthlyincome.equals(""))coapp_monthlyincome="0";
															if(totloanos.equals(""))totloanos="0";
															
															double monthlyinstall=Double.parseDouble(Helper.correctDouble(totmonthlyinstall));
															double minc=Double.parseDouble(monthlyincome);
															double coappminc=Double.parseDouble(coapp_monthlyincome);
															double tottakehome=0.00;
															double dbltemp=0.0;
															//yearinstall=monthlyinstall*12;
															if(incometype.equalsIgnoreCase("2"))
															{
															tottakehome=minc+coappminc;
															}
															else
															{
																tottakehome=(minc+coappminc)/12;
															}
															
															if(tottakehome!=0 && tottakehome!=0.00)
															{
																dbltemp=(monthlyinstall/tottakehome)*100;
																strResultSetData=nf.format(dbltemp>100?100:dbltemp);
															}
															else
															{
																strResultSetData="0";
															}
															bWriter.write(strResultSetData);
															bWriter.write("~");
																								
														}
														//end
														
														if(rsmd.getColumnName(i).equalsIgnoreCase("otherexpenses"))
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															
															if(strResultSetData.equals(""))strResultSetData="0.0";
															if(grossmonthlyincome.equals(""))
															{
																grossmonthlyincome="0";
															}
															double temp1=Double.parseDouble(grossmonthlyincome);
															double temp2=Double.parseDouble(strResultSetData);;
															double temp3=0.00;
															double temp4=0.00;
															if(incometype.equalsIgnoreCase("1"))
															{
																temp3=temp1;
															}
															else
															{
																temp3=temp1*12;
															}
															
																if(temp3!=0)
																{
																 temp4=temp2/temp3;
																 temp4=temp4*100;
																 strResultSetData=nf.format(temp4>100?100:temp4);
																	}
																else
																{
																	strResultSetData="0";
																}
																bWriter.write(strResultSetData);
							 									bWriter.write("~");
																		
															
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("app_usrid"))
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															bWriter.write(strResultSetData);
						 									bWriter.write("~");
															
														}
														if(rsmd.getColumnName(i).equalsIgnoreCase("app_createdate"))
														{
															strResultSetData=Helper.correctNull(rs.getString(i));
															bWriter.write(strResultSetData);
						 									
															
														}
																			
													if(!rsmd.getColumnName(i).equalsIgnoreCase("demo_appid"))
																	//bWriter.write("~");//rowwise Delimiter
																	
														//bWriter.write(strResultSetData);
														bWriter.flush();
														
											   }
						 						
												
										}
										else
										{
											if(queryFlag==11)
											{											
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
												bWriter.write("N");bWriter.write("~");
											}
											if(queryFlag==8)
											{
												bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==3)
											{
												bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==5)
											{
												bWriter.write("0.0");bWriter.write("~");
											}
											if(queryFlag==6)
											{
												bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==61)
											{
												bWriter.write("");bWriter.write("~");
											}
											if(queryFlag==8)
											{
												//bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==12)
											{
												bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==13)
											{
												bWriter.write("Others");
												bWriter.write("~");
											}
											if(queryFlag==14)
											{
												bWriter.write("N");bWriter.write("~");
											}
											if(queryFlag==15)
											{
												bWriter.write("0");bWriter.write("~");
											}
											if(queryFlag==152)
											{
												bWriter.write("0.0");bWriter.write("~");
											}
										}
									} catch (SQLException e) {
											e.printStackTrace();
									} catch (IOException e) {
										e.printStackTrace();
									} finally {
										if (rs != null) {
											try {
												rs.close();
												if(queryFlag==19)writer.close();
											} catch (Exception e) {
												e.printStackTrace();
											}
										}
									}//end of method.
						}
						
							
//	----------------------------------------------------------------------------------------------------------------------------------------------------					
								
											//***End OF Education Loan FlatFile Generation.
					
												
//	---------------------------------------------------------------------------------------------------------------------------------------------------											
		//##################################################################################################################################
												

												public HashMap  companyMaster(HashMap hashmap) 
												{
													
													File Directory = null;
													
													ResultSet rs1= null;
													String Exception_flag="false";
													HashMap hm = new HashMap();
													String strIRBPath1=ApplicationParams.getDRIVEURL();
													String strIRBPath2=ApplicationParams.getDRIVEURL1();
													String rootPath="";
													String FolderName="Masters\\Company\\Data";
													String Path="";
														
														try
														{				
														    
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
														
														

														String modelname="";
														String strDate="";
														String strTime="";
														String query1="",UserID="";
														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");
														
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());
														
														FileWriter fout = null;
														
														
														try
														{
															
															UserID=Helper.correctNull((String)hashmap.get("strUserId"));
															
															if(UserID.equalsIgnoreCase(""))
															{
																UserID=Helper.correctNull((String)hashmap.get("c_username"));
															}
															//INSERTING VALUES TO THE TABLE LAPS_RAM 
															
															String strBorrowertype="C";//2
															String strCompanycode=Helper.correctNull((String)hashmap.get("comapp_id"));//1
															if(strCompanycode.equalsIgnoreCase(""))
															{
																strCompanycode=Helper.correctNull((String)hashmap.get("comapp_companyid"));
															}
															String strGroupcode="";
															String strCompanyName="";
															String strBranchlocation="";
															String strCompanycodeCBS="";
															if(Helper.correctNull((String)hashmap.get("type")).equalsIgnoreCase("OPS"))
															{
																query1 = SQLParser.getSqlQuery("mastgetdemographics^"+strCompanycode);
																rs1 = DBUtils.executeQuery(query1);
																
																if(rs1.next())
																{
																	strCompanyName=Helper.correctNull((String)rs1.getString("perapp_fname"));//2
																	strBranchlocation=Helper.correctNull((String)rs1.getString("org_name"));//1
																	strCompanycodeCBS=Helper.correctNull((String)rs1.getString("perapp_cbsid"));//4
																}
															}
															else
															{
																query1 = SQLParser.getSqlQuery("laps_ram_select_custmerprofile^"+strCompanycode);	
																rs1 = DBUtils.executeQuery(query1);
																
																if(rs1.next())
																{
																	strGroupcode=Helper.correctNull(rs1.getString("comapp_group"));	//3														  
																	strCompanyName=Helper.correctNull(rs1.getString("comapp_companyname"));//2
																	strBranchlocation=Helper.correctNull(rs1.getString("org_name"));//1
																	strCompanycodeCBS=Helper.correctNull(rs1.getString("CBS_COMPANYCODE"));//4
																
																}
															}
															
															String strCompanydeleted="N";//3
															String strCompanycountrycode=Helper.correctNull((String)hashmap.get("sel_country"));//4
															String strStatus="U";//5
															String strCompanysectorcode=Helper.correctNull((String)hashmap.get("sel_sector"));//6														
															String strMarketsegment=Helper.correctNull((String)hashmap.get("sel_segment"));//7
															String strRBIindustrycode=Helper.correctNull((String)hashmap.get("sel_rbiindustrycode"));//8
															String strStandardizehome=Helper.correctNull((String)hashmap.get("sel_asset"));//9
															String strStandardizedhost=Helper.correctNull((String)hashmap.get("sel_asset"));//10														
															String strIRBhome=Helper.correctNull((String)hashmap.get("sel_asset"));//11
															String strIRBhost=Helper.correctNull((String)hashmap.get("sel_asset"));//12
															String strCoremarketparticipant=Helper.correctNull((String)hashmap.get("sel_core"));//13
															String strIscommericialbank=Helper.correctNull((String)hashmap.get("sel_comm"));//14
															String strPSE=Helper.correctNull((String)hashmap.get("sel_pse"));//15
															String strCentralsovereign=Helper.correctNull((String)hashmap.get("sel_claim"));//16
															String strUpdate=Helper.correctNull((String)hashmap.get("hidsendflag"));
																														
															ArrayList arrValues=new ArrayList();
															HashMap hshQuery=new HashMap();
															HashMap hshQueryvalues=new HashMap();
															
															if(strUpdate.equalsIgnoreCase("Y"))
															{
																hshQueryvalues=new HashMap();
																arrValues=new ArrayList();
																hshQuery=new HashMap();
																
																arrValues.add(strCompanycode);
																hshQuery.put("arrValues", arrValues);
																hshQuery.put("strQueryId", "del_laps_ram_customerprofile");																
																hshQueryvalues.put("1",hshQuery);
																hshQueryvalues.put("size", "1");
																EJBInvoker.executeStateLess("dataaccess",hshQueryvalues,"updateData");
															}
															
															hshQueryvalues=new HashMap();
															arrValues=new ArrayList();
															hshQuery=new HashMap();	
															
															arrValues.add(strBorrowertype);
															arrValues.add(strCompanycode);
															arrValues.add(strCompanyName);
														    arrValues.add(strGroupcode);
															arrValues.add(strBranchlocation);
														    arrValues.add(strCompanydeleted);															
														    arrValues.add(strCompanycountrycode);
															arrValues.add(strCompanysectorcode);
															arrValues.add(strMarketsegment);															
															arrValues.add(strStandardizehome);															
															arrValues.add(strStandardizedhost);
															arrValues.add(strCompanycodeCBS);															
															arrValues.add(strIRBhome);															
															arrValues.add(strIRBhome);
															arrValues.add(strStatus);
															arrValues.add(strRBIindustrycode);															
															arrValues.add(strCoremarketparticipant);
															arrValues.add(strIscommericialbank);
															arrValues.add(strPSE);
															arrValues.add(strCentralsovereign);											
															hshQuery.put("strQueryId","insert_laps_ram_customerprofile");
															hshQuery.put("arrValues",arrValues);
															hshQueryvalues.put("size", "1");
															hshQueryvalues.put("1",hshQuery);															
															EJBInvoker.executeStateLess("dataaccess",hshQueryvalues,"updateData");
															
															// File creation and writing into the file
															if(Exception_flag.equalsIgnoreCase("false"))
															{
															    modelname="COMPANY";																
																String FlatFileName="";																
																FlatFileName=Path+"\\"+modelname+"_"+UserID+"_"+strDate+"_"+strTime+".txt";
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);
																
																// Writing into the File
																
																	bWriter.write(strBorrowertype);// For borrower Type;1
																	bWriter.write("~");
																	
																	bWriter.write(Helper.correctNull(strCompanycode));// For company code; 2
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strGroupcode));// For Group code;3
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanyName));// For Company Name 4
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strBranchlocation));// For Branch Location 5
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanydeleted));// For Company Deleted; 6
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanysectorcode));// For Company Sector code; 7
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanycountrycode));// For Company Country Code; 8
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strMarketsegment));// For Market Segment ; 9
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strStandardizehome));// For Standardized -home;10
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strStandardizedhost));// For Standardized -host;11
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanycodeCBS));// For CompanyCode (cbs code);12
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strIRBhome));// For IRB-HOME 13;
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strIRBhost));// For IRB HOST;14
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strRBIindustrycode));// For RBI INDUSTRY CODE:
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCoremarketparticipant));// For IS THIS CORE MARKET PARTICPANT;15
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strIscommericialbank));// For Is this Commercial bank-home;16
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strPSE));// For IS this PSE;17
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCentralsovereign));// For Is the claim to central sovereign;18
																	//bWriter.write("~");//delimiter
																																		
																	
																	//bWriter.write(Helper.correctNull(strStatus));// For STATUS;																
																	
																	bWriter.close();	
																	
														}
														}	
														catch(Exception e)
														{
															throw new EJBException(e.toString());
														}
														finally
														{
															try
															{
																if(rs1!=null)
																	rs1.close();
															}
															catch(Exception e)
															{
																e.printStackTrace();
															}
														}
													//	hm.put("send_flag",correctNull((String)hashmap.get("hidAction")));
														hm.putAll((HashMap)getRAMParameters(hashmap));
														hm.put("Exception_flag",Exception_flag);
														
														return hm;


												}


//												 END OF COMPANY MASTER
//												getmethod getRamparameter
												
												public HashMap getRAMParameters(HashMap hshValues) 
												{
													ResultSet rs=null;
													String strQuery;
													String strCompanycode="";
													boolean bstate=false;
													String strSendflag="";
													String SENT_FLAG="";
													HashMap hshRecord=new HashMap();
													HashMap hshram1=new HashMap();
													try
													{	 
														if(Helper.correctNull((String)hshValues.get("type")).equalsIgnoreCase("OPS"))
														{
															/*strQuery=SQLParser.getSqlQuery("comfunsel4^"+correctNull((String)hshValues.get("comapp_appno"))+"^"+"N");
															rs=DBUtils.executeQuery(strQuery);
															if(rs.next())
															{
																strCompanycode=Helper.correctNull((String)rs.getString("demo_appid"));
															}*/
															strCompanycode=correctNull((String)hshValues.get("comapp_id"));
															if(strCompanycode.equalsIgnoreCase(""))
															{
																strCompanycode=correctNull((String)hshValues.get("comapp_companyid"));
															}
														}
														else
														{
															strCompanycode=correctNull((String)hshValues.get("comapp_id"));
															if(strCompanycode.equalsIgnoreCase(""))
															{
																strCompanycode=Helper.correctNull((String)hshValues.get("comapp_companyid"));
															}
														}
														String page = correctNull((String)hshValues.get("pageval"));
														strSendflag=correctNull((String)hshValues.get("hidAction"));
														strQuery=SQLParser.getSqlQuery("selRAMparameters^"+strCompanycode);
														rs=DBUtils.executeQuery(strQuery);
														bstate=rs.next();
														
															if(bstate)
															{
																hshRecord.put("companysectorcode",correctNull((String)rs.getString("companysectorcode")));
																hshRecord.put("companycountrycode",correctNull((String)rs.getString("companycountrycode")));
																hshRecord.put("marketsegment",correctNull((String)rs.getString("marketsegment")));
																hshRecord.put("rbiindustrycode",correctNull((String)rs.getString("rbiindustrycode")));
																hshRecord.put("standardhost",correctNull((String)rs.getString("standardhost")));
																hshRecord.put("ismarketparticipant",correctNull((String)rs.getString("marketparticipant")));
																hshRecord.put("iscommercialbank",correctNull((String)rs.getString("commercialbank")));
																hshRecord.put("ispsenotified",correctNull((String)rs.getString("psenotified")));
																hshRecord.put("iscentralsoverign",correctNull((String)rs.getString("centralsoverign")));
																hshRecord.put("flag","Y");	
																hshRecord.put("comapp_id",strCompanycode);
																hshRecord.put("comapp_companyid",strCompanycode);
																hshRecord.put("Sendflag",strSendflag);
																hshRecord.put("comapp_appno",Helper.correctNull((String)hshValues.get("comapp_appno")));
															}
															else
															{
																hshRecord.put("flag","N");	
																hshRecord.put("comapp_id",strCompanycode);
																hshRecord.put("comapp_companyid",strCompanycode);
																
															}
															
															/*if(strSendflag.equalsIgnoreCase("sendtoram"))
															{
																 hshram1=(HashMap)EJBInvoker.executeStateLess("LapsToRam",hshValues,"companyMaster");
																 SENT_FLAG=Helper.correctNull((String)hshram1.get("Exception_flag"));
															}*/
															hshRecord.put("Exception_flag",SENT_FLAG);
															hshRecord.put("page",page);
														
													}catch(Exception e)
													{
														throw new EJBException(e.getMessage());
													}finally
													{
														try
														{
															if(rs!=null)
															{
																rs.close();
															}
														}catch(Exception ex)
														{
															throw new EJBException("Error in closing connection in getRAMParameters");
														}
													}
													return hshRecord;
												}

												/**
												 * 
												 *@created for RETAIL COMPANY MASTER.
												 * 
												 * @AUTHOR S.SATHYA MOORTHY.
												 * 
												 * @NO COMMON METHOD. ONLY SPECIFIC USE.
												 * 
												 * 
												 * 
												 */		
																							
																							
																							
												public HashMap  retailCompanyMaster(HashMap hashmap) 
												{
													
													File Directory = null;
													
													ResultSet rs1= null;
													ResultSet rs2 = null;
													ResultSet rs3 = null;
													ResultSet rs4 = null;
													ResultSet rs5 = null;
													
													
													HashMap hm = new HashMap();
													String strIRBPath1=ApplicationParams.getDRIVEURL();
													String strIRBPath2=ApplicationParams.getDRIVEURL1();
													String rootPath="";
													String FolderName="Masters\\Company\\Data";
														
														String strApplicationNumber=correctNull((String)hashmap.get("applicationnumber"));
														
														String Path="";
														String str_Exception="$";
														log.info("ApplicationNumber in retailCompanyMaster::::------>"+strApplicationNumber);
														//log.info("Path in retailCompanyMaster::::------>"+Path);
														log.info("RootPath inretailCompanyMaster::::------>"+rootPath);
														log.info("FolderName inretailCompanyMaster::::------>"+FolderName);
														try
														{				
															log.info("FolderName::::---->  in retailCompanyMaster  " + FolderName + "\n \n");

															if((new File(strIRBPath1)).exists())
												            {
																rootPath=strIRBPath1;
																log.info("RootPath in IRBPath1  :::: in retailCompanyMaster ---->  " + rootPath  + "\n \n");
																Path = rootPath + FolderName;
																log.info("Path::::------> in retailCompanyMaster  " + Path  + "\n \n");
												                Directory = new File(Path);
												                if(!Directory.exists())
												                {
												                    Directory.mkdirs();
												                }
												            }
															else if((new File(strIRBPath2)).exists())
															{
																rootPath=strIRBPath2;
																log.info("RootPath in IRBPath2  ::::  in retailCompanyMaster  ---->  " + rootPath  + "\n \n");
																Path = rootPath + FolderName;
																log.info("Path::::------> in retailCompanyMaster  " + Path  + "\n \n");
												                Directory = new File(Path);
												                if(!Directory.exists())
												                {
												                    Directory.mkdirs();
												                }
															}
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														
														String modelname="";
														String strDate="";
														String strTime="";
														String query1="";
														String OldCustomerID="";
														String UserID="";
														
														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");
														
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());
														
														FileWriter fout = null;
														
														
														try
														{
															UserID=Helper.correctNull((String)hashmap.get("strUserId"));
															
															if(UserID.equalsIgnoreCase(""))
															{
																UserID=Helper.correctNull((String)hashmap.get("c_username"));
															}
															
															//INSERTING VALUES TO THE TABLE LAPS_RAM 
															
															String strBorrowertype="R";//2
															
															String strCompanycode="";
															String strGroupcode="";
															String strCompanyName="";
															String strBranchlocation="";
															String strCompanycodeCBS="";
															
															if(rs1!=null)
															{
																rs1.close();
															}
															
															query1=SQLParser.getSqlQuery("perselappid^"+strApplicationNumber);
															rs1 = DBUtils.executeQuery(query1);
															if(rs1.next())
															{
																strCompanycode=Helper.correctNull(rs1.getString("demo_appid"));
															}
																
															if(rs1!=null)
															{
																rs1.close();
															}
															
															
															query1 = SQLParser.getSqlQuery("laps_ram_select_retailcustmerprofile^"+strCompanycode);
															rs1 = DBUtils.executeQuery(query1);
															
															if(rs1.next())
															{																
																strCompanyName=Helper.correctNull(rs1.getString("perapp_fname"));
																strBranchlocation=Helper.correctNull(rs1.getString("org_name"));
															}
															
															if(rs1!=null)
															{
																rs1.close();
															}
															
															//Modified by Zahoorunnisa.S to send user loc instead applicant created loc after discussing with Suresh Kumar.G
															 
															query1 = SQLParser.getSqlQuery("laps_ram_select_locationbasedonuser^"+UserID);
															rs1 = DBUtils.executeQuery(query1);
															if(rs1.next())
															{																
																strBranchlocation=Helper.correctNull(rs1.getString("org_name"));
																strBranchlocation="SARAL "+strBranchlocation;
															}
															
															if(rs1!=null)
															{
																rs1.close();
															}
															//End
															
															String strCompanydeleted="N";//3
															String strCompanycountrycode=Helper.correctNull((String)hashmap.get("sel_country"));//4
															String strStatus="U";//5
															String strCompanysectorcode=Helper.correctNull((String)hashmap.get("sel_sector"));//6														
															String strMarketsegment=Helper.correctNull((String)hashmap.get("sel_segment"));//7
															String strRBIindustrycode=Helper.correctNull((String)hashmap.get("sel_rbiindustrycode"));//8
															String strStandardizehome=Helper.correctNull((String)hashmap.get("sel_asset"));//9
															String strStandardizedhost=Helper.correctNull((String)hashmap.get("sel_asset"));//10														
															String strIRBhome=Helper.correctNull((String)hashmap.get("sel_asset"));//11
															String strCoremarketparticipant=Helper.correctNull((String)hashmap.get("sel_core"));//13
															String strIscommericialbank=Helper.correctNull((String)hashmap.get("sel_comm"));//14
															String strPSE=Helper.correctNull((String)hashmap.get("sel_pse"));//15
															String strCentralsovereign=Helper.correctNull((String)hashmap.get("sel_claim"));//16
															
																														
															ArrayList arrValues=new ArrayList();
															HashMap hshQuery=new HashMap();
															arrValues.add(strBorrowertype);
															arrValues.add(strCompanycode);
															arrValues.add(strCompanyName);
														    arrValues.add(strGroupcode);
															arrValues.add(strBranchlocation);
														    arrValues.add(strCompanydeleted);															
														    arrValues.add(strCompanycountrycode);
															arrValues.add(strCompanysectorcode);
															arrValues.add(strMarketsegment);															
															arrValues.add(strStandardizehome);															
															arrValues.add(strStandardizedhost);
															arrValues.add(strCompanycodeCBS);															
															arrValues.add(strIRBhome);															
															arrValues.add(strIRBhome);
															arrValues.add(strStatus);
															arrValues.add(strRBIindustrycode);															
															arrValues.add(strCoremarketparticipant);
															arrValues.add(strIscommericialbank);
															arrValues.add(strPSE);
															arrValues.add(strCentralsovereign);
																							   													
															
															hshQuery.put("strQueryId","insert_laps_ram_customerprofile");
															hshQuery.put("arrValues",arrValues);
															HashMap hshQueryvalues=new HashMap();
															hshQueryvalues.put("size","1");
															hshQueryvalues.put("1",hshQuery);
															
															EJBInvoker.executeStateLess("dataaccess",hshQueryvalues,"updateData");
															
															if(rs1!=null)
															{
																rs1.close();
															}
															
															query1=SQLParser.getSqlQuery("seloldrefidforapp^"+strCompanycode);
															rs1 = DBUtils.executeQuery(query1);
															if(rs1.next())
															{
																OldCustomerID=Helper.correctNull(rs1.getString("perapp_oldid"));
															}
															
															if(!OldCustomerID.equalsIgnoreCase(""))
															{
																strCompanycode=OldCustomerID;
															}
															
															// File creation and writing into the file
															
															    modelname="COMPANY";																
																String FlatFileName="";																
																int queryFlag=0;																
																FlatFileName=Path+"/"+modelname+"_"+UserID+"_"+strDate+"_"+strTime+".txt";
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);
																
																// Writing into the File
																
																	bWriter.write(strBorrowertype);// For borrower Type;1
																	bWriter.write("~");
																	
																	bWriter.write(Helper.correctNull(strCompanycode));// For company code; 2
																	bWriter.write("~");//delimiter
																	
																	//bWriter.write(Helper.correctNull(strGroupcode));// For Group code;3
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strCompanyName));// For Company Name 4
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(strBranchlocation));// For company code; 5
															        bWriter.write("~");//delimiter
																
																	bWriter.write(Helper.correctNull("N"));// For Company Deleted; 6
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For Company Sector code; 7
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For Company Country Code; 8
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For Market Segment ; 9
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For Standardized -home;10
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For Standardized -host;11
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For CompanyCode (cbs code);12
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For IRB-HOME 13;
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("1"));// For IRB HOST;14
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull("0004"));// For RBI INDUSTRY CODE:
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(""));// For IS THIS CORE MARKET PARTICPANT;15
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(""));// For Is this Commercial bank-home;16
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(""));// For IS this PSE;17
																	bWriter.write("~");//delimiter
																	
																	bWriter.write(Helper.correctNull(""));// For Is the claim to central sovereign;18
																	
																	bWriter.close();
														
														}
														catch(Exception e)
														{	
															log.error("Exception from interface : retail company master:::"+e.toString());
															
														}
														finally
														{
															try
															{
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															catch(Exception e)
															{
																e.printStackTrace();
															}
														}
														return hm;
												}


//												 END OF RETAIL COMPANY MASTER


												/**
												 * 
												 *@created for CORPORATE INDUSTRY MASTER.
												 * 
												 * @AUTHOR S.SATHYA MOORTHY.
												 * 
												 * @METHOD USED: NO COMMON METHOD. ONLY SPECIFIC USE.
												 * 
												 * 
												 * 
												 */		
																							
																							
																							
												public HashMap  industryMaster(HashMap hashmap) 
												{
													
													
													File Directory = null;													
													ResultSet rs1= null;
													ResultSet rs2 = null;
													ResultSet rs3 = null;
													ResultSet rs4 = null;
													ResultSet rs5 = null;
													
													HashMap hm = new HashMap();
													String rootPath="Y:/";
													String FolderName="Masters/Industry/Data";
														
														
														String Path=rootPath+FolderName;
														String str_Exception="$";
														
														try
														{				
														    if(new File(rootPath).exists())
														    {
																Directory = new File(Path);		
																	
																if (!Directory.exists())
																{
																	Directory.mkdirs();
																}
														    }
														    else
														    {
														    	str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Industry Master to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														String modelname="";
														String strDate="";
														String strTime="";
														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");
														
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());
														
														FileWriter fout = null;
														int rowcounter=0;
														boolean writeflag=false;
														
														
														try
														{
															
																modelname="INDUSTRYMASTER";
																//creation of Flat File
																String FlatFileName="";
																
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"/"+modelname+"_"+strDate+"_"+strTime+".txt";
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);
																
																
																String query1=SQLParser.getSqlQuery("retail_lapstoram_industrymaster1");
																rs1 = DBUtils.executeQuery(query1);
																
																
																while(rs1.next())
																{
																	bWriter.write(Helper.correctNull(rs1.getString(1)));// For company code;
																	bWriter.write("~");//delimiter
																	bWriter.write(Helper.correctNull(rs1.getString(2)));// For company name
																	bWriter.write("~");//delimiter
																	bWriter.write("N");
																	bWriter.newLine();
																	bWriter.flush();
																	++rowcounter;
																	writeflag=true;
																		
																}	
													
																bWriter.close();
														}
														catch(Exception e)
														{
															
															log.error("Exception from interface:company master:::"+e.toString());
															
														}
														
														
														finally
														{
															try
															{
															if(rs1!=null)rs1.close();
															if(rs2!=null)rs2.close();
															if(rs3!=null)rs3.close();
															if(rs4!=null)rs4.close();
															if(rs5!=null)rs5.close();
															}catch(Exception e){e.printStackTrace();}
															
															
														}
														String msg="";
														if(rowcounter > 0)
														{
															msg="1"+"  Total Rows Exported="+new Integer(rowcounter).toString();
															
															
														}
														else
														{
															msg="0 .Total Rows=0";
															
														}
														
														hm.put("nofiles",msg);
														hm.put("type","Exporting Industry Master");
														
														
														return hm;


												}

//												End of Industry Master

												/**
												 * 
												 *@created for CORPORATE GROUP MASTER.
												 * 
												 * @AUTHOR S.SATHYA MOORTHY.
												 * 
												 * @METHOD USED: NO COMMON METHOD. ONLY SPECIFIC USE.
												 * 
												 * 
												 * 
												 */		
																							
																							
																							
												public HashMap  groupMaster(HashMap hashmap) 
												{
													
													
													File Directory = null;
													
													ResultSet rs1= null;
													ResultSet rs2 = null;
													ResultSet rs3 = null;
													ResultSet rs4 = null;
													ResultSet rs5 = null;
													boolean writeflag=false;
													int rowcount=0;
													
													HashMap hm = new HashMap();
													String strIRBPath1=ApplicationParams.getDRIVEURL();
													String strIRBPath2=ApplicationParams.getDRIVEURL1();
													String rootPath="";
													String FolderName="Masters\\Group\\Data";
														
														
														String Path="";
														String str_Exception="$";
														
														try
														{				
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
																str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
																throw new Exception(str_Exception);
												            }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														
														String modelname="";
														String strDate="";
														String strTime="";
														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");
														
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());
														
														FileWriter fout = null;
														int noofrows=0;
														boolean filewrite=false;
														
														
														try
														{
															
																modelname="GROUPMASTER";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+"_"+strDate+"_"+strTime+".txt";
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);
																
																
																String query1=SQLParser.getSqlQuery("retail_lapstoram_groupmaster1");
																rs1 = DBUtils.executeQuery(query1);
																
																while(rs1.next())
																{
																	bWriter.write(Helper.correctNull(rs1.getString(1)));// For company code;
																	bWriter.write("~");//delimiter
																	bWriter.write(Helper.correctNull(rs1.getString(2)));// For company name
																	bWriter.write("~");//delimiter

																	bWriter.write("N");
																	bWriter.newLine();

																	bWriter.flush();
																	++noofrows;
																	++rowcount;
																	filewrite=true;
																		
																}	
																
																bWriter.close();
														
														}
														
														catch(Exception e)
														{
															
															log.error("Exception from interface:Group master:::"+e.toString());
															
														}
														
														
														finally
														{
															try
															{
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															catch(Exception e)
															{
																e.printStackTrace();
															}
														}
														String msg="";
														if(rowcount > 0)
														{
															msg="1"+"  Total Rows Exported="+new Integer(rowcount).toString();
															
															
														}
														else
														{
															msg="0 .Total Rows=0";
															
														}
														
														hm.put("nofiles",msg);
														hm.put("type","Exporting Group Master");
														return hm;


												}

												/**
												 * 
												 *@created for Interface 
												 * 
												 * @AUTHOR R. MURALIDHARAN
												 * 
												 * @METHOD USED: NO COMMON METHOD. ONLY SPECIFIC USE.
												 * 
												 * @DATE: 12 JULY 2007
												 * 
												 * @MODIFIED_DATE: 12 JANUARY 2008
												 * 
												 * @PROJECT: UBI
												 * 
												 * 
												 */		
														



												public HashMap OperationsPhase(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hashRecord = new HashMap();
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														
														String compant_id="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));			
														String Path="";
														String str_Exception="$";
														
														try
														{	
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
															   	str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														int NoOfYears=35;
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="PFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);				
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears2(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																			
																
																String query2 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs2 = DBUtils.executeQuery(query2);
																while(rs2.next())
																{					
																	//Breakeven Sales Year
																	bWriter.newLine();	
																	bWriter.write("Breakeven Sales Year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_breakevensales")));					
																				
																	//Total Debt required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Debt required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totaldebt")));		
																
																	//Total Equity required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Equity required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totalequity")));
																	
																	//Total Project Cost
																	bWriter.newLine();				
																	bWriter.write("Total Project Cost");									
																	bWriter.write("~");
																	double totprojectcost=Double.parseDouble(Helper.correctDouble(rs2.getString("extra_totprojectcost")));
																	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
																	nf.setGroupingUsed(false);
																	nf.setMaximumFractionDigits(0);
																    nf.setMinimumFractionDigits(0);				  
																    nf.format(totprojectcost);									
																	String extra_totprojectcost=Helper.formatDoubleValue(totprojectcost);					
																	bWriter.write(extra_totprojectcost);
																}
															
																// To find the CMA Number for the application			
																//String query3=SQLParser.getSqlQuery("finselect8^"+applicationno);
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);
																
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	//cmano=Helper.correctNull(rs3.getString("cma_no"));
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																	
																}	
																
																//Equity (Tangible Net Worth) including DTL and net off DTA
																serialno="40";				
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Equity (Tangible Net Worth) including DTL and net off DTA");					
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																
																//Total Debt				
																serialno="41";				
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write(" Total Debt");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Incremental investment in FA				
																serialno="10";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Incremental investment in FA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="11";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Gross Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//Accumulated Depreciation				
																serialno="13";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Accumulated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//net fixed assets				
																serialno="14";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("net fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																serialno="42";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="43";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="15";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("net working capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="16";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("net Fixed Assets + Net Working Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="28";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("cash generated from sale of fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="19";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="20";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("All Non Cash expenses including loss on sale of fixed assets but excluding depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="17";								
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="18";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="21";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="44";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("pretax profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="25";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="26";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("pat");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																				
																if(rs4!=null)rs4.close();										
																tabname="OPERATIONS PHASE";				
																String query4 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query4);
																
																while(rs4.next())
																{
																	//discounting rate based on project risk	
																	bWriter.newLine();
																	bWriter.write("discounting rate based on project risk");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_discountrate")));	
																	
																	//Starting year of the loan sanctioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Starting year of the loan sanctioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_startyrloansanct")));
																	
																	//Ending year of the loan santioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Ending year of the loan santioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_endingyrloansanct")));
																}
																
																//total Term Liabilities (excluding DTL)				
																serialno="45";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("total Term Liabilities (excluding DTL)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//repayment on term liabilities (project loans)				
																serialno="46";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("repayment on term liabilities (project loans)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//total Interest & Finance Charges				
																serialno="22";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("total Interest & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pAT + Dep + Int & Finance Charges				
																serialno="39";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("pAT + Dep + Int & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.
																serialno="47";
																bWriter.newLine();
																bWriter.write("Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Net Profit - Record only projected net profit for all years in this row including past years
																serialno="48";
																bWriter.newLine();
																bWriter.write("Projected Net Profit - Record only projected net profit for all years in this row including past years");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//fixed Cost				
																serialno="29";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("fixed Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//variable Cost				
																serialno="30";							
																tabname="OPERATIONS PHASE";				
																bWriter.newLine();
																bWriter.write("variable Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year
																if(rs4!=null)rs4.close();
																String query5 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query5);
																
																while(rs4.next())
																{				
																	bWriter.newLine();
																	bWriter.write("Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_cashflowstabilize")));
																	
																	//Year to be considered for Base Models (UBI Models 1, 2 or 3)
																	bWriter.newLine();
																	bWriter.write("Year to be considered for Base Models (UBI Models 1, 2 or 3)");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_baseyear")));
																}
																
																	
																
																bWriter.close();
																fout.close();
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}				
														
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
															
														}
													
													return hashmap;
													
												}

													


												public HashMap InfraStructureModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														String compant_id="";
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));			
														String Path="";
														String str_Exception="$";
														
														try
														{				
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
														    	str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														int NoOfYears=35;
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String cmano="";
														String serialno="";		
														String tabname="";
														
														
														
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														
														
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="CFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);	
																
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears2(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																																
																
																String query2 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs2 = DBUtils.executeQuery(query2);
																while(rs2.next())
																{					
																	//Breakeven Sales Year
																	bWriter.newLine();	
																	bWriter.write("Breakeven Sales Year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_breakevensales")));					
																				
																
																	//Total Debt required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Debt required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totaldebt")));					
																
																
																	//Total Equity required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Equity required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totalequity")));
																	
																	//Total Project Cost
																	bWriter.newLine();				
																	bWriter.write("Total Project Cost");									
																	bWriter.write("~");
																	double totprojectcost=Double.parseDouble(Helper.correctDouble(rs2.getString("extra_totprojectcost")));
																	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
																	nf.setGroupingUsed(false);
																	nf.setMaximumFractionDigits(0);
																    nf.setMinimumFractionDigits(0);				  
																    nf.format(totprojectcost);									
																	String extra_totprojectcost=Helper.formatDoubleValue(totprojectcost);					
																	bWriter.write(extra_totprojectcost);
																}
															
																// To find the CMA Number for the application			
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//Equity (Tangible Net Worth) including DTL and net off DTA
																serialno="49";				
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Equity (Tangible Net Worth) including DTL and net off DTA");					
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																
																//Total Debt				
																serialno="50";				
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write(" Total Debt");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Incremental investment in FA				
																serialno="10";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Incremental investment in FA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="11";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Gross Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//Accumulated Depreciation				
																serialno="13";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Accumulated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//net fixed assets				
																serialno="14";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("net fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																serialno="51";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="52";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="15";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("net working capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="16";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("net Fixed Assets + Net Working Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="28";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("cash generated from sale of fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="19";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="20";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("All Non Cash expenses including loss on sale of fixed assets but excluding depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="17";								
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="18";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="21";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="53";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("pretax profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="25";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="26";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("pat");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																				
																if(rs4!=null)rs4.close();										
																tabname="INFRA STRUCTURE MODEL";				
																String query4 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query4);
																
																while(rs4.next())
																{
																	//discounting rate based on project risk	
																	bWriter.newLine();
																	bWriter.write("discounting rate based on project risk");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_discountrate")));	
																	
																	//Starting year of the loan sanctioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Starting year of the loan sanctioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_startyrloansanct")));
																	
																	//Ending year of the loan santioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Ending year of the loan santioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_endingyrloansanct")));
																}
																
																//total Term Liabilities (excluding DTL)				
																serialno="56";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("total Term Liabilities (excluding DTL)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//repayment on term liabilities (project loans)				
																serialno="57";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("repayment on term liabilities (project loans)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//total Interest & Finance Charges				
																serialno="22";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("total Interest & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pAT + Dep + Int & Finance Charges				
																serialno="39";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("pAT + Dep + Int & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.
																serialno="54";
																bWriter.newLine();
																bWriter.write("Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Net Profit - Record only projected net profit for all years in this row including past years
																serialno="55";
																bWriter.newLine();
																bWriter.write("Projected Net Profit - Record only projected net profit for all years in this row including past years");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//fixed Cost				
																serialno="29";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("fixed Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//variable Cost				
																serialno="30";							
																tabname="INFRA STRUCTURE MODEL";				
																bWriter.newLine();
																bWriter.write("variable Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year
																if(rs4!=null)rs4.close();
																String query5 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query5);
																
																while(rs4.next())
																{				
																	bWriter.newLine();
																	bWriter.write("Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_cashflowstabilize")));
																	
//																	Year to be considered for Base Models (UBI Models 1, 2 or 3)
																	bWriter.newLine();
																	bWriter.write("Year to be considered for Base Models (UBI Models 1, 2 or 3)");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_baseyear")));
																}																
																																
																bWriter.close();
																fout.close();
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}				
														
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
															
														}
													
													return hashmap;
													
												}



												public HashMap NbfcModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String compant_id="";
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));			
														String Path="";
														String str_Exception="$";
														
														try
														{
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
														    	str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														//To give the Number of years for this Model
														
														int NoOfYears=3;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
																												
														
														String prefix="CORP";
														String companycode=Helper.correctNull((String)hashmap.get("strOrgShortCode"));
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String seperator="_";
														String flag;
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";
														String printer="";
														int num;
														int formulaid=0;
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="CFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);				
																
																
																// To find the CMA Number for the application			
																//String query3=SQLParser.getSqlQuery("finselect8^"+applicationno);				
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	//cmano=Helper.correctNull(rs3.getString("cma_no"));
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																	
																}	
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																
																
																//No. of months
																serialno="0";				
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("NoOfMonths");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																
																//Gross Sales -  Domestic				
																serialno="3";				
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Finance charges, Service charges etc. under HP business");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Gross Sales - Export				
																serialno="4";								
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Lease income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="5";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Other (income)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
															
																//net fixed assets				
																serialno="6";								
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Total Gross Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																/*serialno="7";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/
																
																//current Liabilities				
																serialno="8";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Interest Paid");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="9";								
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Personnel Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="10";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Administrative & Other expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="11";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Depreciation as per balance sheet (indicate method)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="12";								
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Total Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="13";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Operating Profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																/*serialno="14";								
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Other Income / Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																/*serialno="15";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Add: Other Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/
																
																//depreciation				
																serialno="16";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="17";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Dividends");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="18";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="19";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Non Operating expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="20";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Subtotal of Other Income / Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																/*serialno="21";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Writeoffs & Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/			
																		
																
//																pat				
																serialno="22";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Bad debts w/off net of write back");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="23";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Provision for dimunition in value of assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="24";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Provision for NPAs net of write back");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="25";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Other Provision");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="26";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Total Writeoffs & Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="27";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Profit / Loss before tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																/*serialno="28";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Provision for taxation:");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
																		
																
//																pat				
																serialno="29";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Current Provision for Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="30";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Deferred Provision for Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="31";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Sub Total: Provision for taxation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="32";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Net Profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="33";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Dividend & Dividend tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="34";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Other Appropriations");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="35";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Retained Profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="36";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Cash Accruals");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																/*serialno="37";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("BALANCE SHEET (LIABILITIES ) INPUT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/	
																		
//																pat				
															/*	serialno="38";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("CURRENT LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="39";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from Banks (including bills purchased, discounted & excess borrowings placed on repayment basis)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
																		
//																pat				
																serialno="40";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Bank Borrowings - From our Bank");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="41";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Bank Borrowings - From other Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="42";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Sub Total");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="43";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Deposits (Maturing within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="44";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Sundry Creditors for expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="45";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Sundry Creditors for other finance");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="46";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Advances from customers");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="47";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Interest and other charges accrued but not due");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="48";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Provision for taxation ");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="49";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Dividend payable");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="50";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";			
																bWriter.newLine();
																bWriter.write("Other statutory liabilities (due within 12 months)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="51";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Instalments of Term Loans /Deferred payment credits/ Debentures/ redeemable preference shares (due within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="52";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Other current liabilities & provisions (due within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="53";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Sub Total");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		

//																pat				
																serialno="54";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="56";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";			
																bWriter.newLine();
																bWriter.write("Debentures");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="57";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write(" Redeemable preference shares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="58";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write(" Term Loans" );
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="59";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Borrowings from subsidiaries / affiliates (Quasi Equity)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="60";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Unsecured Loans (Quasi equity)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="61";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Term Deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="62";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Other term liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="63";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Liability");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="64";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Total term liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="65";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";			
																bWriter.newLine();
																bWriter.write("TOTAL OUTSIDE LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																/*serialno="66";							
																tabname="Nbfc ModelL";				
																bWriter.newLine();
																bWriter.write("CAPITAL & RESERVES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="67";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Equity Share Capital ");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		*/	
																
//																pat				
																serialno="68";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";			
																bWriter.newLine();
																bWriter.write("Share Capital (Paid-up)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="69";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Share Application (finalised for allotment)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="70";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Sub Total (Share Capital) ");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
//																pat				
																serialno="71";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("General Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="72";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Capital  Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="73";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Capital Redemption Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="74";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Statutory Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="75";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";			
																bWriter.newLine();
																bWriter.write("Employees Stock Option Outstanding");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="76";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Other reserves & surplus");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="77";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Balance in P&L Account (+ / - )");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="78";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Capital & Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="79";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("TOTAL LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																/*serialno="80";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("BALANCE SHEET (ASSETS) INPUT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="81";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("CURRENT ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		*/	
																		
																
//																pat				
																serialno="82";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Cash & Bank Balances (Excluding Fixed Deposits)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																/*serialno="83";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Investments (Other than long term investments)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
																		
																
//																pat				
																serialno="84";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Govt. and other trustee Securities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="85";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Fixed Deposits with Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="86";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Stock-on-hire under Hire Purchase Agreements (net of finance charges unmatured)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="87";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Sundry Debtors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="88";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Advances to suppliers");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="89";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Advance payment of taxes");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="90";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Other Loans and Advances (interest bearing)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																/*serialno="91";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Other Current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/			
																		
//																pat				
																serialno="92";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Bills Rediscounted");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="93";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Outstanding Credits under lease agreements");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="95";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Excise Duty Receivables");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="96";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("other Current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="97";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("TOTAL CURRENT ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																/*serialno="98";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("FIXED ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
																	
//																pat				
																serialno="99";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Fixed Assets on Lease");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="100";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Less Depreciation to date");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="101";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Sub Total");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="102";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Other Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="103";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Less Depreciation on other Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="104";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Sub Total");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="105";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Net Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
															/*	serialno="106";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("NON-CURRENT ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="107";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Investments / Book Debts / Advances / Deposits (which are not current assets):");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/	
																	
//																pat				
																serialno="108";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Investements in subsidiary companies / affiliates");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="109";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Others (deposits / loans to affiliates/ subsidiaries)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="110";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Unquoted Investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);																	
																
																
//																pat				
																serialno="111";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Housing Loans Outstanding");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="112";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Other miscellaneous assets including dues from directors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="113";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Deferred Tax Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="114";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("TOTAL NON CURRENT ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="115";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Intangible Assets: Goodwill, Patents & trademarks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="116";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("Intangible Assets: Accumulated Losses,Preliminary expenses,Miscellaneous expenditure not w/off, Other deferred revenue expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	

//																pat				
																serialno="117";							
																tabname="BALANCE SHEET (ASSETS) INPUT";					
																bWriter.newLine();
																bWriter.write("TOTAL ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																/*serialno="118";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("TANGIBLE NETWORTH");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat		57		
																serialno="119";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("DIFFERENCE IN B/S");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="120";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Net working capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);*/		
																
//																pat				
																serialno="146";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="147";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Tier I capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="148";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Tier II capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															


															
//																pat				
																/*serialno="121";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("ADDITIONAL INFORMATION");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
															
//																pat				
																serialno="122";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Capital Adequacy Ratio (%)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="123";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gross NPA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="124";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net NPA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="125";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gross Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="126";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Arrears of depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
																
//																pat				
																serialno="149";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net owned funds");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															

															
//																pat				
																/*serialno="127";							
																tabname="Nbfc Model";				
																bWriter.newLine();
																bWriter.write("Contingent liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
															
//																pat				
																serialno="128";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Arrears of cumulative dividends");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="129";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (relating to business)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="130";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (for group companies)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="131";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gratuity Liability not provided for");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
													
															
//																pat				
																serialno="132";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("disputed excise / customs / tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="133";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("LCs");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="134";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("All other contingent liabilities (incldg. Bills purchased - Under LC)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="154";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Overdue");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="155";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("Demand");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																


																bWriter.close();
																fout.close();
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}			
														
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
															
														}
													
													return hashmap;
													
												}
																				
												public HashMap ProjectFinancialInput(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hashRecord = new HashMap();
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														
														String compant_id="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));
														
														String Path="";
														String str_Exception="$";
														
														try
														{				
															if((new File(strIRBPath1)).exists())
												            {
																rootPath=strIRBPath1;
																Path = rootPath + FolderName;
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
															   	str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														String prefix="CORP";
														String companycode=Helper.correctNull((String)hashmap.get("strOrgShortCode"));
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String seperator="_";
														String flag;
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";														
														String printer="";
														
														//To give the Number of years for this Model
														
														int NoOfYears=35;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														int num;
														int formulaid=0;
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														
														
														try
														{			
																String hidUpload=correctNull((String)hashmap.get("hidUpload"));
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="PFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);				
																int i=0;
																
																//To Get The Year Values (35) years
																
																hashRecord=getFinancialYears2(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																	
																
																String query2 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs2 = DBUtils.executeQuery(query2);
																
																while(rs2.next())
																{					
																	//Breakeven Sales Year
																	bWriter.newLine();	
																	bWriter.write("Breakeven Sales Year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_breakevensales")));					
																				
																
																	//Total Debt required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Debt required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totaldebt")));					
																
																
																	//Total Equity required for the entire Project
																	bWriter.newLine();				
																	bWriter.write("Total Equity required for the entire Project");									
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs2.getString("extra_totalequity")));
																	
																	//Total Project Cost
																	bWriter.newLine();				
																	bWriter.write("Total Project Cost");									
																	bWriter.write("~");
																	double totprojectcost=Double.parseDouble(Helper.correctDouble(rs2.getString("EXTRA_TOTPROJECTCOST")));
																	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
																	nf.setGroupingUsed(false);
																	nf.setMaximumFractionDigits(0);
																    nf.setMinimumFractionDigits(0);				  
																    nf.format(totprojectcost);									
																	String extra_totprojectcost=Helper.formatDoubleValue(totprojectcost);					
																	bWriter.write(extra_totprojectcost);
																}
															
																// To find the CMA Number for the application			
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//Equity (Tangible Net Worth) including DTL and net off DTA
																serialno="8";				
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Equity (Tangible Net Worth) including DTL and net off DTA");					
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
																
																//Total Debt				
																serialno="9";				
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write(" Total Debt");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Incremental investment in FA				
																serialno="10";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Incremental investment in FA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="11";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Gross Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//Accumulated Depreciation				
																serialno="13";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Accumulated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//net fixed assets				
																serialno="14";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("net fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																serialno="3";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="4";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="15";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("net working capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="16";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("net Fixed Assets + Net Working Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="28";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("cash generated from sale of fixed assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="19";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="20";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("All Non Cash expenses including loss on sale of fixed assets but excluding depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="17";								
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="18";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="21";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="23";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("pretax profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="25";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="26";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("pat");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																				
																if(rs4!=null)rs4.close();										
																tabname="Project Financial Input";				
																String query4 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query4);
																
																while(rs4.next())
																{
																	//discounting rate based on project risk	
																	bWriter.newLine();
																	bWriter.write("discounting rate based on project risk");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_discountrate")));	
																	
																	//Starting year of the loan sanctioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Starting year of the loan sanctioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_startyrloansanct")));
																	
																	//Ending year of the loan santioned/ to be sanctioned by our bank	
																	bWriter.newLine();
																	bWriter.write("Ending year of the loan santioned/ to be sanctioned by our bank");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_endingyrloansanct")));
																}
																
																//total Term Liabilities (excluding DTL)				
																serialno="42";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("total Term Liabilities (excluding DTL)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//repayment on term liabilities (project loans)				
																serialno="36";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("repayment on term liabilities (project loans)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//total Interest & Finance Charges				
																serialno="22";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("total Interest & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pAT + Dep + Int & Finance Charges				
																serialno="39";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("pAT + Dep + Int & Finance Charges");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.
																serialno="40";
																bWriter.newLine();
																bWriter.write("Projected Sales Revenue - Record only projected sales/ revenue for all years in this row including past years.");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Projected Net Profit - Record only projected net profit for all years in this row including past years
																serialno="41";
																bWriter.newLine();
																bWriter.write("Projected Net Profit - Record only projected net profit for all years in this row including past years");
																bWriter.write("~");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//fixed Cost				
																serialno="29";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("fixed Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//variable Cost				
																serialno="30";							
																tabname="Project Financial Input";				
																bWriter.newLine();
																bWriter.write("variable Cost");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year
																if(rs4!=null)rs4.close();
																String query5 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
																rs4 = DBUtils.executeQuery(query5);
																
																while(rs4.next())
																{				
																	bWriter.newLine();
																	bWriter.write("Enter year from which the cash flows stabalize and are presumed to be the same in every period after this year");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("extra_cashflowstabilize")));
																	
																	//Year to be considered for Base Models (UBI Models 1, 2 or 3)
																	bWriter.newLine();
																	bWriter.write("Year to be considered for Base Models (UBI Models 1, 2 or 3)");
																	bWriter.write("~");
																	bWriter.write(Helper.correctNull(rs4.getString("baseyear")));
																}
																
																hidUpload="Y";
																hashmap.put("hidUpload",hidUpload);
																
																bWriter.close();
																fout.close();
																
																String ProjectFinancialFlag=Helper.correctNull((String)hashmap.get("ProjectFinancialFlag"));
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true" && ProjectFinancialFlag.equalsIgnoreCase("1"))
																{
																	str_Exception = str_Exception + "Project Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																if(finflag=="true" && ProjectFinancialFlag.equalsIgnoreCase("2"))
																{
																	str_Exception = str_Exception + "Large Corporate & Project Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}				
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
														}
													
													return hashmap;
													
												}


												public HashMap BankModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														ResultSet rs6 = null;															
														
														String strFileName="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));	
														String compant_id="";
														
														//To give the Number of years for this Model
														
														int NoOfYears=3;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];														
														String Path="";
														String str_Exception="$";
														
														try
														{				
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
																str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														String prefix="CORP";
														String companycode=Helper.correctNull((String)hashmap.get("strOrgShortCode"));
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String seperator="_";
														String flag;
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";
														
														String printer="";
														int num;
														int formulaid=0;
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="CFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"/"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);				
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																
																// To find the CMA Number for the application			
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//No. of months
																serialno="0";				
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("NoOfMonths");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																
																//Gross Sales -  Domestic				
																serialno="2";				
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Interest/Discount on Advances/Bills");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Gross Sales - Export				
																serialno="3";								
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Income on Investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="4";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Interest on Balance with RBI & Other Interbank Borrowings");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
															
																//net fixed assets				
																serialno="5";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Other Interest Earned");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Assets				
																serialno="6";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Interest Earned");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="7";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Commission, Exchange & Brokerage");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="8";								
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Profit/Loss on Sale/Revaluation of Investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="9";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Profit/Loss on Sale/Revaluation of Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="10";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Profit/Loss on Exchange Transaction");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="11";								
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Income earned by way of dividend");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="12";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Miscellaneous Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="13";								
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Other Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="14";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="15";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Interest on Deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="16";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Interest paid on borrowings from RBI/Interbank");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="17";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("other interest expended");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="18";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("total interest expended");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="19";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Operating Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
																//pat				
																serialno="23";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
																
//																pat				
																serialno="20";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Provision for Loan Losses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="21";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Provision for Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="22";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Provision for investment");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
												/*				pat				
																serialno="23";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Provision for Diminution in value of securities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		*/
																
//																pat				
																serialno="24";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="25";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="26";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Provisions & Contingencies");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="27";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Expenditure");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="28";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Net Profit for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="29";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Profit brought forward");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="30";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Loss brought forward");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="31";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("PROFIT/LOSS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="33";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	

													
//																pat				
																serialno="34";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Transfer to Statutory Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="35";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Transfer to Capital Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="36";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Transfer to Revenue and other Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="37";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Dividend and Tax thereon paid");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="38";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Proposed Dividend");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="39";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Dividend Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="40";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Balance carried over to balance sheet");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="41";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Total Transfers");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																														
//																pat				
																serialno="43";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="44";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Statutory Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="45";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Revaluation Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="46";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Share Premium");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="47";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Investment Fluctuation Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="48";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Other Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="49";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Balance in P&L Ac");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="50";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Reserves & Surplus");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="52";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="53";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Borrowings and Other Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="54";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="55";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Defered Tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="56";							
																tabname="BALANCE SHEET (LIABILITIES) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Capital & Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
												/*				pat				
																serialno="57";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("BALANCE SHEET (ASSETS) INPUT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		*/	
																		
//																pat				
																serialno="58";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Cash & Balance with RBI");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
																
//																pat				
																serialno="59";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Balance with Banks & Money at call & short notice");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																		

//																pat				
																serialno="61";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Investments in G-Sec");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="62";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Invt in Other Approved Securities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="63";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Invt in Shares, Debentures & Bonds");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="64";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Invt in Subsidiaries/ Joint Ventures");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="65";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Invt in Others ( MF,IVP, CP etc)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="66";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="67";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="68";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Fixed Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="69";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Other Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="70";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Intangiable Assets including Deferred Tax Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="71";							
																tabname="BALANCE SHEET (ASSETS) INPUT";				
																bWriter.newLine();
																bWriter.write("Total Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="74";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Tier I Capital (%)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="75";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("CAR (%)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="76";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gross Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
															
//																pat				
																serialno="77";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gross NPA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
																
//																pat				
																serialno="78";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net NPA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
																
//																pat				
																serialno="100";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("current Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
													
//																pat				
																serialno="101";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="102";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Tier I Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
													
//																pat				
																serialno="103";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Tier II Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="104";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net Advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
																
//																pat				
																serialno="105";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Net owned funds");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
																			
																	
//																pat				
																serialno="106";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Overdue");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="107";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Demand");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
													
													
												/*				pat				
																serialno="79";							
																tabname="Bank Model";				
																bWriter.newLine();
																bWriter.write("Contingent liabilities ");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	*/		
																		
																
//																pat				
																serialno="80";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Arrears of cumulative dividends");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="81";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (relating to business)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="82";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (for group companies)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="83";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gratuity Liability not provided for");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="84";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Disputed excise / customs / tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="85";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("LCs");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="86";							
																tabname="ADDITIONAL INFORMATION";			
																bWriter.newLine();
																bWriter.write("All other contingent liabilities (incldg. Bills purchased - Under LC)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		

																bWriter.close();
																fout.close();
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}				
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															catch(Exception e)
															{
																e.printStackTrace();
															}
														}
													return hashmap;
													
												}

												public HashMap RealEstateModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														ResultSet rs4 = null;
														ResultSet rs5 = null;
														ResultSet rs6 = null;	
														
														//To give the Number of years for this Model
														
														int NoOfYears=5;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														//----														
														String compant_id="";
														String strFileName="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));			
														String Path="";
														String str_Exception="$";
														try
														{				
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
																str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														String prefix="CORP";
														String companycode=Helper.correctNull((String)hashmap.get("strOrgShortCode"));
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String seperator="_";
														String flag;
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";														
														String printer="";
														int num;
														int formulaid=0;
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
																															
																
																//creation of Flat File
																
																modelname="CFIN";
																String FlatFileName="";																
																int queryFlag=0;
																
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);	
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));																
																
																
																// To find the CMA Number for the application	
																
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//No. of Months
																serialno="0";				
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("NoOfMonths");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Value of work completed
																serialno="3";				
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Value of work completed");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Gross Sales - Export				
																serialno="4";								
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Add: Closing Work-in-progress");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="5";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Less: Opening Work-in-progress");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//net fixed assets				
																serialno="6";								
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("GROSS REVENUE (1+2-3)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																serialno="8";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Materials consumed");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="9";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Sub-contract work");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="10";								
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Salaries & wages");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="11";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Repairs & Maintenance");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="12";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Other construction expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="13";								
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="14";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("COST OF CONSTRUCTION");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="15";								
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("GROSS PROFIT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="16";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="17";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("General & Administrative Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="18";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Provision for abnormal losses / claims etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="19";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("SUB - TOTAL");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="20";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("OPERATING PROFIT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="23";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Profit on sale of assets/ investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="24";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Interest from investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="25";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Forex gains");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="26";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Non-op. income from subsidiaries");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="27";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Tax Refund");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="28";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Other Non Operating Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="29";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Total non-operating Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="31";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Loss on sale of assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="32";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Prem. Expenses w/off");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="33";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Other Non- operating exp.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="34";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Total non-operating Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="35";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Net of Non-operating Income and Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="36";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Profit before tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="38";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Current tax provision");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="39";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Deferred tax provision");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="40";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Sub Total: Provision for tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="41";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Net Profit After tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="43";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Prior Period Adjustments (+)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="44";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Prior Period Adjustments (-)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="45";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Prior Period Adjustments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="46";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Balance for appropriation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="48";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Dividend paid On Equity Cap");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="49";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Dividend paid On Preference Share Cap");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="50";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Dividend Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="51";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Partners Withdrawl");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="52";							
																tabname="REAL ESTATE MODEL";				
																bWriter.newLine();
																bWriter.write("Retained profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="56";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from applicant banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="57";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from other banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="58";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Sub-total ( Short Term Borrowing from banks)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="59";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from others (repayable within 12 months)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="60";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Deposits (Maturing within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="61";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Mobilisation / works advances received from client");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="63";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Creditors for materials");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="64";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Creditors for outstanding payments towards wages and salaries");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		

//																pat				
																serialno="65";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Creditors for for other expenses (towards hire charges of machinery etc");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="66";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Creditors for outstanding payments to sub contractors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="67";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Unsecured loans (repayable within 12 months)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="68";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Advances / progress payments from customers , if any. Deposits from sub contractors repayable within 12 months");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="69";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Interest and other chrages accured but not due for payment");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="71";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Tax Provision");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="72";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Others Provision");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="73";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Dividend payable");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="74";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Other statutory liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="75";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Current Portion of Long Term Debt");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="76";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Other current liabilities & provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="171";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Current Liabilities other than bank borrowings");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="78";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Total Current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="80";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Debentures");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="81";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Redeemable preference shares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="82";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Term loans");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="83";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Term Loans From Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="84";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Term deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="85";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Unsecured loans (quasi equity)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="86";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("mobilisation / works advances received from clientele and recoverable / repayable after 1 year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="87";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Advances / progress payments from customers , if any. Deposits from sub contractotrs repayable after 1 year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="90";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Liability");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="88";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("Other term liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="89";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("TOTAL TERM LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="91";							
																tabname="LIABILITIES";				
																bWriter.newLine();
																bWriter.write("TOTAL OUTSIDE LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="94";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Share Capital (Paid-up)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="95";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Share Application (finanlized for allotment)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="96";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Sub Total Share Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="97";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("General reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="98";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Revaluation Reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="99";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Other reserves & Surplus");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="100";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Partners capital / Proprietors capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="101";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Share Premium");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="102";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Capital subsidy");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="103";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Any other reserves");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="104";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("Surplus (+) or deficit (-) in profit and loss account");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="106";							
																tabname="NETWORTH";				
																bWriter.newLine();
																bWriter.write("TOTAL LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="109";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Cash & bank balances (excluding fixed deposits)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="111";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Deposits encumbered for raising CCSDL, etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="112";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Unencumbered deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="113";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Receivables - upto 180 days (bills raised but ending for payment) other than deferred & export receivables (including bills / supply bills purchased & discounted by bankers)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="114";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Export receivables - upto 180 days (bills raised but pending for payment) including bills / supply bills purchased & discounted by bankers.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="115";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Instalments of deferred payment receivables (due within 1 year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="116";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Inventory of materials (viz. cement, iron / steel, etc.) & consumable spares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="117";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Work-in-progress (not completed for the purpose of raising work bills)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="118";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("work completed (in respect of works completed but bills are yet to be raised)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="119";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Commission due and to be received from sub contractors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="120";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Mobilisation / works advance given to sub contractors & recoverable / repayable within 12 months");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="121";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Advances to suppliers of materials, consumable stores and spares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="122";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Advance payment of taxes / Tax deducted at source (net of provision for tax)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="123";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Other Current assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="124";							
																tabname="ASSETS";			
																bWriter.newLine();
																bWriter.write("TOTAL CURRENT ASSETS (total of items 34 to 43)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="126";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Gross Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="127";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Accumalated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="128";							
																tabname="ASSETS";			
																bWriter.newLine();
																bWriter.write("NET BLOCK");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="129";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Capital Work in Progress");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="131";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Mobilisation  / works advance given to sub contractors & recoverable / repayable after 12 months");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="132";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("SD / EMD / retention money / other deposits lying with contract awarding authorities to the extent recovererable / repayable after 1 year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="133";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Investments / book debts / advances / deposits which are not current assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="134";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Investments/ Loans in subsidiary companies / affiliates");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="135";							
																tabname="ASSETS";			
																bWriter.newLine();
																bWriter.write("Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="136";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Advances to suppliers of capital goods / spares & for capital expenditure");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="137";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Deferred receivables (other than those maturing within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="138";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Investmnets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat		57		
																serialno="139";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Held as cash margin for BGs & DPGs, etc.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="140";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Debtors > 6 months");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="141";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Non-consumable stores & spares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="142";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="143";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Other misc assets including dues from directors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="144";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("TOTAL NON-CURRENT ASSETS");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="145";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Intangible assets (patents, goodwill, trademarks)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="146";							
																tabname="ASSETS";				
																bWriter.newLine();
																bWriter.write("Accumulated Losses,Preliminary expenses,Miscellaneous expenditure not w/off, Other deferred revenue expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="150";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("arrears of depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="169";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("Projected Net Sales for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="170";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("Projected Net Profit for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="152";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("arrears of cumulative dividend");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="153";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("guarantees issued (relating to business)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="154";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("guarantees issued (for group companies)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="155";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("gratuty Liability not provided for");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="156";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("disputed excise / customs / tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="157";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("All other contingent liabilities(incldg. Bills purchased - Under LC)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="158";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits (due within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="159";							
																tabname="ADDITIONAL INFORMATION";					
																bWriter.newLine();
																bWriter.write("preference Share Capital (due in less than a year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
																bWriter.close();
																fout.close();
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}			
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
																if(rs4!=null)rs4.close();
																if(rs5!=null)rs5.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
														}
													
													return hashmap;
													
												}

												public HashMap LargeCorporateModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs3 = null;
																																										
														//To give the Number of years for this Model
														
														int NoOfYears=5;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														String compant_id="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));
														String Path="";
														String str_Exception="$";
														
														try
														{				
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
																str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
																throw new Exception(str_Exception);
														    }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}
														
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String cmano="";
														String serialno="";		
														String tabname="";
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="CFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);				
																
																
																// To find the CMA Number for the application			
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																
																//No. of months
																serialno="0";				
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("NoOfMonths");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Gross Sales -  Domestic				
																serialno="3";				
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Gross Sales - Domestic");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Gross Sales - Export				
																serialno="4";								
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Gross Sales - Export");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																
																//Gross Fixed Assets				
																serialno="5";							
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Sub Total (Gross Sales)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//Accumulated Depreciation				
																serialno="6";								
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Less Excise Duty");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//net fixed assets				
																serialno="7";								
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Net Sales");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																
																//current Assets				
																serialno="10";							
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Export Incentives");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//current Liabilities				
																serialno="11";							
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Duty Drawback");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net working capital				
																serialno="12";								
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//net Fixed Assets + Net Working Capital				
																serialno="13";							
																tabname="LARGE CORPORATE MODEL";				
																bWriter.newLine();
																bWriter.write("Total Operating Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//cash generated from sale of fixed assets				
																serialno="16";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Raw materials consumed imported");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																	
																//All Non cash revenue such as profit on sale of fixed assets, appreciation in the value of assets, forex gains etc.
																serialno="17";								
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Raw materials consumed indigenous");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//All Non Cash expenses including loss on sale of fixed assets but excluding depreciation				
																serialno="19";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Other Spares consumed Imported");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Sales / Revenue from the project (For all past years record the actual sales/ revenue while for all future years record projected sales/ revenue in this row			
																serialno="20";								
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Other spares consumed Indigenous");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//Expenses incurred due to the functioning of the project other than capital expenditure, depreciation and interest				
																serialno="21";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Power and fuel");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//depreciation				
																serialno="22";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Direct labour and wages");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pretax profit				
																serialno="23";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Repair and maintanance");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//tax				
																serialno="24";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("other manufacturing expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="25";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																//pat				
																serialno="26";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("sub Total (A)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="27";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("add: Op. Stock of WIP");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="28";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("less: Cl. Stock of WIP");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="29";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("total Cost of Production");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="30";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("add Opening Stock of Finished Goods");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="31";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("less: Cl. Stock  of Finished Goods");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="32";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("total Cost of Sales");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="33";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("selling, Gen. & Administration Exp");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="34";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("cost of Sales + SGA");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="35";							
																tabname="COST OF SALES";				
																bWriter.newLine();
																bWriter.write("Operating Profit before Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="37";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("interest To Banks- WC");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="38";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("interest  to banks- Term Loans");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="40";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("interest to FIs- WC");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="41";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("interest to FIs - Term Loans");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="42";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("total Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="43";							
																tabname="INTEREST PAYMENT TO BANKS";				
																bWriter.newLine();
																bWriter.write("Operating Profit after Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="46";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Profit on sale of assets/ investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="47";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Investments and Dividend");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="48";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Forex gains");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="49";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Non-op. income from subsidiaries");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="50";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Tax Refund");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="51";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Other Non Operating Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="52";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Total non-operating Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="54";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Loss on sale of assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="55";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Prem. Expenses w/off");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="56";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Other Non- operating exp.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="57";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Total Non-operating expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="58";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Net of Non-operating Income / Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="59";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Profit Before Interest Depreciation & Taxes (PBIDT");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="60";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Profit Before tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="62";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Provision for taxation:Current");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="63";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Provision for taxation:Deferred");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="64";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Sub Total: Provision for taxation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="65";							
																tabname="NON OPERATING ITEMS";				
																bWriter.newLine();
																bWriter.write("Net Profit After tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		

//																pat				
																serialno="67";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Extraordinary Income adjustments (+)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="68";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Extraordinary Expenses adjustments (-)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="70";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Adjusted PAT (excl Extraordinary  Items)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="72";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Dividend Paid on Equity Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="73";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Dividend Paid on Preference Sh. Capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="74";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Dividend tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="75";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Partners Withdrawal");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="76";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Dividend (%)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="77";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Retained Profit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="78";							
																tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
																bWriter.newLine();
																bWriter.write("Cash Accruals");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="82";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Bank Borrowings - From our Bank");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="83";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Bank Borrowings - From other Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="84";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Sub Total");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="85";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from Associates & Group Concerns");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="86";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Short term borrowings from Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="87";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Creditors for purchases");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="88";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Advs/ pymts from customers/deposits from dealers");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
//																pat				
																serialno="90";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Tax Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="91";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Other Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="92";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Dividends Payable");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="93";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Interest and other Charges Accrued but not Due");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="94";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("statutory liabilities due within one year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="95";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits / redeemable preference shares (due within one year) - To Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="96";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="97";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("other Current Liabilities due within one year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="98";							
																tabname="BALANCE SHEET (LIABILITIES )";				
																bWriter.newLine();
																bWriter.write("total Current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="100";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Debentures");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="101";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Preference share capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="102";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Dealers Deposit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="103";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Liability");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
																
//																pat				
																serialno="104";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Term Loans  - From Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="105";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Term Loans - From Fis");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="106";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Term Deposits");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="107";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Borrowings from subsidiaries / affiliates (Quasi E");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="108";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Unsecured Loans (Quasi Equity)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="109";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Other term liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="110";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Total Term Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="111";							
																tabname="BALANCE SHEET(TERM LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("TOTAL OUTSIDE LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																		
//																pat				
																serialno="114";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Share Capital (Paid-up)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="115";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Share Application (finalised for allotment)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="116";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Sub Total (Share Capital)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="117";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("General Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="118";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Capital  Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="119";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Capital Redemption Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="120";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Statutory Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="121";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Employees Stock Option Outstanding");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="122";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("revaluation Reserve");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="123";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("partners capital / Proprietors capital");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="125";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Share Premium");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat				
																serialno="126";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Capital Subsidy");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="127";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("other reserves and surplus");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="128";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("balance in P&L Account (+ / - )");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="129";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("total networth");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="130";							
																tabname="NET WORTH";				
																bWriter.newLine();
																bWriter.write("Total Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="133";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Cash & Bank Balances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="135";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Investments in Govt. and other trustee Securities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="136";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Fixed Deposits with Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="137";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other Investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="139";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Receivables other than defered & export (Domestic)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="140";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Export Receivables");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="144";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Deferred receivable (due within 1 yr.)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="146";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Raw Materials - Imported");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																	
//																pat				
																serialno="147";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Raw Materials - Indigenous");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
																
//																pat		57		
																serialno="148";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Work in process");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="149";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Finished Goods (incl Traded Goods)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="150";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other consumable spares - Imported");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="151";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other consumable spares -  Indigenous");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="152";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Sub total (Inventory)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="153";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Advances to suppliers");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="154";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Advance payment of tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="155";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Excise Duty Receivables");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="156";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("other Current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="157";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("total current assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="159";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Gross Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="160";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Less: Accumulated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="161";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Net Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="162";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Capital Work in progress");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="165";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Investments in Group concerns");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="166";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Loans to group concerns / Advances to subsidiaries");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="167";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Investments in others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="168";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Advances to suppliers of capital goods and contrac");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="169";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Deferred receivables (maturity exceeding one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="170";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Debtors > 6 mths.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="171";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Others (Loans & Advances non current in nature, ICDs etc");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="172";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="173";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other Non-current Assets(incld. Dues from directors)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="174";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Total Non Current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="175";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Goodwill Patents trademarks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="176";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Accumulated Losses Preliminary expenses Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="177";							
																tabname="BALANCE SHEET(FIXED ASSETS)";				
																bWriter.newLine();
																bWriter.write("Total Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																
//																pat				
																serialno="206";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Projected Net Sales for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="207";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Projected Net Profit for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="186";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Arrears of cumulative dividends");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="187";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (relating to business)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="188";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Guarantees issued (for group companies)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="189";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Gratuity Liability not provided for");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="190";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Disputed excise / customs / tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="191";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("LCs");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="192";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("All other contingent liabs (incl Bills payable)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
															
//																pat				
																serialno="184";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Arrears of depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
																

//																pat				
																serialno="193";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits (due within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
																
//																pat				
																serialno="209";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Preference Share Capital (due in less than a year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																String finflag="true";
																bWriter.close();
																fout.close();
																
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Large Corporate Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}		
														
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs3!=null)rs3.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
															
														}
													
													return hashmap;
													
												}


												/**
												 * 
												 *@created for FINANCIAL 
												 * 
												 * @AUTHOR R. MURALIDHARAN
												 * 
												 * @METHOD USED: NO COMMON METHOD. ONLY SPECIFIC USE.
												 * 
												 * @DATE: 12 JULY 2007
												 * 
												 * @PROJECT: UBI
												 * 
												 * 
												 */		


//												private void getFinancialvalues(String sno,String cma_no,String appno,String tab_name,String fin_yeartype[],BufferedWriter writer) 
//												 
//												{
//													ResultSet rs= null;
//													String query="",year1="";
//													String finvalues="";
//													int num=0;	
//													int formulaid=0;
//													
//													try
//													{
//														BufferedWriter bWriter = writer;
//														query=SQLParser.getSqlQuery("lapstoram_finvalues^"+sno+"^"+cma_no+"^"+appno+"^"+tab_name);				
//														rs=DBUtils.executeQuery(query);
//														
//														while(rs.next())
//														{
//															finvalues="";
//															num=num+1;
//															formulaid=rs.getInt("fin_formula");
//															year1=Helper.correctNull(rs.getString("fin_year"));
//															/*if(formulaid>0)
//															{
//																HashMap hshformula =  new HashMap();
//																hshformula.put("appno",appno);
//																hshformula.put("formulaid",Integer.toString(formulaid));
//																hshformula.put("curryear",year1);
//																hshformula.put("prevyear"," ");
//																hshformula.put("currfinancialtype",fin_yeartype[num]);
//																hshformula.put("prevfinancialtype","a");
//																hshformula.put("internalcalc","N");
//																hshformula.put("hshdata",new HashMap());
//																HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
//																finvalues=correctNull((String)hshRes.get("strTotalValue"));
//															}
//															else
//															{*/
//																if(fin_yeartype[num].equalsIgnoreCase("a"))
//																{
//																	finvalues=Helper.correctNull(rs.getString("fin_audit"));
//																}
//																else if(fin_yeartype[num].equalsIgnoreCase("u"))
//																{
//																	finvalues=Helper.correctNull(rs.getString("fin_unaudit"));
//																}
//																else if(fin_yeartype[num].equalsIgnoreCase("e"))
//																{
//																	finvalues=Helper.correctNull(rs.getString("fin_estimated"));
//																}
//																else if(fin_yeartype[num].equalsIgnoreCase("p"))
//																{
//																	finvalues=Helper.correctNull(rs.getString("fin_projection"));
//																}
//															//}
//															bWriter.write("~");
//															bWriter.write(finvalues);
//														}
//													}
//													
//													catch(Exception e)
//													{
//														log.error("Exception from interface : Financial ----> getFinancialvalues :::"+e.toString());		
//													}		
//													
//													finally
//													{
//														try
//														{
//															if(rs!=null)rs.close();			
//														}
//														
//														catch(Exception e)
//														{
//															e.printStackTrace();
//														}
//													}	
//													
//												}
												
												/**
												 * 
												 *@created for Interface
												 * 
												 * @AUTHOR R. MURALIDHARAN
												 * 
												 * @METHOD USED: To Get Individual Row Item values from Financials 
												 * 
												 * @DATE: 24 November 2007
												 * 
												 * @PROJECT: UBI
												 * 
												 * 
												 */		
												
												
												private void getFinancialvalues2(String sno,String cma_no,String appno,String tab_name,String fin_yeartype[],BufferedWriter writer,String years[]) 
												 
												{
													ResultSet rs= null;
													String query="",year1="";
													String year="";
													String finvalues="";													
													int formulaid=0;
													
													try
													{
														BufferedWriter bWriter = writer;
														for(int i=0;i<years.length;i++)
														{
															year=Helper.correctNull(years[i]);
															if(!year.equalsIgnoreCase("0"))
															{
																if(rs!=null)
																{
																	rs.close();
																}
																query=SQLParser.getSqlQuery("lapstoram_finvalues_new^"+sno+"^"+cma_no+"^"+appno+"^"+tab_name+"^"+year);				
																rs=DBUtils.executeQuery(query);
														
																if(rs.next())
																{
																	finvalues="";																	
																	formulaid=rs.getInt("fin_formula");
																	year1=Helper.correctNull(rs.getString("fin_year"));
																	/*if(formulaid>0)
																	{
																		HashMap hshformula =  new HashMap();
																		hshformula.put("appno",appno);
																		hshformula.put("formulaid",Integer.toString(formulaid));
																		hshformula.put("curryear",year1);
																		hshformula.put("prevyear"," ");
																		hshformula.put("currfinancialtype",fin_yeartype[i]);
																		hshformula.put("prevfinancialtype","a");
																		hshformula.put("internalcalc","N");
																		hshformula.put("hshdata",new HashMap());
																		HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
																		finvalues=correctNull((String)hshRes.get("strTotalValue"));
																	}
																	else
																	{*/
																		if(fin_yeartype[i].equalsIgnoreCase("a"))
																		{
																			finvalues=Helper.correctNull(rs.getString("fin_audit"));
																		}
																		else if(fin_yeartype[i].equalsIgnoreCase("u"))
																		{
																			finvalues=Helper.correctNull(rs.getString("fin_unaudit"));
																		}
																		else if(fin_yeartype[i].equalsIgnoreCase("e"))
																		{
																			finvalues=Helper.correctNull(rs.getString("fin_estimated"));
																		}
																		else if(fin_yeartype[i].equalsIgnoreCase("p"))
																		{
																			finvalues=Helper.correctNull(rs.getString("fin_projection"));
																		}
																	//}
																	bWriter.write("~");
																	bWriter.write(finvalues);
																}
																else
																{
																	bWriter.write("~");
																	bWriter.write("0");
																}
																
															}
															else
															{
																bWriter.write("~");
																bWriter.write("0");
															}
														}
													}
													
													catch(Exception e)
													{
														log.error("Exception from interface : Financial ---> getFinancialvalues2 ::: "+e.toString());		
													}		
													
													finally
													{
														try
														{
															if(rs!=null)rs.close();			
														}
														
														catch(Exception e)
														{
															e.printStackTrace();
														}
													}	
													
												}
												
												/**
												 * 
												 *@created for Interface
												 * 
												 * @AUTHOR R. MURALIDHARAN
												 * 
												 * @METHOD USED: To Get the Financial Years as per the Model (Previous,Current,Next)
												 * 
												 * @DATE: 24 November 2007
												 * 
												 * @MODIFIED_DATE: 11 January 2008
												 *
												 * @PROJECT: UBI
												 * 
												 * 
												 */	
												
												private HashMap getFinancialYears(String applicationno,int NoOfYears,BufferedWriter writer)  
												{
													ResultSet rs1= null;
													ResultSet rs= null;
													HashMap HashRecord=new HashMap();
													String query="",year="",strQuery="",CurrentYear="";
													String finvalues="",CurrentBaseYear="",BaseYear="";
													String Prev_Year[]=new String[5];
													String Next_Year[]=new String[5];
													String yeartype[]= new String[NoOfYears];
													String years[]= new String[NoOfYears];
													String fin_yeartype[]= new String[NoOfYears];
													String tempYear="",cmano="";
													int num=0,temp=0;	
													int Current_Year=0;
													int No_Prev_Years=0;
													int No_Next_Years=0;
													int Temp_Year1=0,Temp_Year2=0;
													int formulaid=0;
													String strExp="$";
													try
													{
														BufferedWriter bWriter = writer;
														
														
														//TO GET BASE YEAR
															
														strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^"+applicationno);
														if(rs1!=null)
															rs1.close();
														rs1=DBUtils.executeQuery(strQuery);
														if(rs1.next())
														{
															BaseYear=Helper.correctNull(rs1.getString("base_year"));
															CurrentBaseYear=Helper.correctNull(rs1.getString("year"));
														}
														/*else
														{
															strExp=strExp+" Base Year Not entered";
															throw new EJBException(strExp);
														}*/
														
														Current_Year=Integer.parseInt(CurrentBaseYear);
														
														if(rs!=null)
														{
															rs.close();
														}
														
														query=SQLParser.getSqlQuery("lapstoram_yeartype^"+applicationno+"^"+BaseYear);
														rs = DBUtils.executeQuery(query);
														
														if(rs.next())
														{						
															CurrentYear=Helper.correctNull(rs.getString("fin_year"));														
														}
														else
														{
															CurrentYear="0";
														}
														
														// TO FIND PREVIOUS 2 YEARS AND NEXT 2 YEARS 
														
														if(NoOfYears==5)
														{
															No_Prev_Years=2;
															No_Next_Years=2;
														}
														
														// TO FIND PREVIOUS 2 YEARS
														
														if(NoOfYears==3)
														{
															No_Prev_Years=2;
															No_Next_Years=0;
														}
													
														Temp_Year1=Current_Year;
														Temp_Year2=Current_Year;
														
														for(int i=1;i<=NoOfYears;i++)
														{
															if(i>No_Prev_Years)				
																break;
															
															Temp_Year1=Temp_Year1-1;
															
															if(rs!=null)
															{
																rs.close();
															}
															query=SQLParser.getSqlQuery("lapstoram_yeartype2^"+applicationno+"^"+Integer.toString(Temp_Year1));
															rs = DBUtils.executeQuery(query);
															
															if(rs.next())
															{						
																Prev_Year[i]=Helper.correctNull(rs.getString("fin_year"));																
															}
															else
															{
																Prev_Year[i]="0";
															}
															
															if(No_Next_Years > 0)
															{
																Temp_Year2=Temp_Year2+1;
																
																if(rs!=null)
																{
																	rs.close();
																}
																query=SQLParser.getSqlQuery("lapstoram_yeartype2^"+applicationno+"^"+Integer.toString(Temp_Year2));
																rs = DBUtils.executeQuery(query);
																
																if(rs.next())
																{						
																	Next_Year[i]=Helper.correctNull(rs.getString("fin_year"));														
																}
																else
																{
																	Next_Year[i]="0";
																}
															}
														}
														
														//Total Years
														
														temp=0;														
														
														if(!Prev_Year[2].equalsIgnoreCase(""))
														{
															years[temp]=Prev_Year[2];
															temp=temp+1;
														}														
														
														if(!Prev_Year[1].equalsIgnoreCase(""))
														{
															years[temp]=Prev_Year[1];
															temp=temp+1;
														}
														if(!CurrentYear.equalsIgnoreCase(""))
														{
															years[temp]=CurrentYear;
															temp=temp+1;
														}
														if(NoOfYears==5)
														{
															if(!Next_Year[1].equalsIgnoreCase(""))
															{
																years[temp]=Next_Year[1];
																temp=temp+1;
															}
														
															if(!Next_Year[2].equalsIgnoreCase(""))
															{
																years[temp]=Next_Year[2];
																temp=temp+1;
															}
														}														
														
														//Writing into the File
														
														//Year Ending date(DD-MM-YYYY)
														
														tempYear="";
														
														bWriter.write("Year Ending date(DD-MM-YYYY)");
														
														for(int i=0;i<years.length;i++)
														{		
															tempYear=Helper.correctNull(years[i]);
															if(!tempYear.equalsIgnoreCase("0"))
															{
																bWriter.write("~");
																bWriter.write(Helper.correctNull(years[i]));	
															}
															else
															{
																bWriter.write("~");																	
															}
														}
														
														//YearType
														
														if(rs!=null)
														{
															rs.close();
														}
														int i=0;
														tempYear="";
														bWriter.newLine();
														bWriter.write("YearType");														
														
														for(int z=0;z<years.length;z++)
														{															
															tempYear=Helper.correctNull(years[z]);
															if(!tempYear.equalsIgnoreCase("0"))
															{
																year=Helper.correctNull(years[z]);
																query=SQLParser.getSqlQuery("lapstoram_yeartype^"+applicationno+"^"+year);
																rs = DBUtils.executeQuery(query);
																
																if(rs.next())
																{						
																	if(!rs.getString("sumaudit").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Audited";
																		fin_yeartype[i]="a";
																	}
																	else if(!rs.getString("sumunaudit").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="UnAudited";
																		fin_yeartype[i]="u";
																	}
																	else if(!rs.getString("sumestimated").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Estimated";
																		fin_yeartype[i]="e";
																	}
																	else if(!rs.getString("sumprojection").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Projected";
																		fin_yeartype[i]="p";
																	}				
																	bWriter.write("~");
																	bWriter.write(yeartype[i]);
																	i=i+1;
																}
															}
															else
															{
																yeartype[i]="0";
																fin_yeartype[i]="0";
																bWriter.write("~");																
																i=i+1;
															}
														}
														HashRecord.put("yeartype",yeartype);
														HashRecord.put("fin_yeartype",fin_yeartype);
														HashRecord.put("years",years);
													}													
													
													catch(Exception e)
													{
														log.error("Exception from interface : Financial --->getFinancialYears ::: "+e.toString());		
													}		
													
													finally
													{
														try
														{
															if(rs!=null)rs.close();			
														}
														
														catch(Exception e)
														{
															e.printStackTrace();
														}
													}	
													return HashRecord;
												}
												
												private HashMap getFinancialYears2(String applicationno,int NoOfYears,BufferedWriter writer)  
												{
													ResultSet rs1= null;
													ResultSet rs= null;
													HashMap HashRecord=new HashMap();
													String query="",year="",strQuery="",CurrentYear="";
													String finvalues="",CurrentBaseYear="",BaseYear="";													
													String yeartype[]= new String[NoOfYears];
													String years[]= new String[NoOfYears];
													String fin_yeartype[]= new String[NoOfYears];
													String tempYear="",cmano="";
													int num=0,temp=0;	
													int Current_Year=0;													
													int Temp_Year=0;
													int formulaid=0;
													
													try
													{
														BufferedWriter bWriter = writer;
														
														
														//TO GET BASE YEAR
															
														strQuery = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+applicationno);
														if(rs1!=null)
															rs1.close();
														rs1=DBUtils.executeQuery(strQuery);
														if(rs1.next())
														{
															BaseYear=Helper.correctNull(rs1.getString("baseyear"));
															CurrentBaseYear=Helper.correctNull(rs1.getString("extra_baseyear"));
														}															
														
														Current_Year=Integer.parseInt(CurrentBaseYear);
														
														Temp_Year=Current_Year;
														
														if(rs!=null)
														{
															rs.close();
														}
														
														query=SQLParser.getSqlQuery("lapstoram_yeartype^"+applicationno+"^"+BaseYear);
														rs = DBUtils.executeQuery(query);
														
														if(rs.next())
														{						
															CurrentYear=Helper.correctNull(rs.getString("fin_year"));														
														}
														else
														{
															CurrentYear="0";
														}
														
														years[0]=CurrentYear;
														
														for(int i=1;i<NoOfYears;i++)
														{															
																Temp_Year=Temp_Year+1;
																
																query=SQLParser.getSqlQuery("lapstoram_yeartype2^"+applicationno+"^"+Integer.toString(Temp_Year));
																rs = DBUtils.executeQuery(query);
																
																if(rs.next())
																{						
																	years[i]=Helper.correctNull(rs.getString("fin_year"));																
																}
																else
																{
																	years[i]="0";
																}
															
														}
														
														
														//Writing into the File
														
														//Year Ending date(DD-MM-YYYY)
														
														tempYear="";
														
														bWriter.write("Year Ending date(DD-MM-YYYY)");
														
														for(int i=0;i<years.length;i++)
														{		
															tempYear=Helper.correctNull(years[i]);
															if(!tempYear.equalsIgnoreCase("0"))
															{
																bWriter.write("~");
																bWriter.write(Helper.correctNull(years[i]));	
															}
															else
															{
																bWriter.write("~");																	
															}
														}
														
														//YearType
														
														if(rs!=null)
														{
															rs.close();
														}
														int i=0;
														tempYear="";
														bWriter.newLine();
														bWriter.write("YearType");														
														
														for(int z=0;z<years.length;z++)
														{															
															tempYear=Helper.correctNull(years[z]);
															if(!tempYear.equalsIgnoreCase("0"))
															{
																year=Helper.correctNull(years[z]);
																query=SQLParser.getSqlQuery("lapstoram_yeartype^"+applicationno+"^"+year);
																rs = DBUtils.executeQuery(query);
																
																if(rs.next())
																{						
																	if(!rs.getString("sumaudit").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Audited";
																		fin_yeartype[i]="a";
																	}
																	else if(!rs.getString("sumunaudit").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="UnAudited";
																		fin_yeartype[i]="u";
																	}
																	else if(!rs.getString("sumestimated").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Estimated";
																		fin_yeartype[i]="e";
																	}
																	else if(!rs.getString("sumprojection").equalsIgnoreCase("0"))
																	{
																		yeartype[i]="Projected";
																		fin_yeartype[i]="p";
																	}				
																	bWriter.write("~");
																	bWriter.write(yeartype[i]);
																	i=i+1;
																}
															}
															else
															{
																yeartype[i]="0";
																fin_yeartype[i]="0";
																bWriter.write("~");																
																i=i+1;
															}
														}
														HashRecord.put("yeartype",yeartype);
														HashRecord.put("fin_yeartype",fin_yeartype);
														HashRecord.put("years",years);
													}													
													
													catch(Exception e)
													{
														log.error("Exception from interface : Financial --->getFinancialYears ::: "+e.toString());		
													}		
													
													finally
													{
														try
														{
															if(rs!=null)rs.close();			
														}
														
														catch(Exception e)
														{
															e.printStackTrace();
														}
													}	
													return HashRecord;
												}
												
												public HashMap BrokerModel(HashMap hashmap) 
												{
														File Directory = null;
														HashMap hshmap = new HashMap();
														HashMap hashRecord = new HashMap();
														String compant_id="";
														
														ResultSet rs= null;
														ResultSet rs1= null;
														ResultSet rs2 = null;
														ResultSet rs3 = null;
														

														//To give the Number of years for this Model
														
														int NoOfYears=3;
														
														String yeartype[]= new String[NoOfYears];
														String fin_yeartype[]= new String[NoOfYears];
														String years[]= new String[NoOfYears];
														
														String strFileName="";
														String strIRBPath1=ApplicationParams.getDRIVEURL();
														String strIRBPath2=ApplicationParams.getDRIVEURL1();
														String rootPath="";
														String FolderName="Financials\\Data";		
														String strApplicationNumber=correctNull((String)hashmap.get("appno"));			
														String Path="";
														String str_Exception="$";
														try
														{
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
																str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financials to IRB !!";
																throw new Exception(str_Exception);
												            }
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
														}
														String prefix="CORP";
														String companycode=Helper.correctNull((String)hashmap.get("strOrgShortCode"));
														String applicationno=strApplicationNumber;
														String modelname="";
														String strDate="";
														String strTime="";
														String seperator="_";
														String flag;
														String cmano="";
														String serialno="";		
														String tabname="",year="",finvalues="",year1="";
														
														String printer="";
														
														int num;
														int formulaid=0;
														
														sd = new SimpleDateFormat("ddMMyyyy");
														sdt = new SimpleDateFormat("HHmmss");		
														strDate=sd.format(new Date());
														strTime=sdt.format(new Date());		
														FileWriter fout = null;
														
														
														try
														{			
																String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
																
																if(rs1!=null)
																{
																	rs=null;
																}
																
																rs1 = DBUtils.executeQuery(query10);
																
																if(rs1.next())
																{
																	compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
																}	
															
																modelname="CFIN";
																//creation of Flat File
																String FlatFileName="";
																//setting up the path and file name for the flat file to generate.....
																int queryFlag=0;
																//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
																FlatFileName=Path+"\\"+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
																File file=new File(FlatFileName);
																fout = new FileWriter(FlatFileName);
																BufferedWriter bWriter = new BufferedWriter(fout);	
																
																int i=0;
																
															
																// To find the CMA Number for the application			
																String query3=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);				
																rs3=DBUtils.executeQuery(query3);
																
																while(rs3.next())
																{
																	cmano=Helper.correctNull(rs3.getString("demo_finstandard"));
																}	
																
																//To Get The Year Values (previous,current,next) years
																
																hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
																
																yeartype=(String[])(hashRecord.get("yeartype"));
																fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
																years=(String[])(hashRecord.get("years"));	
																
																
																serialno="0";				
																tabname="Broker Model";				
																bWriter.newLine();
																bWriter.write("NoOfMonths");					
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="3";				
																tabname="Broker Model";				
																bWriter.newLine();
																bWriter.write("Income from Broking Operations");				
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																																		
																serialno="4";								
																tabname="Broker Model";				
																bWriter.newLine();
																bWriter.write("Income from Mutual funds distribution,Placement of investments etc");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
																			
																serialno="5";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Income from Dividend/Interest");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																				
																serialno="6";								
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Other Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																				
																serialno="7";								
																tabname="Broker Model";				
																bWriter.newLine();
																bWriter.write("Total Income");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
																				
																serialno="9";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Operating Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																				
																serialno="10";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Expenditure on Write-off of bad investments / debt");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="11";								
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Other Expenses");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																				
																serialno="12";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Loss on sale of asset/investment");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																																		
																serialno="13";							
																tabname="Broker Model";				
																bWriter.newLine();
																bWriter.write("Depreciation/Amortisation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="14";								
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Interest/ Finance Charges (working capital)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="16";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Total Expenditure");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="19";								
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Provision for taxation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="15";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Interest/ Finance Charges (term loans)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="17";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Profit Before tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																		
																serialno="18";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Profit Before Interest Depreciation & Taxes (PBIDT)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="20";							
																tabname="Broker Model";					
																bWriter.newLine();
																bWriter.write("Net Profit after Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="23";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Share Capital (Paid-up)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="24";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Share Application (finalised for allotment)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																		
																serialno="25";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Sub Total (Share Capital)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="27";							
																tabname="BALANCE SHEET (LIABILITIES)";						
																bWriter.newLine();
																bWriter.write("Balance in P&L Account");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																		
																serialno="28";							
																tabname="BALANCE SHEET (LIABILITIES)";						
																bWriter.newLine();
																bWriter.write("Other Reserve & Surplus");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="29";
																tabname="BALANCE SHEET (LIABILITIES)";		
																bWriter.newLine();
																bWriter.write("Accumulated Losses");																
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="30";
																tabname="BALANCE SHEET (LIABILITIES)";	
																bWriter.newLine();
																bWriter.write("Receivables (more than 6 months old)");																
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="31";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Misc. & Prem. Exp. Not w/off");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																			
																serialno="32";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Excess Value of stock exchange cards");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="33";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Investment in group cos.");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="34";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Loans and Advances to group cos. (net)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="35";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Other Intangible Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="36";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Others (if any)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="37";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Sub-total : Intangible items");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="38";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Tangible Networth");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="39";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Deffered Tax Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="41";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Loans from Promoters/Partners/Associates");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="42";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Loans from Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="43";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Others");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="44";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Total Long Term liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="46";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Creditors");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="47";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits / redeemable preference shares (due within one year)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="49";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Provision for Tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="50";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Provision for Dividend");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="51";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Other Provisions");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="52";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Other current liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="53";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Loans from Banks (Short Term)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="54";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("Total Current Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="55";							
																tabname="BALANCE SHEET (LIABILITIES)";					
																bWriter.newLine();
																bWriter.write("TOTAL OUTSIDE LIABILITIES");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="56";							
																tabname="BALANCE SHEET (LIABILITIES)";				
																bWriter.newLine();
																bWriter.write("Total Liabilities");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="59";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Cash & Bank Balances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="60";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Debtors < 6 mths");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="62";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Listed shares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="63";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Unlisted shares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="64";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Other");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="65";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Sub-total (Held for Trading)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="67";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Deposits with Stock Exchanges (Margin/ABC/Security");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="68";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Advance payment of tax");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="69";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Margin money with banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="70";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other loans & advances");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="71";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Sub total (Loans & Advances)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="72";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Total Current Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="74";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Gross Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="75";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Accumulated Depreciation");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="76";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Net Block");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="78";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Shares listed");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="79";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Shares unlisted");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="80";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Other investments");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="81";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Sub Total (Held till Maturity)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="82";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Deferred Tax Asset");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="83";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Total Assets");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="86";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Guarantees issued by our Bank");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="87";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Guarantees issued by other Banks");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="88";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("Guarantees issued by our Bank for group companies");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="89";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Guarantees issued by other Banks for grp companies");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="90";							
																tabname="BALANCE SHEET (ASSETS)";				
																bWriter.newLine();
																bWriter.write("LCs");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="91";							
																tabname="BALANCE SHEET (ASSETS)";			
																bWriter.newLine();
																bWriter.write("Others (SEBI fees arrears, etc)");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="97";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Fixed Deposit");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="98";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Shares");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="99";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Bank Guarantees");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="100";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Total Money with Exchange");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="102";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily Settlement Volumes - BSE");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="103";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily Settlement Volumes - NSE");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="104";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily Settlement Volumes - NSE F&O");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="105";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Total Daily Settlement Volumes");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="107";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily turnover - BSE");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="108";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily turnover - NSE");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="109";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Daily turnover - NSE F&O");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="110";							
																tabname="ADDITIONAL INFORMATION";			
																bWriter.newLine();
																bWriter.write("Total Daily Turnover");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="94";							
																tabname="ADDITIONAL INFORMATION";			
																bWriter.newLine();
																bWriter.write("Projected Net Sales for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																serialno="95";							
																tabname="ADDITIONAL INFORMATION";				
																bWriter.newLine();
																bWriter.write("Projected Net Profit for the year");
																getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
																
																bWriter.close();
																fout.close();
																
																String finflag="true";
																str_Exception="$";
																if(finflag=="true")
																{
																	str_Exception = str_Exception + "Financial Data is sent successfully to IRB";
																	throw new Exception(str_Exception);
																}
																
														}
														catch(Exception e)
														{
															throw new EJBException(e.toString());
															
														}		
														
														
														finally
														{
															try
															{
																if(rs!=null)rs.close();
																if(rs1!=null)rs1.close();
																if(rs2!=null)rs2.close();
																if(rs3!=null)rs3.close();
															}
															
															catch(Exception e)
															{
																e.printStackTrace();
															}
															
															
														}
													
													return hashmap;
													
												}
												
												
												private boolean checkmandatoryfields(HashMap hashmap) 
												{
												ResultSet rs=null;
												String strQuery = "";
												String appno="";
												String producttype="";
												String strExp="$";
												boolean bState = false;
												
												appno=correctNull((String)hashmap.get("applicationnumber"));
												/*if(appno.equalsIgnoreCase("") ||  appno.equalsIgnoreCase("null"))
												{
													appno=correctNull((String)hashmap.get("appno1"));
												}*/
												if(appno.equalsIgnoreCase("") ||  appno.equalsIgnoreCase("null"))
												{
													appno=correctNull((String)hashmap.get("appno"));
												}
												
												producttype=correctNull((String)hashmap.get("strProductType"));
												
												try
												{
													if(producttype.equalsIgnoreCase("pH") || producttype.equalsIgnoreCase("pM"))
													{
														strQuery = SQLParser.getSqlQuery("propdetailsel^"+appno);
														rs = DBUtils.executeQuery(strQuery);
														bState=rs.next();
														if(!bState)
														{
															strExp = strExp + "Values Not entered in proposed asset";
															throw new EJBException(strExp);
														}
													}
													else if(producttype.equalsIgnoreCase("pA"))
													{													
														if(rs!=null)
															rs.close();
														strQuery = SQLParser.getSqlQuery("selectvehicledetails1^A^"+appno);
														rs = DBUtils.executeQuery(strQuery);
														bState=rs.next();
														if(!bState)
														{
															strExp = strExp + "Values Not entered in proposed asset";
															throw new EJBException(strExp);
														}
													}else if(producttype.equalsIgnoreCase("pD"))
													{
														if(rs!=null)
															rs.close();
														strQuery = SQLParser.getSqlQuery("perotherassetselect^"+appno+"^1");
														rs = DBUtils.executeQuery(strQuery);
														bState=rs.next();
														if(!bState)
														{
															strExp = strExp + "Values Not entered in proposed asset";
															throw new EJBException(strExp);
														}
													}
													else if(producttype.equalsIgnoreCase("pE"))
													{													
														if(rs!=null)
															rs.close();
														strQuery = SQLParser.getSqlQuery("edustudentsel^"+appno);
														rs = DBUtils.executeQuery(strQuery);
														bState=rs.next();
														if(!bState)
														{
															strExp = strExp + "Values Not entered in Particulars of student";
															throw new EJBException(strExp);
														}
														
														if(rs!=null)
															rs.close();
														if(bState)
														{
															strQuery = SQLParser.getSqlQuery("edudetailsselection^"+appno);
															rs = DBUtils.executeQuery(strQuery);
															bState=rs.next();
															if(!bState)
															{
																strExp = strExp + "Values Not entered in Education Details";
																throw new EJBException(strExp);
															}
														}
														
														if(rs!=null)
															rs.close();
														if(bState)
														{
															strQuery = SQLParser.getSqlQuery("eduparticularssel^"+appno);
															rs = DBUtils.executeQuery(strQuery);
															bState=rs.next();
															if(!bState)
															{
																strExp = strExp + "Values Not entered in Course Details";
																throw new EJBException(strExp);
															}
														}
													}
													
												}catch(Exception e)
												{
													log.error(e.toString());
												}finally
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
														throw new EJBException("Error in closing Connection " + e.getMessage());
													}
												}
												return bState;												
												}
//												Kamal Added - Start
 public HashMap  createSecurityMaster(HashMap hashmap) 
 {
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="Masters\\Security\\Data";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	
	
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
				throw new Exception(str_Exception);
            }
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}
		
HashMap hshvalue=null;
SimpleDateFormat sdf = null;
String strFileName="";
String strQuery="";
String strDate="";
ResultSet rs = null;
FileWriter fout = null;	
sdf = new SimpleDateFormat("ddMMyyyy");
strDate=sdf.format(new java.util.Date());
		
		
		try
		{
			
			hshvalue = new HashMap();
			strFileName=Path+"/"+"SECURITY"+"_"+strDate+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
		
		strQuery = SQLParser.getSqlQuery("securitymaster");
				
		rs = DBUtils.executeQuery(strQuery);												
		while(rs.next())
		{
			 bufWriter.write(correctNull(rs.getString("stat_data_desc1")));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("stat_data_desc")));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("N")));
					 
			 bufWriter.newLine(); 
		}
		
		
		bufWriter.close();
		hshvalue.put("Status","Security Master File is generated");
		if (rs!= null)
			rs.close();
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Security Master File is not generated");
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if (rs!= null)
				rs.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
 	return hshvalue;
 	
}
////												Kamal Added - End	
 
//												Kamal Added - Start
 public HashMap  createChargeMaster(HashMap hashmap) 
 {
 	HashMap hshvalue=null;
 	SimpleDateFormat sdf = null;
 	String strFileName="";
	String strQuery="";
	String strDate="";
	ResultSet rs = null;
	FileWriter fout = null;	
	sdf = new SimpleDateFormat("ddMMyyyy");
	strDate=sdf.format(new java.util.Date());
	//String strPath="C:";
	
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="Masters\\Charge\\Data";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
			throw new Exception(str_Exception);
        }
	}
	catch(Exception e)
	{
		throw new EJBException(e.toString());
		
	}

	try
	{
		hshvalue = new HashMap();
		strFileName=Path+"/"+"CHARGE"+"_"+strDate+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
													
		
		 bufWriter.write("1");
		 bufWriter.write("~");
		 bufWriter.write("Exclusive~Exclusive");
		 bufWriter.write("~");
		 bufWriter.write("1");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("2");
		 bufWriter.write("~");
		 bufWriter.write("First & Parri-passu~First & Parri-passu");
		 bufWriter.write("~");
		 bufWriter.write("2");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("3");
		 bufWriter.write("~");
		 bufWriter.write("Second & Exclusive~Second & Exclusive");
		 bufWriter.write("~");
		 bufWriter.write("3");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("4");
		 bufWriter.write("~");
		 bufWriter.write("Second & Parri-passu~Second & Parri-passu");
		 bufWriter.write("~");
		 bufWriter.write("4");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("5");
		 bufWriter.write("~");
		 bufWriter.write("Subservient & Exclusive~Subservient & Exclusive");
		 bufWriter.write("~");
		 bufWriter.write("5");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("6");
		 bufWriter.write("~");
		 bufWriter.write("Subservient & Parri-passu~Subservient & Parri-passu");
		 bufWriter.write("~");
		 bufWriter.write("6");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 bufWriter.newLine(); 
		 
		 bufWriter.write("7");
		 bufWriter.write("~");
		 bufWriter.write("Unsecured~Unsecured");
		 bufWriter.write("~");
		 bufWriter.write("7");
		 bufWriter.write("~");
		 bufWriter.write("N");
		 
		 
		 bufWriter.close();
		 hshvalue.put("Status","Charge Master File is generated");
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Charge Master File is not generated");
	
		e.printStackTrace();
	}
	finally
	{
		try
		{
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
 	return hshvalue;
 	
}
////												Kamal Added - End
 
//												Kamal Added - Start
 public HashMap  createFacilityMaster(HashMap hashmap) 
 {
 	
	//String strPath="C:";
	
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="Masters\\Facility\\Data";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
			throw new Exception(str_Exception);
        }
	}
	catch(Exception e)
	{
		throw new EJBException(e.toString());
		
	}
		
	HashMap hshvalue=null;
	SimpleDateFormat sdf = null;
	String strFileName="";
	String strQuery="";
	String strDate="";
	ResultSet rs = null;
	FileWriter fout = null;	
	sdf = new SimpleDateFormat("ddMMyyyy");
	strDate=sdf.format(new java.util.Date());
	
	try
	{
		hshvalue = new HashMap();
		strFileName=Path+"/"+"FACILITY"+"_"+strDate+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
		
		strQuery = SQLParser.getSqlQuery("facilitymaster");
				
		rs = DBUtils.executeQuery(strQuery);												
		while(rs.next())
		{
			 bufWriter.write(correctNull(rs.getString("FACility_catid")));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("facility_schemecode")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("facility_catdesc")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("fund")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("fac_type")));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("N")));
			 
			 bufWriter.newLine(); 
		}
		
		
		bufWriter.close();
		hshvalue.put("Status","Facility Master File is generated");
		if (rs!= null)
			rs.close();
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Facility Master File is not generated");
	
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if (rs!= null)
				rs.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
 	return hshvalue;
 	
}
////												Kamal Added - End

public HashMap  createFacilityDetails(HashMap hashmap) 
{
	
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="FRR\\Data\\";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
			throw new Exception(str_Exception);
        }
	}
	catch(Exception e)
	{
		throw new EJBException(e.toString());
	}
	
	HashMap hshvalue=null;
	SimpleDateFormat sdf 	= null;
	SimpleDateFormat sdtime = null;
	String strFileName="";
	String strQuery="";
	String strDate="";
	String strtime="";
	ResultSet rs = null;
	FileWriter fout = null;	
	sdf = new SimpleDateFormat("ddMMyyyy");
	sdtime = new SimpleDateFormat("HHmmss");
	strDate=sdf.format(new java.util.Date());
	strtime=sdtime.format(new java.util.Date());
	//String strPath="C:";
	String comapp_oldid = "";
	
	try
	{
		hshvalue = new HashMap();
		String comapp_id = correctNull((String)hashmap.get("comapp_id"));
		if(comapp_id.equals(""))
		{
			comapp_id = correctNull((String)hashmap.get("hidapplicantid"));
		}
		String strAppno=correctNull((String)hashmap.get("appno"));
		
		strQuery = SQLParser.getSqlQuery("sel_comapp_oldid^"+comapp_id);
		rs = DBUtils.executeQuery(strQuery);												
		if(rs.next())
		{
			comapp_oldid = correctNull(rs.getString("comapp_oldid"));
		}
		
		
		strFileName=Path+"/"+"FACDETAILS"+comapp_oldid+"_"+strDate+"_"+strtime+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
		
		strQuery = SQLParser.getSqlQuery("facilitydetials^"+strAppno);
		if(rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);												
		while(rs.next())
		{
			 bufWriter.write(correctNull(comapp_oldid));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("facility_appno")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("facility_id")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("facility_sno")));
			 bufWriter.write("~");
			 
			 bufWriter.write(""+rs.getDouble("facility_proposed"));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("denomination")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("facility_months")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("facility_interest")));
			 
			 bufWriter.newLine(); 
		}
		
		
		bufWriter.close();
		hshvalue.put("Status","Facility Details File is generated");
		if (rs!= null)
			rs.close();
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Facility Details File not generated");
		File dfile = new File(strFileName);
		if (dfile.exists())
		{
			dfile.delete();
		}
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if (rs!= null)
				rs.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
	return hshvalue;
	
}
////												Kamal Added - End
public HashMap  createChargeDetails(HashMap hashmap) 
{
	
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="FRR\\Data\\";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
			throw new Exception(str_Exception);
        }
	}
	catch(Exception e)
	{
		throw new EJBException(e.toString());
		
	}
	
	
	HashMap hshvalue=null;
	SimpleDateFormat sdf 	= null;
	SimpleDateFormat sdtime = null;
	String strFileName="";
	String strQuery="";
	String strDate="";
	String strtime="";
	ResultSet rs = null;
	FileWriter fout = null;	
	sdf = new SimpleDateFormat("ddMMyyyy");
	sdtime = new SimpleDateFormat("HHmmss");
	strDate=sdf.format(new java.util.Date());
	strtime=sdtime.format(new java.util.Date());
//	String strPath="C:";
	String comapp_oldid = "";
	

	try
	{
		hshvalue = new HashMap();
		String comapp_id = correctNull((String)hashmap.get("comapp_id"));
		if(comapp_id.equals(""))
		{
			comapp_id = correctNull((String)hashmap.get("hidapplicantid"));
		}
		String strAppno=correctNull((String)hashmap.get("appno"));
		
		strQuery = SQLParser.getSqlQuery("sel_comapp_oldid^"+comapp_id);
		rs = DBUtils.executeQuery(strQuery);												
		if(rs.next())
		{
			comapp_oldid = correctNull(rs.getString("comapp_oldid"));
		}
		
		
		strFileName=Path+"/"+"CHGDETAILS"+comapp_oldid+"_"+strDate+"_"+strtime+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
		
		strQuery = SQLParser.getSqlQuery("chargedetials^"+strAppno);
		if(rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);												
		while(rs.next())
		{
			 bufWriter.write(correctNull(comapp_oldid));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("SEC_APPNO")));
			 bufWriter.write("~");
			 
			 String strsecfacsno=correctNull(rs.getString("SEC_FACSNO"));
			 
			 if(strsecfacsno.equals(""))
			 {
				 bufWriter.write(correctNull(rs.getString("facility_sno")));
				 bufWriter.write("~");
				 bufWriter.write(correctNull(rs.getString("SEC_SRLNO")));
				 bufWriter.write("~");
				 String strSecCharge=correctNull(rs.getString("SEC_CHARGE"));
				 if(strSecCharge.equals("1"))
				 {
					 bufWriter.write("2");
				 }
				 else if(strSecCharge.equals("3"))
				 {
					 bufWriter.write("4");
				 }
				 else
				 {
					 bufWriter.write(strSecCharge);
				 }
			 }
			 else
			 {
				 String strFacsno=correctNull(rs.getString("facility_sno"));
				 if(strsecfacsno.equals(strFacsno))
				 {
					 //bufWriter.write(strsecfacsno);
					 bufWriter.write(strFacsno);
					 bufWriter.write("~");
					 bufWriter.write(correctNull(rs.getString("SEC_SRLNO")));
					 bufWriter.write("~");
					 bufWriter.write(correctNull(rs.getString("SEC_CHARGE")));
				 }
				 else
				 {
					 //bufWriter.write(strsecfacsno);
					 bufWriter.write(strFacsno);
					 bufWriter.write("~");
					 bufWriter.write(correctNull(rs.getString("SEC_SRLNO")));
					 bufWriter.write("~");
					 bufWriter.write("7");
					 
				 }
			 }
			 
			 bufWriter.newLine(); 
			
			 
			
		}
		
		
		bufWriter.close();
		hshvalue.put("Status","Charge Details File is generated");
		if (rs!= null)
			rs.close();
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Charge Details File is not generated");
		File dfile = new File(strFileName);
		if (dfile.exists())
		{
			dfile.delete();
		}
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if (rs!= null)
				rs.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
	return hshvalue;
	
}
////												Kamal Added - End - createChargeDetails


////												Kamal Added - Start - createSecurityDetails

public HashMap  createSecurityDetails(HashMap hashmap) 
{
	
	String strIRBPath1=ApplicationParams.getDRIVEURL();
	String strIRBPath2=ApplicationParams.getDRIVEURL1();
	String rootPath="";
	String FolderName="FRR\\Data\\";
	String Path="";
	String str_Exception="$";
	File Directory = null;
	
	try
	{				
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
			str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Group Master to IRB !!";
			throw new Exception(str_Exception);
        }
	}
	catch(Exception e)
	{
		throw new EJBException(e.toString());
		
	}
	
	HashMap hshvalue=null;
	SimpleDateFormat sdf 	= null;
	SimpleDateFormat sdtime = null;
	String strFileName="";
	String strQuery="";
	String strDate="";
	String strtime="";
	ResultSet rs = null;
	FileWriter fout = null;	
	sdf = new SimpleDateFormat("ddMMyyyy");
	sdtime = new SimpleDateFormat("HHmmss");
	strDate=sdf.format(new java.util.Date());
	strtime=sdtime.format(new java.util.Date());
//	String strPath="C:";
	String comapp_oldid = "";
	

	try
	{
		hshvalue = new HashMap();
		String comapp_id = correctNull((String)hashmap.get("comapp_id"));
		if(comapp_id.equals(""))
		{
			comapp_id = correctNull((String)hashmap.get("hidapplicantid"));
		}
		String strAppno=correctNull((String)hashmap.get("appno"));
		
		strQuery = SQLParser.getSqlQuery("sel_comapp_oldid^"+comapp_id);
		rs = DBUtils.executeQuery(strQuery);												
		if(rs.next())
		{
			comapp_oldid = correctNull(rs.getString("comapp_oldid"));
		}
		
		
		strFileName=Path+"/"+"SECUDETAILS"+comapp_oldid+"_"+strDate+"_"+strtime+".txt";	
		fout=new FileWriter(strFileName); 
		BufferedWriter bufWriter=new BufferedWriter(fout);
		
		
		strQuery = SQLParser.getSqlQuery("securitydetials^"+strAppno);
		if(rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);												
		while(rs.next())
		{
			 bufWriter.write(correctNull(comapp_oldid));
			 bufWriter.write("~");
	
			 bufWriter.write(correctNull(rs.getString("SEC_APPNO")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("SEC_DESC_ID")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("SEC_SRLNO")));
			 bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("SEC_DESC_VALUE")));
			 bufWriter.write("~");
	
			 //bufWriter.write(correctNull(rs.getString("currency")));
			 //bufWriter.write("~");
			 
			 bufWriter.write(correctNull(rs.getString("SEC_TENOR")));
		
			 bufWriter.newLine(); 
		}
		
		
		bufWriter.close();
		hshvalue.put("Status","Security Details File is generated");
		if (rs!= null)
			rs.close();
		
		
	
	}
	catch(Exception e)
	{
		hshvalue.put("Status","Security Details File is not generated");
		e.printStackTrace();
	}
	finally
	{
		try
		{
			if (rs!= null)
				rs.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}
	return hshvalue;
	
}
////												Kamal Added - End - createSecurityDetails


	public HashMap SimplifiedFinancial(HashMap hashmap)
	{

		File Directory = null;
		HashMap hshmap = new HashMap();
		HashMap hashRecord = new HashMap();
		
		ResultSet rs= null;
		ResultSet rs1= null;
		ResultSet rs3 = null;
																														
		//To give the Number of years for this Model
		
		int NoOfYears=5;
		
		String yeartype[]= new String[NoOfYears];
		String fin_yeartype[]= new String[NoOfYears];
		String years[]= new String[NoOfYears];
		
		String compant_id="";
		String strIRBPath1=ApplicationParams.getDRIVEURL();
		String strIRBPath2=ApplicationParams.getDRIVEURL1();
		String rootPath="";
		String FolderName="Financials"+File.separatorChar+"Data";		
		String strApplicationNumber=correctNull((String)hashmap.get("appno"));
		String Path="";
		String str_Exception="$";
		
		try
		{				
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
				str_Exception = str_Exception + "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
				throw new Exception(str_Exception);
		    }
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}
		
		String applicationno=strApplicationNumber;
		String modelname="";
		String strDate="";
		String strTime="";
		String cmano="";
		String serialno="";		
		String tabname="";
		sd = new SimpleDateFormat("ddMMyyyy");
		sdt = new SimpleDateFormat("HHmmss");		
		strDate=sd.format(new Date());
		strTime=sdt.format(new Date());		
		FileWriter fout = null;
		try
		{			
				String query10=SQLParser.getSqlQuery("commapplicantdemosel^"+strApplicationNumber);
				
				if(rs1!=null)
				{
					rs=null;
				}
				
				rs1 = DBUtils.executeQuery(query10);
				
				if(rs1.next())
				{
					compant_id=	Helper.correctNull((String)rs1.getString("comapp_oldid"));			
				}	
			
				modelname="CFIN";
				//creation of Flat File
				String FlatFileName="";
				//setting up the path and file name for the flat file to generate.....
				int queryFlag=0;
				//FlatFileName=Path+"/"+prefix+companycode+"_"+strApplicationNumber+"_"+modelname+"_"+strDate+"_"+strTime+".txt";
				FlatFileName=Path+File.separatorChar+modelname+compant_id+"_"+strApplicationNumber+"_"+strDate+"_"+strTime+".txt";
				File file=new File(FlatFileName);
				fout = new FileWriter(FlatFileName);
				BufferedWriter bWriter = new BufferedWriter(fout);				
				
				
				// To find the CMA Number for the application
				
				String strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+applicationno);
				if(rs != null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				 
				while(rs.next())
				{  
					cmano=rs.getString("demo_finstandard");
				}
				
				/*String query3=SQLParser.getSqlQuery("finselect8^"+applicationno);				
				rs3=DBUtils.executeQuery(query3);
				
				while(rs3.next())
				{
					cmano=Helper.correctNull(rs3.getString("cma_no"));
				}*/	
				
				//To Get The Year Values (previous,current,next) years
				
				hashRecord=getFinancialYears(applicationno,NoOfYears,bWriter);
				
				yeartype=(String[])(hashRecord.get("yeartype"));
				fin_yeartype=(String[])(hashRecord.get("fin_yeartype"));
				years=(String[])(hashRecord.get("years"));	
				
				//No. of months
				serialno="0";				
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("NoOfMonths");				
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Gross Sales -  Domestic				
				serialno="2";				
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("Gross Sales - Domestic");				
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Gross Sales - Export				
				serialno="3";								
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("Gross Sales - Export");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);								
				
				//Gross Fixed Assets				
				serialno="4";							
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("Sub Total (Gross Sales)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
				
				//Accumulated Depreciation				
				serialno="9";								
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("Less Excise Duty");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
				
				//net fixed assets				
				serialno="7";								
				tabname="PROFIT LOSS A/C";				
				bWriter.newLine();
				bWriter.write("Net Sales");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);				
				
				//Export Incentives						
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Export Incentives~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Duty Drawback						
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Duty Drawback~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Others						
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Others~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Total Operating Income					
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Total Operating Income~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Raw materials consumed imported						
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Raw materials consumed imported~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
					
				//Raw materials consumed indigenous
				serialno="4";								
				tabname="COST OF SALES";				
				bWriter.newLine();
				bWriter.write("Raw materials consumed indigenous");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Other Spares consumed Imported~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//serialno="";								
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Other spares consumed Indigenous~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Power and Fuel				
				serialno="6";							
				tabname="COST OF SALES";				
				bWriter.newLine();
				bWriter.write("Power and fuel");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Direct Labour				
				serialno="5";							
				tabname="COST OF SALES";				
				bWriter.newLine();
				bWriter.write("Direct labour and wages");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Repair and maintanance~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Others				
				serialno="8";							
				tabname="COST OF SALES";				
				bWriter.newLine();
				bWriter.write("other manufacturing expenses");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//Depreciation			
				serialno="7";							
				tabname="COST OF SALES";				
				bWriter.newLine();
				bWriter.write("depreciation");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);

				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("sub Total (A)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("add: Op. Stock of WIP~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("less: Cl. Stock of WIP~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("total Cost of Production~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("add Opening Stock of Finished Goods~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("less: Cl. Stock  of Finished Goods~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="32";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("total Cost of Sales~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				//Selling & Administrative Expenses			
				serialno="1";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("selling, Gen. & Administration Exp");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("cost of Sales + SGA~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//Operating Profit before Interest
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Operating Profit before Interest~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//Interest On Working Capital - Banks				
				serialno="3";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("interest to banks- WC");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="4";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("interest to banks- Term Loans");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="6";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("interest to FIs- WC");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="7";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("interest to FIs- Term Loans");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("total Interest~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="10";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Operating Profit after Interest");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="46";							
				//tabname="NON OPERATING ITEMS";				
				bWriter.newLine();
				bWriter.write("Profit on sale of assets/ investments~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Investments and Dividend~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Forex gains~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Non-op. income from subsidiaries~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="50";							
				//tabname="NON OPERATING ITEMS";				
				bWriter.newLine();
				bWriter.write("Tax Refund~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="11";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Other Non Operating Income");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="11";							
				//tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Total non-operating Income~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Loss on sale of assets~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Prem. Expenses w/off~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="8";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Other Non- operating exp.");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Total Non-operating expenses~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Net of Non-operating Income / Expenses~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Profit Before Interest Depreciation & Taxes (PBIDT~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="12";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Profit Before tax");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="13";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Provision for taxation:Current");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Provision for taxation:Deferred~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Sub Total: Provision for taxation~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
//				pat				
				serialno="14";							
				tabname="SELLING ADMINISTRATIVE EXPENSES";				
				bWriter.newLine();
				bWriter.write("Net Profit After tax");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						

				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Extraordinary Income adjustments (+)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Extraordinary Expenses  adjustments (-)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="70";							
				//tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
				bWriter.newLine();
				bWriter.write("Adjusted PAT (excl Extraordinary  Items)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="72";							
				//tabname="EXTRAORDINARY ITEMS ADJUSTMENTS";				
				bWriter.newLine();
				bWriter.write("Dividend Paid on Equity Capital~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Dividend Paid on Preference Sh. Capital~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Dividend tax~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Partners Withdrawal~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Dividend (%)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Retained Profit~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Cash Accruals~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="1";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Bank Borrowings - From our Bank");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			

				//serialno="83";							
				//tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Bank Borrowings - From other Banks~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Sub Total~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Short term borrowings from Associates & Group Concerns~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				serialno="2";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Short term borrowings from Others");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				serialno="3";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Creditors for purchases");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				serialno="5";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Advs/ pymts from customers/deposits from dealers");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				serialno="10";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Tax Provisions");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
				
				serialno="13";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Other Provisions");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
				
				serialno="11";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Dividends Payable");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				serialno="9";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Interest and other Charges Accrued but not Due");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="12";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("statutory liabilities due within one year");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="8";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits / redeemable preference shares (due within one year) - To Banks");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				serialno="7";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("deposits");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="15";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("other Current Liabilities due within one year");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="14";							
				tabname="CURRENT LIABILITIES";				
				bWriter.newLine();
				bWriter.write("total Current Liabilities");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="1";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Debentures");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Preference share capital~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Dealers Deposit~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Deferred Tax Liability~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				
				serialno="3";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Term Loans  - From Banks");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Term Loans - From Fis~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="2";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Term Deposits");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Borrowings from subsidiaries / affiliates (Quasi E~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="5";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Unsecured Loans (Quasi Equity)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="8";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Other term liabilities");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="7";							
				tabname="BALANCE SHEET (LONG TERM LIABILITIES)";				
				bWriter.newLine();
				bWriter.write("Total Term Liabilities");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("TOTAL OUTSIDE LIABILITIES~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
						
				serialno="2";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Share Capital (Paid-up)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Share Application (finalised for allotment)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Sub Total (Share Capital)");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="3";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("General Reserve");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="118";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Capital  Reserve~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Capital Redemption Reserve~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Statutory Reserve~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Employees Stock Option Outstanding~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="4";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("revaluation Reserve");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("partners capital / Proprietors capital~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="5";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Share Premium");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
				
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Capital Subsidy~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="6";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("other reserves and surplus");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="7";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("balance in P&L Account (+ / - )");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="8";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("total networth");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Total Liabilities");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="1";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Cash & Bank Balances");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="3";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Investments in Govt. and other trustee Securities");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="4";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Fixed Deposits with Banks");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				//serialno="";							
				//tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Other Investments~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="6";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Receivables other than defered & export (Domestic)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="7";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Export Receivables");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="15";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Deferred receivable (due within 1 yr.)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="10";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Raw Materials - Imported");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
					
				serialno="9";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Raw Materials - Indigenous");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
				
				serialno="13";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Work in process");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="14";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Finished Goods (incl Traded Goods)");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="12";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Other consumable spares - Imported");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="11";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Other consumable spares -  Indigenous");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="152";							
				//tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Sub total (Inventory)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="16";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Advances to suppliers");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="17";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Advance payment of tax");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("Excise Duty Receivables~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="18";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("other Current Assets");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="19";							
				tabname="BALANCE SHEET (CURRENT ASSETS)";				
				bWriter.newLine();
				bWriter.write("total current assets");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="7";							
				tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Gross Block");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Less: Accumulated Depreciation~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="7";							
				tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Net Block");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="4";							
				tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Capital Work in progress");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="";				
				bWriter.newLine();
				bWriter.write("Investments in Group concerns~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="1";							
				tabname="MISCELLANIOUS ASSETS";				
				bWriter.newLine();
				bWriter.write("Loans to group concerns / Advances to subsidiaries");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Investments in others~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="4";							
				tabname="MISCELLANIOUS ASSETS";				
				bWriter.newLine();
				bWriter.write("Advances to suppliers of capital goods and contrac");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="5";							
				//tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Deferred receivables (maturity exceeding one year)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="5";							
				tabname="MISCELLANIOUS ASSETS";				
				bWriter.newLine();
				bWriter.write("Debtors > 6 mths.");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="8";							
				tabname="MISCELLANIOUS ASSETS";				
				bWriter.newLine();
				bWriter.write("Others (Loans & Advances non current in nature, ICDs etc");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Deferred Tax Asset~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="BALANCE SHEET FIXIED ASSETS(NET BLOCK)";				
				bWriter.newLine();
				bWriter.write("Other Non-current Assets(incld. Dues from directors~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="7";							
				tabname="MISCELLANIOUS ASSETS";				
				bWriter.newLine();
				bWriter.write("Total Non Current Assets");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="10";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Goodwill Patents trademarks");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="21";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Accumulated Losses Preliminary expenses Others");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="13";							
				tabname="NET WORTH AND INTANGIBLE ASSETS";				
				bWriter.newLine();
				bWriter.write("Total Assets");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
				
				serialno="1";							
				tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Projected Net Sales for the year");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				serialno="2";							
				tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Projected Net Profit for the year");
				getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
				
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Arrears of cumulative dividends~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Guarantees issued (relating to business)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Guarantees issued (for group companies)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Gratuity Liability not provided for~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Disputed excise / customs / tax Liabilities~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("LCs~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="192";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("All other contingent liabs (incl Bills payable)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);			
			
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Arrears of depreciation~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);	
				
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Installments of Term Loans / Deferred payment credits / Debentures / deposits (due within one year)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);		
				
				//serialno="";							
				//tabname="ADDITIONAL INFORMATION";				
				bWriter.newLine();
				bWriter.write("Preference Share Capital (due in less than a year)~0~0~0~0~0");
				//getFinancialvalues2(serialno,cmano,applicationno,tabname,fin_yeartype,bWriter,years);
				
				String finflag="true";
				bWriter.close();
				fout.close();
				
				str_Exception="$";
				if(finflag=="true")
				{
					str_Exception = str_Exception + "Simplified Financial Data is sent successfully to IRB";
					throw new Exception(str_Exception);
				}
				
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
			
		}		
		
		finally
		{
			try
			{
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				if(rs3!=null)rs3.close();
			}
			
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
		}
	
	return hashmap;
	

	}
  
	
}//end of class