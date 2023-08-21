package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper5;
public class QisAnalysisRangeTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(QisAnalysisRangeTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			HashMap hshRes=(HashMap)tagDataHelper5.getDataHelp1(hshquery);
			
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("qisrange",hshquery,"getDataHelp");
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