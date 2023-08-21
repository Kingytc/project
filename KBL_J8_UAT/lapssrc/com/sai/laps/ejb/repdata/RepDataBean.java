package com.sai.laps.ejb.repdata;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "RepDataBean", mappedName = "RepDataHome")
@Remote (RepDataRemote.class)
public class RepDataBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8976806296379693143L;
	/**
	 * 
	 */

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProfileNames"))
			{
				hshRecord =(HashMap)getProfileNames(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getProducts"))
			{
				hshRecord =(HashMap)getProducts(hshValues);
			} 
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
	private HashMap getProfileNames(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecBnkCode = new ArrayList();
 		ArrayList vecBnkName = new ArrayList();		
		String strUser=null;
		String strRepName=null;
		try
		{
			strUser=correctNull((String)hshPar.get("userid"));
			strRepName=correctNull((String)hshPar.get("repname"));
			strQuery = SQLParser.getSqlQuery("profilenames^"+strUser+"^"+strRepName);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
			vecBnkCode.add(correctNull(rs.getString("rep_profilename")));
			vecBnkName.add(correctNull(rs.getString("rep_profilename")));
			
			}
			hshRecord.put("vecCodes",vecBnkCode);
			hshRecord.put("vecValues",vecBnkName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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

	private HashMap getProducts(HashMap hshPar) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = null;
		ArrayList vecProdCode = new ArrayList();
 		ArrayList vecProdName = new ArrayList();		
		String strProdType=null;

		try
		{
			strProdType=correctNull((String)hshPar.get("prodtype"));
			strQuery = SQLParser.getSqlQuery("productcat^"+strProdType);
			rs =DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				 vecProdCode.add(correctNull(rs.getString("cat_id")));
				 vecProdName.add(correctNull(rs.getString("cat_name")));	
			}
									
			hshRecord.put("vecCodes",vecProdCode);
			hshRecord.put("vecValues",vecProdName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
	
	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction =null;
		String strRepName =null;
		String strProfileName=null;
		String strUser=null;
		String strParam =null;
		String txtfromamt=null;
		String txttoamt=null;
		int count=0;
		HashMap hshCount = new HashMap();
		

		try
		{	strAction = correctNull((String)hshValues.get("hidAction"));	
			strUser= correctNull((String)hshValues.get("userid"));
			strRepName = correctNull((String)hshValues.get("repname"));
			strProfileName = (String)hshValues.get("txtprofile_name");
			strParam = (String)hshValues.get("hidParam");
			txtfromamt =correctNull((String)hshValues.get("txtfromamt"));
			txttoamt =correctNull((String)hshValues.get("txttoamt"));
			if (strAction.equalsIgnoreCase("Insert"))
			{
				hshCount = (HashMap)getParameter(hshValues);
				count =Integer.parseInt((String)hshCount.get("count"));
				hshQueryValues.put("size","1");
				if((!txtfromamt.equalsIgnoreCase(""))&&(!txttoamt.equalsIgnoreCase("")))
				{
				hshQuery.put("strQueryId","InsertRepParam");
				arrValues = new ArrayList();
				arrValues.add(strUser);
				arrValues.add(strRepName);
				arrValues.add(strProfileName);
				arrValues.add(strParam);
				arrValues.add(txtfromamt);
				arrValues.add(txttoamt);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				   }
				else
				{
					hshQuery.put("strQueryId","InsertRepParam1");
					arrValues = new ArrayList();
					arrValues.add(strUser);
					arrValues.add(strRepName);
					arrValues.add(strProfileName);
					arrValues.add(strParam);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
				}
		     	}
			else if(strAction.equalsIgnoreCase("Update"))
			{
				hshQuery=new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","DeleteRepParam");
				arrValues = new ArrayList();
				arrValues.add(strUser);
				arrValues.add(strRepName);
				arrValues.add(strProfileName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","InsertRepParam");
				arrValues = new ArrayList();
				arrValues.add(strUser);
				arrValues.add(strRepName);
				arrValues.add(strProfileName);
				arrValues.add(strParam);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","DeleteRepParam");
				arrValues = new ArrayList();
				arrValues.add(strUser);
				arrValues.add(strRepName);
				arrValues.add(strProfileName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
		
			if (count== 0)
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hshRecord.put("action","done");
			}
			else
			{
				hshRecord.put("action","failed");
			}

			hshRecord.put("fromwhichpage",strAction);

		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		return hshRecord;
	}

	public HashMap getParameter(HashMap hshPar) 
	{
		HashMap hshRec = new HashMap();
		ResultSet rs = null;
		String strQuery = null;
		String strUserid=null;
		String strRepName=null;
		String strProfileName=null;
		String strParam = "";
		String strDate="";
		String txtfromamt=null;
		String txttoamt=null;
		boolean bState = false;
		
		try
		{
			strUserid=correctNull((String)hshPar.get("userid"));
			strRepName=correctNull((String)hshPar.get("repname"));
			strProfileName = (String)hshPar.get("txtprofile_name");
			txtfromamt =(String)hshPar.get("txtfromamt");
			txttoamt =(String)hshPar.get("txttoamt");
			strQuery = SQLParser.getSqlQuery("profileparam^"+strUserid+"^"+strRepName+"^"+strProfileName);
			rs =DBUtils.executeQuery(strQuery);
			bState =rs.next();
			int count=0;
			if (bState)
			{
				count=count+1;
				strUserid =correctNull(rs.getString("rep_usrid"));		
				strParam = correctNull(rs.getString("rep_param"));			
				strDate=correctNull(rs.getString("rep_repdate"));
				txtfromamt=correctNull(rs.getString("rep_frmamt"));
				txttoamt=correctNull(rs.getString("rep_toamt"));
			}
			
			hshRec.put("param",strParam);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strUserid);
			hshRec.put("count",new Integer(count).toString());
			hshRec.put("profilename",strProfileName);
			hshRec.put("txtfromamt",txtfromamt);
			hshRec.put("txttoamt",txttoamt);
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in get Parameter "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRec;
	}
	public HashMap getParameter1(HashMap hshPar) 
	{
		HashMap hshRec = new HashMap();
		ResultSet rs = null;
		String strQuery = null;
		String strUserid=null;
		String strRepName=null;
		String strProfileName=null;
		String strParam = "";
		String strDate="";
		boolean bState = false;
		
		try
		{
			strUserid=correctNull((String)hshPar.get("userid"));
			strRepName=correctNull((String)hshPar.get("repname"));
			strProfileName = (String)hshPar.get("txtprofile_name");
			strQuery = SQLParser.getSqlQuery("profileparam1^"+strUserid+"^"+strRepName+"^"+strProfileName);
			rs =DBUtils.executeQuery(strQuery);
			bState =rs.next();
			int count=0;
			if (bState)
			{
				count=count+1;
				strUserid =correctNull(rs.getString("rep_usrid"));		
				strParam = correctNull(rs.getString("rep_param"));			
				strDate=correctNull(rs.getString("rep_repdate"));
				
			}
			
			hshRec.put("param",strParam);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strUserid);
			hshRec.put("count",new Integer(count).toString());
			hshRec.put("profilename",strProfileName);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in get Parameter "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRec;
	}
}