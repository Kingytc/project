<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup-Groups</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strId="";
var strdisc_grpname="";
var strId=	"<%=Helper.correctNull((String)hshValues.get("disc_grpid"))%>";
var strdisc_grpname = "<%=Helper.correctNull((String)hshValues.get("disc_grpname"))%>";
var strdisc_perpartyanncap= "<%=Helper.correctNull((String)hshValues.get("disc_perpartyanncap"))%>";
var strdisc_grouplimit="<%=Helper.correctNull((String)hshValues.get("disc_grouplimit"))%>";
var strdisc_perptyfundbased="<%=Helper.correctNull((String)hshValues.get("disc_perptyfundbased"))%>";
var strdisc_perptynonfund="<%=Helper.correctNull((String)hshValues.get("disc_perptynonfund"))%>";
var strdisc_workingcapital="<%=Helper.correctNull((String)hshValues.get("disc_workingcapital"))%>";
var strdisc_perptyunsecured="<%=Helper.correctNull((String)hshValues.get("disc_perptyunsecured"))%>";
var strdisc_adhocsanclimit="<%=Helper.correctNull((String)hshValues.get("disc_adhocsanclimit"))%>";
var strdisc_adhocmonths="<%=Helper.correctNull((String)hshValues.get("disc_adhocmonths"))%>";
var strdisc_adhocunsecured="<%=Helper.correctNull((String)hshValues.get("disc_adhocunsecured"))%>";
var strdisc_guarantee="<%=Helper.correctNull((String)hshValues.get("disc_guarantee"))%>";
var strdisc_termloan="<%=Helper.correctNull((String)hshValues.get("disc_termloan"))%>";
var strdisc_lgmargin="<%=Helper.correctNull((String)hshValues.get("disc_lgmargin"))%>";
var strdisc_lgwomargin="<%=Helper.correctNull((String)hshValues.get("disc_lgwomargin"))%>";
var strdisc_lc="<%=Helper.correctNull((String)hshValues.get("disc_lc"))%>";
var strdisc_lcpb="<%=Helper.correctNull((String)hshValues.get("disc_lcpb"))%>";
var strdisc_bankdeposit="<%=Helper.correctNull((String)hshValues.get("disc_bankdeposits"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function populateValues()
{  
	if(document.forms[0].grouplimitslist.selectedIndex==-1)
	{
		return;
	}		 
	var strId=document.forms[0].grouplimitslist[document.forms[0].grouplimitslist.selectedIndex].value;
	document.forms[0].grp_id.value=strId;	  
	document.forms[0].hidBeanMethod.value="getData";
	document.forms[0].action=appUrl+"action/setgrouplimits.jsp";
	document.forms[0].submit();
}
function placeValues()
 {		
	 if(strId=="null" || strAction!="")
	 {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;
		 document.forms[0].grouplimitslist.disabled=false;
         document.forms[0].cmdcreate.disabled=false;
		 document.forms[0].cmdclose.disabled=false;
		 return;
	 }
	 document.forms[0].grp_id.value = strId;
	 document.forms[0].dis_authname.value = strdisc_grpname;
	 document.forms[0].dis_authperparty.value = strdisc_perpartyanncap;	 
	 document.forms[0].dis_authfundbased.value = strdisc_perptyfundbased;
	 document.forms[0].dis_authnonfundbased.value = strdisc_perptynonfund;
	 document.forms[0].dis_workingcapital.value = strdisc_workingcapital;
	 document.forms[0].dis_termloan.value=strdisc_termloan;
 	 document.forms[0].dis_lccashmargin.value=strdisc_lc;
	 document.forms[0].dis_authunsecadv.value = strdisc_perptyunsecured;
	 document.forms[0].dis_authmaxsanclimit.value = strdisc_adhocsanclimit;
	 document.forms[0].dis_authsancmonths.value = strdisc_adhocmonths;
	 document.forms[0].disc_adhocunsecured.value = strdisc_adhocunsecured;
	 document.forms[0].disc_lgcashmargin.value = strdisc_guarantee;
	 document.forms[0].dis_banksdeposits.value=strdisc_bankdeposit;
	 document.forms[0].dis_lcprimebank.value=strdisc_lcpb;
	 document.forms[0].grouplimitslist.disabled=false;

	 if(document.forms[0].dis_authname.value=="")
	 {
	 document.forms[0].cmdedit.disabled=true;
	 }
	 else
	 {
	 document.forms[0].cmdedit.disabled=false;
	 }
	 document.forms[0].cmdcreate.disabled=false;
	 document.forms[0].cmddelete.disabled=true;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmdclose.disabled=false;	
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text' && document.forms[0].elements[i].name != 'dis_authsancmonths' && document.forms[0].elements[i].name != 'dis_authname')
		  {
			roundtxt(document.forms[0].elements[i]);
		  }
	   } 
 }
