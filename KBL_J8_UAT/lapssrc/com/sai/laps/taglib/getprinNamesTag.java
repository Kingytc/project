package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class getprinNamesTag extends TagSupport
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public getprinNamesTag()
    {
    }

    public int doEndTag()
        throws JspException
    {
        try
        {
            JspWriter jspwriter = null;
            jspwriter = super.pageContext.getOut();
            String s = "";
            ServletRequest servletrequest = null;
            servletrequest = super.pageContext.getRequest();
            s = Helper.correctNull(servletrequest.getParameter("appno"));
            HashMap hshquery = new HashMap();
            hshquery.put("appno1", s);
            TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			HashMap hshRes=(HashMap)tagDataHelper4.getNames(hshquery);
            //HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("ssidemographics", hshquery, "getNames");
           
            ArrayList arraylist = new ArrayList();
            ArrayList arraylist1 = new ArrayList();
            ArrayList arraylist2 = new ArrayList();
            ArrayList arraylist3 = new ArrayList();
            arraylist = (ArrayList)hshRes.get("arrFNames");
            arraylist1 = (ArrayList)hshRes.get("arrLNames");
            arraylist2 = (ArrayList)hshRes.get("arrMNames");
            arraylist3 = (ArrayList)hshRes.get("arrPrinid");
            if(arraylist != null && arraylist.size() > 0)
            {
                for(int i = 0; i < arraylist.size(); i++)
                {
                    jspwriter.print("<option value='" + (String)arraylist3.get(i));
                    jspwriter.print("'>");
                    jspwriter.print("" + (String)arraylist.get(i) + " " + (String)arraylist2.get(i) + " " + (String)arraylist1.get(i));
                    jspwriter.print("</option>");
                }

            }
        }
        catch(Exception exception)
        {
            throw new JspException(exception.toString());
        }
        return 6;
    }
}