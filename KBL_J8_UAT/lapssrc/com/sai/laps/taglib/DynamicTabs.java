package com.sai.laps.taglib;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

public class DynamicTabs extends TagSupport 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String strSelectedParent = "";
	String strSelectedchild = "";

	public void setParentTab(String strId)
	{
		this.strSelectedParent = strId;
	}

	public void setChildTab(String strId) 
	{
		this.strSelectedchild = strId;
	}

	public int doEndTag() throws JspException 
	{
		JspWriter out = null;
		try {
			out = pageContext.getOut();
			HashMap hshParameters = new HashMap();
			hshParameters.put("strParent", strSelectedParent);
			hshParameters.put("strChild", strSelectedchild);
			HashMap hshValues = (HashMap) EJBInvoker.executeStateLess(
					"dynamictabs", hshParameters, "getChildTabs");

			ArrayList arrValues = new ArrayList();
			if (hshValues.get("arrValues") != null) {
				arrValues = (ArrayList) hshValues.get("arrValues");
			}
			if (arrValues.size() > 0) {
				out.println("<table width=\"100%\" border=\"0\" "
						+ "cellspacing=\"0\" cellpadding=\"0\">");
				out.println("<tr>");
				out.println("<td colspan=\"2\" valign=\"bottom\">");
				out
						.println("<table width=\"55%\" border=\"0\" cellspacing=\"3\" "
								+ "cellpadding=\"3\" align=\"left\">");
				out.println("<tr>");
				for (int iCtr = 0, size = arrValues.size(); iCtr < size; iCtr++) {
					ArrayList arrRow = (ArrayList) arrValues.get(iCtr);

					if (strSelectedchild.trim().equals(String.valueOf(iCtr))
							|| strSelectedchild.trim().equals("") && iCtr == 0) {
						out.println("<td class=" + "darktabcolor"
								+ " align=\"center\"><b><font size=\"1\" "
								+ "face=\"MS Sans Serif\" color=\"white"
								+ "\"> "

								+ Helper.correctNull((String) arrRow.get(1))
								+ "</font></b></td>");

					}
					else 
					{
						out.println("<td class=lighttabcolor"
						+ " align=\"center\"><b><font size=\"1\" "
						+ "face=\"MS Sans Serif\" color=\"#FFFFFF"
						+ "\"> "
						+ "<a href=\"JavaScript:parent.topFrame.callChildPage('"
						+ Helper.correctNull((String) arrRow
								.get(0))
						+ "', '"
						+ Helper.correctNull((String) arrRow
								.get(2))
						+ "', '"
						+ iCtr
						+ "')\" class=\"blackfont\">"
						+ Helper.correctNull((String) arrRow
								.get(1)) + "</a>"
						+ "</font></b></td>");
					}
				}
			}
			out.println("</tr>");
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
		} catch (Exception e) {
			throw new JspException(e.getMessage());
		}
		return EVAL_PAGE;
	}
}