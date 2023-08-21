package com.sai.laps.taglib;

import java.util.ArrayList;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.rules.AgrNurseryLoanBO;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.Helper;
 
public class HorticultureplantnamesTag extends TagSupport{

	static Logger log=Logger.getLogger(HorticultureplantnamesTag.class);	
	private static final long serialVersionUID = 1L;
	JspWriter out =null;
	
	public void setApptype(String apptype)
	{
		out=pageContext.getOut();
	}
	
	public int doEndTag() throws JspException
	{
		ArrayList arrValues=null;		
		JspWriter out=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();	
		ServletRequest request=null;
		String strAppno="";
		try
		{
			
			out=pageContext.getOut();
			request=pageContext.getRequest();

			AgrNurseryLoanBO taglib=new AgrNurseryLoanBO();
			arrRow=taglib.getHorticultureScaleMasterData("");
			
			int intSize = 0;
			intSize = arrRow.size();
			for(int i=0;i<intSize ;i++)
			{
				arrCol = (ArrayList) arrRow.get(i);
				String strPlantSno = Helper.correctNull((String)arrCol.get(4));
				String strPlantName= Helper.correctNull((String)arrCol.get(0));
				out.println("<option value=\""+strPlantSno+"\">"+strPlantName+"</option>");
				
			}
			
		}
		catch(Exception e)
		{
			log.error("exception in HorticultureplantnamesTag.. "+e);
		}
		return EVAL_PAGE;
	}


}
