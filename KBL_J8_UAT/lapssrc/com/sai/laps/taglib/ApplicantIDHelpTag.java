package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper1;

public class  ApplicantIDHelpTag extends TagSupport
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ApplicantIDHelpTag.class);
	private static final long serialVersionUID = 1L;
	String appid;
	String searchid;
	JspWriter out = null;
	public void setAppid(String appid)
	{
		this.appid=appid;
		out = pageContext.getOut();
	}
	public void setSearchid(String appid)
	{
		this.searchid=searchid;
		out = pageContext.getOut();
	}
	

	public int doEndTag() throws JspException
	{
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		HashMap hshValue=new HashMap();
		String strnoData="";
	
		
		try
		{
			hshValue.put("appid",appid);
			hshValue.put("searchid",searchid);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hashResult=(HashMap)tagDataHelper1.getApplicantIDHelp(hshValue);
			//hashResult=(HashMap)EJBInvoker.executeStateLess(
								//"perapplicant",hshValue,"getApplicantIDHelp");
			arryRow=(ArrayList)hashResult.get("arryRow");
			strnoData=(String)hashResult.get("noData");
			if(strnoData.equalsIgnoreCase("noData"))
			{
				out.print("<option value='"+strnoData+">");
						out.print("Enter Values in Applicant Master");
						out.print("</option>");
			}else
			{
				if(arryRow!=null && arryRow.size()>0)
				{
					for(int i=0;i<arryRow.size();i++)
					{
						arryCol=(ArrayList)arryRow.get(i);
						out.print("<option title='"+(String)arryCol.get(1)+" - "+(String)arryCol.get(0)+"' value='"+(String)arryCol.get(0)+"$");
						out.print((String)arryCol.get(1)+"'>");
						out.print((String)arryCol.get(1)+" - "+(String)arryCol.get(0));
						out.print("</option>");
					}
				}
			}

		}
		catch(Exception e)
		{
			throw new JspException("Error in ApplicantIDHelpTag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}
