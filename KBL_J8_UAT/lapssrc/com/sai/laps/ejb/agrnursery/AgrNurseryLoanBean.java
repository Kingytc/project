package com.sai.laps.ejb.agrnursery;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.rules.AgrFarmMachineryBO;
import com.sai.laps.ejb.rules.AgrNurseryLoanBO;
import com.sai.laps.ejb.rules.StaticDataBO;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgrNurseryLoanBean", mappedName = "AgrNurseryLoanHome")
@Remote (AgrNurseryLoanRemote.class)
public class AgrNurseryLoanBean extends BeanAdapter{

	static Logger log=Logger.getLogger(AgrNurseryLoanBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getHorticultureIncomeExp(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getTotIncomeExpByAppno(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getHorticultureIncomeExp === "+e.toString());
		}
		return hshRecord;
	}

	public HashMap getHorticultureFinancialAnalysis(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().calculateFinancialAnalysisByAppno(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getHorticultureFinancialAnalysis === "+e.toString());
		}
		return hshRecord;
	}

	public void updateDairyCostofInvestment(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		try
		{
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strAppno= correctNull((String)hshValues.get("strappno"));
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQueryValues.put("size","1");
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","agr_dairycostofinvestment_delete");
			arrValues.add(strAppno);
			arrValues.add(schemetype);
			arrValues.add(strFacSNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(strAction.trim().equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_dairycostofinvestment_insert");
				arrValues.add(strAppno);//0
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noofadultanimal")));//1
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_sqftperadultanimal")));//2
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_adultshedamtpersqft")));//3
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costofconsofadultshed")));//4
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noofcalvesanimal")));//5
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noofheifersanimal")));//6
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_calvesarea")));//7
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_calvesamtpersqft")));//8
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costofcalvesshed")));//9
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_equipmentcostperanimal")));//10	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_noofanimal")));//11
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costofequipment")));//12
				arrValues.add("0.00");//13
				arrValues.add("0.00");//14
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costoffencing")));//15
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_yieldingltr")));//16
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costofanimal")));	//17
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totalcostofanimal")));//18
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_maintenancecost")));//19
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_firstbatchanimal")));	//20	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_insurancepercent")));//21
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_insurancecost")));//22
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_miscellaneouscost")));//23
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totalunitcost")));//24
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_heifersarea")));//25
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_heifersamtpersqft")));//26
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costofheifersshed")));//27
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_godowncost")));//28
				arrValues.add(schemetype);//29
				arrValues.add(strFacSNo);//30
				arrValues.add(Helper.correctInt((String)hshValues.get("sel_animaltype")));//31
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(rs!=null) rs.close();
				rs=DBUtils.executeLAPSQuery("agr_dairyherdproduction_count_select^"+strAppno+"^"+strFacSNo);
				boolean bstate=false;
				if(rs.next())
				{
					if(FwHelper.parseInt(Helper.correctInt((String)rs.getString("total")))>0)
					{
						bstate=true;
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				if(bstate)
				{
					int ionhandbegin=FwHelper.parseInt(Helper.correctInt((String)hshValues.get("txt_noofadultanimal")));
					int igrownyear1=0,igrownyear2=0,igrownyear3=0,igrownyear4=0,igrownyear5=0,igrownyear6=0;
					int isoldyear1=0,isoldyear2=0,isoldyear3=0,isoldyear4=0,isoldyear5=0,isoldyear6=0;
					rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_selectBySlNo^"+strAppno+"^2"+"^"+schemetype+"^"+strFacSNo);
					if(rs.next())
					{
						igrownyear1=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_firstyear")));
						igrownyear2=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_secondyear")));
						igrownyear3=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_thirdyear")));
						igrownyear4=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_fourthyear")));
						igrownyear5=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_fifthyear")));
						igrownyear6=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_sixthyear")));
					}
					if(rs!=null) rs.close();
					rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_selectBySlNo^"+strAppno+"^3"+"^"+schemetype+"^"+strFacSNo);
					if(rs.next())
					{
						isoldyear1=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_firstyear")));
						isoldyear2=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_secondyear")));
						isoldyear3=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_thirdyear")));
						isoldyear4=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_fourthyear")));
						isoldyear5=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_fifthyear")));
						isoldyear6=FwHelper.parseInt(Helper.correctInt((String)rs.getString("agr_hrdproud_sixthyear")));
					}
					int iendyear1=calculateBuffaloesCount(ionhandbegin, igrownyear1, isoldyear1);
					int iendyear2=calculateBuffaloesCount(ionhandbegin, igrownyear2, isoldyear2);
					int iendyear3=calculateBuffaloesCount(ionhandbegin, igrownyear3, isoldyear3);
					int iendyear4=calculateBuffaloesCount(ionhandbegin, igrownyear4, isoldyear4);
					int iendyear5=calculateBuffaloesCount(ionhandbegin, igrownyear5, isoldyear5);
					int iendyear6=calculateBuffaloesCount(ionhandbegin, igrownyear6, isoldyear6);
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_dairyherdproduction_deletebyslno");
					arrValues.add(strAppno);
					arrValues.add(strFacSNo);
					arrValues.add("1");
					arrValues.add("4");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_dairyherdproduction_insert");
					arrValues.add(strAppno);//1
					arrValues.add("1");//2
					for(int i=0;i<6;i++)
					{
						arrValues.add(String.valueOf(ionhandbegin));
					}
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_dairyherdproduction_insert");
					arrValues.add(strAppno);//1
					arrValues.add("4");//2
					arrValues.add(String.valueOf(iendyear1));//3
					arrValues.add(String.valueOf(iendyear2));//4
					arrValues.add(String.valueOf(iendyear3));//5
					arrValues.add(String.valueOf(iendyear4));//6
					arrValues.add(String.valueOf(iendyear5));//7
					arrValues.add(String.valueOf(iendyear6));//8
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					hshQueryValues.put("size","3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			//					---------------------------------------Audittrial------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append(
			"~Land Preparation = ").append(correctNull((String)hshValues.get("txt_landPrep"))).append(
			"~Cost of cuttings = ").append(correctNull((String )hshValues.get("txt_cuttings"))).append(
			"~Planting expenses= ").append(correctNull((String )hshValues.get("txt_planting"))).append(
			"~Manures = ").append(correctNull((String )hshValues.get("txt_manures"))).append(
			"~Irrigation= ").append(correctNull((String )hshValues.get("txt_irrigation"))).append(
			"~Weeding= ").append(correctNull((String )hshValues.get("txt_weeding"))).append(
			"~Others = ").append(correctNull((String)hshValues.get("txt_others"))).append(
			"~Total cost of planting = ").append(correctNull((String )hshValues.get("txt_totala"))).append(
			"~Construction of rear shed sft = ").append(correctNull((String )hshValues.get("txt_rearshedsft"))).append(
			"~Construction of rear shed rs = ").append(correctNull((String )hshValues.get("txt_rearshedrs"))).append(
			"~Rearing stand no= ").append(correctNull((String )hshValues.get("txt_rearstandno"))).append(
			"~Rearing stand rs = ").append(correctNull((String )hshValues.get("txt_rearstandrs"))).append(
			"~Rearing tray no= ").append(correctNull((String )hshValues.get("txt_reartrayno"))).append(
			"~Rearing tray rs = ").append(correctNull((String)hshValues.get("txt_reartrayrs"))).append(
			"~chandrikas no = ").append(correctNull((String )hshValues.get("txt_chandrikano"))).append(
			"~chandrikas rs = ").append(correctNull((String )hshValues.get("txt_chandrikars"))).append(
			"~Miscellaneous  = ").append(correctNull((String )hshValues.get("txt_misc"))).append(
			"~Total cost of equipment= ").append(correctNull((String )hshValues.get("txt_totalb"))).append(
			"~Labour charges = ").append(correctNull((String )hshValues.get("txt_labour"))).append(
			"~Transportation & marketing= ").append(correctNull((String )hshValues.get("txt_marketing"))).append(
			"~Cost of DFL no = ").append(correctNull((String)hshValues.get("txt_dflno"))).append(
			"~DFL rs. each = ").append(correctNull((String )hshValues.get("txt_dflrs"))).append(
			"~Total cost of rearing worms = ").append(correctNull((String )hshValues.get("txt_totalc"))).append(
			"~Unit cost = ").append(correctNull((String )hshValues.get("txt_totalunitcost"))).append(
			"~No. of acres = ").append(correctNull((String )hshValues.get("txt_noofacres")));
			//AuditTrial.auditLog(hshValues,"302",strAppno,sbAuditTrial.toString());
			//-------------------------------------------End---------------------------
		}
		catch(Exception ce)
		{
			log.error(ce);
			throw new EJBException("Error in updateDairyCostofInvestment === "+ce.toString());
		}
	}

	private int calculateBuffaloesCount(int ibegincount,int igrowncount,int isoldcount) 
	{
		int iendofyearcount=0;
		iendofyearcount=ibegincount+igrowncount-isoldcount;
		return iendofyearcount;
	}

	public HashMap getDairyCostofInvestment(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			strAppNo=correctNull((String)hshValues.get("appno"));
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getDairyCostofInvestmentByAppno(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyCostofInvestment === "+e.toString());
		}
		return hshRecord;
	}

	public void updateDairyFinancialData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		try
		{
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strAppno= correctNull((String)hshValues.get("strappno"));
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","agr_dairyfinancialdata_delete");
			arrValues.add(strAppno);
			arrValues.add(schemetype);
			arrValues.add(strFacSNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(strAction.trim().equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_dairyfinancialdata_insert");
				arrValues.add(strAppno);//0
				arrValues.add(correctNull((String)hshValues.get("txt_milkcostperltr")));//1
				arrValues.add(correctNull((String)hshValues.get("txt_manurecost")));//2
				arrValues.add(correctNull((String)hshValues.get("txt_buffaloecost")));	//3
				arrValues.add(correctNull((String)hshValues.get("txt_expvetaidadult")));//4
				arrValues.add(correctNull((String)hshValues.get("txt_expvetaidheifer")));//5
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_expelectricity")));//6
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_heiferfoddercost")));//7
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_nooflabour")));//8
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_laboursalary")));//9
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_lactgreenfodderwt")));	//10
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_lactdryfodderwt")));//11
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_lactconcentratefeedwt")));	//12
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_drygreenfodderwt")));//13
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_drydryfodderwt")));	//14
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_dryconcentratefeedwt")));//15
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_greenfoddercost")));//16	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_dryfoddercost")));//17
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_concentratefoddercost")));	//18
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_heiferfeedcost")));//19
				arrValues.add(schemetype);//20
				arrValues.add(strFacSNo);//21
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//					---------------------------------------Audittrial------------------------
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append(
			"~Sale Price of Milk per ltr. = ").append(correctNull((String)hshValues.get("txt_milkcostperltr"))).append(
			"~Sale of Manure per animal= ").append(correctNull((String)hshValues.get("txt_manurecost"))).append(
			"~Sale Price of Each Buffaloe= ").append(correctNull((String)hshValues.get("txt_buffaloecost"))).append(
			"~Expenses on Veterianary Aid / Adult / Year= ").append(correctNull((String)hshValues.get("txt_expvetaidadult"))).append(
			"~Expenses on Veterianary Aid / Heifer / Year= ").append(correctNull((String)hshValues.get("txt_expvetaidheifer"))).append(
			"~Electricity & Other Misc expenses Per Month= ").append(correctNull((String)hshValues.get("txt_expelectricity"))).append(
			"~Cost of Feed & Fodder/Heifer/Year= ").append(correctNull((String)hshValues.get("txt_heiferfoddercost"))).append(
			"~No of Labourers = ").append(correctNull((String )hshValues.get("txt_nooflabour"))).append(
			"~Salary /Month/labourers = ").append(correctNull((String )hshValues.get("txt_laboursalary"))).append(
			"~Feeding during Lactation days Green fodder  = ").append(correctNull((String )hshValues.get("txt_lactgreenfodderwt"))).append(
			"~Feeding during Lactation days Dry fodder= ").append(correctNull((String )hshValues.get("txt_lactdryfodderwt"))).
			append("~Feeding during Lactation days Concentrate fodder=").append(correctNull((String )hshValues.get("txt_lactconcentratefeedwt"))).
			append("~Feeding during dry days Green fodder=").append(correctNull((String )hshValues.get("txt_drygreenfodderwt"))).
			append("~Feeding during dry days dry fodder=").append(correctNull((String )hshValues.get("txt_drydryfodderwt"))).
			append("~Feeding during dry days Concentrate fodder=").append(correctNull((String )hshValues.get("txt_lactconcentratefeedwt"))).
			append("~Cost Per KG for Green fodder=").append(correctNull((String )hshValues.get("txt_greenfoddercost"))).
			append("~Cost Per KG for dry fodder=").append(correctNull((String )hshValues.get("txt_dryfoddercost"))).
			append("~Cost Per KG for Concentrate fodder=").append(correctNull((String )hshValues.get("txt_concentratefoddercost")));
			
			//AuditTrial.auditLog(hshValues,"305",strAppno,sbAuditTrial.toString());	
			//-------------------------------------------End---------------------------
		}
		catch(Exception ce)
		{
			log.error(ce);
			throw new EJBException("Error in updateDairyFinancialData === "+ce.toString());
		}
	}

	public HashMap getDairyFinancialData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getDairyFinancialDataByAppNo(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyFinancialData === "+e.toString());
		}
		return hshRecord;
	}

	public void updateDairyHerdProductionChart(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAction=correctNull((String)hshValues.get("hidAction"));
			int iUpdatesize=0;
			strAppNo=correctNull((String)hshValues.get("strAppno"));
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("appno"));
			}
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("strAppno"));
			}
			String strYear1[]=(String [])hshValues.get("txt_year1");//Year1
			String strYear2[]=(String [])hshValues.get("txt_year2");//Year2
			String strYear3[]=(String [])hshValues.get("txt_year3");//Year3
			String strYear4[]=(String [])hshValues.get("txt_year4");//Year4				
			String strYear5[]=(String [])hshValues.get("txt_year5");//Year5
			String strYear6[]=(String [])hshValues.get("txt_year6");//Year6
			hshQuery=new HashMap();
			hshQueryValues=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","agr_dairyherdproduction_delete");
			arrValues.add(strAppNo);
			arrValues.add(schemetype);
			arrValues.add(strFacSNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(strAction.trim().equalsIgnoreCase("insert"))
			{
				hshQueryValues=new HashMap();
				for(int k=0;k<12;k++)
				{				
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					hshQuery.put("strQueryId","agr_dairyherdproduction_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(String.valueOf(k+1));//serial no 2
					arrValues.add(Helper.correctInt(strYear1[k]));//Year 1		//3
					arrValues.add(Helper.correctInt(strYear2[k]));//Year 2		//4	
					arrValues.add(Helper.correctInt(strYear3[k]));//Year 3		//5
					arrValues.add(Helper.correctInt(strYear4[k]));//Year 4		//6
					arrValues.add(Helper.correctInt(strYear5[k]));//Year 5		//7	
					arrValues.add(Helper.correctInt(strYear6[k]));//Year 6		//8	
					arrValues.add(schemetype); //For schemetype
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int k=0;k<12;k++)
			{	
				strActionData=new StringBuilder();
				strActionData.append(" ;~  Year1 =").
				append(Helper.correctInt(strYear1[k])).
				append(";~ Year2 =").
				append(Helper.correctInt(strYear2[k])).
				append(";~ Year3 =").
				append(Helper.correctInt(strYear3[k])).
				append(";~ Year4 =").
				append(Helper.correctInt(strYear4[k])).
				append(";~ Year5 =").
				append(Helper.correctInt(strYear5[k])).
				append(";~ Year6 =").
				append(Helper.correctInt(strYear6[k]));
				arrValues.add(strActionData.toString());
				arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				//AuditTrial.auditLogBatch(hshValues,"304",strAppNo,arrAuditBatchData);
			}
		}
		catch(Exception e)
		{
			log.error("Error in updateDairyHerdProductionChart "+e.getMessage());
			throw new EJBException("Error in updateDairyHerdProductionChart === "+e.toString());
		}
	}

	public HashMap getDairyHerdProductionChart(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getDairyHerdProductionChartByAppno(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyHerdProductionChart === "+e.toString());
		}
		return hshRecord;
	}

	public void updateDairyIncomeStatement(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAction=correctNull((String)hshValues.get("hidAction"));
			int iUpdatesize=0;
			strAppNo=correctNull((String)hshValues.get("strAppno"));
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("appno"));
			}
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			String strYear1[]=(String [])hshValues.get("txt_year1");//Year1
			String strYear2[]=(String [])hshValues.get("txt_year2");//Year2
			String strYear3[]=(String [])hshValues.get("txt_year3");//Year3
			String strYear4[]=(String [])hshValues.get("txt_year4");//Year4				
			String strYear5[]=(String [])hshValues.get("txt_year5");//Year5
			String strYear6[]=(String [])hshValues.get("txt_year6");//Year6	
			//Added by bhaskar for new fields
			String strCycleValues=correctNull((String)hshValues.get("txt_cycledays"));
			String strLactation=correctNull((String)hshValues.get("txt_lacdays"));
			String strDry=correctNull((String)hshValues.get("txt_drydays"));
			String strBatch2=correctNull((String)hshValues.get("txt_batch2days"));
			//end
			hshQuery=new HashMap();
			hshQueryValues=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","agr_dairyincomestatement_delete");
			arrValues.add(strAppNo);
			arrValues.add(schemetype);
			arrValues.add(strFacSNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(strAction.trim().equalsIgnoreCase("insert"))
			{
				hshQueryValues=new HashMap();
				for(int k=0;k<15;k++)
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					hshQuery.put("strQueryId","agr_dairyincomestatement_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(String.valueOf(k+1));//serial no 2
					arrValues.add(Helper.correctInt(strYear1[k]));//Year 1		//3
					arrValues.add(Helper.correctInt(strYear2[k]));//Year 2		//4	
					arrValues.add(Helper.correctInt(strYear3[k]));//Year 3		//5
					arrValues.add(Helper.correctInt(strYear4[k]));//Year 4		//6
					arrValues.add(Helper.correctInt(strYear5[k]));//Year 5		//7	
					arrValues.add(Helper.correctInt(strYear6[k]));//Year 6		//8	
					arrValues.add(schemetype);	//For Schemetype
					arrValues.add(strFacSNo);
					//Added by bhaskar for new fileds
					arrValues.add(strCycleValues);
					arrValues.add(strLactation);
					arrValues.add(strDry);
					arrValues.add(strBatch2);
					//end			
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int k=0;k<12;k++)
			{	
				strActionData=new StringBuilder();
				strActionData.append(" ;~  Year1 =").
				append(Helper.correctInt(strYear1[k])).
				append(";~ Year2 =").
				append(Helper.correctInt(strYear2[k])).
				append(";~ Year3 =").
				append(Helper.correctInt(strYear3[k])).
				append(";~ Year4 =").
				append(Helper.correctInt(strYear4[k])).
				append(";~ Year5 =").
				append(Helper.correctInt(strYear5[k])).
				append(";~ Year6 =").
				append(Helper.correctInt(strYear6[k]));
				arrValues.add(strActionData.toString());
				arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				//AuditTrial.auditLogBatch(hshValues,"306",strAppNo,arrAuditBatchData);
			}
		}
		catch(Exception e)
		{
			log.error("Error in updateDairyIncomeStatement "+e.getMessage());
			throw new EJBException("Error in updateDairyIncomeStatement === "+e.toString());
		}
	}
	
	public HashMap getDairyIncomeStatement(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getDairyIncomeStatementByAppNo(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyIncomeStatement === "+e.toString());
		}
		return hshRecord;
	}

	public HashMap getDairyRecurringExpenditure(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			strAppNo=correctNull((String)hshValues.get("appno"));
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().getRecurringExpenditure(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyRecurringExpenditure === "+e.toString());
		}
		return hshRecord;
	}

	public HashMap getDairyFinancialAnalysis(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null;
		try
		{
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			strAppNo=correctNull((String)hshValues.get("appno"));
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strappno"));
			}
			if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
			{
				strAppNo=correctNull((String)hshValues.get("strAppno"));
			}
			hshRecord=new AgrNurseryLoanBO().calculateDairyFinancialAnalysis(strAppNo,schemetype,strFacSNo);
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException("Error in getDairyFinancialAnalysis === "+e.toString());
		}
		return hshRecord;
	}
	
	public HashMap getNurseryScaleMasterData(HashMap hshValues) 
	{
	String strQuery = "";
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrRow = new ArrayList();
	ArrayList arrVal = new ArrayList();
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrRow1 = new ArrayList();
	try 
	{
		String strStatId = correctNull((String) hshValues.get("sel_state"));
		
		
		if (strStatId.trim().equalsIgnoreCase("")) 
		{
			strStatId = "0";
		}
		String hidslno = correctNull((String) hshValues.get("sel_district"));
		if (hidslno.trim().equalsIgnoreCase("")) 
		{
			hidslno = "0";
		}	

		strQuery = SQLParser.getSqlQuery("agrnurserymaster_sel^" + strStatId+ "^" + hidslno);
		rs2 = DBUtils.executeQuery(strQuery);
		while (rs2.next())
		{
			arrVal = new ArrayList();
			arrVal.add(correctNull(rs2.getString("agr_sfn_state")));
			String statecode = correctNull(rs2.getString("agr_sfn_state"));
			String statename = "";
			if (!statecode.equalsIgnoreCase(""))
			{
				statename = new StaticDataBO().getStateNameByCode(statecode);
			}
			if (rs1 != null)
				rs1.close();
			arrVal.add(correctNull(rs2.getString("agr_sfn_district")));
			String districtcode = correctNull(rs2.getString("agr_sfn_district"));
			String districtname = "";
			if (!statecode.equalsIgnoreCase("")&& !districtcode.equalsIgnoreCase("")) 
			{
				districtname = new StaticDataBO().getDistrictNameByStateCode(statecode, districtcode);
			}
			arrVal.add(correctNull(rs2.getString("agr_sfn_plant")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_scaleoffinance")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_sno")));
			arrVal.add(districtname);
			arrVal.add(statename);
			arrVal.add(correctNull(rs2.getString("agr_sfn_type")));	
			arrVal.add(correctNull(rs2.getString("agr_sfn_scaleoffinance")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_amount")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_rangefrom")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_rangeto")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_maxnoofunits")));
			arrVal.add(correctNull(rs2.getString("agr_sfn_todate")));
			arrRow.add(arrVal);
		}
		hshRecord.put("arrRow", arrRow);
		if(rs2!=null)
			rs2.close();
		rs1 = DBUtils.executeLAPSQuery("sel_district_master^"+strStatId);		
		while(rs1.next())
		{
			arrCol1 = new ArrayList();
			arrCol1.add(correctNull(rs1.getString(1)));
			String statename = "";
			if(!strStatId.equalsIgnoreCase(""))
			{
				statename = new StaticDataBO().getStateNameByCode(strStatId);
			}
			if(rs2!=null)
				rs2.close();
			arrCol1.add(correctNull(rs1.getString(2)));
			arrCol1.add(correctNull(rs1.getString(3)));
			arrCol1.add(statename);
			arrRow1.add(arrCol1);							
		}	
		hshRecord.put("arrRow1",arrRow1);
		hshRecord.put("strStatId",strStatId);
		hshRecord.put("hidslno",hidslno);
	}
	catch (Exception ce) 
	{
		log.error("Exception in getNurseryScaleMasterData::"+ce.getMessage());
		throw new EJBException("Error in getNurseryScaleMasterData " + ce.toString());
	}
	finally 
	{
		try
		{
			if (rs1 != null) 
			{
				rs1.close();
			}
			if (rs2 != null) 
			{
				rs2.close();
			}
		} 
		catch (Exception cf) 
		{
			log.error("Exception in getNurseryScaleMasterData::"+cf.getMessage());
			throw new EJBException("Error closing the connection "+ cf.getMessage());
		}
	}
	return hshRecord;
}

	public HashMap getScaleFinanceMasterList(HashMap hshValues) 
	  {
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		String state_name	=null;
		String district_name	=null;
		ResultSet rs1=null;
		ArrayList arrRow1=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		try {
				state_name	=correctNull((String)hshValues.get("sel_state"));
				if(state_name.trim().equals(""))
					state_name="0";
				district_name	=correctNull((String)hshValues.get("sel_district"));
				arrRow=new AgrNurseryLoanBO().getNurseryScaleMasterData(state_name,district_name);
				hshRecord.put("arrRow",arrRow);
				rs1 = DBUtils.executeLAPSQuery("sel_district_master^"+state_name);		
				while(rs1.next())
				{
					arrCol1 = new ArrayList();
					arrCol1.add(correctNull(rs1.getString(1)));
					String statename = "";
					if(!state_name.equalsIgnoreCase(""))
					{
						statename = new StaticDataBO().getStateNameByCode(state_name);
					}
					arrCol1.add(correctNull(rs1.getString(2)));
					arrCol1.add(correctNull(rs1.getString(3)));
					arrCol1.add(statename);
					arrRow1.add(arrCol1);							
				}	
				hshRecord.put("arrRow1",arrRow1);
				hshRecord.put("strStatId",state_name);
				hshRecord.put("hidslno",district_name);
			
		} catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getScaleFinanceMasterList === "+e.toString());
		}
		return hshRecord;
	  }
	
	public HashMap getHorticultureScaleOfFinance(HashMap hshValues) 
	  {
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		
		String strCrop	=null;
		try {
				
				strCrop =Helper.correctNull((String)hshValues.get("sel_crop"));
				
				arrRow=new AgrNurseryLoanBO().getHorticultureScaleMasterData(strCrop);
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("Spacing", strCrop);
			
		} catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getHorticultureScaleOfFinance === "+e.toString());
		}
		return hshRecord;
	  }
	
	public HashMap getSheepRearingCostOfProject(HashMap hshValues) 
	 {

			HashMap hshRecord=new HashMap();
			String strAppNo=null;
			ArrayList arrRow = new ArrayList();
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			String schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);	
			try {
					strAppNo=correctNull((String)hshValues.get("appno"));
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strappno"));
					}
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strAppno"));
					}

					hshRecord.put("hshFixedCost",new AgrNurseryLoanBO().getSheepFixedCostByAppNo(strAppNo,schemetype,strFacSNo));
					hshRecord.put("hshRecurringCost",new AgrNurseryLoanBO().getSheepRecurringExpByAppNo(strAppNo,schemetype,strFacSNo));
					hshRecord.put("strMargin",""+new AgrNurseryLoanBO().getApplicationMarginByAppNo(strAppNo,schemetype,strFacSNo));
					arrRow=new AgrNurseryLoanBO().getHortiDF();
					hshRecord.put("arrRow",arrRow);
			} catch (Exception e) {
				log.error("Error in getSheepRearingCostOfProject::"+e.toString());
				throw new EJBException("Error in getSheepRearingCostOfProject === "+e.toString());
			}
			return hshRecord;
		  
	 }
	public void updateSheepRearingCostOfProject(HashMap hshValues) 
	  {

			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;		
			ArrayList arrValues=new ArrayList();
			
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String schemetype = correctNull((String)hshValues.get("schemetype"));	

			String strAppno= correctNull((String)hshValues.get("strappno"));		
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			ResultSet rs = null;
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			try
			{			
				
				if(strAction.trim().equalsIgnoreCase("insert"))
				{								
					
				 	arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","4");	
					hshQuery = new HashMap();					
					hshQuery.put("strQueryId","agr_sheepfixedcost_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				 
					
					hshQuery = new HashMap();					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheeprecurringexp_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					hshQuery = new HashMap();					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheepfixedcost_insert");
								
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_noofanimal")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_sqftperanimal")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_shedamtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofconsofshed")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_areaofsqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_roomamtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofoficecons")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_fencingcost")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoffencing")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_equipcostperanimal")));		
					arrValues.add(Helper.correctNull((String )hshValues.get("txt_noofanimalforequip")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofequipment")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofwatersource")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_othercost")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totala")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("sel_df"))); //DF %
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_fenper")));
					arrValues.add(strFacSNo);
					arrValues.add(schemetype);
					
					//Added by Arsath on 06/03/2014 as per the new requirements
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedareaofsqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedamtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoffeedcons")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_areaoflaboursqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_labouramtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoflabourcons")));
					
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);	
					
					hshQuery = new HashMap();					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheeprecurringexp_insert");
								
					arrValues.add(strAppno);
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_noofadults")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_nooframs")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofewes")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofram")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofeweram")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_cultivationacre")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_cultivationcstperacre")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofcultivation")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedconcentrateadultkg")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedconcentratelamb")));		
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feednoofadults")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feednooflambs")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totalquantitykg")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_amtoffeedperkg")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoffeed")));
					
					
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_nooflabours")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_amtperlabour")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofwage")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofvetenaryperanimal")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofvetenary")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_insurpremiumpercanim")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_insurperccostofshed")));		
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofinsurance")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_electricitypermonth")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_electricityperyear")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_totalb")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_bankloan")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_cstfeed")));
					arrValues.add(strFacSNo);
					arrValues.add(schemetype);
					
					//Added by Arsath on 06/03/2014 as per the new requirements
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedareaofsqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_feedamtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoffeedcons")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_areaoflaboursqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_labouramtpersqft")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costoflabourcons")));
					arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofsheds")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4",hshQuery);	


					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
				 if(strAction.equals("delete"))
				{
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","2");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheepfixedcost_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheeprecurringexp_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
				}
				
