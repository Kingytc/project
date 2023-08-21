package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
 
import com.sai.laps.tagdatahelper.TagDataHelper7;


public class GetMonAccountNumberTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(GetMonAccountNumberTag.class);
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList vecRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		String strAccno="";	
	
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			String cbsid=Helper.correctNull((String)request.getParameter("hidcbsid"));
			hsh.put("cbsid",cbsid);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getMonAccno(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				strAccno = Helper.correctNull((String)vecRow.get(i));
				out.println("<option value=\""+strAccno+"\">"+strAccno+"</option>");
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in GetMonitorAccno.. "+e);
		}
		return EVAL_PAGE;
	}
}


