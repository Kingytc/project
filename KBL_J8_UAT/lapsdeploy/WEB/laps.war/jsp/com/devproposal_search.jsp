<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deviation Proposal Search</title>
<SCRIPT LANGUAGE="JavaScript">
var bflag="<%=Helper.correctNull((String)hshValues.get("bflag"))%>";
function doSearch()
{
	for(var k=0;k<2;k++)
	{
		if(document.forms[0].radiobutton[k].checked==true) 
		{
			if(document.forms[0].txt_val.value=="") 
			{
				ShowAlert(121,'Search Criteria');
				document.forms[0].txt_val.focus();
				return;
			}
		}	
	}
	var textval=document.forms[0].txt_val.value;
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
	if(document.forms[0].radiobutton[i].checked==true) {
		
		document.forms[0].rdovalue.value = document.forms[0].radiobutton[i].value;
		}
	}
	
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getPermissionPropSearch";
	document.forms[0].hidBeanId.value="perlimitofloan";
	document.forms[0].action=appURL+"action/devproposal_search.jsp";	
	document.forms[0].submit();
}
function placevalue(prop_no,Appl_attach,prodate,cuurent)
{

	var partss =prodate.split('-');
	var date1 = new Date(partss[0], partss[1] - 1, partss[2]);
	var parts =cuurent.split('-');
	var date2 = new Date(parts[0], parts[1] - 1, parts[2]); 
	if(date1<date2)
	{
		alert("Sanction date of permission proposal number cannot be more than 6 months from Current Date");
		return;
	}
	else
	{
	if(Appl_attach!="")
	{
		alert("Already attached to Proposals("+Appl_attach+")");
	}
	window.opener.document.forms[0].dev_prop_no.value=prop_no;
	window.close();
	}
}
function fieldfocus()
{
	document.forms[0].txt_val.focus();
}
function onLoad()
{
	
	if(bflag=="false")
	{
		alert("Customer is not related to this proposal");
	}
	
}
</SCRIPT>

</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<body onload="onLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<tr>
						

						<td width="5%"><input type="radio" name="radiobutton"
													value="cbsid" style="border-style:none"
													tabindex="2" onclick="fieldfocus();"></td>
												<td width="20%">CBS Customer ID</td>
												
												<td width="5%"><input type="radio" name="radiobutton"
													value="perm_no" style="border-style:none"
													tabindex="3" onclick="fieldfocus();"></td>
												<td width="30%">Permission Proposal No.</td>
						<td width="25%" align="center"><input type="text"
							name="txt_val" size="25" maxlength="400" value=""
							onKeyPress="notAllowSplChar();"></td>
						<td width="25%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="doSearch()">
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="3">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="outertable border1">
						<tr>
							<td valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader">
									<td width="30%">Applicant Name</td>
									<td width="30%">Permission No</td>
									<td width="40%">Attached Proposal No</td>
								</tr>
								
							</table>
							</td>
						</tr>
						<tr>
							<td valign="top" align="center">
							<DIV class="cellContainer">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<%
								ArrayList arrVal=(ArrayList)hshValues.get("arrData");								
									if (arrVal != null && arrVal.size()>0) {
										int arrSize = arrVal.size();
										ArrayList arrCol = null;
										for (int i = 0; i < arrSize; i++) {
											arrCol = new ArrayList();
											if (arrCol != null) {
												arrCol = (ArrayList) arrVal.get(i);
										%>
										<tr class="datagrid">
								<td width=30%"><a href="#"
										onclick="javascript:placevalue('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>
								<td width="30%"><a href="#"
										onclick="javascript:placevalue('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
								<%if(Helper.correctNull((String) arrCol.get(1)).equalsIgnoreCase("")) {%>
								<td width="40%">Not Attached</td>
								<%}else{ %>
									<td width="40%"><%=Helper.correctNull((String) arrCol.get(1))%></td>
									<%} %>
								</tr>	
								<%
									}
										}

									}  else { %>
									<tr class="datagrid"><td colspan="3" align="center"> &nbsp;</td></tr>
									<tr class="datagrid"><td colspan="3" align="center"> No Records Found </td></tr>
									<tr class="datagrid"><td colspan="3" align="center"> &nbsp;</td></tr>
								
								<% } %>
							</table>
							</div>
							<table width="0%" border="0" cellspacing="0" cellpadding="3"
								align="center" class="outertable">
								<tr valign="top">
									<td width="20%" align="center"><input type="button"
										class="buttonClose" value="Close" name="closebtn" tabindex="25"
										onClick="window.close()"></td>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="rdovalue" value="">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)hshValues.get("strappno"))%>"> 
</form>
</body>
</html>