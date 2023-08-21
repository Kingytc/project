package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class FinCoAppGuarantorTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(FinCoAppGuarantorTag.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request=null;
		String appno="";
		String apptype="";
		HashMap hshquery = new HashMap();
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			appno = Helper.correctNull(request.getParameter("appno"));
			//apptype = Helper.correctNull(request.getParameter("applnt"));
			apptype="A','C','G','O";
			hshquery.put("appno",appno);
			hshquery.put("applnt",apptype);
			HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("perapplicant",hshquery,"getCoAppGuarantorType");
			//log.info("--vals from bean-------hshRes-----------"+hshRes);
			//HashMap hshRes=new HashMap();
			//TagDataHelper2 taglib=new TagDataHelper2();
			//hshRes=taglib.getCoAppGuarantorType(hshquery);
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			String strType="";
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				String strValue = (String)arrCol.get(2);
				if(strValue.equalsIgnoreCase("A"))
				{
					strType="App";
				}
				else if(strValue.equalsIgnoreCase("C"))
				{
					strType="JointApp";
				}
				else if(strValue.equalsIgnoreCase("G"))
				{
					strType="Gua";
				}
				else if(strValue.equalsIgnoreCase("O"))
				{
					strType="CoOb";
				}

				out.print("<option value="+strValue+arrCol.get(0));
				out.print(">"+strType + " - " +arrCol.get(1)+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}