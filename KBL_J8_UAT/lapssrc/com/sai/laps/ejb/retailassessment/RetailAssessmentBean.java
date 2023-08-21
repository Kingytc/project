package com.sai.laps.ejb.retailassessment;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.agrotherassets.agrotherBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RetailAssessmentBean", mappedName = "RetailAssessmentHome")
@Remote (RetailAssessmentRemote.class)
public class RetailAssessmentBean extends BeanAdapter{

	static Logger log=Logger.getLogger(RetailAssessmentBean.class);
	public  HashMap getCommonAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshResult=new HashMap();
		HashMap hshRecord=new HashMap();
		String strPrdType="",strAppStatus="",strEligibleLoanAmt="",strQuery="",strPrdPurpose="",strStaffPrd="",strAmtRequested="";
		double dbl_eligible_based_cost=0.00;
		ResultSet rs=null;
		try
		{
			strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
			strAppStatus=Helper.correctNull((String)hshValues.get("strappstatus"));
			String strAppNo=correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(rs!=null){
				rs.close(); 
			}
			strQuery = SQLParser.getSqlQuery("sel_prdloantype^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPrdPurpose=Helper.correctNull(rs.getString("prd_purpose"));
				strStaffPrd=Helper.correctNull(rs.getString("prd_staffprd"));
				if("".equalsIgnoreCase(Helper.correctNull((String)hshValues.get("prdcode"))))
				{
					hshValues.put("prdcode",Helper.correctNull(rs.getString("prd_code")));
				}
			}
			if(strPrdType.equals("pA"))
			{
					hshResult=updateVehicleAssessment(hshValues);
					dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
					strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
			}
			else if(strPrdType.equals("pH")&& (strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T"))||strPrdPurpose.equalsIgnoreCase("HC"))
			{
				hshResult=updateHouseAssessment(hshValues);
				strEligibleLoanAmt=Helper.correctDouble((String)hshResult.get("strEligibleLoanAmt"));
			}
			else if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equals("DIGI") && strPrdType.equals("pM"))
			{
				hshResult=updateHouseAssessment(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				strEligibleLoanAmt=Helper.correctDouble((String)hshResult.get("strEligibleLoanAmt"));
				hshResult.put("hshInc", update_Income_Based_Assessment(hshValues));
				hshRecord= (HashMap) hshResult.get("hshInc");
				strEligibleLoanAmt=Helper.correctDouble((String)hshRecord.get("strEligibleLoanAmt"));
			}
			else if((strPrdType.equals("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")))||(strPrdType.equals("pM"))||strPrdPurpose.equalsIgnoreCase("HC"))
			{
				hshResult=updateHouseAssessment(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				hshResult.put("hshInc", update_Income_Based_Assessment(hshValues));
				//hshRecord=update_Income_Based_Assessment(hshValues);
				hshRecord= (HashMap) hshResult.get("hshInc");
				strEligibleLoanAmt=Helper.correctDouble((String)hshRecord.get("strEligibleLoanAmt"));
			}
			else if(strPrdType.equals("pG"))
			{
				hshResult=updateGoldAssessment(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
			}
			else if(strPrdType.equals("pP"))
			{
				hshResult.put("hshInc", update_Income_Based_Assessment(hshValues));
				//hshRecord=update_Income_Based_Assessment(hshValues);
				hshRecord= (HashMap) hshResult.get("hshInc");
				strEligibleLoanAmt=Helper.correctDouble((String)hshRecord.get("strEligibleLoanAmt"));
			}
			else if(strPrdType.equals("pU"))
			{
				hshResult=updateMahilaUdyogAssessment(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				strEligibleLoanAmt=strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
				
				
				//hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				//strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
			}
			else if(strPrdType.equals("pR"))
			{
				hshResult=updateDepositAssessment(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
			}
			
			else if(strPrdType.equalsIgnoreCase("pk"))
			{
				hshResult=updateRavikirandate(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);
			}
			else if(strPrdType.equalsIgnoreCase("pE"))
			{
				hshResult=updateEducationloandate(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				strEligibleLoanAmt=jtn.format(dbl_eligible_based_cost);	
			}
			
			else if((strPrdType.equalsIgnoreCase("pL"))||(strPrdType.equalsIgnoreCase("pI")))
			{
				hshResult=updateLeasencashdata(hshValues);
				strEligibleLoanAmt=Helper.correctDouble((String)hshResult.get("strEligibleLoanAmt"));
			}
			else if(strPrdType.equalsIgnoreCase("pV"))
			{
				hshResult=updateSuvidhadata(hshValues);
				dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshResult.get("EligibleBasedonCost")));
				hshValues.put("eligible_based_cost", jtn.format(dbl_eligible_based_cost));
				hshResult.put("hshInc", update_Income_Based_Assessment(hshValues));
				hshRecord= (HashMap) hshResult.get("hshInc");
				//hshRecord=update_Income_Based_Assessment(hshValues);
				strEligibleLoanAmt=Helper.correctDouble((String)hshRecord.get("strEligibleLoanAmt"));
			}
			else if(strPrdType.equalsIgnoreCase("pS"))
			{
				hshResult=updateLoanAgainstshareData(hshValues);
				strEligibleLoanAmt=Helper.correctDouble((String)hshResult.get("strEligibleLoanAmt"));
			}
			else if(strPrdType.equalsIgnoreCase("pB"))
			{
				hshResult=updateBusinessLoanData(hshValues);
				strEligibleLoanAmt=Helper.correctDouble((String)hshResult.get("strEligibleLoanAmt"));
			}
			
			if(rs!=null){
				rs.close(); 
			}
			strQuery=SQLParser.getSqlQuery("sel_attachedsecurities_retail^"+strAppNo);
    		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("strSecuirtyFlag","N");
			}
		
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			if(!Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppNo);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delmpbfeligibleamount");
				hshQueryValues.put("1", hshQuery);				
				hshQuery = new HashMap();
				arrValues = new ArrayList();				
				hshQuery.put("strQueryId", "insertmpbfeligibleamount");
				arrValues.add(strAppNo);
				arrValues.add(strEligibleLoanAmt);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			hshResult.put("strStaffPrd", strStaffPrd);
			
			
			if(strPrdType.equalsIgnoreCase("pH"))
			{
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("selproposed_assetsum^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strPurchseplotprice",Helper.correctDouble(rs.getString("Purchseplotprice")));
					hshResult.put("strConstructioncost",Helper.correctDouble(rs.getString("Constructioncost")));
					hshResult.put("strEstimatedcost",Helper.correctDouble(rs.getString("Estimatedcost")));
					hshResult.put("strPurchasebuiltprice",Helper.correctDouble(rs.getString("Purchasebuiltprice")));
					hshResult.put("strSitePurchaseprice",Helper.correctDouble(rs.getString("SitePurchaseprice")));
				}
				
				//digi application
				if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equals("DIGI"))
				{
					if(!strPrdPurpose.equals("F") && !strPrdPurpose.equals("T")&& !strPrdPurpose.equals("HC"))
					{
					hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					
					if(rs!=null)
						rs.close();
					strQuery = SQLParser.getSqlQuery("selperprdmargin^"+strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strAmtRequested = Helper.correctDouble(rs.getString("LOAN_AMTREQD"));
					}
					
					if(strPrdPurpose.equalsIgnoreCase("C") || strPrdPurpose.equalsIgnoreCase("R"))
						arrValues.add(Helper.correctDouble((String) hshResult.get("strConstructioncost")));
					else if(strPrdPurpose.equalsIgnoreCase("H"))
						arrValues.add(Helper.correctDouble((String) hshResult.get("strPurchasebuiltprice")));
					else if(strPrdPurpose.equalsIgnoreCase("S"))
						arrValues.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String) hshResult.get("strPurchseplotprice"))) + Double.parseDouble(Helper.correctDouble((String) hshResult.get("strEstimatedcost")))));
					else if(strPrdPurpose.equalsIgnoreCase("G"))
						arrValues.add(Helper.correctDouble((String) hshResult.get("strSitePurchaseprice")));
					
