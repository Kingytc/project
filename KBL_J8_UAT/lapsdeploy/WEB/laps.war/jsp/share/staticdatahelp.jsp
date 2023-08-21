<%@include file="../share/directives.jsp"%>
<%ArrayList arrValues = new ArrayList();
			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCode");
			}
			String strID = Helper.correctNull((String) request.getParameter("id"));
			String pagename = Helper.correctNull((String) request.getParameter("pagename"));%>
<html>
<head>
<title>Static Data Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callSearch()
{
	var id="<%=strID%>";
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}			
	var txtval=document.forms[0].txt_codename.value;
	var txtlen=txtval.length;	
	if (cat==2)
	{
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
		     document.forms[0].txt_codename.focus();
		     return;
	 	 }
	}
	else if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].txt_codename.focus();
	     return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getSearch";
	document.forms[0].hidBeanId.value="additionalParameter";
	document.forms[0].action=appURL+"action/staticdatahelp.jsp";	
	document.forms[0].submit();
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}			
	}
}
function setValues(value1,value2,value3)
{	
	var value5=value3+"-"+value2;
	window.opener.document.forms[0].hidsecid.value=value3;
	window.opener.document.forms[0].txtsecdesc.value=value5;
	window.close();
}
function doSelect()
{
	document.forms[0].txt_codename.value="";
	document.forms[0].txt_codename.focus();
}
function doClose()
{
	window.close();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						<td width="4%" nowrap><input type="radio" name="cat" value="1"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="25%" nowrap><b>Security
						</b></td>
						<td width="4%" nowrap><input type="radio" name="cat" value="2"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="17%" nowrap><b> Security Code</b></td>
						<td width="16%"><input type="text" name="txt_codename" size="20"
							maxlength="25" value="" onKeyPress="notAllowSplChar()">
						</td>
						<td width="16%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()">
						</td>
					</tr>
					<tr>
						<td colspan="7" nowrap>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="97.3%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
							<tr class="dataheader">
								<td width="50%"><b> Security</b></td>
								<td width="50%"><b>Security Code</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center"><%if (arrValues != null){if(arrValues.size()>6){ %>
								<div class="cellContainer">
								<%} }%>
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
							<%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);%>
							<tr class="datagrid">
								<td width="50%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>

								<td width="50%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>

							</tr>
							<%}}%>
					
						</table>
								<%if (arrValues != null){if(arrValues.size()>6){ %></div><%}} %>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="pagename" value="<%=pagename%>"> 
<input type=hidden name="id" value="<%=strID%>"> 
<input type="hidden" name="hidAction">
</form>
</body>
</html>
