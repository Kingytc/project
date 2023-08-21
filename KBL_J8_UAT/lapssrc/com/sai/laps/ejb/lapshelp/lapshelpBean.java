package com.sai.laps.ejb.lapshelp;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;

@Stateless(name = "lapshelpBean", mappedName = "lapshelpHome")
@Remote (lapshelpRemote.class)
public class lapshelpBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(lapshelpBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void updateData(HashMap hshValues)
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null;
		String strExp= "$";
		String hid_help_key_no ="";		
		String action = (String)hshValues.get("hidAction");		
		hid_help_key_no = correctNull((String)hshValues.get("txt_helpKey_no"));
		
		try
		{						
			if(action.equalsIgnoreCase("New"))
			{
				int count = 0;	
				count = getcnthelpKeyno(hid_help_key_no);				
				if (count>0)
				{
					strExp = "$Help Key No. already exists";
					throw new Exception(strExp);
				}
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","Ins_key_info");				
				arrVal.add(hid_help_key_no);
				arrVal.add(correctNull((String)hshValues.get("txta_helpdesc")));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");				
			}
			else if(action.equalsIgnoreCase("Edit"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","Upd_key_info");				
				arrVal.add(correctNull((String)hshValues.get("txta_helpdesc")));
				arrVal.add(hid_help_key_no);
				hshQry.put("arrValues",arrVal);							
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(action.equalsIgnoreCase("delete"))
			{
				hshqueryval.put("size","1");
				hshQry.put("strQueryId","help_del");
				arrVal.add(hid_help_key_no);
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("1",hshQry);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	}
	
	public HashMap getData(HashMap hshValues) 
	{		 	 
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		String strAction = correctNull((String)hshValues.get("hidAction"));
		
		try
		{ 
			String Help_Key_No="";			
			if(strAction.trim().equalsIgnoreCase("New"))
			{
				strAction = "Edit";	
				Help_Key_No = correctNull((String)hshValues.get("txt_helpKey_no"));
			}
			else if(strAction.trim().equalsIgnoreCase("Edit"))
			{
				Help_Key_No = correctNull((String)hshValues.get("hid_helpKey_no"));
			}
			if(!(Help_Key_No.trim().equalsIgnoreCase("")))
			{
				rs=DBUtils.executeLAPSQuery("Get_Help_info^"+Help_Key_No);
				hshRecord.put("Hid_action",strAction);
				while(rs.next())
				{
					hshRecord.put("helpkeyno",correctNull(rs.getString("Help_key")));
					hshRecord.put("helpdesc",correctNull(rs.getString("Help_Data")));
				}
			}
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());					
			}
		}
		return hshRecord;
	}

	public HashMap getdataHelpList(HashMap hshValues) 
	{	
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		String strHelp_Key_No  = correctNull((String)hshValues.get("hidhelpkeyid"));
		
		try
		{	
			if(strHelp_Key_No.trim().equals(""))
			{
				ArrayList vecData = new ArrayList();
				ArrayList vecVal =new ArrayList();				
				rs=DBUtils.executeLAPSQuery("disp_key_info");
				while(rs.next())
				{
					vecVal = new ArrayList();				
					vecVal.add(correctNull(rs.getString("Help_key")));
					vecVal.add(correctNull(rs.getString("help_data")));
					vecVal.add(correctNull(rs.getString("screen_id")));
					vecVal.add(correctNull(rs.getString("screen_name")));
					vecData.add(vecVal);	
				}	
				hshRecord.put("vecData",vecData);
			}	
			else
			{
				rs=DBUtils.executeLAPSQuery("Get_Help_info^"+ strHelp_Key_No );				 
				while(rs.next())
				{
					hshRecord.put("helpkeyno",correctNull(rs.getString("Help_key")));
					hshRecord.put("helpdesc",correctNull(rs.getString("Help_Data")));
					hshRecord.put("screen_name",correctNull(rs.getString("screen_name")));
				}
			}
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());					
			}
		}
		return hshRecord;
	}

	public HashMap getdataHelpLeftMenu(HashMap hshValues) 
	{	
	 	ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		String hidkeyid = "";
		hidkeyid = correctNull((String)hshValues.get("hidhelpkeyid"));
		
		try
		{
			ArrayList vecData = new ArrayList();
			ArrayList vecVal =new ArrayList();
			ArrayList vecsubVal = new ArrayList();				
			rs=DBUtils.executeLAPSQuery("Sel_left_Helpmenu");
			while(rs.next())
			{
				vecVal = new ArrayList();	
				vecsubVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("screen_id")));
				vecVal.add(correctNull(rs.getString("screen_name")));
				vecVal.add(correctNull(rs.getString("screen_level")));
				vecVal.add(correctNull(rs.getString("parent_screen")));
				vecVal.add(correctNull(rs.getString("screen_seq_no")));
				vecVal.add(correctNull(rs.getString("help_key")));				
				vecsubVal = getdataHelpLeftSubMenu(correctNull(rs.getString("screen_id")));				
				vecVal.add(vecsubVal);
				vecData.add(vecVal);	
			}	
			hshRecord.put("vecData",vecData);
			hshRecord.put("hidkeyid",hidkeyid);	
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());					
			}
		}
		return hshRecord;
	}

	private int getcnthelpKeyno(String temphelpkeyno)  
	{
		ResultSet rs = null;
		int cntval = 0;
	
		try
		{
			rs=DBUtils.executeLAPSQuery("Chk_Help_info^"+temphelpkeyno);		
			 
			while (rs.next()) 
			{
				if (rs.getString(1) != null) {
					cntval = Integer.parseInt(rs.getString(1)) ;
				} 
			}	
			rs.close();	
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
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
		return cntval;
	}

	private ArrayList getdataHelpLeftSubMenu(String tempscreenid)  
	{
		ResultSet rs = null;
		ArrayList vecDatasub = new ArrayList();
		ArrayList vecValsub =new ArrayList();
	
		try 
		{		
			rs=DBUtils.executeLAPSQuery("Sel_left_Helpsubmenu^"+tempscreenid);
			while(rs.next())
			{
				vecValsub = new ArrayList();				
				vecValsub.add(correctNull(rs.getString("screen_id")));
				vecValsub.add(correctNull(rs.getString("screen_name")));
				vecValsub.add(correctNull(rs.getString("screen_level")));
				vecValsub.add(correctNull(rs.getString("parent_screen")));
				vecValsub.add(correctNull(rs.getString("screen_seq_no")));
				vecValsub.add(correctNull(rs.getString("help_key")));		
				vecDatasub.add(vecValsub);	
			}
			rs.close();	
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
		} 
		finally 
		{
			try
			{				 
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return vecDatasub;
	}
}