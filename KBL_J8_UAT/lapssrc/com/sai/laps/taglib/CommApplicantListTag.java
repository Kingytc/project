package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper2;

public class CommApplicantListTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(CommApplicantListTag.class);
	private static final long serialVersionUID = 1L;
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrcomappid=null;
		ArrayList arrcomname=null;
		ArrayList arrcomid =null;
		HashMap hshRequestValues=new HashMap();
		try
		{
			out=pageContext.getOut();
			
			hshRequestValues.put("comapp_id","%");
			hshRequestValues.put("comapp_companyname","%");
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			hshValues=(HashMap)tagDataHelper2.getApplicantList(hshRequestValues);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("commappmaster",hshRequestValues,
				                          //           "getApplicantList");
			arrcomappid=(ArrayList)hshValues.get("arrcomappid");
			arrcomname=(ArrayList)hshValues.get("arrcomname");
			arrcomid=(ArrayList)hshValues.get("arrcomid");

			for(int i=0;i<arrcomappid.size();i++)
			{
				String strId=(String)arrcomappid.get(i);
				String strName=(String)arrcomname.get(i);
				String strCmpID=(String)arrcomid.get(i);
				strName=correctDoubleQuotesHtml(strName);
				out.println("<option title=\""+strName+"-"+strCmpID+"\" value=\""+strId+"\">"+strName+"-"+strCmpID+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in CommAppliantListtag. "+e);
		}
		return EVAL_PAGE;
	}
	private String correctDoubleQuotesHtml(String str)
	{
		StringBuffer sbf=new StringBuffer(str);
		for(int i=0;i<sbf.length();i++)
		{
			if(sbf.charAt(i)=='"')
			{
				sbf.replace(i,i+1,"&quot;");
			}
		}
		return sbf.toString();
	}


}
