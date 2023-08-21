package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;

public class ComDynamicFormulaTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComDynamicFormulaTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String cmano="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			cmano = Helper.correctNull(request.getParameter("cmano"));
			hshquery.put("cmano",cmano);
			
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			HashMap hshRes=(HashMap)tagDataHelper2.getDynamicFormula(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("ratemaster",hshquery,"getDynamicFormula");
		
		
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
	

		arr = (ArrayList)hshRes.get("arr");
		arr1 = (ArrayList)hshRes.get("arr1");
		
		
		
		
			
			for(int i=0;i<arr.size();i++)
			{
				out.print("<option value="+arr.get(i));
				out.print(">"+arr1.get(i)+"</option>");
				
				
			}	
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}