package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
public class QisTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(QisTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String strDocType="",appno="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			strDocType=request.getParameter("val");
			appno=request.getParameter("appno");
			hshquery.put("val",strDocType);
			hshquery.put("appno",appno);
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("QisBean",hshquery,"getDataTag");
			ArrayList arrVal  = new ArrayList();
			ArrayList arrValdesc  = new ArrayList();
			arrVal = (ArrayList)hshRes.get("arrVal");
			arrValdesc = (ArrayList)hshRes.get("arrValdesc");
			for(int i=0;i<arrVal.size();i++)
			{
				out.print("<option value='"+arrVal.get(i));
				out.print("'>"+arrValdesc.get(i)+"</option>");
				
			}		
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}