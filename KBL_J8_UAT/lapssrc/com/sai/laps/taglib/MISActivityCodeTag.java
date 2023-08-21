package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class MISActivityCodeTag extends TagSupport
{
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;
	static Logger log=Logger.getLogger(MISActivityCodeTag.class);
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
			hshValues=taglib.getMISActivityCodeData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strPurposeDesc = Helper.correctNull((String)vecCol.get(1));
				String strPurposeSNo = Helper.correctNull((String)vecCol.get(2));
				if(apptype.equalsIgnoreCase("M"))
				{
					out.println("<option title=\""+strId+"-"+strPurposeDesc+"\" value=\""+strId+"\">"+strId+"-"+strPurposeDesc+"</option>");
				}
				else
				{
					out.println("<option title=\""+strId+"-"+strPurposeDesc+"\" value=\""+strId+"&"+strPurposeSNo+"\">"+strId+"-"+strPurposeDesc+"</option>");
				}
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}




