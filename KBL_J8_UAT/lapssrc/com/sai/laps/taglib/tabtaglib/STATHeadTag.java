package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class STATHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String pageId = "";
	static Logger log=Logger.getLogger(STATHeadTag.class);
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
			
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class='outertable'>");
			out.println("<tr align='center'> ");

			out.println("<td width='11%' ");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>General</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('StatusNote_page1.jsp','npacommon','getGeneralinfoData')\" >");
				out.println("General</a></b>");
			}
			out.println("</td>");
						
			out.println("<td width='11%' ");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Present Position</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('PresentPositionstatus.jsp','npacommon','getPresentPosition')\" >");
				out.println("Present Position</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 3)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('StatusNote_page2.jsp','npa','getstatusnotepage2Data')\" >");
				out.println("Comments</a></b>");
			}
			out.println("</td>");

			out.println("<td width='11%' ");
			if(pageid == 6)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>History</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('StatusNote_page3.jsp','npacommon','getGeneralHistoryData')\" >");
				out.println("History</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 7)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>OTS Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('npastatusnote_ots.jsp','npacommon','getStatusnoteOTS')\" >OTS Comments</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 8)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Sarfaesia Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('npastatusnote_sarfaesia.jsp','npacommon','getStatusNoteSarfaesia')\" >Sarfaesia Comments</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 9)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Suit Filed Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('statusnote_suitfield.jsp','npa','getstatusSuitfield')\" >Suit Filed Comments</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width='11%' ");
			if(pageid == 10)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Audit Observations</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:callLink('StatusNote_page4.jsp','npacommon','getStatusnotepage4')\" >");
				out.println("Audit Observations</a></b>");
			}
			out.println("</td>");

			out.println("<td width='11%' ");
			if(pageid == 11)
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
			log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

