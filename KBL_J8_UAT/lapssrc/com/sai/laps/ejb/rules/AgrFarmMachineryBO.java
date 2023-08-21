package com.sai.laps.ejb.rules;

import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class AgrFarmMachineryBO{
	
	static Logger log=Logger.getLogger(AgrFarmMachineryBO.class);	

	
public HashMap getFarmMachineryDetByAppNo(String strAppNo,String strfacsno,String schemetype) throws Exception
{
	String strQuery=null;
	ResultSet rs=null;
	
	HashMap hshFarmMachDet= new HashMap();
	strQuery = SQLParser.getSqlQuery("agrfarmmachinery_select^"+strAppNo+"^"+strfacsno+"^"+schemetype);
	rs = DBUtils.executeQuery(strQuery);
	try{
	while(rs.next())
	{	 
		hshFarmMachDet.put("category",Helper.correctNull(rs.getString("AGR_FAM_CATEGORY")));  
		hshFarmMachDet.put("vehicleType",Helper.correctNull(rs.getString("agr_fam_vehicletype"))); 
		hshFarmMachDet.put("brandname",Helper.correctNull(rs.getString("agr_fam_brandname")));
		hshFarmMachDet.put("make",Helper.correctNull(rs.getString("agr_fam_make")));
		hshFarmMachDet.put("model",Helper.correctNull(rs.getString("agr_fam_model")));
		hshFarmMachDet.put("costoftractor",Helper.correctDouble(rs.getString("agr_fam_costoftractor")));
		hshFarmMachDet.put("costoftrailor",Helper.correctDouble(rs.getString("agr_fam_costoftrailor")));
		hshFarmMachDet.put("costofimpliment",Helper.correctDouble(rs.getString("agr_fam_costofimpliment")));
		hshFarmMachDet.put("totalcost",Helper.correctDouble(rs.getString("agr_fam_totalcost")));
		hshFarmMachDet.put("proformadate",Helper.correctNull(rs.getString("agr_fam_proformadate")));
		hshFarmMachDet.put("valuationdone",Helper.correctNull(rs.getString("agr_fam_valuationdone")));		
		hshFarmMachDet.put("dateofvaluation",Helper.correctNull(rs.getString("agr_fam_dateofvaluation"))); 
		hshFarmMachDet.put("nameofdealer",Helper.correctNull(rs.getString("agr_fam_nameofdealer")));
		hshFarmMachDet.put("dealersince",Helper.correctNull(rs.getString("agr_fam_dealersince")));
		hshFarmMachDet.put("address1",Helper.correctNull(rs.getString("agr_fam_address1")));
		hshFarmMachDet.put("address2",Helper.correctNull(rs.getString("agr_fam_address2")));
		hshFarmMachDet.put("district",Helper.correctNull(rs.getString("agr_fam_district")));
		hshFarmMachDet.put("authoriseddealer",Helper.correctNull(rs.getString("agr_fam_authoriseddealer")));
		hshFarmMachDet.put("dateofdelivery",Helper.correctNull(rs.getString("agr_fam_dateofdelivery")));
		hshFarmMachDet.put("city",Helper.correctNull(rs.getString("agr_fam_city")));
		hshFarmMachDet.put("state",Helper.correctNull(rs.getString("agr_fam_state")));
		hshFarmMachDet.put("pincode",Helper.correctNull(rs.getString("agr_fam_pincode")));
		hshFarmMachDet.put("comments",Helper.correctNull(rs.getString("AGR_FAM_COMMENTS")));
		hshFarmMachDet.put("others",Helper.correctNull(rs.getString("agr_fam_others")));
		hshFarmMachDet.put("othercost",Helper.correctNull(rs.getString("agr_fam_othercost")));		
		hshFarmMachDet.put("facsno",Helper.correctNull(rs.getString("AGR_FACSNO")));		
		hshFarmMachDet.put("schemetype",Helper.correctNull(rs.getString("AGR_SCHEMETYPE")));
		hshFarmMachDet.put("agr_fam_depriciation",Helper.correctNull(rs.getString("agr_fam_depriciation")));
	}
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getFarmMachineryDetByAppNo of AgrCorpAssessmentBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}	
	return hshFarmMachDet;
}
	public ArrayList getDSCRDataByAppno(String strAppNo)throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		try {
			strQuery = SQLParser.getSqlQuery("agr_dscrvalues_select^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrCol =new ArrayList();
			
				arrCol.add(Helper.correctNull(rs.getString("agr_dscrappno")));//0
				arrCol.add(Helper.correctNull(rs.getString("agr_dscrslno")));//1
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear1")));//2
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear2")));//3
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear3")));//4
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear4")));//5
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear5")));//6
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear6")));//7
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear7")));//8
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear8")));//9
				arrCol.add(Helper.correctNull(rs.getString("agr_dscryear9")));//10
				arrRow.add(arrCol);
				
			}
			
		} catch (Exception e) {
			log.info("Error in getDSCRDataByAppno of AgrFarmMachineryBO"+e.getMessage());
			throw new EJBException("Error in getDSCRDataByAppno "+e.toString());
		}
		finally
		{
			try {
				if(rs!=null)rs.close();
			} catch (Exception e) {
				log.info("Error in Closing Connection of AgrFarmMachineryBO"+e.getMessage());
				throw new EJBException("Error in Closing Connection of getDSCRDataByAppno "+e.toString());
			}
		}
		return arrRow;
	}

