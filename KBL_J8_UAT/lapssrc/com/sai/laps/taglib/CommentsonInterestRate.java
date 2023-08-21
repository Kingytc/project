package com.sai.laps.taglib;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class CommentsonInterestRate extends TagSupport
{
	String appno,page;
	JspWriter out = null;
	ServletRequest request = null;


	static Logger log=Logger.getLogger(CommentsonInterestRate.class);	

	
	public void setAppno(String appno)
	{
		this.appno = appno;
		out = pageContext.getOut();
	}
	public void setPage(String page)
	{
		this.page = page;
		out = pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		HttpSession httpSession=pageContext.getSession();
		request = pageContext.getRequest();
		
		String appnoval =  Helper.correctNull(request.getParameter("comapp_id"));
		String strPage =  Helper.correctNull(request.getParameter("page"));
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		HashMap hshValue=new HashMap();
		
		try
		{
			hshValue.put("appno",appno);
			hshValue.put("strPage",page);
					
			TagDataHelper5 taglib1=new TagDataHelper5();
			hashResult=taglib1.getFacilityforCommentsonInterestRate(hshValue);
			arryRow=(ArrayList)hashResult.get("arryRow");
			if(arryRow!=null && arryRow.size()>0)
			{
				for(int i=0;i<arryRow.size();i++)
				{
					arryCol=(ArrayList)arryRow.get(i);
					String strId = Helper.correctNull((String)arryCol.get(0));
					String strDesc = Helper.correctNull((String)arryCol.get(1));
					out.println("<option  title=\""+strDesc+"\" value=\""+strId+"\">"+strId+"-"+strDesc+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			throw new JspException("Error in CommentsonInterestRate Tag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}