//					---------------------------------------Audittrial------------------------
				StringBuilder sbAuditTrial=new StringBuilder();
				
						
				sbAuditTrial.append(
				"~No of animals = ").append(correctNull((String)hshValues.get("txt_noofanimal"))).append(
				"~Sq Ft required for per animal = ").append(correctNull((String )hshValues.get("txt_sqftperanimal"))).append(
				"~Cost per sq.ft = ").append(correctNull((String )hshValues.get("txt_shedamtpersqft"))).append(
				"~Cost of construction of shed = ").append(correctNull((String )hshValues.get("txt_costofconsofshed"))).append(
				"~Total area for construction of room,office etc.= ").append(correctNull((String )hshValues.get("txt_areaofsqft"))).append(
				"~Cost per sq.ft = ").append(correctNull((String )hshValues.get("txt_roomamtpersqft"))).append(
				"~Office construction cost = ").append(correctNull((String )hshValues.get("txt_costofoficecons"))).append(
				"~Fencing cost per acre = ").append(correctNull((String )hshValues.get("txt_fencingcost"))).append(
				"~Total fencing cost= ").append(correctNull((String )hshValues.get("txt_costoffencing"))).append(
				"~Equipment cost per animal = ").append(correctNull((String )hshValues.get("txt_equipcostperanimal"))).append(
				"~No of animals = ").append(correctNull((String )hshValues.get("txt_noofanimalforequip"))).append(
				"~Cost of equipments = ").append(correctNull((String )hshValues.get("txt_costofequipment"))).append(
				"~Water resource cost= ").append(correctNull((String )hshValues.get("txt_costofwatersource"))).append(
				"~Other cost = ").append(correctNull((String )hshValues.get("txt_othercost"))).append(
				"~Total A = ").append(correctNull((String )hshValues.get("txt_totala"))).append(					
				"~Fenper = ").append(correctNull((String )hshValues.get("txt_fenper"))).append(
				
				"~No of adults = ").append(correctNull((String)hshValues.get("txt_noofadults"))).append(
				"~No of Rams = ").append(correctNull((String )hshValues.get("txt_nooframs"))).append(
				"~Cost of ewes = ").append(correctNull((String )hshValues.get("txt_costofewes"))).append(
				"~Cost of rams = ").append(correctNull((String )hshValues.get("txt_costofram"))).append(
				"~Total cost of ewes and rams").append(correctNull((String )hshValues.get("txt_costofeweram"))).append(
				"~Area of Cultivation = ").append(correctNull((String )hshValues.get("txt_cultivationacre"))).append(
				"~Cost of cultivation per acre = ").append(correctNull((String )hshValues.get("txt_cultivationcstperacre"))).append(
				"~Total cost of cultivation = ").append(correctNull((String )hshValues.get("txt_costofcultivation"))).append(
				"~Adult feed per day= ").append(correctNull((String )hshValues.get("txt_feedconcentrateadultkg"))).append(
				"~Lamb feed per day = ").append(correctNull((String )hshValues.get("txt_feedconcentratelamb"))).append(
				"~No of adults feed = ").append(correctNull((String )hshValues.get("txt_feednoofadults"))).append(
				"~No of lambs feed= ").append(correctNull((String )hshValues.get("txt_feednooflambs"))).append(
				"~Total quantity of feed= ").append(correctNull((String )hshValues.get("txt_totalquantitykg"))).append(
				"~Feed cost per kg = ").append(correctNull((String )hshValues.get("txt_amtoffeedperkg"))).append(
				"~Total cost of feed = ").append(correctNull((String )hshValues.get("txt_costoffeed"))).append(
		
				"~No of labours= ").append(correctNull((String)hshValues.get("txt_nooflabours"))).append(
				"~cost per labour = ").append(correctNull((String )hshValues.get("txt_amtperlabour"))).append(
				"~Cost of wage = ").append(correctNull((String )hshValues.get("txt_costofwage"))).append(
				"~Cost of vetenary per animal = ").append(correctNull((String )hshValues.get("txt_costofvetenaryperanimal"))).append(
				"~Cost of vetenary= ").append(correctNull((String )hshValues.get("txt_costofvetenary"))).append(
				"~Insurance premium percentage from cost of animal = ").append(correctNull((String )hshValues.get("txt_insurpremiumpercanim"))).append(
				"~Insurance premium percentage from cost of shed = ").append(correctNull((String )hshValues.get("txt_insurperccostofshed"))).append(
				"~Insurance premium = ").append(correctNull((String )hshValues.get("txt_costofinsurance"))).append(
				"~Cost of electricity per month= ").append(correctNull((String )hshValues.get("txt_electricitypermonth"))).append(
				"~Cost of electricity per year= ").append(correctNull((String )hshValues.get("txt_electricityperyear"))).append(
				"~Total B= ").append(correctNull((String )hshValues.get("txt_totalb"))).append(
				"~Bank Loan= ").append(correctNull((String )hshValues.get("txt_bankloan"))).append(		
				"~Total Cosfeed= ").append(correctNull((String )hshValues.get("txt_cstfeed")));
				
				//AuditTrial.auditLog(hshValues,"261",strAppno,sbAuditTrial.toString());	
				//-------------------------------------------End---------------------------
			}
			catch(Exception ce)
			{	//log.error("Exception in updateSheepRearingCostOfProject::"+ce);
				log.error("Exception in updateSheepRearingCostOfProject::"+ce);
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
					
				}
				catch(Exception cf)
				{	log.error(cf);
					throw new EJBException(LAlerts.DBEXCEPTION+"Error closing the connection "+cf.getMessage());
				}
			}
		
	  }
	
	

	 public HashMap getSheepHerdProjectionChart(HashMap hshValues) 
	 {

			HashMap hshRecord=new HashMap();
			String strAppNo=null;
			String schemetype = "";	
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);	
			try {
					strAppNo=correctNull((String)hshValues.get("appno"));
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strappno"));
					}
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strAppno"));
					}

					hshRecord=new AgrNurseryLoanBO().getSheepHerdProjChartByAppno(strAppNo,schemetype,strFacSNo);
				} catch (Exception e) {
				log.error("Error in getSheepHerdProjectionChart::"+e.toString());
				throw new EJBException("Error in getSheepHerdProjectionChart === "+e.toString());
			}
			return hshRecord;
		  
	 }
	
	 public void updateSheepHerdProjectionChart(HashMap hshValues) 
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;
			ArrayList arrValues=new ArrayList();
			String schemetype = correctNull((String)hshValues.get("schemetype"));
			String strAction=null;
			String strAppNo=null;
			String strYear1[]=null;
			String strYear2[]=null;
			String strYear3[]=null;
			String strYear4[]=null;
			String strYear5[]=null;
			String strYear6[]=null;
			
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
					String strSchemeType=correctNull((String)hshValues.get("schemetype"));
					schemetype=Helper.getfacilitySchemetype(strSchemeType);
					String strFacSNo=Helper.getfacilitySno(strSchemeType);
			
				
				strYear1= (String [])hshValues.get("txt_year1");//Year1
				strYear2= (String [])hshValues.get("txt_year2");//Year2
				strYear3= (String [])hshValues.get("txt_year3");//Year3
				strYear4 = (String [])hshValues.get("txt_year4");//Year4				
				strYear5= (String [])hshValues.get("txt_year5");//Year5
				strYear6= (String [])hshValues.get("txt_year6");//Year6
				
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_sheepherdprojchart_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_lambsproducedpercentage_delete");
				arrValues.add(strAppNo);
				arrValues.add(schemetype);
				arrValues.add(strFacSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(strAction.trim().equalsIgnoreCase("insert"))
				{
					hshQueryValues=new HashMap();
					for(int k=0;k<17;k++)
					{				
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							iUpdatesize++;
							hshQuery.put("strQueryId","agr_sheepherdprojchart_insert");
							
							arrValues.add(strAppNo);	//1
							arrValues.add(String.valueOf(k+1));//serial no 2

							arrValues.add(Helper.correctInt((String)strYear1[k]));//Year 1		//3
							arrValues.add(Helper.correctInt((String)strYear2[k]));//Year 2		//4	
							arrValues.add(Helper.correctInt((String)strYear3[k]));//Year 3		//5
							arrValues.add(Helper.correctInt((String)strYear4[k]));//Year 4		//6
							arrValues.add(Helper.correctInt((String)strYear5[k]));//Year 5		//7	
							arrValues.add(Helper.correctInt((String)strYear6[k]));//Year 6		//8	
							arrValues.add(strFacSNo);
							arrValues.add(schemetype);
							

							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(iUpdatesize));
							hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					hshQuery.put("strQueryId","agr_lambsproducedpercentage_insert");
					arrValues.add(strAppNo);//AppNo
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_adultpercent")));//2 No of lambs produced percentage
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mortalitypercent")));//3 No of lambs after mortality of percentage
					arrValues.add(strFacSNo);
					arrValues.add(schemetype);//4 For Scheme type
					hshQuery.put("arrValues",arrValues);		
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);	
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}

				hshQueryValues= new HashMap();
				StringBuilder strActionData = new StringBuilder();
				ArrayList arrAuditBatchData = new ArrayList();
				for(int i=0;i<17;i++)
				{	
						strActionData=new StringBuilder();
						
						strActionData.append(" ;~  Year1 =").
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
						append(Helper.correctDouble((String)hshValues.get("txt_adultpercent"))).
						append(Helper.correctDouble((String)hshValues.get("txt_mortalitypercent")));

						arrValues.add(strActionData.toString());
						arrAuditBatchData.add(strActionData);
				}
				if(arrAuditBatchData.size()>0)
				{
					AuditTrial.auditLogBatch(hshValues,"262",strAppNo,arrAuditBatchData);
				}
				
			} catch (Exception e) {
				log.error("Error in updateSheepHerdProjectionChart "+e.getMessage());
				throw new EJBException(LAlerts.EXCEPTION+"inside updateSheepHerdProjectionChart"+e.toString());
			}
			
		  }
	 
	 
	 
	 
	 
	 public HashMap getSheepIncome(HashMap hshValues) 
	 {

			HashMap hshRecord=new HashMap();
			String strAppNo=null;
			String schemetype = "";
			String strSchemeType=correctNull((String)hshValues.get("schemetype"));
			schemetype=Helper.getfacilitySchemetype(strSchemeType);
			String strFacSNo=Helper.getfacilitySno(strSchemeType);
			try {
					strAppNo=correctNull((String)hshValues.get("appno"));
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strappno"));
					}
					if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strAppno"));
					}
					hshRecord.put("arrIncome",new AgrNurseryLoanBO().getSheepIncomeByAppno(strAppNo,schemetype,strFacSNo));
					hshRecord.put("HshHerdPrjChart",new AgrNurseryLoanBO().getSheepHerdProjChartByAppno(strAppNo,schemetype,strFacSNo));

				} catch (Exception e) {
				log.error("Error in getSheepIncome::"+e.toString());
				throw new EJBException("Error in getSheepIncome === "+e.toString());
			}
			return hshRecord;
		  
	 }
	 
		public void updateSheepIncome(HashMap hshValues) 
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;
			ArrayList arrValues=new ArrayList();
			String strAction=null;
			String strAppNo=null;
			String strYear1[]=null;
			String strYear2[]=null;
			String strYear3[]=null;
			String strYear4[]=null;
			String strYear5[]=null;
			String strYear6[]=null;
			String strCost[]=null;
			String strAvgWt[]=null;
			String strRateperkg[]=null; 
			String schemetype1[]=null;
			String schemetype = correctNull((String)hshValues.get("schemetype"));
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
					String strSchemeType=correctNull((String)hshValues.get("schemetype"));
					schemetype=Helper.getfacilitySchemetype(strSchemeType);
					String strFacSNo=Helper.getfacilitySno(strSchemeType);
			
				strYear1= (String [])hshValues.get("txt_year1");//Year1
				strYear2= (String [])hshValues.get("txt_year2");//Year2
				strYear3= (String [])hshValues.get("txt_year3");//Year3
				strYear4 = (String [])hshValues.get("txt_year4");//Year4				
				strYear5= (String [])hshValues.get("txt_year5");//Year5
				strYear6= (String [])hshValues.get("txt_year6");//Year6
				strCost= (String [])hshValues.get("txt_cost");//Year6
				strAvgWt = (String [])hshValues.get("txt_avgwt");//Average Weight
				strRateperkg =(String [])hshValues.get("txt_rateperkg");//Rate per kg
				
				
				if(strAction.trim().equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					
					hshQuery.put("strQueryId","agr_sheepincome_delete");
					arrValues.add(strAppNo);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
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
					
					hshQuery.put("strQueryId","agr_sheepincome_delete");
					arrValues.add(strAppNo);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					for(int k=0;k<6;k++)
					{				
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							iUpdatesize++;
							hshQuery.put("strQueryId","agr_sheepincome_insert");
							
							arrValues.add(strAppNo);	//1
							arrValues.add(String.valueOf(k+1));//serial no 2
							if(k==0 ||k==1||k==2||k==3)
							{
								arrValues.add(Helper.correctDouble((String)strCost[k]));
								arrValues.add(Helper.correctDouble((String)strAvgWt[k]));
								arrValues.add(Helper.correctDouble((String)strRateperkg[k]));
							}
							else
							{
								arrValues.add("0.00"); //3
								arrValues.add("0.00");
								arrValues.add("0.00");
							}
							arrValues.add(Helper.correctDouble((String)strYear1[k]));//Year 1		//4
							arrValues.add(Helper.correctDouble((String)strYear2[k]));//Year 2		//5
							arrValues.add(Helper.correctDouble((String)strYear3[k]));//Year 3		//6
							arrValues.add(Helper.correctDouble((String)strYear4[k]));//Year 4		//7
							arrValues.add(Helper.correctDouble((String)strYear5[k]));//Year 5		//8	
							arrValues.add(Helper.correctDouble((String)strYear6[k]));//Year 6		//9	
							arrValues.add(strFacSNo);//10 
							arrValues.add(schemetype);//11
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(iUpdatesize));
							hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					//To insert Total
					hshQueryValues= new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_sheepincome_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add("7");//serial no 2
					arrValues.add("0");//cost 3
					arrValues.add("0");//Avg Weight
					arrValues.add("0");//Rate perkg
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot1")));//Year 1	   	4 	
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot2")));//Year 2  	5
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot3")));//Year 3		6
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot4")));//Year 4		7
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot5")));//Year 5		8
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tot6")));//Year 6		9
					arrValues.add(strFacSNo);//10 
					arrValues.add(schemetype);//11
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					
				
				}

				hshQueryValues= new HashMap();
				StringBuilder strActionData = new StringBuilder();
				ArrayList arrAuditBatchData = new ArrayList();
				for(int i=0;i<6;i++)
				{	
						strActionData=new StringBuilder();
						
						strActionData.append(" ;~  Year1 =").
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
						append(Helper.correctDouble(strYear6[i]));
						
						
	
						arrValues.add(strActionData.toString());
						arrAuditBatchData.add(strActionData);
				}
				if(arrAuditBatchData.size()>0)
				{
					AuditTrial.auditLogBatch(hshValues,"263",strAppNo,arrAuditBatchData);
				}
				
			} catch (Exception e) {
				log.error("Error in updateSheepIncome "+e.getMessage());
				throw new EJBException(LAlerts.EXCEPTION+"inside updateSheepIncome"+e.toString());
			}
			
			
		}
	 
	 
	 
		public  HashMap getSheepFinancialAnalysis(HashMap hshValues) 
		{
			
			HashMap hshRecord = new HashMap();
			
			String strAppNo=null;
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			
			HashMap hshCashFlow = new HashMap();
			try
			{
				strAppNo = Helper.correctNull((String)hshValues.get("appno"));
				hshCashFlow=new AgrFarmMachineryBO().calculateSheepFinancialAnalysis(strAppNo,Helper.correctNull((String)hshValues.get("strprdcode")),schemetype);
				hshRecord.put("arryRow",(ArrayList)hshCashFlow.get("arryRow"));	
				hshRecord.put("NetWorth",Helper.correctNull((String)hshCashFlow.get("NetWorth")));		
				hshRecord.put("df",Helper.correctNull((String)hshCashFlow.get("df")));		
			}
			catch(Exception ce)
			{
				log.error("Error in getSheepFinancialAnalysis ::" + ce.getMessage());
				throw new EJBException("Error in getSheepFinancialAnalysis "+ce.toString());
			}
			
			return hshRecord;
		}
	 
		/*
		 * @Author 	: 	Anees.H
		 * @Purpose : 	Financial Year Inclusion in Agriculture
		 * @Date    :	10/12/2013
		 * 
		 */
		public  HashMap getAgriFinancialYear(HashMap hshValues) 
		{
			HashMap hshRecord = new HashMap();
			String strAppNo=null;
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			ResultSet rs=null,rs1=null;
			String strQuery ="",strQuery1="";
			HashMap hshCashFlow = new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				strAppNo = Helper.correctNull((String)hshValues.get("appno"));
				strQuery= SQLParser.getSqlQuery("sel_agr_financialyears^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("fin_sno")));//0
					arrCol.add(Helper.correctNull((String)rs.getString("fin_fromdate")));//1
					arrCol.add(Helper.correctNull((String)rs.getString("fin_todate")));//2
					strQuery1= SQLParser.getSqlQuery("sel_agr_croppingpattern_finyr^"+strAppNo+"^"+Helper.correctNull((String)rs.getString("fin_sno")));
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						arrCol.add("Y");//3
					}
					else
					{
						arrCol.add("N");//3
					}
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);		
			}
			catch(Exception ce)
			{
				log.error("Error in getAgriFinancialYear ::" + ce.getMessage());
				throw new EJBException("Error in getAgriFinancialYear "+ce.toString());
			}
			
			return hshRecord;
		}
		public void updateAgriFinancialYear(HashMap hshValues) 
		{
			HashMap hshRecord = new HashMap();
			String strAppNo=null;
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			ResultSet rs=null;
			String strQuery ="";
			HashMap hshCashFlow = new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			String strhidAction = "";
			String strFromDate="",strToDate="",strhidSno="";
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			String strExp="$";
			try
			{
				strAppNo = Helper.correctNull((String)hshValues.get("appno"));
				strhidAction = Helper.correctNull((String)hshValues.get("hidAction"));
				strFromDate = Helper.correctNull((String)hshValues.get("txt_fromdate"));
				strToDate = Helper.correctNull((String)hshValues.get("txt_todate"));
				strhidSno = Helper.correctNull((String)hshValues.get("hid_sno"));
				
				if(strhidAction.equalsIgnoreCase("Insert"))
				{
					strQuery=SQLParser.getSqlQuery("sel_financialyr_range^"+strAppNo+"^"+strFromDate);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(rs.getInt(1)!=0)
						{
							strExp = strExp + " Financial Year already exist ";
							throw new Exception(strExp);
						}
					}
					
					strQuery=SQLParser.getSqlQuery("max_agr_financialyears^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strhidSno=Helper.correctInt((String)rs.getString("maxid"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "ins_agr_financialyears");
					arrValues.add(strAppNo);
					arrValues.add(strhidSno);
					arrValues.add(strFromDate);
					arrValues.add(strToDate);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				if(strhidAction.equalsIgnoreCase("update"))
				{
					strQuery=SQLParser.getSqlQuery("sel_financialyr_range^"+strAppNo+"^"+strFromDate);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(rs.getInt(1)!=0)
						{
							strExp = strExp + " Financial Year already exist ";
							throw new Exception(strExp);
						}
					}
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "upd_agr_financialyears");
					arrValues.add(strFromDate);
					arrValues.add(strToDate);
					arrValues.add(strAppNo);
					arrValues.add(strhidSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				if(strhidAction.equalsIgnoreCase("delete"))
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId", "del_agrcroppingpattern_finyr");
					arrValues.add(strAppNo);
					arrValues.add(strhidSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_agr_financialyears");
					arrValues.add(strAppNo);
					arrValues.add(strhidSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
			}
			catch(Exception ce)
			{
				throw new EJBException(ce.toString());
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
					cf.printStackTrace();
					throw new EJBException("Error closing the connection "+cf.getMessage());
							
				}
			}
		}
}