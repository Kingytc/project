<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
String str_reportmis= Helper.correctNull((String) request.getParameter("hidreportmis"));
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>

var appURL="<%=ApplicationParams.getAppUrl()%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("strstatus"))%>";


function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action = appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callUsersHelp()
{
	var varQryString = appURL+"action/setLockedUserSearch.jsp";
	var title = "Users";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
function doUnlock()
{
	if(document.forms[0].txt_user_id.value=="")
	{
		alert("Select User ID");
		return;
	}
	document.forms[0].hidBeanId.value="setusers"
	document.forms[0].hidBeanGetMethod.value="UnLockUsers";
	document.forms[0].action=appURL+"action/setsacuser.jsp";
	document.forms[0].submit();
}
function onload()
{
	if(varstatus=="Y")
	{
		alert("User unlocked successfully");
	}
	document.forms[0].cmdunlock.disabled=true;
}
function getUserDetails()
{
	if(document.forms[0].txt_user_id.value!="")
	{
		document.all.ifrm1.src=appURL+"action/ifrmSACUserChk.jsp?hidBeanGetMethod=getLockedUserSearchData&hidBeanId=setusers&userStatus=id&txt_user_id_name="+document.forms[0].txt_user_id.value;
	}
}
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
</head>

<body onload="onload();">
<form name="custdet" method="post" class="normal">
<div align="center">
<h3></h3></div>


<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3" align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="50%" border="0" cellspacing="0" cellpadding="3" align="center">
							<tr>
							 	<td width="20%" align="center">USER ID</td>
							  <td width="15%" align="center" nowrap="nowrap"> <input type="text" name="txt_user_id"  readonly="readonly" maxlength="10" size="15" onblur="getUserDetails();"> 
							  &nbsp; <input type="text" name="txt_username" maxlength="20" size="35" readonly="readonly"> <a href="#" onClick="javascript:callUsersHelp()"><img
								src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
								border="0"> </a> </td>
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
</table>
<br>
<lapschoice:combuttonnew btnnames="Unlock" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe height="0" width="0" id="ifrm1" frameborder="0"	style="border: 0"></iframe>
</form>
</body>
</html>
