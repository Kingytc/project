<%@include file="../share/directives.jsp"%>

<%
			String strCompId = Helper.correctNull((String) hshValues
					.get("comapp_id"));
			String strId = Helper.correctNull((String) request
					.getParameter("id"));

			if (strCompId.trim().equals("")) {
				strCompId = strId;
			}
			

			ArrayList g1 = new ArrayList();
			%>

<html>
<head>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
function chkmail(appholdername)
{
	alert("The Application is with "+(appholdername.toUpperCase())+", So you cannot view this application");
}
  
function callAppPage(appno, borrowername,status,appholder,appholdusrname, appholder)
{
		if(appholder=="N" && status=="OPEN/PENDING")
		{
			alert("The Application is with "+(appholdusrname.toUpperCase())+", So you cannot modify data in this application");
			
		}
		document.forms[0].appno.value=appno;
		document.forms[0].appstatus.value=status;
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/permission_gist.jsp";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}

function menuOptionDivMouseDown (url)
{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="srchform" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
	<%ArrayList v = (ArrayList) hshValues.get("vecval");
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					//String strstatus = Helper.correctNull((String) g1
					//		.get(1));
					//String strchk = Helper
					//		.correctNull((String) g1.get(2));
					//if ((strstatus.trim().equalsIgnoreCase("OPEN/PENDING"))
					//		&& strchk.trim().equalsIgnoreCase("N")) {
%>
 	<%//} else {

						%>
	<tr valign="top" class="datagrid">
		<td width="15%"
			align="center">&nbsp;&nbsp;<a
			href="#" onclick="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="33%" align="center"><%=Helper.correctNull((String) g1.get(1))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(2))%></td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(5))%></td>
	</tr>
	<%}
				}
			//}%>
</table>
<input type="hidden" name="appno"> 
<input type="hidden" name="appname">
<input type="hidden" name="applevel">
<input type="hidden" name="appstatus"> 
<input type="hidden" name="app_no"> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="srcpage" value="<%=Helper.correctNull(request.getParameter("page"))%>"> 
<input type="hidden" name="comapp_id" value="<%=strCompId%>"> 
<input type="hidden" name="comapp_compname" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
<input type="hidden" name="comapp_compid" value="<%=Helper.correctNull((String)hshValues.get("comapp_compid"))%>">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidSSIType" value="<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>">
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("select_cat"))%>">
<input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>">
<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>">
<input type="hidden" name="hidMethod">
<input type="hidden" name="valuesin" value="L">
<input type="hidden" name="comapp_newid" value="<%=Helper.correctNull((String)request.getParameter("idnew"))%>">
</form>
</body>
</html>