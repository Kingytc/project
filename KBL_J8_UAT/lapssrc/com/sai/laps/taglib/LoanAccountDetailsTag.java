package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class LoanAccountDetailsTag extends TagSupport 
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(WCFacilitiesTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		String strAppno="";
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		Iterator enum1=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			strAppno=Helper.correctNull((String)request.getParameter("appno"));
			hsh.put("appno",strAppno);
			hsh.put("apptype",apptype);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getLoanAccountDetails(hsh);
		    enum1=(hshValues.keySet()).iterator();
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				String strName=strId+" - "+Helper.correctNull((String)hshValues.get(strId));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
