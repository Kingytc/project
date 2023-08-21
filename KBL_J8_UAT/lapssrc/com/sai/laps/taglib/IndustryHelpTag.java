package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper4;

public class IndustryHelpTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(IndustryHelpTag.class);

	public int doEndTag() throws JspException
	{  	
		HashMap hshPar = new HashMap();
		JspWriter out = null;	
		try
		{	out = pageContext.getOut();
		TagDataHelper4 tagDataHelper4=new TagDataHelper4();
		HashMap hshRes=(HashMap)tagDataHelper4.showIndustry(hshPar);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("exposure",hshPar,"showIndustry");			
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol = null;
			arrRow=(ArrayList)hshRes.get("arryRow");
			if(arrRow!=null)
			{	for(int i=0;i<arrRow.size();i++)
				{	
					arrCol = (ArrayList)arrRow.get(i);
					if(arrCol!=null)
					{
						out.print("<option value=\""+(String)arrCol.get(0));
						out.print("\">"+(String)arrCol.get(1)+"</option>");
					}
				}
			}
	}
	catch(Exception ioe)
	{
		log.error("error occured"+ioe.toString());
	}
	return EVAL_PAGE;
	}
}