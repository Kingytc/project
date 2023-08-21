package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;

public class ComReporttabTag extends TagSupport 
{
	static Logger log=Logger.getLogger(ComReporttabTag.class);
	private static final long serialVersionUID = 1L;
	String strTabid="";
	String strApplevel="";
	String strApplied="";
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setApplevel(String applevel)
	{
		this.strApplevel = Helper.correctNull(applevel).trim();
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
			out.println("<table width=60% border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center><b>");
				out.print("<b>Inspection Report</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getComInspectionReport','com_pre_SanctionInspectionReport.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Inspection Report';return true;\""+
						"class=\"blackfont\">Inspection Report</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
				out.print("<b>Technical Inspection</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','Inspection','getTechnicalpage1','TechnicalInspectionpage1.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Technical Inspection';return true;\""+
						"class=\"blackfont\">Technical Inspection</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("3"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
				out.print("Credit Report");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreport1','creditreport3.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Credit Report';return true;\""+
						"class=\"blackfont\">Credit Report</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("5"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
				out.print("Due Diligence");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Due Diligence';return true;\""+
						"class=\"blackfont\">Due Diligence</a>" );
				out.print("</b></td>");
			}
			if(strApplevel.equals("S"))
			{
				if(strTabid.equals("4"))
				{
					out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
					out.print("Recommendations ");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td width=15% class=\"sub_tab_inactive\" align=center><b>");
					if(strApplied.equalsIgnoreCase("R"))
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')\"");	
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +" onMouseOver=\"window.status='Credit Report';return true;\""+ "class=\"blackfont\">Recommendations</a>" );
					out.print("</b></td>");
				}
			}
			out.println("<input type=\"hidden\" name=\"appliedfor\" value=\""+strApplied+"\">");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in ComReporttabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}