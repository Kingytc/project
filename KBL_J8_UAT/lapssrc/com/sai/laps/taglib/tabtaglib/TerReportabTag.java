package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class TerReportabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TerReportabTag.class);
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
			out.println("<table width='60%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class='sub_tab_active'><b>");
				out.print("Credit Report");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreportforRetail','ops_creditreport.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Credit Report';return true;\""+
						">Credit Report</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class='sub_tab_active'><b>");
				out.print("<b>Inspection Report</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getOPSInspectionReport','ops_inspectionreport.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Inspection Report';return true;\""+
						">Inspection Report</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("4"))
			{
				out.print("<td class='sub_tab_active'><b>");
				out.print("<b>Technical Inspection</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','appnotes','getData','appnotes.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Technical Inspection Report';return true;\""+
						">Technical Inspection</a>" );
				out.print("</b></td>");
			}
			if(strApplevel.equals("S"))
			{
				if(strTabid.equals("3"))
				{
					out.print("<td class='sub_tab_active'><b>");
					out.print("Recommendations ");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					if(strApplied.equalsIgnoreCase("R"))
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')\"");	
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
					">Recommendations</a>" );
					out.print("</b></td>");
				}
			}
			out.println("<input type=\"hidden\" name=\"appliedfor\" value=\""+strApplied+"\">");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in TerReportabTag :: "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}