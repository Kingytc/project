package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;

public class statemasterTag1 extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(statemasterTag1.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
				
		HashMap hshquery = new HashMap();
		try
		{
			out=pageContext.getOut();
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("staticdata",hshquery,"getState1");
			
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				out.print("<option value="+arrCol.get(0));
				out.print(">"+arrCol.get(1)+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}