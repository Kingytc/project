package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper4;

public class choiceTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JspWriter out = null;

	static Logger log=Logger.getLogger(choiceTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshPar = new HashMap();
		try
		{	
			out = pageContext.getOut();
			TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			HashMap hshRes=(HashMap)tagDataHelper4.getDataHelp(hshPar);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("setglpoptions",hshPar,"getDataHelp");			

			ArrayList vecCodes = new ArrayList();
			ArrayList vecValues = new ArrayList();

			vecCodes = (ArrayList)hshRes.get("vecCodes");
			vecValues = (ArrayList)hshRes.get("vecValues");

			out.print("<option selected value =''>-Select-</option>");
			for(int i=0;i<vecCodes.size();i++)
			{
				out.println("<option title=\""+vecCodes.get(i)+"\" value=\""+vecCodes.get(i)+"^"+vecValues.get(i)+"\">"+vecCodes.get(i)+"</option>");
			}		
			
		}
		catch(Exception ioe)
		{
			log.error("error occured"+ioe.toString());

		}
	return EVAL_PAGE;
	}
}