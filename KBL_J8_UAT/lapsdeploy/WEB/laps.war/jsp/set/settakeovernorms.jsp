<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	ArrayList arrRow=new ArrayList();
	if (hshValues!=null && hshValues.size()>0)
	{
		arrRow =(ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Take Over Norms</title>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/settakeovernorms.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varModule="<%=Helper.correctNull((String)request.getParameter("sel_Module"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; Corporate & Agriculture Products -&gt; Take Over Norms Master</td>
	</tr>
</table>
<br>
<table class="outertable" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
<tr>
	<td>
	<table class="outertable border1 tableBg" width="80%" border="0" cellpadding="5" cellspacing="1" align="center">
	<tr>
		<td>
			<table class="outertable" width="98%" border="0" cellpadding="12" cellspacing="5" align="center">
			<tr>
				<td width="50%" align="right">Take Over Norms for</td>
				<td width="50%" align="left">
					<select name="sel_Module" onChange="getTakeOverNorms();" style="width: 120px">
						<option value="S">&nbsp;---Select---</option>
						<option value="C">&nbsp;CORPORATE</option>
						<option value="A">&nbsp;AGRICULTURE</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<textarea name="txt_TakeOverNorm" cols="140" wrap="VIRTUAL" rows="5" onKeyPress="notAllowSingleQuote();NoallowEnterandDoubleQuote();textlimit(document.forms[0].txt_TakeOverNorm,'400');" onKeyUp="textlimit(this,400)"></textarea>
				</td>
				</tr>
				<tr>
			<td width="50%" align="right">Active</td>
				<td><select name="sel_active" style="width: 120px">
				<option value="">--Select--</option>
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
<tr>
	<td>
		<table class="outertable" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
		<tr>
			<td>
			<br>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
				<tr>
					<td valign="top">
					<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete"
									btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
					</td>
				</tr>
				</table>
				<br>
				<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" height="100%">
				<tr>
					<td colspan="2" align="center" class="dataheader"><b>TAKE OVER NORMS</b></td>
				</tr>
				<%if(arrRow!=null && arrRow.size()>0){
					for(int i=0;i<arrRow.size();i++){
						ArrayList arrCol=new ArrayList();
						arrCol=(ArrayList)arrRow.get(i);
				%>
				<tr class="datagrid">
					<td width="5%" align="center">
						<input type="radio" name="termsel" value="radiobutton" style="border-style: none"
							onClick="placeValues('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>')">
					</td>
					<td width="95%">&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
				</tr>
				<%}}
				else{
				%>
				<tr class="datagrid">
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr class="datagrid">
					<td colspan="2" align="center"><b>--- No Records to display ---</b></td>
				</tr>
				<tr class="datagrid">
					<td colspan="2">&nbsp;</td>
				</tr>
				<%} %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidSNo" value="">
</form>
</body>
</html>