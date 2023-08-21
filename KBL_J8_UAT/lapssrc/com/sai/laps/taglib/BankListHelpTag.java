package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;
import com.sai.laps.tagdatahelper.TagDataHelper1;
import com.sai.laps.tagdatahelper.TagDataHelper2;

public class BankListHelpTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(BankListHelpTag.class);
	
	
	String orglevel;
	String appno;
	String orgcode;
	String pagename;
	JspWriter out =null;
	
	public void setOrglevel(String orglevel)
	{
		this.orglevel=orglevel;
		out=pageContext.getOut();
	}
	public void setAppno(String appno)
	{
		this.appno=appno;
		out=pageContext.getOut();
	}
	public void setOrgcode(String orgcode)
	{
		this.orgcode=orgcode;
		out=pageContext.getOut();
	}
	public void setPagename(String pagename)
	{
		this.pagename=pagename;
		out=pageContext.getOut();
	}
	public int doEndTag() throws JspException
	{  	HashMap hshPar = new HashMap();
		try
		{	out = pageContext.getOut();
			hshPar.put("TagQuery","selbanklisthelp");
			hshPar.put("orglevel",orglevel);
			hshPar.put("appno",appno);
			hshPar.put("orgcode",orgcode);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			//TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			HashMap hshRes=new HashMap();
			/*if(pagename.equalsIgnoreCase("MSME"))
				hshRes=(HashMap)tagDataHelper2.getMSMEOrgDetails(hshPar);
			else*/
				hshRes=(HashMap)tagDataHelper1.getDataHelp(hshPar);
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			arrRow=(ArrayList)hshRes.get("arryRow");
			if(arrRow!=null)
			{	for(int i=0;i<arrRow.size();i++)
				{	arrCol=(ArrayList)arrRow.get(i);
					/*if(pagename.equalsIgnoreCase("MSME"))
						out.println("<option title=\""+(String)arrCol.get(0)+"\" value=\""+(String)arrCol.get(2)+"\">"+(String)arrCol.get(0)+"</option>");
					else*/
						out.println("<option title=\""+(String)arrCol.get(0)+"\" value=\""+(String)arrCol.get(1)+"\">"+(String)arrCol.get(0)+"</option>");
				}
			}
	}
	catch(Exception ioe)
	{
		log.error("error occured"+ioe.toString());
	}
	return EVAL_PAGE;
	}
}