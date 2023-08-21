<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var realisible_value="<%=Helper.correctNull((String)hshValues.get("marketabilityofsec"))%>";
var legal_position="<%=Helper.correctNull((String)hshValues.get("legalposition"))%>";

var aggrmeanspt="<%=Helper.correctNull((String)hshValues.get("aggregatemeanspoint"))%>";
var ageofnpapt="<%=Helper.correctNull((String)hshValues.get("ageofnpapoints"))%>";
var legalpospt="<%=Helper.correctNull((String)hshValues.get("legalpositionpoint"))%>";
var realisiblept="<%=Helper.correctNull((String)hshValues.get("realisiblepoint"))%>";


function totparticulars()
{
	var valsec=eval(document.forms[0].securities_value.value);
	var valmeans=eval(document.forms[0].means_value.value);
	var valnpage=eval(document.forms[0].npa_value.value);
	var vallegal=eval(document.forms[0].legalposition_value.value);
	var total=eval(valsec+valmeans+valnpage+vallegal);
	document.forms[0].netscore_points.value=eval(total);
}

function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_evaluation.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatecompromisepage3Data";
		document.forms[0].hidBeanGetMethod.value="getcompromisepage3Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}
}


function onLoading()
{

	if(realisible_value!="")
	{
		document.forms[0].sel_marketabilityofsec.value=realisible_value;
	}
	else
	{
		document.forms[0].sel_marketabilityofsec.value="0";
		document.forms[0].securities_value.value="";
	}
	if(legal_position!="")
	{
		document.forms[0].sel_legalposition.value=legal_position;
	}
	else
	{
		document.forms[0].sel_legalposition.value="0";
		document.forms[0].legalposition_value.value="";
	}
	disableFields(true);
}

function doEdit()
{ 	
	disableCommandButtons(true,false,false,false,true);
    disableFields(false);
    document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getcompromisepage3Data";
		document.forms[0].action=appUrl +"action/CompromiseProposal_evaluation.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	document.forms[0].hidSecValue.value = document.forms[0].sel_marketabilityofsec[document.forms[0].sel_marketabilityofsec.selectedIndex].text;
	document.forms[0].hidLegalPosi.value = document.forms[0].sel_legalposition[document.forms[0].sel_legalposition.selectedIndex].text;
	document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_evaluation.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updatecompromisepage3Data";
	document.forms[0].hidBeanGetMethod.value="getcompromisepage3Data";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
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
	}
	document.forms[0].securities_value.readOnly=true;
	document.forms[0].legalposition_value.readOnly=true;
	document.forms[0].means_value.readOnly=true;
	document.forms[0].npa_value.readOnly=true;
	document.forms[0].netscore_points.readOnly=true;
	document.forms[0].txt_realisablevalue.readOnly=true;
	document.forms[0].txt_rateofint.readOnly=true;
	document.forms[0].txt_npv.readOnly=true;
}

function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
		}
	}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function getscores()
{
	document.all.ifrm.src=appUrl+"action/iframecompromiseevaluation.jsp?hidBeanGetMethod=getEvaluationscores&hidBeanId=npa&npa_appno="+document.forms[0].appno.value+"&marketabilityofsec="+document.forms[0].sel_marketabilityofsec.value+"&legalposition="+document.forms[0].sel_legalposition.value+"&crystaliseddues="+document.forms[0].crystaliseddues.value;
}

