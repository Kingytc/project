package com.sai.laps.taglib.tabtaglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class setproductstabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 773969476776685812L;
	static Logger log=Logger.getLogger(setproductstabTag.class);
	/**
	 * 
	 */
	String strTabid="";
	String strPrdType="";
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	public void setPrdtype(String prdtype)
	{
		this.strPrdType = Helper.correctNull(prdtype);
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class=\"outertable\">");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Products");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getData','setproducts.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Products';return true;\""+
						"class=\"blackfont\">Products</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("2"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Used By");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setusedby','getData','produsedby.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Used By';return true;\""+
						"class=\"blackfont\">Used By</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("3"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Authority");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getAuthorityData','setprdauth.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Authority';return true;\""+
						"class=\"blackfont\">Authority</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("4"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Documents");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getDocData','setprddoc.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Documents';return true;\""+
						"class=\"blackfont\">Documents</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("5"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Flowpoints");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getWorkflowData','setprdworkflow.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Flowpoints';return true;\""+
						"class=\"blackfont\">Flowpoints</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("6"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Charges");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setinterest','getProcessData','prodprocesscharges.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Charges';return true;\""+
						"class=\"blackfont\">Charges</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("7"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Delegated Powers");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','prdsanclimit','getData','prodsanclimit.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Delegated Powers';return true;\""+
						"class=\"blackfont\">Delegated Powers</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("8"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Int. &amp; Terms");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','interestTerm','setintterms.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Int. &amp; Terms';return true;\""+
						"class=\"blackfont\">Int. &amp; Terms</a>" );
				out.print("</b></td>");
			}
			if(!(strPrdType.equalsIgnoreCase("pG")||strPrdType.equalsIgnoreCase("aH")||strPrdType.equalsIgnoreCase("pR")))
			{
				if(strTabid.equals("9"))
				{
					out.print("<td class=\"main_tab_active\" align=center><b>");
					out.print("Repayment Capacity");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"main_tab_inactive\" align=center><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setinterest','getIncomeData','prodrepaycapacity.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Repayment Capacity';return true;\""+
							"class=\"blackfont\">Repayment Capacity</a>" );
					out.print("</b></td>");
				}
			}
			if(strTabid.equals("10"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Margin");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setinterest','getMarginData','prodMarginAmount.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Margin';return true;\""+
						"class=\"blackfont\">Margin</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("11"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Activity Code");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getPrdAcitivityCodeData','prodactivitycode.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Activity Code';return true;\""+
						"class=\"blackfont\">Activity Code</a>" );
				out.print("</b></td>");
			}
			
			if(strTabid.equals("12"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Terms and Conditions");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','getSetTermsandConditions','prodtermsandcondition.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Terms and Conditions';return true;\""+
						"class=\"blackfont\">Terms and Conditions</a>" );
				out.print("</b></td>");
			}
			
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in setproductstabTag :: "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}