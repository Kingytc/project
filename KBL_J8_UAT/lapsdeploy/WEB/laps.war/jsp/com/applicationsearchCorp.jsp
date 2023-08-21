<%@include file="../share/directives.jsp"%>
<%ArrayList arrValues = new ArrayList();
			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrRow");
			}
	
		NumberFormat nft=NumberFormat.getNumberInstance();
		nft.setMaximumFractionDigits(2);
		nft.setMinimumFractionDigits(2);
		nft.setGroupingUsed(false);
		
		//out.println(arrValues);
%>

<%@page import="java.text.NumberFormat"%><html>
<head>
<title>Application Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>	
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAppid = "<%=Helper.correctNull((String) hshValues.get("strcustid"))%>";

function setValues(value1)
{

	var varAppno = value1;
	window.opener.document.forms[0].txtSearch.value=value1;
	window.opener.callOnload(varAppno,strAppid);
	window.close();
}
function doClose()
{
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
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
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
							<tr class="dataheader">
								<td width="25%" align="center"><b>Application No.</b></td>
								<td width="50%" align="center" nowrap="nowrap"><b>Borrower Name</b></td>
								<td width="25%" align="center"><b>Approved Date</b></td>								
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center"><div class="cellContainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<%if (arrValues != null && arrValues.size()>0 ) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);%>
							<tr class="datagrid">
								<td width="25%" style="text-align: center;"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>')">
                          												<%=Helper.correctNull((String) arrCol.get(0))%></a></td>
						
							<td width="50%"><%=Helper.correctNull((String) arrCol.get(1))%></td>
							<td width="25%" style="text-align: center;"><%=Helper.correctNull((String) arrCol.get(2))%></td>
							</tr>
							<%}}else { %>
							<tr class="datagrid">
							 <td colspan="5" align="center" rowspan="3"><b>-----No Data Found----</b></td></tr>
							
							<%} %>
							<!--remove data grid space for country-->
						</table></div>
						<table width="10%" border="0" cellspacing="0" cellpadding="3" class="outertable"
							align="center">
							<tr valign="top">
								<td width="20%"><lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidAction">

<input type="hidden" name="hidcntrycontrol" value="<%=Helper.correctNull((String)request.getParameter("hidcntrycontrol")) %>">
<input type="hidden" name="hidPageFrom" value="<%=Helper.correctNull((String)request.getParameter("hidPageFrom"))%>">
<input type="hidden" name="hidPrdType" value="<%=Helper.correctNull((String)request.getParameter("hidPrdType"))%>">
</form>
</body>
</html>
