package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper6;

public class ActivitySearchTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ActivitySearchTag.class);
	private static final long serialVersionUID = 1L;

	public int doEndTag() throws JspException
	{ 
		HashMap hshValues=null;
		JspWriter out=null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		String strValue ="",strTenor;
		double dblTenor = 0.00,dblTenortot = 0.00;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		try
		{
			out=pageContext.getOut();		
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			HashMap hshRecord=new HashMap();
			hshRecord.put("appno",Helper.correctNull(request.getParameter("appno")));
			hshValues =(HashMap)tagDataHelper6.getActivitydet(hshRecord);
			if(hshValues!=null)
			{
				arrRow = (ArrayList)hshValues.get("arryRow");
			}
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol = (ArrayList)arrRow.get(i);
					out.print("<option value="+arrCol.get(0)+">"+arrCol.get(1)+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			log.error("exception in getTenorforfinancialcalculation.. "+e);
		}
		return EVAL_PAGE;
	}

}
