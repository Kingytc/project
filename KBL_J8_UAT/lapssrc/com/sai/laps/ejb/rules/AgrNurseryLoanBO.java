package com.sai.laps.ejb.rules;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

public class AgrNurseryLoanBO{
	static Logger log=Logger.getLogger(AgrNurseryLoanBO.class);
	public ArrayList getNurseryScaleMasterData(String state_name,String district_name)throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		try {
			rs=DBUtils.executeLAPSQuery("agrscaleoffinancenursery_selectmaxunits^"+state_name+"^"+district_name);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.correctNull(rs.getString("agr_sfn_plant")));	//0
				arrCol.add(Helper.correctNull(rs.getString("agr_sfn_maxnoofunits")));//1
				arrCol.add(Helper.correctNull(rs.getString("agr_sfn_todate")));//2
				arrCol.add(state_name);//3
				arrCol.add(district_name);//4
				arrCol.add(district_name);//5
				arrCol.add(Helper.correctNull(rs.getString("agr_sfn_type")));//6
				arrRow.add(arrCol);	
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			log.error("Error in getNurseryScaleMasterData of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getNurseryScaleMasterData === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrRow;
		
	}
	
	public HashMap arriveParametersForBCR(ArrayList arrDF,ArrayList arrNB)throws Exception
	{
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrDFPerc=new ArrayList();
		ArrayList arrBCR=null;
		HashMap hshBCRParam=new HashMap();
		HashMap hshNXTBCRParam=new HashMap();
		double dblNPV1=0.00;
		double dblNPV2=0.00;
		double dblIRR=0.00;
		try {

			if(arrDF!=null && arrNB!=null && arrDF.size()>0 && arrNB.size()>0)
			{
				
				for(int i=0;i<arrDF.size();i++)
				{
					arrCol=new ArrayList();
					arrDFPerc=(ArrayList)arrDF.get(i);
					for(int j=0;j<arrNB.size();j++)
					{
						arrCol.add(""+FwHelper.parseDouble((String)arrDFPerc.get(j+2)) * FwHelper.parseDouble((String)arrNB.get(j)));
						
					}
					log.info("arrCol"+arrCol);
					arrBCR=calculateBCR(arrCol);
					log.info("arrBCR"+arrBCR);
					if(FwHelper.correctNull((String)arrBCR.get(0)).equalsIgnoreCase("recalculate"))
					{
						continue;
					}else{
						hshBCRParam.put("DFPERC", arrDFPerc.get(1));
						
						arrDFPerc.remove(0);
						arrDFPerc.remove(0);
						hshBCRParam.put("arrDFPerc", arrDFPerc);
						hshBCRParam.put("NBF", arrCol);
						hshBCRParam.put("arrBCR", arrBCR);
						if((i+1)<arrDF.size())
						{
							
							hshNXTBCRParam=arriveParametersForNextBCRSlab(arrDF,i+1,arrNB);
							hshBCRParam.put("DFNXT", hshNXTBCRParam.get("DFNXT"));	
							hshBCRParam.put("NBFNXT", hshNXTBCRParam.get("NBFNXT"));
							hshBCRParam.put("arrBCRNXT", hshNXTBCRParam.get("arrBCR"));
							hshBCRParam.put("arrDFNXT", hshNXTBCRParam.get("arrDFNXT"));
						}
						break;
					}
				}
				dblNPV1=FwHelper.parseDouble((String)arrBCR.get(1));
				
				if(hshNXTBCRParam.get("arrBCRNXT")!=null)
				{
					 dblNPV2=FwHelper.parseDouble((String)((ArrayList)hshNXTBCRParam.get("arrBCRNXT")).get(1));	
				}else{
					 dblNPV2=0.00;
				}

				
				dblIRR=calculateIRR(FwHelper.parseDouble((String)hshBCRParam.get("DFPERC")), FwHelper.parseDouble((String)hshBCRParam.get("DFNXT")), dblNPV1, dblNPV2);
				hshBCRParam.put("IRR", ""+dblIRR);
			}
			
		} catch (Exception e) {	
			log.error("Error in arriveParametersForBCR of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in arriveParametersForBCR === AgrNurseryLoanBO"+e.toString());
		}

		return hshBCRParam;
		
	}
	
	public HashMap arriveParametersForNextBCRSlab(ArrayList arrDF,int pos,ArrayList arrNB)throws Exception
	{
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrBCR=new ArrayList();
		HashMap hshBCRParam=new HashMap();
		ArrayList arrDFPerc=null;
		try {

			if(arrDF!=null && arrNB!=null && arrDF.size()>0 && arrNB.size()>0)
			{
				for(int i=pos;i<arrDF.size();i++)
				{
					arrCol=new ArrayList();
					arrDFPerc=(ArrayList)arrDF.get(i);
					log.info("arrDFPerc===="+arrDFPerc);
					log.info("arrDFPerc===="+arrNB);
				for(int j=0;j<arrNB.size();j++)
				{
					arrCol.add(""+FwHelper.parseDouble((String)arrDFPerc.get(j+2)) * FwHelper.parseDouble((String)arrNB.get(j)));				
				}	
				arrBCR=calculateNextBCR(arrCol);
				log.info("arrBCR===="+arrBCR);
				if(FwHelper.correctNull((String)arrBCR.get(0)).equalsIgnoreCase("recalculate"))
				{
					continue;
				}else{
					hshBCRParam.put("DFNXT", arrDFPerc.get(1));
					
					arrDFPerc.remove(0);
					arrDFPerc.remove(0);
					hshBCRParam.put("arrDFNXT", arrDFPerc);
					hshBCRParam.put("NBFNXT", arrCol);
					hshBCRParam.put("arrBCRNXT", arrBCR);
					break;
				}
			}
			}
			
		} catch (Exception e) {	
			log.error("Error in arriveParametersForNextBCRSlab of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in arriveParametersForNextBCRSlab === AgrNurseryLoanBO"+e.toString());
		}

		return hshBCRParam;
		
	}
	public ArrayList multiplyDFWithList(ArrayList arrDF,ArrayList arrNB)throws Exception
	{
		ArrayList arrDet = new ArrayList();
		try {
			if(arrDF!=null && arrNB!=null && arrDF.size()>0 && arrNB.size()>0)
			{
				for(int i=0;i<arrNB.size();i++)
				{
					arrDet.add(""+FwHelper.parseDouble((String)arrDF.get(i)) * FwHelper.parseDouble((String)arrNB.get(i)));				
				}	
				
			}
			
		} catch (Exception e) {	
			log.error("Error in multiplyDFWithList of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in multiplyDFWithList === AgrNurseryLoanBO"+e.toString());	
		}
		return arrDet;
		
	}
	
	public ArrayList calculateNextBCR(ArrayList arrDFNB)throws Exception
	{
	
		ArrayList arrBCR=new ArrayList();
		double dblNegativeSum=0.00;
		double dblPositiveSum=0.00;
		double dblNPV=0.00;
		double dblBCR=0.00;
		
		try {

			if(arrDFNB !=null && arrDFNB.size()>0 )
			{			
				for(int i=0;i<arrDFNB.size();i++)
				{				
					if(FwHelper.parseDouble((String)arrDFNB.get(i)) < 0)
					{
						dblNegativeSum+=FwHelper.parseDouble((String)arrDFNB.get(i));
					}else if(FwHelper.parseDouble((String)arrDFNB.get(i)) >=0)
					{
						dblPositiveSum+=FwHelper.parseDouble((String)arrDFNB.get(i));
					}					
				}
				dblNPV=dblNegativeSum+dblPositiveSum;
				dblBCR=dblPositiveSum/(-1 * dblNegativeSum);
				if(dblPositiveSum==0)
				{
					dblBCR=0.00;
				}
				
			}
			if(dblNPV>=0)
			{
				arrBCR.add("recalculate");
			}else{
				arrBCR.add("freeze");
			}
			arrBCR.add(""+dblNPV);
			arrBCR.add(""+dblBCR);
			
		} catch (Exception e) {		
			log.error("Error in calculateNextBCR of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in calculateNextBCR === AgrNurseryLoanBO"+e.toString());		
		}
		return arrBCR;		
	}
	
	public ArrayList calculateBCR(ArrayList arrDFNB)throws Exception
	{
	
		ArrayList arrBCR=new ArrayList();
		double dblNegativeSum=0.00;
		double dblPositiveSum=0.00;
		double dblNPV=0.00;
		double dblBCR=0.00;
		
		try {

			if(arrDFNB !=null && arrDFNB.size()>0 )
			{			
				for(int i=0;i<arrDFNB.size();i++)
				{				
					if(FwHelper.parseDouble((String)arrDFNB.get(i)) < 0)
					{
						dblNegativeSum+=FwHelper.parseDouble((String)arrDFNB.get(i));
					}else if(FwHelper.parseDouble((String)arrDFNB.get(i)) >=0)
					{
						dblPositiveSum+=FwHelper.parseDouble((String)arrDFNB.get(i));
					}					
				}
				dblNPV=dblNegativeSum+dblPositiveSum;
				dblBCR=dblPositiveSum/(-1 * dblNegativeSum);
				if(dblPositiveSum==0)
				{
					dblBCR=0.00;
				}
				
			}
			/*
			 * Always BCR is Greater Than  1.
			 * If its less than or equal to 1 Recalculate the BCR at Next DF value.
			 * If its greater  1 the BCR Value is Freeze.
			*/
			if(dblBCR<=1)
			{
				arrBCR.add("recalculate");
			}else{
				arrBCR.add("freeze");
			}
			arrBCR.add(""+dblNPV);
			arrBCR.add(""+dblBCR);
			
		} catch (Exception e) {		
			log.error("Error in CalculateBCR of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in CalculateBCR === AgrNurseryLoanBO"+e.toString());		
		}
		return arrBCR;		
	}
	
	public double calculateIRR(double dblDF,double dblDFNxt, double NPV1, double NPV2)throws Exception
	{
		double dblIRR=0.00;
		try {
			log.info("dblDF="+dblDF+"dblDFNxt="+dblDFNxt+"dblDF="+dblDF+"NPV1="+NPV1+"NPV2="+NPV2);
			if(NPV1==0)
			{
				dblIRR=0.00;
			}else{
			
			dblIRR = dblDF + (dblDFNxt - dblDF) * ( NPV1 / (NPV1 - NPV2));
			}
			
		} catch (Exception e) {
			
			log.error("Error in calculateIRR of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in calculateIRR === AgrNurseryLoanBO"+e.toString());
			
		}
		return dblIRR;
		
	}
	
	public ArrayList getHorticultureScaleMasterData(String strCrop)throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;

