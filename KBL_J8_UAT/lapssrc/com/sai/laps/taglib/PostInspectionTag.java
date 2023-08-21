package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.postinspection.PostInspectionBean;
import com.sai.laps.helper.Helper;

public class PostInspectionTag extends TagSupport
{

    private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(PostInspectionTag.class);
    String appno;

    public PostInspectionTag()
    {
        appno = "";
    }

    public int doEndTag()
        throws JspException
    {
        JspWriter out = null;
        ServletRequest request = null;
        request = pageContext.getRequest();
        HttpSession session1 = pageContext.getSession();
        String cbsname = Helper.correctNull(request.getParameter("cbsname"));
        char readFlag = Helper.correctNull((String)session1.getAttribute("strGroupRights")).charAt(18);
        String postins_no = "";
        String strcbsid = "";
        String appstatus = "";
        String type = "";
        String month = "";
        String year = "";
        String strBtnenable="";
        String strAppholder = "";
        String strApporgname = "";
       
        try
        {
            postins_no = Helper.correctNull(request.getParameter("hidpostins_no"));
            strcbsid = Helper.correctNull(request.getParameter("cbsid"));
            type = Helper.correctNull(request.getParameter("type"));
            
            HashMap hshParams = new HashMap();
            hshParams.put("postins_no", postins_no);
            hshParams.put("cbsid", strcbsid);
            hshParams.put("strUserId", Helper.correctNull((String)session1.getAttribute("strUserId")));
            hshParams.put("postins_no", postins_no);
            if(!postins_no.equals(""))
            {
                PostInspectionBean postinsobj = new PostInspectionBean();
                HashMap hshRes = postinsobj.getTypePostInspection(hshParams);
                if(hshRes != null)
                {
                    appstatus = Helper.correctNull((String)hshRes.get("postins_status"));
                    month = Helper.correctNull((String)hshRes.get("postins_month"));
                    year = Helper.correctNull((String)hshRes.get("postins_year"));
                    strBtnenable=Helper.correctNull((String)hshRes.get("btnenable"));
                    strApporgname = Helper.correctNull((String)hshRes.get("org_name"));
                    strAppholder = Helper.correctNull((String)hshRes.get("postins_holder"));
                    int mon = Integer.parseInt(month);
                    month = Helper.getMonths(mon);
                }
            }
            if(appstatus.equalsIgnoreCase(""))
            {
                appstatus = "P";
            }
            
            out = pageContext.getOut();
            out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
            out.println("<tr class='applicationheader'>");
            out.println("<td width=\"12%\">");
            out.println("<b>CBS ID</b>");
            out.println("</td>");
            out.println("<td width=\"15%\">" + strcbsid + "&nbsp;&nbsp;");
            out.println("<input type=\"hidden\" name=\"cbsid\"  value=\"" + strcbsid + "\"></td>");
            out.println("<td width=\"12%\"> ");
            out.println("<b>Borrower Name</b>");
            out.println("</td>");
            out.println("<td width=\"20%\">" + Helper.decodeAmpersand(cbsname));
            out.println("<input type=\"hidden\" name=\"cbsname\"  value=\"" + cbsname + "\">&nbsp;&nbsp;</td>");
            out.println("<td width=\"12%\"> ");
            out.println("<b>Month</b>");
            out.println("</td>");
            out.println("<td width=\"8%\">" + month + "&nbsp;&nbsp;</td>");
            out.println("<td width=\"4%\"> ");
            out.println("<b>Year</b>");
            out.println("</td>");
            out.println("<td width=\"6%\">" + year + "&nbsp;&nbsp;</td>");
       
            out.println("</tr>");
            out.println("<tr class='applicationheader'>");
            out.println("<td><b>Inspection Number</b></td>");
            out.println("<td> " +postins_no+" ");
            out.println("</td>"); 
            out.println("<td>");
            out.println("<b>App. Recd. from</b>");
            out.println("</td>");
            out.println("<td>" + strApporgname + "&nbsp;&nbsp;");
            out.println("<input type=\"hidden\" name=\"apporgname\"  value=\"" + strApporgname + "\"></td>");
            out.println("<td>");
            out.println("<b>Application Holder</b>");
            out.println("</td>");
            out.println("<td>" + strAppholder + "&nbsp;&nbsp;");
            out.println("<input type=\"hidden\" name=\"appholder\"  value=\"" + strAppholder + "\"></td>");
            out.println("<td><b>Status</b></td>");
            out.println("<td> " +(appstatus.equals("P")?"Pending":"Closed")+" ");
            out.println("<input type=\"hidden\" name=\"statusflag\"  value=\"" + appstatus + "\">");
            out.println("<input type=\"hidden\" name=\"hidpostins_no\" value=\"" + postins_no + "\">");
            out.println("<input type=\"hidden\" name=\"type\" value=\"" + type + "\">");
            out.println("<input type=\"hidden\" name=\"btnenable\" value=\""+strBtnenable+"\">");
            out.println("<input type=\"hidden\" name=\"readFlag\" value=\""+readFlag+"\">");
            out.println("</td>");
             out.println("</tr>");
            out.println("</table>");
        }
        catch(Exception e)
        {
        	log.error("exception in PostInspectionTag.. " + e);
            throw new JspException(e.getMessage());
        }
        return 6;
    }
}
