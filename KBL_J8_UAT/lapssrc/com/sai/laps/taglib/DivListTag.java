package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;

public class DivListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DivListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		HashMap hshPar = null;
		ArrayList arrValues=null;
		Iterator enum1=null;
		JspWriter out=null;
		try
		{
			hshPar = new HashMap();
			out=pageContext.getOut();
			HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			hshPar.put("appno",request.getParameter("appno"));
			hshPar.put("hidfintypes",request.getParameter("hidfintypes"));
			hshValues=(HashMap)EJBInvoker.executeStateLess("comfin",hshPar,
				                                     "getDivList");
			enum1=(Iterator)hshValues.keySet();
			int i;
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				arrValues=(ArrayList)hshValues.get(strId);
				for(i=0;i<arrValues.size();i++)
				{
				String strName=(String)arrValues.get(i);
				out.println("<option value=\""+strName+"\">"+strName+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
