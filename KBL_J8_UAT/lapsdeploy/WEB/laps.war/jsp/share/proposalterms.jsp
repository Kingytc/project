<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Proposal Terms </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">

var appURL="<%=ApplicationParams.getAppUrl()%>";

function callOnload(){

	var selreg = '<%=Helper.correctNull((String)hshValues.get("CON_ROCLREPORT"))%>';
	var selregEM = '<%=Helper.correctNull((String)hshValues.get("CON_EMREG"))%>';
	var chargenote = '<%=Helper.correctNull((String)hshValues.get("CON_CHARGESNOTED"))%>';


	if(selreg!=""){
		document.forms[0].sel_regcharge.value =selreg;
	}
	else{
		document.forms[0].sel_regcharge.value ="S";
	}
	

	if(selregEM!=""){
		document.forms[0].sel_regEM.value =selregEM;
	}
	else{
		document.forms[0].sel_regEM.value ="S";
	}
	

	if(chargenote!=""){
		document.forms[0].sel_chargenoted.value =chargenote;
	}
	else{
		document.forms[0].sel_chargenoted.value ="S";
	}

	
	disableFields(true);
	callReason1();
	callReason2();
}

function callRBI()
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].action=appURL+"action/rbiguidelines.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}	
}

function callInspection()
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getInspection";
		document.forms[0].action=appURL+"action/inspectioncomments.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callCersai()
{
	if(document.forms[0].cmdsave.disabled)
	{	
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getCersaiCibil";
		document.forms[0].action=appURL+"action/cersaicibildetails.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
}

function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}  

function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false,true); 
	document.forms[0].hidAction.value="update";
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getConduct";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].action=appURL+"action/proposalterms.jsp";	
		document.forms[0].submit();
	}
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanMethod.value="updateConduct";
	document.forms[0].hidBeanGetMethod.value="getConduct";
	document.forms[0].hidBeanId.value="proposalterms";
	document.forms[0].hidSourceUrl.value="/action/proposalterms.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateConduct";
	    document.forms[0].hidBeanGetMethod.value="getConduct";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].hidSourceUrl.value="/action/proposalterms.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	}
}

function callReason1()
{
	if(document.forms[0].sel_regcharge.value=="Y" )
	{
		document.all.id1.style.visibility="hidden";
		document.all.id1.style.position="absolute";
		document.all.id2.style.visibility="hidden";
		document.all.id2.style.position="absolute";
		document.all.id12.style.visibility="visible";
		document.all.id12.style.position="relative";
	} 
	else if(document.forms[0].sel_regcharge.value=="N" )
	{
		document.all.id1.style.visibility="visible";
		document.all.id1.style.position="relative";
		document.all.id2.style.visibility="visible";
		document.all.id2.style.position="relative";
		document.all.id12.style.visibility="hidden";
		document.all.id12.style.position="absolute";
	}
	else{
		document.all.id1.style.visibility="hidden";
		document.all.id1.style.position="absolute";
		document.all.id2.style.visibility="hidden";
		document.all.id2.style.position="absolute";
		document.all.id12.style.visibility="hidden";
		document.all.id12.style.position="absolute";
	}
}

function callReason2()
{
	if(document.forms[0].sel_regEM.value=="N" )
	{
		document.all.id3.style.visibility="visible";
		document.all.id3.style.position="relative";
		document.all.id4.style.visibility="visible";
		document.all.id4.style.position="relative";
	} 
	else
	{
		document.all.id3.style.visibility="hidden";
		document.all.id3.style.position="absolute";
		document.all.id4.style.visibility="hidden";
		document.all.id4.style.position="absolute";
	}
	if(document.forms[0].sel_chargenoted.value=="N" )
	{
		document.all.id5.style.visibility="visible";
		document.all.id5.style.position="relative";
		document.all.id6.style.visibility="visible";
		document.all.id6.style.position="relative";
	} 
	else
	{
		document.all.id5.style.visibility="hidden";
		document.all.id5.style.position="absolute";
		document.all.id6.style.visibility="hidden";
		document.all.id6.style.position="absolute";
	}
}
function callNpa()
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getNpaScheme";
		document.forms[0].action=appURL+"action/npascheme.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="proposal" action="" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="51" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Proposal Terms -&gt; Conduct of Operations</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>			
				<td align="center" class="sub_tab_active" width="15%"><b>Conduct of operations</b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callRBI()" >RBI Guidelines</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInspection()" >Inspection Comments</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callCersai()" >CERSAI Details</a></b></td>
				<td align="center" class="sub_tab_inactive" width="15%" ><b><a href="JavaScript:callNpa()" >NPA/Ratification/Concession</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br/>
<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
	<tr>
		<td><b>Conduct of Operations in the Existing Facilities of Applicant</b></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr><td>
	<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td>Compliance of the earlier sanction terms</td>
		<td colspan="3"><textarea name="txt_sanctionterms" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_COMPLIANCE"))%></textarea></td>
	</tr>
	<tr>
		<td>Internal Inspection</td>
		<td><textarea name="txt_intinspection" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_INTERNALINSPECTION"))%></textarea></td>
		<td>RBI Inspection</td>
		<td><textarea name="txt_rbiinspection" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_RBIINSPECTION"))%></textarea></td>
	</tr>
	<tr>
		<td>Audits Observation</td>
		<td><textarea name="txt_auditobservation" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_AUDITSOBSER"))%></textarea></td>
		<td>Offsite Observation</td>
		<td><textarea name="txt_offobservation" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_OFFSITEOBSERV"))%></textarea></td>
	</tr>
	<tr>
		<td>Registration of charge with ROC & Latest search report<br/> obtained</td>
		<td><Select name="sel_regcharge" onChange="callReason1()">
			<option value="S" selected="selected">--Select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</Select></td>
		<td id="id1">Reason</td>
		<td id="id2"><textarea name="txt_reason1" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_ROCREASON"))%></textarea></td>
	</tr>
	<tr id="id12">
		<td>Period Covered</td>
		<td colspan="3"><input type="text" size="20" name="txt_periodcovered" maxlength="4"><%=Helper.correctNull((String)hshValues.get("CON_PERIODCOVERED"))%></td>
	</tr>
	<tr>
		<td>Registration of EM details with Central Registry</td>
		<td><Select name="sel_regEM" onChange="callReason2()">
			<option value="S" selected="selected">--Select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</Select></td>
		<td id="id3">Reason</td>
		<td id="id4"><textarea name="txt_reason2" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_EMREASON"))%></textarea></td>
	</tr>
	<tr>
		<td>Whether charge noted in favor of our Bank 
						on the<br/> property/ies has been verified</td>
		<td><Select name="sel_chargenoted" onChange="callReason2()">
			<option value="S" selected="selected">--Select--</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
			</Select></td>
		<td id="id5">Reason</td>
		<td id="id6"><textarea name="txt_reason3" cols="40"
						rows="4" onKeyPress="textlimit(this,'1999');notAllowSingleAndDoubleQuote()" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("CON_CHARGESREASON"))%></textarea></td>
	</tr>
	<tr>
		<td>Conduct of TL/DPN</td>
		<td colspan="3"><textarea name="txt_tldpn" cols="40"><%=Helper.correctNull((String)hshValues.get("CON_CONDUCTTLDPN"))%></textarea>
	</tr>
</table>
</td></tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<INPUT TYPE="hidden" name="hidsno"> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
