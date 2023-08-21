package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class ComPromotorsTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(ComPromotorsTag.class);	

	
	
	String appno;
	JspWriter out =null;
	
	public void setappno(String appno)
	{
		this.appno=appno;
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
			hsh.put("appno",appno);
			hshValues=taglib.getPrmotorsDetails(hsh);
			arrRow = (ArrayList)hshValues.get("arrRow");		
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				
				out.print("<option value='"+(String)arrCol.get(0)+"'>");	
				out.print((String)arrCol.get(1));
				out.print("</option>");
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
