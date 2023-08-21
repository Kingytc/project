package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperBST;

public class BSTHeadtag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(BSTHeadtag.class);
	
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
		String strUserId=Helper.correctNull((String)httpSession.getAttribute("strUserId"));
		String appname = Helper.correctDoubleQuotesHtml(request.getParameter("appname"));
		String strCatory= Helper.correctNull(request.getParameter("hidcatory"));
		String strappno = Helper.correctNull(request.getParameter("appno"));
		String strappid=Helper.correctNull((String)request.getParameter(("com_id")));
		String strappstatus = "";
		String appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
		String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
		String strappholder=Helper.correctNull((String)request.getParameter("applnholder"));
		String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
		String strApporgname=Helper.correctNull((String)request.getParameter("apporgname"));
		
		
		boolean boolflag=false;
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appno",strappno);
			if(strSourcepage.equals("/action/combst_workflowhistroy.jsp") || strSourcepage.equals("/action/combst_workflowaction.jsp"))
			{
				boolflag=true;
			}
				
				if(appname.equals("") 
						|| strCatory.equals("")
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
				TagDataHelperBST tagDataHelperbst=new TagDataHelperBST();
				HashMap hshRes=(HashMap)tagDataHelperbst.getBSTAppData(hshParams);
				//appstatus
				
				if(hshRes!=null)
				{
					appname = Helper.correctNull( (String) hshRes.get("companyname") );
					appstatus = Helper.correctNull( (String) hshRes.get("appstatus") );
					strappholder = Helper.correctNull( (String) hshRes.get("applnholder") );
					strValuesin = Helper.correctNull( (String) hshRes.get("valuesin") );
					strApporgname = Helper.correctNull((String)hshRes.get("org_name"));//					
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
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"outertable linebor\">");
			out.println("<tr class=\"applicationheader\">");
			out.print("<td width=\"10%\">");
			out.print("<b>Application No</b>");
			out.print("</td>");
			out.print("<td width=\"12%\"><b>"+strappno+"</b>");
			out.print("<input type=\"hidden\" name=\"appno\" value=\""+strappno+"\"></td>");
			out.print("<td width=\"12%\"><b>Applicant Name</b>");
			out.print("</td>");
			out.print("<td width=\"25%\"><b>"+Helper.decodeAmpersand(appname)+"</b>");
			out.print("<input type=\"hidden\" name=\"appname\" value=\""+appname+"\"></td>");
			out.print("<td width=\"6%\"><b>Status</b>");
			out.print("</td>");
			out.print("<td width=\"12%\"><b>"+strappstatus+"</b>");
			out.print("</td>");
			out.print("</tr>");
			out.println("<tr class=\"applicationheader\">");
			out.print("<td>");
			out.print("<b>Application Holder</b>");
			out.print("</td>");
			out.print("<td><b>"+strappholder+"</b>");
			out.print("<input type=\"hidden\" name=\"applnholder\" value=\""+strappholder+"\"></td>");
			out.print("<td>");
			out.print("<b>App. Recd. from</b>");
			out.print("</td>");
			out.print("<td><b>"+strApporgname+"</b>");
			out.print("<input type=\"hidden\" name=\"apporgname\" value=\""+strApporgname+"\"></td>");
			out.print("<td colspan=\"2\">");
			out.print("<input type=\"hidden\" name=\"appstatus\" value=\""+appstatus+"\">");
			out.print("<input type=\"hidden\" name=\"hidcatory\" value=\""+strCatory+"\"> ");
			out.print("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.print("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"com_id\" value=\""+strappid+"\">");
			String btnenable=(""+readFlag).equalsIgnoreCase("r")?"N":(appstatus.equalsIgnoreCase("op") && strappholder.equals(strUserId))?"Y":"N";
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+btnenable+"\">");
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in BSTHeadtag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}