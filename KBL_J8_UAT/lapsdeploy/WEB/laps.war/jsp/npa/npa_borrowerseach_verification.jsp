<%@include file="../share/directives.jsp"%>
<%
	String strCategorytype = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
%>
<html>
<head>
<title>NPA Verification Account Search</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function doReset()
{
	document.forms[0].reset();
	document.forms[0].txtsearch.focus();
	document.all.result.src=appURL+"action/blank.jsp";

}
function doSearch()
{
	var search;
   if(document.forms[0].txtsearch.value=="")
	{
		alert("Enter data in any of the search criteria");
		return;
	}

   for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
	if(document.forms[0].radiobutton[i].checked==true)
		{
		
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
   // for searching

   if(document.forms[0].chk_search.checked==true)
   {
	   search="GlobalSearch"; 
   }
	txtsearch =  document.forms[0].txtsearch.value;
	
	hidCategoryType= document.forms[0].hidCategoryType.value;
	
	document.all.result.src=appURL+"action/npaborsearchresult_verify.jsp?hidBeanId=borrowersearch&hidBeanGetMethod=getNPAAccountVerifySearchData&rdovalue="+rdovalue+"&txtsearch="+txtsearch+"&hidCategoryType="+hidCategoryType+"&strSearch="+search;

}
function doClose()
{
	document.forms[0].action=appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
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
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA - Account Details (Search)
 				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	height="400" align="center" class="outertable">
	<tr>
		<td valign="top" height="397">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" class="outertable">
					<tr>
						<td valign="top" align="left"><b>Borrower Search</b><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							height="100%" class="outertable">
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
											<td colspan="6"><input type="checkbox" name="chk_search" style="border: none;"> Global Search</td>
											</tr>
										<tr>
												<td ><input type="radio" name="radiobutton"
													value="NAME" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td  nowrap="nowrap">Borrower Name</td>

												
												<td ><input type="radio" name="radiobutton"
													value="CBSID" style="border-style:none"
													onClick="onRadioClick()" checked="checked"></td>
												<td >CBS Customer ID</td>
												
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20"
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
												
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="doSearch()" tabindex="3"></td>
													<td width="18%">&nbsp;</td>
											</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="dataheader">

												<td width="33%" align="center">Borrower Name</td>
												<td width="26%" align="center">CBS Customer Id</td>
												<td width="41%" align="center">Organisation</td>
											</tr>
										</table>
										</td>
									</tr>


									<tr align="center" valign="top">
										<td><iframe id="result" src="" width="100%"
											height="240" border="no"></iframe></td>
									</tr>
									<tr align="center">
										<td colspan="6">&nbsp;</td>
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

<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidBeanMethod" value="getNPAAccountSearchData" />
<input type="hidden" name="hid_rowcount" value="" />
</form>
</body>
</html>
