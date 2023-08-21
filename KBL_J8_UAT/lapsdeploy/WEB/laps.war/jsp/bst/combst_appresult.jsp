<%@include file="../share/directives.jsp"%>
<%ArrayList g1 = new ArrayList();%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callAppPage(appno,cname,id,status)
{
		document.forms[0].appno.value=appno;
		document.forms[0].appname.value=cname;
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanGetMethod.value="getBSTfacility";
		document.forms[0].action=appURL+"action/combst_facility.jsp?appstatus="+status+"&com_id="+id+"&hidcatory=bst";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}

function chkmail(appholdername)
{
	alert("The Application is with "+(appholdername.toUpperCase())+", So you cannot view this application");
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name=srchform method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
	<%ArrayList arr = (ArrayList) hshValues.get("arryRow");
			if (arr != null) {
				int vecsize = arr.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) arr.get(l);

					String strappstatus = Helper
							.correctNull((String) g1.get(1));
					String strHoldbyme = Helper.correctNull((String) g1.get(2));
					if (strappstatus.equalsIgnoreCase("op")) {
						strappstatus = "Open/Pending";
					} else if (strappstatus.equalsIgnoreCase("pa")) {
						strappstatus = "Processed/Approved";
					} else if (strappstatus.equalsIgnoreCase("pr")) {
						strappstatus = "Processed/Rejected";
					} else if (strappstatus.equalsIgnoreCase("ca")) {
						strappstatus = "Closed/Approved";
					} else if (strappstatus.equalsIgnoreCase("cr")) {
						strappstatus = "Closed/Rejected";
					}
char readFlag=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18);
					if (strappstatus.equalsIgnoreCase("Open/Pending")
							&& strHoldbyme.equalsIgnoreCase("N")     &&  readFlag=='w') {%>

	<tr valign="top" class="datagrid">
		<td  width="25%"
			align="center">&nbsp;&nbsp;<a
			href="javascript:chkmail('<%=Helper.correctNull((String)g1.get(3))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a>
		</td>
		<td width="52%" align="center"><%=Helper.correctNull((String) request.getParameter("appname"))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=strappstatus%></td>
	</tr>

	<%} else {%>
	<tr valign="top" class="datagrid">
		<td  width="25%"
			align="center">&nbsp;&nbsp;<a
			href="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)request.getParameter("appname"))%>','<%=Helper.correctNull((String)request.getParameter("com_id"))%>','<%=Helper.correctNull((String)g1.get(1))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a>
		</td>
		<td width="52%" align="center"><%=Helper.correctNull((String) request
										.getParameter("appname"))%>&nbsp;
		</td>
		<td width="23%" align="center">&nbsp;<%=strappstatus%></td>
	</tr>
	<%}}}%>
</table>
<lapschoice:hiddentag/>
<input type="hidden" name="appno"> 
<input type="hidden" name="appname">
<input type="hidden" name="applevel"> 
<input type="hidden" name="appstatus"> 
<input type="hidden" name="comapp_compname" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
<input type="hidden" name="comapp_compid" value="<%=Helper.correctNull((String)hshValues.get("comapp_compid"))%>">
<input type="hidden" name="valuesin" value="L">
</form>
</body>
</html>
