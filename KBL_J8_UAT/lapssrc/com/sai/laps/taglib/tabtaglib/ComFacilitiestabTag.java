package com.sai.laps.taglib.tabtaglib;

import javax.jms.Session;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class ComFacilitiestabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComFacilitiestabTag.class);
	String strTabid="";
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		HttpSession session = pageContext.getSession();
		try
		{
			out = pageContext.getOut();
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");
			if(strTabid.equals("1"))
			{
				out.print("<td width=7% class=\"sub_tab_active\">");
				out.print("Facilities");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=7% class=\"sub_tab_inactive\">");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','facilities','getFacilityData','facilities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facilities';return true;\""+
						">Facilities</a>" );
				out.print("</td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td width=12% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Customer Profile");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=12% class=\"sub_tab_inactive\"  nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotocusprofile('"+ApplicationParams.getAppUrl()+"','perapplicantdispco.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Customer Profile';return true;\""+
						">Customer Profile</a>" );
				out.print("</td>");
			}			
		
			if(strTabid.equals("3"))
			{
				out.print("<td width=7% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Brief History");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=7% class=\"sub_tab_inactive\"  nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','facilities','getComments','com_briefhistory.jsp','brief')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Brief History';return true;\""+
						">Brief History</a>" );
				out.print("</td>");
			}
			
			if(strTabid.equals("5"))
			{
				out.print("<td width=15% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Management Information");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\"  nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','','','com_managementinfo.jsp','MangementInfo')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Management Information';return true;\""+
						">Management Information</a>" );
				out.print("</td>");
			}
			
			if(strTabid.equals("4"))
			{
				out.print("<td width=15% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Gist of Proposal<br/>(Introduction)");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\"  nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','facilities','getComments','com_gistproposal.jsp','gist')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Gist of Proposal';return true;\""+
						">Gist of Proposal<br/>(Introduction)</a>" );
				out.print("</td>");
			}
			
			if(strTabid.equals("6"))
			{
				out.print("<td width=10% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Details of proposal <br/>(for Assessment)");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=10% class=\"sub_tab_inactive\"  nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','facilities','getComments','com_presentproposal.jsp','presentproposal')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Details of present proposal';return true;\""+
						">Details of proposal<br/> (for Assessment)</a>" );
				out.print("</td>");
			}
			
			if(strTabid.equals("7"))
			{
				out.print("<td width=20% class=\"sub_tab_active\"  nowrap=\nowrap\">");
				out.print("Other Interest Rates / Commission");
				out.print("</td>");
			}
			else
			{
				out.println("<td width=20% class=\"sub_tab_inactive\" nowrap=\nowrap\">");
				out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','facilities','getCommentsonInterestRate','com_commentsonintrestrate.jsp','commentsonintrestrate')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Other Interest Rates / Commission';return true;\""+
						">Other Interest Rates /<br/> Commission</a>" );
				out.print("</td>");
			}
			
		
			if(session.getAttribute("StrDigiLoanType").equals("PC"))
			{
				if(strTabid.equals("8"))
				{
					out.print("<td width=20% class=\"sub_tab_active\"  nowrap=\nowrap\">");
					out.print("Verification");
					out.print("</td>");
				}
				else
				{
					out.println("<td width=20% class=\"sub_tab_inactive\" nowrap=\nowrap\">");
					out.print("<a href=\"JavaScript:gotoCommentsTab('"+ApplicationParams.getAppUrl()+"','MsmeDigitalAppInterface','msmeGetDigiDecisionDetail','appl_digitalisation_decision_msme.jsp','')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Verification';return true;\""+
							">Verification</a>" );
					out.print("</td>");
				}
			}
			
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in ComFacilitiestabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}