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

public class GCFacilitiesTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(GCFacilitiesTag.class);
	JspWriter out =null;
	
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
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getGCFacilitiesData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strId = Helper.correctNull((String)vecCol.get(0));
				String strDesc = Helper.correctNull((String)vecCol.get(1));
				String strNature = Helper.correctNull((String)vecCol.get(2));
				String strNatureDesc="";
				if(strNature.equalsIgnoreCase("1"))
				{
					strNatureDesc="Working Capital";
				}
				else if(strNature.equalsIgnoreCase("2"))
				{
					strNatureDesc="Term Finance";
				}
				out.println("<option title=\""+strDesc+"\" value=\""+strId+"^"+strNature+"\">"+strNatureDesc+" - "+strDesc+"</option>");
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




