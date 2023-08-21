package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class saralappinward extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(saralappinward.class);
	private static final long serialVersionUID = 1L;
	String strSector = "";
	String strTabid="";
	String strApplied="";
	
	
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setSector(String sector)
	{
		this.strSector = Helper.correctNull(sector).trim();
	}
	public void setApplied(String applied)
	{
		this.strApplied = Helper.correctNull(applied).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
						
			out.println("<table width=50% border=0 cellpadding=4 cellspacing=1 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
			
			
			/*- This is for enabling tab in saral application lvel
			 * ADC---Adhoc limit application
			 * STL---short term loan
			 * SRE-short Review Extension
			 *  
			 *  */
			if(strSector.equalsIgnoreCase("ADC") ||strSector.equalsIgnoreCase("STL")|| strSector.equalsIgnoreCase("SRE"))
			{
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"tabactivenew\" align=center width=\"9%\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"tabinactivenew\" align=center width=\"8%\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							"class=\"blackfont\">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"tabactivenew\" align=center width=\"8%\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"tabinactivenew\" align=center width=\"10%\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							"class=\"blackfont\">Securities</a>" );
					out.print("</b></td>");
				}
			
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"tabactivenew\" align=center width=\"10%\"><b>");
					out.print("Recommendations");
					out.print("</b></td>");
				}
				else
				{
					
					out.println("<td class=\"tabinactivenew\" align=center width=\"10%\"><b>");
				
					if(strApplied.equalsIgnoreCase("E"))
					{
						 out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','facilityremdcomments.jsp')\"");
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							"class=\"blackfont\">Recommendations</a>" );
					out.print("</b></td>");
				}
				/*if(strSector.equalsIgnoreCase("SRE"))
				{
					if(strTabid.equals("11"))
					{
						
						out.print("<td class=\"tabactivenew\" align=center width=\"7%\"><b>");
						out.print("Audit Observation");
						out.print("</b></td>");
					}
					else
					{
						
						out.println("<td class=\"tabinactivenew\" align=center width=\"7%\"><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getAuditorComments','com_auditobserv.jsp')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Audit Observations';return true;\""+
								"class=\"blackfont\">Audit Observation</a>" );
						out.print("</b></td>");
					}
				}*/
				
				out.print("<input type=\"hidden\" name=\"appliedfor\" value=\""+strApplied+"\">");
				
			}
		}
			catch(Exception e)
			{
				log.error("exception in saralreportTag :: "+e);
				throw new JspException(e.getMessage());
			}
			return EVAL_PAGE;	
			
			}
	
}