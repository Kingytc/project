package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.sql.SQLPermission;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper5 extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TagDataHelper5.class);

	/**
	 * Bean : SetOrgBean
	 * 
	 * @param hshParamter
	 * @return
	 * @
	 */
	public HashMap getDataHelp(HashMap hshParamter)  {

		String strName = "";
		String strVal = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCodes = new ArrayList();
		ArrayList vecValues = new ArrayList();
		String strDynquery = (String) hshParamter.get("TagQuery");
		int intTokens = 0;
		try {

			StringTokenizer strHelpTok = new StringTokenizer(strDynquery, "^");
			intTokens = strHelpTok.countTokens();
			if (intTokens == 2) {
				strName = strHelpTok.nextToken();
				strVal = strHelpTok.nextToken();
			} else {
				strName = "";
				strVal = "";
			}

			rs = DBUtils.executeLAPSQuery("setorghelp^" + strName + "^"
					+ strVal);
			while (rs.next()) {
				vecCodes.add(correctNull(rs.getString("org_code")));
				vecValues.add(correctNull(rs.getString("org_name")));
			}
			hshRecord.put("vecCodes", vecCodes);
			hshRecord.put("vecValues", vecValues);
		} catch (Exception ce) {
			log.error(ce.toString());
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
	 * Bean : SetInterestBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getProcessChargesID(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		String strPrdCode = "";
		try {

			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("selprocesschargeid^" + strPrdCode);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getProcessChargesID "
								+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	/**
	 * Bean : AppTermsConditions
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getTermData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ArrayList arrTerms = new ArrayList();
		ArrayList arrTermsId = new ArrayList();
		HashMap hshRecord = new HashMap();
		try {

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("setmodtermcondterm");
			while (rs.next()) {
				arrTermsId.add(correctNull(rs.getString(1)));
				arrTerms.add(correctNull(rs.getString(2)));

			}
			hshRecord.put("arrTermsId", arrTermsId);
			hshRecord.put("arrTerms", arrTerms);
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

	public HashMap getProductList1(HashMap hshValues) 
	{
		 
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="";
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
	
		String strApplicationType=correctNull((String)hshValues.get("apptype"));
		String strOrgLevel=correctNull((String)hshValues.get("orglevel"));
		String strGroupRights=correctNull((String)hshValues.get("grouprights"));
		String strOrgCode=correctNull((String)hshValues.get("orgcode"));
		String strBankVal="";
		String strShortCode="";
		try
		{
			strGroupRights=strGroupRights.substring(8,11);
			 
			if (strOrgLevel.equalsIgnoreCase("C"))
			{
				strBankVal = "'"+strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("R"))
			{
				strBankVal = "'"+strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("D"))
			{
				strBankVal = "'"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("A"))
			{
				strBankVal = "'"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}
			else if (strOrgLevel.equalsIgnoreCase("B"))
			{
				strBankVal = "'"+strOrgCode.substring(0,15);
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,12)+"000";
				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
			}

			if(strApplicationType.equalsIgnoreCase("p") || strApplicationType.equalsIgnoreCase("gf") || strApplicationType.equalsIgnoreCase("a"))
			{
				strQuery =SQLParser.getSqlQuery("selorgsortcode^"+ strBankVal);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					strShortCode= rs.getString(1);
					if(!strShortCode.equals(""))
					{
						//rs1=DBUtils.executeLAPSQuery("perprdlisthelp5^" +strShortCode+"^"+ strApplicationType);
						rs1=DBUtils.executeLAPSQuery("perprdlisthelp5^"+ strApplicationType+"^"+strShortCode);
						while (rs1.next())
						{
							arryCol=new ArrayList();
							arryCol.add(rs1.getString("prdcode"));
							arryCol.add(rs1.getString("category"));
							arryCol.add(rs1.getString("subcategory"));
							arryCol.add(rs1.getString("rangefrom"));
							arryCol.add(rs1.getString("rangeto"));
							arryCol.add(rs1.getString("term"));
							arryCol.add(rs1.getString("class"));
							arryCol.add(rs1.getString("loanratio"));
							arryCol.add(rs1.getString("intrest"));
							arryCol.add(rs1.getString("prd_type"));
							arryCol.add(rs1.getString("prd_inttype"));
							arryCol.add(rs1.getString("prd_repayselfemp"));
							arryCol.add(rs1.getString("prd_collweight"));
							arryCol.add(rs1.getString("prd_desc"));
							arryRow.add(arryCol);
						}
						rs1.close();
					}						
				}									
			}
			else if(strApplicationType.equalsIgnoreCase("c"))
			{
			 
				 rs=DBUtils.executeLAPSQuery("selorgsortcode^"+ strBankVal);
				 while(rs.next())
				{
					 strShortCode= rs.getString(1);
					if(!strShortCode.equals(""))
					{
					 
						 rs=DBUtils.executeLAPSQuery("comprdlisthelp^" + strShortCode);
						 while (rs1.next())
						{
							arryCol=new ArrayList();
							arryCol.add(rs1.getString("prdcode"));
							arryCol.add(rs1.getString("category"));
							arryCol.add(rs1.getString("subcategory"));
							arryCol.add(rs1.getString("rangefrom"));
							arryCol.add(rs1.getString("rangeto"));
							arryCol.add(rs1.getString("term"));
							arryCol.add(rs1.getString("class"));
							arryCol.add(rs1.getString("loanratio"));
							arryCol.add(rs1.getString("intrest"));
							arryCol.add(rs1.getString("prd_type"));
							arryCol.add(rs1.getString("prd_inttype"));
							arryRow.add(arryCol);
						}
						rs1.close();
					}						
				}
			} 
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getData"+ce.getMessage());
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
		return hshResult;
	}

	/**
	 * Bean : QisRangeBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getDataHelp1(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("selqisanalysisdetails");
			while (rs.next()) {
				arr.add(correctNull(rs.getString("id")));
				arr1.add(correctNull(rs.getString("ratio_desc")));
			}
			hshRecord.put("arrVal", arr);
			hshRecord.put("arrValdesc", arr1);

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
	 * Bean : QisAnalysisMasterBean
	 * 
	 * @param hsh
	 * @return
	 * @
	 */
	
	public HashMap getDivListId(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr1 = new ArrayList();
		
		try {
			String appid=Helper.correctNull((String)hshRequestValues.get("appid"));
		
			
			rs = DBUtils.executeLAPSQuery("seldivisionsid^"+appid);
			while (rs.next()) {
				ArrayList arr = new ArrayList();
				arr.add(correctNull(rs.getString("comapp_div_appid")));
				arr.add(correctNull(rs.getString("comapp_div_name")));
				arr1.add(arr);
			}
			hshRecord.put("arryRow", arr1);
			

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

	public HashMap getDataHelp2(HashMap hsh)  {

		ResultSet rs = null;
		// ResultSet rs1=null;
		// ResultSet rs3=null;

		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", value6 = "";
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

				rs = DBUtils.executeLAPSQuery("qisanalysiarow^" + value6);
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
	 * Bean : RepDataBean
	 * 
	 * @param hshValues
	 * @return
	 * @
	 */
	public HashMap getData(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		String strMethod = "";

		try {
			strMethod = (String) hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProfileNames")) {
				hshRecord = (HashMap) getProfileNames(hshValues);
			} else if (strMethod.equalsIgnoreCase("getProducts")) {
				hshRecord = (HashMap) getProducts(hshValues);
			}

		} catch (Exception ce) {
			throw new EJBException("Error in getdata " + ce.toString());
		}

		return hshRecord;
	}

	private HashMap getProfileNames(HashMap hshPar)  {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecBnkCode = new ArrayList();
		ArrayList vecBnkName = new ArrayList();
		String strUser = null;
		String strRepName = null;
		try {

			strUser = correctNull((String) hshPar.get("userid"));
			strRepName = correctNull((String) hshPar.get("repname"));

			rs = DBUtils.executeLAPSQuery("profilenames^" + strUser + "^"
					+ strRepName);
			while (rs.next()) {
				vecBnkCode.add(correctNull(rs
						.getString("rep_profilename")));
				vecBnkName.add(correctNull(rs
						.getString("rep_profilename")));

			}

			hshRecord.put("vecCodes", vecBnkCode);
			hshRecord.put("vecValues", vecBnkName);
		} catch (Exception ce) {
			throw new EJBException("Error in help " + ce.toString());
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

	private HashMap getProducts(HashMap hshPar)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecProdCode = new ArrayList();
		ArrayList vecProdName = new ArrayList();
		String strProdType = null;

		try {

			strProdType = correctNull((String) hshPar.get("prodtype"));

			rs = DBUtils.executeLAPSQuery("productcat^" + strProdType);
			while (rs.next()) {
				vecProdCode.add(correctNull(rs.getString("cat_id")));
				vecProdName.add(correctNull(rs.getString("cat_name")));
			}

			hshRecord.put("vecCodes", vecProdCode);
			hshRecord.put("vecValues", vecProdName);
		} catch (Exception ce) {
			throw new EJBException("Error in help " + ce.toString());
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
	 * Bean : ComRepayScheduleBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getTermFinanceFac(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		String strAppno = "";
		HashMap hshResult = new HashMap();
		try {

			strAppno = correctNull((String) hshRequestValues.get("appno"));

			rs = DBUtils.executeLAPSQuery("seltermfinancefac^" + strAppno);
			while (rs.next()) {
				String strCode = correctNull((String) rs.getString(1));
				String strName = correctNull((String) rs.getString(2));
				hshResult.put(strCode, strName);
			}

		} catch (Exception e) {
			throw new EJBException("Error in getTermFinanceFac  "
					+ e.toString());
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
	
	/**
	 * taglib : MarginTag
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getMarginID(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		String strpageid="";
		try {

			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			
			strpageid = correctNull((String) hshRequestValues.get("pageId"));
			
			hshRecord = new HashMap();
			if(strpageid.equalsIgnoreCase("P"))
			{
			strQuery=SQLParser.getSqlQuery("selMarginlist1^" +strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
		}
			else if(strpageid.equalsIgnoreCase("c"))
			{
			
				
				strQuery=SQLParser.getSqlQuery("selCOM_MARGINCOST1^" +strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				
				
			}
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(Helper.correctNull((String)rs.getString("margin_id")));
				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_from")));
				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_to")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getProcessChargesID "
								+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getFVCTenor(HashMap hshRequestValues) {
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strpageid="";
		try {

			strpageid = correctNull((String) hshRequestValues.get("pageId"));

			hshRecord = new HashMap();
			strQuery=SQLParser.getSqlQuery("selfvcmaster^" +strpageid);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(Helper.correctNull((String)rs.getString("fvc_sno")));
				vecCol.add(Helper.correctNull((String)rs.getString("fvc_tnr_from")));
				vecCol.add(Helper.correctNull((String)rs.getString("fvc_tnr_to")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getFVCTenor login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getFVCTenor "
						+ cf.getMessage());
			}
		}
		return hshRecord;
}
	
	/**
	 * taglib : IncomeTag
	 * @author sureshkumar Ganapathy
	 * @since 04/12/2009
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getIncome(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		try {

			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();
			strQuery=SQLParser.getSqlQuery("selprdrepaycapacitytag^" + strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("repay_id")));
				arrCol.add(correctNull((String)rs.getString("repay_incrangefrom")));
				arrCol.add(correctNull((String)rs.getString("repay_incrangeto")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getIncome "
								+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getFinIndicatorComment(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr1 = new ArrayList();
		
		try {
			String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
		
			
			rs = DBUtils.executeLAPSQuery("sel_comfinindallcommentlist^"+appno);
			while (rs.next()) {
				ArrayList arr = new ArrayList();
				arr.add(correctNull(rs.getString("indcomment_rowid")));
				arr.add(correctNull(rs.getString("indcomment_desc")));
				arr1.add(arr);
			}
			hshRecord.put("arryRow", arr1);
			

		} catch (Exception ce) {
			throw new EJBException("Error in getFinIndicatorComment login  " + ce.toString());
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
	public HashMap getRentInsuranceChargeID(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		String strPrdCode = "";
		try
		{
			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("selrentinsurechargeid^" + strPrdCode);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getProcessChargesID "
								+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getJewelAppraisalChargeID(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		String strPrdCode = "";
		try
		{
			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();
			
			rs = DBUtils.executeLAPSQuery("seljewelappraisalid^" + strPrdCode);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
				
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getProcessChargesID "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	/**
	 * Bean : SetOrgBean
	 * 
	 * @param hshParamter
	 * @return
	 * @
	 */
	public HashMap getFreeCodeData(HashMap hshParamter)  {

		String strName = "";
		String strVal = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCodes = new ArrayList();
		ArrayList vecValues = new ArrayList();
		String strDynquery = (String) hshParamter.get("TagQuery");
		int intTokens = 0;
		try {

			StringTokenizer strHelpTok = new StringTokenizer(strDynquery, "^");
			intTokens = strHelpTok.countTokens();
			if (intTokens == 2) {
				strName = strHelpTok.nextToken();
				strVal = strHelpTok.nextToken();
			} else {
				strName = "";
				strVal = "";
			}

			rs = DBUtils.executeLAPSQuery("sel_freecodes^" + strName + "^"
					+ strVal);
			while (rs.next()) {
				vecCodes.add(correctNull(rs.getString("FC_REFNO")));
				vecValues.add(correctNull(rs.getString("FC_DESC")));
			}
			hshRecord.put("vecCodes", vecCodes);
			hshRecord.put("vecValues", vecValues);
		} catch (Exception ce) {
			log.error(ce.toString());
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
	
	public HashMap getTermLoanFacilities(HashMap hshRequestValues)  {

		ResultSet rs = null;
		String strQuery = "", strType = "";
		HashMap hshVal = new HashMap();
		HashMap hshRecord = new HashMap();
		boolean flag = false;
		
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		try {
			String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
			hshRecord = new HashMap();
			

			rs=DBUtils.executeLAPSQuery("sel_termloan_facilities^"+appno);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("term_sno")));
				arrCol.add(Helper.correctNull((String)rs.getString("term_desc")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arryRow",arrRow);
			
			if(rs!= null)
			{
				rs.close();
			}
			
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
	
	public HashMap getColID(HashMap hshRequestValues)  
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		try {

				strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
				hshRecord = new HashMap();
				strQuery=SQLParser.getSqlQuery("selColSeclist1^" + strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
						vecCol = new ArrayList();
						vecCol.add(Helper.correctNull((String)rs.getString("COL_ID")));
						vecCol.add(Helper.correctNull((String)rs.getString("COL_RANGE_FROM")));
						vecCol.add(Helper.correctNull((String)rs.getString("COL_RANGE_TO")));
						vecRow.add(vecCol);
				}
				hshRecord.put("vecRow", vecRow);
			}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getColID " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			} 
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection getColID "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
		public HashMap getColsegSno(HashMap hshRequestValues)  
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		String strfacid = "";
		try {

				strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
				strfacid= correctNull((String) hshRequestValues.get("strfacid"));
				hshRecord = new HashMap();
				if(strfacid!="")
				{
				strQuery=SQLParser.getSqlQuery("selset_corpcollateralsecurity1^"+strPrdCode+"^"+strfacid);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
						vecCol = new ArrayList();
						vecCol.add(Helper.correctNull((String)rs.getString("scol_FacSno")));
						vecCol.add(Helper.correctNull((String)rs.getString("scol_RANGE_FROM")));
						vecCol.add(Helper.correctNull((String)rs.getString("scol_RANGE_TO")));
						vecRow.add(vecCol);
				}
				}
				hshRecord.put("vecRow", vecRow);
			}
		catch (Exception ce) 
		{
			throw new EJBException("Error in getColID " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			} 
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection getColID "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	/*
	 * For Facilities tag
	 * 
	 */
		public HashMap getTermFinanceFacNew(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ResultSet rs1 = null;
		 	String strQuery ="",strAppno="",strPagename="",strValue="",strQuery1="";
			HashMap hshResult = new HashMap();
			try
			{
				
				strAppno = correctNull((String)hshRequestValues.get("appno"));
				strPagename = correctNull((String)hshRequestValues.get("pagename"));
				
				if(strPagename.equalsIgnoreCase("EMI"))
				{
					strValue="E";
					strQuery = SQLParser.getSqlQuery("seltermfinancefac1_new^"+strAppno+"^"+strValue);
					rs = DBUtils.executeQuery(strQuery);
		  			while(rs.next())
					{
						String strCode= correctNull((String)rs.getString(1));
						String strName= correctNull((String)rs.getString(2));
						hshResult.put(strCode,strName);
					}
				}
				else if(strPagename.equalsIgnoreCase("NONEMI"))
				{
					strValue="'NE','OD','LC','CO','BG','DD','PC','PS'";
					String strLoanaccount="";  
					strQuery = SQLParser.getSqlQuery("seltermfinancefac_NE_new^"+strAppno+"^"+strValue);
					rs = DBUtils.executeQuery(strQuery);
		  			while(rs.next())
					{
						String strCode= correctNull((String)rs.getString(1));
						String strName= correctNull((String)rs.getString(2));
						String strFaccode= correctNull((String)rs.getString(4));
						strQuery1 = SQLParser.getSqlQuery("sel_otherdetails^"+strFaccode);
						rs1 = DBUtils.executeQuery(strQuery1);
			  			if(rs1.next())
						{
			  				strLoanaccount=Helper.correctNull((String)rs1.getString("COM_LOANACC"));
						}
			  			if(strLoanaccount.equalsIgnoreCase("Y"))
			  			{
			  				hshResult.put(strCode,strName);
			  			}
					}
				}
				else if(strPagename.equalsIgnoreCase("ALL"))
				{
					String strLoanaccount="";  
					strQuery = SQLParser.getSqlQuery("seltermfinancefac_NE_newAll^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
		  			while(rs.next())
					{
						String strCode= correctNull((String)rs.getString(1));
						String strName= correctNull((String)rs.getString(2));
			  			hshResult.put(strCode,strName);
					}
				}
				
				
				

			}
			catch(Exception e)
			{
				throw new EJBException("Error in getTermFinanceFac  "+e.toString());
			}
			finally
			{
				try
				{	
					if(rs != null)
						rs.close();
					
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}
			}
			return hshResult;
		}
		
		
		public HashMap getTermLoanFundbased(HashMap hshRequestValues)  {

			ResultSet rs = null;
			String strQuery = "", strType = "";
			HashMap hshVal = new HashMap();
			HashMap hshRecord = new HashMap();
			boolean flag = false;
			
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			try {
				String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
				hshRecord = new HashMap();
				

				rs=DBUtils.executeLAPSQuery("sel_termloan_facilities_fund_tag^"+appno);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("term_sno")));
					arrCol.add(Helper.correctNull((String)rs.getString("term_desc")));
					arrCol.add(Helper.correctNull((String)rs.getString("facility_proposed")));
					arrRow.add(arrCol);
				}
				
				hshRecord.put("arryRow",arrRow);
				
				if(rs!= null)
				{
					rs.close();
				}
				
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
		
		
		public HashMap getFacilityforCommentsonInterestRate(HashMap hshRequestValues)  {

			ResultSet rs = null;
			String strQuery = "", strType = "";
			HashMap hshVal = new HashMap();
			HashMap hshRecord = new HashMap();
			boolean flag = false;
			
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			try {
				String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
				hshRecord = new HashMap();

				rs=DBUtils.executeLAPSQuery("sel_faclityforcommentsonintrate_tag^"+appno);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("term_sno")));
					arrCol.add(Helper.correctNull((String)rs.getString("facility_displaydesc")));
					arrRow.add(arrCol);
				}
				
				hshRecord.put("arryRow",arrRow);
				
				if(rs!= null)
				{
					rs.close();
				}
				
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
		
		public HashMap getLoanAccountDetails(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ResultSet rs1 = null;
		 	String strQuery ="",strAppno="",strPagename="",strValue="",strQuery1="";
			HashMap hshResult = new HashMap();
			try
			{
				
				strAppno = correctNull((String)hshRequestValues.get("appno"));
				strPagename = correctNull((String)hshRequestValues.get("apptype"));
				String strLoanaccount="";
				if(strPagename.equalsIgnoreCase("S"))
				{
					strQuery = SQLParser.getSqlQuery("selrestraccdetails^"+strAppno);
				}
				else
				{
					strValue="'NE','OD','LC','CO','BG','DD','PC','PS'";
					strQuery = SQLParser.getSqlQuery("selloanaccdetails^"+strAppno+"^"+strValue+"^"+strAppno+"^"+strValue+"^"+strAppno+"^"+strValue);
				}
				rs = DBUtils.executeQuery(strQuery);
	  			while(rs.next())
				{
					String strCode= correctNull((String)rs.getString(1));
					String strName= correctNull((String)rs.getString(2));
					String strFaccode= correctNull((String)rs.getString(4));
					strQuery1 = SQLParser.getSqlQuery("sel_otherdetails^"+strFaccode);
					rs1 = DBUtils.executeQuery(strQuery1);
		  			if(rs1.next())
					{
		  				strLoanaccount=Helper.correctNull((String)rs1.getString("COM_LOANACC"));
					}
		  			else
		  			{
		  				strLoanaccount="";
		  			}
		  			if(strLoanaccount.equalsIgnoreCase("Y"))
		  			{
		  				hshResult.put(strCode,strName);
		  			}
				}
				
				
				

			}
			catch(Exception e)
			{
				throw new EJBException("Error in getTermFinanceFac  "+e.toString());
			}
			finally
			{
				try
				{	
					if(rs != null)
						rs.close();
					
				}
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
				}
			}
			return hshResult;
		}
		public HashMap getMCLRData(HashMap hshParamter)  {

			String strVal = "";
			ResultSet rs1 = null;
			HashMap hshRecord = new HashMap();
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strQuery="",strAppstatus="",strTemp=" ";
			try {

				strVal=Helper.correctNull((String)hshParamter.get("strValue"));
				strAppstatus=Helper.correctNull((String)hshParamter.get("appstatus"));
				if(!strVal.equalsIgnoreCase(""))
				{
					if(strAppstatus.equalsIgnoreCase("op"))
						strTemp="and mclr_activeflag='Y'";
						
					strQuery = SQLParser.getSqlQuery("sel_mclrspreadmasterval^" +strVal+"^"+strTemp);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) {
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull(rs1.getString("mclr_id")));
						arrCol.add(Helper.correctNull(rs1.getString("mclr_parent")));
						arrCol.add(Helper.correctNull(rs1.getString("mclr_desc")));
						arrRow.add(arrCol);
					}
					hshRecord.put("arrRow", arrRow);
				}
			} catch (Exception ce) {
				log.error(ce.toString());
				throw new EJBException("Error in getMCLRData " + ce.toString());
			} finally {
				try {
					if (rs1 != null) {
						rs1.close();
					}

				} catch (Exception cf) {
					throw new EJBException("Error closing the connection "
							+ cf.getMessage());
				}
			}
			return hshRecord;
		}
		/**
		 * Bean : SetInterestBean
		 * 
		 * @param hshRequestValues
		 * @return
		 * @
		 */
		public HashMap getsolvencyProcessChargesID(HashMap hshRequestValues)
				 {

			ResultSet rs = null;
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = null;
			HashMap hshRecord = new HashMap();
			String strPrdCode = "";
			try {

				strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
				hshRecord = new HashMap();
				if(!strPrdCode.equalsIgnoreCase("")){
				rs = DBUtils.executeLAPSQuery("selsolprocesschargeid^" + strPrdCode);
				while (rs.next()) {
					vecCol = new ArrayList();
					for (int i = 0; i < 3; i++) {
						vecCol.add(rs.getString(i + 1));
					}
					vecRow.add(vecCol);
				}
				}
				hshRecord.put("vecRow", vecRow);
			} catch (Exception ce) {
				throw new EJBException("Error in getsolvencyProcessChargesID login  " + ce.toString());
			} finally {
				try {
					if (rs != null)
						rs.close();

				} catch (Exception cf) {
					throw new EJBException(
							"Error closing the connection getsolvencyProcessChargesID "
									+ cf.getMessage());
				}
			}
			return hshRecord;
		}

		
		

}


/**
 * Bean : AppEditLockBean Function getProductList This Method is invoked for
 * getting the productlist help for personal and commercial application
 * 
 * @param hshValues
 * @return HashMap
 * @exception java.ejb.EJBException
 */
//public HashMap getProductList(HashMap hshValues) 
//{
//	 
//ResultSet rs=null;
//ResultSet rs1=null;
//String strQuery="";
//HashMap hshResult=new HashMap();
//ArrayList arryRow=new ArrayList();
//ArrayList arryCol=null;
//	
//String strApplicationType=correctNull((String)hshValues.get("apptype"));
//String strOrgLevel=correctNull((String)hshValues.get("orglevel"));
//String strGroupRights=correctNull((String)hshValues.get("grouprights"));
//String strOrgCode=correctNull((String)hshValues.get("orgcode"));
//String strBankVal="";
//String strShortCode="";
//try
//{
//strGroupRights=strGroupRights.substring(8,11);
//		 
//if (strOrgLevel.equalsIgnoreCase("C"))
//{
//strBankVal = "'"+strOrgCode.substring(0,3)+"000000000000'";
//}
//else if (strOrgLevel.equalsIgnoreCase("R"))
//{
//strBankVal = "'"+strOrgCode.substring(0,6)+"000000000";
//strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//}
//else if (strOrgLevel.equalsIgnoreCase("D"))
//{
//strBankVal = "'"+strOrgCode.substring(0,9)+"000000";
//strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//}
//else if (strOrgLevel.equalsIgnoreCase("A"))
//{
//strBankVal = "'"+strOrgCode.substring(0,12)+"000";
//strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
//strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//}
//else if (strOrgLevel.equalsIgnoreCase("B"))
//{
//strBankVal = "'"+strOrgCode.substring(0,15);
//strBankVal = strBankVal+"','"+strOrgCode.substring(0,12)+"000";
//strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
//strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//}
//
//if(strApplicationType.equalsIgnoreCase("p") ||
//strApplicationType.equalsIgnoreCase("gf"))
//{
//strQuery =SQLParser.getSqlQuery("selorgsortcode^"+ strBankVal);
//rs=DBUtils.executeQuery(strQuery);
//			
//while(rs.next())
//{
//strShortCode= rs.getString(1);
//if(!strShortCode.equals(""))
//{
//rs1=DBUtils.executeLAPSQuery("perprdlisthelp^" + strShortCode);
//while (rs1.next())
//{
//arryCol=new ArrayList();
//arryCol.add(rs1.getString("prdcode"));
//arryCol.add(rs1.getString("category"));
//arryCol.add(rs1.getString("subcategory"));
//arryCol.add(rs1.getString("rangefrom"));
//arryCol.add(rs1.getString("rangeto"));
//arryCol.add(rs1.getString("term"));
//arryCol.add(rs1.getString("class"));
//arryCol.add(rs1.getString("loanratio"));
//arryCol.add(rs1.getString("intrest"));
//arryCol.add(rs1.getString("prd_type"));
//arryCol.add(rs1.getString("prd_inttype"));
//arryCol.add(rs1.getString("prd_repayselfemp"));
//arryCol.add(rs1.getString("prd_collweight"));
//arryRow.add(arryCol);
//}
//rs1.close();
//}
//}
//}
//else if(strApplicationType.equalsIgnoreCase("c"))
//{
//		 
//rs=DBUtils.executeLAPSQuery("selorgsortcode^"+ strBankVal);
//while(rs.next())
//{
//strShortCode= rs.getString(1);
//if(!strShortCode.equals(""))
//{
//				 
//rs=DBUtils.executeLAPSQuery("comprdlisthelp^" + strShortCode);
//while (rs1.next())
//{
//arryCol=new ArrayList();
//arryCol.add(rs1.getString("prdcode"));
//arryCol.add(rs1.getString("category"));
//arryCol.add(rs1.getString("subcategory"));
//arryCol.add(rs1.getString("rangefrom"));
//arryCol.add(rs1.getString("rangeto"));
//arryCol.add(rs1.getString("term"));
//arryCol.add(rs1.getString("class"));
//arryCol.add(rs1.getString("loanratio"));
//arryCol.add(rs1.getString("intrest"));
//arryCol.add(rs1.getString("prd_type"));
//arryCol.add(rs1.getString("prd_inttype"));
//arryRow.add(arryCol);
//}
//rs1.close();
//}
//}
//}
//hshResult.put("arryRow",arryRow);
//}
//catch(Exception ce)
//{
//throw new EJBException("Error in closing getData"+ce.getMessage());
//}
//finally
//{
//try
//{
//if(rs!=null)
//{
//rs.close();
//}
//			 
//}
//catch(Exception e)
//{
//throw new EJBException("Error in closing Connection "+e.getMessage());
//}
//}
//return hshResult;
//}