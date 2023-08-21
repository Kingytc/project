package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper6;

public class UserListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(UserListTag.class);

	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		ArrayList vecData = new ArrayList();
		ArrayList vecRow  = new ArrayList();
		int vecsize=0;
		String strId="",strName="",strGrpId="";
		try
		{
			out=pageContext.getOut();
			TagDataHelper6 tagDataHelper6=new TagDataHelper6();
			hshValues=(HashMap)tagDataHelper6.getUserList(new HashMap());
			if(hshValues!=null)
				{
					vecData = (ArrayList)hshValues.get("users_data");
				}
				//String txt_flag=(String)hshValues.get("txt_flag");
			if(vecData!=null)
			{
					vecsize = vecData.size(); 	
		
				for(int i=0;i<vecsize;i++)
				{				
					vecRow = (ArrayList)vecData.get(i);

					if(vecRow!=null)
					{
					
					strId=Helper.correctNull((String)vecRow.get(0));
					strName=Helper.correctNull((String)vecRow.get(1));
					strGrpId=Helper.correctNull((String)vecRow.get(2));
					out.println("<option value=\""+strId+"^"+strGrpId+"\">"+strId.toUpperCase()+"-"+strName.toUpperCase()+"</option>");
	
					}
				}
			}
					//Modified By HAri	- End

		}
		catch(Exception e)
		{
			log.error("exception in userlisttag.. "+e);
		}
		return EVAL_PAGE;
	}

}
