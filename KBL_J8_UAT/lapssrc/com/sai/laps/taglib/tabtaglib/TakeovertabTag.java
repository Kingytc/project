package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;

public class TakeovertabTag extends TagSupport 
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TakeovertabTag.class);
	String strTabid="";
	String strIstakeover="";
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setIstakeover(String istakeover)
	{
		this.strIstakeover = Helper.correctNull(istakeover).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			out.println("<table  border='0' cellpadding='3' cellspacing='1' class='outertable' width='45%'>");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"sub_tab_active\" align=center width='15%'>");
				out.print("Take Over");
				out.print("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\" align=center width='15%'>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','gettakeover','com_istakeover.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" + " onMouseOver=\"window.status='Take Over';return true;\">Take Over</a>" );
				out.print("</td>");
			}
			if(strIstakeover.equals("1"))
			{
				if(strTabid.equals("2"))
				{
					out.print("<td class=\"sub_tab_active\" align=center width='15%'>");
					out.print("Take Over Norms");
					out.print("</td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" align=center width='15%'>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','gettakeoverterm','com_takeoverterm.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" + " onMouseOver=\"window.status='Take Over Norms';return true;\">Take Over Norms</a>" );
					out.print("</td>");
				}
				/*if(strTabid.equals("3"))
				{
					out.print("<td class=\"sub_tab_active\" align=center width='15%'>");
					out.print("Trade &amp; Services");
					out.print("</td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" align=center width='15%'>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','gettakeoverworking','com_takeoverworking.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" + " onMouseOver=\"window.status='Trade &amp; Services';return true;\">Trade &amp; Services</a>" );
					out.print("</td>");
				}*/
			}
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in TakeovertabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}