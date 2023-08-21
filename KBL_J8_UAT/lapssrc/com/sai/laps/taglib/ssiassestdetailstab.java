package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

public class ssiassestdetailstab extends TagSupport 
{

	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ssiassestdetailstab.class);
	String tabId = "";
	String ssiType="";
	public void setTabid(String tabid)
	{
		tabId = tabid;
	}

	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int tabid = Integer.parseInt(tabId);	
		try
		{
			out = pageContext.getOut();
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class='outertable'>");
			out.println("<tr align='center'> ");
			
			if(tabid==1)
			{
				out.println("<td class=\"sub_tab_active\">");
				out.println("<b>Land&nbsp;&amp;Building</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\"><b>");
				out.println("<a href=\"javascript:callFunction('ssi_appendix2_landbuilding.jsp','getGeneralDetails','LandLocation^LandArea^LandFreeHoldLeaseHold^PurchasePriceOfLand^RentForLeaseLand^LandTermsOfLease^LandYearlyGroundRent^BuildingLocation^BuildingOwnedOrLease^PurchasePriceOfBuilding^RentForLeaseOrRentedBuilding^BuildingTermsOfLease','AppendixIILandAndBuilding')\" >");
				out.println("Land&nbsp;&amp;Building</a></b>");
				out.println("</td>");
			}			
			if(tabid==3)
			{
				out.println("<td class=\"sub_tab_active\">");
				out.println("<b>Building Proposed</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\"><b>");
				out.println("<a href=\"javascript:callFunction('ssi_appendix2_proposedbuilding.jsp','getAnnexure2ProposedBuilding','','AppendixIIProposedBuilding')\" >");
				out.println("Building Proposed</a></b>");
				out.println("</td>");
			}
			if(tabid==4)
			{
				out.println("<td class=\"sub_tab_active\">");
				out.println("<b>Equipment Details</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\"><b>");
				out.println("<a href=\"javascript:callFunction('ssi_appendix2_machinerydetails.jsp','getAnnexure2MachineryDetails','','AnnexureIIMachineryDetails')\" >");
				out.println("Equipment Details</a></b>");
				out.println("</td>");
			}
			if(tabid==5)
			{
				out.println("<td class=\"sub_tab_active\">");
				out.println("<b>Vehicle Details</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\"><b>");
				out.println("<a href=\"javascript:callVehicleDetails()\" >");
				out.println("Vehicle Details</a></b>");
				out.println("</td>");
			}
			if(tabid==6)
			{
				out.println("<td class=\"sub_tab_active\">");
				out.println("<b>Valuation Entry</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class=\"sub_tab_inactive\"><b>");
				out.println("<a href=\"javascript:callValuationEntry()\" >");
				out.println("Valuation Entry</a></b>");
				out.println("</td>");
			}			
		}
		catch(Exception e)
		{
			log.error("exception in PrdHeaderTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}