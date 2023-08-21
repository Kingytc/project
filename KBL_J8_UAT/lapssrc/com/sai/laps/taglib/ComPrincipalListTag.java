///////////////////////////////////////////////////////////
// DeJaved by mDeJava v1.0. Copyright 1999 MoleSoftware. //
//       To download last version of this software:      //
//            http://molesoftware.hypermatr.net          //
//               e-mail:molesoftware@mail.ru             //
///////////////////////////////////////////////////////////
//          JAD JavaDecompiler by Pavel Kuznetsov        //
// www.geocities.com/SiliconValley/Bridge/8617/jad.html  //
///////////////////////////////////////////////////////////

package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.EJBInvoker;

public class ComPrincipalListTag extends TagSupport
{

    /**
	 * 
	 */
	static Logger log=Logger.getLogger(ComPrincipalListTag.class);
	private static final long serialVersionUID = 1L;

	public ComPrincipalListTag()
    {
    }

    public int doEndTag()
        throws JspException
    {
       
        HashMap hashtable1 = new HashMap();
        try
        {
            JspWriter jspwriter = pageContext.getOut();
            ServletRequest servletrequest = pageContext.getRequest();
            String s = servletrequest.getParameter("appno");
            hashtable1.put("appno", s);
            HashMap hashtable = (HashMap)EJBInvoker.executeStateLess("commprincipal", hashtable1, "getPrincipalList");
            ArrayList arraylist = (ArrayList)hashtable.get("arrName");
            ArrayList arraylist1 = (ArrayList)hashtable.get("arrNo");
            for(int i = 0; i < arraylist1.size(); i++)
            {
                String s1 = (String)arraylist.get(i);
                String s2 = (String)arraylist1.get(i);
                s1 = correctDoubleQuotesHtml(s1);
                jspwriter.println("<option value=\"" + s2 + "\">" + s1 + "</option>");
            }

        }
        catch(Exception exception)
        {
            log.error("exception in comprincipallisttag.. " + exception);
        }
        return 6;
    }

    private String correctDoubleQuotesHtml(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(s);
        for(int i = 0; i < stringbuffer.length(); i++)
            if(stringbuffer.charAt(i) == '"')
                stringbuffer.replace(i, i + 1, "&quot;");

        return stringbuffer.toString();
    }
}
