package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class BAFacilityTag extends TagSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String bankflag;
	JspWriter out =null;
	static Logger log=Logger.getLogger(BAFacilityTag.class);
		
	public void setBankflag(String bankflag)
	{
		this.bankflag=bankflag;
		out=pageContext.getOut();
	}
		
	public int doEndTag() throws JspException
	{
		ServletRequest request = null;
		request = pageContext.getRequest(); 
		
		String strAppno=Helper.correctNull((String)request.getParameter("strAppno"));
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();	
		HashMap hsh =  new HashMap();
		try
		{
			out=pageContext.getOut();
			hsh.put("appno",strAppno);
			hsh.put("bankflag",bankflag);
			TagDataHelper7 taglib=new TagDataHelper7();
			hshValues=taglib.getBAFacilitiesData(hsh);
			vecRow = (ArrayList)hshValues.get("vecRow");		
			
			int intSize = 0;
			intSize = vecRow.size();
			for(int i=0;i<intSize ;i++)
			{
				vecCol = (ArrayList) vecRow.get(i);
				String strFacId 	= Helper.correctNull((String)vecCol.get(0));
				String strFacNature 	= Helper.correctNull((String)vecCol.get(1));
				String strFacDesc 	= Helper.correctNull((String)vecCol.get(2));
				String strfacsno 	= Helper.correctNull((String)vecCol.get(3));
				String strcredittype 	= Helper.correctNull((String)vecCol.get(4));
				String strbankingtype 	= Helper.correctNull((String)vecCol.get(5));
				String strFacVal=strFacId+"~"+strFacNature+"~"+strfacsno+"~"+strcredittype+"~"+strbankingtype;
				out.println("<option title=\""+strFacDesc+"\" value=\""+strFacVal+"\">"+strFacDesc+"</option>");
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




