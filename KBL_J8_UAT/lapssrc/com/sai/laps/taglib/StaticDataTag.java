package com.sai.laps.taglib;

import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.Helper;
import com.sai.laps.helper.RefTableManager;
import com.sai.laps.helper.ReferenceTableDAO;
import com.sai.laps.tagdatahelper.TagDataHelper7;

public class StaticDataTag extends TagSupport
{
	static Logger log=Logger.getLogger(StaticDataTag.class);
	private static final long serialVersionUID = 1L;
	String apptype;
	String tagType;
	
	ReferenceTableDAO rtDAO = new ReferenceTableDAO();
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
	}
	public void settagType(String tagType)
	{
		this.tagType=tagType;
	}
	
	public int doEndTag() throws JspException
	{
		try
		{
			HttpSession httpSession=pageContext.getSession();
			JspWriter out=pageContext.getOut();
			ServletRequest request = null;
			request = pageContext.getRequest();
			String appno="";
			appno=Helper.correctNull(request.getParameter("appno"));
			ArrayList arrRow=new ArrayList();
			if(apptype.length()!=0)
			{
				if((apptype.equals("245")||apptype.equals("246")||apptype.equals("154")||apptype.equals("223"))&&(tagType.equalsIgnoreCase("pa"))){
					 arrRow = rtDAO.getcreditsaleReferenceData(apptype,tagType);
	
				}
				else if((apptype.equals("245") || apptype.equals("246")) && !tagType.equals(""))
				{
					 arrRow = rtDAO.getcreditsaleReferenceData(apptype,tagType);
				}
				else if((apptype.equals("154")||apptype.equals("223")) && (!tagType.equalsIgnoreCase("pa"))){
					 arrRow = rtDAO.getcreditsaleReferenceData(apptype,tagType);
	
				}else if((apptype.equals("11"))){
					 arrRow = rtDAO.getGovtSchemeReferenceData(apptype,tagType,appno);
	
				}
				else if((apptype.equals("270") || apptype.equals("271") || apptype.equals("272") || apptype.equals("273") || apptype.equals("274") || apptype.equals("275")) && tagType.equals(""))
				{
					 arrRow = rtDAO.getGovtSchemeReferenceData(apptype,tagType,appno);
				}
				else{
					arrRow = RefTableManager.getCodeAndDescription(apptype,"STATIC");
				}
			if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					ArrayList arrCol=(ArrayList)arrRow.get(i);
					String strId = Helper.correctNull((String)arrCol.get(0));
					String strName = Helper.correctNull((String)arrCol.get(1));
					if(Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
							Helper.correctNull((String)httpSession.getAttribute("strappstatus")).equalsIgnoreCase("cr"))
					{
						out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
					}
					else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Y"))
					{
						if(apptype.equalsIgnoreCase("223")){
							if(tagType!=null && tagType.equalsIgnoreCase("child")){
								if(!strId.equalsIgnoreCase("SF") && !strId.equalsIgnoreCase("NC"))
								   out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
							}
							else{
								out.println("<option  title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
							}
						}
						
						else if(apptype.equalsIgnoreCase("224") && tagType!=null &&  tagType.equalsIgnoreCase("child")){
								out.println("<option title=\""+strName+"\" value=\""+strId+"-0\">"+strName+"</option>");
						}

					  else if(apptype.equalsIgnoreCase("210")){
							out.println("<option  title=\""+strName+"\" value=\""+strId+"\">"+strId+"-"+strName+"</option>");
						}
					  else if(apptype.equalsIgnoreCase("283")){
							out.println("<option  title=\""+strName+"\" value=\""+strId+"\">"+strId+"-"+strName+"</option>");
						}
					  else if(apptype.equalsIgnoreCase("211")){
							out.println("<option  title=\""+strName+"\" value=\""+strId+"\">"+strId+"-"+strName+"</option>");
						}
						else{
							out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
						}
					}
					else{
						out.println("<option title=\""+strName+"\" value=\""+strId+"\">"+strName+"</option>");
					}
				}
			}
			}
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataTag.. "+e);
		}
		return EVAL_PAGE;
	}
}




