<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrValues = new ArrayList(); 

	if (hshValues != null) {
		arrValues = (ArrayList) hshValues.get("arrCust");
	}
	String strCategory = Helper.correctNull((String)hshValues.get("Category"));
	String strreqpagefrom = Helper.correctNull((String)hshValues.get("reqpagefrom"));
	String strCusprofile = Helper.correctNull((String)hshValues.get("Cusprofile"));
	if(strCategory.equalsIgnoreCase("")){
		strCategory =  Helper.correctNull((String)request.getParameter("Category"));
	}
	String strCbs = Helper.correctNull((String)request.getParameter("CBSid"));
	if(strCbs.equalsIgnoreCase(""))
	{
		strCbs = Helper.correctNull((String)hshValues.get("strCBSid"));
	}
	//out.println(hshValues);
		
%>

<html>
<head>
<title>Acknowledgement Number Search</title>
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
	
function callack()
{
	if(document.forms[0].radiobutton[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].radiobutton[1].checked)
	{
		cat=2;
	}
	else if (document.forms[0].radiobutton[2].checked)
	{
		cat=3;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	for(var k=0;k<2;k++)
	{
		if(document.forms[0].radiobutton[k].checked==true) 
		{
			if(trim(document.forms[0].txt_ackname.value) == "") 
			{
				ShowAlert(121,'Search Criteria');
				document.forms[0].txt_ackname.focus();
				return;
			}
		}	
	}
	
   	var txtval=document.forms[0].txt_ackname.value;

	var txtlen=txtval.length;

	if(txtlen<=2) {
		 alert("Enter atleast 3 characters");
	     document.forms[0].txt_ackname.focus();
	     return;
	}
	
	var rdovalue="";
	if(document.forms[0].radiobutton[0].checked == true && txtval == "")
	{
	ShowAlert('121','Customer Name');
	return false;
	}
	if(document.forms[0].radiobutton[1].checked == true && txtval == "")
	{
	ShowAlert('121','CBS Custemer ID');
	return false;
	}
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
	if(document.forms[0].radiobutton[i].checked==true) {
		
		document.forms[0].rdovalue.value = document.forms[0].radiobutton[i].value;
		}
	}
}



