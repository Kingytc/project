package com.sai.laps.ejb.percollateral;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "PerCollateralBean", mappedName = "PerCollateralHome")
@Remote (PerCollateralRemote.class)
public class PerCollateralBean extends BeanAdapter {
	private static final long serialVersionUID = 1L;

	/**
	 * Function getData This Method is invoked for getting personal collateral
	 * datas
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public HashMap getData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strApplicationNo = correctNull((String) hshValues.get("appno"));
		String strapptype = "";
		String strappid = "";
		String strAppValue = "";
		String strQuery = "";

		String strappid1 = "";
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		try {
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			if (strAppValue.equalsIgnoreCase("")
					|| strAppValue.equalsIgnoreCase("null")) {
				hshResult = hshValues;
			} else {
				strapptype = strAppValue.substring(0, 1);
				strappid = strAppValue.substring(1, strAppValue.length());

				strQuery = SQLParser.getSqlQuery("sel_collatraldetails^"
						+ strApplicationNo + "^" + strapptype + "^" + strappid);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					vecRow = new ArrayList();
					vecRow.add(correctNull(rs.getString("home_appno")));
					vecRow.add(correctNull(rs.getString("home_applnt")));
					vecRow.add(correctNull(rs.getString("home_appid")));
					vecRow.add(correctNull(rs.getString("home_sino")));
					vecRow.add(correctNull(rs.getString("home_contperson")));
					vecRow.add(correctNull(rs.getString("home_titlecity")));
					vecRow.add(correctNull(rs.getString("home_titlestate")));
					vecRow.add(correctNull(rs.getString("home_titlezip")));
					vecRow.add(correctNull(rs.getString("home_titleadd1")));
					vecRow.add(correctNull(rs.getString("home_titleadd2")));
					vecRow.add(correctNull(rs.getString("home_yrbuilt")));
					vecRow.add(correctNull( rs
							.getString("home_purchaseval")));
					vecRow.add(correctNull( rs
							.getString("home_appval")));
					vecRow.add(correctNull( rs
							.getString("home_mortval")));
					vecRow.add(correctNull( rs
							.getString("home_extent")));
					vecRow.add(correctNull( rs
							.getString("home_surveyno")));
					vecRow.add(correctNull( rs
							.getString("home_propertytax")));
					vecRow.add(correctNull( rs
							.getString("home_watertax")));
					vecRow.add(correctNull( rs
							.getString("home_other")));
					vecRow.add(correctNull( rs
							.getString("home_desc")));
					vecRow.add(correctNull( rs
							.getString("city_name")));
					vecRow.add(correctNull( rs
							.getString("state_name")));
					vecRow.add(correctNull( rs
							.getString("home_contperson2")));
					vecRow.add(correctNull( rs
							.getString("home_contperson3")));
					vecData.add(vecRow);
				}
				hshResult.put("vecData", vecData);
				hshResult.put("strAppValue", strAppValue);
				hshResult.put("id1", strappid1);
			}
		} catch (Exception ce) {
			throw new EJBException("Error in closing getData" + ce.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}

	/**
	 * Function insertData used for inserting collateral home datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public void updatehome(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strApplicationNo = "", strQuery = "";
		String strslno = "";
		String strAppValue = "";
		String strapptype = "";
		String strappid = "";
		String strhome_purchaseval = "";
		String strhome_mortval = "";
		String strhome_appval = "";
		String strAction = "";
		StringBuilder sbolddata=new StringBuilder();
		strslno = correctNull((String) hshValues.get("hid_sino"));

		try {
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			strapptype = strAppValue.substring(0, 1);
			strappid = strAppValue.substring(1, strAppValue.length());
			strhome_purchaseval = Helper.correctDouble((String) hshValues
					.get("txthome_purchaseval"));
			strhome_mortval = Helper.correctDouble((String) hshValues
					.get("txthome_mortval"));
			strhome_appval = Helper.correctDouble((String) hshValues
					.get("txthome_appval"));
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAction = correctNull((String) hshValues.get("hidAction"));

			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("sel_collatraldetailsbysno^"+strslno+"^"+strApplicationNo+"^"+strapptype+"^"+strappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Applicant Type  =").append(correctNull((String) hshValues.get("selapptype1")))
					.append(" ~First Title Holder ="+ correctNull(rs.getString("home_contperson")))
					.append(" ~Year Built =").append(correctNull(rs.getString("home_yrbuilt")))
					.append(" ~Second Title Holder =").append(correctNull(rs.getString("home_contperson2")))
					.append(" ~Immovable property Extent (Sq.ft) =").append(correctNull(rs.getString("home_extent")))
					.append(" ~Third Title Holder =").append(correctNull(rs.getString("home_contperson3")))
					.append(" ~Survey No =").append(correctNull(rs.getString("home_surveyno")))
					.append(" ~Address =").append(correctNull(rs.getString("home_titleadd1"))).append(correctNull(rs.getString("home_titleadd2")))
					.append(" ~City =").append(correctNull(rs.getString("city_name")))
					.append(" ~State =").append(correctNull(rs.getString("state_name")))
					.append(" ~" + ApplicationParams.getZipName() + "=").append(correctNull(rs.getString("home_titlezip")))
					.append(" ~Purchase Price =").append(correctNull(rs.getString("home_purchaseval")))
					.append(" ~Mortgage Bal. (if any) =").append(correctNull(rs.getString("home_mortval")))
					.append(" ~Decription =").append(correctNull(rs.getString("home_desc")))
					.append(" ~Other Informations =").append(correctNull(rs.getString("home_other")))
					.append(" ~Market Value =").append(correctNull(rs.getString("home_appval")))
					.append(" ~Last Property Tax Paid Upto (dd/mm/yyyy) =").append(correctNull(rs.getString("home_propertytax")))
					.append(" ~Water Tax Paid Upto (dd/mm/yyyy) =").append(correctNull(rs.getString("home_watertax")));
				}
			}
 
			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "perinscollateralhome");
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype);
				strQuery = "sel_max_collatraldetails^" + strApplicationNo;
				rs = DBUtils.executeLAPSQuery(strQuery);
				while (rs.next()) {
					strslno = correctNull( rs.getString("maxid"));
				}
				if (rs != null)
					rs.close();
				arrValues.add(strslno);
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleaccnt")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleadd1")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleadd2")));
				arrValues.add(correctNull((String) hshValues.get("hidcity")));
				arrValues.add(correctNull((String) hshValues.get("hidstate")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titlezip")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_yrbuilt")));
				arrValues.add(strhome_purchaseval);
				arrValues.add(strhome_appval);
				arrValues.add(strhome_mortval);
				arrValues.add(correctNull((String) hshValues
						.get("txthome_extent")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_surveyno")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_propertytax")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_watertax")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_other")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_desc")));
				arrValues.add(strappid);
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson2")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson3")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "perupdcollateralhome");

				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleaccnt")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleadd1")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titleadd2")));
				arrValues.add(correctNull((String) hshValues.get("hidcity")));
				arrValues.add(correctNull((String) hshValues.get("hidstate")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_titlezip")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_yrbuilt")));
				arrValues.add(strhome_purchaseval);
				arrValues.add(strhome_appval);
				arrValues.add(strhome_mortval);
				arrValues.add(correctNull((String) hshValues
						.get("txthome_extent")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_surveyno")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_propertytax")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_watertax")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_other")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_desc")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson2")));
				arrValues.add(correctNull((String) hshValues
						.get("txthome_contperson3")));
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype);
				arrValues.add(strslno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype);
				arrValues.add(strslno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perdelcollateralhome");
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (!strAction.equalsIgnoreCase("edit")) {
				StringBuilder sbAuditTrial=new StringBuilder();
				if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert"))) {
				sbAuditTrial.append("Applicant Type  =").append(
						correctNull((String) hshValues.get("selapptype1")))
						.append(
								"~First Title Holder ="
										+ correctNull((String) hshValues
												.get("txthome_contperson")))
						.append("~Year Built =").append(
								correctNull((String) hshValues
										.get("txthome_yrbuilt"))).append(
								"~Second Title Holder =").append(
								correctNull((String) hshValues
										.get("txthome_contperson2"))).append(
								"~Immovable property Extent (Sq.ft) =").append(
								correctNull((String) hshValues
										.get("txthome_extent"))).append(
								"~Third Title Holder =").append(
								correctNull((String) hshValues
										.get("txthome_contperson3"))).append(
								"~Survey No =").append(
								correctNull((String) hshValues
										.get("txthome_surveyno"))).append(
								"~Address =").append(
								correctNull((String) hshValues
										.get("txthome_titleadd1"))).append(
								correctNull((String) hshValues
										.get("txthome_titleadd2")))
								.append("~City =").append(
								correctNull((String) hshValues
										.get("txthome_titlecity"))).append(
								"~State =").append(
								correctNull((String) hshValues
										.get("txthome_titlestate"))).append(
								"~" + ApplicationParams.getZipName() + "=")
						.append(
								correctNull((String) hshValues
										.get("txthome_titlezip")))
								.append("~Purchase Price =").append(correctNull((String) hshValues.get("txthome_purchaseval")))
								.append("~Mortgage Bal. (if any) =").append(correctNull((String) hshValues.get("txthome_mortval")))
								.append("~Description =").append(correctNull((String) hshValues.get("txthome_desc")))
								.append("~Other Informations =").append(correctNull((String) hshValues.get("txthome_other")))
								.append("~Market Value =").append(correctNull((String) hshValues.get("txthome_appval")))
								.append("~Last Property Tax Paid Upto (dd/mm/yyyy) =").append(correctNull((String) hshValues.get("txthome_propertytax"))).append(
								"~Water Tax Paid Upto (dd/mm/yyyy) =").append(
								correctNull((String) hshValues
										.get("txthome_watertax")));
				}
				AuditTrial.auditNewLog(hshValues,"54",strApplicationNo,sbAuditTrial.toString(),sbolddata.toString());
			}

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
	}

	/**
	 * Function getBoatAuto This Method is invoked for getting personal boat and
	 * car datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public HashMap getBoatAuto(HashMap hshValues)  {
		String strautotype = correctNull((String) hshValues.get("hidauto_type"));
		String prdcode = correctNull((String) hshValues.get("prdcode"));
		String prdType = correctNull((String) hshValues.get("strProductType"));
		String strQuery = "",strVehiType="",strauto_category="";
		String checkStaff = "";
		ResultSet rs = null,rs1=null,rs2=null;
		HashMap hshRecord = new HashMap();
		String strGradeId = "",strSecId="",strAppid="",strType_name="",str_Type="";
		String recordflag = "N";
		String strJointOwnDetails="";
		int intAtuoCount=0;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();

		try {
			String appno = correctNull((String) hshValues.get("appno"));
			strGradeId = "A";
			strQuery = SQLParser.getSqlQuery("selectvehicledetails1^"
					+ strGradeId + "^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshRecord.put("auto_purpose", correctNull(rs.getString("auto_purpose")));
				strauto_category=Helper.correctNull(rs.getString("auto_category"));
				hshRecord.put("auto_category", correctNull(rs.getString("auto_category")));
				hshRecord.put("auto_make", correctNull(rs.getString("auto_make")));
				hshRecord.put("auto_model", correctNull(rs.getString("auto_model")));
				hshRecord.put("auto_articlename", correctNull(rs.getString("auto_articlename")));
				hshRecord.put("auto_accessories", correctNull(rs.getString("auto_accessories")));
				hshRecord.put("auto_valuation", correctNull(rs.getString("auto_valuation")));
				hshRecord.put("auto_age", correctNull(rs.getString("auto_age")));
				hshRecord.put("auto_dealer", correctNull(rs.getString("auto_dealer")));
				hshRecord.put("auto_deleraddress1", correctNull(rs.getString("auto_deleraddress1")));
				hshRecord.put("auto_deleraddress2", correctNull(rs.getString("auto_deleraddress2")));
				hshRecord.put("hidcity", correctNull(rs.getString("auto_delercity")));
				hshRecord.put("hidstate", correctNull(rs.getString("auto_delerstate")));
				hshRecord.put("auto_delercity", correctNull(rs.getString("city_name")));
				hshRecord.put("auto_delerstate", correctNull(rs.getString("state_name")));
				hshRecord.put("auto_delerpin", correctNull( rs.getString("auto_delerpin")));
				hshRecord.put("auto_delerphone", correctNull(rs.getString("auto_delerphone")));
				hshRecord.put("auth_dealer", correctNull(rs.getString("auth_dealer")));
				hshRecord.put("estb_year", correctNull(rs.getString("estb_year")));
				hshRecord.put("dealer_since", correctNull(rs.getString("dealer_since")));
				hshRecord.put("remark_app", correctNull(rs.getString("remark_app")));
				hshRecord.put("remark_gen", correctNull(rs.getString("remark_gen")));
				hshRecord.put("txtauto_valuation1",correctNull(rs.getString("auto_valuationentry")));
				hshRecord.put("txtauto_registration", correctNull(rs.getString("auto_registration")));
				hshRecord.put("txtauto_chasis", correctNull(rs.getString("auto_chasis")));
				hshRecord.put("txtauto_engine", correctNull(rs.getString("auto_engine")));
				hshRecord.put("txtauto_tax", correctNull(rs.getString("auto_tax")));
				hshRecord.put("txtauto_insurance", correctNull(rs.getString("auto_insurance")));
				hshRecord.put("txtauto_charges", correctNull(rs.getString("auto_charges")));
				hshRecord.put("txt_discount", correctNull(rs.getString("auto_discount")));
				hshRecord.put("radio_applicantdrivenvehicle",correctNull(rs.getString("driven_by_applicant")));
				hshRecord.put("txt_fuelused", correctNull( rs.getString("auto_fuel_used")));
				hshRecord.put("txtauto_vehicles", correctNull(rs.getString("auto_vehicles")));
				hshRecord.put("txtauto_ownername", correctNull(rs.getString("auto_owner")));
				hshRecord.put("txa_remarks", correctNull(rs.getString("auto_remarks")));
				hshRecord.put("txt_userid", correctNull(rs.getString("auto_userid")));
				hshRecord.put("auto_appid", correctNull(rs.getString("auto_appid")));
				
				strAppid= correctNull(rs.getString("auto_appid"));
					
				hshRecord.put("auto_vehicletype", correctNull(rs.getString("auto_vehicletype")));
				strVehiType=Helper.correctNull(rs.getString("auto_vehicletype"));
				hshRecord.put("auto_originalcost", correctNull(rs.getString("auto_originalcost")));
				hshRecord.put("auto_actualconsideration",correctNull(rs.getString("auto_actualconsideration")));
				hshRecord.put("auto_leastvalue", correctNull(rs.getString("auto_leastvalue")));
				hshRecord.put("auto_datemanu", correctNull(rs.getString("auto_datemanu")));
				hshRecord.put("auto_take_over", correctNull(rs.getString("auto_take_over")));
				hshRecord.put("registration_date", correctNull(rs.getString("registration_date")));
				hshRecord.put("AUTO_SALTOSB", correctNull(rs.getString("AUTO_SALTOSB")));
				hshRecord.put("AUTO_UNDERTKNGLETTER", correctNull(rs.getString("AUTO_UNDERTKNGLETTER")));
				hshRecord.put("auto_natureofcharge", correctNull(rs.getString("auto_natureofcharge")));
				hshRecord.put("AUTO_OLDVEHICLETYPE", correctNull(rs.getString("AUTO_OLDVEHICLETYPE")));
				recordflag = "Y";
			}
			//for grid view
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selectvehicledetails1^"
					+ strGradeId + "^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add( correctNull(rs.getString("auto_purpose")));//0
				vecCol.add( correctNull(rs.getString("auto_vehicletype")));//1
				vecCol.add( correctNull(rs.getString("auto_make")));//2
				vecCol.add( correctNull(rs.getString("auto_model")));//3
				vecCol.add( correctNull(rs.getString("auto_articlename")));//4
				vecCol.add( correctNull(rs.getString("auto_accessories")));//5
				vecCol.add( correctNull(rs.getString("auto_valuation")));//6
				vecCol.add( correctNull(rs.getString("auto_age")));//7
				vecCol.add( correctNull(rs.getString("auto_dealer")));//8
				vecCol.add(correctNull(rs.getString("auto_deleraddress1")));//9
				vecCol.add(correctNull(rs.getString("auto_deleraddress2")));//10
				vecCol.add(correctNull(rs.getString("auto_delercity")));//11
				vecCol.add( correctNull(rs.getString("auto_delerstate")));//12
				vecCol.add(correctNull(rs.getString("city_name")));//13
				vecCol.add(correctNull(rs.getString("state_name")));//14
				vecCol.add(correctNull( rs.getString("auto_delerpin")));//15
				vecCol.add(correctNull(rs.getString("auto_delerphone")));//16
				vecCol.add(correctNull(rs.getString("auth_dealer")));//17
				vecCol.add(correctNull(rs.getString("estb_year")));//18
				vecCol.add(correctNull(rs.getString("dealer_since")));//19
				vecCol.add(correctNull(rs.getString("remark_app")));//20
				vecCol.add(correctNull(rs.getString("remark_gen")));//21
				vecCol.add(correctNull(rs.getString("auto_valuationentry")));//22
				vecCol.add(correctNull(rs.getString("auto_registration")));//23
				vecCol.add(correctNull(rs.getString("auto_chasis")));//24
				vecCol.add(correctNull(rs.getString("auto_engine")));//25
				vecCol.add(correctNull(rs.getString("auto_tax")));//26
				vecCol.add(correctNull(rs.getString("auto_insurance")));//27
				vecCol.add(correctNull(rs.getString("auto_charges")));//28
				vecCol.add(correctNull(rs.getString("auto_discount")));//29
				vecCol.add(correctNull(rs.getString("driven_by_applicant")));//30
				vecCol.add(correctNull( rs.getString("auto_fuel_used")));//31
				vecCol.add(correctNull(rs.getString("auto_vehicles")));//32
				vecCol.add(correctNull(rs.getString("auto_owner")));//33
				vecCol.add(correctNull(rs.getString("auto_remarks")));//34
				vecCol.add(correctNull(rs.getString("auto_userid")));//35
				vecCol.add(correctNull(rs.getString("auto_appid")));//36
				vecCol.add(correctNull(rs.getString("auto_category")));//37
				str_Type=correctNull(rs.getString("auto_vehicletype"));
				vecCol.add(correctNull(rs.getString("auto_originalcost")));//38
				vecCol.add(correctNull(rs.getString("auto_actualconsideration")));//39
				vecCol.add(correctNull(rs.getString("auto_leastvalue")));//40
				vecCol.add(correctNull(rs.getString("auto_datemanu")));//41
				vecCol.add(correctNull(rs.getString("auto_take_over")));//42
				vecCol.add(correctNull(rs.getString("registration_date")));//43
				vecCol.add(correctNull(rs.getString("AUTO_SALTOSB")));//44
				vecCol.add(correctNull(rs.getString("AUTO_UNDERTKNGLETTER")));//45
				vecCol.add(correctNull(rs.getString("auto_natureofcharge")));//46
				vecCol.add(correctNull(rs.getString("AUTO_OLDVEHICLETYPE")));//47
				vecCol.add(correctNull(rs.getString("AUTO_SNO")));//48
				vecCol.add(correctNull(rs.getString("auto_sec_secid")));//49
				if(str_Type!=""){
					if(str_Type.equalsIgnoreCase("1")){strType_name="Two Wheeler";}
					else if(str_Type.equalsIgnoreCase("2")){strType_name="Three Wheeler";}
					else if(str_Type.equalsIgnoreCase("3")){strType_name="four Wheeler";}
					vecCol.add(strType_name);//50
				}else{
					vecCol.add("");//50
				}
				vecCol.add(correctNull(rs.getString("AUTO_PURCHASEVAL")));//51
				vecRow.add(vecCol);
			}
			
			hshRecord.put("vecRow",vecRow);
			
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selecttakeover^"+ appno);	
			if (rs.next()) 
			{
				hshRecord.put("loan_takeover",correctNull(rs.getString("loan_takeover")));
			}
			if(rs !=null)
			{rs.close();}
			
			rs = DBUtils.executeLAPSQuery("sel_staffproductcheck^" + prdcode);
			if (rs.next()) {
				checkStaff = "staff";
			}
			
			rs=null;
			rs=DBUtils.executeLAPSQuery("selvehage^"+ appno);
			if(rs.next())
			{				
				hshRecord.put("loan_ageofveh", correctNull((String)rs.getString("loan_ageofveh")));												
			}
			
			hshRecord.put("checkStaff", checkStaff);
			hshRecord.put("hidauto_type", strautotype);
			hshRecord.put("recordflag", recordflag);
			hshRecord.put("prdcode", prdcode);

			
			if (rs != null) 
			{
				rs.close();
			}
			
			if(!prdcode.equalsIgnoreCase("")&& !prdType.equalsIgnoreCase("pU"))
			{
				rs = DBUtils.executeLAPSQuery("sel_proincomeflag^" + prdcode);
				if (rs.next()) 
				{
					hshRecord.put("vehtype",correctNull(rs.getString("prd_purpose")));	
				}
			}
			else
			{
				if(strauto_category.equalsIgnoreCase(""))
				{
					rs = DBUtils.executeLAPSQuery("sel_mahilaVehi^" + appno);
					if (rs.next()) 
					{
						hshRecord.put("auto_category",correctNull(rs.getString("prd_vehitype")));	
					}
				}
				hshRecord.put("vehtype",strVehiType);	
			}
			
			//**********************************************
			
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
				if(strAppid.equalsIgnoreCase(""))
				{
					strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
				}
			}
			
			if(!strAppid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
				if(rs.next())
				{
					strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
			}
			
			// For Per_Auto Count
			rs = DBUtils.executeLAPSQuery("sel_perAuto_count^" + appno);
			if(rs.next())
			{
				intAtuoCount=rs.getInt("auto_count");
			}
			
			if(intAtuoCount>0)
			{
				strQuery = SQLParser.getSqlQuery("sel_appsecDetails_secid^" +appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					strSecId=Helper.correctNull((String)rs.getString("app_sec_secid"));
				}
				
				hshRecord.put("strSecId",strSecId);
				
				if(!strSecId.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) 
					{
						hshRecord.put("cus_sec_joint_holder",Helper.correctNull((String)rs.getString("cus_sec_joint_holder")));
					}
				}
			}
			
			if(!strSecId.equalsIgnoreCase(""))
			{
				if (rs != null) 
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					strJointOwnDetails="";
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						String strSeperator="@";
	
						String strId=Helper.correctNull((String)rs1.getString("cus_owner_laps_id"));
						String strName="";
						String strCBSID="";
						String strOldID="";
						strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strId);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							 strName=Helper.correctNull((String)rs2.getString("perapp_fname"));
							 strOldID=Helper.correctNull((String)rs2.getString("perapp_oldid"));
							 strCBSID=Helper.correctNull((String)rs2.getString("perapp_cbsid"));
						}
						strJointOwnDetails+=strName;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strOldID;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strCBSID;
						strJointOwnDetails+=strSeperator;
					}
					strJointOwnDetails+=strSecId;
				}
				hshRecord.put("strJointOwnDetails", strJointOwnDetails);
			}
			
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+appno);
			if(rs.next())
			{
				hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			
			if (rs != null) {
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
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshRecord.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("VehicleEdit_Flag","N");
				}
			}
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_release_flag_cus_sec^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshRecord.put("cus_release_flag",Helper.correctNull((String)rs.getString("cus_releaseflag")));	
				
			}
			
			
			
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	/**
	 * Function insertData used for inserting collateral home datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public void updateCollVehicle(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ResultSet rs = null;
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "";
		String strAppValue = "";
		String strapptype = "";
		StringBuilder sbolddata=new StringBuilder();
		String strauto_category = correctNull((String) hshValues.get("cmbauto_category"));
		String strauto_make = correctNull((String) hshValues.get("txtauto_make"));
		String strauto_model = correctNull((String) hshValues.get("txtauto_model"));
		String strauto_dealer = correctNull((String) hshValues.get("txtauto_dealer"));
		String strauto_serialno = correctNull((String) hshValues.get("txtauto_serialno"));
		String strauto_ser_age = correctNull((String) hshValues.get("txtauto_ser_age"));
		String strauto_valuation = correctNull((String) hshValues.get("txtauto_valuation"));
		String strauto_cost = correctNull((String) hshValues.get("txtauto_cost"));
		String strauto_price_type = correctNull((String) hshValues.get("cmbauto_price_type"));
		String strauto_age = correctNull((String) hshValues.get("cmbauto_age"));
		String strauto_type = correctNull((String) hshValues.get("hidauto_type"));
		String strsno = Helper.correctNull((String) hshValues.get("hid_strsno"));
		String strseltax = correctNull((String) hshValues.get("sel_taxpaid"));
		String strauto_lasttax = correctNull((String) hshValues.get("txtauto_lasttax"));
		String strappid = "";
		String strQuery = "";
		String strAction = "";

		try {
			strAction = correctNull((String) hshValues.get("hidAction"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			if (!strAppValue.equals("")) {
				strapptype = strAppValue.substring(0, 1);
				strappid = strAppValue.substring(1, strAppValue.length());
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("pergetcollateralautobysno^"+strsno+"^"+strApplicationNo+"^"+strapptype.toUpperCase()+"^"+strauto_type+"^"+strappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					 sbolddata.append("Applicant Type ="+ correctNull((String) hshValues.get("selapptype1")))
					.append(" ~Category =").append(correctNull(rs.getString("auto_category")))
					.append(" ~Make =").append(correctNull(rs.getString("auto_make")))
					.append(" ~Model =").append(correctNull(rs.getString("auto_model")))
					.append(" ~Name of the Dealer / Seller =").append(correctNull(rs.getString("auto_dealer")))
					.append(" ~Serial No. =").append(correctNull(rs.getString("auto_serialno")))
					.append(" ~Approx. serviceable age of Vehicle =")
					.append(correctNull(rs.getString("auto_ser_age")))
					.append(" ~Cost of Vehicle =").append(correctNull(rs.getString("auto_cost")))
					.append(" ~Type of Vehicle =");
					if(correctNull(rs.getString("auto_price_type")).equalsIgnoreCase("1"))
						sbolddata.append("Two Wheeler");
					else if(correctNull(rs.getString("auto_price_type")).equalsIgnoreCase("2"))
						sbolddata.append("Three Wheeler");
					else if(correctNull(rs.getString("auto_price_type")).equalsIgnoreCase("3"))
						sbolddata.append("Four Wheeler");
					else
						sbolddata.append("");
					sbolddata.append(" ~Valuation as per garage certificate  =").append(correctNull(rs.getString("auto_valuation")))
					.append(" ~Age of Vehicle =").append((correctNull(rs.getString("auto_age")).equals("")) ? "":(ApplicantParams.getApplicantParams("AgeVehicle", correctNull(rs.getString("auto_age")))))
					.append(" ~Life Tax Paid =").append(SetupParams.getSetupParams("SacrificeLimit",(correctNull(rs.getString("auto_lifetaxpd")))));
					if (correctNull((String) hshValues.get("sel_taxpaid")).equals("y"))
					{
						sbolddata.append(" ~Last Tax Paid upto ").append(correctNull(rs.getString("auto_lasttax")));
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_maxperautosno^"
						+ strApplicationNo + "^" + "C");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strsno = Helper.correctNull((String) rs.getString("auto_sno"));
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "perinscollateralauto");
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype.toUpperCase());
				arrValues.add(strauto_category);
				arrValues.add(strauto_model);
				arrValues.add(strauto_make);
				arrValues.add(strauto_dealer);
				arrValues.add(strauto_serialno);
				arrValues.add(strauto_ser_age);
				arrValues.add(strauto_valuation);
				arrValues.add(strauto_price_type);
				arrValues.add(strauto_age);
				arrValues.add(strauto_type);

				if (strauto_lasttax.equalsIgnoreCase("")) {
					arrValues.add(null);
				} else {
					arrValues.add(strauto_lasttax);
				}
				arrValues.add(strappid);
				arrValues.add(strauto_cost);
				arrValues.add(strseltax);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "perupdcollateralauto");
				arrValues.add(strauto_category);
				arrValues.add(strauto_model);
				arrValues.add(strauto_make);
				arrValues.add(strauto_dealer);
				arrValues.add(strauto_serialno);
				arrValues.add(strauto_ser_age);
				arrValues.add(strauto_valuation);
				arrValues.add(strauto_price_type);
				arrValues.add(strauto_age);
				arrValues.add(strauto_type);

				if (strauto_lasttax.equalsIgnoreCase("")) {
					arrValues.add(null);
				} else {
					arrValues.add(strauto_lasttax);
				}
				arrValues.add(strappid);
				arrValues.add(strauto_cost);
				arrValues.add(strseltax);
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype.toUpperCase());
				arrValues.add(strauto_type);
				arrValues.add(strappid);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} 
			else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strapptype.toUpperCase());
				arrValues.add(strauto_type);
				arrValues.add(strappid);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perdelcollateralautocoll");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("insert"))
			{
				sbAuditTrial
					.append(
							"Applicant Type ="
									+ correctNull((String) hshValues
											.get("selapptype1")))
					.append("~Category =")
					.append(
							correctNull((String) hshValues
									.get("cmbauto_category1")))
					.append("~Make =")
					.append(correctNull((String) hshValues.get("txtauto_make")))
					.append("~Model =")
					.append(
							correctNull((String) hshValues.get("txtauto_model")))
					.append("~Name of the Dealer / Seller =")
					.append(
							correctNull((String) hshValues
									.get("txtauto_dealer")))
					.append("~Serial No. =")
					.append(
							correctNull((String) hshValues
									.get("txtauto_serialno")))
					.append("~Approx. serviceable age of Vehicle =")
					.append(
							correctNull((String) hshValues
									.get("txtauto_ser_age")))
					.append("~Cost of Vehicle =")
					.append(correctNull((String) hshValues.get("txtauto_cost")))
					.append("~Type of Vehicle =").append(correctNull((String) hshValues.get("cmbauto_price_type1")))
					.append("~Valuation as per garage certificate  =").append(correctNull((String) hshValues.get("txtauto_valuation")))
					.append("~Age of Vehicle =").append((correctNull((String) hshValues.get("cmbauto_age"))
									.equals("")) ? ""
									: correctNull((String) hshValues
											.get("cmbauto_age1"))).append(
							"~Life Tax Paid =").append(
							SetupParams.getSetupParams("SacrificeLimit",
									correctNull((String) hshValues
											.get("sel_taxpaid"))));

				if (correctNull((String) hshValues.get("sel_taxpaid")).equals("y")) {
					sbAuditTrial.append("~Last Tax Paid upto ").append(
							correctNull((String) hshValues.get("txtauto_lasttax")));
				}
			}
			AuditTrial.auditNewLog(hshValues,"55",strApplicationNo,sbAuditTrial.toString(),sbolddata.toString());
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public HashMap getCollVehicleData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strautotype = "C";
		String strAppValue = "";
		String strApplicationNo = "";
		String strapptype = "";
		String strappid = "";
		String recordflag = "N";
		String strQuery = "";

		try {
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strautotype = correctNull((String) hshValues.get("hidauto_type"));
			strautotype = strautotype.equals("") ? "C" : strautotype;
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			if (strAppValue.equalsIgnoreCase("")
					|| strAppValue.equalsIgnoreCase("null")) {
				hshResult = hshValues;
			} else {
				strapptype = strAppValue.substring(0, 1);
				strappid = strAppValue.substring(1, strAppValue.length());

				strQuery = SQLParser.getSqlQuery("pergetcollateralauto^"
						+ strApplicationNo + "^" + strapptype.toUpperCase()
						+ "^" + strautotype + "^" + strappid);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol.add(correctNull((String) rs.getString("auto_appno")));
					vecCol.add(correctNull((String) rs.getString("auto_applnt")));
					vecCol.add(correctNull((String) rs.getString("auto_category")));
					vecCol.add(correctNull((String) rs.getString("auto_make")));
					vecCol.add(correctNull((String) rs.getString("auto_model")));
					vecCol.add(correctNull((String) rs.getString("auto_dealer")));
					vecCol.add(correctNull((String) rs.getString("auto_serialno")));
					vecCol.add(correctNull((String) rs.getString("auto_ser_age")));
					vecCol.add(correctNull((String) rs.getString("auto_valuation")));
					vecCol.add(correctNull((String) rs.getString("auto_price_type")));
					vecCol.add(correctNull((String) rs.getString("auto_age")));
					vecCol.add(correctNull((String) rs.getString("auto_type")));
					vecCol.add(correctNull((String) rs.getString("auto_lasttax")));
					vecCol.add(correctNull((String) rs.getString("auto_regno")));
					vecCol.add(correctNull((String) rs.getString("auto_cost")));
					vecCol.add(correctNull((String) rs.getString("auto_lifetaxpd")));
					vecCol.add(correctNull((String) rs.getString("auto_sno")));
					vecRow.add(vecCol);
					recordflag = "Y";
				}

				hshResult.put("hidauto_type", strautotype);
				hshResult.put("vecRow", vecRow);
				hshResult.put("strAppValue", strAppValue);
				hshResult.put("recordflag", recordflag);
			}
		} catch (Exception ce) {
			throw new EJBException("Error in closing getData" + ce.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap updateBoatAutoprim(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshResult = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "",strSecId="",currentdate="",maxno="";
		String strAppValue = correctNull((String) hshValues.get("selapptype"));
		String appid = correctNull((String) hshValues.get("hidapplicantid"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strdateofmanuf = correctNull((String) hshValues.get("txt_dateofmanufac"));
		String prdcode = Helper.correctNull((String) hshValues.get("prdcode"));
		String strhidapplicantid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
		if(strhidapplicantid.equals(""))
		{
			strhidapplicantid = Helper.correctNull((String) hshValues.get("appid"));
		}
		String noOfCustomers="1",strOwnerCount="";
		int intOwnerCount=0,intAtuoCount=0;
		
		ResultSet rs = null,rs1=null;
		
		try {
			SecurityMasterBean SM=new SecurityMasterBean();
			String strAppid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strAppid);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			strOwnerCount=Helper.correctInt((String)hshValues.get("hidOwners"));
			intOwnerCount=Integer.parseInt(strOwnerCount);
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs1=DBUtils.executeLAPSQuery("Sel_MaxId_vehicle^"+strApplicationNo);				 
				if(rs1.next())
				{	
					maxno= rs1.getString("maxid");
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "vehicledetailsinsert1");
				arrValues.add(strApplicationNo);
				arrValues.add("A");
				arrValues.add(correctNull((String) hshValues.get("selectpurdurable")));
				arrValues.add(correctNull((String) hshValues.get("cmbauto_category")));
				String Auto_type=correctNull((String) hshValues.get("cmbauto_category"));
				arrValues.add(correctNull((String) hshValues.get("txtauto_make")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_model")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_article")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_accessories")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_valuation")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_age")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_dealer")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_address1")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_address2")));
				arrValues.add(correctNull((String) hshValues.get("hidcity")));
				arrValues.add(correctNull((String) hshValues.get("hidstate")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_zip")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_phone")));
				arrValues.add(correctNull((String) hshValues.get("selauthdealer")));

				arrValues.add(correctNull((String) hshValues.get("txtestablished")));
				arrValues.add(correctNull((String) hshValues.get("txtdealersince")));
//				arrValues.add(correctNull((String) hshValues.get("txtverf_doneby")));
//				arrValues.add(correctNull((String) hshValues.get("txtverf_doneon")));
//				arrValues.add(correctNull((String) hshValues.get("srcofverf")));
//				arrValues.add(correctNull((String) hshValues.get("refmade")));
//				arrValues.add(correctNull((String) hshValues.get("checkboxapp")));
//				arrValues.add(correctNull((String) hshValues.get("chkboxdealer")));
				if(Auto_type.equalsIgnoreCase("2"))
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_valuation1")));
				else
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_totcost")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_registration")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_chasis")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_engine")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_tax")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_insurance")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_charges")));

				arrValues.add(correctNull((String) hshValues.get("txt_discount")));			
				arrValues.add(correctNull((String) hshValues.get("radio_applicantdrivenvehicle")));
				arrValues.add(correctNull((String) hshValues.get("txt_fuelused")));

				arrValues.add(correctNull((String) hshValues.get("txtauto_vehicles")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_ownername")));
				arrValues.add(correctNull((String) hshValues.get("txa_remarks")));
				arrValues.add(correctNull((String) hshValues.get("txt_userid")));
				arrValues.add(appid);
				arrValues.add(correctNull((String) hshValues.get("sel_vehicletype")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_originalcost")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_actualconsideration")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_leastvalue")));
				arrValues.add(strdateofmanuf);
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_take_over")));
				arrValues.add(correctNull((String) hshValues.get("txt_registration")));
				if(correctNull((String) hshValues.get("sel_vehicletype")).equalsIgnoreCase("1"))
				{
					arrValues.add(correctNull((String) hshValues.get("sel_salrytoSB")));
					arrValues.add(correctNull((String) hshValues.get("sel_undrtkngletter")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
				}
					
				// For Nature of charge in Loan particulars by DINESH on 07/02/2014 
				arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
				
				// For Per_Auto Count
				/*rs = DBUtils.executeLAPSQuery("sel_perAuto_count^" + strApplicationNo);
				if(rs.next())
				{
					intAtuoCount=rs.getInt("auto_count");
				}
				
				if(intAtuoCount==0)
				{
					//strSecId=SM.getOldAppidWithSno(strAppid);
				}
				else
				{
					strSecId = correctNull((String) hshValues.get("hidSecurityId"));
				}*/
				arrValues.add("");
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_oldcar_type")));
				arrValues.add(maxno);
				arrValues.add("Y");
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				/** For inserting Vehicle details in Securities by DINESH on 07/20/2014 **//*
			
				if(intAtuoCount==0)
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_secVechicleDetails");
					
					arrValues.add(strSecId);
					arrValues.add("18");  // Vehicle Sec ID
					
					String strType = correctNull((String) hshValues.get("sel_vehicletype"));
					
					if(strType.equals("1"))
					{
						arrValues.add("74"); // Type - 2 wheeler
					}
					else if(strType.equals("3"))
					{
						arrValues.add("76"); // Type - 4 wheeler
					}
					else
					{
						arrValues.add("");
					}
					arrValues.add("N");
					arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost")));	// For Net Sec Value
					arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
					
					currentdate=Helper.getCurrentDateTime();
					
					arrValues.add(currentdate);
					arrValues.add(currentdate);
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_jointholder")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost")));	// For Residual Value
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
			
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_ownership_securities");
					arrValues.add(strSecId);
					arrValues.add(strAppid);
					arrValues.add(noOfCustomers);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
			
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}	
				else
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_secVechicleDetails");
					
					arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost"))); // For Net Sec Value
					arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_jointholder")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost")));  // For Residual Value
					arrValues.add(strSecId);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				*//** End **//*
				
				// OWNERSHIP DETAILS
				
				if(intAtuoCount==0)
				{
					String strJointOwner=Helper.correctNull((String) hshValues.get("sel_jointholder"));
					if(strJointOwner.equalsIgnoreCase("Y"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();					
						for(int i=1;i<=intOwnerCount;i++)
						{
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							String size=Integer.toString(i);
							int j=i;
							--j;
							if(i==1) //To add the Main Applicant
							{
								arrValues.add(strSecId);
								arrValues.add(strAppid);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
							}
							else //To add Joint Owner newly
							{
								String strOwnerID=Helper.correctNull((String)hshValues.get("hid_jointID["+j+"]"));
								arrValues.add(strSecId);
								arrValues.add(strOwnerID);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
							}
							hshQueryValues.put(Integer.toString(i),hshQuery);
						}
						hshQueryValues.put("size",Integer.toString(intOwnerCount));
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "ins_ownership_securities");
						
						arrValues.add(strSecId);
						arrValues.add(strAppid);
						arrValues.add("1");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
	
					}
				}
				else
				{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_ownership_securities");
					arrValues.add(strSecId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();				
					for(int i=1;i<intOwnerCount;i++)
					{
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						String size=Integer.toString(i);
						if(i==1) //To add the Main Applicant
						{
							arrValues.add(strSecId);
							arrValues.add(strAppid);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						else //To add Joint Owner newly
						{
							String strOwnerID=Helper.correctNull((String)hshValues.get("hid_jointID["+i+"]"));
							arrValues.add(strSecId);
							arrValues.add(strOwnerID);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						hshQueryValues.put(Integer.toString(i),hshQuery);
					}
					hshQueryValues.put("size",Integer.toString(--intOwnerCount));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				*//** For inserting values into app_securitydetails table **//*
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_secDetails");
				arrValues.add(strSecId);
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_securitydetails");
				
				arrValues.add(strApplicationNo);
				arrValues.add(strSecId);
				arrValues.add("1");
				arrValues.add(strAppid);
				arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost")));	//net sec val
				arrValues.add(Helper.correctNull((String) hshValues.get("txtauto_totcost"))); 	//resi val
				arrValues.add("");	//fac type
				arrValues.add("");	//fac nat
				arrValues.add("1");	//sec type
				arrValues.add("");	//loan amt
				arrValues.add("");	//outstanding
				arrValues.add("");	//unsec 
				arrValues.add(strAppid);	//applicant
				arrValues.add("");	//margin
				arrValues.add("");	//fac id
				arrValues.add("P");	//loan type
				arrValues.add("");	//collateral
				arrValues.add("");	//existing
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(strAppid);
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
			
			} 
			else if(strAction.equalsIgnoreCase("update"))
			{
				/*hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add("A");
				arrValues.add(appid);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perdelcollateralauto");
				hshQueryValues.put("1", hshQuery);*/
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add("A");
				arrValues.add(correctNull((String) hshValues.get("selectpurdurable")));
				arrValues.add(correctNull((String) hshValues.get("sel_vehicletype")));
				String Auto_type=correctNull((String) hshValues.get("cmbauto_category"));
				arrValues.add(correctNull((String) hshValues.get("txtauto_make")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_model")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_article")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_accessories")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_valuation")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_age")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_dealer")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_address1")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_address2")));
				arrValues.add(correctNull((String) hshValues.get("hidcity")));
				arrValues.add(correctNull((String) hshValues.get("hidstate")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_zip")));
				arrValues.add(correctNull((String) hshValues.get("txtsup_phone")));
				arrValues.add(correctNull((String) hshValues.get("selauthdealer")));

				arrValues.add(correctNull((String) hshValues.get("txtestablished")));
				arrValues.add(correctNull((String) hshValues.get("txtdealersince")));
//				arrValues.add(correctNull((String) hshValues.get("txtverf_doneby")));
//				arrValues.add(correctNull((String) hshValues.get("txtverf_doneon")));
//				arrValues.add(correctNull((String) hshValues.get("srcofverf")));
//				arrValues.add(correctNull((String) hshValues.get("refmade")));
//				arrValues.add(correctNull((String) hshValues.get("checkboxapp")));
//				arrValues.add(correctNull((String) hshValues.get("chkboxdealer")));
				if(Auto_type.equalsIgnoreCase("2"))
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_valuation1")));
				else
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_totcost")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_registration")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_chasis")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_engine")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_tax")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_insurance")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtauto_charges")));

				arrValues.add(correctNull((String) hshValues.get("txt_discount")));			
				arrValues.add(correctNull((String) hshValues.get("radio_applicantdrivenvehicle")));
				arrValues.add(correctNull((String) hshValues.get("txt_fuelused")));

				arrValues.add(correctNull((String) hshValues.get("txtauto_vehicles")));
				arrValues.add(correctNull((String) hshValues.get("txtauto_ownername")));
				arrValues.add(correctNull((String) hshValues.get("txa_remarks")));
				arrValues.add(correctNull((String) hshValues.get("txt_userid")));
				arrValues.add(appid);
				arrValues.add(correctNull((String) hshValues.get("cmbauto_category")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_originalcost")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_actualconsideration")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_leastvalue")));
				arrValues.add(strdateofmanuf);
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_take_over")));
				arrValues.add(correctNull((String) hshValues.get("txt_registration")));
				if(correctNull((String) hshValues.get("sel_vehicletype")).equalsIgnoreCase("1"))
				{
					arrValues.add(correctNull((String) hshValues.get("sel_salrytoSB")));
					arrValues.add(correctNull((String) hshValues.get("sel_undrtkngletter")));
				}
				else
				{
					arrValues.add("");
					arrValues.add("");
				}
					
				// For Nature of charge in Loan particulars by DINESH on 07/02/2014 
				arrValues.add(correctNull((String) hshValues.get("sel_natureCharge")));
				
				// For Per_Auto Count
				/*rs = DBUtils.executeLAPSQuery("sel_perAuto_count^" + strApplicationNo);
				if(rs.next())
				{
					intAtuoCount=rs.getInt("auto_count");
				}
				
				if(intAtuoCount==0)
				{
					//strSecId=SM.getOldAppidWithSno(strAppid);
				}
				else
				{
					strSecId = correctNull((String) hshValues.get("hidsecID"));
				}*/
				strSecId = correctNull((String) hshValues.get("hidsecID"));
				arrValues.add(strSecId);
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_oldcar_type")));
				arrValues.add("Y");
				arrValues.add(strApplicationNo);
				arrValues.add(Helper.correctNull((String) hshValues.get("hidsnmbr")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId", "vehicledetails_update");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
			}
			else if (strAction.equalsIgnoreCase("delete")) {
				if(correctNull((String) hshValues.get("hidsecID")).equalsIgnoreCase("")){
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("A");
					//arrValues.add(appid);
					arrValues.add(Helper.correctNull((String) hshValues.get("hidsnmbr")));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "perdelcollateralauto");
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}
				else
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("A");
					//arrValues.add(appid);
					arrValues.add(Helper.correctNull((String) hshValues.get("hidsnmbr")));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "perdelcollateralauto");
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					
					String SecID=correctNull((String) hshValues.get("hidSecurityId"));
					String srlno="";
					 if(rs!=null)
						  rs.close();
						rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec_veh^"+strApplicationNo+"^"+SecID);
						if(rs.next())
						{ 
							/*rs1 = DBUtils.executeLAPSQuery("Sel_MaxId_vehicle^"+strApplicationNo);
							if(rs1.next())
							{
								srlno= Helper.correctInt((String)rs1.getString("maxid"));
							}*/

		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();   
		    					arrValues.add(strApplicationNo);	    					
		    					arrValues.add(SecID);	    					
		    					//arrValues.add(srlno);	
		    					arrValues.add(Helper.correctNull((String) hshValues.get("hidsnmbr")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("LOAN_TAKEOVER")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_NATUREOFCHARGE")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLETYPE")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_COMPANY")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLECAT")));	    
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MAKE")));	
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MODEL")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_REGNO")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_HPNO")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_CHASSISNO")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERNAME")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS1")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS2")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCITY")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERSTATE")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERPIN")));	    					
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCONT")));
		    					arrValues.add("N");	
		    					arrValues.add("A");	
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PURCHASEVALUE")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_AGE")));
		    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_BOOKVALUE")));
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","ins_proposedasset_vehicle");
		    					hshQueryValues.put("size","2");
		    					hshQueryValues.put("2",hshQuery);
						}
				}
				/* For deleting Vehicle loan details in Securities by DINESH */
				
				/*hshQuery = new HashMap();
				arrValues = new ArrayList();
				strSecId=correctNull((String) hshValues.get("hidSecurityId"));
				hshQuery.put("strQueryId", "del_securities");
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_ownership_securities");
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size", "3");*/
				/* End */
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			String strauto_type = correctNull((String) hshValues
					.get("hidauto_type"));
			hshpasValues.put("appno", strApplicationNo);
			hshpasValues.put("hidauto_type", strauto_type);
			hshpasValues.put("selapptype", strAppValue);
			hshpasValues.put("appid", appid);
			hshpasValues.put("prdcode", prdcode);
			hshpasValues.put("strProductType", Helper.correctNull((String)hshValues.get("strProductType")));
			hshResult = getBoatAuto(hshpasValues);
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert"))
			{
				sbAuditTrial
					.append("Brand Name ="+ correctNull((String) hshValues.get("txtauto_article")))
					.append("~Purchase of Vehicle =")
					.append(ApplicantParams.getApplicantParams("Purchase_vehicle",correctNull((String) hshValues.get("selectpurdurable"))))
					.append("~Type =")
					.append(ApplicantParams.getApplicantParams("Type_vehicle",correctNull((String) hshValues.get("sel_vehicletype"))))
					.append("~Category =")
					.append(ApplicantParams.getApplicantParams("Category_vehicle",correctNull((String) hshValues.get("cmbauto_category"))))
					.append("~Model =")
					.append(correctNull((String) hshValues.get("txtauto_model")))
					.append("~Make =")
					.append(correctNull((String) hshValues.get("txtauto_make")));
			if (correctNull((String) hshValues.get("cmbauto_category")).equalsIgnoreCase("1")) {
				sbAuditTrial.append("~Cost Price of the Vehicle=")
						.append(correctNull((String) hshValues.get("txtauto_valuation")))
						.append("~Price For Accessories/Body Building =")
						.append(correctNull((String) hshValues.get("txtauto_accessories")))
						.append("~Tax=")
						.append(correctNull((String) hshValues.get("txtauto_tax")))
						.append("~Insurance=")
						.append(correctNull((String) hshValues.get("txtauto_insurance")))
						.append("~Other Charges=")
						.append(correctNull((String) hshValues.get("txtauto_charges")))
						.append("~Discount=")
						.append(correctNull((String) hshValues.get("txt_discount")))
						.append("~Total Cost =")
						.append(correctNull((String) hshValues.get("txtauto_totcost")));
			} else if (correctNull((String) hshValues.get("cmbauto_category")).equalsIgnoreCase("2")) {
				sbAuditTrial.append("~Date of Manufacture=")
						.append(correctNull((String) hshValues.get("txt_dateofmanufac")))
						.append("~Age of Vehicle =")
						.append(correctNull((String) hshValues.get("txtauto_age")))
						.append("~Original Cost of the Vehicle=")
						.append(correctNull((String) hshValues.get("txt_originalcost")))
						.append("~Valuation of the Vehicle=")
						.append(correctNull((String) hshValues.get("txtauto_valuation1")))
						.append("~Actual Consideration paid by purchaser=")
						.append(correctNull((String) hshValues.get("txt_actualconsideration")))
						.append("~Least Value of the above =").append(correctNull((String) hshValues.get("txt_leastvalue")))
						.append("~Name of the Owner=")
						.append(correctNull((String) hshValues.get("txtauto_ownername")));
			}
			sbAuditTrial.append("~Registration No =")
					.append(correctNull((String) hshValues.get("txtauto_registration")))
					.append("~Chasis No  =")
					.append(correctNull((String) hshValues.get("txtauto_chasis")))
					.append("~Engine No  =")
					.append(correctNull((String) hshValues.get("txtauto_engine")))
					.append("~Fuel Used =")
					.append(ApplicantParams.getApplicantParams("Fuel",correctNull((String) hshValues.get("txt_fuelused"))))
					.append("~Vehicle to be Driven By Applicant =")
					.append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String) hshValues.get("radio_applicantdrivenvehicle"))))
					.append("~If Transport Operator No. of Vehicles Owned =")
					.append(correctNull((String) hshValues.get("txtauto_vehicles")))
					.append("~Name of the Supplier =")
					.append(correctNull((String) hshValues.get("txtauto_dealer")))
					.append("~Address  =")
					.append(correctNull((String) hshValues.get("txtsup_address1")))
					.append(",<br>")
					.append(correctNull((String) hshValues.get("txtsup_address2")))
					.append("~City  =")
					.append(correctNull((String) hshValues.get("txtsup_city")))
					.append("~State  =")
					.append(correctNull((String) hshValues.get("txtsup_state")))
					.append("~Pin Code =")
					.append(correctNull((String) hshValues.get("txtsup_zip")))
					.append("~Phone No =")
					.append(correctNull((String) hshValues.get("txtsup_phone")))
					.append("~Authorised Dealer  =")
					.append(SetupParams.getSetupParams("Education",correctNull((String) hshValues.get("selauthdealer"))))
					.append("~Dealer Since  =")
					.append(correctNull((String) hshValues.get("txtdealersince")));
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("hidAction", "update");
				}
			}
			AuditTrial.auditLog(hshValues, "35", strApplicationNo, sbAuditTrial.toString());
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		return hshResult;
	}

	public HashMap getUsers(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrUsers = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("selusers");
			while (rs.next()) {
				arrUsers.add(rs.getString(1));
			}
			hshRecord.put("arrUsers", arrUsers);
			return hshRecord;
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
	}

	public void updateVerification(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String strApplicationNo = "";
		String strAction = correctNull((String) hshValues.get("hidAction"));

		try {
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			
			/*** For Audit Trial Old Data - By Guhan.T on 15/10/2013 ***/
			
			StringBuilder sboldAudit = new StringBuilder();
			if(!strApplicationNo.equalsIgnoreCase(""))
			{
				String strQuery = SQLParser.getSqlQuery("selverification^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strsource=Helper.correctNull(rs.getString("verify_source"));
					String strreference=Helper.correctNull(rs.getString("verify_reference"));
					String strapplicantgenuine=Helper.correctNull(rs.getString("verify_applicantremark"));
					String strdocumentgenuine=Helper.correctNull(rs.getString("verify_documentrerk"));
					String strsourceopt="";
					String strrefopt="";
					String strapplicantgenuineopt="";
					String strdocumentgenuineopt="";
			
					if(strsource.equalsIgnoreCase("001"))
						strsourceopt="Ration Card";
					else if(strsource.equalsIgnoreCase("002"))
						strsourceopt="Voter ID";
					else if(strsource.equalsIgnoreCase("003"))
						strsourceopt="Driving License";
					else if(strsource.equalsIgnoreCase("004"))
						strsourceopt="PAN Card";
					
					if(strreference.equalsIgnoreCase("0"))
						strrefopt="--Select--";
					else if(strreference.equalsIgnoreCase("1"))
						strrefopt="The Manufactures / Their Reg.Office";
					else if(strreference.equalsIgnoreCase("2"))
						strrefopt="Visit made";
					else if(strreference.equalsIgnoreCase("3"))
						strrefopt="Local Dealer of same or similar product";
					
					if(strapplicantgenuine.equalsIgnoreCase("Y"))
						strapplicantgenuineopt="Yes";
					else strapplicantgenuineopt="No";
			
					if(strdocumentgenuine.equalsIgnoreCase("Y"))
						strdocumentgenuineopt="Yes";
					else strdocumentgenuineopt="No";
					
					sboldAudit.append("~Verification done by =")
					.append(Helper.correctNull(rs.getString("verify_doneby")))
					.append(" - ")
					.append(Helper.correctNull(rs.getString("verify_donebyname")))
					.append("~Verified On: =")
					.append(Helper.correctNull(rs.getString("verify_doneon")))
					.append("~Source of verification/identification of the applicant =")
					.append(strsourceopt)
					.append("~Reference made =")
					.append(strrefopt)
					.append("~Remarks of the Official - (a) Applicant : Genuine =")
					.append(strapplicantgenuineopt)
					.append("~(b) documents submitted by applicant:geniune =")
					.append(strdocumentgenuineopt);
			}
			if(rs!=null)
				{
					rs.close();
				}
		}
	/*** End of audit trial old data ***/
			
			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);

				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delverification");
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insverification");
				arrValues.add(strApplicationNo);

				arrValues.add(correctNull((String) hshValues.get("txt_userid")));
				arrValues.add(correctNull((String) hshValues.get("txtverf_doneon")));
				arrValues.add(correctNull((String) hshValues.get("srcofverf")));
				arrValues.add(correctNull((String) hshValues.get("refmade")));
				arrValues.add(correctNull((String) hshValues.get("checkboxapp")));
				arrValues.add(correctNull((String) hshValues.get("chkboxdealer")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);

				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delverification");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}

			/*** For Audit Trial new Data - By Guhan.T on 11/10/2013 ***/
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strApplicationNo.equalsIgnoreCase(""))
			{
			sbAuditTrial
					.append("~Verification done by =")
					.append(correctNull((String) hshValues.get("txt_userid")))
					.append(" - ")
					.append(correctNull((String) hshValues.get("txtverf_doneby")))
					.append("~Verified On: =")
					.append(correctNull((String) hshValues.get("txtverf_doneon")))
					.append("~Source of verification/identification of the applicant =")
					.append(correctNull((String) hshValues.get("hidsrcofverf")))
					.append("~Reference made =")
					.append(ApplicantParams.getApplicantParams("Reference",	correctNull((String) hshValues.get("refmade"))))
					.append("~Remarks of the Official - (a) Applicant : Genuine =")
					.append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String) hshValues.get("checkboxapp"))))
					.append("~(b) documents submitted by applicant:geniune =")
					.append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String) hshValues.get("chkboxdealer"))));
			
				if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");
			
			AuditTrial.auditNewLog(hshValues, "240", strApplicationNo,sbAuditTrial.toString(),sboldAudit.toString());
			}
			
			/*** End of audit trial new data ***/ 
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public HashMap getVerification(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String recordflag = "N";
		try {
			String appno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("selverification^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("VERIFY_DONEBY", correctNull((String) rs
						.getString("VERIFY_DONEBY")));
				hshRecord.put("VERIFY_DONEBYNAME", correctNull((String) rs
						.getString("VERIFY_DONEBYNAME")));
				hshRecord.put("VERIFY_DONEON", correctNull((String) rs
						.getString("VERIFY_DONEON")));
				hshRecord.put("VERIFY_SOURCE", correctNull((String) rs
						.getString("VERIFY_SOURCE")));
				hshRecord.put("VERIFY_REFERENCE", correctNull((String) rs
						.getString("VERIFY_REFERENCE")));
				hshRecord.put("VERIFY_APPLICANTREMARK", correctNull((String) rs
						.getString("VERIFY_APPLICANTREMARK")));
				hshRecord.put("VERIFY_DOCUMENTRERK", correctNull((String) rs
						.getString("VERIFY_DOCUMENTRERK")));
				recordflag = "Y";
			}
			hshRecord.put("recordflag", recordflag);
			
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+appno);
			if(rs.next())
			{
				hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
				
			//for checking freeze count
			if (rs != null) {
				rs.close();
			}
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
			
			
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getStaffvechicle(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String appno = correctNull((String) hshValues.get("appno"));
		String manufacdate = correctNull((String) hshValues.get("vehimanudate"));
		String receivedate = "", strQuery = "", years = "0";
		try {
			rs = DBUtils.executeLAPSQuery("getLoanReceivedate^" + appno);
			if (rs.next()) {
				receivedate = Helper.correctNull((String) rs
						.getString("loan_receivedate"));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getDiffvehicledate^"
					+ receivedate + "^" + manufacdate);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				years = Helper.correctNull((String) rs.getString("years"));
			}
			hshResult.put("years", years);
		} catch (Exception e) {
			throw new EJBException("Error in getStaffvechicle:-"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException(
						"Error while Closing Connection in getStaffvechicle:-"
								+ e.getMessage());
			}
		}
		return hshResult;
	}
}

