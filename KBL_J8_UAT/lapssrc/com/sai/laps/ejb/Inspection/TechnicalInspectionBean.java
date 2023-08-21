package com.sai.laps.ejb.Inspection;

import java.sql.ResultSet;
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

@Stateless(name = "TechnicalInspectionBean", mappedName = "TechnicalInspectionHome")
@Remote (TechnicalInspectionRemote.class)
public class TechnicalInspectionBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(TechnicalInspectionBean.class);
	private static final long serialVersionUID = 1L;
	
	public void updateTechnicalpage1(HashMap hshValues)
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		String appno="";
		strAction = correctNull((String) hshValues.get("hidAction"));
		appno = correctNull((String) hshValues.get("appno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_TechPage1");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_TechPage1");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("pur1")));
				arrValues.add(correctNull((String)hshValues.get("pur2")));
				arrValues.add(correctNull((String)hshValues.get("insp_date")));
				arrValues.add(correctNull((String)hshValues.get("txt_rawmat")));
				arrValues.add(correctNull((String)hshValues.get("txt_water")));
				arrValues.add(correctNull((String)hshValues.get("txt_power")));
				arrValues.add(correctNull((String)hshValues.get("txt_fuel")));
				arrValues.add(correctNull((String)hshValues.get("txt_trans")));
				arrValues.add(correctNull((String)hshValues.get("txt_skill")));
				arrValues.add(correctNull((String)hshValues.get("txt_wage")));
				arrValues.add(correctNull((String)hshValues.get("txt_labour")));
				arrValues.add(correctNull((String)hshValues.get("txt_market")));
				arrValues.add(correctNull((String)hshValues.get("txt_workshop")));
				arrValues.add(correctNull((String)hshValues.get("txt_special")));
				arrValues.add(correctNull((String)hshValues.get("txt_bank")));
				arrValues.add(correctNull((String)hshValues.get("txt_eff")));
				//arrValues.add(ins_flag);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId","del_TechPage1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public 	HashMap getTechnicalpage1(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_Techpage1^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("PURPOSEOFREPORT1",correctNull(rs.getString("PURPOSEOFREPORT1")));
				hshResult.put("PURPOSEOFREPORT2",correctNull(rs.getString("PURPOSEOFREPORT2")));
				hshResult.put("DATEOFINSPECTION",correctNull(rs.getString("DATEOFINSPECTION")));
				hshResult.put("RAWMATERIAL",correctNull(rs.getString("RAWMATERIAL")));
				hshResult.put("WATERARRANGEMANTS",correctNull(rs.getString("WATERARRANGEMANTS")));
				hshResult.put("POWER",correctNull(rs.getString("POWER")));
				hshResult.put("FUEL",correctNull(rs.getString("FUEL")));
				hshResult.put("TRANSPORTATION",correctNull(rs.getString("TRANSPORTATION")));
				hshResult.put("MANPOWER",correctNull(rs.getString("MANPOWER")));
				hshResult.put("PREVALENTWAGERATES",correctNull(rs.getString("PREVALENTWAGERATES")));
				hshResult.put("LABOURRELATION",correctNull(rs.getString("LABOURRELATION")));
				hshResult.put("MARKETFORPRODUCTS",correctNull(rs.getString("MARKETFORPRODUCTS")));
				hshResult.put("WORKSHOPFACILITIES",correctNull(rs.getString("WORKSHOPFACILITIES")));
				hshResult.put("SPECIALFEATURES",correctNull(rs.getString("SPECIALFEATURES")));
				hshResult.put("BANKINGFACILITIES",correctNull(rs.getString("BANKINGFACILITIES")));
				hshResult.put("POLLUTION",correctNull(rs.getString("POLLUTION")));
			}
			hshResult.put("appno",appno);
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
		return hshResult;
	}

	public void updateTechnicalpage2(HashMap hshValues)
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		strAction = correctNull((String) hshValues.get("hidAction"));
		String appno = correctNull((String) hshValues.get("appno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_TechPage2");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_TechPage2");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_rent")));
				arrValues.add(correctNull((String)hshValues.get("txt_mort")));
				arrValues.add(correctNull((String)hshValues.get("txt_area")));
				arrValues.add(correctNull((String)hshValues.get("txt_devexp")));
				arrValues.add(correctNull((String)hshValues.get("txt_built")));
				arrValues.add(correctNull((String)hshValues.get("txt_struct")));
				arrValues.add(correctNull((String)hshValues.get("txt_adeq")));
				arrValues.add(correctNull((String)hshValues.get("txt_deeds")));
				arrValues.add(correctNull((String)hshValues.get("txt_godown")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}											
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId","del_TechPage2");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public 	HashMap getTechnicalpage2(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_Techpage2^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("land_rentedown",correctNull(rs.getString("land_rentedown")));
				hshResult.put("whethermortgaged",correctNull(rs.getString("whethermortgaged")));
				hshResult.put("totalarea",correctNull(rs.getString("totalarea")));
				hshResult.put("developmentcharges",correctNull(rs.getString("developmentcharges")));
				hshResult.put("builtuparea",correctNull(rs.getString("builtuparea")));
				hshResult.put("typesofstructures",correctNull(rs.getString("typesofstructures")));
				hshResult.put("adequencyofspace",correctNull(rs.getString("adequencyofspace")));
				hshResult.put("deedsandrecords",correctNull(rs.getString("deedsandrecords")));
				hshResult.put("godownfacilities",correctNull(rs.getString("godownfacilities")));
			}
			hshResult.put("appno",appno);
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
		return hshResult;
	}

	public void updateTechnicalpage3(HashMap hshValues)
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		strAction = correctNull((String) hshValues.get("hidAction"));
		String appno = correctNull((String) hshValues.get("appno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_TechPage3");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_TechPage3");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_particulars")));
				arrValues.add(correctNull((String)hshValues.get("txt_machine")));
				arrValues.add(correctNull((String)hshValues.get("txt_arrange")));
				arrValues.add(correctNull((String)hshValues.get("txt_imported")));
				arrValues.add(correctNull((String)hshValues.get("txt_comments1")));
				arrValues.add(correctNull((String)hshValues.get("txt_comments2")));
				arrValues.add(correctNull((String)hshValues.get("txt_avail")));
				arrValues.add(correctNull((String)hshValues.get("txt_layout")));
				arrValues.add(correctNull((String)hshValues.get("txt_hypothec")));
				arrValues.add(correctNull((String)hshValues.get("txt_products")));
				arrValues.add(correctNull((String)hshValues.get("txt_operations")));
				arrValues.add(correctNull((String)hshValues.get("txt_rates")));
				arrValues.add(correctNull((String)hshValues.get("txt_shifts")));
				arrValues.add(correctNull((String)hshValues.get("txt_monthwise")));
				arrValues.add(correctNull((String)hshValues.get("txt_yearwise")));
				arrValues.add(correctNull((String)hshValues.get("txt_achievement")));
				arrValues.add(correctNull((String)hshValues.get("txt_quality")));
				arrValues.add(correctNull((String)hshValues.get("txt_testing")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId","del_TechPage3");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public 	HashMap getTechnicalpage3(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_Techpage3^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("particulars",correctNull(rs.getString("particulars")));
				hshResult.put("conditionsofmachine",correctNull(rs.getString("conditionsofmachine")));
				hshResult.put("SATISFACTORYARRANGEMENTS",correctNull(rs.getString("SATISFACTORYARRANGEMENTS")));
				hshResult.put("IMPORTEDMACHINES",correctNull(rs.getString("IMPORTEDMACHINES")));
				hshResult.put("COMMENTSONBALANCING",correctNull(rs.getString("COMMENTSONBALANCING")));
				hshResult.put("COMMENTSONADEQUACY",correctNull(rs.getString("COMMENTSONADEQUACY")));
				hshResult.put("AVAILABILITY",correctNull(rs.getString("AVAILABILITY")));
				hshResult.put("COMMENTSONLAYOUT",correctNull(rs.getString("COMMENTSONLAYOUT")));
				hshResult.put("WHETHERHYPOTHECATED",correctNull(rs.getString("WHETHERHYPOTHECATED")));
				hshResult.put("PRODUCTS_PARTICULARS",correctNull(rs.getString("PRODUCTS_PARTICULARS")));
				hshResult.put("OPERATIONS_PROCESSES",correctNull(rs.getString("OPERATIONS_PROCESSES")));
				hshResult.put("RATESOFTHEPRODUCTION",correctNull(rs.getString("RATESOFTHEPRODUCTION")));
				hshResult.put("NUMBEROFSHIFTS",correctNull(rs.getString("NUMBEROFSHIFTS")));
				hshResult.put("QUANTITIESPRODUCED_MONTH",correctNull(rs.getString("QUANTITIESPRODUCED_MONTH")));
				hshResult.put("QUANTITIESPRODUCED_YEAR",correctNull(rs.getString("QUANTITIESPRODUCED_YEAR")));
				hshResult.put("COMMENTSONACHIEVEMENT",correctNull(rs.getString("COMMENTSONACHIEVEMENT")));
				hshResult.put("QUALITY",correctNull(rs.getString("QUALITY")));
				hshResult.put("TESTINGANDQUALITYCONTROL",correctNull(rs.getString("TESTINGANDQUALITYCONTROL")));
			}
			hshResult.put("appno",appno);
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
		return hshResult;
	}

	public void updateTechnicalpage4(HashMap hshValues)
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		strAction = correctNull((String) hshValues.get("hidAction"));
		String appno = correctNull((String) hshValues.get("appno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_TechPage4");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_TechPage4");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_rawmatavilable")));
				arrValues.add(correctNull((String)hshValues.get("txt_rawmatarrangements")));
				arrValues.add(correctNull((String)hshValues.get("txt_suppliers")));
				arrValues.add(correctNull((String)hshValues.get("txt_credit")));
				arrValues.add(correctNull((String)hshValues.get("txt_frequency")));
				arrValues.add(correctNull((String)hshValues.get("txt_imported")));
				arrValues.add(correctNull((String)hshValues.get("txt_importedlicense")));
				arrValues.add(correctNull((String)hshValues.get("txt_importlicensehand")));
				arrValues.add(correctNull((String)hshValues.get("txt_storage")));
				arrValues.add(correctNull((String)hshValues.get("txt_inspection")));
				arrValues.add(correctNull((String)hshValues.get("txt_insurance")));
				arrValues.add(correctNull((String)hshValues.get("txt_oldstock")));
				arrValues.add(correctNull((String)hshValues.get("txt_exportimport")));
				arrValues.add(correctNull((String)hshValues.get("txt_competitors")));
				arrValues.add(correctNull((String)hshValues.get("txt_substitutes")));
				arrValues.add(correctNull((String)hshValues.get("txt_demand")));
				arrValues.add(correctNull((String)hshValues.get("txt_publicity")));
				arrValues.add(correctNull((String)hshValues.get("txt_prevperfomance")));
				arrValues.add(correctNull((String)hshValues.get("txt_targets")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId","del_TechPage4");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public 	HashMap getTechnicalpage4(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_Techpage4^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("rawmaterial_availability",correctNull(rs.getString("rawmaterial_availability")));
				hshResult.put("rawmaterial_arrangements",correctNull(rs.getString("rawmaterial_arrangements")));
				hshResult.put("suppliers",correctNull(rs.getString("suppliers")));
				hshResult.put("creditavailable",correctNull(rs.getString("creditavailable")));
				hshResult.put("frquencyofpurchase",correctNull(rs.getString("frquencyofpurchase")));
				hshResult.put("imported_rawmaterial",correctNull(rs.getString("imported_rawmaterial")));
				hshResult.put("rawmaterial_license",correctNull(rs.getString("rawmaterial_license")));
				hshResult.put("valueof_importlicense",correctNull(rs.getString("valueof_importlicense")));
				hshResult.put("storage",correctNull(rs.getString("storage")));
				hshResult.put("inspection",correctNull(rs.getString("inspection")));
				hshResult.put("insurance_cover",correctNull(rs.getString("insurance_cover")));
				hshResult.put("oldstockaccumulation",correctNull(rs.getString("oldstockaccumulation")));
				hshResult.put("export_import",correctNull(rs.getString("export_import")));
				hshResult.put("competitors",correctNull(rs.getString("competitors")));
				hshResult.put("presenceofsubstitutes",correctNull(rs.getString("presenceofsubstitutes")));
				hshResult.put("present_futuredemand",correctNull(rs.getString("present_futuredemand")));
				hshResult.put("arrangementofpublicity",correctNull(rs.getString("arrangementofpublicity")));
				hshResult.put("previousperformance",correctNull(rs.getString("previousperformance")));
				hshResult.put("targets",correctNull(rs.getString("targets")));
			}
			hshResult.put("appno",appno);
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
		return hshResult;
	}
	
	public void updateTechnicalpage5(HashMap hshValues)
	{	
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction = null;		
		strAction = correctNull((String) hshValues.get("hidAction"));
		String appno = correctNull((String) hshValues.get("appno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_TechPage5");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_TechPage5");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_agency")));
				arrValues.add(correctNull((String)hshValues.get("txt_direct")));
				arrValues.add(correctNull((String)hshValues.get("txt_areaplaces")));
				arrValues.add(correctNull((String)hshValues.get("txt_govtorders")));
				arrValues.add(correctNull((String)hshValues.get("txt_profit")));
				arrValues.add(correctNull((String)hshValues.get("txt_mngmt")));
				arrValues.add(correctNull((String)hshValues.get("txt_partners")));
				arrValues.add(correctNull((String)hshValues.get("txt_executives")));
				arrValues.add(correctNull((String)hshValues.get("txt_conclusion")));
				arrValues.add(correctNull((String)hshValues.get("txt_techfeasibility")));
				arrValues.add(correctNull((String)hshValues.get("txt_ecoviability")));
				arrValues.add(correctNull((String)hshValues.get("txt_general")));
				arrValues.add(correctNull((String)hshValues.get("txt_name")));
				arrValues.add(correctNull((String)hshValues.get("txt_design")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				hshQuery.put("strQueryId","del_TechPage5");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public 	HashMap getTechnicalpage5(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_Techpage5^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("agency_salesman",correctNull(rs.getString("agency_salesman")));
				hshResult.put("wholesalers_retailer_consumer",correctNull(rs.getString("wholesalers_retailer_consumer")));
				hshResult.put("area_places_covered",correctNull(rs.getString("area_places_covered")));
				hshResult.put("government_orders",correctNull(rs.getString("government_orders")));
				hshResult.put("profitability",correctNull(rs.getString("profitability")));
				hshResult.put("directors",correctNull(rs.getString("directors")));
				hshResult.put("partners",correctNull(rs.getString("partners")));
				hshResult.put("important_executives",correctNull(rs.getString("important_executives")));
				hshResult.put("conclusion",correctNull(rs.getString("conclusion")));
				hshResult.put("technical_feasibility",correctNull(rs.getString("technical_feasibility")));
				hshResult.put("economic_viability",correctNull(rs.getString("economic_viability")));
				hshResult.put("general_comments",correctNull(rs.getString("general_comments")));
				hshResult.put("general_name",correctNull(rs.getString("general_name")));
				hshResult.put("general_designation",correctNull(rs.getString("general_designation")));
			}
			hshResult.put("appno",appno);
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
		return hshResult;
	}
	
	public 	HashMap printgetTechnicalpage(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String ins_flag = "";
		String strQuery1="",strQuery2="",strQuery3="",strQuery4="",strQuery5="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		String strInwardno = correctNull((String) hshValues.get("inwardno"));
		try
		{
			ins_flag="T";
			if (rs != null)rs.close();
			if (strInwardno.equalsIgnoreCase("")) {
				strQuery1 = SQLParser.getSqlQuery("selBranchCityName^"+ appno);
			} else {
				strQuery1 = SQLParser.getSqlQuery("selinwardreg^" + strInwardno);
			}
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				hshResult.put("orgname", correctNull(rs.getString("org_name")));
				hshResult.put("orgadd1", correctNull(rs.getString("org_add1")));
				hshResult.put("orgadd2", correctNull(rs.getString("org_add2")));
				hshResult.put("orgcity", correctNull(rs.getString("org_city")));
				hshResult.put("orgstate",
						correctNull(rs.getString("org_state")));
				hshResult.put("orgzip", correctNull(rs.getString("org_zip")));
			}
			if (rs != null)rs.close();
			strQuery1 = SQLParser.getSqlQuery("sel_Techpage1^"+appno+"^"+ins_flag);
			rs=DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{	
				hshResult.put("PURPOSEOFREPORT1",correctNull(rs.getString("PURPOSEOFREPORT1")));
				hshResult.put("PURPOSEOFREPORT2",correctNull(rs.getString("PURPOSEOFREPORT2")));
				hshResult.put("DATEOFINSPECTION",correctNull(rs.getString("DATEOFINSPECTION")));
				hshResult.put("RAWMATERIAL",correctNull(rs.getString("RAWMATERIAL")));
				hshResult.put("WATERARRANGEMANTS",correctNull(rs.getString("WATERARRANGEMANTS")));
				hshResult.put("POWER",correctNull(rs.getString("POWER")));
				hshResult.put("FUEL",correctNull(rs.getString("FUEL")));
				hshResult.put("TRANSPORTATION",correctNull(rs.getString("TRANSPORTATION")));
				hshResult.put("MANPOWER",correctNull(rs.getString("MANPOWER")));
				hshResult.put("PREVALENTWAGERATES",correctNull(rs.getString("PREVALENTWAGERATES")));
				hshResult.put("LABOURRELATION",correctNull(rs.getString("LABOURRELATION")));
				hshResult.put("MARKETFORPRODUCTS",correctNull(rs.getString("MARKETFORPRODUCTS")));
				hshResult.put("WORKSHOPFACILITIES",correctNull(rs.getString("WORKSHOPFACILITIES")));
				hshResult.put("SPECIALFEATURES",correctNull(rs.getString("SPECIALFEATURES")));
				hshResult.put("BANKINGFACILITIES",correctNull(rs.getString("BANKINGFACILITIES")));
				hshResult.put("POLLUTION",correctNull(rs.getString("POLLUTION")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery2 = SQLParser.getSqlQuery("sel_Techpage2^"+appno+"^"+ins_flag);
			rs=DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{	
				hshResult.put("land_rentedown",correctNull(rs.getString("land_rentedown")));
				hshResult.put("whethermortgaged",correctNull(rs.getString("whethermortgaged")));
				hshResult.put("totalarea",correctNull(rs.getString("totalarea")));
				hshResult.put("developmentcharges",correctNull(rs.getString("developmentcharges")));
				hshResult.put("builtuparea",correctNull(rs.getString("builtuparea")));
				hshResult.put("typesofstructures",correctNull(rs.getString("typesofstructures")));
				hshResult.put("adequencyofspace",correctNull(rs.getString("adequencyofspace")));
				hshResult.put("deedsandrecords",correctNull(rs.getString("deedsandrecords")));
				hshResult.put("godownfacilities",correctNull(rs.getString("godownfacilities")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery3 = SQLParser.getSqlQuery("sel_Techpage3^"+appno+"^"+ins_flag);
			rs=DBUtils.executeQuery(strQuery3);
			if(rs.next())
			{	
				hshResult.put("particulars",correctNull(rs.getString("particulars")));
				hshResult.put("conditionsofmachine",correctNull(rs.getString("conditionsofmachine")));
				hshResult.put("SATISFACTORYARRANGEMENTS",correctNull(rs.getString("SATISFACTORYARRANGEMENTS")));
				hshResult.put("IMPORTEDMACHINES",correctNull(rs.getString("IMPORTEDMACHINES")));
				hshResult.put("COMMENTSONBALANCING",correctNull(rs.getString("COMMENTSONBALANCING")));
				hshResult.put("COMMENTSONADEQUACY",correctNull(rs.getString("COMMENTSONADEQUACY")));
				hshResult.put("AVAILABILITY",correctNull(rs.getString("AVAILABILITY")));
				hshResult.put("COMMENTSONLAYOUT",correctNull(rs.getString("COMMENTSONLAYOUT")));
				hshResult.put("WHETHERHYPOTHECATED",correctNull(rs.getString("WHETHERHYPOTHECATED")));
				hshResult.put("PRODUCTS_PARTICULARS",correctNull(rs.getString("PRODUCTS_PARTICULARS")));
				hshResult.put("OPERATIONS_PROCESSES",correctNull(rs.getString("OPERATIONS_PROCESSES")));
				hshResult.put("RATESOFTHEPRODUCTION",correctNull(rs.getString("RATESOFTHEPRODUCTION")));
				hshResult.put("NUMBEROFSHIFTS",correctNull(rs.getString("NUMBEROFSHIFTS")));
				hshResult.put("QUANTITIESPRODUCED_MONTH",correctNull(rs.getString("QUANTITIESPRODUCED_MONTH")));
				hshResult.put("QUANTITIESPRODUCED_YEAR",correctNull(rs.getString("QUANTITIESPRODUCED_YEAR")));
				hshResult.put("COMMENTSONACHIEVEMENT",correctNull(rs.getString("COMMENTSONACHIEVEMENT")));
				hshResult.put("QUALITY",correctNull(rs.getString("QUALITY")));
				hshResult.put("TESTINGANDQUALITYCONTROL",correctNull(rs.getString("TESTINGANDQUALITYCONTROL")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery4 = SQLParser.getSqlQuery("sel_Techpage4^"+appno+"^"+ins_flag);
			rs=DBUtils.executeQuery(strQuery4);
			if(rs.next())
			{	
				hshResult.put("rawmaterial_availability",correctNull(rs.getString("rawmaterial_availability")));
				hshResult.put("rawmaterial_arrangements",correctNull(rs.getString("rawmaterial_arrangements")));
				hshResult.put("suppliers",correctNull(rs.getString("suppliers")));
				hshResult.put("creditavailable",correctNull(rs.getString("creditavailable")));
				hshResult.put("frquencyofpurchase",correctNull(rs.getString("frquencyofpurchase")));
				hshResult.put("imported_rawmaterial",correctNull(rs.getString("imported_rawmaterial")));
				hshResult.put("rawmaterial_license",correctNull(rs.getString("rawmaterial_license")));
				hshResult.put("valueof_importlicense",correctNull(rs.getString("valueof_importlicense")));
				hshResult.put("storage",correctNull(rs.getString("storage")));
				hshResult.put("inspection",correctNull(rs.getString("inspection")));
				hshResult.put("insurance_cover",correctNull(rs.getString("insurance_cover")));
				hshResult.put("oldstockaccumulation",correctNull(rs.getString("oldstockaccumulation")));
				hshResult.put("export_import",correctNull(rs.getString("export_import")));
				hshResult.put("competitors",correctNull(rs.getString("competitors")));
				hshResult.put("presenceofsubstitutes",correctNull(rs.getString("presenceofsubstitutes")));
				hshResult.put("present_futuredemand",correctNull(rs.getString("present_futuredemand")));
				hshResult.put("arrangementofpublicity",correctNull(rs.getString("arrangementofpublicity")));
				hshResult.put("previousperformance",correctNull(rs.getString("previousperformance")));
				hshResult.put("targets",correctNull(rs.getString("targets")));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery5 = SQLParser.getSqlQuery("sel_Techpage5^"+appno+"^"+ins_flag);
			rs=DBUtils.executeQuery(strQuery5);
			if(rs.next())
			{	
				hshResult.put("agency_salesman",correctNull(rs.getString("agency_salesman")));
				hshResult.put("wholesalers_retailer_consumer",correctNull(rs.getString("wholesalers_retailer_consumer")));
				hshResult.put("area_places_covered",correctNull(rs.getString("area_places_covered")));
				hshResult.put("government_orders",correctNull(rs.getString("government_orders")));
				hshResult.put("profitability",correctNull(rs.getString("profitability")));
				hshResult.put("directors",correctNull(rs.getString("directors")));
				hshResult.put("partners",correctNull(rs.getString("partners")));
				hshResult.put("important_executives",correctNull(rs.getString("important_executives")));
				hshResult.put("conclusion",correctNull(rs.getString("conclusion")));
				hshResult.put("technical_feasibility",correctNull(rs.getString("technical_feasibility")));
				hshResult.put("economic_viability",correctNull(rs.getString("economic_viability")));
				hshResult.put("general_comments",correctNull(rs.getString("general_comments")));
				hshResult.put("general_name",correctNull(rs.getString("general_name")));
				hshResult.put("general_designation",correctNull(rs.getString("general_designation")));
			}
			hshResult.put("appno",appno);
			hshResult.put("insflag",ins_flag);
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
		return hshResult;
	}		
	
	public  HashMap getPDCCharges(HashMap hshValues) 
	{	
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String recordflag="N";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strEmpType="";
		String strAppno="";
		String strPropType="";
		String strNature="";
		String strAccverify="";
		String strResidence="",strDuplicate="";
		String strhouseType="",strHouseStatus="";
		String strPropose="",strDescProp="";
		String strValRep="",strConsValue="";
		
		try
		{
			StringBuilder sbAuditTrial=new StringBuilder();
			strAppno = correctNull((String)hshValues.get("appno"));
			String strValue = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strPrdType=correctNull((String)hshValues.get("strProductType"));
			String strInwardno=correctNull((String)hshValues.get("inwardno"));
			if (strAppno.trim().equals(""))
			{
				strAppno="0";
			}
			if (strValue.trim().equals(""))
			{
				strValue="0";
			}
			
			int intUpdatesize=0;
				
			if (strAction.trim().equals("update"))
			{	
				
				if(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral"))
				{
					
					rs=DBUtils.executeLAPSQuery("selpreinspectionvisitbyinwardno^"+strInwardno);
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("selpreinspectionvisit^"+strAppno);
				}
				if(rs.next())
				{
					hshValues.put("strAction", "update");
				}
				else
				{
					if(!strAction.equalsIgnoreCase("delete"))
					{
					hshValues.put("strAction", "insert");
					}
				}
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arrValues=new ArrayList();
				if(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral"))
				{
					hshquery.put("strQueryId","delpreinspectionvisitbyinwardno");
					arrValues.add(correctNull((String)hshValues.get("inwardno")));
				}
				else
				{
					hshquery.put("strQueryId","delpreinspectionvisit");
					arrValues.add(correctNull((String)hshValues.get("appno")));
	
				}
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				log.info("hshqueryvalhshqueryval"+hshqueryval);
				
				intUpdatesize=2;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arrValues=new ArrayList();
				hshquery.put("strQueryId","inspreinspectionvisit");
				
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applicant")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_father")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_distance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_visitdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_loanpurpose")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nearestbranch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_residence")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_stayingsince")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_homeaddreastlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_homeaddrwestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_homeaddrnorthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_homeaddrsouthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_homeaddreastlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_supplier")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_purchaseprice")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_genuinessphone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_genphcontperson")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_genuinesspersonal")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_genpercontperson")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employername")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employerverify")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employeraddress")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_emppersoncontact")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employeedesig")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employeeincome")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employeeworksince")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employeeno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employerconfirm")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employerofficephone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employerresiphone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employermobile")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_businessfirmname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_businessfirmaddr")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_businessfirmregno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmlicenceno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmeastlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmwestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmnorthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmsouthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmposition")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmestabyr")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_busifirmnature")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_applnamedisplayed")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfoccupation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempaddress")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempregno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfemplicenceno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempeastlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempwestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempnorthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempsouthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempofficephone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempresiphone")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_selfempmobile")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_form16")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_salslip")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_taxreturn")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentbank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentbankbranch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentbankactype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentbankaccno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_accdetailsverifyfrom")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankloantype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbanksancamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankosamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ourbankoverdueamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_otherbankname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_otherbankloantype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_otherbanksancamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_otherbankosamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_otherbankoverdueamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pensionaccno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pensionaccbranch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pensionamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pensionpayorderno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pensionnominee")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_titledeed")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_titledeedno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_subregoffice")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propownername")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_proptype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_ownernature")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_proptopurchase")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_proposed")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propaddress")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_propdesc")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propplotno")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propsurveyno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propstreetno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propwardno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propeastlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propwestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propnorthlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propsouthlandmark")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propnooffloors")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propfloorno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propage")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propagebalance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proppriorcharges")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_propvalreportobtained")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propsaleamt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propfacilityavailable")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propvalreport")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proprepresentative")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proparea")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propowner")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proptaxpaidcomments")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propmaintanance")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propvalasperinsofficial")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_permissionobtained")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_propcompleted")));					
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propconstructstatus")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_propfeatures")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vechicletype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehicleage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehiclevalue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_valueby")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehiclepriorcharges")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehicleregno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehiclechasisno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehicleengineno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_vehicleduplikeyobtain")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_visitofficercomment")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_signplace")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_visitofficername")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_signdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_visitofficerdesign")));
				arrValues.add(correctNull((String)hshValues.get("inwardno")));
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("2",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				//-------------------------------------AuditTrial---------------------------------
				if(rs!=null)
					rs.close();
				if(!(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral")))
				{
					rs=DBUtils.executeLAPSQuery("selapplicant_byappno^"+strAppno+"^a");
					if (rs.next())
					{	
						strEmpType = correctNull((String) rs.getString("perapp_employment"));
					}
				}
				if(rs!=null)
				  rs.close();
				
			//Property Type
			if(correctNull((String)hshValues.get("sel_proptype")).trim().equalsIgnoreCase("1"))
				strPropType = "Residential";
			else if(correctNull((String)hshValues.get("sel_proptype")).trim().equalsIgnoreCase("2"))
				strPropType = "Commerical";
			//Nature of ownership
			if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("1"))
				strNature = "FREE HOLD";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("2"))
				strNature = "LEASE HOLD";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("3"))
				strNature = "LICENCE";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("4"))
				strNature = "UNDIVIDED INTEREST ( GIVE DETAILS OF SHARE)";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("5"))
				strNature = "TRUST PROPERTY";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("6"))
				strNature = "ASSIGNEE";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("7"))
				strNature = "TITLE ONLY BY POSSESSION";
			else if(correctNull((String)hshValues.get("sel_ownernature")).trim().equalsIgnoreCase("8"))
				strNature = "AS A MEMBER / SHARE HOLDER OF SOCIETY";
			//DETAILS OF A/C VERIFIED FROM
			if(correctNull((String)hshValues.get("sel_accdetailsverifyfrom")).trim().equalsIgnoreCase("1"))
				strAccverify = "Bank Statement";
			else if(correctNull((String)hshValues.get("sel_accdetailsverifyfrom")).trim().equalsIgnoreCase("2"))
				strAccverify = "Pass Book";
			//RESIDENCE IS 
			if(correctNull((String)hshValues.get("sel_residence")).trim().equalsIgnoreCase("1"))
				strResidence = "Owned";
			else if(correctNull((String)hshValues.get("sel_residence")).trim().equalsIgnoreCase("2"))
				strResidence = "Rented"; 
			else if(correctNull((String)hshValues.get("sel_residence")).trim().equalsIgnoreCase("3"))
				strResidence = "Leased"; 
			else if(correctNull((String)hshValues.get("sel_residence")).trim().equalsIgnoreCase("4"))
				strResidence = "Others"; 
			else if(correctNull((String)hshValues.get("sel_residence")).trim().equalsIgnoreCase("5"))
				strResidence = "Provided by Employer"; 
			//TO BE PURCHASED - PLOT, HOUSE,FLAT
           if(correctNull((String)hshValues.get("sel_proptopurchase")).trim().equalsIgnoreCase("Y"))
				strhouseType = "Yes";
			else if(correctNull((String)hshValues.get("sel_accdetailsverifyfrom")).trim().equalsIgnoreCase("N"))
				strhouseType = "No";
         //	PROPOSED
           if(correctNull((String)hshValues.get("sel_proposed")).trim().equalsIgnoreCase("Y"))
				strPropose = "Yes";
			else if(correctNull((String)hshValues.get("sel_proposed")).trim().equalsIgnoreCase("N"))
				strPropose = "No";
           //DESCRIPTION OF PROPERTY
            if(correctNull((String)hshValues.get("sel_propdesc")).trim().equalsIgnoreCase("R"))
				strDescProp = "RESIDENTIAL";
		    else if(correctNull((String)hshValues.get("sel_propdesc")).trim().equalsIgnoreCase("C"))
		    	strDescProp = "COMMERCIAL";
	    	else if(correctNull((String)hshValues.get("sel_propdesc")).trim().equalsIgnoreCase("M"))
	    		strDescProp = "MIXED";
            //VALUATION REPORT FROM ARCHITECT/ENGINEER OBTAINED
	           if(correctNull((String)hshValues.get("sel_propvalreportobtained")).trim().equalsIgnoreCase("Y"))
					strValRep = "Yes";
				else if(correctNull((String)hshValues.get("sel_propvalreportobtained")).trim().equalsIgnoreCase("N"))
					strValRep = "No";
             //PERMISSION FOR CONSTRUCTION /REPAIR OBTAINED?
	           if(correctNull((String)hshValues.get("sel_permissionobtained")).trim().equalsIgnoreCase("Y"))
					strConsValue = "Yes";
				else if(correctNull((String)hshValues.get("sel_permissionobtained")).trim().equalsIgnoreCase("N"))
					strConsValue = "No";
	           //HOUSE/FLAT IS COMPLETED?
	           if(correctNull((String)hshValues.get("sel_propcompleted")).trim().equalsIgnoreCase("Y"))
					strHouseStatus = "Yes";
				else if(correctNull((String)hshValues.get("sel_propcompleted")).trim().equalsIgnoreCase("N"))
					strHouseStatus = "No";
	          // DUPLICATE KEYS OBTAINED BY THE BANK
	           if(correctNull((String)hshValues.get("sel_vehicleduplikeyobtain")).trim().equalsIgnoreCase("1"))
	        	   strDuplicate = "Yes";
				else if(correctNull((String)hshValues.get("sel_vehicleduplikeyobtain")).trim().equalsIgnoreCase("2"))
					strDuplicate = "No";
	           
			
			
			sbAuditTrial.append(
			"~NAME OF THE APPLICANT=").append(correctNull((String)hshValues.get("txt_applicant"))).append(
			"~FATHER’S /HUSBAND’S =").append(correctNull((String)hshValues.get("txt_father"))).append(
			"~RESIDENTIAL ADDRESS=").append(correctNull((String)hshValues.get("txt_address"))).append(
			"~DISTANCE FROM BRANCH (KMS)=").append(correctNull((String)hshValues.get("txt_distance"))).append(
			"~DATE OF VISIT=").append(correctNull((String)hshValues.get("txt_visitdate"))).append(
			"~PURPOSE OF LOAN=").append(correctNull((String)hshValues.get("txt_loanpurpose"))).append(
			"~NAME OF THE NEAREST BRANCH OF OUR BANK =").append(correctNull((String)hshValues.get("txt_nearestbranch"))).append(
			"~RESIDENCE IS =").append(strResidence).append(
			"~STAYING SINCE=").append(correctNull((String)hshValues.get("txt_stayingsince"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("NEARBY LANDMARK FOR IDENTIFICATION :").append("</b><br>");
			sbAuditTrial.append("EAST=").append(correctNull((String)hshValues.get("txt_homeaddreastlandmark"))).append(
			"~WEST=").append(correctNull((String)hshValues.get("txt_homeaddrwestlandmark"))).append(
			"~NORTH=").append(correctNull((String)hshValues.get("txt_homeaddrnorthlandmark"))).append(
			"~SOUTH=").append(correctNull((String)hshValues.get("txt_homeaddrsouthlandmark"))).append(
			"~NAME OF THE SUPPLIER=").append(correctNull((String)hshValues.get("txt_supplier"))).append(
			"~PURCHASE PRICE (incl Tax) =").append(correctNull((String)hshValues.get("txt_purchaseprice"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("GENUINENESS OF QUOTATION VERIFIED").append("</b><br>");
			sbAuditTrial.append("OVER PHONE NO.=").append(correctNull((String)hshValues.get("txt_genuinessphone"))).append(
			"~NAME OF THE PERSON CONTACTED=").append(correctNull((String)hshValues.get("txt_genphcontperson"))).append(
			"~BY PERSONAL VISIT=").append(correctNull((String)hshValues.get("txt_genuinesspersonal"))).append(
			"~NAME OF THE PERSON CONTACTED=").append(correctNull((String)hshValues.get("txt_genpercontperson"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("OCCUPATION OF APPLICANT (GIVE DETAILS):").append("</b><br>");
			if(strEmpType.trim().equalsIgnoreCase("1"))       	//1- Employee
			{
			sbAuditTrial.append("NAME OF EMPLOYER=").append(correctNull((String)hshValues.get("txt_employername"))).append(
			"~DETAILS VERIFIED BY/THROUGH PERSONAL VISIT TO OFFICE ON=").append(correctNull((String)hshValues.get("txt_employerverify"))).append(
			"~Address=").append(correctNull((String)hshValues.get("txt_employeraddress"))).append(
			"~NAME OF PERSON CONTACTED =").append(correctNull((String)hshValues.get("txt_emppersoncontact"))).append(
			"~DESIGNATION=").append(correctNull((String)hshValues.get("txt_employeedesig"))).append(
			"~GROSS ANNUAL/MONTHLY INCOME - IF ANY DEVIATION FOUND =").append(correctNull((String)hshValues.get("txt_employeeincome"))).append(
			"~WORKING SINCE=").append(correctNull((String)hshValues.get("txt_employeeworksince"))).append(
			"~EMPLOYEE NO=").append(correctNull((String)hshValues.get("txt_employeeno"))).append(
			"~WHETHER CONFIRMED/PROBATION/OR ON CONTRACT BASIS=").append(correctNull((String)hshValues.get("txt_employerconfirm"))).append(
			"~Phone No. OFFICE=").append(correctNull((String)hshValues.get("txt_employerofficephone"))).append(
			"~Phone No. RESIDENCE=").append(correctNull((String)hshValues.get("txt_employerresiphone"))).append(
			"~Phone No. MOBILE=").append(correctNull((String)hshValues.get("txt_employermobile"))).append("<br>");
			}else if(strEmpType.trim().equalsIgnoreCase("2")){  //2 - Business
			sbAuditTrial.append("NAME OF THE FIRM=").append(correctNull((String)hshValues.get("txt_businessfirmname"))).append(
			"~ADDRESS=").append(correctNull((String)hshValues.get("txt_businessfirmaddr"))).append(
			"~REGISTRATION NO.=").append(correctNull((String)hshValues.get("txt_businessfirmregno"))).append(
			"~LICENCE NO.=").append(correctNull((String)hshValues.get("txt_busifirmlicenceno"))).append("<br>");
			sbAuditTrial.append("<b>").append("NEARBY LANDMARK FOR IDENTIFICATION :").append("</b><br>");
			sbAuditTrial.append("~EAST=").append(correctNull((String)hshValues.get("txt_busifirmeastlandmark"))).append(
			"~WEST=").append(correctNull((String)hshValues.get("txt_busifirmwestlandmark"))).append(
			"~NORTH=").append(correctNull((String)hshValues.get("txt_busifirmnorthlandmark"))).append(
			"~SOUTH=").append(correctNull((String)hshValues.get("txt_busifirmsouthlandmark"))).append(
			"~APPLICANTS POSITION IN THE FIRM=").append(correctNull((String)hshValues.get("txt_busifirmposition"))).append(
			"~YEAR OF ESTABLISHMENT=").append(correctNull((String)hshValues.get("txt_busifirmestabyr"))).append(
			"~NATURE OF BUSINESS=").append(correctNull((String)hshValues.get("txt_busifirmnature"))).append(
			"~APPLICANTS NAME BOARD DISPLAYED=").append(correctNull((String)hshValues.get("sel_applnamedisplayed")));
			
		}else if(strEmpType.trim().equalsIgnoreCase("3")){      //3 -  Professional
			sbAuditTrial.append("<b>").append("APPLICANTS POSITION IN THE FIRM").append("</b><br>");
			sbAuditTrial.append("OCCUPATION=").append(correctNull((String)hshValues.get("txt_selfoccupation"))).append(
			"~BUSINESS ADDRESS=").append(correctNull((String)hshValues.get("txt_selfempaddress"))).append(
			"~REGISTRATION NO.=").append(correctNull((String)hshValues.get("txt_selfempregno"))).append(
			"~LICENCE NO.=").append(correctNull((String)hshValues.get("txt_selfemplicenceno"))).append("<br>");
			sbAuditTrial.append("<b>").append("NEARBY LANDMARK FOR IDENTIFICATION :").append("</b><br>");
			sbAuditTrial.append("~EAST=").append(correctNull((String)hshValues.get("txt_selfempeastlandmark"))).append(
			"~WEST=").append(correctNull((String)hshValues.get("txt_selfempwestlandmark"))).append(
			"~NORTH=").append(correctNull((String)hshValues.get("txt_selfempnorthlandmark"))).append(
			"~SOUTH=").append(correctNull((String)hshValues.get("txt_selfempsouthlandmark"))).append(
			"~Phone No. OFFICE=").append(correctNull((String)hshValues.get("txt_selfempofficephone"))).append(
			"~Phone No. RESIDENCE=").append(correctNull((String)hshValues.get("txt_selfempresiphone"))).append(
			"~Phone No. MOBILE=").append(correctNull((String)hshValues.get("txt_selfempmobile"))).append("<br>");
	    }
			sbAuditTrial.append("<b>").append("DETAILS VERIFIED FROM").append("</b><br>");
			sbAuditTrial.append("a. FORM NO.16 (FOR THE FINANCIAL YEAR ENDED MARCH 200...) =").append(correctNull((String)hshValues.get("txt_form16"))).append(
			"~b. LAST SALARY SLIP (FOR THE MONTH OF =").append(correctNull((String)hshValues.get("txt_salslip"))).append(
			"~c. INCOME TAX RETURN FOR A.Y. (ALONG WITH ORIGINAL COPY OF TAX CHALLAN PERIOD=").append(correctNull((String)hshValues.get("txt_taxreturn"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("PRESENT BANKERS").append("</b><br>");
			sbAuditTrial.append("NAME OF THE BANK=").append(correctNull((String)hshValues.get("txt_presentbank"))).append(
			"~BRANCH=").append(correctNull((String)hshValues.get("txt_presentbankbranch"))).append(
			"~TYPE OF A/C.=").append(correctNull((String)hshValues.get("txt_presentbankactype"))).append(
			"~A/C NO.=").append(correctNull((String)hshValues.get("txt_presentbankaccno"))).append(
			"~DETAILS OF A/C VERIFIED FROM=").append(strAccverify).append("<br>");
				
			sbAuditTrial.append("<b>").append("LOAN OUTSTANDING(OUR BANK)").append("</b><br>");
			sbAuditTrial.append("NAME OF THE BRANCH=").append(correctNull((String)hshValues.get("txt_ourbankname"))).append(
			"~TYPE OF LOAN=").append(correctNull((String)hshValues.get("txt_ourbankloantype"))).append(
			"~AMOUNT SANCTIONED=").append(correctNull((String)hshValues.get("txt_ourbanksancamt"))).append(
			"~BALANCE OUTSTANDING=").append(correctNull((String)hshValues.get("txt_ourbankosamt"))).append(
			"~OVERDUE AMOUNT, IF ANY =").append(correctNull((String)hshValues.get("txt_ourbankoverdueamt"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("LOAN OUTSTANDING(OTHER BANK)").append("</b><br>");
			sbAuditTrial.append("NAME OF THE BRANCH=").append(correctNull((String)hshValues.get("txt_otherbankname"))).append(
			"~TYPE OF LOAN=").append(correctNull((String)hshValues.get("txt_otherbankloantype"))).append(
			"~AMOUNT SANCTIONED=").append(correctNull((String)hshValues.get("txt_otherbanksancamt"))).append(
			"~BALANCE OUTSTANDING=").append(correctNull((String)hshValues.get("txt_otherbankosamt"))).append(
			"~OVERDUE AMOUNT, IF ANY =").append(correctNull((String)hshValues.get("txt_otherbankoverdueamt"))).append("<br>");
			
			//9--Pensioner
			if(strEmpType.trim().equalsIgnoreCase("9")){   
			sbAuditTrial.append("<b>").append("Pension").append("</b><br>");
			sbAuditTrial.append("PENSION ACCOUNT NO.=").append(correctNull((String)hshValues.get("txt_pensionaccno"))).append(
			"~NAME OF THE BRANCH=").append(correctNull((String)hshValues.get("txt_pensionaccbranch"))).append(
			"~MONTHLY PENSION AMOUNT=").append(correctNull((String)hshValues.get("txt_pensionamt"))).append(
			"~PPO NO.=").append(correctNull((String)hshValues.get("txt_pensionpayorderno"))).append(
			"~NAME OF NOMINEE FOR PENSION=").append(correctNull((String)hshValues.get("txt_pensionnominee"))).append("<br>");
			}
			//
			
			sbAuditTrial.append("<b>").append("INSPECTION DETAILS").append("</b><br>");
			sbAuditTrial.append("TITLE DEED=").append(correctNull((String)hshValues.get("txt_titledeed"))).append(
			"~DEED NO.=").append(correctNull((String)hshValues.get("txt_titledeedno"))).append(
			"~NAME OF SUB-REGISTRAR OFFICE=").append(correctNull((String)hshValues.get("txt_subregoffice"))).append(
			"~NAME OF OWNER/S OF THE PROPERTY=").append(correctNull((String)hshValues.get("txt_propownername"))).append(
			"~PROPERTY TYPE=").append(strPropType).append(
			"~NATURE OF OWNERSHIP=").append(strNature).append("<br>");
			
			//house
			if(strPrdType.trim().equalsIgnoreCase("pH")){
			sbAuditTrial.append("<b>").append("DETAILS OF PROPERTY").append("</b><br>");
			sbAuditTrial.append("TO BE PURCHASED - PLOT, HOUSE,FLAT=").append(strhouseType).append(
			"~PROPOSED=").append(strPropose).append(
			"~ADDRESS=").append(correctNull((String)hshValues.get("txt_propaddress"))).append(
			"~DESCRIPTION OF PROPERTY=").append(strDescProp).append(
			"~PLOT NO.=").append(correctNull((String)hshValues.get("txt_propplotno"))).append(
			"~SURVEY NO.=").append(correctNull((String)hshValues.get("txt_propsurveyno"))).append(
			"~STREET NO.=").append(correctNull((String)hshValues.get("txt_propstreetno"))).append(
			"~WARD NO.=").append(correctNull((String)hshValues.get("txt_propwardno"))).append("<br>");
			
			sbAuditTrial.append("<b>").append("NEARBY LANDMARK FOR IDENTIFICATION :").append("</b><br>");
			sbAuditTrial.append("EAST=").append(correctNull((String)hshValues.get("txt_propeastlandmark"))).append(
			"~WEST=").append(correctNull((String)hshValues.get("txt_propwestlandmark"))).append(
			"~NORTH=").append(correctNull((String)hshValues.get("txt_propnorthlandmark"))).append(
			"~SOUTH=").append(correctNull((String)hshValues.get("txt_propsouthlandmark"))).append(
			"~NO. OF FLOORS=").append(correctNull((String)hshValues.get("txt_propnooffloors"))).append(
			"~PROPOSED FLAT ON FLOOR NO.=").append(correctNull((String)hshValues.get("txt_propfloorno"))).append(
			"~AGE OF BUILDING=").append(correctNull((String)hshValues.get("txt_propage"))).append(
			"~BALANCE LIFE OF BUILDING=").append(correctNull((String)hshValues.get("txt_propagebalance"))).append(
			"~ANY PRIOR CHARGES=").append(correctNull((String)hshValues.get("txt_proppriorcharges"))).append(
			"~VALUATION REPORT FROM ARCHITECT/ENGINEER OBTAINED=").append(strValRep).append(
			"~SALE AMOUNT=").append(correctNull((String)hshValues.get("txt_propsaleamt"))).append(
			"~FACILITIES AVAILABLE=").append(correctNull((String)hshValues.get("txt_propfacilityavailable"))).append(
			"~VALUE AS PER VALUATION REPORT, VALUE INDICATED IN THE SALE DEED MAY ALSO BE TAKEN INTO ACCOUNT IN CASE OF WIDE VARIATION, COMMENTS REQUIRED=").append(correctNull((String)hshValues.get("txt_propvalreport"))).append(
			"~NAME OF THE PERSON REPRESENTING SELLER/BUILDER=").append(correctNull((String)hshValues.get("txt_proprepresentative"))).append(
			"~AREA IN SQ.FT.AS PER SALE AGREEMENT=").append(correctNull((String)hshValues.get("txt_proparea"))).append(
			"~WHETHER OWNER OCCUPIED/ RENTED/LEASED=").append(correctNull((String)hshValues.get("txt_propowner"))).append(
			"~COMMENTS ON TAXES PAID=").append(correctNull((String)hshValues.get("txt_proptaxpaidcomments"))).append(
			"~MAINTENANCE OF BUILDING=").append(correctNull((String)hshValues.get("txt_propmaintanance"))).append(
			"~VALUATION OF PROPERTY AS PER INSPECTING OFFICIAL=").append(correctNull((String)hshValues.get("txt_propvalasperinsofficial"))).append("<br>");
			sbAuditTrial.append("<b>").append("CONSTRUCTION / REPAIRS / IMPROVEMENT / EXTENTION OF HOUSE / FLAT").append("</b><br>");
			sbAuditTrial.append("PERMISSION FOR CONSTRUCTION /REPAIR OBTAINED?=").append(strConsValue).append(
			"~HOUSE/FLAT IS COMPLETED?=").append(strHouseStatus).append("<br>");
			}
			//
			//vehicle
			else if(strPrdType.trim().equalsIgnoreCase("pA")){
			sbAuditTrial.append("<b>").append("OLD VEHICLES").append("</b><br>");
			sbAuditTrial.append("TYPE OF VEHICLE=").append(correctNull((String)hshValues.get("txt_vechicletype"))).append(
			"~AGE OF VEHICLE =").append(correctNull((String)hshValues.get("txt_vehicleage"))).append(
			"~VALUE OF THE VEHICLE=").append(correctNull((String)hshValues.get("txt_vehiclevalue"))).append(
			"~VALUED BY & DATE=").append(correctNull((String)hshValues.get("txt_valueby"))).append(
			"~ANY PRIOR CHARGES=").append(correctNull((String)hshValues.get("txt_vehiclepriorcharges"))).append(
			"~REGISTRATION NO.=").append(correctNull((String)hshValues.get("txt_vehicleregno"))).append(
			"~CHASSIS NO.=").append(correctNull((String)hshValues.get("txt_vehiclechasisno"))).append(
			"~ENGINE NO.=").append(correctNull((String)hshValues.get("txt_vehicleengineno"))).append(
			"~DUPLICATE KEYS OBTAINED BY THE BANK=").append(strDuplicate);
			}
			//
			sbAuditTrial.append("<b>").append("COMMENTS OF VISITING OFFICER").append("</b><br>");
			sbAuditTrial.append("Place=").append(correctNull((String)hshValues.get("txt_signplace"))).append(
			"~Name =").append(correctNull((String)hshValues.get("txt_visitofficername"))).append(
			"~Designation with PA No=").append(correctNull((String)hshValues.get("txt_visitofficerdesign"))).append(
			"~Date=").append(correctNull((String)hshValues.get("txt_signdate")));
			
			//----------------------------------------End-------------------------------------
		}
		else if(strAction.trim().equals("delete"))
		{
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arrValues=new ArrayList();
			if(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral"))
			{
				hshquery.put("strQueryId","delpreinspectionvisitbyinwardno");
				arrValues.add(correctNull((String)hshValues.get("inwardno")));
			}
			else
			{
				hshquery.put("strQueryId","delpreinspectionvisit");
				arrValues.add(correctNull((String)hshValues.get("appno")));

			}
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			log.info("hshqueryvalhshqueryval"+hshqueryval);
			
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		if(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral"))
		{
			
			rs=DBUtils.executeLAPSQuery("selpreinspectionvisitbyinwardno^"+strInwardno);
		}
		else
		{
			rs=DBUtils.executeLAPSQuery("selpreinspectionvisit^"+strAppno);
		}
				 
		if (rs.next())
		{
			//hshRecord.put("per_id",correctNull(rs.getString("per_id")));
			hshRecord.put("pre_name",correctNull(rs.getString("pre_applicant")));
			hshRecord.put("perapp_fatname",correctNull(rs.getString("pre_father")));
			hshRecord.put("pre_address",correctNull(rs.getString("pre_address")));	
			
			hshRecord.put("pre_distance",correctNull(rs.getString("pre_distance")));
			hshRecord.put("pre_visitdate",correctNull(rs.getString("pre_visitdate")));
			hshRecord.put("pre_loanpurpose",correctNull(rs.getString("pre_loanpurpose")));
			hshRecord.put("pre_nearestbranch",correctNull(rs.getString("pre_nearestbranch")));
			hshRecord.put("pre_residence",correctNull(rs.getString("pre_residence")));
			hshRecord.put("pre_stayingsince",correctNull(rs.getString("pre_stayingsince")));
			
			hshRecord.put("pre_homeaddreastlandmark",correctNull(rs.getString("pre_homeaddreastlandmark")));
			hshRecord.put("pre_homeaddrwestlandmark",correctNull(rs.getString("pre_homeaddrwestlandmark")));
			hshRecord.put("pre_homeaddrnorthlandmark",correctNull(rs.getString("pre_homeaddrnorthlandmark")));
			hshRecord.put("pre_homeaddrsouthlandmark",correctNull(rs.getString("pre_homeaddrsouthlandmark")));
			
			hshRecord.put("pre_supplier",correctNull(rs.getString("pre_supplier")));
			hshRecord.put("pre_purchaseprice",correctNull(rs.getString("pre_purchaseprice")));
			
			hshRecord.put("pre_genuinessphone",correctNull(rs.getString("pre_genuinessphone")));
			hshRecord.put("pre_genphcontperson",correctNull(rs.getString("pre_genphcontperson")));
			hshRecord.put("pre_genuinesspersonal",correctNull(rs.getString("pre_genuinesspersonal")));
			hshRecord.put("pre_genpercontperson",correctNull(rs.getString("pre_genpercontperson")));
			
			hshRecord.put("pre_employername",correctNull(rs.getString("pre_employername")));
			hshRecord.put("pre_employeraddress",correctNull(rs.getString("pre_employeraddress")));
			hshRecord.put("pre_employeedesig",correctNull(rs.getString("pre_employeedesig")));
			hshRecord.put("pre_employeeworksince",correctNull(rs.getString("pre_employeeworksince")));
			hshRecord.put("pre_employeeno",correctNull(rs.getString("pre_employeeno")));
			hshRecord.put("pre_employeeincome",correctNull(rs.getString("pre_employeeincome")));
			hshRecord.put("pre_emppersoncontact",correctNull(rs.getString("pre_emppersoncontact")));
			hshRecord.put("pre_employerverify",correctNull(rs.getString("pre_employerverify")));
			hshRecord.put("pre_employerconfirm",correctNull(rs.getString("pre_employerconfirm")));
			hshRecord.put("pre_employerofficephone",correctNull(rs.getString("pre_employerofficephone")));
			hshRecord.put("pre_employerresiphone",correctNull(rs.getString("pre_employerresiphone")));
			hshRecord.put("pre_employermobile",correctNull(rs.getString("pre_employermobile")));
			
			hshRecord.put("pre_businessfirmname",correctNull(rs.getString("pre_businessfirmname")));
			hshRecord.put("pre_businessfirmaddr",correctNull(rs.getString("pre_businessfirmaddr")));
			hshRecord.put("pre_businessfirmregno",correctNull(rs.getString("pre_businessfirmregno")));
			hshRecord.put("pre_busifirmlicenceno",correctNull(rs.getString("pre_busifirmlicenceno")));
			hshRecord.put("pre_busifirmeastlandmark",correctNull(rs.getString("pre_busifirmeastlandmark")));
			hshRecord.put("pre_busifirmwestlandmark",correctNull(rs.getString("pre_busifirmwestlandmark")));
			hshRecord.put("pre_busifirmnorthlandmark",correctNull(rs.getString("pre_busifirmnorthlandmark")));
			hshRecord.put("pre_busifirmsouthlandmark",correctNull(rs.getString("pre_busifirmsouthlandmark")));
			hshRecord.put("pre_busifirmposition",correctNull(rs.getString("pre_busifirmposition")));
			hshRecord.put("pre_busifirmestabyr",correctNull(rs.getString("pre_busifirmestabyr")));
			hshRecord.put("pre_busifirmnature",correctNull(rs.getString("pre_busifirmnature")));
			hshRecord.put("pre_applnamedisplayed",correctNull(rs.getString("pre_applnamedisplayed")));
			
			hshRecord.put("pre_selfoccupation",correctNull(rs.getString("pre_selfoccupation")));
			hshRecord.put("pre_selfempaddress",correctNull(rs.getString("pre_selfempaddress")));
			hshRecord.put("pre_selfempregno",correctNull(rs.getString("pre_selfempregno")));
			hshRecord.put("pre_selfemplicenceno",correctNull(rs.getString("pre_selfemplicenceno")));
			hshRecord.put("pre_selfempeastlandmark",correctNull(rs.getString("pre_selfempeastlandmark")));
			hshRecord.put("pre_selfempwestlandmark",correctNull(rs.getString("pre_selfempwestlandmark")));
			hshRecord.put("pre_selfempnorthlandmark",correctNull(rs.getString("pre_selfempnorthlandmark")));
			hshRecord.put("pre_selfempsouthlandmark",correctNull(rs.getString("pre_selfempsouthlandmark")));
			hshRecord.put("pre_selfempofficephone",correctNull(rs.getString("pre_selfempofficephone")));
			hshRecord.put("pre_selfempresiphone",correctNull(rs.getString("pre_selfempresiphone")));
			hshRecord.put("pre_selfempmobile",correctNull(rs.getString("pre_selfempmobile")));
			
			hshRecord.put("pre_form16",correctNull(rs.getString("pre_form16")));
			hshRecord.put("pre_salslip",correctNull(rs.getString("pre_salslip")));
			hshRecord.put("pre_taxreturn",correctNull(rs.getString("pre_taxreturn")));
			
			hshRecord.put("pre_presentbank",correctNull(rs.getString("pre_presentbank")));
			hshRecord.put("pre_presentbankbranch",correctNull(rs.getString("pre_presentbankbranch")));
			hshRecord.put("pre_presentbankactype",correctNull(rs.getString("pre_presentbankactype")));
			hshRecord.put("pre_presentbankaccno",correctNull(rs.getString("pre_presentbankaccno")));
			hshRecord.put("pre_accdetailsverifyfrom",correctNull(rs.getString("pre_accdetailsverifyfrom")));
			
			hshRecord.put("pre_ourbankname",correctNull(rs.getString("pre_ourbankname")));
			hshRecord.put("pre_otherbankname",correctNull(rs.getString("pre_otherbankname")));
			hshRecord.put("pre_ourbankloantype",correctNull(rs.getString("pre_ourbankloantype")));
			hshRecord.put("pre_otherbankloantype",correctNull(rs.getString("pre_otherbankloantype")));
			hshRecord.put("pre_ourbanksancamt",correctNull(rs.getString("pre_ourbanksancamt")));
			hshRecord.put("pre_otherbanksancamt",correctNull(rs.getString("pre_otherbanksancamt")));
			hshRecord.put("pre_ourbankosamt",correctNull(rs.getString("pre_ourbankosamt")));
			hshRecord.put("pre_otherbankosamt",correctNull(rs.getString("pre_otherbankosamt")));
			hshRecord.put("pre_ourbankoverdueamt",correctNull(rs.getString("pre_ourbankoverdueamt")));
			hshRecord.put("pre_otherbankoverdueamt",correctNull(rs.getString("pre_otherbankoverdueamt")));
			
			hshRecord.put("pre_pensionaccno",correctNull(rs.getString("pre_pensionaccno")));
			hshRecord.put("pre_pensionaccbranch",correctNull(rs.getString("pre_pensionaccbranch")));
			hshRecord.put("pre_pensionamt",correctNull(rs.getString("pre_pensionamt")));
			hshRecord.put("pre_pensionpayorderno",correctNull(rs.getString("pre_pensionpayorderno")));
			hshRecord.put("pre_pensionnominee",correctNull(rs.getString("pre_pensionnominee")));
			
			hshRecord.put("pre_titledeed",correctNull(rs.getString("pre_titledeed")));
			hshRecord.put("pre_titledeedno",correctNull(rs.getString("pre_titledeedno")));
			hshRecord.put("pre_subregoffice",correctNull(rs.getString("pre_subregoffice")));
			hshRecord.put("pre_propownername",correctNull(rs.getString("pre_propownername")));
			hshRecord.put("pre_proptype",correctNull(rs.getString("pre_proptype")));
			hshRecord.put("pre_ownernature",correctNull(rs.getString("pre_ownernature")));
			
			hshRecord.put("pre_proptopurchase",correctNull(rs.getString("pre_proptopurchase")));
			hshRecord.put("pre_proposed",correctNull(rs.getString("pre_proposed")));
			hshRecord.put("pre_propaddress",correctNull(rs.getString("pre_propaddress")));
			hshRecord.put("pre_propdesc",correctNull(rs.getString("pre_propdesc")));
			hshRecord.put("pre_propplotno",correctNull(rs.getString("pre_propplotno")));
			hshRecord.put("pre_propsurveyno",correctNull(rs.getString("pre_propsurveyno")));
			hshRecord.put("pre_propstreetno",correctNull(rs.getString("pre_propstreetno")));
			hshRecord.put("pre_propwardno",correctNull(rs.getString("pre_propwardno")));
			
			hshRecord.put("pre_propeastlandmark",correctNull(rs.getString("pre_propeastlandmark")));
			hshRecord.put("pre_propwestlandmark",correctNull(rs.getString("pre_propwestlandmark")));
			hshRecord.put("pre_propnorthlandmark",correctNull(rs.getString("pre_propnorthlandmark")));
			hshRecord.put("pre_propsouthlandmark",correctNull(rs.getString("pre_propsouthlandmark")));
			
			hshRecord.put("pre_propnooffloors",correctNull(rs.getString("pre_propnooffloors")));
			hshRecord.put("pre_propfloorno",correctNull(rs.getString("pre_propfloorno")));
			hshRecord.put("pre_propage",correctNull(rs.getString("pre_propage")));
			hshRecord.put("pre_propagebalance",correctNull(rs.getString("pre_propagebalance")));
			hshRecord.put("pre_proppriorcharges",correctNull(rs.getString("pre_proppriorcharges")));
			hshRecord.put("pre_propvalreportobtained",correctNull(rs.getString("pre_propvalreportobtained")));
			hshRecord.put("pre_propsaleamt",correctNull(rs.getString("pre_propsaleamt")));
			hshRecord.put("pre_propfacilityavailable",correctNull(rs.getString("pre_propfacilityavailable")));
			hshRecord.put("pre_propvalreport",correctNull(rs.getString("pre_propvalreport")));
			hshRecord.put("pre_proprepresentative",correctNull(rs.getString("pre_proprepresentative")));
			hshRecord.put("pre_proparea",correctNull(rs.getString("pre_proparea")));
			hshRecord.put("pre_propowner",correctNull(rs.getString("pre_propowner")));
			hshRecord.put("pre_proptaxpaidcomments",correctNull(rs.getString("pre_proptaxpaidcomments")));
			hshRecord.put("pre_propmaintanance",correctNull(rs.getString("pre_propmaintanance")));
			hshRecord.put("pre_propvalasperinsofficial",correctNull(rs.getString("pre_propvalasperinsofficial")));
			hshRecord.put("pre_permissionobtained",correctNull(rs.getString("pre_permissionobtained")));
			hshRecord.put("pre_propcompleted",correctNull(rs.getString("pre_propcompleted")));
			hshRecord.put("pre_propconstructstatus",correctNull(rs.getString("pre_propconstructstatus")));
			hshRecord.put("pre_propfeatures",correctNull(rs.getString("pre_propfeatures")));
			
			hshRecord.put("pre_vechicletype",correctNull(rs.getString("pre_vechicletype")));
			hshRecord.put("pre_vehicleage",correctNull(rs.getString("pre_vehicleage")));
			hshRecord.put("pre_vehiclevalue",correctNull(rs.getString("pre_vehiclevalue")));
			hshRecord.put("pre_vehiclepriorcharges",correctNull(rs.getString("pre_vehiclepriorcharges")));
			hshRecord.put("pre_vehicleregno",correctNull(rs.getString("pre_vehicleregno")));
			hshRecord.put("pre_vehiclechasisno",correctNull(rs.getString("pre_vehiclechasisno")));
			hshRecord.put("pre_vehicleengineno",correctNull(rs.getString("pre_vehicleengineno")));
			hshRecord.put("pre_valueby",correctNull(rs.getString("pre_valueby")));
			
			hshRecord.put("pre_vehicleduplikeyobtain",correctNull(rs.getString("pre_vehicleduplikeyobtain")));
			
			hshRecord.put("pre_visitofficercomment",correctNull(rs.getString("pre_visitofficercomment")));
			hshRecord.put("pre_signplace",correctNull(rs.getString("pre_signplace")));
			hshRecord.put("pre_visitofficername",correctNull(rs.getString("pre_visitofficername")));
			hshRecord.put("pre_signdate",correctNull(rs.getString("pre_signdate")));
			hshRecord.put("pre_visitofficerdesign",correctNull(rs.getString("pre_visitofficerdesign")));
			hshRecord.put("pre_inwardno",correctNull(rs.getString("pre_inwardno")));
			recordflag="y";
		}
		if(recordflag.equalsIgnoreCase("N"))
		{
			if(!(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral")) && (correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A")))
			{
				rs=DBUtils.executeLAPSQuery("selapplicant_byappno^"+strAppno+"^a");
				if (rs.next())
				{	
					hshRecord.put("pre_name",correctNull(rs.getString("perapp_fname")));
					hshRecord.put("perapp_fatname",correctNull(rs.getString("perapp_fatname")));
				//	hshRecord.put("perapp_husname",correctNull(rs.getString("perapp_husname")));
					hshRecord.put("perapp_title",correctNull(rs.getString("perapp_title")));
					/*String straddr=correctNull(rs.getString("perapp_address1"))+" , "+
									correctNull(rs.getString("perapp_address2"))+" , "+
									correctNull(rs.getString("perapp_address3"))+" , "+
									//correctNull(rs.getString("perapp_city"))+" , "+
									//correctNull(rs.getString("perapp_state"))+" , "+
									correctNull(rs.getString("comm_city"))+" , "+
									correctNull(rs.getString("comm_state"));
					hshRecord.put("pre_address",straddr);*/
				}
			}
			
		}
		
		if(rs!=null)
		{
			rs.close();
		}
		if(!(correctNull((String)hshValues.get("hidsaral")).equalsIgnoreCase("saral")))
		{
			rs=DBUtils.executeLAPSQuery("selLoanAmt^"+strAppno);
			if (rs.next())
			{	
				hshRecord.put("loan_receivedate",correctNull(rs.getString("loan_receivedate")));
			}
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		if(strInwardno.equalsIgnoreCase(""))
		{
			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+strAppno);
		}
		else
		{
			rs=DBUtils.executeLAPSQuery("selinwardreg^"+strInwardno);
		}
		if(rs.next())
		{
			hshRecord.put("orgname",correctNull(rs.getString("org_name")));
			hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
			hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
			hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
			hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
			hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
		}
		if(!strAction.equalsIgnoreCase(""))
		{
			AuditTrial.auditLog(hshValues,"65",strInwardno,sbAuditTrial.toString());
		}
	}
	catch(Exception ce)
	{
		log.error(ce.toString());
		throw new EJBException("Error in getData "+ce.toString());
	}
	finally
	{
		try
		{
			if(rs != null)
				rs.close();
			 
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
}	

}

	


