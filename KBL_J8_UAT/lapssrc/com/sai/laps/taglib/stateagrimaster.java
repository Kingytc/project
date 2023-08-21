package com.sai.laps.taglib;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.RefTableManager;
import com.sai.laps.tagdatahelper.TagDataHelper5;

public class stateagrimaster extends TagSupport
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(stateagrimaster.class);
	String apptype;
	String appval;
	public String getAppval() {
		return appval;
	}
	public void setAppval(String appval) {
		this.appval = appval;
	}
	public void setApptype(String apptype)
	{
		this.apptype=apptype;
	}
	public int doEndTag() throws JspException
	{
		try
		{
			JspWriter out=pageContext.getOut();
			HttpSession httpSession=pageContext.getSession();
			ResultSet rs=null;
			if(apptype.length()!=0)
			{
				//ArrayList arrRow = RefTableManager.getCodeAndDescription(apptype,"STATIC");
				
				
				HashMap hshRequestValues = new HashMap();
				hshRequestValues.put("apptype",apptype);
				hshRequestValues.put("appval",appval);
				
				TagDataHelper5 tagDataHelper5=new TagDataHelper5();
				//hshValues=(HashMap)tagDataHelper5.getsolvencyProcessChargesID(hshRequestValues);	
				ArrayList vecCol = new ArrayList();
				ArrayList vecRow = new ArrayList();
					rs = DBUtils.executeLAPSQuery("selagriunitcostmasterschstateType^"+FwHelper.correctNull((String)hshRequestValues.get("apptype"))+"^"+FwHelper.correctNull((String)hshRequestValues.get("appval")));
					while (rs.next()) {
						vecCol = new ArrayList();
						for (int i = 0; i < 3; i++) {
							vecCol.add(rs.getString(i + 1));
						}
						vecRow.add(vecCol);
					}
					
					hshRequestValues.put("vecRow", vecRow);
					
				
				vecRow = (ArrayList)hshRequestValues.get("vecRow");
				
					
				
				
				if(vecRow!=null && vecRow.size()>0)
				{
					for(int i=0;i<vecRow.size();i++)
					{
						ArrayList arrCol=(ArrayList)vecRow.get(i);
						
						String strId = Helper.correctNull((String)arrCol.get(0));
						String strName = Helper.correctNull((String)arrCol.get(1));
						
							out.println("<option value=\""+strId+"\">"+strName+"</option>");
						
						
					}
				}
			}
			log.info("End of While Loop");
		}
		catch(Exception e)
		{
			log.error("exception in StaticDataNewTag.. "+e);
		}
		return EVAL_PAGE;
	}
}
