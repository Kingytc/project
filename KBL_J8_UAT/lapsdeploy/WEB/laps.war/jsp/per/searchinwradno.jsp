<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrValues = new ArrayList();

	if (hshValues != null) {
		arrValues = (ArrayList) hshValues.get("arrRow");
	}
	String strCategory = Helper.correctNull((String)hshValues.get("Category"));
 
		
%>

<html>
<head>
<title>Inward Numbers</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strCbschk="<%=Helper.correctNull((String)hshValues.get("strCbsidchk"))%>";
var strSecchk="<%=Helper.correctNull((String)hshValues.get("strSecchk"))%>";
var strDocrecv="<%=Helper.correctNull((String)hshValues.get("strDocrecv"))%>";
var varreqpagefrom="<%=Helper.correctNull((String)hshValues.get("reqpagefrom"))%>";
var varUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
var varOrgLevel="<%=strOrgLevel%>";
function callSearch()
{
	callack();
	var cbsid=document.forms[0].txt_ackname.value;
	var hidCBSid=document.forms[0].hidCBSid.value;
	if(cbsid!="")
	{
		if ((document.forms[0].radiobutton[1].checked) && (cbsid!=hidCBSid))
		{
			alert('Customer ID differs');
			document.forms[0].txt_ackname.value="";
			document.forms[0].txt_ackname.focus();
			return;
		}
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanMethod.value="getInwardnoSearchList";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].action=appURL+"action/searchAppinwradno.jsp";	
	document.forms[0].submit();
}

function callReset()
{
	document.forms[0].txt_ackname.value==""
}

function callonLoad()
{
	if(strCbschk=="N")
	{
		alert('Customer ID differs with LAR customer id');
		return false;
	}
	if(strSecchk=="N")
	{
		alert('This Application does not belongs to this sector');
		return false;
	}

	if(strDocrecv=="N" && varOrgLevel=="A")
	{
		alert('Application does not received with all required documents');
		return false;
	}		
}

