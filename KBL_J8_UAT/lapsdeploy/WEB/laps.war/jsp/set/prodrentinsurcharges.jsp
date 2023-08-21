<%@ include file="../share/directives.jsp"%>
<%
String hidProductType=Helper.correctNull((String)request.getParameter("hidProductType"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rent & Insurance</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function processpageClearValues()
{
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangeto.value="";
	document.forms[0].prd_chargecollectrs.value="";
	document.forms[0].prd_chargecollectquarter.value="";
}
function processpageDisableField(flag)
{
	document.forms[0].prd_procrangefrom.disabled=flag;
	document.forms[0].prd_procrangeto.disabled=flag;
	document.forms[0].prd_chargecollectrs.disabled=flag;
	document.forms[0].prd_chargecollectquarter.disabled=flag;
}
function processpageDisableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}
function onloading()
{
	for(i=0;i<document.forms[0].selectterm.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectterm[i].value)
		{
			if(document.forms[0].hidId.value==0)
			{
				document.forms[0].selectterm.selectedIndex=0;
			}
			else
			{
				document.forms[0].selectterm.selectedIndex=i;
			}
		}
	}	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	if(selindex=='')
	{
		processpageDisableButtons(true,true,true,true,false);
	}
	else
	{
		if(document.forms[0].checkApp.value=="No")
		{
			processpageDisableButtons(false,true,true,true,false);			
		}
		else
		{
			processpageDisableButtons(true,true,true,true,false);
		}
	}
	processpageDisableField(true);
}
function getValue()
{	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		if(selindex=='')		
		{	
			processpageClearValues();
			processpageDisableField(true);
			processpageDisableButtons(true,true,true,true,false);
		}
		else if(selindex==0)
		{
			processpageClearValues();
			processpageDisableField(false);
			onNew();
		}
		else
		{
			if(document.forms[0].checkApp.value=="No")
			{	processpageDisableField(false);
			}	
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value=selindex;
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="getRentInsureData";
			document.forms[0].action=appURL+"action/prodrentinsurcharges.jsp";
			document.forms[0].submit();
		}
}
function onNew()
{	
	isnew="true";
	if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp.value=="null" || document.forms[0].checkApp.value=="")
	{
		processpageDisableField(false);
		processpageDisableButtons(true,false,false,true,true);
	}	
	else
	{
		processpageDisableField(true);
		document.forms[0].selectterm.selectedIndex=0;
		ShowAlert(144);
	}
}
function doEdit()
{
	processpageDisableField(false);
	processpageDisableButtons(true,false,false,false,true);
}
function doSave()
{	
	if(checktrim(document.forms[0].prd_procrangefrom.value)=="")
	{
		ShowAlert('121','Range From');
		document.forms[0].prd_procrangefrom.focus();
		return false;
	}
	if(checktrim(document.forms[0].prd_procrangeto.value)=="")
	{
		ShowAlert('121','Range To');
		document.forms[0].prd_procrangeto.focus();
		return false;
	}
	if(checktrim(document.forms[0].prd_chargecollectrs.value)==""||checktrim(document.forms[0].prd_chargecollectquarter.value)=="")
	{
		ShowAlert('121','Charge to be collected ');
		document.forms[0].prd_chargecollectrs.focus();
		return false;
	}
	if(eval(document.forms[0].prd_procrangefrom.value) >=  eval(document.forms[0].prd_procrangeto.value))
	{
		alert("Range From cannot be greater than Range To");
		return false;
	}
	if(parseFloat(document.forms[0].prd_procrangefrom.value) > parseFloat(document.forms[0].prdRangeTo.value) || parseFloat(document.forms[0].prd_procrangefrom.value) < parseFloat(document.forms[0].prdRangeFrom.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
		}
	if(parseFloat(document.forms[0].prd_procrangeto.value) > parseFloat(document.forms[0].prdRangeTo.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
		}
	if(parseFloat(document.forms[0].prd_procrangeto.value) <  parseFloat(document.forms[0].prd_procrangefrom.value))
		{
		alert("The From Range Should Be Less Than To Range For a Interest Range");
		return;
		}	
	if(checktrim(document.forms[0].prd_chargecollectrs.value)=="")
	{
		document.forms[0].prd_chargecollectrs.value ="0.00";
	}
		if(isnew=="true")
		{
		document.forms[0].hidAction.value="insert";
		}
		else
		{
		document.forms[0].hidAction.value="update";
		}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidId.value =
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].action=appURL+"controllerservlet";		
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateRentInsureData";
		document.forms[0].hidSourceUrl.value="/action/prodrentinsurcharges.jsp";
		document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg('101'))
		{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidId.value =
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateRentInsureData";
		document.forms[0].hidSourceUrl.value="/action/prodrentinsurcharges.jsp";
		document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{		
		if(document.forms[0].checkApp.value=="No")
			{
				processpageDisableField(false);
			}	
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value="";
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="getRentInsureData";
			document.forms[0].action=appURL+"action/prodrentinsurcharges.jsp";
			document.forms[0].submit();	
	}
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].hidBeanGetMethod.value = "";
		document.forms[0].action=appURL+"action/setsearchproducts.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>
<body onLoad="onloading();">
<form name="prdrentinsurefrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<lapstab:setproductstab tabid="6" prdtype='<%=hidProductType%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
	<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Charges -&gt; Rent & Insurance</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
<tr> 
	<td valign="top"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr> 
			<td valign="top"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr> 
					<td> 
						<table width="60%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
						<tr> 
							<td width="34%" align="center" id="prm" class="sub_tab_inactive">
							<a href="JavaScript:callOtherTab('prodprocesscharges.jsp')" >
							Processing</a></td>
							<!--<td width="25%" align="center" id="com2" class="sub_tab_inactive"> 
							<a href="JavaScript:callOtherTab('proddocumentcharges.jsp')" >
							Documentation</a></td>-->
							<td width="33%" align="center" class="sub_tab_active">Rent & Insurance</td>
							<td width="33%" align="center" class="sub_tab_inactive"> 
							<a href="JavaScript:callOtherTab('prodjewelappraisalcharges.jsp')" > 
							Jewel Appraisal</a></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td> 
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
						<tr> 
							<td>
								<fieldset> 
								<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
								<tr> 
									<td><lapschoice:products /></td>
								</tr>
								</table>
								</fieldset> 
								<br>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
								<tr> 
									<td colspan="4"> 
										<table width="98%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertableborder1">
										<tr> 
											<td colspan="6"> 
												<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable">
												<tr> 
													<td colspan="6">Charges</td>
												</tr>
												<tr> 
													<td width="25%">Select Rent & Insurance Range</td>
													<td width="4%">&nbsp; </td>
													<td width="20%"> 
													<select name="selectterm" onChange="getValue();" tabindex="10">
													<lapschoice:rentinsurancetag/> 
													</select>
													</td>
													<td width="19%">&nbsp; </td>
												</tr>
												<tr>
													<td width="25%" >Amount Range From <span class="mantatory">*</span></td>
													<td width="4%">&nbsp;</td>
													<td width="20%" >                                                 
													<lapschoice:CurrencyTag name="prd_procrangefrom"  maxlength="14" 
													value='<%=Helper.correctDouble((String)hshValues.get("richrg_rangefrom"))%>' tabindex="11" size="15" onBlur="roundtxt(this);"/> 
													</td>
													<td width="19%">Amount Range To<span class="mantatory">*</span></td>
													<td width="3%"></td>
													<td width="29%">                                                 
													<lapschoice:CurrencyTag name="prd_procrangeto"  maxlength="14" 
													value='<%=Helper.correctDouble((String)hshValues.get("richrg_rangeto"))%>' tabindex="12" size="15" onBlur="roundtxt(this);"/>											  
													</td>
												</tr>
												<tr>
													<td>Charges to be collected<span class="mantatory">*</span></td>
													<td>Rs.&nbsp;</td>
													<td colspan="4">                                                 
													<lapschoice:CurrencyTag name="prd_chargecollectrs"  maxlength="14" 
													value='<%=Helper.correctDouble((String)hshValues.get("richrg_chrgcollect1"))%>' tabindex="13" size="15" onBlur="roundtxt(this);"/>&nbsp;/&nbsp;
													<lapschoice:CurrencyTag name="prd_chargecollectquarter"  maxlength="14" 
													value='<%=Helper.correctDouble((String)hshValues.get("richrg_chrgcollect2"))%>' tabindex="14" size="15" onBlur="roundtxt(this);"/>&nbsp;per quarter
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidSeldInsti" value="">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
<input type="hidden" name="checkApp" value="<%=Helper.correctNull((String)request.getParameter("checkApp"))%>">
<input type="hidden" name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>">
<input type="hidden" name="hiddesc" value="">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>