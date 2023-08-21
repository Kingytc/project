package com.sai.laps.taglib;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;


import com.sai.laps.helper.Helper;


public class agrhiddenTag extends TagSupport
{
	static Logger log=Logger.getLogger(agrhiddenTag.class);
    private static final long serialVersionUID = 7165309627682060569L;
    String strPageId=null;
	JspWriter out=null;
	public void setPageid(String pageid)
	{
		this.strPageId = pageid.trim();
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
    {
		ServletRequest request = null;
		request = pageContext.getRequest();
		
		String strApplicantid=Helper.correctNull((String)request.getParameter("hidapplicantid"));
		String appstatus=Helper.correctNull((String)request.getParameter("appstatus"));
		String strAppno=Helper.correctNull((String)request.getParameter("appno"));
		String strAppname=Helper.correctNull((String)request.getParameter("appname"));
		String strApploantype=Helper.correctNull((String)request.getParameter("apploantype"));
		String strInwardno=Helper.correctNull((String)request.getParameter("inwardno"));
		String strReadFlag=Helper.correctNull((String)request.getParameter("readFlag"));
		String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
		String strAppholder=Helper.correctNull((String)request.getParameter("appholder"));
		String strbtnenable=Helper.correctNull((String)request.getParameter("btnenable"));
		String strCatgoryType=Helper.correctNull((String)request.getParameter("hidCategoryType"));
		String strApporgname=Helper.correctNull((String)request.getParameter("apporgname"));
		String strAppstatus=Helper.correctNull((String)request.getParameter("strappstatus"));
		String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
        try
        {
            JspWriter out = super.pageContext.getOut();
            out.print("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
            out.print("<tr>");
            out.print("<td><input type=\"hidden\" name=\"hidAction\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanId\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidBeanGetMethod\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidSourceUrl\"></td>");
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td><input type=\"hidden\" name=\"hidapplicantid\" value =\""+strApplicantid+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"appstatus\" value=\""+appstatus+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"appno\" value=\""+strAppno+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"appname\" value=\""+strAppname+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"apploantype\" value=\""+strApploantype+"\"></td>");
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td><input type=\"hidden\" name=\"inwardno\" value=\""+strInwardno+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"readFlag\" value=\""+strReadFlag+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"applevel\" value=\""+strApplevel+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"appholder\" value=\""+strAppholder+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"btnenable\" value=\""+strbtnenable+"\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hideditflag\" value=\"N\"></td>");
            out.print("<td><input type=\"hidden\" name=\"hidCategoryType\" value=\""+strCatgoryType+"\"></td>");
            out.println("<input type=\"hidden\" name=\"apporgname\" value=\""+strApporgname+"\">");
            out.println("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			out.println("<input type=\"hidden\" name=\"strappstatus\" value=\""+strAppstatus+"\">");
			out.println("<input type=\"hidden\" name=\"hidPageId\" value=\""+strPageId+"\">");
            out.print("</tr>");
            out.println("</table>");
        }
        catch(Exception exception)
        {
        	log.error("exception in agrhiddenTag.. " + exception);
            throw new JspException(exception.getMessage());
        }
        return EVAL_PAGE;
    }
}