package com.sai.laps.taglib;

import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;

public class ErrorHandlerTag extends TagSupport 
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ErrorHandlerTag.class);

	public int doEndTag() throws JspException
	{  
		try
		{
			ServletRequest request=pageContext.getRequest();
			StringTokenizer strTk = null;

			JspWriter out=pageContext.getOut();
			if(request.getAttribute("Exception")!=null)
			{	
				ArrayList vget = new ArrayList();
				String strErr=Helper.correctNull((String)request.getAttribute("Exception"));
				strErr = strErr.replace('\n',' ');
				strTk = new StringTokenizer(strErr,"$");
				strTk = new StringTokenizer(strErr,"$",true);
				
				while(strTk.hasMoreElements())
				{
					vget.add(strTk.nextElement());
				}
				strErr = Helper.correctNull((String)vget.get(vget.size()-1));
				out.println("<input type=\"hidden\" name=\"hidException\" value=\""+strErr+"\"> ");
				request.removeAttribute("Exception");
				
				if(vget.size()>1)
				{
					if(Helper.correctNull((String)vget.get(1)).equalsIgnoreCase("$"))
					{
						out.println("<script>");
						out.println("alert(\""+strErr+"\")");
						out.println("</script>");
					}
				}	
			}
		}
		catch(Exception e)
		{
			log.error("exception in ErrorHandlerTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
