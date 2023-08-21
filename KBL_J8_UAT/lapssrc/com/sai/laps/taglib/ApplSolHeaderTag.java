package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class ApplSolHeaderTag extends TagSupport {
	static Logger log=Logger.getLogger(ApplHeaderTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		String strQuery = null;
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		try
		{
			String appno =  Helper.correctNull(request.getParameter("hidapplno"));
			String appid= Helper.correctNull(request.getParameter("hidDemoId"));
			String strReferenceno="";
			String applname="",applholder="",applrecfrom="",applstatus="",appstatus="";
			if(!appno.equalsIgnoreCase(""))
			{
			 applname =  Helper.correctNull(request.getParameter("hidapplname"));
			 applholder =  Helper.correctNull(request.getParameter("hidapplholder"));
			 applrecfrom= Helper.correctNull(request.getParameter("hidOrgname"));
			 applstatus =   Helper.correctNull(request.getParameter("hidappstatus"));
				
			 if(applstatus.equalsIgnoreCase(""))	
				{
					strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+appid+"^"+appno);
					 rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{  
						 applstatus =Helper.correctNull(rs.getString("SOL_STATUS"));
				        }
				}
				
				
				
			  strQuery = SQLParser.getSqlQuery("sel_referencenum^"+appno);
			  rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
				 strReferenceno =Helper.correctNull(rs.getString("ars_sanctionrefno"));
		        }
		
				
			 if(applstatus.equalsIgnoreCase("OP"))
				{
					appstatus="Open/Pending";
				}
				else
				if(applstatus.equalsIgnoreCase("PA"))
				{
					appstatus="Processed/Approved";
				}
				else
				if(applstatus.equalsIgnoreCase("PR"))
				{
					appstatus="Processed/Rejected";
				}
				else
				if(applstatus.equalsIgnoreCase("CA"))
				{
					appstatus="Closed/Approved";
				}
				else
				if(applstatus.equalsIgnoreCase("CR"))
				{
					appstatus="Closed/Rejected";
				}
			}
			else
			{
				 strQuery = SQLParser.getSqlQuery("sel_com_solvency^"+appid);
				 rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  
						appid= Helper.correctNull(rs.getString("SOL_APPID"));
						appno=Helper.correctNull(rs.getString("SOL_APPL_NO"));
						applname=Helper.correctNull(rs.getString("SOL_APPLICANT_NAME"));
						applholder=Helper.correctNull(rs.getString("SOL_APPLNHOLDER"));
						applrecfrom=Helper.correctNull(rs.getString("ORG_NAME"));
						applstatus =Helper.correctNull(rs.getString("SOL_STATUS"));
					
						if(applstatus.equalsIgnoreCase("OP"))
						{
							appstatus="Open Pending";
						}
						else
						if(applstatus.equalsIgnoreCase("PA"))
						{
							appstatus="Processed/Approved ";
						}
						else
						if(applstatus.equalsIgnoreCase("PR"))
						{
							appstatus="Processed/Rejected";
						}
						
					}
			}
			
			out = pageContext.getOut();
			request = pageContext.getRequest();
			
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td  width=\"12%\">");
			out.println("&nbsp;<b>Application No:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+appno);
			out.println("</td>");
			
			out.println("<td width=\"10%\">");
			out.println("&nbsp;<b>Applicant Name:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+applname);
			
			out.println("<td width=\"7%\">");
			out.println("&nbsp;<b>Status:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+appstatus);
			out.println("</td>");
			
			out.println("</tr>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Application Holder:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+applholder);
			out.println("</td>");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>App. Recd. from:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+applrecfrom);
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("&nbsp;");
			out.println("</td>");
			out.println("<td>");
			out.println("&nbsp;");
			out.println("</td>");
			out.println("</tr>");
			
			out.println("</tr>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Sanction / Rejected Reference No:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+strReferenceno);
			out.println("</td>");
			
			
			out.println("<td>");
			out.println("&nbsp;");
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("&nbsp;");
			out.println("</td>");
			out.println("<td>");
			out.println("&nbsp;");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;");
			out.println("</td>");
			
			out.println("</tr>");
			out.println("</table>");
		
		}
		catch(Exception e)
		{
			log.error("exception in ApplHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
	
}
