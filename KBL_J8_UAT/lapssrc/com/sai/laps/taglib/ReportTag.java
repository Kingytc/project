package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.tagdatahelper.TagDataHelper5;

public class ReportTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String userid = null;
	public String repname = null;
	public String sqlname = null;
	JspWriter out = null;


	public void setValue(String value)
	{
		this.repname = value;
	
	}  

	public int doEndTag() throws JspException
	{  
		try
		{	
			ServletRequest request =null;
			out = pageContext.getOut();
			HashMap hshValues = new HashMap();

			request = pageContext.getRequest();
			userid =(String)request.getParameter("userid");
			hshValues.put("userid",userid);
			hshValues.put("repname",repname);
			hshValues.put("hidMethod","getProfileNames");
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			HashMap hshRes=(HashMap)tagDataHelper5.getData(hshValues);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess(
					//			"repData",hshValues,"getData");		
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