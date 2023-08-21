<%@ include file="../share/directives.jsp"%>
<%String strExp = Helper.correctNull((String) hshValues.get("strExp"));%>
<html>
<head>
<title>Setup(Products - Repayment Capacity)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varselincomerange="<%=Helper.correctNull((String)hshValues.get("selincomerange"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function onloading()
{   
	
	strExp="<%=strExp%>";
	if(strExp!="")
	{
		alert(strExp);
		disableButtons(true,true,true,true,false);
	}
	else
	{
		
		if(varselincomerange!="")
		{
			document.forms[0].selincomerange.value=varselincomerange;
		}
		disableButtons(false,true,true,true,false);
	}
	disableFields(true);
}

function disableFields(flag)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=flag;
		}
	}
}

function disableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}
	
function getRepaycapacity()
{
	
	if(document.forms[0].selincomerange.value=="")
	{
		document.forms[0].txt_incomefrom.value="";
		document.forms[0].txt_incometo.value="";
		document.forms[0].txt_sustanencesalaried.value="";
		document.forms[0].txt_sustanencenonsalaried.value="";
		document.forms[0].txt_sustanenceartificialbodies.value="";
		document.forms[0].txt_creditscheme.value="";
		disableFields(false);
		disableButtons(true,true,true,true,true);
	}
	else if(document.forms[0].selincomerange.value=="0")
	{
		varRecordFlag="N";
		document.forms[0].txt_incomefrom.value="";
		document.forms[0].txt_incometo.value="";
		document.forms[0].txt_sustanencesalaried.value="";
		document.forms[0].txt_sustanencenonsalaried.value="";
		document.forms[0].txt_sustanenceartificialbodies.value="";
		document.forms[0].txt_creditscheme.value="";
		document.forms[0].hidAction.value="insert";
		if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp.value=="null" || document.forms[0].checkApp.value=="")
		{
			disableFields(false);
			disableButtons(true,false,false,true,true);
		}
		else
		{
			disableFields(true);
			disableButtons(true,true,true,true,true);
			document.forms[0].selincomerange.selectedIndex=0;
			ShowAlert(144);
		}
	}
	else
	{
		
		document.forms[0].action=appUrl+"action/prodrepaycapacity.jsp";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getIncomeData";
		document.forms[0].submit();
	}
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	disableButtons(true,false,false,false,true);
}

function callOtherTab(url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		if(url=="prodCollateralSecurity.jsp")
		{
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="getCollateralSecurity";
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getData";
		}
		document.forms[0].action=appUrl+"action/"+url;
		document.forms[0].submit();
	}
}
function callOtherTab1(url)
{
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getSpecificEligiblity";
		document.forms[0].action=appUrl+"action/"+url;
		document.forms[0].submit();
	
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appUrl+"action/prodrepaycapacity.jsp";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getIncomeData";
		document.forms[0].submit();	
	}
}

function doSave()
{
	if(document.forms[0].txt_incomefrom.value=="" || document.forms[0].txt_incomefrom.value=="0.00")
	{
		alert("Please enter the Gross Income Range From");
		return;
	}
	if(document.forms[0].txt_incometo.value=="" || document.forms[0].txt_incometo.value=="0.00")
	{
		alert("Please enter the Gross Income Range To");
		return;
	}
	if(document.forms[0].txt_sustanencesalaried.value=="")
	{
		alert("Please enter the Sustenance Required for Salaried (%)");
		return;
	}
	if(document.forms[0].txt_sustanencenonsalaried.value=="")
	{
		alert("Please enter the Sustenance Required for Non Salaried (%)");
		return;
	}
	/*if(document.forms[0].txt_sustanenceartificialbodies.value=="")
	{
		alert("Please enter the Sustenance Required for Artificial Bodies (%)");
		return;
	}*/
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="updateIncomeData";
	document.forms[0].action=appUrl+"action/prodrepaycapacity.jsp";
	document.forms[0].submit();	
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateIncomeData";
		document.forms[0].hidSourceUrl.value="/action/prodrepaycapacity.jsp";
		document.forms[0].submit();	
	}
}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		document.forms[0].hidBeanId.value="setsearchproducts";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();loadUsedApp()">
<form name="frmprdrepaycapacity" method="post" class="normal">
<lapstab:setproductstab tabid="9" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Repayment Capacity</td>
	</tr>
