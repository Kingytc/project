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

var path="<%=ApplicationParams.getAppUrl()%>";
var varstr_reportmis="<%=str_reportmis%>"

function doRunReport()
{
	var varcbsid =document.forms[0].idacno.value;
	var varusrid=document.forms[0].usr_id.value;
	if(varstr_reportmis=="C")
	{
		document.forms[0].method="post";
		var purl = path+"action/custdetrun.jsp?hidBeanId=repapptrack&hidBeanMethod=getData&hidMethod=getProposalReport&varcbsid="+varcbsid;
		var title = "Report";
		var prop = "scrollbars=Yes,toolbars=No,menubar=no ,width=1000 , height=550,top=10,left=0";		
		window.open(purl,title,prop);
	}
	else if(varstr_reportmis="U")
	{
		document.forms[0].method="post";
		var purl = path+"action/custdetrun.jsp?hidBeanId=repapptrack&hidBeanMethod=getData&hidMethod=getUserProposalReport&varusrid="+varusrid;
		var title = "Report";
		var prop = "scrollbars=Yes,toolbars=No,menubar=no ,width=1000 , height=550,top=10,left=0";		
		window.open(purl,title,prop);
	}
		
	
}

function onload()
{
	if(varstr_reportmis=="C")
	{
		document.all.field.style.visibility="visible";
		document.all.field.style.position="relative";   
		document.all.field1.style.visibility="hidden";
		document.all.field1.style.position="absolute";
	}
	else if(varstr_reportmis="U")
	{
		document.all.field1.style.visibility="visible";
		document.all.field1.style.position="relative";   
		document.all.field.style.visibility="hidden";
		document.all.field.style.position="absolute";
	}
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].reset();
		document.forms[0].action = path+"action/repnav.jsp";
		document.forms[0].submit();
	}
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?pagename=rep";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
function callUsersHelp()
{
	var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=rep";
	var title = "Users";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
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
							<tr id="field">
							 	<td width="20%" align="center">CBS ID</td>
							  <td width="15%" align="center"> <input type="text" name="idacno" maxlength="20" size="25">
							  </td>
<!--							  <td><input type="text" name="txt_cusname" readonly="readonly" size="25">&nbsp; <span onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img-->
<!--					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"-->
<!--					border="0"></span></td>-->
							</tr>
							<tr id="field1">
							 	<td width="20%" align="center">USER ID</td>
							  <td width="15%" align="center"> <input type="text" name="usr_id" maxlength="20" size="25"></td>
<!--							  <td><input type="text" name="txt_usrname" readonly="readonly" size="25">&nbsp;-->
<!--							  <a href="#" onClick="javascript:callUsersHelp()"><img-->
<!--								src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"-->
<!--								border="0"> </a> </td>-->
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
<lapschoice:combuttonnew btnnames="Run Report" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidreprtmis" value="<%=str_reportmis%>"/>
</form>
</body>
</html>
