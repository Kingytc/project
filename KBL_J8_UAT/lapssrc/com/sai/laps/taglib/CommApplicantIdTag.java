package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper2;

public class CommApplicantIdTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(CommApplicantIdTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrcomid =null;
		HashMap hshRequestValues=new HashMap();
		try
		{
			out=pageContext.getOut();
			
			hshRequestValues.put("comapp_id","%");
			hshRequestValues.put("comapp_companyname","%");
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			hshValues=(HashMap)tagDataHelper2.getApplicantList(hshRequestValues);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("commappmaster",hshRequestValues,
				                                    // "getApplicantList");
			arrcomid=(ArrayList)hshValues.get("arrcomid");

			for(int i=0;i<arrcomid.size();i++)
			{
				String strCmpID=(String)arrcomid.get(i);
				out.println("varcompId["+i+"]=\""+strCmpID+"\";");
			}
		}
		catch(Exception e)
		{
			log.error("exception in CommAppliantListtag. "+e);
		}
		return EVAL_PAGE;
	}
	


}