					arrValues.add(strEligibleLoanAmt);
					arrValues.add(strAmtRequested);
					arrValues.add(strAppNo);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "upd_projcostloan_loandet");
					hshQueryValues.put("1", hshQuery);				
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				
				
			}
			else if(strPrdType.equalsIgnoreCase("pA"))
			{
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("selproposedvehsum^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strVehicleAmt",Helper.correctDouble(rs.getString("valuationamt")));
					hshResult.put("strLeastval",Helper.correctDouble(rs.getString("Leastval")));
				}
			}
			else if(strPrdType.equalsIgnoreCase("pB"))
			{
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("sum_gstreturndetails^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strGSTReturnAmt",Helper.correctDouble(rs.getString("gstamount")));
				}
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selperprdmargin^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("strCOP",Helper.correctDouble(rs.getString("loan_costloanprd")));
				hshResult.put("strMLSS",Helper.correctDouble(rs.getString("loan_metlifepremiumamt")));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selectvehicledetails1^A^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("strVehicleType",Helper.correctDouble(rs.getString("auto_category")));
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppNo);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("strHouseFlag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strAppNo);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("strVehicleFlag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strAppNo);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshResult.put("strValuationFlag","N");
				}
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of getCommonAssessment Method "+ce.toString());
		}
		finally
		{
			try
			{
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in RetailAssessment Bean of getCommonAssessment Method "+cf.getMessage());
			}
	}
	return hshResult;
	}
	
	public  HashMap getRepaymentCapacity(HashMap hshValues) 
	{			
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null,rs3=null,rs4=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrRepayCapacity=new ArrayList();
		ArrayList arrRepayCapacitytemp=new ArrayList();
		HashMap hshResult = new HashMap();
		double dbl_income_salaried=0.00,dbl_repay_capacity_amount=0.00,dbl_prop_loan_commitment=0.00,
		dbl_exi_loan_commitment=0.00,dbl_total_annual_commitments=0.00,dbl_total_monthly_commitments=0.00,
		dbl_borr_income=0.00,dbl_repay_capacity_defined=0.00,dbl_add_depreciation_year1=0.00,dbl_add_depreciation_year2=0.00,dbl_add_intonliab_year1=0.00,dbl_add_intonliab_year2=0.00,
		dbl_nonsal_inc_itr1=0.00,dbl_nonsal_inc_itr2=0.00,dbl_year1_nonsal_totalinc=0.00,dbl_year2_nonsal_totalinc=0.00,
		dbl_nonsal_totalinc=0.00,dbl_avg_nonsal_totalinc=0.00,dbl_grossincome_salaried=0.00, dbldeviatedrepay=0.00;
		int int_applicant_occupation=0;
		double dbl_exi_loan_commitmentgar=0.00;
		double dbl_exi_loan_commitmentbar=0.00;
		double dbl_prop_loan_commitmenttot=0.00;
		double dbl_OtherIncome=0.00;
		double dbl_grossincome_salariedyear=0.00;
		double dbl_OtherIncomeyear=0.00;
		double dbl_exi_loan_commitmentyear=0.00;
		double dbl_totandeductions =0.00;
		double dbl_grant_tot=0.00;
		double dbl_apptotDeductions=0.00;
		double dbl_totandeductionstotapp=0.00;
		double sancamount=0.00;
		double loan_interest=0.00;
		String strQuery=null,strGreater=">=",strLesser="<=",strPrdcode="0",strappTitle="",strappid="", strPrdType="", strGrossOrNetSalary="", strIsdeviated="";
		String strAppNewId="";
		dbl_repay_capacity_defined=0.00;
		String staffproduct="";
		String AppIdnew="",strappOldid="";
		double MonthlyIncome=0.00,Monthlydeduction=0.00;
		String stremp_occp="";
		int intRepaymentType=0;
		double dblAnnualAmount=0.0;
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strCoAppID="";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			AppIdnew=correctNull((String)hshValues.get("hidapplicantnewid"));
			if(AppIdnew.equalsIgnoreCase(""))
			{
				AppIdnew=correctNull((String)hshValues.get("hidapplicantid"));
			}
			/**
			 *  Getting Existing Application/Loan Details
			 */
			
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="",strVehicleType="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
			strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				strPrdcode=correctNull((String)rs.getString("prdcode"));
				strappTitle=correctNull(rs.getString("perapp_title"));
				dbl_prop_loan_commitment=rs.getDouble("loan_emi");
				strPrdType=correctNull((String)rs.getString("prd_type"));
				sancamount=Double.parseDouble(Helper.correctDouble((String)rs.getString("sancamount")));
				loan_interest=Double.parseDouble(Helper.correctDouble((String)rs.getString("mintrate")));
				intRepaymentType=Integer.parseInt(Helper.correctInt((rs.getString("loan_repaymenttype"))));
			}
			
			/**
			 * Display of Assessment Based on Income
			 */
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_app_coapp_details^"+appno);
			while(rs.next())
			{
				dbl_income_salaried=0.00;
				dbl_repay_capacity_amount=0.00;
				dbl_exi_loan_commitment=0.00;
				dbl_total_annual_commitments=0.00;
				dbl_borr_income=0.00;
			
				dbl_add_depreciation_year1=0.00;
				dbl_add_depreciation_year2=0.00;
				dbl_add_intonliab_year1=0.00;
				dbl_add_intonliab_year2=0.00;
				dbl_nonsal_inc_itr1=0.00;
				dbl_nonsal_inc_itr2=0.00;
				dbl_year1_nonsal_totalinc=0.00;
				dbl_year2_nonsal_totalinc=0.00;
				dbl_nonsal_totalinc=0.00;
				dbl_avg_nonsal_totalinc=0.00;
				double dbl_otehrexiloandet=0.00;
			    dbl_OtherIncome=0.00;
			    dbl_grossincome_salariedyear=0.00;
			    dbl_OtherIncomeyear=0.00;
				strappid=Helper.correctNull((String)rs.getString("demo_appid"));
				int_applicant_occupation=Integer.parseInt(Helper.correctInt((String)rs.getString("perapp_employment")));
				String strApptype="",strApptypeDesc="",strAppTagId="";
				strApptype=Helper.correctNull((String)rs.getString("demo_type"));
				strappOldid=Helper.correctNull((String)rs.getString("demo_oldappid"));
				strAppTagId=strApptype+strappid;
				
				if(!strApptype.equalsIgnoreCase("a"))
				{
					if(!strCoAppID.equalsIgnoreCase(""))
						strCoAppID+=",'"+strappOldid+"'";
					else
						strCoAppID=strappOldid;
				}
				if(strApptype.equalsIgnoreCase("a"))
				{
					strApptypeDesc="Applicant";

					stremp_occp=Integer.toString(int_applicant_occupation);	
					hshResult.put("stremp_occp", stremp_occp);
					
				} else if(strApptype.equalsIgnoreCase("c")){
					strApptypeDesc="Joint-Applicant";
				} else if(strApptype.equalsIgnoreCase("g")){
					strApptypeDesc="Guarantor";
				}
				else if(strApptype.equalsIgnoreCase("o")){
					strApptypeDesc="Co-Obligant";
				}
				else if(strApptype.equalsIgnoreCase("p")){
					strApptypeDesc="Sole properitier";
				}
			 
			// Retrieving the Salary of Borrower
				
				
				
			if(rs1!=null)
				rs1.close();
			String ITRyear1="",ITRyear2="",strIncomeFiledDate1="";
			rs1=DBUtils.executeLAPSQuery("assesment_sel_borr_income_details_appid^"+strappid);
			if(rs1.next())
			{
				 ITRyear1="";
				 strIncomeFiledDate1="";
				 dbl_income_salaried = rs1.getDouble("perinc_takehome");
				 dbl_nonsal_inc_itr1 = rs1.getDouble("nonsal_itry1");
				 dbl_nonsal_inc_itr2 = rs1.getDouble("nonsal_itry2");
				 dbl_add_depreciation_year1 = rs1.getDouble("depreciation1");
				 dbl_add_depreciation_year2 = rs1.getDouble("depreciation2");
				 dbl_add_intonliab_year1 = rs1.getDouble("intonliab1");
				 dbl_add_intonliab_year2 = rs1.getDouble("intonliab2");
				 dbl_grossincome_salaried= rs1.getDouble("grossincome_salaried");
				 dbl_grossincome_salariedyear=dbl_grossincome_salaried*12;
				 dbl_OtherIncome=rs1.getDouble("perinc_otherincome");
				 dbl_OtherIncomeyear=dbl_OtherIncome*12;
				 ITRyear1=Helper.correctNull((String)rs1.getString("perinc_itrdate1"));
				 strIncomeFiledDate1=Helper.correctNull(rs1.getString("perinc_yearend1"));
				 
				 
			}
			dbl_year1_nonsal_totalinc=dbl_nonsal_inc_itr1+dbl_add_depreciation_year1+dbl_add_intonliab_year1;
			dbl_year2_nonsal_totalinc=dbl_nonsal_inc_itr2+dbl_add_depreciation_year2+dbl_add_intonliab_year2;
			if(dbl_year1_nonsal_totalinc==0||dbl_year2_nonsal_totalinc==0)
			{
				dbl_nonsal_totalinc=dbl_year1_nonsal_totalinc+dbl_year2_nonsal_totalinc;
				dbl_avg_nonsal_totalinc=dbl_nonsal_totalinc;
			}
			else
			{
				dbl_nonsal_totalinc=dbl_year1_nonsal_totalinc+dbl_year2_nonsal_totalinc;
				dbl_avg_nonsal_totalinc=dbl_nonsal_totalinc/2;
			}
			
			if(int_applicant_occupation==1 ||int_applicant_occupation==9)
			{
				dbl_borr_income=dbl_borr_income+dbl_income_salaried;
			} else {
				dbl_borr_income=dbl_borr_income+dbl_avg_nonsal_totalinc;
			}
			
			 strQuery = SQLParser.getSqlQuery("sel_per_otherbankdTL^"+strappOldid);  //other bank Existing loan/s details
			 rs4 = DBUtils.executeQuery(strQuery);
			
			 while(rs4.next())
			 {
				 dbl_otehrexiloandet+= (Double.parseDouble(Helper.correctDouble((String)rs4.getString("perbank_monthly_ins"))));//monthly_ins amount
			 }

			
			/**
			 * Retriving Existing Liablities of Borrower
			 */
			if(rs1!=null)
				rs1.close();
			
			if(strApptype.equalsIgnoreCase("a"))
			{
				rs1=DBUtils.executeLAPSQuery("assesment_sel_borr_liab_details^"+appno);

			}
			else
			{
				rs1=DBUtils.executeLAPSQuery("assesment_sel_other_liab_details^"+appno+"^"+strappOldid);
			}
			if(rs1.next())
			{
				dbl_exi_loan_commitment=rs1.getDouble("exi_monthly_commitment");
			}
				dbl_total_annual_commitments=(dbl_prop_loan_commitment+dbl_exi_loan_commitment)*12;
				if(strApptype.equalsIgnoreCase("a"))
				{
					dbl_total_monthly_commitments=dbl_otehrexiloandet+dbl_exi_loan_commitment;
				}
			
				if(rs2 !=null)
				{
					rs2.close();
				}
				String strProdPurpose1="";
				strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
				rs2 = DBUtils.executeQuery(strQuery);
				if(rs2.next()){strProdPurpose1=Helper.correctNull((String)rs2.getString("prd_purpose"));}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(strProdPurpose1.equalsIgnoreCase("H") || strProdPurpose1.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
				}
				if(rs2 !=null)
				{
					rs2.close();
				}
			rs2 = DBUtils.executeQuery(strQuery);
			if (rs2.next())
			{
				strIsdeviated=correctNull((String)rs2.getString("app_isdeviated"));
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery=SQLParser.getSqlQuery("selrepaycapacity^" + strLesser +"^"+dbl_borr_income+"^"+ strGreater +"^"+dbl_borr_income+"^"+strPrdcode);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				if(strappTitle.equalsIgnoreCase("M/S"))
				{
					dbl_repay_capacity_defined=(100-rs1.getDouble("repay_artificialsustanece"));
					dbl_repay_capacity_amount=((dbl_repay_capacity_defined/100)*dbl_borr_income);
				}
				else
				{
					if(int_applicant_occupation==1 || int_applicant_occupation==9)
					{
						dbl_repay_capacity_defined=(100-rs1.getDouble("repay_salariedsustanece"));
						dbl_repay_capacity_amount=((dbl_repay_capacity_defined/100)*dbl_borr_income);
					} else {
						dbl_repay_capacity_defined=(100-rs1.getDouble("repay_nonsalariedsustanece"));
						dbl_repay_capacity_amount=((dbl_repay_capacity_defined/100)*dbl_borr_income);
					}
				}
				if(strIsdeviated.equalsIgnoreCase("Y"))
				{
					if (rs2!=null)
					{
						rs2.close();
					}
					strQuery = SQLParser.getSqlQuery("Sel_app_deviation^" + appno);
					rs2 = DBUtils.executeQuery(strQuery);
					while (rs2.next())
					{
						String strdeviationtype=correctNull((rs2.getString("deviation_type")));
						String strdeviationstatus=correctNull((rs2.getString("deviation_apprej")));
						if(strdeviationtype.equalsIgnoreCase("RC") && strdeviationstatus.equalsIgnoreCase("A"))
						{
							dbldeviatedrepay=rs2.getDouble("deviation_newvalue");
							if(dbldeviatedrepay>0)
							{
								dbl_repay_capacity_defined=dbldeviatedrepay;
								dbl_repay_capacity_amount=((dbl_repay_capacity_defined/100)*dbl_borr_income);
							}
						}
					}
				}
			}
			if(strPrdType.equalsIgnoreCase("pP") && strApptype.equalsIgnoreCase("a"))
			{
				strGrossOrNetSalary="Gross Salary";
				dbl_income_salaried=dbl_grossincome_salaried;
			}
			else
			{
				strGrossOrNetSalary="Net Salary";
			}
			
			if(rs2!=null){
				rs2.close();
			}
			String strFinancialYear="",strFinancialYear1="",strFinancialYear2="";
			rs2=DBUtils.executeLAPSQuery("selfinancialyear");
			if(rs2.next())
			{
				strFinancialYear=Helper.correctNull((String)rs2.getString("FinancialYear"));
				strFinancialYear1=strFinancialYear.substring(0,5);
				strFinancialYear2=strFinancialYear.substring(7,9);
				strFinancialYear=strFinancialYear1+strFinancialYear2;
			}
			
			String[] strRepay_Capacity_Sal={"Latest Annual Gross Salary","Total Annual Income Eligible for Deductions&nbsp;",
					String.valueOf(nf.format(dbl_repay_capacity_defined))+"% of Total Income&nbsp;","Monthly/Annual Loan Commitment of Proposed loan","Annual Loan Commitment of Existing loan/s","TOTAL Annual loan Commitment is","Any Other Annual Inome"};
			
			String[] strRepay_Capacity_NSal={"Income as per ITR/Declaration of Financial Year "+strIncomeFiledDate1+" filled on ","Depreciation"," Interest of Existing liabilites whose Interest is considered in P&L",
					"Total Annual Income Eligible for Deductions","Income as per ITR/FS/Declaration for the year Ended ","Add: Depreciation","Add: Interest of Existing liabilites whose Interest is considered in P&L",
					"TOTAL Income of Year 2","GRAND TOTAL of Income","Average Income","TOTAL Income eligible for deductions&nbsp;",
					String.valueOf(nf.format(dbl_repay_capacity_defined))+"% of Total Income&nbsp;","Monthly/Annual Loan Commitment of Proposed loan","Annual Loan Commitment of Existing loan/s","TOTAL Annual loan Commitment is"};
			
			if(int_applicant_occupation==1 || int_applicant_occupation==9)
			{
					arrCol=new ArrayList();
					arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname"));
					arrCol.add("");
					arrRepayCapacity.add(arrCol);
					
					if(!strPrdType.equalsIgnoreCase("pP"))
					{
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[0]);
					arrCol.add(nf.format(dbl_grossincome_salariedyear));
					arrRepayCapacity.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[6]);
					arrCol.add(nf.format(dbl_OtherIncomeyear));
					arrRepayCapacity.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[1]);
					dbl_totandeductions=dbl_grossincome_salariedyear+dbl_OtherIncomeyear;
					arrCol.add(nf.format(dbl_totandeductions));
					dbl_totandeductionstotapp=dbl_totandeductionstotapp+dbl_totandeductions;
					arrRepayCapacity.add(arrCol);
					}
					
			  if(strPrdType.equalsIgnoreCase("pP"))
				{
				  strQuery = SQLParser.getSqlQuery("sel_perincomedetails^"+appno);
					 rs3 = DBUtils.executeQuery(strQuery);
					 if(rs3.next())
					 {
						 
						 dbl_grossincome_salariedyear	=(((Double.parseDouble(Helper.correctDouble((String)rs3.getString("perinc_basicsalary"))))
						+(Double.parseDouble(Helper.correctDouble((String)rs3.getString("perinc_da"))))
					   +(Double.parseDouble(Helper.correctDouble((String)rs3.getString("perinc_alloweligible")))))*12);
						
						
					 }
					    arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_Sal[0]);
						arrCol.add(nf.format(dbl_grossincome_salariedyear));
						arrRepayCapacity.add(arrCol);
					 
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_Sal[1]);
						dbl_totandeductions=dbl_grossincome_salariedyear;
						arrCol.add(nf.format(dbl_totandeductions));
						dbl_totandeductionstotapp=dbl_totandeductions;
						arrRepayCapacity.add(arrCol);
					
				}
					
					
					/*arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[2]);
					arrCol.add(nf.format(dbl_repay_capacity_amount));
					arrRepayCapacity.add(arrCol);*/
					
					/*arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[3]);
					arrCol.add(nf.format(dbl_prop_loan_commitment));
					arrRepayCapacity.add(arrCol);*/
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[4]);
					dbl_exi_loan_commitmentyear=((dbl_exi_loan_commitment*12)+(dbl_otehrexiloandet*12));
					arrCol.add(nf.format(dbl_exi_loan_commitmentyear));
					dbl_exi_loan_commitmentgar=((dbl_otehrexiloandet*12)+dbl_exi_loan_commitmentgar);//added by ganesan for total Loan Commitment of Existing loan/s+ (otherexisting loan details *12)
					arrRepayCapacity.add(arrCol);
					
					/*arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_Sal[5]);
					arrCol.add(nf.format(dbl_total_annual_commitments));
					arrRepayCapacity.add(arrCol);*/
					
			}else if(int_applicant_occupation==10) {
					
					arrCol=new ArrayList();
					arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname")+" is a Student");
					arrCol.add("");
					arrRepayCapacity.add(arrCol);
			} else{
					arrCol=new ArrayList();
					arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname"));
					arrCol.add("");
					arrRepayCapacity.add(arrCol);
				
					if(dbl_year1_nonsal_totalinc>0)
					{
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[0]+""+ITRyear1);
						arrCol.add(nf.format(dbl_nonsal_inc_itr1));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[1]);
						arrCol.add(nf.format(dbl_add_depreciation_year1));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[2]);
						arrCol.add(nf.format(dbl_add_intonliab_year1));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[3]);
						dbl_apptotDeductions=dbl_year1_nonsal_totalinc+dbl_apptotDeductions;
						arrCol.add(nf.format(dbl_year1_nonsal_totalinc));
						arrRepayCapacity.add(arrCol);
					}
					
					/*if(dbl_year2_nonsal_totalinc>0)
					{
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[4]);
						arrCol.add(nf.format(dbl_nonsal_inc_itr2));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[5]);
						arrCol.add(nf.format(dbl_add_depreciation_year2));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[6]);
						arrCol.add(nf.format(dbl_add_intonliab_year2));
						arrRepayCapacity.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strRepay_Capacity_NSal[7]);
						arrCol.add(nf.format(dbl_year2_nonsal_totalinc));
						arrRepayCapacity.add(arrCol);
					}
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[8]);
					arrCol.add(nf.format(dbl_nonsal_totalinc));
					arrRepayCapacity.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[9]);
					arrCol.add(nf.format(dbl_avg_nonsal_totalinc));
					arrRepayCapacity.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[10]);
					arrCol.add(nf.format(dbl_avg_nonsal_totalinc));
					arrRepayCapacity.add(arrCol);

					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[11]);
					arrCol.add(nf.format(dbl_repay_capacity_amount));
					arrRepayCapacity.add(arrCol);*/

					arrCol=new ArrayList();
				//	arrCol.add(strRepay_Capacity_NSal[12]);
					arrCol.add(nf.format(dbl_prop_loan_commitment));
					//dbl_prop_loan_commitmenttot=dbl_prop_loan_commitment;
				//	arrRepayCapacity.add(arrCol);

					arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[13]);
					dbl_exi_loan_commitmentyear=((dbl_exi_loan_commitment*12)+(dbl_otehrexiloandet*12));
					arrCol.add(nf.format(dbl_exi_loan_commitmentyear));
					dbl_exi_loan_commitmentbar=((dbl_otehrexiloandet*12)+dbl_exi_loan_commitmentyear);//added by ganesan for Monthly/Annual Loan Commitment of Existing loan/s
					arrRepayCapacity.add(arrCol);
					
					/*arrCol=new ArrayList();
					arrCol.add(strRepay_Capacity_NSal[14]);
					arrCol.add(nf.format(dbl_total_annual_commitments));
					arrRepayCapacity.add(arrCol);*/
			}
			}
			double Amountreq=0.00;
			int Repaymentperiod=0,Holidayperiod=0;
			
			if(rs != null)
			{rs.close();}
			rs=DBUtils.executeLAPSQuery("selreqamtandinstall^"+appno);	
			if(rs.next())
			{
				Amountreq=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
				Repaymentperiod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_reqterms")));
				Holidayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_noofinstallment")));
				Repaymentperiod=Repaymentperiod-Holidayperiod;
			}
			
			if(int_applicant_occupation==4 && intRepaymentType!=1)
			{
				int intInstallment=0,intRepay=0,intRepayCount=0,intRequired=0;
				String strinstallment="";
				double dblPayment=0.0;
				if(rs2!=null)
				{rs2.close();}
				rs2 =  DBUtils.executeLAPSQuery("securesel^"+appno);
			    if(rs2.next())
			    {
				   strinstallment=Helper.correctNull(rs2.getString("loan_periodicity"));
			    }
			    
			    if(strinstallment.equalsIgnoreCase("M"))
					intRepay=1;
				else if(strinstallment.equalsIgnoreCase("Q"))
					intRepay=3;
				else if(strinstallment.equalsIgnoreCase("H"))
					intRepay=6;
				else if(strinstallment.equalsIgnoreCase("Y"))
					intRepay=12;
			    
				if(rs2!=null)
				{rs2.close();}
				strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"+appno+"^1");
				rs2=DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					if(intInstallment==12)
						break;
					
					intRepayCount=Integer.parseInt(Helper.correctInt(rs2.getString("tl_noofinst")));
					intInstallment+=(intRepay*intRepayCount);
					
					if(intInstallment<=12)
					{
						dblAnnualAmount+=Double.parseDouble(Helper.correctDouble(rs2.getString("tl_totalamt")));
					}
					else
					{
						intInstallment=intInstallment-(intRepay*intRepayCount);
						
						int intTemp=12-intInstallment;
						
						if(intTemp<(intRepay*intRepayCount))
						{
							dblPayment=Double.parseDouble(Helper.correctDouble(rs2.getString("tl_totalamt")))/(intRepay*intRepayCount);
							dblAnnualAmount+=(dblPayment*intTemp);
							intInstallment+=intTemp;
						}
						
					}
						
				}
			}
				double dbl_perannualinterest=((sancamount*loan_interest)/100);
				
				double dblEMIAmount=0;
				if(rs2!=null)
				{rs2.close();}
				if(!strCoAppID.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_exliabvalue^"+appno+"^"+appno+"^"+strCoAppID);
					rs2=DBUtils.executeQuery(strQuery);
				}else{
					strQuery = SQLParser.getSqlQuery("assesment_sel_borr_liab_details^"+appno);
					rs2=DBUtils.executeQuery(strQuery);
				}
				if(rs2.next())
				{
					dblEMIAmount=Double.parseDouble(Helper.correctDouble(rs2.getString("exi_monthly_commitment")));
				}
				
				
				double  Totaldbl_exi_loan= dbl_exi_loan_commitmentbar+dbl_exi_loan_commitmentgar+(dblEMIAmount*12);
				double dbl_prop_loan_commitmenttot1=0.00;
				double Totalloan=0.00;
				if(intRepaymentType==13)
					dbl_prop_loan_commitmenttot1=(sancamount/Repaymentperiod)*12;
				else if(intRepaymentType!=1 && int_applicant_occupation!=4)
					dbl_prop_loan_commitmenttot1=(dbl_prop_loan_commitment*12)+dbl_perannualinterest;
				else if(intRepaymentType!=1 && int_applicant_occupation==4)
					dbl_prop_loan_commitmenttot1=dblAnnualAmount;
				else
					dbl_prop_loan_commitmenttot1=dbl_prop_loan_commitment*12;
				
				if(strPrdType.equalsIgnoreCase("pJ")&&Helper.correctNull((String)hshValues.get("schemeCode")).equalsIgnoreCase("OD"))
					dbl_prop_loan_commitmenttot1=dbl_perannualinterest;
				
				if(int_applicant_occupation==4 && !(strPrdType.equalsIgnoreCase("pJ")&&Helper.correctNull((String)hshValues.get("schemeCode")).equalsIgnoreCase("OD")))
					Totalloan=(Totaldbl_exi_loan+dbl_prop_loan_commitmenttot1+dbl_perannualinterest);
				else
					Totalloan=(Totaldbl_exi_loan+dbl_prop_loan_commitmenttot1);
				//double Totalloanyear=(Totalloan*12);
				dbl_grant_tot=dbl_totandeductionstotapp+dbl_apptotDeductions;
				double dbl_whichis =(dbl_grant_tot*dbl_repay_capacity_defined)/100;
				double dbl_perannualtot=0.00;
				if(dbl_grant_tot!=0)
					dbl_perannualtot = ((Totalloan/dbl_grant_tot)*100);
				
				
			        hshResult.put("arrRepayCapacity", arrRepayCapacity);
			        hshResult.put("dbl_grant_tot",nf.format(dbl_grant_tot));
			        hshResult.put("dbl_whichis",nf.format(dbl_whichis));
			        hshResult.put("dbl_repay_capacity_defined",nf.format(dbl_repay_capacity_defined));
			        hshResult.put("dbl_prop_loan_commitmenttot1",nf.format(dbl_prop_loan_commitmenttot1));
					hshResult.put("Totaldbl_exi_loan",nf.format(Totaldbl_exi_loan));
					hshResult.put("Totalloan",nf.format(Totalloan));
					hshResult.put("dbl_perannualtot",nf.format(dbl_perannualtot));
					hshResult.put("dbl_perannualintr",nf.format(dbl_perannualinterest));
					
					for(int i=0;i<arrRepayCapacity.size();i++)
					{
						arrRepayCapacitytemp.add(arrRepayCapacity.get(i));
					}
										
					int flagcount=0;
					if(rs2 != null)
					{rs2.close();}
					strQuery = SQLParser.getSqlQuery("getloanproductdetails^"+appno);
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next())
					{
						staffproduct=correctNull((String)rs2.getString("prd_staffprd"));
					}
					if((staffproduct.equalsIgnoreCase("Y"))&&(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pA")||strPrdType.equalsIgnoreCase("pC")||strPrdType.equalsIgnoreCase("pJ")))
					{
						if(rs != null)
						{rs.close();}
						double HalfMonthlyIncome=0.00;
						double DeductionofMonthlysalary=0.00;
						double ProposedLoancommitment=0.00;
						double LatestDeductions=0.00;
						double Totalloancommitment=0.00;
						double Percentageofloancommitment=0.00;
						double Percentagemonthlydeduction=0.00;
						int tenor_Staff_house=0;
						String staff_under="";
						if(!AppIdnew.equals(""))
						{				 
							rs=DBUtils.executeLAPSQuery("pergetIncome1^"+AppIdnew);	
							if(rs.next())
							{
								MonthlyIncome=Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_monsalary")));
								Monthlydeduction=Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_otherdeduction")));
							}
							HalfMonthlyIncome=MonthlyIncome/2;
							DeductionofMonthlysalary=((Monthlydeduction/MonthlyIncome)*100);
							if(rs != null)
							{rs.close();}
							rs=DBUtils.executeLAPSQuery("selreqamtandinstall^"+appno);	
							if(rs.next())
							{
								Amountreq=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
								Repaymentperiod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_reqterms")));
								Holidayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_noofinstallment")));
								Repaymentperiod=Repaymentperiod-Holidayperiod;
							}
							strQuery = SQLParser.getSqlQuery("sel_staffprd^"+strPrdcode);			
							rs =DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								staff_under=correctNull((String)rs.getString("prd_staffprd"));
								if(staff_under.equalsIgnoreCase("Y")){
									tenor_Staff_house=Integer.parseInt(Helper.correctInt((String)rs.getString("PRD_STAFF_MAXTERM_PRIN")));
								}else{
									tenor_Staff_house=1;
								}
							}
							if(rs!=null){
								rs.close();
							}
							ProposedLoancommitment=(Amountreq/Repaymentperiod);
							if(staffproduct.equalsIgnoreCase("Y") && (strPrdType.equalsIgnoreCase("pH") || strPrdType.equalsIgnoreCase("pA")))
							{
								tenor_Staff_house=tenor_Staff_house-Holidayperiod;
								ProposedLoancommitment=(Amountreq/tenor_Staff_house);
							}
							LatestDeductions=((ProposedLoancommitment/MonthlyIncome)*100);
							Totalloancommitment=dbl_total_monthly_commitments+Monthlydeduction+ProposedLoancommitment;
							Percentageofloancommitment=((Totalloancommitment/MonthlyIncome)*100);
							Percentagemonthlydeduction=(((dbl_total_monthly_commitments+Monthlydeduction)/MonthlyIncome)*100);
						}
						hshResult.put("MonthlyIncome" ,nf.format(MonthlyIncome));//a
						hshResult.put("HalfMonthlyIncome" ,nf.format(HalfMonthlyIncome));//b
						hshResult.put("Monthlydeduction" ,nf.format(dbl_total_monthly_commitments+Monthlydeduction));//c
						hshResult.put("Percentagemonthlydeduction" ,nf.format(Percentagemonthlydeduction));//d
						hshResult.put("ProposedLoancommitment" ,nf.format(Math.round(ProposedLoancommitment)));//e
						hshResult.put("LatestDeductions" ,nf.format(LatestDeductions));//f
						hshResult.put("Totalloancommitment" ,nf.format(Math.round(Totalloancommitment)));//g
						hshResult.put("Percentageofloancommitment" ,nf.format(Percentageofloancommitment));//h
						hshResult.put("staffproduct" ,staffproduct);
						hshResult.put("strProductType" ,strPrdType);
						
						arrCol=new ArrayList();
						arrCol.add("Assessment Based on Repayment Capacity"); arrCol.add("");
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Latest Monthly  Salary");	arrCol.add(nf.format(MonthlyIncome));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("50 % of montly Salary ");	arrCol.add(nf.format(HalfMonthlyIncome));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Monthly Loan Commitment of Existing loan/s");	arrCol.add(nf.format(dbl_total_monthly_commitments+Monthlydeduction));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Percentage of Deduction to Latest Monthly Salary");	arrCol.add(nf.format(Percentagemonthlydeduction));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Monthly Loan Commitment of Proposed loan");	arrCol.add(nf.format(Math.round(ProposedLoancommitment)));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Percentage of Deduction to Latest Monthly Salary");	arrCol.add(nf.format(LatestDeductions));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Total monthly Loan Commitment is");	arrCol.add(nf.format(Math.round(Totalloancommitment)));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Percentage of Total monthly  loan Commitment to Total monthly salary");	arrCol.add(nf.format(Percentageofloancommitment));
						arrRepayCapacitytemp.add(arrCol);
						
						flagcount++;
					}
					if(strPrdType.equalsIgnoreCase("pP")&& !(stremp_occp.equalsIgnoreCase("1")||stremp_occp.equalsIgnoreCase("9")))
					{
						double Max_deduct=0.00;
						double Total_loanCommitment=0.00;
						double Loan_commitment_percentage=0.00;
						Max_deduct=(dbl_borr_income*60)/100;
						Total_loanCommitment=Totaldbl_exi_loan+dbl_prop_loan_commitmenttot1;
						Loan_commitment_percentage=(Total_loanCommitment/dbl_borr_income)*100;
						hshResult.put("Gross_Income",nf.format(dbl_borr_income));//a
						hshResult.put("Max_per_deduct",nf.format(Max_deduct));
						hshResult.put("Existingloan_commitment",nf.format(Totaldbl_exi_loan));
						hshResult.put("Annual_loan_commitment_proposed",nf.format(dbl_prop_loan_commitmenttot1));
						hshResult.put("Total_annual_commitment",nf.format(Total_loanCommitment));
						hshResult.put("dbl_perannualtot",nf.format(Loan_commitment_percentage));
					
						
						arrCol=new ArrayList();
						arrCol.add("Assessment Based on Repayment Capacity"); arrCol.add("");
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Latest Gross Annual income"); arrCol.add(nf.format(dbl_borr_income));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Maximum Permissible Deductions (%)"); arrCol.add(nf.format(Max_deduct));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Annual Loan Commitment of Existing loan/s"); arrCol.add(nf.format(Totaldbl_exi_loan));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Annual Loan Commitment of Proposed loan");	arrCol.add(nf.format(dbl_prop_loan_commitmenttot1));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Total Annual Loan Commitment is");	arrCol.add(nf.format(Total_loanCommitment));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Percentage of Annual Total loan Commitment to Total Annual Income"); arrCol.add(nf.format(Loan_commitment_percentage));
						arrRepayCapacitytemp.add(arrCol);
						
						flagcount++;
					}
					
					if(flagcount==0)
					{
						arrCol=new ArrayList();
						arrCol.add("Assessment Based on Repayment Capacity"); arrCol.add("");
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Grand Total Income Eligible for Deductions"); arrCol.add(nf.format(dbl_grant_tot));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add(dbl_repay_capacity_defined+"% odasgdsgdsich is"); arrCol.add(nf.format(dbl_whichis));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Annual Loan Commitment of Proposed loan");	arrCol.add(nf.format(dbl_prop_loan_commitmenttot1));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Annual Loan Commitment of Existing loan/s"); arrCol.add(nf.format(Totaldbl_exi_loan));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Total Annual Loan Commitment is");	arrCol.add(nf.format(Totalloan));
						arrRepayCapacitytemp.add(arrCol);
						arrCol=new ArrayList();
						arrCol.add("Percentage of Annual Total loan Commitment to Total Annual Income"); arrCol.add(nf.format(dbl_perannualtot));
						arrRepayCapacitytemp.add(arrCol);
					}
					
					
					if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
					 {
							ArrayList arrValuesCol = new ArrayList();
							int intUpdatesize=1;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							arrValues.add(appno);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","del_per_assessment_details");
							hshQueryValues.put("1",hshQuery);
							int intsize=2;
							for(int i=0;i<arrRepayCapacitytemp.size();i++)
							{
								arrValuesCol= (ArrayList) arrRepayCapacitytemp.get(i);
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize++;
								arrValues.add(appno);
								arrValues.add("1");
								arrValues.add(Integer.toString(i+1));
								arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
								arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>",""));
								//arrValues.add("C");
								if(((String)arrValuesCol.get(1)).equals(""))
								{
									arrValues.add("H");
								}
								else
								{
									arrValues.add("C");
								}
								arrValues.add("RC");
								hshQuery.put("arrValues",arrValues);	
								hshQuery.put("strQueryId","ins_per_assessment_details");
								hshQueryValues.put(Integer.toString(intsize),hshQuery);
								intsize++;
							}
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					 }
					
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of getRepaymentCapacity Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of getRepaymentCapacity Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	private  HashMap updateVehicleAssessment(HashMap hshValues) 
	{			
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();
		double dbl_auto_valuation=0.00,dbl_auto_tax=0.00,dbl_auto_insurance=0.00,
		dbl_auto_total_cost=0.00,dbl_loan_limit_defined=0.00,dbl_loan_eligible_limit=0.00,
		dbl_auto_second_hand_valuation=0.00,dbl_auto_actual_payable=0.00,dbl_auto_least_value=0.00,dbl_auto_second_value=0.0,
		dbl_limitofloan_sal=0.00,dbl_incbased_eligible_limit=0.00,dbl_loan_range_to=0.00,
		dbl_income_salaried=0.00,dbl_income_nonsalaried=0.00,dbl_add_depreciation_year1=0.00,dbl_add_depreciation_year2=0.00,
		dbl_add_intonliab_year1=0.00,dbl_add_intonliab_year2=0.00,dbl_nonsal_inc_itr1=0.00,dbl_nonsal_inc_itr2=0.00,
		dbl_year1_nonsal_totalinc=0.00,dbl_year2_nonsal_totalinc=0.00,dbl_nonsal_totalinc=0.00,dbl_avg_nonsal_totalinc=0.00,
		dbl_limitofloan_nonsal=0.00,dbl_nonsal_eligible_limit=0.00,dbl_tot_elig_based_inc=0.00,dbl_other_accessories=0.0,
		dbl_other_charges=0.0,dbl_discount=0.0;
		int int_auto_type=0,int_applicant_occupation=0;
		String strQuery=null,strappid="",strInsCompName="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		double dbl_SancAmount=0.00,dblInsurance=0.0,dbl_auto_least_value1=0.0;
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			/**
			 *  Getting Proposed Asset Details
			 */
			strQuery = SQLParser.getSqlQuery("selectvehicledetails1^A^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				int_auto_type=rs.getInt("auto_category");
				dbl_auto_valuation=dbl_auto_valuation+rs.getDouble("auto_valuation");
				dbl_auto_second_hand_valuation =dbl_auto_second_hand_valuation+ rs.getDouble("auto_valuationentry");
				dbl_auto_actual_payable=dbl_auto_actual_payable+rs.getDouble("auto_actualconsideration");
				dbl_auto_second_value=dbl_auto_second_value+rs.getDouble("auto_originalcost");
				dbl_auto_least_value=Math.min(dbl_auto_second_hand_valuation, dbl_auto_actual_payable);
				dbl_auto_least_value=Math.min(dbl_auto_second_value, dbl_auto_least_value);
				dbl_auto_tax=dbl_auto_tax+rs.getDouble("auto_tax");
				dbl_auto_insurance=dbl_auto_insurance+rs.getDouble("auto_insurance");
				dbl_other_accessories=dbl_other_accessories+rs.getDouble("auto_accessories");
//				dbl_other_charges=rs.getDouble("auto_charges");
				dbl_discount=dbl_discount+rs.getDouble("auto_discount");
			}
			dbl_auto_total_cost=dbl_auto_valuation+dbl_auto_tax+dbl_auto_insurance+dbl_other_accessories+dbl_other_charges-dbl_discount;
			/**
			 * Calculating Limit of Loan
			 */
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
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				dbl_loan_limit_defined=100-rs.getDouble("loan_margin");
				dbl_limitofloan_sal=rs.getDouble("income_limit_employed");
				dbl_limitofloan_nonsal=rs.getDouble("income_limit_self_employed");
				dbl_loan_range_to=rs.getDouble("rangeto");
				dbl_SancAmount= Double.parseDouble(Helper.correctDouble((String)rs.getString("amtreqd"))); //added by gaensan for Limit applied field
				dblInsurance= Double.parseDouble(Helper.correctDouble(rs.getString("loan_metlifepremiumamt"))); 
				if(Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
					dblInsurance=0;
				
				dbl_auto_total_cost+=dblInsurance;
				dbl_auto_least_value1=dbl_auto_least_value;
				dbl_auto_least_value+=dblInsurance;
				
				if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					if(rs1.next())
					{
						strInsCompName=Helper.correctNull(rs1.getString("stat_data_desc1"));
					}
				}
			}
			
			/**
			 * Retriving the occupation of Borrower
			 */
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("pergetempstatus^"+appno);
			if(rs.next())
			{
				int_applicant_occupation=rs.getInt("perapp_employment");
				hshResult.put("occupation_type", Integer.toString(int_applicant_occupation));
			}
			/**
			 * Calculation of Eligible Limit
			 */
			if(int_auto_type==2)
			{
				dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_least_value;
			} else {
				dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_total_cost;
			}
			
			/**
			 * Display of Assessment Based on Cost
			 */
			arrCol=new ArrayList();
			arrCol.add("<b>Limit Applied [1]</b>");
			arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
			arrRow.add(arrCol);
			
			String[] strLine_NewVeh_Desc={"Cost of Vehicle ","Add: Road Tax","Price For Accessories/Body Building","Add:Insurance","Discount",strInsCompName,"TOTAL Cost [2]",
					"<b>Limit Eligible ["+nf.format(dbl_loan_limit_defined)+"% of Total Cost]&nbsp;[3]</b>",String.valueOf(nf.format(dbl_auto_valuation)),
					String.valueOf(nf.format(dbl_auto_tax)),nf.format(dbl_other_accessories),
					String.valueOf(nf.format(dbl_auto_insurance)),nf.format(dbl_discount),nf.format(dblInsurance),String.valueOf(nf.format(dbl_auto_total_cost)),
					String.valueOf(nf.format(dbl_loan_eligible_limit))};
			
			String[] strLine_OldVeh_Desc={"Value as per valuation","Original Cost of the Vehicle","Actual Consideration paid by purchaser","Least of above three",
					strInsCompName+" [b]","Total Cost  (a+b) [2]","<b>Limit Eligible ["+nf.format(dbl_loan_limit_defined)+" % of Total Cost]&nbsp;<b>[3]</b>",String.valueOf(dbl_auto_second_hand_valuation),
					nf.format(dbl_auto_second_value),String.valueOf(dbl_auto_actual_payable),String.valueOf(dbl_auto_least_value1),nf.format(dblInsurance),nf.format(dbl_auto_least_value),String.valueOf(dbl_loan_eligible_limit)};
			
			if(int_auto_type==1)
			{
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[0]);
				arrCol.add(nf.format(dbl_auto_valuation));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[1]);
				arrCol.add(nf.format(dbl_auto_tax));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[2]);
				arrCol.add(nf.format(dbl_other_accessories));
				arrRow.add(arrCol);
				
				
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[3]);
				arrCol.add(nf.format(dbl_auto_insurance));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[4]);
				arrCol.add(nf.format(dbl_discount));
				arrRow.add(arrCol);
				
				if(dblInsurance>0)
				{
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[5]);
					arrCol.add(nf.format(dblInsurance));
					arrRow.add(arrCol);
				}
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[6]);
				arrCol.add(nf.format(dbl_auto_total_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_NewVeh_Desc[7]);
				arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
				arrRow.add(arrCol);
			} else {
				arrCol=new ArrayList();
				arrCol.add(strLine_OldVeh_Desc[0]);
				arrCol.add(nf.format(dbl_auto_second_hand_valuation));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_OldVeh_Desc[1]);
				arrCol.add(nf.format(dbl_auto_second_value));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_OldVeh_Desc[2]);
				arrCol.add(nf.format(dbl_auto_actual_payable));
				arrRow.add(arrCol);	
				
				
				if(dblInsurance>0)
				{
					arrCol=new ArrayList();
					strLine_OldVeh_Desc[3]=strLine_OldVeh_Desc[3]+" [a]";
					arrCol.add(strLine_OldVeh_Desc[3]);
					arrCol.add(nf.format(dbl_auto_least_value1));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[4]);
					arrCol.add(nf.format(dblInsurance));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[5]);
					arrCol.add(nf.format(dbl_auto_least_value));
					arrRow.add(arrCol);	
				}
				else
				{
					arrCol=new ArrayList();
					strLine_OldVeh_Desc[3]=strLine_OldVeh_Desc[3]+" [2]";
					arrCol.add(strLine_OldVeh_Desc[3]);
					arrCol.add(nf.format(dbl_auto_least_value1));
					arrRow.add(arrCol);
					
				}
				
				
				arrCol=new ArrayList();
				arrCol.add(strLine_OldVeh_Desc[6]);
				arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
				arrRow.add(arrCol);
				
			}
			
			dbl_loan_eligible_limit=Math.min(dbl_SancAmount, dbl_loan_eligible_limit);
			arrCol=new ArrayList();
			arrCol.add("<b>MPBF (Maximum Permissable Bank Finance] [Least of 1,3]</b>");
			arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
			arrRow.add(arrCol);
			
			hshResult.put("arrAssessment", arrRow);
			hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_loan_eligible_limit)));
			/**
			 * Updation in Table
			 */
		
			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			 {
					ArrayList arrValuesCol = new ArrayList();
					int intUpdatesize=1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(appno);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_per_assessment_details");
					hshQueryValues.put("1",hshQuery);
					int intsize=2;
					for(int i=0;i<arrRow.size();i++)
					{
						arrValuesCol= (ArrayList) arrRow.get(i);
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						arrValues.add(appno);
						arrValues.add("1");
						arrValues.add(Integer.toString(i+1));
						arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
						arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>",""));
						//arrValues.add("C");
						if(((String)arrValuesCol.get(1)).equals(""))
						{
							arrValues.add("H");
						}
						else
						{
							arrValues.add("C");
						}
						arrValues.add("C");
						hshQuery.put("arrValues",arrValues);	
						hshQuery.put("strQueryId","ins_per_assessment_details");
						hshQueryValues.put(Integer.toString(intsize),hshQuery);
						intsize++;
					}
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			 }
//			else
//			{
//				int intUpdatesize=1;
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				arrValues.add(appno);
//				arrValues.add("1");
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","del_per_assessment_details");
//				hshQueryValues.put("1",hshQuery);
//				int intsize=2;
//				if(int_auto_type==1)
//				{
//					for(int i=0;i<(strLine_NewVeh_Desc.length/2);i++)
//					{
//						if(i==6 && Double.parseDouble(Helper.correctDouble(strLine_NewVeh_Desc[15]))==0)
//						{
//							i+=2;
//							continue;
//						}
//						hshQuery=new HashMap();
//						arrValues=new ArrayList();
//						intUpdatesize++;
//						arrValues.add(appno);
//						arrValues.add("1");
//						arrValues.add(Integer.toString(i+1));
//						arrValues.add(strLine_NewVeh_Desc[i]);
//						arrValues.add(strLine_NewVeh_Desc[i+9]);
//						arrValues.add("C");
//						//arrValues.add("V");
//						hshQuery.put("arrValues",arrValues);	
//						hshQuery.put("strQueryId","ins_per_assessment_details");
//						hshQueryValues.put(Integer.toString(intsize),hshQuery);
//						intsize++;
//					}
//				} 
//				else
//				{
//					for(int i=0;i<(strLine_OldVeh_Desc.length/2);i++)
//					{
//						if(i==4 && Double.parseDouble(Helper.correctDouble(strLine_OldVeh_Desc[11]))==0)
//						{
//							i+=1;
//							continue;
//						}
//						hshQuery=new HashMap();
//						arrValues=new ArrayList();
//						intUpdatesize++;
//						arrValues.add(appno);
//						arrValues.add("1");
//						arrValues.add(Integer.toString(i+1));
//						arrValues.add(strLine_OldVeh_Desc[i]);
//						arrValues.add(strLine_OldVeh_Desc[i+7]);
//						arrValues.add("C");
//						//arrValues.add("V");
//						hshQuery.put("arrValues",arrValues);	
//						hshQuery.put("strQueryId","ins_per_assessment_details");
//						hshQueryValues.put(Integer.toString(intsize),hshQuery);
//						intsize++;
//					}
//				}
//				hshQueryValues.put("size",Integer.toString(intUpdatesize));
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//			}
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of updateVehicleAssessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of updateVehicleAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	private  HashMap getVehicleAssessment(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		HashMap hshInc = new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			rs=DBUtils.executeLAPSQuery("sel_per_assessment_details^"+appno+"^1^C");
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(rs.getString("ass_det_desc"));
				arrCol.add(rs.getDouble("ass_det_value"));
				arrRow.add(arrCol);
			}
			hshResult.put("arrAssessment", arrRow);
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_per_assessment_details^"+appno+"^1^I");
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(rs.getString("ass_det_desc"));
				arrCol.add(rs.getDouble("ass_det_value"));
				arrRow.add(arrCol);
			}
			hshInc.put("arrIncAssessment", arrRow);
			hshResult.put("hshInc", hshInc);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of getVehicleAssessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of getVehicleAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	private HashMap updateHouseAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null,rs1=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strAppNo="",strInsCompName="";
		String strLoanPurpose="";
		String strPropType="";
		double dbl_site_market_cost=0.00;
		double dbl_site_purchase_cost=0.00;
		double dbl_site_valuation_cost=0.00;
		double dbl_bldg_market_cost=0.00;
		double dbl_bldg_purchase_cost=0.00;
		double dbl_bldg_valuation_cost=0.00;
		double dbl_cons_estimate_cost=0.00;
		double dbl_bldg_rennovation_cost=0.00;
		double dbl_loan_limit_defined=0.00;
		double dbl_eligible_loan_limit=0.00;
		double dbl_site_eligible_loan_limit=0.00;
		double dbl_bldg_eligible_loan_limit=0.00;
		double dbl_bldg_least_limit=0.00;
		double dbl_site_least_limit=0.00;
		double dbl_mort_market_value=0.00;
		String strPrdType=null;
		String 	strQuery=null;
		double dbl_Securityvalue=0.0;
		double dbl_SancAmount=0.00;
		double dbl_RequestedAmount=0.00;
		double dblMetLifeSuraksha=0.00;
		double dblCollateralpercent=0.00;
		try
		{
			String strProcode=Helper.correctNull((String)hshValues.get("prdcode"));
			strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}
			rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+strAppNo);
			while(rs.next())
			{
				strLoanPurpose=Helper.correctNull((String)rs.getString("phpa_loan_purpose"));
				strPropType=Helper.correctNull((String)rs.getString("phpa_prop_type"));
				dbl_site_market_cost=dbl_site_market_cost+rs.getDouble("phpa_site_market_value");
				dbl_site_purchase_cost=dbl_site_purchase_cost+rs.getDouble("phpa_site_purchase_price");
				dbl_site_valuation_cost=dbl_site_valuation_cost+rs.getDouble("phpa_site_valuation_cost");
				dbl_bldg_market_cost=dbl_bldg_market_cost+rs.getDouble("phpa_bldg_market_value");
				dbl_bldg_purchase_cost=dbl_bldg_purchase_cost+rs.getDouble("phpa_bldg_purchase_price");
				dbl_bldg_valuation_cost=dbl_bldg_valuation_cost+rs.getDouble("phpa_bldg_valuation_cost");
				dbl_cons_estimate_cost=dbl_cons_estimate_cost+rs.getDouble("phpa_bldg_estimate_cost");
				dbl_bldg_rennovation_cost=dbl_bldg_rennovation_cost+rs.getDouble("phpa_constucion_cost");
			}
			
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getloanterms^"+ strAppNo);
			if(rs.next())
			{
				
				//dbl_bldg_rennovation_cost=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_costloanprd")));
				dblMetLifeSuraksha=rs.getDouble("loan_metlifepremiumamt");
				
				if(Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
					dblMetLifeSuraksha=0;
				
				
				if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					if(rs1.next())
					{
						strInsCompName=Helper.correctNull(rs1.getString("stat_data_desc1"));
					}
				}
				
			}
			if(rs !=null)
			{
				rs.close();
			}	
			String strProdPurpose="";

			rs = DBUtils.executeLAPSQuery("selprodpurpose^"+strAppNo);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			
			rs = DBUtils.executeLAPSQuery("sel_assessmentloandetails^"+strAppNo);

			if (rs.next()) {
				dbl_loan_limit_defined=100-rs.getDouble("loan_margin");
				dbl_SancAmount= Double.parseDouble(Helper.correctDouble(rs.getString("recmdamt"))); //added by gaensan for Limit applied field
				dbl_RequestedAmount= Double.parseDouble(Helper.correctDouble(rs.getString("reqamt"))); 
				dblCollateralpercent= 100-Double.parseDouble(Helper.correctDouble(rs.getString("loan_securitycollateral"))); 
			}
			
			if(rs!=null)
				rs.close();
			
			if(strProdPurpose.equals("G"))
			{
				dbl_site_least_limit=Math.min(dbl_site_market_cost, dbl_site_purchase_cost);
				dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_site_least_limit;
				
				arrCol=new ArrayList();
				arrCol.add("Purchase Cost ");
				arrCol.add(nf.format(dbl_site_purchase_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Value as per Valuation");
				arrCol.add(nf.format(dbl_site_market_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Least of Purchase Cost OR Valuation");
				arrCol.add(nf.format(dbl_site_least_limit));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+" </b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					dbl_site_least_limit+=dblMetLifeSuraksha;
					dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_site_least_limit;
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_site_least_limit)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
				
			}
			
			if(strProdPurpose.equals("C"))
			{
				dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_rennovation_cost;
				
				arrCol=new ArrayList();
				arrCol.add("Cost of Construction");
				arrCol.add(nf.format(dbl_bldg_rennovation_cost));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+" </b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					dbl_bldg_rennovation_cost+=dblMetLifeSuraksha;
					dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_rennovation_cost;
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_bldg_rennovation_cost)+"</b>");
					arrRow.add(arrCol);
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
				
			}
			
			if(strProdPurpose.equals("S"))
			{
				dbl_bldg_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_cons_estimate_cost;
				dbl_site_least_limit=Math.min(dbl_site_market_cost, dbl_site_purchase_cost);
				dbl_site_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_site_least_limit;
				dbl_eligible_loan_limit=dbl_site_eligible_loan_limit+dbl_bldg_eligible_loan_limit;
				
				arrCol=new ArrayList();
				arrCol.add("Estimated Cost of Construction");
				arrCol.add(nf.format(dbl_cons_estimate_cost));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					dbl_cons_estimate_cost+=dblMetLifeSuraksha;
					dbl_bldg_eligible_loan_limit=(dbl_loan_limit_defined/100)*(dbl_cons_estimate_cost);
					dbl_eligible_loan_limit=dbl_site_eligible_loan_limit+dbl_bldg_eligible_loan_limit;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_cons_estimate_cost)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[x]</b>");
				arrCol.add("<b>"+nf.format(dbl_bldg_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Purchase Cost of Land");
				arrCol.add(nf.format(dbl_site_purchase_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Value as per Valuation");
				arrCol.add(nf.format(dbl_site_market_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Least of Purchase Cost OR  Valuation");
				arrCol.add(nf.format(dbl_site_least_limit));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[y]</b>");
				arrCol.add("<b>"+nf.format(dbl_site_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("<b>TOTAL Eligible Amount [x+y]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
			}
			
			if(strProdPurpose.equals("H"))
			{
				dbl_bldg_least_limit=Math.min(dbl_bldg_market_cost, dbl_bldg_purchase_cost);
				dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_least_limit;
				
				arrCol=new ArrayList();
				arrCol.add("Purchase Cost of House Property");
				arrCol.add(nf.format(dbl_bldg_purchase_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Market Value of House Property");
				arrCol.add(nf.format(dbl_bldg_market_cost));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Least of Purchase Cost & Market Value");
				arrCol.add(nf.format(dbl_bldg_least_limit));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					
					dbl_bldg_least_limit+=dblMetLifeSuraksha;
					dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_least_limit;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_bldg_least_limit)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
			}
			
			if(strProdPurpose.equals("R"))
			{
				dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_rennovation_cost;
				
				arrCol=new ArrayList();
				arrCol.add("Cost of Renovation");
				arrCol.add(nf.format(dbl_bldg_rennovation_cost));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					
					dbl_bldg_rennovation_cost+=dblMetLifeSuraksha;
					dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_bldg_rennovation_cost;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_bldg_rennovation_cost)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
			}
			
			if(strProdPurpose.equals("M"))
			{
				if(strPropType.equals("L"))
				{
					dbl_mort_market_value=dbl_site_market_cost;
				} else {
					dbl_mort_market_value=dbl_bldg_market_cost;
				}
				dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_mort_market_value;
				
				arrCol=new ArrayList();
				arrCol.add("Market Value of Property");
				arrCol.add(nf.format(dbl_mort_market_value));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					
					dbl_mort_market_value+=dblMetLifeSuraksha;
					dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_mort_market_value;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dbl_mort_market_value)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
			}
			if(strProdPurpose.equals("F"))
			{
				arrRow=new ArrayList();
				double dblPrimary=0.00,dblCollateral=0.00,dblPrimaryEligible=0.00,dblCollateralEligible=0.00;
				double dblminvalue1=0.00,dblminvalue2=0.00;
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("select_securityvalue^"+ strAppNo+"^1");
				if(rs.next())
				{
					
					dblPrimary=Double.parseDouble(Helper.correctDouble((String)rs.getString("secvalue")));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("select_securityvalue^"+ strAppNo+"^2");
				if(rs.next())
				{
					
					dblCollateral=Double.parseDouble(Helper.correctDouble((String)rs.getString("secvalue")));
				}
				
				
				
				dblPrimaryEligible=(dbl_loan_limit_defined/100)*dblPrimary;
				dblCollateralEligible=(dblCollateralpercent/100)*dblCollateral;
				
				arrCol=new ArrayList();
				arrCol.add("Limit Applied [1]");
				arrCol.add(nf.format(dbl_SancAmount));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Project Cost");
				arrCol.add(nf.format(dblPrimary));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					
					dblPrimary+=dblMetLifeSuraksha;
					dblPrimaryEligible=(dbl_loan_limit_defined/100)*dblPrimary;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dblPrimary)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add(dbl_loan_limit_defined+"% which is [2]");
				arrCol.add(nf.format(dblPrimaryEligible));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Property Value");
				arrCol.add(nf.format(dblCollateral));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(dblCollateralpercent+"% which is [3]");
				arrCol.add(nf.format(dblCollateralEligible));
				arrRow.add(arrCol);
				
				dblminvalue1=Math.min(dbl_SancAmount, dblPrimaryEligible);
				dblminvalue2=Math.min(dblCollateralEligible, dblminvalue1);
				
				
				arrCol=new ArrayList();
				arrCol.add("Limit Eligible  - MPBF [Least of 1,2,3]");
				arrCol.add(nf.format(dblminvalue2));
				arrRow.add(arrCol);
				
				hshResult.put("strEligibleLoanAmt", String.valueOf(nf.format(dblminvalue2)));
				
			}
			if(strProdPurpose.equals("T"))
			{
				
				double dblCollateral=0.00,dblCollateralEligible=0.00,dblExistingAmt=0.0,dblOSAmt=0.0,dblAValue=0.0,dblBValue=0.0;
				double dblminvalue1=0.00,dblMaxLimit=0.0;
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_residentialpropertysum1^12^"+ strAppNo);
				if(rs.next())
				{
					
					dblCollateral=Double.parseDouble(Helper.correctDouble(rs.getString("secvalue")));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_productdesc^"+ strProcode);
				if(rs.next())
				{
					
					dblMaxLimit=Double.parseDouble(Helper.correctDouble(rs.getString("prd_rng_to")));
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_existinghousingloanliability^"+ strAppNo);
				if(rs.next())
				{
					
					dblExistingAmt=Double.parseDouble(Helper.correctDouble(rs.getString("combk_limit")));
					dblOSAmt=Double.parseDouble(Helper.correctDouble(rs.getString("combk_os")));
				}
				dblCollateralEligible=(dbl_loan_limit_defined/100)*dblCollateral;
				
				arrCol=new ArrayList();
				arrCol.add("Market Value of the Property (1)");
				arrCol.add(nf.format(dblCollateral));
				arrRow.add(arrCol);
				
				if(dblMetLifeSuraksha!=0.0)
				{
					dblCollateral+=dblMetLifeSuraksha;
					dblCollateralEligible=(dbl_loan_limit_defined/100)*dblCollateral;
					
					arrCol=new ArrayList();
					arrCol.add("<b>"+strInsCompName+"</b>");
					arrCol.add("<b>"+nf.format(dblMetLifeSuraksha)+"</b>");
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("<b>Total Cost</b>");
					arrCol.add("<b>"+nf.format(dblCollateral)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("Eligible Limit is "+nf.format(dbl_loan_limit_defined)+" % of (1)     [A]");
				arrCol.add(nf.format(dblCollateralEligible));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Loan Limit availed under KBL Apna ghar+Elite+Home comfort (2)");
				arrCol.add(nf.format(dblExistingAmt));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Outstanding balance in the account (3)");
				arrCol.add(nf.format(dblOSAmt));
				arrRow.add(arrCol);
				
				dblBValue=dblExistingAmt-dblOSAmt;
				
				arrCol=new ArrayList();
				arrCol.add("Limit Eligible (2)-(3)    [B]");
				arrCol.add(nf.format(dblBValue));
				arrRow.add(arrCol);
				
				dblminvalue1=Math.min(dblBValue, dblCollateralEligible);
				
				arrCol=new ArrayList();
				arrCol.add("Limit eligible  as per Assessment [Least of A,B]  [C]");
				arrCol.add(nf.format(dblminvalue1));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Loan Applied   [D]");
				arrCol.add(nf.format(dbl_RequestedAmount));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Maximum Loan Limit as per scheme");
				arrCol.add(nf.format(dblMaxLimit));
				arrRow.add(arrCol);
				
				dblminvalue1=Math.min(dblminvalue1, dbl_RequestedAmount);
				
				arrCol=new ArrayList();
				arrCol.add("Limit Eligible  - MPBF [Least of C,D]");
				arrCol.add(nf.format(dblminvalue1));
				arrRow.add(arrCol);
				
				hshResult.put("strEligibleLoanAmt", String.valueOf(nf.format(dblminvalue1)));
				
			}
			if(strProdPurpose.equals("HC"))
			{
				double dblCollateral=0.00,dblCollateralEligible=0.00,dblMaxLimit=0.00,dblminvalue=0.00,dblminvalue1=0.00,dblResidual=0.00;
				
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_residentialpropertysum1^12^"+ strAppNo);
				if(rs.next())
				{
					dblCollateral=Double.parseDouble(Helper.correctDouble(rs.getString("secvalue")));
				}
				arrCol=new ArrayList();
				arrCol.add("Market Value of the Property (1)");
				arrCol.add(nf.format(dblCollateral));
				arrRow.add(arrCol);
				
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("loanamt_finappdata^"+ strAppNo);
				if(rs.next())
				{
					dblResidual=Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_DIGI_RESIDUAL")));
				}
				arrCol=new ArrayList();
				arrCol.add("Residual value of the security (2)");
				arrCol.add(nf.format(dblResidual));
				arrRow.add(arrCol);
				
				dblCollateralEligible=(dbl_loan_limit_defined/100)*dblResidual;
				
				arrCol=new ArrayList();
				arrCol.add("Eligible Limit is "+nf.format(dbl_loan_limit_defined)+" % of (2) [A]");
				arrCol.add(nf.format(dblCollateralEligible));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Loan Applied [B]");
				arrCol.add(nf.format(dbl_RequestedAmount));
				arrRow.add(arrCol);
				
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_productdesc^"+ strProcode);
				if(rs.next())
				{
					dblMaxLimit=Double.parseDouble(Helper.correctDouble(rs.getString("prd_rng_to")));
				}
				
				arrCol=new ArrayList();
				arrCol.add("Maximum Loan Limit as per scheme [C]");
				arrCol.add(nf.format(dblMaxLimit));
				arrRow.add(arrCol);
								
				dblminvalue=Math.min(dblCollateralEligible, dbl_RequestedAmount);
				dblminvalue1=Math.min(dblMaxLimit, dblminvalue);
				
				arrCol=new ArrayList();
				arrCol.add("Limit Eligible - MPBF [Least of A,B,C]");
				arrCol.add(nf.format(dblminvalue1));
				arrRow.add(arrCol);
				
				hshResult.put("strEligibleLoanAmt", String.valueOf(nf.format(dblminvalue1)));
			}
			if(rs!=null)
				rs.close();
			
			if(strPrdType.equalsIgnoreCase("PM"))//this is the mortgage products
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					dbl_Securityvalue+=Double.parseDouble(Helper.correctDouble(rs.getString("cloanprd")));
				}
				
                 dbl_eligible_loan_limit=(dbl_loan_limit_defined/100)*dbl_Securityvalue;
				
                arrCol=new ArrayList();
				arrCol.add("Security Values");
				arrCol.add(nf.format(dbl_Securityvalue));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Eligible is "+nf.format(dbl_loan_limit_defined)+"% of above&nbsp;[1]</b>");
				arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
				arrRow.add(arrCol);
				
			}
						
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_prd_bankscheme^" + strProcode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("prd_bankscheme", Helper.correctNull(rs.getString("prd_bankscheme")));
			}
			
			if(Helper.correctNull(rs.getString("prd_bankscheme")).equalsIgnoreCase("035"))
			{
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Applied</b>");
				arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
				arrRow.add(arrCol);
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			hshResult.put("arrAssessment", arrRow);
			hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_eligible_loan_limit)));
			
			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{	
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppNo);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
		} catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of updateHouseAssessment Method "+ce.toString());
		} finally
		{
			try{
				
			} catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in RetailAssessment Bean of updateHouseAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	private  HashMap update_Income_Based_Assessment(HashMap hshValues) 
	{			
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshResult = new HashMap();
		double dbl_auto_valuation=0.00,
		dbl_eligible_based_cost=0.00,
		dbl_mpbf=0.00,
		dbl_overall_eligible_inc=0.00,
		dbl_loan_limit_defined=0.00,
		dbl_incbased_eligible_limit=0.00,
		dbl_loan_range_to=0.00,
		dbl_income_salaried=0.00,
		dbl_income_nonsalaried=0.00,
		dbl_add_depreciation_year1=0.00,
		dbl_add_depreciation_year2=0.00,
		dbl_add_intonliab_year1=0.00,
		dbl_add_intonliab_year2=0.00,
		dbl_nonsal_inc_itr1=0.00,
		dbl_nonsal_inc_itr2=0.00,
		dbl_year1_nonsal_totalinc=0.00,
		dbl_year2_nonsal_totalinc=0.00,
		dbl_nonsal_totalinc=0.00,
		dbl_avg_nonsal_totalinc=0.00,
		dbl_nonsal_eligible_limit=0.00,
		dbl_tot_elig_based_inc=0.00,
		dbl_grossincome_salaried=0.00;
		int int_auto_type=0,
		int_limitofloan_sal=0,
		int_limitofloan_nonsal=0,
		int_applicant_occupation=0;
		String strQuery=null,
		strappid="", strPrdType="", strGrossOrNetSalary="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrInc=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		double  dub_LimitligiblMPBF=0.00;
		double dbl_SancAmount=0.00;
		String strPropductType="",strStaffprd="";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			dbl_eligible_based_cost=Double.parseDouble(Helper.correctDouble((String)hshValues.get("eligible_based_cost")));
			/**
			 * Calculating Limit of Loan
			 */
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strStaffprd=Helper.correctNull(rs.getString("prd_staffprd"));
				}
			
			//Digi Application changes
			if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equals("DIGI"))
			{
				strStaffprd="Y";
			}
			///end
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
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				dbl_loan_limit_defined=100-rs.getDouble("loan_margin");
				int_limitofloan_sal=rs.getInt("income_limit_employed");
				int_limitofloan_nonsal=rs.getInt("income_limit_self_employed");
				dbl_loan_range_to=rs.getDouble("rangeto");
				strPrdType=correctNull((String)rs.getString("prd_type"));
				dbl_SancAmount= Double.parseDouble(Helper.correctDouble((String)rs.getString("amtreqd"))); //added by gaensan for Limit applied field 
			}
			/**
			 * Display of Assessment Based on Income
			 */
		
			int i=1;
			String j="1,2,3,4";
			if(strPrdType.equalsIgnoreCase("pP"))
			{
				i=0;
				j="1,2";
			}
			if(strProdPurpose.equalsIgnoreCase("G") || (strStaffprd.equalsIgnoreCase("Y") && (strPrdType.equalsIgnoreCase("pH") || strPrdType.equalsIgnoreCase("pM")))) 
			{
				i=0;
				j="1,2,3";
			}
			strPropductType=Helper.correctNull((String)hshValues.get("strProductType"));
			String[] strCommon_inc_based_ass={"Total Limit Eligible as per Income&nbsp;["+(i+1)+"]","<b>Maximum Limit as per Scheme&nbsp;["+(i+2)+"]</b>",
					"<b>Limit Applied</b>&nbsp;["+(i+3)+"]","<b>Maximum Permissible Bank Finance(MPBF)&nbsp;[Least of "+j+"]<b>"};
			if(rs!=null)
				rs.close();
			
			
			
			if(!(strProdPurpose.equalsIgnoreCase("G") || (strPrdType.equalsIgnoreCase("pH") && strStaffprd.equalsIgnoreCase("Y"))|| (strPrdType.equalsIgnoreCase("pM") && strStaffprd.equalsIgnoreCase("Y")))) 
			{
			rs=DBUtils.executeLAPSQuery("sel_app_coapp_details^"+appno);
			while(rs.next())
			{
				strappid=Helper.correctNull((String)rs.getString("demo_appid"));
				int_applicant_occupation=rs.getInt("perapp_employment");
				String ITRyear1="",ITRyear2="",strIncomeFiledDate1="",strIncomeFiledDate2="";
				 // Retrieving the Salary of Borrower
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("assesment_sel_borr_income_details_appid^"+strappid);
				if(rs1.next())
				{
					 dbl_income_salaried = rs1.getDouble("income_salaried");
					 dbl_income_nonsalaried = rs1.getDouble("income_nonsalaried");
					 dbl_nonsal_inc_itr1 = rs1.getDouble("nonsal_itry1");
					 dbl_nonsal_inc_itr2 = rs1.getDouble("nonsal_itry2");
					 dbl_add_depreciation_year1 = rs1.getDouble("depreciation1");
					 dbl_add_depreciation_year2 = rs1.getDouble("depreciation2");
					 dbl_add_intonliab_year1 = rs1.getDouble("intonliab1");
					 dbl_add_intonliab_year2 = rs1.getDouble("intonliab2");
					 dbl_grossincome_salaried= rs1.getDouble("grossincome_salaried");
					 ITRyear1=Helper.correctNull((String)rs1.getString("perinc_itrdate1"));
					 ITRyear2=Helper.correctNull((String)rs1.getString("perinc_itrdate2"));
					 strIncomeFiledDate1=Helper.correctNull(rs1.getString("perinc_yearend1"));
					 strIncomeFiledDate2=Helper.correctNull(rs1.getString("perinc_yearend2"));
				}
				dbl_year1_nonsal_totalinc=dbl_nonsal_inc_itr1+dbl_add_depreciation_year1;
				dbl_year2_nonsal_totalinc=dbl_nonsal_inc_itr2+dbl_add_depreciation_year2;
				if(dbl_year1_nonsal_totalinc==0||dbl_year2_nonsal_totalinc==0)
				{
					dbl_nonsal_totalinc=dbl_year1_nonsal_totalinc+dbl_year2_nonsal_totalinc;
					dbl_avg_nonsal_totalinc=dbl_nonsal_totalinc;
				}
				else
				{
					dbl_nonsal_totalinc=dbl_year1_nonsal_totalinc+dbl_year2_nonsal_totalinc;
					dbl_avg_nonsal_totalinc=dbl_nonsal_totalinc/2;
				}
				 // Calculating Maximum Eligible amount based on salary
				String strApptype=Helper.correctNull((String)rs.getString("demo_type"));
				dbl_incbased_eligible_limit=int_limitofloan_sal*dbl_income_salaried;
				dbl_nonsal_eligible_limit=int_limitofloan_nonsal*dbl_avg_nonsal_totalinc;
				if(strPrdType.equalsIgnoreCase("pP") && strApptype.equalsIgnoreCase("a"))
				{
					strGrossOrNetSalary="Gross Salary";
					dbl_income_salaried=dbl_grossincome_salaried;
				}	
				else
				{
					strGrossOrNetSalary="Net Salary";
				}
				String[] strSal_inc_based_ass={"Latest "+strGrossOrNetSalary+"",int_limitofloan_sal+" Times of which is [1]",
						"Limit Eligible as per salary",String.valueOf(nf.format(dbl_income_salaried)),
						String.valueOf(nf.format(dbl_incbased_eligible_limit)),String.valueOf(nf.format(dbl_incbased_eligible_limit)),String.valueOf(nf.format(dbl_loan_range_to))};
				
				String[] strNonSal_inc_based_ass={"Income as per ITR/Declaration of Financial Year "+strIncomeFiledDate1+" filled on  ","Add: Depreciation","TOTAL Income of Year 1",
						"Income as per ITR/Declaration of Financial Year "+strIncomeFiledDate2+" filled on   ","Add: Depreciation","TOTAL Income of Year 2","Total Income of YEAR 1 & 2",
						"Average Income of last 2 Years",int_limitofloan_nonsal+" times of Average Income "};
				
				
				String strApptypeDesc="";
				if(strApptype.equals("a"))
				{
					strApptypeDesc="Applicant";
				} else if(strApptype.equals("c")){
					strApptypeDesc="Joint-Applicant";
				} else if(strApptype.equals("g")){
					strApptypeDesc="Guarantor";
				} else if(strApptype.equals("o")){
					strApptypeDesc="Co-Obligant";
				}
						
				if(int_applicant_occupation==1 || int_applicant_occupation==9)
				{
					if(strPrdType.equalsIgnoreCase("pP"))
					{    	
						if(strApptype.equals("a"))
						{
							if(rs1!=null)
								rs1.close();
							double dub_basicsal=0.00;
							double  dub_da=0.00;
							double  dub_alloweligible=0.00;
							double  dub_Totesalary=0.00;
						
							rs1=DBUtils.executeLAPSQuery("sel_perincomedetails^"+appno);
							if(rs1.next())
							{
								dub_basicsal=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_basicsalary")));
								dub_da=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_da")));
								dub_alloweligible=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_alloweligible")));
								dub_Totesalary=dub_basicsal+dub_da+dub_alloweligible;
								dub_LimitligiblMPBF=int_limitofloan_sal*dub_Totesalary;
								
								arrCol=new ArrayList();
								arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname"));
								arrCol.add("");
								arrInc.add(arrCol);
								
								arrCol=new ArrayList();
								arrCol.add("Basic Salary");
								arrCol.add(nf.format(dub_basicsal));
								arrInc.add(arrCol);
								
								arrCol=new ArrayList();
								arrCol.add("DA");
								arrCol.add(nf.format(dub_da));
								arrInc.add(arrCol);
								
								arrCol=new ArrayList();
								arrCol.add("Allowance Eligible for Super Annuation");
								arrCol.add(nf.format(dub_alloweligible));
								arrInc.add(arrCol);
								
								arrCol=new ArrayList();
								arrCol.add("Total Eligible Salary");
								arrCol.add(nf.format(dub_Totesalary));
								arrInc.add(arrCol);
								
								arrCol=new ArrayList();
								arrCol.add(strSal_inc_based_ass[1]);
								arrCol.add(nf.format(dub_LimitligiblMPBF));
								arrInc.add(arrCol);
							}
							dbl_tot_elig_based_inc+=dbl_incbased_eligible_limit;
						}
					}
					else
					{
					    arrCol=new ArrayList();
						arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname"));
						arrCol.add("");
						arrInc.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strSal_inc_based_ass[0]);
						arrCol.add(nf.format(dbl_income_salaried));
						arrInc.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strSal_inc_based_ass[1]);
						arrCol.add(nf.format(dbl_incbased_eligible_limit));
						arrInc.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strSal_inc_based_ass[2]);
						arrCol.add(nf.format(dbl_incbased_eligible_limit));
						arrInc.add(arrCol);
					
						dbl_tot_elig_based_inc+=dbl_incbased_eligible_limit;
					}
				}else if(int_applicant_occupation==10) {
					
					arrCol=new ArrayList();
					arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname")+" is a Student");
					arrCol.add("");
					arrInc.add(arrCol);
					
				}else{
						arrCol=new ArrayList();
						arrCol.add(strApptypeDesc+" - "+rs.getString("perapp_fname"));
						arrCol.add("");
						arrInc.add(arrCol);
					
						if(dbl_year1_nonsal_totalinc>0)
						{
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[0]+""+ITRyear1);
							arrCol.add(nf.format(dbl_nonsal_inc_itr1));
							arrInc.add(arrCol);
							
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[1]);
							arrCol.add(nf.format(dbl_add_depreciation_year1));
							arrInc.add(arrCol);
							
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[2]);
							arrCol.add(nf.format(dbl_year1_nonsal_totalinc));
							arrInc.add(arrCol);
						}
						
						if(dbl_year2_nonsal_totalinc>0)
						{
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[3]+" "+ITRyear2);
							arrCol.add(nf.format(dbl_nonsal_inc_itr2));
							arrInc.add(arrCol);
							
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[4]);
							arrCol.add(nf.format(dbl_add_depreciation_year2));
							arrInc.add(arrCol);
							
							arrCol=new ArrayList();
							arrCol.add(strNonSal_inc_based_ass[5]);
							arrCol.add(nf.format(dbl_year2_nonsal_totalinc));
							arrInc.add(arrCol);
						}
						
						arrCol=new ArrayList();
						arrCol.add(strNonSal_inc_based_ass[6]);
						arrCol.add(nf.format(dbl_nonsal_totalinc));
						arrInc.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strNonSal_inc_based_ass[7]);
						arrCol.add(nf.format(dbl_avg_nonsal_totalinc));
						arrInc.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add(strNonSal_inc_based_ass[8]);
						arrCol.add(nf.format(dbl_nonsal_eligible_limit));
						arrInc.add(arrCol);
						
						dbl_tot_elig_based_inc+=dbl_nonsal_eligible_limit;
				}
			}
			}
			dbl_overall_eligible_inc=Math.min(dbl_tot_elig_based_inc, dbl_loan_range_to);
			if(strPrdType.equalsIgnoreCase("pP"))
			{
			dbl_mpbf=dub_LimitligiblMPBF;
			}else if((strProdPurpose.equalsIgnoreCase("G")||(strPrdType.equalsIgnoreCase("pH") && strStaffprd.equalsIgnoreCase("Y")))) 
			{
				dbl_mpbf=Math.min(dbl_eligible_based_cost, dbl_loan_range_to);
				dbl_mpbf=Math.min(dbl_mpbf,dbl_SancAmount);
			}
			else if(strPrdType.equalsIgnoreCase("pM") && strStaffprd.equalsIgnoreCase("Y"))
			{
				dbl_mpbf=Math.min(dbl_eligible_based_cost,dbl_SancAmount);
			}
			else
			{
				dbl_mpbf=Math.min(dbl_overall_eligible_inc, dbl_eligible_based_cost);
				dbl_mpbf=Math.min(dbl_mpbf,dbl_SancAmount);
			}
			
			if(!strPrdType.equalsIgnoreCase("pP"))
			{
				if(!(strProdPurpose.equalsIgnoreCase("G")||(strPrdType.equalsIgnoreCase("pH") && strStaffprd.equalsIgnoreCase("Y"))||(strPrdType.equalsIgnoreCase("pM") && strStaffprd.equalsIgnoreCase("Y")))) 
				{    
					arrCol=new ArrayList();
					arrCol.add(strCommon_inc_based_ass[0]);
					arrCol.add("<b>"+nf.format(dbl_tot_elig_based_inc)+"</b>");
					arrInc.add(arrCol);
				}
					
					arrCol=new ArrayList();
					arrCol.add("MAXIMUM AMOUNT BASED ON SCHEME");
					arrCol.add("");
					arrInc.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strCommon_inc_based_ass[1]);
					arrCol.add("<b>"+nf.format(dbl_loan_range_to)+"</b>");
					arrInc.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add("OVERALL ELIGIBLE LIMIT FOR BORROWER");
					arrCol.add("");
					arrInc.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strCommon_inc_based_ass[2]);
					arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
					arrInc.add(arrCol);
					
					arrCol=new ArrayList();
					if(strPropductType.equalsIgnoreCase("pM"))
					{
						arrCol.add("Limit Eligible");
					}else{
						arrCol.add(strCommon_inc_based_ass[3]);
					}
					arrCol.add("<b>"+nf.format(dbl_mpbf)+"</b>");   //Added by ganesan for Limit applied
					arrInc.add(arrCol);
			}
			
			else
			{
				arrCol=new ArrayList();
				arrCol.add("Limit Applied [2]");
				arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
				arrInc.add(arrCol);
				
				dbl_mpbf=Math.min(dub_LimitligiblMPBF,dbl_SancAmount);
				arrCol=new ArrayList();
				arrCol.add("MPBF  [Least of 1,2]");
				arrCol.add("<b>"+nf.format(dbl_mpbf)+"</b>");
				arrInc.add(arrCol);
				
			}
							
					hshResult.put("arrIncAssessment", arrInc);
					hshResult.put("strEligibleLoanAmt",nf.format(dbl_mpbf));
		
			/**
			 * Updation in Table
			 */
					/*int intUpdatesize=1;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(appno);
			arrValues.add("1");
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_per_assessment_details");
			hshQueryValues.put("1",hshQuery);
			int intsize=2;
			if(!arrInc.equals(null)&&arrInc.size()>0)
			{
				for(int i=0;i<(strSal_inc_based_ass.length/2);i++)
				{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				arrValues.add(appno);
				arrValues.add("1");
				arrValues.add(Integer.toString(i+1));
				arrValues.add(strSal_inc_based_ass[i]);
				arrValues.add(strSal_inc_based_ass[i+4]);
				arrValues.add("I");
				hshQuery.put("arrValues",arrValues);	
				hshQuery.put("strQueryId","ins_per_assessment_details");
				hshQueryValues.put(Integer.toString(intsize),hshQuery);
				intsize++;
				}
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
	
		if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
		{		
			if(strPrdType.equalsIgnoreCase("pP"))
			{		
				ArrayList arrValuesCol = new ArrayList();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
					
			if(rs != null)
				rs.close();
				
			 int maxslno=0;			
			  strQuery = SQLParser.getSqlQuery("sel_Maxslno_per_assessment_details^" + appno);
			  rs = DBUtils.executeQuery(strQuery);
			  if(rs.next())
			  {
				  maxslno=Integer.parseInt(Helper.correctInt((String)rs.getString("maxslno")));
			  }	
			ArrayList arrValuesCol = new ArrayList();
			int intUpdatesize =0,intsize=1;
			for(int k=0;k<arrInc.size();k++)
			{
				arrValuesCol= (ArrayList) arrInc.get(k);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				maxslno++;
				arrValues.add(appno);
				arrValues.add("1");
				arrValues.add(Integer.toString(maxslno));
				arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
				arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
				//arrValues.add("C");
				if(((String)arrValuesCol.get(1)).equals(""))
				{
					arrValues.add("H");
				}
				else
				{
					arrValues.add("C");
				}
				arrValues.add("C");
				hshQuery.put("arrValues",arrValues);	
				hshQuery.put("strQueryId","ins_per_assessment_details");
				hshQueryValues.put(Integer.toString(intsize),hshQuery);
				intsize++;
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
			
		}
					
					
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of update_Income_Based_Assessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of update_Income_Based_Assessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	private  HashMap updateMahilaUdyogAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="";
		String strVehiCat="",strVehiType="",strInsCompName="";
		double dbl_eligible_loan_limit=0.00,dbl_cost_of_project=0.00;
		
		double dbl_auto_valuation=0.00,dbl_auto_tax=0.00,dbl_auto_insurance=0.00,
		dbl_auto_total_cost=0.00,dbl_loan_limit_defined=0.00,dbl_loan_eligible_limit=0.00,
		dbl_auto_second_hand_valuation=0.00,dbl_auto_actual_payable=0.00,dbl_auto_least_value=0.00,dbl_auto_second_value=0.0,
		dbl_limitofloan_sal=0.00,dbl_incbased_eligible_limit=0.00,dbl_loan_range_to=0.00,
		dbl_income_salaried=0.00,dbl_income_nonsalaried=0.00,dbl_add_depreciation_year1=0.00,dbl_add_depreciation_year2=0.00,
		dbl_add_intonliab_year1=0.00,dbl_add_intonliab_year2=0.00,dbl_nonsal_inc_itr1=0.00,dbl_nonsal_inc_itr2=0.00,
		dbl_year1_nonsal_totalinc=0.00,dbl_year2_nonsal_totalinc=0.00,dbl_nonsal_totalinc=0.00,dbl_avg_nonsal_totalinc=0.00,
		dbl_limitofloan_nonsal=0.00,dbl_nonsal_eligible_limit=0.00,dbl_tot_elig_based_inc=0.00,dbl_other_accessories=0.0,
		dbl_other_charges=0.0,dbl_discount=0.0;
		int int_auto_type=0,int_applicant_occupation=0;
		double dbl_SancAmount=0.00,dblInsurance=0.0,dblMaxLimit=0.0;
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery=SQLParser.getSqlQuery("sel_loandetails^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dbl_eligible_loan_limit=Double.parseDouble(Helper.correctDouble(rs.getString("loan_amtreqd")));
				dbl_cost_of_project=Double.parseDouble(Helper.correctDouble(rs.getString("loan_costloanprd")));
				dblInsurance= Double.parseDouble(Helper.correctDouble(rs.getString("loan_metlifepremiumamt"))); 
				
				if(Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
					dblInsurance=0;
				
				if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					if(rs1.next())
					{
						strInsCompName=Helper.correctNull(rs1.getString("stat_data_desc1"));
					}
				}
			}
			
			if(rs!=null)
			rs.close();
			strQuery = SQLParser.getSqlQuery("sel_mahilaVehi^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strVehiCat=Helper.correctNull(rs.getString("prd_applicablefor"));
				strVehiType=Helper.correctNull(rs.getString("prd_vehitype"));
				dblMaxLimit=rs.getDouble("prd_rng_to");
			}
		
			if(strVehiType.equalsIgnoreCase("2"))
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			else
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				dbl_loan_limit_defined=100-rs.getDouble("loan_margin");
				dbl_limitofloan_sal=rs.getDouble("income_limit_employed");
				dbl_limitofloan_nonsal=rs.getDouble("income_limit_self_employed");
				dbl_loan_range_to=rs.getDouble("rangeto");
				dbl_SancAmount= Double.parseDouble(Helper.correctDouble((String)rs.getString("amtreqd"))); //added by gaensan for Limit applied field
			}
			if(strVehiCat.equalsIgnoreCase("V"))
			{
				/**
				 *  Getting Proposed Asset Details
				 */
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("selectvehicledetails1^A^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					int_auto_type=rs.getInt("auto_category");
					dbl_auto_valuation=dbl_auto_valuation+rs.getDouble("auto_valuation");
					dbl_auto_second_hand_valuation = dbl_auto_second_hand_valuation+rs.getDouble("auto_valuationentry");
					dbl_auto_actual_payable=dbl_auto_actual_payable+rs.getDouble("auto_actualconsideration");
					dbl_auto_second_value=dbl_auto_second_value+rs.getDouble("auto_originalcost");
					dbl_auto_least_value=Math.min(dbl_auto_second_hand_valuation, dbl_auto_actual_payable);
					dbl_auto_least_value=Math.min(dbl_auto_second_value, dbl_auto_least_value);
					dbl_auto_tax=dbl_auto_tax+rs.getDouble("auto_tax");
					dbl_auto_insurance=dbl_auto_insurance+rs.getDouble("auto_insurance");
					dbl_other_accessories=dbl_other_accessories+rs.getDouble("auto_accessories");
					//dbl_other_charges=rs.getDouble("auto_charges");
					dbl_discount=dbl_discount+rs.getDouble("auto_discount");
				}
				dbl_auto_total_cost=dbl_auto_valuation+dbl_auto_tax+dbl_auto_insurance+dbl_other_accessories-dbl_discount;
				/**
				 * Calculating Limit of Loan
				 */
				
				/**
				 * Calculation of Eligible Limit
				 */
				if(int_auto_type==2)
				{
					dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_least_value;
				} else {
					dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_total_cost;
				}
				
				/**
				 * Display of Assessment Based on Cost
				 */
				
				arrCol=new ArrayList();
				arrCol.add("<b>Limit Applied [a]</b>");
				arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
				arrRow.add(arrCol);
				
				String[] strLine_NewVeh_Desc={"Cost of Vehicle ","Add: Road Tax","Add:Price For Accessories/Body Building","Add:Insurance","Less:Discount","TOTAL Cost [b]",
						"<b>Limit Eligible ["+nf.format(dbl_loan_limit_defined)+"% of Total Cost]&nbsp;[c]</b>",String.valueOf(nf.format(dbl_auto_valuation)),
						String.valueOf(nf.format(dbl_auto_tax)),nf.format(dbl_other_accessories),
						String.valueOf(nf.format(dbl_auto_insurance)),nf.format(dbl_discount),String.valueOf(nf.format(dbl_auto_total_cost)),
						String.valueOf(nf.format(dbl_loan_eligible_limit))};
				
				String[] strLine_OldVeh_Desc={"Value as per valuation","Original Cost of the Vehicle","Actual Consideration paid by purchaser","Least of above three [b]",
						"<b>Limit Eligible ["+nf.format(dbl_loan_limit_defined)+" % of Total Cost]&nbsp;<b>[c]</b>",String.valueOf(dbl_auto_second_hand_valuation),
						nf.format(dbl_auto_second_value),String.valueOf(dbl_auto_actual_payable),String.valueOf(dbl_auto_least_value),String.valueOf(dbl_loan_eligible_limit)};
				
				if(int_auto_type==1)
				{
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[0]);
					arrCol.add(nf.format(dbl_auto_valuation));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[1]);
					arrCol.add(nf.format(dbl_auto_tax));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[2]);
					arrCol.add(nf.format(dbl_other_accessories));
					arrRow.add(arrCol);
					
