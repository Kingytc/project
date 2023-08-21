package com.sai.laps.helpertags;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;

public class tagLibrary3 extends BeanAdapter {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(tagLibrary3.class);
	public HashMap getStaticDataHeads(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		try
		{
			
			rs = DBUtils.executeLAPSQuery("getstaticdataheads");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecCol.add(correctNull(rs.getString(2)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getStaticDataHeads "+ce.toString());
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
	public HashMap getHouseLoanData(HashMap hshValues) 
	{	
		
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList vecCol		= new ArrayList();
		ArrayList vecRow		= new ArrayList();	
		
		try
		{
		
			rs = DBUtils.executeLAPSQuery("sel_houseloandate");
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull(rs.getString(1)));
				vecRow.add(vecCol);	
			}
			hshRecord.put("vecRow",vecRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getHouseLoanData "+ce.toString());
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
 