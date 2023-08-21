<%@ include file="../share/directives.jsp"%>

<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>


<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var varstrsel_poultry="<%=Helper.correctNull((String)hshValues.get("strsel_poultry"))%>";
function onload()
{
	disablefields(true);
	document.forms[0].sel_poultry.value=varstrsel_poultry;
	
}
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getCorpMasterList";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].action=appURL+"action/Typepoultrymasters.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	 var cattype=document.forms[0].cattype.value;
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="STL"))
    {
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appUrl+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}

function doEdit()
{
	
	enableButtons(true,false,false,true);
	disablefields(false);
	
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateTypepoultrymastersdata";
	document.forms[0].hidBeanGetMethod.value="getTypepoultrymastersdata";
	document.forms[0].hidSourceUrl.value="/action/Typepoultrymasters.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function funchange()
{
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getTypepoultrymastersdata";
	document.forms[0].hidSourceUrl.value="/action/Typepoultrymasters.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload=" onload();" >
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Corp Loan Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="15" />
		</jsp:include></td>
	</tr>
</table>

<br>
<table width="45%" border="0" cellspacing="1" cellpadding="5"  class="outertable border1 tableBg" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="1" cellpadding="5"  class="outertable" align="center">
<tr>
<td>Type of Poultry </td>
<td> <select name="sel_poultry" onchange="funchange()">
<option value="">---Select---</option>
<option value="1">Hatcheries</option>
<option value="2">Layers(1+1+5)</option>
<option value="4">Layers(1+1+3)</option>
<option value="3">Broiler</option>
</select>
</td>
</tr>

			<tr>
				<td   class="dataheader" colspan="2">Feeding Expenses</td>
			</tr>
			<tr>
				<td width="20%" align="center" class="dataheader">Type of feed</td>
				<td width="26%" align="center" class="dataheader"  >Cost of Consumption of feed/bird</td>
			</tr>
			<tr >
				<td>Starter Mash</td>
				<td   ><lapschoice:CurrencyTag name="txt_Starter"  size="20%" maxlength="12"  onBlur="roundtxt(this);" value='<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("poultry_Startermash")))%>'/></td>
			</tr>
			
			<tr >
				<td >Grower Mash/ Finisher Feed</td>
				<td   ><lapschoice:CurrencyTag name="txt_Grower" size="20%" maxlength="6" onBlur="roundtxt(this);" value='<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("poultry_Growermash")))%>'/></td>
			</tr>
			
			
			<tr >
				<td >Finisher Mash</td>
				<td   ><lapschoice:CurrencyTag name="txt_FinisherMash"  size="20%" maxlength="6" onBlur="roundtxt(this);" value='<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("poultry_Finishermash")))%>'/></td>
			</tr>
			
			<tr >
				<td >% of Mortality</td>
				<td><lapschoice:CurrencyTag  name="txt_Mortality" size="20%" maxlength="12"  onBlur="checkPercentage(this);roundtxt(this);" value='<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("poultry_Mortality")))%>'/></td>
			</tr>
			<!--<tr >
				<td  align="center"><b>Total</b></td>
				<td ><lapschoice:CurrencyTag name="txt_totalfeedcost"
					value="" size="20%" maxlength="6" /></td>
			</tr>
			
			
			<tr >
				<td >Finisher Mash</td>
				<td   ><lapschoice:CurrencyTag name="txt_totalgrowermash" value="" size="20%" maxlength="6" /></td>
			</tr>
		--></table>
</td>
</tr>
</table>

<br>


<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_CODE"))%>">
<input type="hidden" name="hidseqno"
	value="<%=Helper.correctNull((String) hshValues
									.get("lawyer_seqno"))%>">
<input type="hidden" name="hidmastid"/>
									
<lapschoice:hiddentag pageid="<%=PageId%>" />
 <input type="hidden" name="hidzip">
  <table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames="Edit_Save_Cancel"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>