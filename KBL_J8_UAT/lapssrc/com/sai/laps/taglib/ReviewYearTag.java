package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class ReviewYearTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ReviewYearTag.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request=null;
		String cbsCustId="";
		String cbsAccNo="";
		HashMap hshquery = new HashMap();
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			
			cbsAccNo = Helper.correctNull(request.getParameter("cbsaccno"));

			HashMap hshParams = new HashMap();
			hshParams.put("cbsaccno",cbsAccNo);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=(HashMap)tagDataHelper1.getMonData(hshParams);
			if(hshRes!=null)
			{
				cbsCustId = Helper.correctNull( (String) hshRes.get("personal_cbsid") );
			}
			
			hshquery.put("cbsCustId",cbsCustId);
			hshquery.put("cbsAccNo",cbsAccNo);
			hshRes = (HashMap)EJBInvoker.executeStateLess("reviewtermloan",hshquery,"getReviewYear");
			
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			//String strType="";
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				out.print("<option value="+arrCol.get(0));
				out.print(">"+arrCol.get(0)+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}