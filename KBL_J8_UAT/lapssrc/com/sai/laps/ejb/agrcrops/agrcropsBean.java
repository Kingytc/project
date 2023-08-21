package com.sai.laps.ejb.agrcrops;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.rules.AgrCropAssessmentBO;
import com.sai.laps.ejb.rules.AgrFarmMachineryBO;
import com.sai.laps.ejb.rules.AgrLandHoldingsBO;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.helper.UpdateDairyData;
@Stateless(name = "agrcropsBean", mappedName = "agrcropsHome")
@Remote (agrcropsRemote.class)
public class agrcropsBean extends BeanAdapter 
{
	static Logger log=Logger.getLogger(agrcropsBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = -231106835995968718L;


	/**
	 * 
	 */
	

	public HashMap getPreviousseasonData(HashMap hshValues)  {

		String strQuery = "";
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			String count="";
			String count1="";
			String appno = correctNull((String) hshValues.get("appno"));
			
			if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			String hidcroptype = correctNull((String) hshValues.get("hidcroptype"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs2= DBUtils.executeQuery(strQuery);
			if (rs2.next())
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs2.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs2.getString("app_status"))));
				hshRecord.put("applicantid", rs2.getString("demo_appid"));
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			
			strQuery = SQLParser.getSqlQuery("agrcropselection^" + appno + "^" + hidcroptype);
			rs2 = DBUtils.executeQuery(strQuery);
			while (rs2.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("crop_appno")));
				vecVal.add(correctNull(rs2.getString("crop_type")));
				vecVal.add(correctNull(rs2.getString("crop_slno")));
				vecVal.add(correctNull(rs2.getString("crop_season")));
				vecVal.add(correctNull(rs2.getString("crop_area")));
				vecVal.add(correctNull(rs2.getString("crop_avg_yeild")));
				vecVal.add(Helper.correctDouble(rs2.getString("crop_cost_cult")));
				vecVal.add(Helper.correctDouble(rs2.getString("crop_gross_income")));
				vecVal.add(Helper.correctDouble(rs2.getString("crop_net_income")));
				vecVal.add(correctNull(rs2.getString("crop_year")));
				vecVal.add(correctNull(rs2.getString("crop_household")));
				vecVal.add(correctNull(rs2.getString("crop_season1")));
				vecVal.add(count);
				vecVal.add(count1);
				vecVal.add(correctNull(rs2.getString("crop_irrigated")));
				vecVal.add(correctNull(rs2.getString("crop_irrigated_amt")));
				vecVal.add(correctNull(rs2.getString("crop_acre")));
				vecVal.add(correctNull(rs2.getString("crop_total_area")));
				vecVal.add(correctNull(rs2.getString("crop_value")));
				vecVal.add(correctNull(rs2.getString("crop_cost")));
				vecVal.add(correctNull(rs2.getString("crop_sowing")));
				vecVal.add(correctNull(rs2.getString("crop_harvesting")));
				vecData.add(vecVal);
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			hshRecord.put("vecData", vecData);
			hshRecord.put("PageType",PageType);
			
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs2 = DBUtils.executeQuery(strQuery);
			String strLandMeasurement="";
			if(rs2.next())
			{
				strLandMeasurement=correctNull(rs2.getString("land_measurement"));
				hshRecord.put("land_measurement",strLandMeasurement);
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			
			strQuery=SQLParser.getSqlQuery("selLandAcreage^"+appno);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
				int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
				hshRecord.put("totLandHolding",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
			}
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
		} 
		finally
		{
			try
			{
				if (rs2 != null) 
				{
					rs2.close();
				}
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	private int getMaxGradeId(String appno)  
	{
		String strQuery = "";
		ResultSet rs = null;
		int termId = 0;

		try
		{
			strQuery = SQLParser.getSqlQuery("agrcropmax^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if (rs.getString(1) != null) 
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				} 
				else 
				{
					termId = 1;
				}
			}
			if(rs != null)
			{
				rs.close();
			}
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return termId;
	}

	public void updatePreviousseasonData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strGradeId = "",strQuery="";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		ResultSet rs = null;
		double crop_total_area =0.00;
		double acre = 0.00;
		double centgunt = 0.00;
			
		String strSeason="",strCrop="",strAcre="",strCents="",strirrrain="",strloanreq=""
			,strcultivationcost="",strsowmth="",strharmth="",stryield="",strprice="",strgross="",strnet="",
			strcroptype="",strtotarea="";
		
		strcroptype=correctNull((String) hshValues.get("hidcroptype"));
		strCrop=correctNull((String) hshValues.get("txt_crop"));
		stryield=correctNull((String) hshValues.get("txt_avg_yield"));
		strcultivationcost=correctNull((String) hshValues.get("txt_cost"));
		strgross=correctNull((String) hshValues.get("txt_grossincome"));
		strnet=correctNull((String) hshValues.get("txt_netincome"));
		strSeason=correctNull((String) hshValues.get("season"));
		strirrrain=correctNull((String) hshValues.get("sel_irrigated"));
		strloanreq=correctNull((String) hshValues.get("txt_irrigated"));
		strCents=correctNull((String) hshValues.get("txt_acre"));
		acre = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_area")));
		
		if(!strCents.equalsIgnoreCase("0") && !strCents.equalsIgnoreCase(""))
		{
			centgunt = Double.parseDouble(strCents);
			double realval = centgunt / 100 ;
			crop_total_area = acre + realval;
			strtotarea = Helper.formatDoubleValue(crop_total_area);
		}
		else
		{
			centgunt=0.00;	
			crop_total_area = acre;
			strtotarea =Helper.formatDoubleValue(crop_total_area); 
		}
		
		strprice=correctNull((String) hshValues.get("txt_value"));
		strsowmth=correctNull((String) hshValues.get("txt_month_sowing"));
		strharmth=correctNull((String) hshValues.get("txt_month_harvesting"));
		try 
		{
			//Added By Zahoorunnisa.S For Audit Trial
			StringBuilder sbAuditTrialOld=new StringBuilder();
			String hidcroptype = correctNull((String) hshValues.get("hidcroptype"));
			if(!strAction.equalsIgnoreCase("insert")){
			strGradeId = correctNull((String) hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrcropselection^" + appno + "^" + hidcroptype);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strGradeId.equalsIgnoreCase(correctNull((String)rs.getString("crop_slno")))){
				String stracre = correctNull((String )rs.getString("crop_total_area"));
				int intindex = stracre.lastIndexOf(".");
				if(intindex != -1){
					stracre = stracre.substring(0, intindex); 
				}
			sbAuditTrialOld.append("Season=")
			.append(ApplicantParams.getApplicantParams("AgricultureCroppingSeason",correctNull((String)rs.getString("crop_season1"))))
			.append("~Crop =").append(correctNull((String )rs.getString("crop_season")))
			.append("~Area in Acre =").append(stracre)
			.append("~Area in ").append(correctNull((String )hshValues.get("hidmeasurementval")))
			.append(" =").append(correctNull((String )rs.getString("crop_acre")))
			.append("~Irrigated/Rainfed =")
			.append(ApplicantParams.getApplicantParams("AgricultureProposedCrops",correctNull((String)rs.getString("crop_irrigated"))))
			.append("~Loan Required/acre(Rs.)=").append(correctNull((String )rs.getString("crop_irrigated_amt")))
			.append("~Total Amount of loan(Rs.) =")
			.append(correctNull((String )rs.getString("crop_cost_cult"))).append("~Month of Sowing =")
			.append(Helper.getMonths(Integer.parseInt(Helper.correctInt((String )rs.getString("crop_sowing")))))
			.append("~Month of Harvesting =")
			.append(Helper.getMonths(Integer.parseInt(Helper.correctInt((String )rs.getString("crop_harvesting")))))
			.append("~Average Yield/acre Qntal =").append(correctNull((String )rs.getString("crop_avg_yeild")))
			.append("~Value of Produce/Qntal(Rs) =").append(correctNull((String )rs.getString("crop_value")))
			.append("~Gross Income (Expected) =").append(correctNull((String )rs.getString("crop_gross_income")))
			.append("~Net Income (Expected) =").append(Helper.correctDouble((String )rs.getString("crop_net_income")));
			}}
			}//End
			if (strAction.equals("update")) 
			{
				strGradeId = correctNull((String) hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrcropupdate");
				
				arrValues.add(strcroptype);
				arrValues.add(strCrop);
						
				if(strAcre.equalsIgnoreCase(""))
					{
					strAcre="0";
					}
				arrValues.add(strAcre);
				
				if(stryield.equalsIgnoreCase(""))
				{
					stryield="0.00";
				}
				arrValues.add(stryield);
				if (strcultivationcost.equalsIgnoreCase("")) 
				{
					strcultivationcost = "0.00";
				}
				arrValues.add(strcultivationcost);
				
				if (strgross.equalsIgnoreCase("")) 
				{
					strgross = "0";
				}
				arrValues.add(strgross);
				
				if (strnet.equalsIgnoreCase("")) 
				{
					strnet = "0";
				}
				arrValues.add(strnet);
				
				arrValues.add(strSeason);
				arrValues.add(strirrrain);
				
				if(strloanreq.equalsIgnoreCase(""))
				{
					strloanreq="0.00";
				}
				arrValues.add(strloanreq);
								
				
				if(strCents.equalsIgnoreCase(""))
				{
					strCents="0";
				}
				arrValues.add(strCents);
				arrValues.add(strtotarea);
					
				if(strprice.equalsIgnoreCase(""))
				{
					strprice="0.00";
				}
				arrValues.add(strprice);
				arrValues.add(strsowmth);
				arrValues.add(strharmth);
				arrValues.add(appno);
				arrValues.add(strGradeId);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agrassesmentdetailsdel");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				hshQueryValues.put("size", "3");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agrassesmentdetailsins");
				String season="";
				
				arrValues.add(strGradeId);
				arrValues.add(appno);
				if(strSeason.equalsIgnoreCase("1"))
				{
					season="k1";
				}
				else if(strSeason.equalsIgnoreCase("2"))
				{
					season="r1";
				}
				else if(strSeason.equalsIgnoreCase("3"))
				{
					season="s1";
				}
				else if(strSeason.equalsIgnoreCase("4"))
				{
					season="a1";
				}
				else if(strSeason.equalsIgnoreCase("5"))
				{
					season="p1";
				}
				strQuery = SQLParser.getSqlQuery("selassesmentsnomax^"+season+"^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					int temp=rs.getInt("maxid");
					arrValues.add(Integer.toString(temp-1));
				}
				if(rs != null)
				{
					rs.close();
				}
				arrValues.add(season);
				arrValues.add(strtotarea);
				arrValues.add(strcultivationcost);
				String cropseason=strCrop;
				if(strirrrain.equalsIgnoreCase("1"))
				{
					cropseason=cropseason+" - "+"Irrigated";
				}
				else
				{
					cropseason=cropseason+" - "+"Rainfed";
				}
				arrValues.add(cropseason);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("insert")) 
			{
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrcropinsert");
				arrValues.add(appno);
				arrValues.add(strcroptype);
				arrValues.add(strGradeId);
				arrValues.add(strCrop);
				
				
				if(strAcre.equalsIgnoreCase(""))
				{
					strAcre="0";
				}
				arrValues.add(strAcre);
				
				if(stryield.equalsIgnoreCase(""))
				{
					stryield="0.00";
				}
				arrValues.add(stryield);
				if (strcultivationcost.equalsIgnoreCase("")) 
				{
					strcultivationcost = "0.00";
				}
				arrValues.add(strcultivationcost);
				
				if (strgross.equalsIgnoreCase("")) 
				{
					strgross = "0";
				}
				arrValues.add(strgross);
				
				if (strnet.equalsIgnoreCase("")) 
				{
					strnet = "0";
				}
				arrValues.add(strnet);	
				arrValues.add(strSeason);
				arrValues.add(strirrrain);
				
				if(strloanreq.equalsIgnoreCase(""))
				{
					strloanreq="0.00";
				}
				arrValues.add(strloanreq);
								
				
				if(strCents.equalsIgnoreCase(""))
				{
					strCents="0";
				}
				arrValues.add(strCents);
				arrValues.add(strtotarea);
				
				if(strprice.equalsIgnoreCase(""))
				{
					strprice="0.00";
				}
				arrValues.add(strprice);
				arrValues.add(strsowmth);
				arrValues.add(strharmth);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				// insert the values in agrassementdetails table
				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agrassesmentdetailsins");
				String season="";String cropseason="";
				
				arrValues.add(strGradeId);
				arrValues.add(appno);
				if(strSeason.equalsIgnoreCase("1"))
				{
					season="k1";
				}
				else if(strSeason.equalsIgnoreCase("2"))
				{
					season="r1";
				}
				else if(strSeason.equalsIgnoreCase("3"))
				{
					season="s1";
				}
				else if(strSeason.equalsIgnoreCase("4"))
				{
					season="a1";
				}
				else if(strSeason.equalsIgnoreCase("5"))
				{
					season="p1";
				}
				strQuery = SQLParser.getSqlQuery("selassesmentsnomax^"+season+"^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					arrValues.add(rs.getString("maxid"));
				}
				if(rs != null)
				{
					rs.close();
				}
				arrValues.add(season);
				arrValues.add(strtotarea);
				arrValues.add(strcultivationcost);
				cropseason=strCrop;
				if(strirrrain.equalsIgnoreCase("1"))
				{
					cropseason=cropseason+" - "+"Irrigated";
				}
				else
				{
					cropseason=cropseason+" - "+"Rainfed";
				}
				arrValues.add(cropseason);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.equals("delete"))
			{
				strGradeId = correctNull((String) hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "agrcropdelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(strcroptype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agrassesmentdetailsdel");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			
			sbAuditTrial.append("Season=").append(correctNull((String )hshValues.get("season1"))).append("~Crop =")
			.append(correctNull((String )hshValues.get("txt_crop")))
			.append("~Area in Acre =").append(correctNull((String )hshValues.get("txt_area")))
			.append("~Area in ").append(correctNull((String )hshValues.get("hidmeasurementval")))
			.append(" =").append(correctNull((String )hshValues.get("txt_acre")))
			.append("~Irrigated/Rainfed =")
			.append(ApplicantParams.getApplicantParams("AgricultureProposedCrops",correctNull((String )hshValues.get("sel_irrigated"))))
			.append("~Loan Required/acre(Rs.)=").append(correctNull((String )hshValues.get("txt_irrigated")))
			.append("~Total Amount of loan(Rs.) =")
			.append(correctNull((String )hshValues.get("txt_cost"))).append("~Month of Sowing =")
			.append(Helper.getMonths(Integer.parseInt(Helper.correctInt((String )hshValues.get("txt_month_sowing")))))
			.append("~Month of Harvesting =")
			.append(Helper.getMonths(Integer.parseInt(Helper.correctInt((String )hshValues.get("txt_month_harvesting")))))
			.append("~Average Yield/acre Qntal =").append(correctNull((String )hshValues.get("txt_avg_yield")))
			.append("~Value of Produce/Qntal(Rs) =").append(correctNull((String )hshValues.get("txt_value")))
			.append("~Gross Income (Expected) =").append(correctNull((String )hshValues.get("txt_grossincome")))
			.append("~Net Income (Expected) =").append(correctNull((String )hshValues.get("txt_netincome")));
			}
			AuditTrial.auditNewLog(hshValues,"220",appno,sbAuditTrial.toString(),sbAuditTrialOld.toString());
		}
		catch (Exception ce) 
		{
			throw new EJBException("inside update" + ce.toString());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
	}

	public HashMap getPlantationData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();

		try 
		{			
			String appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String strGradeNo = correctNull((String) hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next())
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))));
				hshRecord.put("applicantid", rs1.getString("demo_appid"));
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			if (strAction.trim().equals("edit")) 
			{
				strQuery = SQLParser.getSqlQuery("agrplantsel^" + appno + "^"+ strGradeNo);
			} 
			else
			{
				strQuery = SQLParser.getSqlQuery("agrplantselection^" + appno);
			}
			rs2 = DBUtils.executeQuery(strQuery);
			while (rs2.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("crop_appno")));
				vecVal.add(correctNull(rs2.getString("crop_slno")));
				vecVal.add(correctNull(rs2.getString("crop_name")));
				vecVal.add(correctNull(rs2.getString("crop_planted")));
				vecVal.add(correctNull(rs2.getString("crop_bearing")));
				vecVal.add(correctNull(rs2.getString("crop_nonbearing")));
				vecData.add(vecVal);
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			hshRecord.put("vecData", vecData);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
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
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	private int getMaxGradeId1(String appno)  
	{
		String strQuery = "";
		ResultSet rs = null;
		int termId = 0;
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrplantmax^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				if (rs.getString(1) != null) 
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				} 
				else 
				{
					termId = 1;
				}
			}
			if(rs != null)
			{
				rs.close();
			}
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return termId;
	}

	public void updatePlantationData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strGradeId = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try 
		{
			if (strAction.equals("update"))
			{
				strGradeId = correctNull((String) hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrplantupdate");
				arrValues.add(correctNull((String) hshValues.get("txt_crop")));
				arrValues.add(correctNull((String) hshValues.get("txt_plantation")));
				arrValues.add(correctNull((String) hshValues.get("txt_bearing")));
				String val = correctNull((String) hshValues.get("txt_nonbearing"));
				arrValues.add(val);
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("insert")) 
			{
				strGradeId = Integer.toString(getMaxGradeId1(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrplantinsert");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String) hshValues.get("txt_crop")));
				arrValues.add(correctNull((String) hshValues.get("txt_plantation")));
				arrValues.add(correctNull((String) hshValues.get("txt_bearing")));
				String val = correctNull((String) hshValues.get("txt_nonbearing"));
				arrValues.add(val);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.equals("delete")) 
			{
				strGradeId = correctNull((String) hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "agrplantdelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} 
		catch (Exception ce) 
		{
			throw new EJBException("inside update" + ce.toString());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
	}

	public HashMap getCapitalData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));	
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		String recordflag="N";
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_capital^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(correctNull(rs.getString("seqno")));
				arryCol.add(appno);
				arryCol.add(correctNull(rs.getString("sno")));
				arryCol.add(correctNull(rs.getString("crop_type")));				
				arryCol.add(correctNull(rs.getString("crop_activity")));
				arryCol.add(correctNull(rs.getString("crop_units")));
				arryCol.add(correctNull(rs.getString("crop_particulars")));
				arryCol.add(correctNull(rs.getString("crop_requirements")));
				arryCol.add(correctNull(rs.getString("crop_totamtWC")));
				arryCol.add(correctNull(rs.getString("crop_roiWC")));
				arryCol.add(correctNull(rs.getString("crop_repayWC")));
				arryRow.add(arryCol);

				recordflag="Y";
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("recordflag",recordflag);
		} 
		catch (Exception ce) 
		{
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
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateCapitalData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String PageType = correctNull((String) hshValues.get("hidpagetype"));
		try 
		{
			String[] stxt_activity = null;
			String[] txt_units = null;
			String[] txt_particular = null;
			String[] txt_req = null;
			//String[] txt_purpose = null;
			//String[] txt_estimate = null;
			String totloanamtWC="";
			String roiWC="";
			String repayWC="";

			stxt_activity = (String[]) hshValues.get("txt_activity");
			txt_units = (String[]) hshValues.get("txt_units");
			txt_particular = (String[]) hshValues.get("txt_particular");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_req = (String[]) hshValues.get("txt_req");
			totloanamtWC=correctNull((String)hshValues.get("txt_totalreq"));
			roiWC=correctNull((String)hshValues.get("txt_roiWC"));
			repayWC=correctNull((String)hshValues.get("txt_repaymentWC"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete")) 
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_capital");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert")) 
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_capital");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_capital");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;
				for (int i = 0; i < stxt_activity.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_capital");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1)
					{
						arrValues.add("w1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("w2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("w3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("w4");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("w5");
					}
					if (i + 1 == 6) 
					{
						arrValues.add("w6");
					}
					if (i + 1 == 7)
					{
						arrValues.add("w7");
					}
					if (correctNull(stxt_activity[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{						
						arrValues.add(correctNull(stxt_activity[i]));
					}
					if (correctNull(txt_units[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_units[i]));
					}
					if (correctNull(txt_particular[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_particular[i]));
					}	
					if (correctNull(txt_req[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_req[i]));
					}		
					if(totloanamtWC=="")
					{
						totloanamtWC="0.00";
					}
					arrValues.add(totloanamtWC);
					if(roiWC=="")
					{
						roiWC="0.00";
					}
					arrValues.add(roiWC);
					if(repayWC=="")
					{
						repayWC="0.00";
					}
					arrValues.add(repayWC);
					
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getCapitalData(hshpasValues);
			hshResult.put("PageType", PageType);
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
			sbAuditTrial.append("~Working Capital Requirement for allied activities ^");
			for (int i = 0; i < stxt_activity.length; i++)
			{	
				
				sbAuditTrial.append("~Activity = ").append(correctNull(stxt_activity[i])).append("~Physical Units = ").append(correctNull(txt_units[i]))
				.append("~Particulars = ").append(correctNull(txt_particular[i]))
				.append("~Amount Required = ").append(correctNull(txt_req[i]));
			}	
				sbAuditTrial.append("~Total Amount = ").append(correctNull((String )hshValues.get("txt_totalreq")))
				.append("~Margin % = ").append(correctNull((String )hshValues.get("txt_roiWC")))
				.append("~Renewal period = ").append(correctNull((String )hshValues.get("txt_repaymentWC")));
				
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
			}		
				AuditTrial.auditLog(hshValues,"221",appno,sbAuditTrial.toString());
				
			
			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getAssesmentData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		String croptype[]={"k1","r1","s1","a1","p1"};
		ArrayList arryRowkh = new ArrayList();
		ArrayList arryRowrb = new ArrayList();
		ArrayList arryRowsu = new ArrayList();
		ArrayList arryRowan = new ArrayList();
		ArrayList arryRowpe = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String scrop_date="";
             
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			
			for(int i=0;i<5;i++)
			{
				if(rs!=null)
					rs.close();
				strQuery="";
			
				strQuery = SQLParser.getSqlQuery("per_get_assesment^" + appno+"^"+croptype[i]);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("seqno"));
					arryCol.add(rs.getString("sno"));
					arryCol.add(rs.getString("crop_type"));
					scrop_date=correctNull((String)rs.getString("crop_date"));
					if(scrop_date.equalsIgnoreCase("01/01/1900"))
					{
						arryCol.add("");
					}
					else
					{
						arryCol.add(scrop_date);
					}
					arryCol.add(rs.getString("crop_area"));
					arryCol.add(rs.getString("crop_finance"));
					arryCol.add(rs.getString("crop_eligibility"));
					arryCol.add(rs.getString("crop_loanamt"));
					arryCol.add(rs.getString("crop_amount1"));
					arryCol.add(rs.getString("crop_yield"));
					arryCol.add(rs.getString("crop_produce"));
					arryCol.add(rs.getString("crop_surplus"));
					arryCol.add(rs.getString("crop_repay"));
				    arryCol.add(rs.getString("crop_name"));
				    arryCol.add(rs.getString("crop_remarks"));
				    arryCol.add(rs.getString("crop_margin"));
					
					arryRowkh.add(arryCol);
				}
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			
			hshRecord.put("arryRowkh", arryRowkh);
			hshRecord.put("arryRowrb", arryRowrb);
			hshRecord.put("arryRowsu", arryRowsu);
			hshRecord.put("arryRowan", arryRowan);
			hshRecord.put("arryRowpe", arryRowpe);
			
			hshRecord.put("PageType", PageType);
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
			}
			if(rs != null)
			{
				rs.close();
			}
		} 
		catch (Exception ce)
		{
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
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap updateAssesmentData(HashMap hshValues)  
	{
		//String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
				
		HashMap hshResult = new HashMap();
		
		int intUpdatesize = 0;
				
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		
		
				
		try 
		{
			Object objSeqno = hshValues.get("hidseqno");
			
			if(objSeqno instanceof String[])
			{
				String[] seqno = null;
				String[] sno = null;
				String[] croptype = null;
				String[] txt_crop = null;
				String[] txt_area = null;
				String[] txt_finance = null;
				String[] txt_amount = null;
				String[] txt_yield = null;
				String[] txt_produce = null;
				String[] txt_surplus = null;
				String[] txt_repay = null;
				String[] txt_eligibility = null;
				String[] txt_date = null;
				String[] txt_remarks = null;
				String[] txt_amount1 = null;
				String[] txt_marginamount=null;
				
				seqno=(String[]) hshValues.get("hidseqno");
				sno=(String[]) hshValues.get("hidsno");
				croptype=(String[]) hshValues.get("hidcroptype");
				txt_date = (String[]) hshValues.get("txt_date");
				txt_area = (String[]) hshValues.get("txt_area");
				txt_crop = (String[]) hshValues.get("txt_crop");
				txt_finance = (String[]) hshValues.get("txt_finance");
				txt_eligibility = (String[]) hshValues.get("txt_eligibility");
				txt_amount = (String[]) hshValues.get("txt_amount");
				txt_amount1 = (String[]) hshValues.get("txt_amount1");
				txt_yield = (String[]) hshValues.get("txt_yield");
				txt_produce = (String[]) hshValues.get("txt_produce");
				txt_surplus = (String[]) hshValues.get("txt_surplus");
				txt_repay = (String[]) hshValues.get("txt_repay");
				txt_remarks = (String[]) hshValues.get("txt_remarks");
				txt_marginamount = (String[]) hshValues.get("txt_marginamount");
				
				
				if (strAction.equals("insert"))
				{
					HashMap hshQuery3 = new HashMap();
					ArrayList arrValues3 = new ArrayList();
					hshQuery3.put("size", "2");
					hshQuery3.put("strQueryId", "per_del_assesment");
					arrValues3.add(appno);
					hshQuery3.put("arrValues", arrValues3);
					
					intUpdatesize = 1;

					for (int i = 0; i < txt_amount.length; i++)
					{					
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "per_ins_assesment");
						arrValues.add(correctNull(seqno[i]));
						arrValues.add(appno);
						arrValues.add(correctNull(sno[i]));
						arrValues.add(correctNull(croptype[i]));
						if (correctNull(txt_date[i]).equals(""))
						{
							arrValues.add("01/01/1900");
						} 
						else 
						{
							arrValues.add(correctNull(txt_date[i]));
						}
						if (correctNull(txt_area[i]).equals("")) 
						{
							arrValues.add("");
						} 
						else 
						{
							arrValues.add(correctNull(txt_area[i]));
						}
						
						if (correctNull(txt_finance[i]).equals(""))
						{
							arrValues.add("0.00");
						} 
						else 
						{
							arrValues.add(correctNull(txt_finance[i]));
						}
						if (correctNull(txt_eligibility[i]).equals(""))
						{
							arrValues.add("0.00");
						} 
						else 
						{
							arrValues.add(correctNull(txt_eligibility[i]));
						}
						if (correctNull(txt_amount[i]).equals("")) 
						{
							arrValues.add("0.00");
						}
						else 
						{
							arrValues.add(correctNull(txt_amount[i]));
						}
						if (correctNull(txt_amount1[i]).equals("")) 
						{
							arrValues.add("0.00");
						}
						else 
						{
							arrValues.add(correctNull(txt_amount1[i]));
						}
						if (correctNull(txt_yield[i]).equals(""))
						{
							arrValues.add("0");
						} 
						else 
						{
							arrValues.add(correctNull(txt_yield[i]));
						}
						if (correctNull(txt_produce[i]).equals(""))
						{
							arrValues.add("0.00");
						} 
						else
						{
							arrValues.add(correctNull(txt_produce[i]));
						}
						if (correctNull(txt_surplus[i]).equals("")) 
						{
							arrValues.add("0.00");
						} 
						else 
						{
							arrValues.add(correctNull(txt_surplus[i]));
						}
						if (correctNull(txt_repay[i]).equals("")) 
						{
							arrValues.add("0");
						} 
						else
						{
							arrValues.add(correctNull(txt_repay[i]));
						}						
						arrValues.add(correctNull(txt_crop[i]));
						arrValues.add(correctNull(txt_remarks[i]));	
						if (correctNull(txt_marginamount[i]).equals("")) 
						{
							arrValues.add("0");
						} 
						else
						{
							arrValues.add(correctNull(txt_marginamount[i]));
						}
						hshQuery.put("arrValues", arrValues);
						//f = f + 1;
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
					}
					hshQueryValues.put("1", hshQuery3);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				if(strAction.equals("delete"))
				{
					intUpdatesize = 1;

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_upd_assesment");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(appno);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
					
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			
			if(objSeqno instanceof String)
			{
				String seqno=(String) hshValues.get("hidseqno");
				String sno=(String)hshValues.get("hidsno");
				String croptype= (String)hshValues.get("hidcroptype");
				String txt_date = (String) hshValues.get("txt_date");
				String txt_area =(String)hshValues.get("txt_area");
				String txt_finance = (String) hshValues.get("txt_finance");
				String txt_eligibility = (String) hshValues.get("txt_eligibility");
				String txt_amount = (String) hshValues.get("txt_amount");
				String txt_amount1= (String) hshValues.get("txt_amount1");
				String txt_yield = (String) hshValues.get("txt_yield");
				String txt_produce = (String) hshValues.get("txt_produce");
				String txt_surplus = (String) hshValues.get("txt_surplus");
				String txt_repay = (String) hshValues.get("txt_repay");
				String txt_crop =(String)hshValues.get("txt_crop");
				String txt_remarks = (String) hshValues.get("txt_remarks");
				String txt_marginamount = (String) hshValues.get("txt_marginamount");
				
				
				if (strAction.equals("insert"))
				{
					HashMap hshQuery3 = new HashMap();
					ArrayList arrValues3 = new ArrayList();
					hshQuery3.put("size", "2");
					hshQuery3.put("strQueryId", "per_del_assesment");
					arrValues3.add(appno);
					hshQuery3.put("arrValues", arrValues3);
					
					intUpdatesize = 1;

					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_assesment");
					arrValues.add(correctNull(seqno));
					arrValues.add(appno);
					arrValues.add(correctNull(sno));
					arrValues.add(correctNull(croptype));
					if (correctNull(txt_date).equals(""))
					{
						arrValues.add("01/01/1900");
					} 
					else 
					{
						arrValues.add(correctNull(txt_date));
					}
					if (correctNull(txt_area).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area));
					}
					if (correctNull(txt_finance).equals(""))
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_finance));
					}
					if (correctNull(txt_eligibility).equals(""))
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_eligibility));
					}
					if (correctNull(txt_amount).equals("")) 
					{
						arrValues.add("0.00");
					}
					else 
					{
						arrValues.add(correctNull(txt_amount));
					}
					if (correctNull(txt_amount1).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_amount1));
					}
					if (correctNull(txt_yield).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_yield));
					}
					if (correctNull(txt_produce).equals(""))
					{
						arrValues.add("0.00");
					} 
					else
					{
						arrValues.add(correctNull(txt_produce));
					}
					if (correctNull(txt_surplus).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_surplus));
					}
					if (correctNull(txt_repay).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else
					{
						arrValues.add(correctNull(txt_repay));
					}						
					arrValues.add(correctNull(txt_crop));
					arrValues.add(correctNull(txt_remarks));
					if (correctNull(txt_marginamount).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else
					{
						arrValues.add(correctNull(txt_marginamount));
					}	
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
					
					hshQueryValues.put("1", hshQuery3);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				if(strAction.equals("delete"))
				{
					intUpdatesize = 1;

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_upd_assesment");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
					
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
			}
			
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}*/
			if(rs != null)
			{
				rs.close();
			}			
			hshpasValues.put("appno", appno);
			hshResult = getAssesmentData(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getConsumptionData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}

		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_consumption^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(correctNull(rs.getString("seqno")));
				arryCol.add(appno);
				arryCol.add(correctNull(rs.getString("sno")));
				arryCol.add(correctNull(rs.getString("limit_type")));
				arryCol.add(correctNull(rs.getString("limit_activity")));
				arryCol.add(correctNull(rs.getString("limit_unit")));
				arryCol.add(correctNull(rs.getString("limit_particular")));
				arryCol.add(correctNull(rs.getString("limit_requirement")));
				arryCol.add(correctNull(rs.getString("limit_value")));
				arryCol.add(correctNull(rs.getString("limit_remarks")));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
		} 		
		catch (Exception ce)
		{
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
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateConsumptionData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));

		try 
		{
			String[] stxt_activity = null;
			String[] txt_units = null;
			String[] stxt_particular = null;
			String[] txt_req = null;
			String[] txt_margin = null;
			String[] stxt_loan = null;
			stxt_activity = (String[]) hshValues.get("txt_activity");
			txt_units = (String[]) hshValues.get("txt_units");
			stxt_particular = (String[]) hshValues.get("txt_particular");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_req = (String[]) hshValues.get("txt_req");
			txt_margin = (String[]) hshValues.get("txt_margin");
			stxt_loan = (String[]) hshValues.get("txt_loan");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete")) 
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_consumption");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_consumption");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_consumption");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) 
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_margin.length; i++) 
				{				
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_consumption");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("c1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("c2");
					}
					if (i + 1 == 3)
					{
						arrValues.add("c3");
					}
					arrValues.add(stxt_activity[i]);
					if (correctNull(txt_units[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_units[i]));
					}
					arrValues.add(stxt_particular[i]);
					if (correctNull(txt_req[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_req[i]));
					}
					if (correctNull(txt_margin[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_margin[i]));
					}
					arrValues.add(correctNull(stxt_loan[i]));
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);				
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getConsumptionData(hshpasValues);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getLivestockData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_livestock_data^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs1.getString("stat_data_desc")));
				
				vecData.add(vecRec1);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_livestock^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("livestock_particular"));
				arryCol.add(rs.getString("livestock_fixedcost"));
				arryCol.add(rs.getString("livestock_capital"));
				arryCol.add(rs.getString("livestock_grossincome"));
				arryCol.add(rs.getString("livestock_expenses"));
				arryCol.add(rs.getString("livestock_netincome"));
				arryCol.add(rs.getString("poultry_particular"));
				arryCol.add(rs.getString("poultry_fixedcost"));
				arryCol.add(rs.getString("poultry_capital"));
				arryCol.add(rs.getString("poultry_grossincome"));
				arryCol.add(rs.getString("poultry_expenses"));
				arryCol.add(rs.getString("poultry_netincome"));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("vecData",vecData);
		} 
		catch (Exception ce) 
		{
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
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateLivestockData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));

		try 
		{
			String[] txt_particular = null;
			String[] txt_fixedcost = null;
			String[] txt_capital = null;
			String[] txt_grossincome = null;
			String[] txt_expenses = null;
			String[] txt_netincome = null;
			String[] txt_particular1 = null;
			String[] txt_fixedcost1 = null;
			String[] txt_capital1 = null;
			String[] txt_grossincome1 = null;
			String[] txt_expenses1 = null;
			String[] txt_netincome1 = null;
			txt_particular = (String[]) hshValues.get("txt_particular");
			txt_fixedcost = (String[]) hshValues.get("txt_fixedcost");
			txt_capital = (String[]) hshValues.get("txt_capital");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_grossincome = (String[]) hshValues.get("txt_grossincome");
			txt_expenses = (String[]) hshValues.get("txt_expenses");
			txt_netincome = (String[]) hshValues.get("txt_netincome");
			txt_particular1 = (String[]) hshValues.get("txt_particular1");
			txt_fixedcost1 = (String[]) hshValues.get("txt_fixedcost1");
			txt_capital1 = (String[]) hshValues.get("txt_capital1");
			txt_grossincome1 = (String[]) hshValues.get("txt_grossincome1");
			txt_expenses1 = (String[]) hshValues.get("txt_expenses1");
			txt_netincome1 = (String[]) hshValues.get("txt_netincome1");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_livestock");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_livestock");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_livestock");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;
				for (int i = 0; i < txt_fixedcost.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_livestock");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1)
					{
						arrValues.add("l1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("l2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("l3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("l4");
					}
					if (i + 1 == 5)
					{
						arrValues.add("l5");
					}
					arrValues.add(correctNull(txt_particular[i]));
					if(correctNull(txt_fixedcost[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_fixedcost[i]));
					}
					if (correctNull(txt_capital[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_capital[i]));
					}
					if (correctNull(txt_grossincome[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_grossincome[i]));
					}
					if (correctNull(txt_expenses[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_expenses[i]));
					}
					if (correctNull(txt_netincome[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_netincome[i]));
					}
					arrValues.add(correctNull(txt_particular1[i]));					
					if (correctNull(txt_fixedcost1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_fixedcost1[i]));
					}
					if (correctNull(txt_capital1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_capital1[i]));
					}
					if (correctNull(txt_grossincome1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_grossincome1[i]));
					}
					if (correctNull(txt_expenses1[i]).equals("")) 
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_expenses1[i]));
					}
					if (correctNull(txt_netincome1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_netincome1[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getLivestockData(hshpasValues);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getMachineryData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}

		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_machinery^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("mac_particular"));
				arryCol.add(rs.getString("mac_area"));
				arryCol.add(rs.getString("mac_estimate"));
				arryCol.add(rs.getString("mac_margin"));
				arryCol.add(rs.getString("mac_grossincome"));
				arryCol.add(rs.getString("mac_expenses"));
				arryCol.add(rs.getString("mac_netincome"));
				arryCol.add(rs.getString("house_particular"));
				arryCol.add(rs.getString("house_area"));
				arryCol.add(rs.getString("house_estimate"));
				arryCol.add(rs.getString("house_margin"));
				arryCol.add(rs.getString("house_grossincome"));
				arryCol.add(rs.getString("house_expenses"));
				arryCol.add(rs.getString("house_netincome"));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
		}
		catch (Exception ce) 
		{
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
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateMachineryData(HashMap hshValues) 
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));

		try 
		{
			String[] txt_particular = null;
			String[] txt_fixedcost = null;
			String[] txt_capital = null;
			String[] txt_margin = null;
			String[] txt_grossincome = null;
			String[] txt_expenses = null;
			String[] txt_netincome = null;
			String[] txt_particular1 = null;
			String[] txt_fixedcost1 = null;
			String[] txt_capital1 = null;
			String[] txt_margin1 = null;
			String[] txt_grossincome1 = null;
			String[] txt_expenses1 = null;
			String[] txt_netincome1 = null;
			txt_particular = (String[]) hshValues.get("txt_particular");
			txt_fixedcost = (String[]) hshValues.get("txt_fixedcost");
			txt_capital = (String[]) hshValues.get("txt_capital");
			txt_margin = (String[]) hshValues.get("txt_margin");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_grossincome = (String[]) hshValues.get("txt_grossincome");
			txt_expenses = (String[]) hshValues.get("txt_expenses");
			txt_netincome = (String[]) hshValues.get("txt_netincome");
			txt_particular1 = (String[]) hshValues.get("txt_particular1");
			txt_fixedcost1 = (String[]) hshValues.get("txt_fixedcost1");
			txt_capital1 = (String[]) hshValues.get("txt_capital1");
			txt_margin1 = (String[]) hshValues.get("txt_margin1");
			txt_grossincome1 = (String[]) hshValues.get("txt_grossincome1");
			txt_expenses1 = (String[]) hshValues.get("txt_expenses1");
			txt_netincome1 = (String[]) hshValues.get("txt_netincome1");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_machinery");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert")) 
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_machinery");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_machinery");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;
				for (int i = 0; i < txt_capital.length; i++) 
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_machinery");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1)
					{
						arrValues.add("l1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("l2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("l3");
					}
					if (i + 1 == 4)
					{
						arrValues.add("l4");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("l5");
					}
					arrValues.add(correctNull(txt_particular[i]));
					if (correctNull(txt_fixedcost[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_fixedcost[i]));
					}
					if (correctNull(txt_capital[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_capital[i]));
					}
					if (correctNull(txt_margin[i]).equals(""))
					{
						arrValues.add("");					
					}
					else 
					{
						arrValues.add(correctNull(txt_margin[i]));
					}
					if (correctNull(txt_grossincome[i]).equals("")) 
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_grossincome[i]));
					}
					if (correctNull(txt_expenses[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_expenses[i]));
					}
					if (correctNull(txt_netincome[i]).equals(""))
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_netincome[i]));
					}
					arrValues.add(correctNull(txt_particular1[i]));					
					if (correctNull(txt_fixedcost1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_fixedcost1[i]));
					}
					if (correctNull(txt_capital1[i]).equals(""))
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_capital1[i]));
					}
					if (correctNull(txt_margin1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_margin1[i]));
					}
					if (correctNull(txt_grossincome1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_grossincome1[i]));
					}
					if (correctNull(txt_expenses1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_expenses1[i]));
					}
					if (correctNull(txt_netincome1[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_netincome1[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getMachineryData(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getShagriData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList vecData = new ArrayList();
        ArrayList vecRec1 = new ArrayList();
        ArrayList vecData1 = new ArrayList();
        ArrayList vecRec2 = new ArrayList();
        ArrayList vecData2 = new ArrayList();
        ArrayList vecRec3 = new ArrayList();
        ArrayList vecData3 = new ArrayList();
        ArrayList vecRec4 = new ArrayList();
        ArrayList vecData4 = new ArrayList();
        ArrayList vecRec5 = new ArrayList();	      
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}

		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropname_kh^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs1.getString("crop_season")));
				vecRec1.add(correctNull(rs1.getString("crop_season1")));
				vecRec1.add(correctNull(rs1.getString("crop_total_area")));
				vecRec1.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec1.add(correctNull(rs1.getString("crop_irrigated")));
				vecRec1.add(correctNull(rs1.getString("crop_irrigated_amt")));
				vecRec1.add(correctNull(rs1.getString("crop_rainfed_amt")));
				vecData.add(vecRec1);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropname_rb^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData1 = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec2 = new ArrayList();
				vecRec2.add(correctNull(rs1.getString("crop_season")));
				vecRec2.add(correctNull(rs1.getString("crop_season1")));
				vecRec2.add(correctNull(rs1.getString("crop_total_area")));
				vecRec2.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec2.add(correctNull(rs1.getString("crop_irrigated")));
				vecRec2.add(correctNull(rs1.getString("crop_irrigated_amt")));
				vecRec2.add(correctNull(rs1.getString("crop_rainfed_amt")));
				vecData1.add(vecRec2);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			//int vecsize2= vecData1.size();
			strQuery = SQLParser.getSqlQuery("per_get_cropname_su^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData2 = new ArrayList();
				
			while (rs1.next()) 
			{
				vecRec3= new ArrayList();
				vecRec3.add(correctNull(rs1.getString("crop_season")));
				vecRec3.add(correctNull(rs1.getString("crop_season1")));
				vecRec3.add(correctNull(rs1.getString("crop_total_area")));
				vecRec3.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec3.add(correctNull(rs1.getString("crop_irrigated")));
				vecRec3.add(correctNull(rs1.getString("crop_irrigated_amt")));
				vecRec3.add(correctNull(rs1.getString("crop_rainfed_amt")));
				vecData2.add(vecRec3);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			//int vecsize3 = vecData2.size();
			strQuery = SQLParser.getSqlQuery("per_get_cropname_an^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData3 = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec4 = new ArrayList();
				vecRec4.add(correctNull(rs1.getString("crop_season")));
				vecRec4.add(correctNull(rs1.getString("crop_season1")));
				vecRec4.add(correctNull(rs1.getString("crop_total_area")));
				vecRec4.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec4.add(correctNull(rs1.getString("crop_irrigated")));
				vecRec4.add(correctNull(rs1.getString("crop_irrigated_amt")));
				vecRec4.add(correctNull(rs1.getString("crop_rainfed_amt")));
				vecData3.add(vecRec4);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropname_pe^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData4 = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec5 = new ArrayList();
				vecRec5.add(correctNull(rs1.getString("crop_season")));
				vecRec5.add(correctNull(rs1.getString("crop_season1")));
				vecRec5.add(correctNull(rs1.getString("crop_total_area")));
				vecRec5.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec5.add(correctNull(rs1.getString("crop_irrigated")));
				vecRec5.add(correctNull(rs1.getString("crop_irrigated_amt")));
				vecRec5.add(correctNull(rs1.getString("crop_rainfed_amt")));
				vecData4.add(vecRec5);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_shagriloan^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("crop_name"));
				arryCol.add(rs.getString("acr_irrigated"));
				arryCol.add(rs.getString("acr_rainfed"));
				arryCol.add(rs.getString("req_irrigated"));
				arryCol.add(rs.getString("req_rainfed"));
				arryCol.add(rs.getString("total_req"));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("vecData",vecData);
			hshRecord.put("vecData1",vecData1);
			hshRecord.put("vecData2",vecData2);
			hshRecord.put("vecData3",vecData3);
			hshRecord.put("vecData4",vecData4);			
		} 
		catch (Exception ce)
		{
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
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateShagriData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));

		try
		{			
			String[] txt_crop = null;
			String[] txt_iarea = null;
			String[] txt_rarea = null;
			String[] txt_iarea1 = null;
			String[] txt_rarea1 = null;
			String[] txt_req = null;
			txt_crop = (String[]) hshValues.get("txt_crop");
			txt_iarea = (String[]) hshValues.get("txt_iarea");
			txt_rarea = (String[]) hshValues.get("txt_rarea");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_iarea1 = (String[]) hshValues.get("txt_iarea1");
			txt_rarea1 = (String[]) hshValues.get("txt_rarea1");
			txt_req = (String[]) hshValues.get("txt_req");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete")) 
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_shagriloan");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_shagriloan");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_shagriloan");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) 
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}	
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;
				for (int i = 0; i < txt_iarea.length; i++) 
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_shagriloan");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("w1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("w2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("w3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("w4");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("w5");
					}
					if (i + 1 == 6) 
					{
						arrValues.add("w6");
					}
					if (i + 1 == 7) 
					{
						arrValues.add("w7");
					}
					if (i + 1 == 8) 
					{
						arrValues.add("w8");
					}
					if (i + 1 == 9) 
					{
						arrValues.add("w9");
					}
					if (i + 1 == 10)
					{
						arrValues.add("w10");
					}
					if (i + 1 == 11)
					{
						arrValues.add("w11");
					}
					if (i + 1 == 12)
					{
						arrValues.add("w12");
					}
					if (i + 1 == 13)
					{
						arrValues.add("w13");
					}
					if (i + 1 == 14) 
					{
						arrValues.add("w14");
					}
					if (i + 1 == 15) 
					{
						arrValues.add("w15");
					}
					if (i + 1 == 16) 
					{
						arrValues.add("w16");
					}
					if (i + 1 == 17) 
					{
						arrValues.add("w17");
					}
					if (i + 1 == 18)
					{
						arrValues.add("w18");
					}
					if (i + 1 == 19) 
					{
						arrValues.add("w19");
					}					
					arrValues.add(correctNull(txt_crop[i]));					
					if (correctNull(txt_iarea[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_iarea[i]));
					}
					if (correctNull(txt_rarea[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_rarea[i]));
					}
					if (correctNull(txt_iarea1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_iarea1[i]));
					}
					if (correctNull(txt_rarea1[i]).equals(""))
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_rarea1[i]));
					}
					if (correctNull(txt_req[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_req[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);		     
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getShagriData(hshpasValues);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getBoatNetData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String slno = "";
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();
		try 
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			String PageType = correctNull((String) hshValues.get("hidpagetype"));
			strQuery = SQLParser.getSqlQuery("agrboatnetselect^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("agr_pagetype")));
				vecVal.add(correctNull(rs.getString("agr_slno")));
				vecVal.add(correctNull(rs.getString("agr_boatnet")));
				vecVal.add(correctNull(rs.getString("agr_category")));
				vecVal.add(correctNull(rs.getString("agr_length")));
				vecVal.add(correctNull(rs.getString("agr_breadth")));
				vecVal.add(correctNull(rs.getString("agr_weight")));
				vecVal.add(correctNull(rs.getString("agr_cost")));
				vecVal.add(correctNull(rs.getString("agr_constructionused")));
				vecVal.add(correctNull(rs.getString("agr_supplier")));
				vecData.add(vecVal);
			}
			hshRecord.put("vecData", vecData);
			if (rs != null)
				rs.close();
			if (strAction.equals("update")) 
			{
				slno = correctNull((String) hshValues.get("hidslno"));
			} 
			else if (strAction.equals("insert")) 
			{
				strQuery = SQLParser.getSqlQuery("agrsel_max_agr_boat^" + appno + "^" + PageType);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					slno = rs.getString("maxid");
				}
				if (rs != null)
					rs.close();
			}
			if (!slno.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("agrboatnetselect1^" + appno+ '^' + PageType + '^' + slno);				
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					hshRecord.put("agr_slno", correctNull(rs.getString("agr_slno")));
					hshRecord.put("agr_boatnet", correctNull(rs.getString("agr_boatnet")));
					hshRecord.put("agr_category", correctNull(rs.getString("agr_category")));
					hshRecord.put("agr_length", correctNull(rs.getString("agr_length")));
					hshRecord.put("agr_breadth", correctNull(rs.getString("agr_breadth")));
					hshRecord.put("agr_weight", correctNull(rs.getString("agr_weight")));
					hshRecord.put("agr_cost", correctNull(rs.getString("agr_cost")));
					hshRecord.put("agr_constructionused", correctNull(rs.getString("agr_constructionused")));
					hshRecord.put("agr_supplier", correctNull(rs.getString("agr_supplier")));
				}
				if(rs != null)
				{
					rs.close();
				}
			}
			hshRecord.put("PageType", PageType);
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getBoatNetData " + ce.toString());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateBoatNetData(HashMap hshValues)  
	{
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String agrslno="";
			
		try 
		{
			ArrayList arrValues = new ArrayList();
			agrslno = correctNull((String) hshValues.get("hidslno"));
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			String agrPageType = correctNull((String) hshValues.get("hidpagetype"));
			String agrBoatNet = correctNull((String) hshValues.get("sel_boatnet"));
			String agrCategory = correctNull((String) hshValues.get("sel_category"));
			String agrLength = correctNull((String) hshValues.get("txt_length"));
			String agrBreadth = correctNull((String) hshValues.get("txt_breadth"));
			String agrWeight = correctNull((String) hshValues.get("txt_weight"));
			String agrCost = correctNull((String) hshValues.get("txt_cost"));
			String agrSupplier = correctNull((String) hshValues.get("txt_supplier"));
			String agrBoatTimber = correctNull((String) hshValues.get("txt_boattimber"));
			String agrNetTwine = correctNull((String) hshValues.get("sel_nettwinetype"));
			String agrConstruction = "";
			if (agrBoatNet.trim().equalsIgnoreCase("b")) 
			{
				agrConstruction = agrBoatTimber;
			} 
			else if (agrBoatNet.trim().equalsIgnoreCase("n"))
			{
				agrConstruction = agrNetTwine;
			}
			if (strAction.trim().equalsIgnoreCase("update"))
			{
				agrslno = correctNull((String) hshValues.get("hidslno"));
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrboatnetupdate");
				arrValues.add(agrBoatNet);
				arrValues.add(agrCategory);
				if(agrLength.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrLength);
				}
				if(agrBreadth.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrBreadth);
				}
				if(agrWeight.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrWeight);
				}
				if(agrCost.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrCost);
				}
				arrValues.add(agrConstruction);
				arrValues.add(agrSupplier);
				arrValues.add(appno);
				arrValues.add(agrPageType);
				arrValues.add(agrslno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.trim().equals("insert")) 
			{
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrboatnetinsert");
				agrslno = Integer.toString(getMaxGradeId(appno));
				arrValues.add(appno);
				arrValues.add(agrPageType);
				arrValues.add(agrBoatNet);
				arrValues.add(agrCategory);
				if(agrLength.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrLength);
				}
				if(agrBreadth.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrBreadth);
				}
				if(agrWeight.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrWeight);
				}
				if(agrCost.equalsIgnoreCase(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(agrCost);
				}				
				arrValues.add(agrConstruction);
				arrValues.add(agrSupplier);
				arrValues.add(agrslno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.equals("delete"))
			{
				agrslno = correctNull((String) hshValues.get("hidslno"));
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrboatnetdelete");
				arrValues.add(appno);
				arrValues.add(agrPageType);
				arrValues.add(agrslno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshRecord.put("PageType", agrPageType);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getBoatNetData " + ce.toString());
		}
	}

	public HashMap getDataLiveStock(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		String strQuery = "";
		String strappno = "";
		String strbatchpurchased="";
		//double totalvalue = 0.00;
		//double totalanimal = 0.00;
		//double totalnoofanimal = 0.00;
		//double totalcost = 0.00;
		try 
		{			
			strappno = correctNull((String) hshValues.get("strappno"));
			if(strappno.equalsIgnoreCase("null") || strappno.equalsIgnoreCase(""))
			{
				strappno = correctNull((String)hshValues.get("appno"));
			}	
			
			strQuery = SQLParser.getSqlQuery("agrsel_livestock^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
		
			while (rs.next()) 
			{
				arrData = new ArrayList();
				arrData.add(correctNull(rs.getString("agr_appno")));
				arrData.add(correctNull(rs.getString("agr_livestockslno")));
				arrData.add(correctNull(rs.getString("agr_detlivestock")));
				if(correctNull(rs.getString("agr_present_breed")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_present_breed")));
				if(correctNull(rs.getString("agr_present_age")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_present_age")));
				if(correctNull(rs.getString("agr_present_no")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_present_no")));
				if(correctNull(rs.getString("agr_present_value")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_present_value")));
				
				if(correctNull(rs.getString("agr_proposed_breed")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_proposed_breed")));
				if(correctNull(rs.getString("agr_proposed_age")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_proposed_age")));
				if(correctNull(rs.getString("agr_proposed_no")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_proposed_no")));
				arrRow.add(arrData);
				hshRecord.put("auditFlag", "Y");
			}
			
			hshRecord.put("arrlivestock",arrRow);
			arrRow = new ArrayList();
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
		
			while (rs.next()) 
			{	
				arrData = new ArrayList();
				arrData.add(correctNull(rs.getString("agr_milchcattle")));
				if(correctNull(rs.getString("agr_avg_milk")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_avg_milk")));
				if(correctNull(rs.getString("agr_noanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_noanimals")));
				if(correctNull(rs.getString("agr_costanimals")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_costanimals")));
				if(correctNull(rs.getString("agr_totalcost")).equalsIgnoreCase("0"))
					arrData.add("");
				else
					arrData.add(correctNull(rs.getString("agr_totalcost")));
				arrData.add(correctNull(rs.getString("agr_batch")));
				
				strbatchpurchased=correctNull(rs.getString("agr_batch_purchased"));
				
				arrRow.add(arrData);
				hshRecord.put("auditFlag", "Y");
			}
			
			hshRecord.put("batchpurchased",strbatchpurchased);
			hshRecord.put("arrstockdetails", arrRow);
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("strappno", strappno);		
		}
		catch (Exception e) 
		{
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateLiveStock(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = "";
		String appno = "";
		String strpresent_breed[] =null;
		String strlivestock[] = null;
		String strPresentAge[] = null;
		String strPresentNo[] = null;
		String strPresentValue[] = null;
		String strProposedBreed[] = null;
		String strProposedAge[] = null;
		String strProposedNo[] = null;
		String strsellease[] = null;
		String stravgmilk[] = null;
		String stranimals[] = null;
		String strcostperanimal[] = null;
		String strtotalcost[] = null;
		String strDesc[]={"I Batch","II Batch"};
		strlivestock = (String[]) hshValues.get("txt_livestock");
		strpresent_breed = (String[]) hshValues.get("txt_present_breed");
		strPresentAge = (String[]) hshValues.get("txt_present_age");
		strPresentNo = (String[]) hshValues.get("txt_present_no");
		strPresentValue = (String[]) hshValues.get("txt_present_value");
		strProposedBreed = (String[]) hshValues.get("txt_proposed_breed");
		strProposedAge = (String[]) hshValues.get("txt_proposed_age");
		strProposedNo = (String[]) hshValues.get("txt_proposed_no");
		strsellease = (String[]) hshValues.get("sellease");
		stravgmilk = (String[]) hshValues.get("txt_avgmilk");
		stranimals = (String[]) hshValues.get("txt_noofanimals");
		strcostperanimal = (String[]) hshValues.get("txt_costperanimal");
		strtotalcost = (String[]) hshValues.get("txt_totalcost");
		
		try 
		{
			strAction = correctNull((String)hshValues.get("hidAction"));
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			if (strAction.trim().equalsIgnoreCase("update")) 
			{	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				hshQuery.put("strQueryId", "agr_livestockdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				
				hshQuery.put("strQueryId", "agr_delstockdetails");
				arrValues.add(appno);	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for (int j = 0; j < strpresent_breed.length; j++) 
				{
					hshQueryValues.put("size", "1");
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_livestockinsert");
					arrValues.add(appno);					
					arrValues.add(strlivestock[j]);
					if (correctNull(strpresent_breed[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strpresent_breed[j]);							
					}
					if (correctNull(strPresentAge[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strPresentAge[j]);							
					}
					if (correctNull(strPresentNo[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strPresentNo[j]);
					}
					if (correctNull(strPresentValue[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strPresentValue[j]);
					}
					if (correctNull(strProposedBreed[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strProposedBreed[j]);
					}
					if (correctNull(strProposedAge[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strProposedAge[j]);
					}						
					if (correctNull(strProposedNo[j]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(strProposedNo[j]);
					}
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				for(int i=0; i<strsellease.length; i++)
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "agr_insstockdetails");
					arrValues.add(appno);					
					if(strsellease[i].equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(strsellease[i]);
					}
					if(stravgmilk[i].equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(stravgmilk[i]);
					}
					if(stranimals[i].equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(stranimals[i]);
					}
					if(strcostperanimal[i].equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(strcostperanimal[i]);
					}
					if(strtotalcost[i].equalsIgnoreCase(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(strtotalcost[i]);
					}
					if(i == 0)
					{
						arrValues.add("I");
					}
					else
					{
						arrValues.add("II");
					}
					arrValues.add(correctNull((String)hshValues.get("selbatch")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
				}
				if(correctNull((String)hshValues.get("hid_selbatch")).equalsIgnoreCase("Y"))
				{
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","LDdatadel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
				}
			} 
			else if (strAction.equals("delete"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agr_livestockdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agr_delstockdetails");
				arrValues.add(appno);	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			for(int j=0;j<strpresent_breed.length;j++)
			{
				sbAuditTrial.append("~Details of LiveStock = ").append(correctNull(strlivestock[j]))
				.append("~Presently Owned Breed = ").append(correctNull(strpresent_breed[j]))
				.append("~Presently Owned Age = ").append(correctNull(strPresentAge[j]))
				.append("~Presently Owned Number = ").append(correctNull(strPresentNo[j]))
				.append("~Presently Owned Value in Rs. = ").append(correctNull(strPresentValue[j]))
				.append("~Proposed to be Purchased Breed = ").append(correctNull(strProposedBreed[j]))
				.append("~Proposed to be Purchased Age = ").append(correctNull(strProposedAge[j]))
				.append("~Proposed to be Purchased Lactation No  = ").append(correctNull(strProposedNo[j]));
			}
			
			for(int i=0; i<strsellease.length; i++)
			{
				sbAuditTrial
				.append("~Stages of Particulars = ").append(strDesc[i])
				.append("~Milch Cattle  = ").append(ApplicantParams.getApplicantParams("LiveStock",(correctNull(strsellease[i]))))
				.append("~Average Milk yield / Day / Animal = ").append(correctNull(stravgmilk[i]))
				.append("~No of Animals = ").append(correctNull(stranimals[i]))
				.append("~Cost Per Animal in Rs. = ").append(correctNull(strcostperanimal[i]))
				.append("~Total Cost in Rs. = ").append(correctNull(strtotalcost[i]));
			}
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"238",appno,sbAuditTrial.toString());
			
			
			//this will help apply data in income & expenses page and cattle chart
			UpdateDairyData updateDairyData = new UpdateDairyData();
			updateDairyData.updateCattleChartData(hshValues);
			hshValues.put("strCheck","yes");
			updateDairyData.updateDataForDairy(hshValues);
			
			
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getBoatNetData " + ce.toString());
		}
	}

	public HashMap getEconomicsDetails(HashMap hshValues)  
	{
		String strQuery = "";
		String strAction = "";
		long netIncome = 0;
		long totalNetIncome = 0;
		String strNetIncome = "";
		String strTotalNetIncome = "";	
		String stryieldVlaue = "";
		String strcultExpense = "";
		String strOtherNetIncome = "";
		ArrayList vecVal = new ArrayList();
		ArrayList vecData = new ArrayList();
		long vecsize = 0;
		ResultSet rs = null;
		String appno = "";
		String slno = "";
		HashMap hshRecord = new HashMap();
		ArrayList NetIncome = new ArrayList();
		ArrayList TotalNetIncome = new ArrayList();
		try 
		{
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strAction = correctNull((String)hshValues.get("hidAction"));
			strQuery = SQLParser.getSqlQuery("agreconomicsselect^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("agr_slno")));
				vecVal.add(correctNull(rs.getString("agr_year")));
				vecVal.add(correctNull(rs.getString("agr_area")));
				vecVal.add(correctNull(rs.getString("agr_arabicayield")));
				vecVal.add(correctNull(rs.getString("agr_robustayield")));
				vecVal.add(correctNull(rs.getString("agr_yieldvalue")));
				vecVal.add(correctNull(rs.getString("agr_cultivationexpense")));
				vecVal.add(correctNull(rs.getString("agr_othernetincome")));
				vecVal.add(correctNull(rs.getString("agr_croploaninterest")));
				vecVal.add(correctNull(rs.getString("agr_existingloaninterest")));
				vecVal.add(correctNull(rs.getString("agr_proposedloaninterest")));
				vecVal.add(correctNull(rs.getString("agr_tax")));
				vecVal.add(correctNull(rs.getString("agr_existingloanrepayment")));
				vecVal.add(correctNull(rs.getString("agr_proposedloanrepayment")));
				vecData.add(vecVal);
			}
			
			hshRecord.put("vecData", vecData);
			vecsize = vecData.size();
			for (int i = 0; i < vecsize; i++)
			{
				vecVal = new ArrayList();
				vecVal = (ArrayList) vecData.get(i);
				stryieldVlaue = (String) vecVal.get(5);
				strcultExpense = (String) vecVal.get(6);
				strOtherNetIncome = (String) vecVal.get(7);
				netIncome = Long.parseLong(stryieldVlaue) - Long.parseLong(strcultExpense);
				strNetIncome = Long.toString(netIncome);
				NetIncome.add(strNetIncome);
				totalNetIncome = netIncome + Long.parseLong(strOtherNetIncome);
				strTotalNetIncome = Long.toString(totalNetIncome);
				TotalNetIncome.add(strTotalNetIncome);
			}
			hshRecord.put("NetIncome", NetIncome);
			hshRecord.put("TotalNetIncome", TotalNetIncome);
			if (rs != null)
				rs.close();
			if (strAction.equals("update"))
			{
				slno = correctNull((String) hshValues.get("hidslno"));
			}
			else if (strAction.equals("insert"))
			{
				strQuery = SQLParser.getSqlQuery("agrsel_max_agreconomics");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					slno = rs.getString(1);
				}
				if (rs != null)
					rs.close();
			}
			if (!slno.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("agreconomicsselect1^" + appno+ '^' + slno);
				
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					hshRecord.put("agr_slno", correctNull(rs.getString("agr_slno")));
					hshRecord.put("agr_year", correctNull(rs.getString("agr_year")));
					hshRecord.put("agr_area", correctNull(rs.getString("agr_area")));
					hshRecord.put("agr_arabicayield", correctNull(rs.getString("agr_arabicayield")));
					hshRecord.put("agr_robustayield", correctNull(rs.getString("agr_robustayield")));
					hshRecord.put("agr_yieldvalue", correctNull(rs.getString("agr_yieldvalue")));
					hshRecord.put("agr_cultivationexpense",correctNull(rs.getString("agr_cultivationexpense")));
					hshRecord.put("agr_othernetincome", correctNull(rs.getString("agr_othernetincome")));
					hshRecord.put("agr_croploaninterest", correctNull(rs.getString("agr_croploaninterest")));
					hshRecord.put("agr_existingloaninterest", correctNull(rs.getString("agr_existingloaninterest")));
					hshRecord.put("agr_proposedloaninterest", correctNull(rs.getString("agr_proposedloaninterest")));
					hshRecord.put("agr_tax", correctNull(rs.getString("agr_tax")));
					hshRecord.put("agr_existingloanrepayment", correctNull(rs.getString("agr_existingloanrepayment")));
					hshRecord.put("agr_proposedloanrepayment", correctNull(rs.getString("agr_proposedloanrepayment")));
				}
				if(rs != null)
				{
					rs.close();
				}
			}
		}
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateEconomicsDetails(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = "";
		String appno = "";
		String slno = "";
		long lngSlNo = 0;
		String strYear = "";
		String strArea = "";
		String strArabica = "";
		String strRobusta = "";
		String strYieldValue = "";
		String strCultivationExpense = "";
		String strOtherNetIncome = "";
		String strCropInterest = "";
		String strExistingInterest = "";
		String strProposedInterest = "";
		String strTaxes = "";
		String strExistingInstalment = "";
		String strProposedRepayment = "";
		try 
		{
			strAction = correctNull((String)hshValues.get("hidAction"));
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strYear = correctNull((String) hshValues.get("txt_year"));
			strArea = correctNull((String) hshValues.get("txt_area"));
			strArabica = correctNull((String) hshValues.get("txt_arabica"));
			strRobusta = correctNull((String) hshValues.get("txt_robusta"));
			strYieldValue = correctNull((String) hshValues.get("txt_yield"));
			strCultivationExpense = correctNull((String) hshValues.get("txt_cultivationexpense"));
			strOtherNetIncome = correctNull((String) hshValues.get("txt_othernetincome"));
			strCropInterest = correctNull((String) hshValues.get("txt_cropinterest"));
			strExistingInterest = correctNull((String) hshValues.get("txt_existinginterest"));
			strProposedInterest = correctNull((String) hshValues.get("txt_proposedinterest"));
			strTaxes = correctNull((String) hshValues.get("txt_taxes"));
			strExistingInstalment = correctNull((String) hshValues.get("txt_existinginstalment"));
			strProposedRepayment = correctNull((String) hshValues.get("txt_proposedrepayment"));

			if (strAction.trim().equalsIgnoreCase("update")) 
			{
				slno = correctNull((String) hshValues.get("hidslno"));
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agreconomicsupdate");
				arrValues.add(strYear);
				arrValues.add(strArea);
				arrValues.add(strArabica);
				arrValues.add(strRobusta);
				arrValues.add(strYieldValue);
				arrValues.add(strCultivationExpense);
				arrValues.add(strOtherNetIncome);
				arrValues.add(strCropInterest);
				arrValues.add(strExistingInterest);
				arrValues.add(strProposedInterest);
				arrValues.add(strTaxes);
				arrValues.add(strExistingInstalment);
				arrValues.add(strProposedRepayment);
				arrValues.add(appno);
				arrValues.add(slno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.trim().equals("insert")) 
			{
				strQuery = SQLParser.getSqlQuery("agrsel_max_agreconomics");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					lngSlNo = Long.parseLong(rs.getString(1)) + 1;
				}
				if(rs != null)
				{
					rs.close();
				}
				slno = Long.toString(lngSlNo);
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agreconomicsinsert");
				arrValues.add(appno);
				arrValues.add(slno);
				arrValues.add(strYear);
				arrValues.add(strArea);
				arrValues.add(strArabica);
				arrValues.add(strRobusta);
				arrValues.add(strYieldValue);
				arrValues.add(strCultivationExpense);
				arrValues.add(strOtherNetIncome);
				arrValues.add(strCropInterest);
				arrValues.add(strExistingInterest);
				arrValues.add(strProposedInterest);
				arrValues.add(strTaxes);
				arrValues.add(strExistingInstalment);
				arrValues.add(strProposedRepayment);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.equals("delete"))
			{
				slno = correctNull((String) hshValues.get("hidslno"));
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agreconomicsdelete");
				arrValues.add(appno);
				arrValues.add(slno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in updateEconomicsDetails "+ ce.toString());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
	}

	public HashMap getFinancemasterData(HashMap hshValues) 
	{
		String strQuery = "";
		String strCropName="";
		String strSeasonName=""; 
		String strSeasonType="";
		String strCropType=""; 
		String strAppNo="";
		String strValuesin="";
		String strAmt="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList vecCol1 = new ArrayList();
		ArrayList vecRow1 = new ArrayList();
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strScaleoffin="";
		try 
		{
		
			 strAppNo=correctNull((String)hshValues.get("strappno"));
			if(strAppNo.equalsIgnoreCase("null") || strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String)hshValues.get("appno"));
			}
			String strStatId = correctNull((String) hshValues.get("sel_state"));
			if (strStatId.trim().equalsIgnoreCase("")) 
			{
				strStatId = "0";
			}
			String hidslno = correctNull((String) hshValues.get("sel_district"));
			String strAssessment = correctNull((String) hshValues.get("strAssessment"));
			if (hidslno.trim().equalsIgnoreCase("")) 
			{
				hidslno = "0";
			}		
			if(!strAppNo.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("getagrvaluesin^"+strAppNo);
				if(rs.next())
				{
					strValuesin=Helper.correctNull((String)rs.getString("app_valuesin"));
				}
			}
			{
				if(strAssessment.equalsIgnoreCase("130"))
					rs2 = DBUtils.executeLAPSQuery("sel_financemaster^" + strStatId+ "^" + hidslno+"^"+strAssessment);
				else
					rs2 = DBUtils.executeLAPSQuery("select_financemaster^" + strAssessment);
				while (rs2.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs2.getString("agr_sof_state")));//0
					String statecode = correctNull(rs2.getString("agr_sof_state"));
					String statename = "";
					if (!statecode.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selstatecode^"+ statecode);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next())
						{
							statename = correctNull((String) rs1.getString("state_name"));
						}
					}
					if (rs1 != null)
						rs1.close();
					vecVal.add(correctNull(rs2.getString("agr_sof_district")));//1
					String districtcode = correctNull(rs2.getString("agr_sof_district"));
					String districtname = "";
					if (!statecode.equalsIgnoreCase("")&& !districtcode.equalsIgnoreCase("")) 
					{
						strQuery = SQLParser.getSqlQuery("sel_district_name^"+ statecode + "^" + districtcode);
						rs3 = DBUtils.executeQuery(strQuery);
						if (rs3.next()) 
						{
							districtname = correctNull((String) rs3.getString("district_desc"));
						}
						if(rs3 != null)
						{
							rs1.close();
						}
					}
					strCropType=correctNull(rs2.getString("agr_sof_crop"));
					vecVal.add(correctNull(rs2.getString("agr_sof_crop")));//2
					   strAmt=Helper.correctDouble((String)rs2.getString("agr_sof_amount"));
					   strAmt=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble(Helper.correctDouble(strAmt)));
					   strAmt=jtn.format(Double.parseDouble(Helper.correctDouble(strAmt)));
					   vecVal.add(strAmt);//3
					vecVal.add(correctNull(rs2.getString("agr_sof_sno"))); //4
					vecVal.add(districtname);//5
					vecVal.add(statename);//6
					vecVal.add(correctNull(rs2.getString("agr_sof_type")));//7
					vecVal.add(correctNull(rs2.getString("agr_sof_fromdate")));//8
					vecVal.add(correctNull(rs2.getString("agr_sof_todate")));//9		
					strSeasonType=correctNull(rs2.getString("agr_sof_type"));
					if(!strSeasonType.equalsIgnoreCase(""))
					{
						if(rs3 !=null)
						{
							rs3.close();
						}
						rs3=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+"131"+"^"+strSeasonType);
						if(rs3.next())
						{
							strSeasonName=Helper.correctNull((String)rs3.getString("stat_data_desc1"));
						}
					}
					vecVal.add(strSeasonName);//10
					strSeasonName="";
					String strSDDesc="",strSDDescValue="";
					if(rs3 !=null)
					{
						rs3.close();
					}
					rs3=DBUtils.executeLAPSQuery("getstaticdatavaldispcorporate^"+strAssessment+"^"+strCropType);
					if(rs3.next())
					{
						strCropName =Helper.correctNull((String)rs3.getString("stat_data_desc1"));
						strSDDesc =Helper.correctNull((String)rs3.getString("stat_data_value"));
						strSDDescValue =Helper.correctNull((String)rs3.getString("stat_data_valuedesc"));
					}
					vecVal.add(strCropName);//11
					
							
					   strScaleoffin=Helper.correctNull((String)rs2.getString("agr_sof_sofperplant"));
					   strScaleoffin=Helper.convertSetupToApplicationValues(strValuesin, Double.parseDouble(Helper.correctDouble(strScaleoffin)));
					   strScaleoffin=jtn.format(Double.parseDouble(Helper.correctDouble(strScaleoffin)));
					   vecVal.add(strScaleoffin);//12
					   vecVal.add(strSDDesc);//13
						vecVal.add(strSDDescValue);//14
						vecRow.add(vecVal);
				}
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("dblScaleoffin", strScaleoffin);
			if(rs2!=null)
				rs2.close();
			rs1 = DBUtils.executeLAPSQuery("sel_district_master^"+strStatId);		
			while(rs1.next())
			{
				vecCol1 = new ArrayList();
				vecCol1.add(correctNull(rs1.getString(1)));
				String statename = "";
				if(!strStatId.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_state_name1^"+strStatId);
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						statename = correctNull((String)rs2.getString("stat_data_desc"));
					}
				}
				if(rs2!=null)
					rs2.close();
				vecCol1.add(correctNull(rs1.getString(2)));
				vecCol1.add(correctNull(rs1.getString("district_desc")));
				vecCol1.add(statename);
				vecRow1.add(vecCol1);							
			}	
			if(rs1 != null)
			{
				rs1.close();
			}
			
			hshRecord.put("vecRow1",vecRow1);
			hshRecord.put("strStatId",strStatId);
			hshRecord.put("hidslno",hidslno);
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
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
				if (rs3 != null) 
				{
					rs3.close();
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap getInspectedEstateData(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_inspectedestate^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("lp_name"));
				arryCol.add(rs.getString("lp_age"));
				arryCol.add(rs.getString("lp_area"));
				arryCol.add(rs.getString("lp_rate"));
				arryCol.add(rs.getString("lp_value"));
				arryCol.add(rs.getString("bc_name"));
				arryCol.add(rs.getString("bc_meas"));
				arryCol.add(rs.getString("bc_unit"));
				arryCol.add(rs.getString("bc_rate"));
				arryCol.add(rs.getString("bc_value"));
				arryCol.add(rs.getString("pm_name"));
				arryCol.add(rs.getString("pm_year"));
				arryCol.add(rs.getString("pm_unit"));
				arryCol.add(rs.getString("pm_cost"));
				arryCol.add(rs.getString("pm_value"));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
		}
		catch (Exception ce) 
		{
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
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateInspectedEstateData(HashMap hshValues)	
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			String[] txt_crop = null;
			String[] txt_group = null;
			String[] txt_area = null;
			String[] txt_amount = null;
			String[] txt_value = null;
			String[] txt_crop1 = null;
			String[] txt_group1 = null;
			String[] txt_area1 = null;
			String[] txt_amount1 = null;
			String[] txt_value1 = null;
			String[] txt_crop2 = null;
			String[] txt_group2 = null;
			String[] txt_area2 = null;
			String[] txt_amount2 = null;
			String[] txt_value2 = null;
			txt_crop = (String[]) hshValues.get("txt_crop");
			txt_group = (String[]) hshValues.get("txt_group");
			txt_area = (String[]) hshValues.get("txt_area");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_value = (String[]) hshValues.get("txt_value");
			txt_crop1 = (String[]) hshValues.get("txt_crop1");
			txt_group1 = (String[]) hshValues.get("txt_group1");
			txt_area1 = (String[]) hshValues.get("txt_area1");
			txt_amount1 = (String[]) hshValues.get("txt_amount1");
			txt_value1 = (String[]) hshValues.get("txt_value1");
			txt_crop2 = (String[]) hshValues.get("txt_crop2");
			txt_group2 = (String[]) hshValues.get("txt_group2");
			txt_area2 = (String[]) hshValues.get("txt_area2");
			txt_amount2 = (String[]) hshValues.get("txt_amount2");
			txt_value2 = (String[]) hshValues.get("txt_value2");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete")) 
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_inspectedestate");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert")) 
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_inspectedestate");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_inspectedestate");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_amount.length; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_inspectedestate");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1)
					{
						arrValues.add("w1");
					}
					if (i + 1 == 2)
					{
						arrValues.add("w2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("w3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("w4");
					}
					if (i + 1 == 5)
					{
						arrValues.add("w5");
					}
					if (i + 1 == 6) 
					{
						arrValues.add("w6");
					}
					if (i + 1 == 7) 
					{
						arrValues.add("w7");
					}
					if (i + 1 == 8) 
					{
						arrValues.add("w8");
					}
					arrValues.add(correctNull(txt_crop[i]));
					if (correctNull(txt_group[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_group[i]));
					}
					if (correctNull(txt_area[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area[i]));
					}
					if (correctNull(txt_amount[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					if (correctNull(txt_value[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_value[i]));
					}
					arrValues.add(correctNull(txt_crop1[i]));
					if (correctNull(txt_group1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_group1[i]));
					}
					if (correctNull(txt_area1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area1[i]));
					}
					if (correctNull(txt_amount1[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount1[i]));
					}
					if (correctNull(txt_value1[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_value1[i]));
					}
					arrValues.add(correctNull(txt_crop2[i]));
					if (correctNull(txt_group2[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_group2[i]));
					}
					if (correctNull(txt_area2[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area2[i]));
					}
					if (correctNull(txt_amount2[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount2[i]));
					}
					if (correctNull(txt_value2[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_value2[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getInspectedEstateData(hshpasValues);
			hshResult.put("PageType",PageType);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			}
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getYearCostData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_yearcostdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("item"));
				arryCol.add(rs.getString("cost1"));
				arryCol.add(rs.getString("loan1"));
				arryCol.add(rs.getString("cost2"));
				arryCol.add(rs.getString("loan2"));
				arryCol.add(rs.getString("cost3"));
				arryCol.add(rs.getString("loan3"));
				arryCol.add(rs.getString("cost4"));
				arryCol.add(rs.getString("loan4"));
				arryCol.add(rs.getString("cost5"));
				arryCol.add(rs.getString("loan5"));
				arryCol.add(rs.getString("cost6"));
				arryCol.add(rs.getString("loan6"));
				arryCol.add(rs.getString("cost7"));
				arryCol.add(rs.getString("loan7"));	
				arryCol.add(rs.getString("totalcost1"));
				arryCol.add(rs.getString("totalloan1"));	
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
		} 
		catch (Exception ce)
		{
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
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateYearCostData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String PageType=correctNull((String)hshValues.get("hidpagetype"));
		
		try
		{
			String[] txt_item = null;
			String[] txt_cost1 = null;
			String[] txt_loan1 = null;
			String[] txt_cost2 = null;
			String[] txt_loan2 = null;
			String[] txt_cost3 = null;
			String[] txt_loan3 = null;
			String[] txt_cost4 = null;
			String[] txt_loan4 = null;
			String[] txt_cost5 = null;
			String[] txt_loan5 = null;
			String[] txt_cost6 = null;
			String[] txt_loan6 = null;
			String[] txt_cost7 = null;
			String[] txt_loan7 = null;
			String[] txt_totalcost1 = null;
			String[] txt_totalloan1 = null;
			txt_item = (String[]) hshValues.get("txt_item");
			txt_cost1 = (String[]) hshValues.get("txt_cost1");
			txt_loan1 = (String[]) hshValues.get("txt_loan1");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_cost2 = (String[]) hshValues.get("txt_cost2");
			txt_loan2 = (String[]) hshValues.get("txt_loan2");
			txt_cost3 = (String[]) hshValues.get("txt_cost3");
			txt_loan3 = (String[]) hshValues.get("txt_loan3");
			txt_cost4 = (String[]) hshValues.get("txt_cost4");
			txt_loan4 = (String[]) hshValues.get("txt_loan4");
			txt_cost5 = (String[]) hshValues.get("txt_cost5");
			txt_loan5 = (String[]) hshValues.get("txt_loan5");
			txt_cost6 = (String[]) hshValues.get("txt_cost6");
			txt_loan6 = (String[]) hshValues.get("txt_loan6");
			txt_cost7 = (String[]) hshValues.get("txt_cost7");
			txt_loan7 = (String[]) hshValues.get("txt_loan7");
			txt_totalcost1 = (String[]) hshValues.get("txt_totalcost1");
			txt_totalloan1 = (String[]) hshValues.get("txt_totalloan1");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_yearcostdetails");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_yearcostdetails");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_yearcostdetails");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) 
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;

				for (int i = 0; i<txt_cost1.length; i++) 
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_yearcostdetails");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("w1");
					}
					if (i + 1 == 2)
					{
						arrValues.add("w2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("w3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("w4");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("w5");
					}
					if (i + 1 == 6)
					{						
						arrValues.add("w6");
					}
					if (i + 1 == 7)
					{
						arrValues.add("w7");
					}
					if (i + 1 == 8) 
					{
						arrValues.add("w8");
					}
					if (i + 1 == 9) 
					{
						arrValues.add("w9");
					}
					if (i + 1 == 10) 
					{
						arrValues.add("w10");
					}
					if (i + 1 == 11) 
					{
						arrValues.add("w11");
					}
					if (i + 1 == 12) 
					{
						arrValues.add("w12");
					}
					if (i + 1 == 13) 
					{
						arrValues.add("w13");
					}
					if (i + 1 == 14) 
					{
						arrValues.add("w14");
					}
					arrValues.add(correctNull(txt_item[i]));
					if (correctNull(txt_cost1[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_cost1[i]));
					}
					if (correctNull(txt_loan1[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loan1[i]));
					}
					if (correctNull(txt_cost2[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else 
					{
						arrValues.add(correctNull(txt_cost2[i]));
					}
					if (correctNull(txt_loan2[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_loan2[i]));
					}
					if (correctNull(txt_cost3[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_cost3[i]));
					}
					if (correctNull(txt_loan3[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loan3[i]));
					}
					if (correctNull(txt_cost4[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_cost4[i]));
					}
					if (correctNull(txt_loan4[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_loan4[i]));
					}
					if (correctNull(txt_cost5[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_cost5[i]));
					}
					if (correctNull(txt_loan5[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_loan5[i]));
					}
					if (correctNull(txt_cost6[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_cost6[i]));
					}
					if (correctNull(txt_loan6[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loan6[i]));
					}
					if (correctNull(txt_cost7[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else 
					{
						arrValues.add(correctNull(txt_cost7[i]));
					}
					if (correctNull(txt_loan7[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loan7[i]));
					}
					if (correctNull(txt_totalcost1[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_totalcost1[i]));
					}
					if (correctNull(txt_totalloan1[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_totalloan1[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}

				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getYearCostData(hshpasValues);
			hshResult.put("PageType",PageType);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap insertPlantationExpenses(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshResult = new HashMap();
		HashMap hshExpens = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "";
		//ResultSet rs = null;
		String strAction = null;
		//int f = 0;
		String[] stritemexpenses = null;
		String[] stryear1 = null;
		String[] stryear2 = null;
		String[] stryear3 = null;
		String[] stryear4 = null;
		String[] stryear5 = null;
		String[] stryear6 = null;
		String[] stryear7 = null;
		String[] stryear8 = null;
		String[] stryear9 = null;
		String[] stryear10 = null;
		String[] stryear11 = null;
		String[] stryear12 = null;
		String[] stryear13 = null;
		String[] stryear14 = null;
		String[] stryear15 = null;
		String[] stryear16 = null;
		String[] stryear17 = null;
		String[] stryear18 = null;
		String[] stryear19 = null;
		String[] stryear20 = null;
		String[] stryear21 = null;
		String[] stryear22 = null;
		String[] stryear23 = null;
		String[] stryear24 = null;
		String[] stryear25 = null;
		
		String[] strtotal = null;
		String strType = "";
		strType=correctNull((String)hshValues.get("type1"));
		
		 strApplicationNo = correctNull((String) hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
			stritemexpenses = (String[]) hshValues.get("item");
			stryear1 = (String[]) hshValues.get("txt_year1");
			stryear2 = (String[]) hshValues.get("txt_year2");
			stryear3 = (String[]) hshValues.get("txt_year3");
			stryear4 = (String[]) hshValues.get("txt_year4");
			stryear5 = (String[]) hshValues.get("txt_year5");
			stryear6 = (String[]) hshValues.get("txt_year6");
			stryear7 = (String[]) hshValues.get("txt_year7");
			stryear8 = (String[]) hshValues.get("txt_year8");
			stryear9 = (String[]) hshValues.get("txt_year9");
			stryear10 = (String[]) hshValues.get("txt_year10");
			stryear11 = (String[]) hshValues.get("txt_year11");
			stryear12 = (String[]) hshValues.get("txt_year12");
			stryear13 = (String[]) hshValues.get("txt_year13");
			stryear14 = (String[]) hshValues.get("txt_year14");
			stryear15 = (String[]) hshValues.get("txt_year15");
			stryear16 = (String[]) hshValues.get("txt_year16");
			stryear17 = (String[]) hshValues.get("txt_year16");
			stryear18 = (String[]) hshValues.get("txt_year18");
			stryear19 = (String[]) hshValues.get("txt_year19");
			stryear20 = (String[]) hshValues.get("txt_year20");
			stryear21 = (String[]) hshValues.get("txt_year21");
			stryear22 = (String[]) hshValues.get("txt_year22");
			stryear23 = (String[]) hshValues.get("txt_year23");
			stryear24 = (String[]) hshValues.get("txt_year24");
			stryear25 = (String[]) hshValues.get("txt_year25");
			
			strtotal = (String[]) hshValues.get("txt_total");
			
		int intUpdatesize = 0;
		
		try {
			
			
			 if (strAction.equalsIgnoreCase("U")) 
				{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull(strType));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_delplantexpenses");
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				intUpdatesize = 1;
				for (int i = 0; i <stritemexpenses.length; i++) 
					{
					if (!stritemexpenses[i].equals("")) 
						{
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "agr_insplantexpenses");
						
						arrValues.add(strApplicationNo);
						
						arrValues.add(new Integer(i).toString());
						arrValues.add("y");
						arrValues.add(correctNull(stritemexpenses[i]));

						if (correctNull(stryear1[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear1[i]));
							}
						if (correctNull(stryear2[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear2[i]));
							}
						if (correctNull(stryear3[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear3[i]));
							}
						if (correctNull(stryear4[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear4[i]));
							}
						if (correctNull(stryear5[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear5[i]));
							}
						if (correctNull(stryear6[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear6[i]));
							}
						if (correctNull(stryear7[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear7[i]));
							}
						if (correctNull(stryear8[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear8[i]));
							}
						if (correctNull(stryear9[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear9[i]));
							}
						if (correctNull(stryear10[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear10[i]));
							}
						if (correctNull(stryear11[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear11[i]));
							}
						if (correctNull(stryear12[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear12[i]));
							}
						if (correctNull(stryear13[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear13[i]));
							}
						if (correctNull(stryear14[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear14[i]));
							}
						if (correctNull(stryear15[i]).equals("")) 
							{
							arrValues.add("0.0");
							} 
						else 
							{
							arrValues.add(correctNull(stryear15[i]));
							}
						if (correctNull(stryear16[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear16[i]));
						}
						if (correctNull(stryear17[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear17[i]));
						}
						if (correctNull(stryear18[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear18[i]));
						}
						if (correctNull(stryear19[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear19[i]));
						}
						if (correctNull(stryear20[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear20[i]));
						}
						if (correctNull(stryear21[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear21[i]));
						}
						if (correctNull(stryear22[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear22[i]));
						}
						if (correctNull(stryear23[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear23[i]));
						}
						if (correctNull(stryear24[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear24[i]));
						}
						if (correctNull(stryear25[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(stryear25[i]));
						}
						
						arrValues.add(correctNull(strType));
						if (correctNull(strtotal[i]).equals("")) 
						{
						arrValues.add("0.0");
						} 
						else 
						{
						arrValues.add(correctNull(strtotal[i]));
						}
						
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
						}
					}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			 
					else if(strAction.equalsIgnoreCase("D"))
						{			
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							arrValues.add(strApplicationNo);
							arrValues.add(correctNull(strType));
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","agr_delplantexpenses");
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
			 
			 
			 
			   StringBuilder sbAuditTrial=new StringBuilder();
			   if (strAction.equalsIgnoreCase("I") || strAction.equalsIgnoreCase("U")) {
			 for (int i = 0; i <stritemexpenses.length; i++) 
				{
				if (!stritemexpenses[i].equals("")) 
					{
					sbAuditTrial
						.append("~Items of Development = ")
						.append(correctNull(stritemexpenses[i]))
						.append("~Year1 = ")
						.append(correctNull(stryear1[i]))
						.append("~Year2 = ")
						.append(correctNull(stryear2[i]))
						.append("~Year3 = ")
						.append(correctNull(stryear3[i]))
						.append("~Year4 = ")
						.append(correctNull(stryear4[i]))
						.append("~Year5 = ")
						.append(correctNull(stryear5[i]))
						.append("~Year6 = ")
						.append(correctNull(stryear6[i]))
						.append("~Year7 = ")
						.append(correctNull(stryear7[i]))
						.append("~Year8 = ")
						.append(correctNull(stryear8[i]))
						.append("~Year9 = ")
						.append(correctNull(stryear9[i]))
						.append("~Year10 = ")
						.append(correctNull(stryear10[i]))
						.append("~Year11 = ")
						.append(correctNull(stryear11[i]))
						.append("~Year12 = ")
						.append(correctNull(stryear12[i]))
						.append("~Year13 = ")
						.append(correctNull(stryear13[i]))
						.append("~Year14 = ")
						.append(correctNull(stryear14[i]))
						.append("~Year15 = ")
						.append(correctNull(stryear15[i]))
						.append("~Year16 = ")
						.append(correctNull(stryear16[i]))
						.append("~Year17 = ")
						.append(correctNull(stryear17[i]))
						.append("~Year18 = ")
						.append(correctNull(stryear18[i]))
						.append("~Year19 = ")
						.append(correctNull(stryear19[i]))
						.append("~Year20 = ")
						.append(correctNull(stryear20[i]))
						.append("~Year21 = ")
						.append(correctNull(stryear21[i]))
						.append("~Year22 = ")
						.append(correctNull(stryear22[i]))
						.append("~Year23 = ")
						.append(correctNull(stryear23[i]))
						.append("~Year24 = ")
						.append(correctNull(stryear24[i]))
						.append("~Year25 = ")
						.append(correctNull(stryear25[i]))
						.append("~Total = ")
						.append(correctNull(strtotal[i]));
					}
				}
			 
			 if(strAction.equalsIgnoreCase("U")) {
				 
				 hshValues.put("strAction","Insert");
			 }
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
			   } 
			  
			   if(strAction.equalsIgnoreCase("D")){
				   
					 hshValues.put("strAction","Delete");
				}
			  
			 if(strType.equalsIgnoreCase("EXP"))
			 {
				AuditTrial.auditLog(hshValues,"270",strApplicationNo,sbAuditTrial.toString());
			 }
			 else
			 {
				 AuditTrial.auditLog(hshValues,"271",strApplicationNo,sbAuditTrial.toString());
			 }
			 hshExpens.put("appno", strApplicationNo);
				hshResult = getplantationExpenses(hshExpens);				
			
		} catch (Exception e) {
			throw new EJBException("Error in Delete Data " + e.getMessage());
		}
		return hshResult;
	}
	public HashMap getplantationExpenses(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strApplicationNo="";
		strApplicationNo = correctNull((String) hshValues.get("strappno"));
		String strType = "";
		strType=correctNull((String)hshValues.get("type1"));
		String recordflag="N";		
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
		}
				
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agr_get_plantaionexpenses^" + strApplicationNo+"^"+strType);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				recordflag="Y";
				//arryCol.add(strApplicationNo);
				arryCol.add(rs.getString("exp_sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("exp_item"));
				arryCol.add(rs.getString("exp_year1"));
				arryCol.add(rs.getString("exp_year2"));
				
				arryCol.add(rs.getString("exp_year3"));
				arryCol.add(rs.getString("exp_year4"));
				arryCol.add(rs.getString("exp_year5"));
				arryCol.add(rs.getString("exp_year6"));
				arryCol.add(rs.getString("exp_year7"));
				
				arryCol.add(rs.getString("exp_year8"));
				arryCol.add(rs.getString("exp_year9"));
				arryCol.add(rs.getString("exp_year10"));
				arryCol.add(rs.getString("exp_year11"));
				arryCol.add(rs.getString("exp_year12"));
				
				arryCol.add(rs.getString("exp_year13"));
				arryCol.add(rs.getString("exp_year14"));	
				arryCol.add(rs.getString("exp_year15"));
				
				arryCol.add(rs.getString("exp_year16"));
				arryCol.add(rs.getString("exp_year17"));
				arryCol.add(rs.getString("exp_year18"));
				arryCol.add(rs.getString("exp_year19"));
				arryCol.add(rs.getString("exp_year20"));
				arryCol.add(rs.getString("exp_year21"));
				arryCol.add(rs.getString("exp_year22"));
				arryCol.add(rs.getString("exp_year23"));
				arryCol.add(rs.getString("exp_year24"));
				arryCol.add(rs.getString("exp_year25"));
				arryCol.add(rs.getString("exp_total"));
				
					
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", strApplicationNo);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("recordflag",recordflag);
		} 
		catch (Exception ce)
		{
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
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getEconomicAspects(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		String appno = "";
		String[] strTotalNetIncome = new String[2];
		String[] strTotalGrossIncome = new String[2];
		String[] strNetIncome = null;
		HashMap hshRecord = new HashMap();
		double lngcultcost = 0.00;
		double lngGrossIncome = 0.00;
		double lngNetIncome = 0.00;
		int i = 0;
		double lngBeforeTotalGrossIncome = 0.00;
		double lngBeforeTotalNetIncome = 0.00;
		double lngAfterTotalGrossIncome = 0.00;
		double lngAfterTotalNetIncome = 0.00;
		ArrayList vecVal = new ArrayList();
		ArrayList vecData = new ArrayList();
		try 
		{
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_economicaspectsselect^"+ appno);
			rs = DBUtils.executeQuery(strQuery);
			strNetIncome = new String[6];
			while (rs.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("agr_slno")));
				vecVal.add(correctNull(rs.getString("agr_patterntype")));
				vecVal.add(correctNull(rs.getString("agr_season")));
				vecVal.add(correctNull(rs.getString("agr_cropname")));
				if (correctNull(rs.getString("agr_acreage")).trim().equalsIgnoreCase("0.00"))
				{
					vecVal.add("");
				} 
				else 
				{
					vecVal.add(correctNull(rs.getString("agr_acreage")));
				}
				if (correctNull(rs.getString("agr_cultivationcost")).trim().equalsIgnoreCase("0.00"))
				{
					vecVal.add("");
				} 
				else
				{
					vecVal.add(correctNull(rs.getString("agr_cultivationcost")));
				}
				if (correctNull(rs.getString("agr_totalyield")).trim().equalsIgnoreCase("0.00"))
				{
					vecVal.add("");
				}
				else 
				{
					vecVal.add(correctNull(rs.getString("agr_totalyield")));
				}
				if (correctNull(rs.getString("agr_grossincome")).trim().equalsIgnoreCase("0.00")) 
				{
					vecVal.add("");
				}
				else
				{
					vecVal.add(correctNull(rs.getString("agr_grossincome")));
				}
				vecData.add(vecVal);
				lngcultcost = Double.parseDouble(Helper.correctDouble(rs.getString("agr_cultivationcost")));
				lngGrossIncome = Double.parseDouble(Helper.correctDouble(rs.getString("agr_grossincome")));
				lngNetIncome = lngGrossIncome - lngcultcost;
				strNetIncome[i] = correctNull(Helper.formatDoubleValue(lngNetIncome));
				if (rs.getString("agr_patterntype").trim().equalsIgnoreCase("Before"))
				{
					lngBeforeTotalGrossIncome += lngGrossIncome;
					lngBeforeTotalNetIncome += lngNetIncome;
				} 
				else if (rs.getString("agr_patterntype").trim().equalsIgnoreCase("After")) 
				{
					lngAfterTotalGrossIncome += lngGrossIncome;
					lngAfterTotalNetIncome += lngNetIncome;
				}
				i++;
			}
			if(rs != null)
			{
				rs.close();
			}
			ArrayList arrvalues1 = new ArrayList();
			ArrayList arrvalues2 = new ArrayList();
			arrvalues1.add(correctNull(Helper.formatDoubleValue(lngBeforeTotalGrossIncome)));
			arrvalues1.add(correctNull(Helper.formatDoubleValue(lngAfterTotalGrossIncome)));
			arrvalues2.add(correctNull(Helper.formatDoubleValue(lngBeforeTotalNetIncome)));
			arrvalues2.add(correctNull(Helper.formatDoubleValue(lngAfterTotalNetIncome)));
			for (int k = 0; k < arrvalues1.size(); k++) 
			{
				strTotalGrossIncome[k] = (String) arrvalues1.get(k);
				strTotalNetIncome[k] = (String) arrvalues2.get(k);
			}
			hshRecord.put("vecData", vecData);
			hshRecord.put("NetIncome", strNetIncome);
			hshRecord.put("TotalNetIncome", strTotalNetIncome);
			hshRecord.put("TotalGrossIncome", strTotalGrossIncome);
		}
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateEconomicAspects(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = "";
		String appno = "";
		String slno[] = null;
		String strPatternType[] = null;
		String strSeason[] = null;
		String strCropName[] = null;
		String strAcreage[] = null;
		String strTotalCultivationCost[] = null;
		String strTotalYield[] = null;
		String strGrossIncome[] = null;
		try
		{
			strAction = correctNull((String) hshValues.get("hidAction"));
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			slno = (String[]) hshValues.get("hidtxt_slno");
			strPatternType = (String[]) hshValues.get("hidtxt_patterntype");
			strSeason = (String[]) hshValues.get("hidtxt_season");
			strCropName = (String[]) hshValues.get("txt_cropname");
			strAcreage = (String[]) hshValues.get("txt_acreage");
			strTotalCultivationCost = (String[]) hshValues.get("txt_totalcultivationcost");
			strTotalYield = (String[]) hshValues.get("txt_totalyield");
			strGrossIncome = (String[]) hshValues.get("txt_grossincome");
			if (strAction.trim().equalsIgnoreCase("update")) 
			{
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_economicaspectsdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				for (int i = 0; i < slno.length; i++) 
				{
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_economicaspectsinsert");
					arrValues.add(appno);
					arrValues.add(slno[i]);
					arrValues.add(strPatternType[i]);
					arrValues.add(strSeason[i]);
					arrValues.add(strCropName[i]);
					if (strAcreage[i].trim().equalsIgnoreCase("")) 
					{
						strAcreage[i] = "0.00";
					}
					arrValues.add(strAcreage[i]);
					if (strTotalCultivationCost[i].trim().equalsIgnoreCase(""))
					{
						strTotalCultivationCost[i] = "0.00";
					}
					arrValues.add(strTotalCultivationCost[i]);
					if (strTotalYield[i].trim().equalsIgnoreCase("")) 
					{
						strTotalYield[i] = "0.00";
					}
					arrValues.add(strTotalYield[i]);
					if (strGrossIncome[i].trim().equalsIgnoreCase(""))
					{
						strGrossIncome[i] = "0.00";
					}
					arrValues.add(strGrossIncome[i]);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			} 
			else if (strAction.trim().equals("insert"))
			{
				for (int i = 0; i < slno.length; i++) 
				{
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_economicaspectsinsert");
					arrValues.add(appno);
					arrValues.add(slno[i]);
					arrValues.add(strPatternType[i]);
					arrValues.add(strSeason[i]);
					arrValues.add(strCropName[i]);
					if (strAcreage[i].trim().equalsIgnoreCase("")) 
					{
						strAcreage[i] = "0.00";
					}
					arrValues.add(strAcreage[i]);
					if (strTotalCultivationCost[i].trim().equalsIgnoreCase("")) 
					{
						strTotalCultivationCost[i] = "0.00";
					}
					arrValues.add(strTotalCultivationCost[i]);
					if (strTotalYield[i].trim().equalsIgnoreCase(""))
					{
						strTotalYield[i] = "0.00";
					}
					arrValues.add(strTotalYield[i]);
					if (strGrossIncome[i].trim().equalsIgnoreCase("")) 
					{
						strGrossIncome[i] = "0.00";
					}
					arrValues.add(strGrossIncome[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			else if (strAction.equals("delete"))
			{
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_economicaspectsdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in updateEconomicsDetails "+ ce.toString());
		}
	}

	public HashMap updateCroppingPatterns(HashMap hshValues)  
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshpasValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAction="";		
		String strCropSno="0";
		String strApplicationNo = Helper.correctNull((String) hshValues.get("appno"));
		if(strApplicationNo.equalsIgnoreCase("null") || strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = Helper.correctNull((String)hshValues.get("strappno"));
		}
		strAction = Helper.correctNull((String) hshValues.get("hidAction"));
		
		String strTotal= Helper.correctNull((String) hshValues.get("txt_totalincome"));
		strCropSno=Helper.correctNull((String) hshValues.get("hid_sno"));
		String schemetype= Helper.correctNull((String)hshValues.get("schemetype"));
		String strFinancialYr= Helper.correctNull((String)hshValues.get("sel_finyr"));
		String ModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
		String strSeason=null;
		String strCropname=null;
		String strArea=null;
		String strYieldperAcre=null;
		String strTotalYield=null;
		String strPricePerQtl=null;
		String strTotalInc=null;
		String CostOfCult=null;
		String strTotalCostOfCult=null;
		String strSurplus=null;
		String strType=null;
		String strExiprotype=null;
		int intUpdatesize=0;
		String strAreaUnits="",strYieldUnits="";
		int intValue = 0;
		try
		{
			if(Helper.correctNull((String) hshValues.get("hidPgeType")).equalsIgnoreCase("before")){
				strType="b";
			}
			else
			{
				strType="a";
			}
			
			strApplicationNo=correctNull((String)hshValues.get("appno"));
			if(strApplicationNo.equalsIgnoreCase("null") || strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo= Helper.correctNull((String)hshValues.get("strappno"));
			}
			strSeason=(String)hshValues.get("sel_season");
			strCropname=(String )hshValues.get("txt_cropname");
			strArea=(String )hshValues.get("txt_area");
			strYieldperAcre=(String )hshValues.get("txt_yieldperacre");
			strTotalYield=(String )hshValues.get("txt_totalyield");
			strPricePerQtl=(String)hshValues.get("txt_priceperquin");
			strTotalInc=(String)hshValues.get("txt_totalinc");
			CostOfCult=(String)hshValues.get("txt_costofcultivation");
			strTotalCostOfCult=Helper.correctNull((String)hshValues.get("txt_totalcostofcultivation"));
			strSurplus=Helper.correctNull((String)hshValues.get("txt_surplus"));
			strExiprotype=Helper.correctNull((String)hshValues.get("sel_type"));
			strAreaUnits=Helper.correctNull((String)hshValues.get("sel_units"));
			strYieldUnits=Helper.correctNull((String)hshValues.get("sel_unitsy"));
			if (strAction.equals("delete")) 
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "agr_delcroppingpattern");
				arrValues.add(strApplicationNo);
				arrValues.add(strType);
				arrValues.add(strCropSno);
				arrValues.add(strExiprotype);
				arrValues.add(strSeason);
				arrValues.add(strCropname);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				if(strType.equalsIgnoreCase("b"))
				{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "agr_delcroppingpattern");
				arrValues.add(strApplicationNo);
				arrValues.add("a");
				arrValues.add(strCropSno);
				arrValues.add(strExiprotype);
				arrValues.add(strSeason);
				arrValues.add(strCropname);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				}
				
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				/*HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "agr_delcroppingpattern");
				arrValues3.add(strApplicationNo);
				arrValues3.add(strType);
				arrValues3.add(strCropSno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
				
				
				//For Existing single year value should be updated for all the years  by Guhan T
				if(strExiprotype.equalsIgnoreCase("1"))
				{
				double dblTenor = 0.00,dblTenortot = 0.00;
				String StrQuery10 = SQLParser.getSqlQuery("sel_tenorforfinyear^"+strApplicationNo);
				ResultSet rs10 = DBUtils.executeQuery(StrQuery10);
				if(rs10.next())
				{
					dblTenor = Double.parseDouble(Helper.correctDouble((String)rs10.getString("facility_months")));
					dblTenortot = dblTenor/12;
					dblTenortot = Math.ceil(dblTenortot);
				}
				if(ModuleType.equalsIgnoreCase("RET")){
					String StrQuery11 = SQLParser.getSqlQuery("selloanrecmtamntloanddet^"+strApplicationNo);
					ResultSet rs11 = DBUtils.executeQuery(StrQuery11);
					if(rs11.next()){
						dblTenor = Double.parseDouble(Helper.correctDouble((String)rs11.getString("loan_reqterms")));
						dblTenortot = dblTenor/12;
						dblTenortot = Math.ceil(dblTenortot);
				}
				}
				for(int j=0;j<dblTenortot;j++)
				{
				/*rs=DBUtils.executeLAPSQuery("agrcroppingpattern_max^"+strApplicationNo+"^"+strType+"^"+strExiprotype);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}*/
				intUpdatesize=0;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
							
					if(!Helper.correctNull(strSeason).equals("0"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues = new HashMap();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","agr_inscroppingpattern");
					
						
						arrValues.add(strApplicationNo);
						//intValue=intValue+1;
						int k=j+1;
						String strSno=Integer.toString(k);
						arrValues.add(strSno);
						
						arrValues.add(Helper.correctNull((String)strSeason));	
						arrValues.add(Helper.correctNull((String)strCropname));			
						arrValues.add(Helper.correctDouble((String)strArea));
						arrValues.add(Helper.correctDouble((String)strYieldperAcre));
						arrValues.add(Helper.correctDouble((String)strTotalYield));
						arrValues.add(Helper.correctDouble((String)strPricePerQtl)); 
						arrValues.add(Helper.correctDouble((String)strTotalInc));

						arrValues.add(Helper.correctDouble((String)CostOfCult));
						arrValues.add(Helper.correctDouble((String)strTotalCostOfCult));
						arrValues.add(Helper.correctDouble((String)strSurplus));
						arrValues.add(strTotal);
						arrValues.add(strType);
						//arrValues.add(strFinancialYr);
						arrValues.add(strSno);
						arrValues.add(Helper.correctDouble((String)strExiprotype));
						//added by bhaskar for area units and yeild units
						arrValues.add(strAreaUnits);
						arrValues.add(strYieldUnits);					
						//end						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				}
				
				if(strExiprotype.equalsIgnoreCase("2"))
				{
				rs=DBUtils.executeLAPSQuery("agrcroppingpattern_max^"+strApplicationNo+"^"+strType+"^"+strExiprotype);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
		
				hshQuery = new HashMap();
				arrValues=new ArrayList();
							
					if(!Helper.correctNull(strSeason).equals("0"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","agr_inscroppingpattern");
					
						
						arrValues.add(strApplicationNo);
						intValue=intValue+1;
						//j=j+1;
						String strSno=Integer.toString(intValue);
						arrValues.add(strSno);
						
						arrValues.add(Helper.correctNull((String)strSeason));	
						arrValues.add(Helper.correctNull((String)strCropname));			
						arrValues.add(Helper.correctDouble((String)strArea));
						arrValues.add(Helper.correctDouble((String)strYieldperAcre));
						arrValues.add(Helper.correctDouble((String)strTotalYield));
						arrValues.add(Helper.correctDouble((String)strPricePerQtl)); 
						arrValues.add(Helper.correctDouble((String)strTotalInc));

						arrValues.add(Helper.correctDouble((String)CostOfCult));
						arrValues.add(Helper.correctDouble((String)strTotalCostOfCult));
						arrValues.add(Helper.correctDouble((String)strSurplus));
						arrValues.add(strTotal);
						arrValues.add(strType);
						arrValues.add(strFinancialYr);
						//arrValues.add(strSno);
						arrValues.add(Helper.correctDouble((String)strExiprotype));
						//added by bhaskar for area units and yeild units
						arrValues.add(strAreaUnits);
						arrValues.add(strYieldUnits);					
						//end						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}				
				
			}
			
			
			if (strAction.equals("update"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "agr_delcroppingpattern");
				arrValues3.add(strApplicationNo);
				arrValues3.add(strType);
				arrValues3.add(strCropSno);
				arrValues3.add(strExiprotype);
				arrValues3.add(strSeason);
				arrValues3.add(strCropname);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				rs=DBUtils.executeLAPSQuery("agrcroppingpattern_max^"+strApplicationNo+"^"+strType+"^"+strExiprotype);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
		
				hshQuery = new HashMap();
				arrValues=new ArrayList();
							
					if(!Helper.correctNull(strSeason).equals("0"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","agr_inscroppingpattern");
					
						
						arrValues.add(strApplicationNo);
						intValue=intValue+1;
						String strSno=Integer.toString(intValue);
						arrValues.add(strSno);
						
						arrValues.add(Helper.correctNull((String)strSeason));	
						arrValues.add(Helper.correctNull((String)strCropname));			
						arrValues.add(Helper.correctDouble((String)strArea));
						arrValues.add(Helper.correctDouble((String)strYieldperAcre));
						arrValues.add(Helper.correctDouble((String)strTotalYield));
						arrValues.add(Helper.correctDouble((String)strPricePerQtl)); 
						arrValues.add(Helper.correctDouble((String)strTotalInc));

						arrValues.add(Helper.correctDouble((String)CostOfCult));
						arrValues.add(Helper.correctDouble((String)strTotalCostOfCult));
						arrValues.add(Helper.correctDouble((String)strSurplus));
						arrValues.add(strTotal);
						arrValues.add(strType);
						arrValues.add(strFinancialYr);
						arrValues.add(Helper.correctDouble((String)strExiprotype));
						//added by bhaskar for area units and yeild units
						arrValues.add(strAreaUnits);
						arrValues.add(strYieldUnits);					
						//end	
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshpasValues.put("appno",strApplicationNo);
			
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
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
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	
	}
	
	public HashMap getCroppingPatterns(HashMap hshValues)  
	{
		HashMap hshResult=new HashMap();
		String strType=null;
		String strPageType[]=null;
		HashMap hshCropPattern =null;
		String strApplicationNo = correctNull((String) hshValues.get("appno"));
		String strFinancialYrtype="";
		String strcropexiproptype="";
		if(strApplicationNo.equalsIgnoreCase("null") || strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo= Helper.correctNull((String)hshValues.get("strappno"));
		}
		String schemetype=correctNull((String)hshValues.get("schemetype"));
		strFinancialYrtype=correctNull((String)hshValues.get("sel_finyr"));
		strcropexiproptype=correctNull((String)hshValues.get("sel_type"));
		//Commented as there is no need
		/*if (hshValues.get("hidPgeType") instanceof String[]) {
			
			strPageType = (String[]) hshValues.get("hidPgeType");
			if(Helper.correctNull(strPageType[0]).equalsIgnoreCase("before")){
				strType="b";
			}
			else
			{
				strType="a";
			}
		}
		else{
			if(Helper.correctNull((String) hshValues.get("hidPgeType")).equalsIgnoreCase("before")){
				strType="b";
			}
			else
			{
				strType="a";
			}
		}*/
		strType="a";
		try
		{
			if(!strcropexiproptype.equalsIgnoreCase("")){
				hshCropPattern = new AgrFarmMachineryBO().getCroppingPattenByAppno(strApplicationNo,strType,strcropexiproptype);
				hshResult.put("arryRow",hshCropPattern.get("arrData"));
				hshResult.put("total", (String)hshCropPattern.get("total"));
				hshResult.put("Exis_Tootal", (String)hshCropPattern.get("Exis_Tootal"));
				hshResult.put("prop_Tootal", (String)hshCropPattern.get("prop_Tootal"));
				
				/*if(strType.equalsIgnoreCase("a"))
				{
					hshCropPattern = new AgrFarmMachineryBO().getCroppingPattenByAppno(strApplicationNo,"b",strcropexiproptype);
				}
				*/
				//hshResult.put("arryBefRow",hshCropPattern.get("arrData"));
				//hshResult.put("totalbef",hshCropPattern.get("total"));
			}
			hshResult.put("schemetype",schemetype);
			hshResult.put("sel_type",strcropexiproptype);
		
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		return hshResult;
	
	}


	
	
	
		
	public HashMap getBoatEconomics(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		String appno = "";
		String strTotalCatch = "";
		long lngTotalCatch = 0;
		String strTotalExpense = "";
		String strGrossSurplus = "";
		String strNetSurplus = "";
		double dblTotalExpense = 0.00;
		double dblGrossSurplus = 0.00;
		double dblNetSurplus = 0.00;
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecData = new ArrayList();
		try 
		{			
			appno = correctNull((String) hshValues.get("strappno"));
			appno="ANBR0000009";
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_boateconomicsselect^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				lngTotalCatch = Long.parseLong(rs.getString("agr_avgdailycatches"))* Long.parseLong(rs.getString("agr_fishingdays"));
				dblTotalExpense = Double.parseDouble(Helper.correctDouble(rs.getString("agr_wage")))+ Double.parseDouble(Helper.correctDouble(rs.getString("agr_repair")))
						+ Double.parseDouble(Helper.correctDouble(rs.getString("agr_miscellaneous")));
				dblGrossSurplus = Double.parseDouble(Helper.correctDouble(rs.getString("agr_totalcatchvalue")))- dblTotalExpense;
				dblNetSurplus = dblGrossSurplus- Double.parseDouble(Helper.correctDouble(rs.getString("agr_loanrepay")));
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("agr_slno")));
				vecVal.add(correctNull(rs.getString("agr_operatingplace")));
				vecVal.add(correctNull(rs.getString("agr_distance")));
				vecVal.add(correctNull(rs.getString("agr_boatnos")));
				vecVal.add(correctNull(rs.getString("agr_fishtype1")));
				vecVal.add(correctNull(rs.getString("agr_fishtype2")));
				vecVal.add(correctNull(rs.getString("agr_fishtype3")));
				vecVal.add(correctNull(rs.getString("agr_fishtype4")));
				vecVal.add(correctNull(rs.getString("agr_fishtype5")));
				vecVal.add(correctNull(rs.getString("agr_avgdailycatches")));
				vecVal.add(correctNull(rs.getString("agr_fishingdays")));
				vecVal.add(correctNull(rs.getString("agr_totalcatchvalue")));
				vecVal.add(correctNull(rs.getString("agr_wage")));
				vecVal.add(correctNull(rs.getString("agr_repair")));
				vecVal.add(correctNull(rs.getString("agr_miscellaneous")));
				vecVal.add(correctNull(rs.getString("agr_loanrepay")));
				vecData.add(vecVal);
			}
			if(rs != null)
			{
				rs.close();
			}
			strTotalCatch = Long.toString(lngTotalCatch);
			strTotalExpense = Helper.formatDoubleValue(dblTotalExpense);
			strGrossSurplus = Helper.formatDoubleValue(dblGrossSurplus);
			strNetSurplus = Helper.formatDoubleValue(dblNetSurplus);
			hshRecord.put("vecData", vecData);
			hshRecord.put("TotalCatch", strTotalCatch);
			hshRecord.put("TotalExpense", strTotalExpense);
			hshRecord.put("GrossSurplus", strGrossSurplus);
			hshRecord.put("NetSurplus", strNetSurplus);
		} 
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
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
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateBoatEconomics(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = "";
		String appno = "";
		String strOperatingPlace = "";
		String agrslno="";
		String strDistance = "";
		String strBoatNos = "";
		String strFishtype1 = "";
		String strFishtype2 = "";
		String strFishtype3 = "";
		String strFishtype4 = "";
		String strFishtype5 = "";
		String strAvgDailyCatches = "";
		String strFishingDays = "";
		String strTotalCatchValue = "";
		String strWageExpense = "";
		String strRepairExpense = "";
		String strMiscellaneousExpense = "";
		String strLoanRepay = "";

		try 
		{
			strAction = correctNull((String) hshValues.get("hidAction"));
			appno = correctNull((String) hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			appno="ANBR0000009";
			if (strAction.trim().equalsIgnoreCase("update")) 
			{
				strOperatingPlace = correctNull((String) hshValues.get("txt_operatingplace"));
				strDistance = correctNull((String) hshValues.get("txt_distance"));
				if (strDistance.trim().equalsIgnoreCase(""))
				{
					strDistance = "0";
				}
				strBoatNos = correctNull((String) hshValues.get("txt_alreadyopboatnos"));
				if (strBoatNos.trim().equalsIgnoreCase("")) 
				{
					strBoatNos = "0";
				}
				strFishtype1 = correctNull((String) hshValues.get("txt_fishtype1"));
				strFishtype2 = correctNull((String) hshValues.get("txt_fishtype2"));
				strFishtype3 = correctNull((String) hshValues.get("txt_fishtype3"));
				strFishtype4 = correctNull((String) hshValues.get("txt_fishtype4"));
				strFishtype5 = correctNull((String) hshValues.get("txt_fishtype5"));
				strAvgDailyCatches = correctNull((String) hshValues.get("txt_avgdailycatches"));
				if (strAvgDailyCatches.trim().equalsIgnoreCase("")) 
				{
					strAvgDailyCatches = "0";
				}
				strFishingDays = correctNull((String) hshValues.get("txt_nooffishingdays"));
				if (strFishingDays.trim().equalsIgnoreCase(""))
				{
					strFishingDays = "0";
				}
				strTotalCatchValue = correctNull((String) hshValues.get("txt_totalcatchvalue"));
				if (strTotalCatchValue.trim().equalsIgnoreCase("")) 
				{
					strTotalCatchValue = "0";
				}
				strWageExpense = correctNull((String) hshValues.get("txt_wages"));
				if (strWageExpense.trim().equalsIgnoreCase("")) 
				{
					strWageExpense = "0";
				}
				strRepairExpense = correctNull((String) hshValues.get("txt_repair"));
				if (strRepairExpense.trim().equalsIgnoreCase("")) 
				{
					strRepairExpense = "0";
				}
				strMiscellaneousExpense = correctNull((String) hshValues.get("txt_miscellaneous"));
				if (strMiscellaneousExpense.trim().equalsIgnoreCase("")) 
				{
					strMiscellaneousExpense = "0";
				}
				strLoanRepay = correctNull((String) hshValues.get("txt_loanrepay"));
				if (strLoanRepay.trim().equalsIgnoreCase(""))
				{
					strLoanRepay = "0";
				}

				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_boateconomicsdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				hshQuery.put("strQueryId", "agr_boateconomicsinsert");
				arrValues.add(appno);
				agrslno = Integer.toString(getMaxGradeId(appno));
				arrValues.add(agrslno);
				arrValues.add(strOperatingPlace);
				arrValues.add(strDistance);
				arrValues.add(strBoatNos);
				arrValues.add(strFishtype1);
				arrValues.add(strFishtype2);
				arrValues.add(strFishtype3);
				arrValues.add(strFishtype4);
				arrValues.add(strFishtype5);
				arrValues.add(strAvgDailyCatches);
				arrValues.add(strFishingDays);
				arrValues.add(strTotalCatchValue);
				arrValues.add(strWageExpense);
				arrValues.add(strRepairExpense);
				arrValues.add(strMiscellaneousExpense);
				arrValues.add(strLoanRepay);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.equals("delete"))
			{
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_boateconomicsdelete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in updateBoatEconomics "+ ce.toString());
		}
	}
	
	public void updatesheddetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("strappno"));	
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrsheddetailsupdate");	
				arrValues.add(correctNull((String)hshValues.get("txr_shedarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_cattlearea")));
				arrValues.add(correctNull((String )hshValues.get("txr_cattlefeedarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_watersupply")));
				arrValues.add(correctNull((String )hshValues.get("txr_veterinaryarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_milkarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_sancyear")));
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{				
				strGradeId = Integer.toString(getMaxGradeId2(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrsheddetailsinsert");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String)hshValues.get("txr_shedarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_cattlearea")));
				arrValues.add(correctNull((String )hshValues.get("txr_cattlefeedarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_watersupply")));
				arrValues.add(correctNull((String )hshValues.get("txr_veterinaryarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_milkarea")));
				arrValues.add(correctNull((String )hshValues.get("txr_sancyear")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agrsheddetailsdelete");
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

	public  HashMap getsheddetails(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
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
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))) );
				hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))) );
				hshRecord.put("applicantid",rs1.getString("demo_appid"));
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			if(strAction.trim().equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("agrsheddetailssel^"+appno+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("agrsheddetailsselection^"+appno);
			}	
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("shed_appno")));
				vecVal.add(correctNull(rs2.getString("shed_id")));
				vecVal.add(correctNull(rs2.getString("shed_total_size")));
				vecVal.add(correctNull(rs2.getString("shed_purc_cattle")));
				vecVal.add(correctNull(rs2.getString("shed_purc_cattlefeed")));
				vecVal.add(correctNull(rs2.getString("shed_water_supply")));
				vecVal.add(correctNull(rs2.getString("shed_vetrrinary_aid")));
				vecVal.add(correctNull(rs2.getString("shed_sale_milk_byprod")));
				vecVal.add(correctNull(rs2.getString("shed_prev_loandetails")));
				vecData.add(vecVal);							
			}	
			if(rs2 != null)
			{
				rs2.close();
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
				if(rs1 != null)
				{
					rs1.close();
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
		return hshRecord;
	}	
	
	private int getMaxGradeId2(String appno)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("agrsheddetailsmax^"+appno);
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
			if(rs != null)
			{
				rs.close();
			}		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());		
		}finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getMaxGradeId2 - agrcropsBean  "+ exp.toString()); 
			}
		}
		return termId;
	}

	public void updatetechdetails(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","techdetailsdel");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_grown")));
				String cbofacilities=correctNull((String) hshValues.get("cbofacilities"));
				if(cbofacilities.equalsIgnoreCase(""))
				{
					cbofacilities="0";
				}
				arrValues.add(cbofacilities);				
				arrValues.add(correctNull((String) hshValues.get("txt_adequate")));
				arrValues.add(correctNull((String) hshValues.get("txt_supply")));
				arrValues.add(correctNull((String) hshValues.get("txt_produce")));
				arrValues.add(correctNull((String) hshValues.get("txt_barns")));
				arrValues.add(correctNull((String) hshValues.get("txt_dimensions")));
				arrValues.add(correctNull((String) hshValues.get("txt_loc")));
				arrValues.add(correctNull((String) hshValues.get("txt_bran")));
				String cbocredit=correctNull((String) hshValues.get("cbocredit"));
				if(cbocredit.equalsIgnoreCase(""))
				{
					cbocredit="0";
				}
				arrValues.add(cbocredit);
				arrValues.add(correctNull((String) hshValues.get("txt_fact")));
				String cboagree=correctNull((String) hshValues.get("cboagree"));
				if(cboagree.equalsIgnoreCase(""))
				{
					cboagree="0";
				}
				arrValues.add(cboagree);
				arrValues.add(correctNull((String) hshValues.get("txt_agr")));
				String txt_receivedRH=correctNull((String) hshValues.get("txt_receivedRH"));
				if(txt_receivedRH.equalsIgnoreCase(""))
				{
					txt_receivedRH="01/01/1900";
				}
				arrValues.add(txt_receivedRH);
				arrValues.add(correctNull((String) hshValues.get("address")));
				arrValues.add(correctNull((String) hshValues.get("cbougc")));
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "techdetailsins");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//Added after discussion with Suresh thus the values in scale of finance get cleared once proposal based get changed. 
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
			    hshQueryValues.put("size","1");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId", "agr_assesmentdetails_tech_upd");
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","techdetailsdel");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
			
		StringBuilder sbAuditTrial=new StringBuilder();
		if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
				
			sbAuditTrial.append("Proposal Based On=").append(ApplicantParams.getApplicantParams("AgricultureTechnicalAspects",correctNull((String )hshValues.get("cbougc")))).append("~1. Seasonality of crops to be grown for which financial assistance is required =").append(correctNull((String )hshValues.get("txt_grown")))
			.append("~2. (i) Details of irrigation facilities available  =").append(correctNull((String )hshValues.get("txt_adequate"))).append("~(ii) Are they adequate?  =").append(SetupParams.getSetupParams("Education",correctNull((String )hshValues.get("cbofacilities"))))
			.append("~3. Arrangements for the following ^").append("~(i) Supply of inputs =").append(correctNull((String )hshValues.get("txt_supply")))
			.append("~(ii) Marketing of produce=").append(correctNull((String )hshValues.get("txt_produce"))).append("~4. In case of tobacco crop: ^")
			.append("~(i) Number of Barns =").append(correctNull((String )hshValues.get("txt_barns"))).append("~(ii) Dimension of the Barns =").append(correctNull((String )hshValues.get("txt_dimensions")))
			.append("~(iii) Their location =").append(correctNull((String )hshValues.get("txt_loc"))).append("~(iv) Distance from the Branch =").append(correctNull((String )hshValues.get("txt_bran")))
			.append("~5. In case of Tie up ^").append("~(i) Credit is linked with marketing =").append(SetupParams.getSetupParams("Education",correctNull((String )hshValues.get("cbocredit"))));
			
			if(correctNull((String )hshValues.get("cbocredit")).equals("1"))
			{
				sbAuditTrial.append("~(ii) If yes,name and address of the tie up agency =").append(correctNull((String )hshValues.get("txt_fact")));
			}	
			sbAuditTrial.append("~(iii) Whether an Agreement letter from the factory in the prescribed proforma has been obtained / deposited and our lien over sale proceeds payable to applicant has been got registered.  =")
			.append(SetupParams.getSetupParams("Education",correctNull((String )hshValues.get("cboagree"))));
			
			if(correctNull((String )hshValues.get("cboagree")).equals("1"))
			{
				sbAuditTrial.append("~(iv) If yes,Agreement No.and date =").append(correctNull((String )hshValues.get("txt_agr"))).append(" ").append(correctNull((String )hshValues.get("txt_receivedRH")));
			}
			
			
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
				
		}
			AuditTrial.auditLog(hshValues, "219", appno, sbAuditTrial.toString());	
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
	}

	public  HashMap gettechdetails(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		String recordflag="N";
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agrgettechdetails^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				recordflag="Y";
				hshResult.put("txt_grown",correctNull(rs2.getString("tech_grown")));
				hshResult.put("cbofacilities",correctNull(rs2.getString("tech_facilities")));
				hshResult.put("txt_adequate",correctNull(rs2.getString("tech_adequate")));
				hshResult.put("txt_supply",correctNull(rs2.getString("tech_supply")));
				hshResult.put("txt_produce",correctNull(rs2.getString("tech_produce")));
				hshResult.put("txt_barns",correctNull(rs2.getString("tech_barns")));
				hshResult.put("txt_dimensions",correctNull(rs2.getString("tech_dimensions")));
				hshResult.put("txt_loc",correctNull(rs2.getString("tech_loc")));
				hshResult.put("txt_bran",correctNull(rs2.getString("tech_bran")));
				hshResult.put("cbocredit",correctNull(rs2.getString("tech_credit")));
				hshResult.put("txt_fact",correctNull(rs2.getString("tech_fact")));
				hshResult.put("cboagree",correctNull(rs2.getString("tech_agree")));
				hshResult.put("txt_agr",correctNull(rs2.getString("tech_agreeno")));
				String txt_receivedRH=correctNull(rs2.getString("tech_receivedRH"));
				if(txt_receivedRH.equalsIgnoreCase("01/01/1900"))
				{
					txt_receivedRH ="";
				}
				else
				{
					hshResult.put("txt_receivedRH",correctNull(rs2.getString("tech_receivedRH")));
				}
				hshResult.put("address",correctNull(rs2.getString("tech_address")));
				hshResult.put("cbougc",correctNull(rs2.getString("tech_ugc")));
				recordflag="Y";
				
				hshResult.put("recordflag",recordflag);
			}		  
			if(rs2 != null)
			{
				rs2.close();
			}
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs2 = DBUtils.executeQuery(strQuery);
			if (rs2.next())
			{
				hshResult.put("appname", Helper.correctDoubleQuote(correctNull(rs2.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs2.getString("app_status"))));
				hshResult.put("applicantid", rs2.getString("demo_appid"));
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally 
		{
			try 
			{
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
	}
	
	public void updatecoffeehypo(HashMap hshValues) 
	{
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		//String appno1=correctNull((String)hshValues.get("appno1"));
		String strappno=correctNull((String)hshValues.get("strappno"));
		String strAction=null;//String strAction1=null;
		strAction = correctNull((String) hshValues.get("hidAction"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_item= null;
		String[] txt_cherry1 = null;
		String[] txt_item1 = null;
		String[] txt_cherry2 = null;
		String[] txt_item2= null;
		String[] txt_fer= null;
		String[] txt_wage = null;
		String[] txt_other = null;
		String[] txt_totother1 = null;
		String[] txt_area = null;
		String[] txt_cost = null;
		String[] txt_totseason= null;
		String[] txt_guntas= null;
		String year1="";
		String year2="";
		year1 = correctNull((String)hshValues.get("txt_year1"));
		year2 = correctNull((String)hshValues.get("txt_year2"));
		
		/*if(appno.equalsIgnoreCase(""))
		{
			appno=appno1;
		}*/
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		int intUpdatesize = 0;	//int intUpdatesize1 = 0;
		try
		{
			txt_item = (String[]) hshValues.get("txt_item");
			txt_cherry1= (String[])hshValues.get("txt_cherry1");
			txt_item1= (String[])hshValues.get("txt_item1");
			txt_cherry2 = (String[])hshValues.get("txt_cherry2");
			txt_totseason=(String[])hshValues.get("txt_totseason");
			//crop
			
			txt_item2 = (String[])hshValues.get("txt_item2");
			txt_fer = (String[])hshValues.get("txt_fer");
			txt_wage= (String[])hshValues.get("txt_wage");
			txt_other= (String[])hshValues.get("txt_other");
			txt_totother1 = (String[])hshValues.get("txt_totother1");
			txt_area = (String[])hshValues.get("txt_area");
			txt_cost= (String[])hshValues.get("txt_cost");
			txt_guntas = (String[])hshValues.get("txt_guntas");
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
			//	HashMap hshQueryValues4 = new HashMap();
			//	ArrayList arrValues4 = new ArrayList();
				hshQuery3.put("strQueryId", "per_del_coffeedetails");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			
			
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "per_del_coffeedetails");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			intUpdatesize = 1;
			for (int i = 0; i < txt_item.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "per_ins_coffeedetails");
				arrValues.add(appno);
				if(txt_item[i].equalsIgnoreCase(""))
				{
					txt_item[i] = "";
				}
				arrValues.add(txt_item[i]);
				if(txt_cherry1[i].equalsIgnoreCase(""))
				{
					txt_cherry1[i] = "";
				}
				arrValues.add(txt_cherry1[i]);
			
				if(txt_item1[i].equalsIgnoreCase(""))
				{
					txt_item1[i] = "";
				}
				arrValues.add(txt_item1[i]);
				if(txt_cherry2[i].equalsIgnoreCase(""))
				{
					txt_cherry2[i] = "";
				}				
				arrValues.add(txt_cherry2[i]);
				if(txt_totseason[i].equalsIgnoreCase(""))
				{
					txt_totseason[i] = "";
				}
				arrValues.add(txt_totseason[i]);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("0");
				arrValues.add("0.00");
				arrValues.add(year1);
				arrValues.add(year2);
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			intUpdatesize = 1;
			for (int i = 0; i < txt_item2.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "per_ins_coffeedetails");
				arrValues.add(appno);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				if(txt_item2[i].equalsIgnoreCase(""))
				{
					txt_item2[i] = "";
				}
				arrValues.add(txt_item2[i]);
				if(txt_fer[i].equalsIgnoreCase(""))
				{
					txt_fer[i] = "";
				}
				arrValues.add(txt_fer[i]);
			
				if(txt_wage[i].equalsIgnoreCase(""))
				{
					txt_wage[i] = "";
				}
				arrValues.add(txt_wage[i]);
				if(txt_other[i].equalsIgnoreCase(""))
				{
					txt_other[i] = "";
				}
				arrValues.add(txt_other[i]);
				if(txt_totother1[i].equalsIgnoreCase(""))
				{
					txt_totother1[i] = "";
				}
				arrValues.add(txt_totother1[i]);
				if(txt_area[i].equalsIgnoreCase(""))
				{
					txt_area[i] = "0";
				}
				arrValues.add(txt_area[i]);
				if(txt_cost[i].equalsIgnoreCase(""))
				{
					txt_cost[i] = "";
				}
				arrValues.add(txt_cost[i]);
				arrValues.add(year1);
				arrValues.add(year2);
				if(txt_guntas[i].equalsIgnoreCase(""))
				{
					txt_guntas[i] = "0";
				}
				arrValues.add(txt_guntas[i]);
			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			}
			
			/*------------------Audit Trial Start--------------------------*/
			StringBuilder sbAt = new StringBuilder();
			sbAt.append(" ~ Estimated Crop for =  ").append("20"+year1+"-"+"20"+year2);
						
			for (int i = 0; i < txt_item.length; i++)
			{
				
				if(txt_item[i].equalsIgnoreCase(""))
				{
					txt_item[i] = "";
				}
				sbAt.append(" ~ Arabica-Parachment = ").append(txt_item[i]);
				if(txt_cherry1[i].equalsIgnoreCase(""))
				{
					txt_cherry1[i] = "";
				}
				
				sbAt.append(" ~ Arabica-Cherry = ").append(txt_cherry1[i]);
			
				if(txt_item1[i].equalsIgnoreCase(""))
				{
					txt_item1[i] = "";
				}
				sbAt.append(" ~ Robusta-Parachment = ").append(txt_item1[i]);
				
				if(txt_cherry2[i].equalsIgnoreCase(""))
				{
					txt_cherry2[i] = "";
				}	
				sbAt.append(" ~ Robusta-Cherry = ").append(txt_cherry2[i]);
				
				if(txt_totseason[i].equalsIgnoreCase(""))
				{
					txt_totseason[i] = "";
				}
				sbAt.append(" ~ Estimated Value (Rs.)-Total = ").append(txt_totseason[i]);
			}
			AuditTrial.auditLog(hshValues,"1300",appno,sbAt.toString());
			/*------------------Audit Trial End--------------------------*/
			
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
	
	public  HashMap getcoffeehypo(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		//ArrayList arryRow1 = new ArrayList();
		double netitem=0.00;double netitem1=0.00;
		double netcherry1=0.00;double netcherry2=0.00;double nettotseason=0.00;
		//ArrayList arryCol1 = null;
 		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}							 
			strQuery = SQLParser.getSqlQuery("per_get_coffeedetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("item"));
				netitem=  netitem + Double.parseDouble((Helper.correctDouble((String)rs.getString("item"))));
			    arryCol.add(rs.getString("cherry1"));
				netcherry1=  netcherry1+ Double.parseDouble((Helper.correctDouble((String)rs.getString("cherry1"))));
				arryCol.add(rs.getString("item1"));
				netitem1=  netitem1 + Double.parseDouble((Helper.correctDouble((String)rs.getString("item1"))));
				arryCol.add(rs.getString("cherry2"));
				netcherry2=  netcherry2 + Double.parseDouble((Helper.correctDouble((String)rs.getString("cherry2"))));
				arryCol.add(rs.getString("totseason"));
				nettotseason= nettotseason+ Double.parseDouble((Helper.correctDouble((String)rs.getString("totseason"))));
				
				arryCol.add(rs.getString("item2"));
				arryCol.add(rs.getString("fertilizer"));
				arryCol.add(rs.getString("wage"));
				arryCol.add(rs.getString("other"));
				arryCol.add(rs.getString("total"));
				arryCol.add(rs.getString("area"));
				arryCol.add(rs.getString("cost"));
				arryCol.add(rs.getString("year1"));
				arryCol.add(rs.getString("year2"));
				arryCol.add(rs.getString("acre"));
				
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			if(rs1!= null)
			{
				rs1.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("netitem", Helper.formatDoubleValue(netitem));
			hshRecord.put("netitem1", Helper.formatDoubleValue(netitem1));
			hshRecord.put("netcherry1", Helper.formatDoubleValue(netcherry1));
			hshRecord.put("netcherry2", Helper.formatDoubleValue(netcherry2));
			hshRecord.put("nettotseason", Helper.formatDoubleValue(nettotseason));
			hshRecord.put("arryRow", arryRow);
		    hshRecord.put("PageType", PageType);
			
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
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
					rs2 = null;
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}		
//namrata agri fr assesment
	public HashMap getcropAssesmentData(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String scrop_date="";
        ArrayList vecData = new ArrayList();
        ArrayList vecRec1 = new ArrayList();
        ArrayList vecData1 = new ArrayList();
        ArrayList vecRec2 = new ArrayList();
        ArrayList vecData2 = new ArrayList();
        ArrayList vecRec3 = new ArrayList();
        ArrayList vecData3 = new ArrayList();
        ArrayList vecRec4 = new ArrayList();
        ArrayList vecData4 = new ArrayList();
        ArrayList vecRec5 = new ArrayList();
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropname_kh^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData = new ArrayList();
			//String crop_irrigated1="";
			while (rs1.next()) 
			{
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs1.getString("crop_season")));
				vecRec1.add(correctNull(rs1.getString("crop_season1")));
				vecRec1.add(correctNull(rs1.getString("crop_total_area")));
				vecRec1.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec1.add(correctNull(rs1.getString("crop_acre")));
				vecRec1.add(correctNull(rs1.getString("crop_avg_yeild")));
				vecRec1.add(correctNull(rs1.getString("crop_value")));
				String crop_irrigated=correctNull(rs1.getString("crop_irrigated"));
				
				if(crop_irrigated.equalsIgnoreCase("1 "))
				{
					crop_irrigated="irrigated";
				}
				if(crop_irrigated.equalsIgnoreCase("2 "))
				{
					crop_irrigated="rainfed";
				}
				vecRec1.add(crop_irrigated);
				vecRec1.add(correctNull(rs1.getString("crop_cost")));
				vecRec1.add(correctNull(rs1.getString("crop_area")));
				
				vecData.add(vecRec1);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			//int vecsize1 = vecData.size();
		 	strQuery = SQLParser.getSqlQuery("per_get_cropname_rb^"+appno);
		  	rs1 = DBUtils.executeQuery(strQuery);
		  	vecData1 = new ArrayList();
		
			while (rs1.next()) 
			{
				vecRec2 = new ArrayList();
				vecRec2.add(correctNull(rs1.getString("crop_season")));
				vecRec2.add(correctNull(rs1.getString("crop_season1")));
				vecRec2.add(correctNull(rs1.getString("crop_total_area")));
				vecRec2.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec2.add(correctNull(rs1.getString("crop_acre")));
				vecRec2.add(correctNull(rs1.getString("crop_avg_yeild")));
				vecRec2.add(correctNull(rs1.getString("crop_value")));
				String crop_irrigated=correctNull(rs1.getString("crop_irrigated"));
				
				if(crop_irrigated.equalsIgnoreCase("1 "))
				{
					crop_irrigated="irrigated";
				}
				if(crop_irrigated.equalsIgnoreCase("2 "))
				{
					crop_irrigated="rainfed";
				}
				vecRec2.add(crop_irrigated);
				vecRec2.add(correctNull(rs1.getString("crop_cost")));
				vecRec2.add(correctNull(rs1.getString("crop_area")));
				
				vecData1.add(vecRec2);
			}
			//int vecsize2= vecData1.size();
			
			if (rs1 != null)
		    {
				 rs1.close();
		    }
			strQuery = SQLParser.getSqlQuery("per_get_cropname_su^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData2 = new ArrayList();
					
			while (rs1.next()) 
			{
				vecRec3= new ArrayList();
				vecRec3.add(correctNull(rs1.getString("crop_season")));
				vecRec3.add(correctNull(rs1.getString("crop_season1")));
				vecRec3.add(correctNull(rs1.getString("crop_total_area")));
				vecRec3.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec3.add(correctNull(rs1.getString("crop_acre")));
				vecRec3.add(correctNull(rs1.getString("crop_avg_yeild")));
				vecRec3.add(correctNull(rs1.getString("crop_value")));
				String crop_irrigated=correctNull(rs1.getString("crop_irrigated"));
				
				if(crop_irrigated.equalsIgnoreCase("1 "))
				{
					crop_irrigated="irrigated";
				}
				if(crop_irrigated.equalsIgnoreCase("2 "))
				{
					crop_irrigated="rainfed";
				}
				vecRec3.add(crop_irrigated);
				vecRec3.add(correctNull(rs1.getString("crop_cost")));
				vecRec3.add(correctNull(rs1.getString("crop_area")));
				
				vecData2.add(vecRec3);
			}
			if(rs1 != null)
			{
				rs1.close();
			}
			//int vecsize3 = vecData2.size();
		    strQuery = SQLParser.getSqlQuery("per_get_cropname_an^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData3 = new ArrayList();
			
			while (rs1.next()) 
			{
				vecRec4 = new ArrayList();
				vecRec4.add(correctNull(rs1.getString("crop_season")));
				vecRec4.add(correctNull(rs1.getString("crop_season1")));
				vecRec4.add(correctNull(rs1.getString("crop_total_area")));
				vecRec4.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec4.add(correctNull(rs1.getString("crop_acre")));
				vecRec4.add(correctNull(rs1.getString("crop_avg_yeild")));
				vecRec4.add(correctNull(rs1.getString("crop_value")));
				String crop_irrigated=correctNull(rs1.getString("crop_irrigated"));
				
				if(crop_irrigated.equalsIgnoreCase("1 "))
				{
					crop_irrigated="irrigated";
				}
				if(crop_irrigated.equalsIgnoreCase("2 "))
				{
					crop_irrigated="rainfed";
				}
				vecRec4.add(crop_irrigated);
				vecRec4.add(correctNull(rs1.getString("crop_cost")));
				vecRec4.add(correctNull(rs1.getString("crop_area")));
				
				vecData3.add(vecRec4);
			}
			//int vecsize4 = vecData3.size();
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropname_pe^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			vecData4 = new ArrayList();
							
			while (rs1.next()) 
			{
				vecRec5 = new ArrayList();
				vecRec5.add(correctNull(rs1.getString("crop_season")));
				vecRec5.add(correctNull(rs1.getString("crop_season1")));
				vecRec5.add(correctNull(rs1.getString("crop_total_area")));
				vecRec5.add(correctNull(rs1.getString("crop_cost_cult")));
				vecRec5.add(correctNull(rs1.getString("crop_acre")));
				vecRec5.add(correctNull(rs1.getString("crop_avg_yeild")));
				vecRec5.add(correctNull(rs1.getString("crop_value")));
				String crop_irrigated=correctNull(rs1.getString("crop_irrigated"));
				
				if(crop_irrigated.equalsIgnoreCase("1 "))
				{
					crop_irrigated="irrigated";
				}
				if(crop_irrigated.equalsIgnoreCase("2 "))
				{
					crop_irrigated="rainfed";
				}
				vecRec5.add(crop_irrigated);
                vecRec5.add(correctNull(rs1.getString("crop_cost")));
                vecRec5.add(correctNull(rs1.getString("crop_area")));
				
				vecData4.add(vecRec5);
			}
			//int vecsize5 = vecData4.size();
			if(rs1 != null)
			{
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("per_get_cropassesment^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("crop_type"));
				arryCol.add(rs.getString("crop_area"));
				arryCol.add(rs.getString("crop_finance"));
				arryCol.add(rs.getString("crop_loanamt"));
				arryCol.add(rs.getString("crop_cult"));
				arryCol.add(rs.getString("crop_yield"));
				arryCol.add(rs.getString("crop_produce"));
				arryCol.add(rs.getString("crop_surplus"));
				arryCol.add(rs.getString("crop_repay"));
			    arryCol.add(rs.getString("crop_name"));
				arryCol.add(rs.getString("crop_eligibility"));
				scrop_date=correctNull((String)rs.getString("crop_date"));
				if(scrop_date.equalsIgnoreCase("01/01/1900"))
				{
					arryCol.add("");
				}
				else
				{
					arryCol.add(scrop_date);
				}
				arryCol.add(rs.getString("crop_remarks"));
				arryRow.add(arryCol);
			}
			if(rs != null)
			{
				rs.close();
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("vecData",vecData);
			hshRecord.put("vecData1",vecData1);
			hshRecord.put("vecData2",vecData2);
			hshRecord.put("vecData3",vecData3);
			hshRecord.put("vecData4",vecData4);
			hshRecord.put("PageType", PageType);
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
			}
			if(rs != null)
			{
				rs.close();
			}
		} 
		catch (Exception ce)
		{
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
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap updatecropAssesmentData(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		String strAction1 = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String txt_total_amount1 = correctNull((String) hshValues.get("txt_total_amount1"));
		String  txt_total_amount2 = correctNull((String) hshValues.get("txt_total_amount2"));
		String  txt_total_amount3= correctNull((String) hshValues.get("txt_total_amount3"));
		String  txt_total_amount4 = correctNull((String) hshValues.get("txt_total_amount4"));
		String  txt_total_amount5 = correctNull((String) hshValues.get("txt_total_amount5"));
				
		try 
		{
			String[] txt_crop = null;
			String[] txt_area = null;
			String[] txt_finance = null;
			String[] txt_amount = null;
			//String[] txt_cult = null;
			String[] txt_yield = null;
			String[] txt_produce = null;
			String[] txt_surplus = null;
			String[] txt_repay = null;
			String[] txt_eligibility = null;
			String[] txt_date = null;
			String[] txt_remarks = null;
			String[] txt_amount1 = null;
			txt_crop = (String[]) hshValues.get("txt_crop");
			txt_area = (String[]) hshValues.get("txt_area");
			txt_finance = (String[]) hshValues.get("txt_finance");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			//txt_cult = (String[]) hshValues.get("txt_cult");
            txt_yield = (String[]) hshValues.get("txt_yield");
			txt_produce = (String[]) hshValues.get("txt_produce");
			txt_surplus = (String[]) hshValues.get("txt_surplus");
			txt_repay = (String[]) hshValues.get("txt_repay");
			txt_eligibility = (String[]) hshValues.get("txt_eligibility");
			txt_date = (String[]) hshValues.get("txt_date");
			txt_remarks = (String[]) hshValues.get("txt_remarks");
			txt_amount1= (String[]) hshValues.get("txt_amount1");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs != null)
			{
				rs.close();
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_cropassesment");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction1.equals("delete1"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_cropassesment");
				arrValues5.add(appno);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}
			if(strAction1.equalsIgnoreCase("insert1"))
			{
				hshQuery= new HashMap();
				 arrValues = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_cropassesment");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(txt_total_amount1);
				arrValues.add(txt_total_amount2);
				arrValues.add(txt_total_amount3);
				arrValues.add(txt_total_amount4);
				arrValues.add(txt_total_amount5);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_cropassesment");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_cropassesment");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_cropassesment");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				if(rs != null)
				{
					rs.close();
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_amount.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_cropassesment");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("k1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("k1");
					}
					if (i + 1 == 3)
					{
						arrValues.add("k1");
					}
					if (i + 1 == 4)
					{
						arrValues.add("r1");
					}
					if (i + 1 == 5) 
					{
						arrValues.add("r1");
					}
					if (i + 1 == 6) 
					{
						arrValues.add("r1");
					}
					if (i + 1 == 7) 
					{
						arrValues.add("s1");
					}
					if (i + 1 == 8)
					{
						arrValues.add("s1");
					}
					if (i + 1 == 9)
					{
						arrValues.add("s1");
					}
					if (i + 1 == 10)
					{
						arrValues.add("a1");
					}
					if (i + 1 == 11) 
					{
						arrValues.add("a1");
					}
					if (i + 1 == 12)
					{
						arrValues.add("a1");
					}
					if (i + 1 == 13)
					{
						arrValues.add("p1");
					}
					if (i + 1 == 14)
					{
						arrValues.add("p1");
					}
					if (i + 1 == 15) 
					{
						arrValues.add("p1");
					}
					
					
					if (correctNull(txt_area[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area[i]));
					}
					if (correctNull(txt_finance[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_finance[i]));
					}
					if (correctNull(txt_amount[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					if (correctNull(txt_yield[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_yield[i]));
					}
					if (correctNull(txt_produce[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_produce[i]));
					}
					if (correctNull(txt_surplus[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_surplus[i]));
					}
					if (correctNull(txt_repay[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_repay[i]));
					}						
					arrValues.add(correctNull(txt_crop[i]));
					if (correctNull(txt_eligibility[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_eligibility[i]));
					}
					if (correctNull(txt_date[i]).equals(""))
					{
						arrValues.add("01/01/1900");
					} 
					else 
					{
						arrValues.add(correctNull(txt_date[i]));
					}
					
					arrValues.add(correctNull(txt_remarks[i]));	
					if (correctNull(txt_amount1[i]).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_amount1[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			hshpasValues.put("appno", appno);
			hshResult = getcropAssesmentData(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
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
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getcattlechartdetails(HashMap hshValues)  
	{
		
		HashMap hshResult = new HashMap();
		
		ArrayList arrcattledetails=new ArrayList();
		ArrayList arrcattle=new ArrayList();
		
		String strQuery="";
		String strappno="";
			
		ResultSet rs=null;
		
	    try
	    {
	    	strappno = correctNull((String) hshValues.get("strappno"));
			if(strappno.equalsIgnoreCase(""))
			{
				strappno = correctNull((String)hshValues.get("appno"));
			}
					
			strQuery = SQLParser.getSqlQuery("agrselcattlechart^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) 
			{
				arrcattledetails=new ArrayList();
				arrcattledetails.add("");
				arrcattledetails.add(rs.getString("YEAR"));
				arrcattledetails.add(rs.getString("ADULTONE"));
				arrcattledetails.add(rs.getString("FEMALECALVES"));
				arrcattledetails.add(rs.getString("MALECALVES"));
				arrcattle.add(arrcattledetails);
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting data "+ e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getcattlechartdetails - agrcropsBean  "+ exp.toString()); 
			}
		}
		hshResult.put("arrcattle",arrcattle);
		return hshResult;
	}
	
	
	private String getCalcuatedTotalAcerage(int intAcerage,int intCentGuntas, String strLandMeasureType) 
	{
		
		/*
		
		strQuery=SQLParser.getSqlQuery("agrsel_totland^"+appno+"^3");
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
			int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
			hshRecord.put("totsummeracre",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
		}
		
		strQuery=SQLParser.getSqlQuery("agrsel_totland^"+appno+"^1");
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
			int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
			hshRecord.put("totkarifacre",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
		}
		
		strQuery=SQLParser.getSqlQuery("agrsel_totland^"+appno+"^2");
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
			int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
			hshRecord.put("totrabiacre",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
		}
		
		strQuery=SQLParser.getSqlQuery("agrsel_totland^"+appno+"^5");
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
			int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
			hshRecord.put("totperinnialacre",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
		}
		strQuery=SQLParser.getSqlQuery("agrsel_totland^"+appno+"^4");
		rs2 = DBUtils.executeQuery(strQuery);
		if(rs2.next())
		{
			int intacerage=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage")));
			int intarea=Integer.parseInt(Helper.correctInt(rs2.getString("tot_acerage1")));
			hshRecord.put("totannaulacre",getCalcuatedTotalAcerage(intacerage,intarea,strLandMeasurement));
		}*/
		double dblTotalAcre=0.0;
		String strTotalAcre="";
		String strTotalarea="";
		double dblCentGuntasrem=0;
		int intCentGuntasQuot=0;
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getNumberInstance();
		jtn.setMinimumIntegerDigits(0);
		jtn.setMinimumIntegerDigits(0);
		jtn.setGroupingUsed(false);
		
		try{
			if(strLandMeasureType.equalsIgnoreCase("c"))
			{
				dblCentGuntasrem=intCentGuntas%100;
				intCentGuntasQuot=intCentGuntas/100;
				dblTotalAcre=intAcerage+intCentGuntasQuot;
			}
			else if(strLandMeasureType.equalsIgnoreCase("g"))
			{
				dblCentGuntasrem=intCentGuntas%40;
				intCentGuntasQuot=intCentGuntas/40;
				dblTotalAcre=intAcerage+intCentGuntasQuot;
			}
			
			strTotalAcre=jtn.format(dblTotalAcre);
			strTotalarea=jtn.format(dblCentGuntasrem);
			
			if(strTotalarea.length()==1)
			{
				strTotalAcre=strTotalAcre+".0"+strTotalarea;
			}
			else
			{
				strTotalAcre=strTotalAcre+"."+strTotalarea;
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return strTotalAcre;
	}
	
	public void updateCropAssessmentDetails(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		HashMap hshRecord = new HashMap();

		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String appno="";
		String strfacilitiysno="";  
		String strschemetype="";  
		String strmeastype="";  
		String strSeasonId=null;
		String schemetype = correctNull((String)hshValues.get("schemetype"));
	
		HashMap schemetype1 = (HashMap) Helper.splitScheme((String)hshValues.get("schemetype"));
		strfacilitiysno=Helper.correctNull((String)schemetype1.get("facility_sno"));
		strschemetype=Helper.correctNull((String)schemetype1.get("facility_schemetype"));
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("strappno"));
		}
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("appno"));
		}
		strSeasonId=Helper.correctNull((String)hshValues.get("txt_season"));
		if(strSeasonId.equalsIgnoreCase(""))
		{
			strSeasonId="0";
		}
		try
		{
				if(strAction.equals("update"))
				{											
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agrcropassessment_update");	
					strmeastype=Helper.correctNull((String )hshValues.get("sel_meatype"));
					
					if(Helper.correctNull((String )hshValues.get("sel_assessment")).equalsIgnoreCase("130"))
					{
						arrValues.add(strSeasonId);
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_crop")));
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_sowmonth")));
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_harvmonth")));
						if(strmeastype.equals("2"))
						{
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_areaofcult")));
						}
						else
						{
							arrValues.add("0");
						}
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_amount")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_eligibility")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitappl")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitrecom")));
						if(Helper.correctNull((String )hshValues.get("txt_repay")).equalsIgnoreCase(""))
							arrValues.add(null);
						else
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_repay")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofcultivation")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_state")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_district")));
						arrValues.add(Helper.correctNull((String )hshValues.get("sel_plantName")));
						if(strmeastype.equals("1"))
						{
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_areaofcult")));
						}
						else
						{
							arrValues.add("0");
						}
						arrValues.add(strmeastype);
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_scloffin")));	//hid_scaleoffin
						arrValues.add(strschemetype); 
						arrValues.add(Helper.correctNull((String )hshValues.get("sel_assessment")));
					}
					else
					{
						arrValues.add("");
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_natureofactivity")));
						arrValues.add("");
						arrValues.add("");
						arrValues.add("0");
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_sof_value")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_sof_eligibility")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitappl1")));
						arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitrecom1")));
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_sof_unitvalue")));
						arrValues.add(Helper.correctNull((String )hshValues.get("txt_sof_unit")));
						arrValues.add("0");
						arrValues.add(Helper.correctNull((String )hshValues.get("hid_scaleoffin")));		
						arrValues.add(strschemetype); 
						arrValues.add(Helper.correctNull((String )hshValues.get("sel_assessment")));
					}
					arrValues.add(appno);
					arrValues.add(Helper.correctNull((String )hshValues.get("idno")));	
					arrValues.add(strfacilitiysno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);

					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				else if(strAction.equals("insert"))
				{								
						strGradeId = Integer.toString(getMaxId("agrcropassessmentmaxid_sel^"+appno));
						hshQueryValues = new HashMap(); 
						hshQuery = new HashMap();					
						hshQueryValues.put("size","1");	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","agrcropassessment_insert");
						arrValues.add(appno);
						if(Helper.correctNull((String )hshValues.get("sel_assessment")).equalsIgnoreCase("130"))
						{
							strmeastype=Helper.correctNull((String )hshValues.get("sel_meatype"));
							arrValues.add(strSeasonId);
							arrValues.add(strGradeId);
							
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_crop")));
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_sowmonth")));
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_harvmonth")));
							if(strmeastype.equals("2"))
							{
								arrValues.add(Helper.correctNull((String )hshValues.get("txt_areaofcult")));
							}
							else
							{
								arrValues.add("0");
							}
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_amount")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_eligibility")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitappl")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitrecom")));
							if(Helper.correctNull((String )hshValues.get("txt_repay")).equalsIgnoreCase(""))
								arrValues.add(null);
							else
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_repay")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_costofcultivation")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_state")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_district")));
							arrValues.add(Helper.correctNull((String )hshValues.get("sel_plantName")));
							if(strmeastype.equals("1"))
							{
								arrValues.add(Helper.correctNull((String )hshValues.get("txt_areaofcult")));
							}
							else
							{
								arrValues.add("0");
							}
							arrValues.add(strmeastype);
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_scloffin")));
						}
						else
						{
							arrValues.add("");
							arrValues.add(strGradeId);
							
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_natureofactivity")));
							arrValues.add("");
							arrValues.add("");
							arrValues.add("0");
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_sof_value")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_sof_eligibility")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitappl1")));
							arrValues.add(Helper.correctDouble((String )hshValues.get("txt_limitrecom1")));
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_sof_unitvalue")));
							arrValues.add(Helper.correctNull((String )hshValues.get("txt_sof_unit")));
							arrValues.add("0");
							arrValues.add(Helper.correctNull((String )hshValues.get("hid_scaleoffin")));
						}
						arrValues.add(strschemetype); 
						arrValues.add(strfacilitiysno);
						arrValues.add(Helper.correctNull((String )hshValues.get("sel_assessment")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
				}
				else if(strAction.equals("delete"))
				{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");					
					hshQuery.put("strQueryId","agrcropassessment_delete1");
					arrValues.add(appno);
					arrValues.add(strfacilitiysno);
					arrValues.add(strschemetype);
					arrValues.add(Helper.correctNull((String )hshValues.get("sel_assessment")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "delete_croploan_details");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", "2");
					hshQueryValues.put("2", hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
	
			/*StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("~Season ID= ").append(Helper.correctNull((String )hshValues.get("strSeasonId")))
			.append("~SNo= ").append(Helper.correctNull((String )hshValues.get("strGradeId")))
			.append("~Crop/Plant= ").append(Helper.correctNull((String )hshValues.get("txt_crop")))
			.append("~Sow Month= ").append(Helper.correctNull((String )hshValues.get("txt_sowmonth")))
			.append("~Harvest Month= ").append(Helper.correctNull((String )hshValues.get("txt_harvmonth")))
			.append("~Area of Cultivation= ").append(Helper.correctNull((String )hshValues.get("txt_areaofcult")))
			.append("~Scale of Finance= ").append(Helper.correctDouble((String )hshValues.get("txt_amount")))
			.append("~Eligibility= ").append(Helper.correctDouble((String )hshValues.get("txt_eligibility")))
			.append("~Limit Applied= ").append(Helper.correctDouble((String )hshValues.get("txt_limitappl")))
			.append("~Limit Recommended= ").append(Helper.correctDouble((String )hshValues.get("txt_limitrecom")))
			.append("~Due Date of Repayment= ").append(Helper.correctNull((String )hshValues.get("txt_repay")))
			.append("~Cost of Cultivation= ").append(Helper.correctDouble((String )hshValues.get("txt_costofcultivation")))
			.append("~State= ").append(Helper.correctNull((String )hshValues.get("txt_state")))
			.append("~District= ").append(Helper.correctDouble((String )hshValues.get("txt_district")))
			.append("~Plant Name= ").append(Helper.correctDouble((String )hshValues.get("sel_plantName")));
			
			AuditTrial.auditLog(hshValues,"211",appno,sbAuditTrial.toString());*/
	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting data "+ e.getMessage());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateCropAssessmentDetails - agrcropsBean  "+ exp.toString()); 
			}
		}
	
		
	}
	
	public HashMap getCropAssessmentDetails(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		String appno=null;
		ArrayList arrCropAssessment=null;
		String strPage="";
		String strPages[]=null;
		String strAppId="";
		String strfacilitiysno="";
		String strschemetype="";
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		HashMap schemetype1 = (HashMap) Helper.splitScheme((String)hshValues.get("schemetype"));
		strfacilitiysno=Helper.correctNull((String)schemetype1.get("facility_sno"));
		strschemetype=Helper.correctNull((String)schemetype1.get("facility_schemetype"));
		hshRecord.put("hidSeqNo",Helper.correctNull((String)hshValues.get("hidSeqNo"))); //Parent ID
		try
		{
				appno=Helper.correctNull((String)hshValues.get("strappno")).trim();
				if(appno.equalsIgnoreCase(""))
				{
					appno=Helper.correctNull((String)hshValues.get("appno")).trim();
				}
				if(rs!=null){rs.close();}
				
				if (hshValues.get("pagename") instanceof String[]) {
					
					strPages = (String[]) hshValues.get("pagename");
					strPage=Helper.correctNull(strPages[0]);
				}else{
					strPage= Helper.correctNull((String)hshValues.get("pagename"));
				}
				if(strPage.equalsIgnoreCase("ritu"))
				{
					strAppId=correctNull((String)hshValues.get("hid_comappid2"));
					if (strAppId.trim().equals("") || strAppId.equalsIgnoreCase("null")) {
						strAppId = correctNull((String) hshValues.get("hidDemoId"));
			 		}
					
					if (strAppId.trim().equals("") || strAppId.equalsIgnoreCase("null")) {
						strAppId = correctNull((String) hshValues.get("hidapplicantid"));
			 		}
					arrCropAssessment= new AgrCropAssessmentBO().getRytuCorpAssessmentByAppNo(appno,strAppId,strschemetype,strfacilitiysno);
				}else{
					arrCropAssessment= new AgrCropAssessmentBO().getCorpAssessmentByAppNo(appno,strschemetype,strfacilitiysno);
				}
				hshRecord.put("arrData",arrCropAssessment);
				if(Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("aQ"))
				{
					ArrayList arrLandHoldings = new ArrayList();
					ArrayList arrCol = new ArrayList();
					arrLandHoldings = new AgrLandHoldingsBO().getLandHodingsByAppNo(appno);
					if(arrLandHoldings!=null && arrLandHoldings.size()>0){
					for(int i=0;i<arrLandHoldings.size();i++)
					{
						arrCol = new ArrayList();
						arrCol = (ArrayList)arrLandHoldings.get(i);
						for(int j=0;j< arrCol.size();j++){
							if(arrCol.get(20).equals("1")){
								hshRecord.put("strAllied","Yes");}
						}
					}}
				}
				if(rs!=null){rs.close();}
				
				rs = DBUtils.executeLAPSQuery("agrcropassessment_select^"+appno+"^"+strschemetype+"^"+strfacilitiysno);
				if(rs.next())
				{
					hshRecord.put("strAssessmentFor",Helper.correctNull(rs.getString("agr_cas_assessmenttype")));
				}
			
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting data "+ e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getCropAssessmentDetails - agrcropsBean  "+ exp.toString()); 
			}
		}
		return hshRecord;
	}		

	private int getMaxId(String strQuery)
	{
		ResultSet rs = null;
		int seqId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery(strQuery);
			
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					seqId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					seqId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting data "+ e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getMaxId - agrcropsBean  "+ exp.toString()); 
			}
		}
		return seqId;
	}
	public void updatefarmMechMinorIrrig(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String pagetype=null;
		String strAction=(String)hshValues.get("hidAction");
		String appno= Helper.correctNull((String)hshValues.get("appno"));
		String schemetype = correctNull((String)hshValues.get("schemetype"));	
		String strfacsno="";
		
		HashMap hshScheme = new HashMap();
		hshScheme = Helper.splitScheme(schemetype);
		
		if(hshScheme!=null)
		{
			strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
			schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		}
		
		
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno= Helper.correctNull((String)hshValues.get("strappno"));
		}
		
		pagetype=Helper.correctNull((String)hshValues.get("txt_tabid"));
		
		try
		{			
			if(strAction.equals("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(pagetype);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_minorirrigation_delete");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_minorirrigation_insert");
				arrValues.add(appno);//0
				arrValues.add(pagetype);
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));//Type//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_wellSurveyNo")));//location and survey no//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_typeofpropwell")));//3
				
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_boreHeight")));//4
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_boreDiameter")));//5
				
				
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totalcost")));//to change//6
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_liftsource")));//7
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_deepeningcost")));//8
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_wallscost")));//9
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_othercost")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_benefitarea")));//11

				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pumpitem")));//12
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pumpmake")));//13
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pumphp")));//14
				
//				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sourcewater"))); //15
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sourcewater"))); //15
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_tubeelectric")));//16
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_tubecavity")));//17
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tubeboresize")));//18
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_tubedeliverysize")));//19
				arrValues.add(Helper.correctNull((String)hshValues.get("txa_tubewaterexcessusage")));//20
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_surveydept")));//21
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_surveydeptRsn")));//22
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_clearence")));//23
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_clearenceRsn")));//24
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_electricity")));//25
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_document")));//26
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_cropping")));//27
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_croppingRsn")));//28
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_irrigation"))); //29
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_irrigationRsn")));//30
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_waterPropose")));//31
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_waterProposeInc")));//32
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_netamt")));//33
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_exp_additional_income")));//34
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_netamtsource")));//35
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_netamount")));//36
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_elecWorks")));//37
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_elecDrawing")));//38
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_elecDeposit")));//39
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_estcost")));//40
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_groundWater")));//41
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_noofwells")));//42
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_potential")));//43
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_minDistance")));//44
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_margin")));//45
				arrValues.add(schemetype);//46
				arrValues.add(strfacsno);//47
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_timereq")));//48
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_diesel")));//49
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_indlevelofwater")));//50
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_esttotcost_borewell")));//51
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_esttotcost_tubewell")));//52
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_othrexpperannum")));//52
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_minorirrigation_delete");
				arrValues.add(appno);	
				arrValues.add(pagetype);
				arrValues.add(schemetype);
				arrValues.add(strfacsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		/*StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Survey No = ")
			.append(Helper.correctNull((String )hshValues.get("txt_wellSurveyNo")))
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Extent(acres) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_wellExtent")))
			.append("~Location of the proposed well/well to be fitted with proposed I.P/SIP Set / Details of the land which is proposed to be reclaimed or bunded - Ownership = ")
			.append(Helper.correctNull((String )hshValues.get("txt_wellOwner")))
			.append("~If Pond, dimension - Length (feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_pondLength")))
			.append("~If Pond, dimension - Breadth (feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_pondBreadth")))
			.append("~If Pond, dimension - Depth (feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_pondHeight")))
			.append("~Size of Proposed Well - Depth(feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_boreHeight")))
			.append("~Size of Proposed Well - Diameter/Surface = ")
			.append(Helper.correctNull((String )hshValues.get("txt_boreDiameter")))
			.append("~Source of Water = ")
			.append(Helper.correctNull((String )hshValues.get("txt_sourcewater")))
			.append("~Type of Proposed Well = ")
			.append(Helper.correctNull((String )hshValues.get("txt_proposedwell")))
			.append("~Time required for complete the project  = ")
			.append(Helper.correctNull((String )hshValues.get("txt_projectTime")))
			.append("~Depth of water level in summer (feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_summerlevel")))
			.append("~Area to be benefitted in acres = ")
			.append(Helper.correctNull((String )hshValues.get("txt_totIrrigation")))
			.append("~What is the arrangement for lifting the Water from the Well = ")
			.append(Helper.correctNull((String )hshValues.get("txt_arrangeofwater")))
			.append("~Size of Boring pipe(diameter) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_boring")))
			.append("~Size of Delivery Pipe(diameter) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_delivery")))
			.append("~Feasibility Certificate obtained from Ground Water Survey Department = ")
			.append(Helper.correctNull((String )hshValues.get("sel_surveydept")))
			.append("~Clearance certificate from stream / River development = ")
			.append(Helper.correctNull((String )hshValues.get("sel_clearence")))
			.append("~Whether Electricity Board agree to give the electricity Connection = ")
			.append(Helper.correctNull((String )hshValues.get("sel_electricity")));
			if(Helper.correctNull((String )hshValues.get("sel_electricity")).equalsIgnoreCase("1"))
			{
				sbAuditTrial
				.append("~Documents enclosed  =")
				.append(Helper.correctNull((String )hshValues.get("sel_document")));
			}
			sbAuditTrial
			.append("~Whether cropping pattern propose after development is feasible with reference water availability = ")
			.append(Helper.correctNull((String )hshValues.get("sel_cropping")))
			.append("~Whether the water is suitable for irrigation = ")
			.append(Helper.correctNull((String )hshValues.get("sel_irrigation")))
			.append("~Whether project report obtained from competent engineer/dealer = ")
			.append(Helper.correctNull((String )hshValues.get("sel_project")))
			.append("~Whether Spacing norms between Two Wells,Tube Wells is Maintained ? = ")
			.append(Helper.correctNull((String )hshValues.get("sel_tube")));
			if(Helper.correctNull((String )hshValues.get("sel_tube")).equalsIgnoreCase("1"))
			{
			sbAuditTrial.append("~Distance of the proposed well / Bore well to the nearest Well / Bore Well (feet) = ")
			.append(Helper.correctNull((String )hshValues.get("txt_wellDistance")));
			}
			sbAuditTrial
			.append("~Income and Expenses  ^ ")
			.append("~Whether water is proposed to the sold = ")
			.append(Helper.correctNull((String) hshValues.get("sel_waterPropose")));
			if(Helper.correctNull((String) hshValues.get("sel_waterPropose")).equalsIgnoreCase(""))
			{
			sbAuditTrial.append("~Income/Year  = ")
			.append(Helper.correctNull((String) hshValues.get("txt_waterProposeInc")));
			}
			sbAuditTrial
			.append("~Net Income from other sources  = ")
			.append(Helper.correctNull((String) hshValues.get("sel_netamt_text")))
			.append("~Expected Additional Income after proposed Land Development = ")
			.append(Helper.correctNull((String) hshValues.get("txt_exp_additional_income")));
			
			if(Helper.correctNull((String) hshValues.get("sel_netamt_text")).equalsIgnoreCase("Available"))
			{
			sbAuditTrial
			.append("~Specify Sources = ")
			.append(Helper.correctNull((String) hshValues.get("txt_netamtsource")))
			.append("~Amount/Year =")
			.append(Helper.correctNull((String) hshValues.get("txt_netamount")));
			}
			
			sbAuditTrial
			.append("~Electricity/diesel expenses/Annum = ")
			.append(Helper.correctNull((String) hshValues.get("txt_elecWorks")))
			.append("~Cost of Electricity Connection ^")
			.append("~For drawing power lines to Farm  = ")
			.append(Helper.correctNull((String) hshValues.get("txt_elecDrawing")))
			.append("~Deposit to the Power Supplier  = ")
			.append(Helper.correctNull((String) hshValues.get("txt_elecDeposit")))
			;
			
			AuditTrial.auditLog(hshValues,"302",appno,sbAuditTrial.toString());*/
		}
		catch(Exception ce)
		{	
			throw new EJBException("inside update"+ce.toString());
		}
	}
	public  HashMap getfarmMechMinorIrrig(HashMap hshValues) 
	{
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshMinor=new HashMap();
		String strfacsno="";
		
		HashMap hshScheme = new HashMap();
		
		
		try
		{
			String appno	= Helper.correctNull((String )hshValues.get("appno"));
			String pageid = Helper.correctNull((String)hshValues.get("pageid"));
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(schemetype);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}

			String minortype = Helper.correctNull((String)hshValues.get("tabid"));
			
			//hshRecord = new AgrCropAssessmentBO().getMinorIrrigationByAppno(appno);
			
			
			rs=DBUtils.executeLAPSQuery("agr_minorirrigation_select^"+appno+"^"+minortype+"^"+schemetype+"^"+strfacsno);
			if(rs.next())
			{
				hshMinor.put("agr_appno", appno);
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
				hshMinor.put("am_timereq", Helper.correctNull(rs.getString("agr_timereq")));
				hshMinor.put("am_diesel", Helper.correctNull(rs.getString("agr_diesel")));
				hshMinor.put("am_indlevelofwater", Helper.correctNull(rs.getString("agr_indlevelofwater")));
				hshMinor.put("am_esttotcost_borewell", Helper.correctNull(rs.getString("agr_esttotcost_borewell")));
				hshMinor.put("am_esttotcost_tubewell", Helper.correctNull(rs.getString("agr_esttotcost_tubewell")));
				hshMinor.put("am_otherexpperannum", Helper.correctNull(rs.getString("agr_otherexpperannum")));
				
				
				
			}
		}
		catch(Exception ce)
		{	
			throw new EJBException("Error in getfarmMechMinorIrrig "+ce.toString());
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
		return hshMinor;
	}
	
	public void updateSoilReclamation(HashMap hshValues) 
	  {
		    HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;		
			ArrayList arrValues=new ArrayList();
			
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strSoilType= correctNull((String)hshValues.get("soil_type"));
			String strAppno= correctNull((String)hshValues.get("strappno"));
			String strschemetype = correctNull((String)hshValues.get("schemetype"));
			

			String schemetype=Helper.getfacilitySchemetype(strschemetype);
			String strFacSNo=Helper.getfacilitySno(strschemetype);
			
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			ResultSet rs = null;
			
			HashMap hshValuesAgri = new HashMap();
			HashMap hshPhysical = new HashMap();
			
			try
			{			
				if(strAction.equals("delete"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_soilreclamation_delete");
					arrValues.add(strAppno);
					arrValues.add(strSoilType);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					// For deleting in Physical and Financial Programme by Dinesh on 04/03/2014
					
					hshPhysical.put("scheme_sno", "3");		//Soil Reclamation
					hshPhysical.put("scheme_type", schemetype);
					hshPhysical.put("total_cost", "");
					hshPhysical.put("hidAction", "delete");
					hshPhysical.put("appno",strAppno);
					hshPhysical.put("page_id","LL");
					hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				else
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_soilreclamation_delete");
					arrValues.add(strAppno);
					arrValues.add(strSoilType);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_soilreclamation_insert");
					arrValues.add(strAppno);
					arrValues.add(strSoilType);
					arrValues.add(correctNull((String)hshValues.get("txt_limepertonne")));
					arrValues.add(correctNull((String)hshValues.get("txt_nooftonnes")));
					arrValues.add(correctNull((String)hshValues.get("txt_limetotcost")));
					arrValues.add(correctNull((String)hshValues.get("txt_labour")));
					arrValues.add(correctNull((String)hshValues.get("txt_incorporation")));
					arrValues.add(correctNull((String)hshValues.get("txt_flooring")));
					arrValues.add(correctNull((String)hshValues.get("txt_totalcost")));
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					// For inserting in Physical and Financial Programme by Dinesh on 03/03/2014
					
					hshPhysical.put("scheme_sno", "3");		//Soil Reclamation
					hshPhysical.put("scheme_type", schemetype);
					hshPhysical.put("total_cost", correctNull((String)hshValues.get("txt_totalcost")));
					hshPhysical.put("hidAction", "insert");
					hshPhysical.put("appno",strAppno);
					hshPhysical.put("page_id","SR");
					hshPhysical.put("plant_sno","");
					hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
//				---------------------------------------Audittrial------------------------
				/*StringBuilder sbAuditTrial=new StringBuilder();
				
						
				sbAuditTrial.append(
				"~Soil Type = ").append(correctNull((String)hshValues.get("sel_soilType"))).append(
				"~Cost of limestone per tonne = ").append(correctNull((String )hshValues.get("txt_limepertonne"))).append(
				"~No of tonnes = ").append(correctNull((String )hshValues.get("txt_nooftonnes"))).append(
				"~Cost of limestone = ").append(correctNull((String )hshValues.get("txt_limetotcost"))).append(
				"~labour charges-spreading of lime stone= ").append(correctNull((String )hshValues.get("txt_labour"))).append(
				"~Incorporation of limestone = ").append(correctNull((String )hshValues.get("txt_incorporation"))).append(
				"~Flooring charges= ").append(correctNull((String )hshValues.get("txt_flooring"))).append(
				"~Total cost per acre= ").append(correctNull((String )hshValues.get("txt_totalcost")));
				
				AuditTrial.auditLog(hshValues,"258",strAppno,sbAuditTrial.toString());	*/
				//-------------------------------------------End---------------------------
			}
			catch(Exception ce)
			{	throw new EJBException("Error in closing the connection in getMaxId - agrcropsBean  "+ ce.toString());
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
					throw new EJBException("Error in closing the connection in getMaxId - agrcropsBean  "+ cf.toString());
				}
			}
	  }
	/**
	 * Method to get Land Development-Soil Reclamation page
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getSoilReclamation(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshSoil=new HashMap();
		String strAppNo=null;
		ResultSet rs=null;
		String strSoilType =null;
		try {
			 strAppNo=correctNull((String)hshValues.get("appno"));
			 String strschemetype = correctNull((String)hshValues.get("schemetype"));	


			 String schemetype=Helper.getfacilitySchemetype(strschemetype);
			 String strFacSNo=Helper.getfacilitySno(strschemetype);
				if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strappno"));
				}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
				{
					strAppNo = correctNull((String)hshValues.get("strAppno"));
				}
				if(rs!=null)
				{
					rs.close();
					rs=null;
				}
				rs = DBUtils.executeLAPSQuery("agr_landdevelop_assessparam_select^"+strAppNo+"^"+schemetype+"^"+strFacSNo);
				if(rs.next())
				{
					strSoilType=Helper.correctNull(rs.getString("agr_landdevelop_soiltype"));
				}
				
				hshRecord.put("SoilType", strSoilType);
				hshSoil = new AgrCropAssessmentBO().getSoilReclamationByAppno(strAppNo,strSoilType,schemetype,strFacSNo);
		     	hshRecord.put("hshSoil", hshSoil);
				
		} catch (Exception e) {
			throw new EJBException("Error in closing the connection in getMaxId - agrcropsBean  "+ e.toString());
		}
		return hshRecord;
	}
	public void updateDryingYard(HashMap hshValues) 
	  {
		    HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;		
			ArrayList arrValues=new ArrayList();
			
			String strAction= correctNull((String)hshValues.get("hidAction"));
			String strAppno= correctNull((String)hshValues.get("strappno"));
			String strschemeType = correctNull((String)hshValues.get("schemetype"));	
			String schemetype=Helper.getfacilitySchemetype(strschemeType);
			String strFacSNo=Helper.getfacilitySno(strschemeType);
			if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("appno"));
			}
			ResultSet rs = null;
			
			HashMap hshValuesAgri = new HashMap();
			HashMap hshPhysical = new HashMap();
			
			try
			{			
				if(strAction.equals("delete"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					
					hshQuery.put("strQueryId","agr_dryingyard_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					// For deleting in Physical and Financial Programme by Dinesh on 04/03/2014
					
					hshPhysical.put("scheme_sno", "4");		//Drying Yard
					hshPhysical.put("scheme_type", schemetype);
					hshPhysical.put("total_cost", "");
					hshPhysical.put("hidAction", "delete");
					hshPhysical.put("appno",strAppno);
					hshPhysical.put("page_id","LL");
					hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				else
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","agr_dryingyard_delete");
					arrValues.add(strAppno);
					arrValues.add(schemetype);
					arrValues.add(strFacSNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues=new HashMap();
					hshQuery.put("strQueryId","agr_dryingyard_insert");
					arrValues.add(strAppno);	//1
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_area")));//2	
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_floor")));//	3
					arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_cost"))));//4
					arrValues.add(schemetype);
			     	arrValues.add(Helper.correctNull((String)hshValues.get("strschemetypeno")));//	5
			     	arrValues.add(Helper.correctNull((String)hshValues.get("sel_typeflooring")));//6	
			    	arrValues.add(Helper.correctNull((String)hshValues.get("txt_otehr")));//7
			    	arrValues.add(Helper.correctNull((String)hshValues.get("sel_units")));//8
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);	
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					// For inserting in Physical and Financial Programme by Dinesh on 03/03/2014
					
					hshPhysical.put("scheme_sno", "4");		//Drying Yard
					hshPhysical.put("scheme_type", schemetype);
					hshPhysical.put("total_cost", Helper.correctNull((String)hshValues.get("txt_cost")));
					hshPhysical.put("hidAction", "insert");
					hshPhysical.put("appno",strAppno);
					hshPhysical.put("page_id","DY");
					hshPhysical.put("plant_sno","");
					hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
					
				}				
			}
			catch(Exception ce)
			{	
			throw new EJBException("Error in closing the connection in getMaxId - agrcropsBean  "+ ce.toString());
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
			
			public HashMap getDryingYard(HashMap hshValues) 
			{
				HashMap hshRecord=new HashMap();
				String strAppNo=null;
				String strQuery =null;
				ResultSet rs=null;
				ArrayList arrData=new ArrayList();
				ArrayList arrValues;
				String strSchemetype="";
				String strFacSno="";
				
				try 
				{
					String schemetype = correctNull((String)hshValues.get("schemetype"));	
					String sel_typeflooring = correctNull((String)hshValues.get("sel_typeflooring"));	
					
					strSchemetype=Helper.getfacilitySchemetype(schemetype);
					strFacSno=Helper.getfacilitySno(schemetype);
					
					   strAppNo=correctNull((String)hshValues.get("appno"));
					 	if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
						{
							strAppNo = correctNull((String)hshValues.get("strappno"));
						}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
						{
							strAppNo = correctNull((String)hshValues.get("strAppno"));
						}
						if(sel_typeflooring.equals(""))
						{
						strQuery = SQLParser.getSqlQuery("agr_dryingyard_select^"+strAppNo+"^"+strSchemetype+"^"+strFacSno);
						rs = DBUtils.executeQuery(strQuery);
						
								if(rs.next())
								{
									
									hshRecord.put("agr_appno",Helper.correctNull(rs.getString("agr_appno")));	//0
									hshRecord.put("agr_area",Helper.correctDouble(rs.getString("agr_area")));	//1
									hshRecord.put("agr_floor",Helper.correctDouble(rs.getString("agr_floor")));//2
									hshRecord.put("agr_cost",Helper.correctDouble(rs.getString("agr_cost")));//3
									hshRecord.put("agr_Typefloor",Helper.correctDouble(rs.getString("agr_Typefloor")));//4
									hshRecord.put("agr_Typeother",Helper.correctNull(rs.getString("agr_Typeother")));//5
									hshRecord.put("agr_units",Helper.correctNull(rs.getString("agr_units")));//5
									
								   
								}
						}
						else
						{
								
									strQuery = SQLParser.getSqlQuery("agr_dryingyard_selectflooring^"+strAppNo+"^"+strSchemetype+"^"+strFacSno+'^'+sel_typeflooring);
									rs = DBUtils.executeQuery(strQuery);
									if(rs.next())
									{
										
										hshRecord.put("agr_appno",Helper.correctNull(rs.getString("agr_appno")));	//0
										hshRecord.put("agr_area",Helper.correctDouble(rs.getString("agr_area")));	//1
										hshRecord.put("agr_floor",Helper.correctDouble(rs.getString("agr_floor")));//2
										hshRecord.put("agr_cost",Helper.correctDouble(rs.getString("agr_cost")));//3
										hshRecord.put("agr_Typefloor",Helper.correctDouble(rs.getString("agr_Typefloor")));//4
										hshRecord.put("agr_Typeother",Helper.correctNull(rs.getString("agr_Typeother")));//5
										hshRecord.put("agr_units",Helper.correctNull(rs.getString("agr_units")));//5
										
									   
									}
									hshRecord.put("agr_Typefloor",sel_typeflooring);
									
									
								}
			      	   	

				} catch (Exception e) {
					log.error("Error in getDryingYard of agrcropsbean"+e.getMessage());
					throw new EJBException("Error in getDryingYard "+e.toString());
				}
				return hshRecord;
			}
					
	  
			public void updateLandDevelopment(HashMap hshValues) 
			  {
				    HashMap hshQueryValues = new HashMap();
					HashMap hshQuery = null;		
					ArrayList arrValues=new ArrayList();
					
					String strAction= correctNull((String)hshValues.get("hidAction"));
					String strAppno= correctNull((String)hshValues.get("strappno"));
					String strschemetype = correctNull((String)hshValues.get("schemetype"));	
					
					
					String schemetype=Helper.getfacilitySchemetype(strschemetype);
					String strFacSNo=Helper.getfacilitySno(strschemetype);
					if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
					{
						strAppno = correctNull((String)hshValues.get("appno"));
					}
					ResultSet rs = null;
					try
					{			
						if(strAction.equals("delete"))
						{
							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							
							hshQuery.put("strQueryId","agr_landdevelop_assessparam_delete");
							arrValues.add(strAppno);
							arrValues.add(schemetype);
							arrValues.add(strFacSNo);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							
							hshQuery.put("strQueryId","agr_onfarmdevelopment_delete");
							arrValues.add(strAppno);
							arrValues.add(schemetype);
							arrValues.add(strFacSNo);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","agr_sandcasting_delete");
							arrValues.add(strAppno);
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
							arrValues.add(strAppno);
							arrValues.add(schemetype);
							arrValues.add(strFacSNo);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");


							hshQueryValues = new HashMap();
							hshQuery = new HashMap();					
							hshQueryValues.put("size","1");
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","agr_soilreclamation_delete");
							arrValues.add(strAppno);
							arrValues.add(correctNull((String)hshValues.get("sel_soil")));
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
							hshQuery.put("strQueryId","agr_landdevelop_assessparam_delete");
							arrValues.add(strAppno);
							arrValues.add(schemetype);
							arrValues.add(strFacSNo);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues=new HashMap();
							hshQuery.put("strQueryId","agr_landdevelop_assessparam_insert");
							arrValues.add(strAppno);	//1
							arrValues.add(correctNull((String)hshValues.get("sel_slope")));//slope 1		
							arrValues.add(correctNull((String)hshValues.get("sel_inches")));//slope 2		
							arrValues.add(correctNull((String)hshValues.get("sel_soil")));//slope 3		
							arrValues.add(correctNull((String)hshValues.get("txt_justification")));
							arrValues.add(correctNull(((String)hshValues.get("txt_landdeveloped"))));
							arrValues.add(correctNull(((String)hshValues.get("txt_noofhectare"))));
							arrValues.add(Helper.correctDouble((((String)hshValues.get("txt_maintenance")))));
							arrValues.add(schemetype);
							arrValues.add(strFacSNo);
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);	
							
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
						}
//						---------------------------------------Audittrial------------------------
						/*StringBuilder sbAuditTrial=new StringBuilder();
						
								
						sbAuditTrial.append(
						"~Which Slopes you want used to Level the Land  = ").append(correctNull((String)hshValues.get("sel_slope"))).append(
						"~Which Inches or Feet want used to Reclamation Of Sand Casting  = ").append(correctNull((String )hshValues.get("sel_inches"))).append(
						"~Which Type of Soil Reclamation used  = ").append(correctNull((String )hshValues.get("sel_soil")));
						
						AuditTrial.auditLog(hshValues,"303",strAppno,sbAuditTrial.toString());	*/
						//-------------------------------------------End---------------------------
					}
					catch(Exception ce)
					{	throw new EJBException("Error in getting data "+ ce.getMessage());
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
						{	throw new EJBException("Error in getting data "+ cf.getMessage());
						}
					}
			  }
			public HashMap getLandDevelopment(HashMap hshValues) 
			{
				HashMap hshRecord=new HashMap();
				String strAppNo=null;
				String strschemetype = correctNull((String)hshValues.get("schemetype"));
					
				String schemetype=Helper.getfacilitySchemetype(strschemetype);
				String strFacSNo=Helper.getfacilitySno(strschemetype);
				try 
				{
					   strAppNo=correctNull((String)hshValues.get("appno"));
					 	if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
						{
							strAppNo = correctNull((String)hshValues.get("strappno"));
						}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
						{
							strAppNo = correctNull((String)hshValues.get("strAppno"));
						}
			      	   	hshRecord.put("hshAssessmentParam", new AgrLandHoldingsBO().getLandDevelopmentAssessmentParamByAppno(strAppNo,schemetype,strFacSNo));

				} catch (Exception e) {
					throw new EJBException("Error in getting data "+ e.getMessage());
				}
				return hshRecord;
			}
			
			
			
			/**AUTHOR : ARSATH 
			 * DATE   : 26/02/2014
			 * PURPOSE : FARM DEVELOPMENT SCHEME/FENCING PAGE
			 * */			
			public void updateFencingdet(HashMap hshValues) 
			{
				    
					HashMap hshQueryValues = new HashMap();
					HashMap hshQuery = null;	
					HashMap hshScheme = new HashMap();
					ArrayList arrValues=new ArrayList();
					String strAction= correctNull((String)hshValues.get("hidAction"));
					String strAppno= correctNull((String)hshValues.get("strappno"));
					String strFacSNo="",stragrschemetype="";
					if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
					{
						strAppno = correctNull((String)hshValues.get("appno"));
					}
					ResultSet rs = null;
					String strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
					hshScheme = Helper.splitScheme(strschemetype);
					if(hshScheme!=null)
					{
						strFacSNo = Helper.correctNull((String)hshScheme.get("facility_sno"));
						stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
					}
					try
					{			
						if(strAction.equals("delete"))
						{
							hshQuery=new HashMap();
							hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId","agr_fencing_delete");
							arrValues.add(strAppno);
							arrValues.add(strFacSNo);
							arrValues.add(stragrschemetype);
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
							hshQuery.put("strQueryId","agr_fencing_delete");
							arrValues.add(strAppno);
							arrValues.add(strFacSNo);
							arrValues.add(stragrschemetype);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues=new HashMap();
							hshQuery.put("strQueryId","agr_fencing_insert");
							arrValues.add(strAppno);//1	
							arrValues.add(strFacSNo);//2
							arrValues.add(stragrschemetype);	//3
							arrValues.add(Helper.correctNull((String)hshValues.get("sel_area")));//4	
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totareaval")));//5
							//No of Pits (1Cft)  - ROW
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_areacovpits"))));//6
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costpits")));//7
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totcostpits")));//8
							//No of poles required (Nos) - ROW
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_areacovpoles"))));//9
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costpoles")));//10
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totcostpoles")));//11
							//Barbed wire - ROW
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_areacovbw"))));//12
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costbw")));//13
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_totcostbw")));//14
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_fincostbw"))));//15
							// Labour (Man days) - ROW
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_areacovlabour")));//16	
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_costlabour")));//	17
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_totcostlabour"))));//18
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_fincostlabour")));//19
							//MISC VALUE & FINAL TOT VALUES
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_misfinval")));//20
							arrValues.add(Helper.correctDouble(((String)hshValues.get("txt_misfintotvalue"))));//21
							arrValues.add(Helper.correctDouble((String)hshValues.get("txt_mismainfintotvalue")));//22	
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);	
							
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
						}				
					}
					catch(Exception ce)
					{	
					throw new EJBException("Error in updating the fencing details"+ ce.toString());
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
			
			
			public HashMap getFencingdet(HashMap hshValues) 
			{
				HashMap hshRecord=new HashMap();
				HashMap hshScheme = new HashMap();
				String strAppNo=null;
				String strQuery =null;
				ResultSet rs=null;
				ArrayList arrData=new ArrayList();
				ArrayList arrValues;
				String strschemetype="",stragrschemetype="";
				String strFacSno="";
				
				try 
				{
					strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
					hshScheme = Helper.splitScheme(strschemetype);
					if(hshScheme!=null)
					{
						strFacSno = Helper.correctNull((String)hshScheme.get("facility_sno"));
						stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
					}
					strAppNo=correctNull((String)hshValues.get("appno"));
				 	if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strappno"));
					}if(correctNull(strAppNo).trim().equalsIgnoreCase(""))
					{
						strAppNo = correctNull((String)hshValues.get("strAppno"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("agr_fencing_select^"+strAppNo+"^"+strFacSno+"^"+stragrschemetype);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("fen_area",Helper.correctNull(rs.getString("fen_area")));
						hshRecord.put("fen_areaval",Helper.correctDouble(rs.getString("fen_areaval")));	
						
						hshRecord.put("fen_areacovpits",Helper.correctDouble(rs.getString("fen_areacovpits")));
						hshRecord.put("fen_costpits",Helper.correctDouble(rs.getString("fen_costpits")));
						hshRecord.put("fen_totcostpits",Helper.correctDouble(rs.getString("fen_totcostpits")));	
						
						hshRecord.put("fen_areacovpoles",Helper.correctDouble(rs.getString("fen_areacovpoles")));
						hshRecord.put("fen_costpoles",Helper.correctDouble(rs.getString("fen_costpoles")));
						hshRecord.put("fen_totcostpoles",Helper.correctDouble(rs.getString("fen_totcostpoles")));
						
						hshRecord.put("fen_areabw",Helper.correctDouble(rs.getString("fen_areabw")));
						hshRecord.put("fen_costbw",Helper.correctDouble(rs.getString("fen_costbw")));
						hshRecord.put("fen_totcostbw",Helper.correctDouble(rs.getString("fen_totcostbw")));
						hshRecord.put("fen_fincostbw",Helper.correctDouble(rs.getString("fen_fincostbw")));
						
						hshRecord.put("fen_areacovlab",Helper.correctDouble(rs.getString("fen_areacovlab")));
						hshRecord.put("fen_costlab",Helper.correctDouble(rs.getString("fen_costlab")));	
						hshRecord.put("fen_totcostlab",Helper.correctDouble(rs.getString("fen_totcostlab")));
						hshRecord.put("fen_fincostlab",Helper.correctDouble(rs.getString("fen_fincostlab")));
						
						hshRecord.put("fen_misfinval",Helper.correctDouble(rs.getString("fen_misfinval")));
						hshRecord.put("fen_misfintotval",Helper.correctDouble(rs.getString("fen_misfintotval")));
						hshRecord.put("fen_mismainfintotal",Helper.correctDouble(rs.getString("fen_mismainfintotal")));
					}
			      	   	

				}
				
				catch(Exception ce)
				{	
				throw new EJBException("Error in fetch the fencing details"+ ce.toString());
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
			
	/** Added by DINESH on 27/03/2014 for Agri Interest Subvention Page **/
	public HashMap getInterestSubventionDetails(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		ArrayList arrColyr = new ArrayList();
		ArrayList arrRowyr = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		int i=0,k=0,m=0,RowCount=0;
		boolean booInitialcheck=true;
		String croploanstatus="N";
		double limitinterest=0.0;
		String intr_limit="";
		String pgname= Helper.correctNull((String)hshValues.get("pgname"));
		try
		{
			String strAppno =correctNull((String) hshValues.get("appno"));
			String strFacilitycode="",strselectscheme="",fac_id="";
			strselectscheme = Helper.correctNull((String)hshValues.get("schemetype"));
			if(strselectscheme.equalsIgnoreCase(""))
			{
				strselectscheme = Helper.correctNull((String)hshValues.get("strFacilityAgr"));
			}
			String strFacility="",strfacilisplit="",strFacilityAgr="";
			if(!strselectscheme.equalsIgnoreCase("0"))
			{
			String strSelectSchemesplit[] = strselectscheme.split("-");
			strFacilitycode= strSelectSchemesplit[0];
			}
			if(pgname.equalsIgnoreCase("PN"))
			{
				rs=DBUtils.executeLAPSQuery("sel_agr_facilities^"+strAppno);
				while(rs.next())
				{
					strFacility=Helper.correctNull((String)rs.getString("facscheme"));
					if(strFacility.equalsIgnoreCase("aQ"))
					{
						strFacilitycode=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
					}
				}
			}
			strQuery = SQLParser.getSqlQuery("sel_faccorp_facid^"+strAppno+"^aQ^"+strFacilitycode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				fac_id = Helper.correctNull((String)rs.getString("com_facid")); 
			}
			if (rs != null) {
				rs.close();
			}
			String selectfinYear =  Helper.correctNull((String)hshValues.get("sel_finYear1"));
			if(selectfinYear.trim().equalsIgnoreCase(""))
			{
				selectfinYear=Helper.correctNull((String)hshValues.get("sel_finYear"));
			}

			strQuery=SQLParser.getSqlQuery("sel_countCashflow^"+strAppno+"^"+selectfinYear);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				RowCount = rs.getInt("rowcount");
			}
			
			String strCropFlag="N";
			double dblEligibleAmt=0;
			
			//Other than crop Subvention
			
			strQuery=SQLParser.getSqlQuery("agrcropassessment_select_display^"+strAppno+"^aQ");
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				if(Helper.correctNull(rs2.getString("agr_cas_assessmenttype")).equalsIgnoreCase("130"))
					strCropFlag="Y";
				dblEligibleAmt+=Double.parseDouble(rs2.getString("agr_cas_limitrecom"));
			}
			if(rs2!=null)
			{rs2.close();}
			
			strQuery=SQLParser.getSqlQuery("sel_agrinterestsubvention^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				booInitialcheck=false;
				arrCol = new ArrayList();
				strQuery=SQLParser.getSqlQuery("agrcropassessment_select_display^"+strAppno+"^"+"aQ");
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("sublimitSOF",Helper.correctNull(rs1.getString("agr_cas_eligibility")));
				}
				if (rs1 != null) {
					rs1.close();
				}
				
				k=0;
				boolean booflag=true;
				if(strCropFlag.equalsIgnoreCase("Y"))
				{
					strQuery=SQLParser.getSqlQuery("sel_intsubven_SOF^"+strAppno+"^"+i);
					rs2=DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
					if(Helper.correctNull(rs2.getString("CL_SANC_AMT")).equalsIgnoreCase(""))
					{
						arrCol.add("0.00");	
						arrCol.add("0.00");
						arrCol.add("0.00");
					}
					else
					{
						arrCol.add(Helper.correctNull(rs2.getString("CL_SANC_AMT")));
						arrCol.add(Helper.correctNull(rs2.getString("CL_PCS_AMT")));
						arrCol.add(Helper.correctNull(rs2.getString("cl_jgsud_amt")));
						croploanstatus="Y";
					}
					i++;
					k++;
					booflag=false;
					}
				}
				if(booflag && strCropFlag.equalsIgnoreCase("N"))
				{
					while(k>=0)
					 {
						 arrCol.add(jtn.format(dblEligibleAmt));
						 arrCol.add("0.00");
						 arrCol.add("0.00");
						 k--;
					 }
					booflag=true;
					k=0;
				}
				
				if(Helper.correctNull(rs.getString("agr_intsubv_sofamount")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("agr_intsubv_sofamount")));
				}
				if(Helper.correctNull(rs.getString("agr_intsubv_sofinterest")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("agr_intsubv_sofinterest")));
				}
				if(Helper.correctNull(rs.getString("agr_intsubv_ineligibleamount")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("agr_intsubv_ineligibleamount")));
				}
				if(Helper.correctNull(rs.getString("agr_intsubv_ineligibleinterest")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("selinterestamtforisub^"+strAppno+"^aQ"+"^"+strFacilitycode);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							limitinterest=Double.parseDouble(Helper.correctDouble(rs1.getString("BPLR")));
					}
					arrCol.add(jtn.format(limitinterest));
				}
				
				arrRow.add(arrCol);
			}
			
			
			if(booInitialcheck)
			{
				
				int count=0,countnew=0;
				strQuery=SQLParser.getSqlQuery("sel_intsubven_SOF_count^"+strAppno);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					count =Integer.parseInt(Helper.correctInt(rs2.getString("count")));
					countnew=Integer.parseInt(Helper.correctInt(rs2.getString("count")));
				}
				if(rs2!=null)
				{rs2.close();}
				
				
				
				
				
				while(count>0 && strCropFlag.equalsIgnoreCase("Y"))
				{
					
				strQuery=SQLParser.getSqlQuery("sel_intsubven_SOF^"+strAppno+"^"+i);
				rs2=DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
				arrCol = new ArrayList();
				if(Helper.correctNull(rs2.getString("CL_SANC_AMT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					//arrCol.add("0.00");
					strQuery=SQLParser.getSqlQuery("selinterestamtforisub^"+strAppno+"^aQ"+"^"+strFacilitycode);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							limitinterest=Double.parseDouble(Helper.correctDouble(rs1.getString("BPLR")));
					}
					arrCol.add(jtn.format(limitinterest));
					arrRow.add(arrCol);
				}
				else
				{
					arrCol.add(Helper.correctNull(rs2.getString("CL_SANC_AMT")));
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");
					arrCol.add("0.00");	
					strQuery=SQLParser.getSqlQuery("selinterestamtforisub^"+strAppno+"^aQ"+"^"+strFacilitycode);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							limitinterest=Double.parseDouble(Helper.correctDouble(rs1.getString("BPLR")));
					}
					arrCol.add(jtn.format(limitinterest));
					if(rs1!=null)
					{rs1.close();}
					//arrCol.add("0.00");
					arrRow.add(arrCol);
				}
				
				}
				i++;
				count--;
				}
				if(countnew==1 && strCropFlag.equalsIgnoreCase("Y")){
					for(int j=0;j<4;j++){
						arrCol = new ArrayList();
						arrCol.add("0.00");	
						arrCol.add("0.00");	
						arrCol.add("0.00");	
						arrCol.add("0.00");	
						arrCol.add("0.00");	
						arrCol.add("0.00");	
						arrCol.add("0.00");
						arrRow.add(arrCol);
					}
				}
				
				if(strCropFlag.equalsIgnoreCase("N"))
				{
					for(int j=0;j<5;j++){
					arrCol.add(jtn.format(dblEligibleAmt));
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");	
					arrCol.add("0.00");
					arrCol.add("0.00");	
					strQuery=SQLParser.getSqlQuery("selinterestamtforisub^"+strAppno+"^aQ"+"^"+strFacilitycode);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							limitinterest=Double.parseDouble(Helper.correctDouble(rs1.getString("BPLR")));
					}
					arrCol.add(jtn.format(limitinterest));
					if(rs1!=null)
					{rs1.close();}
					arrRow.add(arrCol);
					}
				}
				
				
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("croploanstatus",croploanstatus);
			hshRecord.put("strCropFlag",strCropFlag);
			
			strQuery = SQLParser.getSqlQuery("sel_corploanMaster");
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				if(Helper.correctNull(rs1.getString("CORPLOAN_ID")).equalsIgnoreCase("7"))
				{
					hshRecord.put("maxCropLimit",correctNull(rs1.getString("CORPLOAN_PERCENTAGE")));
				}
				if(Helper.correctNull(rs1.getString("CORPLOAN_ID")).equalsIgnoreCase("8"))
				{
					hshRecord.put("maxCropROI",correctNull(rs1.getString("CORPLOAN_PERCENTAGE")));
				}
				if(Helper.correctNull(rs1.getString("CORPLOAN_ID")).equalsIgnoreCase("9"))
				{
					hshRecord.put("maxOtherCropLimit",correctNull(rs1.getString("CORPLOAN_PERCENTAGE")));
				}
				if(Helper.correctNull(rs1.getString("CORPLOAN_ID")).equalsIgnoreCase("10"))
				{
					hshRecord.put("maxOtherCropROI",correctNull(rs1.getString("CORPLOAN_PERCENTAGE")));
				}
			}
			
			
			hshRecord.put("strAppno1",strAppno);
			
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing getInterestSubventionDetails" + ce.getMessage()); 
		}
		finally
		{
			try{
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				arrRow=null;
				arrCol=null;
			}
			catch(Exception cf){
				throw  new EJBException("Error in closing getInterestSubventionDetails Connection" + cf.getMessage()); 
			}
		}
		return hshRecord;
	}		
			
	public void updInterestSubventionDetails(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		HashMap hshRecord = new HashMap();

		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno="";
		String schemetype = correctNull((String)hshValues.get("schemetype"));
	
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("strappno"));
		}
		if(appno.trim().equalsIgnoreCase("")){
			appno=Helper.correctNull((String)hshValues.get("appno"));
		}
		String[] Year = null;
		String[] limitsanctioned = null;
		String[] sublimitSOFamt = null;
		String[] sublimitSOFroi = null;
		String[] sublimitIneligible_amt = null;
		String[] sublimitIneligible_roi = null;
		
		Year = (String[])hshValues.get("txt_year");
		limitsanctioned = (String[]) hshValues.get("txt_limitsanctioned");
		sublimitSOFamt = (String[]) hshValues.get("txt_sublimitSOF_amt");
		sublimitSOFroi = (String[]) hshValues.get("txt_sublimitSOF_roi");
		sublimitIneligible_amt = (String[]) hshValues.get("txt_sublimitIneligible_amt");
		sublimitIneligible_roi = (String[])hshValues.get("txt_sublimitIneligible_roi");
		
		try
		{
			if(strAction.equals("update"))
			{	
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","del_agrinterestsubvention");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				int j=0;
				for(int i=0;i<5;i++)
			 	{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","ins_agrinterestsubvention");
					
					arrValues.add(appno);
					arrValues.add(Integer.toString(j+1));
					arrValues.add(Year[i]);
					arrValues.add(limitsanctioned[i]);
					arrValues.add(sublimitSOFamt[i]);
					arrValues.add(sublimitSOFroi[i]);
					arrValues.add(sublimitIneligible_amt[i]);
					arrValues.add(sublimitIneligible_roi[i]);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					j++;
				} 
			
			}
			
			else if(strAction.equals("delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","del_agrinterestsubvention");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getting data "+ e.getMessage());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updInterestSubventionDetails"+ exp.toString()); 
			}
		}
	}		
}