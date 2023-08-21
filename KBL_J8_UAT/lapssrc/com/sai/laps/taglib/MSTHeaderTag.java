package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperMST;

public class MSTHeaderTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(MSTHeaderTag.class);
	private static final long serialVersionUID = 1L;
	String appno = "";

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		
		char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
		
		String appno =  Helper.correctNull(request.getParameter("appno"));
		String strUserId=Helper.correctNull((String)httpSession.getAttribute("strUserId"));
		
		String appname = Helper.correctNull((String)request.getParameter("appname"));
		String appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
		String applicantid=Helper.correctNull((String)request.getParameter("hidapplicantid"));
		String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
		String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
		String strAppstatus="";
		boolean boolflag=false;
		String strpropappno=Helper.correctNull((String)request.getParameter("propappno"));
		String strAppholder=Helper.correctNull((String)request.getParameter("appholder"));
		String strApporgname=Helper.correctNull((String)request.getParameter("apporgname"));
		
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appno",appno);
			hshParams.put("strUserId",strUserId);
			if(strSourcepage.equals("/action/commst_worflowhistory.jsp") || strSourcepage.equals("/action/commst_workflowaction.jsp"))
			{
				boolflag=true;
			}
			if(appname.equals("") 
					|| appstatus.equals("")
					|| applicantid.equals("") 
					|| strValuesin.equals("") 
					|| strAppholder.equals("")
					|| strpropappno.equals("")
					)
			{
				boolflag=true;
			}
			if(boolflag)
			{
				TagDataHelperMST tagDataHelpermst=new TagDataHelperMST();
				HashMap hshRes=(HashMap)tagDataHelpermst.getMSTAppData(hshParams);
			
				if(hshRes!=null)
				{
					appname = Helper.correctNull( (String) hshRes.get("appname") );
					appstatus = Helper.correctNull( (String) hshRes.get("appstatus") );
					applicantid = Helper.correctNull( (String) hshRes.get("applicantid") );
					strValuesin=Helper.correctNull((String)hshRes.get("valuesin"));
					strAppholder=Helper.correctNull((String)hshRes.get("applnholder"));
					strpropappno=Helper.correctNull((String)hshRes.get("propappno"));
					strApporgname=Helper.correctNull((String)hshRes.get("org_name"));
				}
			

			}

			if(appstatus.equalsIgnoreCase("op") || appno.equalsIgnoreCase("new"))
			{
				strAppstatus = "Open/Pending";
			}
			else if(appstatus.equalsIgnoreCase("pa"))
			{
				strAppstatus = "Processed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("pr"))
			{
				strAppstatus = "Processed/Rejected";
			}
			else if(appstatus.equalsIgnoreCase("ca"))
			{
				strAppstatus = "Closed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("cr"))
			{
				strAppstatus = "Closed/Rejected";
			}
			
			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\" class='outertable linebor'>");
			out.println("<tr class=\"applicationheader\">");
			out.println("<td width=\"12%\">");
			out.println("<b>");
			out.println("Application No");
			out.println("</b>");
			out.println("</td>");
			out.println("<td width=\"12%\">");
			out.println("<b>"+appno+"</b>");
			out.println("<input type=\"hidden\" name=\"appno\" value=\""+appno+"\">");
			out.println("</td>");
			out.println("<td width=\"12%\">");
			out.println("<b>Applicant Name</b>");
			out.println("</td>");
			out.println("<td width=\"30%\">");
			out.println("<b>"+appname+"</b>");
			out.println("</td>");
			out.println("<td width=\"8%\"><b>");
			out.println("Status:</b>");
			out.println("</td>");
			out.println("<td width=\"19%\">");
			out.println("<b>"+ strAppstatus+"</b>");
			out.println("</td>");
			out.println("</tr>");
			out.println("<tr class=\"applicationheader\">");
			out.println("<td>");
			out.println("<b>Application Holder</b>");
			out.println("</td>");
			out.println("<td>");
			out.println("<b>"+ strAppholder+"</b>");
			out.println("</td>");
			out.println("<td>");
			out.println("<b>App. Recd. from</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("<b>"+ strApporgname+"</b>");
			out.println("</td>");
			out.println("<td colspan=\"2\">");
			out.println("<input type=\"hidden\" name=\"appname\" value=\""+appname+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"appstatus\" value=\""+appstatus+"\"> ");
			out.println("<input type=\"hidden\" size=\"3\" name=\"hidapplicantid\" value=\""+applicantid+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"appholder\" value=\""+strAppholder+"\">");
			out.println("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("op") && strAppholder.equals(strUserId))?"Y":"N";
			out.println("<input type=\"hidden\" size=\"3\" name=\"btnenable\" value=\""+btnenable+"\">");
			out.println("<input type=\"hidden\" size=\"15\" name=\"propappno\" value=\""+strpropappno+"\">");
			out.println("<input type=\"hidden\" size=\"15\" name=\"apporgname\" value=\""+strApporgname+"\">");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MSTHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

