<%@include file="../share/directives.jsp"%>
<%ArrayList arrycattle = new ArrayList();

			arrycattle = (ArrayList) hshValues.get("arrcattle");

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="form1" method="post" class="normal"><br>
<br>
<table width="25%" border="0" align="center" cellspacing="1" cellpadding="3" class="outertable border1">
	<tr class="dataheader">
		<td><b>Year</b></td>
		<td><b>Adults</b></td>
		<td><b>Female Calves</b></td>
		<td><b>Male Calves</b></td>
	</tr>

	<%if (arrycattle != null && arrycattle.size() != 0) {
				ArrayList arrydata = new ArrayList();
				for (int i = 0; i < arrycattle.size(); i++) {
					arrydata = (ArrayList) arrycattle.get(i);

					%>
	<tr>
		<td><%=arrydata.get(1)%></td>
		<td><%=arrydata.get(2)%></td>
		<td><%=arrydata.get(3)%></td>
		<td><%=arrydata.get(4)%></td>
	</tr>
	<%}
			}

			%>


</table>
<table width="98%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
	<tr>
		<td><b><u>Assumption:</u></b></td>
	</tr>
	<%String sel_calves = Helper.correctNull((String) hshValues
					.get("sel_calves"));
			if (sel_calves.trim().equalsIgnoreCase("2")) {

			%>
	<tr>
		<td>The expense for rearing female calves is compensated through
		selling of female calves. Hence the expenses for rearing of female
		calves and income from sale of female calves is not taken in cash
		flow.</td>
	</tr>
	<%}

		%>
	<tr>
		<td>All male calves are sold</td>
	</tr>
	<tr>
		<td>The expense for rearing male calves is compensated through selling
		of male calves. Hence the expenses for rearing of male calves and
		income from sale of male calves is not taken in cash flow.</td>
	</tr>
	<tr>
		<td>Male to female calving ratio is 50:50</td>
	</tr>
	<tr>
		<td>Rate of mortality of calves is 5%</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag /> 
</form>
</body>
</html>

