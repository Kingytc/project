package com.sai.laps.ejb.comassestsliab;
import java.io.ByteArrayOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ComAssetsLiabBean", mappedName = "ComAssetsLiabHome")
@Remote (ComAssetsLiabRemote.class)
public class ComAssetsLiabBean extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static Logger log=Logger.getLogger(ComAssetsLiabBean.class);	

	public ComAssetsLiabBean() {
	}
	
	
	public void updateInterFrim(HashMap hsh) 
	{

		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue = "", strQuery = "", hidaction = "";
		int intUpdatesize = 0;
		ResultSet rs = null;

		try {
			strValue = correctNull((String) hsh.get("appno"));
			hidaction = correctNull((String) hsh.get("hidAction"));
			if (!hidaction.equalsIgnoreCase("delete")) {
				intUpdatesize = 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_COM_INTERFIRMCOMPARE");
				arr.add(strValue);
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_COM_INTERFIRMCOMPFREETXT");  
				arr.add(strValue);
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "ins_COM_INTERFIRMCOMPFREETXT");
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield1")));// 1
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield2")));// 2
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield3")));// 3
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				for (int k = 1; k < 6; k++) {
					intUpdatesize = intUpdatesize + 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshquery = new HashMap();
					arr = new ArrayList();
					hshquery.put("strQueryId", "ins_COM_INTERFIRMCOMPARE");
					arr.add(strValue);
					arr.add(Integer.toString(k));
					arr.add("InterFirmComparsion");
					arr.add(Helper.correctNull((String) hsh.get("txt_compname"
							+ k)));// 1
					arr.add(Helper
							.correctNull((String) hsh.get("txt_year" + k)));// 2

					if (Helper.correctNull((String) hsh.get("txt_type" + k))
							.equalsIgnoreCase("sel")) { // 3
						arr.add("");
					} else {
						arr.add(Helper.correctNull((String) hsh.get("txt_type"
								+ k)));
					}
					arr.add(Helper.correctNull((String) hsh
							.get("txt_gross" + k)));// 4
					arr.add(Helper.correctNull((String) hsh.get("txt_netsales"
							+ k)));// 5
					arr.add(Helper.correctNull(((String) hsh
							.get("txt_netprofit" + k))));// 6
					arr.add(Helper.correctDouble(((String) hsh
							.get("txt_capital" + k))));// 7
					arr.add(Helper.correctNull(((String) hsh.get("txt_tangnet"
							+ k))));// 8
					arr.add(Helper.correctNull((String) hsh.get("txt_network"
							+ k)));// 9
					arr.add(Helper.correctNull((String) hsh.get("txt_toltnw"
							+ k)));// 10

					arr.add(Helper.correctNull((String) hsh.get("txt_currratio"
							+ k)));// 11
					arr.add(Helper.correctNull((String) hsh
							.get("txt_estproturn" + k)));// 12
					arr.add(Helper.correctNull(((String) hsh.get("txt_totwork"
							+ k))));// 13
					arr.add(Helper.correctNull(((String) hsh
							.get("txt_seccoverinclude" + k))));// 14
					arr.add(Helper.correctNull((String) hsh
							.get("txt_seccoverexclude" + k)));// 15
					arr.add(Helper.correctNull((String) hsh.get("txt_lastcredit"+k)));// 16
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext"+k)));// 17
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext1"+k)));// 18
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext2"+k)));// 19
					arr.add(Helper.correctNull((String) hsh.get("txt_FBWC"+k)));// 20
					arr.add(Helper.correctNull((String) hsh.get("txt_NFBWC"+k)));// 21
					arr.add(Helper.correctNull((String) hsh.get("txt_TOTWC"+k)));// 22
					arr.add(Helper.correctNull((String) hsh.get("txt_termava"+k)));// 23
					hshquery.put("arrValues", arr);
					hshqueryval.put(Integer.toString(intUpdatesize), hshquery);
				}
			}
			if (hidaction.equalsIgnoreCase("delete")) {
				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_COM_INTERFIRMCOMPARE");
				arr.add(strValue);
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_COM_INTERFIRMCOMPFREETXT");
				arr.add(strValue);
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

			}

			EJBInvoker
					.executeStateLess("dataaccess", hshqueryval, "updateData");

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		}

	}

	public HashMap getInterfirmComp(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strQuery = "";
		hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		String strAppNo = correctNull((String) hshValues.get("strAppno"));
		String strcomappid = correctNull((String) hshValues.get("comappid"));
		String strindtype = correctNull((String) hshValues.get("industryType"));
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("appno"));
		}
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("hidAppNo"));
		}
		try {
			
			if(strcomappid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("comfunsel3^" + strAppNo);
				if(rs.next())
				{
					strcomappid=Helper.correctNull((String)rs.getString("demo_appid"));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("com_interfirm_select^" + strindtype
					+ "^" + strcomappid);

			while (rs.next()) {
				// vecRec1 = new ArrayList();
				// vecRec2 = new ArrayList();
				vecRec1.add(correctNull((String) rs
						.getString("comapp_id")));
				vecRec2.add(correctNull((String) rs
						.getString("comapp_companyname")));
				// hshRecord.put("vecname1",vecRec2);
				// vecVal.add(vecRec1);
				// vecVal.add(vecRec2);

			}
			vecVal.add(vecRec1);
			vecVal.add(vecRec2);
			hshRecord.put("vecVal", vecVal);
			hshRecord.put("vecname", vecRec2);
			hshRecord.put("vecid", vecRec1);

			strQuery = SQLParser.getSqlQuery("selinterfrimcompval^" + strAppNo);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("intcompfreetxt_txt1", correctNull(rs
						.getString("COM_FREETEXT1"))); // 1
				hshRecord.put("intcompfreetxt_txt2", correctNull(rs
						.getString("COM_FREETEXT2")));// 2
				hshRecord.put("intcompfreetxt_txt3", correctNull(rs
						.getString("COM_FREETEXT3")));// 3
			}

			strQuery = SQLParser.getSqlQuery("selinterfrimcompare^" + strAppNo);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			int k = 0;
			while (rs.next()) {
				k = k + 1;
				hshRecord.put("txt_compname" + k, correctNull(rs
						.getString("interfirm_comname"))); // 1
				hshRecord.put("txt_year" + k, correctNull(rs
						.getString("interfirm_year")));// 2
				hshRecord.put("txt_type" + k, correctNull(rs
						.getString("interfirm_fintype")));// 3
				hshRecord.put("txt_gross" + k, correctNull(rs
						.getString("interfirm_grosssales")));// 4
				hshRecord.put("txt_netsales" + k, correctNull(rs
						.getString("interfirm_netsales")));// 5
				hshRecord.put("txt_netprofit" + k, correctNull(rs
						.getString("interfirm_netprofit"))); // 6
				hshRecord.put("txt_capital" + k, correctNull(rs
						.getString("interfirm_capital")));// 7
				hshRecord.put("txt_tangnet" + k, correctNull(rs
						.getString("interfirm_tangnetworth")));// 8
				hshRecord.put("txt_network" + k, correctNull(rs
						.getString("interfirm_networkcap"))); // 9
				hshRecord.put("txt_toltnw" + k, correctNull(rs
						.getString("interfirm_toltnw")));// 10

				hshRecord.put("txt_currratio" + k, correctNull(rs
						.getString("interfirm_currratio"))); // 11
				hshRecord.put("txt_estproturn" + k, correctNull(rs
						.getString("interfirm_estproturn")));// 12
				hshRecord.put("txt_totwork" + k, correctNull(rs
						.getString("interfirm_totcapital")));// 13
				hshRecord.put("txt_seccoverinclude" + k, correctNull(rs
						.getString("interfirm_seccoverinclude")));// 14
				hshRecord.put("txt_seccoverexclude" + k, correctNull(rs
						.getString("interfirm_seccoverexclude")));// 15
				hshRecord.put("txt_lastcredit" + k, correctNull(rs
						.getString("interfirm_lastcredit")));// 16
				hshRecord.put("txt_freetext" + k, correctNull(rs
						.getString("interfirm_freetext1")));// 17
				hshRecord.put("txt_freetext1" + k, correctNull(rs
						.getString("interfirm_freetext2")));// 18
				hshRecord.put("txt_freetext2" + k, correctNull(rs
						.getString("interfirm_freetext3")));// 19
				hshRecord.put("txt_FBWC"+k, Helper.correctDouble((String)(rs
						.getString("INTERFIRM_FUNDWC"))));// 20
				hshRecord.put("txt_NFBWC"+k, Helper.correctDouble((String)(rs
						.getString("INTERFIRM_NONFUNDWC"))));// 21
				hshRecord.put("txt_TOTWC"+k, Helper.correctDouble((String)(rs
						.getString("INTERFIRM_TOTWC"))));// 22
				hshRecord.put("txt_termava"+k, Helper.correctDouble((String)(rs
						.getString("INTERFIRM_TERMLOAN"))));// 23
			}
			String strFinvaluesIn="";
			int strFinid=0;
			
			rs	= DBUtils.executeLAPSQuery("sel_financeid^"+strAppNo);
			if(rs.next())
			{
				strFinid	= Integer.parseInt(Helper.correctInt((String)rs.getString("DEMO_FINSTANDARD")));
			}
			if(rs!=null){rs.close();}
			
			rs	= DBUtils.executeLAPSQuery("comfinance_finappid^"+strFinid);
			if(rs.next())
			{
				strFinvaluesIn	= correctNull(rs.getString("fin_valuesarein"));
			}
			if(rs!=null){rs.close();}
			
			//Financail Values In
			if(strFinvaluesIn.equals("C")){strFinvaluesIn = "Crore";}
			else if(strFinvaluesIn.equals("L")){strFinvaluesIn	= "Lacs";}
			else if(strFinvaluesIn.equals("R")){strFinvaluesIn	= "Rs";}
			hshRecord.put("strFinvaluesIn", strFinvaluesIn);

		} catch (Exception e) {
			log.error("error occured" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}

		return hshRecord;
	}
	
	
	
	
	/* AUTHOR : M. ARSATH AYUB
	 * DATE	  : 20/03/2014
	 * PAGE	  : FINANCIAL - GRP CONCERNS
	 */
	public void updateFinangrpconcern(HashMap hsh) 
	{

		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue = "", strQuery = "", hidaction = "";
		int intUpdatesize = 0;
		ResultSet rs = null;

		try {
			strValue = correctNull((String) hsh.get("appno"));
			hidaction = correctNull((String) hsh.get("hidAction"));
			if (!hidaction.equalsIgnoreCase("delete")) {
				intUpdatesize = 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_com_fingrpconcerncompare");
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh.get("txt_compname")));
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_com_fingrpconcernfreetxt");  
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh.get("txt_compname")));
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "ins_com_fingrpconcernfreetxt");
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield1")));// 1
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield2")));// 2
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield3")));// 3
				arr.add(Helper.correctNull((String) hsh.get("txt_compname")));// 1
				arr.add(Helper.correctNull((String) hsh
						.get("txt_freetxtfield4")));//4 added by ganesan 
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				for (int k = 1; k < 6; k++) {
					intUpdatesize = intUpdatesize + 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshquery = new HashMap();
					arr = new ArrayList();
					hshquery.put("strQueryId", "ins_com_fingrpconcerncompare");
					arr.add(strValue);
					arr.add(Integer.toString(k));
					arr.add("Fingrpconcern");
					arr.add(Helper.correctNull((String) hsh.get("txt_compname")));// 1
					arr.add(Helper.correctNull((String) hsh.get("txt_year" + k)));// 2

					if (Helper.correctNull((String) hsh.get("txt_type" + k))
							.equalsIgnoreCase("sel")) { // 3
						arr.add("");
					} else {
						arr.add(Helper.correctNull((String) hsh.get("txt_type"
								+ k)));
					}
					arr.add(Helper.correctNull((String) hsh
							.get("txt_gross" + k)));// 4
					arr.add(Helper.correctNull((String) hsh.get("txt_netsales"
							+ k)));// 5
					arr.add(Helper.correctNull(((String) hsh
							.get("txt_netprofit" + k))));// 6
					arr.add(Helper.correctDouble(((String) hsh
							.get("txt_capital" + k))));// 7
					arr.add(Helper.correctNull(((String) hsh.get("txt_tangnet"
							+ k))));// 8
					arr.add(Helper.correctNull((String) hsh.get("txt_network"
							+ k)));// 9
					arr.add(Helper.correctNull((String) hsh.get("txt_toltnw"
							+ k)));// 10

					arr.add(Helper.correctNull((String) hsh.get("txt_currratio"
							+ k)));// 11
					arr.add(Helper.correctNull((String) hsh
							.get("txt_estproturn" + k)));// 12
					arr.add(Helper.correctNull(((String) hsh.get("txt_totwork"
							+ k))));// 13
					arr.add(Helper.correctNull(((String) hsh
							.get("txt_seccoverinclude" + k))));// 14
					arr.add(Helper.correctNull((String) hsh
							.get("txt_seccoverexclude" + k)));// 15
					arr.add(Helper.correctNull((String) hsh
							.get("txt_lastcredit" + k)));// 16
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext"
							+ k)));// 17
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext1"
							+ k)));// 18
					arr.add(Helper.correctNull((String) hsh.get("txt_freetext2"
							+ k)));// 19
					arr.add(Helper.correctNull((String) hsh.get("txt_freetxtfield4"
							+ k)));// 20 added by ganesan 
					hshquery.put("arrValues", arr);
					hshqueryval.put(Integer.toString(intUpdatesize), hshquery);
				}
			}
			if (hidaction.equalsIgnoreCase("delete")) {
				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_com_fingrpconcerncompare");
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh.get("txt_compname")));
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

				intUpdatesize = intUpdatesize + 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "del_com_fingrpconcernfreetxt");
				arr.add(strValue);
				arr.add(Helper.correctNull((String) hsh.get("txt_compname")));
				hshquery.put("arrValues", arr);
				hshqueryval.put(Integer.toString(intUpdatesize), hshquery);

			}

			EJBInvoker
					.executeStateLess("dataaccess", hshqueryval, "updateData");

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		}

	}

	public HashMap getFinangrpconcern(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strQuery = "";
		hshRecord = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		String strAppNo = correctNull((String) hshValues.get("strAppno"));
		String strcomappid = correctNull((String) hshValues.get("comappid"));
		String strCompanyname = Helper.correctNull((String)hshValues.get("companyname"));
		String strindtype = correctNull((String) hshValues.get("industryType"));
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) {
			strAppNo = correctNull((String) hshValues.get("appno"));
		}
		try {
			
			if(strcomappid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("comfunsel3^" + strAppNo);
				if(rs.next())
				{
					strcomappid=Helper.correctNull((String)rs.getString("demo_appid"));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("com_interfirm_select^" + strindtype
					+ "^" + strcomappid);

			while (rs.next()) {
				// vecRec1 = new ArrayList();
				// vecRec2 = new ArrayList();
				vecRec1.add(correctNull((String) rs
						.getString("comapp_id")));
				vecRec2.add(correctNull((String) rs
						.getString("comapp_companyname")));
				// hshRecord.put("vecname1",vecRec2);
				// vecVal.add(vecRec1);
				// vecVal.add(vecRec2);

			}
			vecVal.add(vecRec1);
			vecVal.add(vecRec2);
			hshRecord.put("vecVal", vecVal);
			hshRecord.put("vecname", vecRec2);
			hshRecord.put("vecid", vecRec1);

			if(!strCompanyname.equalsIgnoreCase(""))
			{
			strQuery = SQLParser.getSqlQuery("selfingrpconcernval^" + strAppNo+"^"+strCompanyname);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("intcompfreetxt_txt1", correctNull(rs
						.getString("COM_FREETEXT1"))); // 1
				hshRecord.put("intcompfreetxt_txt2", correctNull(rs
						.getString("COM_FREETEXT2")));// 2
				hshRecord.put("intcompfreetxt_txt3", correctNull(rs
						.getString("COM_FREETEXT3")));// 3
				hshRecord.put("COM_FREETEXT4", correctNull(rs
						.getString("COM_FREETEXT4")));// 4 added by ganesan
			}

			strQuery = SQLParser.getSqlQuery("selfingrpconcerncompare^" + strAppNo+"^"+strCompanyname);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			int k = 0;
			while (rs.next()) {
				k = k + 1;
				hshRecord.put("txt_compname" + k, correctNull(rs
						.getString("fingrpconcern_comname"))); // 1
				hshRecord.put("txt_year" + k, correctNull(rs
						.getString("fingrpconcern_year")));// 2
				hshRecord.put("txt_type" + k, correctNull(rs
						.getString("fingrpconcern_fintype")));// 3
				hshRecord.put("txt_gross" + k, correctNull(rs
						.getString("fingrpconcern_grosssales")));// 4
				hshRecord.put("txt_netsales" + k, correctNull(rs
						.getString("fingrpconcern_netsales")));// 5
				hshRecord.put("txt_netprofit" + k, correctNull(rs
						.getString("fingrpconcern_netprofit"))); // 6
				hshRecord.put("txt_capital" + k, correctNull(rs
						.getString("fingrpconcern_capital")));// 7
				hshRecord.put("txt_tangnet" + k, correctNull(rs
						.getString("fingrpconcern_tangnetworth")));// 8
				hshRecord.put("txt_network" + k, correctNull(rs
						.getString("fingrpconcern_networkcap"))); // 9
				hshRecord.put("txt_toltnw" + k, correctNull(rs
						.getString("fingrpconcern_toltnw")));// 10

				hshRecord.put("txt_currratio" + k, correctNull(rs
						.getString("fingrpconcern_currratio"))); // 11
				hshRecord.put("txt_estproturn" + k, correctNull(rs
						.getString("fingrpconcern_estproturn")));// 12
				hshRecord.put("txt_totwork" + k, correctNull(rs
						.getString("fingrpconcern_totcapital")));// 13
				hshRecord.put("txt_seccoverinclude" + k, correctNull(rs
						.getString("fingrpconcern_seccoverinclude")));// 14
				hshRecord.put("txt_seccoverexclude" + k, correctNull(rs
						.getString("fingrpconcern_seccoverexclude")));// 15
				hshRecord.put("txt_lastcredit" + k, correctNull(rs
						.getString("fingrpconcern_lastcredit")));// 16
				hshRecord.put("txt_freetext" + k, correctNull(rs
						.getString("fingrpconcern_freetext1")));// 17
				hshRecord.put("txt_freetext1" + k, correctNull(rs
						.getString("fingrpconcern_freetext2")));// 18
				hshRecord.put("txt_freetext2" + k, correctNull(rs
						.getString("fingrpconcern_freetext3")));// 19
				hshRecord.put("FINGRPCONCERN_FREETEXT4" + k, correctNull(rs
						.getString("FINGRPCONCERN_FREETEXT4")));// 19

			}
			}
			hshRecord.put("companyname",strCompanyname);
			
			String strFinvaluesIn="";
			int strFinid=0;
			
			rs	= DBUtils.executeLAPSQuery("sel_financeid^"+strAppNo);
			if(rs.next())
			{
				strFinid	= Integer.parseInt(Helper.correctInt((String)rs.getString("DEMO_FINSTANDARD")));
			}
			if(rs!=null){rs.close();}
			
			rs	= DBUtils.executeLAPSQuery("comfinance_finappid^"+strFinid);
			if(rs.next())
			{
				strFinvaluesIn	= correctNull(rs.getString("fin_valuesarein"));
			}
			if(rs!=null){rs.close();}
			
			//Financail Values In
			if(strFinvaluesIn.equals("C")){strFinvaluesIn = "Crore";}
			else if(strFinvaluesIn.equals("L")){strFinvaluesIn	= "Lacs";}
			else if(strFinvaluesIn.equals("R")){strFinvaluesIn	= "Rs";}
			hshRecord.put("strFinvaluesIn", strFinvaluesIn);

		} catch (Exception e) {
			log.error("error occured" + e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}

		return hshRecord;
	}
	
	
	
	
	
	
}