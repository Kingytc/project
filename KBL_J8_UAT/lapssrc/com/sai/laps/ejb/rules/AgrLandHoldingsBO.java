package com.sai.laps.ejb.rules;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class AgrLandHoldingsBO {

	static Logger log=Logger.getLogger(AgrLandHoldingsBO.class);	

	public ArrayList getLandHodingsByAppNo(String strAppNo) throws Exception
	{
		
		String strQuery=null;
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrRow = null;
		ArrayList arrCol= new ArrayList();
		strQuery = SQLParser.getSqlQuery("agr_landholdings_select^"+strAppNo);
		rs1 = DBUtils.executeQuery(strQuery);
		try{
			arrRow=new ArrayList();	
			while(rs1.next())
			{	 
				
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_appno")));//0
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_id")));//1
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_apptype")));//2
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_village")));//3
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_mandal")));//4
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_totalacre")));//5
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_survey")));//6
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_marketvalue")));//7
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_leased")));//8
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_irrigated")));//9
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_typeofsoil")));//10
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_nature")));// 11 
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_sourceirridation")));//12
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_encumbrance")));//13 
				arrCol.add("");//14
	
				final String strAppType=Helper.correctNull(rs1.getString("agr_land_apptype"));
				String strAppId=null;
				if(strAppType.length()>1)
					strAppId=Helper.correctNull(strAppType.substring(1));
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("perfinancialbnk_agr^"+strAppNo+"^"+Helper.correctNull(strAppType));
				if(rs.next())
				{
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));//15 Name
				}
				else
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("selectagrcomname^"+Helper.correctNull(strAppType));
					if(rs.next())
					{
						arrCol.add(Helper.correctNull(rs.getString("comapp_companyname")));//15 Name
					}
					else{
					arrCol.add("");//15
					}
				}
				
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_district")));// 16
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_state")));// 17
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_leasecond")));// 18
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_collsec")));// 19
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_allied")));// 20
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_nonfarm")));// 21
				arrCol.add(Helper.correctNull(rs1.getString("agr_land_collcomments")));// 22
				arrCol.add(Helper.correctNull(rs1.getString("agr_whetherregistered")));// 23
				arrCol.add(Helper.correctNull(rs1.getString("agr_wardno")));//24
				arrCol.add(Helper.correctNull(rs1.getString("agr_village")));//25
				arrCol.add(Helper.correctNull(rs1.getString("agr_panchayat")));//26
		      	
				arrRow.add(arrCol);
			}
			if(rs!=null){rs.close();}
			if(rs1!=null){rs1.close();}
		}catch(Exception e)
		{
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getLandHodingsByAppNo of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getLandHodingsByAppNo === AgrLandHoldingsBO"+e.toString());
			
		
		}
		
		return arrRow;
	}

	public ArrayList getLandHoldingsSurveyandVillageByAppno(String strAppNo)throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		try {
			
			rs=DBUtils.executeLAPSQuery("agr_landholdings_survey_select^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("agr_land_id")));//0
				arrCol.add(Helper.correctNull(rs.getString("agr_land_survey")));//1
				arrCol.add(Helper.correctNull(rs.getString("agr_land_village")));//2
				arrCol.add(Helper.correctNull(rs.getString("agr_land_apptype")));//3
				arrCol.add(Helper.correctNull(rs.getString("agr_land_totalacre")));//4
				arrRow.add(arrCol);	
			}
			if(rs!=null)rs.close();
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getLandHoldingsSurveyandVillageByAppno of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getLandHoldingsSurveyandVillageByAppno === AgrLandHoldingsBO"+e.toString());
			
		
		}
		return arrRow;
	}
	public ArrayList getLandHoldingsSecurityByAppno(String strAppNo) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		try {
			rs=DBUtils.executeLAPSQuery("agr_landholdings_security_select^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_appno")));//0 Appno
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_id")));//1 Security Id
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_apptype")));//2 Applicant Type
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_survey")));//3 Survey ID
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_type")));//4 Security Type
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_extland")));//5 Extend of Land
				arrCol.add(Helper.correctNull(rs.getString("agr_landsec_detoftitle")));//6 Details of Title of Deed
				
				
				final String strAppType=Helper.correctNull(rs.getString("agr_landsec_apptype"));
				String strAppId=null;
				if(strAppType.length()>1)
					strAppId=Helper.correctNull(strAppType.substring(1));
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("perfinancialbnk_agr^"+strAppNo+"^"+Helper.correctNull(strAppType));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("perapp_fname")));//7 Name
				else
					arrCol.add("");//7
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("agr_landholdings_survey_select_Byid^"+strAppNo+"^"+Helper.correctNull(rs.getString("agr_landsec_survey")));
				if(rs1.next())
					arrCol.add(Helper.correctNull(rs1.getString("agr_land_survey"))+"\t-\t"+Helper.correctNull(rs1.getString("agr_land_village")));//8 Village
				else
					arrCol.add("");//8
				
				arrRow.add(arrCol);	
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getLandHoldingsSecurityByAppno of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getLandHoldingsSecurityByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		
		
		return arrRow;
	}
	
	public HashMap getAgencyDetailsByAppno(String strAppNo) throws Exception
	{
		HashMap hshAgency=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_tieupagency_select^"+strAppNo);
			while(rs.next())
			{
				
				hshAgency.put("appnumber", Helper.correctNull(rs.getString("agr_appno")));
				hshAgency.put("factoryname", Helper.correctNull(rs.getString("agr_factoryname")));
				hshAgency.put("amountrecommended", Helper.correctNull(rs.getString("agr_amountrecommended")));
				hshAgency.put("address1", Helper.correctNull(rs.getString("agr_address1")));
				hshAgency.put("address2", Helper.correctNull(rs.getString("agr_address2")));
				hshAgency.put("city", Helper.correctNull(rs.getString("agr_city")));
				hshAgency.put("state", Helper.correctNull(rs.getString("agr_state")));
				hshAgency.put("district", Helper.correctNull(rs.getString("agr_district")));
				hshAgency.put("pincode", Helper.correctNull(rs.getString("agr_pincode")));
				hshAgency.put("sugarquotadetails", Helper.correctNull(rs.getString("agr_sugarquotadetails")));
				hshAgency.put("refno", Helper.correctNull(rs.getString("agr_refno")));
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getAgencyDetailsByAppno of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getAgencyDetailsByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		
		
		return hshAgency;
	}
	
	public HashMap getTobaccoDetailsByAppno(String strAppNo) throws Exception
	{
		HashMap hshAgency=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_tobacco_select^"+strAppNo);
			while(rs.next())
			{
				
				hshAgency.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshAgency.put("permitobtained", Helper.correctNull(rs.getString("agr_permitobtained")));
				hshAgency.put("istieup", Helper.correctNull(rs.getString("agr_istieup")));
				hshAgency.put("regnumber", Helper.correctNull(rs.getString("agr_regnumber")));
				hshAgency.put("noofbarrens", Helper.correctNull(rs.getString("agr_noofbarrens")));
				hshAgency.put("barrennum", Helper.correctNull(rs.getString("agr_barrennum")));
				hshAgency.put("barrenshare", Helper.correctNull(rs.getString("agr_barrenshare")));
				hshAgency.put("quantity", Helper.correctNull(rs.getString("agr_quantity")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getTobaccoDetailsByAppnoof AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getTobaccoDetailsByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		
		
		return hshAgency;
	}
	
	public HashMap getHorticulturePlantNameByAppno(String strAppNo) throws Exception
	{
		HashMap hshPlantName=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_Horti_Plantname_select^"+strAppNo);
			while(rs.next())
			{
				
				hshPlantName.put(Helper.correctNull(rs.getString("agr_horti_id")), Helper.correctNull(rs.getString("agr_horti_Plantname")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getHorticulturePlantNameByAppno AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getHorticulturePlantNameByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		
		
		return hshPlantName;
	}
	
	public HashMap getHorticultureUnitCostByAppno(String strAppNo) throws Exception
	{
		HashMap hshPlantName=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_horti_plantdetail_sellingunitcost_select^"+strAppNo);
			while(rs.next())
			{
				
				hshPlantName.put(Helper.correctNull(rs.getString("agr_horti_id")), Helper.correctNull(rs.getString("AGR_HORTI_TOTALACRE")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getHorticultureUnitCostByAppno AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getHorticultureUnitCostByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		
		
		return hshPlantName;
	}
	/**
	 * Method to get fisheries details
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	
	public HashMap getFisheriesDetailsByAppno(String strAppNo) throws Exception
	{
		HashMap hshAgency=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_fisheries_select^"+strAppNo);
			while(rs.next())
			{
				hshAgency.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
				hshAgency.put("agr_drying", Helper.correctNull(rs.getString("agr_drying")));
				hshAgency.put("agr_limingkg", Helper.correctNull(rs.getString("agr_limingkg")));
				hshAgency.put("agr_limingrsperkg", Helper.correctNull(rs.getString("agr_limingrsperkg")));
				hshAgency.put("agr_limingtotal", Helper.correctNull(rs.getString("agr_limingtotal")));
				hshAgency.put("agr_poultrytonne", Helper.correctNull(rs.getString("agr_poultrytonne")));//6
				hshAgency.put("agr_watering", Helper.correctNull(rs.getString("agr_watering")));
				hshAgency.put("agr_poultryrspertonne", Helper.correctNull(rs.getString("agr_poultryrspertonne")));
				hshAgency.put("agr_poultrytotal", Helper.correctNull(rs.getString("agr_poultrytotal")));
				hshAgency.put("agr_ssptonne", Helper.correctNull(rs.getString("agr_ssptonne")));
				
				hshAgency.put("agr_ssprspertonne", Helper.correctNull(rs.getString("agr_ssprspertonne")));//11
				hshAgency.put("agr_ssptotal", Helper.correctNull(rs.getString("agr_ssptotal")));
				hshAgency.put("agr_ureatonne", Helper.correctNull(rs.getString("agr_ureatonne")));
				hshAgency.put("agr_urearspertonne", Helper.correctNull(rs.getString("agr_urearspertonne")));
				hshAgency.put("agr_ureatotal", Helper.correctNull(rs.getString("agr_ureatotal")));
				hshAgency.put("agr_otherstonne", Helper.correctNull(rs.getString("agr_otherstonne")));//16
				hshAgency.put("agr_othersrspertonne", Helper.correctNull(rs.getString("agr_othersrspertonne")));
				hshAgency.put("agr_otherstotal", Helper.correctNull(rs.getString("agr_otherstotal")));
				hshAgency.put("agr_variety1", Helper.correctNull(rs.getString("agr_variety1")));
				hshAgency.put("agr_variety1num", Helper.correctNull(rs.getString("agr_variety1num")));

				hshAgency.put("agr_variety1rs", Helper.correctNull(rs.getString("agr_variety1rs")));	//21
				hshAgency.put("agr_variety1total", Helper.correctNull(rs.getString("agr_variety1total")));
				hshAgency.put("agr_variety2", Helper.correctNull(rs.getString("agr_variety2")));
				hshAgency.put("agr_variety2num", Helper.correctNull(rs.getString("agr_variety2num")));
				hshAgency.put("agr_variety2rs", Helper.correctNull(rs.getString("agr_variety2rs")));
				hshAgency.put("agr_variety2total", Helper.correctNull(rs.getString("agr_variety2total")));//26
				hshAgency.put("agr_variety3", Helper.correctNull(rs.getString("agr_variety3")));
				hshAgency.put("agr_variety3num", Helper.correctNull(rs.getString("agr_variety3num")));
				hshAgency.put("agr_variety3rs", Helper.correctNull(rs.getString("agr_variety3rs")));
				hshAgency.put("agr_variety3total", Helper.correctNull(rs.getString("agr_variety3total")));
				
				hshAgency.put("agr_dobtone", Helper.correctNull(rs.getString("agr_dobtone")));	//31
				hshAgency.put("agr_dobrspertone", Helper.correctNull(rs.getString("agr_dobrspertone")));
				hshAgency.put("agr_dobtotal", Helper.correctNull(rs.getString("agr_dobtotal")));
				hshAgency.put("agr_caketone", Helper.correctNull(rs.getString("agr_caketone")));
				hshAgency.put("agr_cakerspertone", Helper.correctNull(rs.getString("agr_cakerspertone")));
				hshAgency.put("agr_caketotal", Helper.correctNull(rs.getString("agr_caketotal")));//36
				hshAgency.put("agr_labourmon", Helper.correctNull(rs.getString("agr_labourmon")));
				hshAgency.put("agr_labourrspermon", Helper.correctNull(rs.getString("agr_labourrspermon")));
				hshAgency.put("agr_labourtotal", Helper.correctNull(rs.getString("agr_labourtotal")));
				hshAgency.put("agr_harvest", Helper.correctNull(rs.getString("agr_harvest")));
				
				hshAgency.put("agr_othermisc", Helper.correctNull(rs.getString("agr_othermisc")));	//41
				hshAgency.put("agr_totcultivationcost", Helper.correctNull(rs.getString("agr_totcultivationcost")));
				hshAgency.put("agr_production", Helper.correctNull(rs.getString("agr_production")));
				hshAgency.put("agr_productionvaluepertone", Helper.correctNull(rs.getString("agr_productionvaluepertone")));
				hshAgency.put("agr_valofproduction", Helper.correctNull(rs.getString("agr_valofproduction")));
				hshAgency.put("agr_surplus", Helper.correctNull(rs.getString("agr_surplus")));
				hshAgency.put("agr_deprequip", Helper.correctNull(rs.getString("agr_deprequip")));
				hshAgency.put("agr_workingcap", Helper.correctNull(rs.getString("agr_workingcap")));
				hshAgency.put("agr_netsurplus", Helper.correctNull(rs.getString("agr_netsurplus")));
				hshAgency.put("agr_netsurpdepr", Helper.correctNull(rs.getString("agr_netsurpdepr")));	
				
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getFisheriesDetailsByAppno of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getFisheriesDetailsByAppno === AgrLandHoldingsBO"+e.toString());
			
		}
		return hshAgency;
	}
	
 public HashMap getDataLiveStockByAppno(String strAppNo) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		String strQuery = "";
		String strbatchpurchased="";
		try 
		{			
			
			
			strQuery = SQLParser.getSqlQuery("agrsel_livestock^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
		
			while (rs.next()) 
			{
				arrData = new ArrayList();
				arrData.add(FwHelper.correctNull(rs.getString("agr_appno")));
				arrData.add(FwHelper.correctNull(rs.getString("agr_livestockslno")));
				arrData.add(FwHelper.correctNull(rs.getString("agr_detlivestock")));
				if(FwHelper.correctNull(rs.getString("agr_present_breed")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_present_breed")));
				if(FwHelper.correctNull(rs.getString("agr_present_age")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_present_age")));
				if(FwHelper.correctNull(rs.getString("agr_present_no")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_present_no")));
				if(FwHelper.correctNull(rs.getString("agr_present_value")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_present_value")));
				if(FwHelper.correctNull(rs.getString("agr_proposed_breed")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_proposed_breed")));
				if(FwHelper.correctNull(rs.getString("agr_proposed_age")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_proposed_age")));
				if(FwHelper.correctNull(rs.getString("agr_proposed_no")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_proposed_no")));
				if(FwHelper.correctNull(rs.getString("agr_proposed_value")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_proposed_value")));
				arrRow.add(arrData);
			}
			
			hshRecord.put("arrlivestock",arrRow);
			arrRow = new ArrayList();
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
		
			while (rs.next()) 
			{	
				arrData = new ArrayList();
				arrData.add(FwHelper.correctNull(rs.getString("agr_milchcattle")));
				if(FwHelper.correctNull(rs.getString("agr_avg_milk")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_avg_milk")));
				if(FwHelper.correctNull(rs.getString("agr_noanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_noanimals")));
				if(FwHelper.correctNull(rs.getString("agr_costanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_costanimals")));
				if(FwHelper.correctNull(rs.getString("agr_totalcost")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_totalcost")));
				arrData.add(FwHelper.correctNull(rs.getString("agr_batch")));
				
				strbatchpurchased= FwHelper.correctNull(rs.getString("agr_batch_purchased"));
				
				arrRow.add(arrData);
			}
			
			hshRecord.put("batchpurchased",strbatchpurchased);
			hshRecord.put("arrstockdetails", arrRow);
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("strappno", strAppNo);		
		}
		catch (Exception e) 
		{	log.error(e);
			throw new EJBException("Error in getDataLiveStock of agrcropsBean :: "+e.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null)
				{
					rs.close();
				}
			} 
			catch (Exception cf)
			{	log.error(cf);
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public  HashMap getLDdataByAppno(String strAppNo) 
	{		
		String strQuery="";		
		ResultSet rs = null;
		HashMap hshResult = new HashMap();	
		try
		{
			
			strQuery = SQLParser.getSqlQuery("getLDdata^"+strAppNo);			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String txt_lactrationdays= FwHelper.correctNull((String)rs.getString("lactationdays"));
				if(txt_lactrationdays.equalsIgnoreCase(""))
				{
					txt_lactrationdays="360";	//changed by saravanan from 280 - 360
				}
				else
				{
					hshResult.put("txt_lactrationdays", FwHelper.correctNull(rs.getString("lactationdays")));
				}
				String txt_drydays= FwHelper.correctNull((String)rs.getString("drydays"));
				if(txt_drydays.equalsIgnoreCase(""))
				{
					txt_drydays="60";	
				}
				else
				{
					hshResult.put("txt_drydays", FwHelper.correctNull(rs.getString("drydays")));
				}
				hshResult.put("txt_months", FwHelper.correctNull(rs.getString("months")));
			}
			if(rs != null){
				rs.close();
			}	
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
		
			if (rs.next()) 
			{	
				hshResult.put("agr_batch_purchased", FwHelper.correctNull((String)rs.getString("agr_batch_purchased")));
			}
			if(rs!=null){
				rs.close();
			}
			
			return hshResult;
		}
		catch(Exception ce)
		{	log.error(ce);
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
			{	log.error(cf);
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}
	public  HashMap getdiaryfinDataByAppno(String strAppNo) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		long totnoofanimal=0;
		long totnoofanimals=0;
		
		
		try
		{
		
			strQuery = SQLParser.getSqlQuery("agrdiaryfindatasel^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("Bet_Batch", FwHelper.correctNull(rs.getString("Bet_Batch")));
				hshRecord.put("milkprice", FwHelper.correctNull(rs.getString("milkprice")));
				hshRecord.put("sel_gober", FwHelper.correctNull(rs.getString("sel_gober")));
				hshRecord.put("incomgober", FwHelper.correctNull(rs.getString("incomgober")));
				hshRecord.put("vetaid", FwHelper.correctNull(rs.getString("vetaid")));
				hshRecord.put("elecexp", FwHelper.correctNull(rs.getString("elecexp")));
				hshRecord.put("sel_calves", FwHelper.correctNull(rs.getString("sel_calves")));
				hshRecord.put("inccalves", FwHelper.correctNull(rs.getString("inccalves")));
				hshRecord.put("greenfodder", FwHelper.correctNull(rs.getString("greenfodder")));
				hshRecord.put("costgreen", FwHelper.correctNull(rs.getString("costgreen")));
				hshRecord.put("expgreen", FwHelper.correctNull(rs.getString("expgreen")));
				hshRecord.put("dryfodder", FwHelper.correctNull(rs.getString("dryfodder")));
				hshRecord.put("costdry", FwHelper.correctNull(rs.getString("costdry")));
				hshRecord.put("expdry", FwHelper.correctNull(rs.getString("expdry")));
				hshRecord.put("concenfeed", FwHelper.correctNull(rs.getString("concenfeed")));
				hshRecord.put("costconcen", FwHelper.correctNull(rs.getString("costconcen")));
				hshRecord.put("expconcen", FwHelper.correctNull(rs.getString("expconcen")));
				hshRecord.put("totcostlact", FwHelper.correctNull(rs.getString("totcostlact")));
				hshRecord.put("dgreenfodder", FwHelper.correctNull(rs.getString("dgreenfodder")));
				hshRecord.put("dcostgreen", FwHelper.correctNull(rs.getString("dcostgreen")));
				hshRecord.put("dexpgreen", FwHelper.correctNull(rs.getString("dexpgreen")));
				hshRecord.put("ddryfodder", FwHelper.correctNull(rs.getString("ddryfodder")));
				hshRecord.put("dcostdry", FwHelper.correctNull(rs.getString("dcostdry")));
				hshRecord.put("dexpdry", FwHelper.correctNull(rs.getString("dexpdry")));
				hshRecord.put("dconcenfeed", FwHelper.correctNull(rs.getString("dconcenfeed")));
				hshRecord.put("dcostconcen", FwHelper.correctNull(rs.getString("dcostconcen")));
				hshRecord.put("dexpconcen", FwHelper.correctNull(rs.getString("dexpconcen")));
				hshRecord.put("totcostdry", FwHelper.correctNull(rs.getString("totcostdry")));
				hshRecord.put("nooflabour", FwHelper.correctNull(rs.getString("nooflabour")));
				hshRecord.put("salmonth", FwHelper.correctNull(rs.getString("salmonth")));
				hshRecord.put("totexplab", FwHelper.correctNull(rs.getString("totexplab")));
				hshRecord.put("constshed", FwHelper.correctNull(rs.getString("constshed")));
				hshRecord.put("constsqrcost", FwHelper.correctNull(rs.getString("constsqrcost")));
				hshRecord.put("totcostconst", FwHelper.correctNull(rs.getString("totcostconst")));
				hshRecord.put("equip1", FwHelper.correctNull(rs.getString("equip1")));
				hshRecord.put("equip1unit", FwHelper.correctNull(rs.getString("equip1unit")));
				hshRecord.put("equip1cost", FwHelper.correctNull(rs.getString("equip1cost")));
				hshRecord.put("equip1totcost", FwHelper.correctNull(rs.getString("equip1totcost")));
				hshRecord.put("equip2", FwHelper.correctNull(rs.getString("equip2")));
				hshRecord.put("equip2unit", FwHelper.correctNull(rs.getString("equip2unit")));
				hshRecord.put("equip2cost", FwHelper.correctNull(rs.getString("equip2cost")));
				hshRecord.put("equip2totcost", FwHelper.correctNull(rs.getString("equip2totcost")));
				hshRecord.put("equip3", FwHelper.correctNull(rs.getString("equip3")));
				hshRecord.put("equip3unit", FwHelper.correctNull(rs.getString("equip3unit")));
				hshRecord.put("equip3cost", FwHelper.correctNull(rs.getString("equip3cost")));
				hshRecord.put("equip3totcost", FwHelper.correctNull(rs.getString("equip3totcost")));
				hshRecord.put("equip4", FwHelper.correctNull(rs.getString("equip4")));
				hshRecord.put("equip4unit", FwHelper.correctNull(rs.getString("equip4unit")));
				hshRecord.put("equip4cost", FwHelper.correctNull(rs.getString("equip4cost")));
				hshRecord.put("equip4totcost", FwHelper.correctNull(rs.getString("equip4totcost")));
				hshRecord.put("totequipcost", FwHelper.correctNull(rs.getString("totequipcost")));
				hshRecord.put("inspremium", FwHelper.correctNull(rs.getString("inspremium")));
				hshRecord.put("transcost", FwHelper.correctNull(rs.getString("transcost")));
				hshRecord.put("otherexp", FwHelper.correctNull(rs.getString("otherexp")));
				hshRecord.put("tototherexp", FwHelper.correctNull(rs.getString("tototherexp")));
				hshRecord.put("sel_workcapital", FwHelper.correctNull(rs.getString("sel_workcapital")));
				hshRecord.put("maintcost", FwHelper.correctNull(rs.getString("maintcost")));
				hshRecord.put("feed", FwHelper.correctNull(rs.getString("feed")));
				hshRecord.put("otherincome", FwHelper.correctNull(rs.getString("otherincome")));
				hshRecord.put("txt_value", FwHelper.correctNull(rs.getString("value_animal")));
			}
			if(rs!=null){
				rs.close();					
			}
			
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arrRow = new ArrayList();
			while (rs.next()) 
			{
				ArrayList arrData = new ArrayList();
				arrData.add(FwHelper.correctNull(rs.getString("agr_milchcattle")));
				if(FwHelper.correctNull(rs.getString("agr_avg_milk")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_avg_milk")));
				if(FwHelper.correctNull(rs.getString("agr_noanimals")).equalsIgnoreCase("0"))
				{
					arrData.add("");
					totnoofanimal=totnoofanimal+0;
				}
				else
				{
					arrData.add(FwHelper.correctNull(rs.getString("agr_noanimals")));
					totnoofanimal=totnoofanimal+Integer.parseInt(FwHelper.correctDouble((String)rs.getString("agr_noanimals")));
				}
				if(FwHelper.correctNull(rs.getString("agr_costanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_costanimals")));
				if(FwHelper.correctNull(rs.getString("agr_totalcost")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(FwHelper.correctNull(rs.getString("agr_totalcost")));
				arrData.add(FwHelper.correctNull(rs.getString("agr_batch")));
				arrRow.add(arrData);
			}
			if(rs!=null){
				rs.close();					
			}
			hshRecord.put("totnoofanimals",Integer.toString((int)totnoofanimals));
			hshRecord.put("arrstockdetails", arrRow);
//================================== Find out the I Batch no of Animal in Live Stock ==============================
			
			strQuery = SQLParser.getSqlQuery("agr_livestockIbatnoanimal^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
		
			if(rs.next()) 
			{
				hshRecord.put("totnoofIBatanimals", FwHelper.correctNull((String)rs.getString("agr_noanimals")));
			}
			if(rs!=null){
				rs.close();					
			}

				
		}
		catch(Exception ce)
		{	log.error(ce);
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
			{	log.error(cf);
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}	
	public  HashMap getCPLDataByAppno(String strAppNo,String strSchemeType,String strSchemeFacSno) 
	{		
		String strQuery="";		
		ResultSet rs = null;
		HashMap hshResult = new HashMap();	
		try
		{
			
			strQuery = SQLParser.getSqlQuery("agrcaptldetails_assessment_select^"+strAppNo+"^"+strSchemeType+"^"+strSchemeFacSno);			
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshResult.put("capl_marketvalue", FwHelper.correctNull(rs.getString("capl_marketvalue")));
				hshResult.put("capl_units", FwHelper.correctNull(rs.getString("capl_units")));
				hshResult.put("capl_marketrate", FwHelper.correctNull(rs.getString("capl_marketrate")));
				hshResult.put("capl_loanamt", FwHelper.correctNull(rs.getString("capl_loanamt")));
			}
			if(rs != null){rs.close();}
			return hshResult;
		}
		catch(Exception ce)
		{	log.error(ce);
			throw new EJBException("Error in getCPLDataByAppno "+ce.toString());
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
			{	log.error(cf);
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}

	public HashMap getHortiCostOfDevelopmentByAppno(String strAppNo,String strPlantSno,String schemetypel,String strfacsno) throws Exception
	{
	String strQuery=null;
	ResultSet rs=null;
	HashMap hshResult = new HashMap();
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol= new ArrayList();
	String strYearStarting = "",strFirstValue = "",strYearsUpto="",strSecondAmt="";
	try
	{
		if(strPlantSno.equalsIgnoreCase(""))
			strPlantSno=" ";
		strQuery = SQLParser.getSqlQuery("sel_estimatecostvalue^"+strAppNo+"^"+schemetypel+"^"+strfacsno+"^"+strPlantSno);
		ResultSet rs1 = DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{	 
			strFirstValue = Helper.correctNull((String)rs1.getString("AGR_HORTI_MAXPLANT"));
			strYearStarting = Helper.correctNull((String)rs1.getString("AGR_HORTI_GROWPERIOD"));
		}
		else
		{
			strFirstValue = "0";
			strYearStarting ="0";
		}
		if(rs1!=null){rs1.close();}
		
		strQuery = SQLParser.getSqlQuery("sel_secondunitcost^"+strAppNo+"^"+schemetypel+"^"+strfacsno+"^"+strPlantSno);
		rs1 = DBUtils.executeQuery(strQuery);
		if(rs1.next())
		{	 
			strYearsUpto = Helper.correctNull((String)rs1.getString("ACT_YEARS"));
			strSecondAmt = Helper.correctNull((String)rs1.getString("ACT_AMT2"));
		}
		else
		{
			strYearsUpto = "1";
			strSecondAmt ="0";
		}
		if(!strPlantSno.equalsIgnoreCase(""))
		{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			strQuery = SQLParser.getSqlQuery("agr_horticostofdevelopment_select^"+strAppNo+"^"+strPlantSno+"^"+schemetypel+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				for(int i=1;i<=15;i++)
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("agr_year"+i)));//0
					arrRow.add(arrCol);
				}
				/*arrCol.add(Helper.correctNull(rs.getString("agr_year2")));//1
				arrCol.add(Helper.correctNull(rs.getString("agr_year3")));//2
				arrCol.add(Helper.correctNull(rs.getString("agr_year4")));//3
				arrCol.add(Helper.correctNull(rs.getString("agr_year5")));//4
				arrCol.add(Helper.correctNull(rs.getString("agr_year6")));//5
				arrCol.add(Helper.correctNull(rs.getString("agr_year7")));//6
				arrCol.add(Helper.correctNull(rs.getString("agr_year8")));//7
				arrCol.add(Helper.correctNull(rs.getString("agr_year9")));//8
				arrCol.add(Helper.correctNull(rs.getString("agr_year10")));//9
				arrCol.add(Helper.correctNull(rs.getString("agr_year11")));//10
				arrCol.add(Helper.correctNull(rs.getString("agr_year12")));//11
				arrCol.add(Helper.correctNull(rs.getString("agr_year13")));//12
				arrCol.add(Helper.correctNull(rs.getString("agr_year14")));//13
				arrCol.add(Helper.correctNull(rs.getString("agr_year15")));//14
			    arrRow.add(arrCol);*/
			}
			int total = Integer.parseInt(strYearStarting)+Integer.parseInt(strYearsUpto)-1;
			hshResult.put("arrRow", arrRow);
			hshResult.put("PlantName", strPlantSno);
			hshResult.put("strYearStarting", strYearStarting);
			hshResult.put("strYearsUpto", strYearsUpto);
			hshResult.put("total", String.valueOf(total));
		}		
	}
	catch(Exception e)
	{
		LogWriter.log("Error in getHortiCostOfDevelopmentByAppno of AgrlandholdingBO" +e.getMessage());
		if(rs!=null){rs.close();}
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
			log.error("Error in getHortiCostOfDevelopmentByAppno of AgrlandholdingBO"+cf.getMessage());
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
		return hshResult;
	}

	
	
	public ArrayList getHortiDetailsByAppNo(String strAppNo,String schemetype,String strfacsno)  throws Exception
	{
		String strQuery=null;
		ResultSet rs1=null;
		ArrayList arrRow = null;
		ArrayList arrCol= new ArrayList();
		strQuery = SQLParser.getSqlQuery("agr_horti_plantdetail_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
		rs1 = DBUtils.executeQuery(strQuery);
		try{
			arrRow=new ArrayList();	
			while(rs1.next())
			{	 
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_appno")));//0
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_id")));//1
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_Plantname")));//2
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_MaxPlant")));//3
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_Spacing")));//4
				
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_cost")));//5
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_GrowPeriod")));//6
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_startingyield")));//7
				arrCol.add(Helper.correctNull(rs1.getString("agr_horti_plantvariety")));//8 plantvariety
				arrCol.add(Helper.correctNull(rs1.getString("AGR_HORTI_SALEPRICE")));//9 plantmaterial
				arrCol.add(Helper.correctDouble(rs1.getString("AGR_HORTI_TOTALACRE")));//10 Selling Cost
				arrCol.add(Helper.correctDouble(rs1.getString("AGR_HORTI_INCPERACRE")));//11 Total income
				arrCol.add(Helper.correctNull(rs1.getString("AGR_HORTI_YIELDUNIT")));//12 yield unit
				arrCol.add(Helper.correctNull(rs1.getString("AGR_PLANT_ACTIVITYSNO")));//13 Scheme Sno

				
				arrRow.add(arrCol);
			}
			if(rs1!=null){rs1.close();}
		}catch(Exception e)
		{
			if(rs1!=null){rs1.close();}
			LogWriter.log("Error in getHortiDetailsByAppNo of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getHortiDetailsByAppNo === AgrLandHoldingsBO"+e.toString());
			
		
		}
		
		return arrRow;
	}
	
	public HashMap getEstimatedCostData(String strAppNo,String schemetype,String strfacsno,String strPlant)  throws Exception
	{
		String strQuery=null;
		HashMap hshValues = new HashMap();
		ResultSet rs1=null;
		ArrayList arrRow =  new ArrayList();
		ArrayList arrCol= new ArrayList();
		String strYearStarting = "",strFirstValue = "",strYearsUpto="",strSecondAmt="";
		int i=0;
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_estimatecostvalue^"+strAppNo+"^"+schemetype+"^"+strfacsno+"^"+strPlant);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{	 
				strFirstValue = Helper.correctNull((String)rs1.getString("AGR_HORTI_MAXPLANT"));
				strYearStarting = Helper.correctNull((String)rs1.getString("AGR_HORTI_STARTINGYIELD"));
			}
			else
			{
				strFirstValue = "0";
				strYearStarting ="0";
			}
			if(rs1!=null){rs1.close();}
			
			strQuery = SQLParser.getSqlQuery("sel_secondunitcost^"+strAppNo+"^"+schemetype+"^"+strfacsno+"^"+strPlant);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{	 
				strYearsUpto = Helper.correctNull((String)rs1.getString("ACT_YEARS"));
				strSecondAmt = Helper.correctNull((String)rs1.getString("ACT_AMT2"));
			}
			else
			{
				strYearsUpto = "1";
				strSecondAmt ="0";
			}
			if(rs1!=null){rs1.close();}
			for(i=1;i<Integer.parseInt(strYearStarting);i++)
			{
				arrCol= new ArrayList();
				arrCol.add("0.00");
				arrRow.add(arrCol);
				//hshValues.put("year"+i, "0.00");
			}
			
			arrCol= new ArrayList();
			arrCol.add(strFirstValue);
			arrRow.add(arrCol);
			//hshValues.put("year"+strYearStarting, strFirstValue);
			
			for(i=Integer.parseInt(strYearStarting)+1;i<Integer.parseInt(strYearStarting)+Integer.parseInt(strYearsUpto);i++)
			{
				arrCol= new ArrayList();
				arrCol.add(strSecondAmt);
				arrRow.add(arrCol);
				//hshValues.put("year"+i, strSecondAmt);
			}
			for(i=Integer.parseInt(strYearStarting)+Integer.parseInt(strYearsUpto);i<=15;i++)
			{
				arrCol= new ArrayList();
				arrCol.add("0.00");
				arrRow.add(arrCol);
				//hshValues.put("year"+i, "0.00");
			}
			int total = Integer.parseInt(strYearStarting)+Integer.parseInt(strYearsUpto)-1;
			hshValues.put("arrRow", arrRow);
			hshValues.put("PlantName", strPlant);
			hshValues.put("strYearStarting", strYearStarting);
			hshValues.put("strYearsUpto", strYearsUpto);
			hshValues.put("total", String.valueOf(total));
		}
		catch(Exception e)
		{
			if(rs1!=null){rs1.close();}
			LogWriter.log("Error in getEstimatedCostData of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getEstimatedCostData === AgrLandHoldingsBO"+e.toString());
		}
		return hshValues;
	}
	
	public ArrayList getHortiProjectedIncomeByAppno(String strAppNo,String strPlantName,String schemetype,String strfacsno) throws Exception
	{
	String strQuery=null;
	ResultSet rs=null;
	ArrayList arrValues = null;
	ArrayList arrData= new ArrayList();
	if(rs!=null)
	{
		rs.close();
		rs=null;
	}
	strQuery = SQLParser.getSqlQuery("agr_hortiprojectedincome_select^"+strAppNo+"^"+strPlantName+"^"+schemetype+"^"+strfacsno);
	rs = DBUtils.executeQuery(strQuery);
	try{
			while(rs.next())
			{
				arrValues=new ArrayList();			
				arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
				arrValues.add(Helper.correctNull(rs.getString("agr_plant")));	//1
				arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//2
				arrValues.add(Helper.correctNull(rs.getString("agr_year")));//3
				arrValues.add(Helper.correctNull(rs.getString("agr_yield")));//4
				arrValues.add(Helper.correctNull(rs.getString("agr_grossinc")));//5
				arrValues.add(Helper.correctNull(rs.getString("agr_maintenance")));//6
				arrValues.add(Helper.correctNull(rs.getString("agr_netinc")));//7
			    arrData.add(arrValues);	
			}
	}
	catch(Exception e)
	{
		LogWriter.log("Error in getHortiProjectedIncomeByAppno of AgrlandholdingBO" +e.getMessage());
		if(rs!=null){rs.close();}
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
			log.error("Error in getHortiProjectedIncomeByAppno of AgrlandholdingBO"+cf.getMessage());
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
		return arrData;
	}
	
	//Method for Land Purchase product
	public HashMap getLandDetailsByAppno(String strAppNo,String schemetype) throws Exception
	{
		HashMap hshLandDet=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_landdetails_select^"+strAppNo+"^"+schemetype);
			while(rs.next())
			{
				hshLandDet.put("appnumber", Helper.correctNull(rs.getString("agr_appno")));	//1
				hshLandDet.put("line1", Helper.correctNull(rs.getString("agr_line1")));
				hshLandDet.put("line2", Helper.correctNull(rs.getString("agr_line2")));
				hshLandDet.put("city", Helper.correctNull(rs.getString("agr_city")));
				hshLandDet.put("district", Helper.correctNull(rs.getString("agr_district")));	//5
				hshLandDet.put("state", Helper.correctNull(rs.getString("agr_state")));
				hshLandDet.put("purchaseval", Helper.correctNull(rs.getString("agr_purchaseval")));
				hshLandDet.put("ec", Helper.correctNull(rs.getString("agr_ec")));
				hshLandDet.put("withinvilage", Helper.correctNull(rs.getString("agr_withinvilage")));
				hshLandDet.put("noofkm", Helper.correctNull(rs.getString("agr_noofkm")));	//10
				hshLandDet.put("area", Helper.correctNull(rs.getString("agr_area")));
				hshLandDet.put("valdoneby", Helper.correctNull(rs.getString("agr_valdoneby")));
				hshLandDet.put("valamt", Helper.correctNull(rs.getString("agr_valamt")));
				hshLandDet.put("valdate", Helper.correctNull(rs.getString("agr_valdate")));
				hshLandDet.put("regdate", Helper.correctNull(rs.getString("agr_regdate")));	//15
				hshLandDet.put("legal", Helper.correctNull(rs.getString("agr_legal")));
				hshLandDet.put("agr_saledeedval", Helper.correctNull(rs.getString("agr_saledeedval")));
				hshLandDet.put("agr_envisagedval", Helper.correctNull(rs.getString("agr_envisagedval")));
				hshLandDet.put("agr_purval", Helper.correctNull(rs.getString("agr_purval")));
				//cost of Project and Means of Finance
				//hshLandDet.put("agr_landdetails", Helper.correctNull(rs.getString("agr_landdetails")));
				hshLandDet.put("agr_stampdutycost", Helper.correctNull(rs.getString("agr_stampdutycost")));
				hshLandDet.put("agr_regcharges", Helper.correctNull(rs.getString("agr_regcharges")));
				hshLandDet.put("agr_bankloan", Helper.correctNull(rs.getString("agr_bankloan")));
				hshLandDet.put("agr_margin", Helper.correctNull(rs.getString("agr_margin")));
				hshLandDet.put("agr_others", Helper.correctNull(rs.getString("agr_others")));
				hshLandDet.put("agr_surveyno", Helper.correctNull(rs.getString("agr_surveyno")));
				hshLandDet.put("agr_wardno", Helper.correctNull(rs.getString("AGR_WARDNO")));
				hshLandDet.put("agr_mandal", Helper.correctNull(rs.getString("AGR_MANDAL")));
				hshLandDet.put("agr_panchayat", Helper.correctNull(rs.getString("AGR_PANCHAYAT")));
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getLandDetailsByAppno of AgrLandHoldingsBO::" +e.getMessage());
			throw new EJBException("Error in getLandDetailsByAppno === AgrLandHoldingsBO"+e.toString());
		}
		return hshLandDet;
	}
	public ArrayList getOnFarmDevelopmentByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		HashMap hshRecord=new HashMap();
		HashMap hshlanddevelop=new HashMap();
		
	String strQuery=null,strlanddevelopslope=null;
	ResultSet rs=null;
	ArrayList arrValues = null;
	ArrayList arrData= new ArrayList();
	//arrRowland =null;
	try{
	hshRecord.put("hshAssessmentParam", new AgrLandHoldingsBO().getLandDevelopmentAssessmentParamByAppno(strAppNo,schemetype,strFacSNo));
	hshlanddevelop=(HashMap)hshRecord.get("hshAssessmentParam");
	
	strlanddevelopslope=Helper.correctNull((String)hshlanddevelop.get("agr_landdevelop_slope"));
	if(rs!=null)
	{
		rs.close();
		rs=null;
	}
	if(strlanddevelopslope!=null)
	{
	strQuery = SQLParser.getSqlQuery("agr_onfarmdevelopment_select^"+strAppNo+"^"+strlanddevelopslope+"^"+strFacSNo);
	rs = DBUtils.executeQuery(strQuery);
	
			while(rs.next())
			{
				arrValues=new ArrayList();
				arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
				arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//1
				arrValues.add(Helper.correctNull(rs.getString("agr_slope1")));//2
				arrValues.add(Helper.correctNull(rs.getString("agr_landdevelopslope")));//3
				//arrValues.add(Helper.correctNull(rs.getString("agr_slope3")));//4
				
			    arrData.add(arrValues);	
			}
	}
	}
	catch(Exception e)
	{
		LogWriter.log("Error in getOnFarmDevelopmentByAppno of AgrlandholdingBO" +e.getMessage());
		if(rs!=null){rs.close();}
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
			log.error("Error in getOnFarmDevelopmentByAppno of AgrlandholdingBO"+cf.getMessage());
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
		return arrData;
	}
	/**
	 * Method to get Horticulture Financial programme details of first 7 rows
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getFinancialProgByAppNo(String strAppNo,String schemetype,String strfacsno) throws Exception
	{
		String strQuery=null;
		ResultSet rs=null;
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
	
		if(rs!=null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("agr_hortifinancialprogramme_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
		
		rs = DBUtils.executeQuery(strQuery);
		try{
				
				while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
					arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//1
					arrValues.add(Helper.correctNull(rs.getString("agr_unit")));	//2
					arrValues.add(Helper.correctNull(rs.getString("agr_unitcost")));//3
					arrValues.add(Helper.correctNull(rs.getString("agr_totalcost")));//4
					arrValues.add(Helper.correctNull(rs.getString("agr_margin")));//6
					arrValues.add(Helper.correctNull(rs.getString("agr_bankloan")));//5					
				    arrData.add(arrValues);	
				}
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getFinancialProgByAppNo of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getFinancialProgByAppNo of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return arrData;
	}
	/**
	 * Method to get Horticulture Financial programme details after year1
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getFinancialProg2ByAppNo(String strAppNo,String schemetype,String strfacsno) throws Exception
	{
		String strQuery=null;
		ResultSet rs=null;
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
	
		if(rs!=null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("agr_hortiyearcultivationcost_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
		
		rs = DBUtils.executeQuery(strQuery);
		try{
			
				while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_appno")));	//0
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_sno")));	//1
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_unit")));	//2
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_totalcost")));//3
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_margin")));//4
					arrValues.add(Helper.correctNull(rs.getString("agr_horti_bankloan")));//5
					
				    arrData.add(arrValues);	
				}
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getFinancialProgByAppNo of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getFinancialProgByAppNo of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
			return arrData;
	}
	/**
	 * Method to get Horticulture Financial programme - Installation of Drip irrigation details
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getFinancialDripByAppNo(String strAppNo,String schemetype,String strfacsno) throws Exception
	{
		String strQuery=null;
		ResultSet rs=null;
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
	
		if(rs!=null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("agr_hortifindripirrigation_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
		
		rs = DBUtils.executeQuery(strQuery);
		try{
				
				while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
					arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//1
					arrValues.add(Helper.correctNull(rs.getString("agr_unit")));	//2
					arrValues.add(Helper.correctNull(rs.getString("agr_unitcost")));//3
					arrValues.add(Helper.correctNull(rs.getString("agr_totalcost")));//4
					arrValues.add(Helper.correctNull(rs.getString("agr_margin")));//6
					arrValues.add(Helper.correctNull(rs.getString("agr_bankloan")));//5					
				    arrData.add(arrValues);	
				}
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getFinancialDripByAppNo of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getFinancialDripByAppNo of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return arrData;
	}
	/**
	 * Method to get Horticulture Financial programme -Cost of cultivation part details
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getFinancialCostofCultivationByAppNo(String strAppNo,String schemetype,String strfacsno) throws Exception
	{
		String strQuery=null;
		ResultSet rs=null;
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
		try{
			
			
			
			
			strQuery = SQLParser.getSqlQuery("agr_horticostofcultivation_select^"+strAppNo+"^"+schemetype+"^"+strfacsno);
			rs = DBUtils.executeQuery(strQuery);
			
				while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
					arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//1
					arrValues.add(Helper.correctNull(rs.getString("agr_unit")));	//2
					arrValues.add(Helper.correctNull(rs.getString("agr_unitcost")));//3
					arrValues.add(Helper.correctNull(rs.getString("agr_totalcost")));//4					
					arrValues.add(Helper.correctNull(rs.getString("agr_margin")));//5
					arrValues.add(Helper.correctNull(rs.getString("agr_bankloan")));//6
				    arrData.add(arrValues);	
				}
		}
		catch(Exception e)
		{
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getFinancialCostofCultivationByAppNo of AgrlandholdingBO" +e.getMessage());
			throw new Exception("Error in getFinancialCostofCultivationByAppNo of AgrlandholdingBO" +e.getMessage());
			
		}
		finally
		{
			try
			{
				if(rs != null) rs.close();
			}
			catch(Exception cf)
			{
				log.error("Error in getFinancialCostofCultivationByAppNo of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return arrData;
	}
	
	/**
	 * Method to get Land development-sand casting page details
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getSandCastingByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		String strQuery=null;
		ResultSet rs=null;
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
		HashMap hshRecord=new HashMap();
		String strInches=null;
		try{
			if(rs!=null)
			{
				rs.close();
				rs=null;
			}
			
			rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
			if(rs.next())
			{
				strInches=Helper.correctNull(rs.getString("agr_landdevelop_inches"));
			}				
			if(strInches!=null)
			{
			strQuery = SQLParser.getSqlQuery("agr_sandcasting_select^"+strAppNo+"^"+strInches+"^"+schemetype+"^"+strFacSNo);
			rs = DBUtils.executeQuery(strQuery);
			
			
			while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull(rs.getString("agr_appno")));	//0
					arrValues.add(Helper.correctNull(rs.getString("agr_sno")));	//1
					arrValues.add(Helper.correctNull(rs.getString("agr_sixinches")));//2
					arrValues.add(Helper.correctNull(rs.getString("agr_inches")));
					
				    arrData.add(arrValues);	
		}
		}
			
			
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getSandCastingByAppno of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getSandCastingByAppno of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return arrData;
	}
	/**
	 * Method to get Land development-sand casting-particulars column details
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public HashMap getSandCastingParticularsByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		String strQuery=null;
		HashMap hshPariculars =  new HashMap();
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strInches=null;
		if(rs!=null)
		{
			rs.close();
			rs=null;
		}
		rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
		if(rs.next())
		{
			strInches=Helper.correctNull(rs.getString("agr_landdevelop_inches"));
		}
		
		if(rs!=null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("agr_sandcastingparticulars_select^"+strAppNo+"^"+strInches+"^"+schemetype+"^"+strFacSNo);
		rs = DBUtils.executeQuery(strQuery);
		try{
				while(rs.next())
				{
					hshPariculars.put("stocking", Helper.correctNull(rs.getString("agr_stocking")));
					hshPariculars.put("remaining", Helper.correctNull(rs.getString("agr_remaining")));
					hshPariculars.put("rateunit", Helper.correctNull(rs.getString("agr_rateunit")));
					hshPariculars.put("rateamt", Helper.correctNull(rs.getString("agr_rateamt")));
					
					hshPariculars.put("avgdepth", Helper.correctNull(rs.getString("agr_avgdepth")));
					hshPariculars.put("totqty", Helper.correctNull(rs.getString("agr_totqty")));
					hshPariculars.put("totcostperacre", Helper.correctNull(rs.getString("agr_totcostperacre")));
					hshPariculars.put("contingencies", Helper.correctNull(rs.getString("agr_contingencies")));
					hshPariculars.put("overalltot", Helper.correctNull(rs.getString("agr_overalltot")));
					//hshPariculars.put("agrparticulars_inches", Helper.correctNull(rs.getString("agrparticulars_inches")));
				}
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getSandCastingParticularsByAppno of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getSandCastingParticularsByAppno of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return hshPariculars;
	}
	public HashMap getLandDevelopmentAssessmentParamByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		HashMap hshRecord =  new HashMap();
		ResultSet rs=null;
		try{
			rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
			
			if(rs.next())
				{
					hshRecord.put("agr_landdevelop_slope", Helper.correctNull(rs.getString("agr_landdevelop_slope")));
					hshRecord.put("agr_landdevelop_inches", Helper.correctNull(rs.getString("agr_landdevelop_inches")));
					hshRecord.put("agr_landdevelop_soiltype", Helper.correctNull(rs.getString("agr_landdevelop_soiltype")));
					hshRecord.put("agr_landdevelop_justification", Helper.correctNull(rs.getString("agr_landdevelop_justification")));
					hshRecord.put("agr_landdeveloped", Helper.correctNull(rs.getString("agr_landdeveloped")));
					hshRecord.put("agr_noofhectare", Helper.correctNull(rs.getString("agr_noofhectare")));
					hshRecord.put("agr_maintenance", Helper.correctDouble(rs.getString("agr_maintenance")));
				}
		
			else
			{
				hshRecord.put("Hidpage","Hidpage"); 
			}
		}
		
		catch(Exception e)
		{
			LogWriter.log("Error in getLandDevelopmentAssessmentParamByAppno of AgrlandholdingBO" +e.getMessage());
			if(rs!=null){rs.close();}
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
				log.error("Error in getLandDevelopmentAssessmentParamByAppno of AgrlandholdingBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	
		return hshRecord;
	}
}
