package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperADC;

public class ADCHeadtag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ADCHeadtag.class);
	
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		
		char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
		
		String strappstatus = ""; 
		String strappholder="";
		
		String strUserId=Helper.correctNull((String)httpSession.getAttribute("strUserId"));
		String appname = Helper.correctDoubleQuotesHtml(request.getParameter("appname"));
		String strappno = Helper.correctNull(request.getParameter("appno"));
		String strappid=Helper.correctNull((String)request.getParameter(("com_id")));
		String appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
		String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
		String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
		String hidcatory=Helper.correctNull((String)request.getParameter("hidcatory"));
		
		boolean boolflag=false;
		
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appno",strappno);
			if(strSourcepage.equals("/action/comadc_workflowhistroy.jsp") || strSourcepage.equals("/action/comadc_workflowaction.jsp"))
			{
				boolflag=true;
			}
				
				if(appname.equals("") 
						|| strappno.equals("") 
						|| strappid.equals("") 
						|| appstatus.equals("") 
						|| strappholder.equals("")
						)
				{
					boolflag=true;
				}
				if(boolflag)
				{
				TagDataHelperADC tagDataHelperadc=new TagDataHelperADC();
				HashMap hshRes=(HashMap)tagDataHelperadc.getADCAppData(hshParams);
				
				if(hshRes!=null)
				{
					appname = Helper.correctNull( (String) hshRes.get("appname") );
					appstatus = Helper.correctNull( (String) hshRes.get("appstatus") );
					strappholder = Helper.correctNull( (String) hshRes.get("applnholder") );
					strValuesin = Helper.correctNull( (String) hshRes.get("valuesin") );
					
					if(strappholder.equals(""))
					{
						strappholder="Y";
					}
					else
					{
						strappholder=strappholder.equals(strUserId)?"Y":"N";
					}
				}
			}
			
			if(appstatus.equalsIgnoreCase("op") || appstatus.equalsIgnoreCase("new"))
			{
				strappstatus = "Open/Pending";
			}
			else if(appstatus.equalsIgnoreCase("pa"))
			{
				strappstatus = "Processed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("pr"))
			{
				strappstatus = "Processed/Rejected";
			}
			else if(appstatus.equalsIgnoreCase("ca"))
			{
				strappstatus = "Closed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("cr"))
			{
				strappstatus = "Closed/Rejected";
			}
			
			
			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#DEDACF\" height=\"20\">");
			out.print("<tr>");
			out.print("<td width=\"10%\">");
			out.print("<b>Application No:</b>");
			out.print("</td>");
			out.print("<td width=\"15%\"><b> <font color='#003399'>" +strappno+"</font></b>");
			out.print("<input type=\"hidden\" name=\"appno\" value=\""+strappno+"\"></td>");
			out.print("<td width=\"10%\"><b>Applicant Name:</b>");
			out.print("</td>");
			out.print("<td width=\"40%\"><b> <font color='#003399'>" +Helper.decodeAmpersand(appname)+"</font></b>");
			out.print("<input type=\"hidden\" name=\"appname\" value=\""+appname+"\"></td>");
			out.print("<td width=\"10%\"><b>Status:</b>");
			out.print("</td>");
			out.print("<td width=\"40%\"><b> <font color='#003399'>" +strappstatus+"</font></b>");
			out.print("<input type=\"hidden\" name=\"appstatus\" value=\""+appstatus+"\">");
			out.print("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.print("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"com_id\" value=\""+strappid+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"hidcatory\" value=\""+hidcatory+"\">");
			String btnenable=(""+readFlag).equalsIgnoreCase("r")?"N":(appstatus.equalsIgnoreCase("op") && strappholder.equals("Y"))?"Y":"N";
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+btnenable+"\">");
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in ADCHeadtag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}