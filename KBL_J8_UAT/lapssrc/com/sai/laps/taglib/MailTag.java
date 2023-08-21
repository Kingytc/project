package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper2;

public class MailTag extends TagSupport
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MailTag.class);
	public String value = null;
    JspWriter out = null;

    

    public int doEndTag()
        throws JspException
    {
        HashMap hshval = new HashMap();
        try
        {
            out = pageContext.getOut();
            TagDataHelper2 tagDataHelper2=new TagDataHelper2();
            HashMap hshValues =(HashMap)tagDataHelper2.getUsersHelp(hshval);
            //HashMap hshValues = (HashMap)EJBInvoker.executeStateLess("mailbox", hshval, "getUsersHelp");
            ArrayList ArrayList = new ArrayList();
            ArrayList ArrayList1 = new ArrayList();
            ArrayList = (ArrayList)hshValues.get("vecCodes");
            ArrayList1 = (ArrayList)hshValues.get("vecValues");
            for(int i = 0; i < ArrayList.size(); i++)
            {
                out.print("<option value=" + ArrayList.get(i));
                out.print(">" + ArrayList.get(i) + " - " + ArrayList1.get(i) + "</option>");
            }

        }
       catch(Exception e)
		{
    	   log.error("exception in orglisttag.. "+e);
		}
        return EVAL_PAGE;
    }
}