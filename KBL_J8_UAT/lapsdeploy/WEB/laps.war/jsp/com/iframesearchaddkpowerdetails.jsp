<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			int noofrows = Integer.parseInt(request.getParameter("noofrows"));
%>
<html>
<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">

function callLink(customername,appid,oldid)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/kpowsearch.jsp?hidBeanGetMethod=getkpowDetails&hidBeanId=comsolvency&customername="+customername+"&appid="+appid;
	document.forms[0].hidoldId.value=oldid;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="isearch" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable linebor">
	<%String uniqid = "";

			if (arryRow != null) {
				int vecsize = arryRow.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {
						arryCol = (ArrayList) arryRow.get(l);

						if (arryCol != null) {
							uniqid = Helper	.correctNull((String) arryCol.get(4));
							if (uniqid.equalsIgnoreCase("")) {
								uniqid = Helper.correctNull((String) arryCol.get(0));
							}%>
	<tr class="datagrid">
		<td width="35%">&nbsp;&nbsp; <a href="JavaScript:callLink('<%=arryCol.get(1)%>','<%=uniqid%>',<%=arryCol.get(8)%>)">
		<b><%=arryCol.get(1)%></b></a></td>
		<td width="10%" align="center""><%=arryCol.get(5)%>&nbsp;</td>
		<td width="10%" align="center""><%=arryCol.get(8)%>&nbsp;&nbsp;</td>
		<td width="10%" align="center"><%=arryCol.get(2)%></td>
		<td width="35%" align="center"><b><%=arryCol.get(3)%>&nbsp;</b>
		</td>
	</tr>
	<%}}}else {%>
	<tr class="datagrid"><td>&nbsp;</td></tr>
	<tr class="datagrid"><td>&nbsp;</td></tr>
	<tr class="datagrid"><td>&nbsp;</td></tr>
	<tr class="datagrid"><td align="center">No Data Found</td></tr>
	<tr class="datagrid"><td>&nbsp;</td></tr>
	<tr class="datagrid"><td>&nbsp;</td></tr>
	<%}}%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType"> 
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hidoldId"> 
<input type="hidden" name="hidModuleName" value="T">
</form>
</body>
</html>
