package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class AdhocFacilityTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplHeaderTag.class);
	private static final long serialVersionUID = 1L;
	String apptype = "";
	String facGroup = "";
	String appid = "";
	String appno = "";
	JspWriter out = null;
	ServletRequest request = null;
	public void setApptype(String apptype)
	{
		this.apptype = apptype;
		out = pageContext.getOut();
	}
	public void setFacGroup(String facGroup)
	{
		this.facGroup = facGroup;
		out = pageContext.getOut();
	}
	public void setAppid(String appid)
	{
		this.appid = appid;
		out = pageContext.getOut();
	}
	public void setAppno(String appno)
	{
		this.appno = appno;
		out = pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		String strQuery = null;
		ResultSet rs = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();

	
		
		try
		{
			out=pageContext.getOut();
			HashMap hshParams = new HashMap();
			hshParams.put("apptype",apptype);
			hshParams.put("facGroup",facGroup);
			hshParams.put("appid",appid);
			hshParams.put("appno",appno);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=(HashMap)tagDataHelper1.getAdhocFacilityData(hshParams);
			if(hshRes!=null)
			{
				arrRow=(ArrayList)hshRes.get("arrRow");
				if(arrRow!=null && arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
						arrCol=(ArrayList)arrRow.get(i);
						String strId=Helper.correctNull((String)arrCol.get(0))+"~"+Helper.correctNull((String)arrCol.get(1))+"~"+Helper.correctNull((String)arrCol.get(3))+"~"+Helper.correctNull((String)arrCol.get(4))+"~"+Helper.correctNull((String)arrCol.get(5))+"~"+Helper.correctNull((String)arrCol.get(6));
						String strName=Helper.correctNull((String)arrCol.get(0))+"-"+Helper.correctNull((String)arrCol.get(1))+"-"+Helper.correctNull((String)arrCol.get(2))+"-"+Helper.correctNull((String)arrCol.get(3))+"-"+Helper.correctNull((String)arrCol.get(4));
						out.println("<option value=\""+strId+"\">"+strName+"</option>");
					}
				}
			}
				
		}
		catch(Exception e)
		{
			log.error("exception in AdhocFacilityTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

