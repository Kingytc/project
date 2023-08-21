package com.sai.laps.taglib;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;

public class InwardHeadtag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(InwardHeadtag.class);
	
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		HttpSession httpSession=pageContext.getSession();
		request = pageContext.getRequest();
		String inwardno = Helper.correctNull(request.getParameter("inwardno"));
		String appname = Helper.correctDoubleQuotesHtml(request.getParameter("appname"));
		String strSector = Helper.correctNull(request.getParameter("hidsector"));
		String strSaral= Helper.correctNull(request.getParameter("hidsaral"));
		String strIssaralhead= Helper.correctNull(request.getParameter("issaralhead"));
		
		String strAppAssign= Helper.correctNull(request.getParameter("hidappassign"));
		String strAppAtached= Helper.correctNull(request.getParameter("hidappatached"));
		String strValuesIn= Helper.correctNull(request.getParameter("valuesin"));
		String strStatus= Helper.correctNull(request.getParameter("hidstatus"));
		String ISOrgHead= Helper.correctNull(request.getParameter("isorghead"));
		String strappliedfor= Helper.correctNull(request.getParameter("appliedfor"));
		String grpRights = Helper.correctNull((String)httpSession.getAttribute("strGroupRights"));
		String strright="";
		String strAppOrgName= Helper.correctNull(request.getParameter("apporgname"));
		String strProposal= Helper.correctNull(request.getParameter("hidproposal"));
		
		try
		{
			if(grpRights.length()>0)
			{
				int len = grpRights.length();
				 strright= grpRights.substring(len-1);
				
			}
			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.print("<tr class=\"applicationheader\">");
			out.print("<td width=\"10%\">");
			out.print("<b>Inward Number</b>");
			out.print("</td>");
			out.print("<td width=\"7%\" align=\"left\"><b>" +inwardno+"</b>");
			out.print("<input type=\"hidden\" name=\"inwardno\" value=\""+inwardno+"\"></b>  </td>");
			out.print("<td width=\"10%\" align=\"left\"><b>Applicant Name</b>");
			out.print("</td>");
			out.print("<td width=\"25%\" align=\"left\"><b> " +Helper.decodeAmpersand(appname)+"</b>");
			out.print("<input type=\"hidden\" name=\"appname\" value=\""+appname+"\"> </b>  </td>");
			out.print("<td width=\"5%\" align=\"left\"><b>Sector</b>");
			out.print("</td>");
			out.print("<td width=\"7%\" align=\"left\"><b> " +strSector+"</b>");
			out.print( "</td>");
			out.print("<td align=\"left\" width=\"10%\" height=\"20\">");
			out.print("<b>App. Recd. from</b>");
			out.print("</td>");
			out.print("<td align=\"left\"><b> " +strAppOrgName+"</b>");
			out.print("<input type=\"hidden\" name=\"apporgname\" value=\""+strAppOrgName+"\">");
			out.print("<input type=\"hidden\" name=\"hidsector\" value=\""+strSector+"\"> ");
			out.print("<input type=\"hidden\" name=\"hidsaral\" value=\""+strSaral+"\">");
			out.print("<input type=\"hidden\" name=\"issaralhead\" value=\""+strIssaralhead+"\">");
			out.print("<input type=\"hidden\" name=\"hidstatus\" value=\""+strStatus+"\">");
			out.print("<input type=\"hidden\" name=\"hidappassign\" value=\""+strAppAssign+"\">");
			out.print("<input type=\"hidden\" name=\"hidappatached\" value=\""+strAppAtached+"\">");
			out.print("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesIn+"\">");
			out.print("<input type=\"hidden\" name=\"isorghead\" value=\""+ISOrgHead+"\">");
			out.print("<input type=\"hidden\" name=\"appliedfor\" value=\""+strappliedfor+"\">");
			out.print("<input type=\"hidden\" name=\"readFlag\" value=\""+strright+"\">");
			out.print("<input type=\"hidden\" name=\"hidproposal\" value=\""+strProposal+"\">");
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in InwardHeadtag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}