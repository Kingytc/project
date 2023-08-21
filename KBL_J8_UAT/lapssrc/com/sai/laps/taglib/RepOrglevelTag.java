package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.reporthelper.GetOrgDetails;


public class RepOrglevelTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7527847176867914398L;
	/**
	 * 
	 */

	//public String beanid = null;
	//public String methodname = null;
	//public String param = null;
	JspWriter out = null;


	/*public void setBeanid(String beanid)
	{
		this.beanid = beanid;
	
	}*/
	/*public void setMethodname(String methodname)
	{
		this.methodname = methodname;
	
	}*/

	/*public void setParam(String param)
	{
		this.param = param;
	
	}*/

	public int doEndTag() throws JspException
	{  
		try
		{	
			out = pageContext.getOut();
			HttpSession session =  pageContext.getSession();
			String org_Level = (String)session.getAttribute("strOrgLevel");
			
			HashMap hshValues = new HashMap();

			//hshValues.put("param",param);
			//hshValues.put("hidMethod",methodname);
			hshValues.put("org_Level",org_Level);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess(
			//					beanid,hshValues,"getData");
			GetOrgDetails orgDetails=new GetOrgDetails();
			HashMap hshRes=(HashMap)orgDetails.getLevels(hshValues);
			ArrayList arrCodes= new ArrayList();
			ArrayList arrValues = new ArrayList();

			arrCodes = (ArrayList)hshRes.get("arrCodes");
			arrValues = (ArrayList)hshRes.get("arrValues");
			
			for(int i=0;arrCodes!=null && i<arrCodes.size();i++)
			{
				out.print("<option value=\""+arrCodes.get(i));
				out.print("\">"+arrValues.get(i)+"</option>");
				
			}		
			
		}
		catch(Exception ioe)
		{
				throw new JspException("Error in RepOrglevelTag :: "+ioe.toString());
		}
	return EVAL_PAGE;
	}
}