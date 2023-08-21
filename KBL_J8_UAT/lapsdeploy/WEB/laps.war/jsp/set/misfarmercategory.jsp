<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Farmer's Category</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/misfarmercategory.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate="<%=Helper.getCurrentDateTime()%>"
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form name="farmercat" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; MIS Farmer's Category</td>
</tr>
</table>
<br>
<br>
<table class="outertable border1 tableBg" width="55%" border="0" cellpadding="5" cellspacing="0" align="center">
<tr>
	<td valign="top">
		<table class="outertable" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
		<tr>
			<td>Farmer's Category</td>
			<td align="left" colspan="2">
				<select name="sel_FarmCat">
					<option value="">--Select--</option>
					<lapschoice:BanksSchemeStaticDataNewTag apptype="13" />
				</select>
			</td>
		</tr>
		<tr>
			<td width="35%">Irrigated Land</td>
			<td align="left" width="30%">
				<select name="sel_Irrigated">
					<option value="">--Select--</option>
					<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
				</select>
			</td>
			<td width="35%">
				<input type="text" name="txt_IrrigatedVal" size="20" onkeypress="allowNumber(this);" onblur="setDecimal(this);">
			</td>
		</tr>
		<tr>
			<td>Total Land</td>
			<td align="left">
				<select name="sel_Cultivated">
					<option value="">--Select--</option>
					<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
				</select>
			</td>
			<td>
				<input type="text" name="txt_CultivatedVal" size="20" onkeypress="allowNumber(this);" onblur="setDecimal(this);">
			</td>
		</tr>
		<tr>
			<td>Policy Date</td>
			<td colspan="2">
				<input type="text" name="txt_NewFarmerDate" size="20" onblur="checkDate(this);">
				<a alt="Select date from calender" href="javascript:callCalender('txt_NewFarmerDate')" tabindex="10">
					<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0">
				</a>
			</td>
		</tr>
		<tr>
			<td>Visibility</td>
			<td colspan="2">
				<select name="sel_Visibility" style="width: 110px;">
					<option value="E">Enable</option>
					<option value="D">Disable</option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<table class="outertable" width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td valign="top" align="center">
		<table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
		<tr class="dataheader">
			<td width="4%">&nbsp;</td>
			<td width="24%" align="center"><b>Farmer's Category</b></td>
			<td width="24%" align="center"><b>Irrigated Land</b></td>
			<td width="24%" align="center"><b>Total Land</b></td>
			<td width="24%" align="center"><b>Policy Date</b></td>
		</tr>
		<%
			if(arrRow!=null&&arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
				
		%>
		<tr class="datagrid">
			<td align="center">
				<input type="radio" name="radiobutton"
					value="radiobutton" style="border-style: none"
					onClick="onRadioSelect('<%=Helper.correctNull((String) arrCol.get(0))%>',
					'<%=Helper.correctNull((String) arrCol.get(1))%>',
					'<%=Helper.correctDouble((String) arrCol.get(2))%>',
					'<%=Helper.correctNull((String) arrCol.get(3))%>',
					'<%=Helper.correctDouble((String) arrCol.get(4))%>',
					'<%=Helper.correctNull((String) arrCol.get(5))%>',
					'<%=Helper.correctNull((String) arrCol.get(8))%>',
					'<%=Helper.correctNull((String) arrCol.get(10))%>')">
			</td>
			<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%></td>
			<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;<%=Helper.correctDouble((String) arrCol.get(2))%></td>
			<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%>&nbsp;<%=Helper.correctDouble((String) arrCol.get(4))%></td>
			<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
		</tr>
		<%
				}
			}
			else
			{
		%>
		<tr class="datagrid">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="datagrid">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="center"><b>No Data Found</b></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="datagrid">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<%
			}
		%>
		</table>
	</td>
</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<input type="hidden" name="hidSNo">
</form>
</body>
</html>