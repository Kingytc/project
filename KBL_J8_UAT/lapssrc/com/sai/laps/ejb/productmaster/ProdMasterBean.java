package com.sai.laps.ejb.productmaster;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ProdMasterBean", mappedName = "ProdMasterHome")
@Remote (ProdMasterRemote.class)
public class ProdMasterBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ProdMasterBean.class);
	private static final long serialVersionUID = 1L;

	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		int count =0;
		String strTemp =null;
		String strAction =null;
		String strCatName =null;
		String strCatParent=null;
		int intTempCount=0;
		String strMsg="";
		ResultSet rs = null;
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			hshQueryValues.put("size","1");
			strAction = correctNull((String)hshValues.get("hidAction"));	
			strCatName= (String)hshValues.get("txtcat_name");
			strCatParent = (String)hshValues.get("hidcat_parent");
			String strCategory = "";
			String strSubCategory = "";
			String strCatId = "";
			if(strAction.equalsIgnoreCase("Update") || strAction.equalsIgnoreCase("Delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_category_audit^"+Helper.correctNull((String)hshValues.get("hidcat_id")));
				while(rs.next())
				{
					strSubCategory = Helper.correctNull((String)rs.getString("cat_name"));	
					strCatId = Helper.correctNull((String)rs.getString("cat_parent"));
				}
				if(rs!=null)
					rs.close();
				if(Helper.correctNull((String)hshValues.get("rad")).equals("radiobutton2"))
				{					
					rs=DBUtils.executeLAPSQuery("sel_category_audit^"+strCatId);
					while(rs.next())
					{
						strCategory = Helper.correctNull((String)rs.getString("cat_name"));
					}
					if(rs!=null)
						rs.close();
					sbolddata.append("~ Category  = "+strCategory);
					sbolddata.append("~ Sub - Category  = "+strSubCategory);					
				}
				else
				{
					sbolddata.append("~ Category  = "+strSubCategory);
				}
				
			}

			if (strAction.equalsIgnoreCase("Insert"))
			{
				if (getProductid("count",strCatName,strCatParent) == 0)
				{
					hshQuery.put("strQueryId","InsertProduct");
					count = getProductid("max",strCatName,strCatParent);
					count = count + 1;
					strTemp = java.lang.String.valueOf(count);
			
					arrValues.add(strTemp);
					arrValues.add(hshValues.get("txtcat_name").toString().toUpperCase());
					arrValues.add(hshValues.get("hidcat_parent"));
					arrValues.add("");
					arrValues.add(hshValues.get("sel_active"));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					intTempCount=0;
				}
				else
				{
					intTempCount=intTempCount+1;
					strMsg="Category Already Exist";
				}
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
				if (strCatParent.equals("0"))
				{
					strCatParent = (String)hshValues.get("hidcat_id");
					count = getProductid("del",strCatName,strCatParent);
				}
				else  
				{
					strCatParent = (String)hshValues.get("hidcat_id");
					count = getProductid("upd",strCatName,strCatParent);
				}
					hshQuery.put("strQueryId","UpdateProduct");
					arrValues.add(hshValues.get("hidcat_id"));
					arrValues.add(hshValues.get("txtcat_name").toString().toUpperCase());
					arrValues.add(hshValues.get("hidcat_parent"));
					arrValues.add(hshValues.get("sel_active"));
					arrValues.add(hshValues.get("hidcat_id"));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					intTempCount=0;

			}
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				strCatParent = (String)hshValues.get("hidcat_id");
				int t =getProductid("del",strCatName,strCatParent);
				int t1=0;
				if (t == 0)
				{
					t1 =getProductid("upd",strCatName,strCatParent);
					if (t1 == 0)
					{
					
						hshQuery.put("strQueryId","DeleteProduct");
						arrValues.add(hshValues.get("hidcat_id"));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						intTempCount=0;
					}
					else
					{
						intTempCount=intTempCount+1;
						strMsg="Cannot delete this Category because it is having related records";
					}
				}
				else
				{
					intTempCount=intTempCount+1;
					strMsg="Cannot delete this Category because it is having related records";
				}
			}
			if (intTempCount == 0)
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hshRecord.put("action","done");
				hshRecord.put("Msg",strMsg);
			}
			else
			{
				hshRecord.put("action","failed");
				hshRecord.put("Msg",strMsg);
			}
			
			//for Entering the values into auditrial
			
			/*hshQuery=new HashMap();
			arrValues=new ArrayList();

			String strActionData = "Category Name="+correctNull((String)hshValues.get("txtcat_name"));
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","audittrial");
					arrValues.add("11");
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("strClientIP")));
					arrValues.add("Category Master");
					arrValues.add(strActionData);
					arrValues.add(strAction);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);			
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
			if (intTempCount == 0)
			{	
				StringBuilder sbAuditTrial=new StringBuilder();
				if(!strAction.equalsIgnoreCase("Delete"))
				{
					if(correctNull((String )hshValues.get("rad")).equals("radiobutton2"))
					{	
						sbAuditTrial.append("Category ="+correctNull((String )hshValues.get("audit_Category"))).append("~Sub Category=").append(correctNull((String )hshValues.get("txtcat_name")).toUpperCase());
					}
					else
					{
						sbAuditTrial.append("Category="+correctNull((String )hshValues.get("txtcat_name")).toUpperCase());
					}
				}
				if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
									hshValues.put("hidAction", "update");
				AuditTrial.auditNewLog(hshValues,"11",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			}	
						
			//---------------------------End Audit Trail------------------------------

		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		return hshRecord;
	}

	private int getProductid(String strVal,String name,String parent) 
													
	{		
		ResultSet rs= null;
		String strQuery=null;
		int count=0;

		try
		{
			
			if (strVal.equalsIgnoreCase("max"))
			{
				strQuery =SQLParser.getSqlQuery("maxprodcat");
			}
			else if (strVal.equalsIgnoreCase("count"))
			{
				strQuery =SQLParser.getSqlQuery("checkproduct^"+name+"^"+Integer.parseInt(parent));
			}
			else if (strVal.equalsIgnoreCase("del"))
			{
				strQuery =SQLParser.getSqlQuery("checkdelproduct^"+Integer.parseInt(parent));
			}
			else if (strVal.equalsIgnoreCase("upd"))
			{
				strQuery =SQLParser.getSqlQuery("checkupdproduct^"+Integer.parseInt(parent));
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				count = rs.getInt(1);	
			}
		}
		catch(Exception e)
		{
			log.error(e.toString());
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
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return count;
	}

	private HashMap getProd(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		String strParent = "1";

		try
		{			
			strValue = (String)hshValues.get("value");
			strParent = (String)hshValues.get("parent");

			if (strValue.equalsIgnoreCase("parent"))
			{
				strQuery = SQLParser.getSqlQuery("selparentproduct");
			}
			else if (strValue.equalsIgnoreCase("sub"))
			{
				strQuery = SQLParser.getSqlQuery("selallproduct");
			}
			else if (strValue.equalsIgnoreCase("subsel"))
			{
				strQuery = SQLParser.getSqlQuery("selsubproduct^"+Integer.parseInt(strParent));
			}

			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				String catid =correctNull(rs.getString("cat_id"));
				String catpa =correctNull(rs.getString("cat_parent"));
				String cat_action =correctNull(rs.getString("CAT_ACTION"));
				catpa= catid+"-"+catpa+"-"+cat_action;
				vecCatid.add(catpa);
				vecCatName.add(correctNull(rs.getString("cat_name")));
	
			}
			
			hshRecord.put("vecCodes",vecCatid);
			hshRecord.put("vecValues",vecCatName);
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
	
	private HashMap getmainhead(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		String strParent = "1";
		boolean recordflag=false;
		try
		{			
			strValue = (String)hshValues.get("value");
			strParent = (String)hshValues.get("parent");


			if (strValue.equalsIgnoreCase("parent"))
			{
				strQuery = SQLParser.getSqlQuery("selsubhead");
			}
			else if (strValue.equalsIgnoreCase("sub"))
			{
				strQuery = SQLParser.getSqlQuery("selallproduct");
			}
			else if (strValue.equalsIgnoreCase("subsel"))
			{
				strQuery = SQLParser.getSqlQuery("selsubproduct^"+Integer.parseInt(strParent));
			}

			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				recordflag=true;
				String catid =correctNull(rs.getString("cat_id"));
				String catpa =correctNull(rs.getString("cat_parent"));
				catpa= catid+"-"+catpa;
				vecCatid.add(catpa);
				vecCatName.add(correctNull(rs.getString("cat_name")));
	
			}
			
			hshRecord.put("vecCodes",vecCatid);
			hshRecord.put("vecValues",vecCatName);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
	
	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProd"))
			{
				hshRecord =(HashMap)getProd(hshValues);
			}
			if (strMethod.equalsIgnoreCase("getmainhead"))
			{
				hshRecord =(HashMap)getmainhead(hshValues);
			}
			
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}
}