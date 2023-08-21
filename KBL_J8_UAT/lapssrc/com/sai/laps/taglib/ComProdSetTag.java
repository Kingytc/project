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
import com.sai.laps.tagdatahelper.TagDataHelper2;
public class ComProdSetTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComProdSetTag.class);
	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	HashMap hshquery = new HashMap();
	ServletRequest request = null;
	request = pageContext.getRequest();
	try
		{
			out=pageContext.getOut();
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			hshquery.put("prdtype",Helper.correctNull(request.getParameter("prdtype")));
			HashMap hshRes=(HashMap)tagDataHelper2.getLimitCode(hshquery);	
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("setproducts",hshquery,"getLimitCode");
			ArrayList arrVal  = new ArrayList();
			ArrayList arrValdesc  = new ArrayList();
			arrVal = (ArrayList)hshRes.get("arrVal");
			arrValdesc = (ArrayList)hshRes.get("arrValdesc");
			for(int i=0;i<arrVal.size();i++)
			{
				out.print("<option value='"+arrVal.get(i));
				out.print("'>"+arrValdesc.get(i)+"</option>");
				
			}		
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}