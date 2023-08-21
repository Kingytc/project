package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper3;

public class defaulterTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(defaulterTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			HashMap hshRes=(HashMap)tagDataHelper3.getDefData(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("cad",hshquery,"getDefData");
		
		
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
	
	

		arr = (ArrayList)hshRes.get("arr");
		arr1 = (ArrayList)hshRes.get("arr1");
	
		
		
		
			
			for(int i=0;i<arr.size();i++)
			{
				out.print("<option value="+arr1.get(i));
				out.print(">"+arr.get(i)+"</option>");
				
				
			}	
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}