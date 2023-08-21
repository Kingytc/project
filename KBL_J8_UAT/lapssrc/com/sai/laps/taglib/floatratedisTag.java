
package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class floatratedisTag extends TagSupport
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(floatratedisTag.class);
	public floatratedisTag()
    {
        out = null;
        strSource = null;
    }

    public void setStrSource(String s)
    {
        if(s == null)
            s = Helper.correctNull(s);
        strSource = s.trim();
        out = super.pageContext.getOut();
    }

    public int doEndTag()
        throws JspException
    {
        HashMap hashtable = new HashMap();
        try
        {
            out = super.pageContext.getOut();
            HashMap hashtable1 = (HashMap)EJBInvoker.executeStateLess("floatbaserate", hashtable, "getDisplay");
            ArrayList ArrayList = new ArrayList();
            ArrayList = (ArrayList)hashtable1.get("vecRec1");
            for(int i = 0; i <= ArrayList.size() / 2; i++)
                out.print("<option value='" + ArrayList.get(i) + "^" + ArrayList.get(ArrayList.size() / 2 + i) + "'>" + ArrayList.get(i) + "</option>");

        }
        catch(Exception exception) {log.error("error occured"+exception.toString()); }
        log.error("end of display tag");
        return 6;
    }

    JspWriter out;
    String strSource;
}