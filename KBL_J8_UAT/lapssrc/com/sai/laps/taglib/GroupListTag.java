package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper4;

public class GroupListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(GroupListTag.class);
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		JspWriter out=null;
		int vecsize=0;
		String strId="",strName="",strRights="",strDiscreteId="",strlimt="",straccess="";
		ArrayList vecData = new ArrayList();
		ArrayList vecRow  = new ArrayList();

		try
		{

			out=pageContext.getOut();
			TagDataHelper4 tagDataHelper4=new TagDataHelper4();
			hshValues=(HashMap)tagDataHelper4.getData(new HashMap());
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setgroups",new HashMap(),
				                    //                 "getData");
		/*	enum1=(Iterator)hshValues.keySet();
			while(enum1.hasNext())
			{
				String strId=(String)enum1.next();
				arrValues=(ArrayList)hshValues.get(strId);
				String strName=(String)arrValues.get(0);
				strName=correctDoubleQuotesHtml(strName);
				String strRights=(String)arrValues.get(1);
				String strDiscreteId=(String)arrValues.get(2);
				log.info("Discretete pawers---"+strDiscreteId);
				out.println("<option value=\""+strId+"^"+strRights+"^"+strDiscreteId+"\">"+strName+"</option>");
			}*/

			// Modified By HAri -Start
				

				if(hshValues!=null)
				{
					vecData = (ArrayList)hshValues.get("groups_data");
				}

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
					strName=correctDoubleQuotesHtml(strName);
					strRights=Helper.correctNull((String)vecRow.get(2));
					strDiscreteId=Helper.correctNull((String)vecRow.get(3));
					strlimt=Helper.correctNull((String)vecRow.get(4));
					straccess=Helper.correctNull((String)vecRow.get(5));
					out.println("<option value=\""+strId+"^"+strRights+"^"+strDiscreteId.toUpperCase()+"^"+strlimt+"^"+straccess+"\">"+strName.toUpperCase()+"</option>");
	
					}
				}
			}
					//Modified By HAri	- End


		}
		catch(Exception e)
		{
			log.error("exception in grouplisttag.. "+e);
		}
		return EVAL_PAGE;
	}
	private String correctDoubleQuotesHtml(String str)
	{
		StringBuffer sbf=new StringBuffer(str);
		for(int i=0;i<sbf.length();i++)
		{
			if(sbf.charAt(i)=='"')
			{
				sbf.replace(i,i+1,"&quote");
			}
		}
		return sbf.toString();
	}


}
