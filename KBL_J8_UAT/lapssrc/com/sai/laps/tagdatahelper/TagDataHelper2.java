package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

import com.sai.laps.ejb.setorg.*;

public class TagDataHelper2 extends BeanAdapter {
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(TagDataHelper2.class);
	private static final long serialVersionUID = 1L;

	public HashMap getDataHelp(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String valsys = "";
		try {
			valsys = Helper.correctNull((String) hsh.get("valsys"));
			String strRegionalOffice=valsys;
			HashMap hshRo=new HashMap();
			hshRo.put("strRegionalOffice", strRegionalOffice);
			hshRo.put("strPage", "appsearch");
			strRegionalOffice=(String)EJBInvoker.executeStateLess("setorg",hshRo,"getRegionalOffice");
			valsys=strRegionalOffice;
			strQuery=SQLParser.getSqlQuery("orgcodesel^" + valsys);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2))+" - "+correctNull(rs.getString(3)));
			}
			hshvalues.put("arrVal", arr);
			hshvalues.put("arrValdesc", arr1);
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

	public HashMap getCoAppGuarantorType(HashMap hshRequestValues)  
	{
		ResultSet rs = null,rs2=null;
		HashMap hshRecord = new HashMap();
		String strAppno = correctNull((String) hshRequestValues.get("appno"));
		String strAppType = correctNull((String) hshRequestValues.get("applnt"));
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strQuery="",	oldappid="";
		try {
			if(!strAppno.equalsIgnoreCase("")){
			strQuery=SQLParser.getSqlQuery("getcoappguarantortype^" + strAppno
					+ "^" + strAppType);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) {
				arrCol = new ArrayList();
				String appid=correctNull(rs.getString(1));
				if(!appid.equalsIgnoreCase("") && false)
				{
					strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+appid);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
					oldappid=Helper.correctNull(rs2.getString("perapp_oldid")); 
					}
					strQuery= SQLParser.getSqlQuery("selrenewappid^"+oldappid);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						appid=Helper.correctNull(rs2.getString("perapp_id")); 
					}
				}
				arrCol.add(appid);
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
				arrRow.add(arrCol);
			}
			}
			hshRecord.put("arrRow", arrRow);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getCoAppGuarantorsecType(HashMap hshRequestValues)  
	{
		ResultSet rs = null,rs2=null;
		HashMap hshRecord = new HashMap();
		String strAppno = correctNull((String) hshRequestValues.get("appno"));
		String strAppType = correctNull((String) hshRequestValues.get("applnt"));
		String strPageType = correctNull((String) hshRequestValues.get("PageType"));
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol1 = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strQuery="",	oldappid="";
		try {
			strQuery=SQLParser.getSqlQuery("getcoappguarantortype^" + strAppno
					+ "^" + strAppType);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) {
				arrCol = new ArrayList();
				String appid=correctNull(rs.getString(1));
				if(!appid.equalsIgnoreCase(""))
				{
					strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+appid);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
					oldappid=Helper.correctNull(rs2.getString("perapp_oldid")); 
					}
				}
				arrCol1.add(oldappid);
				
				arrCol.add(oldappid);
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
				arrRow.add(arrCol);
			}
			
			if(strPageType.equalsIgnoreCase("GC"))
			{
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_groupconcerndetails^" + strAppno);
				while (rs.next()) 
				{
					if(!arrCol1.contains(correctNull(rs.getString("perapp_oldid"))))
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("perapp_oldid")));
						arrCol.add(correctNull(rs.getString("perapp_fname")));
						arrCol.add(correctNull(rs.getString("type")));
						arrCol.add("");
						arrRow.add(arrCol);
					}
				}
			}
			
			hshRecord.put("arrRow", arrRow);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getCoAppGuarantorType1(HashMap hshRequestValues)
	 {
ResultSet rs = null;
HashMap hshRecord = new HashMap();
String strAppno = correctNull((String) hshRequestValues.get("appno"));
String strAppType = correctNull((String) hshRequestValues.get("applnt"));
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
try {
	if(!strAppno.equalsIgnoreCase("")){
	rs = DBUtils.executeLAPSQuery("getcoappguarantortype^" + strAppno
			+ "^" + strAppType);
	while (rs.next()) {
		arrCol = new ArrayList();
		arrCol.add(correctNull(rs.getString(1)));
		arrCol.add(correctNull(rs.getString(2)));
		arrCol.add(correctNull(rs.getString(3)));
		arrCol.add(correctNull(rs.getString(4)));
		arrRow.add(arrCol);
	}
	}
	hshRecord.put("arrRow", arrRow);
} catch (Exception e) {
	throw new EJBException(e.getMessage());
} finally {
	try {
		if (rs != null) {
			rs.close();
		}
	} catch (Exception e1) {
		throw new EJBException(e1.getMessage());
	}
}
return hshRecord;
}

	public HashMap getDynamicFormula(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			String cmano = correctNull((String) hsh.get("cmano"));
			rs = DBUtils.executeLAPSQuery("selcomdynamicformula^" + cmano);
			while (rs.next()) {
				arr.add(correctNull(rs.getString("formula_rowid")));
				arr1.add(correctNull(rs.getString("formula_rowname")));
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
				log.error("error occured" + e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getComFinFormula(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			String cmano = correctNull((String) hsh.get("cmano"));
			if (cmano.trim().equals("0")) {
				rs = DBUtils.executeLAPSQuery("selcomfinformula1^" + cmano);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("formula_no")) + "^"
							+ correctNull(rs.getString("formula_type")) + "^"
							+ correctNull(rs.getString("formula")) + "^"
							+ correctNull(rs.getString("formula_compare"))
							+ "^" + correctNull(rs.getString("formula_for"))
							+ "^"
							+ correctNull(rs.getString("formula_ind_compare"))
							+ "^"
							+ correctNull(rs.getString("formula_ind_ratio"))
							+ "^" + correctNull(rs.getString("formula_others"))
							+ "^"
							+ correctNull(rs.getString("formula_others_Desc")));
					arr1.add(correctNull(rs.getString("formula_desc")));
				}
				hshValues.put("arr", arr);
				hshValues.put("arr1", arr1);
			} else {
				rs = DBUtils.executeLAPSQuery("selcomfinformula^" + cmano);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("formula_no")) + "^"
							+ correctNull(rs.getString("formula_type")) + "^"
							+ correctNull(rs.getString("formula")) + "^"
							+ correctNull(rs.getString("formula_compare"))
							+ "^" + correctNull(rs.getString("formula_for"))
							+ "^"
							+ correctNull(rs.getString("formula_rowname"))
							+ "^"
							+ correctNull(rs.getString("formula_ind_compare"))
							+ "^"
							+ correctNull(rs.getString("formula_ind_ratio"))
							+ "^" + correctNull(rs.getString("formula_others"))
							+ "^"
							+ correctNull(rs.getString("formula_others_Desc")));
					arr1.add(correctNull(rs.getString("formula_desc")));
				}
				hshValues.put("arr", arr);
				hshValues.put("arr1", arr1);
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
		return hshValues;
	}

	public HashMap getFormulaData(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String val = "";
		String strCategory = "";
		try {
			val = correctNull((String) hsh.get("cmano"));
			strCategory = correctNull((String)hsh.get("FormulaCategory"));
			strCategory = (strCategory.trim().equals(""))?"%%%":strCategory;
			rs = DBUtils.executeLAPSQuery("selectformula^" + val+"^"+strCategory);
			while (rs.next()) {
				arr.add(correctNull(rs.getString("formula_rowid")) + "::"
						+ correctNull(rs.getString("formula")) + "::"
						+ correctNull(rs.getString("formula_desc")) + "::"
						+ correctNull(rs.getString("formula_for")) + "::"
						+ correctNull(rs.getString("formula_shortcode")) + "::"
						+ correctNull(rs.getString("formula_cma_no")) + "::"
						+ correctNull(rs.getString("formula_for_type")));
				arr1.add(correctNull(rs.getString("formula_rowname")));
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
				log.error("error occured" + e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getApplicantList(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryCol = new ArrayList();
		ArrayList arryRow = new ArrayList();
		ArrayList arrcomappid = new ArrayList();
		ArrayList arrcomname = new ArrayList();
		ArrayList arrcomid = new ArrayList();
		ArrayList arrcomtype = new ArrayList();
		ArrayList arrindustryname = new ArrayList();
		String strQuery = "";
		String strComappid = "";
		String strComappname = "", absPosition = "";
		try {
			strComappid = correctNull((String) hshValues.get("comapp_id"));
			if (strComappid.trim().equalsIgnoreCase(""))
				strComappid = "%";
			strComappname = correctNull((String) hshValues
					.get("comapp_companyname"));
			if (strComappname.trim().equalsIgnoreCase(""))
				strComappname = "%";
			String strOrgShortCode = correctNull((String) hshValues
					.get("strOrgShortCode"));
			String strOrgSelect = correctNull((String) hshValues
					.get("strOrgSelect"));
			absPosition = correctNull((String) hshValues.get("hid_rowcount"));
			if (strOrgSelect.trim().equalsIgnoreCase(""))
				strOrgSelect = "%";
			if (strOrgShortCode.trim().equalsIgnoreCase(""))
				strOrgShortCode = "%";
			strQuery = SQLParser.getSqlQuery("comappmasterlist^" + strComappid
					+ "^" + strComappname + "^" + strOrgShortCode);
			rs = DBUtils.executeQuery(strQuery);
			rs.last();
			int RowCount = rs.getRow();
			rs.beforeFirst();
			if (RowCount != 0) {
				if (!absPosition.equals("0")) {
					if (Integer.parseInt(absPosition) > RowCount) {
						rs.absolute(RowCount);
					} else {
						rs.absolute(Integer.parseInt(absPosition));
					}
				}
			}
			while (rs.next()) {
				arrcomappid.add(rs.getString(1));
				arrcomname.add(rs.getString(2));
				arrcomid.add(correctNull(rs.getString(3)));
				arrcomtype.add(correctNull(rs.getString(4)));
				arrindustryname.add(correctNull(rs.getString(5)));
				arryCol = new ArrayList();
				arryCol.add(rs.getString("comapp_id"));
				arryCol.add(rs.getString("comapp_companyname"));
				arryCol.add(rs.getString("comapp_companyid"));
				arryCol.add(rs.getString("comapp_comtype"));
				arryCol.add(rs.getString("ind_name"));
				arryRow.add(arryCol);
			}
			hshRecord.put("arrcomappid", arrcomappid);
			hshRecord.put("arrcomname", arrcomname);
			hshRecord.put("arrcomid", arrcomid);
			hshRecord.put("arrcomtype", arrcomtype);
			hshRecord.put("arrindustryname", arrindustryname);
			hshRecord.put("hidPageType", correctNull((String) hshValues
					.get("hidPageType")));
			hshRecord.put("arryRow", arryRow);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection" + e1);
			}
		}
		return hshRecord;
	}

	public HashMap getOrgCode(HashMap hshOrgcode) {
		String strQuery = "";
		ResultSet rs = null;
		String strOrgCode = "";
		HashMap hshOrg = null;
		try {
			strOrgCode = correctNull((String) hshOrgcode.get("OrgCode"));
			hshOrg = new HashMap();
			strQuery=SQLParser.getSqlQuery("getorgcode^" + strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshOrg.put("OrgCode", correctNull(rs.getString(1)));
			} else {
				hshOrg.put("OrgCode", "");
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
		return hshOrg;
	}

	public HashMap getLimitCode(HashMap hsh)  {
		ResultSet rs = null;
		String totalval = "";
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		HashMap hshvalues = new HashMap();
		String strprdtype="";
		try {
			strprdtype=correctNull((String)hsh.get("prdtype"));
			rs = DBUtils.executeLAPSQuery("productcode^"+strprdtype);
			while (rs.next()) {
				totalval = //correctNull(rs.getString("prd_code")) + "---"
						 correctNull(rs.getString("prd_rng_from")) + "---"
						+ correctNull(rs.getString("prd_rng_to"));
				arr.add(totalval);
				arr1.add(correctNull(rs.getString("prd_code")));
			}
			hshvalues.put("arrVal", arr1);
			hshvalues.put("arrValdesc", arr);
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
		return hshvalues;
	}

	public HashMap getUsersHelp(HashMap hashtable)  {
		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		ArrayList ArrayList = new ArrayList();
		ArrayList ArrayList1 = new ArrayList();
		try {
			try {
				for (resultset = DBUtils.executeLAPSQuery("mailids"); resultset
						.next(); ArrayList1.add(correctNull(resultset.getString("username"))))
					ArrayList.add(correctNull(resultset.getString("usr_id")));
				hashtable1.put("vecCodes", ArrayList);
				hashtable1.put("vecValues", ArrayList1);
			} catch (Exception exception) {
				throw new EJBException("Error in getData "
						+ exception.toString());
			}
		} finally {
			try {
				if (resultset != null)
					resultset.close();
			} catch (Exception exception2) {
				throw new EJBException("Error closing the connection "
						+ exception2.getMessage());
			}
		}
		return hashtable1;
	}

	public HashMap getOrgList(HashMap hshRequestValues)  {
		String strQuery = "", scode = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr2 = new ArrayList();
		try {
			scode = Helper.correctNull((String) hshRequestValues.get("scode"));
			if (scode.equals("")) {
				strQuery = SQLParser.getSqlQuery("setorglist");
			} else {
				strQuery = SQLParser.getSqlQuery("setorglistcode");
			}
			rs = DBUtils.executeQuery(strQuery);
			hshRecord = new HashMap();
			while (rs.next()) {
				String strCode = rs.getString(1);
				String strName = rs.getString(2);
				hshRecord.put(strCode, strName);
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
				arr2.add(correctNull(rs.getString(3)));
			}
			hshRecord.put("arr", arr);
			hshRecord.put("arr1", arr1);
			hshRecord.put("arr2", arr2);
		} catch (Exception ce) {
			throw new EJBException("Error in getOrgList " + ce.toString());
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
	public HashMap getBranchList(HashMap hshRequestValues)  {
		String strQuery = "", scode = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			strQuery = SQLParser.getSqlQuery("setbranchlistcode");
			rs = DBUtils.executeQuery(strQuery);
			hshRecord = new HashMap();
			while (rs.next()) {
				String strCode = rs.getString(1);
				String strName = rs.getString(2);
				hshRecord.put(strCode, strName);
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshRecord.put("arr", arr);
			hshRecord.put("arr1", arr1);
		} catch (Exception ce) {
			throw new EJBException("Error in getBranchList " + ce.toString());
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
	public HashMap getAFOUsersList(HashMap hshRequestValues)  {
		String strQuery = "", scode = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			strQuery = SQLParser.getSqlQuery("setafouserslist");
			rs = DBUtils.executeQuery(strQuery);
			hshRecord = new HashMap();
			while (rs.next()) {
				String strCode = rs.getString(1);
				String strName = rs.getString(2);
				hshRecord.put(strCode, strName);
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshRecord.put("arr", arr);
			hshRecord.put("arr1", arr1);
		} catch (Exception ce) {
			throw new EJBException("Error in getAFOUsersList " + ce.toString());
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
	public HashMap getAFOClusterBranchTag(HashMap hshRequestValues)  {
		String strQuery = "", strUserID = "",strBranchCode="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String strTemp="";
		try {
			strUserID=Helper.correctNull((String)hshRequestValues.get("apptype"));
			
			strQuery = SQLParser.getSqlQuery("sel_setafobranchmaster^"+strUserID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBranchCode=Helper.correctNull(rs.getString("sbm_clusterbranchcode"));
				
				if(!strBranchCode.equalsIgnoreCase(""))
				{
					String strArr[]=strBranchCode.split("@");
					
					for(int i=0;i<strArr.length;i++)
					{
						if(strTemp.equalsIgnoreCase(""))
							strTemp="'"+strArr[i]+"'";
						else
							strTemp=strTemp+",'"+strArr[i]+"'";
					}
				}
				if(!strTemp.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selclusterorgnames^"+strTemp);
					rs1 = DBUtils.executeQuery(strQuery);
					hshRecord = new HashMap();
					while (rs1.next()) {
						String strCode = rs1.getString("org_code");
						String strName = rs1.getString("org_name");
						hshRecord.put(strCode, strName);
						arr.add(correctNull(rs1.getString(1)));
						arr1.add(correctNull(rs1.getString(2)));
					}
					hshRecord.put("arr", arr);
					hshRecord.put("arr1", arr1);
				}
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getAFOClusterBranchTag " + ce.toString());
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
	public HashMap getMCLRList(HashMap hshRequestValues)  {
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	
		String strQuery = "", strUserID = "",strBranchCode="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strTemp="";
		try {
			
			strQuery = SQLParser.getSqlQuery("sel_mclrmaster^<");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("description")));
				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD")))));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODE")));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODEOVERDRAFTS")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getMCLRList " + ce.toString());
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
	public HashMap getDevAssList (HashMap hshValues) {
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;

		try
		{
			rs=DBUtils.executeLAPSQuery("sel_PERM_ASSESSMENT_master");
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("PERM_TYPE_ID")));
				arrCol.add(Helper.correctNull((String)rs.getString("PERM_TYPE_DESCRIPTION")));
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getDevAssList "+ce.toString());
		}
		
		return hshRecord;
		
	}
	public HashMap getLeadGeneratedRegion (HashMap hshValues) {
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;

		try
		{
			rs=DBUtils.executeLAPSQuery("sel_LeadRegions");
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_SCODE")));
				arrCol.add(Helper.correctNull((String)rs.getString("ORG_NAME")));
				
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getLeadGeneratedRegion "+ce.toString());
		}
		
		return hshRecord;
		
	}
	
	public HashMap getMSMEOrgDetails(HashMap hshRequestValues)  {
		ResultSet rs = null,rs1=null;
		HashMap hshBankRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		try {
			hshBankRecord = new HashMap();
			arryRow = new ArrayList();
			arryCol = new ArrayList();
			String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("orglevel"));
			String strUsrOrgCode=Helper.correctNull((String)hshRequestValues.get("orgcode"));
			String strBranchOrgCode="",strLoanDisbBranch="";
			String strCLPUOrgCode="";
			String strRegionOrgCode="";
			String strHeadOfficeOrgCode="";
			
			String strQuery="";
			String strQuery1="",strOrgDept="";
			if(!(strAppno.equalsIgnoreCase("")))
			{
			rs = DBUtils.executeLAPSQuery("selMSMEOrgDetails^"+strAppno);
			if(rs.next())
			{
				strBranchOrgCode=Helper.correctNull((String)rs.getString("org_code"));
				strUsrOrgCode=Helper.correctNull((String)rs.getString("org_code"));
				strOrgLevel=Helper.correctNull((String)rs.getString("org_level"));
				strOrgDept=Helper.correctNull((String)rs.getString("msme_orgdept"));
			}
			
			String strProcessLevel="";
			if(rs!=null)
				rs.close();
			
			if(strOrgLevel.equalsIgnoreCase("A"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^M004");
			else if(strOrgLevel.equalsIgnoreCase("R"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M006");
			else if(strOrgLevel.equalsIgnoreCase("D"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M005");
			else if(strOrgLevel.equalsIgnoreCase("C") && !strOrgDept.equalsIgnoreCase(""))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M"+strOrgDept);
			else 
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M001");
		 	if(rs!=null)
		 		rs.close();
		 	rs = DBUtils.executeQuery(strQuery);
		 	if(rs.next())
		 	{
		 		strProcessLevel=Helper.correctNull(rs.getString("LOAN_PARAMVAL2"));
		 	}
			
		 	StringBuffer sb=new StringBuffer();
			if(strOrgLevel.equalsIgnoreCase("A"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,9);
				strCLPUOrgCode=strCLPUOrgCode+"000000";
				strRegionOrgCode=strUsrOrgCode.substring(0,6);
				strRegionOrgCode=strRegionOrgCode+"000000000";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				
				if(strProcessLevel.contains("C@") && !strHeadOfficeOrgCode.equalsIgnoreCase(""))
					sb.append(strHeadOfficeOrgCode).append(",");
				
				if(strProcessLevel.contains("R@") && !strRegionOrgCode.equalsIgnoreCase(""))
					sb.append(strRegionOrgCode).append(",");
				
				if(strProcessLevel.contains("D@") && !strCLPUOrgCode.equalsIgnoreCase(""))
					sb.append(strCLPUOrgCode).append(",");
				
				if(strProcessLevel.contains("A@") && !strBranchOrgCode.equalsIgnoreCase(""))
					sb.append(strBranchOrgCode).append(",");
				
				String strTemp="";
				if(sb.length()>1)
					strTemp=sb.substring(0, sb.length()-1);
				
				if(!strTemp.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strTemp+")"+" ";
				
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,9);
				strCLPUOrgCode=strCLPUOrgCode+"000000";
				strRegionOrgCode=strUsrOrgCode.substring(0,6);
				strRegionOrgCode=strRegionOrgCode+"000000000";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				
				if(strProcessLevel.contains("C@") && !strHeadOfficeOrgCode.equalsIgnoreCase(""))
					sb.append(strHeadOfficeOrgCode).append(",");
				
				if(strProcessLevel.contains("R@") && !strRegionOrgCode.equalsIgnoreCase(""))
					sb.append(strRegionOrgCode).append(",");
				
				if(strProcessLevel.contains("D@") && !strBranchOrgCode.equalsIgnoreCase(""))
					sb.append(strBranchOrgCode).append(",");
				
				
				String strTemp="";
				if(sb.length()>1)
					strTemp=sb.substring(0, sb.length()-1);
				
				if(!strTemp.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strTemp+")"+" ";
				
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,6);
				strCLPUOrgCode=strCLPUOrgCode+"%";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				
				if(strProcessLevel.contains("C@") && !strHeadOfficeOrgCode.equalsIgnoreCase(""))
					sb.append(strHeadOfficeOrgCode).append(",");
				
				if(strProcessLevel.contains("R@") && !strBranchOrgCode.equalsIgnoreCase(""))
					sb.append(strBranchOrgCode).append(",");
				
				
				String strTemp="";
				if(sb.length()>1)
					strTemp=sb.substring(0, sb.length()-1);
				
				if(!strTemp.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strTemp+")"+" ";
			}
			else if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strCLPUOrgCode=strBranchOrgCode.substring(0,6);
				
				if(strProcessLevel.contains("C@") && !strBranchOrgCode.equalsIgnoreCase(""))
					sb.append(strBranchOrgCode).append(",");
				
				String strTemp="";
				if(sb.length()>1)
					strTemp=sb.substring(0, sb.length()-1);
				
				if(!strTemp.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strTemp+")"+" ";
				
			}
			else
			{
				//No Function;
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(!strQuery1.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selbanklistorg^"+strQuery1);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(correctNull((String)rs.getString(1)));
					arryCol.add(correctNull((String)rs.getString(2)));
					arryCol.add(correctNull((String)rs.getString(3)));
					arryRow.add(arryCol);
				}
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(rs !=null)
			{
				rs.close();
			}
		}
		
			hshBankRecord.put("arryRow", arryRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getDataHelp login  "
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
		return hshBankRecord;
	}
public HashMap getMCLRListfbill(HashMap hshRequestValues)  {
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	
		String strQuery = "", strUserID = "",strBranchCode="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strTemp="";
		String fbilldate="";
		try {
			fbilldate = correctNull((String) hshRequestValues.get("fibilldate"));
			if(!(("").equalsIgnoreCase(fbilldate)))
			{
			strQuery = SQLParser.getSqlQuery("selonlyfbill^"+fbilldate);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("description")));
				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD")))));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODE")));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODEOVERDRAFTS")));
				arrRow.add(arrCol);
			}
			}
			hshRecord.put("arrRow", arrRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getMCLRList " + ce.toString());
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
	
}