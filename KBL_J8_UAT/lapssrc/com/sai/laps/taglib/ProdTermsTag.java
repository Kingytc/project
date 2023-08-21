package com.sai.laps.taglib;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper5;

public class ProdTermsTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ProdTermsTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();	
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getTermData(new HashMap());
			//hshValues=(HashMap)EJBInvoker.executeStateLess("apptermscond",new HashMap(),
				                                //     "getTermData");
			ArrayList arrTermId=(ArrayList)hshValues.get("arrTermsId");
			ArrayList arrTerms=(ArrayList)hshValues.get("arrTerms");
			
			for(int i=0;i<arrTermId.size();i++)
			{	
				
				out.print("<option value="+(String)arrTermId.get(i)+">");
				out.print((String)arrTermId.get(i)+" - " + (String)arrTerms.get(i) + "</option>");
			
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
