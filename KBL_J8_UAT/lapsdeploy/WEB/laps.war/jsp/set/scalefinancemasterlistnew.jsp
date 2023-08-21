<%@include file = "../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();%>
<html>
<title>LAPS: Finance Master</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript">	


function getSelectedValue(scaleoffin,varactivity,varSDVal,varSDDesc,varNatureofAct)
{	

	window.opener.document.forms[0].txt_natureofactivity.value =varactivity;	
	window.opener.document.forms[0].txt_sof_value.value =scaleoffin;
	window.opener.document.forms[0].hid_calcMode.value =varSDVal;
	window.opener.document.forms[0].hid_calcValue.value =varSDDesc;
	window.opener.document.forms[0].hid_scaleoffin.value =varNatureofAct;
	window.opener.document.forms[0].txt_natureofactivity.readOnly =true;
	window.opener.document.forms[0].txt_sof_value.readOnly =true;

	//allowWholeNumber(this);
	window.opener.calcEligibility();
	window.opener.calRecommend();
			
	window.close();
}
</SCRIPT>
</head>
<body>
<form name="financelisthelp" method="post"  class="normal" ><br>
<table width="95%" border="1" cellspacing="0" cellpadding="0" class="outertable"
	align="center">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr >
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
							<td class="" width="6%">Sl. No.</td>
								<td class="" width="16%">Nature of Activity</td>
								<td class="" width="37%">Scale of Finance
								Value</td>
								<td class="" width="23%">Valid Upto</td>
							</tr>
							<tr >
							</tr>
						</table>
						</td>
					</tr>
				</table>
			
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%
			if ((vecRow != null) && (vecRow.size() != 0)) {
//out.println("v:"+v);
				int vecsize = vecRow.size();
				for (int l = 0; l < vecsize; l++) {
					vecCol = (ArrayList) vecRow.get(l);

					%>
	<tr valign="top" class="datagrid">
						<td width="6%" align="left"><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) vecCol.get(3))%>','<%=Helper.correctNull((String) vecCol.get(11))%>','<%=Helper.correctNull((String) vecCol.get(13))%>','<%=Helper.correctNull((String) vecCol.get(14))%>','<%=Helper.correctNull((String) vecCol.get(2))%>')"
							align="center"><%=l + 1%></a></td>
						<td width="16%" align="left" height="23"><b><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) vecCol.get(3))%>','<%=Helper.correctNull((String) vecCol.get(11))%>','<%=Helper.correctNull((String) vecCol.get(13))%>','<%=Helper.correctNull((String) vecCol.get(14))%>','<%=Helper.correctNull((String) vecCol.get(2))%>')"
							align="center"><%=Helper.correctNull((String) vecCol.get(11))%></a></b></td>
						<td width="37%" align="right"><%=Helper.correctNull((String) vecCol.get(3))%> </td>
						<td width="23%" align="left"><%=Helper.correctNull((String) vecCol.get(8))%>-<%=Helper.correctNull((String) vecCol.get(9))%></td>
					</tr>
					<%
						}
						}
						else
						{%>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td colspan="4" align="center"><b>No Data Found for the
						selected criteria</b>
					</tr>
					<%
						}
					%>
					

				</table>
				
		</table>
		</td>
	</tr>
</table>
<br>
<table width="10%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr valign="top">
		<td width="20%"><input type=button
			class="buttonClose"
			value="Close" name="closebtn" tabindex="25" onClick=window.close()></td>
	</tr>
</table>

</form>
</body>
</html>

