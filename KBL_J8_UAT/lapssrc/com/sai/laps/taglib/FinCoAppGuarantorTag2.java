package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helpertags.tagLibrary2;

public class FinCoAppGuarantorTag2 extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(FinCoAppGuarantorTag2.class);

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		String appno="";
		String apptype="";
		HashMap hshquery = new HashMap();
		String strQuery="";
		ResultSet rs1 = null; 
		try
		{
			out=pageContext.getOut();
			HttpSession httpSession=pageContext.getSession();
			
			 appno=(String)httpSession.getAttribute("strappno");			
				
			 strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					hshquery.put("app_name", Helper.correctDoubleQuote((rs1.getString("app_name"))));
					hshquery.put("app_status", Helper.correctDoubleQuote((rs1.getString("app_status"))));
					hshquery.put("bowid", rs1.getString("demo_appid"));
				}	
			apptype="A','C','G','P','O";
			hshquery.put("appno",appno);
			hshquery.put("applnt",apptype);
			//log.info("--vals from bean-------hshRes-----------"+hshRes);
			HashMap hshRes=new HashMap();
			tagLibrary2 taglib=new tagLibrary2();
			hshRes=taglib.getCoAppGuarantorType1(hshquery);
			ArrayList arrRow=(ArrayList)hshRes.get("arrRow");
			ArrayList arrCol=new ArrayList();
			String strType="";
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol = (ArrayList)arrRow.get(i);
				String strValue = (String)arrCol.get(2);
				if(strValue.equalsIgnoreCase("A"))
				{
					strType="App";
				}
				else if(strValue.equalsIgnoreCase("C"))
				{
					strType="Co-App";
				}
				else
				{
					strType="Gua";
				}

				out.print("<option value="+strValue+arrCol.get(0));
				out.print(">"+strType + " - " +arrCol.get(1)+"</option>");
			}	
//			ArrayList arrRow1=(ArrayList)hshRes.get("arrRow1");
//			ArrayList arrCol1=new ArrayList();
//			
//			for(int i1=0;i1<arrRow1.size();i1++)
//			{
//				arrCol1 = (ArrayList)arrRow1.get(i1);
//				out.print("<option value="+"J"+arrCol1.get(1));
//				out.print(">"+"Joint Applicant"+"-"+arrCol1.get(0)+"</option>");
//			}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		return EVAL_PAGE;
	}
}