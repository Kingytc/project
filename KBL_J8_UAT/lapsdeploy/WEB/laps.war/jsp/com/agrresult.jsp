<%@include file="../share/directives.jsp"%>
<%ArrayList g1 = new ArrayList();%>
<html>
<head>
<script>
var varnewbuttonenable = "<%=Helper.correctNull((String)hshValues.get("newbuttonenable"))%>";
var varapplicantid="<%=Helper.correctNull((String)hshValues.get("hidapplicantid"))%>";
var varprofilestatus = "<%=Helper.correctNull((String)hshValues.get("profilestatus"))%>";
var varcategorytype="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
function callAppPage(appno, appholdusrname, appholder, status, appid)
{
	if(document.forms[0].hidPageType.value=="audit_trail")
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
		document.forms[0].comapp_id.value=appid;
		document.forms[0].appno.value=appno;
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ops_facilities.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	  }
}
function onload()
{
	if(varnewbuttonenable=="false")
	{
		parent.document.all.idnewbuton.style.visibility="hidden";
		parent.document.forms[0].hidapplicantid.value=varapplicantid;
	}
	else
	{
		if(varprofilestatus=="Y")
		{
			parent.document.all.idnewbuton.style.visibility="visible";
			parent.document.forms[0].hidapplicantid.value=varapplicantid;
		}
		else
		{
			parent.document.all.idnewbuton.style.visibility="hidden";
			parent.document.forms[0].hidapplicantid.value=varapplicantid;
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload()">
<form name=srchform>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<%	ArrayList v = (ArrayList) hshValues.get("vecval");
		if (v != null) 
		{
			int vecsize = v.size();
			for (int l = 0; l < vecsize; l++) 
			{
				g1 = (ArrayList) v.get(l);%>
	<tr valign="top" class="datagrid">
		<td width="25%"
			align="center">&nbsp;&nbsp;<a
			href="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>',
										'<%=Helper.correctNull((String)g1.get(3))%>',
										'<%=Helper.correctNull((String)g1.get(2))%>',
										'<%=Helper.correctNull((String)g1.get(1))%>',
										'<%=Helper.correctNull((String)g1.get(6))%>')"
			 align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="52%" align="center"><%=Helper.correctNull((String) request.getParameter("comapp_compname"))%>&nbsp;</td>
		<td width="23%" align="center">&nbsp;<%=Helper.correctNull((String) g1.get(1))%></td>
	</tr>
	<%}}%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="appno"> 
<input type="hidden" name="comapp_id"> 
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("select_cat"))%>">
<input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>">
<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>">
</form>
</body>
</html>