/*
 * public void updateDataVehicleinfo(HashMap hshValues)  {
 * HashMap hshQuery = new HashMap(); HashMap hshQueryValues = new HashMap();
 * ArrayList arrValues ; ArrayList arrValues1; ResultSet rs=null; String
 * strAction=null; String strappno=""; try { String strinfomantname1=""; String
 * strinfomantname2=""; String strinfomantname3=""; String []strquesno=null;
 * String []stranswer1=null; String []stranswer2=null; String []stranswer3=null;
 * int intUpdatesize = 0; intUpdatesize=intUpdatesize+1; strAction
 * =correctNull((String)hshValues.get("hidAction")); strinfomantname1
 * =Helper.correctNull((String)hshValues.get("textfield")); strinfomantname2
 * =Helper.correctNull((String)hshValues.get("textfield2")); strinfomantname3
 * =Helper.correctNull((String)hshValues.get("textfield3"));
 * strquesno=(String[])hshValues.get("txt_staticdataid2"); stranswer1 =
 * (String[])hshValues.get("sel_option"); stranswer2=
 * (String[])hshValues.get("sel_infomant2answer"); stranswer3=
 * (String[])hshValues.get("sel_infomant3answer"); strappno =
 * Helper.correctNull((String)hshValues.get("appno1")); int
 * len=strquesno.length; if(strAction.equals("update")) { hshQueryValues = new
 * HashMap(); hshQuery=new HashMap(); arrValues=new ArrayList();
 * hshQuery.put("strQueryId","del_conf_info"); arrValues.add(strappno);
 * hshQuery.put("arrValues", arrValues); hshQuery.put("size","1");
 * hshQueryValues.put("1", hshQuery); hshQueryValues.put("size","1");
 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
 * arrValues1=new ArrayList(); hshQueryValues = new HashMap(); hshQuery=new
 * HashMap(); hshQuery.put("strQueryId","del_conf_informants");
 * arrValues1.add(strappno); hshQuery.put("arrValues",arrValues1);
 * hshQuery.put("size","1"); hshQueryValues.put("1", hshQuery);
 * hshQueryValues.put("size","1");
 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
 * 
 * for(int k=0;k<len;k++) { hshQuery.put("strQueryId","ins_conf_info");
 * arrValues=new ArrayList(); arrValues.add(strappno);
 * arrValues.add(strquesno[k]); arrValues.add(stranswer1[k]);
 * arrValues.add(stranswer2[k]); arrValues.add(stranswer3[k]);
 * hshQuery.put("arrValues",arrValues); hshQueryValues.put("1",hshQuery);
 * hshQueryValues.put("size","1");
 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); }
 * hshQuery=new HashMap(); hshQueryValues=new HashMap(); arrValues=new
 * ArrayList(); hshQuery.put("strQueryId","ins_conf_informants"); arrValues=new
 * ArrayList(); arrValues.add(strappno); arrValues.add(strinfomantname1);
 * arrValues.add(strinfomantname2); arrValues.add(strinfomantname3);
 * hshQuery.put("arrValues",arrValues); hshQueryValues.put("1",hshQuery);
 * hshQueryValues.put("size","1");
 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); } }
 * catch(Exception e) { throw new EJBException(e.getMessage()); } finally { try {
 * if(rs != null) { rs.close(); } } catch(Exception e1) { throw new
 * EJBException(e1.getMessage()); } } }
 */

