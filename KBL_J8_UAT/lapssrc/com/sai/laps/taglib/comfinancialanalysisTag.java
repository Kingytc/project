package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class comfinancialanalysisTag extends TagSupport 
{
	
	static Logger log=Logger.getLogger(comfinancialanalysisTag.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String tabId = "";
	public void setTabid(String tabid)
	{
		tabId = tabid;
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int tabid = Integer.parseInt(tabId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable' align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table border=0 cellpadding=3 cellspacing=1 class='outertable' width='70%'>");
			out.println("<tr align=\"center\"> ");

			out.println("<td");
			if(tabid==1)
			{
				out.println("class='sub_tab_active' width='10%' nowrap='nowrap'>");
				out.println("Ratios");
			}
			else
			{
				out.println("class='sub_tab_inactive' width='10%' nowrap='nowrap'>");
				out.println("<a href=\"#\" onclick=\"gototab('financial','getDataRatio','finratio.jsp','RA1')\">");
				out.println("Ratios</a>");
			}
			out.println("</td>");
			
			out.println("<td");
			if(tabid==11)
			{
				out.println("class='sub_tab_active' width='15%' nowrap='nowrap'>");
				out.println("Deviation from Loan Policy");
			}
			else
			{
				out.println("class='sub_tab_inactive' width='15%' nowrap='nowrap'>");
				out.println("<a href=\"#\" onclick=\"gototab('financial','getBenchMarkParam','com_benchmarkparam.jsp','BR')\">");
				out.println("Deviation from Loan Policy</a>");
			}
			out.println("</td>");
			
			out.println("<td");
			if(tabid==5)
			{
				out.println("class='sub_tab_active' width='15%' nowrap='nowrap' >");
				out.println("Financial Position Comments");
			}
			else
			{
				out.println("class='sub_tab_inactive' width='15%' nowrap='nowrap'>");
				out.println("<a href=\"#\" onclick=\"gototab('compro','getFinancialComments','FinPositionComm.jsp','COM')\">");
				out.println("Financial Position Comments</a>");
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
			log.error("exception in comfinancialanalysisTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

