package com.sai.laps.ejb.documentresults;

import java.rmi.RemoteException;
import java.sql.Clob;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.ComProposal.ComProposalBean;
import com.sai.laps.ejb.bankappfi.BankAppFIBean;
import com.sai.laps.ejb.checkeligibility.CheckEligibilityBean;
import com.sai.laps.ejb.commdocument.CommDocumentBean;
import com.sai.laps.ejb.compro.comproBean;
import com.sai.laps.ejb.document.DocumentBean;
import com.sai.laps.ejb.dscr.DscrBean;
import com.sai.laps.ejb.executive.ExecutiveBean;
import com.sai.laps.ejb.mis.MisBean;
import com.sai.laps.ejb.proposalterms.ProposalTermsBean;
import com.sai.laps.ejb.retailassessment.RetailAssessmentBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;

@Stateless(name = "DocumentResultsBean", mappedName = "DocumentResultsHome")
@Remote (DocumentResultsRemote.class)

public class DocumentResultsBean extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log = Logger.getLogger(DocumentResultsBean.class);

	public HashMap getData(HashMap hshRequestValues)  {

		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs10 = null;
		String strQuery = "";
		String Title1 = "";
		String Title2 = "";
		String sancamount = "";
		String strorgname = "";
		String strBranchName = "";
		// String flag = "";
		String strInttype = "";
		String appno = "";
		String strProductType = "";
		String strPrdcode = "";

		String strappId = "";
		int intTerms = 0;
		int intMoratorium = 0;
		String Constitution = "";
		try {

			strappId = Helper.correctNull((String) hshRequestValues
					.get("comappid"));
			if (strappId.equalsIgnoreCase("")) {
				strappId = Helper.correctNull((String) hshRequestValues
						.get("hidDemoId"));
			}
			appno = correctNull((String) hshRequestValues.get("appno"));
			// strProductType=correctNull((String)hshRequestValues.get("strProductType"));
			// strPrdcode= correctNull((String)hshRequestValues.get("prdcode"));

			// Application Details ::::

			if (rs != null)
				rs.close();
			rs = DBUtils
					.executeLAPSQuery("selcommworkflowsancdetails^" + appno);
			if (rs.next()) {
				hshRecord.put("sancofficercomments", correctNull(rs
						.getString("app_sanctioningcomments")));
				hshRecord.put("sancauth",
						correctNull(rs.getString("usr_fname")));
				strPrdcode = correctNull((String) hshRequestValues
						.get("prdcode"));
			}

			// Applicant details

			strQuery = SQLParser.getSqlQuery("selapplicant_byappno^" + appno
					+ "^a");
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {

				String perapp_title = correctNull((String) rs
						.getString("perapp_title"));

				String perapp_hname = correctNull((String) rs
						.getString("perapp_husname"));

				if (perapp_hname.equalsIgnoreCase("1")
						&& perapp_title.equalsIgnoreCase("Mr")) {
					Title1 = "S/o.";
				} else if (perapp_hname.equalsIgnoreCase("1")
						&& perapp_title.equalsIgnoreCase("MS")) {
					Title1 = "D/o.";
				} else if (perapp_hname.equalsIgnoreCase("2")
						&& perapp_title.equalsIgnoreCase("MRS")) {
					Title1 = "W/o.";
				}

				if (perapp_hname.equalsIgnoreCase("1")) {
					Title2 = "Mr.";
				} else if (perapp_hname.equalsIgnoreCase("2")) {
					Title2 = "Mr.";
				}

				hshRecord.put("Title", perapp_title);
				hshRecord.put("Title1", Title1.toUpperCase());
				hshRecord.put("Title2", Title2.toUpperCase());
				hshRecord.put("appname", correctNull((String) rs
						.getString("perapp_fname")));
				hshRecord.put("perapp_address1", correctNull((String) rs
						.getString("perapp_address1")));
				hshRecord.put("perapp_address2", correctNull((String) rs
						.getString("perapp_address2")));
				hshRecord.put("perapp_address3", correctNull((String) rs
						.getString("perapp_address3")));
				hshRecord.put("perapp_city", correctNull((String) rs
						.getString("comm_city")));
				hshRecord.put("perapp_state", correctNull((String) rs
						.getString("comm_state")));
				hshRecord.put("perapp_zip", correctNull((String) rs
						.getString("perapp_zip")));
				hshRecord.put("perapp_phone", correctNull((String) rs
						.getString("perapp_phone")));
				hshRecord.put("perapp_email", correctNull(rs
						.getString("perapp_email")));
				hshRecord.put("perapp_dob", correctNull((String) rs
						.getString("perapp_dob")));
				hshRecord.put("perapp_marstat", correctNull((String) rs
						.getString("perapp_marstat")));
				hshRecord.put("perapp_sex", correctNull((String) rs
						.getString("perapp_sex")));
				hshRecord.put("perapp_employment", correctNull((String) rs
						.getString("perapp_employment")));
				hshRecord.put("perapp_yrsinpresadd", correctNull((String) rs
						.getString("perapp_yrsinpresadd")));
				hshRecord.put("perapp_education", correctNull((String) rs
						.getString("perapp_education")));
				hshRecord.put("perapp_bank", correctNull((String) rs
						.getString("perapp_bank")));
				// hshRecord.put("perapp_buss",correctNull((String)rs.getString("perapp_buss")));
				hshRecord.put("perapp_permadd1", correctNull((String) rs
						.getString("perapp_permadd1")));
				hshRecord.put("perapp_permadd2", correctNull((String) rs
						.getString("perapp_permadd2")));
				hshRecord.put("perapp_permadd3", correctNull((String) rs
						.getString("perapp_permadd3")));
				hshRecord.put("perapp_permcity", correctNull((String) rs
						.getString("perm_city")));
				hshRecord.put("perapp_permstate", correctNull((String) rs
						.getString("perm_state")));
				hshRecord.put("perapp_permzip", correctNull((String) rs
						.getString("perapp_permzip")));
				hshRecord.put("perapp_permphone", correctNull((String) rs
						.getString("perapp_permphone")));
				hshRecord.put("perapp_mobile", correctNull((String) rs
						.getString("perapp_mobile")));
				hshRecord.put("perapp_category", correctNull((String) rs
						.getString("perapp_category")));
				hshRecord.put("perapp_depend", correctNull((String) rs
						.getString("perapp_depend")));
				hshRecord.put("perapp_banksince", correctNull((String) rs
						.getString("perapp_banksince")));
				hshRecord.put("perapp_bankacctype", correctNull((String) rs
						.getString("perapp_bankacctype")));
				hshRecord.put("perapp_bankaccno", correctNull((String) rs
						.getString("perapp_bankaccno")));
				hshRecord.put("perapp_fatname", correctNull((String) rs
						.getString("perapp_fatname")));
				hshRecord.put("perapp_husname", correctNull((String) rs
						.getString("perapp_husname")));
				hshRecord.put("perapp_childnum", correctNull((String) rs
						.getString("perapp_childnum")));
				hshRecord.put("perapp_typeofprof", correctNull((String) rs
						.getString("perapp_typeofprof")));
				hshRecord.put("perapp_passport", correctNull((String) rs
						.getString("perapp_passport")));
				hshRecord.put("perapp_spouseoccu", correctNull((String) rs
						.getString("perapp_spouseoccu")));
				hshRecord.put("perapp_spousepan", correctNull((String) rs
						.getString("perapp_spousepan")));
				hshRecord.put("perapp_brdet", correctNull((String) rs
						.getString("perapp_brdet")));
				// hshRecord.put("perapp_relativedet",correctNull((String)rs.getString("perapp_relativedet")));
				hshRecord.put("perapp_status", correctNull((String) rs
						.getString("perapp_status")));
				hshRecord.put("perapp_minority", correctNull((String) rs
						.getString("perapp_selminority")));
				hshRecord.put("perapp_eduothers", correctNull((String) rs
						.getString("perapp_eduothers")));
				hshRecord.put("perapp_religion", correctNull((String) rs
						.getString("perapp_religion")));
				// hshRecord.put("perapp_relativedet",correctNull((String)rs.getString("perapp_relativedet")));
				hshRecord.put("perapp_hname", correctNull((String) rs
						.getString("perapp_hname")));
				hshRecord.put("perapp_residencetype", correctNull((String) rs
						.getString("perapp_residencetype")));
				hshRecord.put("pfno", correctNull((String) rs
						.getString("perapp_staffusrid")));
				hshRecord.put("perapp_staffdoj", correctNull((String) rs
						.getString("perapp_staffdoj")));
				hshRecord.put("perapp_nomineepfname", correctNull((String) rs
						.getString("perapp_nomineepfname")));
				hshRecord.put("perapp_pfrelation", correctNull((String) rs
						.getString("perapp_pfrelation")));
				hshRecord.put("perapp_nomineegratuityname",
						correctNull((String) rs
								.getString("perapp_nomineegratuityname")));
				hshRecord.put("perapp_gratuityrelation",
						correctNull((String) rs
								.getString("perapp_gratuityrelation")));
				hshRecord.put("perapp_servicerecord", correctNull((String) rs
						.getString("perapp_servicerecord")));
				strBranchName = correctNull(rs.getString("perapp_recfrom"));
				if (!correctNull((String) rs.getString("perapp_constitution"))
						.equals("")) {
					strQuery = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ correctNull((String) rs
											.getString("perapp_constitution")));
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						Constitution = correctNull((String) rs2
								.getString("cbs_static_data_desc"));
					}
				}
				hshRecord.put("Constitution", Constitution);
				if (strappId.equalsIgnoreCase("")) {
					strappId = Helper.correctNull((String) rs
							.getString("perapp_id"));
				}

				// flag="0";
			}

			// This code is used for Income and expenses

			strQuery = SQLParser.getSqlQuery("selIncomeExpenses^" + appno
					+ "^a");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				double yearsalary = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("perinc_yearsalary")));
				double year_statutorydeduction = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("perinc_yeardeduction")));
				double monthsalary = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("perinc_monsalary")));
				double month_statutorydeduction = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("perinc_deduction")));
				double month_otherdeduction = Double.parseDouble(Helper
						.correctDouble((String) rs
								.getString("perinc_otherdeduction")));
				double dblotherincome = rs.getDouble("perinc_otherincome");

				hshRecord.put("perinc_monsalary", correctNull((String) rs
						.getString("perinc_monsalary")));
				hshRecord.put("perinc_deduction", Helper
						.correctDouble((String) rs
								.getString("perinc_deduction")));
				hshRecord.put("perinc_yearsalary", Helper
						.formatDoubleValue(yearsalary));
				hshRecord.put("perinc_yeardeduction", Helper
						.formatDoubleValue(year_statutorydeduction));
				// hshRecord.put("perinc_selfincometype",correctNull((String)rs.getString("perinc_selfincometype")));
				// hshRecord.put("perinc_Constitution",correctNull((String)rs.getString("constitution")));
				hshRecord.put("perinc_otherdeduction", correctNull((String) rs
						.getString("perinc_otherdeduction")));
				hshRecord.put("netsalary", Helper.formatDoubleValue(monthsalary
						- (month_statutorydeduction + month_otherdeduction)));
				hshRecord.put("permonsalary", Helper
						.formatDoubleValue(monthsalary
								- month_statutorydeduction
								- month_otherdeduction + dblotherincome));
				hshRecord.put("peryearsalary", Helper
						.formatDoubleValue((monthsalary
								- month_statutorydeduction
								- month_otherdeduction + dblotherincome) * 12));
				hshRecord.put("perinc_otherincome", correctNull((String) rs
						.getString("perinc_otherincome")));
			}

			// This code is used for Employment Details

			strQuery = SQLParser.getSqlQuery("selcustomerdetails^" + appno
					+ "^a");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("establishdate", correctNull((String) rs
						.getString("establishdate")));
				hshRecord.put("peremp_establish", correctNull((String) rs
						.getString("establishdate")));
				hshRecord.put("peremp_design", correctNull((String) rs
						.getString("peremp_design")));
				double serviceleft = Double.parseDouble(Helper
						.correctDouble((String) rs.getString("serviceleft")));
				int service = (int) serviceleft;
				hshRecord.put("yearsofservice", Integer.toString(service));
			}

			// Code for getting means of applicant
			strQuery = SQLParser.getSqlQuery("selcreditreportdetails^" + appno
					+ "^" + appno + "^" + "a");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("CR_Total_MEANS", correctNull((String) rs
						.getString("CR_Total_MEANS")));
			}

			// This code is used for Co-Applicant details

			ArrayList veccoApp = new ArrayList();
			ArrayList vecCoApplicant = new ArrayList();
			String strConstitution = "";
			strQuery = SQLParser.getSqlQuery("selCoappGuarandet^" + appno
					+ "^c");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())

			{
				veccoApp = new ArrayList();
				veccoApp.add(correctNull(
						(String) rs.getString("perapp_title")).toUpperCase());
				veccoApp.add(correctNull((String) rs
						.getString("Appname")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_address1")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_address2")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_address3")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_city")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_state")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_zip")));
				veccoApp.add(correctNull((String) rs
						.getString("perapp_phone")));

				String CoApplicant_ID = correctNull((String) rs
						.getString("perapp_id"));
				String CoApplicant_Means = "0.00";
				if (rs2 != null) {
					rs2.close();
				}
				strQuery = SQLParser.getSqlQuery("creditapptotmeans^" + appno
						+ "^" + "c" + CoApplicant_ID);
				rs2 = DBUtils.executeQuery(strQuery);

				if (rs2.next()) {
					CoApplicant_Means = correctNull((String) rs2
							.getString("CR_Total_MEANS"));
				}
				veccoApp.add(CoApplicant_Means);
				veccoApp.add(correctNull((String) rs
						.getString("perapp_constitution")));

				if (rs2 != null) {
					rs2.close();
				}
				if (!correctNull((String) rs.getString("perapp_constitution"))
						.equals("")) {
					strQuery = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ correctNull((String) rs
											.getString("perapp_constitution")));
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						strConstitution = correctNull((String) rs2
								.getString("cbs_static_data_desc"));
					}
				}

				veccoApp.add(strConstitution);
				veccoApp.add(correctNull((String) rs
						.getString("perapp_eduothers")));
				veccoApp.add(correctNull((String) rs
						.getString("perinc_monsalary")));
				veccoApp.add(correctNull((String) rs
						.getString("perinc_yearsalary")));
				vecCoApplicant.add(veccoApp);

			}
			hshRecord.put("vecCoApplicant", vecCoApplicant);

			// This code is used for Guarantor details
			ArrayList vecGua = new ArrayList();
			ArrayList vecGuarantor = new ArrayList();

			strQuery = SQLParser.getSqlQuery("selGuarantordet^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecGua = new ArrayList();
				vecGua.add(correctNull((String) rs
						.getString("perapp_title")));
				vecGua.add(correctNull((String) rs
						.getString("GuaAppname")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_address1")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_address2")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_address3")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_city")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_state")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_zip")));
				vecGua.add(correctNull((String) rs
						.getString("perapp_phone")));

				String Guarantor_ID = correctNull((String) rs
						.getString("perapp_id"));
				String Guarantor_Means = "0.00";

				if (rs2 != null) {
					rs2.close();
				}

				strQuery = SQLParser.getSqlQuery("creditapptotmeans^" + appno
						+ "^" + "g" + Guarantor_ID);
				rs2 = DBUtils.executeQuery(strQuery);

				if (rs2.next()) {
					Guarantor_Means = correctNull((String) rs2
							.getString("CR_Total_MEANS"));
				}
				vecGua.add(Guarantor_Means);
				vecGuarantor.add(vecGua);

			}
			hshRecord.put("vecGuarantor", vecGuarantor);

			// rating score details
			strQuery = SQLParser.getSqlQuery("getretailscore^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("scoreobtained", correctNull((String) rs
						.getString("rating_score")));
			}

			// /end

			// This code is used for loandetails

			if (rs != null) {
				rs.close();
			}
			String strProdPurpose = "", strVehicleType = "";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strProdPurpose = Helper.correctNull((String) rs
						.getString("prd_purpose"));
				strVehicleType = Helper.correctNull((String) rs
						.getString("prd_vehitype"));
			}
			/*
			 * For Purchase of Ready Built House and Used Vehicle loan, Margin
			 * is based on age of the building / vehicle respectively
			 */
			if (strProdPurpose.equalsIgnoreCase("H")
					|| strProdPurpose.equalsIgnoreCase("U")
					|| strVehicleType.equalsIgnoreCase("2")) {
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^"
						+ appno);
			} else {
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshRecord.put("appno", correctNull((String) rs
						.getString("appno")));
				hshRecord.put("category", correctNull((String) rs
						.getString("category")));
				hshRecord.put("subcategory", correctNull((String) rs
						.getString("subcategory")));
				hshRecord.put("rfrom", correctNull((String) rs
						.getString("rfrom")));
				hshRecord.put("rangeto", correctNull((String) rs
						.getString("rangeto")));
				hshRecord.put("mintrate", correctNull((String) rs
						.getString("mintrate")));
				hshRecord.put("lterms", correctNull((String) rs
						.getString("lterms")));
				hshRecord.put("amtreqd", correctNull((String) rs
						.getString("amtreqd")));
				hshRecord.put("cloanprd", correctNull((String) rs
						.getString("cloanprd")));
				hshRecord.put("sancamount", correctNull((String) rs
						.getString("sancamount")));
				hshRecord.put("downpay", correctNull((String) rs
						.getString("downpay")));
				strProductType = correctNull((String) rs.getString("prd_type"));
				hshRecord.put("prd_type", strProductType);
				hshRecord.put("loan_purposeofloan", Helper.CLOBToString(rs
						.getClob("loan_purposeofloan")));
				hshRecord.put("loan_filedon", correctNull((String) rs
						.getString("loan_filedon")));
				hshRecord.put("loan_repaymenttype", correctNull((String) rs
						.getString("loan_repaymenttype")));
				hshRecord.put("loan_receivedate", correctNull((String) rs
						.getString("loan_receivedate")));
				hshRecord.put("prd_type", correctNull((String) rs
						.getString("prd_type")));
				hshRecord.put("lreqterms", correctNull((String) rs
						.getString("lreqterms")));
				hshRecord.put("margin_perct", correctNull((String) rs
						.getString("margin_perct")));
				hshRecord.put("loan_emi", correctNull((String) rs
						.getString("loan_emi")));
				strInttype = correctNull((String) rs.getString("loan_inttype"));
				hshRecord.put("loan_inttype", strInttype);
				hshRecord.put("loan_margin", correctNull((String) rs
						.getString("loan_margin")));
				hshRecord.put("loan_margin_amt", correctNull((String) rs
						.getString("raamount")));
				hshRecord.put("prd_principal", correctNull((String) rs
						.getString("prd_principal")));
				hshRecord.put("prd_interest", correctNull((String) rs
						.getString("prd_interest")));
				// hshRecord.put("salarylimit",correctNull((String)rs.getString("salarylimit")));
				hshRecord.put("offeredmargin", correctNull((String) rs
						.getString("offeredmargin")));
				hshRecord.put("loan_facility", Helper.correctNull(rs
						.getString("loan_facility")));
				hshRecord.put("minimargin", Helper.correctNull(rs
						.getString("tradein")));
				hshRecord.put("app_processdate", correctNull((String) rs
						.getString("app_processdate")));
				hshRecord.put("productloantype", correctNull((String) rs
						.getString("prd_loantype")));
				hshRecord.put("nscproduct", correctNull((String) rs
						.getString("nsc_loan")));
				hshRequestValues.put("interestcharged", correctNull((String) rs
						.getString("loan_interestcharged")));

				sancamount = Helper.correctDouble((String) rs
						.getString("sancamount"));
				hshRecord.put("sancamount", sancamount);
				double dblRepaycapacity = 0.00;
				dblRepaycapacity = Double.parseDouble(Helper.correctDouble(rs
						.getString("loan_repaycapacity")));
				hshRecord.put("dblRepaycapacity", Helper
						.formatDoubleValue(dblRepaycapacity));
				hshRecord.put("sustanence", Helper
						.formatDoubleValue(100 - dblRepaycapacity));
				double dblInterestRate = rs.getDouble("mintrate");

				double dblGrossIncome = 0.0;
				double dblNetIncome = 0.0;
				double dblOthrIncome = 0.0;
				double dblOthrDeduc = 0.0;
				double dblDeduc = 0.0;
				double dbltemp = 0.0;
				double dblRate = 0.0;
				double dblDenomi = 0.0;
				double dblNumeri = 0.0;
				double dblRepaysalary = 0.0;
				double dblRepaycapacityeligibility = 0.0;
				double dblSanctionAmount = Double.parseDouble(sancamount);
				double dblEMI = 0.0;
				double dblInterestEMI = 0.0;
				double dblstadeduc = 0.0;

				String strStaffFlag = correctNull((rs
						.getString("indinfo_is_staff")));
				String strPrincipalRatio = Helper.correctNull((String) rs
						.getString("prd_principal"));
				String strInterestRatio = Helper.correctNull((String) rs
						.getString("prd_interest"));

				int intPrincipalTerms = 0;
				int intInterestTerms = 0;
				int intPrincipalRatio = 0;
				int intInterestRatio = 0;

				intPrincipalRatio = (strPrincipalRatio.trim().equals("")) ? 0
						: Integer.parseInt(strPrincipalRatio);
				intInterestRatio = (strInterestRatio.trim().equals("")) ? 0
						: Integer.parseInt(strInterestRatio);

				// //For Staff Loan Process Note Amount Income cretria Field

				intTerms = rs.getInt("lreqterms");
				if (rs1 != null) {
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("repaymoratorium^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);

				if (rs1.next()) {
					intMoratorium = rs1.getInt("loan_noofinstallment");
				}

				// For Staff Loan Process Note

				int intTotalRatio = intPrincipalRatio + intInterestRatio;
				if (intTotalRatio != 0) {
					intPrincipalTerms = intTerms * intPrincipalRatio
							/ intTotalRatio;
				} else {
					intPrincipalTerms = 0;
				}
				intInterestTerms = intTerms - intPrincipalTerms;

				if (dblRepaycapacity > 0) {
					if (rs != null)
						rs.close();

					strQuery = SQLParser.getSqlQuery("pergetIncome^" + appno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						dblGrossIncome = Double.parseDouble(Helper
								.correctDouble(rs
										.getString("perinc_yearsalary")));
						dblNetIncome = Double
								.parseDouble(Helper.correctDouble(rs
										.getString("perinc_takehome")));
						dblOthrIncome = Double
								.parseDouble(Helper.correctDouble(rs
										.getString("perinc_secincome")));
						dblOthrDeduc = Double.parseDouble(Helper
								.correctDouble(rs
										.getString("perinc_yearotherdeduc")));
						dblDeduc = Double.parseDouble(Helper.correctDouble(rs
								.getString("perinc_yeardeduction")));
						dblstadeduc = Double
								.parseDouble(Helper.correctDouble(rs
										.getString("perinc_deduction")));
					}
					if (strStaffFlag.trim().equalsIgnoreCase("Y")
							&& intInterestRatio > 0 && intPrincipalRatio > 0) {
						if (((dblNetIncome / 12) - (dblSanctionAmount / intPrincipalTerms)) >= (dblGrossIncome - (dblGrossIncome
								* dblRepaycapacity / 100))) {
							dblRepaycapacityeligibility = dblSanctionAmount;
						} else if ((dblGrossIncome - (dblGrossIncome
								* dblRepaycapacity / 100)) < (dblNetIncome)) {

							dblRepaycapacityeligibility = ((dblNetIncome - (dblGrossIncome - (dblGrossIncome
									* dblRepaycapacity / 100))) * intPrincipalTerms) / 12;
						} else
							dblRepaycapacityeligibility = 0;

					} else {
						// INSTRUCTION GIVEN BY MADHU
						int inttmpterms = 0;
						inttmpterms = intTerms - intMoratorium;
						dblRate = dblInterestRate / (12 * 100);
						dblDenomi = Math.pow(dblRate + 1, inttmpterms) - 1;
						dblNumeri = dblRate
								* Math.pow(dblRate + 1, inttmpterms);

						double dblDeductions = dblOthrDeduc + dblDeduc;

						dblRepaysalary = dblRepaycapacity
								* (dblGrossIncome + dblOthrIncome) / 100;
						dbltemp = (dblRepaysalary - dblDeductions) / 12;
						if (dblNumeri != 0) {
							dblRepaycapacityeligibility = (dbltemp * dblDenomi)
									/ dblNumeri;
						} else {
							dblRepaycapacityeligibility = 0;
						}
						if (dblRepaycapacityeligibility < 0.0)
							dblRepaycapacityeligibility = 0.0;
					}

				}
				hshRecord.put("dblRepaycapacityeligibility", Helper
						.formatDoubleValue(dblRepaycapacityeligibility));

				// Calculating Principal payments
				if (intPrincipalTerms != 0) {
					dblEMI = dblSanctionAmount / intPrincipalTerms;
				} else {
					dblEMI = 0;
				}

				double dblActualAmtDue = dblSanctionAmount;
				dblRate = dblInterestRate / (12 * 100);
				double dblInterest = 0.0;
				double dblTotalEmi = 0.0;

				for (int i = 0; i < intPrincipalTerms; i++) {
					dblInterest = dblInterest + (dblActualAmtDue * dblRate);
					dblActualAmtDue = dblActualAmtDue - dblEMI;
				}
				if (intInterestTerms != 0) {
					dblInterestEMI = dblInterest / intInterestTerms;
				} else {
					dblInterestEMI = 0;
				}

				dblTotalEmi = dblEMI + dblInterestEMI;

				double TotAmount = 0.00;
				double dblmonGrossincome = 0.0;
				double dblothrdeducmonthly = 0.0;
				double dblmonothrinc = 0.0;
				dblothrdeducmonthly = dblOthrDeduc / 12;
				dblmonGrossincome = dblGrossIncome / 12;
				dblmonothrinc = dblOthrIncome / 12;

				if (strStaffFlag.trim().equalsIgnoreCase("Y")
						&& intInterestRatio > 0 && intPrincipalRatio > 0) {
					// double
					TotAmount = dblmonGrossincome - dblstadeduc
							- dblothrdeducmonthly + dblmonothrinc - dblEMI;
				} else {
					TotAmount = dblmonGrossincome - dblstadeduc
							- dblothrdeducmonthly + dblmonothrinc - dblTotalEmi;
				}

				double percenGrossSalary = 0.0;
				if (dblmonGrossincome != 0) {
					percenGrossSalary = ((TotAmount / (dblmonGrossincome + dblmonothrinc)) * 100);
				} else {
					percenGrossSalary = 0;
				}
				hshRecord.put("percenGrossSalary", Helper
						.formatDoubleValue(percenGrossSalary));
				// dblGrossIncome

				// For Staff Loan Process Note Interest Field

				// Added by Shahul
				ArrayList vecRowslab = new ArrayList();
				ArrayList vecColslab = new ArrayList();
				strQuery = SQLParser.getSqlQuery("sel_calslabrateRange2^"
						+ strPrdcode + "^" + sancamount + "^" + sancamount
						+ "^" + sancamount);
				if (rs1 != null) {
					rs1.close();
				}

				rs1 = DBUtils.executeQuery(strQuery);
				while (rs1.next()) {
					vecColslab = new ArrayList();
					vecColslab.add(rs1.getString(1));
					vecColslab.add(rs1.getString(2));
					vecColslab.add(rs1.getString(3));
					vecRowslab.add(vecColslab);
				}
				hshRecord.put("vecRowslab", vecRowslab);

			}

			// This is for periodicity of loans
			strQuery = SQLParser.getSqlQuery("securesel^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("loan_periodicity", correctNull((String) rs
						.getString("loan_periodicity")));
				hshRecord.put("loan_noofinstallment", correctNull((String) rs
						.getString("loan_noofinstallment")));
				hshRequestValues.put("servised", correctNull((String) rs
						.getString("loan_servised")));
				hshRecord.put("loan_secure", correctNull((String) rs
						.getString("loan_secure")));

			}

			if (strInttype.equalsIgnoreCase("Combo")) {
				hshRequestValues.put("recamt", sancamount);
				hshRequestValues.put("terms", "" + intTerms);
				hshRequestValues.put("moritorium", "" + intMoratorium);
				hshRecord.putAll((HashMap) EJBInvoker.executeStateLess(
						"perapplicant", hshRequestValues, "getComboRateChart"));
			}

			// This code is used for getting Housing details
			// ArrayList arrProposed=new ArrayList();
			strQuery = SQLParser.getSqlQuery("propdetailsel^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("prop_builtup", correctNull((String) rs
						.getString("prop_builtup")));
				hshRecord.put("prop_allotted", correctNull((String) rs
						.getString("prop_allotted")));
				hshRecord.put("prop_purpose", correctNull((String) rs
						.getString("prop_purpose")));
				hshRecord.put("prop_areaofplot", correctNull((String) rs
						.getString("prop_areaofplot")));
				hshRecord.put("prop_proposedbuildup", correctNull((String) rs
						.getString("prop_proposedbuildup")));
				hshRecord.put("prop_purchaseprice", correctNull((String) rs
						.getString("prop_purchaseprice")));
				hshRecord.put("prop_costofcomplete", correctNull((String) rs
						.getString("prop_costofcomplete")));
				hshRecord.put("prop_totalcostloan", correctNull((String) rs
						.getString("prop_totalcostloan")));
				hshRecord.put("prop_estimatecost", correctNull(rs
						.getString("prop_estimatecost")));
				hshRecord.put("prop_type", correctNull((String) rs
						.getString("prop_type")));
				hshRecord.put("prop_mortgage", correctNull((String) rs
						.getString("prop_mortgage")));
				hshRecord.put("prop_housetype", correctNull((String) rs
						.getString("prop_housetype")));
				hshRecord.put("prop_mar_land", correctNull((String) rs
						.getString("prop_mar_land")));
				hshRecord.put("prop_mar_build", correctNull((String) rs
						.getString("prop_mar_build")));
				hshRecord.put("prop_sellername", correctNull((String) rs
						.getString("prop_sellername")));
				hshRecord.put("prop_sell_add", correctNull((String) rs
						.getString("prop_sell_add")));
				hshRecord.put("prop_houseno", correctNull((String) rs
						.getString("prop_houseno")));
				hshRecord.put("prop_area", correctNull((String) rs
						.getString("prop_area")));
				hshRecord
						.put("hidcity", correctNull(rs.getString("prop_city")));
				hshRecord.put("hidstate", correctNull(rs
						.getString("prop_state")));
				hshRecord.put("prop_city", correctNull(rs
						.getString("city_name")));
				hshRecord.put("prop_state", correctNull(rs
						.getString("state_name")));
				hshRecord.put("prop_pin", correctNull((String) rs
						.getString("prop_pin")));
				hshRecord.put("prop_nature", correctNull((String) rs
						.getString("prop_nature")));
				hshRecord.put("prop_housingaddress", correctNull((String) rs
						.getString("prop_housingaddress")));
				hshRecord.put("prop_intermsecurity", correctNull((String) rs
						.getString("prop_intermsecurity")));

				// ArrayList arrProp=new ArrayList();
				// arrProp.add(correctNull((String)rs.getString("prop_appid")));
				// arrProp.add(correctNull((String)rs.getString("prop_houseno")));
				// arrProp.add(correctNull((String)rs.getString("prop_area")));
				// arrProp.add(correctNull((String)rs.getString("prop_city")));
				// arrProp.add(correctNull((String)rs.getString("prop_pin")));
				// arrProp.add(correctNull((String)rs.getString("prop_housingaddress")));
				// arrProp.add(correctNull((String)rs.getString("city_name")));
				// arrProp.add(correctNull((String)rs.getString("state_name")));
				// arrProp.add(correctNull((String)rs.getString("prop_intermsecurity")));
				// arrProposed.add(arrProp);

			}
			// hshRecord.put("arrProposed",arrProposed);

			// if(strProductType.equalsIgnoreCase("PA"))
			// {
			// This code is used for Vehicle details

			strQuery = SQLParser.getSqlQuery("selVehicledet^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {

				hshRecord.put("auto_model", correctNull((String) rs
						.getString("auto_model")));
				hshRecord.put("auto_category", correctNull((String) rs
						.getString("auto_category")));
				hshRecord.put("auto_articlename", correctNull((String) rs
						.getString("auto_articlename")));
				hshRecord.put("verf_doneby", correctNull((String) rs
						.getString("verf_doneby")));
				hshRecord.put("auto_deleraddress2", correctNull((String) rs
						.getString("auto_deleraddress2")));
				hshRecord.put("auto_deleraddress1", correctNull((String) rs
						.getString("auto_deleraddress1")));
				hshRecord.put("auto_dealer", correctNull((String) rs
						.getString("auto_dealer")));
				hshRecord.put("auto_delercity", correctNull((String) rs
						.getString("auto_delercity")));
				hshRecord.put("auto_purpose", correctNull((String) rs
						.getString("auto_purpose")));
				hshRecord.put("auto_make", correctNull((String) rs
						.getString("auto_make")));
				hshRecord.put("auto_valuation", correctNull((String) rs
						.getString("auto_valuation")));
				hshRecord.put("auto_valuationentry", correctNull((String) rs
						.getString("auto_valuationentry")));
				hshRecord.put("auto_delerstate", correctNull((String) rs
						.getString("auto_delerstate")));
				hshRecord.put("auto_tax", correctNull((String) rs
						.getString("auto_tax")));
				hshRecord.put("auto_insurance", correctNull((String) rs
						.getString("auto_insurance")));
				hshRecord.put("auto_charges", correctNull((String) rs
						.getString("auto_charges")));
				hshRecord.put("auto_vehicletype", correctNull((String) rs
						.getString("auto_vehicletype")));
				hshRecord.put("auto_originalcost", correctNull((String) rs
						.getString("auto_originalcost")));
				hshRecord.put("auto_actualconsideration",
						correctNull((String) rs
								.getString("auto_actualconsideration")));
				hshRecord.put("auto_registration", correctNull((String) rs
						.getString("auto_registration")));

			}
			// }

			// this code is used for Education detail
			// if(rs!=null)
			// {
			// rs.close();
			// }
			// rs=DBUtils.executeLAPSQuery("eduparticularssel^"+appno);

			// if (rs.next())
			// {
			// hshRecord.put("eduloan_appno",correctNull(rs.getString("eduloan_appno")));
			// hshRecord.put("edu_coursename",correctNull(rs.getString("edu_coursename")));
			// hshRecord.put("edu_course_approved",correctNull(rs.getString("edu_course_approved")));
			// hshRecord.put("edu_course_approvedby",correctNull(rs.getString("edu_course_approvedby")));
			// hshRecord.put("edu_univ_name",correctNull(rs.getString("edu_univ_name")));
			// hshRecord.put("edu_univ_approved",correctNull(rs.getString("edu_univ_approved")));
			// hshRecord.put("edu_univ_approvedby",correctNull(rs.getString("edu_univ_approvedby")));
			// hshRecord.put("edu_univ_addr",correctNull(rs.getString("edu_univ_addr")));
			// hshRecord.put("edu_duration",correctNull(rs.getString("edu_duration")));
			// hshRecord.put("edu_partfull",correctNull(rs.getString("edu_partfull")));
			// hshRecord.put("edu_qual_proposed",correctNull(rs.getString("edu_qual_proposed")));
			// hshRecord.put("edu_commencedate",correctNull(rs.getString("edu_commencedate")));
			// hshRecord.put("edu_mode_secure",correctNull(rs.getString("edu_mode_secure")));
			// hshRecord.put("edu_univ_situ_domicile",correctNull(rs.getString("edu_univ_situ_domicile")));
			// hshRecord.put("edu_comp_stay_hostel",correctNull(rs.getString("edu_comp_stay_hostel")));
			// hshRecord.put("edu_comments1",correctNull(rs.getString("edu_comments1")));
			// hshRecord.put("edu_comments2",correctNull(rs.getString("edu_comments2")));
			// hshRecord.put("edu_comments3",correctNull(rs.getString("edu_comments3")));
			// hshRecord.put("edu_comments4",correctNull(rs.getString("edu_comments4")));
			// hshRecord.put("edu_studies_in",correctNull(rs.getString("edu_studies_in")));
			// hshRecord.put("expected_income",correctNull(rs.getString("expected_income")));
			// }

			// for checking whether documents are produced are not
			if (rs != null) {
				rs.close();
			}
			String documentsfurnished = "Y";
			rs = DBUtils.executeLAPSQuery("SelMandDocCheckapplicant^" + appno
					+ "^" + strPrdcode);
			if (rs.next()) {
				documentsfurnished = "N";
				hshRecord.put("documentsfurnished", documentsfurnished);
			}
			hshRecord.put("documentsfurnished", documentsfurnished);

			/*********************** STARTS PROCESSING FEES *************/
			HashMap hshTemp = new HashMap();
			HashMap hshGetDocFee = new HashMap();
			// String
			// strPrdCode=correctNull((String)hshRequestValues.get("prdcode"));
			String strLoanDocFee = "";
			String strLoanProcFee = "";

			hshTemp.put("appid", appno);
			hshTemp.put("prdcode", strPrdcode);
			hshTemp.put("recamt", sancamount); // afetr slab
			hshGetDocFee = (HashMap) EJBInvoker.executeStateLess(
					"perlimitofloan", hshTemp, "getDocFee");
			strLoanDocFee = (String) hshGetDocFee.get("docfee");
			strLoanProcFee = (String) hshGetDocFee.get("procfeenew");
			hshRecord.put("docfee", correctNull(strLoanDocFee));
			hshRecord.put("procfee", correctNull(strLoanProcFee));
			/********************** ENDS *******************************/

			/********** This Code is used for Networth Income Details *********************************/
			// HashMap hshnet=new HashMap();
			// HashMap hshnetworth=new HashMap();
			// hshnet.put("appno",appno);
			// hshnetworth=(HashMap)EJBInvoker.executeStateLess("appraisal",hshnet,"getloandetails");
			// hshRecord.put("vecReport",hshnetworth.get("vecReport"));
			/******************** Ends *********************************/
			/*
			 * rs = DBUtils.executeLAPSQuery("selincomeborrower^"+appno+"^a");
			 * if(rs.next()) {
			 * hshRecord.put("permonsalary",correctNull((String)rs
			 * .getString("permonsalary")));
			 * hshRecord.put("peryearsalary",correctNull
			 * ((String)rs.getString("peryearsalary"))); }
			 */
			/****************************** Ends *************************************/
			ArrayList arrTerms = new ArrayList();
			ArrayList arrTermsId = new ArrayList();

			rs = DBUtils.executeLAPSQuery("apptermscondsel^" + appno);
			while (rs.next()) {
				arrTerms = new ArrayList();
				arrTerms.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));
				arrTerms.add(correctNull(rs.getString(3)));
				arrTermsId.add(arrTerms);
			}
			hshRecord.put("arrTermsId", arrTermsId);

			/**
			 * Added for selecting EMI Date
			 */
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selemidate^" + appno);
			while (rs.next()) {
				hshRecord.put("emidate", correctNull(rs.getString("emidate")));
				hshRecord
						.put("emidate1", correctNull(rs.getString("emidate1")));
			}
			rs.close();

			/****************************** Ends *************************************/
			/**
			 * Added for attaching documents
			 */
			ArrayList arrDocs = new ArrayList();
			ArrayList arrDocsId = new ArrayList();

			rs = DBUtils.executeLAPSQuery("appdocssel^" + appno);
			while (rs.next()) {
				arrDocs = new ArrayList();
				arrDocs.add(correctNull(rs.getString(3)));
				arrDocs.add(correctNull(rs.getString(2)));
				arrDocsId.add(arrDocs);
			}
			hshRecord.put("arrDocsId", arrDocsId);

			if (rs != null) {
				rs.close();
			}
			arrDocsId = new ArrayList();
			rs = DBUtils.executeLAPSQuery("appdocsapplicant^" + appno);
			while (rs.next()) {
				arrDocs = new ArrayList();
				arrDocs.add(correctNull(rs.getString(1)));
				arrDocs.add(correctNull(rs.getString(2)));
				arrDocsId.add(arrDocs);
			}
			hshRecord.put("arrDocsapplicant", arrDocsId);

			// This Code is used for Organisation details

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selBranchCityName^" + appno);
			while (rs.next()) {
				strorgname = correctNull(rs.getString("org_name"));

				hshRecord.put("orgname", correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1", correctNull(rs.getString("org_add1")));
				hshRecord.put("orgadd2", correctNull(rs.getString("org_add2")));
				hshRecord
						.put("orgcity", correctNull(rs.getString("city_name")));
				hshRecord.put("orgstate", correctNull(rs
						.getString("state_name")));
				hshRecord.put("orgzip", correctNull(rs.getString("org_zip")));
				hshRecord.put("orgphone",
						correctNull(rs.getString("org_phone")));
			}

			if (strBranchName == null || strBranchName.equals("")) {
				strBranchName = strorgname;

				// flag="1";
			}
			// hshRecord.put("flag",flag);
			hshRecord.put("branchName", strBranchName);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selpreinspectionvisit^" + appno);
			if (rs.next()) {
				hshRecord.put("pre_signdate", correctNull(rs
						.getString("pre_signdate")));
				hshRecord.put("pre_visitdate", correctNull(rs
						.getString("pre_visitdate")));
				hshRecord.put("pre_pensionnominee", correctNull((String) rs
						.getString("pre_pensionnominee")));
			}

			/* from collateral Security House Details */

			if (rs != null)
				rs.close();

			ArrayList arrCollateral = new ArrayList();

			rs = DBUtils.executeLAPSQuery("sel_collatraldetails_processnote^"
					+ appno);

			while (rs.next()) {
				ArrayList arrColl = new ArrayList();
				arrColl.add(correctNull((String) rs.getString("home_appid")));
				arrColl
						.add(correctNull((String) rs
								.getString("home_titleadd1")));
				arrColl
						.add(correctNull((String) rs
								.getString("home_titleadd2")));
				arrColl.add(correctNull((String) rs.getString("city_name")));
				arrColl.add(correctNull((String) rs.getString("state_name")));
				arrColl
						.add(correctNull((String) rs.getString("home_titlezip")));
				arrColl.add(correctNull((String) rs
						.getString("home_contperson")));
				arrColl.add(correctNull((String) rs.getString("home_yrbuilt")));
				arrColl.add(correctNull((String) rs
						.getString("home_purchaseval")));
				arrColl.add(correctNull((String) rs.getString("home_appval")));
				arrCollateral.add(arrColl);
			}
			hshRecord.put("arrCollateral", arrCollateral);

			// for comfort loan from the other assets
			if (rs != null)
				rs.close();

			ArrayList arrAsset = new ArrayList();
			rs = DBUtils
					.executeLAPSQuery("perotherassetselect^" + appno + "^1");
			while (rs.next()) {
				ArrayList arrAss = new ArrayList();
				arrAss.add(correctNull((String) rs
						.getString("asset_assdetails")));
				arrAss.add(correctNull((String) rs.getString("asset_dealer")));
				arrAss.add(correctNull((String) rs
						.getString("asset_puchaseprice")));
				arrAss.add(correctNull((String) rs.getString("asset_invoice")));
				arrAss.add(correctNull((String) rs
						.getString("asset_marketvalue")));
				arrAss
						.add(correctNull((String) rs
								.getString("asset_incincome")));
				arrAss.add(correctNull((String) rs.getString("asset_need")));
				arrAsset.add(arrAss);
			}
			hshRecord.put("arrAsset", arrAsset);

			// from financial Investment/terms for onlys collateral

			if (rs != null)
				rs.close();
			ArrayList arrInvestment = new ArrayList();
			// ArrayList arrShare = new ArrayList();

			rs = DBUtils.executeLAPSQuery("sel_investterms_processnote^"
					+ appno);

			while (rs.next()) {
				ArrayList arrInv = new ArrayList();
				// ArrayList arrSh = new ArrayList();
				// if(correctNull(rs.getString("stoc_isshare")).equalsIgnoreCase("N"))
				// {
				arrInv.add(rs.getString("stoc_desc"));
				arrInv.add(Helper.formatDoubleValue(rs
						.getDouble("stoc_shareval")));
				arrInvestment.add(arrInv);
				// }
				// else
				// {
				// arrSh.add(rs.getString("stoc_desc"));
				// arrSh.add(Helper.formatDoubleValue(rs.getDouble("stoc_shareval")));
				// arrShare.add(arrSh);
				// }
			}

			hshRecord.put("arrInvestment", arrInvestment);
			// hshRecord.put("arrShare",arrShare);

			if (rs != null)
				rs.close();
			ArrayList arrInsurance = new ArrayList();
			rs = DBUtils.executeLAPSQuery("sel_insurance_processnote^" + appno);
			while (rs.next()) {
				ArrayList arrIns = new ArrayList();
				arrIns.add(rs.getString("insu_policyno"));
				arrIns.add(rs.getString("insu_agencyname"));
				double surrenderval = Double.parseDouble(Helper
						.correctDouble(rs.getString("insu_surrenderval")));
				arrIns.add(Helper.formatDoubleValue(surrenderval));
				arrInsurance.add(arrIns);
			}
			hshRecord.put("arrInsurance", arrInsurance);

			if (rs != null)
				rs.close();

			ArrayList arrPerAuto = new ArrayList();
			rs = DBUtils.executeLAPSQuery("sel_collsec_prop^" + appno);
			while (rs.next()) {
				ArrayList arrAuto = new ArrayList();
				arrAuto.add(rs.getString("auto_model"));
				arrAuto.add(rs.getString("auto_make"));
				arrAuto.add(rs.getString("auto_serialno"));
				arrPerAuto.add(arrAuto);
			}
			hshRecord.put("arrPerAuto", arrPerAuto);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_vehicledetails^" + appno);
			while (rs.next()) {
				hshRecord.put("total_newvehicle", correctNull(rs
						.getString("total_newvehicle")));
				// hshRecord.put("auto_category",
				// correctNull((String)rs.getString("auto_category")));
				hshRecord.put("auto_leastvalue", correctNull((String) rs
						.getString("auto_leastvalue")));
			}

			if (rs != null)
				rs.close();
			if ("pR".equals(strProductType)) {
				ArrayList arrSecurity = new ArrayList();
				ArrayList arrSecurityRow = new ArrayList();
				String date1 = "", date2 = "", date3 = "";
				strQuery = SQLParser.getSqlQuery("sel_loanagainstdeposit^"
						+ appno);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					arrSecurity = new ArrayList();
					arrSecurity.add(rs.getString(1));
					arrSecurity.add(rs.getString(2));
					arrSecurity.add(rs.getString(3));
					arrSecurity.add(rs.getString(4));
					date1 = Helper.correctNull((String) rs.getString(5));
					if (date1.equalsIgnoreCase("01/01/1900")) {
						date1 = "";
					}
					arrSecurity.add(date1);
					arrSecurity.add(rs.getString(6));
					arrSecurity.add(rs.getString(7));
					arrSecurity.add(rs.getString(8));
					date3 = Helper.correctNull((String) rs.getString(9));
					if (date3.equalsIgnoreCase("01/01/1900")) {
						date3 = "";
					}
					arrSecurity.add(date3);
					arrSecurity.add(rs.getString(10));
					arrSecurity.add(rs.getString(11));
					date2 = Helper.correctNull((String) rs.getString(12));
					if (date2.equalsIgnoreCase("01/01/1900")) {
						date2 = "";
					}
					arrSecurity.add(date2);
					arrSecurity.add(rs.getString(13));
					arrSecurity.add(rs.getString(14));
					arrSecurityRow.add(arrSecurity);
				}
				hshRecord.put("arrRow", arrSecurityRow);

				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(SQLParser
						.getSqlQuery("get_renewalDetails^" + appno));
				if (rs.next()) {
					hshRecord.put("txtarea_compliance", correctNull(rs
							.getString("per_compliance")));
					hshRecord.put("txtarea_documents", correctNull(rs
							.getString("per_documents")));
					hshRecord.put("txtarea_fdr", correctNull(rs
							.getString("per_fdc")));
					hshRecord.put("txtarea_audit", correctNull(rs
							.getString("per_audit")));
				}
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_orgname_cusprofile^" + strappId);
			if (rs.next()) {
				hshRecord.put("cus_org_name", Helper.correctNull((String) rs
						.getString("org_name")));
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selmaiboxcomments^" + appno);
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("usr_fname")));
				arrCol.add(correctNull(Helper.CLOBToString(rs
						.getClob("mail_comments"))));
				arrRow.add(arrCol);
			}

			hshRecord.put("mailcomments", arrRow);

			hshRecord.putAll((HashMap) EJBInvoker.executeStateLess(
					"perapplicant", hshRecord, "checkEligibility"));

		} catch (Exception e) {
			throw new EJBException("Error closing the connection "
					+ e.getMessage());
		}

		finally {
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
				if (rs10 != null) {
					rs10.close();
				}

			} catch (Exception e) {
				throw new EJBException("Exception in Closing Connection "
						+ e.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap getEligibilityCriteria(HashMap hshValues)
			 {
		HashMap hshRecord = new HashMap();

		try {

		} catch (Exception e) {
			throw new EJBException("Error in getEligibilityCriteria :: "
					+ e.toString());
		}

		return hshRecord;
	}

	public HashMap getRetailProcessNote(HashMap hshValues)  {
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		HashMap hshRecord = new HashMap();
		HashMap hshResult = new HashMap();
		HashMap hshFinValues = new HashMap();
		HashMap hshReqValues = new HashMap();
		ArrayList arrayCol = new ArrayList();
		ArrayList arrayRow = new ArrayList();
		ArrayList arrayRow1 = new ArrayList();
		ArrayList arrAppLiabRow = new ArrayList();
		ArrayList arrAppLiabCol = new ArrayList();
		ArrayList arrJAppLiabRow = new ArrayList();
		ArrayList arrJAppLiabCol = new ArrayList();
		ArrayList arrGuarLiabRow = new ArrayList();
		ArrayList arrGuarLiabCol = new ArrayList();
		ArrayList arrGuardetails = new ArrayList();
		ArrayList arrGuardetailsRow = new ArrayList();
		ArrayList arrProperitierdetails = new ArrayList();
		ArrayList arrProperitierdetailsRow = new ArrayList();
		ArrayList arrRowBor=new ArrayList();
		ArrayList arrColBor= null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null,rs4=null;
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strApplicationNo = "", strOrgCode = "";
		String strQuery = "", strQuery1 = "", strQuery2 = "", strQuery3 = "";
		String strappId = "";
		String strtake = "";
		String strOrgRegion = "";
		String strOrgRegionName = "";
		String strAppReceivedDate = "";
		String strCLPUdate = "";
		String strSanctioningAuth = "";
		String strConstitution = "", strConstCode = "";
		String strBanking = "", strBankingSince = "", strConstCode1 = "";
		String strCoAppID = "";
		String strGuarID = "";
		int intInstallmentExcHoliday = 0;
		String strAppid = Helper
				.correctNull((String) hshValues.get("comappid"));
		String strProductType = Helper.correctNull((String) hshValues
				.get("strProductType"));
		String strCity = "", strState = "", strCountry = "", strdistrict = "";
		String strPrdcode = Helper
				.correctInt((String) hshValues.get("prdcode"));
		String strCustId = "", strOccuCode = "", strOccuCode1 = "";
		String strEmpStatus = "", strRepayType = "";
		String strinw_orgcode = "";
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList vecDataSchl = new ArrayList();
		String staffproduct = "";
		String strNewEmployment = "";
		String strDemoRelation = "";
		String strRelDesc = "", strAppType = "";
		String strVerifyWithCFR = "", strNamApprCFR = "", strRefNoCFR = "", ApprUserid = "", strStatusVer = "";
		double MonthlyIncome = 0.00, Monthlydeduction = 0.00;
		String strgstnumber="",srwhethergstn="",strexempted="";
		String strborrower="",strpurposeloan="",stragriallied="",strpermact="",strpermactelig="",
		strexposueelig="",strborroweravailed="",strborroweravailedelig="",strmsmerestscheme="",strmsmerestschemeelig="",strframework="",strframeworkelig="";
		
		DscrBean dscrobj = new DscrBean();
		try {
			String strAmountForm = Helper.correctNull((String) hshValues
					.get("strAmountVal"));

			strNewEmployment = correctNull((String) hshValues
					.get("strNewEmployment"));
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strappId = Helper.correctNull((String) hshValues.get("comappid"));
			strOrgCode = Helper.correctNull((String) hshValues
					.get("strOrgCode"));
			strQuery = SQLParser.getSqlQuery("selBranchCityName^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("orgname", correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1", correctNull(rs.getString("org_add1")));
				hshRecord.put("orgadd2", correctNull(rs.getString("org_add2")));
				hshRecord
						.put("orgcity", correctNull(rs.getString("city_name")));
				hshRecord.put("orgstate", correctNull(rs
						.getString("state_name")));
				hshRecord.put("orgzip", correctNull(rs.getString("org_zip")));
				hshRecord.put("orgphone",
						correctNull(rs.getString("org_phone")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selapprecdate^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strAppReceivedDate = Helper.correctNull((String) rs
						.getString("inward_appliedon"));
				hshRecord.put("clpudate", Helper.correctNull((String) rs
						.getString("inward_clpudate")));
				// strCLPUdate=Helper.correctNull((String)rs.getString("inward_clpudate"));
			}

			if (rs != null) {
				rs.close();
			}
			/*
			 * strQuery=SQLParser.getSqlQuery("sel_sanctionbranch^"+strApplicationNo
			 * +"^"+strApplicationNo); rs=DBUtils.executeQuery(strQuery);
			 * if(rs.next()) {
			 * hshRecord.put("homebranch",Helper.correctNull((String
			 * )rs.getString("org_name"))); } if(rs !=null) { rs.close(); }
			 */
			strQuery = SQLParser.getSqlQuery("sel_branchname^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strPrdcode = Helper.correctNull(rs.getString("app_prdcode"));

				if (Helper.correctNull(rs.getString("inward_applnprocessat"))
						.equalsIgnoreCase("6"))
					hshRecord.put("homebranch", Helper.correctNull((String) rs
							.getString("org_name"))
							+ " [RLPC]");
				else if (Helper.correctNull(
						rs.getString("inward_applnprocessat"))
						.equalsIgnoreCase("3"))
					hshRecord.put("homebranch", Helper.correctNull((String) rs
							.getString("org_name"))
							+ " [CLPU]");
				else
					hshRecord.put("homebranch", Helper.correctNull((String) rs
							.getString("org_name")));

				strinw_orgcode = Helper.correctNull((String) rs
						.getString("org_code"));
				
				if(Helper.correctNull(rs.getString("app_orglevel")).equalsIgnoreCase("C")||Helper.correctNull(rs.getString("app_orglevel")).equalsIgnoreCase("D"))
				{
					strQuery = SQLParser.getSqlQuery("sel_pertainingbr_ret^"
							+ strApplicationNo);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						hshRecord.put("homebranch", correctNull(rs.getString("org_name")));
						strinw_orgcode=Helper.correctNull(rs.getString("org_code"));
					}
				}
			}
			if (rs != null) {
				rs.close();
			}
			if (!strinw_orgcode.equalsIgnoreCase("")) {
				strOrgRegion = strinw_orgcode.substring(0, 6);
			}
			strOrgRegion = strOrgRegion + "000000000";
			strQuery = SQLParser.getSqlQuery("selorgname^" + strOrgRegion);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strOrgRegionName = Helper.correctNull((String) rs
						.getString("org_name"));
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("strOrgRegionName", strOrgRegionName);
			hshRecord.put("strAppReceivedDate", strAppReceivedDate);
			/*
			 * For getting the Personal Information of the Applicant / Joint
			 * Applicant
			 */
			strQuery=SQLParser.getSqlQuery("selbeneficial^"+strappId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrColBor=new ArrayList();
				arrColBor.add(Helper.correctNull((String)rs.getString("BEN_OWN_ID")));
				arrColBor.add(Helper.correctNull((String)rs.getString("BEN_OWN")));
				String identidoc=Helper.correctNull((String)rs.getString("ID_DOC"));
				strQuery=SQLParser.getSqlQuery("selectidentificationdoc^"+identidoc);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				arrColBor.add(Helper.correctNull((String)rs2.getString("STAT_DATA_DESC1")));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
				arrColBor.add(Helper.correctNull((String)rs.getString("ID_DOC_NUM")));
				arrColBor.add(Helper.correctNull((String)rs.getString("PERC_SHARES_HELD")));
				String relatborr=Helper.correctNull((String)rs.getString("RELA_BORR"));
				strQuery=SQLParser.getSqlQuery("selectrelationshipwithborrower^"+relatborr);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				arrColBor.add(Helper.correctNull((String)rs2.getString("CBS_STATIC_DATA_DESC")));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
				arrColBor.add(Helper.correctNull((String)rs.getString("NO_SHARES_HELD")));
				arrColBor.add(Helper.correctNull((String)rs.getString("GUART_AVB")));
				arrRowBor.add(arrColBor);
			}
			hshRecord.put("arrRowBor", arrRowBor);
			strQuery = SQLParser.getSqlQuery("sel_appl_details^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cus_id", Helper.correctNull((String) rs
						.getString("perapp_id")));
				hshRecord.put("app_processdate", Helper.correctNull((String) rs
						.getString("app_processdate")));
				hshRecord.put("perapp_employment",
						Helper.correctNull((String) rs
								.getString("perapp_employment")));
				strCustId = Helper.correctNull((String) rs
						.getString("perapp_id"));
				hshRecord.put("cus_name", Helper.correctNull((String) rs
						.getString("fullname")));
				hshRecord.put("app_cpcdate", Helper.correctNull((String) rs
						.getString("app_cpcdate")));
				hshRecord.put("app_clpudate", Helper.correctNull((String) rs
						.getString("app_clpudate")));
				hshRecord.put("APP_ROHODATE", Helper.correctNull((String) rs
						.getString("APP_ROHODATE")));
				hshRecord.put("cus_dob", Helper.correctNull((String) rs
						.getString("dob")));
				hshRecord.put("PERAPP_MSE_REGNO", Helper.correctNull((String) rs
						.getString("PERAPP_MSE_REGNO")));
				hshRecord.put("PERAPP_UDYOG_AADHAR", Helper.correctNull((String) rs
						.getString("PERAPP_UDYOG_AADHAR")));
				strConstCode = Helper.correctNull((String) rs
						.getString("perapp_constitution"));
				strEmpStatus = Helper.correctNull((String) rs
						.getString("empemployment"));
				strAppType = Helper.correctNull(rs.getString("app_renew_flag"));
				if (strAppType.equalsIgnoreCase("S"))
					strAppType = "Restructure";
				else if (strAppType.equalsIgnoreCase("R"))
					strAppType = "Renew";
				else if (strAppType.equalsIgnoreCase("P"))
					strAppType = "Postsanction";
				else
					strAppType = "Fresh";

				hshRecord.put("strAppType", strAppType);
				hshRecord.put("strConstCode", strConstCode);
				if (!strConstCode.equalsIgnoreCase("")) {
					strQuery1 = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ strConstCode);
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						strConstitution = Helper.correctNull((String) rs1
								.getString("cbs_static_data_desc"));
					}
				}
				hshRecord.put("strConstitution", strConstitution);
				strBanking = Helper.correctNull((String) rs
						.getString("perapp_bank"));
				if (strBanking.equalsIgnoreCase("1")) {
					strBankingSince = Helper.correctNull((String) rs
							.getString("perapp_banksince"));
				} else {
					strBankingSince = "No";
				}
				hshRecord.put("strBankingSince", strBankingSince);
				hshRecord.put("strNetworth", nf.format(Double
						.parseDouble(Helper.correctDouble(rs
								.getString("perapp_networth")))));
				hshRecord.put("strNetworthAson", Helper.correctNull(rs
						.getString("perapp_networthason")));
				strQuery2 = SQLParser.getSqlQuery("sel_customerdetail^"
						+ strappId);
				rs2 = DBUtils.executeQuery(strQuery2);
				if (rs2.next()) {
					String residentType = correctNull(rs2
							.getString("INDINFO_RESIDENT_STATUS"));
					hshRecord.put("residentType", residentType);
					if (residentType.equals("N")) {
						hshRecord.put("txtperapp_address1", correctNull(rs2
								.getString("CON_COMADDR1")));
						hshRecord.put("txtperapp_address2", correctNull(rs2
								.getString("CON_COMADDR2")));
						hshRecord.put("txtperapp_address3", correctNull(rs2
								.getString("CON_COMVILLAGE")));
						hshRecord.put("txtperapp_zip", correctNull(rs2
								.getString("CON_COMZIP")));
						strCity = Helper.correctNull(rs2
								.getString("CON_COMCITY"));
						strState = Helper.correctNull(rs2
								.getString("CON_COMSTATE"));
						strCountry = Helper.correctNull(rs2
								.getString("CON_COMCOUNTRY"));
						strdistrict = Helper.correctNull(rs2
								.getString("CON_COMDIST"));
					} else {
						hshRecord.put("txtperapp_address1", correctNull(rs2
								.getString("CON_PERMADDR1")));
						hshRecord.put("txtperapp_address2", correctNull(rs2
								.getString("CON_PERMADDR2")));
						hshRecord.put("txtperapp_address3", correctNull(rs2
								.getString("CON_PERMVILLAGE")));
						hshRecord.put("txtperapp_zip", correctNull(rs2
								.getString("CON_PERMZIP")));
						strCity = Helper.correctNull(rs2
								.getString("CON_PERMCITY"));
						strState = Helper.correctNull(rs2
								.getString("CON_PERMSTATE"));
						strCountry = Helper.correctNull(rs2
								.getString("CON_PERMCOUNTRY"));
						strdistrict = Helper.correctNull(rs2
								.getString("CON_PERMDIST"));
					}

					if (!strCity.equalsIgnoreCase("")) {
						if (rs != null) {
							rs.close();
						}
						strQuery2 = SQLParser.getSqlQuery("sel_cityname^"
								+ strCity);
						rs = DBUtils.executeQuery(strQuery2);
						if (rs.next()) {
							hshRecord.put("txtperapp_city", correctNull(rs
									.getString("city_name")));
							strCity = Helper.correctNull(rs
									.getString("city_name"));
						}
					}

					if (!strState.equalsIgnoreCase("")) {
						if (rs != null) {
							rs.close();
						}
						strQuery2 = SQLParser.getSqlQuery("sel_statename^"
								+ strState);
						rs = DBUtils.executeQuery(strQuery2);
						if (rs.next()) {
							hshRecord.put("txtperapp_state", correctNull(rs
									.getString("state_name")));
							strState = Helper.correctNull(rs
									.getString("state_name"));
						}
					}

					if (!strCountry.equalsIgnoreCase("")) {
						if (rs != null) {
							rs.close();
						}
						strQuery2 = SQLParser
								.getSqlQuery("sel_countrynamebycode^"
										+ strCountry);
						rs = DBUtils.executeQuery(strQuery2);
						if (rs.next()) {
							hshRecord.put("txtperapp_country", correctNull(rs
									.getString("con_country")));
							strCountry = Helper.correctNull(rs
									.getString("con_country"));
						}
					}
					if (rs != null)
						rs.close();
					strQuery2 = SQLParser.getSqlQuery("sel_districtmaster^"
							+ strdistrict);
					rs = DBUtils.executeQuery(strQuery2);
					if (rs.next()) {
						hshRecord.put("txtperapp_district", correctNull(rs
								.getString("district_desc")));
					}

				}
				if (rs2 != null)
					rs2.close();
				strQuery2 = SQLParser.getSqlQuery("sel_perdemo^" + strappId);
				rs2 = DBUtils.executeQuery(strQuery2);
				if (rs2.next()) {
					hshRecord.put("perinc_yearsalary", nf.format(Double
							.parseDouble(Helper.correctDouble(rs2
									.getString("perinc_yearsalary")))));
					hshRecord.put("perinc_year1_income", nf.format(Double
							.parseDouble(Helper.correctDouble(rs2
									.getString("perinc_year1_income")))));
					hshRecord.put("perinc_yearend1", Helper.correctNull(rs2
							.getString("perinc_yearend1")));
				}
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_CustDetails^" + strCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strOccuCode1 = Helper.correctNull((String) rs
						.getString("kyc_kycactivity"));
				hshRecord.put("per_occupation", strOccuCode1);
			}
			
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_company_info^" + strCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("COMINFO_GSTIN", Helper.correctNull(rs.getString("COMINFO_GSTIN")));
				hshRecord.put("COMINFO_GSTINREG", Helper.correctNull(rs.getString("COMINFO_GSTINREG")));
			}

			/*
			 * if(rs !=null) { rs.close(); }
			 * if(!strOccuCode.equalsIgnoreCase("")) {
			 * strQuery1=SQLParser.getSqlQuery
			 * ("getstaticdatavaldispcorporatenew^70^"+strOccuCode);
			 * rs=DBUtils.executeQuery(strQuery1); if(rs.next()) {
			 * hshRecord.put("per_occupation",
			 * Helper.correctNull((String)rs.getString("stat_data_desc1"))); } }
			 */
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("pergetfinancialliab^a" + strappId
					+ "^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrAppLiabCol = new ArrayList();
				arrAppLiabCol.add(Helper.correctNull((String) rs
						.getString("liab_loantype")));
				arrAppLiabCol.add(Helper.correctNull((String) rs
						.getString("liab_accountno")));
				arrAppLiabCol.add(Helper.correctDouble((String) rs
						.getString("liab_crdlimit")));
				arrAppLiabCol.add(Helper.correctNull((String) rs
						.getString("liab_sancrefno")));
				arrAppLiabCol.add(Helper.correctDouble((String) rs
						.getString("liab_balance")));
				arrAppLiabCol.add(Helper.correctNull((String) rs
						.getString("liab_presentstatus")));
				arrAppLiabCol.add(Helper.correctNull((String) rs
						.getString("per_securities")));
				arrAppLiabRow.add(arrAppLiabCol);
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_CoApp_details^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strCoAppID = Helper.correctNull((String) rs
						.getString("perapp_id"));
				arrayCol = new ArrayList();
				arrayCol.add(Helper.correctNull((String) rs
						.getString("fullname")));
				strConstCode = Helper.correctNull((String) rs
						.getString("perapp_constitution"));
				strDemoRelation = Helper.correctNull((String) rs
						.getString("demo_relation"));
				if (!strConstCode.equalsIgnoreCase("")) {
					strQuery1 = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ strConstCode);
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						strConstitution = Helper.correctNull((String) rs1
								.getString("cbs_static_data_desc"));
					}
				}
				if (!strCoAppID.equalsIgnoreCase("")) {
					strQuery2 = SQLParser.getSqlQuery("sel_customerdetails^"
							+ strCoAppID);
					rs2 = DBUtils.executeQuery(strQuery2);
					if (rs2.next()) {

						String residentType = correctNull(rs2
								.getString("INDINFO_RESIDENT_STATUS"));

						if (residentType.equals("N")) {
							strCity = Helper.correctNull(rs2
									.getString("CON_COMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_COMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_COMCOUNTRY"));
						} else {
							strCity = Helper.correctNull(rs2
									.getString("CON_PERMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_PERMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_PERMCOUNTRY"));
						}

						if (!strCity.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_cityname^"
									+ strCity);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCity = Helper.correctNull(rs3
										.getString("city_name"));
							}
						}
						if (!strState.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_statename^"
									+ strState);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strState = Helper.correctNull(rs3
										.getString("state_name"));
							}
						}
						if (!strCountry.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser
									.getSqlQuery("sel_countrynamebycode^"
											+ strCountry);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCountry = Helper.correctNull(rs3
										.getString("con_country"));
							}
						}

						String strAddress = "";
						if (residentType.equals("N")) {
							strAddress = Helper.correctNull(rs2
									.getString("CON_COMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						} else {
							strAddress = Helper.correctNull(rs2
									.getString("CON_PERMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						}

						arrayCol.add(strAddress);
					} else {
						arrayCol.add("");
					}
				} else {
					arrayCol.add("");
				}
				arrayCol.add(strConstitution);

				if (rs1 != null) {
					rs1.close();
				}
				strOccuCode = "";
				strQuery = SQLParser.getSqlQuery("sel_CustDetails^"
						+ strCoAppID);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					strOccuCode1 = Helper.correctNull((String) rs1
							.getString("kyc_kycactivity"));
				}
				/*
				 * if(rs1 !=null) { rs1.close(); }
				 * if(!strOccuCode.equalsIgnoreCase("")) {
				 * strQuery1=SQLParser.getSqlQuery
				 * ("getstaticdatavaldispcorporatenew^70^"+strOccuCode);
				 * rs1=DBUtils.executeQuery(strQuery1); if(rs1.next()) {
				 * strOccuCode1
				 * =Helper.correctNull((String)rs1.getString("stat_data_desc1"
				 * )); } }
				 */

				arrayCol.add(strOccuCode1);
				arrayCol.add(Helper.correctNull((String) rs.getString("dob")));
				// Getting Co-Applicant Relationship value
				if (!strDemoRelation.equalsIgnoreCase("")) {
					rs2 = DBUtils
							.executeLAPSQuery("sel_CBSStaticDataPassingCode^"
									+ "32" + "^" + strDemoRelation);
					if (rs2.next()) {
						strRelDesc = Helper.correctNull(rs2
								.getString("CBS_STATIC_DATA_DESC"));
					}
				}
				if (rs2 != null) {
					rs2.close();
				}
				arrayCol.add(strRelDesc);
				arrayCol.add(nf.format(Double
						.parseDouble(Helper.correctDouble((String) rs
								.getString("perapp_networth")))));
				if (Helper.correctNull(rs.getString("empemployment"))
						.equalsIgnoreCase("1")
						|| Helper.correctNull(rs.getString("empemployment"))
								.equalsIgnoreCase("9"))
					arrayCol.add(Helper.converAmount(nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("perinc_yearsalary")))),
							strAmountForm));
				else
					arrayCol.add(Helper.converAmount(nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("perinc_year1_income")))),
							strAmountForm)
							+ "- ("
							+ Helper.correctNull(rs
									.getString("perinc_yearend1")) + ")");
				arrayRow.add(arrayCol);
				if (rs3 != null) {
					rs3.close();
				}
				strQuery3 = SQLParser.getSqlQuery("pergetfinancialliab^c"
						+ strCoAppID + "^" + strApplicationNo);
				rs3 = DBUtils.executeQuery(strQuery3);
				while (rs3.next()) {
					arrJAppLiabCol = new ArrayList();
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_loantype")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_accountno")));
					arrJAppLiabCol.add(Helper.correctDouble((String) rs3
							.getString("liab_crdlimit")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_sancrefno")));
					arrJAppLiabCol.add(Helper.correctDouble((String) rs3
							.getString("liab_balance")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_presentstatus")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("per_securities")));
					arrJAppLiabRow.add(arrJAppLiabCol);
				}
			}
			if (rs != null) {
				rs.close();
			}
			strRelDesc = strDemoRelation = "";
			// for gur..
			strQuery = SQLParser.getSqlQuery("sel_GrApp_details^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strCoAppID = Helper.correctNull((String) rs
						.getString("perapp_id"));
				arrGuardetails = new ArrayList();
				arrGuardetails.add(Helper.correctNull((String) rs
						.getString("fullname")));
				strConstCode = Helper.correctNull((String) rs
						.getString("perapp_constitution"));
				strDemoRelation = Helper.correctNull((String) rs
						.getString("demo_relation"));
				if (!strConstCode.equalsIgnoreCase("")) {
					strQuery1 = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ strConstCode);
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						strConstitution = Helper.correctNull((String) rs1
								.getString("cbs_static_data_desc"));
					}
				}
				if (!strCoAppID.equalsIgnoreCase("")) {
					strQuery2 = SQLParser.getSqlQuery("sel_customerdetails^"
							+ strCoAppID);
					rs2 = DBUtils.executeQuery(strQuery2);
					if (rs2.next()) {
						String residentType = correctNull(rs2
								.getString("INDINFO_RESIDENT_STATUS"));

						if (residentType.equals("N")) {
							strCity = Helper.correctNull(rs2
									.getString("CON_COMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_COMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_COMCOUNTRY"));
						} else {
							strCity = Helper.correctNull(rs2
									.getString("CON_PERMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_PERMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_PERMCOUNTRY"));
						}

						if (!strCity.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_cityname^"
									+ strCity);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCity = Helper.correctNull(rs3
										.getString("city_name"));
							}
						}

						if (!strState.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_statename^"
									+ strState);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strState = Helper.correctNull(rs3
										.getString("state_name"));
							}
						}
						if (!strCountry.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser
									.getSqlQuery("sel_countrynamebycode^"
											+ strCountry);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCountry = Helper.correctNull(rs3
										.getString("con_country"));
							}
						}
						String strAddress = "";
						if (residentType.equals("N")) {
							strAddress = Helper.correctNull(rs2
									.getString("CON_COMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						} else {
							strAddress = Helper.correctNull(rs2
									.getString("CON_PERMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						}
						arrGuardetails.add(strAddress);
					} else {
						arrGuardetails.add("");
					}
				} else {
					arrGuardetails.add("");
				}
				arrGuardetails.add(strConstitution);

				if (rs1 != null) {
					rs1.close();
				}
				strOccuCode = "";
				strQuery = SQLParser.getSqlQuery("sel_CustDetails^"
						+ strCoAppID);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					strOccuCode1 = Helper.correctNull((String) rs1
							.getString("kyc_kycactivity"));
				}
				/*
				 * if(rs1 !=null) { rs1.close(); }
				 * if(!strOccuCode.equalsIgnoreCase("")) {
				 * strQuery1=SQLParser.getSqlQuery
				 * ("getstaticdatavaldispcorporatenew^70^"+strOccuCode);
				 * rs1=DBUtils.executeQuery(strQuery1); if(rs1.next()) {
				 * strOccuCode1
				 * =Helper.correctNull((String)rs1.getString("stat_data_desc1"
				 * )); } }
				 */

				arrGuardetails.add(strOccuCode1);
				arrGuardetails.add(Helper.correctNull((String) rs
						.getString("dob")));
				// Getting Guarantor Relationship value
				if (!strDemoRelation.equalsIgnoreCase("")) {
					rs2 = DBUtils
							.executeLAPSQuery("sel_CBSStaticDataPassingCode^"
									+ "32" + "^" + strDemoRelation);
					if (rs2.next()) {
						strRelDesc = Helper.correctNull(rs2
								.getString("CBS_STATIC_DATA_DESC"));
					}
				}
				if (rs2 != null) {
					rs2.close();
				}
				arrGuardetails.add(strRelDesc);
				arrGuardetails.add(nf.format(Double
						.parseDouble(Helper.correctDouble((String) rs
								.getString("perapp_networth")))));
				if (Helper.correctNull(rs.getString("empemployment"))
						.equalsIgnoreCase("1")
						|| Helper.correctNull(rs.getString("empemployment"))
								.equalsIgnoreCase("9"))
					arrGuardetails.add(Helper.converAmount(nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("perinc_yearsalary")))),
							strAmountForm));
				else
					arrGuardetails.add(Helper.converAmount(nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("perinc_year1_income")))),
							strAmountForm)
							+ "- ("
							+ Helper.correctNull(rs
									.getString("perinc_yearend1")) + ")");

				arrGuardetailsRow.add(arrGuardetails);
				if (rs3 != null) {
					rs3.close();
				}
				strQuery3 = SQLParser.getSqlQuery("pergetfinancialliab^g"
						+ strCoAppID + "^" + strApplicationNo);
				rs3 = DBUtils.executeQuery(strQuery3);
				while (rs3.next()) {
					arrJAppLiabCol = new ArrayList();
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_loantype")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_accountno")));
					arrJAppLiabCol.add(Helper.correctDouble((String) rs3
							.getString("liab_crdlimit")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_sancrefno")));
					arrJAppLiabCol.add(Helper.correctDouble((String) rs3
							.getString("liab_balance")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("liab_presentstatus")));
					arrJAppLiabCol.add(Helper.correctNull((String) rs3
							.getString("per_securities")));
					arrJAppLiabRow.add(arrJAppLiabCol);
				}
			}
			if (rs != null) {
				rs.close();
			}
			// end gur..

			strQuery = SQLParser.getSqlQuery("sel_proprietor_details^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strCoAppID = Helper.correctNull((String) rs
						.getString("perapp_id"));
				arrProperitierdetails = new ArrayList();
				arrProperitierdetails.add(Helper.correctNull((String) rs
						.getString("fullname")));
				strConstCode = Helper.correctNull((String) rs
						.getString("perapp_constitution"));
				strDemoRelation = Helper.correctNull((String) rs
						.getString("demo_relation"));
				if (!strConstCode.equalsIgnoreCase("")) {
					strQuery1 = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^2^"
									+ strConstCode);
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						strConstitution = Helper.correctNull((String) rs1
								.getString("cbs_static_data_desc"));
					}
				}
				if (!strCoAppID.equalsIgnoreCase("")) {
					strQuery2 = SQLParser.getSqlQuery("sel_customerdetails^"
							+ strCoAppID);
					rs2 = DBUtils.executeQuery(strQuery2);
					if (rs2.next()) {
						String residentType = correctNull(rs2
								.getString("INDINFO_RESIDENT_STATUS"));

						if (residentType.equals("N")) {
							strCity = Helper.correctNull(rs2
									.getString("CON_COMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_COMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_COMCOUNTRY"));
						} else {
							strCity = Helper.correctNull(rs2
									.getString("CON_PERMCITY"));
							strState = Helper.correctNull(rs2
									.getString("CON_PERMSTATE"));
							strCountry = Helper.correctNull(rs2
									.getString("CON_PERMCOUNTRY"));
						}

						if (!strCity.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_cityname^"
									+ strCity);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCity = Helper.correctNull(rs3
										.getString("city_name"));
							}
						}
						if (!strState.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser.getSqlQuery("sel_statename^"
									+ strState);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strState = Helper.correctNull(rs3
										.getString("state_name"));
							}
						}
						if (!strCountry.equalsIgnoreCase("")) {
							if (rs3 != null) {
								rs3.close();
							}
							strQuery2 = SQLParser
									.getSqlQuery("sel_countrynamebycode^"
											+ strCountry);
							rs3 = DBUtils.executeQuery(strQuery2);
							if (rs3.next()) {
								strCountry = Helper.correctNull(rs3
										.getString("con_country"));
							}
						}
						String strAddress = "";
						if (residentType.equals("N")) {
							strAddress = Helper.correctNull(rs2
									.getString("CON_COMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_COMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_COMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						} else {
							strAddress = Helper.correctNull(rs2
									.getString("CON_PERMADDR1"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMADDR2"))
									+ "&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMVILLAGE"))
									+ "<br>"
									+ Helper.correctNull(rs2
											.getString("CON_PERMDIST"))
									+ ",&nbsp;<br>"
									+ strCity
									+ ",&nbsp;"
									+ Helper.correctNull(rs2
											.getString("CON_PERMZIP"))
									+ "<br>"
									+ strState + ",&nbsp;" + strCountry;
						}
						arrProperitierdetails.add(strAddress);
					} else {
						arrProperitierdetails.add("");
					}
				} else {
					arrProperitierdetails.add("");
				}
				arrProperitierdetails.add(strConstitution);

				if (rs1 != null) {
					rs1.close();
				}
				strOccuCode = "";
				strQuery = SQLParser.getSqlQuery("sel_CustDetails^"
						+ strCoAppID);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					strOccuCode1 = Helper.correctNull((String) rs1
							.getString("kyc_kycactivity"));
				}
				/*
				 * if(rs1 !=null) { rs1.close(); }
				 * if(!strOccuCode.equalsIgnoreCase("")) {
				 * strQuery1=SQLParser.getSqlQuery
				 * ("getstaticdatavaldispcorporatenew^70^"+strOccuCode);
				 * rs1=DBUtils.executeQuery(strQuery1); if(rs1.next()) {
				 * strOccuCode1
				 * =Helper.correctNull((String)rs1.getString("stat_data_desc1"
				 * )); } }
				 */

				arrProperitierdetails.add(strOccuCode1);
				arrProperitierdetails.add(Helper.correctNull((String) rs
						.getString("dob")));
				if (!strDemoRelation.equalsIgnoreCase("")) {
					rs2 = DBUtils
							.executeLAPSQuery("sel_CBSStaticDataPassingCode^"
									+ "32" + "^" + strDemoRelation);
					if (rs2.next()) {
						strRelDesc = Helper.correctNull(rs2
								.getString("CBS_STATIC_DATA_DESC"));
					}
				}
				if (rs2 != null) {
					rs2.close();
				}
				arrProperitierdetails.add(strRelDesc);
				arrProperitierdetails.add(nf.format(Double
						.parseDouble(Helper.correctDouble((String) rs
								.getString("perapp_networth")))));
				if (Helper.correctNull(rs.getString("empemployment"))
						.equalsIgnoreCase("1")
						|| Helper.correctNull(rs.getString("empemployment"))
								.equalsIgnoreCase("9"))
					arrProperitierdetails.add(Helper.converAmount(nf
							.format(Double.parseDouble(Helper.correctDouble(rs
									.getString("perinc_yearsalary")))),
							strAmountForm));
				else
					arrProperitierdetails.add(Helper.converAmount(nf
							.format(Double.parseDouble(Helper.correctDouble(rs
									.getString("perinc_year1_income")))),
							strAmountForm)
							+ "- ("
							+ Helper.correctNull(rs
									.getString("perinc_yearend1")) + ")");
				arrProperitierdetailsRow.add(arrProperitierdetails);
			}

			if (rs3 != null) {
				rs3.close();
			}

			ArrayList arrOthrbnkRow = new ArrayList();
			ArrayList arrOthrbnkCol = new ArrayList();
			String strFactype = "", strLapsOldId = "0", bankname = "";
			if (!strappId.equalsIgnoreCase("")) {
				strQuery = SQLParser.getSqlQuery("seloldrefidforapp^"
						+ strappId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strLapsOldId = Helper.correctNull(rs
							.getString("perapp_oldid"));
				}
				strQuery = SQLParser.getSqlQuery("selrenewappid^"
						+ strLapsOldId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strappId = Helper.correctNull(rs.getString("perapp_id"));
				}
			}
			strQuery = SQLParser.getSqlQuery("perbankingselectNEW^"
					+ strLapsOldId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrOthrbnkCol = new ArrayList();
				bankname = Helper.correctNull(rs.getString("perbank_bnkname"));
				if (!(bankname.equalsIgnoreCase(""))) {
					strQuery3 = SQLParser
							.getSqlQuery("selbankname^" + bankname);
					rs3 = DBUtils.executeQuery(strQuery3);
					if (rs3.next()) {
						bankname = Helper.correctNull(rs3
								.getString("stat_data_desc1"));
					}
				}
				arrOthrbnkCol.add(bankname);// 0
				strFactype = Helper.correctNull(rs.getString("perbank_type"));
				if (strFactype.equalsIgnoreCase("1"))
					arrOthrbnkCol.add("Working Capital");// 1
				else if (strFactype.equalsIgnoreCase("2"))
					arrOthrbnkCol.add("Term Loan");// 1
				else
					arrOthrbnkCol.add("");
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_limit")));// 2
				arrOthrbnkCol.add(Helper
						.correctNull(rs.getString("perbank_os")));// 3
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_intrate")));// 4
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_monthly_ins")));// 5
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_duedate")));// 6
				arrOthrbnkCol.add(Helper.replaceForJavaScriptString(Helper
						.CLOBToString(rs.getClob("perbank_arrears"))));// 7
				arrOthrbnkRow.add(arrOthrbnkCol);
			}
			hshRecord.put("arrOthrbnkRow", arrOthrbnkRow);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_bankcomments^" + strappId
					+ "^" + "otherbank");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("otherbnkcomments", Helper.CLOBToString(rs
						.getClob("cmt_bankcomments")));
			}
			if (rs != null) {
				rs.close();
			}
			String strProcessingFee = "";
			strQuery = SQLParser.getSqlQuery("selLoanAmt^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("LoanPurpose", Helper.CLOBToString(rs
						.getClob("loan_purposeofloan")));
				hshRecord.put("Limit", Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("loanamt"))));
				strProcessingFee = Helper.checkDecimal(Helper.correctDouble(rs
						.getString("loan_profee")));
				hshRecord.put("strIntType", Helper.correctNull(rs
						.getString("loan_inttype")));
			}

			// processing fee waived
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("selloan_details^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				hshRecord.put("indinfo_is_staff", correctNull(rs
						.getString("indinfo_is_staff")));
				if (hshRecord.get("indinfo_is_staff").equals("02")) {
					strProcessingFee = "W";
				}
			}

			if (rs != null)
				rs.close();
			strQuery1 = SQLParser
					.getSqlQuery("sel_per_house_proposed_asset_new^"
							+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				hshRecord.put("phpa_loan_purpose", correctNull(rs
						.getString("phpa_loan_purpose")));
				hshRecord.put("phpa_project_finance", correctNull(rs
						.getString("phpa_project_finance")));
				if ((Helper.correctNull(
						(String) hshRecord.get("phpa_loan_purpose"))
						.equals("H") && (Helper.correctNull((String) hshRecord
						.get("phpa_project_finance")).equals("Y")))) {
					strProcessingFee = "W";
				}
			}
			// Check Deviated Value
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("Sel_app_deviation1^"
					+ strApplicationNo + "^PF");
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {

				if (Helper.correctNull(rs.getString("deviation_apprej"))
						.equalsIgnoreCase("A")) {
					strProcessingFee = Helper.checkDecimal(Helper
							.correctDouble(rs.getString("deviation_newvalue")));
				}
			}

			hshRecord.put("strProcessingFee", strProcessingFee);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
					+ strApplicationNo + "^" + "C");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("GuarComments", Helper.CLOBToString(rs
						.getClob("cmt_comments")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_GuarantorID^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strGuarID = Helper.correctNull((String) rs
						.getString("demo_appid"));
				if (rs1 != null) {
					rs1.close();
				}
				strQuery1 = SQLParser.getSqlQuery("pergetfinancialliab^g"
						+ strGuarID + "^" + strApplicationNo);
				rs1 = DBUtils.executeQuery(strQuery1);
				while (rs1.next()) {
					arrGuarLiabCol = new ArrayList();
					arrGuarLiabCol.add(Helper.correctNull((String) rs1
							.getString("liab_loantype")));
					arrGuarLiabCol.add(Helper.correctNull((String) rs1
							.getString("liab_accountno")));
					arrGuarLiabCol.add(Helper.correctDouble((String) rs1
							.getString("liab_crdlimit")));
					arrGuarLiabCol.add(Helper.correctNull((String) rs1
							.getString("liab_sancrefno")));
					arrGuarLiabCol.add(Helper.correctDouble((String) rs1
							.getString("liab_balance")));
					arrGuarLiabCol.add(Helper.correctNull((String) rs1
							.getString("liab_presentstatus")));
					arrGuarLiabCol.add(Helper.correctNull((String) rs1
							.getString("per_securities")));
					arrGuarLiabRow.add(arrGuarLiabCol);
				}
			}
			if (!strAppType.equalsIgnoreCase("Postsanction")) {
				hshValues.put("hidapplicantid", strappId);
				RetailAssessmentBean RAB = new RetailAssessmentBean();
				hshResult = RAB.getCommonAssessment(hshValues);
			}
			if (rs1 != null) {
				rs1.close();
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("persourceofmargin_sel^"
					+ strApplicationNo);
			if (rs.next()) {
				hshRecord.put("PER_MARGIN_COSTINCURED", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_COSTINCURED"))));
				hshRecord.put("PER_MARGIN_OWNSAVINGS", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_OWNSAVINGS"))));
				hshRecord.put("PER_MARGIN_OTHERS_DESC1", correctNull(rs
						.getString("PER_MARGIN_OTHERS_DESC1")));
				hshRecord.put("PER_MARGIN_OTHERS_VALUE1", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_OTHERS_VALUE1"))));
				hshRecord.put("PER_MARGIN_OTHERS_DESC2", correctNull(rs
						.getString("PER_MARGIN_OTHERS_DESC2")));
				hshRecord.put("PER_MARGIN_OTHERS_VALUE2", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_OTHERS_VALUE2"))));
				hshRecord.put("PER_MARGIN_OTHERS_DESC3", correctNull(rs
						.getString("PER_MARGIN_OTHERS_DESC3")));
				hshRecord.put("PER_MARGIN_OTHERS_VALUE3", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_OTHERS_VALUE3"))));
				hshRecord.put("PER_MARGIN_TOTAL_FUND", Helper
						.checkDecimal(Helper.correctDouble((String) rs
								.getString("PER_MARGIN_TOTAL_FUND"))));
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getloanreqamt_sel^"
					+ strApplicationNo);
			if (rs.next()) {
				hshRecord.put("PER_MARGIN_REQAMT", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("LOAN_AMTREQD"))));
				strtake = correctNull((String) rs.getString("loan_takeover"));
				if(!Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
				{
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					if (rs1.next()) {
						hshRecord.put("strInsCompname", Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
					}
				}
				if (rs1 != null) {rs1.close();}
				hshRecord.put("LOAN_INS_ACCOUNT_NO", Helper.correctNull(rs.getString("LOAN_INS_ACCOUNT_NO")));
				hshRecord.put("LOAN_PREMIUM_LOAN_AMOUNT", Helper.checkDecimal(Helper.correctDouble(rs.getString("LOAN_PREMIUM_LOAN_AMOUNT"))));
				hshRecord.put("LOAN_PREMIUM_AMOUNT", Helper.checkDecimal(Helper.correctDouble(rs.getString("LOAN_PREMIUM_AMOUNT"))));
				hshRecord.put("LOAN_PREMIUM_TENOR",  Helper.correctNull(rs.getString("LOAN_PREMIUM_TENOR")));
				hshRecord.put("LOAN_INS_COMPANY_NAME",  Helper.correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
				if(!Helper.correctNull( rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")).equalsIgnoreCase(""))
				{
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull(rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")));
					if (rs1.next()) {
						hshRecord.put("strInsFundedCompname", Helper.correctNull((String) rs1.getString("STAT_DATA_DESC1")));
					}
				}
				if (rs1 != null) {rs1.close();}
			}
			if (rs != null) {
				rs.close();
			}
			// For Take over Loans
			/*
			 * rs = DBUtils.executeLAPSQuery("selectvehicledetails1^"
			 * +"A"+"^"+strApplicationNo); if(rs.next()) { strtake =
			 * correctNull((String)rs.getString("auto_take_over")); }
			 */
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("takeoversel^" + strApplicationNo);
			if (rs.next()) {
				hshRecord.put("repay_period", correctNull(rs
						.getString("repay_period")));
				hshRecord.put("no_installpaid", correctNull(rs
						.getString("no_installpaid")));
				String avail_date = correctNull(rs.getString("avail_date"));
				if (avail_date.equalsIgnoreCase("01/01/1900")) {
					avail_date = "";
				} else {
					hshRecord.put("avail_date", correctNull(rs
							.getString("avail_date")));
				}
				hshRecord.put("takeover_amtpaid", correctNull(rs
						.getString("takeover_amtpaid")));
				hshRecord.put("shifting_reason", correctNull(rs
						.getString("shifting_reason")));
				hshRecord.put("holiday_period", correctNull(rs
						.getString("holiday_period")));
				hshRecord.put("rate_of_interest", correctNull(rs
						.getString("rate_of_interest"))
						+ "%");
				hshRecord.put("prev_bank_opinion", correctNull(rs
						.getString("prev_bank_opinion")));
				hshRecord.put("stmt_from_date", correctNull(rs
						.getString("stmt_from_date")));
				hshRecord.put("stmt_to_date", correctNull(rs
						.getString("stmt_to_date")));
				hshRecord.put("stmt_comments", correctNull(rs
						.getString("stmt_comments")));
			}
			if (rs != null) {
				rs.close();
			}
			// For Conduct of Operation
			strQuery = SQLParser.getSqlQuery("sel_conductoperation^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshRecord.put("CON_COMPLIANCE", correctNull((String) rs
						.getString("CON_COMPLIANCE")));
				hshRecord.put("CON_INTERNALINSPECTION", correctNull((String) rs
						.getString("CON_INTERNALINSPECTION")));
				hshRecord.put("CON_ROCLREPORT", correctNull((String) rs
						.getString("CON_ROCLREPORT")));
				hshRecord.put("CON_PERIODCOVERED", correctNull((String) rs
						.getString("CON_PERIODCOVERED")));
				hshRecord.put("CON_ROCREASON", correctNull((String) rs
						.getString("CON_ROCREASON")));
				hshRecord.put("CON_EMREG", correctNull((String) rs
						.getString("CON_EMREG")));
				hshRecord.put("CON_EMREASON", correctNull((String) rs
						.getString("CON_EMREASON")));
				hshRecord.put("CON_CHARGESNOTED", correctNull((String) rs
						.getString("CON_CHARGESNOTED")));
				hshRecord.put("CON_CHARGESREASON", correctNull((String) rs
						.getString("CON_CHARGESREASON")));
				hshRecord.put("CON_CONDUCTTLDPN", correctNull((String) rs
						.getString("CON_CONDUCTTLDPN")));
				hshRecord.put("con_internalinspection", correctNull(rs
						.getString("con_internalinspection")));
				hshRecord.put("con_rbiinspection", correctNull(rs
						.getString("con_rbiinspection")));
				hshRecord.put("con_auditsobser", correctNull(rs
						.getString("con_auditsobser")));
				hshRecord.put("con_offsiteobserv", correctNull(rs
						.getString("con_offsiteobserv")));
			}
			if (rs != null) {
				rs.close();
			}
			HashMap hshrbidetails = new HashMap();
			hshrbidetails = new ProposalTermsBean().getRBIGuidelines(hshValues);
			hshRecord.put("hshrbidetails", hshrbidetails);
			hshRecord.put("creditproposal", correctNull((String) hshrbidetails
					.get("creditproposal")));

			if (rs != null) {
				rs.close();
			}
			String strProdPurpose = "", strVehicleType = "";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strProdPurpose = Helper.correctNull((String) rs
						.getString("prd_purpose"));
				strVehicleType = Helper.correctNull(rs
						.getString("prd_vehitype"));
			}
			if (rs != null) {
				rs.close();
			}
			// For Inspection Comments
			strQuery = SQLParser.getSqlQuery("sel_inspectioncomments^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshRecord.put("INS_INTERNALCOMMENT", correctNull((String) rs
						.getString("INS_INTERNALCOMMENT")));
				hshRecord.put("INS_INTERNALACTION", correctNull((String) rs
						.getString("INS_INTERNALACTION")));
				hshRecord.put("INS_RBICOMMENT", correctNull((String) rs
						.getString("INS_RBICOMMENT")));
				hshRecord.put("INS_RBIACTION", correctNull((String) rs
						.getString("INS_RBIACTION")));
				hshRecord.put("INS_UNITCOMMENT", correctNull((String) rs
						.getString("INS_UNITCOMMENT")));
				hshRecord.put("INS_UNITACTION", correctNull((String) rs
						.getString("INS_UNITACTION")));
				hshRecord.put("INS_RMDCOMMENT", correctNull((String) rs
						.getString("INS_RMDCOMMENT")));
				hshRecord.put("INS_RMDACTION", correctNull((String) rs
						.getString("INS_RMDACTION")));
				hshRecord.put("INS_AUDITCOMMENT", correctNull((String) rs
						.getString("INS_AUDITCOMMENT")));
				hshRecord.put("INS_AUDITACTION", correctNull((String) rs
						.getString("INS_AUDITACTION")));
				hshRecord.put("INS_OFFSITECOMMENT", correctNull((String) rs
						.getString("INS_OFFSITECOMMENT")));
				hshRecord.put("INS_OFFSITEACTION", correctNull((String) rs
						.getString("INS_OFFSITEACTION")));
				hshRecord.put("INS_INTERNALDATE", correctNull((String) rs
						.getString("INS_INTERNALDATE")));
				hshRecord.put("INS_RBIASONDATE", correctNull((String) rs
						.getString("INS_RBIASONDATE")));
			}
			if (rs != null) {
				rs.close();
			}
			if (strProdPurpose.equalsIgnoreCase("T")||strProdPurpose.equalsIgnoreCase("HC"))
				strQuery = SQLParser.getSqlQuery("selhousingloansec^"
						+ strApplicationNo + "^ ");
			else
				strQuery = SQLParser.getSqlQuery("selhousingloansec^"
						+ strApplicationNo + "^ and app_sec_securitytype='1'");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				// hshRecord.put("phpa_prop_nature",correctNull(rs.getString("phpa_prop_nature")));
				// hshRecord.put("phpa_premises_age",correctNull(rs.getString("phpa_premises_age")));
				// hshRecord.put("phpa_branch_distance",correctNull(rs.getString("phpa_branch_distance")));
				// hshRecord.put("phpa_prop_location",correctNull(rs.getString("phpa_prop_location")));
				hshRecord.put("phpa_prop_surveyno", correctNull(rs
						.getString("sec_surveyno")));
				hshRecord.put("phpa_prop_plotno", correctNull(rs
						.getString("sec_plotno")));
				hshRecord.put("phpa_site_area", correctNull(rs
						.getString("sec_totalarea")));
				hshRecord.put("phpa_site_valuer_name", correctNull(rs
						.getString("cus_sec_valuer_name")));
				hshRecord.put("phpa_site_valuation_date", correctNull(rs
						.getString("cus_sec_valuation_date")));
				hshRecord.put("phpa_site_valuation_cost", nf.format(Double
						.parseDouble(Helper.correctDouble(rs
								.getString("sec_valuervalue")))));
				hshRecord.put("phpa_site_valuer_code", correctNull(rs
						.getString("CUS_SEC_VALUERCODE")));
				hshRecord.put("phpa_site_govtvaluer_name", correctNull(rs
						.getString("CUS_SEC_GOVT_VALUER")));
				

				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("getstaticdatavaldisp^135^"
						+ Helper.correctInt(rs.getString("sec_measurement")));
				if (rs1.next()) {
					hshRecord.put("phpa_site_area_measurement", Helper
							.correctNull(rs1.getString("stat_data_desc1")));
				}

				if (rs1 != null) {
					rs1.close();
				}
				String[] VALUATIONNATURE = null;
				rs1 = DBUtils
						.executeLAPSQuery("sel_valmasater_name^"
								+ Helper.correctInt(rs
										.getString("CUS_SEC_VALUERCODE")));
				if (rs1.next()) {
					hshRecord.put("VALUER_VALUATIONNATURE", Helper
							.correctNull(rs1
									.getString("VALUER_VALUATIONNATURE")));
					hshRecord.put("phpa_VALUER_CATEGORYCODE", Helper
							.correctNull(rs1.getString("VALUER_CATEGORYCODE")));

					if (!Helper.correctNull(
							(String) rs1.getString("VALUER_VALUATIONNATURE"))
							.equals(""))
						VALUATIONNATURE = Helper.correctNull(
								rs1.getString("VALUER_VALUATIONNATURE")).split(
								"@");

					String valnature = "";
					if (VALUATIONNATURE != null && VALUATIONNATURE.length > 0) {
						for (int i = 0; i < VALUATIONNATURE.length; i++) {
							if (rs2 != null) {
								rs2.close();
							}
							rs2 = DBUtils
									.executeLAPSQuery("selstaticdata_securitytype_sel^"
											+ VALUATIONNATURE[i]);
							if (rs2.next()) {
								valnature = valnature
										+ Helper.correctNull(rs2
												.getString("sec_name")) + ", ";
							}
						}
						hshRecord.put("valuer_valnature", valnature);
					}
				}
			}
			if (rs != null) {
				rs.close();
			}
			// For Cersai& Cibil Details
			strQuery = SQLParser.getSqlQuery("sel_cersaicibildetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				hshRecord.put("CER_CERSAIDETAILS", correctNull((String) rs
						.getString("CER_CERSAIDETAILS")));
				hshRecord.put("CER_OTHERINFORMATION", correctNull((String) rs
						.getString("CER_OTHERINFORMATION")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_date^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("Recommendation", Helper.correctNull((String) rs
						.getString("apprised_scheme")));

			}
			if (rs != null) {
				rs.close();
			}
			int intRepayPeriod = 0;
			int intHolidayPeriod = 0;

			/*
			 * For Purchase of Ready Built House and Used Vehicle loan, Margin
			 * is based on age of the building / vehicle respectively
			 */
			hshRecord.put("prd_purpose", strProdPurpose);
			String strPassCode="";
			if (strProdPurpose.equalsIgnoreCase("H")
					|| strProdPurpose.equalsIgnoreCase("U")
					|| strVehicleType.equalsIgnoreCase("2")) {
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^"
						+ strApplicationNo);
			} else {
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^"
						+ strApplicationNo);
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("SancAmount", Helper.checkDecimal(Helper
						.correctDouble(Helper.correctNull((String) rs
								.getString("sancamount")))));

				if (rs1 != null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selloan_details^"
						+ strApplicationNo);
				if (rs1.next()) {
					staffproduct = correctNull(rs1.getString("prd_staffprd"));
				}

				if (!staffproduct.equalsIgnoreCase("Y")
						&& Helper.correctNull(rs.getString("loan_inttype"))
								.equalsIgnoreCase("Floating")) {
					String strTemp = Helper.correctNull(rs
							.getString("loan_mclrtype"));
					if (!strTemp.equalsIgnoreCase("")) {
						String[] strArr = strTemp.split("@");
						if (strArr.length > 1) {
							if (rs3 != null)
								rs3.close();
							rs3 = DBUtils
									.executeLAPSQuery("selcbsiddatadesc^34^"
											+ strArr[0]);
							if (rs3.next()) {
								strTemp = Helper.correctNull(rs3
										.getString("cbs_static_data_desc"));
								strPassCode=Helper.correctNull(rs3.getString("cbs_static_data_passing_code"));
							}
							if(strPassCode.equalsIgnoreCase("O")){
							hshRecord.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%" + "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Bussiness strategic Premium)"
									+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
							}else{
								hshRecord.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%"+ "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Fixed Spread)"
										+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
							}
							
							/*hshRecord.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("mintrate")))- Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_BASERATE"))))
													+ "% p.a presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate")))+ "+ Bussiness Interest "+ Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))));*/
						} else {
							hshRecord.put("ROI", Helper.checkDecimal(Helper
									.correctDouble((String) rs
											.getString("mintrate"))));
						}

					} else {
						hshRecord.put("ROI", Helper.checkDecimal(Helper
								.correctDouble((String) rs
										.getString("mintrate"))));
					}

				} else {
					hshRecord.put("ROI", Helper.checkDecimal(Helper
							.correctDouble((String) rs.getString("mintrate"))));
				}
				hshRecord.put("ROI1", Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("mintrate"))));
				hshRecord.put("Margin", Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("loan_margin"))));
				hshRecord.put("Terms", Helper.correctNull((String) rs
						.getString("lreqterms")));
				hshRecord.put("ModeOfPay", Helper.correctNull((String) rs
						.getString("loan_modeofpay")));
				hshRecord.put("loan_repaymenttype", Helper
						.correctNull((String) rs
								.getString("loan_repaymenttype")));
				hshRecord
						.put("loan_receivedate", Helper.correctNull((String) rs
								.getString("loan_receivedate")));
				String repaymenttype = Helper.correctNull((String) rs
						.getString("loan_repaymenttype"));
				if (repaymenttype.equalsIgnoreCase("1")) {
					hshRecord.put("repaytype", "Equated Monthly Installment");
				} else if (repaymenttype.equalsIgnoreCase("2")) {
					hshRecord.put("repaytype", "Non-EMI");
				} else if (repaymenttype.equalsIgnoreCase("3")) {
					hshRecord.put("repaytype", "Graduated installments");
				} else if (repaymenttype.equalsIgnoreCase("4")) {
					hshRecord.put("repaytype", "Step Up");
				} else if (repaymenttype.equalsIgnoreCase("5")) {
					hshRecord.put("repaytype", "Step Down");
				} else if (repaymenttype.equalsIgnoreCase("6")) {
					hshRecord.put("repaytype", "Taper Down");
				} else if (repaymenttype.equalsIgnoreCase("7")) {
					hshRecord.put("repaytype", "Balloon");
				} else if (repaymenttype.equalsIgnoreCase("9")) {
					hshRecord.put("repaytype", "Flip Method");
				} else if (repaymenttype.equalsIgnoreCase("10")) {
					hshRecord.put("repaytype", "Equal Installments");
				} else if (repaymenttype.equalsIgnoreCase("8")) {
					hshRecord.put("repaytype", "On Due Date");
				} else if (repaymenttype.equalsIgnoreCase("12")) {
					hshRecord.put("repaytype", "On Demand");
				} else if (repaymenttype.equalsIgnoreCase("13")) {
					hshRecord.put("repaytype", "Equal Monthly Installments");
				} else if (repaymenttype.equalsIgnoreCase("14")) {
					hshRecord.put("repaytype", "2 Yearly Equal Installment");
				} else {
					hshRecord.put("repaytype", repaymenttype);
				}
				if (Helper.correctNull(
						(String) rs.getString("loan_repaymenttype"))
						.equalsIgnoreCase("1")) {
					hshRecord.put("WhetherEMI", "Yes");
				} else {
					hshRecord.put("WhetherEMI", "No");
				}
				String strIntTerms = Helper.correctNull((String) rs
						.getString("lreqterms"));
				if (!strIntTerms.equalsIgnoreCase("")) {
					intRepayPeriod = Integer.parseInt(Helper
							.correctInt(strIntTerms));
				}
				// strRepayType =
				// Helper.correctNull((String)rs.getString("loan_repaymenttype"));
				// if(strRepayType.equalsIgnoreCase("1"))
				// {
				// strRepayType = "Equated Monthly Installment";
				// }
				// else if(strRepayType.equalsIgnoreCase("2"))
				// {
				// strRepayType = "Non-EMI";
				// }
				// else if(strRepayType.equalsIgnoreCase("3"))
				// {
				// strRepayType = "Graduated installments";
				// }
				// else if(strRepayType.equalsIgnoreCase("4"))
				// {
				// strRepayType = "Step Up";
				// }
				// else if(strRepayType.equalsIgnoreCase("5"))
				// {
				// strRepayType = "Step Down";
				// }
				// else if(strRepayType.equalsIgnoreCase("6"))
				// {
				// strRepayType = "Taper Down";
				// }
				// else if(strRepayType.equalsIgnoreCase("7"))
				// {
				// strRepayType = "Balloon";
				// }
				// else if(strRepayType.equalsIgnoreCase("8"))
				// {
				// strRepayType = "Bullet";
				// }
				// else if(strRepayType.equalsIgnoreCase("9"))
				// {
				// strRepayType = "Flip Method";
				// }
				// else if(strRepayType.equalsIgnoreCase("10"))
				// {
				// strRepayType = "Equal Installments";
				// }
				// else if(strRepayType.equalsIgnoreCase("11"))
				// {
				// strRepayType = "Slab";
				// }
				// else if(strRepayType.equalsIgnoreCase("12"))
				// {
				// strRepayType = "On Demand";
				// }
				hshRecord.put("strInsurancePremium", Helper.checkDecimal(Helper
						.correctDouble(Helper.correctNull(rs
								.getString("loan_metlifepremiumamt")))));
				hshRecord.put("strDueDate", Helper.correctNull(rs
						.getString("loan_duedate")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("securesel^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				String strHolidayPeriod = Helper.correctNull((String) rs
						.getString("loan_noofinstallment"));
				if (!strHolidayPeriod.equalsIgnoreCase("")) {
					intHolidayPeriod = Integer.parseInt(Helper
							.correctInt(strHolidayPeriod));
				}
				intInstallmentExcHoliday = intRepayPeriod - intHolidayPeriod;
				hshRecord.put("strHolidayPeriod", strHolidayPeriod);
				hshRecord.put("loan_noofinstallment", Integer
						.toString(intInstallmentExcHoliday));
				hshRecord.put("loan_periodicity", correctNull((String) rs
						.getString("loan_periodicity")));
				hshRecord.put("loan_secure", correctNull((String) rs
						.getString("loan_secure")));
				hshRecord.put("loan_secureamount", correctNull((String) rs
						.getString("loan_secureamount")));
				if (Helper.correctNull((String) rs.getString("loan_servised"))
						.equalsIgnoreCase("y")) {
					hshRecord.put("loan_servised", "Yes");
				} else {
					hshRecord.put("loan_servised", "No");
				}
			}
			if (rs != null) {
				rs.close();
			}
			// For Terms and Condition
			strQuery = SQLParser.getSqlQuery("apptermscondsel^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrVal = new ArrayList();
				arrVal.add(correctNull((String) rs
						.getString("APP_GENERAL_TERMS_TYPE")));
				arrVal.add(correctNull((String) rs
						.getString("APP_TERMSCONTENT")));
				arrVal.add(correctNull((String) rs
						.getString("terms_prepost")));
				arrRow.add(arrVal);
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("arrayRow", arrayRow);
			hshRecord.put("arrayRow1", arrayRow1);
			hshRecord.put("arrAppLiabRow", arrAppLiabRow);
			hshRecord.put("arrJAppLiabRow", arrJAppLiabRow);
			hshRecord.put("arrGuarLiabRow", arrGuarLiabRow);
			hshRecord.put("strappId", strappId);
			hshRecord.put("strApplicationNo", strApplicationNo);
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("arrRowTerms", arrRow);
			hshRecord.put("strtake", strtake);
			hshRecord.put("hshResult", hshResult);
			hshRecord.put("arrGuardetailsRow", arrGuardetailsRow);
			hshRecord.put("arrProperitierdetailsRow", arrProperitierdetailsRow);

			/* Added by Arsath on 17/02/2014 for EMI Amount */
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_repaymentperiod^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("loan_emi", Helper.correctDouble((String) rs
						.getString("loan_emi")));
				hshRecord.put("loan_purposeofloan", Helper.CLOBToString(rs
						.getClob("loan_purposeofloan")));
			}
			/* End */

			/* Added by Arsath on 17/02/2014 for Deviation Amount */
			ArrayList arrDevCol = new ArrayList();
			ArrayList arrDevRow = new ArrayList();
			if (rs1 != null) {
				rs1.close();
			}
			strQuery = SQLParser.getSqlQuery("Sel_app_deviation^"
					+ strApplicationNo);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next()) {
				arrDevCol = new ArrayList();
				String strDeviated = Helper.correctNull((String) rs1
						.getString("deviation_req"));
				if (strDeviated.equalsIgnoreCase("Y")) {
					String strDevdescode = Helper.correctNull((String) rs1
							.getString("deviation_type"));
					String strDevdesc = "";
					if (strDevdescode.equalsIgnoreCase("LA")) {
						strDevdesc = "Loan Amount";
					} else if (strDevdescode.equalsIgnoreCase("IR")) {
						strDevdesc = "Interest Rate(%)";
					} else if (strDevdescode.equalsIgnoreCase("TR")) {
						strDevdesc = "Tenor (Months)";
					} else if (strDevdescode.equalsIgnoreCase("MN")) {
						strDevdesc = "Margin (%)";
					} else if (strDevdescode.equalsIgnoreCase("RA")) {
						strDevdesc = "Retirement Age (Years)";
					} else if (strDevdescode.equalsIgnoreCase("RC")) {
						strDevdesc = "Repayment Capacity (%)";
					} else if (strDevdescode.equalsIgnoreCase("PF")) {
						strDevdesc = "Processing Fee";
					} else {
						strDevdesc = "Other Deviation";
					}
					arrDevCol.add(strDevdesc);// 0
					arrDevCol.add(Helper.correctNull((String) rs1
							.getString("deviation_oldvalue")));// 1
					arrDevCol.add(Helper.correctNull((String) rs1
							.getString("deviation_newvalue")));// 2
					arrDevCol.add(Helper.correctNull((String) rs1
							.getString("deviation_remarks")));// 3
					String strAppRej = Helper.correctNull((String) rs1
							.getString("deviation_apprej"));
					String strAppRejstatus = "";
					if (strAppRej.equalsIgnoreCase("A")) {
						strAppRejstatus = "Approved";
					} else if (strAppRej.equalsIgnoreCase("R")) {
						strAppRejstatus = "Rejected";
					} else {
						strAppRejstatus = " ";
					}
					arrDevCol.add(strAppRejstatus);// 4
					arrDevRow.add(arrDevCol);
				}

			}
			hshRecord.put("arrDevRow", arrDevRow);
			/* End */

			/* Added by Arsath on 18/02/2014 for Security Details */
			if (rs != null) {
				rs.close();
			}
			ArrayList arrSecexiscol = new ArrayList();
			ArrayList arrSecexisRow = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_secprimexisdetails^"
					+ strApplicationNo + "^" + "1" + "^" + "E");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrSecexiscol = new ArrayList();
				arrSecexiscol.add(Helper.correctNull((String) rs
						.getString("sec_name")));
				arrSecexiscol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_netsecurity")));
				arrSecexiscol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_reidualval")));
				arrSecexisRow.add(arrSecexiscol);
			}
			hshRecord.put("arrSecexisRow", arrSecexisRow);

			if (rs != null) {
				rs.close();
			}
			ArrayList arrSeccol = new ArrayList();
			ArrayList arrSecRow = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_seccollateraldetails^"
					+ strApplicationNo + "^" + "2");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrSeccol = new ArrayList();
				arrSeccol.add(Helper.correctNull((String) rs
						.getString("sec_name")));
				arrSeccol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_netsecurity")));
				arrSeccol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_reidualval")));
				arrSecRow.add(arrSeccol);
			}
			hshRecord.put("arrSecRow", arrSecRow);

			if (rs != null) {
				rs.close();
			}
			ArrayList arrSecprocol = new ArrayList();
			ArrayList arrSecproRow = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_proprimarydetails^"
					+ strApplicationNo + "^" + "1" + "^" + "P");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrSecprocol = new ArrayList();
				arrSecprocol.add(Helper.correctNull((String) rs
						.getString("sec_name")));
				arrSecprocol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_netsecurity")));
				arrSecprocol.add(Helper.correctDouble((String) rs
						.getString("cus_sec_reidualval")));
				arrSecproRow.add(arrSecprocol);
			}
			hshRecord.put("arrSecproRow", arrSecproRow);

			HashMap hshsecdet = new HashMap();
			hshValues.put("valuesin", "R");
			hshsecdet = new SecurityMasterBean()
					.getCollateralSecurityDisplayretail(hshValues);
			hshRecord.put("hshsecdet", hshsecdet);

			HashMap hshsecdet1 = new HashMap();
			hshsecdet1.put("appid", strappId);
			hshsecdet1.put("appno", strApplicationNo);
			CommDocumentBean cdb = new CommDocumentBean();
			hshsecdet1 = cdb.getAnnexureIII(hshsecdet1);
			hshRecord.put("hshsecdet1", hshsecdet1);

			/* End */

			/* Added by Arsath on 18/02/2014 for Vehicle Details */
			if (strProductType.equalsIgnoreCase("pA")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selectvehicledetails1^" + "A"
						+ "^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				ArrayList arrvehicledetcol = new ArrayList();
				ArrayList arrvehicledetRow = new ArrayList();
				while (rs.next()) {
					arrvehicledetcol = new ArrayList();
					arrvehicledetcol.add(correctNull(rs.getString("auto_vehicletype")));//0
					arrvehicledetcol.add( correctNull(rs.getString("auto_category")));//1
					String strCategory = Helper.correctNull(rs.getString("auto_category"));
					String strCategory1 = "";
					if (strCategory.equalsIgnoreCase("1")) {
						strCategory1 = "New";
					} else {
						strCategory1 = "Old";
					}
					arrvehicledetcol.add(strCategory1);//2
					arrvehicledetcol.add(correctNull(rs.getString("auto_make")));//3
					arrvehicledetcol.add(correctNull(rs.getString("auto_model")));//4
					arrvehicledetcol.add(correctNull(rs.getString("auto_originalcost")));//5
					if(strCategory.equalsIgnoreCase("1")){
					arrvehicledetcol.add(Helper.checkDecimal(Helper.correctDouble((String) rs.getString("auto_valuation"))));//6
					}
					else{
						arrvehicledetcol.add(Helper.checkDecimal(Helper.correctDouble((String) rs.getString("auto_originalcost"))));//6	
					}
					arrvehicledetcol.add(Helper.checkDecimal(Helper.correctDouble((String) rs.getString("auto_tax"))));//7
					arrvehicledetcol.add(Helper.checkDecimal(Helper.correctDouble((String) rs.getString("auto_insurance"))));//8
					strQuery1 = SQLParser.getSqlQuery("sel_vehsecuritydetails1^"+ strApplicationNo +"^"+Helper.correctNull((String) rs.getString("AUTO_SEC_SECID")));
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						if (Helper.correctNull(rs1.getString("app_sec_securitytype"))
								.equalsIgnoreCase("1"))
							arrvehicledetcol.add( "Prime");//9
						else
							arrvehicledetcol.add( "Collateral");//9
					}
					else{
						arrvehicledetcol.add("");//9
					}
					
					rs2 = DBUtils.executeLAPSQuery("Sel_valuationentry11^"
							+ strApplicationNo+"^"+Helper.correctNull((String) rs.getString("AUTO_SEC_SECID")));
					if (rs2.next()) {
					String valuation_dt = correctNull(rs2.getString("valuation_dt"));
					if (valuation_dt.equalsIgnoreCase("01/01/1900")) {
						valuation_dt = "";
					}
					arrvehicledetcol.add( valuation_dt);//10
					arrvehicledetcol.add( nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("mark_val_land")))));//11
					arrvehicledetcol.add( correctNull(rs2.getString("valuername")));	//12
					}
					else{
						arrvehicledetcol.add("");//10
						arrvehicledetcol.add("");//11
						arrvehicledetcol.add("");	//12
					}
					arrvehicledetcol.add(Helper.correctNull((String) rs.getString("AUTO_SEC_SECID")));//13
					arrvehicledetRow.add(arrvehicledetcol);
				}
				hshRecord.put("arrvehicledetRow", arrvehicledetRow);

			}

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_cbsidfordepositdet^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cbsid", Helper.correctNull((String) rs
						.getString("perapp_cbsid")));
			}

			if (rs != null) {
				rs.close();
			}
			String strsancdept="";
			strQuery = SQLParser.getSqlQuery("sel_sancauthbyappno^"
					+ strApplicationNo + "^" + "15");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("sancauth", Helper.correctNull((String) rs
						.getString("cbs_static_data_desc")));
				
				strsancdept=Helper.correctNull(rs.getString("appraisal_department"));
				
				hshRecord.put("com_sancdeptcode", Helper.correctNull(rs.getString("appraisal_department")));
			}
			if(!strsancdept.equalsIgnoreCase(""))
			{
				rs1=DBUtils.executeLAPSQuery("sel_cbsstaticdescbycode^"+"26"+"^"+strsancdept);
				if(rs1.next())
				{
					hshRecord.put("strSanctiondept",Helper.correctNull(rs1.getString("cbs_static_data_desc")));
				}
			}

			if (strConstCode.equalsIgnoreCase("01")) {
				strConstCode1 = "Date of Establishment / Date of Birth";
			} else {
				strConstCode1 = "Date of Birth";
			}
			hshRecord.put("constlabel", strConstCode1);

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
					+ strApplicationNo + "^" + "LoanProd");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("backcomments", Helper.CLOBToString(rs
						.getClob("cmt_comments")));
				hshRecord.put("backintercomments", Helper.CLOBToString(rs
						.getClob("cmt_intercomments")));
			}

			if (!strAppType.equalsIgnoreCase("Postsanction")) {
				// /* To get the Eligibility Details*/
				HashMap hshCheckElig = new HashMap();
				hshValues.put("prd_type", strProductType);
				hshCheckElig = new CheckEligibilityBean()
						.getEligibility(hshValues);
				hshRecord.put("hshCheckElig", hshCheckElig);
			}

			/* To get the Assessment Comments */
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_com_comments^RBICOM^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("assesscomments", Helper.CLOBToString(rs
						.getClob("COM_COMMENTS")));
			}

			/* To get the Assessment Comments */
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_cersaicibildetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("CER_CERSAIDETAILS",
						Helper.correctNull((String) rs
								.getString("CER_CERSAIDETAILS")));
				hshRecord.put("CER_OTHERINFORMATION", Helper
						.correctNull((String) rs
								.getString("CER_OTHERINFORMATION")));
			}

			/* To get the Assessment Comments */
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_npascheme^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("npa_amtwise", Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("npa_amtwise"))));
				hshRecord.put("npa_accwise", Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("npa_accwise"))));
				hshRecord.put("npa_ratification", Helper.CLOBToString((rs
						.getClob("npa_ratification"))));
				hshRecord.put("npa_concession", Helper.CLOBToString((rs
						.getClob("npa_concession"))));
			}
			hshRecord.put("prd_type", strProductType);

			if (rs != null) {
				rs.close();
			}
			ArrayList arrAppCol = new ArrayList();
			ArrayList arrAppRow = new ArrayList();
			String strDemotype = "", strDemotype1 = "";
			String str_perapp_fname = "", strSMACategory = "", str_perapp_id = "";
			strQuery = SQLParser.getSqlQuery("sel_CIBILdetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrAppCol = new ArrayList();
				arrAppCol
						.add(Helper.correctNull((String) rs.getString("name"))); // 0
				strDemotype = Helper.correctNull((String) rs
						.getString("demotype"));
				if (strDemotype.equalsIgnoreCase("a")) {
					strDemotype1 = "Applicant";
				} else if (strDemotype.equalsIgnoreCase("c")) {
					strDemotype1 = "Joint Applicant";
				} else if (strDemotype.equalsIgnoreCase("g")) {
					strDemotype1 = "Guarantor";
				} else if (strDemotype.equalsIgnoreCase("o")) {
					strDemotype1 = "Co-Obligant";
				} else {
					strDemotype1 = "";
				}
				arrAppCol.add(strDemotype1); // 1
				arrAppCol.add(Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("score")))); // 2
				arrAppCol.add(Helper.correctNull((String) rs
						.getString("comments"))); // 3

				if (correctNull(rs.getString("cibil_smacategory")).trim()
						.equalsIgnoreCase("Y")) {
					strSMACategory = "Yes";

				} else if (correctNull(rs.getString("cibil_smacategory"))
						.trim().equalsIgnoreCase("NA")) {
					strSMACategory = "Not Applicable";
				} else {
					strSMACategory = "No";
				}
				arrAppCol.add(Helper.correctNull(strSMACategory));// 4
				arrAppCol.add(Helper.correctNull((rs
						.getString("cibil_smadetails"))));// 5
				arrAppCol
						.add(Helper.correctNull((rs.getString("cibil_CRILC"))));// 6

				if (correctNull(rs.getString("CRIF_REFERED")).trim()
						.equalsIgnoreCase("Y")) {
					arrAppCol.add("Yes");// 7
					arrAppCol.add(Helper
							.correctNull(rs.getString("CRIF_SCORE")));// 8
					arrAppCol.add(Helper.correctNull(rs
							.getString("CRIF_DETAILS")));// 9
					arrAppCol
							.add(Helper.correctNull(rs.getString("CRIF_DATE")));// 10
				} else if (correctNull(rs.getString("CRIF_REFERED")).trim()
						.equalsIgnoreCase("NA")) {
					arrAppCol.add("Not Applicable");// 7
					arrAppCol.add("");// 8
					arrAppCol.add("");// 9
					arrAppCol.add("");// 10
				} else {
					arrAppCol.add("No");// 7
					arrAppCol.add("");// 8
					arrAppCol.add("");// 9
					arrAppCol.add("");// 10
				}

				arrAppRow.add(arrAppCol);
			}
			hshRecord.put("arrApptypeRow", arrAppRow);

			/* To get the NPA Details */
			if (!strPrdcode.equalsIgnoreCase("")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_npascheme^"
						+ strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("npa_concession", Helper.CLOBToString((rs
							.getClob("npa_concession"))));
				}
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_workflowcomment^"
					+ strApplicationNo + "^" + "R");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cpccomments", Helper.CLOBToString((rs
						.getClob("workflowcom_COMMENTS"))));
			}

			if (rs != null) {
				rs.close();
			}
			String strPrdtype = "";
			strQuery = SQLParser.getSqlQuery("setproductstypebyprdcode^"
					+ strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strPrdtype = Helper.correctNull((String) rs
						.getString("prd_loantype"));
				String strPrdtype1 = "";
				if (!strPrdtype.equalsIgnoreCase("")) {
					if (strPrdtype.equalsIgnoreCase("TL")) {
						strPrdtype1 = "Term Loan";
					} else if (strPrdtype.equalsIgnoreCase("OD")) {
						strPrdtype1 = "OverDraft";
					} else if (strPrdtype.equalsIgnoreCase("DL")) {
						strPrdtype1 = "Demand Loan";
					} else {
						strPrdtype1 = "Working Capital";
					}
					hshRecord.put("facnature", strPrdtype1);
				}
			}

			/* To get Existing Facility Details */
			ArrayList arrFacCol = new ArrayList();
			ArrayList arrFacRow = new ArrayList();
			String strCbsAccNo = "";
			String strFacilityDesc = "", strFacility = "", strFacilityId = "";
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_appfacexisting^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrFacCol = new ArrayList();
				
				if(!Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("R") && Helper.correctNull(rs.getString("combk_credittype")).equalsIgnoreCase("P"))
					continue;
				/*
				 * if(rs1!=null) { rs1.close(); }
				 * strQuery1=SQLParser.getSqlQuery
				 * ("Docinterestrate^"+strApplicationNo); rs1 =
				 * DBUtils.executeQuery(strQuery1); if(rs1.next()) {
				 * arrFacCol.add
				 * (Helper.correctNull(rs1.getString("loan_purposeofloan"
				 * )));//18 }
				 */
				arrFacCol.add(Helper.correctNull((String) rs
						.getString("combk_purpose")));// 0
				arrFacCol.add(Helper.correctNull((String) rs
						.getString("combk_limit")));// 1
				arrFacCol.add(Helper.correctInt((String) rs
						.getString("combk_sancrefno")));// 2
				arrFacCol.add(Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("combk_os"))));// 3
				arrFacCol.add(Helper.correctNull((String) rs
						.getString("combk_prestatus")));// 4
				String strFacilityFor = correctNull((String) rs
						.getString("combk_modtype"));
				strFacility = correctNull((String) rs
						.getString("combk_facility"));
				String strFacilityCode[] = strFacility.split("~");
				strFacilityId = Helper.correctInt(strFacilityCode[0]);

				if (strFacilityFor.equalsIgnoreCase("r")
						|| strFacilityFor.equalsIgnoreCase("p")) {
					rs1 = DBUtils.executeLAPSQuery("selLoanPurpose^"
							+ strFacilityId);
					if (rs1.next()) {
						strFacilityDesc = correctNull((String) rs1
								.getString("prddesc"));
					}
				} else {
					rs1 = DBUtils.executeLAPSQuery("sel_facilitycorp^"
							+ strFacilityId);
					if (rs1.next()) {
						strFacilityDesc = correctNull((String) rs1
								.getString("prddesc"));
					}
				}
				arrFacCol.add(strFacilityDesc);// 5
				arrFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("combk_interestrate")))));// 6
				arrFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("combk_monthly_ins")))));// 7
				arrFacCol.add(correctNull(rs.getString("combk_duedate")));// 8
				arrFacCol.add(correctNull(rs.getString("combk_arrears")));// 9
				arrFacRow.add(arrFacCol);
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_renewedfacilitydetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				arrFacCol = new ArrayList();
				arrFacCol.add("");
				arrFacCol.add(Helper.correctNull(rs.getString("sanc_lmt")));
				arrFacCol
						.add(Helper.correctNull(rs.getString("sanctionrefno")));
				strCbsAccNo = Helper.correctNull(rs.getString("cbs_accountno"));
				if (strCbsAccNo.equalsIgnoreCase("")) {
					arrFacCol.add("");
					arrFacCol.add("");
				} else {
					if (ApplicationParams.getCbsIntegration().equalsIgnoreCase(
							"TRUE")) {
						strQuery = SQLParser
								.getCBSSqlQuery("selliabpullingdirectacopening^"
										+ strCbsAccNo);
					} else {
						strQuery = SQLParser
								.getCBSSqlQuery("selliabpullingdirectacopening1^"
										+ strCbsAccNo);
					}
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQueryCBSConnection(strQuery);
					if (rs1.next()) {
						arrFacCol.add(String.valueOf(Double.parseDouble(Helper
								.correctDouble(rs1.getString("outstanding")))
								* -1));
						arrFacCol.add("");
					} else {
						arrFacCol.add("");
						arrFacCol.add("");
					}

				}
				arrFacCol.add(Helper.correctNull(rs.getString("prddesc")));
				arrFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("loan_modintrate")))));
				arrFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("loan_emi")))));
				arrFacCol.add("");
				arrFacCol.add("");
				arrFacRow.add(arrFacCol);
			}

			hshRecord.put("arrFacRow", arrFacRow);

			/* To get Joint Applicant Existing Facility Details */
			ArrayList arrJAFacCol = new ArrayList();
			ArrayList arrJAFacRow = new ArrayList();
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_JAppfacexisting^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrJAFacCol = new ArrayList();
				if (rs1 != null) {
					rs1.close();
				}
				// strQuery1=SQLParser.getSqlQuery("Docinterestrate^"+Helper.correctNull((String)rs.getString("comgc_parentappno")));
				// rs1 = DBUtils.executeQuery(strQuery1);
				// if(rs1.next())
				// {
				// arrJAFacCol.add(Helper.CLOBToString(rs1.getClob("loan_purposeofloan")));//0
				// }
				// else{
				// arrJAFacCol.add("");//0
				// }
				arrJAFacCol.add(Helper.correctNull(rs
						.getString("comgc_purpose")));// 0
				arrJAFacCol.add(Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("comgc_limit"))));// 1
				arrJAFacCol.add(Helper.correctNull((String) rs
						.getString("comgc_sancrefno")));// 2
				arrJAFacCol.add(Helper.checkDecimal(Helper
						.correctDouble((String) rs.getString("comgc_os"))));// 3
				arrJAFacCol.add(Helper.correctNull(rs
						.getString("comgc_prestatus")));// 4
				String str_modtype = Helper.correctNull((String) rs
						.getString("comgc_modtype"));
				String strbnkFac = Helper.correctNull((String) rs
						.getString("comgc_facility"));
				if (str_modtype.equalsIgnoreCase("c")
						|| str_modtype.equalsIgnoreCase("a")) {
					rs2 = DBUtils.executeLAPSQuery("sel_facilitycorp_desc^"
							+ strbnkFac);
					if (rs2.next()) {
						arrJAFacCol.add(correctNull(rs2
								.getString("com_facdesc")));// 5
					} else {
						arrJAFacCol.add("");// 5
					}
				} else if (str_modtype.equalsIgnoreCase("p")
						|| str_modtype.equalsIgnoreCase("r")) {
					rs2 = DBUtils.executeLAPSQuery("sel_retProductDesc^"
							+ strbnkFac);
					if (rs2.next()) {
						arrJAFacCol.add(correctNull(rs2
								.getString("com_facdesc")));// 5
					} else {
						arrJAFacCol.add("");// 5
					}
				} else {
					arrJAFacCol.add("");// 5
				}
				arrJAFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("comgc_intrate")))));// 6
				arrJAFacCol.add(nf.format(Double.parseDouble(Helper
						.correctDouble(rs.getString("comgc_monthly_ins")))));// 7
				arrJAFacCol.add(correctNull(rs.getString("comgc_duedate")));// 8
				arrJAFacCol.add(correctNull(rs.getString("comgc_arrears")));// 9
				arrJAFacCol.add(correctNull(rs.getString("demo_type")));// 10

				arrJAFacRow.add(arrJAFacCol);
			}
			hshRecord.put("arrJAFacRow", arrJAFacRow);

			/* To get Repayment Details */
			HashMap hshRepayment = new HashMap();
			hshValues.put("hidapplicantnewid", strappId);
			hshValues.put("hidapplicantid", strappId);
			hshRepayment = new RetailAssessmentBean()
					.getRepaymentCapacity(hshValues);
			hshRecord.put("hshRepayment", hshRepayment);

			// Bank Scheme
			String strguarantee = "", strMainAct = "", strSubAct = "";
			String strActivityCode = "";
			String strActivitySno = "";
			String strBankScheme = "", strBankSchemeDesc = "", strPrdLoanType = "", strPurpose = "";
			String strPur[] = new String[2];
			String strBsrCode = "", strBsr1Code = "";
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_prdloantype^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strPrdLoanType = Helper.correctNull((String) rs
						.getString("prd_loantype"));
				strBankScheme = Helper.correctNull((String) rs
						.getString("prd_bankscheme"));
			}

			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc^1^"
					+ strBankScheme);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strBankSchemeDesc = Helper.correctNull((String) rs
						.getString("mis_static_data_desc"));
			}
			hshRecord.put("strBankSchemeDesc", strBankSchemeDesc);

			strQuery = SQLParser.getSqlQuery("sel_misappdetails^"
					+ strApplicationNo + "^" + 1);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("app_totlim", Helper.correctDouble((String) rs
						.getString("app_totlim")));
				hshRecord.put("app_totlimser", Helper.correctDouble((String) rs
						.getString("app_totlimser")));
				hshRecord
						.put("app_totlimagri", Helper.correctDouble((String) rs
								.getString("app_totlimagri")));
				hshRecord.put("app_whetherrestructure", Helper
						.correctNull((String) rs
								.getString("app_whetherrestructure")));
				hshRecord.put("app_whetherservice", Helper
						.correctNull((String) rs
								.getString("app_whetherservice")));
				hshRecord.put("app_resunder", Helper.correctNull((String) rs
						.getString("app_resunder")));
				hshRecord
						.put("app_settlementno", Helper.correctNull((String) rs
								.getString("app_settlementno")));
				hshRecord.put("app_settlementdate", Helper
						.correctNull((String) rs
								.getString("app_settlementdate")));
				hshRecord.put("app_oldfacid", Helper.correctNull((String) rs
						.getString("app_oldfacid")));
				hshRecord.put("app_resreason", Helper.correctNull((String) rs
						.getString("app_resreason")));
				hshRecord.put("app_place", Helper.correctNull((String) rs
						.getString("app_place")));
				hshRecord.put("app_repayment", Helper.correctNull((String) rs
						.getString("app_repayment")));
				hshRecord.put("app_sourceofrepay",
						Helper.correctNull((String) rs
								.getString("app_sourceofrepay")));
				strguarantee = Helper.correctNull((String) rs
						.getString("app_guarantee"));
				hshRecord.put("app_guaranteeamt", Helper
						.correctDouble((String) rs
								.getString("app_guaranteeamt")));
				hshRecord.put("app_whethernewfac",
						Helper.correctNull((String) rs
								.getString("app_whethernewfac")));
				hshRecord.put("app_commencementdate", Helper
						.correctNull((String) rs
								.getString("app_commencementdate")));
				strActivityCode = Helper.correctNull((String) rs
						.getString("app_activitycode"));
				strActivitySno = Helper.correctNull((String) rs
						.getString("app_activitysno"));
				hshRecord.put("app_activitycode", strActivityCode);
				hshRecord.put("app_activitysno", strActivitySno);
				strMainAct = Helper.correctNull((String) rs
						.getString("app_mainactivity"));
				strSubAct = Helper.correctNull((String) rs
						.getString("app_subactivity"));
				hshRecord.put("app_purpose", Helper.correctNull((String) rs
						.getString("app_purpose")));
				hshRecord.put("app_bsrcode", Helper.correctNull((String) rs
						.getString("app_bsrcode")));
				hshRecord.put("app_bsr1code", Helper.correctNull((String) rs
						.getString("app_bsr1code")));
				hshRecord
						.put("app_industrytype", Helper.correctNull((String) rs
								.getString("app_industrytype")));
				hshRecord.put("app_assetclassifcation", Helper
						.correctNull((String) rs
								.getString("app_assetclassifcation")));
				hshRecord.put("app_dispscreen", Helper.correctNull((String) rs
						.getString("app_dispscreen")));
				hshRecord
						.put("app_facility_sno", Helper.correctNull((String) rs
								.getString("app_facility_sno")));
				hshRecord.put("app_sharebroker", Helper.correctNull((String) rs
						.getString("app_sharebroker")));
				strPurpose = Helper.correctNull((String) rs
						.getString("app_purpose"));
				strBsrCode = Helper.correctNull((String) rs
						.getString("app_bsrcode"));
				strBsr1Code = Helper.correctNull((String) rs
						.getString("app_bsr1code"));

			}

			rs = DBUtils.executeLAPSQuery("sel_guarantee^" + "17" + "^"
					+ strguarantee);
			if (rs.next()) {
				hshRecord.put("app_Guarantee Covered", Helper
						.correctNull((String) rs
								.getString("mis_static_data_desc")));
			}

			if (rs != null) {
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("sel_MISSubActivityDesc^"
					+ strMainAct + "^" + strSubAct);
			if (rs.next()) {
				hshRecord.put("mis_subactdesc", Helper.correctNull((String) rs
						.getString("mis_subactdesc")));
			}

			if (rs != null) {
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("sel_misappclassification^"
					+ strApplicationNo + "^" + "1");
			if (rs.next()) {
				String strSector = Helper.correctNull((String) rs
						.getString("app_sector"));
				String strGOVTANNOUNCESCHEME = Helper.correctNull((String) rs
						.getString("APP_GOVTANNOUNCESCHEME"));
				String str_STANDUP_INDIA = Helper.correctNull((String) rs
						.getString("APP_STANDUP_INDIA"));
				hshRecord
						.put("mis_infrastructure", Helper
								.correctNull((String) rs
										.getString("APP_INFRASTRCODE")));
				if (strSector.equalsIgnoreCase("01")
						|| strSector.equalsIgnoreCase("1")) {
					hshRecord.put("mis_sctortloan", "Priority Sector");
				} else if (strSector.equalsIgnoreCase("02")
						|| strSector.equalsIgnoreCase("2")) {
					hshRecord.put("mis_sctortloan", "Non Priority Sector");
				} else {
					hshRecord.put("mis_sctortloan", "");
				}
				if(str_STANDUP_INDIA.equalsIgnoreCase("Y"))
					hshRecord.put("mis_StandupDesc", "Yes");
				else if(str_STANDUP_INDIA.equalsIgnoreCase("N"))
					hshRecord.put("mis_StandupDesc", "No");
				else
					hshRecord.put("mis_StandupDesc", "Nil");
				
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
						+ "7"
						+ "^"
						+ Helper.correctNull((String) rs
								.getString("app_subsector")));
				if (rs1.next()) {
					hshRecord.put("mis_subscetroloan", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					if (rs1 != null) {
						rs1.close();
					}
					rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
							+ "8"
							+ "^"
							+ Helper.correctNull((String) rs
									.getString("app_subsector")));
					if (rs1.next()) {
						hshRecord.put("mis_subscetroloan", Helper
								.correctNull((String) rs1
										.getString("mis_static_data_desc")));
					}
				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
						+ "9"
						+ "^"
						+ Helper.correctNull((String) rs
								.getString("app_weakersec")));
				if (rs1.next()) {
					hshRecord.put("mis_weaksection", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_weaksection", "Nil");
				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
						+ "11"
						+ "^"
						+ Helper.correctNull((String) rs
								.getString("app_sensitivesector")));
				if (rs1.next()) {
					hshRecord.put("mis_sensitivitysec", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_sensitivitysec", "Nil");
				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
						+ "12"
						+ "^"
						+ Helper.correctNull((String) rs
								.getString("app_agriculture")));
				if (rs1.next()) {
					hshRecord.put("mis_indcattyepagr", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_indcattyepagr", "Nil");
				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_activity_codedetails^"
						+ "2" + "^" + strMainAct);
				if (rs1.next()) {
					hshRecord.put("mis_mainactivitydesc", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_mainactivitydesc", "Nil");
				}

				if (rs1 != null) {
					rs1.close();
				}

				if (!strPurpose.equalsIgnoreCase("")) {
					strPur = strPurpose.split("_");
					rs1 = DBUtils.executeLAPSQuery("sel_purpose_detailsmis^"
							+ "3" + "^" + strPur[0] + "^" + strPur[1]);
					if (rs1.next()) {
						hshRecord.put("mis_purpose", Helper
								.correctNull((String) rs1
										.getString("mis_static_data_desc")));
					}
				} else {
					hshRecord.put("mis_purpose", "Nil");
				}

				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_BSRNameforcode^"
						+ strBsrCode);
				if (rs1.next()) {
					hshRecord.put("mis_bsrcodedesc", Helper
							.correctNull((String) rs1.getString("ind_name")));
				} else {
					hshRecord.put("mis_bsrcodedesc", "Nil");
				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_activity_codedetails^"
						+ "6" + "^" + strBsr1Code);
				if (rs1.next()) {
					hshRecord.put("mis_bsr1codedesc", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_bsr1codedesc", "Nil");
				}

				if (rs1 != null) {
					rs1.close();
				}
				String strGovtScheme = "", strSchemCode = "";
				rs1 = DBUtils.executeLAPSQuery("getlreq^" + strApplicationNo);
				if (rs1.next()) {
					strGovtScheme = Helper.correctNull((String) rs1
							.getString("LOAN_GOVT"));
					strSchemCode = Helper.correctNull((String) rs1
							.getString("GOVT_SCHEME"));
					hshRecord.put("strisGovtScheme", strGovtScheme);
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (strGovtScheme.equalsIgnoreCase("1")) {
					rs1 = DBUtils.executeLAPSQuery("selstaticdatadesccode^"
							+ "11" + "^" + strSchemCode);
					if (rs1.next()) {

						hshRecord.put("mis_govnysponser", Helper
								.correctNull((String) rs1
										.getString("stat_data_desc1")));
					} else {
						hshRecord.put("mis_govnysponser", "");

					}

					if (rs2 != null)
						rs2 = null;
					strQuery = SQLParser.getSqlQuery("sel_PMAY_desc^"
							+ strApplicationNo);
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						if (rs1 != null)
							rs1 = null;
						strQuery = SQLParser.getSqlQuery("select_Pmay_desc^"
								+ Helper.correctNull(rs2
										.getString("PMAY_HOUSE_CAT")));
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next()) {
							hshRecord.put("strGovtCategory", Helper
									.correctNull(rs1
											.getString("PM_SUBCATEGORY")));
						}

					}

				}
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("selcredfreez^"
						+ strApplicationNo);
				if (rs1.next()) {
					hshRecord.put("strcre_rating", Helper
							.correctNull((String) rs1.getString("cre_rating")));
					hshRecord.put("strcre_weight", Helper
							.correctNull((String) rs1.getString("cre_weight")));
				}
				
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_activity_codedetails^"
						+ "23" + "^" + strGOVTANNOUNCESCHEME);
				if (rs1.next()) {
					hshRecord.put("mis_GovtSchemeDesc", Helper
							.correctNull((String) rs1
									.getString("mis_static_data_desc")));
				} else {
					hshRecord.put("mis_GovtSchemeDesc", "Nil");
				}
				if (rs1 != null)
					rs1.close();
			}
			//for CBS Branch display
			String strOrg_Name="",strFacilitySno="1";
			strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strApplicationNo+"^"+strFacilitySno);
			if(rs!=null)
			rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOrgCode=Helper.correctNull(rs.getString("LOANDISBBRANCH"));
				strOrg_Name="";
				if(!strOrgCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strOrg_Name=Helper.correctNull((String)rs1.getString("org_name"));
						hshRecord.put("strOrg_Name", strOrg_Name);
					}
				}
				}
			
			//end
			if (rs != null) {
				rs.close();
			}
			String strPeriodicity = "", strHoliday = "", strServiced = "";

			strQuery = SQLParser.getSqlQuery("securesel^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strHoliday = Helper.correctNull((String) rs
						.getString("loan_noofinstallment"));
				strPeriodicity = Helper.correctNull((String) rs
						.getString("loan_periodicity"));
				strServiced = Helper.correctNull((String) rs
						.getString("loan_servised"));
			}
			if (strPeriodicity.equalsIgnoreCase("m")) {
				strPeriodicity = "Monthly";
			} else if (strPeriodicity.equalsIgnoreCase("q")) {
				strPeriodicity = "Quarterly";
			} else if (strPeriodicity.equalsIgnoreCase("h")) {
				strPeriodicity = "Half-Yearly";
			} else if (strPeriodicity.equalsIgnoreCase("y")) {
				strPeriodicity = "Yearly";
			} else if (strPeriodicity.equalsIgnoreCase("n")) {
				strPeriodicity = "Not Applicable";
			}
			hshRecord.put("strPeriodicity", strPeriodicity);

			if (rs != null) {
				rs.close();
			}
			String strIntFreq = "";
			strQuery = SQLParser.getSqlQuery("sel_cuscbsacdetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strIntFreq = Helper.correctNull((String) rs
						.getString("INTRATEFREQ"));
			}

			if (strIntFreq.equalsIgnoreCase("M")) {
				strIntFreq = "Monthly";
			} else if (strIntFreq.equalsIgnoreCase("Q")) {
				strIntFreq = "Quartely";
			} else if (strIntFreq.equalsIgnoreCase("H")) {
				strIntFreq = "Half-yearly";
			} else if (strIntFreq.equalsIgnoreCase("Y")) {
				strIntFreq = "Yearly";
			}
			hshRecord.put("strIntFreq", strIntFreq);

			/*** For Educational Details - Added by DINESH on 09/04/2014 ***/

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("eduparticularssel^"
					+ strApplicationNo);

			if (rs.next()) {
				hshRecord.put("edu_coursename", correctNull(rs
						.getString("edu_coursename")));
				hshRecord.put("edu_course_approved", correctNull(rs
						.getString("edu_course_approved")));
				hshRecord.put("edu_course_approvedby", correctNull(rs
						.getString("edu_course_approvedby")));
				hshRecord.put("edu_univ_approved", correctNull(rs
						.getString("edu_univ_approved")));
				hshRecord.put("edu_univ_approvedby", correctNull(rs
						.getString("edu_univ_approvedby")));
				hshRecord.put("edu_univ_addr", correctNull(rs
						.getString("edu_univ_addr")));
				hshRecord.put("edu_partfull", correctNull(rs
						.getString("edu_partfull")));
				hshRecord.put("edu_qual_proposed", correctNull(rs
						.getString("edu_qual_proposed")));
				hshRecord.put("edu_commencedate", correctNull(rs
						.getString("edu_commencedate")));
				hshRecord.put("edu_mode_secure", correctNull(rs
						.getString("edu_mode_secure")));
				hshRecord.put("edu_univ_situ_domicile", correctNull(rs
						.getString("edu_univ_situ_domicile")));
				hshRecord.put("edu_comp_stay_hostel", correctNull(rs
						.getString("edu_comp_stay_hostel")));
				hshRecord.put("edu_comments1", correctNull(rs
						.getString("edu_comments1")));
				hshRecord.put("edu_comments2", correctNull(rs
						.getString("edu_comments2")));
				hshRecord.put("edu_comments3", correctNull(rs
						.getString("edu_comments3")));
				hshRecord.put("edu_comments4", correctNull(rs
						.getString("edu_comments4")));
				hshRecord.put("edu_studies_in", correctNull(rs
						.getString("edu_studies_in")));
				hshRecord.put("expected_income", correctNull(rs
						.getString("expected_income")));
				hshRecord.put("EDU_MERITORIOUS", correctNull(rs
						.getString("EDU_MERITORIOUS")));
				hshRecord.put("edu_univ_name", (String) correctNull(rs
						.getString("edu_univ_name")));
				hshRecord.put("edu_qualifyingexa", (String) correctNull(rs
						.getString("edu_qualifyingexa")));
				hshRecord.put("edu_typeofcourse", correctNull(rs
						.getString("edu_typeofcourse")));

				String duration = correctNull(rs.getString("edu_duration"));
				StringTokenizer tknz = new StringTokenizer(duration, "~");
				hshRecord.put("edu_durationyrs", ((String) tknz.nextElement())
						.trim());
				hshRecord.put("edu_durationmon", ((String) tknz.nextElement())
						.trim());
			}

			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("sel_products_education^"
					+ strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("prd_purpose", Helper.correctNull((String) rs
						.getString("prd_purpose")));
			}

			if (rs != null) {
				rs.close();
			}
			if (rs2 != null) {
				rs2.close();
			}
			if (rs3 != null) {
				rs3.close();
			}
			rs = DBUtils.executeLAPSQuery("sel_common_customer^" + Helper.correctNull((String) hshValues.get("comappid")));
			if (rs.next()) {
				hshRecord.put("indinfo_family_income", Helper
						.correctDouble((String) rs
								.getString("indinfo_family_income")));
				rs2=DBUtils.executeLAPSQuery("selmiscust^109^"+Helper.correctNull((String)rs.getString("perapp_status")));
				if(rs2.next())
				{	
					hshRecord.put("perapp_status", Helper.correctNull(rs2.getString("stat_data_desc1")));

				}
				hshRecord.put("perapp_relat_staffid", Helper.correctNull((String) rs
						.getString("perapp_relat_staffid")));
				rs3=DBUtils.executeLAPSQuery("selmiscust^110^"+Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")));
				if(rs3.next())
				{	
					hshRecord.put("perapp_relation_bankstaff", Helper.correctNull(rs3.getString("stat_data_desc1")));

				}
				if(Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")).equalsIgnoreCase("005")||Helper.correctNull((String)rs.getString("perapp_relation_bankstaff")).equalsIgnoreCase("006")){
					hshRecord.put("perapp_relation_staffname", Helper.correctNull((String) rs.getString("perapp_relation_staffname")));

			   }else{
				rs4=DBUtils.executeLAPSQuery("selmiscust^153^"+Helper.correctNull((String)rs.getString("perapp_relation_staffname")));
				if(rs4.next())
				{	
					hshRecord.put("perapp_relation_staffname", Helper.correctNull(rs4.getString("stat_data_desc1")));

				}
			   }
				rs1=DBUtils.executeLAPSQuery("selmiscust^111^"+Helper.correctNull((String)rs.getString("perapp_blood_relation")));
				if(rs1.next())
				{	
					hshRecord.put("perapp_blood_relation", Helper.correctNull(rs1.getString("stat_data_desc1")));

				}
				hshRecord.put("PEREMP_ID", Helper.correctNull((String) rs
						.getString("PEREMP_ID")));
				hshRecord.put("PEREMP_ESTABLISH", Helper.correctNull((String) rs
						.getString("PEREMP_ESTABLISH")));
				hshRecord.put("peremp_department", Helper.correctNull((String) rs
						.getString("peremp_department")));
				hshRecord.put("peremp_retdate", Helper.correctNull((String) rs
						.getString("peremp_retdate")));
				hshRecord.put("perapp_relation_bankstaff_val", Helper.correctNull((String) rs
						.getString("perapp_relation_bankstaff")));
				hshRecord.put("indinfo_is_staff", Helper.correctNull((String) rs
						.getString("indinfo_is_staff")));
				hshRecord.put("PERAPP_INVOCDATE", Helper.correctNull((String) rs
						.getString("PERAPP_INVOCDATE")));
				hshRecord.put("indinfo_dateof_joining", Helper.correctNull((String) rs
						.getString("indinfo_dateof_joining")));
				hshRecord.put("indinfo_staff_id", Helper.correctNull((String) rs
						.getString("indinfo_staff_id")));
			}

			// For Other Educational Details
			strQuery = SQLParser.getSqlQuery("edudetailsselection^"
					+ strApplicationNo);
			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("edu_id")));
				vecVal.add(correctNull(rs.getString("edu_exam")));
				vecVal.add(correctNull(rs.getString("edu_university")));
				vecVal.add(correctNull(rs.getString("edu_yearpass")));
				vecVal.add(correctNull(rs.getString("edu_attempts")));
				vecVal.add(correctNull(rs.getString("edu_marks")));
				vecVal.add(correctNull(rs.getString("edu_class")));

				vecData.add(vecVal);
			}
			hshRecord.put("vecDataEdu", vecData);

			// For Scholarship Details
			strQuery = SQLParser.getSqlQuery("eduscholarsselection^"
					+ strApplicationNo);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("edu_id")));
				vecVal.add(correctNull(rs.getString("edu_exam")));
				vecVal.add(correctNull(rs.getString("edu_academic")));
				vecVal.add(correctNull(rs.getString("edu_name")));
				vecVal.add(correctNull(rs.getString("edu_amount")));
				String strFrom = correctNull(rs.getString("edu_from"));
				String strTo = correctNull(rs.getString("edu_to"));
				if (strFrom.trim().equals("01/01/1900")) {
					vecVal.add("");
				} else {
					vecVal.add(strFrom);
				}
				if (strTo.trim().equals("01/01/1900")) {
					vecVal.add("");
				} else {
					vecVal.add(strTo);
				}
				vecDataSchl.add(vecVal);
			}
			hshRecord.put("vecDataSchl", vecDataSchl);

			// For Course Fees Details

			double dblTotYr1 = 0.00, dblTotYr2 = 0.00, dblTotYr3 = 0.00, dblTotYr4 = 0.00, dblTotYr5 = 0.00, dblTotYr6 = 0.00, dblColTot = 0.00;
			strQuery = SQLParser.getSqlQuery("sel_cop_educoursedet^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);

			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			while (rs.next()) {
				vecRow = new ArrayList();
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year1"))); // 0
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year2"))); // 1
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year3"))); // 2
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year4"))); // 3
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year5"))); // 4
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_year6"))); // 5
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_col_total"))); // 6
				vecRow.add(Helper.correctNull((String) rs
						.getString("edu_comments"))); // 7
				vecRow.add(Helper
						.correctNull((String) rs.getString("edu_type"))); // 8
				vecCol.add(vecRow);

				dblTotYr1 = dblTotYr1
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year1")));
				dblTotYr2 = dblTotYr2
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year2")));
				dblTotYr3 = dblTotYr3
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year3")));
				dblTotYr4 = dblTotYr4
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year4")));
				dblTotYr5 = dblTotYr5
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year5")));
				dblTotYr6 = dblTotYr6
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year6")));
				dblColTot = dblColTot
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_col_total")));
			}
			hshRecord.put("vecCol", vecCol);
			hshRecord.put("dblTotYr1", "" + dblTotYr1);
			hshRecord.put("dblTotYr2", "" + dblTotYr2);
			hshRecord.put("dblTotYr3", "" + dblTotYr3);
			hshRecord.put("dblTotYr4", "" + dblTotYr4);
			hshRecord.put("dblTotYr5", "" + dblTotYr5);
			hshRecord.put("dblTotYr6", "" + dblTotYr6);
			hshRecord.put("dblColTot", "" + dblColTot);

			double dblTotYr1mof = 0.00, dblTotYr2mof = 0.00, dblTotYr3mof = 0.00, dblTotYr4mof = 0.00, dblTotYr5mof = 0.00, dblTotYr6mof = 0.00, dblColTotmof = 0.00;
			strQuery = SQLParser.getSqlQuery("sel_mof_educoursedet^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			double dblMOFtotal = 0.00;
			ArrayList vecRowMOF = new ArrayList();
			ArrayList vecColMOF = new ArrayList();
			while (rs.next()) {
				vecRowMOF = new ArrayList();
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year1"))); // 0
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year2"))); // 1
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year3"))); // 2
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year4"))); // 3
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year5"))); // 4
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_year6"))); // 5
				dblMOFtotal = Double.parseDouble(Helper.correctDouble(rs
						.getString("edu_year1")))
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year2")))
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year3")))
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year4")))
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year5")))
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year6")));
				vecRowMOF.add(String.valueOf(dblMOFtotal)); // 6
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_comments"))); // 7
				vecRowMOF.add(Helper.correctNull((String) rs
						.getString("edu_type"))); // 8
				vecColMOF.add(vecRowMOF);

				dblTotYr1mof = dblTotYr1mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year1")));
				dblTotYr2mof = dblTotYr2mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year2")));
				dblTotYr3mof = dblTotYr3mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year3")));
				dblTotYr4mof = dblTotYr4mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year4")));
				dblTotYr5mof = dblTotYr5mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year5")));
				dblTotYr6mof = dblTotYr6mof
						+ Double.parseDouble(Helper.correctDouble(rs
								.getString("edu_year6")));
			}
			dblColTotmof = dblColTotmof + dblTotYr1mof + dblTotYr2mof
					+ dblTotYr3mof + dblTotYr4mof + dblTotYr5mof + dblTotYr6mof;
			hshRecord.put("vecColMOF", vecColMOF);
			hshRecord.put("dblTotYr1mof", "" + dblTotYr1mof);
			hshRecord.put("dblTotYr2mof", "" + dblTotYr2mof);
			hshRecord.put("dblTotYr3mof", "" + dblTotYr3mof);
			hshRecord.put("dblTotYr4mof", "" + dblTotYr4mof);
			hshRecord.put("dblTotYr5mof", "" + dblTotYr5mof);
			hshRecord.put("dblTotYr6mof", "" + dblTotYr6mof);
			hshRecord.put("dblColTotmof", "" + dblColTotmof);

			// Added by Kishan
			if (strEmpStatus.equals("4")) {
				HashMap hshFarm = new HashMap();
				ComProposalBean comProposal = new ComProposalBean();
				hshFarm = comProposal.getFarmBudget(hshValues);
				log.info("hshFarm : " + hshFarm);
				hshRecord.put("hshFarm", hshFarm);
			}
			hshRecord.put("empemployment", strEmpStatus);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_comments^secoverageretail^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("SECURITY_COMMENTS", Helper.CLOBToString(rs
						.getClob("COM_COMMENTS")));
			}
			strQuery = SQLParser.getSqlQuery("sel_comments^otherparams^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("subject", Helper.CLOBToString(rs
						.getClob("COM_COMMENTS")));
			}
			strQuery = SQLParser.getSqlQuery("sel_comments^otherparams1^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("brief_history", Helper.CLOBToString(rs
						.getClob("COM_COMMENTS")));
			}
			strQuery = SQLParser.getSqlQuery("sel_comments^otherparams3^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("recommendations", Helper.CLOBToString(rs
						.getClob("COM_COMMENTS")));
			}

			if (rs1 != null) {
				rs1.close();
			}
			ArrayList arrSecLegal = new ArrayList();
			strQuery = SQLParser.getSqlQuery("sel_secdetbyappno^"
					+ strApplicationNo);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next()) {
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selseclegalopinion^"
						+ Helper.correctInt(rs1.getString("APP_SEC_SECID")));
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					arrayCol = new ArrayList();
					arrayCol.add(correctNull(rs.getString("SEC_PL_LAWNAME")));// 0
					arrayCol.add(correctNull(rs.getString("SEC_PL_LEGOPDATE")));// 1
					arrayCol.add(correctNull(rs
							.getString("SEC_PL_LEGOPSUPDATE")));// 2
					arrayCol.add(correctNull(rs
							.getString("SEC_PL_LEGALAUDREPDATE")));// 3
					arrayCol.add(correctNull(rs.getString("SEC_PL_CERSID")));// 4
					arrayCol.add(correctNull(rs.getString("SEC_PL_TITLE")));// 5
					arrayCol.add(correctNull(rs.getString("SEC_PL_EC")));// 6
					arrayCol.add(correctNull(rs.getString("SEC_PL_TAX")));// 7
					arrayCol.add(correctNull(rs.getString("SEC_PL_MORTG")));// 8

					strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
							+ Helper.correctInt(rs1.getString("APP_SEC_SECID"))
							+ "^securityLegalOpinion");
					rs2 = DBUtils.executeQuery(strQuery);
					if (rs2.next()) {
						arrayCol.add(Helper.CLOBToString(rs2
								.getClob("cmt_comments")));// 9
					} else {
						arrayCol.add("");// 9
					}
					arrayCol.add(correctNull(rs1.getString("sec_name")));// 10
					arrayCol.add(Helper.CLOBToString(rs1
							.getClob("cus_sec_security_description")));// 11
					arrayCol
							.add(correctNull(rs.getString("sec_pl_elitepanel")));// 12
					arrayCol.add(correctNull(rs.getString("SEC_PL_ID")));// 13
					arrayCol.add(correctNull(rs
							.getString("SEC_PL_SEARCHFROM_PROP")));// 14
					arrayCol.add(correctNull(rs.getString("SEC_PL_PERIOD_EC")));// 15
					arrayCol.add(correctNull(rs.getString("sec_lawyer_seqno")));// 16
					arrayCol.add(correctNull(rs.getString("SEC_PL_GOVT_LAWYERNAME")));// 17
					
					arrSecLegal.add(arrayCol);
				}
			}

			hshRecord.put("arrSecLegal", arrSecLegal);
			if (rs != null) {
				rs.close();
			}
			String Prop_Type="";
			rs = DBUtils.executeLAPSQuery("Sel_valuationentry1^"
					+ strApplicationNo);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("app_no")));// 0
				vecCol.add(correctNull(rs.getString("valu_sno")));// 1
				String entry_date = correctNull(rs.getString("entry_date"));
				if (entry_date.equalsIgnoreCase("01/01/1900")) {
					entry_date = "";
				}
				vecCol.add(entry_date);// 2
				vecCol.add(correctNull(rs.getString("valuers_code")));// 3
				vecCol.add(correctNull(rs.getString("let_cer_no")));// 4
				String let_cer_date = correctNull(rs.getString("let_cer_date"));
				if (let_cer_date.equalsIgnoreCase("01/01/1900")) {
					let_cer_date = "";
				}
				vecCol.add(let_cer_date);// 5
				vecCol.add(correctNull(rs.getString("mark_val_land")));// 6
				vecCol.add(correctNull(rs.getString("mark_val_build")));// 7
				vecCol.add(correctNull(rs.getString("esti_val_force")));// 8
				vecCol.add(correctNull(rs.getString("remark_note")));// 9
				String valuation_dt = correctNull(rs.getString("valuation_dt"));
				if (valuation_dt.equalsIgnoreCase("01/01/1900")) {
					valuation_dt = "";
				}
				vecCol.add(valuation_dt);// 10
				vecCol.add(correctNull(rs.getString("reference_rt")));// 11
				vecCol.add(correctNull(rs.getString("guidance_rt")));// 12
				vecCol.add(correctNull(rs.getString("send_date")));// 13
				vecCol.add(correctNull(rs.getString("valuers_code")));// 14
				vecCol.add(correctNull(rs.getString("valuername")));// 15
				vecCol.add(correctNull(rs.getString("branchpanel")));// 16
				vecCol.add(correctNull(rs.getString("VALUER_CATEGORYCODE")));// 17
				vecCol.add(correctNull(rs.getString("SEC_SECURITYID")));// 18
				if (!correctNull(rs.getString("SEC_SECURITYID")).equalsIgnoreCase("")) {
					if (rs1 != null) {
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_proposedasset_sec^"+ strApplicationNo+"^"+correctNull(rs.getString("SEC_SECURITYID")));
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						Prop_Type="";
						//vecCol.add(correctNull(rs1.getString("CUS_SEC_CLASSIFICATION")));// 19
						if(!correctNull(rs1.getString("CUS_SEC_CLASSIFICATION")).equalsIgnoreCase("")){
							if (rs2 != null) {
								rs2.close();
							}
							rs2 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs1.getString("CUS_SEC_CLASSIFICATION")) );
							if (rs2.next()) {
								vecCol.add(correctNull(rs2.getString("SEC_NAME")));//19
							}
						}else{vecCol.add("");}
						if(correctNull(rs1.getString("SEC_PROPERTYTYPE")).equalsIgnoreCase("L")){Prop_Type="Land";}
						else if(correctNull(rs1.getString("SEC_PROPERTYTYPE")).equalsIgnoreCase("F")){Prop_Type="Flat / Apartment";}
						else if(correctNull(rs1.getString("SEC_PROPERTYTYPE")).equalsIgnoreCase("H")){Prop_Type="House / Building";}
						else{Prop_Type="";}
						vecCol.add(Prop_Type);// 20
						vecCol.add(correctNull(rs1.getString("SEC_TOTALAREA")));// 21
						vecCol.add(correctNull(rs1.getString("SEC_EXTENTOFBUILDING")));// 22
						vecCol.add(correctNull(rs1.getString("sec_salevalue")));// 23
						vecCol.add(correctNull(rs1.getString("CUS_SEC_VALUERCODE")));// 24
						vecCol.add(correctNull(rs1.getString("CUS_SEC_GOVT_VALUER")));// 25
						
					}
				}else{
					vecCol.add("");
					vecCol.add("");
					vecCol.add("");
					vecCol.add("");
					vecCol.add("");
					vecCol.add("");
					vecCol.add("");
				}
				vecRow.add(vecCol);

				hshRecord.put("strVehValuationDate", valuation_dt);
				hshRecord.put("strVehMarketValue", nf.format(Double
						.parseDouble(Helper.correctDouble(rs
								.getString("mark_val_land")))));
				hshRecord.put("strVehValuerName", correctNull(rs
						.getString("valuername")));
			}

			hshRecord.put("vecRow", vecRow);
			
			
			if (rs != null) {
				rs.close();
			}
			/*
			 * strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+
			 * Helper.correctInt
			 * ((String)hshValues.get("strSecId"))+"^securityLegalOpinion"); rs
			 * = DBUtils.executeQuery(strQuery); if (rs.next()) {
			 * hshRecord.put("cmtvalulation_comments",
			 * Helper.CLOBToString(rs.getClob("cmt_comments")));
			 * hshRecord.put("cmtvalulation_cmtinter",
			 * Helper.CLOBToString(rs.getClob("cmt_intercomments"))); }
			 */

			double dblTotal = 0.00;
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"
					+ strApplicationNo + "^1");
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arrRepaySchedule = new ArrayList();
			while (rs.next()) {
				arrayCol = new ArrayList();
				arrayCol.add(correctNull(rs.getString("TL_FEQUENCY")));
				arrayCol.add(correctNull(rs.getString("TL_NOOFINST")));
				arrayCol.add(correctNull(rs.getString("TL_TOTALAMT")));
				arrayCol.add(correctNull(rs.getString("TL_INSTAMT")));
				dblTotal = dblTotal
						+ Double.parseDouble(Helper.correctDouble((String) rs
								.getString("TL_TOTALAMT")));
				arrRepaySchedule.add(arrayCol);
			}
			hshRecord.put("arrRepaySchedule", arrRepaySchedule);
			hshRecord.put("RepaySheduleTotal", nf.format(dblTotal));
			if (rs != null)
				rs.close();
			rs = DBUtils
					.executeLAPSQuery("selloan_details^" + strApplicationNo);
			if (rs.next()) {
				staffproduct = correctNull(rs.getString("prd_staffprd"));
				hshRecord.put("staffproduct", correctNull(rs
						.getString("prd_staffprd")));

				// Whether verfied with Central Fraud Registry ?

				hshRecord.put("staffproduct", correctNull(rs
						.getString("prd_staffprd")));
				hshRecord.put("VerifyWithCFR", Helper.correctNull((String) rs
						.getString("LOAN_CFR_VERIFIED")));
				if (Helper.correctNull(
						(String) rs.getString("LOAN_CFR_VERIFIED"))
						.equalsIgnoreCase("Y")) {
					strVerifyWithCFR = "YES";

				} else if (Helper.correctNull(
						(String) rs.getString("LOAN_CFR_VERIFIED"))
						.equalsIgnoreCase("N")) {
					strVerifyWithCFR = "NO";
				}

				hshRecord.put("NamApprCFR", Helper.correctNull((String) rs
						.getString("LOAN_CFR_BORNAME")));
				if (Helper.correctNull(
						(String) rs.getString("LOAN_CFR_BORNAME"))
						.equalsIgnoreCase("Y")) {
					strNamApprCFR = "YES";
				} else {
					strNamApprCFR = "NO";
				}
				hshRecord.put("RefNoCFR", Helper.correctNull((String) rs
						.getString("LOAN_CFR_DEV_RENFO")));

				hshRecord.put("STATUS_VERIFIED", Helper.correctNull((String) rs
						.getString("STATUS_VERIFIED")));

				if (Helper
						.correctNull((String) rs.getString("STATUS_VERIFIED"))
						.equalsIgnoreCase("A")) {
					strStatusVer = "APPROVED";
				} else if (Helper.correctNull(
						(String) rs.getString("STATUS_VERIFIED"))
						.equalsIgnoreCase("R")) {
					strStatusVer = "REJECTED";
				}

				hshRecord.put("LOAN_APPR_DATE", Helper.correctNull((String) rs
						.getString("LOAN_APPR_DATE")));
				// hshRecord.put("LOAN_USERID1",Helper.correctNull((String)rs.getString("LOAN_USERID1")));
				ApprUserid = Helper.correctNull((String) rs
						.getString("LOAN_USERID1"));

				if (ApprUserid != "") {
					if (rs1 != null) {
						rs1.close();
					}

					strQuery = SQLParser.getSqlQuery("selectusername^"
							+ ApprUserid);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						hshRecord.put("appuserid", correctNull((String) rs1
								.getString("name")));
					}
				}

				hshRecord.put("strStatusVer", strStatusVer);
				hshRecord.put("strVerifyWithCFR", strVerifyWithCFR);
				hshRecord.put("strNamApprCFR", strNamApprCFR);

			}

			if (staffproduct.equalsIgnoreCase("Y")) {
				hshRecord.put("WhetherEMI", "No");
				if (rs1 != null)
					rs1.close();
				ArrayList arrROI = new ArrayList();
				rs = DBUtils.executeLAPSQuery("rulechoice^fixed^" + strPrdcode+"^O");
				while (rs.next()) {
					rs1 = DBUtils.executeLAPSQuery("ruleresult^"
							+ Helper.correctInt(rs.getString("prdint_sno")));
					while (rs1.next()) {
						arrayCol = new ArrayList();
						arrayCol.add(correctNull(rs
								.getString("prd_amtrangefrom")));
						arrayCol
								.add(correctNull(rs.getString("prd_amtrangeto")));
						arrayCol.add(nf.format(Double.parseDouble(Helper
								.correctDouble(rs1.getString("prd_baserate")))
								+ Double.parseDouble(Helper.correctDouble(rs1
										.getString("prd_adjust")))));
						arrROI.add(arrayCol);
					}

				}
				hshRecord.put("arrROI", arrROI);

			}
			if (rs != null)
				rs.close();
			/*
			 * double HalfMonthlyIncome=0.00; double
			 * DeductionofMonthlysalary=0.00; double Amountreq=0.00; int
			 * Repaymentperiod=0,Holidayperiod=0; double
			 * ProposedLoancommitment=0.00; double LatestDeductions=0.00; double
			 * Totalloancommitment=0.00; double Percentageofloancommitment=0.00;
			 * double Percentagemonthlydeduction=0.00; int tenor_Staff_house=0;
			 * String staff_under=""; if(!strappId.equals("")) {
			 * rs=DBUtils.executeLAPSQuery("pergetIncome1^"+strappId);
			 * if(rs.next()) {
			 * MonthlyIncome=Double.parseDouble(Helper.correctDouble
			 * ((String)rs.getString("perinc_monsalary")));
			 * Monthlydeduction=Double
			 * .parseDouble(Helper.correctDouble((String)rs
			 * .getString("perinc_otherdeduction"))); }
			 * HalfMonthlyIncome=MonthlyIncome/2;
			 * DeductionofMonthlysalary=((Monthlydeduction/MonthlyIncome)100);
			 * if(rs != null) {rs.close();}
			 * rs=DBUtils.executeLAPSQuery("selreqamtandinstall^"
			 * +strApplicationNo); if(rs.next()) {
			 * Amountreq=Double.parseDouble(Helper
			 * .correctDouble((String)rs.getString("loan_recmdamt")));
			 * Repaymentperiod
			 * =Integer.parseInt(Helper.correctInt((String)rs.getString
			 * ("loan_reqterms")));
			 * Holidayperiod=Integer.parseInt(Helper.correctInt
			 * ((String)rs.getString("loan_noofinstallment")));
			 * Repaymentperiod=Repaymentperiod-Holidayperiod; }
			 * ProposedLoancommitment=(Amountreq/Repaymentperiod); strQuery =
			 * SQLParser.getSqlQuery("sel_staffprd^"+strPrdcode); rs
			 * =DBUtils.executeQuery(strQuery); if(rs.next()) {
			 * staff_under=correctNull((String)rs.getString("prd_staffprd"));
			 * if(staff_under.equalsIgnoreCase("Y")){
			 * tenor_Staff_house=Integer.parseInt
			 * (Helper.correctInt((String)rs.getString
			 * ("PRD_STAFF_MAXTERM_PRIN"))); }else{ tenor_Staff_house=1; } }
			 * if(staffproduct
			 * .equalsIgnoreCase("Y")&&(strProductType.equalsIgnoreCase("pH")||
			 * strProductType.equalsIgnoreCase("pA"))) {
			 * tenor_Staff_house=tenor_Staff_house-Holidayperiod;
			 * ProposedLoancommitment=(Amountreq/tenor_Staff_house); }
			 * LatestDeductions=((ProposedLoancommitment/MonthlyIncome)100);
			 * Totalloancommitment=Monthlydeduction+ProposedLoancommitment;
			 * Percentageofloancommitment
			 * =((Totalloancommitment/MonthlyIncome)100);
			 * Percentagemonthlydeduction=((Monthlydeduction/MonthlyIncome)100);
			 * } hshRecord.put("MonthlyIncome" ,nf.format(MonthlyIncome));//a
			 * hshRecord.put("HalfMonthlyIncome"
			 * ,nf.format(HalfMonthlyIncome));//b
			 * hshRecord.put("Monthlydeduction"
			 * ,nf.format(Monthlydeduction));//c
			 * hshRecord.put("Percentagemonthlydeduction"
			 * ,nf.format(Percentagemonthlydeduction));//d
			 * hshRecord.put("ProposedLoancommitment"
			 * ,nf.format(Math.round(ProposedLoancommitment)));//e
			 * hshRecord.put("LatestDeductions"
			 * ,nf.format(LatestDeductions));//f
			 * hshRecord.put("Totalloancommitment"
			 * ,nf.format(Totalloancommitment));//g
			 * hshRecord.put("Percentageofloancommitment"
			 * ,nf.format(Percentageofloancommitment));//h
			 */hshRecord.put("staffproduct", staffproduct);
			hshRecord.put("strProductType", strProductType);
			hshRecord.put("strNewEmployment", strNewEmployment);

			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_allcomments^"
					+ strApplicationNo + "^repaycomment");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("repaycomments", Helper.CLOBToString(rs
						.getClob("fin_comments")));
				hshRecord.put("stagewiserealse",Helper.correctNull((String)rs.getString("FIN_STAGEWISE_RELEASE")));
			}

			// Get Primary Security Comments
			strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
					+ strApplicationNo + "^Retailprimarysec");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cmt_retailprimarycomments", Helper
						.CLOBToString(rs.getClob("cmt_comments")));
			}
			// Get Collateral Security Comments
			strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
					+ strApplicationNo + "^RetailCollateralsec");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cmt_retailcollateralcomments", Helper
						.CLOBToString(rs.getClob("cmt_comments")));
			}

			if (!strAppType.equalsIgnoreCase("Postsanction")) {
				if (strEmpStatus.equalsIgnoreCase("4")) {
					hshFinValues = new HashMap();
					hshFinValues.put("appno", strApplicationNo);
					hshFinValues = dscrobj.getPrintValues(hshFinValues);
					hshRecord.put("DSCRhshFinValues", hshFinValues);

					hshReqValues.put("appno", strApplicationNo);
					hshReqValues.put("hidapplicantid", strappId);
					hshReqValues.put("sessionModuleType", "RET");
					hshFinValues = (HashMap) EJBInvoker.executeStateLess(
							"comproposal", hshReqValues, "getDSS");
					hshRecord.put("hshDSSData", hshFinValues);
				}
			}

			ExecutiveBean exbean = new ExecutiveBean();
			hshFinValues = new HashMap();
			hshFinValues.put("appno", strApplicationNo);
			hshFinValues = exbean.getDelegationData(hshFinValues);
			hshRecord.put("arrDelRow", (ArrayList) hshFinValues.get("arrRow"));
			
			arrRow=new ArrayList();
			ArrayList arrCol = new ArrayList();
			if(rs1!=null){rs1.close();}
			strQuery=SQLParser.getSqlQuery("sel_approvedby_appno^"+strApplicationNo);
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs1.getString("USR_FNAME")));
				arrCol.add(correctNull(rs1.getString("USER_DESIGNATION")));
				arrCol.add(correctNull(rs1.getString("COM_DATE")));
				arrCol.add(correctNull(rs1.getString("COM_DETAILS")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrPropFlow",arrRow);

			if (!strAppType.equalsIgnoreCase("Postsanction")) {
				arrRow = new ArrayList();
				strQuery = SQLParser
						.getSqlQuery("rbiguidelines_restr_processnote^"
								+ strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs
							.getString("restr_rbi_slno")));
					arrCol.add(Helper.correctNull(rs
							.getString("restr_rbi_guidelines")));
					arrCol.add(Helper.correctNull(rs
							.getString("restr_rbi_compliance")));
					arrCol.add(Helper.correctNull(rs
							.getString("restr_rbi_comments")));
					arrCol.add(Helper.correctNull(rs
							.getString("restr_pagetype")));
					arrRow.add(arrCol);
				}

				hshRecord.put("arrRBIGuidliness", arrRow);
			}

			ArrayList arrOutRow = new ArrayList();
			ArrayList arrOutCol = new ArrayList();
			ArrayList arrOutRowPro = new ArrayList();
			ArrayList arrfacwisecol = new ArrayList();
			ArrayList arrOutColPro = new ArrayList();
			int k = 0, j = 0;
			String strSecid = "", strPrdDesc = "";
			if (rs2 != null) {
				rs2.close();
			}

			rs2 = DBUtils.executeLAPSQuery("sel_retProductDesc^" + strPrdcode);

			if (rs2.next()) {
				strPrdDesc = Helper.correctNull(rs2.getString("prd_desc"));
			}
			hshRecord.put("strPrdDesc", strPrdDesc);
			if (rs != null) {
				rs.close();
			}
			k = 0;
			j = 0;
			rs = DBUtils
					.executeLAPSQuery("secExisFacilityDetailsView_facwise_ret^"
							+ strApplicationNo + "^" + "P^A");
			while (rs.next()) {
				arrOutCol = new ArrayList();
				if (correctNull(rs.getString("app_sec_securitytype"))
						.equalsIgnoreCase("1")) {
					if (k == 0) {
						k++;
						arrOutCol.add(strPrdDesc);// 0
						arrOutCol.add("");// 1
						arrOutCol.add(""); // 2
						arrOutCol.add("");// 3
						arrOutRow.add(arrOutCol);
					}
					arrOutCol = new ArrayList();
					arrOutCol.add(correctNull(Helper.CLOBToString(rs
							.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
					arrOutCol.add(correctNull(rs
							.getString("app_sec_securityvalue"))); // 2
					arrOutCol.add(correctNull(rs
							.getString("cus_sec_valuation_date")));// 3
					arrOutCol.add(correctNull(rs.getString("CUS_SEC_ID")));// 4
					if (strSecid.equalsIgnoreCase("")) {
						strSecid = "'"
								+ Helper.correctNull((String) rs
										.getString("CUS_SEC_ID")) + "'";
					} else {
						strSecid = strSecid
								+ ",'"
								+ Helper.correctNull((String) rs
										.getString("CUS_SEC_ID")) + "'";
					}
					arrOutRow.add(arrOutCol);
				}
				if (correctNull(rs.getString("app_sec_securitytype"))
						.equalsIgnoreCase("2")) {
					arrOutCol = new ArrayList();
					arrOutCol.add(correctNull(Helper.CLOBToString(rs
							.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
					arrOutCol.add(correctNull(rs
							.getString("app_sec_securityvalue"))); // 2
					arrOutCol.add(correctNull(rs
							.getString("cus_sec_valuation_date")));// 3
					arrOutCol.add(correctNull(rs.getString("CUS_SEC_ID")));// 4
					if (strSecid.equalsIgnoreCase("")) {
						strSecid = "'"
								+ Helper.correctNull((String) rs
										.getString("CUS_SEC_ID")) + "'";
					} else {
						strSecid = strSecid
								+ ",'"
								+ Helper.correctNull((String) rs
										.getString("CUS_SEC_ID")) + "'";
					}
					arrOutRowPro.add(arrOutCol);
				}
			}
			hshRecord.put("arrRowPri", arrOutRow);
			hshRecord.put("arrRowColl", arrOutRowPro);
			if (strPrdtype.equalsIgnoreCase("OD")
					&& !strProductType.equalsIgnoreCase("pV")) {
				hshRecord.put("WhetherEMI", "No");
				hshRecord.put("strPeriodicity", "Not Applicable");
				// hshRecord.put("loan_noofinstallment","Not Applicable");
			}

			if (rs != null) {
				rs.close();
			}

			arrOutRow = new ArrayList();
			String strCityDesc = "", strStateDesc = "", strDistcode = "", strDistDesc = "", strType = "";
			rs = DBUtils.executeLAPSQuery("comapp_division_details_sel^"
					+ strappId);
			while (rs.next()) {
				String strAadharno = "";
				if (correctNull((String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("O"))
					strType = "Share Holders";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("D"))
					strType = "Directors";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("SP"))
					strType = "Sole Proprietor";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("PT"))
					strType = "Partner";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("OT"))
					strType = "Others";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("K"))
					strType = "Karta";
				else if (correctNull(
						(String) rs.getString("comapp_divisiontype"))
						.equalsIgnoreCase("PA"))
					strType = "Power of Attorney";
				else
					strType = correctNull((String) rs
							.getString("comapp_divisiontype"));

				String DIVISIONSUBTYPE = Helper.correctNull((String) rs
						.getString("COMAPP_DIVISIONSUBTYPE"));

				if ((!DIVISIONSUBTYPE.equals("005"))
						&& (!strType.equals("Others"))) {

					arrOutCol = new ArrayList();
					arrOutCol.add(strType);// 0
					arrOutCol.add(correctNull((String) rs
							.getString("comapp_div_name")));// 1
					arrOutCol.add(correctNull((String) rs
							.getString("comapp_div_address")));// 2
					String strCitycode = Helper.correctNull((String) rs
							.getString("comapp_div_city"));
					if (!strCitycode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						rs1 = DBUtils.executeLAPSQuery("sel_citynamebycode^"
								+ strCitycode);
						if (rs1.next()) {

							strCityDesc = Helper.correctNull((String) rs1
									.getString("city_name"));
						}
					}
					arrOutCol.add(strCityDesc);// 3
					String strStatecode = Helper.correctNull((String) rs
							.getString("comapp_div_state"));
					if (!strStatecode.equalsIgnoreCase("")) {
						if (rs2 != null) {
							rs2.close();
						}
						rs2 = DBUtils.executeLAPSQuery("sel_statenamebycode^"
								+ strStatecode);
						if (rs2.next()) {
							strStateDesc = Helper.correctNull((String) rs2
									.getString("state_name"));
						}
					}
					arrOutCol.add(strStateDesc);// 4
					arrOutCol.add(correctNull((String) rs
							.getString("comapp_div_pin")));// 5
					strDistcode = Helper.correctNull((String) rs
							.getString("comapp_div_dist"));

					if (!strDistcode.equalsIgnoreCase("")) {
						if (rs3 != null) {
							rs3.close();
						}
						rs3 = DBUtils.executeLAPSQuery("sel_distnamebycode^"
								+ strDistcode);
						if (rs3.next()) {

							strDistDesc = Helper.correctNull((String) rs3
									.getString("district_desc"));// 15
						}
					}
					arrOutCol.add(strDistDesc);// 6

					if (!correctNull((String) rs.getString("comapp_div_appid"))
							.equalsIgnoreCase("")) {
						rs3 = DBUtils
								.executeLAPSQuery("selappincomekycdetails^"
										+ correctNull((String) rs
												.getString("comapp_div_appid")));
						if (rs3.next()) {
							arrOutCol.add(Helper.converAmount(nf.format(Double
									.parseDouble(Helper.correctDouble(rs3
											.getString("perinc_yearsalary")))),
									strAmountForm));// 7

							if (rs2 != null) {
								rs2.close();
							}
							strQuery1 = SQLParser
									.getSqlQuery("getstaticdatavaldispcorporatenew^70^"
											+ Helper
													.correctNull(rs3
															.getString("kyc_occupationcode")));
							rs2 = DBUtils.executeQuery(strQuery1);
							if (rs2.next()) {
								arrOutCol.add(Helper.correctNull((String) rs2
										.getString("stat_data_desc1")));// 8
							} else {
								arrOutCol.add("");// 8
							}

							if (rs2 != null) {
								rs2.close();
							}
							strQuery1 = SQLParser
									.getSqlQuery("sel_cbsstaticdescbycode^2^"
											+ Helper
													.correctNull(rs3
															.getString("perapp_constitution")));
							rs2 = DBUtils.executeQuery(strQuery1);
							if (rs2.next()) {
								arrOutCol.add(Helper.correctNull((String) rs2
										.getString("cbs_static_data_desc")));// 9
							} else {
								arrOutCol.add("");// 9
							}
							arrOutCol.add(nf.format(rs3
									.getDouble("perapp_networth")));// 10
							arrOutCol.add(Helper.correctNull(rs3
									.getString("perapp_dob")));// 11
							arrOutCol
									.add(Helper
											.converAmount(
													nf
															.format(Double
																	.parseDouble(Helper
																			.correctDouble(rs3
																					.getString("perinc_year1_income")))),
													strAmountForm));// 12
							arrOutCol.add(Helper.correctNull(rs3
									.getString("perapp_employment")));// 13
							arrOutCol.add(Helper.correctNull(rs3
									.getString("con_mobile")));// 14
							arrOutCol.add(Helper.correctNull(rs3
									.getString("con_email")));// 15
							arrOutCol.add(Helper.correctNull(rs3
									.getString("perapp_panno")));// 16
							strAadharno = Helper.correctNull(rs3
									.getString("perapp_aadhaar"));// 17
						} else {
							arrOutCol.add("");// 7
							arrOutCol.add("");// 8
							arrOutCol.add("");// 9
							arrOutCol.add("");// 10
							arrOutCol.add("");// 11
							arrOutCol.add("");// 12
							arrOutCol.add("");// 13
							arrOutCol.add("");// 14
							arrOutCol.add("");// 15
							arrOutCol.add("");// 16
						}
					} else {
						arrOutCol.add("");// 7
						arrOutCol.add("");// 8
						arrOutCol.add("");// 9
						arrOutCol.add("");// 10
						arrOutCol.add("");// 11
						arrOutCol.add("");// 12
						arrOutCol.add("");// 13
						arrOutCol.add("");// 14
						arrOutCol.add("");// 15
						arrOutCol.add("");// 16
					}

					arrOutCol.add(correctNull((String) rs
							.getString("comapp_div_phone")));// 17
					arrOutCol.add(strAadharno);// 18
					arrOutRow.add(arrOutCol);
				}
			}

			hshRecord.put("arrGroupInfo", arrOutRow);

			if (rs != null)
				rs.close();
			arrOutRow = new ArrayList();
			rs = DBUtils.executeLAPSQuery("pergetapplicantdetails^"
					+ strApplicationNo + "^" + strappId);
			while (rs.next()) {
				arrOutCol = new ArrayList();
				arrOutCol.add(Helper
						.correctNull((rs.getString("perapp_fname"))));
				arrOutCol.add(Helper
						.correctNull((rs.getString("perapp_panno"))));
				arrOutCol.add(Helper.correctNull((rs.getString("con_mobile"))));
				arrOutCol.add(Helper.correctNull((rs.getString("con_email"))));
				arrOutCol.add(Helper.correctNull((rs.getString("demo_type"))));
				arrOutCol.add(Helper.correctNull((rs
						.getString("perapp_aadhaar"))));
				arrOutRow.add(arrOutCol);
			}
			hshRecord.put("arrAppBasicInfo", arrOutRow);

			if (strAppType.equalsIgnoreCase("Postsanction")) {
				if (rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_post_sanction_applications^"
						+ strApplicationNo);
				if (rs.next()) {
					hshRecord.put("strpostsancterms", Helper.correctNull(rs
							.getString("ps_modify_terms")));
				}
			}

			ArrayList arrCoAppLiabRow = new ArrayList();
			strQuery = SQLParser.getSqlQuery("selcoapplicantotherbankfac^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrOthrbnkCol = new ArrayList();
				bankname = Helper.correctNull(rs.getString("perbank_bnkname"));
				if (!(bankname.equalsIgnoreCase(""))) {
					strQuery3 = SQLParser
							.getSqlQuery("selbankname^" + bankname);
					rs3 = DBUtils.executeQuery(strQuery3);
					if (rs3.next()) {
						bankname = Helper.correctNull(rs3
								.getString("stat_data_desc1"));
					}
				}
				arrOthrbnkCol.add(bankname);// 0
				strFactype = Helper.correctNull(rs.getString("perbank_type"));
				if (strFactype.equalsIgnoreCase("1"))
					arrOthrbnkCol.add("Working Capital");// 1
				else if (strFactype.equalsIgnoreCase("2"))
					arrOthrbnkCol.add("Term Loan");// 1
				else
					arrOthrbnkCol.add("");// 1
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_limit")));// 2
				arrOthrbnkCol.add(Helper
						.correctNull(rs.getString("perbank_os")));// 3
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_intrate")));// 4
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_monthly_ins")));// 5
				arrOthrbnkCol.add(Helper.correctNull(rs
						.getString("perbank_duedate")));// 6
				arrOthrbnkCol.add(Helper.replaceForJavaScriptString(Helper
						.CLOBToString(rs.getClob("perbank_arrears"))));// 7
				arrCoAppLiabRow.add(arrOthrbnkCol);
			}
			hshRecord.put("arrCoAppLiabRow", arrCoAppLiabRow);

			// To get the inward proposed amount
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("INWARD_TERMLOANAMT", Helper
						.correctDouble((String) rs
								.getString("INWARD_TERMLOANAMT")));
				if (Helper.correctDouble(
						(String) rs.getString("INWARD_SCHEMEDESC"))
						.equalsIgnoreCase("t"))
					hshRecord.put("INWARD_SCHEMEDESC", "Term Loan");
				else if (Helper.correctDouble(
						(String) rs.getString("INWARD_SCHEMEDESC"))
						.equalsIgnoreCase("d"))
					hshRecord.put("INWARD_SCHEMEDESC", "DPN");
				else if (Helper.correctDouble(
						(String) rs.getString("INWARD_SCHEMEDESC"))
						.equalsIgnoreCase("o"))
					hshRecord.put("INWARD_SCHEMEDESC", "Overdraft");
			}
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_vehsecuritydetails^"
					+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if (Helper.correctNull(rs.getString("app_sec_securitytype"))
						.equalsIgnoreCase("1"))
					hshRecord.put("strVehSecType", "Prime");
				else
					hshRecord.put("strVehSecType", "Collateral");
			}

			if (rs != null) {
				rs.close();
			}
			arrRow = new ArrayList();
			rs = DBUtils.executeLAPSQuery("selgolddetails^" + strApplicationNo);
			double dbESTRATE = 0.00;
			double dbESTRATE1 = 0.00;
			double dbNetWeight = 0.00;
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("AGR_ARTCATID")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTNO")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTDESC")));
				arrCol
						.add(correctNull((String) rs
								.getString("AGR_ARTGROSSWT")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
				arrCol
						.add(correctNull((String) rs
								.getString("AGR_ARTQTYTOUCH")));
				arrCol
						.add(correctNull((String) rs
								.getString("AGR_ARTMKTRATE")));
				arrCol.add(correctNull((String) rs.getString("AGR_ARTRATE")));
				arrCol.add(correctNull((String) rs.getString("AGR_ESTRATE")));
				arrCol.add(correctNull((String) rs.getString("agr_quantity")));
				arrCol.add(correctNull((String) rs.getString("AGR_BANKVALUE")));
				arrCol.add(correctNull((String) rs.getString("agr_grsno")));
				arrCol.add(correctNull((String) rs.getString("agr_secid")));
				arrCol
						.add(correctNull((String) rs
								.getString("agr_articletype")));
				arrCol.add(correctNull((String) rs.getString("agr_netvalue")));
				dbESTRATE = Double.parseDouble(Helper.correctDouble((String) rs
						.getString("AGR_ESTRATE")));
				dbESTRATE1 = dbESTRATE1 + dbESTRATE;
				dbNetWeight = dbNetWeight
						+ Double.parseDouble(Helper.correctDouble((String) rs
								.getString("AGR_ARTNETWT")));
				arrRow.add(arrCol);
			}

			hshRecord.put("arrGoldRow", arrRow);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_appraiserdet^"
					+ strApplicationNo);
			if (rs.next()) {
				hshRecord.put("strAppraiserName", Helper.correctNull(rs
						.getString("ja_name")));
				hshRecord.put("strAppraisalDoneon", Helper.correctNull(rs
						.getString("ja_appraiseon")));
				hshRecord.put("strAppraiserComments", Helper.CLOBToString(rs
						.getClob("ja_comments")));
			}

			String strAgriType = "", strLoanType = "";
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selectagriassessment^"
					+ strApplicationNo);
			if (rs.next()) {
				strAgriType = Helper
						.correctNull(rs.getString("agr_typeofagri"));
				strLoanType = Helper
						.correctNull(rs.getString("agr_typeofloan"));
				hshRecord.put("strAgriType", strAgriType);
				hshRecord.put("strAgriLoanType", strLoanType);
				hshRecord.put("strAgriTotalAmt", Helper.correctDouble(rs
						.getString("agr_totalamt")));
				hshRecord.put("strAgriMarginVal", Helper.correctDouble(rs
						.getString("agr_margin_amt")));
				hshRecord.put("strAgriEligAmt", Helper.correctDouble(rs
						.getString("agr_eligible_amt")));
			}
			arrRow = new ArrayList();
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selagriassessmentvalues^"
					+ strApplicationNo + "^" + strAgriType + "^" + strLoanType);
			while (rs.next()) {
				if (!(Helper.correctNull(rs.getString("agr_activity"))
						.equalsIgnoreCase("") && Double.parseDouble(Helper
						.correctDouble(rs.getString("agr_unitcost"))) == 0)) {
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("agr_sno")));
					arrCol.add(Helper.correctDouble(rs.getString("agr_area")));
					arrCol
							.add(Helper.correctNull(rs
									.getString("agr_activity")));
					arrCol.add(Helper.correctDouble(rs
							.getString("agr_unitcost")));
					arrCol.add(Helper.correctDouble(rs
							.getString("agr_totalamt")));
					arrRow.add(arrCol);
				}
			}
			hshRecord.put("arrGoldAgri", arrRow);

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selgoldratemaster^Y");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("dblRecurrexpMargin", Helper
						.formatDoubleValue(100 - rs
								.getDouble("grm_recurrexpmargin")));
			}

			arrRow = new ArrayList();
			ArrayList arrDepdetCol = new ArrayList();
			ArrayList arrDepdet = new ArrayList();
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("sel_loanagainstdeposit^"
					+ strApplicationNo);
			while (rs.next()) {

				arrDepdetCol = new ArrayList();
				String strOrgName = "";
				arrDepdetCol.add(Helper.correctNull(rs.getString(1)));
				String strOrgCode1 = Helper.correctNull(rs.getString(2));
				if (!strOrgCode1.equalsIgnoreCase("")) {
					strQuery1 = SQLParser.getSqlQuery("selectorgname^"
							+ strOrgCode1);
					rs2 = DBUtils.executeQuery(strQuery1);
					if (rs2.next()) {
						strOrgName = Helper.correctNull(rs2
								.getString("org_name"));
					}
				}
				arrDepdetCol.add(strOrgName);
				arrDepdetCol.add(Helper.correctNull(rs.getString(3)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(4)));

				String date1 = Helper.correctNull(rs.getString(5));
				if (date1.equalsIgnoreCase("01/01/1900")) {
					date1 = "";
				}
				arrDepdetCol.add(date1);
				arrDepdetCol.add(Helper.correctNull(rs.getString(6)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(7)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(8)));
				date1 = Helper.correctNull(rs.getString(9));
				if (date1.equalsIgnoreCase("01/01/1900")) {
					date1 = "";
				}
				arrDepdetCol.add(date1);
				arrDepdetCol.add(Helper.correctNull(rs.getString(10)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(11)));
				date1 = Helper.correctNull(rs.getString(12));
				if (date1.equalsIgnoreCase("01/01/1900")) {
					date1 = "";
				}
				arrDepdetCol.add(date1);
				arrDepdetCol.add(Helper.correctNull(rs.getString(13)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(14)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(15)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(16)));
				arrDepdetCol.add(Helper.correctNull(rs.getString(17)));
				arrDepdet.add(arrDepdetCol);
			}
			hshRecord.put("arrDepdet", arrDepdet);
			log.info("<<<<<<<<<<<=============arrDepdet=============>>>>>>>>>>>>>>"+arrDepdet);
			// start=========
			if (rs != null) {
				rs.close();
			}
			ArrayList arrdefCol = new ArrayList();
			ArrayList arrdefRow = new ArrayList();
			String strDemo = "", strDemo1 = "";
			String str_aplnt_fname = "", strCategory_1 = "",strCategory_2 = "",strCategory_3 = "";
			strQuery = SQLParser.getSqlQuery("sel_defaulter_list_note^"+ strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrdefCol = new ArrayList();
				arrdefCol.add(Helper.correctNull((String) rs.getString("name"))); // 0
				strDemo = Helper.correctNull((String) rs.getString("demotype"));
				if (strDemo.equalsIgnoreCase("a")) {
					strDemo1 = "Applicant";
				} else if (strDemo.equalsIgnoreCase("c")) {
					strDemo1 = "Joint Applicant";
				} else if (strDemo.equalsIgnoreCase("g")) {
					strDemo1 = "Guarantor";
				} else if (strDemo.equalsIgnoreCase("o")) {
					strDemo1 = "Co-Obligant";
				} else {
					strDemo1 = "";
				}
				arrdefCol.add(strDemo1); // 1
				if (correctNull(rs.getString("DEF_RBIDEFIS")).trim().equalsIgnoreCase("Y")) {
					strCategory_1 = "Yes";

				} else {
					strCategory_1 = "No";
				}
				arrdefCol.add(Helper.correctNull(strCategory_1));// 2
				arrdefCol.add(Helper.correctNull((String) rs.getString("ASONRBIDATE"))); // 3
				arrdefCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_RBIDEFCOMM")))); // 4

				if (correctNull(rs.getString("DEF_ECGSEPIS")).trim().equalsIgnoreCase("Y")) {
					strCategory_2 = "Yes";

				} else {
					strCategory_2 = "No";
				}
				arrdefCol.add(Helper.correctNull(strCategory_2));// 5
				arrdefCol.add(Helper.correctNull((String) rs.getString("asonECGCIdate"))); // 6
				arrdefCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_ECGSEPCOMM")))); // 7
				
				if (correctNull(rs.getString("DEF_SUITFILED")).trim().equalsIgnoreCase("Y")) {
					strCategory_3 = "Yes";

				} else {
					strCategory_3 = "No";
				}
				arrdefCol.add(Helper.correctNull(strCategory_3));// 8
				arrdefCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("DEF_SUITFILEDCOMM")))); // 9

				arrdefRow.add(arrdefCol);
			}
			hshRecord.put("arrdefRow", arrdefRow);
			//end==================
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("selborrowerdet_company^"
					+ strappId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if (Helper.correctNull(
						(String) rs.getString("cominfo_ownership_type"))
						.equalsIgnoreCase("004")) {
					hshRecord.put("companyinfo_typeofliability",
							correctNull(Helper.CLOBToString(rs
									.getClob("companyinfo_typeofliability"))));
				}
			}

			if (rs != null)
				rs.close();

			java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);

			strQuery = SQLParser.getSqlQuery("sel_per_bir^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			String bir_flag = "";
			if (rs.next()) {
				hshRecord.put("bir_flag", Helper.correctNull(rs
						.getString("bir_flag")));
				bir_flag = Helper.correctNull(rs.getString("bir_flag"));

				if (Helper.correctNull((String) rs.getString("bir_flag"))
						.equalsIgnoreCase("Y")) {

					hshRecord.put("bir_flag1", "Yes");
					hshRecord.put("bir_submitteddate", Helper.correctNull(rs
							.getString("bir_submitteddate")));
					hshRecord.put("bir_receiptdate", Helper.correctNull(rs
							.getString("bir_receiptdate")));
					hshRecord.put("bir_charges", jtn.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("bir_charges")))));
					hshRecord.put("bir_comments", Helper.correctNull(rs
							.getString("bir_comments")));
					hshRecord.put("bir_processdate", Helper.correctNull(rs
							.getString("bir_processdate")));
					hshRecord.put("bir_service_name", Helper.correctNull(rs
							.getString("bir_service_name")));
					
					rs2=DBUtils.executeLAPSQuery("selmiscust^250^"+Helper.correctNull((String)rs.getString("bir_quality_report")));
					if(rs2.next())
					{	
						hshRecord.put("bir_quality_report", Helper.correctNull(rs2.getString("stat_data_desc1")));

					}
					if(rs2!=null){
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("selmiscust^251^"+Helper.correctNull((String)rs.getString("bir_opinion_all")));
					if(rs2.next())
					{	
						hshRecord.put("bir_opinion_all", Helper.correctNull(rs2.getString("stat_data_desc1")));

					}
				} else {
					hshRecord.put("bir_flag1", "No");
					hshRecord.put("bir_comments", Helper.correctNull(rs
							.getString("bir_comments")));
				}

			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_product_subcatdesc^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("prd_subcatscheme",Helper.correctNull(rs.getString("CAT_NAME")));
			}
			
		ArrayList	arrRow1 = new ArrayList();
			 strQuery1="";
			strQuery1 = SQLParser.getSqlQuery("sel_retappdetails^" + strApplicationNo);
			rs=DBUtils.executeQuery(strQuery1); 

			while(rs.next()) {
				ArrayList arrCol1 = new ArrayList();
				 
				arrCol1.add(Helper.correctNull((String) rs
						.getString("DEMO_APPID")));
				arrCol1.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrCol1.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
				arrRow1.add(arrCol1);
			}
			
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("arrRow",arrRow1);
			
			//CheckList Details
			arrRow1=new ArrayList();
			strQuery1 = SQLParser.getSqlQuery("sel_appraisalQuest^" + strApplicationNo+"^"+strPrdcode);
			rs=DBUtils.executeQuery(strQuery1); 

			while(rs.next()) {
				ArrayList arrCol1 = new ArrayList();
				 
				arrCol1.add(Helper.correctNull((String) rs
						.getString("GENE_QUESTION")));
				if(Helper.correctNull(rs.getString("ques_flag")).equalsIgnoreCase("1"))
					arrCol1.add("Yes");
				else if(Helper.correctNull(rs.getString("ques_flag")).equalsIgnoreCase("2"))
					arrCol1.add("No");
				else if(Helper.correctNull(rs.getString("ques_flag")).equalsIgnoreCase("3"))
					arrCol1.add("Not Applicable");
				else
					arrCol1.add("");
				arrCol1.add(Helper.correctNull((String) rs
						.getString("Remarks")));
				arrRow1.add(arrCol1);
			}
			
			if (rs != null) {
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
			}
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_devrefno^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			String strdevType="";
			while(rs.next())
			{ 
				strdevType=correctNull(rs.getString("DEVIATION_TYPE"));
				if(strdevType.equalsIgnoreCase("IRRN")){
					hshRecord.put("com_interest_refno",correctNull(rs.getString("deviation_remarks")));
				}
			}	
			  String strUser="",strUserdesig="";
			     strQuery=SQLParser.getSqlQuery("sel_delegation^"+strApplicationNo);
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("COM_APPNO"))); //0
						strUser=correctNull(rs.getString("COM_USERID"));
						arrCol.add(strUser);//1
						strUserdesig=correctNull(rs.getString("COM_USERDES"));
						arrCol.add(strUserdesig);//2
						arrCol.add(correctNull(rs.getString("COM_SNO")));//3
						
						if(Helper.isNumeric(strUserdesig))
						{
							strQuery = SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^"+"27^"+strUserdesig);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								arrCol.add(Helper.correctNull((String)rs1.getString("CBS_STATIC_DATA_DESC")));//13
							}
							else{
								arrCol.add(strUserdesig);
							}
						}
						else
						{
							if(strUserdesig.equals("adm"))	
							{
								arrCol.add("Administrator");
							}
							else if(strUserdesig.equals("999"))	
							{
								arrCol.add("DGM Admin");
							}
							else if(strUserdesig.equals("001"))	
							{
								arrCol.add("Officer");
							}
							else if(strUserdesig.equals("002"))	
							{
								arrCol.add("General Manager");
							}
							else if(strUserdesig.equals("003"))	
							{
								arrCol.add("Chief Manager");
							}
							else
							{
								arrCol.add(strUserdesig);
							}
						}
						arrCol.add(correctNull(rs.getString("COM_USER")));//5
						strQuery = SQLParser.getSqlQuery("setusername_byuserid^"+correctNull(rs.getString("COM_USER")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							arrCol.add(Helper.correctNull((String)rs1.getString("usrname")));//13
						}
						else{
							arrCol.add("");
						}
						arrCol.add(correctNull(rs.getString("COM_DETAILS")));
						arrCol.add(correctNull(rs.getString("COM_DATE")));

						arrRow.add(arrCol);	
					}
					hshRecord.put("arrRowprop",arrRow);

			hshRecord.put("arrCHRow",arrRow1);

			//Sunil
			String ApplicantName="",strBranchRec="",strHeadOfficeRec="";
			ArrayList arrcol=new ArrayList();
			rs = DBUtils.executeLAPSQuery("sel_appl_cibildetails^" + strApplicationNo);
			String	 strAmberRules="",strName="", strTotName="",strTotAmber="";
			ArrayList arrName=new ArrayList();
			ArrayList arrcolNAme=new ArrayList();
			while(rs.next())
			{
				
			strAmberRules="";
			String strAMBERRULES=Helper.correctNull((String)rs.getString("DEMO_DIGI_AMBERRULES"));
			
			if(!strAMBERRULES.equals(""))
			{
			String[] strarrAmberRules=strAMBERRULES.split("@");
			
			
			int amberlength=strarrAmberRules.length;
			if(amberlength>0)
			{
				String ambName="";
				for(int i=0;i<amberlength;i++)
				{
					
					if (rs1 != null) 
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^" + "232"+"^"+strarrAmberRules[i]);
					if(rs1.next())
					{
						ambName=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
						strAmberRules=strAmberRules+" @ "+ambName+" ";				
					}
				}
				strTotAmber=strTotAmber+strAmberRules+",";
				strName=Helper.correctNull((String)rs.getString("fname"));
				String demoType=Helper.correctNull((String)rs.getString("DEMO_TYPE"));
				
				if(demoType.equalsIgnoreCase("a"))
					strName="Applicant - "+strName;				
				else 
					strName="CoApplicant - "+strName;
				
				strTotName=strTotName+strName+" , ";			
			}
			}
			
			if(!Helper.correctNull((String)rs.getString("PERAPP_ID")).equalsIgnoreCase(""))
			{
				rs1 = DBUtils.executeLAPSQuery("sel_verifydocument^" + strApplicationNo+"^"+Helper.correctNull((String)rs.getString("PERAPP_ID")));
				if(rs1.next())
				{
				
					strBranchRec=Helper.correctNull((String)rs1.getString("VERI_BRANCH_RECOMMEND"));
					strHeadOfficeRec=Helper.correctNull((String)rs1.getString("VERI_HO_RECOMMEND"));
				}
			
			}
			
			}
			String strcrtsales="";
			strQuery=SQLParser.getSqlQuery("sel_cusdetails^"+strappId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("PERAPP_UDYAM_REGNO",Helper.correctNull(rs.getString("PERAPP_UDYAM_REGNO")));
				hshRecord.put("PERAPP_SALES_TURNOVER",Helper.correctNull(rs.getString("PERAPP_SALES_TURNOVER")));
				hshRecord.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull(rs.getString("PERAPP_SALES_TURNOVER_DATE")));
				strcrtsales=Helper.correctNull((String)rs.getString("PERAPP_CRITERIA_SALES_TURNOVER"));
				hshRecord.put("PERAPP_CERTIFICATION_DATE",Helper.correctNull((String)rs.getString("PERAPP_CERTIFICATION_DATE")));
				rs2=DBUtils.executeLAPSQuery("selmiscust^249^"+Helper.correctNull((String)rs.getString("PERAPP_MSME_CLASSIFICATION")));
				if(rs2.next())
				{	
					hshRecord.put("PERAPP_MSME_CLASSIFICATION", Helper.correctNull(rs2.getString("stat_data_desc1")));

				}
			}
			
			
			strQuery=SQLParser.getSqlQuery("selmiscust^243^"+strcrtsales);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				hshRecord.put("strcrtsales",correctNull((String)rs.getString("STAT_DATA_DESC1")));						
			}
			if(rs!=null){
				rs.close();
			}
			String strreason="",streligdigi="";
			rs1=DBUtils.executeLAPSQuery("sel_app_creditsales^"+strApplicationNo);
			if (rs1.next()) 
			{
				hshRecord.put("APP_DIGIAPPNO", Helper.correctNull(rs1.getString("APP_DIGIAPPNO")));	
				hshRecord.put("APP_ELIGCRITERIA", Helper.correctNull(rs1.getString("APP_ELIGCRITERIA")));	
				hshRecord.put("APP_REASON", Helper.correctNull(rs1.getString("APP_REASON")));	
				hshRecord.put("APP_OTHERREASON", Helper.correctNull(rs1.getString("APP_OTHERREASON")));
				hshRecord.put("APP_COMMENTS", correctNull(Helper.CLOBToString(rs1
						.getClob("APP_COMMENTS"))));
			
				strreason=Helper.correctNull((String)rs1.getString("APP_REASON"));
				streligdigi=Helper.correctNull((String)rs1.getString("APP_ELIGCRITERIA"));
				if(streligdigi.equalsIgnoreCase("Y")){
					streligdigi="Yes";
				}else if(streligdigi.equalsIgnoreCase("N")){
					streligdigi="No";
				}else{
					streligdigi="";
				}
			}
			hshRecord.put("streligdigi",streligdigi);
			hshRecord.put("strreason",strreason);	
			if(rs1!=null){
				rs1.close();
			}
			if(streligdigi.equalsIgnoreCase("Yes")){
			strQuery=SQLParser.getSqlQuery("selCreditSaleReason^245^"+strreason);
			rs1=DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{				
				hshRecord.put("STAT_DATA_DESC",correctNull((String)rs1.getString("STAT_DATA_DESC1")));
				hshRecord.put("otherreason",correctNull((String)rs1.getString("STAT_DATA_DESC")));						
				hshRecord.put("commentreason",correctNull((String)rs1.getString("STAT_DATA_DESC")));						

			}

			}
			if(rs1!=null){
				rs1.close();
			}
			if(streligdigi.equalsIgnoreCase("No")){
				strQuery=SQLParser.getSqlQuery("selCreditSaleReason^246^"+strreason);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{				
					hshRecord.put("STAT_DATA_DESC",correctNull((String)rs1.getString("STAT_DATA_DESC1")));	
					hshRecord.put("otherreason",correctNull((String)rs1.getString("STAT_DATA_DESC")));						
				}
			}
			
			hshRecord.put("strBranchRec",strBranchRec);
			hshRecord.put("strHeadOfficeRec",strHeadOfficeRec);
			
			hshRecord.put("arrcol",strTotAmber);
			hshRecord.put("arrName",strTotName);
			
			
			//
			strQuery=SQLParser.getSqlQuery("sel_doc_branchdet^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				hshRecord.put("DIGI_DEVIATION_ROI_CONC",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_CONC")));	
				hshRecord.put("DIGI_DEVIATION_ROI_PENALTY",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_PENALTY")));
			}
			if(rs!=null){
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_retailmisdetails^"+strApplicationNo+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				hshRecord.put("app_plantval",correctNull((String)rs.getString("app_plantval")));	
				hshRecord.put("app_indname",correctNull((String)rs.getString("app_indname")));
				rs1=DBUtils.executeLAPSQuery("sel_guarantee^"+"12"+"^"+Helper.correctNull((String)rs.getString("APP_AGRICULTURE")));
				if(rs1.next())
				{
					hshRecord.put("mis_static_data_desc",Helper.correctNull((String)rs1.getString("mis_static_data_desc")));					
				}
				hshRecord.put("APP_INVESTMENT_DATE",correctNull((String)rs.getString("APP_INVESTMENT_DATE")));
				strQuery=SQLParser.getSqlQuery("selmiscust^248^"+correctNull((String)rs.getString("APP_CRITERIA_INVESTMENT")));
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{				
					hshRecord.put("APP_CRITERIA_INVESTMENT",correctNull((String)rs.getString("STAT_DATA_DESC1")));						
				}
				
			}
	if(rs!=null){
		rs.close();
	}
	String strrestscheme="";
	strQuery=SQLParser.getSqlQuery("sel_ret_rest_processnote^"+strApplicationNo);
	rs=DBUtils.executeQuery(strQuery);
	if(rs.next())
	{				
		hshRecord.put("APP_RENEW_FLAG",correctNull((String)rs.getString("APP_RENEW_FLAG")));	
		hshRecord.put("LOAN_RESTR_SCHEME",correctNull((String)rs.getString("LOAN_RESTR_SCHEME")));
		strrestscheme=correctNull((String)rs.getString("LOAN_RESTR_SCHEME"));
	}
	if(!strrestscheme.equalsIgnoreCase(""))
	{
	rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"154"+"^"+strrestscheme);
	if(rs1.next())
	{
		strrestscheme=Helper.correctNull(rs1.getString("stat_data_desc1"));
	}
	else
	{
		strrestscheme="";
	}
	}
	else
	{
		strrestscheme="";
	}
	hshRecord.put("strrestscheme", strrestscheme);
	
	 if(rs!=null)
    	 rs.close();
     
     ArrayList arrOutCersaiQuesCol = new ArrayList();
     ArrayList arrOutCersaiQuesRow = new ArrayList();

     strQuery1 = SQLParser.getSqlQuery("secExisFacilityDetailsView_existing_cersai_Ques^"+strApplicationNo);	 
     rs = DBUtils.executeQuery(strQuery1);
     while(rs.next())
     {
    	 arrOutCersaiQuesCol= new ArrayList();
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("cus_sec_type")));// 1
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_ALREADY_MORTG")));// 2
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_CHARG_REFLECT")));// 3
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_OTHERBNK_REMARK")));//4
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_REMARK_NOT_REFLECT")));// 5
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_PROP_OBSERVED")));// 6
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_REMARKS")));// 7
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("cus_sec_id")));// 8
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_CERSAI_ID")));// 9
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_CERSAIREFNO")));// 10	        	 
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_SEARCHPERFORM_DATE")));// 11
    	 arrOutCersaiQuesCol.add(correctNull(rs.getString("SEC_CERSAI_DATE")));// 12

		arrOutCersaiQuesRow.add(arrOutCersaiQuesCol);
	 }
     
     hshRecord.put("arrOutCersaiQues", arrOutCersaiQuesRow);
     if(rs!=null){
			rs.close();
		}
		String retrestructureval="N";
		strQuery = SQLParser.getSqlQuery("sel_ret_tab_validation^"+strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()){
			retrestructureval="Y";
		}
     if(rs!=null)
    	 rs.close();
     strQuery=SQLParser.getSqlQuery("getlreq^"+strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()) 
		{
			hshRecord.put("GOVT_SCHEME", Helper.correctNull(rs.getString("GOVT_SCHEME")));
			hshRecord.put("LOAN_GOVT", Helper.correctNull(rs.getString("LOAN_GOVT")));
		}
		if(rs!=null){
			rs.close();
		}
		   hshRecord.put("retrestructureval", retrestructureval);
			rs=DBUtils.executeLAPSQuery("sel_rest_Assesment^"+strApplicationNo);
			if (rs.next()) 
			{
				hshRecord.put("COM_APPNO", Helper.correctNull(rs.getString("COM_APPNO")));	
				hshRecord.put("COM_TYPE_OF_BORROWER", Helper.correctNull(rs.getString("COM_TYPE_OF_BORROWER")));	
				strborrower=Helper.correctNull(rs.getString("COM_TYPE_OF_BORROWER"));
				hshRecord.put("COM_PURPOSE_OF_LOAN", Helper.correctNull(rs.getString("COM_PURPOSE_OF_LOAN")));
				strpurposeloan=Helper.correctNull(rs.getString("COM_PURPOSE_OF_LOAN"));
				hshRecord.put("COM_AGRI_ALLIED", Helper.correctNull(rs.getString("COM_AGRI_ALLIED")));
				stragriallied=Helper.correctNull(rs.getString("COM_AGRI_ALLIED"));
				hshRecord.put("COM_PERM_ACT", Helper.correctNull(rs.getString("COM_PERM_ACT")));
				strpermact=Helper.correctNull(rs.getString("COM_PERM_ACT"));
				hshRecord.put("COM_PERM_ACT_ELIGIBLE", Helper.correctNull(rs.getString("COM_PERM_ACT_ELIGIBLE")));	
				strpermactelig=Helper.correctNull(rs.getString("COM_PERM_ACT_ELIGIBLE"));
				if(strpermactelig.equalsIgnoreCase("Y")){
					strpermactelig="Yes";
				}else if(strpermactelig.equalsIgnoreCase("N")){
					strpermactelig="No";
				}else{
					strpermactelig="";
				}
				hshRecord.put("strpermactelig", strpermactelig);	
				hshRecord.put("COM_EXPOSUE", Helper.correctNull(rs.getString("COM_EXPOSUE")));	
				hshRecord.put("COM_EXPOSUE_ELIGIBLE", Helper.correctNull(rs.getString("COM_EXPOSUE_ELIGIBLE")));
				strexposueelig=Helper.correctNull(rs.getString("COM_EXPOSUE_ELIGIBLE"));
				if(strexposueelig.equalsIgnoreCase("Y")){
					strexposueelig="Yes";
				}else if(strexposueelig.equalsIgnoreCase("N")){
					strexposueelig="No";
				}else{
					strexposueelig="";
				}
				hshRecord.put("strexposueelig", strexposueelig);
				hshRecord.put("COM_BRW_AVAILED", Helper.correctNull(rs.getString("COM_BRW_AVAILED")));
				strborroweravailed=Helper.correctNull(rs.getString("COM_BRW_AVAILED"));
				if(strborroweravailed.equalsIgnoreCase("Y")){
					strborroweravailed="Yes";
				}else if(strborroweravailed.equalsIgnoreCase("N")){
					strborroweravailed="No";
				}else{
					strborroweravailed="";
				}
				hshRecord.put("strborroweravailed", strborroweravailed);
				hshRecord.put("COM_BRW_AVAILED_ELIGIBIE",Helper.correctNull(rs.getString("COM_BRW_AVAILED_ELIGIBIE")));
				strborroweravailedelig=Helper.correctNull(rs.getString("COM_BRW_AVAILED_ELIGIBIE"));
				if(strborroweravailedelig.equalsIgnoreCase("Y")){
					strborroweravailedelig="Yes";
				}else if(strborroweravailedelig.equalsIgnoreCase("N")){
					strborroweravailedelig="No";
				}else{
					strborroweravailedelig="";
				}
				hshRecord.put("strborroweravailedelig", strborroweravailedelig);
				hshRecord.put("COM_PRESENT_MOROTORIUM", Helper.correctNull(rs.getString("COM_PRESENT_MOROTORIUM")));	
				hshRecord.put("COM_PREVIOUS_MOROTORIUM", Helper.correctNull(rs.getString("COM_PREVIOUS_MOROTORIUM")));	
				hshRecord.put("COM_EXTENDED_DATE", Helper.correctNull(rs.getString("COM_EXTENDED_DATE")));
				hshRecord.put("COM_GST_NUMBER", Helper.correctNull(rs.getString("COM_GST_NUMBER")));
				hshRecord.put("COM_MSME_REST_SCHEME", Helper.correctNull(rs.getString("COM_MSME_REST_SCHEME")));
				strmsmerestscheme= Helper.correctNull(rs.getString("COM_MSME_REST_SCHEME"));
				if(strmsmerestscheme.equalsIgnoreCase("Y")){
					strmsmerestscheme="Yes";
				}else if(strmsmerestscheme.equalsIgnoreCase("N")){
					strmsmerestscheme="No";
				}else{
					strmsmerestscheme="";
				}
				hshRecord.put("strmsmerestscheme", strmsmerestscheme);
				
				hshRecord.put("COM_MSME_RESTR_SCHEME_ELIG", Helper.correctNull(rs.getString("COM_MSME_RESTR_SCHEME_ELIG")));	
				strmsmerestschemeelig= Helper.correctNull(rs.getString("COM_MSME_RESTR_SCHEME_ELIG"));
				if(strmsmerestschemeelig.equalsIgnoreCase("Y")){
					strmsmerestschemeelig="Yes";
				}else if(strmsmerestschemeelig.equalsIgnoreCase("N")){
					strmsmerestschemeelig="No";
				}else{
					strmsmerestschemeelig="";
				}
				hshRecord.put("strmsmerestschemeelig", strmsmerestschemeelig);
				
				hshRecord.put("COM_RESOL_FW", Helper.correctNull(rs.getString("COM_RESOL_FW")));
				
				strframework= Helper.correctNull(rs.getString("COM_RESOL_FW"));
				if(strframework.equalsIgnoreCase("Y")){
					strframework="Yes";
				}else if(strframework.equalsIgnoreCase("N")){
					strframework="No";
				}else{
					strframework="";
				}
				hshRecord.put("strframework", strframework);
				hshRecord.put("COM_RESOL_FW_ELIGIBLE", Helper.correctNull(rs.getString("COM_RESOL_FW_ELIGIBLE")));
				
				strframeworkelig= Helper.correctNull(rs.getString("COM_RESOL_FW_ELIGIBLE"));
				if(strframeworkelig.equalsIgnoreCase("Y")){
					strframeworkelig="Yes";
				}else if(strframeworkelig.equalsIgnoreCase("N")){
					strframeworkelig="No";
				}else{
					strframeworkelig="";
				}
				hshRecord.put("strframeworkelig", strframeworkelig);
				hshRecord.put("COM_OTHER_LOAN", Helper.correctNull(rs.getString("COM_OTHER_LOAN")));
				
			String 	strrestallied= Helper.correctNull(rs.getString("COM_RESTRUCTURE_ALLIED"));
				if(strrestallied.equalsIgnoreCase("Y")){
					strrestallied="Yes";
				}else if(strrestallied.equalsIgnoreCase("N")){
					strrestallied="No";
				}else{
					strrestallied="";
				}
				hshRecord.put("strrestallied", strrestallied);
				
		 String	strrestalliedelig= Helper.correctNull(rs.getString("COM_REST_ALLIED_ELIGIBLE"));
				if(strrestalliedelig.equalsIgnoreCase("Y")){
					strrestalliedelig="Yes";
				}else if(strrestalliedelig.equalsIgnoreCase("N")){
					strrestalliedelig="No";
				}else{
					strrestalliedelig="";
				}
				hshRecord.put("strrestalliedelig", strrestalliedelig);
				
				hshRecord.put("COM_RESTRUCTURE_ALLIED", Helper.correctNull(rs.getString("COM_RESTRUCTURE_ALLIED")));
				hshRecord.put("COM_REST_ALLIED_ELIGIBLE", Helper.correctNull(rs.getString("COM_REST_ALLIED_ELIGIBLE")));
			}
			if (rs != null) {
				rs.close();
			}
			if(rs1!=null){
				rs1.close();
			}
			if(!strborrower.equalsIgnoreCase(""))
			{
			rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"260"+"^"+strborrower);
			if(rs1.next())
			{
				strborrower=Helper.correctNull(rs1.getString("stat_data_desc1"));
			}
			else
			{
				strborrower="";
			}
			}
			else
			{
				strborrower="";
			}
			hshRecord.put("strborrower", strborrower);
			if(rs1!=null){
				rs1.close();
			}
			if(!strpurposeloan.equalsIgnoreCase(""))
			{
			rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"261"+"^"+strpurposeloan);
			if(rs1.next())
			{
				strpurposeloan=Helper.correctNull(rs1.getString("stat_data_desc1"));
			}
			else
			{
				strpurposeloan="";
			}
			}
			else
			{
				strpurposeloan="";
			}
			hshRecord.put("strpurposeloan", strpurposeloan);
			
			
			if(rs1!=null){
				rs1.close();
			}
			if(!stragriallied.equalsIgnoreCase(""))
			{
			rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"262"+"^"+stragriallied);
			if(rs1.next())
			{
				stragriallied=Helper.correctNull(rs1.getString("stat_data_desc1"));
			}
			else
			{
				stragriallied="";
			}
			}
			else
			{
				stragriallied="";
			}
			hshRecord.put("stragriallied", stragriallied);
			
			if(rs1!=null){
				rs1.close();
			}
			if(!strpermact.equalsIgnoreCase(""))
			{
			rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"263"+"^"+strpermact);
			if(rs1.next())
			{
				strpermact=Helper.correctNull(rs1.getString("stat_data_desc1"));
			}
			else
			{
				strpermact="";
			}
			}
			else
			{
				strpermact="";
			}
			hshRecord.put("strpermact", strpermact);
			if(rs1!=null){
				rs1.close();
			}
				
				rs1 = DBUtils.executeLAPSQuery("sel_common_customer^"+ strappId);
				if(rs1.next())
				{
					hshRecord.put("COMINFO_GSTIN", correctNull(rs1.getString("COMINFO_GSTIN")));
					strgstnumber=correctNull(rs1.getString("COMINFO_GSTIN"));
					srwhethergstn=correctNull(rs1.getString("COMINFO_GSTINREG"));
					strexempted=correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
					hshRecord.put("COMINFO_GSTINREG", correctNull(rs1.getString("COMINFO_GSTINREG")));
					hshRecord.put("COMINFO_GST_EXEMPTED", correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));
					hshRecord.put("perapp_cbsid", correctNull(rs1.getString("perapp_cbsid")));
					hshRecord.put("perapp_fname", correctNull(rs1.getString("perapp_title"))+"."+correctNull(rs1.getString("perapp_fname")));
					hshRecord.put("PERAPP_INVOCDATE", Helper.correctNull((String) rs1.getString("PERAPP_INVOCDATE")));

				}
		     	
		
     if(rs!=null)
    	 rs.close();
     strQuery=SQLParser.getSqlQuery("sel_ahp_details^"+strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()) 
		{
			
			hshRecord.put("AHP_ALLOTMENT_LETTER", "Yes");
			hshRecord.put("AHP_INCOME_CERTIFICATE", "Yes");
			hshRecord.put("AHP_BRANCHNAME", Helper.correctNull(rs.getString("AHP_BRANCHNAME")));
			hshRecord.put("AHP_BANKNAME_CODE", Helper.correctNull(rs.getString("AHP_BANKNAME")));
			hshRecord.put("AHP_ACCNUMBER", Helper.correctNull(rs.getString("AHP_ACCNUMBER")));
			hshRecord.put("AHP_IFSCCODE", Helper.correctNull(rs.getString("AHP_IFSCCODE")));
			hshRecord.put("AHP_GOI_AMT", Helper.correctNull(rs.getString("AHP_GOI_AMT")));
			hshRecord.put("AHP_GOK_AMT", Helper.correctNull(rs.getString("AHP_GOK_AMT")));
			hshRecord.put("AHP_SAVINGS", Helper.correctNull(rs.getString("AHP_SAVINGS")));
			String branchCode="";
			String stat_id="147";
			branchCode=Helper.correctNull(rs.getString("AHP_BANKNAME"));
			strQuery=SQLParser.getSqlQuery("selstatdatabyiddesc^"+stat_id+"^"+branchCode);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next()) 
			{
				hshRecord.put("AHP_BANKNAME", Helper.correctNull(rs1.getString("stat_data_desc1")));
			}
			hshRecord.put("AHP_COSTLOANPRD", Helper.correctNull(rs.getString("AHP_COSTLOANPRD")));
			String resType=Helper.correctNull(rs.getString("AHP_RESIDENT_TYPE"));
			if(("1").equalsIgnoreCase(resType)){
				resType="Rented";
			}else if(("2").equalsIgnoreCase(resType)){
				resType="Owned";
			}else if(("3").equalsIgnoreCase(resType)){
				resType="Leased";
			}else if(("4").equalsIgnoreCase(resType)){
				resType="Family";
			}else if(("5").equalsIgnoreCase(resType)){
				resType="Employer";
			}
			hshRecord.put("AHP_RESIDENT_TYPE", Helper.correctNull(resType));
			
			
     
		}
		} catch (Exception e) {
			throw new EJBException("Error in getRetailProcessNote :: "
					+ e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs1.close();
				}
			} catch (Exception e) {
				throw new EJBException("Exception in Closing Connection "
						+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getSanctionLetterData(HashMap hshValues)  {
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null, rs3 = null,rs5=null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrayRow = new ArrayList();
		ArrayList arrayTermsRow = new ArrayList();
		ArrayList arrayPartnersRow = new ArrayList();
		ArrayList arrayGoldRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrayCol = new ArrayList();
		ArrayList arrayTermsCol = new ArrayList();
		ArrayList arrayPartnersCol = new ArrayList();
		ArrayList arrayGoldCol = new ArrayList();
		ArrayList arrayTermType = new ArrayList();
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		String strQuery = "";
		String strQuery1 = "";
		String strQuery2 = "";
		String strAppNo = "";
		String strSancAuthCode = "";
		String strSancAuthDesc = "";
		String strOrgCode = "";
		String strOrgRegion = "";
		String strOrgRegionName = "";
		String strDemoType = "";
		String strDemoTypeDesc = "";
		String strSancOrgCode = "";
		String strSancOrgRegion = "";
		String strSancOrgRegionName = "";
		String strPrdLoanType = "";
		String strBankScheme = "";
		String strBankSchemeDesc = "";
		String strPrdLoanTypeDesc = "";
		String strConstitution = "";
		String strConstitutionDesc = "";
		String strSancAmount = "";
		String strHoliday = "";
		String strPrdDesc = "";
		String strModeOfOper = "";
		String strRepayPeriod = "";
		String strIntRate = "";
		String strAppID = "";
		String strStaff = "";
		String strDueDate = "";
		String strRepayType = "";
		String strSanctRefNum = "";
		String strAdvancePurpose = "";
		String strMISClassification = "";
		String strStaffID = "";
		String strSancAppraisalDept = "";
		String strSancAppraisalDeptCode = "";
		String strAdvPurposeCode = "";
		String strIntDemandFreqCode = "";
		String strIntDemandFreq = "";
		String strInwardDate = "";
		String strPartyFileNo = "";
		String strDesignation = "";
		String strDesignationCode = "";
		String strSancCode = "";
		String strSanctDept = "";
		String strUserId = "";
		String strLoanPurpose = "";
		String strSector = "";
		String strSubSector = "";
		String strPurpose = "";
		String strIntType = "";
		String strPrdCode = "";
		String strSymbol = "";
		String strRenewFlg = "";
		String strGovt = "";
		String strPeriodicity = "";
		String strServiced = "";
		String datSanctionDate = "";
		int intMonths = 0, intHoliday = 0;
		double dblBaseRate = 0.00;
		double dblModIntRate = 0.00;
		String strMCLRType = "";

		ArrayList arrSecCol = new ArrayList();
		// ArrayList arrSecRow = new ArrayList();
		try {
			strAppNo = Helper.correctNull((String) hshValues.get("appno"));
			strOrgCode = Helper.correctNull((String) hshValues
					.get("strOrgCode"));
			strAppID = Helper.correctNull((String) hshValues
					.get("hidapplicantid"));
			strUserId = Helper.correctNull((String) hshValues.get("strUserId"));
			String strprdtype = "";
			if (!strAppNo.equalsIgnoreCase("")) {
				/*
				 * Organization Details
				 */
				strQuery = SQLParser.getSqlQuery("sel_HeadOfficeDet");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("strHeadOffAddr1", Helper
							.correctNull((String) rs.getString("org_add1")));
					hshRecord.put("strHeadOffAddr2", Helper
							.correctNull((String) rs.getString("org_add2")));
					hshRecord.put("strHeadOffCity", Helper
							.correctNull((String) rs.getString("city_name")));
					hshRecord.put("strHeadOffState", Helper
							.correctNull((String) rs.getString("state_name")));
					hshRecord.put("strHeadOffZip", Helper
							.correctNull((String) rs.getString("org_zip")));
				}
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selBranchCityName^"
						+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("orgname", correctNull(rs
							.getString("org_name")));
					hshRecord.put("orgadd1", correctNull(rs
							.getString("org_add1")));
					hshRecord.put("orgadd2", correctNull(rs
							.getString("org_add2")));
					hshRecord.put("orgcity", correctNull(rs
							.getString("city_name")));
					hshRecord.put("orgstate", correctNull(rs
							.getString("state_name")));
					hshRecord.put("orgzip",
							correctNull(rs.getString("org_zip")));
					hshRecord.put("orgphone", correctNull(rs
							.getString("org_phone")));
				}
				if (rs != null) {
					rs.close();
				}
				String strLARorgcode = "";
				String livedate=ApplicationParams.getStrCLPHdate();
				String postsanctionflag="";
				String applicationStatus="";
				// check when application is created
				String appcreatedate="";
				
					strQuery = SQLParser.getSqlQuery("getcreatedate^"+strAppNo);
					rs5= DBUtils.executeQuery(strQuery);
					if (rs5.next()){
						
						appcreatedate= rs5.getString("createddate");
						applicationStatus= rs5.getString("APP_STATUS");
					}
					System.out.println("Application created date-->"+appcreatedate);
					System.out.println("Sanction  Live Date-->"+livedate);
			       if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
					 String Pattern="dd/MM/yyyy";
						DateFormat df=new SimpleDateFormat(Pattern);
						Date appcreationdate=df.parse(appcreatedate);
						Date postsanclivedate=df.parse(livedate);

						if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
						{
				strQuery=SQLParser.getSqlQuery("sel_ApplnBranch^"+strAppNo);
						}else{
							strQuery=SQLParser.getSqlQuery("sel_ApplnBranchnewchk^"+strAppNo);
						}
			       }
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("homebranch", Helper.correctNull((String) rs
							.getString("org_name")));
					hshRecord.put("branchcode", Helper.correctNull((String) rs
							.getString("org_scode")));
					strLARorgcode = Helper.correctNull((String) rs
							.getString("org_code"));
					
					
					if(Helper.correctNull(rs.getString("app_orglevel")).equalsIgnoreCase("C")||Helper.correctNull(rs.getString("app_orglevel")).equalsIgnoreCase("D"))
					{
						strQuery = SQLParser.getSqlQuery("sel_pertainingbr_ret^"
								+ strAppNo);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							hshRecord.put("homebranch", correctNull(rs.getString("org_name")));
							hshRecord.put("branchcode", Helper.correctNull((String) rs.getString("org_scode")));
							strLARorgcode=Helper.correctNull(rs.getString("org_code"));
						}
					}
					
					
				}
				if (rs != null) {
					rs.close();
				}
				if (!strLARorgcode.equalsIgnoreCase("")) {
					strOrgRegion = strLARorgcode.substring(0, 6);
				}
				strOrgRegion = strOrgRegion + "000000000";
				if (!strOrgRegion.equalsIgnoreCase("")) {
					strQuery = SQLParser.getSqlQuery("selorgname^"
							+ strOrgRegion);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strOrgRegionName = Helper.correctNull((String) rs
								.getString("org_name"));
					}
				}
				hshRecord.put("strOrgRegionName", strOrgRegionName);
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_ProcessedOrgSCode^"
						+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSancOrgCode = Helper.correctNull((String) rs
							.getString("org_code"));
				}
				if (!strSancOrgCode.equalsIgnoreCase("")) {
					strSancOrgRegion = strSancOrgCode.substring(0, 6);
				}
				strSancOrgRegion = strSancOrgRegion + "000000000";
				if (!strSancOrgRegion.equalsIgnoreCase("")) {
					strQuery = SQLParser.getSqlQuery("selorgname^"
							+ strSancOrgRegion);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strSancOrgRegionName = Helper.correctNull((String) rs
								.getString("org_name"));
					}
				}
				hshRecord.put("strSancOrgRegionName", strSancOrgRegionName);
				/*
				 * End - Organization Details
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Sanction Reference Number
				 */
				strQuery = SQLParser.getSqlQuery("sel_SancRefNo^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSanctRefNum = Helper.correctNull((String) rs
							.getString("sanctionrefno"));
				}
				hshRecord.put("strSanctRefNum", strSanctRefNum);
				/*
				 * End - Sanction Reference Number
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Loan Type
				 */
				strQuery = SQLParser.getSqlQuery("sel_prdloantype^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strPrdLoanType = Helper.correctNull((String) rs
							.getString("prd_loantype"));
					strBankScheme = Helper.correctNull((String) rs
							.getString("prd_bankscheme"));
					strprdtype = Helper.correctNull((String) rs
							.getString("prd_type"));
				}
				hshRecord.put("strLoanType", strPrdLoanType);
				if (strPrdLoanType.equalsIgnoreCase("TL")) {
					strPrdLoanTypeDesc = "Gold Loan";
					strPrdLoanType = "Term Loan";
				}
				if (strPrdLoanType.equalsIgnoreCase("DL")) {
					strPrdLoanTypeDesc = "Gold Loan";
					strPrdLoanType = "Demand Loan";
				} else if (strPrdLoanType.equalsIgnoreCase("OD")) {
					strPrdLoanTypeDesc = "Gold OD";
					strPrdLoanType = "Over Draft";
				}
				hshRecord.put("strPrdLoanType", strPrdLoanTypeDesc);
				hshRecord.put("strPrdLoanTypeRetail", strPrdLoanType);
				/*
				 * End - Loan Type
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Bank's Scheme
				 */
				if (!strBankScheme.equalsIgnoreCase("")) {
					strQuery = SQLParser.getSqlQuery("sel_misstaticdatadesc^1^"
							+ strBankScheme);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strBankSchemeDesc = Helper.correctNull((String) rs
								.getString("mis_static_data_desc"));
					}
				}
				hshRecord.put("strBankSchemeDesc", strBankSchemeDesc);
				/*
				 * End - Bank's Scheme
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Constitution of the Applicant
				 */
				strQuery = SQLParser.getSqlQuery("seleligibileconst^"
						+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strConstitution = Helper.correctNull((String) rs
							.getString("perapp_constitution"));
				}
				if (!strConstitution.equalsIgnoreCase("")) {
					if (rs != null) {
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("selconstitutiondesc^"
							+ strConstitution);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strConstitutionDesc = Helper.correctNull((String) rs
								.getString("cbs_static_data_desc"));
					}
				}
				hshRecord.put("strConstitution", strConstitution);
				hshRecord.put("strConstitutionDesc", strConstitutionDesc);
				/*
				 * End - Constitution
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Whether Applicant is a Staff of KBL
				 */
				strQuery = SQLParser.getSqlQuery("sel_staffandemptype^"
						+ strAppID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strStaff = Helper.correctNull((String) rs
							.getString("indinfo_is_staff"));
					if (strStaff.equalsIgnoreCase("02")) {
						strStaffID = Helper.correctNull((String) rs
								.getString("indinfo_staff_id"));
						if (!strStaffID.equalsIgnoreCase("")) {
							if (rs1 != null) {
								rs1.close();
							}
							strQuery1 = SQLParser.getSqlQuery("setuserssel^"
									+ strStaffID);
							rs1 = DBUtils.executeQuery(strQuery1);
							if (rs1.next()) {
								strDesignationCode = Helper
										.correctNull((String) rs1
												.getString("user_designation"));
								if (!strDesignationCode.equalsIgnoreCase("")) {
									if (rs2 != null) {
										rs2.close();
									}
									strQuery2 = SQLParser
											.getSqlQuery("sel_cbsstaticdescbycode^27^"
													+ strDesignationCode);
									rs2 = DBUtils.executeQuery(strQuery2);
									if (rs2.next()) {
										strDesignation = Helper
												.correctNull((String) rs2
														.getString("cbs_static_data_desc"));
									}
								}
							}
						}
					}
				}
				hshRecord.put("strStaff", strStaff);
				hshRecord.put("strStaffID", strStaffID);
				hshRecord.put("strDesignation", strDesignation);
				if (!strConstitution.equalsIgnoreCase("01")
						&& !strConstitution.equalsIgnoreCase("02")) {
					if (rs != null) {
						rs.close();
					}
					/*
					 * Partner/Co-Directors/Trustees Details
					 */
					strQuery = SQLParser.getSqlQuery("sel_partnerdetails^"
							+ strAppID);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						arrayPartnersCol = new ArrayList();
						arrayPartnersCol.add(Helper.correctNull((String) rs
								.getString("part_name")));
						arrayPartnersCol.add(Helper.correctInt((String) rs
								.getString("part_age")));
						arrayPartnersCol.add(Helper.correctNull((String) rs
								.getString("part_relationship")));
						arrayPartnersRow.add(arrayPartnersCol);
					}
					hshRecord.put("arrayPartnersRow", arrayPartnersRow);
					/*
					 * End - Partner/Co-Directors/Trustees Details
					 */
				}
				/*
				 * 
				 */
				if (rs1 != null) {
					rs1.close();
				}
				strQuery1 = SQLParser.getSqlQuery("setuserssel^" + strUserId);
				rs1 = DBUtils.executeQuery(strQuery1);
				if (rs1.next()) {
					strSancCode = Helper.correctNull((String) rs1
							.getString("user_designation"));
					if (!strSancCode.equalsIgnoreCase("")) {
						if (rs2 != null) {
							rs2.close();
						}
						strQuery2 = SQLParser
								.getSqlQuery("sel_cbsstaticdescbycode^27^"
										+ strSancCode);
						rs2 = DBUtils.executeQuery(strQuery2);
						if (rs2.next()) {
							strSanctDept = Helper.correctNull((String) rs2
									.getString("cbs_static_data_desc"));
						}
					}
				}
				hshRecord.put("strSanctDept", strSanctDept);
				/*
				 * 
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Loan Details
				 */
				String strGovtscheme = "";
				strQuery = SQLParser
						.getSqlQuery("selperprdintrate^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSancAmount = nf.format(rs.getDouble("loan_recmdamt"));
					dblModIntRate = rs.getDouble("loan_modintrate");
					strIntRate = nf.format(dblModIntRate);
					strRepayPeriod = Helper.correctNull((String) rs
							.getString("loan_reqterms"));
					strPartyFileNo = Helper.correctNull((String) rs
							.getString("loan_fileno"));
					strIntType = Helper.correctNull((String) rs
							.getString("loan_inttype"));
					strGovt = Helper.correctNull((String) rs
							.getString("loan_govt"));
					dblBaseRate = Double.parseDouble(Helper.correctDouble(rs
							.getString("loan_baserate")));
					strMCLRType = Helper.correctNull(rs
							.getString("loan_mclrtype"));
					strGovtscheme = Helper.correctNull(rs
							.getString("govt_scheme"));
					hshRecord.put("loan_metlifepremiumamt", nf.format(rs
							.getDouble("loan_metlifepremiumamt")));
					hshRecord.put("strProcessingFee", Helper
							.checkDecimal(Helper.correctDouble(rs
									.getString("loan_profee"))));
					hshRecord.put("LOAN_DUEDATE", Helper.correctNull(rs
							.getString("LOAN_DUEDATE")));
					hshRecord.put("LOAN_CREDITRSKVAL", Helper.correctNull(rs
							.getString("LOAN_CREDITRSKVAL")));
					hshRecord.put("loan_busstatval", Helper.correctNull(rs
							.getString("loan_busstatval")));
					hshRecord.put("DEVIATION_PENALITY", Helper.correctNull(rs
							.getString("DIGI_DEVIATION_ROI_PENALTY")));
					hshRecord.put("APP_LOANSUBTYPE_DIGI", Helper.correctNull(rs
							.getString("APP_LOANSUBTYPE_DIGI")));
					
					if(!Helper.correctNull((String) rs.getString("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase(""))
					{
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull((String) rs.getString("LOAN_INS_COMPANY_NAME")));
						if (rs1.next()) {
							hshRecord.put("strInsCompanyName", Helper.correctNull((String) rs1.getString("STAT_DATA_DESC1")));
						}
					}
					if (rs1 != null) {rs1.close();}
					hshRecord.put("LOAN_INS_ACCOUNT_NO", Helper.correctNull((String) rs.getString("LOAN_INS_ACCOUNT_NO")));
					hshRecord.put("LOAN_PREMIUM_LOAN_AMOUNT", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("LOAN_PREMIUM_LOAN_AMOUNT"))));
					hshRecord.put("LOAN_PREMIUM_AMOUNT", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("LOAN_PREMIUM_AMOUNT"))));
					hshRecord.put("LOAN_PREMIUM_TENOR",  Helper.correctNull((String) rs.getString("LOAN_PREMIUM_TENOR")));
					hshRecord.put("LOAN_INS_COMPANY_NAME",  Helper.correctNull((String) rs.getString("LOAN_INS_COMPANY_NAME")));
					if(!Helper.correctNull((String) rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")).equalsIgnoreCase(""))
					{
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^223^"+ Helper.correctNull((String) rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")));
						if (rs1.next()) {
							hshRecord.put("strInsFundedCompanyName", Helper.correctNull((String) rs1.getString("STAT_DATA_DESC1")));
						}
					}
				}
				if (strGovt.equalsIgnoreCase("1")) {
					hshRecord.put("strGovt", "Yes");

					if (rs1 != null)
						rs1 = null;
					String Housecat_code = "";
					if (!strGovtscheme.equalsIgnoreCase("")) {
						hshRecord.put("strGovtScheme", strGovtscheme);

						if (rs2 != null)
							rs2 = null;
						strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"
								+ "11^" + strGovtscheme);
						rs2 = DBUtils.executeQuery(strQuery);
						if (rs2.next()) {
							hshRecord.put("strGovtSchDesc", Helper
									.correctNull(rs2
											.getString("stat_data_desc1")));
						}

						if (rs2 != null)
							rs2 = null;
						strQuery = SQLParser.getSqlQuery("sel_PMAY_desc^"
								+ strAppNo);
						rs2 = DBUtils.executeQuery(strQuery);
						if (rs2.next()) {
							if (rs3 != null)
								rs3 = null;
							strQuery = SQLParser
									.getSqlQuery("select_Pmay_desc^"
											+ Helper
													.correctNull(rs2
															.getString("PMAY_HOUSE_CAT")));
							rs3 = DBUtils.executeQuery(strQuery);
							if (rs3.next()) {
								hshRecord.put("strGovtCategory", Helper
										.correctNull(rs3
												.getString("PM_SUBCATEGORY")));
							}

						}

					}

				} else if (strGovt.equalsIgnoreCase("2")) {
					hshRecord.put("strGovt", "No");
				}
				hshRecord.put("strPartyFileNo", strPartyFileNo);
				hshRecord.put("strSancAmount", strSancAmount);
				hshRecord.put("strIntRate", strIntRate);
				hshRecord.put("strIntType", strIntType);
				hshRecord.put("strRepayPeriod", strRepayPeriod);
				strQuery = SQLParser.getSqlQuery("get_AppSancDateAndPRDCode^"
						+ strRepayPeriod + "^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					datSanctionDate = Helper.correctNull((String) rs
							.getString("app_processdate"));
					strDueDate = rs.getString("app_duedate");
					strPrdCode = Helper.correctNull((String) rs
							.getString("app_prdcode"));
				}
				int intDateDiff = 0;
				strQuery1 = SQLParser.getSqlQuery("sel_sancdate_diff_Intcode^"
						+ datSanctionDate);
				if (rs1 != null)
					rs1.close();
				rs1 = DBUtils.executeQuery(strQuery1);
				if (rs1.next()) {
					intDateDiff = Integer.parseInt(Helper
							.correctInt((String) rs1.getString("datediff")));
				}
				hshRecord.put("daydiff", String.valueOf(intDateDiff));

				// to get MCLR
				String strMCLRFlag = "Y";
				if (strIntType.equalsIgnoreCase("Floating")) {
					strQuery1 = SQLParser.getSqlQuery("sanctiondate_mclr^"
							+ strAppNo);
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						if (Integer.parseInt(Helper.correctInt(rs1
								.getString("datediff"))) < 0) {
							strMCLRFlag = "N";
						}

					}
				} else {
					strMCLRFlag = "N";
				}

				if (strMCLRFlag.equalsIgnoreCase("Y")) {
					if (!strMCLRType.equalsIgnoreCase("")) {
						String[] strArr = strMCLRType.split("@");
						if (strArr.length > 1) {
							if (rs2 != null)
								rs2.close();
							rs2 = DBUtils
									.executeLAPSQuery("selcbsiddatadesc^34^"
											+ strArr[0]);
							if (rs2.next()) {
								hshRecord.put("mclr_type",Helper.correctNull(rs2.getString("cbs_static_data_desc")));
								hshRecord.put("mclr_passCode",Helper.correctNull(rs2.getString("cbs_static_data_passing_code")));
							}
						}
					}
				}
				hshRecord.put("strMCLRFlag", strMCLRFlag);

				/*
				 * if(rs!=null) { rs.close(); }
				 * strQuery=SQLParser.getSqlQuery("selinttyperate^"
				 * +strIntType+"^"
				 * +strPrdCode+"^<=^"+strSancAmount+"^>=^"+strSancAmount
				 * +"^<=^"+strRepayPeriod+"^>=^"+strRepayPeriod);
				 * rs=DBUtils.executeQuery(strQuery); if(rs.next()) {
				 * dblBaseRate
				 * =Double.parseDouble(Helper.correctDouble((String)rs
				 * .getString("prd_baserate"))); }
				 */

				double dblAdjustment = dblModIntRate - dblBaseRate;
				if (dblModIntRate >= dblBaseRate) {
					strSymbol = "+";
				}
				hshRecord.put("dblAdjustment", nf.format(dblAdjustment));
				hshRecord.put("strSymbol", strSymbol);

				if (rs != null) {
					rs.close();
				}
				if (strMCLRFlag.equalsIgnoreCase("N")) {
					strQuery = SQLParser.getSqlQuery("sel_baseRatefrommaster");
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						hshRecord.put("dblBaseRate", nf.format(Double
								.parseDouble(Helper.correctDouble(rs
										.getString("int_intvalue")))));
					}
				} else {
					hshRecord.put("dblBaseRate", nf.format(dblBaseRate));
				}
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_cbsdetails^" + strAppNo
						+ "^" + 1);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strAdvPurposeCode = Helper.correctNull((String) rs
							.getString("PURPOSEOFADV"));
					strIntDemandFreqCode = Helper.correctNull((String) rs
							.getString("INTRATEFREQ"));
					if (!strAdvPurposeCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser
								.getSqlQuery("sel_cbsstaticdescbycode^24^"
										+ strAdvPurposeCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strAdvancePurpose = Helper.correctNull((String) rs1
									.getString("cbs_static_data_desc"));
						}
					}
					if (strIntDemandFreqCode.equalsIgnoreCase("M")) {
						strIntDemandFreq = "Monthly";
					} else if (strIntDemandFreqCode.equalsIgnoreCase("Q")) {
						strIntDemandFreq = "Quarterly";
					} else if (strIntDemandFreqCode.equalsIgnoreCase("H")) {
						strIntDemandFreq = "Half-yearly";
					} else if (strIntDemandFreqCode.equalsIgnoreCase("Y")) {
						strIntDemandFreq = "Yearly";
					}
				}
				hshRecord.put("strAdvancePurpose", strAdvancePurpose);
				hshRecord.put("strIntDemandFreq", strIntDemandFreq);
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_misappclassification^"
						+ strAppNo + "^" + 1);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					String strMISClassCode = "";
					strMISClassCode = Helper.correctNull((String) rs
							.getString("app_sector"));
					if (strMISClassCode.equalsIgnoreCase("01")) {
						strMISClassification = "Priority Sector";
					} else if (strMISClassCode.equalsIgnoreCase("02")) {
						strMISClassification = "Non Priority Sector";
					}
					
					if (rs1 != null) {
						rs1.close();
					}
					rs1 = DBUtils.executeLAPSQuery("sel_guarantee^"
							+ "12"
							+ "^"
							+ Helper.correctNull((String) rs
									.getString("app_agriculture")));
					if (rs1.next()) {
						hshRecord.put("mis_indcattyepagr", Helper
								.correctNull((String) rs1
										.getString("mis_static_data_desc")));
					} else {
						hshRecord.put("mis_indcattyepagr", "Nil");
					}
					
				}
				hshRecord.put("strMISClassification", strMISClassification);
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("securesel^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strHoliday = Helper.correctNull((String) rs
							.getString("loan_noofinstallment"));
					strPeriodicity = Helper.correctNull((String) rs
							.getString("loan_periodicity"));
					strServiced = Helper.correctNull((String) rs
							.getString("loan_servised"));
				}
				if (strPeriodicity.equalsIgnoreCase("m")) {
					strPeriodicity = "Monthly";
				} else if (strPeriodicity.equalsIgnoreCase("q")) {
					strPeriodicity = "Quarterly";
				} else if (strPeriodicity.equalsIgnoreCase("h")) {
					strPeriodicity = "Half-Yearly";
				} else if (strPeriodicity.equalsIgnoreCase("y")) {
					strPeriodicity = "Yearly";
				} else if (strPeriodicity.equalsIgnoreCase("n")) {
					strPeriodicity = "Not Applicable";
				}
				hshRecord.put("strPeriodicity", strPeriodicity);
				hshRecord.put("strHoliday", strHoliday);
				if (strServiced.equalsIgnoreCase("y")) {
					strServiced = "Yes";
				} else if (strServiced.equalsIgnoreCase("n")) {
					strServiced = "No";
				} else if (strServiced.equalsIgnoreCase("s")) {
					strServiced = "Not Applicable";
				}
				hshRecord.put("strServiced", strServiced);
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("getprddesc^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strPrdDesc = Helper.correctNull((String) rs
							.getString("prd_desc"));
					hshRecord.put("strStaffPrd", correctNull(rs
							.getString("prd_staffprd")));
				}
				hshRecord.put("strPrdDesc", strPrdDesc);
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_ModeOfOper^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strModeOfOper = Helper.correctNull((String) rs
							.getString("modeofoper"));
				}
				hshRecord.put("strModeOfOper", strModeOfOper);
				if (rs != null) {
					rs.close();
				}
				intMonths = Integer.parseInt(Helper
						.correctInt((String) strRepayPeriod));
				intHoliday = Integer.parseInt(Helper
						.correctInt((String) strHoliday));
				// strDueDate=Helper.addMonthWithDate(datSanctionDate,
				// intMonths);
				int intExcHol = intMonths - intHoliday;
				hshRecord.put("strDueDate", strDueDate);
				hshRecord.put("strExcHol", Integer.toString(intExcHol));
				if (rs != null) {
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("get_RepayTypeAndPurpose^"
						+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strLoanPurpose = Helper.CLOBToString(rs
							.getClob("loan_purposeofloan"));
					String strRepayTypeCode = Helper.correctNull((String) rs
							.getString("loan_repaymenttype"));
					if (strRepayTypeCode.equalsIgnoreCase("12")) {
						strRepayType = "On Demand";
					} else if (strRepayTypeCode.equalsIgnoreCase("8")) {
						strRepayType = "On Due Date";
					} else if (strRepayTypeCode.equalsIgnoreCase("14")) {
						strRepayType = "2 Yealy Equal Installment";
					}
					if (strRepayTypeCode.equalsIgnoreCase("1")) {
						hshRecord.put("strWhetherEMI", "Yes");
						strRepayType = "EMI";
					} else {
						hshRecord.put("strWhetherEMI", "No");
						if (strRepayTypeCode.equalsIgnoreCase("2")) {
							strRepayType = "Non-EMI";
						} else if (strRepayTypeCode.equalsIgnoreCase("13")) {
							strRepayType = "Equal Monthly Installment";
						}
					}
					hshRecord.put("strRepayTypeCode", strRepayTypeCode);
				}
				hshRecord.put("strLoanPurpose", strLoanPurpose);
				hshRecord.put("strRepayType", strRepayType);
				/*
				 * End - Loan Details
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Sector, SubSector, Purpose
				 */
				strQuery = SQLParser.getSqlQuery("sel_misappdetails^"
						+ strAppNo + "^" + "1");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					String strSectorCode = Helper.correctNull((String) rs
							.getString("app_mainactivity"));
					String strSubSectorCode = Helper.correctNull((String) rs
							.getString("app_subactivity"));
					String strPurposeCode = Helper.correctNull((String) rs
							.getString("app_purpose"));
					if (!strSectorCode.equalsIgnoreCase("")) {
						MisBean MB = new MisBean();
						strSector = MB.getMISStaticDataDesc("2", strSectorCode);
						if (!strSubSectorCode.equalsIgnoreCase("")) {
							if (rs1 != null) {
								rs.close();
							}
							strQuery1 = SQLParser
									.getSqlQuery("sel_MISSubActivityDesc^"
											+ strSectorCode + "^"
											+ strSubSectorCode);
							rs1 = DBUtils.executeQuery(strQuery1);
							if (rs1.next()) {
								strSubSector = Helper.correctNull((String) rs1
										.getString("mis_subactdesc"));
							}
						}
					}
					if (!strPurposeCode.equalsIgnoreCase("")) {
						String[] strPurposeCodes = strPurposeCode.split("_");
						String strPurposeCode1 = strPurposeCodes[0];
						String strPurposeSlNo = strPurposeCodes[1];
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("sel_PurposeDesc^3^"
								+ strPurposeCode1 + "^" + strPurposeSlNo);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strPurpose = Helper.correctNull((String) rs1
									.getString("mis_static_data_desc"));
						}
					}
				}
				hshRecord.put("strSector", strSector);
				hshRecord.put("strSubSector", strSubSector);
				hshRecord.put("strPurpose", strPurpose);
				/*
				 * End - Sector, SubSector, Purpose
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Applicant/Joint Applicant's Address
				 */
				strQuery = SQLParser.getSqlQuery("sel_sanccustdet^" + strAppNo
						+ "^ d.demo_type in('a','c')");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					String strDistrict = "";
					String strCity = "";
					String strState = "";
					String strCountry = "";
					String strDistCode = "";
					String strCountryCode = "";
					String strCityCode = "";
					String strStateCode = "";
					String strzip = "";
					strDemoType = Helper.correctNull((String) rs
							.getString("demo_type"));
					String residentType = correctNull(rs
							.getString("INDINFO_RESIDENT_STATUS"));

					if (strDemoType.equals("a")) {
						strDemoTypeDesc = "Applicant";
					} else if (strDemoType.equals("c")) {
						strDemoTypeDesc = "Joint Applicant";
					}
					arrCol = new ArrayList();
					arrCol.add(strDemoTypeDesc);
					arrCol.add(Helper.correctNull((String) rs
							.getString("perapp_name")));

					if (residentType.equals("N")) {
						arrCol.add(Helper.correctNull((String) rs
								.getString("con_comaddr1")));
						arrCol.add(Helper.correctNull((String) rs
								.getString("con_comaddr2")));
						arrCol.add(Helper.correctNull((String) rs
								.getString("con_comvillage")));
						strDistCode = Helper.correctNull((String) rs
								.getString("con_comdist"));
						strCountryCode = Helper.correctNull((String) rs
								.getString("con_comcountry"));
						strCityCode = Helper.correctNull((String) rs
								.getString("con_comcity"));
						strStateCode = Helper.correctNull((String) rs
								.getString("con_comstate"));
						strzip = Helper.correctNull((String) rs
								.getString("con_comzip"));
					} else {
						arrCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMADDR1")));
						arrCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMADDR2")));
						arrCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMVILLAGE")));
						strDistCode = Helper.correctNull((String) rs
								.getString("CON_PERMDIST"));
						strCountryCode = Helper.correctNull((String) rs
								.getString("CON_PERMCOUNTRY"));
						strCityCode = Helper.correctNull((String) rs
								.getString("CON_PERMCITY"));
						strStateCode = Helper.correctNull((String) rs
								.getString("CON_PERMSTATE"));
						strzip = Helper.correctNull((String) rs
								.getString("CON_PERMZIP"));
					}

					if (!strDistCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("sel_districtmaster^"
								+ strDistCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strDistrict = Helper.correctNull((String) rs1
									.getString("district_desc"));
						}
					}
					arrCol.add(strDistrict);

					if (!strCityCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("selcitycode^"
								+ strCityCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strCity = Helper.correctNull((String) rs1
									.getString("city_name"));
						}
					}
					arrCol.add(strCity);
					arrCol.add(strzip);
					if (!strStateCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser
								.getSqlQuery("sel_statenamebycode^"
										+ strStateCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strState = Helper.correctNull((String) rs1
									.getString("state_name"));
						}
					}
					arrCol.add(strState);

					if (!strCountryCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser
								.getSqlQuery("sel_countryList^where con_countrycode='"
										+ strCountryCode + "'");
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strCountry = Helper.correctNull((String) rs1
									.getString("con_country"));
						}
					}
					arrCol.add(strCountry);
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);
				/*
				 * End - Applicant/Joint Applicant's Address
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Co-Obligant/Guarantor's Address
				 */
				strQuery = SQLParser.getSqlQuery("sel_sanccustdet^" + strAppNo
						+ "^ d.demo_type in('o','g')");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					String strDistrict = "";
					String strCity = "";
					String strState = "";
					String strCountry = "";
					String strDistCode = "";
					String strCountryCode = "";
					String strCityCode = "";
					String strStateCode = "";
					String strzip = "";
					strDemoType = Helper.correctNull((String) rs
							.getString("demo_type"));
					String residentType = correctNull(rs
							.getString("INDINFO_RESIDENT_STATUS"));

					if (strDemoType.equals("o")) {
						strDemoTypeDesc = "Co-Obligant";
					} else if (strDemoType.equals("g")) {
						strDemoTypeDesc = "Guarantor";
					}
					arrayCol = new ArrayList();
					arrayCol.add(strDemoTypeDesc);
					arrayCol.add(Helper.correctNull((String) rs
							.getString("perapp_name")));

					if (residentType.equals("N")) {
						arrayCol.add(Helper.correctNull((String) rs
								.getString("con_comaddr1")));
						arrayCol.add(Helper.correctNull((String) rs
								.getString("con_comaddr2")));
						arrayCol.add(Helper.correctNull((String) rs
								.getString("con_comvillage")));
						strDistCode = Helper.correctNull((String) rs
								.getString("con_comdist"));
						strCountryCode = Helper.correctNull((String) rs
								.getString("con_comcountry"));
						strCityCode = Helper.correctNull((String) rs
								.getString("con_comcity"));
						strStateCode = Helper.correctNull((String) rs
								.getString("con_comstate"));
						strzip = Helper.correctNull((String) rs
								.getString("con_comzip"));
					} else {
						arrayCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMADDR1")));
						arrayCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMADDR2")));
						arrayCol.add(Helper.correctNull((String) rs
								.getString("CON_PERMVILLAGE")));
						strDistCode = Helper.correctNull((String) rs
								.getString("CON_PERMDIST"));
						strCountryCode = Helper.correctNull((String) rs
								.getString("CON_PERMCOUNTRY"));
						strCityCode = Helper.correctNull((String) rs
								.getString("CON_PERMCITY"));
						strStateCode = Helper.correctNull((String) rs
								.getString("CON_PERMSTATE"));
						strzip = Helper.correctNull((String) rs
								.getString("CON_PERMZIP"));
					}

					if (!strDistCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("sel_districtmaster^"
								+ strDistCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strDistrict = Helper.correctNull((String) rs1
									.getString("district_desc"));
						}
					}
					arrayCol.add(strDistrict);
					if (!strCityCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser.getSqlQuery("selcitycode^"
								+ strCityCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strCity = Helper.correctNull((String) rs1
									.getString("city_name"));
						}
					}
					arrayCol.add(strCity);
					arrayCol.add(strzip);
					if (!strStateCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser
								.getSqlQuery("sel_statenamebycode^"
										+ strStateCode);
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strState = Helper.correctNull((String) rs1
									.getString("state_name"));
						}
					}
					arrayCol.add(strState);
					if (!strCountryCode.equalsIgnoreCase("")) {
						if (rs1 != null) {
							rs1.close();
						}
						strQuery1 = SQLParser
								.getSqlQuery("sel_countryList^where con_countrycode='"
										+ strCountryCode + "'");
						rs1 = DBUtils.executeQuery(strQuery1);
						if (rs1.next()) {
							strCountry = Helper.correctNull((String) rs1
									.getString("con_country"));
						}
					}
					arrayCol.add(strCountry);
					arrayRow.add(arrayCol);
				}
				hshRecord.put("arrayRow", arrayRow);
				/*
				 * End - Co-Obligant/Guarantor's Address
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Gold Ornaments
				 */
				double dbESTRATE = 0.00;
				double dbESTRATE1 = 0.00;
				strQuery = SQLParser.getSqlQuery("selgolddetails^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrayGoldCol = new ArrayList();
					arrayGoldCol.add(Helper.correctNull((String) rs
							.getString("AGR_ARTNO")));
					arrayGoldCol.add(Helper.correctNull((String) rs
							.getString("AGR_ARTDESC")));
					arrayGoldCol.add(Helper.correctNull((String) rs
							.getString("AGR_ARTGROSSWT")));
					arrayGoldCol.add(Helper.correctNull((String) rs
							.getString("AGR_ARTNETWT")));
					arrayGoldCol.add(Helper.correctDouble((String) rs
							.getString("AGR_ARTMKTRATE")));
					arrayGoldCol.add(Helper.correctDouble((String) rs
							.getString("AGR_ESTRATE")));
					arrayGoldCol.add(Helper.correctInt((String) rs
							.getString("agr_quantity")));
					dbESTRATE = Double
							.parseDouble(Helper.correctDouble((String) rs
									.getString("AGR_ESTRATE")));
					dbESTRATE1 = dbESTRATE1 + dbESTRATE;
					arrayGoldCol.add(correctNull((String) rs
							.getString("AGR_ARTQTYTOUCH"))); // 7
					arrayGoldCol.add(correctNull((String) rs
							.getString("AGR_ARTRATE"))); // 8
					arrayGoldRow.add(arrayGoldCol);
				}
				hshRecord.put("arrayGoldRow", arrayGoldRow);
				hshRecord.put("dbESTRATE1", Helper
						.formatDoubleValue(dbESTRATE1));
				/*
				 * End - Gold Ornaments
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Terms & Conditions
				 */
				strQuery = SQLParser.getSqlQuery("apptermscondsel^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					String strTermType = Helper.correctNull((String) rs
							.getString("APP_GENERAL_TERMS_TYPE"));
					arrayTermsCol = new ArrayList();
					arrayTermsCol.add(strTermType);
					arrayTermsCol.add(Helper.correctNull((String) rs
							.getString("APP_TERMSCONTENT")));
					arrayTermsCol.add(Helper.correctNull((String) rs
							.getString("terms_prepost")));
					arrayTermsRow.add(arrayTermsCol);
					arrayTermType.add(strTermType);
				}
				hshRecord.put("arrayTermsRow", arrayTermsRow);
				hshRecord.put("arrayTermType", arrayTermType);
				/*
				 * End - Terms & Conditions
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Sanctioning Authority
				 */
				strQuery = SQLParser.getSqlQuery("sel_date^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSancAuthCode = Helper.correctNull((String) rs
							.getString("appraisal_sancauth"));
					strSancAppraisalDeptCode = Helper.correctNull((String) rs
							.getString("appraisal_department"));
					if (!strSancAppraisalDeptCode.equalsIgnoreCase("")) {
						if (rs != null) {
							rs.close();
						}
						strQuery = SQLParser
								.getSqlQuery("sel_cbsstaticdescbycode^26^"
										+ strSancAppraisalDeptCode);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							strSancAppraisalDept = Helper
									.correctNull((String) rs
											.getString("cbs_static_data_desc"));
						}
					}
				}
				hshRecord.put("strSancAppraisalDept", strSancAppraisalDept);
				if (!strSancAuthCode.equalsIgnoreCase("")) {
					if (rs != null) {
						rs.close();
					}
					strQuery = SQLParser
							.getSqlQuery("sel_cbsstaticdescbycode^15^"
									+ strSancAuthCode);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strSancAuthDesc = Helper.correctNull((String) rs
								.getString("cbs_static_data_desc"));
					}
				}
				hshRecord.put("strSancAuthDesc", strSancAuthDesc);
				/*
				 * End - Sanctioning Authority
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Application Date
				 */
				strQuery = SQLParser.getSqlQuery("sel_inwarddate^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strInwardDate = Helper.correctNull((String) rs
							.getString("inward_createdon"));
				}
				hshRecord.put("strInwardDate", strInwardDate);
				/*
				 * End - Application Date
				 */
				if (rs != null) {
					rs.close();
				}
				/*
				 * Santion / Renewal
				 */
				strQuery = SQLParser.getSqlQuery("sel_RenewFlg^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strRenewFlg = Helper.correctNull((String) rs
							.getString("app_renew_flag"));
					hshRecord.put("app_processdate", Helper.correctNull((String) rs
							.getString("processdate")));
				}
				if (strRenewFlg.equalsIgnoreCase("R")) {
					hshRecord.put("strRenewFlg", "renewal");
				} else {
					hshRecord.put("strRenewFlg", "sanction");
				}
				/*
				 * End - Santion / Renewal
				 */
				/*
				 * Added by Arsath for Security Details if(rs!=null) {
				 * rs.close(); }
				 * 
				 * 
				 * 
				 * strQuery=SQLParser.getSqlQuery("sel_secdetbyappno^"+strAppNo);
				 * rs=DBUtils.executeQuery(strQuery); while(rs.next()) {
				 * arrSecCol = new ArrayList();
				 * arrSecCol.add(Helper.correctNull(
				 * (String)rs.getString("sec_name")));
				 * arrSecCol.add(Helper.correctDouble
				 * ((String)rs.getString("cus_sec_netsecurity")));
				 * arrSecRow.add(arrSecCol); }
				 * hshRecord.put("arrSecRow",arrSecRow);
				 */
				if (rs != null) {
					rs.close();
				}

				// Get EMI Amount
				rs = DBUtils.executeLAPSQuery("selloan_details^" + strAppNo);
				while (rs.next()) {
					hshRecord.put("emi", (correctNull((String) rs
							.getString("emi"))));
				}

				// Get Activity of the Borrower
				strQuery = SQLParser
						.getSqlQuery("sel_applKYCNorms^" + strAppID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("custoccupdesc", correctNull(rs
							.getString("occupationcodedesc")));
				}

				// Get Primary Security Comments
				strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
						+ strAppNo + "^Retailprimarysec");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("cmt_retailprimarycomments", Helper
							.CLOBToString(rs.getClob("cmt_comments")));
				}
				// Get Collateral Security Comments
				strQuery = SQLParser.getSqlQuery("sel_retailcomments^"
						+ strAppNo + "^RetailCollateralsec");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("cmt_retailcollateralcomments", Helper
							.CLOBToString(rs.getClob("cmt_comments")));
				}

				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_allcomments^" + strAppNo
						+ "^repaycomment");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("repaycomments", Helper.CLOBToString(rs
							.getClob("fin_comments")));
				}

				if (rs != null)
					rs.close();

				double dblTotal = 0.00;
				int intInstallment = 0;
				strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"
						+ strAppNo + "^1");
				rs = DBUtils.executeQuery(strQuery);
				ArrayList arrRepaySchedule = new ArrayList();
				while (rs.next()) {
					arrayCol = new ArrayList();
					arrayCol.add(correctNull(rs.getString("TL_FEQUENCY")));
					arrayCol.add(correctNull(rs.getString("TL_NOOFINST")));
					arrayCol.add(correctNull(rs.getString("TL_TOTALAMT")));
					arrayCol.add(correctNull(rs.getString("TL_INSTAMT")));
					dblTotal = dblTotal
							+ Double.parseDouble(Helper
									.correctDouble((String) rs
											.getString("TL_TOTALAMT")));
					arrRepaySchedule.add(arrayCol);
					intInstallment = intInstallment
							+ Integer.parseInt(Helper.correctInt(rs
									.getString("TL_NOOFINST")));
				}
				hshRecord.put("arrRepaySchedule", arrRepaySchedule);
				hshRecord.put("RepaySheduleTotal", jtn.format(dblTotal));
				hshRecord.put("strInstallment", String.valueOf(intInstallment));

				String staffproduct = "";
				if (rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_maxterms^" + strPrdCode);
				if (rs.next()) {
					staffproduct = correctNull(rs.getString("prd_staffprd"));
					hshRecord.put("staffproduct", staffproduct);
				}

				if (staffproduct.equalsIgnoreCase("Y")) {
					if (rs1 != null)
						rs1.close();
					ArrayList arrROI = new ArrayList();
					rs = DBUtils.executeLAPSQuery("rulechoice^fixed^"
							+ strPrdCode+"^O");
					while (rs.next()) {
						rs1 = DBUtils
								.executeLAPSQuery("ruleresult^"
										+ Helper.correctInt(rs
												.getString("prdint_sno")));
						while (rs1.next()) {
							arrayCol = new ArrayList();
							arrayCol.add(correctNull(rs
									.getString("prd_amtrangefrom")));
							arrayCol.add(correctNull(rs
									.getString("prd_amtrangeto")));
							arrayCol
									.add(nf
											.format(Double
													.parseDouble(Helper
															.correctDouble(rs1
																	.getString("prd_baserate")))
													+ Double
															.parseDouble(Helper
																	.correctDouble(rs1
																			.getString("prd_adjust")))));
							arrROI.add(arrayCol);
						}

					}
					hshRecord.put("arrROI", arrROI);
				}
				ArrayList arrOutRow = new ArrayList();
				ArrayList arrOutCol = new ArrayList();
				ArrayList arrOutRowPro = new ArrayList();
				ArrayList arrfacwisecol = new ArrayList();
				ArrayList arrOutColPro = new ArrayList();
				int k = 0, j = 0;
				String strSecid = "";
				if (rs != null) {
					rs.close();
				}
				k = 0;
				j = 0;
				rs = DBUtils
						.executeLAPSQuery("secExisFacilityDetailsView_facwise_ret^"
								+ strAppNo + "^" + "P^A");
				while (rs.next()) {
					arrOutCol = new ArrayList();
					if (correctNull(rs.getString("app_sec_securitytype"))
							.equalsIgnoreCase("1")) {
						if (k == 0) {
							k++;
							arrOutCol.add(strPrdDesc);// 0
							arrOutCol.add("");// 1
							arrOutCol.add(""); // 2
							arrOutCol.add("");// 3
							arrOutRow.add(arrOutCol);
						}
						arrOutCol = new ArrayList();
						arrOutCol.add(correctNull(Helper.CLOBToString(rs
								.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
						arrOutCol.add(correctNull(rs
								.getString("app_sec_securityvalue"))); // 2
						arrOutCol.add(correctNull(rs
								.getString("cus_sec_valuation_date")));// 3
						if (strSecid.equalsIgnoreCase("")) {
							strSecid = "'"
									+ Helper.correctNull((String) rs
											.getString("CUS_SEC_ID")) + "'";
						} else {
							strSecid = strSecid
									+ ",'"
									+ Helper.correctNull((String) rs
											.getString("CUS_SEC_ID")) + "'";
						}
						arrOutRow.add(arrOutCol);
					}
					if (correctNull(rs.getString("app_sec_securitytype"))
							.equalsIgnoreCase("2")) {
						arrOutCol = new ArrayList();
						arrOutCol.add(correctNull(Helper.CLOBToString(rs
								.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
						arrOutCol.add(correctNull(rs
								.getString("app_sec_securityvalue"))); // 2
						arrOutCol.add(correctNull(rs
								.getString("cus_sec_valuation_date")));// 3
						if (strSecid.equalsIgnoreCase("")) {
							strSecid = "'"
									+ Helper.correctNull((String) rs
											.getString("CUS_SEC_ID")) + "'";
						} else {
							strSecid = strSecid
									+ ",'"
									+ Helper.correctNull((String) rs
											.getString("CUS_SEC_ID")) + "'";
						}
						arrOutRowPro.add(arrOutCol);
					}
				}
				hshRecord.put("arrRowPri", arrOutRow);
				hshRecord.put("arrRowColl", arrOutRowPro);
				if (Helper.correctNull((String) hshRecord.get("strLoanType"))
						.equalsIgnoreCase("OD")) {
					hshRecord.put("strWhetherEMI", "No");
					hshRecord.put("strExcHol", "Not Applicable");
					hshRecord.put("strInstallment", "Not Applicable");
					hshRecord.put("strPeriodicity", "Not Applicable");
					hshRecord.put("emi", "Not Applicable");
				}

				if (strprdtype.equalsIgnoreCase("pR")) {
					arrOutRow = new ArrayList();
					strQuery = SQLParser.getSqlQuery("sel_loanagainstdeposit^"
							+ strAppNo);
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						arrOutCol = new ArrayList();
						if (Helper.correctNull(rs.getString("loan_banktype"))
								.equalsIgnoreCase("1")) {
							arrOutCol.add("Own");
						} else {
							arrOutCol.add("3rd Party");
						}
						if (!Helper.correctNull((String) rs.getString(2))
								.equalsIgnoreCase("")) {
							strQuery1 = SQLParser.getSqlQuery("selectorgname^"
									+ Helper.correctNull(rs.getString(2)));
							rs2 = DBUtils.executeQuery(strQuery1);
							if (rs2.next()) {
								arrOutCol.add(Helper.correctNull(rs2
										.getString("org_name")));
							} else {
								arrOutCol.add("");
							}
						} else {
							arrOutCol.add("");
						}
						arrOutCol.add(Helper.correctNull(rs.getString(3)));
						arrOutCol.add(Helper.correctNull(rs.getString(4)));
						arrOutCol.add(Helper.correctNull(rs.getString(5)));
						arrOutCol.add(Helper.correctNull(rs.getString(6)));
						arrOutCol.add(Helper.correctNull(rs.getString(7)));
						arrOutCol.add(Helper.correctNull(rs.getString(8)));
						arrOutCol.add(Helper.correctNull(rs.getString(9)));
						arrOutCol.add(Helper.correctNull(rs.getString(10)));
						arrOutCol.add(Helper.correctNull(rs.getString(11)));
						arrOutCol.add(Helper.correctNull(rs.getString(12)));
						arrOutCol.add(Helper.correctNull(rs.getString(13)));
						arrOutCol.add(Helper.correctNull(rs.getString(14)));
						arrOutRow.add(arrOutCol);
					}
					hshRecord.put("arrDepositRow", arrOutRow);

					if (rs != null)
						rs.close();

					strQuery = SQLParser
							.getSqlQuery("select_loanduedate_depositloan^"
									+ strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						hshRecord.put("strDueDate", Helper.correctNull(rs
								.getString("duedate")));
					}
				}
				hshRecord.put("strprdtype", strprdtype);

				if (rs != null)
					rs.close();

				strQuery = SQLParser.getSqlQuery("selborrowerdet_company^"
						+ strAppID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (Helper.correctNull(
							(String) rs.getString("cominfo_ownership_type"))
							.equalsIgnoreCase("004")) {
						hshRecord
								.put(
										"companyinfo_typeofliability",
										correctNull(Helper
												.CLOBToString(rs
														.getClob("companyinfo_typeofliability"))));
					}
				}

				// processing fee waived
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("selloan_details^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("indinfo_is_staff", correctNull(rs
							.getString("indinfo_is_staff")));
					if (hshRecord.get("indinfo_is_staff").equals("02")) {
						hshRecord.put("strProFeeFlag", "W");
					}
				}

				if (rs != null)
					rs.close();
				strQuery = SQLParser
						.getSqlQuery("sel_per_house_proposed_asset_new^"
								+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("phpa_loan_purpose", correctNull(rs
							.getString("phpa_loan_purpose")));
					hshRecord.put("phpa_project_finance", correctNull(rs
							.getString("phpa_project_finance")));
					if ((Helper.correctNull(
							(String) hshRecord.get("phpa_loan_purpose"))
							.equals("H") && (Helper
							.correctNull((String) hshRecord
									.get("phpa_project_finance")).equals("Y")))) {
						hshRecord.put("strProFeeFlag", "W");
					}
				}
				// Check Deviated Value
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("Sel_app_deviation1^"
						+ strAppNo + "^PF");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (Helper.correctNull(rs.getString("deviation_apprej"))
							.equalsIgnoreCase("A")) {
						hshRecord.put("strProFeeFlag", Helper
								.checkDecimal(Helper.correctDouble(rs
										.getString("deviation_newvalue"))));
					}
				}
				
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_revalidationComments^"+strAppNo+"^1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next()){
					hshRecord.put("APP_REFERENCENO",Helper.correctNull(rs.getString("APP_REFERENCENO")));
				}

				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_product_subcatdesc^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("prd_subcatscheme",Helper.correctNull(rs.getString("CAT_NAME")));
				}
			}
			 

		} catch (Exception e) {
			throw new EJBException("Error in getSanctionLetterData :: "
					+ e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Exception in Closing Connection "
						+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public void updateKeyFactFeesdata(HashMap hshValues)  {
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = "";
		String strAppno = "";
		String strFacSno = "";

		try {
			strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("hidAppNo"));
			}
			strFacSno = Helper.correctNull((String) hshValues
					.get("sel_facilitysno"));

			if (Helper.correctNull((String) hshValues.get("apploantype"))
					.equalsIgnoreCase("P")) {
				strFacSno = "1";
			}
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues.put("size", "3");

				hshQuery.put("strQueryId", "del_keyfactfeedetails");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_keyfactfeedetails");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_onappln")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_duringterm")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_foreclosure")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_refundable")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_conv_charge")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_penalty")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserId")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strOrgShortCode")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserDepartment")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_keyfactfeedetailshistory");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_onappln")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_duringterm")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_foreclosure")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_refundable")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_conv_charge")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_penalty")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserId")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strOrgShortCode")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserDepartment")));
				arrValues.add("Update");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
			}

			else if (strAction.equalsIgnoreCase("delete")) {
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_keyfactfeedetails");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_keyfactfeedetailshistory");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserId")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strOrgShortCode")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("strUserDepartment")));
				arrValues.add("Delete");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
			}

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updatedata");
		} catch (Exception e) {
			throw new EJBException("Error in updateKeyFactFeesdata==="
					+ e.toString());
		}
	}

	public HashMap getKeyFactFeesdata(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null,rs1=null;
		String strAppno = "";
		String strFacSno = "";

		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) hshValues
						.get("hidAppNo"));
			}
			strFacSno = Helper.correctNull((String) hshValues
					.get("sel_facilitysno"));

			if (Helper.correctNull((String) hshValues.get("apploantype"))
					.equalsIgnoreCase("P")) {
				strFacSno = "1";
			}

			strQuery = SQLParser.getSqlQuery("sel_keyfactfeesdata^" + strAppno
					+ "^" + strFacSno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("KF_APP_FEE", Helper.correctNull((String) rs
						.getString("KF_APP_FEE")));
				hshRecord.put("KF_TERM_FEE", Helper.correctNull((String) rs
						.getString("KF_TERM_FEE")));
				hshRecord.put("KF_FORECLOSURE_FEE", Helper
						.correctNull((String) rs
								.getString("KF_FORECLOSURE_FEE")));
				hshRecord.put("KF_REFUND_FEE", Helper.correctNull((String) rs
						.getString("KF_REFUND_FEE")));
				hshRecord.put("KF_CONVERSION_FEE",
						Helper.correctNull((String) rs
								.getString("KF_CONVERSION_FEE")));
				hshRecord.put("KF_PENALTY_FEE", Helper.correctNull((String) rs
						.getString("KF_PENALTY_FEE")));
			}
			hshRecord.put("strFacSno", strFacSno);
			
			String strSancDept="",strProcessDate="",strFacFlag="";
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_productcode^"+strAppno);
			if(rs.next())
			{
				strProcessDate=Helper.correctNull(rs.getString("app_processdate"));
			}

			if (rs != null)
				rs.close();
			if (Helper.correctNull((String) hshValues.get("apploantype"))
					.equalsIgnoreCase("P")) {
				rs = DBUtils.executeLAPSQuery("selecttakeover^" + strAppno);
				if (rs.next()) {
					hshRecord.put("KF_APP_FEE", Helper.checkDecimal(Helper
							.correctDouble(rs.getString("loan_profee"))));
				}
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_date^"+strAppno);
				if(rs.next())
				{
					strSancDept=Helper.correctNull(rs.getString("appraisal_department"));
				}
			} else {
				rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"
						+ strAppno);
				if (rs.next()) {
					hshRecord.put("KF_APP_FEE", Helper.checkDecimal(Helper
							.correctDouble(rs.getString("com_processingfee"))));
					
					strSancDept=Helper.correctNull(rs.getString("com_sancdept"));
					
					if(!Helper.correctNull(rs.getString("COM_PERTAINS_BRANCH")).equalsIgnoreCase(""))
					{
						rs1=DBUtils.executeLAPSQuery("selectorgname^"+Helper.correctNull(rs.getString("COM_PERTAINS_BRANCH")));
						if(rs1.next())
						{
							hshRecord.put("strPertainsBranch",Helper.correctNull(rs1.getString("org_code")));
						}
					}
				}
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_chck_lst_doc^"+ strAppno+"^"+strFacSno);
				if(rs.next())
				{
					if(!Helper.correctNull(rs.getString("FAC_PROCESSDATE")).equalsIgnoreCase("") && !strProcessDate.equalsIgnoreCase(Helper.correctNull(rs.getString("FAC_PROCESSDATE"))))
					{
						strFacFlag="P";
					}
					hshRecord.put("strForexFac",Helper.correctNull(rs.getString("COM_FOREXFAC")));
				}
			}
			
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_disbbranchname^"+ strAppno+"^"+strFacSno);
			if(rs.next())
			{
				hshRecord.put("strDisbBranch",Helper.correctNull(rs.getString("org_code")));
			}

			if (rs != null)
				rs.close();
			String strUserorg = "", strOrgCode = Helper
					.correctNull((String) hshValues.get("strOrgCode"));

			strQuery = SQLParser.getSqlQuery("sel_sanc_authority^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strUserorg = Helper.correctNull(rs.getString("org_code"));
			}

			hshRecord.put("strSancOrgCode",strUserorg);
			hshRecord.put("strSancDept",strSancDept);
			hshRecord.put("strPostFacFlag",strFacFlag);

			if (rs != null)
				rs.close();
		} catch (Exception e) {
			throw new EJBException("Error in getKeyFacrFeesdata==="
					+ e.toString());
		}
		return hshRecord;
	}

	// This code is used for BankAccounts Colletarl details

	// ArrayList vecBankColl=new ArrayList();
	// ArrayList vecBankColletral=new ArrayList();
	// strQuery=SQLParser.getSqlQuery("pergetfinancialbnkcoll^"+appno);
	// if(rs!=null)
	// {
	// rs.close();
	// }
	// rs=DBUtils.executeQuery(strQuery);
	// 
	// String bankapptype="";
	// String bankapptype1="";
	// String fname="";
	// while (rs.next())
	// {
	// vecBankColl=new ArrayList();
	// vecBankColl.add(correctNull((String)rs.getString("bank_appno")));
	// bankapptype=correctNull((String)rs.getString("bank_apptype"));
	// if(!bankapptype.equals("")){
	// bankapptype1=bankapptype.substring(1);
	// }
	//	 
	// strQuery=SQLParser.getSqlQuery("perfinancialbnk^"+appno+"^"+bankapptype1);
	// rs10=DBUtils.executeQuery(strQuery);
	//	 
	// if(rs10.next())
	// {
	// fname=correctNull((String)rs10.getString("appname"));
	// }
	// String name=fname;
	// vecBankColl.add(name);
	// vecBankColl.add(correctNull((String)rs.getString("bank_serialno")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_name")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_accntno")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_accnttype")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_balance")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_iscoll")));
	// vecBankColl.add(correctNull((String)rs.getString("bank_yrsacchold")));
	// vecBankColl.add(correctNull((String)rs.getString("remarks")));
	// vecBankColletral.add(vecBankColl);
	// }
	// hshRecord.put("vecBankColletral",vecBankColletral);
	//
	// //This code is used for Investment details
	//
	// ArrayList vecInvest=new ArrayList();
	// ArrayList vecInvestment=new ArrayList();
	// String Insname="";
	// strQuery=SQLParser.getSqlQuery("selInvestmentdet^"+appno);
	// rs=DBUtils.executeQuery(strQuery);
	// while(rs.next())
	// {
	// vecInvest=new ArrayList();
	// String stoc_applnt=correctNull((String)rs.getString("stoc_applnt"));
	// String stocapplnt=stoc_applnt.substring(1);
	// strQuery=SQLParser.getSqlQuery("perfinancialbnk^"+appno+"^"+stocapplnt);
	// rs10=DBUtils.executeQuery(strQuery);
	// if(rs10.next())
	// {
	// Insname=correctNull((String)rs10.getString("appname"));
	// }
	// vecInvest.add(Insname);
	// vecInvest.add(correctNull((String)rs.getString("stoc_desc")));
	// vecInvest.add(correctNull((String)rs.getString("stoc_shareval")));
	// vecInvest.add(correctNull((String)rs.getString("stoc_noofshares")));
	// vecInvest.add(correctNull((String)rs.getString("stoc_dateofissue")));
	// vecInvest.add(correctNull((String)rs.getString("stoc_dateofmaturity")));
	// vecInvest.add(correctNull((String)rs.getString("stoc_amount")));
	// vecInvestment.add(vecInvest);
	// }
	// hshRecord.put("vecInvestment",vecInvestment);
	//
	// //This Code is used for Insurence Policies
	//
	// String insu_applnt="",insuapplnt="";
	// //ArrayList vecInsu=new ArrayList();
	// //ArrayList vecInsurence=new ArrayList();
	// strQuery=SQLParser.getSqlQuery("selInsurencepolicies^"+appno);
	// rs=DBUtils.executeQuery(strQuery);
	// while(rs.next())
	// {
	// //vecInsu=new ArrayList();
	// insu_applnt=((String)rs.getString("insu_applnt"));
	// insuapplnt=insu_applnt.substring(1);
	// strQuery=SQLParser.getSqlQuery("perfinancialbnk^"+appno+"^"+insuapplnt);
	// rs10=DBUtils.executeQuery(strQuery);
	// if(rs10.next())
	// {
	// Insname=correctNull((String)rs10.getString("appname"));
	// }
	// vecInvest.add(Insname);
	// vecInvest.add(correctNull((String)rs.getString("insu_policyno")));
	// vecInvest.add(correctNull((String)rs.getString("insu_surrenderval")));
	// vecInvest.add(correctNull((String)rs.getString("insu_agencyname")));
	// vecInvest.add(correctNull((String)rs.getString("insu_agencyphone")));
	// vecInvest.add(correctNull((String)rs.getString("insu_matdate")));
	// vecInvest.add(correctNull((String)rs.getString("insu_prepaid")));
	//	
	// }
	// hshRecord.put("vecInvest",vecInvest);
	// strQuery = SQLParser.getSqlQuery("creditGurtotmeans^"+appno);
	// rs=DBUtils.executeQuery(strQuery);
	// ArrayList vecValtot1=new ArrayList();
	// while(rs.next())
	// {
	// ArrayList vecDatatot1 = new ArrayList();
	// vecDatatot1
	// .add(Helper.correctNull((String)rs.getString("CR_Total_MEANS")));
	// vecValtot1.add(vecDatatot1);
	// }
	// hshRecord.put("vecValtot1",vecValtot1);
	// String
	// orgcode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
	// String strRegion="";
	// if(!strorglevel.equalsIgnoreCase("C")){
	// String orgStartcode=orgcode.substring(0,6);
	// orgStartcode=orgStartcode+"%";
	// if(rs!=null)
	// {
	// rs.close();
	// }
	// rs=DBUtils.executeLAPSQuery("sel_region^"+orgStartcode);
	// if (rs.next())
	// {
	// strRegion=rs.getString("org_name");
	// }
	// }
	// hshRecord.put("Region_Name",strRegion);

	public HashMap getKeyFactStatementData(HashMap hshValues)
			 {
		ArrayList arrproposed = new ArrayList();
		ArrayList arrOutColPro = new ArrayList();
		ArrayList arrOutRow = new ArrayList();
		ArrayList arrOutCol = new ArrayList();
		ArrayList arrOutRowPro = new ArrayList();

		ArrayList arrBorrarr = new ArrayList();
		ArrayList arrBorrcol = new ArrayList();

		HashMap hshRecord = new HashMap();
		ResultSet rs = null, rs1 = null;
		String strModuleType = Helper.correctNull((String) hshValues
				.get("sessionModuleType"));
		String strSlNo = Helper.correctInt((String) hshValues.get("hidSNo"));
		String strAppno = Helper.correctNull((String) hshValues.get("appno"));
		String strQuery = "", strPeriodicity = "", strPendingPaymentMode = "";
		String strIntIndexid = "";
		String strMCLRtype = "";
		String strMCLRPercnt = "";
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		int intTenor = 0, intHolidayPeriod = 0, intDiff = 0;
		double dblIntrRate = 0.00, dblBaseRate = 0.00;
		double dblSancamt = 0.00, dblEI = 0.00;
		try {
			String strCurrentDate = Helper.getCurrentDateTime();
			String strMonth = "", strYear = "";
			if (strCurrentDate.length() >= 10) {
				strMonth = strCurrentDate.substring(3, 5);
				strYear = strCurrentDate.substring(6, 10);
			}
			int intMonth = Integer.parseInt(Helper.correctInt(strMonth));
			int intYear = Integer.parseInt(Helper.correctInt(strYear));
			if (intMonth > 3)
				intYear = intYear++;
			if (strModuleType.equalsIgnoreCase("CORP")
					|| strModuleType.equalsIgnoreCase("AGR")) {
				strQuery = SQLParser.getSqlQuery("sel_cusdetails_corp_KFS^"
						+ strAppno + "^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrBorrcol = new ArrayList();
					arrBorrcol.add(Helper.correctNull((String) rs
							.getString("type_desc")));
					arrBorrcol.add(Helper.correctNull((String) rs
							.getString("name")));
					arrBorrarr.add(arrBorrcol);
				}

				hshRecord.put("arrBorrarr", arrBorrarr);

				if (rs != null)
					rs.close();

				strQuery = SQLParser.getSqlQuery("sel_keyfactfeesdata^"
						+ strAppno + "^" + strSlNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("KF_APP_FEE", Helper.correctNull((String) rs
							.getString("KF_APP_FEE")));
					hshRecord.put("KF_TERM_FEE", Helper.correctNull((String) rs
							.getString("KF_TERM_FEE")));
					hshRecord.put("KF_FORECLOSURE_FEE", Helper
							.correctNull((String) rs
									.getString("KF_FORECLOSURE_FEE")));
					hshRecord.put("KF_REFUND_FEE",
							Helper.correctNull((String) rs
									.getString("KF_REFUND_FEE")));
					hshRecord.put("KF_CONVERSION_FEE", Helper
							.correctNull((String) rs
									.getString("KF_CONVERSION_FEE")));
					hshRecord.put("KF_PENALTY_FEE", Helper
							.correctNull((String) rs
									.getString("KF_PENALTY_FEE")));
				}

				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"
						+ strAppno);
				if (rs.next()) {
					hshRecord.put("strProcessingFee", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("com_processingfee")))));
				}

				strQuery = SQLParser.getSqlQuery("sel_facdetails_KFS^"
						+ strAppno + "^" + strSlNo);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strPeriodicity = correctNull(rs
							.getString("facility_repaytype"));
					strMCLRtype = correctNull(rs.getString("mclr_type"));
					strIntIndexid = correctNull(rs
							.getString("facility_intsubtype"));
					hshRecord.put("int_comm", Helper.correctNull(Helper
							.CLOBToString(rs.getClob("int_comm_comments"))));
					dblSancamt = Double.parseDouble(Helper.correctDouble(rs
							.getString("facility_sancamt")));
					dblIntrRate = Double.parseDouble(Helper.correctDouble(rs
							.getString("facility_sancinterest")));
					hshRecord
							.put("strModifiedInterest", nf.format(dblIntrRate));
					dblBaseRate = Double.parseDouble(Helper.correctDouble(rs
							.getString("facility_baserate")));
					intTenor = Integer.parseInt(Helper.correctInt(rs
							.getString("facility_months")));
					intHolidayPeriod = Integer.parseInt(Helper.correctInt(rs
							.getString("facility_holidayperiod")));
					intTenor = intTenor - intHolidayPeriod;
					hshRecord.put("strTenor", String.valueOf(intTenor));
					hshRecord.put("strHolidayPeriod", String
							.valueOf(intHolidayPeriod));

					strPeriodicity = correctNull(rs
							.getString("facility_repaytype"));
					strPendingPaymentMode = correctNull(rs
							.getString("facility_interestcharged"));
					String strTemp = "0";
					double dblRate = 0.00, dblDenomi = 0.00, dblNumeri = 0.00, dblEMI = 0.00;

					if (!strPeriodicity.equalsIgnoreCase("E")) {
						String strQuery1 = SQLParser
								.getSqlQuery("sel_tl_repayschedule^" + strAppno
										+ "^" + strSlNo);
						if (rs1 != null)
							rs1.close();
						arrOutRow = new ArrayList();
						rs1 = DBUtils.executeQuery(strQuery1);
						while (rs1.next()) {
							arrOutCol = new ArrayList();
							arrOutCol.add(correctNull(rs1
									.getString("TL_NOOFINST")));
							arrOutCol.add((nf.format(Double
									.parseDouble(Helper.correctDouble(rs1
											.getString("TL_INSTAMT"))))));
							arrOutRow.add(arrOutCol);
							strTemp = "13";
						}
						hshRecord.put("arrRow", arrOutRow);
					}
					if (strPeriodicity.equalsIgnoreCase("E")) {
						strTemp = "1";
						strPeriodicity = "EMI";
						dblRate = dblIntrRate / (12 * 100);
						double dblRmdamt = 0.0, dblInterestAmt = 0.0;
						dblRmdamt = dblSancamt;
						if ((intHolidayPeriod > 0)
								&& strPendingPaymentMode.equalsIgnoreCase("2")) {
							for (int k = 0; k < intHolidayPeriod; k++) {
								dblInterestAmt = (dblRmdamt * dblRate);
								dblRmdamt = dblRmdamt + dblInterestAmt;
							}

						}

						dblDenomi = Math.pow(dblRate + 1, (intTenor)) - 1;
						dblNumeri = dblRate * Math.pow(dblRate + 1, (intTenor));
						dblEMI = 0.00;
						if (dblNumeri != 0.0 && dblDenomi != 0.0) {
							dblEMI = Math.ceil((dblNumeri / dblDenomi)
									* dblRmdamt);
						}
						hshRecord.put("strEMIamt", nf.format(dblEMI));
					} else if (strPeriodicity.equalsIgnoreCase("NE")) {
						strPeriodicity = "Non-EMI";
					} else if (strPeriodicity.equalsIgnoreCase("OD")) {
						strPeriodicity = "On Demand";
					} else if (strPeriodicity.equalsIgnoreCase("LC")) {
						strPeriodicity = "As Per LC Terms";
					} else if (strPeriodicity.equalsIgnoreCase("CO")) {
						strPeriodicity = "As Per Contract Terms";
					} else if (strPeriodicity.equalsIgnoreCase("BG")) {
						strPeriodicity = "As Per BG Rules";
					} else if (strPeriodicity.equalsIgnoreCase("DD")) {
						strPeriodicity = "On Due Date";
					} else if (strPeriodicity.equalsIgnoreCase("PC")) {
						strPeriodicity = "From the proceeds of PSC / by realization of bill";
					} else if (strPeriodicity.equalsIgnoreCase("PS")) {
						strPeriodicity = "By Realization of Export Bills";
					} else if (strPeriodicity.equalsIgnoreCase("PR")) {
						strPeriodicity = "By Realization of Respective Bills";
					} else if (strPeriodicity.equalsIgnoreCase("TG")) {
						strPeriodicity = "As per TCBG Rules";
					} else {
						strPeriodicity = "Not Applicable";
					}
					hshRecord.put("strPeriodicity", strTemp);
					strTemp = correctNull(rs.getString("facility_inttype"));
					if (strTemp.equalsIgnoreCase("flo"))
						strTemp = "Floating";
					else
						strTemp = "Fixed";
					hshRecord.put("strInterestType", strTemp);
					hshRecord.put("strPeriodicitydesc", strPeriodicity);
					hshRecord.put("strIntIndexid", strIntIndexid);

					dblIntrRate = dblIntrRate - dblBaseRate;
					hshRecord.put("strInterest", nf.format(dblIntrRate));

					if (correctNull(rs.getString("com_headfac"))
							.equalsIgnoreCase("1")) {
						dblSancamt = dblSancamt / 50;
					}
					hshRecord.put("strSancAmt", nf.format(dblSancamt));
					hshRecord.put("strDesc", Helper.correctNull(rs
							.getString("facility_displaydesc")));
					// hshRecord.put("strProcessingFee","0.00");
					hshRecord.put("strMCLRtype_ID", strMCLRtype);
					if (!correctNull(rs.getString("FACILITY_MCLRTYPE"))
							.equalsIgnoreCase("")) {
						strMCLRPercnt = correctNull(
								rs.getString("FACILITY_MCLRTYPE")).split("@")[1];
					}
					hshRecord.put("strMCLRpercent", strMCLRPercnt);
					hshRecord.put("strMCLRsplit", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("facility_sancinterest")))
							- Double.parseDouble(Helper
									.correctDouble(strMCLRPercnt))));

					if (strMCLRtype.equalsIgnoreCase("O"))
						hshRecord.put("strMCLRtype", "One day MCLR");
					else if (strMCLRtype.equalsIgnoreCase("M"))
						hshRecord.put("strMCLRtype", "Monthly MCLR");
					else if (strMCLRtype.equalsIgnoreCase("Q"))
						hshRecord.put("strMCLRtype", "Quartely MCLR");
					else if (strMCLRtype.equalsIgnoreCase("H"))
						hshRecord.put("strMCLRtype", "Half yearly MCLR");
					else if (strMCLRtype.equalsIgnoreCase("Y"))
						hshRecord.put("strMCLRtype", "Yearly MCLR");
				}

			} else {
				strQuery = SQLParser.getSqlQuery("sel_cusdetails_ret_KFS^"
						+ strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrBorrcol = new ArrayList();
					arrBorrcol.add(Helper.correctNull((String) rs
							.getString("DEMO_TYPE")));
					arrBorrcol.add(Helper.correctNull((String) rs
							.getString("name")));
					arrBorrarr.add(arrBorrcol);
				}

				hshRecord.put("arrBorrarr", arrBorrarr);

				strQuery = SQLParser.getSqlQuery("sel_keyfactfeesdata^"
						+ strAppno + "^1");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("KF_APP_FEE", Helper.correctNull((String) rs
							.getString("KF_APP_FEE")));
					hshRecord.put("KF_TERM_FEE", Helper.correctNull((String) rs
							.getString("KF_TERM_FEE")));
					hshRecord.put("KF_FORECLOSURE_FEE", Helper
							.correctNull((String) rs
									.getString("KF_FORECLOSURE_FEE")));
					hshRecord.put("KF_REFUND_FEE",
							Helper.correctNull((String) rs
									.getString("KF_REFUND_FEE")));
					hshRecord.put("KF_CONVERSION_FEE", Helper
							.correctNull((String) rs
									.getString("KF_CONVERSION_FEE")));
					hshRecord.put("KF_PENALTY_FEE", Helper
							.correctNull((String) rs
									.getString("KF_PENALTY_FEE")));
				}

				strQuery = SQLParser
						.getSqlQuery("selectretail_KFS^" + strAppno);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSlNo = Helper.correctNull(rs.getString("app_prdcode"));
					intTenor = Integer.parseInt(Helper.correctInt(rs
							.getString("loan_reqterms")));
					intHolidayPeriod = Integer.parseInt(Helper.correctInt(rs
							.getString("loan_noofinstallment")));
					intTenor = intTenor - intHolidayPeriod;
					dblIntrRate = Double.parseDouble(Helper.correctDouble(rs
							.getString("loan_modintrate")));
					hshRecord
							.put("strModifiedInterest", nf.format(dblIntrRate));
					dblBaseRate = Double.parseDouble(Helper.correctDouble(rs
							.getString("LOAN_BASERATE")));
					dblIntrRate = dblIntrRate - dblBaseRate;
					hshRecord.put("strInterest", nf.format(dblIntrRate));
					strPeriodicity = Helper.correctNull(rs
							.getString("loan_repaymenttype"));
					//strIntIndexid = Helper.correctNull(rs.getString("PRD_INTERESTID"));
					dblSancamt = Double.parseDouble(Helper.correctDouble(rs
							.getString("loan_recmdamt")));
					strMCLRtype = correctNull(rs.getString("mclr_type"));
					if (!correctNull(rs.getString("LOAN_MCLRTYPE"))
							.equalsIgnoreCase("")) {
						strMCLRPercnt = correctNull(
								rs.getString("LOAN_MCLRTYPE")).split("@")[1];
					}
					hshRecord.put("strMCLRpercent", strMCLRPercnt);
					hshRecord.put("strMCLRsplit", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("loan_modintrate")))
							- Double.parseDouble(Helper
									.correctDouble(strMCLRPercnt))));
					hshRecord.put("strMCLRtype_ID", strMCLRtype);

					if (strMCLRtype.equalsIgnoreCase("O"))
						hshRecord.put("strMCLRtype", "One day MCLR");
					else if (strMCLRtype.equalsIgnoreCase("M"))
						hshRecord.put("strMCLRtype", "Monthly MCLR");
					else if (strMCLRtype.equalsIgnoreCase("Q"))
						hshRecord.put("strMCLRtype", "Quartely MCLR");
					else if (strMCLRtype.equalsIgnoreCase("H"))
						hshRecord.put("strMCLRtype", "Half yearly MCLR");
					else if (strMCLRtype.equalsIgnoreCase("Y"))
						hshRecord.put("strMCLRtype", "Yearly MCLR");

					if (!strPeriodicity.equalsIgnoreCase("1")) {
						String strQuery1 = SQLParser
								.getSqlQuery("sel_tl_repayschedule^" + strAppno
										+ "^1");
						if (rs1 != null)
							rs1.close();
						arrOutRow = new ArrayList();
						rs1 = DBUtils.executeQuery(strQuery1);
						while (rs1.next()) {
							arrOutCol = new ArrayList();
							arrOutCol.add(correctNull(rs1
									.getString("TL_NOOFINST")));
							arrOutCol.add((nf.format(Double
									.parseDouble(Helper.correctDouble(rs1
											.getString("TL_INSTAMT"))))));
							arrOutRow.add(arrOutCol);
						}
						hshRecord.put("arrRow", arrOutRow);
					}

					if (strPeriodicity.equalsIgnoreCase("13")) {
						dblEI = dblSancamt / intTenor;
						hshRecord.put("strInstallmentAmt", nf.format(dblEI));
					}
					hshRecord.put("strPeriodicity", strPeriodicity);
					if (strPeriodicity.equalsIgnoreCase("1")) {
						strPeriodicity = "EMI";
					} else if (strPeriodicity.equalsIgnoreCase("2")) {
						strPeriodicity = "Non-EMI";
					} else if (strPeriodicity.equalsIgnoreCase("3")) {
						strPeriodicity = "Graduated installments";
					} else if (strPeriodicity.equalsIgnoreCase("4")) {
						strPeriodicity = "Step Up";
					} else if (strPeriodicity.equalsIgnoreCase("5")) {
						strPeriodicity = "Step Down";
					} else if (strPeriodicity.equalsIgnoreCase("6")) {
						strPeriodicity = "Taper Down";
					} else if (strPeriodicity.equalsIgnoreCase("7")) {
						strPeriodicity = "Balloon";
					} else if (strPeriodicity.equalsIgnoreCase("9")) {
						strPeriodicity = "Flip Method";
					} else if (strPeriodicity.equalsIgnoreCase("10")) {
						strPeriodicity = "Equal Installments";
					} else if (strPeriodicity.equalsIgnoreCase("11")) {
						strPeriodicity = "Slab";
					} else if (strPeriodicity.equalsIgnoreCase("12")) {
						strPeriodicity = "OverDraft";
					} else if (strPeriodicity.equalsIgnoreCase("13")) {
						strPeriodicity = "Equal Monthly Installments";
					} else if (strPeriodicity.equalsIgnoreCase("8")) {
						strPeriodicity = "On Due Date";
					} else {
						strPeriodicity = "Not Applicable";
					}
					hshRecord.put("strSancAmt", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("loan_recmdamt")))));
					hshRecord.put("strTenor", String.valueOf(intTenor));
					hshRecord.put("strHolidayPeriod", String
							.valueOf(intHolidayPeriod));
					hshRecord.put("strInterestType", Helper.correctNull(rs
							.getString("loan_inttype")));
					hshRecord.put("strPeriodicitydesc", strPeriodicity);
					hshRecord.put("strIntIndexid", strIntIndexid);
					hshRecord.put("strEMIamt", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("loan_emi")))));
					String strRepayment = Helper.correctNull(rs
							.getString("loan_periodicity"));
					if (!strRepayment.equalsIgnoreCase("m")) {
						if (strRepayment.equalsIgnoreCase("h")) {
							intDiff = intTenor / 6;
							if (intTenor % 6 > 0)
								intDiff++;
						} else if (strRepayment.equalsIgnoreCase("q")) {
							intDiff = intTenor / 3;
							if (intTenor % 3 > 0)
								intDiff++;
						} else if (strRepayment.equalsIgnoreCase("y")) {
							intDiff = intTenor / 12;
							if (intTenor % 12 > 0)
								intDiff++;
						}

						dblEI = dblSancamt / intDiff;
						hshRecord.put("strInstallmentAmt", String
								.valueOf(dblEI));
					}
					hshRecord.put("strDesc", Helper.correctNull(rs
							.getString("category"))
							+ "-"
							+ Helper.correctNull(rs.getString("subcategory")));
					hshRecord.put("strProcessingFee", nf.format(Double
							.parseDouble(Helper.correctDouble(rs
									.getString("loan_profee")))));
				}
			}
			hshRecord.put("strFinancialyr", "01/04/" + intYear + " - 07/04/"
					+ intYear);
			hshRecord.put("appno", strAppno);

			int k = 0;
			int j = 0;
			arrOutRow = new ArrayList();
			if (strModuleType.equalsIgnoreCase("CORP")
					|| strModuleType.equalsIgnoreCase("AGR")) {
				rs = DBUtils.executeLAPSQuery("secFacilityDetails_facwise_KFS^"
						+ strAppno + "^" + "P" + "^" + strSlNo);
			} else {
				rs = DBUtils
						.executeLAPSQuery("secFacilityDetails_facwise_KFS_ret^"
								+ strAppno + "^" + "P");
			}

			while (rs.next()) {
				arrOutCol = new ArrayList();
				if (correctNull(rs.getString("app_sec_securitytype"))
						.equalsIgnoreCase("1")) {
					arrOutCol = new ArrayList();
					arrOutCol.add(correctNull(Helper.CLOBToString(rs
							.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
					arrOutCol.add(correctNull(rs
							.getString("app_sec_securityvalue"))); // 2
					arrOutCol.add(correctNull(rs
							.getString("cus_sec_valuation_date")));// 3
					arrOutRow.add(arrOutCol);
				}
				if (correctNull(rs.getString("app_sec_securitytype"))
						.equalsIgnoreCase("2")) {
					arrOutCol = new ArrayList();
					arrOutCol.add(correctNull(Helper.CLOBToString(rs
							.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));// 1
					arrOutCol.add(correctNull(rs
							.getString("app_sec_securityvalue"))); // 2
					arrOutCol.add(correctNull(rs
							.getString("cus_sec_valuation_date")));// 3
					arrOutRowPro.add(arrOutCol);
				}
			}
			if (arrOutRow.size() > 0)
				arrproposed.add(arrOutRow);
			if (arrOutRowPro.size() > 0)
				arrOutColPro.add(arrOutRowPro);
			hshRecord.put("arrproposedFacility", arrproposed);
			hshRecord.put("arrproposedCollateralSec", arrOutColPro);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selworkflow^" + strAppno);
			if (rs.next()) {
				hshRecord.put("strInwardBranch", Helper.correctNull(rs
						.getString("org_name")));
			}

			// processing fee waived
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selloan_details^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("indinfo_is_staff", correctNull(rs
						.getString("indinfo_is_staff")));
				if (hshRecord.get("indinfo_is_staff").equals("02")) {
					hshRecord.put("strProFeeFlag", "W");
				}
			}

			if (rs != null)
				rs.close();
			strQuery = SQLParser
					.getSqlQuery("sel_per_house_proposed_asset_new^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("phpa_loan_purpose", correctNull(rs
						.getString("phpa_loan_purpose")));
				hshRecord.put("phpa_project_finance", correctNull(rs
						.getString("phpa_project_finance")));
				if ((Helper.correctNull(
						(String) hshRecord.get("phpa_loan_purpose"))
						.equals("H") && (Helper.correctNull((String) hshRecord
						.get("phpa_project_finance")).equals("Y")))) {
					hshRecord.put("strProFeeFlag", "W");
				}
			}
			// Check Deviated Value
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("Sel_app_deviation1^" + strAppno
					+ "^PF");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if (Helper.correctNull(rs.getString("deviation_apprej"))
						.equalsIgnoreCase("A")) {
					hshRecord
							.put("strProFeeFlag", Helper.checkDecimal(Helper
									.correctDouble(rs
											.getString("deviation_newvalue"))));
				}
			}

		} catch (Exception e) {
			throw new EJBException("Error in getKeyFactStatementData :: "
					+ e.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Exception in Closing Connection "
						+ e.getMessage());
			}
		}
		return hshRecord;

	}
}
