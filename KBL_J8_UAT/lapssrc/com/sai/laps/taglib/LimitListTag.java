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
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class LimitListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(LimitListTag.class);

	public int doEndTag() throws JspException
	{ 
		HashMap hshValues=null;
		JspWriter out=null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		try
		{
			out=pageContext.getOut();		
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRecord=new HashMap();
			hshRecord.put("prdtype",Helper.correctNull(request.getParameter("prdtype")));
			hshValues =(HashMap)tagDataHelper1.getLimitList(hshRecord);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("limitmaster",new HashMap(),
				              //                       "getLimitList");

			ArrayList vecVal = new ArrayList();
			ArrayList vecRow = new ArrayList();
			vecVal = (ArrayList)hshValues.get("vecVal");


			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");					

			for(int i=0;i<vecVal.size();i++)
			{	vecRow = (ArrayList)vecVal.get(i);
				out.print("<option value="+Helper.correctNull((String)vecRow.get(0)));
				out.print(">"+Helper.correctNull((String)vecRow.get(1))+"--"+Helper.correctNull((String)vecRow.get(2))+"</option>");
				
			}		
			
		}
		catch(Exception e)
		{
			log.error("exception in getLimitList.. "+e);
		}
		return EVAL_PAGE;
	}

}
