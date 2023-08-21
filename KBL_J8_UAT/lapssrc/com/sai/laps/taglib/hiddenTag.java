package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;


public class hiddenTag extends TagSupport
{

	private static final long serialVersionUID = -8703184317734513861L;
	static Logger log=Logger.getLogger(hiddenTag.class);
	String strPageId=null;
	JspWriter out=null;
	public void setPageid(String pageid)
	{
		this.strPageId = pageid.trim();
		out = pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
    {
        try
        {
        	out= super.pageContext.getOut();
        	
            out.print("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
            out.print("<tr>");
            out.print("<td><input type=\"hidden\" name=\"hidAction\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanId\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanGetMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidSourceUrl\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hideditflag\" value=\"N\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidparam\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidTabName\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidOtherMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidRecordflag\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidPageId\" value='"+strPageId+"'></td>");
            out.print("</tr>");
            out.println("</table>");
        }
        catch(Exception exception)
        {
        	log.error("exception in hiddenTag.. " + exception);
            throw new JspException(exception.getMessage());
        }
        return EVAL_PAGE;
    }
}