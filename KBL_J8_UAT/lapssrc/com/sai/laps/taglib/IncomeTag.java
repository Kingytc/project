package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class IncomeTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(IncomeTag.class);
	HashMap hshRequestValues = null;
	String strPrdCode="";

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();
			ServletRequest request = pageContext.getRequest();
			strPrdCode = Helper.correctNull(request.getParameter("prdCode"));

			hshRequestValues = new HashMap();
			hshRequestValues.put("prdCode",strPrdCode);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getIncome(hshRequestValues);	
			
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList)hshValues.get("arrRow");
			
			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");
			if(arrRow!=null)
			{	
				for(int i=0;i<arrRow.size();i++)
				{	arrCol = (ArrayList)arrRow.get(i);
					out.print("<option value="+arrCol.get(0));
					out.print(">"+arrCol.get(1)+"----"+arrCol.get(2)+"</option>");
					
				}	
			}
			
		}
		catch(Exception e)
		{
			log.error("exception in IncomeTag.. "+e);
		}
		return EVAL_PAGE;
	}

}
