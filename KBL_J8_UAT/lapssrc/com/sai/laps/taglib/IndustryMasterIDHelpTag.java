package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class  IndustryMasterIDHelpTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		ArrayList vecRow=new ArrayList();
		ArrayList vecCol=new ArrayList();
		HashMap hshValue=new HashMap();
		JspWriter out = null;
		out = pageContext.getOut();
		String strnoData="";	
		ServletRequest request = null;
		
		try
		{
			TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			request = pageContext.getRequest();
			hshValue.put("grpcode",request.getParameter("grpcode"));
			hashResult=(HashMap)tagDataHelper4.getIndustryData(hshValue);
			vecRow=(ArrayList)hashResult.get("vecRow");
			strnoData=Helper.correctNull((String)hashResult.get("noData"));

			if(strnoData.equalsIgnoreCase("noData"))
			{
				out.print("<option value='"+strnoData+">");
				out.print("Enter Values in Applicant Master");
				out.print("</option>");
			}
			else
			{
				if(vecRow!=null && vecRow.size()>0)
				{
					for(int i=0;i<vecRow.size();i++)
					{
						vecCol=(ArrayList)vecRow.get(i);
						if(vecCol!=null)
						{
							out.print("<option value=\""+Helper.correctNull((String)vecCol.get(0))+"$");
							out.print(Helper.correctNull((String)vecCol.get(1))+"$");
							out.print(Helper.correctNull((String)vecCol.get(2))+"$");
							out.print(Helper.correctNull((String)vecCol.get(3))+"$");
							out.print(Helper.correctNull((String)vecCol.get(4))+"$");
							//out.print(Helper.correctNull((String)vecCol.get(5))+"$");
							//out.print(Helper.correctNull((String)vecCol.get(6))+"$");
							out.print("\">"+Helper.correctNull((String)vecCol.get(2))+"</option>");
						}
					}
				}
			}
		}
		catch(Exception e)
		{
			throw new JspException("Error in IndustryMasterIDHelpTag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}