function doCreate()
 {
	document.forms[0].reset();
	document.forms[0].grouplimitslist.disabled = true;
	document.forms[0].dis_authname.value="";
	document.forms[0].dis_authname.readOnly=false;
	document.forms[0].dis_authperparty.value="";
	document.forms[0].dis_authperparty.readOnly=false;
	document.forms[0].dis_authfundbased.value="";
	document.forms[0].dis_authfundbased.readOnly=false;
	document.forms[0].dis_authnonfundbased.value="";
	document.forms[0].dis_authnonfundbased.readOnly=false;
	document.forms[0].dis_workingcapital.value="";
	document.forms[0].dis_workingcapital.readOnly=false;
	document.forms[0].dis_termloan.value="";
	document.forms[0].dis_termloan.readOnly=false;
	document.forms[0].dis_authunsecadv.value="";
	document.forms[0].dis_authunsecadv.readOnly=false;
	document.forms[0].dis_authmaxsanclimit.value="";
	document.forms[0].dis_authmaxsanclimit.readOnly=false;
	document.forms[0].dis_authsancmonths.value="";
	document.forms[0].dis_authsancmonths.readOnly=false;
	document.forms[0].disc_adhocunsecured.value="";
	document.forms[0].disc_adhocunsecured.readOnly=false;
	document.forms[0].disc_lgcashmargin.value="";
	document.forms[0].disc_lgcashmargin.readOnly=false;
	document.forms[0].dis_lccashmargin.value="";
	document.forms[0].dis_banksdeposits.readOnly=false;
	document.forms[0].dis_banksdeposits.value="";
	document.forms[0].dis_lcprimebank.readOnly=false;
	document.forms[0].dis_lcprimebank.value="";
	 
	document.forms[0].cmdcreate.disabled=true;
	document.forms[0].hidAction.value="insert";
    document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;	 
	document.forms[0].dis_authname.focus();
 }

