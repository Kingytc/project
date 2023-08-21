<%@include file="../share/directives.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
if(hshValues != null)
{
	arrRow = (ArrayList) hshValues.get("arrRow");
}
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=ApplicationParams.getAppUrl()%>css/anylinkmenu.css" />
<link rel="stylesheet" type="text/css" href="<%=ApplicationParams.getAppUrl()%>css/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script type="text/javascript">
var appurl = "<%=ApplicationParams.getAppUrl()%>";
var varPageName = "<%=Helper.correctNull((String)hshValues.get("strPageName"))%>";

function doAdd()
{
	if(document.forms[0].sel_pagenames.value == "")
	{
		alert("Select a particular Page to add the user");
		return;
	}
	else
	{
		document.forms[0].hidAction.value = "insert";
		var varQryString = appurl+"action/setUserSearch.jsp?frompage=page_access";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);	
	}
}

function doDelete()
{
	alert("Delete option is currently not available");
	return;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function onLoad()
{
	document.forms[0].sel_pagenames.value = varPageName;
}

function doRemove(arrayval)
{
	if(confirm("Do you want to remove the access for the user"))
	{
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidSno_Val.value = arrayval;
		document.forms[0].hidSourceUrl.value="/action/setUserPageAccess.jsp";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateUserPageControl";	
		document.forms[0].hidBeanGetMethod.value="getUserPageControl";	
		document.forms[0].action=appurl+"controllerservlet";
		document.forms[0].submit();
	}
}

function reloadPage()
{
	document.forms[0].hidSourceUrl.value="/action/setUserPageAccess.jsp";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getUserPageControl";	
	document.forms[0].action=appurl+"controllerservlet";
	document.forms[0].submit();
}

function UserEntry()
{
	<%if (arrRow!=null && arrRow.size() > 1) {
		for (int i = 0; i < arrRow.size(); i++) {%>
			if(document.forms[0].hid_UserID[<%=i%>].value == document.forms[0].txt_user_id.value)
			{
				alert("User Already Exists");
				return;
			}
	<%}}else if(arrRow!=null && arrRow.size() == 1){%>
		if(document.forms[0].hid_UserID.value == document.forms[0].txt_user_id.value)
		{
			alert("User Already Exists");
			return;
		}
	<%}%>
	document.forms[0].hidSourceUrl.value="/action/setUserPageAccess.jsp";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateUserPageControl";	
	document.forms[0].hidBeanGetMethod.value="getUserPageControl";	
	document.forms[0].action=appurl+"controllerservlet";
	document.forms[0].submit();
}

</script>
<title>User Page Access Controls</title>
</head>
<body onload="onLoad()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="page_flow">
		<td valign="bottom">Home -&gt;Setup -&gt; Administrator level controls-&gt; User Page Access Control</td>
	</tr>
</table>
<br><br><br><br>
<table width="90%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
<tr><td>
	<table width="70%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
		<tr>
			<td class="dataheader" align="center" width="25%">Access to the Page</td>
			<td class="datagrid" align="center" width="25%">
				<select name="sel_pagenames" onChange="reloadPage()">
				<option value="">---- Select ----</option>
				<option value="NPA">NPA Provisioning</option>
				<option value="FVC">Fair Value Calculation</option>
				<option value="NSDL">NSDL Application Management</option>
				<option value="RRM">Reference Rate Master</option>
				<option value="SHG">SKDRDP Upload access</option>
			</td>
			<td align="center" width="20%"><input type="button" name="cmdAdd" value="Add a New User" onClick="doAdd()" class="buttonOthers"></td>
		</tr>
		<tr>
			<td colspan="3"><input type="hidden" name="txt_user_id"></td>
		</tr>
	</table>	
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>
	<table width="10%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
	<tr><td>
	<input type="button" name="cmdClose" value="Close" onClick="doClose()" class="buttonClose">
	</td></tr>
	</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>
	<table width="80%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td align="center" width="5%">S.No</td>
			<td align="center" width="10%">User ID</td>
			<td align="center" width="25%">User Name</td>
			<td align="center" width="25%">User Location</td>
			<td align="center" width="15%">Action</td>
		</tr>
		<%if(arrRow!=null && arrRow.size()>0){
			for(int i=0;i<arrRow.size();i++){
				arrCol = (ArrayList)arrRow.get(i); %>		
		<tr class="datagrid">
			<td align="center"><%=i+1%>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;<input type="hidden" name="hid_UserID" value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
			<td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td>
			<td align="center"><input type="button" name="cmdRemove" value="Remove User Access" onClick="doRemove(<%=Helper.correctNull((String)arrCol.get(0))%>)" class="buttonOthers"></td>
		</tr>
		<%}}else{ %>
		<tr class="datagrid">
			<td colspan="5" align="center">None of the Users were Assigned</td>
		</tr>
		<%} %>
	</table>	 
</td></tr>
</table> 
<lapschoice:hiddentag pageid="<%=PageId%>" /> 
<input type="hidden" name="hidSno_Val">
</body>
</html>