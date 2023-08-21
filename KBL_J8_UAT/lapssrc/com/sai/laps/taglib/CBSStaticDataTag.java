package com.sai.laps.taglib;


import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
 
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class CBSStaticDataTag extends TagSupport
{
	
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(CBSStaticDataTag.class);
	private static final long serialVersionUID = 1L;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
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
			//hshValues=(HashMap)EJBInvoker.executeStateLess("staticdata",hsh,"h");
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getCBSStaticData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strName = Helper.correctNull((String)vecCol.get(1));
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




