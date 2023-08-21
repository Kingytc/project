package com.sai.laps.ejb.rules;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;


import com.sai.fw.management.log.LogWriter;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.ejb.rules.AgrCropAssessmentBO;

public class AgrCropAssessmentBO {
public ArrayList getCorpAssessmentByAppNo(String strAppNo,String schemetype,String facilitiysno) throws Exception
{
	String strQuery=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	ArrayList arrRow = null;
	ArrayList arrData= new ArrayList();
	String serialNo=null;
	String strMeastype="";

	strQuery = SQLParser.getSqlQuery("agrcropassessment_select^"+strAppNo+"^"+schemetype+"^"+facilitiysno);
	rs = DBUtils.executeQuery(strQuery);
	try{
	while(rs.next())
	{	 
		strMeastype=Helper.correctNull(rs.getString("agr_measurementtype"));
		 arrRow = new ArrayList();
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sno")));//0
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_season")));//1 
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_crop")));//2
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sowmon")));//3
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_harvmon")));//4
		 if(strMeastype.equals("2"))
			{
			 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_areacul")));//5
			}
			else
			{
				arrRow.add("0");
			}
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_amount")));//6
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_eligibility")));//7
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limapplied")));//8
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limitrecom")));//9
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_duedate")));//10
		 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_COSTOFCULTIVATION")));//11
		 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_STATE")));//12
		 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_DISTRICT")));//13
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_plantname")));//14		
		 if(strMeastype.equals("1")||!Helper.correctNull(rs.getString("agr_cas_assessmenttype")).equalsIgnoreCase("130"))
			{
			 arrRow.add(Helper.correctNull(rs.getString("agr_noofplants")));//15
			}
			else
			{
				arrRow.add("0");
			}
		 arrRow.add(strMeastype);//16
		 arrRow.add(Helper.correctNull(rs.getString("AGR_SCLOFFIN")));//17
		 
		 if(!Helper.correctNull(rs.getString("agr_cas_assessmenttype")).equalsIgnoreCase("130"))
		 {
			 if(rs1!=null)
				 rs1.close();
			 rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+Helper.correctNull(rs.getString("agr_cas_assessmenttype"))+"^"+Helper.correctNull(rs.getString("AGR_SCLOFFIN")));
			 if(rs1.next())
			 {
				 arrRow.add(Helper.correctNull((String)rs1.getString("stat_data_value")));//18
				 arrRow.add(Helper.correctNull((String)rs1.getString("stat_data_valuedesc")));//19
			 }
			 else
			 {
				 arrRow.add("");
				 arrRow.add("");
			 }
		 }
		 else
		 {
			 arrRow.add("");
			 arrRow.add("");
		 }
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_assessmenttype")));//20
		  serialNo=Helper.correctNull(rs.getString("agr_cas_plantname"));//
		
		 if(rs1!=null){rs1.close();}

	     arrData.add(arrRow);	
	}
	if(rs!=null){rs.close();}
	if(rs1!=null){rs1.close();}
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		if(rs1!=null){rs1.close();}
		LogWriter.log("Error in getCorpAssessmentByAppNo of AgrCorpAssessmentBO::" +e.getMessage());
		throw new EJBException("Error closing the connection getCorpAssessmentByAppNo"+e.getMessage());
	}
	
	return arrData;
}

public ArrayList getRytuCorpAssessmentByAppNo(String strAppNo,String strAppId,String schemetype,String facilitiysno) throws Exception
{
	String strQuery=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	ArrayList arrRow = null;
	ArrayList arrData= new ArrayList();
	String serialNo=null;
	//String strfacilitiysno="1";
	strQuery = SQLParser.getSqlQuery("agrcropassessment_select^"+strAppNo+"^"+schemetype+"^"+facilitiysno);
	rs = DBUtils.executeQuery(strQuery);
	try{
	while(rs.next())
	{	 
		
		 arrRow = new ArrayList();
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sno")));//0
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_season")));//1 
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_crop")));//2
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sowmon")));//3
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_harvmon")));//4
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_areacul")));//5
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_amount")));//6
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_eligibility")));//7
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limapplied")));//8
		 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limitrecom")));//9
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_duedate")));//10
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_costofcultivation")));//11
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_state")));//12
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_district")));//13
		 arrRow.add(Helper.correctNull(rs.getString("agr_cas_plantname")));//14
		 arrRow.add(Helper.correctNull(rs.getString("AGR_NOOFPLANTS")));//14
		 serialNo=Helper.correctNull(rs.getString("agr_cas_plantname"));
		 if(rs1!=null){rs1.close();}
		 rs1=DBUtils.executeLAPSQuery("per_selfhelpgroupdetails_selectByIdName^"+strAppId+"^"+serialNo);
			if(rs1.next())
			{
				arrRow.add(Helper.correctNull(rs1.getString("pa_membername")));//15
			}
			else{
				arrRow.add("");//15
			}
	     arrData.add(arrRow);	
	}
	if(rs!=null){rs.close();}
	if(rs1!=null){rs1.close();}
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		if(rs1!=null){rs1.close();}
		LogWriter.log("Error in getRytuCorpAssessmentByAppNo of AgrCorpAssessmentBO::" +e.getMessage());
		throw new EJBException("Error closing the connection getRytuCorpAssessmentByAppNo"+e.getMessage());
	}
	
	return arrData;
}

