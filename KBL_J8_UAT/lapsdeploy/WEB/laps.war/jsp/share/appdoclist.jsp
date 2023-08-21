<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String strType = request.getParameter("doc_type");
	if (strType.equalsIgnoreCase("i")) {
		strType = "Internal";
	} else {
		strType = "Applicant";
	}
%>
<html>
<head>
<title>Setup - Product</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
 var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var doctype="<%=request.getParameter("doc_type")%>";
 
 function doOk()
 {
 	var docselectedcode="";
 	var bflag=false;
	var len=null;

	if(window.opener.document.forms[0].apdoc_del!=undefined)
	{
		len=window.opener.document.forms[0].apdoc_del.length;
	}
	if(len==null)
	{
		for(var j=0;j<document.forms[0].doclist.length;j++)
		{
			if(document.forms[0].doclist.options[j].selected)
		 	{
				var codeDate=document.forms[0].doclist.options[j].value.split("#");
				//for(i=0;i<window.opener.document.forms[0].apdoc_del.length;i++)
				{
					if(window.opener.document.forms[0].apdoc_del!=undefined)
					{
						if(codeDate[0] == window.opener.document.forms[0].apdoc_del.value)
						{
							bflag=true;
						}
					}
				 }
				 if(!bflag)
				 {
				 	docselectedcode=docselectedcode+codeDate[0];
				 	docselectedcode+="#";
				 }
				 else
				 {
				 	alert("The Selected Document is already available");
				 	return false;
				 }
			 }
		}
		if(!bflag)
		{
		 	window.opener.document.forms[0].hidNewDocCode.value=docselectedcode;
		 	window.opener.doSave();
		 	window.close();
		 }
	}
	else
	{
		for(var j=0;j<document.forms[0].doclist.length;j++)
		{
			if(document.forms[0].doclist.options[j].selected)
		 	{
				var codeDate=document.forms[0].doclist.options[j].value.split("#");
				for(i=0;i<window.opener.document.forms[0].apdoc_del.length;i++)
				{
					if(codeDate[0] == window.opener.document.forms[0].apdoc_del[i].value)
					{
					bflag=true;
					}
				 }
				 if(!bflag)
				 {
				 	docselectedcode=docselectedcode+codeDate[0];
				 	docselectedcode+="#";
				 }
				 else
				 {
				 	alert("The Selected Document is already available");
				 	return false;
				 }
			 }
		}
		if(!bflag)
		{
		 	window.opener.document.forms[0].hidNewDocCode.value=docselectedcode;
		 	window.opener.doSave();
		 	window.close();
		 }
	}
}
 function doClose()
 {
	 window.close();
 }
</script>


<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<!--<script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>
-->
<form name="myfrm" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="2"
	height="265" align="center" class="outertable border1">
	<tr>
		<td valign="top" height="259">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="8" align="center" class="outertable">
			<tr>
				<td height="20">
				<div align="left"><b>Documents - <%=strType%></b></div>
				</td>
			</tr>
			<tr>
				<td height="7">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td colspan="4" height="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td colspan="10">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="67" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="4"
											class="outertable">
											<tr>
												<td colspan="2">
												<div align="center"><select name="doclist" size="15"
													style="width: 625" multiple
													onclick="document.forms[0].cmdok.disabled=false"
													onDblClick="doOk()">
													<laps:documents />
												</select></div>
												</td>
											</tr>
											<tr>
												<td width="50%">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td><lapschoice:combuttonnew btnnames='OK'
															btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
</form>
<p>&nbsp;</p>
</body>
</html>
