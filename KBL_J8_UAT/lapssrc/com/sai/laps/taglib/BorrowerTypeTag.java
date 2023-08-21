package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper1;

public class BorrowerTypeTag extends TagSupport
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(BorrowerTypeTag.class);

	public BorrowerTypeTag()
    {
    }

    public int doEndTag()
        throws JspException
    {
        ServletRequest servletrequest = null;
        servletrequest = super.pageContext.getRequest();
        String s = Helper.correctNull(servletrequest.getParameter("appno"));
        String s1 = Helper.correctNull(servletrequest.getParameter("hidPageType"));
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String s5 = "";
        String s6 = "";
        try
        {
            HashMap hashmap = new HashMap();
            hashmap.put("appno", s);
            TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hshRes=(HashMap)tagDataHelper1.getBorrowerType(hashmap);
            //HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("commappmaster", hashmap, "getBorrowerType");
            if(hshRes != null)
            {
                s2 = Helper.correctNull((String)hshRes.get("comapp_companyname"));
                s3 = Helper.correctNull((String)hshRes.get("comapp_companyid"));
                s4 = Helper.correctNull((String)hshRes.get("comapp_comtype"));
                s5 = Helper.correctNull((String)hshRes.get("comapp_ssitype"));
                s6 = Helper.correctNull((String)hshRes.get("comapp_id"));
            }
            if(s.equalsIgnoreCase("new") && s1.equalsIgnoreCase("SRE") || s1.equalsIgnoreCase("STL")|| s1.equalsIgnoreCase("ADC"))
            {
            	s4=s1;
            }
            
            JspWriter jspwriter = super.pageContext.getOut();
            jspwriter.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable linebor'>");
            jspwriter.println("<tr>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"hidPageType\" value=\"" + s1 + "\"> </input> </b>  </td>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"hidCategoryType\" value=\"" + s4 + "\"> </input> </b>  </td>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"hidSSIType\" value=\"" + s5 + "\"> </input> </b>  </td>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"hidBorrowerType\" value=\"" + s6 + "\"> </input> </b>  </td>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"comapp_compname\" value=\"" + s2 + "\"> </input> </b>  </td>");
            jspwriter.println("<td><b><input type=\"hidden\" name=\"comapp_compid\" value=\"" + s3 + "\"> </input> </b>  </td>");
            jspwriter.println("</td>");
            jspwriter.println("</tr>");
            jspwriter.println("</table>");
        }
        catch(Exception exception)
        {
           log.error("exception in PrdHeaderTag.. " + exception);
            throw new JspException(exception.getMessage());
        }
        return 6;
    }
}