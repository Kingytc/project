 package com.sai.laps.ejb.agrlandInvestment;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "agrlandInvestBean", mappedName = "agrlandInvestHome")
@Remote (agrlandInvestRemote.class)
public class agrlandInvestBean extends BeanAdapter {

	static Logger log=Logger.getLogger(agrlandInvestBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void updateData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String[] txt_particulars = null;
		String[] txt_area = null;
		String[] txt_amount = null;
		String[] txt_estimated = null;
		
		int intUpdatesize = 0;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		
		try {
			String appno = Helper.correctNull((String) hshValues
					.get("strappno"));
			txt_particulars = (String[]) hshValues.get("txt_particulars");
			txt_area = (String[]) hshValues.get("txt_area");
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_estimated = (String[]) hshValues.get("txt_estimated");
		 

			if (strAction.equals("insert"))
			{
			hshQuery = new HashMap();
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("size", "1");
			hshQuery.put("strQueryId", "agrlandinvestment_del");
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
			intUpdatesize = 1;
			
			 
			for (int i = 0; i < txt_particulars.length; i++) {
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrlandinvestment_ins");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i));
				arrValues.add(Helper.correctNull((String) txt_particulars[i]));
				if(Helper.correctNull((String) txt_area[i]).equals(""))
				{
				 arrValues.add("0");
				}else
				{
				arrValues.add(Helper.correctNull((String) txt_area[i]));
				}
				if(Helper.correctNull((String) txt_amount[i]).equals(""))
				{
					arrValues.add("0");	
				}else
				{
				arrValues.add(Helper.correctNull((String) txt_amount[i]));
				}
				if(Helper.correctNull((String) txt_estimated[i]).equals(""))
				{
					arrValues.add("0");		
				}else
				{
				arrValues.add(Helper.correctNull((String) txt_estimated[i]));
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			}
			 
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("size", "2");
			 	hshQuery.put("strQueryId","agrlandinvestothers_del");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				if(Helper.correctNull((String)hshValues.get("txt_margin")).equals(""))
				{
					arrValues.add("0.00");
				}else
				{
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_margin")));
				}
				 
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agrlandinvestothers_ins");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	 
			
			if (strAction.equals("delete")) 
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "agrlandinvestment_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			
			 if (strAction.equals("delete")) 
			{
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "agrlandinvestothers_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			
		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}

	}

	public HashMap getData(HashMap hshValues)  {
  		HashMap hshRecord = new HashMap();
				
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery = "";
		ResultSet rs = null;
		try {
			String appno = Helper.correctNull((String) hshValues
					.get("strappno"));
			strQuery = SQLParser.getSqlQuery("agrlandinvestment_sel^" + appno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String) rs.getString("appno")));
				arrCol.add(correctNull((String) rs.getString("invt_id")));
				arrCol.add(correctNull((String) rs
						.getString("invt_particulars")));
				if(correctNull((String) rs.getString("invt_area")).equalsIgnoreCase("0"))
				{
					arrCol.add("");	
				}else
				{
					arrCol.add(correctNull((String) rs.getString("invt_area")));
				}
				
				if(correctNull((String)rs.getString("invt_amount_per_acre")).equalsIgnoreCase("0"))
				{
					arrCol.add("");	
				}else
				{
				arrCol.add(correctNull((String) rs.getString("invt_amount_per_acre")));
				}
				/*if(correctNull((String) rs	.getString("invt_estimated_cost")).equalsIgnoreCase("0"))
				{
					arrCol.add("");	
				}else
				{*/
				arrCol.add(correctNull((String) rs.getString("invt_estimated_cost")));
				//}
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
			
			strQuery = SQLParser.getSqlQuery("agrlandinvestothers_sel^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
			hshRecord.put("margin",correctNull((String)rs.getString("margin")));	
			}
			 

		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getData "+ exp.toString()); 
			}
		}
		return hshRecord;
	}
}