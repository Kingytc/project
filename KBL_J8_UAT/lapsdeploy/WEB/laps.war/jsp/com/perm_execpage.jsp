<%@include file="../share/directives.jsp"%>
<%
	String strAnnexure=Helper.correctNull((String)hshValues.get("strAnnexure"));
	%>
<html>
<head>
<title>Proposalflow</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function callAnnexure(page)
{
	var purl=appUrl+"action/"+page+"?hidBeanId=perDeviation&hidBeanGetMethod=getAnnexure&appno="+document.forms[0].appno.value+"&strAmntVal="+document.forms[0].sel_amount.value;
	var title 	= "Annexure";
	var prop 	= "scrollbars=yes,width=1000,height=600,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"mainnav.jsp";
		document.forms[0].submit();
	}
	
}
function callLink(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
</head>

<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
		</jsp:include></td>
	</tr>
</table>
<table>

	<tr>
		<td class="page_flow">Home -&gt; Permission -&gt; Proposal -&gt;
		Proposal Flow</td>
	</tr>

</table>
<lapschoice:ApplDevHeaderTag />
<table width="60%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:callLink('perm_proposalflow.jsp','perDeviation','getProposalflow')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"><b>Proposal Flow</b></a></td>
		<td class="sub_tab_active" align="center">Executive
		Summary</td>
	</tr>
</table>
<br/>

<table width="40%" border="0" cellspacing="3" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td>
<table width="40%" border="0" cellspacing="3" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td nowrap="nowrap">Amount to be shown in &nbsp;<select name="sel_amount"><option value="R">Rupees</option><option value="L">Lakhs</option><option value="C">Crores</option></select></td>
	<%if(strAnnexure.equalsIgnoreCase("3")||strAnnexure.equalsIgnoreCase("4")){ %>
	
		<td align="center"><input type="button" name="btn_AppraisalNote"
			value="Permission Note" onclick="callAnnexure('Annexure_Deviation.jsp');" class="buttonStyle"
			style="width: 120px"></td>
	<%} else if(strAnnexure.equalsIgnoreCase("5")){ %>
		<td align="center"><input type="button"
			name="btn_AppraisalNote" value="Permission Note"
			onclick="callAnnexure('Annexure_CREpermission.jsp');" class="buttonStyle"
			style="width: 120px"></td>
	<%}else if(strAnnexure.equalsIgnoreCase("6")){ %>
		<td align="center"><input type="button" name="btn_AppraisalNote"
			value="Permission Note" onclick="callAnnexure('Annexure_General.jsp');"
			class="buttonStyle" style="width: 120px"></td>
	<%}
  else if(strAnnexure.equalsIgnoreCase("7")){ %>
		<td align="center"><input type="button" name="btn_AppraisalNote"
			value="Permission Note" onclick="callAnnexure('Annexure_FINANCE.jsp');" class="buttonStyle"
			style="width: 120px"></td>
	<%}else if(strAnnexure.equalsIgnoreCase("8")){ %>
	<td align="center"><input type="button" name="btn_AppraisalNote"
		value="Permission Note" onclick="callAnnexure('Annexure_Trust.jsp');" class="buttonStyle"
		style="width: 120px"></td>
<%} %>
</tr>
</table>
</td>
</tr>
</table>

<lapschoice:combuttonnew btnnames=""
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="cmdsave" disabled="disabled">
</form>
</body>
</html>
