<%@include file="../share/directives.jsp"%>
<%
ArrayList arryRow = new ArrayList();
ArrayList arryCol = new ArrayList();
if (hshValues != null) {
	arryRow = (ArrayList) hshValues.get("arryRow");
}
int  arrSize=0;

String strPagefrom = Helper.correctNull((String)request.getParameter("strfrom"));
if(strPagefrom.equalsIgnoreCase(""))
{
	strPagefrom = Helper.correctNull((String)hshValues.get("hidpagefrom"));
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Activity Master Search</title>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script>
var pagefrom="<%=strPagefrom%>";
function callSearch()
{
	var value = document.forms[0].txt_value.value;
	if(value == "")
	{
		alert("Enter atleast 3 characters");
		document.forms[0].txt_value.focus();
		return false;
	}
		document.forms[0].hidvalue.value="activity";
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="getActivityList";
		document.forms[0].hidBeanId.value="appeditlock";
		document.forms[0].action=appURL+"action/com_activityhelp.jsp";	
		document.forms[0].submit();
}
function setValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11)
{
	if(pagefrom=="plantdet")
	{
		window.opener.document.forms[0].txt_plantname.value=val1;
		window.opener.document.forms[0].txt_maxplant.value=val2;
		window.opener.document.forms[0].hidschemesno.value=val10;
	}
	else
	{
		window.opener.document.forms[0].txt_activityname.value=val1;
		window.opener.document.forms[0].txt_unitcost.value=val2;
		window.opener.document.forms[0].txt_activitycode.value=val3;
		window.opener.document.forms[0].txt_activityavail.value=val4;
		window.opener.document.forms[0].hidcount.value=val6;
		window.opener.document.forms[0].hiddesc2.value=val7;
		window.opener.document.forms[0].hidamt2.value=val8;
		window.opener.document.forms[0].txt_unitcostto.value=val11;
		window.opener.document.forms[0].hidavail2.value=val4;
	}
	window.close();
}
function doClose()
{
	window.close();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form method="post" class="normal">
<table class="outertable"  width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
      <td><b>Specifications Search</b></td>
	</tr>
</table>

<table class="outertable border1"  width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
	<tr>
		<td valign="top">
		<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1">
			<tr>
				<td>
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1">
					<tr>
					<td align="right" width="22%"><b>Activity Name</b></td>
						<td width="25%" align="center"><input type="text" name="txt_value" size="25" maxlength="70"></td>
						<td width="35%"><input type="button" name="cmdsearch" value="Search" class="buttonstyle" onClick="callSearch()"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr class="dataheader">
						<td width="7%"><b>S.No</b></td>
						<td width="50%" align="center"><b>Activity Name</b></td>
						<td width="20%" align="center"><b>Cost From</b></td>
						<td width="20%" align="center"><b>Cost To</b></td>
						
						</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center">
						<DIV class="cellcontainer" style="height: 180px">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="2">
							<%if (arryRow != null) {
				 arrSize = arryRow.size();
				for (int i = 0; i < arrSize; i++) {
					
					arryCol = (ArrayList) arryRow.get(i);
						%>
							<tr class="datagrid">
								<td width="7%"><%=i + 1%></td>
								<td width="50%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arryCol.get(1))%>',
									'<%= Helper.correctNull((String)arryCol.get(3))%>',
									'<%= Helper.correctNull((String)arryCol.get(5))%>',
									'<%= Helper.correctNull((String)arryCol.get(2))%>',
									'<%= Helper.correctNull((String)arryCol.get(5))%>',
									'<%= Helper.correctNull((String)arryCol.get(6))%>',
									'<%= Helper.correctNull((String)arryCol.get(7))%>',
									'<%= Helper.correctNull((String)arryCol.get(8))%>',
									'<%= Helper.correctNull((String)arryCol.get(9))%>',
									'<%= Helper.correctNull((String)arryCol.get(10))%>',
									'<%= Helper.correctNull((String)arryCol.get(4))%>')"><%=Helper.correctNull((String) arryCol.get(1))%></a> 
                          	</td>
							<td width="20%" align="right"><%= Helper.correctNull((String)arryCol.get(3))%></td>
							<td width="20%" align="right"><%= Helper.checkDecimal(Helper.correctDouble((String)arryCol.get(4)))%></td>
							</tr>
							<%
				}

			}%>
							<tr class="datagrid">
						 <td width="7%">&nbsp;</td>
						 <td width="50%">&nbsp;</td>	
                          <td width="20%">&nbsp;</td>
                          <td width="20%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
						 <td width="7%">&nbsp;</td>
						 <td width="50%">&nbsp;</td>	
                          <td width="20%">&nbsp;</td>
                          <td width="20%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
						 <td width="7%">&nbsp;</td>
						 <td width="50%">&nbsp;</td>	
                          <td width="20%">&nbsp;</td>
                          <td width="20%">&nbsp;</td>
							</tr>
							<%if (arrSize == 0) { %>	
							
							<tr class="datagrid">
							 <td width="7%">&nbsp;</td>
							<td colspan="4" align="center"><b>NO DATA FOUND</b>&nbsp;</td>
							</tr>
							<%} %>
							<tr class="datagrid">
						 <td width="7%">&nbsp;</td>
						 <td width="50%">&nbsp;</td>	
                          <td width="20%">&nbsp;</td>
                          <td width="20%">&nbsp;</td>
							</tr>
						</table>
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
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
<input type="hidden" name="hidvalue" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidpagefrom" value="<%=strPagefrom%>">
</form>
</body>
</html>