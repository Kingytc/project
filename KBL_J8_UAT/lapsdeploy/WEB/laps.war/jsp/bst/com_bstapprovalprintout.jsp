<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String[] strdesc = { "&nbsp;", "&nbsp;", "Net Sales", "PAT", "TNW","CURRENT RATIO", "TOL/TNW RATIO" };
	String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));
	String strValuesin = "";

	if (Valuesin.equals("L")) {
		strValuesin = "(Rs. in Lacs)";
	} else if (Valuesin.equals("C")) {
		strValuesin = "(Rs. in Crores)";
	}
	ArrayList arrRow =null;
	ArrayList arrCol = null;
%>
<html>
<head>
<title>Broad Terms Approval Printout</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form name="frmbstprint" method=post>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	bgcolor="#FFFFFF" align="center">
	<tr>
		<td colspan="5" align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
	</tr>
	<tr>
		<td colspan="5" align="center"><b>Branch / Office - <%=Helper.correctNull((String) hshValues.get("orgname"))%></b>
		<hr />
		</td>
	</tr>
	<tr>
		<td colspan="5" align="center"><b><font size="2">APPROVAL OF BROAD
		TERMS OF THE PROPOSAL</font></b></td>
	</tr>
	<tr>
		<td align="left" width="39%"><b>Ref .No </b>&nbsp;&nbsp;&nbsp; <%=Helper.correctNull((String) hshValues.get("refno"))%></td>
		<td width="1%">&nbsp;</td>
		<td align="right" colspan="3"><b>Date </b>&nbsp;&nbsp;&nbsp; <%=Helper.correctNull((String) hshValues.get("datebst"))%></td>
	</tr>
	<tr>
		<td width="39%"><b>Name of the Account</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues
									.get("companyname"))%></td>
	</tr>
	<tr>
		<td width="39%"><b>Account with</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues
									.get("brnlocation"))%></td>
	</tr>
	<tr>
		<td width="39%"><b>Group </b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("group"))%></td>
	</tr>
	<tr>
		<td width="39%"><b>Existing connection or new connection</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull(
							(String) hshValues.get("combst_custype"))
							.equalsIgnoreCase("1") ? "Existing Connection"
					: Helper.correctNull(
							(String) hshValues.get("combst_custype")).equals(
							"2") ? "New Connection" : ""%></td>
	</tr>
	<tr>
		<td width="39%"><b>Credit Rating</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.formatTextAreaData((String) hshValues
							.get("creditrating"))%></td>
	</tr>
	<tr valign="top">
		<td width="39%"><b>Backgroud of Promoters</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("group"))%>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
							.get("promotorsbackground_comments"))%></p>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="5">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="39%"><B>Present Banking Arrangement</B></td>
				<td width="1%"><b>:</b></td>
				<td width="10%"><%=Helper.correctNull((String) hshValues.get("cb_banktype"))%></td>
				<td width="50%">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td width="30%"><B>Lead Bank</B></td>
						<td width="1%"><b>:</b></td>
						<td width="69%"><%=Helper.correctNull((String) hshValues.get("cb_leadbank"))%></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<%
	if(Helper.correctNull((String) hshValues.get("banktype")).trim().equals("2") ||
			Helper.correctNull((String) hshValues.get("banktype")).trim().equals("4") ||
			Helper.correctNull((String) hshValues.get("banktype")).trim().equals("6") ||
			Helper.correctNull((String) hshValues.get("banktype")).trim().equals("7"))
	{
	%>
	<tr valign="top">
		<td colspan="5">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="50%" colspan="3">&nbsp;</td>
				<td width="50%">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td align="center"><B>Our Share (%)</B></td>
						<td align="center"><b>Existing</b></td>
						<td align="center"><b>Proposed</b></td>
					</tr>
					<tr>
						<td>Fund Based</td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("cb_fundexist"))))%>&nbsp;%</td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("cb_fundproposed"))))%>&nbsp;%</td>
					</tr>
					<tr>
						<td>Non Fund Based</td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("cb_nonfundexist"))))%>&nbsp;%</td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("cb_nonfundproposed"))))%>&nbsp;%</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<% }%>
	<tr>
		<td colspan="5"><b>Details of Existing Credit Facilities with the
		bankers/FIs</b></td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center" width="22%"><b>Name of the Bank/FIs</b></td>
				<td align="center" width="22%"><b>Nature of Facilities</b></td>
				<td align="center" width="12%"><b>Limit</b></td>
				<td align="center" width="15%"><b>Applicable ROI/Commission</b></td>
				<td align="center" width="15%"><b>Presently Charged ROI/Commission</b></td>
			</tr>
			<%
            arrRow = new ArrayList();
			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("CreditFacilities");
			if(arrRow != null && arrRow.size() > 0) {
				int count=0;
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if (Helper.correctNull((String) arrCol.get(1))
							.equalsIgnoreCase("0")) {
						count=0;
					%>
			<tr>
				<td valign="top"><b><%=Helper.correctNull((String) arrCol.get(2))%></b>&nbsp;</td>
				<td valign="top"><b><%=Helper.correctNull((String) arrCol.get(3))%></b>&nbsp;
				</td>
				<td valign="top" align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;
				</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;
				</td>
			</tr>
			<%} else if (!Helper.correctNull((String) arrCol.get(1)).equalsIgnoreCase("0")) {
						%>
			<tr>
				<%if (count == 0) {
						%>
				<td>&nbsp;</td>
				<td colspan="4"><b>&gt;&gt;Sub Limit</b></td>
			</tr>
			<tr>
				<%}
				%>
				<td valign="top"><%//=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
				<td valign="top" align="right">(<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>)&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
			</tr>
			<% count++;
		}
			}
			}

			%>
		</table>
		</div>
		</td>
	</tr><br>
	<tr>
		<td width="39%"><b>Brief financials </b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<%
	ArrayList arr = null;
			int arrsize = 0;

			if (hshValues != null) 
			{
				arr = (ArrayList) hshValues.get("arrFinancial");
			}

			if (arr != null)
			{
				arrsize = arr.size();

			}

			ArrayList g1 = null;
			for (int l = 0; l < 7; l++)
			{
				int arrSize = 0;

				if (l < arrsize)
				{
					g1 = (ArrayList) arr.get(l);

					if (g1 != null) 
					{
						arrSize = g1.size();
					}
				}
				if (arrSize > 0)
				{
					if(l==0)
			  {
			  %>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0">
			<tr>
				<td align="center" width="26%">&nbsp;</td>
				<td align="center" width="26%"><b>Year ended</b></td>
				<td align="center" width="23%"><b>Year ended</b></td>
				<td align="center" width="21%"><b>Year ended</b></td>
			</tr>
			<%
			} 
					else if(l==1)
					{
					%>
			<tr>
				<td width="30%"><%=Helper.correctNull((String) g1.get(3))%></td>
				<td align="center" width="26%"><%=Helper.correctNull((String) g1.get(0))%></td>
				<td align="center" width="23%"><%=Helper.correctNull((String) g1.get(1))%></td>
				<td align="center" width="21%"><%=Helper.correctNull((String) g1.get(2))%></td>
			</tr>
			<%
			}
					else
					{ 
					%>
			<tr>
				<td width="30%"><b><%=Helper.correctNull((String) g1.get(3))%></b></td>
				<td align="right" width="26%"><%=Helper.correctNull((String) g1.get(0))%></td>
				<td align="right" width="23%"><%=Helper.correctNull((String) g1.get(1))%></td>
				<td align="right" width="21%"><%=Helper.correctNull((String) g1.get(2))%></td>
			</tr>
			<%
				} 
			}
			}
			%>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td><b>Comments on Financials</b></td>.
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.correctNull((String) hshValues.get("comments"))%></p>
		</td>
	</tr>
	<tr valign="top">
		<td width="39%"><b>Nature of the Project</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
							.get("projectnature_comments"))%></p>
		</td>
	</tr>
	<%ArrayList vecOthers = null;
			vecOthers = (ArrayList) hshValues.get("vecOthers");

			ArrayList vecIncurred = new ArrayList();
			ArrayList vecTobeIncurred = new ArrayList();
			ArrayList vecTotal = new ArrayList();

			String dblTotalCapital1 = "";
			String dblTotalCapital2 = "";
			String dblTotalCapital3 = "";
			String dblTotalCost1 = "";
			String dblTotalCost2 = "";
			String dblTotalCost3 = "";
			String dblTotal1 = "";
			String dblTotal2 = "";
			String dblTotal3 = "";

			int vecsize = 0;
			if (hshValues != null) {
				vecIncurred = (ArrayList) hshValues.get("vecIncurred");
				vecTobeIncurred = (ArrayList) hshValues.get("vecTobeIncurred");
				vecTotal = (ArrayList) hshValues.get("vecTotal");

				if (hshValues.size() > 0) {
					dblTotalCapital1 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital1"))));
					dblTotalCapital2 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital2"))));
					dblTotalCapital3 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCapital3"))));
					dblTotalCost1 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost1"))));
					dblTotalCost2 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost2"))));
					dblTotalCost3 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotalCost3"))));
					dblTotal1 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal1"))));
					dblTotal2 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal2"))));
					dblTotal3 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblTotal3"))));
				}
			} else {
				hshValues = new HashMap();
			}
			if (vecIncurred != null) {
				vecsize = vecIncurred.size();
			}

			String strIncurred[] = new String[28];
			String strTobeIncurred[] = new String[28];
			String strTotal[] = new String[28];
			String strOthers[] = new String[28];

			if (vecsize == 0) {
				for (int i = 0; i < 28; i++) {
					strIncurred[i] = "";
					strTobeIncurred[i] = "";
					strTotal[i] = "";
					strOthers[i] = "";
				}
			} else {
				for (int i = 0; i < 28; i++) {
					strIncurred[i] = (Helper.formatDoubleValue(Double.parseDouble((String) vecIncurred.get(i))));
					strTobeIncurred[i] = (Helper.formatDoubleValue(Double.parseDouble((String) vecTobeIncurred.get(i))));
					strTotal[i] = (Helper.formatDoubleValue(Double.parseDouble((String) vecTotal.get(i))));
					strOthers[i] = Helper.correctNull((String) vecOthers.get(i));
				}
			}

			%>
	<tr>
		<td colspan="5"><b>Cost of the Project</b></td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td width="53%"><b>Cost of Project</b></td>
				<td width="20%" align="center"><b>Already incurred </b></td>
				<td width="16%" align="center"><b>To be incurred</b></td>
				<td width="11%" align="center"><b>Total</b></td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid1" value="1"> Land</td>
				<td width="20%" align="right"><%=strIncurred[0]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[0]%></td>
				<td width="11%" align="right"><%=strTotal[0]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid2" value="2"> Site
				Development</td>
				<td width="20%" align="right"><%=strIncurred[1]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[1]%></td>
				<td width="11%" align="right"><%=strTotal[1]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid3" value="3">
				Buildings</td>
				<td width="20%" align="right"><%=strIncurred[2]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[2]%></td>
				<td width="11%" align="right"><%=strTotal[2]%>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4">Plant and Machinery (incl. Stores and Spares)</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid4" value="4">
				Imported CIF</td>
				<td width="20%" align="right"><%=strIncurred[3]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[3]%></td>
				<td width="11%" align="right"><%=strTotal[3]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid5" value="5"> Import
				Duty</td>
				<td width="20%" align="right"><%=strIncurred[4]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[4]%></td>
				<td width="11%" align="right"><%=strTotal[4]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid6" value="6">
				Indigenous</td>
				<td width="20%" align="right"><%=strIncurred[5]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[5]%></td>
				<td width="11%" align="right"><%=strTotal[5]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid7" value="7">
				Transportation Charges</td>
				<td width="20%" align="right"><%=strIncurred[6]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[6]%></td>
				<td width="11%" align="right"><%=strTotal[6]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid8" value="8"> Other
				Fixed Assests</td>
				<td width="20%" align="right"><%=strIncurred[7]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[7]%></td>
				<td width="11%" align="right"><%=strTotal[7]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid9" value="9"> Tech
				Knowhow, Engg. Fee and Expenses</td>
				<td width="20%" align="right"><%=strIncurred[8]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[8]%></td>
				<td width="11%" align="right"><%=strTotal[8]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid10" value="10">
				Preliminary and pre-operative Expenses</td>
				<td width="20%" align="right"><%=strIncurred[9]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[9]%></td>
				<td width="11%" align="right"><%=strTotal[9]%>&nbsp;</td>
			</tr>
			<%if (!strOthers[10].equalsIgnoreCase("")) {%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid11" value="11"> <%=strOthers[10]%>
				</td>
				<td width="20%" align="right"><%=strIncurred[10]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[10]%></td>
				<td width="11%" align="right"><%=strTotal[10]%>&nbsp;</td>
			</tr>
			<%}
			if (!strOthers[11].equalsIgnoreCase("")) {%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid12" value="12"> <%=strOthers[11]%>
				</td>
				<td width="20%" align="right"><%=strIncurred[11]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[11]%></td>
				<td width="11%" align="right"><%=strTotal[11]%>&nbsp;</td>
			</tr>
			<%}
			if (!strOthers[12].equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid13" value="13"> <%=strOthers[12]%>
				</td>
				<td width="20%" align="right"><%=strIncurred[12]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[12]%></td>
				<td width="11%" align="right"><%=strTotal[12]%>&nbsp;</td>
			</tr>
			<%}
			if (!strOthers[13].equalsIgnoreCase("")) {%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid14" value="14"> <%=strOthers[13]%>
				</td>
				<td width="20%" align="right"><%=strIncurred[13]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[13]%></td>
				<td width="11%" align="right"><%=strTotal[13]%>&nbsp;</td>
			</tr>
			<%}

			%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid15" value="15">
				Provision for Contingencies Incl. Prices escalation etc.</td>
				<td width="20%" align="right"><%=strIncurred[14]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[14]%></td>
				<td width="11%" align="right"><%=strTotal[14]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><b>Total Capital Cost of the Scheme</b></td>
				<td width="20%" align="right"><b><%=dblTotalCapital1%></b></td>
				<td width="16%" align="right"><b><%=dblTotalCapital2%></b></td>
				<td width="11%" align="right"><b><%=dblTotalCapital3%></b></td>
			</tr>
			<tr>
				<td width="53%"><b> <input type="hidden" name="rowid16" value="16">
				Margin for Working capital </b></td>
				<td width="20%" align="right"><b> <%=strIncurred[15]%></b></td>
				<td width="16%" align="right"><b> <%=strTobeIncurred[15]%></b></td>
				<td width="11%" align="center"><b> <%=strTotal[15]%></b></td>
			</tr>
			<tr>
				<td width="53%"><b>Total Cost of the Scheme</b></td>
				<td width="20%" align="right"><b><%=dblTotalCost1%></b></td>
				<td width="16%" align="right"><b><%=dblTotalCost2%></b></td>
				<td width="11%" align="right"><b><%=dblTotalCost3%></b></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr><br>
	<tr>
		<td colspan="5"><b>Means of Funding</b></td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
			<%if (!strOthers[10].equalsIgnoreCase("")) {%>
			<%}
			if (!strOthers[11].equalsIgnoreCase("")) {%>
			<%}
			if (!strOthers[12].equalsIgnoreCase("")) {

			%>
			<%}
			if (!strOthers[13].equalsIgnoreCase("")) {%>
			<%}

			%>
			<tr>
				<td width="53%"><b>Source of Finance</b></td>
				<td width="21%" align="right"><b>Already Tied Up</b></td>
				<td width="16%" align="right"><b>To be Tied Up</b></td>
				<td width="10%" align="right"><b>Total</b></td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid17" value="17">
				Equity</td>
				<td width="21%" align="right"><%=strIncurred[16]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[16]%></td>
				<td width="10%" align="right"><%=strTotal[16]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid18" value="18">
				Promoters contribution</td>
				<td width="21%" align="right"><%=strIncurred[17]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[17]%></td>
				<td width="10%" align="right"><%=strTotal[17]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid19" value="19">
				Loans</td>
				<td width="21%" align="right"><%=strIncurred[18]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[18]%></td>
				<td width="10%" align="right"><%=strTotal[18]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid20" value="20">
				Borrowings from Promoters/ Directors. Friends and relatives</td>
				<td width="21%" align="right"><%=strIncurred[19]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[19]%></td>
				<td width="10%" align="right"><%=strTotal[19]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid21" value="21">
				Internal Generation</td>
				<td width="21%" align="right"><%=strIncurred[20]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[20]%></td>
				<td width="10%" align="right"><%=strTotal[20]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid22" value="22">
				Bonds / Debentures and others debt instruments</td>
				<td width="21%" align="right"><%=strIncurred[21]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[21]%></td>
				<td width="10%" align="right"><%=strTotal[21]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid23" value="23">
				Deferred Credit from Suppliers/Bankers</td>
				<td width="21%" align="right"><%=strIncurred[22]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[22]%></td>
				<td width="10%" align="right"><%=strTotal[22]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid24" value="24">
				Venture Capital</td>
				<td width="21%" align="right"><%=strIncurred[23]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[23]%></td>
				<td width="10%" align="right"><%=strTotal[23]%>&nbsp;</td>
			</tr>
			<tr>
				<td width="53%"><input type="hidden" name="rowid25" value="25">
				Other Sources (Pl. specify)</td>
				<td width="21%" align="right"><%=strIncurred[24]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[24]%></td>
				<td width="10%" align="right"><%=strTotal[24]%>&nbsp;</td>
			</tr>
			<%if (!strOthers[25].equalsIgnoreCase("")) {%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid26" value="26"> <%=strOthers[25]%>
				</td>
				<td width="21%" align="right"><%=strIncurred[25]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[25]%></td>
				<td width="10%" align="right"><%=strTotal[25]%></td>
			</tr>
			<%}
			if (!strOthers[26].equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid27" value="27"> <%=strOthers[26]%>
				</td>
				<td width="21%" align="right"><%=strIncurred[26]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[26]%></td>
				<td width="10%" align="right"><%=strTotal[26]%></td>
			</tr>
			<%}
			if (!strOthers[27].equalsIgnoreCase("")) {%>
			<tr>
				<td width="53%"><input type="hidden" name="rowid28" value="28"> <%=strOthers[27]%>
				</td>
				<td width="21%" align="right"><%=strIncurred[27]%></td>
				<td width="16%" align="right"><%=strTobeIncurred[27]%></td>
				<td width="10%" align="right"><%=strTotal[27]%></td>
			</tr>
			<%}%>
			<tr>
				<td width="53%"><b>Total</b></td>
				<td width="21%" align="right"><b><%=dblTotal1%></b></td>
				<td width="16%" align="right"><b><%=dblTotal2%></b></td>
				<td width="10%" align="right"><b><%=dblTotal3%></b></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr><br>
	<tr>
		<td colspan="5"><b>Details of Facilities:</b></td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
			<tr>
				<td align="center" width="15%" rowspan="2"><b>Facility Head</b></td>
				<td align="center" width="20%" rowspan="2"><b>Facility </b></td>
				<td align="center" width="12%" rowspan="2"><b>Existing Limits</b></td>
				<td align="center" width="12%" rowspan="2"><b>Proposed Limits</b></td>
				<td align="center" width="8%" rowspan="2"><b>Margin(%)</b></td>
				<td align="center" colspan="2"><b>Interest / Commission</b></td>
				<td align="center" width="8%" rowspan="2"><b>Period (in Months)</b></td>
			</tr>
			<tr>
				<td align="center" width="12%"><b>As per Credit Rating</b></td>
				<td align="center" width="13%"><b>Proposed</b></td>
			</tr>
			<%arrRow = new ArrayList();
			 arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrFacility");
			String strSno = "";
			double dblamtexist = 0.0;
			double dblamtproposed = 0.0;
			if (arrRow != null && arrRow.size() > 0) {
				int count = 0;
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);
					strSno = Helper.correctNull((String) arrCol.get(13));
					if (Helper.correctNull((String) arrCol.get(12))
							.equalsIgnoreCase("0")) {
						dblamtexist = dblamtexist
								+ Double.parseDouble(Helper.correctDouble((String) arrCol.get(3)));
						dblamtproposed = dblamtproposed
								+ Double.parseDouble(Helper.correctDouble((String) arrCol.get(4)));
						count = 0;

						%>
			<tr>
				<td valign="top"><b><%=Helper.correctNull((String) arrCol.get(14))%>&nbsp;</b></td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(15))%>&nbsp;</td>
				<td align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%></td>
				<td align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(7))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(8))%>&nbsp;</td>
			</tr>
			<%} else if (!Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("0")) {
						%>
			<tr>
				<%if (count == 0) {
						%>
				<td colspan="8"><b>&gt;&gt;Sub Limit</b></td>
			</tr>
			<tr>
				<%}
				%>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(14))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(15))%>&nbsp;</td>
				<td align="right" valign="top">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>)</td>
				<td align="right" valign="top">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>)</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(7))%></td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td right valign="top"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(8))%></td>
			</tr>
			<%count++;
					}
				}
				%>
			<tr bgcolor="#FFFFFF">
				<td colspan="2" align="right"><b>Total</b></td>
				<td align="right" width="12%">&nbsp;<%=Helper.formatDoubleValue(dblamtexist)%></td>
				<td align="right" width="12%">&nbsp;<%=Helper.formatDoubleValue(dblamtproposed)%></td>
				<td align="right" colspan="4">&nbsp;</td>
			</tr>
			<%} else {

			%>
			<tr>
				<td align="center" colspan="8"><b>No Data Found</b></td>
			</tr>
			<%}

			%>
		</table>
		</div>
		</td>
	</tr><br>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center" width="20%"><b>Facility </b></td>
				<td align="center" width="12%"><b>Proposed Limits</b></td>
				<td align="center" width="15%"><b>Interest reset</b></td>
				<td align="center" width="22%"><b>Purpose</b></td>
			</tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrFacility");
			if (arrRow != null && arrRow.size() > 0) {
				int count=0;
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if (Helper.correctNull((String) arrCol.get(12))
							.equalsIgnoreCase("0")) {
					%>
			<tr>
				<td valign="top"><b><%=Helper.correctNull((String) arrCol.get(14))%>&nbsp;</b></td>
				<td valign="top"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>&nbsp;</td>
				<td valign="top">
				<p><%=Helper.correctNull((String) arrCol.get(10))%>&nbsp;</p>
				</td>
				<td valign="top">
				<p><%=Helper.correctNull((String) arrCol.get(9))%>&nbsp;</p>
				</td>
			</tr>
			<%} else if (!Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("0")) {
						%>
			<tr>
				<%if (count == 0) {
						%>
				<td colspan="4"><b>&gt;&gt;Sub Limit</b></td>
			</tr>
			<tr>
				<%}
				%>
				<td valign="top"><%=Helper.correctNull((String) arrCol.get(14))%>&nbsp;</td>
				<td valign="top">(<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%>)&nbsp;</td>
				<td valign="top">
				<p><%=Helper.correctNull((String) arrCol.get(10))%>&nbsp;</p>
				</td>
				<td valign="top">
				<p><%=Helper.correctNull((String) arrCol.get(9))%>&nbsp;</p>
				</td>
			</tr>
			<%count++;
		}
			}
			}

			%>
		</table>
		</div>
		</td>
	</tr>
	<br>
	<tr>
		<td width="39%"><b>Repayment terms</b></td>
		<td width="1%">&nbsp;</td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0">
			<tr valign="top">
				<td width="29%" align="center" valign="top"><b>Facility Name</b></td>
				<td width="10%" align="center" valign="top"><b>Proposed Limit</b></td>
				<td width="61%" valign="top" align="center"><b>Repayment Terms</b></td>
			</tr>
			<%arrRow = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrTermComments");
			String strtype = "";
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					strtype = Helper.correctNull((String) arrCol.get(0));
					if (Helper.correctNull((String) arrCol.get(0))
							.equalsIgnoreCase("repayment")) {

						%>
			<tr valign="top">
				<td width="29%" valign="top"><%=Helper.correctNull((String) arrCol.get(1))%></td>
				<td width="10%" valign="top" align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(3))))%></td>
				<td width="61%">
				<p><%=Helper.formatTextAreaData((String) arrCol
										.get(2))%></p>
				</td>
			</tr>
			<%}
				}
			} else {%>
			<tr>
				<td colspan="3" align="center"><b>No Data Found</b></td>
			</tr>
			<%}

			%>
		</table>
		</div>
		</td>
	</tr>
	<br>
	<tr valign="top">
		<td width="39%"><b>Upfront/Processing Fees <%=strValuesin%></b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("procfees"))%></td>
	</tr><br><br>
	<tr>
		<td colspan="5"><b>Customer profitability,(in case of exisiting
		accounts)</b></td>
	</tr>
	<tr>
		<td colspan="4" align="right"><b><%=strValuesin%></b></td>
		<td width="20%">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="80%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="83%"><b>1.&nbsp; Commission earned on bills
				purchased/discounted</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("bstcpbillscommission"))))%></td>
			</tr>
			<tr>
				<td width="83%"><b>2.&nbsp; Processing Charges </b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("bstcpprocesscharges"))))%></td>
			</tr>
			<tr>
				<td width="83%"><b>3.&nbsp; Commission on LC/LG</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("bstcplgcommission"))))%></td>
			</tr>
			<tr>
				<td colspan="2"><b>4.&nbsp; Credit balances in </b></td>
			</tr>
			<tr>
				<td width="83%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.&nbsp; SB</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) hshValues
													.get("bstcpsb"))))%></td>
			</tr>
			<tr>
				<td width="83%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;CD</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) hshValues
													.get("bstcpcd"))))%></td>
			</tr>
			<tr>
				<td colspan="2"><b>5.&nbsp; Term deposits</b></td>
			</tr>
			<tr>
				<td width="83%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.&nbsp;Through
				own sources</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("bstcpownsources"))))%></td>
			</tr>
			<tr>
				<td height="22" width="83%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&nbsp;Through
				thrid Party</b></td>
				<td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("bstcpthirdparty"))))%></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<br>
	<tr valign="top">
		<td width="39%"><b>Primary Security</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0">
			<tr>
				<td width="40%" align="center" valign="top"><b>Security Description</b></td>
				<td width="20%" align="center" valign="top"><b>Value of Security</b></td>
				<td width="15%" valign="top" align="center"><b>Value as on</b></td>
			</tr>
		<%int primecnt = 0;
			arrRow = new ArrayList();
			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrSecurity");

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					if (Helper.correctNull((String) arrCol.get(7))
							.equalsIgnoreCase("Primary")) {
						primecnt++;

						%>
						<tr>
				<td><%=Helper.formatTextAreaData((String) arrCol
										.get(3))%></td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>
				<td><%=Helper.correctNull((String) arrCol
										.get(5))%>
				</td>
			      </tr>
				<%}
				}
			}if(primecnt == 0){ %>
			<tr>
				<td colspan="3" align="center"><b>No Data Found</b></td>
			</tr>
			<%}
			%>
		</table>
		</div>
		</td>
	</tr><br>
	<tr valign="top">
		<td width="39%"><b>Collateral security</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0">
			<tr>
				<td width="40%" align="center" valign="top"><b>Security Description</b></td>
				<td width="20%" align="center" valign="top"><b>Value of Security</b></td>
				<td width="15%" valign="top" align="center"><b>Value as on</b></td>
			</tr>
			<% int collcnt = 0;
			arrRow = new ArrayList();
			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrSecurity");

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					if (Helper.correctNull((String) arrCol.get(7))
							.equalsIgnoreCase("Collateral")) {
						collcnt++;

						%>
		<tr>
				<td><%=Helper.formatTextAreaData((String) arrCol
										.get(3))%></td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>
				<td><%=Helper.correctNull((String) arrCol
										.get(5))%>
				</td>
			      </tr>
				<%}
				}
			}if(collcnt == 0){ %>
			<tr>
				<td colspan="3" align="center"><b>No Data Found</b></td>
			</tr>
			<%}
			%>
		</table>
		</div>
		</td>
	</tr>
	<br>
	<tr valign="top">
		<td width="39%"><b>Personal Guarantee/Corporate Guarantee</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
							.get("guarantee_comments"))%></p>
		</td>
	</tr>
	<br>
	<tr valign="top">
		<td width="39%"><b>Prepayment Terms</b></td>
		<td width="1%">&nbsp;</td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" align="right"><b><%=strValuesin%></b></td>
	</tr>
	<tr>
		<td colspan="5">
		<div id="top">
		<table width="100%" border="0">
			<tr valign="top">
				<td width="29%" align="center"><b>Facility Name</b></td>
				<td width="10%" align="center"><b>Proposed Limit</b></td>
				<td width="61%" valign="top" align="center"><b>Prepayment Terms</b></td>
			</tr>
			<%arrRow = new ArrayList();
			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrTermComments");

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					if (Helper.correctNull((String) arrCol.get(0))
							.equalsIgnoreCase("prepayment")) {

						%>
			<tr valign="top">
				<td width="29%" valign="top"><%=Helper.correctNull((String) arrCol.get(1))%></td>
				<td width="10%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(3))))%></td>
				<td width="61%" valign="top">
				<P><%=Helper.formatTextAreaData((String) arrCol
										.get(2))%></P>
				</td>
			</tr>
			<%}
				}
			} else {

			%>
			<tr>
				<td colspan="3" align="center"><b>No Data Found</b></td>
			</tr>
			<%}%>
		</table>
		</div>
		</td>
	</tr>
	<br>
	<tr>
		<td width="39%" valign="top"><b>Whether conforms to Loan Policy </b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues.get("loanpolicy_comments"))%></p>
		</td>
	</tr>
	<br>
	<tr>
		<td width="39%"><b>Whether company/proprietor/any partner/director
		appears in RBI/CIBIL/ECGC defaculter list</b></td>
		<td width="1%"><b>:</b></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.correctNull((String) hshValues
							.get("cd_comments"))%></p>
		</td>
	</tr>
	<br>
	<tr>
		<td colspan="5"><b>Comments</b></td>
	</tr>
	<%if (!Helper.formatTextAreaData(
					(String) hshValues.get("branch_comments")).equals("")) {

				%>
	<tr>
		<td colspan="5"><b>Branch :</b></td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
								.get("branch_comments"))%></p>
		</td>
	</tr>
	<%}
			if (!Helper.formatTextAreaData(
					(String) hshValues.get("region_comments")).equals("")) {

				%>
	<tr>
		<td colspan="5"><b>Region :</b></td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
								.get("region_comments"))%></p>
		</td>
	</tr>
	<%}
			if (!Helper.formatTextAreaData(
					(String) hshValues.get("zonal_comments")).equals("")) {

				%>
	<tr>
		<td colspan="5"><b>FGMO :</b></td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
								.get("zonal_comments"))%></p>
		</td>
	</tr>
	<%}
			if (!Helper.formatTextAreaData(
					(String) hshValues.get("central_comments")).equals("")) {

				%>
	<tr>
		<td colspan="5"><b>Central Office :</b></td>
	</tr>
	<tr>
		<td colspan="5">
		<p><%=Helper.formatTextAreaData((String) hshValues
								.get("central_comments"))%></p>
		</td>
	</tr>
	<%}

			%>
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5"><%=Helper.formatTextAreaData((String) hshValues
							.get("signatures"))%></td>
	</tr>
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr>
</table>
<br>
</form>
</body>
</html>

