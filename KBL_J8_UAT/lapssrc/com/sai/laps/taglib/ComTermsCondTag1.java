package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper3;

public class ComTermsCondTag1 extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComTermsCondTag1.class);

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
			appno = Helper.correctNull(request.getParameter("appno"));
			strcattype = Helper.correctNull(request.getParameter("hidCategoryType"));
			hshQuery.put("appno",appno);
			hshQuery.put("cattype",strcattype);
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			HashMap hshRes=(HashMap)tagDataHelper3.getComFacilities1(hshQuery);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("apptermscond",hshQuery,"getComFacilities");
			ArrayList arrFacilities = new ArrayList();
			ArrayList arrFacilityId = new ArrayList();
			arrFacilityId = (ArrayList)hshRes.get("arrFacilityId");
			arrFacilities = (ArrayList)hshRes.get("arrFacilities");
				
			for(int i=0;i<arrFacilityId.size();i++)
			{
				out.print("<option value="+arrFacilityId.get(i));
				out.print(">"+arrFacilities.get(i)+"</option>");
			}	

		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
	}
}