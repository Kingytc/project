package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper3 extends BeanAdapter {
	static Logger log=Logger.getLogger(TagDataHelper3.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//static Logger log=Logger.getLogger(TagDataHelper3.class);

//	public HashMap getDataHelp(HashMap hsh)  {
//		String strQuery = "";
//		ResultSet rs = null;
//		HashMap hshvalues = new HashMap();
//		ArrayList arr = new ArrayList();
//		ArrayList arr1 = new ArrayList();
//		String str = "", cmano = "";
//		try {
//			str = correctNull((String) hsh.get("val"));
//			if (str.equals("rating") || str.equals("secrat")) {
//				cmano = correctNull((String) hsh.get("cmano"));
//				rs = DBUtils.executeLAPSQuery("ratechoice^" + cmano);
//				while (rs.next()) {
//					String totalval;
//					totalval = correctNull(rs.getString("rating_sno")) + "^"
//							+ correctNull(rs.getString("loan_amt_from")) + "^"
//							+ correctNull(rs.getString("loan_amt_to")) + "^"
//							+ correctNull(rs.getString("rating_industry_type"));
//					arr.add(totalval);
//					arr1.add(correctNull(rs.getString("rating_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			if (str.equals("module") || str.equals("secmodule")) {
//				String totalval;
//				String strValue = correctNull((String) hsh.get("rate"));
//				rs = DBUtils.executeLAPSQuery("modchoice^" + strValue);
//				while (rs.next()) {
//					totalval = correctNull(rs.getString("mod_sno")) + "^"
//							+ correctNull(rs.getString("mod_desc")) + "^"
//							+ correctNull(rs.getString("rating_sno"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("rating_desc")) + "^"
//							+ correctNull(rs.getString("mod_maxweight")) + "^"
//							+ correctNull(rs.getString("mod_access"));
//					arr.add(totalval);
//					arr1.add(correctNull(rs.getString("mod_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			if (str.equals("module_sec")) {
//				rs = DBUtils.executeLAPSQuery("modchoice");
//				while (rs.next()) {
//					arr.add(correctNull(rs.getString("mod_sno")));
//					arr1.add(correctNull(rs.getString("mod_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			str = str.trim();
//			if (str.equals("formula") || (str.equals("formula1"))) {
//				String formulatype = correctNull((String) hsh
//						.get("formulatype"));
//				cmano = correctNull((String) hsh.get("cmano"));
//				if (cmano.equals("")) {
//					cmano = "0";
//				}
//				if (!formulatype.equals("")) {
//					strQuery = SQLParser.getSqlQuery("formchoice^"
//							+ formulatype + "^" + cmano);
//				} else {
//					strQuery = SQLParser.getSqlQuery("formchoicesel^" + cmano);
//				}
//				rs = DBUtils.executeQuery(strQuery);
//				while (rs.next()) {
//					arr.add(correctNull(rs.getString("formula_no")));
//					arr1.add(correctNull(rs.getString("formula_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			if (str.equals("section") || str.equals("parsection")) {
//				String totalval;
//				String strValue = correctNull((String) hsh.get("mod"));
//				rs = DBUtils.executeLAPSQuery("modsecchoice^" + strValue);
//				while (rs.next()) {
//					totalval = correctNull(rs.getString("sect_modid")) + "^"
//							+ correctNull(rs.getString("mod_desc")) + "^"
//							+ correctNull(rs.getString("sect_sno"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("sect_desc")) + "^"
//							+ correctNull(rs.getString("sect_maxcompparam"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("sect_relparam")) + "^"
//							+ correctNull(rs.getString("sect_maxweight"));
//					totalval = totalval
//							+ "^"
//							+ correctNull(rs
//									.getString("sect_loantype_distinguish"))
//							+ "^"
//							+ correctNull(rs.getString("sect_wc_max_weight"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("sect_wc_compparam"))
//							+ "^"
//							+ correctNull(rs.getString("sect_wc_relparam"));
//
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("sect_tl_max_weight"))
//							+ "^"
//							+ correctNull(rs.getString("sect_tl_compparam"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("sect_tl_relparam"));
//					totalval = totalval + "^"
//							+ correctNull(rs.getString("rating_sno")) + "^"
//							+ correctNull(rs.getString("rating_desc"));
//					arr.add(totalval);
//					arr1.add(correctNull(rs.getString("sect_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			if (str.equals("param")) {
//				String strValue = correctNull((String) hsh.get("sec"));
//
//				rs = DBUtils.executeLAPSQuery("paramchoice^" + strValue);
//				while (rs.next()) {
//					String totalval = "";
//					totalval = correctNull(rs.getString("param_sno"));
//					arr.add(totalval);
//					arr1.add(correctNull(rs.getString("param_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//			if (str.equals("subparam")) {
//				String totalval;
//				String strValue = correctNull((String) hsh.get("par"));
//				rs = DBUtils.executeLAPSQuery("populate_sub^" + strValue);
//				while (rs.next()) {
//					totalval = correctNull(rs.getString("subparam_sno"));
//					arr.add(totalval);
//					arr1.add(correctNull(rs.getString("subparam_desc")));
//				}
//				hshvalues.put("arrVal", arr);
//				hshvalues.put("arrValdesc", arr1);
//			}
//		}
//		catch (Exception e) {
//			log.error("error occured" + e.toString());
//		}
//		finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//
//			} catch (Exception e1) {
//				log.error("error occured" + e1.toString());
//			}
//		}
//		return hshvalues;
//	}

	public HashMap getProData(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		ArrayList arr4 = new ArrayList();
		ArrayList arr5 = new ArrayList();
		String appno = "";
		
		try {
			appno = correctNull((String) hsh.get("appno"));
			strQuery=SQLParser.getSqlQuery("compromotertagselect^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arr.add(correctNull(rs.getString("com_compdtappno")));
				arr1.add(correctNull(rs.getString("com_oldlapsid")));
				arr3.add(correctNull(rs.getString("com_compdtfname")));
				//arr4.add(correctNull(rs.getString("com_compdtlname")));
				//arr5.add(correctNull(rs.getString("com_compdtmname")));
			}
			hshValues.put("arr", arr);
			hshValues.put("arr1", arr1);
			hshValues.put("arr3", arr3);
			hshValues.put("arr4", arr4);
			hshValues.put("arr5", arr5);
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
		return hshValues;
	}

	public HashMap getComFacilities(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ArrayList arrFacilities = new ArrayList();
		ArrayList arrFacilityId = new ArrayList();
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String) hshRequestValues.get("appno"));
		String strCattype=correctNull((String)hshRequestValues.get("cattype"));
		String strLoanType="";
		try {
			hshRecord = new HashMap();
			/*if(strCattype.equalsIgnoreCase("OPS"))
			{
				rs = DBUtils.executeLAPSQuery("selOPSBorrowerFacilities^" + appno);
			}
			else
			{*/
			rs	= DBUtils.executeLAPSQuery("sel_appstatus^"+appno);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
				strLoanType=strLoanType.toLowerCase();
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(strLoanType.equalsIgnoreCase("A")||strLoanType.equalsIgnoreCase("C"))
			{
				rs = DBUtils.executeLAPSQuery("sel_facilitydescandsno^" + appno+"^"+strLoanType);
				//}
				while (rs.next()) {
					arrFacilityId.add(correctNull(rs.getString("facility_sno")));
					//+ "^"
						//	+ rs.getString(3)));
					arrFacilities.add(correctNull(rs.getString("com_facdesc")));
				}
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("selProductterms^" + appno);
				while (rs.next()) {
					arrFacilityId.add(correctNull(rs.getString("app_prdcode")));
					arrFacilities.add(correctNull(rs.getString("terms_desc")));
				}
			}
			hshRecord.put("arrFacilities", arrFacilities);
			hshRecord.put("arrFacilityId", arrFacilityId);
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
	
	public HashMap getComFacilities1(HashMap hshRequestValues)
	 {
ResultSet rs = null;
ArrayList arrFacilities = new ArrayList();
ArrayList arrFacilityId = new ArrayList();
HashMap hshRecord = new HashMap();
String appno = correctNull((String) hshRequestValues.get("appno"));
String strCattype=correctNull((String)hshRequestValues.get("cattype"));
try {
	hshRecord = new HashMap();
	if(strCattype.equalsIgnoreCase("OPS"))
	{
		rs = DBUtils.executeLAPSQuery("selOPSBorrowerFacilities^" + appno);
	}
	else
	{
		rs = DBUtils.executeLAPSQuery("selBorrowerFacilities^" + appno);
	}
	while (rs.next()) {
		arrFacilityId.add(correctNull(rs.getString(1))+ "^"+ correctNull(rs.getString(3)));
		arrFacilities.add(correctNull(rs.getString(2) + " - "
				+ rs.getString(4)));
	}
	hshRecord.put("arrFacilities", arrFacilities);
	hshRecord.put("arrFacilityId", arrFacilityId);
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

	public HashMap getDefData(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("rbidefaultselectall");
			while (rs.next()) {
				arr.add(correctNull(rs.getString("PRTY")));
				arr1.add(correctNull(rs.getString("SNO")));
			}
			hshValues.put("arr", arr);
			hshValues.put("arr1", arr1);
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
				log.error("error occured 333333333" + e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getParentName(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		int flag = 0;
		int flags = 0;
		int flagb = 0;
		String crpno = "";
		String zonno = "";
		String regno = "";
		String brnno = "";

		String crpname = "";
		String zonname = "";
		String regname = "";
		String brnname = "";
		String CO = "", Zone = "", Region = "", Branch = "";
		HashMap hshResult = new HashMap();
		String appno = correctNull((String) hshValues.get("appno"));
		String bid = "0";
		bid = correctNull((String) hshValues.get("bid"));
		appno = appno.trim();
		String strAppno = "000000000000000";
		try
		{
			String strflag="false";
			
			if (!appno.equals(""))
			{
				strflag="true";
				strQuery = SQLParser.getSqlQuery("selorgno^" + appno);
			} 
			else if(!bid.equalsIgnoreCase(""))
			{
				strflag="true";
				strQuery = SQLParser.getSqlQuery("selorgwithborrower^" + bid);
			}
			
			if(strflag.equalsIgnoreCase("true"))
			{
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					strAppno = correctNull(rs.getString(1));
				}
				crpno = strAppno.substring(0, 3) + "000000000000";
				zonno = strAppno.substring(0, 6) + "000000000";
				regno = strAppno.substring(0, 9) + "000000";
				brnno = strAppno.substring(0, 12) + "000";
	
				if (zonno.equals(crpno)) {
					flag = 1;
				} else {
					flag = 0;
				}
				if (regno.equals(zonno)) {
					flags = 1;
				} else {
					flags = 0;
				}
				if (brnno.equals(regno)) {
					flagb = 1;
				} else {
					flagb = 0;
				}
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("selorgname^" + crpno);
				while (rs.next()) {
					crpname = correctNull(rs.getString("org_name"));
				}
				if (flag == 0) {
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("selorgname^" + zonno);
					while (rs.next()) {
						zonname = correctNull(rs.getString("org_name"));
					}
				}
				if (flags == 0) {
	
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("selorgname^" + regno);
					while (rs.next()) {
						regname = correctNull(rs.getString("org_name"));
					}
				}
				if (flagb == 0) {
	
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("selorgname^" + brnno);
					while (rs.next()) {
						brnname = correctNull(rs.getString("org_name"));
					}
				}
				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("selOrgLabel");
				while (rs.next()) 
				{
					CO = correctNull(rs.getString("glp_orgname1"));
					Zone = correctNull(rs.getString("glp_orgname2"));
					Region = correctNull(rs.getString("glp_orgname3"));
					Branch = correctNull(rs.getString("glp_orgname4"));
				}
			}
				hshResult.put("crpname", crpname);
				hshResult.put("zonname", zonname);
				hshResult.put("regname", regname);
				hshResult.put("brnname", brnname);
				hshResult.put("CO", CO);
				hshResult.put("Zone", Zone);
				hshResult.put("Region", Region);
				hshResult.put("Branch", Branch);
			
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getParentName"
					+ ce.getMessage());
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

	public HashMap getDocList(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ArrayList vecData = new ArrayList();
		ArrayList vecRec = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		String moduleType=Helper.correctNull((String)hshValues.get("ModuleType"));
		String strSubType=" ",strQuery="";
		if(!Helper.correctNull((String)hshValues.get("strSubType")).equalsIgnoreCase(""))
			strSubType=Helper.correctNull((String)hshValues.get("strSubType"));
		try {

//			rs = DBUtils.executeLAPSQuery("prddoclist^"
//					+ hshValues.get("doc_type"));
//			while (rs.next()) {
//				vecRec = new ArrayList();
//				vecRec.add( correctNull(rs.getString("doc_code")));
//				vecRec.add( correctNull(rs.getString("doc_create_date")));
//				vecRec.add( correctNull(rs.getString("doc_desc")));
//				vecData.add(vecRec);
//				hshRecord.put("vecData", vecData);
//			}
			
			if(moduleType.equalsIgnoreCase("LAD"))
				moduleType="RET";
			
			strQuery=SQLParser.getSqlQuery("sel_doc_id^"+ hshValues.get("doc_type")+"^"+moduleType.toLowerCase()+"^"+strSubType);
			rs= DBUtils.executeQuery(strQuery);
			while(rs.next()){
			    vecRec1 = new ArrayList();
			    String activeflag=correctNull(rs.getString("STAT_DATA_ACTIVE"));
			    if(activeflag.equals("Y"))
			    {
				    vecRec1.add(correctNull(rs.getString("doc_id")));
				    vecRec1.add(correctNull(rs.getString("doc_createddate")));
				    vecRec1.add(correctNull(rs.getString("docdesc")));
				    vecData1.add(vecRec1);
			    }
				hshRecord.put("vecData1", vecData1);
			}
			
			
			
		} catch (Exception e) {
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

	public HashMap getDocumentChargesID(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		String strPrdCode = "";
		try {
			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("seldocumentchargeid^" + strPrdCode);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getDocumentChargesID login  "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException(
						"Error closing the connection getDocumentChargesID"
								+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getFacilityHead(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		HashMap hshRecord = new HashMap();
		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("selfacilityhead");
			while (rs.next()) {
				vecRec = new ArrayList();
				for (int i = 0; i < 2; i++) {
					vecRec.add(rs.getString(i + 1));
				}
				vecVal.add(vecRec);
			}
			hshRecord.put("vecVal", vecVal);
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

//	public HashMap getTagLibData(HashMap hshValues)  {
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecRec = new ArrayList();
//		try {
//			rs = DBUtils.executeLAPSQuery("selperglpopt");
//			while (rs.next()) {
//				vecRec = new ArrayList();
//				String strId = correctNull(rs.getString("perglp_id"));
//				vecRec.add(correctNull(rs.getString("perglp_desc")));
//				hshRecord.put(strId, vecRec);
//			}
//		} catch (Exception ce) {
//			throw new EJBException("Error in getData " + ce.toString());
//		} finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception cf) {
//				throw new EJBException("Error closing the connection "
//						+ cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public HashMap updatePostDisbursalDataCom(HashMap hsh)  {
//		ResultSet rs = null;
//		String strAppno = "";
//		ArrayList arrCom = new ArrayList();
//		HashMap hshRecord = new HashMap();
//		try {
//			strAppno = correctNull((String) hsh.get("appno"));
//			rs = DBUtils.executeLAPSQuery("postdisptagsel^" + strAppno);
//			while (rs.next()) {
//				arrCom.add(correctNull((String) rs.getString("post_date")));
//			}
//			hshRecord.put("arrCom", arrCom);
//		}
//		catch (Exception e) {
//			log.error("error occured" + e.toString());
//		}
//		finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception e1) {
//			}
//		}
//		return hshRecord;
//	}
	
//	public HashMap getTagLibBusRules(HashMap hshValues)  {
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecVal = new ArrayList();
//		ArrayList vecRec =new ArrayList();
//		try {
//			String strId="8";
//			rs = DBUtils.executeLAPSQuery("selclasslist^"+strId);
//			while (rs.next()) {
//				vecRec = new ArrayList();
//				vecRec.add(correctNull((String)rs.getString("stat_data_id")));
//				vecRec.add(correctNull((String)rs.getString("stat_data_desc")));
//				vecRec.add(correctNull((String)rs.getString("stat_data_desc1")));
//				vecVal.add(vecRec);
//			}
//			hshRecord.put("class_list", vecVal);
//		} catch (Exception ce) {
//			throw new EJBException("Error in getData " + ce.toString());
//		} finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception cf) {
//				throw new EJBException("Error closing the connection "
//						+ cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}
	public HashMap gettertiaryProData(HashMap hshValues)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arr1=new ArrayList();
		ArrayList arr2=new ArrayList();
		String strappno="";
		String strapptype="";String strdesc="";
		try
		{
			strapptype=correctNull((String) hshValues.get("strApptype"));
			strappno=correctNull((String) hshValues.get("appno"));
			if(strapptype.equalsIgnoreCase("N"))
			{
				strdesc=" and demo_apptype!='N'";
			}
			else
			{
				strdesc="";
			}
			
			String strQuery=SQLParser.getSqlQuery("sel_terpromoters^'"+strappno+"'"+strdesc);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arr1.add(correctNull(rs.getString("perapp_id")));
				arr2.add(correctNull(rs.getString("perapp_fname")));
			}
			hshRecord.put("arrVal", arr1);
			hshRecord.put("arrValdesc", arr2);
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in getData " + ae.toString());
		}
		finally 
		{
			try
			{
				if (rs != null)
				{
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		
		}
		return hshRecord;
	}
	
//	Added By Kamal
	public HashMap getADCFacilities(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList arrFacilities = new ArrayList();
		ArrayList arrFacilityId = new ArrayList();
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String) hshRequestValues.get("appno"));
		try 
		{
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("sel_adcfacilityforsanction^"+appno);
			while (rs.next())
			{
				arrFacilityId.add(correctNull(rs.getString(1)));
				arrFacilities.add(correctNull(rs.getString(3) + " - "+ rs.getString(4)));
			}
			hshRecord.put("arrFacilities", arrFacilities);
			hshRecord.put("arrFacilityId", arrFacilityId);
		}
		catch (Exception ce) 
		{
				throw new EJBException("Error in getADCFacilities login  " + ce.toString());
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
			throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
	}	
	return hshRecord;
	}
	//Added By Kamal
	public HashMap getADCFacilityName(HashMap hshValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();	
		
		try
		{	
			String appno= correctNull((String)hshValues.get("appno"));
			rs = DBUtils.executeLAPSQuery("sel_facilityforadhoc^"+appno);
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("adcfac_sno")));
				arrCol.add(correctNull(rs.getString("facility_catdesc")));
				arrCol.add(correctNull(rs.getString("adcfac_amount")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in TagDataHelper3 "+ce.toString());
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
	public HashMap getOrganisationCode(String appno)  {
		String strQuery="";
		ResultSet rs=null;
		String strAppOrgCode="";
		String strAppOrgLevel="";
		HashMap hshResult=new HashMap();
		try {
			if (!appno.equals("")) {
				strQuery = SQLParser.getSqlQuery("comseltorgcode^" + appno);
			} 
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strAppOrgCode = correctNull(rs.getString("org_code"));
				strAppOrgLevel = correctNull(rs.getString("org_level"));
			}
			hshResult.put("AppOrgCode",strAppOrgCode);
			hshResult.put("AppOrgLevel",strAppOrgLevel);
		} catch (Exception ce) {
			throw new EJBException("Error in closing getOrganisationCode"
					+ ce.getMessage());
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
	public String getRiskNonPoolFlag(String strAppno,String strUserDet)
	{
		String strRatingNonPoolFlag="";
		ResultSet rs=null;
		try
		{
			if(!strAppno.equalsIgnoreCase("")&&!strAppno.equalsIgnoreCase("new"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_cre_nonpoolflag^"+strAppno+"^"+strUserDet);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strRatingNonPoolFlag=Helper.correctNull((String)rs.getString("flag")); //Helper.correctNull((String)rs.getString("cre_nonpoolflag"));
				}
				else
				{
					strRatingNonPoolFlag="N";
				}
				if (rs != null) {
					rs.close();
				}
			}
		}
		 catch (Exception ce) {
				throw new EJBException("Error in closing getRiskNonPoolFlag"
						+ ce.getMessage());
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
		return strRatingNonPoolFlag;
	}
	//vindhya begin
	public HashMap getproductfacilitydesc(HashMap hshRequestValues)
	 {
		ResultSet rs = null;
		ArrayList arrFacilities = new ArrayList();
		ArrayList arrFacilityId = new ArrayList();
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String) hshRequestValues.get("appno"));
		String strCattype=correctNull((String)hshRequestValues.get("cattype"));
			String strLoanType="";
	try {
		hshRecord = new HashMap();
		/*if(strCattype.equalsIgnoreCase("OPS"))
		{
			rs = DBUtils.executeLAPSQuery("selOPSBorrowerFacilities^" + appno);
		}
		else
		{*/
		rs	= DBUtils.executeLAPSQuery("sel_appstatus^"+appno);
		if(rs.next())
		{
		strLoanType=Helper.correctNull((String)rs.getString("app_loantype"));
		strLoanType=strLoanType.toLowerCase();
	}
	if(rs !=null)
	{
		rs.close();
	}
	if(strLoanType.equalsIgnoreCase("A")||strLoanType.equalsIgnoreCase("C"))
	{
		rs = DBUtils.executeLAPSQuery("sel_facilitydescandsno^" + appno+"^"+strLoanType);
		//}
		while (rs.next()) {
			arrFacilityId.add(correctNull(rs.getString("facility_sno")));
			//+ "^"
				//	+ rs.getString(3)));
			arrFacilities.add(correctNull(rs.getString("com_facdesc")));
		}
	}
	else
	{
		rs = DBUtils.executeLAPSQuery("selProductterms^" + appno);
		while (rs.next()) {
			arrFacilityId.add(correctNull(rs.getString("app_prdcode")));
			arrFacilities.add(correctNull(rs.getString("terms_desc")));
		}
	}
	hshRecord.put("arrFacilities", arrFacilities);
	hshRecord.put("arrFacilityId", arrFacilityId);
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
	//vindhya end
	
}