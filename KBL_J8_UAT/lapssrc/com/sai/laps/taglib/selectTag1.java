package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;

public class selectTag1 extends TagSupport
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(selectTag1.class);
	private static final long serialVersionUID = 1L;
	public HashMap hshPar = new HashMap();  
	JspWriter out = null;

	public void setValue(HashMap hsh)
	{
		this.hshPar = hsh;
		out = pageContext.getOut();
		log.info("value=="+hshPar);
	}  

	public int doEndTag() throws JspException
	{  
		try
		{	
			out = pageContext.getOut();
			String strBeanId = (String)hshPar.get("BeanId");
			String strMethod = (String)hshPar.get("MethodName"); 
			HashMap hshValues = new HashMap();
			hshValues =(HashMap)hshPar.get("BeanParam");
		
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess(strBeanId,hshValues,strMethod);			
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