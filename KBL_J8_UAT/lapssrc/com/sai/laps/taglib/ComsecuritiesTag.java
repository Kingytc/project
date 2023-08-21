package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class ComsecuritiesTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComsecuritiesTag.class);
	String strappno;
	JspWriter out =null;
	
	public void setAppno(String appno)
	{
		this.strappno=appno;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		try
		{
			out=pageContext.getOut();
			hsh.put("appno",strappno);
			
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getPrimeSecurities(hsh);
			arrRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strId = Helper.correctNull((String)arrCol.get(0));
				String strName = Helper.correctNull((String)arrCol.get(1));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}
				
		}
		catch(Exception e)
		{
			log.error("exception in ComsecuritiesTag :: "+e);
		}
		return EVAL_PAGE;
	}
}