function doEdit()
 {
	 document.forms[0].dis_authname.readOnly=false;
	 document.forms[0].dis_authperparty.readOnly=false;
	 document.forms[0].dis_authfundbased.readOnly=false;
	 document.forms[0].dis_authnonfundbased.readOnly=false;
	 document.forms[0].dis_workingcapital.readOnly=false;
	 document.forms[0].dis_termloan.readOnly=false;
	 document.forms[0].dis_authunsecadv.readOnly=false;
	 document.forms[0].dis_authmaxsanclimit.readOnly=false;
	 document.forms[0].dis_authsancmonths.readOnly=false;
	 document.forms[0].disc_adhocunsecured.readOnly=false;
	 document.forms[0].disc_lgcashmargin.readOnly=false;
	 document.forms[0].dis_banksdeposits.readOnly=false;
	 document.forms[0].dis_lcprimebank.readOnly=false;

	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdsave.disabled=false;
	 document.forms[0].cmddelete.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
	 document.forms[0].cmdcreate.disabled=true;
	 document.forms[0].grouplimitslist.disabled=true;
	 document.forms[0].hidAction.value="update";
 }

  function doSave()
 {
 	if(trimtxt(document.forms[0].dis_authname.value) =="")
	 {
	 alert("Enter Authority Name")
	 return;
	 }
	 checkfb();
	 if(document.forms[0].hidAction.value!="update")
	 {
		 if(document.forms[0].hidAction.value=="insert")
			{
			for(var k=0;k<document.forms[0].grouplimitslist.length;k++)
			{
				if(document.forms[0].dis_authname.value.toUpperCase()==document.forms[0].grouplimitslist.options[k].text.toUpperCase())
				{
					alert('Authority already exists');
					return;
				}
			}
		}
	}
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].hidSourceUrl.value="/action/setgrouplimits.jsp"
	 //document.forms[0].hidAction.value ="Update";
	 document.forms[0].hidRecordflag.value=varRecordFlag;
	 document.forms[0].hidBeanId.value="setgrouplimits";		
	 document.forms[0].hidBeanMethod.value="updateData";
	 document.forms[0].hidBeanGetMethod.value="getData";	
	 document.forms[0].action=appUrl+"controllerservlet";
	 document.forms[0].submit();
 }

function doCancel()
 {
	 if(ConfirmMsg(102))
	 {
		 document.forms[0].hidAction.value="";	
		 document.forms[0].action=appUrl+"action/setgrouplimits.jsp";
		 document.forms[0].submit();		 
	 }
 }

function doDelete()
 {
	if(varRecordFlag=="Y")
	{
		 if(ConfirmMsg(101))
		 {	 
			 document.forms[0].cmdsave.disabled=true;
			 document.forms[0].cmddelete.disabled=true;
			 document.forms[0].hidSourceUrl.value="/action/setgrouplimits.jsp"
			 document.forms[0].hidAction.value ="delete";
			 document.forms[0].hidBeanId.value="setgrouplimits";		
			 document.forms[0].hidBeanMethod.value="updateData";
			 document.forms[0].hidBeanGetMethod.value="getData";
			 document.forms[0].action=appUrl+"controllerservlet";
			 document.forms[0].submit();
		 }
	}
	else
	{		
		ShowAlert(158);
	}
 }
function doClose()
 {	 
	 if(ConfirmMsg(100))
	 {	 document.forms[0].action=appUrl+"action/setupnav.jsp";
		 document.forms[0].submit();
	 }
 }
