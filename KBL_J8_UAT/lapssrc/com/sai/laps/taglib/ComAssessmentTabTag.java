package com.sai.laps.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class ComAssessmentTabTag extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8403562746188638675L;
	static Logger log=Logger.getLogger(ComAssessmentTabTag.class);
	/**
	 * 
	 */
	String subtabId = "";
	String assessmentType = "";
	public void setSubtabid(String subtabid)
	{
		subtabId = subtabid;
	}
	public void setAssessmenttype(String assessmenttype)
	{
		assessmentType = assessmenttype;
	}
	public int doEndTag() throws JspException
	{  
		
		JspWriter out = null;
		
		int pageid = Integer.parseInt(subtabId);	
		try
		{
			
			out = pageContext.getOut();
				
			out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\">");
			out.println("<tr>");
			out.println("<td>");
			
			out.println("<table border=\"0\" cellpadding=\"3\" cellspacing=\"1\">");
			out.println("<tr align=\"center\"> ");
			
			out.println("<td");
			if(pageid==1)
			{
				out.println("class='sub_tab_active'>");
				out.println("<b>Assessment Type</b>");
			}
			else
			{
				out.println("class='sub_tab_inactive'>");
				out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getAssessmentType','com_assessmenttype.jsp','')\">");
				out.println("Assessment Type</a></b>");
			}
			out.println("</td>");
			
			if(pageid==2)
			{
				
				if(assessmentType.equalsIgnoreCase("TO"))
				{	
					out.println("<td");
					out.println("class='sub_tab_active'>");
					out.println("<b>Turn Over</b>");
				}
				else if(assessmentType.equalsIgnoreCase("MPBF1"))
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>Flexible Bank Finance</b>");
				}
				else if(assessmentType.equalsIgnoreCase("PBF2"))
				{
					out.println("<td class='sub_tab_active'>");
					out.println("<b>NBFC 1</b>");
				}
				else if(assessmentType.equalsIgnoreCase("PBF3"))
				{
					out.println("<td  class='sub_tab_active'>");
					out.println("<b>NBFC 2</b>");
				}
				out.println("</td>");
			}
			else
			{
				if(assessmentType.equalsIgnoreCase("TO"))
				{
					out.println("<td  class='sub_tab_inactive'>");
					out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getDataComment','com_loanreqcomment.jsp?type=1&pageval=TO','')\">");
					out.println("Turn Over</a></b>");
				}
				else if(assessmentType.equalsIgnoreCase("MPBF1"))
				{
					out.println("<td  class='sub_tab_inactive'>");
					out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getDataComment','com_loanreqcomment.jsp?type=1&pageval=MPBF1','')\">");
					out.println("Flexible Bank Finance</a></b>");
				}
				else if(assessmentType.equalsIgnoreCase("PBF2"))
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getDataComment','com_loanreqcomment.jsp?type=1&pageval=PBF2','')\">");
					out.println("NBFC 1</a></b>");
				}
				else if(assessmentType.equalsIgnoreCase("PBF3"))
				{
					out.println("<td class='sub_tab_inactive'>");
					out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getDataComment','com_loanreqcomment.jsp?type=1&pageval=PBF3','')\">");
					out.println("NBFC 2</a></b>");
				}
				out.println("</td>");
			}
			
			if(assessmentType.equalsIgnoreCase("CBM"))
			{
				out.println("<td");
				if(pageid==6)
				{
					out.println("class='sub_tab_active'>");
					out.println("<b>Cash Budget Method </b>");
				}
				else
				{
					out.println("class='sub_tab_inactive'>");
					out.println("<b><a href=\"#\" onclick=\"gototab('comproposal','getCashBudget','com_cashbudget.jsp?pageval=CBM&tabid=3','')\">");
					out.println("Cash Budget Method </a></b>");
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
			log.error("exception in ComAssessmentTabTag.. "+e);
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}