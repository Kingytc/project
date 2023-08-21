package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperBST;

public class com_bst_termfinfac extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(com_bst_termfinfac.class);
	String strappno;
	JspWriter out =null;
	
	/*public void setAccno(String accno)
	{
		this.accno=accno;
		out=pageContext.getOut();
	}*/
	
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
			ServletRequest request = pageContext.getRequest();
			strappno=Helper.correctNull(request.getParameter("appno"));
			hsh.put("appno",strappno);
			TagDataHelperBST taglib=new TagDataHelperBST();
			hshValues=taglib.getBSTTermFinanceFac(hsh);
			arrRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				out.println("<option value=\""+Helper.correctNull((String)arrCol.get(0))+"\">"+Helper.correctNull((String)arrCol.get(1))+"</option>");
			}
				log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in com_bst_termfinfac.. "+e);
		}
		return EVAL_PAGE;
	}
}




