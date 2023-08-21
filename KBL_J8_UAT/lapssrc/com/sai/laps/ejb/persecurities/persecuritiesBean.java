package com.sai.laps.ejb.persecurities;
 
import java.sql.ResultSet;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "persecuritiesBean", mappedName = "persecuritiesHome")
@Remote (persecuritiesRemote.class)
public class persecuritiesBean extends BeanAdapter
{		
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(persecuritiesBean.class);	

	private static final long serialVersionUID = 1L;

	public void updsecData(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction=null;
		String str_txtsecname="";			
		String  str_txtdempar="";
		String str_txtstandname="";			
		String  str_txtregfoliono ="";
		String  str_txtfacvalue="";
		String   str_txtqty ="";
		String  str_txtmetvalue="";
		double dTotal = 0.0;
		String str_dtotal="";
		String strAppno="";
		String strid="";
		try
		{
			strAction =correctNull((String)hshValues.get("hidAction"));
			strid=correctNull((String)hshValues.get("hid_sno"));
			strAppno=correctNull((String)hshValues.get("appno"));
			str_txtsecname = correctNull((String)hshValues.get("txtsecname"));		
			str_txtdempar = correctNull((String)hshValues.get("txtdempar"));			
			str_txtstandname = correctNull((String)hshValues.get("txtstandname"));
			str_txtregfoliono = correctNull((String)hshValues.get("txtregfoliono"));
			str_txtfacvalue= correctNull((String)hshValues.get("txtfacvalue"));
			str_txtqty= correctNull((String)hshValues.get("txtqty"));
			str_txtmetvalue= correctNull((String)hshValues.get("txtmetvalue"));
		  
			if (str_txtfacvalue.equals(""))
			{
				str_txtfacvalue = "0";
			}			
			str_txtqty = correctNull((String) hshValues.get("txtqty"));
			if (str_txtqty.equals(""))
			{
				str_txtqty = "0";
			}			
			str_txtmetvalue = correctNull((String) hshValues.get("txtmetvalue"));
			if (str_txtmetvalue.equals(""))
			{
				str_txtmetvalue = "0";
			}
			dTotal = Double.parseDouble(str_txtqty) * Double.parseDouble(str_txtmetvalue);
			str_dtotal=Helper.formatDoubleValue(dTotal);
			if(strAction.equals("insert"))
			{	
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Ins_sec_test");
				arrValues=new ArrayList();
				rs=DBUtils.executeLAPSQuery("Sel_MaxId_sec_test^"+strAppno);
				 
				if(rs.next())
				{
					strid = correctNull((String)rs.getString("maxid"));
				}
				arrValues.add(strid);				
				arrValues.add(strAppno);
				arrValues.add(str_txtsecname);
				arrValues.add(str_txtstandname);
				arrValues.add(str_txtdempar);
				arrValues.add( str_txtregfoliono);				 
				arrValues.add( str_txtfacvalue);
				arrValues.add(str_txtqty);
				arrValues.add(str_txtmetvalue);	
				arrValues.add(str_dtotal);	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Upd_sec_test");
				arrValues=new ArrayList();
				arrValues.add(str_txtsecname);
				arrValues.add(str_txtstandname);
				arrValues.add(str_txtdempar);
				arrValues.add( str_txtregfoliono);				 
				arrValues.add( str_txtfacvalue);
				arrValues.add(str_txtqty);
				arrValues.add(str_txtmetvalue);	
				arrValues.add(str_dtotal);	
				arrValues.add(strAppno);
				arrValues.add(strid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_sec_test");
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strid);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Name of the Security  =").append(correctNull((String )hshValues.get("txtsecname")))
			.append("~Demand Particulars DP Id & Client Id =").append(correctNull((String )hshValues.get("txtdempar"))).append("~Standing in the name of =").append(correctNull((String )hshValues.get("txtstandname")))
			.append("~Reg. Folio No =").append(correctNull((String )hshValues.get("txtregfoliono"))).append("~Face Value =").append(correctNull((String )hshValues.get("txtfacvalue")))
			.append("~Quantity =").append(correctNull((String )hshValues.get("txtqty"))).append("~Mkt. / Maturity Value/ NAV =").append(correctNull((String )hshValues.get("txtmetvalue")));
				
			AuditTrial.auditLog(hshValues,"40",strAppno,sbAuditTrial.toString());
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	
	public HashMap selsecData(HashMap hshRequestValues) 
	{
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecRow =new ArrayList();
		ArrayList vecData =new ArrayList();
		String strappid="";
		try
		{ 
			String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("sel_sec_test^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);		
			 		
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(rs.getString(1));
				vecRow.add(rs.getString(2));
				vecRow.add(rs.getString(3));
				vecRow.add(rs.getString(4));
				vecRow.add(rs.getString(5));
				vecRow.add(rs.getString(6));
				vecRow.add(rs.getString(7));
				vecRow.add(rs.getString(8));
				vecRow.add(rs.getString(9));
				vecData.add(vecRow);
			}
			hshRecord.put("vecData",vecData);	
			hshRecord.put("id1",strappid);				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getsecurityList "+ce.toString());
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
}	