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

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper6;

public class NpaFinTag extends TagSupport
{

    /**
	 * 
	 */
	static Logger log=Logger.getLogger(NpaFinTag.class);
	private static final long serialVersionUID = 1L;

	public NpaFinTag()
    {
    }

    public int doEndTag()
        throws JspException
    {
        HashMap hshquery = new HashMap();
        try
        {
            JspWriter jspwriter = pageContext.getOut();
            ServletRequest servletrequest = pageContext.getRequest();
            String s1 = servletrequest.getParameter("val");
            String s4 = Helper.correctNull(servletrequest.getParameter("cmano"));
            hshquery.put("val", s1);
            hshquery.put("cmano", s4);
            TagDataHelper6 tagDataHelper6=new TagDataHelper6();
	        HashMap hshRes =(HashMap)tagDataHelper6.getDataHelp2(hshquery);
            //HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("npafinmaster", hshquery, "getDataHelp");
            ArrayList arraylist = new ArrayList();
            ArrayList arraylist1 = new ArrayList();
            arraylist = (ArrayList)hshRes.get("arrVal");
            arraylist1 = (ArrayList)hshRes.get("arrValdesc");
            for(int i = 0; i < arraylist.size(); i++)
            {
                jspwriter.print("<option value='" + arraylist.get(i));
                jspwriter.print("'>" + arraylist1.get(i) + "</option>");
            }

        }
        catch(Exception exception)
        {
        	log.error("error occured" + exception.toString());
        }
        return 6;
    }
}
