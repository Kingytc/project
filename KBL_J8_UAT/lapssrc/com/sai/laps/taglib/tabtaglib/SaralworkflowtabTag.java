package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class SaralworkflowtabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SaralworkflowtabTag.class);
	String strTabid="";
	
	
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
			out.println("<table width='40%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"sub_tab_active\" align=center width=\"20%\"><b>");
				out.print("History");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\" align=center width=\"20%\"><b>");
			    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='History';return true;\""+
						">History</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class=\"sub_tab_active\" align=center width=\"20%\"><b>");
				out.print("Action");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\" align=center width=\"20%\"><b>");
			    out.print("<a href=\"JavaScript:gotoTabpage('"+ApplicationParams.getAppUrl()+"','inwardworflowaction.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Action';return true;\""+
						">Action</a>" );
				out.print("</b></td>");
			}
			
			out.println("<td class=\"sub_tab_inactive\" align=center width=\"20%\"><b>");
			out.print("<a href=\"JavaScript:callRemarks()\"");
			out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Remarks';return true;\""+
						">Remarks</a>" );
			out.print("</b></td>");
			
			
			out.println("</tr>");
			out.println("</table>");
			
		}
		catch(Exception e)
		{
			log.error("exception in SaralworkflowtabTag :: "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}