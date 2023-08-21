package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.rules.AgrLandHoldingsBO;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SAILogger;

public class AgrHortiPlantNamesTag extends TagSupport {
	static Logger log=Logger.getLogger(AgrHortiPlantNamesTag.class);	
	private static final long serialVersionUID = 1L;
	
	String schemetype;
	JspWriter out =null;
	
	public void setSchemetype(String schemetype)
	{
		this.schemetype=schemetype;
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		JspWriter out = null;
		ServletRequest request=null;
		String strAppNo="";
		HashMap hshValues = new HashMap();
		try
		{
			
			out=pageContext.getOut();
			request=pageContext.getRequest();
			strAppNo = Helper.correctNull(request.getParameter("appno"));
			String schemetype= Helper.correctNull(request.getParameter("schemetype"));
			String strfacsno="";
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(schemetype);			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				schemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			hshValues.put("appno",strAppNo);
			
			ArrayList arrRow=new AgrLandHoldingsBO().getHortiDetailsByAppNo(strAppNo,"aH",strfacsno);
			ArrayList arrCol=new ArrayList();
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				String strSlno= Helper.correctNull((String)arrCol.get(1)).trim();
				String strPlantName = Helper.correctNull((String)arrCol.get(2)).trim();
				out.println("<option value=\""+strSlno+"\">"+strPlantName+"</option>");
			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}

