<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Securities</title>
<script language="JavaScript">
function showDistSearch(val)
{  

	var varstate = document.forms[0].hidstate.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].hidstate.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_City.focus();
		return;
	}
	if(document.forms[0].txt_City.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_City.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}
function callOK()
{
	window.opener.document.forms[0].hidcity.value=document.forms[0].hidcity.value;
	window.opener.document.forms[0].txt_City.value=document.forms[0].txt_City.value;
	window.opener.document.forms[0].hidstate.value=document.forms[0].hidstate.value;
	window.opener.document.forms[0].txt_State.value=document.forms[0].txt_State.value;
	window.opener.document.forms[0].hid_District.value=document.forms[0].hid_District.value;
	window.opener.document.forms[0].txt_District.value=document.forms[0].txt_District.value;
	window.opener.document.forms[0].hidPropertycheck.value="Y";
	window.close();
}
function callClose()
{
	window.close();
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow-y: scroll; overflow-x: hidden">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="colForm" method="post" class="normal">
<table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
 <tr class="dataheader">
<td colspan="4">Property Details</td>
</tr>	
<tr class="datagrid">
<td>City <span class="mantatory">*&nbsp;</span></td>
<td>
	<input type="text" name="txt_City" size="30" value="<%=Helper.correctNull((String)request.getParameter("strCityDesc")) %>" maxlength="10" readonly="readonly">
	<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)request.getParameter("strCityCode")) %>">
	<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)request.getParameter("strStateCode")) %>">&nbsp;
	<a href="#"
		onClick="showCitySearch('txt_City','txt_State','hidcity','hidstate','txt_PinCode','hidzip')"
		style="cursor: hand"> <img
		src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
		border="0" tabindex="15"></a>
</td>
<td>State <span class="mantatory">*&nbsp;</span></td>
<td>
	<input type="text" name="txt_State" size="30" value="<%=Helper.correctNull((String)request.getParameter("strStateDesc")) %>" maxlength="10" readonly="readonly">
</td>
</tr>
<tr class="datagrid">
<td>District <span class="mantatory">*&nbsp;</span></td>
<td>
	<input type="text" name="txt_District" size="30" value="<%=Helper.correctNull((String)request.getParameter("strDistDesc")) %>"
	readonly="readonly" maxlength="10" tabindex="16">&nbsp;
	<a href="#"
				onClick="showDistSearch('PROP');"
				style="cursor:hand" tabindex="22"><img
				src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
				border="0" ></a>
		<input type="hidden" name="hid_District" size="5" value="<%=Helper.correctNull((String)request.getParameter("strDistCode")) %>">	
								
</td>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
</tr>
<tr><td colspan="4" align="center"><input type=button value="Ok" name="cmdsave" tabindex="25" class="buttonStyle" onClick="callOK()">
&nbsp;<input type=button value="Close" name="closebtn" tabindex="25" class="buttonClose" onClick="callClose()"></td></tr>
</table>
</form>
</body>
</html>
