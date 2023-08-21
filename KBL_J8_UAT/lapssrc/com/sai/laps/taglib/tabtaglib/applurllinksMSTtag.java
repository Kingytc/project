package com.sai.laps.taglib.tabtaglib;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class applurllinksMSTtag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String strPageid="";
	String strValuesin="";
	static Logger log=Logger.getLogger(applurllinksMSTtag.class);
	
	public void setPageid(String pageid)
	{
		this.strPageid = Helper.correctNull(pageid).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		
		strValuesin =  Helper.correctNull(request.getParameter("valuesin"));
		
		try
		{
			out = pageContext.getOut();
			out.println("<table width=100% border=1 cellpadding=0 cellspacing=1 class=\"outertable\">");
			out.println("<tr align=\"center\"> ");
			out.println("<td>");
			if(strValuesin.equals("L"))
			{
				out.println("<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Lacs) </b></font> ");
			}
			else if(strValuesin.equals("C"))
			{
				out.println("<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Crores) </b></font> ");
			}
			
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class=\"outertable\">");
			out.println("<tr align=\"center\"> ");
			if(strPageid.equals("1"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Facilities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getfacilityData','commst_facilities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities';return true;\""+
						"class=\"blackfont\">Facilities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("2"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Securities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getSecuritesData','commst_securities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Securities';return true;\""+
						"class=\"blackfont\">Securities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("3"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Financial Highlights");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getFinancialData','commst_financial.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Financial Highlights';return true;\""+
						"class=\"blackfont\">Financial Highlights</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("4"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Modification Sought");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getModsoughtData','commst_modificationsought.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Modification Sought';return true;\""+
						"class=\"blackfont\">Modification Sought</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("5"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Value of Account");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getValueofAccountData','commst_valueofaccount.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Value of Account';return true;\""+
						"class=\"blackfont\">Value of Account</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("7"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Recommendations");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getRecommendationData','commst_recommendations.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Recommendations';return true;\""+
						"class=\"blackfont\">Recommendations</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("6"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Remarks");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getRemarksData','commst_remarks.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Remarks';return true;\""+
						"class=\"blackfont\">Remarks</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("8"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Workflow");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getMSTHistory','commst_worflowhistory.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Workflow';return true;\""+
						"class=\"blackfont\">Workflow</a>" );
				out.print("</b></td>");
			}
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in applurllinksMST.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}