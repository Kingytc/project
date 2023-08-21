<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrBSRCode");
			}
			//out.print();
			String strPage = Helper.correctNull((String) request
					.getParameter("page"));
			String pagename = Helper.correctNull((String) request
					.getParameter("pagename"));

			%>
<html>
<head>
<title>Industrial Activity Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var pagename = "<%=pagename%>";

function callSearch()
	{
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
			
		var txtval=document.forms[0].txt_bsrcode.value;
		var txtlen=txtval.length;	
			if (cat==2)
			{
				 if(txtlen<=2)
				 {
					 alert("Enter atleast 3 characters");
				     document.forms[0].txt_bsrcode.focus();
				     return;
			 	 }
			}
			else if(txtval=="")
			{
					 alert("Enter Value to Search");
				     document.forms[0].txt_bsrcode.focus();
				     return;
			}
		document.forms[0].method="post";
		document.forms[0].hidBeanMethod.value="getSetupBSRCode";
		document.forms[0].hidBeanGetMethod.value="getSetupBSRCode";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].action=appURL+"action/comsetupindustrymasterhelp.jsp";	
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

function setValues(value1,value2,value3,value4,value5,value6)
	{
		if("<%=strPage%>"=="industrymaster")
		{
				//window.opener.document.forms[0].hidinudstryname.value=varArr[0];
				window.opener.document.forms[0].txt_bsrcode.value=value1;
				window.opener.document.forms[0].txt_industryname.value=value2;
				window.opener.document.forms[0].hidinudstryname.value=value3;
				window.opener.document.forms[0].txt_indgrpcode.value=value4;
				window.opener.document.forms[0].txt_indgrp.value=value5;
				window.opener.document.forms[0].selactive.value=value6;
				window.opener.document.forms[0].cmdedit.disabled=false;
				window.opener.document.forms[0].cmdnew.disabled=true;
				window.opener.document.forms[0].cmddelete.disabled=false;
				window.opener.varRecordFlag = "Y";
		}
		else
		{		
			var value6=value1+"-"+value2;
			//alert(value3);
			window.opener.document.forms[0].comapp_companyid.value = value6;
			window.opener.document.forms[0].comapp_indcode.value = value3;
		}
		window.close();
	}


function doSelect()
{
	document.forms[0].txt_bsrcode.value="";
	document.forms[0].txt_bsrcode.focus();
}
function callonLoad()
	{
	
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
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable"
	align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Select Industry ID</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						<td width="4%" nowrap><input type="radio" name="cat" value="1"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="25%" nowrap><b>BSR Code:</b></td>
						<td width="4%" nowrap><input type="radio" name="cat" value="2"
							onClick="doSelect()" style="border-style:none"></td>
						<td width="17%" nowrap><b>Industrial Activity</b></td>
						<td width="16%"><input type="text" name="txt_bsrcode" size="20"
							maxlength="25" value="" onKeyPress="notAllowSplChar()"></td>
						<td width="16%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()"></td>

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

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td width="15%"><b>BSR Code</b></td>
								<td width="45%"><b>Industrial
								Activity</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center">
						<DIV class="cellcontainer">

						<table width="100%" border="0" cellspacing="1" cellpadding="2"
						class="outertable"	>
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
                          												'<%= Helper.replaceForJavaScriptString((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(3))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(4))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(5))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.replaceForJavaScriptString((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(3))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(4))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(5))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
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
<input type="hidden" name="hidBranchCode" value="<%=Helper.correctNull((String)request.getParameter("hidBranchCode")) %>">
<input type=hidden name="hidPageName" value="comsetupindustrymasterhelp.jsp">
<input type=hidden name="page" value="<%=strPage%>">
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>">
</form>
</body>
</html>
