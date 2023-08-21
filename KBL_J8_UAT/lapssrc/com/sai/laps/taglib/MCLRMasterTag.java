package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.*;

import com.sai.laps.tagdatahelper.TagDataHelper5;

public class MCLRMasterTag extends TagSupport
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
			
			String strVal[]=null;String strTemp="";
			strVal=value.split("-");
			if(strVal.length>1)
				strTemp=strVal[0];
			hshPar.put("strValue",strTemp);
			ServletRequest request = null;
			request = pageContext.getRequest();
			
			String strAppstatus =  Helper.correctNull((String)request.getParameter("strappstatus"));
			hshPar.put("appstatus",strAppstatus);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			HashMap hshRes=(HashMap)tagDataHelper5.getMCLRData(hshPar);

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strId="",strValue="";

			arrRow = (ArrayList)hshRes.get("arrRow");

			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
					strId=Helper.correctNull((String)arrCol.get(0))+"-"+Helper.correctNull((String)arrCol.get(1));
					strValue=Helper.correctNull((String)arrCol.get(2));
					out.print("<option value="+strId);
					out.print(">"+strValue+"</option>");
					
				}	
			}
			
		}
		catch(Exception ioe)
		{
			log.error("error occured"+ioe.toString());

		}
	return EVAL_PAGE;
	}
}