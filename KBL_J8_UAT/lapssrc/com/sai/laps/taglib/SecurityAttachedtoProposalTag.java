package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class SecurityAttachedtoProposalTag extends TagSupport {

	/**
	 * @param args
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SecurityAttachedtoProposalTag.class);
	String appno;
	public void setAppno(String appno)
	{
		this.appno=appno;
	}
	
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		HashMap hsh =  new HashMap();
		ServletRequest request=null;
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();			
			hsh.put("appno",appno);
			TagDataHelper7 tagDataHelper7=new TagDataHelper7();
	        hshValues =(HashMap)tagDataHelper7.getSecAttachedtoProposal(hsh);
			ArrayList arrName = new ArrayList();
			ArrayList arrvalue = new ArrayList();
			arrName = (ArrayList)hshValues.get("vecRow");
			
			for(int i=0;i<arrName.size() ;i++)
			{
				arrvalue=(ArrayList) arrName.get(i);
				String strsecId = Helper.correctNull((String)arrvalue.get(0));
				String strappno = Helper.correctNull((String)arrvalue.get(1));
				out.println("<option value=\""+strsecId+"\">"+strsecId+"</option>");
			}
		}
		catch(Exception e)
		{
			log.error("exception in SecurityAttachedtoProposalTag.. "+e);
		}
		return EVAL_PAGE;
	}

}