function setCustVal(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12)
{
   
		window.opener.document.forms[0].txt_inwardrefno.value = val0;
		
     	window.opener.document.forms[0].txt_inwarddate.value = val1;
     	
     	window.opener.document.forms[0].sel_type.value = val11;
     	
     	window.opener.document.forms[0].txt_solid.value = val3;
     	
    	window.opener.document.forms[0].txt_BranchName.value = val4;
    	
     	window.opener.document.forms[0].txt_RegionName.value = val5;
     	
    	window.opener.document.forms[0].txt_custid.value = val6;
    	
    	window.opener.document.forms[0].txt_BorrowerName.value = val7;
    	
    	window.opener.document.forms[0].txt_proposedfblimit.value="";
    	window.opener.document.forms[0].txt_proposednfblimit.value="";
    	window.opener.document.forms[0].txt_totalexposure.value="";
    	window.opener.document.forms[0].sel_exposurebracket.value="0";
    	window.opener.document.forms[0].sel_proposedhandledat.value="0";
    	window.opener.document.forms[0].txt_loanprocessofficername.value="";
    	window.opener.document.forms[0].sel_proposalstatus.value="0";  
    	
    	window.opener.document.forms[0].txt_TAT.value= val12;
    	window.opener.document.forms[0].txt_remarks.value="";
    	window.opener.document.forms[0].sel_proposal.value="0";
    	window.opener.document.forms[0].txt_duedatewc.value="";
    	window.opener.document.forms[0].sel_sanctioningauth.value="0";
    	window.opener.document.forms[0].txt_sanctionrefno.value="";
    	window.opener.document.forms[0].txt_sanctiondate.value="";
    	window.opener.document.forms[0].txt_lodgerefno.value="";
    	window.opener.document.forms[0].txt_lodgedate.value="";
    	window.opener.document.forms[0].txt_droppedrefno.value="";
    	window.opener.document.forms[0].txt_droppeddate.value="";
    	window.opener.document.forms[0].txt_deferreddetails.value="";
    	window.opener.document.forms[0].txt_deferreddate.value="";
    	window.opener.document.forms[0].activity_flagin_proposal.value="Y";
    	
    	
    	window.opener.disableControls(true,false,false);
    	
    	window.opener.callDisable(false);
    	window.opener.document.forms[0].hidAction.value="Insert";
		
	
		
    	window.opener.document.forms[0].txt_inwardrefno.readOnly=true;
    	window.opener.document.forms[0].txt_inwarddate.readOnly=true;
    	window.opener.document.forms[0].sel_type.readOnly=true;
    	window.opener.document.forms[0].txt_solid.readOnly=true;
    	window.opener.document.forms[0].txt_BranchName.readOnly=true;
    	window.opener.document.forms[0].txt_RegionName.readOnly=true;
    	window.opener.document.forms[0].txt_custid.readOnly=true;
    	window.opener.document.forms[0].txt_BorrowerName.readOnly=true;
    	window.opener.document.forms[0].txt_duedatewc.readOnly=true;
    	window.opener.document.forms[0].txt_droppeddate.readOnly=true;
    	window.opener.document.forms[0].txt_sanctiondate.readOnly=true;
    	window.opener.document.forms[0].txt_deferreddate.readOnly=true;
    	window.opener.document.forms[0].txt_lodgedate.readOnly=true;
    	window.opener.document.forms[0].txt_loanprocessofficername.readOnly=true;
    	window.opener.document.forms[0].txt_TAT.readOnly=true;
    	
    	
    	window.opener.funchkforstatus();
    	window.opener.document.forms[0].sel_exposurebracket.disabled=true;
    	window.opener.document.forms[0].hidAction.value="Insert";
    	
     	window.close();
    
}
function onRadioClick(){
	document.forms[0].txt_ackname.value="";
	document.forms[0].txt_ackname.readOnly=false;
	document.forms[0].txt_ackname.focus();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Application Number Search</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="98%" border="1" cellpadding="3" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<!--<tr>
						<td width="5%"><input type="radio" name="radiobutton"
													value="inward" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td width="20%">Application No.</td>

						<td width="5%"><input type="radio" name="radiobutton"
													value="cbscustid" style="border-style:none"
													tabindex="2" onClick="onRadioClick()" checked="checked"></td>
												<td width="20%">CBS Customer ID</td>
												
												<td width="5%"><input type="radio" name="radiobutton"
													value="name" style="border-style:none"
													onClick="onRadioClick()" tabindex="3"></td>
												<td width="20%">Name</td>
						<td width="25%" align="center"><input type="text"
							name="txt_ackname" size="25" maxlength="400" value=""
							onKeyPress="notAllowSplChar();"></td>
						<td width="25%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()">
						</td>  -->
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="3">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">

					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="outertable">
						<tr>
							<td valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader">
									<td width="10%">Slno</td>
									<td width="25%">Inward Ref No</td>
									<td width="25%">Inward Date</td>
									<td width="40%">Name</td>
									
								</tr>
								<%
									if (arrValues != null) {
										int arrSize = arrValues.size();
										ArrayList arrCol = null;
										for (int i = 0; i < arrSize; i++) {
											arrCol = new ArrayList();
											if (arrCol != null) {
												arrCol = (ArrayList) arrValues.get(i);
										%>
								
								<tr class="datagrid">
									<td width="10%"><%=i + 1%></td>
									<td width="25%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
									<td width="25%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
									<td width="40%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>')"><%=Helper.correctNull((String) arrCol.get(7))%></a></td>
								</tr>
								<%
									}
										}

									}
								%>
							</table>
							</div>
							<table width="0%" border="0" cellspacing="0" cellpadding="3"
								align="center" class="outertable">
								<tr valign="top">
									<td width="20%" align="center"><input type="button"
										class="buttonClose" value="Close" name="closebtn" tabindex="25"
										onClick="window.close()"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
				<!-- end -->
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidBeanMethod" value="getInwardnoSearchList">
<input type="hidden" name="hidBeanId" value="inwardRegister"> <input
	type="hidden" name="hidBeanGetMethod" value="getInwardnoSearchList">
<input type="hidden" name="Category"
	value="<%=Helper.correctNull((String) request
							.getParameter("Category"))%>">
<input type="hidden" name="Cusprofile" value="<%=Helper.correctNull((String)hshValues.get("Cusprofile"))%>">
<input type="hidden" name="proposal"
	value="<%=Helper.correctNull((String) request
							.getParameter("proposal"))%>">
							
<input type="hidden" name="rdovalue" value="">	
<input type="hidden" name="reqpagefrom" value="<%=Helper.correctNull((String)hshValues.get("reqpagefrom"))%>">	
<br>
</form>
</body>
</html>
