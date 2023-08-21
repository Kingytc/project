package com.sai.laps.taglib.tabtaglib;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class reasonformodification extends TagSupport{

	private static final long serialVersionUID = 1L;
	String attrval,apptype;
	
	
	public String getApptype() {
		return apptype;
	}


	public void setApptype(String apptype) {
		this.apptype = apptype;
	}


	public String getAttrval() {
		return attrval;
	}


	public void setAttrval(String attrval) {
		this.attrval = attrval;
	}


	public static long getSerialVersionUID() {
		return serialVersionUID;
	}


	public int doEndTag() throws JspException
	{
		HttpSession httpSession=pageContext.getSession();
		JspWriter out = null;
	    ArrayList arrRow =  new ArrayList();
	    ArrayList arrVal =  new ArrayList();
	    ResultSet rs =null;
		try
		{
			
			out=pageContext.getOut();
			rs=DBUtils.executeLAPSQuery("sel_reason^"+attrval+"^"+apptype);
			while(rs.next())
			{
				if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
				{
				out.print("<option value="+Helper.correctNull((String)rs.getString("STAT_DATA_DESC")));
				out.print(">"+Helper.correctNull((String)rs.getString("STAT_DATA_DESC1"))+"</option>");
				}
				else if(Helper.correctNull(rs.getString("STAT_DATA_ACTIVE")).equalsIgnoreCase("Y"))
				{
					out.print("<option value="+Helper.correctNull((String)rs.getString("STAT_DATA_DESC")));
					out.print(">"+Helper.correctNull((String)rs.getString("STAT_DATA_DESC1"))+"</option>");
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception occured in EndUserData "+e.toString());
		}
		return EVAL_PAGE;
	}
	
}
