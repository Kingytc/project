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

public class BankSchemeTag extends TagSupport{

	private static final long serialVersionUID = 1L;
	String apptype;
	
	
	public String getApptype() {
		return apptype;
	}


	public void setApptype(String apptype) {
		this.apptype = apptype;
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
			rs=DBUtils.executeLAPSQuery("sel_bankschemeforcar");
			while(rs.next())
			{
				if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
				{
				out.print("<option value="+Helper.correctNull((String)rs.getString("MIS_STATIC_DATA_CODE")));
				out.print(">"+Helper.correctNull((String)rs.getString("mis_static_data_desc"))+"</option>");
				}
				else if(Helper.correctNull(rs.getString("MIS_STATIC_DATA_SHOW")).equalsIgnoreCase("E"))
				{
					out.print("<option value="+Helper.correctNull((String)rs.getString("MIS_STATIC_DATA_CODE")));
					out.print(">"+Helper.correctNull((String)rs.getString("mis_static_data_desc"))+"</option>");
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