public HashMap getIncomeHireDetByAppNo(String strAppNo,String StrFacsno,String schemetype) throws Exception
{
	String strQuery=null;
	ResultSet rs=null;
	
	HashMap hshFarmMachDet= new HashMap();

	strQuery = SQLParser.getSqlQuery("agrincomehireserv_select^"+strAppNo+"^"+StrFacsno+"^"+schemetype);

	rs = DBUtils.executeQuery(strQuery);
	try{
	while(rs.next())
	{
		hshFarmMachDet.put("onfarm",Helper.correctNull(rs.getString("agr_ihs_onfarm")));  
		hshFarmMachDet.put("offfarm",Helper.correctNull(rs.getString("agr_ihs_offfarm"))); 
		hshFarmMachDet.put("hiringtrans",Helper.correctNull(rs.getString("agr_ihs_hiringtrans")));
		hshFarmMachDet.put("totalhrs",Helper.correctDouble(rs.getString("agr_ihs_totalhrs")));
		hshFarmMachDet.put("incmcustom",Helper.correctDouble(rs.getString("agr_ihs_incmcustom")));
		hshFarmMachDet.put("totincmcustom",Helper.correctDouble(rs.getString("agr_ihs_totincmcustom")));
		hshFarmMachDet.put("lessoperation",Helper.correctDouble(rs.getString("agr_ihs_lessoperation")));
		hshFarmMachDet.put("nooflitres",Helper.correctDouble(rs.getString("agr_ihs_nooflitres")));
		hshFarmMachDet.put("amtperlitre",Helper.correctDouble(rs.getString("agr_ihs_amtperlitre")));
		hshFarmMachDet.put("fuelhrs",Helper.correctNull(rs.getString("agr_ihs_fuelhrs")));
		hshFarmMachDet.put("fuellub",Helper.correctDouble(rs.getString("agr_ihs_fuellub")));
   		hshFarmMachDet.put("fuelcost",Helper.correctDouble(rs.getString("agr_ihs_fuelcost"))); 
		hshFarmMachDet.put("driversalmon",Helper.correctDouble(rs.getString("agr_ihs_driversalmon")));
		hshFarmMachDet.put("driversalyr",Helper.correctDouble(rs.getString("agr_ihs_driversalyr")));
		hshFarmMachDet.put("insuretax",Helper.correctDouble(rs.getString("agr_ihs_insuretax")));
		hshFarmMachDet.put("repairmaintain",Helper.correctDouble(rs.getString("agr_ihs_repairmaintain")));
		hshFarmMachDet.put("totdeduct",Helper.correctDouble(rs.getString("agr_ihs_totdeduc")));
		hshFarmMachDet.put("netincome",Helper.correctDouble(rs.getString("agr_ihs_netincome")));
		hshFarmMachDet.put("agrschemetype",Helper.correctDouble(rs.getString("AGR_SCHEMETYPE")));
		hshFarmMachDet.put("agr_ihs_ownfarm",Helper.correctDouble(rs.getString("agr_ihs_ownfarm")));
		hshFarmMachDet.put("agr_ihs_familyfarm",Helper.correctDouble(rs.getString("agr_ihs_familyfarm")));
		hshFarmMachDet.put("agr_ihs_othrexp",Helper.correctDouble(rs.getString("agr_ihs_otrexp")));
		hshFarmMachDet.put("agr_extentofland",Helper.correctDouble(rs.getString("agr_extentofland")));
		hshFarmMachDet.put("facsno",Helper.correctDouble(rs.getString("AGR_FACSNO")));	
		hshFarmMachDet.put("schemetype",Helper.correctDouble(rs.getString("agr_schemetype")));	
	}
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getIncomeHireDetByAppNo of AgrCorpAssessmentBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return hshFarmMachDet;
}
public HashMap getFarmCashFlowByAppNo(String strAppNo) throws Exception
{
	
	ResultSet rs=null;
	ArrayList arrRow = null;
	ArrayList arrData= new ArrayList();
	HashMap hshCashFlow = new HashMap();
	String strQuery=null;
	int j=9;
	try{
		strQuery = SQLParser.getSqlQuery("sel_cashflow^"+strAppNo);
		rs = DBUtils.executeQuery(strQuery);
		
		while(rs.next())
		{
			arrRow = new ArrayList();		
			
			arrRow.add(Helper.correctNull(rs.getString("agr_cfl_appno")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_loanatbegin")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_surplusamt")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_principal")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_interest")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_total")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_afterrepayment")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_outstdamt")));	
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_prdtype")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_repaymonth")));
			arrRow.add(Helper.correctNull(rs.getString("agr_cfl_noofinstall")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_installtype")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_installamt")));
			arrRow.add(Helper.correctDouble(rs.getString("agr_cfl_lastinstall")));
			arrData.add(arrRow);	
			hshCashFlow.put("repaymonth", Helper.correctDouble(rs.getString("agr_cfl_repaymonth")));
			hshCashFlow.put("noofinstallment", Helper.correctDouble(rs.getString("agr_cfl_noofinstall")));
			hshCashFlow.put("installtype", Helper.correctDouble(rs.getString("agr_cfl_installtype")));
			hshCashFlow.put("installamt", Helper.correctDouble(rs.getString("agr_cfl_installamt")));
			hshCashFlow.put("lastinstall", Helper.correctDouble(rs.getString("agr_cfl_lastinstall")));
			j--;
		}
		for(int i=0; i<j; i++)
		{
			arrRow = new ArrayList();
			arrRow.add("");
			
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrRow.add("");
			arrData.add(arrRow);
		}
		arrData.add(arrRow);
		hshCashFlow.put("arrData", arrData);
		
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getFarmCashFlowByAppNo of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return hshCashFlow;
}
public String getCropingPatternNetIncome(String strAppNo) throws Exception
{
	String strNetIncome="";
	ResultSet rs=null;
	String strQuery=null;
	try{
		strQuery = SQLParser.getSqlQuery("agr_selcroppingpatternnetinc^"+strAppNo);
		rs = DBUtils.executeQuery(strQuery);
		
		if(rs.next())
		{
			strNetIncome= Helper.correctDouble(rs.getString("totnetincyear"));
		}
		
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getCropingPatternNetIncome of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	return strNetIncome;
}

public HashMap getCroppingPattenByAppno(String strAppNo, String strType,String strCropexipropTYpe)throws Exception
{
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	ResultSet rs=null;
	ResultSet rs1=null;
	ArrayList arryCol = null;
	ArrayList arrData= new ArrayList();
	ArrayList arrValues= new ArrayList();
	HashMap hshCropPattern =new HashMap();
	HashMap hshQuery =new HashMap();
	HashMap hshQueryFinal =new HashMap();
	String strCropName="";
	String strCropType="";
	String strSeasonName="";
	String strSeasonType="";
	String strAreaUnit="";
	String strYieldUnit="";
	String strSno="";
	double dblTotal=0.00;
	double dblTotalAmt=0.00;
	String strTotalAmt="";
	DecimalFormat dc = new DecimalFormat();
	dc.setGroupingUsed(false);
	dc.setMaximumFractionDigits(2);
	dc.setMinimumFractionDigits(2);
	String strfinYr=null;
	double dbl_exitot=0.00;
	double dbl_protot=0.00;
	double dbl_exialltot=0.00;
	double dbl_proalltot=0.00;
	
	
	try
	{
		rs=DBUtils.executeLAPSQuery("agr_selcroppingpattern^"+strAppNo+"^"+strType+"^"+strCropexipropTYpe);
		 
		while (rs.next())
		{

			arryCol=new ArrayList();
			
			
			strSeasonType=rs.getString("agr_crp_season");//0
			if(rs1 !=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"131"+'^'+strSeasonType);
			if(rs1.next())
			{
				strSeasonName=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
			arryCol.add(strSeasonName);//0
			strSeasonName="";
			arryCol.add(rs.getString("agr_crp_cropname"));//1
			arryCol.add(rs.getString("agr_crp_area"));//2		
			arryCol.add(rs.getString("agr_crp_yieldperacre"));//3
			arryCol.add(rs.getString("agr_crp_totalyield"));//4
			arryCol.add(rs.getString("agr_crp_priceperqtl"));//5
			arryCol.add(rs.getString("agr_crp_totalinc"));//6
			arryCol.add(rs.getString("agr_crp_costofcult"));//7
			arryCol.add(rs.getString("agr_crp_totcostofcult"));//8	
			arryCol.add(rs.getString("agr_crp_surplus"));//9
//			String strTotal=rs.getString("agr_crp_surplus");
//			dblTotal=Double.parseDouble(strTotal);
//			dblTotalAmt+=dblTotal;
//			strTotalAmt=dc.format(dblTotalAmt);
			arryCol.add(rs.getString("agr_crp_season"));//10
			arryCol.add(rs.getString("agr_crp_sno"));//11
			strCropType=rs.getString("agr_crp_cropname");
			if(rs1 !=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"130"+'^'+strCropType);
			if(rs1.next())
			{
				strCropName=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
			arryCol.add(strCropName);//12
			strfinYr=Helper.correctNull((String)rs.getString("agr_crp_finyr"));
		  	arryCol.add(strfinYr);//13 
		  	strSno=Helper.correctNull((String)rs.getString("agr_crp_areaunit"));
			
			if(rs1 !=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"135"+'^'+strSno);
			if(rs1.next())
			{
				strAreaUnit=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
		  	arryCol.add(strSno);//14 added by bhaskar
		  	strSno=Helper.correctNull((String)rs.getString("agr_crp_yieldunit"));
	
		  	if(rs1 !=null)
			{
				rs1.close();
			}
		  	rs1=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"136"+'^'+strSno);
			if(rs1.next())
			{
				strYieldUnit=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
			}
			arryCol.add(strSno);//15	added by bhaskar	  	
		  	
		  
		  	if(Helper.correctNull(strCropexipropTYpe).equalsIgnoreCase("1"))
		  	{
		  		
		  		//rs1=DBUtils.executeLAPSQuery("sel_exiproagr_croppingpattern^"+strAppNo+'^'+strexiprotype);
		  		dbl_exitot=Double.parseDouble((String)rs.getString("agr_crp_surplus"));
		  		dbl_exialltot=dbl_exialltot+dbl_exitot;
		  		
		  	}
		  	else if(Helper.correctNull(strCropexipropTYpe).equalsIgnoreCase("2"))
		  	{
		  		//rs1=DBUtils.executeLAPSQuery("sel_exiproagr_croppingpattern^"+strAppNo+'^'+strexiprotype);
		  		
		  		dbl_protot=Double.parseDouble((String)rs.getString("agr_crp_surplus"));
		  		dbl_proalltot=dbl_proalltot+dbl_protot;
		  		
		  	}
		  
			arryCol.add(strAreaUnit);
			arryCol.add(strYieldUnit);
			strCropName="";
			arrData.add(arryCol);
		}
		
		if(rs!=null)
			rs.close();
		
		/** Added by Vinoth Kumar for calculate exiting total and proposed total */
		
		if(strCropexipropTYpe.equalsIgnoreCase("1"))
		{
			strCropexipropTYpe="2";
		}
		else if(strCropexipropTYpe.equalsIgnoreCase("2"))
		{
			strCropexipropTYpe="1";
		}		
		
		rs=DBUtils.executeLAPSQuery("agr_selcroppingpattern^"+strAppNo+"^"+strType+"^"+strCropexipropTYpe);		 
		while (rs.next())
		{
			if(Helper.correctNull(strCropexipropTYpe).equalsIgnoreCase("1"))
			{		  				  		
				dbl_exitot=Double.parseDouble((String)rs.getString("agr_crp_surplus"));
				dbl_exialltot=dbl_exialltot+dbl_exitot;			  		
			}
			else if(Helper.correctNull(strCropexipropTYpe).equalsIgnoreCase("2"))
			{		  			  	
				dbl_protot=Double.parseDouble((String)rs.getString("agr_crp_surplus"));
				dbl_proalltot=dbl_proalltot+dbl_protot;			  		
			}
		}
		dblTotalAmt = dbl_exialltot + dbl_proalltot;				
		
		// End Here...
		
		hshCropPattern.put("total",jtn.format(dblTotalAmt));
		hshCropPattern.put("arrData",arrData);
		hshCropPattern.put("Exis_Tootal",dc.format(dbl_exialltot));
		hshCropPattern.put("prop_Tootal",dc.format(dbl_proalltot));
		
		arrValues= new ArrayList();
		hshQuery =new HashMap();
		hshQueryFinal =new HashMap();
		hshQueryFinal.put("size", "1");
		hshQuery.put("strQueryId","updcroppattern");
		arrValues.add(strTotalAmt);
		arrValues.add(strAppNo);
		hshQuery.put("arrValues",arrValues);
		hshQueryFinal.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryFinal,"updateData");
		
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getCroppingPattenByAppno of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return hshCropPattern;
}
public HashMap getFarmMachineryTotalCostByAppNo(String strAppNo,String StrFacsno,String schemetype)throws Exception
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	try {
		rs=DBUtils.executeLAPSQuery("agrfarmmachinery_pdf_select^"+strAppNo+"^"+StrFacsno+"^"+schemetype);
		if(rs.next())
		{
			hshRecord.put("costoftractor",Helper.correctDouble(rs.getString("agr_fam_costoftractor")));
			hshRecord.put("costoftrailor",Helper.correctDouble(rs.getString("agr_fam_costoftrailor")));
			hshRecord.put("costofimpliment",Helper.correctDouble(rs.getString("agr_fam_costofimpliment")));
			hshRecord.put("totalcost",Helper.correctDouble(rs.getString("agr_fam_totalcost")));
			hshRecord.put("othercost",Helper.correctDouble(rs.getString("agr_fam_othercost")));
			hshRecord.put("others",Helper.correctDouble(rs.getString("agr_fam_others")));
		}
		
	} catch (Exception e) {
		log.info("Error in getDSCRDataByAppno of AgrFarmMachineryBO"+e.getMessage());
		throw new EJBException("Error in getDSCRDataByAppno "+e.toString());
	}
	finally
	{
		try {
			if(rs!=null)rs.close();
		} catch (Exception e) {
			log.info("Error in Closing Connection of AgrFarmMachineryBO"+e.getMessage());
			throw new EJBException("Error in Closing Connection of getFarmMachineryTotalCostByAppNo "+e.toString());
		}
	}
	return hshRecord;
	
}

public HashMap getLimitsDataByPrdCode(String strPrdCode)throws Exception
{
	HashMap	 hshRecord = new HashMap();
	String strQuery=null;
	ResultSet rs=null;
	try{
		strQuery=SQLParser.getSqlQuery("set_perprdagriproperties_select^" + strPrdCode);
		rs = DBUtils.executeQuery(strQuery);
	   	if(rs.next()) 
	   	{
	   		hshRecord.put("lubricants",Helper.correctNull(rs.getString("sa_lubricants")));
	   		hshRecord.put("repairs",Helper.correctNull(rs.getString("sa_repairs")));
	   	}
	if(rs!=null){rs.close();}
	
	}catch(Exception e)
	{
		LogWriter.log("Error in getLimitsDataByHashValues of AgrFarmMachineryBO::" +e.getMessage());
		throw new EJBException("Error in Closing Connection of getLimitsDataByHashValues "+e.toString());
	}
	
	return hshRecord ;
}

public HashMap getSurplusDepreciationDetails(String strProductCode,String strAppNo)throws Exception
{
	ResultSet rs =null;
	HashMap hshDet=new HashMap();
	double dblNetincome=0.00;
	double dbldepriciationpercent=0.00;
	double dblProjectCost=0.00;
	double dblMargin=0.00;
	String proposedamount=null;
	try{
		
		if(strProductCode.equalsIgnoreCase(null)||strProductCode.equalsIgnoreCase("")){
			rs=DBUtils.executeLAPSQuery("getProductCode^"+strAppNo);
			if(rs.next())
			{
				strProductCode=Helper.correctNull((String)rs.getString("com_facid"));
				hshDet.put("strProductCode",strProductCode);
			}
		}
		rs=DBUtils.executeLAPSQuery("agr_croppingpattern_total_select^"+strAppNo+"^b");
		if(rs.next())
		{
			dblNetincome+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_crp_total")));
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("agr_minorirrigation_select^"+strAppNo);
		if(rs.next())
		{
			dblNetincome=dblNetincome+FwHelper.parseDouble((String)rs.getString("agr_waterproposedinc"))+
			FwHelper.parseDouble((String)rs.getString("agr_netamount"))+
			FwHelper.parseDouble((String)rs.getString("agr_exp_additional_income"))-
			FwHelper.parseDouble((String)rs.getString("agr_elecWorks"));
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("agrincomehireserv_netincome_select^"+strAppNo);
		if(rs.next())
		{
			dblNetincome+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_ihs_netincome")));
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("set_perprdagriproperties_depriciation_select^"+strProductCode);
		if(rs.next())
		{
			dbldepriciationpercent=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("sa_depriciation")));
		}

		if(rs!=null) rs.close();
		
		rs=DBUtils.executeLAPSQuery("getfacilityIntrate^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("interest",rs.getString("facility_interest"));
			proposedamount=Helper.correctDouble((String)rs.getString("facility_proposed"));
			hshDet.put("proposedamount",Helper.correctDouble((String)rs.getString("facility_proposed")));
			
			dblProjectCost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));	
			
		}
		if(rs!=null) rs.close();
		rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strAppNo+"^"+proposedamount+"^"+proposedamount);
		if(rs.next())
		{
			dblMargin=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("margin_perct")));
		}
		
		rs=DBUtils.executeLAPSQuery("repaymentIRR^"+strAppNo);
		if(rs.next())
		{		
			hshDet.put("pa_repayment_holiday",rs.getString("facility_mor"));
			hshDet.put("pa_instalment_type",rs.getString("facility_loanservised"));
		
		}
		if(rs!=null){rs.close();}
		
		rs=DBUtils.executeLAPSQuery("repaymentIRR^"+strAppNo);
		if(rs.next())
		{		
			hshDet.put("pa_repayment_holiday",rs.getString("facility_mor"));
			hshDet.put("pa_instalment_type",rs.getString("facility_loanservised"));
		
		}if(rs!=null){rs.close();}
		double dbldepriciationcost=dblProjectCost*(dbldepriciationpercent/100);
		dblProjectCost=dblProjectCost-(dblProjectCost*(dblMargin/100));
	
		double dblSurplus=dblNetincome - dbldepriciationcost;
		hshDet.put("dblSurplus",String.valueOf(dblSurplus));
		hshDet.put("dbldepriciationcost",String.valueOf(dbldepriciationcost));
		}catch(Exception e)
		{
			log.info("Exception in getSurplusDepreciationDetails::"+e.getMessage());
		}
		return hshDet;
}
public double getRepaymentPeriodByAppNo(String strAppNo)throws Exception
{
	double dblRepaymentPeriod=0.00;	
	
	try{
		String strQuery=null;
		ResultSet rs=null;
		
		strQuery = SQLParser.getSqlQuery("repaymentIRR^"+strAppNo);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{			
			dblRepaymentPeriod=FwHelper.parseDouble(rs.getString("facility_min"));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		log.info("Exception in getRepaymentPeriodByAppNo::"+e.getMessage());
	}
	return dblRepaymentPeriod;
}
public HashMap calculateRepaymentSchedule(String strAppNo,String strProductCode)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblProposedAmount=0.00;
	double dblBeginingAmt =0.00;
	double dblInterest=0.00;
	double dblSurplus=0.00;
	double dblEMIPrincipal=0.00;
	double dblEMIInterest=0.00;
	double dblEMI=0.00;
	double dblTotal=0.00;
	double dblRepaymentPeriod=0.00;
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;
	ResultSet rs=null;
	try{
		
		
		String strInstallType="";
		
		hshDet = new AgrFarmMachineryBO().getSurplusDepreciationDetails(strProductCode,strAppNo);
		dblProposedAmount=FwHelper.parseDouble((String)hshDet.get("proposedamount"));
		dblInterest=FwHelper.parseDouble((String)hshDet.get("interest"));
		dblSurplus=FwHelper.parseDouble((String)hshDet.get("dblSurplus"));
		dblBeginingAmt=dblProposedAmount;
		dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
		long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod));
		
		
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("getfacilityIntrate^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("dblInterest",rs.getString("facility_interest"));
		}
		if(rs!=null){rs.close();}
		
		rs=DBUtils.executeLAPSQuery("repaymentIRR^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("pa_repayment_holiday",rs.getString("facility_mor"));
			hshDet.put("pa_instalment_type",rs.getString("facility_loanservised"));
			
			 strInstallType=Helper.correctNull(rs.getString("facility_repaytype"));
				
				if (strInstallType.equalsIgnoreCase("q")) {
					lngRepaymentPeriod = Math.round(dblRepaymentPeriod /3);
					
				} else if (strInstallType.equalsIgnoreCase("h")) {
					lngRepaymentPeriod = Math.round(dblRepaymentPeriod / 6);
					
				}else{
					lngRepaymentPeriod = Math.round(dblRepaymentPeriod / 12);
				}
		}
		
		
		if(rs!=null){rs.close();}
		
		
		dblEMIPrincipal=dblBeginingAmt/lngRepaymentPeriod;
		for(int i=1;i<=lngRepaymentPeriod;i++)
		{
			arrCol = new ArrayList();
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt));//0
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus));//1
			
			if(strInstallType.equalsIgnoreCase("q"))
			{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100)/4;
			}else if(strInstallType.equalsIgnoreCase("h"))
			{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100)/2;
			}else{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100);
			}
			dblEMI=dblEMIPrincipal+dblEMIInterest;
			arrCol.add(""+Helper.formatDoubleValue(dblEMIPrincipal));//2
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//3
			arrCol.add(""+Helper.formatDoubleValue(dblEMI));//4
			
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus-dblEMI));//5
			if(dblBeginingAmt - dblEMIPrincipal < 0)
			{
				arrCol.add(""+Helper.formatDoubleValue(0.00));//6
			}
			else{
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt - dblEMIPrincipal));//6
			}
			dblBeginingAmt=dblBeginingAmt - dblEMIPrincipal;
			arrRow.add(arrCol);
			dblTotal+=dblEMI;
		}
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
		hshDet.put("dblSurplus",""+dblSurplus);
		hshDet.put("lngRepaymentPeriod",""+lngRepaymentPeriod);
		
		
	}catch(Exception e)
	{
		log.info("Exception in calculateRepaymentSchedule::"+e.getMessage());
	}
	return hshDet;
}

