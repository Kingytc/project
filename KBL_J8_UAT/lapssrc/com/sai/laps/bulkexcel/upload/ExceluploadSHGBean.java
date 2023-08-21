package com.sai.laps.bulkexcel.upload;

import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.ejb.adhoc.adhocRemote;
import com.sai.laps.ejb.bankappfi.BankAppFIBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.ejb.mis.MisBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.AES_Encryption;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jfree.util.Log;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "ExceluploadSHGBean", mappedName = "ExceluploadSHGHome")
@Remote (ExceluploadSHGRemote.class)
public class ExceluploadSHGBean extends BeanAdapter {
	
	static Logger log=Logger.getLogger(ExceluploadSHGBean.class);	

	private static final long serialVersionUID = 1L;
	static String errorStatus = "";
	static Workbook wb = null;
	static int sheetNo = 0;
	static String status = "";

public  HashMap doUploadBulkData(HashMap hshValues)throws EJBException, IOException
{

	ResultSet rs1=null;
	ResultSet rs=null;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	
	ArrayList AppNo = new ArrayList();
	ArrayList InwardNo = new ArrayList();
	ArrayList arrRepaySchedule = new ArrayList();
	HashMap inwardData = new HashMap();
	HashMap custData = new HashMap();
	HashMap appData = new HashMap();
	HashMap hshformula= new HashMap();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String key="";//ApplicationParams.getStraadharkey();
	String initVector="";//ApplicationParams.getStraadharvector();
	boolean Successflag =false;
	byte[] byteData=(byte[])hshValues.get("byteimg");
	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
	String strOrgscode = Helper.correctNull((String)hshValues.get("strOrgscode"));
	String strUsrid = Helper.correctNull((String)hshValues.get("StrUsrid"));
	String strSolid = Helper.correctNull((String)hshValues.get("strSolid"));
	String strOrgCode = Helper.correctNull((String)hshValues.get("strOrgCode"));
	String FileName = Helper.correctNull((String)hshValues.get("filename"));	
	String strOrgLevel="";
	String strExtension = FileName.substring(FileName.lastIndexOf(".") + 1, FileName.length());
	String strQuery="",strLAPSid="",strperappOldID="",strLimitId="",strAppno="",strFACILITY_SANCAMT="",strCBS_ACCOUNTNO="",mclrtabcode="";
	String strLapscustid="",custid="",inwarddistrict="";
	String strInwardno="";
	String strid="";
	String  proposedAmt="",strPrdCode="",sanamount="";
	boolean demoflag=false;
	boolean shgmemflag=false;
	boolean facilitiesflag=false;
	boolean securitiesflag=false;
	boolean coappguaflag=false;
	String strUserId=strUsrid;
	String Cumulativecharges="";
	 HSSFWorkbook workbook = new HSSFWorkbook();
		FileOutputStream fileOut=null;
		HSSFSheet spreadsheet = workbook.createSheet("Response");
		
	try
	{
		File file = new File(Helper.correctNull((String)hshValues.get("filename")));
        if (file.isFile()) 
        {
		String strFilePath=file.getAbsolutePath();
    	String strDirectory=file.getParent();
    	String strfileName=file.getName();
    	log.info("Changed file Path::"+strFilePath);
    	log.info("Changed Directory for the file::"+strDirectory);
    	log.info("Changed File Name ::"+strfileName);
        }
		int membersdet=0;
		ArrayList arrValues=new ArrayList();
		HashMap hshVal = new HashMap();
		int querycount=0;
		wb = new XSSFWorkbook(inputStream);
		
		Row start= wb.getSheetAt(sheetNo).getRow(2);
		
		int PhysicalNumberOfRows=0;
		Sheet sheetNo1 = wb.getSheetAt(1);
		Iterator<Row> rowIteratornew = ((XSSFSheet) sheetNo1).iterator();  
		
		
		
		strQuery = SQLParser.getSqlQuery("sel_orglevelshgdetails^"+strSolid);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgLevel = Helper.correctNull((String)rs.getString("org_level"));;				
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		if (rowIteratornew.next()!=null)
		{		
			 PhysicalNumberOfRows = sheetNo1.getPhysicalNumberOfRows();
			 System.out.println("inside index 2==================="+PhysicalNumberOfRows);	
		}
		
		for (int a=2;a<=wb.getSheetAt(0).getPhysicalNumberOfRows()-1; a++)
		{
		Iterator<Cell> sheetIterator = ((Iterable<Cell>) wb).iterator();
		while (sheetIterator.hasNext()) 
		{
			
						
			Sheet sheet = (Sheet) sheetIterator.next();							// Iterate through each sheets
			if (sheet.getSheetName().equalsIgnoreCase("Demographics")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("Demographics");
				//Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
				
				
				//while (rowIterator.hasNext())
				//{
				try
				{
				int intUpdatesize=0;
					System.out.println("inside demographics");
					//Row row =a;//rowIterator.next();
					 final Row row = sheet.getRow(a);
					//System.out.println(row.getRowNum());
					//if( row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK || row.getCell(0).getStringCellValue()!=null || row.getCell(0).getStringCellValue()!="")//isStringCell(row.getCell(0)) != null || row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK)
					if(!( row == null || isEmptyRow(row)))// if(!(row.getCell(0)==null))
					 {
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
							
							
							
							
							String currdate=Helper.getCurrentDateTime();
							//dedupe
							String strDedupeFlag="N";
							String lapsoldID="",lapsID="";
							String stridDoc="",strIdNumber="";
							Cumulativecharges="";
							custid=String.valueOf(row.getCell(0));
							HashMap hshValreq = new HashMap();
							hshValreq.put("custid",custid);
							//hshValreq.put("distcode",String.valueOf(row.getCell(3)));
							
							hshValreq.put("distcode",isCorrectNumericCell(row.getCell(3))); //madhu
							
							inwarddistrict="";
							inwarddistrict=isCorrectNumericCell(row.getCell(3));
							//perapp_stakeheld_women  10,12,13
							
							hshValreq.put("leadNo",String.valueOf(row.getCell(10)));//isCorrectNumericCell(row.getCell(3)));
							hshValreq.put("perapp_stakeheld_women",String.valueOf(row.getCell(12)));
							hshValreq.put("Networth",isCorrectNumericCell(row.getCell(13)));
							
							hshValreq.put("minority",String.valueOf(row.getCell(4)));
							hshValreq.put("community",String.valueOf(row.getCell(5)));
							
							
							Cumulativecharges=isCorrectNumericCell(row.getCell(14));
							hshValreq.put("Religion",String.valueOf(row.getCell(15)));
							
							
							hshVal=updateLapsDatabase(hshValreq,"Insert");
							
							strLapscustid=correctNull((String)hshVal.get("strLapscustid"));
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","del_agrappshg");
							arrValues.add(strLapscustid);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","ins_agrappshgshg");
							arrValues.add(strLapscustid);//1
							arrValues.add(String.valueOf(row.getCell(6)));//2
							arrValues.add(isCorrectNumericCell(row.getCell(7)));//7
							
							 membersdet = Integer.valueOf(isCorrectNumericCell(row.getCell(7)));
							arrValues.add(String.valueOf(row.getCell(8)));//8
							arrValues.add(String.valueOf(row.getCell(9)));//9
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
							//if(!strDedupeFlag.equals("Y"))
							
							//////////////////////customer creation ends///////////////////////
							
							//////lar creation starts ////////////////
							
							String strUserhId="";
							strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strUserhId = Helper.correctNull((String)rs.getString("USR_ID"));;				
							}
							if(rs!=null)
							{
								rs.close();
							}
							
							//strSystemUserId
							
							String txt_name="";
							strQuery=SQLParser.getSqlQuery("selshguserdetails^"+strUsrid);//strUserId);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								txt_name = correctNull(rs.getString(1));
								//USER_DESIGNATION=correctNull(rs.getString(2));
							}
							
							if(rs!=null)
							{
								rs.close();
							}
							//system user
							String strSystemUserId=strUsrid;//"K10197";
							String strleadgenId=correctNull((String)hshValues.get("strleadGeneratedAgentId"));
							String strbsadsaname="",strorgscode="",strCanvassedby="",bsaordsa="";
							String strleadConvertedBy=correctNull((String)hshValues.get("strleadConvertedBy"));
							/*String banbkscheme=Helper.correctNull((String)hshValues.get("sel_bankscheme"));
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
							*/
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
									strorgscode = Helper.correctNull((String)rs.getString("org_scode"));				
								}
								strCanvassedby="N";
							}
							else if( strleadgenId.equals("") && !strleadConvertedBy.equals(""))
							{
								strCanvassedby="Y";
							}
							else if(strleadgenId.equals("") && (strleadConvertedBy.equals("")) )
							{
								strCanvassedby="NP";
							}


							
							
							
								InwardRegisterBean inwardreg=new InwardRegisterBean();
								 strInwardno=inwardreg.getMaxInwardno(strSolid);
								
								
						
								
								
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								hshQuery.put("strQueryId","ins_msmelarappinwardSHG");
								arrValues.add(strInwardno);//1 inward_no
								arrValues.add("a");//2 inward_sector
								
								//arrValues.add(correctNull((String)hshValues.get("txt_appdate")));//4 inward_appliedon
								arrValues.add(correctNull((String)hshVal.get("strFname")).toUpperCase());//5 inward_custname
								arrValues.add("E");//E");//selcusttype")));//6 inward_borrowertype --> new/old
								arrValues.add(correctNull((String)custid));//hshValues.get("txt_cbscustid")));//7 inward_cbscustid 
								
								arrValues.add(correctNull((String)hshVal.get("txt_comcustadd1")));//8 inward_add1
								arrValues.add(correctNull((String)hshVal.get("txt_comcustadd2")));//9 inward_add2
								arrValues.add(correctNull((String)hshVal.get("hidcity")));// 10 inward_city
								arrValues.add(correctNull((String)hshVal.get("hid_state")));//11 inward_states
								arrValues.add(correctNull((String)hshVal.get("txtcomcust_zip")));//12 inward_zipcode
								arrValues.add(correctNull((String)hshVal.get("txtcomcust_phone")));//13 inward_phone
								arrValues.add(correctNull((String)hshVal.get("txtcomcust_mobile")));//15 inward_mobile
								arrValues.add(correctNull((String)hshVal.get("txtcomcust_email")));//16 inward_email
								arrValues.add(correctNull((String)hshVal.get("strdob")));//17 inward_dob
								arrValues.add(correctNull((String)hshVal.get("txtcomcust_pan")).toUpperCase());//18 inward_pantan
								arrValues.add("Internal Lending".toLowerCase());//19 inward_purpose 
								//arrValues.add(correctNull((String)hshValues.get("txtret_ftf")));//21 inward_termloanamt
								//arrValues.add(correctNull((String)hshValues.get("txt_receidate")));//25 inward_docreceivedon
								arrValues.add("Y");//correctNull((String)hshValues.get("seldocrecd")));//26 inward_docreceived
								arrValues.add("1");//correctNull((String)hshValues.get("strapplProcessLoc")));//27 inward_applnprocessat --> 1�Branch/6�RLPC 

								arrValues.add(strSolid);//28 inward_orgscode
								arrValues.add(strSystemUserId);//29 inward_usrid
								arrValues.add("A");//30 inward_valuesin
								arrValues.add(strSystemUserId);//31 inward_modifiedby
								//arrValues.add("13/08/2019");
								arrValues.add("N");//33 inward_appliedfor
								arrValues.add("C");//34 inward_proptype
								arrValues.add("");//correctNull((String)hshValues.get("hid_dist")));//39 District

								arrValues.add("1");//correctNull((String)hshValues.get("selapplstatus")));
								arrValues.add(correctNull((String)hshValues.get("txt_rejreason")));
								//arrValues.add("t");// Term loan
							//	arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));//
								arrValues.add("2");//"no"//"2"); //Govt sponser scheme -> default no
								arrValues.add("N");//not appllicable");//strCanvassedby); //Canvasasedby -not appllicable
								arrValues.add("N");//correctNull((String)hshValues.get("selborrowerstatus")));
								arrValues.add(isCorrectNumericCell(row.getCell(10)));//rowcell("10"));//correctNull((String)hshValues.get("txt_leadno")).toUpperCase());
								arrValues.add("N");//"Y");
								//arrValues.add(correctNull((String)hshValues.get("strAddchangeFlag")));
								//arrValues.add(correctNull((String)hshValues.get("strschemeDesc")));

								arrValues.add(correctNull((String)hshValues.get("strdigiAppNo")));
								arrValues.add("BSA");//bsaordsa);
								arrValues.add(strorgscode);
								arrValues.add(strleadgenId);
								arrValues.add(txt_name);////correctNull((String)hshValues.get("strleadConvertedBy")));
								arrValues.add(strSystemUserId);////correctNull((String)hshValues.get("strleadStaffId")));
								
								arrValues.add(correctNull((String)hshValues.get("workingCapital")));
								arrValues.add(correctNull((String)hshValues.get("whetherTinyInd")));
								arrValues.add(correctNull((String)hshValues.get("whetherSSI")));
								arrValues.add(correctNull((String)hshValues.get("termLoan")));
								arrValues.add(correctNull((String)hshValues.get("nonFundBased")));
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("0");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								hshValues.put("strInwardno", strInwardno);
								hshValues.put("strResponseCode", "LAPS-3006");
								hshValues.put("strResponseMsg", "LAR Created Successfully");
								
								
								////////////////////////////lar creation ends///////
								
								/////////proposal creation starts/////////////////////////
								
								
								
								
								String strBorrowId=strLapscustid;
								String strCustomerID=custid;
								strSolid=strSolid;
								
								Date date1;
								Date date2;
								String strDate = ApplicationParams.getStrCLPCdate();
								SimpleDateFormat CLPCdate = new SimpleDateFormat("yyyy-MM-dd");//"yyyy-MM-dd"
								date1 = CLPCdate.parse(strDate);
								String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
								date2 = CLPCdate.parse(NOwCalender);
								String strsolidMang = strSolid,strsolidOf850="";
								
								if (date1.before(date2))
								{
									strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strSolid);
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
								
								//strlapsCustomerId
								strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCustomerID);	
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strLAPSid = Helper.correctNull((String)rs.getString("perapp_id"));	
									strperappOldID = Helper.correctNull((String)rs.getString("PERAPP_OLDID"));
								}
								
								if(strLAPSid.equals(""))
								{
									strLAPSid=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
									strperappOldID=Helper.correctNull((String)hshValues.get("strlapsCustomerId"));
								}
								
								
								// appno generation
								String strType="A";//mck
								hshformula.put("comapp_id",strBorrowId);//mck
								hshformula.put("apptype",strType);//mck
								hshformula.put("strSolid",strSolid);//mck
								strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
								hshValues.put("appno",strAppno);	
								
								
								//getting prdcode by 42
								strLimitId="186";//Helper.correctNull((String)hshValues.get("FacilityDescription"));
								
								
//								if(rs!=null)rs.close();
//								strQuery = SQLParser.getSqlQuery("sel_corpdigiprd^"+strLimitId);
//								rs = DBUtils.executeQuery(strQuery);
//								if(rs.next())
//								{
//									strLimitId=Helper.correctNull((String)rs.getString("COM_FACID"));
//								}
								
								
								//system user
								String strSysteUserId=strUsrid;//"K10197";
								String strOrgLevelC="",strOrgScode="",strorg_branchinC="",strissaral="",strFinancialReq="",strUserDepartment="",strRLPFUser="",stramberExits="",
								strUserIdClpu="",strOrgLevelClpu="",strscheme="",STRCLPHAV="",strOrghScode="",strOrgCodeC="",strUsercId="";
									strPrdCode=strPrdCode;// Helper.correctNull((String)hshValues.get("strLoanProduct"));
								String	strlarNo=strInwardno;// Helper.correctNull((String)hshValues.get("strlarNo"));
								stramberExits= Helper.correctNull((String)hshValues.get("stramberExits"));
								strscheme= Helper.correctNull((String)hshValues.get("strscheme"));//aS  //by AK
								
								strQuery = SQLParser.getSqlQuery("sel_orghead_clpulevel^"+strSolid);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strUsercId = Helper.correctNull((String)rs.getString("USR_ID"));
									strOrgLevelC = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
									strOrgCodeC = Helper.correctNull((String)rs.getString("ORG_CODE"));
									strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	
									strorg_branchinC = Helper.correctNull((String)rs.getString("org_branchin"));
									strUserDepartment = Helper.correctNull((String)rs.getString("USR_DEPARTMENT"));
									strRLPFUser = Helper.correctNull((String)rs.getString("USR_RLPFTYPE"));
									
								}
								
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
									strOrgLevelClpu = Helper.correctNull((String)rs.getString("ORG_LEVEL"));
									strUserIdClpu = Helper.correctNull((String)rs.getString("USR_ID"));
								}
								}else{
								
								strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strUserIdClpu = Helper.correctNull((String)rs.getString("USR_ID"));
									strOrghScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));	

								}
								}
								
								strLimitId=isCorrectNumericCell(row.getCell(3));
								if(rs!=null)
								{
									rs.close();
								}
								//application table
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","insapplications_digiSHG");
								arrValues.add(strAppno);
								arrValues.add(strLimitId);
								arrValues.add(strSysteUserId);
								arrValues.add(strOrgCode);
								arrValues.add("A");
								arrValues.add(strInwardno);//strlarNo);
								arrValues.add("R");
								//arrValues.add((strOrgLevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrgLevel);
								arrValues.add(strOrgLevel);//strOrgLevel);
								arrValues.add(strSysteUserId);//strUserIdClpu);
								arrValues.add("Y");
								arrValues.add(null);
								arrValues.add(null);
								arrValues.add(null);
								arrValues.add(strFinancialReq);
								arrValues.add("");
								arrValues.add(stramberExits);
								arrValues.add("");//correctNull((String) hshValues.get("strbussinessId")));
								arrValues.add("");

								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								
								/*hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","updatefacilityrenewflag");
								arrValues.add("F");
								arrValues.add(correctNull(strAppno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
								
								String strFinStd="0",strIndType="",strIndRating="";

							/*	if(rs!=null)rs.close();
								rs=DBUtils.executeLAPSQuery("selcmabycomappid^"+strBorrowId);
								if(rs.next())
								{
									strFinStd =rs.getString("cma_no");
								}*/
								
								strFinStd=Helper.correctNull((String)hshValues.get("strfinId"));
								
								// Starts updation for com_demographics table
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","commapplicantloanins2");
								arrValues.add(strAppno);


								if(strBorrowId.trim().equals(""))
								{
									strBorrowId="0";
								}
								arrValues.add(strperappOldID);
								arrValues.add(strFinStd);
								arrValues.add(strIndType);
								arrValues.add(strIndRating);
								arrValues.add("N");
								arrValues.add(strLAPSid);//for inserting customer new renewal id added by tharani for solving modify probelm
								hshQuery.put("arrValues",arrValues);
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
									arrValues.add(strAppno);
									arrValues.add(strSysteUserId);
									arrValues.add(strSysteUserId);
									arrValues.add("1");
									arrValues.add("1");
									arrValues.add(strDay);
									arrValues.add("C");
									arrValues.add(strSolid);//"001");
									arrValues.add("");
									arrValues.add(strSolid);//"001");
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
									arrValues.add(strAppno);
									arrValues.add(strSysteUserId);
									arrValues.add(strSysteUserId);////strUserIdClpu);
									arrValues.add("1");
									arrValues.add("2");
									arrValues.add(strDay);
									arrValues.add("C");
									arrValues.add(strSolid);//"001");
									arrValues.add("");
									arrValues.add(strSolid);////strOrgScode);
									arrValues.add("");
									hshQuery.put("arrValues",arrValues);
									//hshQueryValues.put(""+intUpdatesize, hshQuery);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
									//For Updating in inward register

									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize = intUpdatesize+1;
									hshQuery.put("strQueryId","updinwardappatached");
									arrValues.add("Y");
									arrValues.add("op");
									arrValues.add(strInwardno);//strlarNo);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
									//hshQueryValues.put(""+intUpdatesize, hshQuery);
									String strLoanAmt=Helper.correctNull((String)hshValues.get("strproopsedLimit"));
									
									
									
									//strMetLifeInsurance	
								
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","insprosalvaluesin");
									arrValues.add(correctNull(strAppno));
									arrValues.add("R");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									//hshQueryValues.put(""+intUpdatesize, hshQuery);
									
									//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); added
									
									
									//basic info tab
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","ins_basicinfo_digicorpSHG");
									arrValues.add(correctNull(strAppno));
									arrValues.add("4");//com_format  Helper.correctNull((String)hshValues.get("proposalFormat")));
									arrValues.add("25");//01");//COM_SANCAUTHORITY
									arrValues.add("006");//COM_SANCDEPT
									arrValues.add("02");//02");//COM_SACTIONLEVEL
									arrValues.add("Priority");//Helper.correctNull((String)hshValues.get("prioritysector")));
									arrValues.add("R");//COM_AMOUNTVALUE
									arrValues.add("NA");//Helper.correctNull((String)hshValues.get("cfrVerified")));
									arrValues.add("");//COM_CFR_BORNAME
									arrValues.add("NA");//COM_CERSAI_VERIFIEDHelper.correctNull((String)hshValues.get("cersaiChecked")));
									arrValues.add("0");//Helper.correctNull((String)hshValues.get("processingCharges")));
									arrValues.add("005");
									hshQuery.put("arrValues",arrValues);
								
									/*hshQueryValues.put("size","1");
									hshQueryValues.put("1",hshQuery);
									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									
									
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","upd_basicinfo_digicorpshg");
									arrValues.add(correctNull(strAppno));									
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									
									
									java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(2);
									jtn.setMinimumFractionDigits(2);
									jtn.setGroupingUsed(false);
									
									Cumulativecharges=jtn.format(Double.parseDouble(Helper.correctDouble((String)Cumulativecharges)));
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","selshgagrfinancceposition_ins");
									arrValues.add(correctNull(strAppno));
									arrValues.add(Cumulativecharges);
									arrValues.add(Cumulativecharges);//Helper.correctNull((String)hshValues.get("processingCharges")));
									hshQuery.put("arrValues",arrValues);
									
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									
									//hshQueryValues.put(""+intUpdatesize, hshQuery);
									
									//coapplicant/guarantor tab
							/*		ArrayList arrcoapp=new ArrayList();
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
											
											String strfname="",strlname="",strgender="";
											String CON_COMADDR1="",CON_COMADDR2="",CON_COMCITY="",CON_COMSTATE="",CON_COMZIP="",CON_COMPHONE="",CON_MOBILE="",CON_EMAIL="";
											strQuery=SQLParser.getSqlQuery("sel_cbsIdCreation^"+perapppid);
											rs=DBUtils.executeQuery(strQuery);	
											if(rs.next())
											{
												strgender=Helper.correctNull((String)rs.getString("PERAPP_SEX"));
												strfname=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
												strlname=Helper.correctNull((String)rs.getString("PERAPP_LNAME"));
												CON_COMADDR1=Helper.correctNull((String)rs.getString("CON_COMADDR1"));
												CON_COMADDR2=Helper.correctNull((String)rs.getString("CON_COMADDR2"));
												CON_COMCITY=Helper.correctNull((String)rs.getString("CON_COMCITY"));
												CON_COMSTATE=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
												CON_COMZIP=Helper.correctNull((String)rs.getString("CON_COMZIP"));
												CON_COMPHONE=Helper.correctNull((String)rs.getString("CON_COMPHONE"));
												CON_MOBILE=Helper.correctNull((String)rs.getString("CON_MOBILE"));
												CON_EMAIL=Helper.correctNull((String)rs.getString("CON_EMAIL"));
											}
											
											//Finacle relation type
											/*String strfinacletype="";
											if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("c"))
											{
												strfinacletype="J";
											}
											else
											{
												strfinacletype=Helper.correctNull((String)arrcoappval.get(1));
											}*/
											
											//hshQueryValues = new HashMap();
						/*					hshQuery = new HashMap();
											intUpdatesize++;//added
											hshQuery.put("strQueryId", "ins_coapp_digi");
											arrValues = new ArrayList();
											arrValues.add(strAppno);
											arrValues.add(perapppid);
											arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));//type
											arrValues.add(strfname);
											arrValues.add(strlname);
											arrValues.add(CON_COMADDR1);
											arrValues.add(CON_COMADDR2);
											arrValues.add(CON_COMCITY);
											arrValues.add(CON_COMSTATE);
											arrValues.add(CON_COMZIP);
											arrValues.add(CON_MOBILE);
											arrValues.add(CON_COMPHONE);
											arrValues.add(CON_EMAIL);
											arrValues.add(strgender);
											arrValues.add(perapppid);
											arrValues.add(strOldid);
											arrValues.add(Helper.correctNull((String)arrcoappval.get(4)));
											arrValues.add(Helper.correctNull((String)arrcoappval.get(6)));
											arrValues.add(Helper.correctNull((String)arrcoappval.get(7)));
											arrValues.add(Helper.correctNull((String)arrcoappval.get(1)));
											hshQuery.put("arrValues", arrValues);
											//hshQueryValues.put("1", hshQuery);
											//hshQueryValues.put(""+intUpdatesize, hshQuery);
											hshQueryValues.put("size",Integer.toString(intUpdatesize));
											hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
											/*hshQueryValues.put("size", "1");
											EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
									/*	}
									}*/
									
									
						/*			hshQueryValues = new HashMap();
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;//added
									hshQuery.put("strQueryId", "ins_comments");
									arrValues.add(strAppno);
									arrValues.add("1");
									arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryProcesnote")));
									arrValues.add("brief");
									hshQuery.put("arrValues", arrValues);
									//hshQueryValues.put("1", hshQuery);
									//hshQueryValues.put(""+intUpdatesize, hshQuery);
									hshQueryValues.put("size","1");
									hshQueryValues.put("1",hshQuery);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									
									hshQueryValues= new HashMap();
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;//added
									hshQuery.put("strQueryId", "ins_comments");
									arrValues.add(strAppno);
									arrValues.add("2");
									arrValues.add(Helper.correctNull((String)hshValues.get("briefHistoryAnnexure")));
									arrValues.add("brief1");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size","1");
									hshQueryValues.put("1",hshQuery);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									
									hshQueryValues= new HashMap();
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;//added
									hshQuery.put("strQueryId", "ins_comments");
									arrValues.add(strAppno);
									arrValues.add("3");
									arrValues.add(Helper.correctNull((String)hshValues.get("briefHistorySourcing")));
									arrValues.add("brief2");
									hshQuery.put("arrValues", arrValues);
									
									hshQueryValues.put("size","1");
									hshQueryValues.put("1",hshQuery);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									
									ArrayList arrManginfo=new ArrayList();
									ArrayList arrManginfoval=new ArrayList();
									arrManginfo=(ArrayList) hshValues.get("arrmanginfo");
									
									int arrManginfolen=arrManginfo.size();
									
									
									intUpdatesize=0;
									if(arrManginfolen>0)
									{
										for(int i=0;i<arrManginfolen;i++)
										{
											arrManginfoval=(ArrayList) arrManginfo.get(i);
											
											hshQuery = new HashMap();
											arrValues = new ArrayList();
											intUpdatesize++;
											hshQuery.put("strQueryId", "ins_comments");
											arrValues.add(strAppno);
											arrValues.add(arrManginfoval.get(0));
											arrValues.add(arrManginfoval.get(1));
											arrValues.add("MangementInfo");
											hshQuery.put("arrValues", arrValues);
											
											hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
											//hshQueryValues.put(""+intUpdatesize, hshQuery);
											//hshQueryValues.put(String.valueOf(i+1), hshQuery); added
										}
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										/*hshQueryValues.put("size", String.valueOf(arrManginfolen));added
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");added*/
								/*	}*/
									
									
							/*		if(Helper.correctNull((String)hshValues.get("strBirRequired")).equalsIgnoreCase("Y"))
									{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;//added
									hshQuery.put("strQueryId","ins_per_bir_facility_prop");
									arrValues.add(strAppno);
									arrValues.add("Y");
									arrValues.add(Helper.correctNull((String)hshValues.get("strSubmissionDate")));
									arrValues.add(Helper.correctNull((String)hshValues.get("strReceiptDate")));
									arrValues.add(Helper.correctNull((String)hshValues.get("strBirReportDate")));
									arrValues.add(Helper.correctNull((String)hshValues.get("strBirCharges")));
									hshQuery.put("arrValues", arrValues);
									
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									}
									
									else
									{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;//added
									hshQuery.put("strQueryId","ins_per_bir_facility_prop");
									arrValues.add(strAppno);
									arrValues.add("");
									arrValues.add("");
									arrValues.add("");
									arrValues.add("");
									arrValues.add("");
									hshQuery.put("arrValues", arrValues);
									
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									}*/
									
						
						
									/*strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+Helper.correctNull((String)hshValues.get("strReferenceType")));
									rs = DBUtils.executeQuery(strQuery);
									if(rs.next())
									{
										mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
									}
									
									 mclrtype=Helper.correctNull((String)hshValues.get("strReferenceType"))+"@"+Helper.correctDouble(Helper.correctNull((String)hshValues.get("strFixedSpread"))+"@"+mclrtabcode);
										//FACILITY_APPNO,FACILITY_MCLRTYPE,MCLR_CRP_TOTAL,MCLR_SPREAD,MCLR_MSME
									 hshQuery = new HashMap();
										arrValues = new ArrayList();
										hshQuery.put("strQueryId","ins_mclrspread_facility_prop");
										arrValues.add(strAppno);
										arrValues.add(mclrtype);
										arrValues.add(Helper.correctNull((String)hshValues.get("strCreditRiskPremium")));
										arrValues.add(Helper.correctNull((String)hshValues.get("strFixedSpread")));
										arrValues.add("0");
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("1", hshQuery);
										hshQueryValues.put("size", "1");
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");*/
									 
									 
									/*	ArrayList arrayturnover=new ArrayList();
										ArrayList arrayturnoverval=new ArrayList();
										arrayturnover=(ArrayList) hshValues.get("arrayturnover");
										int turnoverlength=arrayturnover.size();
										int turnoverSize=turnoverlength;
										if(turnoverlength>0)
										{
											for(int i=0;i<turnoverlength;i++)
											{
												arrayturnoverval=(ArrayList) arrayturnover.get(i);
												 hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_turnoverMethod");
												arrValues.add(strAppno);
												arrValues.add(String.valueOf(i+1));
												arrValues.add(arrayturnoverval.get(0));	
												arrValues.add(arrayturnoverval.get(2));
												arrValues.add(arrayturnoverval.get(3));
												arrValues.add(arrayturnoverval.get(4));
												arrValues.add(arrayturnoverval.get(5));
												arrValues.add(arrayturnoverval.get(6));
												arrValues.add(arrayturnoverval.get(7));
												arrValues.add(arrayturnoverval.get(8));
												arrValues.add(arrayturnoverval.get(9));
												arrValues.add(arrayturnoverval.get(10));
												arrValues.add(arrayturnoverval.get(11));
												arrValues.add(arrayturnoverval.get(13));
												arrValues.add(arrayturnoverval.get(12));
												arrValues.add(arrayturnoverval.get(1));
												hshQuery.put("arrValues", arrValues);
												hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}					
										}
									
										int balTurnoverlength=5-turnoverlength;
										if(balTurnoverlength>0)
										{
											turnoverlength++;
											for(int j=0;j<balTurnoverlength;j++)
											{
												//hshQueryValues = new HashMap();
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_turnoverMethod");
												arrValues.add(strAppno);
												arrValues.add(String.valueOf(turnoverlength++));
												arrValues.add("0.00");	
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("S");
												hshQuery.put("arrValues", arrValues);
												hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}
										}*/
										
								/*		ArrayList arrayexpnd=new ArrayList();
										ArrayList arrayexpndvalue=new ArrayList();
										arrayexpnd=(ArrayList) hshValues.get("arrayexpenditure");
										int axpenditureLength=arrayexpnd.size();
										int axpenditureSize=axpenditureLength;
										if(axpenditureLength>0)
										{
											for(int i=0;i<axpenditureLength;i++)
											{
												arrayexpndvalue=(ArrayList) arrayexpnd.get(i);
												 hshQuery = new HashMap();
													arrValues = new ArrayList();
													intUpdatesize++;//added
													hshQuery.put("strQueryId","ins_expenditureMethod");
													arrValues.add(strAppno);
													arrValues.add(String.valueOf(i+1));
													arrValues.add(arrayexpndvalue.get(0));
													arrValues.add(arrayexpndvalue.get(2));
													arrValues.add(arrayexpndvalue.get(3));
													arrValues.add(arrayexpndvalue.get(4));
													arrValues.add(arrayexpndvalue.get(5));
											    	arrValues.add(arrayexpndvalue.get(6));
													arrValues.add(arrayexpndvalue.get(7));
													arrValues.add(arrayexpndvalue.get(8));
													arrValues.add(arrayexpndvalue.get(1));
													hshQuery.put("arrValues", arrValues);
															hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}
										}	
										
										int balExpditureLength=5-axpenditureLength;
										if(balExpditureLength>0)
										{
											axpenditureLength++;
											for(int j=0;j<balExpditureLength;j++)
											{
												//hshQueryValues = new HashMap();
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_expenditureMethod");
												arrValues.add(strAppno);
												arrValues.add(String.valueOf(axpenditureLength++));
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
										    	arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("0.00");
												arrValues.add("S");
												hshQuery.put("arrValues", arrValues);
											
												hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}
										}*/
								
								/*		ArrayList arrayapplicant=new ArrayList();
										ArrayList arrayappValue=new ArrayList();
										arrayapplicant=(ArrayList) hshValues.get("arrApplicant");
										int applicantlength=arrayapplicant.size();
										if(applicantlength>0)
										{
											for(int i=0;i<applicantlength;i++)
											{
												arrayappValue=(ArrayList) arrayapplicant.get(i);
												 hshQuery = new HashMap();
												 arrValues = new ArrayList();
												 intUpdatesize++;//added
												 hshQuery.put("strQueryId","updt_perapplicant_verification");
												 
												 arrValues.add(arrayappValue.get(1));
												 arrValues.add(arrayappValue.get(2));
												 arrValues.add(arrayappValue.get(3));
												 arrValues.add(arrayappValue.get(4));
												 arrValues.add(arrayappValue.get(5));
												 arrValues.add(arrayappValue.get(6));
												 arrValues.add(arrayappValue.get(7));
												 arrValues.add(arrayappValue.get(8));
												 arrValues.add(arrayappValue.get(9));
												 arrValues.add(arrayappValue.get(10));
												 arrValues.add(arrayappValue.get(11));
												 arrValues.add(arrayappValue.get(12));
												 arrValues.add(arrayappValue.get(13));
												 arrValues.add(arrayappValue.get(14));
												 arrValues.add(strSolid); 
												 arrValues.add(arrayappValue.get(0));
												 hshQuery.put("arrValues", arrValues);
											
												 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												hshQueryValues.put("size",Integer.toString(intUpdatesize));
												
											
											}
										}
										/*String turnoverTo="",expenditureExp="",assessmentType="";
										if(turnoverSize>0){
										
											turnoverTo="TO@";
										}
										if(axpenditureSize>0){
											expenditureExp="Exp@";	
										}
										
										assessmentType=turnoverTo+expenditureExp;
										
										 hshQuery = new HashMap();
										 arrValues = new ArrayList();
										 hshQuery.put("strQueryId","com_assessmentselection_insert");
										 arrValues.add(strAppno);
										 arrValues.add(assessmentType);
										 hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("1", hshQuery);
										hshQueryValues.put("size", "1");
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
										*/
										
										
							/*			String rowId="";
										rs=DBUtils.executeLAPSQuery("sel_fin_rowid");			 
										if(rs.next())
										{
											rowId=Helper.correctNull((String)rs.getString("fin_rowid"));
										}
										
										ArrayList arrdscr=new ArrayList();
										ArrayList arrdscrValues=new ArrayList();
										arrdscr=(ArrayList) hshValues.get("arraydscr");
										int dscrLength=arrdscr.size();
										int dscrSize=dscrLength;
										if(dscrLength>0)
										{
											for(int i=0;i<dscrLength;i++)
											{	
											
											arrdscrValues=(ArrayList) arrdscr.get(i);	
											if(arrdscrValues.get(15).equals("a"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												hshQuery.put("strQueryId","ins_finDSCR");
												intUpdatesize++;//added
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}
										
											if(arrdscrValues.get(15).equals("u"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCR");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}	
											
											if(arrdscrValues.get(15).equals("e"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCR");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
										
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}	
											
											if(arrdscrValues.get(15).equals("p"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCR");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}	
											
											
										}	
										}
										
							
										
										ArrayList arrdscrsens=new ArrayList();
										ArrayList arrdscrsensValues=new ArrayList();
										arrdscrsens=(ArrayList) hshValues.get("arraydscrSens");
										int dscrsensLength=arrdscrsens.size();
										int dscrsensSize=dscrLength;
										if(dscrsensLength>0)
										{
											for(int i=0;i<dscrsensLength;i++)
											{	
											
												arrdscrsensValues=(ArrayList) arrdscrsens.get(i);	
											if(arrdscrsensValues.get(15).equals("a"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCRSensitivity");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}
										
											if(arrdscrsensValues.get(15).equals("u"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCRSensitivity");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
											
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
											}
											}	
											
											if(arrdscrsensValues.get(15).equals("e"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
												
											
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCRSensitivity");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add("0");
													
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}
											}	
											
											if(arrdscrsensValues.get(15).equals("p"))
											{
												for(int j=0;j<Integer.parseInt(rowId);j++)
												{
													String strRowId="";
												//"sel_prdmargin_appl^"+ strPrdCode+"^"+desc
												strQuery = SQLParser.getSqlQuery("select_finmaster_rowid^"+(j+1));
												rs = DBUtils.executeQuery(strQuery);
												if(rs.next())
												{
													strRowId = Helper.correctNull((String)rs.getString("fin_rowid"));
												}
																	
											
												hshQuery = new HashMap();
												arrValues = new ArrayList();
												intUpdatesize++;//added
												hshQuery.put("strQueryId","ins_finDSCRSensitivity");
												
													arrValues.add(strAppno);
													arrValues.add(arrdscrValues.get(14));
													arrValues.add(strRowId);
													
													arrValues.add("0");
													
													arrValues.add("0");
													arrValues.add("0");
													arrValues.add(arrdscrValues.get(j));
													arrValues.add(String.valueOf(j+1));
													arrValues.add("0");
													arrValues.add("0");
													hshQuery.put("arrValues", arrValues);
													
													hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
											}
											}	
											
											
										}	
										}
										
							
										
										//RepaymentSchedule	
										//ArrayList arrRepayReschedule=new ArrayList();
										ArrayList arrrepayValue=new ArrayList();
										//arrRepayReschedule=(ArrayList) hshValues.get("arrRepaymentSchedule");
										int arrrepayScheduleSize=arrRepaySchedule.size();
										int serialNo=0;
										int facCode=1;
										for(int j=0;j<arrrepayScheduleSize;j++)
										{
										
										int repySheduleSize=((ArrayList) arrRepaySchedule.get(j)).size();
										ArrayList repayArray=new ArrayList();
										repayArray=(ArrayList) arrRepaySchedule.get(j);
										if(repySheduleSize>0)
										{
											for(int i=0;i<repySheduleSize;i++)
											{
										serialNo++;	
										arrrepayValue=(ArrayList) repayArray.get(i);
										
										
										String frequency=correctNull((String)arrrepayValue.get(0));
										String instlmntAmount=Helper.correctInt((String)arrrepayValue.get(1));
										String noInstlmnt=Helper.correctInt((String)arrrepayValue.get(2));
										String totalAmnt=Helper.correctInt((String)arrrepayValue.get(3));
										
										//hshQueryValues = new HashMap();
										hshQuery = new HashMap();
										intUpdatesize++;//added
										hshQuery.put("strQueryId", "ins_repaymnt_schdule");
										arrValues = new ArrayList();
										arrValues.add(strAppno);
										arrValues.add(String.valueOf(serialNo));
										arrValues.add(String.valueOf(facCode));
										arrValues.add(frequency);
										arrValues.add(instlmntAmount);
										arrValues.add(noInstlmnt);
										arrValues.add(totalAmnt);
										arrValues.add("P");
										hshQuery.put("arrValues", arrValues);
										
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));	
											}
											}		
										
										}
										
									
										hshQuery = new HashMap();
										arrValues = new ArrayList();
										intUpdatesize++;//added
										hshQuery.put("strQueryId","ins_assessment");
										
											arrValues.add(strAppno);
											arrValues.add("6");
											arrValues.add("<p>"+Helper.correctNull((String)hshValues.get("strAssessComment"))+"</p>");
											
											hshQuery.put("arrValues", arrValues);
											
											hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
											hshQueryValues.put("size",Integer.toString(intUpdatesize));
											
											//Sunil 06/09/2020
											ArrayList arrayMicroMitra=new ArrayList();
											arrayMicroMitra=(ArrayList) hshValues.get("arraymicroMitraAssessmentValue");
									
											int arrmicroMitraiLen=arrayMicroMitra.size();
											String arrayMicroMitraDesc= "Details as on Date,Value of Stock (A),Value of Book Debt (B),Value of Creditors (C),Total of A+B-C (D),MPBF 75.0% of D (E),Loan amount applied (F),Least of E or F";
											String arrDesc[]=arrayMicroMitraDesc.split(",");
											if(arrmicroMitraiLen>0)
											{
												for(int i=0;i<arrmicroMitraiLen;i++){
												 hshQuery = new HashMap();
												 arrValues = new ArrayList();
												 intUpdatesize++;//added
												 hshQuery.put("strQueryId","ins_com_assesmentdetails");
												 arrValues.add(strAppno);
												 arrValues.add("MMithra"); 
												 arrValues.add(String.valueOf(i+1));
												 arrValues.add(arrDesc[i]);
												 arrValues.add(arrayMicroMitra.get(i));
												 arrValues.add("");
												 hshQuery.put("arrValues", arrValues);					
												 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												 hshQueryValues.put("size",Integer.toString(intUpdatesize));
													
												}
											}
											
											String turnoverTo="",expenditureExp="",assessmentType="",assessComments="",strDscr="",strMithra="",strotherAssessmentforWCDPNWCTL="",strWCDPNWCTL="";
											
											strotherAssessmentforWCDPNWCTL = Helper.correctNull((String)hshValues.get("strotherAssessmentforWCDPNWCTL"));
										
											if(turnoverSize>0){
											
												turnoverTo="TO@";
											}
											if(axpenditureSize>0){
												expenditureExp="Exp@";	
											}
											
											if(!(Helper.correctNull((String)hshValues.get("strAssessComment"))).equals(""))
												assessComments="AOA@";
											
											if(dscrSize>0)
												strDscr="DSCR@";
												
											if(arrmicroMitraiLen>0)
												strMithra="MMithra@";
											
											if(!(Helper.correctNull((String)hshValues.get("strotherAssessmentforWCDPNWCTL"))).equalsIgnoreCase(""))
												strWCDPNWCTL="AOW@";
												
											assessmentType=turnoverTo+expenditureExp+assessComments+strDscr+strMithra+strWCDPNWCTL;
											
											 hshQuery = new HashMap();
											 arrValues = new ArrayList();
											 intUpdatesize++;//added
											 hshQuery.put("strQueryId","com_assessmentselection_insert");
											 arrValues.add(strAppno);
											 arrValues.add(assessmentType);
											 hshQuery.put("arrValues", arrValues);
											 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												hshQueryValues.put("size",Integer.toString(intUpdatesize));
											 //hshQueryValues.put("size",String.valueOf(intUpdatesize)); //added
												
										/*		ArrayList arrayDigiRate=new ArrayList();
												arrayDigiRate=(ArrayList) hshValues.get("arradigiratingValue");
												
												int arrdigiLen=arrayDigiRate.size();
												
												if(arrdigiLen>0)
												{
												
												 hshQuery = new HashMap();
												 arrValues = new ArrayList();
												 intUpdatesize++;//added
												 hshQuery.put("strQueryId","ins_digi_rate_score");
												 arrValues.add(strAppno);
												 arrValues.add(arrayDigiRate.get(0));
												 arrValues.add(arrayDigiRate.get(1));
												 arrValues.add(arrayDigiRate.get(2));
												 arrValues.add(arrayDigiRate.get(3));
												 arrValues.add(arrayDigiRate.get(4));
												 arrValues.add(arrayDigiRate.get(5));
												 arrValues.add(arrayDigiRate.get(6));
												 arrValues.add(arrayDigiRate.get(7));
												 arrValues.add(arrayDigiRate.get(8));
												 arrValues.add(arrayDigiRate.get(9));
												 arrValues.add(arrayDigiRate.get(10));
												 hshQuery.put("arrValues", arrValues);
												
												 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													hshQueryValues.put("size",Integer.toString(intUpdatesize));
												
												}
												
												if(!strotherAssessmentforWCDPNWCTL.equalsIgnoreCase(""))
												{
												 hshQuery = new HashMap();
												 arrValues = new ArrayList();
												 intUpdatesize++;//added
												 hshQuery.put("strQueryId","ins_assessment");
												 arrValues.add(strAppno);
												 arrValues.add("20");
												 arrValues.add(strotherAssessmentforWCDPNWCTL);
												 hshQuery.put("arrValues", arrValues);
												
												 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
												 hshQueryValues.put("size",Integer.toString(intUpdatesize));
												
												} */
												
											/*	ArrayList arraybussinessOperation=new ArrayList();
												ArrayList arraybussinessOperationval=new ArrayList();
												arraybussinessOperation=(ArrayList) hshValues.get("arraybussinessOperation");
												int turnbussinessOperation=arraybussinessOperation.size();
												if(turnbussinessOperation>0)
												{
													for(int i=0;i<turnbussinessOperation;i++)
													{
														
														
														 hshQuery = new HashMap();
														 arrValues = new ArrayList();
														 intUpdatesize++;//added
														 arraybussinessOperationval=(ArrayList) arraybussinessOperation.get(i);
														 hshQuery.put("strQueryId","ins_othercommentsdetails");
														 arrValues.add(strAppno);
														 arrValues.add(arraybussinessOperationval.get(0));
														 arrValues.add(arraybussinessOperationval.get(1));
														 arrValues.add(arraybussinessOperationval.get(2));
														 arrValues.add(arraybussinessOperationval.get(3));
														 arrValues.add(String.valueOf(i+1));
														 arrValues.add(arraybussinessOperationval.get(4));
														 arrValues.add(arraybussinessOperationval.get(5));
														 arrValues.add(arraybussinessOperationval.get(6));
														 arrValues.add(arraybussinessOperationval.get(7));
														 arrValues.add(arraybussinessOperationval.get(8));
														 hshQuery.put("arrValues", arrValues);
														 
														 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
														 hshQueryValues.put("size",Integer.toString(intUpdatesize));
													}	
													
												}*/
												
										/*		ArrayList arrayOdccLimits=new ArrayList();
												ArrayList arrayOdccLimitsval=new ArrayList();
												arrayOdccLimits=(ArrayList) hshValues.get("arrayOdccLimits");
												int OdccLimitslen=arrayOdccLimits.size();
												if(OdccLimitslen>0)
												{
													for(int i=0;i<OdccLimitslen;i++)
													{
														
														
														 hshQuery = new HashMap();
														 arrValues = new ArrayList();
														 intUpdatesize++;//added
														 arrayOdccLimitsval=(ArrayList) arrayOdccLimits.get(i);
														 hshQuery.put("strQueryId","ins_odcclimit");
														 arrValues.add(strAppno);//com_appno
														 arrValues.add(String.valueOf(i+1));//com_sno
														 arrValues.add(arrayOdccLimitsval.get(0));//com_sanclimit
														 arrValues.add(arrayOdccLimitsval.get(1));//com_crsummation
														 arrValues.add("");//com_drsummation
														 arrValues.add(arrayOdccLimitsval.get(2));//com_maxdrbal
														 arrValues.add(arrayOdccLimitsval.get(3));//com_mindrbal
														 arrValues.add(arrayOdccLimitsval.get(4));//com_maxcrbal
														 arrValues.add(arrayOdccLimitsval.get(5));//com_mincrbal
														 arrValues.add(arrayOdccLimitsval.get(6));//com_notimeexcess
														 arrValues.add(arrayOdccLimitsval.get(7));//com_noamtcheque
														 arrValues.add(arrayOdccLimitsval.get(8));//com_amount
														 arrValues.add(arrayOdccLimitsval.get(9));//COM_CREDITSUM
														 arrValues.add(arrayOdccLimitsval.get(10));//COM_DEBITSUM
														 arrValues.add(String.valueOf(i+1));//COM_YEAR_SNO
														 arrValues.add(arrayOdccLimitsval.get(11));//com_odcccomments
														 arrValues.add(arrayOdccLimitsval.get(12));//com_creditsumcomts
														 hshQuery.put("arrValues", arrValues);
														 
														 hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
														 hshQueryValues.put("size",Integer.toString(intUpdatesize));
													}	
													
												}
												
											 EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData"); //added */
											
							
							
								
								
								
								
								///////////////proposal creation ends /////////////////////////
								
							
							
							//////////////////////////////////
				/*			String strEncryptedPan = "";
							String strEncryptedAadhar = "";
							String strEncryptedpassport = "";
							String strEncryptedCBSID = "";
							String strPan = isCorrectNull(row.getCell(7));
							if(!(strPan.equalsIgnoreCase("") || strPan.equals(null) || strPan.equalsIgnoreCase("nopan")))
							{
								strEncryptedPan = Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strPan));
							}
							String strAadhar = isCorrectNumericCell(row.getCell(15));
							if(!(strAadhar.equalsIgnoreCase("") || strAadhar.equals(null)))
							{
								strEncryptedAadhar = Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strAadhar));
							}
							String strPassport = isCorrectNull(row.getCell(38));
							if(!strPassport.equalsIgnoreCase(""))
							{
								strEncryptedpassport  = Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strPassport));
							}
							String strCBSID = isCorrectNumericCell(row.getCell(1));
							if(!strCBSID.equalsIgnoreCase(""))
							{
								strEncryptedCBSID  = Helper.correctNull(AES_Encryption.AESencrypt(key,initVector,strCBSID));
							}
							appinwardreg = new ArrayList();
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							Id.add(isCorrectNumericCell(row.getCell(0)));
							InwardRegisterBean irb = new InwardRegisterBean();
							 strInwardno = irb.getMaxInwardno(strSolid);
							InwardNo.add(strInwardno);
							inwardData.put(Id.get(index), InwardNo.get(index));
							appinwardreg.add(strInwardno); // inward no	
							appinwardreg.add("p");   // sector
							appinwardreg.add(Helper.getCurrentDateTime());  // created on
							appinwardreg.add(Helper.getCurrentDateTime());  // applied on
							appinwardreg.add(isCorrectNull(row.getCell(3)));  // cust name
							appinwardreg.add("N");  // borrower type
							appinwardreg.add(strEncryptedCBSID);  // cust id 
							appinwardreg.add(isCorrectNull(row.getCell(16))); // address 1
							appinwardreg.add(isCorrectNull(row.getCell(17))); // address 2
							appinwardreg.add(lovSplit(row.getCell(18), true)); // city
							appinwardreg.add(lovSplit(row.getCell(19), true));  // state
							appinwardreg.add(isCorrectNumericCell(row.getCell(20))); //pincode
							appinwardreg.add(isCorrectNumericCell(row.getCell(22))); // phone no 
							appinwardreg.add(isCorrectNumericCell(row.getCell(23))); // mobile
							appinwardreg.add(isCorrectNull(row.getCell(12))); // email
							appinwardreg.add(sdf.format((isCorrectDate(row.getCell(8)))));  // dob
							appinwardreg.add(strEncryptedPan);  // pan
							appinwardreg.add("Home Loan");  // purpose of loan - home loan
							appinwardreg.add("1000");  // loan amt
							appinwardreg.add(Helper.getCurrentDateTime()); // doc received date
							appinwardreg.add("Y");  //  doc received 
							appinwardreg.add("1");  // appln processed at
							appinwardreg.add(strOrgscode);  //orgscode
							appinwardreg.add(strUsrid);  // user id
							appinwardreg.add("L");  // values in
							appinwardreg.add(strUsrid);  // modified by
							appinwardreg.add(Helper.getCurrentDateTime());  //  modified date
							appinwardreg.add(strEncryptedpassport);  // passport number
							appinwardreg.add(lovSplit(row.getCell(9), true));   // gender
							appinwardreg.add("1");  // cibil report
							appinwardreg.add("1");  //  co-applicant
							if(lovSplit(row.getCell(6), true).equals("001"))   // constitution
							{
								appinwardreg.add("1");
							}else{
								appinwardreg.add("2");
							}
							appinwardreg.add(strEncryptedAadhar);  // aadhar
							appinwardreg.add(strOrgscode); // branch s code
							appinwardreg.add(strOrgscode); // created branch
							appinwardreg.add(strOrgscode);  // orginate branch
							appinwardreg.add(lovSplit(row.getCell(42), true));  //emp status
							appinwardreg.add("U");  //
							appinwardreg.add(lovSplit(row.getCell(21), true)); // country
							System.out.println("appinwardreg================="+appinwardreg);
							hshQuery.put("strQueryId", "ins_inwardregbulkupload");
							hshQuery.put("arrValues", appinwardreg);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							System.out.println("LAR created for::"+strInwardno);*/
							
							/////////////////
							
							
							
									index++;
						}else{
							////break;
						}
				demoflag=true;
				////break;
			}
					}
				//}
				
				
				
			}
				catch(Exception demo)
				{
					demo.printStackTrace();
					throw new EJBException();
				}
			
		}
		
			////////////////////////
		/////other sheet////
			
			//if(!shgmemflag)
			//{
			if (sheet.getSheetName().equalsIgnoreCase("Members Details")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("Members Details");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
//				while (rowIterator.hasNext())
//				{
				
				try
				{
					System.out.println("inside Members Details");
					//Row row = rowIterator.next();
					final Row row = sheet.getRow(a);
					//System.out.println(row.getRowNum());
					if(!( row == null || isEmptyRow(row)))
					{
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
			int memso=0;
			
			
			//memso++;
			//int arrfacLen=facilityDetails.size();
			
			
					for( memso=1;memso<=membersdet;memso++)
					{
						if(row.getCell(memso) != null)
						{
			String shgmemberinfo=isCorrectNull(row.getCell(memso));
			
			
			
			String[] arrOfStr= shgmemberinfo.split("@");
			  String strCBSID="",strLAPSID="",strMemName="",strMemDOB="",strMemPAN="";
			  
			  strCBSID=String.valueOf(arrOfStr[0]);
			  strMemName=String.valueOf(arrOfStr[1]);
			  strMemDOB=String.valueOf(arrOfStr[2]);
			  strMemPAN=String.valueOf(arrOfStr[3]);
			
			String lapsoldID="",lapsID="";
			  strLAPSID="";
			  strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCBSID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
					lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
					strLAPSID=lapsID;
				}
				
				else
					
				{
					HashMap mhsh= new HashMap();
					mhsh.put("custid", strCBSID);
					updateFromFinacletoLapsDatabase(mhsh,"Insert");
					
					strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strCBSID);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						lapsoldID=Helper.correctNull((String)rs1.getString("perapp_oldid"));
						lapsID=Helper.correctNull((String)rs1.getString("perapp_id"));
						strLAPSID=lapsID;
					}
				}
				
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_shgMemberInfo");
			arrValues.add(strLapscustid);
			arrValues.add(""+memso);
			arrValues.add(strCBSID);
			//perapplicant_selcbsid
			arrValues.add(strLAPSID);
			
			arrValues.add(strMemName);
			arrValues.add(strMemDOB);
			arrValues.add(strMemPAN);
			arrValues.add("N");
			arrValues.add("N");
			arrValues.add("S");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
					}
					}
					
					
						}
						}
									}
				shgmemflag=true;
				//break;	

				}
				catch(Exception shg)
				{
					shg.printStackTrace();
					throw new EJBException();
				}
			}
			//}
			
			
			
			
			//////////////////////////////////////////////////////
		//	if(!facilitiesflag)
		//	{
			if (sheet.getSheetName().equalsIgnoreCase("Facilities")) 
			{
				int index = 0;
				int intUpdatesize=0;
				sheetNo = wb.getSheetIndex("Facilities");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
				//while (rowIterator.hasNext())
				//{
					System.out.println("inside Facilities");
					//Row row = rowIterator.next();
					
					try
					{
					final Row row = sheet.getRow(a);
					//System.out.println(row.getRowNum());
					if(!( row == null || isEmptyRow(row)))
					{
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
								
							proposedAmt=isCorrectNumericCell(row.getCell(4));
							strPrdCode=isCorrectNumericCell(row.getCell(2));
							sanamount=isCorrectNumericCell(row.getCell(6));

							//loandetails table
							
							/*	String intfacMonths=Helper.correctInt((String)hshValues.get("strtenor"));
								String strBPLR=Helper.correctNull((String)hshValues.get("strinterestRate"));
								String strPropbnktype=Helper.correctNull((String)hshValues.get("strproposedBankArrngmnt"));
								String strPurpose=Helper.correctNull((String)hshValues.get("strpuropse"));
								String strIntType=Helper.correctNull((String)hshValues.get("strinterestType"));
								String strGovtsponsschem=Helper.correctNull((String)hshValues.get("strgovtSponserScheme"));
								String strRepayType=Helper.correctNull((String)hshValues.get("strpaymentMode"));
								String strHolidayPeriod=Helper.correctNull((String)hshValues.get("strinitialHoliday"));
								String strMarginTerms=Helper.correctNull((String)hshValues.get("strmargin"));
								String strModeOfPay=Helper.correctNull((String)hshValues.get("strpaymentMode"));
								String strOperativeAccountNo=Helper.correctNull((String)hshValues.get("stroperativeAccNumber"));
								String strPerInstall=Helper.correctNull((String)hshValues.get("strperiodInstallment"));
								String strfacSubIntType=Helper.correctNull((String)hshValues.get("strinterestSubType"));
								String strdisplaydesc=Helper.correctNull((String)hshValues.get("strprocessNoteDesc"));
								String strMetLifeInsurance=Helper.correctNull((String)hshValues.get("strsinglePremium"));*/
								// facility table
													
								ArrayList facilityDetails=new ArrayList();
								ArrayList arrfacilitydetails=new ArrayList();
								facilityDetails=(ArrayList) hshValues.get("arrayFacilityDetails");
								
								//int arrfacLen=facilityDetails.size();
								
							//	if(arrfacLen>0)
							//	{
									//for(int i=0;i<arrfacLen;i++)
									//{
										//arrfacilitydetails=(ArrayList) facilityDetails.get(i);						
										
										strLimitId=isCorrectNumericCell(row.getCell(2));//(String) arrfacilitydetails.get(22);
										
//										String repayType=arrfacilitydetails.get(16)+"@";
//										if(rs!=null)rs.close();
//										strQuery = SQLParser.getSqlQuery("sel_corpdigiprd_tenor^"+strLimitId+"^"+arrfacilitydetails.get(4)+"^"+arrfacilitydetails.get(33)+"^"+repayType);
//										rs = DBUtils.executeQuery(strQuery);
//										if(rs.next())
//										{
//											strLimitId=Helper.correctNull((String)rs.getString("COM_FACID"));
//										}
//										if(rs!=null)rs.close();
//										if(arrfacilitydetails.get(0).equals("2"))
//										{
//											strQuery = SQLParser.getSqlQuery("sel_ExtSancAmnt^"+arrfacilitydetails.get(36)+"^"+arrfacilitydetails.get(37));
//											rs = DBUtils.executeQuery(strQuery);
//											if(rs.next())
//											{
//												strFACILITY_SANCAMT=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));
//												strCBS_ACCOUNTNO=Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
//											}
//										}
										
										String strFacHead="",strSubFac="",strFacilityDetails="",strComFacNAture="",strcomLoanAcc="";
										if(rs!=null)rs.close();
										rs=DBUtils.executeLAPSQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strLimitId);
										if(rs.next())
										{
											strFacHead = Helper.correctNull((String)rs.getString("com_headfac"));
											strSubFac = Helper.correctNull((String)rs.getString("com_subfac"));		
											strFacilityDetails=Helper.correctNull((String)rs.getString("COM_FACID"))+"-"+
																Helper.correctNull((String)rs.getString("COM_RANGEFROM"))+"-"+Helper.correctNull((String)rs.getString("COM_RANGETO"))+"-"+
																Helper.correctNull((String)rs.getString("COM_MINREPAYPERIOD"))+"-"+Helper.correctNull((String)rs.getString("COM_MAXREPAYPERIOD"));
																
										}
												if(rs!=null)rs.close();
												rs=DBUtils.executeLAPSQuery("sel_FacNat_loanacc^"+strLimitId);
												if(rs.next())
												{
													strComFacNAture=Helper.correctNull((String)rs.getString("com_facnature"));
													strcomLoanAcc=Helper.correctNull((String)rs.getString("com_loanacc"));
												}
			//select com_headfac,com_subfac,com_facdesc,com_facility_loantype,com_facdispdesc
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										intUpdatesize++;
										hshQuery.put("strQueryId","insfacility_details_SHG");								
										arrValues.add(correctNull(strAppno));//1
										arrValues.add(correctNull(strFacHead));//2
										arrValues.add(correctNull(strSubFac));//3
										arrValues.add(correctNull(strperappOldID));//4
//										if(arrfacilitydetails.get(0).equals("2"))
//										{
//											arrValues.add(strFACILITY_SANCAMT);//6facility_existing	
//										}
//										else{
											arrValues.add("0");//6facility_existing
										//}
										arrValues.add(isCorrectNumericCell(row.getCell(4)));//arrfacilitydetails.get(12));//6-facility_proposed
										arrValues.add("");//5
										
										
										//arrValues.add("0");//7
										//arrValues.add(correctNull(strIntadjust));
										arrValues.add("1");//arrfacilitydetails.get(28));//8
										arrValues.add("0");//arrfacilitydetails.get(29));//9
										arrValues.add("NIL");//arrfacilitydetails.get(10));//10
										arrValues.add("O");//category
										arrValues.add(isCorrectNumericCell(row.getCell(5)));//tenor//arrfacilitydetails.get(1));//11
										arrValues.add("");//branch name   arrfacilitydetails.get(4));//12	
										/*
										arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("type"));//2
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("adhocType"));//3
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityOfAdhoc"));//4
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestType"));//5
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("tenor"));//6
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proposedBankArrngmnt"));//7
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("paymentMode"));//8
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("periodInstallment"));//9
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("margin"));//10
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("dueDate"));//11
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("irregularities"));//12
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("govtSponserScheme"));//13
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("proopsedLimit"));//14
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("singlePremium"));//15
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestSubType"));//16
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("initialHoliday"));//17
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("repaymentType"));//18
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("interestRate"));//19
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("puropse"));//20
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("borrowerFreshLimit"));//21
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("processNoteDesc"));//22
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("detailsAsOn"));//23
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityDescription"));//24
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("operativeAccountNo"));//25
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmntFundedBy"));//26
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("insuranceAmount"));//27
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("premiumTenor"));//28
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("loanAmountCovered"));//29
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilitySno"));//30
							arrayFacilityDetailsval.add(jsonFacilityDetailsval.getString("facilityGroup"));//31				
										*/
										
										//arrValues.add(correctNull(strInterest));//mck
										//arrValues.add("");//13
										//arrValues.add(correctNull(strMargin));
										
										
										
										if(rs!=null)rs.close();// added by madhu
										rs=DBUtils.executeLAPSQuery("getshgrateofinterest");
										if(rs.next())
										{
											arrValues.add(Helper.correctNull((String)rs.getString("CORPPRD_INTEREST")));
										}
										else
										{
											arrValues.add("14.0");
										}
										
										
										if(rs!=null)rs.close();
										
										
										//arrValues.add("11.5");//EBLR");//arrfacilitydetails.get(17));//added by suresh for inserting BPLR 14
										//arrValues.add(correctNull(strDP));
										//arrValues.add(correctNull(strOutstanding));
										//arrValues.add(correctNull(strSecurity));
										//arrValues.add(correctNull(strcbsaccno));
										//arrValues.add(correctNull(strfacilityintremarks));
										arrValues.add(Helper.getCurrentDateTime());//15
										//arrValues.add(correctNull(strExistbnktype));
										arrValues.add(("S"));//arrfacilitydetails.get(5)));//16
										arrValues.add("Internal Lending");//arrfacilitydetails.get(18));//17
										//added by bhaskar								
										arrValues.add("Fix");//Flo");//arrfacilitydetails.get(3));//18							
										arrValues.add("2");//(arrfacilitydetails.get(11)));//19
										arrValues.add("0");//20
										arrValues.add("0");//21
										arrValues.add("0");	//22
										arrValues.add("0");//23
										arrValues.add("OD");//N");//"E"));//    repayment type arrfacilitydetails.get(16)));//24
										arrValues.add(isCorrectNumericCell(row.getCell(2)));//25
										arrValues.add(strFacilityDetails);//"185-1.00-9999999999.00-1-34-0");//
//strFacilityDetails);//26strFacDetails
										arrValues.add("aS");//27stragrSchemeType
										arrValues.add("0");//arrfacilitydetails.get(15));//28	holidayPeriod
										arrValues.add("s");//arrfacilitydetails.get(35));//29
//										if(arrfacilitydetails.get(34).equals("s") || arrfacilitydetails.get(34).equals("y"))
//										{
//											arrValues.add("1"); //interest charged 
//										}
//										else
//										{
											arrValues.add("3");  //interest charged 
										//}
										arrValues.add(("NIL"));//arrfacilitydetails.get(8)));//31
										//arrValues.add("E");////arrfacilitydetails.get(6));//32	
										arrValues.add("N");//OD");//N");//added by madhu
										arrValues.add("");//operative acc no  arrfacilitydetails.get(23));//33
										arrValues.add("");	//34
										arrValues.add("n");//OD");//m");//pre install   arrfacilitydetails.get(7));//35
										//arrValues.add("SMTB");//NOTAP");//inttype  arrfacilitydetails.get(14));//36
										arrValues.add("NOTAP");//added by madhu
										arrValues.add(""); //37
										arrValues.add("");//38
//										//if(arrfacilitydetails.get(0).equals("2"))
//										{
//											arrValues.add(strCBS_ACCOUNTNO);//6	
//										}
//										else{
											arrValues.add("");//6//cbs_accountno
										//}
										arrValues.add("11.5");//interest arrfacilitydetails.get(17));//40
										//arrValues.add("");//sanctioned amount //arrfacilitydetails.get(12));//41
										arrValues.add(sanamount); //added by madhu//sanamount
										arrValues.add("2");//strComFacNAture);//42
										arrValues.add("");//43
										arrValues.add("11.5");//arrfacilitydetails.get(17));//44
									    arrValues.add("");//45
										arrValues.add("1");//arrfacilitydetails.get(0));//46 sel_type
										arrValues.add("");//arrfacilitydetails.get(19));//47 borrowerfreshlimit
										arrValues.add("Y");//facility acc open//strcomLoanAcc);//48
//										if(arrfacilitydetails.get(0).equals("2"))
//										{
//											arrValues.add("R");//49 FACILITY_TYPEFOR
//										}
//										else{
											arrValues.add("F");//49 FACILITY_TYPEFOR
										//}
										//arrValues.add("F");	//49
											
											
										arrValues.add(""); //50
										arrValues.add("1");//3 //facility display desc //arrfacilitydetails.get(20)); //51//facility_catdesc
										arrValues.add("op"); //52
										//if(arrfacilitydetails.get(0).equals("1"))
										//{
											arrValues.add(""); //53
										//}
//										else
//										{
//											arrValues.add("Y"); //53
//										}
										
										arrValues.add(""); //54
										arrValues.add("");	//FACILITY_CONVERSION_FAC
										arrValues.add("");
										arrValues.add("");
										arrValues.add("");
										arrValues.add("");
										arrValues.add("");
										arrValues.add("N");
										arrValues.add("0");//single premium amt//arrfacilitydetails.get(25));
										/*arrValues.add("");
										arrValues.add("");
										arrValues.add("");
										arrValues.add("");*/
										arrValues.add("");
										arrValues.add("");//tenor arrfacilitydetails.get(26));
										arrValues.add("");//loan amt arrfacilitydetails.get(27));
										arrValues.add("");
										arrValues.add("");//premium amt arrfacilitydetails.get(13));
										arrValues.add("NC");//fac_ins_company_name arrfacilitydetails.get(24));
										arrValues.add("");//FACILITY_OLDAPPNO arrfacilitydetails.get(36));
										arrValues.add("");//FACILITY_OLDAPPSNO  arrfacilitydetails.get(37));
										arrValues.add("");//FAC_ROITYPE
										arrValues.add("");//arrfacilitydetails.get(38));
										arrValues.add("");//arrfacilitydetails.get(39));
										arrValues.add("");//arrfacilitydetails.get(40));
										arrValues.add("");//arrfacilitydetails.get(41));
										arrValues.add("");//arrfacilitydetails.get(42));
										
										
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size","1");
										hshQueryValues.put("1",hshQuery);	
										//hshQueryValues.put(""+intUpdatesize, hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
										
										
										
							/*	strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+arrfacilitydetails.get(32));
								if(rs!=null)rs.close();
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
								}
								
								// mclrtype=Helper.correctNull((String)hshValues.get("strReferenceType"))+"@"+arrfacilitydetails.get(31)+"@"+mclrtabcode;
			 
								 /*	hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","ins_mclrspread_facility_prop");
									arrValues.add(strAppno);
									arrValues.add(mclrtype);
									arrValues.add(arrfacilitydetails.get(30));
									arrValues.add(arrfacilitydetails.get(31));
									arrValues.add("0");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
										 
								
									// arrRepaySchedule=new ArrayList();
									// arrrescheduleData=new  ArrayList();
								//	arrRepaySchedule.add(arrfacilitydetails.get(34));
									//arrrescheduleData.add(arrRepaySchedule);
						
								/*	if(arrfacilitydetails.get(0).equals("2"))
									{
										hshQuery = new HashMap();
										arrValues = new ArrayList();
										intUpdatesize++;
										hshQuery.put("strQueryId","updaterenewfacility");
										arrValues.add("Y");
										arrValues.add((String) arrfacilitydetails.get(36)); //old proposal number
										arrValues.add((String) arrfacilitydetails.get(37)); //old proposal sno
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										//hshQueryValues.put(""+intUpdatesize, hshQuery);
									}
									String typeOfFac = (String)arrfacilitydetails.get(0);
									 if(typeOfFac.equals("2"))
										{
											hshQuery = new HashMap();
										arrValues = new ArrayList();
										intUpdatesize++;
										hshQuery.put("strQueryId","updatefacilityrenewflag");
										arrValues.add("R"); //APP_RENEW_FLAG
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										}*/
							//}
						//}
						
							//ended
								if(rs != null)
								{
									rs.close();
								}	
								
								/*hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								*/
								//Proposal values

								hshQuery=new HashMap();
								arrValues=new ArrayList();
								//intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","commapplicantloanins3");
								arrValues.add(strAppno);
								arrValues.add("0");
								arrValues.add("0");
								arrValues.add("");//arrfacilitydetails.get(12));
								arrValues.add("");//arrfacilitydetails.get(12));
								arrValues.add("");//arrfacilitydetails.get(12));
								arrValues.add("0");
								arrValues.add("0");
								
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size","1");
								hshQueryValues.put("1",hshQuery);	
								
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								hshQuery.put("strQueryId", "ins_takeovernormSHG");
								arrValues.add(strAppno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								//start by madhu reason :sharing equal amount to members
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								hshQuery.put("strQueryId", "del_shgmembershare");
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								if(rs != null)rs.close();
								strQuery = SQLParser.getSqlQuery("countnumberofmembers^"+strAppno);
								rs = DBUtils.executeQuery(strQuery);
								int members=0;
								if(rs.next())
								{
									members=Integer.parseInt(Helper.correctNull((String)rs.getString("MEMBERS")));
								}
								
								if(rs != null)rs.close();
								
								int shareamt=0;
								if(!sanamount.equalsIgnoreCase(""))
								{
									shareamt=Integer.parseInt(sanamount);  
								}
								shareamt=shareamt/members;
								strQuery = SQLParser.getSqlQuery("sel_loanshare_shg1^"+strAppno);
								rs = DBUtils.executeQuery(strQuery);
								while(rs.next())
								{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									hshQuery.put("strQueryId", "ins_shgmembershare");
									arrValues.add(strAppno);
									arrValues.add("1");
									arrValues.add(Helper.correctNull((String)rs.getString("SHG_MEM_SNO")));
									arrValues.add(Integer.toString(shareamt));
									arrValues.add("N");
									arrValues.add("");
									arrValues.add("s");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size", "1");
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								}
								
				            //end by madhu
								
								
								//start by madhu for banking Arrangement
								
								HashMap hshQuerynew = new HashMap();
								hshQuerynew.put("appno", strAppno);
								hshQuerynew.put("strSno", "1");
								hshQuerynew.put("strBorrowId", strLapscustid);
								hshQuerynew.put("strSessionMod", "AGR");
								
								UpdateBankingdataSHG(hshQuerynew);
								
								// banking Arrangement for proposed
								
								//Start  by madhu
								
								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "del_com_comments_shg");
								arrValues = new ArrayList();
								arrValues.add("commentsonintrestrate");
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								
								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "ins_commentsoninterestrate");
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								arrValues.add("1");
								arrValues.add("<p>14% (Fixed) p.a. at present as per the SKDRDP scheme guidelines.</p>");
								arrValues.add("commentsonintrestrate");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "del_com_comments_shg");
								arrValues = new ArrayList();
								
								arrValues.add("term");
								arrValues.add(strAppno);
								arrValues.add("1");
								
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								

								

								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "ins_commentsoninterestrate");
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								arrValues.add("1");
								arrValues.add("<p>Loans not availed with our Bank.</p>");
								arrValues.add("term");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								
								
								
								
								
							  
								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "del_com_comments_shg_other");
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								for(int i=1;i<14;i++)
								{
									if(i!=2)
									{
										hshQueryValues= new HashMap();
										hshQuery = new HashMap();
										hshQuery.put("strQueryId", "ins_commentsoninterestrate");
										arrValues = new ArrayList();
										arrValues.add(strAppno);
										arrValues.add(""+i);
										arrValues.add("<p>Not Applicable.</p>");
										arrValues.add("otherfac");
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("1", hshQuery);
										hshQueryValues.put("size", "1");
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									}
								}

							
	
								
								
								hshQueryValues= new HashMap();
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "del_allcomments_fac");
								arrValues.add(strAppno);
								arrValues.add("repaycomment");
								arrValues.add("1");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "1");
								hshQueryValues.put("1", hshQuery);
								
								// FINANCIALCOMMENTS TABLE
								String strflowdata="";
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "ins_financial_comments2");
								arrValues.add(strAppno);
								arrValues.add("");
								arrValues.add("repaycomment");