		try 
		{
			if(!strCrop.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("agrscaleoffinancehorticulture_selectmaxunits^"+strCrop);
				while(rs.next())
				{
					arrCol=new ArrayList();
					
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_plant")));	//0
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_maxnoofunits")));//1
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_uptodate")));//2
					
					arrCol.add(strCrop);//3
					arrRow.add(arrCol);	
				}
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("agr_scaleoffinancehorticulture_sel");
				while(rs.next())
				{
					arrCol=new ArrayList();
					
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_plant")));	//0
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_maxnoofunits")));//1
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_uptodate")));//2
					arrCol.add(strCrop);//3
					arrCol.add(Helper.correctNull(rs.getString("agr_sfh_sno")));	//4
					arrRow.add(arrCol);	
				}
			}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			log.error("Error in getHorticultureScaleMasterData of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHorticultureScaleMasterData === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrRow;
		
	}
	
	public ArrayList getCostOfRisingByAppno(String strAppNo) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		
		try {
			rs=DBUtils.executeLAPSQuery("agr_costofrising_select^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.correctNull(rs.getString("agr_appno")));//0 Appno
				arrCol.add(Helper.correctNull(rs.getString("agr_sno")));//1  serial number
				arrCol.add(Helper.correctNull(rs.getString("agr_plantname")));//2 plant name
				arrCol.add(Helper.correctNull(rs.getString("agr_costofplant")));//3 costofplant
				arrCol.add(Helper.correctNull(rs.getString("agr_costofbag")));//4 costofbag
				arrCol.add(Helper.correctNull(rs.getString("agr_costofclay")));//5 costofclay
				arrCol.add(Helper.correctNull(rs.getString("agr_wateringcost")));//6 wateringcost
				arrCol.add(Helper.correctNull(rs.getString("agr_costofmanure")));//7 costofmanure
				arrCol.add(Helper.correctNull(rs.getString("agr_labourcost")));//8 labourcost
				arrCol.add(Helper.correctNull(rs.getString("agr_othermisc")));//9 othermisc
				arrCol.add(Helper.correctNull(rs.getString("agr_totalcost")));//10	totalcost
				
				arrRow.add(arrCol);	
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getCostOfRisingByAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getCostOfRisingByAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrRow;
	}
	
	public HashMap getNurseryAssessmentByAppno(String strAppNo) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		HashMap hshNursAssess = new HashMap();
		double dblnoofplants=0.0,dblcostperplant=0.0,dblcultivationcost=0.0,dblsellperplant=0.0,dblsellcost=0.0,dbltotalsale=0.0;
		try {
			rs=DBUtils.executeLAPSQuery("agrnurseryassessment_sel^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
	
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_nameofplant")));//0
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_maxnounits")));//1
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_population")));//2
				dblnoofplants+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_population")));
				
				arrCol.add(Helper.correctDouble(rs.getString("agr_nas_costofraising")));//3
				dblcostperplant+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_costofraising")));
				
				arrCol.add(Helper.correctDouble(rs.getString("agr_nas_costofcultivation")));//4
				dblcultivationcost+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_costofcultivation")));
				
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_plantforsale")));//5
				dblsellperplant+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_plantforsale")));
				
				arrCol.add(Helper.correctDouble(rs.getString("agr_nas_sellingprice")));//6
				dblsellcost+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_sellingprice")));
				
				arrCol.add(Helper.correctDouble(rs.getString("agr_nas_totalsalevalue")));//7
				dbltotalsale+=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_nas_totalsalevalue")));
				
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_acre")));//8
				arrCol.add(Helper.correctNull(rs.getString("agr_nas_totalplant")));//9
				
				hshNursAssess.put("otherexp",Helper.correctDouble(rs.getString("agr_nas_otherexp")));
				arrRow.add(arrCol);	
		}
			hshNursAssess.put("arrRow", arrRow);
			
			hshNursAssess.put("dblnoofplants", String.valueOf(dblnoofplants));
			
			hshNursAssess.put("dblcostperplant", String.valueOf(dblcostperplant));
			hshNursAssess.put("dblcultivationcost", String.valueOf(dblcultivationcost));
			hshNursAssess.put("dblsellperplant", String.valueOf(dblsellperplant));
			hshNursAssess.put("dblsellcost", String.valueOf(dblsellcost));
			hshNursAssess.put("dbltotalsale", String.valueOf(dbltotalsale));
			
			arrCol=null;
			if(rs!=null)
			rs.close();
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			log.error("Error in getNurseryAssessmentByAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getNurseryAssessmentByAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return hshNursAssess;
	}
	
	public HashMap getSHGApplicationDetailByAppno(String strAppNo,String strAppId) throws Exception
	{

		ResultSet rs=null;
		HashMap hshSHGApp = new HashMap();		
		try {
			rs=DBUtils.executeLAPSQuery("per_shgapplicationdet_select^"+strAppNo);
			if(rs.next())
			{
				hshSHGApp.put("locatedin", Helper.correctNull(rs.getString("loan_locatedin")));
				//hshSHGApp.put("dosetype", Helper.correctNull(rs.getString("pa_loan_applyingfor")));
				//hshSHGApp.put("limittype", Helper.correctNull(rs.getString("pa_loan_limittype")));
				//hshSHGApp.put("alreadyavailed",Helper.correctNull(rs.getString("pa_loan_reglimit")));
				//hshSHGApp.put("eligiblemember",Helper.correctNull(rs.getString("pa_eligiblemember")));
				//hshSHGApp.put("debtamt", Helper.correctDouble(rs.getString("pa_debtamt")));
				hshSHGApp.put("pa_loanapp_received_date", rs.getDate("loan_receivedate"));
				
			}
			if(rs!=null) {rs.close();}
			//rs=DBUtils.executeLAPSQuery("per_customergroup_select^"+strAppId);
      	   	
			//if(rs.next()) 
	  		//{
      	   		//hshSHGApp.put("pc_shgstate",Helper.correctNull(rs.getString("pc_shgstate")));
	  		//}
			if(rs!=null) {rs.close();}
			rs=DBUtils.executeLAPSQuery("agrcorpustotal_select^"+strAppNo);
      	   	
			if(rs.next()) 
	  		{
      	   		hshSHGApp.put("agr_cog_total",Helper.correctNull(rs.getString("agr_cog_total")));
	  		}
			if(rs!=null) {rs.close();}
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			log.error("Error in getSHGApplicationDetailByAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getSHGApplicationDetailByAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		return hshSHGApp;
	}
	
	public HashMap getSHGDoseIDetailsByPrdCode(String strPrdCode,String strLocation) throws Exception
	{
      	ResultSet rs = null;
  		HashMap hshRecord = new HashMap();
  		String strQuery = null;  	
        try
        {
      		strQuery="";
      		strQuery=SQLParser.getSqlQuery("set_shgdose1details_select^" + strPrdCode+"^"+strLocation);
      		rs = DBUtils.executeQuery(strQuery);
      	   	if(rs.next()) 
      		{
  				hshRecord.put("reglimit",Helper.correctNull(rs.getString("shg_reglimit")));
  				hshRecord.put("toteliglimit",Helper.correctNull(rs.getString("shg_toteliglimit")));			
      		}
     	}
        catch(Exception exception)
        {
        	log.error("Exception in getSHGDoseIDetailsByPrdCode::"+exception);
        	throw new EJBException(exception.toString());
        }
        finally
        {
        	try{
        		if(rs!=null) {
        			rs.close();
        		}
            }
        	catch(Exception ec){
        		log.error("Exception in getSHGDoseIDetailsByPrdCode::"+ec.getMessage());
			    throw new EJBException(ec.toString());
        	}
        }
          return hshRecord;
     }
	
	public ArrayList getHorticultureCostOfDevTotalAppno(String strAppNo) throws Exception
	{
		ResultSet rs=null;	
		String strQuery = null;
		ArrayList arrCostOfCult=new ArrayList();
		HashMap hshAcre=new HashMap();
		HashMap hshMain=new HashMap();
		
		ArrayList arrMaintenance=new ArrayList();
		ArrayList arrMaintenanceRow=new ArrayList();

		ArrayList arrIncome=new ArrayList();
		ArrayList arrIncomeRow=new ArrayList();
	
		ArrayList arrRow=new ArrayList();
		double dblAcre=0.00;
		String strPlantId="";
		
		try {
			
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_horticostofcultivation_select^"+strAppNo);
			while(rs.next()) 
	  		{
					hshAcre.put(FwHelper.correctNull(rs.getString("AGR_SNO")), FwHelper.correctNull(rs.getString("AGR_UNIT")));
	  		}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_hortiyearcultivationcost_select^"+strAppNo);
			arrCostOfCult=new ArrayList();
			while(rs.next()) 
	  		{
				arrCostOfCult.add(FwHelper.correctNull(rs.getString("AGR_HORTI_TOTALCOST")));		
	  		}
			arrCostOfCult=adjustArrayList(arrCostOfCult);
			
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_horti_plantdetail_sellingunitcost_select^"+strAppNo);
			while(rs.next()) 
	  		{
					arrRow.add(Helper.correctNull(rs.getString("agr_horti_id")));//1
	  		}
			//
			ArrayList arr=null;
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					strPlantId=FwHelper.correctNull((String)arrRow.get(i));
					hshMain=getIndividualMaintenanceIncomeByAppno(strAppNo,strPlantId);
					
					if(hshAcre.size()>0)
					{
						dblAcre=FwHelper.parseDouble((String)hshAcre.get(strPlantId));
					}
					arrMaintenance=(ArrayList)hshMain.get("maint");
					arrMaintenance=rearrangeArrayList(arrMaintenance,15,dblAcre);						
					arrMaintenanceRow.add(arrMaintenance);
					
					arrIncome=(ArrayList)hshMain.get("income");
					arrIncome=rearrangeArrayList(arrIncome,15,dblAcre);
					arrIncomeRow.add(arrIncome);
				}
			}
			arrIncome=calculateTotalIncome(arrIncomeRow);
			
			arrMaintenance=calculateTotalIncome(arrMaintenanceRow);
			arrRow=new ArrayList();
			arrRow=subNetIncomeCost(arrIncome, addCapitalcostMaintenanceCost(arrCostOfCult,arrMaintenance));	
			//arrRow.add(subNetIncomeCost(arrIncome, addCapitalcostMaintenanceCost(arrCostOfCult,arrMaintenance)));
			
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getHorticultureCostOfDevTotalAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHorticultureCostOfDevTotalAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrRow;
	}
	
	public ArrayList getHorticultureMaintenanceIncomeByAppno(String strAppNo) throws Exception
	{
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;	
		String strQuery = null;
		try {
			strQuery=SQLParser.getSqlQuery("agr_hortiincomemaintenance_select^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{			
				arrCol.add(Helper.correctNull(rs.getString("agr_maintenance")));//0 year1
			}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getHorticultureMaintenanceIncomeByAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHorticultureMaintenanceIncomeByAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrCol;
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
			
			log.error("Error in agr_hortiincomeindividual_select of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in agr_hortiincomeindividual_select === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return hshMain;
	}
	
	public ArrayList getHorticultureGrossValueByAppno(String strAppNo) throws Exception
	{
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;	
		String strQuery = null;
		try {
			strQuery=SQLParser.getSqlQuery("agr_hortiincome_select^"+strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{			
				arrCol.add(Helper.correctNull(rs.getString("agr_grossinc")));//0 
			}

			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getHorticultureGrossValueByAppno of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHorticultureGrossValueByAppno === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrCol;
	}
	
	public ArrayList rearrangeArrayList(ArrayList arr,String strAppNo) throws Exception
	{
		
		ResultSet rs=null;	
		int size=0;
		ArrayList arrDet=new ArrayList();
		try {
			size=arr.size();
			if(size!=0)
			{
				for(int i=0;i<size;i++)
					{
						
							arrDet.add(FwHelper.correctNull((String)arr.get(i)));
					
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
			
			log.error("Error in rearrangeArrayList of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in rearrangeArrayList === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrDet;
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
			
			log.error("Error in adjustArrayList of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in adjustArrayList === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrDet;
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
					arr.add(""+ (FwHelper.parseDouble((String)arrDet.get(i)) * dblAcre) );
				}
			}
		
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in rearrangeArrayList of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in rearrangeArrayList === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arr;
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
					arrTotal.add(""+(FwHelper.parseDouble((String)arrCapital.get(i))+FwHelper.parseDouble((String)arrMaintenance.get(i))));
				}
			}
			
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in addCapitalcostMaintenanceCost of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in addCapitalcostMaintenanceCost === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrTotal;
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
						dblTot1+=FwHelper.parseDouble((String)arrDet.get(0));
						dblTot2+=FwHelper.parseDouble((String)arrDet.get(1));
						dblTot3+=FwHelper.parseDouble((String)arrDet.get(2));
						dblTot4+=FwHelper.parseDouble((String)arrDet.get(3));
						dblTot5+=FwHelper.parseDouble((String)arrDet.get(4));
						
						dblTot6+=FwHelper.parseDouble((String)arrDet.get(5));
						dblTot7+=FwHelper.parseDouble((String)arrDet.get(6));
						dblTot8+=FwHelper.parseDouble((String)arrDet.get(7));
						dblTot9+=FwHelper.parseDouble((String)arrDet.get(8));
						dblTot10+=FwHelper.parseDouble((String)arrDet.get(9));
						
						dblTot11+=FwHelper.parseDouble((String)arrDet.get(10));
						dblTot12+=FwHelper.parseDouble((String)arrDet.get(11));
						dblTot13+=FwHelper.parseDouble((String)arrDet.get(12));
						dblTot14+=FwHelper.parseDouble((String)arrDet.get(13));
						dblTot15+=FwHelper.parseDouble((String)arrDet.get(14));
		
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
			
			log.error("Error in calculateTotalIncome of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in calculateTotalIncome === AgrNurseryLoanBO"+e.toString());
			
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
			
			log.error("Error in subNetIncomeCost of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in subNetIncomeCost === AgrNurseryLoanBO"+e.toString());
			
		}
		
		
		return arrNetBenefit;
	}
	
	
	
	
	public HashMap getSHGDoseIIIDetailsByPrdCode(String strPrdCode,String strAppFrom) throws Exception
	{
      	ResultSet rs = null;
  		HashMap hshRecord = new HashMap();
  		String strQuery = null;

        try
        {

      		strQuery="";
      		strQuery=SQLParser.getSqlQuery("set_shgdose3details_select^" + strPrdCode+"^"+strAppFrom);
      		rs = DBUtils.executeQuery(strQuery);
      	   	if(rs.next()) 
      		{
      				hshRecord.put("reglimit",Helper.correctNull(rs.getString("shg_reglimit")));
      				hshRecord.put("invcredit",Helper.correctNull(rs.getString("shg_invcredit")));
      				hshRecord.put("debtmcp",Helper.correctNull(rs.getString("shg_debtmcp")));
      				hshRecord.put("debtamt",Helper.correctNull(rs.getString("shg_debtamt")));
      				hshRecord.put("social",Helper.correctNull(rs.getString("shg_social")));
      				hshRecord.put("indiramma",Helper.correctNull(rs.getString("shg_indiramma")));
      				hshRecord.put("overalllimit",Helper.correctNull(rs.getString("shg_overalllimit")));
      		}
      	   	
      	
			
     	}
        catch(Exception exception)
        {
        	log.error("Exception in getSHGDoseIIIDetailsByPrdCode::"+exception.getMessage());
        	throw new EJBException( exception.toString());
        }
        finally
        {
        	try{
        		if(rs!=null) {
        			rs.close();
        		}
            }
        	catch( Exception ee){
        		log.error("Exception in getSHGDoseIIIDetailsByPrdCode::"+ee.getMessage());
			    throw new EJBException(ee.toString());
        	}
        }
          return hshRecord;
     }
	public HashMap getSHGDoseIIIDetailsByAppNo(String strAppNo) throws Exception
	{
      	ResultSet rs = null;
  		HashMap hshMCP = new HashMap();
        try
        {
      	  if(rs!=null) {rs.close();}
			rs=DBUtils.executeLAPSQuery("agrshgmcptotal_select^"+strAppNo);
    	   	
			if(rs.next()) 
	  		{
				hshMCP.put("regmcp", FwHelper.correctNull(rs.getString("regmcp")));
				hshMCP.put("debtmcp", FwHelper.correctNull(rs.getString("debtmcp")));
				hshMCP.put("indirmcp", FwHelper.correctNull(rs.getString("indirmcp")));
	  		}

     	}
        catch(final Exception exception)
        {
        	log.error("Exception in getSHGDoseIIIDetailsByAppNo::"+exception.getMessage());
        	throw new EJBException(exception.toString());
        }
        finally
        {
        	try{
        		if(rs!=null) {
        			rs.close();
        		}
            }
        	catch(Exception ee){
        		log.error("Exception in getSHGDoseIIIDetailsByAppNo::"+ee.getMessage());
			    throw new EJBException(ee.toString());
        	}
        }
          return hshMCP;
     }
	

	public HashMap getseriProjCostByAppno(String strAppNo)throws Exception
	{
		{
			HashMap hshProjCost =new HashMap();
			ResultSet rs=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_seriprojcost_select^"+strAppNo);
				while(rs.next())
				{
					hshProjCost.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshProjCost.put("landpreparation", Helper.correctNull(rs.getString("agr_landpreparation")));
					hshProjCost.put("cuttings", Helper.correctNull(rs.getString("agr_cuttings")));
					hshProjCost.put("planting", Helper.correctNull(rs.getString("agr_planting")));
					hshProjCost.put("manures", Helper.correctNull(rs.getString("agr_manures")));
					hshProjCost.put("irrigation", Helper.correctNull(rs.getString("agr_irrigation")));//6
					hshProjCost.put("weeding", Helper.correctNull(rs.getString("agr_weeding")));
					hshProjCost.put("others", Helper.correctNull(rs.getString("agr_others")));
					hshProjCost.put("totala", Helper.correctNull(rs.getString("agr_totala")));
					hshProjCost.put("rearshedft", Helper.correctNull(rs.getString("agr_rearshedft")));
					
					hshProjCost.put("rearshedrs", Helper.correctNull(rs.getString("agr_rearshedrs")));//11
					hshProjCost.put("rearstandno", Helper.correctNull(rs.getString("agr_rearstandno")));
					hshProjCost.put("rearstandrs", Helper.correctNull(rs.getString("agr_rearstandrs")));
					hshProjCost.put("reartrayno", Helper.correctNull(rs.getString("agr_reartrayno")));
					hshProjCost.put("reartrayrs", Helper.correctNull(rs.getString("agr_reartrayrs")));
					hshProjCost.put("chandrikasno", Helper.correctNull(rs.getString("agr_chandrikasno")));//16
					hshProjCost.put("chandrikasrs", Helper.correctNull(rs.getString("agr_chandrikasrs")));
					hshProjCost.put("misc", Helper.correctNull(rs.getString("agr_misc")));
					hshProjCost.put("totalb", Helper.correctNull(rs.getString("agr_totalb")));
					hshProjCost.put("labour", Helper.correctNull(rs.getString("agr_labour")));

					hshProjCost.put("transport", Helper.correctNull(rs.getString("agr_transport")));	//21
					hshProjCost.put("dflno", Helper.correctNull(rs.getString("agr_dflno")));
					hshProjCost.put("dflrs", Helper.correctNull(rs.getString("agr_dflrs")));
					hshProjCost.put("totalc", Helper.correctNull(rs.getString("agr_totalc")));
					hshProjCost.put("totunitcost", Helper.correctNull(rs.getString("agr_totunitcost")));
					hshProjCost.put("noofacres", Helper.correctNull(rs.getString("agr_noofacres")));
				}
				if(rs!=null){rs.close();}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getseriProjCostByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getseriProjCostByAppno === AgrNurseryBO"+e.toString());
				
			}
			
			
			return hshProjCost;
		}
	}
	

	public HashMap getSheepFixedCostByAppNo(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try {
			rs=DBUtils.executeLAPSQuery("agr_sheepfixedcost_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
			if(rs.next())
			{

				hshRecord.put("agr_fxd_noofanimals",Helper.correctDouble(rs.getString("agr_fxd_noofanimals")));
				hshRecord.put("agr_fxd_sqftperanimal",Helper.correctDouble(rs.getString("agr_fxd_sqftperanimal")));
				hshRecord.put("agr_fxd_cstofconspersqft",Helper.correctDouble(rs.getString("agr_fxd_cstofconspersqft")));
				hshRecord.put("agr_fxd_costofconstruction",Helper.correctDouble(rs.getString("agr_fxd_costofconstruction")));
				hshRecord.put("agr_fxd_officesqft",Helper.correctDouble(rs.getString("agr_fxd_officesqft")));
				
				hshRecord.put("agr_fxd_offconsamtpersqft",Helper.correctDouble(rs.getString("agr_fxd_offconsamtpersqft")));
				hshRecord.put("agr_fxd_costofconsoff",Helper.correctDouble(rs.getString("agr_fxd_costofconsoff")));
				hshRecord.put("agr_fxd_cstoffencpersqft",Helper.correctDouble(rs.getString("agr_fxd_cstoffencpersqft")));
				hshRecord.put("agr_fxd_costoffencing",Helper.correctDouble(rs.getString("agr_fxd_costoffencing")));
				hshRecord.put("agr_fxd_equicstperanim",Helper.correctDouble(rs.getString("agr_fxd_equicstperanim")));
				
				hshRecord.put("agr_fxd_noofanimequip",Helper.correctDouble(rs.getString("agr_fxd_noofanimequip")));
				hshRecord.put("agr_fxd_totequipcost",Helper.correctDouble(rs.getString("agr_fxd_totequipcost")));
				hshRecord.put("agr_fxd_costofwater",Helper.correctDouble(rs.getString("agr_fxd_costofwater")));
				hshRecord.put("agr_fxd_othercost",Helper.correctDouble(rs.getString("agr_fxd_othercost")));
				hshRecord.put("agr_fxd_total",Helper.correctDouble(rs.getString("agr_fxd_total")));
				hshRecord.put("agr_fxd_df",Helper.correctDouble(rs.getString("agr_fxd_df")));
				hshRecord.put("AGR_FXD_FENPER",Helper.correctDouble(rs.getString("AGR_FXD_FENPER")));
				//Added by Arsath on 06/03/2014 as per the new requirements
				hshRecord.put("agr_fxd_feedstosqft",Helper.correctDouble(rs.getString("agr_fxd_feedstosqft")));
				hshRecord.put("agr_fxd_feedconsamtpersqft",Helper.correctDouble(rs.getString("agr_fxd_feedconsamtpersqft")));
				hshRecord.put("agr_fxd_costofconsfeed",Helper.correctDouble(rs.getString("agr_fxd_costofconsfeed")));
				hshRecord.put("agr_fxd_laboursqft",Helper.correctDouble(rs.getString("agr_fxd_laboursqft")));
				hshRecord.put("agr_fxd_labconsamtpersqft",Helper.correctDouble(rs.getString("agr_fxd_labconsamtpersqft")));
				hshRecord.put("agr_fxd_costofconslab",Helper.correctDouble(rs.getString("agr_fxd_costofconslab")));
				
			
				
				
			}
			
		} catch (Exception e) {
			log.error("Error in getSheepFixedCostByAppNo of AgrNurseryLoanBO"+e.getMessage());
			throw new EJBException("Error in getSheepFixedCostByAppNo "+e.toString());
		}
		finally
		{
			try {
				if(rs!=null)rs.close();
			} catch (Exception e) {
				log.error("Error in Closing Connection of AgrNurseryLoanBO"+e.getMessage());
				throw new EJBException("Error in Closing Connection of getSheepFixedCostByAppNo "+e.toString());
			}
		}
		return hshRecord;
		
	}
	
	public ArrayList getSheepIncomeByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
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
	strQuery = SQLParser.getSqlQuery("agr_sheepincome_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
	
	rs = DBUtils.executeQuery(strQuery);
	try{
			
			while(rs.next())
			{
				arrValues=new ArrayList();
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year1")));//0
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year2")));//1
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year3")));//2
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year4")));//3
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year5")));//4
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_year6")));//5
				arrValues.add(Helper.correctNull(rs.getString("agr_sin_cost")));//6
				arrValues.add(Helper.correctNull(rs.getString("AGR_SIN_AVGWEIGHT")));//7
				arrValues.add(Helper.correctNull(rs.getString("AGR_SIN_RATEPERKG")));//8
			    arrData.add(arrValues);	

			}
		
	}
	catch(Exception e)
	{
		log.error("Error in getSheepIncomeByAppno of AgrNurseryLoanBO" +e.getMessage());
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
			log.error("Error in getSheepIncomeByAppno of AgrNurseryLoanBO"+cf.getMessage());
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
		return arrData;
	}

	public ArrayList getSheepIncomeRearrange(ArrayList arrSheepIncome) throws Exception
	{
		ArrayList arrIncome1=null;
		ArrayList arrIncome2=null;
		ArrayList arrIncome3=null;
		ArrayList arrData=new ArrayList();
		try{
			
			//Added
			for(int i=0;i<arrSheepIncome.size();i++)
			{
				if(i<4)
				{
					arrIncome1=(ArrayList)arrSheepIncome.get(i);
				}
				if(i==6)
				{
					arrIncome1=(ArrayList)arrSheepIncome.get(i);
					arrIncome2=(ArrayList)arrSheepIncome.get(i+1);
					arrIncome3=(ArrayList)arrSheepIncome.get(i+2);
					
					for(int j=0;j<arrIncome2.size();j++)
					{
						arrIncome1.add(arrIncome2.get(j));
					}
					
					for(int j=0;j<arrIncome3.size();j++)
					{
						arrIncome1.add(arrIncome3.get(j));
					}
					i=i+2;
				}
				else if(i==4)
				{
					arrIncome1=(ArrayList)arrSheepIncome.get(i);
					arrIncome2=(ArrayList)arrSheepIncome.get(i+1);
					
					for(int j=0;j<arrIncome2.size();j++)
					{
						arrIncome1.add(arrIncome2.get(j));
					}
					i=i+1;
				}
				if(i==9)
				{
					arrIncome1=(ArrayList)arrSheepIncome.get(i);
				}
				arrData.add(arrIncome1);
			}
	}
	catch(Exception e)
	{
		log.error("Error in getSheepIncomeRearrange of AgrNurseryLoanBO" +e.getMessage());
		
	}
		return arrData;
	}
	
	
	public String getApplicationMarginByAppNo(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
      	ResultSet rs = null;
  		String strMargin="";
  
        try
        {
      	  if(rs!=null) {rs.close();}
			rs=DBUtils.executeLAPSQuery("per_applicationsmargin_select^"+strAppNo);
    	   	
			if(rs.next()) 
	  		{
				strMargin=FwHelper.correctNull(rs.getString("facility_margin"));
	  		}

     	}
        catch(Exception exception)
        {
        	if(rs!=null) {
    			rs.close();
    		}
        	log.error("Exception in getApplicationMarginByAppNo::"+exception.getMessage());
        	throw new EJBException(exception.toString());
        }
  
          return strMargin;
     }
	
	public HashMap getSheepRecurringExpByAppNo(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		try {
			rs=DBUtils.executeLAPSQuery("agr_sheeprecurringexp_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
			if(rs.next())
			{

				hshRecord.put("agr_rec_noofadult",Helper.correctDouble(rs.getString("agr_rec_noofadult")));
				hshRecord.put("agr_rec_noofram",Helper.correctDouble(rs.getString("agr_rec_noofram")));
				hshRecord.put("agr_rec_costofperewe",Helper.correctDouble(rs.getString("agr_rec_costofperewe")));
				hshRecord.put("agr_rec_costofperram",Helper.correctDouble(rs.getString("agr_rec_costofperram")));
				hshRecord.put("agr_rec_totcosteweram",Helper.correctDouble(rs.getString("agr_rec_totcosteweram")));	
				hshRecord.put("agr_rec_areaofcultivation",Helper.correctDouble(rs.getString("agr_rec_areaofcultivation")));
				hshRecord.put("agr_rec_costofcultperacre",Helper.correctDouble(rs.getString("agr_rec_costofcultperacre")));
				hshRecord.put("agr_rec_costofcult",Helper.correctDouble(rs.getString("agr_rec_costofcult")));
				hshRecord.put("agr_rec_feedconcadtperday",Helper.correctDouble(rs.getString("agr_rec_feedconcadtperday")));
				hshRecord.put("agr_rec_feedconclambperday",Helper.correctDouble(rs.getString("agr_rec_feedconclambperday")));			
				hshRecord.put("agr_rec_noofadtforfed",Helper.correctDouble(rs.getString("agr_rec_noofadtforfed")));
				hshRecord.put("agr_rec_nooflamforfed",Helper.correctDouble(rs.getString("agr_rec_nooflamforfed")));
				hshRecord.put("agr_rec_totfeedkg",Helper.correctDouble(rs.getString("agr_rec_totfeedkg")));
				hshRecord.put("agr_rec_feedamtperkg",Helper.correctDouble(rs.getString("agr_rec_feedamtperkg")));
				hshRecord.put("agr_rec_nooflabours",Helper.correctDouble(rs.getString("agr_rec_nooflabours")));
				
				hshRecord.put("agr_rec_totfeedamt",Helper.correctDouble(rs.getString("agr_rec_totfeedamt")));
				hshRecord.put("agr_rec_wageperannum",Helper.correctDouble(rs.getString("agr_rec_wageperannum")));
				hshRecord.put("agr_rec_totwage",Helper.correctDouble(rs.getString("agr_rec_totwage")));
				hshRecord.put("agr_rec_vetcostperanim",Helper.correctDouble(rs.getString("agr_rec_vetcostperanim")));
				hshRecord.put("agr_rec_totvetcost",Helper.correctDouble(rs.getString("agr_rec_totvetcost")));	
				hshRecord.put("agr_rec_insperccstofanim",Helper.correctDouble(rs.getString("agr_rec_insperccstofanim")));
				hshRecord.put("agr_rec_insurpercstofshed",Helper.correctDouble(rs.getString("agr_rec_insurpercstofshed")));
				hshRecord.put("agr_rec_totinsuramt",Helper.correctDouble(rs.getString("agr_rec_totinsuramt")));
				hshRecord.put("agr_rec_elecpermonth",Helper.correctDouble(rs.getString("agr_rec_elecpermonth")));
				hshRecord.put("agr_rec_elecperyear",Helper.correctDouble(rs.getString("agr_rec_elecperyear")));			
				hshRecord.put("agr_rec_totalb",Helper.correctDouble(rs.getString("agr_rec_totalb")));
				hshRecord.put("agr_rec_bankloan",Helper.correctDouble(rs.getString("agr_rec_bankloan")));
				hshRecord.put("agr_rec_totcost",Helper.correctDouble(rs.getString("AGR_REC_TOTCOSFEED")));
				
				//Added by Arsath on 06/03/2014 as per the new requirements
				hshRecord.put("agr_fxd_feedstosqft",Helper.correctDouble(rs.getString("agr_fxd_feedstosqft")));
				hshRecord.put("agr_fxd_feedconsamtpersqft",Helper.correctDouble(rs.getString("agr_fxd_feedconsamtpersqft")));
				hshRecord.put("agr_fxd_costofconsfeed",Helper.correctDouble(rs.getString("agr_fxd_costofconsfeed")));
				hshRecord.put("agr_fxd_laboursqft",Helper.correctDouble(rs.getString("agr_fxd_laboursqft")));
				hshRecord.put("agr_fxd_labconsamtpersqft",Helper.correctDouble(rs.getString("agr_fxd_labconsamtpersqft")));
				hshRecord.put("agr_fxd_costofconslab",Helper.correctDouble(rs.getString("agr_fxd_costofconslab")));
				hshRecord.put("agr_rec_costofshed",Helper.correctDouble(rs.getString("agr_rec_costofshed")));
			}
			
		} catch (Exception e) {
			log.error("Error in getSheepRecurringExpByAppNo of AgrNurseryLoanBO"+e.getMessage());
			throw new EJBException("Error in getSheepRecurringExpByAppNo "+e.toString());
		}
		finally
		{
			try {
				if(rs!=null)rs.close();
			} catch (Exception e) {
				log.error("Error in Closing Connection of AgrNurseryLoanBO"+e.getMessage());
				throw new EJBException("Error in Closing Connection of getSheepRecurringExpByAppNo "+e.toString());
			}
		}
		return hshRecord;
		
	}

	
	public HashMap getSheepHerdProjChartByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = null;
		ArrayList arrData= new ArrayList();
		try
		{
				rs = DBUtils.executeLAPSQuery("agr_sheepherdprojchart_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				while(rs.next())
				{
					arrValues=new ArrayList();
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year1")));//0 Year1
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year2")));//1 Year2
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year3")));//2 Year3
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year4")));//3 Year4
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year5")));//4 Year5
					arrValues.add(Helper.correctInt(rs.getString("agr_hpc_year6")));//5 Year6
				    arrData.add(arrValues);	
				}
				hshRecord.put("arrHerdPrjChart",arrData);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("agr_lambsproducedpercentage_select^"+strAppNo+"^"+schemetype);
				if(rs.next())
				{
					hshRecord.put("agr_lambsproducedpercentage",Helper.correctDouble(rs.getString("agr_lambsproducedpercentage")));
					hshRecord.put("agr_lambsmortalitypercentage",Helper.correctDouble(rs.getString("agr_lambsmortalitypercentage")));
				}
		}
	catch(Exception e)
	{
		log.error("Error in getSheepHerdProjChartByAppno of AgrNurseryLoanBO" +e.getMessage());
		if(rs!=null){rs.close();}
	}
	finally
	{
		try
		{
			if(rs != null) rs.close();
		}
		catch(Exception cf)
		{
			log.error("Error in getSheepHerdProjChartByAppno of AgrNurseryLoanBO"+cf.getMessage());
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	
		return hshRecord;
	}
	public HashMap getseriIncExpByAppno(String strAppNo)throws Exception
	{
		{
			HashMap hshIncExp =new HashMap();
			ResultSet rs=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_sericultureincexp_select^"+strAppNo);
				while(rs.next())
				{
					hshIncExp.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshIncExp.put("yieldofcocoon", Helper.correctNull(rs.getString("agr_yieldofcocoon")));
					hshIncExp.put("noofcrops", Helper.correctNull(rs.getString("agr_noofcrops")));
					hshIncExp.put("totyieldofcocoon", Helper.correctNull(rs.getString("agr_totyieldofcocoon")));
					hshIncExp.put("salepriceofcoc", Helper.correctNull(rs.getString("agr_salepriceofcoc")));
					hshIncExp.put("totinc", Helper.correctNull(rs.getString("agr_totinc")));//6
					hshIncExp.put("totcultivation", Helper.correctNull(rs.getString("agr_totcultivation")));
					hshIncExp.put("rearingcost", Helper.correctNull(rs.getString("agr_rearingcost")));
					hshIncExp.put("noofcropsexp", Helper.correctNull(rs.getString("agr_noofcropsexp")));
					hshIncExp.put("totrearingcost", Helper.correctNull(rs.getString("agr_totrearingcost")));
					hshIncExp.put("totexp", Helper.correctNull(rs.getString("agr_totexp")));//11
					hshIncExp.put("surplus", Helper.correctNull(rs.getString("agr_surplus")));
				}
				if(rs!=null){rs.close();}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getseriIncExpByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getseriIncExpByAppno === AgrNurseryBO"+e.toString());
			}
			return hshIncExp;
		}
	}
	public HashMap getFisheriesExcavationByAppno(String strAppNo)throws Exception
	{
		{
			HashMap hshFisheries =new HashMap();
			ResultSet rs=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_fisheriesexcavation_select^"+strAppNo);
				while(rs.next())
				{
					hshFisheries.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshFisheries.put("excavation", Helper.correctNull(rs.getString("agr_excavation")));
					hshFisheries.put("formation", Helper.correctNull(rs.getString("agr_formation")));
					hshFisheries.put("outlet", Helper.correctNull(rs.getString("agr_outlet")));
					hshFisheries.put("equipment", Helper.correctNull(rs.getString("agr_equipment")));
					hshFisheries.put("othermisc", Helper.correctNull(rs.getString("agr_othermisc")));//6
					hshFisheries.put("totexcavation", Helper.correctNull(rs.getString("agr_totexcavation")));
					hshFisheries.put("desilting", Helper.correctNull(rs.getString("agr_desilting")));
					hshFisheries.put("strength", Helper.correctNull(rs.getString("agr_strength")));
					hshFisheries.put("otherexp", Helper.correctNull(rs.getString("agr_otherexp")));
					hshFisheries.put("totrenovation", Helper.correctNull(rs.getString("agr_totrenovation")));//11
					hshFisheries.put("depreciation", Helper.correctNull(rs.getString("agr_depreciation")));//12
				}
				if(rs!=null){rs.close();}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getFisheriesExcavationByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getFisheriesExcavationByAppno === AgrNurseryBO"+e.toString());
			}
			return hshFisheries;
		}
	}
	public HashMap getMilkCollectionByAppno(String strAppNo)throws Exception
	{
		{
			HashMap hshMilkColln =new HashMap();
			ResultSet rs=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_milkcollection_select^"+strAppNo);
				if(rs.next())
				{
					hshMilkColln.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshMilkColln.put("existing", Helper.correctNull(rs.getString("agr_existing")));
					hshMilkColln.put("proposed", Helper.correctNull(rs.getString("agr_proposed")));
					hshMilkColln.put("milkcompany", Helper.correctNull(rs.getString("agr_milkcompany")));
					hshMilkColln.put("address", Helper.correctNull(rs.getString("agr_address")));
					hshMilkColln.put("avgmilk", Helper.correctNull(rs.getString("agr_avgmilk")));//6
					hshMilkColln.put("peak", Helper.correctNull(rs.getString("agr_peak")));
					hshMilkColln.put("lean", Helper.correctNull(rs.getString("agr_lean")));
					hshMilkColln.put("nooffarmers", Helper.correctNull(rs.getString("agr_nooffarmers")));
					hshMilkColln.put("noofmilch", Helper.correctNull(rs.getString("agr_noofmilch")));
					hshMilkColln.put("purchase", Helper.correctNull(rs.getString("agr_purchase")));
					hshMilkColln.put("water", Helper.correctNull(rs.getString("agr_water")));
					hshMilkColln.put("veterinary", Helper.correctNull(rs.getString("agr_veterinary")));
					hshMilkColln.put("netinc", Helper.correctNull(rs.getString("agr_netinc")));
				}
				if(rs!=null)rs.close();
				
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getMilkCollectionByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getMilkCollectionByAppno === AgrNurseryBO"+e.toString());
			}
			return hshMilkColln;
		}
	}
	
	public HashMap getSheepAgentDetailsByAppno(String strAppNo)throws Exception
	{
		{
			HashMap hshSheep =new HashMap();
			ResultSet rs=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_sheepagentdetails_select^"+strAppNo);
				if(rs.next())
				{
					hshSheep.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshSheep.put("existing", Helper.correctNull(rs.getString("agr_existing")));
					hshSheep.put("proposed", Helper.correctNull(rs.getString("agr_proposed")));
					hshSheep.put("stationname", Helper.correctNull(rs.getString("agr_stationname")));
					hshSheep.put("line1", Helper.correctNull(rs.getString("agr_line1")));	//5
					hshSheep.put("line2", Helper.correctNull(rs.getString("agr_line2")));
					hshSheep.put("city", Helper.correctNull(rs.getString("agr_city")));
					hshSheep.put("district", Helper.correctNull(rs.getString("agr_district")));
					hshSheep.put("state", Helper.correctNull(rs.getString("agr_state")));
					hshSheep.put("purchase", Helper.correctNull(rs.getString("agr_purchase")));//10
					hshSheep.put("water", Helper.correctNull(rs.getString("agr_water")));
					hshSheep.put("veterinary", Helper.correctNull(rs.getString("agr_veterinary")));
					hshSheep.put("annualinc", Helper.correctNull(rs.getString("agr_annualinc")));	//13
					hshSheep.put("agr_costlambs", Helper.correctNull(rs.getString("agr_costlambs")));
					hshSheep.put("agr_totalcost", Helper.correctNull(rs.getString("agr_totalcost")));
				}
				if(rs!=null){rs.close();}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getSheepAgentDetailsByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getSheepAgentDetailsByAppno === AgrNurseryBO"+e.toString());
			}
			return hshSheep;
		}
	}
	public ArrayList getHortiDF() throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		
		try {
			
			rs=DBUtils.executeLAPSQuery("agr_horticulturedf_select");
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("agr_sno")));//0  serial number
				arrCol.add(Helper.correctNull(rs.getString("agr_df")));//1 DF
				arrCol.add(Helper.correctNull(rs.getString("agr_year1")));//2
				arrCol.add(Helper.correctNull(rs.getString("agr_year2")));//3 
				arrCol.add(Helper.correctNull(rs.getString("agr_year3")));//4 
				arrCol.add(Helper.correctNull(rs.getString("agr_year4")));//5 
				arrCol.add(Helper.correctNull(rs.getString("agr_year5")));//7 6
				arrCol.add(Helper.correctNull(rs.getString("agr_year6")));//8 7
				arrCol.add(Helper.correctNull(rs.getString("agr_year7")));//9 8
				arrCol.add(Helper.correctNull(rs.getString("agr_year8")));//10	9
				arrCol.add(Helper.correctNull(rs.getString("agr_year9")));//11 10 
				arrCol.add(Helper.correctNull(rs.getString("agr_year10")));//12	11
				arrCol.add(Helper.correctNull(rs.getString("agr_year11")));//13 12
				arrCol.add(Helper.correctNull(rs.getString("agr_year12")));//14 13
				arrCol.add(Helper.correctNull(rs.getString("agr_year13")));//15 14
				arrCol.add(Helper.correctNull(rs.getString("agr_year14")));//16 15
				arrCol.add(Helper.correctNull(rs.getString("agr_year15")));//17 16				
				arrRow.add(arrCol);	
			}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getHortiDF of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHortiDF === AgrNurseryLoanBO"+e.toString());
		}
		
		return arrRow;
	}
	
	public ArrayList getHortiDFByAppNo(String strAppNo) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		
		try {
			rs=DBUtils.executeLAPSQuery("agrhorticultureappdf_sel^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("agr_sno")));//0  serial number
				arrCol.add(Helper.correctNull(rs.getString("agr_df")));//1 DF
				arrCol.add(Helper.correctNull(rs.getString("agr_year1")));//2
				arrCol.add(Helper.correctNull(rs.getString("agr_year2")));//3 
				arrCol.add(Helper.correctNull(rs.getString("agr_year3")));//4 
				arrCol.add(Helper.correctNull(rs.getString("agr_year4")));//5 
				arrCol.add(Helper.correctNull(rs.getString("agr_year5")));//7 6
				arrCol.add(Helper.correctNull(rs.getString("agr_year6")));//8 7
				arrCol.add(Helper.correctNull(rs.getString("agr_year7")));//9 8
				arrCol.add(Helper.correctNull(rs.getString("agr_year8")));//10	9
				arrCol.add(Helper.correctNull(rs.getString("agr_year9")));//11 10 
				arrCol.add(Helper.correctNull(rs.getString("agr_year10")));//12	11
				arrCol.add(Helper.correctNull(rs.getString("agr_year11")));//13 12
				arrCol.add(Helper.correctNull(rs.getString("agr_year12")));//14 13
				arrCol.add(Helper.correctNull(rs.getString("agr_year13")));//15 14
				arrCol.add(Helper.correctNull(rs.getString("agr_year14")));//16 15
				arrCol.add(Helper.correctNull(rs.getString("agr_year15")));//17 16
				
				arrRow.add(arrCol);	
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			
			log.error("Error in getHortiDFByAppNo of AgrNurseryLoanBO::" +e.getMessage());
			throw new EJBException("Error in getHortiDFByAppNo === AgrNurseryLoanBO"+e.toString());
		}
		
		return arrRow;
	}
	
	public HashMap calculateFinancialAnalysisByAppno(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		
			HashMap hshRecord=new HashMap();
			HashMap hshDF=new HashMap();
			ArrayList arrTotalCost=new ArrayList();
			ArrayList arrIncome=new ArrayList();
			ArrayList arrNetBenefit=new ArrayList();
			ArrayList arrDF=new ArrayList();	
			ArrayList arrPWC=new ArrayList();
			ArrayList arrPWB=new ArrayList();
			ArrayList arrRow=new ArrayList();
			String strAppStatus="";
			ResultSet rs=null;
			try 
			{				
				rs=DBUtils.executeLAPSQuery("sel_appstatus^"+strAppNo);
				if(rs.next()) 
		  		{
					strAppStatus=FwHelper.correctNull(rs.getString("app_status"));
		  		}
				if(rs!=null){rs.close();}
				
				HashMap hshInc =getTotIncomeExpByAppno(strAppNo,schemetype,strFacSNo);
				if(hshInc!=null && hshInc.size()>0)
				{
					arrIncome=(ArrayList)hshInc.get("arrIncome");
					arrTotalCost=(ArrayList)hshInc.get("arrCost");
					arrNetBenefit=(ArrayList)hshInc.get("arrNetBenefit");
					arrRow.add(arrIncome);
					arrRow.add(arrTotalCost);
					arrRow.add(arrNetBenefit);
				}
				
				if(strAppStatus.equalsIgnoreCase("CA"))
				{
					arrDF=getHortiDFByAppNo(strAppNo);
				}else{
					arrDF=getHortiDF(); 
				}
				hshDF=arriveParametersForBCR(arrDF,arrNetBenefit);
				arrPWC=multiplyDFWithList((ArrayList)hshDF.get("arrDFPerc"), arrTotalCost);
				arrPWB=multiplyDFWithList((ArrayList)hshDF.get("arrDFPerc"), arrIncome);
				
				arrRow.add(hshDF.get("arrDFPerc"));//DF
				arrRow.add(arrPWB);
				arrRow.add(arrPWC);
				arrRow.add(hshDF.get("NBF"));//NWB
				hshRecord.put("arrBCR",hshDF.get("arrBCR"));
				hshRecord.put("DFPERC",hshDF.get("DFPERC"));

				arrRow.add(hshDF.get("arrDFNXT"));//DFNXT
				arrRow.add(hshDF.get("NBFNXT"));//NWBNXT
				hshRecord.put("arrBCRNXT",hshDF.get("arrBCRNXT"));
				hshRecord.put("DFNXT",hshDF.get("DFNXT"));
				hshRecord.put("IRR",hshDF.get("IRR"));//IRR

				hshRecord.put("arrRow",arrRow);
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in calculateFinancialAnalysisByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in calculateFinancialAnalysisByAppno === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
	
	}
	public HashMap getTotIncomeExpByAppno(String strAppNo,String schemetype,String strFacSNo)throws Exception
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
			String strfacsno="";
			try 
			{				

				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_horticostofcultivation_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				while(rs.next()) 
		  		{
					arrCostOfCult=new ArrayList();
					arrCostOfCult.add(FwHelper.correctNull(rs.getString("AGR_SNO"))); 
					arrCostOfCult.add(FwHelper.correctNull(rs.getString("AGR_UNIT"))); 
					hshAcre.put(FwHelper.correctNull(rs.getString("AGR_SNO")), FwHelper.correctNull(rs.getString("AGR_UNIT")));
		  		}
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_hortiyearcultivationcost_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				arrCostOfCult=new ArrayList();
				while(rs.next()) 
		  		{
					arrCostOfCult.add(FwHelper.correctNull(rs.getString("AGR_HORTI_TOTALCOST")));		
		  		}
				arrCostOfCult=adjustArrayList(arrCostOfCult);
				
				
						
				if(rs!=null){rs.close();}
				arrHortiplant=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppNo,schemetype,strFacSNo);
				ArrayList arr=null;
				if(arrHortiplant!=null && arrHortiplant.size()>0)
				{
					for(int i=0;i<arrHortiplant.size();i++)
					{
						arr=(ArrayList)arrHortiplant.get(i);
						strPlantId=FwHelper.correctNull((String)arr.get(1));
						hshMain=getIndividualMaintenanceIncomeByAppno(strAppNo,strPlantId);
						arrPlantName.add(FwHelper.correctNull((String)arr.get(2)));
						arrMaintenanceRow=(ArrayList)hshMain.get("maint");
						if(hshAcre.size()>0)
						{
							dblAcre=FwHelper.parseDouble((String)hshAcre.get(strPlantId));
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
				log.error("Error in getTotIncomeExpByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getTotIncomeExpByAppno === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
	
	}
	
	public HashMap getCostOfCulticationDetByAppNo(String strAppNo)throws Exception
	{
		
			HashMap hshRecord=new HashMap();
			
			ArrayList arrNetBenefit=new ArrayList();		
			ArrayList arrRow=new ArrayList();
			ResultSet rs=null;
			try 
			{				
				
				if(rs!=null){rs.close();}
				
			
				
				
				arrRow.add(arrNetBenefit);
				
				hshRecord.put("arrRow",arrRow);
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getTotIncomeExpByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getTotIncomeExpByAppno === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
	
	}
	public ArrayList getLoanOSBegning(String strAppNo)throws Exception
	{
		ArrayList arrLoanBegininofyear=new ArrayList();
		ResultSet rs=null;
		try {
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("agr_hortiyearcultivationcost_select^"+strAppNo);
			arrLoanBegininofyear=new ArrayList();
			while(rs.next()) 
	  		{
				arrLoanBegininofyear.add(FwHelper.correctNull(rs.getString("agr_horti_bankloan")));		
	  		}
			arrLoanBegininofyear=adjustArrayList(arrLoanBegininofyear);
		} catch (Exception e) {
			log.error("Error in getLoanOSBegning AgrNurseryBO::" +e.getMessage());
			throw new EJBException("Error in getLoanOSBegning === AgrNurseryBO"+e.toString());
		}
		finally
		{
			try {
				
			} catch (Exception e) {
				log.error("Error in getLoanOSBegning AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getLoanOSBegning === AgrNurseryBO"+e.toString());
			}
		}
		return arrLoanBegininofyear;
	}
	public HashMap getDairyCostofInvestmentByAppno(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
			HashMap hshRecord =new HashMap();
			ResultSet rs=null;
			double dblrequestedAmount=0.00;
			String strProductCode="",strSchemeType="";
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("appno", Helper.correctNull(rs.getString("agr_appno")));	//1
					hshRecord.put("agr_noofadultanimal", Helper.correctNull(rs.getString("agr_noofadultanimal")));
					hshRecord.put("agr_sqftperadultanimal", Helper.correctNull(rs.getString("agr_sqftperadultanimal")));
					hshRecord.put("agr_adultshedamtpersqft", Helper.correctNull(rs.getString("agr_adultshedamtpersqft")));
					hshRecord.put("agr_costofconsofadultshed", Helper.correctNull(rs.getString("agr_costofconsofadultshed")));
					hshRecord.put("agr_noofcalvesanimal", Helper.correctNull(rs.getString("agr_noofcalvesanimal")));//6
					hshRecord.put("agr_noofheifersanimal", Helper.correctNull(rs.getString("agr_noofheifersanimal")));
					hshRecord.put("agr_calvesarea", Helper.correctNull(rs.getString("agr_calvesarea")));
					hshRecord.put("agr_calvesamtpersqft", Helper.correctNull(rs.getString("agr_calvesamtpersqft")));
					hshRecord.put("agr_costofcalvesshed", Helper.correctNull(rs.getString("agr_costofcalvesshed")));
					
					hshRecord.put("agr_equipmentcost_animal", Helper.correctNull(rs.getString("agr_equipmentcost_animal")));//11
					hshRecord.put("agr_noofanimal", Helper.correctNull(rs.getString("agr_noofanimal")));
					hshRecord.put("agr_costofequipment", Helper.correctNull(rs.getString("agr_costofequipment")));
					hshRecord.put("agr_fencingcost_acre", Helper.correctNull(rs.getString("agr_fencingcost_acre")));
					hshRecord.put("agr_fencingarea", Helper.correctNull(rs.getString("agr_fencingarea")));
					hshRecord.put("agr_costoffencing", Helper.correctNull(rs.getString("agr_costoffencing")));//16
					hshRecord.put("agr_yieldingltr", Helper.correctNull(rs.getString("agr_yieldingltr")));
					hshRecord.put("agr_costofanimal", Helper.correctNull(rs.getString("agr_costofanimal")));
					hshRecord.put("agr_totalcostofanimal", Helper.correctNull(rs.getString("agr_totalcostofanimal")));
					hshRecord.put("agr_maintenancecost", Helper.correctNull(rs.getString("agr_maintenancecost")));

					hshRecord.put("agr_firstbatchanimal", Helper.correctNull(rs.getString("agr_firstbatchanimal")));	//21
					hshRecord.put("agr_insurancepercent", Helper.correctNull(rs.getString("agr_insurancepercent")));
					hshRecord.put("agr_insurancecost", Helper.correctNull(rs.getString("agr_insurancecost")));
					hshRecord.put("agr_miscellaneouscost", Helper.correctNull(rs.getString("agr_miscellaneouscost")));
					hshRecord.put("agr_totunitcost", Helper.correctNull(rs.getString("agr_totunitcost")));
					hshRecord.put("agr_heifersarea", Helper.correctNull(rs.getString("AGR_HEIFERSAREA")));
					hshRecord.put("agr_heifersamtpersqft", Helper.correctNull(rs.getString("AGR_HEIFERSAMTPERSQFT")));
					hshRecord.put("agr_costofgodown", Helper.correctNull(rs.getString("AGR_COSTOFGODOWN")));
					//Added by Arsath as per the requirement
					hshRecord.put("agr_animaltype", Helper.correctNull(rs.getString("agr_animaltype")));
					
				}
				if(rs!=null) rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_agriculture_facilitiesfordairy^"+strAppNo+"^"+"aD"+"^"+strFacSNo);
				while(rs.next())
				{
					strProductCode=Helper.correctNull((String)rs.getString("facility_code"));
				}
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_agriculture_facilities_scheme^"+strAppNo+"^"+"aD"+"^"+strFacSNo);
				if(rs.next())
				{
					dblrequestedAmount=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
					//dblrequestedAmount=dblrequestedAmount*100000.00;
				}
				if(rs!=null) rs.close();
				rs=DBUtils.executeLAPSQuery("getfacilityMargin^"+strProductCode+"^"+dblrequestedAmount+"^"+dblrequestedAmount);
				if(rs.next())
				{
				hshRecord.put("Margin", Helper.correctDouble((String)rs.getString("margin_perct")));
				}
				
				if(rs!=null) {rs.close();}
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getseriProjCostByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getseriProjCostByAppno === AgrNurseryBO"+e.toString());
				
			}
			
			
			return hshRecord;
		
	}
	
	public HashMap getDairyFinancialDataByAppNo(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
			HashMap hshRecord =new HashMap();
			ResultSet rs=null,rs1=null;
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_dairyfinancialdata_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_findata_milkcost", Helper.correctNull(rs.getString("agr_findata_milkcost")));	//1
					hshRecord.put("agr_findata_manurecost", Helper.correctNull(rs.getString("agr_findata_manurecost")));//2
					hshRecord.put("agr_findata_buffaloecost", Helper.correctNull(rs.getString("agr_findata_buffaloecost")));//3
					hshRecord.put("agr_findata_adult_vetaid", Helper.correctNull(rs.getString("agr_findata_adult_vetaid")));//4
					hshRecord.put("agr_findata_heifer_vetaid", Helper.correctNull(rs.getString("agr_findata_heifer_vetaid")));//5
					hshRecord.put("agr_findata_electric_cost", Helper.correctNull(rs.getString("agr_findata_electric_cost")));//6
					hshRecord.put("agr_findata_heifer_foddercost", Helper.correctNull(rs.getString("agr_findata_heifer_foddercost")));//7
					hshRecord.put("agr_findata_labour_count", Helper.correctNull(rs.getString("agr_findata_labour_count")));//8
					hshRecord.put("agr_findata_labour_salary", Helper.correctNull(rs.getString("agr_findata_labour_salary")));//9
					hshRecord.put("agr_findata_lact_grnfodderwt", Helper.correctNull(rs.getString("agr_findata_lact_grnfodderwt")));//10
					hshRecord.put("agr_findata_lact_dryfodderwt", Helper.correctNull(rs.getString("agr_findata_lact_dryfodderwt")));//11
					hshRecord.put("agr_findata_lact_concnfodderwt", Helper.correctNull(rs.getString("agr_findata_lact_concnfodderwt")));//12
					
					hshRecord.put("agr_findata_dry_grnfodderwt", Helper.correctNull(rs.getString("agr_findata_dry_grnfodderwt")));	//13
					hshRecord.put("agr_findata_dry_dryfodderwt", Helper.correctNull(rs.getString("agr_findata_dry_dryfodderwt")));//14
					hshRecord.put("agr_findata_dry_concnfodderwt", Helper.correctNull(rs.getString("agr_findata_dry_concnfodderwt")));//15
					hshRecord.put("agr_findata_grnfodder_cost", Helper.correctNull(rs.getString("agr_findata_grnfodder_cost")));//16
					hshRecord.put("agr_findata_dryfodder_cost", Helper.correctNull(rs.getString("agr_findata_dryfodder_cost")));//17
					hshRecord.put("agr_findata_concnfodder_cost", Helper.correctNull(rs.getString("agr_findata_concnfodder_cost")));//18
					hshRecord.put("agr_findata_heifer_feedcost", Helper.correctNull(rs.getString("AGR_FINDATA_HEIFER_FEEDCOST")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				rs1=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs1.next())
				{
					String strAnimaltype = Helper.correctNull((String)rs1.getString("AGR_ANIMALTYPE"));
					String strAnimaltype1="";
					if(!strAnimaltype.equalsIgnoreCase(""))
					{
						if(strAnimaltype.equalsIgnoreCase("1"))
						{
							strAnimaltype1 = "Cow";
						}
						else
						{
							strAnimaltype1 = "Buffalo";
						}
						hshRecord.put("animaltype",strAnimaltype1);
					}
					
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getDairyFinancialDataByAppNo AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getDairyFinancialDataByAppNo === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
		}
	public HashMap getDairyHerdProductionChartByAppno(String strAppNo,String schemetype,String strFacSNo) throws Exception
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = null;
		ArrayList arrRow= new ArrayList();
		try
		{
				rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_firstyear")));//0 Year1
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_secondyear")));//1 Year2
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_thirdyear")));//2 Year3
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fourthyear")));//3 Year4
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fifthyear")));//4 Year5
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_sixthyear")));//5 Year6
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrRow",arrRow);
				if(rs!=null) rs.close();
				rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_adult_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_noofadultanimal", Helper.correctNull(rs.getString("agr_noofadultanimal")));
					String strAnimaltype = Helper.correctNull((String)rs.getString("agr_animaltype"));
					String strAnimaltype1="";
					if(!strAnimaltype.equalsIgnoreCase(""))
					{
						if(strAnimaltype.equalsIgnoreCase("1"))
						{
							strAnimaltype1 = "Cow";
						}
						else
						{
							strAnimaltype1 = "Buffalo";
						}
						hshRecord.put("animaltype",strAnimaltype1);
					}
					
				}
				if(rs!=null) rs.close();
		}
		catch(Exception e)
		{
			log.error("Error in getDairyHerdProductionChartByAppno of AgrNurseryLoanBO" +e.getMessage());
			throw new EJBException("Error closing the connection "+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null) rs.close();
			}
			catch(Exception cf)
			{
				log.error("Error in getDairyHerdProductionChartByAppno of AgrNurseryLoanBO"+cf.getMessage());
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		
		return hshRecord;
	}
	public HashMap getDairyIncomeStatementByAppNo(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		{
			HashMap hshRecord =new HashMap();
			ResultSet rs=null,rs1=null;
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow= new ArrayList();
			ArrayList arrHerdProductionCol = new ArrayList();
			ArrayList arrHerdProductionRow= new ArrayList();
			try 
			{
				rs=DBUtils.executeLAPSQuery("agr_dairyfinancialdata_income_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_findata_milkcost", Helper.correctNull(rs.getString("agr_findata_milkcost")));	//1
					hshRecord.put("agr_findata_manurecost", Helper.correctNull(rs.getString("agr_findata_manurecost")));//2
					hshRecord.put("agr_findata_buffaloecost", Helper.correctNull(rs.getString("agr_findata_buffaloecost")));//3
				}
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_milkyield_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_yieldingltr", Helper.correctNull(rs.getString("agr_yieldingltr")));	//1
					hshRecord.put("agr_firstbatchanimal", Helper.correctNull(rs.getString("agr_firstbatchanimal")));	//1
					
				}
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_adult_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					hshRecord.put("agr_firstbatchanimal", Helper.correctNull(rs.getString("agr_noofadultanimal")));
				}
				if(rs!=null){rs.close();}
				
				rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				
				while(rs.next())
				{
					arrHerdProductionCol = new ArrayList();
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_firstyear")));//0 Year1
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_secondyear")));//1 Year2
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_thirdyear")));//2 Year3
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fourthyear")));//3 Year4
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fifthyear")));//4 Year5
					arrHerdProductionCol.add(Helper.correctInt(rs.getString("agr_hrdproud_sixthyear")));//5 Year6
					arrHerdProductionRow.add(arrHerdProductionCol);	
				}
				hshRecord.put("arrHerdProductionRow",arrHerdProductionRow);
				
				rs = DBUtils.executeLAPSQuery("agr_dairyincomestatement_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_firstyear")));//0 Year1
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_secondyear")));//1 Year2
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_thirdyear")));//2 Year3
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_fourthyear")));//3 Year4
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_fifthyear")));//4 Year5
					arrCol.add(Helper.correctInt(rs.getString("agr_incstat_sixthyear")));//5 Year6					
					arrRow.add(arrCol);	
					hshRecord.put("AGR_CYCLEDATA",Helper.correctNull((String)rs.getString("AGR_CYCLEDATA")));
					hshRecord.put("AGR_LACTATIONDAYS",Helper.correctNull((String)rs.getString("AGR_LACTATIONDAYS")));
					hshRecord.put("AGR_DRYDAYS",Helper.correctNull((String)rs.getString("AGR_DRYDAYS")));
					hshRecord.put("AGR_BATCH2DAYS",Helper.correctNull((String)rs.getString("AGR_BATCH2DAYS")));
				}
				hshRecord.put("arrRow",arrRow);
				
				
				rs1=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs1.next())
				{
					String strAnimaltype = Helper.correctNull((String)rs1.getString("AGR_ANIMALTYPE"));
					String strAnimaltype1="";
					if(!strAnimaltype.equalsIgnoreCase(""))
					{
						if(strAnimaltype.equalsIgnoreCase("1"))
						{
							strAnimaltype1 = "Cow";
						}
						else
						{
							strAnimaltype1 = "Buffalo";
						}
						hshRecord.put("animaltype",strAnimaltype1);
					}
					
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getDairyIncomeStatementByAppNo AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getDairyIncomeStatementByAppNo === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
		}
	}
	
	public HashMap getRecurringExpenditure(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ResultSet rs=null,rs1=null;
		ArrayList arrValues = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrLabour = new ArrayList();
		ArrayList arrHeiferFodder = new ArrayList();
		ArrayList arrHeiferFeed = new ArrayList();
		ArrayList arrElectricity = new ArrayList();
		ArrayList arrNoofAnimals = new ArrayList();
		ArrayList arrVeterinary = new ArrayList();
		ArrayList arrLactationCost = new ArrayList();
		ArrayList arrDryCost = new ArrayList();
		ArrayList arrTotalExpenditure = new ArrayList();
		ArrayList arrInsurancecost = new ArrayList();
		
		
		
		HashMap hshFinancialData = new HashMap();
		HashMap hshCostofinvest = new HashMap();
		double dblLabourCount =0,dblLabourCost=0,dblHeiferCost=0,dblHeiferfodderCost=0,dblElectricity=0,dblVeterinaryAdult=0,dblVeterinaryHeifer=0;
		double dblSalary =0,dbl_lact_green=0,dbl_lact_dry=0,dbl_lact_concentrate=0,dbl_dry_green=0,dbl_dryfodder=0,dbl_dry_concentrate=0;
		double temp=0,temp1=0,temp2=0,dbl_greencost=0,dbl_drycost=0,dbl_concentratecost=0,dbl_lactation_total=0,dbl_dry_total=0,dbl_insurancecost=0;
		int int_lact1=0,int_lact2=0,int_lact3=0,int_lact4=0,int_lact5=0,int_lact6=0;
		int int_dry1=0,int_dry2=0,int_dry3=0,int_dry4=0,int_dry5=0,int_dry6=0;
		java.text.NumberFormat nf = java.text.NumberFormat
		.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		try {
			
				//For No.of Animals
				hshFinancialData=new AgrNurseryLoanBO().getDairyFinancialDataByAppNo(strAppNo,schemetype,strFacSNo);
				hshRecord.put("hshFinancialData",hshFinancialData);
				
				hshCostofinvest=new AgrNurseryLoanBO().getDairyCostofInvestmentByAppno(strAppNo,schemetype,strFacSNo);
				hshRecord.put("hshCostofinvest",hshCostofinvest);
				
				
				rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_selectBySlNo^"+strAppNo+"^"+"1"+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_firstyear")));//0 Year1
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_secondyear")));//1 Year2
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_thirdyear")));//2 Year3
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fourthyear")));//3 Year4
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fifthyear")));//4 Year5
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_sixthyear")));//5 Year6
					arrRow.add(arrCol);//0  No of animals
				}
				else
				{
					arrRow.add(arrCol);//0  No of animals
				}
				
				//arrCol = new ArrayList();
				if(rs!=null)
					rs.close();
				dbl_lact_green =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_lact_grnfodderwt")));
				dbl_lact_dry =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_lact_dryfodderwt")));
				dbl_lact_concentrate =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_lact_concnfodderwt")));
				dbl_dry_green =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_dry_grnfodderwt")));
				dbl_dryfodder =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_dry_dryfodderwt")));
				dbl_dry_concentrate =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_dry_concnfodderwt")));
				dbl_greencost =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_grnfodder_cost")));
				dbl_drycost =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_dryfodder_cost")));
				dbl_concentratecost =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_concnfodder_cost")));
				dbl_lactation_total = (dbl_lact_green * dbl_greencost)+(dbl_lact_dry*dbl_drycost)+(dbl_lact_concentrate*dbl_concentratecost);
				dbl_dry_total = (dbl_dry_green * dbl_greencost)+(dbl_dryfodder*dbl_drycost)+(dbl_dry_concentrate*dbl_concentratecost);
				
				hshRecord.put("dbl_lactation_total",String.valueOf(dbl_lactation_total));
				hshRecord.put("dbl_dry_total",String.valueOf(dbl_dry_total));
				
				//For no of lactation days batch a,b
				String strno="3,8";
				if(rs!=null)
					rs.close();
				String strQuery=SQLParser.getSqlQuery("agr_dairyincomestatement_selectBySno^"+strAppNo+"^"+strno+"^"+schemetype+"^"+strFacSNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					int_lact1 = int_lact1+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_firstyear")));
					int_lact2 = int_lact2+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_secondyear")));
					int_lact3 = int_lact3+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_thirdyear")));
					int_lact4 = int_lact4+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_fourthyear")));
					int_lact5 = int_lact5+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_fifthyear")));
					int_lact6 = int_lact6+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_sixthyear")));
				}
				arrCol = new ArrayList();
				arrCol.add(String.valueOf(int_lact1));//0 Year1
				arrCol.add(String.valueOf(int_lact2));//1 Year2
				arrCol.add(String.valueOf(int_lact3));//2 Year3
				arrCol.add(String.valueOf(int_lact4));//3 Year4
				arrCol.add(String.valueOf(int_lact5));//4 Year5
				arrCol.add(String.valueOf(int_lact6));//5 Year6
				arrRow.add(arrCol);//1 No of lactation days
				
				arrLactationCost = new ArrayList();
				arrLactationCost.add(String.valueOf(nf.format(int_lact1*dbl_lactation_total)));//0 Year1
				arrLactationCost.add(String.valueOf(nf.format(int_lact2*dbl_lactation_total)));//1 Year2
				arrLactationCost.add(String.valueOf(nf.format(int_lact3*dbl_lactation_total)));//2 Year3
				arrLactationCost.add(String.valueOf(nf.format(int_lact4*dbl_lactation_total)));//3 Year4
				arrLactationCost.add(String.valueOf(nf.format(int_lact5*dbl_lactation_total)));//4 Year5
				arrLactationCost.add(String.valueOf(nf.format(int_lact6*dbl_lactation_total)));//5 Year6
				arrRow.add(arrLactationCost);//2 Cost of fodder lactation days
				
				//For no of dry days batch a,b
				if(rs!=null)
					rs.close();
				strno="5,10";
				strQuery=SQLParser.getSqlQuery("agr_dairyincomestatement_selectBySno^"+strAppNo+"^"+strno+"^"+schemetype+"^"+strFacSNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					int_dry1 = int_dry1+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_firstyear")));
					int_dry2 = int_dry2+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_secondyear")));
					int_dry3 = int_dry3+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_thirdyear")));
					int_dry4 = int_dry4+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_fourthyear")));
					int_dry5 = int_dry5+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_fifthyear")));
					int_dry6 = int_dry6+Integer.parseInt(Helper.correctInt(rs.getString("agr_incstat_sixthyear")));
				}
				arrCol = new ArrayList();
				arrCol.add(String.valueOf(int_dry1));//0 Year1
				arrCol.add(String.valueOf(int_dry2));//1 Year2
				arrCol.add(String.valueOf(int_dry3));//2 Year3
				arrCol.add(String.valueOf(int_dry4));//3 Year4
				arrCol.add(String.valueOf(int_dry5));//4 Year5
				arrCol.add(String.valueOf(int_dry6));//5 Year6
				arrRow.add(arrCol);//3 dry days
				
				arrDryCost = new ArrayList();
				arrDryCost.add(String.valueOf(nf.format(int_dry1*dbl_dry_total)));//0 Year1
				arrDryCost.add(String.valueOf(nf.format(int_dry2*dbl_dry_total)));//1 Year2
				arrDryCost.add(String.valueOf(nf.format(int_dry3*dbl_dry_total)));//2 Year3
				arrDryCost.add(String.valueOf(nf.format(int_dry4*dbl_dry_total)));//3 Year4
				arrDryCost.add(String.valueOf(nf.format(int_dry5*dbl_dry_total)));//4 Year5
				arrDryCost.add(String.valueOf(nf.format(int_dry6*dbl_dry_total)));//5 Year6
				arrRow.add(arrDryCost);//4 Cost of fodder dry days
				if(rs!=null)
					rs.close();
				
				//For no of heifers
				rs = DBUtils.executeLAPSQuery("agr_dairyherdproduction_selectBySlNo^"+strAppNo+"^"+"8"+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_firstyear")));//0 Year1
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_secondyear")));//1 Year2
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_thirdyear")));//2 Year3
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fourthyear")));//3 Year4
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_fifthyear")));//4 Year5
					arrCol.add(Helper.correctInt(rs.getString("agr_hrdproud_sixthyear")));//5 Year6
					arrRow.add(arrCol);//5 no of heifers
				}
				else
				{
					arrCol = new ArrayList();
					arrRow.add(arrCol);//5 no of heifers
				}
				
				dblLabourCount =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_labour_count")));
				dblSalary =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_labour_salary")));
				dblElectricity =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_electric_cost")));
				dblLabourCost = dblLabourCount *dblSalary;
				dblHeiferCost =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_heifer_foddercost")));
				dblHeiferfodderCost=Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_heifer_feedcost")));
				dblVeterinaryAdult =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_adult_vetaid")));
				dblVeterinaryHeifer =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_heifer_vetaid")));
				dbl_insurancecost=Double.parseDouble(Helper.correctDouble((String)hshCostofinvest.get("agr_insurancecost")));
				
				arrCol= (ArrayList)arrRow.get(5);
				arrNoofAnimals= (ArrayList)arrRow.get(0);
				arrLactationCost= (ArrayList)arrRow.get(2);//cost of fodder lactation
				arrDryCost= (ArrayList)arrRow.get(4);//cost of fodder dry
				
				for(int i=0;i<arrCol.size();i++)
				{
						temp=12*dblLabourCost;
					arrLabour.add(String.valueOf(nf.format(temp)));  //Labour cost
						temp=12*dblElectricity;
					arrElectricity.add(String.valueOf(nf.format(temp)));
						temp1 = Double.parseDouble(Helper.correctDouble((String)arrCol.get(i)));//no of heifers
						temp=temp1*dblHeiferCost; //no of heifers * cost
					arrHeiferFodder.add(String.valueOf(nf.format(temp)));
					temp=temp1*dblHeiferfodderCost;
					arrHeiferFeed.add(String.valueOf(nf.format(temp)));
						temp2 =  Double.parseDouble(Helper.correctDouble((String)arrNoofAnimals.get(i)));//no of Animals
						temp=(temp2*dblVeterinaryAdult)+(temp1*dblVeterinaryHeifer);
					arrVeterinary.add(String.valueOf(nf.format(temp))); //Veterinary
					if(i==0)
						arrInsurancecost.add("0.00");
					else
						arrInsurancecost.add(String.valueOf(nf.format(dbl_insurancecost)));
					temp=0;
					temp= Double.parseDouble(Helper.correctDouble((String)arrLactationCost.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrDryCost.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrLabour.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrElectricity.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrHeiferFodder.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrVeterinary.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrHeiferFeed.get(i)))+
					Double.parseDouble(Helper.correctDouble((String)arrInsurancecost.get(i)));
					arrTotalExpenditure.add(String.valueOf(nf.format(temp)));

				}
				arrRow.add(arrHeiferFeed);//6 cost of feed / heifer per year
				arrRow.add(arrHeiferFodder);//7 cost of fodder / heifer per year
				arrRow.add(arrLabour);//8
				arrRow.add(arrElectricity);//9 Electricity
				arrRow.add(arrVeterinary);//10 Veterinary
				arrRow.add(arrInsurancecost);//11 insurance cost
				arrRow.add(arrTotalExpenditure);//12 Total Expenditure
				hshRecord.put("arrNoOfAnimals",arrRow);
				
				if(arrTotalExpenditure.size()>0)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_diaryrecurringexpenditure_delete");
					arrValues.add(strAppNo);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery.put("strQueryId","agr_diaryrecurringexpenditure_insert");
					arrValues.add(strAppNo);
					arrValues.add((String)arrTotalExpenditure.get(0));
					arrValues.add((String)arrTotalExpenditure.get(1));
					arrValues.add((String)arrTotalExpenditure.get(2));
					arrValues.add((String)arrTotalExpenditure.get(3));
					arrValues.add((String)arrTotalExpenditure.get(4));
					arrValues.add((String)arrTotalExpenditure.get(5));
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					
								
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					if(rs!=null) rs.close();
					rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_adult_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
					if(rs.next())
					{
						double dblMaintanceCost=FwHelper.parseDouble(Helper.correctDouble((String)arrTotalExpenditure.get(0)))/4;
						double dblTotalUnitCost=FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_totunitcost")))+dblMaintanceCost-
						FwHelper.parseDouble(Helper.correctDouble((String)rs.getString("agr_maintenancecost")));
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues = new HashMap();
						hshQuery.put("strQueryId","agr_dairycostofinvestment_maintenance_update");
						arrValues.add(String.valueOf(dblMaintanceCost));
						arrValues.add(String.valueOf(dblTotalUnitCost));
						arrValues.add(strAppNo);
						arrValues.add(strFacSNo);
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("1",hshQuery);	
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
					}
					
				}
				
