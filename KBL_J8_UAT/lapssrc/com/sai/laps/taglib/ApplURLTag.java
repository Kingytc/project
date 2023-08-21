package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class ApplURLTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplURLTag.class);
	private static final long serialVersionUID = 1L;
	String pageId = "";
	public void setPageid(String pid)
	{
		pageId = pid;
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
			out.println("<table width=100% border=0 cellpadding=0 cellspacing=0 bgcolor=\"#DEDACF\" height=\"20\">");
			out.println("<tr> ");

			out.println("<td width=\"12%\">");
			out.println("<div align=\"center\">");
			if(pageid==1)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Applicant</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoApplnt()\" class=\"unnamed1\">");
				out.println("Applicant </a>");
				out.println("</font>");
			}
			out.println("</div></td>");


			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\">");
			if(pageid == 2)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Principal [s]</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoPrin()\" class=\"unnamed1\">");
				out.println("Principal [s] </a>");
				out.println("</font>");
			}
			out.println("</div></td>");


			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\">");
			if(pageid == 3)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Financial</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoFin()\" class=\"unnamed1\">");
				out.println("Financial</a>");
				out.println("</font>");
			}
			out.println("</div></td>");


			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\"> ");
			if(pageid == 4)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Collateral</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoCol()\" class=\"unnamed1\">");
				out.println("Collateral</a>");
				out.println("</font>");
			}
			out.println("</div></td>");


			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\"> ");
			if(pageid == 5)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Documents</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoDoc()\" class=\"unnamed1\">");
				out.println("Documents</a>");
				out.println("</font>");
			}
			out.println("</div></td>");

			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\"> ");
			if(pageid == 6)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Risk Analysis</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoRisk()\" class=\"unnamed1\">");
				out.println("Risk Analysis</a>");
				out.println("</font>");
			}
			out.println("</div></td>");


			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\"> ");
			if(pageid == 7)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Workflow</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoWorlflow()\" class=\"unnamed1\">Workflow</a>");
				out.println("</font>");
			}
			out.println("</div></td>");

			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"center\"> ");
			if(pageid == 8)
			{
				out.println("<font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\">Notes</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("<font color=\"#000000\" class=\"unnamed1\">");
				out.println("<a href=\"javascript:gotoNote()\" class=\"unnamed1\">Notes</a>");
				out.println("</font>");
			}

			out.println("</div></td>");
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

