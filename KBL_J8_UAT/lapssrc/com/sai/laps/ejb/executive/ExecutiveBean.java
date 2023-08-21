package com.sai.laps.ejb.executive;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.text.*;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.ejb.combobassessment.ComBobAssessmentBean;
import com.sai.laps.ejb.exceltolaps.ExcelToLapsBean;

@Stateless(name = "ExecutiveBean", mappedName = "ExecutiveHome")
@Remote (ExecutiveRemote.class)
public class ExecutiveBean extends BeanAdapter {
	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ExecutiveBean.class);

	public HashMap getData(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		boolean bstate = false;
		String recordflag = "N";

		try {
			appno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("execsel_port^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			bstate = rs.next();
			if (bstate) {
				recordflag = "Y";
				hshRecord.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
				hshRecord.put("due_diligence", correctNull(rs.getString("due_diligence")));
				hshRecord.put("credit_since", correctNull(rs.getString("credit_since")));
				hshRecord.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
				hshRecord.put("exec_date", correctNull(rs.getString("exec_date")));
				hshRecord.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
				hshRecord.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
				hshRecord.put("exec_comments_sisterconcern", correctNull(rs.getString("exec_comments_sisterconcern")));
				hshRecord.put("sel_borrowertype", correctNull(rs.getString("exec_borrowertype")));
				hshRecord.put("selsancauth", correctNull(rs.getString("exec_sancauth")));
				hshRecord.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
				hshRecord.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
				hshRecord.put("exec_refno", correctNull(rs.getString("exec_refno")));
				hshRecord.put("present_req", correctNull(rs.getString("exec_presentreq")));

				if (rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("selcreditreport2^"+appno+"^"+"1");
				if (rs.next())
				{
					hshRecord.put("means",correctNull(rs.getString("CR_Total_MEANS")));
					hshRecord.put("asondate",correctNull(rs.getString("cr_meansason")));
				}
				else 
				{
					hshRecord.put("means","0.00");
				}
			} 
			hshRecord.put("recordflag", recordflag);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground_sec^"+appno);
			if (rs.next())
			{
				hshRecord.put("com_format",correctNull(rs.getString("com_format")));
				hshRecord.put("com_amountvalue",correctNull(rs.getString("com_amountvalue")));
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_mclr^"+appno);
			if (rs.next())
			{
				hshRecord.put("strMCLRFlag","Y");
			}
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_corpagriappid^"+appno+"^"+appno);
			while(rs.next())
			{
				if(rs1!=null)
					rs1.close();
				strQuery = SQLParser.getSqlQuery("due_report_sel^"+appno+"^"+correctNull(rs.getString("demo_appid")));
				rs1=DBUtils.executeQuery(strQuery);
				if(!rs1.next())
				{
					hshRecord.put("strDDRAppFlag","N");
				}
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_ddr_generalinfo^"+ appno);
			if(!rs.next())
			{
				hshRecord.put("strDDRGeneralInfo","N");
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_cbsaccno^"+ appno);
			if(rs.next())
			{
				hshRecord.put("app_termflag",correctNull(rs.getString("app_termflag")));
				hshRecord.put("strCreatedDate",correctNull(rs.getString("APP_CREATEDATE")));
			}
			
			
			strQuery = SQLParser.getSqlQuery("chk_geclfacchk^"+appno);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
					hshRecord.put("strgeclavailable","Y");
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("063"))
					hshRecord.put("strMMithra","Y");
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("065"))
					hshRecord.put("strCgssd","Y");
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("064"))
					hshRecord.put("strSvanidh","Y");
			}
		
			strQuery = SQLParser.getSqlQuery("sel_wcdpnfac^"+appno);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_ID")).equalsIgnoreCase("98"))
					hshRecord.put("strDPN2020","Y");	
			}
			if(rs!=null){
				rs.close();
			}
			String corprestructureval="N";
			strQuery = SQLParser.getSqlQuery("sel_rest_assess_selection^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				corprestructureval="Y";
				
			}
			hshRecord.put("corprestructureval",corprestructureval);


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
		hshRecord.put("hidapplicantid", correctNull((String)hshValues.get("hidapplicantnewid")));
		hshRecord.put("appno", correctNull((String)hshValues.get("appno")));
		return hshRecord;
	}

	public HashMap getData3(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";

		try {
			appno = correctNull((String) hshValues.get("appno"));

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			strQuery = SQLParser.getSqlQuery("execsel_summary^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("EXEC_EVAL_MAGMT", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_MAGMT"))));
				hshRecord.put("EXEC_EVAL_INDUSTRY", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_INDUSTRY"))));
				hshRecord.put("EXEC_EVAL_BUSSINESSRISK", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_BUSSINESSRISK"))));
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

	public void updateData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();

		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));
		String strCategory = (String) hshValues.get("hidCategoryType");
		
		int intUpdatesize = 0;
		try {
			if (strAction.trim().equals("edit")) {
				// to delete old values in the exec_portfolio table
				intUpdatesize = intUpdatesize + 1;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "execdel_port");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				/* ************************************************************** */
				if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("SRE"))
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "delcreditreport2");
					arrValues.add(appno);
					arrValues.add("1");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				}
				/* *************************************************************** */
				// to insert values in the exec_portfolio table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				//hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQuery.put("strQueryId", "execins_port");
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String) hshValues.get("cmd_searchreport")));
				arrValues.add(Helper.correctNull((String) hshValues.get("due_diligence")));
				arrValues.add(Helper.correctNull((String) hshValues.get("credit_since")));
				arrValues.add(Helper.correctNull((String) hshValues.get("audit_notes")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_exedate")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_guaranteoffered")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_applicantguarantee")));
				arrValues.add(Helper.correctNull((String) hshValues.get("comment_sisterconcern")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_borrowertype")));
				arrValues.add(Helper.correctNull((String) hshValues.get("selsancauth")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_agenda")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_mcm")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_refno")));
				arrValues.add(Helper.correctNull((String) hshValues.get("present_req")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				// to delete old values in the exec_guarantor table
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				intUpdatesize = intUpdatesize + 1;
//				//hshQueryValues.put("size", Integer.toString(intUpdatesize));
//				hshQuery.put("strQueryId", "exec_guadetailsdel");
//				arrValues.add(appno);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);

				// to insert old values in the exec_guarantor table
//				for (int i = 0; i < StrGuarantor.length; i++) {
//					if (!StrGuarantor[i].equals("")) {
//						intUpdatesize = intUpdatesize + 1;
//						hshQuery = new HashMap();
//						arrValues = new ArrayList();
//						hshQuery.put("strQueryId", "exec_guadetailsins");
//						arrValues.add(appno);
//						arrValues.add(correctNull(StrGuarantor[i]));
//						arrValues.add(correctNull(StrGuarantorTNW[i]));
//						hshQuery.put("arrValues", arrValues);
//						//hshQueryValues.put("size", Integer.toString(intUpdatesize));
//						hshQueryValues.put(Integer.toString(intUpdatesize),
//								hshQuery);
//					}
//				}
				
				if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("SRE"))
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(appno);
					arrValues.add("1");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull((String)hshValues.get("valdate")));				
					arrValues.add(correctNull((String)hshValues.get("txt_means")));
					arrValues.add("1");
					arrValues.add(correctNull((String)hshValues.get("inwardno")));
					arrValues.add("1");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull((String)hshValues.get("valdate")));
					hshQuery.put("strQueryId", "inscreditreport2");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);
					
				
				}
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			} else if (strAction.trim().equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "execdel_port");
				arrValues = new ArrayList();
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				//hshQueryValues.put("size", "2");
				hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);

//				hshQuery = new HashMap();
//				intUpdatesize = intUpdatesize + 1;
//				hshQuery.put("strQueryId", "exec_guadetailsdel");
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);
				
				if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC")
						|| Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("SRE"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "delcreditreport2");
					arrValues.add(appno);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);
					//hshQueryValues.put("size", "3");
				}
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			}
			//-----------------------------------------------AuditTrial--------------------------------
//			sbAt.append("~Credit Facilities Since = ").append(Helper.correctNull((String) hshValues.get("credit_since"))).append(
//			"~Date of Executive Summary = ").append(correctNull((String) hshValues.get("txt_exedate")))
//			.append("~Agenda Item No = ").append(correctNull((String)hshValues.get("txt_agenda")))
//			.append("~MCM of =").append(correctNull((String)hshValues.get("txt_mcm")))
//			.append("~Reference No =").append(correctNull((String)hshValues.get("txt_refno")))
//			.append("~Sanctioning Authority =").append(correctNull((String)hshValues.get("")));
			
//			if(correctNull((String) hshValues.get("sel_guaranteoffered")).trim().equalsIgnoreCase("Y"))
//			{
//			sbAt.append("~Whether Corporate Guarantee is offered = Yes");
//			if(correctNull((String) hshValues.get("sel_applicantguarantee")).trim().equalsIgnoreCase("Y"))
//			{
//				sbAt.append("~Whether guaranting Co is same applicant co = Yes");
//			}
//			else if(correctNull((String) hshValues.get("sel_applicantguarantee")).trim().equalsIgnoreCase("N"))
//			{
//				sbAt.append("~Whether guaranting Co is same applicant co = No");
//				for (int i = 0; i < StrGuarantor.length; i++) {
//					if (!StrGuarantor[i].equals("")) {
//						
//						sbAt.append("~Name of the Guarantor = ").append(correctNull(StrGuarantor[i])).append(
//						"~TNW = ").append(correctNull(StrGuarantorTNW[i]));	
//									
//					}
//				}
//				
//			}
//			}
//			else if(correctNull((String) hshValues.get("sel_guaranteoffered")).trim().equalsIgnoreCase("N"))
//			{
//				sbAt.append("~Whether Corporate Guarantee is offered = No");
//			}
					
			
			StringBuilder sbAt=new StringBuilder();
			if (!strAction.trim().equalsIgnoreCase("delete")) {
				
				if(strCategory.equalsIgnoreCase("CORP"))
				{
					sbAt.append("~Date of Executive Summary = ");
				}
				else
				{
					sbAt.append("~Date of process Note = ");
				}
				sbAt.append(Helper.correctNull((String)hshValues.get("txt_exedate")));
				sbAt.append("~Sanctioning Authority = ");
				if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("1"))
				{
					sbAt.append("Branch Head");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("2"))
				{
					sbAt.append("Regional Head");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("3"))
				{
					sbAt.append("FGMO");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("4"))
				{
					sbAt.append("CO GM");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("5"))
				{
					sbAt.append("Executive Director");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("6"))
				{
					sbAt.append("Managing Director");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("7"))
				{
					sbAt.append("MCM");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("8"))
				{
					sbAt.append("SARAL Head");
				}else if(Helper.correctNull((String)hshValues.get("selsancauth")).equals("9"))
				{
					sbAt.append("Cheif Manager");
				}
				else
				{
					sbAt.append("");
				}
				sbAt.append("~Reference No = ");
				sbAt.append(Helper.correctNull((String)hshValues.get("txt_refno")));
				
				if(strCategory.equalsIgnoreCase("CORP") || strCategory.equalsIgnoreCase("STL") || strCategory.equalsIgnoreCase("SRE"))
				{
					sbAt.append("~Type of Borrower = ");
					if(Helper.correctNull((String)hshValues.get("sel_borrowertype")).equalsIgnoreCase("N"))
					{
					sbAt.append("New Borrower");
					}
					else if(Helper.correctNull((String)hshValues.get("sel_borrowertype")).equalsIgnoreCase("E"))
					{
						sbAt.append("Existing Borrower");
						sbAt.append("~Credit Facilities Since = ");
						sbAt.append(Helper.correctNull((String)hshValues.get("credit_since")));
					}
				}
				if(strCategory.equalsIgnoreCase("ADC") || strCategory.equalsIgnoreCase("STL") || strCategory.equalsIgnoreCase("SRE"))
				{
					sbAt.append("~Means/TNW of Applicant company = ");
					sbAt.append(Helper.correctNull((String)hshValues.get("txt_means")));
					sbAt.append("~As on Date = ");
					sbAt.append(Helper.correctNull((String)hshValues.get("valdate")));
				}
				sbAt.append("~Whether applicant company is standing as guarantor = ");
				if(Helper.correctNull((String)hshValues.get("sel_applicantguarantee")).equalsIgnoreCase("Y"))
				{
				sbAt.append("Yes");
				}else if(Helper.correctNull((String)hshValues.get("sel_applicantguarantee")).equalsIgnoreCase("N"))
				{
					sbAt.append("No");
				}else
				{
					sbAt.append("");
				}
				
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				hshValues.put("hidAction","update");
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				hshValues.put("hidAction","Insert");
				
			AuditTrial.auditLog(hshValues,"207",appno,sbAt.toString());	
			//---------------------------------------------------End-----------------------------------
			
		}

		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}
	}

	public HashMap getData2(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";

		try {
			appno = correctNull((String) hshValues.get("appno"));

			/*strQuery = SQLParser.getSqlQuery("selexecpage1status^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_name", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("exec_no", appno);
				hshRecord.put("exec_status", correctNull(rs.getString("app_status")));
			}*/

			strQuery = SQLParser.getSqlQuery("execsel_inducom^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {

				hshRecord.put("exec_summ_mortage", correctNull(rs.getString("exec_summ_mortage")));
				hshRecord.put("exec_summ_mortageY", correctNull(rs.getString("exec_summ_mortageY")));
				hshRecord.put("exec_summ_roc", correctNull(rs.getString("exec_summ_roc")));
				hshRecord.put("exec_summ_rocY", correctNull(rs.getString("exec_summ_rocY")));
				hshRecord.put("exec_summ_validdoc", correctNull(rs.getString("exec_summ_validdoc")));
				hshRecord.put("exec_summ_validdocY", correctNull(rs.getString("exec_summ_validdocY")));
				hshRecord.put("exec_summ_terms", correctNull(rs.getString("exec_summ_terms")));
				hshRecord.put("exec_summ_termsY", correctNull(rs.getString("exec_summ_termsY")));
				hshRecord.put("exec_summ_meetingheld", correctNull(rs.getString("exec_summ_meetingheld")));
				hshRecord.put("exec_summ_meetingheldY", correctNull(rs.getString("exec_summ_meetingheldY")));
				hshRecord.put("exec_summ_indlevelsubopm", correctNull(rs.getString("exec_summ_indlevelsubopm")));
				hshRecord.put("exec_summ_indlevelsubcov", correctNull(rs.getString("exec_summ_indlevelsubcov")));

				hshRecord.put("exec_summ_indlevelsubroce", correctNull(rs.getString("exec_summ_indlevelsubroce")));
				hshRecord.put("exec_summ_indlevelsubcr", correctNull(rs.getString("exec_summ_indlevelsubcr")));
				hshRecord.put("exec_summ_indlevelsubtol", correctNull(rs.getString("exec_summ_indlevelsubtol")));
				hshRecord.put("exec_summ_dateofinspc", correctNull(rs.getString("exec_summ_dateofinspc")));
				hshRecord.put("exec_summ_indlevelotherrisk", correctNull(rs.getString("exec_summ_indlevelotherrisk")));

				hshRecord.put("exec_summ_indlevelrbiY", correctNull(rs.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks", correctNull(rs.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankY", correctNull(rs.getString("exec_summ_indlevelbankY")));
				hshRecord.put("exec_summ_indlevelbankremarks", correctNull(rs.getString("exec_summ_remarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths",correctNull(rs.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelcomkeyweakness",correctNull(rs.getString("exec_summ_weakness")));

			}

			// hema

			strQuery = SQLParser.getSqlQuery("conduct_sel^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {

				hshRecord.put("conduct_acc", correctNull(rs.getString("conduct_acc")));
				hshRecord.put("conduct_no", correctNull(rs.getString("conduct_no")));
				hshRecord.put("conduct_accstock", correctNull(rs.getString("conduct_accstock")));
				hshRecord.put("conduct_stockno", correctNull(rs.getString("conduct_stockno")));
				hshRecord.put("conduct_msod", correctNull(rs.getString("conduct_msod")));
				hshRecord.put("conduct_msodno", correctNull(rs.getString("conduct_msodno")));
				hshRecord.put("conduct_qpr", correctNull(rs.getString("conduct_qpr")));
				hshRecord.put("conduct_qprno", correctNull(rs.getString("conduct_qprno")));
				hshRecord.put("conduct_fin", Helper.correctDouble((String) rs.getString("conduct_fin")));
				hshRecord.put("conduct_finno", correctNull(rs.getString("conduct_finno")));
				hshRecord.put("conduct_cma", correctNull(rs.getString("conduct_cma")));
				hshRecord.put("conduct_cmano", correctNull(rs.getString("conduct_cmano")));
				hshRecord.put("conduct_stockstamt", correctNull(rs.getString("conduct_stockstamt")));

				hshRecord.put("conduct_stockdate", correctNull(rs.getString("conduct_stockdate")));
				hshRecord.put("conduct_msodstmt", correctNull(rs.getString("conduct_msodstmt")));
				hshRecord.put("conduct_msoddate", correctNull(rs.getString("conduct_msoddate")));

				hshRecord.put("conduct_qprstmt", correctNull(rs.getString("conduct_qprstmt")));
				hshRecord.put("conduct_qprdate", correctNull(rs.getString("conduct_qprdate")));
				hshRecord.put("conduct_turn", correctNull(rs.getString("conduct_turn")));

				hshRecord.put("conduct_excess", correctNull(rs.getString("conduct_excess")));
				hshRecord.put("conduct_cheques", correctNull(rs.getString("conduct_cheques")));

			}
			// hema

			hshRecord.put("hidappno", Helper.correctNull((String) hshValues
					.get("hidappno")));
		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
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

	public void updateData2(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));

		try {

			if (strAction.trim().equals("update")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_indu");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				// log.info("hshQry"+hshQry);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");

				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insinduscomp");
				arrValues.add(appno);

				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_mortage")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_mortageY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_roc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_rocY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_validdoc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_validdocY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_terms")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_termsY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_meetingheld")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_meetingheldY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelsubopm")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelsubcov")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelsubroce")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelsubcr")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelsubtol")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_dateofinspc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelotherrisk")));

				// --------------------------------------------------

				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelrbiY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelrbiremarks")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelbankY")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelbankremarks")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelcomkeystrengths")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_summ_indlevelcomkeyweakness")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				ArrayList arrValues1 = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");

				hshQuery.put("strQueryId", "conduct_del");
				arrValues1.add(appno);

				hshQuery.put("arrValues", arrValues1);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");

				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "inscoduct");
				arrValues.add(appno);

				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_acc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_no")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_accstock")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_stockno")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_msod")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_msodno")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_qpr")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_qprno")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_fin")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_finno")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_cma")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_cmano")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_stockstamt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_stockdate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_msodstmt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_msoddate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_qprstmt")));

				// --------------------------------------------------

				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_qprdate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_turn")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_excess")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("conduct_cheques")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.trim().equals("delete")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_indu");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				// log.info("hshQry"+hshQry);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "conduct_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		}

		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} finally {
			try {
				// if(rs != null)
				// {
				// rs.close();
				// }
				// if(stmt != null)
				// {
				// stmt.close();
				// }
				// if(con != null)
				// {
				// con.close();
				// }
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}

	public void updateData3(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));

		if (appno.equalsIgnoreCase(null) || appno.equals("")) {
			appno = correctNull((String) hshValues.get("hidappno"));
		}
		try {
			if (strAction.trim().equals("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_summary");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "execins_summary");

				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("exec_summ_company")));
				arrValues.add(correctNull((String) hshValues.get("exec_summ_indriskdemand")));
				arrValues.add(correctNull((String) hshValues.get("exec_summ_indriskdiversity")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_summary");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}

		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} finally {
			try {
				// if(rs != null)
				// {
				// rs.close();
				// }
				// if(stmt != null)
				// {
				// stmt.close();
				// }
				// if(con != null)
				// {
				// con.close();
				// }
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}

	}

	public HashMap getData5(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		
		try {
			appno = correctNull((String) hshValues.get("appno"));

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			strQuery = SQLParser.getSqlQuery("execsel_credit^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_summ_indlevelrbiY",correctNull(rs.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks",correctNull(rs.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankremarks",correctNull(rs.getString("exec_summ_indlevelbankremarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths",correctNull(rs.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelgenmanager",correctNull(rs.getString("exec_summ_manager")));
			}

			/*strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("status_acc", correctNull(rs.getString("status_acc")));
				//hshRecord.put("background_promoters", correctNull(rs.getString("background_promoters")));
				hshRecord.put("book_value", correctNull(rs.getString("book_value")));
				hshRecord.put("market_value", correctNull(rs.getString("market_value")));
				hshRecord.put("company_rbi", correctNull(rs.getString("company_rbi")));
				hshRecord.put("company_rbidesc", correctNull(rs.getString("company_rbidesc")));
				hshRecord.put("exposure_norms", correctNull(rs.getString("exposure_norms")));

				hshRecord.put("consortium_assessment", correctNull(rs.getString("consortium_assessment")));
				hshRecord.put("other_matters", correctNull(rs.getString("other_matters")));
				hshRecord.put("ind_services", correctNull(rs.getString("ind_services")));
			}
			if (rs != null) {
				rs.close();
			}*/
			hshRecord.put("hidappno", Helper.correctNull((String) hshValues.get("hidappno")));

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

	public void updateData5(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = "";
		appno = correctNull((String) hshValues.get("appno"));

		try {
			if (strAction.trim().equals("edit")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_credit");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execins_credit");
				
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_indlevelrbiY")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_indlevelrbiremarks")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_indlevelbankremarks")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_indlevelcomkeystrengths")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_indlevelgenmanager")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_credit");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			}
		}

		catch (Exception ce) {
			log.error("Exception in updateData5 :: "+ ce.toString());
		}
}

	public void updateData7(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0;
		StringBuilder sbolddata=new StringBuilder();
		
		try
		{
			String strBank=Helper.correctNull((String)hshValues.get("sel_Bank"));
			String strFacility="";
			if(strBank.equalsIgnoreCase("Our"))
			{
				strFacility=Helper.correctNull((String)hshValues.get("sel_Facility"));
			}
			else
			{
				strFacility=Helper.correctNull((String)hshValues.get("txt_Facility"));
			}
			String strOSAsOnDate=Helper.correctNull((String)hshValues.get("txt_OSAsOnDate"));
			String strBnkType=Helper.correctNull((String)hshValues.get("sel_BnkType"));
			String strIntType=Helper.correctNull((String)hshValues.get("sel_IntType"));
			String strCreditType=Helper.correctNull((String)hshValues.get("sel_CreditType"));
			String strSancRefNo=Helper.correctNull((String)hshValues.get("txt_SancRefNo"));
			String strSancDate=Helper.correctNull((String)hshValues.get("txt_SancDate"));
			String strDueDate=Helper.correctNull((String)hshValues.get("txt_DueDate"));
			String strArrears=Helper.correctNull((String)hshValues.get("txtArea_Arrears"));
			String strCompName=Helper.correctNull((String)hshValues.get("sel_CompName"));
			String strBankName=Helper.correctNull((String)hshValues.get("txt_Bank"));
			String strType=Helper.correctNull((String)hshValues.get("sel_Type"));
			String strLimit=Helper.correctNull((String)hshValues.get("txt_Limit"));
			String strOS=Helper.correctNull((String)hshValues.get("txt_OS"));
			String strSpreadVal=Helper.correctNull((String)hshValues.get("txt_SpreadVal"));
			String strRemarks=Helper.correctNull((String)hshValues.get("txtarea_Remarks"));
			String strFacSNo=Helper.correctNull((String)hshValues.get("hidFacSNo"));
			String strFacType=Helper.correctNull((String)hshValues.get("sel_FacilityType"));
			String strModuleType=Helper.correctNull((String)hshValues.get("sel_Module"));
			String strMonthlyIns=Helper.correctNull((String)hshValues.get("txt_monthlyins"));
			String strcbsappno=Helper.correctNull((String)hshValues.get("txt_cbsappno"));
			//Added by rajesh on 02/03/2014
			String strbank_intrate=Helper.correctNull((String)hshValues.get("txt_bank_intrate"));
			String strbanksel_repaytype=Helper.correctNull((String)hshValues.get("com_banksel_repaytype"));
			String strbank_drwpower=Helper.correctNull((String)hshValues.get("txt_bank_drwpower"));
			String strprestatus=Helper.correctNull((String)hshValues.get("txt_prestatus"));
			String strPurpose=Helper.correctNull((String)hshValues.get("txtArea_purpose"));

			if(strAction.equalsIgnoreCase("insert"))
			{
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","comgroupconcernsinsertNEW");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(strFacType);
				arrValues.add(strFacility);
				arrValues.add(strOSAsOnDate);
				arrValues.add(strBnkType);
				arrValues.add(strIntType);
				arrValues.add(strCreditType);
				arrValues.add(strSancRefNo);
				arrValues.add(strSancDate);
				arrValues.add(strDueDate);
				arrValues.add(strArrears);
				arrValues.add(strCompName);
				arrValues.add(strBank);
				arrValues.add(strBankName);
				arrValues.add(strType);
				arrValues.add(strLimit);
				arrValues.add(strOS);
				arrValues.add(strSpreadVal);
				arrValues.add(strRemarks);
				arrValues.add(strFacSNo);
				arrValues.add(strModuleType);
				if(strMonthlyIns.equalsIgnoreCase(""))
				{
					strMonthlyIns="0.00";
				}
				arrValues.add(strMonthlyIns);
				arrValues.add(strcbsappno);//added bu ganesan for cbs appno
				arrValues.add(strbank_intrate);
				arrValues.add(strbanksel_repaytype);
				if(strbank_drwpower.equalsIgnoreCase(""))
				{
					strbank_drwpower="0.00";
				}
				arrValues.add(strbank_drwpower);
				arrValues.add(strprestatus);
				arrValues.add(strPurpose);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","comgroupconcernsupdateNEW");
				arrValues.add(strFacility);
				arrValues.add(strOSAsOnDate);
				arrValues.add(strBnkType);
				arrValues.add(strIntType);
				arrValues.add(strCreditType);
				arrValues.add(strSancRefNo);
				arrValues.add(strSancDate);
				arrValues.add(strDueDate);
				arrValues.add(strArrears);
				arrValues.add(strCompName);
				arrValues.add(strBank);
				arrValues.add(strBankName);
				arrValues.add(strType);
				arrValues.add(strLimit);
				arrValues.add(strOS);
				arrValues.add(strSpreadVal);
				arrValues.add(strRemarks);
				arrValues.add(strFacSNo);
				arrValues.add(strFacType);
				arrValues.add(strModuleType);
				if(strMonthlyIns.equalsIgnoreCase(""))
				{
					strMonthlyIns="0.00";
				}
				arrValues.add(strMonthlyIns);
				arrValues.add(strcbsappno);//added bu ganesan for cbs appno
				arrValues.add(strbank_intrate);
				arrValues.add(strbanksel_repaytype);
				if(strbank_drwpower.equalsIgnoreCase(""))
				{
					strbank_drwpower="0.00";
				}
				arrValues.add(strbank_drwpower);
				arrValues.add(strprestatus);
				arrValues.add(strPurpose);
				arrValues.add(Helper.correctNull((String)hshValues.get("txtArea_repayment")));
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","comgroupconcernsdeleteNEW");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
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
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateData6(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");

		String appno = correctNull((String) hshValues.get("appno"));
		String sel_foreign = correctNull((String) hshValues.get("sel_foreign"));
		try {
			if (strAction.trim().equals("edit")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_VALOFACCOUNT");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execins_VALOFACCOUNT");
				arrValues.add(appno);

				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pfrom")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pto")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cfrom")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cto")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pintincome")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cintincome")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pfeebasedinc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cfeebasedinc")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pnoas")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cnoas")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pretailamt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cretailamt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_poamt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_coamt")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_powntenordate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cowntenordate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_coamt1")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_poamt1")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_pthirdtenordate")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_cthirdtenordate")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				// added for details of currency
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_FOREIGNCURRENCY");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				if (sel_foreign.equalsIgnoreCase("YES")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "execINS_FOREIGNCURRENCY");
					arrValues.add(appno);

					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp1")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld1")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate1")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp2")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld2")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate2")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp3")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld3")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate3")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp4")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld4")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate4")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp5")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld5")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate5")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp6")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld6")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate6")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp7")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld7")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate7")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_exp8")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_unheld8")));
					arrValues.add(Helper.correctNull((String) hshValues
							.get("txt_duedate8")));

					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

				// added for details of excess
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_EXCESSALLOWED");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execINS_EXCESSALLOWED");
				arrValues.add(appno);

				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_nofoccasions")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_maxexcess")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("exec_othexposure")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_othliabilities")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_accexposure")));
				arrValues.add(Helper.correctNull((String) hshValues
						.get("txt_raroc")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.trim().equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_VALOFACCOUNT");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				// added for foreign currency
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_FOREIGNCURRENCY");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				// added for details of excess
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_EXCESSALLOWED");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			StringBuilder sbAuditTrial=new StringBuilder();
			
			sbAuditTrial
			.append("No Of Occasions excesses allowed= ").append(Helper.correctNull((String)hshValues.get("txt_nofoccasions"))).
			append("~Maximum Excess allowed=").append(Helper.correctNull((String)hshValues.get("txt_maxexcess"))).
			append("~Advances for Previous year From= ").append(Helper.correctNull((String)hshValues.get("txt_pfrom"))).
			append("~Advances for Previous year To= ").append(Helper.correctNull((String)hshValues.get("txt_pto"))).
			append("~Advances for Current year From= ").append(Helper.correctNull((String)hshValues.get("txt_cfrom"))).
			append("~Advances for Current year To= ").append(Helper.correctNull((String)hshValues.get("txt_cto"))).
			append("~Interest Income for Previous year=  ").append(Helper.correctNull((String)hshValues.get("txt_pintincome"))).
			append("~Interest Income for Current year= ").append(Helper.correctNull((String)hshValues.get("txt_cintincome"))).
			append("~Feebased Income for Previous year= ").append(Helper.correctNull((String) hshValues.get("txt_pfeebasedinc"))).
			append("~Feebased Income for Current year= ").append(Helper.correctNull((String) hshValues.get("txt_cfeebasedinc")));
			sbAuditTrial
			.append("~Retail/Consumer/Finance(to employees associates)^").
			append("~No.of accounts= ").append(Helper.correctNull((String) hshValues.get("txt_pnoas"))).
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_pretailamt"))).
			append("~No.of accounts=  ").append(Helper.correctNull((String) hshValues.get("txt_cnoas"))).
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_cretailamt")));
			sbAuditTrial.append("~Own Deposits^").
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_poamt"))).
			append("~Tenor & due date= ").append(Helper.correctNull((String) hshValues.get("txt_powntenordate"))).
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_coamt"))).
			append("~Tenor & due date= ").append(Helper.correctNull((String) hshValues.get("txt_cowntenordate"))).
			append("~Third Party Deposits^").
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_poamt1"))).
			append("~Tenor & due date= ").append(Helper.correctNull((String) hshValues.get("txt_pthirdtenordate"))).
			append("~Amount= ").append(Helper.correctNull((String) hshValues.get("txt_coamt1"))).
			append("~Tenor & due date= ").append(Helper.correctNull((String) hshValues.get("txt_cthirdtenordate"))).
			append("~DETAILS OF THE FOREIGN CURRENCY EXPOSURE COMMITMENTS AND UNHEDGED PORTION IF ANY  =").append(Helper.correctNull((String) hshValues.get("sel_foreign")))
			.append("<br>");
			if(Helper.correctNull((String) hshValues.get("sel_foreign")).equalsIgnoreCase("YES"))
			{
				String strdesc[]={"","External Commerical Borrowings","Import usance bills received on collection basis duly accepted and outstanding",
						"O/s.L/Cs & PADs for import of goods/capital equipment.","Outstanding in packing credit for which the corporate is committed to submit export bills",
						"Others Export Receivables","Others Import Obligations","Foreign currency loans availed from Authorised dealers in India","Any others exposure :please specify"};
				
				for(int i=1;i<=8;i++)
				{
				sbAuditTrial.append("~").append(strdesc[i]).append("^")
				.append("~Amount of Exposure= ").append(Helper.correctNull((String)hshValues.get("txt_exp"+i)))
				.append("~Unhedged portion= ").append(Helper.correctNull((String)hshValues.get("txt_unheld"+i)))
				.append("~Due dates for payment(Range)= ").append(Helper.correctNull((String)hshValues.get("txt_duedate"+i)))
				.append("<br>");
				}
			}
			if(strAction.equalsIgnoreCase("edit"))
			{
			hshValues.put("hidAction","Update");
			}
			AuditTrial.auditLog(hshValues,"164",appno,sbAuditTrial.toString());
			
			
			
		} catch (Exception cf) {
			throw new EJBException("Error in closing updateData6"
					+ cf.getMessage());
		}
	}

	public HashMap getData7(HashMap hshValues)  {

		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		boolean recordflag=false;
		String strQuery1="";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
			String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
			String strFacNature=Helper.correctNull((String)hshValues.get("sel_FacilityType"));
			if(strcomappid.equalsIgnoreCase(""))
			{
				strcomappid=Helper.correctNull((String)hshValues.get("hidAppId"));
			}
			strQuery = SQLParser.getSqlQuery("comgroupconcernsselectNEW^"+appno+"^ ");
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecVal=new ArrayList();
				vecVal.add(Helper.correctInt((String)rs.getString("comgc_id")));//0
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_facility")));//1
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_osasondate")));//2
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_bnktype")));//3
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_inttype")));//4
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_credittype")));//5
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_sancrefno")));//6
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_sancdate")));//7
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_duedate")));//8
				vecVal.add(Helper.replaceForJavaScriptString(Helper.correctNull((String)rs.getString("comgc_arrears"))));//9
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_companyname")));//10
				String strBank=Helper.correctNull((String)rs.getString("comgc_bnk"));
				vecVal.add(strBank);//11
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_bnkname")));//12
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_fundtype")));//13
				vecVal.add(Helper.correctDouble((String)rs.getString("comgc_limit")));//14
				vecVal.add(Helper.correctDouble((String)rs.getString("comgc_os")));//15
				vecVal.add(Helper.correctDouble((String)rs.getString("comgc_spread")));//16
				vecVal.add(Helper.replaceForJavaScriptString(Helper.correctNull((String)rs.getString("comgc_remarks"))));//17
				if(strBank.equalsIgnoreCase("Our"))
				{
					String strcombk_modtype=Helper.correctNull((String)rs.getString("comgc_modtype"));
					String strFacility=Helper.correctNull((String)rs.getString("comgc_facility"));
					String[] strFacilityArr=strFacility.split("~");
					if(strFacilityArr.length>0)
					{
						if(strcombk_modtype.equalsIgnoreCase("r")|| strcombk_modtype.equalsIgnoreCase("p"))
						{
							strQuery1=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
							rs1 = DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
							
						}
						else if(strcombk_modtype.equalsIgnoreCase("c"))
						{
							strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^c");
							rs1 = DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
						
						}
						else if(strcombk_modtype.equalsIgnoreCase("a"))
						{
							strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^a");
							rs1 = DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
						
						}
						else
						{
							vecVal.add("");//18
						}
					
					}
					else
					{
						vecVal.add("");//18
					}
				}
				else
				{
					vecVal.add("");//18
				}
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_facility_sno")));//19
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_type")));//20
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_modtype")));//21
				vecVal.add(Helper.correctDouble((String)rs.getString("comgc_monthly_ins")));//22
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_cbsappno")));//23 added by ganesan for cbsappno
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_intrate")));
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_repaytype")));
				vecVal.add(Helper.correctDouble((String)rs.getString("comgc_drwpower")));
				vecVal.add(Helper.correctNull((String)rs.getString("comgc_prestatus")));
				vecVal.add(Helper.correctNull((String)rs.getString("COMGC_EXPOSURE")));
				vecVal.add(Helper.replaceForJavaScriptString(Helper.correctNull((String)rs.getString("comgc_purpose"))));
				vecVal.add(Helper.replaceForJavaScriptString(Helper.correctNull((String)rs.getString("comgc_repaymentcmt"))));
				vecVal.add(Helper.correctNull(rs.getString("COMGC_FACTYPE")));
				vecVal.add(Helper.correctNull(rs.getString("COMGC_FACCATEGORY")));
				vecData.add(vecVal);
				recordflag=true;
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("hidAppId",strcomappid);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	
	}

	public HashMap getData6(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		String flag = "false";
		String appno = correctNull((String) hshValues.get("appno"));
		try {

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("comm_appno"));
			}
			String strQuery ="";
			/*  = SQLParser.getSqlQuery("selexecpage1status^"
					+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_name", correctNull(rs
						.getString("comapp_companyname")));
				hshRecord.put("exec_no", appno);
				hshRecord.put("exec_status", correctNull(rs
						.getString("app_status")));
			}*/

			strQuery = SQLParser.getSqlQuery("execsel_VALOFACCOUNT^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("EXEC_PFROM", correctNull(rs
						.getString("EXEC_PFROM")));
				hshRecord
						.put("EXEC_PTO", correctNull(rs.getString("EXEC_PTO")));
				hshRecord.put("EXEC_CFROM", correctNull(rs
						.getString("EXEC_CFROM")));
				hshRecord
						.put("EXEC_CTO", correctNull(rs.getString("EXEC_CTO")));
				hshRecord.put("EXEC_PINTINC", correctNull(rs
						.getString("EXEC_PINTINC")));
				hshRecord.put("EXEC_CINTINC", correctNull(rs
						.getString("EXEC_CINTINC")));
				hshRecord.put("EXEC_PFEEINC", correctNull(rs
						.getString("EXEC_PFEEINC")));
				hshRecord.put("EXEC_CFEEINC", correctNull(rs
						.getString("EXEC_CFEEINC")));
				hshRecord.put("EXEC_PNOACS", correctNull(rs
						.getString("EXEC_PNOACS")));
				hshRecord.put("EXEC_PRETAILAMT", correctNull(rs
						.getString("EXEC_PRETAILAMT")));
				hshRecord.put("EXEC_CNOACS", correctNull(rs
						.getString("EXEC_CNOACS")));
				hshRecord.put("EXEC_CRETAILAMT", correctNull(rs
						.getString("EXEC_CRETAILAMT")));
				hshRecord.put("EXEC_POWNAMT", correctNull(rs
						.getString("EXEC_POWNAMT")));
				hshRecord.put("EXEC_COWNAMT", correctNull(rs
						.getString("EXEC_COWNAMT")));
				hshRecord.put("EXEC_POWNTENORDATE", correctNull(rs
						.getString("EXEC_POWNTENORDATE")));
				hshRecord.put("EXEC_COWNTENORDATE", correctNull(rs
						.getString("EXEC_COWNTENORDATE")));
				hshRecord.put("EXEC_PTHIRDAMT", correctNull(rs
						.getString("EXEC_PTHIRDAMT")));
				hshRecord.put("EXEC_CTHIRDAMT", correctNull(rs
						.getString("EXEC_CTHIRDAMT")));
				hshRecord.put("EXEC_PTHIRDTENORDATE", correctNull(rs
						.getString("EXEC_PTHIRDTENORDATE")));
				hshRecord.put("EXEC_CTHIRDTENORDATE", correctNull(rs
						.getString("EXEC_CTHIRDTENORDATE")));
			}

			// added for foreign currency
			String strforeign = SQLParser
					.getSqlQuery("execsel_FOREIGNCURRENCY^" + appno);
			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strforeign);
			if (rs.next()) {
				flag = "true";
				hshRecord.put("EXEC_EXPAMT1", correctNull(rs
						.getString("EXEC_EXPAMT1")));
				hshRecord.put("EXEC_UNHEDPOS1", correctNull(rs
						.getString("EXEC_UNHEDPOS1")));
				hshRecord.put("EXEC_DUEDATE1", correctNull(rs
						.getString("EXEC_DUEDATE1")));
				hshRecord.put("EXEC_EXPAMT2", correctNull(rs
						.getString("EXEC_EXPAMT2")));
				hshRecord.put("EXEC_UNHEDPOS2", correctNull(rs
						.getString("EXEC_UNHEDPOS2")));
				hshRecord.put("EXEC_DUEDATE2", correctNull(rs
						.getString("EXEC_DUEDATE2")));
				hshRecord.put("EXEC_EXPAMT3", correctNull(rs
						.getString("EXEC_EXPAMT3")));
				hshRecord.put("EXEC_UNHEDPOS3", correctNull(rs
						.getString("EXEC_UNHEDPOS3")));
				hshRecord.put("EXEC_DUEDATE3", correctNull(rs
						.getString("EXEC_DUEDATE3")));
				hshRecord.put("EXEC_EXPAMT4", correctNull(rs
						.getString("EXEC_EXPAMT4")));
				hshRecord.put("EXEC_UNHEDPOS4", correctNull(rs
						.getString("EXEC_UNHEDPOS4")));
				hshRecord.put("EXEC_DUEDATE4", correctNull(rs
						.getString("EXEC_DUEDATE4")));
				hshRecord.put("EXEC_EXPAMT5", correctNull(rs
						.getString("EXEC_EXPAMT5")));
				hshRecord.put("EXEC_UNHEDPOS5", correctNull(rs
						.getString("EXEC_UNHEDPOS5")));
				hshRecord.put("EXEC_DUEDATE5", correctNull(rs
						.getString("EXEC_DUEDATE5")));
				hshRecord.put("EXEC_EXPAMT6", correctNull(rs
						.getString("EXEC_EXPAMT6")));
				hshRecord.put("EXEC_UNHEDPOS6", correctNull(rs
						.getString("EXEC_UNHEDPOS6")));
				hshRecord.put("EXEC_DUEDATE6", correctNull(rs
						.getString("EXEC_DUEDATE6")));
				hshRecord.put("EXEC_EXPAMT7", correctNull(rs
						.getString("EXEC_EXPAMT7")));
				hshRecord.put("EXEC_UNHEDPOS7", correctNull(rs
						.getString("EXEC_UNHEDPOS7")));
				hshRecord.put("EXEC_DUEDATE7", correctNull(rs
						.getString("EXEC_DUEDATE7")));
				hshRecord.put("EXEC_EXPAMT8", correctNull(rs
						.getString("EXEC_EXPAMT8")));
				hshRecord.put("EXEC_UNHEDPOS8", correctNull(rs
						.getString("EXEC_UNHEDPOS8")));
				hshRecord.put("EXEC_DUEDATE8", correctNull(rs
						.getString("EXEC_DUEDATE8")));
			}
			// added for details of excess

			String strexcess = SQLParser.getSqlQuery("execsel_DETAILEXCESS^"
					+ appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strexcess);
			if (rs.next()) {
				hshRecord.put("EXEC_NOEXCESS", correctNull(rs
						.getString("EXEC_NOEXCESS")));
				hshRecord.put("EXEC_MAXEXCESS", correctNull(rs
						.getString("EXEC_MAXEXCESS")));
				hshRecord.put("EXEC_OTHEXP", correctNull(rs
						.getString("EXEC_OTHEXP")));
				hshRecord.put("EXEC_OTHLIAB", correctNull(rs
						.getString("EXEC_OTHLIAB")));
				hshRecord.put("EXEC_CONDEXP", correctNull(rs
						.getString("EXEC_CONDEXP")));
				hshRecord.put("EXEC_RAROC", correctNull(rs
						.getString("EXEC_RAROC")));

			}

			hshRecord.put("flag", flag);

		} catch (Exception cf) {
			throw new EJBException("Error in closing getData6"
					+ cf.getMessage());
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
		return hshRecord;
	}

	// -----------------------ExecutivePrintMethod by
	// Eswari------------------------------

	public HashMap getExecutivePrint(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		
		HashMap hshRecord = new HashMap();
		HashMap hshformula = new HashMap();
		HashMap hashformula = new HashMap();
		HashMap hshResult =new HashMap();
		HashMap hshValueFinancial = new HashMap();
		
		ArrayList arrVec_supp = new ArrayList();
		ArrayList arrColldetails = new ArrayList();
		ArrayList arrCorpguarantee = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow1 = new ArrayList();
		ArrayList arrPromotors = new ArrayList();
		ArrayList arrGuarantors = new ArrayList();
		ArrayList arrProback = new ArrayList();
		ArrayList arrUnitsworks= new ArrayList();

		ArrayList arrTmpList = new ArrayList();
		ArrayList arrRow12 = new ArrayList();
		ArrayList arrRow15 = new ArrayList();
		ArrayList arrRow16 = new ArrayList();
		ArrayList arrRow14 = new ArrayList();
		ArrayList arrVec41 = new ArrayList();
		ArrayList arrVecRate = new ArrayList();
		ArrayList arr = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arryCol = new ArrayList();
		ArrayList arrVec1 = new ArrayList();
		ArrayList arrVec = new ArrayList();
		ArrayList arrVec12 = new ArrayList();
		ArrayList arrVec4 = new ArrayList();
		//ArrayList arrRow17 = new ArrayList();
		ArrayList arr1 = new ArrayList();
		//ArrayList arrOurBank = new ArrayList();
		ArrayList WC_Funded = new ArrayList();
		ArrayList OurBank_WC_Funded = new ArrayList();
		ArrayList WC_NonFunded = new ArrayList();
		ArrayList OurBank_WC_NonFunded = new ArrayList();
		ArrayList TL_Funded_NonFunded = new ArrayList();
		ArrayList OurBank_TL = new ArrayList();
		ArrayList arrSubFac = new ArrayList();
		ArrayList arrworkingCol = null;
		ArrayList arrworkingRow = new ArrayList();
		ArrayList arrtermsCol = null;
		ArrayList arrtermsRow = new ArrayList();
		ArrayList arrsummary=new ArrayList();
		ArrayList arrsummaryfac=new ArrayList();
		ArrayList arrsummary1=new ArrayList();
		ArrayList arrsummaryfacwise=new ArrayList();
		ArrayList arrVec2 = new ArrayList();
		ArrayList arrBankArrangement = new ArrayList();
		ArrayList arrBankArrangementFI=new ArrayList();
		ArrayList arrBank = new ArrayList();
		
		String appno = "";
		String comappid = "";
		String CompanyName = "";
		String strRegCity = "", strRegState = "";
		String strIndcode="";
		String strOwnership="";
		String strBorrowerType="";
		String strIndustryType="",strGroup="";
		String strTemp="";
		String strPublictype="";
		String strSanctauth ="";
		hshformula = new HashMap();
		
		double dblTotalshares=0.0;

		try {
			appno = correctNull((String) hshValues.get("appno"));
			comappid = correctNull((String) hshValues.get("comappid"));
			CompanyName = correctNull((String) hshValues.get("CompanyName"));

			hshRecord.put("strOrgName", correctNull((String) hshValues.get("strOrgName")));

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			/*********************************************************************
			 * For finding the customer profile created branch to display in the *
			 * point No 1.1                                                      *
			 * Keyword     :   appno                                             *
			 * Tables Used :   COMAPPLICANT, ORGANISATIONS, COM_DEMOGRAPHICS     *
			 * *******************************************************************/
			strQuery = SQLParser.getSqlQuery("applicant_create_code^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				//comapp_org_scode=correctNull((String)rs1.getString("comapp_org_scode"));
				//comapp_org_code=correctNull((String)rs1.getString("comapp_org_code"));
				hshRecord.put("appCreationBranch",correctNull((String)rs1.getString("org_name")));
			}
			
			if (rs != null) {
				rs.close();
			}
			
			/*********************************************************************
			 * To find the customer ID Using the appno for getting the datas of  *
			 * Customer profile related datas                                    *
			 * Keyword     :   appno                                             *
			 * Tables Used :   COMAPPLICANT, APPLICATIONS, COM_DEMOGRAPHICS      *
			 * *******************************************************************/
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
			}
			
			
			// APP CREATE DATE
			
			strQuery = SQLParser.getSqlQuery("getcreatedate^" + appno);
			if (rs != null) {
				rs.close();
			}

			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("createdate", correctNull(rs.getString("createdate")));
			}

			/*********************************************************************
			 * To Fetch the customer profile datas for shown in the executive    *
			 * Print using the customer id got from the previous query           *
			 * Keyword     :   Comappid                                          *
			 * Tables Used :   COMAPPLICANT                                      *
			 * *******************************************************************/
			strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("comapp_companyname", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("comapp_companyid", correctNull(rs.getString("comapp_companyid")));
				hshRecord.put("comapp_yrsinbusiness", correctNull(rs.getString("comapp_yrsinbusiness")));
				hshRecord.put("comapp_businessnature", correctNull(rs.getString("comapp_businessnature")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("comapp_businessnature")));
				hshRecord.put("comapp_regadd1", correctNull(rs.getString("comapp_regadd1")));
				hshRecord.put("comapp_regadd2", correctNull(rs.getString("comapp_regadd2")));
				hshRecord.put("comapp_regcity", correctNull(rs.getString("comapp_regcity")));
				hshRecord.put("comapp_regstate", correctNull(rs.getString("comapp_regstate")));
				hshRecord.put("comapp_regphone", correctNull(rs.getString("comapp_regphone")));
				hshRecord.put("comapp_regfax", correctNull(rs.getString("comapp_regfax")));
				hshRecord.put("comapp_regpin", correctNull(rs.getString("comapp_regpin")));
				hshRecord.put("groupdesc", correctNull(rs.getString("groupdesc")));
				hshRecord.put("comapp_ownership", correctNull(rs.getString("comapp_ownership")));
				hshRecord.put("comapp_cin", correctNull(rs.getString("comapp_cin")));
				//hshRecord.put("auth_captial", Helper.formatDoubleValue(rs.getDouble("auth_captial")));
				//hshRecord.put("comapp_subcapital", Helper.formatDoubleValue(rs.getDouble("comapp_subcapital")));
				hshRecord.put("deal_bank", correctNull(rs.getString("comapp_bankdealing")));
				strIndcode=correctNull(rs.getString("comapp_indcode"));
				strRegCity = correctNull(rs.getString("comapp_regcity"));
				strRegState = correctNull(rs.getString("comapp_regstate"));
				strOwnership=correctNull(rs.getString("comapp_ownership"));
				strIndustryType=correctNull(rs.getString("scale"));
				strGroup=correctNull(rs.getString("comapp_group"));
				//dblTotalshares=rs.getDouble("comapp_totalshares");
				strPublictype=correctNull(rs.getString("comapp_pubtype")).equals("")?"S":correctNull(rs.getString("comapp_pubtype"));
				
			}
			// added by Madhura for fetching City and state
			strQuery = SQLParser.getSqlQuery("selstatename2^" + strRegState);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("Regstate_name", correctNull(rs.getString("state_name")));
			}

			strQuery = SQLParser.getSqlQuery("selcityname2^" + strRegCity);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("Regcity_name", correctNull(rs.getString("city_name")));
			}

			// End customer Profile
			
			/****************************************************************************** 
			* For fetching the values from Factories/branches (Units/Works)etc
			* By Sureshkumar Ganapathy Since all the factories address need to be displayed
			*********************************************************************************/
			
			strQuery=SQLParser.getSqlQuery("selallfactorydetails^" + comappid);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strFactype="";
			while(rs.next())
			{
				arrTmpList = new ArrayList();
				
				strFactype=correctNull(rs.getString("comapp_detailtype"));
				arrTmpList.add(correctNull(rs.getString("comapp_name")));
				arrTmpList.add(correctNull(rs.getString("comapp_add")));
				arrTmpList.add(correctNull(rs.getString("comapp_city")));
				arrTmpList.add(correctNull(rs.getString("comapp_state")));
				arrTmpList.add(correctNull(rs.getString("comapp_pincode")));
				
				arrUnitsworks.add(arrTmpList);
				/*if(strFactype.equals("1"))
					arrFactories.add(arrTmpList);
				else if(strFactype.equals("2"))
					arrBranches.add(arrTmpList);
				else if(strFactype.equals("3"))
					arrGodowns.add(arrTmpList);
				else if(strFactype.equals("4"))
					arrSDO.add(arrTmpList);*/
			}
			hshRecord.put("arrUnitsworks",arrUnitsworks);
			/*hshRecord.put("arrFactories",arrFactories);
			hshRecord.put("arrBranches",arrBranches);
			hshRecord.put("arrGodowns",arrGodowns);
			hshRecord.put("arrSDO",arrSDO);*/
			//End of Units/Works deatils
			
			strQuery = SQLParser.getSqlQuery("compropform8^" + appno);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("com_propassettype", correctNull(rs.getString("com_propassettype")).equals("")?"Standard":correctNull(rs.getString("com_propassettype")));
			}

			/************************************************************************
			 * For Executive Summary Credit Rating (Previous Rating and Current
			 * Rating) by Mohan
			 * 
			 * Modified by Sureshkumar based on New LAS 105 report on 18-March-2009
			 *************************************************************************/
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getramrating105details^"+ appno);
			if (rs.next()) {
				hshRecord.put("lastrating_basemodel", correctNull((String) rs.getString("lastrating_basemodel")));
				hshRecord.put("lastscore_basemodel", correctNull((String) rs.getString("lastscore_basemodel")));
				hshRecord.put("lastgradef_basemodel", correctNull((String) rs.getString("lastgradef_basemodel")));
				hshRecord.put("currentrating_basemodel", correctNull((String) rs.getString("currentrating_basemodel")));
				hshRecord.put("currentscore_basemodel", correctNull((String) rs.getString("currentscore_basemodel")));
				hshRecord.put("currentgradef_basemodel", correctNull((String) rs.getString("currentgradef_basemodel")));
				
				hshRecord.put("lastrating_dynamicmodel", correctNull((String) rs.getString("lastrating_dynamicmodel")));
				hshRecord.put("lastscore_dynamicmodel", correctNull((String) rs.getString("lastscore_dynamicmodel")));
				
				hshRecord.put("currentrating_dynamicmodel", correctNull((String) rs.getString("currentrating_dynamicmodel")));
				hshRecord.put("currentscore_dynamicmodel", correctNull((String) rs.getString("currentscore_dynamicmodel")));
				
				hshRecord.put("lastcombinedrating_dm", correctNull((String) rs.getString("lastcombinedrating_dm")));
				hshRecord.put("currentcombinedrating_dm", correctNull((String) rs.getString("currentcombinedrating_dm")));
				hshRecord.put("lastgradef_dynamicmodel", correctNull((String) rs.getString("lastgradef_dynamicmodel")));
				hshRecord.put("currentgradef_dynamicmodel", correctNull((String) rs.getString("currentgradef_dynamicmodel")));

			}
			
			/***********************************************************************
			 * To Fetch the datas for the External credit rating entered in proposal
			 * By Sureshkumar Ganapathy  as per the Banks new requirement
			 ************************************************************************/
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selexternalrating^"+ appno);
			while (rs.next()) {
				if(correctNull(rs.getString("com_propcomtype")).equals("extagency"))
				{
					hshRecord.put("extagency",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extlastrate"))
				{
					hshRecord.put("extlastrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extcurrate"))
				{
					hshRecord.put("extcurrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
			}


			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("comoperationaldata1^" + appno);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strTemp=correctNull(rs.getString("com_propmulbank"));
				hshRecord.put("status_banking",strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":strTemp.equals("4")?"Sole / Consortium":strTemp.equals("5")?"Sole / Multiple":strTemp.equals("6")?"Consortium / Multiple":strTemp.equals("7")?"Sole/ Consortium / Multiple":"");
				hshRecord.put("com_propleadbank", correctNull(rs.getString("com_propleadbank")).equals("")?"N.A":correctNull(rs.getString("com_propleadbank")));
				hshRecord.put("com_proprevperiod", correctNull(rs.getString("com_proprevperiod")));
				hshRecord.put("COM_PROPDEVREVDATE", correctNull(rs.getString("com_propdevrevdate1")).equals("January  -1900")?"N.A.":correctNull(rs.getString("com_propdevrevdate1")));
				String exfb = correctNull(rs.getString("com_propexistfb"));
				String exnfb = correctNull(rs.getString("com_propexistnfb"));
				hshRecord.put("TOTAL_FUNDEDEXI", Helper.formatDoubleValue(rs.getDouble("com_propexistfb")));
				hshRecord.put("TOTAL_NONFUNDEDEXI", Helper.formatDoubleValue(rs.getDouble("com_propexistnfb")));
				hshRecord.put("TOTAL_FUNDEDPROP", Helper.formatDoubleValue(rs.getDouble("com_propproposedfb")));
				hshRecord.put("TOTAL_NONFUNDEDPROP", Helper.formatDoubleValue(rs.getDouble("com_propproposednfb")));
				hshRecord.put("fundbased", exfb);
				hshRecord.put("nonfundbased", exnfb);
				hshRecord.put("consortium_assessment", Helper.CLOBToString(rs.getClob("com_bankingremarks")));
				
				hshRecord.put("preyear_agency",correctNull(rs.getString("com_preyear_agency")));
				hshRecord.put("curyear_agency",correctNull(rs.getString("com_curyear_agency")));
				hshRecord.put("preyear_short",correctNull(rs.getString("com_preyear_short")));
				hshRecord.put("preyear_long",correctNull(rs.getString("com_preyear_long")));
				hshRecord.put("curyear_short",correctNull(rs.getString("com_curyear_short")));
				hshRecord.put("curyear_long",correctNull(rs.getString("com_curyear_long")));
				
				
			}

			/**************************************************************************
			 * For Retreving the Data from Banking Arrangement for the executive print
			 * Point No 13 Total Indebitness
			 * Keyword    : Appno
			 * Table Used : COM_BANKING
			 *************************************************************************/
			
			if (rs != null) {
				rs.close();
			}
			double dblourFundExist = 0.0;
			double dblourFundProp = 0.0;
			double dblourNonFundExist = 0.0;
			double dblourNonFundProp = 0.0;
			double dblourTotExist = 0.0;
			double dblourTotProp = 0.0;
			double dblotrFundExist = 0.0;
			double dblotrFundProp = 0.0;
			double dblotrNonFundExist = 0.0;
			double dblotrNonFundProp = 0.0;
			double dblotrTotExist = 0.0;
			double dblotrTotProp = 0.0;
			double dbltotpropFI=0.0;
			double dbltotexistFI=0.0;
			double dblnonfundpropFI=0.0;
			double dblnonfundexistFI=0.0;
			double dblfundpropFI=0.0;
			double dblfundexistFI=0.0;
			
			boolean blnFlag=false;
			
			strQuery = SQLParser.getSqlQuery("combankingselection^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				arrVec1 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag=true;
				}else{
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
					blnFlag=true;
				}
			}
			if(blnFlag)
			{
				/*arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec1.add("Other Bank");
				arrRow1.add(arrVec1);*/
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec1.add("KBL");
				arrRow1.add(arrVec1);
			}
			hshRecord.put("arrRow1", arrRow1);

			
			if (rs != null) {
				rs.close();
			}
			/** We r reusing the same variable used in the previous loop */
			dblourFundExist = 0.0;
			dblourFundProp = 0.0;
			dblourNonFundExist = 0.0;
			dblourNonFundProp = 0.0;
			dblourTotExist = 0.0;
			dblourTotProp = 0.0;
			dblotrFundExist = 0.0;
			dblotrFundProp = 0.0;
			dblotrNonFundExist = 0.0;
			dblotrNonFundProp = 0.0;
			dblotrTotExist = 0.0;
			dblotrTotProp = 0.0;
			blnFlag=false;
			
			arrRow1=new ArrayList();
			strQuery = SQLParser.getSqlQuery("combankingselectionFI^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrVec2 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag = true;
				}else if(strType.trim().equalsIgnoreCase("FI")){
						dblfundexistFI = dblfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
						dblfundpropFI = dblfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
						dblnonfundexistFI = dblnonfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
						dblnonfundpropFI = dblnonfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
						dbltotexistFI = dblfundexistFI+dblnonfundexistFI;
						dbltotpropFI = dblfundpropFI+dblnonfundpropFI;
						blnFlag = true;
				}else{
					blnFlag = true;
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
				}
			}
			if(blnFlag)
			{
				/*arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec1.add("Other Bank");
				arrRow1.add(arrVec1);*/
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec1.add("KBL");
				arrRow1.add(arrVec1);
				
				/*arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblfundexistFI));
				arrVec1.add(Helper.formatDoubleValue(dblfundpropFI));
				arrVec1.add(Helper.formatDoubleValue(dblnonfundexistFI));
				arrVec1.add(Helper.formatDoubleValue(dblnonfundpropFI));
				arrVec1.add(Helper.formatDoubleValue(dbltotexistFI));
				arrVec1.add(Helper.formatDoubleValue(dbltotpropFI));
				arrVec1.add("Financial Institutions");
				arrRow1.add(arrVec1);*/
			}
			hshRecord.put("arrRow2", arrRow1);

			// TO FETCH VALUES FROM BANKING ARRANGEMENTS (WC & TL)
			/********************************************************************
			 * For Executive Summary Print Point No: (25) EXPOSURE DETAILS FROM *
			 * BANKING SYSTEM (Incl. Our Bank) Done By: Muralidharan Date:      *
			 * 30-OCT-2007                                                      *
			 * MODIFIED BY G.SURESHKUMAR FOR BRINGING THE REMARKS TO THE FIELD  *
			 * CONDUCT OF THE ACCOUNT                                           *
			 * 01-JULY-2009                                                     * 
			 *********************************************************************/
			arrBankArrangement = new ArrayList();
			arrBankArrangementFI=new ArrayList();
			ArrayList arrNonBankArrange=new ArrayList();
			arrBank = new ArrayList();
			String loan_type = "";
			String bank_name = "";
			double TOT_FE = 0.00;
			double TOT_NFE = 0.00;
			//double TOT_FP = 0.00;
			//double TOT_NFP = 0.00;
			double LIMIT_FE_CON = 0.00;
			double LIMIT_NFE_CON = 0.00;
			double LIMIT_FE_NONCON = 0.00;
			double LIMIT_NFE_NONCON = 0.00;
			double SHARE_FE_CON = 0.00;
			double SHARE_NFE_CON = 0.00;
			String strconductofacctconsort=null;
			String strconductofacctnoncort=null;

			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("comtotalsel^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				TOT_FE=rs.getDouble("com_totwcfundexist");
				//TOT_FP = rs.getDouble("com_totwcfundprop");
				TOT_NFE=rs.getDouble("com_totwcnonfundexist");
				//TOT_NFP = rs.getDouble("com_totwcnonfundprop");
			}

			strQuery = SQLParser.getSqlQuery("com_banksel^" + appno);

			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrBank.add(correctNull(rs.getString("bank_name")));
			}

			for (int j = 0; j < arrBank.size(); j++) {
				//loan_type = "W";
				bank_name = (String) arrBank.get(j);
							
				strconductofacctconsort="";
				strconductofacctnoncort="";
				strQuery = SQLParser.getSqlQuery("com_banking_consortiumsel^" + appno
						+ "^" + bank_name+"^Y");

				if (rs != null)
					rs.close();
				
				SHARE_FE_CON=0.00;
				SHARE_NFE_CON=0.00;
				LIMIT_NFE_CON=0.0;
				LIMIT_FE_CON=0.0;
				LIMIT_FE_NONCON=0.0;
				LIMIT_NFE_NONCON=0.0;
				boolean consortiumflag=false;
				boolean nonconsortiumflag=false;
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(correctNull(rs.getString("combk_consortium")).equals("Y"))
					{
						LIMIT_FE_CON=LIMIT_FE_CON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_CON=LIMIT_NFE_CON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals("") && correctNull(rs.getString("combk_type")).equals("W"))
							strconductofacctconsort=correctNull(rs.getString("combk_overdue"));
						
						if (TOT_FE != 0.00) {
							SHARE_FE_CON = (LIMIT_FE_CON / TOT_FE) * 100;
						}
						if (TOT_NFE != 0.00) {
							SHARE_NFE_CON = (LIMIT_NFE_CON / TOT_NFE) * 100;
						}
						consortiumflag=true;
					}
					else if(correctNull(rs.getString("combk_selbank")).equals("FI"))
					{
						
						arrVec1 = new ArrayList();
						arrVec1.add(bank_name);
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtfundexist")));
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtnonfundexist")));
						arrVec1.add(correctNull(rs.getString("combk_overdue")));
						arrVec1.add(correctNull(rs.getString("combk_excess")));
						arrBankArrangementFI.add(arrVec1);
					}
					else
					{
						LIMIT_FE_NONCON=LIMIT_FE_NONCON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_NONCON=LIMIT_NFE_NONCON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals("") && correctNull(rs.getString("combk_type")).equals("W"))
							strconductofacctnoncort=correctNull(rs.getString("combk_overdue"));
						
						nonconsortiumflag=true;
						
					}
					
				}
				 
				if(consortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add(Helper.formatDoubleValue(SHARE_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(SHARE_FE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_CON));
					arrVec1.add(strconductofacctconsort);
					arrBankArrangement.add(arrVec1);
				}
				if(nonconsortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_NONCON));
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_NONCON));
					arrVec1.add(strconductofacctnoncort);
					arrNonBankArrange.add(arrVec1);
				}
			}

			hshRecord.put("arrBankArrangement", arrBankArrangement);
			hshRecord.put("arrNonBankArrange", arrNonBankArrange);
			hshRecord.put("arrBankArrangementFI", arrBankArrangementFI);

			// End


			strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strTemp=correctNull(rs.getString("status_acc"));
				hshRecord.put("status_acc",strTemp.equals("1")?"Regular":strTemp.equals("2")?"EAS-I":strTemp.equals("3")?"EAS-II":strTemp.equals("4")?"SMA":strTemp.equals("5")?"N.A.":"" );
				hshRecord.put("company_rbi", correctNull(rs.getString("company_rbi")));
				hshRecord.put("company_rbidesc", correctNull(Helper.CLOBToString(rs.getClob("company_rbidesc"))));
				hshRecord.put("exposure_norms", correctNull(rs.getString("exposure_norms")).equals("")?"Nil":correctNull(rs.getString("exposure_norms")));
				//hshRecord.put("consortium_assessment", correctNull(rs.getString("consortium_assessment")));
				hshRecord.put("other_matters", correctNull(Helper.CLOBToString(rs.getClob("other_matters"))));
				hshRecord.put("ind_services", correctNull(rs.getString("ind_services")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("ind_services")));
			}
			if (rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selcapitalstructure^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				
				
				hshRecord.put("auth_captial", Helper.formatDoubleValue(rs.getDouble("com_authcapital")));
				hshRecord.put("comapp_subcapital", Helper.formatDoubleValue(rs.getDouble("com_subisscapital")));
				hshRecord.put("book_value", correctNull(rs.getString("com_bookvalue")));
				hshRecord.put("market_value", correctNull(rs.getString("com_marketvalue")));
				dblTotalshares=rs.getDouble("com_paidshares");
			}
			

			strQuery = SQLParser.getSqlQuery("com_sel_shareholding^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			double dblsharepercent=0.0;
			double dblshares=0.0;
			while (rs.next()) {
				DecimalFormat dc=new DecimalFormat();
				dc.setGroupingUsed(false);
				dc.setMaximumFractionDigits(2);
				dc.setMinimumFractionDigits(2);
				arrVec = new ArrayList();
				//dblTotalshares
				arrVec.add(correctNull(rs.getString("com_compdtfname"))); // 0
				arrVec.add(correctNull(rs.getString("com_compdtlname"))); // 1
				arrVec.add(correctNull(rs.getString("com_compdtmname"))); // 2
				if(dblTotalshares!=0.0)
				{
					if(rs.isLast())
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						if(dblshares==dblTotalshares)
						{
							arrVec.add(""+(100.0-dblsharepercent));
						}
						else if(dblshares<dblTotalshares)
						{
							dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
							arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
						}
						else
						{
							arrVec.add("0.0");
						}
					}
					else
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
						arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
					}
					
				}
				else
				{
					arrVec.add("0.0");
				}
				//arrVec.add(correctNull(rs.getString("com_comdtpershare"))); // 3
				arrVec.add(correctNull(rs.getString("com_compdtshareheld"))); // 4
				arrVec.add(correctNull(rs.getString("CapContribution"))); // 5
				arrVec.add(correctNull(rs.getString("COM_FACEVALUE"))); // 6

				arrRow.add(arrVec);
			}

			hshRecord.put("arrRow", arrRow);

			strQuery = SQLParser.getSqlQuery("compromoterselectionpartner^"
					+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrVec = new ArrayList();
				arrVec.add(correctNull(rs.getString("COM_COMPDTTYPE")));
				arrVec.add(correctNull(rs.getString("com_compdtfname")));
				arrVec.add(correctNull(rs.getString("com_compdtlname")));
				arrVec.add(correctNull(rs.getString("com_compdtmname")));
				arrVec.add(correctNull(rs.getString("com_comdtpershare")));
				arrVec.add(correctNull(rs.getString("com_compdtshareheld")));
				arrVec.add(correctNull(rs.getString("CapContribution")));
				arrRow15.add(arrVec);
			}

			hshRecord.put("arrRow15", arrRow15);
			// End customer Promoters

			// 31.2 rating details

			strQuery = SQLParser.getSqlQuery("sel_irbcreditrating1_esp^"
					+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if(correctNull(rs.getString("description")).equals("Facility Rating(Dynamic Model)"))
				{
					hshRecord.put("facilityrating_dm_prevyear",correctNull(rs.getString("previous_year")));
					hshRecord.put("facilityrating_dm_curryear",correctNull(rs.getString("current_year")));
				}
				else if(correctNull(rs.getString("description")).equals("Facility Score(Dynamic Model)"))
				{
					hshRecord.put("facilityratingscore_dm_prevyear",correctNull(rs.getString("previous_year")));
					hshRecord.put("facilityratingscore_dm_curryear",correctNull(rs.getString("current_year")));
				}
				else
				{
					arrVecRate = new ArrayList();
					arrVecRate.add(correctNull(rs.getString("description")));
					arrVecRate.add(correctNull(rs.getString("previous_year")));
					arrVecRate.add(correctNull(rs.getString("current_year")));
					arrRow16.add(arrVecRate);
				}
			}
			hshRecord.put("arrRow16", arrRow16);
			// 31.3 rating details
//			strQuery = SQLParser.getSqlQuery("sel_irbcreditrating2_esp^"
//					+ appno);
//
//			if (rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) {
//				arrVecRate1 = new ArrayList();
//				arrVecRate1.add(correctNull(rs.getString("serial_no")));
//				arrVecRate1.add(correctNull(rs.getString("parameter")));
//				arrVecRate1.add(correctNull(rs.getString("score")));
//				arrVecRate1.add(correctNull(rs.getString("value")));
//				arrVecRate1.add(correctNull(rs.getString("secured")));
//				arrRow17.add(arrVecRate1);
//			}
//			hshRecord.put("arrRow17", arrRow17);

			// rating detail end
			strQuery = SQLParser
					.getSqlQuery("seltermsandconditionval^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrVec12 = new ArrayList();
				arrVec12.add(correctNull(rs.getString("terms_termdesc")));

				arrRow12.add(arrVec12);

			}
			hshRecord.put("arrRow12", arrRow12);

			strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"
					+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) {
				arrVec4 = new ArrayList();

				arrVec4.add(correctNull(rs.getString("com_compdtfname")));
				arrVec4.add(correctNull(rs.getString("com_compdtlname")));
				arrVec4.add(correctNull(rs.getString("com_compdtmname")));
				arrVec4.add(correctNull(rs.getString("com_compdaca")));
				String company_id = correctNull((String) rs
						.getString("com_compdtid"));
				if (rs1 != null) {
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcreditreport2^" + appno
						+ "^" + company_id);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					arrVec4.add(correctNull(rs1.getString("CR_Total_MEANS")));
					arrVec4.add(correctNull(rs1.getString("cr_meansason")));
				} else {
					arrVec4.add("0.00");
					arrVec4.add("");
				}
				arrVec4.add(correctNull(rs.getString("com_compdexp")));
				arrVec4.add(correctNull(rs.getString("com_background")));
				String strpromgua[] = correctNull(
						rs.getString("com_compdttype")).split("@");
		        ArrayList arrProCheck=new ArrayList();
				
				for(int i = 0; i < strpromgua.length; i++) {
			
					if (strpromgua[i].equals("G")) 
					{
						String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
						if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
						  arrGuarantors.add(arrVec4);
						else
							arrCorpguarantee.add(arrVec4);
						
					}
					else{
						
						if(!arrProCheck.contains("D") && !arrProCheck.contains("PT") && !arrProCheck.contains("SP") && !arrProCheck.contains("OT") && !strpromgua[i].equals("O"))
						{
						    if(strpromgua[i].equals("PT"))
							{
								arrVec4.add("Partner");
							
							}else if(strpromgua[i].equals("SP"))
							{
								arrVec4.add("Sole Proprietor");
								
							}
							else if(strpromgua[i].equals("D"))
							{
								arrVec4.add("Director");
								
							}else if(strpromgua[i].equals("OT")) {
								arrVec4.add(correctNull(rs.getString("com_compdtdesignation")));
							}
						    arrVec4.add(correctNull(rs.getString("COM_COMPDTDIN")));
						 	arrPromotors.add(arrVec4);
							
						}
				    }
					arrProCheck.add(strpromgua[i]);
					
				}
				if(correctNull(rs.getString("com_compdtfname")).equals("gen"))
				{
					hshRecord.put("background_promoters",correctNull(rs.getString("com_background")));
				}
				arrProback.add(arrVec4);
				
			}
			
			hshRecord.put("arrPromotors", arrPromotors);
			hshRecord.put("arrGuarantors", arrGuarantors);
			hshRecord.put("arrProback",arrProback);
			hshRecord.put("arrCorpguarantee",arrCorpguarantee);

			if (rs1 != null) {
				rs1.close();
			}

			strQuery = SQLParser.getSqlQuery("compromoterselectionguar^"
					+ appno);

			arrRow14 = new ArrayList();
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrVec41 = new ArrayList();

				arrVec41.add(correctNull(rs.getString("com_compdtfname")));
				arrVec41.add(correctNull(rs.getString("com_compdtlname")));
				arrVec41.add(correctNull(rs.getString("com_compdtmname")));
				arrVec41.add(correctNull(rs.getString("com_compdaca")));
				arrVec41.add(correctNull(rs.getString("com_compdtnetworth")));
				arrVec41.add(correctNull(rs.getString("com_compdexp")));

				arrRow14.add(arrVec41);
			}
			hshRecord.put("arrRow14", arrRow14);

			// Company Financial, Ratio & Assessment from page8

			hshformula.put("appno", appno);
			hshformula.put("comappid", comappid);

			arr = new ArrayList();
			arr.add("0");
			arr.add(CompanyName);
			arr1.add(arr);

			// Financial
			
			hshformula.put("pageval", "FI");
			hshformula.put("sel_divID", "0");
			hshValueFinancial = (HashMap) EJBInvoker.executeStateLess("executive", hshformula, "getData8");
			hshRecord.put("hshValueFinancial0", hshValueFinancial);

			// Cash Flow
			if (rs1 != null) {
				rs1 = null;
			}
			rs1 = DBUtils.executeLAPSQuery("executive_finnotes_sel^" + appno
					+ "^" + "CA" + "^" + "0");
			if (rs1.next()) {
				hshRecord.put("exec_notes0",correctNull(Helper.CLOBToString(rs1.getClob("notes"))));
			}
			
		
			// Finding any Divisions for the company

			/***if (rs != null) {
				rs = null;
			}
			rs = DBUtils.executeLAPSQuery("seldivisionsid^" + appno);

			while (rs.next()) {
				arr = new ArrayList();
				arr.add(correctNull(rs.getString("comapp_div_id")));
				arr.add(correctNull(rs.getString("comapp_div_name")));
				arr1.add(arr);
			}
			hshRecord.put("arrayDivision", arr1);

			// Division companies Financial, Ratio & Assessment

			if (arr1.size() > 0) {
				for (int i = 0; i < arr1.size(); i++) {
					hshValueFinancial = new HashMap();
					arr = new ArrayList();

					arr = (ArrayList) arr1.get(i);

					// Financial
					hshformula.put("pageval", "FI");
					hshformula.put("sel_divID", arr.get(0)); // division ID
					hshValueFinancial.put("company_name", Helper
							.correctNull((String) arr.get(1)));// division name
					hshValueFinancial = (HashMap) EJBInvoker.executeStateLess(
							"executive", hshformula, "getData8");
					hshRecord.put("hshValueFinancial" + arr.get(0),
							hshValueFinancial);

					// Cash Flow
					if (rs1 != null) {
						rs1 = null;
					}

					rs1 = DBUtils.executeLAPSQuery("executive_finnotes_sel^"
							+ appno + "^" + "CA" + "^" + arr.get(0));
					String flag = "false";
					if (rs1.next()) {
						flag = "true";
						b = null;
						aBlob = null;
						bios = new ByteArrayOutputStream();

						b = rs1.getBlob("notes");
						aBlob = b.getBytes(0, (int) b.length());
						bios.write(aBlob);
						bios.flush();
						bios.close();

						/*
						 * Clob clobData=rs1.getClob("notes"); Reader
						 * reader=clobData.getCharacterStream(); writer=new
						 * CharArrayWriter(); int z=-1;
						 * 
						 * while ( (z=reader.read())!=-1) { writer.write(z); }
						 *
					}
					if (flag == "true")
					{
						hshRecord.put("exec_notes" + arr.get(0),bios.toString());
					}
					if (flag == "false") {
						hshRecord.put("exec_notes" + arr.get(0), "");
					}

				}

			}***/

			/*
			 * String strINV="INV"; hshformula.put("pageval",strINV); HashMap
			 * hshValueFinancialINV =
			 * (HashMap)EJBInvoker.executeStateLess("notecombobassessment",hshformula,"getData");
			 * hshRecord.put("hshValueFinancialINV",hshValueFinancialINV);
			 * 
			 * String strWCA="WCA"; hshformula.put("pageval",strWCA); HashMap
			 * hshValueFinancialWCA =
			 * (HashMap)EJBInvoker.executeStateLess("notecombobassessment",hshformula,"getData");
			 * hshRecord.put("hshValueFinancialWCB",hshValueFinancialWCA);
			 */

			strQuery = SQLParser.getSqlQuery("conduct_sel^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {

				hshRecord.put("conduct_acc", correctNull(rs
						.getString("conduct_acc")));
				hshRecord.put("conduct_no", correctNull(rs
						.getString("conduct_no")));
				hshRecord.put("conduct_accstock", correctNull(rs
						.getString("conduct_accstock")));
				hshRecord.put("conduct_stockno", correctNull(rs
						.getString("conduct_stockno")));
				hshRecord.put("conduct_msod", correctNull(rs
						.getString("conduct_msod")));
				hshRecord.put("conduct_msodno", correctNull(rs
						.getString("conduct_msodno")));
				hshRecord.put("conduct_qpr", correctNull(rs
						.getString("conduct_qpr")));
				hshRecord.put("conduct_qprno", correctNull(rs
						.getString("conduct_qprno")));
				hshRecord.put("conduct_fin", Helper.correctDouble((String) rs
						.getString("conduct_fin")));
				hshRecord.put("conduct_finno", correctNull(rs
						.getString("conduct_finno")));
				hshRecord.put("conduct_cma", correctNull(rs
						.getString("conduct_cma")));
				hshRecord.put("conduct_cmano", correctNull(rs
						.getString("conduct_cmano")));
				hshRecord.put("conduct_stockstamt", correctNull(rs
						.getString("conduct_stockstamt")));
				hshRecord.put("conduct_stockdate", correctNull(rs
						.getString("conduct_stockdate")));
				hshRecord.put("conduct_msodstmt", correctNull(rs
						.getString("conduct_msodstmt")));
				hshRecord.put("conduct_msoddate", correctNull(rs
						.getString("conduct_msoddate")));
				hshRecord.put("conduct_qprstmt", correctNull(rs
						.getString("conduct_qprstmt")));
				hshRecord.put("conduct_qprdate", correctNull(rs
						.getString("conduct_qprdate")));
				hshRecord.put("conduct_turn", correctNull(rs
						.getString("conduct_turn")));
				hshRecord.put("conduct_excess", correctNull(rs
						.getString("conduct_excess")));
				hshRecord.put("conduct_cheques", correctNull(rs
						.getString("conduct_cheques")));
			}
			// hema
			strQuery = SQLParser.getSqlQuery("execsel_VALOFACCOUNT^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("EXEC_PFROM", correctNull(rs.getString("EXEC_PFROM")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PFROM")));
				hshRecord.put("EXEC_PTO", correctNull(rs.getString("EXEC_PTO")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PTO")));
				hshRecord.put("EXEC_CFROM", correctNull(rs
						.getString("EXEC_CFROM")));
				hshRecord
						.put("EXEC_CTO", correctNull(rs.getString("EXEC_CTO")));
				hshRecord.put("EXEC_PINTINC", correctNull(rs
						.getString("EXEC_PINTINC")));
				hshRecord.put("EXEC_CINTINC", correctNull(rs
						.getString("EXEC_CINTINC")));
				hshRecord.put("EXEC_PFEEINC", correctNull(rs
						.getString("EXEC_PFEEINC")));
				hshRecord.put("EXEC_CFEEINC", correctNull(rs
						.getString("EXEC_CFEEINC")));
				hshRecord.put("EXEC_PNOACS", correctNull(rs
						.getString("EXEC_PNOACS")));
				hshRecord.put("EXEC_PRETAILAMT", correctNull(rs
						.getString("EXEC_PRETAILAMT")));
				hshRecord.put("EXEC_CNOACS", correctNull(rs
						.getString("EXEC_CNOACS")));
				hshRecord.put("EXEC_CRETAILAMT", correctNull(rs
						.getString("EXEC_CRETAILAMT")));
				hshRecord.put("EXEC_POWNAMT", correctNull(rs
						.getString("EXEC_POWNAMT")));
				hshRecord.put("EXEC_COWNAMT", correctNull(rs
						.getString("EXEC_COWNAMT")));
				hshRecord.put("EXEC_POWNTENORDATE", correctNull(rs
						.getString("EXEC_POWNTENORDATE")));
				hshRecord.put("EXEC_COWNTENORDATE", correctNull(rs
						.getString("EXEC_COWNTENORDATE")));
				hshRecord.put("EXEC_PTHIRDAMT", correctNull(rs
						.getString("EXEC_PTHIRDAMT")));
				hshRecord.put("EXEC_CTHIRDAMT", correctNull(rs
						.getString("EXEC_CTHIRDAMT")));
				hshRecord.put("EXEC_PTHIRDTENORDATE", correctNull(rs
						.getString("EXEC_PTHIRDTENORDATE")));
				hshRecord.put("EXEC_CTHIRDTENORDATE", correctNull(rs
						.getString("EXEC_CTHIRDTENORDATE")));

			}

			// added for foreign currency
			String strforeign = SQLParser
					.getSqlQuery("execsel_FOREIGNCURRENCY^" + appno);
			String FOREIGN_FLAG = "NO";
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strforeign);
			if (rs.next()) {
				FOREIGN_FLAG = "YES";
				hshRecord.put("EXEC_EXPAMT1", correctNull(rs
						.getString("EXEC_EXPAMT1")));
				hshRecord.put("EXEC_UNHEDPOS1", correctNull(rs
						.getString("EXEC_UNHEDPOS1")));
				hshRecord.put("EXEC_DUEDATE1", correctNull(rs
						.getString("EXEC_DUEDATE1")));
				hshRecord.put("EXEC_EXPAMT2", correctNull(rs
						.getString("EXEC_EXPAMT2")));
				hshRecord.put("EXEC_UNHEDPOS2", correctNull(rs
						.getString("EXEC_UNHEDPOS2")));
				hshRecord.put("EXEC_DUEDATE2", correctNull(rs
						.getString("EXEC_DUEDATE2")));
				hshRecord.put("EXEC_EXPAMT3", correctNull(rs
						.getString("EXEC_EXPAMT3")));
				hshRecord.put("EXEC_UNHEDPOS3", correctNull(rs
						.getString("EXEC_UNHEDPOS3")));
				hshRecord.put("EXEC_DUEDATE3", correctNull(rs
						.getString("EXEC_DUEDATE3")));
				hshRecord.put("EXEC_EXPAMT4", correctNull(rs
						.getString("EXEC_EXPAMT4")));
				hshRecord.put("EXEC_UNHEDPOS4", correctNull(rs
						.getString("EXEC_UNHEDPOS4")));
				hshRecord.put("EXEC_DUEDATE4", correctNull(rs
						.getString("EXEC_DUEDATE4")));
				hshRecord.put("EXEC_EXPAMT5", correctNull(rs
						.getString("EXEC_EXPAMT5")));
				hshRecord.put("EXEC_UNHEDPOS5", correctNull(rs
						.getString("EXEC_UNHEDPOS5")));
				hshRecord.put("EXEC_DUEDATE5", correctNull(rs
						.getString("EXEC_DUEDATE5")));
				hshRecord.put("EXEC_EXPAMT6", correctNull(rs
						.getString("EXEC_EXPAMT6")));
				hshRecord.put("EXEC_UNHEDPOS6", correctNull(rs
						.getString("EXEC_UNHEDPOS6")));
				hshRecord.put("EXEC_DUEDATE6", correctNull(rs
						.getString("EXEC_DUEDATE6")));
				hshRecord.put("EXEC_EXPAMT7", correctNull(rs
						.getString("EXEC_EXPAMT7")));
				hshRecord.put("EXEC_UNHEDPOS7", correctNull(rs
						.getString("EXEC_UNHEDPOS7")));
				hshRecord.put("EXEC_DUEDATE7", correctNull(rs
						.getString("EXEC_DUEDATE7")));
				hshRecord.put("EXEC_EXPAMT8", correctNull(rs
						.getString("EXEC_EXPAMT8")));
				hshRecord.put("EXEC_UNHEDPOS8", correctNull(rs
						.getString("EXEC_UNHEDPOS8")));
				hshRecord.put("EXEC_DUEDATE8", correctNull(rs
						.getString("EXEC_DUEDATE8")));
			}

			hshRecord.put("FOREIGN_FLAG", FOREIGN_FLAG);

			// added for details of excess

			String strexcess = SQLParser.getSqlQuery("execsel_DETAILEXCESS^"
					+ appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strexcess);
			if (rs.next()) {
				hshRecord.put("EXEC_NOEXCESS", correctNull(rs
						.getString("EXEC_NOEXCESS")));
				hshRecord.put("EXEC_MAXEXCESS", correctNull(rs
						.getString("EXEC_MAXEXCESS")));
				hshRecord.put("EXEC_OTHEXP", correctNull(rs
						.getString("EXEC_OTHEXP")));
				hshRecord.put("EXEC_OTHLIAB", correctNull(rs
						.getString("EXEC_OTHLIAB")));
				hshRecord.put("EXEC_CONDEXP", correctNull(rs
						.getString("EXEC_CONDEXP")));
				hshRecord.put("EXEC_RAROC", correctNull(rs.getString("EXEC_RAROC")));
			}

			// operational experience
			String stroperexp = SQLParser.getSqlQuery("execgrpconsel^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(stroperexp);
			double dblgccomlimit = 0.0;
			double dblgccomos = 0.0;
			double dblgcfbwclt = 0.0;
			double dblgcfbwcpd = 0.0;
			double dblgcfbwcos = 0.0;
			double dblgctllt = 0.0;
			double dblgctlos = 0.0;
			double dblgcins = 0.0;

			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("EXEC_GCCONNAME")));
				arrCol.add(correctNull(rs.getString("EXEC_GCBRANCH")));
				arrCol.add(correctNull(rs.getString("EXCE_GCCOA")));
				dblgccomlimit = dblgccomlimit
						+ (rs.getDouble("EXEC_GCCOMLIMIT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMLIMIT")));
				dblgccomos = dblgccomos + (rs.getDouble("EXEC_GCCOMOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMOS")));
				dblgcfbwclt = dblgcfbwclt + (rs.getDouble("EXEC_GCFBWCLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCLT")));
				dblgcfbwcpd = dblgcfbwcpd + (rs.getDouble("EXEC_GCFBWCDP"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCDP")));
				dblgcfbwcos = dblgcfbwcos + (rs.getDouble("EXEC_GCFBWCOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCOS")));
				dblgctllt = dblgctllt + (rs.getDouble("EXEC_GCTLLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLLT")));
				dblgctlos = dblgctlos + (rs.getDouble("EXEC_GCTLOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLOS")));
				dblgcins = dblgcins + (rs.getDouble("EXEC_GCINS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCINS")));
				arrCol.add(correctNull(rs.getString("EXEC_GCMOR")));
				arrCol.add(correctNull(rs.getString("EXEC_GCIRREG")));
				arrCol.add(correctNull(rs.getString("comapp_div_name")));
				arrVec_supp.add(arrCol);
			}
			hshRecord.put("oper_info", arrVec_supp);
			hshRecord.put("EXEC_GCCOMLIMIT", Helper.formatDoubleValue(dblgccomlimit));
			hshRecord.put("EXEC_GCCOMOS", Helper.formatDoubleValue(dblgccomos));
			hshRecord.put("EXEC_GCFBWCLT", Helper.formatDoubleValue(dblgcfbwclt));
			hshRecord.put("EXEC_GCFBWCDP", Helper.formatDoubleValue(dblgcfbwcpd));
			hshRecord.put("EXEC_GCFBWCOS", Helper.formatDoubleValue(dblgcfbwcos));
			hshRecord.put("EXEC_GCTLLT", Helper.formatDoubleValue(dblgctllt));
			hshRecord.put("EXEC_GCTLOS", Helper.formatDoubleValue(dblgctlos));
			hshRecord.put("EXEC_GCINS", Helper.formatDoubleValue(dblgcins));

			strQuery = SQLParser.getSqlQuery("execsel_port^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
				hshRecord.put("due_diligence", correctNull(rs.getString("due_diligence")));
				hshRecord.put("exec_borrowertype", correctNull(rs.getString("exec_borrowertype")));
				hshRecord.put("credit_since", correctNull(rs.getString("credit_since")));
				hshRecord.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
				hshRecord.put("exec_date", correctNull(rs.getString("exec_date")));
				hshRecord.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
				hshRecord.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
				hshRecord.put("exec_comments", correctNull(rs.getString("exec_comments_sisterconcern")).equals("")?"Nil":correctNull(rs.getString("exec_comments_sisterconcern")));
				strBorrowerType=correctNull(rs.getString("exec_borrowertype"));
				hshRecord.put("exec_borrowertype",strBorrowerType);
				hshRecord.put("exec_sancauth", correctNull(rs.getString("exec_sancauth")));
				strSanctauth = Helper.correctNull((String)rs.getString("exec_sancauth"));
				hshRecord.put("exec_refno", correctNull(rs.getString("exec_refno")));
				hshRecord.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
				hshRecord.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
				hshRecord.put("present_req", correctNull(rs.getString("exec_presentreq")).equals("")?"Nil":correctNull(rs.getString("exec_presentreq")));			
			}
			if(rs!=null)
				rs.close();
//			strQuery=SQLParser.getSqlQuery("exec_guadetailsel^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) {
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("exec_guaname"));
//				arryCol.add(rs.getString("exec_tnw"));
//
//				arrCorpguarantee.add(arryCol);
//
//			}
//			hshRecord.put("arrCorpguarantee", arrCorpguarantee);
			
			rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + appno+"^Collateral");
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(rs.getString("sec_desc_details"));
				arryCol.add(rs.getString("sec_desc_value"));
				arryCol.add(rs.getString("as_on_date"));
				arryCol.add(rs.getString("sec_valuersname"));
				arryCol.add(rs.getString("sec_insuranceamt"));
				arryCol.add(rs.getString("sec_insexpirydate"));
				arryCol.add(rs.getString("sec_remarks"));

				arrColldetails.add(arryCol);

			}
			hshRecord.put("arrColldetails", arrColldetails);

			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("pro_takeoversel^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("istakeover", correctNull(rs
						.getString("istakeover")));
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("takeoverworkingsel^" + appno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				arrworkingCol = new ArrayList();
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_NORMS")));
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_NORMSAVAIL")));
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_REASONS")));
				arrworkingRow.add(arrworkingCol);

			}
			hshRecord.put("arrworkingRow", arrworkingRow);
			if (rs != null)
				rs.close();

			strQuery = SQLParser.getSqlQuery("takeovertermsel^" + appno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				arrtermsCol = new ArrayList();
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_NORMS")));
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_STATUS")));
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_REASON")));
				arrtermsRow.add(arrtermsCol);
			}
			hshRecord.put("arrtermsRow", arrtermsRow);
			// --------------------To Fetch Values from Page 2
			// ------------------------

			strQuery = SQLParser.getSqlQuery("execsel_inducom^" + appno);

			if (rs1 != null)
				rs1.close();
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {

				hshRecord.put("exec_summ_mortage", correctNull(rs1
						.getString("exec_summ_mortage")));
				hshRecord.put("exec_summ_mortageY", correctNull(rs1
						.getString("exec_summ_mortageY")));
				hshRecord.put("exec_summ_roc", correctNull(rs1
						.getString("exec_summ_roc")));
				hshRecord.put("exec_summ_rocY", correctNull(rs1
						.getString("exec_summ_rocY")));
				hshRecord.put("exec_summ_validdoc", correctNull(rs1
						.getString("exec_summ_validdoc")));
				hshRecord.put("exec_summ_validdocY", correctNull(rs1
						.getString("exec_summ_validdocY")));
				hshRecord.put("exec_summ_terms", correctNull(rs1
						.getString("exec_summ_terms")));
				hshRecord.put("exec_summ_termsY", correctNull(rs1
						.getString("exec_summ_termsY")));
				hshRecord.put("exec_summ_meetingheld", correctNull(rs1
						.getString("exec_summ_meetingheld")));
				hshRecord.put("exec_summ_meetingheldY", correctNull(rs1
						.getString("exec_summ_meetingheldY")));
				hshRecord.put("exec_summ_indlevelsubopm", correctNull(rs1
						.getString("exec_summ_indlevelsubopm")));
				hshRecord.put("exec_summ_indlevelsubcov", correctNull(rs1
						.getString("exec_summ_indlevelsubcov")));

				hshRecord.put("exec_summ_indlevelsubroce", correctNull(rs1
						.getString("exec_summ_indlevelsubroce")));
				hshRecord.put("exec_summ_indlevelsubcr", correctNull(rs1
						.getString("exec_summ_indlevelsubcr")));
				hshRecord.put("exec_summ_indlevelsubtol", correctNull(rs1
						.getString("exec_summ_indlevelsubtol")));
				hshRecord.put("exec_summ_dateofinspc2", correctNull(rs1
						.getString("exec_summ_dateofinspc")));
				hshRecord.put("exec_summ_indlevelotherrisk2", correctNull(rs1
						.getString("exec_summ_indlevelotherrisk")));

				hshRecord.put("exec_summ_indlevelrbiY2", correctNull(rs1
						.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks2", correctNull(rs1
						.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankY2", correctNull(rs1
						.getString("exec_summ_indlevelbankY")));
				hshRecord.put("exec_summ_indlevelbankremarks2", correctNull(rs1
						.getString("exec_summ_remarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths2",
						correctNull(rs1.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelcomkeyweakness2",
						correctNull(rs1.getString("exec_summ_weakness")));

			}

			// --------------------To Fetch Values from Page 3
			// ------------------------

			strQuery = SQLParser.getSqlQuery("execsel_summary^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("EXEC_EVAL_MAGMT", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_MAGMT"))));
				hshRecord.put("EXEC_EVAL_INDUSTRY", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_INDUSTRY"))));
				hshRecord.put("EXEC_EVAL_BUSSINESSRISK", correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_BUSSINESSRISK"))));

			}
			
			// ---------------To Fetch Values from Page 4
			// ----------------------------

			strQuery = SQLParser.getSqlQuery("selexec_finratio^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				
				hshRecord.put("exec_summ_finTL1", correctNull(rs.getString("exec_summ_finTL1")));
				hshRecord.put("exec_summ_finTOL1", correctNull(rs.getString("exec_summ_finTOL1")));
				hshRecord.put("exec_summ_fincurrentratio1", correctNull(rs.getString("exec_summ_fincurrentratio1")));
				hshRecord.put("exec_summ_findscr1", correctNull(rs.getString("exec_summ_findscr1")));
				hshRecord.put("exec_summ_fincovratio1", correctNull(rs.getString("exec_summ_fincovratio1")));
				
				hshRecord.put("exec_summ_finTL2", correctNull(rs.getString("exec_summ_finTL2")));
				hshRecord.put("exec_summ_finTOL2", correctNull(rs.getString("exec_summ_finTOL2")));
				hshRecord.put("exec_summ_fincurrentratio2", correctNull(rs.getString("exec_summ_fincurrentratio2")));
				hshRecord.put("exec_summ_findscr2", correctNull(rs.getString("exec_summ_findscr2")));
				hshRecord.put("exec_summ_fincovratio2", correctNull(rs.getString("exec_summ_fincovratio2")));
				
				hshRecord.put("exec_summ_finTL3", correctNull(rs.getString("exec_summ_finTL3")));
				hshRecord.put("exec_summ_finTOL3", correctNull(rs.getString("exec_summ_finTOL3")));
				hshRecord.put("exec_summ_fincurrentratio3", correctNull(rs.getString("exec_summ_fincurrentratio3")));
				hshRecord.put("exec_summ_findscr3", correctNull(rs.getString("exec_summ_findscr3")));
				hshRecord.put("exec_summ_fincovratio3", correctNull(rs.getString("exec_summ_fincovratio3")));
				
				hshRecord.put("exec_summ_finTL4", correctNull(rs.getString("exec_summ_finTL4")));
				hshRecord.put("exec_summ_finTOL4", correctNull(rs.getString("exec_summ_finTOL4")));
				hshRecord.put("exec_summ_fincurrentratio4", correctNull(rs.getString("exec_summ_fincurrentratio4")));
				hshRecord.put("exec_summ_findscr4", correctNull(rs.getString("exec_summ_findscr4")));
				hshRecord.put("exec_summ_fincovratio4", correctNull(rs.getString("exec_summ_fincovratio4")));
				

			}

			// ---------------To Fetch Values from Page 5
			// ----------------------------

			strQuery = SQLParser.getSqlQuery("execsel_credit^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_summ_indlevelrbiY", correctNull(rs.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks", correctNull(rs.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankremarks", correctNull(rs.getString("exec_summ_indlevelbankremarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths",correctNull(rs.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelgenmanager", correctNull(rs.getString("exec_summ_manager")));
			}

			/*
			 * To Fetch Values from Proposal ->Operational Details ->Auditor
			 * Observation / Major Inspection Irregularities
			 * 
			 * Done by: Murali c
			 * Changed by Sureshkumar As per bank requirement on 01-Feb-2010
			 */

			String audit_type = "";
			strQuery = SQLParser.getSqlQuery("selallauditobservation^"+appno);
			if (rs != null) {
				rs.close();
			}
			ArrayList arrInternal=new ArrayList();
			ArrayList arrStatutory =new ArrayList();
			ArrayList arrConcurrent=new ArrayList();
			ArrayList arrStock=new ArrayList();
			ArrayList arrRBI=new ArrayList();
			
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("adv_auditorsobservations")));
				arrCol.add(correctNull(rs.getString("adv_branchcomments")));
				
				audit_type = correctNull((String) rs.getString("adv_audittype"));
				if (audit_type.equalsIgnoreCase("1")) {
					arrInternal.add(arrCol);
					hshRecord.put("audit_internal_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("2")) {
					arrConcurrent.add(arrCol);
					hshRecord.put("audit_concurrent_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("3")) {
					arrRBI.add(arrCol);
					hshRecord.put("audit_inspection_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("4")) {
					arrStatutory.add(arrCol);
					hshRecord.put("audit_statutory_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("5")) {
					arrStock.add(arrCol);
					hshRecord.put("audit_stock_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("adv_dateaudited")));
				}
			}
			
			hshRecord.put("arrInternal", arrInternal);
			hshRecord.put("arrConcurrent", arrConcurrent);
			hshRecord.put("arrRBI", arrRBI);
			hshRecord.put("arrStatutory", arrStatutory);
			hshRecord.put("arrStock", arrStock);

			/*
			 * FETCH TANGIBLE NETWORTH(TNW) VALUE FROM FINANCIALS
			 * 
			 * Done by: Murali
			 */

			String curDate = "";
			String strDesc = "";
			String strCurDate = "";
			String cma = "";

			curDate = Helper.getCurrentDateTime();

			if (rs5 != null)
				rs5.close();

			String baseyear_query = SQLParser
					.getSqlQuery("sel_financial_baseyear^" + appno);
			rs5 = DBUtils.executeQuery(baseyear_query);

			if (rs5.next()) {
				curDate = correctNull((String) rs5
						.getString("base_year"));
			}

			strQuery = SQLParser.getSqlQuery("executive_finselect9^" + appno
					+ "^" + "0" + "^" + curDate);
			if (rs5 != null)
				rs5.close();
			rs5 = DBUtils.executeQuery(strQuery);

			if (rs5.next()) {
				if (rs5.getDouble("sumaudit") > 0) {
					strDesc = "a";
				} else if (rs5.getDouble("sumunaudit") > 0) {
					strDesc = "u";
				} else if (rs5.getDouble("sumestimated") > 0) {
					strDesc = "e";
				} else if (rs5.getDouble("sumprojection") > 0) {
					strDesc = "p";
				}
				strCurDate = rs5.getString("fin_year");

			}

			//strQuery = SQLParser.getSqlQuery("notefinselect8^" + appno);
			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+appno);
			
			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				//cma = rs.getString("cma_no");
				cma=correctNull(rs.getString("demo_finstandard"));
			}

			if (cma != "") {
				strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^" + cma);
			}
			if (rs2 != null)
				rs2.close();
			rs2 = DBUtils.executeQuery(strQuery);

			String strRowtype = "";
			String strRowid = "";
			int strRowformula = 0;
			int strRowformula2 = 0;
			String strTangibleNetworth = "0.00";

			if (rs2.next()) {
				strRowtype = correctNull(rs2.getString("fin_rowtype"));
				strRowid = correctNull(rs2.getString("fin_rowid"));
				strRowformula = rs2.getInt("fin_formula");
				strRowformula2 = rs2.getInt("fin_formula2");

				if (strRowtype.trim().equals("C") && strRowformula > 0
						&& !strDesc.trim().equals("")) {
					hashformula = new HashMap();
					hashformula.put("appno", appno);
					hashformula.put("sel_divID", "0");
					hashformula.put("formulaid", Integer
							.toString(strRowformula));
					hashformula.put("curryear", strCurDate);
					hashformula.put("prevyear", "");
					hashformula.put("currfinancialtype", strDesc);
					hashformula.put("prevfinancialtype", "");
					hshResult = (HashMap) EJBInvoker.executeStateLess("comformula", hashformula, "GetFinValue");
					strTangibleNetworth = correctNull((String) hshResult.get("strTotalValue"));
				}
			}

			hshRecord.put("TangibleNetworth", strTangibleNetworth);
			hshRecord.put("TNWason",strCurDate);
			/*
			 * Calculating Paid-up capital : Formula: Total Capital Contribution
			 * of Share Holders
			 * 
			 * Done by: Murali
			 */

			String tot_capital_contribution = "0.00";
			strQuery = SQLParser
					.getSqlQuery("total_pro_gua_capitalcontribution^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				tot_capital_contribution = Helper.formatDoubleValue(rs.getDouble("TotCapContribution"));
			}

			hshRecord.put("PaidupCapital", tot_capital_contribution);

			/******************************************************************
			 * Caluculating Total of Fundbased and NonFundbased Limit(TL+WC)
			 * Formula: Total Fundbased = Term Loan Funded + Working Capital
			 * Funded Total NonFundbased = Term Loan NonFunded + Working Capital
			 * NonFunded
			 * 
			 * Done by: Murali
			 * 
			 * Commented by G.Sureshkumar Since Bank wants only percentage
			 * 
			 * so it is commented and the same is added in the  "comoperationaldata1"
			 ******************************************************************************/

			/*String tot_funded = "0.00";
			String tot_nonfunded = "0.00";

			strQuery = SQLParser.getSqlQuery("com_total_fundbased^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				tot_funded = Helper.correctDouble(correctNull(rs.getString(2)));
			}

			hshRecord.put("TOTAL_FUNDED", tot_funded);

			strQuery = SQLParser.getSqlQuery("com_total_nonfundbased^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				tot_nonfunded = Helper.correctDouble(correctNull(rs
						.getString(2)));
			}

			hshRecord.put("TOTAL_NONFUNDED", tot_nonfunded);*/

			/*************************************************************
			 * Our Bank - UBI Total Working Capital(Funded & NonFunded) Total
			 * Term Loan(Funded + NonFunded)
			 * 
			 * Done by: Murali
			 ******************************************************************/

			double wc_funded_existing = 0.00, wc_funded_proposed = 0.00;
			double wc_nonfunded_existing = 0.00, wc_nonfunded_proposed = 0.00;
			double tl_funded_existing = 0.00, tl_funded_proposed = 0.00;
			//double tl_nonfunded_existing = 0.00, tl_nonfunded_proposed = 0.00;
			double tl_total_existing = 0.00, tl_total_proposed = 0.00;
			double total_existing = 0.00, total_proposed = 0.00;

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("WC_FUNDED_TOTAL^" + appno);
			if (rs.next()) {
				wc_funded_existing = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("WC_FUNDED_EXISTING"))));
				wc_funded_proposed = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("WC_FUNDED_PROPOSED"))));
			}
			if (rs != null) {
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("WC_NONFUNDED_TOTAL^" + appno);
			if (rs.next()) {
				wc_nonfunded_existing = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("WC_NONFUNDED_EXISTING"))));
				wc_nonfunded_proposed = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("WC_NONFUNDED_PROPOSED"))));
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("TL_FUNDED_TOTAL^" + appno);
			if (rs.next()) {
				tl_funded_existing = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("TL_FUNDED_EXISTING"))));
				tl_funded_proposed = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("TL_FUNDED_PROPOSED"))));
			}
			if (rs != null) {
				rs.close();
			}

			/*rs = DBUtils.executeLAPSQuery("TL_NONFUNDED_TOTAL^" + appno);
			if (rs.next()) {
				tl_nonfunded_existing = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("TL_NONFUNDED_EXISTING"))));
				tl_nonfunded_proposed = Double.parseDouble(Helper
						.correctDouble(correctNull((String) rs
								.getString("TL_NONFUNDED_PROPOSED"))));
			}*/

			tl_total_existing = tl_funded_existing ;//+ tl_nonfunded_existing;
			tl_total_proposed = tl_funded_proposed ;//+ tl_nonfunded_proposed;

			total_existing = wc_funded_existing + wc_nonfunded_existing
					+ tl_total_existing;
			total_proposed = wc_funded_proposed + wc_nonfunded_proposed
					+ tl_total_proposed;

			hshRecord.put("wc_funded_existing", Double
					.toString(wc_funded_existing));
			hshRecord.put("wc_funded_proposed", Double
					.toString(wc_funded_proposed));
			hshRecord.put("wc_nonfunded_existing", Double
					.toString(wc_nonfunded_existing));
			hshRecord.put("wc_nonfunded_proposed", Double
					.toString(wc_nonfunded_proposed));
			hshRecord.put("tl_total_existing", Double
					.toString(tl_total_existing));
			hshRecord.put("tl_total_proposed", Double
					.toString(tl_total_proposed));
			hshRecord.put("total_existing", Helper.formatDoubleValue(total_existing));
			hshRecord.put("total_proposed", Helper.formatDoubleValue(total_proposed));

			ArrayList arrSecRemarkscol=new ArrayList();
			ArrayList arrSecRemarksrow=new ArrayList();
			/*
			 * To get Our Bank facility wise details (WC & TL)
			 * 
			 * Done by: Murali
			 */

			//arrOurBank = new ArrayList();
			OurBank_WC_Funded = new ArrayList();
			OurBank_WC_NonFunded = new ArrayList();
			OurBank_TL = new ArrayList();
			// int d2b=0;
			// int d2=0;

			// WC NON FUNDED FACILITY DETAILS

			if (rs != null) {
				rs.close();
			}
			//int intgroup=0;
			strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				int d2b = 0;
				WC_NonFunded = new ArrayList();
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
					WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
					WC_NonFunded.add(Helper.formatDoubleValue(rs.getDouble("facility_existing"))); 		//1
					WC_NonFunded.add(Helper.formatDoubleValue(rs.getDouble("facility_proposed"))); 		//2
					WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
					WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
					WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
					WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
					WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
					WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

					String strfacheadid = correctNull(rs.getString("facility_headid"));
				
					//By Gokul.C for the sub facilities
					arrSubFac = new ArrayList();
					arrSubFac = getSubFacilitiesData(appno,strFacSno,"NFD");				//9
					WC_NonFunded.add(arrSubFac);
					//end for sub-facilities
					WC_NonFunded.add(correctNull(rs.getString("bplr")));					//10
					WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
					WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
					WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
					WC_NonFunded.add(strfacheadid);											//14
					
				/**
				 * By venu & Sureshkumar
				 * if you want additional field add here only and then change in
				 * executiveprint.jsp now rowid=15 change rowid=16 in security
				 * column
				 */
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno
						+ "^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) {
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_NonFunded.add(arrSecurities);
				WC_NonFunded.add(""+j);
				/*strQuery = SQLParser.getSqlQuery("secfacilitywise^" + appno
						+ "^" + strfacheadid + "^" + strfacsubid);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					String strVal = correctNull(rs1.getString(1));

					strQuery = SQLParser.getSqlQuery("propfacmastersel1^"
							+ strVal);
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						String secdetails = correctNull(rs1.getString(3));
						if (!secdetails.equalsIgnoreCase("")) {
							d2b = d2b + 1;
							WC_NonFunded.add(correctNull(rs1.getString(3))); // Modified by Sureshkumar 
							//As per Bank requirement that details captured in the screen to be shown in the
							//executive printout point no 35.1 (Security column)
						}
					}

					if (d2b == 0) {
						for (int d3b = 1; d3b <= d2b; d3b++) {
							WC_NonFunded.add("");
						}
					}

				}
				int valsecol = d2b;
				String valfacstrseccol = Integer.toString(valsecol);
				WC_NonFunded.add((valfacstrseccol));*/
				// Don't add additional field here

				
				OurBank_WC_NonFunded.add(WC_NonFunded);
				
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_NonFunded", OurBank_WC_NonFunded);

			// WC FUNDED FACILITY DETAILS

			if (rs != null) {
				rs.close();
			}

//-----------------------------------------------------------------------------------------------------------------------------------------------------
			strQuery = SQLParser.getSqlQuery("com_wc_funded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				int d2 = 0;
				WC_Funded = new ArrayList();
				WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
				WC_Funded.add(correctNull(rs.getString("facility_existing")));
				WC_Funded.add(correctNull(rs.getString("facility_proposed")));
				WC_Funded.add(correctNull(rs.getString("facility_margin")));
				WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
				WC_Funded.add(correctNull(rs.getString("facility_dp")));
				WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
				WC_Funded.add(correctNull(rs.getString("security_value")));
				WC_Funded.add(correctNull(rs.getString("facility_desc")));

				//
				String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
//By Gokul.C for the sub facilities
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"FD");
				WC_Funded.add(arrSubFac);
//end for sub-facilities	
				WC_Funded.add(correctNull(rs.getString("bplr")));
				WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
				WC_Funded.add(correctNull(rs.getString("facility_category")));
				WC_Funded.add(correctNull(rs.getString("facility_months")));
				WC_Funded.add(correctNull(rs.getString("facility_headid")));
				

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno
						+ "^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) {
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_Funded.add(arrSecurities);
				WC_Funded.add(""+j);
				/*strQuery = SQLParser.getSqlQuery("secfacilitywise^" + appno
						+ "^" + strfacheadid + "^" + strfacsubid);
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					String strVal = correctNull(rs1.getString(1));

					strQuery = SQLParser.getSqlQuery("propfacmastersel1^"
							+ strVal);
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						String secdetails = correctNull(rs1.getString(3));
						if (!secdetails.equalsIgnoreCase("")) {
							d2 = d2 + 1;
							WC_Funded.add(correctNull(rs1.getString(3)));// Modified by Sureshkumar 
							//As per Bank requirement that details captured in the screen to be shown in the
							//executive printout point no 35.1 (Security column)
						}

					}

					if (d2 == 0) {
						for (int d3b = 1; d3b <= d2; d3b++) {
							WC_Funded.add("");
						}
					}

				}
				int valsecol1 = d2;
				String valfacstrseccol1 = Integer.toString(valsecol1);
				WC_Funded.add((valfacstrseccol1));*/
				// Don't add additional field here

				OurBank_WC_Funded.add(WC_Funded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_Funded", OurBank_WC_Funded);

			// TL FUNDED & NON FUNDED FACILITY DETAILS

			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser
					.getSqlQuery("com_tl_funded_nonfunded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				int d3 = 0;
				TL_Funded_NonFunded = new ArrayList();
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_catdesc")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_existing")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_proposed")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_margin")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_intremarks")));
				TL_Funded_NonFunded
						.add(correctNull(rs.getString("facility_dp")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_outstanding")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("security_value")));
				TL_Funded_NonFunded.add(correctNull(rs
						.getString("facility_desc")));

				//
				String strfacheadid = correctNull(rs
						.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
//By Gokul.C for the sub facilities
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"TL");
				TL_Funded_NonFunded.add(arrSubFac);
//end for sub-facilities	
				TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));
				/**
				 * By venu & Sureshkumar
				 * if you want additional field add here only and then change in
				 * executiveprint.jsp now rowid=15 change rowid=16 in securityfacility_months
				 * column
				 */

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno
						+ "^" +  appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) {
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				TL_Funded_NonFunded.add(arrSecurities);
				TL_Funded_NonFunded.add(""+j);
				/*strQuery = SQLParser.getSqlQuery("secfacilitywise^" + appno
						+ "^" + strfacheadid + "^" + strfacsubid);
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					String strVal = correctNull(rs1.getString(1));

					strQuery = SQLParser.getSqlQuery("propfacmastersel1^"
							+ strVal);
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						String secdetails = correctNull(rs1.getString(3));
						if (!secdetails.equalsIgnoreCase("")) {
							d3 = d3 + 1;
							TL_Funded_NonFunded.add(correctNull(rs1
									.getString(3)));// Modified by Sureshkumar 
							//As per Bank requirement that details captured in the screen to be shown in the
							//executive printout point no 35.1 (Security column)
						}
					}

					if (d3 == 0) {
						for (int d3b = 1; d3b <= d3; d3b++) {
							TL_Funded_NonFunded.add("");
						}
					}

				}
				int valsecol2 = d3;
				String valfacstrseccol2 = Integer.toString(valsecol2);
				TL_Funded_NonFunded.add((valfacstrseccol2));
				// Don't add additional field here*/

				
				OurBank_TL.add(TL_Funded_NonFunded);
				
				
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
				hshRecord.put("arrSecRemarks",arrSecRemarksrow);
			}

			hshRecord.put("OurBank_TL", OurBank_TL);
//--------------------------------------------------------------------------------------------------------------------------			
			//Added by Mercy for Comments
			strQuery = SQLParser.getSqlQuery("sel_assessmentoflimit^" + appno);//Assessment of Limit
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_limitassessmnent_comments",correctNull(Helper.CLOBToString(rs.getClob("com_limitassessmnent_comments"))));
			}
			strQuery = SQLParser.getSqlQuery("sel_projectedsales^" + appno);//Projected of Sales
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_projectedsales_comments",correctNull(Helper.CLOBToString(rs.getClob("com_projectedsales_comments"))));
			}
			strQuery = SQLParser.getSqlQuery("sel_termloanassessmentcomments^" + appno);//Assessment of Term Loan
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_termloan_comments",correctNull(Helper.CLOBToString(rs.getClob("com_termloan_comments"))));
			}
			strQuery = SQLParser.getSqlQuery("sel_nonfundassessment^" + appno);//Assessment of Non-fund Limits
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_nonfund_comments",correctNull(Helper.CLOBToString(rs.getClob("com_nonfund_comments"))));
			}
			strQuery = SQLParser.getSqlQuery("sel_holdinglevel^" + appno);//Holding Levels
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_holdinglevel_comments",correctNull(Helper.CLOBToString(rs.getClob("com_holdinglevel_comments"))));
			}
			strQuery = SQLParser.getSqlQuery("sel_assessment^" + appno);//Assessment
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_assessment_comments",correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))));
			}
			
			
			//to fetch values from summary changes
			if(rs!=null)rs.close();
			
			arrsummaryfac=new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_exec_sanctermsgeneral^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrsummary1=new ArrayList();
				arrsummary1.add(correctNull((String)rs.getString("exec_sanctionterms")));//0
				arrsummary1.add(correctNull((String)rs.getString("exec_stipearlier")));//1
				arrsummary1.add(correctNull((String)rs.getString("exec_recmdnow")));//2
				arrsummary1.add(correctNull((String)rs.getString("exec_present")));//3
				arrsummary.add(arrsummary1);
			}
			hshRecord.put("arrsummary",arrsummary);
			
			strQuery = SQLParser.getSqlQuery("sel_exec_sanctermsfacility^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrsummaryfacwise=new ArrayList();
				arrsummaryfacwise.add(correctNull((String)rs.getString("facility")));//0
				arrsummaryfacwise.add(correctNull((String)rs.getString("exec_sanctionterms")));//1
				arrsummaryfacwise.add(correctNull((String)rs.getString("exec_stipearlier")));//2
				arrsummaryfacwise.add(correctNull((String)rs.getString("exec_recmdnow")));//3
				arrsummaryfacwise.add(correctNull((String)rs.getString("exec_present")));//4
				arrsummaryfac.add(arrsummaryfacwise);
			}
			hshRecord.put("arrsummaryfac",arrsummaryfac);
				
			strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+appno);
 			if(rs!=null)
 			{
 				rs.close();
 			}
 			String Strproposalvaluesin="";
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				Strproposalvaluesin=correctNull(rs.getString("prop_valuesin"));
 				hshRecord.put("proposalvaluesin",Strproposalvaluesin);
 			}
 			
 			if(rs!=null)
 			{
 				rs.close();
 			}
			
 			hshRecord.putAll(getExposuredetails(strIndcode,Strproposalvaluesin,strIndustryType,strGroup));
	 			
 			// For Assessment type 
 			String assessment_type="";
 			strQuery = SQLParser.getSqlQuery("sel_assessmenttype^"+appno);
 			rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					assessment_type = correctNull((String)rs.getString("com_assessmenttype"));
				}
				
				//This Condition is for Turn Over Methord,Flexible Bank Finance,NBFC1,NBFC2
				if(!(assessment_type.equalsIgnoreCase("CBM")))
				{
					/*hshValueFinancial=new HashMap();
					hshformula.put("pageval", assessment_type);
					hshformula.put("sel_divID", "0");
					hshValueFinancial = (HashMap) EJBInvoker.executeStateLess("combobassessment", hshformula, "getData");
					hshRecord.put("hshValueAssessmentType", hshValueFinancial);*/
					
					strQuery=SQLParser.getSqlQuery("selfinassessvalues^"+appno+"^0");
					rs=DBUtils.executeQuery(strQuery);
					arrRow=new ArrayList();
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(correctNull(rs.getString("finassess_rowdesc")));
						arrCol.add(correctNull(rs.getString("finassess_year1")));
						arrCol.add(correctNull(rs.getString("finassess_year2")));
						arrCol.add(correctNull(rs.getString("finassess_year3")));
						arrCol.add(correctNull(rs.getString("finassess_year4")));
						arrCol.add(correctNull(rs.getString("finassess_year5")));
						arrRow.add(arrCol);
					}
					hshRecord.put("arrFinAssesment",arrRow);
				}
				//This Condition is for Cash Budget Method 
				else
				{
					strQuery = SQLParser.getSqlQuery("com_mpbfsel^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("com_mbpfcshdeficit",correctNull(rs.getString("com_mbpfcshdeficit")));	
						hshRecord.put("com_mbpfcshdeficitof",correctNull(rs.getString("com_mbpfcshdeficitof")));	
						hshRecord.put("com_mbpfstockmonth",correctNull(rs.getString("com_mbpfstockmonth")).equals("")?"0":correctNull(rs.getString("com_mbpfstockmonth")));
						
						hshRecord.put("com_mbpfseasonfrom",correctNull(rs.getString("com_mbpfseasonfrom")).equals("")?"0":correctNull(rs.getString("com_mbpfseasonfrom")));
						hshRecord.put("com_mbpfseasonto",correctNull(rs.getString("com_mbpfseasonto")).equals("")?"0":correctNull(rs.getString("com_mbpfseasonto")));
						hshRecord.put("com_mbpfseasonyear",correctNull(rs.getString("com_mbpfseasonyear")));
						hshRecord.put("com_mbpftotaltonnes",correctNull(rs.getString("com_mbpftotaltonnes")));
						hshRecord.put("com_mbpftonnesrupees",correctNull(rs.getString("com_mbpftonnesrupees")));
						hshRecord.put("com_mbpfpertonn",correctNull(rs.getString("com_mbpfpertonn")));
						hshRecord.put("com_mbpfsundry",correctNull(rs.getString("com_mbpfsundry")));
						hshRecord.put("com_mbpfmarginper",correctNull(rs.getString("com_mbpfmarginper")));
						hshRecord.put("com_mbpfmarginvalue",correctNull(rs.getString("com_mbpfmarginvalue")));
						hshRecord.put("com_mbpfdp",correctNull(rs.getString("com_mbpfdp")));
						hshRecord.put("com_mbpfwc",correctNull(rs.getString("com_mbpfwc")));
					}
				}
				
				hshRecord.put("assessment_type",assessment_type);
					
					
				// For --------------
				
				if(strOwnership.equalsIgnoreCase("IN"))//Individual
				{
					strOwnership="001";
					hshRecord.put("strownership","Individual");
				}
				else if(strOwnership.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
				{
					strOwnership="005";
					hshRecord.put("strownership","Private Limited Company");
				}
				else if(strOwnership.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
				{
					strOwnership="006";
					hshRecord.put("strownership","Public Limited Company");
				}
				else if(strOwnership.equalsIgnoreCase("OP"))//PARTNER SHIP
				{
					strOwnership="007";
					hshRecord.put("strownership","Partnership");
				}
				else if(strOwnership.equalsIgnoreCase("OLC"))//Joint Borrowers
				{
					strOwnership="002";
					hshRecord.put("strownership","Joint Borrowers");
				}
				else if(strOwnership.equalsIgnoreCase("OS"))//Sole Proprietor
				{
					strOwnership="009";
					hshRecord.put("strownership","Sole Proprietor");
				}
				else if(strOwnership.equalsIgnoreCase("Jo"))//Joint Venture
				{
					strOwnership="011";
					hshRecord.put("strownership","Joint Venture");
				}
				else if(strOwnership.equalsIgnoreCase("sub"))//Wholly owned subsidiary
				{
					strOwnership="011";
					hshRecord.put("strownership","Wholly owned subsidiary");
				}
				else if(strOwnership.equalsIgnoreCase("TR"))//Trusts
				{
					strOwnership="004";
					hshRecord.put("strownership","Trusts");
				}
				else if(strOwnership.equalsIgnoreCase("AC"))//Association
				{
					strOwnership="003";
					hshRecord.put("strownership","Association");
				}
				else if(strOwnership.equalsIgnoreCase("nbfc"))//NBFC
				{
					strOwnership="999";
					hshRecord.put("strownership","NBFC");
				}
				else if(strOwnership.equalsIgnoreCase("HUF"))//HUF
				{
					strOwnership="008";
					hshRecord.put("strownership","H.U.F");
				}
				else if(strOwnership.equalsIgnoreCase("OO"))//Others
				{
					strOwnership="999";
					hshRecord.put("strownership","Others");
				}
					
				strQuery = SQLParser.getSqlQuery("sel_constitutionexposure^"+strBorrowerType+"^"+strOwnership+"^"+strPublictype);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("maxlimit",""+(Strproposalvaluesin.equalsIgnoreCase("C")?rs.getDouble("exp_maxlimit"):(rs.getDouble("exp_maxlimit")*100)));
				}
				strQuery = SQLParser.getSqlQuery("compropform11^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("companybackground",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				
				strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				StringBuffer sbfsignatories=null;
				StringBuffer sbfgridcomments=null;
				if(rs.next())
				{
					sbfsignatories = new StringBuffer(correctNull(rs.getString("exec_signatures")));
					sbfgridcomments= new StringBuffer(correctNull(rs.getString("exec_gridcomments")));
					hshRecord.put("exec_mcmresolution",correctNull(rs.getString("exec_mcmresolution")));
					hshRecord.put("exec_delegated",correctNull(rs.getString("exec_delegated")));
				}
				if(sbfsignatories!=null)
				{
					for (int i = 0;i < sbfsignatories.length(); i++) {
						if (sbfsignatories.charAt(i) == '\n') {
							sbfsignatories.replace(i, i + 1, "<br>");
						}
						if (sbfsignatories.charAt(i) == ' ') {
							sbfsignatories.replace(i, i + 1, "&nbsp;");
						}
					}
					hshRecord.put("exec_signatures",sbfsignatories.toString());
				}
				if(sbfgridcomments!=null)
				{
					for (int i = 0,j=0;i < sbfgridcomments.length(); i++) 
					{
						if (sbfgridcomments.charAt(i) == '\n') {
							sbfgridcomments.replace(i, i + 1, "<br>");
							j++;
						}
						if (j>1 && sbfgridcomments.charAt(i) == ' ') {
							sbfgridcomments.replace(i, i + 1, "&nbsp;");
						}
					}
					hshRecord.put("exec_gridcomments",sbfgridcomments.toString());
				}
				
				if(rs!=null)
	 			{
	 				rs.close();
	 			}
				hshRecord.put("notapplicable","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"4\">N.A</td>");
				

				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("selfinholdingvalues^"+appno+"^0");
				int inttableflag=0;
				rs=DBUtils.executeQuery(strQuery);
				
				//arrRow.add("<div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"5\" bordercolorlight=\"#FFFFFB\" bordercolordark=\"#DEDACF\" align=\"center\"><tr class=\"tblhead\"><td align=\"center\" width=\"35%\"><b>Particulars&nbsp;</b></td><td colspan=\"2\" align=\"center\"><b>Previous Year&nbsp;</b></td><td align=\"center\"><b>Current Year&nbsp;</b></td><td colspan=\"2\" align=\"center\"><b>Next Ye//ar&nbsp;</b></td><td colspan=\"2\" align=\"center\">&nbsp;</td></tr>");
				arrRow.add("<div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"5\" bordercolorlight=\"#FFFFFB\" bordercolordark=\"#DEDACF\" align=\"center\">");
				
				while(rs.next())
				{
					/*arrCol=new ArrayList();
					arrCol.add("");//0
					arrCol.add(correctNull(rs.getString("finholding_rowdesc")));//1
					arrCol.add("");//2
					arrCol.add(correctNull(rs.getString("finholding_year1")));//3
					arrCol.add(correctNull(rs.getString("finholding_year2")));//4
					arrCol.add(correctNull(rs.getString("finholding_year3")));//5
					arrCol.add(correctNull(rs.getString("finholding_year4")));//6
					arrCol.add(correctNull(rs.getString("finholding_year5")));//7
					arrCol.add(correctNull(rs.getString("finholding_actual")));//8
					arrRow.add(arrCol);*/
					if(rs.getRow() == 1)
						arrRow.add("<tr><td align=\"center\">"+correctNull(rs.getString("finholding_rowdesc"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year1"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year2"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year3"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year4"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year5"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_actual"))+"&nbsp;</td></tr>");
					else if(rs.getRow() == 2)
						arrRow.add("<tr><td align=\"center\">"+correctNull(rs.getString("finholding_rowdesc"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year1"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year2"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year3"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year4"))+"&nbsp;</td><td width=\"13%\" align=\"center\">"+correctNull(rs.getString("finholding_year5"))+"&nbsp;</td><td width=\"13%\" align=\"center\">Accepted&nbsp;</td></tr>");
					else
						arrRow.add("<tr><td align=\"left\">"+correctNull(rs.getString("finholding_rowdesc"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_year1"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_year2"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_year3"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_year4"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_year5"))+"&nbsp;</td><td width=\"13%\" align=\"right\">"+correctNull(rs.getString("finholding_actual"))+"&nbsp;</td></tr>");
					
					inttableflag=1;
				}
				
				arrRow.add("</table></div>");

				if(inttableflag==0)
				{
					arrRow=null;
				}
				hshRecord.put("arrHoldingvalues",arrRow);
				
				strQuery = SQLParser.getSqlQuery("sel_companybackground^"+appno);

				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("comback_comment", correctNull(Helper.CLOBToString(rs.getClob("comback_comment"))));
					
				}
				 arrRow = new ArrayList();
				 ArrayList arrDesc = new ArrayList();
				if (rs != null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selcomfincommentlist^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					strQuery=SQLParser.getSqlQuery("selexecfinancials^"+appno+"^0"+"^"+rs.getInt("indcomment_rowid"));
					rs1=DBUtils.executeQuery(strQuery);
					ArrayList arr_Row = new ArrayList();
					ArrayList arr_Desc = new ArrayList();
					while(rs1.next())
					{
						arrCol=new ArrayList();
						arrCol.add("");//0
						arrCol.add(correctNull(rs1.getString("fin_rowdesc")));//1
						arrCol.add(correctNull(rs1.getString("fin_rowtype")));//2
						arrCol.add(correctNull(rs1.getString("fin_year1")));//3
						arrCol.add(correctNull(rs1.getString("fin_year2")));//4
						arrCol.add(correctNull(rs1.getString("fin_year3")));//5
						arrCol.add(correctNull(rs1.getString("fin_year4")));//6
						arrCol.add(correctNull(rs1.getString("fin_year5")));//7
						arr_Row.add(arrCol);
					}
					if(arr_Row.size()==0)
					{
						arr_Desc.add("N");
						arr_Row.add("");
					}
					else
					{
						arr_Desc.add("Y");
					}
					arr_Desc.add(correctNull(rs.getString("indcomment_desc")));
					if (rs1 != null)
						rs1.close();	
					strQuery=SQLParser.getSqlQuery("sel_finindicatorcomment^"+appno+"^0"+"^"+rs.getInt("indcomment_rowid"));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arr_Desc.add(correctNull(Helper.CLOBToString(rs1.getClob("com_finindicator_comments"))));
						
					}
					else
					{
						arr_Desc.add("");
					}
					if (rs1 != null)
						rs1.close();	
					arrRow.add(arr_Row);
					arrDesc.add(arr_Desc);
										
				}
				
				
				hshRecord.put("arrFinIndicatorRow",arrRow);
				hshRecord.put("arrFinIndicatorDesc",arrDesc);
				if (rs != null)
					rs.close();	
				
				arrRow = new ArrayList();
				
				arrRow  = getRecommendations(hshRecord);
				hshRecord.put("arrRecommen",arrRow);
				
				arrRow = new ArrayList();
				
				arrRow  = getExposure(hshRecord);
				hshRecord.put("arrExposure",arrRow);
				
				
				strQuery=SQLParser.getSqlQuery("sel_accountoprationalbyappno^"+appno);
				if (rs != null)
					rs.close();	
				inttableflag=0;
				arrRow = new ArrayList();
				arrRow.add("<div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\"><tr class=\"tblhead\"><td width=\"5%\" align=\"center\"><b>Sno</b></td><td width=\"40%\" align=\"center\"><b>Facility</b></td><td width=\"18%\" align=\"center\"><b>Limit</b></td><td width=\"18%\" align=\"center\"><b>Turnover Debit</b></td><td width=\"19%\" align=\"center\"><b>Turnover Credit</b></td></tr>");
				rs=DBUtils.executeQuery(strQuery);
				int c1=1;
				while(rs.next())
				{				
					arrRow.add("<tr><td width=\"5%\">"+c1+".</td><td width=\"40%\">"+correctNull(rs.getString("accoprationalfacility"))+"</td><td width=\"18%\" align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationallimit"))))+"</td><td width=\"18%\" align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalturnoverdebit"))))+"</td><td width=\"19%\"  align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("accoprationalturnovercredit"))))+"</td></tr>");
					inttableflag=1;
					c1++;
				}	
				arrRow.add("</table></div>");
				if(inttableflag==0)
				{
					arrRow=null;
				}	
				hshRecord.put("arrBusinessTurnOver",arrRow);
				
				arrRow=new ArrayList();
				if(strSanctauth.equals("7"))
				{
					arrRow.add("<tr><td align=\"center\"><b><U>MEMORANDUM TO MANAGEMENT COMMITTEE</U></b></td></tr><tr><td align=\"center\"><b><U>FOR APPROVAL</U></b></td></tr>");
					
				} 
				else
				{
		    	  arrRow.add("<tr><td align=\"center\"><b><U>MEMORANDUM TO THE COMPETENT AUTHORITY FOR APPROVAL</U></b></td></tr><tr><td align=\"center\"><b><U>PROPOSAL FOR: SANCTION/RENEWAL/MODIFICATIONS</U></b></td></tr>");
		    	
		       } 
				hshRecord.put("memorandum",arrRow);

		}catch (Exception ce) {
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
				if (rs5 != null) {
					rs5.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshRecord;

	}

	public HashMap getData4(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		boolean recordflag=false;
		try {
			appno = correctNull((String) hshValues.get("appno"));

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			/*strQuery = SQLParser.getSqlQuery("selexecpage1status^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_name", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("exec_no", appno);
				hshRecord.put("exec_status", correctNull(rs.getString("app_status")));
			}*/

		
			strQuery = SQLParser.getSqlQuery("selexec_finratio^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {

				hshRecord.put("exec_summ_finTL1", correctNull(rs.getString("exec_summ_finTL1")));
				hshRecord.put("exec_summ_finTOL1", correctNull(rs.getString("exec_summ_finTOL1")));
				hshRecord.put("exec_summ_fincurrentratio1", correctNull(rs.getString("exec_summ_fincurrentratio1")));
				hshRecord.put("exec_summ_findscr1", correctNull(rs.getString("exec_summ_findscr1")));
				hshRecord.put("exec_summ_fincovratio1", correctNull(rs.getString("exec_summ_fincovratio1")));
				
				hshRecord.put("exec_summ_finTL2", correctNull(rs.getString("exec_summ_finTL2")));
				hshRecord.put("exec_summ_finTOL2", correctNull(rs.getString("exec_summ_finTOL2")));
				hshRecord.put("exec_summ_fincurrentratio2", correctNull(rs.getString("exec_summ_fincurrentratio2")));
				hshRecord.put("exec_summ_findscr2", correctNull(rs.getString("exec_summ_findscr2")));
				hshRecord.put("exec_summ_fincovratio2", correctNull(rs.getString("exec_summ_fincovratio2")));

				hshRecord.put("exec_summ_finTL3", correctNull(rs.getString("exec_summ_finTL3")));
				hshRecord.put("exec_summ_finTOL3", correctNull(rs.getString("exec_summ_finTOL3")));
				hshRecord.put("exec_summ_fincurrentratio3", correctNull(rs.getString("exec_summ_fincurrentratio3")));
				hshRecord.put("exec_summ_findscr3", correctNull(rs.getString("exec_summ_findscr3")));
				hshRecord.put("exec_summ_fincovratio3", correctNull(rs.getString("exec_summ_fincovratio3")));
				
				hshRecord.put("exec_summ_finTL4", correctNull(rs.getString("exec_summ_finTL4")));
				hshRecord.put("exec_summ_finTOL4", correctNull(rs.getString("exec_summ_finTOL4")));
				hshRecord.put("exec_summ_fincurrentratio4", correctNull(rs.getString("exec_summ_fincurrentratio4")));
				hshRecord.put("exec_summ_findscr4", correctNull(rs.getString("exec_summ_findscr4")));
				hshRecord.put("exec_summ_fincovratio4", correctNull(rs.getString("exec_summ_fincovratio4")));
				recordflag=true;
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");

		}

		catch (Exception ce) {
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

	public void updateData4(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));
		ResultSet rs=null;
		

		try {
			
			if (strAction.trim().equals("update")) {

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delexec_finratio");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");

				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "insexec_finratio");
				arrValues.add(appno);

				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTL1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTOL1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincurrentratio1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_findscr1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincovratio1")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTL2")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTOL2")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincurrentratio2")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_findscr2")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincovratio2")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTL3")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTOL3")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincurrentratio3")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_findscr3")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincovratio3")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTL4")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_finTOL4")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincurrentratio4")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_findscr4")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exec_summ_fincovratio4")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			} 
			else if (strAction.trim().equals("delete")) 
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "delexec_finratio");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			}
			
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Standard NO of A/Cs =").append(correctNull((String )hshValues.get("exec_summ_finTL1"))).append("~Standard Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_finTL2")))
			.append("~Standard Non Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_finTL3"))).append("~Standard Total =").append(correctNull((String )hshValues.get("exec_summ_finTL4")))
			.append("~Sub-standard NO of A/Cs =").append(correctNull((String )hshValues.get("exec_summ_finTOL1"))).append("~Sub-standard Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_finTOL2")))
			.append("~Sub-standard Non Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_finTOL3"))).append("~Sub-standard Total =").append(correctNull((String )hshValues.get("exec_summ_finTOL4")))
			.append("~Doubtful NO of A/Cs =").append(correctNull((String )hshValues.get("exec_summ_fincurrentratio1"))).append("~Doubtful Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_fincurrentratio2")))
			.append("~Doubtful Non Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_fincurrentratio3"))).append("~Doubtful Total =").append(correctNull((String )hshValues.get("exec_summ_fincurrentratio4")))
			.append("~Loss NO of A/Cs =").append(correctNull((String )hshValues.get("exec_summ_findscr1"))).append("~Loss Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_findscr2")))
			.append("~Loss Non Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_findscr3"))).append("~Loss Total =").append(correctNull((String )hshValues.get("exec_summ_findscr4")))
			.append("~Total NO of A/Cs =").append(correctNull((String )hshValues.get("exec_summ_fincovratio1"))).append("~Total Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_fincovratio2")))
			.append("~Total Non Fund based Limits =").append(correctNull((String )hshValues.get("exec_summ_fincovratio3"))).append("~Total =").append(correctNull((String )hshValues.get("exec_summ_fincovratio4")));
			
			AuditTrial.auditLog(hshValues,"163",appno,sbAuditTrial.toString());
		}
		catch (Exception ce) 
		{
			throw new EJBException("inside update" + ce.toString());
		} 
		finally 
		{
			try 
			{

			} 
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

	}

	public HashMap getData8(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		ResultSet rs7 = null;	
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		HashMap hshValues=null;
		String strQuery="",strValue="";
		ArrayList arr=new ArrayList();
		ArrayList arrVal=new ArrayList();
		String sel_divID="";
		int str=0;
		boolean recordflag=false;
	try
	{			
		strValue=correctNull((String)hshRequestValues.get("appno"));
		String page = correctNull((String)hshRequestValues.get("flowtype"));
		if(page.equals(""))
		{
			page="FI";
		}
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase("") || sel_divID.equalsIgnoreCase("null"))
		{
			sel_divID="0";
		}
		
		rs1=null;
		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecVal1=new ArrayList();
		ArrayList vecVal2=new ArrayList();
		ArrayList vecVal3=new ArrayList();
		ArrayList vecVal4=new ArrayList();
		ArrayList vecVal5=new ArrayList();
		ArrayList vecVal41=new ArrayList();
		ArrayList vecVal51=new ArrayList();
		ArrayList vecVal6=new ArrayList();
		ArrayList vecVal7=new ArrayList();
	
		ArrayList vecrec=new ArrayList();
	
		ArrayList vecid = new ArrayList();
		ArrayList vecdesc = new ArrayList();
		ArrayList vectype = new ArrayList();
		
		ArrayList veccomment = null;
		ArrayList vecserialno = null;

		

		//-------------- to find the time of review-----------------
	
		strQuery = SQLParser.getSqlQuery("executive_finselect1^"+strValue+"^"+sel_divID);
		if(rs!=null)
			rs.close();
		
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{  
			str=rs.getInt("cnt");
		}
		

		//--------------- to find the cma format of the particular applications-------
		if(	rs!=null)
		{
			rs.close();
			
		}
		String cma="";
		//strQuery = SQLParser.getSqlQuery("notefinselect8^"+strValue);
		strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
		
		if(rs!=null)
			rs.close();

		rs = DBUtils.executeQuery(strQuery);
			 
		if(rs.next())
		{  
			cma=correctNull(rs.getString("demo_finstandard"));
			//cma=rs.getString("cma_no");
		}
		/*if (cma.trim().equals(""))
		{
			cma="4";
		}*/
			
		String strDate=""; 
		String strYear=""; 
		String strYear1="";
		/*String moncurryear="";
		int monthcurryear=0;
		
			strQuery = SQLParser.getSqlQuery("selmon_curyear");
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				moncurryear=rs12.getString("mon_curryear");
			}
			monthcurryear=Integer.parseInt(moncurryear);
		
			if (monthcurryear>3)
			{			
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					String val=strDate.substring(6,10);					
					int valcon=Integer.parseInt(val)+1;
					val=Integer.toString(valcon);
					//strDate=val1.concat(val);					
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}
					
			else
			{
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}*/
		
			/**
			 * Get the Base Year
			 * by venu
			 */
			if(rs!=null)
			rs.close();
			
			String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strValue);
			rs = DBUtils.executeQuery(baseyear_query);
			if(rs.next())
			{	
				strDate=Helper.correctNull((String)rs.getString("base_year"));
				strYear=Helper.correctNull((String)rs.getString("year"));
				strYear1=Helper.correctNull((String)rs.getString("year"));
			}
			if(rs!=null){
				rs.close();
			}
			/**
			 * end
			 */
			
		strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strValue+"^"+sel_divID+"^"+strDate);
		if(rs5!=null)
			rs5.close();
		rs5=DBUtils.executeQuery(strQuery);
		
		String strDesc="";
		String strCurDate="";
		if(rs5.next())
		{
			if(rs5.getDouble("sumaudit")>0)
			{
				strDesc="a";
			}
			else if(rs5.getDouble("sumunaudit")>0)
			{
				strDesc="u";
			}
			else if(rs5.getDouble("sumestimated")>0)
			{
				strDesc="e";
			}
			else if(rs5.getDouble("sumprojection")>0)
			{
				strDesc="p";
			}
			strCurDate=rs5.getString("fin_year");

		}
			strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strValue+"^"+sel_divID);
			if(rs10!=null)
				rs10.close();
			rs10=DBUtils.executeQuery(strQuery);
			
			
		while(rs10.next())
		{
			arr=new ArrayList();
			arr.add(rs10.getString(1));
			arrVal.add(arr);
		}			

		
		int checkYear=0;
		int count=0;
		String strPrevDesc="";
		String strPrevDate="";
		String strPrevDesc1="";
		String strPrevDate1="";
		checkYear=Integer.parseInt(Helper.correctInt(strYear));
      	for(int x=1;x<=arrVal.size();x++)
    	{
			count=count+1;			
			if(count>2)				
			break;
			
			checkYear=checkYear-1;
			
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+checkYear);
			if(rs11!=null)
				rs11.close();
			rs11=DBUtils.executeQuery(strQuery);
			if(rs11.next())
			{
				if(rs11.getDouble("sumaudit")>0)
				{
					strPrevDesc="a";
				}
				else if(rs11.getDouble("sumunaudit")>0)
				{
					strPrevDesc="u";
				}
				else if(rs11.getDouble("sumestimated")>0)
				{
					strPrevDesc="e";
				}
				else if(rs11.getDouble("sumprojection")>0)
				{
					strPrevDesc="p";
				}
				strPrevDate=rs11.getString("fin_year");

			}
			else
			{
				strPrevDate="";
				strPrevDesc="";
			}
			if(!strPrevDesc.trim().equals("") && strPrevDate1.trim().equals(""))
			{
				strPrevDate1=strPrevDate;
				strPrevDesc1=strPrevDesc;				
			}
				//break;
	}

			
			int chkYear=0;			
			String strNextDesc="";
			String strNextDate="";	
			String strNextDesc2="";
			String strNextDate2="";
			chkYear=Integer.parseInt(Helper.correctInt(strYear1));
			
	for(int y=1;y<=2;y++)
	{
			chkYear=chkYear+1;
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+chkYear);
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				if(rs12.getDouble("sumaudit")>0)
				{
					strNextDesc="a";
				}
				else if(rs12.getDouble("sumunaudit")>0)
				{
					strNextDesc="u";
				}
				else if(rs12.getDouble("sumestimated")>0)
				{
					strNextDesc="e";
				}
				else if(rs12.getDouble("sumprojection")>0)
				{
					strNextDesc="p";
				}
				strNextDate=rs12.getString("fin_year");

			}
			else
			{
				strNextDate="";
				strNextDesc="";
			}
			if(!strNextDesc.trim().equals("") && strNextDate2.trim().equals(""))
			{
				strNextDate2=strNextDate;
				strNextDesc2=strNextDesc;				
			}
			
			
	}

				strQuery = SQLParser.getSqlQuery("noteassessselect1^"+cma+"^"+page);
				
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				String strRowtype="";
				String strRowid="";
				int strRowformula=0;
				int strRowformula2=0;
				vecVal  = new ArrayList();
				vecVal1 = new ArrayList();
				vecVal2 = new ArrayList();
				vecVal3 = new ArrayList();
				vecVal4 = new ArrayList();
				vecVal5 = new ArrayList();
				vecVal41 = new ArrayList();
				vecVal51 = new ArrayList();
				vecVal6 = new ArrayList();
				vecVal7 = new ArrayList();
				vecid   = new ArrayList();
				vecdesc = new ArrayList();
				vectype = new ArrayList();
				veccomment = new ArrayList();
				vecserialno = new ArrayList();
				while (rs2.next())
				{
					strRowtype=correctNull(rs2.getString("fin_rowtype"));
					strRowid=correctNull(rs2.getString("fin_rowid"));
					strRowformula=rs2.getInt("fin_formula");
					strRowformula2=rs2.getInt("fin_formula2");
					vectype.add(strRowtype);
					vecserialno.add(""+rs2.getInt("fin_sno"));
					String strX="";
					
					
					if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C")) && strRowformula>0 && !strDesc.trim().equals(""))
					{						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strX=correctNull((String)hshRes.get("strTotalValue"));
						vecVal.add(strX);
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
						strRowid=correctNull(rs2.getString("fin_rowid")); 
						
						
						
					}// if IC

					else
					{
						vecVal.add("0.00");
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
					}
						
						String strY="";
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strCurDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes1 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strY = correctNull((String)hshRes1.get("strTotalValue"));						
						vecVal1.add(strY);
					}
					else
					{
							vecVal1.add("0.00");
					}
					// for prev year
					
					String strZ="";
					
					if ( (strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ = correctNull((String)hshRes2.get("strTotalValue"));
						vecVal2.add(strZ);
					}// if IC

					else
					{
						vecVal2.add("0.00");						
					}
							
						String strA="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA = correctNull((String)hshRes3.get("strTotalValue"));
						vecVal3.add(strA);
					}
					else
					{
							vecVal3.add("0.00");
					}
						// for prev2 year
						
						String strZ1="";						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C"))&& strRowformula>0 && !strPrevDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate1);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc1);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ1= correctNull((String)hshRes2.get("strTotalValue"));
						vecVal6.add(strZ1);
					}// if IC

					else
					{
						vecVal6.add("0.00");
						
					}
						
						String strA1="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc1.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate1);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc1);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3a = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA1 = correctNull((String)hshRes3a.get("strTotalValue"));
						vecVal7.add(strA1);
					}
					else
					{
							vecVal7.add("0.00");
					}

						// for next year
										
						String strB1="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB1 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal4.add(strB1);
					}// if IC

					else
					{
						vecVal4.add("0.00");
						
					}
						String strT1 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT1=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal5.add(strT1);
					}
					else
					{
							vecVal5.add("0.00");
					}
					
					// for next year
						
						String strB2="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate2);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc2);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB2 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal41.add(strB2);
					}// if IC

					else
					{
						vecVal41.add("0.00");
						
					}
						String strT2 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate2);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc2);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT2=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal51.add(strT2);
					}
					else
					{
							vecVal51.add("0.00");
					}
					 
					 if(rs != null)
							rs.close();
						strQuery = SQLParser.getSqlQuery("sel_comfincommentlist^"+cma+"^"+strValue+"^"+strRowid);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							veccomment.add("Y");
						}
						else
						{
							veccomment.add("N");
						}
						if(rs != null)
							rs.close();
				}
				//while rs2
				

					hshValues.put("year",vecVal);	
					hshValues.put("yearhold",vecVal1);
					hshValues.put("prevyear",vecVal2);	
					hshValues.put("prevyearhold",vecVal3);	
					hshValues.put("nextyear2",vecVal4);	
					hshValues.put("nextyearhold2",vecVal5);
					hshValues.put("nextyear",vecVal41);	
					hshValues.put("nextyearhold",vecVal51);
					hshValues.put("prevyear1",vecVal5);	
					hshValues.put("prevyearhold1",vecVal6);	
					hshValues.put("vecid",vecid);
					hshValues.put("vecdesc",vecdesc);
					hshValues.put("vectype",vectype);
					hshValues.put("sel_divID",sel_divID);
					hshValues.put("forcomment",veccomment);
					hshValues.put("Serialno",vecserialno);
					
					
					//if(!strCurDate.trim().equals(""))
						
					{
						vecrec.add(strCurDate);
					}

					/*else 
					{
						strDate=strDate.substring(6,10);
						vecrec.add(strDate);
					}*/
						vecrec.add(strDesc);
						vecrec.add(strPrevDate);
						vecrec.add(strPrevDesc);	
						vecrec.add(strNextDate2);
						vecrec.add(strNextDesc2);	
						vecrec.add(strPrevDate1);
						vecrec.add(strPrevDesc1);
						vecrec.add(strNextDate);
						vecrec.add(strNextDesc);

					hshValues.put("yearvalue",vecrec);
					hshValues.put("page",page); //old one
					
					strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+strValue+"^"+page+"^"+sel_divID);
					if(rs5!=null)
						rs5.close();
					rs5=DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						hshValues.put("exec_notes",correctNull(Helper.CLOBToString(rs5.getClob("notes"))));
						
						
					}
					
					

	}
		catch(Exception ce)
		{
				throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs2 != null)
					rs2.close();
				if(rs5 != null)
					rs5.close();
				if(rs7 != null)
					rs7.close();
				if(rs10 != null)
					rs10.close();
				if(rs11 != null)
					rs11.close();
				if(rs12 != null)
					rs12.close();
				if(rs13 != null)
					rs13.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
			
			return hshValues; 
	}

	public HashMap getDataList(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ResultSet rs2 = null;

		HashMap hshValues = null;
		String strQuery = "", strValue = "";

		try {

			strValue = correctNull((String) hshRequestValues.get("appno"));

			String yearvalue[] = new String[4];
			String comboselect[] = new String[4];
			hshValues = new HashMap();
			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			ArrayList vecid = new ArrayList();
			// to find the cma format of the particular applications

			String cma = "";
			strQuery = SQLParser.getSqlQuery("comfintrendsel1^" + strValue);
			
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				//cma = rs.getString("cma_no");
				
				cma=correctNull(rs.getString("demo_finstandard"));
			}

			// to find the tab

			String page = correctNull((String) hshRequestValues.get("pageval"));

			vecVal = new ArrayList();

			rs = DBUtils.executeLAPSQuery("assessselect3^" + strValue + "^"
					+ cma);
			String temp = "";
			String tempsno = "";

			while (rs.next()) {
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("rowid")));

				temp = Helper.correctNull(rs.getString("desc1"));
				if (temp.equals("")) {
					vecRec.add(correctNull(rs.getString("desc2")));
				} else {
					vecRec.add(correctNull(rs.getString("desc1")));
				}

				vecRec.add(correctNull(rs.getString("fin_rowtype")));
				tempsno = correctNull(rs.getString("fin_sno"));
				if (tempsno == "") {
					tempsno = " ";
				}
				vecRec.add(tempsno);

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

			for (int i = 0; i <= 3; i++) {
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
				if (!yearvalue[i].equals("") && !comboselect[i].equals("S")) {
					k = k + 1;

					strQuery = SQLParser.getSqlQuery("assessselect1^" + cma);
					if (rs2 != null)
						rs2.close();
					rs2 = DBUtils.executeQuery(strQuery);
					String strRowtype = "";
					String strRowid = "";
					int strRowformula = 0;
					while (rs2.next()) {
						strRowtype = correctNull(rs2.getString("fin_rowtype"));
						strRowid = correctNull(rs2.getString("fin_rowid"));
						strRowformula = rs2.getInt("fin_formula");

						if (strRowtype.trim().equals("FO") && strRowformula > 0) {
							HashMap hshformula = new HashMap();
							hshformula.put("appno", strValue);
							hshformula.put("formulaid", Integer
									.toString(strRowformula));
							hshformula.put("curryear", yearvalue[i]);
							hshformula.put("prevyear", " ");
							hshformula.put("currfinancialtype", desc);
							hshformula.put("prevfinancialtype", "");
							HashMap hshRes = (HashMap) EJBInvoker
									.executeStateLess("comformula", hshformula,
											"GetFinValue");
							vecVal.add(correctNull((String) hshRes
									.get("strTotalValue")));

							vecid.add(correctNull(rs2
									.getString("fin_rowid")));
						}// if IC

						else {
							vecVal.add("0.00");
							vecid.add(correctNull(rs2
									.getString("fin_rowid")));
						}

						hshValues.put("year" + k, vecVal);
						hshValues.put("vecid" + k, vecid);

					}// while rs2

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

			// to get page vales

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}

		return hshValues;

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
		int intUpdatesize = 0;
		String page = "";
		String hidEditMode = correctNull((String) hshValues.get("hidEditMode"));
		String[] strforcomment = (String[]) hshValues.get("forcomment1");
		String[] strhiddesc = (String[]) hshValues.get("hiddesc");
		String[] strhidrowid = (String[]) hshValues.get("hidrowid");
		String[] strhidsno = (String[]) hshValues.get("hidserialno");
		String strcma=null; 
		String str_Rowid="";
		

		try {
			hshQueryValues = new HashMap();
			strValue = correctNull((String) hshValues.get("appno"));
			page = correctNull((String) hshValues.get("flowtype"));
			sel_divID = correctNull((String) hshValues.get("sel_divID"));
			notes = correctNull((String) hshValues.get("exec_notes"));
			
			/* ***  */
			
			if(	rs!=null)
			{
				rs.close();
				
			}
			
			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
			
			

			rs = DBUtils.executeQuery(strQuery);
				 
			if(rs.next())
			{  
				strcma=correctNull(rs.getString("demo_finstandard"));
				
			}
			if(rs!=null)
				rs.close();
			
			/* *************** */
			if (sel_divID.equalsIgnoreCase("")
					|| sel_divID.equalsIgnoreCase("null")) {
				sel_divID = "0";
			}

			if (hidEditMode.equalsIgnoreCase("U")) {
				rs = null;
				/*strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"
						+ strValue + "^" + page + "^" + sel_divID);
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
					// arrValues.add(notes.toCharArray());
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
						"updateData");*/
				
				
				/* ******** */
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = 0;
				intUpdatesize++;
				arrValues.add(strValue);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_finindcommentlist");
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				for(int i=0;i< strforcomment.length;i++)
				{
					if(strforcomment[i].equals("Y"))
					{
						str_Rowid = str_Rowid+strhidrowid[i]+",";
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						arrValues.add(strValue);
						arrValues.add(strhidrowid[i]);
						arrValues.add(strcma);
						arrValues.add(strhiddesc[i]);
						arrValues.add(strhidsno[i]);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_finindcommentlist");
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
					}
					
					
				}
				if(str_Rowid.length() > 0)
				{
					str_Rowid=str_Rowid.substring(0,str_Rowid.length()-1);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				arrValues.add(strValue);
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delfinindcomnotin^"+ "and com_finindicator_rowid not in ("+str_Rowid.trim()+")");
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				arrValues.add(strValue);
				arrValues.add("FICOM");
				arrValues.add("0");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delindrowitemnotin^"+ "and fin_forrowid not in ("+str_Rowid.trim()+")");
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strValue);
					arrValues.add("0");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "del_finindicatorcommentAll");
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(strValue);
					arrValues.add("FICOM");
					arrValues.add("0");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "delindrowitemAll");
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
				}
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				/* ************** */
			} else if (hidEditMode.equalsIgnoreCase("D")) {
				/*hshQuery = new HashMap();
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
						"updateData");*/
			}

			hshRecord = new HashMap();
			//hshRecord.putAll(getFinComments(hshValues));
			hshRecord=(HashMap) EJBInvoker.executeStateLess("executive",hshValues, "getData8");

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

	/*public void updateCollateralSecurity(HashMap hshValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ResultSet rs = null;
		ArrayList arrValues = null;
		String strAppno = "";
		String strQuery = "";
		String strsno = "";
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		String strAction = Helper.correctNull((String) hshValues
				.get("hidAction"));

		strsno = Helper.correctNull((String) hshValues.get("hid_strsno"));
		String strnature = Helper.correctNull((String) hshValues
				.get("txt_nature"));
		String strvalue = Helper.correctNull((String) hshValues
				.get("txt_value"));
		String strvaluationdate = Helper.correctNull((String) hshValues
				.get("txt_valueddate"));
		String strvaluer = Helper.correctNull((String) hshValues
				.get("txt_valuer"));
		String strinsuranceamt = Helper.correctNull((String) hshValues
				.get("txt_insuranceamt"));
		String strinsurancedate = Helper.correctNull((String) hshValues
				.get("txt_insurancedate"));
		String strremarks = Helper.correctNull((String) hshValues
				.get("txt_remarks"));
		try {
			if (strAction.equalsIgnoreCase("insert")) {
				if (rs != null) {
					rs.close();
				}
				strQuery = "sel_maxexeccollateraldetail^" + strAppno;
				rs = DBUtils.executeLAPSQuery(strQuery);
				if (rs.next()) {
					strsno = Helper.correctNull((String) rs
							.getString("COLLATERAL_NO"));
				}
				if (rs != null) {
					rs.close();
				}
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "exec_collateraldetailins");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strnature);
				arrValues.add(strvalue);
				arrValues.add(strvaluationdate);
				arrValues.add(strvaluer);
				arrValues.add(strinsuranceamt);
				arrValues.add(strinsurancedate);
				arrValues.add(strremarks);

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "exec_collateraldetailupd");

				arrValues.add(strnature);
				arrValues.add(strvalue);
				arrValues.add(strvaluationdate);
				arrValues.add(strvaluer);
				arrValues.add(strinsuranceamt);
				arrValues.add(strinsurancedate);
				arrValues.add(strremarks);
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
				hshQuery.put("strQueryId", "exec_collateraldetaildel");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}
			
			StringBuffer sbAuditTrial = new  StringBuffer();
			sbAuditTrial.append("Value = ").append(strvalue)
			.append("~Date of valuation = ").append(strvaluationdate)
			.append("~Name of valuer = ").append(strvaluer)
			.append("~Insurance amount = ").append(strinsuranceamt)
			.append("~Date of expiry = ").append(strinsurancedate);
			
			AuditTrial.auditLog(hshValues,"162",strAppno,sbAuditTrial.toString());
			
		} catch (Exception e) {
			throw new EJBException("Error in updateCollateralSecurity"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception exp) {
				throw new EJBException(
						"Error in closing the connection in updateCollateralSecurity "
								+ exp.toString());
			}
		}

	}*/

	/*public HashMap getCollateralSecurity(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno = "";

		strAppno = Helper.correctNull((String) hshValues.get("appno"));
		if (strAppno.equalsIgnoreCase("")) {
			strAppno = Helper.correctNull((String) hshValues.get("hidAppno"));
		}
		try {

			strQuery = SQLParser.getSqlQuery("exec_collateraldetailsel^"
					+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(correctNull((String) rs
						.getString("COLLATERAL_NO")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_description")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_value")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_valueddate")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_valuer")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_insuranceamt")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_ins_expirydate")));
				vecCol.add(correctNull((String) rs
						.getString("collateral_remarks")));
				vecRow.add(vecCol);
			}
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
	}*/
	
	
	public void updateData9(HashMap hshValues)
	{
			HashMap hshQuery=null;
			HashMap hshQueryValues=null;
			ArrayList arrValues=null;
			String strAppno="";
			String strsno="";
			String strFacility="";
			String strFacId="";
			String strFacType="";
			
			strAppno=correctNull((String)hshValues.get("appno"));
			String strAction=correctNull((String)hshValues.get("hidAction"));
			strsno=correctNull((String)hshValues.get("hid_strsno"));
			
			try
			{
				
				strFacility=correctNull((String)hshValues.get("selfacility"));
				/*if(!strFacility.equals("s"))
				{
					StringTokenizer st = new StringTokenizer(strFacility,"^");
					strFacType = st.nextToken();
					strFacId = st.nextToken();
				}*/
				
				
				if(strAction.equalsIgnoreCase("insert"))
				{	
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					//arrValues.add(strsno);
					arrValues.add(strAppno);
					arrValues.add(strFacility);
					arrValues.add(correctNull((String)hshValues.get("selsancterms")));
					
					hshQuery.put("strQueryId","del_exec_sanctionterms_summmary");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_exec_sanctionterms_summmary");
					
					arrValues.add(strAppno);
					arrValues.add(strFacility);
					arrValues.add(correctNull((String)hshValues.get("selsancterms")));
					arrValues.add(correctNull((String)hshValues.get("txt_earlierstipulated")));
					arrValues.add(correctNull((String)hshValues.get("txt_recommdnow")));
					arrValues.add(correctNull((String)hshValues.get("txt_present")));
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					hshQueryValues.put("size","2");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					//arrValues.add(strsno);
					arrValues.add(strAppno);
					arrValues.add(strFacility);
					arrValues.add(correctNull((String)hshValues.get("selsancterms")));
					hshQuery.put("strQueryId","del_exec_sanctionterms_summmary");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}catch(Exception e)
			{
				throw new EJBException("Error in updateData9"+e.getMessage());
			}
		}

	public HashMap getData9(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		String strAppno="";
		String strFacility="";
		String strFacType="";
		String strFacId="";
		String strSanctionterms="";
		
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
			}
			
			strSanctionterms=correctNull((String)hshValues.get("selsancterms"));
			strFacility=correctNull((String)hshValues.get("selfacility"));
			/*if(!strFacility.equals("") && !strFacility.equals("s"))
			{
				StringTokenizer st = new StringTokenizer(strFacility,"^");
				strFacType = st.nextToken();
				strFacId = st.nextToken();
			}*/

			strQuery=SQLParser.getSqlQuery("sel_exec_sanctionterms_summmary^"+strAppno+"^"+strFacility+
					"^"+strSanctionterms);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("earlierstipulation",correctNull((String)rs.getString("exec_stipearlier")));
				hshRecord.put("nowrecommended",correctNull((String)rs.getString("exec_recmdnow")));
				hshRecord.put("present",correctNull((String)rs.getString("exec_present")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			hshRecord.put("facility",strFacility);
			hshRecord.put("sancterms",strSanctionterms);
			
		}
		catch(Exception exp)
		{
			throw new EJBException(exp.getMessage());
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
	
	public void updateData10(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = "";
		appno = correctNull((String) hshValues.get("appno"));

		try {
			if (strAction.trim().equals("edit")) {

				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_summary_val");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execins_summary_val");

				arrValues.add(Helper.correctNull((String) hshValues.get("status_acc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("background_promoters")));
				arrValues.add(Helper.correctNull((String) hshValues.get("book_value")));
				arrValues.add(Helper.correctNull((String) hshValues.get("market_value")));
				arrValues.add(Helper.correctNull((String) hshValues.get("company_rbi")));
				arrValues.add(Helper.correctNull((String) hshValues.get("company_rbidesc")));
				arrValues.add(Helper.correctNull((String) hshValues.get("exposure_norms")));
				arrValues.add(Helper.correctNull((String) hshValues.get("other_matters")));
				arrValues.add(Helper.correctNull((String) hshValues.get("ind_services")));
				arrValues.add(appno);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete")) {
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "execdel_summary_val");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			}
		}

		catch (Exception ce) {
			log.error("Exception while Rollbacking"+ ce.toString());
		}
}
	
	public HashMap getData10(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		
		try {
			appno = correctNull((String) hshValues.get("appno"));

			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("status_acc", correctNull(rs.getString("status_acc")));
				hshRecord.put("background_promoters", correctNull(rs.getString("background_promoters")));
				hshRecord.put("book_value", correctNull(rs.getString("book_value")));
				hshRecord.put("market_value", correctNull(rs.getString("market_value")));
				hshRecord.put("company_rbi", correctNull(rs.getString("company_rbi")));
				hshRecord.put("company_rbidesc",correctNull(Helper.CLOBToString(rs.getClob("company_rbidesc"))));
				hshRecord.put("exposure_norms", correctNull(rs.getString("exposure_norms")));

				hshRecord.put("other_matters", correctNull(Helper.CLOBToString(rs.getClob("other_matters"))));
				hshRecord.put("ind_services", correctNull(rs.getString("ind_services")));
			}
			if (rs != null) {
				rs.close();
			}
			hshRecord.put("hidappno", Helper.correctNull((String) hshValues.get("hidappno")));

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
 * Method to get the sub facilities under each major facility
 * Added by gokulakrishnan.c
 */	
	private ArrayList getSubFacilitiesData(String strAppno, String strFacSno, String strType) throws Exception{
		ArrayList arrSubFac = new ArrayList();
		ArrayList arrSubFacRecords = new ArrayList();
		String strQuery="";
		ResultSet rs =null;
		ResultSet rs1=null;
		String strsubfacsno="";
		try{
			if(strType.trim().equalsIgnoreCase("TL"))
				strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("FD"))
				strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("NFD"))
				strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
			
			else if(strType.trim().equalsIgnoreCase("stl_TL"))
				strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("stl_FD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("stl_NFD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
			
			else if(strType.trim().equalsIgnoreCase("existstl_TL"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("existstl_FD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
			else if(strType.trim().equalsIgnoreCase("existstl_NFD"))
				strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				//int d2b = 0;
				arrSubFacRecords = new ArrayList();
				arrSubFacRecords.add(correctNull(rs.getString("facility_catdesc")));//0
				arrSubFacRecords.add(correctNull(rs.getString("facility_existing")));//1
				arrSubFacRecords.add(correctNull(rs.getString("facility_proposed")));//2
				arrSubFacRecords.add(correctNull(rs.getString("facility_margin")));//3
				arrSubFacRecords.add(correctNull(rs.getString("facility_intremarks")));//4
				arrSubFacRecords.add(correctNull(rs.getString("facility_dp")));//5
				arrSubFacRecords.add(correctNull(rs.getString("facility_outstanding")));//6
				arrSubFacRecords.add(correctNull(rs.getString("security_value")));//7
				arrSubFacRecords.add(correctNull(rs.getString("facility_desc")));//8
				arrSubFacRecords.add(correctNull(rs.getString("bplr")));//9
				arrSubFacRecords.add(correctNull(rs.getString("facility_intadjustment")));//10
				arrSubFacRecords.add(correctNull(rs.getString("facility_category")));//11
				arrSubFacRecords.add(correctNull(rs.getString("facility_months")));//12
				arrSubFacRecords.add(correctNull(rs.getString("facility_headid")));//13
				strsubfacsno=correctNull(rs.getString("facility_sno"));
				
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strsubfacsno
						+ "^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) {
					ArrayList arrCol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecurities.add(arrCol);
					j++;
				}
				arrSubFacRecords.add(arrSecurities);//14
				arrSubFacRecords.add(""+j);//15
				/*String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				
				//By venu for the sublimit security
				strQuery = SQLParser.getSqlQuery("secfacilitywise^" + strAppno
						+ "^" + strfacheadid + "^" + strfacsubid);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					String strVal = correctNull(rs1.getString(1));

					strQuery = SQLParser.getSqlQuery("propfacmastersel1^"
							+ strVal);
					if (rs1 != null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						String secdetails = correctNull(rs1.getString(3));
						if (!secdetails.equalsIgnoreCase("")) {
							d2b = d2b + 1;
							arrSubFacRecords.add(correctNull(rs1.getString(3)));
						}
					}

					if (d2b == 0) {
						for (int d3b = 1; d3b <= d2b; d3b++) {
							arrSubFacRecords.add("");
						}
					}

				}
				int valsecol = d2b;
				String valfacstrseccol = Integer.toString(valsecol);
				arrSubFacRecords.add((valfacstrseccol));
//	 Don't add additional field here
				//end of sublimit security*/
						
				arrSubFac.add(arrSubFacRecords);
			}
		}catch(Exception e)
		{
			log.error("Exception in getSubFacilitiesData of ExcutiveBean "+e.getMessage());
		}finally{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ce)
			{
				log.error("Exception in closing connection in getSubFacilitiesData of ExcutiveBean"+ce.getMessage());
			}
		}
		return arrSubFac;
	}
	
//	private HashMap getFinComments(HashMap hshValues) throws Exception
//	{
//		HashMap hshmap=new HashMap();;
//		ResultSet rs=null;
//		String strQuery=""; 
//		String strAppno="";
//		String strDivId="";
//		String strPagetype="";
//		
//		try
//		{
//			strAppno=correctNull((String)hshValues.get("appno"));
//			strDivId=correctNull((String)hshValues.get("sel_divID"));
//			strPagetype=correctNull((String)hshValues.get("pageval"));
//				
//			strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+strAppno+"^"+strPagetype+"^"+strDivId);
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				hshmap.put("exec_notes",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
//			}
//		}catch(Exception ex)
//		{
//			throw new EJBException("Error in getFinComments :: "+ ex);
//		}
//		finally{
//				try{
//					if(rs!=null)
//						rs.close();
//				}catch(Exception ex)
//				{
//					throw new EJBException("Error in closing connection in getFinComments  ::  "+ ex);
//				}
//		}
//		return hshmap;
//	}
	
	
	private HashMap getExposuredetails(String strIndcode,String Strproposalvaluesin,String strIndustryType,String strGroup) throws Exception{
	{
		HashMap hshmap=new HashMap();;
		ResultSet rs=null;
		String strQuery="";
		String strGrpcode="";
		String strBSRmaxexp="";
		String strBSRcode="";
		String strGrpexp="";
		String strnegflag="n";
		double dblBankcreditexposure=0.0;
		double dblgrpexposure=0.0;
		double dblgrpsanctionedlimit=0.0;
		double dblgrpos=0.0;
		double dblgrpremainig=0.0;
		double dblcapital_funds=0.0;
		double dbltotbank_credit=0.0;
		try
		{
			strQuery=SQLParser.getSqlQuery("selindustrynamebyindno^"+strIndcode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strGrpcode=correctNull(rs.getString("ind_grpcode"));
				strBSRmaxexp=Helper.correctDouble(rs.getString("ind_exposure"));
				strBSRcode=correctNull(rs.getString("ind_bsr_code"));
			}
			
			if(rs!=null) rs.close();
			strQuery=SQLParser.getSqlQuery("selbanknetfunds");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblBankcreditexposure=Double.parseDouble(Helper.correctDouble(rs.getString("net_totbankcredit")));
				
				if(!(strIndustryType.equalsIgnoreCase("4")) && (strGroup.equalsIgnoreCase("")))
				{
					dblcapital_funds=rs.getDouble("net_singleborrexp");
					hshmap.put("label","Single Borrower");
				}
				else if(!(strIndustryType.equalsIgnoreCase("4")) && (!(strGroup.equalsIgnoreCase(""))))
				{	
					dblcapital_funds=rs.getDouble("net_groupborrexp");
					hshmap.put("label","Group");
				}
				else if(strIndustryType.equalsIgnoreCase("4") && (strGroup.equalsIgnoreCase("")))
				{
					dblcapital_funds=rs.getDouble("net_singleborrinfra");
					hshmap.put("label","Single Borrower with infrastructure");
				}
				else if(strIndustryType.equalsIgnoreCase("4") && (!(strGroup.equalsIgnoreCase(""))))
				{	
					dblcapital_funds=rs.getDouble("net_groupborrinfra");
					hshmap.put("label","Group of Borrower with infrastructure");
				}
				hshmap.put("capital_funds",""+dblcapital_funds);
				dbltotbank_credit=rs.getDouble("net_bankfunds");
				if(Strproposalvaluesin.equalsIgnoreCase("C"))
				{
					hshmap.put("totbankcredit",""+dbltotbank_credit);
					hshmap.put("capital_amt",""+(dbltotbank_credit*dblcapital_funds/100));
				}
				else
				{
					hshmap.put("totbankcredit",""+(dbltotbank_credit*100));
					hshmap.put("capital_amt",""+(dbltotbank_credit*dblcapital_funds));
				}
				
			}
			if(rs!=null) rs.close();
			if(!strGrpcode.equalsIgnoreCase(""))
			{
				if(rs!=null) rs.close();
				strQuery=SQLParser.getSqlQuery("selindexpbygrpcode^"+strGrpcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGrpexp=Helper.correctDouble(rs.getString("exp_maxexp"));
				}
				strQuery=SQLParser.getSqlQuery("selindexpfromcbs^"+strGrpcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblgrpsanctionedlimit=Double.parseDouble(Helper.correctDouble(rs.getString("IND_SANCLIMIT")));
					dblgrpos=Double.parseDouble(Helper.correctDouble(rs.getString("IND_OSLIMIT")));
				}
			}
			
			dblgrpexposure=dblBankcreditexposure*Double.parseDouble(Helper.correctDouble(strGrpexp))/100;
			dblgrpremainig=dblgrpexposure-dblgrpsanctionedlimit;
			if(dblgrpremainig<0)
			{
				strnegflag="y";
			}
			if(Strproposalvaluesin.equalsIgnoreCase("C"))
			{
				hshmap.put("indgrpexplimit",""+dblgrpexposure);
				hshmap.put("indgrpexpsanclimit",""+dblgrpsanctionedlimit);
				hshmap.put("indgrpexpos",""+dblgrpos);
				hshmap.put("indgrpremaing",""+dblgrpremainig);
			}
			else
			{
				hshmap.put("indgrpexplimit",""+(dblgrpexposure*100));
				hshmap.put("indgrpexpsanclimit",""+(dblgrpsanctionedlimit*100));
				hshmap.put("indgrpexpos",""+(dblgrpos*100));
				hshmap.put("indgrpremaing",""+(dblgrpremainig*100));
			}
			
			
			hshmap.put("strnegflag",strnegflag);
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery("selprevdate");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshmap.put("asondate",rs.getString("date1"));
			}	
			
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getExposureDetails :: "+ ex);
		}
		finally{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing connection in getExposuredetails  ::  "+ ex);
			}
		}
		return hshmap;
	}
	
	}
	
	
	public HashMap getData11(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		
		try 
		{
			appno = correctNull((String) hshValues.get("appno"));

			if (appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			strQuery = SQLParser.getSqlQuery("sel_exec_signatures^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("exec_appno",correctNull(rs.getString("exec_appno")));
				hshRecord.put("exec_signatures",correctNull(rs.getString("exec_signatures")));
				hshRecord.put("exec_mcmresolution",correctNull(rs.getString("exec_mcmresolution")));
				hshRecord.put("exec_gridcomments",correctNull(rs.getString("exec_gridcomments")));
				hshRecord.put("exec_delegated",correctNull(rs.getString("exec_delegated")));
			}

			if (rs != null)
			{
				rs.close();
			}

		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getData11 " + ce.toString());
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

	public void updateData11(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = "";
		appno = correctNull((String) hshValues.get("appno"));

		try
		{
			if (strAction.trim().equals("edit"))
			{

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_exec_signatures");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "ins_exec_signatures");
				
				arrValues.add(appno);
				StringBuilder sbf = new StringBuilder(correctNull((String) hshValues.get("txt_signatures")));
				for (int i = 0; i < sbf.length() && sbf.charAt(i) == ' '; i++) {
						sbf.replace(i, i + 1, "&nbsp;");
						i=i+6;
				}
				arrValues.add(sbf.toString());
				arrValues.add(correctNull((String) hshValues.get("txt_mcmresolution")));
				arrValues.add(correctNull((String) hshValues.get("txt_gridcomments")));
				arrValues.add(correctNull((String) hshValues.get("txt_delegated")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_exec_signatures");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			}
		}

		catch (Exception ce) 
		{
			log.error("Exception in updateData11 :: "+ ce.toString());
		}
	}
	
	
	public void updateFinancial(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ResultSet rs=null;
		String val="";
		String appno="";
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");

			String []desc=null;
			String []first_year=null;	
			String []second_year=null;
			String []third_year=null;
			String []fourth_year=null; 
			int intUpdatesize=0;
			
			int len = 0;
			if (val.equals("update"))
			{
				desc= (String [])hsh.get("desc");
				first_year= (String [])hsh.get("txt_firstyear");
				second_year= (String [])hsh.get("txt_secondyear");
				third_year= (String [])hsh.get("txt_thirdyear");
				fourth_year= (String [])hsh.get("txt_fourthyear");
				
				hshQuery = new HashMap();
				len=first_year.length;
			
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_execfin");
				arr.add(appno);
				arr.add("0");
				arr.add("FI");
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","executive_finnotes_del");
				arr.add(appno);
				arr.add("FI");
				arr.add("0");
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				for(int k=0;k<len;k++)
				{			
						hshQuery = new HashMap();
						arr=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_execfin");
						
						arr.add(appno);
						arr.add("0");
						arr.add("FI");
						arr.add(Integer.toString(k));
						arr.add("");
						arr.add(Integer.toString(k));
						arr.add(correctNull((String)desc[k]));
						arr.add(correctNull((String)first_year[k]));
						arr.add(correctNull((String)second_year[k]));
						arr.add(correctNull((String)third_year[k]));
						arr.add(correctNull((String)fourth_year[k]));
						arr.add("0.00");
						arr.add("0.00");
						
						hshQuery.put("arrValues",arr);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","executive_finnotes_ins");
				arr.add(appno);
				arr.add("FI");
				arr.add("0");
				arr.add(Helper.correctNull((String)hsh.get("comments")));
				
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(val.equals("delete"))
			{
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_execfin");
				arr.add(appno);
				arr.add("0");
				arr.add("FI");
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","executive_finnotes_del");
				arr.add(appno);
				arr.add("FI");
				arr.add("0");
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			//audit trial
			StringBuilder strAudit = new StringBuilder();
				if(!val.equals("delete"))
				{
					
					strAudit.append("~Financial Year = ");
					strAudit.append(first_year[0]);
					strAudit.append("~Financial Type = ");
					strAudit.append(first_year[1]);
					strAudit.append("~"+desc[2]+"=");
					strAudit.append(first_year[2]);
					strAudit.append("~"+desc[3]+"=");
					strAudit.append(first_year[3]);
					strAudit.append("~"+desc[4]+"=");
					strAudit.append(first_year[4]);
					strAudit.append("~"+desc[5]+"=");
					strAudit.append(first_year[5]);
					strAudit.append("~"+desc[6]+"=");
					strAudit.append(first_year[6]);
					strAudit.append("~"+desc[7]+"=");
					strAudit.append(first_year[7]);
					
					strAudit.append("~Financial Year = ");
					strAudit.append(second_year[0]);
					strAudit.append("~Financial Type = ");
					strAudit.append(second_year[1]);
					strAudit.append("~"+desc[2]+"=");
					strAudit.append(second_year[2]);
					strAudit.append("~"+desc[3]+"=");
					strAudit.append(second_year[3]);
					strAudit.append("~"+desc[4]+"=");
					strAudit.append(second_year[4]);
					strAudit.append("~"+desc[5]+"=");
					strAudit.append(second_year[5]);
					strAudit.append("~"+desc[6]+"=");
					strAudit.append(second_year[6]);
					strAudit.append("~"+desc[7]+"=");
					strAudit.append(second_year[7]);
					
					strAudit.append("~Financial Year = ");
					strAudit.append(third_year[0]);
					strAudit.append("~Financial Type = ");
					strAudit.append(third_year[1]);
					strAudit.append("~"+desc[2]+"=");
					strAudit.append(third_year[2]);
					strAudit.append("~"+desc[3]+"=");
					strAudit.append(third_year[3]);
					strAudit.append("~"+desc[4]+"=");
					strAudit.append(third_year[4]);
					strAudit.append("~"+desc[5]+"=");
					strAudit.append(third_year[5]);
					strAudit.append("~"+desc[6]+"=");
					strAudit.append(third_year[6]);
					strAudit.append("~"+desc[7]+"=");
					strAudit.append(third_year[7]);
					
					strAudit.append("~Financial Year = ");
					strAudit.append(fourth_year[0]);
					strAudit.append("~Financial Type = ");
					strAudit.append(fourth_year[1]);
					strAudit.append("~"+desc[2]+"=");
					strAudit.append(fourth_year[2]);
					strAudit.append("~"+desc[3]+"=");
					strAudit.append(fourth_year[3]);
					strAudit.append("~"+desc[4]+"=");
					strAudit.append(fourth_year[4]);
					strAudit.append("~"+desc[5]+"=");
					strAudit.append(fourth_year[5]);
					strAudit.append("~"+desc[6]+"=");
					strAudit.append(fourth_year[6]);
					strAudit.append("~"+desc[7]+"=");
					strAudit.append(fourth_year[7]);
					
				}
				if(Helper.correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("N"))
					hsh.put("hidAction","Insert");
				AuditTrial.auditLog(hsh, "402", appno, strAudit.toString());
			//end
						
		}
		catch (Exception e)
		{
			log.error("Error in updateFinancial"+e);
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
	
	public HashMap getDataFinancial(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno="";
		String strQuery="";
		String recordflag = "N";
		try
		{
			appno=(String)hsh.get("appno");
			strQuery=SQLParser.getSqlQuery("sel_execfin^"+appno+"^0^FI");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				recordflag = "Y";
				arrRec = new ArrayList();						
				arrRec.add(correctNull(rs.getString("fin_year1")));
				arrRec.add(correctNull(rs.getString("fin_year2")));
				arrRec.add(correctNull(rs.getString("fin_year3")));
				arrRec.add(correctNull(rs.getString("fin_year4")));
				arrRec.add(correctNull(rs.getString("fin_year5")));
				arrRec.add(correctNull(rs.getString("fin_year6")));
				arrRec.add(correctNull(rs.getString("fin_rowdesc")));
				arrRec.add(correctNull(rs.getString("fin_rowtype")));
				arrVal.add(arrRec);	
				
			}
			hshValues.put("arrVal",arrVal);
			hshValues.put("recordflag",recordflag);
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+appno+"^"+"FI"+"^"+"0");
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshValues.put("comments",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
			}
			
		}		
		catch (Exception e)
		{
			log.error("error occured in getDataFinancial"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}
	
	
	
	
	
	public HashMap getDataSRERatingDetails(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno = "";
		
		try
		{
			appno = correctNull((String) hshValues.get("appno"));
			/*
			 * insert into ramtolaps105(appno, lastrating_basemodel,lastscore_basemodel, lastgradef_basemodel,
currentrating_basemodel, currentscore_basemodel,currentgradef_basemodel,
remarks,extrating_remarks) values(?,?,?,?,?,?,?,?,?)
			 */
			
			strQuery = SQLParser.getSqlQuery("getramrating105details^" + appno);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				arrRec = new ArrayList();	
				arrRec.add(correctNull(rs.getString("LASTSCORE_BASEMODEL")));
				arrRec.add(correctNull(rs.getString("CURRENTSCORE_BASEMODEL")));
				arrVal.add(arrRec);
				arrRec = new ArrayList();	
				arrRec.add(correctNull(rs.getString("lastrating_basemodel")));
				arrRec.add(correctNull(rs.getString("currentrating_basemodel")));
				arrVal.add(arrRec);
				arrRec = new ArrayList();	
				arrRec.add(correctNull(rs.getString("LASTGRADEF_BASEMODEL")));
				arrRec.add(correctNull(rs.getString("CURRENTGRADEF_BASEMODEL")));
				arrVal.add(arrRec);
				hshRecord.put("mig_remarks",correctNull(rs.getString("remarks")));
				hshRecord.put("extrating",correctNull(rs.getString("extrating_remarks")));
				
			}
			else
			{
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				
				
			}
			
			strQuery = SQLParser.getSqlQuery("sel_irbcreditrating1_esp^" + appno);
	
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			boolean recordflag=false;
			recordflag=rs.next();
			if(recordflag)
			{
				do
				{
					arrRec = new ArrayList();						
					arrRec.add(correctNull(rs.getString("Previous_year")));
					arrRec.add(correctNull(rs.getString("Current_year")));
					arrVal.add(arrRec);
				}
				while (rs.next());
			}
			else
			{
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
				arrRec = new ArrayList();	
				arrRec.add("");
				arrRec.add("");
				arrVal.add(arrRec);
				
			}
			hshRecord.put("arrVal",arrVal);
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getDataSRERatingDetails " + ce.toString());
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
	
	public void upDataSRERatingDetails(HashMap hshValues)  
	{
		ResultSet rs = null;
		
		String appno = "";
		String strAction="";
		
		ArrayList arrValues=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=null;
		
		String []desc=null;
		String []pre_year=null;	
		String []cur_year=null;
		int intUpdatesize=0;
		try
		{
			strAction=Helper.correctNull((String) hshValues.get("hidAction"));
			String strCategory = (String) hshValues.get("hidCategoryType");
			if(strCategory.equalsIgnoreCase("STL"))
			{
				hshValues.put("hidAction", "Update");
			}
			
			appno=Helper.correctNull((String) hshValues.get("appno"));
			
			desc= (String [])hshValues.get("txt_parameter");
			pre_year= (String [])hshValues.get("txt_previous");
			cur_year= (String [])hshValues.get("txt_current");
			
			if (strAction.trim().equals("edit"))
			{
				
				//int len=pre_year.length;
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "delreport105");
				
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				
				hshQuery.put("strQueryId", "del_IRBRating1");
				
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
					
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","ins_srerating");
				//5495840000019, 1, 3, 5, 2, 4, 6, ,
				
				/*
				 (appno,lastscore_basemodel, lastrating_basemodel,lastgradef_basemodel ,
	currentscore_basemodel, currentrating_basemodel, currentgradef_basemodel,
		remarks,extrating_remarks) values(?,?,?,?,?,?,?,?,?)
				 */
				
				arrValues.add(appno);
				arrValues.add(correctNull((String)pre_year[0]));
				arrValues.add(correctNull((String)pre_year[1]));
				arrValues.add(correctNull((String)pre_year[2]));
				
				arrValues.add(correctNull((String)cur_year[0]));
				arrValues.add(correctNull((String)cur_year[1]));
				arrValues.add(correctNull((String)cur_year[2]));
				
				arrValues.add(correctNull((String)hshValues.get("txt_migration")));
				arrValues.add(correctNull((String)hshValues.get("txt_extrating")));
				
										
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size", ""+intUpdatesize);	
				
				for(int k=3;k<8;k++)
				{			
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_IRBRating1");
						
						arrValues.add(appno);
						arrValues.add(Integer.toString(k));
						arrValues.add(correctNull((String)desc[k]));
						arrValues.add(correctNull((String)pre_year[k]));
						arrValues.add(correctNull((String)cur_year[k]));
						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put(""+intUpdatesize, hshQuery);
						hshQueryValues.put("size", ""+intUpdatesize);	
				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				hshQuery.put("strQueryId", "delreport105");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId", "del_IRBRating1");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				hshQueryValues.put("size", ""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			}
			StringBuilder strAudit = new StringBuilder();
			if(!strAction.trim().equalsIgnoreCase("delete"))
			{
				for(int i=0;i<8;i++)
				{
				strAudit.append("~"+desc[i] +":");
			//	strAudit.append("~");
				strAudit.append("~ Previous Year = ");
				strAudit.append(pre_year[i]);
				strAudit.append("~ Current Year = ");
				strAudit.append(cur_year[i]);
				}
			}
			AuditTrial.auditLog(hshValues, "403", appno, strAudit.toString());
		}
		catch (Exception ce) 
		{
			throw new EJBException("Error in upDataSRERatingDetails " + ce.toString());
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
	
	public HashMap getShortReveiwPrint(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		
		HashMap hshRecord = new HashMap();
		
		ArrayList arrVec_supp = new ArrayList();
		ArrayList arrColldetails = new ArrayList();
		ArrayList arrCorpguarantee = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow1 = new ArrayList();
		ArrayList arrRow2 = new ArrayList();
		ArrayList arrPromotors = new ArrayList();
		ArrayList arrGuarantors = new ArrayList();
		ArrayList arrProback = new ArrayList();
		ArrayList arrUnitsworks= new ArrayList();
		ArrayList arrTmpList = new ArrayList();
		ArrayList arrRow12 = new ArrayList();
		ArrayList arrRow16 = new ArrayList();
		ArrayList arrVecRate = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arryCol = new ArrayList();
		ArrayList arrVec1 = new ArrayList();
		ArrayList arrVec = new ArrayList();
		ArrayList arrVec12 = new ArrayList();
		ArrayList arrVec4 = new ArrayList();
		ArrayList WC_Funded = new ArrayList();
		ArrayList OurBank_WC_Funded = new ArrayList();
		ArrayList WC_NonFunded = new ArrayList();
		ArrayList OurBank_WC_NonFunded = new ArrayList();
		ArrayList TL_Funded_NonFunded = new ArrayList();
		ArrayList OurBank_TL = new ArrayList();
		ArrayList arrSubFac = new ArrayList();
		ArrayList arrVec2 = new ArrayList();
		ArrayList arrBankArrangement = new ArrayList();
		ArrayList arrBankArrangementFI=new ArrayList();
		ArrayList arrBank = new ArrayList();
		
		String appno = "";
		String comappid = "";
		String strRegCity = "", strRegState = "";
		String strIndcode="";
		String strOwnership="";
		String strBorrowerType="";
		String strIndustryType="",strGroup="";
		String strTemp="";
		String strPublictype="";
		
		double dblTotalshares=0.0;

		try {
			appno = correctNull((String) hshValues.get("appno"));
			comappid = correctNull((String) hshValues.get("comappid"));

			hshRecord.put("strOrgName", correctNull((String) hshValues.get("strOrgName")));

			if (appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}

/*************************************************************************************************************************************************
 * For finding the customer profile created branch to display in the 
 * point No 1.1                                                      
 * Keyword     :   appno                                             
 * Tables Used :   COMAPPLICANT, ORGANISATIONS, COM_DEMOGRAPHICS     
 * ***********************************************************************************************************************************************/
			strQuery = SQLParser.getSqlQuery("applicant_create_code^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("appCreationBranch",correctNull((String)rs1.getString("org_name")));
			}
			
			if (rs != null)
			{
				rs.close();
			}
			
/*************************************************************************************************************************************************
 * To find the customer ID Using the appno for getting the datas of  
 * Customer profile related datas                                    
 * Keyword     :   appno                                             
 * Tables Used :   COMAPPLICANT, APPLICATIONS, COM_DEMOGRAPHICS      
 * ***********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
			}

/*************************************************************************************************************************************************
 * To Fetch the customer profile datas 								 
 * Print using the customer id got from the previous query           
 * Keyword     :   Comappid                                          
 * Tables Used :   COMAPPLICANT                                      
 * ***********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);

			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("comapp_companyname", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("comapp_companyid", correctNull(rs.getString("comapp_companyid")));
				hshRecord.put("comapp_yrsinbusiness", correctNull(rs.getString("comapp_yrsinbusiness")));
				hshRecord.put("comapp_businessnature", correctNull(rs.getString("comapp_businessnature")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("comapp_businessnature")));
				hshRecord.put("comapp_regadd1", correctNull(rs.getString("comapp_regadd1")));
				hshRecord.put("comapp_regadd2", correctNull(rs.getString("comapp_regadd2")));
				hshRecord.put("comapp_regcity", correctNull(rs.getString("comapp_regcity")));
				hshRecord.put("comapp_regstate", correctNull(rs.getString("comapp_regstate")));
				hshRecord.put("comapp_regphone", correctNull(rs.getString("comapp_regphone")));
				hshRecord.put("comapp_regfax", correctNull(rs.getString("comapp_regfax")));
				hshRecord.put("comapp_regpin", correctNull(rs.getString("comapp_regpin")));
				hshRecord.put("groupdesc", correctNull(rs.getString("groupdesc")));
				hshRecord.put("comapp_ownership", correctNull(rs.getString("comapp_ownership")));
				//hshRecord.put("auth_captial", correctNull(rs.getString("auth_captial")));
				//hshRecord.put("comapp_subcapital", correctNull(rs.getString("comapp_subcapital")));
				hshRecord.put("deal_bank", correctNull(rs.getString("comapp_bankdealing")));
				strIndcode=correctNull(rs.getString("comapp_indcode"));
				strRegCity = correctNull(rs.getString("comapp_regcity"));
				strRegState = correctNull(rs.getString("comapp_regstate"));
				strOwnership=correctNull(rs.getString("comapp_ownership"));
				strIndustryType=correctNull(rs.getString("scale"));
				strGroup=correctNull(rs.getString("comapp_group"));
				//dblTotalshares=rs.getDouble("comapp_totalshares");
				strPublictype=correctNull(rs.getString("comapp_pubtype")).equals("")?"S":correctNull(rs.getString("comapp_pubtype"));
				
			}
			strQuery = SQLParser.getSqlQuery("selstatename2^" + strRegState);
			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("Regstate_name", correctNull(rs.getString("state_name")));
			}

			strQuery = SQLParser.getSqlQuery("selcityname2^" + strRegCity);
			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("Regcity_name", correctNull(rs.getString("city_name")));
			}

			
/**************************************************************************************************************************************************** 
* 
* For fetching the values from Factories/branches (Units/Works)etc			
* 	
*****************************************************************************************************************************************************/
			
			strQuery=SQLParser.getSqlQuery("selallfactorydetails^" + comappid);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strFactype="";
			while(rs.next())
			{
				arrTmpList = new ArrayList();
				
				strFactype=correctNull(rs.getString("comapp_detailtype"));
				arrTmpList.add(correctNull(rs.getString("comapp_name")));
				arrTmpList.add(correctNull(rs.getString("comapp_add")));
				arrTmpList.add(correctNull(rs.getString("comapp_city")));
				arrTmpList.add(correctNull(rs.getString("comapp_state")));
				arrTmpList.add(correctNull(rs.getString("comapp_pincode")));
				
				arrUnitsworks.add(arrTmpList);
				
			}
			hshRecord.put("arrUnitsworks",arrUnitsworks);
			
			
/****************************************************************************************************************************************************
*  
*  For ASSET CLASSIFICATION			
*  
*  
*****************************************************************************************************************************************************/
			
			
			strQuery = SQLParser.getSqlQuery("compropform8^" + appno);

			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_propassettype", correctNull(rs.getString("com_propassettype")).equals("")?"Standard":correctNull(rs.getString("com_propassettype")));
			}

/****************************************************************************************************************************************************
* 
*  For EXTERNAL CREDIT RATING		
*  
*****************************************************************************************************************************************************/
			
			
			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selexternalrating^"+ appno);
			while (rs.next()) {
				if(correctNull(rs.getString("com_propcomtype")).equals("extagency"))
				{
					hshRecord.put("extagency",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extlastrate"))
				{
					hshRecord.put("extlastrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extcurrate"))
				{
					hshRecord.put("extcurrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
			}
			
			
/***************************************************************************************************************************************************** 
* 
* For LEAD and OUR SHARE	
* 																
******************************************************************************************************************************************************/
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("comoperationaldata1^" + appno);

			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strTemp=correctNull(rs.getString("com_propmulbank"));
				hshRecord.put("status_banking",strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":strTemp.equals("4")?"Sole / Consortium":strTemp.equals("5")?"Sole / Multiple":strTemp.equals("6")?"Consortium / Multiple":strTemp.equals("7")?"Sole/ Consortium / Multiple":"");
				hshRecord.put("com_propleadbank", correctNull(rs.getString("com_propleadbank")).equals("")?"N.A":correctNull(rs.getString("com_propleadbank")));
				hshRecord.put("com_proprevperiod", correctNull(rs.getString("com_proprevperiod")));
				hshRecord.put("COM_PROPDEVREVDATE", correctNull(rs.getString("com_propdevrevdate1")).equals("January  -1900")?"N.A.":correctNull(rs.getString("com_propdevrevdate1")));
				String exfb = correctNull(rs.getString("com_propexistfb"));
				String exnfb = correctNull(rs.getString("com_propexistnfb"));
				hshRecord.put("TOTAL_FUNDEDEXI", Helper.formatDoubleValue(rs.getDouble("com_propexistfb")));
				hshRecord.put("TOTAL_NONFUNDEDEXI", Helper.formatDoubleValue(rs.getDouble("com_propexistnfb")));
				hshRecord.put("TOTAL_FUNDEDPROP", Helper.formatDoubleValue(rs.getDouble("com_propproposedfb")));
				hshRecord.put("TOTAL_NONFUNDEDPROP", Helper.formatDoubleValue(rs.getDouble("com_propproposednfb")));
				hshRecord.put("fundbased", exfb);
				hshRecord.put("nonfundbased", exnfb);
				hshRecord.put("consortium_assessment", Helper.CLOBToString(rs.getClob("com_bankingremarks")));
			}

			/**************************************************************************
			 * For Retreving the Data from Banking Arrangement for the executive print
			 * Point No 13 Total Indebitness
			 * Keyword    : Appno
			 * Table Used : COM_BANKING
			 *************************************************************************/
			
			if (rs != null) {
				rs.close();
			}
			double dblourFundExist = 0.0;
			double dblourFundProp = 0.0;
			double dblourNonFundExist = 0.0;
			double dblourNonFundProp = 0.0;
			double dblourTotExist = 0.0;
			double dblourTotProp = 0.0;
			double dblotrFundExist = 0.0;
			double dblotrFundProp = 0.0;
			double dblotrNonFundExist = 0.0;
			double dblotrNonFundProp = 0.0;
			double dblotrTotExist = 0.0;
			double dblotrTotProp = 0.0;
			double dbltotpropFI=0.0;
			double dbltotexistFI=0.0;
			double dblnonfundpropFI=0.0;
			double dblnonfundexistFI=0.0;
			double dblfundpropFI=0.0;
			double dblfundexistFI=0.0;
			
			boolean blnFlag=false;
			
			strQuery = SQLParser.getSqlQuery("combankingselection^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				arrVec1 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag=true;
				}else{
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
					blnFlag=true;
				}
			}
			if(blnFlag)
			{
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec1.add("Other Bank");
				arrRow1.add(arrVec1);
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec1.add("UBI");
				arrRow1.add(arrVec1);
			}
			hshRecord.put("arrRow1", arrRow1);

			
			if (rs != null) {
				rs.close();
			}
			/** We r reusing the same variable used in the previous loop */
			dblourFundExist = 0.0;
			dblourFundProp = 0.0;
			dblourNonFundExist = 0.0;
			dblourNonFundProp = 0.0;
			dblourTotExist = 0.0;
			dblourTotProp = 0.0;
			dblotrFundExist = 0.0;
			dblotrFundProp = 0.0;
			dblotrNonFundExist = 0.0;
			dblotrNonFundProp = 0.0;
			dblotrTotExist = 0.0;
			dblotrTotProp = 0.0;
			blnFlag=false;
			
			arrRow1=new ArrayList();
			strQuery = SQLParser.getSqlQuery("combankingselectionFI^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrVec2 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag = true;
				}else if(strType.trim().equalsIgnoreCase("FI")){
						dblfundexistFI = dblfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
						dblfundpropFI = dblfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
						dblnonfundexistFI = dblnonfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
						dblnonfundpropFI = dblnonfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
						dbltotexistFI = dblfundexistFI+dblnonfundexistFI;
						dbltotpropFI = dblfundpropFI+dblnonfundpropFI;
						blnFlag = true;
				}else{
					blnFlag = true;
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
				}
			}
			if(blnFlag)
			{
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec1.add("Other Bank");
				arrRow1.add(arrVec1);
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec1.add("UBI");
				arrRow1.add(arrVec1);
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblfundexistFI));
				arrVec1.add(Helper.formatDoubleValue(dblfundpropFI));
				arrVec1.add(Helper.formatDoubleValue(dblnonfundexistFI));
				arrVec1.add(Helper.formatDoubleValue(dblnonfundpropFI));
				arrVec1.add(Helper.formatDoubleValue(dbltotexistFI));
				arrVec1.add(Helper.formatDoubleValue(dbltotpropFI));
				arrVec1.add("Financial Institutions");
				arrRow1.add(arrVec1);
			}
			hshRecord.put("arrRow2", arrRow1);

//			 TO FETCH VALUES FROM BANKING ARRANGEMENTS (WC & TL)
			/********************************************************************
			 * For Executive Summary Print Point No: (25) EXPOSURE DETAILS FROM *
			 * BANKING SYSTEM (Incl. Our Bank) Done By: Muralidharan Date:      *
			 * 30-OCT-2007                                                      *
			 * MODIFIED BY G.SURESHKUMAR FOR BRINGING THE REMARKS TO THE FIELD  *
			 * CONDUCT OF THE ACCOUNT                                           *
			 * 01-JULY-2009                                                     * 
			 *********************************************************************/
			arrBankArrangement = new ArrayList();
			arrBankArrangementFI=new ArrayList();
			ArrayList arrNonBankArrange=new ArrayList();
			arrBank = new ArrayList();
			String loan_type = "";
			String bank_name = "";
			double TOT_FE = 0.00;
			double TOT_NFE = 0.00;
			//double TOT_FP = 0.00;
			//double TOT_NFP = 0.00;
			double LIMIT_FE_CON = 0.00;
			double LIMIT_NFE_CON = 0.00;
			double LIMIT_FE_NONCON = 0.00;
			double LIMIT_NFE_NONCON = 0.00;
			double SHARE_FE_CON = 0.00;
			double SHARE_NFE_CON = 0.00;
			String strconductofacct="";

			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("comtotalsel^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				TOT_FE=rs.getDouble("com_totwcfundexist");
				//TOT_FP = rs.getDouble("com_totwcfundprop");
				TOT_NFE=rs.getDouble("com_totwcnonfundexist");
				//TOT_NFP = rs.getDouble("com_totwcnonfundprop");
			}

			strQuery = SQLParser.getSqlQuery("com_banksel^" + appno);

			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrBank.add(correctNull(rs.getString("bank_name")));
			}

			for (int j = 0; j < arrBank.size(); j++) {
				//loan_type = "W";
				bank_name = (String) arrBank.get(j);
				strconductofacct="";
				strQuery = SQLParser.getSqlQuery("com_banking_consortiumsel^" + appno
						+ "^" + bank_name+"^Y");

				if (rs != null)
					rs.close();
				
				SHARE_FE_CON=0.00;
				SHARE_NFE_CON=0.00;
				LIMIT_NFE_CON=0.0;
				LIMIT_FE_CON=0.0;
				LIMIT_FE_NONCON=0.0;
				LIMIT_NFE_NONCON=0.0;
				boolean consortiumflag=false;
				boolean nonconsortiumflag=false;
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(correctNull(rs.getString("combk_consortium")).equals("Y"))
					{
						LIMIT_FE_CON=LIMIT_FE_CON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_CON=LIMIT_NFE_CON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals(""))
							strconductofacct=correctNull(rs.getString("combk_overdue"));
						
						if (TOT_FE != 0.00) {
							SHARE_FE_CON = (LIMIT_FE_CON / TOT_FE) * 100;
						}
						if (TOT_NFE != 0.00) {
							SHARE_NFE_CON = (LIMIT_NFE_CON / TOT_NFE) * 100;
						}
						consortiumflag=true;
					}
					else if(correctNull(rs.getString("combk_selbank")).equals("FI"))
					{
						arrVec1 = new ArrayList();
						arrVec1.add(bank_name);
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtfundexist")));
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtnonfundexist")));
						arrVec1.add(correctNull(rs.getString("combk_overdue")));
						arrVec1.add(correctNull(rs.getString("combk_excess")));
						arrBankArrangementFI.add(arrVec1);
					}
					else
					{
						LIMIT_FE_NONCON=LIMIT_FE_NONCON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_NONCON=LIMIT_NFE_NONCON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals(""))
							strconductofacct=correctNull(rs.getString("combk_overdue"));
						
						nonconsortiumflag=true;
						
					}
					
				}
				 
				if(consortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add(Helper.formatDoubleValue(SHARE_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(SHARE_FE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_CON));
					arrVec1.add(strconductofacct);
					arrBankArrangement.add(arrVec1);
				}
				if(nonconsortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_NONCON));
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_NONCON));
					arrVec1.add(strconductofacct);
					arrNonBankArrange.add(arrVec1);
				}
			}

			hshRecord.put("arrBankArrangement", arrBankArrangement);
			hshRecord.put("arrNonBankArrange", arrNonBankArrange);
			hshRecord.put("arrBankArrangementFI", arrBankArrangementFI);


/***********************************************************************************************************************************************
 * 
 * For Points 
 * Account status,
 * background_promoters,
 * book_value
 * market_value 
 * other_matters
 * 
 * **********************************************************************************************************************************************/
			
			
			
			strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strTemp=correctNull(rs.getString("status_acc"));
				hshRecord.put("status_acc",strTemp.equals("1")?"Regular":strTemp.equals("2")?"EAS-I":strTemp.equals("3")?"EAS-II":strTemp.equals("4")?"SMA":strTemp.equals("5")?"N.A.":"" );
				hshRecord.put("background_promoters", correctNull(rs.getString("background_promoters")));
				//hshRecord.put("book_value", correctNull(rs.getString("book_value")));
				//hshRecord.put("market_value", correctNull(rs.getString("market_value")));
				hshRecord.put("company_rbi", correctNull(rs.getString("company_rbi")));
				hshRecord.put("company_rbidesc", correctNull(Helper.CLOBToString(rs.getClob("company_rbidesc"))));
				hshRecord.put("exposure_norms", correctNull(rs.getString("exposure_norms")).equals("")?"Nil":correctNull(rs.getString("exposure_norms")));
				//hshRecord.put("consortium_assessment", correctNull(rs.getString("consortium_assessment")));
				hshRecord.put("other_matters", correctNull(Helper.CLOBToString(rs.getClob("other_matters"))));
				hshRecord.put("ind_services", correctNull(rs.getString("ind_services")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("ind_services")));
			}
			
			if (rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selcapitalstructure^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("auth_captial", Helper.formatDoubleValue(rs.getDouble("com_authcapital")));
				hshRecord.put("comapp_subcapital", Helper.formatDoubleValue(rs.getDouble("com_subisscapital")));
				hshRecord.put("book_value", correctNull(rs.getString("com_bookvalue")));
				hshRecord.put("market_value", correctNull(rs.getString("com_marketvalue")));
				dblTotalshares=rs.getDouble("com_paidshares");
			}

/********************************************************************************************************************************************
 * 
 * SHAREHOLDING PATTERN
 * 
 * *********************************************************************************************************************************/
			
			
			
			strQuery = SQLParser.getSqlQuery("com_sel_shareholding^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			double dblsharepercent=0.0;
			double dblshares=0.0;
			while (rs.next()) 
			{
				DecimalFormat dc=new DecimalFormat();
				dc.setGroupingUsed(false);
				dc.setMaximumFractionDigits(2);
				dc.setMinimumFractionDigits(2);
				arrVec = new ArrayList();
				//dblTotalshares
				arrVec.add(correctNull(rs.getString("com_compdtfname"))); // 0
				arrVec.add(correctNull(rs.getString("com_compdtlname"))); // 1
				arrVec.add(correctNull(rs.getString("com_compdtmname"))); // 2
				if(dblTotalshares!=0.0)
				{
					if(rs.isLast())
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						if(dblshares==dblTotalshares)
						{
							arrVec.add(""+(100.0-dblsharepercent));
						}
						else if(dblshares<dblTotalshares)
						{
							dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
							arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
						}
						else
						{
							arrVec.add("0.0");
						}
					}
					else
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
						arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
					}
					
				}
				else
				{
					arrVec.add("0.0");
				}
				arrVec.add(correctNull(rs.getString("com_compdtshareheld"))); // 4
				arrVec.add(correctNull(rs.getString("CapContribution"))); // 5
				arrVec.add(correctNull(rs.getString("COM_FACEVALUE"))); // 6

				arrRow.add(arrVec);
			}


			hshRecord.put("arrRow", arrRow);
			

/***********************************************************************************************************************************************
 * 
 * RATING DETAILS 
 * 
 * **********************************************************************************************************************************************/
			
			
strQuery = SQLParser.getSqlQuery("getramrating105details^" + appno);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("LASTSCORE_BASEMODEL")));
				arrVecRate.add(correctNull(rs.getString("CURRENTSCORE_BASEMODEL")));
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("lastrating_basemodel")));
				arrVecRate.add(correctNull(rs.getString("currentrating_basemodel")));
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("LASTGRADEF_BASEMODEL")));
				arrVecRate.add(correctNull(rs.getString("CURRENTGRADEF_BASEMODEL")));
				arrRow16.add(arrVecRate);
				hshRecord.put("mig_remarks",correctNull(rs.getString("remarks")));
				hshRecord.put("extrating",correctNull(rs.getString("extrating_remarks")));
			}
			else
			{
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
			}
			
			strQuery = SQLParser.getSqlQuery("sel_irbcreditrating1_esp^" + appno);
	
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			boolean recordflag=false;
			recordflag=rs.next();
			if(recordflag)
			{
				do
				{
					arrVecRate = new ArrayList();						
					arrVecRate.add(correctNull(rs.getString("Previous_year")));
					arrVecRate.add(correctNull(rs.getString("Current_year")));
					arrRow16.add(arrVecRate);
				}
				while (rs.next());
			}
			else
			{
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
			}
			hshRecord.put("arrVal",arrRow16);

			
/***********************************************************************************************************************************************
 * 
 * Terms and Conditions 
 * 
 * **********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("seltermsandconditionval^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrVec12 = new ArrayList();
				arrVec12.add(correctNull(rs.getString("terms_termdesc")));
				arrRow12.add(arrVec12);

			}
			hshRecord.put("arrRow12", arrRow12);
			
/***********************************************************************************************************************************************
 * 
 * 				For Promotes and Guarantors
 * 
 * **********************************************************************************************************************************************/

			strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrVec4 = new ArrayList();

				arrVec4.add(correctNull(rs.getString("com_compdtfname")));
				arrVec4.add(correctNull(rs.getString("com_compdtlname")));
				arrVec4.add(correctNull(rs.getString("com_compdtmname")));
				arrVec4.add(correctNull(rs.getString("com_compdaca")));
				String company_id = correctNull((String) rs.getString("com_compdtid"));
				if (rs1 != null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcreditreport2^" + appno + "^" + company_id);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					arrVec4.add(correctNull(rs1.getString("CR_Total_MEANS")));
					arrVec4.add(correctNull(rs1.getString("cr_meansason")));
				} 
				else
				{
					arrVec4.add("0.00");
				}
				arrVec4.add(correctNull(rs.getString("com_compdexp")));
				arrVec4.add(correctNull(rs.getString("com_background")));
				String strpromgua[] = correctNull(rs.getString("com_compdttype")).split("@");
				ArrayList arrProCheck=new ArrayList();
				for (int i = 0; i < strpromgua.length; i++) 
				{
					if(strpromgua[i].equals("G")) 
					{
						String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
						if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
						  arrGuarantors.add(arrVec4);
						else
							arrCorpguarantee.add(arrVec4);
						
					}
					else if(!strpromgua[i].equals("O"))
					{
						arrProCheck=new ArrayList(arrVec4);
						//arrProCheck=;
					    if(strpromgua[i].equals("PT"))
						{
					    	arrProCheck.add("Partner");
						}
					    else if(strpromgua[i].equals("SP"))
						{
					    	arrProCheck.add("Sole Proprietor");
						}
					    else if(strpromgua[i].equals("D"))
						{
					    	arrProCheck.add("Director");
						}
					    else if(strpromgua[i].equals("OT")) 
					    {
					    	arrProCheck.add(correctNull(rs.getString("com_compdtdesignation")));
						}
						arrPromotors.add(arrProCheck);
				    }
				}
				arrProback.add(arrVec4);
			}
			hshRecord.put("arrPromotors", arrPromotors);
			hshRecord.put("arrGuarantors", arrGuarantors);
			hshRecord.put("arrProback",arrProback);
			hshRecord.put("arrCorpguarantee", arrCorpguarantee);
			

			if (rs1 != null) 
			{
				rs1.close();
			}

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selcreditreport2^"+appno+"^"+"1");
			if (rs.next())
			{
				hshRecord.put("means",correctNull(rs.getString("CR_Total_MEANS")));
				hshRecord.put("meansason",correctNull(rs.getString("cr_meansason")));
			}
/***********************************************************************************************************************************************
 * 
 * 				For CONDUCT OF THE ACCOUNT
 * 
 * **********************************************************************************************************************************************/
			
			
			
			strQuery = SQLParser.getSqlQuery("conduct_sel^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{

				hshRecord.put("conduct_acc", correctNull(rs.getString("conduct_acc")));
				hshRecord.put("conduct_no", correctNull(rs.getString("conduct_no")));
				hshRecord.put("conduct_accstock", correctNull(rs.getString("conduct_accstock")));
				hshRecord.put("conduct_stockno", correctNull(rs.getString("conduct_stockno")));
				hshRecord.put("conduct_msod", correctNull(rs.getString("conduct_msod")));
				hshRecord.put("conduct_msodno", correctNull(rs.getString("conduct_msodno")));
				hshRecord.put("conduct_qpr", correctNull(rs.getString("conduct_qpr")));
				hshRecord.put("conduct_qprno", correctNull(rs.getString("conduct_qprno")));
				hshRecord.put("conduct_fin", Helper.correctDouble((String) rs.getString("conduct_fin")));
				hshRecord.put("conduct_finno", correctNull(rs.getString("conduct_finno")));
				hshRecord.put("conduct_cma", correctNull(rs.getString("conduct_cma")));
				hshRecord.put("conduct_cmano", correctNull(rs.getString("conduct_cmano")));
				hshRecord.put("conduct_stockstamt", correctNull(rs.getString("conduct_stockstamt")));
				hshRecord.put("conduct_stockdate", correctNull(rs.getString("conduct_stockdate")));
				hshRecord.put("conduct_msodstmt", correctNull(rs.getString("conduct_msodstmt")));
				hshRecord.put("conduct_msoddate", correctNull(rs.getString("conduct_msoddate")));
				hshRecord.put("conduct_qprstmt", correctNull(rs.getString("conduct_qprstmt")));
				hshRecord.put("conduct_qprdate", correctNull(rs.getString("conduct_qprdate")));
				hshRecord.put("conduct_turn", correctNull(rs.getString("conduct_turn")));
				hshRecord.put("conduct_excess", correctNull(rs.getString("conduct_excess")));
				hshRecord.put("conduct_cheques", correctNull(rs.getString("conduct_cheques")));
			}

/***********************************************************************************************************************************************
 * 
 * 				For VALUE OF ACCOUNT
 * 
 * **********************************************************************************************************************************************/
			

			strQuery = SQLParser.getSqlQuery("execsel_VALOFACCOUNT^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("EXEC_PFROM", correctNull(rs.getString("EXEC_PFROM")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PFROM")));
				hshRecord.put("EXEC_PTO", correctNull(rs.getString("EXEC_PTO")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PTO")));
				hshRecord.put("EXEC_CFROM", correctNull(rs.getString("EXEC_CFROM")));
				hshRecord.put("EXEC_CTO", correctNull(rs.getString("EXEC_CTO")));
				hshRecord.put("EXEC_PINTINC", correctNull(rs.getString("EXEC_PINTINC")));
				hshRecord.put("EXEC_CINTINC", correctNull(rs.getString("EXEC_CINTINC")));
				hshRecord.put("EXEC_PFEEINC", correctNull(rs.getString("EXEC_PFEEINC")));
				hshRecord.put("EXEC_CFEEINC", correctNull(rs.getString("EXEC_CFEEINC")));
				hshRecord.put("EXEC_PNOACS", correctNull(rs.getString("EXEC_PNOACS")));
				hshRecord.put("EXEC_PRETAILAMT", correctNull(rs.getString("EXEC_PRETAILAMT")));
				hshRecord.put("EXEC_CNOACS", correctNull(rs.getString("EXEC_CNOACS")));
				hshRecord.put("EXEC_CRETAILAMT", correctNull(rs.getString("EXEC_CRETAILAMT")));
				hshRecord.put("EXEC_POWNAMT", correctNull(rs.getString("EXEC_POWNAMT")));
				hshRecord.put("EXEC_COWNAMT", correctNull(rs.getString("EXEC_COWNAMT")));
				hshRecord.put("EXEC_POWNTENORDATE", correctNull(rs.getString("EXEC_POWNTENORDATE")));
				hshRecord.put("EXEC_COWNTENORDATE", correctNull(rs.getString("EXEC_COWNTENORDATE")));
				hshRecord.put("EXEC_PTHIRDAMT", correctNull(rs.getString("EXEC_PTHIRDAMT")));
				hshRecord.put("EXEC_CTHIRDAMT", correctNull(rs.getString("EXEC_CTHIRDAMT")));
				hshRecord.put("EXEC_PTHIRDTENORDATE", correctNull(rs.getString("EXEC_PTHIRDTENORDATE")));
				hshRecord.put("EXEC_CTHIRDTENORDATE", correctNull(rs.getString("EXEC_CTHIRDTENORDATE")));

			}

/***********************************************************************************************************************************************
 * 
 * 	For DETAILS OF EXCESS ALLOWED DURING THE YEAR and 
 *    CONDUCT OF THE ACCOUNT AND EXPOSURE DETAILS FROM FINANCIAL INSTITUTIONS : 
 * 
 * **********************************************************************************************************************************************/

			

			String strexcess = SQLParser.getSqlQuery("execsel_DETAILEXCESS^"
					+ appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strexcess);
			if (rs.next()) {
				hshRecord.put("EXEC_NOEXCESS", correctNull(rs.getString("EXEC_NOEXCESS")));
				hshRecord.put("EXEC_MAXEXCESS", correctNull(rs.getString("EXEC_MAXEXCESS")));
				hshRecord.put("EXEC_OTHEXP", correctNull(rs.getString("EXEC_OTHEXP")));
				hshRecord.put("EXEC_OTHLIAB", correctNull(rs.getString("EXEC_OTHLIAB")));
				hshRecord.put("EXEC_CONDEXP", correctNull(rs.getString("EXEC_CONDEXP")));
			
			}

			
/***********************************************************************************************************************************************
 * 
 * For OPERATIONAL EXPERIENCE WITH REGARD TO SISTER / ALLIED CONCERNS 
 * Point NO. (20.a)
 * 
 * **********************************************************************************************************************************************/
			
			
			String stroperexp = SQLParser.getSqlQuery("execgrpconsel^" + appno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(stroperexp);
			double dblgccomlimit = 0.0;
			double dblgccomos = 0.0;
			double dblgcfbwclt = 0.0;
			double dblgcfbwcpd = 0.0;
			double dblgcfbwcos = 0.0;
			double dblgctllt = 0.0;
			double dblgctlos = 0.0;
			double dblgcins = 0.0;

			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("EXEC_GCCONNAME")));
				arrCol.add(correctNull(rs.getString("EXEC_GCBRANCH")));
				arrCol.add(correctNull(rs.getString("EXCE_GCCOA")));
				dblgccomlimit = dblgccomlimit + (rs.getDouble("EXEC_GCCOMLIMIT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMLIMIT")));
				dblgccomos = dblgccomos + (rs.getDouble("EXEC_GCCOMOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMOS")));
				dblgcfbwclt = dblgcfbwclt + (rs.getDouble("EXEC_GCFBWCLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCLT")));
				dblgcfbwcpd = dblgcfbwcpd + (rs.getDouble("EXEC_GCFBWCDP"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCDP")));
				dblgcfbwcos = dblgcfbwcos + (rs.getDouble("EXEC_GCFBWCOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCOS")));
				dblgctllt = dblgctllt + (rs.getDouble("EXEC_GCTLLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLLT")));
				dblgctlos = dblgctlos + (rs.getDouble("EXEC_GCTLOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLOS")));
				dblgcins = dblgcins + (rs.getDouble("EXEC_GCINS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCINS")));
				arrCol.add(correctNull(rs.getString("EXEC_GCMOR")));
				arrCol.add(correctNull(rs.getString("EXEC_GCIRREG")));
				arrCol.add(correctNull(rs.getString("comapp_div_name")));
				arrVec_supp.add(arrCol);
			}
			hshRecord.put("oper_info", arrVec_supp);
			hshRecord.put("EXEC_GCCOMLIMIT", Helper.formatDoubleValue(dblgccomlimit));
			hshRecord.put("EXEC_GCCOMOS", Helper.formatDoubleValue(dblgccomos));
			hshRecord.put("EXEC_GCFBWCLT", Helper.formatDoubleValue(dblgcfbwclt));
			hshRecord.put("EXEC_GCFBWCDP", Helper.formatDoubleValue(dblgcfbwcpd));
			hshRecord.put("EXEC_GCFBWCOS", Helper.formatDoubleValue(dblgcfbwcos));
			hshRecord.put("EXEC_GCTLLT", Helper.formatDoubleValue(dblgctllt));
			hshRecord.put("EXEC_GCTLOS", Helper.formatDoubleValue(dblgctlos));
			hshRecord.put("EXEC_GCINS", Helper.formatDoubleValue(dblgcins));

			
/***********************************************************************************************************************************************
 * 
 * For Points 
 * CREDIT FACILITIES SINCE,
 * COMMENTS ON LATEST CREDIT/SEARCH REPORT,
 * PERSONAL GUARANTEE (with means) / CORPORATE GUARANTEE (with TNW of company)
 * COMMENTS ON OTHER BANK'S CREDIT REPORT ON SISTER CONCERNS and etc
 * 
 * **********************************************************************************************************************************************/
			
			
			strQuery = SQLParser.getSqlQuery("execsel_port^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
				hshRecord.put("exec_borrowertype", correctNull(rs.getString("exec_borrowertype")));
				hshRecord.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
				hshRecord.put("exec_date", correctNull(rs.getString("exec_date")));
				hshRecord.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
				hshRecord.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
				hshRecord.put("exec_comments", correctNull(rs.getString("exec_comments_sisterconcern")).equals("")?"Nil":correctNull(rs.getString("exec_comments_sisterconcern")));
				strBorrowerType=correctNull(rs.getString("exec_borrowertype"));
				hshRecord.put("exec_borrowertype",strBorrowerType);
				hshRecord.put("exec_sancauth", correctNull(rs.getString("exec_sancauth")));
				hshRecord.put("exec_refno", correctNull(rs.getString("exec_refno")));
				hshRecord.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
				hshRecord.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
			}
			
/***********************************************************************************************************************************************
 * 
 * For Points 
 *  CORPORATE GUARANTEE (with TNW of company) point No.(15 ii)
 * 
 * *********************************************************************************************************************************************/
			
			
//			if(rs!=null)
//				rs.close();
//			strQuery=SQLParser.getSqlQuery("exec_guadetailsel^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) 
//			{
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("exec_guaname"));
//				arryCol.add(rs.getString("exec_tnw"));
//				arrCorpguarantee.add(arryCol);
//
//			}
//			hshRecord.put("arrCorpguarantee", arrCorpguarantee);
			
/***********************************************************************************************************************************************
 * 
 * For   NATURE AND VALUE OF COLLATERAL SECURITY
 * 
 * **********************************************************************************************************************************************/
			
			
			if (rs != null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + appno+"^Collateral");
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(rs.getString("sec_desc_details"));
				arryCol.add(rs.getString("sec_desc_value"));
				arryCol.add(rs.getString("as_on_date"));
				arryCol.add(rs.getString("sec_valuersname"));
				arryCol.add(rs.getString("sec_insuranceamt"));
				arryCol.add(rs.getString("sec_insexpirydate"));
				arryCol.add(rs.getString("sec_remarks"));

				arrColldetails.add(arryCol);

			}
			hshRecord.put("arrColldetails", arrColldetails);

			if (rs != null) {
				rs.close();
			}

/***********************************************************************************************************************************************
 * 
 * 
 * 
 * **********************************************************************************************************************************************/
			
			
			strQuery = SQLParser.getSqlQuery("execsel_inducom^" + appno);

			if (rs1 != null)
				rs1.close();
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) {

				hshRecord.put("exec_summ_mortage", correctNull(rs1.getString("exec_summ_mortage")));
				hshRecord.put("exec_summ_mortageY", correctNull(rs1.getString("exec_summ_mortageY")));
				hshRecord.put("exec_summ_roc", correctNull(rs1.getString("exec_summ_roc")));
				hshRecord.put("exec_summ_rocY", correctNull(rs1.getString("exec_summ_rocY")));
				hshRecord.put("exec_summ_validdoc", correctNull(rs1.getString("exec_summ_validdoc")));
				hshRecord.put("exec_summ_validdocY", correctNull(rs1.getString("exec_summ_validdocY")));
				hshRecord.put("exec_summ_terms", correctNull(rs1.getString("exec_summ_terms")));
				hshRecord.put("exec_summ_termsY", correctNull(rs1.getString("exec_summ_termsY")));
				hshRecord.put("exec_summ_meetingheld", correctNull(rs1.getString("exec_summ_meetingheld")));
				hshRecord.put("exec_summ_meetingheldY", correctNull(rs1.getString("exec_summ_meetingheldY")));
				hshRecord.put("exec_summ_indlevelsubopm", correctNull(rs1.getString("exec_summ_indlevelsubopm")));
				hshRecord.put("exec_summ_indlevelsubcov", correctNull(rs1.getString("exec_summ_indlevelsubcov")));
				hshRecord.put("exec_summ_indlevelsubroce", correctNull(rs1.getString("exec_summ_indlevelsubroce")));
				hshRecord.put("exec_summ_indlevelsubcr", correctNull(rs1.getString("exec_summ_indlevelsubcr")));
				hshRecord.put("exec_summ_indlevelsubtol", correctNull(rs1.getString("exec_summ_indlevelsubtol")));
				hshRecord.put("exec_summ_dateofinspc2", correctNull(rs1.getString("exec_summ_dateofinspc")));
				hshRecord.put("exec_summ_indlevelotherrisk2", correctNull(rs1.getString("exec_summ_indlevelotherrisk")));
				hshRecord.put("exec_summ_indlevelrbiY2", correctNull(rs1.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks2", correctNull(rs1.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankY2", correctNull(rs1.getString("exec_summ_indlevelbankY")));
				hshRecord.put("exec_summ_indlevelbankremarks2", correctNull(rs1.getString("exec_summ_remarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths2",correctNull(rs1.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelcomkeyweakness2",correctNull(rs1.getString("exec_summ_weakness")));

			}

/**************************************************************************************************************************************
 * 
 * 
 * 
 * **************************************************************************************************************************************/

			strQuery = SQLParser.getSqlQuery("execsel_credit^" + appno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("exec_summ_indlevelrbiY", correctNull(rs.getString("exec_summ_indlevelrbiY")));
				hshRecord.put("exec_summ_indlevelrbiremarks", correctNull(rs.getString("exec_summ_indlevelrbiremarks")));
				hshRecord.put("exec_summ_indlevelbankremarks", correctNull(rs.getString("exec_summ_indlevelbankremarks")));
				hshRecord.put("exec_summ_indlevelcomkeystrengths",correctNull(rs.getString("exec_summ_strengths")));
				hshRecord.put("exec_summ_indlevelgenmanager", correctNull(rs.getString("exec_summ_manager")));
			}

/*************************************************************************************************************************
 * 
 * Auditor Obsevvations
 * 
 * ************************************************************************************************************************/

			String audit_type = "";
			strQuery = SQLParser.getSqlQuery("selallauditobservation^"+appno);
			if (rs != null) {
				rs.close();
			}
			ArrayList arrInternal=new ArrayList();
			ArrayList arrStatutory =new ArrayList();
			ArrayList arrConcurrent=new ArrayList();
			ArrayList arrStock=new ArrayList();
			ArrayList arrRBI=new ArrayList();
			
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("adv_auditorsobservations")));
				arrCol.add(correctNull(rs.getString("adv_branchcomments")));
				
				audit_type = correctNull((String) rs.getString("adv_audittype"));
				if (audit_type.equalsIgnoreCase("1")) {
					arrInternal.add(arrCol);
					hshRecord.put("audit_internal_date", correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("2")) {
					arrConcurrent.add(arrCol);
					hshRecord.put("audit_concurrent_date", correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("3")) {
					arrRBI.add(arrCol);
					hshRecord.put("audit_inspection_date", correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("4")) {
					arrStatutory.add(arrCol);
					hshRecord.put("audit_statutory_date", correctNull(rs.getString("adv_dateaudited")));
				}
				if (audit_type.equalsIgnoreCase("5")) {
					arrStock.add(arrCol);
					hshRecord.put("audit_stock_date", correctNull(rs.getString("adv_dateaudited")));
				}
			}
			
			hshRecord.put("arrInternal", arrInternal);
			hshRecord.put("arrConcurrent", arrConcurrent);
			hshRecord.put("arrRBI", arrRBI);
			hshRecord.put("arrStatutory", arrStatutory);
			hshRecord.put("arrStock", arrStock);

/*************************************************************************************************************************
 * 
 * For CAPITAL STRUCTURE --> Paid-up capital
 * 
 * ************************************************************************************************************************/

			String tot_capital_contribution = "0.00";
			strQuery = SQLParser
					.getSqlQuery("total_pro_gua_capitalcontribution^" + appno);
			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				tot_capital_contribution = Helper.correctDouble(correctNull(rs.getString("TotCapContribution")));
			}

			hshRecord.put("PaidupCapital", tot_capital_contribution);

/***************************************************************************************************************************
 * 
 * FOR WC FUND , WC NON FUND AND TERM LOAN FACILITY TOTAL AMT
 * 
 ***************************************************************************************************************************/			
			
			
			double wc_funded_existing = 0.00, wc_funded_proposed = 0.00;
			double wc_nonfunded_existing = 0.00, wc_nonfunded_proposed = 0.00;
			double tl_funded_existing = 0.00, tl_funded_proposed = 0.00;
			double tl_total_existing = 0.00, tl_total_proposed = 0.00;
			double total_existing = 0.00, total_proposed = 0.00;

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("WC_FUNDED_TOTAL^" + appno);
			if (rs.next())
			{
				wc_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_EXISTING"))));
				wc_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("WC_NONFUNDED_TOTAL^" + appno);
			if (rs.next()) 
			{
				wc_nonfunded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_EXISTING"))));
				wc_nonfunded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}
			
			rs = DBUtils.executeLAPSQuery("TL_FUNDED_TOTAL^" + appno);
			if (rs.next()) 
			{
				tl_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_EXISTING"))));
				tl_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_PROPOSED"))));
			}
			if (rs != null)
			{
				rs.close();
			}
			
			tl_total_existing = tl_funded_existing ;//+ tl_nonfunded_existing;
			tl_total_proposed = tl_funded_proposed ;//+ tl_nonfunded_proposed;

			total_existing = wc_funded_existing + wc_nonfunded_existing + tl_total_existing;
			total_proposed = wc_funded_proposed + wc_nonfunded_proposed	+ tl_total_proposed;

			hshRecord.put("wc_funded_existing", jtn.format(wc_funded_existing));
			hshRecord.put("wc_funded_proposed", jtn.format(wc_funded_proposed));
			
			hshRecord.put("wc_nonfunded_existing", jtn.format(wc_nonfunded_existing));
			hshRecord.put("wc_nonfunded_proposed", jtn.format(wc_nonfunded_proposed));
			
			hshRecord.put("tl_total_existing", jtn.format(tl_total_existing));
			hshRecord.put("tl_total_proposed", jtn.format(tl_total_proposed));
			
			hshRecord.put("total_existing", Helper.formatDoubleValue(total_existing));
			hshRecord.put("total_proposed", Helper.formatDoubleValue(total_proposed));

			
/***************************************************************************************************************************
 * 
 * WC NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 ***************************************************************************************************************************/
			ArrayList arrSecRemarkscol=new ArrayList();
			ArrayList arrSecRemarksrow=new ArrayList();
			OurBank_WC_Funded = new ArrayList();
			OurBank_WC_NonFunded = new ArrayList();
			OurBank_TL = new ArrayList();
			
			
			if (rs != null) 
			{
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				int d2b = 0;
				WC_NonFunded = new ArrayList();
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
					WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
					WC_NonFunded.add(correctNull(rs.getString("facility_existing"))); 		//1
					WC_NonFunded.add(correctNull(rs.getString("facility_proposed"))); 		//2
					WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
					WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
					WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
					WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
					WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
					WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

					String strfacheadid = correctNull(rs.getString("facility_headid"));
				
					//By Gokul.C for the sub facilities
					arrSubFac = new ArrayList();
					arrSubFac = getSubFacilitiesData(appno,strFacSno,"NFD");				//9
					WC_NonFunded.add(arrSubFac);
					//end for sub-facilities
					WC_NonFunded.add(correctNull(rs.getString("bplr")));					//10
					WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
					WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
					WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
					WC_NonFunded.add(strfacheadid);											//14
					
				
						strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + appno);
						rs1 = DBUtils.executeQuery(strQuery);
						ArrayList arrSecurities=new ArrayList();
						int j=0;
						while (rs1.next()) 
						{
							arrCol=new ArrayList();
							arrSecRemarkscol=new ArrayList();
							arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
							arrCol.add(correctNull(rs1.getString("sec_margin"))); 
							arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
							arrSecRemarksrow.add(arrSecRemarkscol);
							arrSecurities.add(arrCol);
							j++;
						}
						WC_NonFunded.add(arrSecurities);
						WC_NonFunded.add(""+j);
				
				OurBank_WC_NonFunded.add(WC_NonFunded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_NonFunded", OurBank_WC_NonFunded);

			
			
/***************************************************************************************************************************
 * 
 * WC FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("com_wc_funded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				int d2 = 0;
				WC_Funded = new ArrayList();
				WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
				WC_Funded.add(correctNull(rs.getString("facility_existing")));
				WC_Funded.add(correctNull(rs.getString("facility_proposed")));
				WC_Funded.add(correctNull(rs.getString("facility_margin")));
				WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
				WC_Funded.add(correctNull(rs.getString("facility_dp")));
				WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
				WC_Funded.add(correctNull(rs.getString("security_value")));
				WC_Funded.add(correctNull(rs.getString("facility_desc")));

				//
				String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"FD");
				WC_Funded.add(arrSubFac);
				WC_Funded.add(correctNull(rs.getString("bplr")));
				WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
				WC_Funded.add(correctNull(rs.getString("facility_category")));
				WC_Funded.add(correctNull(rs.getString("facility_months")));
				WC_Funded.add(correctNull(rs.getString("facility_headid")));
				

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_Funded.add(arrSecurities);
				WC_Funded.add(""+j);

				OurBank_WC_Funded.add(WC_Funded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_Funded", OurBank_WC_Funded);

			
/***************************************************************************************************************************
 * 
 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/

			if (rs != null)
			{
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				int d3 = 0;
				TL_Funded_NonFunded = new ArrayList();
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));

				String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				
				arrSubFac = new ArrayList();
				
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"TL");
				
				TL_Funded_NonFunded.add(arrSubFac);
				TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				TL_Funded_NonFunded.add(arrSecurities);
				TL_Funded_NonFunded.add(""+j);
				OurBank_TL.add(TL_Funded_NonFunded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_TL", OurBank_TL);
			hshRecord.put("arrSecRemarks",arrSecRemarksrow);
/***************************************************************************************************************************
 * 
 * 
 * 
 **************************************************************************************************************************/
			
				strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+appno);
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
	 			String Strproposalvaluesin="";
	 			rs = DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				Strproposalvaluesin=correctNull(rs.getString("prop_valuesin"));
	 				hshRecord.put("proposalvaluesin",Strproposalvaluesin);
	 			}
	 			
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
				
	 			hshRecord.putAll(getExposuredetails(strIndcode,Strproposalvaluesin,strIndustryType,strGroup));
	 			
/***************************************************************************************************************************
 * 
 *
 * 
 **************************************************************************************************************************/

					if(strOwnership.equalsIgnoreCase("IN"))//Individual
					{
						strOwnership="001";
						hshRecord.put("strownership","Individual");
					}
					else if(strOwnership.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
					{
						strOwnership="005";
						hshRecord.put("strownership","Private Limited Company");
					}
					else if(strOwnership.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
					{
						strOwnership="006";
						hshRecord.put("strownership","Public Limited Company");
					}
					else if(strOwnership.equalsIgnoreCase("OP"))//PARTNER SHIP
					{
						strOwnership="007";
						hshRecord.put("strownership","Partnership");
					}
					else if(strOwnership.equalsIgnoreCase("OLC"))//Joint Borrowers
					{
						strOwnership="002";
						hshRecord.put("strownership","Joint Borrowers");
					}
					else if(strOwnership.equalsIgnoreCase("OS"))//Sole Proprietor
					{
						strOwnership="009";
						hshRecord.put("strownership","Sole Proprietor");
					}
					else if(strOwnership.equalsIgnoreCase("Jo"))//Joint Venture
					{
						strOwnership="011";
						hshRecord.put("strownership","Joint Venture");
					}
					else if(strOwnership.equalsIgnoreCase("sub"))//Wholly owned subsidiary
					{
						strOwnership="011";
						hshRecord.put("strownership","Wholly owned subsidiary");
					}
					else if(strOwnership.equalsIgnoreCase("TR"))//Trusts
					{
						strOwnership="004";
						hshRecord.put("strownership","Trusts");
					}
					else if(strOwnership.equalsIgnoreCase("AC"))//Association
					{
						strOwnership="003";
						hshRecord.put("strownership","Association");
					}
					else if(strOwnership.equalsIgnoreCase("nbfc"))//NBFC
					{
						strOwnership="999";
						hshRecord.put("strownership","NBFC");
					}
					else if(strOwnership.equalsIgnoreCase("HUF"))//HUF
					{
						strOwnership="008";
						hshRecord.put("strownership","H.U.F");
					}
					else if(strOwnership.equalsIgnoreCase("OO"))//Others
					{
						strOwnership="999";
						hshRecord.put("strownership","Others");
					}
					
					strQuery = SQLParser.getSqlQuery("sel_constitutionexposure^"+strBorrowerType+"^"+strOwnership+"^"+strPublictype);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("maxlimit",""+(Strproposalvaluesin.equalsIgnoreCase("C")?rs.getDouble("exp_maxlimit"):(rs.getDouble("exp_maxlimit")*100)));
					}
					strQuery = SQLParser.getSqlQuery("compropform11^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("companybackground",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
					}
					
					strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					StringBuffer sbfsignatories=null;
					if(rs.next())
					{
						sbfsignatories = new StringBuffer(correctNull(rs.getString("exec_signatures")));
						hshRecord.put("exec_mcmresolution",correctNull(rs.getString("exec_mcmresolution")));
						hshRecord.put("exec_delegated",correctNull(rs.getString("exec_delegated")));
					}
					if(sbfsignatories!=null)
					{
						for (int i = 0;i < sbfsignatories.length(); i++) {
							if (sbfsignatories.charAt(i) == '\n') {
								sbfsignatories.replace(i, i + 1, "<br>");
							}
							if (sbfsignatories.charAt(i) == ' ') {
								sbfsignatories.replace(i, i + 1, "&nbsp;");
							}
						}
						hshRecord.put("exec_signatures",sbfsignatories.toString());
					}
					
					
/********************************************************************************************************************************************
 * 
 * 							JUSTIFICATION /RESONS FOR SEEKING EXTENSION/SHORT REVIEW 
 * 
 * *********************************************************************************************************************************/
					
					
				strQuery=SQLParser.getSqlQuery("sel_srecomment^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("comsre_comments",correctNull(Helper.CLOBToString(rs.getClob("comsre_comments"))));
				}
				
/********************************************************************************************************************************************
 * 
 *   								Justification for continuation of concession, if any:  
 * 
 **********************************************************************************************************************************/					
				String strterms="";
				strQuery=SQLParser.getSqlQuery("sel_otrsancterms^"+appno);
				arrRow=new ArrayList();
				rs=DBUtils.executeQuery(strQuery);
				int i=1;
				while(rs.next())
				{
					arrCol=new ArrayList();
					if(strterms.equals("") || strterms.equals(correctNull(rs.getString("otrsancterms_terms"))))
					{
						i++;
					}
					else
					{
						hshRecord.put(strterms+"size",""+(i-1));
						i=1;
					}
					strterms=correctNull(rs.getString("otrsancterms_terms"));
					arrCol.add(correctNull(rs.getString("otrsancterms_slrno")));//0
					arrCol.add(strterms);//1
					arrCol.add(correctNull(rs.getString("otrsancterms_modification")));//2
					arrCol.add(correctNull(rs.getString("otrsancterms_justification")));//3
					arrRow.add(arrCol);
					
					
				}
				hshRecord.put(strterms+"size",""+i);
				hshRecord.put("ConcessarrRow",arrRow);

/********************************************************************************************************************************************
 * 
 *   								Financials  
 * 
 **********************************************************************************************************************************/					
				
				
				strQuery=SQLParser.getSqlQuery("sel_execfin^"+appno+"^"+"0^FI");
				arrRow=new ArrayList();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();			
					arrCol.add(correctNull(rs.getString("fin_year1")));
					arrCol.add(correctNull(rs.getString("fin_year2")));
					arrCol.add(correctNull(rs.getString("fin_year3")));
					arrCol.add(correctNull(rs.getString("fin_year4")));
					arrCol.add(correctNull(rs.getString("fin_rowdesc")));
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrValFin",arrRow);
				
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+appno+"^"+"FI"+"^"+"0");
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
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
				if (rs1 != null)
				{
					rs1.close();
				}
				if (rs2 != null)
				{
					rs2.close();
				}
				if (rs5 != null)
				{
					rs5.close();
				}
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getShortTermLoanPrint(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		
		HashMap hshRecord = new HashMap();
		
		ArrayList arrVec_supp = new ArrayList();
		ArrayList arrColldetails = new ArrayList();
		ArrayList arrCorpguarantee = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrGuarantors = new ArrayList();
		ArrayList arrUnitsworks= new ArrayList();
		ArrayList arrTmpList = new ArrayList();
		ArrayList arrRow12 = new ArrayList();
		ArrayList arrRow16 = new ArrayList();
		ArrayList arrVecRate = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arryCol = new ArrayList();
		ArrayList arrVec12 = new ArrayList();
		ArrayList arrVec4 = new ArrayList();
		ArrayList WC_Funded = new ArrayList();
		ArrayList OurBank_WC_Funded = new ArrayList();
		ArrayList WC_NonFunded = new ArrayList();
		ArrayList OurBank_WC_NonFunded = new ArrayList();
		ArrayList TL_Funded_NonFunded = new ArrayList();
		ArrayList OurBank_TL = new ArrayList();
		ArrayList arrSubFac = new ArrayList();
		
		String appno = "";
		String comappid = "";
		String strRegCity = "", strRegState = "";
		String strIndcode="";
		String strOwnership="";
		String strBorrowerType="";
		String strIndustryType="",strGroup="";
		String strTemp="";
		String strPublictype="";

		try 
		{
			appno = correctNull((String) hshValues.get("appno"));
			comappid = correctNull((String) hshValues.get("comappid"));

			hshRecord.put("strOrgName", correctNull((String) hshValues.get("strOrgName")));

			if (appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			
/***********************************************************************************************************************************************
 * 
 * For Points 
 * Ref No,
 * Date ,
 * MCM,
 * agendano,
 * 
 * **********************************************************************************************************************************************/
						
		strQuery = SQLParser.getSqlQuery("execsel_port^" + appno);
		
		if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) 
		{
			//hshRecord.put("cmd_searchreport", correctNull(rs.getString("cmd_searchreport")));
			//hshRecord.put("audit_notes", correctNull(Helper.CLOBToString(rs.getClob("audit_notes"))));
			hshRecord.put("exec_date", correctNull(rs.getString("exec_date")));
			hshRecord.put("sel_guaranteoffered", correctNull(rs.getString("exec_offercorpguarantee")));
			hshRecord.put("sel_applicantguarantee", correctNull(rs.getString("exec_whetherapplco")));
			hshRecord.put("exec_comments", correctNull(rs.getString("exec_comments_sisterconcern")).equals("")?"Nil":correctNull(rs.getString("exec_comments_sisterconcern")));
			strBorrowerType=correctNull(rs.getString("exec_borrowertype"));
			//hshRecord.put("exec_borrowertype",strBorrowerType);
			hshRecord.put("exec_sancauth", correctNull(rs.getString("exec_sancauth")));
			hshRecord.put("exec_refno", correctNull(rs.getString("exec_refno")));
			hshRecord.put("exec_mcm", correctNull(rs.getString("exec_mcm")));
			hshRecord.put("exec_agendano", correctNull(rs.getString("exec_agendano")));
			hshRecord.put("exec_presentreq", correctNull(rs.getString("exec_presentreq")));
		}
			
/*************************************************************************************************************************************************
 * For finding the customer profile created branch to display in the 
 * point No 1.1                                                      
 * Keyword     :   appno                                             
 * Tables Used :   COMAPPLICANT, ORGANISATIONS, COM_DEMOGRAPHICS     
 * ***********************************************************************************************************************************************/
			strQuery = SQLParser.getSqlQuery("applicant_create_code^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("appCreationBranch",correctNull((String)rs1.getString("org_name")));
			}
			
			if (rs != null)
			{
				rs.close();
			}
			
/*************************************************************************************************************************************************
 * To find the customer ID Using the appno for getting the datas of  
 * Customer profile related datas                                    
 * Keyword     :   appno                                             
 * Tables Used :   COMAPPLICANT, APPLICATIONS, COM_DEMOGRAPHICS      
 * ***********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
			}

			
			
			
			strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strTemp=correctNull(rs.getString("status_acc"));
				hshRecord.put("status_acc",strTemp.equals("1")?"Regular":strTemp.equals("2")?"EAS-I":strTemp.equals("3")?"EAS-II":strTemp.equals("4")?"SMA":strTemp.equals("5")?"N.A.":"" );
				hshRecord.put("exposure_norms", correctNull(rs.getString("exposure_norms")).equals("")?"Nil":correctNull(rs.getString("exposure_norms")));
			}

			
			
/*************************************************************************************************************************************************
 * To Fetch the customer profile datas 								 
 * Print using the customer id got from the previous query           
 * Keyword     :   Comappid                                          
 * Tables Used :   COMAPPLICANT                                      
 * ***********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);

			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("comapp_companyname", correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("comapp_companyid", correctNull(rs.getString("comapp_companyid")));
				hshRecord.put("comapp_yrsinbusiness", correctNull(rs.getString("comapp_yrsinbusiness")));
				hshRecord.put("comapp_businessnature", correctNull(rs.getString("comapp_businessnature")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("comapp_businessnature")));
				hshRecord.put("comapp_regadd1", correctNull(rs.getString("comapp_regadd1")));
				hshRecord.put("comapp_regadd2", correctNull(rs.getString("comapp_regadd2")));
				hshRecord.put("comapp_regcity", correctNull(rs.getString("comapp_regcity")));
				hshRecord.put("comapp_regstate", correctNull(rs.getString("comapp_regstate")));
				hshRecord.put("comapp_regphone", correctNull(rs.getString("comapp_regphone")));
				hshRecord.put("comapp_regfax", correctNull(rs.getString("comapp_regfax")));
				hshRecord.put("comapp_regpin", correctNull(rs.getString("comapp_regpin")));
				hshRecord.put("groupdesc", correctNull(rs.getString("groupdesc")));
				hshRecord.put("comapp_ownership", correctNull(rs.getString("comapp_ownership")));
				//hshRecord.put("auth_captial", correctNull(rs.getString("auth_captial")));
				//hshRecord.put("comapp_subcapital", correctNull(rs.getString("comapp_subcapital")));
				//hshRecord.put("deal_bank", correctNull(rs.getString("comapp_bankdealing")));
				strIndcode=correctNull(rs.getString("comapp_indcode"));
				strRegCity = correctNull(rs.getString("comapp_regcity"));
				strRegState = correctNull(rs.getString("comapp_regstate"));
				strOwnership=correctNull(rs.getString("comapp_ownership"));
				strIndustryType=correctNull(rs.getString("scale"));
				strGroup=correctNull(rs.getString("comapp_group"));
				strPublictype=correctNull(rs.getString("comapp_pubtype")).equals("")?"S":correctNull(rs.getString("comapp_pubtype"));
				
			}
			strQuery = SQLParser.getSqlQuery("selstatename2^" + strRegState);
			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("Regstate_name", correctNull(rs.getString("state_name")));
			}

			strQuery = SQLParser.getSqlQuery("selcityname2^" + strRegCity);
			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("Regcity_name", correctNull(rs.getString("city_name")));
			}

			
/**************************************************************************************************************************************************** 
* 
* For fetching the values from Factories/branches (Units/Works)etc			
* 	
*****************************************************************************************************************************************************/
			
			strQuery=SQLParser.getSqlQuery("selallfactorydetails^" + comappid);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strFactype="";
			while(rs.next())
			{
				arrTmpList = new ArrayList();
				
				strFactype=correctNull(rs.getString("comapp_detailtype"));
				arrTmpList.add(correctNull(rs.getString("comapp_name")));
				arrTmpList.add(correctNull(rs.getString("comapp_add")));
				arrTmpList.add(correctNull(rs.getString("comapp_city")));
				arrTmpList.add(correctNull(rs.getString("comapp_state")));
				arrTmpList.add(correctNull(rs.getString("comapp_pincode")));
				
				arrUnitsworks.add(arrTmpList);
				
			}
			hshRecord.put("arrUnitsworks",arrUnitsworks);
			
			
/****************************************************************************************************************************************************
*  
*  For ASSET CLASSIFICATION			
*  
*  
*****************************************************************************************************************************************************/
			
			
			strQuery = SQLParser.getSqlQuery("compropform8^" + appno);

			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("com_propassettype", correctNull(rs.getString("com_propassettype")).equals("")
						?"Standard":correctNull(rs.getString("com_propassettype")));
			}

/****************************************************************************************************************************************************
* 
*  For EXTERNAL CREDIT RATING		
*  
*****************************************************************************************************************************************************/
			
			
			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selexternalrating^"+ appno);
			while (rs.next()) {
				if(correctNull(rs.getString("com_propcomtype")).equals("extagency"))
				{
					hshRecord.put("extagency",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extlastrate"))
				{
					hshRecord.put("extlastrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
				else if(correctNull(rs.getString("com_propcomtype")).equals("extcurrate"))
				{
					hshRecord.put("extcurrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
				}
			}
			
			
/***************************************************************************************************************************************************** 
* 
* For LEAD and OUR SHARE	
* 																
******************************************************************************************************************************************************/
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("comoperationaldata1^" + appno);

			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strTemp=correctNull(rs.getString("com_propmulbank"));
				hshRecord.put("status_banking",strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":"Others");
				hshRecord.put("com_propleadbank", correctNull(rs.getString("com_propleadbank")));
				hshRecord.put("com_proprevperiod", correctNull(rs.getString("com_proprevperiod")));
				hshRecord.put("COM_PROPDEVREVDATE", correctNull(rs.getString("com_propdevrevdate1")).equals("January  -1900")?"N.A.":correctNull(rs.getString("com_propdevrevdate1")));
				hshRecord.put("TOTAL_FUNDED", correctNull(rs.getString("com_propproposedfb")));
				hshRecord.put("TOTAL_NONFUNDED", correctNull(rs.getString("com_propproposednfb")));
				hshRecord.put("fundbased", correctNull(rs.getString("com_propexistfb")));
				hshRecord.put("nonfundbased", correctNull(rs.getString("com_propexistnfb")));
				hshRecord.put("consortium_assessment", Helper.CLOBToString(rs.getClob("com_bankingremarks")));
			}
			
/***********************************************************************************************************************************************
 * 
 * RATING DETAILS 
 * 
 * **********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("getramrating105details^" + appno);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("LASTSCORE_BASEMODEL")));
				arrVecRate.add(correctNull(rs.getString("CURRENTSCORE_BASEMODEL")));
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("lastrating_basemodel")));
				arrVecRate.add(correctNull(rs.getString("currentrating_basemodel")));
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add(correctNull(rs.getString("LASTGRADEF_BASEMODEL")));
				arrVecRate.add(correctNull(rs.getString("CURRENTGRADEF_BASEMODEL")));
				arrRow16.add(arrVecRate);
				hshRecord.put("mig_remarks",correctNull(rs.getString("remarks")));
				hshRecord.put("extrating",correctNull(rs.getString("extrating_remarks")));
			}
			else
			{
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
				
				arrVecRate = new ArrayList();	
				arrVecRate.add("");
				arrVecRate.add("");
				arrRow16.add(arrVecRate);
			}

			hshRecord.put("arrVal",arrRow16);
			
/***********************************************************************************************************************************************
 * 
 * Terms and Conditions 
 * 
 * **********************************************************************************************************************************************/
			
			strQuery = SQLParser.getSqlQuery("seltermsandconditionval^" + appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrVec12 = new ArrayList();
				arrVec12.add(correctNull(rs.getString("terms_termdesc")));
				arrRow12.add(arrVec12);

			}
			hshRecord.put("arrRow12", arrRow12);
			
/***********************************************************************************************************************************************
 * 
 * 				For Promotes and Guarantors
 * 
 * **********************************************************************************************************************************************/

			//Personal Promotes
			
			strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"+ appno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrVec4 = new ArrayList();

				arrVec4.add(correctNull(rs.getString("com_compdtfname")));
				arrVec4.add(correctNull(rs.getString("com_compdtlname")));
				arrVec4.add(correctNull(rs.getString("com_compdtmname")));
				arrVec4.add(correctNull(rs.getString("com_compdaca")));
				String company_id = correctNull((String) rs.getString("com_compdtid"));
				if (rs1 != null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcreditreport2^" + appno + "^" + company_id);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					arrVec4.add(correctNull(rs1.getString("CR_Total_MEANS")));
					arrVec4.add(correctNull(rs1.getString("cr_meansason")));
				} 
				else
				{
					arrVec4.add("0.00");
				}
				arrVec4.add(correctNull(rs.getString("com_compdexp")));

				String strpromgua[] = correctNull(rs.getString("com_compdttype")).split("@");

				for (int i = 0; i < strpromgua.length; i++) 
				{
					if (strpromgua[i].equals("G")) 
					{
						String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
						if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
						  arrGuarantors.add(arrVec4);
						else
							arrCorpguarantee.add(arrVec4);
						
					}
				}
				
				
			}
			hshRecord.put("arrGuarantors", arrGuarantors);
			hshRecord.put("arrCorpguarantee", arrCorpguarantee);

			//CORPORATE GUARANTEE
//						
//			if(rs!=null)
//				rs.close();
//			strQuery=SQLParser.getSqlQuery("exec_guadetailsel^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) 
//			{
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("exec_guaname"));
//				arryCol.add(rs.getString("exec_tnw"));
//				arrCorpguarantee.add(arryCol);
//
//			}
//			hshRecord.put("arrCorpguarantee", arrCorpguarantee);
			
			

			
/***********************************************************************************************************************************************
 * 
 * For   NATURE AND VALUE OF COLLATERAL SECURITY
 * 
 * **********************************************************************************************************************************************/
			
			
			if (rs != null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + appno+"^Collateral");
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("sec_desc_details"));
				arryCol.add(rs.getString("sec_desc_value"));
				arryCol.add(rs.getString("as_on_date"));
				arryCol.add(rs.getString("sec_valuersname"));
				arryCol.add(rs.getString("sec_insuranceamt"));
				arryCol.add(rs.getString("sec_insexpirydate"));
				arryCol.add(rs.getString("sec_remarks"));

				arrColldetails.add(arryCol);

			}
			hshRecord.put("arrColldetails", arrColldetails);

			if (rs != null) 
			{
				rs.close();
			}

/***********************************************************************************************************************************************
 * 
 * For OPERATIONAL EXPERIENCE WITH REGARD TO SISTER / ALLIED CONCERNS 
 * 
 * 
 * **********************************************************************************************************************************************/
						
						
				String stroperexp = SQLParser.getSqlQuery("execgrpconsel^" + appno);
				if (rs != null) 
				{
					rs.close();
				}
					rs = DBUtils.executeQuery(stroperexp);
					double dblgccomlimit = 0.0;
					double dblgccomos = 0.0;
					double dblgcfbwclt = 0.0;
					double dblgcfbwcpd = 0.0;
					double dblgcfbwcos = 0.0;
					double dblgctllt = 0.0;
					double dblgctlos = 0.0;
					double dblgcins = 0.0;
				
				while (rs.next()) 
				{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("EXEC_GCCONNAME")));
						arrCol.add(correctNull(rs.getString("EXEC_GCBRANCH")));
						arrCol.add(correctNull(rs.getString("EXCE_GCCOA")));
						dblgccomlimit = dblgccomlimit + (rs.getDouble("EXEC_GCCOMLIMIT"));
						arrCol.add(correctNull(rs.getString("EXEC_GCCOMLIMIT")));
						dblgccomos = dblgccomos + (rs.getDouble("EXEC_GCCOMOS"));
						arrCol.add(correctNull(rs.getString("EXEC_GCCOMOS")));
						dblgcfbwclt = dblgcfbwclt + (rs.getDouble("EXEC_GCFBWCLT"));
						arrCol.add(correctNull(rs.getString("EXEC_GCFBWCLT")));
						dblgcfbwcpd = dblgcfbwcpd + (rs.getDouble("EXEC_GCFBWCDP"));
						arrCol.add(correctNull(rs.getString("EXEC_GCFBWCDP")));
						dblgcfbwcos = dblgcfbwcos + (rs.getDouble("EXEC_GCFBWCOS"));
						arrCol.add(correctNull(rs.getString("EXEC_GCFBWCOS")));
						dblgctllt = dblgctllt + (rs.getDouble("EXEC_GCTLLT"));
						arrCol.add(correctNull(rs.getString("EXEC_GCTLLT")));
						dblgctlos = dblgctlos + (rs.getDouble("EXEC_GCTLOS"));
						arrCol.add(correctNull(rs.getString("EXEC_GCTLOS")));
						dblgcins = dblgcins + (rs.getDouble("EXEC_GCINS"));
						arrCol.add(correctNull(rs.getString("EXEC_GCINS")));
						arrCol.add(correctNull(rs.getString("EXEC_GCMOR")));
						arrCol.add(correctNull(rs.getString("EXEC_GCIRREG")));
						arrCol.add(correctNull(rs.getString("comapp_div_name")));
						arrVec_supp.add(arrCol);
				}
				hshRecord.put("oper_info", arrVec_supp);
				hshRecord.put("EXEC_GCCOMLIMIT", Helper.formatDoubleValue(dblgccomlimit));
				hshRecord.put("EXEC_GCCOMOS", Helper.formatDoubleValue(dblgccomos));
				hshRecord.put("EXEC_GCFBWCLT", Helper.formatDoubleValue(dblgcfbwclt));
				hshRecord.put("EXEC_GCFBWCDP", Helper.formatDoubleValue(dblgcfbwcpd));
				hshRecord.put("EXEC_GCFBWCOS", Helper.formatDoubleValue(dblgcfbwcos));
				hshRecord.put("EXEC_GCTLLT", Helper.formatDoubleValue(dblgctllt));
				hshRecord.put("EXEC_GCTLOS", Helper.formatDoubleValue(dblgctlos));
				hshRecord.put("EXEC_GCINS", Helper.formatDoubleValue(dblgcins));


				
/***************************************************************************************************************************
 * 
 * Comments on EXPOSURE NORMS FOR UNSECURED ADVANCES and UMBRELLA LIMIT FOR SUB-BPLR LENDING
 * 
 ***************************************************************************************************************************/			
				
				
				
				strQuery = SQLParser.getSqlQuery("sel_stlcomments^"+appno+"^"+"'norms','bplr'");
				
				rs = DBUtils.executeQuery(strQuery);	
				
				while(rs.next())
				{
					if(correctNull((String)rs.getString("comstl_type")).equalsIgnoreCase("norms"))
					{
						hshRecord.put("comstl_norms",Helper.CLOBToString(rs.getClob("comstl_comments")));
					}
					else if(correctNull((String)rs.getString("comstl_type")).equalsIgnoreCase("bplr"))
					{
						hshRecord.put("comstl_bplr",Helper.CLOBToString(rs.getClob("comstl_comments")));
					}
				}
/***************************************************************************************************************************
 * 
 * Comments for ASSESSMENT OF THE PROPOSAL
 * 
 ***************************************************************************************************************************/	
				
				strQuery=SQLParser.getSqlQuery("sel_termloanassessmentcomments^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("com_termloan_comments",correctNull(Helper.CLOBToString(rs.getClob("com_termloan_comments"))));
				}
/***************************************************************************************************************************
 * 
 * Comments on CASH FLOW STATEMENT
 * 
 ***************************************************************************************************************************/			
				
				
				strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+appno+"^"+"CA"+"^0");
		    	if(rs!=null)
		    		rs.close();
		    	rs=DBUtils.executeQuery(strQuery);
		    	if(rs.next())
		    	{
		    		hshRecord.put("exec_notes",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
		    	}
				
/***************************************************************************************************************************
 * 
 * FOR WC FUND , WC NON FUND AND TERM LOAN FACILITY TOTAL AMT
 * 
 ***************************************************************************************************************************/			
			
			
			double wc_funded_existing = 0.00, wc_funded_proposed = 0.00;
			double wc_nonfunded_existing = 0.00, wc_nonfunded_proposed = 0.00;
			double tl_funded_existing = 0.00, tl_funded_proposed = 0.00;
			double tl_total_existing = 0.00, tl_total_proposed = 0.00;
			double total_existing = 0.00, total_proposed = 0.00;

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("WC_FUNDED_TOTAL_adc^" + appno);
			if (rs.next())
			{
				wc_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_EXISTING"))));
				wc_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("WC_NONFUNDED_TOTAL_adc^" + appno);
			if (rs.next()) 
			{
				wc_nonfunded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_EXISTING"))));
				wc_nonfunded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}
			
			rs = DBUtils.executeLAPSQuery("TL_FUNDED_TOTAL_adc^" + appno);
			if (rs.next()) 
			{
				tl_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_EXISTING"))));
				tl_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_PROPOSED"))));
			}
			if (rs != null)
			{
				rs.close();
			}
			
			tl_total_existing = tl_funded_existing ;//+ tl_nonfunded_existing;
			tl_total_proposed = tl_funded_proposed ;//+ tl_nonfunded_proposed;

			total_existing = wc_funded_existing + wc_nonfunded_existing + tl_total_existing;
			total_proposed = wc_funded_proposed + wc_nonfunded_proposed	+ tl_total_proposed;

			hshRecord.put("wc_funded_existing", jtn.format(wc_funded_existing));
			hshRecord.put("wc_funded_proposed", jtn.format(wc_funded_proposed));
			
			hshRecord.put("wc_nonfunded_existing", jtn.format(wc_nonfunded_existing));
			hshRecord.put("wc_nonfunded_proposed", jtn.format(wc_nonfunded_proposed));
			
			hshRecord.put("tl_total_existing", jtn.format(tl_total_existing));
			hshRecord.put("tl_total_proposed", jtn.format(tl_total_proposed));
			
			hshRecord.put("total_existing", Helper.formatDoubleValue(total_existing));
			hshRecord.put("total_proposed", Helper.formatDoubleValue(total_proposed));

			
/***************************************************************************************************************************
 * 
 * WC NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 ***************************************************************************************************************************/
			
			OurBank_WC_Funded = new ArrayList();
			OurBank_WC_NonFunded = new ArrayList();
			OurBank_TL = new ArrayList();
			ArrayList arrSecRemarkscol=new ArrayList();
			ArrayList arrSecRemarksrow=new ArrayList();
			
			
			if (rs != null) 
			{
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("com_wc_nonfunded_adc^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				int d2b = 0;
				WC_NonFunded = new ArrayList();
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
				WC_NonFunded.add(correctNull(rs.getString("facility_existing"))); 		//1
				WC_NonFunded.add(correctNull(rs.getString("facility_proposed"))); 		//2
				WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
				WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
				WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
				WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
				WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
				WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

				String strfacheadid = correctNull(rs.getString("facility_headid"));
				
				
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"existstl_NFD");				//9
				WC_NonFunded.add(arrSubFac);
				
				WC_NonFunded.add(correctNull(rs.getString("bplr")));					//10
				WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
				WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
				WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
				WC_NonFunded.add(strfacheadid);											//14
					
				
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
			   }
				 WC_NonFunded.add(arrSecurities);
				 WC_NonFunded.add(""+j);
				
				OurBank_WC_NonFunded.add(WC_NonFunded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_NonFunded", OurBank_WC_NonFunded);

			
			
/***************************************************************************************************************************
 * 
 * WC FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/
			
			if (rs != null) 
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("com_wc_funded_adc^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				int d2 = 0;
				WC_Funded = new ArrayList();
				WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
				WC_Funded.add(correctNull(rs.getString("facility_existing")));
				WC_Funded.add(correctNull(rs.getString("facility_proposed")));
				WC_Funded.add(correctNull(rs.getString("facility_margin")));
				WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
				WC_Funded.add(correctNull(rs.getString("facility_dp")));
				WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
				WC_Funded.add(correctNull(rs.getString("security_value")));
				WC_Funded.add(correctNull(rs.getString("facility_desc")));

				//
				String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"existstl_FD");
				WC_Funded.add(arrSubFac);
				WC_Funded.add(correctNull(rs.getString("bplr")));
				WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
				WC_Funded.add(correctNull(rs.getString("facility_category")));
				WC_Funded.add(correctNull(rs.getString("facility_months")));
				WC_Funded.add(correctNull(rs.getString("facility_headid")));
				

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_Funded.add(arrSecurities);
				WC_Funded.add(""+j);

				OurBank_WC_Funded.add(WC_Funded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_WC_Funded", OurBank_WC_Funded);

			
/***************************************************************************************************************************
 * 
 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 **************************************************************************************************************************/

			if (rs != null)
			{
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded_adc^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				int d3 = 0;
				TL_Funded_NonFunded = new ArrayList();
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));

				String strfacheadid = correctNull(rs.getString("facility_headid"));
				String strfacsubid = correctNull(rs.getString("facility_id"));
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				
				arrSubFac = new ArrayList();
				
				arrSubFac = getSubFacilitiesData(appno,strFacSno,"existstl_TL");
				
				TL_Funded_NonFunded.add(arrSubFac);
				TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  appno);
				rs1 = DBUtils.executeQuery(strQuery);
				ArrayList arrSecurities=new ArrayList();
				int j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				TL_Funded_NonFunded.add(arrSecurities);
				TL_Funded_NonFunded.add(""+j);
				OurBank_TL.add(TL_Funded_NonFunded);
				hshRecord.put("detailsasondate", correctNull(rs.getString("facility_osason")));
			}

			hshRecord.put("OurBank_TL", OurBank_TL);
			hshRecord.put("arrSecRemarks",arrSecRemarksrow);
/***************************************************************************************************************************
 * 
 * 
 * 
 **************************************************************************************************************************/
			
				strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+appno);
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
	 			String Strproposalvaluesin="";
	 			rs = DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				Strproposalvaluesin=correctNull(rs.getString("prop_valuesin"));
	 				hshRecord.put("proposalvaluesin",Strproposalvaluesin);
	 			}
	 			
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
				
	 			hshRecord.putAll(getExposuredetails(strIndcode,Strproposalvaluesin,strIndustryType,strGroup));
	 			
/***************************************************************************************************************************
 * 
 * 
 * 
 **************************************************************************************************************************/

					if(strOwnership.equalsIgnoreCase("IN"))//Individual
					{
						strOwnership="001";
						hshRecord.put("strownership","Individual");
					}
					else if(strOwnership.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
					{
						strOwnership="005";
						hshRecord.put("strownership","Private Limited Company");
					}
					else if(strOwnership.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
					{
						strOwnership="006";
						hshRecord.put("strownership","Public Limited Company");
					}
					else if(strOwnership.equalsIgnoreCase("OP"))//PARTNER SHIP
					{
						strOwnership="007";
						hshRecord.put("strownership","Partnership");
					}
					else if(strOwnership.equalsIgnoreCase("OLC"))//Joint Borrowers
					{
						strOwnership="002";
						hshRecord.put("strownership","Joint Borrowers");
					}
					else if(strOwnership.equalsIgnoreCase("OS"))//Sole Proprietor
					{
						strOwnership="009";
						hshRecord.put("strownership","Sole Proprietor");
					}
					else if(strOwnership.equalsIgnoreCase("Jo"))//Joint Venture
					{
						strOwnership="011";
						hshRecord.put("strownership","Joint Venture");
					}
					else if(strOwnership.equalsIgnoreCase("sub"))//Wholly owned subsidiary
					{
						strOwnership="011";
						hshRecord.put("strownership","Wholly owned subsidiary");
					}
					else if(strOwnership.equalsIgnoreCase("TR"))//Trusts
					{
						strOwnership="004";
						hshRecord.put("strownership","Trusts");
					}
					else if(strOwnership.equalsIgnoreCase("AC"))//Association
					{
						strOwnership="003";
						hshRecord.put("strownership","Association");
					}
					else if(strOwnership.equalsIgnoreCase("nbfc"))//NBFC
					{
						strOwnership="999";
						hshRecord.put("strownership","NBFC");
					}
					else if(strOwnership.equalsIgnoreCase("HUF"))//HUF
					{
						strOwnership="008";
						hshRecord.put("strownership","H.U.F");
					}
					else if(strOwnership.equalsIgnoreCase("OO"))//Others
					{
						strOwnership="999";
						hshRecord.put("strownership","Others");
					}
					
					strQuery = SQLParser.getSqlQuery("sel_constitutionexposure^"+strBorrowerType+"^"+strOwnership+"^"+strPublictype);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("maxlimit",""+(Strproposalvaluesin.equalsIgnoreCase("C")?rs.getDouble("exp_maxlimit"):(rs.getDouble("exp_maxlimit")*100)));
					}
					strQuery = SQLParser.getSqlQuery("compropform11^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("companybackground",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
					}
					
					strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					StringBuffer sbfsignatories=null;
					StringBuffer sbfgridcomments=null;
					if(rs.next())
					{
						sbfsignatories = new StringBuffer(correctNull(rs.getString("exec_signatures")));
						sbfgridcomments= new StringBuffer(correctNull(rs.getString("exec_gridcomments")));
						hshRecord.put("exec_mcmresolution",correctNull(rs.getString("exec_mcmresolution")));
						hshRecord.put("exec_delegated",correctNull(rs.getString("exec_delegated")));
					}
					if(sbfsignatories!=null)
					{
						for (int i = 0;i < sbfsignatories.length(); i++) {
							if (sbfsignatories.charAt(i) == '\n') {
								sbfsignatories.replace(i, i + 1, "<br>");
							}
							if (sbfsignatories.charAt(i) == ' ') {
								sbfsignatories.replace(i, i + 1, "&nbsp;");
							}
						}
						hshRecord.put("exec_signatures",sbfsignatories.toString());
					}
					if(sbfgridcomments!=null)
					{
						for (int i = 0,j=0;i < sbfgridcomments.length(); i++) 
						{
							if (sbfgridcomments.charAt(i) == '\n') {
								sbfgridcomments.replace(i, i + 1, "<br>");
								j++;
							}
							if (j>1 && sbfgridcomments.charAt(i) == ' ') {
								sbfgridcomments.replace(i, i + 1, "&nbsp;");
							}
						}
						hshRecord.put("exec_gridcomments",sbfgridcomments.toString());
					}

/********************************************************************************************************************************************
 * 
 * Financials  
 * 
 **********************************************************************************************************************************/					
				
				
				strQuery=SQLParser.getSqlQuery("sel_execfin^"+appno+"^"+"0^FI");
				arrRow=new ArrayList();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();			
					arrCol.add(correctNull(rs.getString("fin_year1")));
					arrCol.add(correctNull(rs.getString("fin_year2")));
					arrCol.add(correctNull(rs.getString("fin_year3")));
					arrCol.add(correctNull(rs.getString("fin_year4")));
					arrCol.add(correctNull(rs.getString("fin_rowdesc")));
					arrRow.add(arrCol);	
				}
				hshRecord.put("arrValFin",arrRow);
				
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+appno+"^"+"FI"+"^"+"0");
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
				}
/***************************************************************************************************************************
 * 
 * WC NON FUNDED FACILITY DETAILS WITH SECURITY
 * 
 ***************************************************************************************************************************/
							
							OurBank_WC_Funded = new ArrayList();
							OurBank_WC_NonFunded = new ArrayList();
							OurBank_TL = new ArrayList();
							ArrayList arrSecRemarkscol_stl=new ArrayList();
							ArrayList arrSecRemarksrow_stl=new ArrayList();
							
							
							if (rs != null) 
							{
								rs.close();
							}

							strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + appno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next())
							{
								int d2b = 0;
								WC_NonFunded = new ArrayList();
								String strFacSno = correctNull((String)rs.getString("facility_sno"));
								WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
								WC_NonFunded.add(correctNull(rs.getString("facility_existing"))); 		//1
								WC_NonFunded.add(correctNull(rs.getString("facility_proposed"))); 		//2
								WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
								WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
								WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
								WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
								WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
								WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

								String strfacheadid = correctNull(rs.getString("facility_headid"));
								
								
								arrSubFac = new ArrayList();
								arrSubFac = getSubFacilitiesData(appno,strFacSno,"stl_NFD");				//9
								WC_NonFunded.add(arrSubFac);
								
								WC_NonFunded.add(correctNull(rs.getString("bplr")));					//10
								WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
								WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
								WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
								WC_NonFunded.add(strfacheadid);											//14
									
								
								strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + appno);
								rs1 = DBUtils.executeQuery(strQuery);
								ArrayList arrSecurities=new ArrayList();
								int j=0;
								while (rs1.next()) 
								{
									arrCol=new ArrayList();
									arrSecRemarkscol_stl=new ArrayList();
									arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
									arrCol.add(correctNull(rs1.getString("sec_margin"))); 
									arrSecRemarkscol_stl.add(correctNull(rs1.getString("sec_remarks")));
									arrSecRemarksrow_stl.add(arrSecRemarkscol_stl);
									arrSecurities.add(arrCol);
									j++;
							   }
								 WC_NonFunded.add(arrSecurities);
								 WC_NonFunded.add(""+j);
								 WC_NonFunded.add(arrSecRemarksrow_stl);
								OurBank_WC_NonFunded.add(WC_NonFunded);
								hshRecord.put("detailsasondate_stl", correctNull(rs.getString("facility_osason")));
							}

							hshRecord.put("OurBank_WC_NonFunded_STL", OurBank_WC_NonFunded);
							
							
							
				/***************************************************************************************************************************
				 * 
				 * WC FUNDED FACILITY DETAILS WITH SECURITY
				 * 
				 **************************************************************************************************************************/
							
							if (rs != null) 
							{
								rs.close();
							}
							 
							strQuery = SQLParser.getSqlQuery("com_wc_funded^" + appno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								int d2 = 0;
								WC_Funded = new ArrayList();
								WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
								WC_Funded.add(correctNull(rs.getString("facility_existing")));
								WC_Funded.add(correctNull(rs.getString("facility_proposed")));
								WC_Funded.add(correctNull(rs.getString("facility_margin")));
								WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
								WC_Funded.add(correctNull(rs.getString("facility_dp")));
								WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
								WC_Funded.add(correctNull(rs.getString("security_value")));
								WC_Funded.add(correctNull(rs.getString("facility_desc")));

								//
								String strfacheadid = correctNull(rs.getString("facility_headid"));
								String strfacsubid = correctNull(rs.getString("facility_id"));
								String strFacSno = correctNull((String)rs.getString("facility_sno"));
								arrSubFac = new ArrayList();
								arrSubFac = getSubFacilitiesData(appno,strFacSno,"stl_FD");
								WC_Funded.add(arrSubFac);
								WC_Funded.add(correctNull(rs.getString("bplr")));
								WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
								WC_Funded.add(correctNull(rs.getString("facility_category")));
								WC_Funded.add(correctNull(rs.getString("facility_months")));
								WC_Funded.add(correctNull(rs.getString("facility_headid")));
								

								strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + appno);
								rs1 = DBUtils.executeQuery(strQuery);
								ArrayList arrSecurities=new ArrayList();
								arrSecRemarksrow_stl=new ArrayList();
								int j=0;
								while (rs1.next()) 
								{
									arrCol=new ArrayList();
									arrSecRemarkscol_stl=new ArrayList();
									arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
									arrCol.add(correctNull(rs1.getString("sec_margin")));
									arrSecRemarkscol_stl.add(correctNull(rs1.getString("sec_remarks")));
									arrSecRemarksrow_stl.add(arrSecRemarkscol_stl);
									arrSecurities.add(arrCol);
									j++;
								}
								WC_Funded.add(arrSecurities);
								WC_Funded.add(""+j);
								WC_Funded.add(arrSecRemarksrow_stl);			
								OurBank_WC_Funded.add(WC_Funded);
								hshRecord.put("detailsasondate_stl", correctNull(rs.getString("facility_osason")));
							}

							hshRecord.put("OurBank_WC_Funded_STL", OurBank_WC_Funded);
							
							
				/***************************************************************************************************************************
				 * 
				 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
				 * 
				 **************************************************************************************************************************/

							if (rs != null)
							{
								rs.close();
							}
							 
							strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded^" + appno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								int d3 = 0;
								TL_Funded_NonFunded = new ArrayList();
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));

								String strfacheadid = correctNull(rs.getString("facility_headid"));
								String strfacsubid = correctNull(rs.getString("facility_id"));
								String strFacSno = correctNull((String)rs.getString("facility_sno"));
								
								arrSubFac = new ArrayList();
								
								arrSubFac = getSubFacilitiesData(appno,strFacSno,"stl_TL");
								
								TL_Funded_NonFunded.add(arrSubFac);
								TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
								TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));

								strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  appno);
								rs1 = DBUtils.executeQuery(strQuery);
								ArrayList arrSecurities=new ArrayList();
								arrSecRemarksrow_stl=new ArrayList();
								int j=0;
								while (rs1.next()) 
								{
									arrCol=new ArrayList();
									arrSecRemarkscol_stl=new ArrayList();
									arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
									arrCol.add(correctNull(rs1.getString("sec_margin"))); 
									arrSecRemarkscol_stl.add(correctNull(rs1.getString("sec_remarks")));
									arrSecRemarksrow_stl.add(arrSecRemarkscol_stl);
									arrSecurities.add(arrCol);
									j++;
								}
								TL_Funded_NonFunded.add(arrSecurities);
								TL_Funded_NonFunded.add(""+j);
								TL_Funded_NonFunded.add(arrSecRemarksrow_stl);
								OurBank_TL.add(TL_Funded_NonFunded);
								hshRecord.put("detailsasondate_stl", correctNull(rs.getString("facility_osason")));
							}

							hshRecord.put("OurBank_STL", OurBank_TL);
							//hshRecord.put("arrSecRemarks_stl",arrSecRemarksrow_stl);
/***********************************************************************************************************************************************
 * 
 * 				6.2 PERSONAL/CORPORATE GUARANTEE : MEANS
 * 
 * **********************************************************************************************************************************************/
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selcreditreport2^"+appno+"^"+"1");
			if (rs.next())
			{
				hshRecord.put("means",correctNull(rs.getString("CR_Total_MEANS")));
				hshRecord.put("meansason",correctNull(rs.getString("cr_meansason")));
			}
			else 
			{
				hshValues.put("means","0.00");
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
				if (rs1 != null)
				{
					rs1.close();
				}
				if (rs2 != null)
				{
					rs2.close();
				}
				if (rs5 != null)
				{
					rs5.close();
				}
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap getFinIndicatorComment(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrRow=new ArrayList();
		String str_finind = Helper.correctNull((String)hshValues.get("sel_comment"));
		String appno = Helper.correctNull((String)hshValues.get("appno"));
		String str_divID = Helper.correctNull((String)hshValues.get("sel_divID"));
		String strcma="";
		String strQuery="";
	try{
		if(	rs!=null)
			rs.close();
	
		rs = DBUtils.executeLAPSQuery("comfintrendsel1^"+appno);
	
	
			 
		if(rs.next())
		{  
			strcma=correctNull(rs.getString("demo_finstandard"));
		}
		if(rs!=null)
			rs.close();
		if(str_finind.equals(""))
			str_finind="0";
		if(!str_finind.equals("Gen"))
		{
		rs = DBUtils.executeLAPSQuery("sel_note_com_finmasterid^"+strcma+"^"+str_finind);
		if(rs.next())
		{ if(!Helper.correctNull(rs.getString("fin_indicator")).equals(""))
			{
				/*ComBobAssessmentBean obj  =  new ComBobAssessmentBean();
				hshValues.put("pageval",rs.getString("fin_indicator"));
				hshRecord=obj.getData(hshValues);*/
			
			//strQuery=SQLParser.getSqlQuery("selindicatorrowitem^"+appno+"^0"+"^"+str_finind);
			strQuery=SQLParser.getSqlQuery("selexecfinancials^"+appno+"^0"+"^"+str_finind);
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrCol=new ArrayList();
				arrCol.add("");//0
				arrCol.add(correctNull(rs.getString("fin_rowdesc")));//1
				arrCol.add(correctNull(rs.getString("fin_rowtype")));//2
				arrCol.add(correctNull(rs.getString("fin_year1")));//3
				arrCol.add(correctNull(rs.getString("fin_year2")));//4
				arrCol.add(correctNull(rs.getString("fin_year3")));//5
				arrCol.add(correctNull(rs.getString("fin_year4")));//6
				arrCol.add(correctNull(rs.getString("fin_year5")));//7
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("indicatorflag","yes");
			}
		}
		}
		if(rs != null)
			rs.close();
		if(str_finind.equals("Gen"))
		{
			strQuery=SQLParser.getSqlQuery("executive_finnotes_sel^"+appno+"^FI"+"^0");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("finindicator_comments",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
			}
		}
		else
		{
			strQuery=SQLParser.getSqlQuery("sel_finindicatorcomment^"+appno+"^0"+"^"+str_finind);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("finindicator_comments",correctNull(Helper.CLOBToString(rs.getClob("com_finindicator_comments"))));
			}
		}
		
		hshRecord.put("finindactor",str_finind);
		hshRecord.put("sel_divID",str_divID);
		
			
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in getFinIndicatorComment " + ce.toString());
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
	
	public void updateFinIndicatorComment(HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=null;
		String strQuery="";
		ResultSet rs=null;
		int intUpdatesize=0;
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_finindicator"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strcommentid=correctNull((String)hshValues.get("sel_comment"));
		
		try
		{
			if(!strcommentid.equals("")&& !strcommentid.equals("0"))
			{
				if(!strcommentid.equals("Gen"))
				{
					if(strAction.equalsIgnoreCase("insert"))
					{
						hshQuery = new HashMap();	
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","del_finindicatorcomment");
						arrValues.add(strAppno);
						arrValues.add("0");
						arrValues.add(strcommentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
					
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","ins_finindicatorcomment");
						arrValues.add(strAppno);
						arrValues.add(strcommentid);
						arrValues.add(strComments);
						arrValues.add("0");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					}
					if(strAction.equalsIgnoreCase("delete"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","del_finindicatorcomment");
						arrValues.add(strAppno);
						arrValues.add("0");
						arrValues.add(strcommentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					}
				}
				else
				{
					if(strAction.equalsIgnoreCase("insert"))
					{
						strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"
								+ strAppno +"^"+"^FI"+"^0");
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strAppno);
							arrValues.add("FI");
							arrValues.add("0");
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "executive_finnotes_del");
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strAppno);
							arrValues.add("FI");
							arrValues.add("0");
							arrValues.add(strComments);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "executive_finnotes_ins");
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						} else {
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							arrValues.add(strAppno);
							arrValues.add("FI");
							arrValues.add("0");
							arrValues.add(strComments);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "executive_finnotes_ins");
							intUpdatesize = intUpdatesize + 1;
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
					}
					if (strAction.equalsIgnoreCase("delete")) {
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(strAppno);
						arrValues.add("FI");
						arrValues.add("0");
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "executive_finnotes_del");
						intUpdatesize = intUpdatesize + 1;
						hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

					}
					
				}
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateFinIndicatorComment" + e.getMessage());
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
	public HashMap updateLoad(HashMap hshValues)
	{
		
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		int intupdatesize=0;
		String strcma="";
		ResultSet rs = null;
		String str_finind="";
		String strindicator="";
		String strQuery="";
		try{
			 str_finind = Helper.correctNull((String)hshValues.get("sel_comment"));
			 strAppno = Helper.correctNull((String)hshValues.get("appno"));
			if(	rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("comfintrendsel1^"+strAppno);
				 
			if(rs.next())
			{  
				strcma=correctNull(rs.getString("demo_finstandard"));
			}
			if(rs!=null)
				rs.close();
			
			ComBobAssessmentBean obj  =  new ComBobAssessmentBean();
			if(rs!=null)
				rs.close();
			if(str_finind.equals(""))
				str_finind="0";
			rs = DBUtils.executeLAPSQuery("sel_note_com_finmasterid^"+strcma+"^"+str_finind);
			if(rs.next())
			{
				strindicator = Helper.correctNull(rs.getString("fin_indicator"));
				hshValues.put("indicatorflag","yes");
			}
			hshValues.put("pageval",strindicator);
			hshRecord=obj.getData(hshValues);
			arrRow=(ArrayList)hshRecord.get("arrRow");
			hshValues.put("arrRow",arrRow);
			if(arrRow!=null && arrRow.size()>0)
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intupdatesize++;
				//hshQuery.put("strQueryId","delindicatorrowitem");
				hshQuery.put("strQueryId","delexecfinancials");
				arrValues.add(strAppno);
				arrValues.add("0");
				arrValues.add(str_finind);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intupdatesize,hshQuery);
				
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);
						
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intupdatesize++;
				//	hshQuery.put("strQueryId","insindicatorrowitem");
					hshQuery.put("strQueryId","insexecfinancials");
					arrValues.add(strAppno);
					arrValues.add("0");
					arrValues.add(""+(i+1));
					arrValues.add(arrCol.get(0));
					arrValues.add(arrCol.get(1));
					arrValues.add(arrCol.get(2));
					arrValues.add(arrCol.get(3));
					arrValues.add(arrCol.get(4));
					arrValues.add(arrCol.get(5));
					arrValues.add(arrCol.get(6));
					arrValues.add(arrCol.get(7));
					arrValues.add(str_finind);
					arrValues.add("FICOM");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intupdatesize,hshQuery);
				}
				hshQueryValues.put("size",""+intupdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_finindicatorcomment^"+strAppno+"^0"+"^"+str_finind);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshValues.put("finindicator_comments",correctNull(Helper.CLOBToString(rs.getClob("com_finindicator_comments"))));
			}
			hshValues.put("finindactor",str_finind);
			
	
		}catch(Exception Ex)
		{
			throw new EJBException("Error in updateLoad :: "+ Ex.toString());
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
		return hshValues;
	}
	
	private ArrayList getRecommendations(HashMap hshValues) {
		ArrayList arrResult=null;
		String chkCategory="",chkCategory1="";
		ArrayList arrSubFac=null;
		ArrayList arrSubFacRecords=null;
		
		try
		{
			String strProposalvalue = Helper.correctNull((String) hshValues.get("proposalvaluesin"));
			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";
			
			arrResult = new ArrayList();
			
			arrResult.add("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td valign=\"top\" width=\"5%\"><b>36.&nbsp;</b></td>");
			arrResult.add("<td valign=\"top\" colspan=\"4\"><b>RECOMMENDATIONS</b></td></tr><tr><td valign=\"top\" width=\"5%\"><b>36.1.&nbsp;</b></td><td valign=\"top\" colspan=\"4\"><b>In view of the above we recommend for the Sanction/Renewal/Modification of the following credit limits in favour of M/S <u>"+Helper.correctNull((String) hshValues.get("comapp_companyname"))+"</u></b></td></tr>");
			arrResult.add("<tr><td valign=\"top\" align=\"right\" colspan=\"5\"> <b>("+ApplicationParams.getCurrency() +"In "+ strProposalvalue+")</b></td></tr>");
			arrResult.add("<tr><td valign=\"top\" rowspan=\"4\" width=\"5%\">&nbsp;</td><td valign=\"top\" colspan=\"4\"><div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\"><tr class=\"tblhead\">");
			arrResult.add("<td rowspan=\"2\" width=\"27%\"><div align=\"center\">Nature of Limit</div></td><td colspan=\"2\"><div align=\"center\">Amount</div></td>");
			arrResult.add("<td rowspan=\"2\" width=\"8%\"><div align=\"center\">Margin (%)</div></td><td rowspan=\"2\" width=\"8%\"><div align=\"center\">Int./ Comm.</div></td>");
			arrResult.add("<td rowspan=\"2\" width=\"31%\"><div align=\"center\">Security</div></td></tr><tr class=\"tblhead\"><td width=\"13%\" align=\"center\"> Existing</td>");
			arrResult.add("<td width=\"13%\" align=\"center\"> Proposed</td></tr><tr><td colspan=\"6\"><b>A] NON-FUND BASED LIMITS</b></td></tr>");

			ArrayList OurBank_WC_NonFunded = new ArrayList();
			 ArrayList WC_NonFunded = new ArrayList();
			 int arrWC_NonFunded_Size = 0;
			 OurBank_WC_NonFunded = (ArrayList) hshValues.get("OurBank_WC_NonFunded");
			if (OurBank_WC_NonFunded != null) {
				arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
			}
			for (int i = 0; i < arrWC_NonFunded_Size; i++) {
				WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);

				chkCategory = Helper.correctNull((String) WC_NonFunded.get(12));
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) WC_NonFunded.get(13))+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
					int introwspan = Integer.parseInt(Helper.correctInt((String) WC_NonFunded.get(16)));

					arrResult.add("<tr><td width=\"27%\" align=\"left\" valign=\"top\" rowspan="+introwspan+">&nbsp;<b>"+Helper.correctNull((String) WC_NonFunded.get(0))+chkCategory1+"</b></td>");
					arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1))))+"</td>");
					arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2))))+"</td>");
			ArrayList arrSecurities = new ArrayList();
			arrSecurities = (ArrayList) WC_NonFunded.get(15);
			if (arrSecurities != null && arrSecurities.size() > 0) {
				for (int j = 0; j < arrSecurities.size(); j++) {
					ArrayList arrCol = new ArrayList();
					String strBorder = "";
					arrCol = (ArrayList) arrSecurities.get(j);
					if ((introwspan - 1) == j && j != 0) {
						strBorder = "\"border-top-width:0\";";
					} else if (j == 0) {
						strBorder = "\"border-bottom-width:0\";";
					} else {
						strBorder = "\"border-bottom-width:0;border-top-width:0\"";
					}
					if (j == 0) {
						arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
						arrResult.add("<td width= \"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) WC_NonFunded.get(4))+"&nbsp;</td>");
						arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
					} else {
						arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
						arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\"  style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
					}
						}
					} else {
						arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) WC_NonFunded.get(3))+"&nbsp;</td>");
						arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) WC_NonFunded.get(4))+"&nbsp; </td>");
						arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\">&nbsp;</td>");
					}
			arrResult.add("</tr>");
			arrSubFac = new ArrayList();
					arrSubFac = (ArrayList) WC_NonFunded.get(9);
					int subFacSize = arrSubFac.size();
					if (arrSubFac != null && subFacSize > 0) {
						for (int j = 0; j < subFacSize; j++) {
							arrSubFacRecords = new ArrayList();
							arrSubFacRecords = (ArrayList) arrSubFac.get(j);
							chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
							if (chkCategory.equals("A")) {
								chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
							} else {
								chkCategory1 = "";
							}
							int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));
				                       if (j == 0) {
				                    	   arrResult.add("<tr><td colspan=\"6\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>");
				                       }
				                    	   arrResult.add("</tr><tr><td align=\"left\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(0)) +chkCategory1+"&nbsp;</td>");
				                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
				                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
						       ArrayList arrsubSecurities = new ArrayList();
						       arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
							if (arrSecurities != null && arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								ArrayList arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) {
									strBorder = "\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "\"border-bottom-width:0\";";
								} else {
									strBorder = "\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {
									arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
											arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp;</td>");
											arrResult.add(" <td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
						               	} else {
						               		arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
						               		arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");					                }
							}
							} else {
								arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) arrSubFacRecords.get(3))+"&nbsp;</td>");
										arrResult.add("<td width=\"8%\" valign=\"top\">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp; </td>");
										arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\">&nbsp;</td>");
						        }
							arrResult.add("</tr>");
						        }
						}
								//End of 'Sub-Facilities' details               
					}
		
					arrResult.add("<tr><td width=\"27%\" align=\"left\"><b> Sub- Total [A]</b></td><td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_existing"))))+"</td>");
					arrResult.add("<td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_proposed"))))+"</td><td width=\"8%\">&nbsp;</td><td width=\"8%\">&nbsp;</td><td width=\"31%\">&nbsp;</td></tr>");
					
					arrResult.add("<tr><td colspan=\"6\"><b>B] FUND BASED LIMITS</b></td></tr>");

					ArrayList OurBank_WC_Funded = new ArrayList();
					 ArrayList WC_Funded = new ArrayList();
					 int arrWC_Funded_Size = 0;
					 OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");
					if (OurBank_WC_Funded != null) {
						arrWC_Funded_Size = OurBank_WC_Funded.size();
					}
					for (int i = 0; i < arrWC_Funded_Size; i++) {
						WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);

						chkCategory = Helper.correctNull((String) WC_Funded.get(12));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) WC_Funded.get(13))+ " Month ) ";
						} else {
							chkCategory1 = "";
						}
							int introwspan = Integer.parseInt(Helper.correctInt((String) WC_Funded.get(16)));

							arrResult.add("<tr><td width=\"27%\" align=\"left\" valign=\"top\" rowspan="+introwspan+">&nbsp;<b>"+Helper.correctNull((String) WC_Funded.get(0))+chkCategory1+"</b></td>");
							arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(1))))+"</td>");
							arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2))))+"</td>");
					ArrayList arrSecurities = new ArrayList();
					arrSecurities = (ArrayList) WC_Funded.get(15);
					if (arrSecurities != null && arrSecurities.size() > 0) {
						for (int j = 0; j < arrSecurities.size(); j++) {
							ArrayList arrCol = new ArrayList();
							String strBorder = "";
							arrCol = (ArrayList) arrSecurities.get(j);
							if ((introwspan - 1) == j && j != 0) {
								strBorder = "\"border-top-width:0\";";
							} else if (j == 0) {
								strBorder = "\"border-bottom-width:0\";";
							} else {
								strBorder = "\"border-bottom-width:0;border-top-width:0\"";
							}
							if (j == 0) {
								arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
								arrResult.add("<td width= \"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) WC_Funded.get(4))+"&nbsp;</td>");
								arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
							} else {
								arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
								arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\"  style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
							}
								}
							} else {
								arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) WC_Funded.get(3))+"&nbsp;</td>");
								arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) WC_Funded.get(4))+"&nbsp; </td>");
								arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\">&nbsp;</td>");
							}
					arrResult.add("</tr>");
					arrSubFac = new ArrayList();
							arrSubFac = (ArrayList) WC_Funded.get(9);
							int subFacSize = arrSubFac.size();
							if (arrSubFac != null && subFacSize > 0) {
								for (int j = 0; j < subFacSize; j++) {
									arrSubFacRecords = new ArrayList();
									arrSubFacRecords = (ArrayList) arrSubFac.get(j);
									chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
									if (chkCategory.equals("A")) {
										chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
									} else {
										chkCategory1 = "";
									}
									int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));
						                       if (j == 0) {
						                    	   arrResult.add("<tr><td colspan=\"6\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>");
						                       }
						                    	   arrResult.add("</tr><tr><td align=\"left\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(0)) +chkCategory1+"&nbsp;</td>");
						                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
						                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
								       ArrayList arrsubSecurities = new ArrayList();
								       arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
									if (arrSecurities != null && arrsubSecurities.size() > 0) {
									for (int k = 0; k < arrsubSecurities.size(); k++) {
										ArrayList arrCol = new ArrayList();
										String strBorder = "";
										arrCol = (ArrayList) arrsubSecurities.get(k);
										if ((intsubrowspan - 1) == k) {
											strBorder = "\"border-top-width:0\";";
										} else if (k == 0) {
											strBorder = "\"border-bottom-width:0\";";
										} else {
											strBorder = "\"border-bottom-width:0;border-top-width:0\"";
										}
										if (k == 0) {
													arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
													arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp;</td>");
													arrResult.add(" <td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
								               	} else {
								               		arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
								               		arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");					                }
									}
									} else {
										arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) arrSubFacRecords.get(3))+"&nbsp;</td>");
												arrResult.add("<td width=\"8%\" valign=\"top\">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp; </td>");
												arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\">&nbsp;</td>");
								        }
									arrResult.add("</tr>");
								        }
								}
										//End of 'Sub-Facilities' details               
							}
					
							arrResult.add("<tr><td width=\"27%\" align=\"left\"><b> Sub- Total [B]</b></td><td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_existing"))))+"</td>");
							arrResult.add("<td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_proposed"))))+"</td><td width=\"8%\">&nbsp;</td><td width=\"8%\">&nbsp;</td><td width=\"31%\">&nbsp;</td></tr>");
							arrResult.add("<tr><td colspan=\"6\"><b>C] TERM LOAN / DPGL</b></td></tr>");

							ArrayList OurBank_TL = new ArrayList();
							 ArrayList TL_Funded_NonFunded = new ArrayList();
							 int arrTL_Funded_NonFunded_Size = 0;
							 OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");
							if (OurBank_TL != null) {
								arrTL_Funded_NonFunded_Size = OurBank_TL.size();
							}
							for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
								TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);

								chkCategory = Helper.correctNull((String) TL_Funded_NonFunded.get(12));
								if (chkCategory.equals("A")) {
									chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) TL_Funded_NonFunded.get(13))+ " Month ) ";
								} else {
									chkCategory1 = "";
								}
									int introwspan = Integer.parseInt(Helper.correctInt((String) TL_Funded_NonFunded.get(16)));

									arrResult.add("<tr><td width=\"27%\" align=\"left\" valign=\"top\" rowspan="+introwspan+">&nbsp;<b>"+Helper.correctNull((String) TL_Funded_NonFunded.get(0))+chkCategory1+"</b></td>");
									arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(1))))+"</td>");
									arrResult.add("<td width=\"13%\" align=\"right\" valign=\"top\" rowspan="+introwspan+">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(2))))+"</td>");
							ArrayList arrSecurities = new ArrayList();
							arrSecurities = (ArrayList) TL_Funded_NonFunded.get(15);
							if (arrSecurities != null && arrSecurities.size() > 0) {
								for (int j = 0; j < arrSecurities.size(); j++) {
									ArrayList arrCol = new ArrayList();
									String strBorder = "";
									arrCol = (ArrayList) arrSecurities.get(j);
									if ((introwspan - 1) == j && j != 0) {
										strBorder = "\"border-top-width:0\";";
									} else if ((introwspan - 1) == j && j == 0
											&& arrSecurities.size() - 1 == j) {
										//strBorder="\"border-top-width:0\";";
									} else if (j == 0) {
										strBorder = "\"border-bottom-width:0\";";
									} else {
										strBorder = "\"border-bottom-width:0;border-top-width:0\"";
									}
									if (j == 0) {
										arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
										arrResult.add("<td width= \"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) TL_Funded_NonFunded.get(4))+"&nbsp;</td>");
										arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
									} else {
										arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
										arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\"  style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
									}
										}
									} else {
										arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) TL_Funded_NonFunded.get(3))+"&nbsp;</td>");
										arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+introwspan+">"+Helper.correctNull((String) TL_Funded_NonFunded.get(4))+"&nbsp; </td>");
										arrResult.add("<td width=\"31%\" valign=\"top\" align=\"left\">&nbsp;</td>");
									}
							arrResult.add("</tr>");
							arrSubFac = new ArrayList();
									arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
									int subFacSize = arrSubFac.size();
									if (arrSubFac != null && subFacSize > 0) {
										for (int j = 0; j < subFacSize; j++) {
											arrSubFacRecords = new ArrayList();
											arrSubFacRecords = (ArrayList) arrSubFac.get(j);
											chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
											if (chkCategory.equals("A")) {
												chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
											} else {
												chkCategory1 = "";
											}
											int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));
								                       if (j == 0) {
								                    	   arrResult.add("<tr><td colspan=\"6\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>");
								                       }
								                    	   arrResult.add("</tr><tr><td align=\"left\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(0)) +chkCategory1+"&nbsp;</td>");
								                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
								                    	   arrResult.add(" <td align=\"right\" valign=\"top\" rowspan="+intsubrowspan+">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
										       ArrayList arrsubSecurities = new ArrayList();
										       arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
											if (arrSecurities != null && arrsubSecurities.size() > 0) {
											for (int k = 0; k < arrsubSecurities.size(); k++) {
												ArrayList arrCol = new ArrayList();
												String strBorder = "";
												arrCol = (ArrayList) arrsubSecurities.get(k);
												if ((intsubrowspan - 1) == k) {
													strBorder = "\"border-top-width:0\";";
												} else if (k == 0) {
													strBorder = "\"border-bottom-width:0\";";
												} else {
													strBorder = "\"border-bottom-width:0;border-top-width:0\"";
												} if (k == 0) {
															arrResult.add("<td width=\"8%\" align=\"right\" valign=\"top\"  style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
															arrResult.add("<td width=\"8%\" valign=\"top\" rowspan="+intsubrowspan+">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp;</td>");
															arrResult.add(" <td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");
										               	} else {
										               		arrResult.add("</tr><tr><td width=\"8%\" align=\"right\" valign=\"top\" style="+strBorder+">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))+"&nbsp;</td>");
										               		arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\" style="+strBorder+">"+Helper.correctNull((String) arrCol.get(0))+"&nbsp;</td>");					                }
											}
											} else {
												arrResult.add("<td align=\"right\" valign=\"top\">"+Helper.correctDouble((String) arrSubFacRecords.get(3))+"&nbsp;</td>");
														arrResult.add("<td width=\"8%\" valign=\"top\">"+Helper.correctNull((String) arrSubFacRecords.get(4))+"&nbsp; </td>");
														arrResult.add("<td width=\"31%\" align=\"left\" valign=\"top\">&nbsp;</td>");
										        }
											arrResult.add("</tr>");
										        }
										}
												//End of 'Sub-Facilities' details               
									}
							
									arrResult.add("<tr><td width=\"27%\" align=\"left\"><b> Sub- Total [C]</b></td><td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("tl_total_existing"))))+"</td>");
									arrResult.add("<td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("tl_total_proposed"))))+"</td><td width=\"8%\">&nbsp;</td><td width=\"8%\">&nbsp;</td><td width=\"31%\">&nbsp;</td></tr>");		
									arrResult.add("<tr><td width=\"27%\"><div align=\"center\"><b>TOTAL [A+B+C]</b></div></td><td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("total_existing"))))+"</td>");
									arrResult.add("<td width=\"13%\" align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("total_proposed"))))+"</td><td width=\"8%\">&nbsp;</td><td width=\"8%\">&nbsp;</td><td width=\"31%\">&nbsp;</td></tr></table></div>");
									arrResult.add("</td></tr></table>");
									ArrayList arrRow = new ArrayList();
									ArrayList arrData = new ArrayList();
							arrRow = (ArrayList) hshValues.get("arrSecRemarks");
							if (arrRow != null && arrRow.size() != 0) {

								
								arrResult.add("<table width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\" align=\"center\"><tr><td valign=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");				      
				      for (int i = 0; i < arrRow.size(); i++) {
									arrData = (ArrayList) arrRow.get(i);
									if (!Helper.formatTextAreaData((String) arrData.get(0))
											.equalsIgnoreCase("")) {

									
										arrResult.add("<tr><td>&nbsp;</td></tr><tr><td valign=\"top\" class=\"just\">"+Helper.formatTextAreaData((String) arrData.get(0))+"&nbsp;</td></tr>");
				        
				      }
								}

							
				      arrResult.add("</table></td></tr></table>");
						}

								
					
		}
		catch (Exception cf) 
		{
			throw new EJBException("Error closing the connection "+ cf.getMessage());
		}
		return arrResult;
	}
	



	public void updateGridObservationData(HashMap hshValues)  {
		HashMap hshQueryValues = null;
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		int intupdateSize=0;
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));

		if (appno.equalsIgnoreCase(null) || appno.equals("")) {
			appno = correctNull((String) hshValues.get("hidappno"));
		}
		try {
			if (strAction.trim().equals("update")) {
				
				hshQueryValues = new HashMap();
				intupdateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_gridobservation_delete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intupdateSize));
			
				intupdateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_gridobservation_insert");
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("sel_level")));
				arrValues.add(correctNull((String) hshValues.get("txt_observ")));
	        	arrValues.add(correctNull((String) hshValues.get("txt_replies")));
	        	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intupdateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (strAction.trim().equals("delete")) {
				intupdateSize++;
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_gridobservation_delete");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intupdateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}
		catch (Exception ce) 
		{
			log.error("Exception in updateGridObservationData :: "+ ce.toString());
		}

	}
	public HashMap getGridObservationData(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";

		try {
			appno = correctNull((String) hshValues.get("appno"));
			if (appno.equalsIgnoreCase("")) {
				appno = correctNull((String) hshValues.get("hidappno"));
			}

			strQuery = SQLParser.getSqlQuery("com_gridobservation_select^" + appno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cg_observation", correctNull(Helper.CLOBToString(rs.getClob("cg_observation"))));
				hshRecord.put("cg_replies", correctNull(Helper.CLOBToString(rs.getClob("cg_replies"))));
				hshRecord.put("cg_type",correctNull(rs.getString("cg_type")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selBranchCityName^" + appno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("orgname", correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1", correctNull(rs.getString("org_add1")));
				hshRecord.put("orgadd2", correctNull(rs.getString("org_add2")));
				hshRecord.put("orgcity", correctNull(rs.getString("org_city")));
				hshRecord.put("orgstate",
						correctNull(rs.getString("org_state")));
				hshRecord.put("orgzip", correctNull(rs.getString("org_zip")));
			}
			if(rs!=null)
				rs.close();
			
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getGridObservationData " + ce.toString());
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


	private ArrayList getExposure (HashMap hshValues) {
		ArrayList arrResult=null;
		String chkCategory="";//chkCategory1="";
		ArrayList arrSubFac=null;
		ArrayList arrSubFacRecords=null;
		try
		{
			String strProposalvalue = Helper.correctNull((String) hshValues.get("proposalvaluesin"));
			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";
			arrResult = new ArrayList();
			
			arrResult.add("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td valign=\"top\" width=\"5%\"><b>24.&nbsp;</b></td>");
			arrResult.add("<td valign=\"top\" colspan=\"4\"><b>EXPOSURE DETAILS FROM OUR BANK</b></td></tr>");
			arrResult.add("<tr><td valign=\"top\" align=\"right\" colspan=\"5\"> <b>("+ApplicationParams.getCurrency() +"In "+ strProposalvalue+")</b></td></tr>");
			arrResult.add("<tr><td valign=\"top\" rowspan=\"4\" width=\"5%\">&nbsp;</td><td valign=\"top\" colspan=\"4\"><div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\"><tr class=\"tblhead\">");
			//arrResult.add("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\" align=\"center\"><tr><td valign=\"top\">");
			/*arrResult.add("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td valign=\"top\" width=\"3%\"><b>24.&nbsp;</b></td>");
			arrResult.add("<td valign=\"top\" colspan=\"4\"><b> EXPOSURE DETAILS FROM OUR BANK</b></td></tr><tr>");
			arrResult.add("<td  colspan=\"4\" align=\"right\" valign=\"top\"><b>(Rs In "+strProposalvalue+")</b>&nbsp;&nbsp;"); 
			arrResult.add("<br /><div id=\"top\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\"><tr class=\"tblhead\">"); 
			*/arrResult.add("<td width=\"22%\" align=\"center\"><b> Nature of Facility</b></td><td width=\"12%\" align=\"center\"><b> Limits Existing</b></td>");
			arrResult.add("<td width=\"11%\" align=\"center\"><b> Limits Recom ended</b></td><td width=\"8%\" align=\"center\"><b> D.P.</b></td>");
			arrResult.add("<td width=\"10%\" align=\"center\"><b> O/S  as On&nbsp;"+Helper.correctNull((String) hshValues.get("detailsasondate"))+"</b></td>");
			arrResult.add("<td width=\"12%\" align=\"center\"><b> Value of Securities</b></td><td width=\"19%\" align=\"center\"><b> Irregularities, if any</b></td></tr>");
			arrResult.add("<tr><td colspan=\"7\" align=\"left\"><b>A]FUND BASED LIMITS</b></td></tr>");
			
						ArrayList OurBank_WC_Funded = new ArrayList();
						ArrayList WC_Funded = new ArrayList();

						int arrWC_Funded_Size = 0;

						OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");

						if (OurBank_WC_Funded != null) {
							arrWC_Funded_Size = OurBank_WC_Funded.size();
						}

						for (int i = 0; i < arrWC_Funded_Size; i++) {
							WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);

							if (Helper.correctNull((String) WC_Funded.get(12))
									.equalsIgnoreCase("A"))
								chkCategory = "<br> Adhoc Limit for "
										+ Helper.correctNull((String) WC_Funded.get(13))
										+ " Month";
							else
								chkCategory = "";

							
							arrResult.add("<tr><td align=\"left\">&nbsp;"+Helper.correctNull((String) WC_Funded.get(0)) +chkCategory+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(1))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(5))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(6))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(7))))+"</td>");
							arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) WC_Funded.get(8))+"</td></tr>");
			                //For the Sub-limits, under each one
							arrSubFac = new ArrayList();
							arrSubFac = (ArrayList) WC_Funded.get(9);
							int subFacSize = arrSubFac.size();
							if (arrSubFac != null && subFacSize > 0) {
								for (int j = 0; j < subFacSize; j++) {
									arrSubFacRecords = new ArrayList();
									arrSubFacRecords = (ArrayList) arrSubFac.get(j);

									if (Helper.correctNull(
											(String) arrSubFacRecords.get(11))
											.equalsIgnoreCase("A"))
										chkCategory = "<br> Adhoc Limit for "
												+ Helper
														.correctNull((String) arrSubFacRecords
																.get(12)) + " Month";
									else
										chkCategory = "";

									
			                if (j == 0) {
			                	arrResult.add("<tr><td colspan=\"7\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td></tr>");
			                }
			                arrResult.add("<tr><td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(0)) +chkCategory+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(5))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(6))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))+"</td>");
							arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(8))+"</td></tr>");
			                }
							}
							//End of 'Sub-Facilities' details               
						}

						
						arrResult.add("<tr><td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td></tr>");
			            arrResult.add("<tr><td align=\"right\"><b>Sub-total [A]</b></td>");
			            arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_existing"))))+"</td>");
			            arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_proposed"))))+"</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td></tr>");
			            arrResult.add("<tr><td colspan=\"7\" align=\"left\"><b>B] NONFUND BASED LIMITS</b></td></tr>");
			                ArrayList OurBank_WC_NonFunded = new ArrayList();
						ArrayList WC_NonFunded = new ArrayList();

						int arrWC_NonFunded_Size = 0;

						OurBank_WC_NonFunded = (ArrayList) hshValues
								.get("OurBank_WC_NonFunded");

						if (OurBank_WC_NonFunded != null) {
							arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
						}

						for (int i = 0; i < arrWC_NonFunded_Size; i++) {
							WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);

							if (Helper.correctNull((String) WC_NonFunded.get(12))
									.equalsIgnoreCase("A"))
								chkCategory = "<br> Adhoc Limit for "
										+ Helper.correctNull((String) WC_NonFunded.get(13))
										+ " Month";
							else
								chkCategory = "";

							
							 arrResult.add("<tr><td align=\"left\">&nbsp;"+Helper.correctNull((String) WC_NonFunded.get(0)) +chkCategory+"</td>");
							 arrResult.add("<td align=\"right\">&nbsp;"+Helper.correctNull((String) WC_NonFunded.get(1))+"</td>");
							 arrResult.add("<td align=\"right\">&nbsp;"+Helper.correctNull((String) WC_NonFunded.get(2))+"</td>");
							 arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(5))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(6))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(7))))+"</td>");
							arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) WC_NonFunded.get(8))+"</td></tr>");
			                //For the Sub-limits, under each one
							arrSubFac = new ArrayList();
							arrSubFac = (ArrayList) WC_NonFunded.get(9);
							int subFacSize = arrSubFac.size();
							if (arrSubFac != null && subFacSize > 0) {
								for (int j = 0; j < subFacSize; j++) {
									arrSubFacRecords = new ArrayList();
									arrSubFacRecords = (ArrayList) arrSubFac.get(j);

									if (Helper.correctNull(
											(String) arrSubFacRecords.get(11))
											.equalsIgnoreCase("A"))
										chkCategory = "<br> Adhoc Limit for "
												+ Helper
														.correctNull((String) arrSubFacRecords
																.get(12)) + " Month";
									else
										chkCategory = "";

									
			                if (j == 0) {
			                	arrResult.add("<tr><td colspan=\"7\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td></tr>");
			                }
			                arrResult.add("<tr><td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(0)) +chkCategory+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(5))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(6))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))+"</td>");
							arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(8))+"</td></tr>");
			               }
							}
							//End of 'Sub-Facilities' details               
						}

						
						arrResult.add("<tr><td align=\"right\"><b>Sub-total [B]</b></td>");
						arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_existing"))))+"</td>");
						arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_proposed"))))+"</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td></tr>");
						arrResult.add("<tr><td colspan=\"7\" align=\"left\"><b>C] TERM LOAN</b></td></tr>");
			                ArrayList OurBank_TL = new ArrayList();
						ArrayList TL_Funded_NonFunded = new ArrayList();

						int arrTL_Funded_NonFunded_Size = 0;

						OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");

						if (OurBank_TL != null) {
							arrTL_Funded_NonFunded_Size = OurBank_TL.size();
						}

						for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
							TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);

							if (Helper.correctNull((String) TL_Funded_NonFunded.get(12))
									.equalsIgnoreCase("A"))
								chkCategory = "<br> Adhoc Limit for "
										+ Helper.correctNull((String) TL_Funded_NonFunded
												.get(13)) + " Month";
							else
								chkCategory = "";

							
							arrResult.add("<tr><td  align=\"left\">&nbsp;"+Helper.correctNull((String) TL_Funded_NonFunded.get(0))+ chkCategory+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(1))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(2))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(5))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(6))))+"</td>");
							arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(7))))+"</td>");
							arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) TL_Funded_NonFunded.get(8))+"</td></tr>");
			               //For the Sub-limits, under each one
							arrSubFac = new ArrayList();
							arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
							int subFacSize = arrSubFac.size();
							if (arrSubFac != null && subFacSize > 0) {
								for (int j = 0; j < subFacSize; j++) {
									arrSubFacRecords = new ArrayList();
									arrSubFacRecords = (ArrayList) arrSubFac.get(j);
									if (Helper.correctNull(
											(String) arrSubFacRecords.get(11))
											.equalsIgnoreCase("A"))
										chkCategory = "<br> Adhoc Limit for "
												+ Helper
														.correctNull((String) arrSubFacRecords
																.get(12)) + " Month";
									else
										chkCategory = "";

									
			                if (j == 0) {
			                	arrResult.add("<tr><td colspan=\"7\">&nbsp;<b>&gt;&gt;Sub-Limit</b></td></tr>");
			                }
			                arrResult.add("<tr><td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(0))+chkCategory+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;("+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))+")</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(5))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(6))))+"</td>");
			                arrResult.add("<td align=\"right\">&nbsp;"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))+"</td>");
			                arrResult.add("<td align=\"left\">&nbsp;"+Helper.correctNull((String) arrSubFacRecords.get(8))+"</td></tr>");
			             }
							}
							//End of 'Sub-Facilities' details               
						}

						
						arrResult.add("<tr><td align=\"right\"><b>Sub-total [C]</b></td>");
						arrResult.add("<td align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("tl_total_existing"))))+"</td>");
						arrResult.add("<td align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("tl_total_proposed"))))+"</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td></tr>");
						arrResult.add("<tr><td align=\"center\"><b>TOTAL [A+B+C]</b></td>");
						arrResult.add("<td align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("total_existing"))))+"</td>");
						arrResult.add("<td align=\"right\">"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("total_proposed"))))+"</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td>");
						arrResult.add("<td align=\"center\">&nbsp;</td></tr></table></div>");
			           // arrResult.add("</td></tr></table></td></tr></table>");
			            arrResult.add("</td></tr></table>");

								
					
		}
		catch (Exception cf) 
		{
			throw new EJBException("Error closing the connection "+ cf.getMessage());
		}
		return arrResult;
	}
	private int getMaxGradeId(String appno)
	{
		ResultSet rs = null;
		int termId = 0;

		try
		{
			rs=DBUtils.executeLAPSQuery("comgroupconcernsmaxFI^"+appno);
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
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return termId;
	}

	public void updateImplnScheduleData(HashMap hsh)  {
		HashMap hshQueryVal = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;
		String strValue = "";
		String strAppno="";
		String strAction="";
		String strQuery="";
		
		try
		{
			
			strAction=correctNull((String)hsh.get("hidAction"));
			strAppno=correctNull((String)hsh.get("appno"));					
			int intUpdatesize=0;
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_implnschedule");
				
				strQuery=SQLParser.getSqlQuery("implngmax^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));				
				}
				arrValues.add(strAppno);
				
				arrValues.add(correctNull((String)hsh.get("txt_desc")));
				arrValues.add(correctNull((String)hsh.get("txt_commencementdate")));
				arrValues.add(correctNull((String)hsh.get("txt_completiondate")));
				arrValues.add(correctNull((String)hsh.get("txt_presentstat")));
				arrValues.add(strValue);
				arrValues.add(correctNull((String)hsh.get("sel_facility")));
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","upd_implnschedule");
				strValue=correctNull((String)hsh.get("hidsno"));
				
				arrValues.add(correctNull((String)hsh.get("txt_desc")));
				arrValues.add(correctNull((String)hsh.get("txt_commencementdate")));
				arrValues.add(correctNull((String)hsh.get("txt_completiondate")));
				arrValues.add(correctNull((String)hsh.get("txt_presentstat")));
				arrValues.add(strAppno);
				arrValues.add(strValue);
				arrValues.add(correctNull((String)hsh.get("sel_facility")));
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_implnschedule");
				strValue=correctNull((String)hsh.get("hidsno"));
			
				arrValues.add(strAppno);
				arrValues.add(strValue);
				arrValues.add(correctNull((String)hsh.get("sel_facility")));
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	public HashMap getImplnScheduleData(HashMap hsh)  {
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		String appno="";
		String strQuery="";
		boolean recordflag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			String strFacilities=correctNull((String)hsh.get("sel_facility"));	
			String fac="";
			if (!strFacilities.trim().equals("")  && !strFacilities.equalsIgnoreCase("s"))
			{
				strQuery=SQLParser.getSqlQuery("sel_implnschedulesno^"+appno+"^"+strFacilities);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("COM_APPNO"))); //0
					arrCol.add(correctNull(rs.getString("COM_DESC")));
					arrCol.add(correctNull(rs.getString("COM_COMMENCEDATE")));
					arrCol.add(correctNull(rs.getString("COM_COMPLETIONDATE")));
					arrCol.add(correctNull(rs.getString("COM_STATUS")));
					arrCol.add(correctNull(rs.getString("COM_SNO")));//5
					fac=Helper.correctNull(rs.getString("COM_FACILITIES"));
					arrRow.add(arrCol);	
					recordflag=true;
				}
				
				
				//To select the post sanction parameters
				//String strTemp = "and PS_APP_SNO='"+strFacilities+"'";
				String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strFacilities+"^"+appno);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					hshValues.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
				}
			}
			hshValues.put("arrRow",arrRow);
			hshValues.put("facilityid",correctNull((String)hsh.get("sel_facility")));
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public void updateRecommendationData(HashMap hsh)  {
		HashMap hshQueryVal = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;
		String strSno = "";
		String strAppno="";
		String strAction="";
		String strQuery="";
		String struserid="";
		String struserdesign="";
		String strrecmddate="";
		
		
		try
		{
			strAction=correctNull((String)hsh.get("hidAction"));
			strAppno=correctNull((String)hsh.get("appno"));			
			struserid=correctNull((String)hsh.get("txt_usrid"));
			strrecmddate=correctNull((String)hsh.get("txtRecmdDate"));
			int intUpdatesize=0;
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_recommend");
				
				strQuery=SQLParser.getSqlQuery("recommdgmax^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = correctNull(rs.getString(1));				
				}
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(correctNull((String)hsh.get("sel_recmdby")));
				//arrValues.add(correctNull((String)hsh.get("txt_RecmdComment")));
				arrValues.add(strrecmddate);
				arrValues.add(struserid);
				arrValues.add(correctNull((String)hsh.get("txt_RecmdComment")));
						
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","upd_recommend");
				strSno=correctNull((String)hsh.get("strhidSno"));
				
				arrValues.add(correctNull((String)hsh.get("sel_recmdby")));
				arrValues.add(correctNull((String)hsh.get("txt_RecmdComment")));
				arrValues.add(strAppno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_recommend");
				strSno=correctNull((String)hsh.get("strhidSno"));
			
				arrValues.add(strAppno);
				arrValues.add(strSno);			
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	public HashMap getRecommendationData(HashMap hsh)  {
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshValues = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		String appno="";
		String strSno="";
		String struserid="";
		String strRecmdby="";
		String strDesign="";
		
		String strQuery="",strValue="",strTallyFlag="";
		String strRecomendations="";
		boolean recordflag=false;
		double dbLiabAmount=0.00,dbAssetAmount=0.00;
		
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			strSno=correctNull((String)hsh.get("strhidSno"));
			String hidSNo=Helper.correctNull((String) hsh.get("strhidSno"));
			String hidRecomNo=Helper.correctNull((String) hsh.get("hidRecomNo"));
			String hidSelectFlag=Helper.correctNull((String) hsh.get("hidSelectFlag"));
			strQuery=SQLParser.getSqlQuery("sel_recommend^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("COM_APPNO"))); //0
				arrCol.add(correctNull(rs.getString("COM_SNO")));//1
				strRecmdby=correctNull(rs.getString("COM_RECOMMENDEDBY"));
				arrCol.add(strRecmdby);//2
				arrCol.add(correctNull(rs.getString("COM_RECOMMENDEDDATE")));//3
				struserid=correctNull(rs.getString("COM_RECOMMENDEDUSERID"));
				arrCol.add(struserid);//4
				arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("COM_RECOMMENDATIONS")))); //5
				strQuery=SQLParser.getSqlQuery("sel_design^"+struserid);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("CBS_STATIC_DATA_DESC")));//6
					
				}
				else
				{
					arrCol.add("");
				}
				
				arrRow.add(arrCol);	
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(hidSelectFlag.equalsIgnoreCase("Y"))
			{
				if(!(hidSNo.equalsIgnoreCase("") && hidRecomNo.equalsIgnoreCase("")))
				{
					rs=DBUtils.executeLAPSQuery("sel_comrecommendations_bysno^"+appno+"^"+hidSNo+"^"+hidRecomNo);
					if(rs.next())
					{
						strRecomendations=Helper.CLOBToString(rs.getClob("COM_RECOMMENDATIONS"));
					}
				}
			}
			hshValues.put("arrRow",arrRow);
			hshValues.put("strRecomendations", strRecomendations);
			hshValues.put("strRecomendby", hidRecomNo);
			hshValues.put("strSno",hidSNo);
			
			//Get Assets and Liabilities Tally flag Added by Kishan
			String strTabName1="ASSETS",strTabName2="LIABILITIES";
			 String strRowDescAseets="TOTAL ASSETS",strRowDescLiab="TOTAL LIABILITIES";
			 String strAsRowID="0",strLiabRowID="0";
			 if(rs!=null)	 
			 {
				 rs.close();
			 }
			 //To get LiabilityTotal rowid for selected cma number
			 rs=DBUtils.executeLAPSQuery("selrowidforliabasset^"+strValue+"^"+strTabName1+"^"+strRowDescAseets);
			 if(rs.next())
			 {
				 strAsRowID=Helper.correctNull((String)rs.getString("FIN_ROWID"));
			 }
			 if(rs!=null)	 
			 {
				 rs.close();
			 }
			 //To get Assetes rowid for selected cma number
			 rs=DBUtils.executeLAPSQuery("selrowidforliabasset^"+strValue+"^"+strTabName2+"^"+strRowDescLiab);
			 if(rs.next())
			 {
				 strLiabRowID=Helper.correctNull((String)rs.getString("FIN_ROWID"));
			 }
			 
			if(rs!=null)
			{
				  rs.close();
			}
			if(!strLiabRowID.equalsIgnoreCase("") && !strLiabRowID.equalsIgnoreCase("0"))
			{
			rs=DBUtils.executeLAPSQuery("selliabamuntsum^"+strValue+"^"+strLiabRowID);
			if(rs.next())
			{
				  dbLiabAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("liabsum")));
			}
			}
			if(rs!=null)
			{
				  rs.close();
			}
			if(!strAsRowID.equalsIgnoreCase("") && !strAsRowID.equalsIgnoreCase("0"))
			{
			rs=DBUtils.executeLAPSQuery("selassetssumamunt^"+strValue+"^"+strAsRowID);
			if(rs.next())
			{
				  dbAssetAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("assetsum")));
			}
			}
			if(dbAssetAmount!=dbLiabAmount)
			{
				  strTallyFlag="N";  
			}
			else
			{
				  strTallyFlag="Y";
			}
			hshValues.put("strTallyFlag", strTallyFlag);

		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	public void updateDelegationData(HashMap hsh)  {
		HashMap hshQueryVal = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;
		String strSno = "";
		String strAppno="";
		String strAction="";
		String strQuery="";
		
		try
		{
			
			strAction=correctNull((String)hsh.get("hidAction"));
			strAppno=correctNull((String)hsh.get("appno"));					
			int intUpdatesize=0;
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_delegation");
				
				strQuery=SQLParser.getSqlQuery("delegationmax^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno = correctNull(rs.getString(1));				
				}
				arrValues.add(strAppno);
				
				arrValues.add(correctNull((String)hsh.get("txt_name")));
				arrValues.add(correctNull((String)hsh.get("txt_desig")));
				
				arrValues.add(strSno);
				arrValues.add(correctNull((String)hsh.get("txtuserID")));
				arrValues.add(correctNull((String)hsh.get("sel_details")));
				arrValues.add(correctNull((String)hsh.get("txt_date")));

				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","upd_delegation");
				strSno=correctNull((String)hsh.get("hidsno"));
				
				arrValues.add(correctNull((String)hsh.get("txt_name")));
				arrValues.add(correctNull((String)hsh.get("txt_desig")));
				arrValues.add(correctNull((String)hsh.get("txtuserID")));
				arrValues.add(correctNull((String)hsh.get("sel_details")));
				arrValues.add(correctNull((String)hsh.get("txt_date")));
				arrValues.add(strAppno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_delegation");
				strSno=correctNull((String)hsh.get("hidsno"));
			
				arrValues.add(strAppno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	public HashMap getDelegationData(HashMap hsh)  {
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		HashMap hshValues = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		ArrayList arrCode= new ArrayList();
		String appno="";
		String strUserdesig="";
		String strcode="";
		String strUser="";
		String strQuery="",strdetails="";
		boolean recordflag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_delegation^"+appno);
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
			String strdate="";
			strQuery = SQLParser.getSqlQuery("sel_proprecdate^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				 strdate=Helper.correctNull((String)rs1.getString("mail_date"));
			}
			hshValues.put("strdate",strdate);

			hshValues.put("arrRow",arrRow);
			
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_mclr^"+appno);
			if (rs.next())
			{
				hshValues.put("strMCLRFlag","Y");
			}
			//rs=DBUtils.executeLAPSQuery("selrowidforliabasset^"+strValue+"^"+strTabName1+"^"+strRowDescAseets
			String strflagcheck="false";
			String strsanccheck="false";
			strQuery = SQLParser.getSqlQuery("sel_proc^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				hshValues.put("app_processdate",correctNull(rs.getString("app_processdate")));
			}
			strQuery=SQLParser.getSqlQuery("sel_delegation^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next()){
			strdetails=correctNull(rs.getString("COM_DETAILS"));

			strQuery = SQLParser.getSqlQuery("sel_devcheck^"+appno+"^"+strdetails);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next()){
				//hshValues.put("COM_DETAILS",correctNull(rs.getString("COM_DETAILS")));
				if(strdetails.equalsIgnoreCase("A")){
					strflagcheck="True";
				}
				if(strdetails.equalsIgnoreCase("S")){
					strsanccheck="True";
			}
			}
		
			}
			hshValues.put("strflagcheck",strflagcheck);
			hshValues.put("strsanccheck",strsanccheck);
			
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"+appno);
			if(rs.next())
			{ 
				hshValues.put("strSancdate",Helper.correctNull(rs.getString("COM_SANREF_SANCDATE")));
				hshValues.put("strSancAuth",Helper.correctNull(rs.getString("com_sancauthority")));
			}
			else
			{
				if(rs != null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_date^"+appno);
				if(rs.next())
				{
					hshValues.put("strSancdate",Helper.correctNull((String)rs.getString("appref_sancdate")));
					hshValues.put("strSancAuth",Helper.correctNull(rs.getString("appraisal_sancauth")));
					
				}
			}
			
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				if(rs1!= null)
				{
					rs1.close();
				}
				if(rs2!= null)
				{
					rs2.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	public void updateAssessmentSelection(HashMap hshValues) 
	{
	    HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		
		String strAction=null;
		String strAppno= null,strFinID="0";
		String strAssessmentSelect[]=null;
		ResultSet rs = null;
		int intsize=0;
		String[] strArr=null;
		try
		{		
			strAction =  correctNull((String)hshValues.get("hidAction"));;	
			strAppno = Helper.correctNull((String)hshValues.get("appno"));	
			strArr=(String[]) hshValues.get("txt_chkvalue");
			if(strAppno.equals("") || strAppno.equals("null"))
			{
				strAppno = Helper.correctNull((String)hshValues.get("strappno"));	
			}
			if(hshValues.get("chk_assessment") instanceof String[])
			{
				strAssessmentSelect=(String[])hshValues.get("chk_assessment");
			}
			else
			{
				strAssessmentSelect=new String[1];
				strAssessmentSelect[0]=correctNull((String)hshValues.get("chk_assessment"));
			}
			
			rs=DBUtils.executeLAPSQuery("sel_applicantiddemo^"+strAppno);
			if(rs.next())
			{
				strFinID=Helper.correctInt(rs.getString("demo_finstandard"));
			}
			String strAssessment="";
			for(int i=0;i<strAssessmentSelect.length;i++)
			{
				strAssessment+=strAssessmentSelect[i].trim()+"@";
			}
			if(strAction.equals("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","com_assessmentselection_delete");
				arrValues.add(strAppno);
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
				hshQuery.put("strQueryId","com_assessmentselection_delete");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();
				hshQuery.put("strQueryId","com_assessmentselection_insert");
				arrValues.add(strAppno);	//1
				arrValues.add(strAssessment);	
				
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			
			
			//for(int i=0;i<strArr.length;i++)
			{ 
				
				if(strArr[0].equalsIgnoreCase("N"))
				{
					// Turn Over Method
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_turnoverMethod");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("turnover");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[1].equalsIgnoreCase("N"))
				{
					//Expenditure Method
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_expenditureMethod");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("expenditure");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[2].equalsIgnoreCase("N"))
				{
					//Cash Flow
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_cashflowMethod_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("cashflow");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[3].equalsIgnoreCase("N"))
				{
					if(!strFinID.equalsIgnoreCase("0"))
					{
						// Method 1 of lending other than export limits
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","delfinratio_printyear_assessment");
						arrValues.add(strFinID);
						arrValues.add("M1");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_allcomments");
						arrValues.add(strAppno);
						arrValues.add("Method1");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
					}
				}
				if(strArr[4].equalsIgnoreCase("N"))
				{
					if(!strFinID.equalsIgnoreCase("0"))
					{
						// Method 2 of lending other than export limits
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","delfinratio_printyear_assessment");
						arrValues.add(strFinID);
						arrValues.add("M2");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_allcomments");
						arrValues.add(strAppno);
						arrValues.add("Method2");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
					}
				}
				if(strArr[5].equalsIgnoreCase("N"))
				{
					if(!strFinID.equalsIgnoreCase("0"))
					{
						// Working Capital gap method for export limits
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","delfinratio_printyear_assessment");
						arrValues.add(strFinID);
						arrValues.add("AFL");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_allcomments");
						arrValues.add(strAppno);
						arrValues.add("Assessmentofwc");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
					}
				}
				if(strArr[6].equalsIgnoreCase("N"))
				{
					//Other Assessment for WCDPN/WCTL
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add("20");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);	
					
				}
				if(strArr[7].equalsIgnoreCase("N"))
				{
					// Term loan assessment
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_comments");
					arrValues.add("release");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_comments");
					arrValues.add("ExistingTerm");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_comments");
					arrValues.add("BreifDetaisTL");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_copmof_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_comcomments_assessment");
					arrValues.add("SOM");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_comcomments_assessment");
					arrValues.add("CommentsProj");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_copmof_margin_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","delcom_machineryDet_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[8].equalsIgnoreCase("N"))
				{
					{
						//DSCR
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_com_finappDSCR_assessment");
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","finappdscr_avg_del");
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_allcomments");
						arrValues.add(strAppno);
						arrValues.add("assdscr");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						//Sensitivity Analysis
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_com_finappdscrsens_assessment");
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","finappdscrsens_avg_del");
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						intsize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size",String.valueOf(intsize));
						hshQuery.put("strQueryId","del_allcomments");
						arrValues.add(strAppno);
						arrValues.add("dscrsensvty");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						}
				}
				if(strArr[9].equalsIgnoreCase("N"))
				{
					//Cash Budget Method
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_cashbudget_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("cashbudget");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[10].equalsIgnoreCase("N"))
				{
					//Other Assessment for TL
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add("6");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[11].equalsIgnoreCase("N"))
				{
					//Assessment of Inland / Import LC
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_inlandAssessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					

					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("inlandComments");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[12].equalsIgnoreCase("N"))
				{
					//Other Non Funded Assessment
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_nonfundassessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_allcomments");
					arrValues.add(strAppno);
					arrValues.add("assnonfund");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[13].equalsIgnoreCase("N"))
				{
					//BG Assessment
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add("35");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[14].equalsIgnoreCase("N"))
				{
					//Assessment Comments
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_comments");
					arrValues.add("assmntcomments");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[15].equalsIgnoreCase("N"))
				{
					//Crop Loan
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","delete_croploan_details");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					//Debt Servicing statement
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","agr_dssassessment_delete");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","agr_dssaveragenetsurplus_delete");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[16].equalsIgnoreCase("N"))
				{
					//Assessment for Restructuring
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_com_restr_assessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				if(strArr[17].equalsIgnoreCase("N"))
				{
					//Assessment for Adhoc Facilities
					intsize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size",String.valueOf(intsize));
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add("37");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
				
			}
			
			if(intsize>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateAssessmentSelection "+e.getMessage());
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
	public HashMap getAssessmentSelection(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strAppNo=null,expdata=null,turnoverdata=null;
		String StrLoanType =null;
		String strDate=null;
		ResultSet rs=null;
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
				
				rs=DBUtils.executeLAPSQuery("sel_expenditureMethod^"+strAppNo);
				if(rs.next())
				{
					expdata="exist";
						
				}
				hshRecord.put("COM_EXPENDITURE",expdata);	
				
				if(rs!=null)
				{
					rs=null;
				}
				
				rs=DBUtils.executeLAPSQuery("sel_turnoverMethod^"+strAppNo);
				if(rs.next())
				{
					turnoverdata="exist";
					
				}
					hshRecord.put("COM_TURNOVER",turnoverdata);	
				
					if(rs!=null)
				{
					rs=null;
				}
				
				rs=DBUtils.executeLAPSQuery("com_assessmentselection_select^"+strAppNo);
				if(rs.next())
				{
	      	   		hshRecord.put("COM_ASSESSMENTTYPE",correctNull((String)rs.getString("COM_ASSESSMENTTYPE")));
				}
	
				if(rs!=null)
				{
					rs=null;
				}
				rs=DBUtils.executeLAPSQuery("sel_agrischeme^"+strAppNo+"^aQ");
				if(rs.next())
				{
					hshRecord.put("strschemeType",correctNull((String)rs.getString("facility_agrschemetype")));
				}
				if(rs!=null)
				{
					rs=null;
				}
				
				if(rs!=null) rs.close();
				rs = DBUtils.executeLAPSQuery("sel_RenewFlg^"+strAppNo);
				if(rs.next())
				{
					hshRecord.put("app_renew_flag", Helper.correctNull(rs.getString("app_renew_flag")));
				}
				
				//To get the WCDPN facility
				if(rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_wcdpnfac^"+strAppNo);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("FACILITY_ID")).equalsIgnoreCase("98"))
						hshRecord.put("strDPN2020","Y");	
				}
				
				//To get the GECL facility
				if(rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("chk_geclfacchk^"+strAppNo);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
						hshRecord.put("strgeclavailable","Y");	
					if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("063"))
						hshRecord.put("strMMithra","Y");	
					if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("065"))
						hshRecord.put("strCgssd","Y");
				}
				if(rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_rest_assess_selection^"+strAppNo);
				while(rs.next())
				{
					
						hshRecord.put("strrestasseselection","Y");	
					
				}
				//to get eKrishik Bhandar Scheme code
				if(rs != null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("chk_enwrscheme^"+strAppNo);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("074"))
						hshRecord.put("strenwravailable","Y");	
					
				}
				//to get PM Svanidhi data
				
				if(rs!=null)
					rs.close();									
				rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiStatus^"+strAppNo+"^2"));
				if(rs.next())
				{
					hshRecord.put("pmSvanidhi2","Y");
				}
				if(rs!=null)
					rs.close();									
				rs= DBUtils.executeQuery(SQLParser.getSqlQuery("sel_SvanidhiStatus^"+strAppNo+"^3"));
				if(rs.next())
				{
					hshRecord.put("pmSvanidhi3","Y");
				}
				/*if(rs!=null)
					rs.close();	
				rs= DBUtils.executeQuery(SQLParser.getSqlQuery("selloantype^"+strAppNo));
				if(rs.next())
				{
					StrLoanType=correctNull(rs.getString("FACILITY_STATUS"));
					
				if(StrLoanType.equalsIgnoreCase("PA"))
				{
					if(rs!=null)
						rs.close();	
					rs= DBUtils.executeQuery(SQLParser.getSqlQuery("selapp_processdate^"+strAppNo));
						if(rs.next())
						{
							strDate = correctNull(rs.getString("app_processdate"));
							SimpleDateFormat sdformat = new SimpleDateFormat("dd/mm/yyyy");
						      Date d1 = sdformat.parse(strDate);
						      Date d2 = sdformat.parse("23/05/2022");
							 if(d1.compareTo(d2) > 0) {
						         System.out.println("Date 1 occurs after Date 2");
						      } else if(d1.compareTo(d2) < 0) {
						         System.out.println("Date 1 occurs before Date 2");
						      } 
						}
						
				}
				
				}*/
				
				
		}catch (Exception e1)
		{
			throw new EJBException("Error Occured"+e1.getMessage());
		}
	
		return hshRecord;
	}
	public HashMap getTLWCFacilitiesData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCol	=new ArrayList();
		ArrayList arrRow	=new ArrayList();
		try
		{
			
			String strQuery="";
			String strModType	=correctNull((String)hshValues.get("strModType"));
			String strFacType	=correctNull((String)hshValues.get("strFacType")); 
			
			//To get the All Retail Products
			if(strModType.equalsIgnoreCase("r"))
			{
				strQuery=SQLParser.getSqlQuery("sel_allretailproducts"+"^<=");
				rs=DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					arrCol=new ArrayList();
					String strProductDesc="";
					strProductDesc	=correctNull((String)rs.getString("category"))+"-"+correctNull((String)rs.getString("subcategory"))+"-"+correctNull((String)rs.getString("prd_desc"));
					String strPrdLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					if(strPrdLoanType.equalsIgnoreCase("TL")||strPrdLoanType.equalsIgnoreCase("DL"))
					{
						strPrdLoanType="2";
					}
					else if(strPrdLoanType.equalsIgnoreCase("OD"))
					{
						strPrdLoanType="1";
					}
					arrCol.add(correctNull((String)rs.getString("prdcode")));//0
					arrCol.add(strProductDesc);//1
					arrCol.add(strPrdLoanType);//1
					arrRow.add(arrCol);
				}
				
			}
			else
			{
			rs = DBUtils.executeLAPSQuery("sel_Facilities_GC"+"^"+strModType+"^c");
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrRow.add(arrCol);	
			}
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getMISData "+ce.toString());
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
	public void updateRatificationComments(HashMap hsh) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String strAction="";
		String appno="",strcommenttype="",strpage="",comments="",strRatification="";
		
		try
		{
								
				strAction=(String)hsh.get("hidAction");
				appno=(String)hsh.get("appno");
				strRatification=(String)hsh.get("sel_ratification");
				strpage=(String)hsh.get("hidPage");
				comments=(String)hsh.get("txt_comments");
				
				if (strAction.trim().equals("update")) 
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","del_ratification_comments");
					arrValues.add(appno);
					arrValues.add(strpage);
					arrValues.add(strRatification);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					hshQueryValues.put("size", "2");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_ratification_comments");
					arrValues.add(appno);
					arrValues.add(strRatification);
					arrValues.add(comments);
					arrValues.add(strpage);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					
					if(strRatification.equals("5"))
					{
						int intsize=0;
						++intsize;
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId","del_com_ratiftod");
						arrValues = new ArrayList();
						arrValues.add(appno);
						arrValues.add(strRatification);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",String.valueOf(intsize));					
						hshQueryValues.put(String.valueOf(intsize),hshQuery);
						
						if(hsh.get("txt_accountno") instanceof String[])
						{
							
							String txt_accountno[]=(String[])hsh.get("txt_accountno");
							//String txt_slno[]=(String[])hsh.get("txt_slno");
							String txt_todsancrefno[]=(String[])hsh.get("txt_todsancrefno");
							String txt_todsancamt[]=(String[])hsh.get("txt_todsancamt");
							String txt_duedate[]=(String[])hsh.get("txt_duedate");
							String txt_regulardate[]=(String[])hsh.get("txt_regulardate");
							String txt_reguarcomments[]=(String[])hsh.get("txt_reguarcomments");
							for(int i=0;i<txt_accountno.length;i++)
							{
								++intsize;
								hshQuery=new HashMap();
								arrValues = new ArrayList();
								arrValues.add(appno);
								arrValues.add(strRatification);
								arrValues.add((i+1)+"");
								arrValues.add(txt_accountno[i]);
								arrValues.add(txt_todsancrefno[i]);
								arrValues.add(txt_todsancamt[i]);
								arrValues.add(txt_duedate[i]);
								arrValues.add(txt_regulardate[i]);
								arrValues.add(txt_reguarcomments[i]);
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_com_ratiftod");
								hshQueryValues.put("size",String.valueOf(intsize));					
								hshQueryValues.put(String.valueOf(intsize),hshQuery);
								
							}
						}
						else
						{
							++intsize;
							hshQuery=new HashMap();
							arrValues = new ArrayList();
							arrValues.add(appno);
							arrValues.add(strRatification);
							arrValues.add("1");
							arrValues.add(Helper.correctNull((String)hsh.get("txt_accountno")));
							arrValues.add(Helper.correctNull((String)hsh.get("txt_todsancrefno")));
							arrValues.add(Helper.correctNull((String)hsh.get("txt_todsancamt")));
							arrValues.add(Helper.correctNull((String)hsh.get("txt_duedate")));
							arrValues.add(Helper.correctNull((String)hsh.get("txt_regulardate")));
							arrValues.add(Helper.correctNull((String)hsh.get("txt_reguarcomments")));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_com_ratiftod");
							hshQueryValues.put("size",String.valueOf(intsize));					
							hshQueryValues.put(String.valueOf(intsize),hshQuery);
						}
						
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				else if(strAction.trim().equals("delete"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","del_ratification_comments");
					arrValues.add(appno);
					arrValues.add(strpage);
					arrValues.add(strRatification);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","del_com_ratiftod");
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strRatification);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size","2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		
	
		
		finally
		{
			try
			{
				
				/*if(rs != null)
				{
					rs.close();
				}
				*/

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
		
	}



public HashMap getRatificationComments(HashMap hsh) 
	{
		
		String strQuery="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshValues = new HashMap();
		String strAppno="",strpage="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		try
			{
				strAppno =correctNull((String) hsh.get("appno"));
				String strsel =correctNull((String) hsh.get("sel_ratification"));
				strpage=correctNull((String) hsh.get("hidPage"));
				
				if(!strpage.equalsIgnoreCase("") && !strsel.equalsIgnoreCase("") ){
				strQuery=SQLParser.getSqlQuery("sel_ratification_comments^"+strpage+"^"+strsel+"^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					hshValues.put("selratification",Helper.correctNull((String)rs1.getString("COM_SNO")));
					hshValues.put("COM_COMMENTS",Helper.CLOBToString(rs1.getClob("COM_COMMENTS")));
					
				}
				
					strQuery=SQLParser.getSqlQuery("sel_com_ratiftod^"+strAppno+"^"+strsel);
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_serialno")));//0
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_accountno")));//1
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_todsanctef")));//2
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_todamount")));//3
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_duedate")));//4
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_reguldate")));//5
						arrCol.add(Helper.correctNull(rs1.getString("com_ratif_regularcomments")));//6
						arrRow.add(arrCol);
					}
					
					hshValues.put("arrRow",arrRow);
				
				}
				hshValues.put("selratification",strsel);
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_sanctioningdept^"
						+ strAppno);
				if (rs.next()) 
				{
					hshValues.put("strSanctioningDept",Helper.correctNull(rs.getString("sanction_dept")));
					
					
				}
				
				}
		
		catch (Exception e)
			{
			log.error("error occured"+e.toString());
			}

			finally
			{
				try
				{
					if(rs!= null)
					{
						rs.close();
					}
				
				}
				catch (Exception e1)
				{
					log.error("error occured"+e1.toString());
				}
			}
			return hshValues;
	}

public void updateShareHoldPattern(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	String strSno = Helper.correctNull((String)hshValues.get("hidsno"));
	String appno=correctNull((String)hshValues.get("appno"));
	String strQuery = "";
	double lsumofshares = 0.00;
	double lnoofshares = 0.00;
	ResultSet rs=null;
	ResultSet rs1=null;
	int intUpdatesize=0;
	StringBuilder sbolddata=new StringBuilder();	
	try
	{
		
		 String strShareheldBy=Helper.correctNull((String)hshValues.get("sel_sharesheldby"));
		 String strNoofShares=Helper.correctNull((String)hshValues.get("txt_noofshares"));
		 String strFacValue=Helper.correctNull((String)hshValues.get("txt_facevalue"));
		 String strAmount=Helper.correctNull((String)hshValues.get("txt_amount"));
		 String strPercent=Helper.correctNull((String)hshValues.get("txt_perc"));
		 String strMerktValOfShares = Helper.correctDouble((String)hshValues.get("txt_mktvalofshares"));
		

		if(strAction.equalsIgnoreCase("insert"))
		{	
			rs=DBUtils.executeLAPSQuery("selmaxsnoshareholdpattern^"+appno);
			if(rs.next())
			{
				strSno=Helper.correctNull((String)rs.getString("COM_SHP_SNO"));
			}
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_shareholdpatternins");
			arrValues.add(appno);	
			arrValues.add(strSno);
			arrValues.add(strShareheldBy);
			arrValues.add(strNoofShares);
			arrValues.add(strFacValue);
			arrValues.add(strAmount);
			arrValues.add(strPercent);
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","com_shareholdmarketvalofsharesupd");		
			arrValues.add(strMerktValOfShares);
			arrValues.add(appno);	
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equalsIgnoreCase("update"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_shareholdpatternupd");		
			arrValues.add(strShareheldBy);
			arrValues.add(strNoofShares);
			arrValues.add(strFacValue);
			arrValues.add(strAmount);
			arrValues.add(strPercent);
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));
			arrValues.add(appno);	
			arrValues.add(strSno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","com_shareholdmarketvalofsharesupd");		
			arrValues.add(strMerktValOfShares);
			arrValues.add(appno);	
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equalsIgnoreCase("delete"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_shareholdpatterndel");
			arrValues.add(appno);	
			arrValues.add(strSno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("com_sumshareholdnoofshares^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			if( !(Helper.correctNull((String)rs.getString("COM_SHP_NOFSHARES")).equalsIgnoreCase("")) )
			{
				lsumofshares = Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_SHP_NOFSHARES")));
			}
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("com_shareholdpatternsel^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		double lcalc = 0.00;
		while(rs.next())
		{
			strQuery = SQLParser.getSqlQuery("com_shareholdselbysno^"+appno+"^"+Helper.correctNull((String)rs.getString("COM_SHP_SNO")));
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				lnoofshares = Double.parseDouble(Helper.correctDouble((String)rs1.getString("COM_SHP_NOFSHARES")));
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_shareholdpercentofofsharesupd");	
			if(lsumofshares != 0.00)
			{
				lcalc = lnoofshares/lsumofshares;
			}
			arrValues.add(String.valueOf(lcalc*100));
			arrValues.add(appno);
			arrValues.add(Helper.correctNull((String)rs.getString("COM_SHP_SNO")));
			hshQuery.put("arrValues", arrValues);
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
			if(rs!=null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
}

public HashMap getDataShareHoldPattern(HashMap hshValues)  {

	String strQuery="";
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecData = new ArrayList();
	ArrayList vecVal=new ArrayList();
	boolean recordflag=false;
	String strQuery1="";
	try
	{
		
		String strMarktValOfShares = "";
		String appno=correctNull((String)hshValues.get("appno"));
		
		String strValuesIn="";
		strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+appno);
		if(rs!=null)
		{
			rs.close();
		}
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("strValuesIn",correctNull(rs.getString("prop_valuesin")));
		}
			
		String strAction = correctNull((String)hshValues.get("hidAction"));		
		strQuery = SQLParser.getSqlQuery("com_shareholdpatternsel^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecVal=new ArrayList();
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_SNO")));//0	
			String strSharesheld=Helper.correctNull(rs.getString("COM_SHP_SHARESHELDBY"));
			if(!strSharesheld.equalsIgnoreCase(""))
			{			
			 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"139"+"^"+strSharesheld);
			 if(rs1.next())
			 {
				 vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//1
			 }
			 else
			 {
				 vecVal.add("");//1
			 }
			}
			else
			{
				 vecVal.add("");//1
			}				
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_NOFSHARES")));//2		
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_FACVALUE")));//3		
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_AMOUNT")));//4	
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_PERCENT")));//5	
			
			vecVal.add(Helper.correctNull(rs.getString("COM_SHP_SHARESHELDBY")));//6
			vecVal.add(strSharesheld);//7
			vecVal.add(Helper.correctNull(rs.getString("COM_SHAREHOLDERNAME")));//8
			strMarktValOfShares = Helper.correctNull(rs.getString("COM_SHP_MRKTVALOFSHARES"));
			
			vecData.add(vecVal);
			
		}
		hshRecord.put("vecData",vecData);
		hshRecord.put("MrktValOfShares",strMarktValOfShares);
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getData "+ce.toString());
	}
	finally
	{
		try
		{
			if(rs != null)
			{
				rs.close();
			}
			if(rs1 != null)
			{
				rs1.close();
			}
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;

}	

public HashMap getDataNatureOfShares(HashMap hshValues)  {

	String strQuery="";
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecData = new ArrayList();
	ArrayList vecVal=new ArrayList();
	boolean recordflag=false;
	String strQuery1="";
	try
	{
		String appno=correctNull((String)hshValues.get("appno"));
		String strAction = correctNull((String)hshValues.get("hidAction"));		
		strQuery = SQLParser.getSqlQuery("com_natureofsharessel^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecVal=new ArrayList();
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_SNO")));//0	
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_NATURESHAR")));//1
			String strnatureShar=Helper.correctNull(rs.getString("COM_NOS_NATURESHAR"));
			if(!strnatureShar.equalsIgnoreCase(""))
			{			
			 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"140"+"^"+strnatureShar);
			 if(rs1.next())
			 {
				 vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//2
			 }
			 else
			 {
				 vecVal.add("");//1
			 }
			}
			else
			{
				 vecVal.add("");//1
			}	
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_AUTHSHAR")));//3	
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_AUTHVALUE")));//4		
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_ISSUSHAR")));//5		
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_ISSUVALUE")));//6	
			vecVal.add(Helper.correctNull(rs.getString("COM_NOS_NATURESHAR")));//7	
			
			vecData.add(vecVal);
			
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
			if(rs != null)
			{
				rs.close();
			}
			if(rs1 != null)
			{
				rs1.close();
			}
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;

}

public void updateNatureOfShares(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	String strSno = Helper.correctNull((String)hshValues.get("hidsno"));
	String appno=correctNull((String)hshValues.get("appno"));
	ResultSet rs=null;
	int intUpdatesize=0;
	StringBuilder sbolddata=new StringBuilder();	
	try
	{
		
		 String strNatureofShares=Helper.correctNull((String)hshValues.get("sel_natofshares"));
		 String strAuthShares=Helper.correctNull((String)hshValues.get("txt_noofshares_auth"));
		 String strAuthValue=Helper.correctNull((String)hshValues.get("txt_value_auth"));
		 String strIssuedShare=Helper.correctNull((String)hshValues.get("txt_noofshares_issued"));
		 String strIssuedValue=Helper.correctNull((String)hshValues.get("txt_value_issued"));

		if(strAction.equalsIgnoreCase("insert"))
		{	
			rs=DBUtils.executeLAPSQuery("selmaxsnonatureofshares^"+appno);
			if(rs.next())
			{
				strSno=Helper.correctNull((String)rs.getString("COM_NOS_SNO"));
			}
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_natureofsharesins");
			arrValues.add(appno);	
			arrValues.add(strSno);
			arrValues.add(strNatureofShares);
			arrValues.add(strAuthShares);
			arrValues.add(strAuthValue);
			arrValues.add(strIssuedShare);
			arrValues.add(strIssuedValue);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equalsIgnoreCase("update"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_natureofsharesupd");		
			arrValues.add(strNatureofShares);
			arrValues.add(strAuthShares);
			arrValues.add(strAuthValue);
			arrValues.add(strIssuedShare);
			arrValues.add(strIssuedValue);
			arrValues.add(appno);	
			arrValues.add(strSno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equalsIgnoreCase("delete"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","com_natureofsharesdel");
			arrValues.add(appno);	
			arrValues.add(strSno);
			hshQuery.put("arrValues", arrValues);
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
			if(rs!=null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
}
public HashMap getMDSanctiontoEC(HashMap hshValues)  {
	
	String strQuery="";
	ResultSet rs = null;
	ResultSet rs1 = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol=new ArrayList();
	boolean recordflag=false;
	String strQuery1="";
	try
	{
		String appno=correctNull((String)hshValues.get("appno"));
		//String strAction = correctNull((String)hshValues.get("hidAction"));		
		strQuery = SQLParser.getSqlQuery("sel_mdsancitontoec^"+appno);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("MD_ESTIMATEFOR",Helper.correctNull(rs.getString("MD_ESTIMATEFOR")));	
			hshRecord.put("MD_PROVISIONALASON",Helper.correctNull(rs.getString("MD_PROVISIONALASON")));	
			hshRecord.put("MD_ACTUALSUPTO",Helper.correctNull(rs.getString("MD_ACTUALSUPTO")));	
			hshRecord.put("MD_PROJECTIONFOR",Helper.correctNull(rs.getString("MD_PROJECTIONFOR")));	
			hshRecord.put("MD_ACCEPTEDFOR",Helper.correctNull(rs.getString("MD_ACCEPTEDFOR")));	
			hshRecord.put("MD_REMARKS",Helper.correctNull(rs.getString("MD_REMARKS")));	
			hshRecord.put("MD_SHIFTINGREASON",Helper.correctNull(rs.getString("MD_SHIFTINGREASON")));	
			hshRecord.put("MD_WHETHERTAKEOVER_FULFIL",Helper.correctNull(rs.getString("MD_WHETHERTAKEOVER_FULFIL")));	
			hshRecord.put("MD_DEVIATIONCOMMENTS",Helper.correctNull(rs.getString("MD_DEVIATIONCOMMENTS")));	
			hshRecord.put("MD_JUSTIFICATION",Helper.correctNull(rs.getString("MD_JUSTIFICATION")));	
			hshRecord.put("MD_ANYOTHERINFO",Helper.correctNull(rs.getString("MD_ANYOTHERINFO")));	
			hshRecord.put("MD_DEALING",Helper.correctNull(rs.getString("MD_DEALING")));	
		}
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getData "+ce.toString());
	}
	finally
	{
		try
		{
			if(rs != null)
			{
				rs.close();
			}
			if(rs1 != null)
			{
				rs1.close();
			}
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshRecord;
	
}

public void updateMDSanctiontoEC(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	String appno=correctNull((String)hshValues.get("appno"));
	ResultSet rs=null;
	int intUpdatesize=0;
	StringBuilder sbolddata=new StringBuilder();	
	try
	{
		
		
		hshQuery=new HashMap();
		arrValues=new ArrayList();
		hshQueryValues.put("size","1");
		hshQuery.put("strQueryId","del_mdsancitontoec");
		arrValues.add(appno);	
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		if(strAction.equalsIgnoreCase("update"))
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ins_mdsancitontoec");		
			arrValues.add(appno);	
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_estimatefor")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_provisionalason")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_actualsupto")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_projectionsfor")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_acceptedfor")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_remarks")));
			//arrValues.add(Helper.correctNull((String)hshValues.get("sel_accounttakeover")));
			//arrValues.add(Helper.correctNull((String)hshValues.get("txt_furnishdetails")));
			//arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankname")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_shiftingreason")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_takeoverfulfil")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_deviationreason")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_justification")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_anyotherinfo")));
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_dealing")));
			hshQuery.put("arrValues", arrValues);
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
			if(rs!=null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
}
public HashMap getECBoardAnnexureVIII(HashMap hshValues)  {

	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	ResultSet rs = null,rs1=null,rs2=null;
	HashMap hshRecord = new HashMap();
	String strROIType="",strRefType="",strSpread1="",strSpread2="",strMCLRType="",strInterestDef="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrRow1=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrCol1=new ArrayList();
	try
	{
		int intFacCount=0;
		String appno=correctNull((String)hshValues.get("appno"));
		String strPageFrom=Helper.correctNull((String)hshValues.get("pagefrom"));

		if(strPageFrom.equalsIgnoreCase("ecannx8"))
		{
			rs = DBUtils.executeLAPSQuery("sel_exposirtfacilities^"+appno);
			while(rs.next())
			{
				hshRecord=new HashMap();
				intFacCount++;
				hshRecord.put("strFacDesc", Helper.correctNull(rs.getString("facility_displaydesc")));
				hshRecord.put("strFacSno", Helper.correctNull(rs.getString("term_sno")));

				if(rs1!=null)
					rs1.close();

				rs1 = DBUtils.executeLAPSQuery("sel_commentsoninterestrate^commentsonintrestrate^"+Helper.correctNull(rs.getString("term_sno"))+"^"+appno);
				if(rs1.next())
				{
					hshRecord.put("strROIComments", Helper.correctNull(Helper.CLOBToString(rs1.getClob("com_comments"))));
				}
				hshValues.put("hshResult"+intFacCount, hshRecord);
			}
		}
		else if(strPageFrom.equalsIgnoreCase("ecannx2"))
		{
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("sel_management_Assement^Management^22^"+"^"+appno);
			while(rs.next()){
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));//1
				arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));//2
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			
			rs = DBUtils.executeLAPSQuery("sel_management^Management^22^"+appno);
			if (rs.next()) {
				hshValues.put("strcomments", Helper.CLOBToString(rs.getClob("com_comments")));
			
			}
		}
		else if(strPageFrom.equalsIgnoreCase("ecannx6"))
		{
			rs1 = DBUtils.executeLAPSQuery("sel_facmclrdetails^"+appno);
			while(rs1.next())
			{
				hshRecord=new HashMap();
				intFacCount++;
				int inCRPCnt=0,intBSPCnt=0;
				
				hshRecord.put("strFacDesc", Helper.correctNull(rs1.getString("facility_displaydesc")));
				hshRecord.put("strFacSno", Helper.correctNull(rs1.getString("facility_sno")));
				hshRecord.put("strFacSancAmt", Helper.correctNull(rs1.getString("facility_sancamt")));
				hshRecord.put("strAppName", Helper.correctNull(rs1.getString("perapp_fname")));
				hshRecord.put("strSacnIntRate",jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancinterest")))));
				strMCLRType="";
				strInterestDef=Helper.correctNull(rs1.getString("com_facintdef"));
				
				if(rs!=null)
					rs.close();
				//Disbursing Branch name
				rs=DBUtils.executeLAPSQuery("sel_disbbranchname^"+appno+"^"+Helper.correctNull(rs1.getString("facility_sno")));
				if(rs.next())
				{
					hshRecord.put("strDisbBranch", Helper.correctNull(rs.getString("org_name")));
				}
				
				//Sector
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_mispagedetailscorp^"+appno+"^"+Helper.correctNull(rs1.getString("facility_sno")));
				if(rs.next())
				{
					if(Helper.correctNull(rs.getString("app_sector")).equalsIgnoreCase("01"))
						hshRecord.put("strSector", "Priority sector");
					else if(Helper.correctNull(rs.getString("app_sector")).equalsIgnoreCase("02"))
						hshRecord.put("strSector", "Non Priority sector");
				}
				//MCLR Details
				rs=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+Helper.correctNull(rs1.getString("facility_sno"))+"^"+appno);
				if(rs.next())
				{
					hshRecord.put("strMCLRType",Helper.correctNull(rs.getString("facility_mclrtype")));
					hshRecord.put("mclr_spread",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spread")))));
					hshRecord.put("mclr_crp_total",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_crp_total")))));
					hshRecord.put("mclr_bsp_total",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_bsp_total")))));

					double dblTotal=Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spread")))+
					Double.parseDouble(Helper.correctDouble(rs.getString("mclr_crp_total")))+
					Double.parseDouble(Helper.correctDouble(rs.getString("mclr_bsp_total")));

					hshRecord.put("dblTotalIntRate",jtn.format(dblTotal));

					strMCLRType=Helper.correctNull(rs.getString("facility_mclrtype"));

				}
				if(!strMCLRType.equalsIgnoreCase(""))
				{
					String strArr[]=strMCLRType.split("@");
					strROIType="";strRefType="";
					if(strArr!=null && strArr.length>0)
					{
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
						if(rs.next())
						{
							if(strROIType.equalsIgnoreCase("O"))
								strROIType=Helper.correctNull(rs.getString("cbs_static_data_passing_code")); 
							else
								strRefType=Helper.correctNull(rs.getString("cbs_static_data_passing_code")); 

							hshRecord.put("strMCLRtypeDesc",Helper.correctNull(rs.getString("cbs_static_data_desc")));

							strSpread1=Helper.correctNull(rs.getString("cbs_static_sanc_refno"));  
							strSpread2=Helper.correctNull(rs.getString("cbs_static_cgtmse"));  
						}
					}
					if(rs!=null)
						rs.close();
					arrRow=new ArrayList();
					arrRow1=new ArrayList();
					arrCol1=new ArrayList();
					arrCol=new ArrayList();
					rs=DBUtils.executeLAPSQuery("sel_facilitymclr^"+strSpread1+"^"+Helper.correctNull(rs1.getString("facility_sno"))+"^"+appno);
					while(rs.next())
					{
						arrRow1=new ArrayList();
						if(strInterestDef.equalsIgnoreCase("S"))
						{
							++inCRPCnt;
							arrCol1=new ArrayList();
							arrCol1.add(Helper.correctNull(rs.getString("mclr_caption")));
							//if(Helper.correctNull(rs.getString("mclr_caption")).equalsIgnoreCase("Credit Risk Premium") && (strROIType.equalsIgnoreCase("ST")||strROIType.equalsIgnoreCase("TG")) && strRefType.equalsIgnoreCase("O"))
							{
								arrCol1.add(Helper.correctNull(rs.getString("mclr_spreadval")));
							}
							arrCol1.add(Helper.correctNull(rs.getString("mclr_spreadval")));
							arrRow1.add(arrCol1);
						}
						else
						{
							if(!Helper.correctNull(rs.getString("mclr_captionval")).equalsIgnoreCase(""))
							{
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("sel_mclrspreadmaster^"+(Helper.correctNull(rs.getString("mclr_captionval")).split("-"))[0]);
								while(rs2.next())
								{
									++inCRPCnt;
									arrCol1=new ArrayList();
									arrCol1.add(Helper.correctNull(rs2.getString("mclr_desc")));
									arrCol1.add("BenchMark");
									arrCol1.add("Actual");
									arrRow1.add(arrCol1);
								}
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("sel_mclrdescription^"+(Helper.correctNull(rs.getString("mclr_captionval")).split("-"))[0]);
								while(rs2.next())
								{
									++inCRPCnt;
									arrCol1=new ArrayList();
									arrCol1.add(Helper.correctNull(rs2.getString("caption")));
									arrCol1.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("captionvalue")))));
									arrCol1.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spreadval")))));
									arrRow1.add(arrCol1);
								}
							}
							
						}
						
						arrRow.add(arrRow1);
						
						++inCRPCnt;
						arrRow1=new ArrayList();
						arrCol1=new ArrayList();
						arrCol1.add("");
						arrCol1.add("");
						arrCol1.add("");
						arrRow1.add(arrCol1);
						
						arrRow.add(arrRow1);
					}

					if(arrRow!=null && arrRow.size()>0)
						hshRecord.put("arrRowCRP",arrRow);

					arrRow=new ArrayList();
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_facilitymclr^"+strSpread2+"^"+Helper.correctNull(rs1.getString("facility_sno"))+"^"+appno);
					while(rs.next())
					{
						arrRow1=new ArrayList();
						if(strInterestDef.equalsIgnoreCase("S"))
						{
							++intBSPCnt;
							arrCol1=new ArrayList();
							arrCol1.add(Helper.correctNull(rs.getString("mclr_caption")));
							//if(Helper.correctNull(rs.getString("mclr_caption")).equalsIgnoreCase("Business strategic Premium") && !(strROIType.equalsIgnoreCase("ST")||strROIType.equalsIgnoreCase("TG")) && strRefType.equalsIgnoreCase("O"))
							{
								arrCol1.add(Helper.correctNull(rs.getString("mclr_spreadval")));
							}
							arrCol1.add(Helper.correctNull(rs.getString("mclr_spreadval")));
							arrRow1.add(arrCol1);
						}
						else
						{
							if(!Helper.correctNull(rs.getString("mclr_captionval")).equalsIgnoreCase(""))
							{
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("sel_mclrspreadmaster^"+(Helper.correctNull(rs.getString("mclr_captionval")).split("-"))[0]);
								while(rs2.next())
								{
									++intBSPCnt;
									arrCol1=new ArrayList();
									arrCol1.add(Helper.correctNull(rs2.getString("mclr_desc")));
									arrCol1.add("BenchMark");
									arrCol1.add("Actual");
									arrRow1.add(arrCol1);
								}
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("sel_mclrdescription^"+(Helper.correctNull(rs.getString("mclr_captionval")).split("-"))[0]);
								while(rs2.next())
								{
									++intBSPCnt;
									arrCol1=new ArrayList();
									arrCol1.add(Helper.correctNull(rs2.getString("caption")));
									arrCol1.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs2.getString("captionvalue")))));
									arrCol1.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spreadval")))));
									arrRow1.add(arrCol1);
								}
							}
						}
						
						arrRow.add(arrRow1);
						
						++intBSPCnt;
						arrRow1=new ArrayList();
						arrCol1=new ArrayList();
						arrCol1.add("");
						arrCol1.add("");
						arrCol1.add("");
						arrRow1.add(arrCol1);
						
						arrRow.add(arrRow1);
					}

					if(arrRow!=null && arrRow.size()>0)
						hshRecord.put("arrRowBSP",arrRow);


				}

				hshRecord.put("strCRPCnt",String.valueOf(inCRPCnt));
				hshRecord.put("strBSPCnt",String.valueOf(intBSPCnt));
				hshValues.put("hshResult"+intFacCount, hshRecord);

			}
		}
		hshValues.put("strFacCount",String.valueOf(intFacCount));
		
		if(rs!=null){rs.close();}
		rs	= DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"+appno);
		if(rs.next())
		{
			hshValues.put("com_griddate",correctNull(rs.getString("com_griddate")));
		}
		String strQuery13 = SQLParser.getSqlQuery("sel_assessmnt_comments^Management^"+appno);
		ResultSet rs13 = DBUtils.executeQuery(strQuery13);
		while(rs13.next())
		{
			String strsno = Helper.correctNull((String)rs13.getString("COM_SNO"));
			if(strsno.equalsIgnoreCase("22"))
				hshValues.put("strEmailDate",Helper.correctNull(rs13.getString("COM_DACCODATE")));
		}
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getData "+ce.toString());
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
	return hshValues;

}
public void updCaptialMarketInfo(HashMap hsh)  
{
	int intsize=0;
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strAction="";
	String appno="";
	try
	{
		strAction=(String)hsh.get("hidAction");
		appno=Helper.correctNull((String)hsh.get("appno"));
		
		if(strAction.equalsIgnoreCase("insert"))
		{
			++intsize;
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_captial_marketinfo");
			hshQueryValues.put("size",String.valueOf(intsize));					
			hshQueryValues.put(String.valueOf(intsize),hshQuery);
			
			if(Helper.correctNull((String)hsh.get("sel_listedinse")).equalsIgnoreCase("Y"))
			{
				String strParticulars[]=(String[])hsh.get("txt_particulars");
				String strBSE[]=(String[])hsh.get("txt_BSE");
				String strNSE[]=(String[])hsh.get("txt_NSE");
				for(int i=0;i<strParticulars.length;i++)
				{
					++intsize;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strParticulars[i]);
					arrValues.add(strBSE[i]);
					arrValues.add(strNSE[i]);
					arrValues.add(String.valueOf(i+1));
					arrValues.add(Helper.correctNull((String)hsh.get("sel_listedinse")));
					arrValues.add(appno);
					arrValues.add(Helper.correctNull((String)hsh.get("txt_date")));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_captial_marketinfo");
					hshQueryValues.put("size",String.valueOf(intsize));					
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
				}
			}
			else
			{
				++intsize;
				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)hsh.get("sel_listedinse")));
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hsh.get("txt_date")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_captial_marketinfo");
				hshQueryValues.put("size",String.valueOf(intsize));					
				hshQueryValues.put(String.valueOf(intsize),hshQuery);
			}
			
			if(intsize>0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}
		else if(strAction.equalsIgnoreCase("delete"))
		{
			hshQuery=new HashMap();
			arrValues = new ArrayList();
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_captial_marketinfo");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Exception caught in updCaptialMarketInfo===="+ce.toString());
	}
}
public HashMap getCaptialMarketInfo(HashMap hsh)  {

	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ResultSet rs=null;
	try
	{
		String strAppno =correctNull((String) hsh.get("appno"));
		
		rs=DBUtils.executeLAPSQuery("sel_captial_marketinfo^"+strAppno);
		while(rs.next())
		{
			if(Integer.parseInt(Helper.correctInt(rs.getString("capital_sno")))>9)
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("capital_part")));
				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("capital_bse")))));
				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("capital_nse")))));
				arrRow.add(arrCol);
			}
			else
			{
				hsh.put("strCapitalPart"+Helper.correctInt(rs.getString("capital_sno")),Helper.correctNull(rs.getString("capital_part")));
				hsh.put("strCapitalBSE"+Helper.correctInt(rs.getString("capital_sno")),jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("capital_bse")))));
				hsh.put("strCapitalNSE"+Helper.correctInt(rs.getString("capital_sno")),jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("capital_nse")))));
			}
			
			hsh.put("strListedinSE",Helper.correctNull(rs.getString("capital_listedinse")));
			hsh.put("strShareAson",Helper.correctNull(rs.getString("capital_shareason")));
		}
		
		hsh.put("arrRow",arrRow);
		
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getCaptialMarketInfo "+ce.toString());
	}
	return hsh;

}
public HashMap geteNWRassessment(HashMap hsh)  {
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ResultSet rs=null;
	ResultSet rs1=null;
	ResultSet rs2=null;
	String strQuery="";
	String strQuery2="";
	String strQuery1="";
	String strFacilitySno ="";
	double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(4);
	jtn.setMinimumFractionDigits(4);
	jtn.setGroupingUsed(false);
	try
	{
		String strAppno =correctNull((String) hsh.get("appno"));

		strQuery = SQLParser.getSqlQuery("sel_agrenwrassessment^"+strAppno);	
		if(rs != null)
		{rs.close();}
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{	
			strFacilitySno=correctNull((String)rs.getString("ENWR_SNO"));			
			strQuery2=SQLParser.getSqlQuery("selagreNWRdetails^"+strFacilitySno+"^"+strAppno);	
			
			rs1 = DBUtils.executeQuery(strQuery2);
			if(rs1.next())
			{	
				hsh.put("croporcommodity",correctNull((String)rs1.getString("ENWR_CROPNAME")));
				hsh.put("noofpackages",correctNull((String)rs1.getString("ENWR_NOOFPACKAGES")));
				hsh.put("netquantity",correctNull((String)rs1.getString("ENWR_NET_QTY")));
				hsh.put("estimatedvalue",correctNull((String)rs1.getString("ENWR_ESTIMATEVALUE")));
				hsh.put("totalvalue",correctNull((String)rs1.getString("ENWR_TOTALVALUE")));
				hsh.put("loansanctionamt",correctNull((String)rs1.getString("ENWR_LOANSANCTIONAMT")));				
			}
			strQuery1= SQLParser.getSqlQuery("selfacilityproposedmt^" + strAppno+"^"+strFacilitySno);					
			rs2 = DBUtils.executeQuery(strQuery1);
			if(rs2.next())
			{
				dblExist = rs2.getDouble("facility_existing");
				dblProposed =rs2.getDouble("facility_proposed");
				dblMargin =rs2.getDouble("facility_margin");
				hsh.put("headid",correctNull(rs2.getString("facility_headid")));
				hsh.put("facdid",correctNull(rs2.getString("facility_id")));
				hsh.put("facdesc",correctNull(rs2.getString("facility_desc")));
				hsh.put("facexist",jtn.format(dblExist));
				hsh.put("facproposed",jtn.format(dblProposed));
				hsh.put("facmargin",jtn.format(dblMargin));
				hsh.put("facinterest",correctNull(rs2.getString("facility_interest")));
				hsh.put("facapplication",correctNull(rs2.getString("facility_application")));
				}
		}		
		
		
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in geteNWRassessment "+ce.toString());
	}
	return hsh;

}
public void updateeNWRassessment(HashMap hsh)  
{

	HashMap hshQuery=new HashMap();
	HashMap hshRecord = new HashMap();
	HashMap hshQueryValues = null;
	String strQuery = "";
	String strFacilitySno ="";
	ResultSet rs = null;
	ArrayList arr= new ArrayList() ;
	
	HashMap hshQuery1=new HashMap();
	HashMap hshRecord1 = new HashMap();
	HashMap hshQueryValues1 = null;
	
	
	ArrayList arr1= new ArrayList();
	
	String strAppno=Helper.correctNull((String)hsh.get("appno"));
	String strAction = Helper.correctNull((String)hsh.get("hidAction"));	
	String strinwardno=Helper.correctNull((String)hsh.get("inwardno"));
	ArrayList arrValues = new ArrayList();
	ArrayList arrValues1 = new ArrayList();
	
	try
	{
		
		strQuery = SQLParser.getSqlQuery("sel_agrenwrassessment^"+strAppno);	
		if(rs != null)
		{rs.close();}
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{	
			strFacilitySno=correctNull((String)rs.getString("ENWR_SNO"));	
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "del_enwrassessment");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{				
		 		arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();	
				arrValues.add(Helper.correctNull((String)hsh.get("txt_sanctionvalue")));	
				arrValues.add(strAppno);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","update_enwrassessment");			
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
				}
		}
		
		
	}			
	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}

}
}