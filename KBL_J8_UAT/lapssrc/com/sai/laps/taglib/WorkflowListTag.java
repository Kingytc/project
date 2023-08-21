package com.sai.laps.taglib;

import java.util.Iterator;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper6;

public class WorkflowListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(WorkflowListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues = null;
		Iterator enum1 = null;
		JspWriter out = null;
		ServletRequest request = null;
		HashMap hshRequestValues = new HashMap();
		String strWorkflowType = null;
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
            strWorkflowType = request.getParameter("wrk_flowtype");
			hshRequestValues.put("wrk_flowtype",strWorkflowType);
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			hshValues=(HashMap)tagDataHelper6.getWorkflowList(hshRequestValues);

			//hshValues = (HashMap)EJBInvoker.executeStateLess("setproducts",hshRequestValues,
				              //                       "getWorkflowList");
			enum1 = (hshValues.keySet()).iterator();

			

			while(enum1.hasNext())
			{
				String strWorkflowCode=(String)enum1.next();
				String strDesc=(String)hshValues.get(strWorkflowCode);
				strDesc = correctDoubleQuotesHtml(strDesc);
				out.println("<option value=\""+strWorkflowCode+"\">"+strDesc+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in WorkflowListTag.. "+e);
		}
		return EVAL_PAGE;
	}

	private String correctDoubleQuotesHtml(String str)
	{
		StringBuffer sbf = new StringBuffer(str);
		for(int i=0;i<sbf.length();i++)
		{
			if( sbf.charAt(i) == '"' )
			{
				sbf.replace(i,i+1,"&quot;");
			}
		}
		return sbf.toString();
	}
}
