<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Economic Data</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var selsurveydept = "<%=Helper.correctNull((String)hshValues.get("sel_surveydept"))%>";
var selclearence = "<%=Helper.correctNull((String)hshValues.get("sel_clearence"))%>";
var selelectricity = "<%=Helper.correctNull((String)hshValues.get("sel_electricity"))%>";
var selcropping = "<%=Helper.correctNull((String)hshValues.get("sel_cropping"))%>";
var selirrigation = "<%=Helper.correctNull((String)hshValues.get("sel_irrigation"))%>";
var selproject = "<%=Helper.correctNull((String)hshValues.get("sel_project"))%>";
var selwaterpropose = "<%=Helper.correctNull((String)hshValues.get("sel_waterPropose"))%>";
var selpumpshed = "<%=Helper.correctNull((String)hshValues.get("sel_pumpshed"))%>";
var selnetamt = "<%=Helper.correctNull((String)hshValues.get("sel_netamt"))%>";
var agr_electricitydoc = "<%=Helper.correctNull((String)hshValues.get("agr_electricitydoc"))%>";
var agr_wellmaintained = "<%=Helper.correctNull((String)hshValues.get("agr_wellmaintained"))%>";
</script>

<script>

function callLoad()
{	
	if(selsurveydept!="")
		{
		document.forms[0].sel_surveydept.value=selsurveydept;
		}
	else
		{
		document.forms[0].sel_surveydept.value="0";
		}
	if(selclearence!="")
		{
		document.forms[0].sel_clearence.value=selclearence;
		}
	else
		{
		document.forms[0].sel_clearence.value="0";
		}
	if(selelectricity!="")
		{
		document.forms[0].sel_electricity.value=selelectricity;
		}
	else
		{
		document.forms[0].sel_electricity.value="0";
		}
	if(selcropping!="")
	{
		document.forms[0].sel_cropping.value=selcropping;
	}
	if(selirrigation!="")
	{
		document.forms[0].sel_irrigation.value=selirrigation;
	}
	if(selproject!="")
	{
		document.forms[0].sel_project.value=selproject;
	}
	if(selwaterpropose!="")
	{
		document.forms[0].sel_waterPropose.value=selwaterpropose;
	}
	/*if(selpumpshed!="")
	{
		document.forms[0].sel_pumpshed.value=selpumpshed;
	}*/
	if(selnetamt!="")
	{
		document.forms[0].sel_netamt.value=selnetamt;
		if(selnetamt=="1")
		{
			document.all.rNet1.style.visibility="visible";
			document.all.rNet2.style.visibility="visible";
			document.all.rNet3.style.visibility="visible";
			document.all.rNet4.style.visibility="visible";
		}
		else if(selnetamt=="2")
		{
			document.all.rNet1.style.visibility="hidden";
			document.all.rNet2.style.visibility="hidden";
			document.all.rNet3.style.visibility="hidden";
			document.all.rNet4.style.visibility="hidden";
		}
	}
	if(agr_electricitydoc!="")
		{
		document.forms[0].sel_document.value=agr_electricitydoc;
		}
	else
		{
		document.forms[0].sel_document.value="0";
		}
	if(agr_wellmaintained!="")
		{
		document.forms[0].sel_tube.value=agr_wellmaintained;
		}
	else
		{
		document.forms[0].sel_tube.value="0";
		}
	onchangeFCGW();
	onchangeCCSR();
	onchangeFCEB();
	onchangeCPF();
	onchangeWSI();
	onchangePR();
	onchangeWTS();
	onchangeCPS();
	onchangeTube();
	disablefields(true);
}

function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doEdit()
{
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
	enableButtons( true, false, false, false);	
}

function doSave()
{	
	if(document.forms[0].txt_sourcewater.value=="")
	{
	alert("Enter Source of Water");
	document.forms[0].txt_sourcewater.focus();
	return;
	}  
	if(document.forms[0].sel_surveydept.value=="0")
	{
	alert("Select Ground Water Survey Department Certificate");
	document.forms[0].sel_surveydept.focus();
	return;
	} 
    if(document.forms[0].sel_electricity.value=="0")
	{
	alert("Select Electricity Connection");
	document.forms[0].sel_electricity.focus();
	return;
	}  
	if(document.forms[0].sel_tube.value=="1")
	{
		if(document.forms[0].txt_wellDistance.value=="")
		{
		alert("Enter Distance Between Two Well");
		document.forms[0].txt_wellDistance.focus();
		return;
		}
	} 
	
	var len = document.forms[0].sel_netamt.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_netamt.options[i].selected==true)
		 {
			 document.forms[0].sel_netamt_text.value = document.forms[0].sel_netamt.options[i].text; 
			break;
		 }
	}
	enableButtons(true, true, false, true);
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidBeanMethod.value="updatefarmMechMinorIrrig";
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidSourceUrl.value="/action/agr_farmmechMinorIrrig.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].hidAction.value="cancel";
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].action=appURL+"action/agr_farmmechMinorIrrig.jsp";
	document.forms[0].submit();
	}
}
function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatefarmMechMinorIrrig";
		document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_farmmechMinorIrrig.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=one;
	 	}
	}
}