public HashMap getFisherySurplusByAppNo(String strAppNo)throws Exception
{
	HashMap hshSurpl = new HashMap();
	ResultSet rs=null;
	try{
		String strQuery=null;
		
		
		strQuery = SQLParser.getSqlQuery("agr_fisheries_cultivationcost_select^"+strAppNo);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{		
			hshSurpl.put("agr_netsurpdepr",FwHelper.correctNull(rs.getString("agr_netsurpdepr")));
			hshSurpl.put("agr_netsurplus",FwHelper.correctNull(rs.getString("agr_netsurplus")));
			hshSurpl.put("agr_deprequip",FwHelper.correctNull(rs.getString("agr_deprequip")));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		LogWriter.log("Exception in getFisherySurplusByAppNo::"+e.getMessage());
	}
	return hshSurpl;
}

public ArrayList getFisheryExvacationByAppNo(String strAppNo)throws Exception
{
	ArrayList arrFishExc=new ArrayList();	
	ResultSet rs=null;
	try{
		String strQuery=null;
		
		strQuery = SQLParser.getSqlQuery("agr_fisheriesexcavation_depreciation_select^"+strAppNo);	
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{			
			arrFishExc.add(Helper.correctNull(rs.getString("agr_depreciation")));
			arrFishExc.add(Helper.correctNull(rs.getString("agr_totexcavation")));
			arrFishExc.add(Helper.correctNull(rs.getString("agr_totrenovation")));
			
		}
		if(rs!=null){rs.close();}
	
	}catch(Exception e)
	{	
		if(rs!=null){rs.close();}
		LogWriter.log("Exception in getFisheryExvacationByAppNo::"+e.getMessage());
	}
	return arrFishExc;
}

public double getTotalCostOfCultivationByAppNo(String strAppNo) throws Exception
{
	String strQuery=null;
	ResultSet rs=null;
	
	double dblTotCost=0.00;
	strQuery = SQLParser.getSqlQuery("agr_cropassessment_totcostofcultvsum^"+strAppNo);
	rs = DBUtils.executeQuery(strQuery);
	try{
		if(rs.next())
		{	 
			dblTotCost=FwHelper.parseDouble(rs.getString("totalcostofcultivation"));  
		}
		
		
	}
	catch(Exception e)
	{
		LogWriter.log("Error in getTotalCostOfCultivationByAppNo of AgrCorpAssessmentBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return dblTotCost;
}
	public HashMap getLimitsPagePopupDataByAppNoandPrdCode(String strAppNo,String strPrdCode)throws Exception
	{
		HashMap	 hshRecord = new HashMap();
		String strQuery=null;
		ResultSet rs=null;
		try
		{
			strQuery=SQLParser.getSqlQuery("set_perprdagriproperties_select^" + strPrdCode);
	  		rs = DBUtils.executeQuery(strQuery);
	  	   	if(rs.next()) 
	  	   	{
	  	   		hshRecord.put("consumptionneeds",Helper.correctDouble(rs.getString("sa_consumptionneeds")));
				hshRecord.put("allied",Helper.correctDouble(rs.getString("SA_ALLIED")));
				hshRecord.put("nonfarm",Helper.correctDouble(rs.getString("SA_NONFARM")));
	  	   	}
	  	   	if(rs!=null) rs.close();
	  	   	
			strQuery = SQLParser.getSqlQuery("agr_cropassessment_eligibility_sum^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	 
				hshRecord.put("eligibility",Helper.correctDouble(rs.getString("agr_cas_eligibility")));
			}
			else
			{
				hshRecord.put("eligibility","0.00");
			}
			if(rs!=null) rs.close();
			strQuery=SQLParser.getSqlQuery("agr_cropassesment_popup_select^" + strAppNo);
	  		rs = DBUtils.executeQuery(strQuery);
	  	   	if(rs.next()) 
	  	   	{
	  	   		hshRecord.put("agr_appno",Helper.correctNull(rs.getString("agr_appno")));
				hshRecord.put("agr_allied",Helper.correctDouble(rs.getString("agr_allied")));
				hshRecord.put("agr_nonfarm",Helper.correctDouble(rs.getString("agr_nonfarm")));
				hshRecord.put("agr_consumption",Helper.correctDouble(rs.getString("agr_consumption")));
	  	   	}
			
		}catch(Exception e)
		{
			if(rs!=null) rs.close();
			LogWriter.log("Error in getLimitsPagePopupDataByAppNoandPrdCode of AgrCorpAssessmentBO::" +e.getMessage());
			throw new EJBException("Error closing the connection getLimitsPagePopupDataByAppNoandPrdCode"+e.getMessage());
		}
		
		return hshRecord ;
	}
	public HashMap getSoilReclamationByAppno(String strAppNo,String strSoilType,String schemetype,String AGR_FACSNO) throws Exception
	{
		HashMap hshSoil=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_soilreclamation_select^"+strAppNo+"^"+schemetype+"^"+AGR_FACSNO);
			while(rs.next())
			{
				
				hshSoil.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshSoil.put("soiltype", Helper.correctNull(rs.getString("agr_soiltype")));
				hshSoil.put("limepertone", Helper.correctNull(rs.getString("agr_limepertone")));
				hshSoil.put("limenooftonnes", Helper.correctNull(rs.getString("agr_limenooftonnes")));
				hshSoil.put("limetotcost", Helper.correctNull(rs.getString("agr_limetotcost")));
				hshSoil.put("labour", Helper.correctNull(rs.getString("agr_labour")));
				hshSoil.put("incorporation", Helper.correctNull(rs.getString("agr_incorporation")));
				hshSoil.put("flooring", Helper.correctNull(rs.getString("agr_flooring")));
				hshSoil.put("totalcost", Helper.correctNull(rs.getString("agr_totalcost")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSoilReclamationByAppno AgrCorpAssessmentBO::" +e.getMessage());
			throw new EJBException("Error in getSoilReclamationByAppno === AgrCorpAssessmentBO"+e.toString());
		}
		
		return hshSoil;
	}
	public HashMap getGreenCardIncomeByAppno(String strAppNo) throws Exception
	{
		HashMap hshIncome=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_greencardincome_select^"+strAppNo);
			while(rs.next())
			{
				hshIncome.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshIncome.put("agr_landedprop", Helper.correctNull(rs.getString("agr_landedprop")));
				hshIncome.put("agr_valuername", Helper.correctNull(rs.getString("agr_valuername")));
				hshIncome.put("agr_valuationdate", Helper.correctNull(rs.getString("agr_valuationdate")));
				hshIncome.put("agr_farmincome", Helper.correctNull(rs.getString("agr_farmincome")));
			
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getGreenCardIncomeByAppno AgrCorpAssessmentBO::" +e.getMessage());
			throw new EJBException("Error in getGreenCardIncomeByAppno === AgrCorpAssessmentBO"+e.toString());
		}
		
		return hshIncome;
	}
	
	public HashMap getMinorIrrigationByAppno(String strAppNo) throws Exception
	{
		HashMap hshMinor=new HashMap();
		ResultSet rs=null;
		try 
		{
						
			rs=DBUtils.executeLAPSQuery("agr_minorirrigation_select^"+strAppNo);
			if(rs.next())
			{
				hshMinor.put("agr_appno", strAppNo);
				hshMinor.put("am_type", Helper.correctNull(rs.getString("agr_type")));
				hshMinor.put("am_location", Helper.correctNull(rs.getString("agr_location")));
				hshMinor.put("am_typeofwell", Helper.correctNull(rs.getString("agr_typeofwell")));
				hshMinor.put("am_sizeofwell", Helper.correctNull(rs.getString("agr_sizeofwell"))); 
				hshMinor.put("am_welldiameter", Helper.correctNull(rs.getString("agr_welldiameter")));
				hshMinor.put("am_esttotalcost", Helper.correctNull(rs.getString("agr_esttotalcost")));
				hshMinor.put("am_waterliftsource", Helper.correctNull(rs.getString("agr_waterliftsource")));
				hshMinor.put("am_deepeningcost", Helper.correctNull(rs.getString("agr_deepeningcost"))); 
				hshMinor.put("am_wallscost", Helper.correctNull(rs.getString("agr_wallscost")));
				hshMinor.put("am_othercost", Helper.correctNull(rs.getString("agr_othercost"))); 
				hshMinor.put("am_areabenefited", Helper.correctNull(rs.getString("agr_areabenefited")));
				hshMinor.put("am_pump_item", Helper.correctNull(rs.getString("agr_pump_item")));
				hshMinor.put("am_pump_make", Helper.correctNull(rs.getString("agr_pump_make")));
				hshMinor.put("am_pump_hp", Helper.correctNull(rs.getString("agr_pump_hp"))); 
				hshMinor.put("am_watersource", Helper.correctNull(rs.getString("agr_watersource")));
				hshMinor.put("am_tube_elecdsl", Helper.correctNull(rs.getString("agr_tube_elecdsl"))); 
				hshMinor.put("am_tube_cavstnr", Helper.correctNull(rs.getString("agr_tube_cavstnr")));
				hshMinor.put("am_tube_borepipesize", Helper.correctNull(rs.getString("agr_tube_borepipesize")));
				hshMinor.put("am_tube_delivpipisize", Helper.correctNull(rs.getString("agr_tube_delivpipisize")));
				hshMinor.put("am_excesswaterusage", Helper.correctNull(rs.getString("agr_excesswaterusage")));
				hshMinor.put("am_feasibility", Helper.correctNull(rs.getString("agr_feasibility")));
				hshMinor.put("am_feasibilityreason", Helper.correctNull(rs.getString("agr_feasibilityreason")));
				hshMinor.put("am_clearanceriverdpt", Helper.correctNull(rs.getString("agr_clearanceriverdpt")));
				hshMinor.put("am_clearancereason", Helper.correctNull(rs.getString("agr_clearancereason")));
				hshMinor.put("am_electricity", Helper.correctNull(rs.getString("agr_electricity")));
				hshMinor.put("am_elecdocs", Helper.correctNull(rs.getString("agr_elecdocs")));
				hshMinor.put("am_croppingpattern", Helper.correctNull(rs.getString("agr_croppingpattern")));
				hshMinor.put("am_cropppingreason", Helper.correctNull(rs.getString("agr_cropppingreason")));
				hshMinor.put("am_watersuitableirrig", Helper.correctNull(rs.getString("agr_watersuitableirrig"))); 
				hshMinor.put("am_waterirrigreason", Helper.correctNull(rs.getString("agr_waterirrigreason")));
				hshMinor.put("am_waterproposed", Helper.correctNull(rs.getString("agr_waterproposed")));
				hshMinor.put("am_waterproposedinc", Helper.correctDouble(rs.getString("agr_waterproposedinc")));
				hshMinor.put("am_netamt", Helper.correctNull(rs.getString("agr_netamt")));
				hshMinor.put("am_exp_additional_income", Helper.correctNull(rs.getString("agr_exp_additional_income")));
				hshMinor.put("am_netamtsource", Helper.correctNull(rs.getString("agr_netamtsource")));
				hshMinor.put("am_netamount", Helper.correctNull(rs.getString("agr_netamount")));
				hshMinor.put("am_elecWorks", Helper.correctNull(rs.getString("agr_elecWorks")));
				hshMinor.put("am_elecDrawing", Helper.correctNull(rs.getString("agr_elecDrawing")));
				hshMinor.put("am_elecDeposit", Helper.correctNull(rs.getString("agr_elecDeposit")));
				hshMinor.put("am_estcostpropwell", Helper.correctNull(rs.getString("agr_estcostpropwell")));
				
				hshMinor.put("agr_groundwater", Helper.correctNull(rs.getString("agr_groundwater")));
				hshMinor.put("agr_noofwells", Helper.correctNull(rs.getString("agr_noofwells")));
				hshMinor.put("agr_potential", Helper.correctNull(rs.getString("agr_potential")));
				hshMinor.put("agr_mindistance", Helper.correctNull(rs.getString("agr_mindistance")));
				hshMinor.put("agr_margin", Helper.correctNull(rs.getString("agr_margin")));
			}
			
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getMinorIrrigationByAppno AgrCorpAssessmentBO::" +e.getMessage());
			throw new EJBException("Error in getMinorIrrigationByAppno === AgrCorpAssessmentBO"+e.toString());
		}
		
		return hshMinor;
	}
	
	
}