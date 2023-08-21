<%@include file="../share/directives.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>DCB REPORTS</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/generalreportnav.jsp";
		 document.forms[0].submit();
	 }
}

function selectValues()
{
	var i=0,j=0;
	document.forms[0].sel_org.selectedIndex =-1;
	var bnkname = document.forms[0].sel_level.options[document.forms[0].sel_level.selectedIndex].value;
	document.all.ifrm.src=appUrl+"action/iframenpareport.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
}

function checkfields()
{
	var i;
	if(document.forms[0].sel_level.value=="0")
	{
		alert("Select level");
		document.forms[0].sel_level.focus();
		return false;
	} 
	for(i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].sel_org.length)
	{
		alert("Select an Organisation");
		document.forms[0].sel_org.focus();
		return false;
	}
	return true;
}

function runreport()
{
	if(checkfields())
	{
	var code=document.forms[0].sel_org.value;
	for(var i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			var orgname=document.forms[0].sel_org.options[i].text;
		}
	}
	window.open(appUrl+"action/dcbregister.jsp?hidBeanId=npa&hidBeanMethod=getDCBRegisterData&hidBeanGetMethod=getDCBRegisterData&hidOrgName="+orgname+"&hidcode="+code+"&hidlevel="+document.forms[0].sel_level.value,"stat","scrollbars=Yes,toolbars=No,menubar=Yes ,width=1000 , height=550,top=10,left=10");
	}
}

function selectLevels()
{	
	for(i=0,j=1;i<document.forms[0].sel_level.options.length && document.forms[0].sel_level.options.length>2;i++)
	{
		if(document.forms[0].sel_level.options[i].text=="REGIONAL" || document.forms[0].sel_level.options[i].text=="BRANCH")
		{
			document.forms[0].sel_level.options[j].text=document.forms[0].sel_level.options[i].text;
			document.forms[0].sel_level.options[j].value=document.forms[0].sel_level.options[i].value;
			j++;
		}
	}
	if(document.forms[0].sel_level.options.length>3)
	{
		document.forms[0].sel_level.options.length=3;
	}
}

</script>
</head>
<body onLoad="selectValues();selectLevels()">
<form class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0" >
<tr>
	<td class="page_flow">
		 Home -> DCB Register
	</td>
</tr>
</table>
<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
<tr>
<td>
</td>
</tr>
</table>

	
			<table cellspacing="0" cellpadding="0"  class="outertable border1" width="50%" align="center" valign="middle" border="0" >
			<tr>
			<td>
				<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" align="center" border="0" >
					
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
							<tr>
								<td width="50%" align="center" >
									Level
								</td>
						</table><br>
					</td>
					</tr> 
					<tr>
					<td>
					<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
					 <tr>
						<td width="50%" align="center">
							<select name="sel_level" onChange="selectValues()">
								<option value="0"> --select-- </option>
								<lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" />
							</select>
						</td>
					</tr>
				</table>
				</td>
				</tr> 
				<tr>
				<td ><br>
					<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
						<tr>
							<td align="center" width="100%">
								Select Organisation
							</td>
							
						</tr>
					</table><br>
				</td>
				</tr>
				<tr>
				<td >
					<table cellspacing="0" cellpadding="0"  class="outertable" width="100%" border="0">
						<tr>
							<td align="center" width="100%">
								<select name="sel_org" size="10" style="width:250" >
								</select>
							</td>
							
						</tr>
					</table><br>
				</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
				
	
<tr>
				<td>
				
					<br>		<table cellspacing="0" cellpadding="0"  class="outertable border1" border="0" align="center">
							<tr>
							<td width="100%" align="center">
							<input type="button" name="cmdRunReport" value="Run Report" class="buttonothers" onclick="runreport()">
							<input type="button" name="cmdClose" value="Close" class="buttonclose" onClick="doClose()">
							</td>
							</tr>
							</table>
					
			<br>
<input type="hidden" name="hidOrgCode">
</form>
</body>
</html>
