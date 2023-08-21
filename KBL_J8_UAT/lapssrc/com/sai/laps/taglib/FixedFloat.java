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
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class FixedFloat extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(FixedFloat.class);
	
	String apptype;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{  

		JspWriter out = null;
		ServletRequest request=null;
		String strDocType="",str="";
		HashMap hshquery = new HashMap();
			try
			{
				out=pageContext.getOut();
				request=pageContext.getRequest();
				strDocType=Helper.correctNull(request.getParameter("wrk_flowtype1"));
				str=Helper.correctNull(request.getParameter("prdCode"));
				
				if (strDocType.equals(""))
				{
					strDocType="fixed";
				}
				hshquery.put("val",strDocType);
				hshquery.put("code",str);
				hshquery.put("apptype",apptype);
				TagDataHelper4 tagDataHelper4=new TagDataHelper4();
				HashMap hshRes=(HashMap)tagDataHelper4.getDataHelp1(hshquery);
				//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("setproducts",hshquery,"getDataHelp");
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
				log.error("error occured"+e.toString());
			}
		return EVAL_PAGE;
	}
}