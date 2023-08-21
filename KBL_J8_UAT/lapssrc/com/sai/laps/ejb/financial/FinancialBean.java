package com.sai.laps.ejb.financial;

import java.io.File;
import java.net.URISyntaxException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import com.kalyptorisk.www.credit.rating.RatingSoapProxy;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.GenerateFinancials;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FinancialBean", mappedName = "FinancialHome")
@Remote (FinancialRemote.class)
public class FinancialBean extends BeanAdapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static Logger log = Logger.getLogger(FinancialBean.class);

	public HashMap getData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		int str = 0, tabcnt = 0, l = 0;
		String sumaudit = "";
		String sumunaudit = "";
		String sumestimated = "";
		String sumprojection = "";
		String sel_divID = "";
		String pagetab = "";
		String base_year = "";
		String strAction = "";
		String fintype = null;
		String chk1 = "", chk2 = "", chk3 = "", chk4 = "", chk5 = "";
		ArrayList arr_labeldetails = new ArrayList();
		String strappno = "";
		String appid = "";
		String finance_id = "";
		String strValuesin = "";

		try {
			String hidFreeze = correctNull((String) hshRequestValues
					.get("strFreeze"));
			String hidUpload = correctNull((String) hshRequestValues
					.get("hidUpload"));
			// to get the process note base on print out option
			String printtype = correctNull((String) hshRequestValues
					.get("printtype"));

			strAction = Helper.correctNull((String) hshRequestValues
					.get("hidAction"));
			// --------This is Existing Finia-----

			if (strValue.equals("")) {
				strValue = correctNull((String) hshRequestValues
						.get("hidfinanceid"));
				finance_id = correctNull((String) hshRequestValues
						.get("hidfinanceid"));
			}
			if (strValue.equals("")) {
				strValue = correctNull((String) hshRequestValues
						.get("hidfinid"));
				finance_id = correctNull((String) hshRequestValues
						.get("hidfinid"));
			}

			appid = correctNull((String) hshRequestValues.get("hidappid"));
			if (appid.equals("")) {
				appid = correctNull((String) hshRequestValues.get("hid_appid"));
			}
			if (appid.equals("")) {
				appid = correctNull((String) hshRequestValues.get("appidnew"));
			}
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}

			strappno = Helper.correctNull((String) hshRequestValues
					.get("appno"));
			if (strappno.equals("")) {
				strappno = correctNull((String) hshRequestValues.get("APP_NO"));
			}
			if (strappno.equals("")) {
				strappno = correctNull((String) hshRequestValues.get("FACILITY_APPNO"));
			}
			if (strappno.equals("")) {
				strappno = correctNull((String) hshRequestValues.get("strAppno"));
			}
			if (strappno.equals("")) {
				strappno = correctNull((String) hshRequestValues.get("hidRatAppNo"));
			}
			
			if (!strappno.equals("")) {
				if (finance_id.equals("")) {
					String query1 = SQLParser
							.getSqlQuery("comdemographics_sel^" + strappno);
					rs = DBUtils.executeQuery(query1);

					if (rs.next()) {
						finance_id = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
						strValue = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
					}
				}
			}

			String page = correctNull((String) hshRequestValues.get("pageval"));
			pagetab = Helper.correctNull(page);
			

			rs = null;
			chk1 = correctNull((String) hshRequestValues.get("printchk1"));
			chk2 = correctNull((String) hshRequestValues.get("printchk2"));
			chk3 = correctNull((String) hshRequestValues.get("printchk3"));
			chk4 = correctNull((String) hshRequestValues.get("printchk4"));
			chk5 = correctNull((String) hshRequestValues.get("printchk5"));

			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			hshValues.put("sel_divID", sel_divID);

			// Retreving of values for project input

			String query1 = SQLParser
					.getSqlQuery("financial_new_projectinputfields_select^"
							+ strValue);
			rs = DBUtils.executeQuery(query1);
			ArrayList vec = new ArrayList();
			if (rs.next()) {
				vec.add(Helper.correctNull(Helper
						.correctNull((String) rs.getString(10))));
				vec.add(Helper.correctNull(Helper
						.correctNull((String) rs.getString(2))));
				if (Helper.correctNull(rs.getString(3)).equalsIgnoreCase("")) {
					vec.add("0.00");
				} else {
					vec
							.add(Helper.correctNull((String) rs
									.getString(3)));
				}
				if (Helper.correctNull(rs.getString(4)).equalsIgnoreCase("")) {
					vec.add("0.00");
				} else {
					vec
							.add(Helper.correctNull((String) rs
									.getString(4)));
				}
				vec.add(Helper.correctNull((String) rs.getString(5)));
				vec.add(Helper.correctNull((String) rs.getString(6)));
				vec.add(Helper.correctNull((String) rs.getString(7)));
				vec.add(Helper.correctNull((String) rs.getString(8)));
				vec.add(Helper.correctNull((String) rs.getString(9)));
				hshValues.put("projectinputvalue", vec);
			} else {
				vec.add("");
				vec.add("");
				vec.add("0.00");
				vec.add("0.00");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("0.00");
				hshValues.put("projectinputvalue", vec);
			}

			// Retreving of value for base year

			if (rs != null) {
				rs.close();
			}

			String baseyear_query = SQLParser
					.getSqlQuery("sel_financial_baseyear^" + strValue);
			rs = DBUtils.executeQuery(baseyear_query);

			if (rs.next()) {
				base_year = Helper.correctNull((String) rs
						.getString("base_year"));
			}

			hshValues.put("base_year", base_year);

			// -------------- to find the time of review-----------------

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("finselect1^" + strValue + "^"
					+ sel_divID);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				str = rs.getInt("cnt");
			}

			// --------------- to find the cma format of the particular
			// applications-------

			String tempbool = "2", tabool = "";
			String cma = "0";
			log.info((String) hshRequestValues.get("cattype"));
			/*
			 * strQuery=SQLParser.getSqlQuery("comfinance_appid^"+strValue);
			 * if(rs != null) { rs.close(); } rs =
			 * DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=correctNull(rs.getString("fin_cmano"));
			 * fintype = Helper.correctNull((String)rs.getString("fin_cmano"));
			 * }
			 */

			cma = Helper
					.correctNull((String) hshRequestValues.get("hidcmasno"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}

				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}

			/*
			 * if(cma.equalsIgnoreCase("5")) { if(pagetab.equalsIgnoreCase(""))
			 * { pagetab="INFRA STRUCTURE MODEL"; } }
			 */
			int strsize = 0;

			strQuery = SQLParser.getSqlQuery("corp_fin_year_count^" + strValue
					+ "^" + sel_divID);

			if (rs10 != null) {
				rs10.close();
			}
			rs10 = DBUtils.executeQuery(strQuery);
			if (rs10.next()) {

				strsize = rs10.getInt("yearcount");
			}

			strQuery = null;

			String stryear[] = new String[strsize];

			int i = 0;
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}
			if (rs10 != null)
				rs10.close();
			rs10 = DBUtils.executeQuery(strQuery);
			while (rs10.next()) {

				stryear[i] = rs10.getString("fin_year");
				i++;
			}

			i = 0;
			String strDate = "";
			int strcurcount = 0;
			// to check for current year duplication
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_fintype_curryear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_fintype_curryear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strcurcount = strcurcount + 1;
			}
			String strdesctype[] = new String[strcurcount];
			int insno[] = new int[strcurcount];
			rs.beforeFirst();
			while (rs.next()) {

				strdesctype[i] = rs.getString("com_fintype");
				insno[i] = rs.getInt("com_sno");
				strDate = rs.getString("caf_year");
				i++;

			}
			// for take Financial Type Base on Priority
			String strpro = "false", strest = "false", straud = "false", strunaud = "false";
			int prosno = 0, estsno = 0, unaudsno = 0, audsno = 0, intyearsno = 0;
			if (i > 0) {
				for (int j = 0; j < strdesctype.length; j++) {

					if (strdesctype[j].equals("PROJECTION"))

					{
						strpro = "true";
						prosno = insno[j];

					}
					if (strdesctype[j].equals("ESTIMATED"))

					{
						strest = "true";
						estsno = insno[j];

					}
					if (strdesctype[j].equals("UNAUDITED"))

					{
						strunaud = "true";
						unaudsno = insno[j];

					}
					if (strdesctype[j].equals("AUDITED")) {
						straud = "true";
						audsno = insno[j];

					}

				}

				if (straud.equals("true")) {
					intyearsno = audsno;

				} else if (strunaud.equals("true")) {
					intyearsno = unaudsno;

				} else if (strest.equals("true")) {
					intyearsno = estsno;

				} else {
					intyearsno = prosno;

				}

			}
			// }

			// -----------------to find the tab----------------------

			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				if ((y == 0)
						&& (page.trim().equals("") || page.trim().equals("RA"))) {
					page = correctNull((String) rs.getString("fin_tabname"));
				}

				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);

			}

			hshValues.put("tabdetails", vecVal);
			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application
			String tempsno = "";
			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2^" + cma + "^"
						+ page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					arr_labeldetails = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);
					vecVal.add(vecRec);

				}
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect2_label^" + cma
						+ "^" + page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					arr_labeldetails
							.add(correctNull(rs.getString("fin_rowid")));

				}

				hshValues.put("labeldetails", vecVal);
				hshValues.put("arr_labeldetails", arr_labeldetails);
			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect3z^" + cma + "^"
						+ page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));

					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);

					vecVal.add(vecRec);
				}
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect3z_label^" + cma
						+ "^" + page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					arr_labeldetails.add(correctNull(rs.getString("myrowid")));

				}

				hshValues.put("labeldetails", vecVal);
				hshValues.put("arr_labeldetails", arr_labeldetails);
			}

			hshValues.put("count", Integer.toString(str));

			String yearselect = "", seloption = "", givenyear = "";
			i = 0;
			int k = 0;
			int from = 0, p = 0, tt = 0;

			ArrayList vecrec = new ArrayList();
			ArrayList vecrec_strt = new ArrayList();
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[6];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";

			strQuery = SQLParser.getSqlQuery("finYearSel^" + strValue + "^"
					+ sel_divID);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryvall = new ArrayList();

			int kk = 0;
			while (rs.next()) {
				arryvall.add(Helper.correctNull(rs.getString("fin_year")));

			}

			// this code has been commented by balaji & shanmugam for get all
			// the year for all the sub tags
			// and new line has been added bellow
			String sno = "0";
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}

			if (rs != null) {
				rs.close();
			}
			int o = 1;
			int t = 1;
			int r = 1;
			rs = DBUtils.executeQuery(strQuery);
			String audit_flag = "false";
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";
				vecVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				String yearselect_strt = (String) Helper.correctNull(rs
						.getString("COM_FINYEAR_START"));
				sno = (String) Helper.correctNull(rs.getString("com_sno"));
				if (!yearselect.equals("")) {
					if (rs3 != null) {
						rs3.close();
					}

					String strQuery10 = SQLParser.getSqlQuery("assessselect9^"
							+ strValue + "^" + sel_divID + "^" + yearselect
							+ "^" + sno);
					if (rs10 != null) {
						rs10.close();
					}

					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumaudit = Helper.correctDouble(rs10
								.getString("sumaudit"));
						sumunaudit = Helper.correctDouble(rs10
								.getString("sumunaudit"));
						sumestimated = Helper.correctDouble(rs10
								.getString("sumestimated"));
						sumprojection = Helper.correctDouble(rs10
								.getString("sumprojection"));
					}
					if (valarray[0].equals("0") && !sumaudit.equals("0")) {
						valarray[0] = "fin_audit";
						audit_flag = "true";
					}
					if (valarray[1].equals("0") && !sumunaudit.equals("0")) {
						valarray[1] = "fin_unaudit";
					}
					if (valarray[2].equals("0") && !sumestimated.equals("0")) {
						valarray[2] = "fin_estimated";
					}
					if (valarray[3].equals("0") && !sumprojection.equals("0")) {
						valarray[3] = "fin_projection";
					}
					if (valarray[4].equals("0") && !sumprojection.equals("0")) {
						valarray[4] = "fin_projection";
					}

					if (rs10 != null) {
						rs10.close();
					}

					for (int h = 0; h < 4; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0.00";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							boolean flag=false;
							if (printtype.equalsIgnoreCase("Y")) 
							{
								flag=true;
							}
							else
							{
								if(k>=5)
									flag=false;
								else
									flag=true;
							}
							if ((i >= from) && flag) {
								p = i;
								k = k + 1;
								hshValues.put("sno" + (o++), sno);
//								strQuery = SQLParser.getSqlQuery("finselect5^"
//										+ seloption + "^" + cma + "^" + page
//										+ "^" + yearselect + "^" + strValue
//										+ "^" + sel_divID + "^" + sno);

								strQuery = SQLParser.getSqlQuery("finselect5^"
										+ seloption + "^" + yearselect + "^" + strValue
										+ "^" + sel_divID + "^" + sno
										+ "^" + cma + "^" + page);

								if (rs1 != null) {
									rs1.close();
								}
								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {

									vecVal.add(correctNull(rs1
											.getString("txtvalue")));
									vecid.add(correctNull(rs1
											.getString("fin_rowid")));
									// }

									hshValues.put("year" + k, vecVal);
									hshValues.put("vecid" + k, vecid);
								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
								vecrec_strt.add(yearselect_strt);
								strQuery = SQLParser
										.getSqlQuery("com_selfinancial_printyear^"
												+ sno + "^" + strValue);
								if (rs1 != null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) {

									hshValues.put("checkcol" + (t++),Helper.correctNull((String) rs1
																	.getString("FINPRINTYEAR_SELSNO")));

								} else {
									t++;
								}
								
								strQuery = SQLParser
								.getSqlQuery("com_selfinancial_rateyear^"
										+ sno + "^" + strValue);
								if (rs1 != null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) {
									
									hshValues
									.put(
											"ratecol" + (r++),
											Helper
											.correctNull((String) rs1
													.getString("FINRATEYEAR_SELSNO")));
									
								} else {
									r++;
								}
							}

						}
					}
				}
			}

			hshValues.put("from", Integer.toString(from));

			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("yearvalue_strt", vecrec_strt);
			hshValues.put("page", page);
			hshValues.put("IRBUpload", hidUpload);
			hshValues.put("Freeze", hidFreeze);
			hshValues.put("Auditflag", audit_flag);
			// checking for the values in the com_finappvalues table
			strQuery = SQLParser.getSqlQuery("com_finappvaluessel^" + strValue
					+ "^" + sel_divID);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshValues.put("findata", "true");
			} else {
				hshValues.put("findata", "false");
			}

			// to get the Freeze value from com_finance table
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("comfinance_finappid^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			String freeze_flag = "N";
			if (rs.next()) {
				freeze_flag = Helper.correctNull((String) rs
						.getString("fin_freeze"));
				strValuesin = Helper.correctNull((String) rs
						.getString("fin_valuesarein"));
				appid=Helper.correctNull((String) rs.getString("fin_comappid"));
				hshValues.put("fin_model_name",Helper.correctNull((String) rs.getString("CMA_FORMAT_DESC")));
			}
			hshValues.put("freeze_flag", freeze_flag);
			hshValues.put("strValuesin", strValuesin);

			// to get the count of particular tab from com_finmaster
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("com_financetabcount^" + cma + "^"
					+ page);
			rs = DBUtils.executeQuery(strQuery);

			int rowid_count = 0;
			if (rs.next()) {
				rowid_count = Integer.parseInt((Helper.correctInt((String) rs
						.getString("fin_tabcount"))));
			}
			hshValues.put("rowid_count", String.valueOf(rowid_count));

			String attach_flag = "false";
			int cma_flag = 0;
			// to get whether the appno attahced with any cma format
			if (!strappno.equals("")) {
				strQuery = SQLParser.getSqlQuery("comdemographics_sel^"
						+ strappno);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {

					cma_flag = Integer.parseInt((Helper.correctInt((String) rs
							.getString("demo_finstandard"))));
				}
			}

			// to check whether finance id is attached with any application
			String appattachflag = "false";
			String strattach_appno = "";
			rs1 = null;
			String app_status = "";

			if (!finance_id.equals("")) {
				query1 = SQLParser.getSqlQuery("comappnoselect_finid^"+ finance_id);
				rs = DBUtils.executeQuery(query1);
				while (rs.next()) 
				{
						appattachflag = "true";
				}
				if(rs1!=null)
				{rs1.close();}
				query1 = SQLParser.getSqlQuery("sel_finratappno^"+ finance_id);
				rs1 = DBUtils.executeQuery(query1);
				while (rs1.next()) 
				{
					if(correctNull(rs1.getString("fin_status")).equalsIgnoreCase("pa"))
						appattachflag = "true";
				}
			}
			
			
			if (rs != null) {
				rs.close();
			}
			String digiflag="";
			if (!strappno.equals("")) {
			strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strappno);
			 rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
		        }
				hshValues.put("digiflag", digiflag);
				
			}	
			
			if(!digiflag.equalsIgnoreCase("Y")){
			if (rs != null) {
				rs.close();
			}
			if (!finance_id.equals("")) {
			strQuery = SQLParser.getSqlQuery("sel_finid_rating_status^"+finance_id);
			 rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
		        }
				hshValues.put("digiflag", digiflag);
				
			}
			}
			
			hshValues.put("attach_flag", String.valueOf(cma_flag));
			hshValues.put("tabname", pagetab);
			hshValues.put("strAction", strAction);
			hshValues.put("fintype", cma);
			hshValues.put("finappid", appid);
			hshValues.put("appidnew", appid);
			hshValues.put("finace_id", finance_id);

			hshValues.put("PAflag", appattachflag);
			// to get whether finance_id is attached with
			
			if(rs!=null)
			{rs.close(); 	
			}
			
			String strAssetFinRowID="0";
			rs = DBUtils.executeLAPSQuery("sel_rowid^"+"TOTAL LIABILITIES^FI^"+cma);
			if (rs.next()) {
				strAssetFinRowID = Helper.correctInt((String) rs.getString("fin_rowid"));
			}
			
			
			double dblTotAsset=0.0,dblTotLiab=0.0;
			rs = DBUtils.executeLAPSQuery("sel_totalAssets^"+finance_id+"^"+strAssetFinRowID);
			if(rs.next())
			{
				dblTotAsset=Double.parseDouble(Helper.correctDouble(rs.getString("TotalAsset")));
			}
			
			if(rs!=null)
			{rs.close(); 	
			}
			
			String strLiabFinRowID="0";
			rs = DBUtils.executeLAPSQuery("sel_rowid^"+"TOTAL ASSETS^FI^"+cma);
			if (rs.next()) {
				strLiabFinRowID = Helper.correctInt((String) rs.getString("fin_rowid"));
			}
			if(rs!=null)
			{rs.close(); 	
			}
			rs = DBUtils.executeLAPSQuery("sel_totalLiab^"+finance_id+"^"+strLiabFinRowID);
			if(rs.next())
			{
				dblTotLiab =Double.parseDouble(Helper.correctDouble(rs.getString("TotalLiab")));
			}
			
			if( (dblTotAsset==dblTotLiab) && (dblTotAsset>0 || dblTotLiab>0))
			{
				hshValues.put("AssetandLiab", "Y");
			}
			
			rs = DBUtils.executeLAPSQuery("sel_maxfinanceid^"+appid+"^"+cma);
			if(rs.next())
			{
				if(!finance_id.equalsIgnoreCase(Helper.correctNull((String)rs.getString("maxid"))))
				{
					hshValues.put("DisableAllButtons", "Y");
				}
			}
			

		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getData login  " + ce.toString());

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;
	}
	
	public HashMap getRetailData(HashMap hshRequestValues)  {
		
		HashMap hshRecord = null;
		HashMap hshReqVal =null;	
		int l = 0,agri_Sno=0;
		String strSumAudit = "", strSumUnaudit = "", strSumEstimated = "",strSumProjection = "", sel_divID = "",strQuery = "",strTempYear="";
		String strAppNo = "", queryloamamt="",apploamamt="",strAppId="",strYear="";
		double Dblapploanamt=0.0,AmtValue=0.0;
		ResultSet rs = null, rs1 = null, rs3 = null, rs4 = null,rs5=null,rs10 = null;
		ArrayList arr_labeldetails = new ArrayList();
		hshRecord = new HashMap();
		ArrayList arrVal	= new ArrayList();
		ArrayList arrRec	= new ArrayList();
		ArrayList arrId	= new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();

		try {
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}
			String strCategorytype=correctNull((String)hshRequestValues.get("sessionModuleType"));
			strAppNo = Helper.correctNull((String) hshRequestValues.get("appno"));
		
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String) hshRequestValues.get("strappno"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String) hshRequestValues.get("app_no"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo = Helper.correctNull((String) hshRequestValues.get("APP_NO"));
			}
	        hshRecord.put("sel_divID", sel_divID);	        
			// to display financial data according to eligible loan amount
			if(!strAppNo.equalsIgnoreCase("")){
					
					queryloamamt = SQLParser.getSqlQuery("loanamt_finappdata^"+ strAppNo);
					rs = DBUtils.executeQuery(queryloamamt);
					if (rs.next()) {
					Dblapploanamt=Double.parseDouble((Helper.correctDouble((String)rs.getString("loan_amtreqd"))));
					}
				}
			AmtValue=Dblapploanamt;
			
			hshRecord.put("apploamamt",Dblapploanamt);
				
			int strsize = 0;

			strQuery = SQLParser.getSqlQuery("ret_fin_year_count^" + strAppNo+ "^" + sel_divID);

			if (rs10 != null) {
				rs10.close();
			}
			rs10 = DBUtils.executeQuery(strQuery);
			if (rs10.next()) {

				strsize = rs10.getInt("yearcount");
			}

			strQuery = null;

			String stryear[] = new String[strsize];

			int i = 0;
			strQuery = SQLParser.getSqlQuery("ret_app_financials_select_distinctyear^"+ strAppNo + "^" + sel_divID);
			
			if (rs10 != null)
				rs10.close();
			rs10 = DBUtils.executeQuery(strQuery);
			while (rs10.next()) {

				stryear[i] = rs10.getString("fin_year");
				i++;
			}

			i = 0;
		
			int strcurcount = 0;
			// to check for current year duplication
			strQuery = SQLParser.getSqlQuery("ret_app_financials_select_fintype_curryear^"+ strAppNo + "^" + sel_divID);
			
			if (rs != null){rs.close();}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strcurcount = strcurcount + 1;
			}
			String strdesctype[] = new String[strcurcount];
			int insno[] = new int[strcurcount];
			rs.beforeFirst();
			while (rs.next()) {

				strdesctype[i] = rs.getString("ret_fintype");
				insno[i] = rs.getInt("ret_sno");
				i++;

			}
			// for take Financial Type Base on Priority
			String strpro = "false", strest = "false", straud = "false", strunaud = "false";
			int prosno = 0, estsno = 0, unaudsno = 0, audsno = 0, intyearsno = 0;
			if (i > 0) {
				for (int j = 0; j < strdesctype.length; j++) {

					if (strdesctype[j].equals("PROJECTION"))

					{
						strpro = "true";
						prosno = insno[j];

					}
					if (strdesctype[j].equals("ESTIMATED"))

					{
						strest = "true";
						estsno = insno[j];

					}
					if (strdesctype[j].equals("UNAUDITED"))

					{
						strunaud = "true";
						unaudsno = insno[j];

					}
					if (strdesctype[j].equals("AUDITED")) {
						straud = "true";
						audsno = insno[j];

					}

				}

				if (straud.equals("true")) {
					intyearsno = audsno;

				} else if (strunaud.equals("true")) {
					intyearsno = unaudsno;

				} else if (strest.equals("true")) {
					intyearsno = estsno;

				} else {
					intyearsno = prosno;

				}

			}
			if(strCategorytype.equalsIgnoreCase("AGR"))
			{
		     strQuery = SQLParser.getSqlQuery("cgtmse_agriappvalues_sel1^" + strAppNo);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrRec = new ArrayList();
					arrRec.add(correctNull(rs.getString("RETFIN_ROWID")));
					arrRec.add(correctNull(rs.getString("RETFIN_ROWDESC")));
					arrRec.add(correctNull(rs.getString("RETFIN_AMNTFROM")));
					arrRec.add(correctNull(rs.getString("RETFIN_AMNTTO")));
					
					arrVal.add(arrRec);

				}
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("cgtmse_agri_rowid_sel^" + strAppNo);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					arr_labeldetails.add(correctNull(rs.getString("RETFIN_ROWID")));

				}

				hshRecord.put("labeldetails", arrVal);
				hshRecord.put("arr_labeldetails", arr_labeldetails);
			}
			else
			{
				 strQuery = SQLParser.getSqlQuery("cgtmse_retappvalues_sel1^" + AmtValue);
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						arrRec = new ArrayList();
						arrRec.add(correctNull(rs.getString("RETFIN_ROWID")));
						arrRec.add(correctNull(rs.getString("RETFIN_ROWDESC")));
						arrRec.add(correctNull(rs.getString("RETFIN_AMNTFROM")));
						arrRec.add(correctNull(rs.getString("RETFIN_AMNTTO")));
						
						arrVal.add(arrRec);

					}
					arr_labeldetails = new ArrayList();
					strQuery = SQLParser.getSqlQuery("cgtmse_rowid_sel^" + AmtValue);
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {

						arr_labeldetails.add(correctNull(rs.getString("RETFIN_ROWID")));

					}

					hshRecord.put("labeldetails", arrVal);
					hshRecord.put("arr_labeldetails", arr_labeldetails);
			}
			

			String yearselect = "", seloption = "", givenyear = "";
			i = 0;
			int k = 0;
			int from = 0, p = 0;

			ArrayList vecrec=new ArrayList();
			ArrayList vecrec_strt = new ArrayList();
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[6];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";

			strQuery = SQLParser.getSqlQuery("cgtmse_select2^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryvall = new ArrayList();

			int kk = 0;
			while (rs.next()) {
				arryvall.add(Helper.correctNull(rs.getString("CGTMSE_YEAR")));

			}

		
			String sno = "0";
			
			strQuery = SQLParser.getSqlQuery("ret_app_financials_select_distinctyear^"+ strAppNo + "^" + sel_divID);
			

			if (rs != null) {
				rs.close();
			}
			int o = 1;
	 		int t = 1;
			int r = 1;
			rs = DBUtils.executeQuery(strQuery);
			String audit_flag = "false";
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";
				arrVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs.getString("fin_year"));
				String yearselect_strt = (String) Helper.correctNull(rs.getString("RET_FINYEAR_START"));
				sno = (String) Helper.correctNull(rs.getString("ret_sno"));
				if (!yearselect.equals("")) {
					if (rs3 != null) {
						rs3.close();
					}

					String strQuery10 = SQLParser.getSqlQuery("cgtmse_select3^"+ strAppNo + "^" + yearselect
							+ "^" + sno);
					if (rs10 != null) {
						rs10.close();
					}

					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						strSumAudit = Helper.correctDouble(rs10.getString("sumaudit"));
						strSumUnaudit = Helper.correctDouble(rs10.getString("sumunaudit"));
						strSumEstimated = Helper.correctDouble(rs10.getString("sumestimated"));
						strSumProjection = Helper.correctDouble(rs10.getString("sumprojection"));
					}
					if (valarray[0].equals("0") && !strSumAudit.equals("0")) {
						valarray[0] = "CGTMSE_AUDIT";
						audit_flag = "true";
					}
					if (valarray[1].equals("0") && !strSumUnaudit.equals("0")) {
						valarray[1] = "CGTMSE_UNAUDIT";
					}
					if (valarray[2].equals("0") && !strSumEstimated.equals("0")) {
						valarray[2] = "CGTMSE_ESTIMATED";
					}
					if (valarray[3].equals("0") && !strSumProjection.equals("0")) {
						valarray[3] = "CGTMSE_PROJECTION";
					}

					if (rs10 != null) {
						rs10.close();
					}
		
					for (int h = 0; h < 5; h++) {
						arrVal = new ArrayList();
						arrId = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0.00";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							boolean flag=false;
							
								if(k>=5)
									flag=false;
								else
									flag=true;
							
							if ((i >= from) && flag) {
								p = i;
								k = k + 1;
								hshRecord.put("sno" + (o++), sno);						

								strQuery = SQLParser.getSqlQuery("cgtmse_select4^"+ seloption + "^" + yearselect + "^" + strAppNo+ "^" + sno);

								if (rs1 != null) {
									rs1.close();
								}
								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {

									arrVal.add(correctNull(rs1.getString("txtvalue")));
									arrId.add(correctNull(rs1.getString("retfin_rowid")));

									hshRecord.put("year" + k, arrVal);
									hshRecord.put("vecid" + k, arrId);
								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
								vecrec_strt.add(yearselect_strt);
								strQuery = SQLParser.getSqlQuery("ret_selfinancial_printyear^"+ sno + "^"+strAppNo );
						if (rs1 != null)
							rs1.close();
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next()) {

							hshRecord.put("checkcol" + (t++),Helper.correctNull((String) rs1.getString("FINPRINTYEAR_SELSNO")));

						} else {
							t++;
						}
							}

						}
					}
				}
			}
			if(rs5!=null){rs5.close();}
		
			strQuery = SQLParser.getSqlQuery("sel_ret_printyear1^" + strAppNo+"^" + strAppNo);
			
			 rs5 = DBUtils.executeQuery(strQuery);

				while (rs5.next()) {
					valarray[0] = "0";
					valarray[1] = "0";
					valarray[2] = "0";
					valarray[3] = "0";
					valarray[4] = "0";

					ArrayList ArrprintCheck = new ArrayList();
					sno = (String) Helper.correctNull(rs5.getString("cgtmse_sno"));
			
					strYear = (String) Helper.correctNull(rs5.getString("cgtmse_year"));
					if (!sno.equals(strTempYear)) {		
					strQuery = SQLParser.getSqlQuery("ret_selfinancial_printyear1^"+ strYear + "^" + strAppNo + "^" + sno );

						rs3 = DBUtils.executeQuery(strQuery);

						while (rs3.next()) {
							
								if (valarray[0].equals("0")) {
									valarray[0] = Helper.correctDouble(rs3.getString("cgtmse_audit"));
								}
								if (valarray[1].equals("0")) {
									valarray[1] = Helper.correctDouble(rs3.getString("cgtmse_unaudit"));
								}
								if (valarray[2].equals("0")) {
									valarray[2] = Helper.correctDouble(rs3.getString("cgtmse_estimated"));
								}
								if (valarray[3].equals("0")) {
								valarray[3] = Helper.correctDouble(rs3.getString("cgtmse_projection"));
								}
								if (valarray[4].equals("0")) {
								valarray[4] = Helper.correctDouble(rs3.getString("cgtmse_projection"));
								}
				strQuery = SQLParser.getSqlQuery("ret_selfinancial_printyear^" + sno+ "^"+ strAppNo);
				rs4 = DBUtils.executeQuery(strQuery);
				while (rs4.next()) {
					
					ArrprintCheck .add(Helper.correctNull((String) rs4.getString("finprintyear_selsno")));
				}	
								
									if(ArrprintCheck.contains(sno))
									{
									if (valarray[0].equals("0")) {
										valarray[0] = Helper.correctDouble(rs3.getString("cgtmse_audit"));
									}
									if (valarray[1].equals("0")) {
										valarray[1] = Helper.correctDouble(rs3.getString("cgtmse_unaudit"));
									}
									if (valarray[2].equals("0")) {
										valarray[2] = Helper.correctDouble(rs3.getString("cgtmse_estimated"));
									}
									if (valarray[3].equals("0")) {
									valarray[3] = Helper.correctDouble(rs3.getString("cgtmse_projection"));
									}
									if (valarray[4].equals("0")) {
									valarray[4] = Helper.correctDouble(rs3.getString("cgtmse_projection"));
									}
									}else{
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
										valarray[0]="0";
										valarray[1]="0";
									}
									
								
								
								if (!valarray[0].equals("0")) {
								valarray[0] = "cgtmse_audit";
							}

							if (!valarray[1].equals("0")) {
								valarray[1] = "cgtmse_unaudit";
							}

							if (!valarray[2].equals("0")) {
								valarray[2] = "cgtmse_estimated";
							}

							if (!valarray[3].equals("0")) {
								valarray[3] = "cgtmse_projection";
							}
							if (!valarray[4].equals("0")) {
								valarray[4] = "cgtmse_projection";
							}
						}
						strTempYear = sno;
				}
				}
				

		    hshRecord.put("tempyear", strTempYear);
			hshRecord.put("from", Integer.toString(from));
			hshRecord.put("totalyear", i + "");
			hshRecord.put("upto", p + "");
			hshRecord.put("yearvalue", vecrec);
			hshRecord.put("yearvalue_strt", vecrec_strt);
		

			if(strCategorytype.equalsIgnoreCase("AGR"))
			{	
         	if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("cgtmse_agri_sel^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("RETFIN_ROWID")));
					arrCol.add(correctNull(rs.getString("RETFIN_ROWDESC")));
					arrRow.add(arrCol);
				}
				
				hshRecord.put("VecRow",arrRow);
			}
			else
			{
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("cgtmse_retmaster_sel^"+AmtValue);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("RETFIN_ROWID")));
					arrCol.add(correctNull(rs.getString("RETFIN_ROWDESC")));
					arrRow.add(arrCol);
				}
				
				hshRecord.put("VecRow",arrRow);
			}
				

			//to get value from annexureII
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("cgtmse_sel_appid^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			
			if (rs.next()) 
			{	
				strAppId=Helper.correctNull((String) rs.getString("demo_appid"));
			}
			
			strQuery = SQLParser.getSqlQuery("cgtmse_sel_agrappid^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			
			if (rs.next()) 
			{	
				strAppId=Helper.correctNull((String) rs.getString("DEMO_COMAPPID"));
			}
			hshRequestValues.put("strAppId",strAppId );
			hshRequestValues.put("strAppNo", strAppNo);
			hshRequestValues.put("pageval","CorpAnnexure");
			hshRequestValues=getCorpAnnexureII(hshRequestValues);
			hshRequestValues.put("page","CorpAnnexure");
			hshRecord.put("hshReqValues5",hshRequestValues);	
			hshRecord.put("AmtValue",AmtValue);
			hshRecord.put("strAppNo", strAppNo);
			
			
			int strSno=1;
			strQuery=SQLParser.getSqlQuery("sel_CropCgtmse^"+strAppNo+"^"+strSno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{		
		
				hshRecord.put("CG_DEFAULTER",correctNull((String)rs.getString("CG_DEFAULTER")));
			}
			
			

		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getRetailData login  " + ce.toString());

		} finally {
			try {
				if (rs != null){
					rs.close();}
				if (rs1 != null){
					rs1.close();}
				if (rs3 != null){
					rs3.close();}
				if (rs4 != null){
					rs4.close();}
				if (rs10 != null){
					rs10.close();}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection for GetRetailData "
						+ cf.getMessage());
			}
		}

		return hshRecord;
	}

	public HashMap getDataList(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs4 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		String temptab = "", sel_divID = "";
		int tabcnt = 0, l = 0;
		try {
			sel_divID = correctNull((String) hshRequestValues
					.get("hidsel_divID"));
			strValue = correctNull((String) hshRequestValues.get("appno"));
			String yearvalue[] = new String[5];
			String comboselect[] = new String[5];
			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			ArrayList vecid = new ArrayList();
			// to find the cma format of the particular applications

			String cma = "", tempbool = "2", tabool = "";
			strQuery = SQLParser.getSqlQuery("finselect8^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				cma = rs.getString("cma_no");
			}

			// -----------------to find the tab----------------------

			String page = correctNull((String) hshRequestValues.get("pageval"));

			strQuery = SQLParser.getSqlQuery("finselect9^" + cma);
			rs4 = DBUtils.executeQuery(strQuery);
			while (rs4.next()) {
				tabcnt = tabcnt + 1;
			}
			tabcnt = tabcnt + 1;
			if (tabcnt > 0) {
				String[] tabarr = new String[tabcnt];
				strQuery = SQLParser.getSqlQuery("finselect9a^" + cma);

				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				int y = 0;

				while (rs.next()) {
					tempbool = "2";
					if ((y == 0)
							&& (page.trim().equals("") || page.trim().equals(
									"RA"))) {
						page = correctNull((String) rs.getString("fin_tabname"));
					}
					temptab = correctNull((String) rs.getString("fin_tabname"));

					for (int p = 0; p < tabarr.length; p++) {
						if (tempbool.equals("2")) {
							if (tabarr[p] == null) {
								tabarr[p] = "";
							}
							if (tabarr[p].equals(temptab)) {
								tabool = "false";
								tempbool = "1";
							} else {
								tabool = "true";
							}
						}
					}
					if (tabool.equals("true")) {
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs
								.getString("fin_tabname")));
						vecVal.add(vecRec);
						tabarr[l] = temptab;
						l = l + 1;
					}
					y++;
				}
			}

			hshValues.put("tabdetails", vecVal);
			vecVal = new ArrayList();

			// strQuery =
			// SQLParser.getSqlQuery("finselect3^"+strValue+"^"+cma+"^"+page);
			strQuery = SQLParser.getSqlQuery("finselect3z^" + cma + "^" + page);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			String temp = "";
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("myrowid")));

				temp = Helper.correctNull(rs.getString("desc1"));
				if (temp.equals("")) {
					vecRec.add(correctNull(rs.getString("desc2")));
				} else {
					vecRec.add(correctNull(rs.getString("desc1")));
				}

				vecRec.add(correctNull(rs.getString("fin_rowtype")));
				vecRec.add(correctNull(rs.getString("fin_sno")));
				vecVal.add(vecRec);
			}

			hshValues.put("labeldetails", vecVal);
			vecVal = new ArrayList();
			String desc = "";
			int k = 0;

			yearvalue[0] = correctNull((String) hshRequestValues
					.get("txtyear1"));
			comboselect[0] = correctNull((String) hshRequestValues
					.get("combo1"));
			yearvalue[1] = correctNull((String) hshRequestValues
					.get("txtyear2"));
			comboselect[1] = correctNull((String) hshRequestValues
					.get("combo2"));
			yearvalue[2] = correctNull((String) hshRequestValues
					.get("txtyear3"));
			comboselect[2] = correctNull((String) hshRequestValues
					.get("combo3"));
			yearvalue[3] = correctNull((String) hshRequestValues
					.get("txtyear4"));
			comboselect[3] = correctNull((String) hshRequestValues
					.get("combo4"));
			yearvalue[4] = correctNull((String) hshRequestValues
					.get("txtyear5"));
			comboselect[4] = correctNull((String) hshRequestValues
					.get("combo5"));

			for (int i = 0; i <= 4; i++) {
				vecVal = new ArrayList();
				vecid = new ArrayList();
				if (comboselect[i].equals("a")) {
					comboselect[i] = "fin_audit";
					desc = "a";
				} else if (comboselect[i].equals("u")) {
					comboselect[i] = "fin_unaudit";
					desc = "u";
				} else if (comboselect[i].equals("e")) {
					comboselect[i] = "fin_estimated";
					desc = "e";
				} else if (comboselect[i].equals("p")) {
					comboselect[i] = "fin_projection";
					desc = "p";
				}

				if (!yearvalue[i].equals("") && !comboselect[i].equals("S")
						&& !comboselect[i].equals("")) {
					k = k + 1;
					strQuery = SQLParser.getSqlQuery("finselect5^"
							+ comboselect[i] + "^" + cma + "^" + page + "^"
							+ yearvalue[i] + "^" + strValue + "^" + "0");

					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						int formuladesc = 0;
						formuladesc = (rs1.getInt("formula"));
						if (formuladesc > 0) {
							HashMap hshformula = new HashMap();
							hshformula.put("appno", strValue);
							hshformula.put("formulaid", Integer
									.toString(formuladesc));
							hshformula.put("curryear", yearvalue[i]);
							hshformula.put("prevyear", " ");
							hshformula.put("currfinancialtype", desc);
							hshformula.put("prevfinancialtype", "a");
							hshformula.put("internalcalc", "N");
							hshformula.put("hshdata", new HashMap());
							HashMap hshRes = (HashMap) EJBInvoker
									.executeStateLess("comformula", hshformula,
											"GetFinValue");

							vecVal.add(correctNull((String) hshRes
									.get("strTotalValue")));
							vecid.add(correctNull(rs1
									.getString("fin_rowid")));

							//

							//
						} else {
							vecVal.add(correctNull(rs1
									.getString("txtvalue")));
							vecid.add(correctNull(rs1
									.getString("fin_rowid")));
						}
						hshValues.put("year" + k, vecVal);
						hshValues.put("vecid" + k, vecid);
					}
					vecrec.add(yearvalue[i]);
					vecrec.add(comboselect[i]);

				}

			}
			hshValues.put("sel_divID", sel_divID);
			hshValues.put("from", correctNull((String) hshRequestValues
					.get("fromvalue")));
			hshValues.put("totalyear", correctNull((String) hshRequestValues
					.get("totvalue")));
			hshValues.put("upto", correctNull((String) hshRequestValues
					.get("uptovalue")));
			hshValues.put("yearvalue", vecrec);
			hshValues.put("page", page);
			hshValues.put("identity", "list");
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs4 != null)
					rs4.close();
				if (rs1 != null)
					rs1.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;

	}

	public void deleteData(HashMap hsh)  {
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String year1 = "", year2 = "", year3 = "", year4 = "", year5 = "";
		String c1year = "", c2year = "", c3year = "", c4year = "", c5year = "";
		String chk1 = "", chk2 = "", chk3 = "", chk4 = "", chk5 = "";
		int intUpdatesize = 0;
		String appno = "";

		String strDivid = "";
		ResultSet rs1 = null;
		try {
			appno = correctNull((String) hsh.get("hidfinanceid"));

			String strappno = Helper.correctNull((String) hsh.get("appno"));
			String finance_id = "";
			if (!strappno.equals("")) {
				if (appno.equals("")) {
					String query1 = SQLParser
							.getSqlQuery("comdemographics_sel^" + strappno);
					rs = DBUtils.executeQuery(query1);

					if (rs.next()) {
						finance_id = (Helper.correctNull((String) rs
								.getString("demo_finstandard")));
						appno = (Helper.correctNull((String) rs
								.getString("demo_finstandard")));
					}
				}
			}

			strDivid = correctNull((String) hsh.get("sel_divID"));
			year1 = correctNull((String) hsh.get("txtyear1"));
			year2 = correctNull((String) hsh.get("txtyear2"));
			year3 = correctNull((String) hsh.get("txtyear3"));
			year4 = correctNull((String) hsh.get("txtyear4"));
			year5 = correctNull((String) hsh.get("txtyear5"));

			c1year = correctNull((String) hsh.get("combo1"));
			c2year = correctNull((String) hsh.get("combo2"));
			c3year = correctNull((String) hsh.get("combo3"));
			c4year = correctNull((String) hsh.get("combo4"));
			c5year = correctNull((String) hsh.get("combo5"));

			chk1 = correctNull((String) hsh.get("chk1"));
			chk2 = correctNull((String) hsh.get("chk2"));
			chk3 = correctNull((String) hsh.get("chk3"));
			chk4 = correctNull((String) hsh.get("chk4"));
			chk5 = correctNull((String) hsh.get("chk5"));
			String fromid = Helper.correctNull((String) hsh.get("fromnext"));

			String strsno1 = correctNull((String) hsh.get("strsno1"));
			String strsno2 = correctNull((String) hsh.get("strsno2"));
			String strsno3 = correctNull((String) hsh.get("strsno3"));
			String strsno4 = correctNull((String) hsh.get("strsno4"));
			String strsno5 = correctNull((String) hsh.get("strsno5"));

			if (strDivid.equalsIgnoreCase("")) {
				strDivid = "0";
			}

			/*
			 * //for getting Finance ID of particular appno int finance_id=0;
			 * strQuery =
			 * SQLParser.getSqlQuery("comfinance_appid_seldivid^"+appno
			 * +"^"+strDivid); if(rs != null) { rs.close(); }
			 * rs=DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * finance_id=Integer.parseInt(rs.getString("fin_financeid")); }
			 */

			if ((Helper
					.correctNull((String) hsh.get("chk_delete_projectinput")))
					.equalsIgnoreCase("delete")) {
				HashMap hsQuery = new HashMap();
				HashMap hsQueryValues = new HashMap();
				ArrayList arr = new ArrayList();
				arr.add(hsh.get("appno"));
				hsQuery.put("strQueryId",
						"financial_new_projectinputfields_delete");
				hsQuery.put("arrValues", arr);
				hsQueryValues.put("size", "1");
				hsQueryValues.put("1", hsQuery);
				EJBInvoker.executeStateLess("dataaccess", hsQueryValues,
						"updateData");
			}

			boolean boolFinance = true;
			
			if (!chk1.equals("") && boolFinance) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "finappvaluesdel1");
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno1);

				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear1");
				arrValues.add(appno);
				arrValues.add(fromid);
				arrValues.add(strsno1);
				// arrValues.add(finance_id+"");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno1);

				hshQuery.put("strQueryId", "corp_app_finyear_delete");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				if (!year1.equalsIgnoreCase("")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				boolFinance = false;
			}

			if (!chk2.equals("") && boolFinance) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "finappvaluesdel1");
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno2);

				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear1");
				arrValues.add(appno);
				arrValues.add(fromid);
				arrValues.add(strsno2);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno2);

				hshQuery.put("strQueryId", "corp_app_finyear_delete");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				if (!year2.equalsIgnoreCase("")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				boolFinance = false;
			}

			if (!chk3.equals("") && boolFinance) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "finappvaluesdel1");
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno3);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear1");
				arrValues.add(appno);
				arrValues.add(fromid);
				arrValues.add(strsno3);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno3);

				hshQuery.put("strQueryId", "corp_app_finyear_delete");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				if (!year3.equalsIgnoreCase("")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				boolFinance = false;
			}

			if (!chk4.equals("") && boolFinance) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "finappvaluesdel1");
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno4);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear1");
				arrValues.add(appno);
				arrValues.add(fromid);
				arrValues.add(strsno4);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno4);

				hshQuery.put("strQueryId", "corp_app_finyear_delete");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				if (!year4.equalsIgnoreCase("")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				boolFinance = false;
			}

			if (!chk5.equals("") && boolFinance) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "finappvaluesdel1");
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno5);

				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear1");
				arrValues.add(appno);
				arrValues.add(fromid);
				arrValues.add(strsno5);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strDivid);
				arrValues.add(strsno5);

				hshQuery.put("strQueryId", "corp_app_finyear_delete");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				if (!year5.equalsIgnoreCase("")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				boolFinance = false;
			}

		} catch (Exception e) {
			log.error("in bean" + e);
		}

		finally {
			try {

				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}

	public HashMap getDataRatio(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rsPrevYear = null;
		ResultSet rsFormulaFor = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "", strAppName = "", strPage = "", year="";
		String page = "";
		int maxYear = 5;
		int str = 0;
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		hshValues = new HashMap();
		String strValuesin = "";
		try { 
			strValue = correctNull((String) hshRequestValues.get("appno"));
			if( strValue.equals(""))
			{ 
				 strValue = correctNull((String) hshRequestValues.get("hidRatAppNo"));
			} 
			String pageType=correctNull((String)hshRequestValues.get("pageType"));
			String appidnew=correctNull((String)hshRequestValues.get("hid_appid"));
			String strRating = correctNull((String)hshRequestValues.get("rating"));
			String strOFR = correctNull((String)hshRequestValues.get("OFR"));
			// Adde d by Kishan
			String strFinID = "0",givenyear="";
			String cma = "0";
			int from =  0;
			givenyear =  correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear  = "0";
			} 
			from = Integer.parseInt(givenyear);
			if ( from == 0) {
				from = 1;
			} 
			 
			if(strOFR.equalsIgnoreCase("Y"))
			{ 
				 strQuery = SQLParser.getSqlQuery("sel_financeid_ofr^" + strValue);
				rs = DBUtils.executeQuery(strQuery);
				if  (rs.next()) {
					 strFinID = Helper.correctInt((String) rs
					  		.getString("FIN_FINID"));
				} 
			} 
			else
			{ 
				 strQuery = SQLParser.getSqlQuery("sel_financeid^" + strValue);
				rs = DBUtils.executeQuery(strQuery);
				if  (rs.next()) {
					 strFinID = Helper.correctInt((String) rs
					 		.getString("DEMO_FINSTANDARD"));
				}  
			} 
			 
			if (strValue.equalsIgnoreCase("")) {
				 strFinID = Helper.correctInt((String) hshRequestValues
				 		.get("FinID"));
			} 
			if  (strFinID.equalsIgnoreCase("") || strFinID.equalsIgnoreCase("0")) {
				 strFinID = Helper.correctInt((String) hshRequestValues
				 		.get("hidfinid"));
			}  
			if  (!strFinID.equals("")) {
				 strQuery = SQLParser
				 		.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if  (rs.next()) {
					 cma = Helper
					 		.correctNull((String) rs.getString("FIN_CMANO"));
					strValuesin = Helper.correctNull((String) rs
						 	.getString("fin_valuesarein"));
				} 
			} 
			hshValues.put("strValuesin", strValuesin);
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			 
			String strPrintYear=correctNull((String)hshRequestValues.get("printYear"));
			 
			strQuery = SQLParser.getSqlQuery("com_selfin_printyearsno^" + strFinID);
			rs  = DBUtils.executeQuery(strQuery);
			ArrayList ArrprintCheck = new ArrayList();
			while (rs.next()) {
				ArrprintCheck .add(Helper.correctNull((String) rs.getString("finprintyear_selsno")));
			} 
			page = correctNull((String) hshRequestValues.get("page"));
			if  (page.equalsIgnoreCase("")) {
				 page = "RA";
			} 
			strPage = correctNull((String) hshRequestValues.get("pageFrom")); // Ratio
				 																// Type
				 																// RA1,RA2,RA3
			if (strPage.equalsIgnoreCase("")) {
				strPage = correctNull((String) hshRequestValues.get("pagefrom")); // Assessment
					 																// type
					 																// -
					 																// Export
					 																// limits
			} 
			if  (strPage.equalsIgnoreCase("")) {
				 strPage = correctNull((String) hshRequestValues
				 		.get("pagefrom1")); // Assessment type - Export limits
			}  
			if  (strPage.equals("")) {
				 strPage = correctNull((String) hshRequestValues.get("pagefr"));
			}// d efaulty RA1 must be loaded
			String  pagename = correctNull((String) hshRequestValues
					 .get("pagename"));
			if (strPage.equalsIgnoreCase("M1")
					||  strPage.equalsIgnoreCase("M2")
					||  strPage.equalsIgnoreCase("AFL")) {
				HashMap  hshassess = new HashMap();
				hshassess.put("appno", strValue);
				hshassess.put("strFinID", strFinID);
				hshassess.put("page", "INV");
				hshassess.put ("from", String.valueOf(from));
				hshassess.put( "pagefrom1", "I1");
				hshassess.put("pageType", "assesment");
				hshassess.put("pagename", strPage);
				hshValues.put("hshnew", getDataAssessment(hshassess));
			} 
 
 			/*
  			 * Added by Amaravathi for get financial values from Finappvalues
	 		 * and put in one separate HashMap
	 		 */
	 		HashMap hshFinYearVal = new HashMap();
	 		hshFinYearVal.put("appno", strValue);
	 		hshFinYearVal.put("strFinID", strFinID);
	 		hshFinYearVal.put("comappid", correctNull((String) hshRequestValues
	 				.get("sel_divID")));
	 		hshFinYearVal = getFinValues(hshFinYearVal);
	 		/*
	 		 * End
	  		 */
 
 			// -----------to get the borrower name-------------
 			strQuery = SQLParser.getSqlQuery("com_lapsidsearch2^" + strValue);
 			rs = DBUtils.executeQuery(strQuery);
 
 			if (rs.next()) {
 				strAppName = correctNull((String) rs
 						.getString("comapp_companyname"));
 			}
  			if (rs != null) {
	 			rs.close();
	 		}
 
			// -------------- to find the time of review-----------------

			strQuery = SQLParser.getSqlQuery("finselect1^" + strFinID + "^0");
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				str = rs.getInt("cnt");
			}
			if (rs != null) {
				rs.close();
			}

			// --------------- to find the cma format of the particular
			// applications-------

			// String cma="";
			// strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			/*
			 * strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue); rs =
			 * DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=rs.getString("demo_finstandard"); }
			 * hshValues.put("cma",cma); if(rs!=null) { rs.close(); }
			 */

			// -----------------to find the tab----------------------
			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application

			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2anew^" + cma + "^"
						+ page + "^" + strPage);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);

				}

				hshValues.put("labeldetails", vecVal);

			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				// strQuery =
				// SQLParser.getSqlQuery("finselect3a^"+strValue+"^"+cma+"^"+page);
				strQuery = SQLParser.getSqlQuery("finselect3anew^" + cma + "^"
						+ page + "^" + strPage);

				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);
				}

				hshValues.put("labeldetails", vecVal);

			}

			if (rs != null) {
				rs.close();
			}
			hshValues.put("count", Integer.toString(str));

			String yearselect = "",yearselect_strt="", seloption = "",  yearvalue = "", tempyear = "";
			int i = 0, k = 0;
			int p = 0;
			int yearint = 0;
			ArrayList vecrec = new ArrayList();
			ArrayList vecrecStrt = new ArrayList();

			/*if(pageType.equalsIgnoreCase("AN4")||pageType.equalsIgnoreCase("AN9")||pageType.equalsIgnoreCase("MCFD"))
			{
				if(rs!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("finselectcount^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					maxYear=rs.getInt(1);
				}
			}*/
			if(rs!=null){rs.close();}
			String valarray[] = new String[5];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";
			String sno = "";
			int o=1;
			boolean ratioflag=true;
			String strappstatus=Helper.correctNull((String)hshRequestValues.get("strappstatus"));
			if(!strRating.equalsIgnoreCase("Y") && strappstatus.equalsIgnoreCase("pa"))
			{
				strQuery = SQLParser.getSqlQuery("sel_comratiosel_year_sanction^" +strValue+"^"+strPage);
				ResultSet rsfin = DBUtils.executeQuery(strQuery);
				if(rsfin.next())
				{
					
					String strBuffer="";
					if(strPage.equalsIgnoreCase("RA1")||strPage.equalsIgnoreCase("RA2"))
						strBuffer="  and finprintyear_pageid in ('ASSETS','LIABILITIES','PROFIT AND LOSS ACCOUNT')";
					else
						strBuffer=" and finprintyear_pageid='"+strPage+"'";
					
					strQuery = SQLParser.getSqlQuery("finselect4a_ratio^" + strValue);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						valarray[0] = "0";
						valarray[1] = "0";
						valarray[2] = "0";
						valarray[3] = "0";
						valarray[4] = "0";
						vecVal = new ArrayList();
						String desc = "";
						sno = (String) Helper.correctNull(rs.getString("fin_sno"));
						yearselect = (String) Helper.correctNull(rs.getString("fin_year"));
						yearvalue = (String) Helper.correctNull(rs.getString("yearvalue"));
						
						strQuery = SQLParser.getSqlQuery("sel_comratiosel_year_sanction_display^"+ yearselect + "^" + strValue + "^" + sno + "^"+ strPage);
						rs3 = DBUtils.executeQuery(strQuery);
						while (rs3.next())
						{
							if (valarray[0].equals("0"))
							{
								valarray[0] = Helper.correctDouble(rs3.getString("fin_audit"));
							}
							if (valarray[1].equals("0"))
							{
								valarray[1] = Helper.correctDouble(rs3.getString("fin_unaudit"));
							}
							if (valarray[2].equals("0"))
							{
								valarray[2] = Helper.correctDouble(rs3.getString("fin_estimated"));
							}
							if (valarray[3].equals("0"))
							{
								valarray[3] = Helper.correctDouble(rs3.getString("fin_projection"));
							}
							if (valarray[4].equals("0"))
							{
								valarray[4] = Helper.correctDouble(rs3.getString("fin_projection"));
							}
							if (!valarray[0].equals("0")) {
								valarray[0] = "fin_audit";
							}

							if (!valarray[1].equals("0")) {
								valarray[1] = "fin_unaudit";
							}

							if (!valarray[2].equals("0")) {
								valarray[2] = "fin_estimated";
							}

							if (!valarray[3].equals("0")) {
								valarray[3] = "fin_projection";
							}
							if (!valarray[4].equals("0")) {
								valarray[4] = "fin_projection";
							}
						
						}
						if (rs3 != null) {
							rs3.close();
						}
						for (int h = 0; h <= 3; h++)
						{
							vecVal = new ArrayList();
							vecid = new ArrayList();

							if (valarray[h].equals("")) 
							{
								valarray[h] = "0";
							}
							if (!valarray[h].equals("0"))
							{
								i = i + 1;
								seloption = valarray[h];
								boolean max;
								if(k>=5)
									max=false;
								else
									max=true;
								
								if ((i >= from) && max) {
									p = i;
									k = k + 1;
									strQuery = SQLParser
									.getSqlQuery("finratio1new^" + page+ "^" + cma + "^" + strPage);

									rs1 = DBUtils.executeQuery(strQuery);
									while (rs1.next())
									{
										if (seloption.equals("fin_audit")) 
										{
											desc = "a";
										}
										else if (seloption.equals("fin_unaudit"))
										{
											desc = "u";
										}
										else if (seloption.equals("fin_estimated"))
										{
											desc = "e";
										}
										else if (seloption.equals("fin_projection"))
										{
											desc = "p";
										}
										
										strQuery = SQLParser.getSqlQuery("finselect4a_financialratio^"+ yearselect + "^" + strValue + "^" + sno + "^"+ correctNull(rs1.getString("FIN_ROWID")));
										rs3 = DBUtils.executeQuery(strQuery);
										while (rs3.next())
										{
											if (seloption.equals("fin_audit")) 
											{
												vecVal.add(correctNull((String) rs3.getString("fin_audit")));
											}
											else if (seloption.equals("fin_unaudit"))
											{
												vecVal.add(correctNull((String) rs3.getString("fin_unaudit")));
											}
											else if (seloption.equals("fin_estimated"))
											{
												vecVal.add(correctNull((String) rs3.getString("fin_estimated")));
											}
											else if (seloption.equals("fin_projection"))
											{
												vecVal.add(correctNull((String) rs3.getString("fin_projection")));
											}
											
										}
										vecid.add(correctNull(rs1.getString("fin_rowid")));
										hshValues.put("year" + k, vecVal);
										hshValues.put("vecid" + k, vecid);
									}
									if (rs1 != null) {
										rs1.close();
									}
									vecrec.add(yearselect);
									vecrec.add(seloption);
								}
							}
							
							
						}
						yearint = yearint + 1;
						tempyear = sno;
					}
				}
				else
				{
					ratioflag=false;
					if(strRating.equalsIgnoreCase("Y"))
					{
							strQuery = SQLParser.getSqlQuery("finselectratio_ratingyear^" + strFinID+"^" + strFinID);
					}
					else
					{
						String strBuffer="";
						if(strPage.equalsIgnoreCase("RA1")||strPage.equalsIgnoreCase("RA2"))
							strBuffer="  and finprintyear_pageid in ('ASSETS','LIABILITIES','PROFIT AND LOSS ACCOUNT')";
						else
							strBuffer=" and finprintyear_pageid='"+strPage+"'";
						if(!strPrintYear.equalsIgnoreCase("Y"))
							strQuery = SQLParser.getSqlQuery("finselect4a^" + strFinID);
						else
							strQuery = SQLParser.getSqlQuery("finselectratio_printyear^" + strFinID+"^" + strFinID+"^"+strBuffer);
					}
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						valarray[0] = "0";
						valarray[1] = "0";
						valarray[2] = "0";
						valarray[3] = "0";
						valarray[4] = "0";

						vecVal = new ArrayList();
						String str1 = "", str2 = "", str3 = "", str0 = "";
						String desc = "", formula_desc = "";
						sno = (String) Helper.correctNull(rs.getString("fin_sno"));
						// strPage=
						// (String)Helper.correctNull(rs.getString("hidFinPage"));
						// To Find the years assigned for each application

						yearselect = (String) Helper.correctNull(rs
								.getString("fin_year"));
						
						if(strRating.equalsIgnoreCase("Y"))
						{
							yearselect_strt = (String) Helper.correctNull(rs
									.getString("finyear_start"));
						}
						yearvalue = (String) Helper.correctNull(rs
								.getString("yearvalue"));
						if (!sno.equals(tempyear)) {

							// to check for the occurance of audited,.,.,. for a
							// paricular year

							/*
							 * strQuery =
							 * SQLParser.getSqlQuery("finselect7a^"+yearselect
							 * +"^"+strValue+"^"+sno);
							 * 
							 * rs3 = DBUtils.executeQuery(strQuery);
							 * 
							 * while(rs3.next()) { if(valarray[0].equals("0")) {
							 * valarray
							 * [0]=Helper.correctDouble(rs3.getString("fin_audit")); }
							 * if(valarray[1].equals("0")) {
							 * valarray[1]=Helper.correctDouble
							 * (rs3.getString("fin_unaudit")); }
							 * if(valarray[2].equals("0")) {
							 * valarray[2]=Helper.correctDouble
							 * (rs3.getString("fin_estimated")); }
							 * if(valarray[3].equals("0")) {
							 * valarray[3]=Helper.correctDouble
							 * (rs3.getString("fin_projection")); }
							 * if(valarray[4].equals("0")) {
							 * valarray[4]=Helper.correctDouble
							 * (rs3.getString("fin_projection")); }
							 * 
							 * if (!valarray[0].equals("0")) { valarray[0]= "fin_audit";
							 * }
							 * 
							 * if (!valarray[1].equals("0")) { valarray[1] =
							 * "fin_unaudit"; }
							 * 
							 * if (!valarray[2].equals("0")) { valarray[2] =
							 * "fin_estimated"; }
							 * 
							 * if (!valarray[3].equals("0")) { valarray[3] =
							 * "fin_projection"; } if (!valarray[4].equals("0")) {
							 * valarray[4] = "fin_projection"; } }
							 */
							strQuery = SQLParser.getSqlQuery("finselect7a^"
									+ yearselect + "^" + strFinID + "^" + sno + "^"
									+ strPage);

							rs3 = DBUtils.executeQuery(strQuery);

							while (rs3.next()) {
								
									if (valarray[0].equals("0")) {
										valarray[0] = Helper.correctDouble(rs3
												.getString("fin_audit"));
									}
									if (valarray[1].equals("0")) {
										valarray[1] = Helper.correctDouble(rs3
												.getString("fin_unaudit"));
									}
									if (valarray[2].equals("0")) {
										valarray[2] = Helper.correctDouble(rs3
											.getString("fin_estimated"));
									}
									if (valarray[3].equals("0")) {
									valarray[3] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									if (valarray[4].equals("0")) {
									valarray[4] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
								
									if(pageType.equalsIgnoreCase("AN9"))
									{
										if(ArrprintCheck.contains(sno))
										{
										if (valarray[2].equals("0")) {
											valarray[2] = Helper.correctDouble(rs3
												.getString("fin_estimated"));
										}
										if (valarray[3].equals("0")) {
										valarray[3] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										if (valarray[4].equals("0")) {
										valarray[4] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										valarray[0]="0";
										valarray[1]="0";
										}else{
											valarray[4]="0";
											valarray[2]="0";
											valarray[3]="0";
											valarray[0]="0";
											valarray[1]="0";
										}
									}
									if(pageType.equalsIgnoreCase("MCFD"))
									{
										if (valarray[0].equals("0")) {
											valarray[0] = Helper.correctDouble(rs3
													.getString("fin_audit"));
										}
										if (valarray[1].equals("0")) {
											valarray[1] = Helper.correctDouble(rs3
													.getString("fin_unaudit"));
										}
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
									}
									if(pageType.equalsIgnoreCase("AN4"))
									{
										if(ArrprintCheck.contains(sno))
										{
										if (valarray[0].equals("0")) {
											valarray[0] = Helper.correctDouble(rs3
													.getString("fin_audit"));
										}
										if (valarray[1].equals("0")) {
											valarray[1] = Helper.correctDouble(rs3
													.getString("fin_unaudit"));
										}
										if (valarray[2].equals("0")) {
											valarray[2] = Helper.correctDouble(rs3
												.getString("fin_estimated"));
										}
										if (valarray[3].equals("0")) {
										valarray[3] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										if (valarray[4].equals("0")) {
										valarray[4] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										}else{
											valarray[4]="0";
											valarray[2]="0";
											valarray[3]="0";
											valarray[0]="0";
											valarray[1]="0";
										}
										
									}
									if(pageType.equalsIgnoreCase("EAN9"))
									{
										if(ArrprintCheck.contains(sno))
										{
										if (valarray[2].equals("0")) {
											valarray[2] = Helper.correctDouble(rs3
												.getString("fin_estimated"));
										}
										if (valarray[3].equals("0")) {
										valarray[3] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										if (valarray[4].equals("0")) {
										valarray[4] = Helper.correctDouble(rs3
												.getString("fin_projection"));
										}
										valarray[0]="0";
										valarray[1]="0";
										}else{
											valarray[4]="0";
											valarray[2]="0";
											valarray[3]="0";
											valarray[0]="0";
											valarray[1]="0";
										}
									}
									if(pageType.equalsIgnoreCase("EAN4"))
									{
										if(ArrprintCheck.contains(sno))
										{
											if (valarray[0].equals("0")) {
												valarray[0] = Helper.correctDouble(rs3
														.getString("fin_audit"));
											}
											if (valarray[1].equals("0")) {
												valarray[1] = Helper.correctDouble(rs3
														.getString("fin_unaudit"));
											}
											valarray[2]="0";
											valarray[3]="0";
											valarray[4]="0";
										}else{
											valarray[4]="0";
											valarray[2]="0";
											valarray[3]="0";
											valarray[0]="0";
											valarray[1]="0";
										}
									}
								if (!valarray[0].equals("0")) {
									valarray[0] = "fin_audit";
								}

								if (!valarray[1].equals("0")) {
									valarray[1] = "fin_unaudit";
								}

								if (!valarray[2].equals("0")) {
									valarray[2] = "fin_estimated";
								}

								if (!valarray[3].equals("0")) {
									valarray[3] = "fin_projection";
								}
								if (!valarray[4].equals("0")) {
									valarray[4] = "fin_projection";
								}
							}
							if (rs3 != null) {
								rs3.close();
							}

							// to find the values for each label with respect to
							// value(a,una,p,e),year and id

							for (int h = 0; h <= 3; h++) {
								vecVal = new ArrayList();
								vecid = new ArrayList();

								if (valarray[h].equals("")) {
									valarray[h] = "0";
								}
								if (!valarray[h].equals("0")) {
									i = i + 1;
									seloption = valarray[h];
									boolean max;
									if (pagename.equalsIgnoreCase("FI") || pageType.equalsIgnoreCase("AN4")||pageType.equalsIgnoreCase("AN9")||pageType.equalsIgnoreCase("EAN9")||pageType.equalsIgnoreCase("MCFD")||((strPage.equalsIgnoreCase("M1")||strPage.equalsIgnoreCase("M2")||strPage.equalsIgnoreCase("AFL"))&&strPrintYear.equalsIgnoreCase("Y"))||(Helper.correctNull((String)hshRequestValues.get("hidPageId")).equals("comwrflw"))) {
										max = true;
									} else {
										if(k>=5)
											max=false;
										else
											max=true;
										
										//max = (k < maxYear);
									}
									if ((i >= from) && max) {
										p = i;
										k = k + 1;
										strQuery = SQLParser
												.getSqlQuery("finratio1new^" + page
														+ "^" + cma + "^" + strPage);

										rs1 = DBUtils.executeQuery(strQuery);
										while (rs1.next()) {
											if (seloption.equals("fin_audit")) {
												desc = "a";
											} else if (seloption.equals("fin_unaudit")) {
												desc = "u";
											} else if (seloption
													.equals("fin_estimated")) {
												desc = "e";
											} else if (seloption
													.equals("fin_projection")) {
												desc = "p";
											}

											double dblBankBorr = 0.00;
											if (rs4 != null)
												rs4.close();

											if (cma.equalsIgnoreCase("5"))
												strQuery = SQLParser
														.getSqlQuery("selcomfinvalues^"
																+ strFinID + "^461"
																+ "^" + yearselect);
											else
												strQuery = SQLParser
														.getSqlQuery("selcomfinvalues^"
																+ strFinID + "^1005^"
																+ yearselect);

											rs4 = DBUtils.executeQuery(strQuery);
											if (rs4.next()) {
												dblBankBorr = Double
														.parseDouble((Helper
																.correctDouble((String) rs4
																		.getString("finvalue"))));
											}

											int formuladesc = 0;
											formuladesc = (rs1.getInt("fin_formula"));

											if (formuladesc > 0) {

												strQuery = SQLParser
														.getSqlQuery("selfinformula^"
																+ formuladesc);

												rsFormulaFor = DBUtils
														.executeQuery(strQuery);
												String strFormulaFor = "";
												if (rsFormulaFor.next()) {
													strFormulaFor = correctNull((String) rsFormulaFor
															.getString("formula_for"));
												}

												String strPreYear = "", strPreYearDesc = "";
												if (rsFormulaFor != null) {
													rsFormulaFor.close();
												}
												if ((strFormulaFor.trim()
														.equalsIgnoreCase("CA"))
														|| (strFormulaFor.trim()
																.equalsIgnoreCase("ST"))) {
													strQuery = SQLParser
															.getSqlQuery("selpreyrs^"
																	+ strFinID + "^<^"
																	+ yearselect);

													rsPrevYear = DBUtils
															.executeQuery(strQuery);
													if (rsPrevYear.next()) {
														double audit = rsPrevYear
																.getDouble("audit");
														double unaudit = rsPrevYear
																.getDouble("unaudit");
														double estimated = rsPrevYear
																.getDouble("estimated");
														double projection = rsPrevYear
																.getDouble("projection");
														if (audit != 0) {
															strPreYearDesc = "A";
														} else if (unaudit != 0) {
															strPreYearDesc = "U";
														} else if (estimated != 0) {
															strPreYearDesc = "E";
														} else if (projection != 0) {
															strPreYearDesc = "P";
														}
														strPreYear = rsPrevYear
																.getString("prevyear");
													}
													if (rsPrevYear != null) {
														rsPrevYear.close();
													}

													if (!strPreYear.trim().equals("")) {
														HashMap hshformula = new HashMap();
														hshformula.put("appno",
																strValue);
														hshformula.put("strFinID",
																strFinID);
														hshformula
																.put(
																		"formulaid",
																		Integer
																				.toString(formuladesc));
														hshformula.put("curryear",
																yearselect);
														hshformula.put("prevyear",
																strPreYear);
														hshformula.put(
																"currfinancialtype",
																desc);
														hshformula.put(
																"prevfinancialtype",
																strPreYearDesc);
														hshformula.put("internalcalc",
																"N");
														hshformula.put("sno", sno);
														if (strFormulaFor.trim()
																.equalsIgnoreCase("ST")) {
															hshformula.put("isstress",
																	"Y");
															hshformula.put(
																	"ratiostress", "Y");
														}
														hshformula.put("hshdata",
																new HashMap());
														hshformula.put("hshFinYearVal",
																hshFinYearVal);

														HashMap hshRes = (HashMap) EJBInvoker
																.executeStateLess(
																		"comformula",
																		hshformula,
																		"GetFinValue");

														vecVal
																.add(correctNull((String) hshRes
																		.get("strTotalValue")));
													} else {
														vecVal.add("-");

													}

												} else {
													HashMap hshformula = new HashMap();
													hshformula.put("appno", strValue);
													hshformula
															.put("strFinID", strFinID);
													hshformula.put("formulaid", Integer
															.toString(formuladesc));
													hshformula.put("curryear",
															yearselect);
													hshformula.put("prevyear",
															strPreYear);
													hshformula.put("currfinancialtype",
															desc);
													hshformula.put("prevfinancialtype",
															strPreYearDesc);
													hshformula.put("internalcalc", "N");
													hshformula.put("sno", sno);
													hshformula.put("hshdata",
															new HashMap());
													hshformula.put("hshFinYearVal",
															hshFinYearVal);
													HashMap hshRes = (HashMap) EJBInvoker
															.executeStateLess(
																	"comformula",
																	hshformula,
																	"GetFinValue");
													vecVal
															.add(correctNull((String) hshRes
																	.get("strTotalValue")));

												}
												vecid.add(correctNull(rs1
														.getString("fin_rowid")));
											} else {
												String finrowid = correctNull(rs1
														.getString("fin_rowid"));
												if ((cma.equalsIgnoreCase("5") && (finrowid
														.equalsIgnoreCase("1237")
														|| finrowid
																.equalsIgnoreCase("1226") || finrowid
														.equalsIgnoreCase("1230")))
														|| (cma.equalsIgnoreCase("9") && (finrowid
																.equalsIgnoreCase("1220")
																|| finrowid
																		.equalsIgnoreCase("1242") || finrowid
																.equalsIgnoreCase("1224")))||(cma.equalsIgnoreCase("1") && (finrowid
														.equalsIgnoreCase("1271")
														|| finrowid
																.equalsIgnoreCase("1301") || finrowid
														.equalsIgnoreCase("1306")))) {
													if (vecVal.size() >= 2) {
														double WCG = Double
																.parseDouble((Helper
																		.correctDouble((String) vecVal
																				.get(0))));
														double MWCG = Double
																.parseDouble((Helper
																		.correctDouble((String) vecVal
																				.get(1))));
														double NWC = Double
																.parseDouble((Helper
																		.correctDouble((String) vecVal
																				.get(2))));
														double diffMWCG = 0.00, diffNWC = 0.00;
														diffMWCG = WCG - MWCG;
														diffNWC = WCG - NWC;
														if (diffMWCG < diffNWC) {
															vecVal.add(nf
																	.format(diffMWCG));
														} else {
															vecVal.add(nf
																	.format(diffNWC));
														}
													} else {
														vecVal.add("0.00");
													}
												} else if ((cma.equalsIgnoreCase("5") && (finrowid
														.equalsIgnoreCase("1227")
														|| finrowid
																.equalsIgnoreCase("1238") || finrowid
														.equalsIgnoreCase("1231")))
														|| (cma.equalsIgnoreCase("9") && (finrowid
																.equalsIgnoreCase("1221")
																|| finrowid
																		.equalsIgnoreCase("1243") || finrowid
																.equalsIgnoreCase("1225")))||(cma.equalsIgnoreCase("1") && (finrowid
																		.equalsIgnoreCase("1302")
																		|| finrowid
																				.equalsIgnoreCase("1272") || finrowid
																		.equalsIgnoreCase("1307")))) {
													if (vecVal.size() >= 3) {
														double dblMPBF = Double
																.parseDouble((Helper
																		.correctDouble((String) vecVal
																				.get(3))));
														double diffMPBF = 0.00;
														diffMPBF = dblBankBorr
																- dblMPBF;
														if (diffMPBF > 0) {
															vecVal.add(nf
																	.format(diffMPBF));
														} else {
															vecVal.add("0.00");
														}
													} else {
														vecVal.add("0.00");
													}
												} else {
													vecVal.add("0.00");
												}
												vecid.add(correctNull(rs1
														.getString("fin_rowid")));
											}
											hshValues.put("year" + k, vecVal);
											hshValues.put("vecid" + k, vecid);

										}

										if (rs1 != null) {
											rs1.close();
										}
										vecrec.add(yearselect);
										vecrec.add(seloption);
										vecrecStrt.add(yearselect_strt);
										hshValues.put("FPSno" + (o++), sno);
									}

								}
							}

						}
						
						yearint = yearint + 1;
						tempyear = sno;
					}

					
				}
			}
			else
			{
				if(strRating.equalsIgnoreCase("Y"))
				{
						strQuery = SQLParser.getSqlQuery("finselectratio_ratingyear^" + strFinID+"^" + strFinID);
				}
				else
				{
					String strBuffer="";
					if(strPage.equalsIgnoreCase("RA1")||strPage.equalsIgnoreCase("RA2"))
						strBuffer="  and finprintyear_pageid in ('ASSETS','LIABILITIES','PROFIT AND LOSS ACCOUNT')";
					else
						strBuffer=" and finprintyear_pageid='"+strPage+"'";
					if(!strPrintYear.equalsIgnoreCase("Y"))
						strQuery = SQLParser.getSqlQuery("finselect4a^" + strFinID);
					else
						strQuery = SQLParser.getSqlQuery("finselectratio_printyear^" + strFinID+"^" + strFinID+"^"+strBuffer);
				}
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					valarray[0] = "0";
					valarray[1] = "0";
					valarray[2] = "0";
					valarray[3] = "0";
					valarray[4] = "0";

					vecVal = new ArrayList();
					String str1 = "", str2 = "", str3 = "", str0 = "";
					String desc = "", formula_desc = "";
					sno = (String) Helper.correctNull(rs.getString("fin_sno"));
					// strPage=
					// (String)Helper.correctNull(rs.getString("hidFinPage"));
					// To Find the years assigned for each application

					yearselect = (String) Helper.correctNull(rs
							.getString("fin_year"));
					
					if(strRating.equalsIgnoreCase("Y"))
					{
						yearselect_strt = (String) Helper.correctNull(rs
								.getString("finyear_start"));
					}
					yearvalue = (String) Helper.correctNull(rs
							.getString("yearvalue"));
					if (!sno.equals(tempyear)) {

						// to check for the occurance of audited,.,.,. for a
						// paricular year

						/*
						 * strQuery =
						 * SQLParser.getSqlQuery("finselect7a^"+yearselect
						 * +"^"+strValue+"^"+sno);
						 * 
						 * rs3 = DBUtils.executeQuery(strQuery);
						 * 
						 * while(rs3.next()) { if(valarray[0].equals("0")) {
						 * valarray
						 * [0]=Helper.correctDouble(rs3.getString("fin_audit")); }
						 * if(valarray[1].equals("0")) {
						 * valarray[1]=Helper.correctDouble
						 * (rs3.getString("fin_unaudit")); }
						 * if(valarray[2].equals("0")) {
						 * valarray[2]=Helper.correctDouble
						 * (rs3.getString("fin_estimated")); }
						 * if(valarray[3].equals("0")) {
						 * valarray[3]=Helper.correctDouble
						 * (rs3.getString("fin_projection")); }
						 * if(valarray[4].equals("0")) {
						 * valarray[4]=Helper.correctDouble
						 * (rs3.getString("fin_projection")); }
						 * 
						 * if (!valarray[0].equals("0")) { valarray[0]= "fin_audit";
						 * }
						 * 
						 * if (!valarray[1].equals("0")) { valarray[1] =
						 * "fin_unaudit"; }
						 * 
						 * if (!valarray[2].equals("0")) { valarray[2] =
						 * "fin_estimated"; }
						 * 
						 * if (!valarray[3].equals("0")) { valarray[3] =
						 * "fin_projection"; } if (!valarray[4].equals("0")) {
						 * valarray[4] = "fin_projection"; } }
						 */
						strQuery = SQLParser.getSqlQuery("finselect7a^"
								+ yearselect + "^" + strFinID + "^" + sno + "^"
								+ strPage);

						rs3 = DBUtils.executeQuery(strQuery);

						while (rs3.next()) {
							
								if (valarray[0].equals("0")) {
									valarray[0] = Helper.correctDouble(rs3
											.getString("fin_audit"));
								}
								if (valarray[1].equals("0")) {
									valarray[1] = Helper.correctDouble(rs3
											.getString("fin_unaudit"));
								}
								if (valarray[2].equals("0")) {
									valarray[2] = Helper.correctDouble(rs3
										.getString("fin_estimated"));
								}
								if (valarray[3].equals("0")) {
								valarray[3] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
								if (valarray[4].equals("0")) {
								valarray[4] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
							
								if(pageType.equalsIgnoreCase("AN9"))
								{
									if(ArrprintCheck.contains(sno))
									{
									if (valarray[2].equals("0")) {
										valarray[2] = Helper.correctDouble(rs3
											.getString("fin_estimated"));
									}
									if (valarray[3].equals("0")) {
									valarray[3] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									if (valarray[4].equals("0")) {
									valarray[4] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									valarray[0]="0";
									valarray[1]="0";
									}else{
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
										valarray[0]="0";
										valarray[1]="0";
									}
								}
								if(pageType.equalsIgnoreCase("MCFD"))
								{
									if (valarray[0].equals("0")) {
										valarray[0] = Helper.correctDouble(rs3
												.getString("fin_audit"));
									}
									if (valarray[1].equals("0")) {
										valarray[1] = Helper.correctDouble(rs3
												.getString("fin_unaudit"));
									}
									valarray[4]="0";
									valarray[2]="0";
									valarray[3]="0";
								}
								if(pageType.equalsIgnoreCase("AN4"))
								{
									if(ArrprintCheck.contains(sno))
									{
									if (valarray[0].equals("0")) {
										valarray[0] = Helper.correctDouble(rs3
												.getString("fin_audit"));
									}
									if (valarray[1].equals("0")) {
										valarray[1] = Helper.correctDouble(rs3
												.getString("fin_unaudit"));
									}
									if (valarray[2].equals("0")) {
										valarray[2] = Helper.correctDouble(rs3
											.getString("fin_estimated"));
									}
									if (valarray[3].equals("0")) {
									valarray[3] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									if (valarray[4].equals("0")) {
									valarray[4] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									}else{
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
										valarray[0]="0";
										valarray[1]="0";
									}
									
								}
								if(pageType.equalsIgnoreCase("EAN9"))
								{
									if(ArrprintCheck.contains(sno))
									{
									if (valarray[2].equals("0")) {
										valarray[2] = Helper.correctDouble(rs3
											.getString("fin_estimated"));
									}
									if (valarray[3].equals("0")) {
									valarray[3] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									if (valarray[4].equals("0")) {
									valarray[4] = Helper.correctDouble(rs3
											.getString("fin_projection"));
									}
									valarray[0]="0";
									valarray[1]="0";
									}else{
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
										valarray[0]="0";
										valarray[1]="0";
									}
								}
								if(pageType.equalsIgnoreCase("EAN4"))
								{
									if(ArrprintCheck.contains(sno))
									{
										if (valarray[0].equals("0")) {
											valarray[0] = Helper.correctDouble(rs3
													.getString("fin_audit"));
										}
										if (valarray[1].equals("0")) {
											valarray[1] = Helper.correctDouble(rs3
													.getString("fin_unaudit"));
										}
										valarray[2]="0";
										valarray[3]="0";
										valarray[4]="0";
									}else{
										valarray[4]="0";
										valarray[2]="0";
										valarray[3]="0";
										valarray[0]="0";
										valarray[1]="0";
									}
								}
							if (!valarray[0].equals("0")) {
								valarray[0] = "fin_audit";
							}

							if (!valarray[1].equals("0")) {
								valarray[1] = "fin_unaudit";
							}

							if (!valarray[2].equals("0")) {
								valarray[2] = "fin_estimated";
							}

							if (!valarray[3].equals("0")) {
								valarray[3] = "fin_projection";
							}
							if (!valarray[4].equals("0")) {
								valarray[4] = "fin_projection";
							}
						}
						if (rs3 != null) {
							rs3.close();
						}

						// to find the values for each label with respect to
						// value(a,una,p,e),year and id

						for (int h = 0; h <= 3; h++) {
							vecVal = new ArrayList();
							vecid = new ArrayList();

							if (valarray[h].equals("")) {
								valarray[h] = "0";
							}
							if (!valarray[h].equals("0")) {
								i = i + 1;
								seloption = valarray[h];
								boolean max;
								if (pagename.equalsIgnoreCase("FI") || pageType.equalsIgnoreCase("AN4")||pageType.equalsIgnoreCase("AN9")||pageType.equalsIgnoreCase("EAN9")||pageType.equalsIgnoreCase("MCFD")||((strPage.equalsIgnoreCase("M1")||strPage.equalsIgnoreCase("M2")||strPage.equalsIgnoreCase("AFL"))&&strPrintYear.equalsIgnoreCase("Y"))||(Helper.correctNull((String)hshRequestValues.get("hidPageId")).equals("comwrflw"))) {
									max = true;
								} else {
									if(k>=5)
										max=false;
									else
										max=true;
									
									//max = (k < maxYear);
								}
								if ((i >= from) && max) {
									p = i;
									k = k + 1;
									strQuery = SQLParser
											.getSqlQuery("finratio1new^" + page
													+ "^" + cma + "^" + strPage);

									rs1 = DBUtils.executeQuery(strQuery);
									while (rs1.next()) {
										if (seloption.equals("fin_audit")) {
											desc = "a";
										} else if (seloption.equals("fin_unaudit")) {
											desc = "u";
										} else if (seloption
												.equals("fin_estimated")) {
											desc = "e";
										} else if (seloption
												.equals("fin_projection")) {
											desc = "p";
										}

										double dblBankBorr = 0.00;
										if (rs4 != null)
											rs4.close();

										if (cma.equalsIgnoreCase("5"))
											strQuery = SQLParser
													.getSqlQuery("selcomfinvalues^"
															+ strFinID + "^461"
															+ "^" + yearselect);
										else
											strQuery = SQLParser
													.getSqlQuery("selcomfinvalues^"
															+ strFinID + "^1005^"
															+ yearselect);

										rs4 = DBUtils.executeQuery(strQuery);
										if (rs4.next()) {
											dblBankBorr = Double
													.parseDouble((Helper
															.correctDouble((String) rs4
																	.getString("finvalue"))));
										}

										int formuladesc = 0;
										formuladesc = (rs1.getInt("fin_formula"));

										if (formuladesc > 0) {

											strQuery = SQLParser
													.getSqlQuery("selfinformula^"
															+ formuladesc);

											rsFormulaFor = DBUtils
													.executeQuery(strQuery);
											String strFormulaFor = "";
											if (rsFormulaFor.next()) {
												strFormulaFor = correctNull((String) rsFormulaFor
														.getString("formula_for"));
											}

											String strPreYear = "", strPreYearDesc = "";
											if (rsFormulaFor != null) {
												rsFormulaFor.close();
											}
											if ((strFormulaFor.trim()
													.equalsIgnoreCase("CA"))
													|| (strFormulaFor.trim()
															.equalsIgnoreCase("ST"))) {
												strQuery = SQLParser
														.getSqlQuery("selpreyrs^"
																+ strFinID + "^<^"
																+ yearselect);

												rsPrevYear = DBUtils
														.executeQuery(strQuery);
												if (rsPrevYear.next()) {
													double audit = rsPrevYear
															.getDouble("audit");
													double unaudit = rsPrevYear
															.getDouble("unaudit");
													double estimated = rsPrevYear
															.getDouble("estimated");
													double projection = rsPrevYear
															.getDouble("projection");
													if (audit != 0) {
														strPreYearDesc = "A";
													} else if (unaudit != 0) {
														strPreYearDesc = "U";
													} else if (estimated != 0) {
														strPreYearDesc = "E";
													} else if (projection != 0) {
														strPreYearDesc = "P";
													}
													strPreYear = rsPrevYear
															.getString("prevyear");
												}
												if (rsPrevYear != null) {
													rsPrevYear.close();
												}

												if (!strPreYear.trim().equals("")) {
													HashMap hshformula = new HashMap();
													hshformula.put("appno",
															strValue);
													hshformula.put("strFinID",
															strFinID);
													hshformula
															.put(
																	"formulaid",
																	Integer
																			.toString(formuladesc));
													hshformula.put("curryear",
															yearselect);
													hshformula.put("prevyear",
															strPreYear);
													hshformula.put(
															"currfinancialtype",
															desc);
													hshformula.put(
															"prevfinancialtype",
															strPreYearDesc);
													hshformula.put("internalcalc",
															"N");
													hshformula.put("sno", sno);
													if (strFormulaFor.trim()
															.equalsIgnoreCase("ST")) {
														hshformula.put("isstress",
																"Y");
														hshformula.put(
																"ratiostress", "Y");
													}
													hshformula.put("hshdata",
															new HashMap());
													hshformula.put("hshFinYearVal",
															hshFinYearVal);

													HashMap hshRes = (HashMap) EJBInvoker
															.executeStateLess(
																	"comformula",
																	hshformula,
																	"GetFinValue");

													vecVal
															.add(correctNull((String) hshRes
																	.get("strTotalValue")));
												} else {
													vecVal.add("-");

												}

											} else {
												HashMap hshformula = new HashMap();
												hshformula.put("appno", strValue);
												hshformula
														.put("strFinID", strFinID);
												hshformula.put("formulaid", Integer
														.toString(formuladesc));
												hshformula.put("curryear",
														yearselect);
												hshformula.put("prevyear",
														strPreYear);
												hshformula.put("currfinancialtype",
														desc);
												hshformula.put("prevfinancialtype",
														strPreYearDesc);
												hshformula.put("internalcalc", "N");
												hshformula.put("sno", sno);
												hshformula.put("hshdata",
														new HashMap());
												hshformula.put("hshFinYearVal",
														hshFinYearVal);
												HashMap hshRes = (HashMap) EJBInvoker
														.executeStateLess(
																"comformula",
																hshformula,
																"GetFinValue");
												vecVal
														.add(correctNull((String) hshRes
																.get("strTotalValue")));

											}
											vecid.add(correctNull(rs1
													.getString("fin_rowid")));
										} else {
											String finrowid = correctNull(rs1
													.getString("fin_rowid"));
											if ((cma.equalsIgnoreCase("5") && (finrowid
													.equalsIgnoreCase("1237")
													|| finrowid
															.equalsIgnoreCase("1226") || finrowid
													.equalsIgnoreCase("1230")))
													|| (cma.equalsIgnoreCase("9") && (finrowid
															.equalsIgnoreCase("1220")
															|| finrowid
																	.equalsIgnoreCase("1242") || finrowid
															.equalsIgnoreCase("1224")))||(cma.equalsIgnoreCase("1") && (finrowid
													.equalsIgnoreCase("1271")
													|| finrowid
															.equalsIgnoreCase("1301") || finrowid
													.equalsIgnoreCase("1306")))) {
												if (vecVal.size() >= 2) {
													double WCG = Double
															.parseDouble((Helper
																	.correctDouble((String) vecVal
																			.get(0))));
													double MWCG = Double
															.parseDouble((Helper
																	.correctDouble((String) vecVal
																			.get(1))));
													double NWC = Double
															.parseDouble((Helper
																	.correctDouble((String) vecVal
																			.get(2))));
													double diffMWCG = 0.00, diffNWC = 0.00;
													diffMWCG = WCG - MWCG;
													diffNWC = WCG - NWC;
													if (diffMWCG < diffNWC) {
														vecVal.add(nf
																.format(diffMWCG));
													} else {
														vecVal.add(nf
																.format(diffNWC));
													}
												} else {
													vecVal.add("0.00");
												}
											} else if ((cma.equalsIgnoreCase("5") && (finrowid
													.equalsIgnoreCase("1227")
													|| finrowid
															.equalsIgnoreCase("1238") || finrowid
													.equalsIgnoreCase("1231")))
													|| (cma.equalsIgnoreCase("9") && (finrowid
															.equalsIgnoreCase("1221")
															|| finrowid
																	.equalsIgnoreCase("1243") || finrowid
															.equalsIgnoreCase("1225")))||(cma.equalsIgnoreCase("1") && (finrowid
																	.equalsIgnoreCase("1302")
																	|| finrowid
																			.equalsIgnoreCase("1272") || finrowid
																	.equalsIgnoreCase("1307")))) {
												if (vecVal.size() >= 3) {
													double dblMPBF = Double
															.parseDouble((Helper
																	.correctDouble((String) vecVal
																			.get(3))));
													double diffMPBF = 0.00;
													diffMPBF = dblBankBorr
															- dblMPBF;
													if (diffMPBF > 0) {
														vecVal.add(nf
																.format(diffMPBF));
													} else {
														vecVal.add("0.00");
													}
												} else {
													vecVal.add("0.00");
												}
											} else {
												vecVal.add("0.00");
											}
											vecid.add(correctNull(rs1
													.getString("fin_rowid")));
										}
										hshValues.put("year" + k, vecVal);
										hshValues.put("vecid" + k, vecid);

									}

									if (rs1 != null) {
										rs1.close();
									}
									vecrec.add(yearselect);
									vecrec.add(seloption);
									vecrecStrt.add(yearselect_strt);
									hshValues.put("FPSno" + (o++), sno);
								}

							}
						}

					}
					
					yearint = yearint + 1;
					tempyear = sno;
				}
	
			}
						
			/*if()
			else
			{
				
			}*/
			
			
			hshValues.put("strPage", strPage);
			hshValues.put("from", Integer.toString(from));
			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("yearvalueStrt", vecrecStrt);
			hshValues.put("page", page);
			hshValues.put("cma_no", cma);
			hshValues.put("appno", strValue);
			hshValues.put("strFinID", strFinID);
			hshValues.put("appname", strAppName);
			
			//To retrieve the tab details
			vecVal = new ArrayList();
			strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+ strFinID);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				cma = Helper.correctNull((String) rs.getString("fin_cmano"));
			}
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);
			}
			
			if (rs != null) {
				rs.close();
			}
			if(!strValue.equalsIgnoreCase("")){
			String digiflag="";
				strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strValue);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
		        }
				hshValues.put("digiflag", digiflag);
			}
			hshValues.put("tabdetails", vecVal);
			hshValues.put("finace_id", strFinID);
			hshValues.put("appidnew", appidnew);
			hshValues.put("fintype", cma);
			hshValues.put("hidapplicantid", Helper.correctInt((String) hshRequestValues.get("hidAppId")));
			hshValues.put("AssetandLiab", Helper.correctNull((String) hshRequestValues.get("AssetandLiab")));
			hshValues.put("sessionModuleType", Helper.correctNull((String) hshRequestValues.get("sessionModuleType")));
			hshValues.put("cattype", Helper.correctNull((String) hshRequestValues.get("cattype")));

	 		HashMap hshQueryValues= new HashMap();
	 		HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			//Ratios table entry
			if(Helper.correctNull((String)hshRequestValues.get("hidPageId")).equals("comwrflw") || ratioflag==false)
			{	
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_rationsTableEntry");
				arrValues.add(strValue);
				arrValues.add(strPage);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

				int sizeyear=0,to=0,vecModSize=0,n=0;
				String temp="",totcount="",upto="",pageval="",strCurModule="";
				
				ArrayList  g21=(ArrayList) hshValues.get("yearvalue");
				String yearval[] = null;
				String comboselect[] = null;
				
				 if (g21.size() != 0)
				 {
						 sizeyear=g21.size();
						 yearval=new String[(g21.size()/2)];
						 comboselect=new String[(g21.size()/2)];
					for (int k1=0;k1<=g21.size()-1;k1++)
					{
							if ((k1 % 2 ) == 0)
							{
								temp=Helper.correctNull((String)g21.get(k1));
								yearval[y]=temp;
								y =y+1;
							}
							else if ((k1 % 2) == 1)
							{
								temp=Helper.correctNull((String)g21.get(k1));
									if (temp.trim().equalsIgnoreCase("fin_audit"))
									{
										temp = "a";
									}
									else if (temp .trim().equalsIgnoreCase("fin_unaudit"))
									{
										temp = "u";
									}
									else if (temp.trim().equalsIgnoreCase("fin_estimated"))
									{
										temp = "e";
									}
									else if (temp.trim().equalsIgnoreCase("fin_projection"))
									{
									temp = "p";
									}
								comboselect[n]=temp;
								n = n+1;
							}	 		
						}
//						for (int d = 0 ; d <= 4 ; d++)
//						 {
//							if (comboselect[d] == null)
//							 {
//								comboselect[d] = " ";
//							 }
//							if (yearval[d] == null)
//							 {
//								yearval[d]="";			
//							 }			 
//						 }		 
					 }
					 else
					 {		
//						 for ( p=0;p<=4;p++)
//						 {
//							comboselect[p]= " ";		
//							yearval[p]= "";
//						 }
					 }
			 		int totalyear=Integer.valueOf(Helper.correctInt((String)hshValues.get("totalyear")));
			 		String yeardata="";
			 		String fintype="";
			 		ArrayList v1=(ArrayList) hshValues.get("vecid1");
			 		ArrayList vecData=new ArrayList();
			 		String test="0.00";
			 		for(int m=0;m<totalyear;m++)
			 		{
			 			yeardata=yearval[m];
			 			fintype=comboselect[m];
			 			
			 			if (rs != null) 
							rs.close();
			 			strQuery = SQLParser.getSqlQuery("sel_comratiosel_year^" +strValue+"^"+yeardata+"^"+strPage);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							vecData=(ArrayList) hshValues.get("year"+(m+1));
				 			hshQueryValues= new HashMap();
				 			int intUpdatesize=0;
				 			for(int s=0;s<v1.size();s++)
				 			{
				 				hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize = intUpdatesize+1;
								arrValues.add(Helper.correctDouble((String)vecData.get(s)));
								arrValues.add(yeardata);
								arrValues.add(strValue);
								arrValues.add(Helper.correctInt((String)v1.get(s)));
								arrValues.add(strPage);
								if(fintype.equals("a"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up1");
								}
								else if(fintype.equals("u"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up2");
								}
								else if(fintype.equals("e"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up3");
								}
								else if(fintype.equals("p"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up4");
								}
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
								hshQueryValues.put("size",String.valueOf(intUpdatesize));
				 			}
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
 							
						}
						else
						{
							vecData=(ArrayList) hshValues.get("year"+(m+1));
				 			hshQueryValues= new HashMap();
				 			int intUpdatesize=0;
				 			for(int s=0;s<v1.size();s++)
				 			{
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize = intUpdatesize+1;
								arrValues.add(strValue);
								arrValues.add(yeardata);
								arrValues.add(Helper.correctInt((String)v1.get(s)));
								if(fintype.equals("a"))
								{
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
								else if(fintype.equals("u"))
								{
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
									arrValues.add(test);
								}
								else if(fintype.equals("e"))
								{
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
								}
								else if(fintype.equals("p"))
								{
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
								}
								arrValues.add(String.valueOf(m+1));
								arrValues.add(strPage);
								hshQuery.put("strQueryId","ins_ratiosTableEntry");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
								hshQueryValues.put("size",String.valueOf(intUpdatesize));
				 			}
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
			 			
			 		} 
			}
			
		/*	// Added by Kishan
			strQuery = SQLParser
					.getSqlQuery("com_selfin_printyear^" + strFinID);
			rs = DBUtils.executeQuery(strQuery);
			String printCheck = "";
			while (rs.next()) {
				printCheck = printCheck
						+ Helper.correctNull((String) rs
								.getString("finprintyear_labelname")) + "-";
			}
			hshValues.put("printCheck", printCheck);*/
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rsFormulaFor != null)
					rsFormulaFor.close();
				if (rsPrevYear != null)
					rsPrevYear.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;

	}
	


	public HashMap getDataAssessment(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rsPrevYear = null;
		ResultSet rsFormulaFor = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "", strAppName = "", strPage = "";
		String page = "";
		int maxYear = 5;
		int str = 0;
		try {
			String strPrintYear=correctNull((String)hshRequestValues.get("printYear"));
			strValue = correctNull((String) hshRequestValues.get("appno"));
			String strFinID = correctNull((String) hshRequestValues
					.get("strFinID"));
			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();

			page = correctNull((String) hshRequestValues.get("page"));
			if (page.equalsIgnoreCase("")) {
				page = "RA";
			}
			strPage = correctNull((String) hshRequestValues.get("pagefrom")); // Ratio
																				// Type
																				// RA1,RA2,RA3
			if (strPage.equalsIgnoreCase("")) {
				strPage = correctNull((String) hshRequestValues
						.get("pagefrom1")); // Assessment type - Export limits
			}
			if (strPage.equals("")) {
				strPage = "RA1";
			}// defaulty RA1 must be loaded
			String pagename = correctNull((String) hshRequestValues
					.get("pagename"));

			// -----------to get the borrower name-------------
			strQuery = SQLParser.getSqlQuery("com_lapsidsearch2^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				strAppName = correctNull((String) rs
						.getString("comapp_companyname"));
			}
			if (rs != null) {
				rs.close();
			}

			// -------------- to find the time of review-----------------

			strQuery = SQLParser.getSqlQuery("finselect1^" + strFinID + "^0");
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				str = rs.getInt("cnt");
			}
			if (rs != null) {
				rs.close();
			}

			// --------------- to find the cma format of the particular
			// applications-------

			String cma = "0";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
				strValue = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
				if (!strFinID.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ strFinID);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						cma = Helper.correctInt((String) rs
								.getString("FIN_CMANO"));
					}
				}
			}
			hshValues.put("cma", cma);
			if (rs != null) {
				rs.close();
			}

			// -----------------to find the tab----------------------

			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application

			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2anew^" + cma + "^"
						+ page + "^" + strPage);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);

				}

				hshValues.put("labeldetails", vecVal);

			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				// strQuery =
				// SQLParser.getSqlQuery("finselect3a^"+strValue+"^"+cma+"^"+page);
				strQuery = SQLParser.getSqlQuery("finselect3anew^" + cma + "^"
						+ page + "^" + strPage);

				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);
				}

				hshValues.put("labeldetails", vecVal);

			}

			if (rs != null) {
				rs.close();
			}
			hshValues.put("count", Integer.toString(str));

			String yearselect = "", seloption = "", givenyear = "", yearvalue = "", tempyear = "";
			int i = 0, k = 0;
			int from = 0, p = 0;
			int yearint = 0;
			ArrayList vecrec = new ArrayList();

			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[5];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";
			String sno = "";
			
			String strBuffer="";
			String strBuff="";
			strBuff=strPage;
			if(strPage.equalsIgnoreCase("I1"))
				strBuff=pagename;
			if(strPage.equalsIgnoreCase("RA1")||strPage.equalsIgnoreCase("RA2"))
				strBuffer="  and finprintyear_pageid in ('ASSETS','LIABILITIES','PROFIT AND LOSS ACCOUNT')";
			else
				strBuffer=" and finprintyear_pageid='"+strBuff+"'";
			
			if(!strPrintYear.equalsIgnoreCase("Y"))
				strQuery = SQLParser.getSqlQuery("finselect4a^" + strFinID);
			else
				strQuery = SQLParser.getSqlQuery("finselectratio_printyear^" + strFinID+"^" + strFinID+"^"+strBuffer);	
			
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";

				vecVal = new ArrayList();
				String str1 = "", str2 = "", str3 = "", str0 = "";
				String desc = "", formula_desc = "";
				sno = (String) Helper.correctNull(rs.getString("fin_sno"));
				// strPage=
				// (String)Helper.correctNull(rs.getString("hidFinPage"));
				// To Find the years assigned for each application

				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				yearvalue = (String) Helper.correctNull(rs
						.getString("yearvalue"));
				if (!sno.equals(tempyear)) {

					// to check for the occurance of audited,.,.,. for a
					// paricular year

					/*
					 * strQuery =
					 * SQLParser.getSqlQuery("finselect7a^"+yearselect
					 * +"^"+strValue+"^"+sno);
					 * 
					 * rs3 = DBUtils.executeQuery(strQuery);
					 * 
					 * while(rs3.next()) { if(valarray[0].equals("0")) {
					 * valarray
					 * [0]=Helper.correctDouble(rs3.getString("fin_audit")); }
					 * if(valarray[1].equals("0")) {
					 * valarray[1]=Helper.correctDouble
					 * (rs3.getString("fin_unaudit")); }
					 * if(valarray[2].equals("0")) {
					 * valarray[2]=Helper.correctDouble
					 * (rs3.getString("fin_estimated")); }
					 * if(valarray[3].equals("0")) {
					 * valarray[3]=Helper.correctDouble
					 * (rs3.getString("fin_projection")); }
					 * if(valarray[4].equals("0")) {
					 * valarray[4]=Helper.correctDouble
					 * (rs3.getString("fin_projection")); }
					 * 
					 * if (!valarray[0].equals("0")) { valarray[0]= "fin_audit";
					 * }
					 * 
					 * if (!valarray[1].equals("0")) { valarray[1] =
					 * "fin_unaudit"; }
					 * 
					 * if (!valarray[2].equals("0")) { valarray[2] =
					 * "fin_estimated"; }
					 * 
					 * if (!valarray[3].equals("0")) { valarray[3] =
					 * "fin_projection"; } if (!valarray[4].equals("0")) {
					 * valarray[4] = "fin_projection"; } }
					 */
					strQuery = SQLParser.getSqlQuery("finselect7a^"
							+ yearselect + "^" + strFinID + "^" + sno + "^"
							+ strPage);

					rs3 = DBUtils.executeQuery(strQuery);

					while (rs3.next()) {
						if (valarray[0].equals("0")) {
							valarray[0] = Helper.correctDouble(rs3
									.getString("fin_audit"));
						}
						if (valarray[1].equals("0")) {
							valarray[1] = Helper.correctDouble(rs3
									.getString("fin_unaudit"));
						}
						if (valarray[2].equals("0")) {
							valarray[2] = Helper.correctDouble(rs3
									.getString("fin_estimated"));
						}
						if (valarray[3].equals("0")) {
							valarray[3] = Helper.correctDouble(rs3
									.getString("fin_projection"));
						}
						if (valarray[4].equals("0")) {
							valarray[4] = Helper.correctDouble(rs3
									.getString("fin_projection"));
						}

						if (!valarray[0].equals("0")) {
							valarray[0] = "fin_audit";
						}

						if (!valarray[1].equals("0")) {
							valarray[1] = "fin_unaudit";
						}

						if (!valarray[2].equals("0")) {
							valarray[2] = "fin_estimated";
						}

						if (!valarray[3].equals("0")) {
							valarray[3] = "fin_projection";
						}
						if (!valarray[4].equals("0")) {
							valarray[4] = "fin_projection";
						}
					}
					if (rs3 != null) {
						rs3.close();
					}

					// to find the values for each label with respect to
					// value(a,una,p,e),year and id

					for (int h = 0; h <= 3; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							boolean max;
							if (pagename.equalsIgnoreCase("FI")||((pagename.equalsIgnoreCase("M1")||pagename.equalsIgnoreCase("M2")||pagename.equalsIgnoreCase("AFL"))&& strPrintYear.equalsIgnoreCase("Y"))) {
								max = true;
							} else {
								if(k>=5)
									max=false;
								else
									max=true;
							}
							if ((i >= from) && max) {
								p = i;
								k = k + 1;

								strQuery = SQLParser
										.getSqlQuery("finratio1new^" + page
												+ "^" + cma + "^" + strPage);

								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {
									if (seloption.equals("fin_audit")) {
										desc = "a";
									} else if (seloption.equals("fin_unaudit")) {
										desc = "u";
									} else if (seloption
											.equals("fin_estimated")) {
										desc = "e";
									} else if (seloption
											.equals("fin_projection")) {
										desc = "p";
									}
									int formuladesc = 0;
									formuladesc = (rs1.getInt("fin_formula"));

									if (formuladesc > 0) {

										strQuery = SQLParser
												.getSqlQuery("selfinformula^"
														+ formuladesc);

										rsFormulaFor = DBUtils
												.executeQuery(strQuery);
										String strFormulaFor = "";
										if (rsFormulaFor.next()) {
											strFormulaFor = correctNull((String) rsFormulaFor
													.getString("formula_for"));
										}

										String strPreYear = "", strPreYearDesc = "";
										if (rsFormulaFor != null) {
											rsFormulaFor.close();
										}
										if ((strFormulaFor.trim()
												.equalsIgnoreCase("CA"))
												|| (strFormulaFor.trim()
														.equalsIgnoreCase("ST"))) {
											strQuery = SQLParser
													.getSqlQuery("selpreyrs^"
															+ strFinID + "^<^"
															+ yearselect);

											rsPrevYear = DBUtils
													.executeQuery(strQuery);
											if (rsPrevYear.next()) {
												double audit = rsPrevYear
														.getDouble("audit");
												double unaudit = rsPrevYear
														.getDouble("unaudit");
												double estimated = rsPrevYear
														.getDouble("estimated");
												double projection = rsPrevYear
														.getDouble("projection");
												if (audit != 0) {
													strPreYearDesc = "A";
												} else if (unaudit != 0) {
													strPreYearDesc = "U";
												} else if (estimated != 0) {
													strPreYearDesc = "E";
												} else if (projection != 0) {
													strPreYearDesc = "P";
												}
												strPreYear = rsPrevYear
														.getString("prevyear");
											}
											if (rsPrevYear != null) {
												rsPrevYear.close();
											}

											if (!strPreYear.trim().equals("")) {
												HashMap hshformula = new HashMap();
												hshformula.put("appno",
														strValue);
												hshformula.put("strFinID",
														strFinID);
												hshformula
														.put(
																"formulaid",
																Integer
																		.toString(formuladesc));
												hshformula.put("curryear",
														yearselect);
												hshformula.put("prevyear",
														strPreYear);
												hshformula.put(
														"currfinancialtype",
														desc);
												hshformula.put(
														"prevfinancialtype",
														strPreYearDesc);
												hshformula.put("internalcalc",
														"N");
												hshformula.put("sno", sno);
												if (strFormulaFor.trim()
														.equalsIgnoreCase("ST")) {
													hshformula.put("isstress",
															"Y");
													hshformula.put(
															"ratiostress", "Y");
												}
												hshformula.put("hshdata",
														new HashMap());
												HashMap hshRes = (HashMap) EJBInvoker
														.executeStateLess(
																"comformula",
																hshformula,
																"GetFinValue");

												vecVal
														.add(correctNull((String) hshRes
																.get("strTotalValue")));
											} else {
												vecVal.add("-");

											}

										} else {
											HashMap hshformula = new HashMap();
											hshformula.put("appno", strValue);
											hshformula
													.put("strFinID", strFinID);
											hshformula.put("formulaid", Integer
													.toString(formuladesc));
											hshformula.put("curryear",
													yearselect);
											hshformula.put("prevyear",
													strPreYear);
											hshformula.put("currfinancialtype",
													desc);
											hshformula.put("prevfinancialtype",
													strPreYearDesc);
											hshformula.put("internalcalc", "N");
											hshformula.put("sno", sno);
											hshformula.put("hshdata",
													new HashMap());
											HashMap hshRes = (HashMap) EJBInvoker
													.executeStateLess(
															"comformula",
															hshformula,
															"GetFinValue");
											vecVal
													.add(correctNull((String) hshRes
															.get("strTotalValue")));

										}
										vecid.add(correctNull(rs1
												.getString("fin_rowid")));
									} else {
										vecVal.add("0.00");
										vecid.add(correctNull(rs1
												.getString("fin_rowid")));
									}
									hshValues.put("year" + k, vecVal);
									hshValues.put("vecid" + k, vecid);

								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
							}

						}
					}

				}
				yearint = yearint + 1;
				tempyear = sno;

			}
			strQuery = SQLParser.getSqlQuery("com_selfinratio_printyear^"
					+ strFinID + "^M1");
			rs = DBUtils.executeQuery(strQuery);
			String printRatioCheck = "";
			while (rs.next()) {
				printRatioCheck = printRatioCheck
						+ Helper.correctNull((String) rs
								.getString("finprintyear_selsno")) + "-";
			}
			hshValues.put("printRatioCheckM1", printRatioCheck);
			printRatioCheck = "";
			strQuery = SQLParser.getSqlQuery("com_selfinratio_printyear^"
					+ strFinID + "^M2");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				printRatioCheck = printRatioCheck
						+ Helper.correctNull((String) rs
								.getString("finprintyear_selsno")) + "-";
			}
			hshValues.put("printRatioCheckM2", printRatioCheck);
			printRatioCheck = "";
			strQuery = SQLParser.getSqlQuery("com_selfinratio_printyear^"
					+ strFinID + "^AFL");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				printRatioCheck = printRatioCheck
						+ Helper.correctNull((String) rs
								.getString("finprintyear_selsno")) + "-";
			}
			hshValues.put("printRatioCheckAFL", printRatioCheck);
			hshValues.put("strpage", strPage);
			hshValues.put("from", Integer.toString(from));
			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("page", page);
			hshValues.put("cma_no", cma);
			hshValues.put("appno", strValue);
			hshValues.put("strFinID", strFinID);
			hshValues.put("appname", strAppName);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rsFormulaFor != null)
					rsFormulaFor.close();
				if (rsPrevYear != null)
					rsPrevYear.close();
				if (rs3 != null)
					rs3.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;
	}

	public HashMap getRatioList(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";

		try {

			strValue = correctNull((String) hshRequestValues.get("appno"));
			String yearvalue[] = new String[5];
			String comboselect[] = new String[5];
			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			ArrayList vecid = new ArrayList();
			// to find the cma format of the particular applications

			String cma = "";
			// strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				// cma=rs.getString("cma_no");
				cma = correctNull(rs.getString("demo_finstandard"));
			}
			if (rs != null) {
				rs.close();
			}
			String page = correctNull((String) hshRequestValues.get("pageval"));

			if (page.equals("")) {
				page = "RA";
			}

			vecVal = new ArrayList();
			strQuery = SQLParser.getSqlQuery("finselect3a^" + cma + "^" + page);
			rs = DBUtils.executeQuery(strQuery);
			String temp = "";
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("myrowid")));

				temp = Helper.correctNull(rs.getString("desc1"));
				if (temp.equals("")) {
					vecRec.add(correctNull(rs.getString("desc2")));
				} else {
					vecRec.add(correctNull(rs.getString("desc1")));
				}

				vecRec.add(correctNull(rs.getString("fin_rowtype")));
				vecRec.add(correctNull(rs.getString("fin_sno")));

				vecVal.add(vecRec);
			}
			if (rs != null) {
				rs.close();
			}

			hshValues.put("labeldetails", vecVal);
			vecVal = new ArrayList();
			String desc = "";
			int k = 0;

			yearvalue[0] = correctNull((String) hshRequestValues
					.get("txtyear1"));
			comboselect[0] = correctNull((String) hshRequestValues
					.get("combo1"));
			yearvalue[1] = correctNull((String) hshRequestValues
					.get("txtyear2"));
			comboselect[1] = correctNull((String) hshRequestValues
					.get("combo2"));
			yearvalue[2] = correctNull((String) hshRequestValues
					.get("txtyear3"));
			comboselect[2] = correctNull((String) hshRequestValues
					.get("combo3"));
			yearvalue[3] = correctNull((String) hshRequestValues
					.get("txtyear4"));
			comboselect[3] = correctNull((String) hshRequestValues
					.get("combo4"));
			yearvalue[4] = correctNull((String) hshRequestValues
					.get("txtyear5"));
			comboselect[4] = correctNull((String) hshRequestValues
					.get("combo5"));

			for (int i = 0; i <= 4; i++) {
				vecVal = new ArrayList();
				vecid = new ArrayList();
				if (comboselect[i].equals("a")) {
					comboselect[i] = "fin_audit";
					desc = "a";
				} else if (comboselect[i].equals("u")) {
					comboselect[i] = "fin_unaudit";
					desc = "u";
				} else if (comboselect[i].equals("e")) {
					comboselect[i] = "fin_estimated";
					desc = "e";
				} else if (comboselect[i].equals("p")) {
					comboselect[i] = "fin_projection";
					desc = "p";
				} else if (comboselect[i].equals("p")) {
					comboselect[i] = "fin_projection";
					desc = "p";
				}

				if (!yearvalue[i].equals("") && !comboselect[i].equals("S")) {
					k = k + 1;
					strQuery = SQLParser.getSqlQuery("finratio1^" + page + "^"
							+ cma);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						int formuladesc = 0;
						formuladesc = (rs1.getInt("fin_formula"));

						if (formuladesc > 0) {
							HashMap hshformula = new HashMap();
							hshformula.put("appno", strValue);
							hshformula.put("formulaid", Integer
									.toString(formuladesc));
							hshformula.put("curryear", yearvalue[i]);
							hshformula.put("prevyear", " ");
							hshformula.put("currfinancialtype", desc);
							hshformula.put("prevfinancialtype", "a");
							hshformula.put("internalcalc", "N");
							hshformula.put("hshdata", new HashMap());

							HashMap hshRes = (HashMap) EJBInvoker
									.executeStateLess("comformula", hshformula,
											"GetFinValue");

							vecVal.add(correctNull((String) hshRes
									.get("strTotalValue")));
							vecid.add(correctNull(rs1
									.getString("fin_rowid")));

						} else {
							vecVal.add("0.00");
							vecid.add(correctNull(rs1
									.getString("fin_rowid")));
						}
						hshValues.put("year" + k, vecVal);
						hshValues.put("vecid" + k, vecid);
					}
					vecrec.add(yearvalue[i]);
					vecrec.add(comboselect[i]);
				}

			}
			hshValues.put("from", correctNull((String) hshRequestValues
					.get("fromvalue")));
			hshValues.put("totalyear", correctNull((String) hshRequestValues
					.get("totvalue")));
			hshValues.put("upto", correctNull((String) hshRequestValues
					.get("uptovalue")));
			hshValues.put("yearvalue", vecrec);
			hshValues.put("page", page);
			hshValues.put("identity", "list");

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;

	}

	public void updateData(HashMap hsh)  {

		ResultSet rs = null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String year1 = "", year2 = "", year3 = "", year4 = "", year5 = "";
		String year1Strt = "", year2Strt = "", year3Strt = "", year4Strt = "", year5Strt = "";
		String c1year = "", c2year = "", c3year = "", c4year = "", c5year = "", strDivid = "";
		String strRowCol1 = "", strRowCol2 = "", strRowCol3 = "", strRowCol4 = "", strRowCol5 = "";
		int intUpdatesize = 0, intValue = 0;
		String test = Integer.toString(intValue);
		String[] id = null;
		String appno = "";
		String[] strType = null;
		String appid = "";
		String apppage = "";
		String strExp = "$";
		String strValuesin = "";

		try {
			// appno=(String)hsh.get("appno");
			appno = correctNull((String) hsh.get("hidfinanceid"));

			appid = correctNull((String) hsh.get("hid_appid"));

			apppage = correctNull((String) hsh.get("hidapppage"));
			strValuesin = correctNull((String) hsh.get("sel_proposalvaluesin"));
			
			hsh.get("id");
			id = (String[]) hsh.get("id");
			int idlen = id.length;
			strType = (String[]) hsh.get("type");
			strDivid = Helper.correctInt((String) hsh.get("sel_divID"));
			year1 = correctNull((String) hsh.get("txtyear1"));
			year2 = correctNull((String) hsh.get("txtyear2"));
			year3 = correctNull((String) hsh.get("txtyear3"));
			year4 = correctNull((String) hsh.get("txtyear4"));
			year5 = correctNull((String) hsh.get("txtyear5"));
			
			year1Strt = correctNull((String) hsh.get("txtyear1_start"));
			year2Strt = correctNull((String) hsh.get("txtyear2_start"));
			year3Strt = correctNull((String) hsh.get("txtyear3_start"));
			year4Strt = correctNull((String) hsh.get("txtyear4_start"));
			year5Strt = correctNull((String) hsh.get("txtyear5_start"));

			c1year = correctNull((String) hsh.get("combo1"));
			c2year = correctNull((String) hsh.get("combo2"));
			c3year = correctNull((String) hsh.get("combo3"));
			c4year = correctNull((String) hsh.get("combo4"));
			c5year = correctNull((String) hsh.get("combo5"));
			int x = 0;
			String strsno1 = Helper.correctNull((String) hsh.get("strsno1"));
			String strsno2 = Helper.correctNull((String) hsh.get("strsno2"));
			String strsno3 = Helper.correctNull((String) hsh.get("strsno3"));
			String strsno4 = Helper.correctNull((String) hsh.get("strsno4"));
			String strsno5 = Helper.correctNull((String) hsh.get("strsno5"));
			String print_selyear1 = "", print_selyear2 = "", print_selyear3 = "", print_selyear4 = "", print_selyear5 = "";
			print_selyear1 = correctNull((String) hsh.get("printchk1"));
			print_selyear2 = correctNull((String) hsh.get("printchk2"));
			print_selyear3 = correctNull((String) hsh.get("printchk3"));
			print_selyear4 = correctNull((String) hsh.get("printchk4"));
			print_selyear5 = correctNull((String) hsh.get("printchk5"));
			String rate_selyear1 = "", rate_selyear2 = "", rate_selyear3 = "", rate_selyear4 = "", rate_selyear5 = "";
			rate_selyear1 = correctNull((String) hsh.get("ratingchk1"));
			rate_selyear2 = correctNull((String) hsh.get("ratingchk2"));
			rate_selyear3 = correctNull((String) hsh.get("ratingchk3"));
			rate_selyear4 = correctNull((String) hsh.get("ratingchk4"));
			rate_selyear5 = correctNull((String) hsh.get("ratingchk5"));
			String printsel_year1 = "", printsel_year2 = "", printsel_year3 = "", printsel_year4 = "", printsel_year5 = "";
			String ratesel_year1 = "", ratesel_year2 = "", ratesel_year3 = "", ratesel_year4 = "", ratesel_year5 = "";

			String fromid = Helper.correctNull((String) hsh.get("pageval"));

			if (fromid.equals("-1")) {
				fromid = "1";
			}

			/*
			 * to delete the financial Year concept and to save finacial print
			 * year by tharani
			 */
			/*hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "com_delfinancial_printyear");
			arrValues.add(appno);
			arrValues.add(fromid);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");*/
			
			if(Helper.correctNull((String)hsh.get("hidChangeFlag")).equalsIgnoreCase("Y"))
			{
				//To delete the rating data of the current borrower
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "creditratdelete_userid");
				arrValues.add(Helper.correctNull((String) hsh.get("appno")));
				arrValues.add(Helper.correctNull((String) hsh.get("appholder")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
			}

			//For rating year entry By Guhan T
			
			if (!rate_selyear1.equals("")) {
				ratesel_year1 = correctNull((String) hsh.get("ratingchk1"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(ratesel_year1);
				arrValues.add("ASSETS");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!rate_selyear2.equals("")) {
				ratesel_year2 = correctNull((String) hsh.get("ratingchk2"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(ratesel_year2);
				arrValues.add("ASSETS");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!rate_selyear3.equals("")) {
				ratesel_year3 = correctNull((String) hsh.get("ratingchk3"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(ratesel_year3);
				arrValues.add("ASSETS");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!rate_selyear4.equals("")) {
				ratesel_year4 = correctNull((String) hsh.get("ratingchk4"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(ratesel_year4);
				arrValues.add("ASSETS");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!rate_selyear5.equals("")) {
				ratesel_year5 = correctNull((String) hsh.get("ratingchk5"));

				hshQueryValues=new HashMap();
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(ratesel_year5);
				arrValues.add("ASSETS");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_rateyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			
			
			if (!print_selyear1.equals("")) {
				printsel_year1 = correctNull((String) hsh.get("printchk1"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(printsel_year1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear2.equals("")) {
				printsel_year2 = correctNull((String) hsh.get("printchk2"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(printsel_year2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear3.equals("")) {
				printsel_year3 = correctNull((String) hsh.get("printchk3"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(printsel_year3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear4.equals("")) {
				printsel_year4 = correctNull((String) hsh.get("printchk4"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(printsel_year4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear5.equals("")) {
				printsel_year5 = correctNull((String) hsh.get("printchk5"));
				
				hshQueryValues=new HashMap();
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(printsel_year5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}

			/**
			 * 
			 * @S.SATHYA MOORTHY
			 * @CREATED FOR : EXTRA FIELDS ADDED IN THE PROJECT INPUT FIELDS IN
			 *          LARGE CORPORATE AND INFRASTRUCTURE MODEL
			 * 
			 */
			/*
			 * String
			 * p_checkflag=Helper.correctNull((String)hsh.get("p_checkflag"));
			 * 
			 * 
			 * 
			 * if(p_checkflag.equalsIgnoreCase("true"))//condition for checking
			 * large coporate and checking weather it is sister concern or
			 * not.//sathya moorthy
			 * 
			 * {
			 * 
			 * String baseyear=
			 * correctNull((String)hsh.get("txt_baseyearofproject")); String
			 * breakevensales
			 * =correctNull((String)hsh.get("txt_breakevensales")); String
			 * totdebtrequired
			 * =correctNull((String)hsh.get("txt_totdebtrequired")); String
			 * totequityrequired
			 * =correctNull((String)hsh.get("txt_totequityrequired")); String
			 * yearofcashflowestablished
			 * =correctNull((String)hsh.get("txt_yearofcashflowestablished"));
			 * String
			 * discountrate=correctNull((String)hsh.get("txt_discountrate"));
			 * Stringstartingyearloansanctioned=correctNull((String)hsh.get(
			 * "txt_startingyearloansanctioned")); String
			 * endingyearofloansanctioned
			 * =correctNull((String)hsh.get("txt_endingyearofloansanctioned"));
			 * 
			 * double debtrequired=0.0; double equityrequired=0.0; double
			 * totprojectcost=0.0;
			 * 
			 * if(totdebtrequired.equalsIgnoreCase("")) {
			 * totdebtrequired="0.00"; }
			 * 
			 * if(totequityrequired.equalsIgnoreCase("")) {
			 * totequityrequired="0.00"; }
			 * 
			 * debtrequired=Double.parseDouble(totdebtrequired);
			 * equityrequired=Double.parseDouble(totequityrequired);
			 * totprojectcost=debtrequired+equityrequired;
			 * 
			 * String
			 * txt_totprojectcost=Helper.formatDoubleValue(totprojectcost);
			 * 
			 * 
			 * ArrayList arr=new ArrayList();
			 * 
			 * HashMap hsQuery=new HashMap(); HashMap hsQueryValues=new
			 * HashMap(); rs=null;
			 * 
			 * strQuery =
			 * SQLParser.getSqlQuery("financial_new_projectinputfields^"+appno);
			 * rs = DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * arr.add(baseyear); arr.add(breakevensales);
			 * arr.add(totdebtrequired); arr.add(totequityrequired);
			 * arr.add(yearofcashflowestablished); arr.add(discountrate);
			 * arr.add(startingyearloansanctioned);
			 * arr.add(endingyearofloansanctioned); arr.add(txt_totprojectcost);
			 * arr.add(hsh.get("appno"));
			 * 
			 * 
			 * hsQuery.put("strQueryId","financial_new_projectinputfields_update"
			 * );
			 * 
			 * 
			 * } else {
			 * 
			 * arr.add(hsh.get("appno")); arr.add(baseyear);
			 * arr.add(breakevensales); arr.add(totdebtrequired);
			 * arr.add(totequityrequired); arr.add(yearofcashflowestablished);
			 * arr.add(discountrate); arr.add(startingyearloansanctioned);
			 * arr.add(endingyearofloansanctioned); arr.add(txt_totprojectcost);
			 * 
			 * 
			 * hsQuery.put("strQueryId","financial_new_projectinputfields_insert"
			 * );
			 * 
			 * }
			 * 
			 * 
			 * hsQuery.put("arrValues",arr);
			 * 
			 * hsQueryValues.put("size","1"); hsQueryValues.put("1",hsQuery);
			 * EJBInvoker
			 * .executeStateLess("dataaccess",hsQueryValues,"updateData");
			 * 
			 * 
			 * rs=null;
			 * 
			 * 
			 * }
			 */

			// -----------------------------------------------------------------------------------------------------------

			/**
			 * 
			 * @Author: Tharani Devi. R
			 * @CREATED FOR : To Delete all the entries in corp_fin_year table &
			 *          financial table
			 * @PURPOSE : Finacial Page
			 * @DATE : 08/07/2014
			 * 
			 */

			/*
			 * // for getting Finance ID of particular appno int finance_id = 0;
			 * strQuery = SQLParser.getSqlQuery("comfinance_appid_seldivid^" +
			 * appno + "^" + strDivid); if (rs != null) { rs.close(); } rs =
			 * DBUtils.executeQuery(strQuery); if (rs.next()) { finance_id =
			 * Integer.parseInt(rs.getString("fin_financeid")); }
			 */

			/*
			 * to check if detail exists in finacial table & corp_year table
			 * means delete it
			 */

			/*
			 * strQuery = SQLParser.getSqlQuery("corp_fin_year_value^" + appno +
			 * "^" + strDivid); if (rs != null)
			 * 
			 * { rs.close(); } rs = DBUtils.executeQuery(strQuery); if
			 * (rs.next()) { hshQuery = new HashMap(); arrValues = new
			 * ArrayList(); hshQuery.put("strQueryId", "corp_fin_year_del");
			 * arrValues.add(appno); arrValues.add(strDivid);
			 * 
			 * hshQuery.put("arrValues", arrValues); hshQueryValues.put("size",
			 * "1"); hshQueryValues.put("1", hshQuery);
			 * EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
			 * "updateData"); }
			 * 
			 * strQuery = SQLParser.getSqlQuery("corpfinapp_value^" + appno +
			 * "^" + strDivid); if (rs != null)
			 * 
			 * { rs.close(); } rs = DBUtils.executeQuery(strQuery); if
			 * (rs.next()) { hshQuery = new HashMap(); arrValues = new
			 * ArrayList(); hshQuery.put("strQueryId",
			 * "corpfinapp_value_delete"); arrValues.add(appno);
			 * arrValues.add(strDivid);
			 * 
			 * hshQuery.put("arrValues", arrValues); hshQueryValues.put("size",
			 * "1"); hshQueryValues.put("1", hshQuery);
			 * EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
			 * "updateData"); }
			 */

			/**
			 * 
			 * @Author: Muralidharan. R
			 * @CREATED FOR : TO STORE BASE YEAR FOR ALL MODELS
			 * @PURPOSE : RAM INTERFACE
			 * @DATE : 11/01/2008
			 * 
			 */
			String strappno = Helper.correctNull((String) hsh.get("appno"));
			String finance_id = "";
			if (rs != null)
				rs.close();
			if (!strappno.equals("")) {
				if (appno.equals("")) {
					String query1 = SQLParser
							.getSqlQuery("comdemographics_sel^" + strappno);
					rs = DBUtils.executeQuery(query1);

					if (rs.next()) {
						finance_id = (Helper.correctNull((String) rs
								.getString("demo_finstandard")));
						appno = (Helper.correctNull((String) rs
								.getString("demo_finstandard")));
					}
				}
			}

			String BaseYearFlag = Helper.correctNull((String) hsh
					.get("BaseYearFlag"));

			if (BaseYearFlag.equalsIgnoreCase("true")) {
				String base_year = Helper.correctNull((String) hsh
						.get("txt_base_year"));

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_financial_baseyear");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_financial_baseyear");
				arrValues.add(appno);
				arrValues.add(base_year);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			for (int i = 0; i < idlen; i++) {

				String y = Helper.correctInt(id[i]);
				x = Integer.parseInt(y);
				if (strType[i].equalsIgnoreCase("I")) {
					String temp = correctNull((String) hsh.get("desc" + x));
					if (!temp.equals("")) {
						hshQueryValues = new HashMap();
						intUpdatesize = 0;
						strQuery = SQLParser.getSqlQuery("finappdesccount^"
								+ appno + '^' + x);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappdescup");
							arrValues.add(correctNull((String) hsh.get("desc"
									+ x)));
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							hshQuery.put("arrValues", arrValues);

							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
						} else {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappdescins");
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							arrValues.add(correctNull((String) hsh.get("desc"
									+ x)));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}

				}// for first if

				strRowCol1 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c1"));
				strRowCol2 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c2"));
				strRowCol3 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c3"));
				strRowCol4 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c4"));
				strRowCol5 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c5"));

				String strTemp = "";
				strTemp = strType[i];
				String tempDesc = correctNull((String) hsh.get("desc" + x));
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				String yearselect = "";
				int sno = 0;
				if (c1year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c1year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c1year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c1year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year1.equals("") && !c1year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year1);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("com_sno")));
						if(Helper.correctNull((String)rs.getString("com_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
						if (!strsno1.equals("")) {
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							sno = Integer.parseInt(strsno1);
						} else {

							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("per_finayear_maxid^" + appno);
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(Helper.correctInt(rs
										.getString("snorelmax")));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year1Strt);

							hshQuery.put("strQueryId", "corp_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year1.equals("") && !c1year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {

						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year1 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c1year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c1year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }

							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol1);// get values from
															// Rowcal field
								arrValues.add(strRowCol1);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol1);// get values from
															// Rowcal field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(correctNull(id[i]));
							if (c1year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}

							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}

							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(strRowCol1);
								}

							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}
					} else {

						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year1 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c1year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c1year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(correctNull(id[i]));
							if (c1year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}

							/*
							 * if (c1year.trim().equalsIgnoreCase("p")) {
							 * arrValues.add(test); arrValues.add(test);
							 * arrValues.add(test); arrValues.add(test);//get
							 * values from Rowcal field }
							 */
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}

				}// year

				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c2year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c2year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c2year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c2year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year2.equals("") && !year2Strt.equals("") && !c2year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year2);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("com_sno")));
						if(Helper.correctNull((String)rs.getString("com_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year2);
							arrValues.add(yearselect);
							arrValues.add(year2Strt);
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {

						if (!strsno2.equals("")) {
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year2);
							arrValues.add(yearselect);
							arrValues.add(year2Strt);
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							sno = Integer.parseInt(strsno2);
						} else {
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("per_finayear_maxid^" + appno);
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(rs
										.getString("snorelmax"));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year2Strt);
							
							hshQuery.put("strQueryId", "corp_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year2.equals("") && !year2Strt.equals("") && !c2year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year2 + '^'
								+ x + "^" + sno);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c2year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c2year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol2);// get values from
															// Rowcal field
								arrValues.add(strRowCol2);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol2);// get values from
															// Rowcal field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							// log.info("inside this else 2222insert qry loop");
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(correctNull(id[i]));
							if (c2year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(strRowCol2);
								}
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year2 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c2year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c2year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							//						
							if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(correctNull(id[i]));
							if (c2year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}
				}

				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c3year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c3year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c3year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c3year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year3.equals("") && !year3Strt.equals("") && !c3year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year3);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("com_sno")));
						if(Helper.correctNull((String)rs.getString("com_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(year3Strt);
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
						if (!strsno3.equals("")) {
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(year3Strt);
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							sno = Integer.parseInt(strsno3);
						} else {

							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("per_finayear_maxid^" + appno);
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(rs
										.getString("snorelmax"));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year3Strt);
							
							hshQuery.put("strQueryId", "corp_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}

				}

				if (!year3.equals("") && !year3Strt.equals("") && !c3year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year3 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c3year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c3year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol3);// get values from
															// Rowcal field
								arrValues.add(strRowCol3);
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);

							} else {
								arrValues.add(strRowCol3);// get values from
															// Rowcal field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year3);

							arrValues.add(correctNull(id[i]));
							if (c3year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(strRowCol3);
								}
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year3 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c3year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c3year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
								arrValues.add(test);					// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(correctNull(id[i]));
							if (c3year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c4year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c4year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c4year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c4year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year4.equals("") && !year4Strt.equals("") && !c4year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year4);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("com_sno")));
						if(Helper.correctNull((String)rs.getString("com_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(year4Strt);
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
						if (!strsno4.equals("")) {
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(year4Strt);
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							sno = Integer.parseInt(strsno4);
						} else {
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("per_finayear_maxid^" + appno);
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(rs
										.getString("snorelmax"));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year4Strt);

							hshQuery.put("strQueryId", "corp_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}
					}
				}

				if (!year4.equals("") && !year4Strt.equals("") && !c4year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year4 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c4year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c4year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol4);// get values from
															// Rowcal field
								arrValues.add(strRowCol4);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol4);// get values from
															// Rowcal field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(correctNull(id[i]));
							if (c4year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("e")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("p")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(strRowCol4);
								}
							}

							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year4 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c4year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c4year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }

							if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(correctNull(id[i]));
							if (c4year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}

							if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}
				// ///
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c5year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c5year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c5year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c5year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year5.equals("") && !year5Strt.equals("") && !c5year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year5);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("com_sno")));
						if(Helper.correctNull((String)rs.getString("com_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(year5Strt);
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
						if (!strsno5.equals("")) {
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(year5Strt);
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "corp_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							sno = Integer.parseInt(strsno5);
						} else {

							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("per_finayear_maxid^" + appno);
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(rs
										.getString("snorelmax"));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year5Strt);

							hshQuery.put("strQueryId", "corp_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year5.equals("") && !year5Strt.equals("") && !c5year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year5 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c5year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c5year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol5);// get values from
															// Rowcal field
								arrValues.add(strRowCol5);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol5);// get values from
															// Rowcal field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(correctNull(id[i]));
							if (c5year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("e")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("p")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(strRowCol5);
								}
							}

							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("finappvaluescount^"
								+ appno + '^' + strDivid + "^" + year5 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c5year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "finappvaluesup1");
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "finappvaluesup2");
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "finappvaluesup3");
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "finappvaluesup4");
							}
							// if (c5year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "finappvaluesins");
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(correctNull(id[i]));
							if (c5year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}
				// ///

			}// for

			// //log.info("the final hash is "+ hshQueryValues);
			// EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			// Insert Values are in
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "updvaluesarein");
			arrValues.add(strValuesin);
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
		} catch (Exception e) {
			e.printStackTrace();// log.error("in bean"+e);
		}

		finally {
			try {

				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}
	/*Added by Janani. R
	 * Updating data in CGTMSE tab in retail
	 */
	
	public void updateRetailData(HashMap hsh)  {

		ResultSet rs = null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshValues= new HashMap();
		ArrayList arrValues = new ArrayList();
		String  appno="",year1 = "", year2 = "", year3 = "", year4 = "", year5 = "",strAppNo="";
		String year1Strt = "", year2Strt = "", year3Strt = "", year4Strt = "", year5Strt = "";
		String c1year = "", c2year = "", c3year = "", c4year = "", c5year = "", strDivid = "";
		String strRowCol1 = "", strRowCol2 = "", strRowCol3 = "", strRowCol4 = "", strRowCol5 = "";
		int intUpdatesize = 0, intValue = 0;
		String test = Integer.toString(intValue);
		String[] id = null;
		String[] strType = null;
	

		try {
			
			appno = Helper.correctNull((String) hsh.get("appno"));	
			if(appno.equalsIgnoreCase("")){
				appno = Helper.correctNull((String) hsh.get("strappno"));
			}
		
			if(appno.equalsIgnoreCase("")){
				appno = Helper.correctNull((String)hsh.get("app_no"));
			}
			
			
		
			String strAction = Helper.correctNull((String)hsh.get("hidAction"));
			hsh.get("id");
			id = (String[]) hsh.get("id");
			int idlen = id.length;
			
			strType = (String[]) hsh.get("type");
			strDivid = Helper.correctInt((String) hsh.get("sel_divID"));
			year1 = correctNull((String) hsh.get("txtyear1"));
			year2 = correctNull((String) hsh.get("txtyear2"));
			year3 = correctNull((String) hsh.get("txtyear3"));
			year4 = correctNull((String) hsh.get("txtyear4"));
			year5 = correctNull((String) hsh.get("txtyear5"));

			
			
			year1Strt = correctNull((String) hsh.get("txtyear1_start"));
			year2Strt = correctNull((String) hsh.get("txtyear2_start"));
			year3Strt = correctNull((String) hsh.get("txtyear3_start"));
			year4Strt = correctNull((String) hsh.get("txtyear4_start"));
			year5Strt = correctNull((String) hsh.get("txtyear5_start"));
			

			c1year = correctNull((String) hsh.get("combo1"));
			c2year = correctNull((String) hsh.get("combo2"));
			c3year = correctNull((String) hsh.get("combo3"));
			c4year = correctNull((String) hsh.get("combo4"));
			c5year = correctNull((String) hsh.get("combo5"));
	
            String chk1="",chk2="",chk3="",chk4="",chk5="";
            chk1 = correctNull((String) hsh.get("chk1"));
			chk2 = correctNull((String) hsh.get("chk2"));
			chk3 = correctNull((String) hsh.get("chk3"));
			chk4 = correctNull((String) hsh.get("chk4"));
			chk5 = correctNull((String) hsh.get("chk5"));
			
			int x = 0;
			String strsno1 = Helper.correctNull((String) hsh.get("strsno1"));
			String strsno2 = Helper.correctNull((String) hsh.get("strsno2"));
			String strsno3 = Helper.correctNull((String) hsh.get("strsno3"));
			String strsno4 = Helper.correctNull((String) hsh.get("strsno4"));
			String strsno5 = Helper.correctNull((String) hsh.get("strsno5"));
		
			String print_selyear1 = "", print_selyear2 = "", print_selyear3 = "", print_selyear4 = "", print_selyear5 = "";
			print_selyear1 = correctNull((String) hsh.get("printchk1"));
			print_selyear2 = correctNull((String) hsh.get("printchk2"));
			print_selyear3 = correctNull((String) hsh.get("printchk3"));
			print_selyear4 = correctNull((String) hsh.get("printchk4"));
			print_selyear5 = correctNull((String) hsh.get("printchk5"));
			
			String printsel_year1 = "", printsel_year2 = "", printsel_year3 = "", printsel_year4 = "", printsel_year5 = "";
		
			String fromid = "cgtmse";

			if (fromid.equals("-1")) {
				fromid = "1";
			}
			if (!print_selyear1.equals("")) {
				printsel_year1 = correctNull((String) hsh.get("printchk1"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(printsel_year1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear2.equals("")) {
				printsel_year2 = correctNull((String) hsh.get("printchk2"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(printsel_year2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear3.equals("")) {
				printsel_year3 = correctNull((String) hsh.get("printchk3"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(printsel_year3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear4.equals("")) {
				printsel_year4 = correctNull((String) hsh.get("printchk4"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(printsel_year4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear5.equals("")) {
				printsel_year5 = correctNull((String) hsh.get("printchk5"));
				
				hshQueryValues=new HashMap();
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(printsel_year5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_delfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(fromid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			

			for (int i = 0; i < idlen; i++) {

				String y = Helper.correctInt(id[i]);
				x = Integer.parseInt(y);
				
         		strRowCol1 = Helper.correctDouble((String) hsh.get("row" + x+ "c1"));
 				strRowCol2 = Helper.correctDouble((String) hsh.get("row" + x+ "c2"));
 				strRowCol3 = Helper.correctDouble((String) hsh.get("row" + x+ "c3"));
				strRowCol4 = Helper.correctDouble((String) hsh.get("row" + x+ "c4"));
				strRowCol5 = Helper.correctDouble((String) hsh.get("row" + x+ "c5"));
				

				String strTemp = "";
				strTemp = strType[i];
				String tempDesc = correctNull((String) hsh.get("desc" + x));
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				String yearselect = "";
				int sno = 0;
				if (c1year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c1year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c1year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c1year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year1.equals("") && !c1year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("ret_appno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year1);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("ret_sno")));
						if(Helper.correctNull((String)rs.getString("ret_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
						if (!strsno1.equals("")) {
							
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("ret_year_maxid^" + appno);
							if (rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(Helper.correctInt(rs.getString("snorelmax")));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year1Strt);

							hshQuery.put("strQueryId", "ret_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

						
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno1);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							sno = Integer.parseInt(strsno1);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year1.equals("") && !c1year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {

						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year1 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c1year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
					

							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol1);// get values from
															// Rowcal field
								arrValues.add(strRowCol1);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol1);// get values from
															// Rowcal field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(correctNull(id[i]));
							if (c1year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}

							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}

							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol1);// get values from
																// Rowcal field
									arrValues.add(strRowCol1);
								}

							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}
					} else {

						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year1 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c1year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
						
							if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year1);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(correctNull(id[i]));
							if (c1year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c1year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}

						
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}

				}// year

				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c2year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c2year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c2year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c2year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year2.equals("") && !year2Strt.equals("") && !c2year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("ret_appno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year2);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("ret_sno")));
						if(Helper.correctNull((String)rs.getString("ret_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year2);
							arrValues.add(yearselect);
							arrValues.add(year2Strt);
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {

						if (!strsno2.equals("")) {
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("ret_year_maxid^" + appno);
							if (rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(rs.getString("snorelmax"));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year2Strt);
							
							hshQuery.put("strQueryId", "ret_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

							
						} else {
							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year1);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno2);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							sno = Integer.parseInt(strsno2);

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year2.equals("") && !year2Strt.equals("") && !c2year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year2 + '^'
								+ x + "^" + sno);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c2year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol2);// get values from
															// Rowcal field
								arrValues.add(strRowCol2);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol2);// get values from
															// Rowcal field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							// log.info("inside this else 2222insert qry loop");
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(correctNull(id[i]));
							if (c2year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol2);// get values from
																// Rowcal field
									arrValues.add(strRowCol2);
								}
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year2 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c2year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
												
							if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year2);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(correctNull(id[i]));
							if (c2year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c2year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}
				}
				
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c3year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c3year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c3year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c3year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year3.equals("") && !year3Strt.equals("") && !c3year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("ret_appno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year3);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("ret_sno")));
						if(Helper.correctNull((String)rs.getString("ret_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(year3Strt);
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
                           if (!strsno3.equals("")) {
							
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("ret_year_maxid^" + appno);
							if (rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(Helper.correctInt(rs.getString("snorelmax")));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year3Strt);

							hshQuery.put("strQueryId", "ret_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year3);
							arrValues.add(yearselect);
							arrValues.add(year1Strt);
							arrValues.add(appno);
							arrValues.add(strsno3);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							sno = Integer.parseInt(strsno1);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}

				}

				if (!year3.equals("") && !year3Strt.equals("") && !c3year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year3 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c3year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c3year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol3);// get values from
															// Rowcal field
								arrValues.add(strRowCol3);
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

							} else {
								arrValues.add(strRowCol3);// get values from
															// Rowcal field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year3);

							arrValues.add(correctNull(id[i]));
							if (c3year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol3);// get values from
																// Rowcal field
									arrValues.add(strRowCol3);
								}
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year3 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c3year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c3year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
								arrValues.add(test);					// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year3);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(correctNull(id[i]));
							if (c3year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c4year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c4year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c4year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c4year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year4.equals("") && !year4Strt.equals("") && !c4year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("ret_appno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year4);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("ret_sno")));
						if(Helper.correctNull((String)rs.getString("ret_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(year4Strt);
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
	              	if (!strsno4.equals("")) {
							
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("ret_year_maxid^" + appno);
							if (rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(Helper.correctInt(rs.getString("snorelmax")));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year4Strt);

							hshQuery.put("strQueryId", "ret_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year4);
							arrValues.add(yearselect);
							arrValues.add(year4Strt);
							arrValues.add(appno);
							arrValues.add(strsno4);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							sno = Integer.parseInt(strsno1);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}
					}
				}

				if (!year4.equals("") && !year4Strt.equals("") && !c4year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year4 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c4year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c4year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);


								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol4);// get values from
															// Rowcal field
								arrValues.add(strRowCol4);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol4);// get values from
															// Rowcal field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(correctNull(id[i]));
							if (c4year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("e")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c4year.trim().equalsIgnoreCase("p")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol4);// get values from
																// Rowcal field
									arrValues.add(strRowCol4);
								}
							}

							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year4 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c4year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c4year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }

							if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year4);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(correctNull(id[i]));
							if (c4year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c4year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c4year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}

							if (c4year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}
				
				hshQueryValues = new HashMap();
				intUpdatesize = 0;
				yearselect = "";
				sno = 0;
				if (c5year.equalsIgnoreCase("a")) {
					yearselect = "AUDITED";
				}
				if (c5year.equalsIgnoreCase("e")) {
					yearselect = "ESTIMATED";
				}
				if (c5year.equalsIgnoreCase("u")) {
					yearselect = "UNAUDITED";
				}
				if (c5year.equalsIgnoreCase("p")) {
					yearselect = "PROJECTION";
				}
				if (!year5.equals("") && !year5Strt.equals("") && !c5year.trim().equals("")) {

					strQuery = SQLParser.getSqlQuery("ret_appno_select^"
							+ appno + "^" + strDivid + "^" + yearselect + "^"
							+ year5);

					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						sno = Integer.parseInt(Helper.correctInt(rs.getString("ret_sno")));
						if(Helper.correctNull((String)rs.getString("ret_finyear_start")).equalsIgnoreCase(""))
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(year5Strt);
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", "1");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						}
					} else {
                       if (!strsno5.equals("")) {
							
							intUpdatesize = 1;
							strQuery = SQLParser
									.getSqlQuery("ret_year_maxid^" + appno);
							if (rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);

							if (rs.next()) {
								sno = Integer.parseInt(Helper.correctInt(rs
										.getString("snorelmax")));

							}
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(Helper.correctNull(rs
									.getString("snorelmax")));
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(strDivid);
							arrValues.add(year5Strt);

							hshQuery.put("strQueryId", "ret_year_insert");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {

							intUpdatesize = intUpdatesize + 1;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_delete");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add(year5);
							arrValues.add(yearselect);
							arrValues.add(year5Strt);
							arrValues.add(appno);
							arrValues.add(strsno5);
							arrValues.add(strDivid);
							hshQuery.put("strQueryId", "ret_year_update");
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);

							sno = Integer.parseInt(strsno5);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}

				if (!year5.equals("") && !year5Strt.equals("") && !c5year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year5 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c5year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c5year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")
									&& c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(strRowCol5);// get values from
															// Rowcal field
								arrValues.add(strRowCol5);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol5);// get values from
															// Rowcal field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						} else {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(correctNull(id[i]));
							if (c5year.trim().equalsIgnoreCase("a")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("e")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(test);
									arrValues.add(test);
								}
							}
							if (c5year.trim().equalsIgnoreCase("p")) {

								if (strTemp.equalsIgnoreCase("I")
										&& tempDesc.equals("")) {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);// get values from
														// Rowcal field
									arrValues.add(test);
								} else {
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(strRowCol5);// get values from
																// Rowcal field
									arrValues.add(strRowCol5);
								}
							}

							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					} else {
						strQuery = SQLParser.getSqlQuery("sel_retappvaluescount^"
								+ appno + '^' + strDivid + "^" + year5 + '^'
								+ x + "^" + sno);

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							if (c5year.trim().equalsIgnoreCase("a")) {
								hshQuery.put("strQueryId", "cgtmse_update1");
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								hshQuery.put("strQueryId", "cgtmse_update2");
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								hshQuery.put("strQueryId", "cgtmse_update3");
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId", "cgtmse_update4");
							}
							// if (c5year.trim().equalsIgnoreCase("p"))
							// {
							// hshQuery.put("strQueryId","finappvaluesup5");
							// }
							if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							} else {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year5);
								arrValues.add(strDivid);
								arrValues.add(correctNull(id[i]));
								arrValues.add("" + sno);
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
							}

						} else {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cgtmse_retappvaluesins");
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(correctNull(id[i]));
							if (c5year.trim().equalsIgnoreCase("a")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("u")) {
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("e")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(test);
							}
							if (c5year.trim().equalsIgnoreCase("p")) {
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
							}
							arrValues.add(strDivid);
							arrValues.add("" + sno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				}


		}// for
			
			//delete
			if(strAction.equalsIgnoreCase("delete"))
			{
	
				if (!chk1.equals("")) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cgtmse_retappvaluesdel");
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno1);

					hshQuery.put("arrValues", arrValues);

					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_delfinancial_printyear1");
					arrValues.add(appno);
					arrValues.add(fromid);
					arrValues.add(strsno1);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno1);
					
					hshQuery.put("strQueryId", "ret_app_finyear_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

			

					if (!year1.equalsIgnoreCase("")) {
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
								"updateData");
					}
					
				}
				if (!chk2.equals("")) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cgtmse_retappvaluesdel");
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno2);

					hshQuery.put("arrValues", arrValues);

					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_delfinancial_printyear1");
					arrValues.add(appno);
					arrValues.add(fromid);
					arrValues.add(strsno2);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno2);
					
					hshQuery.put("strQueryId", "ret_app_finyear_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

			

					if (!year2.equalsIgnoreCase("")) {
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
								"updateData");
					}
					
				}
				
				if (!chk3.equals("")) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cgtmse_retappvaluesdel");
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno3);

					hshQuery.put("arrValues", arrValues);

					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_delfinancial_printyear1");
					arrValues.add(appno);
					arrValues.add(fromid);
					arrValues.add(strsno3);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno3);
					
					hshQuery.put("strQueryId", "ret_app_finyear_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

			

					if (!year3.equalsIgnoreCase("")) {
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
								"updateData");
					}
					
				}
				
				if (!chk4.equals("")) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cgtmse_retappvaluesdel");
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno4);

					hshQuery.put("arrValues", arrValues);

					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_delfinancial_printyear1");
					arrValues.add(appno);
					arrValues.add(fromid);
					arrValues.add(strsno4);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno4);
					
					hshQuery.put("strQueryId", "ret_app_finyear_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

			

					if (!year4.equalsIgnoreCase("")) {
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
								"updateData");
					}
					
				}
				
				if (!chk5.equals("")) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cgtmse_retappvaluesdel");
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno5);

					hshQuery.put("arrValues", arrValues);

					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_delfinancial_printyear1");
					arrValues.add(appno);
					arrValues.add(fromid);
					arrValues.add(strsno5);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

					hshQuery = new HashMap();
					intUpdatesize = intUpdatesize + 1;
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strDivid);
					arrValues.add(strsno5);
					
					hshQuery.put("strQueryId", "ret_app_finyear_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

			

					if (!year5.equalsIgnoreCase("")) {
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
								"updateData");
					}
					
				}
	
			}


		} catch (Exception e) {
			e.printStackTrace();// log.error("in bean"+e);
		}
		

		finally {
			try {

				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the UpdateRetailData connection "
						+ cf.getMessage());

			}
		}

	}

	public void updateDataRatio(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno = "0", strsno1 = "", strsno2 = "", strsno3 = "", strsno4 = "", strsno5 = "", strValue = "", page = "", strQuery = "", strValuesin = "";
		try {

			strValue = correctNull((String) hsh.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				appno = Helper.correctNull((String) rs
						.getString("DEMO_FINSTANDARD"));
			}
			strsno1 = Helper.correctNull((String) hsh.get("strsno1"));
			strsno2 = Helper.correctNull((String) hsh.get("strsno2"));
			strsno3 = Helper.correctNull((String) hsh.get("strsno3"));
			strsno4 = Helper.correctNull((String) hsh.get("strsno4"));
			strsno5 = Helper.correctNull((String) hsh.get("strsno5"));

			page = correctNull((String) hsh.get("pagefromnew"));
			if (page.equalsIgnoreCase("")) {
				page = "RA";
			}
			String print_selyear1 = "", print_selyear2 = "", print_selyear3 = "", print_selyear4 = "", print_selyear5 = "";
			String printsel_year1 = "", printsel_year2 = "", printsel_year3 = "", printsel_year4 = "", printsel_year5 = "";
			print_selyear1 = correctNull((String) hsh.get("chk1"));
			print_selyear2 = correctNull((String) hsh.get("chk2"));
			print_selyear3 = correctNull((String) hsh.get("chk3"));
			print_selyear4 = correctNull((String) hsh.get("chk4"));
			print_selyear5 = correctNull((String) hsh.get("chk5"));

			/*hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "delfinratio_printyear");
			arrValues.add(appno);
			arrValues.add(page);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");*/

			if (!print_selyear1.equals("")) {
				printsel_year1 = correctNull((String) hsh.get("chk1"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(printsel_year1);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno1);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear2.equals("")) {
				printsel_year2 = correctNull((String) hsh.get("chk2"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(printsel_year2);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno2);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear3.equals("")) {
				printsel_year3 = correctNull((String) hsh.get("chk3"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(printsel_year3);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno3);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear4.equals("")) {
				printsel_year4 = correctNull((String) hsh.get("chk4"));
				
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(printsel_year4);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno4);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
			if (!print_selyear5.equals("")) {
				printsel_year5 = correctNull((String) hsh.get("chk5"));

				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_insfinancial_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(printsel_year5);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "2");
				hshQueryValues.put("2", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delfinratio_printyear");
				arrValues.add(appno);
				arrValues.add(strsno5);
				arrValues.add(page);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
				"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in closing getLoanProducts" + e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
	}

	public void uploadtoRAM(HashMap hshValues)  {
		HashMap hshRes = new HashMap();
		String page = "";
		String cma = "0";
		String strQuery = "";
		String Appno = "", str_Exception = "$";
		String Audited = "", Unaudited = "", Estimated = "", Projection = "";
		String LCM_Financial_Flag = "false", Project_Financial_Flag = "false";
		;
		ResultSet rs = null;

		String strIRBPath1 = ApplicationParams.getDRIVEURL();
		String strIRBPath2 = ApplicationParams.getDRIVEURL1();
		String rootPath = "";
		String FolderName = "Financials\\Data";
		String Path = "";
		File Directory = null;

		try {

			// LogWriter.log("IRB PATH 1 from Financila bean :: "+ strIRBPath1);
			// LogWriter.log("IRB PATH 2 from Financila bean :: "+ strIRBPath2);

			log.info("IRB PATH 1 from Financila bean :: " + strIRBPath1);
			log.info("IRB PATH 2 from Financila bean :: " + strIRBPath2);

			if (new File(strIRBPath1).exists()) {
				rootPath = strIRBPath1;
				Path = rootPath + FolderName;
				Directory = new File(Path);

				if (!Directory.exists()) {
					Directory.mkdirs();
				}
			} else if (new File(strIRBPath2).exists()) {
				rootPath = strIRBPath2;
				Path = rootPath + FolderName;
				Directory = new File(Path);

				if (!Directory.exists()) {
					Directory.mkdirs();
				}
			} else {
				str_Exception = str_Exception
						+ "Network Connectivity Error Occured While Sending Financial Data to IRB !!";
				throw new Exception(str_Exception);
			}
		} catch (Exception e) {
			throw new EJBException(e.toString());

		}
		try {
			Appno = correctNull((String) hshValues.get("appno"));

			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + Appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				cma = rs.getString("demo_finstandard");
			}
			/*
			 * strQuery = SQLParser.getSqlQuery("finselect8^"+Appno); if(rs !=
			 * null) { rs.close(); } rs = DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=rs.getString("cma_no"); }
			 */

			strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^" + Appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			if (!rs.next()) {
				str_Exception = str_Exception + "Base Year Not Entered";
				throw new Exception(str_Exception);
			}

			boolean flag = CheckBalanceSheet(hshValues, cma);

			if (flag == false) {
				str_Exception = str_Exception
						+ "DIFFERENCE IN B/S is not 0. So You Cannot Send Financial Data for Scoring";
				throw new Exception(str_Exception);
			}

			page = correctNull((String) hshValues.get("pageval"));

			// Only for Large Corporate Model

			if (cma.equalsIgnoreCase("4")) {
				strQuery = SQLParser.getSqlQuery("sel_largecorporate_values^"
						+ Appno);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {
					Audited = Helper.correctDouble(rs.getString(1));
					Unaudited = Helper.correctDouble(rs.getString(2));
					Estimated = Helper.correctDouble(rs.getString(3));
					Projection = Helper.correctDouble(rs.getString(4));
				} else {
					LCM_Financial_Flag = "false";
				}

				if (!(Audited.equalsIgnoreCase("0"))
						|| !(Unaudited.equalsIgnoreCase("0"))
						|| !(Estimated.equalsIgnoreCase("0"))
						|| !(Projection.equalsIgnoreCase("0"))) {
					if (!(Audited.equalsIgnoreCase("0.00"))
							|| !(Unaudited.equalsIgnoreCase("0.00"))
							|| !(Estimated.equalsIgnoreCase("0.00"))
							|| !(Projection.equalsIgnoreCase("0.00"))) {
						LCM_Financial_Flag = "true";
					}
				}

				Audited = "";
				Unaudited = "";
				Estimated = "";
				Projection = "";

				strQuery = SQLParser.getSqlQuery("sel_projectfinancial_values^"
						+ Appno);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {
					Audited = Helper.correctDouble(rs.getString(1));
					Unaudited = Helper.correctDouble(rs.getString(2));
					Estimated = Helper.correctDouble(rs.getString(3));
					Projection = Helper.correctDouble(rs.getString(4));
				} else {
					Project_Financial_Flag = "false";
				}

				if (!(Audited.equalsIgnoreCase("0"))
						|| !(Unaudited.equalsIgnoreCase("0"))
						|| !(Estimated.equalsIgnoreCase("0"))
						|| !(Projection.equalsIgnoreCase("0"))) {
					if (!(Audited.equalsIgnoreCase("0.00"))
							|| !(Unaudited.equalsIgnoreCase("0.00"))
							|| !(Estimated.equalsIgnoreCase("0.00"))
							|| !(Projection.equalsIgnoreCase("0.00"))) {

						Project_Financial_Flag = "true";
					}
				}
			}

			if (flag == true) {
				if (cma.equalsIgnoreCase("1")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "NbfcModel");
				} else if (cma.equalsIgnoreCase("2")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "BankModel");
				} else if (cma.equalsIgnoreCase("3")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "RealEstateModel");
				} else if (page.equalsIgnoreCase("Project Financial Input")
						&& cma.equalsIgnoreCase("4")) {
					if (LCM_Financial_Flag.equalsIgnoreCase("true")
							&& Project_Financial_Flag.equalsIgnoreCase("false")) {
						hshRes = (HashMap) EJBInvoker.executeStateLess(
								"LapsToRam", hshValues, "LargeCorporateModel");
					}
					if (LCM_Financial_Flag.equalsIgnoreCase("false")
							&& Project_Financial_Flag.equalsIgnoreCase("true")) {
						hshValues.put("ProjectFinancialFlag", "1");
						hshRes = (HashMap) EJBInvoker
								.executeStateLess("LapsToRam", hshValues,
										"ProjectFinancialInput");
					}
					if (LCM_Financial_Flag.equalsIgnoreCase("true")
							&& Project_Financial_Flag.equalsIgnoreCase("true")) {
						hshValues.put("ProjectFinancialFlag", "2");
						try {
							hshRes = (HashMap) EJBInvoker.executeStateLess(
									"LapsToRam", hshValues,
									"LargeCorporateModel");
						} catch (Exception e) {
							throw new EJBException(e.toString());
						} finally {
							hshRes = (HashMap) EJBInvoker.executeStateLess(
									"LapsToRam", hshValues,
									"ProjectFinancialInput");
						}
					}
				} else if (cma.equalsIgnoreCase("4")) {
					if (LCM_Financial_Flag.equalsIgnoreCase("true")
							&& Project_Financial_Flag.equalsIgnoreCase("false")) {
						hshRes = (HashMap) EJBInvoker.executeStateLess(
								"LapsToRam", hshValues, "LargeCorporateModel");
					}
					if (LCM_Financial_Flag.equalsIgnoreCase("false")
							&& Project_Financial_Flag.equalsIgnoreCase("true")) {
						hshValues.put("ProjectFinancialFlag", "1");
						hshRes = (HashMap) EJBInvoker
								.executeStateLess("LapsToRam", hshValues,
										"ProjectFinancialInput");
					}
					if (LCM_Financial_Flag.equalsIgnoreCase("true")
							&& Project_Financial_Flag.equalsIgnoreCase("true")) {
						hshValues.put("ProjectFinancialFlag", "2");
						try {
							hshRes = (HashMap) EJBInvoker.executeStateLess(
									"LapsToRam", hshValues,
									"LargeCorporateModel");
						} catch (Exception e) {
							throw new EJBException(e.toString());
						} finally {
							hshRes = (HashMap) EJBInvoker.executeStateLess(
									"LapsToRam", hshValues,
									"ProjectFinancialInput");
						}
					}

				} else if (page.equalsIgnoreCase("INFRA STRUCTURE MODEL")
						&& cma.equalsIgnoreCase("5")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "InfraStructureModel");
				} else if (page.equalsIgnoreCase("OPERATIONS PHASE")
						&& cma.equalsIgnoreCase("5")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "OperationsPhase");
				} else if (cma.equalsIgnoreCase("6")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "BrokerModel");
				} else if (cma.equalsIgnoreCase("9")) {
					hshRes = (HashMap) EJBInvoker.executeStateLess("LapsToRam",
							hshValues, "SimplifiedFinancial");
				}
			}

		}

		catch (Exception e) {
			throw new EJBException(e.toString());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}

	/*
	 * Purpose: To check balance sheet for all entered years
	 * 
	 * @Author: Muralidharan.R
	 * 
	 * @Date: 11-JAN-2008
	 */

	public boolean CheckBalanceSheet(HashMap hshValues, String cma)
			 {
		boolean flag = false;
		String Appno = "";
		String sno = "";
		String tab_name = "";
		String year = "", year1 = "", finvalues = "0";
		String fin_yeartype = "";
		int formulaid = 0, i = 0;
		ResultSet rs = null;
		ResultSet rs1 = null;
		double balance_sheet_value = 0.0;
		try {
			Appno = correctNull((String) hshValues.get("appno"));

			if (cma.equalsIgnoreCase("4"))// LCM
			{
				tab_name = "BALANCE SHEET(FIXED ASSETS)";
				sno = "179";
			} else if (cma.equalsIgnoreCase("3"))// REAL ESTATE
			{
				tab_name = "ASSETS";
				sno = "148";
			} else if (cma.equalsIgnoreCase("2"))// BANK MODEL
			{
				tab_name = "BALANCE SHEET (ASSETS) INPUT";
				sno = "72";
			} else if (cma.equalsIgnoreCase("6"))// BROKER MODEL
			{
				tab_name = "BALANCE SHEET (ASSETS)";
				sno = "84";
			} else if (cma.equalsIgnoreCase("1"))// NBFC MODEL
			{
				tab_name = "BALANCE SHEET (ASSETS) INPUT";
				sno = "119";
			} else if (cma.equalsIgnoreCase("9"))// NBFC MODEL
			{
				tab_name = "NET WORTH AND INTANGIBLE ASSETS";
				sno = "19";
			}
			String query1 = SQLParser.getSqlQuery("lapstoram_finYearSel^"
					+ Appno);
			rs1 = DBUtils.executeQuery(query1);
			while (rs1.next()) {
				year = Helper.correctNull(rs1.getString("fin_year"));
				String query = SQLParser.getSqlQuery("lapstoram_yeartype^"
						+ Appno + "^" + year);
				rs = DBUtils.executeQuery(query);
				i = i + 1;
				while (rs.next()) {
					if (!rs.getString("sumaudit").equalsIgnoreCase("0")) {
						fin_yeartype = "a";
					}
					if (!rs.getString("sumunaudit").equalsIgnoreCase("0")) {
						fin_yeartype = "u";
					}
					if (!rs.getString("sumestimated").equalsIgnoreCase("0")) {
						fin_yeartype = "e";
					}
					if (!rs.getString("sumprojection").equalsIgnoreCase("0")) {
						fin_yeartype = "p";
					}

				}

				rs.close();

				String query3 = SQLParser
						.getSqlQuery("lapstoram_finvalues_new^" + sno + "^"
								+ cma + "^" + Appno + "^" + tab_name + "^"
								+ year);
				rs = DBUtils.executeQuery(query3);

				if (rs.next()) {
					finvalues = "";
					formulaid = rs.getInt("fin_formula");
					year1 = Helper.correctNull(rs.getString("fin_year"));
					if (formulaid > 0) {
						HashMap hshformula = new HashMap();
						hshformula.put("appno", Appno);
						hshformula
								.put("formulaid", Integer.toString(formulaid));
						hshformula.put("curryear", year1);
						hshformula.put("prevyear", " ");
						hshformula.put("currfinancialtype", fin_yeartype);
						hshformula.put("prevfinancialtype", "a");
						hshformula.put("internalcalc", "N");
						hshformula.put("hshdata", new HashMap());
						HashMap hshRes = (HashMap) EJBInvoker.executeStateLess(
								"comformula", hshformula, "GetFinValue");
						finvalues = correctNull((String) hshRes
								.get("strTotalValue"));
					}
				}

				if (finvalues.equalsIgnoreCase("")) {
					finvalues = "0.00";
				}

				balance_sheet_value = Double.parseDouble(finvalues);

				if (balance_sheet_value == 0 || balance_sheet_value == 0.00
						|| balance_sheet_value == -0.00
						|| balance_sheet_value == -0) {
					flag = true;
				} else {
					flag = false;
					return flag;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return flag;
	}

	/***
	 * Purpose: to store datas in tables
	 * 
	 * @author:SureshkumarGanapathy
	 * @since:10-Feb-2010
	 ***/
	public void updateFinData(HashMap hshRequestValues)  {
		HashMap hshValues = new HashMap();
		try {
			String strAppno = "";
			String strFlowtype = "";

			strAppno = correctNull((String) hshRequestValues.get("appno"));
			strFlowtype = correctNull((String) hshRequestValues.get("pageval"));

			if (!strAppno.equals("") && !strFlowtype.equals("")) {
				hshValues.put("appno", strAppno);
				hshValues.put("sel_divID", "0");
				hshValues.put("flowtype", strFlowtype);
				GenerateFinancials.GenerateMCMFinancials(hshValues);
			}

		} catch (Exception ex) {
			throw new EJBException("Error in updateFinData :: " + ex.toString());
		}
	}

	/*
	 * Purpose: storing financial values By Venugopal
	 * 
	 * @Date:
	 */
	public HashMap updateFinancialData(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		ArrayList arrValues = new ArrayList();
		HashMap hshValues = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strQuery = "", strValue = "", strTallyFlag = "";

		String sumaudit = "";
		String sumunaudit = "";
		String sumestimated = "";
		String sumprojection = "";
		String sel_divID = "";
		String pagetab = "";
		int intUpdatesize = 0;
		double dbLiabAmount = 0.00, dbAssetAmount = 0.00;
		String cma = "0";

		try {
			// String
			// hidUpload=correctNull((String)hshRequestValues.get("hidUpload"));
			strValue = correctNull((String) hshRequestValues.get("appno"));
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			cma = correctNull((String) hshRequestValues.get("hidcmasno"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}
			String page = correctNull((String) hshRequestValues.get("pageval"));
			pagetab = Helper.correctNull(page);

			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			// ArrayList vecRec=new ArrayList();
			ArrayList vecid = new ArrayList();
			hshValues.put("sel_divID", sel_divID);

			// -------------- to find the time of review-----------------

			/*
			 * if(rs!=null) { rs.close(); } strQuery =
			 * SQLParser.getSqlQuery("finselect1^"+strValue+"^"+sel_divID); rs =
			 * DBUtils.executeQuery(strQuery); while(rs.next()) {
			 * str=rs.getInt("cnt"); }
			 */

			// --------------- to find the cma format of the particular
			// applications-------

			// if(correctNull((String)hshRequestValues.get("cattype")).equalsIgnoreCase("OPS")
			// &&
			// correctNull((String)hshRequestValues.get("hidSSIType")).equalsIgnoreCase("WOADV"))
			// cma=ApplicationParams.getTerCMAWOADV();
			// else
			// if(correctNull((String)hshRequestValues.get("cattype")).equalsIgnoreCase("OPS")
			// &&
			// correctNull((String)hshRequestValues.get("hidSSIType")).equalsIgnoreCase("WADV"))
			// cma=ApplicationParams.getTertiaryCMA();
			// else
			// {
			/*
			 * strQuery=SQLParser.getSqlQuery("comfinance_appid^"+strValue);
			 * //strQuery = SQLParser.getSqlQuery("finselect8^"+strValue); if(rs
			 * != null) { rs.close(); } rs = DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=rs.getString("fin_cmano"); }
			 */

			if (cma.equalsIgnoreCase("5")) {
				if (pagetab.equalsIgnoreCase("")) {
					pagetab = "INFRA STRUCTURE MODEL";
				}
			}
			// }

			String yearselect = "", seloption = "", givenyear = "";
			int i = 0, k = 0;
			int from = 0, p = 0;
			ArrayList vecrec = new ArrayList();
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[6];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";
			String sno = "";
			// this code has been commented by balaji & shanmugam for get all
			// the year for all the sub tags
			// and new line has been added bellow

			// strQuery =
			// SQLParser.getSqlQuery("finselect4^"+page+"^"+masterpage+"^"+strValue);
			strQuery = SQLParser.getSqlQuery("finYearSel_Calc^" + strValue
					+ "^" + sel_divID);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";
				vecVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				sno = (String) Helper.correctNull(rs.getString("com_sno"));
				if (!yearselect.equals("")) {

					if (rs3 != null) {
						rs3.close();
					}

					String strQuery10 = SQLParser.getSqlQuery("assessselect9^"
							+ strValue + "^" + sel_divID + "^" + yearselect
							+ "^" + sno);
					if (rs10 != null) {
						rs10.close();
					}

					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumaudit = Helper.correctDouble(rs10
								.getString("sumaudit"));
						sumunaudit = Helper.correctDouble(rs10
								.getString("sumunaudit"));
						sumestimated = Helper.correctDouble(rs10
								.getString("sumestimated"));
						sumprojection = Helper.correctDouble(rs10
								.getString("sumprojection"));
					}
					if (valarray[0].equals("0") && !sumaudit.equals("0")) {
						valarray[0] = "fin_audit";
					}
					if (valarray[1].equals("0") && !sumunaudit.equals("0")) {
						valarray[1] = "fin_unaudit";
					}
					if (valarray[2].equals("0") && !sumestimated.equals("0")) {
						valarray[2] = "fin_estimated";
					}
					if (valarray[3].equals("0") && !sumprojection.equals("0")) {
						valarray[3] = "fin_projection";
					}
					if (valarray[4].equals("0") && !sumprojection.equals("0")) {
						valarray[4] = "fin_projection";
					}

					if (rs10 != null) {
						rs10.close();
					}

					for (int h = 0; h < 4; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0.00";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							if ((i >= from) && (k < 5)) {
								p = i;
								k = k + 1;

								strQuery = SQLParser
										.getSqlQuery("testfinselect5^"
												+ seloption + "^" + cma + "^"
												+ page + "^" + yearselect + "^"
												+ strValue + "^" + sel_divID
												+ "^" + sno);

								if (rs1 != null) {
									rs1.close();
								}
								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {
									if (seloption.equals("fin_audit")) {
										desc = "a";
									} else if (seloption.equals("fin_unaudit")) {
										desc = "u";
									} else if (seloption
											.equals("fin_estimated")) {
										desc = "e";
									} else if (seloption
											.equals("fin_projection")) {
										desc = "p";
									}
									int formuladesc = 0;
									String fin_rowid = "";
									formuladesc = (rs1.getInt("formula"));

									//
									fin_rowid = Helper.correctNull(rs1
											.getString("fin_rowid"));
									//
									if (formuladesc > 0) {
										HashMap hshformula = new HashMap();
										hshformula.put("appno", strValue);
										hshformula.put("sel_divID", sel_divID);
										hshformula.put("formulaid", Integer
												.toString(formuladesc));
										hshformula.put("curryear", yearselect);
										hshformula.put("prevyear", " ");
										hshformula.put("currfinancialtype",
												desc);
										hshformula
												.put("prevfinancialtype", "a");
										hshformula.put("internalcalc", "N");
										hshformula.put("sno", sno);
										hshformula
												.put("hshdata", new HashMap());
										HashMap hshRes = (HashMap) EJBInvoker
												.executeStateLess("comformula",
														hshformula,
														"GetFinValue");

										String strTotalValue = correctNull((String) hshRes
												.get("strTotalValue"));
										vecVal
												.add(correctNull((String) hshRes
														.get("strTotalValue")));
										vecid.add(correctNull(rs1
												.getString("fin_rowid")));

										/**
										 * By venu Storing financial calculated
										 * data into tables
										 */
										hshQueryValues = new HashMap();
										intUpdatesize = 0;
										hshQuery = new HashMap();
										arrValues = new ArrayList();
										intUpdatesize = intUpdatesize + 1;
										if (seloption.equals("fin_audit")) {
											hshQuery.put("strQueryId",
													"finappvaluesup1");
										}
										if (seloption.equals("fin_unaudit")) {
											hshQuery.put("strQueryId",
													"finappvaluesup2");
										}
										if (seloption.equals("fin_estimated")) {
											hshQuery.put("strQueryId",
													"finappvaluesup3");
										}
										if (seloption.equals("fin_projection")) {
											hshQuery.put("strQueryId",
													"finappvaluesup4");
										}

										if (seloption.equals("fin_projection")) {
											arrValues.add(strTotalValue);// get
																			// values
																			// from
																			// Rowcal
																			// field
											arrValues.add(strTotalValue);// get
																			// values
																			// from
																			// Rowcal
																			// field
											arrValues.add(yearselect);
											arrValues.add(sel_divID);
											arrValues.add(fin_rowid);
											arrValues.add("" + sno);
											arrValues.add(strValue);

											hshQuery
													.put("arrValues", arrValues);
											hshQueryValues.put("size", Integer
													.toString(intUpdatesize));
											hshQueryValues.put(Integer
													.toString(intUpdatesize),
													hshQuery);
											EJBInvoker.executeStateLess(
													"dataaccess",
													hshQueryValues,
													"updateData");
										} else {
											arrValues.add(strTotalValue);// get
																			// values
																			// from
																			// Rowcal
																			// field
											arrValues.add(yearselect);
											arrValues.add(sel_divID);
											arrValues.add(fin_rowid);
											arrValues.add("" + sno);
											arrValues.add(strValue);
											hshQuery
													.put("arrValues", arrValues);
											hshQueryValues.put("size", Integer
													.toString(intUpdatesize));
											hshQueryValues.put(Integer
													.toString(intUpdatesize),
													hshQuery);
											EJBInvoker.executeStateLess(
													"dataaccess",
													hshQueryValues,
													"updateData");
										}

									}
									hshValues.put("year" + k, vecVal);
									hshValues.put("vecid" + k, vecid);
								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
							}

						}
					}
				}
			}
			/*
			 * Calculate Kalypto and Save the details in Kalpto Table
			 */

			/*
			 * intUpdatesize = 0; HashMap hshReqValues=new HashMap(); HashMap
			 * hshResult=new HashMap(); ArrayList vecyear=new ArrayList();
			 * hshReqValues.put("appno",strValue);
			 * hshReqValues.put("pagefrom","RA3"); hshReqValues.put("from",
			 * "1"); hshReqValues.put("pagename", "FI");
			 * hshResult=getDataRatio(hshReqValues);
			 * 
			 * String
			 * totalyear=Helper.correctNull((String)hshResult.get("totalyear"));
			 * int totyr=Integer.parseInt(totalyear); ArrayList yearvalue=new
			 * ArrayList(); yearvalue=(ArrayList)hshResult.get("yearvalue");
			 * 
			 * String[] Dates=new String[totyr];//Date String[] finType=new
			 * String[totyr]; ArrayList[] vecyears=new ArrayList[totyr]; ArrayList
			 * vecid1=new ArrayList(); for(i=0;i<(totyr);i++) { k=i+1;
			 * vecyears[i]=(ArrayList)hshResult.get("year"+k); } int j=0;k=0;
			 * for(i=0;i<2totyr;i++) { if(i%2==0) {
			 * Dates[j]=(String)yearvalue.get(i); j++; } else {
			 * finType[k]=(String)yearvalue.get(i); k++; } }
			 * vecid1=(ArrayList)hshResult.get("vecid1");
			 * 
			 * hshQueryValues = new HashMap(); hshQuery = new HashMap();
			 * arrValues=new ArrayList(); intUpdatesize++;
			 * hshQuery.put("strQueryId","com_kalypto_del");
			 * arrValues.add(strValue); hshQuery.put("arrValues",arrValues);
			 * hshQueryValues.put(""+intUpdatesize,hshQuery);
			 * 
			 * for(int NoOfYears=0;NoOfYears<totyr;NoOfYears++) {
			 * for(i=0;i<vecid1.size();i++) { hshQuery = new HashMap();
			 * arrValues=new ArrayList(); intUpdatesize++;
			 * hshQuery.put("strQueryId","com_kalypto_ins");
			 * arrValues.add(strValue);//appno
			 * arrValues.add(Dates[NoOfYears]);//Date
			 * arrValues.add(vecid1.get(i));//rowid
			 * arrValues.add(vecyears[NoOfYears].get(i));//value
			 * arrValues.add(finType[NoOfYears]);//type
			 * arrValues.add(""+(i+1));//sno
			 * hshQuery.put("arrValues",arrValues);
			 * hshQueryValues.put(""+intUpdatesize,hshQuery); } }
			 * hshQueryValues.put("size",""+intUpdatesize);
			 * EJBInvoker.executeStateLess
			 * ("dataaccess",hshQueryValues,"updateData");
			 */

			// Added by bhaskar for financial assests and liab tally
			String strTabName1 = "ASSETS", strTabName2 = "LIABILITIES";
			String strRowDescAseets = "TOTAL ASSETS", strRowDescLiab = "TOTAL LIABILITIES";
			String strAsRowID = "0", strLiabRowID = "0";
			if (rs != null) {
				rs.close();
			}
			// To get LiabilityTotal rowid for selected cma number
			rs = DBUtils.executeLAPSQuery("selrowidforliabasset^" + strValue
					+ "^" + strTabName1 + "^" + strRowDescAseets);
			if (rs.next()) {
				strAsRowID = Helper.correctNull((String) rs
						.getString("FIN_ROWID"));
			}
			if (rs != null) {
				rs.close();
			}
			// To get Assetes rowid for selected cma number
			rs = DBUtils.executeLAPSQuery("selrowidforliabasset^" + strValue
					+ "^" + strTabName2 + "^" + strRowDescLiab);
			if (rs.next()) {
				strLiabRowID = Helper.correctNull((String) rs
						.getString("FIN_ROWID"));
			}
			
			if(rs1!=null)
				rs1.close();
			
			rs1=DBUtils.executeLAPSQuery("corp_app_financials_select_distinctyear^"+strValue+"^0");
			while(rs1.next())
			{
				if (rs != null) {
					rs.close();
				}
				if (!strLiabRowID.equalsIgnoreCase("")
						&& !strLiabRowID.equalsIgnoreCase("0")) {
					rs = DBUtils.executeLAPSQuery("selliabamuntsum_year^" + strValue
							+ "^" + strLiabRowID+"^"+Helper.correctNull(rs1.getString("com_sno")));
					if (rs.next()) {
						dbLiabAmount = Double.parseDouble(Helper
								.correctDouble((String) rs.getString("liabsum")));
					}
				}
				if (rs != null) {
					rs.close();
				}
				if (!strAsRowID.equalsIgnoreCase("")
						&& !strAsRowID.equalsIgnoreCase("0")) {
					rs = DBUtils.executeLAPSQuery("selassetssumamunt_year^" + strValue
							+ "^" + strAsRowID+"^"+Helper.correctNull(rs1.getString("com_sno")));
					if (rs.next()) {
						dbAssetAmount = Double.parseDouble(Helper
								.correctDouble((String) rs.getString("assetsum")));
					}
				}
				if (dbAssetAmount != dbLiabAmount) {
					strTallyFlag = "N";
					break;
				} 
				else
				{
					strTallyFlag = "Y";
				}
			}

			

			if (page.trim().equalsIgnoreCase("PROFIT AND LOSS ACCOUNT")) {
				strTallyFlag = "";
			}
			// ENDED
			
			//TO update tally flag
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "upd_tally_flag");
			arrValues.add(strTallyFlag);
			arrValues.add(strValue);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getData login  " + ce.toString());

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		hshValues.put("tabname", pagetab);
		hshValues.put("strTallyFlag", strTallyFlag);

		return hshValues;
	}

	/*
	 * private void insertRatios(HashMap hshReqValues) {
	 * ResultSet rs = null; ResultSet rs1 = null; ResultSet rs3 = null;
	 * ResultSet rsPrevYear =null; ResultSet rsFormulaFor =null; HashMap
	 * hshValues=null; String strQuery="",strValue=""; int str=0;
	 * 
	 * try { strValue=correctNull((String)hshReqValues.get("appno"));
	 * 
	 * hshValues = new HashMap(); ArrayList vecVal=new ArrayList(); ArrayList vecRec=new
	 * ArrayList(); ArrayList vecid = new ArrayList(); String page="RA";
	 * 
	 * 
	 * strQuery = SQLParser.getSqlQuery("finselect1^"+strValue+"^0"); rs =
	 * DBUtils.executeQuery(strQuery);
	 * 
	 * while(rs.next()) { str=rs.getInt("cnt"); } if(rs!=null) { rs.close(); }
	 * 
	 * String cma="";
	 * strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue); rs =
	 * DBUtils.executeQuery(strQuery);
	 * 
	 * while(rs.next()) { cma=rs.getString("demo_finstandard"); }
	 * hshValues.put("cma",cma); if(rs!=null) { rs.close(); }
	 * 
	 * 
	 * vecVal = new ArrayList();
	 * 
	 * //--------------- to select label depending upon existence of application
	 * 
	 * if (str <= 0) { strQuery =
	 * SQLParser.getSqlQuery("finselect2a^"+cma+"^"+page);
	 * rs=DBUtils.executeQuery(strQuery); while(rs.next()) { vecRec = new
	 * ArrayList(); vecRec.add(correctNull(rs.getString("fin_rowid")));
	 * vecRec.add(correctNull(rs.getString("fin_rowdesc")));
	 * vecRec.add(correctNull(rs.getString("fin_rowtype")));
	 * vecRec.add(correctNull(rs.getString("fin_sno")));
	 * vecVal.add(vecRec);
	 * 
	 * }
	 * 
	 * hshValues.put("labeldetails",vecVal);
	 * 
	 * }
	 * 
	 * else if (str > 0) { vecVal = new ArrayList(); String temp=""; //strQuery =
	 * SQLParser.getSqlQuery("finselect3a^"+strValue+"^"+cma+"^"+page); strQuery
	 * = SQLParser.getSqlQuery("finselect3a^"+cma+"^"+page);
	 * 
	 * 
	 * rs=DBUtils.executeQuery(strQuery); while(rs.next()) { vecRec = new
	 * ArrayList(); vecRec.add(correctNull(rs.getString("myrowid")));
	 * 
	 * temp = Helper.correctNull(rs.getString("desc1")); if (temp.equals("")) {
	 * vecRec.add(correctNull(rs.getString("desc2"))); } else {
	 * vecRec.add(correctNull(rs.getString("desc1"))); }
	 * 
	 * vecRec.add(correctNull(rs.getString("fin_rowtype")));
	 * vecRec.add(correctNull(rs.getString("fin_sno")));
	 * vecVal.add(vecRec); }
	 * 
	 * hshValues.put("labeldetails",vecVal);
	 * 
	 * }
	 * 
	 * if(rs!=null) { rs.close(); }
	 * hshValues.put("count",Integer.toString(str));
	 * 
	 * String yearselect="",seloption="",givenyear="",yearvalue="",tempyear="";
	 * int i = 0,k=0; int from = 0,p=0; int yearint = 0; ArrayList vecrec = new
	 * ArrayList();
	 * 
	 * givenyear = correctNull((String)hshRequestValues.get("from")); if
	 * (givenyear.equals("")) { givenyear="0"; } from =
	 * Integer.parseInt(givenyear); if (from == 0) { from = 1; }
	 * 
	 * String valarray[] = new String[5]; valarray[0] ="0"; valarray[1] ="0";
	 * valarray[2] ="0"; valarray[3] ="0"; valarray[4] ="0";
	 * 
	 * strQuery = SQLParser.getSqlQuery("finselect4a^"+strValue);
	 * rs=DBUtils.executeQuery(strQuery);
	 * 
	 * while(rs.next()) { valarray[0] ="0"; valarray[1] ="0"; valarray[2] ="0";
	 * valarray[3] ="0"; valarray[4] ="0";
	 * 
	 * vecVal = new ArrayList(); String str1="",str2="",str3="",str0=""; String
	 * desc="",formula_desc="";
	 * 
	 * // To Find the years assigned for each application
	 * 
	 * yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
	 * yearvalue = (String)Helper.correctNull(rs.getString("yearvalue")); if
	 * (!yearvalue.equals(tempyear) ) {
	 * 
	 * // to check for the occurance of audited,.,.,. for a paricular year
	 * 
	 * strQuery = SQLParser.getSqlQuery("finselect7a^"+yearselect+"^"+strValue);
	 * 
	 * rs3 = DBUtils.executeQuery(strQuery);
	 * 
	 * while(rs3.next()) { if(valarray[0].equals("0")) {
	 * valarray[0]=Helper.correctDouble(rs3.getString("fin_audit")); }
	 * if(valarray[1].equals("0")) {
	 * valarray[1]=Helper.correctDouble(rs3.getString("fin_unaudit")); }
	 * if(valarray[2].equals("0")) {
	 * valarray[2]=Helper.correctDouble(rs3.getString("fin_estimated")); }
	 * if(valarray[3].equals("0")) {
	 * valarray[3]=Helper.correctDouble(rs3.getString("fin_projection")); }
	 * if(valarray[4].equals("0")) {
	 * valarray[4]=Helper.correctDouble(rs3.getString("fin_projection")); }
	 * 
	 * if (!valarray[0].equals("0")) { valarray[0]= "fin_audit"; }
	 * 
	 * if (!valarray[1].equals("0")) { valarray[1] = "fin_unaudit"; }
	 * 
	 * if (!valarray[2].equals("0")) { valarray[2] = "fin_estimated"; }
	 * 
	 * if (!valarray[3].equals("0")) { valarray[3] = "fin_projection"; } if
	 * (!valarray[4].equals("0")) { valarray[4] = "fin_projection"; } }
	 * if(rs3!=null) { rs3.close(); }
	 * 
	 * // to find the values for each label with respect to
	 * value(a,una,p,e),year and id
	 * 
	 * for (int h=0;h<=3;h++) { vecVal = new ArrayList(); vecid = new ArrayList();
	 * 
	 * if(valarray[h].equals("")) { valarray[h]="0"; } if
	 * (!valarray[h].equals("0")) { i=i+1; seloption=valarray[h]; if ((i >=
	 * from) && (k < 5) ) { p=i; k=k+1; strQuery =
	 * SQLParser.getSqlQuery("finratio1^"+page+"^"+cma);
	 * 
	 * rs1=DBUtils.executeQuery(strQuery); while (rs1.next()) { if
	 * (seloption.equals("fin_audit")) { desc="a"; } else if
	 * (seloption.equals("fin_unaudit")) { desc="u"; } else if
	 * (seloption.equals("fin_estimated")) { desc="e"; } else if
	 * (seloption.equals("fin_projection")) { desc="p"; } int formuladesc=0;
	 * formuladesc =(rs1.getInt("fin_formula")) ;
	 * 
	 * if (formuladesc > 0 ) {
	 * 
	 * strQuery = SQLParser.getSqlQuery("selfinformula^"+formuladesc);
	 * 
	 * rsFormulaFor = DBUtils.executeQuery(strQuery); String strFormulaFor="";
	 * if(rsFormulaFor.next()) { strFormulaFor =
	 * correctNull((String)rsFormulaFor.getString("formula_for")); }
	 * 
	 * String strPreYear ="",strPreYearDesc=""; if(rsFormulaFor!=null) {
	 * rsFormulaFor.close(); } if((strFormulaFor.trim().equalsIgnoreCase("CA"))
	 * || (strFormulaFor.trim().equalsIgnoreCase("ST"))) { strQuery =
	 * SQLParser.getSqlQuery("selpreyrs^"+strValue+"^<^"+yearselect);
	 * 
	 * rsPrevYear = DBUtils.executeQuery(strQuery); if(rsPrevYear.next()) {
	 * double audit = rsPrevYear.getDouble("audit"); double unaudit =
	 * rsPrevYear.getDouble("unaudit"); double estimated =
	 * rsPrevYear.getDouble("estimated"); double projection =
	 * rsPrevYear.getDouble("projection"); if(audit!=0) { strPreYearDesc = "A";
	 * } else if(unaudit!=0) { strPreYearDesc = "U"; } else if(estimated!=0) {
	 * strPreYearDesc = "E"; } else if(projection!=0) { strPreYearDesc = "P"; }
	 * strPreYear = rsPrevYear.getString("prevyear"); } if(rsPrevYear!=null) {
	 * rsPrevYear.close(); }
	 * 
	 * if(!strPreYear.trim().equals("")) { HashMap hshformula = new HashMap();
	 * hshformula.put("appno",strValue);
	 * hshformula.put("formulaid",Integer.toString(formuladesc));
	 * hshformula.put("curryear",yearselect);
	 * hshformula.put("prevyear",strPreYear);
	 * hshformula.put("currfinancialtype",desc);
	 * hshformula.put("prevfinancialtype",strPreYearDesc);
	 * hshformula.put("internalcalc","N");
	 * if(strFormulaFor.trim().equalsIgnoreCase("ST")) {
	 * hshformula.put("isstress","Y"); hshformula.put("ratiostress","Y"); }
	 * hshformula.put("hshdata",new HashMap()); HashMap hshRes =
	 * (HashMap)EJBInvoker
	 * .executeStateLess("comformula",hshformula,"GetFinValue");
	 * 
	 * vecVal.add(correctNull((String)hshRes.get("strTotalValue"))); }
	 * else { vecVal.add("-");
	 * 
	 * }
	 * 
	 * } else { HashMap hshformula = new HashMap();
	 * hshformula.put("appno",strValue);
	 * hshformula.put("formulaid",Integer.toString(formuladesc));
	 * hshformula.put("curryear",yearselect);
	 * hshformula.put("prevyear",strPreYear);
	 * hshformula.put("currfinancialtype",desc);
	 * hshformula.put("prevfinancialtype",strPreYearDesc);
	 * hshformula.put("internalcalc","N"); hshformula.put("hshdata",new
	 * HashMap()); HashMap hshRes =
	 * (HashMap)EJBInvoker.executeStateLess("comformula"
	 * ,hshformula,"GetFinValue");
	 * vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
	 * 
	 * } vecid.add(correctNull(rs1.getString("fin_rowid"))); } else {
	 * vecVal.add("0.00");
	 * vecid.add(correctNull(rs1.getString("fin_rowid"))); }
	 * hshValues.put("year"+k,vecVal); hshValues.put("vecid"+k,vecid);
	 * 
	 * }
	 * 
	 * if(rs1 != null) { rs1.close(); } vecrec.add(yearselect);
	 * vecrec.add(seloption); }
	 * 
	 * } }
	 * 
	 * }
	 * 
	 * yearint=yearint + 1; tempyear = yearvalue;
	 * 
	 * } hshValues.put("from",Integer.toString(from));
	 * hshValues.put("totalyear",i+""); hshValues.put("upto",p+"");
	 * hshValues.put("yearvalue",vecrec); hshValues.put("page",page);
	 * hshValues.put("cma_no",cma);
	 * 
	 * } catch(Exception ce) { throw new
	 * EJBException("Error in getData login  "+ce.toString()); } finally { try {
	 * if(rs != null) rs.close(); if(rs1 != null) rs1.close(); if(rsFormulaFor
	 * != null) rsFormulaFor.close(); if(rsPrevYear != null) rsPrevYear.close();
	 * if(rs3 != null) rs3.close();
	 * 
	 * } catch(Exception cf) { throw new
	 * EJBException("Error closing the connection "+cf.getMessage()); } } }
	 */

	public HashMap getSensitiveData(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "", strAction = "";

		int str = 0;
		String sumprojection = "";
		String sumstressprojection = "";
		// String strFinType="";

		try {

			strValue = correctNull((String) hshRequestValues.get("appno"));
			strAction = correctNull((String) hshRequestValues.get("hidAction"));

			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			ArrayList vecPercent = new ArrayList();
			ArrayList vecOld = new ArrayList();

			// --------------- to find the cma format of the particular
			// applications-------

			String cma = "";
			// strQuery = SQLParser.getSqlQuery("com_finselect8^"+strValue);
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + strValue);

			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				cma = correctNull(rs.getString("demo_finstandard"));
			}
			// -------------------------Check the financial
			// update---------------------
			/*
			 * strQuery =
			 * SQLParser.getSqlQuery("com_selfinancial_baseyear^"+strValue);
			 * if(rs!=null) rs.close(); rs = DBUtils.executeQuery(strQuery);
			 * 
			 * if(rs.next()) {
			 * strFinType=correctNull(rs.getString("com_finupdate")); }
			 */

			// -----------------to find the tab----------------------
			String page = correctNull((String) hshRequestValues.get("pageval"));

			hshValues.put("tabdetails", vecVal);
			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application
			String tempsno = "";

			if (!cma.equalsIgnoreCase("")) {
				strQuery = SQLParser.getSqlQuery("com_fin_sensitive_select^"
						+ cma);
				if (rs != null)
					rs.close();

				rs = DBUtils.executeQuery(strQuery);
			}
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_rowid")));
				vecRec.add(correctNull(rs.getString("fin_rowdesc")));
				vecRec.add(correctNull(rs.getString("fin_rowtype")));
				tempsno = correctNull(rs.getString("fin_sno"));
				if (tempsno.trim().equals("")) {
					tempsno = " ";
				}
				vecRec.add(tempsno);
				vecVal.add(vecRec);

			}

			hshValues.put("labeldetails", vecVal);
			hshValues.put("count", Integer.toString(str));

			String yearselect = "", seloption = "", givenyear = "";
			int i = 0, k = 0;
			int from = 0, p = 0;

			ArrayList vecrec = new ArrayList();

			givenyear = correctNull((String) hshRequestValues.get("from"));
			// givenyear="5";

			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}
			String valarray[] = new String[6];

			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";

			strQuery = SQLParser.getSqlQuery("com_finYearSel^" + strValue
					+ "^0");

			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryvall = new ArrayList();

			int kk = 0;
			while (rs.next()) {
				arryvall.add(Helper.correctNull(rs.getString("fin_year")));
				// arryvall.add(Integer.toString(kk+1));
			}
			// strQuery =
			// SQLParser.getSqlQuery("finselect4^"+strValue+"^"+page+"^"+masterpage);

			// this code has been commented by balaji & shanmugam for get all
			// the year for all the sub tags
			// and new line has been added bellow
			// strQuery =
			// SQLParser.getSqlQuery("finselect4^"+page+"^"+masterpage+"^"+strValue);
			strQuery = SQLParser.getSqlQuery("com_finYearSel^" + strValue
					+ "^0");

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";

				vecVal = new ArrayList();
				vecOld = new ArrayList();
				// String str1="",str2="",str3="",str0="";
				String desc = "";
				// String formula_desc="";
				// int total=0,v=0;

				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));

				if (!yearselect.equals("")) {
					String strQuery10 = SQLParser
							.getSqlQuery("com_assessselect9^" + strValue
									+ "^0^" + yearselect);
					if (rs10 != null) {
						rs10.close();
					}
					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumprojection = Helper.correctDouble(rs10
								.getString("sumprojection"));
						sumstressprojection = Helper.correctDouble(rs10
								.getString("fin_stress_projection"));
					}

					// if(strFinType.equalsIgnoreCase("Y"))
					// {
					if (Double.parseDouble(sumprojection) > 0) {

						for (int h = 0; h < 1; h++) {
							vecVal = new ArrayList();
							vecid = new ArrayList();
							vecOld = new ArrayList();
							vecPercent = new ArrayList();

							i = i + 1;

							if ((i >= from) && (k < 4)) {
								p = i;
								k = k + 1;
								strQuery = // SQLParser.getSqlQuery("finselect5^"+seloption+"^"+yearselect+"^"+strValue+"^"+cma+"^"+page);
								SQLParser
										.getSqlQuery("com_fin_sensitive_select5^"
												+ cma
												+ "^"
												+ yearselect
												+ "^"
												+ strValue + "^0");

								if (rs1 != null) {
									rs1.close();
								}

								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {
									vecVal
											.add(correctNull(rs1
													.getString("fin_stress_projection")));// new
																							// value
									vecOld.add(correctNull(rs1
											.getString("fin_projection")));// old
																			// value
									vecid.add(correctNull(rs1
											.getString("fin_rowid")));
									vecPercent.add(correctNull(rs1
											.getString("fin_stress_percent")));

									hshValues.put("year" + k, vecVal);
									hshValues.put("finyear" + k, vecOld); // old
																			// value
									hshValues.put("vecid" + k, vecid);
									if (k == 1)
										hshValues.put("vecPercent" + k,
												vecPercent);
								}
								if (rs1 != null)
									rs1.close();
								vecrec.add(yearselect);
								vecrec.add("fin_stress_projection");
							}

						}
					}
					// }
					// else{
					//	
					// if(Double.parseDouble(sumstressprojection)>0){
					//		
					// if (valarray[0].equals("0") &&
					// !sumprojection.equals("0"))
					// valarray[0]="fin_stress_projection";
					//		
					// for (int h=0;h<1;h++)
					// {
					// vecVal = new ArrayList();
					// vecid = new ArrayList();
					// vecPercent=new ArrayList();
					//				
					// if(valarray[h].equals(""))
					// {
					// valarray[h]="0.00";
					// }
					// if (!valarray[h].equals("0"))
					// {
					// i=i+1;
					// seloption=valarray[h];
					//
					// if ((i >= from))
					// {
					// k=k+1;
					// strQuery =
					// //SQLParser.getSqlQuery("finselect5^"+seloption+"^"+yearselect+"^"+strValue+"^"+cma+"^"+page);
					// SQLParser.getSqlQuery("com_fin_sensitive_select5^"+seloption+"^"+cma+"^"+yearselect+"^"+strValue);
					//						
					// if(rs1 != null)
					// {
					// rs1.close();
					// }
					//						
					// rs1=DBUtils.executeQuery(strQuery);
					// while (rs1.next())
					// {
					// vecVal.add(correctNull(rs1.getString("txtvalue")));
					// vecid.add(correctNull(rs1.getString("fin_rowid")));
					// vecPercent.add(correctNull(rs1.getString("fin_stress_percent")));
					// hshValues.put("year"+k,vecVal);
					// hshValues.put("vecid"+k,vecid);
					// if(k==1)
					// hshValues.put("vecPercent"+k,vecPercent);
					// }
					// if(rs1!=null)
					// {
					// rs1.close();
					// }
					// vecrec.add(yearselect);
					// vecrec.add(seloption);
					// }
					//
					// }
					// }
					// }
					// } //
				}
			}

			hshValues.put("from", Integer.toString(from));

			/*
			 * //added by balaji and shanmugam for get the Next and Previous
			 * anchor bellow the page if(i == 0 || i <=4) {
			 * hshValues.put("totalyear"
			 * ,correctNull((String)hshRequestValues.get("totvalue"))+""); }
			 * else {
			 */
			// hshValues.put("totalyear",correctNull((String)hshRequestValues.get("totvalue"))+"");
			hshValues.put("totalyear", i + "");
			// hshValues.put("totalyear","8");
			// }

			hshValues.put("upto", p + "");
			// hshValues.put("value",vecyear);
			hshValues.put("yearvalue", vecrec);
			hshValues.put("page", page);

			// checking for the values in the com_finappvalues table
			strQuery = SQLParser.getSqlQuery("com_finappvaluesselect^"
					+ strValue + "^0");
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshValues.put("findata", "true");
			} else {
				hshValues.put("findata", "false");
			}

			//
			/*
			 * if(rs!=null) rs.close(); String baseyear_query =
			 * SQLParser.getSqlQuery("com_selfinancial_baseyear^"+strValue); rs
			 * = DBUtils.executeQuery(baseyear_query); if(rs.next()) {
			 * hshValues.
			 * put("com_baseyear",Helper.correctNull((String)rs.getString
			 * ("com_baseyear")));
			 * 
			 * }
			 */

			strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"
					+ strValue + "^" + "STRESS" + "^0");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("notes", correctNull(Helper.CLOBToString(rs
						.getClob("notes"))));
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getSensitiveData   "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		hshValues.put("strAction", strAction);
		return hshValues;
	}

	public void updateSensitiveData(HashMap hsh)  {

		ResultSet rs = null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String year1 = "", year2 = "", year3 = "", year4 = "";
		String c1year = "", c2year = "", c3year = "", c4year = "";
		String strRowCol1 = "", strRowCol2 = "", strRowCol3 = "", strRowCol4 = "";

		int intUpdatesize = 0, intValue = 0;
		String test = Integer.toString(intValue);
		String[] id = null;
		String appno = "";
		String[] strType = null;
		int idlen = 0;
		try {
			appno = (String) hsh.get("appno");
			if (hsh.get("id") instanceof java.lang.String) {
				id = new String[1];
				id[0] = Helper.correctNull((String) hsh.get("id"));
			} else {
				id = (String[]) hsh.get("id");
			}
			if (id != null)
				idlen = id.length;

			if (hsh.get("type") instanceof java.lang.String) {
				strType = new String[1];
				strType[0] = Helper.correctNull((String) hsh.get("type"));
			} else {
				strType = (String[]) hsh.get("type");
			}

			year1 = correctNull((String) hsh.get("txtyear1"));
			year2 = correctNull((String) hsh.get("txtyear2"));
			year3 = correctNull((String) hsh.get("txtyear3"));
			year4 = correctNull((String) hsh.get("txtyear4"));

			c1year = correctNull((String) hsh.get("combo1"));
			c2year = correctNull((String) hsh.get("combo2"));
			c3year = correctNull((String) hsh.get("combo3"));
			c4year = correctNull((String) hsh.get("combo4"));

			int x = 0;
			/** update financial check for sensitive analysis */
			// String
			// BaseYearFlag=Helper.correctNull((String)hsh.get("BaseYearFlag"));
			//		
			// if(BaseYearFlag.equalsIgnoreCase("true"))
			// {
			// String base_year="";
			// String
			// base_value=Helper.correctNull((String)hsh.get("year_choose"));
			// if(base_value.equals("b1"))
			// base_year=correctNull((String)hsh.get("txtyear1"));
			// else if(base_value.equals("b2"))
			// base_year=correctNull((String)hsh.get("txtyear2"));
			// else if(base_value.equals("b3"))
			// base_year=correctNull((String)hsh.get("txtyear3"));
			// else if(base_value.equals("b4"))
			// base_year=correctNull((String)hsh.get("txtyear4"));
			//	
			// hshQuery = new HashMap();
			// arrValues=new ArrayList();
			// hshQuery.put("strQueryId","com_delfinancial_baseyear");
			// arrValues.add(appno);
			// hshQuery.put("arrValues",arrValues);
			// hshQueryValues.put("size","1");
			// hshQueryValues.put("1",hshQuery);
			//		
			// hshQuery = new HashMap();
			// arrValues=new ArrayList();
			// hshQuery.put("strQueryId","com_insfinancial_baseyear");
			// arrValues.add(appno);
			// arrValues.add(base_year);
			// hshQuery.put("arrValues",arrValues);
			// hshQueryValues.put("size","2");
			// hshQueryValues.put("2",hshQuery);
			//		
			// EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			// }
			/*
			 * hshQuery = new HashMap(); arrValues=new ArrayList();
			 * hshQuery.put("strQueryId","com_updfinancial_baseyear");
			 * arrValues.add("N"); arrValues.add(appno);
			 * hshQuery.put("arrValues",arrValues);
			 * hshQueryValues.put("size","1"); hshQueryValues.put("1",hshQuery);
			 */

			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "executive_finnotes_del");
			arrValues.add(appno);
			arrValues.add("STRESS");
			arrValues.add("0");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);

			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "executive_finnotes_ins");
			arrValues.add(appno);
			arrValues.add("STRESS");
			arrValues.add("0");
			arrValues.add(Helper.correctNull((String) hsh
					.get("txt_sensitivecomments")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "2");
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
			/**
			 * ----------------------------End----------------------------------
			 * --------------------
			 */

			for (int i = 0; i < idlen; i++) {

				String y = correctNull(id[i]);
				x = Integer.parseInt(y);
				if (strType[i].equalsIgnoreCase("I")) {
					String temp = correctNull((String) hsh.get("desc" + x));

					if (!temp.equals("")) {
						hshQueryValues = new HashMap();
						intUpdatesize = 0;
						strQuery = SQLParser.getSqlQuery("com_finappdesccount^"
								+ appno + '^' + x);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "com_finappdescup");
							arrValues.add(correctNull((String) hsh.get("desc"
									+ x)));
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
						} else {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "com_finappdescins");
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							arrValues.add(correctNull((String) hsh.get("desc"
									+ x)));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}

				}// for first if

				strRowCol1 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c1"));
				strRowCol2 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c2"));
				strRowCol3 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c3"));
				strRowCol4 = Helper.correctDouble((String) hsh.get("row" + x
						+ "c4"));

				String strTemp = "";
				strTemp = strType[i];
				String tempDesc = correctNull((String) hsh.get("desc" + x));
				hshQueryValues = new HashMap();
				intUpdatesize = 0;

				if (!year1.equals("") && !c1year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {

						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year1 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {

								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(year1);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol1);// get values from
															// Rowcal field
								arrValues.add(Helper.correctDouble((String) hsh
										.get("row" + id[i])));
								arrValues.add(year1);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}

					} else {

						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year1 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c1year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							arrValues.add(test);// get values from Rowcal field
							arrValues.add(test);
							arrValues.add(year1);
							arrValues.add("0");
							arrValues.add(correctNull(id[i]));
							arrValues.add(appno);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}

				}

				hshQueryValues = new HashMap();
				intUpdatesize = 0;

				if (!year2.equals("") && !c2year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {

						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year2 + '^' + x + "^0");
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {
								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year2);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {
								arrValues.add(strRowCol2);// get values from
															// Rowcal field
								arrValues.add(Helper.correctDouble((String) hsh
										.get("row" + id[i])));
								arrValues.add(year2);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}

					} else {
						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year2 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c2year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							arrValues.add(test);// get values from Rowcal field
							arrValues.add(test);
							arrValues.add(year2);
							arrValues.add("0");
							arrValues.add(correctNull(id[i]));
							arrValues.add(appno);

							hshQuery.put("arrValues", arrValues);

							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}
				}

				hshQueryValues = new HashMap();
				intUpdatesize = 0;

				if (!year3.equals("") && !c3year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year3 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup5");
							}
							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {

								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year3);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);

							} else {

								arrValues.add(strRowCol3);// get values from
															// Rowcal field
								arrValues.add(Helper.correctDouble((String) hsh
										.get("row" + id[i])));
								arrValues.add(year3);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}

					} else {
						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year3 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}
							if (c3year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup5");
							}

							arrValues.add(test);// get values from Rowcal field
							arrValues.add(test);
							arrValues.add(year3);
							arrValues.add("0");
							arrValues.add(correctNull(id[i]));
							arrValues.add(appno);

							hshQuery.put("arrValues", arrValues);

							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}

				}

				hshQueryValues = new HashMap();
				intUpdatesize = 0;

				if (!year4.equals("") && !c4year.trim().equals("")) {
					if (!strType[i].equalsIgnoreCase("C")
							&& !strType[i].equalsIgnoreCase("H")) {
						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year4 + '^' + x + "^0");

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {

							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							if (strTemp.equalsIgnoreCase("I")
									&& tempDesc.equals("")) {

								arrValues.add(test);// get values from Rowcal
													// field
								arrValues.add(test);
								arrValues.add(year4);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							} else {

								arrValues.add(strRowCol4);// get values from
															// Rowcal field
								arrValues.add(Helper.correctDouble((String) hsh
										.get("row" + id[i])));
								arrValues.add(year4);
								arrValues.add("0");
								arrValues.add(correctNull(id[i]));
								arrValues.add(appno);

								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
							}

							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");

						}

					} else {
						strQuery = SQLParser
								.getSqlQuery("com_finappvaluescount^" + appno
										+ '^' + year4 + '^' + x + "^0");
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);

						if (rs.next()) {
							hshQueryValues = new HashMap();
							intUpdatesize = 0;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;

							if (c4year.trim().equalsIgnoreCase("p")) {
								hshQuery.put("strQueryId",
										"com_sensitive_finappvaluesup4");
							}

							arrValues.add(test);// get values from Rowcal field
							arrValues.add(test);
							arrValues.add(year4);
							arrValues.add("0");
							arrValues.add(correctNull(id[i]));
							arrValues.add(appno);

							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}

					}

				}

			} // for loop

		} catch (Exception e) {
			log.error("in bean" + e);
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}

	/**
	 * Purpose: storing financial values for sensitive analysis By Venugopal
	 * 
	 * @Date:01/07/2010
	 * 
	 */
	public HashMap updateSensitiveFinancialData(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		HashMap hshValues = null;
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strQuery = "", strValue = "";
		String sumprojection = "";
		int intUpdatesize = 0;

		try {

			strValue = correctNull((String) hshRequestValues.get("appno"));
			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecid = new ArrayList();

			// --------------- to find the cma format of the particular
			// applications-------

			String cma = "";
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
				cma = correctNull(rs.getString("demo_finstandard"));

			String yearselect = "", givenyear = "";
			int k = 0, i = 0;
			int from = 0, p = 0;
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			strQuery = SQLParser.getSqlQuery("com_finYearSel^" + strValue
					+ "^0");
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));

				if (!yearselect.equals("")) {
					String strQuery10 = SQLParser
							.getSqlQuery("com_assessselect9^" + strValue
									+ "^0^" + yearselect);
					if (rs10 != null)
						rs10.close();
					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumprojection = Helper.correctDouble(rs10
								.getString("fin_stress_projection"));
					}

					if ((Double.parseDouble(sumprojection)) > 0) {
						vecVal = new ArrayList();
						vecid = new ArrayList();
						i = i + 1;
						if ((i >= from) && (k < 4)) {
							p = i;
							k = k + 1;
							strQuery = SQLParser
									.getSqlQuery("com_sensitive_update_finselect5^"
											+ cma
											+ "^"
											+ yearselect
											+ "^0^"
											+ strValue);
							if (rs1 != null)
								rs1.close();

							rs1 = DBUtils.executeQuery(strQuery);
							while (rs1.next()) {
								desc = "s";// that means "fin_stress_projection"
											// column
								int formuladesc = 0;
								String fin_rowid = "";
								formuladesc = (rs1.getInt("formula"));
								fin_rowid = Helper.correctNull(rs1
										.getString("fin_rowid"));
								if (formuladesc > 0) {
									HashMap hshformula = new HashMap();
									hshformula.put("appno", strValue);
									hshformula.put("formulaid", Integer
											.toString(formuladesc));
									hshformula.put("curryear", yearselect);
									hshformula.put("prevyear", " ");
									hshformula.put("currfinancialtype", desc);
									hshformula.put("prevfinancialtype", "a");
									hshformula.put("internalcalc", "N");
									hshformula.put("hshdata", new HashMap());
									HashMap hshRes = (HashMap) EJBInvoker
											.executeStateLess("comformula",
													hshformula, "GetFinValue");
									String strTotalValue = correctNull((String) hshRes
											.get("strTotalValue"));
									vecVal
											.add(correctNull((String) hshRes
													.get("strTotalValue")));
									vecid.add(correctNull(rs1
											.getString("fin_rowid")));
									/**
									 * By venu Storing financial calculated data
									 * into tables
									 */
									hshQueryValues = new HashMap();
									intUpdatesize = 0;
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize = intUpdatesize + 1;
									hshQuery.put("strQueryId",
											"com_sensitive_finappvaluesup4");
									arrValues.add(strTotalValue);// get values
																	// from
																	// Rowcal
																	// field
									arrValues.add("0");
									arrValues.add(yearselect);
									arrValues.add("0");
									arrValues.add(fin_rowid);
									arrValues.add(strValue);

									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", Integer
											.toString(intUpdatesize));
									hshQueryValues.put(Integer
											.toString(intUpdatesize), hshQuery);
									EJBInvoker.executeStateLess("dataaccess",
											hshQueryValues, "updateData");

								}
								hshValues.put("year" + k, vecVal);
								hshValues.put("vecid" + k, vecid);

							}

							if (rs1 != null)
								rs1.close();
						}
					}
				}
			}

		} catch (Exception ce) {
			throw new EJBException("Error in updateSensitiveFinancialData"
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshValues;

	}

	public HashMap getBenchMarkParam(HashMap hshValues)  {
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null;
		ResultSet rs1 = null;

		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecRec = new ArrayList();
		HashMap hshRes = new HashMap();
		String strQuery = "";
		String strValue = "";
		String formuladesc = "",strDemoAPPID="0";
		String desc = "a";
		String ManualEntry ="";
		HashMap hshBenchparam = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			strValue = Helper.correctNull((String) hshValues.get("comapp_id"));
			if (strValue.equalsIgnoreCase("")) {
				strValue = Helper.correctNull((String) hshValues.get("appno"));
			}
			// Added by Kishan
			String strFinID = "0";
			String cma = "0";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctNull((String) rs
						.getString("DEMO_FINSTANDARD"));
				
				strDemoAPPID=Helper.correctInt(rs.getString("DEMO_COMAPPID"));
				if (!strFinID.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ strFinID);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						cma = Helper.correctNull((String) rs
								.getString("FIN_CMANO"));
					}
				}
			}
			// --------------- to find the cma format of the particular
			// applications-------

			String cma_amtval = "";
			/*strQuery = SQLParser.getSqlQuery("com_applications_value_sel^"
					+ strValue);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				cma_amtval = rs.getString("app_valuesin");
				if (cma_amtval.equalsIgnoreCase("L")) {
					cma_amtval = "Lacs";
				}
				if (cma_amtval.equalsIgnoreCase("C")) {
					cma_amtval = "Crores";
				}
				if (cma_amtval.equalsIgnoreCase("R")) {
					cma_amtval = "Rs.";
				}
			}*/
			
			if (!strFinID.equals("")) {
			rs	= DBUtils.executeLAPSQuery("comfinance_finappid^"+strFinID);
			if(rs.next())
			{
				cma_amtval	= correctNull(rs.getString("fin_valuesarein"));
				if (cma_amtval.equalsIgnoreCase("L")) {
					cma_amtval = "Lacs";
				}
				if (cma_amtval.equalsIgnoreCase("C")) {
					cma_amtval = "Crores";
				}
				if (cma_amtval.equalsIgnoreCase("R")) {
					cma_amtval = "Rs.";
				}
			}
			}

			/*
			 * strQuery = SQLParser.getSqlQuery("com_demographics_cma_sel^" +
			 * strValue); rs = DBUtils.executeQuery(strQuery); while (rs.next())
			 * { cma = rs.getString("demo_finstandard"); }
			 */
			hshRecord.put("cma_amtval", cma_amtval);
			String yearselect = "";

			/** Take last audited year in Bench Mark Ratio */
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("com_finappvalues_audit_select^"
					+ strFinID + "^<=^<");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				yearselect = correctNull((String) rs.getString("audityear"));
			} else {
				yearselect = "";
			}
			if (rs1 != null)
				rs1.close();

			String strDSCRYear = null;
			rs = DBUtils.executeLAPSQuery("com_benchmarkrows^" + strValue + "^"
					+ cma);
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("BENCH_ROWID")));
				vecRec.add(correctNull(rs.getString("BENCH_CMANO")));
				vecRec.add(correctNull(rs.getString("BENCH_ROWDESC")));
				if (Helper.correctNull(rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("CRR")) 
					vecRec.add("KB"+correctNull(rs.getString("BENCH_POLICY")));
				else
					vecRec.add(correctNull(rs.getString("BENCH_POLICY")));
				vecRec.add(correctNull(rs.getString("BENCH_DEPENDSON")));
				formuladesc = (correctNull(rs.getString("BENCH_FORMULA")));

				if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("FI")) {
					if (!yearselect.trim().equalsIgnoreCase("")) {
						
						HashMap hshFinYearVal = new HashMap();
						hshFinYearVal.put("appno", strValue);
						hshFinYearVal.put("strFinID", strFinID);
						hshFinYearVal.put("comappid", Helper.correctNull((String) hshValues.get("comapp_id")));
						
						hshFinYearVal = getFinValues(hshFinYearVal);
						
						HashMap hshformula = new HashMap();
						hshformula.put("appno", strValue);
						hshformula.put("strFinID", strFinID);
						hshformula.put("formulaid", formuladesc);
						hshformula.put("curryear", yearselect);
						hshformula.put("prevyear", "");
						hshformula.put("currfinancialtype", desc);
						hshformula.put("prevfinancialtype", "a");
						hshformula.put("internalcalc", "N");
						hshformula.put("hshdata", new HashMap());
						hshformula.put("hshFinYearVal", hshFinYearVal);
						
						hshRes = (HashMap) EJBInvoker.executeStateLess(
								"comformula", hshformula, "GetFinValue");
						vecRec.add(Helper.correctNull((String) hshRes
								.get("strTotalValue")));
					} else {
						vecRec.add("0.00");
					}
				} else if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("DSCR")) {
					vecRec.add("0.00");
				}
				else if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("PCOV")) {
					
					double dblExposure=0.0,dblPrimeVal=0.0;
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_appproposedExposure^"+strValue+"^"+strDemoAPPID);
					if(rs1.next())
					{
						dblExposure=Double.parseDouble(Helper.correctDouble(rs1.getString("ProposedExp")));
					}
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("select_securityvalue^"+strValue+"^1");
					if(rs1.next())
					{
						dblPrimeVal=Double.parseDouble(Helper.correctDouble(rs1.getString("secvalue")));
					}
					
					if(dblExposure!=0)
					{
						vecRec.add(jtn.format(dblPrimeVal/dblExposure));
					}
					else
					{
						vecRec.add("0.00");
					}
				}
				else if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("CRR")) {
					
					/*if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_creditRatingType^"+strValue);
					if(rs1.next())
					{
						vecRec.add(Helper.correctNull(rs1.getString("cre_weight")));
					}
					else
					{
						vecRec.add("");
					}*/
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_digi_rate_score^"+strValue);
					if(rs1.next())
					{
						vecRec.add(Helper.correctNull(rs1.getString("KB_RATING")));
					}
					else
						vecRec.add("");
				}
				
				
				else if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("PTL")) {
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_TLfacmonths^"+strValue);
					if(rs1.next())
					{
						vecRec.add(Helper.correctInt(rs1.getString("facility_fmonths")));
					}
					else
					{
						vecRec.add("0");
					}
				}
				else if (Helper.correctNull(rs.getString("BENCH_DEPENDSON"))
						.equalsIgnoreCase("M")) {
					
					vecRec.add(Helper.correctNull(rs.getString("BENCH_DEPENDSON")));
				}

				else {
					vecRec.add("0.00");
				}

				vecRec.add(correctNull(rs
						.getString("BENCHMARK_FINVALUES_STATUS")));
				vecRec.add(correctNull(rs
						.getString("BENCHMARK_FINVALUES_ACTUAL")));
				vecData.add(vecRec);
			}

			hshRecord.put("vecData", vecData);

		} catch (Exception e) {
			throw new EJBException(e.getMessage());
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

	public void updateBenchMarkParam(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		ResultSet rs = null,rs1 = null,rs2 = null;
		String[] strStatus = null;
		String[] strId = null;
		String[] strActual= null;
		String appno = "";
		try {
			appno = Helper.correctNull((String) hshValues.get("appno"));
			// Added by Kishan
			/*
			 * String strFinID = "0"; String cma="0"; String strQuery =
			 * SQLParser.getSqlQuery("sel_financeid^"+appno); rs =
			 * DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * strFinID=Helper.correctNull
			 * ((String)rs.getString("DEMO_FINSTANDARD"));
			 * if(!strFinID.equals("")) { strQuery =
			 * SQLParser.getSqlQuery("fin_cmano_select^"+strFinID); rs =
			 * DBUtils.executeQuery(strQuery); if(rs.next()) { cma =
			 * Helper.correctNull((String)rs.getString("FIN_CMANO")); } } }
			 */
			if (hshValues.get("txt_status") instanceof java.lang.String) {
				strStatus = new String[1];
				strStatus[0] = (String) hshValues.get("txt_status");
			} else {
				strStatus = (String[]) hshValues.get("txt_status");
			}
			if (hshValues.get("txt_id") instanceof java.lang.String) {
				strId = new String[1];
				strId[0] = (String) hshValues.get("txt_id");
			} else {
				strId = (String[]) hshValues.get("txt_id");
			}
			if (hshValues.get("txt_Actual") instanceof java.lang.String) {
				strActual = new String[1];
				strActual[0] = (String) hshValues.get("txt_Actual");
			} else {
				strActual = (String[]) hshValues.get("txt_Actual");
			}
			int len = strStatus.length;
			if (strAction.equals("Insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "com_benchvalues_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				for (int k = 0; k < len; k++) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "com_benchvalues_ins");
					arrValues.add(appno);
					arrValues.add(strId[k]);
					arrValues.add(strStatus[k]);
					arrValues.add(strActual[k]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");}
				}
				else if (strAction.equals("Delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "com_benchvalues_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException("inside updateBenchMarkParam"
					+ ce.toString());
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
	}

	public HashMap getAnnexureIX(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		int str = 0, tabcnt = 0, l = 0;
		String sumaudit = "";
		String sumunaudit = "";
		String sumestimated = "";
		String sumprojection = "";
		String sel_divID = "";
		String pagetab = "";
		String base_year = "";
		String strAction = "";
		String fintype = null;
		String chk1 = "", chk2 = "", chk3 = "", chk4 = "", chk5 = "";
		String finance_id = "";
		try {

			strValue = correctNull((String) hshRequestValues.get("appno"));
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}

			String page = correctNull((String) hshRequestValues.get("pageval"));
			String printtype = correctNull((String) hshRequestValues
					.get("printtype"));
			String strFormat = correctNull((String) hshRequestValues
					.get("strFormat"));
			pagetab = Helper.correctNull(page);

			rs = null;

			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			hshValues.put("sel_divID", sel_divID);

			// Retreving of values for project input

			String cma = "0";
			log.info((String) hshRequestValues.get("cattype"));
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + strValue);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				// cma=Helper.correctInt(rs.getString("demo_finstandard"));
				fintype = Helper.correctNull((String) rs
						.getString("demo_finmodel"));
			}

			if (rs != null) {
				rs.close();
			}
			if (!strValue.equals("")) {
				if (finance_id.equals("")) {
					String query1 = SQLParser
							.getSqlQuery("comdemographics_sel^" + strValue);
					rs = DBUtils.executeQuery(query1);

					if (rs.next()) {
						finance_id = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
						strValue = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
					}
				}
			}
			if (cma.equalsIgnoreCase("0")) {
				if (rs != null) {
					rs.close();
				}

				if (!strValue.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ strValue);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}
			strQuery = SQLParser.getSqlQuery("finselect1^" + strValue + "^"
					+ sel_divID);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				str = rs.getInt("cnt");
			}

			// --------------- to select label depending upon existence of
			// application
			String tempsno = "";
			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2^" + cma + "^"
						+ page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);
					vecVal.add(vecRec);
				}

				hshValues.put("labeldetails", vecVal);

			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				strQuery = SQLParser.getSqlQuery("finselect3z^" + cma + "^"
						+ page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));

					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);

					vecVal.add(vecRec);
				}

				hshValues.put("labeldetails", vecVal);

			}

			hshValues.put("count", Integer.toString(str));

			String yearselect = "", seloption = "", givenyear = "";
			int i = 0;
			int k = 0;
			int from = 0, p = 0, tt = 0;

			ArrayList vecrec = new ArrayList();
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[6];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";

			// /strQuery =
			// SQLParser.getSqlQuery("finYearSel^"+strValue+"^"+sel_divID);
			// /rs=DBUtils.executeQuery(strQuery);
			// ArrayList arryvall=new ArrayList();

			int kk = 0;
			// / while(rs.next())
			// / {
			// / arryvall.add(Helper.correctNull(rs.getString("fin_year")));

			// }
			// this code has been commented by balaji & shanmugam for get all
			// the year for all the sub tags
			// and new line has been added bellow
			String sno = "0";
			if (strFormat.equalsIgnoreCase("EAN9")) {
				strQuery = SQLParser.getSqlQuery("sel_annexprojectyear^"
						+ strValue + "^" + sel_divID);
			}
			else if (strFormat.equalsIgnoreCase("EAN4")) {
				strQuery = SQLParser.getSqlQuery("sel_annexauditedyear^"
						+ strValue + "^" + sel_divID);
			}
			else if (strFormat.equalsIgnoreCase("EAN10")) {
				strQuery = SQLParser.getSqlQuery("sel_annexfindetails^"
						+ strValue + "^" + sel_divID);
			}
			else if (!printtype.equalsIgnoreCase("Y1")) {
				strQuery = SQLParser.getSqlQuery("sel_annexprojectyear^"
						+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser.getSqlQuery("sel_annexauditedyear^"
						+ strValue + "^" + sel_divID);
			}

			if (rs != null) {
				rs.close();
			}
			int o = 1;
			int t = 1;
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";
				vecVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				sno = (String) Helper.correctNull(rs.getString("com_sno"));
				if (!yearselect.equals("")) {
					if (rs3 != null) {
						rs3.close();
					}

					String strQuery10 = SQLParser.getSqlQuery("assessselect9^"
							+ strValue + "^" + sel_divID + "^" + yearselect
							+ "^" + sno);
					if (rs10 != null) {
						rs10.close();
					}

					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumaudit = Helper.correctDouble(rs10
								.getString("sumaudit"));
						sumunaudit = Helper.correctDouble(rs10
								.getString("sumunaudit"));
						sumestimated = Helper.correctDouble(rs10
								.getString("sumestimated"));
						sumprojection = Helper.correctDouble(rs10
								.getString("sumprojection"));
					}
					if (valarray[0].equals("0") && !sumaudit.equals("0")) {
						valarray[0] = "fin_audit";
					}
					if (valarray[1].equals("0") && !sumunaudit.equals("0")) {
						valarray[1] = "fin_unaudit";
					}
					if (valarray[2].equals("0") && !sumestimated.equals("0")) {
						valarray[2] = "fin_estimated";
					}
					if (valarray[3].equals("0") && !sumprojection.equals("0")) {
						valarray[3] = "fin_projection";
					}
					if (valarray[4].equals("0") && !sumprojection.equals("0")) {
						valarray[4] = "fin_projection";
					}

					if (rs10 != null) {
						rs10.close();
					}

					for (int h = 0; h < 4; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0.00";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							if (i >= from) {
								p = i;
								k = k + 1;
								hshValues.put("sno" + (o++), sno);
								strQuery = SQLParser.getSqlQuery("finselect5^"
										+ seloption + "^" + yearselect + "^" + strValue
										+ "^" + sel_divID + "^" + sno
										+ "^" + cma + "^" + page);


								if (rs1 != null) {
									rs1.close();
								}
								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {

									vecVal.add(correctNull(rs1
											.getString("txtvalue")));
									vecid.add(correctNull(rs1
											.getString("fin_rowid")));
									// }

									hshValues.put("year" + k, vecVal);
									hshValues.put("vecid" + k, vecid);
								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
								strQuery = SQLParser
										.getSqlQuery("com_selfinancial_printyear^"
												+ sno + "^" + strValue);
								if (rs1 != null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) {

									hshValues
											.put(
													"checkcol" + (t++),
													Helper
															.correctNull((String) rs1
																	.getString("FINPRINTYEAR_SELSNO")));

								} else {
									t++;
								}
							}

						}
					}
				}
			}

			hshValues.put("from", Integer.toString(from));

			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("page", page);
			// hshValues.put("IRBUpload",hidUpload);
			// hshValues.put("Freeze", hidFreeze);

			// checking for the values in the com_finappvalues table
			/*
			 * strQuery =
			 * SQLParser.getSqlQuery("com_finappvaluessel^"+strValue+"^"
			 * +sel_divID); rs = DBUtils.executeQuery(strQuery);
			 * 
			 * if(rs.next()) { hshValues.put("findata","true"); } else {
			 * hshValues.put("findata","false"); }
			 */

		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getData login  " + ce.toString());

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		hshValues.put("tabname", pagetab);
		hshValues.put("strAction", strAction);
		hshValues.put("fintype", fintype);
		return hshValues;
	}

	public void updateFreezeData(HashMap hshValues)  {
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		String strQuery = "", strAction = "", strNewFinID = "", strOldFinID = "", strAppId = "";
		ResultSet rs = null;
		String fincount = "";
		String strExp = "$";
		int cmano = 0;
		int finance_id = 0;
		Connection connectDB = null;
		CallableStatement callableStmt = null;
		String strappid = "";

		try {
			String strAppno = correctNull((String) hshValues
					.get("hidfinanceid"));
			strAction = correctNull((String) hshValues.get("hidAction"));

			strappid = correctNull((String) hshValues.get("hid_appid"));
			if (strAction.equalsIgnoreCase("freeze")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strAppno);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {

					hshQuery = new HashMap();
					arrValues = new ArrayList();

					hshQuery.put("strQueryId", "comfinance_freeze_update");
					arrValues.add("Y");

					arrValues.add(strAppno);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("Undo")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strAppno);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {

					hshQuery = new HashMap();
					arrValues = new ArrayList();

					hshQuery.put("strQueryId", "comfinance_freeze_update_undo");
					arrValues.add("N");
					arrValues.add("");

					arrValues.add(strAppno);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			if (strAction.equalsIgnoreCase("renew")) {
				strQuery = SQLParser.getSqlQuery("maxfinanceid^" + strAppno);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strNewFinID = (Helper.correctNull(rs
							.getString("fin_financeid")));
				}

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				
				hshQuery.put("strQueryId", "comdemographicsfinancialrenew");
				
				arrValues.add(strNewFinID);
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				connectDB = ConnectionFactory.getConnection();
				callableStmt = connectDB
						.prepareCall("call PROC_FIN_RENEW(?,?,?)");
				callableStmt.setString(1, correctNull(strNewFinID));
				callableStmt.setString(2, correctNull(strAppno));
				callableStmt.setString(3, correctNull(strAppId));
				callableStmt.execute();
				callableStmt.clearParameters();
			}
		} catch (Exception cf) {
			throw new EJBException("Error in updateFreezeData:  "
					+ cf.getMessage());
		}
	}

	public HashMap getFinValues(HashMap hshRequestValues)  {
		ResultSet rs = null, rs1 = null;
		String strQuery = "", strAppno = "", strComAppId = "", strYear = "", strSno = "";
		String strFinID = "0";
		HashMap hshFinTxtVal = new HashMap();
		HashMap hshFinYearVal = new HashMap();

		try {
			strAppno = correctNull((String) hshRequestValues.get("appno"));
			strFinID = Helper.correctInt((String) hshRequestValues.get("strFinID"));
			strComAppId = Helper.correctInt((String) hshRequestValues
					.get("comappid"));

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("finYearSel^" + strFinID + "^"
					+ strComAppId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshFinTxtVal = new HashMap();
				strYear = correctNull(rs.getString("fin_year"));
				strSno = correctNull(rs.getString("fin_sno"));
				if (!strYear.equals("")) {
					String strQuery10 = SQLParser.getSqlQuery("sel_FinTxtVal^"
							+ strFinID + "^" + strComAppId + "^" + strYear
							+ "^" + strSno);

					if (rs1 != null) {
						rs1.close();
					}
					rs1 = DBUtils.executeQuery(strQuery10);
					while (rs1.next()) {
						hshFinTxtVal
								.put(correctNull(rs1.getString("fin_rowid")),
										Helper.correctDouble(rs1
												.getString("txtval")));
					}
					hshFinYearVal.put(strYear, hshFinTxtVal);
				}
			}
		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getFinValues : " + ce.toString());

		} finally {
			try {
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshFinYearVal;
	}

	public HashMap getCMAType(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs2 = null;
		HashMap hshValues = new HashMap();
		try {
			String strValue = "";
			String sel_divID = "";
			String strQuery = "";
			String attach_flag = "false";
			String str_finance_id = "";
			String strQuery1 = "", strQuery2 = "", strQuery4 = "";
			strValue = correctNull((String) hshRequestValues.get("appid"));
			if (strValue.equals("")) {
				strValue = correctNull((String) hshRequestValues
						.get("hidppid_value"));
			}
			if (sel_divID.equals("")) {
				sel_divID = "0";
			}
			// to get the cma format for particular appid
			String cma = "";
			if (!strValue.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("comfinance_appid^" + strValue);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					cma = correctNull(rs.getString("fin_cmano"));

				}
			}
			// to get the values of CMA Format of particular appid

			ArrayList arrcmavalcma = new ArrayList();
			ArrayList arrcmavalRowdesc = new ArrayList();
			ArrayList arrcmavalRowdate = new ArrayList();
			ArrayList arrcmavalfinanceid = new ArrayList();
			if (!cma.equals("")) {

				strQuery = SQLParser.getSqlQuery("finselect_cma_appid^"
						+ strValue);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				int row_count = 0;

				while (rs.next()) {
					attach_flag = "true";
					row_count = row_count + 1;

					arrcmavalcma.add(Helper.correctNull(((String) rs
							.getString("fin_cmano"))));// 1
					String cmano = Helper.correctNull(((String) rs
							.getString("fin_cmano")));
					if (!cmano.equals("")) {

						strQuery1 = SQLParser.getSqlQuery("com_cma_master^"
								+ cmano);
						if (rs1 != null) {
							rs1.close();
						}
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							arrcmavalRowdesc.add(Helper
									.correctNull((String) rs1
											.getString("cma_format_desc")));// 2

						}
					}

					arrcmavalRowdate.add(Helper.correctNull(((String) rs
							.getString("fin_freezedate"))));// 3
					arrcmavalfinanceid.add(Helper.correctNull(((String) rs
							.getString("fin_financeid"))));// 4

				}

				// to check whether any data without audited

				strQuery = SQLParser.getSqlQuery("finselect_cma_appid_freeze^"
						+ strValue);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				row_count = 0;

				while (rs.next()) {
					attach_flag = "true";
					row_count = row_count + 1;
					String sum_audit = "";
					String corp_fin_year = "";
					String other_flag = "false";

					str_finance_id = Helper.correctNull(((String) rs
							.getString("fin_financeid")));
					strQuery4 = SQLParser
							.getSqlQuery("corp_app_financials_select_distinctyear^"
									+ str_finance_id + "^" + sel_divID);

					if (rs2 != null) {
						rs2.close();
					}
					rs2 = DBUtils.executeQuery(strQuery4);
					while (rs2.next()) {
						corp_fin_year = Helper.correctNull(((String) rs2
								.getString("fin_year")));
						strQuery2 = SQLParser.getSqlQuery("com_assessselect9^"
								+ str_finance_id + "^" + sel_divID + '^'
								+ corp_fin_year);

						if (rs3 != null) {
							rs3.close();
						}
						rs3 = DBUtils.executeQuery(strQuery2);
						if (rs3.next()) {
							sum_audit = Helper.correctNull(((String) rs3
									.getString("sumaudit")));
							if (!sum_audit.equals(("0"))) {
								other_flag = "true";
							}

						}

					}

					if (other_flag.equals("false")) {
						arrcmavalcma.add(Helper.correctNull(((String) rs
								.getString("fin_cmano"))));// 1
						String cmano = Helper.correctNull(((String) rs
								.getString("fin_cmano")));
						if (!cmano.equals("")) {

							strQuery1 = SQLParser.getSqlQuery("com_cma_master^"
									+ cmano);
							if (rs1 != null) {
								rs1.close();
							}
							rs1 = DBUtils.executeQuery(strQuery1);
							if (rs1.next()) {
								arrcmavalRowdesc.add(Helper
										.correctNull((String) rs1
												.getString("cma_format_desc")));// 2

							}
						}

						arrcmavalRowdate.add(Helper.correctNull(((String) rs
								.getString("fin_freezedate"))));// 3
						arrcmavalfinanceid.add(Helper.correctNull(((String) rs
								.getString("fin_financeid"))));// 4

					}
				}
			}

			hshValues.put("arrcmavalcma", arrcmavalcma);
			hshValues.put("arrcmavalRowdesc", arrcmavalRowdesc);
			hshValues.put("arrcmavalRowdate", arrcmavalRowdate);
			hshValues.put("arrcmavalfinanceid", arrcmavalfinanceid);
			hshValues.put("newattach_flag", attach_flag);
		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getFinValues : " + ce.toString());

		} finally {
			try {
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshValues;
	}

	public HashMap updateAttachData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strQuery = "";
		String appno = "";
		try {
			FinancialBean fOb = new FinancialBean();
			String strAppno = correctNull((String) hshValues.get("hidappid"));
			String cma = correctNull((String) hshValues.get("hidcmasno"));
			String financeid = correctNull((String) hshValues.get("hidfinance"));
			ArrayList arrvalues = new ArrayList();

			if (strAppno.equals("")) {

				strAppno = correctNull((String) hshValues.get("hidapplicantid"));
			}

			if (cma.equals("")) {

				cma = correctNull((String) hshValues.get("cmasno"));
			}
			// to update the application value to particular appid
			appno = correctNull((String) hshValues.get("appno"));
			if (!cma.equals("") && !financeid.equals(""))

			{

				hshQuery = new HashMap();
				arrValues = new ArrayList();

				hshQuery.put("strQueryId", "comdemographics_update");

				arrValues.add(financeid);
				arrValues.add(appno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_management_assementAll");
				arrValues.add("salesjustify");
				arrValues.add("1");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");

			}

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
			HashMap hshResult = new HashMap();

			if (!strAppno.equals("")) {
				hshResult.put("appidnew", strAppno);

				hshResult.put("hidfinanceid", financeid);

				hshResult.put("hidcmasno", cma);

				hshResult = fOb.getData(hshResult);
			}

			Set enu = null;
			Iterator iterator = null;
			enu = hshResult.keySet();
			iterator = enu.iterator();
			while (iterator.hasNext()) {
				String strId = (String) iterator.next();
				hshRecord.put(strId, hshResult.get(strId));
			}

		}

		catch (Exception e) {
			throw new EJBException("Error in getFinancialtype..."
					+ e.toString());
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

	public HashMap updateFinRating(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshformula = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strApp = "", strAppno = "", strBorrowId = "0", strSolid = "", strAction = "", strFac_Sno = "0";
		String strBusId = "", arrSize = "", strParmType = "";
		String strCBSId = "", strNameofBor = "", strperapp_constitution = "", strbankSince = "", strBranchCode = "", strDateofBirth = "";
		int i = 0;
		String struserid = "", strRmd = "", strRatType = "1",strOrgCode="",strFirstName="",strLastName="",strAppName="",strCurryear="";
		int as = 0;
		int intCounter = 0;
		ArrayList arrValues = new ArrayList();
		try {
			strBorrowId = Helper.correctNull((String) hshValues.get("hid_appid"));
			if(strBorrowId.equalsIgnoreCase(""))
				strBorrowId=correctNull((String) hshValues.get("hidAppId"));
			strSolid = correctNull((String) hshValues.get("strSolid"));
			strBusId = correctNull((String) hshValues.get("sel_corpbusinessid"));
			strCurryear=Helper.correctNull((String)hshValues.get("sel_curryear"));
			strApp = correctNull((String) hshValues.get("hidRatAppNo"));
			arrSize = correctNull((String) hshValues.get("hidrowsize"));
			as = Integer.parseInt(Helper.correctInt(arrSize));
			strAction = correctNull((String) hshValues.get("hidAction"));
			strCBSId = correctNull((String) hshValues.get("hidCBSID"));
			struserid = correctNull((String) hshValues.get("strUserId"));
			strOrgCode=correctNull((String) hshValues.get("strOrgCode"));
			if (strBorrowId.equalsIgnoreCase("") && !strApp.equalsIgnoreCase("new")) {
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_finapplicantid^" + strApp);
				if (rs.next()) {
					strBorrowId = Helper.correctNull((String) rs
							.getString("FIN_APPID"));
				}
				if (rs != null) {
					rs.close();
				}
			}
			if (strApp.equals("new")) {
				hshformula.put("comapp_id", strBorrowId);
				hshformula.put("strSolid", strSolid);
				strAppno = (String) EJBInvoker.executeStateLess("appeditlock",
						hshformula, "getRatingAppno");
				hshValues.put("hidRatAppNo", strAppno);
			} else {
				strAppno = correctNull((String) hshValues.get("hidRatAppNo"));
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (strApp.equalsIgnoreCase("new")) {
					
					rs = DBUtils.executeLAPSQuery("sel_appliname_perapplicant^" + strBorrowId);
					if (rs.next()) {
						strFirstName = Helper.correctNull((String) rs
								.getString("perapp_fname"));
						strLastName = Helper.correctNull((String) rs
								.getString("perapp_lname"));
						strAppName=strFirstName+" "+strLastName;
						strCBSId=Helper.correctNull(rs.getString("perapp_cbsid"));
					}
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "ins_finrating");
					arrValues.add(strAppno);
					arrValues.add(strCBSId);
					arrValues.add(strBorrowId);
					arrValues.add(correctNull((String) hshValues
							.get("hidfinanceid")));
					arrValues.add(correctNull((String) hshValues
							.get("strUserId")));
					arrValues.add(strBusId);
					arrValues.add("OP");
					arrValues.add(struserid);
					arrValues.add(strAppName);
					arrValues.add(strOrgCode);
					arrValues.add(correctNull((String) hshValues
							.get("sel_partyfiledet")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
					hshQueryValues.put("size",String.valueOf(intCounter));
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","insert_appmailbox");
					arrValues.add(strAppno);
					arrValues.add(struserid);
					arrValues.add(struserid);
					arrValues.add("C");
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
					hshQueryValues.put("size",String.valueOf(intCounter));
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","upd_finratingstatus");
					arrValues.add(correctNull((String) hshValues
							.get("hidfinanceid")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
					hshQueryValues.put("size",String.valueOf(intCounter));
					
				} else {
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "upd_finrating");
					arrValues.add(strBorrowId);
					arrValues.add(correctNull((String) hshValues
							.get("hidfinanceid")));
					arrValues.add(strBusId);
					arrValues.add(correctNull((String) hshValues
							.get("sel_partyfiledet")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
					hshQueryValues.put("size",String.valueOf(intCounter));
				}

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delriskdata");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intCounter),hshQuery);
				hshQueryValues.put("size",String.valueOf(intCounter));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				
				for (i = 1; i <= as; i++) {
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "insertriskdata");
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull((String) hshValues
							.get("hid_riskparam" + i)));
					if (Helper.correctNull(
							(String) hshValues.get("hid_riskparam" + i))
							.equalsIgnoreCase("19")) {
						String strMar = Helper.correctNull((String) hshValues
								.get("txt_riskparam" + i));
						rs = DBUtils.executeLAPSQuery("selcbsiddatacode^" + "3"
								+ "^" + strMar);
						if (rs.next()) {
							arrValues.add(Helper.correctNull((String) rs
									.getString("cbs_static_data_code")));
						} else {
							arrValues.add("NA");
						}
					} else {
						arrValues.add(Helper.correctNull((String) hshValues
								.get("txt_riskparam" + i)));
					}
					arrValues.add(strFac_Sno);
					arrValues.add(strBusId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				// For current year update
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "update_curryear_null_ofr");
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "update_curryear_ofr");
	 			arrValues.add(strCurryear);	   			
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			} else if (strAction.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delriskdata");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} 
			hshRecord = (HashMap)getFinRating(hshValues);
		} catch (Exception e) {
			log.info("=======Catch block===========");
			e.printStackTrace();
		}

		finally {
			try {

			} catch (Exception cf) {
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshRecord;
	}

	public HashMap getFinRating(HashMap hshRequestValues)  {
		HashMap hshValues = new HashMap();
		ResultSet rs = null, rs1 = null;
		String cma = "0", strQuery = "", finance_id = "", appid = "", strBusRuleID = "", strNewFacSno = "0";
		ArrayList vecRec = new ArrayList();
		ArrayList vecVal = new ArrayList();
		String strLapsParams = "", strParaSeq = "", strAppno = "0", strModelCode = "";
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arRatCol = new ArrayList();
		ArrayList arRatRow = new ArrayList();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strWsResponseFlag = "";
		String struserid = "";
		String strSendFlag = "N", strTempFreezFlag = "", strsend = "";
		String strReject="";
		try {
			struserid=correctNull((String) hshRequestValues.get("strUserId"));
			finance_id = correctNull((String) hshRequestValues
					.get("hidfinanceid"));
			strSendFlag = correctNull((String) hshRequestValues
					.get("sendButtonFlag"));
			cma = Helper
					.correctNull((String) hshRequestValues.get("hidcmasno"));
			appid = correctNull((String) hshRequestValues.get("hid_appid"));
			strBusRuleID = Helper.correctInt((String) hshRequestValues
					.get("sel_corpbusinessid"));
			String strAction = correctNull((String) hshRequestValues
					.get("hidAction"));
			if (strBusRuleID.equalsIgnoreCase("0")) {
				strBusRuleID = Helper.correctInt((String) hshRequestValues
						.get("hidbussID"));
			}
			strAppno = Helper.correctNull((String) hshRequestValues
					.get("hidRatAppNo"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}

				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
						appid = Helper.correctNull((String) rs
								.getString("fin_comappid"));
					}
				}
			}
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);
			}
			rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"
					+ strBusRuleID);
			if (rs1.next()) {
				strLapsParams = Helper.correctNull((String) rs1
						.getString("rsk_rule_params"));
				strModelCode = Helper.correctNull((String) rs1
						.getString("rsk_rule_ratcode"));
				for (int i = 0; i < strLapsParams.length(); i++) {
					if (strLapsParams.substring(i, i + 1).equalsIgnoreCase("1")) {
						int j = i + 1;
						strParaSeq = strParaSeq + j + ",";

					}

				}
			}
			if (rs1 != null) {
				rs1.close();
			}
			if (!strParaSeq.equalsIgnoreCase("") && strParaSeq.contains(",")) {

				strParaSeq = strParaSeq.substring(0, strParaSeq.length() - 1);
				strQuery = SQLParser.getSqlQuery("sel_riskparam_Setup^"
						+ strParaSeq);
				rs1 = DBUtils.executeQuery(strQuery);
				arrRow = new ArrayList();
				while (rs1.next()) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String) rs1
							.getString("rsk_seqno")));// 0
					arrCol.add(Helper.correctNull((String) rs1
							.getString("rsk_paramvalue")));// 1
					arrCol.add(Helper.correctNull((String) rs1
							.getString("rsk_columnflag")));// 2
					String strSeqNo = Helper.correctNull((String) rs1
							.getString("RSK_PARAMCODE"));
					String strTL = "", strWc = "", strTlWc = "";

					if (strSeqNo.equalsIgnoreCase("EXISTING-01")) {

						arrCol.add("");// 3
					} else if (strSeqNo.equalsIgnoreCase("FOREXBOR-01")) {
						arrCol.add("");// 3
					} else if (strSeqNo.equalsIgnoreCase("FACILITY-01")) {

						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeLAPSQuery("selfactypecheckrating^"
								+ strAppno);
						while (rs.next()) {
							strTlWc = strTlWc
									+ Helper.correctNull((String) rs
											.getString("COM_FACCODE")) + ",";
						}
						if (!strTlWc.equalsIgnoreCase("")
								&& strTlWc.contains(",")) {
							strTlWc = strTlWc
									.substring(0, strTlWc.length() - 1);
						}

						if (strTlWc.trim().contains("TL")) {
							strTL = "Only Term Loan";
						}
						if (strTlWc.trim().contains("WC")) {

							strTL = "Only Working Capital";
						}
						if (strTlWc.trim().contains("WC")
								&& strTlWc.trim().contains("TL")) {
							strTL = "Both (W/C and T/L)";
						}

						arrCol.add(strTL);// 3

					} else if (strSeqNo.equalsIgnoreCase("INDUSTRY-01")) {
						arrCol.add("");// 3
					}else if (strSeqNo.equalsIgnoreCase("NBFC_INDU")) {
						arrCol.add("NBFC");// 3
					} else {
						arrCol.add("");// 3
					}
					arrCol.add(Helper.correctNull((String) rs1
							.getString("RSK_PARAMCODE")));// 4
					arrRow.add(arrCol);
				}

				hshValues.put("arrRow", arrRow);
			}
			
			log.info("=====selriskdata===========strAppno=="+strAppno+"==Facility no==="+strNewFacSno+"==Business ID===="+strBusRuleID);
			rs = DBUtils.executeLAPSQuery("selriskdata^" + strAppno + "^"
					+ strNewFacSno + "^" + strBusRuleID);
			String strFlag = "N";
			while (rs.next()) {
				int j = 0;
				j = Integer.parseInt(Helper.correctInt((String) rs
						.getString("RAT_SEQNO")));
				if (j == 6) {
					String strScode = Helper.correctNull((String) rs
							.getString("RAT_VALUE"));
					rs1 = DBUtils.executeLAPSQuery("selbranhcnamebycode^"
							+ strScode);
					if (rs1.next()) {

						hshValues.put("rskvalue" + j, strScode);
					} else {
						hshValues.put("rskvalue" + j,
								Helper.correctNull((String) rs
										.getString("RAT_VALUE")));
					}
				} else if (j == 19) {
					String strScode = Helper.correctNull((String) rs
							.getString("RAT_VALUE"));
					rs1 = DBUtils.executeLAPSQuery("selcbsiddatadesc^" + "3"
							+ "^" + strScode);
					if (rs1.next()) {

						hshValues.put("rskvalue" + j, Helper
								.correctNull((String) rs1
										.getString("cbs_static_data_desc")));
					} else {
						hshValues.put("rskvalue" + j,
								Helper.correctNull((String) rs
										.getString("RAT_VALUE")));
					}

				} else if (j == 26) {
					String strScode = Helper.correctNull((String) rs
							.getString("RAT_VALUE"));
					rs1 = DBUtils.executeLAPSQuery("selcbsiddatadesc^" + "2"
							+ "^" + strScode);
					if (rs1.next()) {

						hshValues.put("rskvalue" + j, Helper
								.correctNull((String) rs1
										.getString("cbs_static_data_desc")));
					} else {
						hshValues.put("rskvalue" + j,
								Helper.correctNull((String) rs
										.getString("RAT_VALUE")));
					}

				} else {
					hshValues.put("rskvalue" + j, Helper
							.correctNull((String) rs.getString("RAT_VALUE")));
				}
				strFlag = "Y";

			}
			
			String strRMDUser="";
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("setuserssel^"+struserid);
			if(rs.next())
			{
				if(correctNull((String)rs.getString("usr_rmdflag")).equalsIgnoreCase("1"))
				{
					strRMDUser="Y";
				}
			}
			
			log.info("=====Action===="+strAction);
			if (strAction.equalsIgnoreCase("send")) {

				
				log.info("=========Before Web service Invokation=========");
				log.info("=========Application Number========="+strAppno);
				

				RatingSoapProxy ratingsoapproxy = new RatingSoapProxy(ApplicationParams.getRatingSoapAddress());
				String strResponse = ratingsoapproxy.corporateRating(strAppno);
				log.info("=========After Web service Invokation========="+strResponse);

				// String strResponse="Success";
				log.info("=========Response========="+strResponse);
				if (strResponse.startsWith("Success")) {
					strWsResponseFlag = "Y";
					if (rs != null) {
						rs.close();
					}
					log.info("=========SUCCESS=========");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "creditratdelete_userid");
					arrValues.add(strAppno);
					arrValues.add(struserid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "inscreditscoring_nonpoolflag");
					arrValues.add(strAppno);
					arrValues.add("1");
					arrValues.add("Y");
					arrValues.add("Y");
					arrValues.add(struserid);
					arrValues.add("");
					arrValues.add(strRMDUser);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				} else {
					// Failure
					strWsResponseFlag = "N";
					log.info("=========FAILURE=========");
				}

			}
			
			//Check for rejection of Non pool based rating request
			if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
			{
				String strQuery1=SQLParser.getCBSSqlQuery("sel_upl_request_result_newconnection_user^"+strAppno+"^"+struserid+"^1");
				ResultSet rsReject=DBUtils.executeQueryKalyptoConnection(strQuery1);
				if(rsReject.next())
				{
					strWsResponseFlag="N";
				}
			}
			
			if(strWsResponseFlag.equalsIgnoreCase("Y"))
			{
				//Do nothing
			}
			else if(strWsResponseFlag.equalsIgnoreCase("N"))
			{
				//sel_upl_request_errors
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					String Errormsg="";
					String strQuery1=SQLParser.getCBSSqlQuery("selgetrejectreason_rat_newconn^"+strAppno);
					ResultSet rssend=DBUtils.executeQueryKalyptoConnection(strQuery1);
					if(rssend.next())
					{
						Errormsg=Helper.correctNull((String)rssend.getString("REJECTED_REASON"));
						strReject="Y";
					}
					else
					{	
						String strQuerysend=SQLParser.getCBSSqlQuery("sel_upl_request_errors_newconnection^"+strAppno+"^"+strAppno);
						rssend=DBUtils.executeQueryKalyptoConnection(strQuerysend);
						if(rssend.next())
						{
						 Errormsg=Helper.correctNull((String)rssend.getString("ERRORS"));
						 //strErrors="Y";
						}
						else
						{
							Errormsg="No Proposal Found"; //Probably there might be a pending request in kalypto for this proposal
						}
					}
					hshValues.put("WebserviceErrorMessage",Errormsg);
						
					if(strReject.equalsIgnoreCase("Y"))
					{	
						arrValues= new ArrayList();
						hshQuery=new HashMap();
						hshQueryValues=new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "creditratdelete_userid");
						arrValues.add(strAppno);
			   			arrValues.add(struserid);
			   			hshQuery.put("arrValues", arrValues);
			   			hshQueryValues.put("1", hshQuery);	
			   			
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues.put("size", "2");
			 			hshQuery.put("strQueryId", "inscreditscoring_nonpoolflag");
			   			arrValues.add(strAppno);
			   			arrValues.add("1");
			   			arrValues.add("Y");
			   			arrValues.add("N");
			   			arrValues.add(struserid);
			   			arrValues.add(Errormsg);
			   			arrValues.add(strRMDUser);
			   			hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);	
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
						if(rssend!=null)
						{
							rssend.close();
						}
					
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							hshQuery.put("strQueryId", "deluplratresultdata_newconn");
						}
						else
						{
							hshQuery.put("strQueryId", "deluplratresultdata");
						}
			 			arrValues.add(strAppno);	
			 			arrValues.add(struserid);
			 			hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);	
						log.info("===deleterejectedreqest==="+arrValues);
						if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
						}
						else
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
					}
					
				}
				else
				{
					String strQuerysend=SQLParser.getSqlQuery("sel_upl_request_errors^"+strAppno+"^"+strAppno);
					ResultSet rssend=DBUtils.executeQuery(strQuerysend);
					if(rssend.next())
					{
						hshValues.put("WebserviceErrorMessage", Helper.correctNull((String)rssend.getString("ERRORS")));
					}
					if(rssend!=null)
					{
						rssend.close();
					}
				}
				}
			rs1 = DBUtils
					.executeLAPSQuery("selcrezflag_nonpoolbor^" + strAppno);
			while (rs1.next()) {
				arRatCol = new ArrayList();
				arRatCol.add(Helper.correctNull((String) rs1
						.getString("cre_rating")));// 0
				arRatCol.add(Helper.correctNull((String) rs1
						.getString("cre_weight")));// 1
				if(Helper.correctNull(rs1.getString("cre_rmdflag")).equalsIgnoreCase("Y"))
					arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid"))+"  - RMD User");//2	
				else
					arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid")));//2	
				arRatCol.add(Helper.correctNull(rs1.getString("cre_freeze")));//3
				arRatCol.add(Helper.correctNull(rs1.getString("cre_asondate")));//4
				arRatCol.add(Helper.correctNull(rs1.getString("cre_ratingerror")));//5
				arRatRow.add(arRatCol);
			}
			rs1 = DBUtils.executeLAPSQuery("selcredfreezuserwise^" + strAppno
					+ "^" + struserid);
			if (rs1.next()) {
				hshValues.put("strSendFlag", Helper.correctNull(rs1
						.getString("cre_freeze")));
				strsend = "Y";
				if (Helper.correctNull(rs1.getString("CRE_RATING"))
						.equalsIgnoreCase("")
						&& Helper.correctNull(rs1.getString("CRE_WEIGHT"))
								.equalsIgnoreCase("")) {
					hshValues.put("strNonPoolEMptyRatingFlag", "Y");
				}
				strTempFreezFlag = Helper.correctNull((String) rs1
						.getString("cre_freeze"));
			} else {
				hshValues.put("strSendFlag", "N");
				strsend = "N";
			}

//			if (strAction.equalsIgnoreCase("check")) {
//
//				String strQueryNew = SQLParser.getSqlQuery("selcredfreez^"
//						+ strAppno);
//				ResultSet rsnew = DBUtils.executeQuery(strQueryNew);
//				if (rsnew.next()) {
//					// Do nothing
//				} else {
//					// sel_upl_request_errors
//					if (ApplicationParams.getCbsIntegration().equalsIgnoreCase(
//							"TRUE")) {
//						arrValues = new ArrayList();
//						hshQuery = new HashMap();
//						hshQueryValues = new HashMap();
//						String strQuerysend = SQLParser
//								.getCBSSqlQuery("sel_upl_request_errors_newconnection^"
//										+ strAppno + "^" + strAppno);
//						ResultSet rssend = DBUtils
//								.executeQueryCBSConnection(strQuerysend);
//						if (rssend.next()) {
//							String Errormsg = Helper
//									.correctNull((String) rssend
//											.getString("ERRORS"));
//							hshValues.put("WebserviceErrorMessage", Helper
//									.correctNull((String) rssend
//											.getString("ERRORS")));
//							arrValues = new ArrayList();
//							hshQuery = new HashMap();
//							hshQueryValues = new HashMap();
//							hshQueryValues.put("size", "1");
//							hshQuery.put("strQueryId",
//									"inscreditscoring_nonpoolflag");
//							arrValues.add(strAppno);
//							arrValues.add("1");
//							arrValues.add("Y");
//							arrValues.add("N");
//							arrValues.add(struserid);
//							arrValues.add(Errormsg);
//							hshQuery.put("arrValues", arrValues);
//							hshQueryValues.put("1", hshQuery);
//							EJBInvoker.executeStateLess("dataaccess",
//									hshQueryValues, "updateData");
//							hshValues.put("WebserviceErrorMessage", Helper
//									.correctNull((String) rssend
//											.getString("ERRORS")));
//						}
//						if (rssend != null) {
//							rssend.close();
//						}
//					} else {
//						String strQuerysend = SQLParser
//								.getSqlQuery("sel_upl_request_errors^"
//										+ strAppno + "^" + strAppno);
//						ResultSet rssend = DBUtils.executeQuery(strQuerysend);
//						if (rssend.next()) {
//							hshValues.put("WebserviceErrorMessage", Helper
//									.correctNull((String) rssend
//											.getString("ERRORS")));
//						}
//						if (rssend != null) {
//							rssend.close();
//						}
//					}
//				}
//
//			}
			hshValues.put("tabdetails", vecVal);
			hshValues.put("appidnew", appid);
			hshValues.put("finace_id", finance_id);
			hshValues.put("fintype", cma);
			hshValues.put("BusRuleID", strBusRuleID);
			hshValues.put("strFlag", strFlag);
			hshValues.put("strModelCode", strModelCode);
			hshValues.put("arRatRow", arRatRow);
			log.info("=====Only for Rating===========Applicant Id=="+appid);
			
			
			
			if(rs!=null)
			rs.close();
			
			String strAppholder="";
			strQuery = SQLParser.getSqlQuery("sel_fin_rating^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);	
            if(rs.next())
           {
            	hshValues.put("fin_status",correctNull(rs.getString("fin_status")));
            	hshValues.put("fin_appholder",correctNull(rs.getString("fin_appholder")));
            	hshValues.put("fin_partyfiledet",correctNull(rs.getString("fin_partyfiledet")));
            	strAppholder=correctNull(rs.getString("fin_appholder"));
           }  
            hshValues.put("strAppno", strAppno);   
            
            if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("selectusername^"+strAppholder);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("Appholdername",correctNull(rs.getString(1)).trim());
			}
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("selpendingforapplicant^"+Helper.correctInt(appid));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("strAppPendingFlag","Y");
			}
			hshValues.put("AssetandLiab", Helper.correctNull((String) hshRequestValues.get("AssetandLiab")));
			
	    	//For Current year fetching
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("select_curryear_rating_ofr^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("strCurrYear", Helper.correctNull((String)rs.getString("FINRATEYEAR_SELSNO")));
			}
			
			if(rs!=null)rs.close();
			rs = DBUtils.executeLAPSQuery("sel_rating_financialyears_OFR^"+finance_id);
			if(rs.next())
			{
				hshValues.put("strCurrFlag","Y");
			}
			else
			{
				hshValues.put("strCurrFlag","N");
			}
			
			if (rs != null) {
				rs.close();
			}
			if(!strAppno.equalsIgnoreCase("")){
			String digiflag="";
				strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
		        }
				hshValues.put("digiflag", digiflag);
			}
			
		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getFinRating : " + ce.toString());

		} finally {
			try {
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshValues;

	}

	public HashMap getHistroy(HashMap hshRequestValues)  {
		
		HashMap hshValues = new HashMap();
		ResultSet rs = null, rs1 = null;
		String cma = "0", strQuery = "", finance_id = "", 
		appid =Helper.correctNull((String) hshRequestValues.get("hid_appid")),
		strBusRuleID = "", strNewFacSno = "0";
		ArrayList vecRec = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList arrValues = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strLapsParams = "", strParaSeq = "", strAppno = "0", strModelCode = "",page="",strappno="",appno="";
		strappno = Helper.correctNull((String) hshRequestValues.get("hidRatAppNo"));
		finance_id=Helper.correctNull((String) hshRequestValues.get("hidfinanceid"));
		try
		{
			cma = Helper.correctNull((String) hshRequestValues.get("hidcmasno"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}
		
				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
		
						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}
			
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				if ((y == 0)
						&& (page.trim().equals("") || page.trim().equals("RA"))) {
					page = correctNull((String) rs.getString("fin_tabname"));
				}

				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);

			}

			hshValues.put("tabdetails", vecVal);
			hshValues.put("appidnew", appid);
			hshValues.put("finace_id", finance_id);
			hshValues.put("fintype", cma);
			hshValues.put("BusRuleID", strBusRuleID);
			
			strQuery = SQLParser.getSqlQuery("sel_appmailboxfind_histroy^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			
			 while(rs.next())
			  { 
				 arrValues = new ArrayList();
				 arrValues.add(Helper.correctNull((String)rs.getString("af_fromuserid")));
				 arrValues.add(Helper.correctNull((String)rs.getString("af_date")));
				 arrValues.add(Helper.correctNull((String)rs.getString("af_touserid")));
				 arrValues.add(Helper.correctNull((String)rs.getString("af_type")));
				 arrRow.add(arrValues);
			 }
			 hshValues.put("arrRow", arrRow);
			 hshValues.put("AssetandLiab", Helper.correctNull((String) hshRequestValues.get("AssetandLiab")));
			 
			 if (rs != null) {
					rs.close();
				}
				if(!strappno.equalsIgnoreCase("")){
				String digiflag="";
					strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strappno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  
						digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
			        }
					hshValues.put("digiflag", digiflag);
				}
			 
		}
		catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getFinRating : " + ce.toString());
		}
		return hshValues;
	}
	
	public HashMap getAction(HashMap hshRequestValues)  {
		HashMap hshValues = new HashMap();
		ResultSet rs = null, rs1 = null;
		String cma = "0", strQuery = "", finance_id = "",appid="", 
		strBusRuleID = "", strNewFacSno = "0";
		ArrayList vecRec = new ArrayList();
		ArrayList vecVal = new ArrayList();
		String strLapsParams = "", strParaSeq = "", strAppno = "0", strModelCode = "",page="",strappno="",appno="",strUsrid="";
		strappno = Helper.correctNull((String) hshRequestValues.get("appno"));
		strappno = Helper.correctNull((String) hshRequestValues.get("hidRatAppNo"));
		finance_id=Helper.correctNull((String) hshRequestValues.get("hidfinanceid"));
		appid = Helper.correctNull((String) hshRequestValues.get("hid_appid"));
		strUsrid =Helper.correctNull((String) hshRequestValues.get("strUserId"));
		String strAction="",strOrgHead="";
		try
		{
			strAction=correctNull((String)hshRequestValues.get("hidAction"));
			cma = Helper.correctNull((String) hshRequestValues.get("hidcmasno"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}
		
				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
		
						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}
			
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				if ((y == 0)
						&& (page.trim().equals("") || page.trim().equals("RA"))) {
					page = correctNull((String) rs.getString("fin_tabname"));
				}

				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);

			}

			hshValues.put("tabdetails", vecVal);
			hshValues.put("appidnew", appid);
			hshValues.put("finace_id", finance_id);
			hshValues.put("fintype", cma);
			hshValues.put("BusRuleID", strBusRuleID);
			
			
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_fin_rating^"+strappno);
			rs = DBUtils.executeQuery(strQuery);	
	                if(rs.next())
	               {
	                	hshValues.put("fin_comments",correctNull(rs.getString("fin_comments")));
	                	hshValues.put("fin_status",correctNull(rs.getString("fin_status")));
	                	hshValues.put("fin_appholder",correctNull(rs.getString("fin_appholder")));
	                	hshValues.put("FIN_PROCESSEDBY",correctNull(rs.getString("FIN_PROCESSEDBY")));
	               }
            
        	if(rs!=null)
				rs.close();		
			
			rs=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUsrid);
			if(rs.next())
			{
				strOrgHead=correctNull(rs.getString("org_head"));
				hshValues.put("usrfunction",correctNull(rs.getString("usr_function")));
				if(correctNull(rs.getString("usr_rmdflag")).equalsIgnoreCase("1"))
				{
					hshValues.put("strRmdUserCheckFlag","Y");
				}
			} 
			if(rs!=null)
			rs.close();	
			
			String strfinalsendflag="N";
			rs=DBUtils.executeLAPSQuery("selcredfreezuser^"+strappno+"^"+strUsrid);
			if(rs.next())
			{
				hshValues.put("strFreezeFlag", Helper.correctNull(rs.getString("cre_freeze")));
				if(Helper.correctNull(rs.getString("cre_freeze")).equalsIgnoreCase("Y"))
				{
					if(!(Helper.correctNull(rs.getString("CRE_RATING")).equalsIgnoreCase("") || Helper.correctNull(rs.getString("CRE_WEIGHT")).equalsIgnoreCase("")))
					{
						strfinalsendflag="Y";
					}
					else
					{
						strfinalsendflag="N";						
					}
				}
				else
				{
				 strfinalsendflag="Y";
				}
			}
			hshValues.put("strfinalsendflag",strfinalsendflag);
			hshValues.put("strappno", strappno);  
			hshValues.put("strUsrid",strUsrid);  
			
			if(strAction.equalsIgnoreCase("send"))
			{
				hshValues.put("status","success");
			}
			if(strAction.equalsIgnoreCase("reallocate"))
			{
				hshValues.put("status","reallocate");
			}
			if(strOrgHead.equals(strUsrid))
			{
				hshValues.put("strOrgHead","Y");
			}
			else
			{
				hshValues.put("strOrgHead","N");
			}
			
			if (rs != null)
			{rs.close();}
			String strQry="where CRE_APPNO='"+strappno+"' and cre_weight is null and cre_rating is null  and cre_userid='"+strUsrid+"'";
			strQuery = SQLParser.getSqlQuery("selcreditscoring^"+strQry);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("cre_freeze", Helper.correctNull((String)rs.getString("cre_freeze")));
							
			}
			 hshValues.put("AssetandLiab", Helper.correctNull((String) hshRequestValues.get("AssetandLiab")));
			 if (rs != null) {
					rs.close();
				}
				if(!strappno.equalsIgnoreCase("")){
				String digiflag="";
					strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strappno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  
						digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
			        }
					hshValues.put("digiflag", digiflag);
				}
		}
		catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getFinRating : " + ce.toString());
		}
		return hshValues;	
    }
	
	public void updateAction(HashMap hshValues) 
	{
	HashMap hshqueryval =new HashMap();
	HashMap hshquery = new HashMap();
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	HashMap hshresult=new HashMap();

	ArrayList arrValues=new ArrayList();
	ResultSet rs = null;
	String strAction="";
	String strTouserid="";
	String strToflowpoint="";
	String strappno="";
	String strQuery="";
	String strCurdate="";
	String strToflwpoint="";
	String strExcep="$";
	String strAppid="";
	String appstatus="";
	String strApplStatus="",strFromuserid="";
	try
	{
    strFromuserid=correctNull((String)hshValues.get("strUserId"));
    strAction=correctNull((String)hshValues.get("hidAction"));
    strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
    strappno = Helper.correctNull((String) hshValues.get("hidRatAppNo"));
    strAppid=Helper.correctNull((String) hshValues.get("hidDemoId"));
    appstatus=Helper.correctNull((String) hshValues.get("strappstatus"));
    String strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
    String strcomments=Helper.correctNull((String)hshValues.get("txt_sanctioncomments"));
    String str_sent_orgcode=Helper.correctNull((String)hshValues.get("org_code"));
    strCurdate=Helper.getCurrentDateTime();
    
	if(strAction!=null && strAction.equalsIgnoreCase("send"))	
	{
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_fin_rating");
		arrValues.add(strTouserid);
		arrValues.add(strcomments);
		arrValues.add(strappno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size","1");
		hshQueryValues.put("1",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		
		/* ********************* CC to FGMO/RO/both from sending branch proposal to FGMO or CO ***************** */
		String str_sentorglevel=""; 
		String str_curorgcode=correctNull((String)hshValues.get("strOrgCode"));
		String strIsSaral=correctNull((String)hshValues.get("strIsSaral"));
		String strreg_head="";
		String strzon_head="";
		String strBranchtype="";
		String str_temporgcode="";
		String strOrgHead="";
		HashMap hshQueryCC;
		ArrayList arrValuesCC;
		HashMap hshQueryValuesCC=new HashMap();
		if(rs!=null)
			rs.close();
		strQuery=SQLParser.getSqlQuery("selorg_level^"+str_sent_orgcode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			str_sentorglevel = correctNull((String)rs.getString("org_level"));
			strOrgHead = correctNull((String)rs.getString("org_head"));
		}
		if(rs!=null)
			rs.close();
		
		
		/* CC to Head of the Organization while forwrding an application to that particular Organization
		 * Commented by Arsath for Performance Tuning 
		 * Field included in previous query
		strQuery=SQLParser.getSqlQuery("selorg_level^"+str_sent_orgcode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgHead = correctNull((String)rs.getString("org_head"));
		}
		*/
		if(str_sentorglevel.equalsIgnoreCase("C"))
		{
			String strUsrDept=Helper.correctNull((String)hshValues.get("usr_department"));
			String strDeptHead="";
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^20^"+strUsrDept);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strDeptHead=Helper.correctNull((String)rs.getString("cbs_static_data_passing_code"));
			}
			if(strDeptHead.equalsIgnoreCase(""))
			{
				throw new Exception("$ The Selected Department does not have Department Head ");
			}
			hshQueryCC=new HashMap();
			arrValuesCC=new ArrayList();
			hshQueryCC.put("strQueryId","insert_appmailbox");
			arrValuesCC.add(strappno);
			arrValuesCC.add(strFromuserid);
			arrValuesCC.add(strDeptHead);
			arrValuesCC.add("CC");
			arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
			arrValuesCC.add(strUsrDept);
			arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
			arrValuesCC.add(strUsrDept);
			hshQueryCC.put("arrValues",arrValuesCC);
			hshQueryValuesCC.put("1",hshQueryCC);
		}
		else
		{
			hshQueryCC=new HashMap();
			arrValuesCC=new ArrayList();
			hshQueryCC.put("strQueryId","insert_appmailbox");
			arrValuesCC.add(strappno);
			arrValuesCC.add(strFromuserid);
			arrValuesCC.add(strOrgHead);
			arrValuesCC.add("CC");
			
			if(rs!=null)
				rs.close();
			
			String strOrgScode="",strDept="";
			strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strOrgHead);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgScode=Helper.correctNull(rs.getString("org_scode"));
				strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			}
			
			arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
			if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
			else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
			else
				arrValuesCC.add("");

			arrValuesCC.add(strOrgScode);
			if(str_sentorglevel.equalsIgnoreCase("D"))
				arrValuesCC.add(strDept);
			else
				arrValuesCC.add("");
			
			hshQueryCC.put("arrValues",arrValuesCC);
			hshQueryValuesCC.put("1",hshQueryCC);
		}
		hshQueryValuesCC.put("size","1");
		
		hshQueryCC=new HashMap();
		arrValuesCC=new ArrayList();
		hshQueryCC.put("strQueryId","insert_appmailbox");
		arrValuesCC.add(strappno);
		arrValuesCC.add(strFromuserid);
		arrValuesCC.add(strTouserid);
		arrValuesCC.add("C");
		
		if(rs!=null)
			rs.close();
		
		String strOrgScode="",strDept="",strHeadUsrDept="";
		strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgScode=Helper.correctNull(rs.getString("org_scode"));
			strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			strHeadUsrDept=Helper.correctNull(rs.getString("usr_department"));
		}
		
		arrValuesCC.add(correctNull((String)hshValues.get("strOrgShortCode")));
		if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			arrValuesCC.add(correctNull((String)hshValues.get("strUserDepartment")));
		else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			arrValuesCC.add(correctNull((String)hshValues.get("strRLPFUser")));
		else
			arrValuesCC.add("");

		arrValuesCC.add(strOrgScode);
		if(str_sentorglevel.equalsIgnoreCase("C"))
			arrValuesCC.add(strHeadUsrDept);
		else if(str_sentorglevel.equalsIgnoreCase("D"))
			arrValuesCC.add(strDept);
		else
			arrValuesCC.add("");
		
		hshQueryCC.put("arrValues",arrValuesCC);
		hshQueryValuesCC.put("2",hshQueryCC);
		hshQueryValuesCC.put("size","2");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValuesCC,"updateData");
		
	}
	
	if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("reject"))
	{
		if(strAction.equalsIgnoreCase("approve"))
		{
			strQuery=SQLParser.getSqlQuery("selcredfreezuser^"+strappno+"^"+strUserID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//Do Nothing
			}
			else
			{
				strExcep=strExcep+"Please Do  the Rating Before Sanctioning , Without Rating You cannot Sanction the Proposal";
				throw new Exception(strExcep);
			}
			
			hshValues.put("pageFrom", "RA1");
			FinancialBean finbean=new FinancialBean();
			hshresult=finbean.getDataRatio(hshValues);

			hshValues.put("pageFrom", "RA2");
			hshresult=finbean.getDataRatio(hshValues);

			hshValues.put("pageFrom", "RA3");
			hshresult=finbean.getDataRatio(hshValues);	
			
		}
        
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_fin_rating_status");
        if(strAction.equalsIgnoreCase("approve"))
		{
		  arrValues.add("PA");
		}
		else
		{
		  arrValues.add("PR");
		}
        arrValues.add(strcomments);
        arrValues.add(strFromuserid);
		arrValues.add(strappno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size","1");
		hshQueryValues.put("1",hshQuery);
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","insert_appmailbox");
		arrValues.add(strappno);
		arrValues.add(strFromuserid);
		arrValues.add(strFromuserid);
		arrValues.add("");
		arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
		if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
		else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
		else
			arrValues.add("");
		arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
		if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
		else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
		else
			arrValues.add("");
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size","2");
		hshQueryValues.put("2",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
	}
	if(strAction.equalsIgnoreCase("undo"))
	{
		HashMap hshRecord = new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		
		strQuery = SQLParser.getSqlQuery("sel_fin_rating^"+strappno);
		rs = DBUtils.executeQuery(strQuery);	
                if(rs.next())
               {
                	hshRecord.put("fin_status",correctNull(rs.getString("fin_status")));
                	strApplStatus=correctNull(rs.getString("fin_status"));
               }
		
	   if(strApplStatus.equalsIgnoreCase("PR") || strApplStatus.equalsIgnoreCase("PA"))
		{
			hshQuery.put("strQueryId","update_fin_rating_undostatus");
			arrValues.add("OP");
			arrValues.add(strcomments);
			arrValues.add(null);
			arrValues.add(null);
			arrValues.add("Y");
			arrValues.add(strUserID);
			
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	 
	}
	if(strAction.equalsIgnoreCase("save"))
	{
		
		strQuery = SQLParser.getSqlQuery("sel_fin_rating^"+strappno);
		rs = DBUtils.executeQuery(strQuery);	
                if(rs.next())
               {
                	strApplStatus=correctNull(rs.getString("fin_status"));
               }
	
	    strApplStatus=strApplStatus.equalsIgnoreCase("PA")?"Processed/Approved":strApplStatus.equalsIgnoreCase("PR")?"Processed/Rejected":strApplStatus;
		
		if(strApplStatus.equalsIgnoreCase("Processed/Approved") || strApplStatus.equalsIgnoreCase("Processed/Rejected"))
		{
			hshQuery.put("strQueryId","updt_finrating_closed");
			arrValues.add(strappno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	   }
	}
	if(strAction!=null && (strAction.equalsIgnoreCase("reallocate")))
	{
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","update_fin_rating");
		arrValues.add(strTouserid);
		arrValues.add(strcomments);
		arrValues.add(strappno);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("size","1");
		hshQueryValues.put("1",hshQuery);
	
	
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQuery.put("strQueryId","insert_appmailbox");
		arrValues.add(strappno);
		arrValues.add(strFromuserid);
		arrValues.add(strTouserid);
		arrValues.add("C");
		if(rs!=null)
			rs.close();
		
		String strOrgScode="",strDept="",strHeadUsrDept="";
		strQuery=SQLParser.getSqlQuery("workflowusersanlimit^"+strTouserid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strOrgScode=Helper.correctNull(rs.getString("org_scode"));
			if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("D"))
			strDept=Helper.correctNull(rs.getString("usr_rlpftype"));
			else if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("C"))
			strDept=Helper.correctNull(rs.getString("usr_department"));
		}
		
		arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
		if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
		else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
		else
			arrValues.add("");

		arrValues.add(strOrgScode);
		arrValues.add(strDept);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("2",hshQuery);
		hshQueryValues.put("size","2");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	}
			
	}
	catch(Exception e)
	{
		throw new EJBException(e.getMessage());
	
	}finally
	{
		try
		{
			if(rs!=null)
				rs.close();
		}catch(Exception exp)
		{
			throw new EJBException("Error in closing the connection in updateAction "+ exp.toString()); 
		}
	}
	}
	public void updateOnlyforRating(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshformula = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		String strApp = "", strAppno = "", strBorrowId = "0", strSolid = "", strAction = "", strFac_Sno = "0";
		String strBusId = "", arrSize = "", strParmType = "";
		String strCBSId = "", strNameofBor = "", strperapp_constitution = "", strbankSince = "", strBranchCode = "", strDateofBirth = "";
		int i = 0;
		String struserid = "", strRmd = "", strRatType = "1",strOrgCode="",strFirstName="",strLastName="",strAppName="";
		int as = 0;
		int intCounter = 0;
		ArrayList arrValues = new ArrayList();
		try{

			strBorrowId = Helper
					.correctInt((String) hshValues.get("hid_appid"));
			strSolid = correctNull((String) hshValues.get("strSolid"));
			strBusId = correctNull((String) hshValues.get("sel_corpbusinessid"));
			strAppno = correctNull((String) hshValues.get("hidRatAppNo"));
			arrSize = correctNull((String) hshValues.get("hidrowsize"));
			as = Integer.parseInt(Helper.correctInt(arrSize));
			strAction = correctNull((String) hshValues.get("hidAction"));
			strCBSId = correctNull((String) hshValues.get("hidCBSID"));
			struserid = correctNull((String) hshValues.get("strUserId"));
			strOrgCode=correctNull((String) hshValues.get("strOrgCode"));
			String strRMDUserFlag="";
			if (strBorrowId.equalsIgnoreCase("")&& !strAppno.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_finapplicantid^" + strAppno);
				if (rs.next()) {
					strBorrowId = Helper.correctNull((String) rs.getString("FIN_APPID"));
					if(strCBSId.equalsIgnoreCase(""))
						strCBSId= Helper.correctNull((String) rs.getString("fin_cbsid"));
				}
				if (rs != null) {
					rs.close();
				}
			}
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("seluserrmd^" + struserid);
			if (rs.next()) {
				strSolid = Helper.correctNull((String) rs
						.getString("SOLID"));
				strRmd = Helper.correctNull((String) rs
						.getString("USR_RMDFLAG"));
				if(strRmd.equalsIgnoreCase("1"))
					strRMDUserFlag="Y";
			}
			if (strAction.equalsIgnoreCase("send")) {
				if (rs != null) {
					rs.close();
				}

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					hshQuery.put("strQueryId", "insuplproposaldata_newconn");
				} else {
					hshQuery.put("strQueryId", "insuplproposaldata");
				}
				arrValues.add(strAppno);
				arrValues.add(strCBSId);
				arrValues.add(struserid);
				arrValues.add(strSolid);
				arrValues.add(strRmd.trim());
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("1", hshQuery);
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateKalyptoData");
				} else {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("selcustomerdetails^"
						+ strBorrowId);
				if (rs.next()) {
					strCBSId = Helper.correctNull((String) rs
							.getString("PERAPP_CBSID"));
					strNameofBor = Helper.correctNull((String) rs
							.getString("perapp_fname"));
					strDateofBirth = Helper.correctNull((String) rs
							.getString("perapp_dob"));
					strbankSince = Helper.correctNull((String) rs
							.getString("perapp_banksince"));
					strBranchCode = Helper.correctNull((String) rs
							.getString("perapp_branchcode"));
					strperapp_constitution = Helper.correctNull((String) rs
							.getString("perapp_constitution"));
				}

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					hshQuery.put("strQueryId", "insuplconutrypardata_newconn");
				} else {
					hshQuery.put("strQueryId", "insuplconutrypardata");
				}
				arrValues.add(strAppno);
				arrValues.add(strCBSId);
				arrValues.add(strNameofBor);
				arrValues.add(strperapp_constitution); // need to pass the
														// customer constitution
				arrValues.add(" ");
				arrValues.add("14");
				arrValues.add("INDIA");
				arrValues.add(strbankSince);
				arrValues.add(strBranchCode);
				arrValues.add(strDateofBirth);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateKalyptoData");
				} else {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					hshQuery.put("strQueryId", "insuplrequestdata_newconn");
				} else {
					hshQuery.put("strQueryId", "insuplrequestdata");
				}
				arrValues.add(strAppno);
				arrValues.add(strAppno
						+ "_"
						+ Helper.correctNull((String) hshValues
								.get("hidModelCode")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("hidModelCode")));
				arrValues.add(strRatType);
				arrValues.add(strAppno
						+ "_"
						+ Helper.correctNull((String) hshValues
								.get("hidModelCode")));
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				log.info("===RequestData===" + arrValues);
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateKalyptoData");
				} else {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

				String strRatingparamCode="";
				for (i = 1; i <= as; i++) {
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					if (ApplicationParams.getKalyptoConnection()
							.equalsIgnoreCase("TRUE")) {
						hshQuery.put("strQueryId",
								"insuplratingreqparams_newconn");
					} else {
						hshQuery.put("strQueryId", "insuplratingreqparams");
					}
					arrValues.add(strAppno);
					arrValues.add(strAppno
							+ "_"
							+ Helper.correctNull((String) hshValues
									.get("hidModelCode")));
					String strSnoParm = Helper.correctNull((String) hshValues
							.get("hid_riskparam" + i));
					if (rs != null)
						rs.close();
					rs = DBUtils.executeLAPSQuery("selriskparamcodetype^"
							+ strSnoParm);
					if (rs.next()) {
						arrValues.add(Helper.correctNull((String) rs
								.getString("rsk_paramcode")));// 1
						strParmType = Helper.correctNull((String) rs
								.getString("RSK_PARMDATATYPE"));
						strRatingparamCode=Helper.correctNull((String)rs.getString("rsk_paramcode"));
					}
					if (strParmType.equalsIgnoreCase("N")) {
						arrValues.add(Helper.correctNull((String) hshValues
								.get("txt_riskparam" + i)));
						arrValues.add("");
					} else if (strParmType.equalsIgnoreCase("T")) {
						arrValues.add("");
						arrValues.add(Helper.correctNull((String) hshValues
								.get("txt_riskparam" + i)));
					}
					if(strRatingparamCode.equalsIgnoreCase("Nature of Current Ratio_LCM") || strRatingparamCode.equalsIgnoreCase("Type of Loan_LCM_V2.0") || 
							strRatingparamCode.equalsIgnoreCase("Type of Business") || strRatingparamCode.equalsIgnoreCase("INDUSTRY-01") 
							|| strRatingparamCode.equalsIgnoreCase("EXISTING-01")|| strRatingparamCode.equalsIgnoreCase("NBFC_INDU"))
		   			{
			   			rs=DBUtils.executeLAPSQuery("selrating_currentyear_ofr^"+strAppno);
			   			if(rs.next())
			   			{	   				
			   				arrValues.add(Helper.correctNull((String)rs.getString("COM_FINYEAR_START")));
				   			arrValues.add(Helper.correctNull((String)rs.getString("COM_FINYEAR")));
			   			}
			   			else
			   			{
			   				arrValues.add("");
				   			arrValues.add("");
			   			}
		   			}
					else
		   			{
		   				arrValues.add("");
			   			arrValues.add("");
		   			}
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					if (ApplicationParams.getKalyptoConnection()
							.equalsIgnoreCase("TRUE")) {
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateKalyptoData");
					} else {
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}
				}
				
				//Added by Guhan for Kalypto table entry 
				 //* Calculate Kalypto ratio and Save the details in Kalpto Table
				 
				FinancialBean fOb	= new FinancialBean();
				int h=0,j=0,k=0;
				int intUpdatesize = 0;
				HashMap hshReqValues	= new HashMap();
				HashMap hshResult		= new HashMap();
				ArrayList vecyear			= new ArrayList();
				ArrayList yearvalue		= new ArrayList();
				ArrayList yearvalueStrt	= new ArrayList();
				
				hshReqValues.put("appno",strAppno);
				hshReqValues.put("pagefrom","RA3");
				hshReqValues.put("from", "1");
				hshReqValues.put("pagename", "FI");
				hshReqValues.put("rating", "Y");
				hshReqValues.put("OFR", "Y");
				hshResult	= fOb.getDataRatio(hshReqValues);

				String  totalyear	= correctNull((String)hshResult.get("totalyear"));
				int totyr			= Integer.parseInt(totalyear);

				yearvalue			= (ArrayList)hshResult.get("yearvalue");
				yearvalueStrt			= (ArrayList)hshResult.get("yearvalueStrt");

				String[] Dates		= new String[totyr];//Date
				String[] DatesStrt	= new String[totyr];//Date strt
				String[] finType	= new String[totyr];
				ArrayList[] vecyears	= new ArrayList[totyr];
				ArrayList vecid1		= new ArrayList();
				
				log.info("===totalyear==="+totyr);
				
				for(h=0;h<(totyr);h++)
				{
					k=h+1;
					vecyears[h]=(ArrayList)hshResult.get("year"+k);
				}
				k=0;
				int m=0;
				
				for(h=0;h<totyr;h++)
				{
					DatesStrt[m]=(String)yearvalueStrt.get(h);
					m++;
				}
				
				for(h=0;h<2*totyr;h++)
				{
					if(h%2==0)
					{
						Dates[j]=(String)yearvalue.get(h);
						j++;							
					}
					else
					{
						finType[k]=(String)yearvalue.get(h);
						k++;
					}
				}
				vecid1=(ArrayList)hshResult.get("vecid1");

				hshQueryValues 	= new HashMap();
				hshQuery 		= new HashMap();
				arrValues		= new ArrayList();	
				String strKALYPTOcode="";
				
				for(int NoOfYears=0;NoOfYears<totyr;NoOfYears++)
				{
					for(h=0;h<vecid1.size();h++)
					{
						String strQuery = SQLParser.getSqlQuery("sel_kalyptocode_byrowid^"+vecid1.get(h));
			   			ResultSet rsKal = DBUtils.executeQuery(strQuery);
			   			if(rsKal.next())
			   			{
			   				strKALYPTOcode = Helper.correctNull((String)rsKal.getString("FIN_KALYPTO_CODE")); //KALYPTO PARAMETER CODE
			   			}
			   			
			   			if(!strKALYPTOcode.equalsIgnoreCase(""))
			   			{
							hshQueryValues 	= new HashMap();
							hshQuery 	= new HashMap();
							arrValues	= new ArrayList();	
							if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								hshQuery.put("strQueryId", "insuplratingreqparams_newconn");
							}
							else
							{
								hshQuery.put("strQueryId", "insuplratingreqparams");
							}
				   			arrValues.add(strAppno);
				   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
				   			arrValues.add(strKALYPTOcode);//KALYPTO code
							arrValues.add(vecyears[NoOfYears].get(h));//value
							arrValues.add("");//text value entry
							arrValues.add(DatesStrt[NoOfYears]);//Date
							arrValues.add(Dates[NoOfYears]);//Date
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);								
							hshQueryValues.put("size","1");
							
							if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
							}
							else
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
			   			}
					}
				}
				//End by Guhan				
			
					
			
				//By Guhan for Kalypto ratio passing to UPL_REQUEST_PERIODS table
				String strQuery5 = SQLParser.getSqlQuery("sel_ratingyears_kalypto_ofr^"+strAppno);
				ResultSet rs5 = DBUtils.executeQuery(strQuery5);
				while(rs5.next())
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						hshQuery.put("strQueryId", "insuplreqperiod_newconn");
					}
					else
					{
						hshQuery.put("strQueryId", "insuplreqperiod");
					}
					arrValues.add(strAppno);
		   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINYEAR_START")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINYEAR")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINTYPE")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("FINRATEYEAR_CURRENTYEAR")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("audit_name")));
		   			arrValues.add(Helper.correctNull((String)rs5.getString("is_compute")));
					hshQuery.put("arrValues", arrValues);
					log.info("===ProposalData==="+arrValues);
					
					hshQueryValues.put("1", hshQuery);	
					if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
					}
					else
					{
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
			
			} else if (strAction.equalsIgnoreCase("undo")) {
				/*arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delriskdata");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");*/

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					hshQuery.put("strQueryId", "deluplratresultdata_newconn");
				} else {
					hshQuery.put("strQueryId", "deluplratresultdata");
				}
				arrValues.add(strAppno);
				arrValues.add(struserid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateKalyptoData");
				} else {
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				// END
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "creditratdelete_userid");
				arrValues.add(strAppno);
				arrValues.add(struserid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("check")) {
				log.info("=======check===========");

				if (ApplicationParams.getKalyptoConnection().equalsIgnoreCase(
						"TRUE")) {
					String strQuery = SQLParser
							.getCBSSqlQuery("sel_upl_request_result_newconnection_user^"
									+ strAppno + "^" + struserid+"^0");
					rs = DBUtils.executeQueryKalyptoConnection(strQuery);
				} else {
					String strQuery = SQLParser
							.getSqlQuery("sel_upl_request_result_user^"
									+ strAppno + "^" + struserid);
					rs = DBUtils.executeQuery(strQuery);
				}
				String strRATING_SCORE = "", strRATING_LABEL = "", strRatUserId = "", strDateAson = "",strratingyear="",stryeartype="";
				int b = 1;
				if (rs.next()) {
					log.info("=======Start===========");
					strRATING_SCORE = Helper.correctNull((String) rs.getString("rating_score"));
					strRATING_LABEL = Helper.correctNull((String) rs.getString("rating_label"));
					strRatUserId = Helper.correctNull((String) rs.getString("user_login_id"));
					strDateAson = Helper.correctNull((String) rs.getString("ason_date"));
					strratingyear=Helper.correctNull((String)rs.getString("date_end"));
					stryeartype=Helper.correctNull((String)rs.getString("period_type"));
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "creditratdelete_nonpool");
					arrValues.add(strAppno);
					arrValues.add(strRatUserId);
					arrValues.add("Y");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "creditratinsu");
					arrValues.add(strAppno);
					arrValues.add(String.valueOf(b));
					arrValues.add(strRATING_SCORE);
					arrValues.add("Y");
					arrValues.add(strRATING_LABEL);
					arrValues.add(strRatUserId);
					//arrValues.add(strDateAson);
					arrValues.add(strratingyear);
		   			arrValues.add(stryeartype);	
		   			arrValues.add("Y");
		   			arrValues.add(strRMDUserFlag);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					if (ApplicationParams.getKalyptoConnection()
							.equalsIgnoreCase("TRUE")) {
						hshQuery.put("strQueryId",
								"deluplratresultdata_newconn");
					} else {
						hshQuery.put("strQueryId", "deluplratresultdata");
					}
					arrValues.add(strAppno);
					arrValues.add(struserid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					if (ApplicationParams.getKalyptoConnection()
							.equalsIgnoreCase("TRUE")) {
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateKalyptoData");
					} else {
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}
					log.info("=======End===========");
				}

			}
			
		}catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateAction "+ exp.toString()); 
			}
		}
	}
	
	public HashMap getCorpDataRatio(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rsPrevYear = null;
		ResultSet rsFormulaFor = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "", strAppName = "", strPage = "";
		String page = "";
		int maxYear = 5;
		int str = 0;
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		hshValues = new HashMap();
		String strValuesin = "";
		try {
			strValue = correctNull((String) hshRequestValues.get("appno"));
			if(strValue.equals(""))
			{
				strValue = correctNull((String) hshRequestValues.get("hidRatAppNo"));
			}
			if(strValue.equals(""))
			{
				strValue = correctNull((String) hshRequestValues.get("FACILITY_APPNO"));
			}
			if(strValue.equals(""))
			{
				strValue = correctNull((String) hshRequestValues.get("APP_NO"));
			}
			if(strValue.equals(""))
			{
				strValue = correctNull((String) hshRequestValues.get("strAppno"));
			}
			
			String pageType=correctNull((String)hshRequestValues.get("pageType"));
			String appidnew=correctNull((String)hshRequestValues.get("hid_appid"));
			String strRating = correctNull((String)hshRequestValues.get("rating"));
			String strOFR = correctNull((String)hshRequestValues.get("OFR"));
			// Added by Kishan
			String strFinID = "0",givenyear="";
			String cma = "0";
			int from = 0;
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}
			
			if(strOFR.equalsIgnoreCase("Y"))
			{
				strQuery = SQLParser.getSqlQuery("sel_financeid_ofr^" + strValue);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strFinID = Helper.correctInt((String) rs
							.getString("FIN_FINID"));
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_financeid^" + strValue);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strFinID = Helper.correctInt((String) rs
							.getString("DEMO_FINSTANDARD"));
				}
			}
			
			if (strValue.equalsIgnoreCase("")) {
				strFinID = Helper.correctInt((String) hshRequestValues
						.get("FinID"));
			}
			if (strFinID.equalsIgnoreCase("") || strFinID.equalsIgnoreCase("0")) {
				strFinID = Helper.correctInt((String) hshRequestValues
						.get("hidfinid"));
			}
			if (!strFinID.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					cma = Helper
							.correctNull((String) rs.getString("FIN_CMANO"));
					strValuesin = Helper.correctNull((String) rs
							.getString("fin_valuesarein"));
				}
			}
			hshValues.put("strValuesin", strValuesin);
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			
			String strPrintYear=correctNull((String)hshRequestValues.get("printYear"));
			
			strQuery = SQLParser.getSqlQuery("com_selfin_printyearsno^" + strFinID);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList ArrprintCheck = new ArrayList();
			while (rs.next()) {
				ArrprintCheck .add(Helper.correctNull((String) rs.getString("finprintyear_selsno")));
			}
			page = correctNull((String) hshRequestValues.get("page"));
			if (page.equalsIgnoreCase("")) {
				page = "RA";
			}
			strPage = correctNull((String) hshRequestValues.get("pageFrom")); // Ratio
																				// Type
																				// RA1,RA2,RA3
			if (strPage.equalsIgnoreCase("")) {
				strPage = correctNull((String) hshRequestValues.get("pagefrom")); // Assessment
																					// type
																					// -
																					// Export
																					// limits
			}
			if (strPage.equalsIgnoreCase("")) {
				strPage = correctNull((String) hshRequestValues
						.get("pagefrom1")); // Assessment type - Export limits
			}
			if (strPage.equals("")) {
				strPage = correctNull((String) hshRequestValues.get("pagefr"));
			}// defaulty RA1 must be loaded
			String pagename = correctNull((String) hshRequestValues
					.get("pagename"));
			if (strPage.equalsIgnoreCase("M1")
					|| strPage.equalsIgnoreCase("M2")
					|| strPage.equalsIgnoreCase("AFL")) {
				HashMap hshassess = new HashMap();
				hshassess.put("appno", strValue);
				hshassess.put("strFinID", strFinID);
				hshassess.put("page", "INV");
				hshassess.put("from", String.valueOf(from));
				hshassess.put("pagefrom1", "I1");
				hshassess.put("pageType", "assesment");
				hshassess.put("pagename", strPage);
				hshValues.put("hshnew", getDataAssessment(hshassess));
			}

			/*
			 * Added by Amaravathi for get financial values from Finappvalues
			 * and put in one separate HashMap
			 */
			HashMap hshFinYearVal = new HashMap();
			hshFinYearVal.put("appno", strValue);
			hshFinYearVal.put("strFinID", strFinID);
			hshFinYearVal.put("comappid", correctNull((String) hshRequestValues
					.get("sel_divID")));
			hshFinYearVal = getFinValues(hshFinYearVal);
			/*
			 * End
			 */

			// -----------to get the borrower name-------------
			strQuery = SQLParser.getSqlQuery("com_lapsidsearch2^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				strAppName = correctNull((String) rs
						.getString("comapp_companyname"));
			}
			if (rs != null) {
				rs.close();
			}

			// -------------- to find the time of review-----------------

			strQuery = SQLParser.getSqlQuery("finselect1^" + strFinID + "^0");
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				str = rs.getInt("cnt");
			}
			if (rs != null) {
				rs.close();
			}

			// --------------- to find the cma format of the particular
			// applications-------

			// String cma="";
			// strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			/*
			 * strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue); rs =
			 * DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=rs.getString("demo_finstandard"); }
			 * hshValues.put("cma",cma); if(rs!=null) { rs.close(); }
			 */

			// -----------------to find the tab----------------------
			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application

			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2anew^" + cma + "^"
						+ page + "^" + strPage);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);

				}

				hshValues.put("labeldetails", vecVal);

			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				// strQuery =
				// SQLParser.getSqlQuery("finselect3a^"+strValue+"^"+cma+"^"+page);
				strQuery = SQLParser.getSqlQuery("finselect3anew^" + cma + "^"                  //need to change 
						+ page + "^" + strPage);

				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));
					vecVal.add(vecRec);
				}

				hshValues.put("labeldetails", vecVal);

			}

			if (rs != null) {
				rs.close();
			}
			hshValues.put("count", Integer.toString(str));

			String yearselect = "",yearselect_strt="", seloption = "",  yearvalue = "", tempyear = "";
			int i = 0, k = 0;
			int p = 0;
			int yearint = 0;
			ArrayList vecrec = new ArrayList();
			ArrayList vecrecStrt = new ArrayList();

			/*if(pageType.equalsIgnoreCase("AN4")||pageType.equalsIgnoreCase("AN9")||pageType.equalsIgnoreCase("MCFD"))
			{
				if(rs!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("finselectcount^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					maxYear=rs.getInt(1);
				}
			}*/
			if(rs!=null){rs.close();}
			String valarray[] = new String[5];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";
			String sno = "";
			int o=1;
			
			if(strRating.equalsIgnoreCase("Y"))
			{
					strQuery = SQLParser.getSqlQuery("finselectratio_ratingyear^" + strFinID+"^" + strFinID);
			}
			else
			{
				String strBuffer="";
				if(strPage.equalsIgnoreCase("RA1")||strPage.equalsIgnoreCase("RA2"))
					strBuffer="  and finprintyear_pageid in ('ASSETS','LIABILITIES','PROFIT AND LOSS ACCOUNT')";
				else
					strBuffer=" and finprintyear_pageid='"+strPage+"'";
				if(!strPrintYear.equalsIgnoreCase("Y"))
					strQuery = SQLParser.getSqlQuery("finselect4a^" + strFinID);
				else
					strQuery = SQLParser.getSqlQuery("finselectratio_printyear^" + strFinID+"^" + strFinID+"^"+strBuffer);
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";

				vecVal = new ArrayList();
				String str1 = "", str2 = "", str3 = "", str0 = "";
				String desc = "", formula_desc = "";
				sno = (String) Helper.correctNull(rs.getString("fin_sno"));
				// strPage=
				// (String)Helper.correctNull(rs.getString("hidFinPage"));
				// To Find the years assigned for each application

				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				
				if(strRating.equalsIgnoreCase("Y"))
				{
					yearselect_strt = (String) Helper.correctNull(rs
							.getString("finyear_start"));
				}
				yearvalue = (String) Helper.correctNull(rs
						.getString("yearvalue"));
				if (!sno.equals(tempyear)) {

					// to check for the occurance of audited,.,.,. for a
					// paricular year

					/*
					 * strQuery =
					 * SQLParser.getSqlQuery("finselect7a^"+yearselect
					 * +"^"+strValue+"^"+sno);
					 * 
					 * rs3 = DBUtils.executeQuery(strQuery);
					 * 
					 * while(rs3.next()) { if(valarray[0].equals("0")) {
					 * valarray
					 * [0]=Helper.correctDouble(rs3.getString("fin_audit")); }
					 * if(valarray[1].equals("0")) {
					 * valarray[1]=Helper.correctDouble
					 * (rs3.getString("fin_unaudit")); }
					 * if(valarray[2].equals("0")) {
					 * valarray[2]=Helper.correctDouble
					 * (rs3.getString("fin_estimated")); }
					 * if(valarray[3].equals("0")) {
					 * valarray[3]=Helper.correctDouble
					 * (rs3.getString("fin_projection")); }
					 * if(valarray[4].equals("0")) {
					 * valarray[4]=Helper.correctDouble
					 * (rs3.getString("fin_projection")); }
					 * 
					 * if (!valarray[0].equals("0")) { valarray[0]= "fin_audit";
					 * }
					 * 
					 * if (!valarray[1].equals("0")) { valarray[1] =
					 * "fin_unaudit"; }
					 * 
					 * if (!valarray[2].equals("0")) { valarray[2] =
					 * "fin_estimated"; }
					 * 
					 * if (!valarray[3].equals("0")) { valarray[3] =
					 * "fin_projection"; } if (!valarray[4].equals("0")) {
					 * valarray[4] = "fin_projection"; } }
					 */
					strQuery = SQLParser.getSqlQuery("finselect7a^"
							+ yearselect + "^" + strFinID + "^" + sno + "^"
							+ strPage);

					rs3 = DBUtils.executeQuery(strQuery);

					while (rs3.next()) {
						
							if (valarray[0].equals("0")) {
								valarray[0] = Helper.correctDouble(rs3
										.getString("fin_audit"));
							}
							if (valarray[1].equals("0")) {
								valarray[1] = Helper.correctDouble(rs3
										.getString("fin_unaudit"));
							}
							if (valarray[2].equals("0")) {
								valarray[2] = Helper.correctDouble(rs3
									.getString("fin_estimated"));
							}
							if (valarray[3].equals("0")) {
							valarray[3] = Helper.correctDouble(rs3
									.getString("fin_projection"));
							}
							if (valarray[4].equals("0")) {
							valarray[4] = Helper.correctDouble(rs3
									.getString("fin_projection"));
							}
						
							if(pageType.equalsIgnoreCase("AN9"))
							{
								if(ArrprintCheck.contains(sno))
								{
								if (valarray[2].equals("0")) {
									valarray[2] = Helper.correctDouble(rs3
										.getString("fin_estimated"));
								}
								if (valarray[3].equals("0")) {
								valarray[3] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
								if (valarray[4].equals("0")) {
								valarray[4] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
								valarray[0]="0";
								valarray[1]="0";
								}else{
									valarray[4]="0";
									valarray[2]="0";
									valarray[3]="0";
									valarray[0]="0";
									valarray[1]="0";
								}
							}
							if(pageType.equalsIgnoreCase("MCFD"))
							{
								if (valarray[0].equals("0")) {
									valarray[0] = Helper.correctDouble(rs3
											.getString("fin_audit"));
								}
								if (valarray[1].equals("0")) {
									valarray[1] = Helper.correctDouble(rs3
											.getString("fin_unaudit"));
								}
								valarray[4]="0";
								valarray[2]="0";
								valarray[3]="0";
							}
							if(pageType.equalsIgnoreCase("AN4"))
							{
								if(ArrprintCheck.contains(sno))
								{
								if (valarray[0].equals("0")) {
									valarray[0] = Helper.correctDouble(rs3
											.getString("fin_audit"));
								}
								if (valarray[1].equals("0")) {
									valarray[1] = Helper.correctDouble(rs3
											.getString("fin_unaudit"));
								}
								if (valarray[2].equals("0")) {
									valarray[2] = Helper.correctDouble(rs3
										.getString("fin_estimated"));
								}
								if (valarray[3].equals("0")) {
								valarray[3] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
								if (valarray[4].equals("0")) {
								valarray[4] = Helper.correctDouble(rs3
										.getString("fin_projection"));
								}
								}else{
									valarray[4]="0";
									valarray[2]="0";
									valarray[3]="0";
									valarray[0]="0";
									valarray[1]="0";
								}
								
							}
						if (!valarray[0].equals("0")) {
							valarray[0] = "fin_audit";
						}

						if (!valarray[1].equals("0")) {
							valarray[1] = "fin_unaudit";
						}

						if (!valarray[2].equals("0")) {
							valarray[2] = "fin_estimated";
						}

						if (!valarray[3].equals("0")) {
							valarray[3] = "fin_projection";
						}
						if (!valarray[4].equals("0")) {
							valarray[4] = "fin_projection";
						}
					}
					if (rs3 != null) {
						rs3.close();
					}

					// to find the values for each label with respect to
					// value(a,una,p,e),year and id

					for (int h = 0; h <= 3; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							boolean max;
							if (pagename.equalsIgnoreCase("FI") || pageType.equalsIgnoreCase("AN4")||pageType.equalsIgnoreCase("AN9")||pageType.equalsIgnoreCase("MCFD")||((strPage.equalsIgnoreCase("M1")||strPage.equalsIgnoreCase("M2")||strPage.equalsIgnoreCase("AFL"))&&strPrintYear.equalsIgnoreCase("Y"))||(Helper.correctNull((String)hshRequestValues.get("hidPageId")).equals("comwrflw"))) {
								max = true;
							} else {
								if(k>=5)
									max=false;
								else
									max=true;
								
								//max = (k < maxYear);
							}
							if ((i >= from) && max) {
								p = i;
								k = k + 1;
								strQuery = SQLParser
										.getSqlQuery("finratio1new^" + page
												+ "^" + cma + "^" + strPage);

								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {
									if (seloption.equals("fin_audit")) {
										desc = "a";
									} else if (seloption.equals("fin_unaudit")) {
										desc = "u";
									} else if (seloption
											.equals("fin_estimated")) {
										desc = "e";
									} else if (seloption
											.equals("fin_projection")) {
										desc = "p";
									}

									double dblBankBorr = 0.00;
									if (rs4 != null)
										rs4.close();

									if (cma.equalsIgnoreCase("5"))
										strQuery = SQLParser
												.getSqlQuery("selcomfinvalues^"
														+ strFinID + "^461"
														+ "^" + yearselect);
									else
										strQuery = SQLParser
												.getSqlQuery("selcomfinvalues^"
														+ strFinID + "^1005^"
														+ yearselect);

									rs4 = DBUtils.executeQuery(strQuery);
									if (rs4.next()) {
										dblBankBorr = Double
												.parseDouble((Helper
														.correctDouble((String) rs4
																.getString("finvalue"))));
									}

									int formuladesc = 0;
									formuladesc = (rs1.getInt("fin_formula"));

									if (formuladesc > 0) {

										strQuery = SQLParser
												.getSqlQuery("selfinformula^"
														+ formuladesc);

										rsFormulaFor = DBUtils
												.executeQuery(strQuery);
										String strFormulaFor = "";
										if (rsFormulaFor.next()) {
											strFormulaFor = correctNull((String) rsFormulaFor
													.getString("formula_for"));
										}

										String strPreYear = "", strPreYearDesc = "";
										if (rsFormulaFor != null) {
											rsFormulaFor.close();
										}
										if ((strFormulaFor.trim()
												.equalsIgnoreCase("CA"))
												|| (strFormulaFor.trim()
														.equalsIgnoreCase("ST"))) {
											strQuery = SQLParser
													.getSqlQuery("selpreyrs^"
															+ strFinID + "^<^"
															+ yearselect);

											rsPrevYear = DBUtils
													.executeQuery(strQuery);
											if (rsPrevYear.next()) {
												double audit = rsPrevYear
														.getDouble("audit");
												double unaudit = rsPrevYear
														.getDouble("unaudit");
												double estimated = rsPrevYear
														.getDouble("estimated");
												double projection = rsPrevYear
														.getDouble("projection");
												if (audit != 0) {
													strPreYearDesc = "A";
												} else if (unaudit != 0) {
													strPreYearDesc = "U";
												} else if (estimated != 0) {
													strPreYearDesc = "E";
												} else if (projection != 0) {
													strPreYearDesc = "P";
												}
												strPreYear = rsPrevYear
														.getString("prevyear");
											}
											if (rsPrevYear != null) {
												rsPrevYear.close();
											}

											if (!strPreYear.trim().equals("")) {
												HashMap hshformula = new HashMap();
												hshformula.put("appno",
														strValue);
												hshformula.put("strFinID",
														strFinID);
												hshformula
														.put(
																"formulaid",
																Integer
																		.toString(formuladesc));
												hshformula.put("curryear",
														yearselect);
												hshformula.put("prevyear",
														strPreYear);
												hshformula.put(
														"currfinancialtype",
														desc);
												hshformula.put(
														"prevfinancialtype",
														strPreYearDesc);
												hshformula.put("internalcalc",
														"N");
												hshformula.put("sno", sno);
												if (strFormulaFor.trim()
														.equalsIgnoreCase("ST")) {
													hshformula.put("isstress",
															"Y");
													hshformula.put(
															"ratiostress", "Y");
												}
												hshformula.put("hshdata",
														new HashMap());
												hshformula.put("hshFinYearVal",
														hshFinYearVal);

												HashMap hshRes = (HashMap) EJBInvoker
														.executeStateLess(
																"comformula",
																hshformula,
																"GetFinValue");

												vecVal
														.add(correctNull((String) hshRes
																.get("strTotalValue")));
											} else {
												vecVal.add("-");

											}

										} else {
											HashMap hshformula = new HashMap();
											hshformula.put("appno", strValue);
											hshformula
													.put("strFinID", strFinID);
											hshformula.put("formulaid", Integer
													.toString(formuladesc));
											hshformula.put("curryear",
													yearselect);
											hshformula.put("prevyear",
													strPreYear);
											hshformula.put("currfinancialtype",
													desc);
											hshformula.put("prevfinancialtype",
													strPreYearDesc);
											hshformula.put("internalcalc", "N");
											hshformula.put("sno", sno);
											hshformula.put("hshdata",
													new HashMap());
											hshformula.put("hshFinYearVal",
													hshFinYearVal);
											HashMap hshRes = (HashMap) EJBInvoker
													.executeStateLess(
															"comformula",
															hshformula,
															"GetFinValue");
											vecVal
													.add(correctNull((String) hshRes
															.get("strTotalValue")));

										}
										vecid.add(correctNull(rs1
												.getString("fin_rowid")));
									} else {
										String finrowid = correctNull(rs1
												.getString("fin_rowid"));
										if ((cma.equalsIgnoreCase("5") && (finrowid
												.equalsIgnoreCase("1237")
												|| finrowid
														.equalsIgnoreCase("1226") || finrowid
												.equalsIgnoreCase("1230")))
												|| (cma.equalsIgnoreCase("9") && (finrowid
														.equalsIgnoreCase("1220")
														|| finrowid
																.equalsIgnoreCase("1242") || finrowid
														.equalsIgnoreCase("1224")))||(cma.equalsIgnoreCase("1") && (finrowid
												.equalsIgnoreCase("1271")
												|| finrowid
														.equalsIgnoreCase("1301") || finrowid
												.equalsIgnoreCase("1306")))) {
											if (vecVal.size() >= 2) {
												double WCG = Double
														.parseDouble((Helper
																.correctDouble((String) vecVal
																		.get(0))));
												double MWCG = Double
														.parseDouble((Helper
																.correctDouble((String) vecVal
																		.get(1))));
												double NWC = Double
														.parseDouble((Helper
																.correctDouble((String) vecVal
																		.get(2))));
												double diffMWCG = 0.00, diffNWC = 0.00;
												diffMWCG = WCG - MWCG;
												diffNWC = WCG - NWC;
												if (diffMWCG < diffNWC) {
													vecVal.add(nf
															.format(diffMWCG));
												} else {
													vecVal.add(nf
															.format(diffNWC));
												}
											} else {
												vecVal.add("0.00");
											}
										} else if ((cma.equalsIgnoreCase("5") && (finrowid
												.equalsIgnoreCase("1227")
												|| finrowid
														.equalsIgnoreCase("1238") || finrowid
												.equalsIgnoreCase("1231")))
												|| (cma.equalsIgnoreCase("9") && (finrowid
														.equalsIgnoreCase("1221")
														|| finrowid
																.equalsIgnoreCase("1243") || finrowid
														.equalsIgnoreCase("1225")))||(cma.equalsIgnoreCase("1") && (finrowid
																.equalsIgnoreCase("1302")
																|| finrowid
																		.equalsIgnoreCase("1272") || finrowid
																.equalsIgnoreCase("1307")))) {
											if (vecVal.size() >= 3) {
												double dblMPBF = Double
														.parseDouble((Helper
																.correctDouble((String) vecVal
																		.get(3))));
												double diffMPBF = 0.00;
												diffMPBF = dblBankBorr
														- dblMPBF;
												if (diffMPBF > 0) {
													vecVal.add(nf
															.format(diffMPBF));
												} else {
													vecVal.add("0.00");
												}
											} else {
												vecVal.add("0.00");
											}
										} else {
											vecVal.add("0.00");
										}
										vecid.add(correctNull(rs1
												.getString("fin_rowid")));
									}
									hshValues.put("year" + k, vecVal);
									hshValues.put("vecid" + k, vecid);
									

								}

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
								vecrecStrt.add(yearselect_strt);
								hshValues.put("FPSno" + (o++), sno);
							}

						}
					}

				}
				yearint = yearint + 1;
				tempyear = sno;

			}
			hshValues.put("strPage", strPage);
			hshValues.put("from", Integer.toString(from));
			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("yearvalueStrt", vecrecStrt);
			hshValues.put("page", page);
			hshValues.put("cma_no", cma);
			hshValues.put("appno", strValue);
			hshValues.put("strFinID", strFinID);
			hshValues.put("appname", strAppName);
			hshValues.put("tempyear", tempyear);

			
			//To retrieve the tab details
			vecVal = new ArrayList();
			strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+ strFinID);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				cma = Helper.correctNull((String) rs.getString("fin_cmano"));
			}
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);
			}
			
			hshValues.put("tabdetails", vecVal);
			hshValues.put("finace_id", strFinID);
			hshValues.put("appidnew", appidnew);
			hshValues.put("fintype", cma);
			hshValues.put("hidapplicantid", Helper.correctInt((String) hshRequestValues.get("hidAppId")));
			hshValues.put("AssetandLiab", Helper.correctNull((String) hshRequestValues.get("AssetandLiab")));
			hshValues.put("sessionModuleType", Helper.correctNull((String) hshRequestValues.get("sessionModuleType")));
			hshValues.put("cattype", Helper.correctNull((String) hshRequestValues.get("cattype")));

	 		HashMap hshQueryValues= new HashMap();
	 		HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			//Ratios table entry
			if(Helper.correctNull((String)hshRequestValues.get("hidPageId")).equals("comwrflw"))
			{	
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_rationsTableEntry");
				arrValues.add(strValue);
				arrValues.add(strPage);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");

				int sizeyear=0,to=0,vecModSize=0,n=0;
				String temp="",totcount="",upto="",pageval="",strCurModule="";
				
				ArrayList  g21=(ArrayList) hshValues.get("yearvalue");
				String yearval[] = null;
				String comboselect[] = null;
				
				 if (g21.size() != 0)
				 {
						 sizeyear=g21.size();
						 yearval=new String[(g21.size()/2)];
						 comboselect=new String[(g21.size()/2)];
					for (int k1=0;k1<=g21.size()-1;k1++)
					{
							if ((k1 % 2 ) == 0)
							{
								temp=Helper.correctNull((String)g21.get(k1));
								yearval[y]=temp;
								y =y+1;
							}
							else if ((k1 % 2) == 1)
							{
								temp=Helper.correctNull((String)g21.get(k1));
									if (temp.trim().equalsIgnoreCase("fin_audit"))
									{
										temp = "a";
									}
									else if (temp .trim().equalsIgnoreCase("fin_unaudit"))
									{
										temp = "u";
									}
									else if (temp.trim().equalsIgnoreCase("fin_estimated"))
									{
										temp = "e";
									}
									else if (temp.trim().equalsIgnoreCase("fin_projection"))
									{
									temp = "p";
									}
								comboselect[n]=temp;
								n = n+1;
							}	 		
						}
//						for (int d = 0 ; d <= 4 ; d++)
//						 {
//							if (comboselect[d] == null)
//							 {
//								comboselect[d] = " ";
//							 }
//							if (yearval[d] == null)
//							 {
//								yearval[d]="";			
//							 }			 
//						 }		 
					 }
					 else
					 {		
//						 for ( p=0;p<=4;p++)
//						 {
//							comboselect[p]= " ";		
//							yearval[p]= "";
//						 }
					 }
			 		int totalyear=Integer.valueOf(Helper.correctInt((String)hshValues.get("totalyear")));
			 		String yeardata="";
			 		String fintype="";
			 		ArrayList v1=(ArrayList) hshValues.get("vecid1");
			 		ArrayList vecData=new ArrayList();
			 		String test="0.00";
			 		for(int m=0;m<totalyear;m++)
			 		{
			 			yeardata=yearval[m];
			 			fintype=comboselect[m];
			 			
			 			if (rs != null) 
							rs.close();
			 			strQuery = SQLParser.getSqlQuery("sel_comratiosel_year^" +strValue+"^"+yeardata+"^"+strPage);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							vecData=(ArrayList) hshValues.get("year"+(m+1));
				 			hshQueryValues= new HashMap();
				 			int intUpdatesize=0;
				 			for(int s=0;s<v1.size();s++)
				 			{
				 				hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize = intUpdatesize+1;
								arrValues.add(Helper.correctDouble((String)vecData.get(s)));
								arrValues.add(yeardata);
								arrValues.add(strValue);
								arrValues.add(Helper.correctInt((String)v1.get(s)));
								arrValues.add(strPage);
								if(fintype.equals("a"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up1");
								}
								else if(fintype.equals("u"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up2");
								}
								else if(fintype.equals("e"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up3");
								}
								else if(fintype.equals("p"))
								{
									hshQuery.put("strQueryId","upd_appratiovalues_up4");
								}
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
								hshQueryValues.put("size",String.valueOf(intUpdatesize));
				 			}
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
 							
						}
						else
						{
							vecData=(ArrayList) hshValues.get("year"+(m+1));
				 			hshQueryValues= new HashMap();
				 			int intUpdatesize=0;
				 			for(int s=0;s<v1.size();s++)
				 			{
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize = intUpdatesize+1;
								arrValues.add(strValue);
								arrValues.add(yeardata);
								arrValues.add(Helper.correctInt((String)v1.get(s)));
								if(fintype.equals("a"))
								{
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
								}
								else if(fintype.equals("u"))
								{
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
									arrValues.add(test);
								}
								else if(fintype.equals("e"))
								{
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
									arrValues.add(test);
								}
								else if(fintype.equals("p"))
								{
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(test);
									arrValues.add(Helper.correctDouble((String)vecData.get(s)));
								}
								arrValues.add(String.valueOf(m+1));
								arrValues.add(strPage);
								hshQuery.put("strQueryId","ins_ratiosTableEntry");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
								hshQueryValues.put("size",String.valueOf(intUpdatesize));
				 			}
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
			 			
			 		} 
			}
			
		/*	// Added by Kishan
			strQuery = SQLParser
					.getSqlQuery("com_selfin_printyear^" + strFinID);
			rs = DBUtils.executeQuery(strQuery);
			String printCheck = "";
			while (rs.next()) {
				printCheck = printCheck
						+ Helper.correctNull((String) rs
								.getString("finprintyear_labelname")) + "-";
			}
			hshValues.put("printCheck", printCheck);*/
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rsFormulaFor != null)
					rsFormulaFor.close();
				if (rsPrevYear != null)
					rsPrevYear.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;

	}
	public HashMap getCorpAnnexureII(HashMap hshReqValues) 
	{
		ResultSet rs 		= null, rs1	= null,rs2=null;
		HashMap hshValues	= new HashMap();
		String strAppId="",strAppNo="",strValuesIn="", strVal="", strType="", strPromoterChk="", strVal1="",strVal2="",strNW="",strValuesIn1="";
		String strAmountValue="",strAmtValueIn="",strfacno="";
		HashMap hshReqDetails=null;
		HashMap hshRespDetails=null;				
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		ArrayList arrRowPrmo	= new ArrayList();
		ArrayList arrColPrmo	= new ArrayList();
		ArrayList arrRowDefault	= new ArrayList();
		ArrayList arrColDefault	= new ArrayList();
		ArrayList arrRowEcgc	= new ArrayList();
		ArrayList arrColEcgc	= new ArrayList();
		
		String strCommentMgmtSno[]	= {"1","2","3","4","5","6","7","8","9","10","11"};
		String strQuery="";
		String arrBranchtype[]={"1","2","3"};
		String strTypeArr[]	= null;
		String strTypecheck[]	= null;
		try
		{
			strAppId	= correctNull((String)hshReqValues.get("strAppId"));
			strAppNo	= correctNull((String)hshReqValues.get("strAppNo"));
			strfacno	= correctNull((String)hshReqValues.get("strFacNo"));
			
			if(rs!=null){rs.close();}
			if(strAppId.equalsIgnoreCase(""))
			{
				rs	= DBUtils.executeLAPSQuery("sel_perapp_id^"+strAppNo);
				if(rs.next())
				{
					strAppId= correctNull(rs.getString("perapp_id"));
				}
			}
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selorgno^"+strAppNo);
			if(rs.next())
			{
				strValuesIn	= correctNull(rs.getString("app_valuesin"));
			}
			
			if(rs!=null){rs.close();}
			
			//Values In
			if(strValuesIn.equals("C")){strValuesIn1			= "Crore";}
			else if(strValuesIn.equals("L")){strValuesIn1	= "Lacs";}
			else if(strValuesIn.equals("R")){strValuesIn1	= "Rs";}
			
			hshValues.put("strValuesIn", strValuesIn1);
			
			rs	= DBUtils.executeLAPSQuery("sel_amountvalue^"+strAppNo);
			if(rs.next())
			{
		    strAmountValue= Helper.correctNull(rs.getString("com_amountvalue"));
		    hshValues.put("strAmountValue", strAmountValue);
			}
			
			if(strAmountValue.equalsIgnoreCase("C"))
			{strAmtValueIn ="Crore";}
			else if(strAmountValue.equalsIgnoreCase("L")){strAmtValueIn ="Lacs";}
			else{strAmtValueIn ="Rs";}
			
			hshValues.put("strAmtValueIn", strAmtValueIn);
			
			String strNewId="0";
			rs=DBUtils.executeLAPSQuery("findBorrowerOrgCom^"+strAppId);
			if(rs.next())
			{arrRowPrmo	= new ArrayList();
				strNewId=Helper.correctNull((String)rs.getString("perapp_id"));
				arrColPrmo.add(strNewId);
				arrColPrmo.add(Helper.changetoTitlecase(Helper.correctNull(rs.getString("perapp_fname"))));
				arrColPrmo.add("A");
				arrRowPrmo.add(arrColPrmo);
			}
			if(rs!=null)
			{
				rs.close();
			}
			//Coapplicant,Promoters,Garunters;
			
			String strCoAppExID="",strCoAppExType="",strCoAppID="";
			
			rs	= DBUtils.executeLAPSQuery("compromoterselectionpromoters^"+strAppNo);
			while(rs.next())
			{
				strType			= correctNull(rs.getString("com_compdttype"));
				strCoAppID			= correctNull(rs.getString("com_oldlapsid"));
				if((strCoAppID.equalsIgnoreCase(strCoAppExID)) && (strType.equalsIgnoreCase(strCoAppExType)))
					continue;
				if(!strType.equals(""))
				{
					arrRowPrmo	= new ArrayList();
					arrColPrmo= new ArrayList();
					arrColPrmo.add(Helper.correctInt(rs.getString("com_compdtappid")));
					arrColPrmo.add(Helper.changetoTitlecase(Helper.correctNull(rs.getString("com_compdtfname"))));
					arrColPrmo.add(strType);
					arrColPrmo.add(Helper.correctNull(rs.getString("COM_COMPRELATIONSHIP")));
					arrRowPrmo.add(arrColPrmo);
				}
				
				strCoAppExID			= correctNull(rs.getString("com_oldlapsid"));
				strCoAppExType			= correctNull(rs.getString("com_compdttype"));
			}
			if(rs!=null){rs.close();}

			// Group management people
			rs	= DBUtils.executeLAPSQuery("com_groupmanagement_people^"+strAppNo);
			while(rs.next())
			{
				strType	= correctNull(rs.getString("COMAPP_DIVISIONTYPE"));
				if(!strType.equals(""))
				{arrRowPrmo	= new ArrayList();
					arrColPrmo= new ArrayList();
					arrColPrmo.add(Helper.correctInt(rs.getString("comapp_div_appid")));
					arrColPrmo.add(Helper.changetoTitlecase(Helper.correctNull(rs.getString("COMAPP_DIV_NAME"))));
					arrColPrmo.add(strType);
					arrColPrmo.add(Helper.changetoTitlecase(Helper.correctNull(rs.getString("COMAPP_RELATION"))));
					arrRowPrmo.add(arrColPrmo);
				}	
			}
			if(rs!=null){rs.close();} 
			
			//Customer Profile
			
			rs	= DBUtils.executeLAPSQuery("sel_common_customer^"+strNewId);
			if(rs.next())
			{
				hshValues.put("perapp_title",  Helper.changetoTitlecase(Helper.correctNull(rs.getString("perapp_title"))));
				hshValues.put("perapp_name", Helper.correctNull(rs.getString("perapp_fname")));
				hshValues.put("cominfo_commencement_date", correctNull(rs.getString("cominfo_commencement_date")));
				hshValues.put("cominfo_incorporation_date", correctNull(rs.getString("cominfo_incorporation_date")));
				hshValues.put("perapp_dob", correctNull(rs.getString("perapp_dob")));
				hshValues.put("perapp_banksince", correctNull(rs.getString("perapp_banksince")));
				hshValues.put("COMINFO_GSTINREG", correctNull(rs.getString("COMINFO_GSTINREG")));
				hshValues.put("PERAPP_MSE_REGNO", correctNull(rs.getString("PERAPP_MSE_REGNO")));
				hshValues.put("COMINFO_GSTIN", correctNull(rs.getString("COMINFO_GSTIN")));
				hshValues.put("PERAPP_UDYOG_AADHAR", correctNull(rs.getString("PERAPP_UDYOG_AADHAR")));
				if(rs1!=null){rs1.close();}
				rs1	= DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^2^"+correctNull(rs.getString("perapp_constitution")));
				if(rs1.next())
				{
					//if(correctNull((String)rs1.getString("cbs_static_data_code")).trim().equals(correctNull(rs.getString("perapp_constitution")).trim()))
					//{
						hshValues.put("cbs_static_data_desc", correctNull(rs1.getString("cbs_static_data_desc")));
					//}
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1	= DBUtils.executeLAPSQuery("selstatdatabyiddesc^110^"+correctNull(rs.getString("perapp_relation_bankstaff")));
				if(rs1.next())
				{
					//if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull(rs.getString("perapp_relation_bankstaff")).trim()))
					//{
						hshValues.put("stat_data_desc1", Helper.correctNull(rs1.getString("stat_data_desc1")));
					//}
				}
				hshValues.put("PEREMP_EXPINYRS", correctNull(rs.getString("PEREMP_EXPINYRS")));
				hshValues.put("PERAPP_NETWORTH", correctNull(rs.getString("PERAPP_NETWORTH")));
			}

			//Added for CGTMSE Promotor Contribution
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("sel_CropCgtmse^"+strAppNo+"^"+"1");
			if(rs1.next())
			{	
				hshValues.put("CG_TC_PROMOTERS", correctNull(rs1.getString("CG_TC_PROMOTERS")));
				hshValues.put("CG_DEFAULTER", correctNull(rs1.getString("CG_DEFAULTER")));
			}

			//Added for CGTMSE Promotor Contribution
			/*if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("sel_CropCgtmse^"+strAppNo+"^"+strfacno);
			if(rs1.next())
			{	
				hshValues.put("CG_TC_PROMOTERS", correctNull(rs1.getString("CG_TC_PROMOTERS")));
				hshValues.put("CG_DEFAULTER", correctNull(rs1.getString("CG_DEFAULTER")));
			}*/

			//Indv Query to retrieve all group info by Guhan 
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_All_GroupInfo^"+strAppId+"^"+strAppNo+"^"+strAppNo);
			while(rs.next())
			{
				arrColPrmo = new ArrayList();
				arrColPrmo.add(Helper.correctNull((String)rs.getString("perapp_id")));
				arrColPrmo.add(Helper.changetoTitlecase(Helper.correctNull(rs.getString("perapp_fname"))));
				arrColPrmo.add(Helper.correctNull((String)rs.getString("strtype")));
				arrColPrmo.add(Helper.correctNull((String)rs.getString("relationtype")));
				arrRowPrmo.add(arrColPrmo);
			}
			
			arrRow = new ArrayList();
			for(int i=0;i<arrRowPrmo.size();i++)
			{
				arrColPrmo=(ArrayList)arrRowPrmo.get(i);
				strPromoterChk	= "false";
				strType=Helper.correctNull((String)arrColPrmo.get(2));
				strTypecheck = strType.split("@");
				for(int j=0;j<strTypecheck.length;j++)
				{
						if(strPromoterChk.equalsIgnoreCase("false"))
						{
							strPromoterChk	= "true";
							rs	= DBUtils.executeLAPSQuery("sel_common_customer_newid^"+Helper.correctInt((String)arrColPrmo.get(0))+"^"+Helper.correctInt((String)arrColPrmo.get(0)));
							if(rs.next())
							{
								rs1	= DBUtils.executeLAPSQuery("selstatdatabyiddesc^110^"+correctNull(rs.getString("perapp_relation_bankstaff")));
								while(rs1.next())
								{
									//if(correctNull((String)rs1.getString("stat_data_desc")).trim().equals(correctNull((String)rs.getString("perapp_relation_bankstaff")).trim()))
									//{ 
										arrCol = new ArrayList();
										arrCol.add(arrColPrmo.get(0));
										arrCol.add(arrColPrmo.get(1));
										if(correctNull((String)rs1.getString("STAT_DATA_DESC")).equalsIgnoreCase("006"))
										{
											arrCol.add("Not Related");
										}
										else{
											arrCol.add(Helper.changetoTitlecase(Helper.correctNull(rs1.getString("stat_data_desc1"))));
										}
										arrRow.add(arrCol);
									//}
								}
							}
							else
							{
								arrCol = new ArrayList();
								arrCol.add(arrColPrmo.get(0));
								arrCol.add(arrColPrmo.get(1));
								arrCol.add("Not Related");
								arrRow.add(arrCol);
							}
						}
				}
			}
			hshValues.put("Relationship",arrRow);

			//Address of the customer Admin office/Registerd office
			String Address="",strAd1="",strAd2="",strAd3="",strCity="";
			String strDis="",strState="",app_constitution="",strZip="";
			 MastApplicantBean msb=new MastApplicantBean();
			 hshReqDetails=new HashMap();
			 hshReqDetails.put("strPageType", "annexure");
			 hshReqDetails.put("hidapplicantnewid", strNewId);
			 hshRespDetails=msb.getAddressDetails(hshReqDetails); 
			 hshValues.put("hshRespDetails", hshRespDetails);

			
			//Factory Details
			if(rs!=null){rs.close();}
			int intSize=arrBranchtype.length;
			arrRow=new ArrayList();
			arrCol = new ArrayList();
			for(int l =0;l<intSize;l++)
    		{
				arrRow=new ArrayList();
				rs	= DBUtils.executeLAPSQuery("selallfactorydetailsbytype^"+strNewId+"^"+arrBranchtype[l]);
				while(rs.next())
				{
					arrCol = new ArrayList(); 
					arrCol.add(correctNull((String)rs.getString("comapp_detailtype")));//0
					arrCol.add(correctNull((String)rs.getString("comapp_name")).toUpperCase());//1
					arrCol.add(correctNull((String)rs.getString("comapp_add")).toUpperCase());//2		
					String strCitycode = Helper.correctNull((String)rs.getString("comapp_city"));//4
					String strCityDesc="";
					if(!strCitycode.equalsIgnoreCase(""))
					{				
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
					if(rs1.next())
					{
						
						strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
					}
					}
					arrCol.add(strCitycode);//5
					arrCol.add(strCityDesc.toUpperCase());//6
					
					String strStatecode = Helper.correctNull((String)rs.getString("comapp_state"));	
					String strStateDesc="";
					if(!strStatecode.equalsIgnoreCase(""))
					{				
					if(rs1!=null)
					{
						rs1.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
					if(rs2.next())
					{
						
						strStateDesc = Helper.correctNull((String)rs2.getString("state_name"));					
					}
					}
					arrCol.add(strStatecode);//7
					arrCol.add(strStateDesc.toUpperCase());//8
					arrCol.add(correctNull((String)rs.getString("comapp_pincode")));//9
					arrRow.add(arrCol);
				}
				if(arrCol.size()>0)
				{
					hshValues.put("arrBranchRow"+l, arrRow);
				}
				arrCol = new ArrayList();
    		}
			
			if(rs!=null){rs.close();}

			//Defaulter's List
			for(int i=0;i<arrRowPrmo.size();i++)
			{
				arrColPrmo=(ArrayList)arrRowPrmo.get(i);
				strPromoterChk	= "false";
				strType=Helper.correctNull((String)arrColPrmo.get(2));
				strTypecheck = strType.split("@");
				for(int j=0;j<strTypecheck.length;j++)
				{
						if(strPromoterChk.equalsIgnoreCase("false"))
						{
							strPromoterChk	= "true";
							String strDefsuitfill="";
							rs	= DBUtils.executeLAPSQuery("cusdefaulter_sel^"+Helper.correctInt((String)arrColPrmo.get(0))+"^"+Helper.correctInt((String)arrColPrmo.get(0)));
							if(rs.next())
							{	
								strVal	= correctNull(rs.getString("def_rbidefis"));
								if(strVal.equals("Y"))
								{
									strVal	= "Yes";
									arrColDefault = new ArrayList();
									arrColDefault.add(arrColPrmo.get(0));
									arrColDefault.add(arrColPrmo.get(1));
									arrColDefault.add(strVal);
									arrColDefault.add(Helper.correctNull(rs.getString("asonRBIdate")));
									arrColDefault.add(Helper.correctNull(Helper.CLOBToString((rs.getClob("def_rbidefcomm")))));
									if(Helper.correctNull(Helper.correctNull(rs.getString("DEF_SUITFILED"))).equalsIgnoreCase("Y")){
										strDefsuitfill="Yes";
									}else{
										strDefsuitfill="No";
									}
									arrColDefault.add(strDefsuitfill);
									arrColDefault.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_SUITFILEDCOMM"))));
									arrRowDefault.add(arrColDefault);
									
								}
								else
								{
									strVal	= "No";
									arrColDefault = new ArrayList();
									arrColDefault.add(arrColPrmo.get(0));
									arrColDefault.add(arrColPrmo.get(1));
									arrColDefault.add(strVal);
									arrColDefault.add(Helper.correctNull(rs.getString("asonRBIdate")));
									arrColDefault.add("Not applicable");
									if(Helper.correctNull(Helper.correctNull(rs.getString("DEF_SUITFILED"))).equalsIgnoreCase("Y")){
										strDefsuitfill="Yes";
									}else{
										strDefsuitfill="No";
									}
									arrColDefault.add(strDefsuitfill);
									arrColDefault.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_SUITFILEDCOMM"))));
									arrRowDefault.add(arrColDefault);
								}
								
									strVal	= "";
									strVal	= correctNull(rs.getString("def_ecgsepis"));
									
									if(strVal.equals("Y"))
									{
										strVal	= "Yes";
										arrColEcgc = new ArrayList();
										arrColEcgc.add(arrColPrmo.get(0));
										arrColEcgc.add(arrColPrmo.get(1));
										arrColEcgc.add(strVal);
										arrColEcgc.add(Helper.correctNull(rs.getString("asonECGCIdate")));
										arrColEcgc.add(Helper.correctNull(Helper.CLOBToString((rs.getClob("def_ecgsepcomm")))));
										arrRowEcgc.add(arrColEcgc);
									}
									else
									{
										strVal	= "No";
										arrColEcgc = new ArrayList();
										arrColEcgc.add(arrColPrmo.get(0));
										arrColEcgc.add(arrColPrmo.get(1));
										arrColEcgc.add(strVal);
										arrColEcgc.add(Helper.correctNull(rs.getString("asonECGCIdate")));
										arrColEcgc.add("Not Applicable");
										arrRowEcgc.add(arrColEcgc);
									}
									if(Helper.correctNull(Helper.correctNull(rs.getString("DEF_SUITFILED"))).equalsIgnoreCase("Y"))
									{
										hshValues.put("com_whtrsuitactioncon","Yes");	
									}else if(Helper.correctNull(Helper.correctNull(rs.getString("DEF_SUITFILED"))).equalsIgnoreCase("N"))
									{
										hshValues.put("com_whtrsuitactioncon","No");	
									}
									hshValues.put("com_whtrsuitaction",Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_SUITFILEDCOMM"))));
							}
						}
				}
			}
			hshValues.put("arrRowDefault", arrRowDefault);
			hshValues.put("arrRowEcgc", arrRowEcgc);
			if(rs!=null){rs.close();}
			
			//CIBIL
			arrRow	= new ArrayList();
			for(int i=0;i<arrRowPrmo.size();i++)
			{
				arrColPrmo=(ArrayList)arrRowPrmo.get(i);
				strPromoterChk	= "false";
				String strSMACategory="",strcheifpro="",strPromoNpa="";
				strType=Helper.correctNull((String)arrColPrmo.get(2));
				strTypecheck = strType.split("@");
				for(int j=0;j<strTypecheck.length;j++)
				{
						if(strPromoterChk.equalsIgnoreCase("false"))
						{
							strPromoterChk	= "true";			
							rs	= DBUtils.executeLAPSQuery("cuscibildetails_sel^"+Helper.correctInt((String)arrColPrmo.get(0))+"^"+Helper.correctInt((String)arrColPrmo.get(0)));
							if(rs.next())
							{
								strVal	= correctNull(rs.getString("cibil_rat_status")).trim();
								
								if(strVal.equalsIgnoreCase("Y")){	strVal	= "Yes";}
								else if(strVal.equalsIgnoreCase("N")){strVal	= "No";}
								else{strVal	= "";}
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("corp_cgtmse_cheifpromotor^"+strAppNo+"^"+Helper.correctInt((String)arrColPrmo.get(0)));
								if(rs2.next())
								{
									strcheifpro=Helper.correctNull(rs2.getString("COMAPP_CHF_PROMOTER")).trim();
									strPromoNpa=Helper.correctNull(rs2.getString("COMAPP_CHF_NPA")).trim();
										if(strPromoNpa.equalsIgnoreCase("Y"))
											strPromoNpa="Yes";
										else if(strPromoNpa.equalsIgnoreCase("N"))
											strPromoNpa="No";
										else
											strPromoNpa="";
								}
								
								if(correctNull(rs.getString("cibil_rat_status")).trim().equalsIgnoreCase("Y"))
								{
									arrCol = new ArrayList();
									arrCol.add(arrColPrmo.get(0));
									arrCol.add(arrColPrmo.get(1)); //1
									arrCol.add(strVal);//2
									arrCol.add(Helper.correctNull(rs.getString("cibil_reporteddate")));//3
									arrCol.add(Helper.correctNull(rs.getString("cibil_score")));//4
									arrCol.add(Helper.correctNull((rs.getString("cibil_details"))));//5
									if(correctNull(rs.getString("cibil_smacategory")).trim().equalsIgnoreCase("Y")){
										strSMACategory="Yes";

									}
									else if(correctNull(rs.getString("cibil_smacategory")).trim().equalsIgnoreCase("NA")){
										strSMACategory="Not Applicable";
									}
									else{
										strSMACategory="No";
									}
									arrCol.add(Helper.correctNull(strSMACategory));//6
									arrCol.add(Helper.correctNull((rs.getString("cibil_smadetails"))));//7
									arrCol.add(strTypecheck[j]);//8
									arrCol.add(Helper.correctNull((rs.getString("cibil_CRILC"))));//9
									
									if(correctNull(rs.getString("CRIF_REFERED")).trim().equalsIgnoreCase("Y")){
										arrCol.add("Yes");//10
										arrCol.add(Helper.correctNull(rs.getString("CRIF_SCORE")));//11
										arrCol.add(Helper.correctNull(rs.getString("CRIF_DETAILS")));//12
										arrCol.add(Helper.correctNull(rs.getString("CRIF_DATE")));//13
									}
									else if(correctNull(rs.getString("CRIF_REFERED")).trim().equalsIgnoreCase("NA")){
										arrCol.add("Not Applicable");//10
										arrCol.add("");//11
										arrCol.add("");//12
										arrCol.add("");//13
									}
									else{
										arrCol.add("No");//10
										arrCol.add("");//11
										arrCol.add("");//12
										arrCol.add("");//13
									}
									arrCol.add(strcheifpro);//14
									 arrCol.add(strPromoNpa);//15
									// Added for Experian Commercial score 
										if(correctNull(rs.getString("EXPERIAN_REFERED")).trim().equalsIgnoreCase("Y")){
											arrCol.add("Yes");//16
											arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_SCORE")));//17
											arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_DETAILS")));//18
											arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_DATE")));//19
										}
										else if(correctNull(rs.getString("EXPERIAN_REFERED")).trim().equalsIgnoreCase("NA")){
											arrCol.add("Not Applicable");//16
											arrCol.add("");//17
											arrCol.add("");//18
											arrCol.add("");//19
										}
										else{
											arrCol.add("No");//16
											arrCol.add("");//17
											arrCol.add("");//18
											arrCol.add("");//19
										}
									 
									arrRow.add(arrCol);
								}
								else
								{
									arrCol = new ArrayList();
									arrCol.add(arrColPrmo.get(0));
									arrCol.add(arrColPrmo.get(1));
									arrCol.add(strVal);
									arrCol.add(Helper.correctNull(rs.getString("cibil_reporteddate")));
									arrCol.add("");
									arrCol.add("");
									if(correctNull(rs.getString("cibil_smacategory")).trim().equalsIgnoreCase("Y")){
										strSMACategory="Yes";

									}
									else if(correctNull(rs.getString("cibil_smacategory")).trim().equalsIgnoreCase("NA")){
										strSMACategory="Not Applicable";
									}
									else{
										strSMACategory="No";
									}
									arrCol.add(Helper.correctNull(strSMACategory));//6
									arrCol.add(Helper.correctNull((rs.getString("cibil_smadetails"))));//7
									arrCol.add(strTypecheck[j]);//8
									arrCol.add(Helper.correctNull((rs.getString("cibil_CRILC"))));//9
									
									if(correctNull(rs.getString("CRIF_REFERED")).trim().equalsIgnoreCase("Y")){
										arrCol.add("Yes");//10
										arrCol.add(Helper.correctNull(rs.getString("CRIF_SCORE")));//11
										arrCol.add(Helper.correctNull(rs.getString("CRIF_DETAILS")));//12
										arrCol.add(Helper.correctNull(rs.getString("CRIF_DATE")));//13
									}
									else if(correctNull(rs.getString("CRIF_REFERED")).trim().equalsIgnoreCase("NA")){
										arrCol.add("Not Applicable");//10
										arrCol.add("");//11
										arrCol.add("");//12
										arrCol.add("");//13
									}
									else{
										arrCol.add("No");//10
										arrCol.add("");//11
										arrCol.add("");//12
										arrCol.add("");//13
									}
									arrCol.add(strcheifpro);//14
									arrCol.add(strPromoNpa);//15
									// Added for Experian Commercial score 
									if(correctNull(rs.getString("EXPERIAN_REFERED")).trim().equalsIgnoreCase("Y")){
										arrCol.add("Yes");//16
										arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_SCORE")));//17
										arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_DETAILS")));//18
										arrCol.add(Helper.correctNull(rs.getString("EXPERIAN_DATE")));//19
									}
									else if(correctNull(rs.getString("EXPERIAN_REFERED")).trim().equalsIgnoreCase("NA")){
										arrCol.add("Not Applicable");//16
										arrCol.add("");//17
										arrCol.add("");//18
										arrCol.add("");//19
									}
									else{
										arrCol.add("No");//16
										arrCol.add("");//17
										arrCol.add("");//18
										arrCol.add("");//19
									}
									arrRow.add(arrCol);
								}
								hshValues.put("whtrCIBIL", strVal);
							}
						}
				}
			}
			hshValues.put("arrRowCIBIL", arrRow);
			
			String strEmpstatus="";
			strCoAppExID="";strCoAppExType="";strCoAppID="";
			//Co-Obligants/ Guarantors 
			arrRow	= new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("compromoterselectionpromoters^"+strAppNo);
			String strid="0";
			while(rs.next())
			{
				strVal			= "";
				strEmpstatus="";
				strPromoterChk	= "false";
				arrCol	= new ArrayList();
				
				strType			= correctNull(rs.getString("com_compdttype"));
				
				strCoAppID			= correctNull(rs.getString("com_oldlapsid"));
				if((strCoAppID.equalsIgnoreCase(strCoAppExID)) && (strType.equalsIgnoreCase(strCoAppExType)))
				continue;
				/*if(!strType.equals(""))
				{
					strTypeArr			= strType.split("@");
				}*/
				/*
				if(strTypeArr!=null)
				{
					for(int i=0;i<strTypeArr.length;i++)
					{
						if(strTypeArr[i].equalsIgnoreCase("G")||strTypeArr[i].equalsIgnoreCase("CO"))
						{
							if(strPromoterChk.equals("false"))
							{
								strVal1	= strTypeArr[i];*/
								//strPromoterChk	= "true";
								arrCol.add(Helper.changetoTitlecase(correctNull(rs.getString("com_compdtfname"))));//0
								
								if(rs1!=null){rs1.close();}
								rs1= DBUtils.executeLAPSQuery("sel_presanactionage^"+Helper.correctInt(rs.getString("com_compdtappid")));
								
								if(rs1.next())
								{
									strid=Helper.correctInt(rs.getString("com_compdtappid"));
									arrCol.add(correctNull(rs1.getString("age")));//1
									strVal	= correctNull(rs1.getString("perapp_constitution"));
									strVal2	= correctNull(rs1.getString("perapp_networthason"));
									strNW	= Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perapp_networth"))));
									strEmpstatus=correctNull(rs1.getString("perapp_employment"));
								}
								else
								{
									arrCol.add("0");
								}
								
								if(strEmpstatus.equals("1") || strEmpstatus.equals("9"))
								{
									if(rs1!=null){rs1.close();}
									rs1= DBUtils.executeLAPSQuery("pergetIncome1^"+Helper.correctInt(rs.getString("com_compdtappid")));
									
									if(rs1.next())
									{
										arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perinc_takehome")))));//2
									}
									else
									{
										arrCol.add("0.00");
									}
									
								}
								else
								{
									if(rs1!=null){rs1.close();}
									rs1= DBUtils.executeLAPSQuery("pergetIncome1^"+Helper.correctInt(rs.getString("com_compdtappid")));
									
									if(rs1.next())
									{
										arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perinc_year1_income")))));//2
									}
									else
									{
										arrCol.add("0.00");
									}
								}
								arrCol.add(Helper.changetoTitlecase(Helper.correctNull((String)rs.getString("com_comprelationship"))));//3
								arrCol.add(strNW);//4
								arrCol.add(strVal2);//5
								arrCol.add(strType);//6
								if(rs1!=null){rs1.close();}
								rs2= DBUtils.executeLAPSQuery("pergetIncome1^"+strid);
								
								if(rs2.next())
								{
									arrCol.add(Helper.correctNull(rs2.getString("PERINC_YEAREND1")));//7
								}
								else
								{
									arrCol.add("");
								}
								arrCol.add(Helper.correctNull(rs.getString("com_compborrname")));//8
								arrCol.add(Helper.correctInt(rs.getString("com_compdtappid")));//9
								if(arrCol.size()>0)
								{
									arrRow.add(arrCol);
								}
								arrCol= new ArrayList();
							//}
						//}
					//}
				//}
								
				strCoAppExID			= correctNull(rs.getString("com_oldlapsid"));
				strCoAppExType			= correctNull(rs.getString("com_compdttype"));
				
			}
			hshValues.put("arrGuaRow", arrRow);
			
			//Promoter/ Director /Co-Obligants/ Guarantors
			arrRow=new ArrayList();
			arrCol= new ArrayList();
			
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("selpromotorsfromappprof^"+strAppNo+"^"+strAppNo+"^"+strAppNo);
			
			while(rs.next())
			{
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeLAPSQuery("selpromotrsdirectordetails^"+Helper.correctInt(rs.getString("com_compdtappid")));
				if(rs2.next())
				{
					arrCol.add(Helper.changetoTitlecase(correctNull(rs2.getString("appname"))));//0
					
					arrCol.add(correctNull(rs2.getString("age")));//1
					strVal	= correctNull(rs2.getString("perapp_constitution"));
					strVal2	= correctNull(rs2.getString("perapp_networthason"));
					strNW	= Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs2.getString("perapp_networth"))));
					strEmpstatus=correctNull(rs2.getString("perapp_employment"));
					if(strEmpstatus.equals("1") || strEmpstatus.equals("9"))
					{
						arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs2.getString("perinc_takehome")))));//2
					}
					else
					{
						arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs2.getString("perinc_year1_income")))));//2
					}
					arrCol.add("");//3
					arrCol.add(strNW);//4
					arrCol.add(strVal2);//5
					arrCol.add("");//6
					arrCol.add(Helper.correctNull(rs2.getString("PERINC_YEAREND1")));//7
					arrCol.add(Helper.correctNull(Helper.correctNull(rs.getString("COM_COMPBORRNAME"))));//8
					if(arrCol.size()>0)
					{
						arrRow.add(arrCol);
					}
					arrCol= new ArrayList();
				}
				else
				{
					arrCol.add(Helper.changetoTitlecase(correctNull(rs.getString("COM_COMPBORRNAME"))));//0
					arrCol.add("");//1
					arrCol.add("");//2
					arrCol.add("");//3
					arrCol.add("");//4
					arrCol.add("");//5
					arrCol.add("");//6
					arrCol.add("");//7
					arrCol.add("");//8
					if(arrCol.size()>0)
					{
						arrRow.add(arrCol);
					}
					arrCol= new ArrayList();
				}
			}
			hshValues.put("arrPromoterRow", arrRow);
			
			
			//Co-Obligants/ Guarantors 
			/*arrRow	= new ArrayList();
			if(rs!=null){rs.close();}
			rs	= DBUtils.executeLAPSQuery("compromoterselectionpromoters^"+strAppNo);
			
			while(rs.next())
			{
				strVal			= "";
				strPromoterChk	= "false";
				arrCol	= new ArrayList();
				
				strType			= correctNull(rs.getString("com_compdttype"));
				if(!strType.equals(""))
				{
					strTypeArr			= strType.split("@");
				}
				
				if(strTypeArr!=null)
				{
					for(int i=0;i<strTypeArr.length;i++)
					{
						if(strTypeArr[i].equalsIgnoreCase("G")||strTypeArr[i].equalsIgnoreCase("CO"))
						{
							if(strPromoterChk.equals("false"))
							{
								strVal1	= strTypeArr[i];
								strPromoterChk	= "true";
								arrCol.add(Helper.changetoTitlecase(correctNull(rs.getString("com_compdtfname"))+" "+correctNull(rs.getString("com_compdtmname"))+" "+correctNull(rs.getString("com_compdtlname"))));//0
								
								if(rs1!=null){rs1.close();}
								rs1= DBUtils.executeLAPSQuery("sel_presanactionage^"+rs.getString("com_compdtappid"));
								
								if(rs1.next())
								{
									arrCol.add(correctNull(rs1.getString("age")));//1
									strVal	= correctNull(rs1.getString("perapp_constitution"));
									strVal2	= correctNull(rs1.getString("perapp_networthason"));
									strNW	= Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perapp_networth"))));
								}
								else
								{
									arrCol.add("0");
								}
								
								if(strVal.equals("01"))
								{
									if(rs1!=null){rs1.close();}
									rs1= DBUtils.executeLAPSQuery("pergetIncome1^"+rs.getString("com_compdtappid"));
									
									if(rs1.next())
									{
										arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perinc_takehome")))));//2
									}
									else
									{
										arrCol.add("0.00");
									}
								}
								else
								{
									if(rs1!=null){rs1.close();}
									rs1= DBUtils.executeLAPSQuery("pergetIncome1^"+rs.getString("com_compdtappid"));
									
									if(rs1.next())
									{
										arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("perinc_year1_income")))));//2
									}
									else
									{
										arrCol.add("0.00");
									}
								}
								arrCol.add(Helper.correctNull((String)rs.getString("com_comprelationship")));//3
								arrCol.add(strNW);//4
								arrCol.add(strVal2);//5
							}
						}
					}
				}
				if(arrCol.size()>0)
				{
					arrRow.add(arrCol);
				}
			}
			hshValues.put("arrGuaRow", arrRow);*/
			
			//Management Comments
			for(int i=0;i<strCommentMgmtSno.length;i++)
			{
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_management^MangementInfo^"+strCommentMgmtSno[i]+"^"+strAppNo);
				if(rs.next())
				{
					hshValues.put("MgmtComments"+correctNull(rs.getString("com_sno")), correctNull(Helper.CLOBToString(rs.getClob("com_comments"))));
				}
			}
			if(rs!=null){rs.close();}
			
			rs	= DBUtils.executeLAPSQuery("sel_CustDetails^"+strNewId);
			if(rs.next())
			{
				hshValues.put("NatureofActivity",rs.getString("kyc_kycactivity"));
			}
			if(rs!=null)
			{
				rs.close();
			}	

			
			strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground_sec^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("Sector",Helper.correctNull(rs.getString("com_sector")));
			}
			if(rs!=null)
			{
				rs.close();
			}	

			//Rating 
			arrRow = new ArrayList();
			String pagetype="cusratingnew";
			strQuery = SQLParser.getSqlQuery("cusratingnew_sel^"+strNewId);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs1.getString("RAT_ID")));//0
				arrCol.add(Helper.correctNull(rs1.getString("RAT_SNO")));//1
				arrCol.add(Helper.correctNull(rs1.getString("RAT_AGENCY")));//2
				arrCol.add(Helper.correctNull(rs1.getString("RATE_DATE")));//3
				arrCol.add(Helper.correctNull(rs1.getString("RAT_PARTICULARS")));//4
				arrCol.add(Helper.convertSetupToApplicationValues(strValuesIn, Double.parseDouble(Helper.correctDouble(rs1.getString("RAT_AMOUNT")))));//5
				arrCol.add(Helper.correctNull(rs1.getString("RAT_SYMBOL")));//6
				arrCol.add(Helper.CLOBToString(rs1.getClob("RAT_DESC")));//7
				arrCol.add(Helper.correctNull(rs1.getString("RAT_DUEDATE")));//8
				arrCol.add(Helper.correctNull(rs1.getString("RAT_RISK_WEIGHT")));//9
				arrRow.add(arrCol);
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			hshValues.put("arrRowRating",arrRow);
				
			strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+ strNewId+"^"+pagetype);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("cmt_ratingcomments", Helper.CLOBToString(rs.getClob("cmt_comments")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			String strPage="brief";
			strQuery = SQLParser.getSqlQuery("sel_comments^"+strPage+"^"+ strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("cmt_Briefhistory", Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strPage="brief1";
			strQuery = SQLParser.getSqlQuery("sel_comments^"+strPage+"^"+ strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("cmt_Briefhistory1", Helper.CLOBToString(rs.getClob("COM_COMMENTS")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			String strMarktValOfShares="";
			arrRow = new ArrayList();
			arrCol = new ArrayList();
			strQuery = SQLParser.getSqlQuery("com_shareholdpatternsel^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_SNO")));//0	
				String strSharesheld=Helper.correctNull(rs.getString("COM_SHP_SHARESHELDBY"));
				if(!strSharesheld.equalsIgnoreCase(""))
				{			
				 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"139"+"^"+strSharesheld);
				 if(rs1.next())
				 {
					 arrCol.add(Helper.changetoTitlecase(Helper.correctNull(rs1.getString("STAT_DATA_DESC1"))));//1
				 }
				 else
				 {
					 arrCol.add("");//1
				 }
				}
				else
				{
					arrCol.add("");//1
				}				
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_NOFSHARES")));//2		
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_FACVALUE")));//3		
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_AMOUNT")));//4	
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_PERCENT")));//5	
				arrCol.add(Helper.correctNull(rs.getString("COM_SHP_SHARESHELDBY")));//6
				arrCol.add(strSharesheld);//7
				arrRow.add(arrCol);
				strMarktValOfShares = Helper.correctNull(rs.getString("COM_SHP_MRKTVALOFSHARES"));
			}
			hshValues.put("Shareholding",arrRow);
			hshValues.put("MrktValOfShares",strMarktValOfShares);
			
			arrRow = new ArrayList();
			arrCol = new ArrayList();
			strQuery = SQLParser.getSqlQuery("com_natureofsharessel^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_SNO")));//0	
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_NATURESHAR")));//1
				String strnatureShar=Helper.correctNull(rs.getString("COM_NOS_NATURESHAR"));
				if(!strnatureShar.equalsIgnoreCase(""))
				{			
				 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"140"+"^"+strnatureShar);
				 if(rs1.next())
				 {
					 arrCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//2
				 }
				 else
				 {
					 arrCol.add("");//1
				 }
				}
				else
				{
					 arrCol.add("");//1
				}	
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_AUTHSHAR")));//3	
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_AUTHVALUE")));//4		
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_ISSUSHAR")));//5		
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_ISSUVALUE")));//6	
				arrCol.add(Helper.correctNull(rs.getString("COM_NOS_NATURESHAR")));//7	
				
				arrRow.add(arrCol);
				
			}
			hshValues.put("Natureofshare",arrRow);	
			pagetype="natureofshare";
			strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+ strAppNo+"^"+pagetype);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshValues.put("cmt_natureofshare", Helper.CLOBToString(rs.getClob("cmt_comments")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			arrRow = new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_rating_year_audited^"+ strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshValues.put("IntRat","Y");
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("rdr_year")));
				if(Helper.correctNull(rs.getString("rdr_financial")).equals("a"))
				{
					arrCol.add("Audited");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("e"))
				{
					arrCol.add("Estimated");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("u"))
				{
					arrCol.add("Unaudited");
				}
				else if(Helper.correctNull(rs.getString("rdr_financial")).equals("p"))
				{
					arrCol.add("Projection");
				}else{
					arrCol.add(" ");
				}
				arrCol.add(Helper.correctNull(rs.getString("rdr_rating")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrRowRatingRMD",arrRow);
			if(rs!=null)
			{
				rs.close();
			}
			// Internal RMD Rating
			if(rs!=null){rs.close();}
			String cre_weight="";
			rs	= DBUtils.executeLAPSQuery("sel_rate_userid^"+strAppNo);
			if(rs.next())
			{
				hshValues.put("cre_rating", correctNull(rs.getString("cre_rating")));
				cre_weight=correctNull(rs.getString("cre_weight"));
				if(cre_weight.equalsIgnoreCase("KB1"))
				{
					cre_weight+=" - Minimal Risk";
				}else if(cre_weight.equalsIgnoreCase("KB2"))
				{
					cre_weight+=" - Lowest Risk";
				}else if(cre_weight.equalsIgnoreCase("KB3"))
				{
					cre_weight+=" - Lower Risk";
				}else if(cre_weight.equalsIgnoreCase("KB4"))
				{
					cre_weight+=" - Low Risk";
				}else if(cre_weight.equalsIgnoreCase("KB5"))
				{
					cre_weight+=" - Moderate Risk";
				}else if(cre_weight.equalsIgnoreCase("KB6"))
				{
					cre_weight+=" - Average Risk";
				}else if(cre_weight.equalsIgnoreCase("KB7"))
				{
					cre_weight+=" - High Risk";
				}else if(cre_weight.equalsIgnoreCase("KB8"))
				{
					cre_weight+=" - Very high Risk";
				}else if(cre_weight.equalsIgnoreCase("KB9"))
				{
					cre_weight+=" - Sub standard (highest)";
				}else if(cre_weight.equalsIgnoreCase("KB10"))
				{
					cre_weight+=" - Doubt full/ loss (critical)";
				}
				hshValues.put("cre_weight", cre_weight);
				hshValues.put("cre_ratyear", correctNull(rs.getString("rating_year")));
				String cre_ratingType=correctNull(rs.getString("rating_yeartype"));
				
				if(cre_ratingType.equalsIgnoreCase("A"))
				{
					cre_ratingType="Audited";
				}else if(cre_ratingType.equalsIgnoreCase("U"))
				{
					cre_ratingType="Unaudited";
				}else if(cre_ratingType.equalsIgnoreCase("E"))
				{
					cre_ratingType="Estimated";
				}else if(cre_ratingType.equalsIgnoreCase("P"))
				{
					cre_ratingType="Projection";
				}
				else{
					cre_ratingType="";
				}
				hshValues.put("cre_rattype", cre_ratingType);
				
			}
			
			if(rs!=null){rs.close();}
			String SMACategory="";
			strQuery=SQLParser.getSqlQuery("cuscibildetails_sel^"+ strNewId+"^"+strNewId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("cibil_smadetails",correctNull(rs.getString("cibil_smadetails")));
				hshValues.put("cibil_CRILC",correctNull(rs.getString("cibil_CRILC")));
				SMACategory=correctNull(rs.getString("cibil_smacategory"));
				if(SMACategory.equalsIgnoreCase("Y")){
					SMACategory="Yes";
				}else{
					SMACategory="No";
				}
				hshValues.put("cibil_SMACategory",SMACategory);
			}
			
			if(rs!=null){rs.close();}
			String strCoAppArr[]	= null;
			strPromoterChk="";
			String strCoAppId="";
			if(rs2!=null){rs2.close();}
			strCoAppExID="";strCoAppExType="";strCoAppID="";
			rs2	= DBUtils.executeLAPSQuery("compromoterselectionpromoters^"+strAppNo);
			strid="0";
			arrRow=new ArrayList();
			arrCol = new ArrayList();
			String constitution="";
			ArrayList arrFacRow=new ArrayList();
			ArrayList arrFacCol=new ArrayList();
			while(rs2.next())
			{
				strVal			= "";
				
				strType			= correctNull(rs2.getString("com_compdttype"));
				strCoAppId      = correctNull(rs2.getString("com_compdtappid"));
				strCoAppID			= correctNull(rs2.getString("com_oldlapsid"));
				
				if((strCoAppID.equalsIgnoreCase(strCoAppExID)) && (strType.equalsIgnoreCase(strCoAppExType)))
					continue;
				
				if(!strType.equals(""))
				{
					strCoAppArr			= strType.split("@");
				}

				if(strCoAppArr!=null)
				{
					for(int i=0;i<strCoAppArr.length;i++)
					{
						arrCol = new ArrayList();
						if(strCoAppArr[i].equalsIgnoreCase("C"))
						{
							
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("sel_appnamebyId^"+strCoAppId);
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull(rs1.getString("coappname")));//0
								arrCol.add(correctNull(rs1.getString("perapp_dob")));//1
								arrCol.add(correctNull(rs1.getString("perapp_banksince")));//2
								arrCol.add(correctNull(rs1.getString("perapp_constitution")));//3
								constitution=correctNull(rs1.getString("perapp_constitution"));
							}else{
								arrCol.add(" ");//0
								arrCol.add(" ");//1
								arrCol.add(" ");//2
								arrCol.add(" ");//3
							}
							
							if(rs1!=null){rs1.close();}
							rs1	= DBUtils.executeLAPSQuery("selborrowerdet_company^"+strCoAppId);
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull(rs1.getString("cominfo_commencement_date")));//4
								arrCol.add(correctNull(rs1.getString("cominfo_incorporation_date")));//5
							}else{
								arrCol.add(" ");//4
								arrCol.add(" ");//5
							}
							StringBuffer strAddress1=new StringBuffer();
							StringBuffer strAddress2=new StringBuffer();
							StringBuffer strAddress3=new StringBuffer();
							StringBuffer FacAdAddress=new StringBuffer();
							
							strAd1="";strAd2="";strAd3="";strCity="";
							strDis="";strState="";strZip="";
							String strAdAd1="",strAdAd2="",strAdAd3="",strAdCity="";
							String strAdDis="",strAdState="",strAdZip="";
							String strFacAd1="",strFacAd2="",strFacCity="";
							String strFacDis="",strFacState="",strFacZip="";
							String strPerAd1="",strPerAd2="",strPerAd3="",strPerCity="";
							String strPerDis="",strPerState="",strPerZip="";
							if(rs1!=null){rs1.close();}
							strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strCoAppId);
							rs1=DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{ 
								strAd1=correctNull(rs1.getString("CON_COMADDR1"));
								strAd2=correctNull(rs1.getString("CON_COMADDR2"));
								strAd3=correctNull(rs1.getString("CON_COMVILLAGE"));
								strCity=correctNull(rs1.getString("CON_COMCITY"));
								strDis=correctNull(rs1.getString("CON_COMDIST"));
								strState=correctNull(rs1.getString("CON_COMSTATE"));		
								strZip=correctNull(rs1.getString("CON_COMZIP"));
								if(!strAd1.equalsIgnoreCase(""))
							 	{ 
									strAddress1.append(strAd1);
							 	}
							 	if(!strAd2.equalsIgnoreCase(""))
							 	{
							 		strAddress1.append(",");
							 		strAddress1.append(strAd2);
							 	}
							 	if(!strAd3.equalsIgnoreCase(""))
							 	{
							 		strAddress1.append(",");
							 		strAddress1.append(strAd3);
							 	}
							 	if(!strCity.equalsIgnoreCase(""))
							 	{
									if(rs!=null)
									{rs.close();}
									rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCity);
									if(rs.next())
									{
										strAddress1.append(",");
								 		strAddress1.append(Helper.correctNull((String)rs.getString("city_name")));
									}
							 	}
							 	if(!strDis.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDis);
							 		if(rs.next())
							 		{
							 			strAddress1.append(",");
							 			strAddress1.append(correctNull(rs.getString("district_desc")));
							 		}
							 	}
							 	if(!strState.equalsIgnoreCase(""))
							 	{
									if(rs!=null)
									{rs.close();}
									rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strState);
									if(rs.next())
									{
										strAddress1.append(",");
								 		strAddress1.append(Helper.correctNull((String)rs.getString("state_name")));
									}
									
							 		if(!strZip.equalsIgnoreCase(""))
							 		{
							 			strAddress1.append("-");
							 			strAddress1.append(strZip);
							 		}
							 	}
							 	
							 	strAdAd1=correctNull(rs1.getString("CON_ADMADDR1"));
							 	strAdAd2=correctNull(rs1.getString("CON_ADMADDR2"));//
							 	strAdAd3=correctNull(rs1.getString("CON_ADMVILLAGE"));
							 	strAdDis=correctNull(rs1.getString("CON_ADMDIST"));
							 	strAdCity=correctNull(rs1.getString("CON_ADMCITY"));
							 	strAdState=correctNull(rs1.getString("CON_ADMSTATE"));
							 	strAdZip=correctNull(rs1.getString("CON_ADMZIP"));
							 	
							 	if(!strAdAd1.equalsIgnoreCase(""))
							 	{ 
							 		strAddress2.append(strAdAd1);
							 	}
							 	if(!strAdAd2.equalsIgnoreCase(""))
							 	{
							 		strAddress2.append(",");
							 		strAddress2.append(strAdAd2);
							 	}
							 	if(!strAdAd3.equalsIgnoreCase(""))
							 	{
							 		strAddress2.append(",");
							 		strAddress2.append(strAdAd3);
							 	}
							 	if(!strAdCity.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strAdCity);
							 		if(rs.next())
							 		{
							 			strAddress2.append(",");
							 			strAddress2.append(Helper.correctNull((String)rs.getString("city_name")));
							 		}
							 	}
							 	if(!strAdDis.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strAdDis);
							 		if(rs.next())
							 		{
							 			strAddress2.append(",");
							 			strAddress2.append(correctNull(rs.getString("district_desc")));
							 		}
							 	}
							 	if(!strAdState.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strAdState);
							 		if(rs.next())
							 		{
							 			strAddress2.append(",");
							 			strAddress2.append(Helper.correctNull((String)rs.getString("state_name")));
							 		}
							 		if(!strAdZip.equalsIgnoreCase(""))
							 		{
							 			strAddress2.append("-");
							 			strAddress2.append(strAdZip);
							 		}
							 	}
							 	
							 	strPerAd1=correctNull(rs1.getString("CON_PERMADDR1"));
							 	strPerAd2=correctNull(rs1.getString("CON_PERMADDR2"));
							 	strPerAd3=correctNull(rs1.getString("CON_PERMVILLAGE"));
							 	strPerDis=correctNull(rs1.getString("CON_PERMDIST"));	
							 	strPerCity=correctNull(rs1.getString("CON_PERMCITY"));
							 	strPerState=correctNull(rs1.getString("CON_PERMSTATE"));
							 	strPerZip=correctNull(rs1.getString("CON_PERMZIP"));
							 	
							 	if(!strPerAd1.equalsIgnoreCase(""))
							 	{ 
							 		strAddress3.append(strPerAd1);
							 	}
							 	if(!strPerAd2.equalsIgnoreCase(""))
							 	{
							 		strAddress3.append(",");
							 		strAddress3.append(strPerAd2);
							 	}
							 	if(!strPerAd3.equalsIgnoreCase(""))
							 	{
							 		strAddress3.append(",");
							 		strAddress3.append(strPerAd3);
							 	}
							 	if(!strPerCity.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strPerCity);
							 		if(rs.next())
							 		{
							 			strAddress3.append(",");
							 			strAddress3.append(Helper.correctNull((String)rs.getString("city_name")));
							 		}
							 	}
							 	if(!strPerDis.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strPerDis);
							 		if(rs.next())
							 		{
							 			strAddress3.append(",");
							 			strAddress3.append(correctNull(rs.getString("district_desc")));
							 		}
							 	}
							 	if(!strPerState.equalsIgnoreCase(""))
							 	{
							 		if(rs!=null)
							 		{rs.close();}
							 		rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPerState);
							 		if(rs.next())
							 		{
							 			strAddress3.append(",");
							 			strAddress3.append(Helper.correctNull((String)rs.getString("state_name")));
							 		}
							 		if(!strPerZip.equalsIgnoreCase(""))
							 		{
							 			strAddress3.append("-");
							 			strAddress3.append(strPerZip);
							 		}
							 	}
							 	
							}
							arrCol.add(strAddress1.toString());//6
							arrCol.add(strAddress2.toString());//7
							arrCol.add(strAddress3.toString());//8
							
								intSize=arrBranchtype.length;
								for(int l =0;l<intSize;l++)
					    		{
									FacAdAddress=new StringBuffer();
									strFacAd1="";strFacAd2="";strFacCity="";
									strFacState="";strFacZip="";
									arrFacRow=new ArrayList();
									if(rs!=null){rs.close();}
									rs	= DBUtils.executeLAPSQuery("selallfactorydetailsbytype^"+strCoAppId+"^"+arrBranchtype[l]);
									while(rs.next())
									{
										arrFacCol=new ArrayList();
										String strCitycode = Helper.correctNull((String)rs.getString("comapp_city"));
										String strCityDesc="";
										if(!strCitycode.equalsIgnoreCase(""))
										{				
										if(rs1!=null)
										{rs1.close();}
										rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCitycode);
										if(rs1.next())
										{
											strCityDesc = Helper.correctNull((String)rs1.getString("city_name"));					
										}
										}
										
										String strStatecode = Helper.correctNull((String)rs.getString("comapp_state"));	
										String strStateDesc="";
										if(!strStatecode.equalsIgnoreCase(""))
										{				
										if(rs1!=null)
										{rs1.close();}
										rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
										if(rs1.next())
										{
											strStateDesc = Helper.correctNull((String)rs1.getString("state_name"));					
										}
										}
										strFacAd1=correctNull((String)rs.getString("comapp_name"));
										strFacAd2=correctNull((String)rs.getString("comapp_add"));
										strFacCity=strCityDesc;
										strFacState=strStateDesc;
										strFacZip=correctNull((String)rs.getString("comapp_pincode"));
										
										if(!strFacAd1.equalsIgnoreCase(""))
									 	{ 
											FacAdAddress.append(strFacAd1);
									 	}
									 	if(!strFacAd2.equalsIgnoreCase(""))
									 	{
									 		FacAdAddress.append(",");
									 		FacAdAddress.append(strFacAd2);
									 	}
									 	if(!strFacCity.equalsIgnoreCase(""))
									 	{
									 		FacAdAddress.append(",");
									 		FacAdAddress.append(strFacCity);
									 	}
									 	if(!strFacState.equalsIgnoreCase(""))
									 	{
									 		FacAdAddress.append(",");
									 		FacAdAddress.append(strFacState);
									 		if(!strFacZip.equalsIgnoreCase(""))
									 		{
									 			FacAdAddress.append("-");
									 			FacAdAddress.append(strFacZip);
									 		}
									 	}
									 	arrFacCol.add(FacAdAddress.toString());
									 	arrFacRow.add(arrFacCol);
									}
									arrCol.add(arrFacRow);//9 & 10 & 11
					    		}
							String strConsFlag="N";
							if(rs!=null){rs.close();}
							rs	= DBUtils.executeLAPSQuery("selconstitutiondesc^"+constitution);
							if(rs.next())
							{
									arrCol.add(correctNull(rs.getString("cbs_static_data_desc")));//12
									strConsFlag="Y";
							}
							//ArrayList arrConstitution = RefTableManager.getCodeAndDescription("2","CBS");
							else{
								arrCol.add(" ");//12
							}
						}
						if(arrCol.size()>0)
						{
							arrRow.add(arrCol);
						}
					}
				}
				strCoAppExID			= correctNull(rs2.getString("com_oldlapsid"));
				strCoAppExType			= correctNull(rs2.getString("com_compdttype"));
				
			}
			hshValues.put("arrCoApplicant", arrRow);
			
			if(rs != null){	rs.close();}
			pagetype="shareholdpattern";
			strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+ strAppNo+"^"+pagetype);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("cmt_shareholdingpattern", Helper.CLOBToString(rs.getClob("cmt_comments")));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_comments^ratingcomments^" + strAppNo);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshValues.put("strInternalrating_comment", correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
			}
			
			
			
			if (rs != null)
				rs.close();
			
			java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			
			strQuery = SQLParser.getSqlQuery("sel_per_bir^" + strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			String bir_flag="";
			if (rs.next())
			{
				hshValues.put("bir_flag", Helper.correctNull(rs.getString("bir_flag")));
				bir_flag=Helper.correctNull(rs.getString("bir_flag"));
				
				if(Helper.correctNull((String)rs.getString("bir_flag")).equalsIgnoreCase("Y"))
				{	
					hshValues.put("bir_flag1", "Yes");
					hshValues.put("bir_submitteddate", Helper.correctNull(rs.getString("bir_submitteddate")));	
					hshValues.put("bir_receiptdate", Helper.correctNull(rs.getString("bir_receiptdate")));	
					hshValues.put("bir_charges", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("bir_charges")))));
					hshValues.put("bir_comments", Helper.correctNull(rs.getString("bir_comments")));
					hshValues.put("bir_processdate", Helper.correctNull(rs.getString("bir_processdate")));

				}
				else
				{
					hshValues.put("bir_flag1", "No");
				}
			
			}	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAnnexureII login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null){	rs.close();}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	
	public HashMap getCgtmseFinancialData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		ResultSet rsFormulaFor=null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		int str = 0, tabcnt = 0, l = 0;
		String sumaudit = "";
		String sumunaudit = "";
		String sumestimated = "";
		String sumprojection = "";
		String sel_divID = "";
		String pagetab = "";
		String base_year = "";
		String strAction = "";
		String fintype = null;
		String chk1 = "", chk2 = "", chk3 = "", chk4 = "", chk5 = "";
		ArrayList arr_labeldetails = new ArrayList();
		String strappno = "";
		String appid = "";
		String finance_id = "";
		String strValuesin = "";
		String strAppId="",strAppNo="", strVal="";
		String strValuesIn="",strFinvaluesIn="";
		int strFinid=0;
		HashMap hshFinYearVal = new HashMap();
		try {
			strappno = Helper.correctNull((String) hshRequestValues
					.get("appno"));
			String strcomId = Helper.correctNull((String) hshRequestValues
					.get("appid"));
			String strFacNo=Helper.correctNull((String) hshRequestValues
					.get("strFacno"));
					if(rs!=null){rs.close();}
					rs	= DBUtils.executeLAPSQuery("selorgno^"+strappno);
					if(rs.next())
					{
						strValuesIn	= correctNull(rs.getString("app_valuesin"));
					}
					
					if(strValuesIn.equals("C")){strValuesIn			= "Crore";}
					else if(strValuesIn.equals("L")){strValuesIn	= "Lacs";}
					else if(strValuesIn.equals("R")){strValuesIn	= "Rs";}
					hshRequestValues.put("strValuesIn", strValuesIn);
					
					rs	= DBUtils.executeLAPSQuery("sel_financeid^"+strappno);
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
					else{
						strFinvaluesIn	= "R";
					}
					if(rs!=null){rs.close();}
					
					//Financail Values In
					if(strFinvaluesIn.equals("C")){strFinvaluesIn = "Crore";}
					else if(strFinvaluesIn.equals("L")){strFinvaluesIn	= "Lacs";}
					else if(strFinvaluesIn.equals("R")){strFinvaluesIn	= "Rs";}
					hshRequestValues.put("strFinvaluesIn", strFinvaluesIn);
					
				
					hshRequestValues.put("appno",strappno);
					hshRequestValues.put("printtype","Y");
					hshRequestValues.put("pageval","");
					
					String hidFreeze = correctNull((String) hshRequestValues
							.get("strFreeze"));
					String hidUpload = correctNull((String) hshRequestValues
							.get("hidUpload"));
					// to get the process note base on print out option
					String printtype = correctNull((String) hshRequestValues
							.get("printtype"));

					strAction = Helper.correctNull((String) hshRequestValues
							.get("hidAction"));
					// --------This is Existing Finia-----

					if (strValue.equals("")) {
						strValue = correctNull((String) hshRequestValues
								.get("hidfinanceid"));
						finance_id = correctNull((String) hshRequestValues
								.get("hidfinanceid"));
					}
					if (strValue.equals("")) {
						strValue = correctNull((String) hshRequestValues
								.get("hidfinid"));
						finance_id = correctNull((String) hshRequestValues
								.get("hidfinid"));
					}

					appid = correctNull((String) hshRequestValues.get("hidappid"));
					if (appid.equals("")) {
						appid = correctNull((String) hshRequestValues.get("hid_appid"));
					}
					if (appid.equals("")) {
						appid = correctNull((String) hshRequestValues.get("appidnew"));
					}
					sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
					if (sel_divID.equalsIgnoreCase("")) {
						sel_divID = "0";
					}

					strappno = Helper.correctNull((String) hshRequestValues
							.get("appno"));
					if (!strappno.equals("")) {
						if (finance_id.equals("")) {
							String query1 = SQLParser
									.getSqlQuery("comdemographics_sel^" + strappno);
							rs = DBUtils.executeQuery(query1);

							if (rs.next()) {
								finance_id = (Helper.correctInt((String) rs
										.getString("demo_finstandard")));
								strValue = (Helper.correctInt((String) rs
										.getString("demo_finstandard")));
							}
						}
					}

					String page = correctNull((String) hshRequestValues.get("pageval"));
					pagetab = Helper.correctNull(page);

					rs = null;
					chk1 = correctNull((String) hshRequestValues.get("printchk1"));
					chk2 = correctNull((String) hshRequestValues.get("printchk2"));
					chk3 = correctNull((String) hshRequestValues.get("printchk3"));
					chk4 = correctNull((String) hshRequestValues.get("printchk4"));
					chk5 = correctNull((String) hshRequestValues.get("printchk5"));

					hshValues = new HashMap();
					ArrayList vecVal = new ArrayList();
					ArrayList vecRec = new ArrayList();
					ArrayList vecid = new ArrayList();
					ArrayList arrVal = new ArrayList();
					ArrayList arrcol = new ArrayList();
					hshValues.put("sel_divID", sel_divID);

					// Retreving of values for project input

					String query1 = SQLParser
							.getSqlQuery("financial_new_projectinputfields_select^"
									+ strValue);
					rs = DBUtils.executeQuery(query1);
					ArrayList vec = new ArrayList();
					if (rs.next()) {
						vec.add(Helper.correctNull(Helper
								.correctNull((String) rs.getString(10))));
						vec.add(Helper.correctNull(Helper
								.correctNull((String) rs.getString(2))));
						if (Helper.correctNull(rs.getString(3)).equalsIgnoreCase("")) {
							vec.add("0.00");
						} else {
							vec
									.add(Helper.correctNull((String) rs
											.getString(3)));
						}
						if (Helper.correctNull(rs.getString(4)).equalsIgnoreCase("")) {
							vec.add("0.00");
						} else {
							vec
									.add(Helper.correctNull((String) rs
											.getString(4)));
						}
						vec.add(Helper.correctNull((String) rs.getString(5)));
						vec.add(Helper.correctNull((String) rs.getString(6)));
						vec.add(Helper.correctNull((String) rs.getString(7)));
						vec.add(Helper.correctNull((String) rs.getString(8)));
						vec.add(Helper.correctNull((String) rs.getString(9)));
						hshValues.put("projectinputvalue", vec);
					} else {
						vec.add("");
						vec.add("");
						vec.add("0.00");
						vec.add("0.00");
						vec.add("");
						vec.add("");
						vec.add("");
						vec.add("");
						vec.add("0.00");
						hshValues.put("projectinputvalue", vec);
					}
					
					// -------------- to find the time of review-----------------

					if (rs != null) {
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("finselect1^" + strValue + "^"
							+ sel_divID);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						str = rs.getInt("cnt");
					}

					// --------------- to find the cma format of the particular
					// applications-------

					String tempbool = "2", tabool = "";
					String cma = "0";
					log.info((String) hshRequestValues.get("cattype"));
					/*
					 * strQuery=SQLParser.getSqlQuery("comfinance_appid^"+strValue);
					 * if(rs != null) { rs.close(); } rs =
					 * DBUtils.executeQuery(strQuery);
					 * 
					 * while(rs.next()) { cma=correctNull(rs.getString("fin_cmano"));
					 * fintype = Helper.correctNull((String)rs.getString("fin_cmano"));
					 * }
					 */

					cma = Helper
							.correctNull((String) hshRequestValues.get("hidcmasno"));
					if (cma.equalsIgnoreCase("")) {
						cma = Helper.correctNull((String) hshRequestValues
								.get("hidCMANo"));
					}
					if (cma.equalsIgnoreCase("")) {
						if (rs != null) {
							rs.close();
						}

						if (!finance_id.equals("")) {
							strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
									+ finance_id);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next()) {

								cma = Helper.correctNull((String) rs
										.getString("fin_cmano"));
							}
						}
					}

					/*
					 * if(cma.equalsIgnoreCase("5")) { if(pagetab.equalsIgnoreCase(""))
					 * { pagetab="INFRA STRUCTURE MODEL"; } }
					 */
					int strsize = 0;

					strQuery = SQLParser.getSqlQuery("corp_fin_year_count^" + strValue
							+ "^" + sel_divID);

					if (rs10 != null) {
						rs10.close();
					}
					rs10 = DBUtils.executeQuery(strQuery);
					if (rs10.next()) {

						strsize = rs10.getInt("yearcount");
					}

					strQuery = null;

					String stryear[] = new String[strsize];

					int i = 0;
					if (!printtype.equalsIgnoreCase("Y")) {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_distinctyear^"
										+ strValue + "^" + sel_divID);
					} else {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_distinctyear_print^"
										+ strValue + "^" + sel_divID + "^" + strValue);
					}
					if (rs10 != null)
						rs10.close();
					rs10 = DBUtils.executeQuery(strQuery);
					while (rs10.next()) {

						stryear[i] = rs10.getString("fin_year");
						i++;
					}

					i = 0;
					String strDate = "";
					int strcurcount = 0;
					// to check for current year duplication
					if (!printtype.equalsIgnoreCase("Y")) {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_fintype_curryear^"
										+ strValue + "^" + sel_divID);
					} else {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_fintype_curryear_print^"
										+ strValue + "^" + sel_divID + "^" + strValue);
					}
					if (rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						strcurcount = strcurcount + 1;
					}
					String strdesctype[] = new String[strcurcount];
					int insno[] = new int[strcurcount];
					rs.beforeFirst();
					while (rs.next()) {

						strdesctype[i] = rs.getString("com_fintype");
						insno[i] = rs.getInt("com_sno");
						strDate = rs.getString("caf_year");
						i++;

					}
					// for take Financial Type Base on Priority
					String strpro = "false", strest = "false", straud = "false", strunaud = "false";
					int prosno = 0, estsno = 0, unaudsno = 0, audsno = 0, intyearsno = 0;
					if (i > 0) {
						for (int j = 0; j < strdesctype.length; j++) {

							if (strdesctype[j].equals("PROJECTION"))

							{
								strpro = "true";
								prosno = insno[j];

							}
							if (strdesctype[j].equals("ESTIMATED"))

							{
								strest = "true";
								estsno = insno[j];

							}
							if (strdesctype[j].equals("UNAUDITED"))

							{
								strunaud = "true";
								unaudsno = insno[j];

							}
							if (strdesctype[j].equals("AUDITED")) {
								straud = "true";
								audsno = insno[j];

							}

						}

						if (straud.equals("true")) {
							intyearsno = audsno;

						} else if (strunaud.equals("true")) {
							intyearsno = unaudsno;

						} else if (strest.equals("true")) {
							intyearsno = estsno;

						} else {
							intyearsno = prosno;

						}

					}
						vecVal = new ArrayList();
						String queryloamamt="";
						String apploamamt="";
						String samplevalue="";
						String loanmodule="",loan_catgry="";
						int sampleval=0;
						if(!strappno.equalsIgnoreCase("")){
							
							strQuery = SQLParser.getSqlQuery("sel_assessmentloandetails^"+ strappno);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next()) {
							apploamamt=Helper.correctNull((String) rs.getString("reqamt"));
							}
						}
						sampleval=Integer.parseInt(apploamamt);
						//sampleval=10000001;
						//sampleval=10000001;
						 //ArrayList al=new ArrayList();
						 
						
						if(sampleval<=1000000){
							samplevalue="'520','580','583'";	
							loanmodule="A. Loans   1 Lakh- 10 Lakh";
						}
						else if(sampleval>=1000000 && sampleval<=5000000){
							samplevalue="'520','580','583','596','1246','629'";
							loanmodule="B. Loans   Above 10 Lakh- 50 Lakh";
						}
						else if(sampleval>=5000000 && sampleval<=10000000){
							samplevalue="'520','580','583','1246','506','596','629'";
							loanmodule="C. Loans  Above 50 Lakh and less than 100 Lakh";
						}
						else if(sampleval>=10000000){
							samplevalue="'520','578','527','579','502','470','471','440','443','444'";
							loanmodule="D. Loan  100 Lakh and above";
							loan_catgry="Above1c";
						}
						
					// --------------- to select label depending upon existence of
					// application
					String tempsno = "";
					if (str <= 0) {
						strQuery = SQLParser.getSqlQuery("finselect2anew_corp_annexure^" + cma );
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) {
							vecRec = new ArrayList();
							arr_labeldetails = new ArrayList();
							vecRec.add(correctNull(rs.getString("fin_rowid")));
							vecRec.add(correctNull(rs.getString("fin_rowdesc")));
							vecRec.add(correctNull(rs.getString("fin_rowtype")));
							tempsno = correctNull(rs.getString("fin_sno"));
							if (tempsno.trim().equals("")) {
								tempsno = " ";
							}

							vecRec.add(tempsno);
							vecRec.add(Helper.correctNull(rs.getString("fin_page")));
							vecVal.add(vecRec);
							arrVal.add(vecRec);

						}
						arr_labeldetails = new ArrayList();
						strQuery = SQLParser.getSqlQuery("finselect2_label_cgtmse^" + cma);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) {

							arr_labeldetails
									.add(correctNull(rs.getString("fin_rowid")));

						}

						hshValues.put("labeldetails", vecVal);
						hshValues.put("arr_labeldetails", arr_labeldetails);
					}

					else if (str > 0) {
						vecVal = new ArrayList();
						String temp = "";
						arr_labeldetails = new ArrayList();
						strQuery = SQLParser.getSqlQuery("finselect3z_cgtmse^" + cma + "^" + samplevalue);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) {
							vecRec = new ArrayList();
							vecRec.add(correctNull(rs.getString("myrowid")));

							temp = Helper.correctNull(rs.getString("desc1"));
							if (temp.equals("")) {
								vecRec.add(correctNull(rs.getString("desc2")));
							} else {
								vecRec.add(correctNull(rs.getString("desc1")));
							}

							vecRec.add(correctNull(rs.getString("fin_rowtype")));

							tempsno = correctNull(rs.getString("fin_sno"));
							if (tempsno.trim().equals("")) {
								tempsno = " ";
							}

							vecRec.add(tempsno);
							vecRec.add(Helper.correctNull(rs.getString("fin_page")));
							vecVal.add(vecRec);
							arrVal.add(vecRec);
						}
						arr_labeldetails = new ArrayList();
						strQuery = SQLParser.getSqlQuery("finselect3z_label_cgtmse^" + cma+ "^" + samplevalue);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) {

							arr_labeldetails.add(correctNull(rs.getString("myrowid")));

						}

						hshValues.put("labeldetails", vecVal);
						hshValues.put("arr_labeldetails", arr_labeldetails);
					}

					hshValues.put("count", Integer.toString(str));

					String yearselect = "", seloption = "", givenyear = "";
					i = 0;
					int k = 0;
					int from = 0, p = 0, tt = 0;

					ArrayList vecrec = new ArrayList();
					ArrayList vecrec_strt = new ArrayList();
					givenyear = correctNull((String) hshRequestValues.get("from"));
					if (givenyear.equals("")) {
						givenyear = "0";
					}
					from = Integer.parseInt(givenyear);
					if (from == 0) {
						from = 1;
					}

					String valarray[] = new String[6];
					valarray[0] = "0";
					valarray[1] = "0";
					valarray[2] = "0";
					valarray[3] = "0";
					valarray[4] = "0";

					strQuery = SQLParser.getSqlQuery("finYearSel^" + strValue + "^"
							+ sel_divID);
					rs = DBUtils.executeQuery(strQuery);
					ArrayList arryvall = new ArrayList();

					int kk = 0;
					while (rs.next()) {
						arryvall.add(Helper.correctNull(rs.getString("fin_year")));

					}

					// this code has been commented by balaji & shanmugam for get all
					// the year for all the sub tags
					// and new line has been added bellow
					String sno = "0";
					if (!printtype.equalsIgnoreCase("Y")) {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_distinctyear^"
										+ strValue + "^" + sel_divID);
					} else {
						strQuery = SQLParser
								.getSqlQuery("corp_app_financials_select_distinctyear_print^"
										+ strValue + "^" + sel_divID + "^" + strValue);
					}

					if (rs != null) {
						rs.close();
					}
					int o = 1;
					int t = 1;
					int r = 1;
					String pgType="",labId="";
					rs = DBUtils.executeQuery(strQuery);
					String audit_flag = "false";
					while (rs.next()) {
						valarray[0] = "0";
						valarray[1] = "0";
						valarray[2] = "0";
						valarray[3] = "0";
						valarray[4] = "0";
						vecVal = new ArrayList();
						String desc = "";
						yearselect = (String) Helper.correctNull(rs
								.getString("fin_year"));
						String yearselect_strt = (String) Helper.correctNull(rs
								.getString("COM_FINYEAR_START"));
						sno = (String) Helper.correctNull(rs.getString("com_sno"));
						if (!yearselect.equals("")) {
							if (rs3 != null) {
								rs3.close();
							}

							String strQuery10 = SQLParser.getSqlQuery("assessselect9^"
									+ strValue + "^" + sel_divID + "^" + yearselect
									+ "^" + sno);
							if (rs10 != null) {
								rs10.close();
							}

							rs10 = DBUtils.executeQuery(strQuery10);
							if (rs10.next()) {
								sumaudit = Helper.correctDouble(rs10
										.getString("sumaudit"));
								sumunaudit = Helper.correctDouble(rs10
										.getString("sumunaudit"));
								sumestimated = Helper.correctDouble(rs10
										.getString("sumestimated"));
								sumprojection = Helper.correctDouble(rs10
										.getString("sumprojection"));
							}
							if (valarray[0].equals("0") && !sumaudit.equals("0")) {
								valarray[0] = "fin_audit";
								audit_flag = "true";
							}
							if (valarray[1].equals("0") && !sumunaudit.equals("0")) {
								valarray[1] = "fin_unaudit";
							}
							if (valarray[2].equals("0") && !sumestimated.equals("0")) {
								valarray[2] = "fin_estimated";
							}
							if (valarray[3].equals("0") && !sumprojection.equals("0")) {
								valarray[3] = "fin_projection";
							}
							if (valarray[4].equals("0") && !sumprojection.equals("0")) {
								valarray[4] = "fin_projection";
							}
						}

							if (rs10 != null) {
								rs10.close();
							}
							for (int h = 0; h < 4; h++) {
								vecVal = new ArrayList();
								vecid = new ArrayList();

								if (valarray[h].equals("")) {
									valarray[h] = "0.00";
								}
								if (!valarray[h].equals("0")) {
									i = i + 1;
									seloption = valarray[h];
									boolean flag=false;
									if (printtype.equalsIgnoreCase("Y")) 
									{
										flag=true;
									}
									else
									{
										if(k>=5)
											flag=false;
										else
											flag=true;
									}
									if ((i >= from) && flag) {
										p = i;
										k = k + 1;
										hshValues.put("sno" + (o++), sno);
//										strQuery = SQLParser.getSqlQuery("finselect5^"
//												+ seloption + "^" + cma + "^" + page
//												+ "^" + yearselect + "^" + strValue
//												+ "^" + sel_divID + "^" + sno);
										for(int a=0;a<arrVal.size();a++)
										{
											arrcol = (ArrayList)arrVal.get(a);
											pgType = Helper.correctNull((String)arrcol.get(4));
											labId  = Helper.correctNull((String)arrcol.get(0));
											if(pgType.equalsIgnoreCase("RA")){
												hshFinYearVal = new HashMap();
												hshFinYearVal.put("appno", strappno);
												hshFinYearVal.put("strFinID", strValue);
												hshFinYearVal.put("comappid", correctNull((String) hshRequestValues
														.get("sel_divID")));
												hshFinYearVal = getFinValues(hshFinYearVal);
												strQuery = SQLParser
												.getSqlQuery("finratio1new_corp^" + "RA"
														+ "^" + cma + "^" + labId);

										rs1 = DBUtils.executeQuery(strQuery);
										while (rs1.next()) {
											if (seloption.equals("fin_audit")) {
												desc = "a";
											} else if (seloption.equals("fin_unaudit")) {
												desc = "u";
											} else if (seloption
													.equals("fin_estimated")) {
												desc = "e";
											} else if (seloption
													.equals("fin_projection")) {
												desc = "p";
											}

											double dblBankBorr = 0.00;
											if (rs4 != null)
												rs4.close();

											if (cma.equalsIgnoreCase("5"))
												strQuery = SQLParser
														.getSqlQuery("selcomfinvalues^"
																+ strValue + "^461"
																+ "^" + yearselect);
											else
												strQuery = SQLParser
														.getSqlQuery("selcomfinvalues^"
																+ strValue + "^1005^"
																+ yearselect);

											rs4 = DBUtils.executeQuery(strQuery);
											if (rs4.next()) {
												dblBankBorr = Double
														.parseDouble((Helper
																.correctDouble((String) rs4
																		.getString("finvalue"))));
											}

											int formuladesc = 0;
											formuladesc = (rs1.getInt("fin_formula"));

											if (formuladesc > 0) {

												strQuery = SQLParser
														.getSqlQuery("selfinformula^"
																+ formuladesc);

												rsFormulaFor = DBUtils
														.executeQuery(strQuery);
												String strFormulaFor = "";
												if (rsFormulaFor.next()) {
													strFormulaFor = correctNull((String) rsFormulaFor
															.getString("formula_for"));
												}

												String strPreYear = "", strPreYearDesc = "";
												if (rsFormulaFor != null) {
													rsFormulaFor.close();
												}
										
													HashMap hshformula = new HashMap();
													hshformula.put("appno", strappno);
													hshformula
															.put("strFinID", strValue);
													hshformula.put("formulaid", Integer
															.toString(formuladesc));
													hshformula.put("curryear",
															yearselect);
													hshformula.put("prevyear",
															strPreYear);
													hshformula.put("currfinancialtype",
															desc);
													hshformula.put("prevfinancialtype",
															strPreYearDesc);
													hshformula.put("internalcalc", "N");
													hshformula.put("sno", sno);
													hshformula.put("hshdata",
															new HashMap());
													hshformula.put("hshFinYearVal",
															hshFinYearVal);
													HashMap hshRes = (HashMap) EJBInvoker
															.executeStateLess(
																	"comformula",
																	hshformula,
																	"GetFinValue");
													vecVal
															.add(correctNull((String) hshRes
																	.get("strTotalValue")));

												}
												vecid.add(correctNull(rs1
														.getString("fin_rowid")));
											}
											hshValues.put("year" + k, vecVal);
											hshValues.put("vecid" + k, vecid);
											}
											else{
												strQuery = SQLParser.getSqlQuery("finselect5_corp^"
												+ seloption + "^" + yearselect + "^" + strValue
												+ "^" + sel_divID + "^" + sno
												+ "^" + cma + "^" + labId );

										if (rs1 != null) {
											rs1.close();
										}
										rs1 = DBUtils.executeQuery(strQuery);
										if (rs1.next()) {

											vecVal.add(correctNull(rs1
													.getString("txtvalue")));
											vecid.add(correctNull(rs1
													.getString("fin_rowid")));
											// }

											hshValues.put("year" + k, vecVal);
											hshValues.put("vecid" + k, vecid);
										}
										}

										if (rs1 != null) {
											rs1.close();
										}
										
										strQuery = SQLParser
												.getSqlQuery("com_selfinancial_printyear^"
														+ sno + "^" + strValue);
										if (rs1 != null)
											rs1.close();
										rs1 = DBUtils.executeQuery(strQuery);
										if (rs1.next()) {

											hshValues
													.put(
															"checkcol" + (t++),
															Helper
																	.correctNull((String) rs1
																			.getString("FINPRINTYEAR_SELSNO")));

										} else {
											t++;
										}
										
										strQuery = SQLParser
										.getSqlQuery("com_selfinancial_rateyear^"
												+ sno + "^" + strValue);
										if (rs1 != null)
											rs1.close();
										rs1 = DBUtils.executeQuery(strQuery);
										if (rs1.next()) {
											
											hshValues
											.put(
													"ratecol" + (r++),
													Helper
													.correctNull((String) rs1
															.getString("FINRATEYEAR_SELSNO")));
											
										} else {
											r++;
										}
									}

								}
									vecrec.add(yearselect);
									vecrec.add(seloption);
									vecrec_strt.add(yearselect_strt);
							}
						}
					}
					hshValues.put("from", Integer.toString(from));
					hshValues.put("loanmodule", loanmodule);
					hshValues.put("totalyear", i + "");
					hshValues.put("upto", p + "");
					hshValues.put("yearvalue", vecrec);
					hshValues.put("yearvalue_strt", vecrec_strt);
					hshValues.put("page", page);
					hshValues.put("IRBUpload", hidUpload);
					hshValues.put("loan_catgry", loan_catgry);
					hshValues.put("Auditflag", audit_flag);
					// Added for Customer details
					if(loan_catgry.equals("Above1c")){
						hshRequestValues.put("strAppNo",strappno);
						hshRequestValues.put("strAppId",strValue); 
						hshRequestValues.put("strcomId",strcomId);
						hshRequestValues.put("strFacNo",strFacNo);
						hshRequestValues.put("printtype","Y");
						hshRequestValues.put("pageval","CorpAnnexure");
						hshRequestValues=getCorpAnnexureII(hshRequestValues);
						hshRequestValues.put("page","CorpAnnexure");
						hshValues.put("hshReqValues5",hshRequestValues);
					}
				
			} catch (Exception ce) {
					ce.printStackTrace();
					throw new EJBException("Error in getCgtmseFinancialData login  " + ce.toString());

				} finally {
					try {
						if (rs != null)
							rs.close();
						if (rs1 != null)
							rs1.close();
						if (rs3 != null)
							rs3.close();
						if (rs4 != null)
							rs4.close();
						if (rs10 != null)
							rs10.close();
					} catch (Exception cf) {
						throw new EJBException("Error closing the connection "
								+ cf.getMessage());
					}
				}

				return hshValues;
			}
	public HashMap getAnnexCorpData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		int str = 0, tabcnt = 0, l = 0;
		String sumaudit = "";
		String sumunaudit = "";
		String sumestimated = "";
		String sumprojection = "";
		String sel_divID = "";
		String pagetab = "";
		String base_year = "";
		String strAction = "";
		String fintype = null;
		String chk1 = "", chk2 = "", chk3 = "", chk4 = "", chk5 = "";
		ArrayList arr_labeldetails = new ArrayList();
		String strappno = "";
		String appid = "";
		String finance_id = "";
		String strValuesin = "";
		String queryloamamt="";
		String apploamamt="";
		String samplevalue="";
		String loanmodule="";
		int sampleval=0;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		ArrayList arrRowPrmo	= new ArrayList();
		ArrayList arrColPrmo	= new ArrayList();
		ArrayList arrRowDefault	= new ArrayList();
		ArrayList arrColDefault	= new ArrayList();
		ArrayList arrRowEcgc	= new ArrayList();
		ArrayList arrColEcgc	= new ArrayList();
		HashMap hshReqDetails=null;
		HashMap hshRespDetails=null;
		String strAmountValue="",strType="",strPromoterChk="",strVal="";
		String strTypecheck[]	= null;
		
		
		
		try {
			String hidFreeze = correctNull((String) hshRequestValues
					.get("strFreeze"));
			String hidUpload = correctNull((String) hshRequestValues
					.get("hidUpload"));
			// to get the process note base on print out option
			String printtype = correctNull((String) hshRequestValues
					.get("printtype"));

			strAction = Helper.correctNull((String) hshRequestValues
					.get("hidAction"));
			// --------This is Existing Finia-----

			if (strValue.equals("")) {
				strValue = correctNull((String) hshRequestValues
						.get("hidfinanceid"));
				finance_id = correctNull((String) hshRequestValues
						.get("hidfinanceid"));
			}
			if (strValue.equals("")) {
				strValue = correctNull((String) hshRequestValues
						.get("hidfinid"));
				finance_id = correctNull((String) hshRequestValues
						.get("hidfinid"));
			}

			appid = correctNull((String) hshRequestValues.get("hidappid"));
			if (appid.equals("")) {
				appid = correctNull((String) hshRequestValues.get("hid_appid"));
			}
			if (appid.equals("")) {
				appid = correctNull((String) hshRequestValues.get("appidnew"));
			}
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}

			strappno = Helper.correctNull((String) hshRequestValues
					.get("APP_NO"));
			if (!strappno.equals("")) {
				if (finance_id.equals("")) {
					String query1 = SQLParser
							.getSqlQuery("comdemographics_sel^" + strappno);
					rs = DBUtils.executeQuery(query1);

					if (rs.next()) {
						finance_id = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
						strValue = (Helper.correctInt((String) rs
								.getString("demo_finstandard")));
					}
				}
			}
			
			
			

			String page = correctNull((String) hshRequestValues.get("pageval"));
			pagetab = Helper.correctNull(page);

			rs = null;
			chk1 = correctNull((String) hshRequestValues.get("printchk1"));
			chk2 = correctNull((String) hshRequestValues.get("printchk2"));
			chk3 = correctNull((String) hshRequestValues.get("printchk3"));
			chk4 = correctNull((String) hshRequestValues.get("printchk4"));
			chk5 = correctNull((String) hshRequestValues.get("printchk5"));
			
			
			
			/////////////////////////////////////
			if(!strappno.equalsIgnoreCase("")){
				
				queryloamamt = SQLParser.getSqlQuery("loanamt_annexure_tab^"+ strappno);
				rs = DBUtils.executeQuery(queryloamamt);
				if (rs.next()) {
				apploamamt=Helper.correctNull((String) rs.getString("loan_amtreqd"));
				}
			}
			sampleval=Integer.parseInt(apploamamt);
			//sampleval=5000001;
			sampleval=10000001;
			 //ArrayList al=new ArrayList();
			 
			
			if(sampleval<=1000000){
				samplevalue="'520','580','583'";	
				loanmodule="A. Loans   1 Lakh- 10 Lakh";
			}
			else if(sampleval>=1000000 && sampleval<=5000000){
				samplevalue="'520','580','583','596','1246','629'";
				loanmodule="B. Loans   Above 10 Lakh- 50 Lakh";
			}
			else if(sampleval>=5000000 && sampleval<=10000000){
				samplevalue="'520','580','583','1246','506','596','629'";
				loanmodule="C. Loans  Above 50 Lakh and less than 100 Lakh";
			}
			else if(sampleval>=10000000){
				samplevalue="'520','578','527','579','502','470','471','440','443','444'";
				loanmodule="D. Loan  100 Lakh and above";
			}
			//hshValues.put("loanmodule",loanmodule);
			
			///////////////////////////////

			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecid = new ArrayList();
			hshValues.put("sel_divID", sel_divID);
			hshValues.put("loanmodule",loanmodule);

			// Retreving of values for project input

			String query1 = SQLParser
					.getSqlQuery("financial_new_projectinputfields_select^"
							+ strValue);
			rs = DBUtils.executeQuery(query1);
			ArrayList vec = new ArrayList();
			if (rs.next()) {
				vec.add(Helper.correctNull(Helper
						.correctNull((String) rs.getString(10))));
				vec.add(Helper.correctNull(Helper
						.correctNull((String) rs.getString(2))));
				if (Helper.correctNull(rs.getString(3)).equalsIgnoreCase("")) {
					vec.add("0.00");
				} else {
					vec
							.add(Helper.correctNull((String) rs
									.getString(3)));
				}
				if (Helper.correctNull(rs.getString(4)).equalsIgnoreCase("")) {
					vec.add("0.00");
				} else {
					vec
							.add(Helper.correctNull((String) rs
									.getString(4)));
				}
				vec.add(Helper.correctNull((String) rs.getString(5)));
				vec.add(Helper.correctNull((String) rs.getString(6)));
				vec.add(Helper.correctNull((String) rs.getString(7)));
				vec.add(Helper.correctNull((String) rs.getString(8)));
				vec.add(Helper.correctNull((String) rs.getString(9)));
				hshValues.put("projectinputvalue", vec);
			} else {
				vec.add("");
				vec.add("");
				vec.add("0.00");
				vec.add("0.00");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("0.00");
				hshValues.put("projectinputvalue", vec);
			}

			// Retreving of value for base year

			if (rs != null) {
				rs.close();
			}

			String baseyear_query = SQLParser
					.getSqlQuery("sel_financial_baseyear^" + strValue);
			rs = DBUtils.executeQuery(baseyear_query);

			if (rs.next()) {
				base_year = Helper.correctNull((String) rs
						.getString("base_year"));
			}

			hshValues.put("base_year", base_year);

			// -------------- to find the time of review-----------------

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("finselect1^" + strValue + "^"
					+ sel_divID);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				str = rs.getInt("cnt");
			}

			// --------------- to find the cma format of the particular
			// applications-------

			String tempbool = "2", tabool = "";
			String cma = "0";
			log.info((String) hshRequestValues.get("cattype"));
			/*
			 * strQuery=SQLParser.getSqlQuery("comfinance_appid^"+strValue);
			 * if(rs != null) { rs.close(); } rs =
			 * DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { cma=correctNull(rs.getString("fin_cmano"));
			 * fintype = Helper.correctNull((String)rs.getString("fin_cmano"));
			 * }
			 */

			cma = Helper
					.correctNull((String) hshRequestValues.get("hidcmasno"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues
						.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}

				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs
								.getString("fin_cmano"));
					}
				}
			}

			/*
			 * if(cma.equalsIgnoreCase("5")) { if(pagetab.equalsIgnoreCase(""))
			 * { pagetab="INFRA STRUCTURE MODEL"; } }
			 */
			int strsize = 0;

			strQuery = SQLParser.getSqlQuery("corp_fin_year_count^" + strValue
					+ "^" + sel_divID);

			if (rs10 != null) {
				rs10.close();
			}
			rs10 = DBUtils.executeQuery(strQuery);
			if (rs10.next()) {

				strsize = rs10.getInt("yearcount");
			}

			strQuery = null;

			String stryear[] = new String[strsize];

			int i = 0;
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}
			if (rs10 != null)
				rs10.close();
			rs10 = DBUtils.executeQuery(strQuery);
			while (rs10.next()) {

				stryear[i] = rs10.getString("fin_year");
				i++;
			}

			i = 0;
			String strDate = "";
			int strcurcount = 0;
			// to check for current year duplication
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_fintype_curryear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_fintype_curryear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strcurcount = strcurcount + 1;
			}
			String strdesctype[] = new String[strcurcount];
			int insno[] = new int[strcurcount];
			rs.beforeFirst();
			while (rs.next()) {

				strdesctype[i] = rs.getString("com_fintype");
				insno[i] = rs.getInt("com_sno");
				strDate = rs.getString("caf_year");
				i++;

			}
			// for take Financial Type Base on Priority
			String strpro = "false", strest = "false", straud = "false", strunaud = "false";
			int prosno = 0, estsno = 0, unaudsno = 0, audsno = 0, intyearsno = 0;
			if (i > 0) {
				for (int j = 0; j < strdesctype.length; j++) {

					if (strdesctype[j].equals("PROJECTION"))

					{
						strpro = "true";
						prosno = insno[j];

					}
					if (strdesctype[j].equals("ESTIMATED"))

					{
						strest = "true";
						estsno = insno[j];

					}
					if (strdesctype[j].equals("UNAUDITED"))

					{
						strunaud = "true";
						unaudsno = insno[j];

					}
					if (strdesctype[j].equals("AUDITED")) {
						straud = "true";
						audsno = insno[j];

					}

				}

				if (straud.equals("true")) {
					intyearsno = audsno;

				} else if (strunaud.equals("true")) {
					intyearsno = unaudsno;

				} else if (strest.equals("true")) {
					intyearsno = estsno;

				} else {
					intyearsno = prosno;

				}

			}
			// }

			// -----------------to find the tab----------------------

			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			int y = 0;
			while (rs.next()) {
				if ((y == 0)
						&& (page.trim().equals("") || page.trim().equals("RA"))) {
					page = correctNull((String) rs.getString("fin_tabname"));
				}

				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("fin_tabname")));
				vecVal.add(vecRec);

			}

			hshValues.put("tabdetails", vecVal);
			vecVal = new ArrayList();

			// --------------- to select label depending upon existence of
			// application
			String tempsno = "";
			if (str <= 0) {
				strQuery = SQLParser.getSqlQuery("finselect2_corp_annexure^" + cma + "^"
						+ page +"^"+samplevalue);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					arr_labeldetails = new ArrayList();
					
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					tempsno = correctNull(rs.getString("fin_sno"));
					
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);
					vecVal.add(vecRec);

				}
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect2_label^" + cma
						+ "^" + page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					arr_labeldetails
							.add(correctNull(rs.getString("fin_rowid")));

				}

				hshValues.put("labeldetails", vecVal);
				hshValues.put("arr_labeldetails", arr_labeldetails);
			}

			else if (str > 0) {
				vecVal = new ArrayList();
				String temp = "";
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect3z_corp_annexure^" + cma + "^"
						+ page +"^"+samplevalue);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecRec = new ArrayList();
					
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals("")) {
						vecRec.add(correctNull(rs.getString("desc2")));
					} else {
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));

					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals("")) {
						tempsno = " ";
					}

					vecRec.add(tempsno);

					vecVal.add(vecRec);
				}
				arr_labeldetails = new ArrayList();
				strQuery = SQLParser.getSqlQuery("finselect3z_label^" + cma
						+ "^" + page);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					arr_labeldetails.add(correctNull(rs.getString("myrowid")));

				}

				hshValues.put("labeldetails", vecVal);
				hshValues.put("arr_labeldetails", arr_labeldetails);
			}

			hshValues.put("count", Integer.toString(str));

			String yearselect = "", seloption = "", givenyear = "";
			i = 0;
			int k = 0;
			int from = 0, p = 0, tt = 0;

			ArrayList vecrec = new ArrayList();
			ArrayList vecrec_strt = new ArrayList();
			givenyear = correctNull((String) hshRequestValues.get("from"));
			if (givenyear.equals("")) {
				givenyear = "0";
			}
			from = Integer.parseInt(givenyear);
			if (from == 0) {
				from = 1;
			}

			String valarray[] = new String[6];
			valarray[0] = "0";
			valarray[1] = "0";
			valarray[2] = "0";
			valarray[3] = "0";
			valarray[4] = "0";

			strQuery = SQLParser.getSqlQuery("finYearSel^" + strValue + "^"
					+ sel_divID);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryvall = new ArrayList();

			int kk = 0;
			while (rs.next()) {
				arryvall.add(Helper.correctNull(rs.getString("fin_year")));

			}

			// this code has been commented by balaji & shanmugam for get all
			// the year for all the sub tags
			// and new line has been added bellow
			String sno = "0";
			if (!printtype.equalsIgnoreCase("Y")) {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear^"
								+ strValue + "^" + sel_divID);
			} else {
				strQuery = SQLParser
						.getSqlQuery("corp_app_financials_select_distinctyear_print^"
								+ strValue + "^" + sel_divID + "^" + strValue);
			}

			if (rs != null) {
				rs.close();
			}
			int o = 1;
			int t = 1;
			int r = 1;
			rs = DBUtils.executeQuery(strQuery);
			String audit_flag = "false";
			while (rs.next()) {
				valarray[0] = "0";
				valarray[1] = "0";
				valarray[2] = "0";
				valarray[3] = "0";
				valarray[4] = "0";
				vecVal = new ArrayList();
				String desc = "";
				yearselect = (String) Helper.correctNull(rs
						.getString("fin_year"));
				String yearselect_strt = (String) Helper.correctNull(rs
						.getString("COM_FINYEAR_START"));
				sno = (String) Helper.correctNull(rs.getString("com_sno"));
				if (!yearselect.equals("")) {
					if (rs3 != null) {
						rs3.close();
					}

					String strQuery10 = SQLParser.getSqlQuery("assessselect9^"
							+ strValue + "^" + sel_divID + "^" + yearselect
							+ "^" + sno);
					if (rs10 != null) {
						rs10.close();
					}

					rs10 = DBUtils.executeQuery(strQuery10);
					if (rs10.next()) {
						sumaudit = Helper.correctDouble(rs10
								.getString("sumaudit"));
						sumunaudit = Helper.correctDouble(rs10
								.getString("sumunaudit"));
						sumestimated = Helper.correctDouble(rs10
								.getString("sumestimated"));
						sumprojection = Helper.correctDouble(rs10
								.getString("sumprojection"));
					}
					if (valarray[0].equals("0") && !sumaudit.equals("0")) {
						valarray[0] = "fin_audit";
						audit_flag = "true";
					}
					if (valarray[1].equals("0") && !sumunaudit.equals("0")) {
						valarray[1] = "fin_unaudit";
					}
					if (valarray[2].equals("0") && !sumestimated.equals("0")) {
						valarray[2] = "fin_estimated";
					}
					if (valarray[3].equals("0") && !sumprojection.equals("0")) {
						valarray[3] = "fin_projection";
					}
					if (valarray[4].equals("0") && !sumprojection.equals("0")) {
						valarray[4] = "fin_projection";
					}

					if (rs10 != null) {
						rs10.close();
					}

					for (int h = 0; h < 4; h++) {
						vecVal = new ArrayList();
						vecid = new ArrayList();

						if (valarray[h].equals("")) {
							valarray[h] = "0.00";
						}
						if (!valarray[h].equals("0")) {
							i = i + 1;
							seloption = valarray[h];
							boolean flag=false;
							if (printtype.equalsIgnoreCase("Y")) 
							{
								flag=true;
							}
							else
							{
								if(k>=5)
									flag=false;
								else
									flag=true;
							}
							if ((i >= from) && flag) {
								p = i;
								k = k + 1;
								hshValues.put("sno" + (o++), sno);
//								strQuery = SQLParser.getSqlQuery("finselect5^"
//										+ seloption + "^" + cma + "^" + page
//										+ "^" + yearselect + "^" + strValue
//										+ "^" + sel_divID + "^" + sno);

								strQuery = SQLParser.getSqlQuery("finselect5_corp_annexure^"//query changed
										+ seloption + "^" + yearselect + "^" + strValue
										+ "^" + sel_divID + "^" + sno
										+ "^" + cma + "^" + page + "^"+samplevalue);

								if (rs1 != null) {
									rs1.close();
								}
								rs1 = DBUtils.executeQuery(strQuery);
								while (rs1.next()) {

									vecVal.add(correctNull(rs1.getString("txtvalue")));
											
									vecid.add(correctNull(rs1.getString("fin_rowid")));
									
									hshValues.put("year" + k, vecVal);
									System.out.println("////////////////////////////////////////"+vecVal);
									hshValues.put("vecid" + k, vecid);
									}
							

								if (rs1 != null) {
									rs1.close();
								}
								vecrec.add(yearselect);
								vecrec.add(seloption);
								vecrec_strt.add(yearselect_strt);
								strQuery = SQLParser
										.getSqlQuery("com_selfinancial_printyear^"
												+ sno + "^" + strValue);
								if (rs1 != null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) {

									hshValues
											.put(
													"checkcol" + (t++),
													Helper
															.correctNull((String) rs1
																	.getString("FINPRINTYEAR_SELSNO")));

								} else {
									t++;
								}
								
								strQuery = SQLParser
								.getSqlQuery("com_selfinancial_rateyear^"
										+ sno + "^" + strValue);
								if (rs1 != null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								if (rs1.next()) {
									
									hshValues
									.put(
											"ratecol" + (r++),
											Helper
											.correctNull((String) rs1
													.getString("FINRATEYEAR_SELSNO")));
									
								} else {
									r++;
								}
							}

						}
					}
				}
			}

			hshValues.put("from", Integer.toString(from));

			hshValues.put("totalyear", i + "");
			hshValues.put("upto", p + "");
			hshValues.put("yearvalue", vecrec);
			hshValues.put("yearvalue_strt", vecrec_strt);
			hshValues.put("page", page);
			hshValues.put("IRBUpload", hidUpload);
			hshValues.put("Freeze", hidFreeze);
			hshValues.put("Auditflag", audit_flag);
			// checking for the values in the com_finappvalues table
			strQuery = SQLParser.getSqlQuery("com_finappvaluessel^" + strValue
					+ "^" + sel_divID);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshValues.put("findata", "true");
			} else {
				hshValues.put("findata", "false");
			}

			// to get the Freeze value from com_finance table
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("comfinance_finappid^" + strValue);
			rs = DBUtils.executeQuery(strQuery);

			String freeze_flag = "N";
			if (rs.next()) {
				freeze_flag = Helper.correctNull((String) rs
						.getString("fin_freeze"));
				strValuesin = Helper.correctNull((String) rs
						.getString("fin_valuesarein"));
				appid=Helper.correctNull((String) rs.getString("fin_comappid"));
				hshValues.put("fin_model_name",Helper.correctNull((String) rs.getString("CMA_FORMAT_DESC")));
			}
			hshValues.put("freeze_flag", freeze_flag);
			hshValues.put("strValuesin", strValuesin);

			// to get the count of particular tab from com_finmaster
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("com_financetabcount^" + cma + "^"
					+ page);
			rs = DBUtils.executeQuery(strQuery);

			int rowid_count = 0;
			if (rs.next()) {
				rowid_count = Integer.parseInt((Helper.correctInt((String) rs
						.getString("fin_tabcount"))));
			}
			hshValues.put("rowid_count", String.valueOf(rowid_count));

			String attach_flag = "false";
			int cma_flag = 0;
			// to get whether the appno attahced with any cma format
			if (!strappno.equals("")) {
				strQuery = SQLParser.getSqlQuery("comdemographics_sel^"
						+ strappno);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {

					cma_flag = Integer.parseInt((Helper.correctInt((String) rs
							.getString("demo_finstandard"))));
				}
			}

			// to check whether finance id is attached with any application
			String appattachflag = "false";
			String strattach_appno = "";
			rs1 = null;
			String app_status = "";

			if (!finance_id.equals("")) {
				query1 = SQLParser.getSqlQuery("comappnoselect_finid^"+ finance_id);
				rs = DBUtils.executeQuery(query1);
				while (rs.next()) 
				{
						appattachflag = "true";
				}
				if(rs1!=null)
				{rs1.close();}
				query1 = SQLParser.getSqlQuery("sel_finratappno^"+ finance_id);
				rs1 = DBUtils.executeQuery(query1);
				while (rs1.next()) 
				{
					if(correctNull(rs1.getString("fin_status")).equalsIgnoreCase("pa"))
						appattachflag = "true";
				}
			}
			hshValues.put("attach_flag", String.valueOf(cma_flag));
			hshValues.put("tabname", pagetab);
			hshValues.put("strAction", strAction);
			hshValues.put("fintype", cma);
			hshValues.put("finappid", appid);
			hshValues.put("appidnew", appid);
			hshValues.put("finace_id", finance_id);

			hshValues.put("PAflag", appattachflag);
			// to get whether finance_id is attached with
			
			if(rs!=null)
			{rs.close(); 	
			}
			
			String strAssetFinRowID="0";
			rs = DBUtils.executeLAPSQuery("sel_rowid^"+"TOTAL LIABILITIES^FI^"+cma);
			if (rs.next()) {
				strAssetFinRowID = Helper.correctInt((String) rs.getString("fin_rowid"));
			}
			
			
			double dblTotAsset=0.0,dblTotLiab=0.0;
			rs = DBUtils.executeLAPSQuery("sel_totalAssets^"+finance_id+"^"+strAssetFinRowID);
			if(rs.next())
			{
				dblTotAsset=Double.parseDouble(Helper.correctDouble(rs.getString("TotalAsset")));
			}
			
			if(rs!=null)
			{rs.close(); 	
			}
			
			String strLiabFinRowID="0";
			rs = DBUtils.executeLAPSQuery("sel_rowid^"+"TOTAL ASSETS^FI^"+cma);
			if (rs.next()) {
				strLiabFinRowID = Helper.correctInt((String) rs.getString("fin_rowid"));
			}
			if(rs!=null)
			{rs.close(); 	
			}
			rs = DBUtils.executeLAPSQuery("sel_totalLiab^"+finance_id+"^"+strLiabFinRowID);
			if(rs.next())
			{
				dblTotLiab =Double.parseDouble(Helper.correctDouble(rs.getString("TotalLiab")));
			}
			
			if( (dblTotAsset==dblTotLiab) && (dblTotAsset>0 || dblTotLiab>0))
			{
				hshValues.put("AssetandLiab", "Y");
			}
			
			rs = DBUtils.executeLAPSQuery("sel_maxfinanceid^"+appid+"^"+cma);
			if(rs.next())
			{
				if(!finance_id.equalsIgnoreCase(Helper.correctNull((String)rs.getString("maxid"))))
				{
					hshValues.put("DisableAllButtons", "Y");
				}
			}
			

		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getData login  " + ce.toString());

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs3 != null)
					rs3.close();
				if (rs4 != null)
					rs4.close();
				if (rs10 != null)
					rs10.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;
	}
	public HashMap getDigiRating(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();

		try
		{
			String strAppno="",strAppID="",cma = "0", strQuery = "",finance_id="",digiflag="";
			
			strAppno=Helper.correctNull((String) hshRequestValues.get("hidRatAppNo"));
			strAppID=Helper.correctNull((String) hshRequestValues.get("hid_appid"));
			if(strAppID.equalsIgnoreCase("")){
				strAppID=Helper.correctNull((String) hshRequestValues.get("hidAppId"));
			}
			if(!strAppID.equalsIgnoreCase("") && strAppno.equalsIgnoreCase("")){
				
			rs=DBUtils.executeLAPSQuery("sel_finrating_digi^"+strAppID);
			if (rs.next()) 
			{
				strAppno = correctNull(rs.getString("fin_ratappno"));
			}
			
			}
			rs=DBUtils.executeLAPSQuery("sel_digi_rate_score^"+strAppno);
			if (rs.next()) 
			{
				hshRequestValues.put("COMMERCIAL_BUREAU_SCORE", correctNull(rs.getString("COMMERCIAL_BUREAU_SCORE")));
				hshRequestValues.put("CONSUMER_IND_SCORE", correctNull(rs.getString("CONSUMER_IND_SCORE")));
				hshRequestValues.put("CONSUMER_PARTY_SCORE", correctNull(rs.getString("CONSUMER_PARTY_SCORE")));
				hshRequestValues.put("OD_ACCOUNT_SCORE", correctNull(rs.getString("OD_ACCOUNT_SCORE")));
				hshRequestValues.put("CURRENT_ACCOUNT_SCORE", correctNull(rs.getString("CURRENT_ACCOUNT_SCORE")));
				hshRequestValues.put("FSA_SCORE", correctNull(rs.getString("FSA_SCORE")));
				hshRequestValues.put("BAND_RATING", correctNull(rs.getString("BAND_RATING")));
				hshRequestValues.put("BAND_PATH", correctNull(rs.getString("BAND_PATH")));
				hshRequestValues.put("KB_RATING", correctNull(rs.getString("KB_RATING")));
				hshRequestValues.put("FINANCIAL_TYPE", correctNull(rs.getString("FINANCIAL_TYPE")));
				hshRequestValues.put("FINANCIAL_YEAR", correctNull(rs.getString("FINANCIAL_YEAR")));

			}
			
			finance_id = correctNull((String) hshRequestValues.get("hidfinanceid"));
			cma = Helper.correctNull((String) hshRequestValues.get("hidcmasno"));
			strAppID = correctNull((String) hshRequestValues.get("hid_appid"));
			
			strAppno = Helper.correctNull((String) hshRequestValues.get("hidRatAppNo"));
			if (cma.equalsIgnoreCase("")) {
				cma = Helper.correctNull((String) hshRequestValues.get("hidCMANo"));
			}
			if (cma.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}

				if (!finance_id.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"
							+ finance_id);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {

						cma = Helper.correctNull((String) rs.getString("fin_cmano"));
						strAppID = Helper.correctNull((String) rs.getString("fin_comappid"));
						hshRequestValues.put("hidAppId", strAppID);
					}
				}
			}
			if (cma.equalsIgnoreCase("")) {
				cma = "0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^" + cma);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				int y = 0;
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_tabname")));
					vecVal.add(vecRec);
				}
				hshRequestValues.put("tabdetails", vecVal);


				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strAppno);
				 rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  
						digiflag =Helper.correctNull(rs.getString("FIN_DIGI_FLAG"));
			        }
					hshRequestValues.put("digiflag", digiflag);
					hshRequestValues.put("digicma", cma);
					hshRequestValues.put("digistrAppID", strAppID);
					hshRequestValues.put("digifinanceid", finance_id);
					
			
		}catch (Exception e) {
			throw new EJBException("Error in financial Bean getDigiRating..."+e.toString());
		}
		return hshRequestValues;
		
	}
}
