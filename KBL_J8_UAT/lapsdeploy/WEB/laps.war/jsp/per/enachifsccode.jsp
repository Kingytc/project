<%@include file="../share/directives.jsp"%>
<%
   String strBankname=Helper.correctNull((String)hshValues.get("strBankname"));
   String strFINBankname=Helper.correctNull((String)hshValues.get("strFINBankname"));
   String strselmodepayment="0";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>enachifsccode</title>
</head>

<SCRIPT LANGUAGE="JavaScript">
var varBankname="<%=strBankname%>";
var strFINBankname="<%=strFINBankname%>";
var strselmodepayment="<%=strselmodepayment%>";

function loadValues()
{
	if(strFINBankname == "")
	{
		alert("IFSC CODE IS NOT VALID");
		parent.frames.document.forms[0].selmodepayment.value=strselmodepayment;
		hid();
		return false;
	}
	
	if((varBankname!="" && strFINBankname == "") || (varBankname=="" && strFINBankname == ""))
	{
	parent.frames.document.forms[0].sel_ECSBankName.value=varBankname;
	alert("BANK NOT REGISTERED FOR E-NACH");
	parent.frames.document.forms[0].selmodepayment.value=strselmodepayment;
	return false;
	hid();
	}else if(varBankname!="" && strFINBankname != ""){
		parent.frames.document.forms[0].sel_ECSBankName.value=varBankname;
	}	
}

function hid()
{
	parent.frames.document.forms[0].txt_operativeaccno.disabled=true;
	parent.frames.document.all.opnolabel.style.visibility="hidden";
	parent.frames.document.all.opnolabel.style.position="absolute";
	
	parent.frames.document.all.opnovalue.style.visibility="hidden";
	parent.frames.document.all.opnovalue.style.position="absolute";
	
	parent.frames.document.forms[0].sel_ECSBankName.disabled=true;
	parent.frames.document.forms[0].sel_ECSaccnttype.disabled=true;
	parent.frames.document.forms[0].txt_ECSoperaccno.disabled=true;
	parent.frames.document.forms[0].sel_ECSauthmode.disabled=true;
	parent.frames.document.forms[0].txt_ECSifsccode.disabled=true;

	parent.frames.document.forms[0].sel_ECSBankName.value="0";
	parent.frames.document.forms[0].sel_ECSaccnttype.value="0";
	parent.frames.document.forms[0].txt_ECSoperaccno.value="";
	parent.frames.document.forms[0].sel_ECSauthmode.value="0";
	parent.frames.document.forms[0].txt_ECSifsccode.value="";
	
	parent.frames.document.all.ECSopnolabel1.style.visibility="hidden";
	parent.frames.document.all.ECSopnolabel1.style.position="absolute";
	
	parent.frames.document.all.ECSopnovalue1.style.visibility="hidden";
	parent.frames.document.all.ECSopnovalue1.style.position="absolute";
	
	parent.frames.document.all.ECSopnolabel2.style.visibility="hidden";
	parent.frames.document.all.ECSopnolabel2.style.position="absolute";
	
	parent.frames.document.all.ECSopnovalue2.style.visibility="hidden";
	parent.frames.document.all.ECSopnovalue2.style.position="absolute";
	
	parent.frames.document.all.ECSopnolabel3.style.visibility="hidden";
	parent.frames.document.all.ECSopnolabel3.style.position="absolute";
	
	parent.frames.document.all.ECSopnovalue3.style.visibility="hidden";
	parent.frames.document.all.ECSopnovalue3.style.position="absolute";
	
	parent.frames.document.all.ECSopnolabel4.style.visibility="hidden";
	parent.frames.document.all.ECSopnolabel4.style.position="absolute";
	
	parent.frames.document.all.ECSopnovalue4.style.visibility="hidden";
	parent.frames.document.all.ECSopnovalue4.style.position="absolute";
	
	parent.frames.document.all.ECSopnolabel5.style.visibility="hidden";
	parent.frames.document.all.ECSopnolabel5.style.position="absolute";
	
	parent.frames.document.all.ECSopnovalue5.style.visibility="hidden";
	parent.frames.document.all.ECSopnovalue5.style.position="absolute";
}
</script>	
<body onload="loadValues()">
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
					<tr>
						<td width="5%"><input type="radio" name="radiobutton"
													value="inward" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td width="20%">IFSC Code</td>
							<td width="25%" align="center"><input type="text"
							name="txt_ackname" size="25" maxlength="400" value=""
							onKeyPress="notAllowSplChar();"></td>
					</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="outertable">
						<tr>
							<td valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader">
									<td width="10%">Sno</td>
									<td width="65%">Bank Name</td>
									<td width="20%">IFSC code</td>
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
</form>
</body>
</html>