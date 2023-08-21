/**
 * Created by : G.Sureshkumar
 * Date : August - 27 - 2007
 * Reason : For Generating Process Note , Sanction Advice , Letter of sanction to the borrower 
 * as per UBI reqiurement.
 * 
 */
package com.sai.laps.ejb.processNote;
import java.io.ByteArrayOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "processNoteBean", mappedName = "processNoteHome")
@Remote (processNoteRemote.class)
public class processNoteBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(processNoteBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap getAgriprocessnoteGeneral(HashMap hshvalues) 
	{
			
		
		/**
		 * For getting the details for general process note cum sanction advice for Agriculture.
		 */
		
		
		HashMap hshRecord = new HashMap();
		String appno=correctNull((String)hshvalues.get("appno"));
		String strQuery;
		ResultSet  rs = null;
		ResultSet  rs1 = null;
		String app_type="";	
		String app_id="";
		String landtype="";
		String loan_facility="",facility_name="";
		ArrayList vecData=new ArrayList();		
		
		try
		{
			strQuery = SQLParser.getSqlQuery("selsanction_advicebranch^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("branchname",correctNull(rs.getString("org_name")));
			}
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("amtrequested",correctNull(rs.getString("amtreqd")));
				hshRecord.put("loanpurpose",Helper.CLOBToString(rs.getClob("loan_purposeofloan")));
			}
		
			strQuery = SQLParser.getSqlQuery("getloanterms^"+appno);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				loan_facility=correctNull(rs.getString("loan_facility"));				
			}
			
			if(loan_facility.equalsIgnoreCase("1"))
			{
				facility_name="Short Term";
			}
			else if(loan_facility.equalsIgnoreCase("2"))
			{
				facility_name="Medium Term";
			}
			else if(loan_facility.equalsIgnoreCase("3"))
			{
				facility_name="Long Term";
			}
			else
			{
				facility_name="";
			}
			
			hshRecord.put("facility_name",facility_name);
			
			app_type="a";
			strQuery = SQLParser.getSqlQuery("selprocessnote^"+app_type+"^"+appno);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
					app_id=correctNull(rs.getString("perapp_id"));
					hshRecord.put("title",correctNull(rs.getString("perapp_title")));
					hshRecord.put("name",correctNull(rs.getString("perapp_fname")));
					hshRecord.put("address1",correctNull((String)rs.getString("perapp_address1")));
					hshRecord.put("address2",correctNull((String)rs.getString("perapp_address2")));
					hshRecord.put("address3",correctNull((String)rs.getString("perapp_address3")));
					hshRecord.put("city",correctNull((String)rs.getString("city_name")));
					hshRecord.put("state",correctNull((String)rs.getString("state_name")));
					hshRecord.put("zip",correctNull((String)rs.getString("perapp_zip")));
					hshRecord.put("phone",correctNull((String)rs.getString("perapp_phone")));
					hshRecord.put("constitution",Helper.correctNull((String)rs.getString("stat_data_desc1")));
					hshRecord.put("agriincome",correctNull((String)rs.getString("perinc_agriculture")));
					hshRecord.put("otherincome",correctNull((String)rs.getString("otherinc")));
					hshRecord.put("perinc_history",correctNull((String)rs.getString("perinc_history")));
			}
			