</table><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
					<tr>
						<td>
						<fieldset>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
							<tr>
								<td><lapschoice:products /></td>
							</tr>
						</table>
						</fieldset>
						</td>
						</tr>
						</table><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
							<tr>
								<td>
								<table width="60%" border="0" cellspacing="1" cellpadding="3"  class="outertable">
									<tr>
										<td align="center" class="sub_tab_active"><b>Repayment Capacity</b></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodCollateralSecurity.jsp')"><b>Collateral Security</b></a></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodinterest.jsp')"><b>Eligibility Parameters</b></a></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab1('prodspeceligible.jsp')"><b>Specific Eligibility Parameters</b></a></td>
									</tr>
								</table>
								</td>
							</tr>
							</table>
							<br>
							<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable border1">
							<tr>
								<td colspan="4">
								<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable">
									<tr>
										<td width="25%">Select Annual Income Range </td>
										<td width="4%"></td>										
                              <td width="19%"> 
                                <select name="selincomerange" onChange="getRepaycapacity()" tabindex="1">
												<lapschoice:incometag/>
											</select>
										</td>										
                              <td width="24%">&nbsp;</td>										
                              <td width="2%"></td>										
                              <td width="26%"></td>
									</tr>
									<tr>
										<td width="25%">Annual Income Range From  <span class="mantatory">*</span></td>
										<td width="4%">&nbsp;</td>										
                              <td width="19%"><lapschoice:CurrencyTag name="txt_incomefrom"
											size="18" tabindex="2" maxlength="15"
											value='<%=Helper.correctNull((String)hshValues.get("incomerangefrom"))%>'/></td>										
                              <td width="24%">Annual Income Range To  <span class="mantatory">*</span></td>										
                              <td width="2%"></td>										
                              <td width="26%"><lapschoice:CurrencyTag name="txt_incometo"
											size="18" tabindex="3" maxlength="15"
											value='<%=Helper.correctNull((String)hshValues.get("incomerangeto"))%>'/></td>
									</tr>
									<tr>
										<td width="25%">Sustenance Required for Salaried (%)  <span class="mantatory">*</span></td>
										<td width="4%">&nbsp;</td>										
                              <td width="19%"><lapschoice:CurrencyTag
											name="txt_sustanencesalaried" size="8"
											maxlength="5" tabindex="4"
											value='<%=Helper.correctNull((String)hshValues.get("sustenancesalaried"))%>'
											onBlur="checkPercentage(this)"/></td>										
                              <td width="24%">Sustenance Required for Non Salaried (%)  <span class="mantatory">*</span></td>										
                              <td width="2%"></td>										
                              <td width="26%"><lapschoice:CurrencyTag
											name="txt_sustanencenonsalaried" size="8"
											maxlength="5" tabindex="5"
											value='<%=Helper.correctNull((String)hshValues.get("sustenancenonsalaried"))%>'
											onBlur="checkPercentage(this)" /></td>
									</tr>
									<!--<tr>
										<td width="25%">Sustenance Required for Artificial Bodies (%)  <span class="mantatory">*</span></td>
										<td width="4%">&nbsp;</td>										
                              <td width="19%"><lapschoice:CurrencyTag
											name="txt_sustanenceartificialbodies" size="8"
											maxlength="5" tabindex="6"
											value='<%=Helper.correctNull((String)hshValues.get("sustenanceartificialbodies"))%>'
											onBlur="checkPercentage(this)"/></td>										
                              <td width="24%">Union credit scheme repay capacity(%)</td>										
                              <td width="2%"></td>										
                              <td width="26%"><lapschoice:CurrencyTag
											name="txt_creditscheme" size="8"
											maxlength="5" tabindex="5"
											value='<%=Helper.correctNull((String)hshValues.get("creditscheme"))%>'
											onBlur="checkPercentage(this)" /></td>
									</tr>
								-->
								<input type="hidden" name="txt_sustanenceartificialbodies" value="">
								<input type="hidden" name="txt_creditscheme" value="">
								
								</table>
								</td>
							</tr>
						</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="checkApp" value="<%=Helper.correctNull((String)request.getParameter("checkApp"))%>">
<input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>






