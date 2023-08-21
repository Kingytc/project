package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class MSTSecuritytabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MSTSecuritytabTag.class);
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
			out.println("<table width=40% border=0 cellpadding=3 cellspacing=4 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"tabactivenew\" align=center ><b>");
				out.print("<b>Details of Secutites</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getSecuritesData','commst_securities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Details of Secutites';return true;\""+
						"class=\"blackfont\">Details of Secutites</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class=\"tabactivenew\" align=center ><b>");
				out.print("<b>Charges on Securities</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','modsancterms','getFacSecurityData','commst_facsecurity.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Charges on Securities';return true;\""+
						"class=\"blackfont\">Charges on Securities</a>" );
				out.print("</b></td>");
			}
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MSTSecuritytabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}