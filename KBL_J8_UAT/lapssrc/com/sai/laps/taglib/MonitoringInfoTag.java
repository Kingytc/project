package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MonitoringInfoTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonitoringInfoTag.class);
	String pageId = "";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class='outertable'>");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align=\"center\"> ");

		

			out.println("<td");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Monitoring Info-1</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('mon_monitoringinfo.jsp','mmrcommon','getMonitoringInfo')\" >");
				out.println("Monitoring Info-1</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Monitoring Info-2</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_monitoringinformation.jsp','mmrcommon','getMonitoringInformation')\" >");
				out.println("Monitoring Info-2</a></b>");
				
			}
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
			
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MSODHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

