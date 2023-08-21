package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class applurllinkbst extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String strPageid="";
	String strCategory="";
	String strValuesin="";
	static Logger log=Logger.getLogger(applurllinkbst.class);
	
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
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class=\"outertable\">");
			out.println("<tr> ");
			out.println("<td colspan=\"10\">");
			out.println("<span id=\"idvalues\" >");
			if(strValuesin.equals("L"))
			{	
				out.println("<FONT SIZE=\"1\" class=\"mantatory\"><b>(Amount Rs. in Lacs) </b></font>");
			}
			else if(strValuesin.equals("C"))
			{
				out.println("<FONT SIZE=\"1\" class=\"mantatory\"><b>(Amount Rs. in Crores) </b></font>");
			}
			out.println("</span>");
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr align='center'>");
			if(strPageid.equals("1"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Facilities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBSTfacility','combst_facility.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities';return true;\""+
						"class=\"blackfont\">Facilities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("2"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Securities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getDataBSTSecurity','combst_securities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Securities';return true;\""+">Securities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("11"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Banking Details");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBankingArrangementData','combst_bankingdetails.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +" onMouseOver=\"window.status='Banking Details';return true;\""+
						">Banking Details</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("3"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Cost of the Project");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','bankapp','getCostofData','com_costofproject.jsp?hidPageSource=COP')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Cost of the Project';return true;\""+
						">Cost of the Project</a>" );
				out.print("</b></td>");
			}

			if(strPageid.equals("4"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Repayment Terms");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBroadTermsProposalComments','com_broadtermscomments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Repayment Terms';return true;\""+
						">Repayment Terms</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("5"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Financial");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBroadTermsProposalFinancial','com_broadtermfin.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Financial';return true;\""+
						">Financial</a>" );
				out.print("</b></td>");
			}
			out.println("</tr>");
			out.println("<tr align='center'>");
			if(strPageid.equals("6"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Comments");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBroadTermsProposalComments','com_broadtermspromcomments.jsp?hidpage=creditrating~promotorsbackground~projectnature~loanpolicy~guarantee~procfees')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Comments';return true;\""+
						">Comments</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("12"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Defaulters List");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getDefaultersListData','combst_defaulterslist.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Defaulters List';return true;\""+
						">Defaulters List</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("7"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Customer Profitability");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBSTCustProfitData','combst_custprofit.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Customer Profitability';return true;\""+
						">Customer Profitability</a>" );
				out.print("</b></td>");
			}			
			if(strPageid.equals("8"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Recommending Office Comments");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBroadTermsProposalComments','com_bstbranchcomments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Recommending Office Comments';return true;\""+
						">Recommending Office Comments</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("9"))
			{
				out.print("<td class=\"main_tab_active\"><b>");
				out.print("Workflow");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','broadsancterms','getBSTHistory','combst_workflowhistroy.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Workflow';return true;\""+
						">Workflow</a>" );
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