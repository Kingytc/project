package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper3;

public class DisplayOrgTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String appno = "";
	String bid="";


	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		out = pageContext.getOut();
		ServletRequest request = null;
		request = pageContext.getRequest();

		 appno =  Helper.correctNull(request.getParameter("appno"));
		 bid =  Helper.correctNull(request.getParameter("bid"));

		String crpname="";
		String zonname="";
		String regname="";
		String brnname="";
		String CO="",Zone="",Region="",Branch="";
		try
		{		
			HashMap hshParams = new HashMap();
			hshParams.put("appno",appno);
			hshParams.put("bid",bid);
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			HashMap hshRes=(HashMap)tagDataHelper3.getParentName(hshParams);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("appeditlock",hshParams,"getParentName");
			if(hshRes!=null)
			{
				crpname = Helper.correctNull( (String) hshRes.get("crpname") );
				zonname = Helper.correctNull( (String) hshRes.get("zonname") );
				regname = Helper.correctNull( (String) hshRes.get("regname") );
				brnname = Helper.correctNull( (String) hshRes.get("brnname") );
				CO=Helper.correctNull( (String) hshRes.get("CO") );
				Zone=Helper.correctNull( (String) hshRes.get("Zone") );
				Region=Helper.correctNull( (String) hshRes.get("Region") );
				Branch=Helper.correctNull( (String) hshRes.get("Branch") );
				
				
			}

				
			if((zonname.equals(""))&&(regname.equals(""))&&(brnname.equals(""))&&(crpname.equals("")))
			{

			}
			else if((zonname.equals(""))&&(regname.equals(""))&&(brnname.equals("")))
			{
					out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"#DEDACF\">");
					out.println("<tr>");
				    out.println("<td width=\"6%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+CO+"</font></b></td>");
				    out.println("<td width=\"28%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+crpname+" </font></td>");
					out.println("</tr>");
					out.println("</table>");	
			}
			else if((regname.equals(""))&&(brnname.equals("")))
			{			
					 out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"#DEDACF\">");
					 out.println("<tr>");
					 out.println("<td width=\"6%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Zone+"</font></b></td>");
					 out.println("<td width=\"28%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+zonname+" </font></td>");
					 out.println("</tr>");
					 out.println("</table>");	
			}
			else if(brnname.equals(""))
			{			
					 out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"1\" bgcolor=\"#DEDACF\">");
					 out.println("<tr>");
					 out.println("<td width=\"6%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Zone+"</font></b></td>");
					 out.println("<td width=\"28%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+zonname+" </font></td>");
					 out.println("<td width=\"7%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Region+"</font></b></td>");
					 out.println("<td width=\"29%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+regname+" </font></td>");
					 out.println("</tr>");
					 out.println("</table>");
		}
		else
		{
					out.println("<table width=\"100%\" border=\"1\" cellspacing=\"0\"    cellpadding=\"1\" bgcolor=\"#DEDACF\">");
					 out.println("<tr>");
					 out.println("<td width=\"6%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Zone+"</font></b></td>");
					 out.println("<td width=\"28%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+zonname+" </font></td>");
					 out.println("<td width=\"7%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Region+"</font></b></td>");
					 out.println("<td width=\"29%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+regname+" </font></td>");
					 out.println("<td width=\"6%\"><b><font size=\"1\" face=\"MS Sans Serif\">"+Branch+"</font></b></td>");
				     out.println("<td width=\"24%\"><font size=\"1\" face=\"MS Sans Serif\" color=#003399>&nbsp;"+brnname+" </font></td>");
				    out.println("</tr>");
					out.println("</table>");	
		}


		}
catch(Exception e)
		{
			
			throw new JspException(e.getMessage());			

		}
		
		return EVAL_PAGE;
	}
}

