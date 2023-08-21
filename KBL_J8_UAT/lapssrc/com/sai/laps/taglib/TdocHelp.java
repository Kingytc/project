package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
public class  TdocHelp extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TdocHelp.class);
	public String value;  
	JspWriter out = null;
	
	public void setValue(String value)
	{
		this.value = value;
		out = pageContext.getOut();
		log.info("value"+value);
	}  

	public int doEndTag() throws JspException
	{
		HashMap hashValue=new HashMap();
		HashMap hashResult=new HashMap();
		String strData="";
		ArrayList arrCode=new ArrayList();
		ArrayList arrDesc=new ArrayList();
		ArrayList arrVal=new ArrayList();
		hashValue.put("value",value);
		//EJBInvoker ejbinvoker=new EJBInvoker();
		try
		{
			if(!value.equalsIgnoreCase("BS") && !value.equalsIgnoreCase("IC") && !value.equalsIgnoreCase("%"))
			{
				hashResult=(HashMap)EJBInvoker.executeStateLess(
											"tdocdocuments",hashValue,"getUsedFor");
			}
			else
			{
				hashResult=(HashMap)EJBInvoker.executeStateLess(
											"setriskbd",hashValue,"getRiskHelp");
			}
			strData=Helper.correctNull((String)hashResult.get("noData"));
			arrCode=(ArrayList)hashResult.get("arrCode");
			arrDesc=(ArrayList)hashResult.get("arrDesc");
			arrVal=(ArrayList)hashResult.get("arrVal");
			if(!strData.equals(""))
			{
				if(strData.equalsIgnoreCase("Data"))
				{
				out.print("<table align=\"center\">");
				out.print("<tr>");
				out.print("<td>");
				out.print("<center><h2> <select name=\"seltdoc_docs\" size ='20' style='width:625' onDblClick ='javascript:getSelectedlistValue()'>");
				for(int i=0;i<arrCode.size();i++)
				{
					if(!value.equals(""))
					{
						out.print("<option value="+(String)arrCode.get(i)+" >"+(String)arrDesc.get(i)+"</option>");
					}
					else
					{
						out.print("<option value="+(String)arrCode.get(i)+" >"+(String)arrCode.get(i)+"-"+(String)arrDesc.get(i)+"</option>");
					}
				}
				for(int i=0;i<arrVal.size();i++){
				    out.print("<option value='documentid'>"+(String)arrVal.get(i)+"</option>");
				}
				out.print("</select>");
				out.print("</td>");
				out.print("</tr>");
				out.print("</table>");
				}
				else if(strData.equalsIgnoreCase("noData"))
				{
				out.print("<table align=\"center\">");
				out.print("<tr>");
				out.print("<td>");
				out.print("Enter New Data ");
				out.print("<br>");
				out.print("</td>");
				out.print("</tr>");
				out.print("</table>");
				}
		
			}
		}
		catch(Exception e)
		{
			throw new JspException("Error in ListTag "+e.getMessage());
		}

		return EVAL_PAGE;
	}

}