//Add Co-Applicant,Guarantor Rent & Agriculture Deductions
			
			app_type = "'a','c'";
			strQuery = SQLParser.getSqlQuery("selprocessnoteCoApp^"+app_type+"^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strAgriIncome", correctNull((String)rs.getString("perinc_agriculture")));
				hshRecord.put("strOtherIncome", correctNull((String)rs.getString("otherinc")));
			}
			
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				landtype=correctNull(rs.getString("land_measurement"));
			}
		
			hshRecord.put("landtype",landtype);
			for(int i=1;i<=3;i++)
			{
				strQuery = SQLParser.getSqlQuery("agrlandirrigationtype^"+appno+"^"+i);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				double dblacre=0.0;
				double dblcentgunthas=0.0;
				double value=0.0;
				int temp=0;
				ArrayList vecVal = new ArrayList();
				while(rs.next())
				{	
					dblacre=Double.parseDouble(Helper.correctDouble(rs.getString("acre")));
					dblcentgunthas=Double.parseDouble(Helper.correctDouble(rs.getString("gunthacents")));
					value=Double.parseDouble(Helper.correctDouble(rs.getString("value")));
					if(landtype.equalsIgnoreCase("c"))
					{
						if(dblcentgunthas>=100)
						{
							temp=(int)dblcentgunthas/100;
							dblacre=dblacre+temp;
							temp=(int)dblcentgunthas%100;
							dblcentgunthas=temp;
						}
					}
					else
					{
						if(dblcentgunthas>=40)
						{
							temp=(int)dblcentgunthas/40;
							dblacre=dblacre+temp;
							temp=(int)dblcentgunthas%40;
							dblcentgunthas=temp;
						}
					}
				}
				vecVal.add(Helper.formatDoubleValue(dblacre));
				vecVal.add(Helper.formatDoubleValue(dblcentgunthas));
				vecVal.add(Helper.formatDoubleValue(value));
				vecData.add(vecVal);		
			}
			hshRecord.put("vecData",vecData);
			
			strQuery = SQLParser.getSqlQuery("agrlandholdingssel_apptype^"+appno+"^"+"a"+app_id);
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			vecData=new ArrayList();
			while(rs.next())
			{
				ArrayList vecVal = new ArrayList();
				String strEncumbrance=correctNull(rs.getString("land_encumbrance"));
				if(!(strEncumbrance.equalsIgnoreCase("")))
				{
					vecVal.add(correctNull(rs.getString("land_survey")));
					vecVal.add(strEncumbrance);
					vecData.add(vecVal);
				}
				
			}
			hshRecord.put("vecEncumbrance",vecData);
			if(rs1!=null)
			{
				rs1.close();
			}
			app_type="a";
			strQuery=SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+app_type+app_id); 
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("Total_MEANS",correctNull((String)rs1.getString("CR_Total_MEANS")));
			}
			
			if(rs1!=null)
			{
				rs1.close();
			}
			app_type="a";
			strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+appno+"^"+app_type+app_id);
			rs1 =DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshRecord.put("year1",correctNull(rs1.getString("year1")));
				hshRecord.put("year2",correctNull(rs1.getString("year2")));
				hshRecord.put("year3",correctNull(rs1.getString("year3")));
				hshRecord.put("grossinc1",correctNull(rs1.getString("grossinc1")));
				hshRecord.put("grossinc2",correctNull(rs1.getString("grossinc2")));
				hshRecord.put("grossinc3",correctNull(rs1.getString("grossinc3")));
			}
			
			String gua_appid="";
			app_type="g";
			ArrayList vecGua=new ArrayList();
			ArrayList vecGuarantor=new ArrayList();
			
			strQuery=SQLParser.getSqlQuery("selGuarantordet^"+appno); 
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecGua=new ArrayList();
				vecGua.add(correctNull((String)rs.getString("perapp_title")));
				vecGua.add(correctNull((String)rs.getString("GuaAppname")));
				vecGua.add(correctNull((String)rs.getString("perapp_address1")));
				vecGua.add(correctNull((String)rs.getString("perapp_address2")));
				vecGua.add(correctNull((String)rs.getString("perapp_address3")));
				vecGua.add(correctNull((String)rs.getString("city_name")));
				vecGua.add(correctNull((String)rs.getString("state_name")));
				vecGua.add(correctNull((String)rs.getString("perapp_zip")));
				vecGua.add(correctNull((String)rs.getString("perapp_phone")));
				
				gua_appid=correctNull((String)rs.getString("perapp_id"));
				app_type="g";
				
				strQuery=SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+app_type+gua_appid); 
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					vecGua.add(correctNull((String)rs1.getString("CR_Total_MEANS")));
				}
				else
				{
					vecGua.add("0.00");
				}
				vecGuarantor.add(vecGua);
				 				
			}
			hshRecord.put("vecGuarantor",vecGuarantor);
			
			strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal1^"+appno+"^BG");
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	
				hshRecord.put("Comments",Helper.correctNull((String)rs.getString("Comments")));
				
			}
			//17-12-2007
			strQuery = SQLParser.getSqlQuery("sel_recommentation_Apprisal^"+appno);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			ArrayList vecRow=new ArrayList();
			while(rs.next())
			{	
				vecRow.add(Helper.CLOBToString(rs.getClob("mail_comments")));
				
			}
			hshRecord.put("recommendations",vecRow);
			
			/*************** Co - Applicants Details *****************/
			ArrayList arrCoApp = null;
			ArrayList arrCoapplicant = new ArrayList();
			strQuery=SQLParser.getSqlQuery("selCoApplicantdet^"+appno); 
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCoApp=new ArrayList();
				arrCoApp.add(correctNull((String)rs.getString("perapp_title")));
				arrCoApp.add(correctNull((String)rs.getString("GuaAppname")));
				arrCoApp.add(correctNull((String)rs.getString("perapp_address1")));
				arrCoApp.add(correctNull((String)rs.getString("perapp_address2")));
				arrCoApp.add(correctNull((String)rs.getString("perapp_address3")));
				arrCoApp.add(correctNull((String)rs.getString("city_name")));
				arrCoApp.add(correctNull((String)rs.getString("state_name")));
				arrCoApp.add(correctNull((String)rs.getString("perapp_zip")));
				arrCoApp.add(correctNull((String)rs.getString("perapp_phone")));
				
				String coapp_appid=correctNull((String)rs.getString("perapp_id"));
				app_type="c";
				
				strQuery=SQLParser.getSqlQuery("selcreditreport2^"+appno+"^"+app_type+coapp_appid); 
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCoApp.add(correctNull((String)rs1.getString("CR_Total_MEANS")));
				}
				else
				{
					arrCoApp.add("0.00");
				}
				arrCoapplicant.add(arrCoApp);
				 				
			}
			hshRecord.put("arrCoapplicant",arrCoapplicant);
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in Getting details for process note"+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
				{
					rs.close();
				}	
				if(rs1 != null)
				{
					rs1.close();
				}	
			}catch(Exception ce)
			{
				throw new EJBException("Error in Closing Result set"+ce.toString());
			}
		}
			
		
		return hshRecord;
	}
	
	public HashMap getTertiaryProcessNote(HashMap hshValues)
	{
		//String facheadid="",facid="";
		String strQuery="";
		String Title="";
		String Title1="";
		String Title2="";
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		
		
		String strQuery1="";
		String strQuery2="";
		String strAppno="";
		String appno="";
		String comappid="";
		//String OrgCode="";
		//String aptype="";
		String strBusiType="",Branchcode="";
		String constitution="";
		//ArrayList vecVal=new ArrayList();
		try
		{
				
				//OrgCode=correctNull((String) hshValues.get("strOrgCode"));
				strAppno = correctNull((String) hshValues.get("comm_appno"));
				if(strAppno.equalsIgnoreCase(""))
				{
					strAppno = correctNull((String) hshValues.get("appno"));
				}
				
				//aptype="N";
				strQuery1 = SQLParser.getSqlQuery("comfunsel4^"+strAppno+"^N");
				rs1=DBUtils.executeQuery(strQuery1);
				
				if(rs1.next())
				{
					comappid=correctNull(rs1.getString("demo_appid"));
				}
				
				
				strQuery = SQLParser.getSqlQuery("mastgetdemographics^"+comappid);
				rs = DBUtils.executeQuery(strQuery);	
				while (rs.next())
				{ 
					String perapp_title=correctNull((String)rs.getString("perapp_title"));
					String perapp_hname=correctNull((String)rs.getString("perapp_husname"));
					
					if(perapp_title.equalsIgnoreCase("MR"))
					{
						Title="Mr.";	
					}else if(perapp_title.equalsIgnoreCase("MS"))
					{
						Title="Ms.";	
					}else if(perapp_title.equalsIgnoreCase("MRS"))
					{
						Title="Mrs.";	
					}else if(perapp_title.equalsIgnoreCase("M/S"))
					{
						Title="M/S.";	
					}
					
					
					if(perapp_hname.equalsIgnoreCase("1") && perapp_title.equalsIgnoreCase("Mr"))
					{
						Title1="S/o.";	
					}else if(perapp_hname.equalsIgnoreCase("1") && perapp_title.equalsIgnoreCase("MS"))
					{
						Title1="D/o.";	
					}else if(perapp_hname.equalsIgnoreCase("2") && perapp_title.equalsIgnoreCase("MRS"))
					{
						Title1="W/o.";	
					}
					
					if(perapp_hname.equalsIgnoreCase("1"))
					{
						Title2="Mr.";	
					}else if(perapp_hname.equalsIgnoreCase("2"))
					{
						Title2="Mr.";	
					}
					
					hshResult.put("appno",appno); 
					hshResult.put("Title",Title.toUpperCase());
					hshResult.put("Title1",Title1.toUpperCase());
					hshResult.put("Title2",Title2.toUpperCase());
					String perapp_fname=correctNull((String)rs.getString("perapp_fname"));
				    //String perapp_lname=correctNull((String)rs.getString("perapp_lname"));
					//String perapp_mname=correctNull((String)rs.getString("perapp_mname"));
					//String name=(perapp_fname+perapp_lname+perapp_mname);
					
					hshResult.put("appname",perapp_fname);
					hshResult.put("perapp_address1",correctNull((String)rs.getString("perapp_address1")));
					hshResult.put("perapp_address2",correctNull((String)rs.getString("perapp_address2")));
					hshResult.put("perapp_address3",correctNull((String)rs.getString("perapp_address3")));
					hshResult.put("perapp_city",correctNull((String)rs.getString("comm_city")));
					hshResult.put("perapp_state",correctNull((String)rs.getString("comm_state")));
					hshResult.put("perapp_zip",correctNull((String)rs.getString("perapp_zip")));
					hshResult.put("perapp_phone",correctNull((String)rs.getString("perapp_phone")));
					hshResult.put("perapp_permphone",correctNull((String)rs.getString("perapp_permphone")));
					hshResult.put("perapp_mobile",correctNull((String)rs.getString("perapp_mobile")));
					constitution=correctNull((String)rs.getString("perapp_constitution"));
					if(!constitution.equalsIgnoreCase("")){
						
						strQuery1 = SQLParser.getSqlQuery("sel_cbsstaticdescbycode^2^"+constitution);
						rs1 = DBUtils.executeQuery(strQuery1);	
						if (rs1.next())
						{ 
							hshResult.put("constitution",correctNull((String)rs1.getString("cbs_static_data_desc")));
						}
					}
				}
				//To get the branch name
				/*if(rs3!=null){
					rs3.close();}
				rs3=DBUtils.executeLAPSQuery("getbranchname^"+strAppno);
				
				String flag = "";
				while(rs3.next())
				{
					hshResult.put("branchname",correctNull((String)rs1.getString("perapp_recfrom")));
				}*/
				//To get branch code
				if(rs!=null){
					rs.close();}
				strQuery1 = SQLParser.getSqlQuery("sel_branchcode^"+comappid);
				rs=DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{	
					Branchcode=(String)correctNull(rs.getString("perapp_branchcode"));
				}	
				
				//To get the processing officers comments
				if(rs!=null){
					rs.close();}
				strQuery1 = SQLParser.getSqlQuery("sel_processcomments^"+strAppno+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{	
					hshResult.put("process_comments",Helper.CLOBToString(rs.getClob("mail_comments")));
				}	
				
				//To get inspection report comments
				if(rs!=null){
					rs.close();}
				Blob b = null;
				byte[] aBlob = null;	
				strQuery1 = SQLParser.getSqlQuery("appnotessel^"+strAppno);
				rs=DBUtils.executeQuery(strQuery1);
				ByteArrayOutputStream bios=new ByteArrayOutputStream();
				if(rs.next())
				{
					b = rs.getBlob("not_text");
					aBlob = b.getBytes(0, (int) b.length());			
					bios.write(aBlob);
					bios.flush();
					hshResult.put("techreportcomments",bios.toString());

				}	
				
				
				
				//To get the sum of loan amt(Proposed amt)
//				To get the processing officers comments
				if(rs!=null){
					rs.close();}
				strQuery1 = SQLParser.getSqlQuery("seltotproplimit^"+strAppno);
				rs=DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{	
					hshResult.put("proposed",correctNull((String)rs.getString("proposed")));
				}	
				
				//To get date of review or renewal
				if(rs!=null){
					rs.close();}
				strQuery1 = SQLParser.getSqlQuery("selapproved^"+strAppno);
				rs=DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{	
					//hshResult.put("REVIEW",correctNull((String)rs.getString("yearreview")));
					hshResult.put("REVIEW",correctNull((String)rs.getString("app_reviewdate")));
				}	
				
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_organisationname^"+Branchcode);
				 
				if(rs.next())
				{	
					//String organisationname=(String)correctNull(rs.getString("org_name"));
					hshResult.put("branchname",(String)correctNull(rs.getString("org_name")));
					hshResult.put("orgaddress1",(String)correctNull(rs.getString("org_add1")));
					hshResult.put("orgaddress2",(String)correctNull(rs.getString("org_add2")));
					//hshResult.put("orgcity",(String)correctNull(rs.getString("org_city")));
					//hshResult.put("orgstate",(String)correctNull(rs.getString("org_state")));
					hshResult.put("orgzip",(String)correctNull(rs.getString("org_zip")));
					hshResult.put("orgphone",(String)correctNull(rs.getString("org_phone")));
					hshResult.put("orgcity",(String)correctNull(rs.getString("city_name")));
					hshResult.put("orgstate",(String)correctNull(rs.getString("state_name")));
					
				}
				//To get the constitution
				if(rs!=null)
					rs.close();
					
				//rs=DBUtils.executeLAPSQuery("comowner^"+comappid);
				//if (rs.next())
				//{
				if(constitution.equalsIgnoreCase("02"))//Joint Borrowers
					strBusiType="OLC";
				else if(constitution.equalsIgnoreCase("07"))//PVT LTD COMPANY
					strBusiType="OLP";
				else if(constitution.equalsIgnoreCase("08"))//PUBLIC LTD COMPANY
					strBusiType="OCC";
				else if(constitution.equalsIgnoreCase("09"))//PARTNER SHIP
					strBusiType="OP";
				else if(constitution.equalsIgnoreCase("009"))//Sole Proprietor
					strBusiType="OS";
				else if(constitution.equalsIgnoreCase("01"))//Individual
					strBusiType="IN";
				else 										// Others
					strBusiType="OO";
				//}
//				Code for getting means of applicant
				strQuery=SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+comappid); 
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("CR_Total_MEANS",correctNull((String)rs.getString("CR_Total_MEANS")));
				}
//				Code for getting Gov offered scheme
				strQuery=SQLParser.getSqlQuery("sel_opssubsidy^"+strAppno); 
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String schmtype=correctNull((String)rs.getString("OPS_SCHEMETYPE"));
					if(!schmtype.equalsIgnoreCase("")){
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("selgovschm^"+schmtype);
						rs1 = DBUtils.executeQuery(strQuery1);	
						if (rs1.next())
						{ 
							hshResult.put("govscheme",correctNull((String)rs1.getString("stat_data_desc1")));
						}
					}					
				}
				//For specific terms and conditions

				ArrayList arrVec12=new ArrayList();
				ArrayList arrVec13 = new ArrayList();
				strQuery = SQLParser.getSqlQuery("seltermsandconditionval^" + strAppno);

				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrVec12 = new ArrayList();
					arrVec12.add(correctNull(rs.getString("terms_termdesc")));

					arrVec13.add(arrVec12);

				}
				hshResult.put("arrVec13", arrVec13);
				
				//To get the general documents
				
				//facheadid="0";
				//facid="0";
				String doctype="I",typeofdoc="gen";
				ArrayList arrDocs1=new ArrayList();
				ArrayList arrDocs2 = new ArrayList();
				strQuery = SQLParser.getSqlQuery("selFacDocMastergeneral^0^0^"+doctype.toUpperCase()+"^"+typeofdoc);
				//strQuery=SQLParser.getSqlQuery("selFacDocMaster^"+doctype+"^"+typeofdoc+"^"+doctype+"^"+); 
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrDocs1 = new ArrayList();
					arrDocs1.add(correctNull(rs.getString("doc_desc")));

					arrDocs2.add(arrDocs1);

				}
				hshResult.put("arrDocs2", arrDocs2);
				//To get specific documents
				ArrayList arrDocs3=new ArrayList();
				ArrayList arrDocs4 = new ArrayList();
				strQuery=SQLParser.getSqlQuery("selcomfacilitydocuments^0^I^"+strAppno); 
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrDocs3 = new ArrayList();
					arrDocs3.add(correctNull(rs.getString("doc_desc")));

					arrDocs4.add(arrDocs3);

				}
				hshResult.put("arrDocs4", arrDocs4);
				//To ger facility based docs ---For constitution
				//					to get the facid and facheadid
					
				ArrayList arrDocs10 = new ArrayList();
				ArrayList arrDocs6 = new ArrayList();
					strQuery=SQLParser.getSqlQuery("selOPSBorrowerFacilities^"+strAppno); 
					if(rs1!=null)
					{
						rs1.close();
					}
					String strFacsno="";
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						//facheadid1=correctNull((String)rs1.getString("facility_headid"));
						//facid1=correctNull((String)rs1.getString("facility_id"));
						strFacsno=correctNull((String)rs1.getString("facility_sno"));
					
						ArrayList arrDocs5=new ArrayList();
						
						strQuery = SQLParser.getSqlQuery("selFacDocMaster^"+doctype.toUpperCase()+"^"+strBusiType+"^"+strFacsno+"^"+strAppno);
						if(rs2!=null)
						{
							rs2.close();
						}
						rs2=DBUtils.executeQuery(strQuery);
						while(rs2.next())
						{
							arrDocs5 = new ArrayList();
							arrDocs5.add(correctNull(rs2.getString("doc_desc")));

							arrDocs6.add(arrDocs5);

						}
						
						
						ArrayList arrDocs9=new ArrayList();
						
						strQuery=SQLParser.getSqlQuery("selcomfacilitydocuments^"+strFacsno+"^"+doctype+"^"+strAppno); 
						if(rs3!=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeQuery(strQuery);
						while(rs3.next())
						{
							arrDocs9 = new ArrayList();
							arrDocs9.add(correctNull(rs3.getString("doc_desc")));

							arrDocs10.add(arrDocs9);

						}
						
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					hshResult.put("arrDocs6", arrDocs6);
					hshResult.put("arrDocs10", arrDocs10);
//						 To get the comments of the sanctioning officer
						
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("selcommworkflowsancdetails^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("Sanction_Comments",correctNull((String)rs.getString("app_sanctioningcomments")));
						}
				//To get the regular facilities
						ArrayList facility1=new ArrayList();
						ArrayList facility2=new ArrayList();
						String group="0";
						strQuery = SQLParser.getSqlQuery("selregularfac^"+strAppno+"^"+group);				
						
						if(rs!=null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							facility1=new ArrayList();
							facility1.add(correctNull(rs.getString(2)));
							facility1.add(correctNull(rs.getString(3)));
							facility1.add(correctNull(rs.getString(4)));
							facility1.add(correctNull(rs.getString(5)));
							facility1.add(correctNull(rs.getString(6)));
							facility1.add(correctNull(rs.getString(7)));
							facility1.add(correctNull(rs.getString(8)));
							facility1.add(correctNull(rs.getString(9)));
							facility1.add(correctNull(rs.getString(10)));
							facility1.add(correctNull(rs.getString(11)));
							facility1.add(correctNull(rs.getString(12)));
							facility1.add(correctNull(rs.getString(13)));
							facility2.add(facility1);
						}
						hshResult.put("facility2",facility2);
						
						//int	intGroup =0;
						strQuery = SQLParser.getSqlQuery("selOPSBorrowerFacilities^" + strAppno);
						if(rs != null)rs.close();
						rs = DBUtils.executeQuery(strQuery);
						
						
						ArrayList arrcols=new ArrayList();
						ArrayList arrrows=new ArrayList();
						String facHead="",facSubHead="",facSubHeadId="";
						int introwspan=0;
						while(rs.next())
						{	
							introwspan++;
							//intGroup = rs.getInt("facility_sno");
							String strFacSno = correctNull((String)rs.getString("facility_sno"));
							arrcols=new ArrayList();
							arrcols.add(correctNull(rs.getString("facility_headid")));
							facHead=correctNull(rs.getString("facheaddesc"));
							facSubHeadId=correctNull(rs.getString("facility_id"));
							facSubHead=correctNull(rs.getString("facdesc"));
							arrcols.add(facHead+"-"+facSubHead);
							arrcols.add(correctNull(Helper.formatDoubleValue(rs.getDouble("facility_existing"))));
							arrcols.add(correctNull(Helper.formatDoubleValue(rs.getDouble("facility_outstanding"))));
							arrcols.add(correctNull(Helper.formatDoubleValue(rs.getDouble("facility_proposed"))));
							arrcols.add(correctNull(rs.getString("facility_interest")));
							arrcols.add("");
							arrcols.add(correctNull(rs.getString("facility_months"))); //period	
							arrcols.add(correctNull(rs.getString("facility_purpose"))); // purpose
							
							if("3".equals(arrcols.get(0)) || "4".equals(arrcols.get(0)))
							{
								arrcols.add("N/A");
							}
							else
							{
								double dblInstalment=0.00;
								double dblPrincipal=0.00;
								double dblPrin=0.00;
								String dbrepay_periodicity="";
								strQuery2 = SQLParser.getSqlQuery("repayInsAmount^"+strAppno+"^"+arrcols.get(0)+"^"+facSubHeadId);	
								rs2 = DBUtils.executeQuery(strQuery2);
								if(rs2.next())
								{
									dblInstalment =  rs2.getDouble("repay_no_instalmt");
									dblPrincipal = rs2.getDouble("facility_proposed");
									dbrepay_periodicity=rs2.getString("repay_periodicity");
									if("C".equalsIgnoreCase(dbrepay_periodicity))
									{
										arrcols.add("N/A");
									}
									else
									{
											if(dblInstalment==0)dblInstalment=1;
											dblPrin = (dblPrincipal)/dblInstalment;
											arrcols.add(String.valueOf(Helper.formatDoubleValue(dblPrin)));
									}
											
																				
								}
								else
								{
									arrcols.add("");
								}
								
								
							}
						//Get Security details
							strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno
									+ "^" +  strAppno);
							if(rs1!=null)
								rs1.close();
							rs1 = DBUtils.executeQuery(strQuery);
							ArrayList arrSecurities=new ArrayList();
							ArrayList arrCol = new ArrayList();
							int j=0;
							while (rs1.next()) {
								arrCol=new ArrayList();
								arrCol.add(correctNull(rs1.getString("sec_margin"))); 
								arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
								arrSecurities.add(arrCol);
								j++;
								introwspan++;
							}
						arrcols.add(arrSecurities);	
						arrcols.add(Integer.toString(j));
						arrrows.add(arrcols);
						
						}
					
					strQuery = SQLParser.getSqlQuery("sel_opssubsidy^"+strAppno);	
					if(rs!=null) rs.close();
					rs = DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						hshResult.put("subamt",correctNull(Helper.formatDoubleValue(rs.getDouble("ops_subsidyamt"))));
					}
					
					hshResult.put("arrrows",arrrows);
					hshResult.put("introwspan",""+introwspan);
					
						
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getTertiaryProcessNote-- "+ce.toString());
			}
			finally
			{
				try
				{	if(rs != null)
					{
						rs.close();
					}
					if(rs1 != null)
					{
						rs1.close();
					}	
					if(rs2 != null)
					{
						rs2.close();
					}	
					
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection -getCorporateSanctionAdvice"+cf.getMessage());
				}
			}
			return hshResult;
		}
}