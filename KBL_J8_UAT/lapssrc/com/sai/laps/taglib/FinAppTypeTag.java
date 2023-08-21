package com.sai.laps.taglib;

import java.sql.ResultSet;
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

public class FinAppTypeTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplHeaderTag.class);
	private static final long serialVersionUID = 1L;
	String appid = "";
	String financeid = "";
	JspWriter out = null;
	ServletRequest request = null;
	public void setAppid(String appid)
	{
		this.appid = appid;
		out = pageContext.getOut();
	}
	public void setFinanceid(String financeid)
	{
		this.financeid = financeid;
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
		char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
		
		String strNewFlag =  Helper.correctNull(request.getParameter("hidnewapp"));

	
		
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("appid",appid);
			hshParams.put("financeid",financeid);
			hshParams.put("strNewFlag",strNewFlag);
			String appname="",applicantid="";
			String strgroup="",strindustry_type="";
			String fin_type="",strAppno="",strBussID="",applstatus="";
			String Fin_id="",strAppId="";
				TagDataHelper1 tagDataHelper1=new TagDataHelper1();
				HashMap hshRes=(HashMap)tagDataHelper1.getFinAppData(hshParams);
				Fin_id=financeid;
				strAppId=appid;
				if(hshRes!=null)
				{
					 appname = Helper.correctNull( (String) hshRes.get("perapp_fname") );
					 
					//appstatus = Helper.correctNull( (String) hshRes.get("app_status") );
				
					 applicantid = Helper.correctNull( (String) hshRes.get("perapp_cbsid") );
					 strgroup=Helper.correctNull( (String) hshRes.get("com_groupname") );
					 strindustry_type=Helper.correctNull( (String) hshRes.get("com_industrytype") );
					 fin_type=Helper.correctNull( (String) hshRes.get("demo_finstandard") );
					 strAppno=Helper.correctNull( (String) hshRes.get("Rat_Appno") );
					 strBussID=Helper.correctNull( (String) hshRes.get("Rat_BussID") );
				}
				
				
				 if(applstatus.equalsIgnoreCase(""))	
					{
						strQuery = SQLParser.getSqlQuery("sel_fin_rating_status^"+strAppno);
						 rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{  
							 applstatus =Helper.correctNull(rs.getString("fin_status"));
					        }
					}
				 
					
				 if(applstatus.equalsIgnoreCase("OP"))
					{
					 applstatus="Open/Pending";
					}
					else
					if(applstatus.equalsIgnoreCase("PA"))
					{
						applstatus="Processed/Approved";
					}
					else
					if(applstatus.equalsIgnoreCase("PR"))
					{
						applstatus="Processed/Rejected";
					}
					else
					if(applstatus.equalsIgnoreCase("CA"))
					{
						applstatus="Closed/Approved";
					}
					else
					if(applstatus.equalsIgnoreCase("CR"))
					{
						applstatus="Closed/Rejected";
					}
				 
				 
			
				
				/*if(strAppholder.equals(""))
				{
					strAppholder="Y";
				}
				else
				{
					strAppholder=strAppholder.equals(strUserId)?"Y":"N";
				}*/
			

			out = pageContext.getOut();
			request = pageContext.getRequest();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td  width=\"10%\">");
			out.println("&nbsp;<b>CBSID :</b>");
			out.println("</td>");
			
			out.println("<td width=\"12%\">");
			out.println("&nbsp;"+applicantid);
			out.println("<input type='hidden' value='"+applicantid+"' name='hidCBSID'>");
			out.println("<input type='hidden' value='"+strAppId+"' name='hidAppId'>");
			out.println("</td>");
			
			out.println("<td width=\"10%\">");
			out.println("&nbsp;<b>Applicant Name:</b>");
			out.println("</td>");
			
			out.println("<td width=\"17%\">");
			out.println("&nbsp;"+appname);
			out.println("</td>");
			
			out.println("<td width=\"10%\" >");
			out.println("&nbsp;<b>Group :</b>");
			out.println("</td>");
			
			out.println("<td width=\"8%\">");
			out.println("&nbsp;"+strgroup);
			out.println("</td>");
			
			out.println("<td width=\"12%\" rowspan=\"2\" align='center' nowrap='nowrap'>");
			out.println("&nbsp;<b>Status : &nbsp;<span id=\"idstatus\">"+applstatus+"</span></b>");
			out.println("</td>");
		
			
			
			out.println("</tr>");
			out.println("<tr  class=\"applicationheader\">");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Industry Type:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+strindustry_type);
			out.println("</td>");
			
			out.println("<td nowrap='nowrap' >");
			out.println("&nbsp;<b>Financial Format:</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;"+fin_type);
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;<b>Application No :</b>");
			out.println("</td>");
			
			out.println("<td>");
			out.println("&nbsp;<span id=\"idappno\">"+strAppno+"</span>");
			out.println("<input type='hidden' value='"+strAppno+"' name='hidRatAppNo'>");
			out.println("<input type='hidden' value='"+strBussID+"' name='hidbussID'>");
			out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("</td>");
			
			
			out.println("</td>");
			
			out.println("</tr>");
			out.println("</table>");
			
		}
		catch(Exception e)
		{
			log.error("exception in ApplHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

