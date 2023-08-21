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

public class MonitHeaderTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonitHeaderTag.class);
	String appno = "";
	String strSource = "";
	
	public void setStrSource(String strSource)
	{
		if(strSource == null)
		{
			strSource = Helper.correctNull(strSource);
		}
		this.strSource = strSource.trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession session1=pageContext.getSession();
		
		String cbsaccno =  Helper.correctNull(request.getParameter("cbsaccno"));
		if(cbsaccno.equalsIgnoreCase("null")|| cbsaccno.equalsIgnoreCase(""))
		{
			cbsaccno=Helper.correctNull(request.getParameter("mon_accno"));
		}
		String strcbsid = Helper.correctNull(request.getParameter("cbsid"));
		String strappname=Helper.correctNull(request.getParameter("appname"));
		String strfacility=Helper.correctNull(request.getParameter("facility"));
		String strStatus=Helper.correctNull(request.getParameter("statusflag"));
		
		char readFlag=Helper.correctNull((String)session1.getAttribute("strGroupRights")).charAt(18);
		try
		{
			if(cbsaccno.equals("") || strcbsid.equals("") || strappname.equals("") || strfacility.equals(""))
			{
				HashMap hshParams = new HashMap();
				hshParams.put("cbsaccno",cbsaccno);
				TagDataHelper1 tagDataHelper1=new TagDataHelper1();
				HashMap hshRes=(HashMap)tagDataHelper1.getMonData(hshParams);
					
				if(hshRes!=null)
				{
					strcbsid = Helper.correctNull( (String) hshRes.get("personal_cbsid") );
					strappname = Helper.correctNull( (String) hshRes.get("personal_custname") );
					strfacility=Helper.correctNull( (String) hshRes.get("limit_facility") );
				}
			}

			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\" class='outertable linebor'>");
			out.println("<tr class='applicationheader'>");
			out.println("<td>");
			out.println("<b>");
			out.println("Account No :");
			out.println("</b>");
			out.println("</td>");
			out.println("<td>"+cbsaccno+"</td>");
			
			
			out.println("<td>");
			out.println("<b>CBS ID:</b>");
			out.println("</td>");
			out.println("<td>"+strcbsid+"</td>");
			
			
			out.println("<td> ");
			out.println("<b>Borrower Name:</b>");
			out.println("</td>");
			out.println("<td>"+strappname+"</td>");
			
			
			out.println("<td width=\"9%\"> ");
			out.println("<b>Facility Name:</b>");
			out.println("</td>");
			out.println("<td width=\"20%\">"+strfacility);
			if(strSource.equalsIgnoreCase("MREG"))
			{
				out.print("<input type=\"hidden\" name=\"statusflag\" value=\""+strStatus+"\">");
				out.print("<input type=\"hidden\" name=\"monCheckFlag\" value=\"yes\">" );
				out.print("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
				out.print("<input type=\"hidden\" name=\"appname\" value=\""+strappname+"\">");
				out.print("<input type=\"hidden\" name=\"cbsaccno\" value=\""+cbsaccno+"\">");
				out.print("<input type=\"hidden\" name=\"facility\" value=\""+strfacility+"\">");
				out.print("<input type=\"hidden\" name=\"cbsid\" value=\""+strcbsid+"\">");
			}
			out.println("</td>");
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