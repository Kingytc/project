package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MonAccountwiseTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonAccountwiseTag.class);
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
				
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#DEDACF\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=3 bgcolor=\"#DEDACF\" height=\"25\">");
			out.println("<tr> ");

		

			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==1)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">MSOD</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('mon_msod.jsp','Register','getMSODdata')\" class=\"unnamed1\">");
				out.println("MSOD</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==2)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">QPR</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("QPR</a></b>");
				out.println("</font>");
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
			log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

