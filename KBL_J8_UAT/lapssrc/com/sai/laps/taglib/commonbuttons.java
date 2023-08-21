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
import com.sai.laps.tagdatahelper.TagDataHelper2;


public class commonbuttons extends TagSupport
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(commonbuttons.class);
	private static final long serialVersionUID = 1L;
	String grouprights = "";
	String sessionorgcode = "";
	String apporgcode = "";
	String strSource = "";
	String strLevel = "";
	JspWriter out = null; 
	String status = null;

	public void setApporgcode(String apporgcode)
	{
		HttpSession session = pageContext.getSession();
		this.apporgcode = (String)session.getAttribute("strOrgShortCode");
		
		/*if(apporgcode == null)
		{
			this.apporgcode = Helper.correctNull(apporgcode);
		}

		this.apporgcode = apporgcode.trim();
		
		if(!this.apporgcode.equalsIgnoreCase(""))
		{
			this.apporgcode = this.apporgcode.substring(0,4);
		}*/

		out = pageContext.getOut();
	}

	public void setStrSource(String strSource)
	{
		if(strSource == null)
		{
			strSource = Helper.correctNull(strSource);
		}
		this.strSource = strSource.trim();
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{
		String strMsg = "";
		//String appurl=null;
		HashMap hshRequestValues = null;
		HashMap hshgetOrg = null;
		try
		{
			ServletRequest request = pageContext.getRequest();
			status = Helper.correctNull(request.getParameter("appstatus"));
			//appurl = ApplicationParams.getAppUrl();
			
			hshRequestValues = new HashMap();
			hshRequestValues.put("OrgCode",apporgcode);
			HttpSession Session = pageContext.getSession();
			grouprights = (String)Session.getAttribute("strGroupRights");
			sessionorgcode = (String)Session.getAttribute("strOrgCode");
			strLevel = (String)Session.getAttribute("strOrgLevel");

			log.info("grouprights full *****  "+grouprights);
			log.info("sessionorgcode *****  "+sessionorgcode);
			log.info("strLevel *****  "+strLevel);
			log.info("apporgcode *****  "+apporgcode);

			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			hshgetOrg=(HashMap)tagDataHelper2.getOrgCode(hshRequestValues);
			//hshgetOrg = (HashMap)EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"getOrgCode");
			apporgcode = (String)hshgetOrg.get("OrgCode");
			
			if(!apporgcode.equals(""))
			{
				 strMsg = msgReturn();
			}
			else
			{
				 strMsg ="";
			}

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
		//String strTemp = "";
		String msg = "";
		/*int intlevel = 0;
		
		if(strLevel.equalsIgnoreCase("c"))
		{
			intlevel =3;
		}

		if(strLevel.equalsIgnoreCase("r"))
		{
			intlevel =6;
		}

		if(strLevel.equalsIgnoreCase("d"))
		{
			intlevel =9;
		}

		if(strLevel.equalsIgnoreCase("b"))
		{
			intlevel =12;
		}

		if(strLevel.equalsIgnoreCase("a"))
		{
			intlevel =15;
		}

		for(int i=intlevel;i<15;i++)
		{
			strTemp+="0";
		}*/

		
		//if(sessionorgcode.equals(apporgcode))
		//{
			//log.info("1"  + "Current Organisation");
			//log.info("Current Organisation"+status.startsWith("Closed"));
			//log.info("Current Organisation"+status.startsWith("Processed"));
			
			if(!strSource.equalsIgnoreCase("control"))
			{
				if( status.startsWith("Closed") || status.startsWith("Processed") )
					msg = "disabled";
				else
				{
					if(grouprights.substring(18,19).equalsIgnoreCase("r"))
						msg = "disabled";
					if(grouprights.substring(18,19).equalsIgnoreCase("w"))
						msg = "";
				}
			}
			else
			{
				if(grouprights.substring(18,19).equalsIgnoreCase("r"))
					msg = "disabled";
				if(grouprights.substring(18,19).equalsIgnoreCase("w"))
					msg = "";
			}
		//}
		/*else if(sessionorgcode.substring(0,intlevel).equals(apporgcode.substring(0,intlevel))
			     && sessionorgcode.substring(intlevel,15).equals(strTemp))
		{
			log.info("Child Organization");
			log.info("Child Organization"+status.startsWith("Closed"));
			log.info("Child Organization"+status.startsWith("Processed"));
			if(!strSource.equalsIgnoreCase("control"))
			{
				if( status.startsWith("Closed") || status.startsWith("Processed") )
					msg = "disabled";
				else
				{
					if(grouprights.substring(19,20).equalsIgnoreCase("r"))
						msg = "disabled";
					if(grouprights.substring(19,20).equalsIgnoreCase("w"))
						msg = "";
				}
			}
			else
			{
				if(grouprights.substring(19,20).equalsIgnoreCase("r"))
					msg = "disabled";
				if(grouprights.substring(19,20).equalsIgnoreCase("w"))
					msg = "";
			}
		}
		else
		{
			log.info("Other Organization");
			log.info("Other Organization"+status.startsWith("Closed"));
			log.info("Other Organization"+status.startsWith("Processed"));
			if(!strSource.equalsIgnoreCase("control"))
			{
				if( status.startsWith("Closed") || status.startsWith("Processed") )
					msg = "disabled";
				else
				{
					if(grouprights.substring(20,21).equalsIgnoreCase("r"))
						msg = "disabled";
					if(grouprights.substring(20,21).equalsIgnoreCase("w"))
						msg = "";
				}
			}
			else
			{
				if(grouprights.substring(20,21).equalsIgnoreCase("r"))
					msg = "disabled";
				if(grouprights.substring(20,21).equalsIgnoreCase("w"))
					msg = "";
			}
		}*/
		return msg;	
	}

	public String contents(String msg)
	{
		StringBuffer sbfcontents = new StringBuffer();

		if( msg.equals("") )
		{
			sbfcontents.append("<table width='0%' border='1' cellspacing='0'"); 
			sbfcontents.append("cellpadding='0' bordercolorlight='#FFFFFB' bordercolordark='#DEDACF' bgcolor='#DEDACF' align='center'>");
			sbfcontents.append("<tr><td><table width='0%' border='0' cellspacing='0' cellpadding='3'><tr valign='top'><td width='16%'><input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" "); 
			sbfcontents.append("style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'  ></td><td width='16%'><input type='button'"); 
			sbfcontents.append("name='cmdsave' value='Save' onClick=\"doSave()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'   disabled>");
			sbfcontents.append("</td><td width='16%'><input type='button' name='cmdcancel' value='Cancel' onClick=\"doCancel()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'  disabled></td>");
			sbfcontents.append("<td width='16%'><input type='button' name='cmddelete' value='Delete' onClick=\"doDelete()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'   disabled></td>");
			//sbfcontents.append("<td width='16%'><div align='center'><input type='button' name='cmdhelp' value='Help' onClick=\"doHelp(strvalue)\" "); 
			//sbfcontents.append("style='font-weight:bold;background-color:#009966;color:white;font-size=10;font-family:mssansserif;width:50;cursor:help' ></div></td>");
			sbfcontents.append("<td width='15%'><input type='button' name='cmdclose' value='Close' onClick=\"doClose()\" "); 
			sbfcontents.append("style='font-weight:bold;background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50' >");
			sbfcontents.append("</tr></table></td></tr></table>");
		}
		else
		{
			sbfcontents.append("<table width='0%' border='1' cellspacing='0'"); 
			sbfcontents.append("cellpadding='0' bordercolorlight='#FFFFFB' bordercolordark='#DEDACF' bgcolor='#DEDACF' align='center'>");
			sbfcontents.append("<tr><td><table width='0%' border='0' cellspacing='0' cellpadding='3'><tr valign='top'><td width='16%'><input type='button' name='cmdedit' value='Edit' onClick=\"doEdit()\" "); 
			sbfcontents.append("style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'  "+msg+"></td><td width='16%'><input type='button'"); 
			sbfcontents.append("name='cmdsave' value='Save' onClick=\"doSave()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'   "+msg+">");
			sbfcontents.append("</td><td width='16%'><input type='button' name='cmdcancel' value='Cancel' onClick=\"doCancel()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'  "+msg+"></td>");
			sbfcontents.append("<td width='16%'><input type='button' name='cmddelete' value='Delete' onClick=\"doDelete()\" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50' disabled></td>");
			//sbfcontents.append("<td width='16%'><div align='center'><input type='button' name='cmdhelp' value='Help' onClick=\"doHelp(strvalue)\" "); 
			//sbfcontents.append("style='font-weight:bold;background-color:#009966;color:white;font-size=10;font-family:mssansserif;width:50;cursor:help' ></div></td>" +
			sbfcontents.append("<td width='15%'><input type='button' name='cmdclose' value='Close' onClick=\"doClose()\" "); 
			sbfcontents.append("style='font-weight:bold;background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50' >");
			sbfcontents.append("</tr></table></td></tr></table>");
		}
				
			return sbfcontents.toString();
	}
}


