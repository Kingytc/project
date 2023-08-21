package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.tagdatahelper.TagDataHelper6;

public class FinYearTenorTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(FinYearTenorTag.class);

	public int doEndTag() throws JspException
	{ 
		HashMap hshValues=null;
		JspWriter out=null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		String strValue ="",strTenor;
		double dblTenor = 0.00,dblTenortot = 0.00;
		try
		{
			out=pageContext.getOut();		
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			HashMap hshRecord=new HashMap();
			hshRecord.put("appno",Helper.correctNull(request.getParameter("appno")));
			hshValues =(HashMap)tagDataHelper6.getFacilityTenor(hshRecord);
			out.print("<option selected value =''>-Select-</option>");
			strTenor =Helper.correctNull((String)hshValues.get("dbltenor"));
			dblTenor = Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltenor")));
			dblTenortot = dblTenor/12;
			dblTenortot = Math.ceil(dblTenortot);
			for(int j=0;j<dblTenortot;j++)
			{
			strValue = "Year "+(j+1);
			out.print("<option value="+(j+1)+">"+strValue+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in getTenorforfinancialcalculation.. "+e);
		}
		return EVAL_PAGE;
	}

}
