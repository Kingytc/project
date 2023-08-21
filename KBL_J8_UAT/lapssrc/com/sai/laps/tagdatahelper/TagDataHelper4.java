package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper4 extends BeanAdapter {
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(TagDataHelper4.class);
	private static final long serialVersionUID = 1L;

	/**
	 * Bean : SetglpOptionsBean
	 * 
	 * @param hshParamter
	 * @return
	 * @
	 */
	public HashMap getDataHelp(HashMap hshParamter)  {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCodes = new ArrayList();
		ArrayList vecValues = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("setglphelp");
			while (rs.next()) {
				vecCodes.add(correctNull(rs.getString("con_country")));
				vecValues.add(correctNull(rs.getString("con_currency")));
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
	 * Bean : ComformulaBean
	 * 
	 * @param hashtable
	 * @return
	 * @
	 */
	public HashMap getYearsData(HashMap hashtable)  {

		ResultSet resultset = null;
		ArrayList ArrayList = new ArrayList();
		HashMap hashtable1 = new HashMap();
		try {
			try {

				hashtable1 = new HashMap();
				String s3 = correctNull((String) hashtable.get("appno"));

				for (resultset = DBUtils.executeLAPSQuery("selfinacialyears^"
						+ s3); resultset.next(); ArrayList.add(resultset
						.getString(1)))
					;
				hashtable1.put("vecVal", ArrayList);
			} catch (Exception exception) {
				throw new EJBException("Error in getYearsData login  "
						+ exception.toString());
			}
		} finally {
			try {
				if (resultset != null) {
					resultset.close();
				}

			} catch (Exception exception2) {
				throw new EJBException(
						"Error closing the connection getYearsData "
								+ exception2.getMessage());
			}
		}
		return hashtable1;
	}

	/**
	 * Bean : ComformulaBean
	 * 
	 * @param hashtable
	 * @return
	 * @
	 */
	public HashMap ListFinData(HashMap hashtable)  {

		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		ArrayList arraylist = new ArrayList();
		try {
			try {

				String s3 = correctNull((String) hashtable.get("cmano"));
				
				ArrayList arraylist1;
				if(!s3.equalsIgnoreCase(""))
				{
					for (resultset = DBUtils.executeLAPSQuery("selfinrows^" + s3); resultset
							.next(); arraylist.add(arraylist1)) {
						arraylist1 = new ArrayList();
						arraylist1.add(correctNull(resultset.getString(1)));
						arraylist1.add(correctNull(resultset.getString(2)));
					}
				}
				hashtable1.put("arryRow", arraylist);
			} catch (Exception exception) {
				throw new EJBException("Error in getScoreModel ="
						+ exception.toString());
			}
		} finally {
			try {
				if (resultset != null) {
					resultset.close();
				}

			} catch (Exception exception2) {
				throw new EJBException("Error closing the connection "
						+ exception2.getMessage());
			}
		}
		return hashtable1;
	}

	/**
	 * Bean : SetProductsBean
	 * 
	 * @param hsh
	 * @return
	 * @
	 */
	public HashMap getDataHelp1(HashMap hsh)  {

		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", val = "", totalval = "", code = "",apptype="";
		try {
			val = correctNull((String) hsh.get("val"));
			str = (String) hsh.get("val");
			code = (String) hsh.get("code");
			apptype = (String) hsh.get("apptype");

			if (val.equals("fixed") || val.equals("floating") || val.equals("combo")) {

				rs = DBUtils.executeLAPSQuery("rulechoice^" + str + "^" + code+"^"+apptype);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("prdint_sno")));
					totalval = correctNull(rs.getString("prd_amtrangefrom"))
							+ "---"
							+ correctNull(rs.getString("prd_amtrangeto"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
			}

			else if (val.equals("fixedselect")) {

				rs = DBUtils.executeLAPSQuery("fixedselect");
				while (rs.next()) {

					arr.add(correctNull(rs.getString("int_intvalue")) + "^"
							+ correctNull(rs.getString("int_intid")));
					totalval = correctNull(rs.getString("int_intdesc"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
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
		log.info("the val is " + hshValues);
		return hshValues;
	}
	public HashMap getInterestData(HashMap hsh)  {

		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arrInterestValues = new ArrayList();
		ArrayList arrInterestDescription = new ArrayList();
		try 
		{			
				rs = DBUtils.executeLAPSQuery("fixedselect");
				while (rs.next()) 
				{
					arrInterestValues.add(correctNull(rs.getString("int_intid"))+"|"+correctNull(rs.getString("int_intvalue")));
					arrInterestDescription.add(correctNull(rs.getString("int_intdesc")));
				}
				hshValues.put("arrVal", arrInterestValues);
				hshValues.put("arrValdesc", arrInterestDescription);
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
		log.info("the val is " + hshValues);
		return hshValues;
	}
	
	public  static String inslogStatus(String pagename,String username,String appno)throws Exception
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrEditLock=new ArrayList();
		ResultSet rsCheck=null;
		ResultSet rsCheck1=null;
		String  strValue="";
		
		try
		{
			hshQueryValues.put("size","1");
			arrEditLock.add(username);
			hshQuery.put("arrValues", arrEditLock);
			hshQuery.put("strQueryId","updlogstatus");
			hshQueryValues.put("1", hshQuery);
			hshQuery = new HashMap();
			arrEditLock = new ArrayList();
			rsCheck = DBUtils.executeLAPSQuery("seluserpage^" + pagename +"^"+appno); 
			if(rsCheck.next())
			{	
				hshQueryValues.put("size","2");
				arrEditLock.add("Y");
				arrEditLock.add(username);
				arrEditLock.add(appno);
				arrEditLock.add(pagename);
				hshQuery.put("arrValues", arrEditLock);
				hshQuery.put("strQueryId","insappref");
				hshQueryValues.put("2", hshQuery);
			}
			else
			{
				strValue="Locked";
			}
			if (rsCheck != null) {
				rsCheck.close();
			}
			rsCheck1 = DBUtils.executeLAPSQuery("seluserpage1^" + pagename +"^"+username+"^"+appno); 
			if(rsCheck1.next())
			{
				hshQueryValues.put("size","2");
				arrEditLock.add("Y");
				arrEditLock.add(username);
				arrEditLock.add(appno);
				arrEditLock.add(pagename);
				hshQuery.put("arrValues", arrEditLock);
				hshQuery.put("strQueryId","insappref");
				hshQueryValues.put("2", hshQuery);
				strValue="";
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		catch (Exception e) {
			throw new EJBException(e.getMessage());}
		finally {
			try {
				if (rsCheck != null) {
					rsCheck.close();
					rsCheck = null;
				}
			} catch (Exception e) {
				throw new EJBException(
						"Error in closing Connection"
								+ e.getMessage());
			}
		}
		return strValue;
	}
	
	/**
	 * Bean : ssidemographicsBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getNames(HashMap hshRequestValues)  {

		// calling from taglib Tag

		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr2 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		String appno1 = Helper.correctNull((String) hshRequestValues
				.get("appno1"));
		String prinid = Helper.correctNull((String) hshRequestValues
				.get("prinid"));
		try {

			if ((prinid == "") || (prinid == null))
				strQuery = SQLParser.getSqlQuery("selnames^" + appno1);
			else
				strQuery = SQLParser.getSqlQuery("selnamestype^" + appno1 + "^"
						+ prinid);

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arr.add(Helper.correctNull(rs.getString("ssi_prinfname")));
				arr1.add(Helper.correctNull(rs.getString("ssi_prinlname")));
				arr2.add(Helper.correctNull(rs.getString("ssi_prinmname")));
				arr3.add(Helper.correctNull(rs.getString("ssi_prinid")));

			}
			hshRecord.put("arrFNames", arr);
			hshRecord.put("arrLNames", arr1);
			hshRecord.put("arrMNames", arr2);
			hshRecord.put("arrPrinid", arr3);

			// ////////////////////// Added by
			// Harini//////////////////////////////
			hshRecord.put("comapp_id", correctNull((String) hshRequestValues
					.get("comapp_id")));
			hshRecord.put("hidPageType", correctNull((String) hshRequestValues
					.get("hidPageType")));
			hshRecord.put("hidCategoryType",
					correctNull((String) hshRequestValues
							.get("hidCategoryType")));
			hshRecord.put("hidSSIType", correctNull((String) hshRequestValues
					.get("hidSSIType")));

			log.info("in bean F" + arr + "L" + arr1 + "M" + arr2
					+ "ID" + arr3);

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

	/**
	 * Bean : ExposureBean
	 * 
	 * @param hashtable
	 * @return
	 * @
	 */
	public HashMap showGroup(HashMap hashtable)  {

		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		ArrayList arry = new ArrayList();
		ArrayList arry1 = new ArrayList();

		try {

			resultset = DBUtils.executeLAPSQuery("showgrouplist^" + "Group");
			while (resultset.next()) {
				arry.add(resultset.getString(1));
				arry1.add(resultset.getString(2));
			}
			hashtable1.put("arry", arry);
			hashtable1.put("arry1", arry1);
		} catch (Exception exception) {
			throw new EJBException("Error in getgrouplist  "
					+ exception.toString());
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

	/**
	 * Bean : SetGroupLimitsBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getGroupLimitListData(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrValues = null;
		try {

			rs = DBUtils.executeLAPSQuery("selgrouplimits");
			hshRecord = new HashMap();
			while (rs.next()) {
				arrValues = new ArrayList();
				String strId = rs.getString("disc_grpid");
				String strName = rs.getString("disc_grpname");
				arrValues.add(strName);
				hshRecord.put(strId, arrValues);
			}

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
		// log.info("hshRecord-----"+hshRecord);
		return hshRecord;
	}

	/**
	 * Bean : SetGroupsBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		HashMap hshRecord = null;
		String strId = "", strName = "", strRights = "", strDiscreteId = "",strGrouplimitslist="";

		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();

		try {
			rs = DBUtils.executeLAPSQuery("setgroupssel");
			hshRecord = new HashMap();

			/*
			 * while(rs.next()) { arrValues=new ArrayList(); String
			 * strId=rs.getString("grp_id"); String
			 * strName=rs.getString("grp_name"); String
			 * strRights=rs.getString("grp_rights"); String
			 * strDiscreteId=rs.getString("grp_discreteid");
			 * 
			 * arrValues.add(strName); arrValues.add(strRights);
			 * arrValues.add(strDiscreteId); hshRecord.put(strId,arrValues); }
			 */

			// Modified By HAri -Start
			while (rs.next()) {
				strId = rs.getString("grp_id");
				strName = rs.getString("grp_name");
				strRights = rs.getString("grp_rights");
				strDiscreteId = rs.getString("grp_discreteid");
				strGrouplimitslist=Helper.correctNull(rs.getString("grouplimitslist"));
				vecRec = new ArrayList();
				vecRec.add(strId);
				vecRec.add(strName);
				vecRec.add(strRights);
				vecRec.add(strDiscreteId);
				vecRec.add(strGrouplimitslist);
				vecRec.add(correctNull((String)rs.getString("grp_accessfor")));
				vecVal.add(vecRec);

			}

			hshRecord.put("groups_data", vecVal);


			log.info("hshRecord.." + hshRecord);



			// Modified By HAri - End

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
	 * Bean : ExposureBean
	 * 
	 * @param hashtable
	 * @return
	 * @
	 */
	public HashMap showIndustry(HashMap hashtable)  {

		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		ArrayList arry = new ArrayList();
		ArrayList arr = null;

		try {

			resultset = DBUtils.executeLAPSQuery("showindustrylist");
			while (resultset.next()) {
				arr = new ArrayList();
				arr.add(correctNull((String) resultset.getString(1)));
				arr.add(correctNull((String) resultset.getString(2)));
				arry.add(arr);
			}
			hashtable1.put("arryRow", arry);
		} catch (Exception exception) {
			throw new EJBException("Error in getindustrylist  "
					+ exception.toString());
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

	/**
	 * Bean : IndustryMasterBean
	 * 
	 * @param hshRequestValues
	 * @return
	 * @
	 */
	public HashMap getIndustryData(HashMap hshRequestValues)
			 {
		log.info("getIndustryData");

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		boolean bState = false;
		HashMap hshRecord = new HashMap();
		try {

			hshRecord = new HashMap();
			String grpcode=correctNull((String)hshRequestValues.get("grpcode"));
			rs = DBUtils.executeLAPSQuery("selindustrynamebygrp^"+grpcode);
			bState = rs.next();
			if (!bState) {
				hshRecord.put("noData", "noData");
			} else {
				hshRecord.put("noData", "Data");
			}
			while (bState) {
				vecCol = new ArrayList();
				for (int i = 0; i < 5; i++) {
					vecCol.add(correctNull(rs.getString(i + 1)));
				}
				vecRow.add(vecCol);
				bState = rs.next();
			}
			hshRecord.put("vecRow", vecRow);
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
	public HashMap corpgetData(HashMap hsh)  {

		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", val = "", totalval = "", code = "",inttype="",apptype="";
		try {
			val = correctNull((String) hsh.get("val"));
			str = (String) hsh.get("val");
			code = (String) hsh.get("code");
			apptype = (String) hsh.get("apptype");
			inttype = correctNull((String) hsh.get("interesttype"));
			if (val.equals("fixed") || val.equals("floating")) {
				rs = DBUtils.executeLAPSQuery("corprulechoice^" + str + "^" + code+"^"+apptype);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("corpprdint_sno")));
					totalval = correctNull(rs.getString("corpprd_amtrangefrom"))
							+ "---"
							+ correctNull(rs.getString("corpprd_amtrangeto"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
			}
			else if (val.equals("fixedselect")) {
				rs = DBUtils.executeLAPSQuery("corpfixedselect^Y^N^" + inttype);
				while (rs.next()) {
					arr.add(correctNull(rs.getString("int_intvalue")) + "^"
							+ correctNull(rs.getString("int_intid")));
					totalval = correctNull(rs.getString("int_intdesc"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
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
	public HashMap getDatapreviousyr(HashMap hsh)  {

		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try 
		{			
				String ratingvalue=Helper.correctNull((String)hsh.get("selrating"));
				rs = DBUtils.executeLAPSQuery("sel_static_data_rating");
				while (rs.next()) 
				{
					arr.add(correctNull(rs.getString("RATING_CODE")));
					arr1.add(correctNull(rs.getString("RATING_DESC")));
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
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

}