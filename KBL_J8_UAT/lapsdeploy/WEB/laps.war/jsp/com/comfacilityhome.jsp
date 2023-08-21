<%@include file="../share/directives.jsp"%>
<%
	ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
	ArrayList arryCol = null;
	String strComm = "";
	String strPar = "";
%>
<html>
<head>
<title>Corporate & Agriculture Products Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var varRights = grpRights.charAt(13);
var strSaveType = "<%=Helper.correctNull(request.getParameter("hidprd_save"))%>";
var strType = "<%=Helper.correctNull(request.getParameter("hid_producttype"))%>";
var strSearchType = "<%=Helper.correctNull(request.getParameter("prd_range"))%>";
var strRangeFrom = "<%=Helper.correctNull(request.getParameter("textrng"))%>";
var strRangeTo = "<%=Helper.correctNull(request.getParameter("textto"))%>";
var strext = "<%=Helper.correctNull(request.getParameter("prd_choose"))%>";
var strcat= "<%=Helper.correctNull(request.getParameter("hidprd_cat"))%>";
var strTerm = "<%=request.getParameter("prd_term")%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="disRadio()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div></div>
<script language="JavaScript">
function doGetProducts()
{
	showcomm();
	saveassign();
	if((document.forms[0].prd_producttype[0].checked==false) && document.forms[0].prd_producttype[1].checked==false)
	{
		alert("Select any one option for Product");
		return;
	}
	if((document.forms[0].prd_save[0].checked==false) && document.forms[0].prd_save[1].checked==false)
	{
		alert("Select any one option for Save Type");
		return;
	}
	document.forms[0].hidprd_select.value ="getSelect";
	document.forms[0].action = appURL+"action/comfacilityhome.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function disRadio()
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "radio")
		{
			document.forms[0].elements[i].disabled = true;
		}
	}
	document.forms[0].prd_choose[0].disabled = false;
	document.forms[0].prd_choose[1].disabled = false;
}
function showsub()
{
	if(document.forms[0].prd_choose[1].checked == true)
	{
		if(varRights == "p")
		{
			document.forms[0].prd_type[0].disabled =false;			
		}
		if(varRights == "c")
		{
			document.forms[0].prd_type[1].disabled =false;
		}
		if(varRights == "b")
		{
			document.forms[0].prd_type[0].disabled =false;
			document.forms[0].prd_type[1].disabled =false;
			document.forms[0].prd_type[2].disabled =false;
			document.forms[0].prd_type[3].disabled =false;			
		}
	}
}
function showcomm()
{
	document.forms[0].hidprd_type.value='p';
	document.forms[0].prd_save[0].disabled = false;
	document.forms[0].prd_save[1].disabled = false;
	document.forms[0].prd_producttype[0].disabled = false;
	document.forms[0].prd_producttype[1].disabled = false;
	document.forms[0].cmdgetproducts.disabled=false;	
}
function saveassign()
{
	if(document.forms[0].prd_save[0].checked == true)
	{
		document.forms[0].hidprd_save.value="p";
	}
	else if(document.forms[0].prd_save[1].checked == true)
	{
		document.forms[0].hidprd_save.value="c";
	}
}
function callfacility(pcode)
{
	if(pcode == 'new')
	{
		document.forms[0].fac_id.value=pcode;
		document.forms[0].action=appURL+"action/setfacility.jsp";
		document.forms[0].submit();
	}
	else 
	{
		document.forms[0].fac_id.value=pcode;
		document.forms[0].action=appURL+"action/setfacility.jsp?val=existing";
		document.forms[0].submit();
	}
}
function producttype()
{
	if(document.forms[0].prd_producttype[0].checked==true)
   	{
   		document.forms[0].hidModType.value="c";
   	}
   	else if(document.forms[0].prd_producttype[1].checked==true)
   	{
   		document.forms[0].hidModType.value="a";
   	}
}
</script>
<form name="fachome" method="get" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<jsp:include page="../share/help.jsp" flush="true"/> 
				<jsp:include page="../share/menus.jsp" flush="true"/>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate -&amp; Agriculture Products -&gt; Search Products</td>
