package com.sai.laps.taglib;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class SolProcessChargeTag extends TagSupport{
	static Logger log=Logger.getLogger(SolProcessChargeTag.class);
	private static final long serialVersionUID = 1L;
	HashMap hshRequestValues = null;
	
	String appvalue;
	
	public void setAppvalue(String appvalue) {
		this.appvalue = appvalue;
	}
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();
			ServletRequest request = pageContext.getRequest();

			hshRequestValues = new HashMap();
			hshRequestValues.put("prdCode",appvalue);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getsolvencyProcessChargesID(hshRequestValues);	
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			vecRow = (ArrayList)hshValues.get("vecRow");

			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");

			for(int i=0;i<vecRow.size();i++)
			{	vecCol = (ArrayList)vecRow.get(i);
				out.print("<option value="+vecCol.get(0));
				out.print(">"+vecCol.get(1)+"----"+vecCol.get(2)+"</option>");
				
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in SolProcessChargeTag.. "+e);
		}
		return EVAL_PAGE;
	}


}
