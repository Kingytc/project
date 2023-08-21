<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCode");
			}
			//out.print();
			String strID = Helper.correctNull((String) request
					.getParameter("id"));
			String pagename = Helper.correctNull((String) request
					.getParameter("pagename"));

			%>
<html>
<head>
<title>Static Data Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<script
src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>

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
			 alert("Enter atleast 3 charcters");
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
	document.forms[0].hidBeanMethod.value="getSearch";
	document.forms[0].hidBeanGetMethod.value="getSearch";
	document.forms[0].hidBeanId.value="additionalParameter";
	document.forms[0].action=appURL+"action/ops_sanctionhelp.jsp";	
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
	
	if("<%=pagename%>"=="mainactdesc")
	{
		window.opener.document.forms[0].txt_MainActivityCode.value=value2;
		window.opener.document.forms[0].txt_MainActivity.value=value3;
	}
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
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body >
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						<td width="4%" nowrap="nowrap" style="visibility: hidden"><input type="radio" name="cat" value="1"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="25%" nowrap="nowrap" style="visibility: hidden"><b>CBS
						Code</b></td>
						<td width="4%" nowrap="nowrap" style="visibility: hidden"><input type="radio" name="cat" value="2"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="17%" nowrap="nowrap" style="visibility: hidden"><b> CBS
						Parameter</b></td>
						<td width="16%" style="visibility: hidden"><input type="text" name="txt_codename" size="20"
							maxlength="25" value="" onKeyPress="notAllowSplChar()">
						</td>
						<td width="16%" style="visibility: hidden">
						<div align="center"><input type="button" name="cmdsearch"
							value="Search"
							class="buttonStyle"
							onClick="callSearch()"></div>
						</td>

					</tr>
					<tr>
						<td colspan="7" nowrap="nowrap">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td width="15%"> Code</td>
								<td width="45%"><b>CBS
								Parameter</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center">
						<DIV class="cellcontainer">

						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
							<%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);

					%>
							<tr class="datagrid">
								<td width="15%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>

								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>

							</tr>
							<%}

			}

			%>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td width="15%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>

						</table>
						</div>
					<lapschoice:combuttonnew 
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="pagename" value="<%=pagename%>"> 
<input type="hidden" name="id" value="<%=strID%>"> 
</form>
</body>
</html>
