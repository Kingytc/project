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

public class comFormulaTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(comFormulaTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String val="";
	String strCategory = "";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			val = Helper.correctNull(request.getParameter("cmano"));
			strCategory = Helper.correctNull(request.getParameter("lst_formula"));
			hshquery.put("cmano",val);
			hshquery.put("FormulaCategory",strCategory);
			
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			HashMap hshRes=(HashMap)tagDataHelper2.getFormulaData(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("formula",hshquery,"getFormulaData");
		
		
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		//ArrayList arr2 = new ArrayList();
		//ArrayList arr3 = new ArrayList();
		//ArrayList arr4 = new ArrayList();
		//ArrayList arr5 = new ArrayList();
	

		arr = (ArrayList)hshRes.get("arr");
		arr1 = (ArrayList)hshRes.get("arr1");
		//arr2 = (ArrayList)hshRes.get("arr2");
		//arr3 = (ArrayList)hshRes.get("arr3");
		//arr4 = (ArrayList)hshRes.get("arr4");
		//arr5 = (ArrayList)hshRes.get("arr5");
		
			for(int i=0;i<arr.size();i++)
			{
				out.print("<option value=\""+arr.get(i));
				out.print("\">"+arr1.get(i)+"</option>");
				
				
			}	
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}