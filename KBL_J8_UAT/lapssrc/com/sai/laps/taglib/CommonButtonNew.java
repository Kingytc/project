package com.sai.laps.taglib;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper3;


public class CommonButtonNew extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(CommonButtonNew.class);
	String grouprights = "";
	String strBtnNames = "";
	String strBtnenable="";
	String strButton[]=null;
	String strRatingNonPoolFlag="";
	String strFinalpageflag="";
	JspWriter out = null; 
	String strUserGrpId="";
	String appstatus="";

	public void setBtnnames(String btnnames)
	{
		this.strBtnNames = btnnames.trim();
		out = pageContext.getOut();
	}
	
	
	public void setfinalpageflag(String finalpageflag) {
		this.strFinalpageflag = finalpageflag;
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
		ServletRequest request = null;
		try
		{
			String strAppno="",struserId="";
			HttpSession Session = pageContext.getSession();
			request = pageContext.getRequest();
			
			strAppno=Helper.correctNull((String)request.getParameter("appno"));
			strUserGrpId=Helper.correctNull((String)Session.getAttribute("strUserGrpId"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)request.getParameter("strAppno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)Session.getAttribute("strAppno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)request.getParameter("hidAppNo"));
			}
			struserId=Helper.correctNull((String)Session.getAttribute("strUserId"));			
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			strRatingNonPoolFlag=tagDataHelper3.getRiskNonPoolFlag(strAppno,struserId);
			grouprights =Helper.correctNull((String)Session.getAttribute("strGroupRights"));
			appstatus = Helper.correctNull((String)request.getParameter("strappstatus"));
			
			if(!strBtnNames.equalsIgnoreCase(""))
			{
				this.strButton=(String [])strBtnNames.split("_");
			}
			
			if(appstatus.equalsIgnoreCase(""))
			{
				appstatus = Helper.correctNull((String)request.getParameter("appstatus"));
			}
			if(appstatus.equalsIgnoreCase(""))
			{
				appstatus = Helper.correctNull((String)request.getParameter("app_status"));
			}
			
			
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
		log.info("strRatingNonPoolFlag  :: "+strRatingNonPoolFlag);
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
				msg = "";
			}
			if(strRatingNonPoolFlag.equalsIgnoreCase("Y"))
			{
				if(strFinalpageflag.equalsIgnoreCase("Y"))
				msg = "";
				else
				msg = "disabled";
			}
		}
		return msg;	
	}
	
	private String formatButtonName(String strButtonName)
	{
		StringBuffer strFormatedButtonName= new StringBuffer();
		String strUpperButtonname=strButtonName.toUpperCase();
		String strLowerButtonname=strButtonName.toLowerCase();
		
		for(int i=0; i<strButtonName.length();i++)
		{
			if(i==0)
			{
				strFormatedButtonName.append(strUpperButtonname.charAt(i));
			}
			else if(strButtonName.charAt(i)==' ')
			{
				++i;
				if((i)<strButtonName.length())
				{
					strFormatedButtonName.append(strUpperButtonname.charAt(i));
				}
			}
			else
			{
				strFormatedButtonName.append(strLowerButtonname.charAt(i));
			}
		}
		
		return strFormatedButtonName.toString();
	}

	public String contents(String strDisabled)
	{
		StringBuffer sbfcontents = new StringBuffer();
		boolean boolbuttondisabled=false;
		log.info("Button Functionality  :: "+strDisabled);
		
		sbfcontents.append("<table width='0%' border='1' cellspacing='0' cellpadding='0' class='outertable' align='center'>\n"); 
		sbfcontents.append("<tr>\n<td>\n"); 
		sbfcontents.append("<table width='0%' border='0' cellspacing='0' cellpadding='3'>\n"); 
		sbfcontents.append("<tr valign='top'>\n");
		
		for(int i=0;strButton!=null && i<strButton.length;i++)
		{
			
			if(formatButtonName(strButton[i]).equals("New") || formatButtonName(strButton[i]).equals("Add"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" "+strDisabled+">\n");
				sbfcontents.append("</td>\n");
				boolbuttondisabled=true;
			}
			else if(formatButtonName(strButton[i]).equals("Edit"))
			{
				if(boolbuttondisabled)
				{
					sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" disabled>\n");
					sbfcontents.append("</td>\n");
				}
				else
				{
					sbfcontents.append("<td align='center'>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" "+strDisabled+">\n");
					sbfcontents.append("</td>\n");
				}
			}
			
			else if(formatButtonName(strButton[i]).equals("Save") || formatButtonName(strButton[i]).equals("Cancel") || formatButtonName(strButton[i]).equals("Delete"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			else if(formatButtonName(strButton[i]).toLowerCase().contains("print"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonPrint\">\n");
				sbfcontents.append("</td>\n");
				boolbuttondisabled=true;
			}
			else if(formatButtonName(strButton[i]).equals("Comments"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			else if(formatButtonName(strButton[i]).equals("History"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"call"+formatButtonName(strButton[i])+"()\" class=\"buttonOthers\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			else if(formatButtonName(strButton[i]).equals("PcComments"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			else if(formatButtonName(strButton[i]).equals("BpcComments"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonStyle\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			else if(formatButtonName(strButton[i]).equals("DMS Upload"))
			{
				sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonInterface1\" disabled>\n");
				sbfcontents.append("</td>\n");
			}
			
			else if(formatButtonName(strButton[i]).equals("Get Cibil"))
				{
					sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonInterface1\" disabled>\n");
					sbfcontents.append("</td>\n");
				}
			
			else 
			{
				
				if((ApplicationParams.getAuditTrailEnable().equalsIgnoreCase("ON"))&& (strUserGrpId.equalsIgnoreCase("1")))
				{
					sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonOthers\">\n");
					sbfcontents.append("</td>\n");
					boolbuttondisabled=true;
				}
				else if(!formatButtonName(strButton[i]).toLowerCase().contains("audittrail"))
				{
					sbfcontents.append("<td>\n<input type='button' name='cmd"+strButton[i].replaceAll(" ", "").toLowerCase()+"' value='"+strButton[i]+"' onClick=\"do"+formatButtonName(strButton[i])+"()\" class=\"buttonOthers\" >\n");
					sbfcontents.append("</td>\n");
					boolbuttondisabled=true;
				}
			}
		
			
		
		}
		
		sbfcontents.append("<td><input type='button' name='cmdclose' value='Close' onClick=\"doClose()\" class=\"buttonClose\">");
		sbfcontents.append("<input type='hidden' name='hidNonPoolFlag' value='"+strRatingNonPoolFlag+"'>");
		sbfcontents.append("</td>\n"); 
		
		sbfcontents.append("</tr></table>"); 
		sbfcontents.append("</td></tr></table>"); 
		return sbfcontents.toString();
	}
}


