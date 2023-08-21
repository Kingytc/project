package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperMST;

public class MSTSecuritylistTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JspWriter out =null;
	static Logger log=Logger.getLogger(MSTSecuritylistTag.class);
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ServletRequest request = null;
		HashMap hshRequestValues = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		String appno="";
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			appno =Helper.correctNull(request.getParameter("appno"));
			hshRequestValues.put("appno",appno);
			TagDataHelperMST tagMST=new TagDataHelperMST();
			hshValues=tagMST.getSecurityName(hshRequestValues);
			arrRow = (ArrayList)hshValues.get("arrRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strId = Helper.correctNull((String)arrCol.get(0));
				String strSecurity = Helper.correctNull((String)arrCol.get(1));
				out.println("<option value=\""+strId+"\">"+strSecurity+"</option>");
			}
				
		}
		catch(Exception e)
		{
			log.error("exception in MSTSecuritylist :: "+e);
		}
		return EVAL_PAGE;
	}
}