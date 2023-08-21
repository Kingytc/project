<%@include file="../share/directives.jsp"%>
<%
ArrayList g1 = new ArrayList();
int noofrows = Integer.parseInt(request.getParameter("noofrows"));
%>
<html>
<head>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varcategorytype="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
	
function callPage(name,uniqoldid,democuststatus,KYCcuststatus,incexpcuststatus,cbsstatus,searchtype,searchval,cbsid)
{	
	if(varcategorytype=="RET" || varcategorytype=="AGR" || varcategorytype=="LAD")
	{

		if(democuststatus=="Y" && cbsstatus=="Y")
		{
			//No Function
		}
		else
		{
			//alert("Customer Profile is not filled completely");
			//return;
		}
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/persearch.jsp?applicantoldid="+uniqoldid+"&appname="+name+"&hidCategoryType="+varcategorytype+"&searchval="+searchval+"&searchtype="+searchtype+"&hidCBSID="+cbsid;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(varcategorytype=="OPS")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrsearch.jsp?applicantoldid="+uniqoldid+"&appname="+compname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="srchform" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%ArrayList v = (ArrayList) hshValues.get("vecval");
			if (v != null) {
				int vecsize = v.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {

						g1 = (ArrayList) v.get(l);
						%>
	<tr class="datagrid">
		<td width="36%"><a href="#" onClick="javascript:callPage('<%=Helper.encodeAmpersand(Helper.replaceForJavaScriptString((String)g1.get(0)))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>','<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>','<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>','<%=Helper.correctNull((String) g1.get(5))%>')"
			><b>&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="12%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(5))%></td>
		<td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String)g1.get(4))%>&nbsp;</td>
		<td width="10%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
		<td width="33%">&nbsp;&nbsp;<%=Helper.correctNull((String) g1.get(2))%></td>
	</tr>
	<%}
				} else {

				%>
	<tr class="datagrid">
		<td width="41%" >&nbsp;</td>
		<td width="20%" align="center"></td>

		<td width="15%" align="left"></td>
		<td width="21%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<tr class="datagrid">
		<td width="41%" >&nbsp;</td>
		<td width="20%" align="center"></td>

		<td width="15%" align="left"></td>
		<td width="21%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<tr class="datagrid">
		<td width="41%" >&nbsp;</td>
		<td width="20%" align="center">No Data Found</td>

		<td width="15%" align="left"></td>
		<td width="21%" align="center"></td>
		<td width="21%" align="center"></td>
	</tr>
	<%}

			}

			%>

</table>
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="txtperapp_apptitle" value="<%=Helper.correctNull((String)request.getParameter("txtperapp_apptitle"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
