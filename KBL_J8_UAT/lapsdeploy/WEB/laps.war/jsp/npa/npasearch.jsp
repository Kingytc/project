<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>NPA-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varClass = "<%=Helper.correctNull((String)request.getParameter("classid"))%>";

function showBlank()
{
	document.all.result.src=appUrl+'action/blank.jsp';
}

function doReset()
{
	document.forms[0].reset();
	document.all.result.src=<%=ApplicationParams.getAppUrl()%>+'action/blank.jsp';
}
	

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function doNew()
{
	document.forms[0].hidBeanGetMethod.value="checkOLDApplication";
	document.forms[0].hidBeanId.value="npa";
	var varmoduletype=document.forms[0].moduletype.value;
	
	
	if(document.forms[0].moduletype.value=="OTSCO")
	{
		if(varClass == "001")
		{
			alert("You Cannot Create New Compromise Proposal For Regular Type of Customer");
			return false;
		}
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/CompromiseProposal_generalinfo.jsp?appno=NEW";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="PAWO")
	{
		if(varClass == "001")
		{
			alert("You Cannot Create New Write Off For Regular Type of Customer");
			return false;
		}
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/prudential_general.jsp?appno=NEW";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="SARFI")
	{
		if(varClass == "001")
		{
			alert("You Cannot Create New SARFAESI Proposal For Regular Type of Customer");
			return false;
		}
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/SarfaeriProposal_page1.jsp?appno=NEW";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="SUIT")
	{
		if(varClass == "001")
		{
			alert("You Cannot Create New Filing of SUIT For Regular Type of Customer");
			return false;
		}
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/34PointsFormat_page1.jsp?appno=NEW";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<%if (Helper.correctNull(
					(String) request.getParameter("hidmoduletype"))
					.equalsIgnoreCase("OTSCO")) {%>
			<tr>
				<td class=page_flow>Home -&gt; NPA -&gt; Compromise Proposal -&gt;
				Application Search</td>
			</tr>
			<%} else if (Helper.correctNull(
					(String) request.getParameter("hidmoduletype"))
					.equalsIgnoreCase("PAWO")) {

			%>
			<tr>
				<td class=page_flow>Home -&gt; NPA -&gt; Write Off -&gt; Application
				Search</td>
			</tr>
			<%} else if (Helper.correctNull(
					(String) request.getParameter("hidmoduletype"))
					.equalsIgnoreCase("SARFI")) {%>
			<tr>
				<td class=page_flow>Home -&gt; NPA -&gt; SARFAESI Proposal -&gt;
				Application Search</td>
			</tr>
			<%} else if (Helper.correctNull(
					(String) request.getParameter("hidmoduletype"))
					.equalsIgnoreCase("SUIT")) {%>
			<tr>
				<td class=page_flow>Home -&gt; NPA -&gt; Filing of SUIT -&gt;
				Application Search</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td align="center" id="yearchk"><%if (Helper.correctNull((String) request.getParameter("moduletype"))
					.equalsIgnoreCase("OTSCO")) {
				if (strGroupRights.charAt(18) == 'w'
						&& (strOrgLevel.equals("A"))) {

				%> <input type="button" name="cmdNew"
									value="New Compromise Proposal" class="buttonStyle"
									style="width:175;height:20" onClick="doNew()"> <%}
			} else if (Helper.correctNull(
					(String) request.getParameter("moduletype"))
					.equalsIgnoreCase("PAWO")) {
				if (strGroupRights.charAt(18) == 'w'
						&& (strOrgLevel.equals("A"))) {%> <input type="button"
									name="cmdNew" value="New Write Off" class="buttonStyle"
									style="width:175;height:20" onClick="doNew()"> <%}
			} else if (Helper.correctNull(
					(String) request.getParameter("moduletype"))
					.equalsIgnoreCase("SARFI")) {
				if (strGroupRights.charAt(18) == 'w'
						&& (strOrgLevel.equals("A"))) {

				%> <input type="button" name="cmdNew" value="New SARFAESI Proposal"
									class="buttonStyle" style="width:175;height:20" onClick="doNew()"> <%}
			} else if (Helper.correctNull(
					(String) request.getParameter("moduletype"))
					.equalsIgnoreCase("SUIT")) {

				%> <%if (strGroupRights.charAt(18) == 'w'
						&& (strOrgLevel.equals("A"))) {%> <input type="button"
									name="cmdNew" value="New Filing of SUIT" class="buttonStyle"
									style="width:175;height:20" onClick="doNew()"> <%}
			}

			%></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center" class="outertable">
					<tr>
						<td valign="top" id="searchheading">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
							<tr align="center" class="dataheader">
								<td width="24%">Application No.</td>
								<td width="51%">Borrower Name</td>
								<td width="25%">Status</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top"><iframe id="result"
							src="<%=ApplicationParams.getAppUrl()%>action/nparesult.jsp?hidBeanGetMethod=getNPADataFinal&hidBeanId=borrowersearch&appid=<%=Helper.correctNull((String)request.getParameter("appid"))%>&moduletype=<%=Helper.correctNull((String)request.getParameter("moduletype"))%>&apptype=<%=Helper.correctNull((String)request.getParameter("hidborrowertype"))%>&appname=<%=Helper.correctNull((String)request.getParameter("appname"))%>"
							width="100%" height=300> </iframe></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<input type="hidden" name="moduletype" value="<%=Helper.correctNull((String)request.getParameter("moduletype"))%>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("appid"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
