package com.sai.laps.taglib;

import java.sql.ResultSet;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;

public class AgriSchemes extends TagSupport{
	String appno="";
	static Logger log=Logger.getLogger(AgriSchemes.class);
	JspWriter out=null;
	public void setappno(String appno)
	{
		this.appno=appno;
		out=pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{  
		JspWriter out=null;
		ServletRequest request=null;
		ResultSet rs1=null;
		try
		{
		
			out=pageContext.getOut();
			request=pageContext.getRequest();	
			String strFacSno="";
			rs1 = DBUtils.executeLAPSQuery("sel_agriculture_facilities^"+appno);
			while(rs1.next())
			{
				strFacSno="";
				String strSchemeType=Helper.correctNull(rs1.getString("facility_agrschemetype"));
				strFacSno=Helper.correctNull(rs1.getString("facility_sno"));
				String strSchemeName="";
				if(strSchemeType.equalsIgnoreCase("aQ"))
				{
					strSchemeName="Kisan Credit Card Scheme";
				}
				else if(strSchemeType.equalsIgnoreCase("aO"))
				{
					strSchemeName="Minor Irrigation";
				}
				else if(strSchemeType.equalsIgnoreCase("aP"))
				{
					strSchemeName="Federal Agri Mobile";
				}
				else if(strSchemeType.equalsIgnoreCase("aL"))
				{
					strSchemeName="Purchase of Agriculture Land";
				}
				else if(strSchemeType.equalsIgnoreCase("aM"))
				{
					strSchemeName="Farm Mechanisation";
				}
				else if(strSchemeType.equalsIgnoreCase("aK"))
				{
					strSchemeName="Advance Against Warehouse Receipt";
				}
				else if(strSchemeType.equalsIgnoreCase("aH"))
				{
					strSchemeName="Plantation & Horticulture";
				}
				else if(strSchemeType.equalsIgnoreCase("aV"))
				{
					strSchemeName="Farm Development";
				}
				else if(strSchemeType.equalsIgnoreCase("aG"))
				{
					strSchemeName="Rural Godown";
				}
				else if(strSchemeType.equalsIgnoreCase("aS"))
				{
					strSchemeName="Self Help Group";
				}
				else if(strSchemeType.equalsIgnoreCase("aF"))
				{
					strSchemeName="Federal Farm Hospitality";
				}
				else if(strSchemeType.equalsIgnoreCase("aR"))
				{
					strSchemeName="Allied Activity";
				}
				else if(strSchemeType.equalsIgnoreCase("aC"))
				{
					strSchemeName="KCC (Restructure)";
				}
				else if(strSchemeType.equalsIgnoreCase("aU"))
				{
					strSchemeName="ACC";
				}
				else if(strSchemeType.equalsIgnoreCase("aD"))
				{
					strSchemeName="Diary Farming";
				}
				else if(strSchemeType.equalsIgnoreCase("aE"))
				{
					strSchemeName="Poultry Development";
				}
				else if(strSchemeType.equalsIgnoreCase("aJ"))
				{
					strSchemeName="Financing Fisheries";
				}
				else if(strSchemeType.equalsIgnoreCase("aI"))
				{
					strSchemeName="Sericulture";
				}
				else if(strSchemeType.equalsIgnoreCase("aB"))
				{
					strSchemeName="Tobacco Financing";
				}
				else if(strSchemeType.equalsIgnoreCase("aN"))
				{
					strSchemeName="Gobar Gas plant";
				}
				else if(strSchemeType.equalsIgnoreCase("aT"))
				{
					strSchemeName="Financing of Bullock Cart";
				}
				else if(strSchemeType.equalsIgnoreCase("aY"))
				{
					strSchemeName="Farm Forestry";
				}
				else
				{
					strSchemeName="";
				}
				
				out.println("<option value=\""+strFacSno+"-"+strSchemeType+"\">"+strFacSno+" - "+strSchemeName+" - "+Helper.correctNull(rs1.getString("com_facdesc"))+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error(e.toString());
		}
		return EVAL_PAGE;
	}
}
