package com.sai.laps.taglib;

import java.sql.ResultSet;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;

public class FacilityHeaderTag extends TagSupport 
{
	static Logger log=Logger.getLogger(FacilityHeaderTag.class);	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		HttpSession session1=pageContext.getSession();
		ResultSet rs = null;
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
			String strtype =Helper.correctNull((String)session1.getAttribute("facility_type"));
			String strnature =Helper.correctNull((String)session1.getAttribute("facility_nature"));
			String strmodule =Helper.correctNull((String)session1.getAttribute("hidcorp_module"));
			String strcom_facstatus =Helper.correctNull((String)session1.getAttribute("hidcom_facstatus"));
			String fac_id = Helper.correctNull((String) request.getParameter("fac_id"));
			//To get the latest Status for facility by Kishan
			rs = DBUtils.executeLAPSQuery("setproductsselcorporate^"+ fac_id);
			if(rs.next()) {
				strcom_facstatus = Helper.correctNull((String) rs.getString("com_facstatus"));
			}
			if(!strtype.equalsIgnoreCase(""))
			{
				if(strtype.equalsIgnoreCase("F"))
				{
					strtype ="Funded";
				}
				else
				{
					strtype = "Non Funded";
				}
			}
			if(!strnature.equalsIgnoreCase(""))
			{
				if(strnature.equalsIgnoreCase("1"))
				{
					strnature ="Working Capital";
				}
				else
				{
					strnature = "Term Loan";
				}
			}
			if(!strcom_facstatus.equalsIgnoreCase(""))
			{
				if(strcom_facstatus.equalsIgnoreCase("p"))
				{
					strcom_facstatus ="Partial";
				}
				else if(strcom_facstatus.equalsIgnoreCase("c"))
				{
					strcom_facstatus = "Completed";
				}
			}
     		out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"2\" height=\"0\" >");
			out.println("<tr> ");

			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"3\" height=\"0\" class=\"outertable\">");
			out.println("<tr>");
			out.println("<td width=\"25%\" > ");
			out.println("</td>");
			out.println("</tr>");
			//1
			out.println("<tr > ");
			out.println("<td width=\"16%\" > ");
			out.println("<div align=\"left\">Facility Code</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<input type=\"text\" name=\"hidcorp_faccode\" size=\"12\" readonly value=\""+session1.getAttribute("hidcorp_faccode")+"\">");
			out.println("</td>");
			
			out.println("<td width=\"16%\"> ");
			out.println("<div align=\"left\">Facility Id</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<input type=\"text\" name=\"fac_id\" size=\"12\" readonly value=\""+request.getParameter("fac_id")+"\">");
			out.println("</td>");
			
			out.println("<td width=\"12%\" > ");
			out.println("<div align=\"left\">Head of Facilty</div>");
			out.println("</td>");
			
			out.println("<td width=\"24%\">");
			out.println("<input type=\"text\" name=\"hidcorp_headname\" size=\"25\" readonly value=\""+session1.getAttribute("facility_parent")+"\">");
			out.println("</td>");
			out.println("</tr> ");
			//2
			out.println("<tr> ");
			out.println("<td width=\"16%\"> ");
			out.println("<div align=\"left\">Facility");
			out.println("</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<input type=\"text\" name=\"hidcorp_subfac\" size=\"40\" readonly value=\""+session1.getAttribute("facility_sub")+"\">");
			out.println("</td>");
			
			out.println("<td width=\"16%\"  > ");
			out.println("<div align=\"left\">Range From: ");
			out.println("</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<input type=\"text\" name=\"prd_rng_from\" size=\"20\" readonly value=\""+request.getParameter("prd_rng_from")+"\">");
			out.println("</td>");
			
			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"left\">Range To: ");
			out.println("</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<input type=\"text\" name=\"prd_rng_to\" size=\"20\" readonly value=\""+request.getParameter("prd_rng_to")+"\">");
			out.println("</td>");
			out.println("</tr>");
			//3
			out.println("<tr> ");
			out.println("<td width=\"16%\"> ");
			out.println("<div align=\"left\">Min." +"Loan Period");
			out.println("</div>");
			out.println("</td>");
			
			out.println("<td width=\"16%\">");
			out.println("<div align=\"right\"></div>");
			out.println("<input type=\"text\" name=\"prd_minterm\" size=\"10\" readonly value=\""+request.getParameter("prd_minterm")+"\">(Months) ");
			out.println("</td>");
			
			out.println("<td width=\"16%\"> ");
			out.println("<div align=\"left\">Max.Loan Period");
			out.println("</div>");
			out.println("</td>");			
			
			out.println("<td width=\"16%\">");
			out.println("<div align=\"left\"></div>");
			out.println("<input type=\"text\" name=\"prd_maxterm\" size=\"10\" readonly value=\""+request.getParameter("prd_maxterm")+"\">(Months)");
			out.println("</td>");
			
			out.println("<td width=\"12%\"> ");
			out.println("<div align=\"left\">Holiday period");
			out.println("</div>");
			out.println("</td>");			
			
			out.println("<td width=\"16%\">");
			out.println("<div align=\"left\"></div>");
			out.println("<input type=\"text\" name=\"txt_holiday\" size=\"10\" readonly value=\""+request.getParameter("txt_holiday")+"\">(Months)");
			out.println("</td>");
			out.println("</tr> ");
			//4
			out.println("<tr> ");
			out.println("<td width=\"16%\" > ");
			out.println("<div align=\"left\">Type</div>");
			out.println("</td>");
			
			out.println("<td width=\"20%\">");
			out.println("<input type=\"text\" name=\"fac_type\" size=\"15\" readonly value=\""+strtype+"\">");
			out.println("</td>");
			
			out.println("<td width=\"16%\" > ");
			out.println("<div align=\"left\">Nature of Facility</div>");
			out.println("</td>");
			
			out.println("<td width=\"20%\">");
			out.println("<input type=\"text\" name=\"fac_nature\" size=\"15\" readonly value=\""+strnature+"\">");
			out.println("<input type=\"hidden\" name=\"fac_module\" size=\"15\" readonly value=\""+strmodule+"\">");
			out.println("</td>");
			
			out.println("<td width=\"12%\" > ");
			out.println("<div align=\"left\">Status</div>");
			out.println("</td>");
			
			out.println("<td width=\"20%\">");
			out.println("<input type=\"text\" name=\"fac_status\" size=\"15\" readonly value=\""+strcom_facstatus+"\">");
			//out.println("<% session.setAttribute(\"hidcom_facstatus\", strcom_facstatus); %>");
			out.println("<input type=\"hidden\" name=\"fac_status1\" size=\"15\" readonly value=\""+strcom_facstatus+"\">");
			out.println("</td>");
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
