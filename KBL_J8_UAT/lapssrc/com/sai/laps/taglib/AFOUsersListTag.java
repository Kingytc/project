package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;

public class AFOUsersListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(OrgListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		String scode="";
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();			
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
	        hshValues =(HashMap)tagDataHelper2.getAFOUsersList(hsh);
			ArrayList arrId = new ArrayList();
			ArrayList arrName = new ArrayList();
			
			arrId = (ArrayList)hshValues.get("arr");
			arrName = (ArrayList)hshValues.get("arr1");
			
			int intSize = 0;
			if(arrId!=null && arrName!=null)
			{
				intSize = arrId.size();
			}
			for(int i=0;i<intSize ;i++)
			{
				String strId = Helper.correctNull((String)arrId.get(i));
				
				String strName = strId+" - "+Helper.correctNull((String)arrName.get(i));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in orglisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
