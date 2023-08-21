package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class BankNameTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(BankNameTag.class);

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
			
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=(HashMap)tagDataHelper1.updateData(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("combanking",hshquery,"updateData");
		
		
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		
	

		arr = (ArrayList)hshRes.get("arr");
		arr1 = (ArrayList)hshRes.get("arr1");
		
		
		
		
			
			for(int i=0;i<arr.size();i++)
			{
				out.println("<option title=\""+arr1.get(i)+"\" value=\""+arr.get(i)+"\">"+arr1.get(i)+"</option>");
				
			}	
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}