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

public class tertiarypromoterTag extends TagSupport
{
	/**
	 * 
	 */
	String strApptype="";
	static Logger log=Logger.getLogger(tertiarypromoterTag.class);
	private static final long serialVersionUID = 1L;
	public void setApptype(String strapptype)
	{
		strApptype=strapptype;
	}
	
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
			hshquery.put("strApptype",strApptype);
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			HashMap hshRes=(HashMap)tagDataHelper3.gettertiaryProData(hshquery);
	
		
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