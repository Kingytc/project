/*
 *@author: S.SATHYA MOORTHY 
 * @PURPOSE: FOR DYNAMIC REPORT.
 * 
 * 
 */

package com.sai.laps.ejb.agrstandardreport;

import java.sql.ResultSet;

import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "AgrStandardReportBean", mappedName = "AgrStandardReportHome")
@Remote (AgrStandardReportRemote.class)
public class AgrStandardReportBean extends BeanAdapter {
	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AgrStandardReportBean.class);	

	public HashMap getDetails(HashMap hashmap)
	{
		HashMap hshvalues=new HashMap();
		ResultSet rs=null;
		ArrayList vrow=new ArrayList();
		ArrayList vcol=new ArrayList();
		String prdtype=(String)hashmap.get("strProductType");
		
		try
		{
			String query1=SQLParser.getSqlQuery("AgrStandardReport1^"+prdtype);
			rs = DBUtils.executeQuery(query1);
			while(rs.next())
			{
				vcol=new ArrayList();
				vcol.add(correctNull((String)rs.getString("row_id")));
				vcol.add(correctNull((String)rs.getString("product_type")));
				vcol.add(correctNull((String)rs.getString("section_id")));
				vcol.add(correctNull((String)rs.getString("row_description")));
				vcol.add(correctNull((String)rs.getString("row_heading")));
				vcol.add(correctNull((String)rs.getString("display_order")));				
				vrow.add(vcol);
			}
			hshvalues.put("reportvalues",vrow);		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in AgrstandardReportBean   "+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)rs.close();
			}
			catch(Exception e)
			{
				
			}
		}
		return hshvalues;
	}
}
