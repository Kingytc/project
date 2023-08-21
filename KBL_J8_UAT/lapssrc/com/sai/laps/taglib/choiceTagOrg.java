package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper5;

public class choiceTagOrg extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String value;  
	JspWriter out = null;
	static Logger log=Logger.getLogger(choiceTagOrg.class);

	public void setValue(String value)
	{
		this.value = value;
		out = pageContext.getOut();
	}  

	public int doEndTag() throws JspException
	{  
		HashMap hshPar = new HashMap();
		try
		{	
			
			hshPar.put("TagQuery",value);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			HashMap hshRes=(HashMap)tagDataHelper5.getDataHelp(hshPar);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("setorg",hshPar,"getDataHelp");			

			ArrayList vecCodes = new ArrayList();
			ArrayList vecValues = new ArrayList();

			vecCodes = (ArrayList)hshRes.get("vecCodes");
			vecValues = (ArrayList)hshRes.get("vecValues");

			for(int i=0;i<vecCodes.size();i++)
			{
				out.print("<option value="+vecCodes.get(i));
				out.print(">"+vecValues.get(i)+"</option>");
				
			}		
			
		}
		catch(Exception ioe)
		{
			log.error("error occured"+ioe.toString());

		}
	return EVAL_PAGE;
	}
}