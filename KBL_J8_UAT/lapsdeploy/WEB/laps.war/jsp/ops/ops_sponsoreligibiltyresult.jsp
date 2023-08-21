<%@include file="../share/directives.jsp"%>
<%String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
			String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));%>

<html>
<head>
<title>Appraisal Confirmation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/agrpage.jsp";
		document.forms[0].submit();
	}
}
  
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="appform" method="post" class="outertable">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="31" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Check List</td>
	</tr>
</table>
<span
			style="visibility:hidden"> <lapschoice:borrowertype /></span> <lapschoice:application />
			<lapschoice:TerGovtSponsorTag pageid="2" govtsponsor="1" />
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr>
				<td valign="top">
				<table width="70%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
					<tr class="datagrid">
						<td width="50%">Based on Minimum Age</td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("Minage"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Maximum Age</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("Maxage"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Educational Qualification</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("EduQualification"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Mobility</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("Mobility"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Annual Income</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("AnnualIncome"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Overall limit</td>
						<td>&nbsp; <%if (Helper.correctNull((String) hshValues.get("Overallimit")).equals(""))
				out
						.print("<font color='red'>Facility Account Details Not Defined !");%>
						<%=Helper.correctNull((String) hshValues
									.get("Overallimit"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Term Loan eligible limit</td>
						<td>&nbsp; <%if (Helper.correctNull((String) hshValues.get("Termloanlimit"))
					.equals(""))
				out
						.print("<font color='red'>Facility Account Details Not Defined !");%>
						<%=Helper.correctNull((String) hshValues
							.get("Termloanlimit"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Working capital limit</td>
						<td>&nbsp; <%if (Helper.correctNull((String) hshValues.get("WClimit"))
					.equals(""))
				out
						.print("<font color='red'>Facility Account Details Not Defined !");%>
						<%=Helper.correctNull((String) hshValues.get("WClimit"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Subsidy Amount</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("Subsidy"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Margin</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues
									.get("Margin"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Minimum Repayment Period</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("MIN_REPAYMENT_PRD"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on Maximum Repayment Period</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("MAX_REPAYMENT_PRD"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on SHG Minimum Members</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("MIN_SHG_MEMBERS"))%></td>
					</tr>
					<tr class="datagrid">
						<td>Based on SHG Maximum Members</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("MAX_SHG_MEMBERS"))%></td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;Based on SHG Maximum Limit for a Borrower</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("SHG_LIMIT"))%></td>
					</tr>
					<tr class="datagrid">
						<td><b>SHG Details if Not Eligible</b></td>
						<td>&nbsp;</td>
					</tr>

					<%/**
			 *@ S.SATHYA MOORTHY
			 *@ purpose: for mapping the flag Values with Actual Value.
			 */

			%>
					<%!public String parseObjectValue(Object arg) {
		String returnVal = "";
		if (arg != null) {

			if (arg.equals("1"))
				returnVal = "Eligbile";
			if (arg.equals("2"))
				returnVal = "Not Eligible";
			if (arg.equals("3"))
				returnVal = "Not Applicable";
			if (arg.equals("0"))
				returnVal = "<font color='red'>Value Not Defined in the Respective Place!";
			if (arg.equals("4"))
				returnVal = "<font color='red'>Value Not Defined in the Setup!";
		} else
			returnVal = "Value Not Defined!";
		return returnVal;
	}

	%>
					<%ArrayList arrCol = (ArrayList) hshValues.get("SHG_STATUS");
			int flag = 0;
			ArrayList arrRow = new ArrayList();
			if (arrCol != null) {

				for (int i = 0; i < arrCol.size(); i++) {

					arrRow = (ArrayList) arrCol.get(i);

					if (arrRow != null && arrRow.get(2).equals("1")
							&& arrRow.get(3).equals("1")
							&& arrRow.get(4).equals("1")
							&& arrRow.get(5).equals("1")
							&& arrRow.get(5).equals("1")) {

						if (flag != 2)
							flag = 1;

					} else if (arrRow != null && arrRow.size() > 1) {
						flag = 2;
						out.print("<tr class='datagrid'><td>&nbsp;DETAILS:</td><td>&nbsp;");
						out.print("<br>Customer Id of the SHG Promoter :"
								+ arrRow.get(0));
						out.print("<br>Name of the SHG Promoter :"
								+ arrRow.get(1));
						out.print("<br>Based On SHG Minimum Age :"
								+ parseObjectValue(arrRow.get(2)));
						out.print("<br>Based On SHG Maximum Age :"
								+ parseObjectValue(arrRow.get(3)));
						out
								.print("<br>Based on SHG Educational Qualification :"
										+ parseObjectValue(arrRow.get(4)));
						//out.print("<br>Based on SHG Mobility :"+parseObjectValue(arrRow.get(5)));
						//out.print("<br>Based on SHG Annual Income :"+parseObjectValue(arrRow.get(5)));
						out.print("<br>Based on SHG Subsidy Amount :"
								+ parseObjectValue(arrRow.get(5)));
						out.print("</td></tr>");
					}

				}

			}

			%>
					<tr class="datagrid">
						<td>Based on Over All Details of SHG</td>
						<td>&nbsp; <%if (flag == 2)
				out.println("Not Eligible");
			else if (flag == 1)
				out.println("Eligible");
			else
				out.println("<span class='mantatory'>Not Applicable</span>");

			%></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="button" name="cmdsave" style="visibility:hidden;position:absolute" disabled> 
</form>
</body>
</html>