/*
 * public HashMap getVehicleData(HashMap hshValues)  { String
 * loan_periodicity=""; String perapp_status=""; String perapp_sex =""; String
 * perapp_marstat=""; String perapp_category=""; String perapp_religion1="";
 * String perapp_religion=""; String loan_repaymenttype=""; ResultSet rs=null;
 * HashMap hshRecord = new HashMap(); String appname; String perapp_title;
 * String perapp_husname; String perapp_fatname; ArrayList vecRow = new ArrayList();
 * ArrayList vecCol = new ArrayList(); ArrayList vecData= new ArrayList(); ArrayList vecRow1 =
 * new ArrayList(); ArrayList vecCol1 = new ArrayList(); ArrayList vecRow2 = new ArrayList();
 * ArrayList vecCol2= new ArrayList(); ArrayList vecRow3 = new ArrayList(); ArrayList vecCol3 =
 * new ArrayList(); ArrayList vecRow4 = new ArrayList(); ArrayList vecCol4 = new ArrayList();
 * 
 * try { String strappid=Helper.correctNull((String)hshValues.get("comappid"));
 * rs=DBUtils.executeLAPSQuery("seldocumentdetails^"+strappid); if (rs.next()) {
 * perapp_title=correctNull(rs.getString("perapp_title"));
 * perapp_title=perapp_title.toUpperCase();
 * hshRecord.put("perapp_title",perapp_title);
 * appname=correctNull(rs.getString("appname")); appname=appname.toUpperCase();
 * hshRecord.put("appname",appname);
 * hshRecord.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
 * hshRecord.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
 * hshRecord.put("perapp_address3",correctNull(rs.getString("perapp_address3")));
 * hshRecord.put("perapp_city",correctNull(rs.getString("perapp_city")));
 * hshRecord.put("perapp_state",correctNull(rs.getString("perapp_state")));
 * hshRecord.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
 * hshRecord.put("perapp_dob",correctNull(rs.getString("perapp_dob"))); String
 * dateofbirth=correctNull(rs.getString("perapp_dob")); String
 * currentdate=Helper.getCurrentDateTime(); dateofbirth =
 * dateofbirth.substring(6, 10); currentdate = currentdate.substring(6, 10);
 * String strAge = Integer.toString(Integer.parseInt(currentdate)-
 * Integer.parseInt(dateofbirth));
 * perapp_husname=correctNull(rs.getString("perapp_husname"));
 * perapp_husname=perapp_husname.toUpperCase(); hshRecord.put("age",strAge);
 * hshRecord.put("perapp_husname",perapp_husname);
 * perapp_fatname=correctNull(rs.getString("perapp_fatname"));
 * perapp_fatname=perapp_fatname.toUpperCase();
 * hshRecord.put("perapp_fatname",perapp_fatname);
 * hshRecord.put("perapp_hname",correctNull(rs.getString("perapp_hname")));
 * hshRecord.put("perapp_date",correctNull(rs.getString("perapp_date")));
 * hshRecord.put("perapp_phone",correctNull(rs.getString("PERAPP_PHONE")));
 * hshRecord.put("perapp_sex",correctNull(rs.getString("perapp_sex")));
 * hshRecord.put("perapp_religion",correctNull(rs.getString("perapp_religion")));
 * hshRecord.put("org_name",correctNull(rs.getString("org_name")));
 * hshRecord.put("org_add1",correctNull(rs.getString("org_add1")));
 * hshRecord.put("org_add2",correctNull(rs.getString("org_add2")));
 * hshRecord.put("org_city",correctNull(rs.getString("org_city")));
 * hshRecord.put("org_state",correctNull(rs.getString("org_state")));
 * hshRecord.put("org_zip",correctNull(rs.getString("org_zip")));
 * hshRecord.put("acc_type",correctNull(rs.getString("perapp_bankacctype")));
 * hshRecord.put("acc_no",correctNull(rs.getString("perapp_bankaccno")));
 * hshRecord.put("perapp_bank",correctNull(rs.getString("perapp_bank"))); }
 * rs=DBUtils.executeLAPSQuery("refdetails^"+strappid);
 * 
 * while (rs.next()) { vecCol2 = new ArrayList();
 * vecCol2.add(rs.getString("ref_name"));
 * vecCol2.add(rs.getString("ref_design"));
 * vecCol2.add(rs.getString("ref_phoneno"));
 * vecCol2.add(rs.getString("ref_oth_details"));
 * vecRow2.add(vecCol2); } hshRecord.put("vecRow2",vecRow2); String appno =
 * correctNull((String) hshValues.get("appno"));
 * rs=DBUtils.executeLAPSQuery("selmargindetails^"+appno);
 * 
 * if (rs.next()) {
 * hshRecord.put("loanintrate",correctNull(rs.getString("loanintrate")));
 * hshRecord.put("loanmargin",correctNull(rs.getString("loanmargin")));
 * hshRecord.put("loancreatedate",correctNull(rs.getString("loancreatedate")));
 * hshRecord.put("loanemi",correctNull(rs.getString("loanemi")));
 * hshRecord.put("repaymenttype",correctNull(rs.getString("repaymenttype")));
 * hshRecord.put("lterms",correctNull(rs.getString("lterms"))); }
 * rs=DBUtils.executeLAPSQuery("vehicledetails^"+appno);
 * 
 * if (rs.next()) {
 * hshRecord.put("auto_dealer",correctNull(rs.getString("auto_dealer")));
 * hshRecord.put("auto_deleraddress1",correctNull(rs.getString("auto_deleraddress1")));
 * hshRecord.put("auto_deleraddress2",correctNull(rs.getString("auto_deleraddress2")));
 * hshRecord.put("estb_year",correctNull(rs.getString("estb_year")));
 * hshRecord.put("auto_delercity",correctNull(rs.getString("auto_delercity")));
 * hshRecord.put("auto_delerstate",correctNull(rs.getString("auto_delerstate")));
 * hshRecord.put("auto_delerphone",correctNull(rs.getString("auto_delerphone")));
 * hshRecord.put("dealer_since",correctNull(rs.getString("dealer_since")));
 * hshRecord.put("ref_made",correctNull(rs.getString("ref_made")));
 * hshRecord.put("remark_app",correctNull(rs.getString("remark_app")));
 * hshRecord.put("remark_gen",correctNull(rs.getString("remark_gen")));
 * hshRecord.put("auto_userid",correctNull(rs.getString("auto_userid")));
 * hshRecord.put("verf_doneby",correctNull(rs.getString("verf_doneby")));
 * hshRecord.put("auth_dealer",correctNull(rs.getString("auth_dealer")));
 * hshRecord.put("src_verification",correctNull(rs.getString("src_verification"))); }
 * rs=DBUtils.executeLAPSQuery("Gdetails1^"+appno);
 * 
 * while (rs.next()) { String dtype=correctNull(rs.getString("demo_type"));
 * if(dtype.equalsIgnoreCase("G")) {
 * appname=correctNull(rs.getString("appname")); appname=appname.toUpperCase();
 * hshRecord.put("appname1",appname);
 * hshRecord.put("perapp_title1",correctNull(rs.getString("perapp_title")));
 * hshRecord.put("perapp_address11",correctNull(rs.getString("perapp_address1")));
 * hshRecord.put("perapp_address21",correctNull(rs.getString("perapp_address2")));
 * hshRecord.put("perapp_address31",correctNull(rs.getString("perapp_address3")));
 * hshRecord.put("perapp_city1",correctNull(rs.getString("perapp_city")));
 * hshRecord.put("perapp_state1",correctNull(rs.getString("perapp_state")));
 * hshRecord.put("perapp_zip1",correctNull(rs.getString("perapp_zip")));
 * perapp_husname=correctNull(rs.getString("perapp_husname"));
 * perapp_husname=perapp_husname.toUpperCase();
 * hshRecord.put("perapp_husname1",perapp_husname);
 * perapp_fatname=correctNull(rs.getString("perapp_fatname"));
 * perapp_fatname=perapp_fatname.toUpperCase();
 * hshRecord.put("perapp_fatname1",perapp_fatname);
 * hshRecord.put("perapp_hname1",correctNull(rs.getString("perapp_hname")));
 * hshRecord.put("perapp_sex1",correctNull(rs.getString("perapp_sex"))); }
 * vecRow = new ArrayList(); if(dtype.equalsIgnoreCase("C")) {
 *  } } rs=DBUtils.executeLAPSQuery("Cdetails^"+appno);
 * 
 * 
 * while(rs.next()) { vecCol = new ArrayList();
 * vecCol.add(rs.getString("appname"));
 * vecCol.add(rs.getString("perapp_title"));
 * vecCol.add(rs.getString("perapp_address1"));
 * vecCol.add(rs.getString("perapp_address2"));
 * vecCol.add(rs.getString("perapp_address3"));
 * vecCol.add(rs.getString("perapp_city"));
 * vecCol.add(rs.getString("perapp_state"));
 * vecCol.add(rs.getString("perapp_zip"));
 * vecCol.add(rs.getString("perapp_husname"));
 * vecCol.add(rs.getString("perapp_fatname"));
 * vecCol.add(rs.getString("perapp_hname"));
 * vecCol.add(rs.getString("perapp_sex")); vecRow.add(vecCol); }
 * hshRecord.put("vecRow",vecRow);
 * 
 * rs=DBUtils.executeLAPSQuery("SancAmt^"+appno);
 * 
 * if (rs.next()) {
 * hshRecord.put("Sanction_Amt",correctNull(rs.getString("Sanction_Amount")));
 * hshRecord.put("Sanction_Date",correctNull(rs.getString("Sancdate")));
 * hshRecord.put("appcom_date",correctNull(rs.getString("appcom_date"))); }
 * rs=DBUtils.executeLAPSQuery("primarySecurity^"+appno);
 * 
 * if (rs.next()) {
 * hshRecord.put("prop_houseno",correctNull(rs.getString("prop_houseno")));
 * hshRecord.put("prop_area",correctNull(rs.getString("prop_area")));
 * hshRecord.put("prop_city",correctNull(rs.getString("prop_city")));
 * hshRecord.put("prop_state",correctNull(rs.getString("prop_state")));
 * hshRecord.put("prop_pin",correctNull(rs.getString("prop_pin")));
 * hshRecord.put("prop_builtup",correctNull(rs.getString("prop_builtup"))); }
 * rs=DBUtils.executeLAPSQuery("assetDocdet^"+appno);
 * 
 * while(rs.next()) { vecCol1 = new ArrayList();
 * vecCol1.add(rs.getString("asset_assdetails"));
 * vecRow1.add(vecCol1); } hshRecord.put("vecRow1",vecRow1);
 * rs=DBUtils.executeLAPSQuery("Docinterestrate^"+appno);
 * 
 * if(rs.next()) {
 * hshRecord.put("loan_modintrate",correctNull(rs.getString("loan_modintrate")));
 * hshRecord.put("loan_purposeofloan",correctNull(rs.getString("loan_purposeofloan"))); }
 * rs=DBUtils.executeLAPSQuery("pergetfinancialliab^"+appno);
 * 
 * while (rs.next()) { vecCol3 = new ArrayList();
 * vecCol3.add(rs.getString("liab_company"));
 * vecCol3.add(rs.getString("liab_crdlimit"));
 * vecRow3.add(vecCol3); } hshRecord.put("vecRow3",vecRow3);
 * 
 * vecData= new ArrayList(); rs=DBUtils.executeLAPSQuery("sel_sec_test^"+appno);
 * 
 * while(rs.next()) { vecRow = new ArrayList(); vecRow.add(rs.getString(3));
 * vecRow.add(rs.getString(4)); vecRow.add(rs.getString(5));
 * vecRow.add(rs.getString(8)); vecRow.add(rs.getString(7));
 * vecRow.add(rs.getString(9)); vecData.add(vecRow); }
 * hshRecord.put("vecData",vecData);
 * rs=DBUtils.executeLAPSQuery("apptermscondsel^"+appno);
 * 
 * while(rs.next()) { vecCol4 = new ArrayList();
 * vecCol4.add(rs.getString("app_termscontent"));
 * vecRow4.add(vecCol4); } hshRecord.put("vecRow4",vecRow4);
 * rs=DBUtils.executeLAPSQuery("pergetEmployer^"+strappid);
 * 
 * if (rs.next()) {
 * hshRecord.put("peremp_name",correctNull(rs.getString("peremp_name")));
 * hshRecord.put("peremp_address1",correctNull(rs.getString("peremp_address1")));
 * hshRecord.put("peremp_address2",correctNull(rs.getString("peremp_address2")));
 * hshRecord.put("peremp_address3",correctNull(rs.getString("peremp_address3")));
 * hshRecord.put("peremp_city",correctNull(rs.getString("peremp_city")));
 * hshRecord.put("peremp_state",correctNull(rs.getString("peremp_state")));
 * hshRecord.put("peremp_zip",correctNull(rs.getString("peremp_zip")));
 * hshRecord.put("peremp_occupation",correctNull(rs.getString("peremp_occupation")));
 * hshRecord.put("peremp_yresemp",correctNull(rs.getString("peremp_yresemp")));
 * hshRecord.put("peremp_phone",correctNull(rs.getString("peremp_phone")));
 * hshRecord.put("peremp_design",correctNull(rs.getString("peremp_design"))); }
 * rs=DBUtils.executeLAPSQuery("selappraisalsanc1^"+appno);
 * 
 * if(rs.next()) {
 * hshRecord.put("applname",correctNull(rs.getString("applname")));
 * perapp_status=correctNull(rs.getString("perapp_status"));
 * if(perapp_status.equalsIgnoreCase("1")) { perapp_status="NRI"; } else {
 * perapp_status="Resident"; } hshRecord.put("perapp_status",perapp_status);
 * perapp_religion=correctNull(rs.getString("perapp_religion"));
 * perapp_sex=correctNull(rs.getString("perapp_sex"));
 * if(perapp_sex.equalsIgnoreCase("M")) { perapp_sex="Male"; } else {
 * perapp_sex="Female"; } hshRecord.put("perapp_sex",perapp_sex);
 * perapp_marstat=correctNull(rs.getString("perapp_marstat"));
 * if(perapp_marstat.equalsIgnoreCase("1")) { perapp_marstat ="Married"; } else
 * if(perapp_marstat.equalsIgnoreCase("2")) { perapp_marstat ="Single"; } else
 * if(perapp_marstat.equalsIgnoreCase("3")) { perapp_marstat ="Divorced"; } else
 * if(perapp_marstat.equalsIgnoreCase("4")) { perapp_marstat ="Widowed"; }
 * perapp_category=Helper.correctNull((String)rs.getString("perapp_category"));
 * 
 * if(perapp_category.equalsIgnoreCase("1")) { perapp_category ="SC & Minority"; }
 * else if(perapp_category.equalsIgnoreCase("2")) { perapp_category ="SC"; }
 * else if(perapp_category.equalsIgnoreCase("3")) { perapp_category ="ST"; }
 * else if(perapp_category.equalsIgnoreCase("4")) { perapp_category ="OBC"; }
 * else if(perapp_category.equalsIgnoreCase("5")) { perapp_category ="Other"; }
 * else if(perapp_category.equalsIgnoreCase("6")) { perapp_category ="Minority"; }
 * else if(perapp_category.equalsIgnoreCase("7")) { perapp_category ="General"; }
 * 
 * if(perapp_category.equalsIgnoreCase("6")) {
 * if(perapp_religion.equalsIgnoreCase("1")) { perapp_religion1 ="Hindu"; } else
 * if(perapp_religion.equalsIgnoreCase("2")) { perapp_religion1 ="Christian"; }
 * else if(perapp_religion.equalsIgnoreCase("3")) { perapp_religion1 ="Muslim"; }
 * else if(perapp_religion.equalsIgnoreCase("4")) { perapp_religion1 ="Sikhs"; }
 * else if(perapp_religion.equalsIgnoreCase("5")) { perapp_religion1
 * ="Neo-Budhist"; } else if(perapp_religion.equalsIgnoreCase("6")) {
 * perapp_religion1 ="Anglo-Indian"; } else
 * if(perapp_religion.equalsIgnoreCase("7")) { perapp_religion1 ="Zorastrian"; } }
 * hshRecord.put("perapp_religion1",perapp_religion1);
 * hshRecord.put("perapp_category",perapp_category);
 * hshRecord.put("perapp_marstat",perapp_marstat);
 * hshRecord.put("app_createdate",correctNull(rs.getString("app_createdate")));
 * hshRecord.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
 * hshRecord.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
 * hshRecord.put("perapp_city",correctNull(rs.getString("perapp_city")));
 * hshRecord.put("perapp_state",correctNull(rs.getString("perapp_state")));
 * hshRecord.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
 * hshRecord.put("catdesc",correctNull(rs.getString("catdesc")));
 * hshRecord.put("subcatdesc",correctNull(rs.getString("subcatdesc")));
 * hshRecord.put("loan_modintrate",correctNull(rs.getString("loan_modintrate")));
 * hshRecord.put("loan_inttype",correctNull(rs.getString("loan_inttype")));
 * hshRecord.put("loan_costloanprd",correctNull(rs.getString("loan_costloanprd")));
 * hshRecord.put("loan_emi",correctNull(rs.getString("loan_emi")));
 * hshRecord.put("loan_reqterms",correctNull(rs.getString("loan_reqterms")));
 * hshRecord.put("loan_recmdamt",correctNull(rs.getString("loan_recmdamt")));
 * hshRecord.put("loan_purposeofloan",correctNull(rs.getString("prd_desc")));
 * if(loan_repaymenttype.equalsIgnoreCase("1")) { loan_repaymenttype="Equated
 * Monthly Installment"; } else if(loan_repaymenttype.equalsIgnoreCase("2")) {
 * loan_repaymenttype="Structured Repayment Schedule"; } else
 * if(loan_repaymenttype.equalsIgnoreCase("3")) {
 * loan_repaymenttype="OverDraft"; }
 * loan_repaymenttype=correctNull(rs.getString("loan_repaymenttype"));
 * hshRecord.put("loan_repaymenttype",loan_repaymenttype);
 * hshRecord.put("loan_margin",correctNull(rs.getString("loan_margin")));
 * hshRecord.put("prd_desc",correctNull(rs.getString("prd_desc")));
 * hshRecord.put("prdcode",correctNull(rs.getString("prd_code")));
 * hshRecord.put("recamt",correctNull(rs.getString("loan_recmdamt")));
 * hshRecord.put("terms",correctNull(rs.getString("loan_reqterms")));
 * hshRecord.put("inttype",correctNull(rs.getString("loan_inttype")));
 * hshRecord.put("loan_filedon",correctNull(rs.getString("loan_filedon")));
 * hshRecord.put("orgcity",correctNull(rs.getString("org_city")));
 * hshRecord.put("orgname",correctNull(rs.getString("org_name")));
 * hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
 * hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
 * hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
 * hshRecord.put("orgstate",correctNull(rs.getString("org_state")));
 * hshRecord.put("app_processdate",correctNull(rs.getString("app_processdate")));
 * hshRecord.put("app_approvedby",correctNull(rs.getString("app_approvedby")));
 * hshRecord.put("loan_interestcharged",correctNull(rs.getString("loan_interestcharged")));
 * hshRecord.put("loan_bank_refno",correctNull(rs.getString("loan_bank_refno")));
 * hshRecord.put("loan_repaycapacity",correctNull(rs.getString("loan_repaycapacity"))); }
 * try { if(rs != null) rs.close(); } catch(Exception cf) { throw new
 * EJBException("Error closing the ResultSet1 "+cf.getMessage()); }
 * rs=DBUtils.executeLAPSQuery("securesel^"+appno);
 * 
 * if(rs.next()) {
 * hshRecord.put("loan_noofinstallment",(String)correctNull(rs.getString("loan_noofinstallment")));
 * loan_periodicity=correctNull(rs.getString("loan_periodicity"));
 * if(loan_periodicity.equalsIgnoreCase("m")) { loan_periodicity="Monthly"; }
 * else if(loan_periodicity.equalsIgnoreCase("q")) {
 * loan_periodicity="Quarterly"; } else
 * if(loan_periodicity.equalsIgnoreCase("h")) { loan_periodicity="Haly-Yearly"; }
 * else if(loan_periodicity.equalsIgnoreCase("y")) { loan_periodicity="Yearly"; }
 * else { loan_periodicity="Others"; }
 * hshRecord.put("loan_periodicity",loan_periodicity);
 * hshRecord.put("loan_servised",(String)correctNull(rs.getString("loan_servised"))); }
 * try { if(rs != null) rs.close(); } catch(Exception cf) { throw new
 * EJBException("Error closing the d=> "+cf.getMessage()); } } catch(Exception
 * e) { throw new EJBException("Error in getApplicantIDHelp "+e.getMessage()); }
 * finally { try { if(rs!=null) { rs.close(); }
 *  } catch(Exception e) { throw new EJBException("Error in closing Connection
 * "+e.getMessage()); } } return hshRecord; }
 */

