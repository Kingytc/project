package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class ComActivitytabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ComActivitytabTag.class);
	String tabId = "";
	String ssiType="";
	public void setTabid(String tabid)
	{
		tabId = tabid;
	}

	public void setSsitype(String ssitype)
	{
		ssiType = ssitype;
	}
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int tabid = Integer.parseInt(tabId);	
		try
		{
			out = pageContext.getOut();
			out.println("<table width='100%' border='0' cellpadding='3' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");
			
			if(tabid==1)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Industrial/Business Activity</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunction('ssi_above10_industryactivity.jsp','getGeneralDetails','ExistingIndustrialActivity^ProposedIndustrialActivity','IndustryActivity')\">");
				out.println("Industrial/Business Activity </a></b>");
				out.println("</td>");
			}
			if(tabid==2)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Manufacturing & Trading Activity</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunction2('ssi_comactivities.jsp')\">");
				out.println("Manufacturing & Trading Activity </a></b>");
				out.println("</td>");
			}
			if(tabid==3)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Existing Finance</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunction1('ssiab10_sourcesoffunds.jsp','getSourcesOfFundsData')\">");
				out.println("Existing Finance</a></b>");
				out.println("</td>");
			}
			if(!ssiType.equalsIgnoreCase("LS10L"))
			{
				if(tabid==4)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Arrears in Statutory Payments</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction1('ssiab10_arrears.jsp','hidGetData')\">");
					out.println("Arrears in Statutory Payments</a></b>");
					out.println("</td>");
				}
			
				if(tabid==5)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Name of Associate Concern(s)</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_associate.jsp','getGeneralDetails','NatureofAssociationandAmountInvested^NatureofActivity^ItemsTraded/Manufactured^TurnoverandProfitduringpreceding3years','Associate')\">");
					out.println("Name of Associate Concern(s)</a></b>");
					out.println("</td>");
				}
			
				if(tabid==6)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Human Resources</b>");
					out.println("</td>");
				}
				else 
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_employment.jsp','getProjectDetails','','Employment')\">");
					out.println("Human Resources</a></b>");
					out.println("</td>");
				}
			}
			else
			{
				if(tabid==7 && ssiType.equalsIgnoreCase("LS10L"))
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Other Details</b>");
					out.println("</td>");
				}
				else if(ssiType.equalsIgnoreCase("LS10L"))
				{	
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_upto10lakh_staffemployed.jsp','getGeneralDetails','NoOfStaffPresentlyEmployed^NoOfStaffProposedEmployed^SourcesOfSupply^LocationOfMarket^PurposeOfLoan^AmountOfLoan','Upto10LakhStaffRMLoanDetails')\">");
					out.println("Other Details</a></b>");
					out.println("</td>");
				}
			}
			if(ssiType.equalsIgnoreCase("AB05C"))
			{
				if(tabid==8)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Management</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above5crore_promoterdetails.jsp','getGeneralDetails','MainPromoter^LtdCompanyPromoter^MemorandumArticlesofAssociation^AuditedBalanceSheet^CopyOfAgreements','PromoterDetails')\">");
					out.println("Management</a></b>");
					out.println("</td>");
				}
				if(tabid==9)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>ShareHolding</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_shareholder.jsp','getGeneralDetails','Shareholding^Promoters^F%^OtherMajorGroups^N%^InstitutionsControlling5%EquityShares^TenLargestPreferenceShareHolders^NoOfEquityPreferenceShareHolders','ShareHolder')\">");
					out.println("ShareHolding</a></b>");
					out.println("</td>");
				}
				if(tabid==10)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Staff Details</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above5crore_staffdetails.jsp','getStaffDetails','','StaffDetails')\">");
					out.println("Staff Details</a></b>");
					out.println("</td>");
				}
			}
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

