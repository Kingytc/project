<%@include file="../share/directives.jsp"%>
<%String appno="";
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
appno = Helper.correctNull((String)request.getParameter("appno"));
String strPageFrm = Helper.correctNull((String)request.getParameter("pageFrm"));
if(strPageFrm.equalsIgnoreCase(""))
{	
	strPageFrm = Helper.correctNull((String)hshValues.get("strpageFrm"));
}
String strprdCode="";
if(strPageFrm.equalsIgnoreCase("P"))
{
	strprdCode = Helper.correctNull((String)request.getParameter("prdCode"));
	if(strprdCode.equalsIgnoreCase(""))
	{
		strprdCode = Helper.correctNull((String)hshValues.get("prdCode"));
	}
	arrRow = (ArrayList)hshValues.get("arrRow");
}
else
{
	if(appno.equalsIgnoreCase(""))
	{
		appno = Helper.correctNull((String)hshValues.get("strappno"));
	}
}
%>
<html>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 325;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varPageFrm = "<%=strPageFrm%>";

function doRemove()
{
	if(document.forms[0].sel_unusedaccounts.value == "0")
	{
		alert("Please select one account");
		document.forms[0].sel_unusedaccounts.focus();
		return;
	}
	else
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidSourceUrl.value="/action/restr_remove_accts.jsp";
		document.forms[0].hidBeanGetMethod.value="updateUnusedAccounts";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doChange()
{
	if(document.forms[0].txt_facnew_limit.value == "")
	{
		alert("Why hurry?? Enter the New Limit you want to update and proceed..");
		return;
	}
	if(document.forms[0].txt_facnew_limit.value == document.forms[0].txt_facold_limit.value)
	{
		alert("Oops!! You are trying to give the same value.");
		return;
	}
	if(document.forms[0].txt_facnew_limit.value < document.forms[0].txt_facold_limit.value)
	{
		alert("New Limit cannot be lesser than Present Limit!!");
		return;
	}
	if(ConfirmMsg(194))
	{
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidSourceUrl.value="/action/restr_remove_accts.jsp?varPageFrm="+varPageFrm;
	 	document.forms[0].hidBeanMethod.value="updatenewSancLimit";
		document.forms[0].hidBeanGetMethod.value="getnewSancLimit";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function Onloading()
{
	if(varPageFrm == "P")
	{
		document.forms[0].cmdchange.disabled = false;
		document.forms[0].txt_facold_limit.readOnly = true;
	}
	else
	{
		document.forms[0].cmdremove.disabled = false;
	}
}

function doClose()
{
	if(varPageFrm == "P")
	{
		window.opener.document.forms[0].hidBeanId.value="setproducts";
		window.opener.document.forms[0].hidBeanGetMethod.value="getData";
		window.opener.document.forms[0].action=appURL+"action/setproducts.jsp";	
		window.opener.document.forms[0].method="post";
		window.opener.document.forms[0].submit();
		window.close();
	}
	else
	{
		window.opener.document.forms[0].hidBeanId.value="facilities";
		window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
		window.opener.document.forms[0].action=appURL+"action/facilities.jsp";	
		window.opener.document.forms[0].method="post";
		window.opener.document.forms[0].submit();
		window.close();
	}
}
</SCRIPT>
<body onload="Onloading();">
<form name="facility" method="post" class="normal">
<br><br>
<table width="98%" border="0" cellspacing="1" cellpadding="2" class="outertable border1" align="center">
<tr align="center">
<td class="dataheader"><b>
<%if(strPageFrm.equalsIgnoreCase("P")){%>Loan product Limit change for Staff Housing Loan<%}else{%>Remove the Unused accounts from the proposal<%}%>
</b></td>
</tr>
<tr><td>
<table width="80%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center">
<%if(strPageFrm.equalsIgnoreCase("P")){%>
<tr><td colspan="3">&nbsp;</td></tr>
<tr><td colspan="3">&nbsp;</td></tr>
<tr><td width="10%">&nbsp;</td><td width="20%">Present Limit</td><td width="30%"><input type="text" name="txt_facold_limit" value="<%=Helper.correctDouble((String)hshValues.get("present"))%>"></td></tr>
<tr><td>&nbsp;</td><td>New Limit</td><td><input type="text" name="txt_facnew_limit" value=""></td></tr>
<tr><td colspan="3">&nbsp;</td></tr>
<%if(arrRow !=null && arrRow.size()>0){%>
<tr><td colspan="3">
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align="center">
<tr><td colspan="5">Limit Changes History</td></tr> 
<tr class="dataheader">
<td align="center" width="5%">S.no</td>
<td align="center" width="40%">Changed by</td>
<td align="center" width="25%">Changed on</td>
<td align="center" width="15%">Old value</td>
<td align="center" width="15%">New Value</td>
</tr>
<%for(int i=0;i<arrRow.size();i++){
arrCol = (ArrayList)arrRow.get(i); %>
<tr class="datagrid">
<td align="center"><%=i+1%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(0))%></td>
<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
<td align="right"><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)))%></td>
<td align="right"><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))%></td>
</tr>
<%}%>
</table>
</td></tr>
<%} %>
<tr><td colspan="3">&nbsp;</td></tr>
<tr><td colspan="3" align="center" font="color:red">Kindly don't use the (X) to close the window. Use the Close button </td></tr>
<%}else{%>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr align="center">
<td>List of accounts which is not used for any process in this proposal</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr align="center">
<td>
<select name="sel_unusedaccounts">
<option value="0">--- Select ---</option>
<lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='restr'/>
</select>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td align="center" font="color:red">Kindly don't use the (X) to close the window. Use the Close button </td></tr>
<%}%>
</table>
</td></tr>
</table>
<br><br>
<%if(strPageFrm.equalsIgnoreCase("P")){%>
<lapschoice:combuttonnew btnnames='Change' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidPrdCode" value="<%=strprdCode%>">
<%}else{ %>
<lapschoice:combuttonnew btnnames='Remove' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidappno" value="<%=appno%>">
<%}%>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
