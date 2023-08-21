package com.sai.laps.taglib;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class SchemeStaticDataTag extends TagSupport
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SchemeStaticDataTag.class);
	String apptype;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		try
		{
			out=pageContext.getOut();
			hsh.put("apptype",apptype);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getSchemeStaticdataData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strName = Helper.correctNull((String)vecCol.get(1));
				String strFrom=Helper.correctNull((String)vecCol.get(2));
				String strTo=Helper.correctNull((String)vecCol.get(3));
				out.println("<option title=\""+strName+"\" value=\""+strId+"$"+strFrom+"$"+strTo+"\">"+strName+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error(e.toString());
			throw new EJBException(" Exception in StaticDataTag "+e.toString());
		}
		return EVAL_PAGE;
	}
}
