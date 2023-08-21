package com.sai.laps.taglib;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.RefTableManager;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class CBSStaticDataNewTag extends TagSupport
{
	static Logger log=Logger.getLogger(CBSStaticDataNewTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	String tagType;
	
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
	}
	public void settagType(String tagType)
	{
		this.tagType=tagType;
	}
	
	public int doEndTag() throws JspException
	{
		try
		{
			HttpSession httpSession=pageContext.getSession();
			JspWriter out=pageContext.getOut();
			if(apptype.length()!=0)
			{
			ArrayList arrRow = RefTableManager.getCodeAndDescription(apptype,"CBS");
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=(ArrayList)arrRow.get(i);
					String strId = Helper.correctNull((String)arrCol.get(0));
					String strName = Helper.correctNull((String)arrCol.get(1));
					if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
					{
						if(tagType!=null && tagType.equalsIgnoreCase("child") && apptype.equalsIgnoreCase("20") && Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa"))
						{
							if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("E"))
							{
								out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
							}
						}
						else
						{
							out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
						}
					}
					else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("E"))
					{
						if(tagType!=null && tagType.equalsIgnoreCase("value"))
						{
							out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strId+"-"+strName+"</option>");
						}
						else
						{
							out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
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




