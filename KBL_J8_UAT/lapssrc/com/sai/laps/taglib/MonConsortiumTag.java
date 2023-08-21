package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MonConsortiumTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonConsortiumTag.class);
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
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable' align=\"center\">");
			out.println("<tr>");
			out.println("<td>");		
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class='outertable'>");
			out.println("<tr align=\"center\"> ");		

			out.println("<td");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Consortium Details</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_consortium.jsp','mmrcommon','getConsortium')\">");
				out.println("Consortium Details</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			out.println("<td");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Consortium Meeting</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_consortiummeeting.jsp','mmrcommon','getmonConsortiumMeeting')\">");
				out.println("Consortium Meeting</a></b>");
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

