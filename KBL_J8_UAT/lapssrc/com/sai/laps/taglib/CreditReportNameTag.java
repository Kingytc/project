package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import com.sai.laps.helper.Helper;

import com.sai.laps.tagdatahelper.TagDataHelper1;

public class  CreditReportNameTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String strinwardno;
	JspWriter out = null;
	
	public void setInwardno(String strinwardno)
	{
		this.strinwardno=strinwardno;
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
			hshValue.put("strinwardno",strinwardno);
			TagDataHelper1 tagDataHelper1=new TagDataHelper1();
			HashMap hashResult=(HashMap)tagDataHelper1.getCreditReportNames(hshValue);
			arryRow=(ArrayList)hashResult.get("arryRow");
			strnoData=(String)hashResult.get("noData");
			if(strnoData.equalsIgnoreCase("noData"))
			{
				out.print("<option value='"+strnoData+">");
						out.print("No data Found");
						out.print("</option>");
			}else
			{
				if(arryRow!=null && arryRow.size()>0)
				{
					for(int i=0;i<arryRow.size();i++)
					{
						arryCol=(ArrayList)arryRow.get(i);
						out.print("<option value='"+Helper.replaceForJavaScriptString((String)arryCol.get(0))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(1))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(2))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(3))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(4))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(5))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(6))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(7))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(8))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(9))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(11))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(12))+"$"+
								Helper.replaceForJavaScriptString((String)arryCol.get(13)));
						out.print("'>");
						out.print((String)arryCol.get(1));
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
