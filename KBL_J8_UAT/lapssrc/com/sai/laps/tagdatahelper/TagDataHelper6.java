package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper6 extends BeanAdapter {
	static Logger log=Logger.getLogger(TagDataHelper6.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	/**
	 * Bean : FinMasterBean
	 * 
	 * @param hsh
	 * @return
	 * @
	 */
	public HashMap getDataHelp(HashMap hsh)  {

		String strQuery = "";

		ResultSet rs = null;
		ResultSet rs3 = null;

		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", value5 = "", value6 = "", value7 = "";
		try {

			str = Helper.correctNull((String) hsh.get("val"));
			str = str.trim();

			value5 = Helper.correctNull((String) hsh.get("tabtitle"));
			value6 = Helper.correctNull((String) hsh.get("cmano"));
			value7 = Helper.correctNull((String) hsh.get("pagetitle"));

			if (str.equals("formula") || str.equals("formula2")) {

				rs = DBUtils.executeLAPSQuery("formulachoice^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("formula_rowid")));
					arr1.add(correctNull(rs.getString("formula_rowname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("cma") || str.equals("cma1")
					|| str.equals("ratingcma")) {

				rs = DBUtils.executeLAPSQuery("cmachoice");
				while (rs.next()) {
					arr.add(correctNull(rs.getString("cma_no")));
					arr1.add(correctNull(rs.getString("cma_format_desc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}
			if (str.equals("tabtitle")) {

				rs = DBUtils.executeLAPSQuery("tabchoice^" + value6 + "^"
						+ value7);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_tabname")));
					arr1.add(correctNull(rs.getString("fin_tabname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("selfdescription")) {

				rs = DBUtils.executeLAPSQuery("description1^" + value7 + "^"
						+ value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("description")) {

				rs = DBUtils.executeLAPSQuery("description2^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("rowdesc")) {
				if (value7.equals("FI") || value7.equals("MU") ||value7.equals("MA")||value7.equals("INV") ) {
					strQuery = SQLParser.getSqlQuery("rowchoice^" + value6
							+ "^" + value5 + "^" + value7);
				} else {
					strQuery = SQLParser.getSqlQuery("rowchoicea^" + value6
							+ "^" + value7);
				}

				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					String totalval;
					String rowid = "", formuladesc = "", coltype = "", formula2 = "", formula2desc = "";

					if (!correctNull(rs.getString("fin_rowdesc").trim())
							.equals("")) {

						rowid = correctNull(rs.getString("formula_rowid"));
						coltype = correctNull(rs.getString("fin_rowtype"));
						coltype = coltype.trim();

						if (rowid.equals("")) {
							rowid = "0";
						}

						formuladesc = correctNull(rs
								.getString("formula_rowname"));
						formula2 = correctNull(rs.getString("fin_formula2"));
						if (!formula2.equals("0") && !formula2.equals("")) {

							rs3 = DBUtils.executeLAPSQuery("finformuladesc^"
									+ formula2);
							while (rs3.next()) {
								formula2desc = correctNull(rs3
										.getString("formula_rowname"));
							}
							formula2 = correctNull(rs.getString("fin_formula2"));
						} else {
							formula2 = "";
							formula2desc = "";

						}
						formuladesc.trim();
						totalval = formuladesc
								+ "^"
								+ rowid
								+ "^"
								+ correctNull(rs.getString("fin_rowtype"))
								+ "^"
								+ correctNull(rs.getString("fin_rowid"))
								+ "^"
								+ correctNull(rs.getString("fin_sno"))
								+ "^"
								+ value7
								+ "^"
								+ correctNull(rs.getString("fin_formula"))
								+ "^"
								+ formula2
								+ "^"
								+ formula2desc
								+ "^"
								+ correctNull(rs.getString("fin_stress"))
								+ "^"
								+ correctNull(rs.getString("fin_stress_percent"))
								+ "^"
								+ correctNull(rs.getString("FIN_KALYPTO_CODE"))
								+ "^"
								+ correctNull(rs.getString("FIN_PERFIOS_MAPPINGCODE"));

						arr.add(totalval);
						arr1.add(correctNull(rs.getString("fin_rowdesc")));
					}
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}
			
			if(str.equalsIgnoreCase("benchrowdesc"))
			{
				String benchformulaid=""; 
				String benchformuladesc="";
				strQuery = SQLParser.getSqlQuery("com_benchmarkrowdesc^" + value6);
				if(rs!=null)
					rs.close();
				
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arr1.add(correctNull(rs.getString("BENCH_ROWDESC")));
					benchformuladesc="";
					
					benchformulaid=Helper.correctNull((String)rs.getString("BENCH_FORMULA"));
					if(rs3!=null)
						rs3.close();
					if((Helper.correctNull((String)rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("FI") || Helper.correctNull((String)rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("DSCR")) && !benchformulaid.equalsIgnoreCase(""))
					{
						
						rs3 = DBUtils.executeLAPSQuery("finformuladesc^"+ benchformulaid);
						if(rs3.next()) 
						{
							benchformuladesc = correctNull(rs3.getString("formula_rowname"));
						}
					}
					else if(Helper.correctNull((String)rs.getString("BENCH_DEPENDSON")).equalsIgnoreCase("OT") && !benchformulaid.equalsIgnoreCase(""))
					{
						rs3 = DBUtils.executeLAPSQuery("fin_benchformuladesc^"+ benchformulaid);
						if(rs3.next()) 
						{
							benchformuladesc = correctNull(rs3.getString("BENCHINBUILDPARAM_DESC"));
						}
					}
						
					
					String Strdesc=Helper.correctNull((String)rs.getString("BENCH_POLICY"))+"^"
					+Helper.correctNull((String)rs.getString("BENCH_DEPENDSON"))+"^"
					+benchformuladesc+"^"
					+Helper.correctNull((String)rs.getString("BENCH_ROWID"))+"^"
					+benchformulaid;
					arr.add(Strdesc);
				}
				
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

		}

		catch (Exception e) {
			log.error("error occured" + e.toString());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs3 != null) {
					rs3.close();
				}

			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshvalues;
	}

	/**
	 * Bean : SetModTermsCondBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getTermData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		try {

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("setmodtermcondterm");
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 2; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecVal", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	/**
	 * Bean : PerApplicantBean
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getInterestTerms(HashMap hshValues)  {

		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;

		String strProductCode = (String) hshValues.get("appid");
		try {

			rs = DBUtils.executeLAPSQuery("seltermsint^" + strProductCode);
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(rs.getString("prd_termfrom"));
				arryCol.add(rs.getString("prd_termto"));
				arryCol.add(rs.getString("prd_interest"));
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow", arryRow);

		} catch (Exception ce) {
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}

		finally {
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
	 * Bean : SetUsersBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getUserList(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = null;

		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();

		try {

			rs = DBUtils.executeLAPSQuery("setuserlist");
			hshRecord = new HashMap();
			/*
			 * while(rs.next()) { String strId=rs.getString("usr_id");
			 * log.info("usr_id.."+strId); String
			 * strName=rs.getString("usr_fname");
			 * log.info("usr_fname.."+strName);
			 * 
			 * String strUsrClass=rs.getString("usr_class");
			 * log.info("usr_class.."+strUsrClass);
			 * 
			 * arrValues=new ArrayList(); arrValues.add(strName);
			 * arrValues.add(strUsrClass); hshRecord.put(strId,arrValues); }
			 */

			// Modified By HAri -Start
			while (rs.next()) {
				String strId = rs.getString("usr_id");
				// log.info("usr_id.."+strId);
				String strName = Helper.correctNull((String)rs.getString("usr_fname")) + " " + Helper.correctNull((String)rs.getString("usr_lname"));
				// log.info("usr_fname.."+strName);

				String strUsrClass = rs.getString("usr_class");
				// log.info("usr_class.."+strUsrClass);

				/*
				 * arrValues=new ArrayList(); arrValues.add(strName);
				 * arrValues.add(strUsrClass); hshRecord.put(strId,arrValues);
				 */

				vecRec = new ArrayList();
				vecRec.add(strId);
				vecRec.add(strName);
				vecRec.add(strUsrClass);
				vecVal.add(vecRec);
			}

			hshRecord.put("users_data", vecVal);

			// Modified By Hari - End

			// log.info("hshRecord.."+hshRecord);

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getUserList " + ce.toString());
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
	 * Bean : SetProductsBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getWorkflowList(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		String strWorkflowType = null;
		HashMap hshRecord = new HashMap();
		try {
			strWorkflowType = (String) hshRequestValues.get("wrk_flowtype");

			rs = DBUtils.executeLAPSQuery("workflowlist^" + strWorkflowType);
			while (rs.next()) {
				hshRecord.put(rs.getString("wrk_flowid"), rs
						.getString("wrk_flowname"));
			}
		} catch (Exception e) {
			log.error("Exception in getWorkList.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception e1) {
				log.error("Error closing connection.. " + e1);
			}
		}
		return hshRecord;
	}

	/**
	 * Bean : CommWorkflowBean
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getWorkUsers(HashMap hshValues)  {
		
		String strOrgCode = "";
		String strUsrClass = "";
		String strFunction = "";
		String strQuery = "";
		String strUsrDept="";

		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrUsers = new ArrayList();
		ArrayList arrUserss = new ArrayList();
		
		try 
		{			
			strOrgCode = Helper.correctNull((String) hshValues.get("strOrgCode"));
			strUsrClass =Helper.correctNull((String) hshValues.get("usr_class"));
			strFunction =Helper.correctNull((String) hshValues.get("usr_func"));
			strUsrDept =Helper.correctNull((String) hshValues.get("usr_dept"));
			if((strUsrClass.equalsIgnoreCase("")&& strFunction.equalsIgnoreCase("")))
			{
				if(strOrgCode.equalsIgnoreCase("001000000000000") && !strUsrDept.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("workflowusrhelp^'"+strOrgCode+"' and usr_department='"+strUsrDept+"'");
				}
				else if(!strOrgCode.substring(6, 9).equalsIgnoreCase("000") && strOrgCode.substring(9, 15).equalsIgnoreCase("000000"))
				{
					strQuery = (SQLParser.getSqlQuery("workflowusrhelp1^'"+strOrgCode+"'"));
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("workflowusrhelp^'"+strOrgCode+"'");
				}
			}
			else if (strFunction.equals("All") || strFunction.equals("")) 
			{
				if(strOrgCode.equalsIgnoreCase("001000000000000") && !strUsrDept.equalsIgnoreCase("") )
				{
					strQuery = (SQLParser.getSqlQuery("workflowusrhelp^'"+strOrgCode+"' and usr_class>="+strUsrClass+" and usr_department='"+strUsrDept+"'"));	
				}
				else if(!strOrgCode.substring(6, 9).equalsIgnoreCase("000") && strOrgCode.substring(9, 15).equalsIgnoreCase("000000"))
				{
					strQuery = (SQLParser.getSqlQuery("workflowusrhelp1^'"+strOrgCode+"' and usr_class>="+strUsrClass));
				}
				else
				{
					strQuery = (SQLParser.getSqlQuery("workflowusrhelp^'"+strOrgCode+"' and usr_class>="+strUsrClass));
				}
			} 
			/*else 
			{
				strQuery = (SQLParser.getSqlQuery("workflowusrhelp^"+strOrgCode+" and usr_class>="+strUsrClass
						+ " and usr_function='" + strFunction + "'"));
			}*/

			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrUsers = new ArrayList();
				arrUsers.add(rs.getString(1));
				arrUsers.add(rs.getString(2));
				arrUsers.add(rs.getString(3));
				strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+rs.getString(3));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrUsers.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
				}
				else{
					arrUsers.add(rs.getString(3));
				}
				arrUsers.add(rs.getString(4));
				arrUsers.add(rs.getString(5));
				arrUserss.add(arrUsers);
			}
			
			hshRecord.put("arrUserss", arrUserss);
			return hshRecord;
		} 
		catch (Exception e) 
		{
			log.error("Error in gettting getWorkUsers.. "+ e);
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
			catch (Exception e1) 
			{
				throw new EJBException("Error closing connection.." + e1);
			}
		}

	}

	/**
	 * Bean : NoteFinMasterBean
	 * 
	 * @param hsh
	 * @return
	 * @
	 */
	public HashMap getDataHelp1(HashMap hsh)  {

		String strQuery = "";

		ResultSet rs = null;
		ResultSet rs3 = null;

		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", value5 = "", value6 = "", value7 = "";
		try {

			str = (String) hsh.get("val");
			str = str.trim();

			value5 = Helper.correctNull((String) hsh.get("tabtitle"));
			value6 = Helper.correctNull((String) hsh.get("cmano"));
			value7 = Helper.correctNull((String) hsh.get("pagetitle"));
			log.info("value7----------------------------" + value7);
			if (value6.equals(""))
				value6=" ";

			String strFI = "FI";

			if (str.equals("formula") || str.equals("formula2")) {

				rs = DBUtils.executeLAPSQuery("noteformulachoice^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("formula_rowid")));
					arr1.add(correctNull(rs.getString("formula_rowname")));
				}
				rs.close();

				rs = DBUtils.executeLAPSQuery("description1^" + strFI + "^"
						+ value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}

			if (str.equals("cma") || str.equals("cma1")
					|| str.equals("ratingcma")) {

				rs = DBUtils.executeLAPSQuery("notecmachoice");
				while (rs.next()) {
					arr.add(correctNull(rs.getString("cma_no")));
					arr1.add(correctNull(rs.getString("cma_format_desc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}
			if (str.equals("tabtitle")) {

				rs = DBUtils.executeLAPSQuery("tabchoice^" + value6 + "^"
						+ value7);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_tabname")));
					arr1.add(correctNull(rs.getString("fin_tabname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}

			if (str.equals("selfdescription")) {

				rs = DBUtils.executeLAPSQuery("notedescription1^" + value7
						+ "^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}

			if (str.equals("description")) {

				rs = DBUtils.executeLAPSQuery("notedescription2^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}

			if (str.equals("rowdesc")) {
				if (value7.equals("FI") && !value5.trim().equals("")) {
					strQuery = SQLParser.getSqlQuery("noterowchoice^" + value6
							+ "^" + value5 + "^" + value7);
				} else {
					strQuery = SQLParser.getSqlQuery("noterowchoicea^" + value6
							+ "^" + value7);
				}

				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					String totalval;
					String rowid = "", formuladesc = "", coltype = "", formula2 = "", formula2desc = "";

					if (!correctNull(rs.getString("fin_rowdesc").trim())
							.equals("")) {

						rowid = correctNull(rs.getString("formula_rowid"));
						coltype = correctNull(rs.getString("fin_rowtype"));
						coltype = coltype.trim();

						if (rowid.equals("")) {
							rowid = "0";
						}

						formuladesc = correctNull(rs
								.getString("formula_rowname"));
						formula2 = correctNull(rs.getString("fin_formula2"));
						if (!formula2.equals("0") && !formula2.equals("")) {

							rs3 = DBUtils
									.executeLAPSQuery("notefinformuladesc^"
											+ formula2);
							while (rs3.next()) {
								formula2desc = correctNull(rs3
										.getString("formula_rowname"));
							}
							formula2 = correctNull(rs.getString("fin_formula2"));
						} else {
							formula2 = "";
							formula2desc = "";

						}
						formuladesc.trim();
						totalval = correctNull(formuladesc) + "^" + correctNull(rowid) + "^"
								+ correctNull(rs.getString("fin_rowtype"))
								+ "^" + correctNull(rs.getString("fin_rowid"))
								+ "^" + correctNull(rs.getString("fin_sno"))
								+ "^" + correctNull(value7) + "^"
								+ correctNull(rs.getString("fin_formula"))
								+ "^" + correctNull(formula2) + "^" + correctNull(formula2desc)
								+"^"+correctNull(rs.getString("fin_attach")).trim()
								+"^"+correctNull(rs.getString("fin_indicator")).trim();

						arr.add(correctNull(totalval));
						arr1.add(correctNull(rs.getString("fin_rowdesc")));
					}
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
				rs.close();
			}

		}

		catch (Exception e) {
			log.error("error occured" + e.toString());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}

				if (rs3 != null) {
					rs3.close();
				}

			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		log.info("the val is " + hshvalues);
		return hshvalues;
	}

	/**
	 * Bean : NpaFinmasterBean
	 * 
	 * @param hsh
	 * @return
	 * @
	 */
	public HashMap getDataHelp2(HashMap hsh)  {

		ResultSet rs = null;

		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "",  value6 = "";
		try {

			str = (String) hsh.get("val");
			str = str.trim();

			value6 = Helper.correctNull((String) hsh.get("cmano"));


			if (str.equals("formula")) {

				rs = DBUtils.executeLAPSQuery("noteformulachoice^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("formula_rowid")));
					arr1.add(correctNull(rs.getString("formula_rowname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("cma")) {
				rs = DBUtils.executeLAPSQuery("notecmachoice");
				while (rs.next()) {
					arr.add(correctNull(rs.getString("cma_no")));
					arr1.add(correctNull(rs.getString("cma_format_desc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("selfdescription")) {

				rs = DBUtils.executeLAPSQuery("notedescription1^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("description")) {

				rs = DBUtils.executeLAPSQuery("notedescription2^" + value6);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("fin_rowid")));
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("rowdesc")) {

				rs = DBUtils.executeLAPSQuery("nparow^" + value6);
				while (rs.next()) {
					String totalval;
					String rowid = "", formuladesc = "", coltype = "";

					if (!correctNull(rs.getString("ratio_desc").trim()).equals(
							"")) {

						rowid = correctNull(rs.getString("id"));
						coltype = correctNull(rs.getString("ratio_desc"));
						coltype = coltype.trim();

						if (rowid.equals("")) {
							rowid = "0";
						}

						formuladesc = correctNull(rs
								.getString("formula_rowname"));

						formuladesc.trim();
						totalval = formuladesc + "^" + rowid + "^"
								+ correctNull(rs.getString("ratio_type")) + "^"
								+ correctNull(rs.getString("id")) + "^"
								+ correctNull(rs.getString("formula_rowid"));

						arr.add(totalval);
						arr1.add(correctNull(rs.getString("ratio_desc")));
					}
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

		}

		catch (Exception e) {
			log.error("error occured" + e.toString());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshvalues;
	}
	
	/**
	 * Bean : SetUsersBean
	 * @author: karthikeyan
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getClassStaticData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = null;

		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();

		try {
			String strId="7";
			rs = DBUtils.executeLAPSQuery("selclasslist^"+strId);
			hshRecord = new HashMap();
			
			while (rs.next()) {
				
				vecRec = new ArrayList();
				vecRec.add(correctNull((String)rs.getString("stat_data_id")));
				vecRec.add(correctNull((String)rs.getString("stat_data_desc")));
				vecRec.add(correctNull((String)rs.getString("stat_data_desc1")));
				vecVal.add(vecRec);
			}

			hshRecord.put("class_list", vecVal);

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getUserList " + ce.toString());
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
	 * Bean : SetUsersBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getHeadUserList(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("sel_userslist");
			hshRecord = new HashMap();
			
			while (rs.next()) {
				String strId = rs.getString("usr_id");
				String strName = Helper.correctNull((String)rs.getString("usr_fname")) + " " + Helper.correctNull((String)rs.getString("usr_lname"));
				String strUsrClass = rs.getString("usr_class");
				
				vecRec = new ArrayList();
				vecRec.add(strId);
				vecRec.add(strName);
				vecRec.add(strUsrClass);
				vecVal.add(vecRec);
			}

			hshRecord.put("users_data", vecVal);
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getUserList " + ce.toString());
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
	 * Author : M. Arsath Ayub
	 * Date : 12/02/2014
	 * Purpose : To get Tenor Period
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getFacilityTenor(HashMap hshRequestValues)  
	{

		ResultSet rs = null;
		HashMap hshRecord = null;
		double dbltenor = 0.00;
		String StrAppno = Helper.correctNull((String)hshRequestValues.get("appno"));
		try {
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("sel_tenorforfinyear^"+StrAppno);
			hshRecord = new HashMap();
			if (rs.next()) 
			{
				dbltenor = Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_months")));
			}
			hshRecord.put("dbltenor",String.valueOf(dbltenor));
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getUserList " + ce.toString());
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
	 * Author : M. Arsath Ayub
	 * Date : 26/02/2014
	 * Purpose : To get Activity Details
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getActivitydet(HashMap hshRequestValues)  
	{

		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		double dbltenor = 0.00;
		String StrAppno = Helper.correctNull((String)hshRequestValues.get("appno"));
		String strQuery="",strSchemetype="";
		ArrayList arryCol = new ArrayList();
		ArrayList arryRow = new ArrayList();
		NumberFormat nft=NumberFormat.getInstance();
		nft.setMinimumFractionDigits(2);
		nft.setMaximumFractionDigits(2);
		nft.setGroupingUsed(false);
		
		try {
			if(rs!=null)
			{
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_agriculture_facilitiesbasedonscheme^"+StrAppno+"^"+"aY");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strSchemetype.equalsIgnoreCase(""))
				{
					strSchemetype="'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
				}else
				{
					strSchemetype=strSchemetype+",'"+Helper.correctNull((String)rs.getString("facility_agrschemetype"))+"'";
				}
				
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_activitymaster^"+strSchemetype);
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				arryCol=new ArrayList();
				arryCol.add(correctNull((String)rs1.getString("ACT_SNO")));//0
				arryCol.add(correctNull((String)rs1.getString("ACT_DESC")));//1
				arryCol.add(correctNull((String)rs1.getString("ACT_RANGEFROM")));//2
				arryRow.add(arryCol);
			}
			hshRecord.put("arryRow",arryRow);
		} 
		
		catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getUserList " + ce.toString());
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
public HashMap getProposalUsers(HashMap hshValues)  {
		
		String strOrgCode = "";
		String strAppno = "";
		String strFunction = "";
		String strQuery = "";
		String strUsrDept="",strModuleType="";

		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrUsers = new ArrayList();
		ArrayList arrUserss = new ArrayList();
		
		try 
		{			
			strOrgCode = Helper.correctNull((String) hshValues.get("strOrgCode"));
			strAppno =Helper.correctNull((String) hshValues.get("appno"));
			strFunction =Helper.correctNull((String) hshValues.get("usr_func"));
			strUsrDept =Helper.correctNull((String) hshValues.get("usr_dept"));
			strModuleType =Helper.correctNull((String) hshValues.get("strModuleType"));
			
			if(strModuleType.equalsIgnoreCase("PER"))
			{
				if(strOrgCode.equalsIgnoreCase("001000000000000") && !strUsrDept.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_perappworkflowusers^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"' and usr_department='"+strUsrDept+"'");
				}
				else if(!strOrgCode.substring(6, 9).equalsIgnoreCase("000") && strOrgCode.substring(9, 15).equalsIgnoreCase("000000"))
				{
					strQuery = (SQLParser.getSqlQuery("sel_perappworkflowusers1^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"'"));
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_perappworkflowusers^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"'");
				}
			}
			else
			{
				if(strOrgCode.equalsIgnoreCase("001000000000000") && !strUsrDept.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_appworkflowusers^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"' and usr_department='"+strUsrDept+"'");
				}
				else if(!strOrgCode.substring(6, 9).equalsIgnoreCase("000") && strOrgCode.substring(9, 15).equalsIgnoreCase("000000"))
				{
					strQuery = (SQLParser.getSqlQuery("sel_appworkflowusers1^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"'"));
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_appworkflowusers^"+strAppno+"^"+strAppno+"^'"+strOrgCode+"'");
				}
			}

			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrUsers = new ArrayList();
				arrUsers.add(rs.getString(1));
				arrUsers.add(rs.getString(2));
				arrUsers.add(rs.getString(3));
				strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+rs.getString(3));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrUsers.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
				}
				else{
					arrUsers.add(rs.getString(3));
				}
				arrUsers.add(rs.getString(4));
				arrUsers.add(rs.getString(5));
				arrUserss.add(arrUsers);
			}
			
			hshRecord.put("arrUserss", arrUserss);
			return hshRecord;
		} 
		catch (Exception e) 
		{
			log.error("Error in gettting getWorkUsers.. "+ e);
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
			catch (Exception e1) 
			{
				throw new EJBException("Error closing connection.." + e1);
			}
		}

	}
	
	
	
}