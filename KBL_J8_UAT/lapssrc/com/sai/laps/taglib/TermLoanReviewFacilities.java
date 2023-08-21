package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class TermLoanReviewFacilities extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TermLoanReviewFacilities.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String appno="";
	String strcattype="";
	HashMap hshQuery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			appno = Helper.correctNull(request.getParameter("hidtlrno"));
			hshQuery.put("appno",appno);
			TagDataHelper7 tagDataHelper7=new TagDataHelper7();
			HashMap hshRes=(HashMap)tagDataHelper7.getTermLoanReviewFacilities(hshQuery);
			ArrayList arrFacilities = new ArrayList();
			ArrayList arrFacilityId = new ArrayList();
			ArrayList arrFacAccno = new ArrayList();
			arrFacilityId = (ArrayList)hshRes.get("arrFacilityId");
			arrFacilities = (ArrayList)hshRes.get("arrFacilities");
			arrFacAccno = (ArrayList)hshRes.get("arrFacAccno");
				
			for(int i=0;i<arrFacilityId.size();i++)
			{
				out.print("<option value=\""+arrFacilityId.get(i));
				out.print("\">"+arrFacAccno.get(i)+" - "+arrFacilities.get(i)+"</option>");
			}	

		}
	catch (Exception e)
		{
		log.info("error occured"+e.toString());
		}
	return EVAL_PAGE;
	}
}