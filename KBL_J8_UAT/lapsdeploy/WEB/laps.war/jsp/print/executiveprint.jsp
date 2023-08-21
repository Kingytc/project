<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList arryCol_grpcon = null;
	ArrayList operinfo = (ArrayList) hshValues.get("oper_info");
	ArrayList arrSubFac = new ArrayList();
	ArrayList arrSubFacRecords = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrData = new ArrayList();

	String strOwnership = Helper.correctNull((String) hshValues
			.get("comapp_ownership"));
	String strProposalvalue = Helper.correctNull((String) hshValues
			.get("proposalvaluesin"));
	String strOwner = Helper.correctNull((String) hshValues
			.get("comapp_ownership"));
	if (strProposalvalue.equalsIgnoreCase("C"))
		strProposalvalue = "Crores";
	else
		strProposalvalue = "Lacs";

	String strSanctauth = Helper.correctNull((String) hshValues
			.get("exec_sancauth"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Executive Summary Print</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/executivereport.css"
	type="text/css">
<script>
function callPageBreak()
{
	var varspan=document.getElementsByTagName('span');
	var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	//var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=page-break-after: always>&nbsp;</span>";
		 for(i in varspan)
		 {
		   if(document.getElementsByTagName('span')[i].title=="pagebreak")
		   {
		   document.getElementsByTagName('span')[i].contentEditable=true;
		   document.getElementsByTagName('span')[i].innerHTML=space;
		   document.getElementsByTagName('span')[i].title="Click & Press 'Enter' for space";
		   }
		   if(document.getElementsByTagName('span')[i].title=="pagebreak1")
		   {
		   document.getElementsByTagName('span')[i].contentEditable=true;
		   document.getElementsByTagName('span')[i].title="Click & Press 'Enter' for space";
		   }
		 }
}
	
function allowEnterOnly()
{
	var key=window.event.keyCode;
	if(key!=13)  
	{
		window.event.returnValue=false;
	}
}	


function gotopage(path, beanid, getmethod, page)
{
	window.opener.document.forms[0].hidBeanId.value=beanid;		
	window.opener.document.forms[0].hidBeanGetMethod.value=getmethod;
	window.opener.document.forms[0].action=path+"action/"+page;	
	window.opener.document.forms[0].method="post";
	window.opener.document.forms[0].submit();
	window.close();
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px"
	topmargin="25px" marginwidth="25px" marginheight="25px"
	onload="callPageBreak()" contentEditable="false"
	onkeypress="allowEnterOnly()">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td>



		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<%
				if (strSanctauth.equals("7")) {
			%>
			<tr align="right">
				<td>
				<table border="0" cellspacing="0" cellpadding="0" width="">
					<tr>
						<td align="left">Agenda Item No:<%=Helper.correctNull((String) hshValues
								.get("exec_agendano"))%> <br>
						MCM of: <%=Helper.correctNull((String) hshValues
										.get("exec_mcm"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>

			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/loginLogo.gif"></td>
			</tr>

			<tr>
				<td align="center">Branch / Office, <%=Helper.correctNull((String) hshValues.get("strOrgName"))%><hr>
				</td>
			</tr>

			<tr align="right">
				<td>
				<table border="0" cellspacing="0" cellpadding="6">
					<tr>
						<%
							if (strSanctauth.equals("4") || strSanctauth.equals("5")) {
						%>
						<td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg"
							width="55" height="77"></td>
						<td>&nbsp;&nbsp;</td>
						<%
							}
							if (strSanctauth.equals("5") || strSanctauth.equals("6")
									|| strSanctauth.equals("7")) {
						%>
						<td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/ED.jpg"
							width="55" height="77"></td>
						<td>&nbsp;&nbsp;</td>
						<%
							}
							if (strSanctauth.equals("6") || strSanctauth.equals("7")) {
						%>
						<td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/CMD.jpg"
							width="55" height="77"></td>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<%
				ArrayList arrmemorandum = ((ArrayList) hshValues.get("memorandum"));
				if (arrmemorandum != null)
					out.println((String) arrmemorandum.get(0));
			%>
		</table>
		</td>
	</tr>

	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td><b>Present Request:</b></td>
			</tr>
			<tr>
				<td class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("present_req"))%></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="10%" valign="top"><b>Ref No:</b></td>
				<td width="60%" valign="top"><%=Helper.correctNull((String) hshValues.get("exec_refno"))%>&nbsp;</td>
				<td width="17%" align="right" valign="top"><b>Date :&nbsp;</b></td>
				<td width="13%" align="right" valign="top"><%=Helper.correctNull((String) hshValues.get("exec_date"))%>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="27%" valign="top">GROUP</td>
				<td width="1%"><b>:</b></td>
				<td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues.get("groupdesc"))%></td>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td width="27%" valign="top">BANKING</td>
				<td width="1%"><b>:</b></td>

				<td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("status_banking"))%></td>
				<td width="21%">LEAD BANK</td>
				<td width="1%"><b>:</b></td>
				<td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_propleadbank"))%></td>
			</tr>
			<tr>
				<%
					if (Helper.correctNull((String) hshValues.get("status_banking"))
							.contains("Consortium")) {
				%>
				<td width="27%" valign="top">MONTH OF REVIEW</td>
				<td width="1%"><b>:</b></td>
				<td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("COM_PROPDEVREVDATE"))%></td>
				<td colspan="2"><b>OUR SHARE</b></td>
				<td><b>EXISTING</b></td>
				<td><b>PROPOSED</b></td>
				<%
					} else {
				%>
				<td width="27%" valign="top">MONTH OF REVIEW</td>
				<td width="1%"><b>:</b></td>
				<td colspan="5">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("COM_PROPDEVREVDATE"))%></td>
				<%
					}
				%>
			</tr>

			<%
				if (Helper.correctNull((String) hshValues.get("status_banking"))
						.contains("Consortium")) {
			%>
			<tr>
				<td width="27%" rowspan="2">ASSET CLASSIFICATION</td>
				<td width="1%" rowspan="2"><b>:</b></td>
				<td width="29%" rowspan="2"><%=Helper.correctNull((String) hshValues
								.get("com_propassettype"))%></td>
				<td width="21%">Fund based</td>
				<td width="1%"><b>:</b></td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("TOTAL_FUNDEDEXI"))%>&nbsp;%</td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("TOTAL_FUNDEDPROP"))%>&nbsp;%</td>
			</tr>
			<tr>
				<td width="21%">Non Fund based</td>
				<td width="1%"><b>:</b></td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("TOTAL_NONFUNDEDEXI"))%>&nbsp;%</td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("TOTAL_NONFUNDEDPROP"))%>&nbsp;%</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>ASSET CLASSIFICATION</td>
				<td><b>:</b></td>
				<td colspan="5"><%=Helper.correctNull((String) hshValues
								.get("com_propassettype"))%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td width="27%" valign="top">INTERNAL CREDIT RATING</td>
				<td width="1%" valign="top"><b>:</b></td>
				<td colspan="5">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center">
						<td>&nbsp;</td>
						<td><b>Rating Grade</b></td>
						<td><b>Score</b></td>
						<td><b>Risk definition</b></td>
					</tr>
					<tr align="left">
						<td><b>Previous Year</b></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("lastrating_basemodel"))%></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("lastscore_basemodel"))%></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("lastgradef_basemodel"))%></td>
					</tr>
					<tr align="left">
						<td><b>Current Year</b></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("currentrating_basemodel"))%></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("currentscore_basemodel"))%></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("currentgradef_basemodel"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="27%" valign="top">EXTERNAL CREDIT RATING</td>
				<td width="1%"><b>:</b></td>
				<td colspan="5">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;</td>
						<td valign="top" align="center"><b>Previous Year</b></td>
						<td valign="top" align="center"><b>Current Year</b></td>
					</tr>
					<tr>
						<td><b>Agency Name</b></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("preyear_agency"))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) hshValues
							.get("curyear_agency"))%>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Short Term Instruments</b></td>
						<td><%=Helper.correctNull((String) hshValues
							.get("preyear_short"))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) hshValues
							.get("curyear_short"))%>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Long Term Instruments</b></td>
						<td><%=Helper.correctNull((String) hshValues
									.get("preyear_long"))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) hshValues
									.get("curyear_long"))%>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="27%" valign="top">STATUS OF ACCOUNT</td>
				<td width="1%"><b>:</b></td>
				<td width="29%"><%=Helper.correctNull((String) hshValues.get("status_acc"))%>&nbsp;</td>
				<td colspan="4">&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td width="5%" valign="top"><b>1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>NAME OF THE ACCOUNT</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%" valign="top"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>1.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CIN</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_cin"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>1.2.&nbsp;</b></td>
				<td width="41%" valign="top"><b>BRANCH / ZONE</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
							.get("appCreationBranch"))%></td>
			</tr>
			
			<tr>
				<td width="5%" valign="top"><b>2.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CONSTITUTION</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
									.get("strownership"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>2.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>DATE OF INCORPORATION</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_yrsinbusiness"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>3.&nbsp;</b></td>
				<td width="41%" valign="top"><b>LINE OF ACTIVITY</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.formatTextAreaData((String) hshValues
							.get("comapp_businessnature"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.&nbsp;</b></td>
				<td width="41%" valign="top"><b> ADDRESS</b></td>
				<td width="3%" valign="top">&nbsp;</td>
				<td width="51%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>Regd./Admn.Office</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_regadd1"))%>-<%=Helper.correctNull((String) hshValues
							.get("comapp_regadd2"))%><br>
				<%=Helper.correctNull((String) hshValues
									.get("Regcity_name"))%> <br>
				<%=Helper.correctNull((String) hshValues
							.get("Regstate_name"))%> <br>
				Pin:<%=Helper.correctNull((String) hshValues
							.get("comapp_regpin"))%><br>
				</td>
			</tr>
			<%
				arrData = new ArrayList();
				arrRow = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrUnitsworks");
				if (arrRow != null && arrRow.size() > 0) {
			%>
			<tr>
				<td width="5%" valign="top"><b>4.2.&nbsp;</b></td>
				<td width="41%" valign="top"><b>Units/Works</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%">
				<table border="0" width="100%">
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								arrData = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td><%=arrData.get(0)%>,<br>
						<%=arrData.get(1)%>,<br>
						<%=arrData.get(2)%>,<br>
						<%=arrData.get(3)%>-<%=arrData.get(4)%>.<br>
						</td>
					</tr>
					<%
						}
					%>

				</table>
				</td>
			</tr>
			<%
				}
			%>

			<tr>
				<td width="5%" valign="top"><b>5.&nbsp;</b></td>
				<td width="41%" valign="top"><b>NAMES OF PROPRIETORS /
				PARTNERS / DIRECTORS &amp; THEIR MEANS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%" valign="top">&nbsp; <%
 	arrRow = new ArrayList();
 	arrRow = (ArrayList) hshValues.get("arrPromotors");
 	if (arrRow != null && arrRow.size() != 0) {
 %>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td><b>Sno</b></td>
						<td><b>Name</b></td>
						<td><b>Designation</b></td>
						<td><b>Means&nbsp;(<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td><b>Means As on&nbsp;</b></td>
						<td><b>DIN</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								arrData = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td><%=i + 1%>.</td>
						<td><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
						<td><%=arrData.get(8)%>&nbsp;</td>
						<td align="right"><%=Helper.correctNull((String) arrData.get(4))%></td>
						<td><%=Helper.correctNull((String) arrData.get(5))%></td>
						<td><%=Helper.correctNull((String) arrData.get(9))%></td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				<%
					} else {
				%> Nil <%
					}
				%>
				</td>
			</tr>

			<tr>
				<td width="5%" valign="top"><b>6.1&nbsp;</b></td>
				<td valign="top" colspan="2"><b><a href="#"
					onClick="gotopage('<%=ApplicationParams.getAppUrl()%>','compromo','getProData','compromoters.jsp')">BACKGROUND
				OF PROMOTERS / DIRECTORS / PROPRIETOR / PARTNER</a></b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrProback");

					if (arrRow != null && arrRow.size() != 0) {
				%><td colspan="4" class="just">
				<%
					for (int i = 0; i < arrRow.size(); i++) {
							arrData = (ArrayList) arrRow.get(i);
							if (!(Helper.correctNull((String) arrData.get(7))
									.equals(""))) {
				%>
				<p><%=Helper.formatTextAreaData((String) arrData
										.get(7))%></p>
				<%
					}
						}
				%>
				</td>
				<%
					}
				%>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>6.2&nbsp;</b></td>
				<td valign="top" colspan="2"><b>BRIEF BACKGROUND PROMOTER
				COMPANY / GROUP COMPANIES</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;</td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
						.get("comback_comment")).equalsIgnoreCase("")){%>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" class="just">
				<%=Helper.correctEditor((String) hshValues
							.get("comback_comment"))%>&nbsp;</td>
			</tr>
			<%} %>
			<tr>
						<td width="6%" valign="top"><b>7.&nbsp;</b></td>
						<td colspan="3"><b>CAPITAL STRUCTURE</b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3"><em>In case of Companies</em></td>
					</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">

				<table width="75%" border="0" cellspacing="0" cellpadding="0">
					
					<%
						if (strOwnership.trim().equals("OLP")
								|| strOwnership.trim().equals("OCC")) {
					%>
					<tr>
						<td width="41%" valign="top">Authorised Capital</td>
						<td width="10%" valign="top"><b>:</b></td>
						<td align="left">Rs&nbsp;<%=Helper.correctDouble((String) hshValues
								.get("auth_captial"))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
					</tr>
					<tr>
						<td width="41%" valign="top">Issued/Subscribed Capital</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">Rs&nbsp;<%=Helper.correctDouble((String) hshValues
								.get("comapp_subcapital"))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
					</tr>
					<tr>
						<td width="41%" valign="top">Paid-up capital</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">Rs&nbsp;<%=Helper.correctDouble((String) hshValues
								.get("PaidupCapital"))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
					</tr>
					<tr>
						<td width="41%" valign="top">Book Value</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left"><%=Helper.correctNull((String)hshValues
								.get("book_value"))%>&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td width="41%" valign="top">Market value</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left"><%=Helper.correctNull((String) hshValues
								.get("market_value"))%>&nbsp;&nbsp;</td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td width="41%" valign="top">Authorised Capital</td>
						<td width="10%" valign="top"><b>:</b></td>
						<td align="left">&nbsp;</td>
					</tr>
					<tr>
						<td width="41%" valign="top">Issued/Subscribed Capital</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">&nbsp;</td>
					</tr>
					<tr>
						<td width="41%" valign="top">Paid-up capital</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">&nbsp;</td>
					</tr>
					<tr>
						<td width="41%" valign="top">Book Value</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">&nbsp;</td>
					</tr>
					<tr>
						<td width="41%" valign="top">Market value</td>
						<td width="3%" valign="top"><b>:</b></td>
						<td align="left">&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>

				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>7.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>SHAREHOLDING PATTERN</b></td>
				<td width="3%" height="2">&nbsp;</td>
				<%
					if (strOwnership.trim().equals("OLP")
							|| strOwnership.trim().equals("OCC")) {
				%>
				<td height="2" width="51%">&nbsp;</td>
				<%
					} else {
				%>
				<td height="2" width="51%">N.A.</td>
				<%
					}
				%>
			</tr>
			<%
				if (strOwnership.trim().equals("OLP")
						|| strOwnership.trim().equals("OCC")) {
			%>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">

				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="40%" align="center"><b> Share Holder</b></td>
						<td width="20%" align="center"><b> No of Shares </b></td>
						<td width="20%" align="center"><b> Value </b></td>
						<td width="20%" align="center"><b> Holding % </b></td>
					</tr>
					<%
						ArrayList arr = new ArrayList();
							ArrayList arr1 = new ArrayList();
							long dblshares = 0;
							long lngvalue = 0;
							double dblholding = 0.0;							
							arr = (ArrayList) hshValues.get("arrRow");
							if (arr != null && arr.size() > 0) {
								int arrSize = arr.size();
								for (int i = 0; i < arrSize; i++) {
									arr1 = (ArrayList) arr.get(i);
									dblshares = dblshares
											+ (long)Double.parseDouble(Helper
													.correctDouble((String) arr1.get(4)));
									lngvalue = lngvalue
											+ (long) Double.parseDouble(Helper
													.correctDouble((String) arr1.get(6)));
									dblholding = dblholding
											+ Double.parseDouble(Helper
													.correctDouble((String) arr1.get(3)));
					%>
					<tr>
						<td width="40%">&nbsp;<%=arr1.get(0)%>&nbsp;<%=arr1.get(2)%>&nbsp;<%=arr1.get(1)%></td>
						<td width="20%" align="left">&nbsp;<%=arr1.get(4)%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arr1
														.get(6))))%></td>
						<%
							String val_hold = Helper.correctNull((String) arr1
												.get(3));
										double dblval_hold = 0.00;
										if (!val_hold.equalsIgnoreCase("")) {
											dblval_hold = Double.parseDouble(val_hold);
										}
						%>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(dblval_hold)%></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td width="40%"><b>Total</b></td>
						<td width="20%" align="left"><%=(dblshares)%>
						</td>
						<td width="20%" align="right"><%=nf.format(lngvalue)%></td>
						<td width="20%" align="right"><%=Helper.formatDoubleValue(dblholding)%>
						</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td width="5%" valign="top"><b>7.2.&nbsp;</b></td>
				<td width="41%" valign="top"><b>IN CASE OF PARTNERSHIP
				FIRMS INDICATE CAPITAL CONTRIBUTED BY EACH PARTNER SEPARATELY</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%" valign="top">
				<%
					if (strOwnership.trim().equals("OP")) {

						ArrayList arrR = new ArrayList();
						ArrayList arrC = new ArrayList();
						int arrSize6 = 0;
						arrR = (ArrayList) hshValues.get("arrRow15");

						if (arrR != null) {

							arrSize6 = arrR.size();
							for (int i = 0; i < arrSize6; i++) {
								arrC = (ArrayList) arrR.get(i);
								//if(arrC.get(0).equals("PT@") || arrC.get(0).equals("PT") || arrC.get(0).equals("PA"))
								{

									String conValue = "", conValue1 = "";
									if (!arrC.get(4).equals("")) {
										conValue = Helper.correctNull((String) arrC
												.get(4));
									} else {
										conValue = "0.00";
									}
									if (!arrC.get(6).equals("")) {
										conValue1 = Helper.correctNull((String) arrC
												.get(6));
									} else {
										conValue1 = "0.00";
									}
				%> &nbsp;<b><%=i + 1%></b>.<%=arrC.get(1)%>&nbsp;<%=arrC.get(2)%>&nbsp;-&nbsp;&nbsp;<%=ApplicationParams.getCurrency()%>
				<%=conValue1%> <%=strProposalvalue%>&nbsp;&nbsp;&nbsp;&nbsp;<br>
				<%
					}
							}

						}

					} else {
						out.println("N.A");
					}
				%>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>8.&nbsp;</b></td>
				<td width="41%" valign="top"><b>SECTOR / BSR CODE</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyid"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>9.&nbsp;</b></td>
				<td width="41%" valign="top"><b>COMMENTS ON LATEST
				CREDIT/SEARCH REPORT</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="51%" valign="top" class="just">
				<%
					String cmd_searchreport = Helper.correctNull((String) hshValues
							.get("cmd_searchreport"));
				%> <%
 	if (cmd_searchreport.trim().equals("")) {
 %> Nil <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				cmd_searchreport, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<!-- <tr>
				<td colspan="5"><a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
			</tr> -->
			<tr>
				<td width="6%" valign="top"><b>10.&nbsp;</b></td>
				<td width="41%" valign="top"><b>WHETHER A/C IS TAKEN/ TO BE
				TAKEN OVER. IF SO NORMS FOR TAKE OVER ARE FUL FILLED</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<%
					String istakeover = Helper.correctNull((String) hshValues
							.get("istakeover"));
					String strTake = "";
					if (istakeover.equalsIgnoreCase("2")
							|| istakeover.equalsIgnoreCase("0")) {
						strTake = "Not Applicable";
					} else {
						strTake = "Yes";
					}
				%>
				<td colspan="2" valign="top">&nbsp;<%=strTake%></td>
			</tr>

			<%
				if (istakeover.equalsIgnoreCase("1")) {
			%>

			<tr>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<%
						arrRow = new ArrayList();
							arrRow = (ArrayList) hshValues.get("arrworkingRow");
							if (arrRow != null && arrRow.size() > 0) {
					%>

					<tr>
						<td align="center" width="60%"><b>TAKE-OVER NORMS FOR
						TRADE &amp; SERVICES </b></td>
						<td align="center" width="40%"><b> COMPLIANCE</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
									arrData = (ArrayList) arrRow.get(i);
									if (arrData != null && arrData.size() > 0) {
					%>
					<tr>
						<td width="60%" valign="top" class="just"><%=Helper.correctNull((String) arrData
											.get(0))%>&nbsp;</td>
						<td valign="top" class="just" width="40%"><%=Helper.correctNull((String) arrData
											.get(2))%>&nbsp;</td>
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
			<!--  <tr>
				<td colspan="5" align="center"><a href="#"
					class="highlight_pagebreak"><span title="pagebreak"
					onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a>&nbsp;</td>
			</tr>-->
			<tr>
				<td colspan="5" align="center">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<%
						arrRow = new ArrayList();
							arrRow = (ArrayList) hshValues.get("arrtermsRow");
							if (arrRow != null && arrRow.size() > 0) {
					%>
					<tr>
						<td align="center" width="60%"><b>TAKE OVER NORMS FOR
						MANUFACTURING / INDUSTRIAL ADVANCES</b></td>
						<td align="center" width="40%"><b> COMPLIANCE</b></td>
					</tr>

					<%
						for (int i = 0; i < arrRow.size(); i++) {
									arrData = (ArrayList) arrRow.get(i);
									if (arrData != null && arrData.size() > 0) {
					%>
					<tr>
						<td width="60%" valign="top" class="just"><%=Helper.correctNull((String) arrData
											.get(0))%> &nbsp;</td>
						<td valign="top" class="just" width="40%">&nbsp;<%=Helper.correctNull((String) arrData
											.get(2))%></td>
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
			<%
				}
			%>
		</table>
		<!-- <a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a> --></td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>10.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>DUE DILIGENCE</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("due_diligence"))%>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="6%" valign="top"><b>11.&nbsp;</b></td>
				<td width="41%" valign="top"><b> DEALING WITH BANK SINCE </b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues.get("deal_bank"))%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="6%" valign="top"><b>12.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CREDIT FACILITIES SINCE</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<%
					if (Helper.correctNull((String) hshValues.get("exec_borrowertype"))
							.equalsIgnoreCase("E")) {
				%>
				<td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("credit_since"))%></td>
				<%
					} else {
				%>
				<td colspan="2">&nbsp;New Borrower</td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="6%" valign="top"><b>13.&nbsp;</b></td>
				<td colspan="5"><b>TOTAL INDEBTEDNESS </b></td>
			</tr>
			<tr valign="top">
				<td colspan="6" align="right"><b>(Rs In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td colspan="5">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td width="24%">&nbsp;</td>
								<td colspan="2" align="center"><b>NON-FUND BASED </b></td>
								<td colspan="2" align="center"><b>FUND BASED </b></td>
								<td colspan="2" align="center"><b>TOTAL </b></td>
							</tr>
							<tr>
								<td width="24%">&nbsp;</td>
								<td width="13%" align="center"><b>Existing </b></td>
								<td width="13%" align="center"><b>Proposed </b></td>
								<td width="13%" align="center"><b>Existing </b></td>
								<td width="13%" align="center"><b>Proposed </b></td>
								<td width="13%" align="center"><b>Existing </b></td>
								<td width="13%" align="center"><b>Proposed </b></td>
							</tr>
							<%
								ArrayList arr2 = new ArrayList();
								ArrayList arr3 = new ArrayList();
								double nfundext = 0.00;
								double nfundext1 = 0.00;
								double nfundpro = 0.00;
								double nfundpro1 = 0.00;

								double fundext = 0.00;
								double fundext1 = 0.00;
								double fundpro = 0.00;
								double fundpro1 = 0.00;

								double tfundext = 0.00;
								double tfundext1 = 0.00;
								double tfundpro = 0.00;
								double tfundpro1 = 0.00;

								int arrSize1 = 0;
								arr2 = (ArrayList) hshValues.get("arrRow1");
								if (arr2 != null && arr2.size() > 0) {
									arrSize1 = arr2.size();

									for (int i = 0; i < arrSize1; i++) {
										arr3 = (ArrayList) arr2.get(i);

										nfundext = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(0)));
										nfundext1 = nfundext1 + nfundext;
										nfundpro = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(1)));
										nfundpro1 = nfundpro1 + nfundpro;

										fundext = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(2)));
										fundext1 = fundext1 + fundext;
										fundpro = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(3)));
										fundpro1 = fundpro1 + fundpro;

										tfundext = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(4)));
										tfundext1 = tfundext1 + tfundext;
										tfundpro = Double.parseDouble(Helper
												.correctDouble((String) arr3.get(5)));
										tfundpro1 = tfundpro1 + tfundpro;
							%>
							<tr>
								<td width="24%">Working Capital-<%=arr3.get(6)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(2))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(3))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(0))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(1))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(4))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(5))))%></td>
							</tr>
							<%
								}
								}
							%>
							<tr>
								<td width="24%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
								<td width="13%">&nbsp;</td>
							</tr>
							<%
								ArrayList arr4 = new ArrayList();
								ArrayList arr5 = new ArrayList();
								int arrSize3 = 0;
								arr4 = (ArrayList) hshValues.get("arrRow2");
								if (arr4 != null && arr4.size() > 0) {

									arrSize3 = arr4.size();

									for (int i = 0; i < arrSize3; i++) {
										arr5 = (ArrayList) arr4.get(i);

										nfundext = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(0)));
										nfundext1 = nfundext1 + nfundext;
										nfundpro = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(1)));
										nfundpro1 = nfundpro1 + nfundpro;

										fundext = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(2)));
										fundext1 = fundext1 + fundext;
										fundpro = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(3)));
										fundpro1 = fundpro1 + fundpro;

										tfundext = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(4)));
										tfundext1 = tfundext1 + tfundext;
										tfundpro = Double.parseDouble(Helper
												.correctDouble((String) arr5.get(5)));
										tfundpro1 = tfundpro1 + tfundpro;
							%>
							<tr>
								<td width="24%">Term Loan-<%=arr5.get(6)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(2))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(3))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(0))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(1))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(4))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr5
																	.get(5))))%></td>
							</tr>
							<%
								}
								}
							%>
							<tr>
								<td width="24%" align="right"><b> TOTAL</b></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(fundext1)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(fundpro1)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(nfundext1)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(nfundpro1)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(tfundext1)%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(tfundpro1)%></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>&nbsp;</b></td>
				<td width="41%" valign="top"><b>BRIEF BACKGROUND</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3"><%=Helper.correctEditor((String) hshValues
							.get("companybackground"))%><a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td width="3%" valign="top"><b>14.1.&nbsp;</b></td>
				<td colspan="5"><b>FINANCIAL INDICATORS </b></td>
			</tr>
			<%
				String CompanyName = "", DivisionID = "";
				ArrayList arrayDivision = new ArrayList();
				ArrayList arrayDiv = new ArrayList();
				HashMap hshValueFinancial = new HashMap();
				arrayDivision = (ArrayList) hshValues.get("arrayDivision");
			%><%-- 
