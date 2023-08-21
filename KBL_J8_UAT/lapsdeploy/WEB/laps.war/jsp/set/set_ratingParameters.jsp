<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vec = new ArrayList();
			int vecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData2");
			}
			if (vec != null) {
				vecsize = vec.size();
			}
			//ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

</STYLE>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var building_type="<%=Helper.correctNull((String)hshValues.get("building_type"))%>";
var effectivedate="<%=Helper.correctNull((String)hshValues.get("effectivedate"))%>";
var housedate="<%=Helper.correctNull((String)hshValues.get("housedate"))%>";

function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, false);		
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
	}
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateDataHouseParameters";
	document.forms[0].hidBeanGetMethod.value="getDataHouseParameters";
	document.forms[0].hidSourceUrl.value="/action/set_ratingParameters.jsp";
	document.forms[0].action=appURL+"controllerservlet";	
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getDataHouseParameters";
		document.forms[0].action=appURL+"action/set_ratingParameters.jsp";	
		document.forms[0].submit();
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update";
	enableButtons(true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}



</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

</script></div>
</div>
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home
		-&gt; Setup -&gt; Other Parameters </td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0"
	 align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">

			<tr>
				<td valign="top">
				<table width="98%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top" height="76">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1 tableBg">
							<tr>
								<td valign="top" class="cellcontainer">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
								class="outertable"	>
									<tr height="25" align="center" class="dataheader">
										<td nowrap width="75%"><b>
											Parameters</b></td>
										<td nowrap width="25%">
											<b>Value</b></td>
									</tr>
									<%if (vecsize > 0) {
										for (int l = 0; l < vecsize; l++) {
											if (l < vecsize) {
												g2 = (ArrayList) vec.get(l);
												if(Helper.correctNull((String)g2.get(0)).equalsIgnoreCase("7")||Helper.correctNull((String)g2.get(0)).equalsIgnoreCase("8")){
									%>
									<tr>
										<td nowrap><b><br>
										<%=Helper.correctNull((String) g2.get(1))%></b> <br>
										<input type="hidden" name="txt_desc"
											value="<%=Helper.correctNull((String)g2.get(1))%>">
										<input type="hidden" name="txt_id"
											value="<%=Helper.correctNull((String)g2.get(0))%>">
											<input type="hidden" name="txt_class_desc"></td>

										<td align="center" nowrap>Rs.&nbsp;<input type="text"
											name="txt_noofyears" size="20" maxlength="16" tabindex="17"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g2.get(3))))%>"
											style="text-align:right" onKeyPress="allowNumber(this)" onblur="roundtxt(this)">
											 </td>

										<%}}
				}
										%>
										</tr>
										
										<%
			}
						%>
									
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="strOrgCode" value="<%=session.getAttribute("strOrgCode")%>"> 
<input type="hidden" name="hidAction" value="<%=Helper.correctNull((String)hshValues.get("strAction"))%>"> 
<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
<input type="hidden" name="hidstate" value="2">
<input type="hidden" name="hidfrom" value="RP">
<input type="hidden" name="auditflag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
<br>
</form>
</body>
</html>
