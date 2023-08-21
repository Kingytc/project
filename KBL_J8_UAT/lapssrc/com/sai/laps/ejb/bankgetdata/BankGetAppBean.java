package com.sai.laps.ejb.bankgetdata;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "BankGetAppBean", mappedName = "BankGetAppHome")
@Remote (BankGetAppRemote.class)
public class BankGetAppBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public  HashMap getBankData(HashMap hshValues) 
	{
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			double fundexist=0.00;
			double fundprop=0.00;
			double nonfundexist=0.00;
			double nonfundprop=0.00;
			double bobfundexist=0.00;
			double bobfundprop=0.00;
			double bobnonfundexist=0.00;
			double bobnonfundprop=0.00;
			double dblBobSh1=0.00;
			double dblBobSh2=0.00;
			double dblBobSh3=0.00;
			double dblBobSh4=0.00;
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			strQuery = SQLParser.getSqlQuery("comtotalsel^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("fundexist",Helper.correctDouble(rs.getString(1)));
				hshRecord.put("fundprop",Helper.correctDouble(rs.getString(2)));			
				hshRecord.put("nonfundexist",Helper.correctDouble(rs.getString(3)));
				hshRecord.put("nonfundprop",Helper.correctDouble(rs.getString(4)));
			}
			else
			{
				hshRecord.put("fundexist","0.00");
				hshRecord.put("fundprop","0.00");			
				hshRecord.put("nonfundexist","0.00");
				hshRecord.put("nonfundprop","0.00");
			}
			strQuery1 = SQLParser.getSqlQuery("comfundtotal^"+appno);			
			rs1 = DBUtils.executeQuery(strQuery1);
			if (rs1.next())
			{
				hshRecord.put("Bobfundexist",Helper.correctDouble(rs1.getString(1)));
				hshRecord.put("Bobfundprop",Helper.correctDouble(rs1.getString(2)));
				String strTemp1=correctNull(rs1.getString(1));
				if (!strTemp1.trim().equals(""))
				{
					bobfundexist=Double.parseDouble((String)rs1.getString(1));
				}
				else
				{
					bobfundexist=0.00;
				}
				String strTemp2=correctNull(rs1.getString(2));
				if (!strTemp2.trim().equals(""))
				{
					bobfundprop=Double.parseDouble((String)rs1.getString(2));
				}
				else
				{
					bobfundprop=0.00;
				}			
			}			
			strQuery2 = SQLParser.getSqlQuery("comnonfundtotal^"+appno);
			rs2 = DBUtils.executeQuery(strQuery2);
			if (rs2.next())
			{
				hshRecord.put("Bobnonfundexist",Helper.correctDouble(rs2.getString(1)));
				hshRecord.put("Bobnonfundprop",Helper.correctDouble(rs2.getString(2)));
				String strTemp3=correctNull(rs2.getString(1));
				if (!strTemp3.trim().equals(""))
				{
					bobnonfundexist=Double.parseDouble((String)rs2.getString(1));
				}
				else
				{
					bobnonfundexist=0.00;
				}
				String strTemp4=correctNull(rs2.getString(2));
				if (!strTemp4.trim().equals(""))
				{
					bobnonfundprop=Double.parseDouble((String)rs2.getString(2));
				}
				else
				{
					bobnonfundprop=0.00;
				}
			}
			if (bobfundexist>0 && fundexist>0)
			{
				dblBobSh1= (bobfundexist/fundexist)*100;
			}
			else
			{
				dblBobSh1=0.00;
			}
			hshRecord.put("dblBobSh1",String.valueOf(jtn.format(dblBobSh1)));
			if (bobfundprop>0 && fundprop>0)
			{
				dblBobSh2= (bobfundprop/fundprop)*100;
			}
			else
			{
				dblBobSh2=0.00;
			}
			hshRecord.put("dblBobSh2",String.valueOf(jtn.format(dblBobSh2)));
			if (bobnonfundexist>0 && nonfundexist>0)
			{
				dblBobSh3= (bobnonfundexist/nonfundexist)*100;
			}
			else
			{
				dblBobSh3=0.00;
			}
			hshRecord.put("dblBobSh3",String.valueOf(jtn.format(dblBobSh3)));
			if (bobnonfundprop>0 && nonfundprop>0)
			{
				dblBobSh4= (bobnonfundprop/nonfundprop)*100;
			}
			else
			{
				dblBobSh4=0.00;
			}
			hshRecord.put("dblBobSh4",String.valueOf(jtn.format(dblBobSh4)));			
			strQuery3 = SQLParser.getSqlQuery("combankingselection^"+appno);			
			rs3 = DBUtils.executeQuery(strQuery3);
			while(rs3.next())
			{	
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs3.getString("combk_id")));
				String id="";
				id=correctNull(rs3.getString("combk_id"));
				double a=rs3.getDouble("combk_sharefundexist");//Double.parseDouble((String))
				vecVal.add(String.valueOf(a));
				double b=rs3.getDouble("combk_sharefundprop");
				vecVal.add(String.valueOf(b));
				double c=rs3.getDouble("combk_sharenonfundexist");
				vecVal.add(String.valueOf(c));
				double d=rs3.getDouble("combk_sharenonfundprop");
				vecVal.add(String.valueOf(d));				
				vecVal.add(Helper.correctDouble(rs3.getString("combk_lmtfundexist")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_lmtfundprop")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_lmtnonfundexist")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_lmtnonfundprop")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_osfundexist")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_osfundprop")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_osnonfundexist")));
				vecVal.add(Helper.correctDouble(rs3.getString("combk_osnonfundprop")));
				vecVal.add(Helper.correctNull(rs3.getString("combk_overdue")));
				vecVal.add(correctNull(rs3.getString("combk_type")));
				if(Helper.correctNull((String)rs3.getString("combk_date")).equals(""))
				{
					vecVal.add("01/01/1900");
					
				}
				else
				{
					vecVal.add(correctNull(rs3.getString("combk_date")));
				}
				vecVal.add(correctNull(rs3.getString("combk_bankname")));
				vecData.add(vecVal);							
			}	
			hshRecord.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}				
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4 != null)
				{
					rs4.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public  HashMap getTermData(HashMap hshValues) 
	{
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		double boblmtfundexist=0.00;
		double boblmtfundprop=0.00;
		double boblmtnonfundexist=0.00;
		double boblmtnonfundprop=0.00;
		
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("comtermfundtotal^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("BobLmtfundexist",Helper.correctNull(rs.getString(1)));
				hshRecord.put("BobLmtfundprop",Helper.correctNull(rs.getString(2)));
				String strTemp1=Helper.correctNull(rs.getString(1));
				if (!strTemp1.trim().equals(""))
				{
					boblmtfundexist=Double.parseDouble((String)rs.getString(1));
				}
				else
				{
					boblmtfundexist=0.00;
				}
				String strTemp2=Helper.correctNull(rs.getString(2));
				if (!strTemp2.trim().equals(""))
				{
					boblmtfundprop=Double.parseDouble((String)rs.getString(2));
				}
				else
				{
					boblmtfundprop=0.00;
				}
			}			
			strQuery1 = SQLParser.getSqlQuery("comtermnonfundtotal^"+appno);
			rs1 = DBUtils.executeQuery(strQuery1);
			if (rs1.next())
			{
				hshRecord.put("BobLmtnonfundexist",Helper.correctNull(rs1.getString(1)));
				hshRecord.put("BobLmtnonfundprop",Helper.correctNull(rs1.getString(2)));

				String strTemp3=Helper.correctNull(rs1.getString(1));
				if (!strTemp3.trim().equals(""))
				{
					boblmtnonfundexist=Double.parseDouble((String)rs1.getString(1));
				}
				else
				{
					boblmtnonfundexist=0.00;
				}
				String strTemp4=Helper.correctNull(rs1.getString(2));
				if (!strTemp4.trim().equals(""))
				{
					boblmtnonfundprop=Double.parseDouble((String)rs1.getString(2));
				}
				else
				{
					boblmtnonfundprop=0.00;
				}				
			}
			strQuery2 = SQLParser.getSqlQuery("combankingselectionFI^"+appno);
			rs2 = DBUtils.executeQuery(strQuery2);
			while(rs2.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("combk_id")));
				String id="";
				id=correctNull(rs2.getString("combk_id"));
				if( !rs2.getString("combk_date").equals("01/01/1900"))
				{
					vecVal.add(correctNull(rs2.getString("combk_date")));
					hshRecord.put("combk_date",correctNull(rs2.getString("combk_date")));
				}
				else
				{
					vecVal.add("");
				}	
				vecVal.add(Helper.correctDouble(rs2.getString("combk_sharefundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_sharefundprop")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_sharenonfundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_sharenonfundprop")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_lmtfundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_lmtfundprop")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_lmtnonfundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_lmtnonfundprop")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_osfundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_osfundprop")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_osnonfundexist")));
				vecVal.add(Helper.correctDouble(rs2.getString("combk_osnonfundprop")));
				vecVal.add(Helper.correctNull(rs2.getString("combk_overdue")));
				vecVal.add(correctNull(rs2.getString("combk_type")));
				vecVal.add(correctNull(rs2.getString("combk_bankname")));
				vecVal.add(correctNull(rs2.getString("combk_security")));
				vecVal.add(correctNull(rs2.getString("combk_excess")));
			 	vecData.add(vecVal);							
			}	
			hshRecord.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4 != null)
				{
					rs4.close();
				}
				if(rs5 != null)
				{
					rs5.close();
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