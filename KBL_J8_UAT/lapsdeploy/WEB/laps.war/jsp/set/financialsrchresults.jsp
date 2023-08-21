<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			int noofrows = Integer.parseInt(request.getParameter("noofrows"));

			%>

<html>
<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strLinkFrom=Helper.correctNull((String)request.getParameter("pageType"));
    
%>
<SCRIPT LANGUAGE="JavaScript">
var vardataexists="<%=Helper.correctNull((String)hshValues.get("exbool"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
function callLink(hidappno,hidfinid,hidbusid,hidCBSid)
{
	document.forms[0].hidRatAppNo.value=hidappno;
	document.forms[0].hidfinanceid.value=hidfinid;
	document.forms[0].hidbussID.value=hidbusid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getFinRating";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/FinancialOFRating.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}
function callDigiLink(hidappno,hidfinid,hidbusid,hidCBSid)
{
	document.forms[0].hidRatAppNo.value=hidappno;
	document.forms[0].hidfinanceid.value=hidfinid;
	document.forms[0].hidbussID.value=hidbusid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getDigiRating";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/digiRatingFin.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}
function callOnLoad()
{
	parent.frames.document.all.finacial.style.visibility="hidden";
	parent.frames.document.all.finacial.style.position="absolute";
	parent.frames.document.all.non_finacial.style.visibility="hidden";
	parent.frames.document.all.non_finacial.style.position="absolute";
}

</SCRIPT>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnLoad()">
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
<form name="isearch" method="post" class="normal" style="width: 102%">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
	<tr class="dataheader">
		<td width="25%"  align="center">Application No
		</td>
		<td width="25%"  align="center">Applicant Name
			</td>
		<td width="10%"  align="center">Applicant ID
		</td>
		<td width="10%"  align="center">Branch
		</td>
		<td width="10%"  align="center">Status
		</td>
		<td width="10%"  align="center">Digi Financals
		</td>
	</tr>
															

	<%String uniqid = "",strPAN="";

			if (arryRow != null) {
				int vecsize = arryRow.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {
						arryCol = (ArrayList) arryRow.get(l);

						if (arryCol != null) {
							%>
	<tr class="datagrid">

	<% String DigiPage = Helper.correctNull((String)arryCol.get(10));
	    if(!DigiPage.equalsIgnoreCase("Y")){
	    %>		
	<td width="25%" align="center">&nbsp; <a
			href="JavaScript:callLink('<%=arryCol.get(0)%>', '<%=arryCol.get(4)%>','<%=arryCol.get(5)%>','<%=arryCol.get(6)%>')" class="blackfont">
		<b><%=Helper.correctNull((String)arryCol.get(0))%></b></a></td>
		<%} else if(DigiPage.equalsIgnoreCase("Y")){ %>
		<td width="25%" align="center">&nbsp; <a
			href="JavaScript:callDigiLink('<%=arryCol.get(0)%>', '<%=arryCol.get(4)%>','<%=arryCol.get(5)%>','<%=arryCol.get(6)%>')" class="blackfont">
		<b><%=Helper.correctNull((String)arryCol.get(0))%></b></a></td>
		<%} %>
		<td width="25%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(1))%>&nbsp;&nbsp;</td>
		<td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(7))%>&nbsp;&nbsp;</td>
		<td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(2))%>&nbsp;&nbsp;</td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arryCol.get(3))%></td>
		<% String digi="";if(Helper.correctNull((String)arryCol.get(10)).equalsIgnoreCase("Y")){digi="YES";} %>
		<td width="10%" align="center"><%=digi%></td>
	
	</tr>
	<%}
					}
				}

				else {

				%>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr><td colspan="4" align="center">&nbsp;No Data Found</td></tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<%}
			}
		%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidRatAppNo">
<input type="hidden" name="hidfinanceid">
<input type="hidden" name="hidbussID">
</form>
</body>
</html>