package com.sai.laps.taglib;


import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;


public class MONTHLYHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8403562746188638675L;
	static Logger log=Logger.getLogger(MONTHLYHeadTag.class);
	/**
	 * 
	 */
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
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1>");
			out.println("<tr align='center' height='25%'> ");
			out.println("<td width=\"9.09%\"");
			if(pageid==1)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Facilities Enjoyed</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_facilitiesenjoyed.jsp','mmrcommon','getMMRFacility')\" >");
				out.println("Facilities Enjoyed</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width=\"9.09%\"");
			if(pageid==2)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Borrower Info</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_personalinfo.jsp','mmrcommon','getBorrowerinfo')\" >");
				out.println("Borrower Info</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width=\"9.09%\"");
			if(pageid==13)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>General Info</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_generalinfo.jsp','mmrcommon','getGeneralInfo')\" >");
				out.println("General Info</a></b>");
			}
			out.println("</td>");
	
			out.println("<td width=\"9.09%\"");
			if(pageid==3)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Int/Inst. Recovered</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_recovered.jsp','mmrcommon','getRecoveredStatement')\" >");
				out.println("Int/Inst. Recovered </a></b>");
			}
			out.println("</td>");		
			
			out.println("<td width=\"9.09%\"");
			if(pageid==4)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Limit Unhedged Details</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_hedgeddetails.jsp','mmrcommon','gethedgeddetails')\" >");
				out.println("Limit Unhedged Details</a></b>");
			}
			out.println("</td>");
			
			
			out.println("<td width=\"9.09%\"");
			if(pageid==5)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Accountwise Details</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_accountwisedetails.jsp','mmrcommon','getAccountwise')\" >");
				out.println("Accountwise Details</a></b>");
			}
			out.println("</td>");
			out.println("<td width=\"9.09%\"");
	       	if(pageid==6)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Ins - Security Details</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_securityinsurancemapping.jsp','Register','getSecuInsuranceMapping')\" >");
				out.println("Ins - Security Details</a></b>");
			}
			out.println("</td>");					
			out.println("<td width=\"9.09%\"");
			if(pageid==8)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Monitoring Info</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_monitoringinfo.jsp','mmrcommon','getMonitoringInfo')\" >");
				out.println("Monitoring Info</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width=\"9.09%\"");
			if(pageid==9)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Auditor Inspection</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_auditinspection.jsp','Register','getAuditorsInspection')\" >");
				out.println("Auditor Inspection</a></b>");
			}
			out.println("</td>");
			
			out.println("<td width=\"9.09%\"");
			if(pageid==10)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Branch Head Comments</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_commentsbybranchhead.jsp','Register','getbranchcomments')\" >");
				out.println("Branch Head Comments</a></b>");
			}
			out.println("</td>");
			out.println("<td width=\"9.09%\"");
			if(pageid==11)
			{
				out.println("class='main_tab_active'>");
				out.println("<b>Workflow</b>");
			}
			else
			{
				out.println("class='main_tab_inactive'>");
				out.println("<b><a href=\"javascript:callLink('mon_appworkflowhistory.jsp','commworkflow','getMONHistory')\" >");
				out.println("Workflow</a></b>");
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
			log.error("exception in MonthlyMonitorHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

