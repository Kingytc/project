package com.sai.laps.ejb.qisrange;

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
import com.sai.laps.helper.SQLParser;

@Stateless(name = "QisRangeBean", mappedName = "QisRangeHome")
@Remote (QisRangeRemote.class)
public class QisRangeBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(QisRangeBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		String strQuery="";
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = null;
		ArrayList vecData = new ArrayList();
		try
		{				
			hshRecord = new HashMap();
			String strRatioid =correctNull((String)hshRequestValues.get("ratioid"));
			String strRatioDesc =correctNull((String)hshRequestValues.get("ratiodesc"));
			String strQisType=correctNull((String)hshRequestValues.get("qistype"));
			if(!strRatioid.trim().equals(""))
			{
				strQuery = SQLParser.getSqlQuery("selqisanalysisrange^"+strRatioid+"^"+strQisType);
				rs = DBUtils.executeQuery(strQuery);
				while( rs.next() )
				{	
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs.getString("qis_from")));
					vecVal.add(correctNull(rs.getString("qis_to")) );
					vecVal.add(correctNull(rs.getString("qis_comments")) );
					vecData.add(vecVal);
				}
			}
			hshRecord.put("ratioid",strRatioid);
			hshRecord.put("ratiodesc",strRatioDesc);
			hshRecord.put("qistype",strQisType);
			
			hshRecord.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}


	public void updateData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String []strFrom = null;
		String []strTo = null;
		String []strPoint = null;
		int intUpdatesize=0;
		try
		{	
			String strRatioid =correctNull((String)hshValues.get("ratioid"));
			String strQisType=correctNull((String)hshValues.get("qistype"));
			String hidAction=correctNull((String)hshValues.get("hidAction"));
			strFrom = (String [])hshValues.get("txtrangefrom");
			strTo = (String [])hshValues.get("txtrangeto");
			strPoint = (String [])hshValues.get("txtpoint");
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add(strRatioid);
			arrValues.add(strQisType);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","delqisanalysisrange");
			intUpdatesize = 1;
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			
		if(!hidAction.trim().equals("delete"))
		{
			for( int i=0;i<strFrom.length;i++)
			{				
				if(!strFrom[i].trim().equals(""))
				{
					intUpdatesize = intUpdatesize + 1 ;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","insqisanalysisrange");
					arrValues.add(strRatioid);
					arrValues.add(correctNull(strFrom[i]));
					arrValues.add(correctNull(strTo[i]));
					arrValues.add(correctNull(strPoint[i]));
					arrValues.add(strQisType);
					arrValues.add(Integer.toString(i+1));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				}
			}
		}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}

public HashMap getDataHelp(HashMap hshRequestValues) 
	{	
		ResultSet rs = null;
		String strQuery="";
		HashMap hshRecord = new HashMap();
		ArrayList arr=new ArrayList();
		ArrayList arr1=new ArrayList();
		try
		{	
			
			hshRecord = new HashMap();
			
			strQuery = SQLParser.getSqlQuery("selqisanalysisdetails");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arr.add(correctNull(rs.getString("id")));
				arr1.add(correctNull(rs.getString("ratio_desc")));
			}
			hshRecord.put("arrVal",arr);
			hshRecord.put("arrValdesc",arr1);


		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}


}