function onchangeFCGW()
{
	if(document.forms[0].sel_surveydept.value=="2")
	{
		document.all.FCGW1.style.visibility="visible";
		document.all.FCGW2.style.visibility="visible";
	}
	else
	{
		document.all.FCGW1.style.visibility="hidden";
		document.all.FCGW2.style.visibility="hidden";
	}
}

function onchangeFCEB()
{
	if(document.forms[0].sel_electricity.value=="1")
	{
		document.all.FCEB1.style.visibility="visible";
		document.all.FCEB2.style.visibility="visible";
	}
	else
	{
		document.all.FCEB1.style.visibility="hidden";
		document.all.FCEB2.style.visibility="hidden";
	}
}

function onchangeCCSR()
{
	if(document.forms[0].sel_clearence.value=="2")
	{
		document.all.CCSR1.style.visibility="visible";
		document.all.CCSR2.style.visibility="visible";
	}
	else
	{
		document.all.CCSR1.style.visibility="hidden";
		document.all.CCSR2.style.visibility="hidden";
	}
}

function onchangeCPF()
{
	if(document.forms[0].sel_cropping.value=="2")
	{
		document.all.CPF1.style.visibility="visible";
		document.all.CPF2.style.visibility="visible";
	}
	else
	{
		document.all.CPF1.style.visibility="hidden";
		document.all.CPF2.style.visibility="hidden";
	}
}

function onchangeWTS()
{
	if(document.forms[0].sel_waterPropose.value=="1")
	{
		document.all.WTS1.style.visibility="visible";
		document.all.WTS2.style.visibility="visible";
	}
	else
	{
		document.all.WTS1.style.visibility="hidden";
		document.all.WTS2.style.visibility="hidden";
		document.forms[0].txt_waterProposeInc.value="";
	}
}

function onchangeWSI()
{
	if(document.forms[0].sel_irrigation.value=="2")
	{
		document.all.WSI1.style.visibility="visible";
		document.all.WSI2.style.visibility="visible";
	}
	else
	{
		document.all.WSI1.style.visibility="hidden";
		document.all.WSI2.style.visibility="hidden";
	}
}

function onchangePR()
{
	if(document.forms[0].sel_project.value=="2")
	{
		document.all.PR1.style.visibility="visible";
		document.all.PR2.style.visibility="visible";
	}
	else
	{
		document.all.PR1.style.visibility="hidden";
		document.all.PR2.style.visibility="hidden";
	}
}	

function netamtmeth()
{
	if(document.forms[0].sel_netamt.value=="1")
	{
		document.all.rNet1.style.visibility="visible";
		document.all.rNet2.style.visibility="visible";
		document.all.rNet3.style.visibility="visible";
		document.all.rNet4.style.visibility="visible";
		
		
	}
	else if(document.forms[0].sel_netamt.value=="2")
	{
		document.all.rNet1.style.visibility="hidden";
		document.all.rNet2.style.visibility="hidden";
		document.all.rNet3.style.visibility="hidden";
		document.all.rNet4.style.visibility="hidden";
		document.forms[0].txt_netamtsource.value="";
		document.forms[0].txt_netamount.value="";
	}
}

