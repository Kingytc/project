package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class customerfacilityTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	static Logger log=Logger.getLogger(customerfacilityTag.class);
		
	public void setApptype(String apptype) {
		this.apptype = apptype;
		out=pageContext.getOut();
		
	}
		
	public int doEndTag() throws JspException
	{
		ServletRequest request = null;
		request = pageContext.getRequest(); 
		
		String strAppno=Helper.correctNull((String) request.getParameter("hidDemoId"));
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrRow = new ArrayList();	
		ArrayList arrCol =  new ArrayList();
		HashMap hsh =  new HashMap();
		try
		{
			out=pageContext.getOut();
			hsh.put("appno",strAppno);
			hsh.put("strapptype",apptype);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getCustomerFacility(hsh);
			arrRow = (ArrayList)hshValues.get("arrRow");			
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strId = Helper.correctNull((String)arrCol.get(0));
				String strName = Helper.correctNull((String)arrCol.get(1));
				String strcredtype = Helper.correctNull((String)arrCol.get(2));
				String strfundtype = Helper.correctNull((String)arrCol.get(3));
				String strfacsno = Helper.correctNull((String)arrCol.get(4));
				String strFacVal=strName+"~"+strId+"~"+strfacsno+"~"+strcredtype+"~"+strfundtype;
				
				out.println("<option title=\""+strName+"\" value=\""+strFacVal+"\">"+strName+"</option>");
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in customerfacilityTag.. "+e);
		}
		return EVAL_PAGE;
	}
}