public HashMap calculateIRR(String strAppNo,String strProductCode)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblTotNPV=0.00;
	double dblDF=0.00;
	double dblDF1=0.00;double dblDFNxt=0.00;double dblNPV1=0.00; double dblNPV2=0.00;double dblIRR=0.00;
	ArrayList arrRow = null;
	ArrayList arrDet= new ArrayList();
	ArrayList arrCol= new ArrayList();
	ArrayList arrTmp= null;
	ArrayList arrIRR=new ArrayList();
	ArrayList arrDF = null;
	ArrayList arrNPV=new ArrayList();
	HashMap hshDF=new HashMap();
	ArrayList arrTotNPV=new ArrayList();
	ResultSet rs=null;
	String strAppStatus="";
	try{
		
		hshDet=calculateRepaymentSchedule(strAppNo,strProductCode);
		arrDet=(ArrayList)hshDet.get("arryRow");
		if(arrDet!=null && arrDet.size()>0)
		{
			for(int i=0;i<arrDet.size();i++)
			{
				arrRow=(ArrayList)arrDet.get(i);
				arrCol.add(arrRow.get(5));		
			}
			if(arrCol.size()<8)
			{
				while(arrCol.size()<8)
					{
						arrCol.add("0.00");
					}
			}
			
		}
		arrRow=null;
		arrIRR.add(arrCol);
		arrTmp=(ArrayList)arrCol.clone();
		arrCol.add(0,"Cash Flow");	
		
		rs=DBUtils.executeLAPSQuery("sel_appstatus^"+strAppNo);
		if(rs.next()) 
  		{
			strAppStatus=FwHelper.correctNull(rs.getString("APP_STATUS"));
  		}
		if(rs!=null){rs.close();}
		if(strAppStatus.equalsIgnoreCase("pa"))
		{
			arrDF=new AgrNurseryLoanBO().getHortiDFByAppNo(strAppNo);
		}else{
			arrDF=new AgrNurseryLoanBO().getHortiDF(); 
		}
		
		arrDF=new AgrNurseryLoanBO().getHortiDF(); 
		if(arrDF!=null && arrDF.size()>0)
		{
			for(int i=0;i<arrDF.size();i++)
			{
				arrRow=(ArrayList)arrDF.get(i);
				dblDF=FwHelper.parseDouble((String)arrRow.get(1));
				arrRow.remove(0);
				arrRow.remove(0);
	
				arrNPV=new AgrNurseryLoanBO().multiplyDFWithList(arrRow,arrTmp);
				
						
				arrIRR.add(arrRow);
				arrRow.add(0,"DF @"+" "+dblDF+"%");		
				dblTotNPV=addArrayListItems(arrNPV);
				hshDF.put(""+dblTotNPV,""+dblDF);
				arrTotNPV.add(""+dblTotNPV);
				arrNPV.add(""+dblTotNPV);
				arrNPV.add(0,"PV @ "+""+dblDF+"%");
				arrIRR.add(arrNPV);
				
			}
		}
		
		if(arrTotNPV!=null && arrTotNPV.size()>0 )
		{
			for(int i=0;i<arrTotNPV.size();i++)
			{
				double dblDFDet=FwHelper.parseDouble((String)arrTotNPV.get(i));
				
				if(dblDFDet<0)
				{
					dblDFNxt=FwHelper.parseDouble((String)hshDF.get(""+dblDFDet));
					dblNPV2=dblDFDet;
					if(i!=0)
					{
					dblNPV1=FwHelper.parseDouble((String)arrTotNPV.get(i-1));
					}else{
						dblNPV1=0.00;
					}
					dblDF1=FwHelper.parseDouble((String)hshDF.get(""+dblNPV1));
					break;
				}
			}
			
			dblIRR=new AgrNurseryLoanBO().calculateIRR(dblDF1,dblDFNxt,dblNPV1,dblNPV2);
		}
		hshDet.put("dblIRR",""+dblIRR);
		hshDet.put("arryRow",arrIRR);
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in calculateIRR::"+e.getMessage());
	}
	return hshDet;
}
public double addArrayListItems(ArrayList arrRow) throws Exception
{
	double dblTot=0.00;
	
	try {

		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0;i<arrRow.size();i++)
			{				
					dblTot+=FwHelper.parseDouble((String)arrRow.get(i));					
			}
		}
		
		
	} catch (Exception e) {
		LogWriter.log("Error in addArrayListItems::" +e.getMessage());
		throw new EJBException("Error in addArrayListItems"+e.toString());
		
	}
	
	
	return dblTot;
}
public HashMap calculateFisheryRepaymentSchedule(String strAppNo)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblProposedAmount=0.00;
	double dblBeginingAmt =0.00;
	double dblInterest=0.00;
	double dblSurplus=0.00;
	double dblEMIPrincipal=0.00;
	double dblEMIInterest=0.00;
	double dblEMI=0.00;
	double dblTotal=0.00;
	double dblRepaymentPeriod=0.00;

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;

	ResultSet rs=null;
	HashMap hshSurplus=null;
	try{
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("view_per_document_details_select^"+strAppNo);
		if(rs.next())
		{
			dblInterest=FwHelper.parseDouble(rs.getString("pa_loan_modintrate"));
			dblProposedAmount=FwHelper.parseDouble(rs.getString("pa_proposed_amount"));
		}
		if(rs!=null){rs.close();}
		
		hshSurplus=new AgrCropAssessmentBO().getFisherySurplusByAppNo(strAppNo);
		dblSurplus=FwHelper.parseDouble((String)hshSurplus.get("agr_netsurpdepr"));
	
		dblBeginingAmt=dblProposedAmount;
		dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
		long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod/12));
		dblEMIPrincipal=dblBeginingAmt/lngRepaymentPeriod;

		for(int i=1;i<=lngRepaymentPeriod;i++)
		{
			arrCol = new ArrayList();
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt));//0
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus));//1
			
			dblEMIInterest=dblBeginingAmt * (dblInterest/100);
			dblEMI=dblEMIPrincipal+dblEMIInterest;
			arrCol.add(""+Helper.formatDoubleValue(dblEMIPrincipal));//2
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//3
			arrCol.add(""+Helper.formatDoubleValue(dblEMI));//4
			
			arrCol.add(""+Helper.formatDoubleValue(dblEMI - dblSurplus));//5
			if(dblBeginingAmt - dblEMIPrincipal < 0)
			{
				arrCol.add(""+Helper.formatDoubleValue(0.00));//6
			}
			else{
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt - dblEMIPrincipal));//6
			}
			dblBeginingAmt=dblBeginingAmt - dblEMIPrincipal;
			arrRow.add(arrCol);
			dblTotal+=dblEMI;
			hshDet.put("lngRepaymentPeriod",""+lngRepaymentPeriod);
		}
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
	
		
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in calculateFisheryRepaymentSchedule::"+e.getMessage());
	}
	return hshDet;
}



