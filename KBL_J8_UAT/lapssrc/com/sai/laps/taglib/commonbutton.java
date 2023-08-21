package com.sai.laps.taglib;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;


public class commonbutton extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(commonbutton.class);
	String grouprights = "";
	String strBtntype = "";
	String strBtnenable="";
	//String appavailstatus="";
	JspWriter out = null; 
	String appstatus="";

	public void setBtntype(String btntype)
	{
		this.strBtntype = btntype.trim();
		out = pageContext.getOut();
	}
	public void setBtnenable(String btnenable)
	{
		this.strBtnenable = btnenable.trim();
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{
		String strMsg = "";
		//String appstatus="";
		ServletRequest request = null;
		try
		{
			HttpSession Session = pageContext.getSession();
			request = pageContext.getRequest();
			
			grouprights =Helper.correctNull((String)Session.getAttribute("strGroupRights"));
			appstatus = Helper.correctNull((String)request.getParameter("strappstatus"));
			
			if(appstatus.equalsIgnoreCase(""))
			{
				appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
			}
			if(appstatus.equalsIgnoreCase(""))
			{
				appstatus = Helper.correctNull((String)request.getParameter("app_status"));
			}
			
			//appavailstatus= Helper.correctNull((String)request.getParameter("appstatus"));
			
			strMsg = msgReturn();
			out.println(contents(strMsg));
		}
		catch(Exception ce)
		{
			log.error("exception in commonbuttons.. "+ce);
		}
		return EVAL_PAGE;
	}

	public String msgReturn()
	{
		log.info("Application Status    :: "+appstatus);
		log.info("grouprights           :: "+grouprights.substring(18,19));
		log.info("strBtnenable          :: "+strBtnenable);
		String msg = "";
		if( appstatus.startsWith("Closed") || appstatus.startsWith("Processed") || appstatus.equalsIgnoreCase("PA") || appstatus.equalsIgnoreCase("PR") || appstatus.equalsIgnoreCase("CA") || appstatus.equalsIgnoreCase("CR"))
			msg = "disabled";
		else if(strBtnenable.equalsIgnoreCase("N"))
		{
			msg = "disabled";
		}
		else
		{
			if(grouprights.substring(18,19).equalsIgnoreCase("r"))
				msg = "disabled";
			if(grouprights.substring(18,19).equalsIgnoreCase("w"))
			{
				/*if(appavailstatus.equalsIgnoreCase("N"))
					msg = "disabled";
				else*/
					msg = "";
			}
		}
		return msg;	
	}

	public String contents(String msg)
	{
		StringBuffer sbfcontents = new StringBuffer();
		log.info("Button Functionality  :: "+msg);
		if( msg.equals("") )
		{
			sbfcontents.append("<table width='0%' border='1' cellspacing='0' cellpadding='0' bordercolorlight='#FFFFFB' bordercolordark='#DEDACF' bgcolor='#DEDACF' align='center'>"); 
			sbfcontents.append("<tr><td>"); 
			sbfcontents.append("<table width='0%' border='0' cellspacing='0' cellpadding='3'>"); 
			sbfcontents.append("<tr valign='top'><td align='center'>");
			if(strBtntype.equalsIgnoreCase("AO") || strBtntype.equalsIgnoreCase("AP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='Add' onClick=\"doNew()\" class=\"buttonStyle\">");
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("AEO") || strBtntype.equalsIgnoreCase("AEP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='Add' onClick=\"doNew()\" class=\"buttonStyle\">");
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\" disabled>"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("NO") || strBtntype.equalsIgnoreCase("NP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='New' onClick=\"doNew()\" class=\"buttonStyle\">");
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\" disabled>"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("EO") || strBtntype.equalsIgnoreCase("EP"))
			{
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\">"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			sbfcontents.append("<input type='button'name='cmdsave' value='Save' onClick=\"doSave()\" class=\"buttonStyle\" disabled>"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmdcancel' value='Cancel' onClick=\"doCancel()\" class=\"buttonStyle\" disabled>"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmddel' value='Delete' onClick=\"doDelete()\" class=\"buttonStyle\" disabled>"); 
			//sbfcontents.append("</td><td align='center'>"); 
			//sbfcontents.append("<input type='button' name='cmdhelp' value='Help' onClick=\"doHelp(strvalue)\" class=\"buttonHelp\">"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmdclose' value='Close' onClick=\"doClose()\" class=\"buttonClose\">");
			if(strBtntype.equalsIgnoreCase("EP") || strBtntype.equalsIgnoreCase("NP"))
				{
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdprint' value='Print' onClick=\"doPrint()\" class=\"buttonPrint\">");
				}
			sbfcontents.append("</td></tr></table>"); 
			sbfcontents.append("</td></tr></table>"); 
		}
		else
		{
			sbfcontents.append("<table width='0%' border='1' cellspacing='0' cellpadding='0' bordercolorlight='#FFFFFB' bordercolordark='#DEDACF' bgcolor='#DEDACF' align='center'>"); 
			sbfcontents.append("<tr><td>"); 
			sbfcontents.append("<table width='0%' border='0' cellspacing='0' cellpadding='3'>"); 
			sbfcontents.append("<tr valign='top'><td align='center'>"); 
			if(strBtntype.equalsIgnoreCase("AO") || strBtntype.equalsIgnoreCase("AP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='Add' onClick=\"doNew()\" class=\"buttonStyle\"  "+msg+ ">");
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("AEO") || strBtntype.equalsIgnoreCase("AEP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='Add' onClick=\"doNew()\" class=\"buttonStyle\"  "+msg+ ">");
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\"  "+msg+ ">"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("NO") || strBtntype.equalsIgnoreCase("NP"))
			{
				sbfcontents.append("<input type='button' name='cmdnew' value='New' onClick=\"doNew()\" class=\"buttonStyle\"  "+msg+ ">");
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\"  "+msg+ ">"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			else if(strBtntype.equalsIgnoreCase("EO") || strBtntype.equalsIgnoreCase("EP"))
			{
				sbfcontents.append("<input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" class=\"buttonStyle\"  "+msg+ ">"); 
				sbfcontents.append("</td><td align='center'>"); 
			}
			sbfcontents.append("<input type='button'name='cmdsave' value='Save' onClick=\"doSave()\" class=\"buttonStyle\"  "+msg+ ">"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmdcancel' value='Cancel' onClick=\"doCancel()\" class=\"buttonStyle\" "+msg+ ">"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmddel' value='Delete' onClick=\"doDelete()\" class=\"buttonStyle\" "+msg+ ">"); 
			//sbfcontents.append("</td><td align='center'>"); 
			//sbfcontents.append("<input type='button' name='cmdhelp' value='Help' onClick=\"doHelp(strvalue)\" class=\"buttonHelp\">"); 
			sbfcontents.append("</td><td align='center'>"); 
			sbfcontents.append("<input type='button' name='cmdclose' value='Close' onClick=\"doClose()\" class=\"buttonClose\">");
			if(strBtntype.equalsIgnoreCase("EP") || strBtntype.equalsIgnoreCase("NP"))
				{
				sbfcontents.append("</td><td align='center'>"); 
				sbfcontents.append("<input type='button' name='cmdprint' value='Print' onClick=\"doPrint()\" class=\"buttonPrint\">");
				}
			sbfcontents.append("</td></tr></table>"); 
			sbfcontents.append("</td></tr></table>"); 
		}
				
			return sbfcontents.toString();
	}
}


