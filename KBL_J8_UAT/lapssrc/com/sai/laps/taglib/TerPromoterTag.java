package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;

public class TerPromoterTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TerPromoterTag.class);
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
			
			out.println("<table width='50%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");			
			out.println("<td ");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>Demographics</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','mastapplicant','getDemographics','ops_applicantdisp.jsp')\">");
				out.println("Demographics</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'> ");
				out.println("<b>KYC Norms</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','mastapplicant','getKYCNormsdetails','perkycnormsdisp.jsp')\">");
				out.println("KYC Norms</a></b>");
				
			}
			out.println("</td>");
			
			out.println("<td ");
			if(pageid==3)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Income & Expenses</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'> ");
				out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','mastapplicant','getIncome','perincexpensesdispco.jsp')\">");
				out.println("Income & Expenses</a></b>");
				
			}
			out.println("</td>");
			out.println("<td ");
			if(pageid==4)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Employment</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:gotoTab('"+ApplicationParams.getAppUrl()+"','mastapplicant','getEmployer','peremployerdispco.jsp')\">");
				out.println("Employment</a></b>");
				
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
			log.error("exception in MSODHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

