<%@include file="../share/directives.jsp"%>
<%ArrayList arrTerms = new ArrayList();
			ArrayList arrTermsComments = new ArrayList();
			ArrayList arrTermId = new ArrayList();
			if (hshValues.size() > 1) {
				arrTerms = (ArrayList) hshValues.get("arrTerms");
				arrTermsComments = (ArrayList) hshValues.get("arrTermsComments");
				arrTermId = (ArrayList) hshValues.get("arrTermId");
			}
			String strHead = Helper.correctNull((String) request.getParameter("seltermvalue"));
			String strAction = Helper.correctNull(request.getParameter("hidAction"));
			String strTermid = Helper.correctNull(request.getParameter("seltermid"));
			String page_from = Helper.correctNull((String) hshValues.get("page_from"));
			String appno = Helper.correctNull((String) hshValues.get("appno"));%>
<html>
<head>
<title>Deleted Data</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var pgfrm= "<%= page_from %>";
var hidComValue = "<%=Helper.correctNull((String)hshValues.get("hidComValue"))%>";
function doClose()
{
	window.close();
}
function doUndelete()
{
	<%if (arrTerms.size() > 0){%>
	var len = document.forms[0].rdtermid.length;
	var flag= "<%=strTermid %>";
	var termid;
	if(len==null)
	{
		if(document.forms[0].rdtermid.value==null)
		{
			alert("Select the terms to UnDelete");
			return;
		}
		else
		{
			termid = document.forms[0].rdtermid.value;
		}
	}
	else
	{
		boolval = false;
		for(i=0;i<len;i++)
		{
			if(document.forms[0].rdtermid[i].checked==true)
			{
				termid = document.forms[0].rdtermid[i].value;
				boolval=true;
			}
		}
		if(boolval==false)
		{
			alert("Select the terms to UnDelete");
			return;
		}
	}
	window.opener.document.forms[0].hidAction.value="undelete";
	window.opener.document.forms[0].hidBeanId.value="apptermscond";
	window.opener.document.forms[0].hidBeanMethod.value="UndeleteTermsData";
	window.opener.document.forms[0].action=appUrl+"action/controllerservlet";
	window.opener.document.forms[0].hidBeanGetMethod.value="getTerms";
	if(window.opener.document.forms[0].hidLoanType && window.opener.document.forms[0].hidLoanType.value=="P")
	{
		window.opener.document.forms[0].hidSourceUrl.value="action/apptermsandcond.jsp";
	}
	else
	{
		window.opener.document.forms[0].hidSourceUrl.value="action/apptermsandcondagr.jsp";
	}
	window.opener.document.forms[0].rdtermid.value=termid;
	window.opener.document.forms[0].method="post";
	window.opener.document.forms[0].submit();
	window.close();
	<%}%>
}
function enableUndelete()
{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		if (document.forms[0].appstatus.value!= "Open/Pending" )
		{
			document.forms[0].cmdundelete.disabled = true;
		}
		else if(document.forms[0].cmdundelete.disabled == true)
		{
			document.forms[0].cmdundelete.disabled = false;
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body onblur="self.focus()">
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
<form name="frmundeleteterms" method="post" class="normal">
<lapschoice:application />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td>&nbsp;</td>
				<td width="66%" align="center">Deleted Data</td>
				<td class="tabactivenew" align="center">Remarks</td>
			</tr>
			<tr class="datagrid">
				<td colspan=2><b><%=strHead%></b></td>
				<%if (arrTerms.size() > 0) {
				int x = 1;
				for (int i = 0; i < arrTerms.size(); i++) {%>
			<tr class="datagrid">
				<td width="10%"><input type="radio" name="rdtermid"
					value="<%=(String)arrTermId.get(i)%>" onClick="enableUndelete()" style="border:none">
				<td width="56%"><%=x++%>) <%=Helper.breakText((String) arrTerms.get(i), 100)%></td>
				<td width="34%"><%=Helper.breakText(
									(String) arrTermsComments.get(i), 100)%></td>
			</tr>
			<%}} else {%>
			<tr class="datagrid">
				<td width="10%" align="right">&nbsp;</td>
				<td width="56%" align="right">&nbsp;</td>
				<td width="34%" align="right">&nbsp;</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Undelete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag/>
</form>
</body>
</html>

