package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper2;
public class BorrowerSearchTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(BorrowerSearchTag.class);

	public int doEndTag() throws JspException
	{  

	JspWriter out = null;
	ServletRequest request=null;
	String val="",valsys="";
	HashMap hshquery = new HashMap();
	try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			val=request.getParameter("val");
			valsys=Helper.correctNull((String)request.getParameter("valsys"));
			if(val.equals("2"))
			{
				valsys="'"+valsys.substring(0,3)+"%%%000000000' and org_code <> '"+valsys.substring(0,3)+"000000000000'";
			}
			else if(val.equals("3"))
			{
				valsys="'"+valsys.substring(0,6)+"%%%000000' and org_code <> '"+valsys.substring(0,6)+"000000000'";
			}
			else if(val.equals("4"))
			{
				valsys="'"+valsys.substring(0,9)+"%%%000'  and org_code <> '"+valsys.substring(0,9)+"000000'";
			}
			else if(val.equals("5"))
			{
				valsys="'"+valsys.substring(0,12)+"%%%' and org_code <> '"+valsys.substring(0,12)+"000'";
			}
			else if(val.equals("66"))
			{
				valsys="'%%%%%%%%%%%%%%'";
			}
			
			hshquery.put("val",val);
			hshquery.put("valsys",valsys);
			TagDataHelper2 tagDataHelper2=new TagDataHelper2();
			HashMap hshRes=(HashMap)tagDataHelper2.getDataHelp(hshquery);
			//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("borrowersearch",hshquery,"getDataHelp");
			ArrayList arrVal  = new ArrayList();
			ArrayList arrValdesc  = new ArrayList();
			arrVal = (ArrayList)hshRes.get("arrVal");
			arrValdesc = (ArrayList)hshRes.get("arrValdesc");
			for(int i=0;i<arrVal.size();i++)
			{
				out.println("<option title=\""+arrValdesc.get(i)+"\" value=\""+arrVal.get(i)+"\">"+arrValdesc.get(i)+"</option>");
				
			}		
		}
	catch (Exception e)
		{
		log.error("error occured"+e.toString());
		}
	return EVAL_PAGE;
}
}