public HashMap calculateSheepRepaymentSchedule(String strAppNo,String strProductCode,String schemetype)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblProposedAmount=0.00;
	double dblBeginingAmt =0.00;
	double dblInterest=0.00;
	double dblSurplus=0.00;
	double dblEMIPrincipal=0.00;
	double dblEMIInterest=0.00;
	double dblEMI=0.00;
	double dblTotal=0.00;
	double dblExpenditure=0.00;
	
	
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;
	ArrayList arrIncomeTot=null;
	try{
		hshDet = new AgrFarmMachineryBO().getSurplusDepreciationDetails(strProductCode,strAppNo);
		arrIncomeTot = new AgrFarmMachineryBO().getSheepIncomeTotByAppno(strAppNo,schemetype);
		dblExpenditure=new AgrFarmMachineryBO().getSheepRecurringExp(strAppNo,schemetype);
		dblProposedAmount=FwHelper.parseDouble((String)hshDet.get("proposedamount"));
		dblInterest=FwHelper.parseDouble((String)hshDet.get("interest"));
		dblSurplus=FwHelper.parseDouble((String)hshDet.get("dblSurplus"));
		dblBeginingAmt=dblProposedAmount;

		dblEMIPrincipal=dblBeginingAmt/6;

		for(int i=1;i<=6;i++)
		{
			arrCol = new ArrayList();
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt));//0
			dblSurplus=FwHelper.parseDouble((String)arrIncomeTot.get(i-1)) - dblExpenditure;
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus));//1
			
			dblEMIInterest=dblBeginingAmt * (dblInterest/100);
			dblEMI=dblEMIPrincipal+dblEMIInterest;
			arrCol.add(""+Helper.formatDoubleValue(dblEMIPrincipal));//2
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//3
			arrCol.add(""+Helper.formatDoubleValue(dblEMI));//4
			
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus -dblEMI));//5
			if(dblBeginingAmt - dblEMIPrincipal < 0)
			{
				arrCol.add(""+Helper.formatDoubleValue(0.00));//6
			}
			else{
			arrCol.add(""+Helper.formatDoubleValue(dblBeginingAmt - dblEMIPrincipal));//6
			}
			arrCol.add(""+Helper.formatDoubleValue(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))));//7
			arrCol.add(""+dblExpenditure);//8
			dblBeginingAmt=dblBeginingAmt - dblEMIPrincipal;
			arrRow.add(arrCol);
			dblTotal+=dblEMI;
		}
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
		hshDet.put("dblSurplus",""+dblSurplus);
		
		
		
	}catch(Exception e)
	{
		log.info("Exception in calculateSheepRepaymentSchedule::"+e.getMessage());
	}
	return hshDet;
}

