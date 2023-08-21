package com.sai.laps.ejb.exceltolaps;



import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;

import org.apache.log4j.Logger;

import jxl.Cell;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;

import java.io.*;

import com.sai.laps.ejb.ExcelReader.ExcelReaderBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.Helper;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

@Stateless(name = "ExcelToLapsBean", mappedName = "ExcelToLapsHome")
@Remote (ExcelToLapsRemote.class)

public class ExcelToLapsBean extends BeanAdapter {

	
	private static final long serialVersionUID = -8878456145368970514L;

	static Logger log=Logger.getLogger(ExcelToLapsBean.class);
	/**
	 * @author Kamalakannan
	 * @param hshValues
	 * @return
	 * @
	 */

	public HashMap excelCustomerParser(HashMap hshValues)  {
		int count = 0;
		ResultSet rs1 = null;
    	HashMap hshQuery = null, hshQueryValues = new HashMap();
		StringBuffer errorDetails = new StringBuffer();
		String usrID = null;
		ArrayList arrValues = null;
		
		
		try {
			
			usrID=correctNull((String)hshValues.get("strUserId"));
            byte[] byteData=(byte[])hshValues.get("stream");
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
				Workbook workbook = Workbook.getWorkbook(inputStream);
				String sheetnames[]=workbook.getSheetNames();
				int sheetSize=sheetnames.length;
				if(sheetSize == 2)
				{

				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(usrID);
				hshQuery.put("strQueryId", "excel_loandetails_exist_delete");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(usrID);
				hshQuery.put("strQueryId", "excel_landholding_exist_delete");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2", hshQuery);
				
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				for(int i=0;i<sheetnames.length;i++)
				{
				
					Sheet sheet = workbook.getSheet(i);
					int rows = sheet.getRows();
					
				    if(i==0)
					{
						errorDetails=LoanDetailsDataExistCustomer(sheet,rows,usrID,errorDetails);
						
					}	
					else if(i==1)
					{
						errorDetails=updateLandHoldingsDataExistCustomer(sheet,rows,errorDetails,usrID);
					}
						
										
				}
				if(!errorDetails.toString().equals(""))
				{
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "excel_loandetails_exist_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "excel_landholding_exist_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2", hshQuery);
					
					hshQueryValues.put("size", "2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					hshValues.put("errorstatus", errorDetails.toString());
					
			
				}
				else
				{
					hshValues.put("status", "Sucessfully Updated");
				}
			 
				}
				else//
				{
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "del_agrexcelcustomerprofile");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
								
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "del_agrexcelincomeexp");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2", hshQuery);
								
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "del_agrexcelempdetails");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "excel_loandetails_agri_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(usrID);
					hshQuery.put("strQueryId", "excel_landholding_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("5", hshQuery);
					
					hshQueryValues.put("size", "5");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					for(int i=0;i<sheetnames.length;i++)
					{
					
						Sheet sheet = workbook.getSheet(i);
						int rows = sheet.getRows();
						
						if(i==0)
						{
							errorDetails=updateCustomerProfilesData(sheet,rows,errorDetails,usrID);
														
						}
						else if(i==1)
						{
							errorDetails=LoanDetailsData(sheet,rows,usrID,errorDetails);
							
						}	
						else if(i==2)
						{
							errorDetails=updateLandHoldingsData(sheet,rows,errorDetails,usrID);
						}
							
											
					}
					if(!errorDetails.toString().equals(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(usrID);
						hshQuery.put("strQueryId", "del_agrexcelcustomerprofile");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1", hshQuery);
									
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(usrID);
						hshQuery.put("strQueryId", "del_agrexcelincomeexp");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2", hshQuery);
									
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(usrID);
						hshQuery.put("strQueryId", "del_agrexcelempdetails");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("3", hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(usrID);
						hshQuery.put("strQueryId", "excel_loandetails_agri_delete");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("4", hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(usrID);
						hshQuery.put("strQueryId", "excel_landholding_delete");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("5", hshQuery);
						
						hshQueryValues.put("size", "5");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						hshValues.put("errorstatus", errorDetails.toString());
						
				
					}
					else
					{
						hshValues.put("status", "Sucessfully Updated");
					}
				}
				inputStream.close();
				inputStream = null;
				workbook.close();
			
            }
            else
            {
            
            	hshValues.put("status", "Select the File before clicking on Proceed");
            }
            
           
		}catch (Exception e) {
		
			throw new EJBException("Error excelCustomerParser in ExcelToLapsBean"+e.toString());
			

		} finally {
			try {
				if (rs1 != null) {
					rs1.close();
					rs1 = null;
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}

		return hshValues;
	}
	
	private void insertCustomer(String s1,String s2,String custid, String s3,String s4,String s5,String s6,String s7,String s8,String s9,String s10,String s11,String s12,String s13,String s14  
			,String s15,String s16,String s17,String s18,String s19,String s20,String s21,String s22,String s23,String s24,String s25 
			,String s26,String s27,String s28,String s29,String s30,String s31,String s32,String s33,String s34,String s35,String s36,String s37,String s38,String s39  
			,String s40,String s41,String s42,String s43,String s44,String s45,String s46,String s47,String s48,String s49,String s50,String s51,String s52,String s53 
			,String s54,String s55,String s56,String s57,String s58,String s59,String s60,String s61,String s62,String s63,String s64,String s65,String s66,String s67,String s68  
			,String s69,String s70,String s71,String s72,String s73,String s74,String s75,String s76,String s77,String s78,String s79,String s80,String s81,String s82,String s83,String branchiid,String guardname,String guardrel,String guardddr,
			String strCustType,String strAnnualIncome,String strOccupationCode,String strOccupation ,String strFormType,String strResCtyCode,String strRefno,
			String strResProofType,String strResRefno,String strIdProofType,String strIdRefno,String strNetworth ,String strPooledType,String strAnnualturnover,String strAnnTurnEstimated,
			String strnof,String strofac,String strForeignRem,String strRemCtyCode,String strRisk,String strSource,String strusrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "ins_agrexcelcustomerprofile");
		arrValues.add(s1); 
		arrValues.add(s2); 
		arrValues.add("0");
		arrValues.add(s3);
		arrValues.add(s4); 
		arrValues.add(s5); 
		arrValues.add(s6);
		arrValues.add(s7);
		arrValues.add(s8);
		arrValues.add(s9);
		arrValues.add(s10);//date
		arrValues.add(s11);
		arrValues.add(s12);
		arrValues.add(s13);
		arrValues.add(s14);
		arrValues.add(s15);
		arrValues.add(s16);
		arrValues.add(s17);
		arrValues.add(s18);
		arrValues.add(s19);
		arrValues.add(s20);
		arrValues.add(s21);
		arrValues.add(s22);
		arrValues.add(s23);
		arrValues.add(s24);
		arrValues.add(s25);
		arrValues.add(s26);
		arrValues.add(s27);
		arrValues.add(s28);
		arrValues.add(s29);
		arrValues.add(s30);
		arrValues.add(s31);
		arrValues.add(s32);
		arrValues.add(s33);
		arrValues.add(s34);
		arrValues.add(s35);
		arrValues.add(s36);
		arrValues.add(s37);
		arrValues.add(s38);
		arrValues.add(s39);
		arrValues.add(s40);
		arrValues.add(s41);//date
		arrValues.add(s42);
		arrValues.add(s43); 
		arrValues.add(s44); //date
		arrValues.add(s45); 
		arrValues.add(s46); 
		arrValues.add(s47);//date
		arrValues.add(s48); //date
		arrValues.add(s49);
		arrValues.add(s50); 
		arrValues.add(s51);
		arrValues.add(s52);
		arrValues.add(s53); 
		arrValues.add(s54); 
		arrValues.add(s55); 
		arrValues.add(s56); 
		arrValues.add(s57); 
		arrValues.add(s58); 
		arrValues.add(s59); 
		arrValues.add(s60); 
		arrValues.add(s61);
		arrValues.add(s62); 
		arrValues.add(s63); 
		arrValues.add(s64);
		arrValues.add(s65);
		arrValues.add(s66); 
		arrValues.add(s67); 
		arrValues.add(s68); 
		arrValues.add(s69);
		arrValues.add(s70);
		arrValues.add(s71);
		arrValues.add(s72); 
		arrValues.add(s73); 
		arrValues.add(s74);
		arrValues.add(s75);
		arrValues.add(s76);
		arrValues.add(s77); 
		arrValues.add(s78); 
		arrValues.add(s79);
		arrValues.add(s80); 
		arrValues.add(s81); 
		arrValues.add(s82); 
		arrValues.add(s83);
		arrValues.add(branchiid);
		arrValues.add(guardname);
		arrValues.add(guardrel);
 		arrValues.add(guardddr);
		arrValues.add(strCustType);
		arrValues.add(strOccupationCode);
		arrValues.add(strOccupation);
		arrValues.add(strAnnualIncome);
		arrValues.add(strResCtyCode);
		arrValues.add(strFormType);
		arrValues.add(strRefno);
		arrValues.add(strIdProofType);
		arrValues.add(strIdRefno);
		arrValues.add(strResProofType);
		arrValues.add(strResRefno);
		arrValues.add(strSource);
		arrValues.add(strNetworth);
    	arrValues.add(strAnnualturnover);
		arrValues.add(strAnnTurnEstimated);
		arrValues.add(strPooledType);
		arrValues.add(strnof);
		arrValues.add(strofac);
		arrValues.add(strForeignRem);
		arrValues.add(strRemCtyCode);
		arrValues.add(strRisk);
		arrValues.add(strusrID);
		
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		
		
		
	}
	
	private void insertIncomeandExp(String s1,String id,String monthsalary,String takehome ,String otherincometotal,String s4,String s5,String otherinc_yrs
			,String s11,String s13,String s14,String consts,String  app,
			String s6,String s12,String monthincometax,String s15,String otherdeduc,
			String yearsalary,String yearincometax,String yearotherdeduc,String s16,String s17,
			String s18,String s20,String s22,String s19,String s21,String s23,String s9,String s10,String s7,String s8,String s2,String s24,String strusrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "ins_agrexcelincomeexp");
		 arrValues.add(s1);
		 arrValues.add("0");
		 arrValues.add(monthsalary);
		 arrValues.add(takehome); 
		 arrValues.add(otherincometotal); 
		 arrValues.add(s4); 
		 arrValues.add(s5); 
		 arrValues.add(otherinc_yrs);
		 arrValues.add(s11); 
		 arrValues.add(s13);
		 arrValues.add(s14); 
		 arrValues.add(consts);
		 arrValues.add(app);
		 arrValues.add(s6);
		 arrValues.add(s12);
		 arrValues.add(monthincometax);
		 arrValues.add(s15);
		 arrValues.add(otherdeduc);
		 arrValues.add(yearsalary);
		 arrValues.add(yearincometax);
		 arrValues.add(yearotherdeduc);
		 arrValues.add(s16); 
		 arrValues.add(s17);
		 arrValues.add(s18);
		 arrValues.add(s20);
		 arrValues.add(s22); 
		 arrValues.add(s19);
		 arrValues.add(s21);
		 arrValues.add(s23);
		 arrValues.add(s9); 
		 arrValues.add(s10);
		 arrValues.add(s7);
		 arrValues.add(s8);
		 arrValues.add(s2);
		 arrValues.add(s24);
		 arrValues.add(strusrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
	}
	
	private void insertEmpDetails(String s1,String id,String s2,String s3 ,String s4,String s5,String s6,String s7,String s8,String s9,String s10
			,String s11,String s12,String s13,String s14,String s15,String s16,String s17,
			String s18,String s19,String s20,String s21,String year,String month,String s22,String s23,String s24,String s25,String s26,String s27,String s28,String strusrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "ins_agrexcelempdetails");
		arrValues.add(s1);
		arrValues.add("0");
		arrValues.add(s2);
		arrValues.add(s3);
		arrValues.add(s4);
		arrValues.add(s5);
		arrValues.add(s6);
		arrValues.add(s7);
		arrValues.add(s8);
		arrValues.add(s9);
		arrValues.add(s10);
		arrValues.add(s11);
		arrValues.add(s12);
		arrValues.add(s13);
		arrValues.add(s14);
		arrValues.add(s15);
		arrValues.add(s16);
		arrValues.add(s17);
		arrValues.add(s18);
		arrValues.add(s19);
		arrValues.add(s20);
		arrValues.add(s21);
		arrValues.add(s22);
		arrValues.add(s23);
		arrValues.add(year);
		arrValues.add(month);
		arrValues.add(s24);
		arrValues.add(s25);
		arrValues.add(s26);
		arrValues.add(s27);
		arrValues.add(s28);
		arrValues.add(strusrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
	
		
	}
	
	private String doChangeFormat(String strDate)
	{
		String date="";
		if(!strDate.equals("")){			
			date=strDate.substring(0,2)+"/"+strDate.substring(3,5)+"/"+strDate.substring(6,10);			
		}
		return date;
	}
	public HashMap exceltoLaps(HashMap hshValues) 
	{
		HashMap hshReturn = new HashMap();
		ResultSet rs = null;
		CallableStatement callstmt = null;
		Connection conn = null;
		String strErrorCode = null;
		String strQuery = null;
		int count = 0;
		String usrID = null;
		
		try
		{
			usrID=correctNull((String)hshValues.get("strUserId"));
			strQuery=SQLParser.getSqlQuery("excel_loandetails_count");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				count = rs.getInt(1);
			}
			if(rs!=null)
				rs.close();
			
			if(count > 0)
			{
    		    conn=getConnection();
     			callstmt=conn.prepareCall("{?=call EXCELAPPLICATIONS(?)}");
				callstmt.registerOutParameter(1,Types.VARCHAR);
				callstmt.setString(2,usrID.trim());
				callstmt.execute();
				strErrorCode =callstmt.getString(1);
				if(!strErrorCode.equals("0"))
				  hshReturn.put("status",strErrorCode);
				else
				{
					hshReturn.put("status","Successfully uploaded to LAS");
				}
			}
			else
			{
				hshReturn.put("status","No Data Found");	
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error exceltoLaps in ExcelToLapsBean.." + e.getMessage());
		}
		finally {
			try {
				if (conn != null)
					conn.close();
				
				if(callstmt != null)
					callstmt.close();
				
				if(rs!=null)
					rs.close();
				
			} catch (Exception e1) {
				throw new EJBException("Error closing connection ExcelToLapsBean.." + e1);
			}
		}
		return hshReturn;
	}
	
	private StringBuffer updateCustomerProfilesData(Sheet sheet,int rows,StringBuffer errorDetails,String usrID)
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
	   // boolean upload   = true;
		String strQuery  = null;
		ResultSet rs1    = null;
		int count        = 0;
				
	   try
	   {
			for (int j = 1; j <=100; j++)
			{
				String s1 = "", s2 = "", s3 = "", s4 = "", s5 = "", s6 = "", s7 = "", s8 = "", s9 = "", s10 = "", s11 = "", s12 = "", s13 = "", s14 = "", s15 = "", s16 = "", s17 = "", s18 = "", s19 = "", s20 = "", s21 = "", s22 = "", s23 = "", s24 = "", s25 = "", s26 = "", s27 = "", s28 = "", s29 = "", s30 = "", s31 = "", s32 = "",
				s33 = "", s34 = "", s35 = "", s36 = "", s37 = "", s38 = "", s39 = "", s40 = "", s41 = "", s42 = "", s43 = "", s44 = "", s45 = "", s46 = "", s47 = "", s48 = "", s49 = "", s50 = "", s51 = "", s52 = "", s53 = "", s54 = "", s55 = "", s56 = "", s57 = "", s58 = "", s59= "", s60 = "", s61 = "", s62 = "", s63 = "", s64 = "",
				s65 = "", s66 = "", s67 = "", s68 = "", s69 = "", s70 = "", s71 = "", s72 = "", s73 = "", s74 = "", s75 = "", s76 = "", s77 = "", s78 = "", s79 = "", s80 = "", s81 = "", s82 = "", s83 = "";
				String branchiid="",guardname="",guardrel="",guardddr="";
					
				Cell id = sheet.getCell(0, j);
				s1 = id.getContents();
				if(!s1.equals(""))
				{
						
				Cell cbs_code = sheet.getCell(1, j);		
				s2=cbs_code.getContents();//Branch CBS Code - Mandatory
				
				if(s2.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Branch SolID").append("@");
				}
				
					strQuery = SQLParser.getSqlQuery("sel_shortorgcode^"+s2);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						branchiid = Helper.correctNull(rs1.getString("org_scode"));
					}
					if(rs1 != null)
					 rs1.close();
					
					if(branchiid.equals(""))
					{
						errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Branch SolID").append("@");
					}
				
				Cell cbs_id = sheet.getCell(2, j);	
				s3=cbs_id.getContents();//CBS ID 
				Cell title = sheet.getCell(3, j);	
				s4=title.getContents();//Title - drop - Mandatory
				
				if(s4.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Title").append("@");
				}
				Cell fullname = sheet.getCell(4, j);	
				s5=fullname.getContents();//Full Name of Applicant - Mandatory
				
				if(s5.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Full Name of Applicant").append("@");
				}
				Cell shortname = sheet.getCell(5, j);	
				s6=shortname.getContents();//Short Name
				Cell husname = sheet.getCell(6, j);
				s7=husname.getContents();//Father / Husband Name 
				Cell consti = sheet.getCell(7, j);
				s8=consti.getContents();//Constitution - drop (0,001-999) - Mandatory
				if(!s8.equals(""))
				{
					s8 = s8.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Constitution").append("@");
				}
				Cell pan = sheet.getCell(8, j);
				s9=pan.getContents();//PAN-TAN-GIR No
				if(s9.equals(""))
				{
					s9="NOPAN";
				}
				
				Cell dob = sheet.getCell(9, j);
				if(dob.getType()== CellType.DATE)
				{
					s10=dob.getContents();//Date of Birth - Mandatory
					s10 = doChangeFormat(s10);
					
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Date of Birth").append("@");
				}
				Cell sex = sheet.getCell(10, j);
				s11=sex.getContents();//Sex - drop (0,M,F,O) - Mandatory
				if(!s11.equals(""))
				{
					s11 = s11.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Sex").append("@");
				}
				Cell marital = sheet.getCell(11, j);
				s12=marital.getContents();//Marital Status - drop (S,1-5,) - Mandatory
				if(!s12.equals(""))
				{
					s12 = s12.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Marital Status").append("@");
				}
				Cell status = sheet.getCell(12, j);
				s13=status.getContents();//CBS Status - drop (0,001-006,999) - Mandatory
				if(!s13.equals(""))
				{
					s13 = s13.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - CBS Status").append("@");
				}
				Cell comadd1 = sheet.getCell(13, j);
				s14=comadd1.getContents();//Communication Address Line 1 - Mandatory
				if(s14.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication  Address 1").append("@");
				}
				Cell comadd2 = sheet.getCell(14, j);
				s15=comadd2.getContents();//Communication Address Line 2
				if(s15.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication Address 2").append("@");
				}
				
				Cell comadd3 = sheet.getCell(15, j);
				s16=comadd3.getContents();//Communication Address Village-Taluk-Town
				Cell comcity = sheet.getCell(16, j);
				s17=comcity.getContents();//Communication Address City - Mandatory
				if(s17.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication Address City Code as per Finacle/LAS").append("@");
				}
				Cell comstate = sheet.getCell(17, j);
				s18=comstate.getContents();//Communication Address State - Mandatory
				if(s18.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication Address State Code as per Finacle/LAS	").append("@");
				}
				Cell compin = sheet.getCell(18, j);
				s19=compin.getContents();//Communication Address Pin Code - Mandatory
				if(s19.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication Address Pin Code").append("@");
				}
				Cell comcoun = sheet.getCell(19, j);
				s20=comcoun.getContents();//Communication Address Country
				if(s20.equals(""))
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Communication Address Country Code as per Finacle/LAS").append("@");
				}
				
				Cell comphone = sheet.getCell(20, j);
				s21=comphone.getContents();//Communication Address Phone Number
				Cell emailid = sheet.getCell(21, j);
				s22=emailid.getContents();//Email ID
				Cell mobile = sheet.getCell(22, j);
				s23=mobile.getContents();//Mobile Number
				Cell peradd1 = sheet.getCell(23, j);
				s24=peradd1.getContents();//Permanent Address Line 1
				Cell peradd2 = sheet.getCell(24, j);
				s25=peradd2.getContents();//Permanent Address Line 2
				Cell peradd3 = sheet.getCell(25, j);
				s26=peradd3.getContents();//Permanent Address Village-Taluk-Town
				Cell percity = sheet.getCell(26, j);
				s27=percity.getContents();//Permanent Address City
				Cell perstate = sheet.getCell(27, j);
				s28=perstate.getContents();//Permanent Address State
				Cell perpin = sheet.getCell(28, j);
				s29=perpin.getContents();//Permanent Address Pin Code
				Cell percoun = sheet.getCell(29, j);
				s30=percoun.getContents();//Permanent Address Country
				Cell perphone = sheet.getCell(30, j);
				s31=perphone.getContents();//Permanent Address Phone Number
				
				//this column is removed in customer profile, So in excel we hide the column, 
				Cell prof = sheet.getCell(31, j);
				s32=prof.getContents();//Type of Profession
				
				Cell regno = sheet.getCell(32, j);
				s33=regno.getContents();//Registration Number
							
				//this column is removed in customer profile, So in excel we hide the column, 
				Cell voteid = sheet.getCell(33, j);
				s34=voteid.getContents();//Voter ID
				//this column is removed in customer profile, So in excel we hide the column,
				Cell licencse = sheet.getCell(34, j);
				s35=licencse.getContents();//Driving License Number
				//this column is removed in customer profile, So in excel we hide the column, 
				Cell otherdoc = sheet.getCell(35, j);
				s36=otherdoc.getContents();//Other Identification Document - drop (S,0,1,2,3)
				
				if(!s36.equals(""))
				{
					s36 = s36.split("-",2)[0];
				}	
				else
					s36 = "S";
			
				
				
				Cell mobility = sheet.getCell(36, j);
				s37=mobility.getContents();//Mobility -drop (0,1,2,3) - Mandatory
				if(!s37.equals(""))
				{
					s37 = s37.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Mobility").append("@");
				}
				Cell residence = sheet.getCell(37, j);
				s38=residence.getContents();//Is the Residence owned - drop (0,1-5) - Mandatory
			
				if(!s38.equals(""))
				{
					s38 = s38.split("-",2)[0];
				}
				else
				{
					errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Is the Residence owned").append("@");
				}
				Cell domicile = sheet.getCell(38, j);
				s39=domicile.getContents();//Place of Domicile
				Cell valresidence = sheet.getCell(39, j);
				s40=valresidence.getContents();//Value of the Residence
				if(s40.equals(""))
					s40="0";
				Cell datepurchase = sheet.getCell(40, j);
				if(datepurchase.getType()== CellType.DATE)
				{
					s41=datepurchase.getContents();//Date of Purchase
					s41 = doChangeFormat(s41);
				}
				Cell resistatus = sheet.getCell(41, j);
				s42=resistatus.getContents();//Resident Status -drop (0,1,2)
				if(!s42.equals(""))
				{
					s42 = s42.split("-",2)[0];
				}
				else
				{
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Resident Status").append("@");;
					s42 ="0";
				}
	
				Cell nri = sheet.getCell(42, j);
				s43=nri.getContents();//If NRI, Country 
				Cell nridate = sheet.getCell(43, j);
				if(nridate.getType()== CellType.DATE)
				{
					s44=nridate.getContents();//If NRI, Date of becoming NRI
					s44 = doChangeFormat(s44);
				}
				Cell passportno = sheet.getCell(44, j);
				s45=passportno.getContents();//Passport Number - Mandatory
				Cell passportissu = sheet.getCell(45, j);
				s46=passportissu.getContents();//Passport Issued By - Mandatory
				Cell passportissudate = sheet.getCell(46, j);
				if(passportissudate.getType()== CellType.DATE)
				{	
					s47=passportissudate.getContents();//Passport Issue Date - Mandatory
					s47 = doChangeFormat(s47);
				}
				Cell passportexpdate = sheet.getCell(47, j);
				if(passportexpdate.getType()== CellType.DATE)
				{
					s48=passportexpdate.getContents();//Passport Expiry Date - Mandatory
					s48 = doChangeFormat(s48);
				}
				
				if(s42.equals("2")&& (s45.equals("")||s45.equals("")||s46.equals("") || s47.equals("")||s48.equals("")))
				{
					
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Passport Expiry Date").append("@");;
					
				}
				Cell empstatus = sheet.getCell(48, j);
				s49=empstatus.getContents();//Employment Status - drop (4) - Mandatory
				if(!s49.equals(""))
				{
					s49 = s49.split("-",2)[0];
				}
				else
				{
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Employment Status").append("@");;
				}
				Cell lineactivity = sheet.getCell(49, j);
				s50=lineactivity.getContents();//Line of Activity - drop (4_S,1_4-10_4)
				if(!s50.equals(""))
				{
					s50 = s50.split("-",2)[0];
				}
				else
					s50="4_S";
				Cell indbsrcode = sheet.getCell(50, j);
				s51=indbsrcode.getContents();//Industry BSR Code
				Cell banking = sheet.getCell(51, j);
				s52=banking.getContents();//Banking with us - drop (1,2)
				if(!s52.equals(""))
				{
					s52 = s52.split("-",2)[0];
				}
				else
				{
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Banking with us").append("@");;
					s52 = "2";	
				}
				
				Cell bankingsince = sheet.getCell(52, j);
				s53=bankingsince.getContents();//Banking since year - Mandatory

				Cell acctype = sheet.getCell(53, j);
				s54=acctype.getContents();//Account Type
				Cell accno = sheet.getCell(54, j);
				s55=accno.getContents();//Account Number
				Cell salarouted = sheet.getCell(55, j);
				s56=salarouted.getContents();//Is salary routed through our Bank - drop (1,2)
				if(!s56.equals(""))
				{
					s56 = s56.split("-",2)[0];
				}
				else
					s56 = "2";	
				Cell category = sheet.getCell(56, j);
				s57=category.getContents();//Category - drop (S,001-999) - Mandatory
				if(!s57.equals(""))
				{
					s57= s57.split("-",2)[0];
				}
				else
				{
					
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Category").append("@").append("@");;;
					
				}
				Cell caste = sheet.getCell(57, j);
				s58=caste.getContents();//Caste
				Cell religion = sheet.getCell(58, j);
				s59=religion.getContents();//Religion - drop (0,001-999) - Mandatory
				if(!s59.equals(""))
				{
					s59= s59.split("-",2)[0];
				}
				else
				{
					
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Religion").append("@");;
					
				}
				Cell children = sheet.getCell(59, j);
				s60=children.getContents();//Number of Dependent Children
				Cell others = sheet.getCell(60, j);
				s61=others.getContents();//Number of Dependent Others
				Cell earning = sheet.getCell(61, j);
				s62=earning.getContents();//Earning Member in Family - Mandatory
				if(s62.equals(""))
				{
					
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Earning Member in Family").append("@");;
					
				}
				Cell otherearning = sheet.getCell(62, j);
				s63=otherearning.getContents();//Other Earning Members in Family
				Cell eduqual = sheet.getCell(63, j);
				s64=eduqual.getContents();//Educational Qualifications - drop(0,1-10) - Mandatory
				if(!s64.equals(""))
				{
					s64= s64.split("-",2)[0];
				}
				else
				{
					
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Educational Qualifications ").append("@");;
					
				}
				Cell areaspec = sheet.getCell(64, j);
				s65=areaspec.getContents();//Area Specialised
				Cell phychall = sheet.getCell(65, j);
				s66=phychall.getContents();//Physically Challenged - drop (Y,N)
				if(!s66.equals(""))
				{
					s66 = s66.split("-",2)[0];
				}
				else
					s66 = "N";	
				Cell minority = sheet.getCell(66, j);
				s67=minority.getContents();//Minority - drop (Y,N)
				if(!s67.equals(""))
				{
					s67 = s67.split("-",2)[0];
				}
				else
					s67 = "N";
				Cell exserviceman = sheet.getCell(67, j);
				s68=exserviceman.getContents();//Ex-Serviceman - drop (Y,N)
				if(!s68.equals(""))
				{
					s68 = s68.split("-",2)[0];
				}
				else
					s68 = "N";
				Cell exservicemanyear = sheet.getCell(68, j);
				s69=exservicemanyear.getContents();//Ex-serviceman's years in service - mandatory 

				Cell anyrelative = sheet.getCell(69, j);
				s70=anyrelative.getContents();//Any relative is working in the bank - drop (1,0)
				if(!s70.equals(""))
				{
					s70 = s70.split("-",2)[0];
				}
				else
					s70 = "1";
				Cell anyrelativebran = sheet.getCell(70, j);
				s71=anyrelativebran.getContents();//Relative working with which branch
				Cell relativename = sheet.getCell(71, j);
				s72=relativename.getContents();//Relative Name and Designation 
				Cell minor = sheet.getCell(72, j);
				s73=minor.getContents();//Whether Minor - drop (2) --nOT nET
				if(!s73.equals(""))
				{
					s73 = s73.split("-",2)[0];
				}
				else
					s73 = "2";
				Cell guardianname = sheet.getCell(73, j);
				guardname=guardianname.getContents();//Guardian Name 
				Cell guardianrel = sheet.getCell(74, j);
				guardrel=guardianrel.getContents();//Guardian Relationship
				Cell guardianaddr = sheet.getCell(75, j);
				guardddr=guardianaddr.getContents();//Guardian Address
//				if(s73.equals("1") && (guardianname.equals("") || guardianrel.equals("") || guardianaddr.equals("")) )
//				{
//					errorflag="1";
//				}
				Cell tradefin = sheet.getCell(76, j);
				s74=tradefin.getContents();//Trade Finance - drop (1,2)
				if(!s74.equals(""))
				{
					s74 = s74.split("-",2)[0];
				}
				else
					s74 = "2";
				Cell inlandtrade = sheet.getCell(77, j);
				s75=inlandtrade.getContents();//Inland Trade Allowed - drop (1,2)
				if(!s75.equals(""))
				{
					s75 = s75.split("-",2)[0];
				}
				else
					s75 = "2";
				
				//this column is removed in customer profile, So in excel we hide the column, 
				Cell introtitle = sheet.getCell(78, j);
				s76=introtitle.getContents();//Introducer Title - drop - Mandatory
				
				//this column is removed in customer profile, So in excel we hide the column, 
				Cell introname = sheet.getCell(79, j);
				s77=introname.getContents();//Introducer Name - mandatory
				
				Cell spousetitle = sheet.getCell(80, j);
				s78=spousetitle.getContents();//Spouse Title  - drop 
				Cell spousename = sheet.getCell(81, j);
				s79=spousename.getContents();//Name of Spouse
				Cell occspouse = sheet.getCell(82, j);
				s80=occspouse.getContents();//Occupation of Spouse
				if(!s80.equals(""))
				{
					s80 = s80.split("-",2)[0];
				}
				else
					s80 = "0";
				Cell spouseemail = sheet.getCell(83,1);
				s81=spouseemail.getContents();
				Cell spouspan = sheet.getCell(84,1);
				s82=spouspan.getContents();//Spouse PAN-GIR
				Cell spousnet = sheet.getCell(85,1);
				s83=spousnet.getContents();//Spouse Net Monthly Income
				if(s83.equals(""))
					s83="0";
				
				
				
	
				
				String  inc_s2 = "", inc_s3 = "", inc_s4 = "", inc_s5 = "", inc_s6 = "", inc_s7 = "", inc_s8 = "", inc_s9 = "", inc_s10 = "", inc_s11 = "", inc_s12 = "", inc_s13 = "", inc_s14 = "", inc_s15 = "", inc_s16 = "", inc_s17 = "", inc_s18 = "", 
				inc_s19 = "", inc_s20 = "", inc_s21 = "", inc_s22 = "", inc_s23 = "", inc_s24 = ""; 
				
				double yearsalary=0;
				double monthsalary=0;
				double yearincometax=0;
				double monthincometax=0;
				double otherincometotal=0;
				double otherinc_yrs=0;
				double grossincome=0;
				double otherdeduc=0;
				double takehome=0;
				double yearotherdeduc=0;
				//String consts="";
				
				
					
					Cell primary = sheet.getCell(86, j);
					inc_s2=primary.getContents();//Primary Income Details - Mandatory
					if(!inc_s2.equals(""))
					{
						inc_s2= inc_s2.split("-",2)[0];
						
					}
					else
					{						
						errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Primary Income Details").append("@");;
					}
					Cell gross_income = sheet.getCell(87, j);
					grossincome=Double.parseDouble(Helper.correctDouble(gross_income.getContents()));//Gross Income Salary/Pension
					Cell incometax = sheet.getCell(88, j);
					inc_s3=incometax.getContents();//Income Tax
					if(!inc_s3.equals(""))
					{
						inc_s3= inc_s3.split("-",2)[0];
						
					}
					Cell rentincome = sheet.getCell(89, j);
					inc_s4=rentincome.getContents();//Rent Income
					Cell agriincome = sheet.getCell(90, j);
					inc_s5=agriincome.getContents();//Agriculture Income
					Cell otherincome = sheet.getCell(91, j);
					inc_s6=otherincome.getContents();//Other Income
					
					otherincometotal = Double.parseDouble(Helper.correctDouble(inc_s4)) +Double.parseDouble(Helper.correctDouble(inc_s5))+Double.parseDouble(Helper.correctDouble(inc_s6));
					if(inc_s2.equals("1"))//Monthly
					{	monthsalary = grossincome;
						yearsalary = 12 * grossincome;
						monthincometax = Double.parseDouble(Helper.correctDouble(inc_s3));
						yearincometax = 12 * Double.parseDouble(Helper.correctDouble(inc_s3));
						otherinc_yrs = 12 * otherincometotal;
						
					}
					else if(inc_s2.equals("2"))
					{
						yearsalary = grossincome;
						monthsalary =  grossincome / 12;
						monthincometax = Double.parseDouble(Helper.correctDouble(inc_s3)) /12;
						yearincometax = Double.parseDouble(Helper.correctDouble(inc_s3));
						otherinc_yrs = otherincometotal;
					}
					Cell lengthrel = sheet.getCell(92, j);
					inc_s7=lengthrel.getContents();//Length of Relationship with the Bank -drop (0,1-6) Mandatory
					if(!inc_s7.equals(""))
					{
						inc_s7= inc_s7.split("-",2)[0];
						
					}
					else
					{						
						errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Length of Relationship with the Bank").append("@");;
					}
					Cell recrepay = sheet.getCell(93, j);
					inc_s8=recrepay.getContents();//Record of Repayment -drop (0,1-8) Mandatory
					if(!inc_s8.equals(""))
					{
						inc_s8= inc_s8.split("-",2)[0];
						
					}
					else
					{						
						errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Record of Repayment").append("@");;
					}
					Cell annualinc = sheet.getCell(94, j);
					inc_s9=annualinc.getContents();//Annual Income Pattern -drop (0,1-4) Mandatory
					if(!inc_s9.equals(""))
					{
						inc_s9= inc_s9.split("-",2)[0];
						
					}
					else
					{
						inc_s9="0";
						
					}
					Cell incomedetails = sheet.getCell(95, j);
					inc_s10=incomedetails.getContents();//Income Tax Details -drop (0,1,2) Mandatory
					if(!inc_s10.equals(""))
					{
						inc_s10= inc_s10.split("-",2)[0];
						
					}
					else
					{
						errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Income Tax Details").append("@");;
						
					}
					Cell totalloan = sheet.getCell(96, j);
					inc_s11=totalloan.getContents();//Total Loan Repayment
					Cell insupay = sheet.getCell(97, j);
					inc_s12=insupay.getContents();//Insurance Payment	
					Cell otherdeduc1 = sheet.getCell(98, j);
					inc_s13=otherdeduc1.getContents();//Other Deductions 1	
					Cell otherdeduc2 = sheet.getCell(99, j);
					inc_s14=otherdeduc2.getContents();//Other Deductions 2	
					otherdeduc = Double.parseDouble(Helper.correctDouble(inc_s11))+Double.parseDouble(Helper.correctDouble(inc_s12))+Double.parseDouble(Helper.correctDouble(inc_s13))+Double.parseDouble(Helper.correctDouble(inc_s14));
					takehome = yearsalary - yearincometax -otherdeduc  +otherinc_yrs;
					yearotherdeduc= otherdeduc*12;
					Cell descdeduc = sheet.getCell(100, j);
					inc_s15=descdeduc.getContents();//Description of Deductions
					Cell latestit = sheet.getCell(101, j);
					inc_s16=latestit.getContents();//Latest IT Return Verified
					if(!inc_s16.equals(""))
					{
						inc_s16= inc_s16.split("-",2)[0];
						
					}
					else
					{
						inc_s16= "N";
						
					}
					Cell ass_liab = sheet.getCell(102, j);
					inc_s17=ass_liab.getContents();//Statement of Assets & Liabilities verfied ?
					if(!inc_s17.equals(""))
					{
						inc_s17= inc_s17.split("-",2)[0];
						
					}
					else
					{
						inc_s17= "N";
						
					}
					Cell annualincyear1 = sheet.getCell(103, j);
					inc_s18=annualincyear1.getContents();//Annual Income Year1
					Cell annualincamt1 = sheet.getCell(104, j);
					inc_s19=annualincamt1.getContents();//Annual Income Year1 Amount
					Cell annualincyear2 = sheet.getCell(105, j);
					inc_s20=annualincyear2.getContents();//Annual Income Year2
					Cell annualincamt2 = sheet.getCell(106, j);
					inc_s21=annualincamt2.getContents();//Annual Income Year2 Amount
					Cell annualincyear3 = sheet.getCell(107, j);
					inc_s22=annualincyear3.getContents();//Annual Income Year3
					Cell annualincamt3 = sheet.getCell(108, j);
					inc_s23=annualincamt3.getContents();//Annual Income Year3 Amount
					Cell particulars = sheet.getCell(109, j);
					inc_s24=particulars .getContents();//Particulars of Income Tax & Sales Tax Assessment
					
					
					/*if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_agrexcelcustomerprofile^"+s1);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						consts = Helper.correctNull(rs1.getString("excel_perapp_constitution"));
					}
					if(rs1 != null)
					{
						rs1.close();
					}*/
					
					
					
			
				String emp_s2 = "", emp_s3 = "", emp_s4 = "", emp_s5 = "", emp_s6 = "", emp_s7 = "", 
				emp_s8 = "", emp_s9 = "", emp_s10 = "", emp_s11 = "", emp_s12 = "", emp_s13 = "", emp_s14 = "", emp_s15 = "", emp_s16 = "", emp_s17 = "", 
				emp_s18 = "", emp_s19 = "", emp_s20 = "", emp_s21 = "", emp_s22 = "", emp_s23 = "", emp_s24 = "", emp_s25 = "",emp_s26="",emp_s27="",emp_s28=""; 
				
				int serv_month=0;
				int serv_left=0;
				
					
				Cell companyname = sheet.getCell(110, j);
				emp_s2=companyname.getContents();//Company Name
				Cell companyadd1 = sheet.getCell(111, j);
				emp_s3=companyadd1.getContents();//Address Line 1
				Cell companyadd2 = sheet.getCell(112, j);
				emp_s4=companyadd2.getContents();//Address Line 2
				Cell companyadd3 = sheet.getCell(113, j);
				emp_s5=companyadd3.getContents();//Address Line 3
				Cell companycity = sheet.getCell(114, j);
				emp_s6=companycity.getContents();//City
				Cell companystate = sheet.getCell(115, j);
				emp_s7=companystate.getContents();//State
				Cell companypin = sheet.getCell(116, j);
				emp_s8=companypin.getContents();//Pincode
				Cell companycoun = sheet.getCell(117, j);
				emp_s9=companycoun.getContents();//Country
				Cell companyphone = sheet.getCell(118, j);
				emp_s10=companyphone.getContents();//Phone No.
				Cell companyfax = sheet.getCell(119, j);
				emp_s11=companyfax.getContents();//Fax No.
				Cell companyemail = sheet.getCell(120, j);
				emp_s12=companyemail.getContents();//Company E-mail.
				Cell companyempid = sheet.getCell(121, j);
				emp_s13=companyempid.getContents();//Employee ID
				Cell  emp_category = sheet.getCell(122, j);
				emp_s14=emp_category.getContents();//Category
				if(!emp_s14.equals(""))
				{
					emp_s14= emp_s14.split("-",2)[0];
					
				}
				else
				{
					emp_s14= "0";
					
				}
				Cell  occup = sheet.getCell(123, j);
				emp_s15=occup.getContents();//Occupation -Mandatory
				if(!emp_s15.equals(""))
				{
					if(!emp_s15.equals("FACULTY"))
					{
						emp_s15= emp_s15.split("-",2)[0];
					}
					
				}
				else
				{
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Educational Qualifications ").append("@");;
				}
				Cell  design = sheet.getCell(124, j);
				emp_s16=design.getContents();//Designation
				Cell  depart = sheet.getCell(125, j);
				emp_s17=depart.getContents();//Department Name
				Cell  licenseno = sheet.getCell(126, j);
				emp_s18=licenseno.getContents();//License Number
				Cell  licensedate = sheet.getCell(127, j);
				if(licensedate.getType()== CellType.DATE)
				{
					emp_s19=licensedate.getContents();//License Date
					emp_s19 = doChangeFormat(emp_s19);
				}
				Cell  phoneextn = sheet.getCell(128, j);
				emp_s20=phoneextn.getContents();//Phone Extn.
				Cell  receiptdate = sheet.getCell(129, j);
				if(receiptdate.getType()== CellType.DATE)
				{
					emp_s21=receiptdate.getContents();//Salary Receipt Date
					emp_s21 = doChangeFormat(emp_s21);
				}
				Cell  yearinbus = sheet.getCell(130, j);
				emp_s22=yearinbus.getContents();//Years in Business
				if(emp_s22.equals(""))
					emp_s22="0";
				Cell  retiredate = sheet.getCell(131, j);
				if(retiredate.getType()== CellType.DATE)
				{
					emp_s23=retiredate.getContents();//Retirement Date
					emp_s23 = doChangeFormat(emp_s23);
					
					String Curdate = Helper.getCurrentDateTime();
					String curryear = Helper.getCurrentDateTime().substring(6,10);
					String retyear = emp_s23.substring(6,10);
					String currmonth = Helper.getCurrentDateTime().substring(3,5);
					String retmonth = emp_s23.substring(3,5);
					
					
				 if(Integer.parseInt(retyear)>Integer.parseInt(curryear))
					{
						if(Integer.parseInt(retmonth)>Integer.parseInt(currmonth))
						{
							serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
					  		serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
					  	}
						else if(Integer.parseInt(retmonth) < Integer.parseInt(currmonth))
						{
							serv_month=Integer.parseInt(retmonth)+12-Integer.parseInt(currmonth);
					  		serv_left=Integer.parseInt(retyear)-1-Integer.parseInt(curryear);
					  	}
						else
						{
							if(Integer.parseInt(emp_s23.substring(0,2))>=Integer.parseInt(Curdate.substring(0,2)))
								{
								serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
					  			serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
					  			}
							else
								{
								serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth)+11;
					  			serv_left=Integer.parseInt(retyear)-1-Integer.parseInt(curryear);
					  			}
						}
					}
				else if(Integer.parseInt(retyear)==Integer.parseInt(curryear))
					{
						if(Integer.parseInt(retmonth)>=Integer.parseInt(currmonth))
						{
							serv_month=Integer.parseInt(retmonth)-Integer.parseInt(currmonth);
					  		serv_left=Integer.parseInt(retyear)-Integer.parseInt(curryear);
					  		
						}
					}
				}
				Cell  commendate = sheet.getCell(132, j);
				if(commendate.getType()== CellType.DATE)
				{
					emp_s24=commendate.getContents();//Date of Commencement of Business
					emp_s24 = doChangeFormat(emp_s24);
				}
				Cell  premises = sheet.getCell(133, j);
				emp_s25=premises.getContents();//Business Premises
				if(!emp_s25.equals(""))
				{
					emp_s25= emp_s25.split("-",2)[0];
					
				}
				else
				{
					emp_s25= "0";
												
				}
				Cell  leaseperiod = sheet.getCell(134, j);
				emp_s26=leaseperiod.getContents();//Lease Period
				if(emp_s26.equals(""))
					emp_s26="0";
				Cell  contact = sheet.getCell(135, j);
				emp_s27=contact.getContents();//Contact Person
				Cell  pastexp = sheet.getCell(136, j);
				emp_s28=pastexp.getContents();//Past Experience
		//KYC NORMS	
				String strCustType = null;
				String strAnnualIncome = null;
				String strOccupationCode = null;
				String strOccupation = null;
				String strFormType = null;
				String strResCtyCode = null;
				String strRefno = null;
				String strResProofType = null;
				String strResRefno = null;
				String strIdProofType = null;
				String strIdRefno = null;
				String strNetworth = null;
				String strPooledType = null;
				String strAnnualturnover = null;
				String strAnnTurnEstimated = null;
				String strnof = null;
				String strofac = null;
				String strForeignRem = null;
				String strRemCtyCode = null;
				String strRisk = null;
				String strSource = null;
		

				Cell  c137 = sheet.getCell(137, j);
				strCustType=c137.getContents();//Customer Type
				if(!strCustType.equals(""))
					strCustType = strCustType.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Corporate Customer").append("@");;
				
				Cell  c138 = sheet.getCell(138, j);
				strAnnualIncome=c138.getContents();//Annual Income
				if(!strAnnualIncome.equals(""))
					strAnnualIncome = strAnnualIncome.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Annual Income").append("@");;
									
				Cell  c139 = sheet.getCell(139, j);
				strOccupationCode=c139.getContents();//Occupation code
				if(!strOccupationCode.equals(""))
					strOccupationCode = strOccupationCode.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Customer Occupation Code").append("@");;
				
				Cell  c140 = sheet.getCell(140, j);
				strOccupation=c140.getContents();//Occupation
				if(strOccupation.equals(""))
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Occupation").append("@");;
				
				
				Cell  c141 = sheet.getCell(141, j);
				strFormType=c141.getContents();//Form 60/61
				if(!strFormType.equals(""))
					strFormType = strFormType.split("-",2)[1];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Form 60/61").append("@");;
				
				Cell  c142 = sheet.getCell(142, j);
				strResCtyCode=c142.getContents();//Country of residence code
				if(strResCtyCode.equals(""))
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Country of residence Code").append("@");;
				
				Cell  c143 = sheet.getCell(143, j);
				strRefno=c143.getContents();//Ref. no
				if(strRefno.equals(""))
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Ref No.").append("@");;
				
				Cell  c144 = sheet.getCell(144, j);
				strResProofType=c144.getContents();//Residence Proof type
				if(!strResProofType.equals(""))
					strResProofType = strResProofType.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Residence Proof Type").append("@");;
				
				
				Cell  c145 = sheet.getCell(145, j);
				strResRefno=c145.getContents();//Residence ID Ref no
				if(strResRefno.equals(""))
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Residence ID Reference").append("@");;
				
				Cell  c146 = sheet.getCell(146, j);
				strIdProofType=c146.getContents();//ID Proof Type
				if(!strIdProofType.equals(""))
					strIdProofType = strIdProofType.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - ID Proof Type").append("@");;
				
				Cell  c147 = sheet.getCell(147, j);
				strIdRefno=c147.getContents();//ID Ref. no
				if(strIdRefno.equals(""))
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - ID Reference").append("@");;
				
				Cell  c148 = sheet.getCell(148, j);
				strSource=c148.getContents();//Source of Income
				if(!strSource.equals(""))
					strSource = strSource.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Source of Income").append("@");;
				
				Cell  c149 = sheet.getCell(149, j);
				strNetworth=c149.getContents();//Networth
				if(!strNetworth.equals(""))
					strNetworth = strNetworth.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Networth (in Rs.)").append("@");;

				Cell  c150 = sheet.getCell(150, j);
				strPooledType=c150.getContents();//Pooled account
				if(!strPooledType.equals(""))
					strPooledType = strPooledType.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Pooled Account").append("@");;
				
				Cell  c151 = sheet.getCell(151, j);
				strAnnualturnover=c151.getContents();//Annual Turnover
				if(!strAnnualturnover.equals(""))
					strAnnualturnover = strAnnualturnover.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Annual Turn Over").append("@");;
				
				Cell  c152 = sheet.getCell(152, j);
				strAnnTurnEstimated=c152.getContents();//Annual Turnover estimated
				if(!strAnnTurnEstimated.equals(""))
					strAnnTurnEstimated = strAnnTurnEstimated.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Annual Turn Over(Estimated)").append("@");;
				
				Cell  c153 = sheet.getCell(153, j);
				strnof=c153.getContents();//nature of activity
				if(!strnof.equals(""))
					strnof = strnof.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Nature of Activity").append("@");;
				
				Cell  c154 = sheet.getCell(154, j);
				strofac=c154.getContents();//OFAC/UNSCAN
		
				if(!strofac.equals(""))
					strofac = strofac.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - OFAC/UNSCAN").append("@");;
				
				Cell  c155 = sheet.getCell(155, j);
				strForeignRem=c155.getContents();//Foreign Inward Remittance
				if(!strForeignRem.equals(""))
					strForeignRem = strForeignRem.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Foreign Inward Remittance").append("@");;
				
				Cell  c156 = sheet.getCell(156, j);
				strRemCtyCode=c156.getContents();//Mandatory only for Foreign inward remittance is "Yes" Remit Country Code
				
				if(strForeignRem.equals("Y"))
				{
			    	if(strRemCtyCode.equals(""))
			    		errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Mandatory only for Foreign inward remittance is Yes Remit Country Code").append("@");;
				}	
				
				Cell  c157 = sheet.getCell(157, j);
				strRisk=c157.getContents();//Risk categorization
				
				if(!strRisk.equals(""))
					strRisk = strRisk.split("-",2)[0];
				else
					errorDetails = errorDetails.append("$Sheet - Customer Profile $S.No - "+s1+" $Column - Risk Categorization").append("@");;
				
		
				if(errorDetails.toString().equals(""))
				{
					insertCustomer(s1,s2,"",s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14  
							,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25 
							,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38,s39  
							,s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s50,s51,s52,s53 
							,s54,s55,s56,s57,s58,s59,s60,s61,s62,s63,s64,s65,s66,s67,s68  
							,s69,s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s80,s81,s82,s83,branchiid,guardname,guardrel,guardddr,
							strCustType,strAnnualIncome,strOccupationCode,strOccupation ,strFormType,strResCtyCode,strRefno,
							strResProofType,strResRefno,strIdProofType,strIdRefno,strNetworth ,strPooledType,strAnnualturnover,strAnnTurnEstimated,
							strnof,strofac,strForeignRem,strRemCtyCode,strRisk,strSource,usrID);
					
					insertIncomeandExp(s1,"",jtn.format(monthsalary),jtn.format(takehome),jtn.format(otherincometotal),inc_s4,inc_s5,jtn.format(otherinc_yrs)
							,inc_s11,inc_s13,inc_s14,s8,"A",inc_s6,inc_s12,jtn.format(monthincometax),inc_s15,jtn.format(otherdeduc),jtn.format(yearsalary),jtn.format(yearincometax),jtn.format(yearotherdeduc),inc_s16,inc_s17,inc_s18,inc_s20,inc_s22,inc_s19,inc_s21,inc_s23,inc_s9,inc_s10,inc_s7,inc_s8,inc_s2,inc_s24,usrID);
					
					insertEmpDetails(s1,"",emp_s2,emp_s3,emp_s4,emp_s5,emp_s6,emp_s7,emp_s8,emp_s9,emp_s10,emp_s11,emp_s12,emp_s13,emp_s14,emp_s15,emp_s16,emp_s17,emp_s18,emp_s19,emp_s20,emp_s21,Integer.toString(serv_left),Integer.toString(serv_month),emp_s22,emp_s23,emp_s24,emp_s25,emp_s26,emp_s27,emp_s28,usrID);
					count = count + 1;
				}
			
		}	
	
	} 
		   
	   }
	   catch (Exception e) {
			
			throw new EJBException("Error in updateCustomerProfilesData"+e.getMessage());
		
		} finally {
			try {
				if (rs1 != null) {
					rs1.close();
			
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return errorDetails;
	}
	private StringBuffer LoanDetailsData(Sheet sheet,int rows,String usrID,StringBuffer errorDetails)
	{
	    boolean upload   = true;
		String strQuery  = null;
		ResultSet rs    = null;
		int count        = 0;
		
	   try
	   {
			for (int j = 1; j < rows; j++)
			{
				String strId = null;
				String strBranchcode = null;
				String strLapsOrgCode = null;
				String strProductCode = null;
				String strAmtReq = null;
				String strCostOfProject = null;
				String strMoraPeriod = null;
				String strRequestTerms = null;
				String strInterestType = null;
				String strIntTypeMode = null;
			String strInstallmentType = null;
				String strGovtScheme = null;
				String strAgency = null;
				String strSchemeType = null;
				String strSubsidyAmt = null;
				String strSubsidyType = null;
				String strPurpose = null;
				String strMeasure = null;
				String strSecured = null;
				String strAmtSecure = null;
				String strRepaymentType = null;
				String strModeofPayment = null;
				String strFacilityType = null;
				String strApplReceived = null;
				String strCoapplicants = null;
				String strGuarantors = null;
				
				
				Cell c0 = sheet.getCell(0, j);
				strId = c0.getContents();
				if(!strId.equals(""))
				{
					Cell c1 = sheet.getCell(1, j);		
					strBranchcode=c1.getContents();//Branch CBS Code - Mandatory
				
				if(strBranchcode.equals(""))
				{
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Branch SolID").append("@");
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_shortorgcode^"+strBranchcode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLapsOrgCode = Helper.correctNull(rs.getString("org_scode"));
					}
					if(rs != null)
					 rs.close();
					
				}
				Cell c2 = sheet.getCell(2, j);	
				strProductCode=c2.getContents();//Product Code
				
				if(strProductCode.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - LAS Product Code").append("@");
				
				Cell c3 = sheet.getCell(3, j);	
				strAmtReq=c3.getContents();//Amount Requested
				if(strAmtReq.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Amount Requested").append("@");
								
				Cell c4 = sheet.getCell(4, j);	
				strCostOfProject=c4.getContents();//Cost of Project
				if(strCostOfProject.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Cost of the Project").append("@");
					
				Cell c5 = sheet.getCell(5, j);	
				strMoraPeriod=c5.getContents();//Intial holiday
				
				Cell c6 = sheet.getCell(6, j);	
				strRequestTerms=c6.getContents();//Repayment period
				if(strRequestTerms.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Repayment Period in months").append("@");
				
				Cell c7 = sheet.getCell(7, j);	
				strInterestType=c7.getContents();//Interest Type
				if(strInterestType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Interest Type").append("@");
				
				strIntTypeMode="1";//Default value Interest Type Mode
				
				Cell c8 = sheet.getCell(8, j);	
				strInstallmentType=c8.getContents();//Periodicity
				if(!strInstallmentType.equals(""))
				{
					strInstallmentType=strInstallmentType.split("-",2)[0];
				}
				if(strInstallmentType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Periodicity of Instalments").append("@");
				
				
				Cell c9 = sheet.getCell(9, j);	
				strGovtScheme=c9.getContents();//Govt sponser scheme
				if(!strGovtScheme.equals(""))
				{
					strGovtScheme=strGovtScheme.split("-",2)[0];
				}
				
				if(strGovtScheme.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Govt. Sponsor Scheme").append("@");
				
				Cell c10 = sheet.getCell(10, j);	
				strAgency=c10.getContents();//Sponsor Agency
				if(!strAgency.equals(""))
				{
					strAgency=strAgency.split("-",2)[0];
				}
				Cell c11 = sheet.getCell(11, j);	
				strSchemeType=c11.getContents();//Scheme Type
				if(!strSchemeType.equals(""))
				{
					strSchemeType=strSchemeType.split("-",2)[0];
				}
							
				Cell c12 = sheet.getCell(12, j);	
				strSubsidyAmt=c12.getContents();//Subsidy Amount
				
				Cell c13 = sheet.getCell(13, j);	
				strSubsidyType=c13.getContents();//Subsidy Type
				if(!strSubsidyType.equals(""))
				{
					strSubsidyType=strSubsidyType.split("-",2)[0];
				}
				
				
				Cell c14 = sheet.getCell(14, j);	
				strPurpose=c14.getContents();//Purpose  of loan
				if(strPurpose.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Purpose of Loan").append("@");
				
				Cell c15 = sheet.getCell(15, j);	
				strMeasure=c15.getContents();//Measurement Type
				if(!strMeasure.equals(""))
				{
					strMeasure=strMeasure.split("-",2)[0];
				}
								
				if(strMeasure.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Measurement Type").append("@");
				
				Cell c16 = sheet.getCell(16, j);	
				strSecured=c16.getContents();//Whether Secured
				if(!strSecured.equals(""))
				{
					strSecured=strSecured.split("-",2)[0];
				}
				
				if(strSecured.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Whether Secured").append("@");
				
				Cell c17 = sheet.getCell(17, j);	
				strAmtSecure=c17.getContents();//Amount Secured
				
				Cell c18 = sheet.getCell(18, j);	
				strRepaymentType=c18.getContents();//Repayment Type
				if(!strRepaymentType.equals(""))
				{
					strRepaymentType=strRepaymentType.split("-",2)[0];
				}
				
				if(strRepaymentType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Repayment Type").append("@");
				
				Cell c19 = sheet.getCell(19, j);	
				strModeofPayment=c19.getContents();//Mode of Payment
				if(!strModeofPayment.equals(""))
				{
					strModeofPayment=strModeofPayment.split("-",2)[0];
				}
				if(strModeofPayment.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Mode of Payment").append("@");
				
				Cell c20 = sheet.getCell(20, j);	
				strFacilityType=c20.getContents();//Facility Type
				if(!strFacilityType.equals(""))
				{
					strFacilityType=strFacilityType.split("-",2)[0];
				}
				
				if(strFacilityType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Facility Type").append("@");
				
				strApplReceived = "";
				Cell c21 = sheet.getCell(21, j);	
				if(c21.getType() == CellType.DATE)
				{
					strApplReceived=c21.getContents();//Application Received date
					strApplReceived = doChangeFormat(strApplReceived);
					
				}
				
				if(strApplReceived.equals(""))
				{
					errorDetails = errorDetails.append("$Sheet - Loan Details $S.No - "+strId+" $Column - Application Received on").append("@");
				}
				
				
				Cell c22 = sheet.getCell(22, j);	
				strCoapplicants=c22.getContents();  //Co-applicants
				
				Cell c23 = sheet.getCell(23, j);	
				strGuarantors=c23.getContents();  //Guarantors
				
				if(errorDetails.toString().equals(""))
				{
						insertApplications(strId,strBranchcode,strLapsOrgCode,strProductCode,strAmtReq,
									strCostOfProject,strMoraPeriod,strRequestTerms,strInterestType,strIntTypeMode,strInstallmentType,strGovtScheme,
									strAgency,strSchemeType,strSubsidyAmt,strSubsidyType,strPurpose,strMeasure,
									strSecured,strAmtSecure,strRepaymentType,strModeofPayment,strFacilityType,strApplReceived,strCoapplicants,strGuarantors,usrID);
						count = count + 1;
				}
			
		}	
	
	} 
		   
	   }
	   catch (Exception e) {
			
			throw new EJBException("Error in updateCustomerProfilesData"+e.getMessage());
		
		} finally {
			try {
				if (rs != null) {
					rs.close();
			
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return errorDetails;
	}
	
	private void insertApplications(String strId,String strBranchcode,String strLapsOrgCode,String strProductCode,String strAmtReq,
			String strCostOfProject,String strMoraPeriod,String strRequestTerms,String strInterestType,String strIntTypeMode,String strInstallmentType,String strGovtScheme,
			String strAgency,String strSchemeType,String strSubsidyAmt,String strSubsidyType,String strPurpose,String strMeasure,
			String strSecured,String strAmtSecure,String strRepaymentType,String strModeofPayment,String strFacilityType,String strApplReceived,String strCoapplicants,String strGuarantors,String usrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "excel_loandetails_agri_insert");
		arrValues.add(strId); 
		arrValues.add(strBranchcode); 
		arrValues.add(strLapsOrgCode);
		arrValues.add(strProductCode);
		arrValues.add(strAmtReq); 
		arrValues.add(strCostOfProject); 
		arrValues.add(strMoraPeriod); 
		arrValues.add(strRequestTerms);
		arrValues.add(strInterestType); 
		arrValues.add(strIntTypeMode); 
		arrValues.add(strInstallmentType); 
		arrValues.add(strGovtScheme);
		arrValues.add(strAgency);
	    arrValues.add(strSchemeType);
		arrValues.add(strSubsidyAmt);
		arrValues.add(strSubsidyType);
		arrValues.add(strPurpose);
	    arrValues.add(strMeasure);
		arrValues.add(strSecured.trim());
		arrValues.add(strAmtSecure);
		arrValues.add(strRepaymentType);
	    arrValues.add(strModeofPayment);
		arrValues.add(strFacilityType);
		arrValues.add(strApplReceived);
		arrValues.add(strCoapplicants);
		arrValues.add(strGuarantors);
		arrValues.add(usrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

	}
	private StringBuffer updateLandHoldingsData(Sheet sheet,int rows,StringBuffer errorDetails,String usrID)
	{

		ResultSet rs    = null;
		int count        = 0;
		
		
	   try
	   {
			for (int j = 1; j < rows; j++)
			{
				String strId = null;
				String strVillage = null;
				String strTaluk = null;
				String strDistrict = null;
				String strSurveyno = null;
				String strLandReview = null;
				String strLandValue = null;
				String strLandArea = null;
				String strLandType = null;
				String strSecurity = null;
				String strMortgageType = null;
				String strMortgageDate = null;
				String strLandParticulars = null;
				String strFarmDistance1 = null;
				String strFarmDistance2 = null;
				String strSource = null;
				String strEncumbrance = null;
				String strEncroached = null;
				String strTreeFruit = null;
				String strNonTreeFruit = null;
				String strYear1 = null;
				String strAmount1 = null;
				String strYear2 = null;
				String strAmount2 = null;
				String strYear3 = null;
				String strAmount3 = null;
				
				String strLandAreaCents = null;
				
				
				Cell c0 = sheet.getCell(0, j);
				strId = c0.getContents();
				if(!strId.equals(""))
				{
					Cell c1 = sheet.getCell(1, j);	
					strVillage=c1.getContents();//Village
					Cell c2 = sheet.getCell(2, j);	
					strTaluk=c2.getContents();//Taluk
					Cell c3 = sheet.getCell(3, j);	
					strDistrict=c3.getContents();//Disrict
				    Cell c4 = sheet.getCell(4, j);	
					strSurveyno=c4.getContents();//Survey no
				
					if(strSurveyno.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $S.No - "+strId+" $Column - Survey No").append("@");
					
					Cell c5 = sheet.getCell(5, j);	
					strLandReview=c5.getContents();//land revenue
					Cell c6 = sheet.getCell(6, j);	
					strLandValue=c6.getContents();//land value
					
					Cell c7 = sheet.getCell(7, j);	
					strLandArea=c7.getContents();//land area
					if(strLandArea.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $S.No - "+strId+" $Column - Land Area (Acre)").append("@");
					
					Cell c8 = sheet.getCell(8, j);	
					strLandAreaCents=c8.getContents();//land area(cents)
					
					Cell c9 = sheet.getCell(9, j);	
					strLandType=c9.getContents();//Whether owned/leased
					if(!strLandType.equals(""))
					{
						strLandType= strLandType.split("-",2)[0];
						
					}
					if(strLandType.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $S.No - "+strId+" $Column - Whether Owned/Leased?").append("@");
					
					
					Cell c10 = sheet.getCell(10, j);	
					strSecurity=c10.getContents();//Security
					if(!strSecurity.equals(""))
					{
						strSecurity= strSecurity.split("-",2)[0];
						
					}
					
					Cell c11 = sheet.getCell(11, j);	
					strMortgageType=c11.getContents();//Type of mortgage
					if(!strMortgageType.equals(""))
					{
						strMortgageType = strMortgageType.split("-",2)[0];
						
					}
					
					Cell c12 = sheet.getCell(12, j);	
					if(c12.getType()== CellType.DATE)
					{
						strMortgageDate=c12.getContents();
						strMortgageDate=doChangeFormat(strMortgageDate);
					}
					Cell c13 = sheet.getCell(13, j);	
					strLandParticulars=c13.getContents();//Particulars of land
					if(!strLandParticulars.equals(""))
					{
						strLandParticulars = strLandParticulars.split("-",2)[0];
						
					}
					
					Cell c14 = sheet.getCell(14, j);	
					strFarmDistance1=c14.getContents();//Farm distance from our branch
					Cell c15 = sheet.getCell(15, j);	
					strFarmDistance2=c15.getContents();//Farm distance from our house
					Cell c16 = sheet.getCell(16, j);	
					strSource=c16.getContents();//Source of irrigation
					Cell c17 = sheet.getCell(17, j);	
					strEncumbrance=c17.getContents();//Encumbrance
					Cell c18 = sheet.getCell(18, j);	
					strEncroached=c18.getContents();//Encroached
					Cell c19 = sheet.getCell(19, j);	
					strTreeFruit=c19.getContents();//Tree fruit
					Cell c20 = sheet.getCell(20, j);	
					strNonTreeFruit=c20.getContents();//Non-Tree fruit
					Cell c21 = sheet.getCell(21, j);	
					strYear1=c21.getContents();//Year 1
					
					Cell c22 = sheet.getCell(22, j);	
					strAmount1=c22.getContents();//Amount 1
					Cell c23 = sheet.getCell(23, j);	
					strYear2=c23.getContents();//Year 2
					Cell c24 = sheet.getCell(24, j);	
					strAmount2=c24.getContents();//Amount 2
					Cell c25 = sheet.getCell(25, j);	
					strYear3=c25.getContents();//Year 3
					Cell c26 = sheet.getCell(26, j);	
					strAmount3=c26.getContents();//Amount 3
							
				if(errorDetails.toString().equals(""))
				{
							insertLandHoldings(strId,strVillage,strTaluk,strDistrict,strSurveyno,strLandReview,
							strLandValue,strLandArea,strLandAreaCents,strLandType,strSecurity,strMortgageType,strMortgageDate,
							strLandParticulars,strFarmDistance1,strFarmDistance2,strSource,strEncumbrance,
							strEncroached,strTreeFruit,strNonTreeFruit,strYear1,strAmount1,strYear2,strAmount2,
							strYear3,strAmount3,usrID);
							count = count + 1;
				}
			
		}	
	
	} 
		   
	   }
	   catch (Exception e) {
			
			throw new EJBException("Error in updateLandHoldingsData"+e.getMessage());
		
		} finally {
			try {
				if (rs != null) {
					rs.close();
			
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return errorDetails;
	}
	private void insertLandHoldings(String strId,String strVillage,String strTaluk,String strDistrict,String strSurveyno,String strLandReview,
			String strLandValue,String strLandArea,String strLandAreaCents,String strLandType,String strSecurity,String strMortgageType,String strMortgageDate,
			String strLandParticulars,String strFarmDistance1,String strFarmDistance2,String strSource,String strEncumbrance,
			String strEncroached,String strTreeFruit,String strNonTreeFruit,String strYear1,String strAmount1,String strYear2,String strAmount2,
			String strYear3,String strAmount3,String strusrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "excel_landholding_insert");
		arrValues.add(strId); 
		arrValues.add(strId); 
		arrValues.add(strVillage); 
		arrValues.add(strTaluk);
		arrValues.add(strDistrict);
		arrValues.add(strSurveyno); 
		arrValues.add(strLandReview); 
		arrValues.add(strLandValue);
	    arrValues.add(strLandArea);
	    arrValues.add(strLandAreaCents);
		arrValues.add(strLandType);
		arrValues.add(strSecurity);
		arrValues.add(strMortgageType);
	    arrValues.add(strMortgageDate);
		arrValues.add(strLandParticulars);
		arrValues.add(strFarmDistance1);
		arrValues.add(strFarmDistance2);
	    arrValues.add(strSource);
		arrValues.add(strEncumbrance);
		arrValues.add(strEncroached);
		arrValues.add(strTreeFruit);
	    arrValues.add(strNonTreeFruit);
		arrValues.add(strYear1);
		arrValues.add(strAmount1);
		arrValues.add(strYear2);
		arrValues.add(strAmount2);
		arrValues.add(strYear3);
		arrValues.add(strAmount3);
		arrValues.add(strusrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

	}
	private StringBuffer LoanDetailsDataExistCustomer(Sheet sheet,int rows,String usrID,StringBuffer errorDetails)
	{
	    boolean upload   = true;
		String strQuery  = null;
		ResultSet rs    = null;
		int count        = 0;
		
	   try
	   {
			for (int j = 1; j < rows; j++)
			{
				String strId = null;
				String strBranchcode = null;
				String strLapsOrgCode = null;
				String strProductCode = null;
				String strAmtReq = null;
				String strCostOfProject = null;
				String strMoraPeriod = null;
				String strRequestTerms = null;
				String strInterestType = null;
				String strIntTypeMode = null;
			String strInstallmentType = null;
				String strGovtScheme = null;
				String strAgency = null;
				String strSchemeType = null;
				String strSubsidyAmt = null;
				String strSubsidyType = null;
				String strPurpose = null;
				String strMeasure = null;
				String strSecured = null;
				String strAmtSecure = null;
				String strRepaymentType = null;
				String strModeofPayment = null;
				String strFacilityType = null;
				String strApplReceived = null;
				String strCoapplicants = null;
				String strGuarantors = null;
				String strCustBranchCode = null;
				
				
				Cell c0 = sheet.getCell(0, j);
				strId = c0.getContents();
				if(!strId.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("excel_customerlocation_check^"+strId);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strCustBranchCode = Helper.correctNull(rs.getString("perapp_branchcode"));
					}
					if(rs!=null)
						rs.close();
					
					Cell c1 = sheet.getCell(1, j);		
					strBranchcode=c1.getContents();//Branch CBS Code - Mandatory
				
				if(strBranchcode.equals(""))
				{
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Branch SolID").append("@");
				}
				else{
					strQuery = SQLParser.getSqlQuery("sel_shortorgcode^"+strBranchcode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLapsOrgCode = Helper.correctNull(rs.getString("org_scode"));
					}
	
					if(rs != null)
					 rs.close();
			
				}
				if(!strCustBranchCode.trim().equals(strLapsOrgCode.trim()))
					errorDetails.append("LAS ID [ "+strId+" ] is not available in the Branch").append("@");
				
				
				Cell c2 = sheet.getCell(2, j);	
				strProductCode=c2.getContents();//Product Code
				
				if(strProductCode.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - LAS Product Code").append("@");
				
				Cell c3 = sheet.getCell(3, j);	
				strAmtReq=c3.getContents();//Amount Requested
				if(strAmtReq.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Amount Requested").append("@");
								
				Cell c4 = sheet.getCell(4, j);	
				strCostOfProject=c4.getContents();//Cost of Project
				if(strCostOfProject.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Cost of the Project").append("@");
					
				Cell c5 = sheet.getCell(5, j);	
				strMoraPeriod=c5.getContents();//Intial holiday
				
				Cell c6 = sheet.getCell(6, j);	
				strRequestTerms=c6.getContents();//Repayment period
				if(strRequestTerms.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Repayment Period in months").append("@");
				
				Cell c7 = sheet.getCell(7, j);	
				strInterestType=c7.getContents();//Interest Type
				if(strInterestType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Interest Type").append("@");
				
				strIntTypeMode="1";//Default value Interest Type Mode
				
				Cell c8 = sheet.getCell(8, j);	
				strInstallmentType=c8.getContents();//Periodicity
				if(!strInstallmentType.equals(""))
				{
					strInstallmentType=strInstallmentType.split("-",2)[0];
				}
				if(strInstallmentType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Periodicity of Instalments").append("@");
				
				
				Cell c9 = sheet.getCell(9, j);	
				strGovtScheme=c9.getContents();//Govt sponser scheme
				if(!strGovtScheme.equals(""))
				{
					strGovtScheme=strGovtScheme.split("-",2)[0];
				}
				
				if(strGovtScheme.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Govt. Sponsor Scheme").append("@");
				
				Cell c10 = sheet.getCell(10, j);	
				strAgency=c10.getContents();//Sponsor Agency
				if(!strAgency.equals(""))
				{
					strAgency=strAgency.split("-",2)[0];
				}
				Cell c11 = sheet.getCell(11, j);	
				strSchemeType=c11.getContents();//Scheme Type
				if(!strSchemeType.equals(""))
				{
					strSchemeType=strSchemeType.split("-",2)[0];
				}
							
				Cell c12 = sheet.getCell(12, j);	
				strSubsidyAmt=c12.getContents();//Subsidy Amount
				
				Cell c13 = sheet.getCell(13, j);	
				strSubsidyType=c13.getContents();//Subsidy Type
				if(!strSubsidyType.equals(""))
				{
					strSubsidyType=strSubsidyType.split("-",2)[0];
				}
				
				
				Cell c14 = sheet.getCell(14, j);	
				strPurpose=c14.getContents();//Purpose  of loan
				if(strPurpose.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Purpose of Loan").append("@");
				
				Cell c15 = sheet.getCell(15, j);	
				strMeasure=c15.getContents();//Measurement Type
				if(!strMeasure.equals(""))
				{
					strMeasure=strMeasure.split("-",2)[0];
				}
								
				if(strMeasure.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Measurement Type").append("@");
				
				Cell c16 = sheet.getCell(16, j);	
				strSecured=c16.getContents();//Whether Secured
				if(!strSecured.equals(""))
				{
					strSecured=strSecured.split("-",2)[0];
				}
				
				if(strSecured.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Whether Secured").append("@");
				
				Cell c17 = sheet.getCell(17, j);	
				strAmtSecure=c17.getContents();//Amount Secured
				
				Cell c18 = sheet.getCell(18, j);	
				strRepaymentType=c18.getContents();//Repayment Type
				if(!strRepaymentType.equals(""))
				{
					strRepaymentType=strRepaymentType.split("-",2)[0];
				}
				
				if(strRepaymentType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Repayment Type").append("@");
				
				Cell c19 = sheet.getCell(19, j);	
				strModeofPayment=c19.getContents();//Mode of Payment
				if(!strModeofPayment.equals(""))
				{
					strModeofPayment=strModeofPayment.split("-",2)[0];
				}
				if(strModeofPayment.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Mode of Payment").append("@");
				
				Cell c20 = sheet.getCell(20, j);	
				strFacilityType=c20.getContents();//Facility Type
				if(!strFacilityType.equals(""))
				{
					strFacilityType=strFacilityType.split("-",2)[0];
				}
				
				if(strFacilityType.equals(""))
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Facility Type").append("@");
				
				strApplReceived = "";
				Cell c21 = sheet.getCell(21, j);	
				if(c21.getType() == CellType.DATE)
				{
					strApplReceived=c21.getContents();//Application Received date
					strApplReceived = doChangeFormat(strApplReceived);
					
				}
				
				if(strApplReceived.equals(""))
				{
					errorDetails = errorDetails.append("$Sheet - Loan Details $LAS ID - "+strId+" $Column - Application Received on").append("@");
				}
				
				
				Cell c22 = sheet.getCell(22, j);	
				strCoapplicants=c22.getContents();  //Co-applicants
				if(!strCoapplicants.trim().equals(""))
				{
					String strCoapp[]=strCoapplicants.split(",");
					for(int i=0;i< strCoapp.length;i++)
					{
						strCustBranchCode = "";
						strQuery = SQLParser.getSqlQuery("excel_customerlocation_check^"+strCoapp[i]);
						if(rs!=null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strCustBranchCode = Helper.correctNull(rs.getString("perapp_branchcode"));
						}
						if(rs!=null)
							rs.close();
						if(!strCustBranchCode.trim().equals(strLapsOrgCode.trim()))
							errorDetails.append("$Sheet - Loan Details $LAS ID "+strId+" $Column - Add Co-Applicants LAS ID  [ "+strCoapp[i]+" ] is not available in the Branch").append("@");
					}
				}
				
				Cell c23 = sheet.getCell(23, j);	
				strGuarantors=c23.getContents();  //Guarantors
				if(!strGuarantors.trim().equals(""))
				{
					String strGua[] = strGuarantors.split(",");
					for(int i=0;i<strGua.length;i++)
					{
						strCustBranchCode = "";
						strQuery = SQLParser.getSqlQuery("excel_customerlocation_check^"+strGua[i]);
						if(rs!=null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strCustBranchCode = Helper.correctNull(rs.getString("perapp_branchcode"));
						}
						if(rs!=null)
							rs.close();
						if(!strCustBranchCode.trim().equals(strLapsOrgCode.trim()))
							errorDetails.append("$Sheet - Loan Details $LAS ID "+strId+" $Column - Add Guarantors LAS ID  [ "+strGua[i]+" ] is not available in the Branch").append("@");
						
					}
				}
				
				
				if(errorDetails.toString().equals(""))
				{
					insertApplicationsExistCustomer(strId,strBranchcode,strLapsOrgCode,strProductCode,strAmtReq,
									strCostOfProject,strMoraPeriod,strRequestTerms,strInterestType,strIntTypeMode,strInstallmentType,strGovtScheme,
									strAgency,strSchemeType,strSubsidyAmt,strSubsidyType,strPurpose,strMeasure,
									strSecured,strAmtSecure,strRepaymentType,strModeofPayment,strFacilityType,strApplReceived,strCoapplicants,strGuarantors,usrID);
						count = count + 1;
				}
			
		}	
	
	} 
		   
	   }
	   catch (Exception e) {
			
			throw new EJBException("Error in LoanDetailsDataExistCustomer"+e.getMessage());
		
		} finally {
			try {
				if (rs != null) {
					rs.close();
			
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return errorDetails;
	}
	private StringBuffer updateLandHoldingsDataExistCustomer(Sheet sheet,int rows,StringBuffer errorDetails,String usrID)
	{

		ResultSet rs    = null;
		int count        = 0;
		
		
	   try
	   {
			for (int j = 1; j < rows; j++)
			{
				String strId = null;
				String strVillage = null;
				String strTaluk = null;
				String strDistrict = null;
				String strSurveyno = null;
				String strLandReview = null;
				String strLandValue = null;
				String strLandArea = null;
				String strLandType = null;
				String strSecurity = null;
				String strMortgageType = null;
				String strMortgageDate = null;
				String strLandParticulars = null;
				String strFarmDistance1 = null;
				String strFarmDistance2 = null;
				String strSource = null;
				String strEncumbrance = null;
				String strEncroached = null;
				String strTreeFruit = null;
				String strNonTreeFruit = null;
				String strYear1 = null;
				String strAmount1 = null;
				String strYear2 = null;
				String strAmount2 = null;
				String strYear3 = null;
				String strAmount3 = null;
				
				String strLandAreaCents = null;
				
				
				Cell c0 = sheet.getCell(0, j);
				strId = c0.getContents();
				if(!strId.equals(""))
				{
					Cell c1 = sheet.getCell(1, j);	
					strVillage=c1.getContents();//Village
					Cell c2 = sheet.getCell(2, j);	
					strTaluk=c2.getContents();//Taluk
					Cell c3 = sheet.getCell(3, j);	
					strDistrict=c3.getContents();//Disrict
				    Cell c4 = sheet.getCell(4, j);	
					strSurveyno=c4.getContents();//Survey no
				
					if(strSurveyno.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $LAS ID - "+strId+" $Column - Survey No").append("@");
					
					Cell c5 = sheet.getCell(5, j);	
					strLandReview=c5.getContents();//land revenue
					Cell c6 = sheet.getCell(6, j);	
					strLandValue=c6.getContents();//land value
					
					Cell c7 = sheet.getCell(7, j);	
					strLandArea=c7.getContents();//land area
					if(strLandArea.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $LAS ID - "+strId+" $Column - Land Area (Acre)").append("@");
					
					Cell c8 = sheet.getCell(8, j);	
					strLandAreaCents=c8.getContents();//land area(cents)
					
					Cell c9 = sheet.getCell(9, j);	
					strLandType=c9.getContents();//Whether owned/leased
					if(!strLandType.equals(""))
					{
						strLandType= strLandType.split("-",2)[0];
						
					}
					if(strLandType.equals(""))
						errorDetails = errorDetails.append("$Sheet - Land Holdings $LAS ID - "+strId+" $Column - Whether Owned/Leased?").append("@");
					
					
					Cell c10 = sheet.getCell(10, j);	
					strSecurity=c10.getContents();//Security
					if(!strSecurity.equals(""))
					{
						strSecurity= strSecurity.split("-",2)[0];
						
					}
					
					Cell c11 = sheet.getCell(11, j);	
					strMortgageType=c11.getContents();//Type of mortgage
					if(!strMortgageType.equals(""))
					{
						strMortgageType = strMortgageType.split("-",2)[0];
						
					}
					
					Cell c12 = sheet.getCell(12, j);	
					if(c12.getType()== CellType.DATE)
					{
						strMortgageDate=c12.getContents();
						strMortgageDate=doChangeFormat(strMortgageDate);
					}
					Cell c13 = sheet.getCell(13, j);	
					strLandParticulars=c13.getContents();//Particulars of land
					if(!strLandParticulars.equals(""))
					{
						strLandParticulars = strLandParticulars.split("-",2)[0];
						
					}
					
					Cell c14 = sheet.getCell(14, j);	
					strFarmDistance1=c14.getContents();//Farm distance from our branch
					Cell c15 = sheet.getCell(15, j);	
					strFarmDistance2=c15.getContents();//Farm distance from our house
					Cell c16 = sheet.getCell(16, j);	
					strSource=c16.getContents();//Source of irrigation
					Cell c17 = sheet.getCell(17, j);	
					strEncumbrance=c17.getContents();//Encumbrance
					Cell c18 = sheet.getCell(18, j);	
					strEncroached=c18.getContents();//Encroached
					Cell c19 = sheet.getCell(19, j);	
					strTreeFruit=c19.getContents();//Tree fruit
					Cell c20 = sheet.getCell(20, j);	
					strNonTreeFruit=c20.getContents();//Non-Tree fruit
					Cell c21 = sheet.getCell(21, j);	
					strYear1=c21.getContents();//Year 1
					
					Cell c22 = sheet.getCell(22, j);	
					strAmount1=c22.getContents();//Amount 1
					Cell c23 = sheet.getCell(23, j);	
					strYear2=c23.getContents();//Year 2
					Cell c24 = sheet.getCell(24, j);	
					strAmount2=c24.getContents();//Amount 2
					Cell c25 = sheet.getCell(25, j);	
					strYear3=c25.getContents();//Year 3
					Cell c26 = sheet.getCell(26, j);	
					strAmount3=c26.getContents();//Amount 3
							
				if(errorDetails.toString().equals(""))
				{
					insertLandHoldingsExistCustomer(strId,strVillage,strTaluk,strDistrict,strSurveyno,strLandReview,
							strLandValue,strLandArea,strLandAreaCents,strLandType,strSecurity,strMortgageType,strMortgageDate,
							strLandParticulars,strFarmDistance1,strFarmDistance2,strSource,strEncumbrance,
							strEncroached,strTreeFruit,strNonTreeFruit,strYear1,strAmount1,strYear2,strAmount2,
							strYear3,strAmount3,usrID);
							count = count + 1;
				}
			
		}	
	
	} 
		   
	   }
	   catch (Exception e) {
			
			throw new EJBException("Error in updateLandHoldingsDataExistCustomer"+e.getMessage());
		
		} finally {
			try {
				if (rs != null) {
					rs.close();
			
					System.gc();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return errorDetails;
	}
	private void insertApplicationsExistCustomer(String strId,String strBranchcode,String strLapsOrgCode,String strProductCode,String strAmtReq,
			String strCostOfProject,String strMoraPeriod,String strRequestTerms,String strInterestType,String strIntTypeMode,String strInstallmentType,String strGovtScheme,
			String strAgency,String strSchemeType,String strSubsidyAmt,String strSubsidyType,String strPurpose,String strMeasure,
			String strSecured,String strAmtSecure,String strRepaymentType,String strModeofPayment,String strFacilityType,String strApplReceived,String strCoapplicants,String strGuarantors,String usrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "excel_loandetails_exist_insert");
		arrValues.add(strId); 
		arrValues.add(strBranchcode); 
		arrValues.add(strLapsOrgCode);
		arrValues.add(strProductCode);
		arrValues.add(strAmtReq); 
		arrValues.add(strCostOfProject); 
		arrValues.add(strMoraPeriod); 
		arrValues.add(strRequestTerms);
		arrValues.add(strInterestType); 
		arrValues.add(strIntTypeMode); 
		arrValues.add(strInstallmentType); 
		arrValues.add(strGovtScheme);
		arrValues.add(strAgency);
	    arrValues.add(strSchemeType);
		arrValues.add(strSubsidyAmt);
		arrValues.add(strSubsidyType);
		arrValues.add(strPurpose);
	    arrValues.add(strMeasure);
		arrValues.add(strSecured.trim());
		arrValues.add(strAmtSecure);
		arrValues.add(strRepaymentType);
	    arrValues.add(strModeofPayment);
		arrValues.add(strFacilityType);
		arrValues.add(strApplReceived);
		arrValues.add(strCoapplicants);
		arrValues.add(strGuarantors);
		arrValues.add(usrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

	}
	private void insertLandHoldingsExistCustomer(String strId,String strVillage,String strTaluk,String strDistrict,String strSurveyno,String strLandReview,
			String strLandValue,String strLandArea,String strLandAreaCents,String strLandType,String strSecurity,String strMortgageType,String strMortgageDate,
			String strLandParticulars,String strFarmDistance1,String strFarmDistance2,String strSource,String strEncumbrance,
			String strEncroached,String strTreeFruit,String strNonTreeFruit,String strYear1,String strAmount1,String strYear2,String strAmount2,
			String strYear3,String strAmount3,String strusrID)

	throws Exception {
		HashMap hshQuery = null, hshQueryValues = new HashMap();
		ArrayList arrValues = null;
		hshQuery = new HashMap();
		arrValues = new ArrayList();
		hshQuery.put("strQueryId", "excel_landholding_exist_insert");
		arrValues.add(strId); 
		arrValues.add(strId); 
		arrValues.add(strVillage); 
		arrValues.add(strTaluk);
		arrValues.add(strDistrict);
		arrValues.add(strSurveyno); 
		arrValues.add(strLandReview); 
		arrValues.add(strLandValue);
	    arrValues.add(strLandArea);
	    arrValues.add(strLandAreaCents);
		arrValues.add(strLandType);
		arrValues.add(strSecurity);
		arrValues.add(strMortgageType);
	    arrValues.add(strMortgageDate);
		arrValues.add(strLandParticulars);
		arrValues.add(strFarmDistance1);
		arrValues.add(strFarmDistance2);
	    arrValues.add(strSource);
		arrValues.add(strEncumbrance);
		arrValues.add(strEncroached);
		arrValues.add(strTreeFruit);
	    arrValues.add(strNonTreeFruit);
		arrValues.add(strYear1);
		arrValues.add(strAmount1);
		arrValues.add(strYear2);
		arrValues.add(strAmount2);
		arrValues.add(strYear3);
		arrValues.add(strAmount3);
		arrValues.add(strusrID);
		
		hshQueryValues.put("size", "1");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

	}
	public HashMap exceltoLapsExistCustomer(HashMap hshValues) 
	{
		HashMap hshReturn = new HashMap();
		ResultSet rs = null;
		CallableStatement callstmt = null;
		Connection conn = null;
		String strErrorCode = null;
		String strQuery = null;
		int count = 0;
		String usrID = null;
		
		try
		{
			usrID=correctNull((String)hshValues.get("strUserId"));
			strQuery=SQLParser.getSqlQuery("excel_loandetails_exist_count");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				count = rs.getInt(1);
			}
			if(rs!=null)
				rs.close();
			
			if(count > 0)
			{
    		    conn=getConnection();
     			callstmt=conn.prepareCall("{?=call EXCELAPPLICATIONS_EXIST(?)}");
				callstmt.registerOutParameter(1,Types.VARCHAR);
				callstmt.setString(2,usrID.trim());
				callstmt.execute();
				strErrorCode =callstmt.getString(1);
				if(!strErrorCode.equals("0"))
				  hshReturn.put("status",strErrorCode);
				else
				{
					hshReturn.put("status","Successfully uploaded to LAS");
				}
			}
			else
			{
				hshReturn.put("status","No Data Found");	
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error exceltoLaps in exceltoLapsExistCustomer.." + e.getMessage());
		}
		finally {
			try {
				if (conn != null)
					conn.close();
				
				if(callstmt != null)
					callstmt.close();
				
				if(rs!=null)
					rs.close();
				
			} catch (Exception e1) {
				throw new EJBException("Error closing connection exceltoLapsExistCustomer.." + e1);
			}
		}
		return hshReturn;
	}
}
