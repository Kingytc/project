package com.sai.laps.ejb.ADV1151;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "ADV1151Bean", mappedName = "ADV1151Home")
@Remote (ADV1151Remote.class)
public class ADV1151Bean extends BeanAdapter {
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ADV1151Bean.class);
	private static final long serialVersionUID = 7878232072700018465L;

	public HashMap getadvBorrowingPower(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strAppno = "", strQuery = "";
		String recordflag = "N";
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_advborrowpower^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("borrpow_activity", correctNull((String) rs
						.getString("borrpow_activity")));
				hshResult.put("borrpow_totalborrowing", correctNull((String) rs
						.getString("borrpow_totalborrowing")));
				hshResult.put("borrpow_resolution", correctNull((String) rs
						.getString("borrpow_resolution")));
				hshResult.put("borrpow_comments", correctNull((String) rs
						.getString("borrpow_comments")));
				hshResult.put("borrpow_sanction", correctNull((String) rs
						.getString("borrpow_sanction")));
				recordflag = "Y";
			}
			hshResult.put("recordflag",recordflag);
			if (rs != null)
				rs.close();

		} catch (Exception exp) {
			throw new EJBException("Error in getadvBorrowingPower"
					+ exp.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in getMonitorCheckList "
								+ exp.toString());
			}
		}
		hshResult.put("appno", strAppno);
		return hshResult;
	}

	public void updateadvBorrowingPower(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "";
		// String strUserId = correctNull((String)hshValues.get("strUserId"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_advborrowpower");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_advborrowpower");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("sel_activity")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_totborrowings")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_resolution")));
				arrValues.add(correctNull((String) hshValues
						.get("text_comments")));
				arrValues.add(correctNull((String) hshValues
						.get("text_sanction")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_advborrowpower");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			//Audit Trial---start
			StringBuilder sbAuditTrial=new StringBuilder();
			String strActivity = "",strTotBelong = "",strResolution = "";
			if(correctNull((String) hshValues.get("sel_activity")).equals("1"))
			{
				strActivity = "Yes";
			} 
			else if(correctNull((String) hshValues.get("sel_activity")).equals("2"))
			{
				strActivity = "No";
			}
			if(correctNull((String) hshValues.get("sel_resolution")).equals("1"))
			{
				strResolution= "Yes";
			}
			else if(correctNull((String) hshValues.get("sel_resolution")).equals("2"))
			{
				strResolution= "No";
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
					sbAuditTrial.append("Whether the activities for which limits are applied for are covered by provisions in the Memorandum of Association =").append(strActivity);
					sbAuditTrial.append("~Whether total borrowings (excluding temporary overdraft not under limit) of the company exceed the total of paidup capital and reserves. =");
					if(correctNull((String) hshValues.get("sel_totborrowings")).equals("1"))
					{
						sbAuditTrial.append("Yes");
						sbAuditTrial.append("~If so, whether the resolution of the general body obtained =");
						sbAuditTrial.append(strResolution);
					}
					else if(correctNull((String) hshValues.get("sel_totborrowings")).equals("2"))
					{
						sbAuditTrial.append("No");
					}
					else
					{
						sbAuditTrial.append("");
					}
			
				if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");
			}
			
			AuditTrial.auditLog(hshValues, "211", strAppno, sbAuditTrial.toString());

			//end
			
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	/*
	 * public void updateCollateralSecurity(HashMap hshValues)throws
	 * EJBException { HashMap hshQuery=null; HashMap hshQueryValues=null;
	 * ResultSet rs=null; ArrayList arrValues=null; String strAppno=""; String
	 * strQuery=""; String strsno="";
	 * strAppno=correctNull((String)hshValues.get("appno")); String
	 * strAction=correctNull((String)hshValues.get("hidAction"));
	 * 
	 * strsno=correctNull((String)hshValues.get("hid_strsno")); String
	 * strdescproperty=correctNull((String)hshValues.get("txt_descproperty"));
	 * String
	 * strpropertyownded=correctNull((String)hshValues.get("txt_propertyownded"));
	 * String
	 * strmarketvalue=correctNull((String)hshValues.get("txt_marketvalue"));
	 * String
	 * strencumbrance=correctNull((String)hshValues.get("txt_encumbrance"));
	 * String
	 * strlegalopinion=correctNull((String)hshValues.get("txt_legalopinion"));
	 * 
	 * 
	 * try { if(strAction.equalsIgnoreCase("insert")) { if(rs!=null) {
	 * rs.close(); } strQuery="sel_maxadvcolsecurities^"+strAppno;
	 * rs=DBUtils.executeLAPSQuery(strQuery); if(rs.next()) {
	 * strsno=correctNull((String)rs.getString("advcol_sno")); } if(rs!=null) {
	 * rs.close(); } hshQuery=new HashMap(); hshQueryValues=new HashMap();
	 * arrValues=new ArrayList();
	 * hshQuery.put("strQueryId","ins_advcolsecurities");
	 * arrValues.add(strAppno); arrValues.add(strsno);
	 * arrValues.add(strdescproperty); arrValues.add(strpropertyownded);
	 * arrValues.add(strmarketvalue); arrValues.add(strencumbrance);
	 * arrValues.add(strlegalopinion);
	 * 
	 * hshQuery.put("arrValues",arrValues); hshQueryValues.put("1",hshQuery);
	 * hshQueryValues.put("size","1");
	 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); }
	 * else if(strAction.equalsIgnoreCase("update")) { hshQuery=new HashMap();
	 * hshQueryValues=new HashMap(); arrValues=new ArrayList();
	 * hshQuery.put("strQueryId","upd_advcolsecurities");
	 * 
	 * arrValues.add(strdescproperty); arrValues.add(strpropertyownded);
	 * arrValues.add(strmarketvalue); arrValues.add(strencumbrance);
	 * arrValues.add(strlegalopinion); arrValues.add(strAppno);
	 * arrValues.add(strsno);
	 * 
	 * hshQuery.put("arrValues",arrValues); hshQueryValues.put("1",hshQuery);
	 * hshQueryValues.put("size","1");
	 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); }
	 * 
	 * else if(strAction.equalsIgnoreCase("delete")) { hshQuery=new HashMap();
	 * hshQueryValues=new HashMap(); arrValues=new ArrayList();
	 * 
	 * arrValues.add(strAppno); arrValues.add(strsno);
	 * hshQuery.put("strQueryId","del_advcolsecurities");
	 * hshQuery.put("arrValues",arrValues); hshQueryValues.put("1",hshQuery);
	 * hshQueryValues.put("size","1");
	 * 
	 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	 *  } }catch(Exception e) { throw new EJBException("Error in
	 * updateCollateralSecurity"+e.getMessage()); } finally { try { if(rs!=null)
	 * rs.close(); }catch(Exception exp) { throw new EJBException("Error in
	 * closing the connection in updateCollateralSecurity "+ exp.toString()); } } }
	 */

	/*
	 * public HashMap getCollateralSecurity(HashMap hshValues)throws
	 * EJBException {
	 * 
	 * ResultSet rs=null; String strQuery; HashMap hshRecord=new HashMap();
	 * ArrayList vecCol = new ArrayList(); ArrayList vecRow = new ArrayList(); String
	 * strAppno=""; strAppno=correctNull((String)hshValues.get("appno"));
	 * 
	 * try { strQuery=SQLParser.getSqlQuery("sel_advcolsecurities^"+strAppno);
	 * rs=DBUtils.executeQuery(strQuery); while(rs.next()) { vecCol = new
	 * ArrayList();
	 * vecCol.add(correctNull((String)rs.getString("advcol_appno")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_sno")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_descproperty")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_propertyownded")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_marketvalue")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_encumbrance")));
	 * vecCol.add(correctNull((String)rs.getString("advcol_legalopinion")));
	 * vecRow.add(vecCol); } if(rs!=null) { rs.close(); }
	 * hshRecord.put("vecRow",vecRow); } catch(Exception e1) { throw new
	 * EJBException(e1.getMessage()); } finally { try { if(rs != null) {
	 * rs.close(); } } catch(Exception cf) { throw new EJBException("Error
	 * closing the connection "+cf.getMessage());
	 *  } } return hshRecord; }
	 */

	public HashMap getLegalheirs(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		// ArrayList arrCol1 = new ArrayList();
		// ArrayList arrRow1 = new ArrayList();
		ResultSet rs = null;
		String strAppno = "";
		// String strsecname="";
		boolean recordflag=false;
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			// String strSno = correctNull((String)hshValues.get("hidsno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			// strsecname=correctNull((String)hshValues.get("txt_security"));
			strQuery = SQLParser.getSqlQuery("sellegalheires^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("lglheirs_sno")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_appno")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_name")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_gender")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_age")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_relationship")));
				arrCol.add(correctNull((String) rs.getString("lglheirs_maritalstate")));
				arrRow.add(arrCol);
				recordflag=true;
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("appno", strAppno);
			hshRecord.put("arrRow", arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		} catch (Exception e1) {
			throw new EJBException("Error in getDocumentRegister :: "+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public void updateLegalheirs(HashMap hshValues)  {
		ResultSet rs = null;

		String strQuery = null;
		String strAppno = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();

		ArrayList arrValues = new ArrayList();

		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));

			strAppno = correctNull((String) hshValues.get("appno"));

			String strtxtname = correctNull((String) hshValues.get("txtname"));
			String strselgender = correctNull((String) hshValues
					.get("sel_gender"));
			String strtxtage = correctNull((String) hshValues.get("txt_age"));
			String strtxtrelation = correctNull((String) hshValues
					.get("txt_relation"));
			String strtxtmaritalstatus = correctNull((String) hshValues
					.get("txt_maritalstatus"));
			String strSno = correctNull((String) hshValues.get("hidsno"));
			StringBuilder sbolddata = new StringBuilder();
			//sel_legalheir_audit_trial
			if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Delete"))
			{
				strQuery=SQLParser.getSqlQuery("sel_legalheir_audit_trial^"+strAppno+"^"+strSno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append(" S.No. = ");
					sbolddata.append(Helper.correctNull((String)rs.getString("LGLHEIRS_SNO")));
					sbolddata.append(" ~Name = ");
					sbolddata.append(Helper.correctNull((String)rs.getString("LGLHEIRS_NAME")));
					sbolddata.append(" ~Gender = ");
					String strAppGender = Helper.correctNull((String)rs.getString("LGLHEIRS_GENDER"));
					if(strAppGender.equalsIgnoreCase("F"))
					{
						strAppGender = "Female";
					}
					else if(strAppGender.equalsIgnoreCase("M"))
					{
						strAppGender = "Male";
					}
					else if(strAppGender.equalsIgnoreCase("O"))
					{
						strAppGender = "Others";
					}
					else
					{
						strAppGender = "";
					}
					sbolddata.append(strAppGender);
					sbolddata.append(" ~Age(in years) = ");
					sbolddata.append(Helper.correctNull((String)rs.getString("LGLHEIRS_AGe")));
					sbolddata.append(" ~Relationship = ");
					sbolddata.append(Helper.correctNull((String)rs.getString("LGLHEIRS_RELATIONSHIP")));
					sbolddata.append(" ~Marital status = ");
					sbolddata.append(Helper.correctNull((String)rs.getString("LGLHEIRS_MARITALSTATE")));
				}
			
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
				strQuery = SQLParser.getSqlQuery("selmaxlegal^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSno = correctNull((String) rs.getString("snorelmax"));
				}
				if (rs != null) {
					rs.close();
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "inslegalheires");

				arrValues.add(strSno);
				arrValues.add(strAppno);
				arrValues.add(strtxtname);
				arrValues.add(strselgender);
				arrValues.add(strtxtage);
				arrValues.add(strtxtrelation);
				arrValues.add(strtxtmaritalstatus);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "updlegalheires");

				arrValues.add(strAppno);
				arrValues.add(strtxtname);
				arrValues.add(strselgender);
				arrValues.add(strtxtage);
				arrValues.add(strtxtrelation);
				arrValues.add(strtxtmaritalstatus);
				arrValues.add(strSno);
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "dellegalheires");
				arrValues.add(strSno);
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}


			StringBuilder sbAuditTrial=new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert"))) {
				sbAuditTrial.append(" S.No. = ");
				sbAuditTrial.append(strSno);
				sbAuditTrial.append(" ~Name = ");
				sbAuditTrial.append(Helper.correctNull((String)hshValues.get("txtname")));
				sbAuditTrial.append(" ~Gender = ");
				String strAppGender = Helper.correctNull((String)hshValues.get("sel_gender"));
				if(strAppGender.equalsIgnoreCase("F"))
				{
					strAppGender = "Female";
				}
				else if(strAppGender.equalsIgnoreCase("M"))
				{
					strAppGender = "Male";
				}
				else if(strAppGender.equalsIgnoreCase("O"))
				{
					strAppGender = "Others";
				}
				else
				{
					strAppGender = "";
				}
				sbAuditTrial.append(strAppGender);
				sbAuditTrial.append(" ~Age(in years) = ");
				sbAuditTrial.append(Helper.correctNull((String)hshValues.get("txt_age")));
				sbAuditTrial.append(" ~Relationship = ");
				sbAuditTrial.append(Helper.correctNull((String)hshValues.get("txt_relation")));
				sbAuditTrial.append(" ~Marital status = ");
				sbAuditTrial.append(Helper.correctNull((String)hshValues.get("txt_maritalstatus")));
			}
			AuditTrial.auditNewLog(hshValues,"191",strAppno,sbAuditTrial.toString(),sbolddata.toString());
		
		} catch (Exception e) {
			throw new EJBException("Error in updateLegalheirs "
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the connection in updateLegalheirs :: "
								+ cf.getMessage());
			}
		}
	}
	

	public HashMap getMeansCapital(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		// HashMap hshRecord=new HashMap();
		// hshValues=new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null;;
		// ArrayList arrRow4=new ArrayList();
		ArrayList arrRow5 = new ArrayList();
		String recordflag = "N";

		String strQuery = "", strAppno = "";
		try {
			strAppno = correctNull((String) hshValues.get("appno"));

			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("selmeanscapital^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("advcap_sanctioncomments",correctNull((String) rs	.getString("advcap_sanctioncomments")));
				hshResult.put("rating", correctNull((String) rs	.getString("rating")));
				hshResult.put("rating_grade", correctNull((String) rs.getString("rating_grade")));
				hshResult.put("rate_check", correctNull((String) rs.getString("adv_ratecheck")));
				recordflag = "Y";
			}
			if (rs != null)
				rs.close();

			// Added by Subha
			ArrayList arrVec5 = null;
			strQuery = SQLParser.getSqlQuery("queryforpromoters_cred^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next()) {
				arrVec5 = new ArrayList();
				String strappid = correctNull(rs1.getString("perapp_id"));
				arrVec5.add(correctNull(rs1.getString("perapp_fname")));

				strQuery = SQLParser.getSqlQuery("gettotoalmeans^" + strappid
						+ "^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					arrVec5.add(correctNull(rs.getString("cr_date")));
					arrVec5.add(correctNull(rs.getString("cr_total_means")));
				} else {
					arrVec5.add("");
					arrVec5.add("");
				}
					arrVec5.add("");
				arrRow5.add(arrVec5);
			}
			hshResult.put("arrRow5", arrRow5);
			if (rs1 != null) {
				rs1.close();
			}
			if (rs2 != null) {
				rs2.close();
			}
			strQuery = SQLParser.getSqlQuery("selcapitalstructure^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("PERAPP_AUTHORISED", correctNull(rs1
						.getString("com_authcapital")));
				hshResult.put("PERAPP_SUBSCRIBED", correctNull(rs1
						.getString("com_subisscapital")));
				hshResult.put("PERAPP_PAIDUP", correctNull(rs1
						.getString("com_paidshares")));
				hshResult.put("PERAPP_RESERVE", correctNull(rs1
						.getString("com_reservecapital")));
			}
			
			hshResult.put("recordflag",recordflag);

		} catch (Exception exp) {
			throw new EJBException("Error in getMeansCapital"
					+ exp.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing in getMeansCapital"
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updateMeansCapital(HashMap hshValues)  {
		ResultSet rs = null;

		// String strQuery=null;
		String strAppno = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();

		ArrayList arrValues = new ArrayList();

		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			// String strUserId =
			// correctNull((String)hshValues.get("strUserId"));

			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}

			String strtxtname = correctNull((String) hshValues
					.get("txt_sanctionuse"));

			if (strAction.equalsIgnoreCase("insert")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delmeanscapital");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insmeanscapital");
				arrValues.add(strAppno);
				arrValues.add(strtxtname);
				arrValues.add(correctNull((String) hshValues.get("rating")));
				arrValues.add(correctNull((String) hshValues.get("rating_grade")));
				arrValues.add(correctNull((String) hshValues.get("sel_rate")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delmeanscapital");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert")) {
				sbAuditTrial.append("Is credit rating applicable? = " );
				if(correctNull((String) hshValues.get("sel_rate")).equals("1"))
				{
					sbAuditTrial.append("Yes" );
				}
				else if(correctNull((String) hshValues.get("sel_rate")).equals("2"))
				{
					sbAuditTrial.append("No" );
				}
				else
				{
					sbAuditTrial.append("");
				}
				
			sbAuditTrial.append("~Rating=").append(
					correctNull((String) hshValues.get("rating"))).append(
					"~Rating Grade=").append(
					correctNull((String) hshValues.get("rating_grade")));
			
			}
			if (Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y")) {
				hshValues.put("hidAction", "update");
			}

			AuditTrial.auditLog(hshValues, "185", strAppno, sbAuditTrial
					.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateMeans " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing in updateMeansCapital"
						+ cf.getMessage());
			}
		}

	}

	public void updateComments(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		// String strQuery="";

		strAppno = correctNull((String) hshValues.get("appno"));
		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strstock = correctNull((String) hshValues.get("sel_stock"));
		String strdetails = correctNull((String) hshValues.get("txt_details"));
		String strpenalinterest = correctNull((String) hshValues
				.get("sel_penalinterest"));
		String strsanctionadvice = correctNull((String) hshValues
				.get("sel_sanctionadvice"));
		String strdetailjust = correctNull((String) hshValues
				.get("txt_detailjust"));
		String strlimitdrawing = correctNull((String) hshValues
				.get("sel_limitdrawing"));
		String strdrawingextent = correctNull((String) hshValues
				.get("txt_drawingextent"));
		String strsanctionoffuse = correctNull((String) hshValues
				.get("txt_sanctionoffuse"));
		String strcashwithdrawl = correctNull((String) hshValues
				.get("sel_cashwithdrawl"));
		String strwithdrwlextent = correctNull((String) hshValues
				.get("txt_withdrwlextent"));
		String strpurposewithdrawl = correctNull((String) hshValues
				.get("sel_purposewithdrawl"));
		String strpurposedetails = correctNull((String) hshValues
				.get("txt_purposedetails"));

		try {
			if (strAction.equalsIgnoreCase("insert")) {

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "del_advcomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_advcomments");
				arrValues.add(strAppno);
				arrValues.add(strstock);
				arrValues.add(strdetails);
				arrValues.add(strpenalinterest);
				arrValues.add(strsanctionadvice);
				arrValues.add(strdetailjust);
				arrValues.add(strlimitdrawing);
				arrValues.add(strdrawingextent);
				arrValues.add(strsanctionoffuse);
				arrValues.add(strcashwithdrawl);
				arrValues.add(strwithdrwlextent);
				arrValues.add(strpurposewithdrawl);
				arrValues.add(strpurposedetails);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();

				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "del_advcomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			StringBuilder sbAt=new StringBuilder();
			if (strAction.equalsIgnoreCase("Insert")) {
			String strCondition = "";
			if (correctNull((String) hshValues.get("sel_stock")).equals("1"))
				strCondition = "YES";
			else if (correctNull((String) hshValues.get("sel_stock")).equals(
					"2"))
				strCondition = "NO";
			else
				strCondition = "<--- Select --->";

			sbAt
					.append(
							"~ Whether Stock/Book Debts/QIS Statement are submitted in time = ")
					.append(strCondition);

			if (correctNull((String) hshValues.get("sel_penalinterest"))
					.equals("1"))
				strCondition = "YES";
			else if (correctNull((String) hshValues.get("sel_penalinterest"))
					.equals("2"))
				strCondition = "NO";
			else
				strCondition = "<--- Select --->";

			sbAt.append("~ Whether Penal interest is charged= ").append(
					strCondition);

			if (correctNull((String) hshValues.get("sel_sanctionadvice"))
					.equals("1"))
				strCondition = "YES";
			else if (correctNull((String) hshValues.get("sel_sanctionadvice"))
					.equals("2"))
				strCondition = "NO";
			else
				strCondition = "<--- Select --->";

			sbAt
					.append(
							"~Whether all stipulations of previous sanction advice have been complied with and the limits utilised accordingly = ")
					.append(strCondition);
			if (correctNull((String) hshValues.get("sel_limitdrawing")).equals(
					"1"))
				strCondition = "YES";
			else if (correctNull((String) hshValues.get("sel_limitdrawing"))
					.equals("2"))
				strCondition = "NO";
			else
				strCondition = "<--- Select --->";

			sbAt.append("~ Are limits or drawing power exceeded ? = ").append(
					strCondition);

			if (correctNull((String) hshValues.get("sel_cashwithdrawl"))
					.equals("1"))
				strCondition = "Frequently";
			else if (correctNull((String) hshValues.get("sel_cashwithdrawl"))
					.equals("2"))
				strCondition = "Never";
			else if (correctNull((String) hshValues.get("sel_cashwithdrawl"))
					.equals("3"))
				strCondition = "Rarely";
			else if (correctNull((String) hshValues.get("sel_cashwithdrawl"))
					.equals("4"))
				strCondition = "No Occasion";

			sbAt.append("~ Whether Cash Withdrawals are frequently made = ")
					.append(strCondition);
			sbAt.append("~ If so, to what extent ?= ").append(
					correctNull((String) hshValues.get("txt_withdrwlextent")));

			if (correctNull((String) hshValues.get("sel_purposewithdrawl"))
					.equals("1"))
				strCondition = "For Payment of Govt. dues";
			else if (correctNull((String) hshValues.get("sel_purposewithdrawl"))
					.equals("2"))
				strCondition = "For disbursement of wages/salaries";
			else if (correctNull((String) hshValues.get("sel_purposewithdrawl"))
					.equals("3"))
				strCondition = "Purchase of raw materials";
			else if (correctNull((String) hshValues.get("sel_purposewithdrawl"))
					.equals("4"))
				strCondition = "Any Other purpose (specify )";
			else
				strCondition = "<--- Select --->";
			sbAt.append("~ Purpose of cash withdrawal = ").append(strCondition)
					.append("~ Amount=").append(
							correctNull((String) hshValues
									.get("txt_purposedetails")));
			}
			if (correctNull((String) hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "Update");

			AuditTrial.auditLog(hshValues, "200",
					correctNull((String) hshValues.get("appno")), sbAt
							.toString());

		} catch (Exception e) {
			throw new EJBException("Error in updateCollateralSecurity"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateCollateralSecurity"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getTermdepoits(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		// String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		// ArrayList arrCol1 = new ArrayList();
		// ArrayList arrRow1 = new ArrayList();
		ResultSet rs = null;
		String strAppno = "";
		// String strsecname="";
		boolean recordflag=false;
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			// String strSno = correctNull((String)hshValues.get("hidsno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			// strsecname=correctNull((String)hshValues.get("txt_security"));
			// strQuery=SQLParser.getSqlQuery("seltermdeposits^"+strAppno);
			// rs=DBUtils.executeQuery(strQuery);
			rs = DBUtils.executeLAPSQuery("seltermdeposits^" + strAppno);
			while (rs.next()) {
				recordflag=true;
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_sno")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_appno")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_date")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_name")));
				arrCol.add(correctNull((String) rs
						.getString("TERMDEPOSITS_AMOUNT")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_maturing")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_encumbered")));
				arrCol.add(correctNull((String) rs
						.getString("termdeposits_explain")));
				arrRow.add(arrCol);
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("appno", strAppno);
			hshRecord.put("arrRow", arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");

		} catch (Exception e1) {
			throw new EJBException("Error in getDocumentRegister :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public void updateADVLiabilities(HashMap hshValues)  {
		String[] limit = null;
		String[] unsecured = null;
		String[] secured = null;
		String[] total = null;
		String[] liabtype = null;
		String option = null;
		HashMap hshQueryValues = null;
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String action = null;
		ResultSet rs = null;
		action = correctNull((String) hshValues.get("hidAction"));
		try {
			limit = ((String[]) hshValues.get("txt_limit"));
			unsecured = ((String[]) hshValues.get("txt_unsec"));
			secured = ((String[]) hshValues.get("txt_sec"));
			total = ((String[]) hshValues.get("txt_total"));
			liabtype = ((String[]) hshValues.get("txt_liabtype"));
			option = correctNull((String) hshValues.get("sel_guarantee"));
			String appno = correctNull((String) hshValues.get("appno"));
			
			StringBuilder strOldAudit = new StringBuilder();
			if(action.equalsIgnoreCase("Delete")||action.equalsIgnoreCase("Update"))
			{
				
				for(int i=0;i<3;i++)
				{
					
				String strQuery = SQLParser.getSqlQuery("sel_advliabilities_audittrial^"+appno+"^"+option+"^"+i);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					if(i==0){
						if(option.equals("1"))
						{
							strOldAudit.append("Liabilities = Guarantees");
						}
						else if(option.equals("2"))
						{
							strOldAudit.append("Liabilities = D.P.Guarantees");
						}
						}
					if(i==0)
					{
						strOldAudit.append("~Inland :^");
					}
					else if(i==1)
					{
						strOldAudit.append("~Foreign :^");
					}
					else if(i==2)
					{
						strOldAudit.append("~Total :^");
					}
					strOldAudit.append("~ Limit = ");
					strOldAudit.append(ApplicationParams.getCurrency() + " "+ Helper.correctNull((String)rs.getString("liab_limit")));
					strOldAudit.append("~ Outstanding Unsecured = ");
					strOldAudit.append(ApplicationParams.getCurrency() + " "+ Helper.correctNull((String)rs.getString("LIAB_UNSECURED")));
					strOldAudit.append("~ Outstanding Secured = ");
					strOldAudit.append(ApplicationParams.getCurrency() + " "+ Helper.correctNull((String)rs.getString("LIAB_SECURED")));
					strOldAudit.append("~ Total = ");
					strOldAudit.append(ApplicationParams.getCurrency() + " "+ Helper.correctNull((String)rs.getString("LIAB_TOTAL")));
				}
				}
				
			}
			if (action.equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_ADV_Liabilities");
				arrValues.add(appno);
				arrValues.add(option);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (action.equals("update")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_ADV_Liabilities");
				arrValues.add(appno);
				arrValues.add(option);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				for (int i = 0; i < limit.length; i++) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_ADV_Liabilities");

					arrValues.add(appno);
					arrValues.add(correctNull(limit[i]));
					arrValues.add(correctNull(unsecured[i]));
					arrValues.add(correctNull(secured[i]));
					arrValues.add(correctNull(total[i]));
					arrValues.add(correctNull(option));
					arrValues.add(correctNull(liabtype[i]));

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

			}
			
			StringBuilder sbAt=new StringBuilder();
			if(action.equalsIgnoreCase("Update"))
			{
			if (option.equals("1"))
				sbAt.append("~ Liabilities =").append("Guarantees");
			if (option.equals("2"))
				sbAt.append("~ Liabilities =").append("D.P.Guarantees");

			sbAt.append(" ~INLAND ^ ");
			sbAt.append("~ Limit = ").append(ApplicationParams.getCurrency() + " "+ correctNull(limit[0]));
			sbAt.append("~ OutStanding UnSecured = ").append(ApplicationParams.getCurrency() + " "+ unsecured[0]);
			sbAt.append("~ OutStanding Secured = ").append(ApplicationParams.getCurrency() + " "+ secured[0]);
			sbAt.append("~ Total = ").append(correctNull(ApplicationParams.getCurrency() + " "+ total[0]));

			sbAt.append("~FOREIGN ^");
			sbAt.append("~ Limit = ").append(correctNull(ApplicationParams.getCurrency() + " "+ limit[1]));
			sbAt.append("~ OutStanding UnSecured = ").append(ApplicationParams.getCurrency() + " "+ unsecured[1]);
			sbAt.append("~ OutStanding Secured = ").append(ApplicationParams.getCurrency() + " "+ secured[1]);
			sbAt.append("~ Total = ").append(correctNull(ApplicationParams.getCurrency() + " "+ total[1]));

			sbAt.append("~TOTAL ^");
			sbAt.append("~ Limit = ").append(correctNull(ApplicationParams.getCurrency() + " "+ limit[2]));
			sbAt.append("~ OutStanding UnSecured = ").append(ApplicationParams.getCurrency() + " "+ unsecured[2]);
			sbAt.append("~ OutStanding Secured = ").append(ApplicationParams.getCurrency() + " "+ secured[2]);
			sbAt.append("~ Total = ").append(correctNull(ApplicationParams.getCurrency() + " "+ total[2]));
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
					hshValues.put("hidAction","Insert");
			AuditTrial.auditNewLog(hshValues, "199",correctNull((String) hshValues.get("appno")), sbAt.toString(),strOldAudit.toString());

		} catch (Exception e) {
			throw new EJBException("Error in updateADVLibilities "
					+ e.getMessage());
		}
	}

	public HashMap getADVLiabilities(HashMap hshValues)  {
		HashMap rethash = null;
		ResultSet rs = null;
		String strQuery = null;
		ArrayList listrow = null;
		ArrayList listcol = null;
		boolean recordflag=false;
		try {
			rethash = new HashMap();
			String appno = correctNull((String) hshValues.get("appno"));
			String selPrint = correctNull((String) hshValues.get("selPrint"));
			String strliaboption = correctNull((String) hshValues
					.get("sel_guarantee"));
			if (!selPrint.equalsIgnoreCase("Get")) {
				strQuery = SQLParser.getSqlQuery("sel_ADV_Liabilities^" + appno
						+ "^" + strliaboption);
				rs = DBUtils.executeQuery(strQuery);

				listrow = new ArrayList();
				while (rs.next()) {
					listcol = new ArrayList();
					recordflag=true;
					listcol
							.add(correctNull((String) rs
									.getString("liab_limit")));
					listcol.add(correctNull((String) rs
							.getString("liab_unsecured")));
					listcol.add(correctNull((String) rs
							.getString("liab_secured")));
					listcol
							.add(correctNull((String) rs
									.getString("liab_total")));
					listcol.add(correctNull((String) rs
							.getString("liab_option")));
					listcol.add(correctNull((String) rs
							.getString("liab_liabtype")));
					listrow.add(listcol);
					rethash.put("liab_option", correctNull((String) rs
							.getString("liab_option")));
				}
				if (rs != null) {
					rs.close();
				}
				rethash.put("Row", listrow);
				rethash.put("appno", appno);
				rethash.put("liab_option", strliaboption);
				// rethash.put("liab_option",appno);
			}

			if (selPrint.equalsIgnoreCase("Get")) {
				strQuery = SQLParser.getSqlQuery("sel_ALLADV_Liabilities^"
						+ appno);
				rs = DBUtils.executeQuery(strQuery);

				listrow = new ArrayList();
				while (rs.next()) {
					listcol = new ArrayList();
					listcol
							.add(correctNull((String) rs
									.getString("liab_limit")));
					listcol.add(correctNull((String) rs
							.getString("liab_unsecured")));
					listcol.add(correctNull((String) rs
							.getString("liab_secured")));
					listcol
							.add(correctNull((String) rs
									.getString("liab_total")));
					listcol.add(correctNull((String) rs
							.getString("liab_option")));
					listcol.add(correctNull((String) rs
							.getString("liab_liabtype")));
					listrow.add(listcol);
					rethash.put("liab_option", correctNull((String) rs
							.getString("liab_option")));
				}
				if (rs != null) {
					rs.close();
				}
				rethash.put("Row", listrow);
				rethash.put("appno", appno);
				rethash.put("liab_option", strliaboption);
				// rethash.put("liab_option",appno);
			}
			if(recordflag)
				rethash.put("recordflag","Y");
			else
				rethash.put("recordflag","N");

		} catch (Exception e) {
			throw new EJBException("Error in getADVLiabilities "
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in getADVLiabilities connection "
								+ cf.getMessage());
			}
		}
		return rethash;
	}

	public HashMap getComments(HashMap hshValues)  {

		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		// ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		strAppno = correctNull((String) hshValues.get("appno"));
		boolean recordflag=false;
		try {
			strQuery = SQLParser.getSqlQuery("sel_advcomments^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				recordflag=true;
				hshRecord.put("advcom_appno", correctNull((String) rs
						.getString("advcom_appno")));
				hshRecord.put("advcom_stock", correctNull((String) rs
						.getString("advcom_stock")));
				hshRecord.put("advcom_details", correctNull((String) rs
						.getString("advcom_details")));
				hshRecord.put("advcom_penalinterest", correctNull((String) rs
						.getString("advcom_penalinterest")));
				hshRecord.put("advcom_sanctionadvice", correctNull((String) rs
						.getString("advcom_sanctionadvice")));
				hshRecord.put("advcom_detailjust", correctNull((String) rs
						.getString("advcom_detailjust")));
				hshRecord.put("advcom_limitdrawing", correctNull((String) rs
						.getString("advcom_limitdrawing")));
				hshRecord.put("advcom_drawingextent", correctNull((String) rs
						.getString("advcom_drawingextent")));
				hshRecord.put("advcom_sanctionoffuse", correctNull((String) rs
						.getString("advcom_sanctionoffuse")));
				hshRecord.put("advcom_cashwithdrawl", correctNull((String) rs
						.getString("advcom_cashwithdrawl")));
				hshRecord.put("advcom_withdrwlextent", correctNull((String) rs
						.getString("advcom_withdrwlextent")));
				hshRecord.put("advcom_purposewithdrawl",
						correctNull((String) rs
								.getString("advcom_purposewithdrawl")));
				hshRecord.put("advcom_purposedetails", correctNull((String) rs
						.getString("advcom_purposedetails")));
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("vecRow", vecRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		} catch (Exception e1) {
			throw new EJBException(e1.getMessage());
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

	public void updateconnectedaccts(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";// ,strmodule_type="";

		strAppno = correctNull((String) hshValues.get("appno"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		strsno = correctNull((String) hshValues.get("hid_strsno"));

		String strname = correctNull((String) hshValues.get("txt_name"));
		String strbranch = correctNull((String) hshValues.get("txt_branch"));
		String strlimit = correctNull((String) hshValues.get("txt_limit"));
		String stramount = correctNull((String) hshValues.get("txt_amount"));
		String strbalance = correctNull((String) hshValues.get("txt_bal"));
		String strotherdeposits = correctNull((String) hshValues
				.get("txt_otherdep"));

		try {
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete"))
			{
				strQuery = SQLParser.getSqlQuery("sel_connectedacct_audittrial^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("S.No = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADVCONN_SNO")));
					strOldAudit.append("~Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADVCONN_NAME")));
					strOldAudit.append("~Branch = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADVCONN_BRANCH")));
					strOldAudit.append("~Limit = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADVCONN_LIMIT")));
					strOldAudit.append("~Amount = ");
					strOldAudit.append(ApplicationParams.getCurrency()+" "+Helper.correctNull((String)rs.getString("ADVCONN_AMOUNT")));
					strOldAudit.append("~Bal in CD A/C = ");
					strOldAudit.append(ApplicationParams.getCurrency()+" "+Helper.correctNull((String)rs.getString("ADVCONN_BAL")));
				}
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxconectedaccts^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("advconn_sno"));
				}
				if (rs != null) {
					rs.close();
				}
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insconnectedaccts");

				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strname);
				arrValues.add(strbranch);
				arrValues.add(strlimit);
				arrValues.add(stramount);
				arrValues.add(strbalance);
				arrValues.add(strotherdeposits);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updconnectedaccts");

				arrValues.add(strname);
				arrValues.add(strbranch);
				arrValues.add(strlimit);
				arrValues.add(stramount);
				arrValues.add(strbalance);
				arrValues.add(strotherdeposits);

				arrValues.add(strAppno);
				arrValues.add(strsno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();

				arrValues.add(strAppno);
				arrValues.add(strsno);

				hshQuery.put("strQueryId", "delconnectedaccts");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Insert"))
			{
				strNewAudit.append("S.No = ");
				strNewAudit.append(strsno);
				strNewAudit.append("~Name = ");
				strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_name")));
				strNewAudit.append("~Branch = ");
				strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_branch")));
				strNewAudit.append("~Limit = ");
				strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_limit")));
				strNewAudit.append("~Amount = ");
				strNewAudit.append(ApplicationParams.getCurrency()+" "+Helper.correctNull((String)hshValues.get("txt_amount")));
				strNewAudit.append("~Bal in CD A/C = ");
				strNewAudit.append(ApplicationParams.getCurrency()+" "+Helper.correctNull((String)hshValues.get("txt_bal")));
			}
			AuditTrial.auditNewLog(hshValues, "196", strAppno, strNewAudit.toString(),strOldAudit.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateConnectedAccounts"+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateConnectedAccounts"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getconnectedaccts(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		boolean recordflag=false; 
		strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = correctNull((String) hshValues.get("hidAppno"));
		}
		try {

			strQuery = SQLParser.getSqlQuery("selconnectedaccts^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				recordflag=true;
				vecCol = new ArrayList();
				vecCol.add(correctNull((String) rs
						.getString("advconn_sno")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_name")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_branch")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_limit")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_amount")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_bal")));
				vecCol.add(correctNull((String) rs
						.getString("advconn_otherdep")));
				vecRow.add(vecCol);
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("vecRow", vecRow);

		} catch (Exception exp) {
			throw new EJBException(exp.getMessage());
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

	public void updateTermdepoits(HashMap hshValues)  {
		ResultSet rs = null;

		String strQuery = null;
		String strAppno = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();

		ArrayList arrValues = new ArrayList();

		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}

			String strdepositsdate = correctNull((String) hshValues
					.get("deposit_date"));
			String strtxtname = correctNull((String) hshValues.get("txt_name"));
			String stramount = correctNull((String) hshValues.get("txt_amount"));
			String strmaturitydate = correctNull((String) hshValues
					.get("maturing_date"));
			String strtxtencumbered = correctNull((String) hshValues
					.get("sel_encumbered"));
			String strtextcomments = correctNull((String) hshValues
					.get("text_comments"));

			String strSno = correctNull((String) hshValues.get("hidsno"));
			//Audit trial
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete"))
			{
				strQuery= SQLParser.getSqlQuery("sel_termdeposits_audittrial^"+strAppno+"^"+strSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAudit.append("~Date = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("TERMDEPOSITS_DATE")));
					strOldAudit.append("~Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("TERMDEPOSITS_NAME")));
					strOldAudit.append("~Amount  = ");
					strOldAudit.append(ApplicationParams.getCurrency() + " "+Helper.correctNull((String)rs.getString("TERMDEPOSITS_AMOUNT")));
					strOldAudit.append("~Maturing On = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("TERMDEPOSITS_MATURING")));
					strOldAudit.append("~Encumbered = ");
					String strEncumbered = Helper.correctNull((String)rs.getString("TERMDEPOSITS_ENCUMBERED"));
					if(strEncumbered.equals("1"))
					{
						strEncumbered = "Yes";
					}
					else if(strEncumbered.equals("2"))
					{
						strEncumbered = "No";
					}
					else
					{
						strEncumbered = "No";
					}
					strOldAudit.append(strEncumbered);
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
				strQuery = "selmaxtermdeposits";
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strSno = correctNull((String) rs.getString("snorelmax"));
				}
				if (rs != null) {
					rs.close();
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "instermdeposits");

				arrValues.add(strSno);
				arrValues.add(strAppno);
				arrValues.add(strdepositsdate);
				arrValues.add(strtxtname);
				arrValues.add(stramount);
				arrValues.add(strmaturitydate);
				arrValues.add(strtxtencumbered);
				arrValues.add(strtextcomments);
				// arrValues.add(strUserId);
				// arrValues.add(Helper.getCurrentDateTime());

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "updtermdeposits");

				arrValues.add(strAppno);
				arrValues.add(strdepositsdate);
				arrValues.add(strtxtname);
				arrValues.add(stramount);
				arrValues.add(strmaturitydate);
				arrValues.add(strtxtencumbered);
				arrValues.add(strtextcomments);
				arrValues.add(strSno);
				// arrValues.add(strUserId);
				// arrValues.add(Helper.getCurrentDateTime());
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("Delete")) {
				// arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "deltermdeposits");
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Insert"))
			{
				strNewAudit.append("~Date = ");
				strNewAudit.append(strdepositsdate);
				strNewAudit.append("~Name = ");
				strNewAudit.append(strtxtname);
				strNewAudit.append("~Amount  = ");
				strNewAudit.append(ApplicationParams.getCurrency() + " "+stramount);
				strNewAudit.append("~Maturing On = ");
				strNewAudit.append(strmaturitydate);
				strNewAudit.append("~Encumbered = ");
				String strEncumbered = strtxtencumbered;
				if(strEncumbered.equals("1"))
				{
					strEncumbered = "Yes";
				}
				else if(strEncumbered.equals("2"))
				{
					strEncumbered = "No";
				}
				else
				{
					strEncumbered = "No";
				}
				strNewAudit.append(strEncumbered);
			}
			AuditTrial.auditNewLog(hshValues, "195", strAppno, strNewAudit.toString(),strOldAudit.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateDocumentRegister "
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateDocumentRegister the connection "
								+ cf.getMessage());
			}
		}
	}

	public HashMap getTurnover(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		// ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();

		ArrayList vecRow1 = new ArrayList();
		// ArrayList vecRow2=new ArrayList();
		boolean recordflag=false; 
		String strQuery = "";
		String strAppno = "";
		boolean bstate = true;
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		// ArrayList vecData2 = new ArrayList();

		strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = correctNull((String) hshValues.get("appno"));
		}

		hshResult.put("appno", strAppno);

		try {

			strQuery = SQLParser.getSqlQuery("selturnover^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);

			int size = 0;
			bstate = rs.next();
			if (bstate == true) {
				size = rs.getFetchSize();

				do {
					vecRow = new ArrayList();

					vecRow1 = new ArrayList();

					if (correctNull(
							(String) rs.getString("ADV_particularcramt"))
							.equalsIgnoreCase("")) {
						vecRow.add("0.00");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("ADV_particularcramt")));
					}

					if (correctNull(
							(String) rs.getString("ADV_particulardramt"))
							.equalsIgnoreCase("")) {
						vecRow.add("0.00");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("ADV_particulardramt")));
					}

					vecData.add(vecRow);
					// /

					if (correctNull((String) rs.getString("ADV_monthcramt"))
							.equalsIgnoreCase("")) {
						vecRow1.add("0.00");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("ADV_monthcramt")));
					}

					vecRow1.add(correctNull((String) rs
							.getString("ADV_monthcrdays")));

					if (correctNull((String) rs.getString("ADV_monthdramt"))
							.equalsIgnoreCase("")) {
						vecRow1.add("0.00");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("ADV_monthdramt")));
					}
					vecRow1.add(correctNull((String) rs
							.getString("ADV_monthdrdays")));

					vecData1.add(vecRow1);
					size++;

				} while (rs.next());

			}

			if (vecData == null || vecData.size() == 0) {
				for (int i = 0; i < 5; i++) {
					ArrayList vecDat = new ArrayList();
					vecDat.add("0.00");
					vecDat.add("0.00");
					vecData.add(vecDat);
				}

			}

			if (vecData1 == null || vecData1.size() == 0) {
				for (int i = 0; i < 12; i++) {
					ArrayList vecDat1 = new ArrayList();
					vecDat1.add("0.00");
					vecDat1.add("0.00");
					vecDat1.add("0.00");
					vecDat1.add("0.00");
					vecData1.add(vecDat1);
				}
			}

			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selturnover^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				recordflag=true;
				hshResult.put("ADV_turnoverfrom", correctNull((String) rs
						.getString("ADV_turnoverfrom")));
				hshResult.put("ADV_turnoverto", correctNull((String) rs
						.getString("ADV_turnoverto")));
				hshResult.put("ADV_sanction", correctNull((String) rs
						.getString("ADV_sanction")));
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
			if (rs != null)
				rs.close();

		} catch (Exception exp) {

			throw new EJBException("Error in getmonitoring" + exp.getMessage());

		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}
		hshResult.put("appno", strAppno);
		hshResult.put("vecData", vecData);
		hshResult.put("vecData1", vecData1);
		return hshResult;
	}

	public void updateTurnover(HashMap hshRequestValues)  {

		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		ResultSet rs = null;
		String strAppno = "";

		// String strUserId =
		// correctNull((String)hshRequestValues.get("strUserId"));
		String strAction = correctNull((String) hshRequestValues
				.get("hidAction"));

		strAppno = correctNull((String) hshRequestValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = correctNull((String) hshRequestValues.get("appno"));
		}

		// String strappno
		// =correctNull((String)hshRequestValues.get("adv_accno"));

		String[] particularcramt = null;
		String[] particulardramt = null;

		String[] monthcramt = null;
		String[] monthcrdays = null;
		String[] monthdramt = null;
		String[] monthdrdays = null;

		String strturnoverfrom = "";
		String strturnoverto = "";
		String strsanction = "";

		int intUpdatesize = 0;
		try {
			particularcramt = (String[]) hshRequestValues.get("txtCredit_amt");
			particulardramt = (String[]) hshRequestValues.get("txtDebit_amt");

			monthcramt = (String[]) hshRequestValues.get("txt_Cramt");
			monthcrdays = (String[]) hshRequestValues.get("txt_Crdays");
			monthdramt = (String[]) hshRequestValues.get("txt_Dramt");
			monthdrdays = (String[]) hshRequestValues.get("txt_Drdays");

			strturnoverfrom = correctNull((String) hshRequestValues
					.get("txt_overfrom"));
			strturnoverto = correctNull((String) hshRequestValues
					.get("txt_overto"));
			strsanction = correctNull((String) hshRequestValues
					.get("text_sanction"));

			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "delturnover");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				intUpdatesize = 1;

				for (int i = 0; i < 12; i++) {
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "insturnover");

					arrValues.add(strAppno);
					arrValues.add(strturnoverfrom);
					arrValues.add(strturnoverto);

					if (i < 5) {
						if (particularcramt[i].equalsIgnoreCase("")
								|| particularcramt[i].equalsIgnoreCase("NaN")) {
							particularcramt[i] = "0.00";
						}
						arrValues.add(particularcramt[i]);
						if (particulardramt[i].equalsIgnoreCase("")
								|| particulardramt[i].equalsIgnoreCase("NaN")) {
							particulardramt[i] = "0.00";
						}
						arrValues.add(particulardramt[i]);
					} else {
						arrValues.add("0.00");
						arrValues.add("0");
					}

					if (monthcramt[i].equalsIgnoreCase("")
							|| monthcramt[i].equalsIgnoreCase("NaN")) {
						monthcramt[i] = "0.00";
					}
					arrValues.add(monthcramt[i]);
					if (monthcrdays[i].equalsIgnoreCase("")
							|| monthcrdays[i].equalsIgnoreCase("NaN")) {
						monthcrdays[i] = "0.00";
					}
					arrValues.add(monthcrdays[i]);
					if (monthdramt[i].equalsIgnoreCase("")
							|| monthdramt[i].equalsIgnoreCase("NaN")) {
						monthdramt[i] = "0.00";
					}
					arrValues.add(monthdramt[i]);
					if (monthdrdays[i].equalsIgnoreCase("")
							|| monthdrdays[i].equalsIgnoreCase("NaN")) {
						monthdrdays[i] = "0.00";
					}
					arrValues.add(monthdrdays[i]);
					arrValues.add(strsanction);

					// //

					hshQuery.put("strturnoverfrom", strturnoverfrom);
					hshQuery.put("strturnoverto", strturnoverto);
					hshQuery.put("strsanction", strsanction);

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

				}
			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "delturnover");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert")) {
			String strparticulars[] = { "Turn Over", "Minimum Balance",
					"Average Balance", "Maximum Balance",
					"No of Days Account was showing Balance" };
			sbAuditTrial.append("").append("").append("~Turn Over:From =")
					.append(
							Helper.correctNull((String) hshRequestValues
									.get("txt_overfrom"))).append("~To =")
					.append(
							Helper.correctNull((String) hshRequestValues
									.get("txt_overto")));
			for (int i = 0; i < 5; i++) {
				if (i == 0) {
					sbAuditTrial.append("~Credit Balance^");
				}
				sbAuditTrial.append("~").append(strparticulars[i]).append("=")
						.append(particularcramt[i]);
			}
			for (int i = 0; i < 5; i++) {
				if (i == 0) {
					sbAuditTrial.append("~Debit Balance^");
				}
				sbAuditTrial.append("~").append(strparticulars[i]).append("=")
						.append(particulardramt[i]);
			}

			int j = 0;
			sbAuditTrial
					.append("~Balance Maintained during last 12 months Rs. in lacs^");
			for (int i = 0; i < 12; i = i + 2) {
				j++;
				sbAuditTrial.append("~").append(Helper.getMonths(j)).append(
						"-Credit").append("^").append("~Amount =").append(
						monthcramt[i]).append("~Days =").append(monthcrdays[i])
						.append("~").append(Helper.getMonths(j)).append(
								"-Debit").append("^").append("~Amount =")
						.append(monthdramt[i]).append("~Days =").append(
								monthdrdays[i]);
			}

			for (int i = 1; i < 12; i = i + 2) {
				j++;
				sbAuditTrial.append("~").append(Helper.getMonths(j)).append(
						"-Credit").append("^").append("~Amount =").append(
						monthcramt[i]).append("~Days =").append(monthcrdays[i])
						.append("~").append(Helper.getMonths(j)).append(
								"-Debit").append("^").append("~Amount =")
						.append(monthdramt[i]).append("~Days =").append(
								monthdrdays[i]);

			}
		}
			if (Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y")) {
				hshRequestValues.put("hidAction", "Update");
			}
			AuditTrial.auditLog(hshRequestValues, "193", strAppno, sbAuditTrial
					.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());

			}
		}

	}

	/*
	 * public void updateADVMarketBorrowing(HashMap hshValues) throws
	 * EJBException { HashMap hshQueryValues = null; HashMap hshQuery = null;
	 * ArrayList arrValues = null; String action = null; String extent = null;
	 * String nature = null; String sanction = null; String appno = null;
	 * 
	 * try { action = correctNull((String)hshValues.get("hidAction")); extent =
	 * correctNull((String)hshValues.get("txt_marketborrow")); nature =
	 * correctNull((String)hshValues.get("area_nature")); sanction =
	 * correctNull((String)hshValues.get("area_sanction")); appno =
	 * correctNull((String)hshValues.get("appno"));
	 * 
	 * if(action.equals("delete")) { hshQueryValues = new HashMap(); hshQuery =
	 * new HashMap(); arrValues=new ArrayList();
	 * hshQuery.put("strQueryId","del_adv_marketborrowing");
	 * arrValues.add(appno); hshQuery.put("arrValues",arrValues);
	 * hshQueryValues.put("1",hshQuery); hshQueryValues.put("size","1");
	 * EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); }
	 * if(action.equals("update")) { hshQueryValues = new HashMap(); hshQuery =
	 * new HashMap(); arrValues=new ArrayList(); hshQuery.put("strQueryId",
	 * "del_adv_marketborrowing"); arrValues.add(appno);
	 * hshQuery.put("arrValues", arrValues); hshQueryValues.put("1", hshQuery);
	 * hshQuery = new HashMap(); arrValues=new ArrayList();
	 * arrValues.add(appno); arrValues.add(extent); arrValues.add(nature);
	 * arrValues.add(sanction); hshQuery.put("arrValues", arrValues);
	 * hshQuery.put("strQueryId", "ins_adv_marketborrowing");
	 * hshQueryValues.put("size", "2"); hshQueryValues.put("2", hshQuery);
	 * EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); } }
	 * catch(Exception e) { throw new EJBException("Error in
	 * updateADVMarketBorrowing "+e.getMessage()); }
	 *  }
	 */

	/*
	 * public HashMap getADVMarketBorrowing(HashMap hshValues) throws
	 * EJBException { HashMap rethash = null; ResultSet rs = null; String
	 * strQuery = null; try { rethash = new HashMap(); String
	 * appno=correctNull((String)hshValues.get("appno"));
	 * 
	 * strQuery=SQLParser.getSqlQuery("sel_adv_marketborrowing^"+appno);
	 * rs=DBUtils.executeQuery(strQuery);
	 * 
	 * 
	 * if(rs.next()) {
	 * 
	 * rethash.put("extent",correctNull((String)rs.getString("mb_marketborrow")));
	 * rethash.put("nature",correctNull((String)rs.getString("mb_nature")));
	 * rethash.put("sanction",correctNull((String)rs.getString("mb_Sanction")));
	 *  } if(rs != null) { rs.close(); } rethash.put("appno",appno);
	 *  } catch(Exception e) { throw new EJBException("Error in
	 * getADVMarketBorrowing "+e.getMessage()); } finally { try { if(rs != null) {
	 * rs.close(); } } catch(Exception cf) { throw new EJBException("Error
	 * closing in getADVMarketBorrowing connection "+cf.getMessage()); } }
	 * return rethash;
	 *  }
	 */

	public void updateADVDocument(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = null;
		String strQuery = null;
		ResultSet rs = null;

		try {
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			String strsno = correctNull((String) hshValues.get("rowno"));
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String appno = correctNull((String) hshValues.get("appno"));
			StringBuilder sbAt=new StringBuilder();
			StringBuilder stroldAudit = new StringBuilder();
			if (!strAction.equalsIgnoreCase("new")) {
			strQuery = SQLParser.getSqlQuery("sel_adv_document_ind^" + appno+"^"+strsno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_adv_document^" + appno);
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			stroldAudit.append("~ Nature of limit =").append(
					correctNull((String) rs.getString("doc_naturelimit")));
			stroldAudit.append("~ Documents Obtained Name=").append(
					correctNull((String) rs.getString("doc_name")));
			stroldAudit.append("~ Documents Obtained Amount=").append(
					nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("doc_amount")))));
			stroldAudit.append("~ Documents Obtained  Date=").append(
					correctNull((String) rs.getString("doc_date")));
			}
			
			if (strAction.equalsIgnoreCase("new")) {
				strsno = "";
				strQuery = SQLParser.getSqlQuery("sel_max_slno_advdoc");
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {
					strsno = correctNull((String) rs.getString("slno"));
				}
				if (rs != null) {
					rs.close();
				}
				if (strsno.equalsIgnoreCase("")) {
					strsno = "0";
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery.put("strQueryId", "ins_adv_document");
				arrValues.add(strsno);
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues
						.get("txt_naturelimit")));
				arrValues.add(correctNull((String) hshValues.get("txt_name")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_date")));
				arrValues
						.add(correctNull((String) hshValues.get("area_remark")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				// AUDIT TRIAL...

				sbAt.append("~ Nature of limit =").append(
						correctNull((String) hshValues.get("txt_naturelimit")));
				sbAt.append("~ Documents Obtained Name=").append(
						correctNull((String) hshValues.get("txt_name")));
				sbAt.append("~ Documents Obtained Amount=").append(
						correctNull((String) hshValues.get("txt_amount")));
				sbAt.append("~ Documents Obtained  Date=").append(
						correctNull((String) hshValues.get("txt_date")));
				


			}

			if (strAction.equalsIgnoreCase("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_adv_document");
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_adv_document");
				arrValues.add(strsno);
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues
						.get("txt_naturelimit")));
				arrValues.add(correctNull((String) hshValues.get("txt_name")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_date")));
				arrValues
						.add(correctNull((String) hshValues.get("area_remark")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				// AUDIT TRIAL...
			

				sbAt.append("~ Nature of limit =").append(
						correctNull((String) hshValues.get("txt_naturelimit")));
				sbAt.append("~ Documents Obtained Name=").append(
						correctNull((String) hshValues.get("txt_name")));
				sbAt.append("~ Documents Obtained Amount=").append(
						correctNull((String) hshValues.get("txt_amount")));
				sbAt.append("~ Documents Obtained  Date=").append(
						correctNull((String) hshValues.get("txt_date")));

			}

			if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_adv_document");
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			
			if (correctNull((String) hshValues.get("hidAction")).equals("new"))
			{
				hshValues.put("hidAction", "insert");
			AuditTrial.auditLog(hshValues, "201",
					correctNull((String) hshValues.get("appno")), sbAt
							.toString());
			}
			else
			{
			AuditTrial.auditNewLog(hshValues, "201", appno, sbAt.toString(), stroldAudit.toString());
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();

		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public HashMap getADVDocument(HashMap hshValues)  {
		HashMap hshResult = null;
		ResultSet rs = null;
		String strQuery = null;
		ArrayList arrayCol = null;
		ArrayList arrayRow = null;
		// String rownumber = null;
		String appno = null;
		boolean recordflag=false;
		try {
			hshResult = new HashMap();
			appno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_adv_document^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			arrayRow = new ArrayList();
			while (rs.next()) {
				recordflag=true;
				arrayCol = new ArrayList();
				arrayCol.add(correctNull((String) rs.getString("slno")));// 0
				arrayCol.add(correctNull((String) rs.getString("doc_appno")));// 1
				arrayCol.add(correctNull((String) rs
						.getString("doc_naturelimit")));// 2
				arrayCol.add(correctNull((String) rs.getString("doc_name")));// 3
				arrayCol.add(correctNull((String) rs.getString("doc_amount")));// 4
				arrayCol.add(correctNull((String) rs.getString("doc_date")));// 5
				arrayCol.add(correctNull((String) rs.getString("doc_remark")));// 6
				arrayRow.add(arrayCol);
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
			if (rs != null) {
				rs.close();
			}
			hshResult.put("arrayRow", arrayRow);
		} catch (Exception e1) {
			throw new EJBException("Error in getADVDocument :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshResult;
	}

	public void updateADVBorrowerExp(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = null;

		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String appno = correctNull((String) hshValues.get("appno"));

			if (strAction.equalsIgnoreCase("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_adv_BorrowerExperience");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_adv_BorrowerExperience");
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues
						.get("area_borrowerexp")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_restriction")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_adv_BorrowerExperience");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception e1) {
			e1.printStackTrace();

		}

	}

	public HashMap getADVBorrowerExp(HashMap hshValues)  {
		HashMap hshResult = null;
		ResultSet rs = null;
		String strQuery = null;
		String appno = null;

		try {
			hshResult = new HashMap();
			appno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_adv_BorrowerExperience^"
					+ appno);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshResult.put("BorrowerExp", correctNull((String) rs
						.getString("Borrower_Exp")));
				hshResult.put("Borrowerrestriction", correctNull((String) rs
						.getString("Borrower_restriction")));
			}
			if (rs != null) {
				rs.close();
			}
			hshResult.put("appno", appno);
		} catch (Exception e1) {
			throw new EJBException("Error in getADVBorrowerExp :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshResult;
	}

//	public void updateAuditObservations(HashMap hshValues)  {
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		String strAudittype = "";
//		String appno = correctNull((String) hshValues.get("appno"));
//		String strAction = correctNull((String) hshValues.get("hidAction"));
//		strAudittype = correctNull((String) hshValues.get("sel_audittype"));
//
//		try {
//			if (strAction.equalsIgnoreCase("insert")) {
//				hshQueryValues = new HashMap();
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(strAudittype);
//				arrValues.add("1");
//				hshQueryValues.put("size", "1");
//				hshQuery.put("strQueryId", "delauditobservation");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
//						"updateData");
//
//				arrValues = new ArrayList();
//				hshQuery = new HashMap();
//				hshQueryValues = new HashMap();
//				arrValues.add(appno);
//				arrValues.add(correctNull((String) hshValues
//						.get("sel_audittype")));
//				arrValues.add(correctNull((String) hshValues
//						.get("txt_auditorsobservations")));
//				arrValues.add(correctNull((String) hshValues
//						.get("txt_branchcomments")));
//				arrValues
//						.add(correctNull((String) hshValues.get("txt_replies")));
//				arrValues.add(correctNull((String) hshValues
//						.get("txt_dateaudited")));
//				arrValues.add("1");
//				hshQueryValues.put("1", hshQuery);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("strQueryId", "insauditobservation");
//				hshQueryValues.put("size", "1");
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
//						"updateData");
//			}
//
//			if (strAction.equalsIgnoreCase("delete")) {
//				hshQueryValues = new HashMap();
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(strAudittype);
//				arrValues.add("1");
//				hshQueryValues.put("size", "1");
//				hshQuery.put("strQueryId", "delauditobservation");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
//						"updateData");
//			}
//		} catch (Exception e) {
//			throw new EJBException("Error in Insert Data " + e.getMessage());
//		}
//	}

//	public HashMap getAuditObservations(HashMap hshValues)  {
//		
//	HashMap hshResult = new HashMap();
//	ResultSet rs = null;
//	ArrayList arrCol = null;
//	ArrayList arrRow = new ArrayList();
//	String strAudittype = "", strQuery = "";
//	String appno = correctNull((String) hshValues.get("appno"));
//	if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase(null)) {
//		appno = correctNull((String) hshValues.get("appno"));
//	}
//
//	String selPrint = correctNull((String) hshValues.get("selPrint"));
//	try {
//		strAudittype = correctNull((String) hshValues.get("sel_audittype"));
//		if (strAudittype.equalsIgnoreCase("")) {
//			strAudittype = "0";
//		}
//
//		if (!selPrint.equalsIgnoreCase("Get")) {
//			strQuery = SQLParser.getSqlQuery("selauditobservation^" + appno
//					+ "^" + strAudittype);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) {
//				hshResult.put("auditorsobservations",
//						correctNull((String) rs
//								.getString("adv_auditorsobservations")));
//				hshResult.put("branchcomments", correctNull((String) rs
//						.getString("adv_branchcomments")));
//				hshResult.put("replies", correctNull((String) rs
//						.getString("adv_replies")));
//				hshResult.put("dateaudited", correctNull((String) rs
//						.getString("adv_dateaudited")));
//			}
//		}
//		if (rs != null) {
//			rs.close();
//		}
//
//		if (selPrint.equalsIgnoreCase("Get")) {
//			strQuery = SQLParser.getSqlQuery("selallauditobservation^"
//					+ appno);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) {
//				arrCol = new ArrayList();
//				// hshResult.put("mon_custid",correctNull((String)rs.getString("mon_custid")));
//				arrCol.add(correctNull((String) rs
//						.getString("adv_audittype")));
//				arrCol.add(correctNull((String) rs
//						.getString("adv_auditorsobservations")));
//				arrCol.add(correctNull((String) rs
//						.getString("adv_branchcomments")));
//				arrCol
//						.add(correctNull((String) rs
//								.getString("adv_replies")));
//				arrCol.add(correctNull((String) rs
//						.getString("adv_dateaudited")));
//				arrRow.add(arrCol);
//			}
//			if (rs != null) {
//				rs.close();
//			}
//
//		}
//		hshResult.put("arrRow", arrRow);
//		hshResult.put("audittype", strAudittype);
//	} catch (Exception exp) {
//		throw new EJBException("Error in getAuditorsObservation :: "
//				+ exp.getMessage());
//	} finally {
//		try {
//			if (rs != null)
//				rs.close();
//		} catch (Exception exp) {
//			throw new EJBException(
//					"Error in closing the connection in getAuditorsInspection :: "
//							+ exp.toString());
//		}
//	}
//
//	return hshResult;
//	}

	public void updateGeneralComments(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strCommenttype = "";
		String appno = correctNull((String) hshValues.get("appno"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		strCommenttype = correctNull((String) hshValues.get("sel_commenttype"));

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strCommenttype);
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_generalcomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues
						.get("sel_commenttype")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_branchcomments")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_sanctionofficecomments")));
				hshQueryValues.put("1", hshQuery);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_generalcomments");
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strCommenttype);
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_generalcomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public HashMap getGeneralComments(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		// ArrayList arrRow=new ArrayList();
		String strCommenttype = "", strQuery = "";
		String appno = correctNull((String) hshValues.get("appno"));
		try {
			strCommenttype = correctNull((String) hshValues
					.get("sel_commenttype"));
			if (strCommenttype.equalsIgnoreCase("")) {
				strCommenttype = "0";
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_generalcomments^" + appno
					+ "^" + strCommenttype);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("branchcomment", correctNull((String) rs
						.getString("adv_branchcomment")));
				hshResult.put("sanctionofficecomment", correctNull((String) rs
						.getString("adv_sanctionofficecomment")));
			}
			if (rs != null) {
				rs.close();
			}
			hshResult.put("commenttype", strCommenttype);
		} catch (Exception exp) {
			throw new EJBException("Error in getGeneral Comments :: "
					+ exp.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in getAuditorsInspection :: "
								+ exp.toString());
			}
		}

		return hshResult;
	}

	public HashMap getGuranteedetails(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null;
		String strAppno = "";
		ArrayList arrRowgua = new ArrayList();
		String recordflag = "N";
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}

			strQuery = SQLParser.getSqlQuery("sel_guranteedetails^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				// hshRecord.put("adv_guaranteeoffered",correctNull(rs.getString("adv_guaranteeoffered")));
				hshRecord.put("adv_guaranteedate", correctNull(rs
						.getString("adv_guaranteedate")));
				hshRecord.put("adv_amount", correctNull(rs
						.getString("adv_amount")));
				hshRecord.put("adv_guarantors", correctNull(rs
						.getString("adv_guarantors")));
				hshRecord.put("adv_sanction", correctNull(rs
						.getString("adv_sanction")));
				hshRecord.put("ADV_GUARANTORSRENEWAL", correctNull(rs
						.getString("ADV_GUARANTORSRENEWAL")));
				recordflag = "Y";
			}
			hshRecord.put("appno", strAppno);

			strQuery = SQLParser.getSqlQuery("queryforgurantor^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				ArrayList arrVecgua = new ArrayList();
				arrVecgua.add(correctNull(rs.getString("perapp_fname")));

				String strId = correctNull(rs.getString("perapp_id"));
				strQuery = SQLParser.getSqlQuery("selcreditreport2^" + strAppno
						+ "^" + strId);
				ResultSet rs1 = null;
				rs1 = DBUtils.executeQuery(strQuery);
				String strMeans = "0.0";
				if (rs1.next()) {
					strMeans = correctNull((String) rs1
							.getString("CR_Total_MEANS"));
				}
				arrVecgua.add(strMeans);
				arrVecgua.add(correctNull(rs.getString("perapp_address1")));
				arrVecgua.add(correctNull(rs.getString("perapp_address2")));
				arrVecgua.add(correctNull(rs.getString("perapp_address3")));
				arrVecgua.add(correctNull(rs.getString("city_name")));
				arrVecgua.add(correctNull(rs.getString("state_name")));
				arrVecgua.add(correctNull(rs.getString("perapp_zip")));
				arrVecgua.add(correctNull(rs.getString("perapp_phone")));
				arrRowgua.add(arrVecgua);
			}
			hshRecord.put("arrRowgua", arrRowgua);
			hshRecord.put("recordflag",recordflag);
			/*
			 * strQuery =
			 * SQLParser.getSqlQuery("selallssiguarantor1^"+strAppno);
			 * if(rs!=null) rs.close(); rs = DBUtils.executeQuery(strQuery);
			 * while(rs.next()) { ArrayList arrVec6 = new ArrayList();
			 * arrVec6.add(correctNull(rs.getString("ssi_guarantor_name")));
			 * arrVec6.add(correctNull(rs.getString("SSI_GUARANTOR_ADDRESS")));
			 * String ssi_guarantor_id =
			 * correctNull((String)rs.getString("ssi_guarantor_id"));
			 * if(rs1!=null) { rs1.close(); } strQuery =
			 * SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+ssi_guarantor_id+"g");
			 * rs1 = DBUtils.executeQuery(strQuery); if(rs1.next()) {
			 * arrVec6.add(correctNull(rs1.getString("CR_Total_MEANS"))); } else {
			 * arrVec6.add("0.00"); } arrRow6.add(arrVec6); }
			 * 
			 * hshRecord.put("arrRow6",arrRow6); if(rs1!=null) { rs1.close(); }
			 * //Corporate Guarantor Only strQuery =
			 * SQLParser.getSqlQuery("compromoterselectionguar1^"+strAppno);
			 * if(rs!=null) { rs.close(); } rs = DBUtils.executeQuery(strQuery);
			 * while(rs.next()) { ArrayList arrVec6 = new ArrayList();
			 * arrVec6.add(correctNull(rs.getString("com_compdtfname")));
			 * arrVec6.add(correctNull(rs.getString("cor_promoteraddress")));
			 * String company_id =
			 * correctNull((String)rs.getString("com_compdtid")); if(rs1!=null) {
			 * rs1.close(); } strQuery =
			 * SQLParser.getSqlQuery("selcreditreport2^"+strAppno+"^"+company_id);
			 * rs1 = DBUtils.executeQuery(strQuery); if(rs1.next()) {
			 * arrVec6.add(correctNull(rs1.getString("CR_Total_MEANS"))); } else {
			 * arrVec6.add("0.00"); } arrRow6.add(arrVec6); }
			 * hshRecord.put("arrRow6",arrRow6); if(rs1!=null) { rs1.close(); }
			 *  // added by subha
			 *  // Added by Subha
			 * 
			 * 
			 * if(rs1!=null) { rs1.close(); }
			 * 
			 * if(rs != null) { rs.close(); } if(rs1 != null) { rs1.close(); }
			 */
		}

		catch (Exception e1) {
			throw new EJBException("Error in getGuranteedetails :: "
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hshRecord;
	}

	public void updateGuranteedetails(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "";
		// String strUserId = correctNull((String)hshValues.get("strUserId"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_guranteedetails");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_guranteedetails");
				arrValues.add(strAppno);
				// arrValues.add(correctNull((String)hshValues.get("txt_restriction")));
				// arrValues.add(correctNull((String)hshValues.get("sel_guarantee")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_guaranteedate")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_amount")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_guarantors")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_sanction")));
				arrValues
						.add(correctNull((String) hshValues.get("sel_renewal")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_guranteedetails");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder strAudit = new StringBuilder();
			if(!strAction.equalsIgnoreCase("Delete"))
			{
				strAudit.append("~Guarantor details");
				strAudit.append("~If renewal = ");
				if(correctNull((String) hshValues.get("sel_renewal")).equals("1"))
				{
					strAudit.append("Yes");
					strAudit.append("~Date of letter of guarantee = ");
					strAudit.append(correctNull((String) hshValues.get("txt_guaranteedate")));
					strAudit.append("~Amount = ");
					strAudit.append(ApplicationParams.getCurrency()+" "+correctNull((String) hshValues.get("txt_amount")));
				}
				else
				{
					strAudit.append("No");
				}
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction","Update");
			AuditTrial.auditLog(hshValues, "213", strAppno, strAudit.toString());
			
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public void updateworkingcapital(HashMap hshRequestValues)
			 {

		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();
		ResultSet rs = null;

		String strAction = correctNull((String) hshRequestValues
				.get("hidAction"));

		String strappno = correctNull((String) hshRequestValues.get("appno"));

		String[] ccpledgelast12month = null;
		String[] ccpledgeprevious12month = null;
		String[] cchyplast12month = null;
		String[] cchypprevious12month = null;

		String[] amount1 = null;
		String[] amount2 = null;
		String[] amount3 = null;
		String[] amount4 = null;

		String[] preamount1 = null;
		String[] predate1 = null;
		String[] preamount2 = null;
		String[] predate2 = null;

		int intUpdatesize = 0;
		try {
			ccpledgelast12month = (String[]) hshRequestValues
					.get("txt_cclast12month");
			ccpledgeprevious12month = (String[]) hshRequestValues
					.get("txt_ccprevious12month");
			cchyplast12month = (String[]) hshRequestValues
					.get("txt_hyplast12month");
			cchypprevious12month = (String[]) hshRequestValues
					.get("txt_hypprevious12month");

			amount1 = (String[]) hshRequestValues.get("txt_pledgeamount1");
			amount2 = (String[]) hshRequestValues.get("txt_pledgeamount2");
			amount3 = (String[]) hshRequestValues.get("txt_hypamount1");
			amount4 = (String[]) hshRequestValues.get("txt_hypamount2");

			preamount1 = (String[]) hshRequestValues.get("txt_amount1");
			predate1 = (String[]) hshRequestValues.get("txt_date1");
			preamount2 = (String[]) hshRequestValues.get("txt_amount2");
			predate2 = (String[]) hshRequestValues.get("txt_date2");

			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "delworkingcapital");
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				intUpdatesize = 1;

				for (int i = 0; i < ccpledgelast12month.length; i++) {
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_workingcapital");

					arrValues.add(strappno);

					if (ccpledgelast12month[i].equalsIgnoreCase("")
							|| ccpledgelast12month[i].equalsIgnoreCase("NaN")) {
						ccpledgelast12month[i] = "0.00";
					}
					arrValues.add(ccpledgelast12month[i]);
					if (ccpledgeprevious12month[i].equalsIgnoreCase("")
							|| ccpledgeprevious12month[i]
									.equalsIgnoreCase("NaN")) {
						ccpledgeprevious12month[i] = "0.00";
					}
					arrValues.add(ccpledgeprevious12month[i]);
					if (cchyplast12month[i].equalsIgnoreCase("")
							|| cchyplast12month[i].equalsIgnoreCase("NaN")) {
						cchyplast12month[i] = "0.00";
					}
					arrValues.add(cchyplast12month[i]);
					if (cchypprevious12month[i].equalsIgnoreCase("")
							|| cchypprevious12month[i].equalsIgnoreCase("NaN")) {
						cchypprevious12month[i] = "0.00";
					}
					arrValues.add(cchypprevious12month[i]);

					if (amount1[i].equalsIgnoreCase("")
							|| amount1[i].equalsIgnoreCase("NaN")) {
						amount1[i] = "0.00";
					}
					arrValues.add(amount1[i]);
					if (amount2[i].equalsIgnoreCase("")
							|| amount2[i].equalsIgnoreCase("NaN")) {
						amount2[i] = "0.00";
					}
					arrValues.add(amount2[i]);
					if (amount3[i].equalsIgnoreCase("")
							|| amount3[i].equalsIgnoreCase("NaN")) {
						amount3[i] = "0.00";
					}
					arrValues.add(amount3[i]);
					if (amount4[i].equalsIgnoreCase("")
							|| amount4[i].equalsIgnoreCase("NaN")) {
						amount4[i] = "0.00";
					}
					arrValues.add(amount4[i]);

					// //
					if (i < 4) {

						if (preamount1[i].equalsIgnoreCase("")
								|| preamount1[i].equalsIgnoreCase("NaN")) {
							preamount1[i] = "0.00";
						}
						arrValues.add(preamount1[i]);
						if (predate1[i].equalsIgnoreCase("")
								|| predate1[i].equalsIgnoreCase("")) {
							predate1[i] = "";
						}
						arrValues.add(predate1[i]);
						if (preamount2[i].equalsIgnoreCase("")
								|| preamount2[i].equalsIgnoreCase("NaN")) {
							preamount2[i] = "0.00";
						}
						arrValues.add(preamount2[i]);
						if (predate2[i].equalsIgnoreCase("")
								|| predate2[i].equalsIgnoreCase("")) {
							predate2[i] = "";
						}
						arrValues.add(predate2[i]);

					} else {
						arrValues.add("0.00");
						arrValues.add("");
						arrValues.add("0.00");
						arrValues.add("");
					}

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

				}
			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "1");
				hshQuery.put("strQueryId", "delworkingcapital");
				arrValues.add(strappno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			String strdesc[] = { "Limit", "TurnOver", "Maximum Debit",
					"Minimum Debit", "No of Days A/C in Debit",
					"Avg Debit Balance(Only of last 12 Months)", "Present O/S",
					"Overdue", "Stocks Last Inspected",
					"Stock Stmt Last received" };
			int k = 0;
			for (int i = 0; i < ccpledgelast12month.length; i++) {
				sbAuditTrial.append("~").append(strdesc[k]).append("^").append(
						"~Cash Credit (Pledge)^").append(
						"~Last 12 Month (Rs.) =")
						.append(ccpledgelast12month[i]).append(
								"~Previous 12 Month (Rs.) =").append(
								ccpledgeprevious12month[i]).append(
								"~Cash Credit (Hyp)^").append(
								"~Last 12 Month (Rs.) =").append(
								cchyplast12month[i]).append(
								"~Previous 12 Month (Rs.) =").append(
								cchypprevious12month[i]);
				k++;
			}

			sbAuditTrial.append("~Cash Credit (Pledge)^").append(
					"~For Jan (Rs.)=").append(amount1[0]).append(
					"~For Feb (Rs.)=").append(amount1[1]).append(
					"~For March (Rs.)=").append(amount1[2]).append(
					"~For April (Rs.)=").append(amount1[3]).append(
					"~For May (Rs.)=").append(amount1[4]).append(
					"~For June (Rs.)=").append(amount1[5])

			.append("~For July (Rs.)=").append(amount2[0]).append(
					"~For Aug (Rs.)=").append(amount2[1]).append(
					"~For Sep (Rs.)=").append(amount2[2]).append(
					"~For Oct (Rs.)=").append(amount2[3]).append(
					"~For Nov (Rs.)=").append(amount2[4]).append(
					"~For Dec (Rs.)=").append(amount2[5])

			.append("~Cash Credit (Hyp)^").append("~For Jan (Rs.)=").append(
					amount3[0]).append("~For Feb (Rs.)=").append(amount3[1])
					.append("~For March (Rs.)=").append(amount3[2]).append(
							"~For April (Rs.)=").append(amount3[3]).append(
							"~For May (Rs.)=").append(amount3[4]).append(
							"~For June (Rs.)=").append(amount3[5])

					.append("~For July (Rs.)=").append(amount4[0]).append(
							"~For Aug (Rs.)=").append(amount4[1]).append(
							"~For Sep (Rs.)=").append(amount4[2]).append(
							"~For Oct (Rs.)=").append(amount4[3]).append(
							"~For Nov (Rs.)=").append(amount4[4]).append(
							"~For Dec (Rs.)=").append(amount4[5]);

			for (int i = 0; i < preamount1.length; i++) {
				sbAuditTrial.append("~").append(strdesc[k]).append("^").append(
						"~Cash Credit (Pledge)^").append(
						"~Amount (Rs.) =").append(preamount1[i]).append(
						"~Date =").append(predate1[i])
						.append("~Cash Credit (Hyp)^").append(
								"~Amount (Rs.) =").append(preamount2[i])
						.append("~Date (Rs.) =").append(
								predate2[i]);
				k++;
			}
			if(Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equals("Y"))
				hshRequestValues.put("hidAction","Update");
			if(Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equals("N"))
				hshRequestValues.put("hidAction","insert");
			AuditTrial.auditLog(hshRequestValues, "197", strappno, sbAuditTrial
					.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());

			}
		}

	}

	public HashMap getworkingcapital(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		// ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();

		ArrayList vecRow1 = new ArrayList();
		ArrayList vecRow2 = new ArrayList();

		// ArrayList arrRow=new ArrayList();
		String strQuery = "";// strSno="",
		boolean bstate = true;
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecData2 = new ArrayList();
		boolean recordflag=false;
		String strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {

			strappno = correctNull((String) hshValues.get("appno"));

		}

		hshResult.put("appno", strappno);

		try {

			strQuery = SQLParser.getSqlQuery("sel_workingcapital^" + strappno);
			rs = DBUtils.executeQuery(strQuery);

			int size = 0;
			bstate = rs.next();
			if (bstate == true) {
				size = rs.getFetchSize();
				recordflag=true;
				do {
					vecRow = new ArrayList();

					vecRow1 = new ArrayList();
					vecRow2 = new ArrayList();

					if (correctNull((String) rs.getString("adv_cclast12month"))
							.equalsIgnoreCase("0.00")) {
						vecRow.add("");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("adv_cclast12month")));
					}

					if (correctNull(
							(String) rs.getString("adv_ccprevious12month"))
							.equalsIgnoreCase("0.00")) {
						vecRow.add("");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("adv_ccprevious12month")));
					}

					if (correctNull((String) rs.getString("adv_hyplast12month"))
							.equalsIgnoreCase("0.00")) {
						vecRow.add("");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("adv_hyplast12month")));
					}

					if (correctNull(
							(String) rs.getString("adv_hypprevious12month"))
							.equalsIgnoreCase("0.00")) {
						vecRow.add("");
					} else {
						vecRow.add(correctNull((String) rs
								.getString("adv_hypprevious12month")));
					}

					vecData.add(vecRow);
					// /

					if (correctNull((String) rs.getString("amount1"))
							.equalsIgnoreCase("0.00")) {
						vecRow1.add("");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("amount1")));
					}

					if (correctNull((String) rs.getString("amount2"))
							.equalsIgnoreCase("0.00")) {
						vecRow1.add("");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("amount2")));
					}

					if (correctNull((String) rs.getString("amount3"))
							.equalsIgnoreCase("0.00")) {
						vecRow1.add("");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("amount3")));
					}

					if (correctNull((String) rs.getString("amount4"))
							.equalsIgnoreCase("0.00")) {
						vecRow1.add("");
					} else {
						vecRow1.add(correctNull((String) rs
								.getString("amount4")));
					}

					vecData1.add(vecRow1);

					// /

					if (correctNull((String) rs.getString("preamount1"))
							.equalsIgnoreCase("0.00")) {
						vecRow2.add("");
					} else {
						vecRow2.add(correctNull((String) rs
								.getString("preamount1")));
					}

					if (correctNull((String) rs.getString("predate1"))
							.equalsIgnoreCase("01/01/1900")) {
						vecRow2.add("");
					} else {
						vecRow2.add(correctNull((String) rs
								.getString("predate1")));
					}

					if (correctNull((String) rs.getString("preamount2"))
							.equalsIgnoreCase("0.00")) {
						vecRow2.add("");
					} else {
						vecRow2.add(correctNull((String) rs
								.getString("preamount2")));
					}

					if (correctNull((String) rs.getString("predate2"))
							.equalsIgnoreCase("01/01/1900")) {
						vecRow2.add("");
					} else {
						vecRow2.add(correctNull((String) rs
								.getString("predate2")));
					}

					vecData2.add(vecRow2);
					size++;

				} while (rs.next());

			}
			if (vecData == null || vecData.size() == 0) {
				for (int i = 0; i < 4; i++) {
					vecData.add("");
				}
			}

			if (vecData1 == null || vecData1.size() == 0) {
				for (int i = 0; i < 4; i++) {
					vecData1.add("");
				}
			}
			if (vecData2 == null || vecData2.size() == 0) {
				for (int i = 0; i < 3; i++) {
					vecData2.add("");
				}
			}

			hshResult.put("vecData", vecData);

			// /
			hshResult.put("vecData1", vecData1);
			hshResult.put("vecData2", vecData2);
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
			if (rs != null)
				rs.close();

		} catch (Exception exp) {

			throw new EJBException("Error in getmonitoring" + exp.getMessage());

		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}

		return hshResult;
	}

	public void updatedishonours(HashMap hshRequestValues)  {
		/*
		 * Modification done by sureshkumar ganapathy on 08112008 for the
		 * tertiary requirements
		 */
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();

		ArrayList arrValues = new ArrayList();

		ResultSet rs = null;

		String strAction = correctNull((String) hshRequestValues
				.get("hidAction"));
		String strappno = correctNull((String) hshRequestValues.get("appno"));

		String[] noofdishonours = null;
		String[] rangeofamt = null;
		String[] reasons = null;
		String[] strDishonortype = null;

		String strhundi = "";
		String strtype = "";
		String strcomments = "";

		strhundi = correctNull((String) hshRequestValues.get("sel_hundi"));
		strtype = correctNull((String) hshRequestValues.get("sel_type"));
		strcomments = correctNull((String) hshRequestValues.get("txt_sanction"));

		int intUpdatesize = 0;
		try {
			noofdishonours = (String[]) hshRequestValues.get("txt_noofdishonours");
			rangeofamt = (String[]) hshRequestValues.get("txt_rangeofamt");
			reasons = (String[]) hshRequestValues.get("txt_reasons");
			strDishonortype = (String[]) hshRequestValues.get("txt_dishonortype");

			if (strAction.equalsIgnoreCase("insert")) {
				/*
				 * For deleting the old values in the table adv_dishonours
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize++;
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_dishonours");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				/*
				 * For deleting the old values in the table adv_borrowonhundi
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize++;
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_borrowhundi");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				/*
				 * For Inserting the new values in the table adv_borrowonhundi
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize++;
				arrValues.add(strappno);
				arrValues.add(strhundi);
				arrValues.add(strtype);
				arrValues.add(strcomments);
				hshQuery.put("strQueryId", "ins_borrowhundi");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				/*
				 * For Inserting the new values in the table adv_dishonours
				 */
				for (int i = 0; i < noofdishonours.length; i++) {
					intUpdatesize++;

					hshQuery = new HashMap();
					arrValues = new ArrayList();

					arrValues.add(strappno);
					arrValues.add(correctNull(strDishonortype[i]));
					arrValues.add(correctNull(noofdishonours[i]));
					arrValues.add(Helper.correctDouble(rangeofamt[i]));
					arrValues.add(correctNull(reasons[i]));

					hshQuery.put("strQueryId", "ins_dishonours");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
				}

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("delete")) {
				/*
				 * For deleting the values in the table adv_dishonours
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize++;
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_dishonours");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				/*
				 * For deleting the values in the table adv_borrowonhundi
				 */
				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdatesize++;
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_borrowhundi");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert")) {
			sbAuditTrial.append("~Does the borrower borrow on Hundi =").append(
					SetupParams.getSetupParams("SAABranch",
							correctNull((String) hshRequestValues
									.get("sel_hundi"))));
			if (correctNull((String) hshRequestValues.get("sel_hundi"))
					.equalsIgnoreCase("1")) {
				sbAuditTrial.append("-").append(
						ApplicantParams.getApplicantParams("adv_dishonours",
								correctNull((String) hshRequestValues
										.get("sel_type")))).append("~");
			}
			sbAuditTrial
					.append(
							"Details of cheques & or acceptances dishonored for lack of funds & Bills purchased returned unpaid during past one year")
					.append("^");
			for (int i = 0; i < noofdishonours.length; i++) {
				sbAuditTrial.append("~").append(
						Helper.correctNull(strDishonortype[i])).append("^")
						.append("~No. of Dishonours =").append(
								Helper.correctNull(noofdishonours[i])).append(
								"~Range of Amount =").append(
								Helper.correctDouble(rangeofamt[i])).append(
								"~Reasons =").append(
								Helper.correctNull(reasons[i]));
			}
			if (Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y")) {
				hshRequestValues.put("hidAction", "update");
			}
			}
			AuditTrial.auditLog(hshRequestValues, "190", strappno, sbAuditTrial
					.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());
			}
		}
	}

	public HashMap getdishonours(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;

		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		boolean recordflag=false;
		String strQuery = "";

		String strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {
			strappno = correctNull((String) hshValues.get("appno"));
		}
		try {
			strQuery = SQLParser.getSqlQuery("sel_borrowhundi^" + strappno);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshResult.put("adv_dishundi", correctNull((String) rs.getString("adv_bohundi")));
				hshResult.put("adv_distype", correctNull((String) rs.getString("adv_bohtype")));
				hshResult.put("adv_discomments", correctNull((String) rs.getString("adv_bohcomments")));
			}

			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("sel_dishonours^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("adv_dishonortype")));
				arrCol.add(correctNull((String) rs.getString("adv_disnoofdis")));
				arrCol.add(correctNull((String) rs.getString("adv_disrangeamt")));
				arrCol.add(correctNull((String) rs.getString("adv_disreasons")));
				arrRow.add(arrCol);
				recordflag=true;
			}
			hshResult.put("arrRow", arrRow);
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		} catch (Exception exp) {
			throw new EJBException("Error in getmonitoring" + exp.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}
		return hshResult;
	}

	public void updatecommentsonstatus(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int intUpdateSize = 0;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strappno = correctNull((String) hshValues.get("appno"));
		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();

				hshQuery = new HashMap();
				arrValues = new ArrayList();

				intUpdateSize++;
				arrValues.add(strappno);

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_commentsonstatus");

				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				intUpdateSize++;
				arrValues.add(strappno);
				arrValues.add(correctNull((String) hshValues.get("sel_bowpayment")));
				arrValues.add(correctNull((String) hshValues.get("sel_local")));
				arrValues.add(correctNull((String) hshValues.get("sel_commit")));
				arrValues.add(correctNull((String) hshValues.get("txt_suppliers")));
				arrValues.add(correctNull((String) hshValues.get("txt_customer")));
				arrValues.add(correctNull((String) hshValues.get("txt_marketborrow")));
				arrValues.add(correctNull((String) hshValues.get("area_nature")));
				arrValues.add(correctNull((String) hshValues.get("area_sanction")));
				arrValues.add(correctNull((String) hshValues.get("status_days")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_commentsonstatus");

				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.equalsIgnoreCase("delete")) 
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();

				intUpdateSize++;
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_commentsonstatus");
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			if (!strAction.equalsIgnoreCase("delete")) {
			sbAuditTrial.append("~Borrower's Payments=").append(ApplicantParams.getApplicantParams("adv_borrpayment",
					correctNull((String) hshValues.get("sel_bowpayment")))).append(
					"~Whether meeting the commitment=").append(
					SetupParams.getSetupParams("SAABranch",
							correctNull((String) hshValues.get("sel_commit"))))
					.append("~Local Practise=").append(
							ApplicantParams.getApplicantParams("adv_local",
									correctNull((String) hshValues.get("sel_local"))));
			if (correctNull((String) hshValues.get("sel_local"))
					.equalsIgnoreCase("2")) {
				sbAuditTrial.append("~No of days=").append(
						correctNull((String) hshValues.get("status_days")));
			}
			sbAuditTrial
					.append("~Extent of Credit available from Suppliers =")
					.append(
							correctNull((String) hshValues.get("txt_suppliers")))
					.append("~Extent of Credit to customer=")
					.append(correctNull((String) hshValues.get("txt_customer")))
					.append("~Extent of Market borrowings=").append(
							correctNull((String) hshValues
									.get("txt_marketborrow")));
			}
			if (Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y")) {
				hshValues.put("hidAction", "update");
			}

			AuditTrial.auditLog(hshValues, "300", strappno, sbAuditTrial.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}
	}

	public HashMap getcommentsonstatus(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		boolean recordflag=false;
		String strappno = correctNull((String) hshValues.get("appno"));
		try {
			strQuery = SQLParser.getSqlQuery("sel_commentsonstatus^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("adv_bowpayment", correctNull((String) rs.getString("adv_bowpayment")));
				hshResult.put("adv_local", correctNull((String) rs.getString("adv_local")));
				hshResult.put("adv_commit", correctNull((String) rs.getString("adv_commit")));
				hshResult.put("adv_suppliers", correctNull((String) rs.getString("adv_suppliers")));
				hshResult.put("adv_customer", correctNull((String) rs.getString("adv_customer")));
				hshResult.put("extent", correctNull((String) rs.getString("adv_extentborrow")));
				hshResult.put("nature", correctNull((String) rs.getString("adv_natureborrow")));
				hshResult.put("sanction", correctNull((String) rs.getString("adv_commtonstatusrep")));
				hshResult.put("adv_status_days", correctNull((String) rs.getString("adv_status_days")));
				recordflag=true;
			}
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		} 
		catch (Exception exp) 
		{
			throw new EJBException("Error in getcommentsonstatus of ADV1151Bean :: "+ exp.getMessage());
		} 
		finally 
		{
			try 
				{
					if (rs != null)
					rs.close();
				} 
				catch (Exception exp) 
				{
					throw new EJBException("Error in closing the connection in getcommentsonstatus of ADV1151Bean ::  "	+ exp.toString());
				}
		}
		return hshResult;
	}

	public void updatetermloancomments(HashMap hshValues)  {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		// String strQuery ="";
		// String strsno="";

		// String strUserId = correctNull((String)hshValues.get("strUserId"));
		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcostofproject = correctNull((String) hshValues
				.get("txt_costofproject"));
		String strfinance = correctNull((String) hshValues.get("txt_finance"));
		String strcoverage = correctNull((String) hshValues.get("txt_coverage"));

		String strappno = correctNull((String) hshValues.get("appno"));

		try {

			if (strAction.equalsIgnoreCase("insert")) {

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strappno);

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_termloancomments");

				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				arrValues.add(strappno);

				arrValues.add(strcostofproject);
				arrValues.add(strfinance);
				arrValues.add(strcoverage);

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_termloancomments");

				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_termloancomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());

			}
		}

	}

	public HashMap gettermloancomments(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		// ArrayList vecCol = new ArrayList();
		// ArrayList vecRow=new ArrayList();
		// ArrayList arrRow=new ArrayList();
		String strQuery = "";// strSno="",
		String strappno = "";

		strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {

			strappno = correctNull((String) hshValues.get("appno"));

		}

		hshResult.put("appno", strappno);

		try {

			strQuery = SQLParser
					.getSqlQuery("sel_termloancomments^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				hshResult.put("adv_costofpro", correctNull((String) rs
						.getString("adv_costofpro")));
				hshResult.put("adv_termfinance", correctNull((String) rs
						.getString("adv_termfinance")));
				hshResult.put("adv_termcoverage", correctNull((String) rs
						.getString("adv_termcoverage")));

			}
			if (rs != null) {
				rs.close();
			}

		} catch (Exception exp) {

			throw new EJBException("Error in getmonitoring" + exp.getMessage());

		} finally {

			try {

				if (rs != null)
					rs.close();
			} catch (Exception exp) {

				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}

		return hshResult;
	}

	public void updateotherbank(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strQuery = "";
		String strsno = "";

		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strbankfinacial = correctNull((String) hshValues
				.get("txt_bankfinacial"));
		String strnature = correctNull((String) hshValues.get("txt_nature"));
		String stramt = correctNull((String) hshValues.get("txt_amt"));
		String strpaidupto = correctNull((String) hshValues.get("sel_paidupto"));
		String strnoofinstal = correctNull((String) hshValues
				.get("txt_noofinstal"));
		String stroverdue = correctNull((String) hshValues.get("txt_overdue"));
		String hidsno = correctNull((String) hshValues.get("hidsno"));

		String strappno = correctNull((String) hshValues.get("appno"));

		try {
			//sel_otherbank_audittrial
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete"))
			{
				strQuery = SQLParser.getSqlQuery("sel_otherbank_audittrial^"+strappno+"^"+hidsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAudit.append("Bank / Financial Institution = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_OTHBANKFIN")));
					strOldAudit.append("~Nature of limit = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_OTHLIMIT")));
					strOldAudit.append("~Amount = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_OTHAMT")));
					strOldAudit.append("~Whether installmenst paid up to date = ");
					String strInstallmentsPaid = Helper.correctNull((String)rs.getString("ADV_OTHPAIDUPTO"));
					if(strInstallmentsPaid.equalsIgnoreCase("1"))
					{
						strInstallmentsPaid = "Yes";
						strOldAudit.append(strInstallmentsPaid);
					}
					else if(strInstallmentsPaid.equalsIgnoreCase("2"))
					{
						strInstallmentsPaid = "No";
						strOldAudit.append(strInstallmentsPaid);
						strOldAudit.append("~No. of Installments = ");
						strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_OTHNOOFINSTAL")));
						strOldAudit.append("~Total amount overdue = ");
						strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_OTHTOTALAMT")));
					}
					else
					{
						strInstallmentsPaid = "";
						strOldAudit.append(strInstallmentsPaid);
					}
				
				}
				
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_maxotherID^" + strappno);
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {
					strsno = correctNull((String) rs.getString("adv_othsno"));
				}
				if (rs != null) {
					rs.close();
				}
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();

				hshQuery.put("strQueryId", "ins_otherbank");
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(strbankfinacial);
				arrValues.add(strnature);
				arrValues.add(stramt);
				arrValues.add(strpaidupto);
				arrValues.add(strnoofinstal);
				arrValues.add(stroverdue);

				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_otherbank");
				arrValues.add(strbankfinacial);
				arrValues.add(strnature);
				arrValues.add(stramt);
				arrValues.add(strpaidupto);
				arrValues.add(strnoofinstal);
				arrValues.add(stroverdue);

				arrValues.add(hidsno);
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(hidsno);
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_otherbank");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			StringBuilder sbAuditTrial=new StringBuilder();

			sbAuditTrial.append("~Bank/Financial Institution =").append(
					strbankfinacial).append("~Nature of limit =").append(
					strnature).append("~Amount =").append(stramt).append(
					"~Whether installments paid up to date =").append(
					SetupParams.getSetupParams("SAABranch", strpaidupto));
			if ((SetupParams.getSetupParams("SAABranch", strpaidupto)
					.equalsIgnoreCase("No"))) {
				sbAuditTrial.append("~No. of installmets =").append(
						strnoofinstal).append("~Total amount overdue =")
						.append(stroverdue);
			}
			//start for new
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Insert"))
			{
					strNewAudit.append("Bank / Financial Institution = ");
					strNewAudit.append(strbankfinacial);
					strNewAudit.append("~Nature of limit = ");
					strNewAudit.append(strnature);
					strNewAudit.append("~Amount = ");
					strNewAudit.append(stramt);
					strNewAudit.append("~Whether installmenst paid up to date = ");
					String strInstallmentsPaid = strpaidupto;
					if(strInstallmentsPaid.equalsIgnoreCase("1"))
					{
						strInstallmentsPaid = "Yes";
						strNewAudit.append(strInstallmentsPaid);
					
					}
					else if(strInstallmentsPaid.equalsIgnoreCase("2"))
					{
						strInstallmentsPaid = "No";
						strNewAudit.append(strInstallmentsPaid);
						strNewAudit.append("~No. of Installments = ");
						strNewAudit.append(strnoofinstal);
						strNewAudit.append("~Total amount overdue = ");
						strNewAudit.append(stroverdue);
					}
					else
					{
						strInstallmentsPaid = "";
						strNewAudit.append(strInstallmentsPaid);
					}
			}
			//end
			AuditTrial.auditNewLog(hshValues, "192", strappno, strNewAudit.toString(),strOldAudit.toString());

		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());

			}
		}

	}

	public HashMap getotherbank(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		// ArrayList arrRow=new ArrayList();
		String strQuery = "";// strSno="",
		String strappno = "";
		boolean recordflag=false;
		strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {

			strappno = correctNull((String) hshValues.get("appno"));

		}

		hshResult.put("appno", strappno);

		try {

			strQuery = SQLParser.getSqlQuery("sel_otherbank^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				recordflag=true;
				vecCol = new ArrayList();

				vecCol.add(correctNull((String) rs
						.getString("adv_othsno")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHBANKFIN")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHLIMIT")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHAMT")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHPAIDUPTO")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHNOOFINSTAL")));
				vecCol.add(correctNull((String) rs
						.getString("ADV_OTHTOTALAMT")));

				vecRow.add(vecCol);

			}
			if (rs != null) {
				rs.close();
			}
			hshResult.put("vecRow", vecRow);
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");

		} catch (Exception exp) {

			throw new EJBException("Error in getmonitoring" + exp.getMessage());

		} finally {

			try {

				if (rs != null)
					rs.close();
			} catch (Exception exp) {

				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}

		return hshResult;
	}

	public void updateworkingcapitalcomments(HashMap hshValues)
			 {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		// String strQuery ="";
		// String strsno="";

		// String strUserId = correctNull((String)hshValues.get("strUserId"));
		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strinventory = correctNull((String) hshValues
				.get("txt_inventory"));
		String strdeviation = correctNull((String) hshValues
				.get("txt_deviation"));
		String strlending = correctNull((String) hshValues.get("txt_lending"));

		String strcomputation = correctNull((String) hshValues
				.get("txt_computation"));
		String strrecommendation = correctNull((String) hshValues
				.get("txt_recommendation"));

		String strappno = correctNull((String) hshValues.get("appno"));

		try {

			if (strAction.equalsIgnoreCase("insert")) {

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strappno);

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_workcapitalcomments");

				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				arrValues.add(strappno);

				arrValues.add(strinventory);
				arrValues.add(strdeviation);
				arrValues.add(strlending);

				arrValues.add(strcomputation);
				arrValues.add(strrecommendation);

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_workcapitalcomments");

				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strappno);

				hshQuery.put("strQueryId", "del_workcapitalcomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
		} catch (Exception e) {
			throw new EJBException("Error in updatemonitoring Statement"
					+ e.getMessage());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in the updatemonitoring Statement connection "
								+ cf.getMessage());

			}
		}

	}

	public HashMap getworkingcapitalcomments(HashMap hshValues)
			 {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		// ArrayList vecCol = new ArrayList();
		// ArrayList vecRow=new ArrayList();
		// ArrayList arrRow=new ArrayList();
		String strQuery = "";// strSno="",
		String strappno = "";

		strappno = correctNull((String) hshValues.get("appno"));

		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {

			strappno = correctNull((String) hshValues.get("appno"));

		}

		hshResult.put("appno", strappno);

		try {

			strQuery = SQLParser.getSqlQuery("sel_workcapitalcomments^"
					+ strappno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				hshResult.put("adv_workinventory", correctNull((String) rs
						.getString("adv_workinventory")));
				hshResult.put("adv_workdeviation", correctNull((String) rs
						.getString("adv_workdeviation")));
				hshResult.put("adv_worklending", correctNull((String) rs
						.getString("adv_worklending")));

				hshResult.put("adv_workcomputation", correctNull((String) rs
						.getString("adv_workcomputation")));
				hshResult.put("adv_workrecommendation", correctNull((String) rs
						.getString("adv_workrecommendation")));

			}

			if (rs != null)
				rs.close();

		} catch (Exception exp) {

			throw new EJBException("Error in getmonitoring" + exp.getMessage());

		} finally {

			try {

				if (rs != null)
					rs.close();
			} catch (Exception exp) {

				throw new EJBException(
						"Error in closing the connection in getmonitoring "
								+ exp.toString());
			}
		}

		return hshResult;
	}

	public void updatePurchaseDetails(HashMap hshValues)  {
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues = new HashMap();

		String strAction = correctNull((String) hshValues.get("hidAction"));
		String appno = correctNull((String) hshValues.get("appno"));
		try {
			String[] strLimit = null;
			String[] strBusiness = null;
			String[] strPresentos = null;
			String[] strOverdue = null;
			String[] strBilltype = null;

			if (strAction.equalsIgnoreCase("insert")) {
				strLimit = (String[]) hshValues.get("txt_limit");
				strBusiness = (String[]) hshValues.get("txt_business");
				strPresentos = (String[]) hshValues.get("txt_presentos");
				strOverdue = (String[]) hshValues.get("txt_overdue");
				strBilltype = (String[]) hshValues.get("hid_billtype");

				String officeuse = (String) hshValues.get("txt_officeuse");

				HashMap hshQuery1 = new HashMap();
				ArrayList arrValues1 = new ArrayList();
				HashMap hshQueryValues1 = new HashMap();
				hshQuery1.put("strQueryId", "del_billpurchase");
				arrValues1.add(appno);
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("1", hshQuery1);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,
						"updateData");

				for (int i = 0; i < strLimit.length; i++) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_billpurchase");
					arrValues.add(appno);
					arrValues.add(correctNull(strLimit[i]));
					arrValues.add(correctNull(strBusiness[i]));
					arrValues.add(correctNull(strPresentos[i]));
					arrValues.add(correctNull(strOverdue[i]));
					arrValues.add(correctNull(strBilltype[i]));
					arrValues.add(String.valueOf(i+1));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_officeuse");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQuery = new HashMap();
				arrValues = new ArrayList();

				hshQuery.put("strQueryId", "ins_officeuse");
				arrValues.add(appno);
				arrValues.add(officeuse);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			if (strAction.equalsIgnoreCase("delete")) {
				HashMap hshQuery1 = new HashMap();
				ArrayList arrValues1 = new ArrayList();
				HashMap hshQueryValues1 = new HashMap();
				// hshQuery1.put("size", "1");
				hshQuery1.put("strQueryId", "del_billpurchase");
				arrValues1.add(appno);
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("1", hshQuery1);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,
						"updateData");

				// hshQuery1.put("size", "1");
				hshQuery1 = new HashMap();
				hshQueryValues1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQuery1.put("strQueryId", "del_officeuse");
				arrValues1.add(appno);
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("1", hshQuery1);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,
						"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("Insert")) {
				
				
			for (int i = 0; i < strLimit.length; i++) {
				log.info(strBilltype[i]);
				sbAuditTrial.append("~").append(correctNull(strBilltype[i]))
						.append("^").append("~Limit =").append(
								correctNull(strLimit[i])).append("~Business =")
						.append(correctNull(strBusiness[i])).append(
								"~Present O/S =").append(
								correctNull(strPresentos[i])).append(
								"~OverDue =")
						.append(correctNull(strOverdue[i]));
			}
			}
			if (Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y")) 
				hshValues.put("hidAction", "Update");
			if (Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N")) 
				hshValues.put("hidAction", "Insert");


			AuditTrial.auditLog(hshValues, "198", appno, sbAuditTrial.toString());

		} catch (Exception e) {
			log.error(e.toString());
		}

	}

	public HashMap getPurchaseDetails(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		// HashMap hshResult=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		// ArrayList arr=new ArrayList();
		String strAppno = "";
		boolean recordflag=false;
		strAppno = correctNull((String) hshValues.get("appno"));

		if (strAppno.equalsIgnoreCase("") || strAppno.equalsIgnoreCase(null)) {

			strAppno = correctNull((String) hshValues.get("appno"));

		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_billpurchase^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				recordflag=true;
				vecCol.add(correctNull((String) rs
						.getString("bill_accountno")));
				vecCol.add(correctNull((String) rs
						.getString("bill_limit")));
				vecCol.add(correctNull((String) rs
						.getString("bill_business")));
				vecCol.add(correctNull((String) rs
						.getString("bill_presentos")));
				vecCol.add(correctNull((String) rs
						.getString("bill_overdue")));
				vecCol.add(correctNull((String) rs
						.getString("bill_type")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_officeuse^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("bill_officeuse", correctNull(rs
						.getString("bill_officeuse")));

			}
			if (rs != null) {
				rs.close();
			}
			log.info("getPurchaseDetails"+hshRecord);
		}

		catch (Exception e) {
			log.error(e.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				log.error(e.toString());
			}
		}
		return hshRecord;
	}

	public HashMap getDepositAccounts(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strappno = correctNull((String) hshValues.get("appno"));
		boolean recordflag=false; 
		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {
			strappno = correctNull((String) hshValues.get("appno"));
		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_depositaccounts^" + strappno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) 
			{
				recordflag=true;
				vecCol = new ArrayList();
				vecCol.add(correctNull((String) rs.getString("sno")));
				vecCol.add(correctNull((String) rs.getString("adv_depositaccountsname")));
				vecCol.add(correctNull((String) rs.getString("adv_depositaccountssbaccountno")));
				vecCol.add(correctNull((String) rs.getString("adv_depositaccountsavgbal")));
				vecCol.add(correctNull((String) rs.getString("adv_depositaccountspresentbal")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e1) {
			log.error(e1.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				log.error(e.toString());
			}
		}
		return hshRecord;
	}

	public void updateDepositAccounts(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = new ArrayList();
		String strQuery = "";
		ResultSet rs = null;
		String strsno = correctNull((String) hshValues.get("hidsno"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strappno = correctNull((String) hshValues.get("appno"));
		if (strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase(null)) {
			strappno = correctNull((String) hshValues.get("appno"));
		}

		try {
			//
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete")){
				strQuery = SQLParser.getSqlQuery("sel_depositaccounts_audittrial^"+strappno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("SNo = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("SNO")));
					strOldAudit.append("~Name = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_DEPOSITACCOUNTSNAME")));
					strOldAudit.append("~S.B a/c No = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_DEPOSITACCOUNTSSBACCOUNTNO")));
					strOldAudit.append("~Avg Bal. maintained for the previous 12 months = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_DEPOSITACCOUNTSAVGBAL")));
					strOldAudit.append("~Present Balance = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("ADV_DEPOSITACCOUNTSPRESENTBAL")));
				}
			}
			if (strAction.equalsIgnoreCase("new")) {

				strsno = "";
				strQuery = SQLParser.getSqlQuery("selmaxdepositaccounts^"
						+ strappno);
				rs = DBUtils.executeQuery(strQuery);

				if (rs.next()) {
					strsno = correctNull((String) rs.getString("sno"));
				}
				if (rs != null) {
					rs.close();
				}

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery.put("strQueryId", "ins_depositaccounts");
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(correctNull((String) hshValues.get("txt_name")));
				arrValues.add(correctNull((String) hshValues.get("txt_sbaccountno")));
				arrValues.add(correctNull((String) hshValues.get("txt_avgbalance")));
				arrValues.add(correctNull((String) hshValues.get("txt_presentbalance")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			if (strAction.equalsIgnoreCase("update")) {
				strsno = correctNull((String) hshValues.get("hidsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_depositaccounts");
				arrValues.add(strappno);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery.put("strQueryId", "ins_depositaccounts");
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(correctNull((String) hshValues.get("txt_name")));
				arrValues.add(correctNull((String) hshValues.get("txt_sbaccountno")));
				arrValues.add(correctNull((String) hshValues.get("txt_avgbalance")));
				arrValues.add(correctNull((String) hshValues.get("txt_presentbalance")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				strsno = correctNull((String) hshValues.get("hidsno"));
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_depositaccounts");
				arrValues.add(strappno);
				arrValues.add(strsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("New")){
			strNewAudit.append("SNo = ");
			strNewAudit.append(strsno);
			strNewAudit.append("~Name = ");
			strNewAudit.append(correctNull((String) hshValues.get("txt_name")));
			strNewAudit.append("~S.B a/c No = ");
			strNewAudit.append(correctNull((String) hshValues.get("txt_sbaccountno")));
			strNewAudit.append("~Avg Bal. maintained for the previous 12 months = ");
			strNewAudit.append(correctNull((String) hshValues.get("txt_avgbalance")));
			strNewAudit.append("~Present Balance = ");
			strNewAudit.append(correctNull((String) hshValues.get("txt_presentbalance")));
			}
			if (strAction.equalsIgnoreCase("New")) {
				hshValues.remove("hidAction");
				hshValues.put("hidAction", "insert");
			} else if (strAction.equalsIgnoreCase("Edit")) {
				hshValues.remove("hidAction");
				hshValues.put("hidAction", "update");
			}

			AuditTrial.auditNewLog(hshValues, "194", strappno, strNewAudit.toString(), strOldAudit.toString());
		} catch (Exception e1) {
			log.error(e1.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing in updateDepositAccounts"
						+ cf.getMessage());
			}
		}

	}

	public HashMap insertData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		String strQuery = "", strValue = "";
		ArrayList arrValues = new ArrayList();
		String sel_divID = "";
		String notes = "";
		String notes2 = "";
		int intUpdatesize = 0;
		String page = "";
		String hidEditMode = correctNull((String) hshValues.get("hidEditMode"));

		try {
			hshQueryValues = new HashMap();
			strValue = correctNull((String) hshValues.get("appno"));
			page = correctNull((String) hshValues.get("pageval"));
			sel_divID = correctNull((String) hshValues.get("sel_divID"));
			notes = correctNull((String) hshValues.get("branch_comments"));
			notes2 = correctNull((String) hshValues.get("sanction_office"));
			if (sel_divID.equalsIgnoreCase("")
					|| sel_divID.equalsIgnoreCase("null")) {
				sel_divID = "0";
			}

			if (hidEditMode.equalsIgnoreCase("U")) {
				rs = null;
				strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^" + strValue
						+ "^" + page + "^" + sel_divID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_del");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					arrValues.add(notes);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_ins");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
				} else {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					arrValues.add(notes);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_ins");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				if (rs != null) {
					rs.close();
				}
			} else if (hidEditMode.equalsIgnoreCase("D")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strValue);
				arrValues.add(page);
				arrValues.add(sel_divID);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "executive_finnotes_del");
				intUpdatesize = intUpdatesize + 1;
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			hshRecord = new HashMap();
			hshRecord = (HashMap) EJBInvoker.executeStateLess("ADV1151",
					hshValues, "getDataFinancials");

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
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

	public HashMap getDataFinancials(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		//ResultSet rs1 = null;
		//ResultSet rs2 = null;
		//ResultSet rs5 = null;
		//ResultSet rs7 = null;
		//ResultSet rs10 = null;
		//ResultSet rs11 = null;
		//ResultSet rs12 = null;
		//ResultSet rs13 = null;

		HashMap hshValues = null;
		String strQuery = "", strValue = "";
		ArrayList arrRec = new ArrayList();
		ArrayList arrVal = new ArrayList();
		//ArrayList vecVal = new ArrayList();
		// ArrayList vecVal1=new ArrayList();
		//ArrayList vecVal2 = new ArrayList();
		// ArrayList vecVal3=new ArrayList();
		//ArrayList vecVal4 = new ArrayList();
		// ArrayList vecVal5=new ArrayList();
		//ArrayList vecVal41 = new ArrayList();
		// ArrayList vecVal51=new ArrayList();
		//ArrayList vecVal6 = new ArrayList();
		//ArrayList vecVal7 = new ArrayList();

		//ArrayList vecrec = new ArrayList();
		//ArrayList vecid = new ArrayList();
		//ArrayList vecdesc = new ArrayList();
		//ArrayList vectype = new ArrayList();
		String sel_divID = "";
		// int str=0;
		try {
			hshValues = new HashMap();
			strValue = correctNull((String) hshRequestValues.get("appno"));
			if (strValue.equalsIgnoreCase("")
					|| strValue.equalsIgnoreCase(null)) {
				strValue = correctNull((String) hshRequestValues.get("appno"));
			}
			String page = correctNull((String) hshRequestValues.get("pageval"));
			sel_divID = correctNull((String) hshRequestValues.get("sel_divID"));
			if (sel_divID.equalsIgnoreCase("")) {
				sel_divID = "0";
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("executive_finnotes_sel^" + strValue + "^"
					+ page + "^" + sel_divID);

			if (rs.next()) {
				hshValues.put("advnotes", correctNull(Helper.CLOBToString(rs
						.getClob("notes"))));
			}

			// -------------- to find the time of review-----------------
			/*
			 * strQuery =
			 * SQLParser.getSqlQuery("executive_finselect1^"+strValue+"^"+sel_divID);
			 * if(rs!=null) rs.close(); rs = DBUtils.executeQuery(strQuery);
			 * while(rs.next()) { str=rs.getInt("cnt"); }
			 */
			// --------------- to find the cma format of the particular
			// applications-------

			if (page.equals("FU")) {

				String cma = "8";

				if (correctNull(
						(String) hshRequestValues.get("hidCategoryType"))
						.equalsIgnoreCase("OPS")
						&& correctNull(
								(String) hshRequestValues.get("hidSSIType"))
								.equalsIgnoreCase("WOADV"))
					cma = ApplicationParams.getTerCMAWOADV();
				else if (correctNull(
						(String) hshRequestValues.get("hidCategoryType"))
						.equalsIgnoreCase("OPS")
						&& correctNull(
								(String) hshRequestValues.get("hidSSIType"))
								.equalsIgnoreCase("WADV"))
					cma = ApplicationParams.getTertiaryCMA();
				hshRequestValues.put("cma", cma);

				hshValues.putAll((HashMap) EJBInvoker.executeStateLess(
						"comformula", hshRequestValues, "GetCashFlowData"));

			} else {
				
				strQuery=SQLParser.getSqlQuery("sel_execfin^"+strValue+"^0^"+page);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrRec = new ArrayList();	
					arrRec.add(correctNull(rs.getString("fin_rowdesc")));
					arrRec.add(correctNull(rs.getString("fin_year1")));
					arrRec.add(correctNull(rs.getString("fin_year2")));
					arrRec.add(correctNull(rs.getString("fin_year3")));
					arrRec.add(correctNull(rs.getString("fin_year4")));
					arrRec.add(correctNull(rs.getString("fin_year5")));
					//arrRec.add(correctNull(rs.getString("fin_year6")));
					arrRec.add(correctNull(rs.getString("fin_rowtype")));
					arrVal.add(arrRec);	
				}
				hshValues.put("arrRow",arrVal);
				
//
//				String cma = "8";
//
//				if (correctNull(
//						(String) hshRequestValues.get("hidCategoryType"))
//						.equalsIgnoreCase("OPS")
//						&& correctNull(
//								(String) hshRequestValues.get("hidSSIType"))
//								.equalsIgnoreCase("WOADV"))
//					cma = ApplicationParams.getTerCMAWOADV();
//				else if (correctNull(
//						(String) hshRequestValues.get("hidCategoryType"))
//						.equalsIgnoreCase("OPS")
//						&& correctNull(
//								(String) hshRequestValues.get("hidSSIType"))
//								.equalsIgnoreCase("WADV"))
//					cma = ApplicationParams.getTertiaryCMA();
//				String strDate = "";
//				String strYear = "";
//				String strYear1 = "";
//				String moncurryear = "";
//				int monthcurryear = 0;
//
//				strQuery = SQLParser.getSqlQuery("sel_financial_baseyear^"
//						+ strValue);
//				rs = DBUtils.executeQuery(strQuery);
//				if (rs.next()) {
//					strDate = Helper.correctNull((String) rs
//							.getString("base_year"));
//					strYear = Helper.correctNull((String) rs.getString("year"));
//					strYear1 = Helper
//							.correctNull((String) rs.getString("year"));
//				}
//				/*
//				 * strQuery = SQLParser.getSqlQuery("selmon_curyear");
//				 * if(rs12!=null) rs12.close();
//				 * rs12=DBUtils.executeQuery(strQuery); if(rs12.next()) {
//				 * moncurryear=rs12.getString("mon_curryear"); }
//				 * monthcurryear=Integer.parseInt(moncurryear);
//				 * 
//				 * if (monthcurryear>3) { strQuery =
//				 * SQLParser.getSqlQuery("noteassessselect5"); if(rs7!=null)
//				 * rs7.close();
//				 * 
//				 * rs7=DBUtils.executeQuery(strQuery); if(rs7.next()) {
//				 * strDate=rs7.getString("dat"); String
//				 * val=strDate.substring(6,10); int
//				 * valcon=Integer.parseInt(val)+1; val=Integer.toString(valcon);
//				 * //strDate=val1.concat(val); strYear=rs7.getString("txtyear");
//				 * strYear1=rs7.getString("txtyear"); }
//				 *  }
//				 * 
//				 * else { strQuery = SQLParser.getSqlQuery("noteassessselect5");
//				 * if(rs7!=null) rs7.close();
//				 * rs7=DBUtils.executeQuery(strQuery); if(rs7.next()) {
//				 * strDate=rs7.getString("dat");
//				 * strYear=rs7.getString("txtyear");
//				 * strYear1=rs7.getString("txtyear"); }
//				 *  }
//				 */
//				if (!strDate.equals("")) {
//					strQuery = SQLParser.getSqlQuery("executive_finselect9^"
//							+ strValue + "^" + sel_divID + "^" + strDate);
//					if (rs5 != null)
//						rs5.close();
//					rs5 = DBUtils.executeQuery(strQuery);
//
//					String strDesc = "";
//					String strCurDate = "";
//					if (rs5.next()) {
//						if (rs5.getDouble("sumaudit") > 0) {
//							strDesc = "a";
//						} else if (rs5.getDouble("sumunaudit") > 0) {
//							strDesc = "u";
//						} else if (rs5.getDouble("sumestimated") > 0) {
//							strDesc = "e";
//						} else if (rs5.getDouble("sumprojection") > 0) {
//							strDesc = "p";
//						}
//						strCurDate = rs5.getString("fin_year");
//
//					}
//					strQuery = SQLParser.getSqlQuery("noteassessselect10^"
//							+ strValue + "^" + sel_divID);
//					if (rs10 != null)
//						rs10.close();
//					rs10 = DBUtils.executeQuery(strQuery);
//
//					while (rs10.next()) {
//						arr = new ArrayList();
//						arr.add(rs10.getString(1));
//						arrVal.add(arr);
//					}
//
//					int checkYear = 0;
//					int count = 0;
//					String strPrevDesc = "";
//					String strPrevDate = "";
//					String strPrevDesc1 = "";
//					String strPrevDate1 = "";
//					checkYear = Integer.parseInt(Helper.correctInt(strYear));
//					for (int x = 1; x <= arrVal.size(); x++) {
//						count = count + 1;
//						if (count > 2)
//							break;
//
//						checkYear = checkYear - 1;
//
//						strQuery = SQLParser
//								.getSqlQuery("executive_finselect11^"
//										+ strValue + "^" + sel_divID + "^"
//										+ checkYear);
//						if (rs11 != null)
//							rs11.close();
//						rs11 = DBUtils.executeQuery(strQuery);
//						if (rs11.next()) {
//							if (rs11.getDouble("sumaudit") > 0) {
//								strPrevDesc = "a";
//							} else if (rs11.getDouble("sumunaudit") > 0) {
//								strPrevDesc = "u";
//							} else if (rs11.getDouble("sumestimated") > 0) {
//								strPrevDesc = "e";
//							} else if (rs11.getDouble("sumprojection") > 0) {
//								strPrevDesc = "p";
//							}
//							strPrevDate = rs11.getString("fin_year");
//
//						} else {
//							strPrevDate = "";
//							strPrevDesc = "";
//						}
//						if (!strPrevDesc.trim().equals("")
//								&& strPrevDate1.trim().equals("")) {
//							strPrevDate1 = strPrevDate;
//							strPrevDesc1 = strPrevDesc;
//						}
//						// break;
//					}
//
//					int chkYear = 0;
//					String strNextDesc = "";
//					String strNextDate = "";
//					String strNextDesc2 = "";
//					String strNextDate2 = "";
//					chkYear = Integer.parseInt(Helper.correctInt(strYear1));
//
//					for (int y = 1; y <= 2; y++) {
//						chkYear = chkYear + 1;
//						strQuery = SQLParser
//								.getSqlQuery("executive_finselect11^"
//										+ strValue + "^" + sel_divID + "^"
//										+ chkYear);
//						if (rs12 != null)
//							rs12.close();
//						rs12 = DBUtils.executeQuery(strQuery);
//						if (rs12.next()) {
//							if (rs12.getDouble("sumaudit") > 0) {
//								strNextDesc = "a";
//							} else if (rs12.getDouble("sumunaudit") > 0) {
//								strNextDesc = "u";
//							} else if (rs12.getDouble("sumestimated") > 0) {
//								strNextDesc = "e";
//							} else if (rs12.getDouble("sumprojection") > 0) {
//								strNextDesc = "p";
//							}
//							strNextDate = rs12.getString("fin_year");
//
//						} else {
//							strNextDate = "";
//							strNextDesc = "";
//						}
//						if (!strNextDesc.trim().equals("")
//								&& strNextDate2.trim().equals("")) {
//							strNextDate2 = strNextDate;
//							strNextDesc2 = strNextDesc;
//						}
//
//					}
//
//					strQuery = SQLParser.getSqlQuery("noteassessselect1^" + cma
//							+ "^" + page);
//
//					if (rs2 != null)
//						rs2.close();
//					rs2 = DBUtils.executeQuery(strQuery);
//					String strRowtype = "";
//					// String strRowid="";
//					int strRowformula = 0;
//					int strRowformula2 = 0;
//					vecVal = new ArrayList();
//					// vecVal1 = new ArrayList();
//					vecVal2 = new ArrayList();
//					// vecVal3 = new ArrayList();
//					vecVal4 = new ArrayList();
//					// vecVal5 = new ArrayList();
//					vecVal41 = new ArrayList();
//					// vecVal51 = new ArrayList();
//					vecVal6 = new ArrayList();
//					vecVal7 = new ArrayList();
//					vecid = new ArrayList();
//					vecdesc = new ArrayList();
//					vectype = new ArrayList();
//					while (rs2.next()) {
//						strRowtype = correctNull(rs2.getString("fin_rowtype"));
//						// strRowid=correctNull(rs2.getString("fin_rowid"));
//						strRowformula = rs2.getInt("fin_formula");
//						strRowformula2 = rs2.getInt("fin_formula2");
//						vectype.add(strRowtype);
//
//						String strX = "";
//
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula > 0
//								&& !strDesc.trim().equals("")) {
//							HashMap hshformula = new HashMap();
//							hshformula.put("appno", strValue);
//							hshformula.put("sel_divID", sel_divID);
//							hshformula.put("formulaid", Integer
//									.toString(strRowformula));
//							hshformula.put("curryear", strCurDate);
//							hshformula.put("prevyear", "");
//							hshformula.put("currfinancialtype", strDesc);
//							hshformula.put("prevfinancialtype", "");
//							HashMap hshRes = (HashMap) EJBInvoker
//									.executeStateLess("comformula", hshformula,
//											"GetFinValue");
//							strX = correctNull((String) hshRes
//									.get("strTotalValue"));
//							vecVal.add(strX);
//							vecid.add(correctNull(rs2
//									.getString("fin_rowid")));
//							vecdesc.add(correctNull(rs2
//									.getString("fin_rowdesc")));
//
//						}// if IC
//
//						else {
//							vecVal.add("0.00");
//							vecid.add(correctNull(rs2
//									.getString("fin_rowid")));
//							vecdesc.add(correctNull(rs2
//									.getString("fin_rowdesc")));
//						}
//
//						/*
//						 * String strY=""; if ((strRowtype.trim().equals("FO") ||
//						 * strRowtype.trim().equals("C"))&& strRowformula2>0 &&
//						 * !strDesc.trim().equals("")) {
//						 * 
//						 * HashMap hshformula1 = new HashMap();
//						 * hshformula1.put("appno",strValue);
//						 * hshformula1.put("sel_divID",sel_divID);
//						 * hshformula1.put("formulaid",Integer.toString(strRowformula2));
//						 * hshformula1.put("curryear",strCurDate);
//						 * hshformula1.put("prevyear","");
//						 * hshformula1.put("currfinancialtype",strDesc);
//						 * hshformula1.put("prevfinancialtype",""); HashMap
//						 * hshRes1 =
//						 * (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
//						 * strY =
//						 * correctNull((String)hshRes1.get("strTotalValue"));
//						 * vecVal1.add(strY); } else {
//						 * vecVal1.add("0.00"); }
//						 */
//						// for prev year
//						String strZ = "";
//
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula > 0
//								&& !strPrevDesc.trim().equals("")) {
//
//							HashMap hshformula = new HashMap();
//							hshformula.put("appno", strValue);
//							hshformula.put("sel_divID", sel_divID);
//							hshformula.put("formulaid", Integer
//									.toString(strRowformula));
//							hshformula.put("curryear", strPrevDate);
//							hshformula.put("prevyear", "");
//							hshformula.put("currfinancialtype", strPrevDesc);
//							hshformula.put("prevfinancialtype", "");
//							HashMap hshRes2 = (HashMap) EJBInvoker
//									.executeStateLess("comformula", hshformula,
//											"GetFinValue");
//							strZ = correctNull((String) hshRes2
//									.get("strTotalValue"));
//							vecVal2.add(strZ);
//						}// if IC
//
//						else {
//							vecVal2.add("0.00");
//						}
//
//						/*
//						 * String strA=""; if ((strRowtype.trim().equals("FO")||
//						 * strRowtype.trim().equals("C")) && strRowformula2>0 &&
//						 * !strPrevDesc.trim().equals("")) {
//						 * 
//						 * HashMap hshformula1 = new HashMap();
//						 * hshformula1.put("appno",strValue);
//						 * hshformula1.put("sel_divID",sel_divID);
//						 * hshformula1.put("formulaid",Integer.toString(strRowformula2));
//						 * hshformula1.put("curryear",strPrevDate);
//						 * hshformula1.put("prevyear","");
//						 * hshformula1.put("currfinancialtype",strPrevDesc);
//						 * hshformula1.put("prevfinancialtype",""); HashMap
//						 * hshRes3 =
//						 * (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
//						 * strA =
//						 * correctNull((String)hshRes3.get("strTotalValue"));
//						 * vecVal3.add(strA); } else {
//						 * vecVal3.add("0.00"); }
//						 */
//						// for prev2 year
//						String strZ1 = "";
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula > 0
//								&& !strPrevDesc1.trim().equals("")) {
//							HashMap hshformula = new HashMap();
//							hshformula.put("appno", strValue);
//							hshformula.put("sel_divID", sel_divID);
//							hshformula.put("formulaid", Integer
//									.toString(strRowformula));
//							hshformula.put("curryear", strPrevDate1);
//							hshformula.put("prevyear", "");
//							hshformula.put("currfinancialtype", strPrevDesc1);
//							hshformula.put("prevfinancialtype", "");
//							HashMap hshRes2 = (HashMap) EJBInvoker
//									.executeStateLess("comformula", hshformula,
//											"GetFinValue");
//							strZ1 = correctNull((String) hshRes2
//									.get("strTotalValue"));
//							vecVal6.add(strZ1);
//						}// if IC
//
//						else {
//							vecVal6.add("0.00");
//
//						}
//
//						String strA1 = "";
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula2 > 0
//								&& !strPrevDesc1.trim().equals("")) {
//
//							HashMap hshformula1 = new HashMap();
//							hshformula1.put("appno", strValue);
//							hshformula1.put("sel_divID", sel_divID);
//							hshformula1.put("formulaid", Integer
//									.toString(strRowformula2));
//							hshformula1.put("curryear", strPrevDate1);
//							hshformula1.put("prevyear", "");
//							hshformula1.put("currfinancialtype", strPrevDesc1);
//							hshformula1.put("prevfinancialtype", "");
//							HashMap hshRes3a = (HashMap) EJBInvoker
//									.executeStateLess("comformula",
//											hshformula1, "GetFinValue");
//							strA1 = correctNull((String) hshRes3a
//									.get("strTotalValue"));
//							vecVal7.add(strA1);
//						} else {
//							vecVal7.add("0.00");
//						}
//
//						// for next year
//
//						String strB1 = "0.00";
//
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula > 0
//								&& !strNextDesc.trim().equals("")) {
//
//							HashMap hshformula = new HashMap();
//							hshformula.put("appno", strValue);
//							hshformula.put("sel_divID", sel_divID);
//							hshformula.put("formulaid", Integer
//									.toString(strRowformula));
//							hshformula.put("curryear", strNextDate);
//							hshformula.put("prevyear", "");
//							hshformula.put("currfinancialtype", strNextDesc);
//							hshformula.put("prevfinancialtype", "");
//							HashMap hshRes4 = (HashMap) EJBInvoker
//									.executeStateLess("comformula", hshformula,
//											"GetFinValue");
//							strB1 = correctNull((String) hshRes4
//									.get("strTotalValue"));
//							vecVal4.add(strB1);
//						}// if IC
//
//						else {
//							vecVal4.add("0.00");
//
//						}
//						/*
//						 * String strT1 = "0.00";
//						 * 
//						 * if ((strRowtype.trim().equals("FO") ||
//						 * strRowtype.trim().equals("C"))&& strRowformula2>0 &&
//						 * !strNextDesc.trim().equals("")) {
//						 * 
//						 * HashMap hshformula1 = new HashMap();
//						 * hshformula1.put("appno",strValue);
//						 * hshformula1.put("sel_divID",sel_divID);
//						 * hshformula1.put("formulaid",Integer.toString(strRowformula2));
//						 * hshformula1.put("curryear",strNextDate);
//						 * hshformula1.put("prevyear","");
//						 * hshformula1.put("currfinancialtype",strNextDesc);
//						 * hshformula1.put("prevfinancialtype",""); HashMap
//						 * hshRes5 =
//						 * (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
//						 * strT1=correctNull((String)hshRes5.get("strTotalValue"));
//						 * vecVal5.add(strT1); } else {
//						 * vecVal5.add("0.00"); }
//						 */
//
//						// for next year
//						String strB2 = "0.00";
//
//						if ((strRowtype.trim().equals("FO") || strRowtype
//								.trim().equals("C"))
//								&& strRowformula > 0
//								&& !strNextDesc2.trim().equals("")) {
//
//							HashMap hshformula = new HashMap();
//							hshformula.put("appno", strValue);
//							hshformula.put("sel_divID", sel_divID);
//							hshformula.put("formulaid", Integer
//									.toString(strRowformula));
//							hshformula.put("curryear", strNextDate2);
//							hshformula.put("prevyear", "");
//							hshformula.put("currfinancialtype", strNextDesc2);
//							hshformula.put("prevfinancialtype", "");
//							HashMap hshRes4 = (HashMap) EJBInvoker
//									.executeStateLess("comformula", hshformula,
//											"GetFinValue");
//							strB2 = correctNull((String) hshRes4
//									.get("strTotalValue"));
//							vecVal41.add(strB2);
//						}// if IC
//
//						else {
//							vecVal41.add("0.00");
//
//						}
//						/*
//						 * String strT2 = "0.00";
//						 * 
//						 * if ((strRowtype.trim().equals("FO") ||
//						 * strRowtype.trim().equals("C"))&& strRowformula2>0 &&
//						 * !strNextDesc2.trim().equals("")) {
//						 * 
//						 * HashMap hshformula1 = new HashMap();
//						 * hshformula1.put("appno",strValue);
//						 * hshformula1.put("sel_divID",sel_divID);
//						 * hshformula1.put("formulaid",Integer.toString(strRowformula2));
//						 * hshformula1.put("curryear",strNextDate2);
//						 * hshformula1.put("prevyear","");
//						 * hshformula1.put("currfinancialtype",strNextDesc2);
//						 * hshformula1.put("prevfinancialtype",""); HashMap
//						 * hshRes5 =
//						 * (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
//						 * strT2=correctNull((String)hshRes5.get("strTotalValue"));
//						 * vecVal51.add(strT2); } else {
//						 * vecVal51.add("0.00"); }
//						 */
//					}
//					// while rs2
//
//					hshValues.put("year", vecVal);
//					// hshValues.put("yearhold",vecVal1);
//					hshValues.put("prevyear", vecVal2);
//					// hshValues.put("prevyearhold",vecVal3);
//					hshValues.put("nextyear2", vecVal4);
//					// hshValues.put("nextyearhold2",vecVal5);
//					hshValues.put("nextyear", vecVal41);
//					// hshValues.put("nextyearhold",vecVal51);
//					// hshValues.put("prevyear1",vecVal5);
//					hshValues.put("prevyearhold1", vecVal6);
//					hshValues.put("vecid", vecid);
//					hshValues.put("vecdesc", vecdesc);
//					hshValues.put("vectype", vectype);
//					hshValues.put("sel_divID", sel_divID);
//
//					if (!strCurDate.trim().equals("")) {
//						vecrec.add(strCurDate);
//					}
//
//					else {
//						// strDate=strDate.substring(6,10);
//						vecrec.add("");
//					}
//					vecrec.add(strDesc);
//					vecrec.add(strPrevDate);
//					vecrec.add(strPrevDesc);
//					vecrec.add(strNextDate2);
//					vecrec.add(strNextDesc2);
//					vecrec.add(strPrevDate1);
//					vecrec.add(strPrevDesc1);
//					vecrec.add(strNextDate);
//					vecrec.add(strNextDesc);
//				}
//				hshValues.put("yearvalue", vecrec);
//				 // old one
//
//				hshValues.put("appno", strValue);
//
				
				hshValues.put("page", page);
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				/*if (rs1 != null)
					rs1.close();
				if (rs2 != null)
					rs2.close();
				if (rs5 != null)
					rs5.close();
				if (rs7 != null)
					rs7.close();
				if (rs10 != null)
					rs10.close();
				if (rs11 != null)
					rs11.close();
				if (rs12 != null)
					rs12.close();
				if (rs13 != null)
					rs13.close();*/

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;
	}

	public HashMap getADVPrint(HashMap hshRecord)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String strQuery = null;
		String strAppno = null;
		String strOrgCode = null;
		String strComappid = null;
		// String orgcode=correctNull((String) hshRecord.get("strOrgCode"));
		String comapp_region_code = "", comapp_zone_code = "", comapp_corp_code = "", cityregval = "";
		String cityregvalue = "", stateregvalue = "", statereg_value = "", flag = "";
		String strappname = "";
		String strconstitution = "";
		// ArrayList arrDircol=new ArrayList();
		// ArrayList arrnonfundedcol=new ArrayList();
		ArrayList OurBank_TL = new ArrayList();
		HashMap hsh1 = new HashMap();
		HashMap hsh2 = new HashMap();
		HashMap hsh3 = new HashMap();
		HashMap hsh4 = new HashMap();
		HashMap hsh5 = new HashMap();
		// HashMap hsh6=new HashMap();
		// HashMap hsh7=new HashMap();
		HashMap hsh8 = new HashMap();
		HashMap hsh9 = new HashMap();
		HashMap hsh10 = new HashMap();
		HashMap hsh11 = new HashMap();
		HashMap hsh12 = new HashMap();
		HashMap hsh13 = new HashMap();
		HashMap hsh14 = new HashMap();
		HashMap hsh15 = new HashMap();
		HashMap hsh16 = new HashMap();
		HashMap hsh17 = new HashMap();
		HashMap hsh18 = new HashMap();
		// HashMap hsh19=new HashMap();
		HashMap hsh20 = new HashMap();
		HashMap hsh21 = new HashMap();
		//HashMap hsh22 = new HashMap();
		HashMap hsh23 = new HashMap();
		HashMap hsh24 = new HashMap();
		HashMap hsh25 = new HashMap();

		ArrayList arrRow = new ArrayList();
		strAppno = correctNull((String) hshRecord.get("appno"));

		strAppno = correctNull((String) hshRecord.get("appno"));
		if (strAppno.equalsIgnoreCase("") || strAppno.equalsIgnoreCase(null)) {

			strAppno = correctNull((String) hshRecord.get("appno"));

		}
		// hshValues.put("appno",strValue);

		strOrgCode = correctNull((String) hshRecord.get("strOrgCode"));
		//strComappid = correctNull((String) hshRecord.get("comappid"));

		// int intGroup =0;
		try {
			strQuery = SQLParser.getSqlQuery("setorgselect^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshResult.put("RespectiveBranch", correctNull((String) rs
						.getString("org_name")));
			}
			if (rs != null)
				rs.close();
			int code = strOrgCode.length();
			if (code == 15) {

				strOrgCode = strOrgCode.substring(0, 9);
				comapp_region_code = strOrgCode + "000000";
				strOrgCode = strOrgCode.substring(0, 6);
				comapp_zone_code = strOrgCode + "000000000";
				strOrgCode = strOrgCode.substring(0, 3);
				comapp_corp_code = strOrgCode + "000000000000";
			}

			strQuery = SQLParser.getSqlQuery("setorgselect^"
					+ comapp_region_code);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshResult.put("RespectiveRegion", correctNull((String) rs
						.getString("org_name")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser
					.getSqlQuery("setorgselect^" + comapp_zone_code);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("RespectiveZone", correctNull((String) rs
						.getString("org_name")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser
					.getSqlQuery("setorgselect^" + comapp_corp_code);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("RespectiveCorporate", correctNull((String) rs
						.getString("org_name")));
			}
			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("comfunsel4^" + strAppno + "^N");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strComappid = correctNull(rs.getString("demo_appid"));
				strappname = correctNull(rs.getString("app_name"));
			}
			hshResult.put("strappname", strappname);

			strQuery = SQLParser.getSqlQuery("mastgetdemographics^"
					+ strComappid);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {

				hshResult.put("perapp_address1", correctNull(rs
						.getString("perapp_address1")));
				hshResult.put("perapp_address2", correctNull(rs
						.getString("perapp_address2")));
				hshResult.put("perapp_city", correctNull(rs
						.getString("perapp_city")));
				hshResult.put("perapp_state", correctNull(rs
						.getString("perapp_state")));
				hshResult.put("perapp_zip", correctNull(rs
						.getString("perapp_zip")));
				cityregval = correctNull(rs.getString("perapp_city"));
				strconstitution = correctNull(rs
						.getString("perapp_constitution"));
				hshResult.put("perapp_dob", correctNull(rs
						.getString("perapp_dob")));
				hshResult.put("perapp_banksince", correctNull(rs
						.getString("perapp_banksince")));
				hshResult.put("perapp_cin", correctNull(rs
						.getString("perapp_cin")));
			}
			if (rs != null)
				rs.close();
			if (!cityregval.equalsIgnoreCase("")) {
				strQuery = SQLParser.getSqlQuery("selcitycode^" + cityregval);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					cityregvalue = correctNull((String) rs1
							.getString("city_name"));
					stateregvalue = correctNull((String) rs1
							.getString("state_id"));
					if (!stateregvalue.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery = SQLParser.getSqlQuery("selstatecode^"
								+ stateregvalue);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next()) {
							statereg_value = correctNull((String) rs1
									.getString("state_name"));

						}
						if (rs1 != null) {
							rs1.close();
						}
					}
				}
				if (rs1 != null) {
					rs1.close();
				}
			}
			hshResult.put("comapp_regcity", cityregvalue);
			hshResult.put("comapp_regstate", statereg_value);
			if (rs != null)
				rs.close();
			// constitution

			strQuery = SQLParser.getSqlQuery("sel_cbsstaticdescbycode^2^"
					+ strconstitution);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("constitution", correctNull(rs1
						.getString("cbs_static_data_desc")));
			}
			// application created date
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("appcreatedate^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("app_createdate", correctNull(rs1
						.getString("app_createddate")));
			}
			// Funded and non funded
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("sel_fundedfacilitylistforadv11^"
					+ strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {

				hshResult.put("facility_proposedforfund", correctNull(rs1
						.getString("facility_proposed")));

			}
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser
					.getSqlQuery("sel_nonfundedfacilitylistforadv11^"
							+ strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("facility_proposedfornonfund", correctNull(rs1
						.getString("facility_proposed")));
			}

			// TAKE OVER NORMS
			if (rs1 != null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("pro_takeoversel^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("istakeover", correctNull(rs1
						.getString("istakeover")));
			}
			// NAMES OF PROPRIETORS/DIRECTORS/PARTNERS
			if (rs != null)
				rs.close();
			ArrayList arrdir = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_adv11propdirectors^"
					+ strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next()) {

				arrdir.add(correctNull(rs1.getString("perapp_fname")));
				// arrDircol.add(arrdir);
			}

			hshResult.put("arrDircol", arrdir);
			strQuery = SQLParser.getSqlQuery("selnewrating^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				flag = "Renewal";
			} else {
				flag = "New";
			}
			hshResult.put("flag", flag);
			if (rs1 != null) {
				rs1.close();
			}

			strQuery = SQLParser.getSqlQuery("selapproved^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("REVIEW", correctNull(rs1.getString("app_reviewdate")));
			}

			if (rs1 != null) {
				rs1.close();
			}
			String strclass = "";
			strQuery = SQLParser.getSqlQuery("sel_opsaccountdetails^"
					+ strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("ops_accountsectorcategory", correctNull(rs1
						.getString("ops_accountsectorcategory")));
				hshResult.put("ops_accountbusinessnature", correctNull(rs1
						.getString("ops_accountbusinessnature")));
				strclass = correctNull(rs1
						.getString("ops_accountassetclassification"));
			}
			// Asset Classification
			if (rs1 != null)
				rs.close();
			String strid = "31";
			strQuery = SQLParser.getSqlQuery("sel_static_desc^" + strid + "^"
					+ strclass);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {
				hshResult.put("asset_classification", correctNull(rs1
						.getString("stat_data_desc1")));

			}

			// Limits
			if (rs != null)
				rs.close();
			strQuery = SQLParser
					.getSqlQuery("com_wctl_funded_nonfunded_sanctionadvice^"
							+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				ArrayList TL_Funded_NonFunded = new ArrayList();
				String strFacsno = correctNull(rs.getString("facility_sno"));
				TL_Funded_NonFunded.add(strFacsno);
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_interest")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facilityhead")));

				// String strfacheadid =
				// correctNull(rs.getString("facility_headid"));
				// String strfacsubid =
				// correctNull(rs.getString("facility_id"));
				ArrayList arrSecurity = new ArrayList();
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^"
						+ strFacsno + "^" + strAppno);
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery);
				int j=0;
				while (rs1.next()) {
					ArrayList arrSeccol=new ArrayList();
					arrSeccol.add(correctNull(rs1.getString("sec_desc_details")));
					arrSeccol.add(correctNull(rs1.getString("sec_margin")));
					arrSecurity.add(arrSeccol);
					j++;
				}

				TL_Funded_NonFunded.add(arrSecurity);
				TL_Funded_NonFunded.add(""+j);
				OurBank_TL.add(TL_Funded_NonFunded);

			}
			hshResult.put("OurBank_TL", OurBank_TL);

			if (rs1 != null) {
				rs1.close();
			}

			hshRecord.put("selPrint", "Get");
			hshRecord.put("pageval", "FI");
			hshRecord.put("sel_divID", "0");

			// getPurchaseDetails(hshRecord);
			// getDepositAccounts(hshRecord);
			hsh1 = getadvBorrowingPower(hshRecord);
			hsh2 = getLegalheirs(hshRecord);
			hsh3 = getMeansCapital(hshRecord);
			hsh4 = getTermdepoits(hshRecord);
			hsh5 = getTurnover(hshRecord);
			// hsh6= getADVLiabilities(hshRecord);
			// hsh7= getADVMarketBorrowing(hshRecord);
			hsh8 = getADVDocument(hshRecord);
			hsh9 = getADVBorrowerExp(hshRecord);
			hsh10 = getGuranteedetails(hshRecord);
			hsh11 = getworkingcapital(hshRecord);
			hsh12 = getdishonours(hshRecord);
			hsh13 = getcommentsonstatus(hshRecord);
			hsh14 = gettermloancomments(hshRecord);
			hsh15 = getotherbank(hshRecord);
			hsh16 = getworkingcapitalcomments(hshRecord);
			hsh17 = getDepositAccounts(hshRecord);
			hsh18 = getPurchaseDetails(hshRecord);
			hsh20 = getComments(hshRecord);
			hsh21 = getconnectedaccts(hshRecord);
			//hshResult.putAll(getAuditObservations(hshRecord));
			hsh23 = getDataFinancials(hshRecord);

			hsh24.put("hidMethod", "getCostofProject");
			hsh24.put("appno", strAppno);
			hsh24.put("hidTabName", "getCostofProject");

			hsh24 = (HashMap) EJBInvoker.executeStateLess("comssiaboveten",
					hsh24, "getData");

			hsh25.put("hidMethod", "getCostofProject");
			hsh25.put("appno", strAppno);
			hsh25.put("hidTabName", "MeansOfFinancing");

			hsh25 = (HashMap) EJBInvoker.executeStateLess("comssiaboveten",
					hsh25, "getData");

			hshResult.put("hsh1", hsh1);
			hshResult.put("hsh2", hsh2);
			hshResult.put("hsh4", hsh4);
			hshResult.put("hsh5", hsh5);
			hshResult.put("hsh3", hsh3);
			hshResult.put("hsh8", hsh8);
			hshResult.put("hsh9", hsh9);
			hshResult.put("hsh10", hsh10);
			hshResult.put("hsh11", hsh11);
			hshResult.put("hsh12", hsh12);
			hshResult.put("hsh13", hsh13);
			hshResult.put("hsh14", hsh14);
			hshResult.put("hsh15", hsh15);
			hshResult.put("hsh16", hsh16);
			hshResult.put("hsh17", hsh17);
			hshResult.put("hsh18", hsh18);
			hshResult.put("hsh20", hsh20);
			hshResult.put("hsh21", hsh21);
			hshResult.put("hshValueFinancial", hsh23);
			hshResult.put("hsh24", hsh24);
			hshResult.put("hsh25", hsh25);

			strQuery = SQLParser.getSqlQuery("sel_generalcomments^" + strAppno
					+ "^" + "1");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("branchcomment1", correctNull((String) rs
						.getString("adv_branchcomment")));
				hshResult.put("sanctionofficecomment1", correctNull((String) rs
						.getString("adv_sanctionofficecomment")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_generalcomments^" + strAppno
					+ "^" + "2");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("branchcomment2", correctNull((String) rs
						.getString("adv_branchcomment")));
				hshResult.put("sanctionofficecomment2", correctNull((String) rs
						.getString("adv_sanctionofficecomment")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_generalcomments^" + strAppno
					+ "^" + "3");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("branchcomment3", correctNull((String) rs
						.getString("adv_branchcomment")));
				hshResult.put("sanctionofficecomment3", correctNull((String) rs
						.getString("adv_sanctionofficecomment")));
			}
			if (rs != null) {
				rs.close();
			}
			ArrayList arrhon = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_dishonours^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				ArrayList arrhon1 = new ArrayList();
				arrhon1.add(correctNull((String) rs
						.getString("adv_dishonortype")));
				arrhon1
						.add(correctNull((String) rs
								.getString("adv_disnoofdis")));
				arrhon1.add(correctNull((String) rs
						.getString("adv_disrangeamt")));
				arrhon1
						.add(correctNull((String) rs
								.getString("adv_disreasons")));
				arrhon.add(arrhon1);
			}
			hshResult.put("arrhon", arrhon);
			if (rs != null) {
				rs.close();
			}
			// Liablities
			ArrayList listrow = null;
			ArrayList listcol = null;

			strQuery = SQLParser.getSqlQuery("sel_ALLADV_Liabilities^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);

			listrow = new ArrayList();
			while (rs.next()) {
				listcol = new ArrayList();
				listcol.add(correctNull((String) rs.getString("liab_limit")));
				listcol
						.add(correctNull((String) rs
								.getString("liab_unsecured")));
				listcol.add(correctNull((String) rs.getString("liab_secured")));
				listcol.add(correctNull((String) rs.getString("liab_total")));
				listcol.add(correctNull((String) rs.getString("liab_option")));
				listcol
						.add(correctNull((String) rs.getString("liab_liabtype")));
				listrow.add(listcol);
			}
			hshResult.put("listrow", listrow);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("executive_finnotes_sel^" + strAppno
					+ "^MPBF1^0");

			if (rs.next()) {
				hshResult.put("advnotesMPBF", correctNull(Helper
						.CLOBToString(rs.getClob("notes"))));
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("executive_finnotes_sel^" + strAppno
					+ "^FI^0");

			if (rs.next()) {
				hshResult.put("advnotesFI", correctNull(Helper.CLOBToString(rs
						.getClob("notes"))));
			}

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("adv_finnotes_sel^" + strAppno
					+ "^FU^0");

			if (rs.next()) {
				hshResult.put("advnotesFUA", correctNull(Helper.CLOBToString(rs
						.getClob("notes"))));
			}

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selcommworkflowsancdetails^"
					+ strAppno);

			if (rs.next()) {
				hshResult.put("app_sanctioningcomments", Helper.correctNull(rs
						.getString("app_sanctioningcomments")));
			}

			if (rs != null)
				rs.close();

			rs = DBUtils.executeLAPSQuery("selmaiboxcomments^" + strAppno);

			if (rs.next()) {
				hshResult.put("branchcomments", correctNull(Helper
						.CLOBToString(rs.getClob("mail_comments"))));
			}

			rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + strAppno
					+ "^Collateral");
			while (rs.next()) {
				ArrayList arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("sec_desc_details")));
				arrCol.add(correctNull(rs.getString("sec_ownedby")));
				arrCol.add(correctNull(rs.getString("sec_desc_value")));
				arrCol.add(correctNull(rs.getString("sec_remarks")));
				arrCol.add(correctNull(rs.getString("sec_legalopinion")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrCollateral", arrRow);
			
			
			
			strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
			if (rs != null) {
				rs.close();
			}
			ArrayList arrInternal=new ArrayList();
			ArrayList arrStatutory =new ArrayList();
			ArrayList arrConcurrent=new ArrayList();
			ArrayList arrStock=new ArrayList();
			ArrayList arrRBI=new ArrayList();
			String audit_type = "";
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				ArrayList arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("adv_auditorsobservations")));
				arrCol.add(correctNull(rs.getString("adv_branchcomments")));
				arrCol.add(correctNull(rs.getString("adv_replies")));
				
				audit_type = correctNull((String) rs.getString("adv_audittype"));
				if (audit_type.equalsIgnoreCase("1")) {
					arrInternal.add(arrCol);
					hshResult.put("audit_internal_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("2")) {
					arrConcurrent.add(arrCol);
					hshResult.put("audit_concurrent_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("3")) {
					arrRBI.add(arrCol);
					hshResult.put("audit_inspection_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("4")) {
					arrStatutory.add(arrCol);
					hshResult.put("audit_statutory_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("5")) {
					arrStock.add(arrCol);
					hshResult.put("audit_stock_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
			}
			
			hshResult.put("arrInternal", arrInternal);
			hshResult.put("arrConcurrent", arrConcurrent);
			hshResult.put("arrRBI", arrRBI);
			hshResult.put("arrStatutory", arrStatutory);
			hshResult.put("arrStock", arrStock);
			
			hshResult.put("notapplicable","<td valign=\"top\">N.A</td>");
			
			 if(rs!=null)
				 rs.close();
		       rs = DBUtils.executeLAPSQuery("selmaiboxcomments^"+strAppno);
		      arrRow=new ArrayList();
		       while(rs.next())
		       {
		    	   ArrayList arrCol=new ArrayList();
		    	   arrCol=new ArrayList();
		    	   arrCol.add(correctNull(rs.getString("usr_fname")));
		    	   arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
		    	   arrRow.add(arrCol);
		       }
		      hshResult.put("mailcomments",arrRow);
		       
		} catch (Exception ce) {
			ce.printStackTrace();
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

		return hshResult;
	}

}