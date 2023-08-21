package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class sancrefnoTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(sancrefnoTag.class);

	public String strAppno="";
	public String strSaral="";
	
	public void setAppno(String appno)
	{
		strAppno=Helper.correctNull(appno);
	}
	
	public void setSaral(String saral)
	{
		strSaral=Helper.correctNull(saral);
	}
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		//String appno="";
		try
		{
			out=pageContext.getOut();
			//HttpSession session = pageContext.getSession();
			HashMap hshRes=new HashMap();
			// appno=Helper.correctNull((String)session.getAttribute("strappno"));
			hshRes.put("appno",strAppno);
			hshRes.put("Saral",strSaral);
			 hshRes = (HashMap)EJBInvoker.executeStateLess("staticdata",hshRes,"getSancrefno");
			
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				out.print("<option value="+arrCol.get(0));
				out.print(">"+arrCol.get(1)+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}