package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class moninsurance extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(moninsurance.class);
	String straccno;
	String strcbsid;
	JspWriter out =null;
	
	public void setAccno(String accno)
	{
		this.straccno=accno;
		out=pageContext.getOut();
	}
	public void setCbsid(String cbsid)
	{
		this.strcbsid=cbsid;
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
			hsh.put("accno",straccno);
			hsh.put("cbsid",strcbsid);
			
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getMonInsurance(hsh);
			arrRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strId = Helper.correctNull((String)arrCol.get(0));
				String strPolicy = Helper.correctNull((String)arrCol.get(1));
				String strAmt = Helper.correctNull((String)arrCol.get(2));
				out.println("<option value=\""+strId+"\">"+strPolicy+"</option>");
				//out.println("<input type=\"hidden\" size=\"3\" name=\"hidinsuamt\" value=\""+strAmt+"\">");
			}
				
		}
		catch(Exception e)
		{
			log.error("exception in moninsuranceTag :: "+e);
		}
		return EVAL_PAGE;
	}
}