				rs1=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs1.next())
				{
					String strAnimaltype = Helper.correctNull((String)rs1.getString("AGR_ANIMALTYPE"));
					String strAnimaltype1="";
					if(!strAnimaltype.equalsIgnoreCase(""))
					{
						if(strAnimaltype.equalsIgnoreCase("1"))
						{
							strAnimaltype1 = "Cow";
						}
						else
						{
							strAnimaltype1 = "Buffalo";
						}
						hshRecord.put("animaltype",strAnimaltype1);
					}
					
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				
				
				
				
		} catch (Exception e) {
			log.error(e.toString());
			throw new EJBException("Error in getDairyRecurringExpenditure === AgrNurseryloanBean"+e.toString());
		}
		return hshRecord;
	}
	public HashMap calculateDairyFinancialAnalysis(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		
			HashMap hshRecord=new HashMap();
			HashMap hshDF=new HashMap();
			ArrayList arrExpTot=new ArrayList();
			ArrayList arrIncome=new ArrayList();
			ArrayList arrNetBenefit=new ArrayList();
			ArrayList arrDF=new ArrayList();	
			ArrayList arrPWC=new ArrayList();
			ArrayList arrPWB=new ArrayList();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCapExp=new ArrayList();
			ArrayList arrRecExp=new ArrayList();
			String strAppStatus="";
			ResultSet rs=null;
			try 
			{				
							
				rs=DBUtils.executeLAPSQuery("sel_prdriskruleid^"+strAppNo);
				if(rs.next()) 
		  		{
					strAppStatus=FwHelper.correctNull(rs.getString("APP_STATUS"));
		  		}
				if(rs!=null){rs.close();}
				
				HashMap hshInc =getDairyTotIncomeExpByAppno(strAppNo,schemetype,strFacSNo);
				if(hshInc!=null && hshInc.size()>0)
				{
					//Captial Expenditure & Expenditure total is removed as said by banker's request
					//arrCapExp=(ArrayList)hshInc.get("arrCapExp");
					arrRecExp=(ArrayList)hshInc.get("arrRecExp");
					arrIncome=(ArrayList)hshInc.get("arrIncome");
					//arrExpTot=(ArrayList)hshInc.get("arrExpTot");
					arrNetBenefit=(ArrayList)hshInc.get("arrNetBenefit");
					
					//arrRow.add(arrCapExp);//0
					arrRow.add(arrRecExp);//1
					//arrRow.add(arrExpTot);//2
					arrRow.add(arrIncome);//3
					arrRow.add(arrNetBenefit);//4
				}
				
				if(strAppStatus.equalsIgnoreCase("A"))
				{
					arrDF=getHortiDFByAppNo(strAppNo);
				}else{
					arrDF=getHortiDF(); 
				}
				hshDF=arriveParametersForBCR(arrDF,arrNetBenefit);
				arrPWC=multiplyDFWithList((ArrayList)hshDF.get("arrDFPerc"), arrRecExp);
				arrPWB=multiplyDFWithList((ArrayList)hshDF.get("arrDFPerc"), arrIncome);
				
				arrRow.add(hshDF.get("arrDFPerc"));//DF5
				arrRow.add(arrPWC);//6
				arrRow.add(arrPWB);//7
				
				arrRow.add(hshDF.get("NBF"));//NWB//8
				hshRecord.put("arrBCR",hshDF.get("arrBCR"));
				hshRecord.put("DFPERC",hshDF.get("DFPERC"));

				arrRow.add(hshDF.get("arrDFNXT"));//DFNXT//9
				arrRow.add(hshDF.get("NBFNXT"));//NWBNXT//10
				hshRecord.put("arrBCRNXT",hshDF.get("arrBCRNXT"));
				hshRecord.put("DFNXT",hshDF.get("DFNXT"));
				hshRecord.put("IRR",hshDF.get("IRR"));//IRR

				hshRecord.put("arrRow",arrRow);
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in calculateFinancialAnalysisByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in calculateFinancialAnalysisByAppno === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
	
	}
	
	public HashMap getDairyTotIncomeExpByAppno(String strAppNo,String schemetype,String strFacSNo)throws Exception
	{
		
			HashMap hshRecord=new HashMap();

			ArrayList arrIncome=new ArrayList();
		
		
			ArrayList arrRow=new ArrayList();
			ResultSet rs=null;
			ArrayList arrExpTot= null;
			ArrayList arrRecExp=new ArrayList();
			ArrayList arrCapExp=new ArrayList();
			AgrFarmMachineryBO agrDariyIncomeExpenditure=new AgrFarmMachineryBO();
			try 
			{				
				
				
				if(rs!=null){rs.close();}
				rs=DBUtils.executeLAPSQuery("agr_dairycostofinvestment_adult_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next()) 
		  		{
					arrCapExp.add(FwHelper.correctDouble(rs.getString("agr_totunitcost")));	//year 1
					arrCapExp.add("0.00");//year 2
					arrCapExp.add("0.00");//year 3
					arrCapExp.add("0.00");//year 4
					arrCapExp.add("0.00");//year 5
					arrCapExp.add("0.00");//year 6
		  		}
				else
				{
					arrCapExp.add("0.00");//year 1
					arrCapExp.add("0.00");//year 2
					arrCapExp.add("0.00");//year 3
					arrCapExp.add("0.00");//year 4
					arrCapExp.add("0.00");//year 5
					arrCapExp.add("0.00");//year 6
				}
				arrIncome=agrDariyIncomeExpenditure.getDairyDevInc(strAppNo,schemetype,strFacSNo);
				arrRecExp=agrDariyIncomeExpenditure.getDairyDevExp(strAppNo,schemetype,strFacSNo);
				//arrExpTot=addCapitalcostMaintenanceCost(arrRecExp, arrCapExp);
			
						
				
				//arrRow.add(arrCapExp);
				arrRow.add(arrRecExp);
				arrRow.add(arrIncome);
				arrRow.add(subNetIncomeCost(arrIncome, arrRecExp));
				hshRecord.put("arrIncome",arrIncome);
				hshRecord.put("arrCapExp",arrCapExp);
				hshRecord.put("arrRecExp",arrRecExp);
				//hshRecord.put("arrExpTot",arrRecExp);
				hshRecord.put("arrNetBenefit",subNetIncomeCost(arrIncome, arrRecExp));
				hshRecord.put("arrRow",arrRow);
				
			} catch (Exception e) {
				if(rs!=null){rs.close();}
				log.error("Error in getDairyTotIncomeExpByAppno AgrNurseryBO::" +e.getMessage());
				throw new EJBException("Error in getDairyTotIncomeExpByAppno === AgrNurseryBO"+e.toString());
			}
			return hshRecord;
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}