/*
 * public HashMap getDataVechicleinfo(HashMap hshValues)  {
 * ResultSet rs = null; ResultSet rs1 = null; ResultSet rs2 = null; HashMap
 * hshRecord = new HashMap(); ArrayList vecData = new ArrayList(); ArrayList vecRec1 =
 * new ArrayList(); ArrayList vecData2=new ArrayList();; ArrayList vecRec2=new ArrayList();;
 * String strAction=null; String strappno=""; int vecsize=0; int vecsize1=0;
 * 
 * try { strAction ="select";
 * rs=DBUtils.executeLAPSQuery("sel_pervehicleinfoquestion"); vecData=new
 * ArrayList(); vecRec2=new ArrayList(); vecData2=new ArrayList(); String strInfomanttype =
 * ""; strInfomanttype =
 * Helper.correctNull((String)hshValues.get("sel_infomanttype")); while
 * (rs.next()) { vecRec1=new ArrayList();
 * vecRec1.add(correctNull(rs.getString("stat_data_sno")));
 * vecRec1.add(correctNull(rs.getString("stat_data_desc")));
 * vecData.add(vecRec1); } vecsize1=vecData.size();
 * if(strAction.equals("select")) { strappno =
 * Helper.correctNull((String)hshValues.get("appno1"));
 * if((strappno==null)||(strappno=="")) { strappno =
 * Helper.correctNull((String)hshValues.get("appno")); }
 * rs1=DBUtils.executeLAPSQuery("getinfo^"+strappno); while (rs1.next()) {
 * vecRec2=new ArrayList();
 * vecRec2.add(correctNull(rs1.getString("per_infomantquesno")));
 * vecRec2.add(correctNull(rs1.getString("per_infomant1_answer")));
 * vecRec2.add(correctNull(rs1.getString("per_infomant2_answer")));
 * vecRec2.add(correctNull(rs1.getString("per_infomant3_answer")));
 * vecData2.add(vecRec2); } String strquery =
 * SQLParser.getSqlQuery("getinfomant^"+strappno);
 * rs2=DBUtils.executeQuery(strquery); while(rs2.next()) {
 * hshRecord.put("infomant1",correctNull(rs2.getString("per_infomant1_name")));
 * hshRecord.put("infomant2",correctNull(rs2.getString("per_infomant2_name")));
 * hshRecord.put("infomant3",correctNull(rs2.getString("per_infomant3_name"))); } }
 * vecsize=vecData2.size(); if(vecsize1!=vecsize) { int i=vecsize1-vecsize;
 * for(int l=1; l<=i; l++) { vecRec2=new ArrayList(); vecRec2.add("");
 * vecRec2.add("0"); vecRec2.add("0"); vecRec2.add("0");
 * vecData2.add(vecRec2); } } vecsize=vecData2.size(); String
 * str=Integer.toString(vecsize); hshRecord.put("vecData2",vecData2);
 * hshRecord.put("appno",strappno); hshRecord.put("strInfomanttype",
 * strInfomanttype); hshRecord.put("str",str); hshRecord.put("vecData",vecData);
 * String appname; String perapp_title; String perapp_husname; String
 * perapp_fatname; String
 * strappid=Helper.correctNull((String)hshValues.get("comappid"));
 * rs=DBUtils.executeLAPSQuery("seldocumentdetails^"+strappid);
 * 
 * if (rs.next()) { perapp_title=correctNull(rs.getString("perapp_title"));
 * perapp_title=perapp_title.toUpperCase();
 * hshRecord.put("perapp_title",perapp_title);
 * appname=correctNull(rs.getString("appname")); appname=appname.toUpperCase();
 * hshRecord.put("appname",appname);
 * hshRecord.put("perapp_address1",correctNull(rs.getString("perapp_address1")));
 * hshRecord.put("perapp_address2",correctNull(rs.getString("perapp_address2")));
 * hshRecord.put("perapp_address3",correctNull(rs.getString("perapp_address3")));
 * hshRecord.put("perapp_city",correctNull(rs.getString("perapp_city")));
 * hshRecord.put("perapp_state",correctNull(rs.getString("perapp_state")));
 * hshRecord.put("perapp_zip",correctNull(rs.getString("perapp_zip")));
 * hshRecord.put("perapp_dob",correctNull(rs.getString("perapp_dob")));
 * perapp_husname=correctNull(rs.getString("perapp_husname"));
 * perapp_husname=perapp_husname.toUpperCase();
 * hshRecord.put("perapp_husname",perapp_husname);
 * perapp_fatname=correctNull(rs.getString("perapp_fatname"));
 * perapp_fatname=perapp_fatname.toUpperCase();
 * hshRecord.put("perapp_fatname",perapp_fatname);
 * hshRecord.put("perapp_hname",correctNull(rs.getString("perapp_hname")));
 * hshRecord.put("perapp_date",correctNull(rs.getString("perapp_date")));
 * hshRecord.put("perapp_sex",correctNull(rs.getString("perapp_sex")));
 * hshRecord.put("perapp_religion",correctNull(rs.getString("perapp_religion")));
 * hshRecord.put("org_name",correctNull(rs.getString("org_name")));
 * hshRecord.put("org_add1",correctNull(rs.getString("org_add1")));
 * hshRecord.put("org_add2",correctNull(rs.getString("org_add2")));
 * hshRecord.put("org_city",correctNull(rs.getString("org_city")));
 * hshRecord.put("org_state",correctNull(rs.getString("org_state")));
 * hshRecord.put("org_zip",correctNull(rs.getString("org_zip")));
 * hshRecord.put("acc_type",correctNull(rs.getString("perapp_bankacctype")));
 * hshRecord.put("acc_no",correctNull(rs.getString("perapp_bankaccno")));
 * hshRecord.put("perapp_bank",correctNull(rs.getString("perapp_bank"))); String
 * dateofbirth=correctNull(rs.getString("perapp_dob")); String
 * currentdate=Helper.getCurrentDateTime(); dateofbirth =
 * dateofbirth.substring(6, 10); currentdate = currentdate.substring(6, 10);
 * String strAge = Integer.toString(Integer.parseInt(currentdate) -
 * Integer.parseInt(dateofbirth));
 * perapp_husname=correctNull(rs.getString("perapp_husname"));
 * perapp_husname=perapp_husname.toUpperCase(); hshRecord.put("age",strAge); }
 * rs=DBUtils.executeLAPSQuery("pergetEmployer^"+strappid);
 * 
 * if (rs.next()) {
 * hshRecord.put("peremp_name",correctNull(rs.getString("peremp_name")));
 * hshRecord.put("peremp_address1",correctNull(rs.getString("peremp_address1")));
 * hshRecord.put("peremp_address2",correctNull(rs.getString("peremp_address2")));
 * hshRecord.put("peremp_address3",correctNull(rs.getString("peremp_address3")));
 * hshRecord.put("peremp_city",correctNull(rs.getString("peremp_city")));
 * hshRecord.put("peremp_state",correctNull(rs.getString("peremp_state")));
 * hshRecord.put("peremp_zip",correctNull(rs.getString("peremp_zip")));
 * hshRecord.put("occup_name",correctNull(rs.getString("peremp_occupation")));
 * hshRecord.put("peremp_yresemp",correctNull(rs.getString("peremp_yresemp")));
 * hshRecord.put("peremp_phone",correctNull(rs.getString("peremp_phone")));
 * hshRecord.put("design_name",correctNull(rs.getString("peremp_design"))); } }
 * catch (Exception e) { throw new EJBException(e.getMessage()); } finally { try {
 * if (rs != null) { rs.close(); } if(rs1!=null) { rs1.close(); } if(rs2!=null) {
 * rs2.close(); } } catch (Exception cf) { throw new EJBException("Error closing
 * the connection "+ cf.getMessage()); } } return hshRecord; }
 */