//								arrValues.add("<p>On demand as per the scheme guidelines.<br />Limit Sanctioned:<br />Drawing Power:</p>");
								arrValues.add(correctNull((String)hshValues.get("strrepaymentterms")));
								arrValues.add("");
		  						arrValues.add("");
		  						arrValues.add("1");
		  						arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "2");
								hshQueryValues.put("2", hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");	
							
								
								
								String duedate=Helper.getCurrentDateTime();
								String endduedate="";
								String day1=duedate.substring(0, 2);
								String month1=duedate.substring(3, 5);
								String year1=duedate.substring(6, 10);

								if(Integer.valueOf(day1)<=28)
								{
									if(month1.equalsIgnoreCase("01")|| month1.equalsIgnoreCase("03") || month1.equalsIgnoreCase("05")|| month1.equalsIgnoreCase("07") || month1.equalsIgnoreCase("08")|| month1.equalsIgnoreCase("10")||month1.equalsIgnoreCase("12"))
									{
										endduedate="31/"+month1+"/"+year1;
									}
									if(month1.equalsIgnoreCase("02"))
									{
										endduedate="28/"+month1+"/"+year1;
										
										if(Integer.valueOf(year1)%4==0)
										{
											endduedate="29/"+month1+"/"+year1;
										}
									}
									if(month1.equalsIgnoreCase("04")|| month1.equalsIgnoreCase("06")||month1.equalsIgnoreCase("09")|| month1.equalsIgnoreCase("11"))
									{
										endduedate="30/"+month1+"/"+year1;
									}
									
								}
									
									String newtxt_tenopendatemon=endduedate;
									String txt_valdays=isCorrectNumericCell(row.getCell(5));
									String expiry_date="";
									
									
								
								  rs=DBUtils.executeLAPSQuery("sel_expirydatedualnewfacilityshg^"+newtxt_tenopendatemon+"^"+newtxt_tenopendatemon+"^"+txt_valdays+
							        		"^"+newtxt_tenopendatemon+"^"+txt_valdays);
									if(rs.next())
									{
										System.out.println("=================="+correctNull(rs.getString("expiry_date")));
										
										expiry_date=	correctNull(rs.getString("expiry_date"));
									}
									
								
									if(rs!=null)
									{
										rs.close();
									}
									
								
								hshQueryValues= new HashMap();
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "updduefacitydateshg");
								arrValues = new ArrayList();
								arrValues.add(expiry_date);//endduedate);
								arrValues.add(strAppno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);
								
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								
								    hshQueryValues= new HashMap();
								    hshQuery=new HashMap();
			                        arrValues=new ArrayList();
			                        hshQueryValues.put("size","1");
			                        hshQuery.put("strQueryId","ins_BankingArrangment");
			                        arrValues.add(strAppno);
			                        arrValues.add("S");
			                        arrValues.add("0");
			                        arrValues.add("0");
			                        arrValues.add("S");
			                        arrValues.add("0");
			                        arrValues.add("0");
			                        arrValues.add("S");
			                        
			                        hshQuery.put("arrValues", arrValues);
			                        hshQueryValues.put("1",hshQuery);
			                        EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

								
								
								
					}}
					
				}
				
				facilitiesflag=true;	
					}
					catch(Exception fac)
					{
						fac.printStackTrace();
						throw new EJBException();
					}
				//break;
			}
			
			
			if (sheet.getSheetName().equalsIgnoreCase("Securities")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("Securities");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
				//while (rowIterator.hasNext())
				//{
				
				try
				{
				int intUpdatesize=0;
					System.out.println("inside Securities");
					//Row row = rowIterator.next();
					final Row row = sheet.getRow(a);
					//System.out.println(row.getRowNum());
					if(!( row == null || isEmptyRow(row)))
					{
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
							String strOldLapsId="";
							if (rs != null) 
							{  	rs.close();  }
							strQuery = SQLParser.getSqlQuery("select_perappoldid^"+strLapscustid);
				    		rs = DBUtils.executeQuery(strQuery);
				    		if(rs.next())
				    		{
				    			strOldLapsId = Helper.correctNull((String) rs.getString("perapp_oldid"));
				    		}
				    		//strUserId=SysteUserId;
				    		String strSysUser=strUsrid;//"K10197",strusrorg="";
				    		String strUserIdh="",strOrgLevelh="",strOrgScode="",strorg_branchin="",strSecurityId="";
							
				    		strQuery = SQLParser.getSqlQuery("sel_orghead_userorg^"+strSolid);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strUserIdh = Helper.correctNull((String)rs.getString("USR_ID"));
								strOrgLevelh = Helper.correctNull((String)rs.getString("ORG_LEVEL"));	
								strOrgCode = Helper.correctNull((String)rs.getString("ORG_CODE"));
								strOrgScode = Helper.correctNull((String)rs.getString("ORG_SCODE"));
								//strUserClass = Helper.correctNull((String)rs.getString("USR_CLASS"));
								strorg_branchin = Helper.correctNull((String)rs.getString("org_branchin"));
							}
							
							
							// selcollateralenddateshg
							
							String CUS_SEC_COLLATERAL_END_DATE="";
							
							strQuery = SQLParser.getSqlQuery("selcollateralenddateshg");
							rs = DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								CUS_SEC_COLLATERAL_END_DATE = Helper.correctNull((String)rs.getString("CUS_SEC_COLLATERAL_END_DATE"));				
							}
							if(rs != null)rs.close();
							
							
							
							SecurityMasterBean secMasBean =new SecurityMasterBean();
							strSecurityId = secMasBean.getOldAppidWithSno(strOldLapsId);
							
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId","ins_securities_detailsSHG");	
							arrValues.add(strSecurityId);
							arrValues.add("1");//correctNull((String)hshValues.get("strSecurityType")));
							arrValues.add("25");//correctNull((String)hshValues.get("strSecurityClassification")));
							arrValues.add("N");//correctNull((String)hshValues.get("strAlChrgdToOtherBanks")));
							arrValues.add("3");//0//1,3,005,006//correctNull((String)hshValues.get("strNatureOfCharge")));
							arrValues.add("");//correctNull((String)hshValues.get("strValuerName"))); 
							//arrValues.add(correctNull((String)hshValues.get("strDateOfSubmissionForValuation")));
							arrValues.add(correctNull((String)hshValues.get("strDateOfReceiptOfValuation")));
							arrValues.add(correctNull((String)hshValues.get("strDateOfValuation")));
							arrValues.add("Clean, Joint and Several Liabilities of the group and its members");//Clean - SHG loan under NULM scheme.Joint and several liabilities of groups and its members.");//correctNull((String)hshValues.get("strSecurityDescription"))); 
							//arrValues.add(correctNull((String)hshValues.get("strCollateralStartDate")));
							arrValues.add(CUS_SEC_COLLATERAL_END_DATE);////correctNull((String)hshValues.get("strCollateralEndDate")));
							arrValues.add(String.valueOf(Helper.correctDouble((String)hshValues.get("strTotalSecurityValue"))));
							arrValues.add(String.valueOf(Helper.correctDouble((String)hshValues.get("strTotalSecurityValue"))));
							arrValues.add("Y");
							arrValues.add("N");
							arrValues.add(strSysUser);
							arrValues.add(strOrgCode);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
				    		
							
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId","ins_ownership_securities");
							arrValues.add(strSecurityId);
							arrValues.add(strOldLapsId);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size", "2");
							
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_sec_inbox_new");
							arrValues.add(strSecurityId);
							arrValues.add(strSysUser);
							arrValues.add("N");
							arrValues.add(strOrgScode);
							arrValues.add("");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("3",hshQuery);
							hshQueryValues.put("size", "3");
							
							
							//security attachment
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strAppno);
							arrValues.add(strSecurityId);
							arrValues.add("1");
							arrValues.add(strLAPSid);
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("F");
							arrValues.add("P");//strLoanType);//loantype
							arrValues.add("1");
							arrValues.add(proposedAmt);//correctNull((String) hshValues.get("strAmountRequested")));
							arrValues.add(proposedAmt);//correctNull((String) hshValues.get("strAmountRequested")));
							arrValues.add("1");
							arrValues.add(strLAPSid);
							arrValues.add("0.00");
							arrValues.add("");//strPrdCode);
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
							
							hshQueryValues.put("4",hshQuery);
							hshQueryValues.put("size","4");
							
							
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
										
							//security Freeze
							BankAppFIBean bankappfi=new BankAppFIBean();
							hshValues.put("appno", strAppno);
							hshValues.put("hidapplicantid", strLAPSid);
							hshValues.put("hidapplicantnewid", strLAPSid);
							
							

							bankappfi.getSecCollateralCoverageRetail(hshValues);
							
							
							
							
							
							
							///////////////////////////////////////security end///////////////////
							
							
							
							
							//terms and conditions
						/*	ArrayList arrTerms=new ArrayList();
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
									arrValues.add(strAppno);
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
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
							
							
							
							
							ResultSet rs2=null;
							String strTermsno="",strTerms="",strMode="",strPrePost="",strParentid="",strSno1="";
							rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditionsshg^"+"A"+"^"+"P");//sel_Specifidtermsconditionsshg	  //sel_Specifidtermsconditions		
							while(rs2.next())
							{
								strTermsno = rs2.getString("fac_sno");
								strTerms = rs2.getString("fac_terms");
								strMode= rs2.getString("fac_mode");
								strPrePost=rs2.getString("fac_prepost");
								strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
								intUpdatesize = intUpdatesize+1;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","insfactermsSHG");//insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno1));
								//arrValues.add(correctNull(strFacCode));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull("A"));//strModType));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								
								arrValues.add(correctNull("A"));////P"));//strTermsType));
								arrValues.add(correctNull("N"));//strTermsDel));
								arrValues.add(" ");
								arrValues.add("Y");//Nssssssss
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size","1");
								hshQueryValues.put("1",hshQuery);	
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

							}
							if(rs2 !=null){
								rs2.close();
							}
							
							
							
							//Coapplicant Freeze
							hshValues.put("appno", strAppno);
							PerApplicantBean perApplicantBean = new PerApplicantBean();
							perApplicantBean.getFreezeData(hshValues);
							
							//Credit Facilities Freeze
							BankAppFIBean appFIBean = new BankAppFIBean();
							appFIBean.updateFreezeData(hshValues);
						
						//////replayment terms //////
							
							
							/* hshQuery = new HashMap();
						 	 arrValues=new ArrayList();
							 arrValues.add(strAppno);
							  arrValues.add("on Demand");//correctNull((String) hshValues.get("txt_fincomments")));
							 hshQuery.put("arrValues",arrValues);
							 hshQuery.put("strQueryId","tlr_financialcomments_insert");
							 hshQueryValues.put("1",hshQuery);
							 hshQueryValues.put("size","1");							
							 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
							 
							 
							 //rating insertion kaylpto
							 //CREDITSCORING
						/*	 arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								hshQueryValues.put("size", "1");
					 			hshQuery.put("strQueryId", "creditratinsu");
					   			arrValues.add(strAppno);
					   			arrValues.add(String.valueOf(r));
					   			arrValues.add(strRATING_SCORE);
					   			arrValues.add("Y");
					   			arrValues.add(strRATING_LABEL);
					   			arrValues.add(strRatUserId);
					   			//arrValues.add(strDateAson);
					   			arrValues.add(strratingyear);
					   			arrValues.add(stryeartype);	
					   			arrValues.add("");
					   			arrValues.add(strRMDUser);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);	
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
							 
							 
							// DDR/BIR
							 
							 
							 arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								arrValues.add(strAppno);
								arrValues.add("N");//Helper.correctNull((String)hshValues.get("sel_bir")));								
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("It is not applicable to SHG finance and SKDRDP scheme guidelines as well.");//Helper.correctNull((String)hshValues.get("txt_bircomments")));
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","ins_per_birshg");//ins_per_bir");
								hshQueryValues.put("size","1");
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
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
							
							
							
							String strActCode="";
							String strActivityCodes="";
							//strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+strModuleType);
							
							strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+"a");
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strActivityCodes=correctNull(Helper.CLOBToString(rs.getClob("prdact_activitycode")));
							}
							if( strActivityCodes != null )
							{
								StringTokenizer st = new StringTokenizer(strActivityCodes,"~");
								while(st.hasMoreTokens())
								{
									String strCode = (String)st.nextToken();
									if(strCode != null)
									{
										String[] strDesc=strCode.split("&");
										if(strDesc!=null)
										{
											strActCode=strActCode+"'"+strDesc[0]+"',";
										}
									}
								}
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
							//String strActCode=Helper.correctNull((String) hshValues.get("strmisActivityCode"));
							String stractivitycode=strActCode;
							if(rs1!=null)
							{	  rs1.close();		}
							
							if(strActCode.endsWith(","))
							{
								strActCode=strActCode.substring(0,strActCode.length()-1);
							}
							if(strActCode.equalsIgnoreCase(""))
							{
								strActCode = "''";
							}
							strActCode="020143";
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
							dblTotLimAgr=misbean.getBorrowerTotalAgriLimit(strLAPSid,"R",strAppno);
							dblTotLimSer=misbean.getBorrowerTotalServiceLimit(strLAPSid,"R",strAppno);
							
							 querycount=0;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							querycount++;
							hshQuery.put("strQueryId","del_misappdetails");
							arrValues.add(strAppno);
							arrValues.add("1"); //facility serialno
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(querycount),hshQuery);
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							querycount++;
							hshQuery.put("strQueryId","del_misappdisplayscreen");
							arrValues.add(strAppno);
							arrValues.add("1"); //facility serialno
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(querycount),hshQuery);
							
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							querycount++;
							hshQuery.put("strQueryId","ins_misappdetails");
							arrValues.add(strAppno);
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
							arrValues.add("020143");//strActCode);
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
							arrValues.add(strAppno);
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
							strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^"+"1");
							MISLogger.UpdateLogger(strQuery);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								if(!Helper.correctNull((String)hshValues.get("txt_ActivityCode")).equalsIgnoreCase(""))
								{
									if(rs!=null)
										rs.close();
									strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +"020143");//Helper.correctNull((String)hshValues.get("txt_ActivityCode")));
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
										arrValues.add(strAppno);
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
								arrValues.add(strAppno);
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
							strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strAppno+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
							strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
							}

							if(rs!=null)
							rs.close();
							String strlbrcode="",freeCode6="",freeCode7="",freeCode8="",finfreeCode7="",finfreeCode8="";
							strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^"  +"020143");
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
							
							strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strAppno+"^op");
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
								strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
								strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
							}
							System.out.println("===============strLoanType===========1"+strLoanType);
							if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
							{
								strLoanType="LAA";
							}
							else if(strLoanType.equalsIgnoreCase("OD"))
							{
								strLoanType="ODA";
							}
							System.out.println("===============strLoanType===========222222"+strLoanType);
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
							arrValues.add(strAppno);
							arrValues.add(freeCode6);
							arrValues.add(freeCode7);
							arrValues.add(freeCode8);
							arrValues.add("17");////01");//strModeOfOperation
							arrValues.add("M");//E");//strDrawingPowerInd
							arrValues.add(sanamount);//correctNull((String) hshValues.get("strAmountRequested"))); //sanc amount
							arrValues.add("N"); // Account Handoff
							arrValues.add("03");//strAdvanceNature
							arrValues.add("20");//strAdvanceType);
							arrValues.add(strmodeofadv);
							arrValues.add("10"); //default 10
							arrValues.add("999"); //default 999
							arrValues.add(strSolid);
							arrValues.add(""); //Security Code
							arrValues.add("M");//strintratefrq);
							arrValues.add(finfreeCode7);
							arrValues.add(finfreeCode8);
							arrValues.add(strlbrcode);
							arrValues.add(strFacilitySno);
							arrValues.add("Clean,Joint and Severval Liabilities of the group and its members.");
							arrValues.add("ODPS");//TGAQ"); //facilityschemecode
							arrValues.add("70006");//strGLSubHeadCode); //facility_glsubheadcode
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
							hshValues.put("app_no", strAppno);
							//hshValues=getDocumentURLs(hshValues);
							
							//APPRAISALSANCTION table
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "ins_appraisalsanc_extappl");
							arrValues = new ArrayList();
							arrValues.add(strAppno);
							arrValues.add(strUserId);//appraised by
							arrValues.add(sanamount);//correctNull((String) hshValues.get("strAmountRequested")));//sanc amount
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
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
							
							hshQueryValues= new HashMap();
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_msmeappinwardSHG");
							arrValues.add(proposedAmt);
							arrValues.add(inwarddistrict);
							arrValues.add(strInwardno);//strlarNo);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
							
							
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							
							hshQuery.put("strQueryId","ins_delegation");
							String strSno="",txt_name="",USER_DESIGNATION="";
							strQuery=SQLParser.getSqlQuery("delegationmax^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strSno = correctNull(rs.getString(1));				
							}
							
							if(rs!=null)
							{
								rs.close();
							}
							
							strQuery=SQLParser.getSqlQuery("selshguserdetails^"+strUserId);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								txt_name = correctNull(rs.getString(1));
								USER_DESIGNATION=correctNull(rs.getString(2));
							}
							arrValues.add(strAppno);
							
							arrValues.add(txt_name);
							arrValues.add(USER_DESIGNATION);//correctNull((String)hsh.get("txt_desig")));
							
							arrValues.add(strSno);
							arrValues.add(strUserId);//correctNull((String)hsh.get("txtuserID")));
							arrValues.add("A");//correctNull((String)hsh.get("sel_details")));
							arrValues.add(Helper.getCurrentDateTime());//correctNull((String)hsh.get("txt_date")));

							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							
							
							if(rs!=null)
							{
								rs.close();
							}
							
							if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
							{
								strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+custid);
								rs=DBUtils.executeQueryCBSConnection(strQuery);
							}
							else
							{
								strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+custid);
								rs=DBUtils.executeQuery(strQuery); 
							}
							String Name="",dob="",age="";
                        if(rs.next()){
							Name=(String) Helper.correctNull(rs.getString("CUST_TITLE_CODE"))+" "+
							(String) Helper.correctNull(rs.getString("CUST_NAME"))+" "+(String) Helper.correctNull(rs.getString("CUST_SHORT_NAME"));
							
							 dob=(String) Helper.correctNull(rs.getString("DATE_OF_BIRTH")).trim();
							age=(String) Helper.correctNull(rs.getString("years")).trim();
                        }
                        if(rs!=null)
						{
							rs.close();
						}
							
							hshQueryValues=new HashMap();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_ratification_comments");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add(
									
									"<table class='MsoTableGrid' style='margin-left:5.65pt; border-collapse:collapse; border:solid windowtext 1.0pt' width='577'>"
											+"<tbody>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Name of the Group</span></b></span></span></p>"
													+"</td>"
													+"<td style='border:solid windowtext 1.0pt; width:179.8pt; border-left:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+Name+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Date of formation of" +"Group</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+dob+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>No. of Members</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+membersdet+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>President</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Secretary</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Treasurer</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Savings of group as on" +"date</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Age of the group as on" +"date</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+age+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Limit Eligible for" +"sanction</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+sanamount+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:14.1pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Limit Sought</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:14.1pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New"+"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'> "+proposedAmt+"</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Purpose of loan</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Onward lending to its individual members as decided by" +"SHG/JLG.</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Security</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Nil</span></span></span></p>"

													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Guarantee: Joint &amp; several liabilities of the group" +"and its members.</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Classification</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Priority Sector: Agriculture-Farm Credit &amp; weaker" +"section.</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Tenure</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Maximum of 35 months.</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Margin &amp; processing" +"charges</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Nil</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Repayment</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>On demand on or before due date, subject to yearly /" +"periodical review by the Bank </span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>ROI</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>14.00% (Fixed)</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Assessment of loan</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Based on the age of the group</span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Maximum loan limit</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Maximum loan sanction limit of Rs.20.00 Lakh per group" +"subject to maximum of Rs.3.00 Lakh per member in respect of SHGs (minimum of 10 members).</span></span></span></p>"

													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>To JLGs (minimum of 5 members), maximum loan of " +"Rs.15.00 Lakh per group subject to maximum of Rs.3.00 Lakh per member. </span></span></span></p>"
													+"</td>"
												+"</tr>"
												+"<tr style='height:13.35pt'>"
													+"<td style='border:solid windowtext 1.0pt; width:166.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='277'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>Pre sanction DDR</span></b></span></span></p>"
													+"</td>"
													+"<td style='border-bottom:solid windowtext 1.0pt; width:179.8pt; border-top:none; border-left:none; border-right:solid windowtext 1.0pt;" +"padding:0cm 5.4pt 0cm 5.4pt; height:13.35pt' valign='top' width='300'>"
													+"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New" +"Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'>No applicable since it is not a part of approved" +"application &amp; documentation booklet a confirmed by credit-sales dept. vide mail dated: 15.03.2023.</span></span></span></p>"
													+"</td>"
												+"</tr>"
											+"</tbody>"
										+"</table>"


											

									
									);////<p>Trustworthy customer</p>");
							arrValues.add("brief");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							
							
							hshQueryValues=new HashMap();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_ratification_comments");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add(
									
							
									"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>Assessment of limit is based on the Age of the Group as mentioned below:</span></span></span></span></p>"

									+"<table class='Table' style='margin-left:5.65pt; border-collapse:collapse; border:solid black 1.0pt' width='525'>"
										+"<tbody>"
											+"<tr style='height:36.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; padding:0cm 5.4pt 0cm 5.4pt; height:36.75pt' width='184'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>Age of the Group</span></span></b></span></span></p>"
												+"</td>"
												+"<td colspan='3' style='border:solid black 1.0pt; width:144.7pt; border-left:none; padding:0cm 5.4pt 0cm 5.4pt; height:36.75pt' width='241'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>Drawing Power</span></span></b></span></span></p>"
												+"</td>"
												+"<td style='border:solid black 1.0pt; width:60.05pt; border-left:none; padding:0cm 5.4pt 0cm 5.4pt; height:36.75pt' width='100'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>Sanction Limit</span></span></b></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>1 Year</span></span></b></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>2 Year</span></span></b></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><b><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>3 year</span></span></b></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='right' style='text-align:right; margin:0cm 0cm 0.0001pt'>&nbsp;</p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>3 months to 1 year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>1.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>3.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>1 year - 2 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>3.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>2 year - 3 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>3 year - 4 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>10.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>4 year - 5 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>5 year - 6 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>6 year - 7 Year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>15.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
											+"<tr style='height:18.75pt'>"
												+"<td style='border:solid black 1.0pt; width:110.25pt; border-top:none; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='184'>"
												+"<p style='margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>&gt; 7 year</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.75pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='81'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>20.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:47.95pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>20.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:48.0pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='80'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>20.00</span></span></span></span></p>"
												+"</td>"
												+"<td style='border-bottom:solid black 1.0pt; width:60.05pt; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0cm 5.4pt 0cm 5.4pt; height:18.75pt' width='100'>"
												+"<p align='center' style='text-align:center; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span style='font-family:&quot;Times New Roman&quot;,serif'><span lang='EN-US' style='font-family:&quot;Book Antiqua&quot;,serif'><span style='color:black'>20.00</span></span></span></span></p>"
												+"</td>"
											+"</tr>"
										+"</tbody>"
									+"</table>"
									+"<p align='justify' class='western' lang='en-US' style='margin-bottom:0in; text-align:left'><span style='font-size:12pt'><span style='background:transparent'><span style='line-height:100%'><span style='font-family:&quot;Times New Roman&quot;,serif'><span style='color:#000000'><span style='orphans:2'><span style='widows:2'><font color='#000000'><font face='Book Antiqua, serif'><u><b>In the instant case:"
									+ "</b></u></font></font></span></span></span></span></span></span></span></p>"

									+"<p align='justify' class='western' lang='en-US' style='margin-bottom:0in; text-align:left'><span style='font-size:12pt'><span style='background:transparent'><span style='line-height:100%'><span style='font-family:&quot;Times New Roman&quot;,serif'><span style='color:#000000'><span style='orphans:2'><span style='widows:2'><font color='#000000'><font face='Book Antiqua, serif'><b>Limit Requested: "
									+ "</b>"+ sanamount +"</font></font><font color='#000000'> </font></span></span></span></span></span></span></span></p>"

									+"<p align='justify' class='western' lang='en-US' style='margin-bottom:0in; text-align:left'><span style='font-size:12pt'><span style='background:transparent'><span style='line-height:100%'><span style='font-family:&quot;Times New Roman&quot;,serif'><span style='color:#000000'><span style='orphans:2'><span style='widows:2'><font color='#000000'><font face='Book Antiqua, serif'><b>Limit Recommended: "
									+ "</b>"+sanamount+"</font></font></span></span></span></span></span></span></span></p>"

									+"<p align='justify' class='western' lang='en-US' style='margin-bottom:0in; text-align:left'><span style='font-size:12pt'><span style='background:transparent'><span style='line-height:100%'><span style='font-family:&quot;Times New Roman&quot;,serif'><span style='color:#000000'><span style='orphans:2'><span style='widows:2'><font color='#000000'><font face='Book Antiqua, serif'><b>Drawing power: "
									+ "</b>"+sanamount+"</font></font></span></span></span></span></span></span></span></p>"

									+"<p>&nbsp;</p>"

											

									
									);////<p>Trustworthy customer</p>");
							arrValues.add("presentproposal");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							
							
							
							hshQueryValues=new HashMap();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_ratification_comments");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add("<p align='justify' class='western' lang='en-US' style='margin-bottom:0in; text-align:left'>"
									+ "<span style='font-size:12pt'><span style='background:transparent'><span style='line-height:100%'>"
									+ "<span new='' roman='' style='font-family:' times=''><span style='color:#000000'><span style='orphans:2'>"
									+ "<span style='widows:2'><font color='#000000'><font size='3'><font style='font-size: 12pt'>"
									+ "<span style='font-weight:normal'>Financing OD facility to Self Help Groups (SHG) and Joint Liability Groups (JLG) under Business Facilitator (BF) &amp; Business Correspondent (BC) Model through </span>"
									+ "</font></font></font><font size='3'><font style='font-size: 12pt'><span style='font-weight:normal'>&ldquo;Shri Kshetra Dharmasthala Rural Development Project BC Trust (R.)&rdquo; (SKDRDP BC Trust).</span></font>"
									+ "</font></span></span></span></span></span></span></span></p>");
							arrValues.add("gist");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							
							
							hshQueryValues=new HashMap();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_ratification_comments");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add("<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span new='' roman='' style='font-family:' times=''><span antiqua='' "+
									"book='' lang='EN-US' style='font-family:'>ROI: 14% (Fixed) p.a. for the said scheme as per the approved scheme guidelines.</span></span></span></p>"+
									"<p style='text-align:justify; margin:0cm 0cm 0.0001pt'><span style='font-size:12pt'><span new='' roman='' sty le='font-family:' times=''><span antiqua=''"+
									 "book='' lang='EN-US' style='font-family:'>Processing Charges: Nil</span></span></span></p>");
							arrValues.add("Management");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							
							//added by madhu
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size", "1");
							hshQuery.put("strQueryId", "del_management");
							arrValues.add("Management");
							arrValues.add("13");
							arrValues.add(strAppno);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							hshQueryValues = new HashMap();
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","ins_management");
							arrValues.add(strAppno);
							arrValues.add("13");				
							arrValues.add(" <div class='WordSection1'>"
						              +"<p align='justify' style='MARGIN:0cm 0cm 0pt'><span style='FONT-FAMILY: '><span style='BACKGROUND-IMAGE:none'><span style='BACKGROUND-REPEAT:repeat'>"
						              + "<span style='BACKGROUND-ATTACHMENT:scroll'><span style='BACKGROUND-POSITION:0% 0%'><span style='COLOR: '>"
						              + "<font style='BACKGROUND-COLOR:#ffffff'><font color='#000000'>"
						             + "<font face='Book Antiqua'>ROI: 14% (Fixed) p.a. for the said scheme as per the approved scheme guidelines.</font></font></font></span></span></span></span></span></span></p>"
						             +"<p align='justify' style='MARGIN:0cm 0cm 0pt'><span style='FONT-FAMILY: '><span style='BACKGROUND-IMAGE:none'><span style='BACKGROUND-REPEAT:repeat'>"
						              + "<span style='BACKGROUND-ATTACHMENT:scroll'><span style='BACKGROUND-POSITION:0% 0%'><span style='COLOR: '><font style='BACKGROUND-COLOR:#ffffff'>"
						                + "<font color='#000000'><font face='Book Antiqua'>Processing Charges: Nil</font></font></font></span></span></span></span></span></span></p>"
						               +"</div>");
							arrValues.add("Management");
							arrValues.add("");
							arrValues.add("");
							
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							//////////////////////logger////////////////////////////////////////
							
							rs=DBUtils.executeLAPSQuery("ins_maxSHGexcelupload");			 
							if(rs.next())
							{
								strid=Helper.correctNull((String)rs.getString(1));
								
								
							}
							
							hshQueryValues= new HashMap();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "ins_maxSHGexceluploadins");
							arrValues = new ArrayList();
							arrValues.add(""+custid);
							arrValues.add(""+strAppno);
							arrValues.add("");//Helper.correctNull((String)arrcoappval.get(1)));//type
							arrValues.add(""+hshValues);
							arrValues.add("Sucess");
							arrValues.add(""+strInwardno);
							arrValues.add("");
							arrValues.add(""+strLAPSid);
							arrValues.add(strid);
							arrValues.add(strUsrid);	
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
							
							
							
							hshQueryValues = new HashMap();
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							hshQuery.put("strQueryId", "del_seccomments");
							arrValues.add(strAppno);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_seccomments");
							arrValues.add(strAppno);//1
							arrValues.add("S");//2
							arrValues.add("");//3
							arrValues.add("S");//4
							arrValues.add("");//5
							arrValues.add("S");//6
							arrValues.add("");//7
							arrValues.add("0");//8
							arrValues.add("");//9
							arrValues.add("");//10
							
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							
							
							
							
						}	
							
						}
					}
				}
				catch(Exception sec)
				{
					sec.printStackTrace();
					throw new EJBException();
				}
					
					hshValues.put("ApplicationNo", strAppno);
					hshValues.put("strResponseCode", "LAPS-000000");
					hshValues.put("strResponseMsg", "Proposal Created Successfully");
					
					
			//}
			
				securitiesflag=true;
				////break;
						}
			
			
			
			
			//////////////////////////securities over ////////////////////
			
			////////////////////////////Coapplicant and guarantor  starts////////////////////////
			
			if (sheet.getSheetName().equalsIgnoreCase("CoApplicant and Guarantor")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("CoApplicant and Guarantor");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
				//while (rowIterator.hasNext())
				//{
				try
				{
					System.out.println("inside CoApplicant and Guarantor Details");
					//Row row = rowIterator.next();
					int intUpdatesize=0;
					final Row row = sheet.getRow(a);
					
					//System.out.println(row.getRowNum());
					if(!( row == null || isEmptyRow(row)))
					{
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
			int memso=0;
			
			
			//memso++;
			//int arrfacLen=facilityDetails.size();
			
			String Appcbsid="";
			Appcbsid=isCorrectNull(row.getCell(0));
			
					for( memso=1;memso<=5;memso++)
					{
						if(row.getCell(memso) != null)
						{
							
							
					
			//Type@Type CBSID@RelationType@RelationShiptoborrower@	
							//CO@999@P@4@
			String CoAppGuaDet=isCorrectNull(row.getCell(memso));
			String[] arrOfStr= CoAppGuaDet.split("@");
			  String Type="",strCBSID="",strLAPSID="",strMemName="",strMemDOB="",strMemPAN="",RelationType="",RelationShiptoborrower="";
			  
			  Type=String.valueOf(arrOfStr[0]);
			  strCBSID=String.valueOf(arrOfStr[1]);
			  RelationType=String.valueOf(arrOfStr[2]);
			  RelationShiptoborrower=String.valueOf(arrOfStr[3]);
			
			String lapsoldID="",lapsID="";
			  strLAPSID="";
			  strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+custid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
					lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
					strLAPSID=lapsID;
				}
						if(lapsoldID.equals(""))
						{
							lapsoldID=strLAPSID;
						}
						
						String strfname="",strlname="",strgender="";
						String CON_COMADDR1="",CON_COMADDR2="",CON_COMCITY="",CON_COMSTATE="",CON_COMZIP="",CON_COMPHONE="",CON_MOBILE="",CON_EMAIL="";
						strQuery=SQLParser.getSqlQuery("sel_cbsIdCreation^"+strLAPSID);
						rs=DBUtils.executeQuery(strQuery);	
						if(rs.next())
						{
							strgender=Helper.correctNull((String)rs.getString("PERAPP_SEX"));
							strfname=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));
							strlname=Helper.correctNull((String)rs.getString("PERAPP_LNAME"));
							CON_COMADDR1=Helper.correctNull((String)rs.getString("CON_COMADDR1"));
							CON_COMADDR2=Helper.correctNull((String)rs.getString("CON_COMADDR2"));
							CON_COMCITY=Helper.correctNull((String)rs.getString("CON_COMCITY"));
							CON_COMSTATE=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
							CON_COMZIP=Helper.correctNull((String)rs.getString("CON_COMZIP"));
							CON_COMPHONE=Helper.correctNull((String)rs.getString("CON_COMPHONE"));
							CON_MOBILE=Helper.correctNull((String)rs.getString("CON_MOBILE"));
							CON_EMAIL=Helper.correctNull((String)rs.getString("CON_EMAIL"));
						}
						
						//Finacle relation type
					/*	String strfinacletype="";
						if(Helper.correctNull((String)arrcoappval.get(1)).equalsIgnoreCase("c"))
						{
							strfinacletype="J";
						}
						else
						{
							strfinacletype=Helper.correctNull((String)arrcoappval.get(1));
						}*/
						
						//hshQueryValues = new HashMap();
						
						 
						
						hshQuery = new HashMap();
						intUpdatesize++;//added
						hshQuery.put("strQueryId", "ins_coapp_digi");
						arrValues = new ArrayList();
						arrValues.add(strAppno);
						arrValues.add(strLAPSID);
						arrValues.add(Type);//Helper.correctNull((String)arrcoappval.get(1)));//type
						arrValues.add(strfname);
						arrValues.add(strlname);
						arrValues.add(CON_COMADDR1);
						arrValues.add(CON_COMADDR2);
						arrValues.add(CON_COMCITY);
						arrValues.add(CON_COMSTATE);
						arrValues.add(CON_COMZIP);
						arrValues.add(CON_MOBILE);
						arrValues.add(CON_COMPHONE);
						arrValues.add(CON_EMAIL);
						arrValues.add(strgender);
						arrValues.add(strLAPSID);//strLAPSIDperapppid);
						arrValues.add(lapsoldID);//strOldid);
						
						arrValues.add(RelationShiptoborrower);
						arrValues.add(RelationType);
						
						//arrValues.add(RelationType);//Helper.correctNull((String)arrcoappval.get(4)));
						//arrValues.add(RelationShiptoborrower);//Helper.correctNull((String)arrcoappval.get(6)));
						arrValues.add("1");//Helper.correctNull((String)arrcoappval.get(7)));
						arrValues.add(Type);//Helper.correctNull((String)arrcoappval.get(1)));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
						
						
					}
				}
					
					}
					}
					
					
						}
				Successflag=true;
				coappguaflag=true;
				////break;
				
			}
				catch(Exception coapp)
				{
					coapp.printStackTrace();
					throw new EJBException();
				}
			}
		//}}

			
