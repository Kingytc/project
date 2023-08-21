package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;


public class yearSelectTag extends TagSupport
{
	public yearSelectTag()
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
            HashMap hashtable = new HashMap();
            hashtable.put("appno", s);
            HashMap hashtable1 = (HashMap)EJBInvoker.executeStateLess("comproposal", hashtable, "getFinYear");
            ArrayList arraylist = new ArrayList();
            ArrayList arraylist1 = new ArrayList();
            ArrayList arraylist2 = new ArrayList();
            ArrayList arraylist3 = new ArrayList();
            arraylist = (ArrayList)hashtable1.get("arrFinYear");
            if(arraylist != null && arraylist.size() > 0)
            {
                for(int i = 0; i < arraylist.size(); i++)
                {
                    jspwriter.print("<option value='" + (String)arraylist.get(i));
                    jspwriter.print("'>");
                    jspwriter.print("" + (String)arraylist.get(i));
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