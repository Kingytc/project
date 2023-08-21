package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.EJBInvoker;

public class accountheldTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(accountheldTag.class);
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		HashMap hshquery = new HashMap();
		try
		{
			out=pageContext.getOut();
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("staticdata",hshquery,"getaccountheld1");
			
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				out.println("<option title=\""+arrCol.get(1)+"\" value=\""+arrCol.get(0)+"\">"+arrCol.get(1)+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}