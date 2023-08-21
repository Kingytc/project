package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class ApplHeaderTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplHeaderTag.class);
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
		String strAppType=Helper.correctNull((String)httpSession.getAttribute("strAppType"));
		String digiappno=Helper.correctNull((String)httpSession.getAttribute("digiappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull(request.getParameter("Applicationno"));
		}
		if(appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull(request.getParameter("hidProposalNum"));
		}
		String appname = Helper.correctNull((String)request.getParameter("appname"));
		String appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
		String applicantid=Helper.correctNull((String)request.getParameter("hidapplicantid"));
		String inwardno=Helper.correctNull((String)request.getParameter("inwardno"));
		String applevel=Helper.correctNull((String)request.getParameter("applevel"));
		String loanType=Helper.correctNull((String)request.getParameter("apploantype"));
		String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
		String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
		boolean boolflag=false;
		String strAppholder=Helper.correctNull((String)request.getParameter("appholder"));
		String strAppstatus=Helper.correctNull((String)request.getParameter("strappstatus"));
		String strApporgname=Helper.correctNull((String)request.getParameter("apporgname"));
		String RepaymentType=Helper.correctNull((String)request.getParameter("hidRepayType"));
		String sanctionrefno=Helper.correctNull((String)request.getParameter("sanctionrefno"));
		String cbsaccountno=Helper.correctNull((String)request.getParameter("CBSACCOUNTNO"));
		String employmentstatus=Helper.correctNull((String)request.getParameter("PERAPP_EMPLOYMENT"));
		String applicantnewid=Helper.correctNull((String)request.getParameter("hidapplicantnewid"));
		String strProAvailableFor=Helper.correctNull((String)request.getParameter("hidApplicableFor"));
		String strAppprocessAt=Helper.correctNull((String)request.getParameter("hidAppProcessAt"));
		String strAppOrgCode=Helper.correctNull((String)request.getParameter("hidAppOrgcode"));
		String applicationType="",strTakeOverFlag="",strOpenFlag="",strAccOpenDate="",strRevalidationFlag="",strPrdType="";
		
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appno",appno);
			hshParams.put("strUserId",strUserId);
			if(strSourcepage.equals("/action/appworkflowhistory.jsp") || strSourcepage.equals("/action/appworkflowaction.jsp"))
			{
				boolflag=true;
			}
			if(appname.equals("") 
					|| appstatus.equals("")
					|| applicantid.equals("") 
					|| inwardno.equals("") 
					|| applevel.equals("") 
					|| loanType.equals("") 
					|| strValuesin.equals("") 
					|| strAppholder.equals("")
					||RepaymentType.equals("")
					||(sanctionrefno.equals("") || (cbsaccountno.equals("")) || (employmentstatus.equals(""))&& !strAppstatus.equals("op"))
					)
			{
				boolflag=true;
			}
			if(boolflag)
			{
				TagDataHelper1 tagDataHelper1=new TagDataHelper1();
				HashMap hshRes=(HashMap)tagDataHelper1.getAppData(hshParams);
			
				if(hshRes!=null)
				{
					appname = Helper.correctNull( (String) hshRes.get("app_name") );
					//appstatus = Helper.correctNull( (String) hshRes.get("app_status") );
					strAppstatus=Helper.correctNull( (String) hshRes.get("app_status") );
					applicantid = Helper.correctNull( (String) hshRes.get("applicantid") );
					inwardno = Helper.correctNull( (String) hshRes.get("inwardno") );
					applevel=Helper.correctNull( (String) hshRes.get("applevel") );
					loanType=Helper.correctNull( (String) hshRes.get("apploantype") );
					strValuesin=Helper.correctNull((String)hshRes.get("valuesin"));
					strAppholder=Helper.correctNull((String)hshRes.get("applnholder"));
					strApporgname=Helper.correctNull((String)hshRes.get("apporgname"));
					RepaymentType=Helper.correctNull((String)hshRes.get("repaytype"));
					sanctionrefno=Helper.correctNull((String)hshRes.get("sanctionrefno"));
					cbsaccountno=Helper.correctNull((String)hshRes.get("CBSACCOUNTNO"));
					employmentstatus=Helper.correctNull((String)hshRes.get("PERAPP_EMPLOYMENT"));
					applicantnewid = Helper.correctNull( (String) hshRes.get("applicantnewid") );
					applicationType=Helper.correctNull( (String) hshRes.get("ApplicantType") );
					strTakeOverFlag=Helper.correctNull( (String) hshRes.get("takeoverflag") );
					strOpenFlag=Helper.correctNull( (String) hshRes.get("strAccopenFlag") );
					strAccOpenDate=Helper.correctNull( (String) hshRes.get("strAccopenDate") );
					strAppprocessAt=Helper.correctNull( (String) hshRes.get("app_processat") );
					strRevalidationFlag=Helper.correctNull( (String) hshRes.get("strRevalidationFlag") );
					strAppOrgCode=Helper.correctNull( (String) hshRes.get("apporgcode") );
					strPrdType=Helper.correctNull( (String) hshRes.get("prdType"));
					digiappno=Helper.correctNull( (String) hshRes.get("digiappno"));
					if(digiappno.equalsIgnoreCase(""))
					{
						digiappno="NA";
					}
				}
				
				
				if(strAppstatus.equalsIgnoreCase("op") || appno.equalsIgnoreCase("new"))
				{
					appstatus = "Open/Pending";
				}
				else if(strAppstatus.equalsIgnoreCase("pa"))
				{
					appstatus = "Processed/Approved";
				}
				else if(strAppstatus.equalsIgnoreCase("pr"))
				{
					appstatus = "Processed/Rejected";
				}
				else if(strAppstatus.equalsIgnoreCase("ca"))
				{
					appstatus = "Closed/Approved";
				}
				else if(strAppstatus.equalsIgnoreCase("cr"))
				{
					appstatus = "Closed/Rejected";
				}
				else if(strAppstatus.equalsIgnoreCase("ol"))
				{
					appstatus = "Open/Lodged";
				}
				
				/*if(strAppholder.equals(""))
				{
					strAppholder="Y";
				}
				else
				{
					strAppholder=strAppholder.equals(strUserId)?"Y":"N";
				}*/
				if(applicationType.equalsIgnoreCase("S"))
				{
					applicationType="Restructure";
				}
				else if(applicationType.equalsIgnoreCase("P"))
				{
					applicationType="Post Sanction";
				}
				else if(applicationType.equalsIgnoreCase("R"))
				{
					applicationType="Renew";
				}
				else{
					applicationType="Fresh";
				}
			}

			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td  width=\"12%\">");
			out.println("&nbsp;<b>Proposal No :</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+appno);
			out.println("</td>");
			
			out.println("<td width=\"10%\">");
			out.println("&nbsp;<b>Applicant Name:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+appname);
			
			out.println("<td width=\"7%\">");
			out.println("&nbsp;<b>Status:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+appstatus);
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;<b>Digi Appno:</b>");
			out.println("</td>");
			
			
			out.println("<td>");
			out.println("&nbsp;"+digiappno);
			out.println("</td>");
			
			out.println("</tr>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Application Holder:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+strAppholder);
			out.println("</td>");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>App. Recd. from:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+strApporgname);
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("&nbsp;<b>Application No:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+inwardno);
			
			if(!strAppType.equalsIgnoreCase("P")&&loanType.equalsIgnoreCase("P") && strAppstatus.equalsIgnoreCase("pa"))
			{
				out.println("<td width=\"15%\">");
				out.println("&nbsp;<b>Whether Send to CBS Done :</b>");
				out.println("</td>");
				
				out.println("<td>");
				out.println("&nbsp;"+strOpenFlag);
				out.println("</td>");
			}else{
				out.println("<td>");
				out.println("&nbsp;");
				out.println("</td>");
			}

			out.println("<input type=\"hidden\" name=\"appstatus\" value=\""+appstatus+"\"> ");
			out.println("<input type=\"hidden\" name=\"appname\" value=\""+appname+"\"></td>");
			out.println("<input type=\"hidden\" name=\"appno\" value=\""+appno+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"hidapplicantid\" value=\""+applicantid+"\">");
			out.println("<input type=\"hidden\" name=\"inwardno\" value=\""+inwardno+"\">");
			out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"appholder\" value=\""+strAppholder+"\">");
			out.println("<input type=\"hidden\" name=\"applevel\" value=\""+applevel+"\">");
			out.println("<input type=\"hidden\" name=\"apploantype\" value=\""+loanType+"\">");
			out.println("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			out.println("<input type=\"hidden\" name=\"strappstatus\" value=\""+strAppstatus+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"digiappno\" value=\""+digiappno+"\">");
			out.println("<input type=\"hidden\" name=\"apporgname\" value=\""+strApporgname+"\">");
			out.println("<input type=\"hidden\" name=\"hidRepayType\" value=\""+RepaymentType+"\">");
			out.println("<input type=\"hidden\" name=\"sancrefno\" value=\""+sanctionrefno+"\">");
			out.println("<input type=\"hidden\" name=\"employmentstatus\" value=\""+employmentstatus+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"hidapplicantnewid\" value=\""+applicantnewid+"\">");
			out.println("<input type=\"hidden\" size=\"12\" name=\"hidapplicationType\" value=\""+applicationType+"\">");
			out.println("<input type=\"hidden\" size=\"12\" name=\"hidTakeOverFlag\" value=\""+strTakeOverFlag+"\">");
			out.println("<input type=\"hidden\" size=\"12\" name=\"hidApplicableFor\" value=\""+strProAvailableFor+"\">");
			out.println("<input type=\"hidden\" size=\"12\" name=\"hidAppProcessAt\" value=\""+strAppprocessAt+"\">");
			out.println("<input type=\"hidden\" size=\"12\" name=\"hidAppOrgcode\" value=\""+strAppOrgCode+"\">");
			
			String btnenable=(""+readFlag).equals("r")?"N":(strAppstatus.equalsIgnoreCase("OP") && strAppholder.equals(strUserId))?"Y":"N";
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+btnenable+"\">");
			out.println("</td>");
			
					
			out.println("</tr>");
			
			out.println("<tr class=\"applicationheader\">");
			
			out.println("<td nowrap>");
			out.println("&nbsp;<b>Sanction / Rejected Reference No:</b>");
			out.println("</td>");
			//sanctionrefno
			out.println("<td>");
			out.println("&nbsp;"+sanctionrefno);
			out.println("</td>");
			
			if(loanType.equalsIgnoreCase("P"))
			{
				out.println("<td nowrap>");
				out.println("&nbsp;<b>CBS Account No:</b>&nbsp;");
				out.println("</td>");
				
				out.println("<td>");
				out.println("&nbsp;"+cbsaccountno);
				out.println("</td>");
			}
			
			out.println("<td nowrap>");
			out.println("&nbsp;<b>Proposal Type:</b>&nbsp;");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+applicationType);
			out.println("</td>");
			
			if(!strAppType.equalsIgnoreCase("P")&&loanType.equalsIgnoreCase("P") && strAppstatus.equalsIgnoreCase("pa"))
			{
				out.println("<td width=\"7%\">");
				out.println("&nbsp;<b>Date of Account Opening:</b>");
				out.println("</td>");
				
				out.println("<td>");
				out.println("&nbsp;"+strAccOpenDate);
				out.println("</td>");
			}else{
				out.println("<td>");
				out.println("&nbsp;");
				out.println("</td>");
			}
			
			
			
			if(!strAppType.equalsIgnoreCase("P")&&loanType.equalsIgnoreCase("P") && strAppstatus.equalsIgnoreCase("pa"))
			{
				
				if(!strRevalidationFlag.equalsIgnoreCase(""))
				{
					out.println("<td nowrap>");
					out.println("&nbsp;<b>Revalidation Initiated</b>&nbsp;");
					out.println("</td>");
					
					out.println("<td>");
					out.println(strRevalidationFlag+"&nbsp;");
					out.println("</td>");
				}
				else
				{
					out.println("<td colspan=\"2\">");
					out.println("&nbsp;");
					out.println("</td>");
				}
			}
			
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

