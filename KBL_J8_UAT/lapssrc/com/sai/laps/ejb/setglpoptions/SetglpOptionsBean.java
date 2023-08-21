package com.sai.laps.ejb.setglpoptions;

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

@Stateless(name = "SetglpOptionsBean", mappedName = "SetglpOptionsHome")
@Remote (SetglpOptionsRemote.class)
public class SetglpOptionsBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 923804658632769892L;
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(SetglpOptionsBean.class);
	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intUpdateSize=0;
		StringBuilder sbActionData = new StringBuilder();
		String strKeyId="";
		try
		{
		
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			hshQuery.put("strQueryId","setglpoptionsdel");
			hshQuery.put("arrValues",new ArrayList());
			intUpdateSize++;
			hshQueryValues.put(""+intUpdateSize,hshQuery);

			hshQuery=new HashMap();
			hshQuery.put("strQueryId","setglpoptionsins");
			arrValues.add(hshValues.get("choglp_orglevel"));
			arrValues.add((hshValues.get("txtglp_orgname1")).toString().toUpperCase());
			arrValues.add(hshValues.get("txtglp_orgname2").toString().toUpperCase());
			arrValues.add(hshValues.get("txtglp_orgname3").toString().toUpperCase());
			arrValues.add(hshValues.get("txtglp_orgname4").toString().toUpperCase());
			arrValues.add(hshValues.get("txtglp_orgname5").toString().toUpperCase());
			
			hshQuery.put("arrValues",arrValues);
			intUpdateSize++;
			hshQueryValues.put(""+intUpdateSize,hshQuery);
			hshQueryValues.put("size",""+intUpdateSize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			//for Entering the values into auditrial
			
			sbActionData.append("No of Levels=").append(correctNull((String)hshValues.get("choglp_orglevel"))).
							append("~Level 1=").append(correctNull((String)hshValues.get("txtglp_orgname1"))).
							append("~Level 2=").append(correctNull((String)hshValues.get("txtglp_orgname2"))).
							append("~Level 3=").append(correctNull((String)hshValues.get("txtglp_orgname3"))).
							append("~Level 4=").append(correctNull((String)hshValues.get("txtglp_orgname4"))).
							append("~Level 5=").append(correctNull((String)hshValues.get("txtglp_orgname5")));
			
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
		    AuditTrial.auditLog(hshValues,"4",strKeyId,sbActionData.toString());			
		}
		catch(Exception ce)
		{
			log.error("in bean... "+ce);
			throw new EJBException("Error in updateData "+ce.toString());
		}
	}

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		int intLevel = 0;
		boolean recordflag=false;
		try
		{
			rs=DBUtils.executeLAPSQuery("setglpoptionssel");
			hshRecord = new HashMap();			
			while(rs.next())
			{
				recordflag=true;
				hshRecord.put("choglp_orglevel",correctNull(rs.getString("glp_orglevel")));
				hshRecord.put("txtglp_orgname1",correctNull(rs.getString("glp_orgname1")));
				hshRecord.put("txtglp_orgname2",correctNull(rs.getString("glp_orgname2")));
				hshRecord.put("txtglp_orgname3",correctNull(rs.getString("glp_orgname3")));
				hshRecord.put("txtglp_orgname4",correctNull(rs.getString("glp_orgname4")));
				hshRecord.put("txtglp_orgname5",correctNull(rs.getString("glp_orgname5")));
			}
			rs=DBUtils.executeLAPSQuery("setglpoptionsorglevel");
			while(rs.next())
			{
				intLevel++;			
			}
			hshRecord.put("intLevel",String.valueOf(intLevel));
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}


	public HashMap getDataHelp(HashMap hshParamter) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCodes = new ArrayList();
		ArrayList vecValues = new ArrayList();
		try
		{
			rs=DBUtils.executeLAPSQuery("setglphelp");
			while(rs.next())
			{
				vecCodes.add(correctNull(rs.getString("con_country")));
				vecValues.add(correctNull(rs.getString("con_currency")));
			}
			hshRecord.put("vecCodes",vecCodes);
			hshRecord.put("vecValues",vecValues);

		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}
	
	public void updateScreenData(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String action = (String)hshValues.get("hidAction");
		try
		{
		
			if(action.equals("new"))
			{
				rs=DBUtils.executeLAPSQuery("getScrCount");
				int scrID=0;
				while(rs.next())
				{
					scrID = rs.getInt(1);
				}
				scrID++;
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","updateScreen");
				arrValues.add(hshValues.get("sel_scrmod"));
				arrValues.add(Integer.toString(scrID));
				arrValues.add(hshValues.get("txtscr_name"));
				arrValues.add(hshValues.get("txtmsg_jspname"));
				arrValues.add(hshValues.get("txtseq_number"));
				arrValues.add(hshValues.get("txtmsg_scrimage"));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(action.equals("edit"))
			{
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","updatescr");
				
				arrValues.add(hshValues.get("sel_scrmod"));
				arrValues.add(hshValues.get("txtscr_name"));
				arrValues.add(hshValues.get("txtmsg_jspname"));
				arrValues.add(hshValues.get("txtseq_number"));
				arrValues.add(hshValues.get("txtmsg_scrimage"));
				arrValues.add(hshValues.get("scrId"));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
							
			}
			else if(action.equals("del"))
			{
				hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","delscr");
				arrValues.add(hshValues.get("scrId"));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);				
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			log.error("in bean... "+ce);
			throw new EJBException("Error in updateData "+ce.toString());
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
				throw new EJBException("Error closing in the updateScreenData connection "+cf.getMessage());
						
			}
		}

}
	public HashMap getScreenData(HashMap hshParamter) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList vecValues = new ArrayList();
		try
		{
			rs=DBUtils.executeLAPSQuery("getScreen");
			while(rs.next())
			{
				ArrayList vecCodes = new ArrayList();
				vecCodes.add(correctNull(rs.getString("screen_module")));
				vecCodes.add(correctNull(rs.getString("screen_name")));
				vecCodes.add(correctNull(rs.getString("screen_jsp_page")));
				vecCodes.add(correctNull(rs.getString("screen_seq_no")));
				vecCodes.add(correctNull(rs.getString("screen_image")));
				vecCodes.add(correctNull(rs.getString("screen_id")));
				vecValues.add(vecCodes);
			}
			hshRecord.put("vecValues",vecValues);

		}
		catch(Exception ce)
		{
			log.error(ce.toString());
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}
	
	
	
}
