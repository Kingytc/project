package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class  ProductListHelpTag1 extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out = null;
	public void setApptype(String apptype)
	{
		this.apptype = apptype;
		out = pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		HttpSession httpSession=pageContext.getSession();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		HashMap hshValue=new HashMap();
		String orgScode=(String)httpSession.getAttribute("strOrgShortCode");
		String orgCode=(String)httpSession.getAttribute("strOrgCode");
		String orgLevel=(String)httpSession.getAttribute("strOrgLevel");
		String groupRights=(String)httpSession.getAttribute("strGroupRights");
		try
		{
			hshValue.put("apptype",apptype);
			hshValue.put("orgscode",orgScode);
			hshValue.put("orglevel",orgLevel);
			hshValue.put("orgcode",orgCode);
			hshValue.put("grouprights",groupRights);		
			TagDataHelper5 taglib1=new TagDataHelper5();
			hashResult=taglib1.getProductList1(hshValue);
			arryRow=(ArrayList)hashResult.get("arryRow");
			if(arryRow!=null && arryRow.size()>0)
			{
				for(int i=0;i<arryRow.size();i++)
				{
					arryCol=(ArrayList)arryRow.get(i);
					String strConcat=(String)arryCol.get(13)+"-";
					strConcat=strConcat+(String)arryCol.get(3)+"-";
					strConcat=strConcat+(String)arryCol.get(4)+"-";
					strConcat=strConcat+(String)arryCol.get(0);

					out.print("<option value='"+(String)arryCol.get(0)+"$");
					out.print((String)arryCol.get(5)+"$"+(String)arryCol.get(6));
					out.print("$"+(String)arryCol.get(7)+"$");
					out.print((String)arryCol.get(8)+"$");
					out.print((String)arryCol.get(9)+"$");
					out.print((String)arryCol.get(10)+"$");
					out.print((String)arryCol.get(11)+"$");
					out.print((String)arryCol.get(12)+"$");
					out.print(strConcat.trim()+"'>");
					out.print(strConcat);
					out.print("</option>");
				}
			}
		}
		catch(Exception e)
		{
			throw new JspException("Error in ProductListHelpTag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}
