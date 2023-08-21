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
  
function callAppPage(appno, appholdusrname, appholder, status)
{
	if(document.forms[0].hidPageType.value=="PROP")
	{
		if(appholder=="N" && status=="OPEN/PENDING")
		{
			alert("The Application is with "+(appholdusrname.toUpperCase())+", So you cannot modify data in this application");
			return;
		}
		document.forms[0].appno.value=appno;
		document.forms[0].appstatus.value=status;
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanId.value="";
		document.forms[0].hidBeanMethod.value="";	
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp"
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
	else if(document.forms[0].hidPageType.value=="audit_trial")
	{
		select_cat=document.forms[0].select_cat.value;
		From_date=document.forms[0].From_date.value;
		To_date=document.forms[0].To_date.value;
		document.forms[0].appno.value=appno;
		var appno = document.forms[0].appno.value;
		var page="comrunappaudit.jsp";
		var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&select_cat="+select_cat+"&From_date="+From_date+"&To_date="+To_date+"&hidBeanGetMethod=getDataHelp";
		var title = "AuditReport";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
	}
	else
	{
		if(appholder=="N" && status=="OPEN/PENDING")
		{
			alert("The Application is with "+(appholdusrname.toUpperCase())+", So you cannot modify data in this application");
			
		}
		document.forms[0].appno.value=appno;
		document.forms[0].appstatus.value=status;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facilities.jsp";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
	}
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
			href="#" onclick="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(1))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="33%" align="center"><%=Helper.correctNull((String) request
										.getParameter("comapp_compname"))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
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