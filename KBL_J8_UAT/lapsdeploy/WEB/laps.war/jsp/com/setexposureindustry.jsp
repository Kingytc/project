<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	if (hshValues != null)
		arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></meta>
<title>Exposure To Industry</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function doNew()
{
    disabled_New(false);
	disableButtons(true,true,false,false,true,false);	
	document.forms[0].reset();	
	document.forms[0].hidAction.value="insert";
	document.forms[0].sel_active.disabled = false;
	document.forms[0].sel_active.value = "S";
}
function onLoading()
{	document.forms[0].sel_active.disabled = true;
	disableButtons(false,true,true,true,true,false);
	disabled_New(true);
}
function disableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function disabled_New(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=="")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
	}
}
function doEdit()
{
	disabled_New(false);
	document.forms[0].sel_active.disabled = false;
	disableButtons(true,true,false,false,false,false);
	document.forms[0].hidAction.value="update";	
}
function doSave() {
	if(document.forms[0].txt_activity.value == "")
	{
		ShowAlert('121'," Activity");
		document.forms[0].txt_activity.focus();
		return;
	}
	if(document.forms[0].sel_active.value == "S")
	{
		ShowAlert('111'," Active");
		document.forms[0].sel_active.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidPageId.value = "setupnav";
	document.forms[0].hidBeanId.value = "facilitymaster";
	document.forms[0].hidBeanMethod.value = "updateexposureindustry";
	document.forms[0].hidBeanGetMethod.value = "getexposureindustry";
	document.forms[0].hidSourceUrl.value = "/action/setexposureindustry.jsp";
	document.forms[0].action = appUrl + "action/ControllerServlet";
	document.forms[0].submit();
}	
function doClose() 
{
if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidPageId.value = "setupnav";
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="facilitymaster";
	document.forms[0].hidBeanMethod.value="updateexposureindustry";	
	document.forms[0].hidBeanGetMethod.value="getexposureindustry";				
	document.forms[0].hidSourceUrl.value="action/setexposureindustry.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}
}
function doCancel()
{
	if (ConfirmMsg(102))
	{	document.forms[0].hidPageId.value = "setupnav";
		document.forms[0].hidBeanId.value = "facilitymaster";
		document.forms[0].hidBeanMethod.value = "updateexposureindustry";
		document.forms[0].hidBeanGetMethod.value = "getexposureindustry";
		document.forms[0].action=appURL+"action/setexposureindustry.jsp";
		document.forms[0].submit();
	}
}
function setValues(val1,val2,val3)
{
	document.forms[0].txt_activity.value=val1;
	document.forms[0].hidSno.value=val2;
	if(!val3=="")
		document.forms[0].sel_active.value=val3;
	else
		document.forms[0].sel_active.value="S";
	disableButtons(true,false,true,true,false,false);	
}

</script>
<body onload="onLoading()">
<form>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corporate &
		Agriculture Products -&gt; Exposure To Industry</td>
	</tr>
</table>
<br>
<table class="outertable border1" width="70%" border="0" cellpadding="80"
	cellspacing="0" align="center">
	<tr>
		<td>
		<table class="outertable" width="80%" border="0" cellpadding="5"
			 cellspacing="1" align="center">
			<tr>
				<td>
				<table class="outertable" width="60%" border="0" cellspacing="1" cellpadding="3"
					 align="center">
					<tr class="datagrid">
						<td width="30%" align="right">Activity</td>
						<td width="70%" align="left"><input type="text"
							name="txt_activity" maxlength="50" /><input type="hidden"
							name="hidSno">
					</tr>
					 <tr id="action" class="datagrid">
						<td align="right">Active</td>
						 <td width=""><select name="sel_active">
						 <option value="S" selected="selected">--Select--</option>
						 <option value="E">Enable</option>
						  <option value="D">Disable</option>
						 </select>
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
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_' btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		<lapschoice:hiddentag pageid='<%=PageId%>' />
<br>

<table cellpadding="3" cellspacing="1" align="center" width="70%">
	<tr class="dataheader">
		<td align="center" width="10%">&nbsp;</td>
		<td align="center" width="40%"><b>SINO</b></td>
		<td align="center" width="40%"><b>Activity</b></td>
	</tr>
</table>

<div class="cellContainer">

<%
	if (arrRow != null && arrRow.size() > 0) {

		for (int i = 0; i < arrRow.size(); i++) {
			arrCol = (ArrayList) arrRow.get(i);
%>

<table cellpadding="3" cellspacing="1" align="center" width="70%"
	class="outertable">
	<tr class="datagrid">
		<td width="10%"><input type="radio" name="rdo_select"
			style="border: none;"
			onclick="setValues('<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(2))%>');">
		</td>
		<td align="center" width="40%"><%=Helper.correctNull((String) arrCol.get(0))%></td>
		<td align="left" width="40%"><%=Helper.correctNull((String) arrCol.get(1))%></td>
	</tr>
</table>
<%
	}
	} else {
%>


<table cellpadding="3" cellspacing="1" align="center" width="70%"
	class="outertable">
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr class="datagrid">
		<td colspan="2" align="center"><b>--- No Records to display
		---</b></td>
	</tr>
	<tr class="datagrid">
		<td colspan="2">&nbsp;</td>
	</tr>
	<%
		}
	%>
</table>
</div>



</form>
</body>
</html>





