package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class SUITHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String pageId = "";
	static Logger log=Logger.getLogger(SUITHeadTag.class);
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
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable'>");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");

			out.println("<td  width='11%' ");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>General</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('34PointsFormat_page1.jsp','npacommon','getGeneralinfoData')\">");
				out.println("General </a></b>");
			}
			out.println("</td>");
			
			out.println("<td  width='11%' ");
			if(pageid == 2)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Limit Sanctioned</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('filingofsuit_limitsanctioned.jsp','npa','getFilingLimitSanctioned')\">Limit Sanctioned</a></b>");
				
			}
			out.println("</td>");					
			out.println("<td width='11%' ");
			if(pageid == 5)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Term Loan</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('filingofsuit_termloan.jsp','npa','getFilingtermloan')\">Term Loan</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 6)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Present Position</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('34PointsFormat_presentpos.jsp','npacommon','getPresentPosition')\">");
				out.println("Present Position</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 7)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Banking Details</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('34PointsFormat_page4.jsp','npa','get34pointspage4Data')\">");
				out.println("Banking Details</a></b>");
				
			}
			out.println("</td>");
			
			
			out.println("<td width='11%' ");
			if(pageid == 8)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Present ROI</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('filingofsuitpresentrate.jsp','npa','getFilingPresentrate')\">Present ROI</a></b>");
				
			}
			out.println("</td>");
			out.println("<td width='11%' ");
			if(pageid == 9)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Recovery</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('filingofsuit_deposit.jsp','npa','getFilingDeposit')\">Recovery</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 12)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Audit Observations</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('filing_auditor.jsp','npacommon','getAuditorsObservation')\">Audit Observations </a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 15)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>History</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_suithistory.jsp','npacommon','getGeneralHistoryData')\">History</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 10)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Comments</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('34PointsFormat_page6.jsp','npa','get34pointspage6Data')\">Comments</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 13)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Signatories</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_suitsignatories.jsp','npacommon','getsignatories')\">");
				out.println("Signatories</a></b>");
				
			}
			out.println("</td>");
			out.println("<td width='11%' ");
			if(pageid == 14)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Recommendations </b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_suitrecommendations.jsp','npacommon','getorganisationrecmmendations')\">");
				out.println("Recommendations</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 11)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Workflow</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_appworkflowhistory.jsp','commworkflow','getNPAHistory')\">Workflow</a></b>");
				
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

