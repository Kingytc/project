package com.sai.laps.taglib;

import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class choiceIdGenTag extends TagSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JspWriter out = null;
	String strSource = null;
	static Logger log=Logger.getLogger(choiceIdGenTag.class);
	
	public void setStrSource(String strSource)
	{
		if(strSource == null)
		{
			strSource = Helper.correctNull(strSource);
		}
		this.strSource = strSource.trim();
		out = pageContext.getOut();
	}

	public int doEndTag() throws JspException
	{  
		HashMap hshPar = new HashMap();
		try
		{	
			out = pageContext.getOut();
			
			HashMap hshRes = 
				(HashMap)EJBInvoker.executeStateLess("factglobaloptions",hshPar,"getKeys");			

			if(strSource.equalsIgnoreCase("factglbopt"))
			{
				out.print("<option selected value ='^ ' selected>--Select--</option>");
				out.print("<option selected value ='N^ '>New</option>");
			
				for(int i=0;i<hshRes.size();i++)
				{
					String strKey =Integer.toString(i+1);
					out.println("<option title=\""+strKey+"\" value=\""+strKey+"^"+hshRes.get(strKey)+"\">"+strKey+"</option>");
				}
			}
			else
			{
				for(int i=0;i<hshRes.size();i++)
				{
					String strKey =Integer.toString(i+1);
					out.print("<option value=\""+strKey+"^"+hshRes.get(strKey));
					out.print("\">"+strKey+"-"+hshRes.get(strKey)+"</option>");
				}
			}

			/*			Iterator enum = (Iterator)hshRes.keySet();
			while( enum.hasMoreElements() )
			{ 
				String strKey = (String)enum.nextElement();
				out.print("<option value=\""+strKey+"^"+hshRes.get(strKey));
				out.print("\">"+strKey+"</option>");
			}		
*/
		}
		catch(Exception ioe)
		{
			log.error("error occured"+ioe.toString());

		}
	return EVAL_PAGE;
	}
}