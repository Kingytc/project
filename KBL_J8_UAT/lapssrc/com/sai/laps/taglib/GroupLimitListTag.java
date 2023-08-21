package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper4;

public class GroupLimitListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(GroupLimitListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		ArrayList arrValues=null;
		Iterator enum1=null;
		JspWriter out=null;

		try
		{	out=pageContext.getOut();
			TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			hshValues=(HashMap)tagDataHelper4.getGroupLimitListData(new HashMap());
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setgrouplimits",new HashMap(),"getGroupLimitListData");
			enum1=(hshValues.keySet()).iterator();
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setgrouplimits",new HashMap(),"getGroupLimitListData");
			//enum1=(hshValues.keySet()).iterator();
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				arrValues=(ArrayList)hshValues.get(strId);
				String strName=(String)arrValues.get(0);
				strName=correctDoubleQuotesHtml(strName);
				out.println("<option value="+strId+">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in GroupLimitListTag.. "+e);
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
				sbf.replace(i,i+1,"&quote");
			}
		}
		return sbf.toString();
	}


}
