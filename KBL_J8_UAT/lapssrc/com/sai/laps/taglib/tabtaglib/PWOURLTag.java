package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class PWOURLTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
			out.println("<tr align='center'> ");

			out.println("<td width='12%' ");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>General</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('prudential_general.jsp','npacommon','getGeneralinfoData')\" >");
				out.println("General </a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 2)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>History</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('prudential_history.jsp','npa','getprudentialpage2Data')\" >");
				out.println("History</a></b>");
			}
			out.println("</td>");

			out.println("<td width='12%' ");
			if(pageid == 3)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('prudential_comments.jsp','npacommon','getGeneralHistoryData')\" >");
				out.println("Comments</a></b>");
			}
			out.println("</td>");

			out.println("<td width='12%' ");
			if(pageid == 4)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Present Position</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('prudential_presentposition.jsp','npacommon','getPresentPosition')\" >");
				out.println("Present Position</a></b>");
			}
			out.println("</td>");	
			
			out.println("<td width='12%' ");
			if(pageid == 7)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Audit Details</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('prudential_auditirregularities.jsp','npacommon','getAuditorsObservation')\" >");
				out.println("Audit Details</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 9)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Signatories</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('npa_pawosignatories.jsp','npacommon','getsignatories')\" >");
				out.println("Signatories</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 10)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Recommendations </b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('npa_paworecommendations.jsp','npacommon','getorganisationrecmmendations')\" >");
				out.println("Recommendations</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 8)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Workflow</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('npa_appworkflowhistory.jsp','commworkflow','getNPAHistory')\" >Workflow</a></b>");
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
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

