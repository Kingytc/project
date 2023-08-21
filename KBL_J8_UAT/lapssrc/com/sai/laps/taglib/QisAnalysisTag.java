package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;
public class QisAnalysisTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static Logger log=Logger.getLogger(QisAnalysisTag.class);
	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String val="",cmano="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			val=request.getParameter("val");
		
			cmano=Helper.correctNull((String)request.getParameter("cmano"));
			hshquery.put("val",val);
			


			hshquery.put("cmano",cmano);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			HashMap hshRes=(HashMap)tagDataHelper5.getDataHelp2(hshquery);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("qisanalysismaster",hshquery,"getDataHelp");
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