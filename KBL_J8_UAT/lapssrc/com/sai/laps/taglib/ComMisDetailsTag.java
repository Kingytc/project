package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;
public class ComMisDetailsTag  extends TagSupport
{
	private static final long serialVersionUID = 1L;
	String apptype,pagefrom;
	JspWriter out =null;
	static Logger log=Logger.getLogger(ComMisDetailsTag.class);
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
		out=pageContext.getOut();
	}
	public void setPage(String pagefrom)
	{
		this.pagefrom=pagefrom;
		out=pageContext.getOut();
	}
	 
	public int doEndTag() throws JspException
	{
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		
		
		try
		{
			out=pageContext.getOut();
			TagDataHelper7 taglib=new TagDataHelper7();
			hsh.put("apptype",apptype);
			hsh.put("pagefrom",pagefrom);
			hshValues=taglib.getFacilitySno(hsh);
			arrRow = (ArrayList)hshValues.get("arrRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strId = Helper.correctNull((String)arrCol.get(0));
				String strName = strId+" - "+Helper.correctNull((String)arrCol.get(1));
				out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
			}
				log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataHeadsTag.. "+e);
		}
		return EVAL_PAGE;
	}


	
}
