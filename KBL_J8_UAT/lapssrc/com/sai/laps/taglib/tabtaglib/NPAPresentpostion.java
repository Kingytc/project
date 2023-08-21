package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;

public class NPAPresentpostion extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(NPAPresentpostion.class);
	String pageId = "";
	String strModule="";
	
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	
	public void setModule(String module)
	{
		strModule =Helper.correctNull(module.trim());
	}
	

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
				
			out.println("<table width=\"35%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable'>");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");
			
			
			if(strModule.equalsIgnoreCase("OTSCO"))
			{
				if(pageid==1)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Account");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('npacompromise_presentposition.jsp','npacommon','getPresentPosition')\">");
					out.println("Account");
					out.println("</a></td>");
				}
				
				if(pageid==2)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Securities");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('npacompromise_securities.jsp','npacommon','getSecurities')\">");
					out.println("Securities");
					out.println("</a></td>");
				}
				
				
				if(pageid==3)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Promoters/ Guarantors");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('npacompromise_means.jsp','npacommon','getBorrowerDetails')\">");
					out.println("Promoters/ Guarantors");
					out.println("</a></td>");
				}
			}
			else if(strModule.equalsIgnoreCase("SARFI"))
			{
				if(pageid==1)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Account");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('PresentPosition_npa.jsp','npacommon','getPresentPosition')\">");
					out.println("Account");
					out.println("</a></td>");
				}
				
				if(pageid==2)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Securities");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('securities_npa.jsp','npacommon','getSecurities')\">");
					out.println("Securities");
					out.println("</a></td>");
				}
				
				
				if(pageid==3)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Promoters/ Guarantors");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('SarfaeriProposal_means.jsp','npacommon','getBorrowerDetails')\">");
					out.println("Promoters/ Guarantors");
					out.println("</a></td>");
				}
			}
			else if(strModule.equalsIgnoreCase("PAWO"))
			{
				if(pageid==1)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Account");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('prudential_presentposition.jsp','npacommon','getPresentPosition')\">");
					out.println("Account");
					out.println("</a></td>");
				}
				
				if(pageid==2)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Securities");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('prudential_securities.jsp','npacommon','getSecurities')\">");
					out.println("Securities");
					out.println("</a></td>");
				}
				
				
				if(pageid==3)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Promoters/ Guarantors");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('prudential_applntmeans.jsp','npacommon','getBorrowerDetails')\">");
					out.println("Promoters/ Guarantors");
					out.println("</a></td>");
				}
			}
			else if(strModule.equalsIgnoreCase("STAT"))
			{
				if(pageid==1)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Account");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('PresentPositionstatus.jsp','npacommon','getPresentPosition')\">");
					out.println("Account");
					out.println("</a></td>");
				}
				
				if(pageid==2)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Securities");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('Securitiesstatus.jsp','npacommon','getSecurities')\">");
					out.println("Securities");
					out.println("</a></td>");
				}
				
				
				if(pageid==3)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Promoters/ Guarantors");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('statusnote_means.jsp','npacommon','getBorrowerDetails')\">");
					out.println("Promoters/ Guarantors");
					out.println("</a></td>");
				}
			}
			else if(strModule.equalsIgnoreCase("SUIT"))
			{
				if(pageid==1)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Account");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('34PointsFormat_presentpos.jsp','npacommon','getPresentPosition')\">");
					out.println("Account");
					out.println("</a></td>");
				}
				
				if(pageid==2)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Securities");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('filingofsuit_colletralsecurity.jsp','npa','getFilingColletralSecurity')\">");
					out.println("Securities");
					out.println("</a></td>");
				}
				
				
				if(pageid==3)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("Promoters/ Guarantors");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callLink('filingofsuit_means.jsp','npacommon','getBorrowerDetails')\">");
					out.println("Promoters/ Guarantors");
					out.println("</a></td>");
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
			log.error("exception in NPAPresentpostion.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

