package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class StaticDataQuestionMastTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String apptype;
	String page;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}
	public void setPage(String page) {
		this.page = page;
	}
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		ArrayList arrValues=null;		
		JspWriter out=null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
				
			hsh.put("apptype",apptype);
			request.getAttribute("hidBeanMethod");
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getRetailQuestionMast(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strslno = Helper.correctNull((String)vecCol.get(0));
				String strId = Helper.correctNull((String)vecCol.get(1));
				String strName = Helper.correctNull((String)vecCol.get(2));
				if(Helper.correctNull(page).equalsIgnoreCase("yes")){
					out.println("<option value=\""+strslno+"\" title='"+strName+"'>"+strName+"</option>");
				}else{
					out.print("<option value='"+strId+"'title='"+strName+"'>"+strName+"</option>");
				}
			}
				
		}
		catch(Exception e)
		{
			throw new JspException(e.toString());
		}
		return EVAL_PAGE;
	}

	
}




