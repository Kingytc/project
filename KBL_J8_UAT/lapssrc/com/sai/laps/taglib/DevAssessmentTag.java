package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;

public class DevAssessmentTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(OrgListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		String scode="";
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
	        hshValues =(HashMap)tagDataHelper2.getDevAssList(hsh);
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strId="",strName="";
			
			arrRow = (ArrayList)hshValues.get("arrRow");
			
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size() ;i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
					
					strId=Helper.correctNull((String)arrCol.get(0));
					strName=Helper.correctNull((String)arrCol.get(1));
					
					out.println("<option value=\""+strId+"\">"+strName+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			log.error("exception in DevAssessmentTag.. "+e);
		}
		return EVAL_PAGE;
	}

}
