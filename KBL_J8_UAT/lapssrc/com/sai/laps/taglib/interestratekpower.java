package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class interestratekpower extends TagSupport {
	private static final long serialVersionUID = 1L;

	public int doEndTag() throws JspException
	{
            JspWriter out = null;
			ServletRequest request=null;
			HashMap hshquery = new HashMap();
				try
				{
					out=pageContext.getOut();
					request=pageContext.getRequest();
				
					TagDataHelper4 tagDataHelper4=new TagDataHelper4();
					HashMap hshRes=(HashMap)tagDataHelper4.getInterestData(hshquery);
					ArrayList arrVal  = new ArrayList();
					ArrayList arrValdesc  = new ArrayList();
					arrVal = (ArrayList)hshRes.get("arrVal");
					arrValdesc = (ArrayList)hshRes.get("arrValdesc");
					for(int i=0;i<arrVal.size();i++)
					{	
						out.println("<option value='"+arrVal.get(i)+"'>"+arrValdesc.get(i)+"</option>");
						
					}
					
				}
				catch (Exception e)
				{
					SAILogger.log("error occured"+e.toString());
				}
			return EVAL_PAGE;
		}
	}
