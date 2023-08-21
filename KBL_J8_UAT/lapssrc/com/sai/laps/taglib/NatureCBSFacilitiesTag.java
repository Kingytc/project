package com.sai.laps.taglib;


import java.io.IOException;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.fw.management.log.LogWriter;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class NatureCBSFacilitiesTag extends TagSupport 
{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4624321821067295332L;

	public int doEndTag() throws JspException
	{  
		ArrayList vecCol= new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		JspWriter out = pageContext.getOut();
		
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		
		HashMap hshRes = new HashMap();
		
		String strAppno=Helper.correctNull((String)request.getParameter("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)request.getParameter("npa_appno"));
		}
		
		TagDataHelper7 tagData7 = new TagDataHelper7();
		
		hshRes = tagData7.getFacilityDataDesc(strAppno);
		
		vecRow = (ArrayList)hshRes.get("vecRow");	
		
		int intSize = 0;
		intSize = vecRow.size();
		try 
		{
				for(int i=0;i<intSize ;i++)
				{
					vecCol = (ArrayList) vecRow.get(i);
					//String SchemeCode = Helper.correctNull((String)vecCol.get(0));
					String FacilityID = Helper.correctNull((String)vecCol.get(0));
					String FacilityName = Helper.correctNull((String)vecCol.get(1));
					out.println("<option value=\""+FacilityID+"\">"+FacilityName+"</option>");
				}
		}
		catch(IOException e)
		{
			LogWriter.log(e.getMessage());
		}
			
		
		
		return EVAL_PAGE;
	}
	
}