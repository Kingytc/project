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


public class MonitorReviewTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String appno = "";
	static Logger log=Logger.getLogger(MonitorReviewTag.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession session1=pageContext.getSession();
		char readFlag=Helper.correctNull((String)session1.getAttribute("strGroupRights")).charAt(18);
		String strcbsid = "";
		String cbsname="";
		String reviewYear="";
		String appstatus="";
		String mmrStatus="";
		String StrTLReviewno="";
		String strAppStatus=null;
		String strAppholder ="";
		
		boolean boolflag=false;
		try
		{
			strcbsid = Helper.correctNull( (String) request.getParameter("cbsid"));
			cbsname = Helper.correctNull((String) request.getParameter("cbsname"));
			reviewYear =Helper.correctNull((String) request.getParameter("reviewYear"));
			appstatus =Helper.correctNull((String) request.getParameter("appstatus"));
			StrTLReviewno = Helper.correctNull((String)request.getParameter("hidtlrno"));
			strAppholder=Helper.correctNull((String)request.getParameter("appholder"));
			String strUserId=Helper.correctNull((String)session1.getAttribute("strUserId"));
			String strSourcepage=Helper.correctNull((String)request.getParameter("hidSourceUrl"));
			String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
			String strApporgname=Helper.correctNull((String)request.getParameter("apporgname"));
			
			HashMap hshParams = new HashMap();
			hshParams.put("cbsid",strcbsid);
			hshParams.put("hidtlrno",StrTLReviewno);
			hshParams.put("reviewYear",reviewYear);
			
					if(strSourcepage.equals("/action/reviewnoteworkflowhistroy.jsp") || strSourcepage.equals("/action/reviewnoteworkflow.jsp"))
					{
						boolflag=true;
					}
			        if(cbsname.equals("") || strcbsid.equals("") || reviewYear.equals("") || strAppholder.equals("") || strValuesin.equals("")) 
					{
			        	boolflag=true;
					}
			        if(boolflag)
					{
						TagDataHelper1 tagDataHelper1=new TagDataHelper1();
						HashMap hshRes=(HashMap)tagDataHelper1.getCBSCustName(hshParams);
					
						if(hshRes!=null)
						{
							cbsname = Helper.correctNull( (String) hshRes.get("personal_custname"));
							strcbsid = Helper.correctNull( (String) hshRes.get("personal_cbsid") );
							reviewYear = Helper.correctNull( (String) hshRes.get("tlr_year") );
							strAppholder = Helper.correctNull( (String) hshRes.get("tlr_holder"));
							appstatus = Helper.correctNull( (String) hshRes.get("tlr_status"));
							strValuesin = Helper.correctNull( (String) hshRes.get("tlr_valuesin") );
							strApporgname=Helper.correctNull((String)hshRes.get("org_name"));
						}

					}
			if(appstatus.equalsIgnoreCase("op"))
			{
				strAppStatus="PENDING";
			}
			else if(appstatus.equalsIgnoreCase("pa"))
			{
				strAppStatus="APPROVED";
			}
			else if(appstatus.equalsIgnoreCase("ca"))
			{
				strAppStatus="CLOSED";
			}
			else
			{
				strAppStatus="PENDING";
			}
			
			
			out = pageContext.getOut();
			out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" height=\"15\" class=\"outertable\">");
			out.println("<tr class=\"applicationheader\">");
			
			out.println("<td width='10%' nowrap>");
			out.println("<b>Application No :</b>");
			out.println("</td>");
			
			out.println("<td width='12%'> <font color='#003399'>"+StrTLReviewno+"</font>&nbsp;&nbsp;"); 
			out.println("</td>");
			
			out.println("<td nowrap width='10%'> ");
			out.println("<b>Borrower Name:</b>");
			out.println("</td>");
			
			out.println("<td nowrap width='20%'><font color='#003399'>"+Helper.decodeAmpersand(cbsname));
			out.println("<input type=\"hidden\" name=\"cbsname\"  value=\""+cbsname+"\">&nbsp;&nbsp;</font></td>");
			
			out.println("<td nowrap width='6%'>");
			out.println("<b>CBS ID:</b>");
			out.println("</td>");
			
			out.println("<td width='7%'><font color='#003399'>"+strcbsid+"&nbsp;&nbsp;</font>");
			out.println("<input type=\"hidden\" name=\"cbsid\"  value=\""+strcbsid+"\"></td>");
			
		
			
			out.println("<td nowrap width='8%'> ");
			out.println("<b>Review Year:</b>");
			out.println("</td>");
			out.println("<td width=\"4%\"><font color='#003399'>" +reviewYear);
			out.println("<input type=\"hidden\" name=\"reviewYear\" value=\""+reviewYear+"\"></font></td>");
			
			out.println("<td width=\"6%\"> ");
			out.println("<b>Status:</b>");
			out.println("</td>");
			
			out.println("<td width=\"6%\"><font color='#003399'>" +strAppStatus);
			out.println("</font></td>");
			out.println("</tr>");
			
			out.println("<tr class=\"applicationheader\">");
			out.println("<td nowrap>");
			out.println("<b>Application Holder</b>");
			out.println("</td>");
			
			out.println("<td> <font color='#003399'>"+strAppholder);
			out.println("</font></td>");
		
			out.println("<td nowrap>");
			out.println("<b>App. Recd. from</b>");
			out.println("</td>");
			
			out.println("<td> <font color='#003399'>"+strApporgname);
			out.println("</font></td>");
			
		    out.println("<td colspan=\"6\">");
			out.println("<input type=\"hidden\" name=\"appstatus\"  value=\""+appstatus+"\">");
			out.print("<input type=\"hidden\" name=\"valuesin\" value=\""+strValuesin+"\">");
			out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("<input type=\"hidden\" size=\"3\" name=\"appholder\" value=\""+strAppholder+"\">");
			out.println("<input type=\"hidden\" name=\"apporgname\" value=\""+strApporgname+"\">");
			String btnenable=(""+readFlag).equals("r")?"N":(strAppStatus.equalsIgnoreCase("PENDING") && strAppholder.equals(strUserId))?"Y":"N";
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+btnenable+"\">");
			out.println("<input type=\"hidden\" name=\"hidtlrno\" readonly value=\""+StrTLReviewno+"\">");
			out.println("<input type=\"hidden\" name=\"appname\" readonly value=\""+cbsname+"\"></td>");
			out.println("</tr>");
			
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in MonitHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}
