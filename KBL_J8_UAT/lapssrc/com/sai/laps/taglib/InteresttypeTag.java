package com.sai.laps.taglib;


import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class InteresttypeTag extends TagSupport {
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(InteresttypeTag.class);
	private static final long serialVersionUID = 1L;
	
	String appmodule;
	String appvalue;
	String strInterestType="";
	public void setAppmodule(String appmodule) {
		this.appmodule = appmodule;
	}
	public void setAppvalue(String appvalue) {
		this.appvalue = appvalue;
	}



	JspWriter out =null;
	ResultSet rs=null;
	
	

	public int doEndTag() throws JspException
	{  
		HashMap hshquery = new HashMap();
		String strQuery="";
		try
		{
			out=pageContext.getOut();
			if(appmodule.equalsIgnoreCase("C"))
			{
				rs=DBUtils.executeLAPSQuery("sel_facilityCorp^"+appvalue);
				if(rs.next())
				{
					strInterestType=Helper.correctNull(rs.getString("fac_interesttype"));
					strInterestType=strInterestType.replace("RATING@", "").replace("O@", "");
					if(!strInterestType.equalsIgnoreCase(""))
					{
						strInterestType=strInterestType.substring(0, strInterestType.length()-1);
						strInterestType=strInterestType.replaceAll("@",  "','");
					}
				}
				
				if(rs!=null)
					rs.close();
				
				if(!strInterestType.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_staticdatavalues^219^"+strInterestType);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						out.println("<option value='"+Helper.correctNull(rs.getString("stat_data_desc"))+"'>"+Helper.correctNull(rs.getString("stat_data_desc1"))+"</option>");
					}
				}
				
			}
			else if(appmodule.equalsIgnoreCase("R"))
			{
				if(rs!=null)
					rs.close();				
				strQuery=SQLParser.getSqlQuery("sel_interestrtrepo");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					out.println("<option value='"+Helper.correctNull(rs.getString("CBS_STATIC_DATA_PASSING_CODE"))+"'>"+Helper.correctNull(rs.getString("CBS_STATIC_DATA_DESC"))+"</option>");
				}				
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("setproductstypebyprdcode^"+appvalue);
				if(rs.next())
				{
					strInterestType=Helper.correctNull(rs.getString("prd_interesttype"));
					strInterestType=strInterestType.replace("RATING@", "").replace("O@", "");
					if(!strInterestType.equalsIgnoreCase(""))
					{
						strInterestType=strInterestType.substring(0, strInterestType.length()-1);
						strInterestType=strInterestType.replaceAll("@", "','");
					}
				}
				
				if(rs!=null)
					rs.close();
				
				if(!strInterestType.equalsIgnoreCase(""))
				{
					
					strQuery=SQLParser.getSqlQuery("sel_staticdatavalues^219^"+strInterestType);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						out.println("<option value='"+Helper.correctNull(rs.getString("stat_data_desc"))+"'>"+Helper.correctNull(rs.getString("stat_data_desc1"))+"</option>");
					}
				}
			}
			
		}
		catch(Exception e)
		{
			log.error("exception in InteresttypeTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}
