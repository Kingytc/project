package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class applurllinkSRE extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(applurllinkSRE.class);
	private static final long serialVersionUID = 1L;
	String strPageid="";
	String strCategory="";
	String strValuesin="";
	
	public void setPageid(String pageid)
	{
		this.strPageid = Helper.correctNull(pageid).trim();
	}
	
	public void setCategory(String category)
	{
		this.strCategory = Helper.correctNull(category).trim();
	}
	
	public void setValuesin(String valuesin)
	{
		this.strValuesin = Helper.correctNull(valuesin).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=3 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
			out.println("<td colspan=\"10\">");
			out.println("<span id=\"idvalues\" >");
			if(strValuesin.equals("L"))
			{
				out.println("<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Lacs) </b></font>");
			}
			else if(strValuesin.equals("C"))
			{
				out.println("<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Crores) </b></font>");
			}
			out.println("</span>");
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr> ");
			if(strPageid.equals("1"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"7%\"><b>");
				out.print("Facilities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"7%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','facilities','getFacilityData','facilities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities';return true;\""+
						"class=\"blackfont\">Facilities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("2"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"8%\"><b>");
				out.print("Promotors");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"8%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','compro','getValues','compromoters.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Promotors';return true;\""+
						"class=\"blackfont\">Promotors</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("3"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"12%\"><b>");
				out.print("Banking Arrangement");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"12%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','bankapp','getData','combanking.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Banking Arrangement';return true;\""+
						"class=\"blackfont\">Banking Arrangement</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("4"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"10%\"><b>");
				out.print("Brief Background ");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"10%\"><b>");
				out.print("<a href=\"JavaScript:gotoTabpage('"+ApplicationParams.getAppUrl()+"','com_companydet.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Repayment Terms';return true;\""+
						"class=\"blackfont\">Brief Background</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("5"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"7%\"><b>");
				out.print("Oper. Details");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"7%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getDataOper','com_operdet.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Oper. Details';return true;\""+
						"class=\"blackfont\">Oper. Details</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("6"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"7%\"><b>");
				out.print("Terms and Conditions");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"7%\"><b>");
				out.print("<a href=\"JavaScript:gotoTabpage('"+ApplicationParams.getAppUrl()+"','comtermsandcond.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Terms and Conditions';return true;\""+
						"class=\"blackfont\">Terms and Conditions</a>" );
				out.print("</b></td>");
			}
			
			if(strPageid.equals("7"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"14%\"><b>");
				out.print("Facilities & Charges");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"14%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','bankgetdata','getBankData','com_priworkcapital.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities & Charges';return true;\""+
						"class=\"blackfont\">Facilities & Charges</a>" );
				out.print("</b></td>");
			}			
			if(strPageid.equals("8"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"15%\"><b>");
				out.print("Collateral Security");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"15%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','executive','getCollateralSecurity','com_collateral.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Collateral Security';return true;\""+
						"class=\"blackfont\">Collateral Security</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("9"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"8%\"><b>");
				out.print("Executive Summary");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"8%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBSTHistory','combst_workflowhistroy.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Executive Summary';return true;\""+
						"class=\"blackfont\">Executive Summary</a>" );
				out.print("</b></td>");
			}
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in applurllinkbst.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}