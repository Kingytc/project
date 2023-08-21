package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.tagdatahelper.TagDataHelper5;

public class  DivisionsListIdTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String appid;
	JspWriter out = null;
	ServletRequest request = null;
	
	public void setAppid(String appid)
	{
		this.appid = appid;
		out = pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		request = pageContext.getRequest();
		
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		HashMap hshValue=new HashMap();
		
		try
		{
			hshValue.put("appid",appid);
					
			TagDataHelper5 taglib1=new TagDataHelper5();
			hashResult=taglib1.getDivListId(hshValue);
			arryRow=(ArrayList)hashResult.get("arryRow");
			if(arryRow!=null && arryRow.size()>0)
			{
				for(int i=0;i<arryRow.size();i++)
				{
					arryCol=(ArrayList)arryRow.get(i);
	
					out.print("<option value='"+(String)arryCol.get(0)+"'>");	
					out.print((String)arryCol.get(1));
					out.print("</option>");
				}
			}
			
		}
		catch(Exception e)
		{
			throw new JspException("Error in DivisionsListIdTag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}