</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="datagrid">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr class="datagrid">
							<td width="5%">
								<input type="radio" name="prd_choose" value="New" style="border-style:none"
										onclick="callfacility('new')">
							</td>
							<td width="25%">Create New</td>
							<td width="5%">
								<input type="radio" name="prd_choose" value="Existing" style="border-style:none"
										onClick="showsub();showcomm()">
							</td>
							<td width="65%">Existing Products</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr class="dataheader">
							<td colspan="4" id="prdtype">Product For</td>
						</tr>
						<tr class="datagrid">
							<td width="5%">
								<input type="radio" name="prd_producttype" value="Corp" style="border-style:none"
										onclick="producttype()"> 
							</td>
							<td width="25%">Corporate</td>
							<td width="5%">
								<input type="radio" name="prd_producttype" value="Agri" style="border-style:none"
										onClick="producttype()"> 
							</td>
							<td width="65%">Agriculture</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"> 
						<tr class="dataheader">
							<td colspan="4" id="prdtype">Save type</td>
						</tr>
						<tr class="datagrid"> 
							<td width="3%" id="prdtype">
								<input type="radio" name="prd_save" value="Partial" style="border-style:none"
										onClick="saveassign()">
							</td>
							<td width="47%">Partial</td>
							<td width="3%">
								<input type="radio" name="prd_save" value="Complete" style="border-style:none"
										onClick="saveassign()">
							</td>
							<td width="47%">Completed</td>
						</tr> 
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="0" align="center" class="outertable border1"> 
						<tr> 
							<td height="20" valign="top"> 
								<table width="100%" border="0" cellspacing="0" cellpadding="1"> 
								<tr> 
									<td colspan="4"> 
										<table width="100%" border="0" cellpadding="0" cellspacing="0"> 
										<tr> 
											<td> 
												<table width="100%" border="0" cellpadding="3" cellspacing="1"> 
												<tr class="dataheader"> 
													<td width="7%" align="center">Facility Id</td>
													<td width="17%" align="center">Facility Head</td>
													<td width="13%" align="center">Facility</td>
													<td width="15%" align="center">Facility Code</td>
													<td width="24%" align="center">Description</td>
													<td width="9%" align="center">Range From</td>
													<td width="13%" align="center">Range To</td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td> 
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
												<%if (arryRow != null) {
												for (int i = 0; i < arryRow.size(); i++) {
												arryCol = (ArrayList) arryRow.get(i);%>
												<tr class="datagrid"> 
													<td width="7%" align="center"><a href="javaScript:callfacility('<%=Helper.correctNull((String)arryCol.get(0))%>')"> 
													<%=Helper.correctNull((String)arryCol.get(0))%></a></td>
													<td width="17%" align="center"><a href="javaScript:callfacility('<%=Helper.correctNull((String)arryCol.get(0))%>')"> 
													<%=Helper.correctNull((String)arryCol.get(5))%></a></td>
													<td width="13%" align="left"><%=Helper.correctNull((String) arryCol.get(6))%> </td>
													<td width="15%" align="left"><%=Helper.correctNull((String) arryCol.get(1))%></td>
													<td width="24%" align="left"><%=Helper.correctNull((String) arryCol.get(4))%></td>
													<td width="9%" align="right"><%=Helper.correctNull((String) arryCol.get(2))%>&nbsp;</td>
													<td width="13%" align="right"><%=Helper.correctNull((String) arryCol.get(3))%>&nbsp;</td>
												</tr> 
												<%}
												}%> <%long lngArrSize = 0;
												if (arryRow != null) {
													lngArrSize = arryRow.size();
												}
												if (arryRow == null || lngArrSize == 0) {
												%> 
												<tr> 
													<td colspan="7" align="center">&nbsp;</td>
												</tr> 
												<tr> 
													<td align="center" colspan="7">No Data Found</td>
												</tr>
												<tr> 
													<td colspan="7" align="center">&nbsp;</td>
												</tr> 
												<%}%>
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
<br> 
<lapschoice:combuttonnew btnnames='Get Products' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="prd_type" value="P" style="border-style:none"> 
<input type="hidden" name="prd_type" value="C" style="border-style:none"> 
<input type="hidden" name="prd_type" value="O" style="border-style:none"> 
<input type="hidden" name="prd_type" value="A" style="border-style:none"> 
<input type="hidden" name="hidprd_type" value="<%=Helper.correctNull(request.getParameter("hidprd_type"))%>"> 
<input type="hidden" name="hidprd_term" value="<%=Helper.correctNull(request.getParameter("hidprd_term"))%>"> 
<input type="hidden" name="hidprd_save" value="<%=Helper.correctNull(request.getParameter("hidprd_save"))%>"> 
<input type="hidden" name="hidprd_cat" value="<%=Helper.correctNull(request.getParameter("hidprd_cat"))%>"> 
<input type="hidden" name="hidprd_select" value="<%=Helper.correctNull(request.getParameter("hidprd_select"))%>"> 
<input type="hidden" name="hidprd_rng" value="<%=Helper.correctNull(request.getParameter("hidprd_rng"))%>"> 
<input type="hidden" name="fac_id" value="<%=Helper.correctNull(request.getParameter("hidcorp_facid"))%>"> 
<input type="hidden" name="hid_producttype" value="<%=Helper.correctNull(request.getParameter("hid_producttype"))%>"> 
<input type="hidden" name="hidcorp_faccode" value="<%=Helper.correctNull(request.getParameter("hidcorp_faccode"))%>"> 
<input type="hidden" name="hidcorp_headname" value="<%=Helper.correctNull(request.getParameter("hidcorp_headname"))%>"> 
<input type="hidden" name="hidcorp_subfac" value="<%=Helper.correctNull(request.getParameter("hidcorp_subfac"))%>"> 
<input type="hidden" name="prd_rng_from" value="<%=Helper.correctNull(request.getParameter("prd_rng_from"))%>"> 
<input type="hidden" name="prd_rng_to" value="<%=Helper.correctNull(request.getParameter("prd_rng_to"))%>">
<input type="hidden" name="hidModType">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>