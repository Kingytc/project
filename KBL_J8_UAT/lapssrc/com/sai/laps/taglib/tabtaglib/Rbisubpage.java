package com.sai.laps.taglib.tabtaglib;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;
public class Rbisubpage  extends TagSupport  {
	
	private static final long serialVersionUID = 1L;
	String strTabid="";
	String strApplevel="";
	String strApplied="";
	String strAppno="";
	static Logger log=Logger.getLogger(Rbisubpage.class);
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setApplevel(String applevel)
	{
		this.strApplevel = Helper.correctNull(applevel).trim();
	}
	public void setApplied(String applied)
	{
		this.strApplied = Helper.correctNull(applied).trim();
	}
	public void setAppno(String appno)
	{
		this.strAppno = Helper.correctNull(appno).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		boolean boolflag=true;
		
		String appno =  Helper.correctNull(request.getParameter("appno"));
		String strAppType="";
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appno",appno);
			
			if(appno.equals(""))
			{
				boolflag=false;
			}
			if(boolflag)
			{
				TagDataHelper1 tagDataHelper1=new TagDataHelper1();
				HashMap hshRes=(HashMap)tagDataHelper1.getAppType(hshParams);
				if(hshRes!=null)
				{
					strAppType=Helper.correctNull((String)hshRes.get("strAppType"));
				}
			}
			
			out = pageContext.getOut();
			out.println("<table width=60% border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center><b>");
				out.print("<b>Audit / Inspection Observations</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','compro','getcom_Rbiloanpolicyguidedata','com_Rbiloanpolicyguide.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Inspection Report';return true;\""+
						"class=\"blackfont\">Audit / Inspection Observations</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
				out.print("<b>Comments</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','compro','getcom_Rbicommentsdata','com_Rbicomments.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Technical Inspection';return true;\""+
						"class=\"blackfont\">Comments</a>" );
				out.print("</b></td>");
			}
			if(strAppType.equalsIgnoreCase("S"))
			{
				if(strTabid.equals("3"))
				{
					out.print("<td width=15% class=\"sub_tab_active\" align=center ><b>");
					out.print("<b>RBI Guidelines</b>");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td width=15% class=\"sub_tab_inactive\" align=center ><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getRBIGuidelines_restr','com_rbi_guidelines_restr.jsp?strPageType=G')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Technical Inspection';return true;\""+
							"class=\"blackfont\">RBI Guidelines</a>" );
					out.print("</b></td>");
				}
			}
			
			
			
			out.println("<input type=\"hidden\" name=\"appliedfor\" value=\""+strApplied+"\">");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in ComReporttabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}
