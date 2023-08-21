<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String applicantoldid = Helper.correctNull((String) request.getParameter("applicantoldid"));
	String searchType = Helper.correctNull((String) request.getParameter("searchtype"));
	String strBtnenable= Helper.correctNull((String) session.getAttribute("strBtnenable"));
	
	
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	if (hshValues != null)
		arrRow = (ArrayList) hshValues.get("arrRow");
	String strLevel=Helper.correctNull((String)session.getAttribute("strOrgLevel"));
%>
<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCustomerName='<%=Helper.correctNull((String) request.getParameter("customername"))%>';
var varAppid='<%=Helper.correctNull((String) request.getParameter("appid"))%>';
var varstrusrid='<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>';
var varoldAppid='<%=Helper.correctNull((String) request.getParameter("hidoldId"))%>';
var varapprovedAppl_demoid="<%=Helper.correctNull((String) hshValues.get("str_approvedAppl_demoid"))%>";
var varOccupationCode="<%=Helper.correctNull((String) hshValues.get("strOccupationCode"))%>";

function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/com_searchsolvency.jsp";
		document.forms[0].submit();
	}
}

function doNew()
{
	if(varapprovedAppl_demoid=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		return;
	}
	if(varOccupationCode=="MIGR")
	{
		alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile");
		return;
	}
	document.forms[0].hidAction.value = "new";
	var varappid="<%=applicantoldid%>";
	document.forms[0].action = appURL + "action/com_solvency.jsp?hidBeanGetMethod=getSolvencyData&hidBeanId=comsolvency&customername="+varCustomerName+"&appid="+varAppid;
	document.forms[0].hidoldId.value=varoldAppid;
	document.forms[0].method="post";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function callToSolvencyLink(appno,status,holder,appid)
{
	if(varstrusrid!=holder)
	{
	alert("The Application is with " + holder + " So you cannot modify data in this application"); 
	}
	document.forms[0].hidApplno.value=appno;
	document.forms[0].hidAppid.value=appid;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getSolvencyData";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_solvency.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
			<td class="page_flow" colspan="4">Home -> Solvency -> Proposal
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top"><br>
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td valign="top" align="center">
								<table width="60%" border="0" cellspacing="0" cellpadding="0"
									align="center" class="outertable border1">
									<tr>
										<td align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="datagrid" align="center">
												<td><B>Borrower Name:&nbsp;<%=Helper.correctNull((String) request.getParameter("customername"))%></B>
												</td>
												<%if(strLevel.equalsIgnoreCase("A") && strGroupRights.charAt(18)=='w'){ %>
												<td>
												<input type="button" name="cmdnew" value="New Proposal"
													onClick="doNew()" class="buttonStyle" /> 
												</td>
												<%} %>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
							<tr valign="top">
								<td id="searchheading">
								<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center"
									class="outertable">
									<tr class="dataheader" align="center">
										<td width="10%">Application No.</td>
										<td width="20%">Process Status</td>
										<td width="7%">Holder</td>
									</tr>
									<%if (arrRow != null && arrRow.size() > 0) {
								
										for (int i = 0; i < arrRow.size(); i++) {
											arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid" align="center">
								 	<td align="center">
		                           <a href="javascript:callToSolvencyLink('<%=Helper.correctNull((String) arrCol.get(0))%>',
		                           '<%=Helper.correctNull((String) arrCol.get(1))%>',
		                           '<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>') "><%=Helper.correctNull((String) arrCol.get(0))%> </a>
                                 </td>
								 	<%String strAppstatus=Helper.correctNull((String) arrCol.get(1));
								 	String strAppstat="";
								 	if(strAppstatus.equalsIgnoreCase("OP"))
								 	{
								 		strAppstat="Open/Pending";
								 	}
								 	else if(strAppstatus.equalsIgnoreCase("PA"))
								 	{
								 		strAppstat="Process/Approved";
								 	}
								 	else if(strAppstatus.equalsIgnoreCase("PR"))
								 	{
								 		strAppstat="Process/Rejected";
								 	}
								 	else if(strAppstatus.equalsIgnoreCase("CA"))
								 	{
								 		strAppstat="Closed/Approved";
								 	}
								 	else if(strAppstatus.equalsIgnoreCase("CR"))
								 	{
								 		strAppstat="Closed/Rejected";
								 	}
								 	%> 
									<td align="center"><%=strAppstat%></td>
									<td align="center"><%=Helper.correctNull((String) arrCol.get(2))%></td>
									</tr>
									<%}} %>		
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="middle">
				<td align="center"><input type="button" name="cmdclose"
					value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidPageType"
	value="<%=request.getParameter("hidPageType")%>"> <input
	type="hidden" name="hidapplicantid"> <lapschoice:hiddentag
	pageid='<%=PageId%>' />
	
<input type="hidden" name="hidApplno">
<input type="hidden" name="hidAppid">
<input type="hidden" name="hidoldId">
	</form>
</body>
</html>