//					arrCol=new ArrayList();
//					arrCol.add(strLine_NewVeh_Desc[3]);
//					arrCol.add(nf.format(dbl_other_charges));
//					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[3]);
					arrCol.add(nf.format(dbl_auto_insurance));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[4]);
					arrCol.add(nf.format(dbl_discount));
					arrRow.add(arrCol);
					
					if(dblInsurance>0)
					{
						arrCol = new ArrayList();
						arrCol.add(strInsCompName);
						arrCol.add(nf.format(dblInsurance));
						arrRow.add(arrCol);
						
						dbl_auto_total_cost+=dblInsurance;
						dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_total_cost;
					}
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[5]);
					arrCol.add(nf.format(dbl_auto_total_cost));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_NewVeh_Desc[6]);
					arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
					arrRow.add(arrCol);
				} else {
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[0]);
					arrCol.add(nf.format(dbl_auto_second_hand_valuation));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[1]);
					arrCol.add(nf.format(dbl_auto_second_value));
					arrRow.add(arrCol);
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[2]);
					arrCol.add(nf.format(dbl_auto_actual_payable));
					arrRow.add(arrCol);	
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[3]);
					arrCol.add(nf.format(dbl_auto_least_value));
					arrRow.add(arrCol);	
					
					if(dblInsurance>0)
					{
						arrCol = new ArrayList();
						arrCol.add(strInsCompName);
						arrCol.add(nf.format(dblInsurance));
						arrRow.add(arrCol);
						
						dbl_auto_least_value+=dblInsurance;
						dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_auto_least_value;
						
						arrCol = new ArrayList();
						arrCol.add("<b>Total Cost</b>");
						arrCol.add(nf.format(dbl_auto_least_value));
						arrRow.add(arrCol);
					}
					
					arrCol=new ArrayList();
					arrCol.add(strLine_OldVeh_Desc[4]);
					arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
					arrRow.add(arrCol);
					
				}
				
				arrCol=new ArrayList();
				arrCol.add("Maximum Loan Limit [d]");
				arrCol.add(nf.format(dblMaxLimit));
				arrRow.add(arrCol);
				
				dbl_loan_eligible_limit=Math.min(dbl_SancAmount, dbl_loan_eligible_limit);
				dbl_loan_eligible_limit=Math.min(dblMaxLimit, dbl_loan_eligible_limit);
				arrCol=new ArrayList();
				arrCol.add("<b>Eligible Amount [Least of a,c,d] </b>");
				arrCol.add("<b>"+nf.format(dbl_loan_eligible_limit)+"</b>");
				arrRow.add(arrCol);
				
				hshResult.put("arrAssessment", arrRow);
				hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_loan_eligible_limit)));
			}
			else
			{
				String[] strLine_Salaried_Desc={"<b>Limit Applied [a]</b>","Project cost/Cost of machineries/equipment/ Stock/Book Debts","<b>Limit Eligible ["+nf.format(dbl_loan_limit_defined)+"% of Total Cost]&nbsp;[b]</b>","<b>Eligible Amount [Least of a,b,c]</b>"};
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[0]);
				arrCol.add(nf.format(dbl_eligible_loan_limit));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[1]);
				arrCol.add(nf.format(dbl_cost_of_project));
				arrRow.add(arrCol);
				
				if(dblInsurance>0)
				{
					arrCol = new ArrayList();
					arrCol.add(strInsCompName);
					arrCol.add(nf.format(dblInsurance));
					arrRow.add(arrCol);
					
					dbl_cost_of_project+=dblInsurance;
					
					arrCol = new ArrayList();
					arrCol.add("Total Cost");
					arrCol.add(nf.format(dbl_cost_of_project));
					arrRow.add(arrCol);
				}
				
				dbl_loan_eligible_limit=(dbl_loan_limit_defined/100)*dbl_cost_of_project;
				
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[2]);
				arrCol.add(nf.format(dbl_loan_eligible_limit));
				arrRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("Maximum Loan Limit [c]");
				arrCol.add(nf.format(dblMaxLimit));
				arrRow.add(arrCol);
				
				dbl_eligible_loan_limit=Math.min(dbl_eligible_loan_limit,dbl_loan_eligible_limit);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[3]);
				arrCol.add(nf.format(dbl_eligible_loan_limit));
				arrRow.add(arrCol);
				
				hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_eligible_loan_limit)));
				hshResult.put("arrAssessment", arrRow);
				
			}
			
			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of updateMahilaUdyogAssessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of updateMahilaUdyogAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	private  HashMap updateGoldAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult=new HashMap();
		HashMap hshRecord=new HashMap();
		HashMap hshBnkGold=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery="",strEmployment="",strAgriPrd="",strMasterID="",strStatus="",strRecAmt="0.00";
		double dblLimitApplied=0.00, dblLoanLimitDefined=0.00, dblBnkDefined=0.00, dblNetWeight=0.00, dbl_eligible_loan_limit=0.00, dblMinValue=0.00,dbNetWeight=0.00;
		double dblLatestMargin=0.00,dblAvgMargin=0.00,dblAgriLatestMargin=0.0,dblAgriAvgMargin=0.0;
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery=SQLParser.getSqlQuery("sel_loandetails^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblLimitApplied=Double.parseDouble(Helper.correctDouble(rs.getString("loan_amtreqd")));
				strRecAmt=Helper.correctDouble(rs.getString("loan_amtreqd"));
			}
			if(rs !=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			if(rs !=null)
			{
				rs.close();
			}
			
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				dblLoanLimitDefined=100-rs.getDouble("loan_margin");
				strEmployment=Helper.correctNull(rs.getString("perapp_employment"));
				strAgriPrd=Helper.correctNull(rs.getString("prd_whetheragri"));
				strMasterID=Helper.correctNull(rs.getString("loan_goldrate_masterid"));
				strStatus=Helper.correctNull(rs.getString("status"));
			}
			String strFlag="Y";
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selloanagainstparams^118");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				if(!Helper.correctNull((String)rs.getString("LOAN_PARAMVAL")).equalsIgnoreCase(""))
				{
					if((Helper.dateDiff(Helper.correctNull((String)rs.getString("LOAN_PARAMVAL")), Helper.correctNull((String)hshValues.get("strAppCreateDate"))))>=0)
						strFlag="N";	
				}
			}
			
			if(strFlag.equalsIgnoreCase("Y"))
			{
				if(!strStatus.equalsIgnoreCase("op")&& !strMasterID.equalsIgnoreCase(""))
					strQuery = SQLParser.getSqlQuery("selgoldratemaster_id^"+strMasterID);
				else
					strQuery = SQLParser.getSqlQuery("selgoldratemaster^Y");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					dblLatestMargin=100-rs.getDouble("grm_latestmargin");
					dblAvgMargin=100-rs.getDouble("grm_avgmargin");
					dblAgriLatestMargin=100-rs.getDouble("grm_agrilatestmargin_ibja");
					dblAgriAvgMargin=100-rs.getDouble("grm_agriavgmargin_ibja");
				}
				if(rs !=null)
				{rs.close();}
				
				if(strAgriPrd.equalsIgnoreCase("Y"))
				{
					dblLatestMargin=dblAgriLatestMargin;
					dblAvgMargin=dblAgriAvgMargin;
				}
			}
			else
			{
				String strLesser = ">=";
				String strGreater = "<=";
				
				strQuery = SQLParser.getSqlQuery("selmarginrate^" + Helper.correctNull((String)hshValues.get("prdcode")) + "^" + strGreater + "^" + strRecAmt + "^"
						+ strLesser + "^" + strRecAmt);

				rs = DBUtils.executeQuery(strQuery);

				if (rs.next())
				{
						dblLatestMargin=100-Double.parseDouble(Helper.correctDouble(rs.getString("margin_perct")));
						dblAvgMargin=100-Double.parseDouble(Helper.correctDouble(rs.getString("margin_perct_othersec")));
						
						
				}
			}
			
			if((100-dblAvgMargin)>(100-dblLatestMargin))
				hshResult.put("strGoldMargin", nf.format(100-dblAvgMargin));	
			else
				hshResult.put("strGoldMargin", nf.format(100-dblLatestMargin));	
			
			double dblGoldRate=0.00,dblAvgRate=0.00;
			agrotherBean agrOther = new agrotherBean();
			hshRecord.put("prdcode",Helper.correctNull((String)hshValues.get("prdcode")));
			hshRecord.put("strAppId",Helper.correctNull((String)hshValues.get("hidapplicantid")));
			hshBnkGold=agrOther.getGoldRateDetails(hshRecord);
			dblGoldRate=Double.parseDouble(Helper.correctDouble((String)hshBnkGold.get("strGoldRate")));
			dblAvgRate=Double.parseDouble(Helper.correctDouble((String)hshBnkGold.get("strAvgRate")));
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selgolddetails^" + appno);
			double dbESTRATE=0.00,dbAvgRate=0.00,dblAgriAss=0.00;
			while (rs.next())
			{
				dblNetWeight=dblNetWeight+Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ARTNETWT")));
				//dbESTRATE=dbESTRATE+Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ESTRATE")));
				//dbNetWeight=dbNetWeight+Double.parseDouble(Helper.correctDouble((String) rs.getString("AGR_ARTNETWT")));
				
				dblGoldRate=Double.parseDouble(Helper.correctDouble(rs.getString("AGR_ARTMKTRATE")));
				dblAvgRate=Double.parseDouble(Helper.correctDouble(rs.getString("AGR_ARTRATE")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selectagriassessment^" + appno);
			while (rs.next())
			{
				dblAgriAss=Double.parseDouble(Helper.correctDouble((String) rs.getString("agr_eligible_amt")));
			}
			dbAvgRate=((dblNetWeight*dblAvgRate)*dblAvgMargin)/100;
			dbESTRATE=((dblNetWeight*dblGoldRate)*dblLatestMargin)/100;
			String[] strLine_Salaried_Desc={"Loan Amount Requested [1]", nf.format(dblAvgMargin)+"% of average of previous 30 days closing gold rate [2]", nf.format(dblLatestMargin)+"% Last market rate [3]", "<b>Eligible Loan Limit [Least of 1,2,3]</b>"};
			if(rs!=null)
			{
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[0]);
				arrCol.add(nf.format(dblLimitApplied));
				arrRow.add(arrCol);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[1]);
				arrCol.add(nf.format(dbAvgRate));
				arrRow.add(arrCol);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[2]);
				arrCol.add(nf.format(dbESTRATE));
				arrRow.add(arrCol);
				
				dblMinValue=Math.min(dblLimitApplied,dbAvgRate);
				dbl_eligible_loan_limit=Math.min(dbESTRATE,dblMinValue);
				
				if(strEmployment.equalsIgnoreCase("4") && strAgriPrd.equalsIgnoreCase("Y"))
				{
					arrCol=new ArrayList();
					arrCol.add("Loan amount Eligible as per Scale of Finance [4]");
					arrCol.add(nf.format(dblAgriAss));
					arrRow.add(arrCol);
					dbl_eligible_loan_limit=Math.min(dblAgriAss,dbl_eligible_loan_limit);
					strLine_Salaried_Desc[3]="<b>Eligible Loan Limit [Least of 1,2,3 and 4]</b>";
				}
				
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[3]);
				arrCol.add(nf.format(dbl_eligible_loan_limit));
				arrRow.add(arrCol);
			}
			hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_eligible_loan_limit)));
			hshResult.put("arrAssessment", arrRow);
			
			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{	
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of updateGoldAssessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of updateGoldAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}
	private  HashMap updateDepositAssessment(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult=new HashMap();
		String strQuery="";
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		double dblLimitApplied=0.00, dblPresentVal=0.00, dblLoanLimitDefined=0.00, dbl_eligible_loan_limit=0.00,dbl_depositValue=0.0;
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase(null) || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery=SQLParser.getSqlQuery("sel_loandetails^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblLimitApplied=Double.parseDouble(Helper.correctDouble(rs.getString("loan_amtreqd")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				dblPresentVal=dblPresentVal+Double.parseDouble(Helper.correctDouble(rs.getString("loan_presentos")));
			}
			dbl_depositValue=dblPresentVal;
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
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				dblLoanLimitDefined=100-Double.parseDouble(Helper.correctDouble(rs.getString("loan_margin")));
			}
			dblPresentVal=(dblPresentVal*dblLoanLimitDefined)/100;
			dbl_eligible_loan_limit=Math.min(dblLimitApplied,dblPresentVal);
			String[] strLine_Salaried_Desc={"Loan Amount Requested [1]","Outstanding Balance in the Fixed/Cumulative Deposit as on date", nf.format(dblLoanLimitDefined)+"% on the Outstanding Balance as on date [2]", "<b>Limit Eligible - Least of [1,2]</b>"};
			if(rs!=null)
			{
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[0]);
				arrCol.add(nf.format(dblLimitApplied));
				arrRow.add(arrCol);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[1]);
				arrCol.add(nf.format(dbl_depositValue));
				arrRow.add(arrCol);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[2]);
				arrCol.add(nf.format(dblPresentVal));
				arrRow.add(arrCol);
				arrCol=new ArrayList();
				arrCol.add(strLine_Salaried_Desc[3]);
				arrCol.add(nf.format(dbl_eligible_loan_limit));
				arrRow.add(arrCol);
			}
			hshResult.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_eligible_loan_limit)));
			hshResult.put("arrAssessment", arrRow);
	
			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in RetailAssessment Bean of updateDepositAssessment Method "+ce.toString());
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
				throw new EJBException("Error closing the connection in RetailAssessment Bean of updateDepositAssessment Method "+cf.getMessage());
			}
		}
		return hshResult;
	}

	private	HashMap updateRavikirandate(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null,rs1=null;
	
		String strAppNo="";
		String strLoanPurpose="",strInsCompName="";
		String strPropType="";
		double totloanamt=0.00;
		double douloanamt=0.00;
		double othertot=0.00;
		double loanamtpr=0.00,dbl_sancAmt=0.0;
		int i=0;
	    int j=0;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arrCol = new ArrayList();
 		ArrayList arrRow = new ArrayList();
		boolean bstate =true;
		try
		{
			String appno	= Helper.correctNull((String )hshValues.get("appno"));	
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			double dbl_loan_limit_defined=0.00;
			double dbl_eligible_loan_limit=0.00,dblInsurance=0.0;
			String strProdPurpose="";
			rs = DBUtils.executeLAPSQuery("selprodpurpose^"+appno);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+appno);
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProduct^"+appno);
			}
			if (rs.next()) {
							dbl_loan_limit_defined=100-rs.getDouble("loan_margin");
							dbl_sancAmt=rs.getDouble("amtreqd");
							dblInsurance= Double.parseDouble(Helper.correctDouble(rs.getString("loan_metlifepremiumamt"))); 
							
							if(Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
								dblInsurance=0;
							
							
							if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
							{
								if(rs1!=null)
									rs1.close();
								rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
								if(rs1.next())
								{
									strInsCompName=Helper.correctNull(rs1.getString("stat_data_desc1"));
								}
							}
							
						}
			
			strQuery = SQLParser.getSqlQuery("sel_farmmechparticulars^" + appno);
			rs = DBUtils.executeQuery(strQuery);			
			bstate = rs.next();			
			if(bstate==true)
			{
				rs.beforeFirst();
				while(rs.next())
				{
					if(i<3)
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("particulars")));
						loanamtpr=Double.parseDouble(Helper.correctDouble((rs.getString("loanamt"))));
						arrCol.add(nf.format(loanamtpr));
						
						arrRow.add(arrCol);
				}
					else
					{
						douloanamt=Double.parseDouble(Helper.correctDouble(rs.getString("loanamt")));
						othertot=othertot+douloanamt;
						
					}
						if(i==6)
						{
							
								totloanamt=Double.parseDouble(Helper.correctDouble(rs.getString("totloanamt")));
						
					}	
						i=i+1;
					}
					}
			arrCol = new ArrayList();
			arrCol.add("other");
			arrCol.add(nf.format(othertot));
			arrRow.add(arrCol);
			
			if(dblInsurance>0)
			{
				arrCol = new ArrayList();
				arrCol.add(strInsCompName);
				arrCol.add(nf.format(dblInsurance));
				arrRow.add(arrCol);
				
				totloanamt+=dblInsurance;
			}
			
			
			arrCol = new ArrayList();
			arrCol.add("<b>Total Cost</b>");
		    arrCol.add("<b>"+nf.format(totloanamt)+"</b>");
			
			arrRow.add(arrCol);

			if(rs !=null)
			{
				rs.close();
			}
			
						dbl_eligible_loan_limit=((dbl_loan_limit_defined/100)*totloanamt);
						
						arrCol=new ArrayList();
						arrCol.add("<b>Limit Eligible is ["+nf.format(dbl_loan_limit_defined)+"%    of TOTAL Cost]  [1]</b>");
						arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
						arrRow.add(arrCol);
						
						arrCol=new ArrayList();
						arrCol.add("<b>Limit Applied  [2]</b>");
						arrCol.add("<b>"+nf.format(dbl_sancAmt)+"</b>");
						arrRow.add(arrCol);
						
						dbl_eligible_loan_limit=Math.min(dbl_eligible_loan_limit,dbl_sancAmt);
						
						arrCol=new ArrayList();
						arrCol.add("<b>MPBF [Least of 1,2]</b>");
						arrCol.add("<b>"+nf.format(dbl_eligible_loan_limit)+"</b>");
						arrRow.add(arrCol);
			
			
				
			hshRecord.put("arrAssessment",arrRow);
			hshRecord.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_eligible_loan_limit)));	
		
		    if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
		    {		
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i1=0;i1<arrRow.size();i1++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i1);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add(Integer.toString(i1+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		    }
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateRavikirandate "+ce.toString());
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
	
	private	HashMap updateEducationloandate(HashMap hshValues)  
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null,rs1=null;
	
		String strAppNo="",strInsCompName="";
		String strLoanPurpose="";
		String strPropType="";
		
		int i=0;
	    int j=0;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arrCol = new ArrayList();
 		ArrayList arrRow = new ArrayList();
 		double totCostEducation=0.00;
 		double CostEducation=0.00;
 	    double dblloan_margin=0.00;
 	    
 	   double dblloan_margintot=0.00;
 	   double dblLimitEligible=0.00;
 	   double loan_amtreqd=0.00;
 	   double dbl_Examination=0.0; 
 	   double dbl_Totexamination=0.0; 
 	   
 	   double dbl_CautionBuilding=0.0;
 	   double dbl_totCautionBuilding=0.0;
 	   double dbl_Percautionbuilding=0.00;
 	   double dbl_Travelexp=0.00;
 	   double dbl_InsurancePr=0.00;
 	  double dbl_CostBook=0.00;
 	  double dbl_costcomputer=0.00;
 	  double dbl_otehr=0.00;
 	 double dbl_tototehr=0.00;
 	 double dbl_percaution=0.00;
 	double dbl_perbook=0.0;
 	double dbl_TotCau=0.00;
 	double dbl_TotcasBook=0.00;
 	double dbl_perTotcasBook=0.00;
 	double dbl_TotLimitEligible=0.00;
 	String strdblloan_margin=null;
 	String strEdu_type=null;
 	String strStudies=null;
 	double dblTuitionFees=0.00;
 	double dbl_SancAmount=0.00,dblInsurance=0.0;
 	int eduid=0;
 	 
		boolean bstate =true;
		try
		{
			String appno	= Helper.correctNull((String )hshValues.get("appno"));	
			
			String strprocode=Helper.correctNull((String)hshValues.get("prdcode"));
			
			
			strQuery = SQLParser.getSqlQuery("sel_products_education^"+strprocode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strStudies=Helper.correctNull((String)rs.getString("prd_purpose"));
			}
		
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=null;
			strQuery=null;
			
			strQuery = SQLParser.getSqlQuery("sel_edu_course_exp_app^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				eduid=Integer.parseInt(Helper.correctInt(rs.getString("EDU_ID")));
				strEdu_type=Helper.correctNull(rs.getString("EDU_TYPE"));
				
				if((eduid<=15)&&(strEdu_type.equalsIgnoreCase("e")))
				{
				if((eduid==1)||(eduid==8)||(eduid==9))
				{
					CostEducation=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
					totCostEducation=CostEducation+totCostEducation;
				}
				if((eduid==1))
				{
					dblTuitionFees=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
				}
				
				if((eduid==4)||(eduid==5))
				{
					dbl_Examination=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
					dbl_Totexamination=dbl_Totexamination+dbl_Examination;
				}
				
				if((eduid==7)||(eduid==10))
				{
					dbl_CautionBuilding=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
					dbl_totCautionBuilding=dbl_totCautionBuilding+dbl_CautionBuilding;
					
				}
				
				if((eduid==6)&&(strStudies.equalsIgnoreCase("A")))//studies in abroad  in A 
				{
					dbl_Travelexp=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
				}
				
				if((eduid==11)&&(strStudies.equalsIgnoreCase("A")))//studies in abroad  in A
				{
					dbl_InsurancePr=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
				}
				
				
				if(eduid==2)
				{
					dbl_CostBook=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
				}
				
				if(eduid==3)
				{
					dbl_costcomputer=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
				}
				if((eduid==15)||(eduid==12)||(eduid==13)||(eduid==14))
				{
					dbl_otehr=Double.parseDouble(Helper.correctDouble(rs.getString("EDU_COL_TOTAL")));
					dbl_tototehr=dbl_tototehr+dbl_otehr;
					
				}
				
			}
			}
			strQuery=null;
			rs=null;
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("selcb_prd_specificconditions^" + strprocode);
			rs = DBUtils.executeQuery(strQuery);
		     if(rs.next())
		    {
				dbl_percaution=Double.parseDouble(Helper.correctDouble(rs.getString("PRD_CAUTIONDEPOSIT")));
				dbl_perbook=Double.parseDouble(Helper.correctDouble(rs.getString("PRD_BOOKEQUIPMENTS")));
			
			}
		     
			
			arrCol = new ArrayList();
			arrCol.add("College / Hostel / Boarding Fees - (A)");//a
			arrCol.add(nf.format(totCostEducation));
			arrRow.add(arrCol);
						
			arrCol = new ArrayList();
			arrCol.add("Examination / Library / Laboratory Fee - (B)");//b
			arrCol.add(nf.format(dbl_Totexamination));
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("Caution Deposit, Building Fund/Refundable Deposit - (C)");
			arrCol.add(nf.format(dbl_totCautionBuilding));
			arrRow.add(arrCol);
			
			dbl_Percautionbuilding=(dbl_percaution*dblTuitionFees)/100;//10% values//c
			
			dbl_Percautionbuilding=Math.min(dbl_totCautionBuilding, dbl_Percautionbuilding);
			
			arrCol = new ArrayList();
			arrCol.add("Minimum of (C OR "+nf.format(dbl_percaution)+" % of Tuition Fees) - (D)");
			arrCol.add(nf.format(dbl_Percautionbuilding));
			arrRow.add(arrCol);
			
			if(strStudies.equalsIgnoreCase("A"))
			{
			arrCol = new ArrayList();
			arrCol.add("Travel Expenses");
			arrCol.add(nf.format(dbl_Travelexp));//d
			arrRow.add(arrCol);
			}
			
			if(strStudies.equalsIgnoreCase("A"))
			{
			arrCol = new ArrayList();
			arrCol.add("Insurance Premium");
			arrCol.add(nf.format(dbl_InsurancePr));//e
			arrRow.add(arrCol);
			}
			
			if(strStudies.equalsIgnoreCase("A"))
			{
				dbl_TotCau=totCostEducation+dbl_Totexamination+dbl_Percautionbuilding+dbl_Travelexp+dbl_InsurancePr;//a+b+c  this is  the  education loan for abroad 
			}
			else
			{
				dbl_TotCau=totCostEducation+dbl_Totexamination+dbl_Percautionbuilding;//a+b+c+d+e this is  the  education loan for indian 
			}
			
			arrCol = new ArrayList();
			arrCol.add("Cost of Books/Equipments/Instruments/Uniforms - (E)");//f
			arrCol.add(nf.format(dbl_CostBook));
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("Cost of Computers - (F)");
			arrCol.add(nf.format(dbl_costcomputer));//g
			arrRow.add(arrCol);
		
			arrCol = new ArrayList();
			arrCol.add("Any Other Expenses - (G)");
			arrCol.add(nf.format(dbl_tototehr));//h
			arrRow.add(arrCol);
			
			
			dbl_TotcasBook=(dbl_CostBook+dbl_costcomputer+dbl_tototehr);////*dbl_perbook)/100);// [F+G+H]
			
			dbl_perTotcasBook=(dblTuitionFees*dbl_perbook)/100;//(dbl_TotcasBook )% dbl_perbook /100
			
			dbl_perTotcasBook=Math.min(dbl_TotcasBook, dbl_perTotcasBook);
			
			dbl_TotLimitEligible=dbl_TotCau+dbl_perTotcasBook ; //Limit Eligible
			/*rs=null;
			rs = DBUtils.executeLAPSQuery("sel_loan_amtreqd_app^"+appno);
			if(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add("Limit Sought");
				loan_amtreqd=Double.parseDouble(Helper.correctDouble(rs.getString("loan_amtreqd")));
				arrCol.add(nf.format(loan_amtreqd));
				arrRow.add(arrCol);				
			}*/
			rs=null;
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="";
			rs = DBUtils.executeLAPSQuery("selprodpurpose^"+appno);

			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+appno);
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProduct^"+appno);
			}
			if (rs.next()) 
			{
				 strdblloan_margin=Helper.correctNull(rs.getString("loan_margin"));
				 dbl_SancAmount= Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd"))); //added by gaensan for Limit applied field
				 dblInsurance= Double.parseDouble(Helper.correctDouble(rs.getString("loan_metlifepremiumamt"))); 
				 
				 if(Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
						dblInsurance=0;
				 
				 if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
						if(rs1.next())
						{
							strInsCompName=Helper.correctNull(rs1.getString("stat_data_desc1"));
						}
					}
			}
			
			//dblloan_margintot=((totCostEducation*dblloan_margin)/100);//Margin
			
			//dblLimitEligible=(totCostEducation-dblloan_margintot);//Limit Eligible  
			

			arrCol = new ArrayList();
			arrCol.add("Minimum of ( Sum of (E + F + G) OR "+nf.format(dbl_perbook)+" % of Tuition fees) - (H)");
			arrCol.add(nf.format(dbl_perTotcasBook));//h
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("Limit Eligible (A + B + D + H)");
			arrCol.add(nf.format(dbl_TotLimitEligible));//Limit Eligible  
			arrRow.add(arrCol);
			
			if(dblInsurance>0)
			{
				arrCol = new ArrayList();
				arrCol.add(strInsCompName);
				arrCol.add(nf.format(dblInsurance));
				arrRow.add(arrCol);
				
				dbl_TotLimitEligible+=dblInsurance;
				
				arrCol = new ArrayList();
				arrCol.add("Total Cost");
				arrCol.add(nf.format(dbl_TotLimitEligible));
				arrRow.add(arrCol);
			}
			
			arrCol = new ArrayList();
			arrCol.add("Margin Required ");
			arrCol.add(strdblloan_margin+" %");
			arrRow.add(arrCol);
			
			dblloan_margin=(100-Double.parseDouble(Helper.correctDouble(strdblloan_margin)));
			
			double dbl_EligibleLimit=0.00;
			
			dbl_EligibleLimit=(dblloan_margin*dbl_TotLimitEligible)/100;//Margin Required
			
			
			arrCol = new ArrayList();
			if(dblInsurance>0)
			arrCol.add("<b>"+nf.format(dblloan_margin)+" % of Total Cost [1] "+"</b>");
			else
			arrCol.add("<b>"+nf.format(dblloan_margin)+" % of Eligible Limit "+"</b>");
			arrCol.add("<b>"+nf.format(dbl_EligibleLimit)+"</b>");
			arrRow.add(arrCol);
			
			dbl_EligibleLimit=Math.min(dbl_EligibleLimit, dbl_SancAmount);
			
			arrCol = new ArrayList();
			arrCol.add("<b>"+"Limit applied  [2]"+"</b>");
			arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>");
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("<b>"+"MPBF (Maximum Permissible Bank Finance] [Lease of 1,2]"+"</b>");
			arrCol.add("<b>"+nf.format(dbl_EligibleLimit)+"</b>");
			arrRow.add(arrCol);
			
			
			hshRecord.put("arrAssessment",arrRow);
			hshRecord.put("EligibleBasedonCost", String.valueOf(nf.format(dbl_EligibleLimit)));	

			if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{	
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i1=0;i1<arrRow.size();i1++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i1);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add(Integer.toString(i1+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","").replace("%","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
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

	
	private	HashMap updateLeasencashdata(HashMap hshValues)  
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null;
	
		String strAppNo="";
		String strPropType="",strQuery="";
		String strPrdType=null;
		String strprocode=null;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		double dbl_CostotProject=0.00;  
	    double dbl_Sepnetrent=0.00;
		int dbl_septimesrent=0;
		double dbl_promargin=0.00;
		double dbl_NetrentReceivable=0.00;
		double dbl_PernetRent=0.00;
		int dbl_Timesofabove=0;
		double dbl_Tottimesofabove1=0;
		double dbl_Tottimesofabove=0.00;
		double dbl_SancAmount=0.00;
	
		double dbl_Surrendar=0.00;
	//	String strLeasencash[]={"Gross Rent","Net Rent receivable","of Net Rent","times of above"};
		try
		{
			strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			strprocode=Helper.correctNull((String)hshValues.get("prdcode"));
			
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}  
			if(strPrdType.equalsIgnoreCase("PL"))
			{
			    strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+strAppNo);
			
			}
			else if(strPrdType.equalsIgnoreCase("PI"))
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductInstaCash^"+strAppNo);
			}
			
			rs = DBUtils.executeQuery(strQuery);
						
			if(rs.next())
			{
				dbl_CostotProject=Double.parseDouble(Helper.correctDouble(rs.getString("loan_mongrossrent")));
				dbl_promargin=((100) -(Double.parseDouble(Helper.correctDouble(rs.getString("margin_perct")))));
				dbl_SancAmount= Double.parseDouble(Helper.correctDouble(rs.getString("recmdamt"))); //added by gaensan for Limit applied field
				dbl_Surrendar= Double.parseDouble(Helper.correctDouble((String)rs.getString("cloanprd"))); //added by gaensan for Limit applied field 
			}
			
		if(strPrdType.equalsIgnoreCase("PL"))
		{
			
					arrCol = new ArrayList();
					arrCol.add("<b>"+"Limit Applied [1]"+"</b>"); 
					arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>"); 
					arrRow.add(arrCol);
			
			
					if(rs !=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_proleasedloandetails^"+strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dbl_Timesofabove=Integer.parseInt(Helper.correctInt(rs.getString("loan_Timesofabove")));
					}
					
					if(rs !=null)
					{
						rs.close();
					}
					
					strQuery = SQLParser.getSqlQuery("sel_specificeligible^"+strprocode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						
						dbl_Sepnetrent=Double.parseDouble(Helper.correctDouble(rs.getString("prd_leasenrReceivable")));
						dbl_septimesrent=Integer.parseInt(Helper.correctInt(rs.getString("prd_leasenrTimes")));
						
					}
					
					dbl_NetrentReceivable=(dbl_CostotProject-((dbl_CostotProject*dbl_Sepnetrent)/100));
					
					dbl_PernetRent=((dbl_NetrentReceivable*dbl_promargin)/100);//magin*netrentrecived/100;
					
					dbl_Tottimesofabove=dbl_Timesofabove*dbl_PernetRent;
					
					arrCol = new ArrayList();
					arrCol.add("Monthly Gross Rent");
					arrCol.add(nf.format(dbl_CostotProject)); 
					arrRow.add(arrCol);
					
					arrCol = new ArrayList();
					arrCol.add("Monthly Net Rent Receivable");
					arrCol.add(nf.format(dbl_NetrentReceivable)); 
					arrRow.add(arrCol);
					
					arrCol = new ArrayList();
					arrCol.add(nf.format(dbl_promargin)+ " % of Monthly Net Rent");
					arrCol.add(nf.format(dbl_PernetRent)); 
					arrRow.add(arrCol);
					
					arrCol = new ArrayList();
					arrCol.add(String.valueOf(dbl_Timesofabove)+" Times of Above"); 
					arrCol.add(nf.format(dbl_Tottimesofabove)); 
					arrRow.add(arrCol);
					dbl_Tottimesofabove1=dbl_Tottimesofabove;
					
					if(dbl_Timesofabove != dbl_septimesrent)
					{
						dbl_Tottimesofabove=dbl_PernetRent*dbl_septimesrent;
						arrCol = new ArrayList();
						arrCol.add(String.valueOf(dbl_septimesrent) + " Times of Net Rent"); 
						arrCol.add(nf.format(dbl_Tottimesofabove)); 
						arrRow.add(arrCol);
						dbl_Tottimesofabove1=Math.min(dbl_Tottimesofabove1, dbl_Tottimesofabove);
					}
					
					dbl_Tottimesofabove1=Math.min(dbl_Tottimesofabove1,dbl_SancAmount);
					
						arrCol = new ArrayList();
						arrCol.add("<b>"+"MPBF (Maximum Permissible Bank Finance) "+"</b>"); 
						arrCol.add("<b>"+nf.format(dbl_Tottimesofabove1)+"</b>"); 
						arrRow.add(arrCol);
					
		}
		if(strPrdType.equalsIgnoreCase("PI"))// this is the INSTACASH LOAN calculations 
			
		{
			/*arrCol = new ArrayList();
			arrCol.add("Surrendar Value"); 
			arrCol.add(nf.format(dbl_Surrendar)); 
			arrRow.add(arrCol);
*/
			//dbl_Tottimesofabove1=((dbl_Surrendar*dbl_promargin)/100); //
			
			arrCol = new ArrayList();
			arrCol.add("<b>"+"Limit Applied [1]"+"</b>"); 
			arrCol.add("<b>"+nf.format(dbl_SancAmount)+"</b>"); 
			arrRow.add(arrCol);
			
			if(rs !=null)
			{
				rs.close();
			}
			double eligibleamt=0.00;
			rs=DBUtils.executeLAPSQuery("sel_instacash^"+strAppNo);
			while(rs.next()){
				eligibleamt=eligibleamt+Double.parseDouble(Helper.correctDouble((String)rs.getString("insta_eligibleamt")));
			}
			arrCol = new ArrayList();
			arrCol.add("Total Eligible Loan Amount [2]"); 
			arrCol.add(nf.format(eligibleamt)); 
			arrRow.add(arrCol);
			
			eligibleamt=Math.min(eligibleamt,dbl_SancAmount);
			
			arrCol = new ArrayList();
			arrCol.add("<b>"+"MPBF  Lease of [1,2]"+"</b>"); 
			arrCol.add("<b>"+nf.format(eligibleamt)+"</b>"); 
			arrRow.add(arrCol);
			dbl_Tottimesofabove1=eligibleamt;
			
		}
		
		           hshResult.put("arrAssessment", arrRow);
			       hshResult.put("strEligibleLoanAmt",nf.format(dbl_Tottimesofabove1));//mpbf value
	
			       
			    if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
				{
			       HashMap hshQuery = new HashMap();
					ArrayList arrValues = new ArrayList();
					ArrayList arrValuesCol = new ArrayList();
					HashMap hshQueryValues = new HashMap();
					int intUpdatesize=1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strAppNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_per_assessment_details");
					hshQueryValues.put("1",hshQuery);
					int intsize=2;
					for(int i=0;i<arrRow.size();i++)
					{
						arrValuesCol= (ArrayList) arrRow.get(i);
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						arrValues.add(strAppNo);
						arrValues.add("1");
						arrValues.add(Integer.toString(i+1));
						arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
						arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
						//arrValues.add("C");
						if(((String)arrValuesCol.get(1)).equals(""))
						{
							arrValues.add("H");
						}
						else
						{
							arrValues.add("C");
						}
						arrValues.add("C");
						hshQuery.put("arrValues",arrValues);	
						hshQuery.put("strQueryId","ins_per_assessment_details");
						hshQueryValues.put(Integer.toString(intsize),hshQuery);
						intsize++;
					}
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");    
				}
			
		}
		
			catch(Exception ce)
			{
				throw new EJBException("Error in updateLeasencashdata "+ce.toString());
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
	private	HashMap updateSuvidhadata(HashMap hshValues)  
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		HashMap hshResult = new HashMap();
		ResultSet rs=null;
	
		String strAppNo="";
		String strQuery="";
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		double dbl_promargin=0.00;
	
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}  
			
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+strAppNo);
			
			
			rs = DBUtils.executeQuery(strQuery);
						
			if(rs.next())
			{
				dbl_promargin=((100) -(Double.parseDouble(Helper.correctDouble(rs.getString("loan_margin")))));
			}
			
			double dblCollateral=0.00,dblCollateralEligible=0.00;
			if(rs !=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_residentialpropertysum1^11','12','5','7^"+ strAppNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				dblCollateral=Double.parseDouble(Helper.correctDouble(rs.getString("secvalue")));
			}
			if(rs !=null)
			{
				rs.close();
			}
			
			dblCollateralEligible=(dbl_promargin/100)*dblCollateral;
			
			arrCol = new ArrayList();
			arrCol.add("Market Value of the property");
			arrCol.add(nf.format(dblCollateral)); 
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add(nf.format(dbl_promargin)+" % Market Value of the property");
			arrCol.add(nf.format(dblCollateralEligible)); 
			arrRow.add(arrCol);
			
			hshResult.put("arrAssessment", arrRow);
			hshResult.put("EligibleBasedonCost",nf.format(dblCollateralEligible));//mpbf value
		
		    if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
		    {
				HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppNo);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					//arrValues.add("C");
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		    }
		}
		
			catch(Exception ce)
			{
				throw new EJBException("Error in updateSuvidhadata "+ce.toString());
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
	private	HashMap updateLoanAgainstshareData(HashMap hshValues)  
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null,rs1=null;
	
		String strAppNo="",strAppstatus="",strProcessDate="";
		String strQuery="";
		double dblMargin=0.0,dblReqAmt=0.00,dblSecValue=0.0,dblMaxLimit=0.0;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}  
			
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+strAppNo);
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMargin=((100) -(Double.parseDouble(Helper.correctDouble(rs.getString("loan_margin")))));
				dblReqAmt=Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd")));
				dblMaxLimit=Double.parseDouble(Helper.correctDouble(rs.getString("rangeto")));
				strAppstatus=Helper.correctNull(rs.getString("status"));
				strProcessDate=Helper.correctNull(rs.getString("app_processdate"));
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_totalprimesecval^"+strAppNo);
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblSecValue=Double.parseDouble(Helper.correctDouble(rs.getString("totalsec")));
			}
			
			
			arrCol = new ArrayList();
			arrCol.add("Amount Requested [1]");
			arrCol.add(nf.format(dblReqAmt)); 
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("Share Value");
			arrCol.add(nf.format(dblSecValue)); 
			arrRow.add(arrCol);
			
			dblSecValue=dblSecValue*(dblMargin/100);
			
			arrCol = new ArrayList();
			arrCol.add(nf.format(dblMargin) +" % of Share Value [2]");
			arrCol.add(nf.format(dblSecValue)); 
			arrRow.add(arrCol);
			
			arrCol = new ArrayList();
			arrCol.add("Maximum Eligible Limit Based on Scheme [3]");
			arrCol.add(nf.format(dblMaxLimit)); 
			arrRow.add(arrCol);
			
			dblReqAmt=Math.min(dblReqAmt,dblSecValue);
			dblReqAmt=Math.min(dblReqAmt,dblMaxLimit);
			
			String strMaxPaidPercOurBank="",strMaxPaidPercOthers="";
			double dblKBLPaidup=0,dblOtherPaidup=0;
			
			if(rs!=null)
				rs.close();
			
			if(!(strAppstatus.equalsIgnoreCase("op")||strAppstatus.equalsIgnoreCase("ol")))
				strQuery = SQLParser.getSqlQuery("sel_masterpercent^109','110^"+strProcessDate+"^ ");
			else
				strQuery = SQLParser.getSqlQuery("sel_masterpercent^109','110^"+Helper.getCurrentDateTime()+"^ and LOAN_PARAM_ACTIVEFLAG='Y'");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strMaxPaidPercOurBank.equalsIgnoreCase("")||strMaxPaidPercOthers.equalsIgnoreCase(""))
				{
					if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("109") && strMaxPaidPercOurBank.equalsIgnoreCase(""))
						strMaxPaidPercOurBank=Helper.correctNull(rs.getString("loan_paramval"));
					if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("110") && strMaxPaidPercOthers.equalsIgnoreCase(""))
						strMaxPaidPercOthers=Helper.correctNull(rs.getString("loan_paramval"));
				}
			}
			
			if(!strMaxPaidPercOurBank.equalsIgnoreCase(""))
			{
				
				if(rs!=null)
					rs.close();
				
				rs = DBUtils.executeLAPSQuery("selcompanymaster_comname^000000001");
				if(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add("Karnataka Bank Paid up capital and reserves total");
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup")))+
							Double.parseDouble(Helper.correctDouble(rs.getString("svm_companyreservescapital"))))); 
					arrRow.add(arrCol);
					
					dblKBLPaidup=((Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup")))+
							Double.parseDouble(Helper.correctDouble(rs.getString("svm_companyreservescapital"))))*(Double.parseDouble(strMaxPaidPercOurBank)))/100;
					arrCol = new ArrayList();
					arrCol.add(strMaxPaidPercOurBank+" % Paid up capital for Karnataka Bank   [4]");
					arrCol.add(nf.format(dblKBLPaidup)); 
					arrRow.add(arrCol);
				}
				
			}
			if(!strMaxPaidPercOthers.equalsIgnoreCase(""))
			{
				boolean boolflag=false;
				if(rs1!=null)
					rs1.close();
				ArrayList arrVal=new ArrayList();
				
				rs1 = DBUtils.executeLAPSQuery("sel_loanagainstsharesec^"+strAppNo+"^1");
				while(rs1.next())
				{
					boolflag=true;
					if(!arrVal.contains(Helper.correctNull(rs1.getString("CUS_COMPANYCODE"))))
					{
						arrVal.add(Helper.correctNull(rs1.getString("CUS_COMPANYCODE")));
						
						if(rs!=null)
							rs.close();
						rs = DBUtils.executeLAPSQuery("selcompanymaster_comname^"+Helper.correctNull(rs1.getString("CUS_COMPANYCODE")));
						if(rs.next())
						{
							arrCol = new ArrayList();
							arrCol.add(Helper.correctNull(rs.getString("svm_companyname"))+" Paid up capital");
							arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup"))))); 
							arrRow.add(arrCol);
							
							arrCol = new ArrayList();
							arrCol.add(strMaxPaidPercOthers+" % Paid up capital for "+Helper.correctNull(rs.getString("svm_companyname")));
							arrCol.add(nf.format(((Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup"))))*(Double.parseDouble(strMaxPaidPercOthers)))/100)); 
							arrRow.add(arrCol);
							dblOtherPaidup+=((Double.parseDouble(Helper.correctDouble(rs.getString("svm_companypaidup"))))*(Double.parseDouble(strMaxPaidPercOthers)))/100;
						}
					}
				}
				
				if(boolflag)
				{
					arrCol = new ArrayList();
					arrCol.add("Sum of all the Companies Paid up Capital [5]");
					arrCol.add(nf.format(dblOtherPaidup)); 
					arrRow.add(arrCol);
				}
			}
			
			dblReqAmt=Math.min(dblReqAmt,dblKBLPaidup);
			dblReqAmt=Math.min(dblReqAmt,dblOtherPaidup);
			
			arrCol = new ArrayList();
			arrCol.add("MPBF (Maximum Permissable Bank Finance] [Least of 1,2,3,4,5]");
			arrCol.add(nf.format(dblReqAmt)); 
			arrRow.add(arrCol);
			
		
		    hshResult.put("arrAssessment", arrRow);
			hshResult.put("strEligibleLoanAmt",nf.format(dblReqAmt));//mpbf value
	
			       
		    if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{
		       HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppNo);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");    
			}
			
		}
		
			catch(Exception ce)
			{
				throw new EJBException("Error in updateLoanAgainstshareData "+ce.toString());
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
	private	HashMap updateBusinessLoanData(HashMap hshValues)  
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		ResultSet rs=null,rs1=null;
	
		String strAppNo="",strAppstatus="",strProcessDate="";
		String strQuery="";
		double dblReqAmt=0.00,dblTotal=0.0,dblAverage=0.0;
		int intCount=0;
		
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			
			if(strAppNo.equalsIgnoreCase(null) || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("strappno"));
			}  
			
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+strAppNo);
			
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblReqAmt=Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd")));
			}
			
			arrCol = new ArrayList();
			arrCol.add("Limit Applied [1]");
			arrCol.add(nf.format(dblReqAmt)); 
			arrRow.add(arrCol);
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("gst_newAssemnt_businLoanQuick^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intCount=24;
			}
			if(rs!=null)
				rs.close();
			int counter=0;
			rs=DBUtils.executeLAPSQuery("sel_gstreturndetails^"+strAppNo);
			while (rs.next()) 
			{
				if(intCount == 24)
				{
					arrCol = new ArrayList();
					if(counter ==0)
						arrCol.add("GST Returns for FY  "+Helper.correctNull(rs.getString("gst_year"))+" (A)");
					else
						arrCol.add("GST Returns for FY  "+Helper.correctNull(rs.getString("gst_year"))+" (B)");
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt"))))); 
					arrRow.add(arrCol);
					
					if(Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt")))>0)
					{
						dblTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt")));
					}
					counter++;
				}else
				{
					arrCol = new ArrayList();
					arrCol.add("GST Return for the Year "+Helper.correctNull(rs.getString("gst_year")));
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt"))))); 
					arrRow.add(arrCol);
					
					if(Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt")))>0)
					{
						dblTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt")));
						intCount++;
					}
				}
			}
			if(rs!=null)
				rs.close();
			
			if(intCount>0)
			dblAverage = dblTotal/intCount;
			
			log.info("Before ASSESMENT_SETUP_QUICKBUSSLOAN function");
			CallableStatement cstmt=null;
			Connection conn=null;String returnVal="";
			String Retval[]=null;
			conn= getConnection();
			cstmt = conn.prepareCall("{? = call ASSESMENT_SETUP_QUICKBUSSLOAN(?)}");
			cstmt.registerOutParameter(1, Types.VARCHAR);
			cstmt.setString(2, strAppNo);
			cstmt.executeUpdate();
			returnVal = Helper.correctNull(cstmt.getString(1));
			log.info("After ASSESMENT_SETUP_QUICKBUSSLOAN function : " + returnVal);
			conn.close();
			cstmt.close();
			Retval = returnVal.split("@");
			if(intCount==24)
			{
				
				arrCol = new ArrayList();
				arrCol.add("Average Returns for 24 Months  {C=(A+B)/24}");
				arrCol.add(nf.format(dblAverage)); 
				arrRow.add(arrCol);
				
				dblAverage =  dblAverage * Double.parseDouble(Helper.correctDouble(Retval[0]));
				
				arrCol = new ArrayList();
				arrCol.add("Eligible Limit (2) ("+Retval[0]+" times of C)");
				arrCol.add(nf.format(dblAverage)); 
				arrRow.add(arrCol);
				
			}else
			{
				arrCol = new ArrayList();
				arrCol.add("Average Returns [A]");
				arrCol.add(nf.format(dblAverage)); 
				arrRow.add(arrCol);
				
				dblAverage=dblAverage*Double.parseDouble(Helper.correctDouble(Retval[0]));
				arrCol = new ArrayList();
				arrCol.add(Retval[0]+" times of (A) [B] ");
				arrCol.add(nf.format(dblAverage)); 
				arrRow.add(arrCol);
				
				dblAverage=dblAverage*Double.parseDouble(Helper.correctDouble(Retval[1]));
				dblAverage=dblAverage/100;
				arrCol = new ArrayList();
				arrCol.add("Eligible Limit "+Retval[1]+" % of (B) [2]");
				arrCol.add(nf.format(dblAverage)); 
				arrRow.add(arrCol);
				
				/*if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("selloanagainstparams^125");
				if (rs.next()) 
				{
					dblAverage=dblAverage*Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("LOAN_PARAMVAL"))+" times of (A) [B] ");
					arrCol.add(nf.format(dblAverage)); 
					arrRow.add(arrCol);
									
				}
				else
				{
					dblAverage=0.0;
					
					arrCol = new ArrayList();
					arrCol.add("0 times of (A) [B] ");
					arrCol.add(nf.format(dblAverage)); 
					arrRow.add(arrCol);
				}
				
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("selloanagainstparams^126");
				if (rs.next()) 
				{
					dblAverage=dblAverage*Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					dblAverage=dblAverage/100;
					arrCol = new ArrayList();
					arrCol.add("Eligible Limit "+Helper.correctNull(rs.getString("LOAN_PARAMVAL"))+" % of (B) [2]");
					arrCol.add(nf.format(dblAverage)); 
					arrRow.add(arrCol);
									
				}
				else
				{
					dblAverage=0.0;
					
					arrCol = new ArrayList();
					arrCol.add("Maximum Permissable Bank Finance [2]");
					arrCol.add(nf.format(dblAverage)); 
					arrRow.add(arrCol);
				}*/
			}
			dblAverage=Math.min(dblAverage,dblReqAmt);
			arrCol = new ArrayList();
			arrCol.add("Maximum Permissable Bank Finance Least of [1,2]");
			arrCol.add(nf.format(dblAverage)); 
			arrRow.add(arrCol);
			
			
			
			
			
			
			
		    hshResult.put("arrAssessment", arrRow);
			hshResult.put("strEligibleLoanAmt",nf.format(dblAverage));//mpbf value
	
			       
		    if(Helper.correctNull((String)hshValues.get("hidPageId")).equals("comwrflw"))
			{
		       HashMap hshQuery = new HashMap();
				ArrayList arrValues = new ArrayList();
				ArrayList arrValuesCol = new ArrayList();
				HashMap hshQueryValues = new HashMap();
				int intUpdatesize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppNo);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_per_assessment_details");
				hshQueryValues.put("1",hshQuery);
				int intsize=2;
				for(int i=0;i<arrRow.size();i++)
				{
					arrValuesCol= (ArrayList) arrRow.get(i);
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add(Integer.toString(i+1));
					arrValues.add(((String)arrValuesCol.get(0)).replace("<b>", "").replace("</b>","") );
					arrValues.add(((String)arrValuesCol.get(1)).replace("<b>", "").replace("</b>","") );
					if(((String)arrValuesCol.get(1)).equals(""))
					{
						arrValues.add("H");
					}
					else
					{
						arrValues.add("C");
					}
					arrValues.add("C");
					hshQuery.put("arrValues",arrValues);	
					hshQuery.put("strQueryId","ins_per_assessment_details");
					hshQueryValues.put(Integer.toString(intsize),hshQuery);
					intsize++;
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");    
			}
			
		}
		
			catch(Exception ce)
			{
				throw new EJBException("Error in updateLoanAgainstshareData "+ce.toString());
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
}



