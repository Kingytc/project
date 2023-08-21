package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class  OrgLocationTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(OrgLocationTag.class);

	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		HttpSession httpSession=pageContext.getSession();
		JspWriter out=null;
		out=pageContext.getOut();
		HashMap hshValue=new HashMap();
		String orgScode=(String)httpSession.getAttribute("strOrgShortCode");
		String orgCode=(String)httpSession.getAttribute("strOrgCode");	
		String orgSelect=(String)httpSession.getAttribute("strOrgSelect");	
		String strOrgLevel=(String)httpSession.getAttribute("strOrgLevel");
		if(strOrgLevel.equalsIgnoreCase("R"))
		{
			strOrgLevel = "D";
		
		}
		else if(strOrgLevel.equalsIgnoreCase("D"))
		{
			strOrgLevel = "D";
		}
		try
		{
			hshValue.put("orgscode",orgScode);
			hshValue.put("orglevel",strOrgLevel);
			hshValue.put("orgcode",orgCode);
			hshValue.put("orgSelect", orgSelect);
			hashResult=(HashMap)EJBInvoker.executeStateLess(
									"setusers",hshValue,"getOrgLocationData");
		
			ArrayList arrId = new ArrayList();
			ArrayList arrName = new ArrayList();
			
			arrId = (ArrayList)hashResult.get("arr");
			arrName = (ArrayList)hashResult.get("arr1");
			
			int intSize = 0;
			if(arrId!=null && arrName!=null)
			{
				intSize = arrId.size();
			}
			for(int i=0;i<intSize ;i++)
			{
				String strId = Helper.correctNull((String)arrId.get(i));
				String strName = Helper.correctNull((String)arrName.get(i));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}			
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
