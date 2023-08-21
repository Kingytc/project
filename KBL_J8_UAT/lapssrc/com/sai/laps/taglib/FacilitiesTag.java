package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class FacilitiesTag extends TagSupport
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(FacilitiesTag.class);
	private static final long serialVersionUID = 1L;
	String moduletype;
	JspWriter out =null;
	
	public void setModuletype(String moduletype)
	{
		this.moduletype=moduletype;
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
			hsh.put("moduletype",moduletype);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getFacilitiesData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strDesc =Helper.correctNull((String)vecCol.get(0))+"-"+Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(3));
				out.println("<option title=\""+strDesc+"\" value=\""+strId+"\">"+strDesc+"</option>");
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





