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

public class TermFinanceFacTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TermFinanceFacTag.class);
	String pagename = "";
	JspWriter out = null;
	
	public void setPagename(String pagename)
	{
		if(pagename == null)
		{
			pagename = Helper.correctNull(pagename);
		}
		this.pagename = pagename.trim();
		out = pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		Iterator enum1=null;
		JspWriter out=null;
		
		String strAppno="";
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			strAppno=Helper.correctNull((String)request.getParameter("appno"));
			hsh.put("appno",strAppno);
			hsh.put("pagename",pagename);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getTermFinanceFacNew(hsh);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("comrepayschedule",hsh,"getTermFinanceFac");
		    enum1=(hshValues.keySet()).iterator();
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				String strName=strId+" - "+Helper.correctNull((String)hshValues.get(strId));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}
			//namrata
			
		}
		catch(Exception e)
		{
			log.info("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
