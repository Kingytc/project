package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class BusinessRule_RatingTag extends TagSupport 
{

	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(BusinessRule_RatingTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	
	
	
	@SuppressWarnings("null")
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		String strId = "", strName = "";
		try
		{
			out=pageContext.getOut();
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getBusinessRuleid(hsh);
			arrRow = (ArrayList)hshValues.get("arrRowId");		
			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				strId = Helper.correctNull((String)arrCol.get(0));
				strName = Helper.correctNull((String)arrCol.get(1));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
				
			}
				log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}


}
