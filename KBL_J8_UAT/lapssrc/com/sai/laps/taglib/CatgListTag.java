package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.tagdatahelper.TagDataHelper1;

public class CatgListTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(CatgListTag.class);
	private static final long serialVersionUID = 1L;
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		Iterator enum1=null;
		JspWriter out=null;
		ServletRequest request=null;
		HashMap hshRequestValues=new HashMap();
		String strCatId=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
            strCatId=request.getParameter("cat_id");
			if(strCatId==null || strCatId.trim().equals(""))
			{
				strCatId="0";
			}
			hshRequestValues.put("cat_id",strCatId);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			hshValues=(HashMap)tagDataHelper1.getCatgList(hshRequestValues);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setproducts",hshRequestValues,"getCatgList");
			enum1=(hshValues.keySet()).iterator();
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				String strName=(String)hshValues.get(strId);
				strName=correctDoubleQuotesHtml(strName);
				out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in catglisttag.. "+e);
		}
		return EVAL_PAGE;
	}
	private String correctDoubleQuotesHtml(String str)
	{
		StringBuffer sbf=new StringBuffer(str);
		for(int i=0;i<sbf.length();i++)
		{
			if(sbf.charAt(i)=='"')
			{
				sbf.replace(i,i+1,"&quot;");
			}
		}
		return sbf.toString();
	}


}
