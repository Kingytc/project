package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class CollateralSecurityTag extends TagSupport {
	HashMap hshRequestValues = null;
	String strPrdCode="";

	
	


	static Logger log=Logger.getLogger(CollateralSecurityTag.class);	

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		ArrayList arrValues=null;
		JspWriter out=null;
		try
		{
			out=pageContext.getOut();
			ServletRequest request = pageContext.getRequest();
			strPrdCode = Helper.correctNull(request.getParameter("prdCode"));

			hshRequestValues = new HashMap();
			hshRequestValues.put("prdCode",strPrdCode);
			TagDataHelper5 tagDataHelper5=new TagDataHelper5();
			hshValues=(HashMap)tagDataHelper5.getColID(hshRequestValues);	
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
