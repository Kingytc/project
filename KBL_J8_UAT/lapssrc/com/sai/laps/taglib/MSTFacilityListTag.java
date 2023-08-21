package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelperMST;

public class MSTFacilityListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MSTFacilityListTag.class);
	public int doEndTag() throws JspException
	{  
		HashMap hshValues = null;		
		JspWriter out = null;
		ServletRequest request = null;
		HashMap hshRequestValues = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String appno="";
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
            appno = request.getParameter("appno");
			hshRequestValues.put("appno",appno);
			TagDataHelperMST tagDataHelperMST=new TagDataHelperMST();
			hshValues=(HashMap)tagDataHelperMST.getFacilityName(hshRequestValues);
			
			arrRow = (ArrayList)hshValues.get("arrRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String FacilityID = Helper.correctNull((String)arrCol.get(0));
				String FacilityName = Helper.correctNull((String)arrCol.get(1))+" - "+Helper.correctNull((String)arrCol.get(2));
				out.println("<option value=\""+FacilityID+"\">"+FacilityName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in MSTFacilityListTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
