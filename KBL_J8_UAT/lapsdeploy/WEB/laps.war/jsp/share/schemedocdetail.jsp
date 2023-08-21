<%@include file="../share/directives.jsp"%>
<%ArrayList arrValues = new ArrayList();
			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCust");
			}%>
<html>
<head>
<title>Documents to be collected</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function setValues(values)
{
	var table=window.opener.document.getElementById("table");
	var rowCount=table.rows.length; 

	for(var i=0;i<rowCount;i++)
	{ 
		if(rowCount>1)
		{
			if(window.opener.document.forms[0].docname[i].value==values)
			{
				alert("Document already selected");
				return;
			}
		}
		else
		{
			if(window.opener.document.forms[0].docname.value==values)
			{
				alert("Document already selected");
				return;
			}
		}
	}
	
	var row=table.insertRow(rowCount++);
	var cell1=row.insertCell(0);
	var cell2=row.insertCell(1);
	
	cell1.innerHTML="<td ><input type='checkbox' checked='checked' name='doccheckbx'  style='border=none;'></td>";
	cell2.innerHTML="<td ><input type='text' size='60' name='docname' readonly='readonly'  value='"+values +"'></td>";

	window.opener.document.forms[0].area_details.value=window.opener.document.forms[0].area_details.value+"\n"+values;
	window.opener.document.all.iddoc.style.display="none";	
}
function doClose()
{
	window.close();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>CheckList for Documents to be Collected</b></td>
	</tr>
	<tr>
		<td>&nbsp;<span class="mantatory"><b>Please Select the Documents which
		are required but not received</b></span></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
							<tr class="dataheader">
								<td width="20%"><b>Scheme</b></td>
								<td width="80%"><b>Documents</b></td>
							</tr>						
							<%String pre_value = "";
			if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					if (arrCol != null) {
						if (i > 0) {
							ArrayList arrCol1 = new ArrayList();
							arrCol1 = (ArrayList) arrValues.get(i - 1);
							pre_value = Helper.correctInt((String) arrCol1
									.get(0));
						} else {
							pre_value = "0";
						}
						arrCol = (ArrayList) arrValues.get(i);%>
							<tr class="datagrid">
								<%if (Integer.parseInt(Helper.correctInt((String) arrCol.get(0))) > Integer.parseInt(pre_value)) {%>
								<td width="30%"><b><%=Helper.correctNull((String) arrCol.get(1))%></b></td>
								<%} else {%>
								<td width="20%">&nbsp;</td>
								<%}%>
								<td width="80%"><a
									href="javascript:setValues('<%=Helper.replaceForJavaScriptString((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>
							</tr>
							<%}}}%>
							<tr class="datagrid">
								<td width="20%">&nbsp;</td>
								<td width="80%">&nbsp;</td>
							</tr>
				</table>						
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br> 
</form>
</body>
</html>
