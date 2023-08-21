package com.sai.laps.ejb.edustudent;

import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "edustudentBean", mappedName = "edustudentHome")
@Remote (edustudentRemote.class)

public class edustudentBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(edustudentBean.class);
	private static final long serialVersionUID = 1L;
	public HashMap getData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String recordflag="N";
		try
		{
			String appno=correctNull((String)hshRequestValues.get("appno"));
			
			if(rs!=null)
				rs.close();	
			strQuery=SQLParser.getSqlQuery("edustudentsel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("edu_appno",correctNull(rs.getString("edu_appno")));
				hshRecord.put("edu_name",correctNull(rs.getString("edu_name")));
				hshRecord.put("edu_relation",correctNull(rs.getString("edu_relation")));
				hshRecord.put("edu_relname",correctNull(rs.getString("edu_relname")));
				hshRecord.put("edu_relgauratian",correctNull(rs.getString("edu_relgaurdian")));
				hshRecord.put("edu_dob",correctNull(rs.getString("edu_dob")).trim());
				hshRecord.put("edu_age",correctNull(rs.getString("edu_age")));
				hshRecord.put("edu_caste",correctNull(rs.getString("edu_caste")));
				hshRecord.put("edu_religion",correctNull(rs.getString("edu_religion")));
				hshRecord.put("edu_status",correctNull(rs.getString("edu_status")));
				hshRecord.put("edu_child",correctNull(rs.getString("edu_child")));
				hshRecord.put("edu_addr1",correctNull(rs.getString("edu_addr1")));
				hshRecord.put("edu_addr2",correctNull(rs.getString("edu_addr2")));
				hshRecord.put("edu_addr3",correctNull(rs.getString("edu_addr3")));
				hshRecord.put("hidcity",correctNull(rs.getString("edu_city")));
				hshRecord.put("hidstate",correctNull(rs.getString("edu_state")));
				hshRecord.put("edu_city",correctNull(rs.getString("city_name")));
				hshRecord.put("edu_state",correctNull(rs.getString("state_name")));
				hshRecord.put("edu_pincode",correctNull(rs.getString("edu_pincode")));
				hshRecord.put("edu_mobile_no",correctNull(rs.getString("edu_mobile_no")));
				hshRecord.put("edu_no_of_years",correctNull(rs.getString("edu_no_of_years")));
				hshRecord.put("edu_exp",correctNull(rs.getString("edu_exp")));
				hshRecord.put("edu_prevexperience",correctNull(rs.getString("edu_prevexperience")));
				recordflag="Y";
			}		
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataedustudent "+ce.toString());
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
		return hshRecord;
	}

	public void updateData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		
		HashMap hshQry = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String strQuery= "";
		ResultSet rs=null;
		String val="";
		String appno="";
		DecimalFormat dc=new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(1);
		dc.setMinimumFractionDigits(1);
		boolean blnactionflag = false;
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));		
			int intUpdatesize=0;
			intUpdatesize=1;
			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","edustudentdel");				
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
			if(val.equals("retrieve"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","edustudentins1");
			}
			
			strQuery=SQLParser.getSqlQuery("edustudentsel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				blnactionflag=true;
			}
			if(rs !=null){
				rs.close();
			}
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","edustudentins");
				arrVal.add(correctNull((String)hsh.get("appno")));
				arrVal.add(correctNull((String)hsh.get("namefostudent")));
				arrVal.add(correctNull((String)hsh.get("nameof")));
				arrVal.add(correctNull((String)hsh.get("nameofval")));
				arrVal.add(correctNull((String)hsh.get("guastaterelation")));
				arrVal.add(correctNull((String)hsh.get("dob")));
				arrVal.add(correctNull((String)hsh.get("age")));
				arrVal.add(correctNull((String)hsh.get("caste")));
				arrVal.add(correctNull((String)hsh.get("selreligion")));
				arrVal.add(correctNull((String)hsh.get("mstatus")));
				arrVal.add(correctNull((String)hsh.get("noofchildren")));
				arrVal.add(correctNull((String)hsh.get("addr1")));
				arrVal.add(correctNull((String)hsh.get("addr2")));
				arrVal.add(correctNull((String)hsh.get("addr3")));
				arrVal.add(correctNull((String)hsh.get("hidcity")));
				arrVal.add(correctNull((String)hsh.get("hidstate")));
				arrVal.add(correctNull((String)hsh.get("pincode")));
				arrVal.add(correctNull((String)hsh.get("mobile")));
				arrVal.add(correctNull((String)hsh.get("previous")));
				arrVal.add(correctNull((String)hsh.get("previous1")));
				arrVal.add(correctNull((String)hsh.get("prevexperience")));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
//				FOR AUDIT TRIAL
			StringBuilder sbAuditTrial=new StringBuilder();
		    if(!val.equalsIgnoreCase("delete")){
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y")){
				hsh.put("hidAction", "update");
			}else{
				hsh.put("hidAction", "insert");
			}}
			
			if (Helper.correctNull((String)hsh.get("hidAction")).equalsIgnoreCase("update") 
					|| Helper.correctNull((String)hsh.get("hidAction")).equalsIgnoreCase("insert")) 
			{
				sbAuditTrial.append(" ~Name of Student = ").append(Helper.correctNull((String)hsh.get("namefostudent")));
				sbAuditTrial.append(" ~Name of ").append(Helper.correctNull((String)hsh.get("nameof"))).append("=").append(Helper.correctNull((String)hsh.get("nameofval")));
				sbAuditTrial.append(" ~Date of Birth = ").append(Helper.correctNull((String)hsh.get("dob")));
				sbAuditTrial.append(" ~Caste= ").append(Helper.correctNull((String)hsh.get("caste")));
				sbAuditTrial.append(" ~Age= ").append(Helper.correctNull((String)hsh.get("age")));
				sbAuditTrial.append(" ~Religion= ").append(Helper.correctNull((String)hsh.get("selreligion")));
				sbAuditTrial.append(" ~No of Children if any= ").append(Helper.correctNull((String)hsh.get("noofchildren")));
				sbAuditTrial.append(" ~Marital Status = ").append(Helper.correctNull((String)hsh.get("mstatus")));
				sbAuditTrial.append(" ~Address1= ").append(Helper.correctNull((String)hsh.get("addr1")));
				sbAuditTrial.append(" ~Address2= ").append(Helper.correctNull((String)hsh.get("addr2")));
				sbAuditTrial.append(" ~Address3= ").append(Helper.correctNull((String)hsh.get("addr3")));
				sbAuditTrial.append(" ~City= ").append(Helper.correctNull((String)hsh.get("city")));
				sbAuditTrial.append(" ~State= ").append(Helper.correctNull((String)hsh.get("state")));
				sbAuditTrial.append(" ~Pin Code= ").append(Helper.correctNull((String)hsh.get("pincode")));
				sbAuditTrial.append(" ~Mobile Number = ").append(Helper.correctNull((String)hsh.get("mobile")));
				
				sbAuditTrial.append(" ~Any previous work experience = ").append(SetupParams.getSetupParams("SAABranch",Helper.correctNull((String)hsh.get("previous1"))));
				if(SetupParams.getSetupParams("SAABranch",Helper.correctNull((String)hsh.get("previous1"))).equalsIgnoreCase("Yes"))
				{
					sbAuditTrial.append(" ~No of Years = ").append(Helper.correctNull((String)hsh.get("previous")));
					sbAuditTrial.append(" ~Work Experience = ").append(Helper.correctNull((String)hsh.get("prevexperience")));
				}
				/*else if(SetupParams.getSetupParams("SAABranch",Helper.correctNull((String)hsh.get("previous1"))).equalsIgnoreCase("No"))
				{
					sbAuditTrial.append(" ~No of Years = ").append("Nil");
					sbAuditTrial.append(" ~Work Experience = ").append("Nil");
				}*/
				
				
				
			}
			AuditTrial.auditLog(hsh,"41",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
		
		
	}
