package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;

public class CompropbriefbackgrondtabTag extends TagSupport 
{
	private static final long serialVersionUID = 1L;
	String strTabid="";
	static Logger log=Logger.getLogger(CompropbriefbackgrondtabTag.class);
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			out.println("<table width=45% border=0 cellpadding=3 cellspacing=4 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("Borrower Demographics ");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getData','com_companydet.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Borrower Demographics ';return true;\""+
						"class=\"blackfont\">Borrower Demographics </a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("Nature of Activities");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getData','com_activitydet.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Nature of Activities';return true;\""+
						"class=\"blackfont\">Nature of Activities</a>" );
				out.print("</b></td>");
			}
			
			if(strTabid.equals("3"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("Evaluation");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','executive','getData3','exec_page3.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Evaluation';return true;\""+
						"class=\"blackfont\">Evaluation</a>" );
				out.print("</b></td>");
			}
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in CompropbriefbackgrondtabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}