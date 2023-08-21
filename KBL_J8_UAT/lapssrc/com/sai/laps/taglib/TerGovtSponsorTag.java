package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;

public class TerGovtSponsorTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TerGovtSponsorTag.class);
	String pageId = "";
	String strgovtscheme="";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setGovtsponsor(String scheme)
	{
		strgovtscheme = scheme;
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
			
			out.println("<table width='40%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");	
			log.info("strgovtscheme=============================="+strgovtscheme);
			if(!strgovtscheme.equalsIgnoreCase("")||strgovtscheme.equalsIgnoreCase("null"))
			{
				if(strgovtscheme.equalsIgnoreCase("1"))
				{
					out.println("<td");
					if(pageid==3)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Sponsor Scheme</b>");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','govtsponschklist','getgovtQuestParameters','ops_checklist.jsp')\" >");
						out.println("Sponsor Scheme</a></b>");
					}
				}
				out.println("</td>");
			
			
			
			out.println("<td");
			if(pageid==2 && strgovtscheme.equalsIgnoreCase("1"))
			{
				out.println("class=\"sub_tab_active\">");
				out.println("<b>Eligibility CheckList</b>");
			}
			else if(strgovtscheme.equalsIgnoreCase("1"))
			{
				out.println("class=\"sub_tab_inactive\">");
				out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','govtsponschklist','checkeligibityforgovtsponsor','ops_sponsoreligibiltyresult.jsp')\" >");
				out.println("Eligibility CheckList</a></b>");
			}
			out.println("</td>");
			
			}
			out.println("</tr>");
			out.println("</table>");
			
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in TerApplicantHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

