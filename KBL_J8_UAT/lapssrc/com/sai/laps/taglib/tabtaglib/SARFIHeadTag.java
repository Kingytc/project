package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class SARFIHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SARFIHeadTag.class);
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
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable' >");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=100% border=0 cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");

			out.println("<td width='12%' ");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b> General</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('SarfaeriProposal_page1.jsp','npacommon','getGeneralinfoData')\" >");
				out.println("General</a></b>");
			}
			out.println("</td>");
			out.println("<td width='12%' ");
			if(pageid == 2)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Present Position</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('PresentPosition_npa.jsp','npacommon','getPresentPosition')\" >");
				out.println("Present Position</a></b>");
			}
			out.println("</td>");			
			out.println("<td width='12%' ");
			if(pageid == 8)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Documentation</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('Sarfaeri_documentation.jsp','npa','getSarfaesiDocument')\" >");
				out.println("Documentation</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 4)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Complaint</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('SarfaeriProposal_page2.jsp','npa','getsarfaeripage2Data')\" >");
				out.println("Complaint</a></b>");
			}
			out.println("</td>");

			out.println("<td width='12%' ");
			if(pageid == 5)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Disposal of Securities</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('SarfaeriProposal_page3.jsp','npa','getsarfaeripage3Data')\" >");
				out.println("Disposal of Securities</a></b>");
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
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_sarfisignatories.jsp','npacommon','getsignatories')\" >");
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
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_sarfirecommendations.jsp','npacommon','getorganisationrecmmendations')\" >");
				out.println("Recommendations</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='12%' ");
			if(pageid == 6)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Workflow</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_appworkflowhistory.jsp','commworkflow','getNPAHistory')\" >Workflow</a></b>");
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