////////////////////////////Coapplicant and guarantor  ends////////////////////////
			
			
			
			if (sheet.getSheetName().equalsIgnoreCase("Groups and Management")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("Groups and Management");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
//				while (rowIterator.hasNext())
//				{
				
				try
				{
					System.out.println("inside Groups and Management");
					//Row row = rowIterator.next();
					final Row row = sheet.getRow(a);
					//System.out.println(row.getRowNum());
					if(!( row == null || isEmptyRow(row)))
					{
					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
					{
						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
			int memso=0;
			
			
			//memso++;
			//int arrfacLen=facilityDetails.size();
			
			
					for( memso=1;memso<=5;memso++)
					{
						if(row.getCell(memso) != null)
						{
			String shgmemberinfo=isCorrectNull(row.getCell(memso));
			
			
			
			String[] arrOfStr= shgmemberinfo.split("@");
			  String strCBSID="",strLAPSID="",Concertype="",CTsubtype="",Accountoperated="";
			  String Relationship="",DocuExe="",cheifProm="",PerGuaAval="";
			  //CBS ID@Concertype@CTsubtype@Accountoperated@Relationship@DocuExe@cheifProm@PerGuaAval@
			 // 100@OT@005@Y@PRESIDENT@Y@N@N@
			  
			  strCBSID=String.valueOf(arrOfStr[0]);
			  Concertype=String.valueOf(arrOfStr[1]);
			  CTsubtype=String.valueOf(arrOfStr[2]);
			  Accountoperated=String.valueOf(arrOfStr[3]);
			  Relationship=String.valueOf(arrOfStr[4]);
			  DocuExe=String.valueOf(arrOfStr[5]);
			  cheifProm=String.valueOf(arrOfStr[6]);
			  PerGuaAval=String.valueOf(arrOfStr[7]);
			  
			
			String lapsoldID="",lapsID="";
			  strLAPSID="";
			  strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+custid);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
					lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
					strLAPSID=lapsID;
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				String perapp_fname1="",perapp_cbsid="",CON_MOBILE="",CON_COMADDR1="",CON_COMCITY="";
				String CON_COMDIST="",CON_COMSTATE="",CON_COMZIP="",perapp_id="";
				 strQuery = SQLParser.getSqlQuery("selgroupsmanagementsearch^"+strCBSID);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						
					
						perapp_fname1=Helper.correctNull((String)rs.getString("perapp_fname"));
						perapp_cbsid=Helper.correctNull((String)rs.getString("perapp_cbsid"));
						CON_MOBILE=Helper.correctNull((String)rs.getString("CON_MOBILE"));
						CON_COMADDR1=Helper.correctNull((String)rs.getString("CON_COMADDR1"))+","+Helper.correctNull((String)rs.getString("CON_COMADDR2"));
						CON_COMCITY=Helper.correctNull((String)rs.getString("CON_COMCITY"));
						CON_COMDIST=Helper.correctNull((String)rs.getString("CON_COMDIST"));
						CON_COMSTATE=Helper.correctNull((String)rs.getString("CON_COMSTATE"));
						CON_COMZIP=Helper.correctNull((String)rs.getString("CON_COMZIP"));
						perapp_id=Helper.correctNull((String)rs.getString("perapp_id"));
						
						
						
						
					}
					if(rs!=null)
					{
						rs.close();
					}
				String strsno="";
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				String company_id=correctNull((String)hshValues.get("strLapscustid"));
//				strQuery=("selmaxsdivision^"+company_id);
//				rs=DBUtils.executeLAPSQuery(strQuery);
//				if(rs.next())
//				{
//					strsno=Helper.correctNull((String)rs.getString("snorelmax"));
//				}
				hshQuery.put("strQueryId","insdivisiondetails_new");
				arrValues.add(lapsoldID);
				arrValues.add(""+memso);
				arrValues.add(strLapscustid);//lapsID);//strLapscustid);
				arrValues.add(perapp_fname1);////correctNull((String)hshValues.get("comapp_div_name")));
				arrValues.add(CON_COMADDR1);//correctNull((String)hshValues.get("comapp_div_address")));
				arrValues.add(CON_COMCITY);//correctNull((String)hshValues.get("hid_city")));				
				arrValues.add(CON_COMSTATE);//correctNull((String)hshValues.get("hid_state")));
				arrValues.add(CON_COMZIP);//correctNull((String)hshValues.get("comapp_div_pin")));
				arrValues.add(CON_MOBILE);//correctNull((String)hshValues.get("comapp_div_phone")));
				arrValues.add("");//correctNull((String)hshValues.get("comapp_div_fax")));
				arrValues.add(Concertype);//correctNull((String)hshValues.get("comapp_divisiontype")));
				arrValues.add("");//lapsID);//correctNull((String)hshValues.get("comapp_companyid")));
				arrValues.add(CON_COMDIST);//correctNull((String)hshValues.get("hid_dist")));
				arrValues.add(perapp_id);//strCBSID);//correctNull((String)hshValues.get("comapp_customer_id")));
				arrValues.add("");//correctNull((String)hshValues.get("txt_ratinggrade1")));
				arrValues.add("");//correctNull((String)hshValues.get("txt_ratingdate1")));
				arrValues.add("");//correctNull((String)hshValues.get("rating_type1")));
				arrValues.add("");//correctNull((String)hshValues.get("txt_ratinggrade2")));
				arrValues.add("");//correctNull((String)hshValues.get("txt_ratingdate2")));
				arrValues.add("");//correctNull((String)hshValues.get("rating_type2")));
				arrValues.add("");//correctNull((String)hshValues.get("comapp_banker")));
				arrValues.add(perapp_cbsid);//correctNull((String)hshValues.get("comapp_cbsid")));
				arrValues.add(Relationship);//correctNull((String)hshValues.get("txt_relation")));
				arrValues.add(CTsubtype);//correctNull((String)hshValues.get("comapp_divisionSubtype")));
				arrValues.add(DocuExe);//correctNull((String)hshValues.get("sel_docexecutant")));
				arrValues.add(Accountoperated);//correctNull((String)hshValues.get("selaccoperby")));//Added By Sathish
				arrValues.add("");//correctNull((String)hshValues.get("txt_DINnumber"))); 
				arrValues.add(cheifProm);//correctNull((String)hshValues.get("sel_chf_promoter")));
				arrValues.add(PerGuaAval);//correctNull((String)hshValues.get("sel_personal_guarantee")));
				arrValues.add("");//correctNull((String)hshValues.get("sel_chk_npa"))); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				
					}
					}
					
					
						}
						}
									}
				//shgmemflag=true;s
				//break;	

				}
				catch(Exception gm)
				{
					gm.printStackTrace();
					throw new EJBException();
				}
			}
			
			
			
			
			///////////////////////Result///////////////////////////////
			
			
			if (sheet.getSheetName().equalsIgnoreCase("Result")) 
			{
				int index = 0;
				sheetNo = wb.getSheetIndex("Result");
				Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
//				while (rowIterator.hasNext())
//				{
				
				try
				{
					System.out.println("inside Result");
					//Row row = rowIterator.next();
					//final Row row = sheet.getRow(a);
					 String filename = ApplicationParams.getSHGFILE_RESDOWNLOAD();//"E:/SHG_RESPONSE"; 
					 
//					 if(spreadsheet.getSheetName().equalsIgnoreCase("Response"))
//					 {
//					 }
					 
					Row row = sheet.createRow(a);
					Row rowNew= spreadsheet.createRow(a);
					//System.out.println(row.getRowNum());
					//if(!( row == null || isEmptyRow(row)))
					//{
					if (row.getRowNum() > 1 && row.getRowNum() < 12) 
					{
						if ( row.getRowNum()<=PhysicalNumberOfRows)
								//row.getSheet().getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
						{
			
						row.createCell(1).setCellValue(custid);
						row.createCell(2).setCellValue(strAppno);
						row.createCell(3).setCellValue("Successfully created");
						row.createCell(4).setCellValue("");
//creating the 0th row using the createRow() method 
// HSSFRow rowhead = sheet.createRow((short)0);  
//creating cell by using the createCell() method and setting the values to the cell by using the setCellValue() method  rowhead.createCell(0).setCellValue("S.No.");  
						rowNew.createCell(1).setCellValue(custid);
						rowNew.createCell(2).setCellValue(strAppno);
						rowNew.createCell(3).setCellValue("Successfully created");
						rowNew.createCell(4).setCellValue("");
			 
			 
//FileOutputStream fileOut = new FileOutputStream(filename);  


if(!filename.equalsIgnoreCase(""))
{
	File foldername = null;
	
	foldername=new File(filename);
	if(!foldername.exists())
	{
		foldername.mkdirs();
	}
	// fileOut = new FileOutputStream(filename+"/SHGRESPONSE"+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
	//hshresult.put("workbook",wb);
	//hshValues.put("FileDownload",filename+"/SHGRESPONSE"+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
	//hshValues.put("FileName","SHGRESPONSE"+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
	//hshValues.put("strFinancialDn","N");
	//workbook.write(fileOut); 
	
	
	 String strFileName=filename+"/SHGRESPONSE"+"_"+Helper.getCurrentDateTime().replace("/", "")+"_"+Helper.getCurrentDateandTime()+".xls";	
	  FileOutputStream fout=new FileOutputStream(strFileName);
	  workbook.write(fout);
	  String strmsg="";
	  strmsg="SHG Response data is Successfully exported to Excel!";
	  hshValues.put("msg",strmsg);
	  hshValues.put("FileDownload",strFileName);
	  fout.close();
	
	
}

			
					
						}
						else
						{
						}
						}
						//}
									//}
				//shgmemflag=true;s
				//break;	

				}
				catch(Exception gm)
				{
					gm.printStackTrace();
					throw new EJBException();
			}
			}
			
			////////////////////////////////////////////////////
			
			
			//logger
			
			//String strid="";
			
			
		///////
			
			
