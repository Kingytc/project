package com.sai.laps.taglib;


import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class PromoterTag extends TagSupport 
{	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(PromoterTag.class);
HashMap hshRequestValues = null;
	String strAppno="";
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		int hshsize=0;
		String strpromotername="";
		JspWriter out=null;
		try
		{	
			log.info("inside try Taglib");
			out=pageContext.getOut();	
			ServletRequest request = pageContext.getRequest();
			strAppno = Helper.correctNull(request.getParameter("appno"));

			hshRequestValues = new HashMap();
			hshRequestValues.put("hidappno",strAppno);
			hshValues=(HashMap)EJBInvoker.executeStateLess("credithistory",hshRequestValues,"getData");
			hshsize=hshValues.size();
			out.print("<option selected value ='0'>-Select-</option>");
			for(int i=1;i<=hshsize;i++)
			{	String strsize=Integer.toString(i);
				strpromotername  =(String) hshValues.get(strsize);
				out.print("<option value="+i);
				out.print(">"+strpromotername+"</option>");
				
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
