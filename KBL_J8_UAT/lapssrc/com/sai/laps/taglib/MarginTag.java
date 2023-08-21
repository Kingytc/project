package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class MarginTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MarginTag.class);
	HashMap hshRequestValues = null;
	String strPrdCode="";
	String strPrdCode1="";
	String pageId = "";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();
			ServletRequest request = pageContext.getRequest();
			if(pageId.equalsIgnoreCase("C")){
					
				strPrdCode1 = Helper.correctNull(request.getParameter("fac_id"));
				
				
			}
			else if(pageId.equalsIgnoreCase("P"))
			{
				strPrdCode = Helper.correctNull(request.getParameter("prdCode"));
			}
		
			hshRequestValues = new HashMap();
			if(pageId.equalsIgnoreCase("C")){
			hshRequestValues.put("prdCode",strPrdCode1);
			}
			else if(pageId.equalsIgnoreCase("P"))
			{
				hshRequestValues.put("prdCode",strPrdCode);
			}
			hshRequestValues.put("pageId",pageId);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getMarginID(hshRequestValues);	
			
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			vecRow = (ArrayList)hshValues.get("vecRow");
			
			out.print("<option selected value =''>-Select-</option>");
			out.print("<option  value ='0'>-New-</option>");
			if(vecRow!=null)
			{	
				for(int i=0;i<vecRow.size();i++)
				{	vecCol = (ArrayList)vecRow.get(i);
					out.print("<option value="+vecCol.get(0));
					out.print(">"+vecCol.get(1)+"----"+vecCol.get(2)+"</option>");
					
				}	
			}
			
		}
		catch(Exception e)
		{
			log.error("exception in ProcessChargeTag.. "+e);
		}
		return EVAL_PAGE;
	}

}