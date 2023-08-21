package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class OTSCOHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(OTSCOHeadTag.class);
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
					
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' >");
			out.println("<tr align='center'> ");

			out.println("<td");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>General</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_generalinfo.jsp','npacommon','getGeneralinfoData')\" >");
				out.println("General</a></b>");
				
			}
			out.println("</td>");

			out.println("<td");
			if(pageid == 2)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>History</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_history.jsp','npacommon','getGeneralHistoryData')\" >");
				out.println("History</a></b>");
				
			}
			out.println("</td>");

			out.println("<td ");
			if(pageid == 3)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Present Position</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npacompromise_presentposition.jsp','npacommon','getPresentPosition')\" >");
				out.println("Present Position</a></b>");
				
			}
			out.println("</td>");

			out.println("<td ");
			if(pageid == 6)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Comments</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_comments.jsp','npa','getcompromisecomments')\" >");
				out.println("Comments</a></b>");
				
			}
			out.println("</td>");

			out.println("<td");
			if(pageid == 7)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Evaluation</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_evaluation.jsp','npa','getcompromisepage3Data')\" >Evaluation</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid == 11)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Modular Dues</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_modulardues.jsp','npa','getCompromiseModulardues')\" >Modular Dues</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid == 10)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Relief Sought</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseReliefSought.jsp','npa','getCompromiseReliefSought')\" >Relief Sought</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid == 12)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Terms &amp; Condition</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_otstermscond.jsp','npa','getcompromisetermscond')\" >Terms &amp; Condition</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid == 13)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Signatories</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('npa_otscosignatories.jsp','npacommon','getsignatories')\" >Signatories</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td");
			if(pageid == 8)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Recommendations</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"#\" onClick=\"javascript:callLink('CompromiseProposal_recommendations.jsp','npacommon','getorganisationrecmmendations')\" >Recommendations</a></b>");
				
			}
			out.println("</td>");
			
			
			out.println("<td ");
			if(pageid == 9)
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

