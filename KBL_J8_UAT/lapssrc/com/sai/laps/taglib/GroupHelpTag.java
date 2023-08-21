package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper4;

public class GroupHelpTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(GroupHelpTag.class);

	public int doEndTag() throws JspException
	{  	
		HashMap hshPar = new HashMap();
		JspWriter out = null;	
		try
		{	out = pageContext.getOut();
		  	TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			HashMap hshRes=(HashMap)tagDataHelper4.showGroup(hshPar);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("exposure",hshPar,"showGroup");
			ArrayList arrVal  = new ArrayList();
			ArrayList arrValdesc  = new ArrayList();
			arrVal = (ArrayList)hshRes.get("arry");
			arrValdesc = (ArrayList)hshRes.get("arry1");
			for(int i=0;i<arrVal.size();i++)
			{
				out.print("<option value='"+arrVal.get(i));
				out.print("'>"+arrValdesc.get(i)+"</option>");
				
			}	
	}
	catch(Exception ioe)
	{
		log.error("error occured"+ioe.toString());
	}
	return EVAL_PAGE;
	}
}