//	 public HashMap getPrintData(HashMap hshRequestValues) 
//	{		
//		
//		String strQuery = "";
//		ResultSet rs = null;
//		HashMap hshRecord = null;
//	 
//		ArrayList vecData = new ArrayList();
//		ArrayList vecVal=new ArrayList();
//		ArrayList vecData1 = new ArrayList();
//		ArrayList vecVal1=new ArrayList();
//		ArrayList vecData2 = new ArrayList();
//		ArrayList vecVal2=new ArrayList();
//		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
//			jtn.setMaximumFractionDigits(2);
//			jtn.setMinimumFractionDigits(2);
//			jtn.setGroupingUsed(false);
//		try
//		{
//			
//			String appno=correctNull((String)hshRequestValues.get("appno"));
//
//					
//			if(rs!=null)
//			rs.close();	
//			rs=DBUtils.executeLAPSQuery("edustudentsel^"+appno);
//
//			if (rs.next())
//			{
//				hshRecord = new HashMap();
//				hshRecord.put("edu_appno",correctNull(rs.getString("edu_appno")));
//				hshRecord.put("edu_name",correctNull(rs.getString("edu_name")));
//				hshRecord.put("edu_relation",correctNull(rs.getString("edu_relation")));
//				hshRecord.put("edu_relname",correctNull(rs.getString("edu_relname")));
//				hshRecord.put("edu_relgauratian",correctNull(rs.getString("edu_relgaurdian")));
//				hshRecord.put("edu_dob",correctNull(rs.getString("edu_dob")));
//				hshRecord.put("edu_age",correctNull(rs.getString("edu_age")));
//				hshRecord.put("edu_caste",correctNull(rs.getString("edu_caste")));
//				hshRecord.put("edu_religion",correctNull(rs.getString("edu_religion")));
//				hshRecord.put("edu_status",correctNull(rs.getString("edu_status")));
//				hshRecord.put("edu_child",correctNull(rs.getString("edu_child")));
//				hshRecord.put("edu_addr1",correctNull(rs.getString("edu_addr1")));
//				hshRecord.put("edu_addr2",correctNull(rs.getString("edu_addr2")));
//				hshRecord.put("edu_city",correctNull(rs.getString("edu_city")));
//				hshRecord.put("edu_state",correctNull(rs.getString("edu_state")));
//				hshRecord.put("edu_pincode",correctNull(rs.getString("edu_pincode")));
//				hshRecord.put("edu_mobile_no",correctNull(rs.getString("edu_mobile_no")));
//				hshRecord.put("edu_no_of_years",correctNull(rs.getString("edu_no_of_years")));
//			}
//			if(hshRecord==null){
//				log.info("$ Record Not Found");
//			}
//			
//			if(rs!=null)
//			rs.close();	
//			
//			strQuery = SQLParser.getSqlQuery("eduparticularssel^"+appno);
//			rs=DBUtils.executeQuery(strQuery);
//			
//			if(hshRecord!=null)
//			{
//			while(rs.next())
//			{
//				
//				hshRecord.put("eduloan_appno",(String)correctNull(rs.getString("eduloan_appno")));
//				hshRecord.put("edu_coursename",correctNull(rs.getString("edu_coursename")));
//				hshRecord.put("edu_university",correctNull(rs.getString("edu_university")));
//				hshRecord.put("edu_duration",correctNull(rs.getString("edu_duration")));
//				
//				if(correctNull(rs.getString("edu_partfull")).equals("parttime"))
//				{
//					hshRecord.put("edu_partfull","Part - Time");
//				}
//				else if(correctNull(rs.getString("edu_partfull")).equals("fulltime"))
//				{
//					hshRecord.put("edu_partfull","Regular");
//				}
//				else if(correctNull(rs.getString("edu_partfull")).equals("Correspondence"))
//				{
//					hshRecord.put("edu_partfull","Correspondence /Distance");
//				}
//				else
//				{
//					hshRecord.put("edu_partfull","");
//				}
//
//
//				hshRecord.put("edu_other",correctNull(rs.getString("edu_other")));
//				hshRecord.put("edu_any",correctNull(rs.getString("edu_any")));
//				hshRecord.put("edu_insurance",correctNull(rs.getString("edu_insurance")));
//				
//				if(correctNull(rs.getString("edu_proposed")).equals("1"))
//				{
//					hshRecord.put("edu_proposed","Doctorate /Other Professional");
//				}
//				else if(correctNull(rs.getString("edu_proposed")).equals("2"))
//				{
//					hshRecord.put("edu_proposed","Post Graduate");
//				}
//				else if(correctNull(rs.getString("edu_proposed")).equals("3"))
//				{
//					hshRecord.put("edu_proposed","Graduate");
//				}
//				else if(correctNull(rs.getString("edu_proposed")).equals("4"))
//				{
//					hshRecord.put("edu_proposed","Higher Secondary");
//				}
//				else
//				{
//					hshRecord.put("edu_proposed","");
//				}
//
//
//				
//				
//			}
//
//			if(rs!=null)
//			rs.close();	
//			
//			rs=DBUtils.executeLAPSQuery("educourseselection^"+appno);
//			while(rs.next())
//			{
//				vecVal = new ArrayList();
//				vecVal.add(correctNull(rs.getString("edu_id")));
//				vecVal.add(correctNull(rs.getString("edu_year")));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_tution")));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_exam")));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_books")));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_lodge")));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_lab")));
//				double dblTotalExp=0.00;
//				dblTotalExp=Double.parseDouble((String)rs.getString("edu_tution"))+Double.parseDouble((String)rs.getString("edu_exam"))+Double.parseDouble((String)rs.getString("edu_books"))+
//Double.parseDouble((String)rs.getString("edu_lodge"))+Double.parseDouble((String)rs.getString("edu_lab"));
//				vecVal.add(String.valueOf(jtn.format(dblTotalExp)));
//				vecVal.add(Helper.correctDouble(rs.getString("edu_scholar")));
//				double dblTotalReq=0.00;
//				dblTotalReq=dblTotalExp - Double.parseDouble((String)rs.getString("edu_scholar"));
//				vecVal.add(String.valueOf(jtn.format(dblTotalReq)));
//				
//				
//				vecData.add(vecVal);							
//			}	
//			if(vecData.size()>0)
//			{
//				hshRecord.put("vecData",vecData);
//			}
//						
//			if(rs!=null)
//			rs.close();	
//			
//			rs=DBUtils.executeLAPSQuery("edudetailsselection^"+appno);
//			while(rs.next())
//			{
//				vecVal1= new ArrayList();
//				vecVal1.add(correctNull(rs.getString("edu_id")));
//				vecVal1.add(correctNull(rs.getString("edu_exam")));
//				vecVal1.add(correctNull(rs.getString("edu_university")));
//				vecVal1.add(correctNull(rs.getString("edu_yearpass")));
//				vecVal1.add(correctNull(rs.getString("edu_attempts")));
//				vecVal1.add(correctNull(rs.getString("edu_marks")));
//				vecVal1.add(correctNull(rs.getString("edu_class")));
//
//				vecData1.add(vecVal1);							
//			}	
//			//hshRecord.put("vecData1",vecData1);
//			if(vecData1.size()>0)
//			{
//				hshRecord.put("vecData1",vecData1);
//			}
//
//			
//			if(rs!=null)
//			rs.close();	
//			
//			rs=DBUtils.executeLAPSQuery("eduscholarsselection^"+appno);
//			while(rs.next())
//			{
//				vecVal2 = new ArrayList();
//				vecVal2.add(correctNull(rs.getString("edu_id")));
//				vecVal2.add(correctNull(rs.getString("edu_exam")));
//				vecVal2.add(correctNull(rs.getString("edu_academic")));
//				vecVal2.add(correctNull(rs.getString("edu_name")));
//				vecVal2.add(correctNull(rs.getString("edu_amount")));
//				String strFrom=correctNull(rs.getString("edu_from"));
//				String strTo=correctNull(rs.getString("edu_to"));
//				if (strFrom.trim().equals("01/01/1900"))
//				{
//					vecVal2.add("");
//				}
//				else
//				{
//				vecVal2.add(strFrom);
//				}
//				if (strTo.trim().equals("01/01/1900"))
//				{
//					vecVal2.add("");
//				}
//				else
//				{
//				vecVal2.add(strTo);
//				}
//
//				vecData2.add(vecVal2);							
//			}	
////			hshRecord.put("vecData2",vecData2);
//			if(vecData2.size()>0)
//			{
//				hshRecord.put("vecData2",vecData2);
//			}
//			}
//			
//		}
//		catch(Exception ce)
//		{
//			
//			throw new EJBException("Student Record Not Found"+ce.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//				
//				
//			}
//			catch(Exception cf)
//			{
//			throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//	
//	return hshRecord;
//}
	 //To retrieve details from customer profile if student is applicant
	 public HashMap getStudentDetails(HashMap hshRequestValues)
	 {
		 	String strQuery = "";
			ResultSet rs = null;
			HashMap hshRecord = null;
			try
			{
				String strappid=correctNull((String)hshRequestValues.get("hidapplicantid"));
				rs=DBUtils.executeLAPSQuery("mastgetdemographicsforedu^"+strappid);

				if (rs.next())
				{
					hshRecord = new HashMap();
					hshRecord.put("perapp_fname",correctNull(rs.getString("perapp_fname")));
					hshRecord.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
					hshRecord.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
					hshRecord.put("perapp_address3",correctNull(rs.getString("perapp_address3")));
					hshRecord.put("perapp_city",correctNull(rs.getString("perapp_city")));
					hshRecord.put("perapp_state",correctNull(rs.getString("perapp_state")));
					
					hshRecord.put("perapp_cityname",correctNull(rs.getString("comm_city")));
					hshRecord.put("perapp_statename",correctNull(rs.getString("comm_state")));
					hshRecord.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
					hshRecord.put("perapp_mobile",correctNull(rs.getString("perapp_mobile")));
					hshRecord.put("perapp_dob",correctNull(rs.getString("perapp_dob")));
					String birthdate = correctNull((String) rs.getString("perapp_dob"));
					String currentdate = Helper.getCurrentDateTime();
					currentdate = currentdate.substring(6, 10);
					birthdate = birthdate.substring(6, 10);
					String strAge = Integer.toString(Integer.parseInt(currentdate) - Integer.parseInt(birthdate));
					hshRecord.put("perapp_age", strAge);
					hshRecord.put("perapp_marstat",correctNull(rs.getString("perapp_marstat")));
					hshRecord.put("perapp_fatname",correctNull(rs.getString("perapp_fatname")));
					hshRecord.put("perapp_religion",correctNull(rs.getString("perapp_religion")));
					hshRecord.put("per_caste",correctNull(rs.getString("per_caste")));
					hshRecord.put("perapp_childnum",correctNull(rs.getString("perapp_childnum")));
					hshRecord.put("guardian",correctNull(rs.getString("guardian")));
					hshRecord.put("minor",correctNull(rs.getString("minor")));
					hshRecord.put("gua_name",correctNull(rs.getString("gua_name")));
					
				}	
					
			}
			catch(Exception ae)
			{
				throw new EJBException("Student Record Not Found in customer profile "+ae.getMessage());
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
			return hshRecord;
	 }
}

	 
		 
