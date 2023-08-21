package com.sai.laps.ejb.agreconomic;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.helper.UpdateDairyData;

//import java.util.StringTokenizer;

@Stateless(name = "agrEconomicBean", mappedName = "agrEconomicHome")
@Remote (agrEconomicRemote.class)
public class agrEconomicBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(agrEconomicBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1819849742415614196L;

	/**
	 * 
	 */
	

	public void updateEconomicData(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshRequestValues.get("hidAction");
		String appno=correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));    
		}		
		ResultSet rs = null;
		try
		{			
			if(strAction.equals("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				ArrayList arrValues2 = new ArrayList();
				arrValues2.add(appno);
				hshQuery.put("arrValues",arrValues2);
				hshQuery.put("strQueryId","del_agreconomic");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_agreconomic");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshRequestValues.get("txt_place")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_distance")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_trans")));
				if(correctNull((String)hshRequestValues.get("txt_cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_cost")));
				}
				arrValues.add(correctNull((String)hshRequestValues.get("Modepurchase")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_commitee")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency")));
				if(correctNull((String)hshRequestValues.get("txt_cattle")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_cattle")));
				}
				arrValues.add(correctNull((String)hshRequestValues.get("adequ")));
				arrValues.add(correctNull((String)hshRequestValues.get("Provision")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_givereason")));
				arrValues.add(correctNull((String)hshRequestValues.get("Electricity")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_water")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_dry")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_veterinary")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_disunit")));
				arrValues.add(correctNull((String)hshRequestValues.get("Grazing")));
				arrValues.add(correctNull((String)hshRequestValues.get("hid_forest")));
				arrValues.add(correctNull((String)hshRequestValues.get("hid_pastureland")));
				arrValues.add(correctNull((String)hshRequestValues.get("hid_ownfield")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_markplace")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_dsunit")));
				arrValues.add(correctNull((String)hshRequestValues.get("consumer")));
				arrValues.add(correctNull((String)hshRequestValues.get("Society")));
				arrValues.add(correctNull((String)hshRequestValues.get("Recovery")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agen")));
				arrValues.add(correctNull((String)hshRequestValues.get("animals")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_numunits")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_financing")));
				arrValues.add(correctNull((String)hshRequestValues.get("Equipment")));
				arrValues.add(correctNull((String)hshRequestValues.get("acquisition")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_reason")));
				arrValues.add(correctNull((String)hshRequestValues.get("Borrower")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_ver")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_agreconomic");
				arrValues.add(appno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
			.append("~Market where animals to be purchased - Place = ").append(correctNull((String )hshRequestValues.get("txt_place")))
			.append("~Distance from Unit = ").append(correctNull((String )hshRequestValues.get("txt_distance")))
			.append("~Mode of Transportation = ").append(correctNull((String )hshRequestValues.get("txt_trans")))
			.append("~Cost of Transportation Rs = ").append(correctNull((String )hshRequestValues.get("txt_cost")))
			.append("~Mode of Purchase = ").append(correctNull((String )hshRequestValues.get("Modepurchase_text")));
			if(correctNull((String )hshRequestValues.get("Modepurchase_text")).equalsIgnoreCase("Purchase Commitee"))
			{
				sbAuditTrial
			.append("~Purchase Commitee Name = ").append(correctNull((String )hshRequestValues.get("txt_commitee")));
			}
			sbAuditTrial
			.append("~Whether the Borrower is selected by any Agency = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("Borrower"))));
			if(correctNull((String )hshRequestValues.get("Borrower")).equalsIgnoreCase("1"))
			{
				sbAuditTrial
				.append("~Name of Agency = ").append(correctNull((String )hshRequestValues.get("txt_agency")));	
			}
			sbAuditTrial
			.append("~Whether Following Infrastracture facility available ^")
			.append("~Space in Cattle Shed = ").append(correctNull((String )hshRequestValues.get("txt_cattle")))
			.append("Sq/ft")
			.append("~Adequate for Housing proposed animals = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("adequ"))));
			if(correctNull((String)hshRequestValues.get("adequ")).equalsIgnoreCase("2"))
			{
			sbAuditTrial
			.append("~Whether Provision Now Made = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("Provision"))));
			}
			sbAuditTrial
			.append("~Electricity = ").append(ApplicantParams.getApplicantParams("TechnicalData",correctNull((String )hshRequestValues.get("Electricity"))))
			.append("~Water Facility = ").append(correctNull((String )hshRequestValues.get("txt_water")))
			.append("~Dry/Green fodder Source = ").append(correctNull((String )hshRequestValues.get("txt_dry")))
			.append("~Veterinary Aid = ").append(ApplicantParams.getApplicantParams("TechnicalData",correctNull((String )hshRequestValues.get("sel_ver"))));
			
			if(correctNull((String)hshRequestValues.get("sel_ver")).equalsIgnoreCase("1"))
			{
			sbAuditTrial
			.append("~place = ").append(correctNull((String )hshRequestValues.get("txt_veterinary")))
			.append("~Distance from Unit = ").append(correctNull((String )hshRequestValues.get("txt_disunit"))).append("KM");
			}	
			
			sbAuditTrial
			.append("~Grazing Facility = ").append(ApplicantParams.getApplicantParams("TechnicalData",correctNull((String )hshRequestValues.get("Grazing"))));
			if(correctNull((String )hshRequestValues.get("Grazing")).equalsIgnoreCase("1"))
			{
				if(correctNull((String )hshRequestValues.get("chkForest")).equalsIgnoreCase("checkbox"))
				{
					sbAuditTrial
					.append("  -  ")
					.append("Forest")
					.append(" ,  ");	
					
				}
				if(correctNull((String )hshRequestValues.get("chkParticulars")).equalsIgnoreCase("checkbox"))
				{
					sbAuditTrial
					.append("  -  ")
					.append("Pasture Land")
					.append(" , ");
				}
				if(correctNull((String )hshRequestValues.get("chkfield")).equalsIgnoreCase("checkbox"))
				{
					sbAuditTrial
					.append("  -  ")
					.append("Own field")
					.append(" , ");
				}
					
			}
			sbAuditTrial
			.append("~Market for sale of by products-Place = ").append(correctNull((String )hshRequestValues.get("txt_markplace")))
			.append("~Distance from Unit = ").append(correctNull((String )hshRequestValues.get("txt_dsunit")))
			.append("~Directly to consumer = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("consumer"))))
			.append("~Society = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("Society"))))
			.append("~Tie up for Recovery = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("Recovery"))));
			if(correctNull((String )hshRequestValues.get("Recovery")).equalsIgnoreCase("1"))
			{
			sbAuditTrial
			.append("~Agency = ").append(correctNull((String )hshRequestValues.get("txt_agen")));
			}
			sbAuditTrial
			.append("~Who is the care taker of animals = ").append(correctNull((String )hshRequestValues.get("animals_text")))
			.append("~Number of similar units = ").append(correctNull((String )hshRequestValues.get("txt_numunits")))
			.append("~Scope for further financing = ").append(correctNull((String )hshRequestValues.get("txt_financing")))
			.append("~Equipments / Utensils -Available = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("Equipment"))));
			
			if(correctNull((String )hshRequestValues.get("Equipment")).equalsIgnoreCase("2"))
			{
			sbAuditTrial
			.append("~Whether provision made for acquisition = ").append(ApplicantParams.getApplicantParams("AccountHolder",correctNull((String )hshRequestValues.get("acquisition"))));
			}
			
			if(correctNull((String )hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshRequestValues.put("strAction","update");
			}
		}
			AuditTrial.auditLog(hshRequestValues,"239",appno,sbAuditTrial.toString());
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
	
	public  HashMap getEconomicData(HashMap hshValues) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_agreconomic^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("agr_appno",correctNull(rs.getString("agr_appno")));
				hshRecord.put("agr_place",correctNull(rs.getString("agr_place")));
				hshRecord.put("agr_distancefrom",correctNull(rs.getString("agr_distancefrom")));
				hshRecord.put("agr_modeoftransport",correctNull(rs.getString("agr_modeoftransport")));
				hshRecord.put("agr_costoftransport",correctNull(rs.getString("agr_costoftransport")));
				hshRecord.put("agr_modeofpurchase",correctNull(rs.getString("agr_modeofpurchase"))); //sel
				hshRecord.put("agr_purcommiteename",correctNull(rs.getString("agr_purcommiteename")));
				hshRecord.put("agr_agency",correctNull(rs.getString("agr_agency"))); // agency name or whether
				hshRecord.put("agr_cattleshed",correctNull(rs.getString("agr_cattleshed")));					
				hshRecord.put("agr_houseproposed",correctNull(rs.getString("agr_houseproposed"))); //sel
				hshRecord.put("agr_provisionmode",correctNull(rs.getString("agr_provisionmode"))); //sel
				hshRecord.put("agr_reason",correctNull(rs.getString("agr_reason")));	 //txtarea
				hshRecord.put("agr_electricity",correctNull(rs.getString("agr_electricity"))); //sel
				hshRecord.put("agr_water_facility",correctNull(rs.getString("agr_water_facility")));
				hshRecord.put("agr_foddersource",correctNull(rs.getString("agr_foddersource")));
				hshRecord.put("agr_veterinaryaid",correctNull(rs.getString("agr_veterinaryaid")));
				hshRecord.put("agr_veterinarydistance",correctNull(rs.getString("agr_veterinarydistance")));
				hshRecord.put("agr_grazefacility",correctNull(rs.getString("agr_grazefacility"))); //sel
				hshRecord.put("agr_grazeforest",correctNull(rs.getString("agr_grazeforest"))); //chk
				hshRecord.put("agr_grazepastureland",correctNull(rs.getString("agr_grazepastureland"))); //chk
				hshRecord.put("agr_grazeownfield",correctNull(rs.getString("agr_grazeownfield"))); //chk
				hshRecord.put("agr_marketsale",correctNull(rs.getString("agr_marketsale")));
				hshRecord.put("agr_marketdistancefrom",correctNull(rs.getString("agr_marketdistancefrom")));
				hshRecord.put("agr_consumer",correctNull(rs.getString("agr_consumer"))); //sel
				hshRecord.put("agr_society",correctNull(rs.getString("agr_society"))); //sel
				hshRecord.put("agr_recovery",correctNull(rs.getString("agr_recovery"))); //sel
				hshRecord.put("agr_recoveryagency",correctNull(rs.getString("agr_recoveryagency")));
				hshRecord.put("agr_animals",correctNull(rs.getString("agr_animals"))); //sel
				hshRecord.put("agr_noofunits",correctNull(rs.getString("agr_noofunits")));
				hshRecord.put("agr_scopefinance",correctNull(rs.getString("agr_scopefinance")));					
				hshRecord.put("agr_equipments",correctNull(rs.getString("agr_equipments"))); //sel
				hshRecord.put("agr_acquisition",correctNull(rs.getString("agr_acquisition")));					
				hshRecord.put("agr_acq_reason",correctNull(rs.getString("agr_acq_reason"))); //sel
				hshRecord.put("agr_borrower",correctNull(rs.getString("agr_borrower")));
				hshRecord.put("sel_ver",correctNull(rs.getString("agr_ver")));
				hshRecord.put("auditFlag", "Y");
			}	
			
		}
		catch(Exception ce)
		{
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
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}	
	
	public void updatediaryfinData(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshRequestValues.get("hidAction");
		String appno=correctNull((String)hshRequestValues.get("appno"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}		
		ResultSet rs = null;
		try
		{			
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agrdiaryfindatadel");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agrdiaryfindatains");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshRequestValues.get("txt_Bet_Batch")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_milkprice")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_gober")));
				String selgober=correctNull((String)hshRequestValues.get("sel_gober"));
				if(selgober.equalsIgnoreCase("1"))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_incomgober")));
				}	
				arrValues.add(correctNull((String)hshRequestValues.get("txt_vetaid")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_elecexp")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_calves")));
				String selcalves=correctNull((String)hshRequestValues.get("sel_calves"));
				if(selcalves.equalsIgnoreCase("2"))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_inccalves")));
				}
				String greenfodder = correctNull((String)hshRequestValues.get("txt_greenfodder"));
				if(greenfodder.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(greenfodder);
				}
				String costgreen = correctNull((String)hshRequestValues.get("txt_costgreen"));
				if(costgreen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(costgreen);
				}
				String expgreen  = correctNull((String)hshRequestValues.get("txt_expgreen"));
				if(expgreen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(expgreen);
				}
				String dryfodder = correctNull((String)hshRequestValues.get("txt_dryfodder"));
				if(dryfodder.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dryfodder);
				}
				String costdry = correctNull((String)hshRequestValues.get("txt_costdry"));
				if(costdry.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(costdry);
				}
				String expdry = correctNull((String)hshRequestValues.get("txt_expdry"));
				if (expdry.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(expdry);
				}
				String concenfeed = correctNull((String)hshRequestValues.get("txt_concenfeed"));
				if(concenfeed.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(concenfeed);
				}
				String costconcen = correctNull((String)hshRequestValues.get("txt_costconcen"));
				if(costconcen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(costconcen);
				}
				String expconcen = correctNull((String)hshRequestValues.get("txt_expconcen"));
				if(expconcen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(expconcen);
				}
				String totcostlact = correctNull((String)hshRequestValues.get("txt_totcostlact"));
				if(totcostlact.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(totcostlact);
				}
				String dgreenfodder = correctNull((String)hshRequestValues.get("txt_dgreenfodder"));
				if(dgreenfodder.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dgreenfodder);
				}
				String dcostgreen = correctNull((String)hshRequestValues.get("txt_dcostgreen"));
				if(dcostgreen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dcostgreen);
				}
				String dexpgreen = correctNull((String)hshRequestValues.get("txt_dexpgreen"));
				if(dexpgreen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dexpgreen);
				}
				String ddryfodder = correctNull((String)hshRequestValues.get("txt_ddryfodder"));
				if(ddryfodder.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(ddryfodder);
				}
				String dcostdry = correctNull((String)hshRequestValues.get("txt_dcostdry"));
				if(dcostdry.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dcostdry);
				}
				String dexpdry = correctNull((String)hshRequestValues.get("txt_dexpdry"));
				if(dexpdry.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dexpdry);
				}
				String dconcenfeed = correctNull((String)hshRequestValues.get("txt_dconcenfeed"));
				if(dconcenfeed.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dconcenfeed);
				}
				String dcostconcen = correctNull((String)hshRequestValues.get("txt_dcostconcen"));
				if(dcostconcen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dcostconcen);
				}
				String dexpconcen = correctNull((String)hshRequestValues.get("txt_dexpconcen"));
				if(dexpconcen.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(dexpconcen);
				}
				String totcostdry = correctNull((String)hshRequestValues.get("txt_totcostdry"));
				if(totcostdry.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(totcostdry);
				}
				if(correctNull((String)hshRequestValues.get("txt_nooflabour")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_nooflabour")));
				}
				if(correctNull((String)hshRequestValues.get("txt_salmonth")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_salmonth")));
				}
				String totexplab = correctNull((String)hshRequestValues.get("txt_totexplab"));
				if(totexplab.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(totexplab);
				}
				if(correctNull((String)hshRequestValues.get("txt_constshed")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_constshed")));
				}
				if(correctNull((String)hshRequestValues.get("txt_constsqrcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_constsqrcost")));
				}	
				if(correctNull((String)hshRequestValues.get("txt_totcostconst")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_totcostconst")));
				}	
				if(correctNull((String)hshRequestValues.get("txt_equip1")).equalsIgnoreCase(""))
				{
					arrValues.add("");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip1")));
				}
						
				if(correctNull((String)hshRequestValues.get("txt_equip1unit")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip1unit")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip1cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip1cost")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip1totcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip1totcost")));
				}
				String equip2 = correctNull((String)hshRequestValues.get("txt_equip2"));
				if(equip2.equalsIgnoreCase(""))
				{
					arrValues.add("");
				}
				else
				{
					arrValues.add(equip2);
				}
				if(correctNull((String)hshRequestValues.get("txt_equip2unit")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip2unit")));
				}				
				if(correctNull((String)hshRequestValues.get("txt_equip2cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip2cost")));
				}	
				if(correctNull((String)hshRequestValues.get("txt_equip2totcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip2totcost")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip3")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip3")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip3unit")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip3unit")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip3cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip3cost")));
				}	
				if(correctNull((String)hshRequestValues.get("txt_equip3totcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip3totcost")));
				}
				String equip4 = correctNull((String)hshRequestValues.get("txt_equip4"));
				if(equip4.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(equip4);
				}
				if(correctNull((String)hshRequestValues.get("txt_equip4unit")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip4unit")));
				}
				if(correctNull((String)hshRequestValues.get("txt_equip4cost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip4cost")));
				}	
				if(correctNull((String)hshRequestValues.get("txt_equip4totcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_equip4totcost")));
				}
				if(correctNull((String)hshRequestValues.get("txt_totequipcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_totequipcost")));
				}
				if(correctNull((String)hshRequestValues.get("txt_inspremium")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_inspremium")));
				}
				if(correctNull((String)hshRequestValues.get("txt_transcost")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_transcost")));
				}
				if(correctNull((String)hshRequestValues.get("txt_otherexp")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_otherexp")));
				}
				if(correctNull((String)hshRequestValues.get("txt_tototherexp")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_tototherexp")));
				}
				arrValues.add(correctNull((String)hshRequestValues.get("sel_workcapital")));
				String selworkcapital=correctNull((String)hshRequestValues.get("sel_workcapital"));
				if(selworkcapital.equalsIgnoreCase("2"))
				{
					arrValues.add("0");
					arrValues.add("0");
					
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_maintcost")));
					arrValues.add(correctNull((String)hshRequestValues.get("txt_feed")));
				}
				if(correctNull((String)hshRequestValues.get("txt_otherincome")).equalsIgnoreCase(""))
				{
					arrValues.add("0.00");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_otherincome")));
				}
				if(correctNull((String)hshRequestValues.get("txt_value")).equalsIgnoreCase(""))
				{
					arrValues.add("0.00");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_value")));
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agrdiaryfindatadel");
				arrValues.add(appno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			
			UpdateDairyData updateDairyData = new UpdateDairyData();
			updateDairyData.updateCattleChartData(hshRequestValues);
			hshRequestValues.put("strCheck","yes"); // this strcheck variable will help us edit apply data
			updateDairyData.updateDataForDairy(hshRequestValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
					.append("~Income Details ^")
					.append("~Sale Price of Milk/litre (Rs) = ").append(correctNull((String)hshRequestValues.get("txt_milkprice")))
					.append("~Gober = ").append(correctNull((String)hshRequestValues.get("sel_gober_text")));
					if(correctNull((String)hshRequestValues.get("sel_gober")).equalsIgnoreCase("2"))
					{
					sbAuditTrial
					.append("~Income from Gober/ Animal / Year (Rs)  = ").append(correctNull((String)hshRequestValues.get("txt_incomgober")));
					}
					sbAuditTrial
					.append("~Other Income per year (Rs.) = ").append(correctNull((String)hshRequestValues.get("txt_otherincome")))
					
					.append("~Expenses Details ^")
					.append("~Expenses on Veterianary Aid / Animal / Year (Rs) = ")	.append(correctNull((String)hshRequestValues.get("txt_vetaid")))
					.append("~Electricity expenses Per Month (Rs) = ")	.append(correctNull((String)hshRequestValues.get("txt_elecexp")))
					.append("~Female Calves = ")	.append(correctNull((String)hshRequestValues.get("sel_calves_text")));
					if(correctNull((String)hshRequestValues.get("sel_calves")).equalsIgnoreCase("1"))
					{
						sbAuditTrial
						.append("~Expense for rearing Female Calves/ Animal / Year (Rs) = ").append(correctNull((String)hshRequestValues.get("txt_inccalves")));
					}
					sbAuditTrial
					.append("~Insurance Premium / Per Animal / Year (Rs) = ")	.append(correctNull((String)hshRequestValues.get("txt_inspremium")))
					.append("~Cost of Transportation per animal (Rs) = ")	.append(correctNull((String)hshRequestValues.get("txt_transcost")))
					.append("~Other Expenses / Animal / Year = ")	.append(correctNull((String)hshRequestValues.get("txt_otherexp")))
					.append("~No of Labourers   = ")	.append(correctNull((String)hshRequestValues.get("txt_nooflabour")))
					.append("~Salary Per Month (Rs)  = ")  	.append(correctNull((String)hshRequestValues.get("txt_salmonth")))
					.append("~Total Expenses on Labour / Month      = ")	.append(correctNull((String)hshRequestValues.get("txt_totexplab")))
					
					.append("~Feeding during Lactation days ^")
					.append("~Green fodder / Animal / Day - KG  = ")	.append(correctNull((String)hshRequestValues.get("txt_greenfodder")))
					.append("~Cost Per KG (Rs)   = ")	.append(correctNull((String)hshRequestValues.get("txt_costgreen")))
					.append("~Total Expenses on Green Fodder  = ")      	.append(correctNull((String)hshRequestValues.get("txt_expgreen")))
					
					.append("~Dry fodder / Animal / Day - KG  = ")	.append(correctNull((String)hshRequestValues.get("txt_dryfodder")))
					.append("~Cost Per KG (Rs)   = ")	.append(correctNull((String)hshRequestValues.get("txt_costdry")))
					.append("~Total Expenses on Dry Fodder        = ")	.append(correctNull((String)hshRequestValues.get("txt_expdry")))
					
					.append("~Concentrate feed / Animal / Day - KG   = ")	.append(correctNull((String)hshRequestValues.get("txt_concenfeed")))
					.append("~Cost Per KG (Rs)    = ")	.append(correctNull((String)hshRequestValues.get("txt_costconcen")))
					.append("~Total Expenses on Conc Feed    = ")	.append(correctNull((String)hshRequestValues.get("txt_expconcen")))
					
					.append("~Feeding during Dry days ^")
					.append("~Green fodder / Animal / Day - KG  = ")	.append(correctNull((String)hshRequestValues.get("txt_dgreenfodder")))
					.append("~Cost Per KG = ")	.append(correctNull((String)hshRequestValues.get("txt_dcostgreen")))
					.append("~Total Expenses on Green Fodder = ")	.append(correctNull((String)hshRequestValues.get("txt_dexpgreen")))
					
					.append("~Dry fodder / Animal / Day - KG  = ")	.append(correctNull((String)hshRequestValues.get("txt_ddryfodder")))
					.append("~Cost Per KG   = ")	.append(correctNull((String)hshRequestValues.get("txt_dcostdry")))
					.append("~Total Expenses on Dry Fodder = ")	.append(correctNull((String)hshRequestValues.get("txt_dexpdry")))
					
					.append("~Concentrate feed / Animal / Day - KG   = ")	.append(correctNull((String)hshRequestValues.get("txt_dconcenfeed")))
					.append("~Cost Per KG  = ")	.append(correctNull((String)hshRequestValues.get("txt_dcostconcen")))
					.append("~Total Expenses on Conc Feed    = ")	.append(correctNull((String)hshRequestValues.get("txt_dexpconcen")))
					
					.append("~Value of one animal at the end of project (Average of culled & young) = ")	.append(correctNull((String)hshRequestValues.get("txt_value")))
					
					.append("~Loan Particulars ^")
					.append("~Shed Details ^")
					
					.append("~Construction of Shed (Total Area - Sq ft)   = ")	.append(correctNull((String)hshRequestValues.get("txt_constshed")))
					.append("~Cost Per Sq ft (Rs)  = ")	.append(correctNull((String)hshRequestValues.get("txt_constsqrcost")))
					.append("~Total Cost of Construction  = ")	.append(correctNull((String)hshRequestValues.get("txt_totcostconst")))
					
					.append("~Equipment Details ^")
					.append("~Equipment Specify (1)  = ")	.append(correctNull((String)hshRequestValues.get("txt_equip1")))
					.append("~No of Units   = ")	.append(correctNull((String)hshRequestValues.get("txt_equip1unit")))
					.append("~Cost Per Unit (Rs) = ")	.append(correctNull((String)hshRequestValues.get("txt_equip1cost")))
					.append("~Total Cost       = ")	.append(correctNull((String)hshRequestValues.get("txt_equip1totcost")))
					
					.append("~Equipment Specify (2)   = ")	.append(correctNull((String)hshRequestValues.get("txt_equip2")))
					.append("~No of Units   = ")	.append(correctNull((String)hshRequestValues.get("txt_equip2unit")))
					.append("~Cost Per Unit (Rs) = ")  	.append(correctNull((String)hshRequestValues.get("txt_equip2cost")))
					.append("~Total Cost        = ")	.append(correctNull((String)hshRequestValues.get("txt_equip2totcost")))
					
					.append("~Equipment Specify (3)  = ") 	.append(correctNull((String)hshRequestValues.get("txt_equip3")))
					.append("~No of Units  = ")	.append(correctNull((String)hshRequestValues.get("txt_equip3unit")))
					.append("~Cost Per Unit (Rs)   = ")	.append(correctNull((String)hshRequestValues.get("txt_equip3cost")))
					.append("~Total Cost       = ")	.append(correctNull((String)hshRequestValues.get("txt_equip3totcost")))
					
					.append("~Equipment Specify (4) = ")	.append(correctNull((String)hshRequestValues.get("txt_equip4unit")))
					.append("~No of Units  = ")	.append(correctNull((String)hshRequestValues.get("txt_equip4cost")))
					.append("~Cost Per Unit (Rs)  = ")	.append(correctNull((String)hshRequestValues.get("txt_equip4totcost")))
					.append("~Total Cost        = ")	.append(correctNull((String)hshRequestValues.get("txt_equip4totcost")))
					
					.append("~Animal Details ^")
					.append("~Animal Cost (I Batch) = ")	.append(correctNull((String)hshRequestValues.get("txt_icost")))
					.append("~No of Animals    = ")	.append(correctNull((String)hshRequestValues.get("txt_ino")))
					.append("~Total Cost    = ")	.append(correctNull((String)hshRequestValues.get("txt_itotcost")))
					
					.append("~Animal Cost (II Batch) = ")	.append(correctNull((String)hshRequestValues.get("txt_iicost")))
					.append("~No of Animals    = ")	.append(correctNull((String)hshRequestValues.get("txt_iino")))
					.append("~Total Cost   = ")	.append(correctNull((String)hshRequestValues.get("txt_iitotcost")))
					
					.append("~Working Capital Requirement(if required)= ")	.append(correctNull((String)hshRequestValues.get("sel_workcapital_text")));
					if(correctNull((String)hshRequestValues.get("sel_workcapital_text")).equalsIgnoreCase("Required"))
					{
						sbAuditTrial
						.append("~Cost of Maintenance(No of Months) = ")	.append(correctNull((String)hshRequestValues.get("txt_maintcost")))
						.append("  ")
						.append("~Feeding Cost")
						.append("  ")
						.append(correctNull((String)hshRequestValues.get("txt_feed")))
						.append("    ")
						.append("(Cost of Maintenance in Days) x (First Batch No of Animals) x (To Cost of Feeding Laction Days)");
					}		
					if(correctNull((String)hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
					{
						hshRequestValues.put("strAction", "update");
					}
					else
					{
						hshRequestValues.put("strAction", "insert");
					}
			}
			AuditTrial.auditLog(hshRequestValues,"240",appno,sbAuditTrial.toString());
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
		
	public  HashMap getdiaryfinData(HashMap hshValues) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		long totnoofanimal=0;
		long totnoofanimals=0;
		
		
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null"))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrdiaryfindatasel^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("Bet_Batch",correctNull(rs.getString("Bet_Batch")));
				hshRecord.put("milkprice",correctNull(rs.getString("milkprice")));
				hshRecord.put("sel_gober",correctNull(rs.getString("sel_gober")));
				hshRecord.put("incomgober",correctNull(rs.getString("incomgober")));
				hshRecord.put("vetaid",correctNull(rs.getString("vetaid")));
				hshRecord.put("elecexp",correctNull(rs.getString("elecexp")));
				hshRecord.put("sel_calves",correctNull(rs.getString("sel_calves")));
				hshRecord.put("inccalves",correctNull(rs.getString("inccalves")));
				hshRecord.put("greenfodder",correctNull(rs.getString("greenfodder")));
				hshRecord.put("costgreen",correctNull(rs.getString("costgreen")));
				hshRecord.put("expgreen",correctNull(rs.getString("expgreen")));
				hshRecord.put("dryfodder",correctNull(rs.getString("dryfodder")));
				hshRecord.put("costdry",correctNull(rs.getString("costdry")));
				hshRecord.put("expdry",correctNull(rs.getString("expdry")));
				hshRecord.put("concenfeed",correctNull(rs.getString("concenfeed")));
				hshRecord.put("costconcen",correctNull(rs.getString("costconcen")));
				hshRecord.put("expconcen",correctNull(rs.getString("expconcen")));
				hshRecord.put("totcostlact",correctNull(rs.getString("totcostlact")));
				hshRecord.put("dgreenfodder",correctNull(rs.getString("dgreenfodder")));
				hshRecord.put("dcostgreen",correctNull(rs.getString("dcostgreen")));
				hshRecord.put("dexpgreen",correctNull(rs.getString("dexpgreen")));
				hshRecord.put("ddryfodder",correctNull(rs.getString("ddryfodder")));
				hshRecord.put("dcostdry",correctNull(rs.getString("dcostdry")));
				hshRecord.put("dexpdry",correctNull(rs.getString("dexpdry")));
				hshRecord.put("dconcenfeed",correctNull(rs.getString("dconcenfeed")));
				hshRecord.put("dcostconcen",correctNull(rs.getString("dcostconcen")));
				hshRecord.put("dexpconcen",correctNull(rs.getString("dexpconcen")));
				hshRecord.put("totcostdry",correctNull(rs.getString("totcostdry")));
				hshRecord.put("nooflabour",correctNull(rs.getString("nooflabour")));
				hshRecord.put("salmonth",correctNull(rs.getString("salmonth")));
				hshRecord.put("totexplab",correctNull(rs.getString("totexplab")));
				hshRecord.put("constshed",correctNull(rs.getString("constshed")));
				hshRecord.put("constsqrcost",correctNull(rs.getString("constsqrcost")));
				hshRecord.put("totcostconst",correctNull(rs.getString("totcostconst")));
				hshRecord.put("equip1",correctNull(rs.getString("equip1")));
				hshRecord.put("equip1unit",correctNull(rs.getString("equip1unit")));
				hshRecord.put("equip1cost",correctNull(rs.getString("equip1cost")));
				hshRecord.put("equip1totcost",correctNull(rs.getString("equip1totcost")));
				hshRecord.put("equip2",correctNull(rs.getString("equip2")));
				hshRecord.put("equip2unit",correctNull(rs.getString("equip2unit")));
				hshRecord.put("equip2cost",correctNull(rs.getString("equip2cost")));
				hshRecord.put("equip2totcost",correctNull(rs.getString("equip2totcost")));
				hshRecord.put("equip3",correctNull(rs.getString("equip3")));
				hshRecord.put("equip3unit",correctNull(rs.getString("equip3unit")));
				hshRecord.put("equip3cost",correctNull(rs.getString("equip3cost")));
				hshRecord.put("equip3totcost",correctNull(rs.getString("equip3totcost")));
				hshRecord.put("equip4",correctNull(rs.getString("equip4")));
				hshRecord.put("equip4unit",correctNull(rs.getString("equip4unit")));
				hshRecord.put("equip4cost",correctNull(rs.getString("equip4cost")));
				hshRecord.put("equip4totcost",correctNull(rs.getString("equip4totcost")));
				hshRecord.put("totequipcost",correctNull(rs.getString("totequipcost")));
				hshRecord.put("inspremium",correctNull(rs.getString("inspremium")));
				hshRecord.put("transcost",correctNull(rs.getString("transcost")));
				hshRecord.put("otherexp",correctNull(rs.getString("otherexp")));
				hshRecord.put("tototherexp",correctNull(rs.getString("tototherexp")));
				hshRecord.put("sel_workcapital",correctNull(rs.getString("sel_workcapital")));
				hshRecord.put("maintcost",correctNull(rs.getString("maintcost")));
				hshRecord.put("feed",correctNull(rs.getString("feed")));
				hshRecord.put("otherincome",correctNull(rs.getString("otherincome")));
				hshRecord.put("txt_value",correctNull(rs.getString("value_animal")));
				hshRecord.put("auditFlag", "Y");
			}		
			
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arrRow = new ArrayList();
			while (rs.next()) 
			{
				ArrayList arrData = new ArrayList();
				arrData.add(correctNull(rs.getString("agr_milchcattle")));
				if(correctNull(rs.getString("agr_avg_milk")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_avg_milk")));
				if(correctNull(rs.getString("agr_noanimals")).equalsIgnoreCase("0"))
				{
					arrData.add("");
					totnoofanimal=totnoofanimal+0;
				}
				else
				{
					arrData.add(correctNull(rs.getString("agr_noanimals")));
					totnoofanimal=totnoofanimal+Integer.parseInt(Helper.correctDouble((String)rs.getString("agr_noanimals")));
				}
				if(correctNull(rs.getString("agr_costanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_costanimals")));
				if(correctNull(rs.getString("agr_totalcost")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_totalcost")));
				arrData.add(correctNull(rs.getString("agr_batch")));
				arrRow.add(arrData);
			}
			hshRecord.put("totnoofanimals",Integer.toString((int)totnoofanimals));
			hshRecord.put("arrstockdetails", arrRow);
//================================== Find out the I Batch no of Animal in Live Stock ==============================
			
			strQuery = SQLParser.getSqlQuery("agr_livestockIbatnoanimal^" + appno);
			rs = DBUtils.executeQuery(strQuery);
		
			if(rs.next()) 
			{
				hshRecord.put("totnoofIBatanimals", correctNull((String)rs.getString("agr_noanimals")));
			}


				
		}
		catch(Exception ce)
		{
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
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}	
		
	public void updatecroptermData(HashMap hshRequestValues) 
	{
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		String appno=correctNull((String)hshRequestValues.get("appno"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshValues= new HashMap();
		ArrayList arrValues = new ArrayList();		
		String[] stockpart = null;
		String[] noofanimal = null;
		String[] costanimal = null;
		String[] workcap = null;
		String[] estimcost = null;
		String[] margin = null;
		String[] gross = null;
		String[] totexp = null;
		String[] pstockpart = null;
		String[] pnoofanimal = null;
		String[] pcostanimal = null;
		String[] pworkcap = null;
		String[] pestimcost = null;
		String[] pmargin = null;
		String[] pgross = null;
		String[] ptotexp = null;
		String[] fstockpart = null;
		String[] farea = null;
		String[] fesmcost = null;
		String[] fmargin = null;
		String[] fgrossinc = null;
		String[] ftotexpend = null;
		String[] ostockpart = null;
		String[] odimension = null;
		String[] ovolume = null;
		String[] oestimate = null;
		String[] omargin = null;
		String[] ogrossinc = null;
		String[] ototexp = null;
		String totestimation="";
		String totmargin="";
		String roiTL="";
		String repayTL="";String sel_payment="",txt_holiday="",txt_installment="",txt_date="";
		
				
		ResultSet rs = null;
		int intUpdatesize = 0;
		try
		{	
			
			if(appno.equalsIgnoreCase(""))
			{
				appno=correctNull((String)hshRequestValues.get("strappno"));
			}
			//Live Stock 
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno=correctNull((String)hshValues.get("strappno"));
			}	
			
			stockpart = (String[]) hshRequestValues.get("txt_stockpart");
			noofanimal = (String[])hshRequestValues.get("txt_noofanimal");
			costanimal = (String[])hshRequestValues.get("txt_costanimal");
			workcap = (String[])hshRequestValues.get("txt_workcap");
			estimcost = (String[])hshRequestValues.get("txt_estimcost");
			margin = (String[])hshRequestValues.get("txt_margin");
			gross = (String[])hshRequestValues.get("txt_gross");
			totexp = (String[])hshRequestValues.get("txt_totexp");
			
			//Poultry
			
			pstockpart = (String[])hshRequestValues.get("txt_pstockpart");
			pnoofanimal = (String[])hshRequestValues.get("txt_pnoofanimal");
			pcostanimal = (String[])hshRequestValues.get("txt_pcostanimal");
			pworkcap = (String[])hshRequestValues.get("txt_pworkcap");
			pestimcost = (String[])hshRequestValues.get("txt_pestimcost");
			pmargin = (String[])hshRequestValues.get("txt_pmargin");
			pgross = (String[])hshRequestValues.get("txt_pgross");
			ptotexp = (String[])hshRequestValues.get("txt_ptotexp");
			
			totestimation = correctNull((String)hshRequestValues.get("txt_ptotalestimate"));
			totmargin = correctNull((String)hshRequestValues.get("txt_ptotalmargin"));
			
			roiTL= correctNull((String)hshRequestValues.get("txt_roiTL"));
			if(roiTL.equalsIgnoreCase(""))
			{
				roiTL="0.00";
			}
			repayTL= correctNull((String)hshRequestValues.get("txt_repayTL"));
			if(repayTL.equalsIgnoreCase(""))
			{
				repayTL="0.00";
			}
			txt_installment= correctNull((String)hshRequestValues.get("txt_installment"));
			if(txt_installment.equalsIgnoreCase(""))
			{
				txt_installment="0.00";
			}
			txt_date= correctNull((String)hshRequestValues.get("txt_date"));
			if(txt_date.equalsIgnoreCase(""))
			{
				txt_date="01/01/1900";
			}
			txt_holiday= correctNull((String)hshRequestValues.get("txt_holiday"));
			if(txt_holiday.equalsIgnoreCase(""))
			{
				txt_holiday="0";
			}
			sel_payment= correctNull((String)hshRequestValues.get("sel_payment"));
			if(sel_payment.equalsIgnoreCase(""))
			{
				sel_payment="0";
			}
			//Farm Machinery
			
			fstockpart = (String[])hshRequestValues.get("txt_fstockpart");
			farea = (String[])hshRequestValues.get("txt_farea");
			fesmcost = (String[])hshRequestValues.get("txt_fesmcost");
			fmargin = (String[])hshRequestValues.get("txt_fmargin");
			fgrossinc = (String[])hshRequestValues.get("txt_fgrossinc");
			ftotexpend = (String[])hshRequestValues.get("txt_ftotexpend");
			
			//Farm House / Shed / Godown / Barn 
			
			ostockpart = (String[])hshRequestValues.get("txt_ostockpart");
			odimension= (String[])hshRequestValues.get("txt_odimension");
			ovolume = (String[])hshRequestValues.get("txt_ovolume");
			oestimate = (String[])hshRequestValues.get("txt_oestimate");
			omargin = (String[])hshRequestValues.get("txt_omargin");
			ogrossinc = (String[])hshRequestValues.get("txt_ogrossinc");
			ototexp = (String[])hshRequestValues.get("txt_ototexp");
			
			//LiveStock
			
			if(!strAction.equalsIgnoreCase("delete")){		
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_agr_termloans");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			
			int j = 1;
			intUpdatesize = 1;
			for (int i = 0; i < stockpart.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_agr_termloans");
				arrValues.add(appno);
				if(stockpart[i].equalsIgnoreCase(""))
				{
					stockpart[i] = "0.00";
				}
				arrValues.add(stockpart[i]);
				if(noofanimal[i].equalsIgnoreCase(""))
				{
					noofanimal[i] = "0.00";
				}
				arrValues.add(noofanimal[i]);
				if(costanimal[i].equalsIgnoreCase(""))
				{
					costanimal[i] = "0.00";
				}
				arrValues.add(costanimal[i]);
				if(workcap[i].equalsIgnoreCase(""))
				{
					workcap[i] = "0.00";
				}
				arrValues.add(workcap[i]);
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("0.00");
				if(estimcost[i].equalsIgnoreCase(""))
				{
					estimcost[i] = "0.00";
				}				
				arrValues.add(estimcost[i]);
				if(margin[i].equalsIgnoreCase(""))
				{
					margin[i] = "0.00";
				}
				arrValues.add(margin[i]);
				if(gross[i].equalsIgnoreCase(""))
				{
					gross[i] = "0.00";
				}
				arrValues.add(gross[i]);
				if(totexp[i].equalsIgnoreCase(""))
				{
					totexp[i] = "0.00";
				}
				arrValues.add(totexp[i]);
				arrValues.add("LiveStock");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				arrValues.add(Integer.toString(j));
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				j++;
			}
			
			//Poultry
			
			intUpdatesize = 1;
			for (int i = 0; i < pstockpart.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_agr_termloans");
				arrValues.add(appno);
				if(pstockpart[i].equalsIgnoreCase(""))
				{
					pstockpart[i] = "0.00";
				}
				arrValues.add(pstockpart[i]);
				if(pnoofanimal[i].equalsIgnoreCase(""))
				{
					pnoofanimal[i] = "0.00";
				}
				arrValues.add(pnoofanimal[i]);
				if(pcostanimal[i].equalsIgnoreCase(""))
				{
					pcostanimal[i] = "0.00";
				}
				arrValues.add(pcostanimal[i]);
				if(pworkcap[i].equalsIgnoreCase(""))
				{
					pworkcap[i] = "0.00";
				}
				arrValues.add(pworkcap[i]);
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("0.00");
				if(pestimcost[i].equalsIgnoreCase(""))
				{
					pestimcost[i] = "0.00";
				}
				arrValues.add(pestimcost[i]);
				if(pmargin[i].equalsIgnoreCase(""))
				{
					pmargin[i] = "0.00";
				}
				arrValues.add(pmargin[i]);
				if(pgross[i].equalsIgnoreCase(""))
				{
					pgross[i] = "0.00";
				}
				arrValues.add(pgross[i]);
				if(ptotexp[i].equalsIgnoreCase(""))
				{
					ptotexp[i] = "0.00";
				}
				arrValues.add(ptotexp[i]);
				arrValues.add("Poultry");
				if(totestimation.equalsIgnoreCase(""))
				{
					totestimation="0.00";
				}
				arrValues.add(totestimation);
				
				if(totmargin.equalsIgnoreCase(""))
				{
					totmargin="0.00";
				}
				arrValues.add(totmargin);
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				arrValues.add(Integer.toString(j));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				j++;
			}
			
			//FarmMachinery
			
			intUpdatesize = 1;
			for (int i = 0; i < fstockpart.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_agr_termloans");
				arrValues.add(appno);
				if(fstockpart[i].equalsIgnoreCase(""))
				{
					fstockpart[i] = "0.00";
				}
				arrValues.add(fstockpart[i]);				
				arrValues.add("0.00");				
				arrValues.add("0.00");
				arrValues.add("0.00");
				if(farea[i].equalsIgnoreCase(""))
				{
					farea[i] = "0.00";
				}
				arrValues.add(farea[i]);
				arrValues.add("0.00");
				arrValues.add("0.00");
				if(fesmcost[i].equalsIgnoreCase(""))
				{
					fesmcost[i] = "0.00";
				}
				arrValues.add(fesmcost[i]);
				if(fmargin[i].equalsIgnoreCase(""))
				{
					fmargin[i] = "0.00";
				}
				arrValues.add(fmargin[i]);
				if(fgrossinc[i].equalsIgnoreCase(""))
				{
					fgrossinc[i] = "0.00";
				}
				arrValues.add(fgrossinc[i]);
				if(ftotexpend[i].equalsIgnoreCase(""))
				{
					ftotexpend[i] = "0.00";
				}
				arrValues.add(ftotexpend[i]);				
				arrValues.add("FarmMachinery");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				arrValues.add(Integer.toString(j));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				j++;
			}
			
			//Farm House / Shed / Godown / Barn 
				
			intUpdatesize = 1;
			for (int i = 0; i < ostockpart.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_agr_termloans");
				arrValues.add(appno);
				if(ostockpart[i].equalsIgnoreCase(""))
				{
					ostockpart[i] = "0.00";
				}
				arrValues.add(ostockpart[i]);				
				arrValues.add("0.00");				
				arrValues.add("0.00");
				arrValues.add("0.00");				
				arrValues.add("0.00");
				if(odimension[i].equalsIgnoreCase(""))
				{
					odimension[i] = "0.00";
				}
				arrValues.add(odimension[i]);
				if(ovolume[i].equalsIgnoreCase(""))
				{
					ovolume[i] = "0.00";
				}
				arrValues.add(ovolume[i]);
				if(oestimate[i].equalsIgnoreCase(""))
				{
					oestimate[i] = "0.00";
				}
				arrValues.add(oestimate[i]);
				if(omargin[i].equalsIgnoreCase(""))
				{
					omargin[i] = "0.00";
				}
				arrValues.add(omargin[i]);
				if(ogrossinc[i].equalsIgnoreCase(""))
				{
					ogrossinc[i] = "0.00";
				}
				arrValues.add(ogrossinc[i]);
				if(ototexp[i].equalsIgnoreCase(""))
				{
					ototexp[i] = "0.00";
				}
				arrValues.add(ototexp[i]);				
				arrValues.add("Farm House");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				arrValues.add(Integer.toString(j));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				j++;
			}
			/*if (strAction.equals("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_termdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_termdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			}
			if (strAction.equals("delete"))
			{
					
				 HashMap hshQuery3 = new HashMap();
				 ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_agr_termloans");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			/*if (strAction.equals("delete"))
			{
					
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "agr_del_termdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}*/
			//Update Product margin
			updateProductMargin(hshRequestValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
				
			
			sbAuditTrial.append("~Live Stock ^");
			for (int i = 0; i < stockpart.length; i++)
			{	
				
				sbAuditTrial.append("~Live Stock Particulars = ").append(correctNull(stockpart[i])).append("~No of Animal = ").append(correctNull(noofanimal[i]))
				.append("~Cost per Animal(Rs.) = ").append(correctNull(costanimal[i]))
				.append("~Working Capital (Feed + Vet.Care+Ins)(Rs.) = ").append(correctNull(workcap[i]))
				.append("~Estimated Cost (Rs.) = ").append(correctNull(estimcost[i]))
				.append("~Margin Money (Rs.) = ").append(correctNull(margin[i]))
				.append("~Income (Monthly)(Rs.) = ").append(correctNull(gross[i]))
				.append("~Expenses (Monthly)(Rs.) = ").append(correctNull(totexp[i]));
			}	
			
					
			sbAuditTrial.append("~Poultry ^");
			for (int i = 0; i < pstockpart.length; i++)
			{	
				
				sbAuditTrial.append("~Particulars = ").append(correctNull(pstockpart[i])).append("~No of Birds = ").append(correctNull(pnoofanimal[i]))
				.append("~Cost per Bird(Rs.) = ").append(correctNull(pcostanimal[i]))
				.append("~Working Capital (Feed + Vet.Care+Ins)(Rs.) = ").append(correctNull(pworkcap[i]))
				.append("~Estimated Cost (Rs.) = ").append(correctNull(pestimcost[i]))
				.append("~Margin Money (Rs.) = ").append(correctNull(pmargin[i]))
				.append("~Income (Monthly)(Rs.) = ").append(correctNull(pgross[i]))
				.append("~Expenses (Monthly)(Rs.) = ").append(correctNull(ptotexp[i]));
			}
			
			sbAuditTrial.append("~Farm Machinery (Power Tiller/Pump Set/Sprinkler/Etc. ^");
			for (int i = 0; i < fstockpart.length; i++)
			{	
				
				sbAuditTrial.append("~Particulars = ").append(correctNull(fstockpart[i])).append("~Area Benefited (Own + Other lands) = ").append(correctNull(farea[i]))
				.append("~Estimated Cost (Rs.) = ").append(correctNull(fesmcost[i]))
				.append("~Margin Money (Rs.) = ").append(correctNull(fmargin[i]))
				.append("~Gross Income (Monthly)(Rs.) = ").append(correctNull(fgrossinc[i]))
				.append("~Total Expenditure (Monthly)(Rs.) = ").append(correctNull(ftotexpend[i]));
			}	
			
			sbAuditTrial.append("~Farm House/Shed/Godown/Barn/Well digging/Deepening/Fencing/Binding/Land Development / Etc ^");
			for (int i = 0; i < ostockpart.length; i++)
			{	
				
				sbAuditTrial.append("~Particulars = ").append(correctNull(ostockpart[i])).append("~Total Dimension (L X B)  = ").append(correctNull(odimension[i]))
				.append("~Total Volume (L X B X H) = ").append(correctNull(ovolume[i]))
				.append("~Estimated Cost (Rs.) = ").append(correctNull(oestimate[i]))
				.append("~Margin Money (Rs.) = ").append(correctNull(omargin[i]))
				.append("~Gross Income (Monthly)(Rs.) = ").append(correctNull(ogrossinc[i]))
				.append("~Total Expenditure (Monthly)(Rs.) = ").append(correctNull(ototexp[i]));
			}	
				
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}else{
				hshValues.put("strAction", "insert");
			}
				
			}
			AuditTrial.auditLog(hshRequestValues,"222",appno,sbAuditTrial.toString());
			
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

	
	public  HashMap getcroptermData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		ResultSet rs2 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		String sel_payment="";
		String recordflag="N";
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("select_product_margin^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				
				hshRecord.put("appno",correctNull(rs.getString("appno")));	
				hshRecord.put("live_margin",correctNull(rs.getString("live_margin")));
				hshRecord.put("poultry_margin",correctNull(rs.getString("poultry_margin")));
				hshRecord.put("machinary_margin",correctNull(rs.getString("machinary_margin")));
				hshRecord.put("other_margin",correctNull(rs.getString("other_margin")));
				
			}
			strQuery = SQLParser.getSqlQuery("sel_agr_termloans^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate == true)
			{
				while(rs.next())
				{
					recordflag="Y";
					vecRow = new ArrayList();
					vecRow.add(correctNull((String)rs.getString("appno")));
					vecRow.add(correctNull((String)rs.getString("slno")));
					if(correctNull((String)rs.getString("agr_particulars")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_particulars")));
					}
					if(correctNull((String)rs.getString("agr_animal")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_animal")));
					}
					if(correctNull((String)rs.getString("agr_costperanimal")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_costperanimal")));
					}
					if(correctNull((String)rs.getString("agr_workingcapital")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_workingcapital")));
					}
					if(correctNull((String)rs.getString("agr_areabenefit")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_areabenefit")));
					}
					if(correctNull((String)rs.getString("agr_dimention")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_dimention")));
					}
					if(correctNull((String)rs.getString("agr_volume")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_volume")));
					}
					if(correctNull((String)rs.getString("agr_estimatedcost")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_estimatedcost")));
					}
					if(correctNull((String)rs.getString("agr_margin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_margin")));
					}
					if(correctNull((String)rs.getString("agr_grossincome")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_grossincome")));
					}
					if(correctNull((String)rs.getString("agr_totalexpenditure")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_totalexpenditure")));
					}
					vecRow.add(correctNull((String)rs.getString("agr_termtype")));
					
					if(correctNull((String)rs.getString("agr_totestimate")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_totestimate")));
					}
					if(correctNull((String)rs.getString("agr_totmargin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_totmargin")));
					}
					
		//==================agr_roiTL, agr_repayTL
					if(correctNull((String)rs.getString("agr_roiTL")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_roiTL")));
					}
					
					if(correctNull((String)rs.getString("agr_repayTL")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_repayTL")));
					}
					if(correctNull((String)rs.getString("agr_payment")).equalsIgnoreCase("0"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_payment")));
					}
					 sel_payment	= correctNull((String)rs.getString("agr_payment"));	
					
					if(correctNull((String)rs.getString("agr_installment")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_installment")));
					}
										
					if(correctNull((String)rs.getString("agr_date")).equalsIgnoreCase("01/01/1900"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_date")));
					}
					if(correctNull((String)rs.getString("agr_holiday")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("agr_holiday")));
					}
					vecData.add(vecRow);
				}
			}
			else
			{
				for(int i=0; i<16; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
			 // ====================For find out the Gross income and Expenses per month from agr_termsloan.jsp===================
						
			strQuery = SQLParser.getSqlQuery("sel_agr_termloans^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			String grossmon=null;
			String expenses=null;
			String estimated = "";
			String marg="";
			double temp1=0;
			double temp2=0;
			double temp3=0;
			double temp4=0;
			double temp5=0;
			double temptotmar=0;
			double tempest=0;
			double tempmar=0;
			bstate = rs1.next();
			ArrayList grossExp = null;
			ArrayList grossExpRow = new ArrayList();
			if(bstate == true)
			{
				while(rs.next())
				{
					temp1=0;
					temp2=0;
					temp3=0;
					temp4=0;
					grossExp = new ArrayList();
					grossmon = correctNull((String)rs.getString("agr_grossincome"));
					expenses = correctNull((String)rs.getString("agr_totalexpenditure"));
					if(grossmon.equalsIgnoreCase(""))
					{
						grossmon="0.00";
					}
					if(expenses.equalsIgnoreCase(""))
					{
						expenses="0.00";
					}
					temp1= Double.parseDouble(Helper.correctDouble((String)grossmon)) * 12 ;
					temp2=Double.parseDouble(Helper.correctDouble((String)expenses)) * 12;
					temp3=(temp1)-(temp2);

					estimated = correctNull((String)rs.getString("agr_estimatedcost"));
					if(estimated.equalsIgnoreCase(""))
					{
						estimated = "0.00";
					}
					tempest=Double.parseDouble(Helper.correctDouble((String)estimated));
					
					marg = correctNull((String)rs.getString("agr_margin"));
					if(marg.equalsIgnoreCase(""))
					{
						marg = "0.00";
					}
					tempmar=Double.parseDouble(Helper.correctDouble((String)marg));
					temp4 = tempest - tempmar;
					temp5 = temp5 + temp4;
					temptotmar = temptotmar + tempmar; 
															
					grossExp.add(new Double(temp1));
					grossExp.add(new Double(temp2));
					grossExp.add(new Double(temp3)); 
					grossExp.add(new Double(temp4));
					grossExpRow.add(grossExp);
				}
			}
			else
			{
				for(int i=0;i<14;i++)
				{	
					grossExp = new ArrayList();
					grossExp.add(new Double(temp1));
					grossExp.add(new Double(temp2));
					grossExp.add(new Double(temp3)); 
					grossExp.add(new Double(temp4)); 
					grossExpRow.add(grossExp);
				}
			}
			hshRecord.put("grossExpRow", grossExpRow);
			hshRecord.put("vecData", vecData);
			hshRecord.put("totloanamt",Helper.formatDoubleValue(temp5));
			hshRecord.put("totmaramt", Helper.formatDoubleValue(temptotmar));
			hshRecord.put("sel_payment", sel_payment);
			
			/*if(rs != null)
			{
				rs.close();
			}
                          strQuery = SQLParser.getSqlQuery("agr_sel_termdata^"+appno);
				rs2= DBUtils.executeQuery(strQuery);
				String txt_date="";
				if (rs2.next()) 
				{
					hshRecord.put("txt_roiTL", Helper.correctDoubleQuote(correctNull(rs2.getString("agr_roiTL"))));
					hshRecord.put("txt_repayTL", Helper.correctDoubleQuote(correctNull(rs2.getString("agr_repayTL"))));
					hshRecord.put("txt_payment", Helper.correctDoubleQuote(correctNull(rs2.getString("agr_payment"))));
					hshRecord.put("txt_installment", Helper.correctDoubleQuote(correctNull(rs2.getString("agr_installment"))));
					
					txt_date=correctNull((String)rs2.getString("agr_date"));
					if(txt_date.equalsIgnoreCase("01/01/1900"))
					{
						txt_date="";
					}
					else
					{
					
					txt_date=Helper.correctDoubleQuote(correctNull(rs2.getString("agr_date")));
						}

					hshRecord.put("agr_date", txt_date);
			
					hshRecord.put("txt_holiday", Helper.correctDoubleQuote(correctNull(rs2.getString("agr_holiday"))));
					
			     	}
				
					 if (rs2 != null)
					    {
						rs2.close();
					    }*/
			hshRecord.put("recordflag",recordflag);
					
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}	
				if (rs1 != null) 
				{
					rs1.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}


public void updatecroptermassData(HashMap hshRequestValues) 
	{
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		String appno=correctNull((String)hshRequestValues.get("appno"));
		String strappno=correctNull((String)hshRequestValues.get("strappno"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		
		String roiTL="";
		String repayTL="";String sel_payment="",txt_holiday="",txt_installment="",txt_date="";
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		try
		{		
			
			roiTL= correctNull((String)hshRequestValues.get("txt_roiTL"));
			if(roiTL.equalsIgnoreCase(""))
			{
				roiTL="0.00";
			}
			repayTL= correctNull((String)hshRequestValues.get("txt_repayTL"));
			if(repayTL.equalsIgnoreCase(""))
			{
				repayTL="0.00";
			}
			txt_installment= correctNull((String)hshRequestValues.get("txt_installment"));
			if(txt_installment.equalsIgnoreCase(""))
			{
				txt_installment="0.00";
			}
			txt_date= correctNull((String)hshRequestValues.get("txt_date"));
			if(txt_date.equalsIgnoreCase(""))
			{
				txt_date="01/01/1900";
			}
			txt_holiday= correctNull((String)hshRequestValues.get("txt_holiday"));
			if(txt_holiday.equalsIgnoreCase(""))
			{
				txt_holiday="0";
			}
			sel_payment= correctNull((String)hshRequestValues.get("sel_payment"));
			if(sel_payment.equalsIgnoreCase(""))
			{
				sel_payment="0";
			}
			
			
			if (strAction.equals("delete"))
			{
				
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "agr_del_termdata");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
				
			
			if (strAction.equals("insert"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_termdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(roiTL);
				arrValues.add(repayTL);
				arrValues.add(sel_payment);
				arrValues.add(txt_installment);
				arrValues.add(txt_date);
				arrValues.add(txt_holiday);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_termdata");
				hshQueryValues.put("2", hshQuery);
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
			

public void updatecashflowData(HashMap hshRequestValues) 
{
	String strAppno="";
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();		
	String[] loanamt = null;
	String[] intrate = null;
	String[] netinc = null;
	String[] principal = null;
	String[] netintamt = null;
	String[] outgoingamt = null;
	String[] surplusamt = null;
	String[] repayment = null;
	String[] txt_taxdec = null;
	String[] txt_aftertax= null;
	String[] txt_depri = null;
	String[] txt_dscr= null;
	
	String strAction="";
	String strQuery="";
	String strProductType="";
	
	ResultSet rs = null;
	
	int intUpdatesize = 0;
	try
	{	
		strAppno=correctNull((String)hshRequestValues.get("appno"));
		 
		if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
		{
			strAppno=correctNull((String)hshRequestValues.get("strappno"));
		}
		
		if(!(strAppno.equalsIgnoreCase("") || strAppno.equalsIgnoreCase("null")))
		{
			strAction = correctNull((String)hshRequestValues.get("hidAction"));
			strQuery = SQLParser.getSqlQuery("getloanproductdetails^" + strAppno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strProductType=correctNull(rs.getString("prd_type"));
			}
			
			loanamt = (String[]) hshRequestValues.get("txt_loan");
			intrate = (String[])hshRequestValues.get("txt_int");
			netinc = (String[])hshRequestValues.get("txt_netinc");
			principal = (String[])hshRequestValues.get("txt_principal");
			netintamt = (String[])hshRequestValues.get("txt_netint");
			outgoingamt = (String[])hshRequestValues.get("txt_outgoing");
			surplusamt = (String[])hshRequestValues.get("txt_surplus");
			repayment = (String[])hshRequestValues.get("txt_repayment");
			txt_taxdec = (String[]) hshRequestValues.get("txt_taxdec");
			txt_aftertax = (String[])hshRequestValues.get("txt_aftertax");
			txt_depri = (String[])hshRequestValues.get("txt_depri");
			txt_dscr = (String[])hshRequestValues.get("txt_dscr");
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "del_cashflow");
				arrValues.add(strAppno);
				arrValues.add(strProductType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				intUpdatesize = 1;
				for (int i = 0; i < loanamt.length; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_cashflow");
					arrValues.add(strAppno);
					arrValues.add(Integer.toString(i+1));
					
					arrValues.add(Helper.correctDouble(loanamt[i]));
					arrValues.add(Helper.correctDouble(intrate[i]));
					arrValues.add(Helper.correctDouble(netinc[i]));
					arrValues.add(Helper.correctDouble(principal[i]));
					arrValues.add(Helper.correctDouble(netintamt[i]));
					arrValues.add(Helper.correctDouble(outgoingamt[i]));
					arrValues.add(Helper.correctDouble(surplusamt[i]));
					arrValues.add(Helper.correctDouble(repayment[i]));
					arrValues.add(strProductType.trim());
					arrValues.add(Helper.correctDouble(txt_taxdec[i]));
					arrValues.add(Helper.correctDouble(txt_aftertax[i]));
					arrValues.add(Helper.correctDouble(txt_depri[i]));
					arrValues.add(Helper.correctDouble(txt_dscr[i]));
					
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "del_cashflow");
				arrValues.add(strAppno);
				arrValues.add(strProductType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for (int i = 0; i < loanamt.length; i++)
			{	
				
				sbAuditTrial
				.append("~Loan At the Beginning ")
				.append((i+1)+" year = ")
				.append(correctNull(loanamt[i]))
				.append("~Interest ")
				.append(correctNull((String)hshRequestValues.get("txt_roi"))+" ")
				.append((i+1)+"  year [%] = ")
				.append(correctNull(intrate[i]));
				
				
				sbAuditTrial.append("~Gross Income (G)").append((i+1)+"  year = ").append(correctNull(netinc[i]))
					.append("~Repayment Principal(A) ").append((i+1)+"  year = ").append(correctNull(principal[i]))
					.append("~Repayment Interest(B) ").append((i+1)+"  year = ").append(correctNull(netintamt[i]))
					.append("~Repayment to Other loans(C) ").append((i+1)+"  year = ").append(correctNull(repayment[i]))
					.append("~Total Repay(B+C=D) ").append((i+1)+"  year = ").append(correctNull(outgoingamt[i]))
					.append("~Surplus(G-D) ").append((i+1)+"  year = ").append(correctNull(surplusamt[i]))
					.append("~Tax Deduction (T) ").append((i+1)+"  year = ").append(correctNull(txt_taxdec[i]))
					.append("~Net Profit after tax(G-D-T=I) ").append((i+1)+"  year = ").append(correctNull(txt_aftertax[i]))
					.append("~Depreciation(D1) ").append((i+1)+"  year = ").append(correctNull(txt_depri[i]))
					.append("~DSCR(I+D1+B)/(A+B) ").append((i+1)+"  year = ").append(correctNull(txt_dscr[i]));
				
				if(correctNull((String)hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				{
					hshRequestValues.put("strAction", "update");
				}else{
					hshRequestValues.put("strAction", "insert");
				}
			}
			}
			if(correctNull((String)hshRequestValues.get("hidtype")).equalsIgnoreCase("PLANT")){
			AuditTrial.auditLog(hshRequestValues,"272",strAppno,sbAuditTrial.toString());
		  }else{
			AuditTrial.auditLog(hshRequestValues,"242",strAppno,sbAuditTrial.toString());  
		  }
		}
	}		
	catch(Exception ce)
	{
		throw new EJBException(" Error in updatecashflowData :: "+ce.toString());
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
			throw new EJBException("Error closing the connection in updatecashflowData ::  "+cf.getMessage());
		}
	}
}


public  HashMap getcashflowData(HashMap hshValues) 
{
		ResultSet rs = null;
		
		String strQuery = "";
		String strProductType="";
		int intlreqterms=0;
		
		double lreqterms=0.00;
		
		HashMap hshRecord = new HashMap();
		HashMap hshRecord1 = new HashMap();
		HashMap hshRecordtmp = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList vecyearlyincome=new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		double dbllastyrinc=0.0;
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			
			strQuery = SQLParser.getSqlQuery("getloanproductdetails^" + appno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("loan_recmdamt", Helper.correctDouble(rs.getString("loan_recmdamt")));
				hshRecord.put("loan_modintrate", Helper.correctDouble(rs.getString("loan_modintrate")));
				
				strProductType=correctNull(rs.getString("prd_type"));
				lreqterms=rs.getDouble("loan_reqterms");
				intlreqterms=(int)Math.ceil(lreqterms/12);
				hshRecord.put("intyearsize", Integer.toString(intlreqterms));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_cashflow^" + appno+"^"+strProductType);
			rs = DBUtils.executeQuery(strQuery);
			int size=0;
			while(rs.next())
			{
				arrData = new ArrayList();
				
				
				arrData.add(Helper.formatDoubleValue(rs.getDouble("loan_begin")));//vec[][1]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("interest")));//vec[][2]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("netincome")));//vec[][3]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("principalamt")));//vec[][4]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("netintamt")));//vec[][5]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("outgoingamt")));//vec[][6]
				arrData.add(Helper.formatDoubleValue(rs.getDouble("surplusamt")));//vec[][7]
				//vec[][8]
				if(Helper.formatDoubleValue(rs.getDouble("repayment")).equalsIgnoreCase("0.00"))
				{
					arrData.add("");
				}
				else
				{
					arrData.add(Helper.formatDoubleValue(rs.getDouble("repayment")));
				}
				//vec[][9]
				if(Helper.formatDoubleValue(rs.getDouble("taxdedc")).equalsIgnoreCase("0.00"))
				{
					arrData.add("");
				}
				else
				{
					arrData.add(Helper.formatDoubleValue(rs.getDouble("taxdedc")));
				}
				
				arrData.add(Helper.formatDoubleValue(rs.getDouble("netprofit")));//vec[][10]
				//vec[][11]
				if(Helper.formatDoubleValue(rs.getDouble("depriciation")).equalsIgnoreCase("0.00"))
				{
					arrData.add("");
				}
				else
				{
					arrData.add(Helper.formatDoubleValue(rs.getDouble("depriciation")));
				}
				arrData.add(Helper.formatDoubleValue(rs.getDouble("dscr")));//vec[][12]
				arrRow.add(arrData);
				size++;
				hshRecord.put("auditFlag", "Y");//For Audit Trial
			}
			
			hshRecord.put("arrRow", arrRow);
			
			
			if(strProductType.equalsIgnoreCase("aD"))
			{
				//hshRecord.put("intyearsize","7");
				strQuery = SQLParser.getSqlQuery("sel_agr_dairyfarming^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					vecyearlyincome.add(correctNull(rs.getString("firstyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("secondyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("thirdyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("fourthyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("fifthyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("sixthyearsurplus")));
					vecyearlyincome.add(correctNull(rs.getString("seventhyearsurplus")));
					dbllastyrinc=rs.getDouble("seventhyearsurplus");
				}
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			
			// Call the getfarmemiData method of AppraisalBean
			if(strProductType.equalsIgnoreCase("aU") || strProductType.equalsIgnoreCase("aF"))
			{
				hshRecordtmp.put("strappno",appno);
				hshRecordtmp.put("strProductType",strProductType);
				hshRecord1 = (HashMap)EJBInvoker.executeStateLess("appraisal",hshRecordtmp,"getfarmemiData");
				dbllastyrinc=Double.parseDouble(Helper.correctDouble((String)hshRecord1.get("incrementalincome")));
				for(int i=0;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			
			//	for Fishery
			if(strProductType.equalsIgnoreCase("aN"))
			{
				//hshRecord.put("intyearsize","7");
				double incyear1=0.00;
				double incyear2=0.00;
				double incyear3=0.00;
				double incyear4=0.00;
				
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("netincome_get_income^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					incyear1= Double.parseDouble((Helper.correctDouble(rs.getString("INC1"))));
					incyear2= Double.parseDouble((Helper.correctDouble(rs.getString("INC2"))));
					incyear3= Double.parseDouble((Helper.correctDouble(rs.getString("INC3"))));
					incyear4= Double.parseDouble((Helper.correctDouble(rs.getString("INC4"))));
				}
				double expyear1=0.00;
				double expyear2=0.00;
				double expyear3=0.00;
				double expyear4=0.00;
				if(rs!=null)
				{
					rs.close();
				}
					
				strQuery = SQLParser.getSqlQuery("netincome_get_expenses^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					expyear1=Double.parseDouble((Helper.correctDouble(rs.getString("EXP1"))));
					expyear2=Double.parseDouble((Helper.correctDouble(rs.getString("EXP2"))));
					expyear3= Double.parseDouble((Helper.correctDouble(rs.getString("EXP3"))));
					expyear4=Double.parseDouble((Helper.correctDouble(rs.getString("EXP4"))));
				}
				double firstyearincome=0.00;
				double secondyearincome=0.00;
				double thirdyearincome=0.00;
				double fourthyearincome=0.00;
				firstyearincome=incyear1-expyear1;
				secondyearincome=incyear2-expyear2;
				thirdyearincome=incyear3-expyear3;
				fourthyearincome=incyear4-expyear4;
				dbllastyrinc=fourthyearincome;
				vecyearlyincome.add(Helper.formatDoubleValue(firstyearincome));
				vecyearlyincome.add(Helper.formatDoubleValue(secondyearincome));
				vecyearlyincome.add(Helper.formatDoubleValue(thirdyearincome));
				vecyearlyincome.add(Helper.formatDoubleValue(fourthyearincome));
				
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			
			if(strProductType.equalsIgnoreCase("aJ"))
			{
				//hshRecord.put("intyearsize","6");
				strQuery = SQLParser.getSqlQuery("agr_sel_serieconomics^"+appno);			
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					vecyearlyincome.add(correctNull(rs.getString("agr_totalincomeiyear")));
					vecyearlyincome.add(correctNull(rs.getString("agr_totalincomeiiyear")));
					
					dbllastyrinc=rs.getDouble("agr_totalincomeiiyear");
				}
				
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			/* FOR BEE KEEPING(aK)
			 * Done By : Muralidharan
			 */ 
			if(strProductType.equalsIgnoreCase("aK"))
			{
				HashMap hshTotal = new HashMap();
			
				hshTotal=(HashMap)EJBInvoker.executeStateLess("agrcommon",hshValues,"getIncomeExpenseTotal");
				
				vecyearlyincome.add(correctNull((String)hshTotal.get("total1")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total2")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total3")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total4")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total5")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total6")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total7")));
				vecyearlyincome.add(correctNull((String)hshTotal.get("total8")));
				
				dbllastyrinc=Double.parseDouble(Helper.correctDouble((String)hshTotal.get("total8")));
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			
			if(strProductType.equalsIgnoreCase("aA") || strProductType.equalsIgnoreCase("aP"))
			{			
				strQuery = SQLParser.getSqlQuery("sel_poultry_cashflow^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					vecyearlyincome.add(correctNull(rs.getString("totiyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totiiyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totiiiyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totivyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totvyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totviyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totviiyearincome")));
					vecyearlyincome.add(correctNull(rs.getString("totviiiyearincome")));
					
					dbllastyrinc=rs.getDouble("totviiiyearincome");
				}
				
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
			}
			
			if(strProductType.equalsIgnoreCase("aE"))
			{
				strQuery = SQLParser.getSqlQuery("sel_sheep_income^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					vecyearlyincome.add(correctNull(rs.getString("totiyears")));
					vecyearlyincome.add(correctNull(rs.getString("totiiyears")));
					vecyearlyincome.add(correctNull(rs.getString("totiiiyears")));
					vecyearlyincome.add(correctNull(rs.getString("totivyears")));
					vecyearlyincome.add(correctNull(rs.getString("totvyears")));
					vecyearlyincome.add(correctNull(rs.getString("totviyears")));
					dbllastyrinc=rs.getDouble("totviyears");
				}
				
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(dbllastyrinc));
				}
				
//				strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+strProductType);
//				rs = DBUtils.executeQuery(strQuery);
//				if (rs.next()) 
//				{
//					hshRecord.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_totalamount"))));
//					hshRecord.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_marginper"))));
//					hshRecord.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_margin"))));
//					hshRecord.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_subsidyper"))));
//					hshRecord.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_subsidy"))));
//					hshRecord.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_totalloanamount"))));
//					hshRecord.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_value1"))));
//					hshRecord.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_value2"))));
//					hshRecord.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs.getString("sheep_value3"))));
//					
//				}	
			}
			if(strProductType.equalsIgnoreCase("aQ"))
			{
				double incyear1=0.00;
				double incyear2=0.00;
				double incyear3=0.00;
				double incyear4=0.00;
				double incyear5=0.00;
				double incyear6=0.00;
				double incyear7=0.00;
				double incyear8=0.00;
				double incyear9=0.00;
				double incyear10=0.00;
				double incyear11=0.00;
				double incyear12=0.00;
				double incyear13=0.00;
				double incyear14=0.00;
				double incyear15=0.00;
				double incyear16=0.00;
				double incyear17=0.00;
				double incyear18=0.00;
				double incyear19=0.00;
				double incyear20=0.00;
				double incyear21=0.00;
				double incyear22=0.00;
				double incyear23=0.00;
				double incyear24=0.00;
				double incyear25=0.00;
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("netincome_inc_plantation^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					incyear1= Double.parseDouble((Helper.correctDouble(rs.getString("INC1"))));
					incyear2= Double.parseDouble((Helper.correctDouble(rs.getString("INC2"))));
					incyear3= Double.parseDouble((Helper.correctDouble(rs.getString("INC3"))));
					incyear4= Double.parseDouble((Helper.correctDouble(rs.getString("INC4"))));
					incyear5= Double.parseDouble((Helper.correctDouble(rs.getString("INC5"))));
					incyear6= Double.parseDouble((Helper.correctDouble(rs.getString("INC6"))));
					incyear7= Double.parseDouble((Helper.correctDouble(rs.getString("INC7"))));
					incyear8= Double.parseDouble((Helper.correctDouble(rs.getString("INC8"))));
					incyear9= Double.parseDouble((Helper.correctDouble(rs.getString("INC9"))));
					incyear10= Double.parseDouble((Helper.correctDouble(rs.getString("INC10"))));
					incyear11= Double.parseDouble((Helper.correctDouble(rs.getString("INC11"))));
					incyear12= Double.parseDouble((Helper.correctDouble(rs.getString("INC12"))));
					incyear13= Double.parseDouble((Helper.correctDouble(rs.getString("INC13"))));
					incyear14= Double.parseDouble((Helper.correctDouble(rs.getString("INC14"))));
					incyear15= Double.parseDouble((Helper.correctDouble(rs.getString("INC15"))));
					incyear16= Double.parseDouble((Helper.correctDouble(rs.getString("INC16"))));
					incyear17= Double.parseDouble((Helper.correctDouble(rs.getString("INC17"))));
					incyear18= Double.parseDouble((Helper.correctDouble(rs.getString("INC18"))));
					incyear19= Double.parseDouble((Helper.correctDouble(rs.getString("INC19"))));
					incyear20= Double.parseDouble((Helper.correctDouble(rs.getString("INC20"))));
					incyear21= Double.parseDouble((Helper.correctDouble(rs.getString("INC21"))));
					incyear22= Double.parseDouble((Helper.correctDouble(rs.getString("INC22"))));
					incyear23= Double.parseDouble((Helper.correctDouble(rs.getString("INC23"))));
					incyear24= Double.parseDouble((Helper.correctDouble(rs.getString("INC24"))));
					incyear25= Double.parseDouble((Helper.correctDouble(rs.getString("INC25"))));
				}
					
				double expyear1=0.00;
				double expyear2=0.00;
				double expyear3=0.00;
				double expyear4=0.00;
				double expyear5=0.00;
				double expyear6=0.00;
				double expyear7=0.00;
				double expyear8=0.00;
				double expyear9=0.00;
				double expyear10=0.00;
				double expyear11=0.00;
				double expyear12=0.00;
				double expyear13=0.00;
				double expyear14=0.00;
				double expyear15=0.00;
				double expyear16=0.00;
				double expyear17=0.00;
				double expyear18=0.00;
				double expyear19=0.00;
				double expyear20=0.00;
				double expyear21=0.00;
				double expyear22=0.00;
				double expyear23=0.00;
				double expyear24=0.00;
				double expyear25=0.00;
				
				if(rs!=null)
				{
					rs.close();
				}
					
				strQuery = SQLParser.getSqlQuery("netincome_exp_plantation^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					expyear1=Double.parseDouble((Helper.correctDouble(rs.getString("EXP1"))));
					expyear2=Double.parseDouble((Helper.correctDouble(rs.getString("EXP2"))));
					expyear3= Double.parseDouble((Helper.correctDouble(rs.getString("EXP3"))));
					expyear4=Double.parseDouble((Helper.correctDouble(rs.getString("EXP4"))));
					expyear5=Double.parseDouble((Helper.correctDouble(rs.getString("EXP5"))));
					expyear6=Double.parseDouble((Helper.correctDouble(rs.getString("EXP6"))));
					expyear7= Double.parseDouble((Helper.correctDouble(rs.getString("EXP7"))));
					expyear8=Double.parseDouble((Helper.correctDouble(rs.getString("EXP8"))));
					expyear9=Double.parseDouble((Helper.correctDouble(rs.getString("EXP9"))));
					expyear10=Double.parseDouble((Helper.correctDouble(rs.getString("EXP10"))));
					expyear11= Double.parseDouble((Helper.correctDouble(rs.getString("EXP11"))));
					expyear12=Double.parseDouble((Helper.correctDouble(rs.getString("EXP12"))));
					expyear13=Double.parseDouble((Helper.correctDouble(rs.getString("EXP13"))));
					expyear14=Double.parseDouble((Helper.correctDouble(rs.getString("EXP14"))));
					expyear15= Double.parseDouble((Helper.correctDouble(rs.getString("EXP15"))));
					expyear16= Double.parseDouble((Helper.correctDouble(rs.getString("EXP16"))));
					expyear17= Double.parseDouble((Helper.correctDouble(rs.getString("EXP17"))));
					expyear18= Double.parseDouble((Helper.correctDouble(rs.getString("EXP18"))));
					expyear19= Double.parseDouble((Helper.correctDouble(rs.getString("EXP19"))));
					expyear20= Double.parseDouble((Helper.correctDouble(rs.getString("EXP20"))));
					expyear21= Double.parseDouble((Helper.correctDouble(rs.getString("EXP21"))));
					expyear22= Double.parseDouble((Helper.correctDouble(rs.getString("EXP22"))));
					expyear23= Double.parseDouble((Helper.correctDouble(rs.getString("EXP23"))));
					expyear24= Double.parseDouble((Helper.correctDouble(rs.getString("EXP24"))));
					expyear25= Double.parseDouble((Helper.correctDouble(rs.getString("EXP25"))));
				}
				double netincomeyear1=0.00;
				double netincomeyear2=0.00;
				double netincomeyear3=0.00;
				double netincomeyear4=0.00;
				double netincomeyear5=0.00;
				double netincomeyear6=0.00;
				double netincomeyear7=0.00;
				double netincomeyear8=0.00;
				double netincomeyear9=0.00;
				double netincomeyear10=0.00;
				double netincomeyear11=0.00;
				double netincomeyear12=0.00;
				double netincomeyear13=0.00;
				double netincomeyear14=0.00;
				double netincomeyear15=0.00;
				double netincomeyear16=0.00;
				double netincomeyear17=0.00;
				double netincomeyear18=0.00;
				double netincomeyear19=0.00;
				double netincomeyear20=0.00;
				double netincomeyear21=0.00;
				double netincomeyear22=0.00;
				double netincomeyear23=0.00;
				double netincomeyear24=0.00;
				double netincomeyear25=0.00;
					
				netincomeyear1=incyear1-expyear1;
				netincomeyear2=incyear2-expyear2;
				netincomeyear3=incyear3-expyear3;
				netincomeyear4=incyear4-expyear4;
				netincomeyear5=incyear5-expyear5;
				netincomeyear6=incyear6-expyear6;
				netincomeyear7=incyear7-expyear7;
				netincomeyear8=incyear8-expyear8;
				netincomeyear9=incyear9-expyear9;
				netincomeyear10=incyear10-expyear10;
				netincomeyear11=incyear11-expyear11;
				netincomeyear12=incyear12-expyear12;
				netincomeyear13=incyear13-expyear13;
				netincomeyear14=incyear14-expyear14;
				netincomeyear15=incyear15-expyear15;
				netincomeyear16=incyear16-expyear16;
				netincomeyear17=incyear17-expyear17;
				netincomeyear18=incyear18-expyear18;
				netincomeyear19=incyear19-expyear19;
				netincomeyear20=incyear20-expyear20;
				netincomeyear21=incyear21-expyear21;
				netincomeyear22=incyear22-expyear22;
				netincomeyear23=incyear23-expyear23;
				netincomeyear24=incyear24-expyear24;
				netincomeyear25=incyear25-expyear25;
					
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear1));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear2));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear3));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear4));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear5));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear6));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear7));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear8));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear9));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear10));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear11));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear12));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear13));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear14));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear15));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear16));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear17));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear18));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear19));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear20));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear21));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear22));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear23));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear24));
				vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear25));
				
				int len=vecyearlyincome.size();
				for(int i=len;i<=intlreqterms;i++)
				{
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear25));
				}
			}
		
			hshRecord.put("strProductType",strProductType);
			hshRecord.put("vecyearlyincome",vecyearlyincome);
					
		//end 
					
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getcashflowData"+ce.toString());
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


	public void updatefarmMechData(HashMap hshRequestValues) 
	{
 		String appno=correctNull((String)hshRequestValues.get("appno"));
		String strappno=correctNull((String)hshRequestValues.get("strappno"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		
		String[] particulars = null;
		String[] make = null;
		String[] hpower = null;
		String[] estimcost = null;
		String[] margin = null;
		String[] loanamt = null;
		String totestimcost = "";
		String totmargin = "";
		String totloanamt = "";
		String seltractor = "";
		String tractorreason = "";
		String selmachinery = "";
		String machineryreason = "";
	
		String hidAction=correctNull((String)hshRequestValues.get("hidAction"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		try
		{		
			particulars = (String[]) hshRequestValues.get("txt_particulars");
			make = (String[]) hshRequestValues.get("txt_make");
			hpower = (String[]) hshRequestValues.get("txt_hp");
			estimcost = (String[]) hshRequestValues.get("txt_estimcost");
			margin = (String[]) hshRequestValues.get("txt_margin");
			loanamt = (String[]) hshRequestValues.get("txt_loanamt");
			totestimcost = correctNull((String)hshRequestValues.get("txt_totestimcost"));
			totmargin = correctNull((String)hshRequestValues.get("txt_totmargin"));
			totloanamt = correctNull((String)hshRequestValues.get("txt_totloanamt"));
			seltractor = correctNull((String)hshRequestValues.get("sel_tractor"));
			tractorreason = correctNull((String)hshRequestValues.get("txt_tractorreason"));
			selmachinery = correctNull((String)hshRequestValues.get("sel_machinery"));
			machineryreason = correctNull((String)hshRequestValues.get("txt_machineryreason"));
			if(correctNull((String) hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hidAction="insert";
			}
			else
			{
				if(!hidAction.equalsIgnoreCase("delete"))
				{
					hidAction="update";
				}
			}
			StringBuilder sbAuditTrialOld=new StringBuilder();
			if(!hidAction.equalsIgnoreCase("insert"))
			{
				sbAuditTrialOld.append("Particulars of Investment ^");
			
				String strQuery = SQLParser.getSqlQuery("sel_farmmechparticulars^" + appno);
				rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
				sbAuditTrialOld.append("~Particulars = ").append(correctNull(rs.getString("particulars")))
				.append("~Name of the supplier = ").append(correctNull(rs.getString("make")))
				.append("~Quotation no & Date = ").append(correctNull(rs.getString("hp")))
				.append("~No. of Units = ").append(correctNull(rs.getString("estimcost")))
				.append("~Rate per unit = ").append(correctNull(rs.getString("margin")))
				.append("~Total Cost = ").append(correctNull(rs.getString("loanamt")));
					}
			}
		if(hidAction.equalsIgnoreCase("update"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_farmmechparticulars");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			for(int i=0; i<7; i++)
			{
				arrValues = new ArrayList();
				arrValues.add(appno);
				/*if(particulars[i].equalsIgnoreCase(""))
				{
					particulars[i]="0.00";
				}*/
				arrValues.add(Integer.toString(i+1));
				arrValues.add(particulars[i]);
				if(make[i].equalsIgnoreCase(""))
				{
					make[i]="";
				}
				arrValues.add(make[i]);
				if(hpower[i].equalsIgnoreCase(""))
				{
					hpower[i]="0.00";
				}
				arrValues.add(hpower[i]);
				if(estimcost[i].equalsIgnoreCase(""))
				{
					estimcost[i]="0.00";
				}
				arrValues.add(estimcost[i]);
				if(margin[i].equalsIgnoreCase(""))
				{
					margin[i]="0.00";
				}
				arrValues.add(margin[i]);
				if(loanamt[i].equalsIgnoreCase(""))
				{
					loanamt[i]="0.00";
				}
				arrValues.add(loanamt[i]);
				if(totestimcost.equalsIgnoreCase(""))
				{
					totestimcost="0.00";
				}
				arrValues.add(totestimcost);
				if(totmargin.equalsIgnoreCase(""))
				{
					totmargin="0.00";
				}
				arrValues.add(totmargin);
				if(totloanamt.equalsIgnoreCase(""))
				{
					totloanamt="0.00";
				}
				arrValues.add(totloanamt);
				arrValues.add(seltractor);
				arrValues.add(tractorreason);
				arrValues.add(selmachinery);
				arrValues.add(machineryreason);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_farmmechparticulars");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}	
//====================Insert this same value into Farm Mechanisation Eligibility calculation========================
				
				 hshQuery = new HashMap();
				 arrValues = new ArrayList();
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				 hshQueryValues1 = new HashMap();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_farmmechparticularsEMI");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				
				for(int i=0; i<7; i++)
				{
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					arrValues.add(particulars[i]);
					if(make[i].equalsIgnoreCase(""))
					{
						make[i]="";
					}
					arrValues.add(make[i]);
					if(hpower[i].equalsIgnoreCase(""))
					{
						hpower[i]="0.00";
					}
					arrValues.add(hpower[i]);
					if(estimcost[i].equalsIgnoreCase(""))
					{
						estimcost[i]="0.00";
					}
					arrValues.add(estimcost[i]);
					if(margin[i].equalsIgnoreCase(""))
					{
						margin[i]="0.00";
					}
					arrValues.add(margin[i]);
					if(loanamt[i].equalsIgnoreCase(""))
					{
						loanamt[i]="0.00";
					}
					arrValues.add(loanamt[i]);
					if(totestimcost.equalsIgnoreCase(""))
					{
						totestimcost="0.00";
					}
					arrValues.add(totestimcost);
					if(totmargin.equalsIgnoreCase(""))
					{
						totmargin="0.00";
					}
					arrValues.add(totmargin);
					if(totloanamt.equalsIgnoreCase(""))
					{
						totloanamt="0.00";
					}
					arrValues.add(totloanamt);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_farmmechparticularsEMI");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}		
	
		if(hidAction.equalsIgnoreCase("delete"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_farmmechparticulars");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
		}
		if(hidAction.equalsIgnoreCase("delete"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_farmmechanism_part");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
		}
		
		StringBuilder sbAuditTrial=new StringBuilder();
	
		if (hidAction.equalsIgnoreCase("insert") || hidAction.equalsIgnoreCase("update")) {
		sbAuditTrial.append("Particulars of Investment ^");
		
		for(int j=0;j<particulars.length;j++)
		{
			sbAuditTrial.append("~Particulars = ").append(correctNull(particulars[j]))
			.append("~Name of the supplier = ").append(correctNull(make[j]))
			.append("~Quotation no & Date = ").append(correctNull(hpower[j]))
			.append("~No. of Units = ").append(correctNull(estimcost[j]))
			.append("~Rate per unit = ").append(correctNull(margin[j]))
			.append("~Total Cost = ").append(correctNull(loanamt[j]));
		}
		
        if(correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y")){
        	
			hshRequestValues.put("strAction", "update");
		}else{
			hshRequestValues.put("strAction", "Insert");
		}
		}
		if(Helper.correctNull((String)hshRequestValues.get("strProductType")).equalsIgnoreCase("aU"))		
		{
			AuditTrial.auditNewLog(hshRequestValues, "227", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());	
		}
		else
		{
			AuditTrial.auditNewLog(hshRequestValues, "224", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());	
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
	
	
	public  HashMap getfarmMechData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		String recordflag="N";
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_farmmechparticulars^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate==true)
			{
				while(rs.next())
				{
					vecRow = new ArrayList();
					vecRow.add(correctNull(rs.getString("appno")));
					vecRow.add(correctNull(rs.getString("particulars")));
					if(correctNull(rs.getString("make")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("make")));
					}
					if(correctNull(rs.getString("hp")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("hp")));
					}
					if(correctNull(rs.getString("estimcost")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("estimcost")));
					}
					if(correctNull(rs.getString("margin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("margin")));
					}
					if(correctNull(rs.getString("loanamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("loanamt")));
					}
					if(correctNull(rs.getString("totestimamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("totestimamt")));
					}
					if(correctNull(rs.getString("totmarginamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("totmarginamt")));
					}
					if(correctNull(rs.getString("totloanamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("totloanamt")));
					}
					vecRow.add(correctNull(rs.getString("sel_tractor")));
					vecRow.add(correctNull(rs.getString("tractorreason")));
					vecRow.add(correctNull(rs.getString("sel_machinery")));
					vecRow.add(correctNull(rs.getString("machineryreason")));
					vecData.add(vecRow);
					hshRecord.put("seltractor",correctNull(rs.getString("sel_tractor")));
					hshRecord.put("selmachinery",correctNull(rs.getString("sel_machinery")));
					hshRecord.put("totestimamt",correctNull(rs.getString("totestimamt")));
					hshRecord.put("totmarginamt",correctNull(rs.getString("totmarginamt")));
					hshRecord.put("totloanamt",correctNull(rs.getString("totloanamt")));
					recordflag="Y";
				}
			}
			else
			{
				for(int i=0; i<7; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("recordflag",recordflag);
			if(rs != null)
			{
				rs.close();
			}	
			if(rs1 != null)
			{
				rs1.close();
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getfarmMechData "+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs1 != null)
				{
					rs1.close();
				}
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getfarmMechData "+ exp.toString()); 
			}
		}
		
		return hshRecord;
	}	

	
	public void updatefarmMechTechData(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshRequestValues.get("hidAction");
		
		String appno=correctNull((String)hshRequestValues.get("appno"));
		
		String landmeasurement=correctNull((String)hshRequestValues.get("txtlandmeasurement"));
		
		if (landmeasurement.equalsIgnoreCase("g")) 
		{
			landmeasurement = "Guntas";
		} 
		else 
		{
			landmeasurement = "Cents";
		}
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}		
		ResultSet rs = null;
		try
		{			
			if(strAction.equals("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delfarmmechanism");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_insfarmmechanism");
				arrValues.add(appno);
				if(correctNull((String)hshRequestValues.get("txt_olandacre")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_olandacre")));
				}
				if(correctNull((String)hshRequestValues.get("txt_ocents")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_ocents")));
				}
			
				if(correctNull((String)hshRequestValues.get("txt_omachinery")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_omachinery")));
				}
	// ===========================			
				if(correctNull((String)hshRequestValues.get("txt_omember")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_omember")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_omembercents")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_omembercents")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_omembermachin")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_omembermachin")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_clandacre")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_clandacre")));
				}
								
				if(correctNull((String)hshRequestValues.get("txt_ccents")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_ccents")));
				}
			
				if(correctNull((String)hshRequestValues.get("txt_cmachinery")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_cmachinery")));
				}
			
				if(correctNull((String)hshRequestValues.get("txt_cmember")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_cmember")));
				}
				
				
				if(correctNull((String)hshRequestValues.get("sel_proposed")).equalsIgnoreCase(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("sel_proposed")));
				}
				if(correctNull((String)hshRequestValues.get("txt_reason")).equalsIgnoreCase(""))
				{
					arrValues.add("");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_reason")));
				}
				
				if(correctNull((String)hshRequestValues.get("sel_drive")).equalsIgnoreCase(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("sel_drive")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_salary")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_salary")));
				}
				
				if(correctNull((String)hshRequestValues.get("sel_license")).equalsIgnoreCase(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("sel_license")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_agency1")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency1")));
				}
				if(correctNull((String)hshRequestValues.get("txt_agency2")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_agency2")));
				}
				if(correctNull((String)hshRequestValues.get("txt_agency3")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency3")));
				}
				if(correctNull((String)hshRequestValues.get("txt_agency4")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_agency4")));
				}
				if(correctNull((String)hshRequestValues.get("txt_amount1")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String)hshRequestValues.get("txt_amount1")));
				}
				if(correctNull((String)hshRequestValues.get("txt_amount2")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String)hshRequestValues.get("txt_amount2")));
				}
				if(correctNull((String)hshRequestValues.get("txt_amount3")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String)hshRequestValues.get("txt_amount3")));
				}
				if(correctNull((String)hshRequestValues.get("txt_amount4")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_amount4")));
				}
				arrValues.add(correctNull((String)hshRequestValues.get("sel_netamt")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_netamtsource")));
				//arrValues.add(correctNull((String)hshRequestValues.get("txt_netamount")));
				if(correctNull((String)hshRequestValues.get("txt_netamount")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_netamount")));
				}
				
				
				
				if(correctNull((String)hshRequestValues.get("txt_costrepair")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_costrepair")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_costfuel")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_costfuel")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_insurence")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_insurence")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_others")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_others")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_bullck")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_bullck")));
				}
				
				if(correctNull((String)hshRequestValues.get("txt_interest")).equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String)hshRequestValues.get("txt_interest")));
				}
				arrValues.add(correctNull((String)hshRequestValues.get("txt_ratehour")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_age")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_originalcost")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_valuationvechi")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_leastvalue")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_regno")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_chasisno")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_engineno")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_owner")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_valuationdone")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_branch")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_mechanic")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_mechdistance")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_bullckbm")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_interestbm")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_vehicle")));
			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_delfarmmechanism");
				arrValues.add(appno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			String  sel_drive = correctNull((String )hshRequestValues.get("sel_drive"));
			
			if(sel_drive.equals("1"))
				sel_drive = "Self";
			else if(sel_drive.equals("2"))
				sel_drive = "Others";
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
			sbAuditTrial.append("~Farm Machinery to be purchased = ").append(correctNull((String )hshRequestValues.get("sel_vehicle1")))
			.append("~Total acreage to be covered ^")
			.append("~Own Land Acre = ").append(correctNull((String )hshRequestValues.get("txt_olandacre")))
			.append("~"+landmeasurement+" = ").append(correctNull((String )hshRequestValues.get("txt_ocents")))
			.append("~Family Holding Acre= ").append(correctNull((String )hshRequestValues.get("txt_omember")))
			.append("~"+landmeasurement+" = ").append(correctNull((String )hshRequestValues.get("txt_omembercents")))
			.append("~Leased/Share cropper Acre= ").append(correctNull((String )hshRequestValues.get("txt_clandacre")))
			.append("~"+landmeasurement+" = ").append(correctNull((String )hshRequestValues.get("txt_ccents")))
			.append("~No. of hours to be used annually ^")
			.append("~On farm operations (Hrs/Year) = ").append(correctNull((String )hshRequestValues.get("txt_omachinery")))
			.append("~Off farm operations (Hrs/Year) = ").append(correctNull((String )hshRequestValues.get("txt_cmachinery")))
			.append("~Rate/hour = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_ratehour")))
			.append("~Income from Hiring = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_cmember")))
			.append("~Whether agri implements are proposed to be purchase along with Tractor / Power Tiller = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_proposed"))));
			
			if(correctNull((String )hshRequestValues.get("sel_proposed")).equals("2"))
			{	
				sbAuditTrial.append("~Reason = ").append(correctNull((String )hshRequestValues.get("txt_reason")));
			}	
			sbAuditTrial.append("~Who will drive the Tractor / Power Tiller/Agricultural Machinary = ")
			.append(sel_drive);
			
			if(correctNull((String )hshRequestValues.get("sel_drive")).equals("2"))
			{
				sbAuditTrial.append("~Salary / Year =").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_salary")));
			}
			
			sbAuditTrial.append("~Whether Driving License is held = ").append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_license"))))
			.append("~Cost of Maintanence of bullocks per annum (BM) = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_bullckbm")))
			.append("~Cost of Maintanence of bullocks per annum (AM) = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_bullck")))
			.append("~Interest on Crop Loan (BM) = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_interestbm")))
			.append("~Interest on Crop Loan (AM) = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_interest")))
			.append("~Cost of Repairs of Machinery/year = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_costrepair")))
			.append("~Cost of fuel for Machinery/year = ").append(correctNull((String )hshRequestValues.get("txt_costfuel")))
			.append("~Insurance and Taxes/year = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_insurence")))
			.append("~Others = ").append(ApplicationParams.getCurrency()).append(correctNull((String )hshRequestValues.get("txt_others")))
			.append("~If Second Hand  ^ ")
			.append("~Age of Vehicle = ").append(correctNull((String )hshRequestValues.get("txt_age")))
			.append("~Original Cost = ").append(correctNull((String )hshRequestValues.get("txt_originalcost")))
			.append("~Value as per valuer's report = ").append(correctNull((String )hshRequestValues.get("txt_valuationvechi")))
			.append("~Least Value of the above = ").append(correctNull((String )hshRequestValues.get("txt_leastvalue")))
			.append("~Registration No. = ").append(correctNull((String )hshRequestValues.get("txt_regno")))
			.append("~Chasis No. = ").append(correctNull((String )hshRequestValues.get("txt_chasisno")))
			.append("~Engine No. = ").append(correctNull((String )hshRequestValues.get("txt_engineno")))
			.append("~Name of the Owner = ").append(correctNull((String )hshRequestValues.get("txt_owner")))
			.append("~Valuation done by = ").append(correctNull((String )hshRequestValues.get("txt_valuationdone")))
			.append("~Whether valuer on the branch panel = ").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String )hshRequestValues.get("sel_branch"))))
			.append("~Name of Garage/Mechanic = ").append(correctNull((String )hshRequestValues.get("txt_mechanic")))
			.append("~Distance from Village = ").append(correctNull((String )hshRequestValues.get("txt_mechdistance")))
			.append("").append("Km");
			
			if(correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshRequestValues.put("strAction", "update");
			}
			}
			AuditTrial.auditLog(hshRequestValues,"225",appno,sbAuditTrial.toString());
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
	
	public  HashMap getfarmMechTechData(HashMap hshValues) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		//ArrayList vecRec = new ArrayList();
		//ArrayList vecCol=new ArrayList();
		//ArrayList vecData=new ArrayList();
		String recordflag="N";
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery=SQLParser.getSqlQuery("sel_otherparameters1");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(correctNull(rs.getString("stat_data_desc")).equalsIgnoreCase("trac"))
				{
					if(correctNull(rs.getString("loan_paramval")).equalsIgnoreCase("0"))
					{
						hshRecord.put("tractorhours","");
					}
					else
					{
						hshRecord.put("tractorhours",correctNull(rs.getString("loan_paramval")));
					}
					
				}
				if(correctNull(rs.getString("stat_data_desc")).equalsIgnoreCase("POWER"))
				{
					if(correctNull(rs.getString("loan_paramval")).equalsIgnoreCase("0"))
					{
						hshRecord.put("powertillerhours","");
					}
					else
					{
						hshRecord.put("powertillerhours",correctNull(rs.getString("loan_paramval")));
					}
				}
				if(correctNull(rs.getString("stat_data_desc")).equalsIgnoreCase("COMHAR"))
				{
					if(correctNull(rs.getString("loan_paramval")).equalsIgnoreCase("0"))
					{
						hshRecord.put("combineharvestorhours","");
					}
					else
					{
						hshRecord.put("combineharvestorhours",correctNull(rs.getString("loan_paramval")));
					}
				}
				
			}	
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agr_selfarmmechanism^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("agr_appno",correctNull(rs.getString("appno")));
				hshRecord.put("agr_olandacre",correctNull(rs.getString("agr_olandacre")));
				hshRecord.put("agr_oguntas",correctNull(rs.getString("agr_oguntas")));
				hshRecord.put("agr_omachinery",correctNull(rs.getString("agr_omachinery"))); 
				hshRecord.put("agr_omember",correctNull(rs.getString("agr_omember")));
				hshRecord.put("agr_omem_guntas",correctNull(rs.getString("agr_omem_guntas")));
				hshRecord.put("agr_omem_machinery",correctNull(rs.getString("agr_omem_machinery")));
				
				hshRecord.put("agr_clandacre",correctNull(rs.getString("agr_clandacre")));
				hshRecord.put("agr_cguntas",correctNull(rs.getString("agr_cguntas")));
				hshRecord.put("agr_cmachinery",correctNull(rs.getString("agr_cmachinery"))); 
				hshRecord.put("agr_cmember",correctNull(rs.getString("agr_cmember")));
				
				hshRecord.put("agr_selproposed",correctNull(rs.getString("agr_selproposed"))); 
				hshRecord.put("agr_reason",correctNull(rs.getString("agr_reason")));
				hshRecord.put("agr_seldrive",correctNull(rs.getString("agr_seldrive")));
				hshRecord.put("agr_salary",correctNull(rs.getString("agr_salary")));
				hshRecord.put("agr_sellicense",correctNull(rs.getString("agr_sellicense"))); 
				
				//hshRecord.put("agr_agency1",correctNull(rs.getString("agr_agency1")));
				//hshRecord.put("agr_agency2",correctNull(rs.getString("agr_agency2"))); 
				//hshRecord.put("agr_agency3",correctNull(rs.getString("agr_agency3")));
				//hshRecord.put("agr_agency4",correctNull(rs.getString("agr_agency4")));
				//hshRecord.put("agr_amt1",correctNull(rs.getString("agr_amt1")));
				//hshRecord.put("agr_amt2",correctNull(rs.getString("agr_amt2")));
				//hshRecord.put("agr_amt3",correctNull(rs.getString("agr_amt3")));
				//hshRecord.put("agr_amt4",correctNull(rs.getString("agr_amt4")));
				hshRecord.put("agr_selnetamt", correctNull(rs.getString("selnetamt")));
				hshRecord.put("agr_netamtsource",correctNull(rs.getString("netamtsource")));
				hshRecord.put("agr_netamt",correctNull(rs.getString("netamt")));
				hshRecord.put("agr_repair_cost",correctNull(rs.getString("agr_repair_cost")));
				hshRecord.put("agr_fuel_cost", correctNull(rs.getString("agr_fuel_cost")));
				hshRecord.put("agr_insurence",correctNull(rs.getString("agr_insurence")));
				hshRecord.put("agr_other_cost",correctNull(rs.getString("agr_other_cost")));
				hshRecord.put("agr_bullock_cost",correctNull(rs.getString("agr_bullock_cost")));
				hshRecord.put("agr_interest",correctNull(rs.getString("agr_interest")));
				
				hshRecord.put("agr_ratehour",correctNull(rs.getString("agr_ratehour")));
				hshRecord.put("agr_age", correctNull(rs.getString("agr_age")));
				hshRecord.put("agr_originalcost",correctNull(rs.getString("agr_originalcost")));
				hshRecord.put("agr_valuercost",correctNull(rs.getString("agr_valuercost")));
				hshRecord.put("agr_leastvalue",correctNull(rs.getString("agr_leastvalue")));
				hshRecord.put("agr_regno", correctNull(rs.getString("agr_regno")));
				hshRecord.put("agr_chasisno",correctNull(rs.getString("agr_chasisno")));
				hshRecord.put("agr_engineno",correctNull(rs.getString("agr_engineno")));
				hshRecord.put("agr_owner",correctNull(rs.getString("agr_owner")));
				hshRecord.put("agr_valuationdoneby",correctNull(rs.getString("agr_valuationdoneby")));
				hshRecord.put("agr_panel",correctNull(rs.getString("agr_panel")));
				hshRecord.put("txt_mechanic",correctNull(rs.getString("agr_mechanic")));
				hshRecord.put("txt_mechdistance",correctNull(rs.getString("agr_mechdistance")));
				hshRecord.put("agr_bullock_costbm",correctNull(rs.getString("agr_bullockcostbm")));
				hshRecord.put("agr_interestbm",correctNull(rs.getString("agr_interestbm")));
				hshRecord.put("agr_farmvehicle",correctNull(rs.getString("agr_farmvehicle")));
				recordflag="Y";
			}		
			
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("landmeasurement",correctNull(rs.getString("land_measurement")));
			}	
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
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
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	
// =========================================================================
	
	public void updatefarmMechDataEMI(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		String strappno=correctNull((String)hshRequestValues.get("strappno"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		String[] estimcost = null;
		String[] margin = null;
		String[] loanamt = null;
		String totestimcost = "";
		String totmargin = "";
		String totloanamt = "";
		String reason = "";
	
		String hidAction=correctNull((String)hshRequestValues.get("hidAction"));
		
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		try
		{		
			estimcost = (String[]) hshRequestValues.get("txt_estimcost");
			margin = (String[]) hshRequestValues.get("txt_margin");
			loanamt = (String[]) hshRequestValues.get("txt_loanamt");
			totestimcost = correctNull((String)hshRequestValues.get("txt_totestimcost"));
			totmargin = correctNull((String)hshRequestValues.get("txt_totmargin"));
			totloanamt = correctNull((String)hshRequestValues.get("txt_totloanamt"));
			reason = correctNull((String)hshRequestValues.get("txt_reason"));

//====================Update the value in Farm Mechanisation Eligibility calculation========================
		if(hidAction.equalsIgnoreCase("update"))
		{
				for(int i=0; i<7; i++)
				{
					arrValues = new ArrayList();
					if(estimcost[i].equalsIgnoreCase(""))
					{
						estimcost[i]="0.00";
					}
					arrValues.add(estimcost[i]);
					if(margin[i].equalsIgnoreCase(""))
					{
						margin[i]="0.00";
					}
					arrValues.add(margin[i]);
					if(loanamt[i].equalsIgnoreCase(""))
					{
						loanamt[i]="0.00";
					}
					arrValues.add(loanamt[i]);
					if(totestimcost.equalsIgnoreCase(""))
					{
						totestimcost="0.00";
					}
					arrValues.add(totestimcost);
					if(totmargin.equalsIgnoreCase(""))
					{
						totmargin="0.00";
					}
					arrValues.add(totmargin);
					if(totloanamt.equalsIgnoreCase(""))
					{
						totloanamt="0.00";
					}
					arrValues.add(totloanamt);
					arrValues.add(reason);
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_farmmechparticularsEMI");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
				
		}
		if(hidAction.equalsIgnoreCase("update"))
		{
			arrValues=new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			 totloanamt = correctNull((String)hshRequestValues.get("txt_totloanamt"));
			if(totloanamt.equalsIgnoreCase(""))
			{
				totloanamt="0.00";
			}
			String strCollpercent="";
			PerApplicantBean perapp = new PerApplicantBean();
			strCollpercent = perapp.getCollateralpercent(appno, totloanamt);
			arrValues.add(totloanamt);
			arrValues.add(totloanamt);
			arrValues.add(strCollpercent);
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","agr_ins_loandetail");
			arrValues.add(appno);
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
	
	
	public  HashMap getfarmMechDataEMI(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_farmmechparticularsEMI^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate==true)
			{
				while(rs.next())
				{
					vecRow = new ArrayList();
					vecRow.add(correctNull(rs.getString("appno")));
					vecRow.add(correctNull(rs.getString("agr_particulars")));
					if(correctNull(rs.getString("agr_make")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_make")));
					}
					if(correctNull(rs.getString("agr_hp")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_hp")));
					}
					if(correctNull(rs.getString("agr_estimcost")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_estimcost")));
					}
					if(correctNull(rs.getString("agr_margin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_margin")));
					}
					if(correctNull(rs.getString("agr_loanamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_loanamt")));
					}
					if(correctNull(rs.getString("agr_totestimamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_totestimamt")));
					}
					if(correctNull(rs.getString("agr_totmarginamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_totmarginamt")));
					}
					if(correctNull(rs.getString("agr_totloanamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull(rs.getString("agr_totloanamt")));
					}
					//vecRow.add(correctNull(rs.getString("agr_reason")));
					vecData.add(vecRow);
					hshRecord.put("totestimamt",correctNull(rs.getString("agr_totestimamt")));
					hshRecord.put("totmarginamt",correctNull(rs.getString("agr_totmarginamt")));
					hshRecord.put("totloanamt",correctNull(rs.getString("agr_totloanamt")));
					hshRecord.put("agr_reason",correctNull(rs.getString("agr_reason")));
					
				}
			}
			else
			{
				for(int i=0; i<7; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
			hshRecord.put("vecData",vecData);
			
			if(rs != null)
			{
				rs.close();
			}	
			if(rs1 != null)
			{
				rs1.close();
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getfarmMechDataEMI "+ce.toString());
		}finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}	
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getfarmMechDataEMI "+ exp.toString());
			}
		}
		return hshRecord;
	}	

//============================================= Farm Mech Minor Irrigation ==========================================
	
	
	public void updatefarmMechMinorIrrig(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshRequestValues.get("hidAction");
		String appno=correctNull((String)hshRequestValues.get("appno")),strQuery="";
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}		
		ResultSet rs = null;
		try
		{		
			String strnetincome="";
			
			if(correctNull((String) hshRequestValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				strAction="insert";
				hshRequestValues.put("strAction", "insert");
			}
			else
			{
				if(!strAction.equalsIgnoreCase("delete"))
				{
				strAction="update";
				hshRequestValues.put("strAction", "update");
				}
			}
			StringBuilder sbAuditTrialOld=new StringBuilder();
			if(!strAction.equalsIgnoreCase("insert"))
			{
				
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				strQuery = SQLParser.getSqlQuery("agr_selfarmmechMinorIrrig^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					if(correctNull((String) rs.getString("sel_netamt")).equalsIgnoreCase("1"))
					{
						strnetincome="Available";
					}
					else if(correctNull((String) rs.getString("sel_netamt")).equalsIgnoreCase("2"))
					{
						strnetincome="Not Available";
					}
				sbAuditTrialOld
				.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Survey No = ")
				.append(correctNull((String )rs.getString("agr_wellSurveyNo")))
				.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Extent(acres) = ")
				.append(correctNull((String )rs.getString("agr_wellExtent")))
				.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Ownership = ")
				.append(correctNull((String )rs.getString("agr_wellOwner")))
				.append("~If Pond, dimension - Length (feet) = ")
				.append(correctNull((String )rs.getString("agr_pondLength")))
				.append("~If Pond, dimension - Breadth (feet) = ")
				.append(correctNull((String )rs.getString("agr_pondBreadth")))
				.append("~If Pond, dimension - Depth (feet) = ")
				.append(correctNull((String )rs.getString("agr_pondHeight")))
				.append("~Size of Proposed Well - Depth(feet) = ")
				.append(correctNull((String )rs.getString("agr_boreHeight")))
				.append("~Size of Proposed Well - Diameter/Surface = ")
				.append(correctNull((String )rs.getString("agr_boreDiameter")))
				.append("~Source of Water = ")
				.append(correctNull((String )rs.getString("agr_sourcewater")))
				.append("~Type of Proposed Well = ")
				.append(correctNull((String )rs.getString("agr_proposedwell")))
				.append("~Time required for complete the project  = ")
				.append(correctNull((String )rs.getString("agr_projectTime")))
				.append("~Depth of water level in summer (feet) = ")
				.append(correctNull((String )rs.getString("agr_summerlevel")))
				.append("~Area to be benefitted in acres = ")
				.append(correctNull((String )rs.getString("agr_totIrrigation")))
				.append("~What is the arrangement for lifting the Water from the Well = ")
				.append(correctNull((String )rs.getString("agr_arragewater")))
				.append("~Size of Boring pipe(diameter) = ")
				.append(correctNull((String )rs.getString("borindsiz")))
				.append("~Size of Delivery Pipe(diameter) = ")
				.append(correctNull((String )rs.getString("delivesiz")))
				.append("~Feasibility Certificate obtained from Ground Water Survey Department = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_surveydept"))))
				.append("~Clearance certificate from stream / River development = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_clearence"))))
				.append("~Whether Electricity Board agree to give the electricity Connection = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_clearence"))));
				if(correctNull((String )rs.getString("agr_electricitydoc")).equalsIgnoreCase("1"))
				{
					sbAuditTrialOld
					.append("~Documents enclosed  =")
					.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("agr_electricitydoc"))));
				}
				sbAuditTrialOld
				.append("~Whether cropping pattern propose after development is feasible with reference water availability = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_cropping"))))
				.append("~Whether the water is suitable for irrigation = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_irrigation"))))
				.append("~Whether project report obtained from competent engineer/dealer = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("sel_project"))))
				.append("~Whether Spacing norms between Two Wells,Tube Wells is Maintained ? = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )rs.getString("agr_wellmaintained"))));
				if(correctNull((String )rs.getString("agr_wellmaintained")).equalsIgnoreCase("1"))
				{
					sbAuditTrialOld.append("~Distance of the proposed well / Bore well to the nearest Well / Bore Well (feet) = ")
				.append(correctNull((String )rs.getString("agr_wellDistance")));
				}
				sbAuditTrialOld
				.append("~Income and Expenses  ^ ")
				.append("~Whether water is proposed to the sold = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String) rs.getString("sel_waterPropose"))));
				if(correctNull((String) rs.getString("sel_waterPropose")).equalsIgnoreCase(""))
				{
					sbAuditTrialOld.append("~Income/Year  = ")
				.append(correctNull((String) rs.getString("agr_waterProposeInc")));
				}
				sbAuditTrialOld
				.append("~Net Income from other sources  = ")
				.append(strnetincome)
				.append("~Expected Additional Income after proposed Land Development = ")
				.append(correctNull((String) rs.getString("agr_expect_addition")));
				
				if(strnetincome.equalsIgnoreCase("Available"))
				{
					sbAuditTrialOld
				.append("~Specify Sources = ")
				.append(correctNull((String) rs.getString("agr_netamtsource")))
				.append("~Amount/Year =")
				.append(correctNull((String) rs.getString("agr_netamount")));
				}
				
				sbAuditTrialOld
				.append("~Electricity/diesel expenses/Annum = ")
				.append(correctNull((String) rs.getString("agr_elecWorks")))
				.append("~Cost of Electricity Connection ^")
				.append("~For drawing power lines to Farm Rs. = ")
				.append(correctNull((String) rs.getString("agr_elecDrawing")))
				.append("~Deposit to the Power Supplier Rs. = ")
				.append(correctNull((String) rs.getString("agr_elecDeposit")))
				;
				}
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			}
			if(strAction.equals("insert") || strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delfarmmechMinorIrrig");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_insfarmmechMinorIrrig");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshRequestValues.get("txt_sourcewater")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_surveydept")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_surveydeptRsn")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("sel_clearence")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_clearenceRsn")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_electricity")));
				arrValues.add(correctNull((String)hshRequestValues.get("0")));
				
				
				arrValues.add(correctNull((String)hshRequestValues.get("sel_cropping")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_croppingRsn")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_irrigation")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_irrigationRsn")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_summerlevel")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("sel_project")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_projectRsn")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_projectTime"))); //=========
						
				arrValues.add(correctNull((String)hshRequestValues.get("txt_HP")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_pondLength")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_pondBreadth")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_pondHeight")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("txt_boreDiameter")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_boreHeight")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_wellSurveyNo")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_wellExtent")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_wellOwner")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("txt_wellDistance")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_waterPropose")));
				
				//arrValues.add(correctNull((String)hshRequestValues.get("txt_waterProposeInc")));
				String txt_waterProposeInc=correctNull((String)hshRequestValues.get("txt_waterProposeInc"));
				if(txt_waterProposeInc.equalsIgnoreCase(""))
				{
					txt_waterProposeInc="0";	
				}
				
				arrValues.add(txt_waterProposeInc);
				arrValues.add(correctNull((String)hshRequestValues.get("txt_totIrrigation"))); //===== 	
							
				arrValues.add(correctNull((String)hshRequestValues.get("sel_pumpshed")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_pumpshedArea")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_pumpshedAmt")));

				arrValues.add(correctNull((String)hshRequestValues.get("txt_elecDrawing")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_elecWorks")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_elecDeposit")));
			
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency1")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agencyAmt1")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency2")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agencyAmt2")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency3")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agencyAmt3")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agency4")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agencyAmt4")));
				
				arrValues.add(correctNull((String)hshRequestValues.get("sel_netamt")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_netamtsource")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_netamount")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_proposedwell")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_arrangeofwater")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_document")));
				arrValues.add(correctNull((String)hshRequestValues.get("sel_tube")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_boring")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_delivery")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_exp_additional_income")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_delfarmmechMinorIrrig");
				arrValues.add(appno);			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			
			sbAuditTrial
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Survey No = ")
			.append(correctNull((String )hshRequestValues.get("txt_wellSurveyNo")))
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Extent(acres) = ")
			.append(correctNull((String )hshRequestValues.get("txt_wellExtent")))
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Ownership = ")
			.append(correctNull((String )hshRequestValues.get("txt_wellOwner")))
			.append("~If Pond, dimension - Length (feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_pondLength")))
			.append("~If Pond, dimension - Breadth (feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_pondBreadth")))
			.append("~If Pond, dimension - Depth (feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_pondHeight")))
			.append("~Size of Proposed Well - Depth(feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_boreHeight")))
			.append("~Size of Proposed Well - Diameter/Surface = ")
			.append(correctNull((String )hshRequestValues.get("txt_boreDiameter")))
			.append("~Source of Water = ")
			.append(correctNull((String )hshRequestValues.get("txt_sourcewater")))
			.append("~Type of Proposed Well = ")
			.append(correctNull((String )hshRequestValues.get("txt_proposedwell")))
			.append("~Time required for complete the project  = ")
			.append(correctNull((String )hshRequestValues.get("txt_projectTime")))
			.append("~Depth of water level in summer (feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_summerlevel")))
			.append("~Area to be benefitted in acres = ")
			.append(correctNull((String )hshRequestValues.get("txt_totIrrigation")))
			.append("~What is the arrangement for lifting the Water from the Well = ")
			.append(correctNull((String )hshRequestValues.get("txt_arrangeofwater")))
			.append("~Size of Boring pipe(diameter) = ")
			.append(correctNull((String )hshRequestValues.get("txt_boring")))
			.append("~Size of Delivery Pipe(diameter) = ")
			.append(correctNull((String )hshRequestValues.get("txt_delivery")))
			.append("~Feasibility Certificate obtained from Ground Water Survey Department = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_surveydept"))))
			.append("~Clearance certificate from stream / River development = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_clearence"))))
			.append("~Whether Electricity Board agree to give the electricity Connection = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_electricity"))));
			if(correctNull((String )hshRequestValues.get("sel_electricity")).equalsIgnoreCase("1"))
			{
				sbAuditTrial
				.append("~Documents enclosed  =")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_document"))));
			}
			sbAuditTrial
			.append("~Whether cropping pattern propose after development is feasible with reference water availability = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_cropping"))))
			.append("~Whether the water is suitable for irrigation = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_irrigation"))))
			.append("~Whether project report obtained from competent engineer/dealer = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_project"))))
			.append("~Whether Spacing norms between Two Wells,Tube Wells is Maintained ? = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshRequestValues.get("sel_tube"))));
			if(correctNull((String )hshRequestValues.get("sel_tube")).equalsIgnoreCase("1"))
			{
			sbAuditTrial.append("~Distance of the proposed well / Bore well to the nearest Well / Bore Well (feet) = ")
			.append(correctNull((String )hshRequestValues.get("txt_wellDistance")));
			}
			sbAuditTrial
			.append("~Income and Expenses  ^ ")
			.append("~Whether water is proposed to the sold = ")
			.append(SetupParams.getSetupParams("SAABranch",correctNull((String) hshRequestValues.get("sel_waterPropose"))));
			if(correctNull((String) hshRequestValues.get("sel_waterPropose")).equalsIgnoreCase(""))
			{
			sbAuditTrial.append("~Income/Year  = ")
			.append(correctNull((String) hshRequestValues.get("txt_waterProposeInc")));
			}
			sbAuditTrial
			.append("~Net Income from other sources  = ")
			.append(correctNull((String) hshRequestValues.get("sel_netamt_text")))
			.append("~Expected Additional Income after proposed Land Development = ")
			.append(correctNull((String) hshRequestValues.get("txt_exp_additional_income")));
			
			if(correctNull((String) hshRequestValues.get("sel_netamt_text")).equalsIgnoreCase("Available"))
			{
			sbAuditTrial
			.append("~Specify Sources = ")
			.append(correctNull((String) hshRequestValues.get("txt_netamtsource")))
			.append("~Amount/Year =")
			.append(correctNull((String) hshRequestValues.get("txt_netamount")));
			}
			
			sbAuditTrial
			.append("~Electricity/diesel expenses/Annum = ")
			.append(correctNull((String) hshRequestValues.get("txt_elecWorks")))
			.append("~Cost of Electricity Connection ^")
			.append("~For drawing power lines to Farm Rs. = ")
			.append(correctNull((String) hshRequestValues.get("txt_elecDrawing")))
			.append("~Deposit to the Power Supplier Rs. = ")
			.append(correctNull((String) hshRequestValues.get("txt_elecDeposit")))
			;
			}
			AuditTrial.auditNewLog(hshRequestValues, "226", appno, sbAuditTrial.toString(), sbAuditTrialOld.toString());	
			
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
	
	public  HashMap getfarmMechMinorIrrig(HashMap hshValues) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_selfarmmechMinorIrrig^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("agr_appno",correctNull(rs.getString("agr_appno")));
				hshRecord.put("agr_sourcewater",correctNull(rs.getString("agr_sourcewater")));
				hshRecord.put("sel_surveydept",correctNull(rs.getString("sel_surveydept")));
				hshRecord.put("agr_surveydeptRsn",correctNull(rs.getString("agr_surveydeptRsn"))); 
				hshRecord.put("sel_clearence",correctNull(rs.getString("sel_clearence")));
						
				hshRecord.put("agr_clearenceRsn",correctNull(rs.getString("agr_clearenceRsn")));
				hshRecord.put("sel_electricity",correctNull(rs.getString("sel_electricity")));
				//hshRecord.put("agr_electricityRsn",correctNull(rs.getString("agr_electricityRsn"))); 
				hshRecord.put("sel_cropping",correctNull(rs.getString("sel_cropping")));
				hshRecord.put("agr_croppingRsn",correctNull(rs.getString("agr_croppingRsn"))); 
				
				hshRecord.put("sel_irrigation",correctNull(rs.getString("sel_irrigation")));
				hshRecord.put("agr_irrigationRsn",correctNull(rs.getString("agr_irrigationRsn")));
				hshRecord.put("agr_summerlevel",correctNull(rs.getString("agr_summerlevel")));
				hshRecord.put("sel_project",correctNull(rs.getString("sel_project"))); 
				hshRecord.put("agr_projectRsn",correctNull(rs.getString("agr_projectRsn")));
								
				hshRecord.put("agr_projectTime",correctNull(rs.getString("agr_projectTime"))); 
				hshRecord.put("agr_HP",correctNull(rs.getString("agr_HP")));
				hshRecord.put("agr_pondLength",correctNull(rs.getString("agr_pondLength")));
				hshRecord.put("agr_pondBreadth",correctNull(rs.getString("agr_pondBreadth")));
				hshRecord.put("agr_pondHeight",correctNull(rs.getString("agr_pondHeight")));
			
				hshRecord.put("agr_boreDiameter",correctNull(rs.getString("agr_boreDiameter")));
				hshRecord.put("agr_boreHeight",correctNull(rs.getString("agr_boreHeight")));
				hshRecord.put("agr_wellSurveyNo", correctNull(rs.getString("agr_wellSurveyNo")));
				hshRecord.put("agr_wellExtent",correctNull(rs.getString("agr_wellExtent")));
				hshRecord.put("agr_wellOwner",correctNull(rs.getString("agr_wellOwner")));
				
				hshRecord.put("agr_wellDistance",correctNull(rs.getString("agr_wellDistance")));
				hshRecord.put("sel_waterPropose",correctNull(rs.getString("sel_waterPropose")));
				hshRecord.put("agr_waterProposeInc",correctNull(rs.getString("agr_waterProposeInc")));
				hshRecord.put("agr_totIrrigation",correctNull(rs.getString("agr_totIrrigation"))); 
				hshRecord.put("sel_pumpshed",correctNull(rs.getString("sel_pumpshed")));
									
				hshRecord.put("agr_pumpshedArea",correctNull(rs.getString("agr_pumpshedArea"))); 
				hshRecord.put("agr_pumpshedAmt",correctNull(rs.getString("agr_pumpshedAmt")));
				hshRecord.put("agr_elecDrawing",correctNull(rs.getString("agr_elecDrawing")));
				hshRecord.put("agr_elecWorks",correctNull(rs.getString("agr_elecWorks")));
				hshRecord.put("agr_elecDeposit",correctNull(rs.getString("agr_elecDeposit")));
				
				hshRecord.put("agr_agency1",correctNull(rs.getString("agr_agency1")));
				hshRecord.put("agr_agencyAmt1",correctNull(rs.getString("agr_agencyAmt1")));
				hshRecord.put("agr_agency2", correctNull(rs.getString("agr_agency2")));
				hshRecord.put("agr_agencyAmt2",correctNull(rs.getString("agr_agencyAmt2")));
				hshRecord.put("agr_agency3",correctNull(rs.getString("agr_agency3")));
				
				hshRecord.put("agr_agencyAmt3",correctNull(rs.getString("agr_agencyAmt3")));
				hshRecord.put("agr_agency4",correctNull(rs.getString("agr_agency4")));
				hshRecord.put("agr_agencyAmt4", correctNull(rs.getString("agr_agencyAmt4")));
				
				hshRecord.put("sel_netamt",correctNull(rs.getString("sel_netamt")));
				hshRecord.put("agr_netamtsource",correctNull(rs.getString("agr_netamtsource")));
				hshRecord.put("agr_netamount", correctNull(rs.getString("agr_netamount")));
				hshRecord.put("agr_proposedwell", correctNull(rs.getString("agr_proposedwell")));
				hshRecord.put("agr_arragewater",correctNull(rs.getString("agr_arragewater")));
				hshRecord.put("agr_electricitydoc", correctNull(rs.getString("agr_electricitydoc")));
				hshRecord.put("agr_wellmaintained", correctNull(rs.getString("agr_wellmaintained")));
				hshRecord.put("borindsiz", correctNull(rs.getString("borindsiz")));
				hshRecord.put("delivesiz", correctNull(rs.getString("delivesiz")));
				hshRecord.put("agr_expect_addition", correctNull(rs.getString("agr_expect_addition")));
				hshRecord.put("auditFlag", "N");
			}	
			else
			{
				hshRecord.put("auditFlag", "Y");
			}
			
			//ArrayList newVal =  new ArrayList();
			//ArrayList errVal =  new ArrayList();
		}
		catch(Exception ce)
		{
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
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	
	public void updateVehicleParticulars(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshRequestValues.get("hidAction");
		String appno=correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}		
		ResultSet rs = null;
		String selvehicletype = correctNull((String)hshRequestValues.get("sel_vehicletype"));
		String particulars = correctNull((String)hshRequestValues.get("txt_particulars"));
		String make = correctNull((String)hshRequestValues.get("txt_make"));
		String yearofregistration =correctNull((String)hshRequestValues.get("txt_registration"));
		String estimatecost = correctNull((String)hshRequestValues.get("txt_estimcost"));
		if(estimatecost.equalsIgnoreCase(""))
		{
			estimatecost = "0.00";
		}
		String margin = correctNull((String)hshRequestValues.get("txt_margin"));
		if(margin.equalsIgnoreCase(""))
		{
			margin = "0.00";
		}
		String loanamount = correctNull((String)hshRequestValues.get("txt_loanamt"));
		if(loanamount.equalsIgnoreCase(""))
		{
			loanamount = "0.00";
		}
		String particulars1 = correctNull((String) hshRequestValues.get("txt_particulars1"));
		String make1 = correctNull((String) hshRequestValues.get("txt_make1"));
		String yearofregistration1 =correctNull((String)hshRequestValues.get("txt_registration1"));
		String estimatecost1 = correctNull((String)hshRequestValues.get("txt_estimcost1"));
		if(estimatecost1.equalsIgnoreCase(""))
		{
			estimatecost1 = "0.00";
		}
		String margin1 = correctNull((String)hshRequestValues.get("txt_margin1"));
		if(margin1.equalsIgnoreCase(""))
		{
			margin1 = "0.00";
		}
		String loanamount1 = correctNull((String)hshRequestValues.get("txt_loanamt1"));
		if(loanamount1.equalsIgnoreCase(""))
		{
			loanamount1 = "0.00";
		}
		
		String sel_goods = correctNull((String)hshRequestValues.get("sel_goods"));
		String txt_vehicledrive = correctNull((String)hshRequestValues.get("txt_vehicledrive"));
		String age=correctNull((String)hshRequestValues.get("txt_age"));
		String originalcost=correctNull((String)hshRequestValues.get("txt_originalcost"));
		String leastvalue=correctNull((String)hshRequestValues.get("txt_leastvalue"));
		String valuationvechi=correctNull((String)hshRequestValues.get("txt_valuationvechi"));
		String regno=correctNull((String)hshRequestValues.get("txt_regno"));
		String chasisno=correctNull((String)hshRequestValues.get("txt_chasisno"));
		String engineno=correctNull((String)hshRequestValues.get("txt_engineno"));
		String owner=correctNull((String)hshRequestValues.get("txt_owner"));
		String valuationdone=correctNull((String)hshRequestValues.get("txt_valuationdone"));
		String branch=correctNull((String)hshRequestValues.get("sel_branch"));
		String mechanic=correctNull((String)hshRequestValues.get("txt_mechanic"));
		String mechdistance=correctNull((String)hshRequestValues.get("txt_mechdistance"));
		
		
		
		try
		{			
			if(strAction.equals("update"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				hshQuery.put("strQueryId","agr_delvehicleparticulars");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
								
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(selvehicletype);
				if(particulars.equalsIgnoreCase(""))
				{
					particulars = "Nil";
				}
				arrValues.add(particulars);
				arrValues.add(make);
				arrValues.add(yearofregistration);
				arrValues.add(estimatecost);
				arrValues.add(margin);
				arrValues.add(loanamount);
				arrValues.add(particulars1);
				arrValues.add(make1);
				arrValues.add(yearofregistration1);
				arrValues.add(estimatecost1);
				arrValues.add(margin1);
				arrValues.add(loanamount1);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(sel_goods);
				arrValues.add(txt_vehicledrive);
				arrValues.add(age);
				arrValues.add(originalcost);
				arrValues.add(leastvalue);
				arrValues.add(valuationvechi);
				arrValues.add(regno);
				arrValues.add(chasisno);
				arrValues.add(engineno);
				arrValues.add(owner);
				arrValues.add(valuationdone);
				arrValues.add(branch);
				arrValues.add(mechanic);
				arrValues.add(mechdistance);
			
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_insertvehicleparticulars");
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				hshQuery.put("strQueryId","agr_delVehicleApprElig");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","3");
				hshQueryValues.put("3",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_insVehicleApprElig");
				hshQueryValues.put("size","4");
				hshQueryValues.put("4",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			if(strAction.equals("delete"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues.add(appno);
				hshQuery.put("strQueryId","agr_delvehicleparticulars");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				hshQuery.put("strQueryId","agr_delVehicleApprElig");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Inside Update"+e.toString());
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
			catch(Exception ce)
			{
				throw new EJBException("Error closing the Connection"+ce.getMessage());
			}
		}
	}
	
	public  HashMap getVehicleParticulars(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		HashMap hshRecord = new HashMap();
 		double totestim = 0.00, totmargin = 0.00, totloanamt = 0.00, temp1 = 0.00, temp2 = 0.00;
 		
		String appno = correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		
		try
		{
			rs = DBUtils.executeLAPSQuery("agr_Selvehicleparticulars^"+appno);
			if(rs.next())
			{
				hshRecord.put("agr_appno",correctNull((String)rs.getString("agr_appno")));
				hshRecord.put("sel_vehicletype",correctNull((String)rs.getString("sel_vehicletype")));
				hshRecord.put("agr_particulars",correctNull((String)rs.getString("agr_particulars")));
				hshRecord.put("agr_make",correctNull((String)rs.getString("agr_make")));
				hshRecord.put("agr_registration",correctNull((String)rs.getString("agr_registration")));
				
				hshRecord.put("agr_estimcost",correctNull((String)rs.getString("agr_estimcost")));
				hshRecord.put("agr_margin",correctNull((String)rs.getString("agr_margin")));
				hshRecord.put("agr_loanamt",correctNull((String)rs.getString("agr_loanamt")));
				hshRecord.put("agr_particulars1",correctNull((String)rs.getString("agr_particulars1")));
				hshRecord.put("agr_make1",correctNull((String)rs.getString("agr_make1")));
				hshRecord.put("agr_registration1",correctNull((String)rs.getString("agr_registration1")));
				
				hshRecord.put("agr_estimcost1",correctNull((String)rs.getString("agr_estimcost1")));
				hshRecord.put("agr_margin1",correctNull((String)rs.getString("agr_margin1")));
				hshRecord.put("agr_loanamt1",correctNull((String)rs.getString("agr_loanamt1")));
				hshRecord.put("repay_mon",correctNull((String)rs.getString("repay_mon")));
				hshRecord.put("repay_period",correctNull((String)rs.getString("repay_period")));

				hshRecord.put("sel_repay",correctNull((String)rs.getString("sel_repay")));
				hshRecord.put("repay_amount",correctNull((String)rs.getString("repay_amount")));
				hshRecord.put("repay_lastamt",correctNull((String)rs.getString("repay_lastamt")));
				
				temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_estimcost")));
				temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_estimcost1")));
				totestim = temp1 + temp2;
				
				temp1 = temp2 = 0;
				temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_margin")));
				temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_margin1")));
				totmargin = temp1 + temp2;
				
				temp1 = temp2 = 0;
				temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_loanamt")));
				temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_loanamt1")));
				totloanamt = temp1 + temp2;
				
				hshRecord.put("totestimcost", Helper.formatDoubleValue(totestim));
				hshRecord.put("totmarginamt", Helper.formatDoubleValue(totmargin));
				hshRecord.put("totloanamt", Helper.formatDoubleValue(totloanamt));
				hshRecord.put("sel_goods",correctNull((String)rs.getString("agr_goods")));
				hshRecord.put("txt_vehicledrive",correctNull((String)rs.getString("agr_vehicledrive")));
				hshRecord.put("agr_age", correctNull(rs.getString("agr_age")));
				hshRecord.put("agr_originalcost",correctNull(rs.getString("agr_originalcost")));
				hshRecord.put("agr_valuercost",correctNull(rs.getString("agr_valuercost")));
				hshRecord.put("agr_leastvalue",correctNull(rs.getString("agr_leastvalue")));
				hshRecord.put("agr_regno", correctNull(rs.getString("agr_regno")));
				hshRecord.put("agr_chasisno",correctNull(rs.getString("agr_chasisno")));
				hshRecord.put("agr_engineno",correctNull(rs.getString("agr_engineno")));
				hshRecord.put("agr_owner",correctNull(rs.getString("agr_owner")));
				hshRecord.put("agr_valuationdoneby",correctNull(rs.getString("agr_valuationdoneby")));
				hshRecord.put("agr_panel",correctNull(rs.getString("agr_panel")));
				hshRecord.put("txt_mechanic",correctNull(rs.getString("agr_mechanic")));
				hshRecord.put("txt_mechdistance",correctNull(rs.getString("agr_mechdistance")));
				
				
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Inside getVehicleParticulars"+e);
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
			catch(Exception ce)
			{
				throw new EJBException("Error closing the Connection"+ce.getMessage());
			}
		}
		return hshRecord;
	}
	
	//=============================== Vehicle Applicant Particulars ==============================================
	
	public void updateVehicleApplicantPart(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = null;
		
		String appno = correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshRequestValues.get("strappno"));
		}
		String hidAction = correctNull((String)hshRequestValues.get("hidAction"));
		String chkapprUpdval = correctNull((String)hshRequestValues.get("chkappraisalUpd"));
		try
		{	
			if(hidAction.equalsIgnoreCase("update"))
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delVehicleApplicantPart");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshRequestValues.get("txt_agriAmt")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_otherSource")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_otherSourceInc")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_totIncome")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_familyExp")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_exi_loanRepay")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_totExpenditure")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_netsurplus")));
				arrValues.add(correctNull((String)hshRequestValues.get("txt_netWorth")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId","agr_updVehicleApplicantPart");
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				if(chkapprUpdval.equalsIgnoreCase("True"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					
					arrValues.add(correctNull((String)hshRequestValues.get("repay_monAppr")));
					arrValues.add(correctNull((String)hshRequestValues.get("repay_periodAppr")));
					arrValues.add(correctNull((String)hshRequestValues.get("sel_repayAppr")));
					arrValues.add(correctNull((String)hshRequestValues.get("repay_amountAppr")));
					arrValues.add(correctNull((String)hshRequestValues.get("repay_lastamtAppr")));
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","agr_updVehicleApprElig");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					
				}
				
			}
			else if(hidAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_delVehicleApplicantPart");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Inside updateVehicleApplicantPart"+e);
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
			catch(Exception fe)
			{
				throw new EJBException("Error Closing connection"+fe);
			}
		}
	}
	
	
	public HashMap getVehicleApplicantPart(HashMap hshValues) 
	{
		
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1=null;
		String chkappraisalvalue = correctNull((String)hshValues.get("chkappraisal"));
		String appno = correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		
		try
		{
			rs = DBUtils.executeLAPSQuery("agr_selVehicleApplicantPart^"+appno);
			if(rs.next())
			{
				hshRecord.put("agr_agriAmt",correctNull((String)rs.getString("agr_agriAmt")));
				hshRecord.put("agr_otherSource",correctNull((String)rs.getString("agr_otherSource")));
				hshRecord.put("agr_otherSourceInc",correctNull((String)rs.getString("agr_otherSourceInc")));
				hshRecord.put("agr_totIncome",correctNull((String)rs.getString("agr_totIncome")));
				hshRecord.put("agr_familyExp",correctNull((String)rs.getString("agr_familyExp")));
				hshRecord.put("agr_exi_loanRepay",correctNull((String)rs.getString("agr_exi_loanRepay")));
				hshRecord.put("agr_totExpenditure",correctNull((String)rs.getString("agr_totExpenditure")));
				hshRecord.put("agr_netsurplus",correctNull((String)rs.getString("agr_netsurplus")));
				hshRecord.put("agr_netWorth",correctNull((String)rs.getString("agr_netWorth")));
			}
			
			
//========================================== Net worth from Financial============================================
			
			  java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			 
			  
				nf.setGroupingUsed(false);
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				//ArrayList vecReport=new ArrayList();
				ArrayList vecCoapp=null;
				String strType="";
				String strbankbal="";
				String strshare="";
				String strinsurance="";
				String strpermovprop="";
				String strperimmovprop="";
				String strtotlia="";
				String TotalMoveable ="";
				String TotalAssets="";
				String NetAssets="";
				String strId="";
				String strQuery1="";			
				rs=DBUtils.executeLAPSQuery("appreport_3^"+appno);
				 
				while(rs.next())
				{				
					vecCoapp=new ArrayList();
					strType=correctNull(rs.getString("demo_type"));
					strId=strType+correctNull(rs.getString("demo_appid"));
					strQuery1 = SQLParser.getSqlQuery("appreport_2^"+strId+"^"+appno+"^"+strId+"^"+appno+"^"+strId+"^"+appno+"^"+strId+"^"+appno+"^"+strId+"^"+appno+"^"+appno+"^"+strId);
					rs1=DBUtils.executeQuery(strQuery1);
					if (rs1.next())
					{				
						strbankbal=Helper.correctDouble((String)rs1.getString("bankbal"));
						strshare=Helper.correctDouble((String)rs1.getString("shares"));
						strinsurance=Helper.correctDouble((String)rs1.getString("insurance"));
						strpermovprop=Helper.correctDouble((String)rs1.getString("permovprop"));
						strperimmovprop=Helper.correctDouble((String)rs1.getString("perimmovprop"));
						strtotlia=Helper.correctDouble((String)rs1.getString("totlia"));
						TotalMoveable=nf.format(
						Double.parseDouble(Helper.correctDouble((String)strbankbal))+
						Double.parseDouble(Helper.correctDouble((String)strinsurance))+
						Double.parseDouble(Helper.correctDouble((String)strpermovprop))+
						Double.parseDouble(Helper.correctDouble((String)strshare)));
						TotalAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalMoveable))+
						Double.parseDouble(Helper.correctDouble((String)strperimmovprop)));
						NetAssets=nf.format(Double.parseDouble(Helper.correctDouble((String)TotalAssets))-
						Double.parseDouble(Helper.correctDouble((String)strtotlia)));
						vecCoapp.add(NetAssets);
					}				
				}
				//hshRecord.put("agr_netWorth",NetAssets);
				
