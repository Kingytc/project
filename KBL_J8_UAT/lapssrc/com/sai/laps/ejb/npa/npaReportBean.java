package com.sai.laps.ejb.npa;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import java.util.StringTokenizer;

@Stateless(name = "npaReportBean", mappedName = "npaReportHome")
@Remote (npaReportRemote.class)
public class npaReportBean extends BeanAdapter {
	private static final long serialVersionUID = 6456131852069954499L;
	static Logger log=Logger.getLogger(npaReportBean.class);
	public HashMap getcompromisepage3Data(HashMap hshValues)
			 {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery = "";
		String strAppno = "";
		String strLegalpos = "";
		double dblNotionalAmt = 0.0;
		double dblduedate = 0.0;
		double dblintrate = 0.0;
		double dblcrystaliseddues = 0.0;
		double dblNetDues = 0.0;
		double dblNotionalRate = 0.0;

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("selpresentpositiontotal^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblNotionalAmt = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("totnotionalinterest")));
				dblNetDues = Double.parseDouble(Helper
						.correctDouble((String) rs.getString("netdues")));
			}
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("seldummyledgerduedate^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblduedate = Double.parseDouble(Helper
						.correctDouble((String) rs.getString("duedate")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("getnpainterest^002");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblNotionalRate = Double.parseDouble(Helper
						.correctDouble((String) rs.getString("npa_intrate")));
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("getnpainterest^001");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblintrate = Double.parseDouble(Helper
						.correctDouble((String) rs.getString("npa_intrate")));
			}
			dblcrystaliseddues = dblNetDues
					+ (dblNotionalAmt * dblintrate / dblNotionalRate);
			hshResult.put("crystaliseddues", Helper
					.formatDoubleValue(dblcrystaliseddues));

			strQuery = SQLParser.getSqlQuery("sel_otsevaluation^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("marketabilityofsec", correctNull(rs
						.getString("npa_otssecurityparam")));
				hshResult.put("securities_value", correctNull(rs
						.getString("npa_otssecurityscore")));
				hshResult.put("legalposition", correctNull(rs
						.getString("npa_otslegalparam")));
				hshResult.put("legalposition_value", correctNull(rs
						.getString("npa_otslegalscore")));
				hshResult.put("means_value", correctNull(rs
						.getString("npa_otsmeansscore")));
				hshResult.put("npa_value", correctNull(rs
						.getString("npa_otsnpagescore")));
				hshResult.put("otherparam1", correctNull(rs
						.getString("npa_otsother1param")));
				hshResult.put("otherscore1", correctNull(rs
						.getString("npa_otsother1score")));
				hshResult.put("otherparam1", correctNull(rs
						.getString("npa_otsother2param")));
				hshResult.put("otherscore2", correctNull(rs
						.getString("npa_otsother2score")));
				hshResult.put("netscore_points", correctNull(rs
						.getString("npa_otsnetscore")));

				String strlegalpos = correctNull(rs.getString("npa_otslegalparam"));
				strQuery = SQLParser.getSqlQuery("sel_static_desc^29^"+ strlegalpos);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					strLegalpos = correctNull((String) rs1.getString("stat_data_desc1"));
				}
				hshResult.put("AuditFlag", "Y");
			}
			else{
				hshResult.put("AuditFlag", "N");
			}
			hshResult.put("npa_appno", strAppno);
			hshResult.put("Legal_position", strLegalpos);
			hshResult.put("npa_age", Helper
					.formatDoubleValue(dblduedate / 365 / 12));
			hshResult.putAll(getNPV(hshValues));
		} catch (Exception e) {
			throw new EJBException("Error in getting Data " + e.getMessage());
		}
		finally {
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
		return hshResult;
	}

	public void updatecompromisepage3Data(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAppno = "";
		String strAction = correctNull((String) hshValues.get("hidAction"));
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_otsevaluation");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_otsevaluation");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("sel_marketabilityofsec")));
				arrValues.add(correctNull((String) hshValues
						.get("securities_value")));
				arrValues
						.add(correctNull((String) hshValues.get("means_value")));
				arrValues.add(correctNull((String) hshValues.get("npa_value")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_legalposition")));
				arrValues.add(correctNull((String) hshValues
						.get("legalposition_value")));
				arrValues
						.add(correctNull((String) hshValues.get("otherparam1")));
				arrValues
						.add(correctNull((String) hshValues.get("otherscore1")));
				arrValues
						.add(correctNull((String) hshValues.get("otherparam1")));
				arrValues
						.add(correctNull((String) hshValues.get("otherscore2")));
				arrValues.add(correctNull((String) hshValues
						.get("netscore_points")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_otsevaluation");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			updateNPV(hshValues);
			
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag  = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				sbAuditData
				.append("Crystallised Dues =" +correctNull((String)hshValues.get("crystaliseddues")))
				.append("~ Value of Securities Particulars =" +correctNull((String)hshValues.get("hidSecValue")))
				.append("~ Value of Securities Points =" +correctNull((String)hshValues.get("securities_value")))
				.append("~ Bank Legal Position Particulars =" +correctNull((String)hshValues.get("hidLegalPosi")))
				.append("~ Bank Legal Position Points =" +correctNull((String)hshValues.get("legalposition_value")))
				.append("~ Borrower / Guarantors Aggregate Points =" +correctNull((String)hshValues.get("means_value")))
				.append("~ Age Of NPA Points =" +correctNull((String)hshValues.get("npa_value")))
				.append("~ NET SCORE POINTS =" +correctNull((String)hshValues.get("netscore_points")))
				.append("~ Realisable Value Of Available Securities =" +correctNull((String)hshValues.get("txt_realisablevalue")))
				.append("~ Rate of Interest =" +correctNull((String)hshValues.get("txt_rateofint")))
				.append("~ Number Of Years =" +correctNull((String)hshValues.get("txt_years")))
				.append("~ NPV =" +correctNull((String)hshValues.get("txt_npv")));
			}
			AuditTrial.auditLog(hshValues, "379", strAppno, sbAuditData.toString());
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public void updateSarfaesiDocument(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strQuery = "";
		String strsno = "";
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}
		String strsno1 = correctNull((String) hshValues.get("hid_strsno"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("selsarfaesidocdet^"+strAppno+"^"+strsno1);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("DOCUMENT NAME =" +correctNull((String)rs.getString("DOCUMENT_NAME")))
					.append("~ DATE OF DOCUMENTATION =" +correctNull((String)rs.getString("DOCUMENT_DATE")))
					.append("~ EXPIRY DATE OF DOCUMENT =" +correctNull((String)rs.getString("DOCUMENT_EXPIRYDATE")))
					.append("~ WHETHER DOCUMENTS ARE ENFORCEABLE =" +ApplicantParams.getApplicantParams("DOCUMENTENFORCE", correctNull((String)rs.getString("DOCUMENT_ENFORCEABLE"))))
					.append("~ DATE OF CERTIFICATION =" +correctNull((String)rs.getString("DATE_CERTIFICATION")))
					.append("~ TYPE OF DOCUMENT =" +ApplicantParams.getApplicantParams("TYPEOFDOCUMENT", correctNull((String)rs.getString("DOCUMENT_TYPE"))));
				}
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxsarfaesidoc^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("SARF_DOCNO"));
				}
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_sarfaesidoc");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(correctNull((String) hshValues
						.get("txt_documentname")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_documentdate")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_expirydocumentdate")));
				arrValues
						.add(correctNull((String) hshValues.get("doc_enforce")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_certificationdate")));
				arrValues.add(correctNull((String) hshValues.get("sel_field")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updsarfaesidoc");

				arrValues.add(correctNull((String) hshValues
						.get("txt_documentname")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_documentdate")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_expirydocumentdate")));
				arrValues
						.add(correctNull((String) hshValues.get("doc_enforce")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_certificationdate")));
				arrValues.add(correctNull((String) hshValues.get("sel_field")));
				arrValues.add(strAppno);
				arrValues.add(strsno1);

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
				arrValues.add(correctNull((String) hshValues
						.get("txt_documentname")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_documentdate")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_expirydocumentdate")));
				arrValues.add("1");
				arrValues.add("");
				arrValues.add("1");
				arrValues.add(strAppno);
				arrValues.add(strsno1);
				hshQuery.put("strQueryId", "updsarfaesidoc");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("DOCUMENT NAME =" +correctNull((String)hshValues.get("txt_documentname")))
				.append("~ DATE OF DOCUMENTATION =" +correctNull((String)hshValues.get("txt_documentdate")))
				.append("~ EXPIRY DATE OF DOCUMENT =" +correctNull((String)hshValues.get("txt_expirydocumentdate")))
				.append("~ WHETHER DOCUMENTS ARE ENFORCEABLE =" +ApplicantParams.getApplicantParams("DOCUMENTENFORCE", correctNull((String)hshValues.get("doc_enforce"))))
				.append("~ DATE OF CERTIFICATION =" +correctNull((String)hshValues.get("txt_certificationdate")))
				.append("~ TYPE OF DOCUMENT =" +ApplicantParams.getApplicantParams("TYPEOFDOCUMENT", correctNull((String)hshValues.get("sel_field"))));
			}
			AuditTrial.auditNewLog(hshValues, "385", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateSarfaesiDocument"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getSarfaesiDocument(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery = "";
		String strAppno = "";

		try {
			String moduletype = correctNull((String) hshValues
					.get("hidmoduletype"));
			String orgcode = correctNull((String) hshValues.get("strOrgCode"));
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("npa_appno"));
			}
			hshResult.put("strOrgName", correctNull((String) hshValues
					.get("strOrgName")));
			strQuery = SQLParser.getSqlQuery("sel_sarfaesidoc^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("SARF_DOCNO")));
				arrCol.add(correctNull(rs.getString("DOCUMENT_NAME")));
				arrCol.add(correctNull(rs.getString("DOCUMENT_DATE")));
				arrCol.add(correctNull(rs.getString("DOCUMENT_EXPIRYDATE")));
				arrCol.add(correctNull(rs.getString("DOCUMENT_ENFORCEABLE")));
				arrCol.add(correctNull(rs.getString("DATE_CERTIFICATION")));
				arrCol.add(correctNull(rs.getString("DOCUMENT_TYPE")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			hshResult.put("npa_appno", strAppno);
			hshResult.put("moduletype", moduletype);

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("setorgselect^" + orgcode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				hshResult
						.put("region", correctNull(rs.getString("org_region")));
			}
			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("sel_minmortgagedate^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				hshResult.put("min_certificationdate", correctNull(rs
						.getString("min_certificationdate")));
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getGuarantorHelpData-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updatesarfaeripage2Data(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_sarfaesicomplaint");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_sarfaesicomplaint");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("complaint_rec")));
				arrValues.add(correctNull((String) hshValues
						.get("complaint_received")));
				arrValues.add(correctNull((String) hshValues
						.get("complaint_disposal")));
				arrValues
						.add(correctNull((String) hshValues.get("suit_filed")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_suitdate")));
				arrValues.add(correctNull((String) hshValues.get("bifr_acct")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_lasthearing")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_sarfaesicomplaint");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert")){
				sbAuditData
				.append("WHETHER ANY COMPLAINT RECIEVED BY THE BRANCH =" +ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("complaint_rec"))))
				.append("~ WHETHER SUIT FILED =" +ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("suit_filed"))))
				.append("~ DATE OF SUIT FILED =" +correctNull((String)hshValues.get("txt_suitdate")))
				.append("~ WHETHER BIFR ACCOUNT REFERRED =" +ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("bifr_acct"))))
				.append("~ LAST HEARING HELD ON =" +correctNull((String)hshValues.get("txt_lasthearing")));
			}
			AuditTrial.auditLog(hshValues, "386", strAppno, sbAuditData.toString());

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public HashMap getsarfaeripage2Data(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_sarfaesicomplaint^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("AuditFlag", "Y");
				rs.beforeFirst();
			}
			else{
				hshResult.put("AuditFlag", "N");
				rs.beforeFirst();
			}
			while (rs.next()) {
				hshResult.put("COMPLAINT_REC", correctNull(rs
						.getString("COMPLAINT_REC")));
				hshResult.put("COMPLAINT_RECEIVED", correctNull(rs
						.getString("COMPLAINT_RECEIVED")));
				hshResult.put("COMPLAINT_DISPOSAL", correctNull(rs
						.getString("COMPLAINT_DISPOSAL")));
				hshResult.put("SUIT_FILED", correctNull(rs
						.getString("SUIT_FILED")));
				hshResult.put("SUIT_DATE", correctNull(rs
						.getString("SUIT_DATE")));
				hshResult.put("BIFR_ACCT", correctNull(rs
						.getString("BIFR_ACCT")));
				hshResult.put("HEARING_DATE", correctNull(rs
						.getString("HEARING_DATE")));
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getGuarantorHelpData-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updatesarfaeripage3Data(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "";
		String strAction = correctNull((String) hshValues.get("hidAction"));
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {

			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_sarfaeri3");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "ins_sarfaeri3");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("select1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_security")));
				arrValues.add(correctNull((String) hshValues.get("select2")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_peacefulposiion")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_approximate")));
				arrValues.add(correctNull((String) hshValues.get("select3")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_securitydisposed1")));
				arrValues.add(correctNull((String) hshValues.get("select4")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_OTSoverdue")));
				arrValues.add(correctNull((String) hshValues.get("select5")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_Borrweridentified")));
				arrValues.add(correctNull((String) hshValues.get("select6")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_bankerdecision")));
				arrValues.add(correctNull((String) hshValues.get("bank1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_borrower")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_sarfaeri3");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert")){
				sbAuditData
				.append("WHETHER SECURITIES CAN BE EASILY DISPOSED ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select1"))))
				.append("~ HAS THE BORROWER DISPUTED BANK'S DUES ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("bank1"))))
				.append("~ WHETHER PEACEFUL POSSESSION OF SECURITIES POSSIBLE ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select2"))))
				.append("~ TIME FRAME FOR DISPOSAL FOR SECURITIES ="+correctNull((String)hshValues.get("txt_approximate")))
				.append("~ WHETHER OTS ITS APPROVED IN THIS ACCOUNT ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select3"))))
				.append("~ CHANCES OF RECOVERY OF AMOUNT AS PER OTS ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select4"))))
				.append("~ WHETHER BORROWER IS IDENTIFIED AS WILFUL DEFAULTER ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select5"))))
				.append("~ WHETHER BANKER'S MEETING CALLED ="+ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("select6"))));
			}
			AuditTrial.auditLog(hshValues, "387", strAppno, sbAuditData.toString());
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public HashMap getsarfaeripage3Data(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";
		String comappid = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			comappid = correctNull((String) hshValues.get("comappid"));
			if (comappid.equalsIgnoreCase("")) {
				comappid = correctNull((String) hshValues.get("comapp_id"));
			}
			if (comappid.equalsIgnoreCase("")) {
				comappid = correctNull((String) hshValues.get("appid"));
			}
			hshResult.put("strOrgName", correctNull((String) hshValues
					.get("strOrgName")));
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_sarfaeri3^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("AuditFlag", "Y");
				rs.beforeFirst();
			}
			else
			{
				hshResult.put("AuditFlag", "N");
				rs.beforeFirst();
			}
			while (rs.next()) {
				hshResult.put("sec_disposed", correctNull(rs
						.getString("sec_disposed")));
				hshResult.put("sec_disposedetails", correctNull(rs
						.getString("sec_disposedetails")));

				hshResult.put("sec_possible", correctNull(rs
						.getString("sec_possible")));
				hshResult.put("sec_possibledetails", correctNull(rs
						.getString("sec_possibledetails")));
				hshResult.put("approxtime", correctNull(rs
						.getString("approxtime")));
				hshResult.put("ots_account", correctNull(rs
						.getString("ots_account")));
				hshResult.put("ots_accountdetails", correctNull(rs
						.getString("ots_accountdetails")));
				hshResult.put("ots_overdue", correctNull(rs
						.getString("ots_overdue")));

				hshResult.put("ots_overduedetails", correctNull(rs
						.getString("ots_overduedetails")));
				hshResult.put("defaulter", correctNull(rs
						.getString("defaulter")));
				hshResult.put("defaulter_details", correctNull(rs
						.getString("defaulter_details")));
				hshResult.put("account", correctNull(rs.getString("account")));
				hshResult.put("account_details", correctNull(rs
						.getString("account_details")));
				hshResult.put("borr_disputed", correctNull(rs
						.getString("borr_disputed")));
				hshResult.put("borr_disputedetails", correctNull(rs
						.getString("borr_disputedetails")));
			}
			
			if (rs != null) {
				rs.close();
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getsarfaeripage3Data-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getprudentialpage2Data(HashMap hshValues)
			 {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "", strAppno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_prudentialpage2^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("legal_expenses", correctNull(rs
						.getString("legal_expenses")));
				hshResult.put("DICGC_settled", correctNull(rs
						.getString("DICGC_settled")));
				hshResult.put("DICGC_date", correctNull(rs
						.getString("DICGC_date")));
				hshResult.put("lastreview_date", correctNull(rs
						.getString("lastreview_date")));
				hshResult.put("txt_enhancements", correctNull(rs
						.getString("txt_enhancements")));
				hshResult.put("lastinspection_date", correctNull(rs
						.getString("lastinspection_date")));
				hshResult.put("suit_date", correctNull(rs
						.getString("suit_date")));
				hshResult
						.put("suit_amt", correctNull(rs.getString("suit_amt")));
				hshResult.put("prospects", correctNull(rs
						.getString("prospects")));
				hshResult.put("staff_accountability", correctNull(rs
						.getString("staff_accountability")));
				hshResult.put("suitposition", correctNull(rs
						.getString("suitposition")));
				hshResult.put("AuditFlag", "Y");
			}
			else
			{
				hshResult.put("AuditFlag", "N");
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getprudentialpage2Data:::  "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection in getprudentialpage2Data :: "
								+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updateprudentialpage2Data(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAppno = "";
		String strAction = correctNull((String) hshValues.get("hidAction"));
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_prudentialpage2");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_prudentialpage2");

				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("legal_expenses")));
				arrValues.add(correctNull((String) hshValues
						.get("digc_settled")));
				if (correctNull((String) hshValues.get("DICGC_date"))
						.equalsIgnoreCase("")
						|| correctNull((String) hshValues.get("DICGC_date"))
								.equalsIgnoreCase("null")) {
					arrValues.add("");
				} else {
					arrValues.add(correctNull((String) hshValues
							.get("DICGC_date")));
				}
				if (correctNull((String) hshValues.get("lastreview_date"))
						.equalsIgnoreCase("")
						|| correctNull(
								(String) hshValues.get("lastreview_date"))
								.equalsIgnoreCase("null")) {
					arrValues.add("");
				} else {
					arrValues.add(correctNull((String) hshValues
							.get("lastreview_date")));
				}
				arrValues.add(correctNull((String) hshValues
						.get("txt_enhancement")));
				if (correctNull((String) hshValues.get("lastinspection_date"))
						.equalsIgnoreCase("")
						|| correctNull(
								(String) hshValues.get("lastinspection_date"))
								.equalsIgnoreCase("null")) {
					arrValues.add("");
				} else {
					arrValues.add(correctNull((String) hshValues
							.get("lastinspection_date")));
				}

				if (correctNull((String) hshValues.get("suit_date"))
						.equalsIgnoreCase("")
						|| correctNull((String) hshValues.get("suit_date"))
								.equalsIgnoreCase("null")) {
					arrValues.add("");
				} else {
					arrValues.add(correctNull((String) hshValues
							.get("suit_date")));
				}
				arrValues.add(correctNull((String) hshValues.get("suit_amt")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_prospects")));
				arrValues.add(correctNull((String) hshValues.get("txt_staff")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_suitposition")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_prudentialpage2");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "Update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "Insert");
			}
			if(strAction.equalsIgnoreCase("insert")){
				sbAuditData
				.append("DATE OF LAST REVIEW / ENHANCEMENT =" +correctNull((String)hshValues.get("lastreview_date")))
				.append("~ DATE OF LAST INSPECTION =" +correctNull((String)hshValues.get("lastinspection_date")))
				.append("~ DATE WHEN SUIT FILED =" +correctNull((String)hshValues.get("suit_date")))
				.append("~ AMOUNT OF SUIT FILED =" +correctNull((String)hshValues.get("suit_amt")));
			}
			AuditTrial.auditLog(hshValues, "389", strAppno, sbAuditData.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateprudentialpage2Data :: "
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateprudentialpage2Data"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getstatusnotepage2Data(HashMap hshValues)
			 {
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAppno = "";
		String strQuery = "";
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("select_statusnotepage2^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("ACCOUNT_CLASSIFIED", correctNull(rs
						.getString("ACCOUNT_CLASSIFIED")));
				hshResult.put("ACCOUNT_CLASSIFIED_REASON", correctNull(rs
						.getString("ACCOUNT_CLASSIFIED_REASON")));

				hshResult.put("ACCOUNT_PLACEDUNDER", correctNull(rs
						.getString("ACCOUNT_PLACEDUNDER")));
				hshResult.put("ACCOUNT_PLACEDUNDER_REASON", correctNull(rs
						.getString("ACCOUNT_PLACEDUNDER_REASON")));
				hshResult.put("OTS", correctNull(rs.getString("OTS")));
				hshResult.put("OTS_REASON", correctNull(rs
						.getString("OTS_REASON")));
				hshResult.put("ECGC_POSITION", correctNull(rs
						.getString("ECGC_POSITION")));
				hshResult.put("BIFR_ACCOUNT", correctNull(rs
						.getString("BIFR_ACCOUNT")));
				hshResult.put("TAKEOVER_ACCOUNT", correctNull(rs
						.getString("TAKEOVER_ACCOUNT")));
				hshResult.put("TAKEOVER_BANK", correctNull(rs
						.getString("TAKEOVER_BANK")));
				hshResult.put("GUARANTEE", correctNull(rs
						.getString("GUARANTEE")));
				hshResult.put("PARTICULAR_GUARANTEE", correctNull(rs
						.getString("PARTICULAR_GUARANTEE")));
				hshResult.put("FRAUD_ACCOUNT", correctNull(rs
						.getString("FRAUD_ACCOUNT")));
				hshResult.put("FRAUD_ACCOUNTDATE", correctNull(rs
						.getString("FRAUD_ACCOUNTDATE")));
				hshResult.put("TERMS_SANCTION", correctNull(rs
						.getString("TERMS_SANCTION")));
				hshResult.put("TERMS_SANCTION_NOT_COMPLIED", correctNull(rs
						.getString("TERMS_SANCTION_NOT_COMPLIED")));
				hshResult.put("LATEST_DOCDATE", correctNull(rs
						.getString("LATEST_DOCDATE")));
				hshResult
						.put("DBC_DATE", correctNull(rs.getString("DBC_DATE")));
				hshResult.put("VETTED_BY_ADVOCATES", correctNull(rs
						.getString("VETTED_BY_ADVOCATES")));
				hshResult.put("VETTEDDATE", correctNull(rs
						.getString("VETTEDDATE")));
				hshResult.put("VETTING_AUTHORITY", correctNull(rs
						.getString("VETTING_AUTHORITY")));
				hshResult.put("ADVOCATES_NAME", correctNull(rs
						.getString("ADVOCATES_NAME")));
				hshResult.put("DISCREPANCIES", correctNull(rs
						.getString("DISCREPANCIES")));
				hshResult.put("SUIT", correctNull(rs.getString("SUIT")));
				hshResult
						.put("SUITDATE", correctNull(rs.getString("SUITDATE")));
				hshResult.put("SUIT_AMOUNT", correctNull(rs
						.getString("SUIT_AMOUNT")));
				hshResult.put("PRESENT_POSITION", correctNull(rs
						.getString("PRESENT_POSITION")));
				hshResult.put("ADVOCATES_NAME1", correctNull(rs
						.getString("ADVOCATES_NAME1")));
				hshResult.put("ADVOCATES_TELNO", correctNull(rs
						.getString("ADVOCATES_TELNO")));
				hshResult.put("ACTION_UNDER_SARFAESIA", correctNull(rs
						.getString("ACTION_UNDER_SARFAESIA")));
				hshResult.put("ISSUEDDATE", correctNull(rs
						.getString("ISSUEDDATE")));
				hshResult.put("POSSESSION_NOTICE", correctNull(rs
						.getString("POSSESSION_NOTICE")));
				hshResult.put("POSSESSION_DATE", correctNull(rs
						.getString("POSSESSION_DATE")));
				hshResult.put("POSSESSION_TAKEN", correctNull(rs
						.getString("POSSESSION_TAKEN")));
				hshResult.put("POSSESSION_TAKEN_DATE", correctNull(rs
						.getString("POSSESSION_TAKEN_DATE")));
				hshResult.put("ASSET_SOLD", correctNull(rs
						.getString("ASSET_SOLD")));
				hshResult.put("ASSET_SOLD_AMT", correctNull(rs
						.getString("ASSET_SOLD_AMT")));
				hshResult.put("ASSET_SOLD_DATE", correctNull(rs
						.getString("ASSET_SOLD_DATE")));
				hshResult.put("OTHERS", correctNull(rs.getString("OTHERS")));
				hshResult.put("AGENT_APPOINTED", correctNull(rs
						.getString("AGENT_APPOINTED")));
				hshResult.put("AGENT_REASON", correctNull(rs
						.getString("AGENT_REASON")));
			}
			strQuery = SQLParser.getSqlQuery("sel_statusnote21^" + strAppno);
			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("sn_no")));
				arrCol.add(correctNull(rs.getString("ref_no")));
				arrCol.add(correctNull(rs.getString("ref_date")));
				arrCol.add(correctNull(rs.getString("hearing_status")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			strQuery = SQLParser.getSqlQuery("sel_npageneralinfo^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("status_note", correctNull(rs
						.getString("npagen_propfor")));
			}
			strQuery = SQLParser.getSqlQuery("sel_statusnote22^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("pwo_amt", correctNull(rs.getString("pwo_amt")));
				hshResult
						.put("pwo_date", correctNull(rs.getString("pwo_date")));
				hshResult.put("pwo_recovery", correctNull(rs
						.getString("pwo_recovery")));
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getstatusnotepage2Data-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updatestatusnotepage2Data(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String[] refno = null;
		String[] ref_date = null;
		String[] hearing_status = null;
		ResultSet rs = null;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("npa_appno"));
		}
		refno = (String[]) hshValues.get("txt_refno");
		ref_date = (String[]) hshValues.get("txt_refdate");
		hearing_status = (String[]) hshValues.get("txt_hearing_status");

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "del_statusnote21");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusnotepage2data");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusnote22");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size", "3");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "ins_statusnotepage2");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("txt_eas")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_easreason")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_placedunders")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_placedundersreason")));
				arrValues.add(correctNull((String) hshValues.get("txt_ots")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_ots_reason")));
				arrValues.add(correctNull((String) hshValues.get("txt_ecgc")));
				arrValues.add(correctNull((String) hshValues.get("txt_bifr")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_takeover")));
				arrValues.add(correctNull((String) hshValues.get("txt_bank")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_govern")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_governreason")));
				arrValues.add(correctNull((String) hshValues.get("txt_fraud")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_frauddate")));
				arrValues.add(correctNull((String) hshValues.get("txt_terms")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_termscomplied")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_latestdoc")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_dbcdoc")));
				arrValues.add(correctNull((String) hshValues.get("txt_docs")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_latestdate")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_vetting")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_vettingname")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_Discrepancies")));
				arrValues.add(correctNull((String) hshValues.get("txt_suit")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_datesuit")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_amtsuit")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_presentposition")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_advocatename1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_advocateno")));
				arrValues.add(correctNull((String) hshValues.get("txt_sarf")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_datenotice")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_poss_notice")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_noticedate")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_poss_taken")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_takendate")));
				arrValues.add(correctNull((String) hshValues.get("sel_asset")));
				arrValues.add(correctNull((String) hshValues.get("txt_asset")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_assetdate")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_others")));
				arrValues.add(correctNull((String) hshValues.get("txt_agent")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_agentreason")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				for (int i = 0; i < 5; i++) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(Integer.toString(i + 1));
					arrValues.add(correctNull(refno[i]));
					arrValues.add(correctNull(ref_date[i]));
					arrValues.add(correctNull(hearing_status[i]));

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "ins_statusnote21");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_statusnote22");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("txt_amtwrittenoff")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_writtenoffdate")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_recoverywrittenoff")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			if (strAction.equalsIgnoreCase("delete")) {

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "del_statusnote21");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusnotepage2data");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusnote22");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size", "3");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updatestatusnotepage2Data"
								+ cf.getMessage());
			}
		}
	}

	public void updatenpamailbox(HashMap hshValues)  {
		String appno = "";
		HashMap hshQueryValues = null;
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		try {
			appno = correctNull((String) hshValues.get("appno"));

			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_npamail");
			arrValues.add(appno);

			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
		} catch (Exception e) {
			throw new EJBException("Error in updatenpamailbox:- "
					+ e.getMessage());
		}
	}

	public HashMap getnpatype(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		String appno = "";

		try {
			appno = correctNull((String) hshValues.get("comm_appno"));
			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_npatype^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("npatype", correctNull(rs.getString("npa_type")));
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getnpatype-- " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap printgetCompromise(HashMap hshValues)  {
		String strAppno = "";
		String strQuery = "";
		StringBuffer sbfsignatories = null;
		ResultSet rs = null;

		HashMap hshResult = new HashMap();
		HashMap hshgeneral = new HashMap();
		HashMap hshResult2 = new HashMap();
		HashMap hshResult3 = new HashMap();
		HashMap hshResult4 = new HashMap();
		HashMap hshResult6 = new HashMap();
		HashMap hshResult7 = new HashMap();
		HashMap hshResult8 = new HashMap();
		HashMap hshborrower = new HashMap();
		HashMap hshEvaluation = new HashMap();
		HashMap hshReliefSought = new HashMap();
		HashMap hshModulardues = new HashMap();
		HashMap hshComments = new HashMap();
		HashMap hshTermscond = new HashMap();
		HashMap hshSignatories = new HashMap();

		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		double total = 0.0;
		double tot = 0.0;
		try {
			hshResult.put("proposalin", correctNull((String) hshValues
					.get("proposalin")));
			hshValues.put("printdata", "print");
			strAppno = correctNull((String) hshValues.get("npa_appno"));
			hshValues.put("appno", strAppno);
			hshgeneral = new HashMap();

			hshgeneral = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getGeneralinfoData");
			hshResult2 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getGeneralHistoryData");

			hshResult3 = (HashMap) getcompromisepage3Data(hshValues);
			
			hshResult6 = (HashMap) EJBInvoker.executeStateLess("npacommon",	hshValues, "getorganisationrecmmendations");
			
			hshEvaluation = (HashMap) getEvaluationscores(hshResult3);
			hshReliefSought = (HashMap) getCompromiseReliefSought(hshValues);
			hshModulardues = (HashMap) getCompromiseModulardues(hshValues);
			hshComments = (HashMap) getcompromisecomments(hshValues);

			hshResult.put("hshgeneral", hshgeneral);
			hshResult.put("hshValues2", hshResult2);
			hshResult.put("hshValues3", hshResult3);
			hshResult.put("hshValues4", hshResult4);

			hshResult.put("hshValues6", hshResult6);
			hshResult7 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getPresentPosition");
			hshResult8 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getSecurities");
			hshborrower = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getBorrowerDetails");
			hshTermscond = (HashMap) getcompromisetermscond(hshValues);
			hshSignatories = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getsignatories");

			hshResult.put("hshValues7", hshResult7);
			hshResult.put("hshValues8", hshResult8);
			hshResult.put("hshborrower", hshborrower);
			hshResult.put("hshEvaluation", hshEvaluation);
			hshResult.put("hshReliefSought", hshReliefSought);
			hshResult.put("hshModulardues", hshModulardues);
			hshResult.put("hshComments", hshComments);
			hshResult.put("hshTermscond", hshTermscond);
			hshResult.put("hshSignatories", hshSignatories);

			sbfsignatories = new StringBuffer(
					correctNull((String) hshSignatories.get("signatures")));
			if (sbfsignatories != null) {
				for (int i = 0; i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshResult.put("signatures", sbfsignatories.toString());
			}

			vecRow = (ArrayList) hshResult7.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					{
						tot = Double.parseDouble((Helper
								.correctDouble((String) vecCol.get(3))));
						total = total + tot;

					}
				}
			}

			hshResult
					.put("totalrunningledger", Helper.formatDoubleValue(total));

			String processeddate = "";

			strQuery = SQLParser.getSqlQuery("npaprocessdate^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				processeddate = correctNull((String) rs
						.getString("processeddate"));
			}

			hshResult.put("processeddate", processeddate);
			hshResult.putAll(getBorrowerDetails(hshValues));
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing in printgetCompromise"
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap printgetSarfaeri(HashMap hshValues)  {

		HashMap hshResult = new HashMap();
		HashMap hshResult1 = new HashMap();
		HashMap hshResult2 = new HashMap();
		HashMap hshResult3 = new HashMap();
		HashMap hshResult4 = new HashMap();
		HashMap hshResult5 = new HashMap();
		HashMap hshPrint = new HashMap();
		HashMap hshSec = new HashMap();
		HashMap hshMeans = new HashMap();
		HashMap hshvalue = new HashMap();
		StringBuffer sbfsignatories = null;

		hshResult2 = (HashMap) getsarfaeripage2Data(hshValues);
		hshResult3 = (HashMap) getsarfaeripage3Data(hshValues);
		// hshResult4=(HashMap)getsarfaeripage4Data(hshValues);
		hshResult5 = (HashMap) getSarfaesiDocument(hshValues);

		hshResult.put("hshValues2", hshResult2);
		hshResult.put("hshValues3", hshResult3);
		hshResult.put("hshValues4", hshResult4);
		hshResult.put("hshValues5", hshResult5);

		try {
			hshValues.put("printdata", "print");
			hshResult1 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getGeneralinfoData");
			hshPrint = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getPresentPosition");
			hshSec = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getSecurities");
			hshMeans = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getBorrowerDetails");

			hshvalue = new HashMap();
			hshValues.put("banktype", "CON");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getotherbankdues");
			hshResult.put("hshcons", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "MUL");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getotherbankdues");
			hshResult.put("hshmul", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getorganisationrecmmendations");
			hshResult.put("hshRecommendations", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getsignatories");

			hshResult.put("hshSignatories", hshvalue);
			sbfsignatories = new StringBuffer(correctNull((String) hshvalue.get("signatures")));
			if (sbfsignatories != null) {
				for (int i = 0; i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshResult.put("signatures", sbfsignatories.toString());
			}
			hshResult.putAll(getBorrowerDetails(hshValues));
		} catch (Exception ae) {
			throw new EJBException("Error closing the connection "
					+ ae.getMessage());
		}
		hshResult.put("hshValues1", hshResult1);
		hshResult.put("hshPrint", hshPrint);
		hshResult.put("hshSec", hshSec);
		hshResult.put("hshMeans", hshMeans);

		return hshResult;
	}

	public void update34pointspage6Data(HashMap hshValues)  {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		ResultSet rs = null;

		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		String strCBSNO = correctNull((String) hshValues.get("cbs_accountno"));
		// String strcustid=correctNull((String)hshValues.get("cbs_custid"));

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_filingelab6");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "ins_filingelab6");
				arrValues.add(strAppno);
				arrValues.add(strCBSNO);
				arrValues.add(correctNull((String) hshValues
						.get("txt_elaborate")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_further")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_elaboratedbc")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_account_history")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_symptoms")));
				arrValues
						.add(correctNull((String) hshValues.get("sel_rbutton")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_reason")));

				arrValues.add(correctNull((String) hshValues
						.get("sel_business_cont")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_present_act")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_assets")));
				arrValues.add(correctNull((String) hshValues.get("txt_claim")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_branch_rec")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_filingelab6");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in update34pointspage6Data"
								+ cf.getMessage());
			}
		}
	}

	public HashMap get34pointspage6Data(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;

		String strQuery = "";
		String strAppno = "";

		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("npa_appno"));
			}

			hshResult.put("strOrgName", correctNull((String) hshValues
					.get("strOrgName")));

			strQuery = SQLParser.getSqlQuery("sel_filingelab6^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshResult.put("fil_elaborate", correctNull(rs
						.getString("fil_elaborate")));
				hshResult.put("fil_further", correctNull(rs
						.getString("fil_further")));
				hshResult.put("fil_elaboratedbc", correctNull(rs
						.getString("fil_elaboratedbc")));
				hshResult.put("fil_account_history", correctNull(rs
						.getString("fil_account_history")));
				hshResult.put("fil_symptoms", correctNull(rs
						.getString("fil_symptoms")));
				hshResult.put("terms_condts", correctNull(rs
						.getString("terms_condts")));
				hshResult.put("reasons", correctNull(rs.getString("reasons")));

				hshResult.put("business_cont", correctNull(rs
						.getString("business_cont")));
				hshResult.put("present_act", correctNull(rs
						.getString("present_act")));
				hshResult.put("fil_assets", correctNull(rs
						.getString("fil_assets")));
				hshResult.put("fil_claim", correctNull(rs
						.getString("fil_claim")));

				hshResult.put("fil_branch_rec", correctNull(rs
						.getString("fil_branch_rec")));
			}

			if (rs != null) {
				rs.close();
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getGuarantorHelpData-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;

	}

	public void update34pointspage4Data(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();

		String[] stractholdname = null;
		String[] strrelation = null;
		String[] straccounttype = null;
		String[] stroutstandingamount = null;

		ResultSet rs = null;
		String strAppno = "";
		ArrayList arrValues = new ArrayList();

		String strAction = correctNull((String) hshValues.get("hidAction"));
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}
		String strcustid = correctNull((String) hshValues.get("cbsid"));

		stractholdname = (String[]) hshValues.get("txt_actholdname");
		strrelation = (String[]) hshValues.get("txt_relation");
		straccounttype = (String[]) hshValues.get("txt_accounttype");
		stroutstandingamount = (String[]) hshValues
				.get("txt_outstandingamount");

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_filingbank40");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "ins_filingbank40");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("strcustid")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_account_history")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_symptoms")));
				arrValues.add(correctNull((String) hshValues
						.get("bank_arrangement")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_associate")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_accountholder")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_filingbank43");
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
			for (int k = 0; k < stractholdname.length; k++) {

				if (!stractholdname[k].equals("")) {
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strAppno);
					arrValues.add(strcustid);
					arrValues.add(Integer.toString(k + 1));
					arrValues.add(stractholdname[k]);
					arrValues.add(strrelation[k]);
					arrValues.add(straccounttype[k]);
					arrValues.add(stroutstandingamount[k]);
					hshQuery.put("strQueryId", "ins_filingbank43");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");

				}

			}
			if (strAction.equalsIgnoreCase("delete")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_filingbank40");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_filingbank43");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

		}

		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

	}

	public HashMap get34pointspage4Data(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;

		String[] stractholdname = new String[5];
		String[] strrelation = new String[5];
		String[] straccounttype = new String[5];
		String[] stroutstandingamount = new String[5];

		int i = 0, j = 0, k = 0;

		String strQuery = "";

		String strAppno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_filingbank40^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("fil_account_history", correctNull(rs
						.getString("fil_account_history")));
				hshResult.put("fil_symptoms", correctNull(rs
						.getString("fil_symptoms")));
				hshResult.put("sel_accountholder", correctNull(rs
						.getString("sel_accountholder")));
			}

			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("sel_filingbank43^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				stractholdname[k] = correctNull((String) rs
						.getString("fil_actholdname"));
				strrelation[k] = correctNull((String) rs
						.getString("fil_relation"));
				straccounttype[k] = correctNull((String) rs
						.getString("fil_accounttype"));
				stroutstandingamount[k] = correctNull((String) rs
						.getString("fil_outstandingamount"));

				k = k + 1;
			}

			hshResult.put("fil_actholdname", stractholdname);
			hshResult.put("fil_relation", strrelation);
			hshResult.put("fil_accounttype", straccounttype);
			hshResult.put("fil_outstandingamount", stroutstandingamount);

			if (rs != null) {
				rs.close();
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getGuarantorHelpData-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;

	}

	public HashMap printget34pointspageData(HashMap hshValues)
			 {
		HashMap hshResult = new HashMap();
		HashMap hshResult1 = new HashMap();
		HashMap hshResult2 = new HashMap();
		HashMap hshResult3 = new HashMap();
		HashMap hshResult4 = new HashMap();
		HashMap hshResult5 = new HashMap();
		HashMap hshResult6 = new HashMap();
		HashMap hshResult7 = new HashMap();
		HashMap hshResult8 = new HashMap();
		HashMap hshResult9 = new HashMap();
		HashMap hshResult10 = new HashMap();
		HashMap hshResult11 = new HashMap();
		HashMap hshResult12 = new HashMap();
		HashMap hshvalue = new HashMap();
		StringBuffer sbfsignatories = null;
		try {

			hshResult1 = new HashMap();
			hshValues.put("printdata", "print");
			hshResult1 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getGeneralinfoData");

			hshResult2 = (HashMap) getFilingLimitSanctioned(hshValues);
			hshResult3 = (HashMap) getFilingColletralSecurity(hshValues);
			hshResult4 = (HashMap) getFilingtermloan(hshValues);
			hshResult5 = (HashMap) getFilingPresentrate(hshValues);
			hshResult6 = (HashMap) get34pointspage6Data(hshValues);
			hshResult9 = (HashMap) get34pointspage4Data(hshValues);
			hshResult10 = (HashMap) getFilingregistered(hshValues);
			hshResult11 = (HashMap) getFilingDeposit(hshValues);
			hshResult12 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getAuditorsObservation");

			hshResult.put("hshValues1", hshResult1);
			hshResult.put("hshValues2", hshResult2);
			hshResult.put("hshValues3", hshResult3);
			hshResult.put("hshValues4", hshResult4);
			hshResult.put("hshValues5", hshResult5);
			hshResult.put("hshValues6", hshResult6);
			hshResult.put("hshValues9", hshResult9);
			hshResult.put("hshValues10", hshResult10);
			hshResult.put("hshValues11", hshResult11);
			hshResult.put("hshValues12", hshResult12);

			hshResult7 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getPresentPosition");
			hshResult.put("hshValues7", hshResult7);
			hshResult8 = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getBorrowerDetails");
			hshResult.put("hshValues8", hshResult8);

			hshvalue = new HashMap();
			hshValues.put("banktype", "CON");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getotherbankdues");
			hshResult.put("hshValues13", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "MUL");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getotherbankdues");
			hshResult.put("hshValues14", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "TF");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getotherbankdues");
			hshResult.put("hshValues15", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getsisterconcerndata");
			hshResult.put("hshValues16", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",hshValues, "getsignatories");
			hshResult.put("hshSignatories", hshvalue);

			sbfsignatories = new StringBuffer(correctNull((String) hshvalue.get("signatures")));
			if (sbfsignatories != null) {
				for (int i = 0; i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshResult.put("signatures", sbfsignatories.toString());
			}
			
			hshvalue = new HashMap();
			hshvalue = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getorganisationrecmmendations");
			hshResult.put("hshRecommendations", hshvalue);
			
			hshvalue = new HashMap();
			hshvalue = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getGeneralHistoryData");
			hshResult.put("hshHistory", hshvalue);
			
			hshResult.putAll(getBorrowerDetails(hshValues));
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());
		}
		return hshResult;
	}

	public HashMap getcompromisecomments(HashMap hshValues)  {

		HashMap hshResult = new HashMap();

		ResultSet rs = null;

		String strQuery = "";
		String strAppno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_compromisecomments^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("settlementproposal", correctNull(rs
						.getString("npa_otssettlementproposal")));
				hshResult.put("paymentschedule", correctNull(rs
						.getString("npa_otspaymentschedule")));
				hshResult.put("paymentsource", correctNull(rs
						.getString("npa_otspaymentsource")));
				hshResult.put("claimdetails", correctNull(rs
						.getString("npa_otsclaimdetails")));
				hshResult.put("bifrstatus", correctNull(rs
						.getString("npa_otsbifrstatus")));
				hshResult.put("nfbduestreatment", correctNull(rs
						.getString("npa_otsnfbduestreatment")));
			}

		} catch (Exception e) {
			throw new EJBException("Error in getcompromisecomments:: "
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection in getcompromisecomments :: "
								+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public void updatecompromisecomments(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "", strAction = "";

		strAction = correctNull((String) hshValues.get("hidAction"));

		try {

			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}

			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_compromisecomments");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_compromisecomments");
				arrValues.add(strAppno);

				arrValues.add(correctNull((String) hshValues.get("txt_settlementproposal")));
				arrValues.add(correctNull((String) hshValues.get("txt_paymentschedule")));
				arrValues.add(correctNull((String) hshValues.get("txt_paymentsource")));
				arrValues.add(correctNull((String) hshValues.get("txt_claimdetails")));
				arrValues.add(correctNull((String) hshValues.get("txt_bifrstatus")));
				arrValues.add(correctNull((String) hshValues.get("txt_nfbduestreatment")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_compromisecomments");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in updatecompromisecomments::  "
					+ e.getMessage());
		}

	}

	public void updatecompromisetermscond(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "", strAction = "";
		strAction = correctNull((String) hshValues.get("hidAction"));

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}

			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_otstermscond");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();

				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_otstermscond");

				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("txt_termscond")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);

				hshQuery.put("strQueryId", "del_otstermscond");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in updatecompromisetermscond :: "+ e.getMessage());
		}
	}

	public HashMap getcompromisetermscond(HashMap hshValues)
			 {
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_otstermscond^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshResult.put("termscond", Helper.CLOBToString(rs
						.getClob("npa_termscond")));
			}
		} catch (Exception e) {
			throw new EJBException("Error in getcompromisetermscond :: "
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getprudentialprint(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		HashMap hshvalue = null;
		StringBuffer sbfsignatories = null;
		try {
			hshValues.put("printdata", "print");
			hshRecord.put("appname", correctNull((String) hshValues
					.get("appname")));

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getGeneralinfoData");
			hshRecord.put("hsh1", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) getprudentialpage2Data(hshValues);
			hshRecord.put("hsh2", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getGeneralHistoryData");
			hshRecord.put("hsh3", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getPresentPosition");
			hshRecord.put("hsh4", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getSecurities");
			hshRecord.put("hsh5", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getBorrowerDetails");
			hshRecord.put("hsh6", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("selPrint", "get");
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getAuditorsObservation");
			hshRecord.put("hsh7", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "CON");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hshRecord.put("hsh8", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "MUL");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hshRecord.put("hsh9", hshvalue);

			hshvalue = new HashMap();
			hshValues.put("banktype", "TF");
			hshValues.put("appno", hshValues.get("npa_appno"));
			hshvalue = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hshRecord.put("hsh10", hshvalue);
			
			hshvalue = new HashMap();
			hshvalue = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getorganisationrecmmendations");
			hshRecord.put("hshRecommendations", hshvalue);

			hshvalue = new HashMap();
			hshvalue = (HashMap) (HashMap) EJBInvoker.executeStateLess("npacommon", hshValues, "getsignatories");
			hshRecord.put("hshSignatories", hshvalue);
			
			sbfsignatories = new StringBuffer(correctNull((String) hshvalue	.get("signatures")));
			if (sbfsignatories != null) {
				for (int i = 0; i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshRecord.put("signatures", sbfsignatories.toString());
			}

			hshRecord.putAll(getBorrowerDetails(hshValues));

		} catch (Exception ex) {
			throw new EJBException("Error in getprudentialprint :: "
					+ ex.toString());
		}
		return hshRecord;
	}

	public HashMap getNPAStatuspagePrint(HashMap hshValues)  {
		HashMap hsh1 = new HashMap();
		HashMap hsh2 = new HashMap();
		HashMap hsh3 = new HashMap();
		HashMap hsh4 = new HashMap();
		HashMap hsh5 = new HashMap();
		HashMap hsh6 = new HashMap();
		HashMap hsh7 = new HashMap();
		HashMap hsh8 = new HashMap();
		HashMap hsh9 = new HashMap();
		HashMap hsh10 = new HashMap();
		HashMap hsh11 = new HashMap();
		HashMap hsh12 = new HashMap();
		HashMap hsh13 = new HashMap();
		HashMap hsh14 = new HashMap();
		HashMap hshResult = new HashMap();
		String strquater = correctNull((String) hshValues.get("quater"));

		try {
			hsh1 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getGeneralinfoData");
			hsh2 = getstatusnotepage2Data(hshValues);
			hsh5 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getGeneralHistoryData");
			hsh10 = getstatusSuitfield(hshValues);
			hsh6 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getAuditorsObservation");
			hsh3 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getPresentPosition");
			hsh4 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getSecurities");
			hsh7 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getBorrowerDetails");
			hsh8 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getStatusnoteOTS");
			hsh9 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getStatusNoteSarfaesia");

			hshValues.put("appno", hshValues.get("npa_appno"));
			hshValues.put("banktype", "CON");
			hsh11 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hshValues.put("banktype", "MUL");
			hsh12 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hshValues.put("banktype", "TF");
			hsh13 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getotherbankdues");
			hsh14 = (HashMap) EJBInvoker.executeStateLess("npacommon",
					hshValues, "getsisterconcerndata");

			hshResult.put("hsh1", hsh1);
			hshResult.put("hsh2", hsh2);
			hshResult.put("hsh3", hsh3);
			hshResult.put("hsh4", hsh4);
			hshResult.put("hsh5", hsh5);
			hshResult.put("hsh6", hsh6);
			hshResult.put("hsh7", hsh7);
			hshResult.put("hsh8", hsh8);
			hshResult.put("hsh9", hsh9);
			hshResult.put("hsh10", hsh10);
			hshResult.put("hsh11", hsh11);
			hshResult.put("hsh12", hsh12);
			hshResult.put("hsh13", hsh13);
			hshResult.put("hsh14", hsh14);
			hshResult.put("strquater", strquater);
			hshResult.putAll(getBorrowerDetails(hshValues));
		} catch (Exception e) {
			throw new EJBException("Error in getNPAStatuspagePrint"
					+ e.getMessage());
		}
		return hshResult;

	}

	public void updateFilingtermloan(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "", strmodule_type = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		String strAction = correctNull((String) hshValues.get("hidAction"));
		strmodule_type = correctNull((String) hshValues.get("hidmoduletype"));

		String strcustid = correctNull((String) hshValues.get("cbsid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String str_term_name = correctNull((String) hshValues
				.get("txt_term_name"));
		String str_termtype = correctNull((String) hshValues
				.get("sel_termtype"));
		String str_no_instalments = correctNull((String) hshValues
				.get("txt_no_instalments"));
		String str_ins_amount = correctNull((String) hshValues
				.get("txt_ins_amount"));
		String str_start_date = correctNull((String) hshValues
				.get("txt_start_date"));
		String str_last_date = correctNull((String) hshValues
				.get("txt_last_date"));
		String str_disburse_date = correctNull((String) hshValues
				.get("txt_disburse_date"));
		String str_noinstalment_rec = correctNull((String) hshValues
				.get("txt_noinstalment_rec"));
		String str_amount_insreceived = correctNull((String) hshValues
				.get("txt_amount_insreceived"));
		String str_instale_date = correctNull((String) hshValues
				.get("txt_instale_date"));
		String str_payment_date = correctNull((String) hshValues
				.get("txt_payment_date"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("gettermloandet^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Name of term loan =" +correctNull((String)rs.getString("FIL_TERM_NAME")))
					.append("~ Date of loan first disbursed =" +correctNull((String)rs.getString("FIL_DISBURSE_DATE")))
					.append("~ Type of term loan =" +ApplicantParams.getApplicantParams("TERMLOANTYPE", correctNull((String)rs.getString("FIL_SEL_TERMTYPE"))))
					.append("~ No of instalments received =" +correctNull((String)rs.getString("FIL_REGNAMENOINSTALMENT_REC")))
					.append("~ No of instalments =" +correctNull((String)rs.getString("FIL_NO_INSTALMENTS")))
					.append("~ Amount of instalment received =" +Helper.formatDoubleValue(rs.getDouble("FIL_AMOUNT_INSRECEIVED")))
					.append("~ Instalment amount =" +Helper.formatDoubleValue(rs.getDouble("FIL_INS_AMOUNTS")))
					.append("~ Date of last instalment received =" +correctNull((String)rs.getString("FIL_INSTALMENT_DATE")))
					.append("~ Start Date =" +correctNull((String)rs.getString("FIL_START_DATE")))
					.append("~ Date from when default in payment is started =" +correctNull((String)rs.getString("FIL_PAYMENT_DATE")))
					.append("~ Last instalment date =" +correctNull((String)rs.getString("FIL_LAST_DATE")));
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfilingsuittermloan^" + strAppno + "^"
						+ strmodule_type;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("FIL_SNO"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insfilingsuittermloan");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(str_term_name);
				arrValues.add(str_termtype);
				arrValues.add(str_no_instalments);
				arrValues.add(str_ins_amount);
				arrValues.add(str_start_date);
				arrValues.add(str_last_date);
				arrValues.add(str_disburse_date);
				arrValues.add(str_noinstalment_rec);
				arrValues.add(str_amount_insreceived);
				arrValues.add(str_instale_date);
				arrValues.add(str_payment_date);
				// arrValues.add(str_legal_expenses);
				// arrValues.add(str_total_dues);
				arrValues.add(strmodule_type);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "updpfilingsuittermloan");

				arrValues.add(str_term_name);
				arrValues.add(str_termtype);
				arrValues.add(str_no_instalments);
				arrValues.add(str_ins_amount);
				arrValues.add(str_start_date);
				arrValues.add(str_last_date);
				arrValues.add(str_disburse_date);
				arrValues.add(str_noinstalment_rec);
				arrValues.add(str_amount_insreceived);
				arrValues.add(str_instale_date);
				arrValues.add(str_payment_date);
				// arrValues.add(str_legal_expenses);
				// arrValues.add(str_total_dues);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);

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
				arrValues.add(strmodule_type);
				hshQuery.put("strQueryId", "delfilingsuittermloan");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("Name of term loan =" +correctNull((String)hshValues.get("txt_term_name")))
				.append("~ Date of loan first disbursed =" +correctNull((String)hshValues.get("txt_disburse_date")))
				.append("~ Type of term loan =" +ApplicantParams.getApplicantParams("TERMLOANTYPE", correctNull((String)hshValues.get("sel_termtype"))))
				.append("~ No of instalments received =" +correctNull((String)hshValues.get("txt_noinstalment_rec")))
				.append("~ No of instalments =" +correctNull((String)hshValues.get("txt_no_instalments")))
				.append("~ Amount of instalment received =" +correctNull((String)hshValues.get("txt_amount_insreceived")))
				.append("~ Instalment amount =" +correctNull((String)hshValues.get("txt_ins_amount")))
				.append("~ Date of last instalment received =" +correctNull((String)hshValues.get("txt_instale_date")))
				.append("~ Start Date =" +correctNull((String)hshValues.get("txt_start_date")))
				.append("~ Date from when default in payment is started =" +correctNull((String)hshValues.get("txt_payment_date")))
				.append("~ Last instalment date =" +correctNull((String)hshValues.get("txt_last_date")));
			}
			AuditTrial.auditNewLog(hshValues, "395", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingtermloan"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection in updateFilingtermloan"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getFilingtermloan(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		String strmodule_type = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			strmodule_type = correctNull((String) hshValues
					.get("hidmoduletype"));
			strQuery = SQLParser.getSqlQuery("selfilingsuittermloan^"
					+ strAppno + "^" + strmodule_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("FIL_SNO")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_TERM_NAME")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_SEL_TERMTYPE")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_NO_INSTALMENTS")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_INS_AMOUNTS")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_START_DATE")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_LAST_DATE")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_DISBURSE_DATE")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_REGNAMENOINSTALMENT_REC")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_AMOUNT_INSRECEIVED")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_INSTALMENT_DATE")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_PAYMENT_DATE")));
				vecCol.add(correctNull((String) rs
						.getString("NPA_MODULE")));
				vecRow.add(vecCol);
			}

			hshRecord.put("vecRow", vecRow);
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

	public void updateFilingPresentrate(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcustid = correctNull((String) hshValues.get("cbsid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String str_nature = correctNull((String) hshValues.get("txt_nature"));
		String str_present = correctNull((String) hshValues.get("txt_present"));
		String str_dateupto = correctNull((String) hshValues
				.get("txt_dateupto"));
		String str_amountdbc = correctNull((String) hshValues
				.get("txt_amountdbc"));
		String str_datedbc = correctNull((String) hshValues.get("txt_datedbc"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				if(rs != null){
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selsuitroidet^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Present Nature =" +correctNull((String)rs.getString("fil_Nature")))
					.append("~ Present rate of interest(%) =" +correctNull((String)rs.getString("fil_Present")))
					.append("~ Date up to which interest is charged =" +correctNull((String)rs.getString("fil_Dateupto")))
					.append("~ Amount of DBC =" +Helper.formatDoubleValue(rs.getDouble("fil_Amountdbc")))
					.append("~ Date of DBC =" +correctNull((String)rs.getString("fil_Datedbc")));
				}
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfilingdbc5^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("fil_sno"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_filingdbc5");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(str_nature);
				arrValues.add(str_present);
				arrValues.add(str_dateupto);
				arrValues.add(str_amountdbc);
				arrValues.add(str_datedbc);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_filingdbc5");

				arrValues.add(str_nature);
				arrValues.add(str_present);
				arrValues.add(str_dateupto);
				arrValues.add(str_amountdbc);
				arrValues.add(str_datedbc);

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
				// arrValues.add(strmodule_type);
				hshQuery.put("strQueryId", "del_filingdbc5");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("Present Nature =" +correctNull((String) hshValues.get("txt_nature")))
				.append("~ Present rate of interest(%) =" +correctNull((String) hshValues.get("txt_present")))
				.append("~ Date up to which interest is charged =" +correctNull((String) hshValues.get("txt_dateupto")))
				.append("~ Amount of DBC =" +correctNull((String) hshValues.get("txt_amountdbc")))
				.append("~ Date of DBC =" +correctNull((String) hshValues.get("txt_datedbc")));
			}
			AuditTrial.auditNewLog(hshValues, "399", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingPresentRate"
					+ e.getMessage());
		}
	}

	public HashMap getFilingPresentrate(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_filingdbc5^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("fil_sno")));
				vecCol.add(correctNull((String) rs
						.getString("fil_Nature")));
				vecCol.add(correctNull((String) rs
						.getString("fil_Present")));
				vecCol.add(correctNull((String) rs
						.getString("fil_Dateupto")));
				vecCol.add(correctNull((String) rs
						.getString("fil_Amountdbc")));
				vecCol.add(correctNull((String) rs
						.getString("fil_Datedbc")));

				// vecCol.add(correctNull((String)rs.getString("NPA_MODULE")));
				vecRow.add(vecCol);
			}

			hshRecord.put("vecRow", vecRow);
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

	public void updateFilingLimitSanctioned(HashMap hshValues)
			 {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcustid = correctNull((String) hshValues.get("cbsid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String str_nature_facility = correctNull((String) hshValues
				.get("nature_facilty"));
		String str_amount = correctNull((String) hshValues.get("txt_amount"));
		String str_rateofinterst = correctNull((String) hshValues
				.get("txt_rateofinterst"));
		String str_securitydoc = correctNull((String) hshValues
				.get("txt_securitydoc"));
		String str_dateofdocument = correctNull((String) hshValues
				.get("txt_dateofdocument"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("selsanclimitdet^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Nature of Facility(ies) =" +correctNull((String)rs.getString("facility")))
					.append("~ Amount =" +Helper.formatDoubleValue(rs.getDouble("FIL_AMOUNT")))
					.append("~ Security/ documents obtained =" +correctNull((String)rs.getString("FIL_SECURITY")))
					.append("~ Rate of interest(%) =" +correctNull((String)rs.getString("FIL_RATEOFINTERST")))
					.append("~ Date of documents obtained =" +correctNull((String)rs.getString("FIL_DATEOFDOCUMENT")));
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfiling_sanction^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("fil_sno"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_filing_sanction");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(str_nature_facility);
				arrValues.add(str_amount);
				arrValues.add(str_rateofinterst);
				arrValues.add(str_securitydoc);
				arrValues.add(str_dateofdocument);

				// arrValues.add(str_legal_expenses);
				// arrValues.add(str_total_dues);
				// arrValues.add(strmodule_type);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_filing_sanction");

				arrValues.add(str_nature_facility);
				arrValues.add(str_amount);
				arrValues.add(str_rateofinterst);
				arrValues.add(str_securitydoc);
				arrValues.add(str_dateofdocument);

				// arrValues.add(str_legal_expenses);
				// arrValues.add(str_total_dues);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				// arrValues.add(strmodule_type);

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
				// arrValues.add(strmodule_type);
				hshQuery.put("strQueryId", "del_filing_sanction");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("Nature of Facility(ies) =" +correctNull((String)hshValues.get("hidfacility")))
				.append("~ Amount =" +correctNull((String)hshValues.get("txt_amount")))
				.append("~ Security/ documents obtained =" +correctNull((String)hshValues.get("txt_securitydoc")))
				.append("~ Rate of interest(%) =" +correctNull((String)hshValues.get("txt_rateofinterst")))
				.append("~ Date of documents obtained =" +correctNull((String)hshValues.get("txt_dateofdocument")));
			}
			AuditTrial.auditNewLog(hshValues, "394", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingLimitSanctioned"
					+ e.getMessage());
		}
	}

	public HashMap getFilingLimitSanctioned(HashMap hshValues)
			 {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_filing_sanction^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("FIL_SNO")));
				vecCol.add(correctNull((String) rs
						.getString("stat_data_desc1")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_AMOUNT")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_RATEOFINTERST")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_SECURITY")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_DATEOFDOCUMENT")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_NATURE_FACILITY")));

				// vecCol.add(correctNull((String)rs.getString("NPA_MODULE")));
				vecRow.add(vecCol);
			}

			hshRecord.put("vecRow", vecRow);

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

	public HashMap checkOLDApplication(HashMap hshValues)  {
		HashMap hshResult = new HashMap();
		HashMap hshAppdata = new HashMap();
		String strQuery = "";
		String strCbsid = correctNull((String) hshValues.get("cbsid"));
		String strModuletype = correctNull((String) hshValues.get("moduletype"));
		ResultSet rs = null;
		String exiAppno = "";
		String strStatusAppno = "";
		String comments = "";
		String apptype = correctNull((String) hshValues.get("hidborrowertype"));
		String flag = "Y";

		try {
			if (!strModuletype.equalsIgnoreCase("STAT")) {
				strQuery = SQLParser.getSqlQuery("getnpaappstatus^" + strCbsid
						+ "^" + strModuletype);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					exiAppno = correctNull((String) rs.getString("npa_appno"));
					if (!exiAppno.equalsIgnoreCase("")) {
						flag = "N";
						comments = "Cannot Generate New Application Untill existing application is Processed Approved/Rejected";
					}
					hshResult.put("exist_appno", exiAppno);
				}

				strQuery = SQLParser.getSqlQuery("sel_MaxNPAstatApplnNo^"
						+ strCbsid + "^" + "C" + "^"
						+ " and npa_status='ca' and npa_demoappno=npa_appno");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strStatusAppno = correctNull(rs.getString("npa_appno"));
				}
				if (strStatusAppno.equalsIgnoreCase("")) {
					strQuery = SQLParser.getSqlQuery("sel_MaxNPAstatApplnNo^"
							+ strCbsid + "^" + "C" + "^"
							+ " and npa_demoappno=npa_appno");
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strStatusAppno = correctNull(rs.getString("npa_appno"));
					}
					if (strStatusAppno.equalsIgnoreCase("")) {
						comments = "Cannot Create a new Application Since You have not created the Status note";
					} else {
						comments = "Cannot Create a new Application Since You have not Freezed the Status note";
					}

				}
				hshResult.put("comments", comments);
			}

			hshAppdata.put("customername", correctNull((String) hshValues
					.get("appno")));
			hshAppdata.put("npaappno", correctNull((String) hshValues
					.get("appno")));
			hshAppdata.put("cbsid", strCbsid);
			hshAppdata.put("status", "op");
			hshAppdata.put("demoapptype", apptype);
			hshAppdata.put("moduletype", strModuletype);
			hshAppdata.put("btnenable", "Y");

			hshResult.put("hshAppdata", hshAppdata);
			hshResult.put("flag", flag);
		} catch (Exception e) {
			throw new EJBException("Error in getNPAStatuspagePrint"
					+ e.getMessage());
		}
		return hshResult;
	}

	public void updateFilingColletralSecurity(HashMap hshValues)
			 {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("npa_appno"));
		}

		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcustid = correctNull((String) hshValues.get("cbsid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String str_location = correctNull((String) hshValues
				.get("txt_location"));
		String str_descript = correctNull((String) hshValues
				.get("txt_descript"));
		String str_owner = correctNull((String) hshValues.get("txt_owner"));
		String str_date = correctNull((String) hshValues.get("txt_date"));
		String str_security_type = correctNull((String) hshValues
				.get("security_type"));
		String txt_present_security = correctNull((String) hshValues
				.get("txt_present_security"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("selfilingsecuritiesdet^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Type of Security ="+ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull((String)rs.getString("security_type"))))
					.append("~ Location ="+correctNull((String)rs.getString("fil_location")))
					.append("~ Description ="+correctNull((String)rs.getString("fil_descript")))
					.append("~ Owner of the Property ="+correctNull((String)rs.getString("fil_owner")))
					.append("~ Date of EM ="+correctNull((String)rs.getString("fil_date")));
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfilingsuitcollsecurity^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("fil_sno"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_filingsuitcollsecurity");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(str_location);
				arrValues.add(str_descript);
				arrValues.add(str_owner);
				arrValues.add(str_date);
				arrValues.add(str_security_type);
				arrValues.add(txt_present_security);

				// arrValues.add(str_dateofdocument);

				// arrValues.add(str_legal_expenses);
				// arrValues.add(str_total_dues);
				// arrValues.add(strmodule_type);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_filingsuitcollsecurity");

				arrValues.add(str_location);
				arrValues.add(str_descript);
				arrValues.add(str_owner);
				arrValues.add(str_date);
				arrValues.add(str_security_type);
				arrValues.add(txt_present_security);

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
				// arrValues.add(strmodule_type);
				hshQuery.put("strQueryId", "del_filingsuitcollsecurity");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("Type of Security ="+ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull((String)hshValues.get("security_type"))))
				.append("~ Location ="+correctNull((String)hshValues.get("txt_location")))
				.append("~ Description ="+correctNull((String)hshValues.get("txt_descript")))
				.append("~ Owner of the Property ="+correctNull((String)hshValues.get("txt_owner")))
				.append("~ Date of EM ="+correctNull((String)hshValues.get("txt_date")));
			}
			AuditTrial.auditNewLog(hshValues, "397", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingColletralSecurity"
					+ e.getMessage());
		}
	}

	public HashMap getFilingColletralSecurity(HashMap hshValues)
			 {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		String strrecords = "N";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_filingsuitcollsecurity^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("fil_sno")));
				vecCol.add(correctNull((String) rs
						.getString("fil_location")));
				vecCol.add(correctNull((String) rs
						.getString("fil_descript")));
				vecCol.add(correctNull((String) rs
						.getString("fil_owner")));
				vecCol
						.add(correctNull((String) rs
								.getString("fil_date")));
				vecCol.add(correctNull((String) rs
						.getString("security_type")));
				vecCol.add(correctNull((String) rs
						.getString("present_security")));
				vecRow.add(vecCol);
				if (correctNull((String) rs.getString("security_type")).equals(
						"2"))
					strrecords = "Y";
			}

			hshRecord.put("vecRow", vecRow);
			hshRecord.put("strrecords", strrecords);
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

	public void updateFilingregistered(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("npa_appno"));
		}
		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcustid = correctNull((String) hshValues.get("cbs_custid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String strregname = correctNull((String) hshValues.get("txt_regname"));
		String strregdate = correctNull((String) hshValues.get("txt_regdate"));
		String strregamount = correctNull((String) hshValues
				.get("txt_regamount"));
		String strregcharges = correctNull((String) hshValues
				.get("txt_regcharges"));

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfilingsuit22^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("fil_sno"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_filingsuit22");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(strregname);
				arrValues.add(strregdate);
				arrValues.add(strregamount);
				arrValues.add(strregcharges);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_filingsuit22");

				arrValues.add(strregname);
				arrValues.add(strregdate);
				arrValues.add(strregamount);
				arrValues.add(strregcharges);

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

				hshQuery.put("strQueryId", "del_filingsuit22");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingregistered"
					+ e.getMessage());
		}
	}

	public HashMap getFilingregistered(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		String strRecord = "N";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}
		try {
			strQuery = SQLParser.getSqlQuery("sel_filingsuit22^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("fil_sno")));
				vecCol.add(correctNull((String) rs
						.getString("fil_regname")));
				vecCol.add(correctNull((String) rs
						.getString("fil_regdate")));
				vecCol.add(correctNull((String) rs
						.getString("fil_regamount")));
				vecCol.add(correctNull((String) rs
						.getString("fil_regcharges")));

				vecRow.add(vecCol);
				strRecord = "Y";
			}

			hshRecord.put("vecRow", vecRow);
			hshRecord.put("strRecord", strRecord);
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

	/*
	 * For getting the total points scored by the proposal author @ :
	 * Sureshkumar Ganapathy
	 * 
	 */
	public HashMap getEvaluationscores(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();

		ResultSet rs = null;

		String StrAppno = "";
		String StrQuery = "";
		String strMarketabilityofsecurity = "";
		String strLegalposition = "";
		String MarketDesc = "";
		String LegalDesc = "";

		double dblCrystaliseddues = 0.0;
		double dblnpaage = 0.0;
		double dblsecurityvalue = 0.0;
		double dblaggrmeans = 0.0;

		int realisiblepoint = 0;
		int aggregatepoint = 0;
		int ageofnpapoint = 0;
		int legalpoint = 0;
		try {

			StrAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (StrAppno.equalsIgnoreCase("")) {
				StrAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strMarketabilityofsecurity = correctNull((String) hshValues
					.get("marketabilityofsec"));
			StrQuery = SQLParser.getSqlQuery("getstaticdesc^28^"
					+ strMarketabilityofsecurity);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				MarketDesc = correctNull(rs.getString("stat_data_desc1"));
			}
			hshRecord.put("MarketDesc", MarketDesc);
			strLegalposition = correctNull((String) hshValues
					.get("legalposition"));
			if (rs != null)
				rs.close();
			StrQuery = SQLParser.getSqlQuery("getstaticdesc^29^"
					+ strLegalposition);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				LegalDesc = correctNull(rs.getString("stat_data_desc1"));
			}
			hshRecord.put("LegalDesc", LegalDesc);

			dblCrystaliseddues = Double.parseDouble(Helper
					.correctDouble((String) hshValues.get("crystaliseddues")));
			/*
			 * For getting age of npa for the account
			 */
			if (rs != null)
				rs.close();
			StrQuery = SQLParser.getSqlQuery("selnpage_npacompromisepage1^"
					+ StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				dblnpaage = (Double.parseDouble(Helper.correctDouble(rs
						.getString("ageofnpa"))));
			}
			hshRecord.put("AgeofNPA", Helper.formatDoubleValue(dblnpaage));
			if (rs != null)
				rs.close();
			/*
			 * For getting present total security value for the proposal
			 */
			StrQuery = SQLParser.getSqlQuery("selsecurityvalue^" + StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				dblsecurityvalue = Double.parseDouble(Helper.correctDouble(rs
						.getString("presentvalue")));
			}
			if (rs != null)
				rs.close();
			/*
			 * For getting the aggregate means of applicants and guarantors
			 */
			StrQuery = SQLParser.getSqlQuery("selaggregatemeans^" + StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				dblaggrmeans = Double.parseDouble(Helper.correctDouble(rs
						.getString("aggregatemeans")));
			}
			hshRecord.put("AggregateMeans", Helper
					.formatDoubleValue(dblaggrmeans));
			/*
			 * For getting the points scored in Realisable value of security
			 */
			double dbltemp = 0.0;
			if (dblCrystaliseddues != 0)
				dbltemp = (dblsecurityvalue / dblCrystaliseddues) * 100.0;
			if (rs != null)
				rs.close();

			StrQuery = SQLParser.getSqlQuery("selpointforrealisable^ <= "
					+ Helper.formatDoubleValue(dbltemp) + "^ >= "
					+ Helper.formatDoubleValue(dbltemp) + "^"
					+ strMarketabilityofsecurity);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {

				hshRecord.put("realisiblepoint", correctNull(rs
						.getString("points")));
				realisiblepoint = Integer.parseInt(Helper.correctDouble(rs
						.getString("points")));
			}

			/*
			 * For getting the points scored through Aggregate Means
			 */
			dbltemp = 0.0;
			if (dblCrystaliseddues != 0)
				dbltemp = dblaggrmeans / dblCrystaliseddues * 100;
			hshRecord.put("aggregatemeansparticulars", Helper
					.formatDoubleValue(dbltemp));
			if (rs != null)
				rs.close();

			StrQuery = SQLParser.getSqlQuery("selpointformeans^ <= " + dbltemp
					+ "^ >= " + dbltemp);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				hshRecord.put("aggregatemeanspoint", correctNull(rs
						.getString("points")));
				aggregatepoint = Integer.parseInt(Helper.correctDouble(rs
						.getString("points")));
			}

			/*
			 * For getting the points scored through Age of NPA
			 */
			if (rs != null)
				rs.close();

			StrQuery = SQLParser.getSqlQuery("selpointofnpage^ <= " + dblnpaage
					+ "^ >= " + dblnpaage);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				hshRecord.put("ageofnpapoints", correctNull(rs
						.getString("npa_point")));
				ageofnpapoint = Integer.parseInt(Helper.correctDouble(rs
						.getString("npa_point")));
			}

			/*
			 * For getting the points scored through Legal position of bank
			 */
			if (rs != null)
				rs.close();

			StrQuery = SQLParser
					.getSqlQuery("sel_npalegal^" + strLegalposition);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				hshRecord.put("legalpositionpoint", correctNull(rs
						.getString("npa_point")));
				legalpoint = Integer.parseInt(Helper.correctDouble(rs
						.getString("npa_point")));
			}
			int totalscore = realisiblepoint + aggregatepoint + ageofnpapoint
					+ legalpoint;
			hshRecord.put("totalscore", Integer.toString(totalscore));

		} catch (Exception ex) {
			throw new EJBException("Error in getEvaluationscores :: "
					+ ex.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception exp) {
				throw new EJBException("Error in closing Connection :: "
						+ exp.toString());
			}
		}

		return hshRecord;
	}

	public HashMap getCompromiseReliefSought(HashMap hshValues)
			 {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		String StrAppno = "";
		String StrQuery = "";
		String strmoduletype = "";

		/*
		 * Fields created by Sureshkumar for Without Writeoff & Ecgc cleimed
		 * 
		 */

		String strecgcclaimed = "2";
		String strwriteoff = "2";

		double dblrunningledgeros = 0.0;
		double dblwriteoffamt = 0.0;
		double dblunrecoveredint = 0.0;
		double dblnetdues = 0.0;
		double dbldummyledgeros = 0.0;
		double dbllegalexpenses = 0.0;
		double dbltotaldues = 0.0;
		double dblgrosssettlementamt = 0.0;
		double dblnetsettlementamt = 0.0;
		double dbltempsettlementamt = 0.0;
		double dblsacrificeamt = 0.0;
		double dblsacwriteoffamount = 0.0;
		double dblwsacaiveramt = 0.0;
		double dblsaclegalexpenses = 0.0;
		double dblnotionalos = 0.0;
		double dblrunningos = 0.0;
		double dbltotnotionalinterest = 0.0;

		double dblContractualtotdues = 0.0;
		double dblNotionaltotdues = 0.0;
		double dblContractualsacrificeamt = 0.0;
		double dblNotionalsacrificeamt = 0.0;
		try {
			StrAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (StrAppno.equalsIgnoreCase("")) {
				StrAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strmoduletype = correctNull((String) hshValues.get("hidmoduletype"));

			if (rs != null) {
				rs.close();
			}
			StrQuery = SQLParser.getSqlQuery("sel_npageneralinfo^" + StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				if (correctNull(rs.getString("npagen_propfor"))
						.equalsIgnoreCase("1"))
					dblgrosssettlementamt = Double.parseDouble(Helper
							.correctDouble(rs
									.getString("npagen_propcounteramt")));
				else if (correctNull(rs.getString("npagen_propfor"))
						.equalsIgnoreCase("2"))
					dblgrosssettlementamt = Double.parseDouble(Helper
							.correctDouble(rs.getString("npagen_propamt")));

				strecgcclaimed = correctNull(rs.getString("npagen_ecgcclaim"));
				strwriteoff = correctNull(rs.getString("npagen_pwo"));
			}

			if (rs != null)
				rs.close();

			StrQuery = SQLParser.getSqlQuery("selpresentpositiontotal^"
					+ StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				dblrunningledgeros = Double.parseDouble(Helper.correctDouble(rs
						.getString("runningos")));
				dblwriteoffamt = Double.parseDouble(Helper.correctDouble(rs
						.getString("prudentailamt")));
				dblunrecoveredint = Double.parseDouble(Helper.correctDouble(rs
						.getString("unrecoveredint")));
				dblnetdues = Double.parseDouble(Helper.correctDouble(rs
						.getString("netdues")));
				dbldummyledgeros = Double.parseDouble(Helper.correctDouble(rs
						.getString("dummyledgeros")));
				dbllegalexpenses = Double.parseDouble(Helper.correctDouble(rs
						.getString("legalotrexp")));
				dbltotaldues = Double.parseDouble(Helper.correctDouble(rs
						.getString("totaldues")));
				dbltotnotionalinterest = Double.parseDouble(Helper
						.correctDouble(rs.getString("totnotionalinterest")));
			}
			dblnotionalos = dblrunningledgeros + dblwriteoffamt;
			// With ECGC Claimed

			if (strecgcclaimed.equalsIgnoreCase("1")) {
				double dblosatclaim = 0.0;
				double dblclaimsettled = 0.0;
				double dblosclaimsetted = 0.0;
				double dblfacsettlementamt = 0.0;
				double dblrefundamt = 0.0;
				double dblclaimretaintedamt = 0.0;
				double dblprudentialwriteoffamt = 0.0;
				double dblfacnotionalos = 0.0;

				StrQuery = SQLParser.getSqlQuery("selpresentposition^"
						+ StrAppno + "^" + strmoduletype);
				rs = DBUtils.executeQuery(StrQuery);
				while (rs.next()) {
					dblrunningos = Double.parseDouble(Helper.correctDouble(rs
							.getString("PRE_RUNNING_OUTSTAND")));
					dblprudentialwriteoffamt = Double.parseDouble(Helper
							.correctDouble(rs.getString("PRE_PRODENTIAL")));
					dblfacnotionalos = dblrunningos + dblprudentialwriteoffamt;
					dblosatclaim = Double.parseDouble(Helper.correctDouble(rs
							.getString("pre_claimlodgedos")));
					if (strwriteoff.equalsIgnoreCase("1")) {
						dblclaimsettled = Double
								.parseDouble(Helper.correctDouble(rs
										.getString("pre_claimsettled")));
						if (dblosatclaim != 0) {
							dblosclaimsetted = (dblclaimsettled / dblosatclaim) * 100.0;
						} else {
							dblosclaimsetted = 0.0;
						}
						dblclaimsettled = Double.parseDouble(Helper
								.correctDouble(rs.getString("PRE_ECGC_CLAIM")));
					} else {
						dblclaimsettled = Double
								.parseDouble(Helper.correctDouble(rs
										.getString("pre_claimsettled")));
						if (dblosatclaim != 0) {
							dblosclaimsetted = (dblclaimsettled / dblosatclaim) * 100.0;
						} else {
							dblosclaimsetted = 0.0;
						}
					}

					// dblosclaimsetted=(dblclaimsettled/dblosatclaim)*100.0;
					if (dblnotionalos != 0.0
							&& (dblgrosssettlementamt - dbllegalexpenses) != 0.0)
						dblfacsettlementamt = dblfacnotionalos / dblnotionalos
								* (dblgrosssettlementamt - dbllegalexpenses);

					if (((dblfacsettlementamt * dblosclaimsetted) / 100) > dblclaimsettled) {
						dblrefundamt = dblclaimsettled;
					} else {
						dblrefundamt = (dblfacsettlementamt * dblosclaimsetted) / 100;
					}
					dblclaimretaintedamt = dblclaimsettled - dblrefundamt;
					if (dblnotionalos != 0) {
						dbltempsettlementamt = dbltempsettlementamt
								+ dblclaimretaintedamt
								+ dblfacsettlementamt
								+ (dbllegalexpenses / dblnotionalos * dblfacnotionalos);
					} else {
						dbltempsettlementamt = dbltempsettlementamt
								+ dblclaimretaintedamt + dblfacsettlementamt;
					}
				}
				if (strwriteoff.equalsIgnoreCase("1")) {
					/*
					 * The procedure for With ECGC claimed and with write off
					 */
					dblnetsettlementamt = dbltempsettlementamt;

				} else if (strwriteoff.equalsIgnoreCase("2")) {
					/*
					 * The procedure for With ECGC claimed and with out write
					 * off
					 */
					dblnetsettlementamt = dbltempsettlementamt;
				}
			} else if (strecgcclaimed.equalsIgnoreCase("2")) {
				if (strwriteoff.equalsIgnoreCase("1")) {
					/*
					 * procedure for With out ECGC claimed and with write off
					 */

					dblnetsettlementamt = dblgrosssettlementamt;

				} else if (strwriteoff.equalsIgnoreCase("2")) {
					/*
					 * Procedure for With out ECGC claimed and with out write
					 * off
					 */
					dblnetsettlementamt = dblgrosssettlementamt;

				}
			}

			dblContractualtotdues = dblnotionalos - dblunrecoveredint
					+ dbldummyledgeros + dbllegalexpenses;
			dblNotionaltotdues = dblnotionalos - dblunrecoveredint
					+ dbltotnotionalinterest + dbllegalexpenses;

			// to calculate the sacrifice amount

			// dblsacrificeamt=dbltotaldues-dblnetsettlementamt;
			dblContractualsacrificeamt = dblContractualtotdues
					- dblnetsettlementamt;
			dblNotionalsacrificeamt = dblNotionaltotdues - dblnetsettlementamt;

			// To find the write off amount for settlemet
			if (dblnetsettlementamt > dblnetdues)
				dblsacwriteoffamount = 0;
			else
				dblsacwriteoffamount = dblnetdues - dblnetsettlementamt;

			// To calculate the sacrifice legal expenses

			if (dblsacwriteoffamount > 0)
				dblsaclegalexpenses = dbllegalexpenses;
			else if ((dblnetsettlementamt - dblnetdues) > dbllegalexpenses)
				dblsaclegalexpenses = 0;
			else
				dblsaclegalexpenses = dbllegalexpenses - dblnetsettlementamt
						+ dblnetdues;

			// to calculate the sacrifice waiver amount
			// dblwsacaiveramt=dblsacrificeamt-dblsacwriteoffamount-dblsaclegalexpenses;
			dblwsacaiveramt = dblContractualsacrificeamt - dblsacwriteoffamount
					- dblsaclegalexpenses;

			// For Nan Error
			String strsaclegalexpenses = Helper
					.formatDoubleValue(dblsaclegalexpenses);
			if (strsaclegalexpenses.equalsIgnoreCase("NaN")) {
				strsaclegalexpenses = "0.00";
			}
			String strwaiveramt = Helper.formatDoubleValue(dblwsacaiveramt);
			if (strwaiveramt.equalsIgnoreCase("NaN"))
				strwaiveramt = "0.00";
			String strsettlementamt = Helper
					.formatDoubleValue(dblnetsettlementamt);
			if (strsettlementamt.equalsIgnoreCase("NaN"))
				strsettlementamt = "0.00";

			String strsacrificewriteoff = Helper
					.formatDoubleValue(dblsacwriteoffamount);
			if (strsacrificewriteoff.equalsIgnoreCase("NaN")) {
				strsacrificewriteoff = "0.00";
			}
			/*
			 * String strsacrificeamt=Helper.formatDoubleValue(dblsacrificeamt);
			 * if(strsacrificeamt.equalsIgnoreCase("NaN")) {
			 * strsacrificeamt="0.00"; }
			 */
			hshRecord.put("runningoutstanding", Helper
					.formatDoubleValue(dblnotionalos));
			hshRecord.put("unrecoveredint", Helper
					.formatDoubleValue(dblunrecoveredint));
			hshRecord.put("netdues", Helper.formatDoubleValue(dblnetdues));
			hshRecord.put("dummyamt", Helper
					.formatDoubleValue(dbldummyledgeros));
			hshRecord.put("legalotrexp", Helper
					.formatDoubleValue(dbllegalexpenses));
			// hshRecord.put("totaldues",Helper.formatDoubleValue(dbltotaldues));
			hshRecord.put("settlementamt", strsettlementamt);
			// hshRecord.put("sacrificeamt",strsacrificeamt);
			hshRecord.put("sacrificewriteoff", strsacrificewriteoff);// No
																		// change
			hshRecord.put("waiveramt", strwaiveramt);// the sacrificeamt is
														// changed
			hshRecord.put("saclegalexpenses", strsaclegalexpenses);// No change
			hshRecord.put("totnotionalinterest", Helper
					.formatDoubleValue(dbltotnotionalinterest));

			hshRecord.put("Contractualtotdues", Helper
					.formatDoubleValue(dblContractualtotdues));
			hshRecord.put("Notionaltotdues", Helper
					.formatDoubleValue(dblNotionaltotdues));
			hshRecord.put("Contractualsacrificeamt", Helper
					.formatDoubleValue(dblContractualsacrificeamt));
			hshRecord.put("Notionalsacrificeamt", Helper
					.formatDoubleValue(dblNotionalsacrificeamt));

			if (rs != null)
				rs.close();
			StrQuery = SQLParser.getSqlQuery("sel_npareliefsought^" + StrAppno);
			rs = DBUtils.executeQuery(StrQuery);
			if (rs.next()) {
				hshRecord.put("npa_runningledgerdate", correctNull(rs
						.getString("npa_runningledgerdate")));
			}
			if (rs != null) {
				rs.close();
			}
			/*
			 * StrQuery=SQLParser.getSqlQuery("selpresentposition^"+StrAppno);
			 * rs=DBUtils.executeQuery(StrQuery); if(rs.next()) {
			 * hshRecord.put("pre_notionalinterest",correctNull(rs.getString("pre_notionalinterest"))); }
			 */
		} catch (Exception ae) {
			throw new EJBException("Error in getCompromiseReliefSought :: "
					+ ae.toString());
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

	public void updateCompromiseReliefSought(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAppno = "";
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			String strAction = correctNull((String) hshValues.get("hidAction"));
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_npareliefsought");
				arrValues.add(strAppno);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_npareliefsought");
				arrValues.add(strAppno);
				arrValues
						.add(correctNull((String) hshValues.get("ledger_date")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_runningledger1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_runningledger2")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_unrecovered1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_unrecovered2")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_netdues1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_netdues2")));
				arrValues.add(correctNull((String) hshValues
						.get("dummyledger_from")));
				arrValues.add(correctNull((String) hshValues
						.get("dummyledger_to")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_unappliedinterest1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_unappliedinterest2")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_Legalexpenses1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_Legalexpenses2")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_Totaldues1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_Totaldues2")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_settlementamt1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_settlementamt2")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_sacrifice1")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_sacrifice2")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_writeoff")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_waiver")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_absorption")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				if (strAction.equalsIgnoreCase("delete")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);

					hshQuery.put("strQueryId", "del_npareliefsought");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
			}
		} catch (Exception ae) {
			throw new EJBException("Error in updateCompromiseReliefSought :: "
					+ ae.toString());
		}

	}

	public HashMap getCompromiseModulardues(HashMap hshValues)
			 {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;

		String strQuery = "";
		String strAppno = "";
		double dblminamt = 0.0;
		double dblmaxamt = 0.0;
		double dblminpercent = 0.0;
		double dblmaxpercent = 0.0;
		double dblroi = 0.0;
		double dblOSAmt = 0.0;
		double dblminintamt = 0.0;
		double dblmaxintamt = 0.0;
		double dblsettlementamt = 0.0;
		double dblscoreobtained = 0;
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_otsevaluation^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblscoreobtained = Double.parseDouble(Helper.correctDouble(rs
						.getString("npa_otsnetscore")));
			}
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selpresentpositiontotal^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblOSAmt = Double.parseDouble(Helper.correctDouble((String) rs
						.getString("subtotal")));
			}
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selamountforpoints^<="
					+ dblscoreobtained + "^>=" + dblscoreobtained);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblminpercent = Double.parseDouble(Helper.correctDouble(rs
						.getString("npamehod_minledger")));
				dblmaxpercent = Double.parseDouble(Helper.correctDouble(rs
						.getString("npamehod_maxledger")));
				dblroi = Double.parseDouble(Helper.correctDouble(rs
						.getString("npamethd_rateinterest")));
			}
			dblminamt = dblminpercent * dblOSAmt / 100;
			dblmaxamt = dblmaxpercent * dblOSAmt / 100;
			dblminintamt = dblminamt * dblroi / 100;
			dblmaxintamt = dblmaxamt * dblroi / 100;
			dblminamt = dblminamt + dblminintamt;
			dblmaxamt = dblmaxamt + dblmaxintamt;

			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("sel_npageneralinfo^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if (correctNull(rs.getString("npagen_propfor"))
						.equalsIgnoreCase("2"))
					dblsettlementamt = Double.parseDouble(Helper
							.correctDouble(rs.getString("npagen_propamt")));
				else if (correctNull(rs.getString("npagen_propfor"))
						.equalsIgnoreCase("1"))
					dblsettlementamt = Double.parseDouble(Helper
							.correctDouble(rs
									.getString("npagen_propcounteramt")));
			}

			if (dblsettlementamt < dblminamt)
				hshRecord.put("deviationany", "Y");
			else
				hshRecord.put("deviationany", "N");
			hshRecord.put("moduleminamt", Helper.formatDoubleValue(dblminamt));
			hshRecord.put("modulemaxamt", Helper.formatDoubleValue(dblmaxamt));
			hshRecord.put("settlementamt", Helper
					.formatDoubleValue(dblsettlementamt));
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selmodulardues^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("deviationreason", correctNull(rs
						.getString("npa_otscodeviationreason")));
				hshRecord.put("bplr",
						correctNull(rs.getString("npa_otscobplr")));
				hshRecord.put("noofyears", correctNull(rs
						.getString("npa_otsconoofyears")));
				hshRecord.put("costofrealisation", correctNull(rs
						.getString("npa_otscorealisationcost")));
				hshRecord.put("npvsecurities", correctNull(rs
						.getString("npa_otsconpvsecurities")));
				hshRecord.put("netnpv", correctNull(rs
						.getString("npa_otsconetnpv")));
				hshRecord.put("AuditFlag", "Y");
			}
			else
			{
				hshRecord.put("AuditFlag", "N");
			}

		} catch (Exception exp) {
			throw new EJBException(
					"Error in getting data from getCompromiseModulardues :: "
							+ exp.toString());
		}
		return hshRecord;
	}

	public void updateCompromiseModulardues(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "";
		String strAction = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strAction = correctNull((String) hshValues.get("hidAction"));

			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "delmodulardues");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "insmodulardues");

				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("txtdeviationreason")));
				arrValues.add(correctNull((String) hshValues.get("txtroi")));
				arrValues.add(correctNull((String) hshValues
						.get("txtnoofyears")));
				arrValues.add(correctNull((String) hshValues
						.get("txtrealisationcost")));
				arrValues.add(correctNull((String) hshValues
						.get("txtminmoduleamt")));
				arrValues.add(correctNull((String) hshValues
						.get("txtmaxmoduleamt")));
				arrValues.add(correctNull((String) hshValues
						.get("txtnpvsecurities")));
				arrValues.add(correctNull((String) hshValues.get("txtnetnpv")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "delmodulardues");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert")){
				sbAuditData
				.append("Amount Payable as per Module Minimum =" +correctNull((String)hshValues.get("txtminmoduleamt")))
				.append("~ Amount Payable as per Module Maximum =" +correctNull((String)hshValues.get("txtmaxmoduleamt")))
				.append("~ Settlement amount offered =" +correctNull((String)hshValues.get("txtsetlementamt")));
			}
			AuditTrial.auditLog(hshValues, "380", strAppno, sbAuditData.toString());

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public void updateFilingDeposit(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = correctNull((String) hshValues.get("appno"));
		if (strAppno.equals("")) {
			strAppno = correctNull((String) hshValues.get("npa_appno"));
		}

		String strAction = correctNull((String) hshValues.get("hidAction"));

		String strcustid = correctNull((String) hshValues.get("cbsid"));

		strsno = correctNull((String) hshValues.get("hid_strsno"));
		String str_facility = correctNull((String) hshValues
				.get("txt_facility"));
		String str_amount = correctNull((String) hshValues.get("txt_amount"));
		String str_detailsremit = correctNull((String) hshValues
				.get("txt_detailsremit"));
		String str_date = correctNull((String) hshValues.get("txt_date"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try {
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				if(rs!= null){
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("getsuitrecovdet^"+strAppno+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Facility ="+correctNull((String)rs.getString("FIL_FACILITY")))
					.append("~ Date of remittance ="+correctNull((String)rs.getString("FIL_DATE")))
					.append("~ Amount deposited ="+Helper.formatDoubleValue(rs.getDouble("FIL_AMOUNT")));
				}
			}
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxfilingsuitdeposit^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = correctNull((String) rs.getString("fil_sno"));
				}

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_filingsuitdeposit");
				arrValues.add(strAppno);
				arrValues.add(strcustid);
				arrValues.add(strsno);

				arrValues.add(str_facility);
				arrValues.add(str_amount);
				arrValues.add(str_detailsremit);
				arrValues.add(str_date);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_filingsuitdeposit");

				arrValues.add(str_facility);
				arrValues.add(str_amount);
				arrValues.add(str_detailsremit);
				arrValues.add(str_date);

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

				hshQuery.put("strQueryId", "del_filingsuitdeposit");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
					.append("Facility ="+correctNull((String) hshValues.get("txt_facility")))
					.append("~ Date of remittance ="+correctNull((String) hshValues.get("txt_date")))
					.append("~ Amount deposited ="+correctNull((String) hshValues.get("txt_amount")));
				
			}
			AuditTrial.auditNewLog(hshValues, "400", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			
		} catch (Exception e) {
			throw new EJBException("Error in updateFilingDeposit"
					+ e.getMessage());
		}
	}

	public HashMap getFilingDeposit(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			strQuery = SQLParser.getSqlQuery("sel_filingsuitdeposit^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol
						.add(correctNull((String) rs
								.getString("FIL_SNO")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_FACILITY")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_AMOUNT")));
				vecCol.add(correctNull((String) rs
						.getString("FIL_REMITTANCEDETAIL")));
				vecCol
						.add(correctNull((String) rs
								.getString("FIL_DATE")));

				vecRow.add(vecCol);
			}

			hshRecord.put("vecRow", vecRow);
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

	public void updatestatusSuitfield(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		ResultSet rs = null;

		String strAction = correctNull((String) hshValues.get("hidAction"));
		String strAppno = "";

		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}

		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusSuitfield");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "ins_statusSuitfield");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("sel_suitfiled")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_seccategoryadvance")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_suitamount")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_courtname")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_suitno")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_suitdate")));//

				arrValues.add(correctNull((String) hshValues
						.get("txt_runingledger")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_dummyledger")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_sec_advancedate")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_premarketvalue")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_premarketdate")));//
				arrValues.add(correctNull((String) hshValues
						.get("txt_recoveryhalfyear")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_totalrecovery")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_dateofdecree")));//

				arrValues.add(correctNull((String) hshValues
						.get("txt_dateofEP")));//
				arrValues.add(correctNull((String) hshValues
						.get("txt_advocatename")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_advocateaddress")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_phoneno")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_prepositionsuit")));
				arrValues.add(correctNull((String) hshValues.get("sel_ol")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_staussaleofaddr")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_facility")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_lagalproceeding")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_countrclaim")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_compensation")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_staliablity")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_conliablity")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_others")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_pendingcriminal")));

				arrValues.add(correctNull((String) hshValues
						.get("txt_attachment")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_noreason")));
				arrValues
						.add(correctNull((String) hshValues.get("txt_process")));

				arrValues.add(correctNull((String) hshValues.get("strUserId"))); // New
																					// Line
																					// Added
																					// by
																					// Kamal
				arrValues.add(correctNull((String) hshValues
						.get("txt_decreeamount"))); // New Line Added by Kamal
				arrValues.add(correctNull((String) hshValues
						.get("hid_advocateid"))); // added by prashanth for
													// storing advocates slno

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_statusSuitfield");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditflag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditflag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "update");
			}else if(strAuditflag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				sbAuditData
				.append("Whether suit filed/decreed =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_suitfiled"))))
				.append("~ Sectoral Category of Advance =" +correctNull((String)hshValues.get("txt_seccategoryadvance")))
				.append("~ Amount of suit =" +correctNull((String)hshValues.get("txt_suitamount")))
				.append("~ Name of Court =" +ApplicantParams.getApplicantParams("COURTNAME", correctNull((String)hshValues.get("sel_courtname"))))
				.append("~ Suit No =" +correctNull((String)hshValues.get("txt_suitno")))
				.append("~ Suit Date =" +correctNull((String)hshValues.get("txt_suitdate")))
				.append("~ Running Ledger O/s =" +correctNull((String)hshValues.get("txt_runingledger")))
				.append("~ Dummy Ledger O/s =" +correctNull((String)hshValues.get("txt_dummyledger")))
				.append("~ Value of Security =" +correctNull((String)hshValues.get("txt_sec_advancedate")))
				.append("~ Present Market Value =" +correctNull((String)hshValues.get("txt_premarketvalue")))
				.append("~ Date of Valuation =" +correctNull((String)hshValues.get("txt_premarketdate")))
				.append("~ Recovery =" +correctNull((String)hshValues.get("txt_recoveryhalfyear")))
				.append("~ Total recovery till date =" +correctNull((String)hshValues.get("txt_totalrecovery")))
				.append("~ Date of Decree =" +correctNull((String)hshValues.get("txt_dateofdecree")))
				.append("~ Decree Amount =" +correctNull((String)hshValues.get("txt_decreeamount")))
				.append("~ Date of filing EP =" +correctNull((String)hshValues.get("txt_dateofEP")))
				.append("~ Name of Advocate =" +correctNull((String)hshValues.get("txt_advocatename")))
				.append("~ Phone no =" +correctNull((String)hshValues.get("txt_phoneno")))
				.append("~ Whether OL appointed =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_ol"))));
			}
			AuditTrial.auditLog(hshValues, "373", strAppno, sbAuditData.toString());
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection in updatestatusSuitfield"
								+ cf.getMessage());
			}
		}
	}

	public HashMap getstatusSuitfield(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAppno = "";
		String strQuery = "";
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("select_statusSuitfield^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("suit_decreed", correctNull(rs
						.getString("suit_decreed")));
				hshResult.put("suit_sectoralcat", correctNull(rs
						.getString("suit_sectoralcat")));

				hshResult.put("suit_amount", correctNull(rs
						.getString("suit_amount")));
				hshResult.put("suit_courtname", correctNull(rs
						.getString("suit_courtname")));

				hshResult.put("suit_no", correctNull(rs.getString("suit_no")));
				hshResult.put("suit_date", correctNull(rs
						.getString("suit_date")));

				hshResult.put("siut_running", correctNull(rs
						.getString("siut_running")));

				hshResult.put("siut_outstanding", correctNull(rs
						.getString("siut_outstanding")));
				hshResult.put("siut_securityvalueadvance", correctNull(rs
						.getString("siut_securityvalueadvance")));

				// hshResult.put("BIFR_REFDATE",correctNull(rs.getString("BIFR_REFDATE")));
				hshResult.put("siut_presentmarketvalue", correctNull(rs
						.getString("siut_presentmarketvalue")));
				hshResult.put("suit_dateofvaluation", correctNull(rs
						.getString("suit_dateofvaluation")));

				hshResult.put("suit_recoveryhalf", correctNull(rs
						.getString("suit_recoveryhalf")));
				hshResult.put("suit_totalrecovery", correctNull(rs
						.getString("suit_totalrecovery")));
				hshResult.put("suit_dateofdecree", correctNull(rs
						.getString("suit_dateofdecree")));

				hshResult.put("suit_dateoffilling", correctNull(rs
						.getString("suit_dateoffilling")));
				hshResult.put("suit_advocatename", correctNull(rs
						.getString("suit_advocatename")));
				hshResult.put("suit_address", correctNull(rs
						.getString("suit_address")));

				hshResult.put("suit_phoneno", correctNull(rs
						.getString("suit_phoneno")));
				hshResult.put("suit_presentposition", correctNull(rs
						.getString("suit_presentposition")));

				hshResult.put("suit_olappointed", correctNull(rs
						.getString("suit_olappointed")));
				hshResult.put("suit_saleofstatus", correctNull(rs
						.getString("suit_saleofstatus")));
				hshResult.put("suit_facility", correctNull(rs
						.getString("suit_facility")));
				hshResult.put("suit_legalproceeding", correctNull(rs
						.getString("suit_legalproceeding")));
				hshResult.put("suit_counterclaim", correctNull(rs
						.getString("suit_counterclaim")));

				hshResult.put("suit_workercompensation", correctNull(rs
						.getString("suit_workercompensation")));
				hshResult.put("suit_Statliabilities", correctNull(rs
						.getString("suit_Statliabilities")));
				hshResult.put("suit_Contiliabilities", correctNull(rs
						.getString("suit_Contiliabilities")));
				hshResult.put("suit_Others", correctNull(rs
						.getString("suit_Others")));
				hshResult.put("suit_pendingcriminal", correctNull(rs
						.getString("suit_pendingcriminal")));
				hshResult.put("suit_attachment", correctNull(rs
						.getString("suit_attachment")));
				hshResult.put("suit_noreason", correctNull(rs
						.getString("suit_noreason")));
				hshResult.put("suit_process", correctNull(rs
						.getString("suit_process")));
				hshResult.put("decree_amount", correctNull(rs
						.getString("suit_decreeamount"))); // New Line Added by
															// Kamal
				hshResult.put("advocate_sno", correctNull(rs
						.getString("suit_advocatesno"))); // added by
															// prashanth
				hshResult.put("AuditFlag", "Y");

			}
			else{
				hshResult.put("AuditFlag", "N");
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getstatusSuitfield-- "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}

	private HashMap getNPV(HashMap hshValues)  {
		HashMap hshResult = null;
		String strAppno = "";
		String strQuery = "";
		ResultSet rs = null;
		try {
			hshResult = new HashMap();
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("getnpv^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshResult.put("realisablevalue", correctNull(rs
						.getString("npa_securityvalue")));
				hshResult.put("roi", correctNull(rs.getString("npa_roi")));
				hshResult.put("years", correctNull(rs.getString("npa_years")));
				hshResult.put("npv", correctNull(rs.getString("npa_npv")));
			} else {
				strQuery = SQLParser
						.getSqlQuery("selsecurityvalue^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshResult.put("realisablevalue", correctNull(rs
							.getString("presentvalue")));
				}
			}
		} catch (Exception ex) {
			throw new EJBException("Error in getNPV :: " + ex.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ex) {
				throw new EJBException(
						"Error in closing Connection in getNPV  :: "
								+ ex.toString());
			}
		}
		return hshResult;
	}

	private void updateNPV(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = null;
		String strAppno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
		}
		String strAction = correctNull((String) hshValues.get("hidAction"));

		try {
			if (strAction.equalsIgnoreCase("insert")) {

				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "delnpv");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues
						.get("txt_realisablevalue")));
				arrValues.add(correctNull((String) hshValues
						.get("txt_rateofint")));
				arrValues.add(correctNull((String) hshValues.get("txt_years")));
				arrValues.add(correctNull((String) hshValues.get("txt_npv")));
				hshQuery.put("strQueryId", "insnpv");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("delete")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "delnpv");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
		} catch (Exception e) {
			throw new EJBException("Error in updateNPV" + e.getMessage());
		}
	}

	public HashMap getNpaProposalReport(HashMap hshValues)  {
		HashMap hshResult = null;
		ResultSet rs = null;
		String str_orgname = null;
		String str_npatype = null;
		String str_level = null;
		String strSelFields = null;
		String strcode = null;
		String strperiod = null;
		String strperiodfrom = null;
		String strperiodto = null;
		StringBuffer strbufOrgcode = null;
		String strQuery = null;
		String strQuery1 = null;
		String strQuery2 = null;
		String strQuery3 = null;
		String strnpatypedesc = null;
		ArrayList vecT = null;
		ArrayList vecT1 = null;
		ArrayList veccol = null;
		ArrayList vecrow = null;
		String strlabel = null;
		StringTokenizer st1 = null;
		try {

			String[] count = { "0", "0", "0", "0" };
			strlabel = "NPA Type,No. of Proposals Applied,No. of Proposals Sanctioned,No. of Proposals Rejected,No. of Proposals Pending";

			hshResult = new HashMap();
			str_orgname = correctNull((String) (hshValues.get("hidOrgName")));
			hshResult.put("orgname", str_orgname);
			strSelFields = correctNull((String) (hshValues.get("hidselfields")));
			strnpatypedesc = correctNull((String) (hshValues
					.get("hidnpatypedesc")));
			StringTokenizer st = new StringTokenizer(strSelFields, ",");
			vecT = new ArrayList();
			while (st.hasMoreTokens()) {
				vecT.add(st.nextToken());
			}
			st1 = new StringTokenizer(strnpatypedesc, ",");
			vecT1 = new ArrayList();
			while (st1.hasMoreTokens()) {
				vecT1.add(st1.nextToken());
			}
			// hshResult.put("labels",strSelFields);
			strcode = correctNull((String) (hshValues.get("hidcode")));
			strbufOrgcode = new StringBuffer();
			strcode = strcode.substring(2);
			str_level = correctNull((String) (hshValues.get("hidlevel")));
			if (str_level.equalsIgnoreCase("B")) {
				strbufOrgcode.append("npa_orgcode='").append(strcode).append(
						"'");
			} else if (str_level.equalsIgnoreCase("A")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 12)).append("%'");
			} else if (str_level.equalsIgnoreCase("D")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 9)).append("%'");
			} else if (str_level.equalsIgnoreCase("R")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 6)).append("%'");
			} else if (str_level.equalsIgnoreCase("C")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 3)).append("%'");
			}
			strperiod = correctNull((String) (hshValues.get("hidperiod")));
			vecrow = new ArrayList();
			for (int i = 0; i < vecT.size(); i++) {
				str_npatype = correctNull((String) vecT.get(i));
				if (strperiod.equalsIgnoreCase("All")) {
					strQuery = SQLParser
							.getSqlQuery("select_npa_proposal_report_all^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "op" + "^" + "op");
					strQuery1 = SQLParser
							.getSqlQuery("select_npa_proposal_report_all^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "pa" + "^" + "ca");
					strQuery2 = SQLParser
							.getSqlQuery("select_npa_proposal_report_all^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "pr" + "^" + "cr");
					strQuery3 = SQLParser
							.getSqlQuery("select_npa_proposal_report_all_applied^"
									+ strbufOrgcode.toString()
									+ "^"
									+ str_npatype);
				} else {
					strperiodfrom = strperiod.substring(0, strperiod
							.indexOf("-"));
					strperiodto = strperiod.substring(
							strperiod.indexOf("-") + 1, strperiod.length());
					strQuery = SQLParser
							.getSqlQuery("select_npa_proposal_report^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "op" + "^" + "op"
									+ "^" + strperiodfrom + "^" + strperiodto);
					strQuery1 = SQLParser
							.getSqlQuery("select_npa_proposal_report^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "pa" + "^" + "ca"
									+ "^" + strperiodfrom + "^" + strperiodto);
					strQuery2 = SQLParser
							.getSqlQuery("select_npa_proposal_report^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + "pr" + "^" + "cr"
									+ "^" + strperiodfrom + "^" + strperiodto);
					strQuery3 = SQLParser
							.getSqlQuery("select_npa_proposal_report_applied^"
									+ strbufOrgcode.toString() + "^"
									+ str_npatype + "^" + strperiodfrom + "^"
									+ strperiodto);
				}
				veccol = new ArrayList();
				veccol.add(correctNull((String) vecT1.get(i)));
				rs = DBUtils.executeQuery(strQuery3);
				if (rs.next()) {
					veccol.add((String) correctNull(rs
							.getString("count1")));
					count[0] = Integer.toString(Integer.parseInt(count[0])
							+ Integer.parseInt(rs.getString("count1")));
				}
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) {
					veccol.add((String) correctNull(rs
							.getString("count1")));
					count[1] = Integer.toString(Integer.parseInt(count[1])
							+ Integer.parseInt(rs.getString("count1")));
				}
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery2);
				if (rs.next()) {
					veccol.add((String) correctNull(rs
							.getString("count1")));
					count[2] = Integer.toString(Integer.parseInt(count[2])
							+ Integer.parseInt(rs.getString("count1")));
				}
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					veccol.add((String) correctNull(rs
							.getString("count1")));
					count[3] = Integer.toString(Integer.parseInt(count[3])
							+ Integer.parseInt(rs.getString("count1")));
				}
				if (rs != null) {
					rs.close();
				}
				vecrow.add(veccol);
				veccol = null;
			}
			hshResult.put("vecrow", vecrow);
			hshResult.put("period", strperiod);
			hshResult.put("labels", strlabel);
			hshResult.put("count", count);
		} catch (Exception ex) {
			throw new EJBException("Error in getNpaProposalReport :: "
					+ ex.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception ex) {
				throw new EJBException(
						"Error in closing Connection in getNpaReport :: "
								+ ex.toString());
			}
		}
		return hshResult;
	}

	public HashMap getNpaReport(HashMap hshValues)  {
		HashMap hshResult = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String str_orgname = null;
		String str_status = null;
		String str_npatype = null;
		String str_level = null;
		String strSelFields = null;
		String strcode = null;
		String statuscode1 = null;
		String statuscode2 = null;
		String strperiod = null;
		String strperiodfrom = null;
		String strperiodto = null;
		StringBuffer strbufOrgcode = null;
		String strQuery = null;
		String strQuery1 = null;
		String strQuery2 = null;
		String strnpaappno = null;
		String strDate = null;
		ArrayList vecT = null;
		ArrayList veccol = null;
		ArrayList vecrow = null;
		ArrayList vecalign = null;
		String temp = null;
		try {
			vecalign = new ArrayList();
			strDate = (String) hshValues.get("txt_period");
			hshResult = new HashMap();
			str_orgname = correctNull((String) (hshValues.get("hidOrgName"))); // Organisation
																				// Name
																				// Of
																				// Current
																				// User
			hshResult.put("orgname", str_orgname);
			str_status = correctNull((String) (hshValues.get("hidstatus"))); // Application
																				// status
																				// selected
																				// by
																				// the
																				// user
			hshResult.put("status", str_status);
			strSelFields = correctNull((String) (hshValues.get("hidselfields")));// output
																					// Fields
																					// Selected
																					// By
																					// User
			StringTokenizer st = new StringTokenizer(strSelFields, ",");
			vecT = new ArrayList();
			while (st.hasMoreTokens()) {
				vecT.add(st.nextToken());
			}
			hshResult.put("labels", strSelFields);
			strcode = correctNull((String) (hshValues.get("hidcode")));
			strbufOrgcode = new StringBuffer();
			strcode = strcode.substring(2);
			str_level = correctNull((String) (hshValues.get("hidlevel")));
			if (str_level.equalsIgnoreCase("B")) {
				strbufOrgcode.append("npa_orgcode='").append(strcode).append(
						"'");
			} else if (str_level.equalsIgnoreCase("A")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 12)).append("%'");
			} else if (str_level.equalsIgnoreCase("D")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 9)).append("%'");
			} else if (str_level.equalsIgnoreCase("R")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 6)).append("%'");
			} else if (str_level.equalsIgnoreCase("C")) {
				strbufOrgcode.append("npa_orgcode like '").append(
						strcode.substring(0, 3)).append("%'");
			}
			str_npatype = correctNull((String) (hshValues.get("hidnpatype")));
			if (str_status.equalsIgnoreCase("Pending")) {
				statuscode1 = "op";
				statuscode2 = "op";
			} else if (str_status.equalsIgnoreCase("Approved")) {
				statuscode1 = "pa";
				statuscode2 = "ca";
			} else if (str_status.equalsIgnoreCase("Rejected")) {
				statuscode1 = "pr";
				statuscode2 = "cr";
			}
			strperiod = correctNull((String) (hshValues.get("hidperiod")));
			if (strperiod.equalsIgnoreCase("All")) {
				strQuery = SQLParser.getSqlQuery("select_npa_report_all^"
						+ strbufOrgcode.toString() + "^" + statuscode1 + "^"
						+ statuscode2 + "^" + str_npatype);
			} else {
				strperiodfrom = strperiod.substring(0, strperiod.indexOf("-"));
				strperiodto = strperiod.substring(strperiod.indexOf("-") + 1,
						strperiod.length());
				strQuery = SQLParser.getSqlQuery("select_npa_report^"
						+ strbufOrgcode.toString() + "^" + statuscode1 + "^"
						+ statuscode2 + "^" + str_npatype + "^" + strperiodfrom
						+ "^" + strperiodto);
			}
			rs = DBUtils.executeQuery(strQuery);
			vecrow = new ArrayList();
			while (rs.next()) {
				veccol = new ArrayList();
				strnpaappno = (String) correctNull(rs.getString("appno"));
				if (vecT.contains("Application Number")) {
					veccol.add(strnpaappno);
					vecalign.add("center");
				}
				if (vecT.contains("Borrower Name")) {
					veccol.add((String) correctNull(rs
							.getString("appname")));
					vecalign.add("left");
				}
				if (vecT.contains("Amount")) {
					strQuery1 = SQLParser
							.getSqlQuery("select_npa_presentposition_amount^"
									+ strnpaappno);
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						temp = Helper.correctDouble(rs1.getString("amount"));
						// veccol.add(temp.toString());
						veccol.add((String) Helper
								.formatDoubleValue(Double.parseDouble(temp)));
						vecalign.add("right");
					}
					if (rs1 != null) {
						rs1.close();
					}
				}
				if (vecT.contains("Applied Date")) {
					veccol.add((String) correctNull(rs
							.getString("createddate")));
					vecalign.add("center");
				}
				if (vecT.contains("Pending With")
						|| vecT.contains("Pending Since")) {
					strQuery2 = SQLParser
							.getSqlQuery("select_npamailbox_pending^"
									+ strnpaappno);
					rs2 = DBUtils.executeQuery(strQuery2);
					if (rs2.next()) {
						if (vecT.contains("Pending With")) {
							veccol.add((String) correctNull(rs2
									.getString("tousrid")));
							vecalign.add("left");
						}
						if (vecT.contains("Pending Since")) {
							veccol.add((String) correctNull(rs2
									.getString("maildate")));
							vecalign.add("center");
						}
					} else {
						if (vecT.contains("Pending With")) {
							veccol.add((String) correctNull(rs
									.getString("createdby")));
							vecalign.add("left");
						}
						if (vecT.contains("Pending Since")) {
							veccol.add((String) correctNull(rs
									.getString("createddate")));
							vecalign.add("center");
						}
					}
					if (rs2 != null) {
						rs2.close();
					}
				}
				if (vecT.contains("Approved By")
						|| vecT.contains("Rejected By")) {
					veccol.add((String) correctNull(rs
							.getString("processedby")));
					vecalign.add("left");
				}
				if (vecT.contains("Approved Date")
						|| vecT.contains("Rejected Date")) {
					veccol.add((String) correctNull(rs
							.getString("processeddate")));
					vecalign.add("center");
				}
				if (vecT.contains("Branch")) {
					veccol.add((String) correctNull(rs
							.getString("orgname")));
					vecalign.add("center");
				}
				vecrow.add(veccol);
				veccol = null;
			}
			hshResult.put("vecrow", vecrow);
			hshResult.put("vecalign", vecalign);
			hshResult.put("txtDate", strDate);
			hshResult.put("period", strperiod);
		} catch (Exception ex) {
			throw new EJBException("Error in getNpaReport :: " + ex.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
				if (rs2 != null)
					rs2.close();
			} catch (Exception ex) {
				throw new EJBException(
						"Error in closing Connection in getNpaReport :: "
								+ ex.toString());
			}
		}
		return hshResult;
	}

	public HashMap getDCBRegisterData(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String str_name = "";
		String str_code = "";
		String str_code_1 = "";
		String str_solid = "";
		String str_level = "";
		ArrayList branch = null;
		ArrayList totalbranch = new ArrayList();
		ArrayList totalregion = new ArrayList();
		ArrayList totalregionname = new ArrayList();
		StringBuffer strbufOrgcode = null;
		ArrayList arr_solid = null;
		ArrayList arr_orgname = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try {
			strbufOrgcode = new StringBuffer();
			str_code = correctNull((String) hshValues.get("hidcode"));
			if (!str_code.equals(""))
				str_code_1 = str_code.substring(2);
			else
				str_code_1 = correctNull((String) hshValues.get("hidcode1"));
			if (str_code_1.equals(""))
				str_code_1 = correctNull((String) hshValues.get("hidcode2"));
			str_name = correctNull((String) hshValues.get("hidOrgName"));
			if (str_name.equals(""))
				str_name = correctNull((String) hshValues.get("hidorg"));
			str_level = correctNull((String) (hshValues.get("hidlevel")));
			if (str_level.equalsIgnoreCase("B")) {
				strbufOrgcode.append("org_code='").append(str_code_1).append(
						"'");
			} else if (str_level.equalsIgnoreCase("A")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 12)).append("%'");
			} else if (str_level.equalsIgnoreCase("D")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 9)).append("%'");
			} else if (str_level.equalsIgnoreCase("R")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 6)).append("%'");
			} else if (str_level.equalsIgnoreCase("C")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 3)).append("%'");
			}

			/*
			 * strQuery=SQLParser.getSqlQuery("organisations_select_solid^"+str_code_1);
			 * rs = DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * str_solid=correctNull((String)rs.getString("solid")); }
			 */

			strQuery = SQLParser.getSqlQuery("organisations_select_solid")
					+ strbufOrgcode;
			rs = DBUtils.executeQuery(strQuery);
			arr_solid = new ArrayList();
			arr_orgname = new ArrayList();
			while (rs.next()) {
				arr_solid.add(correctNull((String) rs.getString("solid")));
				arr_orgname.add(correctNull((String) rs.getString("org_name")));
			}
			if (rs != null)
				rs.close();

			for (int i = 0; i < arr_solid.size(); i++) {
				strQuery = SQLParser.getSqlQuery("seldcbregister^"
						+ arr_solid.get(i).toString());
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					branch = new ArrayList();

					double dblcurrentdemand = rs
							.getDouble("dcb_demand_current");
					double dblarreardemand = rs.getDouble("dcb_demand_arrear");
					double dbldemand = dblcurrentdemand + dblarreardemand;
					double dbloverduetotal = rs.getDouble("dcb_overduetotal");
					double dblrecovery = dbldemand - dbloverduetotal;
					double dbloverduelessoneyear = rs
							.getDouble("dcb_less_one_year");
					double dbloverduegtr3year = rs
							.getDouble("dcb_over_three_year");
					double dbloverdue123year = dbloverduetotal
							- dbloverduelessoneyear - dbloverduegtr3year;

					branch.add(correctNull(rs.getString("dcb_accno")));// 0
					if (correctNull(rs.getString("dcb_sector")).equals("OTHPS"))
						branch.add("Other Priority Sector");// 1
					else if (correctNull(rs.getString("dcb_sector")).equals(
							"AGRDT"))
						branch.add("Agriculture Direct");// 1
					else if (correctNull(rs.getString("dcb_sector")).equals(
							"SSIDT"))
						branch.add("SSI Direct");// 1
					else
						branch.add("");// 1
					branch.add(correctNull(rs.getString("dcb_scheme")));// 2
					branch.add(Helper.formatDoubleValue(dblcurrentdemand));// 3
					branch.add(Helper.formatDoubleValue(dblarreardemand));// 4
					branch.add(Helper.formatDoubleValue(dbldemand));// 5
					branch.add(Helper.formatDoubleValue(dblrecovery));// 6
					branch.add("0.00");// 7
					branch.add(Helper.formatDoubleValue(dbloverduelessoneyear));// 8
					branch.add(Helper.formatDoubleValue(dbloverdue123year));// 9
					branch.add(Helper.formatDoubleValue(dbloverduegtr3year));// 10
					branch.add(Helper.formatDoubleValue(dbloverduetotal));// 11
					totalbranch.add(branch);
				}
				if (totalbranch != null && totalbranch.size() > 0) {
					totalregion.add(totalbranch);
					totalregionname.add(arr_orgname.get(i).toString());
				}
				totalbranch = new ArrayList();
				if (rs != null)
					rs.close();
			}
			hshRecord.put("totalregion", totalregion);
			hshRecord.put("regionname", totalregionname);
			hshRecord.put("levelcode", str_level);
			hshRecord.put("branchname", str_name);
			hshRecord.put("branchcode", str_code_1);
			hshRecord.put("orgname", str_name);
			// hshRecord.put("branccode",str_code_1);
			if (rs != null) {
				rs.close();
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getDCBRegisterData "
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
		return hshRecord;

	}

	public void updateDCBRegisterData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = correctNull((String) hshValues.get("hidAction"));
		String size = (String) hshValues.get("hid_size");

		try {
			if (strAction.equalsIgnoreCase("update")) {
				if (Integer.parseInt(size) > 1) {
					String strAppno[] = (String[]) hshValues.get("txt_accno");
					String str_remark[] = (String[]) hshValues
							.get("area_remark");

					for (int i = 0; i < strAppno.length; i++) {
						if (!str_remark[i].equals("")) {
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "upd_dcbreg");
							arrValues.add(str_remark[i]);
							arrValues.add(strAppno[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess",
									hshQueryValues, "updateData");
						}
					}
				} else {
					String strAppno = correctNull((String) hshValues
							.get("txt_accno"));
					String str_remark = correctNull((String) hshValues
							.get("area_remark"));
					if (!str_remark.equals("")) {
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "upd_dcbreg");
						arrValues.add(str_remark);
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}
				}

			}

		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}

	public HashMap getDCBRegisterPrintData(HashMap hshValues)
			 {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String str_name = "";
		String str_code = "";
		String str_code_1 = "";
		String str_solid = "";
		String str_level = "";
		ArrayList branch = null;
		ArrayList totalbranch = new ArrayList();
		ArrayList totalregion = new ArrayList();
		ArrayList totalregionname = new ArrayList();
		ArrayList vectemp_branchold = new ArrayList();
		ArrayList vectemp_branchnew = new ArrayList();
		StringBuffer strbufOrgcode = null;
		ArrayList arr_solid = null;
		ArrayList arr_orgname = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try {
			strbufOrgcode = new StringBuffer();
			str_code_1 = correctNull((String) hshValues.get("hidcode"));
			str_name = correctNull((String) hshValues.get("hidorgname"));
			str_level = correctNull((String) (hshValues.get("hidlevel")));
			if (str_level.equalsIgnoreCase("B")) {
				strbufOrgcode.append("org_code='").append(str_code_1).append(
						"'");
			} else if (str_level.equalsIgnoreCase("A")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 12)).append("%'");
			} else if (str_level.equalsIgnoreCase("D")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 9)).append("%'");
			} else if (str_level.equalsIgnoreCase("R")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 6)).append("%'");
			} else if (str_level.equalsIgnoreCase("C")) {
				strbufOrgcode.append("org_code like '").append(
						str_code_1.substring(0, 3)).append("%'");
			}

			/*
			 * strQuery=SQLParser.getSqlQuery("organisations_select_solid^"+str_code_1);
			 * rs = DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * str_solid=correctNull((String)rs.getString("solid")); }
			 */

			strQuery = SQLParser.getSqlQuery("organisations_select_solid")
					+ strbufOrgcode;
			rs = DBUtils.executeQuery(strQuery);
			arr_solid = new ArrayList();
			arr_orgname = new ArrayList();
			while (rs.next()) {
				arr_solid.add(correctNull((String) rs.getString("solid")));
				arr_orgname.add(correctNull((String) rs.getString("org_name")));
			}
			if (rs != null)
				rs.close();

			for (int i = 0, flag = 0; i < arr_solid.size(); i++) {
				strQuery = SQLParser.getSqlQuery("seldcbregister^"
						+ arr_solid.get(i).toString());
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {

					double dblcurrentdemand = rs
							.getDouble("dcb_demand_current");
					double dblarreardemand = rs.getDouble("dcb_demand_arrear");
					double dbldemand = dblcurrentdemand + dblarreardemand;
					double dbloverduetotal = rs.getDouble("dcb_overduetotal");
					double dblrecovery = dbldemand - dbloverduetotal;
					double dbloverduelessoneyear = rs
							.getDouble("dcb_less_one_year");
					double dbloverduegtr3year = rs
							.getDouble("dcb_over_three_year");
					double dbloverdue123year = dbloverduetotal
							- dbloverduelessoneyear - dbloverduegtr3year;

					flag = 0;
					if (totalbranch != null && totalbranch.size() > 0) {
						flag = 0;
						for (int k = 0; k < totalbranch.size(); k++) {

							vectemp_branchold = new ArrayList();
							vectemp_branchold = (ArrayList) totalbranch
									.get(k);
							if (vectemp_branchold.get(0).toString()
									.equals(
											correctNull(rs
													.getString("dcb_sector")))
									&& vectemp_branchold
											.get(1)
											.toString()
											.equals(
													correctNull(rs
															.getString("dcb_scheme")))
									&& flag == 0) {
								vectemp_branchnew = new ArrayList();
								vectemp_branchnew.add(vectemp_branchold
										.get(0).toString());
								vectemp_branchnew.add(vectemp_branchold
										.get(1).toString());
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(2).toString())
										+ dblcurrentdemand));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(3).toString())
										+ dblarreardemand));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(4).toString())
										+ dbldemand));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(5).toString())
										+ dblrecovery));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(6).toString())));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(7).toString())
										+ dbloverduelessoneyear));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(8).toString())
										+ dbloverdue123year));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(9).toString())
										+ dbloverduegtr3year));
								vectemp_branchnew.add(nf.format(Double
										.parseDouble(vectemp_branchold
												.get(10).toString())
										+ dbloverduetotal));
								//totalbranch.setget(
									//	(ArrayList) vectemp_branchnew, k);
								totalbranch.addAll(k, vectemp_branchnew);
								
								flag = 1;
							}
						}

					}
					if (flag == 0) {
						branch = new ArrayList();
						branch.add(correctNull(rs.getString("dcb_sector")));// 0
						branch.add(correctNull(rs.getString("dcb_scheme")));// 1
						branch.add(Helper.formatDoubleValue(dblcurrentdemand));// 2
						branch.add(Helper.formatDoubleValue(dblarreardemand));// 3
						branch.add(Helper.formatDoubleValue(dbldemand));// 4
						branch.add(Helper.formatDoubleValue(dblrecovery));// 5
						branch.add("0.00");// 6
						branch.add(Helper
								.formatDoubleValue(dbloverduelessoneyear));// 7
						branch.add(Helper.formatDoubleValue(dbloverdue123year));// 8
						branch
								.add(Helper
										.formatDoubleValue(dbloverduegtr3year));// 9
						branch.add(Helper.formatDoubleValue(dbloverduetotal));// 10
						totalbranch.add(branch);
					}
				}
				if (totalbranch != null && totalbranch.size() > 0) {
					totalregion.add(totalbranch);
					totalregionname.add(arr_orgname.get(i).toString());
				}
				totalbranch = new ArrayList();
				if (rs != null)
					rs.close();
			}
			hshRecord.put("totalregion", totalregion);
			hshRecord.put("regionname", totalregionname);
			hshRecord.put("levelcode", str_level);
			hshRecord.put("branchname", str_name);
			// hshRecord.put("branccode",str_code_1);
			if (rs != null) {
				rs.close();
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getDCBRegisterData "
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
		return hshRecord;

	}

	public HashMap getNPAapplicationno(HashMap hshValues)  {

		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
		String strAppid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
		String strApptype = Helper.correctNull((String) hshValues.get("apptype"));
		String strModuletype = Helper.correctNull((String) hshValues.get("moduletype"));
		// String
		// strOrgShortCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));

		int intLen = 0;
		String strYear = Helper.correctNull((String) hshValues.get("year"));
		String strQuarter = Helper.correctNull((String) hshValues
				.get("quarter"));
		String strexist = "N";
		String strprepared = "";
		String strmessage = "";
		String strAppno = "";
		String strQuery = "";
		String strMaxQuater = "";
		String strMaxYear = "";
		try {

			// intLen=strOrgShortCode.length();
			intLen = 4;
			if (strQuarter.equalsIgnoreCase("")) {

				strQuery = SQLParser
						.getSqlQuery("sel_NPAstatApplnNo^"+ strModuletype	+ "^"+ strAppid	+ "^"+ strApptype	+ "^"	+ (intLen + 1)
								+ "^"+ strYear+ "^"	+ " and npa_demoappno=npa_appno order by npa_appno ASC");
				rs = DBUtils.executeQuery(strQuery);
			} else {

				strQuery = SQLParser
						.getSqlQuery("sel_NPAstatApplnNo^"
								+ strModuletype
								+ "^"
								+ strAppid
								+ "^"
								+ strApptype
								+ "^"
								+ (intLen + 1)
								+ "^"
								+ strYear
								+ "^"
								+ "and substr(npa_appno,"
								+ +(intLen + 8)
								+ ", 1)='"
								+ strQuarter
								+ "'and npa_demoappno=npa_appno order by npa_appno ASC");
				rs = DBUtils.executeQuery(strQuery);

			}

			hshRecord = new HashMap();
			while (rs.next()) {
				strexist = "Y";
				strmessage = "The Status Note for " + strQuarter
						+ " Quarter of " + strYear + " is already perpared .";
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("npa_appno")));
				arrRow.add(arrCol);
			}

			hshRecord.put("arrRow", arrRow);
			hshRecord.put("exist", strexist);

			if ((correctNull((String) hshValues.get("hidtype"))
					.equalsIgnoreCase("NEW"))
					&& strexist.equalsIgnoreCase("N")) {
				strQuery = SQLParser.getSqlQuery("sel_MaxNPAstatApplnNo^"
						+ strAppid + "^" + strApptype + "^"
						+ "and npa_demoappno=npa_appno");

				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strAppno = correctNull(rs.getString("npa_appno"));
				}

				if (!(strAppno.equalsIgnoreCase("")) && strAppno.length() == 20) {
					strMaxYear = strAppno.substring(6, 10);
					strMaxQuater = strAppno.substring(10, 11);

					if ((Integer.parseInt(strMaxYear) > (Integer
							.parseInt(strYear)))) {
						strprepared = "Y";
						strmessage = "The Status Note for "
								+ strMaxQuater
								+ " Quarter of "
								+ strMaxYear
								+ " is already perpared So You cannot prepared it for  "
								+ strQuarter + " Quarter of " + strYear;
					}

					else if ((Integer.parseInt(strMaxYear) >= (Integer
							.parseInt(strYear)))
							&& (Integer.parseInt(strMaxQuater) > (Integer
									.parseInt(strQuarter)))) {
						strprepared = "Y";
						strmessage = "The Status Note for "
								+ strMaxQuater
								+ " Quarter of "
								+ strMaxYear
								+ " is already perpared So You cannot prepared it for  "
								+ strQuarter + " Quarter of " + strYear;
					}
				}

			}
			hshRecord.put("prepared", strprepared);
			hshRecord.put("Year", strYear);
			hshRecord.put("Quarter", strQuarter);
			hshRecord.put("message", strmessage);
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getNPAapplicationno "
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
		return hshRecord;
	}

	public void updateNPAMailComments(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAppno = "";
		String strMailComments = "";
		String strUserId = "";
		String strtoUser = "";

		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			strMailComments = correctNull((String) hshValues.get("comments"));
			strUserId = correctNull((String) hshValues.get("hiduserid"));
			strtoUser = correctNull((String) hshValues.get("hidtoUser"));

			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "1");

			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_npamailcomments");
			arrValues.add(strAppno);
			arrValues.add(strMailComments);
			arrValues.add(strUserId);
			arrValues.add(strtoUser);
			arrValues.add(correctNull((String) hshValues.get("txt_pano")));

			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");

		} catch (Exception ce) {
			throw new EJBException("inside updateNPAMailComments"
					+ ce.toString());
		}
	}

	public HashMap getNPAMailComments(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRow = null;

		String strAppno = "";

		int no = 1;

		try {

			strAppno = correctNull((String) hshValues.get("npa_appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = correctNull((String) hshValues.get("appno"));
			}

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("sel_npamailcomments^" + strAppno);
			while (rs.next()) {
				hshRow = new HashMap();
				hshRow.put("mail_appno", correctNull(rs.getString(1)));
				hshRow.put("mail_comments", correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
				hshRow.put("mail_userid", correctNull(rs.getString(3)));
				hshRow.put("mail_date", correctNull(rs.getString(4)));
				hshRow.put("mail_touser", correctNull(rs.getString(5)));
				hshRow.put("mail_usrname", correctNull(rs.getString(7)));
				hshRow.put("mail_usrdesign", correctNull(rs.getString(6)));
				hshRow.put("mail_pano", correctNull(rs.getString(8)));

				hshRecord.put(Integer.toString(no), hshRow);
				no++;
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getNPAMailComments  "+ ce.toString());
		} finally {
			try {

				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "+ cf.getMessage());

			}
		}
		return hshRecord;
	}

	private HashMap getBorrowerDetails(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strappno = "";
		String strQuery = "";
		ResultSet rs = null;
		try {
			strappno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("npacustbranchdet^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("branchname", correctNull(rs.getString("branchname")));
				hshRecord.put("zonalname", correctNull(rs.getString("zonalname")));
				hshRecord.put("regionname", correctNull(rs.getString("regionalname")));
			}

		} catch (Exception ex) {
			throw new EJBException("Error in getBorrowerdetails :: "+ ex.toString());
		}
		return hshRecord;
	}
}
