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
String strcount=Helper.correctNull((String)hshValues.get("count"));
String strAppCount=Helper.correctNull((String)hshValues.get("appCount"));

%>
<SCRIPT LANGUAGE="JavaScript">
var vardataexists="<%=Helper.correctNull((String)hshValues.get("exbool"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
var icount ="<%=Helper.correctNull((String)hshValues.get("count"))%>";
var varAppcount="<%=Helper.correctNull((String)hshValues.get("appCount"))%>";
var Alert="<%=Helper.correctNull((String)hshValues.get("ALERT"))%>";


function callLink(demoid, cbsdata, cbsid,name,addr,citycode,dist,statcode,pin,ph,fax,cityname,statename,distname,status,age)
{
if(status == "N")
{
	alert("Customer Profile Not Completed");
	return;
}
if(Alert != "N")
{
	alert("Kindly confirm the correctness of CBS id. Once updated in verfication tab cannot be revert..! ");
}
if(varAppcount=="1" || varAppcount=="01")
{
	parent.frames.window.opener.document.all.comapp_cbsid.value=cbsid;
}
else{
parent.frames.window.opener.document.all.comapp_cbsid[<%=strcount%>].value=cbsid;
//parent.frames.window.opener.document.all.comapp_customer_id[icount].value=demoid;
}
top.close();	



}

function callOnload()
{
	
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="isearch" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
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
							uniqid = Helper
									.correctNull((String) arryCol.get(0));
							if (uniqid.equalsIgnoreCase("")) {
								uniqid = Helper.correctNull((String) arryCol
										.get(4));
							}

							%>
	<tr class="datagrid">

		<td width="35%" align="left">&nbsp; <a
			href="JavaScript:callLink('<%=uniqid%>', '<%=arryCol.get(6)%>','<%=arryCol.get(5)%>','<%=arryCol.get(1)%>')" class="blackfont">
		<b><%=Helper.replaceForJavaScriptString((String)arryCol.get(1))%></b></a></td>
		<td width="35%" align="center"">&nbsp;<%=Helper.correctNull((String)arryCol.get(5))%>&nbsp;&nbsp;</td>
		<td width="30%" align="center"">&nbsp;<%=uniqid%>&nbsp;&nbsp;</td>

	</tr>
	<%}
					}
				}

				else {

				%>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5" align="center">&nbsp;No  Data Found</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<%}
			}
		%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hidModuleName" value="P">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