// ===================================== Appraisal Cum Eligibility ===============================================
				
		if(chkappraisalvalue.equalsIgnoreCase("True"))
		{	
				
				double totestim = 0.00, totmargin = 0.00, totloanamt = 0.00, temp1 = 0.00, temp2 = 0.00;
		 		
				rs = DBUtils.executeLAPSQuery("agr_Selvehicleparticulars^"+appno);
				if(rs.next())
				{
					hshRecord.put("agr_appno",correctNull((String)rs.getString("agr_appno")));
					hshRecord.put("sel_vehicletype",correctNull((String)rs.getString("sel_vehicletype")));
					hshRecord.put("agr_particulars",correctNull((String)rs.getString("agr_particulars")));
					hshRecord.put("agr_make",correctNull((String)rs.getString("agr_make")));
					hshRecord.put("agr_registration",correctNull((String)rs.getString("agr_registration")));
					
					hshRecord.put("agr_estimcost",correctNull((String)rs.getString("agr_estimcost")));
					hshRecord.put("agr_margin",correctNull((String)rs.getString("agr_margin")));
					hshRecord.put("agr_loanamt",correctNull((String)rs.getString("agr_loanamt")));
					hshRecord.put("agr_particulars1",correctNull((String)rs.getString("agr_particulars1")));
					hshRecord.put("agr_make1",correctNull((String)rs.getString("agr_make1")));
					hshRecord.put("agr_registration1",correctNull((String)rs.getString("agr_registration1")));
					
					hshRecord.put("agr_estimcost1",correctNull((String)rs.getString("agr_estimcost1")));
					hshRecord.put("agr_margin1",correctNull((String)rs.getString("agr_margin1")));
					hshRecord.put("agr_loanamt1",correctNull((String)rs.getString("agr_loanamt1")));
					/*hshRecord.put("repay_mon",correctNull((String)rs.getString("repay_mon")));
					hshRecord.put("repay_period",correctNull((String)rs.getString("repay_period")));

					hshRecord.put("sel_repay",correctNull((String)rs.getString("sel_repay")));
					hshRecord.put("repay_amount",correctNull((String)rs.getString("repay_amount")));
					hshRecord.put("repay_lastamt",correctNull((String)rs.getString("repay_lastamt"))); */
					
					temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_estimcost")));
					temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_estimcost1")));
					totestim = temp1 + temp2;
					
					temp1 = temp2 = 0;
					temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_margin")));
					temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_margin1")));
					totmargin = temp1 + temp2;
					
					temp1 = temp2 = 0;
					temp1 = Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_loanamt")));
					temp2 =	Double.parseDouble(Helper.correctDouble((String)rs.getString("agr_loanamt1")));
					totloanamt = temp1 + temp2;
					
					hshRecord.put("totestimcost", Helper.formatDoubleValue(totestim));
					hshRecord.put("totmarginamt", Helper.formatDoubleValue(totmargin));
					hshRecord.put("totloanamt", Helper.formatDoubleValue(totloanamt));
				}
				
				rs = DBUtils.executeLAPSQuery("agr_selVehicleApprElig^"+appno);
				if(rs.next())
				{
					hshRecord.put("repay_mon",correctNull((String)rs.getString("agr_repay_monAppr")));
					hshRecord.put("repay_period",correctNull((String)rs.getString("agr_repay_periodAppr")));
					hshRecord.put("sel_repay",correctNull((String)rs.getString("agr_sel_repayAppr")));
					hshRecord.put("repay_amount",correctNull((String)rs.getString("agr_repay_amountAppr")));
					hshRecord.put("repay_lastamt",correctNull((String)rs.getString("agr_repay_lastamtAppr")));
				} 
		}//if chkappraisalvalue		
