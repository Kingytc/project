package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;

public class NPABankingDetails extends TagSupport 
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(NPABankingDetails.class);
	
	String pageId = "";
	String strModule="";
	String strBankarrangement="";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setModule(String module)
	{
		strModule =Helper.correctNull(module.trim());
	}
	public void setBankarrangement(String bankarrangement)
	{
		strBankarrangement=Helper.correctNull(bankarrangement.trim());
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
			out.println("<table width=\"60%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >");
			out.println("<tr>");
			out.println("<td>");
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' >");
			out.println("<tr align='center'> ");			
			out.println("<td width='12%' ");
			if(strModule.equalsIgnoreCase("STAT"))
			{
				if(pageid==5)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Banking Details</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('StatusNote_page1.jsp','npacommon','getGeneralinfoData')\" >");
					out.println("Banking Details</a></b>");
				}
			}
			else if(strModule.equalsIgnoreCase("PAWO"))
			{
				if(pageid==5)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Banking Details</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('prudential_general.jsp','npacommon','getGeneralinfoData')\" >");
					out.println("Banking Details</a></b>");
				}
			}
			else if(strModule.equalsIgnoreCase("SARFI"))
			{
				if(pageid==5)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Banking Details</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('SarfaeriProposal_page1.jsp','npacommon','getGeneralinfoData')\" >");
					out.println("Banking Details</a></b>");
				}
			}
			else if(strModule.equalsIgnoreCase("SUIT"))
			{
				if(pageid==5)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Banking Details</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('34PointsFormat_page1.jsp','npacommon','getGeneralinfoData')\" >");
					out.println("Banking Details</a></b>");
				}
			}
			out.println("</td>");
			if(strBankarrangement.equals("2"))
			{
				out.println("<td ");
				if(pageid==1)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Consortium Banking</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('npa_otherconsbankdues.jsp?banktype=CON','npacommon','getotherbankdues')\" >");
					out.println("Consortium Banking</a></b>");
				}
				out.println("</td>");
			}
			if(strBankarrangement.equals("3"))
			{
				out.println("<td ");
				if(pageid==2)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Multiple Banking</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('npa_othermulbankdues.jsp?banktype=MUL','npacommon','getotherbankdues')\" >");
					out.println("Multiple Banking</a></b>");
				}
				out.println("</td>");
			}
			if(!(strModule.equalsIgnoreCase("SARFI")))
			{
				out.println("<td ");
				if(pageid == 3)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Financial Institution</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('npa_otherfidues.jsp?banktype=TF','npacommon','getotherbankdues')\" >");
					out.println("Financial Institution</a></b>");
				}
				out.println("</td>");
			}
			if(!(strModule.equalsIgnoreCase("PAWO") || strModule.equalsIgnoreCase("SARFI")))
			{
				out.println("<td ");
				if(pageid == 4)
				{
					out.println("class='sub_tab_active'> ");
					out.println("<b>Sister Concerns Banking</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'> ");
					out.println("<b><a href=\"javascript:callLink('npa_otherconcernsbankdues.jsp','npacommon','getsisterconcerndata')\" >");
					out.println("Sister Concerns Banking</a></b>");
				}
				out.println("</td>");
			}
			
			out.println("</tr>");
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in NPABankingDetails.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

