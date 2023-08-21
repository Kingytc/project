package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

//Created By Venkat Prasad Chowdary for Securities on 26-APR-2013

public class StaticDataSecuritiesTag extends TagSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(StaticDataSecuritiesTag.class);
	String parenttype;
	JspWriter out =null;
	
	public void setParenttype(String parenttype)
	{
		this.parenttype=parenttype;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		try
		{
			out=pageContext.getOut();
			hsh.put("parenttype",parenttype);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getstaticdataSecurities(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strName = Helper.correctNull((String)vecCol.get(1));
				if(parenttype.equalsIgnoreCase("!0"))
					out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"<b>--</b>"+strId+"</option>");
				else
				{
					
					out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
			}
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
