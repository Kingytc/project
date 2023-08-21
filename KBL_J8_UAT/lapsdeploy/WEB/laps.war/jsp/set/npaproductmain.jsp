<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>LAPS- Products</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowNPA";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	
}
function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callFunction1(page,bean,method)
{	 
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
</script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<script language="JavaScript">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+'setupnav.jsp';
	document.forms[0].submit();
}
</script>
<form name="frmloanrpt" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Setup -&gt; NPA module </td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
<br>
<table width="40%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				<td width="84%" valign="top">
				<center>
				<fieldset ><legend>
				 <b>NPA MODULE </b>
				 </legend>
				<table width="100%" cellpadding="1" cellspacing="1" border="0" class="outertable">
					<tr>
						<td valign="top" align="center">
						<fieldset style="width:180;">
						<table border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr >
								<td ><b> <a
									href="javascript:callWorkflow('setprdworkflowcomnpa.jsp')"
									>Flowpoints</a></b></td>
							</tr>
							<tr>
								<td nowrap><b> <a
									href="javascript:callFunction('npadelegatepower.jsp')"
									><b>Delegated
								Powers</b> </a> </b></td>
							</tr>
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('aggregate_means.jsp','npasetup','getaggregatemeansData')"
									>Aggregate Means</a></b></td>
							</tr>
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('Realisible_value.jsp','npasetup','getRealisible')"
									>Realisible values</a></b></td>
							</tr>
						</table>
						</fieldset>
						</td>
						<td>
						<fieldset style="width:180;">
						<table border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('ageofnpa.jsp','npasetup','getAgeofNpa')"
									>Age of NPA</a></b></td>
							</tr>
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('npainterest.jsp','npasetup','getNpainterest')"
									>NPA Interest Master</a></b></td>
							</tr>
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('npamethodology.jsp','npasetup','getMethodology')"
									>Methodology</a></b></td>
							</tr>
							<tr>
								<td><b><A
									HREF="javascript:callFunction1('legal_position.jsp','npasetup','getLegalPosition')"
									>Legal Position</a></b></td>
							</tr>
						</table>
						</fieldset>
						</td>
					</tr>
				</table>
				</fieldset>
				</center>

				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
 <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
