package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class AFOClusterBranchTag extends TagSupport 
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(WCFacilitiesTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		String strAppno="";
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		ArrayList arr=new ArrayList();
		ArrayList arr1=new ArrayList();
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			hsh.put("apptype",apptype);
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
	        hshValues =(HashMap)tagDataHelper2.getAFOClusterBranchTag(hsh);
	        arr=(ArrayList)hshValues.get("arr");
	        arr1=(ArrayList)hshValues.get("arr1");
			for(int i=0;i<arr.size();i++)
			{
				String strId=Helper.correctNull((String)arr.get(i));
				String strName=Helper.correctNull((String)arr1.get(i));
				out.println("<option value=\""+strId+"\">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
