package com.sai.laps.ejb.Instructions;

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

@Stateless(name = "InstructionsBean", mappedName = "InstructionsHome")
@Remote (InstructionsRemote.class)
public class InstructionsBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;

	public void updateInstructions(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		ResultSet rs=null;	
		String strAction=null;
		String strsno = null;	
		String strInstructions=null;	
		String strTilldate="";
		String strUserID ="";
		try
		{
			strAction =correctNull((String)hshValues.get("hidAction"));
			strsno = correctNull((String)hshValues.get("hidsno"));
			strInstructions = correctNull((String)hshValues.get("txr_Instructions"));
			strTilldate= correctNull((String)hshValues.get("txt_dateupto"));
			strUserID = correctNull((String)hshValues.get("strUserId"));
			if(strAction.equals("New"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Ins_Bull_mast");
				arrValues=new ArrayList();
				arrValues.add(strInstructions);
				arrValues.add(strTilldate);
				arrValues.add(strUserID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("Edit"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Upd_Bull_mast");
				arrValues=new ArrayList();	
				arrValues.add(strInstructions);
				arrValues.add(strTilldate);
				arrValues.add(strUserID);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("Delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_Bull_mast");
				arrValues=new ArrayList();			
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
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

	public HashMap getInstructionsData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol 		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		String strsno="", action="";
		try
		{	
			action=correctNull((String)hshRequestValues.get("hidAction"));
			strsno=correctNull((String)hshRequestValues.get("hidsno"));
			if(strsno.equalsIgnoreCase(""))
		    {
		    	strsno="0";
			}
			rs=DBUtils.executeLAPSQuery("Sel_Bull_mast_values");
			hshRecord = new HashMap();			
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString("BULL_ID")));
				vecCol.add(correctNull(rs.getString("BULL_DESC")));
				String date = correctNull(rs.getString("BULL_DISP_UPTO"));
				if(date.trim().equals("01/01/1900"))
				{
					date = "";
					vecCol.add(date);
				}
				else
				{
					vecCol.add(date);
				}
				vecCol.add(correctNull(rs.getString("BULL_CDATE")));
				vecCol.add(correctNull(rs.getString("BULL_CREATEDBY")));
				vecRow.add(vecCol);	
			}
			if (action.equalsIgnoreCase("New"))
			{
				String qry="Max_Bull_mast";
				strsno = Integer.toString(getMaxGradeId(qry));
				rs=DBUtils.executeLAPSQuery("Sel_Bull_mast^"+strsno);		
				hshRecord = new HashMap();
			}
			if(action.equalsIgnoreCase("Edit")||action.equalsIgnoreCase("Cancel"))
			{
				rs=DBUtils.executeLAPSQuery("Sel_Bull_mast^"+strsno);
				hshRecord = new HashMap();
			}			
			else if(action.equalsIgnoreCase("")||action.equalsIgnoreCase("Delete"))
			{
				rs=DBUtils.executeLAPSQuery("Sel_Bull_mast_values");
			}
			if(rs.next())
			{
				hshRecord.put("BULL_ID",correctNull((String)rs.getString("BULL_ID")));
			    hshRecord.put("BULL_DESC",correctNull((String)rs.getString("BULL_DESC")));
			    if(correctNull(rs.getString("BULL_DISP_UPTO")).trim().equals("01/01/1900"))
			    {
			    	hshRecord.put("BULL_DISP_UPTO","");
			    }
			    else
			    {
			    	hshRecord.put("BULL_DISP_UPTO",correctNull((String)rs.getString("BULL_DISP_UPTO")));
			    }
			    hshRecord.put("BULL_CDATE",correctNull((String)rs.getString("BULL_CDATE")));
			    hshRecord.put("BULL_CREATEDBY",correctNull((String)rs.getString("BULL_CREATEDBY")));	
			}			
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
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
	
	private int getMaxGradeId(String qry)  
	{
		String strQuery = "";
		ResultSet rs = null;
		int termId = 0;
		try 
		{
			strQuery = SQLParser.getSqlQuery(qry);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) 
			{
				if (rs.getString(1) != null) 
				{
					termId = Integer.parseInt(rs.getString(1)) ;
				}
			}
			if(rs!=null)rs.close();
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
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
}