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

public class CoAppGuarantorTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(CoAppGuarantorTag.class);

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
	String appno="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			appno = Helper.correctNull(request.getParameter("appno"));
			//apptype = Helper.correctNull(request.getParameter("applnt"));
			
			hshquery.put("appno",appno);
			hshquery.put("applnt",apptype);
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			HashMap hshRes=(HashMap)tagDataHelper2.getCoAppGuarantorType(hshquery);
		//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("perapplicant",hshquery,"getCoAppGuarantorType");
		
		
		ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
		ArrayList arrCol=new ArrayList();
		
		for(int i=0;i<arrRow.size();i++)
		{
			String strApp="";
			arrCol = (ArrayList)arrRow.get(i);
			if(arrCol.get(2).toString().equalsIgnoreCase("A"))
			{
				strApp="App - ";
			}
			else if(arrCol.get(2).toString().equalsIgnoreCase("C")){
				strApp="Jointapp - ";
			}else if(arrCol.get(2).toString().equalsIgnoreCase("G")){
				strApp="Gua - ";
			}
			else if(arrCol.get(2).toString().equalsIgnoreCase("O")){
			strApp="CoOb - ";
			}
			
			out.println("<option title=\""+strApp+arrCol.get(1)+"\" value=\""+arrCol.get(0)+"\">"+strApp+arrCol.get(1)+"</option>");
		}	
	}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}