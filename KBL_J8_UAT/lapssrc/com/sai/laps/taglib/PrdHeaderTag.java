package com.sai.laps.taglib;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;

public class PrdHeaderTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(PrdHeaderTag.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		HttpSession session1=pageContext.getSession();
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
			
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"2\"  class=\"outertable\">");
			out.println("<tr> ");
			
			out.println("<td width=\"14%\" colspan=\"2\"> ");
			out.println(" Product Code ");
			out.println("</td>");
			
			out.println("<td width=\"8%\">  ");
			out.println("<input type=\"text\" name=\"prdCode\" size=\"7\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdCode"))+"\">");
			out.println(" </td>");
			
			out.println("<td width=\"10%\"> ");
			out.println(" Scheme Code ");
			out.println("</td>");
			
			out.println("<td width=\"8%\">  ");
			out.println("<input type=\"text\" name=\"schCode\" size=\"7\" readonly value=\""+Helper.correctNull((String)request.getParameter("schCode"))+"\">");
			out.println(" </td>");
			
			out.println("<td width=\"14%\" colspan=\"2\"> ");
			out.println("Product For ");
			out.println("</td>");
			
			out.println("<td width=\"20%\">  ");
			out.println("<input type=\"text\" name=\"prdType\" size=\"40\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdType"))+"\">");
			out.println(" </td>");
			
			out.println("<td width=\"16%\"> ");
			out.println("Status ");
			out.println("</td>");
			
			out.println("<td width=\"10%\">  ");
			out.println("<input type=\"text\" name=\"prdStatus\" size=\"15\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdStatus"))+"\">");
			out.println(" </td>");
			
			out.println("</tr>");
			out.println("<tr> ");
			
			out.println("<td width=\"14%\" colspan=\"2\">Product Category </td>");
			
			out.println("<td width=\"26%\" colspan=\"3\"> ");
			out.println("<input type=\"text\" name=\"prdCat\" size=\"40\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdCat"))+"\">");
			out.println("</td>");
			
			out.println("<td width=\"14%\" colspan=\"2\">Sub Category ");
			out.println("</td>");
			
			out.println("<td width=\"20%\"> ");
			out.println("<input type=\"text\" name=\"prdSubCat\" size=\"40\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdSubCat"))+"\">");
			out.println("</td>");
			
			out.println("<td width=\"16%\"> ");
			out.println(" Min." +"Repayment Period"	+"");
			out.println("</td>");
			
			out.println("<td width=\"10%\">   ");
			out.println("<input type=\"text\" name=\"prdminTerm\" size=\"10\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdminTerm"))+"\">(Months) ");
			out.println(" </td>");
			
			out.println("</tr>");
			
			out.println("<tr> ");
			
			out.println("<td width=\"10%\"> ");
			out.println("Range&nbsp;From ");
			out.println("</td>");
			
			out.println("<td width=\"4%\"> <div align=\"right\">");
			out.println(ApplicationParams.getCurrency()+"</td>");
			
			out.println("<td width=\"26%\" colspan=\"3\">   ");
			out.println("<input type=\"text\" name=\"prdRangeFrom\" size=\"15\" style=\"text-align:right\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdRangeFrom"))+"\">");
			out.println(" </td>");
			
			out.println("<td width=\"10%\"> ");
			out.println("Range To ");
			out.println("</td>");
			
			out.println("<td width=\"4%\"> <div align=\"right\">");
			out.println(ApplicationParams.getCurrency()+"</td>");
			
			out.println("<td width=\"20%\" >   ");
			out.println("<input type=\"text\" name=\"prdRangeTo\" size=\"15\" readonly style=\"text-align:right\" value=\""+Helper.correctNull((String)request.getParameter("prdRangeTo"))+"\">");
			out.println(" </td>");			
			
			out.println("<td width=\"16%\"> ");
			out.println(" Max.Repayment Period   ");
			out.println("</td>");			
			
			out.println("<td width=\"10%\">   ");
			out.println("<input type=\"text\" name=\"prdTerm\" size=\"10\" readonly value=\""+Helper.correctNull((String)request.getParameter("prdTerm"))+"\">(Months)");
			out.println(" </td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}
