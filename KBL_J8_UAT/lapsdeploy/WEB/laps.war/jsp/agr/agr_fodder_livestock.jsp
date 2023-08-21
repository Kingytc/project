<%@include file="../share/directives.jsp"%>
<!DOCtype html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
<title>Live Stock Details</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var selgovt = "<%=Helper.correctNull((String)hshValues.get("ls_govt"))%>";
var selstate = "<%=Helper.correctNull((String)hshValues.get("ls_state"))%>";
var selobtained = "<%=Helper.correctNull((String)hshValues.get("ls_obtained"))%>";

var ls_breed1="<%=Helper.correctNull((String)hshValues.get("ls_breed1"))%>";
if(ls_breed1=="")
{
	ls_breed1="Select";
}
var ls_breed2="<%=Helper.correctNull((String)hshValues.get("ls_breed2"))%>";
if(ls_breed2=="")
{
	ls_breed2="Select";
}
var ls_breed3="<%=Helper.correctNull((String)hshValues.get("ls_breed3"))%>";
if(ls_breed3=="")
{
	ls_breed3="Select";
}
var ls_breed4="<%=Helper.correctNull((String)hshValues.get("ls_breed4"))%>";
if(ls_breed4=="")
{
	ls_breed4="Select";
}
var ls_breed5="<%=Helper.correctNull((String)hshValues.get("ls_breed5"))%>";
if(ls_breed5=="")
{
	ls_breed5="Select";
}
var ls_breed6="<%=Helper.correctNull((String)hshValues.get("ls_breed6"))%>";
if(ls_breed6=="")
{
	ls_breed6="Select";
}
var ls_breed7="<%=Helper.correctNull((String)hshValues.get("ls_breed7"))%>";
if(ls_breed7=="")
{
	ls_breed7="Select";
}
currentDate = "<%=Helper.getCurrentDateTime()%>";

function callOnload()
{
	if(selgovt!="")
	{
		document.forms[0].sel_govt.value=selgovt;
		document.forms[0].sel_state.value=selstate;
		document.forms[0].sel_obtained.value=selobtained;
	}
	disableFields(true);
	document.forms[0].txt_Breed1.value=ls_breed1;
	document.forms[0].txt_Breed2.value=ls_breed2;
	document.forms[0].txt_Breed3.value=ls_breed3;
	document.forms[0].txt_Breed4.value=ls_breed4;
	document.forms[0].txt_Breed5.value=ls_breed5;
	document.forms[0].txt_Breed6.value=ls_breed6;
	document.forms[0].txt_Breed7.value=ls_breed7;
}

function disablebuttons(cmdEdit,cmdApply,cmdCancel,cmddel)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmddel;
}

function doSave() 
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="/action/agr_fodder_livestock.jsp";
	document.forms[0].hidBeanMethod.value="updateFodderLiveStock";
	document.forms[0].hidBeanGetMethod.value="getFodderLiveStock";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{ 	
	disableFields(false);
	disablebuttons(true,false,false,false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getFodderLiveStock";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appURL+"action/agr_fodder_livestock.jsp";	
		document.forms[0].submit();
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}

function doClose()
    {
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();

	}
}
function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="/action/agr_fodder_livestock.jsp";
		document.forms[0].hidBeanMethod.value="updateFodderLiveStock";
		document.forms[0].hidBeanGetMethod.value="getFodderLiveStock";	
		document.forms[0].submit();
	}
}


</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
</head>
<body onload="callOnload()">
<form name="appform" method="post" class="normal">
<table width=98% " border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td colspan="2">
		<table width="100%" cellpadding="5" cellspacing="0" border="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
					<tr>
						<td>
						<table width="100%" cellpadding="3" cellspacing="0" border="0" class="outertable">
							<tr>
								<td><a alt="Select date from calender" href="#"
									onclick="callCalender('txt_date')"
									onmouseover="window.status='Date Picker';return true;"
									onmouseout="window.status='';return true;"> </a>Type of Natural
								calamity <input type="text" name="txt_calamity" size="20"
									maxlength="30" onkeypress="notAllowSplChar()"
									value="<%=Helper.correctNull((String)hshValues.get("ls_clamity"))%>" />
								whether area is declared as affected by natural calamity by govt
								<select name="sel_govt">
									<option value="1" selected>YES</option>
									<option value="2">NO</option>
								</select> <select name="sel_state">
									<option value="1" selected>Central</option>
									<option value="2">State</option>
								</select> copy of Govt. declaration obtained <select
									name="sel_obtained">
									<option value="1" selected>YES</option>
									<option value="2">NO</option>
								</select> what is the annavari declared by the Govt <font
									size="1" face="MS Sans Serif"><b><font
									color="#FF0000">*</font></b></font> <input
									type="text" name="txt_annas" size="20" maxlength="30"
									onkeypress="notAllowSplChar()"
									value="<%=Helper.correctNull((String)hshValues.get("ls_annas"))%>" />
								annas</td>
							</tr>
							<tr>
								<td>
								<table width="70%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
											<tr class="dataheader">
												<td colspan="2" align="center"><b>Detail of Presently Owned
												Live Stock</b></td>
											</tr>
											<tr class="dataheader">
												<td align="center"><b>Live Stock</b></td>
												<td align="center"><b>Number</b></td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed1">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno1"
													style="text-align:left" size="20" maxlength="4"
													onkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno1"))%>" />
												</td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed2">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno2"
													size="20" maxlength="4" onkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno2"))%>" />
												</td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed3">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno3"
													size="20" maxlength="4" inkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno3"))%>" /></td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed4">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno4"
													size="20" maxlength="4" inkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno4"))%>" /></td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed5">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno5"
													size="20" maxlength="4" inkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno5"))%>" /></td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed6">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno6"
													size="20" maxlength="4" inkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno6"))%>" /></td>
											</tr>
											<tr class="datagrid">
												<td align="center"><select name="txt_Breed7">
													<option selected value="Select">Select</option>
													<option value="Cows">Cows</option>
													<option value="Buffaloes">Buffaloes</option>
													<option value="Plough Animals">Plough Animals</option>
													<option value="Sheep">Sheep</option>
													<option value="Goat">Goat</option>
													<option value="Other Animals">Other Animals</option>
												</select></td>
												<td align="center"><input type="text" name="txt_Breedno7"
													size="20" maxlength="4" inkeypress="allowInteger()"
													value="<%=Helper.correctNull((String)hshValues.get("ls_breedno7"))%>" />
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
<br/>	
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="comapp_id" value="" /> 
<input type="hidden" name="hidsno" value=""/> 
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>"/>
</form>
</body>
</html>


