package com.sai.laps.ejb.setsearchproductscorporate;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.setsearchproducts.SetSearchProducts;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "setsearchproductscorporateBean", mappedName = "setsearchproductscorporateHome")
@Remote (setsearchproductscorporateRemote.class)
public class setsearchproductscorporateBean extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	static Logger log=Logger.getLogger(setsearchproductscorporateBean.class);
	public setsearchproductscorporateBean()
	{}
	public HashMap getData(HashMap hshRequestValues)  {
 		ResultSet rs = null; 
		ResultSet rs1 = null; 
		HashMap hshRecord = null;
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strQuery = "";
		String strPrdType = "";
		String strfacid ="";
		String strfaccode = "";
		String strfachead = "",strPrdSave="",strprdTerm="",strPrdSelect="";
		String strsubfac = "";
		String strPrdRange = "";
		String strPrdTo = "";
		String strhead = "";
		String strsub = "";
		String newfachead  = "";
		String newfacsub  = "";
		String strPrdCat = "";
		String strChoose = "";
		String strCond = "";
		String strProductType = "";
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
			
			strfacid = correctNull((String) hshRequestValues.get("hidcorp_facid"));
			strfaccode = correctNull((String) hshRequestValues.get("hidcorp_faccode"));
			strfachead = correctNull((String) hshRequestValues.get("hidcorp_headname"));
			strsubfac = correctNull((String) hshRequestValues.get("hidcorp_subfac"));
			
			strPrdRange = correctNull((String) hshRequestValues.get("prd_rng_from"));
			strPrdTo = correctNull((String) hshRequestValues.get("prd_rng_to"));
			String strModType = correctNull((String) hshRequestValues.get("hidModType"));

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
			hshRecord = new HashMap();
			if (!strPrdSelect.equals("")) {
				if (strChoose.equals("Existing")) {
					strQuery = SQLParser.getSqlQuery("selectcorporateproducts^"+strPrdSave+"^"+strModType);
					
				} else {
					strQuery = SQLParser.getSqlQuery("selectcorporateproducts^"+strPrdSave+"^"+strModType);
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arryCol = new ArrayList();
					arryCol.add(rs.getString(1));
					arryCol.add(rs.getString(2));
//					arryCol.add(rs.getString(3));
					strhead = correctNull(rs.getString(3));
					strsub = correctNull(rs.getString(4));
					arryCol.add(rs.getString(5));
					arryCol.add(rs.getString(6));
					arryCol.add(rs.getString(7));
					if(!strhead.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selfacilitydesc^"+strhead);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							 newfachead = correctNull((String) rs1
									.getString("facility_catdesc"));
						}
						arryCol.add(newfachead);
					}
					
					if(!strsub.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selfacilitydesc^"+strsub);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							 newfacsub = correctNull((String) rs1
									.getString("facility_catdesc"));
						}
						arryCol.add(newfacsub);
					}
					//arryCol.add(rs.getString(4));
					//arryCol.add(rs.getString(5));
					//arryCol.add(rs.getString(6));
					//arryCol.add(rs.getString(7));
					//arryCol.add(rs.getString(8));
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow", arryRow);
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getData login  " + ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null)
				{
					rs.close();
				}
				arryRow=null;
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
}
}
