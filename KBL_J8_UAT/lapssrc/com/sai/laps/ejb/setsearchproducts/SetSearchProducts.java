package com.sai.laps.ejb.setsearchproducts;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.FinacleBean.FinacleInterfaceBean;

import org.apache.log4j.Logger;


import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "SetSearchProducts", mappedName = "SetSearchProductsHome")
@Remote (SetSearchProductsRemote.class)
public class SetSearchProducts extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6582346661838828322L;


	static Logger log=Logger.getLogger(SetSearchProducts.class);	


	/**
	 * 
	 */
	

	public HashMap getData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strQuery = "";
		String strPrdType = "";
		String strprdTerm = "";
		String strPrdSave = "";
		String strPrdSelect = "";
		String strPrdRange = "";
		String strPrdTo = "";
		String strPrdCat = "";
		String strChoose = "";
		//String strCond = "";
		String strProductType = "";
		String strProdavail="";
		try {

			strPrdType = correctNull((String) hshRequestValues.get("hidprd_type"));
			strprdTerm = correctNull((String) hshRequestValues.get("hidprd_term"));
			strPrdSave = correctNull((String) hshRequestValues.get("hidprd_save"));
			strPrdSelect = correctNull((String) hshRequestValues.get("hidprd_select"));
			strPrdCat = correctNull((String) hshRequestValues.get("hidprd_cat"));
			strPrdRange = correctNull((String) hshRequestValues.get("textrng"));
			strPrdTo = correctNull((String) hshRequestValues.get("textto"));
			strChoose = correctNull((String) hshRequestValues.get("prd_choose"));
			strProductType = correctNull((String) hshRequestValues.get("hid_producttype"));
			strProdavail = correctNull((String) hshRequestValues.get("hid_prodavail"));

			if (strPrdType.equals("")) {
				strPrdType = "%";
			}
			
			if (strProductType.equals("")) {
				strProductType = "%";
			}
			if (strprdTerm.equals("")) {
				strprdTerm = "%";
			}
			if (strPrdSave.equals("")) {
				strPrdSave = "%";
			}
			if (strPrdRange.equals("")) {
				strPrdRange = "%";
			}
			if (strPrdTo.equals("")) {
				strPrdTo = "%";
			}
			if (strPrdCat.equals("")) {
				strPrdCat = "%";

			}
			if(strProdavail.equals("")){
				strProdavail="n";
			}

			hshRecord = new HashMap();
			if (!strPrdSelect.equals("")) {
				if (strChoose.equals("Existing")) {
					strQuery = SQLParser.getSqlQuery("selectproducts^"
							+ strProductType + "^" + strprdTerm + "^"
							+ strPrdSave + "^" + strPrdCat + "^" + strPrdRange
							+ "^" + strPrdTo+"^"+strProdavail+"^n");
				} else {
					strQuery = SQLParser.getSqlQuery("selectproducts^"
							+ strProductType + "^" + strprdTerm + "^"
							+ strPrdSave + "^" + strPrdCat + "^" + strPrdRange
							+ "^" + strPrdTo+"^"+strProdavail+"^y");
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arryCol = new ArrayList();
					arryCol.add(rs.getString(1));
					arryCol.add(rs.getString(2));
					arryCol.add(rs.getString(3));
					arryCol.add(rs.getString(4));
					arryCol.add(rs.getString(5));
					arryCol.add(rs.getString(6));
					arryCol.add(rs.getString(7));
					arryCol.add(rs.getString(8));
					arryCol.add(correctNull(rs.getString(9)).equals("n")?"Yes":"No");
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow", arryRow);
			}

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
}
