package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.EJBInvoker;

public class SelectTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap hshPar = new HashMap();  
	JspWriter out = null;

	public void setValue(HashMap hsh)
	{
		this.hshPar = hsh;
		System.out.println("value=="+hshPar);
		out = pageContext.getOut();
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
				out.print("<option value="+FwHelper.correctNull((String)vecCodes.get(i)));
				out.print(">"+FwHelper.correctNull((String)vecValues.get(i))+"</option>");
				
			}		
			
		}
		catch(Exception ioe)
		{
				throw new JspException(ioe.toString());
		}
	return EVAL_PAGE;
	}
}