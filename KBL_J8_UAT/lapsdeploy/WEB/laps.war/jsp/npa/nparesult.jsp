<%@include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	String strCbsid=Helper.correctNull((String)request.getParameter("cbsid"));
	String moduletype=Helper.correctNull((String)request.getParameter("moduletype"));
%>
<html>
<head>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
function chkmail(appholdername)
{
	alert("The Application is with "+(appholdername.toUpperCase())+", So you cannot view this application");
}
  
function callAppPage(appno,module,appid)
{

	document.forms[0].appno.value=appno;
	document.forms[0].hidmoduletype.value=module;
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].cbsid.value=appid;
	document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
	if(document.forms[0].moduletype.value=="OTSCO")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/CompromiseProposal_generalinfo.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="PAWO")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/prudential_general.jsp"
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="SARFI")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/SarfaeriProposal_page1.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(document.forms[0].moduletype.value=="SUIT")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/34PointsFormat_page1.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}

function callOnLoad()
{
	if('<%=Helper.correctNull((String)hshValues.get("newbtnenable"))%>'=="Y")
	 parent.frames.document.all.yearchk.style.visibility="visible";
	else 
	 parent.frames.document.all.yearchk.style.visibility="hidden";
}

</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad()">
<form name=srchform method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<%ArrayList v = (ArrayList) hshValues.get("vecRow");
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					String strstatus = Helper.correctNull((String) g1
							.get(2));
					String strchk = Helper
							.correctNull((String) g1.get(4));
					if ((strstatus.trim().equalsIgnoreCase("OPEN/PENDING"))
							&& strchk.trim().equalsIgnoreCase("N")) {%>
 
	<tr valign="top" class="datagrid">
		<td	align="center"><a
			href="javascript:chkmail('<%=Helper.correctNull((String)g1.get(2))%>')"
			class="blackfont" align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="52%" align="center"><%=Helper.correctNull((String) request.getParameter("appname"))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
	</tr>
	<%} else {

						%>
	<tr valign="top" class="datagrid">
		<td align="center"><a
			href="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String) request.getParameter("moduletype"))%>','<%=Helper.correctNull((String) request.getParameter("appid"))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="52%" align="center"><%=Helper.correctNull((String) request.getParameter("appname"))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(2))%></td>
	</tr>
	<%}}}%>
</table>
<input type="hidden" name="appno"> 
<input type="hidden" name="appname" value="<%=Helper.correctNull((String) request.getParameter("appname"))%>">
<input type="hidden" name="applevel">
<input type="hidden" name="appstatus"> 
<input type="hidden" name="hidmoduletype"/>
<input type="hidden" name="cbsid" value="<%=strCbsid %>">
<input type="hidden" name="moduletype" value="<%=moduletype%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>