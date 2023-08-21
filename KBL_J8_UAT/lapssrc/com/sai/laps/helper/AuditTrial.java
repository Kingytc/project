package com.sai.laps.helper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

//import javax.ejb.EJBException;


public class AuditTrial{
	static Logger log=Logger.getLogger(AuditTrial.class);
	/*public static void insert(HashMap hshRecord,HashMap hshValues)throws Exception
	{
		
		String strOldVal="";
		String strNewVal="";
		String strBeanMethod = Helper.correctNull((String)hshValues.get("hidBeanMethod"));
		String appno = Helper.correctNull((String)hshValues.get("appno"));
		
		hshRecord.put("oldVal",hshRecord.toString());
		if(!strBeanMethod.equalsIgnoreCase(""))
		{
	       	strOldVal = Helper.correctNull((String)hshValues.get("hidAudit")).toString();
	       	hshRecord.remove("oldVal");
	       	strNewVal = hshRecord.toString();
	       	hshRecord.put("oldVal",hshRecord.toString());
	       	
	        AuditTrial.auditNew(strOldVal,strNewVal,hshValues,appno);
		}    
	}*/	
	/*public static void auditNew(String oldValues,String newValues,HashMap hshValues,String appno)throws Exception
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrAudit=new ArrayList();
		String username = Helper.correctNull((String)hshValues.get("strUserId")); 
		String pagename = Helper.correctNull((String)hshValues.get("hidPageName"));
		String clientip = Helper.correctNull((String)hshValues.get("strClientIP"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		try
		{
			hshQueryValues.put("size","1");
			arrAudit.add(username);
			arrAudit.add(appno);
			arrAudit.add(pagename);
			arrAudit.add(clientip);
			
			if(oldValues.equalsIgnoreCase(""))
			{
				oldValues="New";
				
				arrAudit.add(oldValues);
			}
			else
			{	
			arrAudit.add(oldValues);
			}
			if(oldValues.equalsIgnoreCase(newValues))
			{
				arrAudit.add(username + " does not made any Changes");
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				arrAudit.add("Deleted by " + username);
			}
			else
			{
				arrAudit.add(newValues);
			}
			hshQuery.put("arrValues", arrAudit);
			hshQuery.put("strQueryId","insAuditTrial");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		catch (Exception e) {
			//rollBack();
			throw new EJBException(e.getMessage());}
		finally {
			try {
				
				}
			catch (Exception e) {
				throw new EJBException(
						"Error in closing Connection"
								+ e.getMessage());
			}
		}
		
	}*/	
	
	
	
	/**
	 * @author S.SATHYA MOORTHY
	 * @since 23/01/2009
	 * @param hshValues
	 * @param strKeyId
	 * @param strAppno
	 * @param strData
	 * @return
	 */
	public static boolean auditLog(HashMap hshValues,String strKeyId,String strAppno,String strData)
	{
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		try
		{
			hshQuery.put("strQueryId", "audittrial");
			hshQueryValues.put("size", "1");
			arrValues.add(strKeyId);
			arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strClientIP")));
			arrValues.add(strAppno);
			//arrValues.add("");
			arrValues.add(strData);
			strAction=Helper.correctNull((String)hshValues.get("strAction"));
			if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			//if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
			arrValues.add(strAction);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		catch(Exception e)
		{
		log.error("Exception From AuditTrial:auditLog:"+e.toString());
		}
		finally
		{
		hshQuery=null;hshQueryValues=null;arrValues=null;strAppno=null;	
		}
		
		return true;
	}
	
	public static boolean auditNewLog(HashMap hshValues,String strKeyId,String strAppno,String strData,String strOldData)
	{
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		try
		{
			hshQuery.put("strQueryId", "audittrialNEW");
			hshQueryValues.put("size", "1");
			arrValues.add(strKeyId);
			arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));
			arrValues.add(Helper.correctNull((String) hshValues.get("strClientIP")));
			arrValues.add(strAppno);
			arrValues.add(strOldData);
			arrValues.add(strData);
			strAction=Helper.correctNull((String)hshValues.get("strAction"));
			if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
			arrValues.add(strAction);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		catch(Exception e)
		{
			log.error("Exception From AuditTrial:auditLog:"+e.toString());
		}
		finally
		{
		hshQuery=null;hshQueryValues=null;arrValues=null;strAppno=null;	
		}
		
		return true;
	}
	public static boolean auditNewLog1(HashMap hshValues,String strKeyId,String strAppno,String strData,String strOldData,String strSno)
	{
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		try
		{	
		strAction=Helper.correctNull((String)hshValues.get("strAction"));
		hshQuery.put("strQueryId", "audittrialNEW1");
		hshQueryValues.put("size", "1");
		arrValues.add(strKeyId);
		arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));
		arrValues.add(Helper.correctNull((String) hshValues.get("strClientIP")));
		arrValues.add(strAppno);
		
		if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		arrValues.add(strOldData);
		if(strAction.equalsIgnoreCase("delete")){
			arrValues.add("");
		}else{
		arrValues.add(strData);
		}
		
		arrValues.add(strAction);
		arrValues.add(strSno);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");}
		catch(Exception e)
		{
			log.error("Exception From AuditTrial:auditLog:"+e.toString());
		}
		finally
		{
		hshQuery=null;hshQueryValues=null;arrValues=null;strAppno=null;	
		}
		
		return true;
	}
	
	public static boolean auditLogBatch(HashMap hshValues,String strKeyId,String strAppno,ArrayList arrBatchData)
	{
		
		HashMap hshQuery=null;
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=null;
		String strAction=null;
		try
		{
			
			if(arrBatchData!=null && arrBatchData.size()>0)
			{
				for(int i=0;i<arrBatchData.size();i++)
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId", "audittrial");
					arrValues.add(strKeyId);
					arrValues.add(Helper.correctNull((String) hshValues.get("strUserId")));
					arrValues.add(Helper.correctNull((String) hshValues.get("strClientIP")));
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull(((StringBuffer)arrBatchData.get(i)).toString()));
					strAction=Helper.correctNull((String)hshValues.get("strAction"));
					if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidAction"));
					if(strAction.equals(""))strAction=Helper.correctNull((String)hshValues.get("hidActionMode"));
					
					arrValues.add(strAction);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(""+(i+1), hshQuery);
				}
				hshQueryValues.put("size",""+arrBatchData.size());
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateBatchData");
			}
		}
		catch(Exception e)
		{
			log.error("Exception From AuditTrial:auditLog:"+e.getMessage());
		}
		finally
		{
		hshQuery=null;hshQueryValues=null;arrValues=null;strAppno=null;	
		}
		
		return true;
	}

}