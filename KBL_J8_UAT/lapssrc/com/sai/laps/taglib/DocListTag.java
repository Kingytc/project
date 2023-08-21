package com.sai.laps.taglib;

import java.util.HashMap;
import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.tagdatahelper.TagDataHelper3;

public class DocListTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DocListTag.class);
	
	public int doEndTag() throws JspException
	{  
		HashMap hshValues=null;
		
		JspWriter out=null;
		ServletRequest request=null;
		HashMap hshRequestValues=new HashMap();
		String strDocType=null,strSubType=" ";
		ArrayList vecData = new ArrayList();
		ArrayList vecData1=new ArrayList();
		ArrayList vecRec= new ArrayList();
		ArrayList vecRec1= new ArrayList();
		try
		{
			out=pageContext.getOut();
			request=pageContext.getRequest();
			if (request.getParameter("doc_type").equals("A"))
			{
				strDocType = "A";
				
				if(Helper.correctNull((String)request.getParameter("strSubType")).equalsIgnoreCase("pre"))
					strSubType=" and doc_docsubtype='pre'";
				else
					strSubType=" and doc_docsubtype='post'";
			}
			else if (request.getParameter("doc_type").equals("I"))
			{
				strDocType = "I";
			}
			else
			{
				strDocType=request.getParameter("doc_type");
			}
			String ModuleType=request.getParameter("ModuleType");
			hshRequestValues.put("doc_type",strDocType.toUpperCase());
			hshRequestValues.put("ModuleType",ModuleType);
			hshRequestValues.put("strSubType",strSubType);
			TagDataHelper3 tagDataHelper3=new TagDataHelper3();
			hshValues=(HashMap)tagDataHelper3.getDocList(hshRequestValues);
			//hshValues=(HashMap)EJBInvoker.executeStateLess("setproducts",hshRequestValues,
				           //                          "getDocList");

			//added by balaji for aplha order on 29/03/2004
			//vecData = (ArrayList)hshValues.get("vecData");
			vecData1=(ArrayList)hshValues.get("vecData1");
	
	
//			if(vecData.size() >0)
//			{
//				for(int i=0;i<vecData.size();i++)
//				{
//					vecRec = (ArrayList)vecData.get(i);
//					String strDocCode=Helper.correctNull((String)vecRec.get(0))+"#"+Helper.correctNull((String)vecRec.get(1));
//					String strDesc=Helper.correctNull((String)vecRec.get(2));
//					strDesc=correctDoubleQuotesHtml(strDesc);
//					out.println("<option value=\'"+strDocCode+"\'>"+strDesc+"</option>");
//				}
//			}
			
			if(vecData1!=null && vecData1.size()>0)
			{
				
				for(int i=0;i<vecData1.size();i++)
				{
					System.out.println("(ArrayList)vecData1.get(i)"+(ArrayList)vecData1.get(i));
					vecRec1 = (ArrayList)vecData1.get(i);
					String strcode=Helper.correctNull((String)vecRec1.get(0))+"#"+Helper.correctNull((String)vecRec1.get(1));
					String strDesc=Helper.correctNull((String)vecRec1.get(2));
					strDesc=correctDoubleQuotesHtml(strDesc);
			        out.println("<option value=\'"+strcode+"\'>"+Helper.correctNull((String)vecRec1.get(2))+"</option>");
				}
			}
			

		/*	enum1=(Iterator)hshValues.keySet();
			while(enum1.hasNext())
			{
				String strDocCode=(String)enum1.next();
				String strDesc=(String)hshValues.get(strDocCode);
				strDesc=correctDoubleQuotesHtml(strDesc);
				String strDate=(String)hshValues.get("doc_create_date");
				log.info("strDocCode -->"+strDocCode);
				out.println("<option value=\'"+strDocCode+"\'>"+strDesc+"</option>");
			}*/


		}
		catch(Exception e)
		{
			log.error("exception in DocListTag.. "+e);
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
				sbf.replace(i,i+1,"&quot;");
			}
		}
		return sbf.toString();
	}


}
