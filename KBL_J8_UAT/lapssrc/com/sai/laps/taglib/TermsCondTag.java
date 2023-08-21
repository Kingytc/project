package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper6;

public class TermsCondTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TermsCondTag.class);
	public int doEndTag() throws JspException
	{ 
		HashMap hshValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();		
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			hshValues=(HashMap)tagDataHelper6.getTermData(new HashMap());
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setmodtermscond",new HashMap(),
				                            //         "getTermData");

			ArrayList vecVal = new ArrayList();
			ArrayList vecRow = new ArrayList();
			vecVal = (ArrayList)hshValues.get("vecVal");

			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");

			for(int i=0;i<vecVal.size();i++)
			{	
				vecRow = (ArrayList)vecVal.get(i);
				out.print("<option value="+vecRow.get(0));
				out.print(">"+vecRow.get(1)+"</option>");
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in TermsCondTag.. "+e);
		}
		return EVAL_PAGE;
	}

}
