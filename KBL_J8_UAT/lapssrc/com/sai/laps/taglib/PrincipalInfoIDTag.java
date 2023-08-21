package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class PrincipalInfoIDTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(PrincipalInfoIDTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		String appno="";
		try
		{
			out=pageContext.getOut();	
			ServletRequest request = pageContext.getRequest();
			appno = Helper.correctNull(request.getParameter("appno"));
			hshValues = new HashMap();
			hshValues.put("appno",appno);

			hshValues=(HashMap)EJBInvoker.executeStateLess("comprincipalsinfo",hshValues,
				                                     "getPrincipalInfoID");

			ArrayList vecVal = new ArrayList();
			ArrayList vecRow = new ArrayList();
			vecVal = (ArrayList)hshValues.get("vecVal");

			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");

			for(int i=0;i<vecVal.size();i++)
			{	vecRow = (ArrayList)vecVal.get(i);
				out.print("<option value="+vecRow.get(0));
				out.print(">"+vecRow.get(0)+"</option>");
				
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