function checkfb()
{
	var authfund = document.forms[0].dis_authfundbased.value
	var termloan = document.forms[0].dis_termloan.value
	var workingcapital= document.forms[0].dis_workingcapital.value
	
	if(workingcapital=="")
	{
		
		workingcapital=0.00;
	}
	else if(parseFloat(workingcapital)>parseFloat(authfund))
	{
		alert("Working Capital amount should be less than Fundbased");
		document.forms[0].dis_workingcapital.value="";
		document.forms[0].dis_workingcapital.focus();
		return;
	}
	if(termloan=="")
	{
		termloan=0.00;
	}
	else if(parseFloat(termloan)>parseFloat(authfund))
	{
		alert("Term Loan amount should be less than Fundbased");
		document.forms[0].dis_termloan.value="";
		document.forms[0].dis_termloan.focus();
		return;
	}
}
</script>
</head>
<body onload="placeValues();">
<form name="groupsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Lending Powers</td>
	</tr>
	<tr>
		<td align="center"><b>Discretionary Lending Powers for C &amp; I Advances (Public)</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1 tableBg">
					<tr>
						<td width="70%" valign="top" rowspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							 align="center" class="outertable">
							<tr>
								<td valign="middle">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="20%" align="center"><b>Authority <span class="mantatory">*&nbsp;</span></b></td>
										<td width="60%"> <input type="text"
											name="dis_authname" maxlength="25" readOnly tabindex="1"
											size="100" class="txtstyle" onKeyPress="notAllowSplChar()"> </td>
										<td width="20%"> </td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
											<tr>
												<td width="75%" class="setuphead"><b>Annual Cap </b><b></b></td>
												<td width="25%">&nbsp;</td>
											</tr>
											<tr>
												<td width="75%"> Per Party</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authperparty" maxlength="14" tabindex="2"
													size="25" other="readOnly" /> 
												</td>
											</tr>											
											<tr>
												<td width="75%"><b> &gt; </b>Fund Based</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authfundbased" maxlength="14" tabindex="4"
													size="25" styleClass="txtstyle"
													other="readOnly" /> 


												</td>
											</tr>
											<tr>
												<td width="75%"><b> &gt;&gt; </b>Term Loan</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_termloan" maxlength="14" tabindex="5" size="25"
													onBlur="checkfb()" other="readOnly" />
												
												</td>
											</tr>
											<tr>
												<td width="75%"><b> &gt;&gt; </b>Working Capital</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_workingcapital" maxlength="14" tabindex="6"
													size="25" onBlur="checkfb()" styleClass="txtstyle"
													other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%"><b> &gt;&gt;&gt;&gt; </b> <b>W/w Unsecured Advances, not to exceed</b></td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authunsecadv" maxlength="14" tabindex="11"
													size="25" other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%"><b> &gt; </b>Non Fund Based</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authnonfundbased" maxlength="14" tabindex="7"
													size="25" styleClass="txtstyle"
													other="readOnly" /> 
												</td>
											</tr>										
											<tr>
												<td colspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td width="75%" class="setuphead"><b>Ad Hoc / Excess over sanctioned Limit</b></td>
												<td width="25%" align="center"> &nbsp;
												</td>
											</tr>
											<tr>
												<td width="75%">Maximum Adhoc Limit
												</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authmaxsanclimit" maxlength="14" tabindex="12"
													size="25" other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%">For no. of months Adhoc
												</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_authsancmonths" maxlength="14" tabindex="13"
													size="25" precision="0" styleClass="txtstyle"
													other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%">W/w Unsecured Adhoc Limit
												</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="disc_adhocunsecured" maxlength="14" tabindex="14"
													size="25" other="readOnly"/> 
												</td>
											</tr>
											<tr>
												<td colspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td colspan="2" class="setuphead"><b>These will not rank for reckoning the per party limits</b></td>
											</tr>
											<tr>
												<td width="75%">Letter of Guarantee with 100% cash margin
												/ Term Deposits under Lien (Non Fund Based Limits)</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="disc_lgcashmargin" maxlength="14" tabindex="15"
													size="25" other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%">Letter of Credit with 100% cash margin
												/ Term Deposits under Lien (In respect of import LC 110% Cash Margin/ Term Deposit under Lien)</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_lccashmargin" maxlength="14" tabindex="16" size="25"
													/> </td>
											</tr>
											<tr>
												<td width="75%">Advances against Banks Own Deposits</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_banksdeposits" maxlength="14" tabindex="15"
													size="25" other="readOnly" /> 
												</td>
											</tr>
											<tr>
												<td width="75%">Advances Under LC of Prime Bank</td>
												<td width="25%" align="center"> <lapschoice:CurrencyTag
													name="dis_lcprimebank" maxlength="14" tabindex="15"
													size="25" other="readOnly" onBlur="roundtxt(this);" /> 
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
						<td width="30%" valign="top" class="dataheader">
						<center><br>
						<span class="mantatory">Double click to view Lending Powers</span><br>
						</center>
						</td>
					</tr>
					<tr>
						<td width="30%" align="center" valign="top"><select
							name="grouplimitslist" style="width:250;height:500" size="50"
							onDblClick="populateValues()" class="txtstyle">
							<lapschoice:grouplimits />
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
  <lapschoice:combuttonnew btnnames='Create_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="grp_id">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>


