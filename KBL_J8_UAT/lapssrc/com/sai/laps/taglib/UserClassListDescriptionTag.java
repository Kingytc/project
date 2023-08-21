package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper6;

public class UserClassListDescriptionTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(UserClassListDescriptionTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshClassValues=null;
		JspWriter out=null;
		ArrayList vecData = new ArrayList();
		ArrayList vecRow  = new ArrayList();
		String strDataValue1="",strDataValue2="";
		try
		{
			out=pageContext.getOut();
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			hshClassValues=(HashMap)tagDataHelper6.getClassStaticData(new HashMap());
			if(hshClassValues!=null)
			{
				vecData=(ArrayList)hshClassValues.get("class_list");
			}
			if(vecData.size()>0)
			{
				for(int i=0;i<vecData.size();i++)
				{
					vecRow=(ArrayList)vecData.get(i);
					strDataValue1=(String)vecRow.get(1);
					strDataValue2=(String)vecRow.get(2);
					if(!strDataValue1.equals(""))
					{
						out.println("<option value=\""+strDataValue1+"\">"+strDataValue2+"</option>");
					}
				}
			}
	
		}
		catch(Exception e)
		{
			log.error("exception in userlisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
