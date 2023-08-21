package com.sai.laps.taglib.tabtaglib;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.ServletRequest;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class setproductstabcorpTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 773969476776685812L;
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(setproductstabcorpTag.class);
	String strTabid="";
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	public int doEndTag() throws JspException
	{
		JspWriter out = null;
		ServletRequest request = null;
		HttpSession session1=pageContext.getSession();
		try
		{
			out = pageContext.getOut();
			request = pageContext.getRequest();
			String strCorpModule=Helper.correctNull((String)request.getParameter("strCorpModule"));
			String strFacIntDef=Helper.correctNull((String)session1.getAttribute("com_facintdef"));
			
			String strSvanidhi=Helper.correctNull((String)session1.getAttribute("com_svanidhi"));
			if(("").equalsIgnoreCase(strSvanidhi)){
				strSvanidhi=Helper.correctNull((String)session1.getAttribute("com_svanidhi1"));
			}
			if(strCorpModule.equalsIgnoreCase(""))
			{
				strCorpModule=Helper.correctNull((String)session1.getAttribute("hidcorp_module"));
			}
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class=\"outertable\">");
			out.println("<tr> ");
			if(strTabid.equals("1"))
			{
				out.print("<td class=\"main_tab_active\" align=center><b>");
				out.print("Facility");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','corporatefacility','getData','setfacility.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Facility';return true;\""+
						"class=\"blackfont\">Facility</a>" );
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
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setusedby','getFacUsedby','setfacilityusedby.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Used By';return true;\""+
						"class=\"blackfont\">Used By</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("3"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Delegated Powers");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','corporatefacility','getComFacilityDelegatedPowers','setfacilitydelegation.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Delegated Powers';return true;\""+
						"class=\"blackfont\">Delegated Powers</a>" );
				out.print("</b></td>");
			}
			if(!strFacIntDef.equalsIgnoreCase("M"))
			{
				if(strTabid.equals("4"))
				{
					out.print("<td class=\"main_tab_active\" align=center ><b>");
					out.print("Int.&amp; Tenors");
					out.print("</b></td>");
				}
				else
				{
					if(strFacIntDef.equalsIgnoreCase("F"))
					{
						out.println("<td class=\"main_tab_inactive\" align=center ><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','corpinterestTerm','setfacilityintterms.jsp?wrk_flowtype1=fixed')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Int.&amp; Tenors';return true;\""+
								"class=\"blackfont\">Int.&amp; Tenors</a>" );
						out.print("</b></td>");
					}
					else
					{
						out.println("<td class=\"main_tab_inactive\" align=center ><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setproducts','corpinterestTerm','setfacilityintterms.jsp?wrk_flowtype1=floating')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Int.&amp; Tenors';return true;\""+
								"class=\"blackfont\">Int.&amp; Tenors</a>" );
						out.print("</b></td>");
					}
				}
			}
			if(strTabid.equals("5"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Other Details");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','corporatefacility','getDataotherdet','otherdetails.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Other Details';return true;\""+
						"class=\"blackfont\">Other Details</a>" );
				out.print("</b></td>");
			}
			if(strTabid.equals("6"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Range Deviation");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','combanking','getrangedeviation','set_rangedeviation.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Range Deviation';return true;\""+
						"class=\"blackfont\">Range Deviation</a>" );
				out.print("</b></td>");
			}
			if(strCorpModule.equalsIgnoreCase("a"))
			{
				if(strTabid.equals("17"))
				{
					out.print("<td class=\"main_tab_active\" align=center><b>");
					out.print("Agri Parameters");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"main_tab_inactive\" align=center><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setinterest','getAgrimarginData','set_AgriParametersmargin.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Agri Parameters';return true;\""+
							"class=\"blackfont\">Agri Parameters</a>" );
					out.print("</b></td>");
				}
			}
			if(strTabid.equals("8"))
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
			
			if(strTabid.equals("18"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Collateral Security");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','setinterest','getSet_corpcollateralSecurity','set_corpcollateralsecurity.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Collateral Security';return true;\""+
						"class=\"blackfont\">Collateral Security</a>" );
				out.print("</b></td>");
			}
			if(!("").equalsIgnoreCase(strSvanidhi)){
				if(("3").equalsIgnoreCase(strSvanidhi) ){	
			if(strTabid.equals("19"))
			{
				out.print("<td class=\"main_tab_active\" align=center ><b>");
				out.print("Svanidhi Eligibility");
				out.print("</b></td>");
			}
			else
			{
				out.println("<td class=\"main_tab_inactive\" align=center ><b>");
				out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','corporatefacility','get_svanidhi','set_svanidhiEligibilty.jsp')\"");
				out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='Svanidhi Eligibility';return true;\""+
						"class=\"blackfont\">Svanidhi Eligibility</a>" );
				out.print("</b></td>");
			}}}
			//Vindhya begin
			if(strTabid.equals("20"))
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
			//Vindhya end			
			out.println("<input type=\"hidden\" name=\"strCorpModule\" size=\"40\" readonly value=\""+strCorpModule+"\">");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in setproductstabcorpTag :: "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}