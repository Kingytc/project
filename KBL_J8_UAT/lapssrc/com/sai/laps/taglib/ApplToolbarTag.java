package com.sai.laps.taglib;

import java.util.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;
import com.sai.laps.helper.*;
import com.sai.laps.tagdatahelper.TagDataHelper1;
public class ApplToolbarTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplToolbarTag.class);
	private static final long serialVersionUID = 1L;
	String strusrid = "";
	String strModule = "";
	JspWriter out = null; 
	
	public void setStrModule(String strModule)
	{
		if(strModule == null)
		{
			strModule = Helper.correctNull(strModule);
		}
		this.strModule = strModule.trim();
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		HttpSession session = pageContext.getSession();
		ServletRequest servletrequest = null;
        servletrequest = super.pageContext.getRequest();
		String usrid =  Helper.correctNull((String)session.getAttribute("strUserId"));
		//String strAppno = Helper.correctNull(servletrequest.getParameter("appno"));
		String strvaluesin = Helper.correctNull(servletrequest.getParameter("valuesin"));
		String grpRights = Helper.correctNull((String)session.getAttribute("strGroupRights"));
		
		//usrid="admin";
		String url=ApplicationParams.getAppUrl();
		ArrayList arr=new ArrayList();
		ArrayList arr1=new ArrayList();
	
		try
		{
			HashMap hshParams = new HashMap();
			hshParams.put("usrid",usrid);
			hshParams.put("strModule",strModule);
			//hshParams.put("strAppno",strAppno);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=(HashMap)tagDataHelper1.getToolBarData(hshParams);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("appeditlock",hshParams,"getToolBarData");
			arr=(ArrayList)hshRes.get("arryRow");
			String strProposalin="";
			//String strProposalin=Helper.correctNull((String)hshRes.get("proposalvaluesin"));
			if(strvaluesin.equalsIgnoreCase("C"))
				strProposalin="Crores";
			else if(strvaluesin.equalsIgnoreCase("L"))
				strProposalin="Lacs";
			else if(strvaluesin.equalsIgnoreCase("A"))
				strProposalin="Rs.";
			
			out = pageContext.getOut();
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#DEDACF\" >");
			out.println("<tr>");
			/*if(strModule.equalsIgnoreCase("2") || strModule.equalsIgnoreCase("1"))
			{
				out.print("\n<td width=\"95%\" align=\"center\">");
				out.print("\n<b><FONT SIZE=\"5\" color=\"red\" face=\"MS Sans Serif\">(Rs. in " +
					"<strong>" +strProposalin+
					"</strong>)</FONT></b>");
				out.print("\n</td>");
			}*/
			
			for(int i=0;i<arr.size();i++)
			{
				if(strModule.equalsIgnoreCase("2") && grpRights.charAt(Integer.parseInt("1"+(i+1))) == '1')
				{	
					arr1=(ArrayList)arr.get(i);
					out.println("<td width=\"26\">");
					out.println("<font size=\"1\" face=\"MS Sans Serif\" title="+ arr1.get(1).toString() + ">");
					out.println("<a href=javascript:Validate('"+arr1.get(0)+"','"+arr1.get(2).toString().trim()+"','"+arr1.get(3).toString().trim()+"') >");
					out.println("<IMG border=0 SRC="+url+arr1.get(3).toString().trim());
					out.println("</a>");
					out.println("</font>");
					out.println("</td>");
				}	
				else if(strModule.equalsIgnoreCase("3") && grpRights.charAt(Integer.parseInt(""+(i+8))) == '1')
				{
					arr1=(ArrayList)arr.get(i);
					out.println("<td width=\"26\">");
					out.println("<font size=\"1\" face=\"MS Sans Serif\" title="+ arr1.get(1).toString() + ">");
					out.println("<a href=javascript:Validate('"+arr1.get(0)+"','"+arr1.get(2).toString().trim()+"','"+arr1.get(3).toString().trim()+"') >");
					out.println("<IMG border=0 SRC="+url+arr1.get(3).toString().trim());
					out.println("</a>");
					out.println("</font>");
					out.println("</td>");
				}
			}
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
				log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

