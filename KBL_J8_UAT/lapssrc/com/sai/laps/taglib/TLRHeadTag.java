package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.Helper;

public class TLRHeadTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TLRHeadTag.class);
	String pageId = "";
	String strReviewOf="";
	String strValuesin="";
	public void setPageid(String pageid)
	{
		pageId = pageid;
	}
	public void setReviewof(String strreviewof)
	{
		strReviewOf = strreviewof;
	}
	public void setValuesin(String valuesin)
	{
		this.strValuesin = Helper.correctNull(valuesin).trim();
	}
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		int pageid = Integer.parseInt(pageId);	
		try
		{
			out = pageContext.getOut();
			
			
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable'>");
			out.println("<tr> ");
			out.println("<td  align=\"center\">");
			out.println("<span id=\"idvalues\" >");
			if(strValuesin.equals("L"))
			{
				
				out.println("<FONT SIZE=\"4\" color=\"red\"><b>(All Values are in Lacs) </b></font>");
			}
			else if(strValuesin.equals("C"))
			{
				out.println("<FONT SIZE=\"4\" color=\"red\"><b>(All Values are in Crores) </b></font>");
			}
			else if(strValuesin.equals("A"))
			{
				out.println("<FONT SIZE=\"4\" color=\"red\"><b>(All Values are in Rs.) </b></font>");
			}
			out.println("</span>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class='outertable' align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table width=100% border=0 cellpadding=3 cellspacing=1 class='outertable'>");
		    out.println("<tr align='center'> ");
			out.println("<td");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>General Details</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('reviewnotetypeofreview.jsp','reviewtermloantwo','getTypeReviewTermLoan')\">");
				out.println("General Details</a></b>");
			}
			out.println("</td>");
		if(strReviewOf.equals("2"))		
		{
				
			out.println("<td");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Facilities</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_facilitydetails.jsp','reviewtermloantwo','getTermLoanReviewFacilities')\">");
				out.println("Facilities</a></b>");
			}
			out.println("</td>");
			
    	    out.println("<td");
	       	if(pageid==3)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Promoter</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_promoterdetails.jsp','reviewtermloan','getPromotersData')\">");
				out.println("Promoter</a></b>");
			}
			out.println("</td>");
			
			 out.println("<td");
		       	if(pageid==4)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Securities</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('tlr_secdetails.jsp','reviewtermloan','getSecuritiesData')\">");
					out.println("Securities</a></b>");
				}
				out.println("</td>");
				
				out.println("<td");
		       	if(pageid==5)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Banking Details</b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('tlr_bankdetails.jsp','reviewtermloantwo','getBankingArrangementData')\">");
					out.println("Banking Details</a></b>");
				}
			out.println("</td>");
				
				out.println("<td");
			       	if(pageid==14)
					{
						out.println("class='sub_tab_active'>");
						out.println("<b>Internal Credit Rating</b>");
					}
					else
					{
						out.println("class='sub_tab_inactive'>");
						out.println("<b><a href=\"javascript:callOtherLink('tlr_internalrating.jsp','reviewtermloantwo','getInternalRatingData')\">");
						out.println("Internal Credit Rating</a></b>");
					}
				out.println("</td>");
				out.println("<td");
		       	if(pageid==6)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Financial</b>");//corrected by Zahoorunnisa.S
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('reviewnotecorporatefinancial.jsp','reviewtermloan','getReviewFinancial')\">");
					out.println("Financial</a></b>");//corrected by Zahoorunnisa.S
				}
			out.println("</td>");
			
			out.println("<td");
	       	if(pageid==7)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Comments</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_briefbackground.jsp','reviewtermloantwo','getBirefBackgroundData')\">");
				out.println("Comments</a></b>");
			}
		out.println("</td>");			
			out.println("</tr>");
			out.println("<tr align='center'> ");
			out.println("<td");
	       	if(pageid==8)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Operations of Account</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_opercdaccount.jsp','reviewtermloantwo','getCDAccountData')\">");
				out.println("Operations of Account</a></b>");
			}
		out.println("</td>");
		
			out.println("<td");
		   	if(pageid==9)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Audit observations</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_auditobservation.jsp','reviewtermloan','getAuditorObservationData')\">");
				out.println("Audit observations</a></b>");
			}
		out.println("</td>");
		
			out.println("<td");
		   	if(pageid==10)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Terms & Conditions</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_termsandconditions.jsp','reviewtermloantwo','getTermAndConditionsData')\">");
				out.println("Terms & Conditions</a></b>");
			}
	    	out.println("</td>");			
	    	out.println("<td");
		   	if(pageid==11)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Compliance</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_compliance.jsp','reviewtermloantwo','getComplianceData')\">");
				out.println("Compliance</a></b>");
			}
	    	out.println("</td>");
	    	out.println("<td");
		   	if(pageid==12)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Proposal</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_proposal.jsp','reviewtermloantwo','getProposalData')\">");
				out.println("Proposal</a></b>");
			}
	    	out.println("</td>");
	    	out.println("<td");
		   	if(pageid==13)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Workflow</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('reviewnoteworkflowhistroy.jsp','commworkflow','getTermLoanReviewHistory')\">");
				out.println("Workflow</a></b>");
			}
	    	out.println("</td>");
		}else if(strReviewOf.equals("1"))
		{
					out.println("<td");
					if(pageid==2)
					{
						out.println("class='sub_tab_active'>");
						out.println("<b>Facilities</b>");
					}
					else
					{
						out.println("class='sub_tab_inactive'>");
						out.println("<b><a href=\"javascript:callOtherLink('tlr_facilitydetails.jsp','reviewtermloantwo','getTermLoanReviewFacilities')\">");
						out.println("Facilities</a></b>");
					}
					out.println("</td>");
					
		    	    out.println("<td");
			       	if(pageid==3)
					{
						out.println("class='sub_tab_active'>");
						out.println("<b>Promoter</b>");
					}
					else
					{
						out.println("class='sub_tab_inactive'>");
						out.println("<b><a href=\"javascript:callOtherLink('tlr_promoterdetails.jsp','reviewtermloan','getPromotersData')\">");
						out.println("Promoter</a></b>");
					}
					out.println("</td>");
					
					 out.println("<td");
				       	if(pageid==4)
						{
							out.println("class='sub_tab_active'>");
							out.println("<b>Securities</b>");
						}
						else
						{
							out.println("class='sub_tab_inactive'>");
							out.println("<b><a href=\"javascript:callOtherLink('tlr_secdetails.jsp','reviewtermloan','getSecuritiesData')\">");
							out.println("Securities</a></b>");
							
						}
						out.println("</td>");
						
						out.println("<td");
				       	if(pageid==6)
						{
							out.println("class='sub_tab_active'>");
							out.println("<b>Finacial</b>");
							
						}
						else
						{
							out.println("class='sub_tab_inactive'>");
							out.println("<b><a href=\"javascript:callOtherLink('reviewnotesmefinancial.jsp','reviewtermloan','getReviewFinancial')\">");
							out.println("Finacial</a></b>");
							
						}
					out.println("</td>");
					
					out.println("<td");
			       	if(pageid==7)
					{
						out.println("class='sub_tab_active'>");
						out.println("<b>Comments</b>");
						
					}
					else
					{
						out.println("class='sub_tab_inactive'>");
						out.println("<b><a href=\"javascript:callOtherLink('tlr_briefbackground.jsp','reviewtermloantwo','getBirefBackgroundData')\">");
						out.println("Comments</a></b>");
						
					}
				out.println("</td>");
				
				out.println("<td");
		       	if(pageid==8)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Operations of Account</b>");
					
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('tlr_opercdaccount.jsp','reviewtermloantwo','getCDAccountData')\">");
					out.println("Operations of Account</a></b>");
					
				}
			out.println("</td>");
					
			out.println("<td");
		   	if(pageid==9)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Audit observations</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_auditobservation.jsp','reviewtermloantwo','getAuditorObservationData')\">");
				out.println("Audit observations</a></b>");
				
			}
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr> ");
		out.println("<td");
		if(pageid==10)
		{
			out.println("class='sub_tab_active'>");
			out.println("<b>Terms & Conditions</b>");
			
		}
		else
		{
			out.println("class='sub_tab_inactive'>");
			out.println("<b><a href=\"javascript:callOtherLink('tlr_termsandconditions.jsp','reviewtermloantwo','getTermAndConditionsData')\">");
			out.println("Terms & Conditions</a></b>");
			
		}
		out.println("</td>");
		
		out.println("<td");
		if(pageid==11)
		{
			out.println("class='sub_tab_active'>");
			out.println("<b>Compliance</b>");
			
		}
		else
		{
			out.println("class='sub_tab_inactive'>");
			out.println("<b><a href=\"javascript:callOtherLink('tlr_compliance.jsp','reviewtermloantwo','getComplianceData')\">");
			out.println("Compliance</a></b>");
			
		}
		out.println("</td>");
		out.println("<td");
		if(pageid==12)
		{
			out.println("class='sub_tab_active'>");
			out.println("<b>Proposal</b>");
			
		}
		else
		{
			out.println("class='sub_tab_inactive'>");
			out.println("<b><a href=\"javascript:callOtherLink('tlr_proposal.jsp','reviewtermloantwo','getProposalData')\">");
			out.println("Proposal</a></b>");
			
		}
		    out.println("</td>");
			out.println("<td");
			if(pageid==13)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Workflow</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('reviewnoteworkflowhistroy.jsp','commworkflow','getTermLoanReviewHistory')\">");
				out.println("Workflow</a></b>");
				
			}
			out.println("</td>");
			
		}
		else if(strReviewOf.equals("0"))
		{
			out.println("<td");
			if(pageid==2)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Facilities</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_facilitydetails.jsp','reviewtermloantwo','getTermLoanReviewFacilities')\">");
				out.println("Facilities</a></b>");
				
			}
			out.println("</td>");
			 out.println("<td");
		       	if(pageid==4)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Securities</b>");
					
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('tlr_secdetails.jsp','reviewtermloan','getSecuritiesData')\">");
					out.println("Securities</a></b>");
					
				}
				out.println("</td>");
				
				out.println("<td");
		       	if(pageid==7)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Comments</b>");
					
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"javascript:callOtherLink('tlr_briefbackground.jsp','reviewtermloantwo','getBirefBackgroundData')\">");
					out.println("Comments</a></b>");
					
				}
			out.println("</td>");
			
			out.println("<td");
	       	if(pageid==8)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Operations of Account</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_opercdaccount.jsp','reviewtermloantwo','getCDAccountData')\">");
				out.println("Operations of Account</a></b>");
				
			}
		out.println("</td>");
				
		out.println("<td");
	   	if(pageid==9)
		{
			out.println("class='sub_tab_active'>");
			out.println("<b>Audit observations</b>");
			
		}
		else
		{
			out.println("class='sub_tab_inactive'>");
			out.println("<b><a href=\"javascript:callOtherLink('tlr_auditobservation.jsp','reviewtermloan','getAuditorObservationData')\">");
			out.println("Audit observations</a></b>");
			
		}
			out.println("</td>");
			out.println("<td");
		if(pageid==11)
		{
			out.println("class='sub_tab_active'>");
			out.println("<b>Compliance</b>");
			
		}
		else
		{
			out.println("class='sub_tab_inactive'>");
			out.println("<b><a href=\"javascript:callOtherLink('tlr_compliance.jsp','reviewtermloantwo','getComplianceData')\">");
			out.println("Compliance</a></b>");
			
		}
		out.println("</td>");
		out.println("<td");
			if(pageid==12)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Proposal</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('tlr_proposal.jsp','reviewtermloantwo','getProposalData')\">");
				out.println("Proposal</a></b>");
				
			}
			out.println("</td>");
			out.println("<td");
			if(pageid==13)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Workflow</b>");
				
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"javascript:callOtherLink('reviewnoteworkflowhistroy.jsp','commworkflow','getTermLoanReviewHistory')\">");
				out.println("Workflow</a></b>");
				
			}
			out.println("</td>");
		 }
			out.println("</tr>");
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		}
		catch(Exception e)
		{
			log.error("exception in TLRHeadTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}

