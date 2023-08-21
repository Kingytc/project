package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MONHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MONHeadTag.class);
	String pageId = "";
	String strReviewOf="";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setReviewof(String strreviewof)
	{
		strReviewOf = strreviewof;
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
			
			out.println("<table width=100% border=0 cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");			
			out.println("<td");
			if(pageid==1)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Limit Register</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('limit_register.jsp','Register','getLimitRegister')\">");
				out.println("Limit Register</a></b>");
			}
			out.println("</td>");			
			out.println("<td");
			if(pageid==2)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Insurance Register</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('insurance_register.jsp','Register','getInsuranceDetails')\">");
				out.println("Insurance Register</a></b>");
			}

			out.println("</td>");			
			out.println("<td");
	       	if(pageid==3)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Security Details</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_securityregirter.jsp','Register','getmonSecurityregister')\">");
				out.println("Security Details</a></b>");
			}
			out.println("</td>");
					
			out.println("<td");
			if(pageid==5)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Document Register</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('document_register.jsp','Register','getDocumentRegister')\">");
				out.println("Document Register</a></b>");
			}
			out.println("</td>");
			
			out.println("<td");
			if(pageid==6)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Monitoring CheckList</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_checklist.jsp','Register','getmonitorchecklist')\">");
				out.println("Monitoring CheckList</a></b>");
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

