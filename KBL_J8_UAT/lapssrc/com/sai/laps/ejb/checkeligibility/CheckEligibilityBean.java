package com.sai.laps.ejb.checkeligibility;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.retailassessment.RetailAssessmentBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "CheckEligibilityBean", mappedName = "CheckEligibilityHome")
@Remote (CheckEligibilityRemote.class)
public class CheckEligibilityBean extends BeanAdapter
{
	String strEligCondition="";
	String strEligRequired="";
	String strEligAvailable="";
	String strEligStatus="";
	static Logger log=Logger.getLogger(CheckEligibilityBean.class);	
	/**
	 * @author:Karthikeyan.S
	 * @category Eligibility Check
	 * @return HashMap
	 * @
	 */
	public HashMap getEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshValuesnew=new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrayListRow = new ArrayList();
		ArrayList arrayListCol = new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrayRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strQuery = "",strQuery1="",strEligibiltychk="",strGreater=">=",strLesser="<=";
		int intCount=0,intEligibleParam=0;
		String strAppno = Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		}
		String strPrdType = Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdTypefromcommwrkflwbean = Helper.correctNull((String)hshValues.get("prdtype"));
		String strappstatus = Helper.correctNull((String)hshValues.get("appstatus1"));
		String dev_approval="",strPrdCode="",strConstitution="";
		String strLoanType=Helper.correctNull((String)hshValues.get("schemeCode"));
		String strIsdeviated="";
		try
		{
			if(!strAppno.equalsIgnoreCase(""))
			{
				//--------------Start For Getting Application Status from Database---------------
				if(strappstatus.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("commworkflowsel2^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strappstatus = correctNull((String)rs.getString("app_status"));
						strPrdCode = correctNull(rs.getString("app_prdcode"));
						hshValues.put("prdcode",Helper.correctNull(rs.getString("app_prdcode")));
					}
					if(rs!=null)
					{
						rs.close();
					}
				}
				if(strLoanType.equalsIgnoreCase(""))
				{
					rs=DBUtils.executeLAPSQuery("findapptypeoffline^"+strAppno);
					if(rs.next())
					{
						strLoanType = Helper.correctNull(rs.getString("PRD_LOANTYPE"));
					}
					
				}
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_shareheldwomen^"+strAppno);
				if(rs.next())
				{
					strConstitution = Helper.correctNull(rs.getString("perapp_constitutionnew"));
				}
				
				//--------------End For Getting Application Status from Database---------------
				if(strappstatus.equalsIgnoreCase("op"))
				{
					if(strPrdType.equalsIgnoreCase("pH") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pH"))
					{
						hshRecord=getHousingLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pM") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pM"))
					{
						hshRecord=getMortgageLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pA") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pA"))
					{
						hshRecord=getVehicleLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pP") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pP"))
					{
						hshRecord=getSalaryLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pJ") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pJ"))
					{
						hshRecord=getGeneralLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pU") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pU"))
					{
						hshRecord=getMahilaUdyogLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pK") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pK"))
					{
						hshRecord=getRaviKiranLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pE") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pE"))
					{
						hshRecord=getEducationLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pL") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pL"))
					{
						hshRecord=getLeasedLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pI") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pI"))
					{
						hshRecord=getInstacashLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pV") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pV"))
					{
						hshRecord=getSuvidhaLoanEligibility(hshValues);
					}
					else if(strPrdType.equalsIgnoreCase("pB") || strPrdTypefromcommwrkflwbean.equalsIgnoreCase("pB"))
					{
						hshRecord=getBusinessLoanEligibility(hshValues);
					}
					arrayListRow=(ArrayList)hshRecord.get("arrRow");
					if(arrayListRow==null)
						arrayListRow = new ArrayList();
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^OC");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						String dev_request=Helper.correctNull((String)rs.getString("deviation_req"));
							dev_approval=Helper.correctNull((String)rs.getString("deviation_apprej"));
					}
					
					if(rs !=null)
					{
						rs.close();
					}
					String strProdPurpose="",strVehicleType="";
					strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
					strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
					/*
					 * 			For Purchase of Ready Built House and Used Vehicle loan, 
					 * 				Margin is based on age of the building / vehicle respectively
					 */
					if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strAppno);
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strAppno);
					}
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						strIsdeviated=Helper.correctNull((String)rs.getString("app_isdeviated"));
					}
					
					if((strConstitution.equalsIgnoreCase("01"))&&(!((strPrdType.equalsIgnoreCase("pU")&& strLoanType.equalsIgnoreCase("OD"))||strPrdType.equalsIgnoreCase("pR")||
							strPrdType.equalsIgnoreCase("pG")||strPrdType.equalsIgnoreCase("pE")||(strPrdType.equalsIgnoreCase("pL"))||
							(strPrdType.equalsIgnoreCase("pI") && strLoanType.equalsIgnoreCase("OD"))||
							(strPrdType.equalsIgnoreCase("pJ") && strLoanType.equalsIgnoreCase("OD"))||
							(strPrdType.equalsIgnoreCase("pM") && strLoanType.equalsIgnoreCase("OD"))||(strPrdType.equalsIgnoreCase("pV")&& strLoanType.equalsIgnoreCase("OD"))))
							&& !strPrdType.equalsIgnoreCase("pB")){
						RetailAssessmentBean rab=new RetailAssessmentBean();
						hshValuesnew=rab.getRepaymentCapacity(hshValues);
						String annaulincomenew=Helper.correctNull((String)hshValuesnew.get("dbl_perannualtot"));
						double Annualincome=Double.parseDouble((String)annaulincomenew);
						double eligibleincome=60.00;
						  
						int intApplicantOccupation=0;
						String strappid="";
						int int_applicant_occupation=0;
						double dbl_borr_income=0.00;
						double dbl_income_salaried=0.00, dbl_add_depreciation_year1=0.00, dbl_add_depreciation_year2=0.00,
						dbl_add_intonliab_year1=0.00, dbl_add_intonliab_year2=0.00, dbl_nonsal_inc_itr1=0.00, dbl_nonsal_inc_itr2=0.00,
						dbl_year1_nonsal_totalinc=0.00, dbl_year2_nonsal_totalinc=0.00, dbl_nonsal_totalinc=0.00, dbl_avg_nonsal_totalinc=0.00;
							strQuery1=SQLParser.getSqlQuery("sel_app_coapp_details^"+strAppno);
							rs1=DBUtils.executeQuery(strQuery1);
							
							while(rs1.next())
							{
								strappid=Helper.correctNull(rs1.getString("demo_appid"));
							
							if(!strappid.equalsIgnoreCase(""))
							{
								if(rs!=null)
									rs.close();
								rs=DBUtils.executeLAPSQuery("findBorrowerOrgCom^"+strappid);
								if(rs.next())
								{
									int_applicant_occupation=rs.getInt("perapp_employment");
								}
								if(rs1.getString("demo_type").equalsIgnoreCase("a"))
								{
									intApplicantOccupation=rs.getInt("perapp_employment");
								}
								if(rs!=null)
									rs.close();
								rs=DBUtils.executeLAPSQuery("assesment_sel_borr_income_details_appid^"+strappid);
								if(rs.next())
								{
									 dbl_income_salaried = rs.getDouble("perinc_takehome");
									 dbl_nonsal_inc_itr1 = rs.getDouble("nonsal_itry1");
									 dbl_nonsal_inc_itr2 = rs.getDouble("nonsal_itry2");
									 dbl_add_depreciation_year1 = rs.getDouble("depreciation1");
									 dbl_add_depreciation_year2 = rs.getDouble("depreciation2");
									 dbl_add_intonliab_year1 = rs.getDouble("intonliab1");
									 dbl_add_intonliab_year2 = rs.getDouble("intonliab2");
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
							  }
							}
								if(!strPrdCode.equalsIgnoreCase(""))
								{
									strQuery=SQLParser.getSqlQuery("selrepaycapacity^" + strLesser +"^"+dbl_borr_income+"^"+ strGreater +"^"+dbl_borr_income+"^"+strPrdCode);
									rs1 = DBUtils.executeQuery(strQuery);
									if(rs1.next())
									{
										if(intApplicantOccupation==1 || intApplicantOccupation==9)
										{
											eligibleincome=(100-rs1.getDouble("repay_salariedsustanece"));
										} 
										else 
										{
											eligibleincome=(100-rs1.getDouble("repay_nonsalariedsustanece"));
										}
										
									}
								}
								
								if(strIsdeviated.equalsIgnoreCase("Y"))
								{
									if (rs1!=null)
									{
										rs1.close();
									}
									strQuery = SQLParser.getSqlQuery("Sel_app_deviation^" + strAppno);
									rs1 = DBUtils.executeQuery(strQuery);
									while (rs1.next())
									{
										String strdeviationtype=Helper.correctNull((rs1.getString("deviation_type")));
										String strdeviationstatus=Helper.correctNull((rs1.getString("deviation_apprej")));
										if(strdeviationtype.equalsIgnoreCase("RC") && strdeviationstatus.equalsIgnoreCase("A"))
										{
											double dbldeviatedrepay=rs1.getDouble("deviation_newvalue");
											if(dbldeviatedrepay>0)
											{
												eligibleincome=dbldeviatedrepay;
											}
										}
									}
								}
							
						String eligibility="";
						if(Annualincome <= eligibleincome){
							eligibility="Eligible";
						}else{
							eligibility="Not Eligible";
							if(dev_approval.equalsIgnoreCase("A")){
										eligibility="Eligible";
									}else{
										eligibility="Not Eligible";
									}
							}
						if(!strPrdType.equalsIgnoreCase("pU")){
						arrayListCol=new ArrayList();
						arrayListCol.add("Annual Total loan Commitment to Total Annual Income (%)");
						arrayListCol.add(String.valueOf(eligibleincome));
						arrayListCol.add(annaulincomenew);
						arrayListCol.add(eligibility);
						arrayListRow.add(arrayListCol);
						}						
					}
					
					ArrayList arrPMRow=(ArrayList)hshRecord.get("arrPMRow");
					if(arrPMRow!=null && arrPMRow.size()>0)
					{
						for(int k = 0; k < arrPMRow.size(); k++) 
						{
							arrayListRow.add(arrPMRow.get(k));
						}
					}
					
					if(arrayListRow!=null && arrayListRow.size()>0)
					{
						for(int k = 0; arrayListRow!=null && k < arrayListRow.size(); k++) 
						{
							arrayListCol =(ArrayList)arrayListRow.get(k);
							if(arrayListCol != null)
							{
								if(Helper.correctNull((String)arrayListCol.get(3)).equalsIgnoreCase("Eligible"))
								{
									strEligibiltychk="Y";
									intEligibleParam++;
								}
								else if(Helper.correctNull((String)arrayListCol.get(3)).equalsIgnoreCase("not eligible"))
								{
									if(Helper.correctNull((String)arrayListCol.get(0)).equalsIgnoreCase("Maximum Age of Applicant")
											||Helper.correctNull((String)arrayListCol.get(0)).equalsIgnoreCase("Maximum Age of Applicant(Including Repayment Period)")||
											Helper.correctNull((String)arrayListCol.get(0)).equalsIgnoreCase("Minimum Age of Applicant"))
											{
												if(dev_approval.equalsIgnoreCase("A")){
													strEligibiltychk="Y";
													arrayListCol.set(3,"Eligible");
													intCount++;
													intEligibleParam++;
												}
											}
								}
								else{
									strEligibiltychk="N";
								}
							}
							else
							{
								arrayListRow.remove(k);
								k--;
							}
						}
						
						if(arrayListRow.size()==intEligibleParam)
						{
							strEligibiltychk="Y";
						}
						else
						{
							strEligibiltychk="N";
						}
					}
						if(strEligibiltychk.equalsIgnoreCase(""))
						{
							strEligibiltychk="Y";	
						}
						hshRecord.put("strEligibiltychk",strEligibiltychk);
						hshRecord.put("intCount",String.valueOf(intCount));
						hshRecord.put("arrRow",arrayListRow);
						
						
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("select_eligibility_sanc_history^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("elig_condition")));
						arrCol.add(Helper.correctNull((String)rs.getString("elig_required")));
						arrCol.add(Helper.correctNull((String)rs.getString("elig_available")));
						arrCol.add(Helper.correctNull((String)rs.getString("elig_status")));
						arrayRow.add(arrCol);
					}
					hshRecord.put("arrRow",arrayRow);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	
	
	private HashMap getHousingLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		ArrayList arrPMRow=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strQuery="", strWhetherTakeOver="", strLoanPurpose="", strReimbursement="", strRegMonths="", strConstitution="",strgovt_scheme="",strDigiLoan="";
		int strloan_reqterms=0;
		double strloan_recmdamt=0.00;
		int intAgeOfPremise=0, intResidualLife=0;
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);

			strQuery=SQLParser.getSqlQuery("findapptype^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanPurpose=Helper.correctNull(rs.getString("prd_purpose"));
				strDigiLoan=Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI"));
			}
			strQuery=SQLParser.getSqlQuery("getappamt^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strgovt_scheme=Helper.correctNull(rs.getString("govt_scheme"));
				strloan_recmdamt=Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt")));
				strloan_reqterms=Integer.parseInt(Helper.correctInt((String)rs.getString("loan_reqterms")));
			}
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
				
				hshTemp=new HashMap();
				hshValues.put("strCheck","CIBIL");
				hshTemp=getCIBILCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
			}
			
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getMinimumIncome(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			if(!strLoanPurpose.equalsIgnoreCase("T"))
			{
				
				if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
				{
				hshTemp=new HashMap();
				hshTemp=getGuarantorRelationCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				}
				
//				if(strLoanPurpose.equalsIgnoreCase("F"))
//				{
//					hshTemp=new HashMap();
//					hshTemp=getCollateralPercntCheck(hshValues);
//					arrCol=new ArrayList();
//					arrCol=(ArrayList)hshTemp.get("arrCol");
//					arrRow.add(arrCol);
//				}
			
			}
			if(!strLoanPurpose.equalsIgnoreCase("HC"))
			{
				if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
				{
				hshTemp=new HashMap();
				hshTemp=getGuarantorRelationCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				}
			}
			
			if(strLoanPurpose.equalsIgnoreCase("G")||strLoanPurpose.equalsIgnoreCase("H")||strLoanPurpose.equalsIgnoreCase("R") || strLoanPurpose.equalsIgnoreCase("S"))
			{
				strQuery=SQLParser.getSqlQuery("select_takeoverflag^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strWhetherTakeOver=Helper.correctNull(rs.getString("loan_takeover"));
					if(strWhetherTakeOver.equalsIgnoreCase("Y"))
					{
						hshValues.put("strLoanPurpose",strLoanPurpose);
						hshTemp=new HashMap();
						hshTemp=getTakeOverLoan(hshValues);
						arrCol=new ArrayList();
						arrCol=(ArrayList)hshTemp.get("arrCol");
						arrRow.add(arrCol);
					}
				}
			}
			
			if(strLoanPurpose.equalsIgnoreCase("G")){
				hshTemp=new HashMap();
				hshTemp=getMaxCoappGuarantor(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_per_house_proposed_asset^"+ strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intAgeOfPremise=Integer.parseInt(Helper.correctInt(rs.getString("phpa_premises_age")));
				intResidualLife=Integer.parseInt(Helper.correctInt(rs.getString("phpa_residual_life")));
			}
			if(strLoanPurpose.equalsIgnoreCase("H")&&intAgeOfPremise>0)
			{
				hshValues.put("intResidualLife",Integer.toString(intResidualLife));
				hshTemp=new HashMap();
				hshTemp=getLoanPeriodResidual(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			if(strDigiLoan.equalsIgnoreCase(""))
			{
				if((!(strLoanPurpose.equalsIgnoreCase("T")||strLoanPurpose.equalsIgnoreCase("F")||strLoanPurpose.equalsIgnoreCase("HC"))) && (strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02")))
				{
					hshTemp=new HashMap();
					hshTemp=getConfirmedService(hshValues);
					arrCol=new ArrayList();
					arrCol=(ArrayList)hshTemp.get("arrCol");
					arrRow.add(arrCol);
				}
			}
			
			
			if((strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02")))
			{
				String strResStat=""; 
				
				strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strResStat=Helper.correctNull(rs.getString("indinfo_resident_status"));
					if(strResStat.equalsIgnoreCase("Y")){
						hshTemp=new HashMap();
						hshValues.put("strConfServ",Helper.correctNull(rs.getString("peremp_confemp")));
						hshValues.put("strResStat",strResStat);
						hshValues.put("intServiceLeft",Helper.correctInt(rs.getString("peremp_servleft")));
						hshValues.put("dblPreviousEmployment",Helper.correctInt(rs.getString("peremp_expinyrs")));
						hshValues.put("dblcurrentEmployment",Helper.correctInt(rs.getString("presentempmonths")));
						
						
						hshTemp=getResidentialStatus(hshValues);
						arrCol=new ArrayList();
						arrCol=(ArrayList)hshTemp.get("arrCol");
						arrRow.add(arrCol);
						}
				}
			
			}
			/*if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pM"))
			{
				if(strConfServ.equalsIgnoreCase("1"))
				{
					if(strResStat.equalsIgnoreCase("N"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else if(strResStat.equalsIgnoreCase("Y"))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							intConfYears=Integer.parseInt(Helper.correctInt(rs1.getString("prd_minconfservice")));
						}
						if(intServiceLeft>=intConfYears)
						{
							strEligAvailable="Available";
							strEligStatus="Eligible";
						}
						else
						{
							strEligAvailable="Not Available";
							strEligStatus="Not Eligible";
						}
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else
				{
					strEligAvailable="Not Available";
					strEligStatus="Not Eligible";
				}
			}*/
			if(rs!=null)
			{
				rs.close();
			}
			
//			if(strLoanPurpose.equalsIgnoreCase("H")&&intAgeOfPremise>20)
//			{
//				hshTemp=new HashMap();
//				hshTemp=getLoanPeriodHouse(hshValues);
//				arrCol=new ArrayList();
//				arrCol=(ArrayList)hshTemp.get("arrCol");
//				arrRow.add(arrCol);
//			}
			
			if(strLoanPurpose.equalsIgnoreCase("T")||strLoanPurpose.equalsIgnoreCase("HC")){
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
//			hshTemp=new HashMap();
//			hshTemp=getResidentialOwner(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
			
//			strQuery=SQLParser.getSqlQuery("sel_propgeninfo_regmonths^"+strAppno);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strReimbursement=Helper.correctNull(rs.getString("escalation_status"));
//				strRegMonths=Helper.correctInt(rs.getString("reg_months"));
//			}
//			if((strLoanPurpose.equalsIgnoreCase("G")||strLoanPurpose.equalsIgnoreCase("H"))&&strReimbursement.equalsIgnoreCase("1"))
//			{
//				String strQuery5 = SQLParser.getSqlQuery("sel_applntloans^"+strAppId);
//				ResultSet rs5 = DBUtils.executeQuery(strQuery5);
//				if(!(rs5.next()))
//				{
//					hshValues.put("strRegMonths",strRegMonths);
//					hshTemp=new HashMap();
//					hshTemp=getReimbursement(hshValues);
//					arrCol=new ArrayList();
//					arrCol=(ArrayList)hshTemp.get("arrCol");
//					arrRow.add(arrCol);
//				}
//			}
			
			hshTemp=new HashMap();
			hshTemp=getEligibleConstitution(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			if(strgovt_scheme.equals("078") || strgovt_scheme.equals("079"))
			{
				hshTemp=new HashMap();
				if(rs!=null)
				{ rs.close(); 	}
				strQuery = SQLParser.getSqlQuery("sel_pmayAppl_master^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshTemp.put("PM_SUBCATEGORYFAMILY_INCOME", Helper.correctNull(rs.getString("PM_SUBCATEGORYFAMILY_INCOME")));
					hshTemp.put("PM_FEMALE_OWNERSHIP", Helper.correctNull(rs.getString("PM_FEMALE_OWNERSHIP")));
					hshTemp.put("PM_LOAN_SUBSIDY", Helper.correctNull(rs.getString("PM_LOAN_SUBSIDY")));
					hshTemp.put("PM_MAXLOAN_TENOR", Helper.correctNull(rs.getString("PM_MAXLOAN_TENOR")));
					hshTemp.put("PM_AREA", Helper.correctNull(rs.getString("PM_AREA")));
					hshTemp.put("PM_NRI_BORROWER", Helper.correctNull(rs.getString("PM_NRI_BORROWER")));
					hshTemp.put("PMAY_BORR_PUCCA", Helper.correctNull(rs.getString("PMAY_BORR_PUCCA")));
					hshTemp.put("PM_AADHAR_MANDATORY", Helper.correctNull(rs.getString("PM_AADHAR_MANDATORY")));
					hshTemp.put("PM_INTEREST_SUBSIDY", Helper.correctNull(rs.getString("PM_INTEREST_SUBSIDY")));
					hshTemp.put("PM_MAX_SUBSIDY", Helper.correctDouble(rs.getString("PM_MAX_SUBSIDY")));

				}
				
				if(rs!=null)
				{ rs.close(); 	}
				strQuery = SQLParser.getSqlQuery("sel_familyincomeoftheapplicant^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					double totalFamilysalary=Double.parseDouble(Helper.correctDouble((String)rs.getString("indinfo_family_income")));
					double pmaymasterincome=Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_SUBCATEGORYFAMILY_INCOME")));
					if(totalFamilysalary>pmaymasterincome)
					{
						strEligCondition="FAMILY ANNUAL INCOME (TOTAL)";
						strEligRequired=nf.format(pmaymasterincome);
						strEligAvailable=nf.format(totalFamilysalary);
						strEligStatus="Not Eligible";
					}
					else
					{
						strEligCondition="FAMILY ANNUAL INCOME (TOTAL)";
						strEligRequired=nf.format(pmaymasterincome);
						strEligAvailable=nf.format(totalFamilysalary);
						strEligStatus="Eligible";
					}
					arrCol=new ArrayList();
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					arrPMRow.add(arrCol);
				}
				
				if(rs!=null)
				{ rs.close(); 	}
				String femaleborrower="N";
				String PM_FEMALE_OWNERSHIP=Helper.correctNull((String)hshTemp.get("PM_FEMALE_OWNERSHIP"));
				strQuery = SQLParser.getSqlQuery("sel_perapp_femaleBorrower^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					femaleborrower="Y";
				}
				
				if(PM_FEMALE_OWNERSHIP.equals("Y"))
				{
					if(femaleborrower.equals("Y"))
					{
						strEligCondition="FEMALE OWNERSHIP";
						strEligRequired="Mandatory";
						strEligAvailable="Yes";
						strEligStatus="Eligible";
					}
					if(femaleborrower.equals("N"))
					{
						strEligCondition="FEMALE OWNERSHIP";
						strEligRequired="Mandatory";
						strEligAvailable="No";
						strEligStatus="Not Eligible";
					}
				}
				else
				{
					if(femaleborrower.equals("Y"))
					{
						strEligCondition="FEMALE OWNERSHIP";
						strEligRequired="Optional";
						strEligAvailable="Yes";
						strEligStatus="Eligible";
					}
					if(femaleborrower.equals("N"))
					{
						strEligCondition="FEMALE OWNERSHIP";
						strEligRequired="Optional";
						strEligAvailable="No";
						strEligStatus="Eligible";
					}
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				
				double PM_LOAN_SUBSIDY=Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_LOAN_SUBSIDY")));
				if(strloan_recmdamt>PM_LOAN_SUBSIDY)
				{
					strEligCondition="LOAN AMOUNT ELIGIBLE FOR SUBSIDY";
					strEligRequired=nf.format(PM_LOAN_SUBSIDY);
					strEligAvailable=nf.format(PM_LOAN_SUBSIDY);
					strEligStatus="Eligible";
					
					strloan_recmdamt=PM_LOAN_SUBSIDY;
				}
				else
				{
					strEligCondition="LOAN AMOUNT ELIGIBLE FOR SUBSIDY";
					strEligRequired=nf.format(PM_LOAN_SUBSIDY);
					strEligAvailable=nf.format(strloan_recmdamt);
					strEligStatus="Eligible";
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				arrCol=new ArrayList();
				arrCol.add("INTEREST SUBSIDY");
				arrCol.add(Helper.correctDouble((String)hshTemp.get("PM_INTEREST_SUBSIDY"))+" % ");
				arrCol.add(Helper.correctDouble((String)hshTemp.get("PM_INTEREST_SUBSIDY"))+" % ");
				arrCol.add("Eligible");
				arrPMRow.add(arrCol);
				
				
				
				int PM_MAXLOAN_TENOR=Integer.parseInt(Helper.correctInt((String)hshTemp.get("PM_MAXLOAN_TENOR")));
				if(strloan_reqterms>PM_MAXLOAN_TENOR)
				{
					strEligCondition="MAX. LOAN TENURE FOR INTEREST SUBSIDY";
					strEligRequired=PM_MAXLOAN_TENOR+" months";
					strEligAvailable=strloan_reqterms+" months";
					strEligStatus="Eligible";
					strloan_reqterms=PM_MAXLOAN_TENOR;
				}
				else
				{
					strEligCondition="MAX. LOAN TENURE FOR INTEREST SUBSIDY";
					strEligRequired=PM_MAXLOAN_TENOR+" months";
					strEligAvailable=strloan_reqterms+" months";
					strEligStatus="Eligible";
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				
				if(rs!=null)
				{ rs.close(); 	}
				double prophousearea=0.00;
				double PM_AREA=Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_AREA")));
				strQuery = SQLParser.getSqlQuery("sel_per_house_proposed_asset^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					prophousearea+=Double.parseDouble(Helper.correctDouble((String)rs.getString("PHPA_FLOORSPACE_AREA")));
				}
				prophousearea=Math.round(prophousearea*0.092903);
				if(prophousearea>PM_AREA && !strgovt_scheme.equals("078"))
				{
					strEligCondition="AREA OF THE HOUSE- CARPET AREA ";
					strEligRequired=PM_AREA +" SQ MT";
					strEligAvailable=prophousearea +" SQ MT";
					strEligStatus="Not Eligible";
				}
				else
				{
					strEligCondition="AREA OF THE HOUSE- CARPET AREA ";
					strEligRequired=PM_AREA +" SQ MT";
					strEligAvailable=prophousearea +" SQ MT";
					strEligStatus="Eligible";
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				
				if(rs!=null)
				{ rs.close(); 	}
				String INDINFO_RESIDENT_STATUS="";
				strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					INDINFO_RESIDENT_STATUS= Helper.correctNull((String)rs.getString("INDINFO_RESIDENT_STATUS"));
					if(INDINFO_RESIDENT_STATUS.equals("Y"))
						INDINFO_RESIDENT_STATUS="NRI";
					else
						INDINFO_RESIDENT_STATUS="Resident";	
				}
				String PM_NRI_BORROWER=Helper.correctNull((String)hshTemp.get("PM_NRI_BORROWER"));
				if(PM_NRI_BORROWER.equals("N") && (INDINFO_RESIDENT_STATUS).equals("NRI"))
				{
					strEligCondition="WHETHER NRI BORROWER IS ELIGIBLE ";
					strEligRequired=" No ";
					strEligAvailable=INDINFO_RESIDENT_STATUS;
					strEligStatus="Not Eligible";
				}
				else
				{
					strEligCondition="WHETHER NRI BORROWER IS ELIGIBLE ";
					strEligRequired="Yes";
					strEligAvailable=INDINFO_RESIDENT_STATUS;
					strEligStatus="Eligible";
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				String PMAY_BORR_PUCCA=Helper.correctNull((String)hshTemp.get("PMAY_BORR_PUCCA"));
				if(PMAY_BORR_PUCCA.equals("Y"))
					PMAY_BORR_PUCCA="Yes";
				else 
					PMAY_BORR_PUCCA="No";
				if(PMAY_BORR_PUCCA.equals("Yes"))
				{
					strEligCondition="WHETHER BORROWER OWNED A PUCCA HOUSE EITHER IN HIS/HER NAME OR IN NAME OF FAMILY MEMBER OF HIS/HER FAMILY IN ANY PART OF INDIA";
					strEligRequired=" No ";
					strEligAvailable=PMAY_BORR_PUCCA;
					strEligStatus="Not Eligible";
				}
				else
				{
					strEligCondition="WHETHER BORROWER OWNED A PUCCA HOUSE EITHER IN HIS/HER NAME OR IN NAME OF FAMILY MEMBER OF HIS/HER FAMILY IN ANY PART OF INDIA";
					strEligRequired=" No ";
					strEligAvailable=PMAY_BORR_PUCCA;
					strEligStatus="Eligible";
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				if(rs!=null)
				{ rs.close(); 	}
				String aadhaarfillFlag="Yes";
				String PM_AADHAR_MANDATORY=Helper.correctNull((String)hshTemp.get("PM_AADHAR_MANDATORY"));
				strQuery = SQLParser.getSqlQuery("sel_aadhaarCheck_appl^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					aadhaarfillFlag="No";
				}
				if(PM_AADHAR_MANDATORY.equals("N"))
				{
					strEligCondition="AADHAR MANDATORY";
					strEligRequired="Optional";
					if(aadhaarfillFlag.equals("Yes"))
						strEligAvailable="Available";
					else
						strEligAvailable="Not Available";
					strEligStatus="Eligible";
				}
				if(PM_AADHAR_MANDATORY.equals("Y"))
				{
					if(aadhaarfillFlag.equals("Yes"))
					{
						strEligCondition="AADHAR MANDATORY";
						strEligRequired="Mandatory";
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else if(aadhaarfillFlag.equals("No"))
					{
						strEligCondition="AADHAR MANDATORY";
						strEligRequired="Mandatory";
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				double dblRecmdAmt=strloan_recmdamt,dblintconcession=Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_INTEREST_SUBSIDY"))),dblval1=0.0,dblDemoninator=0.0,dblEMI=0.0,dblpercent=9.00;
				int intTenor=strloan_reqterms;
				dblval1=dblintconcession/1200;
				dblDemoninator=(Math.pow((1+dblval1), intTenor))-1;
				
				if(dblDemoninator!=0)
				{
					dblEMI=((dblRecmdAmt*dblval1)*(Math.pow((1+dblval1), intTenor)))/dblDemoninator;
				}
				
				double dblBVal=0.0,dblDVal=0.0,dblEVal=0.0,dblGVal=0.0;
				
				dblBVal=dblRecmdAmt;
				
				for(int i=1;i<=intTenor;i++)
				{
					dblDVal=(dblBVal*dblintconcession)/1200;
					dblEVal=dblEMI-dblDVal;
					dblBVal=dblBVal-dblEVal;
					dblGVal+=dblDVal/(Math.pow((1+dblpercent/1200), i));
				}
				
				strEligCondition="Maximum Subsidy";
				strEligRequired=nf.format(Math.round(Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_MAX_SUBSIDY")))));
				strEligAvailable=nf.format(Math.round(dblGVal));
				if(Double.parseDouble(Helper.correctDouble((String)hshTemp.get("PM_MAX_SUBSIDY")))>=Math.round(dblGVal))
					strEligStatus="Eligible";
				else
					strEligStatus="Not Eligible";
				
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrPMRow.add(arrCol);
				
				
				
			}
			
			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrPMRow",arrPMRow);
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getMortgageLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strLoanType=Helper.correctNull((String)hshValues.get("schemeCode"));
		String strQuery="", strWhetherTakeOver="", strLoanPurpose="", strReimbursement="", strDateOfReg="", strConstitution="";
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
				
				
				hshTemp=new HashMap();
				hshValues.put("strCheck","CIBIL");
				hshTemp=getCIBILCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			hshTemp=new HashMap();
			hshValues.put("strConstn", strConstitution);
			hshTemp=getIndividualSecurityCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			if(strLoanType.equalsIgnoreCase("TL"))
			{
				if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
				{
				
				hshTemp=new HashMap();
				hshTemp=getGuarantorRelationCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
				hshTemp=new HashMap();
				hshTemp=getMinimumIncome(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
				hshTemp=new HashMap();
				hshTemp=getEligibleConstitution(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
				hshTemp=new HashMap();
				hshTemp=getConfirmedService(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
				}
				
				if(strLoanType.equalsIgnoreCase("TL"))
				{
					hshTemp=new HashMap();
					hshTemp=getMaxCoappGuarantor(hshValues);
					arrCol=new ArrayList();
					arrCol=(ArrayList)hshTemp.get("arrCol");
					arrRow.add(arrCol);
				}
				
				
			}
			
			
			boolean bflag=true;
			strQuery=SQLParser.getSqlQuery("sel_residentialpropertysum^11','12','15^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(rs.getDouble("secvalue")>0)
				{
					bflag=false;
					arrCol=new ArrayList();
					arrCol.add("Type of Property  should be Residential / Commercial / Industrial");
					arrCol.add("Yes");
					arrCol.add("Yes");
					arrCol.add("Eligible");
					arrRow.add(arrCol);
				}
			}
			
			if(bflag)
			{
				arrCol=new ArrayList();
				arrCol.add("Type of Property  should be Residential / Commercial / Industrial");
				arrCol.add("Yes");
				arrCol.add("No");
				arrCol.add("Not Eligible");
				arrRow.add(arrCol);
			}
			
			if(rs!=null)
				rs.close();
			
			if(strLoanType.equalsIgnoreCase("OD"))
			{
				hshTemp=new HashMap();
				hshTemp=getMISClassification(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			
			if((strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02")) )
			{
				String strResStat=""; 
				
				strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strResStat=Helper.correctNull(rs.getString("indinfo_resident_status"));
					if(strResStat.equalsIgnoreCase("Y")){
						hshTemp=new HashMap();
						hshValues.put("strConfServ",Helper.correctNull(rs.getString("peremp_confemp")));
						hshValues.put("strResStat",strResStat);
						hshValues.put("intServiceLeft",Helper.correctInt(rs.getString("peremp_servleft")));
						hshValues.put("dblPreviousEmployment",Helper.correctInt(rs.getString("peremp_expinyrs")));
						hshValues.put("dblcurrentEmployment",Helper.correctInt(rs.getString("presentempmonths")));
						
						
						hshTemp=getResidentialStatus(hshValues);
						arrCol=new ArrayList();
						arrCol=(ArrayList)hshTemp.get("arrCol");
						arrRow.add(arrCol);
						}
				}
			
			}
//			hshTemp=new HashMap();
//			hshTemp=getMaxAppIncomeadd(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
			
			/*hshTemp=new HashMap();
			hshTemp=getResidentialOwner(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);*/
//			hshTemp=new HashMap();
//			hshTemp=getMortgageMinimumIncome(hshValues);
//			ArrayList arrMortRow= new ArrayList();
//			int size = Integer.parseInt(Helper.correctInt((String)hshTemp.get("size")));
//			arrMortRow = (ArrayList)hshTemp.get("arrRow");
//			for(int i=0;i<size;i++)
//			{				
//				arrCol=new ArrayList();
//				arrCol=(ArrayList)arrMortRow.get(i);
//				arrRow.add(arrCol);
//			}
//			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
//			{
//				hshTemp=new HashMap();
//				hshTemp=getConfirmedService(hshValues);
//				arrCol=new ArrayList();
//				arrCol=(ArrayList)hshTemp.get("arrCol");
//				arrRow.add(arrCol);
//			}
//			strQuery=SQLParser.getSqlQuery("sel_per_house_proposed_asset^"+strAppno);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strWhetherTakeOver=Helper.correctNull(rs.getString("phpa_take_over"));
//				strLoanPurpose=Helper.correctNull(rs.getString("phpa_loan_purpose"));
//				hshValues.put("strLoanPurpose",strLoanPurpose);
//				if(strWhetherTakeOver.equalsIgnoreCase("Y"))
//				{
//					hshTemp=new HashMap();
//					hshTemp=getTakeOverLoan(hshValues);
//					arrCol=new ArrayList();
//					arrCol=(ArrayList)hshTemp.get("arrCol");
//					arrRow.add(arrCol);
//				}
//			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getVehicleLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrRow1=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strQuery="", strWhetherTakeOver="", strVehicleType="", strVehicleCategory="", strEmpStat="", strConstitution="", strRegMonths="";
		String strRegistraionDt="",strCreatedDate="";
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			strQuery=SQLParser.getSqlQuery("selvehicletypecat^"+strAppno+"^A");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strVehicleType=Helper.correctNull(rs.getString("auto_vehicletype"));
				hshValues.put("strVehicleType", strVehicleType);
				strVehicleCategory=Helper.correctNull(rs.getString("auto_category"));
				strRegistraionDt=Helper.correctNull(rs.getString("registration_date"));
//				strWhetherTakeOver=Helper.correctNull(rs.getString("auto_take_over"));
//				if(strWhetherTakeOver.equalsIgnoreCase("Y"))
//				{
//					hshTemp=new HashMap();
//					hshTemp=getTakeOverLoan(hshValues);
//					arrCol=new ArrayList();
//					arrCol=(ArrayList)hshTemp.get("arrCol");
//					arrRow.add(arrCol);
//				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("compropform6^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCreatedDate=Helper.correctNull(rs.getString("app_createdate"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
				hshTemp=new HashMap();
				hshTemp=getConfirmedService(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
				if(strVehicleType.equalsIgnoreCase("3")||strVehicleType.equalsIgnoreCase("4"))
				{
					hshTemp=new HashMap();
					hshValues.put("strCheck","CIBIL");
					hshTemp=getCIBILCheck(hshValues);
					arrCol=new ArrayList();
					arrCol=(ArrayList)hshTemp.get("arrCol");
					arrRow.add(arrCol);
				}
			}
			
//			if(strVehicleType.equalsIgnoreCase("3"))
//			{
//				hshTemp=new HashMap();
//				hshTemp=getCollateralPercntCheck(hshValues);
//				arrCol=new ArrayList();
//				arrCol=(ArrayList)hshTemp.get("arrCol");
//				arrRow.add(arrCol);
//			}
			
			if(strVehicleType.equalsIgnoreCase("3"))
			{
				hshTemp=new HashMap();
				hshTemp=getMaxCoappGuarantor(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getGuarantorRelationCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			if(strVehicleType.equalsIgnoreCase("1"))
			{
				hshTemp=new HashMap();
				hshTemp=getMinimumIncome(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			}
			
			hshTemp=new HashMap();
			hshTemp=getMutualGuarantor(hshValues);
			arrRow1 = new ArrayList();			
			arrRow1 = (ArrayList)hshTemp.get("arrRow");
			if(arrRow1.size()>0 && arrRow1!=null)
			{
				for(int i=0;i<arrRow1.size();i++)
				{
					arrCol = new ArrayList();
					arrCol=(ArrayList)arrRow1.get(i);
					arrRow.add(arrCol);
				}
			}
			
			strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
			}
			if(strVehicleCategory.equalsIgnoreCase("2"))
			{
				hshValues.put("strVehicleCategory", strVehicleCategory);
				hshValues.put("strRegistraionDt", strRegistraionDt);
				hshValues.put("strCreatedDate", strCreatedDate);
				hshTemp=new HashMap();
				hshTemp=getLoanPeriod(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			else if(strVehicleType.equalsIgnoreCase("1"))
			{
				if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
				{
					hshValues.put("strVehicleType", strVehicleType);
					hshValues.put("strEmpStat", strEmpStat);
					hshTemp=new HashMap();
					hshTemp=getLoanPeriod(hshValues);
					arrCol=new ArrayList();
					arrCol=(ArrayList)hshTemp.get("arrCol");
					arrRow.add(arrCol);
				}
			}
			
			if(strVehicleType.equalsIgnoreCase("3"))
			{
				if(rs !=null)
				{
					rs.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_JointApplicants^"+strAppno+"^g','o");
				rs = DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					hshTemp=new HashMap();
					hshTemp=getCollateralPercntCheck(hshValues);
					arrCol=new ArrayList();
					arrCol=(ArrayList)hshTemp.get("arrCol");
					arrRow.add(arrCol);
				}
				
			}
//			if(rs!=null)
//			{
//				rs.close();
//			}
//			strQuery=SQLParser.getSqlQuery("sel_perauto_regmonths^"+strAppno);
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strRegMonths=Helper.correctInt((String)rs.getString("reg_months"));
//			}
		
//			if(strVehicleType.equalsIgnoreCase("3")&& strVehicleCategory.equalsIgnoreCase("1"))
//			{
//				String strQuery5 = SQLParser.getSqlQuery("sel_applntloans^"+strAppId);
//				ResultSet rs5 = DBUtils.executeQuery(strQuery5);
//				if(!(rs5.next()))
//				{
//					hshValues.put("strRegMonths",strRegMonths);
//					hshTemp=new HashMap();
//					hshTemp=getReimbursement(hshValues);
//					arrCol=new ArrayList();
//					arrCol=(ArrayList)hshTemp.get("arrCol");
//					arrRow.add(arrCol);
//				}
//			}
			
//			hshTemp=getGuarantorCheck(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
//			
			
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getSalaryLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strEmpStat="", strConstitution="";
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
//				hshTemp=new HashMap();
//				hshTemp=getConfirmedService(hshValues);
//				arrCol=new ArrayList();
//				arrCol=(ArrayList)hshTemp.get("arrCol");
//				arrRow.add(arrCol);
			}
			
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			hshTemp=new HashMap();
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=getEligibleConstitution(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			hshTemp=new HashMap();
			hshTemp=getMutualGuarantor(hshValues);
			ArrayList arrRow1 = new ArrayList();			
			arrRow1 = (ArrayList)hshTemp.get("arrRow");
			if(arrRow1.size()>0 && arrRow1!=null)
			{
				for(int i=0;i<arrRow1.size();i++)
				{
					arrCol = new ArrayList();
					arrCol=(ArrayList)arrRow1.get(i);
					arrRow.add(arrCol);
				}
			}			
			
			strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
			}
			if(strEmpStat.equalsIgnoreCase("1"))
			{
				hshValues.put("strEmpStat", strEmpStat);
				hshTemp=new HashMap();
				hshTemp=getLoanPeriod(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			if((strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
					&&strEmpStat.equalsIgnoreCase("1"))
			{
				hshTemp=new HashMap();
				hshTemp=getApplntCompany(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getGeneralLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strEmpStat="", strConstitution="";
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
							arrRow.add(arrCol2);
					}
				}
			}
			
			if(!(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9")))
			{
				hshTemp=new HashMap();
				hshValues.put("strEmpStat", strEmpStat);
				hshTemp=getLoanPeriod(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getMinimumIncome(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getMahilaUdyogLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="",strQuery="";
		ResultSet rs=null;
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				arrCol1=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
			}
			else if(!((Integer.parseInt(Helper.correctInt(strConstitution)) >=183) && (Integer.parseInt(Helper.correctInt(strConstitution)) <=191)))
			{   
				strQuery = SQLParser.getSqlQuery("sel_shareheldwomen^" + strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshValues.put("stakeheld_women", Helper.correctNull(rs.getString("perapp_stakeheld_women")));
				}
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=getEligibleConstitution(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			else if((Integer.parseInt(Helper.correctInt(strConstitution)) >=183) && (Integer.parseInt(Helper.correctInt(strConstitution)) <=191))
			{
				hshTemp=getEligibleConstitution(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			else
			{
				hshTemp=getEligibleConstitution(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
//			hshTemp=new HashMap();
//			hshTemp=getCollateralPercntCheck(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
			
			hshTemp=new HashMap();
			hshTemp=getMISClassification(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			/* Hided by Guhan T as per the bank requirement
			hshTemp=new HashMap();
			hshTemp=getCGTMSEScheme(strAppno);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);*/
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	
	private HashMap getLeasedLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="";
		String strQuery="";
		ResultSet rs=null;
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getAgeCheck(hshValues);
			arrCol1=new ArrayList();
			arrCol1=(ArrayList)hshTemp.get("arrCol");
			if(arrCol1!=null && arrCol1.size()>0)
			{
				for(int i=0;i<arrCol1.size();i++)
				{
					arrCol2=(ArrayList)arrCol1.get(i);
					if(arrCol2!=null && arrCol2.size()>0)
					arrRow.add(arrCol2);
				}
			}
			
			hshTemp=new HashMap();
			hshValues.put("strCheck","CIBIL");
			hshTemp=getCIBILCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");       
			arrRow.add(arrCol);
			
			
			strQuery = SQLParser.getSqlQuery("sel_emiornot^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()){
				
			String emi=Helper.correctNull((String)rs.getString("loan_repaymenttype"));
			if(emi.equalsIgnoreCase("1")){
			hshTemp=new HashMap();
			hshTemp=getEMIandRentEligibility(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			}
			/*hshTemp=new HashMap();
			hshTemp=getResidentialOwner(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);*/
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	
	private HashMap getInstacashLoanEligibility(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="",strQuery="";
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			
			hshTemp=new HashMap();
			hshTemp=getAgeCheck(hshValues);
			arrCol1=new ArrayList();
			arrCol1=(ArrayList)hshTemp.get("arrCol");
			if(arrCol1!=null && arrCol1.size()>0)
			{
				for(int i=0;i<arrCol1.size();i++)
				{
					arrCol2=(ArrayList)arrCol1.get(i);
					if(arrCol2!=null && arrCol2.size()>0)
					arrRow.add(arrCol2);
				}
			}
			}

			hshTemp=new HashMap();
			hshValues.put("strConstn", strConstitution);
			hshTemp=getIndividualSecurityCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			
			
			strQuery=SQLParser.getSqlQuery("selinstacashsectype^5^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add("Type of Security Must be NSC/KVP/Post Office TD");
				arrCol.add("Yes");
				arrCol.add("Yes");
				arrCol.add("Eligible");
				arrRow.add(arrCol);
			}
			else
			{
				arrCol=new ArrayList();
				arrCol.add("Type of Security Must be NSC/KVP/Post Office TD");
				arrCol.add("Yes");
				arrCol.add("No");
				arrCol.add("Not Eligible");
				arrRow.add(arrCol);
			}
			
			
//			if(rs!=null)
//				rs.close();
//			hshTemp=new HashMap();
//			hshTemp=getCollateralPercntCheck(hshValues);
//			arrCol=new ArrayList();
//			arrCol=(ArrayList)hshTemp.get("arrCol");
//			arrRow.add(arrCol);
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getSuvidhaLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="";
		try
		{
			
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getAgeCheck(hshValues);
			
			ArrayList arrCol1=new ArrayList();
			ArrayList arrCol2=new ArrayList();
			arrCol1=(ArrayList)hshTemp.get("arrCol");
			if(arrCol1!=null && arrCol1.size()>0)
			{
				for(int i=0;i<arrCol1.size();i++)
				{
					arrCol2=(ArrayList)arrCol1.get(i);
					if(arrCol2!=null && arrCol2.size()>0)
					arrRow.add(arrCol2);
				}
			}
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=getEligibleConstitution(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getConfirmedService(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
            
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getMinimumIncome(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);	
			}
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getRaviKiranLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="";
		try
		{
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);

			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getAgeCheck(hshValues);
			arrCol1=new ArrayList();
			arrCol1=(ArrayList)hshTemp.get("arrCol");
			if(arrCol1!=null && arrCol1.size()>0)
			{
				for(int i=0;i<arrCol1.size();i++)
				{
					arrCol2=(ArrayList)arrCol1.get(i);
					if(arrCol2!=null && arrCol2.size()>0)
					arrRow.add(arrCol2);
				}
			}
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=new HashMap();
			hshTemp=getConfirmedService(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getRaviKiranLoanEligibility "+e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getEducationLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="";
		String strQualifType="";
		String strMeritorious="";
		try
		{
			
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			
			String strQuery = SQLParser.getSqlQuery("eduparticularssel^"+strAppno);
			ResultSet rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strQualifType = Helper.correctNull((String)rs.getString("edu_qual_proposed"));
				strMeritorious = Helper.correctNull((String)rs.getString("EDU_MERITORIOUS"));
			}
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=getEligibleConstitution(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getGuarantorCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
			hshTemp=getAgeCheck(hshValues);
			ArrayList arrCol1=new ArrayList();
			arrCol1=(ArrayList)hshTemp.get("arrCol");
			if(arrCol1!=null && arrCol1.size()>0)
			{
				for(int i=0;i<arrCol1.size();i++)
				{
					ArrayList arrCol2=(ArrayList)arrCol1.get(i);
					if(arrCol2!=null && arrCol2.size()>0)
					arrRow.add(arrCol2);
				}
			}
			}
			
			hshTemp=new HashMap();
			hshTemp=getNationalityCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			if(strQualifType.equalsIgnoreCase("1") || strQualifType.equalsIgnoreCase("2") 
					|| strQualifType.equalsIgnoreCase("3") || strQualifType.equalsIgnoreCase("4")
					|| strMeritorious.equalsIgnoreCase("2"))
			{
				hshTemp=new HashMap();
				hshValues.put("strQualifType", strQualifType);
				hshTemp=getCoursebasedEligibility(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getRecogInstituteCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getEducationLoanEligibility "+e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getGuarantorCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strApplntType="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strRestype="";
		String strSaltoSB="";
		String strUndertkngletter="";
		String strApplntSatisfy="";
		String strRKsalrytoSB="";
		String strRKadeqInc="";
		int strBanksince=0;
		String strSecurityMort="N";
		int strNoofyrs=0;
		boolean boolGuarCheck=false;
		boolean boolJointAppCheck=false;
		boolean boolvehothers=false;
		boolean boolRKothers=false;
		
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			// If the Application is having any Joint Applicants, then should not insist for Guarantor/Co-obligant
			strQuery = SQLParser.getSqlQuery("sel_JointApplicants^" + strAppno + "^c");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				boolJointAppCheck=true;
			}
			if(strPrdType.equalsIgnoreCase("pA")||strPrdType.equalsIgnoreCase("pV")||strPrdType.equalsIgnoreCase("pK")||strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pH"))
				boolJointAppCheck=false;
				
			if(boolJointAppCheck!=true)
			{
				if(strPrdType.equalsIgnoreCase("pA"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery1 = SQLParser.getSqlQuery("sel_customerdetail^" + strAppId);
					rs=DBUtils.executeQuery(strQuery1); 
					while(rs.next())
					{
						strRestype = correctNull(rs.getString("CON_RESTYPE"));
						String strArr[]=Helper.correctNull(rs.getString("CON_YEARS")).split("~");
						strNoofyrs = Integer.parseInt(Helper.correctInt(strArr[0]));
					}
					
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery2 = SQLParser.getSqlQuery("selectvehicledetails1^A^"+strAppno);
					rs=DBUtils.executeQuery(strQuery2); 
					while(rs.next())
					{
						strSaltoSB = correctNull(rs.getString("AUTO_SALTOSB"));
						strUndertkngletter = correctNull(rs.getString("AUTO_UNDERTKNGLETTER"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery3 = SQLParser.getSqlQuery("sel_appsatisfy^"+strAppId);
					rs=DBUtils.executeQuery(strQuery3); 
					while(rs.next())
					{
						strApplntSatisfy = correctNull(rs.getString("PERAPP_SATISFACTORY"));
						strBanksince = Integer.parseInt(Helper.correctInt(rs.getString("bank_since")));
					}
					
					if((strRestype.equalsIgnoreCase("2") && strNoofyrs>=3)||strSaltoSB.equalsIgnoreCase("Y")
							||strUndertkngletter.equalsIgnoreCase("Y")||
							(strApplntSatisfy.trim().equalsIgnoreCase("Y") && strBanksince>=3))
					{
						boolvehothers = true;
					}
				}
				
				if(strPrdType.equalsIgnoreCase("pK"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery21 = SQLParser.getSqlQuery("sel_appsatisfy^"+strAppId);
					rs=DBUtils.executeQuery(strQuery21); 
					while(rs.next())
					{
						strApplntSatisfy = Helper.correctNull(rs.getString("PERAPP_SATISFACTORY"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery22 = SQLParser.getSqlQuery("sel_ravikiranelig^"+strAppno);
					rs=DBUtils.executeQuery(strQuery22); 
					if(rs.next())
					{
						strRKsalrytoSB = Helper.correctNull(rs.getString("SALARYTOSB"));
						strRKadeqInc = Helper.correctNull(rs.getString("ADEQUATE_INCOME"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					String strQuery23 = SQLParser.getSqlQuery("sel_securitymortgage^"+strAppId);
					rs=DBUtils.executeQuery(strQuery23); 
					if(rs.next())
					{
						strSecurityMort = "Y";
					}
					
					if((strApplntSatisfy.equalsIgnoreCase("Y") && strRKadeqInc.equalsIgnoreCase("Y")) ||
							(strSecurityMort.equalsIgnoreCase("Y") && strApplntSatisfy.equalsIgnoreCase("Y")) ||
						(strRKsalrytoSB.equalsIgnoreCase("Y")))
					{
						boolRKothers = true;
					}
				}
				
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("getcoappguarantor^" + strAppno);
					rs=DBUtils.executeQuery(strQuery); 
					while(rs.next())
					{
						strApplntType=Helper.correctNull(rs.getString("demo_type"));
						if(strPrdType.equalsIgnoreCase("pH"))
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
							if(strApplntType.equalsIgnoreCase("g")||strApplntType.equalsIgnoreCase("o"))
							{
								boolGuarCheck=true;
							}
						}
						if(strPrdType.equalsIgnoreCase("pA"))
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
							if(strApplntType.equalsIgnoreCase("g")||strApplntType.equalsIgnoreCase("o"))
							{
								boolGuarCheck=true;
							}
						}
						else if(strPrdType.equalsIgnoreCase("pM"))
						{
							if(Helper.correctNull((String)hshValues.get("schemeCode")).equalsIgnoreCase("OD"))
							{
								strEligCondition="Addition of Co-Obligant";
								if(strApplntType.equalsIgnoreCase("o"))
								{
									boolGuarCheck=true;
								}
							}
							else
							{
								strEligCondition="Addition of Guarantor";
								if(strApplntType.equalsIgnoreCase("g"))
								{
									boolGuarCheck=true;
								}
							}
						}
						else if(strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pV"))
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
							if(strApplntType.equalsIgnoreCase("g")||strApplntType.equalsIgnoreCase("o"))
							{
								boolGuarCheck=true;
							}
						}
						else if(strPrdType.equalsIgnoreCase("pK"))
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
							if(strApplntType.equalsIgnoreCase("g")||strApplntType.equalsIgnoreCase("o"))
							{
								boolGuarCheck=true;
							}
						}
						else if(strPrdType.equalsIgnoreCase("pE"))
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
							if(strApplntType.equalsIgnoreCase("g")||strApplntType.equalsIgnoreCase("o"))
							{
								boolGuarCheck=true;
							}
						}
					}
					if(strPrdType.equalsIgnoreCase("pV"))
						strEligCondition="Addition of Guarantor/Co-Obligant";
					
					strEligRequired="Required";
					if(boolGuarCheck==true)
					{
						strEligAvailable="Added";
						strEligStatus="Eligible";
					}
					else if(strPrdType.equalsIgnoreCase("pA") && boolvehothers==true)
					{
						strEligCondition="Addition of Guarantor";
						strEligAvailable="Added (Waiver)";
						strEligStatus="Eligible";
					}
					else if(strPrdType.equalsIgnoreCase("pK") && boolRKothers==true)
					{
						strEligCondition="Addition of Guarantor/Co-Obligant";
						strEligAvailable="Added (Waiver)";
						strEligStatus="Eligible";
					}					
					else
					{
						if(strPrdType.equalsIgnoreCase("pP") || strPrdType.equalsIgnoreCase("pK") )
						{
							strEligCondition="Addition of Guarantor/Co-Obligant";
						}
						else if(strPrdType.equalsIgnoreCase("pE")){
							strEligCondition="Addition of Joint Applicant";
						}
						else if(strPrdType.equalsIgnoreCase("pM") && Helper.correctNull((String)hshValues.get("schemeCode")).equalsIgnoreCase("OD")){
							strEligCondition="Addition of Co-obligant";
						}
						else
						{
							strEligCondition="Addition of Guarantor";
						}
						strEligAvailable="Not Added";
						strEligStatus="Not Eligible";
					}
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					hshRecord.put("arrCol", arrCol);
				}
			else
			{
				if(strPrdType.equalsIgnoreCase("pE")){
					strEligCondition="Addition of Joint Applicant";
					strEligRequired="Required";
					strEligAvailable="Added";
					strEligStatus="Eligible";
					
					
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getGuarantorCheck "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getEligibleConstitution(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strAppConst="", strFemale="",strAppConstNew="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Constitution";
			strQuery = SQLParser.getSqlQuery("seleligibileconst^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppConst=Helper.correctNull(rs.getString("perapp_constitution"));
				strAppConstNew=Helper.correctNull(rs.getString("PERAPP_CONSTITUTIONNEW"));
				strFemale=Helper.correctNull(rs.getString("perapp_sex"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selconstitutiondesc^"+strAppConstNew);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEligAvailable=Helper.correctNull(rs.getString("cbs_static_data_desc"));
			}
			if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pV"))
			{
				strEligRequired="Individuals / HUF";
				if(strAppConst.equalsIgnoreCase("01")||strAppConst.equalsIgnoreCase("10")||strAppConst.equalsIgnoreCase("02"))
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
			}
			else if(strPrdType.equalsIgnoreCase("pM"))
			{
				strEligRequired="Individuals / HUF / Proprietorship firms";
				if(strAppConst.equalsIgnoreCase("01")||strAppConst.equalsIgnoreCase("11")||strAppConst.equalsIgnoreCase("10")||strAppConst.equalsIgnoreCase("02"))
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
			}
			else if(strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pE"))
			{
				strEligRequired="Individuals";
				if(strAppConst.equalsIgnoreCase("01")||strAppConst.equalsIgnoreCase("02"))
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
			}
			else if(strPrdType.equalsIgnoreCase("pU"))
			{
				if((strAppConst.equalsIgnoreCase("01")||strAppConst.equalsIgnoreCase("02")))
				{
					strEligCondition="Individuals";
					strEligRequired="Female Individual";
					if(strFemale.equalsIgnoreCase("F"))
					{
						strEligStatus="Eligible";
						strEligAvailable="Available ";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else if((Integer.parseInt(Helper.correctInt(strAppConst)) >=183) && (Integer.parseInt(Helper.correctInt(strAppConst)) <=191))
				{
					strEligCondition="Self Help Group";
					strEligRequired="Women Self Help Group";
					if(strAppConst.equalsIgnoreCase("183")||strAppConst.equalsIgnoreCase("186") || strAppConst.equalsIgnoreCase("189"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else
				{
					strEligCondition=" Firm/Company";
					strEligRequired="At least 51% of the shareholding and controlling stake is held by Woman entrepreneur";
					String stakeheld_women=Helper.correctNull((String)hshValues.get("stakeheld_women"));
					if(stakeheld_women.equalsIgnoreCase("Y"))
					{
						strEligStatus="Eligible";
						strEligAvailable="Available";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getEligibleConstitution "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getLoanPeriodHouse(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intRepayTerms=0, intTermsRestricted=0;
		try
		{
			strEligCondition="Minimum Loan Period";
			strQuery = SQLParser.getSqlQuery("getloanreqamt_sel^"+ strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRepayTerms=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intTermsRestricted=12*Integer.parseInt(Helper.correctInt(rs.getString("prd_hourepperiod")));
			}
			if(intRepayTerms<=intTermsRestricted)
			{
				strEligStatus="Eligible";
			}
			else
			{
				strEligStatus="Not Eligible";
			}
			strEligRequired=getMonthYearFormat(intTermsRestricted);
			strEligAvailable=getMonthYearFormat(intRepayTerms);
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getLoanPeriodHouse "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getLoanPeriodResidual(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intResidualLife=12*Integer.parseInt(Helper.correctInt((String)hshValues.get("intResidualLife")));
		int intRepayTerms=0;
		try
		{
			strEligCondition="Minimum Residual Life Of Premises";
			strQuery = SQLParser.getSqlQuery("getloanreqamt_sel^"+ strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRepayTerms=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
			}
			intRepayTerms = 2*intRepayTerms;
			if(intRepayTerms<=intResidualLife)
			{
				strEligStatus="Eligible";
			}
			else
			{
				strEligStatus="Not Eligible";
			}
			strEligRequired=getMonthYearFormat(intRepayTerms);
			strEligAvailable=getMonthYearFormat(intResidualLife);
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getLoanPeriodResidual "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getResidentialOwner(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strResOwn="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Ownership of Residential / Commercial";
			strEligRequired="Required";
			strQuery = SQLParser.getSqlQuery("propgendetailsel^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strResOwn=Helper.correctNull(rs.getString("collateral_status"));
			}
			if(strPrdType.equalsIgnoreCase("pH") || strPrdType.equalsIgnoreCase("pM") || 
					strPrdType.equalsIgnoreCase("pL"))
			{
				if(strResOwn.equalsIgnoreCase("1"))
				{
					strEligAvailable="Available";
					strEligStatus="Eligible";
				}
				else
				{
					strEligAvailable="Not Available";
					strEligStatus="Not Eligible";
				}
			}	
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getResidentialOwner "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getMinimumIncome(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strResStat="", strEmpStat="", strQuery1="",strAppName="";
		double dblMinMonthRes=0.00, dblMinMonthNRI=0.00, dblMinAnnualRes=0.00, dblMinAnnualNRI=0.00;
		double dblMinIncApplnt=0.00,dblMinIncome=0.00, dblMinIncJApplnt=0.00;
		double dblTakeHome=0.00,dblAnnualInc=0.00,
		dbl_add_depreciation_year1=0.00, dbl_add_depreciation_year2=0.00,
		dbl_add_intonliab_year1=0.00, dbl_add_intonliab_year2=0.00, dbl_nonsal_inc_itr1=0.00, dbl_nonsal_inc_itr2=0.00,	dbl_year1_nonsal_totalinc=0.00,
		dbl_year2_nonsal_totalinc=0.00,	dbl_nonsal_totalinc=0.00, dbl_avg_nonsal_totalinc=0.00,dblIncomeApp=0.00,dblIncomeRequired=0.00;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));;
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		String strTemp="";
		boolean boolflag=true;
		try
		{
			strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strResStat=Helper.correctNull(rs.getString("indinfo_resident_status"));
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
				dblTakeHome=Double.parseDouble(Helper.correctDouble((rs.getString("perinc_takehome"))));
				dblAnnualInc=Double.parseDouble(Helper.correctDouble((rs.getString("perinc_year2_income"))));
				strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
				strAppName=Helper.correctNull((String)rs.getString("perapp_fname"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_prdinterest^" + strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMinMonthRes=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_salincres")));
				dblMinMonthNRI=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_salincnri")));
				dblMinAnnualRes=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_nonsalincres")));
				dblMinAnnualNRI=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_nonsalincnri")));
			}
			if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
			{
				if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
				{
					dblMinIncome=dblMinMonthRes;
				}
				//else if(strResStat.equalsIgnoreCase("Y"))
				else
				{
					dblMinIncome=dblMinMonthNRI;
				}
				//dblMinIncJApplnt=getJointApplicantsIncome(strAppno,strEmpStat,strPrdType);
				dblMinIncApplnt=(dblTakeHome/12.0)+dblMinIncJApplnt;
			}
			else
			{
				strQuery1=SQLParser.getSqlQuery("assesment_sel_borr_income_details_appid^"+strAppId);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					 dbl_nonsal_inc_itr1 = rs1.getDouble("nonsal_itry1");
					 dbl_nonsal_inc_itr2 = rs1.getDouble("nonsal_itry2");
					 dbl_add_depreciation_year1 = rs1.getDouble("depreciation1");
					 dbl_add_depreciation_year2 = rs1.getDouble("depreciation2");
					 dbl_add_intonliab_year1 = rs1.getDouble("intonliab1");
					 dbl_add_intonliab_year2 = rs1.getDouble("intonliab2");
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
				if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
				{
					dblMinIncome=dblMinAnnualRes;
				}
				//else if(strResStat.equalsIgnoreCase("Y"))
				else
				{
					dblMinIncome=dblMinAnnualNRI;
				}
				//dblMinIncJApplnt=getJointApplicantsIncome(strAppno,strEmpStat,strPrdType);
				if(strPrdType.equalsIgnoreCase("pM"))
					dblMinIncApplnt=dbl_year1_nonsal_totalinc+dblMinIncJApplnt;
				else
					dblMinIncApplnt=dbl_avg_nonsal_totalinc+dblMinIncJApplnt;
			}
			strEligRequired=Helper.formatDoubleValue(dblMinIncome);
			strEligAvailable=Helper.formatDoubleValue(dblMinIncApplnt);
			
			dblIncomeApp=dblMinIncApplnt;dblIncomeRequired=dblMinIncome;
			
			if(dblMinIncApplnt>=dblMinIncome)
			{
				if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
				{
					strTemp="Monthly";
				}
				else
				{
					strTemp="Annual";
				}
				if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
				{
					strEligCondition="Minimum "+strTemp+" Income of the Applicant - "+strAppName+" (Resident)";
				}
				//else if(strResStat.equalsIgnoreCase("Y"))
				else
				{
					strEligCondition="Minimum "+strTemp+" Income of the Applicant - "+strAppName+" (NRI)";
				}
				
				strEligStatus="Eligible";
				boolflag=false;
			}
			else
			{
				strEligStatus="Not Eligible";
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_JointApplicantIncome^"+strAppno+"^c^2");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strAppId=Helper.correctNull(rs.getString("perapp_id"));
					strAppName=Helper.correctNull(rs.getString("perapp_fname"));
					strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
					
					strResStat=Helper.correctNull(rs.getString("indinfo_resident_status"));
					double dbl_sal_inc=0.00,dbl_tot_sal_Joint=0.0;
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("pergetIncome1^"+strAppId);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						dbl_sal_inc=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_takehome")));
						dbl_nonsal_inc_itr1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_year1_income")));
						dbl_nonsal_inc_itr2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_year2_income")));
						dbl_add_depreciation_year1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_depreciation_year1")));
						dbl_add_depreciation_year2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_depreciation_year2")));
						dbl_add_intonliab_year1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_intonliab_year1")));
						dbl_add_intonliab_year2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_intonliab_year2")));
					}
					if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
					{
						if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
						{
							dblMinIncome=dblMinMonthRes;
						}
						//else if(strResStat.equalsIgnoreCase("Y"))
						else
						{
							dblMinIncome=dblMinMonthNRI;
						}
						
						dblMinIncApplnt=dbl_sal_inc/12;
					}
					else
					{
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
						if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9")) //Converting Income of Joint App if Applicant is salaried
						{
							dbl_avg_nonsal_totalinc=dbl_avg_nonsal_totalinc/12;
						}
						if(strPrdType.equalsIgnoreCase("pM"))
							dblMinIncApplnt=dbl_year1_nonsal_totalinc;
						else
							dblMinIncApplnt=dbl_avg_nonsal_totalinc;
						
						if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
						{
							dblMinIncome=dblMinAnnualRes;
						}
						//else if(strResStat.equalsIgnoreCase("Y"))
						else
						{
							dblMinIncome=dblMinAnnualNRI;
						}
					}
					dblIncomeApp=dblMinIncApplnt;dblIncomeRequired=dblMinIncome;
					strEligRequired=Helper.formatDoubleValue(dblMinIncome);
					strEligAvailable=Helper.formatDoubleValue(dblMinIncApplnt);
					
					if(dblMinIncApplnt>=dblMinIncome)
					{
						if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
						{
							strTemp="Monthly";
						}
						else
						{
							strTemp="Annual";
						}
						
						if(strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R"))
						{
							strEligCondition="Minimum "+strTemp+" Income of the Co-Applicant - "+strAppName+" (Resident)";
						}
						//else if(strResStat.equalsIgnoreCase("Y"))
						else
						{
							strEligCondition="Minimum "+strTemp+" Income of the Co-Applicant - "+strAppName+" (NRI)";
						}
						
						strEligStatus="Eligible";
						boolflag=false;
						break;
					}
					
				}
			}
			
			if(boolflag)
			{
				strEligRequired=Helper.formatDoubleValue(dblIncomeRequired);
				strEligAvailable=Helper.formatDoubleValue(dblMinIncApplnt);
				strEligCondition="Minimum Income of the Applicants";
				strEligStatus="Not Eligible";
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMinimumIncome "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	private HashMap getMortgageMinimumIncome(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs12=null;
		String strQuery="", strResStat="", strEmpStat="", strQuery1="";
		double dblMinMonthRes=0.00, dblMinMonthNRI=0.00, dblMinAnnualRes=0.00, dblMinAnnualNRI=0.00;
		double dblMinIncApplnt=0.00,dblMinIncome=0.00, dblMinIncJApplnt=0.00;
		double dblTakeHome=0.00,dblAnnualInc=0.00,
		dbl_add_depreciation_year1=0.00, dbl_add_depreciation_year2=0.00,
		dbl_add_intonliab_year1=0.00, dbl_add_intonliab_year2=0.00, dbl_nonsal_inc_itr1=0.00, dbl_nonsal_inc_itr2=0.00,	dbl_year1_nonsal_totalinc=0.00,
		dbl_year2_nonsal_totalinc=0.00,	dbl_nonsal_totalinc=0.00, dbl_avg_nonsal_totalinc=0.00;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));;
		String strName="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strQuery = SQLParser.getSqlQuery("selconfservicemort^" + strAppno);
			rs12=DBUtils.executeQuery(strQuery);
			while(rs12.next())
			{
				strName=Helper.correctNull(rs12.getString("cusname"));
				strResStat=Helper.correctNull(rs12.getString("indinfo_resident_status"));
				strEmpStat=Helper.correctNull(rs12.getString("perapp_employment"));
				dblTakeHome=Double.parseDouble(Helper.correctDouble((rs12.getString("perinc_takehome"))));
				dblAnnualInc=Double.parseDouble(Helper.correctDouble((rs12.getString("perinc_year2_income"))));
				strAppId=Helper.correctNull((String)rs12.getString("perapp_id"));
			
				strQuery = SQLParser.getSqlQuery("sel_prdinterest^" + strPrdCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblMinMonthRes=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_salincres")));
					dblMinMonthNRI=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_salincnri")));
					dblMinAnnualRes=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_nonsalincres")));
					dblMinAnnualNRI=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_nonsalincnri")));
				}
				if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
				{
					if(strResStat.equalsIgnoreCase("N"))
					{
						strEligCondition="Minimum Monthly Income(Resident) of "+strName;
						dblMinIncome=dblMinMonthRes;
					}
					else if(strResStat.equalsIgnoreCase("Y"))
					{
						strEligCondition="Minimum Monthly Income(NRI) of "+strName;
						dblMinIncome=dblMinMonthNRI;
					}
					dblMinIncJApplnt=getJointApplicantsIncome(strAppno,strEmpStat,strPrdType);
					dblMinIncApplnt=(dblTakeHome/12.0)+dblMinIncJApplnt;
				}
				else
				{
					strQuery1=SQLParser.getSqlQuery("assesment_sel_borr_income_details_appid^"+strAppId);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						 dbl_nonsal_inc_itr1 = rs1.getDouble("nonsal_itry1");
						 dbl_nonsal_inc_itr2 = rs1.getDouble("nonsal_itry2");
						 dbl_add_depreciation_year1 = rs1.getDouble("depreciation1");
						 dbl_add_depreciation_year2 = rs1.getDouble("depreciation2");
						 dbl_add_intonliab_year1 = rs1.getDouble("intonliab1");
						 dbl_add_intonliab_year2 = rs1.getDouble("intonliab2");
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
					if(strResStat.equalsIgnoreCase("N"))
					{
						strEligCondition="Minimum Annual Income(Resident) of "+strName;
						dblMinIncome=dblMinAnnualRes;
					}
					else if(strResStat.equalsIgnoreCase("Y"))
					{
						strEligCondition="Minimum Annual Income(NRI) of "+strName;
						dblMinIncome=dblMinAnnualNRI;
					}
					dblMinIncJApplnt=getJointApplicantsIncome(strAppno,strEmpStat,strPrdType);
					if(strPrdType.equalsIgnoreCase("pM"))
						dblMinIncApplnt=dbl_year1_nonsal_totalinc+dblMinIncJApplnt;
					else
						dblMinIncApplnt=dbl_avg_nonsal_totalinc+dblMinIncJApplnt;
				}
				strEligRequired=Helper.formatDoubleValue(dblMinIncome);
				strEligAvailable=Helper.formatDoubleValue(dblMinIncApplnt);
				
				if(dblMinIncApplnt>=dblMinIncome)
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol = new ArrayList();
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					arrRow.add(arrCol);
					hshRecord.put("arrRow", arrRow);
				}
			}
			hshRecord.put("size", String.valueOf(arrRow.size()));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMinimumIncome "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getConfirmedService(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strConfServ="", strResStat="", strEmpStat="",strRegularIncome="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intServiceLeft=0;
		int intConfYears=0;
		double dblPreviousEmployment=0,dblcurrentEmployment=0;
		try
		{
			strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strConfServ=Helper.correctNull(rs.getString("peremp_confemp"));
				strResStat=Helper.correctNull(rs.getString("indinfo_resident_status"));
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
				intServiceLeft=Integer.parseInt(Helper.correctInt(rs.getString("peremp_servleft")));
				dblPreviousEmployment=Double.parseDouble(Helper.correctInt(rs.getString("peremp_expinyrs")));
				dblcurrentEmployment=Double.parseDouble(Helper.correctInt(rs.getString("presentempmonths")));
				strRegularIncome=Helper.correctNull(rs.getString("peremp_incsource"));
			}
			if((strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9")) && (strResStat.equalsIgnoreCase("N")||strResStat.equalsIgnoreCase("R")))
			{
				strEligCondition="Confirmed Service";
				strEligRequired="Required";
				/*if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pM"))
				{
					if(strConfServ.equalsIgnoreCase("1"))
					{
						if(strResStat.equalsIgnoreCase("N"))
						{
							strEligAvailable="Available";
							strEligStatus="Eligible";
						}
						else if(strResStat.equalsIgnoreCase("Y"))
						{
							if(rs1!=null)
							{
								rs1.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								intConfYears=Integer.parseInt(Helper.correctInt(rs1.getString("prd_minconfservice")));
							}
							if(intServiceLeft>=intConfYears)
							{
								strEligAvailable="Available";
								strEligStatus="Eligible";
							}
							else
							{
								strEligAvailable="Not Available";
								strEligStatus="Not Eligible";
							}
						}
						else
						{
							strEligAvailable="Not Available";
							strEligStatus="Not Eligible";
						}
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}*/
				if(strPrdType.equalsIgnoreCase("pM")){
					strEligCondition="Minimum 1 Year of Regular Employment and 6 Months of Current Employment";
					strEligRequired="Required";
					
					if(dblPreviousEmployment>=1 && dblcurrentEmployment>=6)
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else if(strPrdType.equalsIgnoreCase("pH")){
					strEligCondition="Regular Source from a gainful employment";
					strEligRequired="Required";
					
					if(strRegularIncome.equalsIgnoreCase("1"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else if(strPrdType.equalsIgnoreCase("pA")||strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pK"))
				{
					if(strConfServ.equalsIgnoreCase("1"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else if(strPrdType.equalsIgnoreCase("pV"))
				{
					strEligCondition="Minimum 1 Year of Regular Employment and 6 Months of Current Employment";
					strEligRequired="Required";
					
					if(dblPreviousEmployment>=1 && dblcurrentEmployment>=6)
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					hshRecord.put("arrCol", arrCol);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getConfirmedService "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	
private HashMap getResidentialStatus(HashMap hshValues) {
		
		
		
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strQuery="", strConfServ="", strResStat=""; 
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intServiceLeft=0;
		int intConfYears=0;
		double dblPreviousEmployment=0,dblcurrentEmployment=0;
		try{
			
				strConfServ=Helper.correctNull((String)hshValues.get("strConfServ"));
				strResStat=Helper.correctNull((String)hshValues.get("strResStat"));
				intServiceLeft=Integer.parseInt(Helper.correctInt((String)hshValues.get("intServiceLeft")));
				dblPreviousEmployment=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblPreviousEmployment")));
				dblcurrentEmployment=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblcurrentEmployment")));
				
		if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pM"))
		{
			strEligCondition="NRI:Minimum 2 years of regular Service & 6 months in the present employment";
			strEligRequired="Required";
			if(strConfServ.equalsIgnoreCase("1"))
			{
				if(strResStat.equalsIgnoreCase("N"))
				{
					strEligCondition="Minimum 2 years of regular Service & 6 months in the present employment";
					strEligRequired="Required";
				}
				if(strResStat.equalsIgnoreCase("Y"))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						intConfYears=Integer.parseInt(Helper.correctInt(rs1.getString("prd_minconfservice")));
					}
					if(intServiceLeft>=intConfYears)
					{
						
						strEligCondition="NRI:Minimum 2 years of regular Service & 6 months in the present employment";
						strEligRequired="Required";
						if(dblPreviousEmployment>=2 && dblcurrentEmployment>=6)
						{
							strEligAvailable="Available";
							strEligStatus="Eligible";
						}
						else
						{
							strEligAvailable="Not Available";
							strEligStatus="Not Eligible";
						}
					}
					else
					{
						
						strEligAvailable="Not Available";
						strEligStatus="Not Eligible";
					}
				}
				else
				{
					strEligAvailable="Not Available";
					strEligStatus="Not Eligible";
				}
			}
			else
			{
				strEligAvailable="Not Available";
				strEligStatus="Not Eligible";
			}
			
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		}
		
		catch(Exception e){
			throw new EJBException("Error in closing Connection "+e.getMessage());
		}
		return hshRecord;
		
	}
	private HashMap getAgeCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshCalc=new HashMap();
		HashMap hshResult=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strEmpStat="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strVehicleType=Helper.correctNull((String)hshValues.get("strVehicleType"));
		if(strAppId.equalsIgnoreCase(""))
		strAppId=Helper.correctNull((String)hshValues.get("hidDemoId"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intAge=0, intMaxAgeSelf=0, intMaxAgeEmp=0, intMinAge=0, intMaxAge=0, intRepayTerms=0, intFinalAge=0, intRetireAge=0;
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_prdinterest^" + strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intMaxAgeSelf=Integer.parseInt(Helper.correctInt(rs.getString("prd_selfretireage")))*12;
				intMaxAgeEmp=Integer.parseInt(Helper.correctInt(rs.getString("prd_empretireage")))*12;
				intMinAge=Integer.parseInt(Helper.correctInt(rs.getString("prd_appminage")))*12;
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getloanreqamt_sel^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRepayTerms=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intAge=Integer.parseInt(Helper.correctInt(rs.getString("age")));
				strEmpStat=Helper.correctNull(rs.getString("perapp_employment"));
			}
			if(strPrdType.equalsIgnoreCase("pP") || (strPrdType.equalsIgnoreCase("pA") && strVehicleType.equalsIgnoreCase("1")))
				intFinalAge=intAge;
			else
				intFinalAge=intAge+intRepayTerms;
			
			if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
			{
				intMaxAge=intMaxAgeEmp;
				strQuery = SQLParser.getSqlQuery("selapplntretireage^" + strAppId);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					intRetireAge=Integer.parseInt(Helper.correctInt(rs1.getString("age")));
				}
//				if(intRetireAge!=0&&intRetireAge<intMaxAge)
//				{
//					intMaxAge=intRetireAge;
//				}
			}
			else
			{
				intMaxAge=intMaxAgeSelf;
			}
			if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pM")
					||strPrdType.equalsIgnoreCase("pA")||strPrdType.equalsIgnoreCase("pK")||
					strPrdType.equalsIgnoreCase("pI")||strPrdType.equalsIgnoreCase("pL")||strPrdType.equalsIgnoreCase("pV") || strPrdType.equalsIgnoreCase("pU") || strPrdType.equalsIgnoreCase("pB"))
			{
				if((intAge>=intMinAge)&&intMinAge!=0&&intAge!=0)
				{
					strEligCondition="Minimum Age of Applicant";
					strEligRequired=getMonthYearFormat(intMinAge);
					strEligAvailable=getMonthYearFormat(intAge);
					strEligStatus="Eligible";
				}
				else
				{
					boolean boolFlag=false;
					if(rs!=null)
					{rs.close();}
					strQuery = SQLParser.getSqlQuery("getcoappguarantor^" + strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						int intCoAppAge=0;
						strEmpStat="";
						strAppId=Helper.correctNull(rs.getString("demo_appid"));
						String strDemoType=Helper.correctNull(rs.getString("demo_type"));
						if(boolFlag==false)
						{
							if(strDemoType.equalsIgnoreCase("c"))
							{
								strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
								rs1=DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									intCoAppAge=Integer.parseInt(Helper.correctInt(rs1.getString("age")));
									strEmpStat=Helper.correctNull(rs1.getString("perapp_employment"));
								}
								if((intCoAppAge>=intMinAge)&&intMinAge!=0&&intAge!=0)
								{
									boolFlag=true;
									strEligCondition="Minimum Age of Co-Applicant";
									strEligRequired=getMonthYearFormat(intMinAge);
									strEligAvailable=getMonthYearFormat(intCoAppAge);
									strEligStatus="Eligible";
								}
								
							}
						}
					}
					if(intMinAge!=0 && boolFlag==false)
					{
						strEligCondition="Minimum Age of Applicant";
						strEligRequired=getMonthYearFormat(intMinAge);
						strEligAvailable=getMonthYearFormat(intAge);
						strEligStatus="Not Eligible";
					}
				
				}
				
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol=new ArrayList();
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					arrRow.add(arrCol);
				}
				
				strEligCondition="";
				strEligRequired="";
				strEligAvailable="";
				strEligStatus="";
				
				if(intFinalAge<=intMaxAge)
				{
					if(strPrdType.equalsIgnoreCase("pA") && strVehicleType.equalsIgnoreCase("1"))
						strEligCondition="Maximum Age of Applicant/Joint applicant/s";
					else
						strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
					strEligRequired=getMonthYearFormat(intMaxAge);
					strEligAvailable=getMonthYearFormat(intFinalAge);
					strEligStatus="Eligible";
				}
				else
				{
					hshCalc.put("intApplntMaxAge",getMonthYearFormat(intMaxAge));
					hshCalc.put("intApplntAge",getMonthYearFormat(intFinalAge));
					hshCalc.put("intMaxAgeSelf",Integer.toString(intMaxAgeSelf));
					hshCalc.put("intMaxAgeEmp",Integer.toString(intMaxAgeEmp));
					hshCalc.put("intRepayTerms",Integer.toString(intRepayTerms));
					hshCalc.put("strAppno",strAppno);
					hshCalc.put("strPrdType",strPrdType);
					hshCalc.put("strVehicleType",strVehicleType);
					hshResult=getJointAppGuarAgeCheck(hshCalc);
					strEligCondition=Helper.correctNull((String)hshResult.get("strEligCondition"));
					strEligRequired=Helper.correctNull((String)hshResult.get("strEligRequired"));
					strEligAvailable=Helper.correctNull((String)hshResult.get("strEligAvailable"));
					strEligStatus=Helper.correctNull((String)hshResult.get("strEligStatus"));
				}
			}
			else if(strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pJ"))
			{
				if((intAge<intMinAge)&&intMinAge!=0&&intAge!=0)
				{
					strEligCondition="Minimum Age of Applicant";
					strEligRequired=getMonthYearFormat(intMinAge);
					strEligAvailable=getMonthYearFormat(intAge);
					strEligStatus="Not Eligible";
				}
				else
				{
					strEligCondition="Minimum Age of Applicant";
					strEligRequired=getMonthYearFormat(intMinAge);
					strEligAvailable=getMonthYearFormat(intAge);
					strEligStatus="Eligible";
				}
				
				arrCol=new ArrayList();
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				arrRow.add(arrCol);
				
				strEligCondition="";
				strEligRequired="";
				strEligAvailable="";
				strEligStatus="";
				
				if((intAge>=intMinAge)&&(intFinalAge<=intMaxAge))
				{
					if(strPrdType.equalsIgnoreCase("pP"))
						strEligCondition="Maximum Age of Applicant/Joint applicant/s";
					else
						strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
					strEligRequired=getMonthYearFormat(intMaxAge);
					strEligAvailable=getMonthYearFormat(intFinalAge);
					strEligStatus="Eligible";
				}
				else
				{
					strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
					strEligRequired=getMonthYearFormat(intMaxAge);
					strEligAvailable=getMonthYearFormat(intFinalAge);
					strEligStatus="Not Eligible";
				}
			}
			else if(strPrdType.equalsIgnoreCase("pE"))
			{
				if(intAge<=intMaxAge)
				{
					strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
					strEligRequired=getMonthYearFormat(intMaxAge);
					strEligAvailable=getMonthYearFormat(intAge);
					strEligStatus="Eligible";
				}
				else
				{
					strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
					strEligRequired=getMonthYearFormat(intMaxAge);
					strEligAvailable=getMonthYearFormat(intAge);
					strEligStatus="Not Eligible";
				}
			}
			arrCol=new ArrayList();
			arrCol.add(strEligCondition);
			arrCol.add(strEligRequired);
			arrCol.add(strEligAvailable);
			arrCol.add(strEligStatus);
			arrRow.add(arrCol);
			hshRecord.put("arrCol", arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getAgeCheck "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getTakeOverLoan(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strLoanPurpose=Helper.correctNull((String)hshValues.get("strLoanPurpose"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		int intRepayPeriod=0, intTakeOverPeriod=0, intTakeOverDefined=0;
		int intDuePeriod=0, intTakeOverRepayPeriod=0, intAvailPeriod=0;
		try
		{
			strEligCondition="Maximum Loan period (For Take Over loan)";
			strQuery = SQLParser.getSqlQuery("getloanterms^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRepayPeriod=Integer.parseInt(Helper.correctInt(rs.getString("loan_terms")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("seltakeoverperiod^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intAvailPeriod=Integer.parseInt(Helper.correctInt(rs.getString("avail_date")));
				intDuePeriod=Integer.parseInt(Helper.correctInt(rs.getString("due_date")));
				intTakeOverRepayPeriod=Integer.parseInt(Helper.correctInt(rs.getString("repay_period")));
				intTakeOverPeriod=intTakeOverRepayPeriod-intAvailPeriod;
				if(intTakeOverPeriod<0)
				{
					intTakeOverPeriod=0;
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_prdinterest^" + strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intTakeOverDefined=Integer.parseInt(Helper.correctInt(rs.getString("prd_takeoverloan")));
			}
			if(intTakeOverDefined<intTakeOverPeriod)
			{
				intTakeOverPeriod=intTakeOverDefined;
			}
			if(strPrdType.equalsIgnoreCase("pH"))
			{
				strEligRequired=getMonthYearFormat(intDuePeriod);
				if(strLoanPurpose.equalsIgnoreCase("G"))
				{
					if(intRepayPeriod<=intDuePeriod)
					{
						strEligStatus="Eligible";
					}
					else
					{
						strEligStatus="Not Eligible";
					}
				}
				if(strLoanPurpose.equalsIgnoreCase("S"))
				{
					if(intRepayPeriod<=intDuePeriod)
					{
						strEligStatus="Eligible";
					}
					else
					{
						strEligStatus="Not Eligible";
					}
				}
				else
				{
					strEligRequired=getMonthYearFormat(intTakeOverPeriod);
					if(intRepayPeriod<=intTakeOverPeriod)
					{
						strEligStatus="Eligible";
					}
					else
					{
						strEligStatus="Not Eligible";
					}
				}
			}
			else if(strPrdType.equalsIgnoreCase("pM"))
			{
				strEligRequired=getMonthYearFormat(intDuePeriod);
				if(intRepayPeriod<=intDuePeriod)
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
			}
			else if(strPrdType.equalsIgnoreCase("pA"))
			{
				strEligRequired=getMonthYearFormat(intTakeOverPeriod);
				if(intRepayPeriod<=intTakeOverPeriod)
				{
					strEligStatus="Eligible";
				}
				else
				{
					strEligStatus="Not Eligible";
				}
			}
			strEligAvailable=getMonthYearFormat(intRepayPeriod);
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTakeOverLoan "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getReimbursement(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="";
		String strBanking="", strSatisfactory="";
		int intPrdSatisfactoryDeal=0, intPrdRegisterMonth=0, intBankingSince=0;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		int intRegMonths=Integer.parseInt(Helper.correctInt((String)hshValues.get("strRegMonths")));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Reimbursement";
			strEligRequired="Required";
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intPrdSatisfactoryDeal=Integer.parseInt(Helper.correctInt((String)rs.getString("prd_satisfacdealing")));
				intPrdRegisterMonth=Integer.parseInt(Helper.correctInt((String)rs.getString("prd_registermonth")));
			}
			strQuery=SQLParser.getSqlQuery("selapplntage^"+strAppId);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				strBanking=Helper.correctNull(rs1.getString("perapp_bank"));
				strSatisfactory=Helper.correctNull(rs1.getString("perapp_satisfactory"));
				intBankingSince=Integer.parseInt(Helper.correctInt((String)rs1.getString("perapp_banksince")));
			}
			/* Customer should have satisfactory dealing more than the period specified in products
			 * and registration should be done within the period specified in product
			 */
			if((intBankingSince>=intPrdSatisfactoryDeal)&&(intRegMonths<=intPrdRegisterMonth)&&
					(strBanking.equalsIgnoreCase("1")&&strSatisfactory.equalsIgnoreCase("Y")))
			{
				strEligAvailable="Available";
				strEligStatus="Eligible";
			}
			else
			{
				strEligAvailable="Not Available";
				strEligStatus="Not Eligible";
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getReimbursement "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getLoanPeriod(HashMap hshValues) 
	{
		
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strVehicleType=Helper.correctNull((String)hshValues.get("strVehicleType"));
		String strVehicleCategory=Helper.correctNull((String)hshValues.get("strVehicleCategory"));
		String strRegistraionDt=Helper.correctNull((String)hshValues.get("strRegistraionDt"));
		String strCreatedDate=Helper.correctNull((String)hshValues.get("strCreatedDate"));
		String strEmpStat=Helper.correctNull((String)hshValues.get("strEmpStat"));
		int intRetirePrior=0, intRepayPeriod=0, intRetireAge=0,intVehiclePeriod=0;
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Loan Period";
			strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRetirePrior=Integer.parseInt(Helper.correctInt(rs.getString("prd_perretdate")));
				intVehiclePeriod=Integer.parseInt(Helper.correctInt(rs.getString("prd_vehloanperiod")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getemiinfo^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRepayPeriod=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_monthstoretire^" + strAppId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intRetireAge=Integer.parseInt(Helper.correctInt(rs.getString("ret_date")));
			}
			if(strPrdType.equalsIgnoreCase("pA")&&strVehicleCategory.equalsIgnoreCase("2"))
			{
				if(!strRegistraionDt.equalsIgnoreCase(""))
				{
					int intPeriod=0,intReqPeriod=0,intAvailblePeriod=0;
					strQuery = SQLParser.getSqlQuery("selmonthsdiff^" + strRegistraionDt+"^"+intVehiclePeriod+"^"+strCreatedDate+"^"+intRepayPeriod+"^"+strRegistraionDt+"^"+intVehiclePeriod+"^"+strRegistraionDt+"^"+strCreatedDate+"^"+intRepayPeriod+"^"+strCreatedDate);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						intPeriod=Integer.parseInt(Helper.correctInt(rs.getString("days")));
						intReqPeriod=Integer.parseInt(Helper.correctInt(rs.getString("reqmonths")));
						intAvailblePeriod=Integer.parseInt(Helper.correctInt(rs.getString("availblemonths")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					if(intPeriod>=0)
					{
						strEligStatus="Eligible";
					}
					else
					{
						strEligStatus="Not Eligible";
					}
					strEligAvailable=getMonthYearFormat(intAvailblePeriod);
					strEligRequired="Less than "+getMonthYearFormat(intReqPeriod)+" from Date of Registration";
				}
				else
				{
					strEligStatus="Not Eligible";
					strEligAvailable=getMonthYearFormat(intRepayPeriod);
					strEligRequired="Less than "+getMonthYearFormat(intVehiclePeriod)+" from date of Degistration";
				}
			}
			else if((strPrdType.equalsIgnoreCase("pA")&&strVehicleType.equalsIgnoreCase("1"))||strPrdType.equalsIgnoreCase("pP")||strPrdType.equalsIgnoreCase("pJ"))
			{
				if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
				{
					intRetireAge=intRetireAge-intRetirePrior;
					if(intRepayPeriod<=intRetireAge)
					{
						strEligStatus="Eligible";
					}
					else
					{
						strEligStatus="Not Eligible";
					}
				}
				strEligAvailable=getMonthYearFormat(intRepayPeriod);
				strEligRequired="Less than "+getMonthYearFormat(intRetireAge);
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getLoanPeriod "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getApplntCompany(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strQuery="", strConfirmedEmp="",strListedComp="",strDealOurBnk="";
		int intNoOfYears=0, intNoOfMinYears=0;
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		boolean bflag=false;
		try
		{
			strEligCondition="Applicant / Co-Obligant Working in Reputed Organisation as a confirmed Employee";
			strEligRequired="Required";
			strQuery = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^a");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strConfirmedEmp=Helper.correctNull(rs.getString("peremp_confemp"));
				strListedComp=Helper.correctNull(rs.getString("peremp_listcomp"));
				strDealOurBnk=Helper.correctNull(rs.getString("peremp_dealing"));
				intNoOfYears=Integer.parseInt(Helper.correctInt(rs.getString("peremp_noofyrs")));
			}
			if(strPrdType.equalsIgnoreCase("pP"))
			{
				if(strConfirmedEmp.equalsIgnoreCase("1"))
				{
					if(strListedComp.equalsIgnoreCase("1"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
					}
					else
					{
						if(strDealOurBnk.equalsIgnoreCase("1"))
						{
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								intNoOfMinYears=Integer.parseInt(Helper.correctInt(rs.getString("prd_perdeal")));
							}
							if(intNoOfYears>=intNoOfMinYears)
							{
								strEligAvailable="Available";
								strEligStatus="Eligible";
							}
							else
							{
//								strEligAvailable="Not Available";
//								strEligStatus="Not Eligible";
								
								bflag=true;
							}
						}
						else
						{
//							strEligAvailable="Not Available";
//							strEligStatus="Not Eligible";
							
							bflag=true;
						}
					}
				}
				else
				{
//					strEligAvailable="Not Available";
//					strEligStatus="Not Eligible";
					
					bflag=true;
				}
			}
			
			if(bflag==true)
			{
				
				boolean bflag1=false;
				String strQuery13 = SQLParser.getSqlQuery("selconfservice^" + strAppno+"^o");
				ResultSet rs22 = DBUtils.executeQuery(strQuery13);
				while(rs22.next())
				{

					strConfirmedEmp=Helper.correctNull(rs.getString("peremp_confemp"));
					strListedComp=Helper.correctNull(rs.getString("peremp_listcomp"));
					strDealOurBnk=Helper.correctNull(rs.getString("peremp_dealing"));
					intNoOfYears=Integer.parseInt(Helper.correctInt(rs.getString("peremp_noofyrs")));
					if(strListedComp.equalsIgnoreCase("1"))
					{
						strEligAvailable="Available";
						strEligStatus="Eligible";
						bflag1=true;
						break;
					}
					else
					{
						if(strDealOurBnk.equalsIgnoreCase("1"))
						{
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_specificeligible^" + strPrdCode);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								intNoOfMinYears=Integer.parseInt(Helper.correctInt(rs.getString("prd_perdeal")));
							}
							if(intNoOfYears>=intNoOfMinYears)
							{
								strEligAvailable="Available";
								strEligStatus="Eligible";
								bflag1=true;
								break;
							}
						}
					}
				
				}
				
				if(bflag1==false)
				{
					strEligAvailable="Not Available";
					strEligStatus="Not Eligible";
				}
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getApplntCompany "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getJointAppGuarAgeCheck(HashMap hshValues) 
	{
		String strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		String strPrdType=Helper.correctNull((String)hshValues.get("strPrdType"));
		String strAppId=Helper.correctNull((String)hshValues.get("strAppId"));
		String strVehicleType=Helper.correctNull((String)hshValues.get("strVehicleType"));
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strDemoType="", strDemoRelation="", strEmpStat="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		boolean boolFlag=false;
		int intMaxAgeSelf=Integer.parseInt(Helper.correctInt((String)hshValues.get("intMaxAgeSelf")));
		int intMaxAgeEmp=Integer.parseInt(Helper.correctInt((String)hshValues.get("intMaxAgeEmp")));
		int intRepayTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("intRepayTerms")));
		int intAge=0, intMaxAge=0, intFinalAge=0, intRetireAge=0;
		try
		{
			strQuery = SQLParser.getSqlQuery("getcoappguarantor^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intAge=0;
				intMaxAge=0;
				strEmpStat="";
				intFinalAge=0;
				intRetireAge=0;
				strAppId=Helper.correctNull(rs.getString("demo_appid"));
				strDemoType=Helper.correctNull(rs.getString("demo_type"));
				strDemoRelation=Helper.correctNull(rs.getString("demo_relation"));
				if(boolFlag==false)
				{
					if(strDemoType.equalsIgnoreCase("c"))
					{
						strQuery = SQLParser.getSqlQuery("selapplntage^" + strAppId);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							intAge=Integer.parseInt(Helper.correctInt(rs1.getString("age")));
							strEmpStat=Helper.correctNull(rs1.getString("perapp_employment"));
						}
						if((strPrdType.equalsIgnoreCase("pA") && strVehicleType.equalsIgnoreCase("1"))||strPrdType.equalsIgnoreCase("pP"))
							intFinalAge=intAge;
						else
							intFinalAge=intAge+intRepayTerms;
						if(strEmpStat.equalsIgnoreCase("1")||strEmpStat.equalsIgnoreCase("9"))
						{
							intMaxAge=intMaxAgeEmp;
							strQuery = SQLParser.getSqlQuery("selapplntretireage^" + strAppId);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								intRetireAge=Integer.parseInt(Helper.correctInt(rs1.getString("age")));
							}
//							if(intRetireAge!=0&&intRetireAge<intMaxAge)
//							{
//								intMaxAge=intRetireAge;
//							}
						}
						else
						{
							intMaxAge=intMaxAgeSelf;
						}
						if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pM"))
						{
							if(strDemoType.equalsIgnoreCase("c"))
							{
								if((intFinalAge<intMaxAge)&&intFinalAge!=0&&intMaxAge!=0)
								{
									boolFlag=true;
									strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
									strEligRequired=getMonthYearFormat(intMaxAge);
									strEligAvailable=getMonthYearFormat(intFinalAge);
									strEligStatus="Eligible";
								}
							}
							else if(strDemoType.equalsIgnoreCase("g"))
							{
								if((intFinalAge<intMaxAge)&&(intFinalAge!=0)&&(intMaxAge!=0)&&(strDemoRelation.equalsIgnoreCase("4")))
								{
									boolFlag=true;
									strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
									strEligRequired=getMonthYearFormat(intMaxAge);
									strEligAvailable=getMonthYearFormat(intFinalAge);
									strEligStatus="Eligible";
								}
							}
						}
						else
						{
							if(strDemoType.equalsIgnoreCase("c"))
							{
								if((intFinalAge<intMaxAge)&&intFinalAge!=0&&intMaxAge!=0)
								{
									boolFlag=true;
									strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
									strEligRequired=getMonthYearFormat(intMaxAge);
									strEligAvailable=getMonthYearFormat(intFinalAge);
									strEligStatus="Eligible";
								}
							}
						}
					}
				}
			}
			if(boolFlag==false)
			{
				if((strPrdType.equalsIgnoreCase("pA") && strVehicleType.equalsIgnoreCase("1"))||strPrdType.equalsIgnoreCase("pP"))
					strEligCondition="Maximum Age of Applicant/Joint applicant/s";
				else
					strEligCondition="Maximum Age of Applicant/Joint applicant/s(Including Repayment Period)";
				strEligRequired=Helper.correctNull((String)hshValues.get("intApplntMaxAge"));
				strEligAvailable=Helper.correctNull((String)hshValues.get("intApplntAge"));
				strEligStatus="Not Eligible";
			}
			hshValues.put("strEligCondition",strEligCondition);
			hshValues.put("strEligRequired",strEligRequired);
			hshValues.put("strEligAvailable",strEligAvailable);
			hshValues.put("strEligStatus",strEligStatus);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getAppJointAppGuarAgeCheck "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshValues;
	}
	private String getApplntConstitution(HashMap hshValues) 
	{
		String strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		ResultSet rs=null;
		String strQuery="", strAppConst="";
		try
		{
			strQuery = SQLParser.getSqlQuery("seleligibileconst^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppConst=Helper.correctNull(rs.getString("perapp_constitution"));
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getApplntConstitution "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return strAppConst;
	}
	
	
	private HashMap getEMIandRentEligibility(HashMap hshValues) 
	{
		String strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
		ResultSet rs=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		String strQuery="",strEMI="0",strGrossRent="0";
		try
		{
			strEligCondition="EMI amount limit";
			strEligRequired="EMI amount should be less than Monthly Net Rent";
			strQuery = SQLParser.getSqlQuery("sel_emiandgrossrent^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEMI = Helper.correctDouble((String)rs.getString("LOAN_EMI"));
				strGrossRent = Helper.correctDouble((String)rs.getString("LOAN_MONGROSSRENT"));
			}
			if(Double.parseDouble(strEMI)<Double.parseDouble(strGrossRent))
			{
				strEligAvailable="EMI amount is less than Monthly Net Rent";
				strEligStatus="Eligible";
			}
			else
			{
				strEligAvailable="EMI amount is greater than Monthly Net Rent";
				strEligStatus="Not Eligible";
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getEMIandRentEligibility "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private String getMonthYearFormat(int intMonthValue) 
	{
		String strDisplay="";
		int intYear=0, intMonth=0;
		try
		{
			intYear=intMonthValue/12;
			intMonth=intMonthValue%12;
			strDisplay=Integer.toString(intYear)+" Years";
			if(intMonth!=0)
			{
				strDisplay=strDisplay+", "+Integer.toString(intMonth)+" Months";
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMonthYearFormat "+e.getMessage());
		}
		return strDisplay;
	}
	private HashMap getCGTMSEScheme(String strAppno) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strCGTMSE="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Facility covers under CGTMSE scheme";
			strEligRequired="Yes";
			strQuery=SQLParser.getSqlQuery("get_RepayTypeAndPurpose^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCGTMSE=Helper.correctNull((String)rs.getString("loan_cgtmse"));
			}
			if(strCGTMSE.equalsIgnoreCase("1"))
			{
				strEligAvailable="Yes";
				strEligStatus="Eligible";
			}
			else
			{
				strEligAvailable="No";
				strEligStatus="Not Eligible";
			}
			arrCol.add(strEligCondition);
			arrCol.add(strEligRequired);
			arrCol.add(strEligAvailable);
			arrCol.add(strEligStatus);
			hshRecord.put("arrCol", arrCol);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCGTMSEScheme "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private double getJointApplicantsIncome(String strAppNo, String strEmp,String strPrdType) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strQuery1="";
		String strAppId="", strEmpJ="";
		double dbl_tot_sal_Joint=0.00;
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_JointApplicantIncome^"+strAppNo+"^c^2");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
				strEmpJ=Helper.correctNull((String)rs.getString("perapp_employment"));
				
				double dbl_add_depreciation_year1=0.00, dbl_add_depreciation_year2=0.00, dbl_add_intonliab_year1=0.00, dbl_add_intonliab_year2=0.00,
						dbl_nonsal_inc_itr1=0.00, dbl_nonsal_inc_itr2=0.00,	dbl_year1_nonsal_totalinc=0.00, dbl_year2_nonsal_totalinc=0.00,
						dbl_nonsal_totalinc=0.00, dbl_avg_nonsal_totalinc=0.00, dbl_sal_inc=0.00;
				
				if(rs1!=null)
				{
					rs.close();
				}
				strQuery1=SQLParser.getSqlQuery("pergetIncome1^"+strAppId);
				rs1=DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					dbl_sal_inc=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_takehome")));
					dbl_nonsal_inc_itr1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_year1_income")));
					dbl_nonsal_inc_itr2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_year2_income")));
					dbl_add_depreciation_year1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_depreciation_year1")));
					dbl_add_depreciation_year2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_depreciation_year2")));
					dbl_add_intonliab_year1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_intonliab_year1")));
					dbl_add_intonliab_year2=Double.parseDouble(Helper.correctDouble((String)rs1.getString("perinc_intonliab_year2")));
				}
				if(strEmpJ.equalsIgnoreCase("1")||strEmpJ.equalsIgnoreCase("9"))
				{
					if(strEmp.equalsIgnoreCase("1")||strEmp.equalsIgnoreCase("9")) //Converting Income of Joint App if Applicant is salaried
					{
						dbl_sal_inc=dbl_sal_inc/12;
					}
					dbl_tot_sal_Joint=dbl_tot_sal_Joint+dbl_sal_inc;
				}
				else
				{
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
					if(strEmp.equalsIgnoreCase("1")||strEmp.equalsIgnoreCase("9")) //Converting Income of Joint App if Applicant is salaried
					{
						dbl_avg_nonsal_totalinc=dbl_avg_nonsal_totalinc/12;
					}
					if(strPrdType.equalsIgnoreCase("pM"))
						dbl_tot_sal_Joint=dbl_tot_sal_Joint+dbl_year1_nonsal_totalinc;
					else
						dbl_tot_sal_Joint=dbl_tot_sal_Joint+dbl_avg_nonsal_totalinc;
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getJointApplicantsIncome "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return dbl_tot_sal_Joint;
	}
	private HashMap getNationalityCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strNation="India";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strEligCondition="Nationality of Student";
			strEligRequired="India";
			strEligAvailable=strNation;
			if(strNation.equalsIgnoreCase("India"))
			{
				strEligStatus="Eligible";
			}
			else
			{
				strEligStatus="Not Eligible";
			}
			arrCol.add(strEligCondition);
			arrCol.add(strEligRequired);
			arrCol.add(strEligAvailable);
			arrCol.add(strEligStatus);
			hshRecord.put("arrCol", arrCol);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getNationalityCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	
	private HashMap getMutualGuarantor(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs = null;
		String strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
		String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strVehicleType=Helper.correctNull((String)hshValues.get("strVehicleType"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		ResultSet rs22=null;
		try
		{
			String strCount="",strsearchid="",strTemp="",strName="";
			boolean mutualguar = false;	
			boolean count=false;
			int intcount=0;
			if(strPrdType.equalsIgnoreCase("pA") && strVehicleType.equalsIgnoreCase("3"))
				strTemp="3";
			else
				strTemp="1";
			
			String strAppOldid=strAppId;
			
			if(rs22!=null)
				rs22.close();
			
			rs22=DBUtils.executeLAPSQuery("seloldrefidforapp^"+strAppId);
			if(rs22.next())
			{
				strAppOldid=Helper.correctNull(rs22.getString("perapp_oldid"));
			}
			
			if(!strAppId.equalsIgnoreCase(""))
			{
				//No of guarantors
				String strQuery13 = SQLParser.getSqlQuery("sel_GuarantorID^"+strAppno);
				rs22 = DBUtils.executeQuery(strQuery13);
				while(rs22.next())
				{				
					strsearchid = Helper.correctNull((String)rs22.getString("demo_appid"));
					if(rs!=null) rs.close();
					String strQuery12 = SQLParser.getSqlQuery("sel_guarcount^"+strsearchid);
					rs = DBUtils.executeQuery(strQuery12);
					while(rs.next())
					{
						strCount = Helper.correctNull((String)rs.getString("guar_count"));
					}
					strEligRequired = "2";
					
					if(Integer.parseInt(strCount)>2)
					{
						strName="";
						String strQuery14 = SQLParser.getSqlQuery("sel_appnamebyId^"+strsearchid);
						ResultSet rs14 = DBUtils.executeQuery(strQuery14);
						if(rs14.next())
						{
							strName = Helper.correctNull((String)rs14.getString("coappname"));
						}
						strEligCondition = "Number of times an applicant can be added as guarantor ["+strName+"]";
						strEligAvailable = strCount;
						strEligStatus = "Not Eligible";
						break;
					}
					else
					{
						intcount++;
						count=true;
						strName="";
						String strQuery14 = SQLParser.getSqlQuery("sel_appnamebyId^"+strsearchid);
						ResultSet rs14 = DBUtils.executeQuery(strQuery14);
						if(rs14.next())
						{
							strName = Helper.correctNull((String)rs14.getString("coappname"));
						}
						strEligCondition = "Number of times an applicant added as guarantor ["+strName+"]";
						strEligAvailable = strCount;
						strEligStatus = "Eligible";
					}
				}
				if(!strEligStatus.equalsIgnoreCase("") || (count==true))
				{
					arrCol = new ArrayList();
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					arrRow.add(arrCol);
				}
				
				//Mutual guarantor
				strEligCondition="";
				strEligRequired="";
				strEligAvailable="";
				strEligStatus="";
				strName="";
				if(strPrdType.equalsIgnoreCase("pP"))
				{
					//
					String strQuery11 = SQLParser.getSqlQuery("sel_applcntid^"+strAppno);
					ResultSet rs11 = DBUtils.executeQuery(strQuery11);
					while (rs11.next()) {
						
						String strguaId=Helper.correctNull((String)rs11.getString("DEMO_APPID"));;
					//
					
					if(rs!=null) rs.close();
					String strQuery21 = SQLParser.getSqlQuery("sel_demoappnolist^"+strguaId);
					rs = DBUtils.executeQuery(strQuery21);
					while(rs.next())
					{
						String strApplctNo = Helper.correctNull((String)rs.getString("DEMO_APPNO"));
						String strQuery22 = SQLParser.getSqlQuery("sel_applcntid^"+strApplctNo);
						ResultSet rs5 = DBUtils.executeQuery(strQuery22);
						while(rs5.next())
						{
							String strnewid = Helper.correctNull((String)rs5.getString("DEMO_APPID"));
							if(strAppOldid.equals(strnewid))
							{
								String strQuery15 = SQLParser.getSqlQuery("sel_appnamebyId^"+strnewid);
								ResultSet rs15 = DBUtils.executeQuery(strQuery15);
								if(rs15.next())
								{
									strName = Helper.correctNull((String)rs15.getString("coappname"));
								}
								mutualguar=true;
							}
						}
					}
					
					//
					}
					
					//
					strEligCondition = "Mutual guarantor policy";
					strEligRequired = "Not Applicable";
					if(mutualguar==true)
					{
						strEligCondition = "Mutual guarantor policy ["+strName+"]";
						strEligAvailable = "Yes";
						strEligStatus = "Not Eligible";
					}
					if(!strEligStatus.equalsIgnoreCase(""))
					{
						arrCol = new ArrayList();
						arrCol.add(strEligCondition);
						arrCol.add(strEligRequired);
						arrCol.add(strEligAvailable);
						arrCol.add(strEligStatus);
						arrRow.add(arrCol);
					}
				}
			}
			hshRecord.put("arrRow", arrRow);
		}
		catch(Exception e)
		{
			log.error("Error in getNationalityCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	
	private HashMap getIndividualSecurityCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		boolean Secowner = true;
		String strSecOwnerId="";
		String strAgeComplete="";
		String strAgeComplete1="",strConstitution1="";
		String strNewId="",strjointId="",strPrdType="",strProperitier="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			strPrdType =Helper.correctNull((String)hshValues.get("prd_type"));
			String strConstitution = Helper.correctNull((String)hshValues.get("strConstn"));
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
			String strQuery5 = SQLParser.getSqlQuery("selcustomerdetails^"+strAppId);
			ResultSet rs5 = DBUtils.executeQuery(strQuery5);
			if(rs5.next())
			{
				strNewId = Helper.correctNull((String)rs5.getString("perapp_oldid"));
			}
			if(rs5 !=null)
			{
				rs5.close();
			}
			
			strQuery5 = SQLParser.getSqlQuery("sel_JointApplicants^"+strAppno+"^c");
			rs5 = DBUtils.executeQuery(strQuery5);
			while(rs5.next())
			{
				strjointId =strjointId+ Helper.correctNull((String)rs5.getString("demo_oldappid"))+",";
			}
			if(rs5!=null)
				rs5.close();
			
			strQuery5 = SQLParser.getSqlQuery("sel_JointApplicants^"+strAppno+"^p','c','g','o");
			rs5 = DBUtils.executeQuery(strQuery5);
			while(rs5.next())
			{
				strProperitier =strProperitier+ Helper.correctNull((String)rs5.getString("demo_oldappid"))+",";
			}
				strEligCondition="Ownernership of the added Security";
			String strQuery = SQLParser.getSqlQuery("sel_secownerid^"+strAppno);
			ResultSet rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strSecOwnerId= Helper.correctNull((String)rs.getString("APP_SEC_CUSTOMERID"));
				String strQuery1 = SQLParser.getSqlQuery("sel_borrowerage^"+strSecOwnerId);
				ResultSet rs1 = DBUtils.executeQuery(strQuery1);
				if(rs1.next())
				{
					strAgeComplete = Helper.correctNull((String)rs1.getString("agecompleted"));
					//strConstitution = Helper.correctNull((String)rs1.getString("perapp_constitution"));
				}
				if(strConstitution.equalsIgnoreCase("01") || strConstitution.equalsIgnoreCase("02"))
				{
					if(Integer.parseInt(strAgeComplete)>=18)
					{
						//Either applicant or joint applicant security must be attached
						if(strSecOwnerId.equals(strNewId) || strjointId.contains(strSecOwnerId))
						{
							Secowner = true;
							strEligRequired="Applicant/ Joint applicant should be the Security Owner";
							strEligAvailable="Applicant/ Joint applicant is the Security Owner";
							strEligStatus="Eligible";
						}
						else
						{
							Secowner = false;
							strEligRequired="Applicant/ Joint applicant should be the Security Owner";
							strEligAvailable="Security owned by Third parties also";
							strEligStatus="Not Eligible";
							break;
						}
					}
					else
					{
					String strQuery2 = SQLParser.getSqlQuery("sel_borrowerage^"+strSecOwnerId);
					ResultSet rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						strAgeComplete1 = Helper.correctNull((String)rs2.getString("agecompleted"));
						
						strConstitution1 = Helper.correctNull((String)rs2.getString("perapp_constitution"));
					}
					if(strConstitution1.equalsIgnoreCase("01") || strConstitution1.equalsIgnoreCase("02")){

					strEligRequired="Applicant/ Joint applicant Should not be a Minor";
					strEligAvailable="Applicant/ Joint applicant is Minor";
					strEligStatus="Not Eligible";
					break;
					}
					}
				}
				else
				{
					if(strPrdType.equalsIgnoreCase("pI")||strPrdType.equalsIgnoreCase("pM"))
					{
						if(strSecOwnerId.equals(strNewId) || strProperitier.contains(strSecOwnerId))
						{
							Secowner = true;
							strEligRequired="Firm/Partners/Directors/Proprietor should be the Security Owner";
							strEligAvailable="Applicant/ Joint applicant is the Security Owner";
							strEligStatus="Eligible";
						}
						else
						{
							Secowner = false;
							strEligRequired="Firm/Partners/Directors/Proprietor should be the Security Owner";
							strEligAvailable="Security owned by Third parties also";
							strEligStatus="Not Eligible";
							break;
						}
					}
				}
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}else
			{
					arrCol.add(strEligCondition);
					arrCol.add("Secutities not attached for this Proposal");
					arrCol.add("");
					arrCol.add("Not Eligible");
					hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getNationalityCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	private HashMap getCollateralPercntCheck(HashMap hshValues) 
	{
		
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strCollPercnt="0";
		String strEligCollPercnt="";
		String strAmtReqstd="";
		String strPrdType = Helper.correctNull((String)hshValues.get("prd_type"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		double strPercent=0;
		double strCollPercent=0;
		double strOtherPercent=0;
		double strImmovblePercent=0;
		String RecmdValue="";
		double dblPercent=0.0,dblAmtFrom=0.0;
		try
		{
			strEligCondition="Percentage of Collateral security required";
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
			String strQuery2=SQLParser.getSqlQuery("sel_loancollpercent^"+strAppno);
			ResultSet rs=DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				strEligCollPercnt = Helper.correctDouble((String)rs.getString("LOAN_SECURITYCOLLATERAL"));
				RecmdValue = Helper.correctDouble(rs.getString("LOAN_RECMDAMT"));
			}
			
			if(rs!=null) rs.close();
			strQuery2 = SQLParser.getSqlQuery("sel_collpercentforloandet^"+strAppno+"^"+RecmdValue);
			rs = DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				strCollPercent = Double.parseDouble(Helper.correctDouble(rs.getString("COL_PERCENT")));
				strOtherPercent = Double.parseDouble(Helper.correctDouble(rs.getString("COL_OTHER_PER")));
				strImmovblePercent = Double.parseDouble(Helper.correctDouble(rs.getString("COL_IMMOVABLE_PER")));
				dblAmtFrom = Double.parseDouble(Helper.correctDouble(rs.getString("COL_RANGE_FROM")));
			}
			strPercent = Math.max(strCollPercent,Math.max(strOtherPercent,strImmovblePercent));
			
			if(strPrdType.equalsIgnoreCase("pL")||strPrdType.equalsIgnoreCase("pM"))
			{
				if(rs!=null) rs.close();
				strQuery2 = SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery2);
				if(rs.next())
				{
					strPercent = Double.parseDouble(Helper.correctDouble(rs.getString("PRD_COLLATRALPERC")));
				}
			}
			log.info("strEligCollPercnt==================="+strPercent);
			
			if(rs!=null)rs.close();  	
			String strQuery1 = SQLParser.getSqlQuery("getCollSecPercnt^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				strCollPercnt = Helper.correctDouble((String)rs.getString("app_totalpropcoverage"));
				log.info("strCollPercnt==================="+strCollPercnt);
			}
			
			log.info("strEligCollPercnt"+strPercent);
			
			strEligRequired = strPercent+"%";
			strEligAvailable = strCollPercnt+"%";
			
			
			//if(Double.parseDouble(strEligCollPercnt)>0)
			{
				
				log.info("CONDITION TRUE");
				
				if(strPrdType.equalsIgnoreCase("pP"))
				{
					strEligCondition="Percentage of Collateral security required";
					
					double dblSanAmt=0.0;
					String strQuery3 = SQLParser.getSqlQuery("sel_margindetails^"+strAppno);
					rs = DBUtils.executeQuery(strQuery3);
					if(rs.next())
					{
						strAmtReqstd = Helper.correctDouble((String)rs.getString("loan_amtreqd"));
						dblSanAmt = Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt")));
					}
					dblSanAmt-=dblAmtFrom-1;
					if(Double.parseDouble(strAmtReqstd)>=300000)
					{
						if(rs!=null)
							rs.close();
						double dblLiquidSec=0.0,dblLiquidCoverage=0.0;
						strQuery3 = SQLParser.getSqlQuery("sel_liquidsecurities^"+strAppno);
						rs = DBUtils.executeQuery(strQuery3);
						if(rs.next())
						{
							dblLiquidSec = Double.parseDouble(Helper.correctDouble(rs.getString("secval")));
						}
						
						if(dblSanAmt!=0)
						dblLiquidCoverage=(dblLiquidSec/dblSanAmt)*100;
						
						
						if(dblLiquidCoverage>=strCollPercent)
						{
							strEligCondition="Percentage of Liquid Collateral security required";
							strEligRequired = strCollPercent+"%";
							strEligAvailable = jtn.format(dblLiquidCoverage)+"%";
							strEligStatus = "Eligible";
						}
						else
						{
							if((Double.parseDouble(strCollPercnt)>=strPercent) )
							{
								strEligStatus = "Eligible";
							}
							else
							{
								strEligStatus = "Not Eligible";
							}
						}
					}
				}
				else
				{
					
					if(strPrdType.equalsIgnoreCase("pL")||strPrdType.equalsIgnoreCase("pM"))
					strEligCondition="Percentage of the value of Mortgage property to the Loan Amount";
					if(Double.parseDouble(strCollPercnt)>=strPercent)
					{
						strEligStatus = "Eligible";
						
						log.info("Eligible ");
					}
					else
					{
						log.info("Not Eligible ====");
						strEligStatus = "Not Eligible";
					}
				}	
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					hshRecord.put("arrCol", arrCol);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCollateralPercntCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	
	private HashMap getMaxAppIncomeadd(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs = null;
		String strCollPercnt="0";
		String strEligCollPercnt="";
		String strAmtReqstd="";
		String strPrdType = Helper.correctNull((String)hshValues.get("prd_type"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		String strIncCount="",strEligible="0";
		try
		{
			strEligCondition="Number of Applicant's Income to be added";
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
			if(rs!=null)rs.close();
			String strQuery1 = SQLParser.getSqlQuery("sel_includeincomecount^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				strIncCount = Helper.correctNull((String)rs.getString("inccount"));
			}
			if(rs!=null)rs.close();
			String strQuery2 = SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				strEligible = Helper.correctInt((String)rs.getString("PRD_NOOFAPPLICNTINC"));
			}
			strEligRequired = strEligible;
			strEligAvailable = strIncCount;
			if(Integer.parseInt(strIncCount)>Integer.parseInt(strEligible))
			{
				strEligStatus = "Not Eligible";
			}
			else 
			{
				strEligStatus = "Eligible";
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCollateralPercntCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	private HashMap getGuarantorRelationCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		String strRelationarr[]=new String[20];
		String strListofRelatn = "";
		String strDemoType ="";
		boolean relation=false;
		try
		{
			strEligCondition="Relationship of the Joint Applicant";
			String strQuery = SQLParser.getSqlQuery("sel_prdinterest^"+strPrdCode);
			ResultSet rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strRelationarr = Helper.correctNull(rs.getString("PRD_RELATIONSHIP")).split("~");
				for(int i=0;i<strRelationarr.length;i++)
                {
					if(rs!=null) rs.close();
					String strQuery2 = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^32^"+strRelationarr[i]);
					rs = DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						if(strListofRelatn.equalsIgnoreCase(""))
							strListofRelatn = Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
						else
							strListofRelatn = strListofRelatn+"/ "+Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"));
					}
                }
			}
			if(strRelationarr.length>=1)
			{
				strEligRequired = strListofRelatn;
				if(rs!=null) rs.close();
				int g,o,c=0;
				String strQuery1 = SQLParser.getSqlQuery("sel_demorelation^"+strAppno);
				rs = DBUtils.executeQuery(strQuery1);
				while(rs.next())
				{
					String strRelation = Helper.correctNull((String)rs.getString("DEMO_RELATION"));
					strDemoType = Helper.correctNull((String)rs.getString("DEMO_TYPE"));
					g=0;o=0;c=0;
					String strQuery5 = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^32^"+strRelation);
					ResultSet rs1 = DBUtils.executeQuery(strQuery5);
					if(rs1.next())
					{
						strEligAvailable = Helper.correctNull(rs1.getString("CBS_STATIC_DATA_DESC"));
					}
					/*if(strDemoType.equalsIgnoreCase("g"))
					{
						for(int i=0;i<strRelationarr.length;i++)
		                {
							//k=k+1;
		                	if(strRelation.equals(strRelationarr[i]))
		                	{
		                		g=g+1;
		                		strEligAvailable = strEligAvailable;
		                		strEligStatus = "Eligible";
		                	}
		                }
					}
					if(strDemoType.equalsIgnoreCase("o"))
					{
						for(int i=0;i<strRelationarr.length;i++)
						{
							if(strRelation.equals(strRelationarr[i]))
							{
								o=o+1;
								strEligAvailable = strEligAvailable;
		                		strEligStatus = "Eligible";
							}
						}
					}*/
					if(strDemoType.equalsIgnoreCase("c"))
					{
						for(int i=0;i<strRelationarr.length;i++)
						{
							if(strRelation.equals(strRelationarr[i]))
							{
								c=c+1;
								strEligAvailable = strEligAvailable;
		                		strEligStatus = "Eligible";
							}
						}
					}
					if(!strEligStatus.equalsIgnoreCase("Eligible"))
						break;
				}
				
				/*if(g==0 && strDemoType.equalsIgnoreCase("g"))
				{
					//strEligAvailable = strEligAvailable+" cannot be selected as Guarantor";
	        		strEligStatus = "Not Eligible";
				}
				if(o==0 && strDemoType.equalsIgnoreCase("o"))
				{
					//strEligAvailable = strEligAvailable+" cannot be selected as Co - Obligant";
					strEligStatus = "Not Eligible";
				}*/
				if(c==0 && strDemoType.equalsIgnoreCase("c"))
				{
					//strEligAvailable = strEligAvailable+" cannot be selected as Joint applicant";
					strEligStatus = "Not Eligible";
				}
				
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					hshRecord.put("arrCol", arrCol);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getGuarantorRelationCheck "+e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getCoursebasedEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strEduApproved="",strQualifType="",strMeritorious="",strQuery2="",strMinMarks="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
			strQuery2=SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
			rs=DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				strMinMarks = Helper.correctNull((String)rs.getString("PRD_EXAMMINMARKS"));
			}
			if(!strMinMarks.equalsIgnoreCase(""))
			{
				if(rs!=null)rs.close();  	
				strQuery = SQLParser.getSqlQuery("eduparticularssel^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strQualifType = Helper.correctNull((String)rs.getString("edu_qual_proposed"));
					strMeritorious = Helper.correctNull((String)rs.getString("EDU_MERITORIOUS"));
					if(strQualifType.equalsIgnoreCase("3") || strMeritorious.equalsIgnoreCase("2"))
					{
						int strSecMarks = Integer.parseInt(Helper.correctInt((String)rs.getString("EDU_QUALIFYINGEXA")));
						strEligCondition="Minimum Percentage of Marks (Graduate)";
						strEligRequired=strMinMarks+"%";
						strEligAvailable=String.valueOf(strSecMarks)+"%";
						if(strSecMarks>=Integer.parseInt(strMinMarks))
						{
							strEligStatus="Eligible";
						}
						else
						{
							strEligStatus="Not Eligible";
						}
					}
					if(strQualifType.equalsIgnoreCase("2"))
					{
						int strSecMarks = Integer.parseInt(Helper.correctInt((String)rs.getString("EDU_QUALIFYINGEXA")));
						String strModeSecure = Helper.correctNull((String)rs.getString("edu_mode_secure"));
						String strMerit = Helper.correctNull((String)rs.getString("EDU_MERITORIOUS"));
						if(strModeSecure.equalsIgnoreCase("1"))
						{
							strEligCondition="Minimum Percentage of Marks (Post Graduate)";
							strEligRequired=strMinMarks+"% and Got Admission through Entrance Test";
							strEligAvailable=String.valueOf(strSecMarks)+"% and Admission through Entrance Test";
							if(strSecMarks>=Integer.parseInt(strMinMarks))
							{
								strEligStatus="Eligible";
							}
							else
							{
								strEligStatus="Not Eligible";
							}
						}
						if(strModeSecure.equalsIgnoreCase("2") || strModeSecure.equalsIgnoreCase("3"))
						{
							strEligCondition="Minimum Percentage of Marks (Post Graduate)";
							strEligRequired=strMinMarks+"% and Got Admission through Merit based/under open category";
							strEligAvailable=String.valueOf(strSecMarks)+"% and Admission through Merit based/under open category";
							if(strSecMarks>=Integer.parseInt(strMinMarks))
							{
								strEligStatus="Eligible";
							}
							else
							{
								strEligStatus="Not Eligible";
							}
						}
					}
					if(strQualifType.equalsIgnoreCase("1") || strQualifType.equalsIgnoreCase("4"))
					{
						int strSecMarks = Integer.parseInt(Helper.correctInt((String)rs.getString("EDU_QUALIFYINGEXA")));
						String strModeSecure = Helper.correctNull((String)rs.getString("edu_mode_secure"));
						String strRecogUniv = Helper.correctNull((String)rs.getString("edu_univ_approved"));
						strEligCondition="Admission in Recognized University/Institution (Professional /Diploma certification)";
						strEligRequired=strMinMarks+"% and Recognized University/Institution";
						if(strSecMarks>=Integer.parseInt(strMinMarks))
						{
							if(strRecogUniv.equalsIgnoreCase("1"))
							{
								strEligAvailable=String.valueOf(strSecMarks)+"% and Recognized University/Institution";
								strEligStatus="Eligible";
							}
							else
							{
								strEligAvailable=String.valueOf(strSecMarks)+"% and Not a Recognized University/Institution";
								strEligStatus="Not Eligible";
							}
						}
						else
						{
							if(strRecogUniv.equalsIgnoreCase("1"))
							{
								strEligAvailable=String.valueOf(strSecMarks)+"% and Recognized University/Institution";
							}
							else
							{
								strEligAvailable=String.valueOf(strSecMarks)+"% and Not a Recognized University/Institution";
							}
							strEligStatus="Not Eligible";
						}
						if(!strEligStatus.equalsIgnoreCase("Eligible")&&
								(strModeSecure.equalsIgnoreCase("2") || strModeSecure.equalsIgnoreCase("3")))
						{
							strEligCondition="Minimum Percentage of Marks (Professional /Diploma certification)";
							strEligRequired=strMinMarks+"% and Got Admission through Merit based/under open category";
							strEligAvailable=String.valueOf(strSecMarks)+"% and Admission through Merit based/under open category";
							if(strSecMarks>=Integer.parseInt(strMinMarks))
							{
								strEligStatus="Eligible";
							}
							else
							{
								strEligStatus="Not Eligible";
							}
						}
					}			
				}
				if(!strEligStatus.equalsIgnoreCase(""))
				{
					arrCol.add(strEligCondition);
					arrCol.add(strEligRequired);
					arrCol.add(strEligAvailable);
					arrCol.add(strEligStatus);
					hshRecord.put("arrCol", arrCol);
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getRecogInstituteCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
	
	private HashMap getRecogInstituteCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="", strEduApproved="";
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		try
		{
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strEligCondition="Admission in Recognized Institution";
			strEligRequired="Yes";
			strQuery = SQLParser.getSqlQuery("eduparticularssel^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strEduApproved=Helper.correctNull(rs.getString("edu_univ_approved"));
			}
			if(strEduApproved.equalsIgnoreCase("1"))
			{
				strEligAvailable="Yes";
				strEligStatus="Eligible";
			}
			else
			{
				strEligAvailable="No";
				strEligStatus="Not Eligible";
			}
			arrCol.add(strEligCondition);
			arrCol.add(strEligRequired);
			arrCol.add(strEligAvailable);
			arrCol.add(strEligStatus);
			hshRecord.put("arrCol", arrCol);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getRecogInstituteCheck "+e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getMISClassification(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		String strClassification="";
		try
		{
			strEligCondition="MIS Classification";
			strEligRequired="Priority Sector";
			strQuery = SQLParser.getSqlQuery("sel_mispagedetails^"+ strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strClassification=Helper.correctNull(rs.getString("app_sector"));
			}
			if(strClassification.equalsIgnoreCase("01"))
			{
				strEligStatus="Eligible";
				strEligAvailable="Priority Sector";
			}
			else if(strClassification.equalsIgnoreCase("02"))
			{
				strEligStatus="Not Eligible";
				strEligAvailable="Non-Priority Sector";
			}
			else
			{
				strEligStatus="Not Eligible";
				strEligAvailable="Not Available";
			}
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMISClassification "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshRecord;
	}
	private HashMap getMaxCoappGuarantor(HashMap hshValues) {
		
		HashMap hshRecord=new HashMap();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		strEligCondition="";
		strEligRequired="";
		strEligAvailable="";
		strEligStatus="";
		
		int jointappprd=0;
		int coappguarprd=0;
		int appmaxjntcount=0;
		int appmaxguarcount=0;
		
		
		try{
			strQuery=SQLParser.getSqlQuery("sel_specificeligible^"+Helper.correctNull((String)hshValues.get("prdcode")));
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()){
				
				jointappprd=Integer.parseInt(Helper.correctInt(rs.getString("prd_maxnoofjointapp")));
				coappguarprd=Integer.parseInt(Helper.correctInt(rs.getString("prd_maxnoofguarantor")));
				
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_countjointapplicant^"+strAppno+"^c");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next()){
				
				appmaxjntcount=Integer.parseInt(Helper.correctInt(rs.getString("demo_appid")));
		
			}
			
			
			
			
			if(appmaxjntcount<=jointappprd){
				strEligCondition="Maximum Number of Joint Applicants";
				strEligRequired="Required-"+jointappprd;
				strEligAvailable="Available-"+appmaxjntcount;
				strEligStatus="Eligible";
			}
			else{
				strEligCondition="Maximum Number of Joint Applicants";
				strEligRequired="Required-"+jointappprd;
				strEligAvailable="Available-"+appmaxjntcount;
				strEligStatus="Not Eligible";
			}
			
			
	
			if(!strEligStatus.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
				hshRecord.put("arrCol", arrCol);
			}
		
		}
		
		catch(Exception e){
			throw new EJBException("Exception in getMaxCoappGuarantor...."+e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getBusinessLoanEligibility(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshTemp=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strConstitution="",strDefCIBIL="",strDefCRIF="",strBorrowerCIBIL="",strBorrowerCRIF="";
		ResultSet rs=null;
		
		ArrayList arrCol1=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		try
		{
			
			hshValues.put("strAppno",strAppno);
			strConstitution=getApplntConstitution(hshValues);
			
			if(strConstitution.equalsIgnoreCase("01")||strConstitution.equalsIgnoreCase("02"))
			{
				hshTemp=new HashMap();
				hshTemp=getAgeCheck(hshValues);
				
				arrCol1=new ArrayList();
				arrCol2=new ArrayList();
				arrCol1=(ArrayList)hshTemp.get("arrCol");
				if(arrCol1!=null && arrCol1.size()>0)
				{
					for(int i=0;i<arrCol1.size();i++)
					{
						arrCol2=(ArrayList)arrCol1.get(i);
						if(arrCol2!=null && arrCol2.size()>0)
						arrRow.add(arrCol2);
					}
				}
				
				hshTemp=new HashMap();
				hshValues.put("strCheck","CIBIL");
				hshTemp=getCIBILCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
				
			}
			else
			{
				hshTemp=new HashMap();
				hshValues.put("strCheck","CRIF");
				hshTemp=getCIBILCheck(hshValues);
				arrCol=new ArrayList();
				arrCol=(ArrayList)hshTemp.get("arrCol");
				arrRow.add(arrCol);
			}
			
			hshTemp=new HashMap();
			hshTemp=getCollateralPercntCheck(hshValues);
			arrCol=new ArrayList();
			arrCol=(ArrayList)hshTemp.get("arrCol");
			arrRow.add(arrCol);
			
			
			
			arrCol=new ArrayList();
			arrCol.add("Accounts under this scheme are not eligible for CGTMSE Cover");
			arrCol.add("Yes");
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^1");
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("app_guarantee")).equalsIgnoreCase("11"))
				{
					arrCol.add("No");
					arrCol.add("Not Eligible");
				}
				else
				{
					arrCol.add("Yes");
					arrCol.add("Eligible");
				}
			}
			else
			{
				arrCol.add("");
				arrCol.add("Not Eligible");
			}
			
			arrRow.add(arrCol);
			
			
			
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		return hshRecord;
	}
	private HashMap getCIBILCheck(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strDefCIBIL="",strDefCRIF="",strBorrowerCIBIL="",strBorrowerCRIF="",strCheck="";
		ResultSet rs=null;
		ArrayList arrCol=new ArrayList();
		String strEligCondition="",strEligRequired="",strEligAvailable="",strEligStatus="";
		try
		{
			String strAppId=Helper.correctNull((String)hshValues.get("comappid"));
			strCheck=Helper.correctNull((String)hshValues.get("strCheck"));
			
			rs=DBUtils.executeLAPSQuery("sel_specificeligible^"+Helper.correctNull((String)hshValues.get("prdcode")));
			if(rs.next())
			{
				strDefCIBIL=Helper.correctNull(rs.getString("prd_mincibilscore"));
				strDefCRIF=Helper.correctNull(rs.getString("prd_mincrifscore"));
			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("select_cuscibildetails^"+strAppId);
			if(rs.next())
			{
				strBorrowerCIBIL=Helper.correctNull(rs.getString("cibil_score"));
				strBorrowerCRIF=Helper.correctNull(rs.getString("CRIF_SCORE"));
			}
			
			if(strCheck.equalsIgnoreCase("CIBIL"))
			{
				
				strEligCondition="CIBIL Score";
				strEligRequired=strDefCIBIL;
				strEligAvailable=strBorrowerCIBIL;
				if(Integer.parseInt(Helper.correctInt(strDefCIBIL))<=Integer.parseInt(Helper.correctInt(strBorrowerCIBIL)))
					strEligStatus="Eligible";
				else
					strEligStatus="Not Eligible";
				
			}
			else if(strCheck.equalsIgnoreCase("CRIF"))
			{
				
				strEligCondition="CRIF Score";
				strEligRequired=strDefCRIF;
				strEligAvailable=strBorrowerCRIF;
				if(Integer.parseInt(Helper.correctInt(strDefCRIF))<=Integer.parseInt(Helper.correctInt(strBorrowerCRIF)))
					strEligStatus="Eligible";
				else
					strEligStatus="Not Eligible";
			}
			
			if(!strEligCondition.equalsIgnoreCase(""))
			{
				arrCol.add(strEligCondition);
				arrCol.add(strEligRequired);
				arrCol.add(strEligAvailable);
				arrCol.add(strEligStatus);
			}
			
			hshRecord.put("arrCol", arrCol);
		}
		catch(Exception e)
		{
			log.error("Error in getNationalityCheck "+e.getMessage());
		}
		return hshRecord;
	}
	
}