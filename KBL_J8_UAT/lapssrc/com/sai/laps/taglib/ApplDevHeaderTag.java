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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class ApplDevHeaderTag extends TagSupport {
	static Logger log=Logger.getLogger(ApplHeaderTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	JspWriter out =null;

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		String strQuery = null;
		ResultSet rs = null,rs1=null,rs2=null;
		HashMap hshRecord = new HashMap();
		ServletRequest request = null;
		request = pageContext.getRequest();
		HttpSession httpSession=pageContext.getSession();
		try
		{
			String appno =  Helper.correctNull(request.getParameter("appno"));
			char readFlag=Helper.correctNull((String)httpSession.getAttribute("strGroupRights")).charAt(18);
			String strUserId=Helper.correctNull((String)httpSession.getAttribute("strUserId"));

			String applname="",applholder="",applrecfrom="",applstatus="",appstatus="",strReferenceno="",strDeviationType="",strDeviationCat="",Region_name="";
			String strAssessment="",strFinancial="";
			String strCbsId="";
			if(!appno.equalsIgnoreCase(""))
			{
				applname =  Helper.correctNull(request.getParameter("appname"));
				applholder =  Helper.correctNull(request.getParameter("appholder"));
				applrecfrom= Helper.correctNull(request.getParameter("applrecfrom"));
				applstatus =   Helper.correctNull(request.getParameter("appstatus"));
				strDeviationType =   Helper.correctNull(request.getParameter("hiddeviationType"));

				//if(applrecfrom.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_appl_deviation^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  
						applstatus =Helper.correctNull(rs.getString("DEV_APPSTATUS"));
						applholder =Helper.correctNull(rs.getString("dev_applholder"));
						strDeviationType =Helper.correctNull(rs.getString("DEV_TYPE"));
						strDeviationCat=Helper.correctNull(rs.getString("DEV_SUBTYPE"));
						strCbsId=Helper.correctNull(rs.getString("DEV_CBSID"));

						rs1=DBUtils.executeLAPSQuery("getorgcode^"+Helper.correctNull(rs.getString("DEV_ORGSCODE")));
						if(rs1.next())
						{
							if(Helper.correctNull(rs1.getString("org_level")).equalsIgnoreCase("D"))
								applrecfrom=Helper.correctNull(rs1.getString("org_name"))+" [CLPH]";
							else
								applrecfrom=Helper.correctNull(rs1.getString("org_name"));
						}
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery= SQLParser.getSqlQuery("sel_perm_details^"+appno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						String apporgcode=Helper.correctNull((String)rs1.getString("org_code")).substring(0,6)+"000000000";
						if(rs2!=null)
						{
							rs2.close();
						}
						strQuery= SQLParser.getSqlQuery("selorgname^"+ apporgcode);
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							Region_name=Helper.correctNull(rs2.getString("org_name"));
						}
					}
					HashMap hshValues=new HashMap();
					if(rs!=null)
					{
						rs.close();
					}
					strQuery= SQLParser.getSqlQuery("sel_appl_deviation_int^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						String strQuery11="";
					
						String parameter=Helper.correctNull(rs.getString("DEV_DEVPARAM"));
						if(rs!=null)
						{rs.close();}
						if(!parameter.equalsIgnoreCase(""))
						{
							int countA=0;
							int countB=0;
							String strArr[]=parameter.split("@");
							for(int i=0;i<strArr.length;i++)
							{
								strQuery11 = SQLParser.getSqlQuery("sel_parameter^"+strArr[i]);
								rs = DBUtils.executeQuery(strQuery11);
							if (rs.next())
								{
									if(Helper.correctNull(rs.getString("PER_INTEREST")).equalsIgnoreCase("Y"))
									{
										countA++;
									}
									if(Helper.correctNull(rs.getString("PER_FINANCE")).equalsIgnoreCase("Y"))
									{
										countB++;
									}
									
								}
							}
							if(countA>0)
							{
								strAssessment="Y";
							}
							else
							{
								strAssessment="N";
							}
							if(countB>0)
							{
								strFinancial="Y";
							}
							else
							{
								strFinancial="N";
							}
						}	
					}
				}
				
				if(applname.equalsIgnoreCase(""))
				{
					if(rs!=null)
						rs.close();
					strQuery = SQLParser.getSqlQuery("sel_permissionGist_Data^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
						applname =Helper.correctNull(rs.getString("PG_APPLIANTNAME"));
				}
				strQuery = SQLParser.getSqlQuery("sel_SancRefNo^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					strReferenceno =Helper.correctNull(rs.getString("sanctionrefno"));
				}

				if(applstatus.equalsIgnoreCase("OP"))
				{
					appstatus="Open/Pending";
				}
				else
					if(applstatus.equalsIgnoreCase("PA"))
					{
						appstatus="Processed/Approved";
					}
					else
						if(applstatus.equalsIgnoreCase("PR"))
						{
							appstatus="Processed/Rejected";
						}
						else
							if(applstatus.equalsIgnoreCase("CA"))
							{
								appstatus="Closed/Approved";
							}
							else
								if(applstatus.equalsIgnoreCase("CR"))
								{
									appstatus="Closed/Rejected";
								}
			}

			out = pageContext.getOut();
			request = pageContext.getRequest();

			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
			out.println("<tr  class=\"applicationheader\">");

			out.println("<td  width=\"12%\">");
			out.println("&nbsp;<b>Proposal No:</b>");
			out.println("</td>");

			out.println("<td>");
			out.println("&nbsp;"+appno);
			out.println("</td>");

			out.println("<td width=\"10%\">");
			out.println("&nbsp;<b>Applicant Name:</b>");
			out.println("</td>");

			out.println("<td>");
			out.println("&nbsp;"+applname);

			out.println("<td width=\"7%\">");
			out.println("&nbsp;<b>Status:</b>");
			out.println("</td>");

			out.println("<td>");
			out.println("&nbsp;"+appstatus);
			out.println("</td>");

			out.println("</tr>");
			out.println("<tr  class=\"applicationheader\">");

			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Application Holder:</b>");
			out.println("</td>");

			out.println("<td>");
			out.println("&nbsp;"+applholder);
			out.println("</td>");

			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>App. Recd. from:</b>");
			out.println("</td>");

			out.println("<td>");
			out.println("&nbsp;"+applrecfrom);
			out.println("</td>");

			out.println("<td nowrap>");
			out.println("&nbsp;<b>Sanction / Rejected Reference No:</b>");
			out.println("</td>");
			out.println("<td>");
			out.println("&nbsp;"+strReferenceno);
			out.println("</td>");
			out.println("</tr>");
			
			out.println("<tr  class=\"applicationheader\">");
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Customer CBS ID:</b>");
			out.println("</td>");
			out.println("<td>");
			out.println("&nbsp;"+strCbsId);
			out.println("</td>");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b>Region:</b>");
			out.println("</td>");			
			out.println("<td>");
			out.println("&nbsp;"+Region_name);
			out.println("</td>");
			
			out.println("<td nowrap='nowrap'>");
			out.println("&nbsp;<b></b>");
			out.println("</td>");			
			out.println("<td>");
			out.println("&nbsp;");
			out.println("</td>");
			out.println("</tr>");

			out.println("</table>");
			out.println("<input type=\"hidden\" name=\"appstatus\" value=\""+applstatus+"\"> ");
			out.println("<input type=\"hidden\" name=\"appno\" value=\""+appno+"\">");
			out.println("<input type=\"hidden\" name=\"applrecfrom\" value=\""+applrecfrom+"\">");
			out.println("<input type=\"hidden\" name=\"appname\" value=\""+applname+"\">");
			out.println("<input type=\"hidden\" name=\"appholder\" value=\""+applholder+"\">");
			out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
			out.println("<input type=\"hidden\" name=\"hiddeviationType\" value=\""+strDeviationType+"\">");
			
			out.println("<input type=\"hidden\" name=\"hidassessment\" value=\""+strAssessment+"\">");
			out.println("<input type=\"hidden\" name=\"hidfinancial\" value=\""+strFinancial+"\">");
			
			out.println("<input type=\"hidden\" name=\"hidDevCat\" value=\""+strDeviationCat+"\">");

			
			String btnenable=(""+readFlag).equals("r")?"N":(applstatus.equalsIgnoreCase("OP") && applholder.equals(strUserId))?"Y":"N";
			out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+btnenable+"\">");
		}
		catch(Exception e)
		{
			log.error("exception in ApplHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}



