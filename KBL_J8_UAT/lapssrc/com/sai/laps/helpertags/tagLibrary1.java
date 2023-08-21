package com.sai.laps.helpertags;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;

public class tagLibrary1 extends BeanAdapter {

	static Logger log=Logger.getLogger(tagLibrary1.class);	

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//static Logger log=Logger.getLogger(tagLibrary1.class);

//public HashMap getProductList(HashMap hshValues) 
//	{
//		 
//		ResultSet rs=null;
//		ResultSet rs1=null;
//		String strQuery="";
//		
//		HashMap hshResult=new HashMap();
//		ArrayList arryRow=new ArrayList();
//		ArrayList arryCol=null;
//		
//		
//		String strApplicationType=correctNull((String)hshValues.get("apptype"));
//		String strOrgLevel=correctNull((String)hshValues.get("orglevel"));
//		String strGroupRights=correctNull((String)hshValues.get("grouprights"));
//		String strOrgCode=correctNull((String)hshValues.get("orgcode"));
//			
//		String strBankVal="";
//		String strShortCode="";
//		try
//		{
//			strGroupRights=strGroupRights.substring(8,11);
//			 
//			if (strOrgLevel.equalsIgnoreCase("C"))
//			{
//				strBankVal = "'"+strOrgCode.substring(0,3)+"000000000000'";
//			}
//			else if (strOrgLevel.equalsIgnoreCase("R"))
//			{
//				strBankVal = "'"+strOrgCode.substring(0,6)+"000000000";
//				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//			}
//			else if (strOrgLevel.equalsIgnoreCase("D"))
//			{
//				strBankVal = "'"+strOrgCode.substring(0,9)+"000000";
//				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//			}
//			else if (strOrgLevel.equalsIgnoreCase("A"))
//			{
//				strBankVal = "'"+strOrgCode.substring(0,12)+"000";
//				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
//				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//			}
//			else if (strOrgLevel.equalsIgnoreCase("B"))
//			{
//				strBankVal = "'"+strOrgCode.substring(0,15);
//				strBankVal = strBankVal+"','"+strOrgCode.substring(0,12)+"000";
//				strBankVal = strBankVal+"','"+strOrgCode.substring(0,9)+"000000";
//				strBankVal = strBankVal+"','"+ strOrgCode.substring(0,6)+"000000000";
//				strBankVal = strBankVal +"','"+ strOrgCode.substring(0,3)+"000000000000'";
//			}
//			
//			if(strApplicationType.equalsIgnoreCase("p") || strApplicationType.equalsIgnoreCase("gf"))
//			{
//				strQuery =SQLParser.getSqlQuery("selorgsortcode^"+ strBankVal);
//				rs=DBUtils.executeQuery(strQuery);
//				
//				while(rs.next())
//				{
//					strShortCode= rs.getString(1);
//					if(!strShortCode.equals(""))
//					{
//						rs1=DBUtils.executeLAPSQuery("perprdlisthelp^" + strShortCode);
//						while (rs1.next())
//						{
//							arryCol=new ArrayList();
//							arryCol.add(rs1.getString("prdcode"));
//							arryCol.add(rs1.getString("category"));
//							arryCol.add(rs1.getString("subcategory"));
//							arryCol.add(rs1.getString("rangefrom"));
//							arryCol.add(rs1.getString("rangeto"));
//							arryCol.add(rs1.getString("term"));
//							arryCol.add(rs1.getString("class"));
//							arryCol.add(rs1.getString("loanratio"));
//							arryCol.add(rs1.getString("intrest"));
//							arryCol.add(rs1.getString("prd_type"));
//							arryCol.add(rs1.getString("prd_inttype"));
//							arryCol.add(rs1.getString("prd_repayselfemp"));
//							arryCol.add(rs1.getString("prd_collweight"));
//							arryRow.add(arryCol);
//						}
//						rs1.close();
//					}						
//				}									
//			}
//			else if(strApplicationType.equalsIgnoreCase("c"))
//			{
//			 
//				 rs=DBUtils.executeLAPSQuery("selorgsortcode^"+ strBankVal);
//				 while(rs.next())
//				{
//					 strShortCode= rs.getString(1);
//					if(!strShortCode.equals(""))
//					{
//					 
//						 rs=DBUtils.executeLAPSQuery("comprdlisthelp^" + strShortCode);
//						 while (rs1.next())
//						{
//							arryCol=new ArrayList();
//							arryCol.add(rs1.getString("prdcode"));
//							arryCol.add(rs1.getString("category"));
//							arryCol.add(rs1.getString("subcategory"));
//							arryCol.add(rs1.getString("rangefrom"));
//							arryCol.add(rs1.getString("rangeto"));
//							arryCol.add(rs1.getString("term"));
//							arryCol.add(rs1.getString("class"));
//							arryCol.add(rs1.getString("loanratio"));
//							arryCol.add(rs1.getString("intrest"));
//							arryCol.add(rs1.getString("prd_type"));
//							arryCol.add(rs1.getString("prd_inttype"));
//							arryRow.add(arryCol);
//						}
//						rs1.close();
//					}						
//				}
//			} 
//			hshResult.put("arryRow",arryRow);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in closing getData"+ce.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!=null)
//				{
//					rs.close();
//				}
//				 
//			}
//			catch(Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+e.getMessage());
//			}
//		}		
//		return hshResult;
//	}

public HashMap getUserList(HashMap hshRequestValues)  
{
	ResultSet rs = null;
	HashMap hshRecord = null;
	ArrayList vecVal = new ArrayList();		
	ArrayList vecRec= new ArrayList();

	try
	{
		rs = DBUtils.executeLAPSQuery("setuserlist");
		hshRecord = new HashMap();
		while(rs.next())
		{
			String strId=rs.getString("usr_id");
			String strName=rs.getString("usr_fname");
			String strUsrClass=rs.getString("usr_class");
			vecRec = new ArrayList();		
			vecRec.add(strId);
			vecRec.add(strName);
			vecRec.add(strUsrClass);	
			vecVal.add(vecRec);
		}
		hshRecord.put("users_data",vecVal);
		
	}
	catch(Exception ce)
	{
		log.error(ce.toString());
		throw new EJBException("Error in getUserList "+ce.toString());
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