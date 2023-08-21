package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
public class QisMasterTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(QisMasterTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String val="",tabtitle="",cmano="",pagetitle="",button="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			val=request.getParameter("val");
			button=Helper.correctNull((String)request.getParameter("button"));
			tabtitle=Helper.correctNull((String)request.getParameter("tabtitle"));
			pagetitle=Helper.correctNull((String)request.getParameter("pagetitle"));
			cmano=Helper.correctNull((String)request.getParameter("cmano"));
			hshquery.put("val",val);
			hshquery.put("tabtitle",tabtitle);
			hshquery.put("pagetitle",pagetitle);
			hshquery.put("button",button);


			hshquery.put("cmano",cmano);
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("qismaster",hshquery,"getDataHelp");
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