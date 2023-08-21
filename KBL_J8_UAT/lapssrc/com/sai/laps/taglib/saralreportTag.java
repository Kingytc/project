package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.Helper;



public class saralreportTag extends TagSupport 
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(saralreportTag.class);
	private static final long serialVersionUID = 1L;
	String strSector = "";
	String strTabid="";
	String strApplied="";
	String strProposal="";
	
	
	public void setTabid(String tabid)
	{
		this.strTabid = Helper.correctNull(tabid).trim();
	}
	
	public void setSector(String sector)
	{
		this.strSector = Helper.correctNull(sector).trim();
	}
	
	public void setApplied(String applied)
	{
		this.strApplied = Helper.correctNull(applied).trim();
	}
	public void setProposal(String proposal)
	{
		this.strProposal = Helper.correctNull(proposal).trim();
	}
	
	
	public int doEndTag() throws JspException
	{  
		JspWriter out = null;
		try
		{
			out = pageContext.getOut();
			
			out.println("<table width=100% border='0' cellpadding='4' cellspacing='1' class='outertable'>");
			out.println("<tr align='center'> ");
			if(strSector.equalsIgnoreCase("Corporate") && strProposal.equals("C"))
			{
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				if(strApplied.equalsIgnoreCase("E"))
				{
					if(strTabid.equals("8"))
					{
						out.print("<td class=\"tabactivenew\" ><b>");
						out.print("Account Operational Details");
						out.print("</b></td>");
					}
					else
					{
						out.println("<td class=\"sub_tab_inactive\" ><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Account Operational Details';return true;\""+
								">Account Operational Details</a>" );
						out.print("</b></td>");
					}
				}
				if(strTabid.equals("2"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Credit Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreport1','creditreport3.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Credit Report</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("3"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("<b>Inspection Report</b>");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getComInspectionReport','com_pre_SanctionInspectionReport.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Inspection Report';return true;\""+
							">Inspection Report</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("4"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Due Diligence");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Due Diligence';return true;\""+
							">Due Diligence</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("10"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Audit Observation");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getAuditorComments','com_auditobserv.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Audit Observations';return true;\""+
							">Audit Observation</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("11"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("ROC Details");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','commappmaster','getrocdetails','rocdetails.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +" onMouseOver=\"window.status='ROC Details';return true;\""+
							">ROC Details</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations");
					out.print("</b></td>");
				}
				else
				{
					
					out.println("<td class=\"sub_tab_inactive\"><b>");
				
					if(strApplied.equalsIgnoreCase("E"))
					{
						 out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','facilityremdcomments.jsp')\"");
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("1"))
					{
						out.print("<td class=\"sub_tab_active\"><b>");
						out.print("Work Flow");
						out.print("</b></td>");
					}
					else
					{
						out.println("<td class=\"sub_tab_inactive\"><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Work Flow';return true;\""+
								">Work Flow</a>" );
						out.print("</b></td>");
					}
				
				
			}
			
			
// For Adhoc proposal type
			
			else if(strSector.equalsIgnoreCase("Corporate") && strProposal.equals("H"))
			{
				
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				if(strApplied.equalsIgnoreCase("E"))
					{
							if(strTabid.equals("8"))
							{
								out.print("<td class=\"sub_tab_active\" ><b>");
								out.print("Account Operational Details");
								out.print("</b></td>");
							}
							else
							{
								out.println("<td class=\"sub_tab_inactive\" ><b>");
								out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')\"");
								out.print("onMouseOut=\"window.status='';return true;\");" +
										" onMouseOver=\"window.status='Account Operational Details';return true;\""+
										">Account Operational Details</a>" );
								out.print("</b></td>");
							}
					}
				
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations");
					out.print("</b></td>");
				}
				else
				{
					
					out.println("<td class=\"sub_tab_inactive\"><b>");
				
					if(strApplied.equalsIgnoreCase("E"))
					{
						 out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','facilityremdcomments.jsp')\"");
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("1"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Work Flow");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Work Flow';return true;\""+
							">Work Flow</a>" );
					out.print("</b></td>");
				}
			
			}
			
			// for short term loan 
			
			
			
			
			
// For short term Review Extension loan and short term loan
			
			else if(strSector.equalsIgnoreCase("Corporate") && (strProposal.equals("V") || strProposal.equals("E")))
			{
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				
				if(!strProposal.equals("V")) //for short term loan Audit observation tab is not needed
				{
						if(strTabid.equals("10"))
						{
							out.print("<td class=\"sub_tab_active\"><b>");
							out.print("Audit Observation");
							out.print("</b></td>");
						}
						else
						{
							out.println("<td class=\"sub_tab_inactive\"><b>");
							out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','comproposal','getAuditorComments','com_auditobserv.jsp')\"");
							out.print("onMouseOut=\"window.status='';return true;\");" +
									" onMouseOver=\"window.status='Audit Observations';return true;\""+
									">Audit Observation</a>" );
							out.print("</b></td>");
						}
				}
				
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations");
					out.print("</b></td>");
				}
				else
				{
					
					out.println("<td class=\"sub_tab_inactive\"><b>");
				
					if(strApplied.equalsIgnoreCase("E"))
					{
						 out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','facilityremdcomments.jsp')\"");
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("1"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Work Flow");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Work Flow';return true;\""+
							">Work Flow</a>" );
					out.print("</b></td>");
				}
			
			}
					
			
			
			else if(strSector.equalsIgnoreCase("Tertiary"))
			{
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				if(strApplied.equalsIgnoreCase("E"))
				{
					if(strTabid.equals("8"))
					{
						out.print("<td class=\"sub_tab_active\"><b>");
						out.print("Account Operational Details");
						out.print("</b></td>");
					}
					else
					{
						out.println("<td class=\"sub_tab_inactive\"><b>");
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getAccountOperationalDetails','facilityrecmdforrenewal.jsp')\"");
						out.print("onMouseOut=\"window.status='';return true;\");" +
								" onMouseOver=\"window.status='Account Operational Details';return true;\""+
								">Account Operational Details</a>" );
						out.print("</b></td>");
					}
				}
				if(strTabid.equals("2"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Credit Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreportforRetail','ops_creditreport.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Credit Report</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("3"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Inspection Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getOPSInspectionReport','ops_inspectionreport.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Inspection';return true;\""+
							">Inspection Report</a>" );
					out.print("</b></td>");
				}				
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations ");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					if(strApplied.equalsIgnoreCase("E"))
					{
						 out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','facilityremdcomments.jsp')\"");
					}
					else
					{
						out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					}
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Recommendations';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("1"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Work Flow");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
						" onMouseOver=\"window.status='General';return true;\""+
							">Work Flow</a>" );
					out.print("</b></td>");
				}
			}
			
			else if(strSector.equalsIgnoreCase("Agriculture") || strSector.equalsIgnoreCase("Agricultue"))
			{
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("2"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Credit Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreportforRetail','agr_creditreport1.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Credit Report</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("3"))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Inspection Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','appraisal','getPresanction','agr_pre_sanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Inspection Report';return true;\""+
							">Inspection Report</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("4"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Due Diligence");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getDueDiligence','agr_Duediligence1.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Due Diligence';return true;\""+
							">Due Diligence</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations ");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Recommendations';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("1"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Work Flow");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='General';return true;\""+
							">Work Flow</a>" );
					out.print("</b></td>");
				}
			}
			else if(strSector.equalsIgnoreCase("Retail"))
			{
				if(strTabid.equals("0") || strTabid.equals(""))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Loan Application Register");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
				    out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getdata','appinwardreg.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Laon Application Register';return true;\""+
							">Loan Application Register</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("6"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Facilities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdfacility','facilityrecmdforsanc.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Facilities</a>" );
					out.print("</b></td>");
				}
				
				if(strTabid.equals("7"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Securities");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Securities</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("2"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Credit Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getCreditreportforRetail','creditreport1.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Credit Report</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("3"))
				{
					out.print("<td class=\"sub_tab_active\" ><b>");
					out.print("Inspection Report");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\" ><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','Inspection','getPDCCharges','presanctionvisit.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Inspection Report';return true;\""+
							">Inspection Report</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("4"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Due Diligence");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','lapsReport','getDueDiligenceRetail','Duediligence1.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Due Diligence';return true;\""+
							">Due Diligence</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("5"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Recommendations ");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getbrrecmd','recmdforsanction.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='Credit Report';return true;\""+
							">Recommendations</a>" );
					out.print("</b></td>");
				}
				if(strTabid.equals("1"))
				{
					out.print("<td class=\"sub_tab_active\"><b>");
					out.print("Work Flow");
					out.print("</b></td>");
				}
				else
				{
					out.println("<td class=\"sub_tab_inactive\"><b>");
					out.print("<a href=\"JavaScript:gotoTab('"+ApplicationParams.getAppUrl()+"','inwardRegister','getHistorydata','inwardworflowhistory.jsp')\"");
					out.print("onMouseOut=\"window.status='';return true;\");" +
							" onMouseOver=\"window.status='General';return true;\""+
							">Work Flow</a>" );
					out.print("</b></td>");
				}
			}
			out.println("</tr>");
			out.println("</table>");
			
		}
		catch(Exception e)
		{
			log.error("exception in saralreportTag :: "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}

}