function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function setValues(value1, value2,value3,value4,value5,value6,value7,value8,value9,value10,value11,value12,value13,value14,value16)
{
	
	if(value2=="Y" && varOrgLevel=="D" && value14=="" && varUser!="012")
	{
		alert("Date Receipt of Physical loan papers at CLPU is Incomplete in LAR, Please Revisit the LAR & Proceed further.");
		return;
	}
	else if(value2=="Y" && varOrgLevel=="D" && value14!="" && <%=strCategory%> == "p")
	{
		window.opener.document.forms[0].txt_receiptclpu.value=value14;
	}
	if(<%=strCategory%> == "p")
	{
		if(value12=="Y" && (window.opener.document.forms[0].prd_type.value!="") && (window.opener.document.forms[0].prd_type.value!="pE"))
		{
			if(confirm("This LAR belongs to NSDL Vidhyalakshmi Loan Request,Applicable only for Education Loan Schemes. If you wish to proceed Loan particulars entries will be deleted. Do you want to Continue?"))
			{
				window.opener.document.forms[0].selectinttype.value="0";
				window.opener.document.forms[0].txtloan_intrate.value="";
				window.opener.document.forms[0].txtprd_desc.value="";
				window.opener.document.forms[0].txtloan_amtreqd.value="";
				window.opener.document.forms[0].txtloan_reqterms.value="";
				window.opener.document.forms[0].txtloan_modintrate.value="";
				window.opener.document.forms[0].txt_installments.value="0";
				window.opener.document.forms[0].txt_repaycapacity.value="";
				window.opener.document.forms[0].txtloan_downpay.value="";
				window.opener.document.forms[0].txtMarginpercent.value="";
				window.opener.document.forms[0].txtmarginoffered.value="";
				window.opener.document.forms[0].txtmonPay.value="";
				window.opener.document.forms[0].txtloan_sancamt.value="";
				window.opener.document.forms[0].txtloan_procfee.value="";
				window.opener.document.forms[0].hidPrdFlag.value="N";
				window.opener.callInterestCharged();
				window.opener.document.forms[0].hidMCLRTableCode.value="";
				window.opener.document.forms[0].hidbusstrategicpremium.value="";
				window.opener.document.forms[0].hidcreditrskpremium.value="";
				window.opener.document.forms[0].hidCRP.value="";
				window.opener.document.forms[0].hidBSP.value="";
				window.opener.document.forms[0].sel_mclrtype.value="";
				window.opener.document.forms[0].selrepaymenttype.selectedIndex=0;
				window.opener.document.forms[0].selmodepayment.selectedIndex=0;
			}
			else
			{
				return;
			}
			
		}
	}
	if(value2=="N")
	{
		if(varOrgLevel=="A")
		{
			alert('Application does not received with all required documents');
			return;
		}
		if(confirm('Necessary Documents not given by the Customer, Do you want to proceed?'))
		{
			window.opener.document.forms[0].txt_appinwardno.value = value1;
			window.opener.document.forms[0].hidinwardAmt.value = value4;
			
			if(<%=strCategory%> == "p") 
			{
				window.opener.document.forms[0].txt_receivedRH.value = value3;
				window.opener.document.forms[0].hidNSDLFlag.value = value12;
				window.opener.document.forms[0].hidNSDLRefNo.value = value13;
				if(value12=="Y")
				{
					window.opener.document.all.idnsdl1.style.visibility = "visible";
					window.opener.document.all.idnsdl1.style.position = "relative";
					window.opener.document.all.idnsdl2.style.visibility = "visible";
					window.opener.document.all.idnsdl2.style.position = "relative";
				}
				else
				{
					window.opener.document.all.idnsdl1.style.visibility = "hidden";
					window.opener.document.all.idnsdl1.style.position = "absolute";
					window.opener.document.all.idnsdl2.style.visibility = "hidden";
					window.opener.document.all.idnsdl2.style.position = "absolute";
				}
			}
			window.opener.document.forms[0].selectgovt.value = value5;
			window.opener.document.forms[0].schemetype.value = value6;
			window.opener.document.forms[0].sel_subsidytype.value = value7;
			window.opener.document.forms[0].txt_agency.value = value8;
			window.opener.document.forms[0].sub.value = value9;
			window.opener.document.forms[0].sel_sponser_agency.value = value10;
			window.opener.document.forms[0].hidLARbankscheme.value = value11;
			window.opener.selsub();
			
			window.close();
		}
	}
	else if(varreqpagefrom == "gate")
	{
		window.opener.document.forms[0].txt_appinwardno.value = value1;
		
		window.close();
	}
	else
	{
		window.opener.document.forms[0].txt_appinwardno.value = value1;
		if(<%=strCategory%> != "p")
		{
		 window.opener.document.forms[0].hidinwarcreateddate.value = value16;
		}
		if(document.forms[0].reqpagefrom.value!="CA")
		window.opener.document.forms[0].hidinwardAmt.value = value4;
		if(<%=strCategory%> == "p")
		{
			window.opener.document.forms[0].txt_receivedRH.value = value3;
			window.opener.document.forms[0].selectgovt.value = value5;
			window.opener.document.forms[0].schemetype.value = value6;
			window.opener.document.forms[0].sel_subsidytype.value = value7;
			window.opener.document.forms[0].sub.value = value9;
			window.opener.document.forms[0].sel_sponser_agency.value = value10;
			if(value10=="OTHERS")
			{
				window.opener.document.forms[0].txt_agency.value = value8;
			}
			window.opener.document.forms[0].hidLARbankscheme.value = value11;
			window.opener.document.forms[0].hidNSDLFlag.value = value12;
			window.opener.document.forms[0].hidNSDLRefNo.value = value13;
			if(value12=="Y")
			{
				window.opener.document.all.idnsdl1.style.visibility = "visible";
				window.opener.document.all.idnsdl1.style.position = "relative";
				window.opener.document.all.idnsdl2.style.visibility = "visible";
				window.opener.document.all.idnsdl2.style.position = "relative";
			}
			else
			{
				window.opener.document.all.idnsdl1.style.visibility = "hidden";
				window.opener.document.all.idnsdl1.style.position = "absolute";
				window.opener.document.all.idnsdl2.style.visibility = "hidden";
				window.opener.document.all.idnsdl2.style.position = "absolute";
			}
			window.opener.selsub();
		}
		window.close();
	}
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

function setCustVal(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
    if(<%=strCategory%> == "c")
    {
        window.opener.document.forms[0].comapp_companyname.value = val1;
        window.opener.document.forms[0].comapp_corpstructure.value = val11;
        window.opener.document.forms[0].comapp_email.value = val9;
        window.opener.document.forms[0].comapp_regadd1.value = val2;
        window.opener.document.forms[0].comapp_regadd2.value = val3;
        window.opener.document.forms[0].comapp_regcity.value = val15;
        window.opener.document.forms[0].comapp_regstate.value = val16;
        window.opener.document.forms[0].comapp_regpin.value = val6;
        window.opener.document.forms[0].comapp_regphone.value = val7;
        window.opener.document.forms[0].hidcity3.value = val4;
        window.opener.document.forms[0].hidstate3.value = val5;
        window.opener.document.forms[0].comapp_yrsinbusiness.value = val10;
        window.close();
	}
	else
	{
		window.opener.document.forms[0].hid_inwardno.value = val0;
     	window.opener.document.forms[0].txtperapp_fname.value = val1;
     	window.opener.document.forms[0].txtperapp_address1.value = val2;
     	window.opener.document.forms[0].txtperapp_address2.value = val3;
    	window.opener.document.forms[0].txtperapp_city.value = val15;
     	window.opener.document.forms[0].txtperapp_state.value = val16;
    	window.opener.document.forms[0].txtperapp_zip.value = val6;
    	window.opener.document.forms[0].txtperapp_phone.value = val7;
     	window.opener.document.forms[0].txtperapp_mobile.value = val8;
     	window.opener.document.forms[0].txtperapp_email.value = val9;
     	window.opener.document.forms[0].txtperapp_dob.value = val10;
     	window.opener.document.forms[0].txtperapp_panno.value = val11;
     	window.opener.document.forms[0].choperapp_sex.value = val14;
     	window.opener.document.forms[0].txtperapp_passport.value = val12;
    	window.opener.document.forms[0].hidcity.value = val4;
    	window.opener.document.forms[0].hidstate.value = val5;
    	
     	window.close();
    }
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
<table width="98%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<tr>
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
						</td>
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="3">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<%if(strCusprofile.equalsIgnoreCase("CUSPROFILE")){%>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="outertable">
						<tr>
							<td valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader">
									<td width="5%">Sno</td>
									<td width="30%">Name</td>
									<td width="20%">Acknowledgement Number </td>
									<td width="45%">Address</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td valign="top" align="center">
							<DIV class="cellContainer">
							<table width="100%" border="0" cellspacing="1" cellpadding="2"
								class="outertable">
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
									<td width="5%"><%=i + 1%></td>
									<td width="30%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>',
																		'<%=Helper.correctNull((String) arrCol.get(12))%>','<%=Helper.correctNull((String) arrCol.get(13))%>',
																		'<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(15))%>',
																		'<%=Helper.correctNull((String) arrCol.get(16))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
									<td width="20%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>',
																		'<%=Helper.correctNull((String) arrCol.get(12))%>','<%=Helper.correctNull((String) arrCol.get(13))%>',
																		'<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(15))%>',
																		'<%=Helper.correctNull((String) arrCol.get(16))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
									<td width="45%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>',
																		'<%=Helper.correctNull((String) arrCol.get(4))%>','<%=Helper.correctNull((String) arrCol.get(5))%>',
																		'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>',
																		'<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.correctNull((String) arrCol.get(9))%>',
																		'<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>',
																		'<%=Helper.correctNull((String) arrCol.get(12))%>','<%=Helper.correctNull((String) arrCol.get(13))%>',
																		'<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(15))%>',
																		'<%=Helper.correctNull((String) arrCol.get(16))%>')"><%=Helper.correctNull((String) arrCol.get(2))%>, <%=Helper.correctNull((String) arrCol.get(3))%></a></td>
								</tr>
								<%
									}
										}

									}
								%>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">

									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
								<tr class="datagrid">
									<td width="5%">&nbsp;</td>
									<td width="30%">&nbsp;</td>
									<td width="20%">&nbsp;</td>
									<td width="45%">&nbsp;</td>
								</tr>
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
					<%}else{
			%>
				<!-- start -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
								<td width="10%">Sno</td>
								<td width="30%">Name</td>
								<td width="30%">Application Number</td>
					 	   <% if(strCategory.equals("'p'")){ %>
								<td width="30%">Bank Scheme</td>
							<% } %>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center">
						<DIV class="cellContainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2"
							class="outertable">
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
								<td width="30%"><a href="#"
									onclick="javascript:setValues('<%=Helper.correctNull((String) arrCol.get(0))%>',
                                            											'<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.correctNull((String) arrCol.get(10))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(16))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
								<td width="30%"><a href="#"
									onclick="javascript:setValues('<%=Helper.correctNull((String) arrCol.get(0))%>',
											                                            '<%=Helper.correctNull((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>'
											                                            ,'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.correctNull((String) arrCol.get(10))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>'
                                            											,'<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(16))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
								<% if(strCategory.equals("'p'")){ %>
								<td width="30%"><%=Helper.correctNull((String) arrCol.get(15))%> </td>
								<% } %>
							</tr>
							<%
								}
									}

								}
							%>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
							<tr class="datagrid">
								<td width="10%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
								<td width="30%">&nbsp;</td>
						 <% if(strCategory.equals("'p'")){ %>		<td width="30%">&nbsp;</td><% } %>
							</tr>
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
				<%} %>
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
<input type="hidden" name="hidCBSid" value="<%=strCbs%>">	
<input type="hidden" name="reqpagefrom" value="<%=Helper.correctNull((String)hshValues.get("reqpagefrom"))%>">	
<br>
</form>
</body>
</html>
