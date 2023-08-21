package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class ComSecuritiestabTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ComSecuritiestabTag.class);
	private static final long serialVersionUID = 1L;
	String strTabid="";
	String strCattype="";
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setCattype(String cattype)
	{
		this.strCattype = Helper.correctNull(cattype).trim();
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			out.println("<table width=45% border=0 cellpadding=3 cellspacing=4 bgcolor=\"#DEDACF\">");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("<b>Secutites</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comsecurities','getData','com_securities.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Secutites';return true;\""+
						"class=\"blackfont\">Secutites</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("<b>Charges on Securities</b>");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comsecurities','getChargeData','comsecuritycharges.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Charges on Securities';return true;\""+
						"class=\"blackfont\">Charges on Securities</a>" );
				out.print("</b></td>");
			}
			/*if(!strCattype.equalsIgnoreCase("OPS") && strTabid.equals("3"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("<b>Collateral Security</b>");
				out.print("</b></td>");
			}
			else if(!strCattype.equalsIgnoreCase("OPS"))
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','executive','getCollateralSecurity','com_collateral.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Collateral Security';return true;\""+
						"class=\"blackfont\">Collateral Security</a>" );
				out.print("</b></td>");
			}
			
			if(strCattype.equalsIgnoreCase("OPS") && strTabid.equals("4"))
			{
				out.print("<td class=\"tabactivenew\" align=center width=\"20%\"><b>");
				out.print("<b>Collateral Security</b>");
				out.print("</b></td>");
			}
			else if(strCattype.equalsIgnoreCase("OPS"))
			{
				out.println("<td class=\"tabinactivenew\" align=center width=\"20%\"><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','adv1151','getCollateralSecurity','adv_collateralsecurity.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Collateral Security';return true;\""+
						"class=\"blackfont\">Collateral Security</a>" );
				out.print("</b></td>");
			}*/
			
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in ComSecuritiestabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}