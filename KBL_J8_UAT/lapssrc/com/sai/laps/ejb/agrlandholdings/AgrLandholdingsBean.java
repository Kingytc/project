package com.sai.laps.ejb.agrlandholdings;

import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.rules.AgrLandHoldingsBO;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "AgrLandholdingsBean", mappedName = "AgrLandholdingsHome")
@Remote (AgrLandholdingsRemote.class)
public class AgrLandholdingsBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(AgrLandholdingsBean.class);	
	private static final long serialVersionUID = 1L;

	public  HashMap getData(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3  = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strorgcode="";
		/*String strprd_type=correctNull((String)hshValues.get("strProductType"));
		String prd_type="";
		if(!strprd_type.equalsIgnoreCase(""))
		{
			prd_type=strprd_type.substring(0,1);
		}*/
		String chobank_apptype=Helper.correctNull((String)hshValues.get("chobank_apptype"));
		String  strAppType="",strAppID="",appType="",strAppName="",strComappid="",strFarmcategory="";
       try
		{
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
			strorgcode=correctNull((String)hshValues.get("strOrgCode"));
			if(chobank_apptype.equalsIgnoreCase("0"))
			{
				strQuery = SQLParser.getSqlQuery("sel_applicantid^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))) );
					hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))) );
					hshRecord.put("applicantid",rs1.getString("demo_comappid"));
					strComappid=Helper.correctNull((String)rs1.getString("demo_comappnewid")); 
				}
			}
			else if(!(chobank_apptype.equalsIgnoreCase("")))
			{
				
				strQuery = SQLParser.getSqlQuery("sel_Promoterapplicantid^"+appno+"^"+chobank_apptype);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strComappid=Helper.correctNull((String)rs1.getString("COM_COMPDTAPPID")); 
				}
				
			}
			if(strAction.trim().equals("get"))
			{
				/*strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+strComappid+"^"+chobank_apptype);
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					hshRecord.put("year1",correctNull(rs2.getString("year1")));
					hshRecord.put("year2",correctNull(rs2.getString("year2")));
					hshRecord.put("year3",correctNull(rs2.getString("year3")));
					hshRecord.put("grossinc1",correctNull(rs2.getString("grossinc1")));
					hshRecord.put("grossinc2",correctNull(rs2.getString("grossinc2")));
					hshRecord.put("grossinc3",correctNull(rs2.getString("grossinc3")));
				}*/
			}
			if(!strComappid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("agrlandholdingsselection^"+strComappid);
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs2.getString("LAND_APPID")));
					vecVal.add(correctNull(rs2.getString("land_apptype")));
					strQuery = SQLParser.getSqlQuery("Applicantname_sel^"+strComappid);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strAppName=correctNull(rs.getString("appname"));
					}
					vecVal.add(correctNull(rs2.getString("land_id")));
					vecVal.add(correctNull(rs2.getString("land_acreage")));
					vecVal.add(correctNull(rs2.getString("land_village")));
					vecVal.add(correctNull(rs2.getString("land_taluk")));
					vecVal.add(correctNull(rs2.getString("land_district")));
					vecVal.add(correctNull(rs2.getString("land_survey")));
					vecVal.add(correctNull(rs2.getString("land_revenue")));
					vecVal.add(correctNull(rs2.getString("land_value")));
					vecVal.add(correctNull(rs2.getString("land_owned_leased")));
					vecVal.add(correctNull(rs2.getString("land_leaseperiod")));
					vecVal.add(correctNull(rs2.getString("land_rent_repay")));
					vecVal.add(correctNull(rs2.getString("land_irrigated")));
					vecVal.add(correctNull(rs2.getString("land_which_irrigated")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_source")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_encumbrance")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_Encroached_Land")))));
					vecVal.add(correctNull(rs2.getString("land_farmdistance")));
					vecVal.add(correctNull(rs2.getString("land_housedistance")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_landlorddetails")))));//20
					vecVal.add(correctNull(rs2.getString("land_acreage1")));
					vecVal.add(correctNull(rs2.getString("land_mortgage")));
					vecVal.add(correctNull(rs2.getString("land_security")));
					vecVal.add(strAppName);
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("LAND_FRUIT")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_nonfruit")))));
					vecVal.add(correctNull(rs2.getString("land_datemortgage")));
					vecVal.add(correctNull(rs2.getString("LAND_IRRIGSIZE")));
					vecVal.add(correctNull(rs2.getString("LAND_NONIRRIGA")));
					vecVal.add(correctNull(rs2.getString("LAND_NONCULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_CULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_FARMERCATEGORY")));
					strFarmcategory=Helper.correctNull(rs2.getString("LAND_FARMERCATEGORY"));
					if(!strFarmcategory.equalsIgnoreCase(""))
					{
						hshRecord.put("strFarmcategory",strFarmcategory);
					}
					/*strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+appno+"^"+strAppType);
					rs1 =DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecVal.add(correctNull(rs1.getString("year1")));
						vecVal.add(correctNull(rs1.getString("year2")));
						vecVal.add(correctNull(rs1.getString("year3")));
						vecVal.add(correctNull(rs1.getString("grossinc1")));
						vecVal.add(correctNull(rs1.getString("grossinc2")));
						vecVal.add(correctNull(rs1.getString("grossinc3")));
					}*/
					vecData.add(vecVal);		
				}
			}
			hshRecord.put("vecData",vecData);
	    	/*strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs3 = DBUtils.executeQuery(strQuery);
			if(rs3.next())
			{
				hshRecord.put("land_measurement",Helper.correctNull(rs3.getString("land_measurement")));
			}*/
			if(!strComappid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("selLandAcreage^" + strComappid);
				if (rs.next())
				{
					hshRecord.put("strAcress", correctNull((String) rs.getString(1)));
				}
			}
			hshRecord.put("chobank_apptype",chobank_apptype);
			hshRecord.put("hidAction",strAction);
			
			/** Added by DINESH on 28-03-2014 for KCC -  Interest Subvention Tab **/
			String strFacilitycode="",strselectscheme="",strScheme="",fac_id="";
			
			strselectscheme = Helper.correctNull((String)hshValues.get("schemetype"));
			
			if(strselectscheme.equalsIgnoreCase(""))
			{
				strselectscheme =  Helper.correctNull((String)hshValues.get("sel_scheme"));
			}
			if(!strselectscheme.equalsIgnoreCase(""))
			{
				if(!strselectscheme.equalsIgnoreCase("0"))
				{
				String strSelectSchemesplit[] = strselectscheme.split("-");
				strFacilitycode= strSelectSchemesplit[0];
				strScheme=strSelectSchemesplit[1];
				}
				else
				{
					strFacilitycode="";
					strScheme="";
				}
			}
			else
			{
				strFacilitycode="";
				strScheme="";
			}
			
			if(!strFacilitycode.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_faccorp_facid^"+appno+"^"+strScheme+"^"+strFacilitycode);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					fac_id = Helper.correctNull((String)rs.getString("com_facid")); 
					hshRecord.put("strLoanType", correctNull((String) rs.getString("com_facility_loantype")));
					
				}
			}
			if(strScheme.equalsIgnoreCase("aQ"))
			{	
				String strbranchin="";
				strQuery = SQLParser.getSqlQuery("organisations_select_branchin^" + strorgcode);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					strbranchin= correctNull((String) rs1.getString("org_branchin"));
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				if(strbranchin.equalsIgnoreCase("1") || strbranchin.equalsIgnoreCase("2"))
				{
					strQuery = SQLParser.getSqlQuery("sel_otherdetails^" + fac_id);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) 
					{
						hshRecord.put("com_subvention", correctNull((String) rs1.getString("com_subvention")));
					}
				}
			}
			/** End **/
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
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
	
	public HashMap getDatareject(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String actionflag = correctNull((String)hshRequestValues.get("hidflagtype"));
		String appno=correctNull((String)hshRequestValues.get("strappno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshRequestValues.get("appno"));
		}
		try
		{			
			strQuery = SQLParser.getSqlQuery("getagrrejdetails");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{   vecCol = new ArrayList();
				for (int i=0 ;i<2; i++ )
				{
					vecCol.add(rs.getString(i+1));
				}
				vecRow.add(vecCol);
			}			
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidflagtype",actionflag);
			String regstatus="";
			rs=null;
			strQuery = SQLParser.getSqlQuery("agrsecureselectreg^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{ 
				regstatus=Helper.correctNull(rs.getString("loan_regdetails"));
			}
			if(regstatus.equalsIgnoreCase(""))
			{
				hshRecord.put("status","no");
			}
			else
			{
				hshRecord.put("status","yes");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}

	private int getMaxGradeId(String appno)
	{
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("agrlandholdingsmax^"+appno);
			rs = DBUtils.executeQuery(strQuery);
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
			if(rs!=null)rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return termId;
	}
	
	public void updateRegData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("strappno"));	
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{
			strGradeId =  correctNull((String)hshValues.get("hidstatus"));				
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","agrsecureupd");		
			arrValues.add(strGradeId);
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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

	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		int flag=0;
		String strQuery="";
		String chobank_apptype = Helper.correctNull((String)hshValues.get("chobank_apptype"));
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
      	String measurementval="";
    	if(measurementtype.equalsIgnoreCase("c"))
  		{
    		 measurementval = "Cents";
 		}
 		else
 		{
			 measurementval = "Guntas";
		}
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		StringBuilder sbAuditTrialOld = null;
		try
		{
			sbAuditTrialOld = new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
			strGradeId =  correctNull((String)hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrlandholdingssel_audit^"+appno+"^"+chobank_apptype+"^"+strGradeId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strAppType = Helper.correctNull(rs.getString("land_apptype"));
				String strAppType1 = "";
				if(strAppType.substring(0,1).equalsIgnoreCase("a")){
					strAppType1 = "Applicant";
				}else if(strAppType.substring(0,1).equalsIgnoreCase("c")){
					strAppType1 = "Co-Applicant";
				}else if(strAppType.substring(0,1).equalsIgnoreCase("g")){
					strAppType1 = "Guarantor";
				}
				int len = strAppType.length();
				String strAppValue = strAppType.substring(1,len);
				strQuery = SQLParser.getSqlQuery("getAppName^"+strAppValue);
				rs1 = DBUtils.executeQuery(strQuery);
				String strAppName = "";
				if(rs1.next()){
					strAppName = correctNull(rs1.getString("perapp_name"));
				}
				sbAuditTrialOld
				.append("~Applicant Type & Name = ").append(strAppType1+" - "+strAppName)
				.append("~Village = ").append(correctNull(rs.getString("land_village")))
				.append("~Taluk = ").append(correctNull(rs.getString("land_taluk")))
				.append("~District = ").append(correctNull(rs.getString("land_district")))
				.append("~Survey No = ").append(correctNull(rs.getString("land_survey")))
				.append("~Land revenue (Rs) = ").append(correctNull(rs.getString("land_revenue")))
				.append("~Value (Rs in Lakh) = ").append(correctNull(rs.getString("land_value")))
				.append("~Extent (Inclusive of Encroached Land) Acre = ").append(correctNull(rs.getString("land_acreage"))+"Acre"+correctNull(rs.getString("land_acreage1"))+"Cents");
				if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("1")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Owned");
				}
				else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("2")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Leased");
				sbAuditTrialOld
				.append("~Unexpired Lease / Rent period = ").append(correctNull(rs.getString("land_leaseperiod")))
				.append("~Annual rent payable = ").append(correctNull(rs.getString("land_rent_repay")));
				}
				else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("3")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Share Cropper");
				}else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("4")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Others");
				}
				sbAuditTrialOld
				.append("~Security = ").append(ApplicantParams.getApplicantParams("LandHoldingsSecutrity",correctNull(rs.getString("land_security"))));
				if(correctNull(rs.getString("land_security")).equalsIgnoreCase("1"))
				{
				sbAuditTrialOld	
				.append("~Mortgage = ").append(ApplicantParams.getApplicantParams("LandHoldingsMortgage",correctNull(rs.getString("land_mortgage"))))
				.append("~Date of charge/mortgage = ").append(correctNull(rs.getString("land_datemortgage")));
				}
				sbAuditTrialOld
				.append("~Particulars of land = ").append(ApplicantParams.getApplicantParams("LandHoldingsParticulars",correctNull(rs.getString("land_irrigated"))))
				.append("~Farm Distance From Our Branch = ").append(correctNull(rs.getString("land_farmdistance")))
				.append("~House Distance From Our Branch = ").append(correctNull(rs.getString("land_housedistance")));
			   }
			 if(rs!=null){
				 rs.close();
			 }
			 strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+appno+"^"+chobank_apptype);
			 rs = DBUtils.executeQuery(strQuery);
			 if(rs.next()){
				sbAuditTrialOld
				.append("~   Last Three Years Production Data(Grross) ")
				.append("~Year1 =").append(correctNull(rs.getString("year1"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc1")))
				.append("~Year2 =").append(correctNull(rs.getString("year2"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc2")))
				.append("~Year3 =").append(correctNull(rs.getString("year3"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc3")));
			 }
			
			}
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsupdate");			
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("village")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_taluk")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("survey")));
				String val4=Helper.correctNull((String)hshValues.get("txt_landrevenue"));
				if(val4.equalsIgnoreCase(""))
				{
					val4="0.00";
				}
				arrValues.add(val4);
				String val=Helper.correctNull((String)hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);
				arrValues.add(Helper.correctNull((String)hshValues.get("sellease")));
				String val1=Helper.correctNull((String)hshValues.get("leaseperiod"));
				if(val1.equalsIgnoreCase(""))
				{
					val1="0";
				}
				arrValues.add(val1);
				String val2=Helper.correctNull((String)hshValues.get("txt_amtrent"));
				if(val2.equalsIgnoreCase(""))
				{
					val2="0.00";
				}
				arrValues.add(val2);
				arrValues.add(Helper.correctNull((String)hshValues.get("selirrigation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("source")));
				arrValues.add(Helper.correctNull((String)hshValues.get("encumbrance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_encroached")));
				arrValues.add(Helper.correctNull((String)hshValues.get("farmdistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("housedistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("Mortgage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("security")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_fruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_nonfruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dateofmortgage")));
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.trim().equals("insert"))
			{				
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsinsert");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("village")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_taluk")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("survey")));
				String val4=Helper.correctNull((String)hshValues.get("txt_landrevenue"));
				if(val4.equalsIgnoreCase(""))
				{
					val4="0.00";
				}
				arrValues.add(val4);
				String val=Helper.correctNull((String)hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);
				arrValues.add(Helper.correctNull((String)hshValues.get("sellease")));
				String val1=Helper.correctNull((String)hshValues.get("leaseperiod"));
				if(val1.equalsIgnoreCase(""))
				{
					val1="0";
				}
				arrValues.add(val1);
				String val2=Helper.correctNull((String)hshValues.get("txt_amtrent"));
				if(val2.equalsIgnoreCase(""))
				{
					val2="0.00";
				}
				arrValues.add(val2);
				arrValues.add(Helper.correctNull((String)hshValues.get("selirrigation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("source")));
				arrValues.add(Helper.correctNull((String)hshValues.get("encumbrance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_encroached")));
				arrValues.add(Helper.correctNull((String)hshValues.get("farmdistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("housedistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("Mortgage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("security")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_fruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_nonfruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dateofmortgage")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsdelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				strQuery = SQLParser.getSqlQuery("agrlandholdingssel_apptype^"+appno+"^"+chobank_apptype);
				rs2 =DBUtils.executeQuery(strQuery);				
				if(rs2.next())
				{
					flag=1;
				}
				else
				{
					flag=0;
				}
				
				if(flag==0)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_grossdatadel");
					arrValues.add(appno);
					arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			if(strAction.equals("insert") || strAction.equals("update"))
			{
				arrValues = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_grossdatadel");
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				arrValues.add(strGradeId);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year1")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year2")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year3")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc1")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc2")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc3")));
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_grossdatains");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			sbAuditTrial
			.append("~Applicant Type & Name = ").append(correctNull((String)hshValues.get("hidchobank_apptype")))
			.append("~Village = ").append(correctNull((String)hshValues.get("village")))
			.append("~Taluk = ").append(correctNull((String)hshValues.get("txt_taluk")))
			.append("~District = ").append(correctNull((String)hshValues.get("txt_district")))
			.append("~Survey No = ").append(correctNull((String)hshValues.get("survey")))
			.append("~Land revenue (Rs) = ").append(correctNull((String)hshValues.get("txt_landrevenue")))
			.append("~Value (Rs in Lakh) = ").append(correctNull((String)hshValues.get("txt_value")))
			.append("~Extent (Inclusive of Encroached Land) Acre = ").append(correctNull((String)hshValues.get("txt_acreage")))
			.append("~"+measurementval+" = ").append(correctNull((String)hshValues.get("txt_acreage1")));
			
			if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Owned");
			}else if(correctNull((String)hshValues.get("sellease")).equals("2"))
			{	
				sbAuditTrial
				.append("~Whether Owned/Leased = ").append("Leased")
				.append("~Unexpired Lease / Rent period = ").append(correctNull((String)hshValues.get("leaseperiod")))
				.append("~Annual rent payable = ").append(correctNull((String)hshValues.get("txt_amtrent")));
			}else if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Share Cropper");
			}else if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("4"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Others");
			}
			
			sbAuditTrial.append(
			"~Security = ").append(ApplicantParams.getApplicantParams("LandHoldingsSecutrity",correctNull((String)hshValues.get("security"))));
			if(correctNull((String)hshValues.get("security")).equalsIgnoreCase("1")){
			sbAuditTrial
			.append("~Mortgage = ").append(ApplicantParams.getApplicantParams("LandHoldingsMortgage",correctNull((String)hshValues.get("Mortgage"))))
			.append("~Date of charge/mortgage = ").append(correctNull((String)hshValues.get("txt_dateofmortgage")));
			}
			sbAuditTrial
			.append("~Particulars of land = ").append(ApplicantParams.getApplicantParams("LandHoldingsParticulars",correctNull((String)hshValues.get("selirrigation")))).append(
			"~Farm Distance From Our Branch = ").append(correctNull((String)hshValues.get("farmdistance"))).append(
			"~House Distance From Our Branch = ").append(correctNull((String)hshValues.get("housedistance")));
			
			sbAuditTrial
			.append("~   Last Three Years Production Data(Gross) ")
			.append("~Year1 =").append(correctNull((String)hshValues.get("txt_year1"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc1")))
			.append("~Year2 =").append(correctNull((String)hshValues.get("txt_year2"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc2")))
			.append("~Year3 =").append(correctNull((String)hshValues.get("txt_year3"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc3")));
			}
			if(!strAction.equalsIgnoreCase("get"))
			{
			AuditTrial.auditNewLog(hshValues, "217", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public  HashMap getDatainvest(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		
		try
		{	
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeId= correctNull((String)hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))) );
				hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))) );
				hshRecord.put("applicantid",rs.getString("demo_appid"));
			}
			if(strAction.trim().equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("agrinvestmentsel^"+appno+"^"+strGradeId);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selectagrinvestment^"+appno);
			}			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("invloan_appno")));
				vecVal.add(correctNull(rs.getString("invloan_id")));
				vecVal.add(Helper.correctNull(rs.getString("invloan_assettype")));
				vecVal.add(Helper.correctNull(rs.getString("invloan_breedmake")));
				vecVal.add(Helper.correctNull(rs.getString("invloan_totalsqft")));
				vecVal.add(Helper.correctNull(rs.getString("invloan_ageofasset")));
				vecVal.add(Helper.correctNull(rs.getString("invloan_year")));
				vecVal.add(Helper.correctDouble(rs.getString("invloan_cost")));
				vecVal.add(Helper.correctDouble(rs.getString("invloan_subsidy")));
				vecVal.add(Helper.correctDouble(rs.getString("invloan_margin")));
				vecVal.add(Helper.correctDouble(rs.getString("invloan_loanamountrequird")));
				double dblTotalExp=0.00;				
				dblTotalExp= Double.parseDouble(Helper.correctDouble(rs.getString("invloan_cost")))+
				Double.parseDouble(Helper.correctDouble(rs.getString("invloan_subsidy")))+
				Double.parseDouble(Helper.correctDouble(rs.getString("invloan_margin"))) + 
				Double.parseDouble(Helper.correctDouble(rs.getString("invloan_loanamountrequird")));
				vecVal.add(String.valueOf(jtn.format(dblTotalExp)));
				vecVal.add(Helper.correctDouble(rs.getString("invloan_selsubsidy")));
				vecData.add(vecVal);							
			}			
			hshRecord.put("vecData",vecData);
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
		return hshRecord;
	}
	
	private int getMaxGradeIdinvest(String appno)
	{
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("agrinvestmax^"+appno);
			rs = DBUtils.executeQuery(strQuery);
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
			if(rs != null)rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDatainvest "+ce.toString());
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
	
	public HashMap getDataConsumptionloan(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno=correctNull((String)hshValues.get("strappno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("selectagr_Consumptionloan^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("AGR_PATIENTNAME",Helper.correctNull(rs.getString("AGR_PATIENTNAME")));
				hshRecord.put("AGR_DOCNAME",Helper.correctNull(rs.getString("AGR_DOCNAME")));
				hshRecord.put("AGR_CHILDNAME",Helper.correctNull(rs.getString("AGR_CHILDNAME")));
				hshRecord.put("AGR_CLASS",Helper.correctNull(rs.getString("AGR_CLASS")));
				hshRecord.put("AGR_YEAROFSTUDY",Helper.correctNull(rs.getString("AGR_YEAROFSTUDY")));
				hshRecord.put("AGR_SCHOOL",Helper.correctNull(rs.getString("AGR_SCHOOL")));
				hshRecord.put("AGR_BRIDENAME",Helper.correctNull(rs.getString("AGR_BRIDENAME")));
				hshRecord.put("AGR_BRIDEGROOMNAME",Helper.correctNull(rs.getString("AGR_BRIDEGROOMNAME")));
				hshRecord.put("AGR_MARRPLACE",Helper.correctNull(rs.getString("AGR_MARRPLACE")));
				hshRecord.put("AGR_MARRDATE",Helper.correctNull(rs.getString("AGR_MARRDATE")));
				hshRecord.put("AGR_DECEASED",Helper.correctNull(rs.getString("AGR_DECEASED")));
				hshRecord.put("AGR_NEWBORNCHILD",Helper.correctNull(rs.getString("AGR_NEWBORNCHILD")));
				hshRecord.put("AGE_CEREMONYNAME",Helper.correctNull(rs.getString("AGE_CEREMONYNAME")));
				hshRecord.put("AGR_CEREMONYDATE",Helper.correctNull(rs.getString("AGR_CEREMONYDATE")));
				hshRecord.put("AGR_FININSTITUTION",Helper.correctNull(rs.getString("AGR_FININSTITUTION")));
				hshRecord.put("AGR_OURBANK",Helper.correctNull(rs.getString("AGR_OURBANK")));
				hshRecord.put("auditFlag", "Y");
			}
		}catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getDataConsumptionloan-AgrLandholdingsBean "+ exp.toString()); 
			}
		}
		return hshRecord;
	}
	
	public void updateConsumptionloan(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction = correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		StringBuilder sb=null;
		
		try
		{
			sb=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagr_Consumptionloan");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","insertagr_Consumptionloan"); 
	
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_patient")));
				arrValues.add(correctNull((String)hshValues.get("txt_doctor")));
				arrValues.add(correctNull((String)hshValues.get("txt_child")));
				arrValues.add(correctNull((String)hshValues.get("txt_class")));
				arrValues.add(correctNull((String)hshValues.get("txt_year")));
				arrValues.add(correctNull((String)hshValues.get("txt_school")));
				arrValues.add(correctNull((String)hshValues.get("txt_bride")));
				arrValues.add(correctNull((String)hshValues.get("txt_bridegroom")));
				arrValues.add(correctNull((String)hshValues.get("txt_place")));
				arrValues.add(correctNull((String)hshValues.get("txt_date")));
				arrValues.add(correctNull((String)hshValues.get("txt_deceased")));
				arrValues.add(correctNull((String)hshValues.get("txt_born")));
				arrValues.add(correctNull((String)hshValues.get("txt_ceremony")));
				arrValues.add(correctNull((String)hshValues.get("txt_ceremonydate")));
				arrValues.add(correctNull((String)hshValues.get("sel_fininstitution")));
				arrValues.add(correctNull((String)hshValues.get("sel_ourbank")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			 else if(strAction.equalsIgnoreCase("delete"))
			 {
				 arrValues.add(appno);
				 hshQuery.put("arrValues",arrValues);
				 hshQuery.put("strQueryId","delagr_Consumptionloan");
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");
			 }
 		     EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    // 	-------Start Of Audit Trail ----------
 		     sb = new StringBuilder();
 		     if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
 		     {
			 sb.append("~Loan From Other Financial Institution= ");
			 if(correctNull((String)hshValues.get("sel_fininstitution")).equals("1"))
			 {
				 sb.append("Yes");
			 }
			 else if(correctNull((String)hshValues.get("sel_fininstitution")).equals("2"))
			 {
				 sb.append("No");
			 }
			 sb.append("~Defaulter Of Our Bank= ");
			 if(correctNull((String)hshValues.get("sel_ourbank")).equals("1"))
			 {
				 sb.append("Yes");
			 }
			 else if(correctNull((String)hshValues.get("sel_ourbank")).equals("2"))
			 {
				 sb.append("No");
			 }
			 sb.append("~Name Of Patient= ").append(correctNull((String)hshValues.get("txt_patient")))
		     .append("~Name Of Doctor/Hospital= ").append(correctNull((String)hshValues.get("txt_doctor")))
		     .append("~Name Of Child/Children= ").append(correctNull((String)hshValues.get("txt_child")))
		     .append("~Class= ").append(correctNull((String)hshValues.get("txt_class")))
		     .append("~Year Of Studying= ").append(correctNull((String)hshValues.get("txt_year")))
		     .append("~Name Of School/College= ").append(correctNull((String)hshValues.get("txt_school")))
		     .append("~Name Of Bride= ").append(correctNull((String)hshValues.get("txt_bride")))
		     .append("~Name Of Bridegroom= ").append(correctNull((String)hshValues.get("txt_bridegroom")))
		     .append("~Marriage Place= ").append(correctNull((String)hshValues.get("txt_place")))
		     .append("~Marriage Date= ").append(correctNull((String)hshValues.get("txt_date")))
		     .append("~Name Of Ceremony= ").append(correctNull((String)hshValues.get("txt_ceremony")))
		     .append("~Ceremony Date= ").append(correctNull((String)hshValues.get("txt_ceremonydate")))
		     .append("~Name Of Deceased= ").append(correctNull((String)hshValues.get("txt_deceased")))
		     .append("~Name Of Newly Born Child= ").append(correctNull((String)hshValues.get("txt_born")));
			 if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			 {
				 hshValues.put("strAction", "update");
			 }else
			 {
				 hshValues.put("strAction", "insert");
			 }
 		     }
			 AuditTrial.auditLog(hshValues,"277",appno,sb.toString());	
		}catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
	public void updateDatainvest(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{ 
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agriinvestmentupdate");
				arrValues.add(Helper.correctNull((String)hshValues.get("assettyp")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("breedmake")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("totalsqft")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("ageofasset")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("selyear")));
				if(Helper.correctDouble((String)hshValues.get("cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("cost")));
				}
				if(Helper.correctDouble((String)hshValues.get("subsidy")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("subsidy")));
				}
				if(Helper.correctDouble((String)hshValues.get("margin")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("margin")));
				}
				if(Helper.correctDouble((String)hshValues.get("loanamountrequird")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("loanamountrequird")));
				}				
				arrValues.add(Helper.correctDouble((String)hshValues.get("selsubsidy")));
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{			
				strGradeId = Integer.toString(getMaxGradeIdinvest(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrinvstinsert");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(Helper.correctNull((String)hshValues.get("assettyp")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("breedmake")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("totalsqft")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("ageofasset")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("selyear")));
				if(Helper.correctDouble((String)hshValues.get("cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("cost")));
				}
				if(Helper.correctDouble((String)hshValues.get("subsidy")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("subsidy")));
				}
				if(Helper.correctDouble((String)hshValues.get("margin")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("margin")));
				}
				if(Helper.correctDouble((String)hshValues.get("loanamountrequird")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(Helper.correctDouble((String)hshValues.get("loanamountrequird")));
				}
				arrValues.add(Helper.correctDouble((String)hshValues.get("selsubsidy")));
			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agrinvestmentdelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	
	public void updateFodderLiveStock(HashMap hshValues) 
	{
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("strappno"));
		StringBuilder sbaudittrail=null;
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{ 
			sbaudittrail=new StringBuilder();
			if(strAction.trim().equals("insert"))
			{			
			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_fodder_livestock");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_calamity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_govt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_state")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_obtained")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_annas")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed6")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breed7")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno5")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno6")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Breedno7")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_fodder_livestock");
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_fodder_livestock");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
			}
//			 ----------  Start Of Audit Trail----------
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbaudittrail
			.append("~Type Of Natural Calamity= ").append(Helper.correctNull((String)hshValues.get("txt_calamity")))
			.append("~Declared As Affected By Natural Calamity= ");
			if(Helper.correctNull((String)hshValues.get("sel_govt")).equals("1"))
			{
				sbaudittrail.append("Yes");
			}
			else
			if(Helper.correctNull((String)hshValues.get("sel_govt")).equals("2"))
			{
				sbaudittrail.append("No");
			}
			sbaudittrail.append("~Govt= ");
			if(Helper.correctNull((String)hshValues.get("sel_state")).equals("1"))
			{
				sbaudittrail.append("Central");
			}
			else
			if(Helper.correctNull((String)hshValues.get("sel_state")).equals("2"))
			{
				sbaudittrail.append("State");
			} 
			sbaudittrail.append("~Govt Declaration obtained= ");
			if(Helper.correctNull((String)hshValues.get("sel_obtained")).equals("1"))
			{
				sbaudittrail.append("Yes");
			}
			else
			if(Helper.correctNull((String)hshValues.get("sel_obtained")).equals("2"))
			{
				sbaudittrail.append("No");
			}
			sbaudittrail.append("~annavari declared by the Govt= ").append(Helper.correctNull((String)hshValues.get("txt_annas"))).append(" annas");
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed1")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed1"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno1")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed2")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed2"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno2")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed3")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed3"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno3")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed4")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed4"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno4")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed5")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed5"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno5")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed6")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed6"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno6")));
			}
			if(!(Helper.correctNull((String)hshValues.get("txt_Breed7")).equals("Select")))
			{
				sbaudittrail.append("~").append(Helper.correctNull((String)hshValues.get("txt_Breed7"))).append("= ").append(Helper.correctNull((String)hshValues.get("txt_Breedno7")));
			}
			
			if(Helper.correctNull((String)hshValues.get("hidAuditFlag")).equals("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"278",appno,sbaudittrail.toString());
//			 ----------  End Of Audit Trail----------
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	public  HashMap getFodderLiveStock(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
	
		try
		{	
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_fodder_livestock^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("ls_clamity",Helper.correctNull((String)(rs.getString("ls_clamity"))));
				hshRecord.put("ls_govt",Helper.correctNull((String)(rs.getString("ls_govt"))));
				hshRecord.put("ls_state",Helper.correctNull((String)(rs.getString("ls_state"))));
				hshRecord.put("ls_obtained",Helper.correctNull((String)(rs.getString("ls_obtained"))));
				hshRecord.put("ls_annas",Helper.correctNull((String)(rs.getString("ls_annas"))));
				hshRecord.put("ls_breed1",Helper.correctNull((String)(rs.getString("ls_breed1"))));
				hshRecord.put("ls_breed2",Helper.correctNull((String)(rs.getString("ls_breed2"))));
				hshRecord.put("ls_breed3",Helper.correctNull((String)(rs.getString("ls_breed3"))));
				hshRecord.put("ls_breed4",Helper.correctNull((String)(rs.getString("ls_breed4"))));
				hshRecord.put("ls_breed5",Helper.correctNull((String)(rs.getString("ls_breed5"))));
				hshRecord.put("ls_breed6",Helper.correctNull((String)(rs.getString("ls_breed6"))));
				hshRecord.put("ls_breed7",Helper.correctNull((String)(rs.getString("ls_breed7"))));
				hshRecord.put("ls_breedno1",Helper.correctNull((String)(rs.getString("ls_breedno1"))));
				hshRecord.put("ls_breedno2",Helper.correctNull((String)(rs.getString("ls_breedno2"))));
				hshRecord.put("ls_breedno3",Helper.correctNull((String)(rs.getString("ls_breedno3"))));
				hshRecord.put("ls_breedno4",Helper.correctNull((String)(rs.getString("ls_breedno4"))));
				hshRecord.put("ls_breedno5",Helper.correctNull((String)(rs.getString("ls_breedno5"))));
				hshRecord.put("ls_breedno6",Helper.correctNull((String)(rs.getString("ls_breedno6"))));
				hshRecord.put("ls_breedno7",Helper.correctNull((String)(rs.getString("ls_breedno7"))));
				hshRecord.put("auditFlag", "Y");
			}
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
		return hshRecord;
	}
	
	
	
	
	
	public void updateHortiData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		String strQuery=null;
		String strAction= correctNull((String)hshValues.get("hidAction"));
		String strSlno = "";
		String strAppno= correctNull((String)hshValues.get("strappno"));
		if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
		{
			strAppno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		ResultSet rs2 = null;
		String grow = correctNull((String)hshValues.get("txt_yieldgrow"));
		String yield = correctNull((String)hshValues.get("txt_startyield"));
		String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
		String strDelete= Helper.correctNull((String)hshValues.get("hiddelete"));
		int intyield=Integer.parseInt(yield);
		String queryColumns=null;
		String columnValue=null;
		boolean bstate=false;
		
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
		hshScheme = Helper.splitScheme(strschemetype);
		
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		HashMap hshValuesAgri = new HashMap();
		HashMap hshPhysical = new HashMap();
		
		try
		{			
			if(strAction.equals("update"))
			{
				strSlno =  correctNull((String )hshValues.get("selsno"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","agr_horti_plantdetail_update");
				arrValues.add(correctNull((String)hshValues.get("txt_plantname")));//Plant Name
				arrValues.add(correctNull((String)hshValues.get("txt_maxplant")));//Max Plant populated
				
				arrValues.add(correctNull((String)hshValues.get("txt_cost")));//Period Start Yeild
				arrValues.add(correctNull((String)hshValues.get("txt_yieldgrow")));//Period grow
				arrValues.add(correctNull((String)hshValues.get("txt_startyield")));
				arrValues.add(correctNull((String)hshValues.get("txt_plantvariety")));//Plant Variety
				arrValues.add(correctNull((String)hshValues.get("txt_saleprice")));//sale price
				arrValues.add(correctNull((String)hshValues.get("txt_totacre")));//Total acre
				arrValues.add(correctNull((String)hshValues.get("txt_incperacre")));//income per acre
				arrValues.add(correctNull((String)hshValues.get("sel_yieldunits")));//Yield units
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(strDelete.equalsIgnoreCase("Y"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "2");
					hshQuery.put("strQueryId", "agr_horticostofdevelopment_delete");
					arrValues.add(strAppno);
					arrValues.add(strSlno);
					arrValues.add(stragrschemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_hortiprojectedincome_delete");
					arrValues.add(strAppno);
					arrValues.add(strSlno);
					arrValues.add(stragrschemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				//To update agr_horticostofdevelopment table if the growing period of agr_Horti_Plant table value changes
				//strslno refers to agr_plant in  agr_horticostofdevelopment table
				
				strQuery = SQLParser.getSqlQuery("agr_horticostofdevelopment_select^"+strAppno+"^"+strSlno+"^"+stragrschemetype+"^"+strfacsno);
				rs = DBUtils.executeQuery(strQuery);
				bstate=rs.next();
				if(bstate)
				{
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					
					columnValue="0";
					if(grow.equalsIgnoreCase("1"))
					{
						queryColumns	=	"agr_year2="+columnValue+",agr_year3="+columnValue+",agr_year4="+columnValue+
											",agr_year5="+columnValue+",agr_year6="+columnValue+",agr_year7="+columnValue;
					}
					else if(grow.equalsIgnoreCase("2"))
					{
						queryColumns	=	"agr_year3="+columnValue+",agr_year4="+columnValue+
											",agr_year5="+columnValue+",agr_year6="+columnValue+",agr_year7="+columnValue;
					}
					else if(grow.equalsIgnoreCase("3"))
					{
						queryColumns	=	"agr_year4="+columnValue+",agr_year5="+columnValue+
											",agr_year6="+columnValue+",agr_year7="+columnValue;
					}
					else if(grow.equalsIgnoreCase("4"))
					{
						queryColumns	=	"agr_year5="+columnValue+
											",agr_year6="+columnValue+",agr_year7="+columnValue;
					}
					else if(grow.equalsIgnoreCase("5"))
					{
						queryColumns	=	"agr_year6="+columnValue+",agr_year7="+columnValue;
					}
					else if(grow.equalsIgnoreCase("6"))
					{
						queryColumns	=	"agr_year7="+columnValue;
					}
					if(!(grow.equalsIgnoreCase("7")))
					{
						hshQuery.put("strQueryId","agr_horticostofdevelopment_updateValuesDynamically^"+queryColumns);
					
						arrValues.add(strAppno);
						arrValues.add(strSlno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
				}
				if(rs != null)
				{
					rs.close();
				}
				//To update AGR_HORTIPROJECTEDINCOME table if the Starting Yield period of agr_Horti_Plant table value changes
				//strslno refers to agr_plant in  agr_horticostofdevelopment table
				
				strQuery = SQLParser.getSqlQuery("agr_hortiprojectedincome_select^"+strAppno+"^"+strSlno+"^"+stragrschemetype+"^"+strfacsno);
				rs = DBUtils.executeQuery(strQuery);
				bstate=rs.next();
				if(bstate)
				{
					columnValue="0";
					if( intyield<15)
					{
						for(int j=1;j<=(intyield-1);j++)
						{
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							hshQueryValues=new HashMap(); 
							
							queryColumns	=	"agr_yield="+columnValue+",agr_grossinc="+columnValue+
												",agr_maintenance="+columnValue+",agr_netinc="+columnValue;
							hshQuery.put("strQueryId","agr_hortiprojectedincome_updateValuesDynamically^"+queryColumns);
							
							arrValues.add(strAppno);
							arrValues.add(strSlno);//plant name
							arrValues.add(Integer.toString(j));//serial no
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);	
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
					else if(intyield>=15)
					{
						for(int j=1;j<=14;j++)
						{
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							hshQueryValues=new HashMap(); 
							
							queryColumns	=	"agr_yield="+columnValue+",agr_grossinc="+columnValue+
												",agr_maintenance="+columnValue+",agr_netinc="+columnValue;
							hshQuery.put("strQueryId","agr_hortiprojectedincome_updateValuesDynamically^"+queryColumns);
							
							arrValues.add(strAppno);
							arrValues.add(strSlno);//plant name
							arrValues.add(Integer.toString(j));//serial no
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);	
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
					
				}
				//To update agr_hortiyearcultivationcost table
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				updateHortiFinData(hshValues);
				
				// For updating in Physical and Financial Programme by Dinesh on 03/03/2014
				
			/* 	hshPhysical.put("scheme_sno", "4");		//Plant Details
				hshPhysical.put("scheme_type", stragrschemetype);
				hshPhysical.put("total_cost", Helper.correctNull((String)hshValues.get("txt_maxplant")));
				hshPhysical.put("hidAction", "update");
				hshPhysical.put("appno",strAppno);
				hshPhysical.put("page_id","PD");
				hshPhysical.put("plant_sno", strSlno);
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme"); */
				
			}
			if(strAction.trim().equals("insert"))
			{				
				strSlno = Integer.toString(getHortiMaxGradeId(strAppno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_horti_plantdetail_insert");
				
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(correctNull((String)hshValues.get("txt_plantname")));//Plant Name
				arrValues.add(correctNull((String)hshValues.get("txt_maxplant")));//Max Plant populated
			
				arrValues.add(correctNull((String)hshValues.get("txt_cost")));//Period Start Yeild
				arrValues.add(correctNull((String)hshValues.get("txt_yieldgrow")));//Period grow
				arrValues.add(correctNull((String)hshValues.get("txt_startyield")));
				arrValues.add(correctNull((String)hshValues.get("txt_plantvariety")));//Plant Variety
				arrValues.add(correctNull((String)hshValues.get("txt_saleprice")));//sale price
				arrValues.add(correctNull((String)hshValues.get("txt_totacre")));//Total acre
				arrValues.add(correctNull((String)hshValues.get("txt_incperacre")));//income per acre
				arrValues.add(correctNull((String)hshValues.get("sel_yieldunits")));//Yield units
				arrValues.add(stragrschemetype);//Scheme Type
				arrValues.add(strfacsno);//Fac SNO
				arrValues.add(correctNull((String)hshValues.get("hidschemesno")));//scheme specific sno
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For inserting in Physical and Financial Programme by Dinesh on 03/03/2014
			/*	
				hshPhysical.put("scheme_sno", "4");		//Plant Details
				hshPhysical.put("scheme_type", stragrschemetype);
				hshPhysical.put("total_cost", Helper.correctNull((String)hshValues.get("txt_maxplant")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",strAppno);
				hshPhysical.put("page_id","PD");
				hshPhysical.put("plant_sno", strSlno);
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");*/
				
			}
			 if(strAction.equals("delete"))
			{
				strSlno =  correctNull((String )hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","6");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_horti_plantdetail_delete");
				arrValues.add(strAppno);
				arrValues.add(strSlno);	
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_horticostofdevelopment_delete");
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_hortiprojectedincome_delete");
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_hortifindripirrigation_deleteBySno");
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_horticostofcultivation_deletebysno");
				arrValues.add(strAppno);
				arrValues.add(strSlno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppno);
				arrValues.add(stragrschemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("6",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				updateHortiFinData(hshValues);
				
				// For deleting in Physical and Financial Programme by Dinesh on 03/03/2014
				
		/*		hshPhysical.put("scheme_sno", "4");		//Plant Details
				hshPhysical.put("scheme_type", stragrschemetype);
				hshPhysical.put("total_cost", "");
				hshPhysical.put("hidAction", "delete");
				hshPhysical.put("appno",strAppno);
				hshPhysical.put("page_id","PD");
				hshPhysical.put("plant_sno", strSlno);
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");*/
				
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
					
			sbAuditTrial.append(
			"~plant Name= ").append(correctNull((String)hshValues.get("txt_plantname"))).append(
			"~Max Plant = ").append(correctNull((String )hshValues.get("txt_maxplant"))).append(
			"~Plant Spacing = ").append(correctNull((String )hshValues.get("txt_spacing"))).append(
			"~Plant Startyield  = ").append(correctNull((String )hshValues.get("txt_startyield"))).append(
			"~Plant Yieldgrow = ").append(correctNull((String )hshValues.get("txt_yieldgrow"))).append(
			"~Start Yieldgrow = ").append(correctNull((String )hshValues.get("txt_startyield")));

			
			//AuditTrial.auditLog(hshValues,"260",strAppno,sbAuditTrial.toString());	
		}
		catch(Exception ce)
		{	log.error(ce);
			throw new EJBException(LAlerts.EXCEPTION+"inside update"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{	log.error(cf);
				throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	
	
	
	
	/**
	 * Method to update agr_hortiyearcultivationcost table if data in Estimated Cost page or Plant Detail page changes
	 */
	
	private void updateHortiFinData(HashMap hshValues)
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strAppNo=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		ArrayList arrYearRow=new ArrayList();
		ArrayList arrYearCol=new ArrayList();
		ArrayList arrHortiplant=new ArrayList();
		ArrayList arrFinCulti=new ArrayList();
		ArrayList arrFinCultiCol=new ArrayList();
		ArrayList arrYearCol2=new ArrayList();
		int intmaxgrow=0,arrPlantDetSize=0,iUpdatesize=0;
		double dbltotyear = 0.0,dblmargin = 0.0,dblmarginpercent = 0.0,dblbankloan = 0.0,dblFinCost=0.0,dblDripCost=0.0,dblCultiCost=0.0,dblCultiUnitCost=0.0;
		
		ResultSet rs=null;
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			String strfacsno="";
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				
				rs=DBUtils.executeLAPSQuery("get_risk_from_loandetails^"+strAppNo);
				if(rs.next())
				{
					//hshRecord.put("margin",Helper.correctNull((String) rs.getString("pa_margin_required")));
					dblmarginpercent = Double.parseDouble(Helper.correctDouble((String) rs.getString("LOAN_MARGIN")));
				}
				//arrFinancial=new AgrLandHoldingsBO().getFinancialProgByAppNo(strAppNo);
				//hshRecord.put("arrFinancial",arrFinancial);
				arrHortiplant=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppNo,schemetype,strfacsno);
				//hshRecord.put("arrHortiplant",arrHortiplant);
				
				if(arrHortiplant!=null)
				{
					arrPlantDetSize=arrHortiplant.size();//Size of plant arraylist
				}
				
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horticostofdevelopment_selectTotal^"+strAppNo+"^"+schemetype+"^"+strfacsno);
				while(rs.next())
				{
					arrYearCol=new ArrayList();
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_plant")));//0
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year1")));//1
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year2")));//2
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year3")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year4")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year5")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year6")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year7")));
					
					arrYearRow.add(arrYearCol);
				}
				//hshRecord.put("arrYearRow",arrYearRow);
				
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horti_plantdetail_selectMaxGrowPeriod^"+strAppNo+"^"+schemetype);
				if(rs.next())
				{
					String strmaxgrow = Helper.correctNull((String) rs.getString("maxgrow"));
					if(strmaxgrow.equals(""))
					{
							intmaxgrow=0;
					}
					else
					{
							intmaxgrow	=	Integer.parseInt(Helper.correctInt(strmaxgrow));
					}
					//hshRecord.put("maxgrow",Helper.correctNull((String) rs.getString("maxgrow")));
				}
				
				//arrFinancial2=new AgrLandHoldingsBO().getFinancialProg2ByAppNo(strAppNo);
				//hshRecord.put("arrFinancial2",arrFinancial2);
				
				//arrFinDrip =new AgrLandHoldingsBO().getFinancialDripByAppNo(strAppNo);
			//	hshRecord.put("arrFinDrip",arrFinDrip);
				
				arrFinCulti = new AgrLandHoldingsBO().getFinancialCostofCultivationByAppNo(strAppNo,schemetype,strfacsno);
				//hshRecord.put("arrFinCulti",arrFinCulti);
				//Total financial programme
				
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_hortifinancialprogramme_selectSum^"+strAppNo);
				if(rs.next())
				{
					String strFinCost = Helper.correctNull((String) rs.getString("fintotcost"));
					if(strFinCost.equals(""))
						dblFinCost=0;
					else
						dblFinCost	=	Double.parseDouble(Helper.correctDouble(strFinCost));
				}
				//Total drip irrigation cost
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_hortifindripirrigation_selectSum^"+strAppNo);
				if(rs.next())
				{
					String strDripCost = Helper.correctNull((String) rs.getString("driptotcost"));
					if(strDripCost.equals(""))
						dblDripCost=0;
					else
						dblDripCost	=	Double.parseDouble(Helper.correctDouble(strDripCost));
				}
				
				//Cost of cultivation total
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horticostofcultivation_selectsum^"+strAppNo);
				if(rs.next())
				{
					String strCultiCost = Helper.correctNull((String) rs.getString("cultitotcost"));
					String strcultiunitcost = Helper.correctNull((String) rs.getString("cultiunitcost"));
					if(strCultiCost.equals(""))
						dblCultiCost=0;
					else
						dblCultiCost	=	Double.parseDouble(Helper.correctDouble(strCultiCost));
					if(strcultiunitcost.equals(""))
						dblCultiUnitCost=0;
					else
						dblCultiUnitCost	=	Double.parseDouble(Helper.correctDouble(strcultiunitcost));
				}
				
				for(int i=0;i<intmaxgrow;i++)
				{
					dbltotyear=0.0;
					double dblyear2=0.0,dblCultiUnit=0.0;
					if(i>0)
					{
						for(int j=0;j<arrPlantDetSize;j++)
						{
							if(arrYearRow!=null && arrYearRow.size()>0 && arrYearRow.size()>j)//arrYearRow.size()<=j)
							{
							arrYearCol2		=	(ArrayList)arrYearRow.get(j);
							dblyear2	=	 Double.parseDouble(Helper.correctDouble((String)arrYearCol2.get(i+1)));
							}
							else
							{
								dblyear2=0;
							}

							if(arrFinCulti.size()>j)
							{
								arrFinCultiCol		=	(ArrayList)arrFinCulti.get(j);
								dblCultiUnit	=	 Double.parseDouble(Helper.correctDouble((String)arrFinCultiCol.get(2)));
							}
							else
							{
								dblCultiUnit =0.0;
							}
							dbltotyear 			= 	Math.round(dbltotyear+(dblyear2*dblCultiUnit));
						}
					}
					else
					{
						dbltotyear = Math.round(dblFinCost+dblDripCost+dblCultiCost);
					}
					dblmargin			=	Math.round((dblmarginpercent/100)*dbltotyear);
					dblbankloan			=	Math.round(dbltotyear-dblmargin);
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					hshQuery.put("strQueryId","agr_hortiyearcultivationcost_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(String.valueOf(i+1));//serial no 2
					arrValues.add(jtn.format(dblCultiUnitCost));//3  from cultivation table max query
					arrValues.add(jtn.format(dbltotyear));		//4
					arrValues.add(jtn.format(dblbankloan));	//5
					arrValues.add(jtn.format(dblmargin));	//6	
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				if(intmaxgrow!=0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
		} catch (Exception e) {
			log.error("Error in updateHortiFinData of agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in updateHortiFinData "+e.toString());
		}
	}
	
	
	private int getHortiMaxGradeId(String appno)
	{
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("agr_Horti_Plant_maxid^"+appno);
			rs = DBUtils.executeQuery(strQuery);
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
		{	log.error(ce);
			throw new EJBException(LAlerts.EXCEPTION+"Error in getHortiMaxGradeId "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{	log.error(cf);
				throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
			}
		}
		return termId;
	}
	
	
	
	public  HashMap getHortiData(HashMap hshValues) 
	{		
		HashMap hshRecord = new HashMap();
		HashMap hshScheme = new HashMap();
		ArrayList arrRow= new ArrayList();
		String strfacsno ="";
		try
		{
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(schemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}			
			String strAppno=correctNull((String)hshValues.get("strappno"));
			if(correctNull(strAppno).trim().equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			arrRow=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppno,schemetype,strfacsno);
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("appno",strAppno);
			arrRow =null;
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData === agrlandholdings"+ce.toString());
		}
		return hshRecord;
	}
	
	
	/**
	 * Method to update Horiculture-Estimated cost page
	 */
	public void updateHortiCostOfDevelopmentDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		HashMap hshScheme=null;
		ArrayList arrValues=new ArrayList();
		ArrayList arrFinCulti=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		String strYear1[]=null;
		String strYear2[]=null;
		String strYear3[]=null;
		String strYear4[]=null;
		String strYear5[]=null;
		String strYear6[]=null;
		String strYear7[]=null;
		String strDescription[]=null;
		String strfacsno="";
		
		String strDesc[]=null;
		String strPlantName=null;
		
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(schemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}	
			
			
			strAction=(String)hshValues.get("hidAction");
			int iUpdatesize=0;
			
				strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
			strPlantName = correctNull((String)hshValues.get("sel_plantName"));
									
			if(strAction.trim().equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_horticostofdevelopment_delete");
				arrValues.add(strAppNo);
				arrValues.add(strPlantName);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				/**hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				updateHortiFinData(hshValues);**/
			}
			else
			{			
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_horticostofdevelopment_delete");
				arrValues.add(strAppNo);
				arrValues.add(strPlantName);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				iUpdatesize++;
				hshQuery.put("strQueryId","agr_horticostofdevelopment_insert");
				arrValues.add(strAppNo);
				arrValues.add(strPlantName);
				for(int i=1;i<=15;i++)
				{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_year"+i)));
				}
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("size",Integer.toString(iUpdatesize));
				hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//To update agr_hortifincostofculti table
				arrFinCulti = new AgrLandHoldingsBO().getFinancialCostofCultivationByAppNo(strAppNo,schemetype,strfacsno);

				if(arrFinCulti!=null && arrFinCulti.size()>0)
				{
					updateHortiFinCulti(strAppNo,strPlantName,Helper.correctNull((String)strYear1[14]));
					
					
					//To update agr_hortiyearcultivationcost table
					
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
					arrValues.add(strAppNo);
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					updateHortiFinData(hshValues);
				}
			
			}
			
			/*hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int i=0;i<15;i++)
			{	
					strActionData=new StringBuffer();
					
					strActionData.append(strDesc[i]).
					append(" ;~  Year1 =").
					append(Helper.correctDouble(strYear1[i])).
					append(";~ Year2 =").
					append(Helper.correctDouble(strYear2[i])).
					append(";~ Year3 =").
					append(Helper.correctDouble(strYear3[i])).
					append(";~ Year4 =").
					append(Helper.correctDouble(strYear4[i])).
					append(";~ Year5 =").
					append(Helper.correctDouble(strYear5[i])).
					append(";~ Year6 =").
					append(Helper.correctDouble(strYear6[i])).
					append(";~ Year7 =").
					append(Helper.correctDouble(strYear7[i]));
					
					
					arrValues.add(strActionData.toString());
					arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				AuditTrial.auditLogBatch(hshValues,"241",strAppNo,arrAuditBatchData);
			}*/
			
		} 
		catch (Exception e) {
			log.error("Error in updateHortiCostOfDevelopmentDetails of Agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"inside updateHortiCostOfDevelopmentDetails"+e.toString());
		}
		
		
	}
	
	
	
		
	/**
	 * Method to get Horiculture-Estimated cost page
	 */
	public HashMap getHortiCostOfDevelopmentDetails(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshScheme=new HashMap();
		HashMap hshEstimateCost = new HashMap(); 
		String strAppNo=null,strfacsno=null;
		ArrayList arrHorti=new ArrayList();
		ArrayList arrHortiplant=new ArrayList();
		
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(schemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}	
			
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				String strPlantSno = correctNull((String)hshValues.get("sel_plantName"));
								
				hshRecord = new AgrLandHoldingsBO().getHortiCostOfDevelopmentByAppno(strAppNo,strPlantSno,schemetype,strfacsno);
				
				
				//Commend by saravanan.
				
			//	if(!strPlantSno.equalsIgnoreCase("") && ((ArrayList)hshRecord.get("arrRow")).size()==0)
				///hshRecord = new AgrLandHoldingsBO().getEstimatedCostData(strAppNo, schemetype, strfacsno, strPlantSno);
				
		} catch (Exception e) {
			log.error("Error in getHortiCostOfDevelopmentDetails of agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in getHortiCostOfDevelopmentDetails "+e.toString());
		}
		
		return hshRecord;
		
	}
	
	private void updateHortiFinCulti(String strAppNo, String strPlant, String strUnitCost) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
	
		double dblunit=0.0,dblunitcost=0.0,dbltotcost=0.0,marginpercent=0.0,dblMargin=0.0,dblBankLoan=0.0;
		
		try
		{
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("get_risk_from_loandetails^"+strAppNo);
			if(rs.next())
			{
				marginpercent = FwHelper.parseDouble(Helper.correctNull((String) rs.getString("LOAN_MARGIN")));
			}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_horticostofcultivation_selectBySno^"+strAppNo+"^"+strPlant);
			if(rs.next())
			{
				String strunit = Helper.correctNull((String) rs.getString("agr_unit"));
				if(strunit.equals(""))
					dblunit = 0.0;
				else
					dblunit = Double.parseDouble(strunit);
				dblunitcost = Double.parseDouble(strUnitCost);
				dbltotcost=	((dblunit *  dblunitcost));
				dblMargin = (marginpercent/100)*(dbltotcost);
				dblBankLoan = (dbltotcost-dblMargin);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_hortifincostofculti_update");
				arrValues.add(strUnitCost); //unit cost
				arrValues.add(jtn.format(dbltotcost)); //Total cost
				arrValues.add(jtn.format(dblBankLoan)); //Bank Loan
				arrValues.add(jtn.format(dblMargin)); //Margin
				arrValues.add(strAppNo);
				arrValues.add(strPlant);//serial no
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e) {
			log.error("Error in updateHortiFinCulti of agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in updateHortiFinCulti "+e.toString());
		}
	}
	

	public HashMap getHortiFinancialProgramme(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshScheme=new HashMap();
		String strAppNo=null,strfacsno=null;
		ArrayList arrYearRow=new ArrayList();
		ArrayList arrYearCol=new ArrayList();
		ArrayList arrHortiplant=new ArrayList();
		ArrayList arrFinancial=new ArrayList();
		ArrayList arrFinancial2=new ArrayList();
		ArrayList arrFinDrip=new ArrayList();
		ArrayList arrFinCulti=new ArrayList();
		ResultSet rs=null;
		try {
			
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(schemetype);
			

			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}	
			
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				
				rs=DBUtils.executeLAPSQuery("get_risk_from_loandetails^"+strAppNo);
				if(rs.next())
				{
					hshRecord.put("margin",Helper.correctNull((String) rs.getString("LOAN_MARGIN")));
				}
				arrFinancial=new AgrLandHoldingsBO().getFinancialProgByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrFinancial",arrFinancial);
				arrHortiplant=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrHortiplant",arrHortiplant);
				
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horticostofdevelopment_selectTotal^"+strAppNo+"^"+schemetype+"^"+strfacsno);
				while(rs.next())
				{
					arrYearCol=new ArrayList();
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_plant")));//0
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year1")));//1
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year2")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year3")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year4")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year5")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year6")));
					arrYearCol.add(Helper.correctNull((String) rs.getString("agr_year7")));
					arrYearRow.add(arrYearCol);
				}
				hshRecord.put("arrYearRow",arrYearRow);
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horti_plantdetail_selectMaxGrowPeriod^"+strAppNo+"^"+schemetype);
				if(rs.next())
				{
					hshRecord.put("maxgrow",Helper.correctNull((String) rs.getString("maxgrow")));
				}
				arrFinancial2=new AgrLandHoldingsBO().getFinancialProg2ByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrFinancial2",arrFinancial2);
				
				arrFinDrip =new AgrLandHoldingsBO().getFinancialDripByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrFinDrip",arrFinDrip);
				
				arrFinCulti = new AgrLandHoldingsBO().getFinancialCostofCultivationByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrFinCulti",arrFinCulti);
				
		} catch (Exception e) {
			log.error("Error in getHortiCostOfDevelopmentDetails of agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in getHortiCostOfDevelopmentDetails "+e.toString());
		}
		
		return hshRecord;
		
	}
	
	public void updateHortiFinancialProgramme(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		int intsecondloopsize=0;
		int intPlantDetSize=0;
		String strAppNo=null;
		String strUnit[]=null;
		String strUnitCost[]=null;
		String strTotCost[]=null;
		String strBankLoan[]=null;
		String strMargin[]=null;
		String strUnitDrip[]=null;
		String strUnitCostDrip[]=null;
		String strTotCostDrip[]=null;
		String strBankLoanDrip[]=null;
		String strMarginDrip[]=null;
		String strSerialNoDrip[]=null;
		String strUnitCulti[]=null;
		String strUnitCostCulti[]=null;
		String strTotCostCulti[]=null;
		String strBankLoanCulti[]=null;
		String strMarginCulti[]=null;
		String strSerialNoCulti[]=null;

		String strUnit2[]=null;
		String strTotCost2[]=null;
		String strBankLoan2[]=null;
		String strMargin2[]=null;
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));			
			String strfacsno="";
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			strAction=(String)hshValues.get("hidAction");
			int iUpdatesize=0;
				strAppNo=correctNull((String)hshValues.get("strAppno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("appno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
			//For first 7 rows
			strUnit= (String [])hshValues.get("txt_unit");//unit
			strUnitCost= (String [])hshValues.get("txt_unitCost");//unit Cost
			strTotCost= (String [])hshValues.get("txt_totalCost");//total Cost
			strBankLoan = (String [])hshValues.get("txt_bankLoan");//bank Loan
			strMargin= (String [])hshValues.get("txt_margin");//margin
			
			//For Installation of drip irrigation
			String strPlantDet = Helper.correctNull((String)hshValues.get("hidPlantDetSize"));
			if(strPlantDet.equals(""))
			{
				intPlantDetSize=0;
			
			}
			else
			{
				intPlantDetSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidPlantDetSize")));
			}
			if(intPlantDetSize>1)
			{
				strUnitDrip= (String [])hshValues.get("txt_unitDrip");//unit
				strUnitCostDrip= (String [])hshValues.get("txt_unitCostDrip");//unit Cost
				strTotCostDrip= (String [])hshValues.get("txt_totalCostDrip");//total Cost
				strBankLoanDrip = (String [])hshValues.get("txt_bankLoanDrip");//bank Loan
				strMarginDrip= (String [])hshValues.get("txt_marginDrip");//margin
				strSerialNoDrip= (String [])hshValues.get("txt_hortidripsno");//margin
			}
			
			
			//For cost of cultivation
			if(intPlantDetSize>1)
			{
				strUnitCulti= (String [])hshValues.get("txt_unitCulti");//unit
				strUnitCostCulti= (String [])hshValues.get("txt_unitCostCulti");//unit Cost
				strTotCostCulti= (String [])hshValues.get("txt_totalCostCulti");//total Cost
				strBankLoanCulti = (String [])hshValues.get("txt_bankLoanCulti");//bank Loan
				strMarginCulti= (String [])hshValues.get("txt_marginCulti");//margin
				strSerialNoCulti= (String [])hshValues.get("txt_horticultisno");//margin
			}
			
			//For cost of cultivation part of all years
			strUnit2= (String [])hshValues.get("txt_unit2");//unit
			strTotCost2= (String [])hshValues.get("txt_totalCost2");//total Cost
			strBankLoan2 = (String [])hshValues.get("txt_bankLoan2");//bank Loan
			strMargin2= (String [])hshValues.get("txt_margin2");//margin
			
			if(strAction.trim().equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortifinancialprogramme_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortifindripirrigation_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_horticostofcultivation_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{

				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortifinancialprogramme_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				for(int k=0;k<7 ;k++)
				{				
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						iUpdatesize++;
						hshQuery.put("strQueryId","agr_hortifinancialprogramme_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctDouble((String)strUnit[k]));//		3
						arrValues.add(Helper.correctDouble((String)strUnitCost[k]));		//4	
						arrValues.add(Helper.correctDouble((String)strTotCost[k]));		//5
						arrValues.add(Helper.correctDouble((String)strBankLoan[k]));		//6
						arrValues.add(Helper.correctDouble((String)strMargin[k]));		//7	
						arrValues.add(schemetype);
						arrValues.add(strfacsno);
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(iUpdatesize));
						hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//For second table insert
				intsecondloopsize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidSecondLoop")));
				iUpdatesize=0;
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				for(int k=0;k<(intsecondloopsize) ;k++)
				{				
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						iUpdatesize++;
						hshQuery.put("strQueryId","agr_hortiyearcultivationcost_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctDouble((String)strUnit2[k]));		//3
						arrValues.add(Helper.correctDouble((String)strTotCost2[k]));		//4
						arrValues.add(Helper.correctDouble((String)strBankLoan2[k]));		//5
						arrValues.add(Helper.correctDouble((String)strMargin2[k]));	//6	
						arrValues.add(schemetype);
						arrValues.add(strfacsno);
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(iUpdatesize));
						hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//For installation of drip irrigation part insert
				
				intPlantDetSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidPlantDetSize")));

				iUpdatesize=0;
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_hortifindripirrigation_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				if(intPlantDetSize>1)
				{
					for(int k=0;k<(intPlantDetSize) ;k++)
					{				
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							iUpdatesize++;
							hshQuery.put("strQueryId","agr_hortifindripirrigation_insert");
							arrValues.add(strAppNo);	//1
							arrValues.add(strSerialNoDrip[k]);//serial no 2
							arrValues.add(Helper.correctDouble((String)strUnitDrip[k]));//3	
							arrValues.add(Helper.correctDouble((String)strUnitCostDrip[k]));//4		
							arrValues.add(Helper.correctDouble((String)strTotCostDrip[k]));	//5
							arrValues.add(Helper.correctDouble((String)strBankLoanDrip[k]));		//6
							arrValues.add(Helper.correctDouble((String)strMarginDrip[k]));		//7	
							arrValues.add(schemetype);
							arrValues.add(strfacsno);
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(iUpdatesize));
							hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_hortifindripirrigation_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_hortidripsno")));//serial no 2
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_unitDrip")));//3
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_unitCostDrip")));//4
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totalCostDrip")));//5
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_bankLoanDrip")));//6
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_marginDrip")));//7
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				//	For Cost Of Cultivation insert
				
				intPlantDetSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidPlantDetSize")));

				iUpdatesize=0;
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_horticostofcultivation_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				if(intPlantDetSize>1)
				{
					for(int k=0;k<(intPlantDetSize) ;k++)
					{				
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							iUpdatesize++;
							hshQuery.put("strQueryId","agr_horticostofcultivation_insert");
							arrValues.add(strAppNo);	//1
							arrValues.add(strSerialNoCulti[k]);//serial no 2
							arrValues.add(Helper.correctDouble((String)strUnitCulti[k]));		//3
							arrValues.add(Helper.correctDouble((String)strUnitCostCulti[k]));		//4	
							arrValues.add(Helper.correctDouble((String)strTotCostCulti[k]));		//5
							arrValues.add(Helper.correctDouble((String)strBankLoanCulti[k]));		//6
							arrValues.add(Helper.correctDouble((String)strMarginCulti[k]));	//7
							arrValues.add(schemetype);
							arrValues.add(strfacsno);
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(iUpdatesize));
							hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_horticostofcultivation_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(correctNull((String)hshValues.get("txt_horticultisno")));//serial no 2
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_unitCulti")));//3
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_unitCostCulti")));//4
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totalCostCulti")));//5
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_bankLoanCulti")));//6
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_marginCulti")));//7
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				
				//For audit trail
				StringBuilder strActionData = new StringBuilder();
				ArrayList arrAuditBatchData = new ArrayList();
				for(int i=0;i<7;i++)
				{	
						strActionData=new StringBuilder();
						strActionData.
						append(" ;~  unit =").
						append(Helper.correctDouble(strUnit[i])).
						append(";~ unit cost =").
						append(Helper.correctDouble(strUnitCost[i])).
						append(";~ total cost =").
						append(Helper.correctDouble(strTotCost[i])).
						append(";~ bank loan =").
						append(Helper.correctDouble(strBankLoan[i])).
						append(";~ margin =").
						append(Helper.correctDouble(strMargin[i]));
						arrValues.add(strActionData.toString());
						arrAuditBatchData.add(strActionData);
				}
				if(arrAuditBatchData.size()>0)
				{
					AuditTrial.auditLogBatch(hshValues,"255",strAppNo,arrAuditBatchData);
				}
			}
			hshQueryValues= new HashMap();
			
			
		} catch (Exception e) {
			log.error("Error in updateHortiFinancialProgramme of Agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"inside updateHortiFinancialProgramme"+e.toString());
		}
		
		
	}
	
	public HashMap getHortiProjectedIncome(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshScheme=new HashMap();
		String strAppNo=null,strfacsno=null;
		ArrayList arrHorti=new ArrayList();
		ArrayList arrHortiplant=new ArrayList();
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			hshScheme = Helper.splitScheme(schemetype);
			

			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}	
			
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				String strPlantName = correctNull((String)hshValues.get("sel_plantNameInc"));
				if(strPlantName.equalsIgnoreCase(""))
				{
					strPlantName = "s";
				}
				hshRecord.put("PlantNameInc", strPlantName);
				arrHorti = new AgrLandHoldingsBO().getHortiProjectedIncomeByAppno(strAppNo,strPlantName,schemetype,strfacsno);
				hshRecord.put("arrHortiProjInc", arrHorti);
				arrHortiplant=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppNo,schemetype,strfacsno);
				hshRecord.put("arrHortiplant",arrHortiplant);
				
		} catch (Exception e) {
			log.error("Error in getHortiProjectedIncome of agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"Error in getHortiProjectedIncome "+e.toString());
		}
		return hshRecord;
	}
	
	
	
	/**
	 * Method to Horiculture-Projected income page
	 * @param hshValues
	 * @
	 */
	public void updateHortiProjectedIncome(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		String strYield[]=null;
		String strGrossInc[]=null;
		String strMaintenance[]=null;
		String strNetInc[]=null;
		String strDescription[]=null;
		String strDesc[]=null;
		String strPlantName=null;
		
		try {
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));			
			String strfacsno="";
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			strAction=(String)hshValues.get("hidAction");
			int iUpdatesize=0;
			
				strAppNo=correctNull((String)hshValues.get("strAppno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("appno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
			strPlantName = correctNull((String)hshValues.get("sel_plantNameInc"));
			strDescription= (String [])hshValues.get("txt_desc");//description or year
			strYield= (String [])hshValues.get("txt_yield");//yield
			strGrossInc= (String [])hshValues.get("txt_grossInc");//gross income
			//strMaintenance= (String [])hshValues.get("txt_maintenance");//maintenance
			strNetInc = (String [])hshValues.get("txt_netInc");//net income
			strDesc= (String [])hshValues.get("txt_desc");
			
			
			if(strAction.trim().equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_hortiprojectedincome_delete");
				arrValues.add(strAppNo);
				arrValues.add(strPlantName);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{
			
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_hortiprojectedincome_delete");
				arrValues.add(strAppNo);
				arrValues.add(strPlantName);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				for(int k=0;k<15;k++)
				{				
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						iUpdatesize++;
						hshQuery.put("strQueryId","agr_hortiprojectedincome_insert");
						
						arrValues.add(strAppNo);	//1
						arrValues.add(strPlantName);	//2
						arrValues.add(String.valueOf(k+1));//serial no 3
						
						arrValues.add(Helper.correctNull((String)strDescription[k]));	//year 4
						arrValues.add(Helper.correctDouble((String)strYield[k]));//yield		//5
						arrValues.add(Helper.correctDouble((String)strGrossInc[k]));//gross		//6	
						arrValues.add("0.00");//maintenance	//7
						arrValues.add(Helper.correctDouble((String)strNetInc[k]));//net income//8
						arrValues.add(schemetype);
						arrValues.add(strfacsno);
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				
			
			}

			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int i=0;i<15;i++)
			{	
					strActionData=new StringBuilder();
					strActionData.append(strDesc[i]).
					append(" ;~  yield =").
					append(Helper.correctDouble(strYield[i])).
					append(";~ Gross income =").
					append(Helper.correctDouble(strGrossInc[i])).
					//append(";~ Maintenance =").
					//append(Helper.correctDouble(strMaintenance[i])).
					append(";~ Netincome =").
					append(Helper.correctDouble(strNetInc[i]));
					
					
					arrValues.add(strActionData.toString());
					arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				AuditTrial.auditLogBatch(hshValues,"242",strAppNo,arrAuditBatchData);
			}
			
		} catch (Exception e) {
			log.error("Error in updateHortiProjectedIncome of Agrlandholdings"+e.getMessage());
			throw new EJBException(LAlerts.EXCEPTION+"inside updateHortiProjectedIncome"+e.toString());
		}
		
		
	}
	
	
	 public HashMap getPlantationRepayment(HashMap hshValues) 
	  {
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs1=null;
		String strQuery=null;
		String strAppNo=null;
		try {
			
			 strAppNo=correctNull((String)hshValues.get("strappno"));
			 String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			    String strfacsno="";
				HashMap hshScheme = new HashMap();
				hshScheme = Helper.splitScheme(schemetype);
				
				if(hshScheme!=null)
				{
					strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
					schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
				}
				
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("appno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				arrRow=new ArrayList();	
				strQuery = SQLParser.getSqlQuery("agr_plantationrepayment_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{	 
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs1.getString("agr_repay_appno")));//0
					arrCol.add(Helper.correctNull(rs1.getString("agr_repay_id")));//1
					arrCol.add(Helper.correctNull(rs1.getString("agr_repay_year")));//2
					arrCol.add(Helper.correctNull(rs1.getString("agr_repay_principal")));//3
					arrCol.add(Helper.correctNull(rs1.getString("agr_repay_interest")));//4							
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);
				if(rs1!=null){rs1.close();}
			}
			
			
		catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getPlantationRepayment === AgrLandholdings"+e.toString());
		}
		return hshRecord;
	  }
	 
	 
	 
	  public void updatePlantationRepayment(HashMap hshValues) 
	  {

			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;		
			ArrayList arrValues=new ArrayList();
			String strfacsno="";
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strSlno = "",strYear=null;
			String strAppno= correctNull((String)hshValues.get("strappno"));
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			ResultSet rs = null;
			ResultSet rs2 = null;
			try
			{			
				if(strAction.equals("update"))
				{	//strSecuritytype= correctNull((String )hshValues.get("sel_agrSecurity"));
					strSlno =  correctNull((String )hshValues.get("selsno"));	
					strYear = correctNull((String )hshValues.get("txt_year"));
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_plantationrepayment_update");
					if(strYear.equalsIgnoreCase(""))
					{
						arrValues.add(null);
					}
					else
					{
					arrValues.add(strYear);//year 1
					}
					arrValues.add(correctNull((String)hshValues.get("txt_principal")));//principal 2
					arrValues.add(correctNull((String)hshValues.get("txt_interest")));//interest 3							
					arrValues.add(strAppno);
					arrValues.add(strSlno);
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strAction.trim().equals("insert"))
				{				
					rs = DBUtils.executeLAPSQuery("agr_plantationrepayment_maxid^"+strAppno+"^"+schemetype+"^"+strfacsno);
					if(rs.next())
					{
							strSlno = Helper.correctInt((String)rs.getString("maxid"));
					}
					strYear = correctNull((String )hshValues.get("txt_year"));
					rs.close();		
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");	
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_plantationrepayment_insert");
					
					arrValues.add(strAppno);
					arrValues.add(strSlno);			
					if(strYear.equalsIgnoreCase(""))
					{
						arrValues.add(null);
					}
					else
					{
					arrValues.add(strYear);//year 1
					}
					arrValues.add(correctNull((String)hshValues.get("txt_principal")));//principal 2
					arrValues.add(correctNull((String)hshValues.get("txt_interest")));//interest 3
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				 if(strAction.equals("delete"))
				{
					strSlno =  correctNull((String )hshValues.get("selsno"));
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_plantationrepayment_delete");
					arrValues.add(strAppno);
					arrValues.add(strSlno);		
					arrValues.add(schemetype);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
				}
				
			}
			catch(Exception ce)
			{	log.error(ce);
				throw new EJBException(LAlerts.EXCEPTION+"inside update"+ce.toString());
			}
			finally
			{
				try
				{
					if(rs != null)
					{
						rs.close();
					}
					if(rs2 != null)
					{
						rs2.close();
					}
				}
				catch(Exception cf)
				{	log.error(cf);
					throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
				}
			}
		
	  }
	  
	

	public void updateOnFarmDevelopment(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		String strSlope1[]=null;
		String strSlope2[]=null;
		String strSlope3[]=null;
		String strlandslope=null;
		String strschemetype = correctNull((String)hshValues.get("schemetype"));	
		String schemetype=Helper.getfacilitySchemetype(strschemetype);
		String strFacSNo=Helper.getfacilitySno(strschemetype);
		
		HashMap hshValuesAgri = new HashMap();
		HashMap hshPhysical = new HashMap();
		
		try {
			strAction=(String)hshValues.get("hidAction");
			int iUpdatesize=0;
				strAppNo=correctNull((String)hshValues.get("strAppno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("appno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				strlandslope=Helper.correctNull((String)hshValues.get("landdevelopslope"));
			strSlope1= (String [])hshValues.get("txt_slope1");//Year1
			//strSlope2= (String [])hshValues.get("txt_slope2");//Year2
			//strSlope3= (String [])hshValues.get("txt_slope3");//Year3
			if(strAction.trim().equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_onfarmdevelopment_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For deleting in Physical and Financial Programme by Dinesh on 04/03/2014
				
				hshPhysical.put("scheme_sno", "1");		//Land Levelling
				hshPhysical.put("scheme_type", schemetype);
				hshPhysical.put("total_cost", "");
				hshPhysical.put("hidAction", "delete");
				hshPhysical.put("appno",strAppNo);
				hshPhysical.put("page_id","LL");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
			}
			else
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","agr_onfarmdevelopment_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				for(int k=0;k<11;k++)
				{		
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						iUpdatesize++;
						hshQuery.put("strQueryId","agr_onfarmdevelopment_insert");
						
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						
						arrValues.add(Helper.correctDouble((String)strSlope1[k]));//slope 1		
						//arrValues.add(Helper.correctDouble((String)strSlope2[k]));//slope 2		
						//arrValues.add(Helper.correctDouble((String)strSlope3[k]));//slope 3		
						arrValues.add(strlandslope);
						arrValues.add(schemetype);
						arrValues.add(strFacSNo);
						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(iUpdatesize));
						hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					
					
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For inserting in Physical and Financial Programme by Dinesh on 03/03/2014
				
				hshPhysical.put("scheme_sno", "1");		//Land Levelling
				hshPhysical.put("scheme_type", schemetype);
				hshPhysical.put("total_cost", Helper.correctDouble((String)strSlope1[10]));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",strAppNo);
				hshPhysical.put("page_id","LL");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				
			}
			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int i=0;i<3;i++)
			{	
					strActionData=new StringBuilder();
					
					strActionData.append("serial no:").
					append(i).
					append(" ;~  Slope1 =").
					append(Helper.correctDouble(strSlope1[i]));
					//append(";~ Slope2 =").
					//append(Helper.correctDouble(strSlope2[i])).
					//append(";~ slope3 =").
					//append(Helper.correctDouble(strSlope3[i]));
					arrValues.add(strActionData.toString());
					arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				AuditTrial.auditLogBatch(hshValues,"248",strAppNo,arrAuditBatchData);
			}
			
		} 	catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
		
		
	}
	/**
	 * Method to get land developement-on farm development details
	 */
	public HashMap getOnFarmDevelopment(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		ArrayList arrFarm=new ArrayList();
		String strPrdCode=null;
		String strQuery=null;
		ResultSet rs=null;
		String strExp="$";
		String strschemetype = correctNull((String)hshValues.get("schemetype"));


		String schemetype=Helper.getfacilitySchemetype(strschemetype);
	    String strFacSNo=Helper.getfacilitySno(strschemetype);
		try {
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				
				rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_landdevelop_slope", Helper.correctNull(rs.getString("agr_landdevelop_slope")));
					hshRecord.put("agr_landdevelop_inches", Helper.correctNull(rs.getString("agr_landdevelop_inches")));
					hshRecord.put("agr_landdevelop_soiltype", Helper.correctNull(rs.getString("agr_landdevelop_soiltype")));
					hshRecord.put("agr_landdevelop_justification", Helper.correctNull(rs.getString("agr_landdevelop_justification")));
					hshRecord.put("agr_landdeveloped", Helper.correctNull(rs.getString("agr_landdeveloped")));
					hshRecord.put("agr_noofhectare", Helper.correctNull(rs.getString("agr_noofhectare")));
					hshRecord.put("maintenance", Helper.correctDouble(rs.getString("agr_maintenance")));
				}
				if(rs != null)
				{
					rs.close();
				}  
				
				arrFarm = new AgrLandHoldingsBO().getOnFarmDevelopmentByAppno(strAppNo,schemetype,strFacSNo);
				hshRecord.put("arrFarm", arrFarm);
				strPrdCode=correctNull((String)hshValues.get("strprdcode"));
				if(strPrdCode.trim().equals(""))
				{
				  strPrdCode=correctNull((String)hshValues.get("prdcode"));
				}
				if(rs != null)
				{
					rs.close();
				}  
	      		/*strQuery="";
	      		strQuery=SQLParser.getSqlQuery("set_prdlanddevelopment_select^" + strPrdCode);
	      		rs = DBUtils.executeQuery(strQuery);
	      	   	if(rs.next()) 
	      		{
	      				hshRecord.put("maintenance",correctNull(rs.getString("sp_maintenance")));
	      		}*/
				
		} 	catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
		
		return hshRecord;
		
	}
	
	

	public void updateSandCasting(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		String strSixInches[]=null;
		String strTwelveInches[]=null;
		String strEighteen[]=null;
		String strParticulars[]=null;
		String strinches=null;
		String strschemetype = correctNull((String)hshValues.get("schemetype"));	


		String schemetype=Helper.getfacilitySchemetype(strschemetype);
		String strFacSNo=Helper.getfacilitySno(strschemetype);
		
		HashMap hshValuesAgri = new HashMap();
		HashMap hshPhysical = new HashMap();
		
		try {
			strAction=(String)hshValues.get("hidAction");
			int iUpdatesize=0;
				strAppNo=correctNull((String)hshValues.get("strAppno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("appno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
			strSixInches= (String [])hshValues.get("txt_sixInches");//column 6" to 12"
			strParticulars= (String [])hshValues.get("txt_particulars");//Particulars
			strinches=correctNull((String)hshValues.get("landdevelopinches"));
			if(strAction.trim().equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_sandcasting_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_sandcastingparticulars_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For deleting in Physical and Financial Programme by Dinesh on 04/03/2014
				
				hshPhysical.put("scheme_sno", "2");		//Sand Casting
				hshPhysical.put("scheme_type", schemetype);
				hshPhysical.put("total_cost", "");
				hshPhysical.put("hidAction", "delete");
				hshPhysical.put("appno",strAppNo);
				hshPhysical.put("page_id","LL");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
			}
			else
			{
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_sandcasting_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				for(int k=0;k<7;k++)
				{		
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						iUpdatesize++;
						hshQuery.put("strQueryId","agr_sandcasting_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctDouble((String)strSixInches[k]));//column 6" to 12"	
						arrValues.add(strinches);
						arrValues.add(schemetype);
						arrValues.add(strFacSNo);
						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(iUpdatesize));
						hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//To insert Particulars details
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_sandcastingparticulars_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_sandcastingparticulars_insert");
				arrValues.add(strAppNo);	//1
				arrValues.add(Helper.correctDouble((String)strParticulars[0]));//% for Stocking		
				arrValues.add(Helper.correctDouble((String)strParticulars[1]));//Remaining %		
				arrValues.add(Helper.correctDouble((String)strParticulars[2]));//rate per unit		
				arrValues.add(Helper.correctDouble((String)strParticulars[3]));//amount	
				
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_avgDepth")));//Avg depth to be fixed		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totqtyofsoil")));//Tot qty of soil required		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totCostPerAcre")));//Tot cost per acre		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_contingencies")));//contingencies		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_overallTot")));//Tot cost per acre
				arrValues.add(strinches);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For inserting in Physical and Financial Programme by Dinesh on 03/03/2014
				
				hshPhysical.put("scheme_sno", "2");		//Sand Casting
				hshPhysical.put("scheme_type", schemetype);
				hshPhysical.put("total_cost", Helper.correctDouble((String)strSixInches[6]));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",strAppNo);
				hshPhysical.put("page_id","SC");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				
			}
			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			for(int i=0;i<7;i++)
			{	
					strActionData=new StringBuilder();
					
					strActionData.append("serial no:").
					append(i).
					append(" ;~ 6 to 12 =").
					append(Helper.correctDouble(strSixInches[i]));
			}
			
			strActionData.append(
			"~avgDepth = ").append(correctNull((String)hshValues.get("txt_avgDepth"))).append(
			"~totqtyofsoil = ").append(correctNull((String )hshValues.get("txt_totqtyofsoil"))).append(
			"~totCostPerAcre = ").append(correctNull((String )hshValues.get("txt_totCostPerAcre"))).append(
			"~contingencies = ").append(correctNull((String )hshValues.get("txt_contingencies"))).append(
			"~overallTot= ").append(correctNull((String )hshValues.get("txt_overallTot"))).append(
			"~Stocking = ").append(correctNull((String )hshValues.get("strParticulars[0]"))).append(
			"~remaining= ").append(correctNull((String )hshValues.get("strParticulars[1]"))).append(
			"~Rate per unit = ").append(correctNull((String )hshValues.get("strParticulars[2]"))).append(
			"~Amount= ").append(correctNull((String )hshValues.get("strParticulars[3]")));
			AuditTrial.auditLog(hshValues,"257",strAppNo,strActionData.toString());
			
			
		} catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
		
		
	}
	/**
	 * Method to get land developement-Sand casting details by ganesan_k
	 */
	public HashMap getSandCasting(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshParticulars=new HashMap();
		String strAppNo=null;
		ArrayList arrSand=new ArrayList();
		ResultSet rs=null;
		String strschemetype = correctNull((String)hshValues.get("schemetype"));	


		String schemetype=Helper.getfacilitySchemetype(strschemetype);
		String strFacSNo=Helper.getfacilitySno(strschemetype);
		
		try {
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				arrSand = new AgrLandHoldingsBO().getSandCastingByAppno(strAppNo,schemetype,strFacSNo);
				hshRecord.put("arrSand", arrSand);
				
				hshParticulars = new AgrLandHoldingsBO().getSandCastingParticularsByAppno(strAppNo,schemetype,strFacSNo);
				hshRecord.put("hshParticulars", hshParticulars);
				if(rs!=null)
				{
					rs.close();
					rs=null;
				}
				rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_landdevelop_slope", Helper.correctNull(rs.getString("agr_landdevelop_slope")));
					hshRecord.put("agr_landdevelop_inches", Helper.correctNull(rs.getString("agr_landdevelop_inches")));
					hshRecord.put("agr_landdevelop_soiltype", Helper.correctNull(rs.getString("agr_landdevelop_soiltype")));
					hshRecord.put("agr_landdevelop_justification", Helper.correctNull(rs.getString("agr_landdevelop_justification")));
				}
				
		} 	
		catch(Exception cf)
	{
		throw new EJBException("Error closing the connection "+cf.getMessage());
	}
		return hshRecord;
	}
	
	
	public  HashMap getLandHoldingDataDisp(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3  = null;
		ResultSet rs4=null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strprd_type=correctNull((String)hshValues.get("strProductType"));
		String prd_type="";
		String strAppliName="";				
		if(!strprd_type.equalsIgnoreCase(""))
		{
			prd_type=strprd_type.substring(0,1);
		}
		//String chobank_apptype=Helper.correctNull((String)hshValues.get("chobank_apptype"));
		String  strAppType="",strAppID="",appType="",strAppName="";
		String strProfilestatus="",strAppStatus="",strCBSID="",strFarmcategory="",strComappid="";
		try
		{
			String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));	
			if(hidDemoId.equalsIgnoreCase("") || hidDemoId.equalsIgnoreCase("null")){
			strQuery = SQLParser.getSqlQuery("sel_applicantid^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))) );
					hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))) );
					hshRecord.put("applicantid",rs1.getString("demo_comappid"));
					hidDemoId=Helper.correctNull((String)rs1.getString("demo_comappnewid")); 
				}
			}
				strQuery = SQLParser.getSqlQuery("select_latestappid^"+hidDemoId);
				rs2 =DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					hidDemoId=correctNull(rs2.getString("perapp_id"));
					
				}
			
				strQuery = SQLParser.getSqlQuery("agrlandholdingsselection^"+hidDemoId);
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs2.getString("LAND_APPID")));
					vecVal.add(correctNull(rs2.getString("land_apptype")));
					/*strAppType=correctNull(rs2.getString("land_apptype"));
					strAppID=strAppType.substring(1);
					appType=strAppType.substring(0,1);
					if(prd_type.equalsIgnoreCase("a")){
						strQuery = SQLParser.getSqlQuery("cr_getcoappguarantor^"+hidDemoId+"^"+appType.toUpperCase()+"^"+strAppID);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strAppName=correctNull(rs.getString("appname"));
						}
					}*/
					vecVal.add(correctNull(rs2.getString("land_id")));
					vecVal.add(correctNull(rs2.getString("land_acreage")));
					vecVal.add(correctNull(rs2.getString("land_village")));
					vecVal.add(correctNull(rs2.getString("land_taluk")));
					vecVal.add(correctNull(rs2.getString("land_district")));
					vecVal.add(correctNull(rs2.getString("land_survey")));
					vecVal.add(correctNull(rs2.getString("land_revenue")));
					vecVal.add(correctNull(rs2.getString("land_value")));
					vecVal.add(correctNull(rs2.getString("land_owned_leased")));
					vecVal.add(correctNull(rs2.getString("land_leaseperiod")));
					vecVal.add(correctNull(rs2.getString("land_rent_repay")));
					vecVal.add(correctNull(rs2.getString("land_irrigated")));
					vecVal.add(correctNull(rs2.getString("land_which_irrigated")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_source")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_encumbrance")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_Encroached_Land")))));
					vecVal.add(correctNull(rs2.getString("land_farmdistance")));
					vecVal.add(correctNull(rs2.getString("land_housedistance")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_landlorddetails")))));//20
					vecVal.add(correctNull(rs2.getString("land_acreage1")));
					vecVal.add(correctNull(rs2.getString("land_mortgage")));
					vecVal.add(correctNull(rs2.getString("land_security")));
					vecVal.add("");
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("LAND_FRUIT")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_nonfruit")))));
					vecVal.add(correctNull(rs2.getString("land_datemortgage")));
					vecVal.add(correctNull(rs2.getString("LAND_IRRIGSIZE")));
					vecVal.add(correctNull(rs2.getString("LAND_NONIRRIGA")));
					vecVal.add(correctNull(rs2.getString("LAND_NONCULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_CULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_FARMERCATEGORY")));
					vecVal.add(correctNull(rs2.getString("LAND_LLF_TYPE")));
					strFarmcategory=Helper.correctNull(rs2.getString("LAND_FARMERCATEGORY"));
					if(!strFarmcategory.equalsIgnoreCase(""))
					{
						hshRecord.put("strFarmcategory",strFarmcategory);
					}
					/*strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+hidDemoId+"^"+strAppType);
					rs1 =DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecVal.add(correctNull(rs1.getString("year1")));
						vecVal.add(correctNull(rs1.getString("year2")));
						vecVal.add(correctNull(rs1.getString("year3")));
						vecVal.add(correctNull(rs1.getString("grossinc1")));
						vecVal.add(correctNull(rs1.getString("grossinc2")));
						vecVal.add(correctNull(rs1.getString("grossinc3")));
					}*/
					vecData.add(vecVal);		
				}
			hshRecord.put("vecData",vecData);
	    	/*strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+hidDemoId);
			rs3 = DBUtils.executeQuery(strQuery);
			if(rs3.next())
			{
				hshRecord.put("land_measurement",Helper.correctNull(rs3.getString("land_measurement")));
			}*/
			rs = DBUtils.executeLAPSQuery("selLandAcreage^" + hidDemoId);
			if(rs.next())
			{
				hshRecord.put("strAcress", correctNull((String) rs.getString(1)));
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				strCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
			}			
			rs4=DBUtils.executeLAPSQuery("coapdetails^"+hidDemoId);
			if(rs4.next())
			{
				strAppliName=correctNull((String)rs4.getString("perapp_fname"));
			}
			//hshRecord.put("chobank_apptype",chobank_apptype);
			hshRecord.put("hidAction",strAction);
			hshRecord.put("strProfilestatus",strProfilestatus);
			hshRecord.put("appstatus", strAppStatus);
			hshRecord.put("strCBSID", strCBSID);
			hshRecord.put("perapp_id",hidDemoId);
			hshRecord.put("applicantid",hidDemoId);			
			hshRecord.put("AppliName", strAppliName);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4!=null)
				{
					rs4.close();
				}
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
	
	/** Added by DINESH on 03/03/2014 for Physical and Financial Programme Functionality **/
	
	public void updatePhysicalProgramme(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0,maxsno=0,maxsno1=0;
		StringBuilder sbolddata=new StringBuilder();
		String strScheme="",str_yearcount="",str_desc2="",str_avail="",str_actCode="",str_unitCost="",strPageID="",str_actAvail="",strPlantsno="";
		double amt2=0.00,dbunitCost=0.00,dbunitCostto=0.00;
		String strfacsno="";
		
		int intselyear = 1,intarea=1;
		
		try
		{
			String strSchsno = correctNull((String)hshValues.get("scheme_sno"));
			double dbtotal = Double.parseDouble(Helper.correctDouble((String)hshValues.get("total_cost")));
			strScheme = correctNull((String)hshValues.get("scheme_type"));
			strPageID = correctNull((String)hshValues.get("page_id"));
			strPlantsno = correctNull((String)hshValues.get("plant_sno"));
			
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(strScheme);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				strScheme = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(strPlantsno.equalsIgnoreCase(""))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","delete_agrfinProgramme");
					arrValues.add(appno);
					arrValues.add(strScheme);  
					arrValues.add(strPageID); 
					arrValues.add(strfacsno); // added by Subha
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				rs = DBUtils.executeLAPSQuery("sel_farmDev_activitymaster^"+strScheme+"^"+strSchsno);
				if(rs.next())
				{
					str_yearcount=Helper.correctNull(rs.getString("act_years"));
					str_desc2=Helper.correctNull(rs.getString("act_desc2"));
					amt2=Double.parseDouble(Helper.correctDouble(rs.getString("act_amt2")));
					str_avail=Helper.correctNull(rs.getString("act_whether2"));
					str_actCode=Helper.correctNull(rs.getString("act_sno"));
					dbunitCost=Double.parseDouble(Helper.correctDouble(rs.getString("act_rangefrom")));
					dbunitCostto=Double.parseDouble(Helper.correctDouble(rs.getString("act_rangeto")));
					str_actAvail=Helper.correctNull(rs.getString("act_available"));
				}
				
				int j=Integer.parseInt(Helper.correctInt((String)str_yearcount));
				
				rs = DBUtils.executeLAPSQuery("sel_max_agr_finprogramme^"+appno);
				if(rs.next())
				{
					maxsno = rs.getInt("afp_sno");
				}
				intUpdatesize+=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","ins_agr_finprogramme");
				arrValues.add(appno);
				arrValues.add(String.valueOf(maxsno));   
				arrValues.add(Integer.toString(intselyear)); 
				arrValues.add(str_actCode); 	//Activity code
				
				if(str_actAvail.equalsIgnoreCase("N"))
				{ 
					arrValues.add("0.00"); 	//Amt range from
				}
				else
				{
					arrValues.add(""+dbunitCost);
				}
				
				arrValues.add(Integer.toString(intarea)); 		//Area
				arrValues.add(""+dbtotal); 		//Total Cost
				arrValues.add("0.00"); 
				arrValues.add(""+dbtotal); 		//Bank loan
				arrValues.add("0"); 
				arrValues.add(""+dbtotal); 		//Unit cost adapted
				arrValues.add("3");				//Acre
				
				if(str_actAvail.equalsIgnoreCase("N"))
				{ 
					arrValues.add("0.00"); 	//Amt range to
				}
				else
				{
					arrValues.add(""+dbunitCostto); //Amt range to
				}
				
				arrValues.add(strScheme); //Scheme Type
				arrValues.add(strPageID); //Page ID
				arrValues.add(strPlantsno);	//Plant sno
				arrValues.add(strfacsno);	// added Facility sno by subha
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				if(str_avail.equalsIgnoreCase("Y"))
				{ 
					int yrdiff = (j -  intselyear)+1;
					for(int h=1;h<yrdiff;h++)
					{
						int c=(intselyear)+(h);
						double adpcost=dbtotal;
						double margin=0.00;
						
						double minamt=Math.min(amt2, adpcost);
						double area= Double.parseDouble(Integer.toString(intarea));
						double totarea= minamt*area;
						double bankloan=totarea-(totarea*margin)/100;
						
						intUpdatesize+=1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",""+intUpdatesize);
						hshQuery.put("strQueryId","ins_agr_finprogramme");
						arrValues.add(appno);
						arrValues.add(String.valueOf(c));   
						arrValues.add(""+c); 
						arrValues.add(str_desc2); 
						arrValues.add(""+amt2); 
						arrValues.add(Integer.toString(intarea)); 	//No.of units
						arrValues.add(""+totarea); 
						arrValues.add("0.00"); 
						arrValues.add(""+bankloan); 
						arrValues.add(String.valueOf(maxsno)); 
						arrValues.add(""+adpcost); 
						arrValues.add("3");
						arrValues.add(""+dbunitCostto); 
						arrValues.add(strScheme); //Scheme Type
						arrValues.add(strPageID); //Page ID
						arrValues.add(strPlantsno);	//Plant sno
						arrValues.add(strfacsno);	// added Facility sno by subha
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize+=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","update_agrFinprogramme");
				arrValues.add(""+dbtotal); 
				arrValues.add(""+dbtotal); 
				arrValues.add(""+dbtotal); 
				arrValues.add(appno); 
				arrValues.add(strPlantsno); 
				arrValues.add("0"); 
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
	
			else if(strAction.equalsIgnoreCase("delete"))
			{
				if(strPlantsno.equalsIgnoreCase(""))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","delete_agrfinProgramme");
					arrValues.add(appno);
					arrValues.add(strScheme);  
					arrValues.add(strPageID); 
					arrValues.add(strfacsno);// added by Subha
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_agrfinProg_plantdetail");
					arrValues.add(appno);
					arrValues.add(strScheme);  
					arrValues.add(strPageID); 
					arrValues.add(strPlantsno); 
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
	}
	
	/** END **/
}