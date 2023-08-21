package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class ComTechFeasibilitytabTag extends TagSupport 
{

	static Logger log=Logger.getLogger(ComTechFeasibilitytabTag.class);
	private static final long serialVersionUID = 1L;
	String tabId = "";
	String ssiType="";
	public void setTabid(String tabid)
	{
		tabId = tabid;
	}

	public void setTypessi(String typessi)
	{
		ssiType = typessi;
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
				out.println("<b>Product Details</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunctionTab('ssiab10_technicalfeasb.jsp','getGeneralData','TechnicalFeasibility^Nameoftheproducts^ManufacturingProcessInBrief^Noofworkingdaysinmonth^Noofshiftsinday','TechnicalFeasibility','getSSIProductData')\">");
				out.println("Product Details</a></b>");
				out.println("</td>");
			}
			if(tabid==2)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Locational Advantage</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunctionTab('ssiab10_exist_propos.jsp','getGeneralData','Absencecivicrestrictions^Marketproduct^Availabilitywater^Availabilitytransport^Proximitysourcerawmaterials^Availabilitypower^Availabilitylabour^Whetherclearanceobtainedauthority','ExistProposed','getSSIExistProposedData')\">");
				out.println("Locational Advantage</a></b>");
				out.println("</td>");
			}
			if(tabid==3)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Raw Materials</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunction1('ssiab10_product_info.jsp','getProductInformData')\">");
				out.println("Raw Materials</a></b>");
				out.println("</td>");
			}
			if(tabid==10)
			{
				out.println("<td class='sub_tab_active'>");
				out.println("<b>Utilities</b>");
				out.println("</td>");
			}
			else
			{
				out.println("<td class='sub_tab_inactive'><b>");
				out.println("<a href=\"javascript:callFunction('ssi_above10_utilities.jsp','getGeneralDetails','PowerContractedLoad^PowerConnectedLoad^PowerFutureConsumption^Water^Fuel^Others','Utilities')\">");
				out.println("Utilities</a></b>");
				out.println("</td>");
			}
			if(ssiType.equals("AB05C"))
			{
				if(tabid==5)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Compressed Air</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:;callFunction('ssi_above10_airfuel.jsp','getGeneralDetails','CompressedAir^RequirementsOfCompressedAir^ArrangementsForCompressedAir^Fuel^RequirementsOfFuel^ArrangementsForSupply^ArrangementsForCarryingRM','AirAndFuel')\">");
					out.println("Compressed Air</a></b>");
					out.println("</td>");
				}
				if(tabid==6)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Effluent</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_atmosphere.jsp','getGeneralDetails','DetailsOfAtmosphere^ObtainedPermissionForEffluents','Atmosphere')\">");
					out.println("Effluent</a></b>");
					out.println("</td>");
				}
				if(tabid==7)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Collaboration</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_collaborationdetails.jsp','getGeneralDetails','CollaborationYes^CollaborationNo','CollaborationDetails')\">");
					out.println("Collaboration</a></b>");
					out.println("</td>");
				}
				if(tabid==8)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Consultants</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_consultantdetails.jsp','getGeneralDetails','ConsultantName^ConsultantAddress^FeesPayable^ScopeOfWork^ConsultantOrganisationSetUp^PartnersInterestinConsultant','ConsultantDetails')\">");
					out.println("Consultants</a></b>");
					out.println("</td>");
				}
				if(tabid==9)
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Architect & Machinery</b>");
					out.println("</td>");
				}
				else
				{
					out.println("<td class='sub_tab_inactive'><b>");
					out.println("<a href=\"javascript:callFunction('ssi_above10_architectandfixedassets.jsp','getGeneralDetails','ArchitectName^ArchitectAddress^ScopeOfWork^RatesQuotedExpenses^FeesPayable^TimeSchedule^Penalties^PastExperianceOfArchitects^ProductionStagesinSubcontracting^AvailabilityOfMachinery^ErectionAndCommissiningOfPlant^PurposeOfProposedInvestment','ArchitectAndMachinery')\">");
					out.println("Architect & Machinery</a></b>");
					out.println("</td>");
				}
				
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