// ===================================== End of Appraisal cum Eligibility ===========================================

		}
		catch(Exception e)
		{
			throw new EJBException("Error in bean connection"+e);
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception fe)
			{
				throw new EJBException("Error Closing connection"+fe);
			}
		}
		return hshRecord;
	}
	
	public  HashMap getUpdateQueryData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;
 		//String strOrgShortCode = "";
 		String strQuery = "";
 		String strAppno=null;
 		HashMap hshRecord = new HashMap();
 		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
 		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
 		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
 		String oldorgscode ="";
 		String neworgscode ="";
 		oldorgscode= correctNull((String)hshValues.get("sel_oldorg")); //with 0
 		neworgscode= correctNull((String)hshValues.get("sel_neworg")); //without 0
 		String oldzeroappno = "";
		long longAppno=0;
		int intLen=0;
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_changeorgcode^" + oldorgscode);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				intLen=neworgscode.length();
				strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+neworgscode);
				rs =DBUtils.executeQuery(strQuery);

				if(rs.next())
				{
					longAppno=rs.getLong(1);
				}
				longAppno++;
				strAppno=neworgscode + nf.format(longAppno);
				oldzeroappno = correctNull((String)rs1.getString("app_no"));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(oldzeroappno);
				arrValues.add(strAppno);
				arrValues.add(oldorgscode);
				arrValues.add(neworgscode);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_orgcode");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(oldzeroappno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_orgcode");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception fe)
			{
				throw new EJBException("Error Closing connection"+fe);
			}
		}
		return hshRecord;
	}
	
	public void updatechangeorgData(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		//String oldorgscode = "";
		ArrayList arrValues=new ArrayList();
		String withzeroappno="";
		String withoutzeroappno ="";
		String strQuery ="", strQuery1 ="";
		ResultSet rs = null;
		ResultSet rs1= null;

		String app_deviation = "app_deviation";
		//String app_enclosures = "app_enclosures"; 
		//String app_history = "app_history"; 
		//String app_termsandcond = "app_termsandcond"; 
		//String appdocscanning = "appdocscanning"; 
		//String appdocuments = "appdocuments"; 
		//String appmailbox = "appmailbox"; 
		//String appraisalQuest = "appraisalQuest";
		//String appraisalsanction = "appraisalsanction"; 
		//String branch_ref_comments = "branch_ref_comments"; 
		//String edu_course = "edu_course"; 
		//String edu_details = "edu_details"; 
		//String edu_loan = "edu_loan"; 
		//String edu_scholar = "edu_scholar"; 
		//String edu_student = "edu_student"; 
		//String emiabcdlogic = "emiabcdlogic";
		//String legalopinion = "legalopinion";  
		//String loandetails = "loandetails"; 
		//String mailbox_comments = "mailbox_comments"; 
		//String operational_viability = "operational_viability"; 
		//String per_auto = "per_auto"; 
		//String per_bank = "per_bank"; 
		/*String per_conf_info = "per_conf_info"; 
		String per_conf_informants = "per_conf_informants"; 
		String per_demographics = "per_demographics"; 
		String per_disbdetails = "per_disbdetails"; 
		String per_home = "per_home"; 
		String per_insurance = "per_insurance"; 
		String per_legalheirs = "per_legalheirs"; 
		String per_liabilities = "per_liabilities"; 
		String per_lifestyle = "per_lifestyle"; 
		String per_loan_secure = "per_loan_secure"; 
		String per_otherassets = "per_otherassets"; 
		String per_properties = "per_properties"; 
		String per_security = "per_security"; 
		String per_step_updown = "per_step_updown"; 
		String per_stocks = "per_stocks"; 
		String perapp_Apprisal = "perapp_Apprisal"; 
		String perapp_takeover = "perapp_takeover"; 
		String perpropertydet = "perpropertydet";
		String prop_generalinfo = "prop_generalinfo";
		String post_disbursal = "post_disbursal";
		String rental_propdet = "rental_propdet"; 
		String valuationentry = "valuationentry"; */
		
		String appno = "appno";
		/*String app_no = "appno";
		String branch_refno = "branch_refno";
		String app_termappno = "app_termappno";
		String appscan_appno = "appscan_appno";
		String apdoc_appno = "apdoc_appno";
		String mail_appno = "mail_appno";
		String edu_appno = "edu_appno";
		String edudetail_appno = "edudetail_appno";
		String eduloan_appno = "eduloan_appno";
		String eduscholar_appno = "eduscholar_appno"; 
		String loan_appno = "loan_appno";
		String proc_appno = "proc_appno"; 
		String serv_appno = "serv_appno"; 
		String ope_appno = "ope_appno"; 
		String auto_appno = "auto_appno";
		String bank_appno = "bank_appno";
		String per_appno = "per_appno"; 
		String demo_appno = "demo_appno"; 
		String home_appno = "home_appno"; 	
		String insu_appno = "insu_appno";
		String legal_appno = "legal_appno";
		String liab_appno = "liab_appno"; 
		String lifestyle_appno = "lifestyle_appno"; 
		String asset_appno = "asset_appno";  
		String prop_appno = "prop_appno"; 
		String stoc_appno = "stoc_appno"; 
		String prop_appid = "prop_appid"; */

		try
		{			
			strQuery = SQLParser.getSqlQuery("sel_oldappno");
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				withzeroappno = correctNull((String)rs1.getString("old_appno"));
				withoutzeroappno = correctNull((String)rs1.getString("new_appno"));
				
				strQuery1 = SQLParser.getSqlQuery("sel_tablename^" + appno + "^" +app_deviation +"^" + appno + "^" + withzeroappno);
				rs = DBUtils.executeQuery(strQuery1);
				while(rs.next())
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(withoutzeroappno);
					arrValues.add(withzeroappno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_tablename");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					hshQuery.put("arrValues",arrValues);
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
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	private void updateProductMargin(HashMap hshValues)
	{
		String appno="";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strQuery = "";
		String strAction="";
		//ArrayList arrValues = new ArrayList();		
		ResultSet rs = null;
		
		try
		{		
			appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno=correctNull((String)hshValues.get("strappno"));
			}
				
			strQuery = SQLParser.getSqlQuery("select_product_margin^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				strAction="update";
			}
			else
			{
				strAction="insert";
			}
			if(rs!=null)
				rs.close();
			
			if(strAction.trim().equals("insert"))				
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				ArrayList arrvalues=new ArrayList();
				
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","insert_product_margin");
				
				arrvalues.add(appno);
				arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent")));
				arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent2")));
				arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent3")));
				arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent4")));
				hshQuery.put("arrValues",arrvalues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.trim().equals("update"))
			{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();	
					ArrayList arrvalues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","update_product_margin");
					
					arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent")));
					arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent2")));
					arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent3")));
					arrvalues.add(correctNull((String )hshValues.get("txt_marginpercent4")));
					arrvalues.add(appno);
					
					hshQuery.put("arrValues",arrvalues);
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
			}
			else if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				ArrayList arrvalues=new ArrayList();
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","delete_product_margin");
				arrvalues.add(appno);
				
				hshQuery.put("arrValues",arrvalues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("inside update"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ex)
			{
				throw new EJBException("Exception while closing result set "+ex.getMessage());
			}
		}
	}
	
	public HashMap getfarmMechreport(HashMap hsh) 
	{
 		String strOrgAdd1="",strOrgAdd2="",strOrgzip="",strOrgstate="",strOrgphone="",strOrgfax="",strOrgurl="",strorgname="";
		String strCityName="",strOrgtaxid="",strBranchName="";
		String strQuery="";
		ResultSet rs=null;	
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal1=new ArrayList();
		
		ArrayList vecData2 = new ArrayList();
		ArrayList vecVal2=new ArrayList();
		
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;	
		double netincpre=0.00, netincpost=0.00,dbTotal=0.00;
		
		String flag = "";
		
		String prd_type = correctNull((String)hsh.get("strProductType"));
		
		try
		{
			
			
			String strappno = correctNull((String)hsh.get("appno")); 
			String	appname=correctNull((String)hsh.get("appname"));
			String strOrganisationCode=(String)hsh.get("strOrgCode");
			String strOrganisationName=(String)hsh.get("strOrgName");
			hsh.put("appname",appname);
//			Assest Disbursing Branch
			hsh.put("OrganisationName",strOrganisationName);
			hsh.put("OrganisationCode",strOrganisationCode); 
			
		    
			strQuery=SQLParser.getSqlQuery("selapplicant_byappno^"+strappno+"^a"); 
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				String perapp_fname=correctNull((String)rs.getString("perapp_fname"));
				strBranchName=correctNull(rs.getString("perapp_recfrom"));
				flag="0";
				String name=(perapp_fname);
				hsh.put("appname",name);
			}
				
		
			
//This Code is used for Organisation details
			
			String strorglevel="";
			if(rs!=null)
			{
				rs.close();
			}			
			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+strappno);
			while (rs.next())
			{ 
				strorgname=correctNull(rs.getString("org_name"));
				strorglevel=correctNull(rs.getString("org_level"));
				strCityName=correctNull(rs.getString("org_city"));
				strOrgAdd1=correctNull(rs.getString("org_add1"));
				strOrgAdd2=correctNull(rs.getString("org_add2"));
				strOrgzip=correctNull(rs.getString("org_Zip"));
				strOrgstate=correctNull(rs.getString("org_state"));
				strOrgphone=correctNull(rs.getString("org_phone"));
				strOrgfax=correctNull(rs.getString("org_fax"));
				strOrgurl=correctNull(rs.getString("org_url"));		
				strOrgtaxid=correctNull(rs.getString("org_taxid"));		
			}
			
			String orgcode=correctNull((String)hsh.get("strOrgCode"));
			String strRegion="";
			if(!strorglevel.equalsIgnoreCase("C")){
				String orgStartcode=orgcode.substring(0,6);
				orgStartcode=orgStartcode+"%";
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_region^"+orgStartcode);
			if (rs.next())  
			{ 
				strRegion=rs.getString("org_name");
			}
		}
			hsh.put("Region_Name",strRegion);	
		
		
		if(strBranchName==null || strBranchName.equals(""))
		{
			strBranchName=strorgname; 

			flag="1";
		}	
		if(flag=="1")
		{
			hsh.put("cityName",strCityName);
			hsh.put("strOrgAdd1",strOrgAdd1);
			hsh.put("strOrgAdd2",strOrgAdd2);
			hsh.put("strOrgzip",strOrgzip);
			hsh.put("strOrgstate",strOrgstate);
			hsh.put("strOrgphone",strOrgphone);
			hsh.put("strOrgfax",strOrgfax);
			hsh.put("strOrgurl",strOrgurl);
			hsh.put("strOrgtaxid",strOrgtaxid);
		}
		hsh.put("flag",flag);
		hsh.put("branchName",strBranchName);			

			
		rs=DBUtils.executeLAPSQuery("agr_selcroppingpattern^"+strappno);
		 
		while (rs.next())
		{
			arryCol=new ArrayList();
			arryCol.add(rs.getString("appno"));
			arryCol.add(rs.getString("season"));
			arryCol.add(rs.getString("sno"));
			arryCol.add(rs.getString("crop_name"));	
			double bmacre=Double.parseDouble(Helper.correctDouble((String)rs.getString("crop_areaie")));
			bmacre=bmacre+Double.parseDouble(Helper.correctDouble((String)rs.getString("crop_areare")));
			arryCol.add(Helper.formatDoubleValue(bmacre));
			double amacre=Double.parseDouble(Helper.correctDouble((String)rs.getString("crop_areaip")));
			amacre=amacre+Double.parseDouble(Helper.correctDouble((String)rs.getString("crop_arearp")));
			arryCol.add(Helper.formatDoubleValue(amacre));
			arryCol.add(rs.getString("crop_yielde"));
			arryCol.add(rs.getString("crop_propcoste"));
			arryCol.add(rs.getString("crop_coste"));
			arryCol.add(rs.getString("crop_costp"));
			arryCol.add(rs.getString("crop_exiyield"));
			arryCol.add(rs.getString("crop_propyield"));
			arryCol.add(rs.getString("crop_yielde"));
			arryCol.add(rs.getString("crop_yieldp"));
			arryCol.add(rs.getString("crop_exitotincome"));
			arryCol.add(rs.getString("crop_proptotincome"));
			arryCol.add(rs.getString("crop_grossincomee"));
			arryCol.add(rs.getString("crop_grossincomep"));
			arryCol.add(rs.getString("crop_netincomee"));
			arryCol.add(rs.getString("crop_netincomep"));
			arryCol.add(rs.getString("crop_exicoste"));
			netincpost=netincpost + Double.parseDouble((Helper.correctDouble((String)rs.getString("crop_netincomep"))));
			netincpre=netincpre + Double.parseDouble((Helper.correctDouble((String)rs.getString("crop_netincomee"))));
			arryRow.add(arryCol);
		}
		hsh.put("crop",arryRow);
		hsh.put("netincpre",Helper.formatDoubleValue(netincpre));
		hsh.put("netincpost",Helper.formatDoubleValue(netincpost));
		

		strQuery = SQLParser.getSqlQuery("agr_farmsel^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
		hsh.put("agr_repair_cost",correctNull(rs.getString("agr_repair_cost")));
		hsh.put("agr_fuel_cost",correctNull(rs.getString("agr_fuel_cost")));
		hsh.put("agr_insurence",correctNull(rs.getString("agr_insurence")));
		hsh.put("agr_other_cost",correctNull(rs.getString("agr_other_cost")));
		hsh.put("agr_salary",correctNull(rs.getString("agr_salary")));
		
		hsh.put("agr_cmember",correctNull(rs.getString("agr_cmember")));
		hsh.put("agr_bullock_cost_am",correctNull(rs.getString("agr_bullock_cost")));
		hsh.put("agr_interest_am",correctNull(rs.getString("agr_interest")));
		hsh.put("agr_bullock_cost_bm",correctNull(rs.getString("agr_bullockcostbm")));
		hsh.put("agr_interest_bm",correctNull(rs.getString("agr_interestbm")));
		hsh.put("agr_ratehour",correctNull(rs.getString("agr_ratehour")));
		hsh.put("agr_cmachinery",correctNull(rs.getString("agr_cmachinery")));
		}
	
		strQuery = SQLParser.getSqlQuery("agr_farmloan^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			String strperiod = Helper.correctDouble(rs.getString("loan_periodicity"));
			String strper="";
			
			if(strperiod.equalsIgnoreCase("m"))
			{
				strper="Monthly";
			}
			else if(strperiod.equalsIgnoreCase("q"))
			{
				strper="Quarterly";
			}
			else if(strperiod.equalsIgnoreCase("h"))
			{
				strper="Half-Yearly ";
			}
			else if(strperiod.equalsIgnoreCase("y"))
			{
				strper="Yearly";
			}
			hsh.put("loan_amtreqd",correctNull(rs.getString("loan_amtreqd")));
		    hsh.put("strper",(strper));
		}
		
		strQuery = SQLParser.getSqlQuery("agr_farmloanamt^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			hsh.put("totloanamt",correctNull(rs.getString("totloanamt")));
		
		
		}
		
		strQuery = SQLParser.getSqlQuery("selagrcal^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			hsh.put("loanmodintrate",correctNull(rs.getString("loanmodintrate")));
			hsh.put("payment",correctNull(rs.getString("payment")));
		}
		
		
		strQuery = SQLParser.getSqlQuery("sellandrevenue^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			hsh.put("landrevenue",correctNull(rs.getString("landrevenue")));
			
		}
		
		strQuery = SQLParser.getSqlQuery("seltotalirr^"+strappno);
		if(rs!=null)
		{
			rs.close();
		}
		rs =DBUtils.executeQuery(strQuery);
		
		if(rs.next())
		{
			hsh.put("totalirrigated",correctNull(rs.getString("totalirrigated")));
			hsh.put("totalunirr",correctNull(rs.getString("totalunirr")));
			
			if(!correctNull(rs.getString("totalirrigated")).equalsIgnoreCase("") && !correctNull(rs.getString("totalunirr")).equalsIgnoreCase("")){
				dbTotal = Double.parseDouble(Helper.correctDouble(rs.getString("totalirrigated"))) +
							Double.parseDouble(Helper.correctDouble(rs.getString("totalunirr")));
			}
			hsh.put("dbTotal",Helper.formatDoubleValue(dbTotal));	
		}
		
		strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+strappno+ "^" +prd_type);			
		rs1 =DBUtils.executeQuery(strQuery);
		while(rs1.next())
		{
			hsh.put("txt_loanamount",correctNull(rs1.getString("loanamount")));
		}
		
		if(rs2 !=null)
		{
			rs.close();
		}
		String strProdPurpose="";
		strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strappno);
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next()){strProdPurpose=Helper.correctNull((String)rs2.getString("prd_purpose"));}
		/*
		 * 			For Purchase of Ready Built House and Used Vehicle loan, 
		 * 				Margin is based on age of the building / vehicle respectively
		 */
		if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
		{
			strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strappno);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strappno);
		}
		if(rs2 !=null)
		{
			rs2.close();
		}
		rs2 =DBUtils.executeQuery(strQuery);
		while(rs2.next())
		{
			hsh.put("lreqterms",correctNull(rs2.getString("lreqterms")));
		}
		if(rs2!=null)
			rs2.close();
		
		strQuery = SQLParser.getSqlQuery("selAppLandAcerage^"+strappno);
		rs3 =DBUtils.executeQuery(strQuery);
		while(rs3.next())
		{
			vecVal = new ArrayList();
			vecVal.add(correctNull(rs3.getString("land_appno")));
			vecVal.add(correctNull(rs3.getString("land_apptype")));
			vecVal.add(correctNull(rs3.getString("land_acreage")));
			vecVal.add(correctNull(rs3.getString("land_acreage1")));
			vecData.add(vecVal);	
			
		}
			hsh.put("vecData",vecData);
			if(rs3!=null)
				rs3.close();
		strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+strappno);
		rs3 = DBUtils.executeQuery(strQuery);
		if(rs3.next())
		{
			hsh.put("land_measurement",correctNull(rs3.getString("land_measurement")));
		}
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeLAPSQuery("selLandAcreage^" + strappno);
		if (rs.next())
		{
			hsh.put("strAcress", correctNull((String) rs.getString(1)));
			
		}
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeLAPSQuery("selIrrigatedLandAcreage^"+strappno);
		while (rs.next())
		{
			vecVal1 = new ArrayList();
			vecVal1.add(correctNull(rs.getString("land_acreage")));
			vecVal1.add(correctNull(rs.getString("land_acreage1")));
			vecData1.add(vecVal1);	
		}
			hsh.put("vecData1",vecData1);
			
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeLAPSQuery("selUnIrrigatedLandAcreage^"+strappno);
		while (rs.next())
			{
				vecVal2 = new ArrayList();
				vecVal2.add(correctNull(rs.getString("land_acreage")));
				vecVal2.add(correctNull(rs.getString("land_acreage1")));
				vecData2.add(vecVal2);	
			}
				hsh.put("vecData2",vecData2);	
				if(rs != null)
				{
					rs.close();
					rs=null;
				}
				strQuery=SQLParser.getSqlQuery("agr_sel_bullockrepay^"+strappno+"^"+prd_type); 
				rs=DBUtils.executeQuery(strQuery);
				//rs=DBUtils.executeLAPSQuery("agr_sel_bullockrepay^"+appno+"^"+prdtype);
				if(rs.next())
				{
					hsh.put("bullock_holiday",correctNull((String)rs.getString("bullock_holiday")));
					String period=correctNull((String)rs.getString("bullock_payment"));
					String selperiod="";
					int intperiod=0;
					if(period.equalsIgnoreCase("m"))
					{
						selperiod="Monthly";
						intperiod=1;
					}
					else if(period.equalsIgnoreCase("q"))
					{
						selperiod="Quarterly";
						intperiod=3;
					}
					else if(period.equalsIgnoreCase("h"))
					{
						selperiod="Half-Yearly";
						intperiod=6;
					}
					else if(period.equalsIgnoreCase("y"))
					{
						selperiod="Yearly";
						intperiod=12;
					}
					hsh.put("selperiod",selperiod);
					hsh.put("period",""+intperiod);
				}
		}
		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs3!=null)
					rs3.close();
				if(rs1!=null)
					rs1.close();
				if(rs2!=null)
					rs2.close();
			}
			catch(Exception ex)
			{
				throw new EJBException("Exception while closing result set "+ex.getMessage());
			}
		}
		
			return hsh;
	}
	/*
	 * @Added for Fisheries on 07/12/2013 by Anees.H
	 */
	public  HashMap getFisheryParticularsData(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		String strschemetype="";
		String stragrschemetype="", strfacsno="";
		HashMap hshScheme=new HashMap();
		try
		{
			String appno	= Helper.correctNull((String )hshValues.get("appno"));	
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_fishery_particulars_select^" + appno + "^" + strfacsno + "^" + stragrschemetype);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(Helper.correctNull(rs.getString("af_particulars")));
				vecRow.add(Helper.correctNull(rs.getString("af_presentposition")));
				vecRow.add(Helper.correctNull(rs.getString("af_proposeddevelopment")));
				vecData.add(vecRow);
			}
			if(rs!=null){
				rs.close();
			}
			if(vecData.size()==0)
			{
				String[] strarrayParticulars={"Total water area (acre)","Effective water area for Pisciculture (acre)",
											  "Nature of fisheries","Varieties of fishes grown / to be grown",
											  "Cultural operations with details","Maintenance","Nutritional requirements of fish",
											  "Others"};
				for(int i=0;i<strarrayParticulars.length;i++)
				{
					vecRow = new ArrayList();
					vecRow.add(strarrayParticulars[i]);
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
			hshRecord.put("vecData",vecData);			
		}
		catch(Exception ce)
		{	
			log.error(ce);
			throw new EJBException("Error in getFisheryParticularsData "+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null){
					rs.close();
				}
			}catch(Exception exp)
			{	log.error(exp);
				throw new EJBException("Error in closing the connection in getFisheryParticularsData "+ exp.toString()); 
			}
		}
		
		return hshRecord;
	}	
	public void updateFisheryParticularsData(HashMap hshRequestValues) 
	{
 		String appno= Helper.correctNull((String)hshRequestValues.get("appno"));
		String strappno= Helper.correctNull((String)hshRequestValues.get("strappno"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		String strfacsno="",stragrschemetype="";
		String[] particulars = null;
		String[] strarrayPresentPosition = null;
		String[] strarrayProposedDevelopment = null;
		String hidAction= Helper.correctNull((String)hshRequestValues.get("hidAction"));
		String strschemetype	= Helper.correctNull((String )hshRequestValues.get("schemetype"));	
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(strschemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		
		try
		{		
			particulars = (String[]) hshRequestValues.get("txt_particulars");
			strarrayPresentPosition = (String[]) hshRequestValues.get("txtarea_presentposition");
			strarrayProposedDevelopment = (String[]) hshRequestValues.get("txtarea_proposeddevelopment");
						
		if(hidAction.equalsIgnoreCase("update"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "agr_fishery_particulars_delete");
			arrValues3.add(appno);
			arrValues3.add(strfacsno);
			arrValues3.add(stragrschemetype);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			for(int i=0; i<particulars.length; i++)
			{
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(Integer.toString(i+1));
				arrValues.add(particulars[i]);
				arrValues.add(strarrayPresentPosition[i]);
				arrValues.add(strarrayProposedDevelopment[i]);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_fishery_particulars_insert");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}	
		}		
	
		if(hidAction.equalsIgnoreCase("delete"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "agr_fishery_particulars_delete");
			arrValues3.add(appno);
			arrValues3.add(strfacsno);
			arrValues3.add(stragrschemetype);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
		}
			
	  }		
	  catch(Exception ce)
	  {	
		  log.error(ce);
			throw new EJBException("Exception occurred in updateFisheryParticularsData"+ce.toString());
	  }		
	}
	
	
	//ProjectDetails created by Venkat Prasad on 07/12/2013
	public HashMap getSericultreProjectDetails(HashMap hshValues)  
	{
		String strQuery="";
		ResultSet rs = null; 
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrVal;
		String strappno="",agr_schemeType="",agr_schemeSno="";
		
		try 
		{
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			String schemetype=correctNull((String)hshValues.get("schemetype"));
			agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			agr_schemeSno=Helper.getfacilitySno(schemetype);
			

			strQuery = SQLParser.getSqlQuery("agr_sericulture_projectdetails_select^"+strappno+"^"+agr_schemeSno+"^"+agr_schemeType);	
			
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("agr_area_mulberry",rs.getString("agr_area_mulberry"));
					hshRecord.put("agr_marketingarrangements",rs.getString("agr_marketingarrangements"));
					hshRecord.put("agr_total",rs.getString("agr_total"));
				}
				if(rs!=null){
					rs.close();
				}
				hshRecord.put("schemetype",agr_schemeType);
				hshRecord.put("schemetype",Helper.correctNull((String)hshValues.get("strappstatus")));
				
		}catch (Exception e) 
		{	log.error(e);	
		throw new EJBException("Error in getSericultreProjectDetails - agrEconomicBean"+e.toString());
			
		}
		finally
		{
			try 
			{	
				if(rs!=null){
					rs.close();
				}
			}
			catch (SQLException e) 
			{	log.error(e);	
				throw new EJBException("Error in getSericultreProjectDetails - agrEconomicBean "+e.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateSericultreProjectDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="",schemetype="",agr_schemeType="",agr_schemeSno="",strtotal="";
	
		
		try
		{		
			
			String strMulberry			=  	Helper.correctNull((String)hshValues.get("txt_mulberry"));
			String strCocoon			=   Helper.correctNull((String)hshValues.get("txt_cocoon"));
			appno=Helper.correctNull((String)hshValues.get("appno"));
			schemetype=correctNull((String)hshValues.get("schemetype"));
			agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			agr_schemeSno=Helper.getfacilitySno(schemetype);
			strtotal=Helper.correctNull((String)hshValues.get("txt_totamount"));
			int k=0;
			if(hshValues.get("hidAction").toString().equals("insert"))
			{		
				k++;
				hshQuery.put("strQueryId","agr_ins_sericulture_projectdetails");	
				arrValues.add(appno);
			    arrValues.add(strMulberry);
			    arrValues.add(strCocoon);
			    arrValues.add(agr_schemeSno);
			    arrValues.add(agr_schemeType);
			    arrValues.add(strtotal);
			    hshQuery.put("arrValues",arrValues);
			    hshQueryValues.put(String.valueOf(k),hshQuery);			    
			
				
				  hshQueryValues.put("size",String.valueOf(k));
				  EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			else if(hshValues.get("hidAction").toString().equals("delete"))
			{
				   
				    hshQuery = new HashMap();
				    arrValues = new ArrayList();
				    hshQuery.put("strQueryId","agr_del_seri_projectdetails");			
				    arrValues.add(appno);
				    arrValues.add(agr_schemeSno);
				    arrValues.add(agr_schemeType);
				    hshQuery.put("arrValues",arrValues);
				    hshQueryValues.put("1",hshQuery);
				    hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}	
			else if(hshValues.get("hidAction").toString().equals("update"))
			{
				  
				    
				    k++;
				    hshQuery = new HashMap();
				    arrValues = new ArrayList();
				    hshQuery.put("strQueryId","agr_del_seri_projectdetails");			
				    arrValues.add(appno);
				    arrValues.add(agr_schemeSno);
				    arrValues.add(agr_schemeType);
				    hshQuery.put("arrValues",arrValues);
				    hshQueryValues.put(String.valueOf(k),hshQuery);
				    
				    k++;
				    hshQuery = new HashMap();
				    arrValues = new ArrayList();
					hshQuery.put("strQueryId","agr_ins_sericulture_projectdetails");	
					arrValues.add(appno);
				    arrValues.add(strMulberry);
				    arrValues.add(strCocoon);
				    arrValues.add(agr_schemeSno);
				    arrValues.add(agr_schemeType);
				    arrValues.add(strtotal);
				    hshQuery.put("arrValues",arrValues);
				    hshQueryValues.put(String.valueOf(k),hshQuery);			  
					
				
					 hshQueryValues.put("size",String.valueOf(k));
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}	
		}
		catch(Exception e)
		{	log.error(e);
			throw new EJBException("Error in updateSericultreProjectDetails - AgriEconamicBean "+e.toString());
		}		
	}

	public HashMap getSericultureIncomeStatement(HashMap hshValues)  
	{
		//Added for sericulture income statement by rajesh on 06/03/2014
		String strQuery="";
		ResultSet rs = null; 
		HashMap hshRecord = new HashMap();
		String strappno="";
		String strType="",agr_schemeType="",agr_schemeSno="";
		
		try 
		{
			String schemetype=correctNull((String)hshValues.get("schemetype"));
			agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			agr_schemeSno=Helper.getfacilitySno(schemetype);
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("agr_serincomeselect^"+strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord = new HashMap();
				hshRecord.put("SERI_TOTACRE",Helper.correctNull((String)rs.getString("seri_totacre"))); //0
				hshRecord.put("SERI_NOREARING",Helper.correctNull((String)rs.getString("seri_norearing")));//1
				hshRecord.put("SERI_SALECOCOON",Helper.correctNull((String)rs.getString("seri_salecocoon")));//2
				hshRecord.put("SERI_DISFREELAYING",Helper.correctNull((String)rs.getString("seri_disfreelaying"))); //3
				hshRecord.put("SERI_YIELDREARING",Helper.correctNull((String)rs.getString("seri_yieldrearing")));//4
				hshRecord.put("SERI_YIELDACRE",Helper.correctNull((String)rs.getString("seri_yieldacre")));//5
				hshRecord.put("SERI_CROSSINC",Helper.correctNull((String)rs.getString("seri_crossinc")));//6
				hshRecord.put("SERI_MULBERYEXP",Helper.correctNull((String)rs.getString("seri_mulberyexp")));//7
				hshRecord.put("SERI_SILKWORM",Helper.correctNull((String)rs.getString("seri_silkworm")));//8
				hshRecord.put("SERI_AMOUNT",Helper.correctNull((String)rs.getString("seri_amount")));//9
				hshRecord.put("SERI_YIELDDLF",Helper.correctNull((String)rs.getString("seri_yielddlf")));//10
				hshRecord.put("SERI_INCCARRY",Helper.correctNull((String)rs.getString("SERI_INCCARRY")));//11
				hshRecord.put("SERI_EXPCARRY",Helper.correctNull((String)rs.getString("SERI_EXPCARRY")));//12
				hshRecord.put("SERI_NETINC",Helper.correctNull((String)rs.getString("SERI_NETINC")));//13
			}
			    
			if(rs!=null){
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("agr_sericulture_projectdetails_select^"+strappno+"^"+agr_schemeSno+"^"+agr_schemeType);	
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("agr_total",rs.getString("agr_total"));
			}
		} 
		catch (Exception e) 
		{	log.error(e);	
		throw new EJBException("Error in getSericultureIncomeStatement"+e.toString());
			
		}
		finally
		{
			try 
			{	
				if(rs!=null){
					rs.close();
				}
			}
			catch (SQLException e) 
			{	log.error(e);	
				throw new EJBException("Error in getSericultureIncomeStatement "+e.toString());
			}
		}
		return hshRecord;
	}
	
	public void updateSericultureIncomeStatement(HashMap hshValues) 
	{
		//Added for sericulture income statement by rajesh on 06/03/2014
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strappno="",schemetype="",agr_schemeType="",agr_schemeSno="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		strappno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{		
			
			String strtotacres =Helper.correctNull((String)hshValues.get("txt_totacres"));//1
			String stryieldfl =Helper.correctNull((String)hshValues.get("txt_yieldfl"));//2
			String strnorear = Helper.correctNull((String)hshValues.get("txt_norear"));//3
			String strpricecocoon =Helper.correctNull((String)hshValues.get("txt_pricecocoon"));//4
			String strdisfree =Helper.correctNull((String)hshValues.get("txt_disfree"));//5
			String stryieldrear=Helper.correctNull((String)hshValues.get("txt_yieldrear"));//6
			String stryieldacre =Helper.correctNull((String)hshValues.get("txt_yieldacre"));//7
			String strgrossinc= Helper.correctNull((String)hshValues.get("txt_grossinc"));//8
			String strmulcultivatexp=Helper.correctNull((String)hshValues.get("txt_mulcultivatexp"));//9
			String strsilkworm =Helper.correctNull((String)hshValues.get("txt_silkworm"));//10
			String stramount= Helper.correctNull((String)hshValues.get("txt_amount"));//11
			String strinccarry= Helper.correctNull((String)hshValues.get("txt_inccarry"));//12
			String strexpensecarry= Helper.correctNull((String)hshValues.get("txt_expensecarry"));//13
			String strnetinc= Helper.correctNull((String)hshValues.get("txt_netinc"));//14
		
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_serincomedelete");
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_serincomeinsert");
				arrValues.add(strappno);//1
				arrValues.add(strtotacres);//2
				arrValues.add(strnorear);//3
				arrValues.add(strpricecocoon);//4
				arrValues.add(strdisfree);//5
				arrValues.add(stryieldrear);//6
				arrValues.add(stryieldacre);//7
				arrValues.add(strgrossinc);//8
				arrValues.add(strmulcultivatexp);//9
				arrValues.add(strsilkworm);//10
				arrValues.add(stramount);//11
				arrValues.add(stryieldfl);//12
				arrValues.add(strinccarry);//13
				arrValues.add(strexpensecarry);//14
				arrValues.add(strnetinc);//15
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_serincomedelete");
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{	log.error(e);
			throw new EJBException("Error in updateSericultreIncomeStatement - AgriEconamicBean "+e.toString());
		}	
	    
	}
	
	  public HashMap getTobaccoDetails(HashMap hshValues) 
	  {
		HashMap hshRecord=new HashMap();
		HashMap hshTobaccoDetails	=	null;
		String strAppNo=null;
		try {
			
			 strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				String schemetype=correctNull((String)hshValues.get("schemetype"));
				String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
				String agr_schemeSno=Helper.getfacilitySno(schemetype);
				hshValues.put("strAppNo",strAppNo);
				hshValues.put("agr_schemeSno",agr_schemeSno);
				hshValues.put("agr_schemeType",agr_schemeType);
				agrEconomicBean agreconomicbean=new agrEconomicBean();
				hshTobaccoDetails=(HashMap) agreconomicbean.getTobaccoDetailsByAppno(hshValues);
				hshRecord.put("hshTobaccoDet",hshTobaccoDetails);
				hshRecord.put("schemetype",agr_schemeType);
				
			
		} catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getTobaccoDetails === AgrEconomicBean"+e.toString());
		}
		return hshRecord;
	  }
	  
	  public HashMap getTobaccoDetailsByAppno(HashMap hshValues) throws Exception
		{
			HashMap hshAgency=new HashMap();
			ResultSet rs=null;
			try 
			{
				String strAppNo=correctNull((String)hshValues.get("appno"));
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				String agr_schemeType=correctNull((String)hshValues.get("agr_schemeType"));
				String agr_schemeSno=correctNull((String)hshValues.get("agr_schemeSno"));
				rs=DBUtils.executeLAPSQuery("agr_tobacco_select^"+strAppNo+"^"+agr_schemeSno+"^"+agr_schemeType);
				while(rs.next())
				{
					
					hshAgency.put("appno", Helper.correctNull(rs.getString("agr_appno")));
					//hshAgency.put("permitobtained", Helper.correctNull(rs.getString("agr_permitobtained")));
					hshAgency.put("istieup", Helper.correctNull(rs.getString("agr_istieup")));
					hshAgency.put("regnumber", Helper.correctNull(rs.getString("agr_regnumber")));
					hshAgency.put("noofbarrens", Helper.correctNull(rs.getString("agr_noofbarrens")));
					hshAgency.put("barrennum", Helper.correctNull(rs.getString("agr_barrennum")));
					hshAgency.put("barrenshare", Helper.correctNull(rs.getString("agr_barrenshare")));
					hshAgency.put("quantity", Helper.correctNull(rs.getString("agr_quantity")));
					hshAgency.put("txt_licensedate", Helper.correctNull(rs.getString("agr_licensedate")));
					hshAgency.put("txt_validupto", Helper.correctNull(rs.getString("agr_validupto")));
					
				}
				if(rs!=null){rs.close();}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getTobaccoDetailsByAppnoof AgrEconomicBean::" +e.getMessage());
				throw new EJBException("Error in getTobaccoDetailsByAppno === AgrEconomicBean"+e.toString());
				
			}
			
			
			return hshAgency;
		}
	
	//Method to update Tobacco Details added on 07-12-2013 by Venkata Prasad Chowdary
	  
	  public void updateTobaccoDetails(HashMap hshValues) 
	  {
		  HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;		
			ArrayList arrValues=new ArrayList();
			
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strAppno= correctNull((String)hshValues.get("strappno"));
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			String schemetype=correctNull((String)hshValues.get("schemetype"));
			String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			String agr_schemeSno=Helper.getfacilitySno(schemetype);
			ResultSet rs = null;
			ResultSet rs2 = null;
			try
			{			
				if(strAction.equals("delete"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_tobacco_delete");
					arrValues.add(strAppno);
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_tobacco_delete");
					arrValues.add(strAppno);
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_tobacco_insert");
					arrValues.add(strAppno);
					//arrValues.add(correctNull((String)hshValues.get("sel_tobaccopermit")));
					arrValues.add(correctNull((String)hshValues.get("sel_tieup"))); //6
					arrValues.add(correctNull((String)hshValues.get("txt_tobaccoregnumber"))); //1
					arrValues.add(correctNull((String)hshValues.get("txt_noofbarrens"))); //2
					arrValues.add(correctNull((String)hshValues.get("txt_tobaccobarrenno"))); //3
					arrValues.add(correctNull((String)hshValues.get("sel_barrenshare"))); //4
					arrValues.add(correctNull((String)hshValues.get("txt_quantity"))); //5
					arrValues.add(correctNull((String)hshValues.get("txt_licensedate"))); //7
					arrValues.add(correctNull((String)hshValues.get("txt_validupto"))); //8
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
//				---------------------------------------Audittrial------------------------
				StringBuilder sbAuditTrial=new StringBuilder();
				
						
				sbAuditTrial.append(
				"~Permit from the tobacco board obtained = ").append(correctNull((String)hshValues.get("sel_tobaccopermit"))).append(
				"~If there is any tieup = ").append(correctNull((String )hshValues.get("sel_tieup"))).append(
				"~tobacco board registration number = ").append(correctNull((String )hshValues.get("txt_tobaccoregnumber"))).append(
				"~No of barrens = ").append(correctNull((String )hshValues.get("txt_noofbarrens"))).append(
				"~Tobacco Barren no= ").append(correctNull((String )hshValues.get("txt_tobaccobarrenno"))).append(
				"~Barren Share = ").append(correctNull((String )hshValues.get("sel_barrenshare"))).append(
				"~Quantity authorised in kgs= ").append(correctNull((String )hshValues.get("txt_quantity")));
				
				AuditTrial.auditLog(hshValues,"222",strAppno,sbAuditTrial.toString());	
				//-------------------------------------------End---------------------------
			}
			catch(Exception ce)
			{	log.error(ce);
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
				{	log.error(cf);
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}
			}
	  }
	  
	//GOBAR GAS DETAILS ADDED ON 09-12-2013 BY VENKATA PRASAD CHOWDARY

		public HashMap getgobartechdata(HashMap hshValues)  
		{
			String strQuery = "";
			ResultSet rs = null;
			ResultSet rs1 = null;
			HashMap hshRecord = new HashMap();
			ArrayList arryRow = new ArrayList();
			ArrayList arryCol = null;
			ArrayList arryIncomeDescription = new ArrayList();
			ArrayList arryIncomeAmount = new ArrayList();
		  	String appno= Helper.correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("appno"));
			}
		    String PageType=Helper.correctNull((String)hshValues.get("hidpagetype1"));
	        if(PageType.equalsIgnoreCase(""))
	        {
	        	 PageType=Helper.correctNull((String)hshValues.get("hidpagetype"));
	        }
	        String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
			if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
			{
				prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
			}
			String schemetype=correctNull((String)hshValues.get("schemetype"));
			String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			String agr_schemeSno=Helper.getfacilitySno(schemetype);
			
			try 
			{
//				strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno+"^"+agr_schemeSno+"^"+agr_schemeType);
//				rs = DBUtils.executeQuery(strQuery);
//				if (rs.next()) 
//				{
//					hshRecord.put("app_name", Helper.correctDoubleQuote(Helper.correctNull(rs.getString("app_name"))));
//					hshRecord.put("app_status", Helper.correctDoubleQuote(Helper.correctNull(rs.getString("app_status"))));
//					hshRecord.put("applicantid", rs.getString("pa_appid"));
//				}
				if(rs!=null){
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("agr_get_gobartechdata1^"+appno+"^"+agr_schemeSno+"^"+agr_schemeType);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					hshRecord.put("txt_distancefrom_kitchen", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_distancefrom_kitchen"))));
					hshRecord.put("txt_syno", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_syno"))));
					hshRecord.put("txt_acreage", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_acreage"))));
					hshRecord.put("txt_village", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_village"))));
					hshRecord.put("txt_taluk", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_taluk"))));
					hshRecord.put("txt_ownership", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_ownership"))));
					hshRecord.put("txt_distance", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_distance"))));
					hshRecord.put("txt_sizeplant", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_sizeplant"))));
					hshRecord.put("sel_design", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_design"))));
					hshRecord.put("txt_investment", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_investment"))));
					hshRecord.put("txt_animalsnorms", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_animalsnorms"))));
					hshRecord.put("txt_persons", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_persons"))));
					hshRecord.put("txt_purpose1", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_purpose1"))));
					hshRecord.put("txt_hrs1", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_hrs1"))));
					hshRecord.put("txt_purpose2", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_purpose2"))));
					hshRecord.put("txt_hrs2", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_hrs2"))));
					hshRecord.put("txt_purpose3", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_purpose3"))));
					hshRecord.put("txt_hrs3", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_hrs3"))));
					hshRecord.put("txt_savings", Helper.correctDoubleQuote(Helper.correctNull(rs1.getString("gg_savings"))));
					hshRecord.put("txt_netannualincome", Helper.correctNull(rs1.getString("gg_netannualincome")));
					hshRecord.put("txt_membersinvolved", Helper.correctNull(rs1.getString("gg_membersinvolved")));
					hshRecord.put("txt_buffalo_adult", Helper.correctNull(rs1.getString("gg_buffalo_adult")));
					hshRecord.put("txt_buffalo_calf", Helper.correctNull(rs1.getString("gg_buffalo_calf")));
					hshRecord.put("txt_cows_adult", Helper.correctNull(rs1.getString("gg_cows_adult")));
					hshRecord.put("txt_cows_calf", Helper.correctNull(rs1.getString("gg_cows_calf")));
					hshRecord.put("txt_draught_adult", Helper.correctNull(rs1.getString("gg_draught_adult")));
					hshRecord.put("txt_draught_calf", Helper.correctNull(rs1.getString("gg_draught_calf")));
				}
				if(rs1!=null){
					rs1.close();
				}
				String txt_date="";
				strQuery = SQLParser.getSqlQuery("agr_sel_cklslimit^" + appno+"^"+agr_schemeSno+"^"+agr_schemeType);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("seqno"));
					arryCol.add(appno);
					arryCol.add(rs.getString("sno"));
					arryCol.add(rs.getString("ckls_limit"));
					arryCol.add(rs.getString("ckls_amount"));
					txt_date= Helper.correctNull((String)rs.getString("ckls_date"));
					if(txt_date.equalsIgnoreCase("01/01/1900"))
					{
						arryCol.add("");
					}
					else
					{
						arryCol.add(txt_date);
					}
					arryCol.add(rs.getString("ckls_balance"));
					arryCol.add(rs.getString("ckls_comments"));
					arryRow.add(arryCol);
				}
				if(rs!=null){
					rs.close();
				}
				
//				strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
//				rs1 = DBUtils.executeQuery(strQuery);
//				if(rs1.next())
//				{
//					hshRecord.put("land_measurement",Helper.correctNull(rs1.getString("pa_measurementtype")));
//				}
				if(rs1!=null){
					rs1.close();
				}
				hshRecord.put("appno", appno);
				hshRecord.put("PageType", PageType);
				hshRecord.put("arryRow", arryRow);
				
				strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+"^"+agr_schemeSno+"^"+agr_schemeType);			
				rs1 =DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					hshRecord.put("txt_roi", Helper.correctNull(rs1.getString("bullock_roi")));
					hshRecord.put("txt_holiday", Helper.correctNull(rs1.getString("bullock_holiday")));
					hshRecord.put("sel_payment", Helper.correctNull(rs1.getString("bullock_payment")));
					hshRecord.put("txt_installment", Helper.correctNull(rs1.getString("bullock_installment")));
					hshRecord.put("txt_date", Helper.correctNull(rs1.getString("bullock_date")));
					hshRecord.put("txt_lastinstallment", Helper.correctNull(rs1.getString("bullock_lastinstallment")));
					hshRecord.put("txt_loanamount", Helper.correctNull(rs1.getString("loanamount")));
				}
				if(rs1!=null){
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("agr_gobar_income_select^"+appno+"^"+agr_schemeSno+"^"+agr_schemeType);			
				rs1 =DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					
					arryIncomeDescription.add(Helper.correctNull(rs1.getString("agi_gg_incomedescription")));
					arryIncomeAmount.add(Helper.correctNull(rs1.getString("agi_gg_incomeamount")));
					
				}
				hshRecord.put("arryIncomeDescription", arryIncomeDescription);
				hshRecord.put("arryIncomeAmount", arryIncomeAmount);
				if(rs1!=null){
					rs1.close();
				}
				
			} 
			catch (Exception ce)
			{	log.error(ce);
				throw new EJBException("Error in closing getData" + ce.getMessage());
			}
			finally 
			{
				try
				{
					if (rs != null) 
					{
						rs.close();
						rs = null;
					}
					 if (rs1 != null)
					    {
						rs1.close();
					    }
				}
				catch (Exception e)
				{	log.error(e);
					throw new EJBException("Error in closing Connection "+ e.getMessage());
				}
			}
			return hshRecord;
		}
		
		
		public HashMap updategobartechdata(HashMap hshValues)  
		{
			String strQuery = "";
			String [] strIncomeDescription;
			String [] strIncomeAmount;
			String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
			if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
			{
				prd_type = Helper.correctNull((String)hshValues.get("prd_type"));
			}
			HashMap hshQueryValues = new HashMap();		
			HashMap hshpasValues = new HashMap();
			HashMap hshQuery = new HashMap();	
			ArrayList arrValues = new ArrayList();
			ResultSet rs = null;
			String strAction = null;		
				
			HashMap hshResult = new HashMap();
			HashMap hshQuery4 = new HashMap();		
			String appno= Helper.correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
		   strAction = Helper.correctNull((String) hshValues.get("hidAction"));
		   		    
		   String txt_syno= Helper.correctNull((String) hshValues.get("txt_syno"));
		   String  txt_acreage = Helper.correctNull((String) hshValues.get("txt_acreage"));
		   String  txt_village= Helper.correctNull((String) hshValues.get("txt_village"));
		   String  txt_taluk= Helper.correctNull((String) hshValues.get("txt_taluk"));
		   String txt_ownership= Helper.correctNull((String) hshValues.get("txt_ownership"));
		   String txt_distance= Helper.correctNull((String) hshValues.get("txt_distance"));
			String txt_sizeplant= Helper.correctNull((String) hshValues.get("txt_sizeplant"));
			String sel_design = Helper.correctNull((String) hshValues.get("sel_design"));
			if(sel_design.equalsIgnoreCase(""))
			{
				sel_design="0";	
			}
			else
			{
				sel_design= Helper.correctNull((String) hshValues.get("sel_design"));
			}
			String  txt_investment = Helper.correctNull((String) hshValues.get("txt_investment"));
			String  txt_animalsnorms= Helper.correctNull((String) hshValues.get("txt_animalsnorms"));
			String txt_persons= Helper.correctNull((String) hshValues.get("txt_persons"));
			String  txt_purpose1= Helper.correctNull((String) hshValues.get("txt_purpose1"));
			String txt_hrs1= Helper.correctNull((String) hshValues.get("txt_hrs1"));
			String  txt_purpose2= Helper.correctNull((String) hshValues.get("txt_purpose2"));
			String txt_hrs2= Helper.correctNull((String) hshValues.get("txt_hrs2"));
			String  txt_purpose3= Helper.correctNull((String) hshValues.get("txt_purpose3"));
			String txt_hrs3= Helper.correctNull((String) hshValues.get("txt_hrs3"));
			String txt_savings= Helper.correctNull((String) hshValues.get("txt_savings"));
			String  txt_netannualincome= Helper.correctNull((String) hshValues.get("txt_netannualincome"));
			int txt_membersinvolved = Helper.parseInt((String) hshValues.get("txt_membersinvolved"));
			int txt_buffalo_adult = Helper.parseInt((String) hshValues.get("txt_buffalo_adult"));
			int txt_buffalo_calf = Helper.parseInt((String) hshValues.get("txt_buffalo_calf"));
			int txt_cows_adult = Helper.parseInt((String) hshValues.get("txt_cows_adult"));
			int txt_cows_calf = Helper.parseInt((String) hshValues.get("txt_cows_calf"));
			int txt_draught_adult = Helper.parseInt((String) hshValues.get("txt_draught_adult"));
			int txt_draught_calf = Helper.parseInt((String) hshValues.get("txt_draught_calf"));
			int txt_distancefrom_kitchen = Helper.parseInt((String) hshValues.get("txt_distancefrom_kitchen"));
			
			String schemetype=correctNull((String)hshValues.get("schemetype"));
			String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
			String agr_schemeSno=Helper.getfacilitySno(schemetype);
			try 
			{
				strIncomeDescription				= 	(String [])hshValues.get("txt_incomedescription");
				strIncomeAmount			=   (String [])hshValues.get("txt_incomeamount");
//				strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//				rs = DBUtils.executeQuery(strQuery);
//				if (rs.next()) 
//				{
//					hshResult.put("app_name", Helper.correctDoubleQuote(Helper.correctNull(rs.getString("app_name"))));
//					hshResult.put("app_status", Helper.correctDoubleQuote(Helper.correctNull(rs.getString("app_status"))));
//					hshResult.put("applicantid", rs.getString("pa_appid"));
//				}
				if(rs!=null){
					rs.close();
				}
				if (strAction.equals("delete"))
				{
					hshQuery4 = new HashMap();
					HashMap hshQueryValues4 = new HashMap();
					ArrayList arrValues4 = new ArrayList();
					hshQueryValues4.put("size", "1");
					hshQuery4.put("strQueryId", "agr_del_gobartechdata");
					arrValues4.add(appno);
					arrValues4.add(agr_schemeSno);
					arrValues4.add(agr_schemeType);
					hshQuery4.put("arrValues", arrValues4);
					hshQueryValues4.put("1", hshQuery4);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
					

					hshQuery4 = new HashMap();
					hshQueryValues4 = new HashMap();
					arrValues4 = new ArrayList();
					hshQueryValues4.put("size", "1");
					hshQuery4.put("strQueryId", "agr_gobar_income_delete");
					arrValues4.add(appno);
					arrValues4.add(agr_schemeSno);
					arrValues4.add(agr_schemeType);
					hshQuery4.put("arrValues", arrValues4);
					hshQueryValues4.put("1", hshQuery4);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
				
				}
				
				
				if(strAction.equalsIgnoreCase("insert"))
				{
					int k=1;
					hshQuery= new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_del_gobartechdata");
					arrValues.add(appno);
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues",arrValues);	
					hshQueryValues.put(String.valueOf(k),hshQuery);
					k++;
					hshQuery= new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(txt_syno);
					arrValues.add(txt_acreage);
					arrValues.add(txt_village);
					arrValues.add(txt_taluk);
					arrValues.add(txt_ownership);
					arrValues.add(txt_distance);
					arrValues.add(txt_sizeplant);
					arrValues.add(sel_design);				
					arrValues.add(txt_investment);			
					arrValues.add(txt_animalsnorms);
					arrValues.add(txt_persons);
					arrValues.add(txt_purpose1);
					arrValues.add(txt_hrs1);
					arrValues.add(txt_purpose2);
					arrValues.add(txt_hrs2);
					arrValues.add(txt_purpose3);
					arrValues.add(txt_hrs3);
					arrValues.add(txt_savings);
					arrValues.add(txt_netannualincome);	
					arrValues.add(String.valueOf(txt_membersinvolved));	
					arrValues.add(String.valueOf(txt_buffalo_adult));	
					arrValues.add(String.valueOf(txt_buffalo_calf));	
					arrValues.add(String.valueOf(txt_cows_adult));	
					arrValues.add(String.valueOf(txt_cows_calf));	
					arrValues.add(String.valueOf(txt_draught_adult));	
					arrValues.add(String.valueOf(txt_draught_calf));	
					arrValues.add(String.valueOf(txt_distancefrom_kitchen));
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "agr_ins_gobartechdata");
					hshQueryValues.put(String.valueOf(k), hshQuery);
					k++;
					hshQuery= new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_gobar_income_delete");
					arrValues.add(appno);
					arrValues.add(agr_schemeSno);
					arrValues.add(agr_schemeType);
					hshQuery.put("arrValues",arrValues);	
					hshQueryValues.put(String.valueOf(k), hshQuery);
					
					for(int i=0;i<strIncomeDescription.length;i++)
					{
						k++;
						hshQuery= new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "agr_gobar_income_insert");
						arrValues.add(appno);
						
						strIncomeDescription[i] = Helper.correctNull(strIncomeDescription[i]);
						if(strIncomeAmount[i].equals(""))
						{
							strIncomeAmount[i] = "0.00";
						}
						
						arrValues.add(strIncomeDescription[i]);
						arrValues.add(strIncomeAmount[i]);
						arrValues.add(agr_schemeSno);
						arrValues.add(agr_schemeType);
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put(String.valueOf(k), hshQuery);
					}
					hshQueryValues.put("size",String.valueOf(k));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				
				/*StringBuilder sbAuditTrial=new StringBuilder();
				
					sbAuditTrial
					.append("Location of Gobar Gas Plant ^")
					.append("~Survey No= ")
					.append(txt_syno)
					.append("~Extend Land = ")
					.append(txt_acreage)
					.append("~Village = ")
					.append(txt_village)
					.append("~Taluk = ")
					.append(txt_taluk)
					.append("~Ownership = ")
					.append(txt_ownership)
					.append("~Distance from the Branch to Plant = ")
					.append(txt_distance)
					.append("~Size of the Plant = ")
					.append(txt_sizeplant)
					.append("~Design of the Plant = ")
					.append(Helper.correctNull((String)hshValues.get("sel_designtext")));
				if(Helper.correctNull((String)hshValues.get("sel_designtext")).equalsIgnoreCase("Others"))
				{
					sbAuditTrial
					.append("~Specify = ")
					.append(txt_specify);
				}
				sbAuditTrial
					.append("~Cost of Investment "+ApplicationParams.getCurrency()+" = ")
					.append(txt_investment)
					.append("~Margin Money = ")
					.append(txt_margin)
					.append(" ")
					.append("&")
					.append(" ")
					.append(txt_marginper)
					.append(" ")
					.append("%")
					.append(" ")
					.append("~No. of Animals Owned (cows/buffaloes/bullocks) = ")
					.append(txt_animalsowned)
					.append("~of which stallfed= ")
					.append(txt_animalsstallfed)
					.append("~of which allowed for grazing = ")
					.append(txt_animalsgrazing)
					.append("~No. of Animals as per Norms = ")
					.append(txt_animalsnorms)
					.append("~How the shortfall has occured  = ")
					.append(txt_shortfall)
					.append("~Name of agency  = ")
					.append(txt_agency)
					.append("~Name of agency Supply gas holder,pipelines = ")
					.append(txt_agencygas)
					.append("~Agency Supplying Equipment is approved by = ")
					.append(txt_agencyapproved)
					.append("~No. of persons benefited by the construction of proposed plant = ")
					.append(txt_persons)
					.append("~Purpose gas is used for = ")
					.append(txt_purpose1)
					.append("~No. of Hrs. gas is used for = ")
					.append(txt_hrs1)
					.append("~Purpose gas is used for = ")
					.append(txt_purpose2)
					.append("~No. of Hrs. gas is used for = ")
					.append(txt_hrs2)
					.append("~Purpose gas is used for = ")
					.append(txt_purpose3)
					.append("~No. of Hrs. gas is used for = ")
					.append(txt_hrs3)
					.append("~Savings on fuel due to implementation of G.G Plant = ")
					.append(txt_savings)
					.append("~Net Annual Income = ")
					.append(txt_netannualincome);
					
					
					//AuditTrial.auditLog(hshValues,"275",appno,sbAuditTrial.toString());*/
				
				hshpasValues.put("appno", appno);
				hshpasValues.put("prd_type", prd_type);
			//	hshResult = getgobartechdata(hshpasValues);
			}
			catch (Exception e)
			{	log.error(e);
				throw new EJBException("Error in Insert Data " + e.getMessage());
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
				catch (Exception e1) 
				{	log.error(e1);
					throw new EJBException("Error in closing Connection "+ e1.getMessage());
				}
			}
			return hshResult;
		}
		//Plantation & Horticulture--> Income & Expenditure DETAILS BY VENKATA PRASAD CHOWDARY
		 public HashMap getHorticultureIncomeExp(HashMap hshValues) 
		  {
			HashMap hshRecord=new HashMap();
			ResultSet rs = null;
			ResultSet rs12 = null;
			String strAppNo=null;
			double expendi=0.00,totalacr=0.00;
			try {
				String schemetype=correctNull((String)hshValues.get("schemetype"));
				String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
				String agr_schemeSno=Helper.getfacilitySno(schemetype);
				 strAppNo=correctNull((String)hshValues.get("appno"));
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strappno"));
					}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strAppno"));
					}
					//hshRecord=getTotIncomeExpByAppno(strAppNo,schemetype);
					ArrayList arrPHRow = new ArrayList();
					ArrayList arrPHCol = new ArrayList();
					ArrayList arrECRow = new ArrayList();
					ArrayList arrECCol = new ArrayList();
					arrPHCol = new ArrayList();
					arrECCol = new ArrayList();
					String strfacname="";
					if(rs!=null)rs.close();
					String strQuery11 = SQLParser.getSqlQuery("sel_maxcountplants^"+strAppNo);
					rs = DBUtils.executeQuery(strQuery11);
					while(rs.next())
					{
						String strSno = Helper.correctNull((String)rs.getString("sno"));
						String strQuery12 = SQLParser.getSqlQuery("sel_plantnamebyscheme^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno+"^"+strSno);
						rs12 = DBUtils.executeQuery(strQuery12);
						if(rs12.next())
						{
							strfacname = Helper.correctNull((String)rs12.getString("ACT_DESC"));
						}
						
						//For Net Income
						if(rs12!=null)rs12.close();
						strQuery12 = SQLParser.getSqlQuery("sel_netincforfarmbudget^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno+"^"+strSno);
						rs12 = DBUtils.executeQuery(strQuery12);
						arrPHCol = new ArrayList();
						if(rs12.next())
						{
							rs12.previous();
							arrPHCol.add(strfacname);
							while(rs12.next())
							{
								arrPHCol.add(Helper.correctNull((String)rs12.getString("AGR_NETINC")));
							}
							arrPHRow.add(arrPHCol);
						}
						
						if(rs12!=null)rs12.close();
						strQuery12 = SQLParser.getSqlQuery("sel_estimatecostvalue^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno+"^"+strSno);
						rs12 = DBUtils.executeQuery(strQuery12);
						if(rs12.next())
							{
							totalacr=Double.parseDouble(Helper.correctDouble((String) rs12.getString("AGR_HORTI_TOTALACRE")));
							}
						
						
						//For Expenditure  
						if(rs12!=null)rs12.close();
						strQuery12 = SQLParser.getSqlQuery("agr_horticostofdevelopment_select^"+strAppNo+"^"+strSno+"^"+agr_schemeType+"^"+agr_schemeSno);
						rs12 = DBUtils.executeQuery(strQuery12);
						arrECCol = new ArrayList();
						if(rs12.next())
						{
							rs12.previous();
							while(rs12.next())
							{
								arrECCol.add(strfacname);
								for(int i=1;i<=15;i++)
								{
									expendi=Double.parseDouble(Helper.correctDouble((String) rs12.getString("agr_year"+i)));
									arrECCol.add(String.valueOf(expendi*totalacr));
								}
							}
							arrECRow.add(arrECCol);
						}
					}
					hshRecord.put("arrNetInc", arrPHRow);
					hshRecord.put("arrExpense", arrECRow);
					//hshRecord = new AgrLandHoldingsBO().getHortiCostOfDevelopmentByAppno(strAppNo,strPlantSno,agr_schemeType,agr_schemeSno);
					hshRecord.put("agr_schemeType", agr_schemeType);
					hshRecord.put("agr_schemeSno", agr_schemeSno);
				
			} catch (Exception e) {
				log.error(e.toString());
				throw new EJBException("Error in getHorticultureIncomeExp === "+e.toString());
			}
			return hshRecord;
		  }
		
		 public HashMap getTotIncomeExpByAppno(String strAppNo,String schemetype)throws Exception
		 {				
				HashMap hshRecord=new HashMap();
				HashMap hshMain=new HashMap();
				HashMap hshMaint=new HashMap();
				HashMap hshAcre=new HashMap();
				ArrayList arrPlantName=new ArrayList();
				ArrayList arrCostOfCult=null;
				ArrayList arrMaintenanceRow=new ArrayList();
	
				ArrayList arrIncome=new ArrayList();
				ArrayList arrIncomeRow=new ArrayList();
			
				ArrayList arrRow=new ArrayList();
				ArrayList arrHortiplant=null;
				ResultSet rs=null;
				double dblAcre=0.00;
				String strPlantId="";
				
				Iterator itr=null;
				try 
				{
					String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
					String agr_schemeSno=Helper.getfacilitySno(schemetype);
					if(rs!=null){rs.close();}
					rs=DBUtils.executeLAPSQuery("agr_horticostofcultivation_select^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno);
					while(rs.next()) 
			  		{
						arrCostOfCult=new ArrayList();
						arrCostOfCult.add(Helper.correctNull(rs.getString("AGR_SNO"))); 
						arrCostOfCult.add(Helper.correctNull(rs.getString("AGR_UNIT"))); 
						hshAcre.put(Helper.correctNull(rs.getString("AGR_SNO")), Helper.correctNull(rs.getString("AGR_UNIT")));
			  		}
					if(rs!=null){rs.close();}
					rs=DBUtils.executeLAPSQuery("agr_hortiyearcultivationcost_select^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno);
					arrCostOfCult=new ArrayList();
					while(rs.next()) 
			  		{
						arrCostOfCult.add(Helper.correctNull(rs.getString("AGR_HORTI_TOTALCOST")));		
			  		}
					arrCostOfCult=adjustArrayList(arrCostOfCult);						
							
					if(rs!=null){rs.close();}						
					arrHortiplant=getHortiDetailsByAppNo(strAppNo,schemetype);
					ArrayList arr=null;
					if(arrHortiplant!=null && arrHortiplant.size()>0)
					{
						for(int i=0;i<arrHortiplant.size();i++)
						{
							arr=(ArrayList)arrHortiplant.get(i);
							strPlantId=Helper.correctNull((String)arr.get(1));
							hshMain=getIndividualMaintenanceIncomeByAppno(strAppNo,strPlantId);
							arrPlantName.add(Helper.correctNull((String)arr.get(2)));
							arrMaintenanceRow=(ArrayList)hshMain.get("maint");
							if(hshAcre.size()>0)
							{
								dblAcre=Double.parseDouble(Helper.correctDouble((String)hshAcre.get(strPlantId)));
							}
							
							arrMaintenanceRow=rearrangeArrayList(arrMaintenanceRow,15,dblAcre);						
							hshMaint.put(strPlantId, arrMaintenanceRow);
							arrIncome=(ArrayList)hshMain.get("income");
							arrIncome=rearrangeArrayList(arrIncome,15,dblAcre);
							arrIncomeRow.add(arrIncome);
						}
					}
					arrIncome=calculateTotalIncome(arrIncomeRow);
					arrRow.add(arrIncome);
					
					ArrayList arrMain=new ArrayList();
					ArrayList arrCost=new ArrayList();
					if(hshMaint!=null && hshMaint.size()>0)
					{
						itr = (hshMaint.keySet()).iterator();
						
							while(itr.hasNext() )
							{
								arrMain.add(hshMaint.get(Helper.correctNull((String)itr.next())));
							}
							arrMain=calculateTotalIncome(arrMain); 
					}
					
					arrCost=addCapitalcostMaintenanceCost(arrMain,arrCostOfCult);
					arrRow.add(arrCost);
					arrRow.add(subNetIncomeCost(arrIncome, arrCost));
					hshRecord.put("arrIncome",arrIncome);
					hshRecord.put("arrCost",arrCost);
					hshRecord.put("arrNetBenefit",subNetIncomeCost(arrIncome, arrCost));
					hshRecord.put("arrIncomeRow",arrIncomeRow);
					hshRecord.put("arrRow",arrRow);
					hshRecord.put("arrPlantName",arrPlantName);
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					log.error("Error in getTotIncomeExpByAppno AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in getTotIncomeExpByAppno === AgrEconomicBean"+e.toString());
				}
				return hshRecord;
			
			}
		 
		 public ArrayList adjustArrayList(ArrayList arrDet) throws Exception
			{
				
				ResultSet rs=null;	
				int size=0;
				int remain=0;

				try {
					size=arrDet.size();
					remain=15-size;
					if(size!=0)
					{
						for(int i=0;i<remain;i++)
							{
							arrDet.add("0.00");
							}
					}else{
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
						arrDet.add("0.00");
					
					}
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in adjustArrayList of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in adjustArrayList === AgrEconomicBean"+e.toString());
					
				}
				
				
				return arrDet;
			}
		 
		 public ArrayList getHortiDetailsByAppNo(String strAppNo,String schemetype) throws Exception
			{
				String strQuery=null;
				ResultSet rs1=null;
				ArrayList arrRow = null;
				ArrayList arrCol= new ArrayList();
				String agr_schemeType=Helper.getfacilitySchemetype(schemetype);
				String agr_schemeSno=Helper.getfacilitySno(schemetype);
				strQuery = SQLParser.getSqlQuery("agr_horti_plantdetail_select^"+strAppNo+"^"+agr_schemeType+"^"+agr_schemeSno);
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
						arrCol.add(Helper.correctNull(rs1.getString("AGR_HORTI_INCPERACRE")));//11 Income per acre
						arrCol.add(Helper.correctNull(rs1.getString("AGR_HORTI_YIELDUNIT")));//12 yield unit
						arrCol.add(Helper.correctNull(rs1.getString("AGR_PLANT_ACTIVITYSNO")));//13 Scheme Sno

						arrRow.add(arrCol);
					}
					if(rs1!=null){rs1.close();}
				}catch(Exception e)
				{
					if(rs1!=null){rs1.close();}
					log.error("Error in getHortiDetailsByAppNo of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in getHortiDetailsByAppNo === AgrEconomicBean"+e.toString());
					
				
				}
				
				return arrRow;
			}
		 public HashMap getIndividualMaintenanceIncomeByAppno(String strAppNo,String strPlantId) throws Exception
			{
				ArrayList arrMain=new ArrayList();
				ArrayList arrInc= new ArrayList();
				ResultSet rs=null;	
				String strQuery = null;
				HashMap hshMain=new HashMap();
				try {
					strQuery=SQLParser.getSqlQuery("agr_hortiincomeindividual_select^"+strAppNo+"^"+strPlantId);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{			
						arrMain.add(Helper.correctNull(rs.getString("agr_maintenance")));
						arrInc.add(Helper.correctNull(rs.getString("agr_grossinc")));
					}
					hshMain.put("maint", arrMain);
					hshMain.put("income", arrInc);
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in agr_hortiincomeindividual_select of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in agr_hortiincomeindividual_select === AgrEconomicBean"+e.toString());
					
				}
				
				
				return hshMain;
			}
		 
		 public ArrayList rearrangeArrayList(ArrayList arrDet,int size,double dblAcre) throws Exception
			{
				
				ResultSet rs=null;	
				ArrayList arr=new ArrayList();
				try {
					if(arrDet==null)
					{
						arrDet=new ArrayList();
					}
					if(arrDet.size()==0)
					{
						for(int i=0;i<size;i++)
						{
							arr.add("0.00");
						}
						
					}else{
						for(int i=0;i<arrDet.size();i++)
						{
							arr.add(""+ (Double.parseDouble(Helper.correctDouble((String)arrDet.get(i))) * dblAcre));
						}
					}
				
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in rearrangeArrayList of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in rearrangeArrayList === AgrEconomicBean"+e.toString());
					
				}
				
				
				return arr;
			}
		 public ArrayList calculateTotalIncome(ArrayList arrRow) throws Exception
			{
				
				ResultSet rs=null;	
				ArrayList arrTotal=new ArrayList();
				ArrayList arrDet=new ArrayList();
				double dblTot1=0.00;
				double dblTot2=0.00;
				double dblTot3=0.00;
				
				double dblTot4=0.00;
				double dblTot5=0.00;
				double dblTot6=0.00;
				
				double dblTot7=0.00;
				double dblTot8=0.00;
				double dblTot9=0.00;
				
				double dblTot10=0.00;
				double dblTot11=0.00;
				double dblTot12=0.00;
				
				double dblTot13=0.00;
				double dblTot14=0.00;
				double dblTot15=0.00;
				try {
			
					
					if(arrRow!=null && arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
								arrDet=(ArrayList)arrRow.get(i);			
								dblTot1+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(0)));
								dblTot2+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(1)));
								dblTot3+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(2)));
								dblTot4+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(3)));
								dblTot5+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(4)));
								
								dblTot6+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(5)));
								dblTot7+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(6)));
								dblTot8+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(7)));
								dblTot9+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(8)));
								dblTot10+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(9)));
								
								dblTot11+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(10)));
								dblTot12+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(11)));
								dblTot13+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(12)));
								dblTot14+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(13)));
								dblTot15+=Double.parseDouble(Helper.correctDouble((String)arrDet.get(14)));
				
						}
						arrTotal.add(""+dblTot1);
						arrTotal.add(""+dblTot2);
						arrTotal.add(""+dblTot3);
						
						arrTotal.add(""+dblTot4);
						arrTotal.add(""+dblTot5);
						arrTotal.add(""+dblTot6);
						
						arrTotal.add(""+dblTot7);
						arrTotal.add(""+dblTot8);
						arrTotal.add(""+dblTot9);
						
						arrTotal.add(""+dblTot10);
						arrTotal.add(""+dblTot11);
						arrTotal.add(""+dblTot12);
						
						arrTotal.add(""+dblTot13);
						arrTotal.add(""+dblTot14);
						arrTotal.add(""+dblTot15);
						
					}
					
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in calculateTotalIncome of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in calculateTotalIncome === AgrEconomicBean"+e.toString());
					
				}
				
				
				return arrTotal;
			}
		 public ArrayList addCapitalcostMaintenanceCost(ArrayList arrCapital,ArrayList arrMaintenance) throws Exception
			{
				
				ResultSet rs=null;	
				ArrayList arrTotal=new ArrayList();
				
				try {
			
					
					if(arrCapital.size()==arrMaintenance.size())
					{
						for(int i=0;i<arrCapital.size();i++)
						{
							arrTotal.add(String.valueOf((Double.parseDouble(Helper.correctDouble((String)arrCapital.get(i)))+Double.parseDouble(Helper.correctDouble((String)arrMaintenance.get(i))))));
						}
					}
					
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in addCapitalcostMaintenanceCost of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in addCapitalcostMaintenanceCost === AgrEconomicBean"+e.toString());
					
				}
				
				
				return arrTotal;
			}
		 public ArrayList subNetIncomeCost(ArrayList arrIncome ,ArrayList arrTotCost) throws Exception
			{
				
				ResultSet rs=null;	
				ArrayList arrNetBenefit=new ArrayList();
				
				try {
			
					if(arrTotCost.size()==arrIncome.size())
					{
						for(int i=0;i<arrTotCost.size();i++)
						{
							arrNetBenefit.add(""+(FwHelper.parseDouble((String)arrIncome.get(i))-FwHelper.parseDouble((String)arrTotCost.get(i))));
						}
					}
					
					
				} catch (Exception e) {
					if(rs!=null){rs.close();}
					
					log.error("Error in subNetIncomeCost of AgrEconomicBean::" +e.getMessage());
					throw new EJBException("Error in subNetIncomeCost === AgrEconomicBean"+e.toString());
					
				}
				
				
				return arrNetBenefit;
			}
		 
		 public void updateSolarlightData(HashMap hshRequestValues) 
			{
		 		String appno= Helper.correctNull((String)hshRequestValues.get("appno"));
				String strappno= Helper.correctNull((String)hshRequestValues.get("strappno"));
				HashMap hshQueryValues = new HashMap();
				HashMap hshQueryValues1 = new HashMap();
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();		
				
				String[] particulars;
				String[] make;
				String[] hpower;
				String[] estimcost;
				String[] margin;
				String[] loanamt;
				String totestimcost;
				String totmargin;
				String totloanamt;
				String seltractor;
				String tractorreason;
				String selmachinery;
				String machineryreason;
				String strSaltoSB;
				String strAdeqIncome;
			
				String hidAction= Helper.correctNull((String)hshRequestValues.get("hidAction"));
				if(appno.equalsIgnoreCase(""))
				{
					appno=strappno;
				}		
				try
				{		
					particulars = (String[]) hshRequestValues.get("txt_particulars");
					make = (String[]) hshRequestValues.get("txt_make");
					hpower = (String[]) hshRequestValues.get("txt_hp");
					estimcost = (String[]) hshRequestValues.get("txt_estimcost");
					margin = (String[]) hshRequestValues.get("txt_margin");
					loanamt = (String[]) hshRequestValues.get("txt_loanamt");
					totestimcost = Helper.correctNull((String)hshRequestValues.get("txt_totestimcost"));
					totmargin = Helper.correctNull((String)hshRequestValues.get("txt_totmargin"));
					totloanamt = Helper.correctNull((String)hshRequestValues.get("txt_totloanamt"));
					seltractor = Helper.correctNull((String)hshRequestValues.get("sel_tractor"));
					tractorreason = Helper.correctNull((String)hshRequestValues.get("txt_tractorreason"));
					selmachinery = Helper.correctNull((String)hshRequestValues.get("sel_machinery"));
					machineryreason = Helper.correctNull((String)hshRequestValues.get("txt_machineryreason"));
					strSaltoSB = Helper.correctNull((String)hshRequestValues.get("sel_salrytoSB"));
					strAdeqIncome = Helper.correctNull((String)hshRequestValues.get("sel_adeqincsrc"));
					
				if(hidAction.equalsIgnoreCase("update"))
				{
					HashMap hshQuery3 = new HashMap();
					ArrayList arrValues3 = new ArrayList();
					hshQuery3.put("size", "1");
					hshQuery3.put("strQueryId", "del_farmmechparticulars");
					arrValues3.add(appno);
					hshQuery3.put("arrValues", arrValues3);
					hshQueryValues1.put("1", hshQuery3);
					hshQueryValues1.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
					
					for(int i=0; i<7; i++)
					{
						arrValues = new ArrayList();
						arrValues.add(appno);				
						arrValues.add(Integer.toString(i+1));
						arrValues.add(particulars[i]);
						if(make[i].equalsIgnoreCase(""))
						{
							make[i]="0.00";
						}
						arrValues.add(make[i]);
						if(hpower[i].equalsIgnoreCase(""))
						{
							hpower[i]="0.00";
						}
						arrValues.add(hpower[i]);
						if(estimcost[i].equalsIgnoreCase(""))
						{
							estimcost[i]="0.00";
						}
						arrValues.add(estimcost[i]);
						if(margin[i].equalsIgnoreCase(""))
						{
							margin[i]="0.00";
						}
						arrValues.add(margin[i]);
						if(loanamt[i].equalsIgnoreCase(""))
						{
							loanamt[i]="0.00";
						}
						arrValues.add(loanamt[i]);
						if(totestimcost.equalsIgnoreCase(""))
						{
							totestimcost="0.00";
						}
						arrValues.add(totestimcost);
						if(totmargin.equalsIgnoreCase(""))
						{
							totmargin="0.00";
						}
						arrValues.add(totmargin);
						if(totloanamt.equalsIgnoreCase(""))
						{
							totloanamt="0.00";
						}
						arrValues.add(totloanamt);
						arrValues.add(seltractor);
						arrValues.add(tractorreason);
						arrValues.add(selmachinery);
						arrValues.add(machineryreason);
						arrValues.add(strSaltoSB);
						arrValues.add(strAdeqIncome);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_farmmechparticulars");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}	
		//====================Insert this same value into Farm Mechanisation Eligibility calculation========================
						
						 hshQuery = new HashMap();
						 arrValues = new ArrayList();
						 hshQuery3 = new HashMap();
						 arrValues3 = new ArrayList();
						 hshQueryValues1 = new HashMap();
						hshQuery3.put("size", "1");
						hshQuery3.put("strQueryId", "del_farmmechparticularsEMI");
						arrValues3.add(appno);
						hshQuery3.put("arrValues", arrValues3);
						hshQueryValues1.put("1", hshQuery3);
						hshQueryValues1.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
						
						for(int i=0; i<7; i++)
						{
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(Integer.toString(i+1));
							arrValues.add(particulars[i]);
							if(make[i].equalsIgnoreCase(""))
							{
								make[i]="0.00";
							}
							arrValues.add(make[i]);
							if(hpower[i].equalsIgnoreCase(""))
							{
								hpower[i]="0.00";
							}
							arrValues.add(hpower[i]);
							if(estimcost[i].equalsIgnoreCase(""))
							{
								estimcost[i]="0.00";
							}
							arrValues.add(estimcost[i]);
							if(margin[i].equalsIgnoreCase(""))
							{
								margin[i]="0.00";
							}
							arrValues.add(margin[i]);
							if(loanamt[i].equalsIgnoreCase(""))
							{
								loanamt[i]="0.00";
							}
							arrValues.add(loanamt[i]);
							if(totestimcost.equalsIgnoreCase(""))
							{
								totestimcost="0.00";
							}
							arrValues.add(totestimcost);
							if(totmargin.equalsIgnoreCase(""))
							{
								totmargin="0.00";
							}
							arrValues.add(totmargin);
							if(totloanamt.equalsIgnoreCase(""))
							{
								totloanamt="0.00";
							}
							arrValues.add(totloanamt);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","ins_farmmechparticularsEMI");
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
					}
				}		
			
				if(hidAction.equalsIgnoreCase("delete"))
				{
					HashMap hshQuery3 = new HashMap();
					ArrayList arrValues3 = new ArrayList();
					hshQuery3.put("size", "1");
					hshQuery3.put("strQueryId", "del_farmmechparticulars");
					arrValues3.add(appno);
					hshQuery3.put("arrValues", arrValues3);
					hshQueryValues1.put("1", hshQuery3);
					hshQueryValues1.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				}
				if(hidAction.equalsIgnoreCase("delete"))
				{
					HashMap hshQuery3 = new HashMap();
					ArrayList arrValues3 = new ArrayList();
					hshQuery3.put("size", "1");
					hshQuery3.put("strQueryId", "del_farmmechanism_part");
					arrValues3.add(appno);
					hshQuery3.put("arrValues", arrValues3);
					hshQueryValues1.put("1", hshQuery3);
					hshQueryValues1.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				}
				
				StringBuilder sbAuditTrial=new StringBuilder();
				
				sbAuditTrial.append("Particulars of Investment ^");
				
				for(int j=0;j<particulars.length;j++)
				{
					sbAuditTrial.append("~Particulars = ").append(FwHelper.correctNull(particulars[j]))
					.append("~Name of the supplier = ").append(FwHelper.correctNull(make[j]))
					.append("~Quotation no & Date = ").append(FwHelper.correctNull(hpower[j]))
					.append("~No. of Units = ").append(FwHelper.correctNull(estimcost[j]))
					.append("~Rate per unit = ").append(FwHelper.correctNull(margin[j]))
					.append("~Total Cost = ").append(FwHelper.correctNull(loanamt[j]));
				}
				if(hidAction.equalsIgnoreCase("update"))
				{
					hshRequestValues.put(hidAction,"insert");
				}
			/*	if(Helper.correctNull((String)hshRequestValues.get("strProductType")).equalsIgnoreCase(ProductConstants.MinorIrrigation))		
				{
					//AuditTrial.auditLog(hshRequestValues,"227",appno,sbAuditTrial.toString());
				}
				else
				{
					//AuditTrial.auditLog(hshRequestValues,"224",appno,sbAuditTrial.toString());
				}*/
			  }		
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}	
			}
			
			
			public  HashMap getSolarlightData(HashMap hshValues) 
			{
		 		ResultSet rs = null; 	
		 		String strQuery = "";
		 		HashMap hshRecord = new HashMap();
				ArrayList vecRow = new ArrayList();
				ArrayList vecData = new ArrayList();
				boolean bstate =true;
				try
				{
					String appno	= Helper.correctNull((String )hshValues.get("appno"));	
					if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
					{
						appno = Helper.correctNull((String)hshValues.get("strappno"));
					}
					strQuery = SQLParser.getSqlQuery("sel_farmmechparticulars^" + appno);
					rs = DBUtils.executeQuery(strQuery);			
					bstate = rs.next();			
					if(bstate==true)
					{
						rs.beforeFirst();
						while(rs.next())
						{
							vecRow = new ArrayList();
							vecRow.add(Helper.correctNull(rs.getString("appno")));
							vecRow.add(Helper.correctNull(rs.getString("particulars")));
							if(Helper.correctNull(rs.getString("make")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("make")));
							}
							if(Helper.correctNull(rs.getString("hp")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("hp")));
							}
							if(Helper.correctNull(rs.getString("estimcost")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("estimcost")));
							}
							if(Helper.correctNull(rs.getString("margin")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("margin")));
							}
							if(Helper.correctNull(rs.getString("loanamt")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("loanamt")));
							}
							if(Helper.correctNull(rs.getString("totestimamt")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("totestimamt")));
							}
							if(Helper.correctNull(rs.getString("totmarginamt")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("totmarginamt")));
							}
							if(Helper.correctNull(rs.getString("totloanamt")).equalsIgnoreCase("0.00"))
							{
								vecRow.add("");
							}
							else
							{
								vecRow.add(Helper.correctNull(rs.getString("totloanamt")));
							}
							vecRow.add(Helper.correctNull(rs.getString("sel_tractor")));
							vecRow.add(Helper.correctNull(rs.getString("tractorreason")));
							vecRow.add(Helper.correctNull(rs.getString("sel_machinery")));
							vecRow.add(Helper.correctNull(rs.getString("machineryreason")));
							vecRow.add(Helper.correctNull(rs.getString("SALARYTOSB")));
							vecRow.add(Helper.correctNull(rs.getString("ADEQUATE_INCOME")));
							vecData.add(vecRow);
							hshRecord.put("seltractor", Helper.correctNull(rs.getString("sel_tractor")));
							hshRecord.put("selmachinery", Helper.correctNull(rs.getString("sel_machinery")));
							hshRecord.put("SALARYTOSB", Helper.correctNull(rs.getString("SALARYTOSB")));
							hshRecord.put("ADEQUATE_INCOME", Helper.correctNull(rs.getString("ADEQUATE_INCOME")));
							hshRecord.put("totestimamt", Helper.correctNull(rs.getString("totestimamt")));
							hshRecord.put("totmarginamt", Helper.correctNull(rs.getString("totmarginamt")));
							hshRecord.put("totloanamt",Helper.correctNull(rs.getString("totloanamt")));
							
						}
						if(rs != null){
							rs.close();
						}
					}
					else
					{
						for(int i=0; i<7; i++)
						{
							vecRow = new ArrayList();
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecRow.add("");
							vecData.add(vecRow);
						}
					}
					hshRecord.put("vecData",vecData);
					
					
					if(rs != null)
					{
						rs.close();
					}	
					rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+appno);
					if(rs.next())
					{
						hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
					}
					
					if(rs != null)
					{
						rs.close();
					}	
					//for checking freeze count
		    		int strFreezecount=0;
		    		String strFreezeflag="N",strPrioityflag="N";
		    		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + appno);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
						if(strFreezecount!=0 )
						{
							strFreezeflag="Y";
						}
					}
					if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
					{
						strFreezeflag="N";
					}
					hshRecord.put("strFreezeflag",strFreezeflag);
	    		
					
				}
				catch(Exception ce)
				{
					throw new EJBException("Error in getSolarlightData "+ce.toString());
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

				 
			public HashMap getSericultureIncomeExp(HashMap hshValues)  
			{
				String strQuery="";
				ResultSet rs = null; 
				HashMap hshRecord = new HashMap();
				ArrayList arrData = new ArrayList();
				ArrayList arrVal;
				String strappno="";
				String strType="",agr_schemeType="",agr_schemeSno="";
				
				try 
				{
					strappno=Helper.correctNull((String)hshValues.get("appno"));
					String schemetype=correctNull((String)hshValues.get("schemetype"));
					agr_schemeType=Helper.getfacilitySchemetype(schemetype);
					agr_schemeSno=Helper.getfacilitySno(schemetype);
					strType=Helper.correctNull((String)hshValues.get("reartype"));
					strQuery = SQLParser.getSqlQuery("sel_agr_seriincexpmeasure^"+strappno+"^"+agr_schemeSno+"^"+agr_schemeType);	
						
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("unitarea",(Helper.correctNull(rs.getString("agr_unitarea"))));
						hshRecord.put("spacing1",(Helper.correctNull(rs.getString("agr_space1"))));
						hshRecord.put("spacing2",(Helper.correctNull(rs.getString("agr_space2"))));
						hshRecord.put("population",(Helper.correctDouble(rs.getString("agr_plantpopulation"))));
					}
					if(rs!=null){
						rs.close();
					}
					
					if(!strType.equals("") && !strType.equals("0"))
					{
						strQuery = SQLParser.getSqlQuery("sel_agr_seriincexp^"+strappno+"^"+strType+"^"+agr_schemeSno+"^"+agr_schemeType);	
						arrData = new ArrayList();
						rs=DBUtils.executeQuery(strQuery);
						while(rs.next())
						{
							arrVal = new ArrayList();
							arrVal.add(Helper.correctNull(rs.getString("agr_desc")));
							arrVal.add(Helper.correctNull(rs.getString("agr_year1rate")));
							arrVal.add(Helper.correctNull(rs.getString("agr_year1total")));
							arrVal.add(Helper.correctNull(rs.getString("agr_year2rate")));
							arrVal.add(Helper.correctNull(rs.getString("agr_year2total")));
							arrVal.add(Helper.correctNull(rs.getString("agr_kilogram")));
							arrVal.add(Helper.correctNull(rs.getString("agr_reartype")));
							arrData.add(arrVal);
						}
						if(rs!=null){
							rs.close();
						}
						hshRecord.put("arrPart",arrData);
					}
					
					hshRecord.put("appno",strappno);
					hshRecord.put("schemetype",agr_schemeType);
					hshRecord.put("agr_schemeSno",agr_schemeSno);
					    
				} 
				catch (Exception e) 
				{	log.error(e);	
				throw new EJBException("Error in getSericultureIncomeExp - AgriEconomicBean"+e.toString());
					
				}
				finally
				{
					try 
					{	
						if(rs!=null){
							rs.close();
						}
					}
					catch (SQLException e) 
					{	log.error(e);	
						throw new EJBException("Error in getSericultureIncomeExp - agrEconomicBean "+e.toString());
					}
				}
				return hshRecord;
				
			}
			
			public void updateSericultureIncomeExp(HashMap hshValues) 
			{
				HashMap hshQueryValues = new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
				String appno="";
				int intindex=1;
				int intLoop=1;
				String  strAcre; 
				String strSpace1;
				String strSpace2;
				String  strPopulation;
				String [] strDesc;
				String [] strRate1;
				String [] strTotal1;
				String [] strRate2;
				String [] strTotal2;
				String strType;
				String strkilogram;
				String strQuery="",agr_schemeType="",agr_schemeSno="";
				ResultSet rs = null; 
				try
				{		
					appno				=	Helper.correctNull((String)hshValues.get("appno"));
					strAcre				= 	Helper.correctNull((String)hshValues.get("txt_acre"));	
					strSpace1			= 	Helper.correctNull((String)hshValues.get("txt_space1"));	
					strSpace2			= 	Helper.correctNull((String)hshValues.get("txt_space2"));
					strPopulation		=   Helper.correctNull((String)hshValues.get("txt_population"));
					strType				=	Helper.correctNull((String)hshValues.get("sel_rear_system"));
					strDesc				= 	(String [])hshValues.get("txt_desc");	
					strRate1			=  	(String [])hshValues.get("txt_rate1");
					strTotal1			=  	(String [])hshValues.get("txt_total1");
					strRate2			=  	(String [])hshValues.get("txt_rate2");
					strTotal2			=  	(String [])hshValues.get("txt_total2");
					strkilogram			=	Helper.correctNull((String)hshValues.get("txt_kg"));
					String schemetype=correctNull((String)hshValues.get("schemetype"));
					agr_schemeType=Helper.getfacilitySchemetype(schemetype);
					agr_schemeSno=Helper.getfacilitySno(schemetype);
					if(hshValues.get("hidAction").toString().equals("insert"))
					{		
							if(!strAcre.equals(""))
							{
								hshQuery.put("strQueryId","del_seriincexpmeasure");			
								arrValues.add(appno);
								arrValues.add(agr_schemeSno);
								arrValues.add(agr_schemeType);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intLoop),hshQuery);
								intLoop++; 
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_seriincexp");			
								arrValues.add(appno);
								arrValues.add(strType);
								arrValues.add(agr_schemeSno);
								arrValues.add(agr_schemeType);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intLoop),hshQuery);
								intLoop++; 
							}
							
							arrValues = null;
							hshQuery = null;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_seriincexpmeasure");
					        arrValues.add(appno);
					        arrValues.add(Helper.correctDouble(strAcre));
				        	arrValues.add(Helper.correctDouble(strSpace1));
				        	arrValues.add(Helper.correctDouble(strSpace2));
				        	arrValues.add(Helper.correctDouble(strPopulation));
				        	arrValues.add(agr_schemeSno);
							arrValues.add(agr_schemeType);
			        		hshQuery.put("arrValues",arrValues);
				           	hshQueryValues.put(Integer.toString(intLoop),hshQuery);
					      
				        	while(intindex<=strDesc.length)
					        {
					        	if(strDesc[intindex-1] != null && !strDesc[intindex-1].equals(""))
					        	{
					        		arrValues = null;
									hshQuery = null;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","ins_seriincexp");
									arrValues.add(appno);
									arrValues.add(Integer.toString(intindex));
									arrValues.add(strDesc[intindex-1]);
						        	arrValues.add(Helper.correctDouble(strRate1[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strTotal1[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strRate2[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strTotal2[intindex-1]));
						        	arrValues.add(Helper.correctDouble(strkilogram));
						        	arrValues.add(strType);
						        	arrValues.add(agr_schemeSno);
									arrValues.add(agr_schemeType);
						        	hshQuery.put("arrValues",arrValues);
							        hshQueryValues.put(Integer.toString(intLoop+1),hshQuery);
							        intLoop++;
					        	}
					        	intindex++;
					        	
					        }
					        	
					    	hshQueryValues.put("size",Integer.toString(intLoop));
					    	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
					else if(hshValues.get("hidAction").toString().equals("delete"))
					{
						hshQuery.put("strQueryId","del_seriincexp");			
						arrValues.add(appno);
						arrValues.add(strType);
						arrValues.add(agr_schemeSno);
						arrValues.add(agr_schemeType);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						strQuery = SQLParser.getSqlQuery("sel_seriincexprowcount^"+appno);	
						rs=DBUtils.executeQuery(strQuery);
						if(!rs.next())
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","del_seriincexpmeasure");			
							arrValues.add(appno);
							arrValues.add(agr_schemeSno);
							arrValues.add(agr_schemeType);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						if(rs!=null){
							rs.close();
						}
					}	
				}
				catch(Exception e)
				{	log.error(e);
					throw new EJBException("Error in updateSericultureIncomeExp - AgriMechanisedBoatBean "+e.toString());
				}
				finally
				{
					try 
					{	if(rs !=null)
							rs.close();
					}
					catch (SQLException e) 
					{	log.error(e);	
						throw new EJBException("Error in updateSericultureIncomeExp - AgriMechanisedBoatBean "+e.toString());
					}
				}
			    
			}	 
		 
		 
		

}
