package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class RamFacilityListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(RamFacilityListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues = null;		
		JspWriter out = null;
		ServletRequest request = null;
		HashMap hshRequestValues = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		String appno="";
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
            appno = request.getParameter("appno");
			hshRequestValues.put("appno",appno);
			TagDataHelper7 tagDataHelper7=new TagDataHelper7();
			hshValues=(HashMap)tagDataHelper7.getFacilityName(hshRequestValues);
			
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				//String SchemeCode = Helper.correctNull((String)vecCol.get(0));
				String FacilityID = Helper.correctNull((String)vecCol.get(0));
				String FacilityName = Helper.correctNull((String)vecCol.get(1));
				out.println("<option value=\""+FacilityID+"\">"+FacilityName+"</option>");
			}

			
		}
		catch(Exception e)
		{
			log.error("exception in WorkflowListTag.. "+e);
		}
		return EVAL_PAGE;
	}

	
}
