package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class MonthMonHeaderTag extends TagSupport
{

    private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MonthMonHeaderTag.class);

    public MonthMonHeaderTag()
    {
    }

    public int doEndTag()
        throws JspException
    {
        JspWriter out = null;
        ServletRequest request = null;
        request = pageContext.getRequest();
        HttpSession session1 = pageContext.getSession();
        String strRptholder = "";
        String strbtnenable = Helper.correctNull(request.getParameter("btnenable"));
        String mmrorgscode = "";
        String strApporgname = "";
        String strcbsid = Helper.correctNull(request.getParameter("hidcbsid"));
        String strUserId = Helper.correctNull((String)session1.getAttribute("strUserId"));
        String strOrgScode = Helper.correctNull((String)session1.getAttribute("strOrgShortCode"));
        String strcbsname = Helper.correctNull(request.getParameter("strcbsname"));
        String strYear = Helper.correctNull(request.getParameter("mon_year"));
        String mmrStatus = Helper.correctNull(request.getParameter("statusflag"));
        String Strmmrno = Helper.correctNull(request.getParameter("mmrno"));
        String strMon = Helper.correctNull(request.getParameter("mon_month"));
        strRptholder = Helper.correctNull(request.getParameter("mmrappholder"));
        strApporgname = Helper.correctNull(request.getParameter("mmrapporgname"));
        if(strcbsid.equalsIgnoreCase(""))
        {
            strcbsid = Helper.correctNull(request.getParameter("cbsid"));
        }
        if(strcbsname.equals(""))
        {
            strcbsname = Helper.correctNull(request.getParameter("cbsname"));
        }
        if(strYear.equalsIgnoreCase(""))
        {
            strYear = Helper.correctNull(request.getParameter("strYear"));
        }
        if(strMon.equalsIgnoreCase(""))
        {
            strMon = Helper.correctNull(request.getParameter("mmr_month"));
        }
        if(strMon.equalsIgnoreCase(""))
        {
            strMon = Helper.correctNull(request.getParameter("mon_smonth"));
        }
        int mon = Integer.parseInt(strMon);
        String strmonth = Helper.getMonths(mon);
        char readFlag = Helper.correctNull((String)session1.getAttribute("strGroupRights")).charAt(18);
        try
        {
            if(Strmmrno.equals("") || strcbsid.equals("") || strMon.equals("") || strYear.equals("") || strRptholder.equals("") || strApporgname.equals("") || strbtnenable.equalsIgnoreCase(""))
            {
                HashMap hshParams = new HashMap();
                hshParams.put("strcbsid", strcbsid);
                hshParams.put("strYear", strYear);
                hshParams.put("strMon", strMon);
                TagDataHelper1 tagDataHelper1 = new TagDataHelper1();
                HashMap hshRes = tagDataHelper1.getMMRAppDetails(hshParams);
                if(hshRes != null)
                {
                    strcbsid = Helper.correctNull((String)hshRes.get("strcbsid"));
                    Strmmrno = Helper.correctNull((String)hshRes.get("Strmmrno"));
                    strYear = Helper.correctNull((String)hshRes.get("strYear"));
                    strMon = Helper.correctNull((String)hshRes.get("strMon"));
                    mmrStatus = Helper.correctNull((String)hshRes.get("mmrStatus"));
                    strRptholder = Helper.correctNull((String)hshRes.get("mmrrptholder"));
                    mmrorgscode = Helper.correctNull((String)hshRes.get("mmrorgscode"));
                    strApporgname = Helper.correctNull((String)hshRes.get("org_name"));
                }
                if(readFlag == 'w')
                {
                    if(mmrStatus.equalsIgnoreCase("O"))
                    {
                        if(strRptholder.equalsIgnoreCase(strUserId))
                        {
                            strbtnenable = "Y";
                        } else
                        {
                            strbtnenable = "N";
                        }
                    } else
                    if(mmrStatus.equalsIgnoreCase("P"))
                    {
                        if(strOrgScode.equals(mmrorgscode))
                        {
                            strbtnenable = "Y";
                        } else
                        {
                            strbtnenable = "N";
                        }
                    } else
                    if(mmrStatus.equalsIgnoreCase("C"))
                    {
                        strbtnenable = "N";
                    }
                } else
                {
                    strbtnenable = "N";
                }
            }
            out = pageContext.getOut();
            request = pageContext.getRequest();
            out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>"
);
            out.println("<tr class=\"applicationheader\">");
            out.println("<td width=\"12%\">");
            out.println("<b>MMR No</b>");
            out.println("</td>");
            out.println("<td width=\"18%\"><b>" + Strmmrno);
            out.println("<input type=\"hidden\" name=\"mmrno\" value=\"" + Strmmrno + "\">");
            out.println("</b></td>");
            out.println("<td width=\"12%\"> ");
            out.println("<b>Borrower Name</b>");
            out.println("</td>");
            out.println("<td width=\"25%\"><b>" + Helper.decodeAmpersand(strcbsname));
            out.println("<input type=\"hidden\" name=\"strcbsname\" value=\"" + strcbsname + "\">");
            out.println("</b></td>");
            out.println("<td width=\"6%\">");
            out.println("<b>");
            out.println("CBS ID");
            out.println("</b>");
            out.println("</td>");
            out.println("<td width=\"8%\"><b>"+ strcbsid);
            out.println("<input type=\"hidden\" name=\"hidcbsid\" value=\"" + strcbsid + "\"");
            out.println("</b></td>");
            out.println("<td width=\"4%\">");
            out.println("<b>Year</b>");
            out.println("</td>");
            out.println("<td width=\"4%\"><b>" + strYear);
            out.println("<input type=\"hidden\" name=\"strYear\" value=\"" + strYear + "\">");
            out.println("</b></td>");
            out.println("<td width=\"7%\"> ");
            out.println("<b>Month</b>");
            out.println("</td>");
            out.println("<td width=\"10%\"><b>" + strmonth);
            out.println("<input type=\"hidden\" name=\"strmonth\" value=\"" + strmonth + "\">");
            out.println("<input type=\"hidden\" name=\"mmr_month\" value=\"" + mon + "\">");
            out.println("</b></td>");
            out.println("</tr>");
            out.println("<tr class=\"applicationheader\">");
            out.println("<td>");
            out.println("<b>Application Holder</b>");
            out.println("</td>");
            out.println("<td><b>" + strRptholder);
            out.println("<input type=\"hidden\" name=\"mmrappholder\" value=\"" + strRptholder + "\">");
            out.println("</b></td>");
            out.println("<td> ");
            out.println("<b>App. Recd. from</b>");
            out.println("</td>");
            out.println("<td><b>" + strApporgname);
            out.println("<input type=\"hidden\" name=\"mmrapporgname\" value=\"" + strApporgname + "\">");
            out.println("</b></td>");
            out.println("<td colspan=\"6\">");
            out.println("<input type=\"hidden\" name=\"btnenable\" value=\"" + strbtnenable + "\"> ");
            out.println("<input type=\"hidden\" name=\"monCheckFlag\" value=\"yes\"> ");
            out.println("<input type=\"hidden\" name=\"statusflag\" readonly value=\"" + mmrStatus + "\">");
            out.println("<input type=\"hidden\" name=\"readFlag\" value=\"" + readFlag + "\">");
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
        }
        catch(Exception e)
        {
        	log.error("exception in MonitHeaderTag.. " + e);
            throw new JspException(e.getMessage());
        }
        return EVAL_PAGE;
    }
}