/*if(arrayDivision!=null && arrayDivision.size()>0)
{
	for(int x=0;x<arrayDivision.size();x++)
	{	
		arrayDiv=(ArrayList)arrayDivision.get(x);
		DivisionID=Helper.correctNull((String)arrayDiv.get(0));*/
		--%>
			<%
				hshValueFinancial = (HashMap) hshValues.get("hshValueFinancial0");

				String label0 = "";
				label0 = Helper.correctNull((String) hshValueFinancial
						.get("label0"));

				ArrayList vecdesc = (ArrayList) hshValueFinancial.get("vecdesc");
				ArrayList vectype = (ArrayList) hshValueFinancial.get("vectype");
				ArrayList vecCuryear = (ArrayList) hshValueFinancial.get("year");
				ArrayList vecCuryearHold = (ArrayList) hshValueFinancial.get("yearhold");
				ArrayList vecPreyear = (ArrayList) hshValueFinancial.get("prevyear");
				ArrayList vecPreyearHold = (ArrayList) hshValueFinancial
						.get("prevyearhold");
				ArrayList vecNextyear = (ArrayList) hshValueFinancial.get("nextyear");
				ArrayList vecNextyearHold = (ArrayList) hshValueFinancial
						.get("nextyearhold");
				ArrayList vecNextyear2 = (ArrayList) hshValueFinancial.get("nextyear2");
				ArrayList vecNextyearHold2 = (ArrayList) hshValueFinancial
						.get("nextyearhold2");
				ArrayList vecPreyear1 = (ArrayList) hshValueFinancial.get("prevyear1");
				ArrayList vecPreyearHold1 = (ArrayList) hshValueFinancial
						.get("prevyearhold1");
			%><%-- 
		/* String strDesc =Helper.correctNull((String)request.getParameter("pageval"));
		 String strPage=Helper.correctNull((String)hshValueFinancial.get("page"));
		 
		 ArrayList vecdata1=(ArrayList)hshValueFinancial.get("vecdata1");
		 ArrayList vecdata2=(ArrayList)hshValueFinancial.get("vecdata2");
		 ArrayList vecdata3=(ArrayList)hshValueFinancial.get("vecdata3");
		 ArrayList vecdata4=(ArrayList)hshValueFinancial.get("vecdata4");
		 ArrayList vecdata5=(ArrayList)hshValueFinancial.get("vecdata5");
		 ArrayList vecdata6=(ArrayList)hshValueFinancial.get("vecdata6");
		 ArrayList arryCol=null;
		 ArrayList arryRow=(ArrayList)hshValueFinancial.get("arryRow");*/
		--%>
			<%
				int vecsizeFI = 0;

				ArrayList yearval = new ArrayList();
				yearval = (ArrayList) hshValueFinancial.get("yearvalue");

				String curYear = Helper.correctNull((String) yearval.get(0));
				String curYearDesc = Helper.correctNull((String) yearval
						.get(1));
				String pervYear = Helper.correctNull((String) yearval.get(2));
				String prevYearDesc = Helper.correctNull((String) yearval
						.get(3));
				String nextYear = Helper.correctNull((String) yearval.get(4));
				String nextYearDesc = Helper.correctNull((String) yearval
						.get(5));
				String pervYear1 = Helper
						.correctNull((String) yearval.get(6));
				String prevYearDesc1 = Helper.correctNull((String) yearval
						.get(7));
				String nextYear2 = Helper
						.correctNull((String) yearval.get(8));
				String nextYearDesc2 = Helper.correctNull((String) yearval
						.get(9));

				String a = "", b = "", c = "", d = "", e = "";
				if (curYearDesc.trim().equals("a")) {
					a = "Audited";
				} else if (curYearDesc.trim().equals("u")) {
					a = "Unaudited / Provisional";
				} else if (curYearDesc.trim().equals("e")) {
					a = "Estimated";
				} else if (curYearDesc.trim().equals("p")) {
					a = "Projection";
				}
				if (prevYearDesc.trim().equals("a")) {
					b = "Audited";
				} else if (prevYearDesc.trim().equals("u")) {
					b = "Unaudited / Provisional";
				} else if (prevYearDesc.trim().equals("e")) {
					b = "Estimated";
				} else if (prevYearDesc.trim().equals("p")) {
					b = "Projection";
				}
				if (nextYearDesc.trim().equals("a")) {
					c = "Audited";
				} else if (nextYearDesc.trim().equals("u")) {
					c = "Unaudited / Provisional";
				} else if (nextYearDesc.trim().equals("e")) {
					c = "Estimated";
				} else if (nextYearDesc.trim().equals("p")) {
					c = "Projection";
				}
				if (prevYearDesc1.trim().equals("a")) {
					d = "Audited";
				} else if (prevYearDesc1.trim().equals("u")) {
					d = "Unaudited / Provisional";
				} else if (prevYearDesc1.trim().equals("e")) {
					d = "Estimated";
				} else if (prevYearDesc1.trim().equals("p")) {
					d = "Projection";
				}
				if (nextYearDesc2.trim().equals("a")) {
					e = "Audited";
				} else if (nextYearDesc2.trim().equals("u")) {
					e = "Unaudited / Provisional";
				} else if (nextYearDesc2.trim().equals("e")) {
					e = "Estimated";
				} else if (nextYearDesc2.trim().equals("p")) {
					e = "Projection";
				}

				// if((!pervYear.trim().equalsIgnoreCase("")) || (!pervYear1.trim().equalsIgnoreCase(""))) {
			%>
			<tr>
				<td>&nbsp;</td>
				<td colspan="5"><b><u>Company Name :&nbsp;</u></b><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname"))%></td>
			</tr>
			<tr>
				<td colspan="6" align="right"><b>(Rs In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="5">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="left">
					<%-- 
                <tr class="tblhead"> 
                  <td width="30%" align="center" height="25">Particulars
                  </td>
                  <td colspan="2" align="center" height="25" width="30%">Last 
                    2 Years</td>
                  <td align="center" height="25" width="12%" >Current 
                    Year </td>
                  <td  colspan="2" align="center" height="25" width="30%">Next 
                    2 Years </td>
                </tr>--%>
					<tr class="tblhead">
						<td width="30%" align="center">Particulars&nbsp;</td>
						<td align="center" width="14%"><b><%=pervYear%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=pervYear1%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=curYear%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=nextYear%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=nextYear2%>&nbsp;</b></td>
					</tr>

					<tr>
						<td width="30%">&nbsp;</td>
						<td align="center" width="14%"><b><%=b%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=d%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=a%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=c%>&nbsp;</b></td>
						<td align="center" width="14%"><b><%=e%>&nbsp;</b></td>
					</tr>
					<%
						if (vecdesc != null) {
							vecsizeFI = vecdesc.size();
						}

						for (int i = 0; i < vecsizeFI; i++) {
							String desc = Helper.correctNull((String) vecdesc.get(i));
							String type = Helper.correctNull((String) vectype.get(i));
							String col1 = Helper.correctNull((String) vecCuryear
									.get(i));//3
							String col2 = Helper.correctNull((String) vecCuryearHold
									.get(i));
							String col3 = Helper.correctNull((String) vecPreyear
									.get(i));//1
							String col4 = Helper.correctNull((String) vecPreyearHold
									.get(i));
							String col5 = Helper.correctNull((String) vecNextyear
									.get(i));//4
							String col6 = Helper.correctNull((String) vecNextyearHold
									.get(i));
							String col9 = Helper.correctNull((String) vecNextyear2
									.get(i));//5
							String col10 = Helper.correctNull((String) vecNextyearHold2
									.get(i));
							String col7 = Helper.correctNull((String) vecPreyear1
									.get(i));
							String col8 = Helper.correctNull((String) vecPreyearHold1
									.get(i));//2
					%>
					<%
						if (type.trim().equals("HE") || type.trim().equals("H")) {
					%>
					<tr>
						<td width="30%"><%=desc%></td>
						<td width="14%" align="right">&nbsp;</td>
						<td width="14%" align="right">&nbsp;</td>
						<td width="14%" align="right">&nbsp;</td>
						<td width="14%" align="right">&nbsp;</td>
						<td width="14%" align="right">&nbsp;</td>
					</tr>
					<%
						} else {
					%>

					<tr>
						<td width="30%"><%=desc%></td>
						<td width="14%" align="right">&nbsp;<%=col3%></td>
						<td width="14%" align="right">&nbsp;<%=col8%></td>
						<td width="14%" align="right">&nbsp;<%=col1%></td>
						<td width="14%" align="right">&nbsp;<%=col5%></td>
						<td width="14%" align="right">&nbsp;<%=col9%></td>
					</tr>
					<%
						}
					%>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<%
	ArrayList arrRowdesc = (ArrayList) hshValues
			.get("arrFinIndicatorDesc");
	if (arrRowdesc != null && arrRowdesc.size() == 0) {
%>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5%" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td valign="top"><b>COMMENTS ON FINANCIAL INDICATORS&nbsp;:</b></td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValueFinancial.get("exec_notes")).equals("")){ %>
			<tr>
				<td width="5%" valign="top">&nbsp;</td>
				<td valign="top"><%=Helper.correctEditor((String) hshValueFinancial
								.get("exec_notes"))%></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>

</table>
<%
	}
%>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				arrRow = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrFinIndicatorRow");
				String str_lineitem = "";
				String strDesc = "";

				if (arrRowdesc != null && arrRowdesc.size() > 0) {
			%>
			<tr>
				<td width="3%" valign="top"><b>&nbsp;</b></td>
				<td colspan="5"><b>COMMENTS ON FINANCIAL INDICATORS&nbsp;:</b></td>
			</tr>
			<%
				for (int i = 0; i < arrRowdesc.size(); i++) {
						ArrayList arr_Row = (ArrayList) arrRowdesc.get(i);
						str_lineitem = (String) arr_Row.get(0);
						strDesc = (String) arr_Row.get(1);
			%>
			<tr>
				<td width="3%" valign="top"><b>14.1.<%=(i + 1)%>.&nbsp;</b></td>
				<td colspan="5"><b><%=strDesc%>:&nbsp;</b></td>
			</tr>

			<%
				if (str_lineitem.equals("Y")) {
			%>


			<%
				ArrayList arr_Row1 = (ArrayList) arrRow.get(i);
							if (arr_Row1 != null && arr_Row1.size() > 0) {
			%>

			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="5" width="100%">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="left">
					<%
						for (int j = 0; j < arr_Row1.size(); j++) {
											ArrayList arrCol = new ArrayList();
											arrCol = (ArrayList) arr_Row1.get(j);
											String strAlign = "";
											if (j < 2) {

												strAlign = "center";
											} else {

												strAlign = "right";
											}
											if (Helper.correctNull((String) arrCol.get(2))
													.equals("FO")) {
												if (!(Helper.correctNull(
														(String) arrCol.get(4)).equals("") || Helper
														.correctNull((String) arrCol.get(4))
														.equals("0.00"))
														|| !(Helper.correctNull(
																(String) arrCol.get(5))
																.equals("") || Helper
																.correctNull(
																		(String) arrCol
																				.get(5))
																.equals("0.00"))
														|| !(Helper.correctNull(
																(String) arrCol.get(6))
																.equals("") || Helper
																.correctNull(
																		(String) arrCol
																				.get(6))
																.equals("0.00"))) {
					%>
					<tr>
						<td><%=Helper
																.correctNull((String) arrCol
																		.get(1))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
																.correctNull((String) arrCol
																		.get(4))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
																.correctNull((String) arrCol
																		.get(5))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
																.correctNull((String) arrCol
																		.get(6))%>&nbsp;</td>

					</tr>
					<%
						}
											} else {
					%>
					<tr>
						<td><%=Helper
															.correctNull((String) arrCol
																	.get(1))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
															.correctNull((String) arrCol
																	.get(4))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
															.correctNull((String) arrCol
																	.get(5))%>&nbsp;</td>
						<td width="13%" align="<%=strAlign%>"><%=Helper
															.correctNull((String) arrCol
																	.get(6))%>&nbsp;</td>
					</tr>
					<%
						}
					%>

					<%
						}
					%>
				</table>
				</div>
				<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
			<%
				}
						}
			%>

			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="5"><%=Helper.correctEditor((String) arr_Row.get(2))%>&nbsp;</td>
			</tr>
			<%
				}
				}
			%>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td width="3%" valign="top"><b>14.2.&nbsp;</b></td>
				<td colspan="4"><b>CASH FLOW </b></td>
			</tr>
			<%--

DivisionID="0";
arrayDivision= new ArrayList();
arrayDiv= new ArrayList();
arrayDivision=(ArrayList)hshValues.get("arrayDivision");
if(arrayDivision!=null && arrayDivision.size()>0)
{
	for(int x=0;x<arrayDivision.size();x++)
	{	
		arrayDiv=(ArrayList)arrayDivision.get(x);
		DivisionID=Helper.correctNull((String)arrayDiv.get(0));	
		
--%>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4"><b><u>Company Name :</u></b>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("comapp_companyname"))%></td>
			</tr>
			<tr>
				<td width="3%" valign="top"><b>14.2.<%=(0 + 1)%>&nbsp;</b></td>
				<td width="41%" valign="top" class="subheading"><b>COMMENTS
				ON FINANCIAL INDICATORS ON CASH BASIS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("exec_notes0")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("exec_notes0"))%><a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td width="3%" valign="top"><b>14.3.&nbsp;</b></td>
				<td width="41%" colspan="4"><b>AUDIT NOTES IN BALANCE SHEET
				IF ANY, TO BE SPECIFIED</b></td>
			</tr>
			<%if(!Helper.correctEditor(
					(String) hshValues.get("audit_notes")).trim().equalsIgnoreCase("")) {%>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4"><%=Helper.correctEditor(
							(String) hshValues.get("audit_notes")).trim()%></td>
			</tr>
			
			<%} %>
		</table>
		<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td width="3%" valign="top"><b>15.&nbsp;</b></td>
				<td colspan="4"><b>EVALUATION OF MANAGEMENT</b></td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("EXEC_EVAL_MAGMT")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("EXEC_EVAL_MAGMT"))%></td>
			</tr>
			<%} %>
		</table>
		<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>16.&nbsp;</b></td>
				<td colspan="4"><b>EVALUATION OF INDUSTRY</b></td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("EXEC_EVAL_INDUSTRY")).equalsIgnoreCase("")) {%>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("EXEC_EVAL_INDUSTRY"))%></td>
			</tr>
			<%} %>
		</table>
		<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>17.&nbsp;</b></td>
				<td colspan="4"><b>EVALUATION OF BUSINESS RISK</b></td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("EXEC_EVAL_BUSSINESSRISK")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("EXEC_EVAL_BUSSINESSRISK"))%></td>
			</tr>
			<%} %>
		</table>
		<a href="#" class="highlight_pagebreak"><span title="pagebreak"
			onPaste="window.event.returnValue=false"
			onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>18.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CONDUCT OF THE ACCOUNT</b></td>
				<%
					String selstock0 = Helper.correctNull((String) hshValues
							.get("conduct_acc"));
					if (selstock0.equalsIgnoreCase("1")) {
						selstock0 = "Satisfactory";
					} else if (selstock0.equalsIgnoreCase("2")) {
						selstock0 = "Not Satisfactory";
					} else if (selstock0.equalsIgnoreCase("3")) {
						selstock0 = "Good";
					} else if (selstock0.equalsIgnoreCase("4")) {
						selstock0 = "Poor";
					} else if (selstock0.equalsIgnoreCase("5")) {
						selstock0 = "Not Healthy";
					} else {
						selstock0 = " ";
					}
				%>
				<td width="3%" valign="top"><b>:&nbsp;<%=selstock0%>&nbsp;</b></td>
				<td colspan="2" valign="top" >&nbsp;</td>
			</tr>
			<%if(!Helper.formatTextAreaData((String) hshValues
					.get("conduct_no")).equalsIgnoreCase("")){ %>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4"><p><%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_no"))%></p></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td rowspan="6" valign="top" width="3%"><b>18.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>Regularity in submission of
				</b></td>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>-Stock
				Statements / Book Debt Statements</b></td>
				<%
					String selstock = Helper.correctNull((String) hshValues
							.get("conduct_accstock"));
					if (selstock.equalsIgnoreCase("1")) {
						selstock = "Yes";
					} else if (selstock.equalsIgnoreCase("2")) {
						selstock = "No";
					} else {
						selstock = " ";
					}
				%>
				<td valign="top" width="3%">&nbsp;<%=selstock%>&nbsp;</td>
				<td valign="top" colspan="2"><%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_stockno"))%>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>-MSOD </b></td>
				<%
					String selstock1 = Helper.correctNull((String) hshValues
							.get("conduct_msod"));
					if (selstock1.equalsIgnoreCase("1")) {
						selstock1 = "Yes";
					} else if (selstock1.equalsIgnoreCase("2")) {
						selstock1 = "No";
					} else {
						selstock1 = " ";
					}
				%>
				<td valign="top" width="3%">&nbsp;<%=selstock1%>&nbsp;</td>
				<td valign="top" colspan="2"><%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_msodno"))%> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>-QPR
				Statements / Half Yearly Statements </b></td>
				<%
					String selstock2 = Helper.correctNull((String) hshValues
							.get("conduct_qpr"));
					if (selstock2.equalsIgnoreCase("1")) {
						selstock2 = "Yes";
					} else if (selstock2.equalsIgnoreCase("2")) {
						selstock2 = "No";
					} else {
						selstock2 = " ";
					}
				%>
				<td valign="top" width="3%">&nbsp;<%=selstock2%>&nbsp;</td>
				<td valign="top" colspan="2"><%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_qprno"))%> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>-Financial
				Statements</b></td>
				<%
					String selstock3 = Helper.correctNull((String) hshValues
							.get("conduct_fin"));
					if (selstock3.equalsIgnoreCase("1")) {
						selstock3 = "Yes";
					} else if (selstock3.equalsIgnoreCase("2")) {
						selstock3 = "No";
					} else {
						selstock3 = " ";
					}
				%>
				<td valign="top" width="3%">&nbsp;<%=selstock3%>&nbsp;</td>
				<td valign="top" colspan="2"><%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_finno"))%> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b> -CMA
				Data</b></td>
				<%
					String selstock4 = Helper.correctNull((String) hshValues
							.get("conduct_cma"));
					if (selstock4.equalsIgnoreCase("1")) {
						selstock4 = "Yes";
					} else if (selstock4.equalsIgnoreCase("2")) {
						selstock4 = "No";
					} else {
						selstock4 = " ";
					}
				%>
				<td valign="top" width="3%">&nbsp;<%=selstock4%>&nbsp;</td>
				<td valign="top" colspan="2"><%=Helper.correctNull((String) hshValues
							.get("conduct_cmano"))%> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%" rowspan="4"><b>18.2.&nbsp;</b></td>
				<td valign="top" width="41%" height="49"><b>Name of the
				Statement/return</b></td>
				<td valign="top" width="3%">
				<p><b>:</b></p>
				<p></p>
				</td>
				<td valign="top" width="27%" height="49" bgcolor="#E6E6E6"><b>No
				of Statements/Return recd. during the year</b></td>
				<td valign="top" width="23%" height="49" bgcolor="#E6E6E6"><b>Last
				Stat. / Return recd.</b></td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>Stock
				Statement /BD </b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_stockstamt"))%></td>
				<td valign="top" width="23%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_stockdate"))%></td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>MSOD </b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_msodstmt"))%></td>
				<td valign="top" width="23%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_msoddate"))%></td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>QPR /
				Half Yearly Statement</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_qprstmt"))%></td>
				<td valign="top" width="23%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_qprdate"))%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%" rowspan="5"><b>18.3.&nbsp;</b></td>
				<td valign="top" width="41%"><b>COMMENTS ON OPERATIONS /
				OVERDUES </b><br>
				Indicate Whether</td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>(1)
				Turnover in the account is commensurate with the limits.</b></td>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" colspan="2"  class="just">
				<%if(Helper.formatTextAreaData((String) hshValues.get("conduct_turn")).equalsIgnoreCase("")){%>Nil
				<%}else{ %>
				<p><%=Helper.formatTextAreaData((String) hshValues.get("conduct_turn"))%></p>
				<%} %>
				</td>
			</tr>
			<%
				arrRow = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrBusinessTurnOver");
				if (arrRow != null && arrRow.size() > 0) {
			%>
			<tr>

				<td valign="top" colspan="5">
				<%
					for (int i = 0; i < arrRow.size(); i++) {
							out.println((String) arrRow.get(i));
						}
				%> &nbsp;</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>(2)
				Frequent excesses are given.</b> <b> </b></td>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" colspan="2"  class="just">
				<%if(Helper.formatTextAreaData((String) hshValues
						.get("conduct_excess")).equalsIgnoreCase("")){ %>Nil
				<%}else{ %>
				<p>
				<%=Helper.formatTextAreaData((String) hshValues
						.get("conduct_excess"))%> </p>
				<%} %>
				</td>
			</tr>
			<tr>
				<td valign="top" width="41%" class="subheading"><b>(3)
				Cheques are returned frequently.</b></td>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" colspan="2"  class="just">
				<%if(Helper.formatTextAreaData((String) hshValues
						.get("conduct_cheques")).equalsIgnoreCase("")){ %>Nil
				<%}else{ %>
				<p>
				<%=Helper.formatTextAreaData((String) hshValues
							.get("conduct_cheques"))%> </p>
				<%} %></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>19.&nbsp;</b></td>
				<td width="41%" valign="top" colspan="4"><b> COMPLIANCE TO
				TERMS OF SANCTION </b></td>
			</tr>

			<tr>
				<td valign="top" width="3%"><b>19.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Completion of Mortgage
				formalities</b></td>
				<%
					String selmort = Helper.correctNull((String) hshValues
							.get("exec_summ_mortage"));
					if (selmort.equalsIgnoreCase("1")) {
						selmort = "Yes";
					} else if (selmort.equalsIgnoreCase("2")) {
						selmort = "No";
					} else {
						selmort = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selmort%></b></td>
				<td valign="top" width="53%" class="just">&nbsp;</td>
			</tr>
			<%if(!Helper.formatTextAreaData((String) hshValues
					.get("exec_summ_mortageY")).equalsIgnoreCase("")){ %>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2" class="just">
				<p><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_mortageY"))%></p>
				</td>
			</tr>
			<%} %>
			<tr>
				<td valign="top" width="3%"><b>19.2.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Registration of charges
				with RoC</b></td>
				<%
					String selroc = Helper.correctNull((String) hshValues
							.get("exec_summ_roc"));
					if (selroc.equalsIgnoreCase("1")) {
						selroc = "Yes";
					} else if (selroc.equalsIgnoreCase("2")) {
						selroc = "No";
					} else {
						selroc = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc%>&nbsp;</b></td>
				<td valign="top" width="53%" class="just">
				<%if(Helper.formatTextAreaData((String) hshValues
						.get("exec_summ_rocY")).equalsIgnoreCase("")){ %>Nil
				<%}else{ %>
				<p><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_rocY"))%> </p>
				<%} %></td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>19.3.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Whether documents valid
				and in force</b></td>
				<%
					String selroc1 = Helper.correctNull((String) hshValues
							.get("exec_summ_validdoc"));
					if (selroc1.equalsIgnoreCase("1")) {
						selroc1 = "Yes";
					} else if (selroc1.equalsIgnoreCase("2")) {
						selroc1 = "No";
					} else {
						selroc1 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc1%>&nbsp;</b></td>
				<td valign="top" width="53%" class="just"><p>
				<%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_validdocY"))%></p></td>
			</tr>

			<tr>
				<td valign="top" width="3%"><b>19.4.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Whether all other terms
				and conditions complied with</b></td>
				<%
					String selroc2 = Helper.correctNull((String) hshValues
							.get("exec_summ_terms"));
					if (selroc2.equalsIgnoreCase("1")) {
						selroc2 = "Yes";
					} else if (selroc2.equalsIgnoreCase("2")) {
						selroc2 = "No";
					} else {
						selroc2 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc2%></b></td>
				<td valign="top" width="53%" class="just">
				<%
					String exec_summ_termsY = Helper.correctNull((String) hshValues
							.get("exec_summ_termsY"));
				%> <%
 	if (exec_summ_termsY.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_termsY, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>19.5.&nbsp;</b></td>
				<td width="41%" valign="top"><b>Compliance of RBI
				guidelines</b></td>
				<%
					String selroc3 = Helper.correctNull((String) hshValues
							.get("exec_summ_indlevelrbiY2"));
					if (selroc3.equalsIgnoreCase("1")) {
						selroc3 = "Yes";
					} else if (selroc3.equalsIgnoreCase("2")) {
						selroc3 = "No";
					} else {
						selroc3 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc3%></b></td>
				<td valign="top" class="just">
				<%
					String exec_summ_indlevelrbiremarks2 = Helper
							.correctNull((String) hshValues
									.get("exec_summ_indlevelrbiremarks2"));
				%> <%
 	if (exec_summ_indlevelrbiremarks2.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_indlevelrbiremarks2, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>19.6.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Whether consortium
				meetings held at prescribed periodic intervals</b></td>
				<%
					String selroc4 = Helper.correctNull((String) hshValues
							.get("exec_summ_meetingheld"));
					if (selroc4.equalsIgnoreCase("1")) {
						selroc4 = "Yes";
					} else if (selroc4.equalsIgnoreCase("2")) {
						selroc4 = "No";
					} else {
						selroc4 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc4%></b></td>
				<td valign="top" class="just">
				<%
					String exec_summ_meetingheldY = Helper
							.correctNull((String) hshValues
									.get("exec_summ_meetingheldY"));
				%> <%
 	if (exec_summ_meetingheldY.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_meetingheldY, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>19.7.&nbsp;</b></td>
				<td width="41%" valign="top"><b> Compliance on Loan Policy</b></td>
				<%
					String selroc5 = Helper.correctNull((String) hshValues
							.get("exec_summ_indlevelbankY2"));
					if (selroc5.equalsIgnoreCase("1")) {
						selroc5 = "Yes";
					} else if (selroc5.equalsIgnoreCase("2")) {
						selroc5 = "No";
					} else {
						selroc5 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selroc5%></b></td>
				<td valign="top" class="just">
				<%
					String exec_summ_indlevelbankremarks2 = Helper
							.correctNull((String) hshValues
									.get("exec_summ_indlevelbankremarks2"));
				%> <%
 	if (exec_summ_indlevelbankremarks2.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_indlevelbankremarks2, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>19.8.&nbsp;</b></td>
				<td width="41%" valign="top" colspan="3"><b> DATES OF
				INSPECTION DURING THE FINANCIAL YEAR</b></td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>&nbsp;</b></td>
				<td valign="top" colspan="3" class="just">
				<p>
				<%
					String exec_summ_dateofinspc2 = Helper
							.correctNull((String) hshValues
									.get("exec_summ_dateofinspc2"));
				%> <%
 	if (exec_summ_dateofinspc2.trim().equals("")) {
 %> Nil <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_dateofinspc2, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %>
				</p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>20.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> NATURE AND VALUE OF
				COLLATERAL SECURITY</b></td>
			</tr>
			<tr>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="32%"><b>Nature / Description of collateral
						security indicating area &amp; location of property</b></td>
						<td width="12%" align="center"><b> Value<BR>
						(<%=ApplicationParams.getCurrency()%>in <%=strProposalvalue%>)</b></td>
						<td width="19%"><b> Date of Valuation along with name of
						Valuer</b></td>
						<td width="21%"><b>Insurance Amount &amp; Date of Expiry</b></td>
						<td width="17%" align="center"><b> Remarks</b></td>
					</tr>
					<%
						ArrayList arrColldetails = new ArrayList();
						ArrayList arrValues = new ArrayList();
						arrColldetails = (ArrayList) hshValues.get("arrColldetails");
						double dbltotal = 0.00;
						if (arrColldetails != null && arrColldetails.size() != 0) {
							for (int i = 0; i < arrColldetails.size(); i++) {
								arrValues = (ArrayList) arrColldetails.get(i);
								dbltotal = dbltotal
										+ Double.parseDouble(Helper
												.correctDouble((String) arrValues.get(1)));
					%>
					<tr>
						<td width="32%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrValues
									.get(0))%>&nbsp;</td>
						<td width="12%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrValues
													.get(1))))%></td>
						<td width="19%" valign="top">&nbsp;<%=Helper.correctNull((String) arrValues.get(2))%>
						- <%=Helper.correctNull((String) arrValues.get(3))%></td>
						<td width="21%" align="center" valign="top">&nbsp; <%
 	if (Helper.formatDoubleValue(
 					Double.parseDouble(Helper
 							.correctDouble((String) arrValues.get(4))))
 					.equals("0.00")) {
 				out.println("-");
 			} else {
 %> <%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrValues
																		.get(4))))%> - <%=Helper.correctNull((String) arrValues
												.get(5))%></td>
						<%
							}
						%>
						<td width="17%" valign="top">&nbsp;<%=Helper.correctNull((String) arrValues.get(6))%></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td><b>Total</b></td>
						<td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td width="32%">&nbsp;</td>
						<td width="12%">&nbsp;</td>
						<td width="19%">&nbsp;</td>
						<td width="21%">&nbsp;</td>
						<td width="17%">&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>20.1.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> PERSONAL GUARANTEE (with
				means) / <br />
				CORPORATE GUARANTEE (with TNW of company)</b></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4" valign="top">
				<div id="top">
				<table width="60%" border="0" cellspacing="0" cellpadding="3">
					<%
						boolean bolguarantee = false;
						boolean corpguarantee = false;
						arrRow = new ArrayList();
						arrData = new ArrayList();

						arrRow = (ArrayList) hshValues.get("arrGuarantors");

						if (arrRow != null && arrRow.size() != 0) {
							bolguarantee = true;
					%>
					<tr align="center" class="tblhead ">
						<td width="60%" align="center"><b>Name</b></td>
						<td width="30%" align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td width="10%" align="center">Means As on</td>
					</tr>
					<tr align="center">
						<td align="left" colspan="3"><b>PERSONAL GUARANTEE</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								arrData = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="60%" align="left"><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
						<td width="30%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrData
													.get(4))))%></td>
						<td><%=Helper.correctNull((String) arrData.get(5))%></td>
					</tr>
					<%
						}
						}
					%>
					<%
						if (Helper.correctNull(
								(String) hshValues.get("sel_applicantguarantee"))
								.equalsIgnoreCase("Y")) {
							if (!bolguarantee) {
								bolguarantee = true;
					%>
					<tr align="center" class="tblhead ">
						<td width="60%" align="center"><b>Name</b></td>
						<td width="30%" align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td width="10%" align="center">Means As on</td>
					</tr>
					<%
						}
					%>
					<%
						if (!corpguarantee) {
								corpguarantee = true;
					%>

					<tr align="center">
						<td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
					</tr>
					<%
						}
					%>
					<tr align="center">
						<td width="60%" align="left"><%=Helper.correctNull((String) hshValues
								.get("comapp_companyname"))%>&nbsp;</td>
						<td width="30%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TangibleNetworth"))))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) hshValues
										.get("TNWason"))%>&nbsp;</td>
					</tr>
					<%
						}
					%>

					<%
						arrRow = new ArrayList();
						arrData = new ArrayList();
						arrRow = (ArrayList) hshValues.get("arrCorpguarantee");
						if (arrRow != null && arrRow.size() > 0) {
							if (!bolguarantee) {
								bolguarantee = true;
					%>

					<tr align="center" class="tblhead ">
						<td width="60%" align="center"><b>Name</b></td>
						<td width="30%" align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td width="10%" align="center">Means As on</td>
					</tr>
					<%
						}
					%>
					<%
						if (!corpguarantee) {
								corpguarantee = true;
					%>
					<tr align="center">
						<td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
					</tr>
					<%
						}
					%>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								arrData = (ArrayList) arrRow.get(i);
					%>
					<tr align="center">
						<td width="60%" align="left"><%=Helper.correctNull((String) arrData.get(0))%>&nbsp;</td>
						<td width="30%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrData
													.get(4))))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arrData.get(5))%></td>
					</tr>
					<%
						}
						}
					%>
				</table>
				</div>
				<%
					if (!bolguarantee) {
						out.print("Nil");
					}
				%>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="5%"><b>21.&nbsp;</b></td>
				<td width="41%" valign="top"><b> WHETHER THE NAME OF THE
				COMPANY / DIRECTORS FIGURE IN RBI DEFAULTERS'/CAUTION LIST / WILFUL
				DEFAULTERS / ECGC. IF YES, PLEASE FURNISH DETAILS.</b></td>
				<%
					String selrbi4 = Helper.correctNull((String) hshValues
							.get("company_rbi"));
					if (selrbi4.equalsIgnoreCase("1")) {
						selrbi4 = "Yes";
					} else if (selrbi4.equalsIgnoreCase("2")) {
						selrbi4 = "No";
					} else {
						selrbi4 = " ";
					}
				%>
				<td valign="top" width="10%"><b>:&nbsp;<%=selrbi4%></b></td>
				<td valign="top" colspan="2">&nbsp;</td>
				<%
					String company_rbidesc = Helper.correctEditor((String) hshValues
							.get("company_rbidesc"));
				%>
				<%
					if (company_rbidesc.trim().equals("")
							|| company_rbidesc.equalsIgnoreCase("<P>&nbsp;</P>")) {
				%>

				<td valign="top" width="44%" class="just">Nil &nbsp;</td>
				<%
					} else {
				%>

				<td valign="top" width="44%">&nbsp;</td>
			</tr>
			<tr>

				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="5"><%=company_rbidesc%></td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td valign="top" width="3%" rowspan="3"><b>21.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b> WHETHER DIRECTOR PARTNER /
				PROPRIETOR IS A DIRECTOR IN OUR / OTHER BANK OR IS RELATED TO THEM.
				IF YES
				<br>
				</b></td>
				<%
					String selrbi1 = Helper.correctNull((String) hshValues
							.get("exec_summ_indlevelrbiY"));
					if (selrbi1.equalsIgnoreCase("1")) {
						selrbi1 = "Yes";
					} else if (selrbi1.equalsIgnoreCase("2")) {
						selrbi1 = "No";
					} else {
						selrbi1 = " ";
					}
				%>
				<td valign="top" width="3%"><b>:&nbsp;<%=selrbi1%> </b></td>
				<td valign="top" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="41%" valign="top"><b>(1) Name of such Director
				with name of the Bank </b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just">
				<%
					String exec_summ_indlevelrbiremarks = Helper
							.correctNull((String) hshValues
									.get("exec_summ_indlevelrbiremarks"));
				%> <%
 	if (exec_summ_indlevelrbiremarks.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_indlevelrbiremarks, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td width="41%" valign="top"><b>(2) Type of Relation</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just">
				<%
					String exec_summ_indlevelbankremarks = Helper
							.correctNull((String) hshValues
									.get("exec_summ_indlevelbankremarks"));
				%> <%
 	if (exec_summ_indlevelbankremarks.trim().equals("")) {
 %> &nbsp; <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_indlevelbankremarks, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>21.2&nbsp;</b></td>
				<td width="41%" valign="top"><b> Any litigation in force
				against the firm/ company or against the Partners / Directors. If
				so, mention details and present position.</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just">
				<%
					String exec_summ_indlevelcomkeystrengths = Helper
							.correctNull((String) hshValues
									.get("exec_summ_indlevelcomkeystrengths"));
				%> <%
 	if (exec_summ_indlevelcomkeystrengths.trim().equals("")) {
 %> Nil <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(
 				exec_summ_indlevelcomkeystrengths, "\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>22.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> AUDIT OBSERVATIONS</b></td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>22.1.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> Internal Audit<%=Helper.correctNull((String) hshValues
							.get("audit_internal_date"))%> </b></td>
			</tr>
			<tr>

				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrInternal");
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">


					<tr>
						<td width="50%" align="center"><b>Audit Remark </b></td>
						<td width="50%" align="center"><b>Branch Reply</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
					</tr>


					<%
						}
					%>
				</table>
				</div>
				<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
				<%
					} else {
				%>
				<%=Helper.correctNull((String) hshValues
								.get("notapplicable"))%>
				<%
					}
				%>

			</tr>
			<tr>
				<td valign="top" width="3%"><b>22.2.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> Concurrent Audit<%=Helper.correctNull((String) hshValues
							.get("audit_concurrent_date"))%></b></td>
			</tr>
			<tr>
				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrConcurrent");
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr>
						<td width="50%" align="center"><b>Audit Remark </b></td>
						<td width="50%" align="center"><b>Branch Reply</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
					</tr>

					<%
						}
					%>
				</table>
				</div>
				<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
				<%
					} else {
				%>
				<%=Helper.correctNull((String) hshValues
								.get("notapplicable"))%>
				<%
					}
				%>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>22.3.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> Statutory Audit<%=Helper.correctNull((String) hshValues
							.get("audit_statutory_date"))%></b></td>
			</tr>
			<tr>
				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrStatutory");
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr>
						<td width="50%" align="center"><b>Audit Remark </b></td>
						<td width="50%" align="center"><b>Branch Reply</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
				<%
					} else {
				%>
				<%=Helper.correctNull((String) hshValues
								.get("notapplicable"))%>
				<%
					}
				%>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>22.4.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> RBI Inspection Audit<%=Helper.correctNull((String) hshValues
							.get("audit_inspection_date"))%></b></td>
			</tr>
			<tr>
				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrRBI");
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr>
						<td width="50%" align="center"><b>Audit Remark </b></td>
						<td width="50%" align="center"><b>Branch Reply</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
				<%
					} else {
				%>
				<%=Helper.correctNull((String) hshValues
								.get("notapplicable"))%>
				<%
					}
				%>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>22.5.&nbsp;</b></td>
				<td valign="top" colspan="4"><b> Stock Audit<%=Helper.correctNull((String) hshValues
							.get("audit_stock_date"))%></b></td>
			</tr>
			<tr>
				<%
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrStock");
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td colspan="5">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr>
						<td width="50%" align="center"><b>Audit Remark </b></td>
						<td width="50%" align="center"><b>Branch Reply</b></td>
					</tr>
					<%
						for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList();
								arrCol = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
				<%
					} else {
				%>
				<%=Helper.correctNull((String) hshValues
								.get("notapplicable"))%>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>23.&nbsp;</b></td>
				<td width="41%" valign="top"><b> ANY IRREGULAR FEATURE
				OBSERVED IN THE MONITORING REPORT</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_indlevelgenmanager"))%> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<%
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrExposure");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					out.println((String) arrRow.get(i));
				}
			}
		%>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>

	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>24.1.&nbsp;</b></td>
				<td valign="top" colspan="4"><b>DETAILS OF EXCESS ALLOWED
				DURING THE YEAR </b></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4" valign="top">
				<div id="top">
				<table width="50%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td colspan="2" align="right"><b>(Rs In <%=strProposalvalue%>)</b></td>
					</tr>
					<tr>
						<td width="50%" align="center"><b>No. of occasions
						excesses allowed</b></td>
						<td width="50%" align="center"><b> Maximum Excess Allowed</b></td>
					</tr>
					<tr>
						<td align="left"><%=Helper.correctNull((String) hshValues
							.get("EXEC_NOEXCESS"))%>&nbsp;</td>
						<td align="left"><%=Helper.correctNull((String) hshValues
							.get("EXEC_MAXEXCESS"))%>&nbsp;</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="5"><a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>24.2.&nbsp;</b></td>
				<td width="41%" valign="top"><b> OTHER EXPOSURE, IF
				ANY,INCLUDING INVESTMENTS</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just">
				<%
					String EXEC_OTHEXP = Helper.correctNull((String) hshValues
							.get("EXEC_OTHEXP"));
				%> <%
 	if (EXEC_OTHEXP.trim().equals("")) {
 %> Nil <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(EXEC_OTHEXP,
 				"\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>24.3.&nbsp;</b></td>
				<td width="41%" valign="top"><b> OTHER LIABILITIES OF
				DIRECTORS / PARTNERS [in their individual capacity]</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2" class="just">
				<%
					String EXEC_OTHLIAB = Helper.correctNull((String) hshValues
							.get("EXEC_OTHLIAB"));
				%> <%
 	if (EXEC_OTHLIAB.trim().equals("")) {
 %> Nil <%
 	} else {
 		StringTokenizer strIdV16c = new StringTokenizer(EXEC_OTHLIAB,
 				"\n");
 		while (strIdV16c.hasMoreTokens()) {
 			String strTempV = (String) strIdV16c.nextToken();
 			out.println(strTempV + "<br>");
 		}
 	}
 %> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="6%"><b>25.&nbsp;</b></td>
				<td colspan="4"><b> EXPOSURE DETAILS FROM BANKING SYSTEM
				(Incl. Our Bank)</b></td>
			</tr>
			<tr>
				<td colspan="5" align="right"><b>(<%=ApplicationParams.getCurrency()%>
				In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="25%" rowspan="2" align="center"><b>Name of the
						Bank</b></td>
						<td colspan="2" align="center"><b>Non-Fund Based</b></td>
						<td colspan="2" align="center"><b>Fund Based</b></td>
						<%-- %> <td width="16%" rowspan="2" align="center"><b>Term Loan</b></td>--%>
						<td width="25%" rowspan="2" align="center"><b>Conduct of
						the Account</b></td>
					</tr>
					<tr class="tblhead">
						<td width="12%" align="center"><b>%Share</b></td>
						<td width="13%" align="center"><b>Amt.</b></td>
						<td width="12%" align="center"><b>%Share </b></td>
						<td width="13%" align="center"><b>Amt.</b></td>
					</tr>

					<%
						ArrayList arrBankArrangement = (ArrayList) hshValues
								.get("arrBankArrangement");
						if (arrBankArrangement != null && arrBankArrangement.size() != 0) {
					%>
					<tr>
						<td colspan="6">Under Consortium</td>
					</tr>

					<%
						for (int i = 0; i < arrBankArrangement.size(); i++) {
								arr3 = new ArrayList();
								arr3 = (ArrayList) arrBankArrangement.get(i);
					%>
					<tr>
						<td width="25%"><%=arr3.get(0)%>&nbsp;</td>
						<td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(1))%></td>
						<td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(2))%></td>
						<td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(3))%></td>
						<td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(4))%></td>
						<%-- %>                  <td width="16%" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(5))))%></td>--%>
						<td width="25%" align="left"><%=Helper.correctNull((String) arr3.get(5))%>&nbsp;</td>
					</tr>
					<%
						}
						}
					%>
					<%
						arrBankArrangement = (ArrayList) hshValues.get("arrNonBankArrange");
						if (arrBankArrangement != null && arrBankArrangement.size() != 0) {
					%>
					<tr>
						<td colspan="6">Under Non Consortium</td>
					</tr>

					<%
						for (int i = 0; i < arrBankArrangement.size(); i++) {
								arr3 = new ArrayList();
								arr3 = (ArrayList) arrBankArrangement.get(i);
					%>
					<tr>
						<td width="25%"><%=arr3.get(0)%>&nbsp;</td>
						<td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(1))%></td>
						<td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(2))%></td>
						<td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(3))%></td>
						<td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) arr3.get(4))%></td>
						<td width="25%" align="left"><%=Helper.correctNull((String) arr3.get(5))%>&nbsp;</td>
					</tr>
					<%
						}
						}
					%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="6%"><b>25.1.&nbsp;</b></td>
				<td width="94%" valign="top"><b> CONDUCT OF THE ACCOUNT AND
				EXPOSURE DETAILS FROM FINANCIAL INSTITUTIONS :</b></td>
			</tr>
			<%
				arrBankArrangement = (ArrayList) hshValues
						.get("arrBankArrangementFI");
				if (arrBankArrangement != null && arrBankArrangement.size() != 0) {
			%>
			<tr>
				<td valign="top" width="6%">&nbsp;</td>
				<td width="80%" align="right"><b>(<%=ApplicationParams.getCurrency()%>
				in <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="31%" align="center" rowspan="2"><b>Name of the
						Bank</b></td>
						<td align="center" colspan="2"><b>Amount</b></td>
						<td align="center" width="16%" rowspan="2"><b>Remarks</b></td>
						<td align="center" width="15%" rowspan="2"><b>Over Due if
						any.</b></td>
					</tr>
					<tr class="tblhead">
						<td width="14%"><b>Fund Based</b></td>
						<td width="20%"><b>Non-Fund Based</b></td>
					</tr>
					<%
						for (int i = 0; i < arrBankArrangement.size(); i++) {
								arr3 = new ArrayList();
								arr3 = (ArrayList) arrBankArrangement.get(i);
					%>
					<tr>
						<td width="31%" valign="top"><%=arr3.get(0)%>&nbsp;</td>
						<td width="14%" valign="top" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(1))))%></td>
						<td width="20%" valign="top" align="right">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arr3
																	.get(2))))%></td>
						<td width="16%" valign="top"><%=Helper.formatTextAreaData((String) arr3.get(3))%></td>
						<td width="15%" valign="top"><%=Helper.formatTextAreaData((String) arr3.get(4))%></td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>25.2.&nbsp;</b></td>
				<td colspan="4"><b> VALUE OF ACCOUNT</b></td>
			</tr>
			<tr>
				<td colspan="5" align="right"><b>(<%=ApplicationParams.getCurrency()%>
				In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="4" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="29%" valign="top">Advances:</td>
						<td width="32%" valign="top" align="center" colspan="2">Previous
						Year<br>
						From:<%=Helper.correctNull((String) hshValues.get("EXEC_PFROM"))%>
						&nbsp;&nbsp;&nbsp;&nbsp;To:<%=Helper.correctNull((String) hshValues.get("EXEC_PTO"))%></td>
						<td width="39%" valign="top" align="center" colspan="2">Current
						Year<br>
						From:<%=Helper.correctNull((String) hshValues.get("EXEC_CFROM"))
							.equals("") ? "__/__/____" : Helper
					.correctNull((String) hshValues.get("EXEC_CFROM"))%>
						&nbsp;&nbsp;&nbsp;&nbsp;To:<%=Helper.correctNull((String) hshValues.get("EXEC_CTO"))
							.equals("") ? "__/__/____" : Helper
					.correctNull((String) hshValues.get("EXEC_CTO"))%></td>
					</tr>
					<tr>
						<td width="29%" valign="top">- Interest Income</td>
						<td width="32%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PINTINC"))))%></td>
						<td width="39%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CINTINC"))))%></td>
					</tr>
					<tr>
						<td width="29%" valign="top">-Feebased Income</td>
						<td width="32%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PFEEINC"))))%></td>
						<td width="39%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CFEEINC"))))%></td>
					</tr>
					<tr>
						<td rowspan="2" valign="top">Retail / Consumer / Finance (to
						employees associates)</td>
						<td width="16%" align="center" valign="top">No.of Accounts</td>
						<td width="16%" align="center" valign="top">Amount</td>
						<td width="19%" align="center" valign="top">No.of Accounts</td>
						<td width="20%" align="center" valign="top">Amount</td>
					</tr>
					<tr>
						<td width="16%" valign="top" align="left">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("EXEC_PNOACS"))%></td>
						<td width="16%" valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PRETAILAMT"))))%></td>
						<td width="19%" valign="top" align="left"><%=Helper.correctNull((String) hshValues
									.get("EXEC_CNOACS"))%>&nbsp;</td>
						<td width="20%" valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CRETAILAMT"))))%></td>
					</tr>
					<tr>
						<td rowspan="3" valign="top">
						<p>Deposit</p>
						<p>-Own -</p>
						<p>Third Party</p>
						</td>
						<td width="16%" align="center" valign="top">Amount</td>
						<td width="16%" align="center" valign="top">Tenor &amp; due
						date</td>
						<td width="19%" align="center" valign="top">Amount</td>
						<td width="20%" align="center" valign="top">Tenor &amp; due
						date</td>
					</tr>
					<tr>
						<td width="16%" height="35" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_POWNAMT"))))%></td>
						<td width="16%" height="35" valign="top" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_POWNTENORDATE"))%></td>
						<td width="19%" height="35" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_COWNAMT"))))%></td>
						<td width="20%" height="35" valign="top" align="left">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_COWNTENORDATE"))%></td>
					</tr>
					<tr>
						<td width="16%" height="43" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PTHIRDAMT"))))%></td>
						<td width="16%" height="43" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_PTHIRDTENORDATE"))%></td>
						<td width="19%" height="43" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CTHIRDAMT"))))%></td>
						<td width="20%" height="43" align="left">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_CTHIRDTENORDATE"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>25.3.&nbsp;</b></td>
				<td width="41%" valign="top"><b>RAROC</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues.get("EXEC_RAROC"))%></td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>25.4.&nbsp;</b></td>
				<td width="41%" valign="top"><b>DETAILS OF THE FOREIGN
				CURRENCY EXPOSURE COMMITMENTS AND UNHEDGED PORTION IF ANY.</b></td>
				<td valign="top" width="3%"><b>:</b></td>
				<td valign="top" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("FOREIGN_FLAG"))%></td>
			</tr>
			<%
				String FOREIGN_FLAG = Helper.correctNull((String) hshValues
						.get("FOREIGN_FLAG"));
				if (FOREIGN_FLAG.equalsIgnoreCase("YES")) {
			%>
			<tr>
				<td align="right" valign="bottom" colspan="5">(Amt. in USD,
				000' omitted)</td>
			</tr>
			<tr>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="3%" height="51">&nbsp;</td>
						<td width="34%" height="51"><b>Name of the Corporate</b></td>
						<td width="20%" height="51"><b>Amount of Exposure</b></td>
						<td width="20%" height="51"><b>Unhedged Portion</b></td>
						<td width="20%" height="51"><b>Due date for payment
						(Range)</b></td>
					</tr>
					<tr>
						<td width="5%" align="center">1.&nbsp;</td>
						<td width="34%">External Commercial Borrowings</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT1"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS1"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE1"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">2.&nbsp;</td>
						<td width="34%">Import usance bills received on collection
						basis duly accepted and outstanding</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT2"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS2"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE2"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">3.&nbsp;</td>
						<td width="34%">O/s. L/Cs &amp; PADs for import of
						goods/capital equipment.</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT3"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS3"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE3"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">4.&nbsp;</td>
						<td width="34%">Outstanding in packing credit for which the
						corporate is committed to submit export bills</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT4"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS4"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE4"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">5.&nbsp;</td>
						<td width="34%">Other Export Receivables</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT5"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS5"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE5"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">6.&nbsp;</td>
						<td width="34%">Others Import Obligations</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT6"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS6"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE6"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" height="48" align="center">7.&nbsp;</td>
						<td width="34%" height="48">Foreign currency loans availed
						from Authorised Dealers in India</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT7"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS7"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE7"))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="5%" align="center">8.&nbsp;</td>
						<td width="34%">Any other exposure: Please specify</td>
						<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_EXPAMT8"))))%></td>
						<td width="20%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("EXEC_UNHEDPOS8"))%></td>
						<td width="20%" align="left"><%=Helper.correctNull((String) hshValues
								.get("EXEC_DUEDATE8"))%>&nbsp;</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>26.&nbsp;</b></td>
				<td valign="top" colspan="2"><b>OPERATIONAL EXPERIENCE WITH
				REGARD TO GROUP CONCERNS</b></td>
				<td valign="bottom" align="right" colspan="2"><b>(Rs In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				<td colspan="5" valign="top">
				<div id="top">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%" rowspan="2" align="center">Name<br>
						of the <br>
						Concern</td>
						<td rowspan="2" width="15%" align="center">Branch</td>
						<td rowspan="2" width="10%" align="center">CoA</td>
						<td colspan="2" align="center">Contin-gent</td>
						<td colspan="3" align="center">FBWC</td>
						<td colspan="2" align="center">Term Loan</td>
						<td width="5%" rowspan="2" align="center">Investment</td>
						<td width="5%" rowspan="2" align="center">MOR</td>
						<td width="5%" rowspan="2" align="center">Irregularity,<br>
						if any</td>
					</tr>
					<tr>
						<td width="5%" valign="top">Limit</td>
						<td width="5%" valign="top">O/s</td>
						<td width="5%" valign="top">Limit</td>
						<td width="5%" valign="top">DP</td>
						<td width="5%" valign="top">O/s</td>
						<td width="5%" valign="top">Limit</td>
						<td width="5%" valign="top">O/s</td>
					</tr>
					<%
						if (operinfo != null && operinfo.size() > 0) {
							for (int j = 0; j < operinfo.size(); j++) {

								arryCol_grpcon = (ArrayList) operinfo.get(j);
					%>
					<tr>
						<td width="15%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arryCol_grpcon
									.get(13))%></font></td>
						<td width="15%" align="left">&nbsp;<font size="1"><%=Helper
											.correctNull((String) arryCol_grpcon
													.get(1))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper
											.correctNull((String) arryCol_grpcon
													.get(2))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(3))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(4))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(5))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(6))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(7))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(8))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(9))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(10))))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arryCol_grpcon
									.get(11))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arryCol_grpcon
									.get(12))%></font></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td width="15%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
						<td width="10%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="5%" valign="top">&nbsp;</td>
						<td width="10%" valign="top">&nbsp;</td>
						<td width="10%" valign="top">&nbsp;</td>
					</tr>
					<%
						}

						if (operinfo != null && operinfo.size() != 0) {
					%>
					<tr>
						<td width="15%"><b>Total Exposure</b></td>
						<td width="15%">&nbsp;</td>
						<td width="10%" valign="top">&nbsp;</td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCCOMLIMIT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCCOMOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCLT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCDP"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCTLLT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCTLOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCINS"))))%></font></td>
						<td width="10%" valign="top">&nbsp;</td>
						<td width="10%" valign="top">&nbsp;</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>26.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>COMMENTS ON OTHER BANK'S
				CREDIT REPORT ON SISTER CONCERNS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2" valign="top" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_comments"))%>&nbsp;</td>
			</tr>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
			<tr>
				<td width="3%" valign="top"><b>27.&nbsp;</b></td>
				<td width="41%" valign="top"><b>PRUDENTIAL EXPOSURE NORMS
				[inclusive of Bank's exposure in the form of investments like
				shares, debentures, CP, etc.]</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4">
				<div id="top">
				<table width="75%" border="0">
					<tr>
						<td>Constitution</td>
						<td>Prudential Limit in <b>(<%=ApplicationParams.getCurrency()%>
						in <%=strProposalvalue%>)</b></td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues
									.get("strownership"))%></td>
						<td align="right"><%=Helper
							.formatDoubleValue(Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("maxlimit"))))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4">
				<div id="top">
				<table width="75%" border="0">
					<tr>
						<td>Category</td>
						<td>Ceiling as % to Bank's Capital Funds</td>
						<td>Amount based on Capital Funds <b>(<%=ApplicationParams.getCurrency()%>
						in <%=strProposalvalue%>)</b></td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues.get("label"))%></td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("capital_funds"))))%></td>
						<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("capital_amt"))))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%if(!Helper.formatTextAreaData((String) hshValues
					.get("exposure_norms")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exposure_norms"))%></td>
			</tr>
			<%} %>
		</table>
		<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>28.&nbsp;</b></td>
				<td width="41%" valign="top"><b>COMMENTS ON ASSESSMENT OF
				LIMITS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="3%" valign="top"><b>28.1.&nbsp;</b></td>
				<td width="41%" valign="top"><b>PROJECTED LEVEL OF SALES</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2" valign="top">&nbsp;</td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("com_projectedsales_comments")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("com_projectedsales_comments"))%>
					<a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>28.2.&nbsp;</b></td>
				<td width="50%" valign="top"><b>INVENTORY &amp; RECEIVABLE
				NORMS</b></td>
				<td width="2%" valign="top">&nbsp;</td>
				<td valign="top" width="45%">&nbsp;</td>
			</tr>
			<%
				arrRow = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrHoldingvalues");

				if (arrRow != null && arrRow.size() > 0) {
			%>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<%
					for (int i = 0; i < arrRow.size(); i++) {
							out.println((String) arrRow.get(i));
				%> <%
 	}
 %>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td width="50%" valign="top"><b>COMMENTS ON HOLDING LEVELS</b></td>
				<td width="2%" valign="top"><b>:</b></td>
				<td valign="top" width="45%">&nbsp;</td>
			</tr>
			<%if(!Helper.correctEditor((String) hshValues
					.get("com_holdinglevel_comments")).equalsIgnoreCase("")){ %>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="3" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("com_holdinglevel_comments"))%></td>
			</tr>
			<%}else{ %>
			<tr>
				<td colspan="4"><a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan="5"><b>28.3.&nbsp;WORKING CAPITAL
				ASSESSMENT</b></td>
			</tr>
			<%
				if ((Helper.correctNull((String) hshValues.get("assessment_type"))
						.equalsIgnoreCase("TO"))
						|| (Helper.correctNull((String) hshValues
								.get("assessment_type")).equalsIgnoreCase("MPBF1"))
						|| (Helper.correctNull((String) hshValues
								.get("assessment_type")).equalsIgnoreCase("PBF2"))
						|| (Helper.correctNull((String) hshValues
								.get("assessment_type")).equalsIgnoreCase("PBF3"))) {

					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrFinAssesment");
					if (arrRow != null && arrRow.size() > 0) {
			%>
			<tr>
				<td>&nbsp;</td>
				<td width="95%" valign="top" colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					align="left">

					<%
						for (int i = 0; i < arrRow.size(); i++) {
									ArrayList arrCol = new ArrayList();
									arrCol = (ArrayList) arrRow.get(i);
									String strAlign = "";
									String strBold = "";
									String strstartBold = "";
									if (i < 2) {
										strAlign = "center";
										strstartBold = "<b>";
										strBold = "<b/>";
									} else {
										strAlign = "right";
										strstartBold = "";
										strBold = "";
									}
					%>
					<tr>
						<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
						<%
							if (!Helper.correctNull((String) arrCol.get(1)).equals(
												"")) {
						%>
						<td width="13%" align="<%=strAlign%>"><%=strstartBold%><%=Helper
													.correctNull((String) arrCol
															.get(1))%>&nbsp;<%=strBold%></td>
						<%
							}
										if (!Helper.correctNull((String) arrCol.get(2)).equals(
												"")) {
						%>
						<td width="13%" align="<%=strAlign%>"><%=strstartBold%><%=Helper
													.correctNull((String) arrCol
															.get(2))%>&nbsp;<%=strBold%></td>
						<%
							}
										if (!Helper.correctNull((String) arrCol.get(3)).equals(
												"")) {
						%>
						<td width="13%" align="<%=strAlign%>"><%=strstartBold%><%=Helper
													.correctNull((String) arrCol
															.get(3))%>&nbsp;<%=strBold%></td>
						<%
							}
										if (!Helper.correctNull((String) arrCol.get(4)).equals(
												"")) {
						%>
						<td width="13%" align="<%=strAlign%>"><%=strstartBold%><%=Helper
													.correctNull((String) arrCol
															.get(4))%>&nbsp;<%=strBold%></td>
						<%
							}
										if (!Helper.correctNull((String) arrCol.get(5)).equals(
												"")) {
						%>
						<td width="13%" align="<%=strAlign%>"><%=strstartBold%><%=Helper
													.correctNull((String) arrCol
															.get(5))%>&nbsp;<%=strBold%></td>
						<%
							}
						%>
					</tr>
					<%
						}

							}
					%>
				</table>
				</div>
				</td>
			</tr>

			<%
				} else if (Helper.correctNull(
						(String) hshValues.get("assessment_type"))
						.equalsIgnoreCase("CBM")) {
			%>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td width="41%" valign="top" colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr>
						<td colspan="3" align="center"><b>Calculation of MPBF</b></td>
					</tr>
					<tr>
						<td colspan="3">Peak Level Cash Deficit is &nbsp;<%=Helper.correctNull((String) hshValues
								.get("com_mbpfcshdeficit"))%> &nbsp;as of &nbsp;<%=Helper.correctNull((String) hshValues
								.get("com_mbpfcshdeficitof"))%>&nbsp; and Peak Build up of stock
						is in month of &nbsp;<%=Helper.getMonths(Integer.parseInt(Helper
								.correctInt((String) hshValues
										.get("com_mbpfstockmonth"))))%></td>
					</tr>
					<tr>
						<td colspan="3" height="46"><b>Drawing Power on the Basis
						of Peak Build up of stock is as follows: </b></td>
					</tr>
					<tr>
						<td colspan="3" height="44">
						<p>Peak Level of Stock Build up during the season from &nbsp;
						<%=Helper.getMonths(Integer.parseInt(Helper
								.correctInt((String) hshValues
										.get("com_mbpfseasonfrom"))))%> to&nbsp;<%=Helper.getMonths(Integer.parseInt(Helper
								.correctInt((String) hshValues
										.get("com_mbpfseasonto"))))%>&nbsp;(Year)&nbsp;<%=Helper.correctNull((String) hshValues
								.get("com_mbpfseasonyear"))%>&nbsp; for&nbsp;<%=Helper.correctNull((String) hshValues
								.get("com_mbpftotaltonnes"))%> Tonnes @ <%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpftonnesrupees"))))%> Per Tonn</p>
						</td>
					</tr>
					<tr>
						<td width="40%">Total Stock Holding</td>
						<td width="15%"><%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%></td>
						<td width="45%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpfpertonn"))))%></td>
					</tr>
					<tr>
						<td width="40%">Less : Sundry Creditors</td>
						<td width="15%"><%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>.</td>
						<td width="45%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpfsundry"))))%></td>
					</tr>
					<tr>
						<td width="40%">Less: Margin on the above @ <%=Helper.correctNull((String) hshValues
								.get("com_mbpfmarginper"))%> %</td>
						<td width="15%"><%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%></td>
						<td width="45%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpfmarginvalue"))))%></td>
					</tr>
					<tr>
						<td width="40%">Drawing Power for the Stock</td>
						<td width="15%"><%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%></td>
						<td width="45%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpfdp"))))%></td>
					</tr>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td width="40%" height="55">Working Capital Eligible</td>
						<td width="15%" height="55"><%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%></td>
						<td width="45%" height="55"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("com_mbpfwc"))))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5%" valign="top">&nbsp;</td>
				<td width="41%" valign="top"><b>COMMENTS ON ASSESSMENT</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="42%" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top">&nbsp;</td>
				<td colspan="3" valign="top"><%=Helper.correctEditor((String) hshValues
							.get("com_limitassessmnent_comments"))%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>28.4.&nbsp;</b></td>
				<td width="41%" valign="top"><b>TERM LOAN ASSESSMENT</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor(
							(String) hshValues.get("com_termloan_comments"))
							.trim()%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>28.5.&nbsp;</b></td>
				<td width="47%" valign="top"><b>ASSESSEMENT OF NON-FUND
				LIMITS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.correctEditor(
							(String) hshValues.get("com_nonfund_comments"))
							.trim()%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5%" valign="top"><b>28.6.&nbsp;</b></td>
				<td width="53%" valign="top"><b>ASSESSEMENT OF
				EXPORT/IMPORT LIMITS</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top" width="42%">&nbsp;</td>
			</tr>
			<tr>
				<td width="3%" valign="top">&nbsp;</td>
				<td colspan="3" valign="top"><%=Helper.correctEditor(
							(String) hshValues.get("com_assessment_comments"))
							.trim()%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>29.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CONSORTIUM ARRANGEMENT</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top" width="42%" class="just">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3"><%=Helper.correctEditor((String) hshValues
							.get("consortium_assessment"))%> &nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5%" valign="top"><b>30.&nbsp;</b></td>
				<td valign="top" width="40%"><b>OTHER MATTERS :</b></td>
				<%
					String other_matters = Helper.correctEditor((String) hshValues
							.get("other_matters"));
					if (other_matters.trim().equals("")
							|| other_matters.equalsIgnoreCase("<P>&nbsp;</P>")) {
				%>
				<td valign="top" width="55%" class="just">Nil &nbsp;</td>
				<%
					} else {
				%>
				<td valign="top" width="55%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="2"><%=other_matters%></td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%" valign="top"><b>31.&nbsp;</b></td>
				<td width="41%" valign="top"><b>CREDIT RATING</b></td>
				<td width="3%" valign="top">&nbsp;</td>
				<td valign="top" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" colspan="4">
				<%
					arrRow = new ArrayList();
					arrData = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrRow16");
					int ratesize = 0;
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td width="42%" align="center"><b>Parameters</b></td>
						<td colspan="2" align="center"><b>Marks obtained</b></td>
					</tr>
					<tr>
						<td width="42%"><b>Score Sheet for Bank Model</b></td>
						<td width="29%" align="center"><b>PreviousYr.</b></td>
						<td width="29%" align="center"><b>Current Yr.</b></td>
					</tr>
					<%
						ratesize = arrRow.size();
							for (int i = 0; i < ratesize; i++) {
								arrData = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td width="42%">&nbsp;<%=Helper.correctNull((String) arrData.get(0))%></td>
						<td width="29%">&nbsp;<%=Helper.correctNull((String) arrData.get(1))%></td>
						<td width="29%">&nbsp;<%=Helper.correctNull((String) arrData.get(2))%></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td width="42%">Borrower Rating</td>
						<td width="29%"><%=Helper.correctNull((String) hshValues
								.get("lastrating_basemodel"))%></td>
						<td width="29%"><%=Helper.correctNull((String) hshValues
								.get("currentrating_basemodel"))%></td>
					</tr>
					<tr>
						<td width="42%">Risk Definition</td>
						<td width="29%"><%=Helper.correctNull((String) hshValues
								.get("lastgradef_basemodel"))%></td>
						<td width="29%"><%=Helper.correctNull((String) hshValues
								.get("currentgradef_basemodel"))%></td>
					</tr>
				</table>

				</div>
				<%
					}
				%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%">&nbsp;</td>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td width="42%"><b>Score Sheet for CRISIL Model</b></td>
						<td width="13%">Grade</td>
						<td width="14%">Score</td>
						<td width="15%">Grade</td>
						<td width="16%">Score</td>
					</tr>
					<tr>
						<td width="42%">Borrower Rating</td>
						<td width="13%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("lastrating_dynamicmodel"))%></td>
						<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("lastscore_dynamicmodel"))%></td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("currentrating_dynamicmodel"))%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("currentscore_dynamicmodel"))%></td>
					</tr>
					<tr>
						<td width="42%">Facility Rating</td>
						<td width="13%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("facilityrating_dm_prevyear"))%></td>
						<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("facilityratingscore_dm_prevyear"))%></td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("facilityrating_dm_curryear"))%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("facilityratingscore_dm_curryear"))%></td>
					</tr>
					<tr>
						<td width="42%">Combined Rating</td>
						<td width="27%" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("lastcombinedrating_dm"))%></td>
						<td width="31%" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("currentcombinedrating_dm"))%></td>
					</tr>
					<tr>
						<td width="42%">Risk Definition</td>
						<td width="27%" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("lastgradef_dynamicmodel"))%></td>
						<td width="31%" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("currentgradef_dynamicmodel"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%--
                	ArrayList arrrate3=new ArrayList();
                	ArrayList arrrate4=new ArrayList();
                	arrrate3=(ArrayList)hshValues.get("arrRow17");
                	int ratesize1=0;
                	if(arrrate3!=null && arrrate3.size()>0)
                	{
                	%>
        <tr> 
          <td colspan="5"><a href="#" class="highlight_pagebreak"><span title="pagebreak"  onPaste="window.event.returnValue=false"  onKeyPress="allowEnterOnly()"></span></a>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"></td>
          <td valign="top" colspan="4"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td colspan="5"><b>RATING OF THE BORROWER</b></td>
                </tr>
                <tr> 
                  <td width="5%" valign="top"> 
                    <div align="center"><b>SL.</b></div>
                  </td>
                  <td width="46%"><b>PARAMETER</b></td>
                  <td width="16%"> 
                    <div align="center"><b>SCORE</b></div>
                  </td>
                  <td width="16%"> 
                    <div align="center"><b>VALUE</b></div>
                  </td>
                  <td width="17%"> 
                    <div align="center"><b>SECURED</b></div>
                  </td>
                </tr>
                <%String strParameter="",paraflag="N";
                	
                	ratesize1=arrrate3.size();
                		for(int i=0;i<ratesize1;i++)
                		{
                			arrrate4=(ArrayList)arrrate3.get(i);
                			strParameter=Helper.correctNull((String)arrrate4.get(1));
                		if(strParameter.equals("Financial Risk")|| strParameter.equals("Cash Flow related parameters") || strParameter.equals("Management Risk") || strParameter.equals("Market-Industry Risk")|| strParameter.equals("Rating of the Facility")|| strParameter.equals("Business Considerations") )	
                		{
                			paraflag="Y";
                		}
                		else
                		{
                			paraflag="N";
                		}
                %>
                <tr> 
                  <td width="5%" valign="top">&nbsp;<%=i+1%></td>
                  <%if(paraflag.equalsIgnoreCase("Y"))
                  { 
                	  strParameter=strParameter.toUpperCase();
                  %>
                  <td width="46%">&nbsp;<b><%=strParameter%></b></td>
                  <%}else{ 
                  %>
                  <td width="46%">&nbsp;<%=strParameter%></td>
                  <%} %>
                  <td width="16%">&nbsp;<%=Helper.correctNull((String)arrrate4.get(2))%></td>
                  <td width="16%">&nbsp;<%=Helper.correctNull((String)arrrate4.get(3))%></td>
                  <td width="17%">&nbsp;<%=Helper.correctNull((String)arrrate4.get(4))%></td>
                </tr>
                <%} %>
              </table> 
            </div>
          </td>
        </tr>
       <%
                	
               	}
                	
              --%>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%"><b>32.&nbsp;</b></td>
				<td width="41%" valign="top"><b> INDICATE PRODUCTS /
				SERVICES PROPOSED TO BE MARKETED TO CUSTOMER:</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td width="44%" valign="top" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("ind_services"))%>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="3%" rowspan="8"><b>33.&nbsp;</b></td>
				<td width="41%" valign="top"><b> BANK'S EXPOSURE TO
				INDUSTRY <BR>
				(BSR Code:<%=Helper.correctNull((String) hshValues
							.get("comapp_companyid"))%>) </b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td colspan="2"><b>Activity:</b>&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues
							.get("comapp_businessnature"))%></td>
			</tr>
			<tr>
				<td align="left"><b>Industry Exposure Limit as per loan
				policy</b></td>
				<td align="left"><b>:</b></td>
				<td colspan="2" align="left"><b><%=ApplicationParams.getCurrency()%>
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("indgrpexplimit"))))%> <%=strProposalvalue%> </b></td>
			</tr>
			<tr>
				<td align="left"><b>Bank's Present Exposure to this
				Industry</b></td>
				<td align="left"></td>
				<td colspan="2" align="left">&nbsp;</td>
			</tr>
			<tr>
				<td align="left">Total Sanctioned limit as on <b><%=Helper.correctNull((String) hshValues.get("asondate"))%></b></td>
				<td align="left"><b>:</b></td>
				<td colspan="2" align="left"><b><%=ApplicationParams.getCurrency()%>
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("indgrpexpsanclimit"))))%> <%=strProposalvalue%> </b></td>
			</tr>
			<tr>
				<td align="left">Present O/s as on <b><%=Helper.correctNull((String) hshValues.get("asondate"))%></b></td>
				<td align="left"><b>:</b></td>
				<td colspan="2" align="left"><b><%=ApplicationParams.getCurrency()%>
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("indgrpexpos"))))%> <%=strProposalvalue%> </b></td>
			</tr>
			<tr>
				<td align="left">Available Limit for sanction as on <b><%=Helper.correctNull((String) hshValues.get("asondate"))%></b></td>
				<td align="left"><b>:</b></td>
				<td colspan="2" align="left"><b><%=ApplicationParams.getCurrency()%>
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("indgrpremaing"))))%> <%=strProposalvalue%> <%
 	if (Helper.correctNull((String) hshValues.get("strnegflag"))
 			.equalsIgnoreCase("y")) {
 %> * <%
 	}
 %> </b></td>
			</tr>
			<%
				if (Helper.correctNull((String) hshValues.get("strnegflag"))
						.equalsIgnoreCase("y")) {
			%>
			<tr>
				<td align="left" colspan="4">* - (Minus sign indicates that the
				industry exposure limit is already exceeded)</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="4" align="right"><b>(<%=ApplicationParams.getCurrency()%>
				In <%=strProposalvalue%>)</b>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td width="26%">
						<div align="center"><b>Classification of Asset</b></div>
						</td>
						<td width="15%">
						<div align="center"><b>No. of A/cs.</b></div>
						</td>
						<td width="24%">
						<div align="center"><b>Fund Based limits</b></div>
						</td>
						<td width="24%">
						<div align="center"><b>Non Fund Based limits</b></div>
						</td>
						<td width="11%">
						<div align="center"><b>Total</b></div>
						</td>
					</tr>
					<tr>
						<td width="26%">Standard</td>
						<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTL1"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTL2"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTL3"))%></td>
						<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTL4"))%></td>
					</tr>
					<tr>
						<td width="26%">Sub-Standard</td>
						<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTOL1"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTOL2"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTOL3"))%></td>
						<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_finTOL4"))%></td>
					</tr>
					<tr>
						<td width="26%">Doubtful</td>
						<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincurrentratio1"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincurrentratio2"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincurrentratio3"))%></td>
						<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincurrentratio4"))%></td>
					</tr>
					<tr>
						<td width="26%">Loss</td>
						<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_findscr1"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_findscr2"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_findscr3"))%></td>
						<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_findscr4"))%></td>
					</tr>
					<tr>
						<td width="26%">
						<div align="center"><b>TOTAL</b></div>
						</td>
						<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincovratio1"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincovratio2"))%></td>
						<td width="24%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincovratio3"))%></td>
						<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("exec_summ_fincovratio4"))%></td>
					</tr>
					<tr>
						<td colspan="5"><b>* to be filled in at Central Office
						level.</b></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="5%"><b>34.&nbsp;</b></td>
				<td width="95%"><b> SUMMARY OF CHANGES IN SANCTION TERMS,
				IF ANY</b></td>

			</tr>
			<tr>
				<td valign="top" width="5%">&nbsp;</td>
				<td valign="top" width="95%">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td align="center"><b> Terms of Sanction </b></td>
						<td align="center"><b> Stipulated earlier</b></td>
						<td align="center"><b> Present</b></td>
						<td align="center"><b> Now recommended</b></td>
					</tr>

					<%
						arrRow = new ArrayList();
						arrRow = (ArrayList) hshValues.get("arrsummaryfac");
						String strFacility = "";
						if (arrRow != null && arrRow.size() > 0) {
					%>

					<%
						for (int i = 0; i < arrRow.size(); i++) {
								arrData = new ArrayList();
								arrData = (ArrayList) arrRow.get(i);
								if (strFacility.equalsIgnoreCase("")
										|| !strFacility.equalsIgnoreCase((String) arrData
												.get(0))) {
									strFacility = (String) arrData.get(0);
					%>
					<tr>
						<td colspan="4"><b><%=arrData.get(0)%></b></td>
					</tr>
					<%
						}
								if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("pc")) {
					%>
					<tr>
						<td valign="top">Processing charges</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("ps")) {
					%>
					<tr>
						<td valign="top">Primary security (give details)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("cs")) {
					%>
					<tr>
						<td valign="top">Collateral security (give details)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("pcg")) {
					%>
					<tr>
						<td valign="top">Personal /Corporate
						guarantees(Name/means/TNW)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("roi")) {
					%>
					<tr>
						<td valign="top">Rate of Interest(fixed or floating)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("mar")) {
					%>
					<tr>
						<td valign="top">Margin(%)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("lclg")) {
					%>
					<tr>
						<td valign="top">Commission for L/c,LG,DPGL(%)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("remit")) {
					%>
					<tr>
						<td valign="top">Commission on remittances and other
						services(please specify)</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(1))
										.equalsIgnoreCase("othr")) {
					%>
					<tr>
						<td valign="top">Other Matters</td>
						<td valign="top"><%=arrData.get(2)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(4)%>&nbsp;</td>
						<td valign="top"><%=arrData.get(3)%>&nbsp;</td>
					</tr>
					<%
						}
							}
						}
					%>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					<%
						arrRow = new ArrayList();
						arrRow = (ArrayList) hshValues.get("arrsummary");
						if (arrRow != null && arrRow.size() > 0) {
							for (int i = 0; i < arrRow.size(); i++) {
								arrData = new ArrayList();
								arrData = (ArrayList) arrRow.get(i);
								if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("pc")) {
					%>
					<tr>
						<td valign="top"><b>Processing charges</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("ps")) {
					%>
					<tr>
						<td valign="top"><b>Primary security (give details)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("cs")) {
					%>
					<tr>
						<td valign="top"><b>Collateral security (give details)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("pcg")) {
					%>
					<tr>
						<td valign="top"><b>Personal /Corporate
						guarantees(Name/means/TNW)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("roi")) {
					%>
					<tr>
						<td valign="top"><b>Rate of Interest(fixed or floating)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("mar")) {
					%>
					<tr>
						<td valign="top"><b>Margin(%)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("lclg")) {
					%>
					<tr>
						<td valign="top"><b>Commission for L/c,LG,DPGL(%)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("othr")) {
					%>
					<tr>
						<td valign="top"><b>Other Matters</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						} else if (Helper.correctNull((String) arrData.get(0))
										.equalsIgnoreCase("remit")) {
					%>
					<tr>
						<td valign="top"><b>Commission on remittances and other
						services(please specify)</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(1))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(3))%>&nbsp;</td>
						<td valign="top"><%=Helper.formatTextAreaData((String) arrData
										.get(2))%>&nbsp;</td>
					</tr>
					<%
						}
					%>
					<%
						}
						}
					%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td width="5%" valign="top"><b>35.&nbsp;</b></td>
				<td width="39%" valign="top"><b>Delegated Authority</b></td>
				<td width="3%" valign="top"><b>:</b></td>
				<td valign="top" colspan="2" width="53%">&nbsp;</td>
			</tr>
			<%if(!Helper.formatTextAreaData(
					(String) hshValues.get("exec_delegated")).trim().equalsIgnoreCase("")){ %>
			<tr>
				<td width="5%" valign="top">&nbsp;</td>
				<td colspan="4" valign="top"><%=Helper.formatTextAreaData(
							(String) hshValues.get("exec_delegated")).trim()%></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<%
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRecommen");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					out.println((String) arrRow.get(i));
				}
			}
		%>
		</td>

	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" width="5%"><b>36.2.&nbsp;</b></td>
				<td valign="top"><b>TERMS AND CONDITIONS:</b></td>
			</tr>
			<%
				arrRow = new ArrayList();
				arrData = new ArrayList();
				arrRow = (ArrayList) hshValues.get("arrRow12");
				if (arrRow != null && arrRow.size() != 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrData = (ArrayList) arrRow.get(i);
			%>
			<tr>
				<td valign="top" width="5%">&nbsp;<%=i + 1%>.</td>
				<td valign="top" class="just"><%=Helper
											.formatTextAreaData((String) arrData
													.get(0))%>&nbsp;</td>
			</tr>
			<%
				}
				}
			%>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="10%" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td valign="top" align="left">Submitted for Approval</td>
			</tr>
			<tr>
				<td colspan="2"><a href="#" class="highlight_pagebreak"><span
					title="pagebreak" onPaste="window.event.returnValue=false"
					onKeyPress="allowEnterOnly()"></span></a>&nbsp;</td>
			</tr>
			<%
				if (!Helper.correctNull(
						(String) hshValues.get("exec_mcmresolution"))
						.equalsIgnoreCase("")) {
			%>
			<tr>
				<td width="10%" valign="top">&nbsp;</td>
				<td valign="top" align="left" class="just"><b>Resolution:</b><br>
				<br>
				<b>If approved,</b> the MANAGEMENT COMMITTEE <b>is requested to
				adopt the following resolution. </b><br>
				<br>
				<%=Helper.formatTextAreaData((String) hshValues
								.get("exec_mcmresolution"))%></td>
			</tr>

			<%
				}
			%>
			<tr>
				<td valign="top" align="left" colspan="2">&nbsp;<br>
				<br>
				</td>
			</tr>
			<tr>
				<td width="10%" valign="top">&nbsp;</td>
				<td valign="top" align="left"><b><%=Helper.correctNull((String) hshValues
							.get("exec_signatures"))%></b></td>
			</tr>
			<%
				if (!Helper
						.correctNull((String) hshValues.get("exec_gridcomments"))
						.equalsIgnoreCase("")) {
			%>
			<tr>
				<td valign="top" align="left" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="10%" valign="top">&nbsp;</td>
				<td valign="top" class="just"><%=Helper.correctNull((String) hshValues
								.get("exec_gridcomments"))%></td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>
</body>
</html>