public HashMap calculateHortiCashFlow(String strAppNo)throws Exception
{
	HashMap hshDet=new HashMap();
	ResultSet rs=null;

	double dblTotal=0.00;
	double dblRepaymentPeriod=0.00;
	dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
	ArrayList arryCol =null;
	
	/*if(dblRepaymentPeriod<12)
	{
		dblRepaymentPeriod=12;
	}*/
	long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod));
	AgrNurseryLoanBO agrnurseryloanBO=new AgrNurseryLoanBO();
	ArrayList arrRow = new ArrayList();

	try{
		
		ArrayList arrNetBenefit=agrnurseryloanBO.getHorticultureCostOfDevTotalAppno(strAppNo);
		ArrayList arrLoanBegininofyear=agrnurseryloanBO.getLoanOSBegning(strAppNo);
		
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("per_apploandetails_pdf_select^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("dblInterest",rs.getString("loan_modintrate"));
			hshDet.put("pa_repayment_holiday",rs.getString("loan_noofinstallment"));
			hshDet.put("pa_instalment_type",rs.getString("loan_periodicity"));
			hshDet.put("proposedamount",Helper.correctDouble((String)rs.getString("loan_recmdamt")));
			hshDet.put("pa_payment_holiday",Helper.correctDouble((String)rs.getString("loan_servised")));
		}
		String strInstallType=Helper.correctNull(rs.getString("loan_periodicity"));
		int holidayPeriod=0;
		holidayPeriod = FwHelper.parseInt(rs.getString("loan_noofinstallment"));
		
		if(Helper.correctNull((String)hshDet.get("pa_payment_holiday")).trim().equalsIgnoreCase("p"))
			lngRepaymentPeriod-=holidayPeriod;
		
		else if(Helper.correctNull((String)hshDet.get("pa_payment_holiday")).trim().equalsIgnoreCase("b"))
		{
			lngRepaymentPeriod-=holidayPeriod;
		} 
		else
		{
			lngRepaymentPeriod-=holidayPeriod;
		}
		
		if (strInstallType.equalsIgnoreCase("q")) {
			
			lngRepaymentPeriod = Math.round(lngRepaymentPeriod /3);
			holidayPeriod = Math.round(holidayPeriod / 3);
		} else if (strInstallType.equalsIgnoreCase("h")) {
			lngRepaymentPeriod = Math.round(lngRepaymentPeriod / 6);
			holidayPeriod = Math.round(holidayPeriod/ 6);
		}else if(strInstallType.equalsIgnoreCase("y")){
			lngRepaymentPeriod = Math.round(lngRepaymentPeriod / 12);
			holidayPeriod = Math.round(holidayPeriod / 12);
		}
		
		if(rs!=null){rs.close();}
		double dblOSBegin=0,dblGrossSurplus=0,dblInterest=0,dblprinciple=0;
		double dbltotaloutgoing=0,dblNetSurplus=0,dblOSEnd=0;
		dblprinciple=FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("proposedamount")))/lngRepaymentPeriod;
		if(arrLoanBegininofyear!=null && arrLoanBegininofyear.size()>0)
			 dblOSBegin=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(0))));
		if(holidayPeriod==0)
		{
			for(int i=0;i<lngRepaymentPeriod;i++)
			{
				arryCol=new ArrayList();	
				
				if(Math.round(dblOSBegin)<=0)
					break;
				
				if(i<arrNetBenefit.size())
				{
					dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(i))));
					if(dblGrossSurplus<0) dblGrossSurplus=0;
					dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
					
					
					dblprinciple=FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("proposedamount")))/lngRepaymentPeriod;
					dbltotaloutgoing=dblprinciple+dblInterest;
					dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
					if(dblNetSurplus<0) dblNetSurplus=0;
				}
				else
				{
					dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(14))));
					if(dblGrossSurplus<0) dblGrossSurplus=0;
					dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
					
					dbltotaloutgoing=dblprinciple+dblInterest;
					dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
					if(dblNetSurplus<0) dblNetSurplus=0;
						 
				}
				dblOSEnd=dblOSBegin-dblprinciple;
				arryCol.add(""+dblOSBegin);
				arryCol.add(""+dblGrossSurplus);
				arryCol.add(""+dblInterest);
				arryCol.add(""+dblprinciple);
				arryCol.add(""+dblInterest);
				arryCol.add(""+dbltotaloutgoing);
				arryCol.add(""+dblNetSurplus);
				arryCol.add(""+(dblOSEnd<0?0:dblOSEnd));
				arrRow.add(arryCol);
				
				dblOSBegin=dblOSEnd;
				if(dblprinciple>0)
				{
					
					if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==lngRepaymentPeriod-1)
						dblOSBegin=dblOSEnd;
					else if(i<arrLoanBegininofyear.size() && i<14)
					{
						if(i<lngRepaymentPeriod-1)
							dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i+1))));
						else
							dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i))));
						dblOSBegin-=dblprinciple;
				    }
					else
					{
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
						dblOSBegin-=dblprinciple;
					}
					

				}
				else
				{
					if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==lngRepaymentPeriod-1)
						dblOSBegin=dblOSEnd;
					else if(i<arrLoanBegininofyear.size()&& i<14)
					{
						if(i<lngRepaymentPeriod-1)
							dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i+1))));
						else
							dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i))));
				    }
					else
					{
						dblOSBegin=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
					}
					
				}
				dblTotal+=dbltotaloutgoing;	
				
			}
		}
		else
		{
		for(int i=0;i<holidayPeriod;i++)
		{
			arryCol=new ArrayList();	
			if(Math.round(dblOSBegin)<=0)
				break;
			if(i<arrNetBenefit.size())
			{
				dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(i))));
				if(dblGrossSurplus<0) dblGrossSurplus=0;
				dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
				
				if(Helper.correctNull((String)hshDet.get("pa_payment_holiday")).trim().equalsIgnoreCase("p"))
					dblprinciple=0;
				else if(Helper.correctNull((String)hshDet.get("pa_payment_holiday")).trim().equalsIgnoreCase("i"))
					dblInterest=0;
				else if(Helper.correctNull((String)hshDet.get("pa_payment_holiday")).trim().equalsIgnoreCase("b"))
				{
					dblInterest=0;
					dblprinciple=0;
				}
				else
				{
					dblprinciple=FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("proposedamount")))/lngRepaymentPeriod;
				}
				dbltotaloutgoing=dblprinciple+dblInterest;
				dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
				if(dblNetSurplus<0) dblNetSurplus=0;
			}
			else
			{
				dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(14))));
				if(dblGrossSurplus<0) dblGrossSurplus=0;
				dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
				
				dbltotaloutgoing=dblprinciple+dblInterest;
				dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
				if(dblNetSurplus<0) dblNetSurplus=0;
					 
			}
			dblOSEnd=dblOSBegin-dblprinciple;
			arryCol.add(""+dblOSBegin);
			arryCol.add(""+dblGrossSurplus);
			arryCol.add(""+dblInterest);
			arryCol.add(""+dblprinciple);
			arryCol.add(""+dblInterest);
			arryCol.add(""+dbltotaloutgoing);
			arryCol.add(""+dblNetSurplus);
			arryCol.add(""+(dblOSEnd<0?0:dblOSEnd));
			arrRow.add(arryCol);
			
			dblOSBegin=dblOSEnd;
			if(dblprinciple>0)
			{
				if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==holidayPeriod-1)
					dblOSBegin=dblOSEnd;
				else if(i<arrLoanBegininofyear.size()&& i<14)
				{
					if(i<lngRepaymentPeriod-1)
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i+1))));
					else
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i))));
					dblOSBegin-=dblprinciple;
				}
				else
				{
					dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
					dblOSBegin-=dblprinciple;
				}
				

			}
			else
			{
				if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==holidayPeriod-1)
					dblOSBegin=dblOSEnd;
				else if(i<arrLoanBegininofyear.size()&& i<14)
				{
					if(i<lngRepaymentPeriod-1)
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i+1))));
					else
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(i))));
			    }
				else
				{
					dblOSBegin=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
				}
				
			}
			dblTotal+=dbltotaloutgoing;	
			
		}
		int j=holidayPeriod;
		dblprinciple= FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("proposedamount")))/lngRepaymentPeriod;
		for(int i=1;i<=lngRepaymentPeriod;i++)
		{
			
			arryCol=new ArrayList();	
			if(Math.round(dblOSBegin)<=0)
				break;
			if(j<arrNetBenefit.size())
			{
				dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(j))));
				if(dblGrossSurplus<0) dblGrossSurplus=0;
				dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
				
				dbltotaloutgoing=dblprinciple+dblInterest;
				dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
				if(dblNetSurplus<0) dblNetSurplus=0;
			}
			else
			{
				dblGrossSurplus=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrNetBenefit.get(14))));
				if(dblGrossSurplus<0) dblGrossSurplus=0;
				dblInterest= Math.round(dblOSBegin*FwHelper.parseDouble(Helper.correctDouble((String)hshDet.get("dblInterest")))/100);
				
				dbltotaloutgoing=dblprinciple+dblInterest;
				dblNetSurplus=dblGrossSurplus-dbltotaloutgoing;
				if(dblNetSurplus<0) dblNetSurplus=0;
					 
			}
			dblOSEnd=dblOSBegin-dblprinciple;
			arryCol.add(""+dblOSBegin);
			arryCol.add(""+dblGrossSurplus);
			arryCol.add(""+dblInterest);
			arryCol.add(""+dblprinciple);
			arryCol.add(""+dblInterest);
			arryCol.add(""+dbltotaloutgoing);
			arryCol.add(""+dblNetSurplus);
			arryCol.add(""+(dblOSEnd<0?0:dblOSEnd));
			arrRow.add(arryCol);
			
			dblOSBegin=dblOSEnd;
			if(dblprinciple>0)
			{
				if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==lngRepaymentPeriod-1)
					dblOSBegin=dblOSEnd;
				if(j<arrLoanBegininofyear.size()-1)
				{
					if(j<lngRepaymentPeriod-1)
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(j+1))));
					else
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(j))));
					dblOSBegin-=dblprinciple;
			    }
				else
				{
					dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
					dblOSBegin-=dblprinciple;
				}
				

			}
			else
			{
				if(Math.round(dblOSEnd)<=Math.round(dblprinciple) || i==lngRepaymentPeriod-1)
					dblOSBegin=dblOSEnd;
				if(j<arrLoanBegininofyear.size()-1)
				{
					if(j<lngRepaymentPeriod-1)
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(j+1))));
					else
						dblOSBegin+=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(j))));
			    }
				else
				{
					dblOSBegin=Math.round(FwHelper.parseDouble(Helper.correctDouble((String)arrLoanBegininofyear.get(14))));
				}
				
			}
			dblTotal+=dbltotaloutgoing;	
			j++;
		}
		
		}
		
		
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
		hshDet.put("lngRepaymentPeriod",""+lngRepaymentPeriod);
		hshDet.put("holidayPeriod",""+holidayPeriod);
		
		
		
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in calculateHortiCashFlow::"+e.getMessage());
		throw new Exception("Error in calculateHortiCashFlow :: AgrFarmMachineryBO"+e.getMessage());
	}
	return hshDet;
}

