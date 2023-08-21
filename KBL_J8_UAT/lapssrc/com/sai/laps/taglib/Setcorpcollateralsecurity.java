package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class Setcorpcollateralsecurity extends TagSupport  {
	
	HashMap hshRequestValues = null;
	String strfacCode="";
	String strfacid="";
	static Logger log=Logger.getLogger(Setcorpcollateralsecurity.class);
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		ArrayList arrValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();
			ServletRequest request = pageContext.getRequest();
			strfacCode = Helper.correctNull(request.getParameter("hidcorp_faccode"));
			strfacid =Helper.correctNull(request.getParameter("fac_id"));
			hshRequestValues = new HashMap();
			hshRequestValues.put("prdCode",strfacCode);
			hshRequestValues.put("strfacid",strfacid);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getColsegSno(hshRequestValues);	
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
			log.error("exception in NriTag.. "+e);
		}
		return EVAL_PAGE;
	}


}
