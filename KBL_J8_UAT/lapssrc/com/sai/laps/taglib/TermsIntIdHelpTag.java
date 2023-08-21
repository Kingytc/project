package com.sai.laps.taglib;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.tagdatahelper.TagDataHelper6;

public class  TermsIntIdHelpTag extends TagSupport
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(TermsIntIdHelpTag.class);
	private static final long serialVersionUID = 1L;
	String appid;
	JspWriter out = null;
	
	public void setAppid(String appid)
	{
		this.appid=appid;
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{
		HashMap hashResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		HashMap hshValue=new HashMap();
				
		try
		{
			hshValue.put("appid",appid);
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			hashResult=(HashMap)tagDataHelper6.getInterestTerms(hshValue);
			//hashResult=(HashMap)EJBInvoker.executeStateLess(
					//			"perapplicant",hshValue,"getInterestTerms");
			arryRow=(ArrayList)hashResult.get("arryRow");
			log.info("arryRow===>"+arryRow);
			log.info("arryRowsize===>"+arryRow.size());

				
				if(arryRow!=null && arryRow.size()>0)
				{
					log.info("22222");
					for(int i=0;i<arryRow.size();i++)
					{
						log.info("iiiiiiiiiiiiiiiiiiiiiiii="+i);
						arryCol=(ArrayList)arryRow.get(i);
						out.print("<option value='"+(String)arryCol.get(0)+"-");
						out.print((String)arryCol.get(1)+"$" +(String)arryCol.get(2)+"'>");
						out.print("Terms " + (String)arryCol.get(0) + " to " + (String)arryCol.get(1) + "--> Interest Rate " + (String)arryCol.get(2));
						out.print("</option>");
					}
				}
				log.info("end");	

		}
		catch(Exception e)
		{
			throw new JspException("Error in ApplicantIDHelpTag "+e.getMessage());
		}
		return EVAL_PAGE;
	}
}
