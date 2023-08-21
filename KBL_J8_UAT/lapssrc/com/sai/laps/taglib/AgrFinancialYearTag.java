package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;


import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class AgrFinancialYearTag extends TagSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AgrFinancialYearTag.class);
	String appno,page;
	JspWriter out =null;
	public void setappno(String appno)
	{
		this.appno=appno;
		out=pageContext.getOut();
	}
	public void setPage(String page)
	{
		this.page=page;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrRow=new ArrayList();
		int intSize=0;
		try
		{
			out=pageContext.getOut();
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getAgriFinancialYear(appno,page);
			arrRow=(ArrayList)hshValues.get("arrRow");
			if(arrRow!=null && arrRow.size()>0)
			{
				intSize = arrRow.size();
				for(int i=0;i<intSize ;i++)
				{
					ArrayList arrCol = (ArrayList) arrRow.get(i);
					String strId = Helper.correctNull((String)arrCol.get(3));
					String strDesc = Helper.correctNull((String)arrCol.get(1))+" - "+Helper.correctNull((String)arrCol.get(2));
					out.println("<option title=\""+strDesc+"\" value=\""+strId+"\">"+strDesc+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			log.error("exception in AgrFinancialYear.. "+e);
		}
		return EVAL_PAGE;
	}
}
