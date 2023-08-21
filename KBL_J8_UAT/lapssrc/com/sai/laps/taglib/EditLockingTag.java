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
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class EditLockingTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(EditLockingTag.class);
	JspWriter out = null;
	String apppagename = "";
	
	public void setapppagename(String pid)
	{
		apppagename = pid;
	}
	public int doEndTag() throws JspException
	{  
		HashMap hshPar = new HashMap();
		ServletRequest request = null;
		request = pageContext.getRequest();
		
		try
		{	
			out = pageContext.getOut();
			HttpSession session = pageContext.getSession();
			String strUserName=Helper.correctNull((String)session.getAttribute("strUserId"));
			String strAppno=Helper.correctNull(request.getParameter("appno"));
			String hshRes1=TagDataHelper4.inslogStatus(apppagename,strUserName,strAppno);
			hshPar.put("hshRes1",hshRes1);
			out.println("<input type=\"hidden\" name=\"hidCheckButtondisable\" size=\"20\" value=\""+hshRes1+"\" readonly style=\"border:0;background-color:#FFFFFF\"> </input> ");
		}
		catch(Exception ioe)
		{
			log.error("error occured"+ioe.toString());
		}
		return EVAL_PAGE;
	}
}