public ArrayList getHorticultureNetBenefit(String strAppNo) 
{

	ArrayList arrCapitalRow=new ArrayList();
	ArrayList arrMaintenanceRow=new ArrayList();
	ArrayList arrTotalCost=new ArrayList();
	ArrayList arrIncome=new ArrayList();
	ArrayList arrNetBenefit=new ArrayList();

	
	try {
				arrCapitalRow=new AgrNurseryLoanBO().getHorticultureCostOfDevTotalAppno(strAppNo);
				arrMaintenanceRow=new AgrNurseryLoanBO().getHorticultureMaintenanceIncomeByAppno(strAppNo);
				arrMaintenanceRow=new AgrNurseryLoanBO().rearrangeArrayList(arrMaintenanceRow,strAppNo);
				arrIncome=new AgrNurseryLoanBO().getHorticultureGrossValueByAppno(strAppNo);
				arrIncome=new AgrNurseryLoanBO().rearrangeArrayList(arrIncome,strAppNo);
				arrTotalCost=new AgrNurseryLoanBO().addCapitalcostMaintenanceCost(arrCapitalRow, arrMaintenanceRow);
				arrNetBenefit=new AgrNurseryLoanBO().subNetIncomeCost(arrIncome, arrTotalCost);		

	} catch (Exception e) {
		log.info(e.toString());
		throw new EJBException("Error in getHorticultureNetBenefit === "+e.toString());
	}
	return arrNetBenefit;
}


public HashMap calculateSheepFinancialAnalysis(String strAppNo,String strProductCode,String schemetype)throws Exception
{
	HashMap hshDet=new HashMap();
	ResultSet rs =null;

	double dblExpenditure=0.00;
	double dblCapExp=0.00;
	double dblDF=0.00;double dblDFValue=0.00;double dblTotBenefit=0.00;double dblTotCost=0.00;
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;
	ArrayList arrIncomeTot=null;
	ArrayList arrDFDet=new ArrayList();
	ArrayList arrDF=new ArrayList();
	String strAppStatus="";
	String strSchemeType="";
	try{
		//strSchemeType=strProductCode+"-"+schemetype;
		arrIncomeTot = new AgrFarmMachineryBO().getSheepIncomeTotByAppno(strAppNo,schemetype);
		dblExpenditure=new AgrFarmMachineryBO().getSheepRecurringExp(strAppNo,schemetype);
		dblCapExp = new AgrFarmMachineryBO().getCapitalExp(strAppNo,schemetype);
		
		dblDF= new AgrFarmMachineryBO().getSheepDF(strAppNo,schemetype);
		rs=DBUtils.executeLAPSQuery("sel_prdriskruleid^"+strAppNo);
		if(rs.next()) 
  		{
			strAppStatus=FwHelper.correctNull(rs.getString("app_status"));
  		}
		if(strAppStatus.equalsIgnoreCase("A"))
		{
			arrDFDet=new AgrNurseryLoanBO().getHortiDFByAppNo(strAppNo);
			if(arrDFDet!=null && arrDFDet.size()>0)
			{
				arrDF=(ArrayList)arrDFDet.get(0);
				arrDF.remove(0);
				arrDF.remove(0);
			}
		}else{
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_horticulturedfbyperc_select^"+dblDF);
			if(rs.next())
			{
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year1")));
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year2")));
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year3")));
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year4")));
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year5")));
				arrDF.add(FwHelper.correctNull(rs.getString("agr_year6")));
			
			}
			if(rs!=null){rs.close();}
		}
				
		
		//The following ArrayList is to get the Net income values to farm budget page
		ArrayList arrFBcol = new ArrayList();
		arrFBcol = new ArrayList();
		
		for(int i=1;i<=6;i++)
		{
			arrCol = new ArrayList();
		
			arrCol.add(""+dblCapExp);//0
			arrCol.add(""+dblExpenditure);//1
			arrCol.add(""+(dblCapExp+dblExpenditure));//2
			arrCol.add(""+Helper.formatDoubleValue(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))));//3
			arrCol.add(""+(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))-(dblCapExp+dblExpenditure) ));//4
			arrFBcol.add(""+(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))-(dblCapExp+dblExpenditure)));//for Farm budget
			if(arrDF!=null && arrDF.size()>0)
			{
				dblDFValue=FwHelper.parseDouble((String)arrDF.get(i-1));
				arrCol.add(""+FwHelper.correctNull((String)arrDF.get(i-1)));//5
			}else{
				arrCol.add("0.000");//5
			}
			arrCol.add(""+(dblCapExp+dblExpenditure)* dblDFValue);//6
			arrCol.add(""+(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))* dblDFValue));//7
			dblTotBenefit+=(FwHelper.parseDouble((String)arrIncomeTot.get(i-1))* dblDFValue);
			dblTotCost+=(dblCapExp+dblExpenditure)* dblDFValue;
			arrRow.add(arrCol);
		}
		hshDet.put("arryRow", arrRow);
		hshDet.put("arrFBcol", arrFBcol);
		hshDet.put("NetWorth",""+(dblTotBenefit - dblTotCost));
		hshDet.put("df", ""+dblDF);


	}catch(Exception e)
	{
		log.info("Exception in calculateSheepFinancialAnalysis::"+e.getMessage());
	}
	return hshDet;
}

public ArrayList getSheepIncomeTotByAppno(String strAppNo,String schemetype) throws Exception
{
		String strQuery=null,strfacsno="";
		ResultSet rs=null;
		HashMap hshScheme = new HashMap();
		ArrayList arrData= new ArrayList();
		
	/*	if(hshScheme!=null)
		{
			hshScheme = Helper.splitScheme(schemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
		} */
		strQuery = SQLParser.getSqlQuery("sel_sheep_tot^"+strAppNo+"^"+"7"+"^"+schemetype);	
		rs = DBUtils.executeQuery(strQuery);
		try{
				
				if(rs.next())
				{				
					arrData.add(Helper.correctNull(rs.getString("totyr1")));//0
					arrData.add(Helper.correctNull(rs.getString("totyr2")));//1
					arrData.add(Helper.correctNull(rs.getString("totyr3")));//2
					arrData.add(Helper.correctNull(rs.getString("totyr4")));//3
					arrData.add(Helper.correctNull(rs.getString("totyr5")));//4
					arrData.add(Helper.correctNull(rs.getString("totyr6")));//5
				}
				else{
					arrData.add("0.00");
					arrData.add("0.00");
					arrData.add("0.00");
					arrData.add("0.00");
					arrData.add("0.00");
					arrData.add("0.00");
				}
				
				if(rs!=null){rs.close();}
			
		}
		catch(Exception e)
		{
			LogWriter.log("Error in getSheepIncomeTotByAppno of AgrNurseryLoanBO" +e.getMessage());
			if(rs!=null){rs.close();}
		}

		return arrData;
}

