package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MonQPRTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonQPRTag.class);
	String pageId = "";
	String strqpr="";
	
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setQpr(String qpr)
	{
		strqpr = qpr;
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=60% border=0 cellpadding=2 cellspacing=1 height=\"25\">");
			out.println("<tr> ");
			    
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==1)
			{
				out.println(" class=\"sub_tab_active\">");
				out.println("<b>Qpr Performance</b>");
				out.println("");
			}
			else
			{
			out.println("class=\"sub_tab_inactive\">");
			out.println("<b><a href=\"javascript:callLink('mon_qprperformance.jsp','mmrcommon','getQprPerformance')\" >");
			out.println("Qpr Performance</a></b>");
			out.println("");
			}
			out.println("</td>");
			
			out.println("<td width=\"10%\" align=\"center\"");
			      
					if(pageid==2)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Working Capital Funds</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_workingcapitalfunds.jsp','mmrcommon','getworkingcapitalfunds')\" >");
						out.println("Working Capital Funds");
						out.println("");
					}
						out.println("</td>");
						
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==3)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Current Assets</b>");
						out.println("");
					}
					else
					{
					out.println("class=\"sub_tab_inactive\">");
					out.println("<b><a href=\"javascript:callLink('mon_currentassetfinanced.jsp','mmrcommon','getCurrentAssetfinanced')\" >");
					out.println("Current Assets</a></b>");
					out.println("");
					}
					out.println("</td>");
					
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==4)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Levels of Inventory</b>");
						out.println("");
					}
					else
					{
					out.println("class=\"sub_tab_inactive\">");
					out.println("<b><a href=\"javascript:callLink('mon_inventory.jsp','mmrcommon','getinventory')\" >");
					out.println("Levels of Inventory</a></b>");
					out.println("");
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
			log.error("exception in QPRHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

