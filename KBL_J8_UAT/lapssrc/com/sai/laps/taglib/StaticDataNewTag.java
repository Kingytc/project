package com.sai.laps.taglib;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.RefTableManager;
public class StaticDataNewTag extends TagSupport
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(StaticDataNewTag.class);
	String apptype;
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
	}
	public int doEndTag() throws JspException
	{
		try
		{
			JspWriter out=pageContext.getOut();
			HttpSession httpSession=pageContext.getSession();
			if(apptype.length()!=0)
			{
				ArrayList arrRow = RefTableManager.getCodeAndDescription(apptype,"STATIC");
				if(arrRow!=null && arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
						ArrayList arrCol=(ArrayList)arrRow.get(i);
						
						String strId = Helper.correctNull((String)arrCol.get(0));
						String strName = Helper.correctNull((String)arrCol.get(1));
						
						if(apptype.equalsIgnoreCase("210")){
							if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
									Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
									Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
									Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
							{
								out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strId+" - "+strName+"</option>");
							}
							else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Y"))
							{
								out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strId+" - "+strName+"</option>");
							}
						}
						else{
						if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
								Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
								Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
								Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
						{
							out.println("<option value=\""+strId+"\">"+strName+"</option>");
						}
						else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Y"))
						{
							out.println("<option value=\""+strId+"\">"+strName+"</option>");
						}
						}
					}
				}
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}