public double getFisherySurplus(String strAppNo)throws Exception
{
	double dblExp=0.00;	
	
	try{
		String strQuery=null;
		ResultSet rs=null;
		
		strQuery = SQLParser.getSqlQuery("agrfisherysurplus_select^"+strAppNo);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{			
			dblExp=FwHelper.parseDouble(rs.getString("agr_rec_totalb"));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		log.info("Exception in getSheepRecurringExp::"+e.getMessage());
	}
	return dblExp;
}

public double getSheepRecurringExp(String strAppNo,String schemetype)throws Exception
{
	double dblExp=0.00;	
	ResultSet rs=null;
	HashMap hshScheme=new HashMap();
	String strfacsno = "";
	
/*	if(hshScheme!=null)
	{
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
	}*/
	
	try{
		String strQuery=null;
		
		
		strQuery = SQLParser.getSqlQuery("agr_sheeprecurringexp_sel^"+strAppNo+"^"+schemetype);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{			
			dblExp=FwHelper.parseDouble(rs.getString("agr_rec_totalb"));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in getSheepRecurringExp::"+e.getMessage());
	}
	return dblExp;
}

public double getCapitalExp(String strAppNo,String schemetype)throws Exception
{
	double dblExp=0.00;	
	ResultSet rs=null;
	HashMap hshScheme=new HashMap();
	String strfacsno="";
	/*if(hshScheme!=null)
	{
		hshScheme = Helper.splitScheme(schemetype);
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
	}*/
	try{
		String strQuery=null;
		
		
		strQuery = SQLParser.getSqlQuery("agr_sheepfixedcosttotal_select^"+strAppNo+"^"+schemetype);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{			
			dblExp=FwHelper.parseDouble(rs.getString("agr_fxd_total"));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in getCapitalExp::"+e.getMessage());
	}
	return dblExp;
}
public double getSheepDF(String strAppNo,String schemetype)throws Exception
{
	double dblExp=0.00;	
	ResultSet rs=null;
	
	try{
		String strQuery=null;
		
		
		strQuery = SQLParser.getSqlQuery("agr_sheepdf_select^"+strAppNo+"^"+schemetype);	
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{			
			dblExp=FwHelper.parseDouble(rs.getString("agr_fxd_df"));
		}
		if(rs!=null){rs.close();}

	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in getSheepDF::"+e.getMessage());
	}
	return dblExp;
}
public HashMap calculateRepaymentScheduleForDSCR(String strAppNo,String strProductCode)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblProposedAmount=0.00;
	double dblBeginingAmt =0.00;
	double dblInterest=0.00;
	double dblSurplus=0.00;
	double dblEMIPrincipal=0.00;
	double dblEMIInterest=0.00;
	double dblEMI=0.00;
	double dblTotal=0.00;
	double A=0.00;
	double B=0.00;
	double dblRepaymentPeriod=0.00;
	double dblAvgDSCR=0.00;
	double dbltotalA=0.00;
	double dbltotalB=0.00;
	
	double dbltotSurplus=0.00;
	double dbltotDepr=0.00;
	double dbltotEMIInterest=0.00;
	double dbltotA=0.00;
	double dbltotEMI=0.00;
	
	double dbltotB=0.00;
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;
	ResultSet rs=null;
	String strInstallType="";
	try{
		hshDet = new AgrFarmMachineryBO().getSurplusDepreciationDetails(strProductCode,strAppNo);
		dblProposedAmount=FwHelper.parseDouble((String)hshDet.get("proposedamount"));
		dblInterest=FwHelper.parseDouble((String)hshDet.get("interest"));
		dblSurplus=FwHelper.parseDouble((String)hshDet.get("dblSurplus"));
		dblBeginingAmt=dblProposedAmount;
		dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
		long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod));
		
		if(rs!=null){rs.close();}
		
		rs=DBUtils.executeLAPSQuery("getloanterms^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("dblInterest",rs.getString("loan_modintrate"));
		}
		if(rs!=null){rs.close();}

		
		rs=DBUtils.executeLAPSQuery("repaymentIRR^"+strAppNo);
		if(rs.next())
		{
			hshDet.put("pa_repayment_holiday",rs.getString("facility_mor"));
			hshDet.put("pa_instalment_type",rs.getString("facility_loanservised"));
			
			 strInstallType=Helper.correctNull(rs.getString("facility_repaytype"));
			
			if (strInstallType.equalsIgnoreCase("q")) {
				lngRepaymentPeriod = Math.round(dblRepaymentPeriod /3);
				
			} else if (strInstallType.equalsIgnoreCase("h")) {
				lngRepaymentPeriod = Math.round(dblRepaymentPeriod / 6);
				
			}else{
				lngRepaymentPeriod = Math.round(dblRepaymentPeriod / 12);
			}
			
		}

		dblEMIPrincipal=dblBeginingAmt/lngRepaymentPeriod;

		for(int i=1;i<=lngRepaymentPeriod;i++)
		{
			arrCol = new ArrayList();
			
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus));//0	
			arrCol.add(""+FwHelper.parseDouble((String)hshDet.get("dbldepriciationcost")));//1
			if(strInstallType.equalsIgnoreCase("q"))
			{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100)/4;
			}else if(strInstallType.equalsIgnoreCase("h"))
			{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100)/2;
			}else{
				dblEMIInterest=dblBeginingAmt * (dblInterest/100);
			}
			dblEMI=dblEMIPrincipal+dblEMIInterest;	
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//2
			A= dblSurplus+FwHelper.parseDouble((String)hshDet.get("dbldepriciationcost"))+dblEMIInterest;
			B=dblEMIPrincipal+dblEMIInterest;
			arrCol.add(""+Helper.formatDoubleValue(A));//3
			arrCol.add(""+Helper.formatDoubleValue(dblEMIPrincipal));//4
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//5
			arrCol.add(""+Helper.formatDoubleValue(B));//6
			arrCol.add(""+Helper.formatDoubleValue(A/B));//7
			dblBeginingAmt=dblBeginingAmt - dblEMIPrincipal;
			dbltotalA+=A;
			dbltotalB+=B;
		
			arrRow.add(arrCol);
			dblTotal+=dblEMI;
			
			dbltotSurplus+=dblSurplus;
			dbltotDepr+=FwHelper.parseDouble((String)hshDet.get("dbldepriciationcost"));
			dbltotEMIInterest+=dblEMIInterest;
			dbltotA+=A;
			dbltotEMI+=dblEMIPrincipal;
			dbltotB+=B;
			
		}
		arrCol = new ArrayList();
		arrCol.add(""+dbltotSurplus);
		arrCol.add(""+dbltotDepr);
		arrCol.add(""+dbltotEMIInterest);
		arrCol.add(""+dbltotA);
		arrCol.add(""+dbltotEMI);
		arrCol.add(""+dbltotEMIInterest);
		arrCol.add(""+dbltotB);
		arrRow.add(arrCol);
		
		
		if(dbltotalB!=0)
			dblAvgDSCR=(dbltotalA/dbltotalB);
		else
			dblAvgDSCR=0;
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
		hshDet.put("dblAvgDSCR",""+dblAvgDSCR);	
		hshDet.put("dblSurplus",""+dblSurplus);
		hshDet.put("lngRepaymentPeriod",""+lngRepaymentPeriod);
		
		
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in calculateRepaymentScheduleForDSCR::"+e.getMessage());
	}
	return hshDet;
}

