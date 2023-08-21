<%@include file="../share/directives.jsp"%>
<%
String strloadFlag=Helper.correctNull((String)hshValues.get("strLoadFlag"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Other Deposit Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script>
var varstrloadFlag="<%=strloadFlag%>";
var pagefrom="";
function onLoad()
{
	document.forms[0].cmdsave.disabled=false;
	pagefrom=document.forms[0].hidPageFrom.value;
	if(varstrloadFlag=="Y")
	{
		window.opener.loadParent();
		window.close();
	}
}
function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function callExisting()
{
	if(document.forms[0].radiobutton.checked)
	{
		cat=1;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	if(document.forms[0].radiobutton.checked==true)
	{
		if(trim(document.forms[0].txtsearch.value) == "")
		{
			ShowAlert(121,'Search Criteria');
			document.forms[0].txtsearch.focus();
			return false;
		}
	}
	var txtval=document.forms[0].txtsearch.value;
	if(document.forms[0].radiobutton.checked == true && txtval == "")
	{
		ShowAlert('121','CBS Custemer ID');
		return false;
	}
	if(document.forms[0].radiobutton.checked==true)
	{
		rdovalue=document.forms[0].radiobutton.value;
	}
	var hid_rowcount=document.forms[0].hid_rowcount.value;
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
	document.all.pullsearch.src=appURL+"action/perpullotherdeposit_search.jsp?hidBeanGetMethod=getOtherDepDetails&hidBeanId=perpropertydetails&txtsearch="+txtval+"&strBankType="+document.forms[0].strBankType.value+"&pagefrom="+pagefrom;		
}
function doSave()
{
	if(document.forms[0].selaccno.value=="")
	{
		alert("Please click on the appropriate Checkbox to Pull Other Deposit Details");
		return;
	}
	if(ConfirmMsg('178'))
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value ="pulling";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].action=appURL+"action/perpullotherdeposit.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{	
	if(ConfirmMsg('100'))
	{
		window.close();
	}
}
function doReset()
{	document.forms[0].reset();
	document.forms[0].txtsearch.readOnly=true;
	document.all.pullsearch.src=appURL+'action/blank.jsp';
}
</script>
</head>
<body onload="onLoad();">
<form name="perpullothdep" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
<tr>
	<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
				<tr>
					<td colspan="4"><b>Search By</b></td>
				</tr>
				<tr>
					<td width="15%" align="right"><input type="radio" name="radiobutton"
						value="CBSID" style="border-style:none"
						onClick="onRadioClick()"></td>
					<td width="20%">CBS Customer ID</td>
					<td width="25%"><input type="text" name="txtsearch"
						size="20" maxlength="20" readOnly="readonly"
						onKeyPress="notAllowSplChar();" tabindex="2"></td>
					<td width="40%" align="left"><input type="button" name="cmdOK2"
						value="Search" class="buttonStyle" style="width:75"
						onClick="callExisting()" tabindex="3"></td>
				</tr>
				<tr>
					<td colspan="4">
						<table width="96.5%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="left">
						<tr class="dataheader">
							<td width="15%" colspan="2" align="center">Customer Name</td>
							<td width="15%"  align="center">CBS Customer ID</td>
							<td width="20%"  align="center">Account No</td>
							<td width="15%"  align="center">Present Value</td>
							<td width="15%"  align="center">Maturity Date</td>
							<td width="20%"  align="center">Rate Of Interest(%)</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr class="datagrid">
					<td colspan="4">
						<div align="left">
						<iframe id="pullsearch" width="100%" height="200"
							src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp">
						</iframe>
						</div>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames='Save_Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_rowcount" value="">
<input type="hidden" name="selaccno" value="">
<input type="hidden" name="strBankType" value="2">
<input type="hidden" name="hidPageFrom" value="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>">
</form>
</body>
</html>