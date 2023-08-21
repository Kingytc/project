package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class MonMSODTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(MonMSODTag.class);
	private static final long serialVersionUID = 1L;
	String pageId = "";
	String strmsod="";
	String strstock="";
	String strbookdbts="";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setMsod(String msod)
	{
		strmsod = msod;
	}
	public void setStock(String stock)
	{
		strstock = stock;
	}
	public void setbookdebts(String bookdebts)
	{
		strbookdbts = bookdebts;
	}
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\"  align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class=\"outertable\" height=\"25\">");
			out.println("<tr> ");
			out.println("<td width=\"10%\" align=\"center\"");
			if(!strmsod.equalsIgnoreCase("")||strmsod.equalsIgnoreCase("null"))
			{
				if(strmsod.equalsIgnoreCase("y"))
				{
					if(pageid==1)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>MSOD Estimates</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_msodestimates.jsp','mmrcommon','getmsodestimate')\" >");
						out.println("MSOD Estimates</a></b>");
						out.println("");
					}
						out.println("</td>");
						out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==2)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>MSODBorrowing</b>");
						out.println("");
					}
					else
					{
					out.println("class=\"sub_tab_inactive\">");
					out.println("<b><a href=\"javascript:callLink('mon_msod2.jsp','mmrcommon','getmonmsodBorrowing')\" >");
					out.println("MSOD Borrowing</a></b>");
					out.println("");
					}
					out.println("</td>");
				}
			}
			if(!strstock.equalsIgnoreCase("")||strstock.equalsIgnoreCase("null"))
			{
				if(strstock.equalsIgnoreCase("y"))
				{
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==3)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Stock Statement</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_stockstatement.jsp','Register','getStockStatement')\" >");
						out.println("Stock Statement</a></b>");
						out.println("");
					}
						out.println("</td>");
						out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==4)
					{
						out.println("class=\"sub_tab_active\".");
						out.println("<b>Stock Eligible</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_stockeligible.jsp','mmrcommon','getstockeligible')\" >");
						out.println("Stock Eligible</a></b>");
						out.println("");
					}
					out.println("</td>");
				}
			}
			if(!strbookdbts.equalsIgnoreCase("")||strbookdbts.equalsIgnoreCase("null"))
			{
				if(strbookdbts.equalsIgnoreCase("y"))
				{
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==5)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>BookDebts Statement</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_bookdebitsvalue.jsp','mmrcommon','getBookdebitsvalue')\" >");
						out.println("BookDebts Statement</a></b>");
						out.println("");
					}
					out.println("</td>");
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==6)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>BookDebts Eligible</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_bookdebitseligible.jsp','mmrcommon','getBookdebitseligible')\" >");
						out.println("BookDebts Eligible</a></b>");
						out.println("");
					}
				}
			}	
			out.println("</td>");
			if(!strstock.equalsIgnoreCase("")||strstock.equalsIgnoreCase("null"))
			{
				if(strstock.equalsIgnoreCase("y"))
				{
					out.println("<td width=\"10%\" align=\"center\"");
					if(pageid==7)
					{
						out.println("class=\"sub_tab_active\">");
						out.println("<b>Insurance</b>");
						out.println("");
					}
					else
					{
						out.println("class=\"sub_tab_inactive\">");
						out.println("<b><a href=\"javascript:callLink('mon_insurancecovered.jsp','mmrcommon','getDataInsurancecovered')\" >");
						out.println("Insurance</a></b>");
						out.println("");
					}
					out.println("</td>");
				}
			}	
			out.println("</tr>");
			out.println("</table>");
			
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MSODHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

