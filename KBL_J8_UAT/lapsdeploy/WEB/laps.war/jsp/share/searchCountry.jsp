<%@include file="../share/directives.jsp"%>
<%ArrayList arrValues = new ArrayList();
			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCntry");
			}
		String hidcntrycontrol = Helper.correctNull((String)request.getParameter("hidcntrycontrol"));
		String hidcntrycodecontrol  = Helper.correctNull((String)request.getParameter("hidcntrycodecontrol"));%>
<html>
<head>
<title>Country Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callSearch()
{
	var txtval=document.forms[0].txt_codename.value;
	var txtlen=txtval.length;	
	 if(txtlen<=2)
	 {
		 alert("Enter atleast 3 characters");
	     document.forms[0].txt_codename.focus();
	     return;
 	 }
	else if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].txt_codename.focus();
	     return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getCountrySearchList";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchCountry.jsp";	
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

function setValues(value1,value2)
{
	window.opener.document.forms[0].elements["<%=hidcntrycontrol%>"].value = value1;
	window.opener.document.forms[0].elements["<%=hidcntrycodecontrol%>"].value = value2;
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
<body>
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
                 
                  <td width="12%" nowrap><b>Enter Country</b></td>
                  <td width="26%"> 
                    <input type="text" name="txt_codename" size="20"
							maxlength="25" value="" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="62%">
                      <input type="button" name="cmdsearch"	value="Search" class="buttonStyle" onClick="callSearch()">
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

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
							<tr class="dataheader">
								<td width="15%"><b> Code</b></td>
								<td width="45%"><b>Country Name</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center"><div class="cellContainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable linebor">
							<%if (arrValues != null&&arrValues.size()>0) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);%>
							<tr class="datagrid">
								<td width="15%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>')">
                          												<%=Helper.correctNull((String) arrCol.get(1))%></a></td>

								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>')">
                          												<%=Helper.correctNull((String) arrCol.get(0))%></a></td>

							</tr>
							<%}}
							else
							{
							%>
							<tr class="datagrid">
								<td>&nbsp;</td>
							</tr>
							<tr class="datagrid">
								<td align="center"><b>No Data Found</b></td>
							</tr>
							<tr class="datagrid">
								<td>&nbsp;</td>
							</tr>
							<%
							}
							%>
							<!--remove data grid space for country-->
						</table></div>
						<table width="10%" border="0" cellspacing="0" cellpadding="3" class="outertable"
							align="center">
							<tr valign="top">
								<td width="20%"><lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/></td>
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

<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidAction">

<input type="hidden" name="hidcntrycontrol" value="<%=Helper.correctNull((String)request.getParameter("hidcntrycontrol")) %>">
<input type="hidden" name="hidcntrycodecontrol" value="<%=Helper.correctNull((String)request.getParameter("hidcntrycodecontrol")) %>">
</form>
</body>
</html>
