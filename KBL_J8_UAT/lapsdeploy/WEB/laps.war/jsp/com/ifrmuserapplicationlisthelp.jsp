<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
%>

<html>
<head>
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 325;
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
	var varappno="";
	function callLink() 
	{
		<%if(arrRow!=null && arrRow.size()>0){
			for(int i=0;i<arrRow.size();i++){
			if(arrRow.size()==1){%>
			if(document.forms[0].chk_application.checked)
				 varappno=varappno+","+document.forms[0].chk_application.value;
			<%}else{%>
			if(document.forms[0].chk_application[<%=i%>].checked)
			 varappno=varappno+","+document.forms[0].chk_application[<%=i%>].value;
			<%}}}%>
		window.opener.document.forms[0].txtapplicationno.value=varappno.slice(1);
		window.opener.document.all.ifrmtab.style.visibility="visible";
		window.opener.document.all.ifrmtab.style.position="relative";
		window.opener.document.forms[0].cmdtransfer.disabled=false;
		window.opener.document.forms[0].cmdgetapplication.disabled=true;
		window.close();
	}
	function doOk()
	{
		callLink();
	}
	function doClose() 
	{
		window.close();
	}
</SCRIPT>
<body>
<form name="facility" method="post" class="normal">
<table width="98%" border="0" cellspacing="2" cellpadding="2"
	class="outertable" align="center">
	<tr>
	<td>&nbsp;</td></tr>
	<tr>
		<td>
		<table width="70%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="center">
			<tr class="dataheader">
				<td align="center">Select Application Number</td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0){
				for(int i=0;i<arrRow.size();i++){%>
				<tr class="datagrid">
				<td align="center"><input type="checkbox"  name="chk_application" style="border: none;" value="<%=Helper.correctNull((String)arrRow.get(i)) %>">
				<%=Helper.correctNull((String)arrRow.get(i)) %></td>
			</tr>
			<%}} else{%>
			<tr class="datagrid">
				<td align="center">&nbsp;</td>
			</tr>
			<tr class="datagrid">
				<td align="center">-- No Record Found --</td>
			</tr>
			<tr class="datagrid">
				<td align="center">&nbsp;</td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
</form>
</body>
</html>
