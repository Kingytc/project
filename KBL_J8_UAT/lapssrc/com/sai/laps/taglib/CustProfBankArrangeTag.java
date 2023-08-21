package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class CustProfBankArrangeTag extends TagSupport {
/**
 * 
 */
static Logger log=Logger.getLogger(SchemeSecuritiesTag.class);
private static final long serialVersionUID = 1L;

String pagevalue;
JspWriter out =null;

public void setPagevalue(String pagevalue)
{
	this.pagevalue=pagevalue;
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
		hsh.put("pagevalue",pagevalue);
		TagDataHelper7 taglib=new TagDataHelper7();
		hshValues=taglib.getCustProfBankArrangement(hsh);
		arrRow = (ArrayList)hshValues.get("arrRow");		
		int intSize = 0;
		intSize = arrRow.size();
		for(int i=0;i<intSize ;i++)
		{
			arrCol = (ArrayList) arrRow.get(i);
			out.println("<option title=\""+Helper.correctNull((String)arrCol.get(2))+"\" value=\""+Helper.correctNull((String)arrCol.get(1))+"\">"+Helper.correctNull((String)arrCol.get(2))+"</option>");
		}
		log.info("End of While Loop");
	}
	catch(Exception e)
	{
		log.error("Exception in Cust Prof Getting Banking Arrangements.. "+e);
		}
		return EVAL_PAGE;
	}
}

	
	
	
