package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class BAConsortiumTag extends TagSupport
{
	private static final long serialVersionUID = 1L;
	String strConsType;
	JspWriter out =null;
	static Logger log=Logger.getLogger(BAFacilityTag.class);
		
	public void setContype(String constype)
	{
		this.strConsType=constype;
		out=pageContext.getOut();
	}
		
	public int doEndTag() throws JspException
	{
		ServletRequest request = null;
		request = pageContext.getRequest(); 
		
		String strAppno=Helper.correctNull((String)request.getParameter("appno"));
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		HashMap hsh =  new HashMap();
		
		try
		{
			out	= pageContext.getOut();
			hsh.put("appno",strAppno);
			hsh.put("strConsType",strConsType);
			TagDataHelper7 taglib	= new TagDataHelper7();
			hshValues	= taglib.getBAConsorDet(hsh);
			arrRow 		= (ArrayList)hshValues.get("arrRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol	= (ArrayList)arrRow.get(i);
				out.println("<option value=\""+Helper.correctNull((String)arrCol.get(0))+"\">"+Helper.correctNull((String)arrCol.get(1))+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in BAConsortiumTag.. "+e);
		}
		return EVAL_PAGE;
	}
}




