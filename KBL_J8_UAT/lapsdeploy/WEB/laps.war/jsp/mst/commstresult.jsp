<%@include file="../share/directives.jsp"%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callAppPage(appno,cname,id,status)
{
		document.forms[0].appno.value=appno;
		document.forms[0].appname.value=cname;
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].hidBeanGetMethod.value="getfacilityData";
		document.forms[0].action=appURL+"action/commst_facilities.jsp?appstatus="+status;
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}

function chkmail(appholdername)
{
	alert("The Application is with "+(appholdername.toUpperCase())+", So you cannot view this application");
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name=srchform method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%ArrayList vecData = (ArrayList) hshValues.get("vecval");
			if (vecData != null && vecData.size()>0) {
				int vecsize = vecData.size();
				for (int l = 0; l < vecsize; l++) {
					ArrayList vecCol = (ArrayList) vecData.get(l);

					String strappstatus = Helper
							.correctNull((String) vecCol.get(2));
					String strHoldbyme = Helper.correctNull((String) vecCol.get(3));
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
					if (strappstatus.equalsIgnoreCase("Open/Pending")
							&& strHoldbyme.equalsIgnoreCase("N")) {
%>

	<tr valign="top" class="datagrid">
		<td  width="25%"
			align="center">&nbsp;&nbsp;<a
			href="#" onclick="javascript:chkmail('<%=Helper.correctNull((String)vecCol.get(4))%>')"><b><%=Helper.correctNull((String) vecCol.get(0))%></b></a>
		</td>
		<td width="52%" align="center"><%=Helper.correctNull((String)vecCol.get(1))%>&nbsp;
		</td>
		<td width="23%" align="center">&nbsp;<%=strappstatus%></td>
	</tr>

	<%} else {%>
	<tr valign="top" class="datagrid">
		<td  width="25%"
			align="center">&nbsp;&nbsp;<a
			href="#" onclick="javascript:callAppPage('<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)request.getParameter("comapp_id"))%>','<%=Helper.correctNull((String)vecCol.get(2))%>')"><b><%=Helper.correctNull((String) vecCol.get(0))%></b></a>
		</td>
		<td width="52%" align="center"><%=Helper.correctNull((String)vecCol.get(1))%>&nbsp;
		</td>
		<td width="23%" align="center">&nbsp;<%=strappstatus%></td>
	</tr>


	<%}
				}
			}

			%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
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
