package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

//import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.EJBInvoker;

public class RepTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String beanid = null;
	public String methodname = null;
	public String param = null;
	JspWriter out = null;


	public void setBeanid(String beanid)
	{
		this.beanid = beanid;
	
	}
	public void setMethodname(String methodname)
	{
		this.methodname = methodname;
	
	}

	public void setParam(String param)
	{
		this.param = param;
	
	}

	public int doEndTag() throws JspException
	{  
		try
		{	
			out = pageContext.getOut();
			HttpSession session =  pageContext.getSession();
			String org_Level = (String)session.getAttribute("strOrgLevel");
			
			HashMap hshValues = new HashMap();

			hshValues.put("param",param);
			hshValues.put("hidMethod",methodname);
			hshValues.put("org_Level",org_Level);
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess(
								beanid,hshValues,"getData");		
			ArrayList vecCodes= new ArrayList();
			ArrayList vecValues = new ArrayList();

			vecCodes = (ArrayList)hshRes.get("vecCodes");
			vecValues = (ArrayList)hshRes.get("vecValues");
			
			for(int i=0;i<vecCodes.size();i++)
			{
				out.print("<option value=\""+vecCodes.get(i));
				out.print("\">"+vecValues.get(i)+"</option>");
				
			}		
			
		}
		catch(Exception ioe)
		{
				throw new JspException(ioe.toString());
		}
	return EVAL_PAGE;
	}
}