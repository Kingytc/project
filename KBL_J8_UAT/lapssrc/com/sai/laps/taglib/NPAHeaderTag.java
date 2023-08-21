package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class NPAHeaderTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JspWriter out = null;
	static Logger log=Logger.getLogger(NPAHeaderTag.class);
	
	public int doEndTag() throws JspException
	{  
		
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		String strAppno =  Helper.correctNull(request.getParameter("appno"));
		char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
		
		if(strAppno.equalsIgnoreCase("") || strAppno.equalsIgnoreCase("null"))
		{
			strAppno =  Helper.correctNull(request.getParameter("npa_appno"));
		}
		if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
		{
			strAppno =  Helper.correctNull(request.getParameter("strappno"));
		}
		if(strAppno.equalsIgnoreCase("null") || strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String) httpSession.getAttribute("strappno"));
		}
		
		String strmoduletype = Helper.correctNull((String) request.getParameter("hidmoduletype"));
		String strcbsid=Helper.correctNull((String) request.getParameter("cbsid"));
		String appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
		String applicantid= Helper.correctNull((String)request.getParameter("hidapplicantid"));
		String strBorrowertype=Helper.correctNull((String)request.getParameter("hidborrowertype"));
		String strOrgShortCode = Helper.correctNull((String)httpSession.getAttribute("strOrgShortCode"));
		String strUserId=Helper.correctNull((String)httpSession.getAttribute("strUserId"));
		String appname= Helper.decodeAmpersand(Helper.correctNull(request.getParameter("appname")));
		String strAppname=Helper.correctNull(request.getParameter("appname"));
		String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
		String npaholder=Helper.correctNull((String)request.getParameter("appholder"));
		String npaorgscode=Helper.correctNull((String)request.getParameter("npaorgcode"));
		String strOrgname=Helper.correctNull((String)request.getParameter("apporgname"));
		
		String stryear="";
		String strquarter="";
		String strQua="";
		
		String strAppstatus="";
		String checkvalue="npa";
		String strBTNEnable="Y";
		
		boolean boolflag=false;
		try
		{
			
			if(strmoduletype.equalsIgnoreCase("STAT"))
			{
				stryear = Helper.correctNull((String) request.getParameter("year"));
				
				if(stryear.equalsIgnoreCase(""))
				{
					stryear=strAppno.substring(6,10);
				}
				
				strquarter = Helper.correctNull((String) request.getParameter("quarter"));
				if(strquarter.equalsIgnoreCase(""))
				{
					strquarter=strAppno.substring(10,11);
				}
				if(strquarter.equals("1"))
				{
					strQua="First";
				}
				if(strquarter.equals("2"))
				{
					strQua="Second";
				}
				if(strquarter.equals("3"))
				{
					strQua="Third";
				}
				if(strquarter.equals("4"))
				{
					strQua="Fourth";
				}
			}
			
			
			HashMap hshParams = new HashMap();
			hshParams.put("appno",strAppno);
			hshParams.put("check",checkvalue);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=null;
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				boolflag=false;
			}
			if(strSourcepage.equals("/action/npa_appworkflowaction.jsp"))
			{
				boolflag=true;
			}
			if(strAppname.equals("") ||
					strAppno.equals("") ||
					strcbsid.equals("")||
					appstatus.equals("")||
					strBorrowertype.equals("")||
					strmoduletype.equals("")||
					npaholder.equals("")||
					npaorgscode.equals(""))
			{
				boolflag=true;
			}
			
			if(boolflag)
			{
				hshRes=(HashMap)tagDataHelper1.getAppData(hshParams);
				if(hshRes!=null)
				{
					appname=Helper.correctNull((String)hshRes.get("customername"));
					strAppname=Helper.encodeAmpersand((String)hshRes.get("customername"));
					strAppno = Helper.correctNull((String)hshRes.get("npaappno"));
					strcbsid=Helper.correctNull((String)hshRes.get("cbsid"));
					appstatus = Helper.correctNull((String)hshRes.get("status"));
					strBorrowertype=Helper.correctNull((String)hshRes.get("demoapptype"));
					strmoduletype=Helper.correctNull((String)hshRes.get("moduletype"));
					npaholder = Helper.correctNull((String)hshRes.get("holduserid"));
					npaorgscode = Helper.correctNull((String)hshRes.get("createorgscode"));
					strOrgname = Helper.correctNull((String)hshRes.get("apporgname"));
				}
			}
			/*else
			{
				strAppno="NEW";
				strAppstatus = "";
				appstatus="op";
			}*/
			if(appstatus.equalsIgnoreCase("pp"))
			{
				strAppstatus = "Open/Pending";
			}
			if(appstatus.equalsIgnoreCase("op"))
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
				if(strmoduletype.equalsIgnoreCase("STAT"))
				{
					strAppstatus = "Closed";
				}
				else
				{
					strAppstatus = "Closed/Approved";
				}
			}
			else if(appstatus.equalsIgnoreCase("cr"))
			{
				strAppstatus = "Closed/Rejected";
			}
			if((appstatus.equalsIgnoreCase("op") || appstatus.equalsIgnoreCase("pp")) && (""+readFlag).equalsIgnoreCase("W"))
			{
				if(npaholder.equals(""))
				{
					strBTNEnable="Y";
				}
				else if(npaholder.equals(strUserId))
				{
					if(strmoduletype.equalsIgnoreCase("STAT"))
					{
						if(strOrgShortCode.equals(npaorgscode))
						{
							strBTNEnable="Y";
						}
						else
						{
							strBTNEnable="N";
						}
					}
					else 
					{
						strBTNEnable="Y";
					}
				}
				else
				{
					strBTNEnable="N";
				}
			}
			else
			{
				strBTNEnable="N";
			}
			
			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.println("<tr class='applicationheader'>");
			
			out.println("<td nowrap>");
			out.println("<b>Application No :</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+strAppno+"</b>");
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("<b>Applicant Name:</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+appname+"</b>");
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("<b>CBS CUSTOMER ID:</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+strcbsid+"</b>");
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("<b>Status:</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+strAppstatus+"</b>");
			out.println("</td>");
			
			out.println("</tr>");
			out.println("<tr class='applicationheader'>");
			
			out.println("<td nowrap>");
			out.println("<b>Application Holder:</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+npaholder+"</b>");
			out.println("</td>");
			
			out.println("<td nowrap>");
			out.println("<b>Application Recd. from:</b>");
			out.println("</td>");
			out.println("<td nowrap>");
			out.println("<b>"+strOrgname+"</b>");
			out.println("</td>");
			
			if(strmoduletype.equalsIgnoreCase("STAT"))
			{
				out.println("<td> ");
				out.println("<b>Year:</b>");
				out.println("</td>");
				out.println("<td><b>"+stryear+"</b>");
				out.println("</td>");
				
				out.println("<td> ");
				out.println("<b>Quarter:</b>");
				out.println("</td>");
				out.println("<td><b>"+strQua+"</b>");
				out.println("</td>");
				
				out.println("<input type=\"hidden\" name=\"quarter\" value=\""+strquarter+"\">");
				out.println("<input type=hidden name=year value="+stryear+">");
				out.println("<input type=hidden name=Qua value="+strQua+">");
			}
			else
			{
				out.println("<td colspan=\"4\"> &nbsp;</td>");
			}
			out.println("<input type=\"hidden\" name=\"appstatus\" value=\""+appstatus+"\">");
			out.println("<input type=\"hidden\" name=\"appname\" value=\""+strAppname+"\">");
			out.println("<input type=\"hidden\" name=\"cbsid\" value=\""+strcbsid+"\">");
			out.println("<input type=\"hidden\" name=\"hidapplicantid\" value=\""+applicantid+"\">");
			out.println("<input type=\"hidden\" name=\"appno\" value=\""+strAppno+"\">");
			out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("<input type=\"hidden\" name=\"hidmoduletype\" value=\""+strmoduletype+"\">");
			out.println("<input type=\"hidden\" name=\"hidborrowertype\" value=\""+strBorrowertype+"\">");
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+strBTNEnable+"\">");
			out.println("<input type=\"hidden\" name=\"appholder\" value=\""+npaholder+"\">");
			out.println("<input type=\"hidden\" name=\"npaorgcode\" value=\""+npaorgscode+"\">");
			out.println("<input type=\"hidden\" name=\"apporgname\" value=\""+strOrgname+"\">");
			
			out.println("</tr>");
			out.println("</table>");
			
		}
		catch(Exception e)
		{
			log.error("exception in NPAHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
	

	
}