function opendisfixed(field)
{
	if (document.forms[0].cmdsave.disabled==false)
	{
	var num="-";
	
	  var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
}

function calculatenpv()
{
	var varinterestrate=document.forms[0].txt_rateofint.value;
	if(varinterestrate=="")
	{
		alert('Select Rate of Interest');
		return;
	}
	var varnoofyears=document.forms[0].txt_years.value;
	if(varnoofyears=="")
	{
		alert('Enter Number of Years');
		return;
	}
	var varsecurityvalue=document.forms[0].txt_realisablevalue.value;
	if(varsecurityvalue=="")varsecurityvalue=0.0;
	
	var varnpv=0;
	
	var varrate=parseFloat(eval(varinterestrate))/(100);
	var denominator=Math.pow(varrate+1,varnoofyears);						
	varnpv=eval(varsecurityvalue)/eval(denominator);
	
	document.forms[0].txt_npv.value=varnpv;
	roundtxt(document.forms[0].txt_npv);
}

</script>
<body onload="onLoading()">
<form name="proposalpage3" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:otscourltag pageid="7" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Compromise
				Proposal -&gt;Evaluation</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
			<tr>
				<td colspan="2"><b><U>EVALUATION MODULE:</u></b></td>
			</tr>
			<tr>
				<td width="11%">&nbsp;Crystallised Dues</td>
				<td width="89%">&nbsp; <input type="text" name="crystaliseddues"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("crystaliseddues"))))%>"
					readOnly></td>
			</tr>
			<tr>
				<td colspan="2">
				<table width="77%" border="0" cellspacing="0" cellpadding="4"
					align="center" class="outertable border1">
					<tr class="dataheader">
						<td width="10%" ><b>Sr.No</b></td>
						<td width="30%" align="center" ><b>Parameter</b></td>
						<td width="30%" align="center" ><b>Particulars</b></td>
						<td width="30%" align="center" ><b> Points </b></td>
					</tr>
					<tr>
						<td width="10%">1</td>
						<td width="30%">Realisable value of Securities</td>
						<td width="30%"><select name="sel_marketabilityofsec"
							onChange="getscores()">
							<option value="0">&lt;---Select---&gt;</option>
							<lapschoice:StaticDataNewTag apptype="28" />
						</select></td>
						<td width="30%"><input type="text" name="securities_value"
							size="5" onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("securities_value"))%>"
							maxlength="3" readOnly></td>
					</tr>
					<tr>
						<td width="10%">2</td>
						<td width="30%">Legal position of the Bank</td>
						<td width="30%"><select name="sel_legalposition"
							onChange="getscores()">
							<option value="0">&lt;---Select---&gt;</option>
							<lapschoice:StaticDataNewTag apptype="29" />
						</select></td>
						<td width="30%"><input type="text" name="legalposition_value"
							onKeyPress="allowInteger()" size="5"
							value="<%=Helper.correctNull((String)hshValues.get("legalposition_value"))%>"
							maxlength="3" readOnly></td>
					</tr>
					<tr>
						<td width="10%">3</td>
						<td width="30%">Aggregate means of the Borrower / guarantors</td>
						<td width="30%">&nbsp; <input type="hidden"
							name="means_particulars" size="45" onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("means_particulars"))%>"
							maxlength="15"></td>
						<td width="30%"><input type="text" name="means_value" size="5"
							onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("means_value"))%>"
							maxlength="3" readOnly></td>
					</tr>
					<tr>
						<td width="10%">4</td>
						<td width="30%">Age of NPA</td>
						<td width="30%">&nbsp; <input type="hidden" name="npa_particulars"
							size="45" onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("npa_particulars"))%>"
							maxlength="15"></td>
						<td width="30%"><input type="text" name="npa_value" size="5"
							onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("npa_value"))%>"
							maxlength="3" readOnly></td>
					</tr>
					<tr>
						<td width="10%">&nbsp;</td>
						<td width="30%" align="center">NET SCORE</td>
						<td width="30%">&nbsp;</td>
						<td width="30%"><input type="text" name="netscore_points"
							onKeyPress="allowInteger()" size="5"
							value="<%=Helper.correctNull((String)hshValues.get("netscore_points"))%>"
							maxlength="3" readOnly></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<table width="50%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
					<tr>
						<td>Realisable Value of Available securities <%=ApplicationParams.getCurrency()%></td>
						<td><lapschoice:CurrencyTag name="txt_realisablevalue"
							value='<%=Helper.correctNull((String)hshValues.get("realisablevalue")) %>' />
						</td>
					</tr>
					<tr>
						<td>Rate of Interest</td>
						<td><lapschoice:CurrencyTag name="txt_rateofint"
							value='<%=Helper.correctNull((String)hshValues.get("roi")) %>'
							onBlur="calculatenpv()" /> <span
							onClick="opendisfixed('txt_rateofint')" style="cursor:hand"><b><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></td>
					</tr>
					<tr>
						<td>Number of years</td>
						<td><input type="text" name="txt_years"
							value="<%=Helper.correctNull((String)hshValues.get("years"))%>"
							onBlur="calculatenpv()"></td>
					</tr>
					<tr>
						<td>NPV <%=ApplicationParams.getCurrency()%></td>
						<td><lapschoice:CurrencyTag name="txt_npv"
							value='<%=Helper.correctNull((String)hshValues.get("npv")) %>' />
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<INPUT type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" /> <iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe>
<input type="hidden" name="hidSecValue">
<input type="hidden" name="hidLegalPosi">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