//			if(Successflag)
//			{
//			 
//			  
//		        // spreadsheet object
//		        XSSFSheet spreadsheet
//		            = (XSSFSheet) wb.getSheet("Demographics");
//		  
//		        // creating a row object
//		        
//		        Iterator<Row> rowIterator = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
//				
//					System.out.println("inside demographics");
//					Row row = rowIterator.next();
//					
//		        Cell cell = row.createCell(14);
//                cell.setCellValue("Completed");
//                 cell = row.createCell(15);
//                cell.setCellValue(strAppno);
//                
//              wb.write(); 
//              
//              
//			}
                
			if(demoflag && shgmemflag && facilitiesflag && securitiesflag &&coappguaflag)
				{
//                if (sheet.getSheetName().equalsIgnoreCase("Result")) 
//    			{
//    				int index = 0;
//    				sheetNo = wb.getSheetIndex("Result");
//    				Iterator<Row> rowIterator1 = ((XSSFSheet) sheet).iterator();        // Iterate through each rows one by one
//    				while (rowIterator1.hasNext())
//    				{
//    					System.out.println("*********************Final******************************");
//    					Row row1 = rowIterator.next();
//    					System.out.println(row.getRowNum());
//    					if (row.getRowNum() > 1 && row.getRowNum() < 50) 
//    					{
//    						if (row.getCell(0) != null && row.getCell(0).getCellType() != Cell.CELL_TYPE_BLANK) 
//    						{
//    						}
//    					}
//    				}
//    			}
                
    						}
                
                
                
                
                
                
			
		//}
		}	
		}
		
	}
						catch(Exception e)
						{
							
							e.printStackTrace();
							//String strid="";
							
							try {
								rs=DBUtils.executeLAPSQuery("ins_maxSHGexcelupload");
							} catch (Exception e3) {
								// TODO Auto-generated catch block
								e3.printStackTrace();
							}			 
							try {
								if(rs.next())
								{
									strid=Helper.correctNull((String)rs.getString(1));
									
									
								}
							} catch (SQLException e2) {
								// TODO Auto-generated catch block
								e2.printStackTrace();
							}
							String strquaryId=(String) hshQuery.get("strQueryId");
                           System.out.println(strquaryId);
							hshQueryValues= new HashMap();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "ins_maxSHGexceluploadins");
							ArrayList arrValues = new ArrayList();
							arrValues.add(""+custid);
							arrValues.add(""+strAppno);
							arrValues.add("");//byteData);//Helper.correctNull((String)arrcoappval.get(1)));//type
							arrValues.add(""+hshValues);
							arrValues.add("Failure--->"+e.toString());
							arrValues.add(""+strInwardno);
							arrValues.add("");
							arrValues.add(""+strLAPSid);
							arrValues.add(strid);
							arrValues.add(strUsrid);	
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							
							hshQueryValues.put("size", "1");
							try {
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
							} catch (Exception e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							}
							
	throw new EJBException("Error closing the connection " + e.getMessage());
						}
	
	finally
	{
		//workbook.close();
		//fileOut.flush();
		//fileOut.close();
	}

					
					return hshValues;
}
					
					private boolean isEmptyRow(Row row) {
	// TODO Auto-generated method stub
	return false;
}

					public static String lovSplit(Cell cellValue, boolean mflag) throws IllegalAccessException {
						String value = "";
						String[] values = new String[2];
						if (cellValue != null && cellValue.getCellType() == Cell.CELL_TYPE_STRING
								&& cellValue.getStringCellValue().contains("-")) {
							values = cellValue.getStringCellValue().split("-");
							value = values[0];
						} else if (mflag) {
							if (cellValue != null) {
								int row = cellValue.getRowIndex() - 2;
								errorStatus = "Invalid LOV at sheet Name:" + wb.getSheetName(sheetNo) + ",Row id: " + row
										+ " ,Column Name: " + wb.getSheetAt(sheetNo).getRow(1).getCell(cellValue.getColumnIndex())
												.getStringCellValue();
								status = "unsucessfull";
								errorHandle();
							} else {
								status = "unsucessfull";
								errorStatus = "sheet Name:" + wb.getSheetName(sheetNo) + "contains empty mandatory column";
								errorHandle();
							}
						}
						return value;
					}
					
					public static String lovSplitDesc(Cell cellValue, boolean mflag) throws IllegalAccessException {
						String value = "";
						String[] values = new String[2];
						if (cellValue != null && cellValue.getCellType() == Cell.CELL_TYPE_STRING
								&& cellValue.getStringCellValue().contains("-")) {
							values = cellValue.getStringCellValue().split("-");
							value = values[1];
						} else if (mflag) {
							if (cellValue != null) {
								int row = cellValue.getRowIndex() - 2;
								errorStatus = "Invalid LOV at sheet Name:" + wb.getSheetName(sheetNo) + ",Row id: " + row
										+ " ,Column Name: " + wb.getSheetAt(sheetNo).getRow(1).getCell(cellValue.getColumnIndex())
												.getStringCellValue();
								status = "unsucessfull";
								errorHandle();
							} else {
								status = "unsucessfull";
								errorStatus = "sheet Name:" + wb.getSheetName(sheetNo) + "contains empty mandatory column";
								errorHandle();
							}
						}
						return value;
					}
					
					public static void errorHandle() throws IllegalAccessException {

						System.err.println(errorStatus);

						throw new IllegalAccessException(errorStatus);

					}
					
					public String isNumericCell(Cell cellValue) throws IllegalAccessException {
						String value = "";

						if (cellValue == null || cellValue.getCellType() == Cell.CELL_TYPE_BLANK
								|| cellValue.getCellType() != Cell.CELL_TYPE_NUMERIC) {
							int row = cellValue.getRowIndex() - 2;
							errorStatus = "Error at sheet Name:" + wb.getSheetName(sheetNo) + ":Row id " + row + "Column Name"
									+ wb.getSheetAt(sheetNo).getRow(2).getCell(cellValue.getColumnIndex()).getStringCellValue();

							status = "unsucessfull";
							errorHandle();
						} else {
							value = new DataFormatter().formatCellValue(cellValue);
						}
						return value;
					}

					public static String isStringCell(Cell cellValue) throws IllegalAccessException {
						String value = "";
						if (cellValue == null || cellValue.getCellType() == Cell.CELL_TYPE_BLANK
								|| cellValue.getCellType() != Cell.CELL_TYPE_STRING) {
							if (cellValue != null) {
								int row = cellValue.getRowIndex() - 1;
								errorStatus = "Invalid data at sheet Name:" + wb.getSheetName(sheetNo) + ",Row id: " + row
										+ " ,Column Name: " + wb.getSheetAt(sheetNo).getRow(1).getCell(cellValue.getColumnIndex())
												.getStringCellValue();
								status = "unsucessfull";
								errorHandle();
							} else {
								status = "unsucessfull";
								errorStatus = "sheet Name:" + wb.getSheetName(sheetNo) + "contains empty mandatory column";
								errorHandle();
							}
						} else {
							value = cellValue.getStringCellValue();
						}
						return value;
					}

					public static Date isDateCell(Cell cellValue) throws IllegalAccessException {
						Date value = null;
						if (cellValue != null && cellValue.getCellType() != Cell.CELL_TYPE_BLANK
								&& HSSFDateUtil.isCellDateFormatted(cellValue)) {
							value = cellValue.getDateCellValue();
						} else {
							if (cellValue != null) {
								int row = cellValue.getRowIndex() - 2;
								errorStatus = "Invalid data at sheet Name:" + wb.getSheetName(sheetNo) + ",Row id: " + row
										+ " ,Column Name: " + wb.getSheetAt(sheetNo).getRow(2).getCell(cellValue.getColumnIndex())
												.getStringCellValue();
								status = "unsucessfull";
								errorHandle();
							} else {
								status = "unsucessfull";
								errorStatus = "sheet Name:" + wb.getSheetName(sheetNo) + "contains empty mandatory column";
								errorHandle();
							}
						}
						return value;
					}
					
					public static String isCorrectNumericCell(Cell cellValue) {
						return cellValue != null && cellValue.getCellType() == Cell.CELL_TYPE_NUMERIC
								? new DataFormatter().formatCellValue(cellValue) : "";
					}
					
					public static String isCorrectNull(Cell cellValue) {

						return cellValue != null && cellValue.getCellType() == Cell.CELL_TYPE_STRING ? cellValue.getStringCellValue()
								: "";

					}

					public static Date isCorrectDate(Cell cellValue) {
						return cellValue != null && HSSFDateUtil.isCellDateFormatted(cellValue) ? cellValue.getDateCellValue() : null;
					}
					
					public HashMap updateLapsDatabase(HashMap hshValues, String action) throws EJBException 
					{
						HashMap hshQueryValues = new HashMap();
						
						ArrayList arrValues = new ArrayList();
						ResultSet rs = null;
						ResultSet rs1 = null;
						ResultSet rs2 = null;
						
						HashMap hshQuery = new HashMap();//For Perapplicant table
						HashMap hshIndQuery=new HashMap();//For Individual_Info table
						HashMap hshKycQuery=new HashMap();//For applicant_kyc table
						HashMap hshConQuery=new HashMap();//For cust_contactinfo table
						HashMap hshEmpQuery=new HashMap();//For peremployer table
						HashMap hshNRIQuery=new HashMap();//For perapplicant_nri table

						
						
						
						String strQuery = "";
						String strQuery1="";
						String  prefix = "", fname = "", lname = "",strSolid="";
						String strdob = "", strsex = "", strMarital = "", strEmail = "", strReligion = "", strLocation = "";
						String strPresentAdr1 = "",strPresentAdr2="",strPresentCity = "", strPresentZip = "", strPresentState = "", strPresentPho = "";
						String strPerAdrs1 = "",strPerAdrs2="",strPerCity = "";
						String strPerPin = "", strPerState = "", strPresentPho2="";
						
						String strCaste= "",strEmpStatus="",strResidentialStatus="",
						strPassportNo= "",strPassportIssDate= "",strPassportExpDate="",strPassportIssuedBy="",strPanno="",
						strIntroducerName= "",strIntroducerId= "";
						String strAccount_Opening_Year="";
						String strSel_add1="",strSel_add2="";
						String strSel_City="";
						String strSel_state="";
						String strSel_pin="";
						String strSel_country="";
						String strCustConstitution="",strTDSTableCode="",strCustStatusCode="",
						strIDProof="",strAdrsProof1="",strAdrsProof2="",strStaffYN="",strCustEmpID="",
						strCustIntrostatus="",strCustIntroID="",strIntroEmpID="",strIntroTitleCode="",
						strCustIntroName="",strIntroAdrs="",strCustOccCode="", strCustConstitutionNew="";
						
						String strTradeFinance="",strTradeAllowed="",strIsStaff="",strIsMinor="",strPresentCountry="";
						String strPerCountry="",strPresentFax="",strPerFax="",strPerPho="",strPerEmail="";
						String strEmployerZip="",strEmployerState="",strEmployerAdr1="",strEmployerAdr2="",strEmployerCity="";
						String strEmployerPho1="",strEmployerFax="",strEmployerEmail="",strEmployerNo="",strFatherName="";
						String strEducationQua="",strSpouseName="",strSpouseOccupation="",strSpouseQua="",strSpouseAdd1="";
						String strSpouseAdd2="",strCusIDProof="",strCusIDRef="",strCusRating="",strGuarName="";
						String strGuarCode="",strGuarAddr1="",strGuarAddr2="",strGuarCity="",strGuarState="";
						String strGuarPincode="",strGuarCountry="",strNRICountry="",strIntroducerStatus="";
						String strPassportNumber="",strLAPSIntroducerType="",strComGroupId="",strAadharNo="",defid="",cus_def_id="";
						
						Connection connectDB	= null;
						CallableStatement callableStmt = null;
						String strNewFinID="";
						String strOldFinID="";
						
						ArrayList arryRow = new ArrayList();
						ArrayList arryCol = new ArrayList();
						
						ArrayList arrIndValues=new ArrayList();//For Individual_Info table
						ArrayList arrKycValues=new ArrayList();//For applicant_kyc table
						ArrayList arrConValues=new ArrayList();//For cust_contactinfo table
						ArrayList arrEmpValues=new ArrayList();//For peremployer table
						ArrayList arrNRIValues=new ArrayList();//For perapplicant_nri table
						int querycount=0;

						String strLapsCustId="";

						String diffyears="";

						
						try 
						{
							// For Getting the Applicant Details From CBS
							int count=0;
							int NRICount=0;
							String strcustid = Helper.correctNull((String) hshValues.get("custid"));
							String strLapscustid=Helper.correctNull((String) hshValues.get("strLapscustid"));
							String strDedupeFlag="",lapsoldID="",lapsID="";
							if(!strcustid.equals(""))
							{
								strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strcustid);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strDedupeFlag="Y";
									lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
									lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
								}
							}
							
							
							
									
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
									arrValues.add("y");
									arrValues.add(lapsID);
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strQueryId","perapplicantupdaterenew");
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
								}
								else
								{
									stroldLAPSid=strNewLAPSid;
									strRenewFlag="";
									lapsID=strNewLAPSid;
									strLapscustid=strNewLAPSid;
								}
								
								if(strLapscustid.equalsIgnoreCase(""))
								{
								strLapscustid=strNewLAPSid;
								if(strDedupeFlag.equals("Y"))
								{
								stroldLAPSid=lapsoldID;
								}
								else
								{
									lapsoldID=strNewLAPSid;
								}
								}
								
								hshValues.put("strLapscustid",strNewLAPSid);
								
								
								/////////////open pending check status check ////////////////////
								
								strLapsCustId=lapsID;
								
								boolean boolappstatus=false;
								if(rs!=null)
									rs.close();
								rs=DBUtils.executeLAPSQuery("checkapplicantstatuspershgop^"+strLapsCustId);				 
								if(rs.next())
								{
									boolappstatus=true;
								}
								
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corpshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp_cooappshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("sel_processAppl_solvency_newidshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("sel_processAppl_bankers_newidshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("sel_processAppl_kpower_newidshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								if(!boolappstatus)
								{
									if(rs!=null)
										rs.close();
									rs=DBUtils.executeLAPSQuery("sel_processApplmsmenewidshgop^"+strLapsCustId);				 
									if(rs.next())
									{
										boolappstatus=true;
									}
								}
								
								
								
					
								
								//////////////////////////////////
								
								
							if(!strcustid.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("sel_nrioverseasdetails^"+ strLapscustid);
								if(rs!=null)
								{
									rs.close();
								}
								rs=DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									NRICount=1;
								}
								
								if(rs!=null)
								{
									rs.close();
								}
								if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
								{
									strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strcustid);
									rs=DBUtils.executeQueryCBSConnection(strQuery);
								}
								else
								{
									strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strcustid);
									rs=DBUtils.executeQuery(strQuery); 
								}
								if (rs.next()) {
									count++;
									
									/*
									 * The following details are related to perapplicant table
									 */
									
									diffyears= Helper.correctNull(rs.getString("years"))+"~"+"0";//done
									strSolid= Helper.correctNull(rs.getString("solid"));//done
									prefix = Helper.correctNull(rs.getString("cust_title_code"));//done
									fname = (String) Helper.correctNull(rs.getString("cust_name"));//done
									lname = (String) Helper.correctNull(rs.getString("cust_short_name"));//done
									strCustConstitutionNew = (String) Helper.correctNull(rs.getString("cust_const"));//done
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									if(strCustConstitution.trim().equalsIgnoreCase("01")||
											strCustConstitution.trim().equalsIgnoreCase("02"))
									{
										strdob = (String) Helper.correctNull(rs.getString("date_of_birth")).trim();//done
									}
									else
									{
										strdob = (String) Helper.correctNull(rs.getString("dateof_est")).trim();//done
									}
									strsex = (String) Helper.correctNull(rs.getString("cust_sex"));//done
									strMarital = (String) Helper.correctNull(rs.getString("cust_marital_status"));//done
									strPanno = (String) Helper.correctNull(rs.getString("pan_gir_num"));//done
									if(strPanno.equalsIgnoreCase(""))
									{
										strPanno="NOPAN";
									}
									strIntroducerName = (String) Helper.correctNull(rs.getString("cust_introd_name"));//done
									strTradeFinance=(String) Helper.correctNull(rs.getString("party_flg"));//Trade Finance
									strTradeAllowed=(String) Helper.correctNull(rs.getString("inland_trade_allowed"));//Whether Trade Allowed
									strTDSTableCode = (String) Helper.correctNull(rs.getString("tds_tbl_code"));// tax slab done
									strFatherName = (String) Helper.correctNull(rs.getString("father_name"));//Father Name
									strCustStatusCode = (String) Helper.correctNull(rs.getString("cust_stat_code"));//done
									strIntroducerStatus=(String) Helper.correctNull(rs.getString("cust_introd_stat_code"));// Introducer status

									
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^6^"+strIntroducerStatus);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strLAPSIntroducerType=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									
									
									/*
									 * The following details are related to INDIVIDUAL_INFO table
									 */
									
									strCaste =(String) Helper.correctNull(rs.getString("cust_caste_code"));//done
									strReligion = (String) Helper.correctNull(rs.getString("cust_commu_code"));//done
									strResidentialStatus = (String) Helper.correctNull(rs.getString("cust_nre_flg")); //done
									strPassportNumber=(String) Helper.correctNull(rs.getString("psprt_num")); //done
									strPassportIssDate=(String) Helper.correctNull(rs.getString("psprt_issu_date"));
									strPassportExpDate=(String) Helper.correctNull(rs.getString("psprt_exp_date"));
									
									strIsStaff=(String) Helper.correctNull(rs.getString("cust_type_code"));//To identify whether staff
									if(!strIsStaff.equalsIgnoreCase("02") && !strIsStaff.equalsIgnoreCase("03"))
									{
										strIsStaff="01";
									}
									strIsMinor=(String) Helper.correctNull(rs.getString("cust_minor_flg"));//To identify minor
									strCustEmpID = (String) Helper.correctNull(rs.getString("cust_emp_id"));//done
									strEducationQua =(String) Helper.correctNull(rs.getString("ed_qualification"));//Education qualification
									strSpouseName = (String) Helper.correctNull(rs.getString("spouse_name"));//Spouse Name
									strSpouseOccupation = (String) Helper.correctNull(rs.getString("spouse_occup"));//Spouse Occupation
									strSpouseQua = (String) Helper.correctNull(rs.getString("spouse_qualif"));//Spouse Qualification
									strSpouseAdd1= (String) Helper.correctNull(rs.getString("spouse_addr_1"));//Spouse Address
									strSpouseAdd2 = (String) Helper.correctNull(rs.getString("spouse_addr_2"));//Spouse Address
									strGuarName = (String) Helper.correctNull(rs.getString("minor_guard_name"));//Guardian Name
									strGuarCode = (String) Helper.correctNull(rs.getString("minor_guard_code"));//Guardian Code
									strGuarAddr1 = (String) Helper.correctNull(rs.getString("minor_guard_addr1"));//Guardian Address1
									strGuarAddr2 = (String) Helper.correctNull(rs.getString("minor_guard_addr2"));//Guardian Address2
									strGuarCity = (String) Helper.correctNull(rs.getString("minor_guard_city_code"));//Guardian City
									if(!strGuarCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strGuarCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarCity=Helper.correctNull((String)rs1.getString("city_name"));
										}
									}
									strGuarState = (String) Helper.correctNull(rs.getString("minor_guard_state_code"));//Guardian State
									if(!strGuarState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strGuarState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarState=Helper.correctNull((String)rs1.getString("state_name"));
										}
									}
									strGuarPincode = (String) Helper.correctNull(rs.getString("minor_guard_pin_code"));//Guardian Zip
									strGuarCountry = (String) Helper.correctNull(rs.getString("minor_guard_cntry_code"));//Guardian Country
									if(!strGuarCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strGuarCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}
									strNRICountry = (String) Helper.correctNull(rs.getString("nre_nationality"));//Country code if the customer is NRI
									if(!strNRICountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strNRICountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strNRICountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}
									/* KBL doesn't provide the view for the following
									 * 
									 * strLocation = (String) Helper.correctNull(rs.getString("br_code"));  
									strPassportNo = (String) Helper.correctNull(rs.getString("psprt_num"));
									strPassportIssDate =(String) Helper.correctNull(rs.getString("psprt_issu_date"));
									strPassportExpDate =(String) Helper.correctNull(rs.getString("psprt_exp_date"));
									strPassportIssuedBy =(String) Helper.correctNull(rs.getString("psprt_issuedby"));
									
									strIntroducerId = (String) Helper.correctNull(rs.getString("cust_introducer_id"));//modified at datacenter
									*/
									
									/*
									 * The following details related to CUST_CONTACTINFO Table
									 */
									
									strPresentAdr1 = (String) Helper.correctNull(rs.getString("cust_comu_addr1"));//done
									strPresentAdr2=(String) Helper.correctNull(rs.getString("cust_comu_addr2"));//done
									strPresentCity = (String) Helper.correctNull(rs.getString("cust_comu_city_code"));//done
									if(!strPresentCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPresentCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentCity=Helper.correctNull(rs1.getString("city_code"));
										}
										else
										{
											strPresentCity="";
										}
									}
									strPresentZip = (String) Helper.correctNull(rs.getString("cust_comu_pin_code"));//done
									strPresentState = (String) Helper.correctNull(rs.getString("cust_comu_state_code"));//done
									if(!strPresentState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPresentState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentState=Helper.correctNull(rs1.getString("state_code"));
										}
										else
										{
											strPresentState="";
										}
									}
									strPresentCountry =(String) Helper.correctNull(rs.getString("cust_comu_cntry_code"));//Communication Country Code
									/*if(!strPresentCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPresentCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}*/
									strPresentFax =(String) Helper.correctNull(rs.getString("cust_comu_telex_num"));//Communication Fax No.
									strPresentPho = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_1"));//done
									strPresentPho2 = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_2"));//done
									strEmail = (String) Helper.correctNull(rs.getString("email_id"));//done

									
									/////hshValreq.put("distcode"////
									
									
									strPerAdrs1 = (String) Helper.correctNull(rs.getString("cust_perm_addr1"));//done
									strPerAdrs2=(String) Helper.correctNull(rs.getString("cust_perm_addr2"));//done
									strPerCity = (String) Helper.correctNull(rs.getString("cust_perm_city_code"));//done
									if(!strPerCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPerCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerCity=Helper.correctNull((String)rs1.getString("city_code"));
										}
										else
										{
											strPerCity="";
										}
									}
									strPerPin = (String) Helper.correctNull(rs.getString("cust_perm_pin_code"));//done
									strPerState = (String) Helper.correctNull(rs.getString("cust_perm_state_code")); //done
									if(!strPerState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPerState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerState=Helper.correctNull((String)rs1.getString("state_code"));
										}
										else
										{
											strPerState="";
										}
									}
									strPerCountry =(String) Helper.correctNull(rs.getString("cust_perm_cntry_code")); //Permanent country code
									/*if(!strPerCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPerCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}*/
									strPerFax =(String) Helper.correctNull(rs.getString("cust_perm_telex_num"));//Communication Fax No.
									strPerPho = (String) Helper.correctNull(rs.getString("cust_perm_phone_num"));//Permanent phone no.
									strPerEmail=(String) Helper.correctNull(rs.getString("cust_perm_email_id"));//Permanent Email id
									
									
									if(strPresentAdr1.equalsIgnoreCase(strPerAdrs1))
									{
										strSel_add1="1";
									}
									else
									{
										strSel_add1="2";
									}
									if(strPresentAdr2.equalsIgnoreCase(strPerAdrs2))
									{
										strSel_add2="1";
									}
									else
									{
										strSel_add2="2";
									}
									if(strPresentCity.equalsIgnoreCase(strPerCity))
									{
										strSel_City="1";
									}
									else
									{
										strSel_City="2";
									}
									if(strPresentZip.equalsIgnoreCase(strPerPin))
									{
										strSel_pin="1";
									}
									else
									{
										strSel_pin="2";
									}
									if(strPresentState.equalsIgnoreCase(strPerState))
									{
										strSel_state="1";
									}
									else
									{
										strSel_state="2";
									}
									if(strPresentCountry.equalsIgnoreCase(strPerCountry))
									{
										strSel_country="1";
									}
									else
									{
										strSel_country="2";
									}
									
									/*
									 * The following details related to PEREMPLOYER table
									 */
									
									strEmployerAdr1 = (String) Helper.correctNull(rs.getString("cust_emp_addr1"));//Employer company address
									strEmployerAdr2=(String) Helper.correctNull(rs.getString("cust_emp_addr2"));//Employer company address
									strEmployerCity = (String) Helper.correctNull(rs.getString("cust_emp_city_code"));//Employer company city
									/*if(!strEmployerCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strEmployerCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strEmployerCity=Helper.correctNull((String)rs1.getString("city_name"));
										}
									}*/
									strEmployerZip = (String) Helper.correctNull(rs.getString("cust_emp_pin_code"));//Employer company zip
									strEmployerState = (String) Helper.correctNull(rs.getString("cust_emp_state_code"));//Employer company state
									/*if(!strEmployerState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strEmployerState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strEmployerState=Helper.correctNull((String)rs1.getString("state_name"));
										}
									}*/
									strEmployerPho1 = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_1"));//Employer company phone1
									strEmployerFax = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_2"));//Employer company Fax No
									strEmployerEmail = (String) Helper.correctNull(rs.getString("cust_emp_email_id"));//Employer company Email id
									strEmployerNo = (String) Helper.correctNull(rs.getString("cust_employee_no"));//Employee Number
									
									/*
									 * The following details related to APPLICANT_KYCNORMS table
									 */
									strCustOccCode = (String) Helper.correctNull(rs.getString("cust_occp_code"));//done
									strCusIDProof = (String) Helper.correctNull(rs.getString("id_doc")); // ID proof of the customer
									strCusIDRef=(String) Helper.correctNull(rs.getString("id_number"));//ID Refernce number of the customer proof
									strCusRating=(String) Helper.correctNull(rs.getString("riskrating"));//Rating of the customer
								


							
									
									/*KBL doesn't provide the view for the following
									 * 
									 * strIDProof = (String) Helper.correctNull(rs.getString("ID_PROOF"));
									strAdrsProof1 = (String) Helper.correctNull(rs.getString("ADDR_PROOF1"));
									strAdrsProof2 = (String) Helper.correctNull(rs.getString("ADDR_PROOF2"));
									strStaffYN = (String) Helper.correctNull(rs.getString("STAFF_YN"));
									if(strStaffYN.trim().equals(""))
										strStaffYN="0";
									
									strCustIntrostatus  = (String) Helper.correctNull(rs.getString("CUST_INTROD_STAT_CODE"));
									strCustIntroID = (String) Helper.correctNull(rs.getString("CUST_INTROD_CUST_ID"));
									strIntroEmpID = (String) Helper.correctNull(rs.getString("INTROD_EMP_ID"));
									strIntroTitleCode = (String) Helper.correctNull(rs.getString("INTROD_TITLE_CODE"));
									strCustIntroName = (String) Helper.correctNull(rs.getString("CUST_INTROD_NAME"));
									strIntroAdrs = (String) Helper.correctNull(rs.getString("INTRO_ADDRESS"));
									 
									strAccount_Opening_Year=(String) Helper.correctNull(rs.getString("acct_opn_year")); 
									*/
									
									/*
									 * The group id value related to COMPANY_INFO table
									 */
									
									strComGroupId= Helper.correctNull(rs.getString("cust_grp"));//Rating of the customer
									strAadharNo= Helper.correctNull(rs.getString("nat_id_card_num"));//Rating of the customer
								}
								if(count !=0)
								{
									// For Updating the values to LAPS DATABASE
									hshQueryValues = new HashMap();
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									if (action.equalsIgnoreCase("Update")) 
									{
										if(rs!=null)
										{
											rs.close();
										}
										rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+strLapscustid);				 
										if(rs.next())
										{
											//No update if the borrower has processed approved/processed closed application
											hshValues.put("arryRow", arryRow);
											return hshValues;
										}
										else
										{
											if (action.equalsIgnoreCase("Update")) 
											{
												if(rs!=null)
												{
													rs.close();
												}
												rs=DBUtils.executeLAPSQuery("sel_genderdet^"+strLapscustid);				 
												if(rs.next())
												{
													if(strCustConstitution.trim().equalsIgnoreCase("01")||
															strCustConstitution.trim().equalsIgnoreCase("02"))
													{
														if(!Helper.correctNull(rs.getString("perapp_sex")).equalsIgnoreCase(strsex)||!Helper.correctNull(rs.getString("indinfo_caste")).equalsIgnoreCase(strCaste))
														{
															hshQuery = new HashMap();
															arrValues=new ArrayList();
															arrValues.add(strLapscustid);
															arrValues.add(strLapscustid);
															hshQuery.put("strQueryId","upd_misreselectflag"); 
															hshQuery.put("arrValues",arrValues); 
															hshQueryValues.put("1",hshQuery);
															hshQueryValues.put("size","1");
															EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
															
															
															hshQueryValues = new HashMap();
															hshQuery = new HashMap();
															arrValues = new ArrayList();
														}
													}
												}
											}
											
											
											hshQuery.put("strQueryId", "perapplicant_updatecbsdataSHG");
											hshIndQuery.put("strQueryId", "perindividual_updatecbsdata");
											hshConQuery.put("strQueryId", "percontact_updatecbsdataSHG");
											hshKycQuery.put("strQueryId", "perkyc_updatecbsdataSHG");
											//hshEmpQuery.put("strQueryId", "peremployer_updatecbsdata");
											if(strResidentialStatus.equalsIgnoreCase("Y"))
											{
												if(NRICount==0)
												{
													hshNRIQuery.put("strQueryId", "perapplicant_insertnridet1");
												}
												else
												{
													hshNRIQuery.put("strQueryId", "perapplicant_updatenridet");
												}
											}

										}
									}
									else if (action.equalsIgnoreCase("Insert")) 
									{				
										hshQuery.put("strQueryId", "perapplicant_insertcbsdataSHG");
										hshIndQuery.put("strQueryId", "perindividual_insertcbsdata");
										hshConQuery.put("strQueryId", "percontact_insertcbsdataSHG");
										hshKycQuery.put("strQueryId", "perkyc_insertcbsdataSHG");
										//hshEmpQuery.put("strQueryId", "peremployer_insertcbsdata");
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										hshNRIQuery.put("strQueryId", "perapplicant_insertnridet");
										
										arrValues.add(Helper.correctNull((String) strLapscustid));//0
										arrValues.add(lapsoldID);//1
										arrValues.add(strcustid);//2
										arrValues.add("C");//P");//3
										arrValues.add("Y");//4
										arrIndValues.add(strLapscustid);//0
										arrConValues.add(strLapscustid);//0
										arrConValues.add("P");//1
										arrKycValues.add(strLapscustid);//0
										arrKycValues.add("P");//1
										arrEmpValues.add(strLapscustid);
										arrEmpValues.add("P");
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										arrNRIValues.add(strLapscustid);
									}
									
									/*
									 * Values for the table perapplicant
									 */
									
									arrValues.add(Helper.correctNull((String)prefix));//5
									arrValues.add(Helper.correctNull((String)fname));//6
									arrValues.add(Helper.correctNull((String)lname));//7
									arrValues.add(Helper.correctNull((String)strdob));//8
									hshValues.put("strdob",strdob);
									arrValues.add(Helper.correctNull((String)strsex));//9
									arrValues.add(Helper.correctNull((String)strMarital));//10
									arrValues.add(Helper.correctNull((String)strPanno));//11
									arrValues.add(Helper.correctNull((String)strIntroducerName));//12
									arrValues.add(Helper.correctNull((String)strTradeFinance));//13
									arrValues.add(Helper.correctNull((String)strTradeAllowed));//14
									arrValues.add(Helper.correctNull((String)strCustConstitution));//15
									arrValues.add(Helper.correctNull((String)strTDSTableCode));//16
									arrValues.add(Helper.correctNull((String)strFatherName));//17
									arrValues.add(Helper.correctNull((String)strCustStatusCode));//18
									arrValues.add(Helper.correctNull((String)strIntroducerStatus));//19
									arrValues.add(Helper.correctNull((String)strSolid));//20
									arrValues.add(Helper.correctNull((String)strCustConstitutionNew));//21
									arrValues.add(Helper.correctNull((String)strLAPSIntroducerType));//22
									arrValues.add(Helper.correctNull((String)strAadharNo));//23
									
									arrValues.add(Helper.correctNull((String)"001"));//24
									arrValues.add("11");//25
									arrValues.add("1");//26
									arrValues.add(Helper.correctDouble(Helper.correctNull((String)hshValues.get("Networth"))));////"0.00");
									arrValues.add("IL");
									
									arrValues.add(Helper.correctNull((String)hshValues.get("perapp_stakeheld_women")));
									
									hshValues.put("strSolid",strSolid);
									hshValues.put("strFname",fname);
									
									//txt_comcustadd1
									
									
									/*
									 * Values for the table individual_info
									 */
									
									arrIndValues.add(Helper.correctNull((String)strCaste));//0
									arrIndValues.add(Helper.correctNull((String)strReligion));//1
									arrIndValues.add(Helper.correctNull((String)strResidentialStatus));//2
									arrIndValues.add(Helper.correctNull((String)strNRICountry));//3
									arrIndValues.add(Helper.correctNull((String)strIsStaff));//4
									arrIndValues.add(Helper.correctNull((String)strCustEmpID));//5
									arrIndValues.add(Helper.correctNull((String)strIsMinor));//6
									arrIndValues.add(Helper.correctNull((String)strEducationQua));//7
									arrIndValues.add(Helper.correctNull((String)strSpouseName));//8
									arrIndValues.add(Helper.correctNull((String)strSpouseOccupation));//9
									arrIndValues.add(Helper.correctNull((String)strSpouseQua));//10
									arrIndValues.add(Helper.correctNull((String)(strSpouseAdd1+"/n"+strSpouseAdd2)));//11
									arrIndValues.add(Helper.correctNull((String)strGuarName));//12
									arrIndValues.add(Helper.correctNull((String)strGuarCode));//13
									arrIndValues.add(Helper.correctNull((String)(strGuarAddr1+"/n"+strGuarAddr2)));//14
									
									/*
									 * Values for the table cust_contactinfo
									 */
									
									
									hshValues.put("strPresentAdr1",strPresentAdr1);
									
									arrConValues.add(Helper.correctNull((String)strPresentAdr1));//2
									arrConValues.add(Helper.correctNull((String)strPresentAdr2));//3
									arrConValues.add(Helper.correctNull((String)strPresentCity));//4
									arrConValues.add(Helper.correctNull((String)strPresentState));//5
									arrConValues.add(Helper.correctNull((String)strPresentZip));//6
									arrConValues.add(Helper.correctNull((String)strPresentCountry));//7
									arrConValues.add(Helper.correctNull((String)strPresentPho));//8
									arrConValues.add(Helper.correctNull((String)strPresentPho2));//9
									arrConValues.add(Helper.correctNull((String)strPresentFax));//10
									arrConValues.add(Helper.correctNull((String)strEmail));//11
									arrConValues.add(Helper.correctNull((String)strPerAdrs1));//12
									arrConValues.add(Helper.correctNull((String)strPerAdrs2));//13
									arrConValues.add(Helper.correctNull((String)strPerCity));//14
									arrConValues.add(Helper.correctNull((String)strPerState));//15
									arrConValues.add(Helper.correctNull((String)strPerPin));//16
									arrConValues.add(Helper.correctNull((String)strPerCountry));//17
									arrConValues.add(Helper.correctNull((String)strPerPho));//18
									arrConValues.add(Helper.correctNull((String)strPerFax));//19
									arrConValues.add(Helper.correctNull((String)strPerEmail));//20
									
									if(strSel_add1.equalsIgnoreCase("1") && strSel_add2.equalsIgnoreCase("1") && strSel_City.equalsIgnoreCase("1") &&
											strSel_pin.equalsIgnoreCase("1") && strSel_state.equalsIgnoreCase("1") && strSel_country.equalsIgnoreCase("1"))
									{
										arrConValues.add("1");//21
									}
									else
									{
										arrConValues.add("2");//21
									}
									arrConValues.add(Helper.correctNull((String)hshValues.get("distcode")));//20
									arrConValues.add(Helper.correctNull((String)hshValues.get("distcode")));//20
									arrConValues.add(diffyears);//20
									
									
									hshValues.put("txt_comcustadd1",strPresentAdr1);
									hshValues.put("txt_comcustadd2",strPresentAdr2);
									hshValues.put("hidcity",strPresentCity);
									hshValues.put("hid_state",strPresentState);
									hshValues.put("txtcomcust_zip",strPresentZip);
									hshValues.put("strbussnissdate",strdob);
									hshValues.put("txtcomcust_phone",strPresentPho);
									hshValues.put("txtcomcust_mobile",strPresentPho2);
									hshValues.put("txtcomcust_email",strEmail);
									hshValues.put("txtcomcust_pan",strPanno);
									/*
									 * Values for the table applicant_kycnorms
									 */
									
									arrKycValues.add(Helper.correctNull((String)strCustOccCode));//2
									arrKycValues.add(Helper.correctNull((String)strCusIDProof));//3
									arrKycValues.add(Helper.correctNull((String)strCusIDRef));//4
									arrKycValues.add(Helper.correctNull((String)strCusRating));//5
									arrKycValues.add(Helper.correctNull((String)strCusIDRef));//6
									arrKycValues.add(Helper.correctNull((String)strdob));//7
									/*
									 * Values for the table peremployer
									 */
									arrEmpValues.add(Helper.correctNull((String)strEmployerAdr1));
									arrEmpValues.add(Helper.correctNull((String)strEmployerAdr2));
									arrEmpValues.add(Helper.correctNull((String)strEmployerCity));
									arrEmpValues.add(Helper.correctNull((String)strEmployerState));
									arrEmpValues.add(Helper.correctNull((String)strEmployerZip));
									arrEmpValues.add(Helper.correctNull((String)strEmployerPho1));
									arrEmpValues.add(Helper.correctNull((String)strEmployerFax));
									arrEmpValues.add(Helper.correctNull((String)strEmployerEmail));
									arrEmpValues.add(Helper.correctNull((String)strEmployerNo));
									
									/*
									 * Values for the table perapplicant_nri
									 */
									if(strResidentialStatus.equalsIgnoreCase("Y"))
									{
										arrNRIValues.add(Helper.correctNull((String)strPassportNumber));
										arrNRIValues.add(Helper.correctNull((String)strPassportIssDate));
										arrNRIValues.add(Helper.correctNull((String)strPassportExpDate));
									}
								
									if (action.equalsIgnoreCase("Update")) 
									{
										
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("chk_districtavailability^"+strLapscustid+"^"+strPresentState+"^"+strPerState);
										if(rs.next())
										{
											arrConValues.add(Helper.correctNull(rs.getString("con_comdist")));
											arrConValues.add(Helper.correctNull(rs.getString("con_permdist")));
										}
										else
										{
											arrConValues.add("");
											arrConValues.add("");
										}
										
										arrValues.add(Helper.correctNull((String) strLapscustid));
										arrIndValues.add(Helper.correctNull((String) strLapscustid));
										arrConValues.add(Helper.correctNull((String) strLapscustid));
										arrKycValues.add(Helper.correctNull((String) strLapscustid));
										
										arrEmpValues.add(Helper.correctNull((String) strLapscustid));
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										{
											arrNRIValues.add(Helper.correctNull((String) strLapscustid));
										}
									}
									
									hshQueryValues.put("size","1");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshIndQuery.put("arrValues", arrIndValues);
									hshQueryValues.put("1", hshIndQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshConQuery.put("arrValues", arrConValues);
									hshQueryValues.put("1", hshConQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshKycQuery.put("arrValues", arrKycValues);
									hshQueryValues.put("1", hshKycQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									
									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									hshQuery.put("strQueryId","ins_cusdefaulter");
									arrValues.add(strLapscustid); 
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
					                hshQueryValues.put("size","1");									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									querycount++;
									hshQuery.put("strQueryId","ins_cusrating_extAppl");
									arrValues.add(strLapscustid); //newid
									arrValues.add("2");
									arrValues.add("Y");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
					                hshQueryValues.put("size","1");									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
									
									/*hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshEmpQuery.put("arrValues", arrEmpValues);
									hshQueryValues.put("1", hshEmpQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); */
									
									if(strResidentialStatus.equalsIgnoreCase("Y"))
									{
										hshQueryValues=new HashMap();
										hshQueryValues.put("size", "1");
										hshNRIQuery.put("arrValues", arrNRIValues);
										hshQueryValues.put("1", hshNRIQuery);			
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									
									//To insert a row in perincexpenses
									if (action.equalsIgnoreCase("Insert")) 
									{
										hshQueryValues.put("size","2");
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","mastdemographicsincins"); //
										arrValues.add(strLapscustid);
										arrValues.add("P");
										arrValues.add("A");
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("1",hshQuery);
										
										//To insert a row in company_info
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","percompanyinfo_insertdataSHG");//percompanyinfo_insertdata");
										arrValues.add(strLapscustid);
										arrValues.add(strComGroupId);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("2",hshQuery);
										
										int intsize=2;
										//CIBIL Entry
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("sel_burcibildetails^"+strdob+"^"+strPanno+"^"+strAadharNo);
										if(rs.next())
										{
											if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase("")&& !Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","ins_cibilScore");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
												arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
											else if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","upd_cibilScore_CIBIL1");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
											
											else if(!Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","upd_cibilScore_CRIF1");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
										}
										
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("sel_bur_details^"+strdob+"^"+strPanno+"^"+strAadharNo);
										if(rs.next())
										{
										
											if (rs2 != null) 
											{
												rs2.close();
											}
											rs2=DBUtils.executeLAPSQuery("sel_defid^"+strLapscustid);
											if(rs2.next())
											{
												cus_def_id=Helper.correctNull((String)rs2.getString("DEF_ID"));
											}
										if(!cus_def_id.equalsIgnoreCase(""))
										{
											++intsize;
													hshQuery=new HashMap();
													arrValues=new ArrayList();
													hshQuery.put("strQueryId","update_cus_score");
													arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
													arrValues.add(cus_def_id);
													hshQuery.put("arrValues",arrValues);
													hshQueryValues.put(String.valueOf(intsize),hshQuery);
													hshQueryValues.put("size",String.valueOf(intsize));
										}
										else if(cus_def_id.equalsIgnoreCase("")){
											
											++intsize;
											hshQuery=new HashMap();
											arrValues=new ArrayList();
											hshQuery.put("strQueryId","ins_hun_score");
											arrValues.add(strLapscustid);
											arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put(String.valueOf(intsize),hshQuery);
											hshQueryValues.put("size",String.valueOf(intsize));
										}
										}
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									else if (action.equalsIgnoreCase("update")) 
									{
										hshQueryValues=new HashMap();
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQueryValues.put("size", "1");
										hshQuery.put("strQueryId","percompanyinfo_updatedata");
										arrValues.add(strComGroupId);
										arrValues.add(strLapscustid);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("1",hshQuery);
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									
									if (action.equalsIgnoreCase("update")) 
									{
										if(rs!=null)
											rs.close();
										if(rs1!=null)
											rs1.close();
										rs=DBUtils.executeLAPSQuery("sel_CBScustomerdetails^"+strcustid);
										if(rs.next())
										{
											String strIntroName=Helper.correctNull(rs.getString("PERAPP_INTRONAME"));
											String strIntroCBSID=Helper.correctNull(rs.getString("PERAPP_INTROCBSID"));
											
											if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("1"))
											{
												rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("PERAPP_INTROSTAFFID")));
												if(rs1.next())
												{
													strIntroName=Helper.correctNull(rs1.getString("name"));
												}
											}
											else if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("2"))
											{
												if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
												{
													strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strIntroCBSID);
													rs1=DBUtils.executeQueryCBSConnection(strQuery);
												}
												else
												{
													strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strIntroCBSID);
													rs1=DBUtils.executeQuery(strQuery); 
												}
												if (rs1.next()) 
												{
													strIntroName=Helper.correctNull(rs1.getString("cust_name"));
												}
											}
											
											hshQueryValues=new HashMap();
											hshQuery=new HashMap();
											arrValues=new ArrayList();
											hshQueryValues.put("size", "1");
											hshQuery.put("strQueryId","upd_CBScustomerdetails");
											arrValues.add(strIntroName);
											arrValues.add(strIntroCBSID);
											arrValues.add(strLapscustid);
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put("1",hshQuery);
											EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
											
											
											
										}
									}
								}
								 
								
								//updperapplicantprofileshg
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updperapplicantprofileshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updapplicant_kycnormsshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updcust_contactinfotshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								//getperincexpensesincomestatusSHG
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","getperincexpensesincomestatusSHG");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								//getPEREMPLOYERprofileemploymentstatus
								

								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","getPEREMPLOYERprofileemploymentstatus");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								
								
								
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								arrValues.add(correctNull((String)hshValues.get("minority")));
								arrValues.add(correctNull((String)hshValues.get("community")));
								hshQuery.put("strQueryId","updcompanyminoritydet");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								
								if(correctNull((String)hshValues.get("community")).equalsIgnoreCase("Y"))
								{
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								arrValues.add(correctNull((String)hshValues.get("Religion")));
								hshQuery.put("strQueryId","perapplicantreligionshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								}
								
								if(boolappstatus)
								{
									
									boolean openpendingapp=false;
									
									rs=DBUtils.executeLAPSQuery("checkapplicantstatuspershgop^"+strLapsCustId);
									if(rs.next())
									{
										openpendingapp=true;
									}
								}
								
								
							// End of Inserting Applicant Details in LAPS DataBase
							
							/*strQuery = SQLParser.getSqlQuery("mastsearch");
							strQuery = strQuery + " "
									+ SQLParser.getSqlQuery("mastOrderID^" + strLapscustid);
							if(rs!=null)
							{
								
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) {
								arryCol = new ArrayList();
								arryCol.add(Helper.correctNull(rs.getString("perapp_id"))); //0
								arryCol.add(Helper.correctNull(rs.getString("perapp_fname")));
								arryCol.add(Helper.correctNull(rs.getString("perapp_lname")));
								arryCol.add(Helper.correctNull(rs.getString("perapp_mname")));
								arryCol.add(Helper.correctNull(rs.getString("org_name")));
								arryRow.add(arryCol);
							}*/
								hshValues.put("arryRow",arryRow); 
							} 
							
							
							if(boolappstatus)
							{
								
								String strAppCode="",strOldAppId="";
								strAppCode=strLapscustid;
								strOldAppId=lapsID;
								
								////perapplicant
								
//								
//								hshQuery=new HashMap();
//								arrValues=new ArrayList();
//								arrValues.add("y");
//								arrValues.add(lapsID);
//								hshQuery.put("arrValues",arrValues);
//								hshQuery.put("strQueryId","perapplicantupdaterenew");
//								hshQueryValues.put("1",hshQuery);
//								hshQueryValues.put("size","1");
//								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
//								
								
						/*		hshQuery=new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","perapplicantupdaterenewshgop");
								hshQueryValues.put("2",hshQuery);
								
								//individual_info_renewshgop
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","individual_info_renewshgop");
								hshQueryValues.put("3",hshQuery);
								
								// insert data in to company_info table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","company_info_renewshgop");
								hshQueryValues.put("4",hshQuery);
								
								// insert data in to perincexpences table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","perincomerenewshgop");
								hshQueryValues.put("5",hshQuery);
								
								// insert data in to peremployer table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","peremployerrenewshgop");
								hshQueryValues.put("6",hshQuery);
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();			
								arrValues.add(strOldAppId);
								arrValues.add(strAppCode);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","ins_perapplicant_idmap");
								hshQueryValues.put("7",hshQuery);
								
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","kycnormsrenewshgop");
								hshQueryValues.put("8",hshQuery);
								
								
								// insert data in to Communication Details table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","percomaddressrenewshgop");
								hshQueryValues.put("9",hshQuery);
								
								// insert data in to Customer Cibil Details Details table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","percuscibilrenewshgop");
								hshQueryValues.put("11",hshQuery);
								
								
								// insert data in to Customer Defaulter Details table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","percusdefaultrenewshgop");
								hshQueryValues.put("12",hshQuery);*/
								
								// Applicant New id updated to per_demographics table
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strLapscustid);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","perdemographicsrenew");
								hshQueryValues.put("1",hshQuery);
								
								
								// Applicant New id updated to com_demographics table
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","comdemographicsrenew");
								hshQueryValues.put("2",hshQuery);
								
								
								
//								arrValues=new ArrayList();
//								hshQuery=new HashMap();
//								arrValues.add(strAppCode);
//								arrValues.add(strOldAppId);
//								hshQuery.put("arrValues",arrValues);
//								hshQuery.put("strQueryId","agrlandholdingsrenewshgop");
//								hshQueryValues.put("3",hshQuery);
								
								
								
								/*arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","comcompanydetailsrenewshgop");
								hshQueryValues.put("16",hshQuery);*/
								
							/*	arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","updatecusgroupsmembersrenewshgop");
								hshQueryValues.put("17",hshQuery);  */
								
								

								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","renew_agrappshg_addtnlinfoshgop");
								hshQueryValues.put("3",hshQuery);
								
								//////////
							/*	arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","percusratingnewrenew");
								hshQueryValues.put("22",hshQuery);*/
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","upd_solvency_idrenew");
								hshQueryValues.put("4",hshQuery);
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","upd_kpower_idrenew");
								hshQueryValues.put("5",hshQuery);
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","renew_com_Financialparticulars");
								hshQueryValues.put("6",hshQuery);
								
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","renew_com_charge_assets");
								hshQueryValues.put("7",hshQuery);
								
								//svandidhi tab
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","ins_svanidhidetails_renew");
								hshQueryValues.put("8",hshQuery);
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","ins_per_familyDetails_renew");
								hshQueryValues.put("9",hshQuery);
											
								
								
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strAppCode);
								arrValues.add(strOldAppId);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","upd_bankercertificate_idrenew");
								hshQueryValues.put("10",hshQuery);
								
								hshQueryValues.put("size","10");
											
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
								
								//For inserting in Finacial(corp_fin_year table,com_finance,COM_FINAPPVALUES)
								
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
								////////////
								
								
							}
							
						}catch (Exception ce) {
						throw new EJBException("Error in updateLapsDatabase" + ce.toString());
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
							catch (Exception e1) {
								throw new EJBException(e1.getMessage());
							}
						}
						
						return hshValues;
					}
					
					private void UpdateBankingdataSHG(HashMap hshValues)
					{
						java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
						jtn.setMaximumFractionDigits(2);
						jtn.setMinimumFractionDigits(2);
						jtn.setGroupingUsed(false);
						
						ResultSet rs=null,rs1=null;
						ArrayList arrValues=new ArrayList();
						
						HashMap hshQueryValues=new HashMap();
						HashMap hshQuery=new HashMap();
						
						double wc_funded_existing_cons=0.0;
						double wc_funded_proposed_cons=0.0;
						double wc_funded_existing_noncons=0.0;
						double wc_funded_proposed_noncons=0.0;
						
						double wc_nonfunded_existing_cons=0.0;
						double wc_nonfunded_proposed_cons=0.0;
						double wc_nonfunded_existing_noncons=0.0;
						double wc_nonfunded_proposed_noncons=0.0;
						
						double tl_funded_existing_cons=0.0;
						double tl_funded_proposed_cons=0.0;
						double tl_funded_existing_noncons=0.0;
						double tl_funded_proposed_noncons=0.0;
						
						double tl_nonfunded_existing_cons=0.0;
						double tl_nonfunded_proposed_cons=0.0;
						double tl_nonfunded_existing_noncons=0.0;
						double tl_nonfunded_proposed_noncons=0.0;
						
						String strAppno="";
						String strSno="";
						String strId="";
						String checkid="";
						String strOverdue="";
						String strExcess="";
						//String strSecurity="";
						String strQuery="";
						java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
						nf.setGroupingUsed(false);
						nf.setMaximumFractionDigits(2);
						nf.setMinimumFractionDigits(2);
						int intUpdatesize=0;
						String strcbsappno="";
						String strBorrowId="";
						try
						{
							strAppno=correctNull((String)hshValues.get("appno"));
							strSno=correctNull((String)hshValues.get("strSno"));
							strBorrowId=correctNull((String)hshValues.get("strBorrowId"));
							
							strQuery=SQLParser.getSqlQuery("selfacilitylimits^"+strAppno+"^0");
							rs=DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								if(correctNull(rs.getString("facility_headid")).equals("1"))
								{
									if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
										tl_funded_existing_cons=tl_funded_existing_cons+rs.getDouble("existinglimit");
									else
										tl_funded_existing_noncons=tl_funded_existing_noncons+rs.getDouble("existinglimit");
									if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
										tl_funded_proposed_cons=tl_funded_proposed_cons+rs.getDouble("proposedlimit");
									else
										tl_funded_proposed_noncons=tl_funded_proposed_noncons+rs.getDouble("proposedlimit");
								}
								else if(correctNull(rs.getString("facility_headid")).equals("2"))
								{
									if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
										tl_nonfunded_existing_cons=tl_nonfunded_existing_cons+rs.getDouble("existinglimit");
									else
										tl_nonfunded_existing_noncons=tl_nonfunded_existing_noncons+rs.getDouble("existinglimit");
									if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
										tl_nonfunded_proposed_cons=tl_nonfunded_proposed_cons+rs.getDouble("proposedlimit");
									else
										tl_nonfunded_proposed_noncons=tl_nonfunded_proposed_noncons+rs.getDouble("proposedlimit");
								}
								else if(correctNull(rs.getString("facility_headid")).equals("3"))
								{
									if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
										wc_funded_existing_cons=wc_funded_existing_cons+rs.getDouble("existinglimit");
									else
										wc_funded_existing_noncons=wc_funded_existing_noncons+rs.getDouble("existinglimit");
									if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
										wc_funded_proposed_cons=wc_funded_proposed_cons+rs.getDouble("proposedlimit");
									else
										wc_funded_proposed_noncons=wc_funded_proposed_noncons+rs.getDouble("proposedlimit");
								}
								else if(correctNull(rs.getString("facility_headid")).equals("4"))
								{
									if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
										wc_nonfunded_existing_cons=wc_nonfunded_existing_cons+rs.getDouble("existinglimit");
									else
										wc_nonfunded_existing_noncons=rs.getDouble("existinglimit");
									if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
										wc_nonfunded_proposed_cons=wc_nonfunded_proposed_cons+rs.getDouble("proposedlimit");
									else
										wc_nonfunded_proposed_noncons=wc_nonfunded_proposed_noncons+rs.getDouble("proposedlimit");
								}
							}
								
						
						String strFacId="";
						String strFacNature="";
						String strCombkFacNature="";
						String strcom_factype="",strWhetherACOpening="",strDrawingpower="",strDueDate="",strOutstanding="";
						String strFlag="",strGroup="";
						String strRepayType="",strInterestType="",strBankingType="",strInterestRate="",strPurpose="",strParentAppno="",strParentsno="",strProcessDate="",strSancRefno="";
						String strPrefix="",strSuffix="",strFacCategory="";
						double dblTLExposure=0.00,dblOutstanding=0.00,dbl_Sancamount=0.00,dbl_disbamount=0.00;
						double dblLimit=0.00;
						strQuery=SQLParser.getSqlQuery("sel_FacilityIdLimit^"+strAppno+"^"+strSno);
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strFacId=Helper.correctNull((String)rs.getString("facility_code"));
							dblLimit=Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT")));
							strFacNature=Helper.correctNull((String)rs.getString("facility_nature"));
							strcbsappno=Helper.correctNull((String)rs.getString("cbs_accountno"));
							strWhetherACOpening=Helper.correctNull(rs.getString("facility_accountopen"));
							strGroup=Helper.correctNull(rs.getString("facility_group"));
							strDueDate=Helper.correctNull(rs.getString("facility_duedate"));
							strPurpose=Helper.CLOBToString(rs.getClob("facility_purpose"));
							strRepayType=Helper.correctInt(rs.getString("facility_repaytype"));
							strInterestType=Helper.correctNull(rs.getString("facility_intsubtype"));
							strBankingType=Helper.correctNull(rs.getString("facility_propbanktype"));
							strInterestRate=Helper.correctInt(rs.getString("facility_sancinterest"));
							strPrefix=Helper.correctNull(rs.getString("facility_prefix"));
							strSuffix=Helper.correctNull(rs.getString("facility_suffix"));
							strParentAppno=Helper.correctNull(rs.getString("facility_oldappno"));
							strParentsno=Helper.correctNull(rs.getString("facility_oldappsno"));
							strFacCategory=Helper.correctNull(rs.getString("facility_category"));
							
							if(!strParentAppno.equalsIgnoreCase("")&&!strParentsno.equalsIgnoreCase(""))
							{
								strQuery=SQLParser.getSqlQuery("sel_facsanctionstatus1^"+strParentAppno+"^"+strParentsno);
								rs1=DBUtils.executeQuery(strQuery);
								if (rs1.next())
								{
									strProcessDate=Helper.correctNull(rs1.getString("FAC_PROCESSDATE"));
									strDueDate=Helper.correctNull(rs1.getString("facility_duedate"));
									strInterestRate=Helper.correctNull(rs1.getString("facility_sancinterest"));
								}
								if(rs1!=null)
									rs1.close();
								strQuery=SQLParser.getSqlQuery("sel_SancRefNo^"+strParentAppno);
								rs1=DBUtils.executeQuery(strQuery);
								if (rs1.next())
								{
									strSancRefno=Helper.correctNull(rs1.getString("sanctionrefno"));
								}
								if(rs1!=null)
									rs1.close();
							}
							
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_com_factype_value^"+strAppno+"^"+strSno);
						rs=DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strcom_factype=Helper.correctNull((String)rs.getString("com_factype"));
						}
						{
							if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
							{
								if(strWhetherACOpening.equalsIgnoreCase("Y"))
								strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strcbsappno);
								else
				    			{
				    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
				    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
				    				else
				    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strcbsappno);
				    			}
							}
							else
							{
								if(strWhetherACOpening.equalsIgnoreCase("Y"))
								strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strcbsappno);
								else
								{
									if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
				    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
				    				else
				    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strcbsappno);
								}
								
							}
							if(rs!=null) rs.close();
							rs = DBUtils.executeQueryCBSConnection(strQuery);
							if(rs.next())
							{
								strDrawingpower =jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower"))));    
								strDueDate =Helper.correctNull((String)rs.getString("duedate"));
								strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
							
								dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
								dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
								dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
								
								if(dblOutstanding<0)
								{
									dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
									strFlag="DR";
								}	
				    			else
				    			{
				    				strFlag="CR";
				    			}
								
								if(strFacNature.equalsIgnoreCase("1"))
								{
									if(strFlag.equalsIgnoreCase("CR"))
									{
										dblTLExposure=dbl_Sancamount;
									}
									else
									{
										if(dbl_Sancamount < dblOutstanding)
										{
											dblTLExposure=dblOutstanding;
										}
										else
										{
											dblTLExposure=dbl_Sancamount;
										}
									}
								}
								else
								{
									dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
								}
								
							}
						}
						/*if(strFacNature.equalsIgnoreCase("1"))
						{
							strFacNature="W";
						}
						else if(strFacNature.equalsIgnoreCase("2"))
						{
							strFacNature="T";
						}*/
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_Combk_Type^"+strAppno+"^"+strSno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strCombkFacNature=Helper.correctNull((String)rs.getString("combk_type"));
							if(!strCombkFacNature.equalsIgnoreCase(strFacNature))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size","1");					
								hshQuery.put("strQueryId","combankingdeletebasedonsno");
								arrValues.add(strAppno);
								arrValues.add(Helper.correctNull((String)strSno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							}
						}
						if(dblLimit>0.00)
						{
								strId = Integer.toString(getMaxGradeId(strAppno));
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size","1");					
								hshQuery.put("strQueryId","combankinginsertNEW");
								arrValues.add(strAppno);//1
								arrValues.add(strId);//2
								arrValues.add(strFacNature);//3
								arrValues.add(strFacId+"~"+strFacNature);//4
								//arrValues.add("");//5
								arrValues.add(strBankingType);//6
								if(strInterestType.equalsIgnoreCase("SMTB"))
									arrValues.add("ST");//7
								else if(strInterestType.equalsIgnoreCase("TYGS"))
									arrValues.add("GS");//7
								else
									arrValues.add(strInterestType);//7
								arrValues.add("P");//8
								arrValues.add(strSancRefno);//9
								arrValues.add(strProcessDate);//10
								arrValues.add(strDueDate);//11
								arrValues.add("");//12
								arrValues.add(strBorrowId);//13
								arrValues.add("Our");//14
								arrValues.add("Karnataka Bank");//15
								if(strcom_factype.equalsIgnoreCase("F"))
								{
									arrValues.add("F");//16
								}else
								{
									arrValues.add("N");//16
								}
								arrValues.add(Helper.formatDoubleValue(dblLimit));//17
								if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
									arrValues.add(Helper.formatDoubleValue(dblLimit));//18
								else
								arrValues.add(Helper.formatDoubleValue(dblOutstanding));//18
								arrValues.add("");//19
								arrValues.add("");//20
								arrValues.add(strSno);//21
								String strSessionMod=(Helper.correctNull((String)hshValues.get("strSessionMod")));
								if(strSessionMod.equalsIgnoreCase("CORP"))
								{
									strSessionMod="c";
								}
								else if(strSessionMod.equalsIgnoreCase("AGR"))
								{
									strSessionMod="a";
									
								}
								else
								{
									strSessionMod="";
								}
								arrValues.add(strSessionMod);//22
								arrValues.add("0");//23
								arrValues.add(strcbsappno);//24
								arrValues.add(strInterestRate);//25
								arrValues.add(strRepayType);//26
								arrValues.add(strDrawingpower);//27
								arrValues.add(strPurpose);	//	28		
								arrValues.add("0");//29
								if(strGroup.equalsIgnoreCase("0"))
									arrValues.add("M");//30
								else
									arrValues.add("S");//30
								arrValues.add(strGroup);//31	
								if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
									arrValues.add(Helper.formatDoubleValue(dblLimit));//32
								else
								arrValues.add(Helper.formatDoubleValue(dblTLExposure));//32
								arrValues.add(strFlag);//33
								arrValues.add(strWhetherACOpening);//34
								arrValues.add(strPrefix);
								arrValues.add(strSuffix);
								arrValues.add(strFacCategory);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
							
						}
						else
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");					
							hshQuery.put("strQueryId","combankingdeletebasedonsno");
							arrValues.add(strAppno);
							arrValues.add(Helper.correctNull((String)strSno));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}catch(Exception ex)
						{
							throw new EJBException("Error in UpdateBankData :: "+ex.toString());
						}
					}
					
					private int getMaxGradeId(String appno)
					{
						ResultSet rs = null;
						int termId = 0;
						try
						{	
							rs=DBUtils.executeLAPSQuery("combankingmax^"+appno);
							
							while(rs.next())
							{
								if(rs.getString(1) != null)
								{
									termId = Integer.parseInt(rs.getString(1)) + 1;
								}
								else
								{
									termId = 1;
								}
							}
							rs.close();			
						}
						catch(Exception ce)
						{
							throw new EJBException("Error in getData "+ce.toString());
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
						return termId;
					}
					
					public void updateFromFinacletoLapsDatabase(HashMap hshValues, String action) throws EJBException 
					{
						HashMap hshQueryValues = new HashMap();
						
						ArrayList arrValues = new ArrayList();
						ResultSet rs = null;
						ResultSet rs1 = null;
						ResultSet rs2 = null;
						
						HashMap hshQuery = new HashMap();//For Perapplicant table
						HashMap hshIndQuery=new HashMap();//For Individual_Info table
						HashMap hshKycQuery=new HashMap();//For applicant_kyc table
						HashMap hshConQuery=new HashMap();//For cust_contactinfo table
						HashMap hshEmpQuery=new HashMap();//For peremployer table
						HashMap hshNRIQuery=new HashMap();//For perapplicant_nri table

						
						
						
						String strQuery = "";
						String strQuery1="";
						String  prefix = "", fname = "", lname = "",strSolid="";
						String strdob = "", strsex = "", strMarital = "", strEmail = "", strReligion = "", strLocation = "";
						String strPresentAdr1 = "",strPresentAdr2="",strPresentCity = "", strPresentZip = "", strPresentState = "", strPresentPho = "";
						String strPerAdrs1 = "",strPerAdrs2="",strPerCity = "";
						String strPerPin = "", strPerState = "", strPresentPho2="";
						
						String strCaste= "",strEmpStatus="",strResidentialStatus="",
						strPassportNo= "",strPassportIssDate= "",strPassportExpDate="",strPassportIssuedBy="",strPanno="",
						strIntroducerName= "",strIntroducerId= "";
						String strAccount_Opening_Year="";
						String strSel_add1="",strSel_add2="";
						String strSel_City="";
						String strSel_state="";
						String strSel_pin="";
						String strSel_country="";
						String strCustConstitution="",strTDSTableCode="",strCustStatusCode="",
						strIDProof="",strAdrsProof1="",strAdrsProof2="",strStaffYN="",strCustEmpID="",
						strCustIntrostatus="",strCustIntroID="",strIntroEmpID="",strIntroTitleCode="",
						strCustIntroName="",strIntroAdrs="",strCustOccCode="", strCustConstitutionNew="";
						
						String strTradeFinance="",strTradeAllowed="",strIsStaff="",strIsMinor="",strPresentCountry="";
						String strPerCountry="",strPresentFax="",strPerFax="",strPerPho="",strPerEmail="";
						String strEmployerZip="",strEmployerState="",strEmployerAdr1="",strEmployerAdr2="",strEmployerCity="";
						String strEmployerPho1="",strEmployerFax="",strEmployerEmail="",strEmployerNo="",strFatherName="";
						String strEducationQua="",strSpouseName="",strSpouseOccupation="",strSpouseQua="",strSpouseAdd1="";
						String strSpouseAdd2="",strCusIDProof="",strCusIDRef="",strCusRating="",strGuarName="";
						String strGuarCode="",strGuarAddr1="",strGuarAddr2="",strGuarCity="",strGuarState="";
						String strGuarPincode="",strGuarCountry="",strNRICountry="",strIntroducerStatus="";
						String strPassportNumber="",strLAPSIntroducerType="",strComGroupId="",strAadharNo="",defid="",cus_def_id="";
						
						Connection connectDB	= null;
						CallableStatement callableStmt = null;
						String strNewFinID="";
						String strOldFinID="";
						
						ArrayList arryRow = new ArrayList();
						ArrayList arryCol = new ArrayList();
						
						ArrayList arrIndValues=new ArrayList();//For Individual_Info table
						ArrayList arrKycValues=new ArrayList();//For applicant_kyc table
						ArrayList arrConValues=new ArrayList();//For cust_contactinfo table
						ArrayList arrEmpValues=new ArrayList();//For peremployer table
						ArrayList arrNRIValues=new ArrayList();//For perapplicant_nri table
						int querycount=0;

						String strLapsCustId="";

						String diffyears="";

						
						try 
						{
							// For Getting the Applicant Details From CBS
							int count=0;
							int NRICount=0;
							String strcustid = Helper.correctNull((String) hshValues.get("custid"));
							String strLapscustid=Helper.correctNull((String) hshValues.get("strLapscustid"));
							String strDedupeFlag="",lapsoldID="",lapsID="";
							if(!strcustid.equals(""))
							{
								strQuery = SQLParser.getSqlQuery("perapplicant_selcbsid^"+strcustid);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strDedupeFlag="Y";
									lapsoldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
									lapsID=Helper.correctNull((String)rs.getString("perapp_id"));
								}
							}
							
							
							
									
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
									arrValues.add("y");
									arrValues.add(lapsID);
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strQueryId","perapplicantupdaterenew");
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
								}
								else
								{
									stroldLAPSid=strNewLAPSid;
									strRenewFlag="";
									lapsID=strNewLAPSid;
									strLapscustid=strNewLAPSid;
								}
								
								if(strLapscustid.equalsIgnoreCase(""))
								{
								strLapscustid=strNewLAPSid;
								if(strDedupeFlag.equals("Y"))
								{
								stroldLAPSid=lapsoldID;
								}
								else
								{
									lapsoldID=strNewLAPSid;
								}
								}
								
								hshValues.put("strLapscustid",strNewLAPSid);
								
								
								
								
							if(!strcustid.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("sel_nrioverseasdetails^"+ strLapscustid);
								if(rs!=null)
								{
									rs.close();
								}
								rs=DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									NRICount=1;
								}
								
								if(rs!=null)
								{
									rs.close();
								}
								if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
								{
									strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strcustid);
									rs=DBUtils.executeQueryCBSConnection(strQuery);
								}
								else
								{
									strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strcustid);
									rs=DBUtils.executeQuery(strQuery); 
								}
								if (rs.next()) {
									count++;
									
									/*
									 * The following details are related to perapplicant table
									 */
									
									diffyears= Helper.correctNull(rs.getString("years"))+"~"+"0";//done
									strSolid= Helper.correctNull(rs.getString("solid"));//done
									prefix = Helper.correctNull(rs.getString("cust_title_code"));//done
									fname = (String) Helper.correctNull(rs.getString("cust_name"));//done
									lname = (String) Helper.correctNull(rs.getString("cust_short_name"));//done
									strCustConstitutionNew = (String) Helper.correctNull(rs.getString("cust_const"));//done
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									if(strCustConstitution.trim().equalsIgnoreCase("01")||
											strCustConstitution.trim().equalsIgnoreCase("02"))
									{
										strdob = (String) Helper.correctNull(rs.getString("date_of_birth")).trim();//done
									}
									else
									{
										strdob = (String) Helper.correctNull(rs.getString("dateof_est")).trim();//done
									}
									strsex = (String) Helper.correctNull(rs.getString("cust_sex"));//done
									strMarital = (String) Helper.correctNull(rs.getString("cust_marital_status"));//done
									strPanno = (String) Helper.correctNull(rs.getString("pan_gir_num"));//done
									if(strPanno.equalsIgnoreCase(""))
									{
										strPanno="NOPAN";
									}
									strIntroducerName = (String) Helper.correctNull(rs.getString("cust_introd_name"));//done
									strTradeFinance=(String) Helper.correctNull(rs.getString("party_flg"));//Trade Finance
									strTradeAllowed=(String) Helper.correctNull(rs.getString("inland_trade_allowed"));//Whether Trade Allowed
									strTDSTableCode = (String) Helper.correctNull(rs.getString("tds_tbl_code"));// tax slab done
									strFatherName = (String) Helper.correctNull(rs.getString("father_name"));//Father Name
									strCustStatusCode = (String) Helper.correctNull(rs.getString("cust_stat_code"));//done
									strIntroducerStatus=(String) Helper.correctNull(rs.getString("cust_introd_stat_code"));// Introducer status

									
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^6^"+strIntroducerStatus);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strLAPSIntroducerType=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									
									if(rs1!=null)
									{
										rs1.close();
									}
									strQuery1=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^2^"+strCustConstitutionNew);
									rs1=DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										strCustConstitution=Helper.correctNull((String)rs1.getString("cbs_static_data_passing_code"));
									}
									
									
									/*
									 * The following details are related to INDIVIDUAL_INFO table
									 */
									
									strCaste =(String) Helper.correctNull(rs.getString("cust_caste_code"));//done
									strReligion = (String) Helper.correctNull(rs.getString("cust_commu_code"));//done
									strResidentialStatus = (String) Helper.correctNull(rs.getString("cust_nre_flg")); //done
									strPassportNumber=(String) Helper.correctNull(rs.getString("psprt_num")); //done
									strPassportIssDate=(String) Helper.correctNull(rs.getString("psprt_issu_date"));
									strPassportExpDate=(String) Helper.correctNull(rs.getString("psprt_exp_date"));
									
									strIsStaff=(String) Helper.correctNull(rs.getString("cust_type_code"));//To identify whether staff
									if(!strIsStaff.equalsIgnoreCase("02") && !strIsStaff.equalsIgnoreCase("03"))
									{
										strIsStaff="01";
									}
									strIsMinor=(String) Helper.correctNull(rs.getString("cust_minor_flg"));//To identify minor
									strCustEmpID = (String) Helper.correctNull(rs.getString("cust_emp_id"));//done
									strEducationQua =(String) Helper.correctNull(rs.getString("ed_qualification"));//Education qualification
									strSpouseName = (String) Helper.correctNull(rs.getString("spouse_name"));//Spouse Name
									strSpouseOccupation = (String) Helper.correctNull(rs.getString("spouse_occup"));//Spouse Occupation
									strSpouseQua = (String) Helper.correctNull(rs.getString("spouse_qualif"));//Spouse Qualification
									strSpouseAdd1= (String) Helper.correctNull(rs.getString("spouse_addr_1"));//Spouse Address
									strSpouseAdd2 = (String) Helper.correctNull(rs.getString("spouse_addr_2"));//Spouse Address
									strGuarName = (String) Helper.correctNull(rs.getString("minor_guard_name"));//Guardian Name
									strGuarCode = (String) Helper.correctNull(rs.getString("minor_guard_code"));//Guardian Code
									strGuarAddr1 = (String) Helper.correctNull(rs.getString("minor_guard_addr1"));//Guardian Address1
									strGuarAddr2 = (String) Helper.correctNull(rs.getString("minor_guard_addr2"));//Guardian Address2
									strGuarCity = (String) Helper.correctNull(rs.getString("minor_guard_city_code"));//Guardian City
									if(!strGuarCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strGuarCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarCity=Helper.correctNull((String)rs1.getString("city_name"));
										}
									}
									strGuarState = (String) Helper.correctNull(rs.getString("minor_guard_state_code"));//Guardian State
									if(!strGuarState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strGuarState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarState=Helper.correctNull((String)rs1.getString("state_name"));
										}
									}
									strGuarPincode = (String) Helper.correctNull(rs.getString("minor_guard_pin_code"));//Guardian Zip
									strGuarCountry = (String) Helper.correctNull(rs.getString("minor_guard_cntry_code"));//Guardian Country
									if(!strGuarCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strGuarCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strGuarCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}
									strNRICountry = (String) Helper.correctNull(rs.getString("nre_nationality"));//Country code if the customer is NRI
									if(!strNRICountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strNRICountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strNRICountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}
									/* KBL doesn't provide the view for the following
									 * 
									 * strLocation = (String) Helper.correctNull(rs.getString("br_code"));  
									strPassportNo = (String) Helper.correctNull(rs.getString("psprt_num"));
									strPassportIssDate =(String) Helper.correctNull(rs.getString("psprt_issu_date"));
									strPassportExpDate =(String) Helper.correctNull(rs.getString("psprt_exp_date"));
									strPassportIssuedBy =(String) Helper.correctNull(rs.getString("psprt_issuedby"));
									
									strIntroducerId = (String) Helper.correctNull(rs.getString("cust_introducer_id"));//modified at datacenter
									*/
									
									/*
									 * The following details related to CUST_CONTACTINFO Table
									 */
									
									strPresentAdr1 = (String) Helper.correctNull(rs.getString("cust_comu_addr1"));//done
									strPresentAdr2=(String) Helper.correctNull(rs.getString("cust_comu_addr2"));//done
									strPresentCity = (String) Helper.correctNull(rs.getString("cust_comu_city_code"));//done
									if(!strPresentCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPresentCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentCity=Helper.correctNull(rs1.getString("city_code"));
										}
										else
										{
											strPresentCity="";
										}
									}
									strPresentZip = (String) Helper.correctNull(rs.getString("cust_comu_pin_code"));//done
									strPresentState = (String) Helper.correctNull(rs.getString("cust_comu_state_code"));//done
									if(!strPresentState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPresentState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentState=Helper.correctNull(rs1.getString("state_code"));
										}
										else
										{
											strPresentState="";
										}
									}
									strPresentCountry =(String) Helper.correctNull(rs.getString("cust_comu_cntry_code"));//Communication Country Code
									/*if(!strPresentCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPresentCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPresentCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}*/
									strPresentFax =(String) Helper.correctNull(rs.getString("cust_comu_telex_num"));//Communication Fax No.
									strPresentPho = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_1"));//done
									strPresentPho2 = (String) Helper.correctNull(rs.getString("cust_comu_phone_num_2"));//done
									strEmail = (String) Helper.correctNull(rs.getString("email_id"));//done

									
									/////hshValreq.put("distcode"////
									
									
									strPerAdrs1 = (String) Helper.correctNull(rs.getString("cust_perm_addr1"));//done
									strPerAdrs2=(String) Helper.correctNull(rs.getString("cust_perm_addr2"));//done
									strPerCity = (String) Helper.correctNull(rs.getString("cust_perm_city_code"));//done
									if(!strPerCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strPerCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerCity=Helper.correctNull((String)rs1.getString("city_code"));
										}
										else
										{
											strPerCity="";
										}
									}
									strPerPin = (String) Helper.correctNull(rs.getString("cust_perm_pin_code"));//done
									strPerState = (String) Helper.correctNull(rs.getString("cust_perm_state_code")); //done
									if(!strPerState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strPerState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerState=Helper.correctNull((String)rs1.getString("state_code"));
										}
										else
										{
											strPerState="";
										}
									}
									strPerCountry =(String) Helper.correctNull(rs.getString("cust_perm_cntry_code")); //Permanent country code
									/*if(!strPerCountry.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("sel_countryList^where con_countrycode='"+strPerCountry+"'");
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strPerCountry=Helper.correctNull((String)rs1.getString("con_country"));
										}
									}*/
									strPerFax =(String) Helper.correctNull(rs.getString("cust_perm_telex_num"));//Communication Fax No.
									strPerPho = (String) Helper.correctNull(rs.getString("cust_perm_phone_num"));//Permanent phone no.
									strPerEmail=(String) Helper.correctNull(rs.getString("cust_perm_email_id"));//Permanent Email id
									
									
									if(strPresentAdr1.equalsIgnoreCase(strPerAdrs1))
									{
										strSel_add1="1";
									}
									else
									{
										strSel_add1="2";
									}
									if(strPresentAdr2.equalsIgnoreCase(strPerAdrs2))
									{
										strSel_add2="1";
									}
									else
									{
										strSel_add2="2";
									}
									if(strPresentCity.equalsIgnoreCase(strPerCity))
									{
										strSel_City="1";
									}
									else
									{
										strSel_City="2";
									}
									if(strPresentZip.equalsIgnoreCase(strPerPin))
									{
										strSel_pin="1";
									}
									else
									{
										strSel_pin="2";
									}
									if(strPresentState.equalsIgnoreCase(strPerState))
									{
										strSel_state="1";
									}
									else
									{
										strSel_state="2";
									}
									if(strPresentCountry.equalsIgnoreCase(strPerCountry))
									{
										strSel_country="1";
									}
									else
									{
										strSel_country="2";
									}
									
									/*
									 * The following details related to PEREMPLOYER table
									 */
									
									strEmployerAdr1 = (String) Helper.correctNull(rs.getString("cust_emp_addr1"));//Employer company address
									strEmployerAdr2=(String) Helper.correctNull(rs.getString("cust_emp_addr2"));//Employer company address
									strEmployerCity = (String) Helper.correctNull(rs.getString("cust_emp_city_code"));//Employer company city
									/*if(!strEmployerCity.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selcitycode^"+strEmployerCity);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strEmployerCity=Helper.correctNull((String)rs1.getString("city_name"));
										}
									}*/
									strEmployerZip = (String) Helper.correctNull(rs.getString("cust_emp_pin_code"));//Employer company zip
									strEmployerState = (String) Helper.correctNull(rs.getString("cust_emp_state_code"));//Employer company state
									/*if(!strEmployerState.equalsIgnoreCase(""))
									{
										strQuery1=SQLParser.getSqlQuery("selstatename2^"+strEmployerState);
										if(rs1!=null)
										{
											rs1.close();
										}
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											strEmployerState=Helper.correctNull((String)rs1.getString("state_name"));
										}
									}*/
									strEmployerPho1 = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_1"));//Employer company phone1
									strEmployerFax = (String) Helper.correctNull(rs.getString("cust_emp_phone_num_2"));//Employer company Fax No
									strEmployerEmail = (String) Helper.correctNull(rs.getString("cust_emp_email_id"));//Employer company Email id
									strEmployerNo = (String) Helper.correctNull(rs.getString("cust_employee_no"));//Employee Number
									
									/*
									 * The following details related to APPLICANT_KYCNORMS table
									 */
									strCustOccCode = (String) Helper.correctNull(rs.getString("cust_occp_code"));//done
									strCusIDProof = (String) Helper.correctNull(rs.getString("id_doc")); // ID proof of the customer
									strCusIDRef=(String) Helper.correctNull(rs.getString("id_number"));//ID Refernce number of the customer proof
									strCusRating=(String) Helper.correctNull(rs.getString("riskrating"));//Rating of the customer
								


							
									
									/*KBL doesn't provide the view for the following
									 * 
									 * strIDProof = (String) Helper.correctNull(rs.getString("ID_PROOF"));
									strAdrsProof1 = (String) Helper.correctNull(rs.getString("ADDR_PROOF1"));
									strAdrsProof2 = (String) Helper.correctNull(rs.getString("ADDR_PROOF2"));
									strStaffYN = (String) Helper.correctNull(rs.getString("STAFF_YN"));
									if(strStaffYN.trim().equals(""))
										strStaffYN="0";
									
									strCustIntrostatus  = (String) Helper.correctNull(rs.getString("CUST_INTROD_STAT_CODE"));
									strCustIntroID = (String) Helper.correctNull(rs.getString("CUST_INTROD_CUST_ID"));
									strIntroEmpID = (String) Helper.correctNull(rs.getString("INTROD_EMP_ID"));
									strIntroTitleCode = (String) Helper.correctNull(rs.getString("INTROD_TITLE_CODE"));
									strCustIntroName = (String) Helper.correctNull(rs.getString("CUST_INTROD_NAME"));
									strIntroAdrs = (String) Helper.correctNull(rs.getString("INTRO_ADDRESS"));
									 
									strAccount_Opening_Year=(String) Helper.correctNull(rs.getString("acct_opn_year")); 
									*/
									
									/*
									 * The group id value related to COMPANY_INFO table
									 */
									
									strComGroupId= Helper.correctNull(rs.getString("cust_grp"));//Rating of the customer
									strAadharNo= Helper.correctNull(rs.getString("nat_id_card_num"));//Rating of the customer
								}
								if(count !=0)
								{
									// For Updating the values to LAPS DATABASE
									hshQueryValues = new HashMap();
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									if (action.equalsIgnoreCase("Update")) 
									{
										if(rs!=null)
										{
											rs.close();
										}
										rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+strLapscustid);				 
										if(rs.next())
										{
											//No update if the borrower has processed approved/processed closed application
											hshValues.put("arryRow", arryRow);
											
										}
										else
										{
											if (action.equalsIgnoreCase("Update")) 
											{
												if(rs!=null)
												{
													rs.close();
												}
												rs=DBUtils.executeLAPSQuery("sel_genderdet^"+strLapscustid);				 
												if(rs.next())
												{
													if(strCustConstitution.trim().equalsIgnoreCase("01")||
															strCustConstitution.trim().equalsIgnoreCase("02"))
													{
														if(!Helper.correctNull(rs.getString("perapp_sex")).equalsIgnoreCase(strsex)||!Helper.correctNull(rs.getString("indinfo_caste")).equalsIgnoreCase(strCaste))
														{
															hshQuery = new HashMap();
															arrValues=new ArrayList();
															arrValues.add(strLapscustid);
															arrValues.add(strLapscustid);
															hshQuery.put("strQueryId","upd_misreselectflag"); 
															hshQuery.put("arrValues",arrValues); 
															hshQueryValues.put("1",hshQuery);
															hshQueryValues.put("size","1");
															EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
															
															
															hshQueryValues = new HashMap();
															hshQuery = new HashMap();
															arrValues = new ArrayList();
														}
													}
												}
											}
											
											
											hshQuery.put("strQueryId", "perapplicant_updatecbsdataSHG");
											hshIndQuery.put("strQueryId", "perindividual_updatecbsdata");
											hshConQuery.put("strQueryId", "percontact_updatecbsdataSHG");
											hshKycQuery.put("strQueryId", "perkyc_updatecbsdataSHG");
											//hshEmpQuery.put("strQueryId", "peremployer_updatecbsdata");
											if(strResidentialStatus.equalsIgnoreCase("Y"))
											{
												if(NRICount==0)
												{
													hshNRIQuery.put("strQueryId", "perapplicant_insertnridet1");
												}
												else
												{
													hshNRIQuery.put("strQueryId", "perapplicant_updatenridet");
												}
											}

										}
									}
									else if (action.equalsIgnoreCase("Insert")) 
									{				
										hshQuery.put("strQueryId", "perapplicant_insertcbsdataSHG");
										hshIndQuery.put("strQueryId", "perindividual_insertcbsdata");
										hshConQuery.put("strQueryId", "percontact_insertcbsdataSHG");
										hshKycQuery.put("strQueryId", "perkyc_insertcbsdataSHG");
										//hshEmpQuery.put("strQueryId", "peremployer_insertcbsdata");
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										hshNRIQuery.put("strQueryId", "perapplicant_insertnridet");
										
										arrValues.add(Helper.correctNull((String) strLapscustid));//0
										arrValues.add(lapsoldID);//1
										arrValues.add(strcustid);//2
										arrValues.add("C");//P");//3
										arrValues.add("Y");//4
										arrIndValues.add(strLapscustid);//0
										arrConValues.add(strLapscustid);//0
										arrConValues.add("P");//1
										arrKycValues.add(strLapscustid);//0
										arrKycValues.add("P");//1
										arrEmpValues.add(strLapscustid);
										arrEmpValues.add("P");
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										arrNRIValues.add(strLapscustid);
									}
									
									/*
									 * Values for the table perapplicant
									 */
									
									arrValues.add(Helper.correctNull((String)prefix));//5
									arrValues.add(Helper.correctNull((String)fname));//6
									arrValues.add(Helper.correctNull((String)lname));//7
									arrValues.add(Helper.correctNull((String)strdob));//8
									hshValues.put("strdob",strdob);
									arrValues.add(Helper.correctNull((String)strsex));//9
									arrValues.add(Helper.correctNull((String)strMarital));//10
									arrValues.add(Helper.correctNull((String)strPanno));//11
									arrValues.add(Helper.correctNull((String)strIntroducerName));//12
									arrValues.add(Helper.correctNull((String)strTradeFinance));//13
									arrValues.add(Helper.correctNull((String)strTradeAllowed));//14
									arrValues.add(Helper.correctNull((String)strCustConstitution));//15
									arrValues.add(Helper.correctNull((String)strTDSTableCode));//16
									arrValues.add(Helper.correctNull((String)strFatherName));//17
									arrValues.add(Helper.correctNull((String)strCustStatusCode));//18
									arrValues.add(Helper.correctNull((String)strIntroducerStatus));//19
									arrValues.add(Helper.correctNull((String)strSolid));//20
									arrValues.add(Helper.correctNull((String)strCustConstitutionNew));//21
									arrValues.add(Helper.correctNull((String)strLAPSIntroducerType));//22
									arrValues.add(Helper.correctNull((String)strAadharNo));//23
									
									arrValues.add(Helper.correctNull((String)"001"));//24
									arrValues.add("11");//25
									arrValues.add("1");//26
									arrValues.add(Helper.correctDouble(Helper.correctNull((String)hshValues.get("Networth"))));////"0.00");
									arrValues.add("IL");
									
									arrValues.add(Helper.correctNull((String)hshValues.get("perapp_stakeheld_women")));
									
									hshValues.put("strSolid",strSolid);
									hshValues.put("strFname",fname);
									
									//txt_comcustadd1
									
									
									/*
									 * Values for the table individual_info
									 */
									
									arrIndValues.add(Helper.correctNull((String)strCaste));//0
									arrIndValues.add(Helper.correctNull((String)strReligion));//1
									arrIndValues.add(Helper.correctNull((String)strResidentialStatus));//2
									arrIndValues.add(Helper.correctNull((String)strNRICountry));//3
									arrIndValues.add(Helper.correctNull((String)strIsStaff));//4
									arrIndValues.add(Helper.correctNull((String)strCustEmpID));//5
									arrIndValues.add(Helper.correctNull((String)strIsMinor));//6
									arrIndValues.add(Helper.correctNull((String)strEducationQua));//7
									arrIndValues.add(Helper.correctNull((String)strSpouseName));//8
									arrIndValues.add(Helper.correctNull((String)strSpouseOccupation));//9
									arrIndValues.add(Helper.correctNull((String)strSpouseQua));//10
									arrIndValues.add(Helper.correctNull((String)(strSpouseAdd1+"/n"+strSpouseAdd2)));//11
									arrIndValues.add(Helper.correctNull((String)strGuarName));//12
									arrIndValues.add(Helper.correctNull((String)strGuarCode));//13
									arrIndValues.add(Helper.correctNull((String)(strGuarAddr1+"/n"+strGuarAddr2)));//14
									
									/*
									 * Values for the table cust_contactinfo
									 */
									
									
									hshValues.put("strPresentAdr1",strPresentAdr1);
									
									arrConValues.add(Helper.correctNull((String)strPresentAdr1));//2
									arrConValues.add(Helper.correctNull((String)strPresentAdr2));//3
									arrConValues.add(Helper.correctNull((String)strPresentCity));//4
									arrConValues.add(Helper.correctNull((String)strPresentState));//5
									arrConValues.add(Helper.correctNull((String)strPresentZip));//6
									arrConValues.add(Helper.correctNull((String)strPresentCountry));//7
									arrConValues.add(Helper.correctNull((String)strPresentPho));//8
									arrConValues.add(Helper.correctNull((String)strPresentPho2));//9
									arrConValues.add(Helper.correctNull((String)strPresentFax));//10
									arrConValues.add(Helper.correctNull((String)strEmail));//11
									arrConValues.add(Helper.correctNull((String)strPerAdrs1));//12
									arrConValues.add(Helper.correctNull((String)strPerAdrs2));//13
									arrConValues.add(Helper.correctNull((String)strPerCity));//14
									arrConValues.add(Helper.correctNull((String)strPerState));//15
									arrConValues.add(Helper.correctNull((String)strPerPin));//16
									arrConValues.add(Helper.correctNull((String)strPerCountry));//17
									arrConValues.add(Helper.correctNull((String)strPerPho));//18
									arrConValues.add(Helper.correctNull((String)strPerFax));//19
									arrConValues.add(Helper.correctNull((String)strPerEmail));//20
									
									if(strSel_add1.equalsIgnoreCase("1") && strSel_add2.equalsIgnoreCase("1") && strSel_City.equalsIgnoreCase("1") &&
											strSel_pin.equalsIgnoreCase("1") && strSel_state.equalsIgnoreCase("1") && strSel_country.equalsIgnoreCase("1"))
									{
										arrConValues.add("1");//21
									}
									else
									{
										arrConValues.add("2");//21
									}
									arrConValues.add(Helper.correctNull((String)hshValues.get("distcode")));//20
									arrConValues.add(Helper.correctNull((String)hshValues.get("distcode")));//20
									arrConValues.add(diffyears);//20
									
									
									hshValues.put("txt_comcustadd1",strPresentAdr1);
									hshValues.put("txt_comcustadd2",strPresentAdr2);
									hshValues.put("hidcity",strPresentCity);
									hshValues.put("hid_state",strPresentState);
									hshValues.put("txtcomcust_zip",strPresentZip);
									hshValues.put("strbussnissdate",strdob);
									hshValues.put("txtcomcust_phone",strPresentPho);
									hshValues.put("txtcomcust_mobile",strPresentPho2);
									hshValues.put("txtcomcust_email",strEmail);
									hshValues.put("txtcomcust_pan",strPanno);
									/*
									 * Values for the table applicant_kycnorms
									 */
									
									arrKycValues.add(Helper.correctNull((String)strCustOccCode));//2
									arrKycValues.add(Helper.correctNull((String)strCusIDProof));//3
									arrKycValues.add(Helper.correctNull((String)strCusIDRef));//4
									arrKycValues.add(Helper.correctNull((String)strCusRating));//5
									arrKycValues.add(Helper.correctNull((String)strCusIDRef));//6
									arrKycValues.add(Helper.correctNull((String)strdob));//7
									/*
									 * Values for the table peremployer
									 */
									arrEmpValues.add(Helper.correctNull((String)strEmployerAdr1));
									arrEmpValues.add(Helper.correctNull((String)strEmployerAdr2));
									arrEmpValues.add(Helper.correctNull((String)strEmployerCity));
									arrEmpValues.add(Helper.correctNull((String)strEmployerState));
									arrEmpValues.add(Helper.correctNull((String)strEmployerZip));
									arrEmpValues.add(Helper.correctNull((String)strEmployerPho1));
									arrEmpValues.add(Helper.correctNull((String)strEmployerFax));
									arrEmpValues.add(Helper.correctNull((String)strEmployerEmail));
									arrEmpValues.add(Helper.correctNull((String)strEmployerNo));
									
									/*
									 * Values for the table perapplicant_nri
									 */
									if(strResidentialStatus.equalsIgnoreCase("Y"))
									{
										arrNRIValues.add(Helper.correctNull((String)strPassportNumber));
										arrNRIValues.add(Helper.correctNull((String)strPassportIssDate));
										arrNRIValues.add(Helper.correctNull((String)strPassportExpDate));
									}
								
									if (action.equalsIgnoreCase("Update")) 
									{
										
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("chk_districtavailability^"+strLapscustid+"^"+strPresentState+"^"+strPerState);
										if(rs.next())
										{
											arrConValues.add(Helper.correctNull(rs.getString("con_comdist")));
											arrConValues.add(Helper.correctNull(rs.getString("con_permdist")));
										}
										else
										{
											arrConValues.add("");
											arrConValues.add("");
										}
										
										arrValues.add(Helper.correctNull((String) strLapscustid));
										arrIndValues.add(Helper.correctNull((String) strLapscustid));
										arrConValues.add(Helper.correctNull((String) strLapscustid));
										arrKycValues.add(Helper.correctNull((String) strLapscustid));
										
										arrEmpValues.add(Helper.correctNull((String) strLapscustid));
										if(strResidentialStatus.equalsIgnoreCase("Y"))
										{
											arrNRIValues.add(Helper.correctNull((String) strLapscustid));
										}
									}
									
									hshQueryValues.put("size","1");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshIndQuery.put("arrValues", arrIndValues);
									hshQueryValues.put("1", hshIndQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshConQuery.put("arrValues", arrConValues);
									hshQueryValues.put("1", hshConQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshKycQuery.put("arrValues", arrKycValues);
									hshQueryValues.put("1", hshKycQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									
									
									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									hshQuery.put("strQueryId","ins_cusdefaulter");
									arrValues.add(strLapscustid); 
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									arrValues.add("N");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
					                hshQueryValues.put("size","1");									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									querycount++;
									hshQuery.put("strQueryId","ins_cusrating_extAppl");
									arrValues.add(strLapscustid); //newid
									arrValues.add("2");
									arrValues.add("Y");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
					                hshQueryValues.put("size","1");									
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
									
									
									
									/*hshQueryValues=new HashMap();
									hshQueryValues.put("size", "1");
									hshEmpQuery.put("arrValues", arrEmpValues);
									hshQueryValues.put("1", hshEmpQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); */
									
									if(strResidentialStatus.equalsIgnoreCase("Y"))
									{
										hshQueryValues=new HashMap();
										hshQueryValues.put("size", "1");
										hshNRIQuery.put("arrValues", arrNRIValues);
										hshQueryValues.put("1", hshNRIQuery);			
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									
									//To insert a row in perincexpenses
									if (action.equalsIgnoreCase("Insert")) 
									{
										hshQueryValues.put("size","2");
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","mastdemographicsincins"); //
										arrValues.add(strLapscustid);
										arrValues.add("P");
										arrValues.add("A");
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("1",hshQuery);
										
										//To insert a row in company_info
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","percompanyinfo_insertdataSHG");//percompanyinfo_insertdata");
										arrValues.add(strLapscustid);
										arrValues.add(strComGroupId);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("2",hshQuery);
										
										int intsize=2;
										//CIBIL Entry
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("sel_burcibildetails^"+strdob+"^"+strPanno+"^"+strAadharNo);
										if(rs.next())
										{
											if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase("")&& !Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","ins_cibilScore");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
												arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
											else if(!Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","upd_cibilScore_CIBIL1");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CIBIL_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_cibildate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
											
											else if(!Helper.correctNull(rs.getString("BUR_CRIF_SCORE")).equalsIgnoreCase(""))
											{
												++intsize;
												hshQuery=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId","upd_cibilScore_CRIF1");
												arrValues.add(Helper.correctNull(rs.getString("BUR_CRIF_SCORE")));
												arrValues.add(Helper.correctNull(rs.getString("bur_crifdate")));
												arrValues.add(strLapscustid);
												hshQuery.put("arrValues",arrValues);
												hshQueryValues.put(String.valueOf(intsize),hshQuery);
												hshQueryValues.put("size",String.valueOf(intsize));
											}
										}
										
										if(rs!=null)
											rs.close();
										rs=DBUtils.executeLAPSQuery("sel_bur_details^"+strdob+"^"+strPanno+"^"+strAadharNo);
										if(rs.next())
										{
										
											if (rs2 != null) 
											{
												rs2.close();
											}
											rs2=DBUtils.executeLAPSQuery("sel_defid^"+strLapscustid);
											if(rs2.next())
											{
												cus_def_id=Helper.correctNull((String)rs2.getString("DEF_ID"));
											}
										if(!cus_def_id.equalsIgnoreCase(""))
										{
											++intsize;
													hshQuery=new HashMap();
													arrValues=new ArrayList();
													hshQuery.put("strQueryId","update_cus_score");
													arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
													arrValues.add(cus_def_id);
													hshQuery.put("arrValues",arrValues);
													hshQueryValues.put(String.valueOf(intsize),hshQuery);
													hshQueryValues.put("size",String.valueOf(intsize));
										}
										else if(cus_def_id.equalsIgnoreCase("")){
											
											++intsize;
											hshQuery=new HashMap();
											arrValues=new ArrayList();
											hshQuery.put("strQueryId","ins_hun_score");
											arrValues.add(strLapscustid);
											arrValues.add(Helper.correctNull(rs.getString("BUR_HUNTER_SCORE")));
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put(String.valueOf(intsize),hshQuery);
											hshQueryValues.put("size",String.valueOf(intsize));
										}
										}
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									else if (action.equalsIgnoreCase("update")) 
									{
										hshQueryValues=new HashMap();
										hshQuery=new HashMap();
										arrValues=new ArrayList();
										hshQueryValues.put("size", "1");
										hshQuery.put("strQueryId","percompanyinfo_updatedata");
										arrValues.add(strComGroupId);
										arrValues.add(strLapscustid);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("1",hshQuery);
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
									}
									
									if (action.equalsIgnoreCase("update")) 
									{
										if(rs!=null)
											rs.close();
										if(rs1!=null)
											rs1.close();
										rs=DBUtils.executeLAPSQuery("sel_CBScustomerdetails^"+strcustid);
										if(rs.next())
										{
											String strIntroName=Helper.correctNull(rs.getString("PERAPP_INTRONAME"));
											String strIntroCBSID=Helper.correctNull(rs.getString("PERAPP_INTROCBSID"));
											
											if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("1"))
											{
												rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("PERAPP_INTROSTAFFID")));
												if(rs1.next())
												{
													strIntroName=Helper.correctNull(rs1.getString("name"));
												}
											}
											else if(Helper.correctNull(rs.getString("PERAPP_INTROTYPE")).equalsIgnoreCase("2"))
											{
												if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
												{
													strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+strIntroCBSID);
													rs1=DBUtils.executeQueryCBSConnection(strQuery);
												}
												else
												{
													strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+strIntroCBSID);
													rs1=DBUtils.executeQuery(strQuery); 
												}
												if (rs1.next()) 
												{
													strIntroName=Helper.correctNull(rs1.getString("cust_name"));
												}
											}
											
											hshQueryValues=new HashMap();
											hshQuery=new HashMap();
											arrValues=new ArrayList();
											hshQueryValues.put("size", "1");
											hshQuery.put("strQueryId","upd_CBScustomerdetails");
											arrValues.add(strIntroName);
											arrValues.add(strIntroCBSID);
											arrValues.add(strLapscustid);
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put("1",hshQuery);
											EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
											
											
											
										}
									}
								}
								 
								
								//updperapplicantprofileshg
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updperapplicantprofileshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updapplicant_kycnormsshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","updcust_contactinfotshg");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								//getperincexpensesincomestatusSHG
								
								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","getperincexpensesincomestatusSHG");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								//getPEREMPLOYERprofileemploymentstatus
								

								hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues.put("size", "1");
								hshQuery.put("strQueryId","getPEREMPLOYERprofileemploymentstatus");
								arrValues.add(strLapscustid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								
								
								
								
								
			

								
							} 
						
							
						}catch (Exception ce) {
						throw new EJBException("Error in updateLapsDatabase" + ce.toString());
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
							catch (Exception e1) {
								throw new EJBException(e1.getMessage());
							}
						}
						
						return;
					}
				}
