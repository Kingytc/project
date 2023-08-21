package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MMRHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MMRHeadTag.class);
	String pageId = "";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#DEDACF\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=3 bgcolor=\"#DEDACF\" height=\"25\">");
			out.println("<tr> ");
			

			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==1)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Borrower Info</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('borrowerinfo.jsp','','')\" class=\"unnamed1\">");
				out.println("Borrower Info</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
		
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==2)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Facilities Enjoyed</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("Facilities Enjoyed</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
		

			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==3)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">B-4</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("B-4</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==4)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">B-5</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("B-5</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==5)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Account Details</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("Account Details</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==6)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Consortium</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("Consortium</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==7)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Inspection</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("Inspection</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			out.println("<td width=\"10%\" align=\"center\"");
			if(pageid==8)
			{
				out.println("bgcolor=\"#71694F\"> <font color=\"#999999\">");
				out.println("<b><font size=\"1\" face=\"MS Sans Serif\" color=\"#FFFFFF\">Monitoring Info</font></b>");
				out.println("</font>");
			}
			else
			{
				out.println("bgcolor=\"#EEEAE3\"> <font color=\"#000000\" class=\"unnamed1\">");
				out.println("<b><a href=\"javascript:callLink('','','')\" class=\"unnamed1\">");
				out.println("Monitoring Info</a></b>");
				out.println("</font>");
			}
			out.println("</td>");
			
			

			out.println("</tr>");
			out.println("</table>");
			
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MMRHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