public HashMap calculateFisheryDSCR(String strAppNo)throws Exception
{
	HashMap hshDet=new HashMap();
	double dblProposedAmount=0.00;
	double dblBeginingAmt =0.00;
	double dblInterest=0.00;
	double dblSurplus=0.00;
	double dblEMIPrincipal=0.00;
	double dblEMIInterest=0.00;
	double dblEMI=0.00;
	double dblTotal=0.00;
	double A=0.00;
	double B=0.00;
	double dblRepaymentPeriod=0.00;
	double dblAvgDSCR=0.00;
	double dbltotalA=0.00;
	double dbltotalB=0.00;
	double dblDepr=0.00;

	
	double dbltotSurplus=0.00;
	double dbltotDepr=0.00;
	double dbltotEMIInterest=0.00;
	double dbltotA=0.00;
	double dbltotEMI=0.00;
	
	double dbltotB=0.00;
	HashMap hshSurplus=null;
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=null;
	ResultSet rs=null;
	
	try{
		
		if(rs!=null){rs.close();}
		rs=DBUtils.executeLAPSQuery("view_per_document_details_select^"+strAppNo);
		if(rs.next())
		{
			dblInterest=FwHelper.parseDouble(rs.getString("pa_loan_modintrate"));
			dblProposedAmount=FwHelper.parseDouble(rs.getString("pa_proposed_amount"));
		}
		if(rs!=null){rs.close();}
		
		hshSurplus=new AgrCropAssessmentBO().getFisherySurplusByAppNo(strAppNo);
		dblSurplus=FwHelper.parseDouble((String)hshSurplus.get("agr_netsurpdepr"));//AFTER DEPRECIATION
		dblDepr=FwHelper.parseDouble((String)hshSurplus.get("agr_deprequip"));
		dblBeginingAmt=dblProposedAmount;
		dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
		long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod/12));
		dblEMIPrincipal=dblBeginingAmt/lngRepaymentPeriod;

		for(int i=1;i<=lngRepaymentPeriod;i++)
		{
			arrCol = new ArrayList();
		
			arrCol.add(""+Helper.formatDoubleValue(dblSurplus));//0	
			arrCol.add(""+dblDepr);//1
			dblEMIInterest=dblBeginingAmt * (dblInterest/100);
			dblEMI=dblEMIPrincipal+dblEMIInterest;	
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//2
			A= dblSurplus+dblDepr+dblEMIInterest;
			B=dblEMIPrincipal+dblEMIInterest;
			arrCol.add(""+Helper.formatDoubleValue(A));//3
			arrCol.add(""+Helper.formatDoubleValue(dblEMIPrincipal));//4
			arrCol.add(""+Helper.formatDoubleValue(dblEMIInterest));//5
			arrCol.add(""+Helper.formatDoubleValue(B));//6
			arrCol.add(""+Helper.formatDoubleValue(A/B));//7
			dblBeginingAmt=dblBeginingAmt - dblEMIPrincipal;
			dbltotalA+=A;
			dbltotalB+=B;
			
			arrRow.add(arrCol);
			dblTotal+=dblEMI;
			
			dbltotSurplus+=dblSurplus;
			dbltotDepr+=dblDepr;
			dbltotEMIInterest+=dblEMIInterest;
			dbltotA+=A;
			dbltotEMI+=dblEMIPrincipal;
			dbltotB+=B;
		}
		arrCol = new ArrayList();
		arrCol.add(""+dbltotSurplus);
		arrCol.add(""+dbltotDepr);
		arrCol.add(""+dbltotEMIInterest);
		arrCol.add(""+dbltotA);
		arrCol.add(""+dbltotEMI);
		arrCol.add(""+dbltotEMIInterest);
		arrCol.add(""+dbltotB);
		arrRow.add(arrCol);
		
		dblAvgDSCR=(dbltotalA/dbltotalB);
		hshDet.put("arryRow", arrRow);
		hshDet.put("Total",""+dblTotal);
		hshDet.put("dblAvgDSCR",""+dblAvgDSCR);	
		hshDet.put("dblSurplus",""+dblSurplus);
		hshDet.put("lngRepaymentPeriod",""+lngRepaymentPeriod);
		
		
	}catch(Exception e)
	{
		if(rs!=null){rs.close();}
		log.info("Exception in calculateFisheryDSCR::"+e.getMessage());
	}
	return hshDet;
}

public HashMap convertRepaymentScheduleToColl(ArrayList arrDSCR,String strAppNo)throws Exception
{
	HashMap hshDet=new HashMap();
	
	double dblTotal=0.00;
	
	ArrayList arrRow = null;
	ArrayList arrFinColl = null;
	ArrayList arrFinRow = new ArrayList();
	ArrayList arrCol = null;
	ArrayList arrInterest=null;
	arrCol=(ArrayList)arrDSCR.get(0);
	int size=arrCol.size();

	try{
		double dblRepaymentPeriod=getRepaymentPeriodByAppNo(strAppNo);	
		long lngRepaymentPeriod=(Math.round(dblRepaymentPeriod/12));
		for(int i=0;i<size;i++)
		{
			
			arrFinColl=new ArrayList();	
			dblTotal=0.00;
			for(int j=0;j<lngRepaymentPeriod;j++)
			{
				arrRow=(ArrayList)arrDSCR.get(j);
				arrFinColl.add(Helper.correctNull((String)arrRow.get(i)));
				dblTotal+=FwHelper.parseDouble(FwHelper.correctNull((String)arrRow.get(i)));
			}	
			arrFinColl.add(""+dblTotal);
			arrFinRow.add(arrFinColl);
		}
		hshDet.put("arrFinRow", arrFinRow);
		hshDet.put("arrInterest", arrInterest);
		hshDet.put("Total",""+dblTotal);
		
	
	}catch(Exception e)
	{
		log.info("Exception in convertRepaymentScheduleToColl::"+e.getMessage());
	}
	return hshDet;
}


public double calculateRepaymentEMI(double dblLoanAmount, double dblInterestRate, double dblYears)throws Exception
{
	double dblDenomi=0.00;	
	double dblNumeri=0.00;
	double  dblEMI=0.00;
	double dblModIntRate=0.00;
	try{
		 dblModIntRate=dblInterestRate/(100);
		 dblDenomi=Math.pow(dblModIntRate+1,(dblYears))-1;	
		 dblNumeri=dblModIntRate*Math.pow(dblModIntRate+1,(dblYears));
	
		 if(dblNumeri!=0.0 && dblDenomi!=0.0)
		 {
			 dblEMI=(dblNumeri/dblDenomi)*dblLoanAmount;
		 }
	}catch(Exception e)
	{
		log.info("Exception in calculateRepaymentEMI::"+e.getMessage());
	}
	return dblEMI;
}

public ArrayList calculatePrincipalInterestFromEMI(double dblLoanAmount, double dblInterestRate, double dblEMI)throws Exception
{
	double dblInterest=0.00;	
	double dblPrincipal=0.00;
	ArrayList arrPrinInt =new ArrayList();
	try{
		
		dblInterest=dblLoanAmount*(dblInterestRate/(12*100));
		dblPrincipal=dblEMI-dblInterest;
		arrPrinInt.add(""+dblPrincipal);
		arrPrinInt.add(""+dblInterest);
		
	}catch(Exception e)
	{
		log.info("Exception in calculatePrincipalInterestFromEMI::"+e.getMessage());
	}
	return arrPrinInt;
}
public ArrayList getMilkFlowChartByAppno(String strAppNo)throws Exception
{

	ResultSet rs=null;
	ArrayList arryCol = null;
	ArrayList arrData= new ArrayList();
	try
	{
		rs=DBUtils.executeLAPSQuery("agr_milkchartdetailsrep_select^"+strAppNo);		 
		while (rs.next())
		{
			arryCol=new ArrayList();
			
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_il")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_id")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_iil")));				
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_iid")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_iiil")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_iiid")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_ivl")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_ivd")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_vl")));	
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_vd")));
			
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_vil")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_vid")));
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_viil")));	
			arryCol.add(FwHelper.correctNull(rs.getString("agr_mfc_viid")));
			arrData.add(arryCol);
		}
		
	if(rs!=null){rs.close();}
	}catch(Exception e)
	{
		LogWriter.log("Error in getMilkFlowChartByAppno of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return arrData;
}

public ArrayList getDairyDevInc(String strAppNo,String schemetype,String strFacSNo)throws Exception
{

	ArrayList arrIncomeTot =new ArrayList();
	ResultSet rs=null;
	try
	{
		rs=DBUtils.executeLAPSQuery("agr_dairyincomestatement_Total_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
		if(rs.next())
		{

			arrIncomeTot.add(rs.getString("agr_incstat_firstyear"));
			arrIncomeTot.add(rs.getString("agr_incstat_secondyear"));
			arrIncomeTot.add(rs.getString("agr_incstat_thirdyear"));
			arrIncomeTot.add(rs.getString("agr_incstat_fourthyear"));
			arrIncomeTot.add(rs.getString("agr_incstat_fifthyear"));
			arrIncomeTot.add(rs.getString("agr_incstat_sixthyear"));
	 		
		}else{
			arrIncomeTot.add("0.00");
			arrIncomeTot.add("0.00");
			arrIncomeTot.add("0.00");
			arrIncomeTot.add("0.00");
			arrIncomeTot.add("0.00");
			arrIncomeTot.add("0.00");
		}
		if(rs!=null){rs.close();}
		
	}catch(Exception e)
	{
		LogWriter.log("Error in getDairyDevInc of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return arrIncomeTot;
}
public ArrayList getDairyDevExp(String strAppNo,String schemetype,String strFacSNo)throws Exception
{

	ArrayList arrExpTot =new ArrayList();
	ResultSet rs=null;
	try
	{
		rs=DBUtils.executeLAPSQuery("agr_diaryrecurringexpenditure_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
		if(rs.next())
		{
			arrExpTot.add(rs.getString("agr_recexp_year1"));
			arrExpTot.add(rs.getString("agr_recexp_year2"));
			arrExpTot.add(rs.getString("agr_recexp_year3"));
			arrExpTot.add(rs.getString("agr_recexp_year4"));
			arrExpTot.add(rs.getString("agr_recexp_year5"));
			arrExpTot.add(rs.getString("agr_recexp_year6"));
	 		
		}else{
			arrExpTot.add("0.00");
			arrExpTot.add("0.00");
			arrExpTot.add("0.00");
			arrExpTot.add("0.00");
			arrExpTot.add("0.00");
			arrExpTot.add("0.00");
		}
		if(rs!=null){rs.close();}
		
	}catch(Exception e)
	{
		LogWriter.log("Error in getDairyDevExp of AgrFarmMachineryBO::" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	
	return arrExpTot;
}
}