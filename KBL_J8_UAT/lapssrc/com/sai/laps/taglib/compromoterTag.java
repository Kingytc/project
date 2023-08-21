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
import com.sai.laps.tagdatahelper.TagDataHelper3;

public class compromoterTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(compromoterTag.class);

	public int doEndTag() throws JspException
	{  
		
	JspWriter out = null;
	ServletRequest request=null;
	String appno="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			appno = Helper.correctNull(request.getParameter("appno"));
			hshquery.put("appno",appno);
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			HashMap hshRes=(HashMap)tagDataHelper3.getProData(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("compro",hshquery,"getProData");
		
		
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		ArrayList arr4 = new ArrayList();
		ArrayList arr5 = new ArrayList();
	
		arr = (ArrayList)hshRes.get("arr");
		arr1 = (ArrayList)hshRes.get("arr1");
		arr3 = (ArrayList)hshRes.get("arr3");
//		arr4 = (ArrayList)hshRes.get("arr4");
//		arr5 = (ArrayList)hshRes.get("arr5");
		
			
			for(int i=0;i<arr.size();i++)
			{
				out.print("<option value='"+arr1.get(i));
				out.print("'>"+arr3.get(i)+"</option>");
				
				
			}	
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}