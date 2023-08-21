package com.sai.laps.taglib;

import java.sql.ResultSet;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;


public class RAMParametersTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(RAMParametersTag.class);
	private static final long serialVersionUID = 1L;
	private String type="";
	
	public int doEndTag() throws JspException
	{  
		JspWriter out=null;
		ResultSet rs1=null;
		String strQueryId="";
		
		try
		{
			out=pageContext.getOut();
			if(type.trim().equalsIgnoreCase("sector"))
			{
				strQueryId="ram_sector";
			}
			else if(type.trim().equalsIgnoreCase("segment"))
			{
				strQueryId="ram_segment";
			}
			else if(type.trim().equalsIgnoreCase("assetclass"))
			{
				strQueryId="ram_assetclass";
			}
			else if(type.trim().equalsIgnoreCase("industry"))
			{
				strQueryId="ram_industry";
			}
			else if(type.trim().equalsIgnoreCase("country"))
			{
				strQueryId="ram_country";
			}
			if (!strQueryId.trim().equals(""))
			{
				String query1=SQLParser.getSqlQuery(strQueryId);
				rs1 = DBUtils.executeQuery(query1);
				
				while(rs1.next())
				{
					out.println("<option value=\""+rs1.getString(1)+"\">"+rs1.getString(2)+"</option>");
				}
			}
			
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}
	public void setType(String strType)
	{
		type=strType;
	}
	public String getType()
	{
		return type;
	}
	
}
