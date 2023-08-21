package com.sai.laps.ejb.setuprate;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.setstatecity.SetStateCityBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "setuprateBean", mappedName = "setuprateHome")
@Remote (setuprateRemote.class)
public class setuprateBean extends BeanAdapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5133085769255398622L;
	static Logger log=Logger.getLogger(setuprateBean.class);
	/**
	 * 
	 */
	

//	public HashMap getRate(HashMap hshRequestValues)  {
//		ResultSet rs = null;
//		HashMap hshRecord = null;
//		String strQuery = "";
//
//		try {
//			hshRecord = new HashMap();
//			ArrayList vecRec1 = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("setupratehelp");
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next()) {
//
//				vecRec1.add(rs.getString(1));
//
//			}
//			hshRecord.put("vecRec1", vecRec1);
//		} catch (Exception ce) {
//			throw new EJBException("Error in getRate(taglib)---->>>>>  "
//					+ ce.toString());
//		} finally {
//			try {
//				if (rs != null)
//					rs.close();
//			} catch (Exception cf) {
//				throw new EJBException("Error closing the connection "
//						+ cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

	public HashMap getData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshValues = null;
		String strQuery = "", strValue = "";

		try {

			strValue = correctNull((String) hshRequestValues.get("code"));
			if(strValue.equalsIgnoreCase("")){
				strValue = correctNull((String) hshRequestValues.get("prdCode"));	
			}
			hshValues = new HashMap();
			ArrayList vecRec2 = new ArrayList();
			ArrayList vecData = new ArrayList();
			strQuery = SQLParser.getSqlQuery("setupsel2^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecRec2 = new ArrayList();
				vecRec2.add(rs.getString(1));
				vecRec2.add(rs.getString(2));
				vecRec2.add(rs.getString(3));

				vecData.add(vecRec2);

			}

			hshValues.put("vecData", vecData);

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

		return hshValues;
	}

	public void updateData(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = null;
		ArrayList arr = null;
		try {
			String strRangefrom[] = null;
			String strRangeto[] = null;
			String strRange[] = null;
			String strId;

			int intUpdatesize = 0;
			strRangefrom = (String[]) hshValues.get("fromamount");

			strRangeto = (String[]) hshValues.get("toamount");

			strRange = (String[]) hshValues.get("interest");

			strId = correctNull((String) hshValues.get("code"));
			
			if(strId.equalsIgnoreCase("")){
				strId = correctNull((String) hshValues.get("prdCode"));
			}

			intUpdatesize = 1;
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr = new ArrayList();
			arr.add((String) hshValues.get("code"));
			hshquery.put("strQueryId", "setupdelid");
			hshquery.put("arrValues", arr);
			hshqueryval.put("1", hshquery);
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			int num = 0;
			for (int k = 2; k < strRangefrom.length + 2; k++) {
				if (!strRangefrom[k - 2].equals("")) {
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshQuery.put("strQueryId", "setupins2");
					arrValues.add(strId);
					arrValues.add(Integer.toString(num));
					arrValues.add(correctNull(strRangefrom[k - 2]));
					arrValues.add(correctNull(strRangeto[k - 2]));
					arrValues.add(correctNull(strRange[k - 2]));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put(Integer.toString(k), hshQuery);

				}
			}
			EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");
			
			String strValue = correctNull((String) hshValues.get("code"));
			
			if(strValue.equalsIgnoreCase("")){
				strValue = correctNull((String) hshValues.get("prdCode"));
			}
			
			ArrayList vecRec2 = new ArrayList();
			ArrayList vecData = new ArrayList();
			strQuery = SQLParser.getSqlQuery("setupsel2^" + strValue);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecRec2 = new ArrayList();
				vecRec2.add(rs.getString(1));
				vecRec2.add(rs.getString(2));
				vecRec2.add(rs.getString(3));
				vecData.add(vecRec2);

			}

			hshValues.put("vecData", vecData);
			HashMap HashMap3 = new HashMap();
			HashMap3.put("prd_code", correctNull((String) hshValues.get("prdCode")));
			HashMap3.put("prdCode", correctNull((String) hshValues.get("prdCode")));
			  EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
		}

		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
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

//	private String getNewId() throws Exception {
//		ResultSet rs = null;
//		String strQuery = "";
//		int id = 0;
//		try {
//			strQuery = SQLParser.getSqlQuery("setupratemax");
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) {
//				if (rs.getString(1) == null) {
//					id = 0;
//				} else {
//					id = Integer.parseInt(correctNull(rs.getString(1)));
//				}
//			}
//
//			id++;
//		} catch (Exception ce) {
//			throw new EJBException("Error in getData login  " + ce.toString());
//		} finally {
//			try {
//				if (rs != null)
//					rs.close();
//			} catch (Exception cf) {
//				throw new Exception("Error closing the connection "
//						+ cf.getMessage());
//			}
//		}
//		return Integer.toString(id);
//	}

}