function onchangeCPS()
{
	/*if(document.forms[0].sel_pumpshed.value=="2")
	{
		document.all.CPS1.style.visibility="visible";
		document.all.CPS2.style.visibility="visible";
		document.all.CPS3.style.visibility="visible";
		document.all.CPS4.style.visibility="visible";
	}
	else 
	{
		document.all.CPS1.style.visibility="hidden";
		document.all.CPS2.style.visibility="hidden";
		document.all.CPS3.style.visibility="hidden";
		document.all.CPS4.style.visibility="hidden";       
	}*/
}
function onchangeTube()
{
	if(document.forms[0].sel_tube.value=="1")
	{
		document.all.tube.style.visibility="visible";
		document.all.tube1.style.visibility="visible";
	}
	else
	{
		document.all.tube.style.visibility="hidden";
		document.all.tube1.style.visibility="hidden";
		document.forms[0].txt_wellDistance.value="";
	}
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callLoad()">
<form class="normal" name="frmpri" method="post">
<table class="outertable border1" width="100%" border="0" cellpadding="3" cellspacing="0"
	>
	<tr>
		<td>
		<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"
			>
			<tr>
				<td width="40%" rowspan="2" >
				Location of the proposed well/well to be
				fitted with proposed I.P/SIP Set / Details of the land which is
				proposed to be reclaimed or bunded.</td>
				<td align="center" width="20%">Survey
				No </td>
				<td align="center" width="20%">Extent(acres)</td>
				<td align="center" width="20%">Ownership</td>
			</tr>
			<tr>
				<td align="center" width="20%"><input type="text"
					name="txt_wellSurveyNo" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_wellSurveyNo"))%>"
					onKeyPress="" maxlength="9"></td>
				<td align="center" width="20%"><input type="text"
					name="txt_wellExtent" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_wellExtent"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="9"></td>
				<td align="center" width="20%"><input type="text"
					name="txt_wellOwner" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_wellOwner"))%>"
					onKeyPress="notAllowSplChar()" maxlength="15"></td>
			</tr>
			<tr>
				<td width="40%" rowspan="2">If
				Pond, dimension </td>
				<td align="center" width="20%">Length
				(feet) </td>
				<td align="center" width="20%">Breadth
				(feet)</td>
				<td align="center" width="20%">
				Depth (feet) </td>
			</tr>
			<tr>
				<td align="center" width="20%"><input type="text"
					name="txt_pondLength" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_pondLength"))%>"
					onkeypress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
				<td align="center" width="20%"><input type="text"
					name="txt_pondBreadth" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_pondBreadth"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
				<td align="center" width="20%"><input type="text"
					name="txt_pondHeight" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_pondHeight"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
			</tr>
			<tr>
				<td width="40%" rowspan="2">Size
				of Proposed Well</td>
				<td align="center" width="20%">Depth(feet)</td>
				<td align="center" width="20%">Diameter/Surface</td>
				<td align="left" width="20%">&nbsp;</td>
			</tr>
			<tr>
				<td align="center" width="20%"><input type="text"
					name="txt_boreHeight" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_boreHeight"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
				<td align="center" width="20%">
				<input type="text" name="txt_boreDiameter" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_boreDiameter"))%>"
					onKeyPress="allowDecimals(this)" maxlength="5"> </td>
				<td align="left" width="20%">&nbsp;</td>
			</tr>
		</table>
		<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3">
			<tr>
				<td width="40%">Source of Water<b><span class="mantatory">*</span></b></td>
				<td align="left" width="20%"><input type="text"
					name="txt_sourcewater" size="30"
					value="<%=Helper.correctNull((String)hshValues.get("agr_sourcewater"))%>"
					onKeyPress="notAllowSplChar()" maxlength="50"></td>
				<td width="20%">Type of Proposed
				Well </td>
				<td align="left" width="20%"> <input
					type="text" name="txt_proposedwell" size="25"
					value="<%=Helper.correctNull((String)hshValues.get("agr_proposedwell"))%>"
					maxlength="50"> </td>
			</tr>
			<tr>
				<td width="40%">Time required
				for complete the project </td>
				<td width="20%"> <input
					type="text" name="txt_projectTime" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_projectTime"))%>"
					onKeyPress="allowDecimal(this)" style="text-align:right" maxlength="15" onblur="roundtxt(this)"> </td>
				<td width="20%">Depth of water
				level in summer (feet)</td>
				<td width="20%"><input type="text" name="txt_summerlevel" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_summerlevel"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right" onblur="roundtxt(this)"
					maxlength="9"></td>
			</tr>
			<tr>
				<td width="40%" ROWSPAN="3">What
				is the arrangement for lifting the Water from the Well</td>
				<td width="20%" ROWSPAN="3"><input type="text"
					name="txt_arrangeofwater" size="30"
					value="<%=Helper.correctNull((String)hshValues.get("agr_arragewater"))%>"
					onKeyPress="notAllowSplChar()" maxlength="50"></td>
				<td width="20%">Area to be
				benefitted in acres </td>
				<td width="20%"> <input
					type="text" name="txt_totIrrigation" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("agr_totIrrigation"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right" onblur="roundtxt(this)"
					maxlength="9"> </td>
			</tr>
			<tr>
				<td width="20%">Size of Boring pipe(diameter)</td>
				<td width="20%"><input type="text" name="txt_boring" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("borindsiz"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
			</tr>
			<tr>
				<td width="20%">Size of Delivery Pipe(diameter)</td>
				<td width="20%"><input type="text" name="txt_delivery" size="15"
					value="<%=Helper.correctNull((String)hshValues.get("delivesiz"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"></td>
			</tr>
			<tr>
				<td width="40%">Feasibility
				Certificate obtained from Ground Water Survey Department<b><span class="mantatory">*</span></b></td>
				<td width="20%"> <select
					name="sel_surveydept" onChange="onchangeFCGW()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="FCGW1">Reason</td>
				<td width="20%" id="FCGW2"><textarea name="txt_surveydeptRsn"
					rows="2" cols="20" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("agr_surveydeptRsn"))%></textarea></td>
			</tr>
			<tr>
				<td width="40%">Clearance
				certificate from stream / River development</td>
				<td width="20%"> <select
					name="sel_clearence" onChange="onchangeCCSR()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="CCSR1">Reason</td>
				<td width="20%" id="CCSR2"><textarea name="txt_clearenceRsn"
					rows="2" cols="20" onKeyPress="textlimit(this,399)"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("agr_clearenceRsn"))%></textarea></td>
			</tr>
			<tr>
				<td width="40%">Whether
				Electricity Board agree to give the electricity Connection<b><span class="mantatory">*</span></b></td>
				<td width="20%"> <select
					name="sel_electricity" onChange="onchangeFCEB()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="FCEB1" align="left">Documents enclosed </td>
				<td width="20%" id="FCEB2"> <select
					name="sel_document">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
			</tr>
			<tr>
				<td width="40%">Whether cropping
				pattern propose after development is feasible with reference water
				availability</td>
				<td width="20%"> <select
					name="sel_cropping" onChange="onchangeCPF()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="CPF1">Reason</td>
				<td width="20%" id="CPF2"><textarea name="txt_croppingRsn" rows="2"
					cols="20" onKeyPress="textlimit(this,399)"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("agr_croppingRsn"))%></textarea></td>
			</tr>
			<tr>
				<td width="40%">Whether the
				water is suitable for irrigation </td>
				<td width="20%"> <select
					name="sel_irrigation" onChange="onchangeWSI()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="WSI1">Reason
				</td>
				<td width="20%" id="WSI2"><textarea name="txt_irrigationRsn"
					rows="2" cols="20" onKeyPress="textlimit(this,399)"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("agr_irrigationRsn"))%></textarea></td>
			</tr>
			<tr>
				<td align="left" width="40%">Whether
				project report obtained from competent engineer/dealer</td>
				<td width="20%"> <select
					name="sel_project" onChange="onchangePR()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="PR1">Reason</td>
				<td width="20%" id="PR2"> <textarea
					name="txt_projectRsn" rows="2" cols="20"
					onKeyPress="textlimit(this,399)"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("agr_projectRsn"))%></textarea> </td>
			</tr>
			<tr>
				<td width="40%">Whether HP of
				I.P. set &amp; length of the pipe are sufficiant /suitable with
				reference to the availability of water &amp; depth of the well
				&nbsp; </td>
				<td align="left" colspan="3"> <textarea
					name="txt_HP" rows="2" cols="40" onKeyPress="textlimit(this,399)"  onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
									.get("agr_HP"))%></textarea> </td>
			</tr>
			<tr>
				<td width="40%">Whether Spacing
				norms between Two Wells,Tube Wells is Maintained?</td>
				<td align="left" width="20%"> <select
					name="sel_tube" onChange="onchangeTube()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
			</tr>
			<tr>
				<td width="40%" id="tube">Distance
				of the proposed well / Bore well to the nearest Well / Bore Well
				(feet) <b><span class="mantatory">*</span></b></td>
				<td align="left" width="20%" id="tube1">
				 <input type="text" name="txt_wellDistance"
					size="12"
					value="<%=Helper.correctNull((String)hshValues.get("agr_wellDistance"))%>"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					maxlength="5"> </td>
				<td width="20%">&nbsp;</td>
				<td width="20%"> </td>
			</tr>
			
			<tr>
				<td colspan="4"><b>Income and
				Expenses </b></td>
			</tr>
			<tr>
				<td width="40%">Whether water is
				proposed to the sold </td>
				<td align="left" width="20%"> <select
					name="sel_waterPropose" onChange="onchangeWTS()">
					<option value="0" selected>select</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select> </td>
				<td width="20%" id="WTS1">Income/Year
				<b><%=ApplicationParams.getCurrency()%></b></td>
				<td width="20%" id="WTS2"><lapschoice:CurrencyTag
					name="txt_waterProposeInc" size="15"
					value='<%=Helper.correctNull((String)hshValues.get("agr_waterProposeInc"))%>'
					maxlength="9" /></td>
			</tr>
			<%-- <tr> 
            <td width="40%" >Arrangement for 
              construction of Pumpshed</td>
            <td colspan="3" > 
              <select name="sel_pumpshed" onChange="onchangeCPS()">
                <option value="0" selected>select</option>
                <option value="1">Own</option>
                <option value="2" selected>Loan Requested</option>
              </select>
               </td>
          </tr>
          <tr> 
            <td id="CPS1">Area of Shed (Sq.ft)</td>
            <td width="12%" id="CPS2"> 
              <input type="text" name="txt_pumpshedArea" size="15"
			value="<%=Helper.correctNull((String)hshValues.get("agr_pumpshedArea"))%>"
			onKeyPress="allowDecimals(this)" style="text-align:right"  maxlength="9">
            </td>
            <td width="9%" id="CPS3">Amount 
              <b><%=ApplicationParams.getCurrency()%></b></td>
            <td width="9%" id="CPS4"> 
              <input type="text" name="txt_pumpshedAmt" size="15"
			value="<%=Helper.correctNull((String)hshValues.get("agr_pumpshedAmt"))%>"
			onKeyPress="allowDecimals(this)" style="text-align:right" maxlength="9">
            </td>
          </tr>--%>
			<tr>
				<td width="40%">Net Income from
				other sources </td>
				<td width="20%"> <select
					name="sel_netamt" onChange="netamtmeth()">
					<option value="1" selected>Available</option>
					<option value="2">Not Available</option>
				</select> </td>
				<td width="20%">Expected Additional Income after proposed Land
				Development</td>
				<td width="20%"><lapschoice:CurrencyTag
					name="txt_exp_additional_income" size="15"
					value='<%=Helper.correctNull((String)hshValues.get("agr_expect_addition"))%>'
					maxlength="9" /></td>
			</tr>
			<tr>
				<td id="rNet1">Specify Sources</td>
				<td id="rNet2"> <input
					type="text" name="txt_netamtsource"
					value="<%=Helper.correctNull((String)hshValues.get("agr_netamtsource"))%>"
					size="15" maxlength="25" onKeyPress="" onBlur=""
					style="text-align:left"> </td>
				<td width="9%" id="rNet3">Amount/Year
				<b><%=ApplicationParams.getCurrency()%></b></td>
				<td width="9%" id="rNet4"> <lapschoice:CurrencyTag
					name="txt_netamount"
					value='<%=Helper.correctNull((String)hshValues.get("agr_netamount"))%>'
					size="12" maxlength="9" onBlur="" /> </td>
			</tr>
			<tr>
				<td width="40%">Electricity/diesel
				expenses/Annum <b><%=ApplicationParams.getCurrency()%></b></td>
				<td width="20"><lapschoice:CurrencyTag name="txt_elecWorks"
					size="15"
					value='<%=Helper.correctNull((String)hshValues.get("agr_elecWorks"))%>'
					maxlength="9" /></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4"> <b>Cost of
				Electricity Connection </b> </td>
			</tr>
			<tr>
				<td width="40%">For drawing
				power lines to Farm <b><%=ApplicationParams.getCurrency()%></b></td>
				<td align="left" width="20%"><lapschoice:CurrencyTag
					name="txt_elecDrawing" size="15"
					value='<%=Helper.correctNull((String)hshValues.get("agr_elecDrawing"))%>'
					maxlength="9" /></td>
				<td width="20%">Deposit to the
				Power Supplier&nbsp;<b><%=ApplicationParams.getCurrency()%></b></td>
				<td width="20%"> <lapschoice:CurrencyTag
					name="txt_elecDeposit" size="15"
					value='<%=Helper.correctNull((String)hshValues.get("agr_elecDeposit"))%>'
					maxlength="9" /> </td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew  btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hid_ownfield" value=""> 
<input type="hidden" name="sel_netamt_text" value="">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
	</form>

</body>
</html>
