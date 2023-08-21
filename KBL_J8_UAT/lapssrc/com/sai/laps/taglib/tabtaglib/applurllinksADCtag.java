package com.sai.laps.taglib.tabtaglib;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class applurllinksADCtag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(applurllinksADCtag.class);
	private static final long serialVersionUID = 1L;
	String strPageid="";
	String strValuesin="";
	
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
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=4 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
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
			out.println("<tr> ");
			if(strPageid.equals("1"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Facilities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getFacilityData','adc_facilities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities';return true;\""+
						"class=\"blackfont\">Facilities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("2"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Securities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comsecurities','getData','com_securities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Securities';return true;\""+
						"class=\"blackfont\">Securities</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("3"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Banking Details");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getBankingDetails','adc_bankingdetails.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Banking Details';return true;\""+
						"class=\"blackfont\">Banking Details</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("4"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Financial");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getFinancial','adc_financials.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Financial';return true;\""+
						"class=\"blackfont\">Financial</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("5"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Guarantee");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getGuaranteeData','adc_guaranteecomments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Guarantee';return true;\""+
						"class=\"blackfont\">Guarantee</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("6"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Comments");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getComments','adc_comments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Comments';return true;\""+
						"class=\"blackfont\">Comments</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("7"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Limit Sought");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getLimitSought','adc_limitcomments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Limit Sought';return true;\""+
						"class=\"blackfont\">Limit Sought</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("8"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Terms and Cond.");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','gettermscond','adc_termscond.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Terms and Cond.';return true;\""+
						"class=\"blackfont\">Terms and Cond.</a>" );
				out.print("</b></td>");
			}
			
			if(strPageid.equals("9"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Recommendations");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getRecommendations','adc_recommendations.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Recommendations';return true;\""+
						"class=\"blackfont\">Recommendations</a>" );
				out.print("</b></td>");
			}
			if(strPageid.equals("10"))
			{
				out.print("<td class=\"tabactivenew\" align=center><b>");
				out.print("Workflow");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adhoc','getADCHistory','adc_workflowhistory.jsp')\"");
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