<%@include file="../share/directives.jsp"%>
<%ArrayList g1 = new ArrayList();
	session.removeAttribute("appno");
	%>
<html>
<head>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varnewbuttonenable = "<%=Helper.correctNull((String)hshValues.get("newbuttonenable"))%>";
var varprofilestatus = "<%=Helper.correctNull((String)hshValues.get("profilestatus"))%>";
var varapplicantid="<%=Helper.correctNull((String)hshValues.get("hidapplicantid"))%>";
var varkycnormstatus="<%=Helper.correctNull((String) hshValues.get("str_statuscompkyc"))%>";
var varsearchtype="<%=Helper.correctNull((String) hshValues.get("searchtype"))%>";

function chkmail(appholdusrname)
{
	alert("The Application is with "+(appholdusrname.toUpperCase())+", So you cannot view this application");
}

function callAppPage(appno, appholdusrname, appholder, status, appid,proptype,appl_subtype)
{
	var hidPageType=document.forms[0].hidPageType.value;
	if(hidPageType=="audit_trial")
	{
		select_cat=document.forms[0].select_cat.value;
		From_date=document.forms[0].From_date.value;
		To_date=document.forms[0].To_date.value;
		document.forms[0].appno.value=appno;
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
		var varGLdate = "";
		if(appholder=="N" && status=="OPEN/PENDING")
		{
			alert("The Application is with "+(appholdusrname.toUpperCase())+", So you cannot modify data in this application");
		}
		else
		{
			varGLdate = "Y"
		}
		document.forms[0].appno.value=appno;
		if(proptype=="P")
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getHistory";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?appid="+appid+"&strAppType="+proptype+"&ModuleType=RET";
		}
		else
		{
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].hidBeanGetMethod.value="getLoanProducts";
			if(document.forms[0].hidCategoryType.value=="LAD")
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?appid="+appid+"&strAppType="+proptype+"&appname=<%=request.getParameter("appname")%>&varGLdate="+varGLdate;
			}
			else if(appl_subtype=="PR")
			{
				document.forms[0].hidCategoryType.value="DIGI";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perDigiLoandetails.jsp?appid="+appid+"&strAppType="+proptype+"&appname=<%=request.getParameter("appname")%>";
			}
			else
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?appid="+appid+"&strAppType="+proptype+"&appname=<%=request.getParameter("appname")%>";
			}
		}
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}

function onload()
{	
	if(varsearchtype !="APPLICATIONNO")	//When the search is done using application number no need to show the new application button
	{
		if(varnewbuttonenable=="false")
		{
			//parent.document.all.idnewbuton.style.visibility="hidden";
			//parent.document.all.idnewbuton.style.position="absolute";
			parent.frames.document.forms[0].cmdnew.disabled=true;
			parent.document.forms[0].hidapplicantid.value=varapplicantid;
		}
		else
		{
			if(varprofilestatus=="Y")
			{
				parent.document.all.idnewbuton.style.visibility="visible";  
				parent.document.all.idnewbuton.style.position="relative";
				parent.document.forms[0].hidapplicantid.value=varapplicantid;
			}
			/*else if(document.forms[0].hidCategoryType.value=="LAD" && varkycnormstatus == "Y")
			{
				parent.document.all.idnewbuton.style.visibility="visible";
				parent.document.all.idnewbuton.style.position="relative";
				parent.document.forms[0].hidapplicantid.value=varapplicantid;
			}*/
			else
			{
				//parent.document.all.idnewbuton.style.visibility="hidden";
				//parent.document.all.idnewbuton.style.position="absolute";
				parent.frames.document.forms[0].cmdnew.disabled=true;
				parent.document.forms[0].hidapplicantid.value=varapplicantid;
			}
		}
	}
	parent.frames.document.forms[0].hidRatingProposalFlag.value="<%=Helper.correctNull((String)hshValues.get("strRatingProposalPending"))%>";
	parent.frames.document.forms[0].hidRatingProposalPendingFlag.value="<%=Helper.correctNull((String)hshValues.get("strProposalPendinginKalypto"))%>";
	parent.frames.document.forms[0].hidRatingProposalUser.value="<%=Helper.correctNull((String)hshValues.get("strProposalUserID"))%>"+" : "+"<%=Helper.correctNull((String)hshValues.get("strProposalUserName"))%>";
	parent.frames.document.forms[0].hidApprovedApplDemoID.value="<%=Helper.correctNull((String)hshValues.get("str_approvedAppl_demoid"))%>";
	parent.frames.document.forms[0].hidOccuCode.value="<%=Helper.correctNull((String)hshValues.get("strOccupationCode"))%>";
}

</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onload()">
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
<table width="102%" border="0" cellspacing="1" cellpadding="2" class="outertable">
	<%ArrayList v = (ArrayList) hshValues.get("vecval");
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
						%>
	<tr valign="top" class="datagrid">
		<td width="10%"
			align="center"><a
			href="javascript:callAppPage('<%=Helper.correctNull((String)g1.get(0))%>',
										'<%=Helper.correctNull((String)g1.get(5))%>',
										'<%=Helper.correctNull((String)g1.get(4))%>',
										'<%=Helper.correctNull((String)g1.get(1))%>',
										'<%=Helper.correctNull((String)g1.get(7))%>',
										'<%=Helper.correctNull((String)g1.get(9))%>',
										'<%=Helper.correctNull((String)g1.get(10))%>')"
			align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
		<td width="18%" align="left"><%=Helper.correctNull((String) g1.get(2))%>&nbsp;</td>
		<td width="18%" align="left"><%=Helper.correctNull((String) g1.get(3))%>&nbsp;</td>
		<td width="27%" align="left"><%=Helper.correctNull((String) g1.get(8))%>&nbsp;</td>
		<td width="20%" align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
		<td width="7%" align="center"><%=Helper.correctNull((String) g1.get(6))%></td>
	</tr>
	<%}
				}
		%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="page"> 
<input type="hidden" name="appno"> 
<input type="hidden" name="appname"> 
<input type="hidden" name="appstatus"> 
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>">
<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>">
<input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("select_cat"))%>">

</form>
</body>
</html>
