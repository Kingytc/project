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

public class FinIndicatorCommentsTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(FinIndicatorCommentsTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues = null;		
		JspWriter out = null;
		ServletRequest request = null;
		HashMap hshRequestValues = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		String appno="";
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
            appno = request.getParameter("appno");
			hshRequestValues.put("appno",appno);
			TagDataHelper5 taglib1=new TagDataHelper5();
			hshValues=(HashMap)taglib1.getFinIndicatorComment(hshRequestValues);
			
			arryRow=(ArrayList)hshValues.get("arryRow");
			if(arryRow!=null && arryRow.size()>0)
			{
				for(int i=0;i<arryRow.size();i++)
				{
					arryCol=(ArrayList)arryRow.get(i);
					String strid = Helper.correctNull((String)arryCol.get(0));
					String strvalue = Helper.correctNull((String)arryCol.get(1));
					out.println("<option value=\""+strid+"\">"+strvalue+"</option>");
				}
			}
			else
			{
				out.println("<option value=\"Gen\">General</option>");
			}
		
		}
		catch(Exception e)
		{
			log.error("exception in FinIndicatorCommentTag.. "+e);
		}
		return EVAL_PAGE;
	}

	
}