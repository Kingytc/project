package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper6;

public class WrkflowUsersTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public int doEndTag() throws JspException
	{  	
		HashMap hshPar = new HashMap();
		JspWriter out = null;	
		try
		{	out = pageContext.getOut();
		    HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
			hshPar.put("strOrgCode",request.getParameter("org_code"));
			hshPar.put("usr_class",request.getParameter("usr_class"));
			hshPar.put("usr_func",request.getParameter("usr_func"));
			hshPar.put("usr_dept",request.getParameter("usr_dept"));
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			HashMap hshRes=(HashMap)tagDataHelper6.getWorkUsers(hshPar);			
			ArrayList arrUsers=(ArrayList)hshRes.get("arrUserss");
			
			for(int i=0;i<arrUsers.size();i++)
			{				
				ArrayList arrUserss=new ArrayList();
				arrUserss=(ArrayList)arrUsers.get(i);
				String strUserId=(String)arrUserss.get(0);
				String strUserName=(String)arrUserss.get(1);
				String strUserClass=(String)arrUserss.get(4);
				String strUserDesig=Helper.correctNull((String)arrUserss.get(3)).toUpperCase();	
				
				if(!Helper.correctNull((String)arrUserss.get(5)).equalsIgnoreCase(""))
				{
					strUserDesig=strUserDesig+" - ( "+Helper.correctNull((String)arrUserss.get(5))+" User )";
				}
				out.print("<option value=\""+strUserId+"~"+strUserClass);
				out.print("\">"+strUserName+" - "+strUserDesig+"</option>");
			}
	   }
	   catch(Exception ioe)
	   {
		   throw new JspException(ioe.getMessage());
	   }
	   return EVAL_PAGE;
	}
}