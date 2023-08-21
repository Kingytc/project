<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol = null;
String strrangefrom ="";
String strrangeto ="";
String strpercentcharge ="";
String strminactualcharge ="";
String strmaxactualcharge ="";
if(vecRow!=null && vecRow.size()>0)
 {	
	 vecCol =(ArrayList)vecRow.get(0);
		if(vecCol!=null)
		{
			strrangefrom	   =Helper.correctNull((String)vecCol.get(0));
			strrangeto		   =Helper.correctNull((String)vecCol.get(1));
			strpercentcharge   =Helper.correctNull((String)vecCol.get(2));
			strminactualcharge =Helper.correctNull((String)vecCol.get(3));
			strmaxactualcharge =Helper.correctNull((String)vecCol.get(4));			 
		}
 }

 %>
<html>
<head>
<title>Setup(Products - Interest)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">

var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var path ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varPrdCode="<%=Helper.correctNull((String) hshValues.get("strPrdCode"))%>";

function processpageClearValues()
{
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangeto.value="";
	document.forms[0].prd_procfees.value="";
	document.forms[0].prd_procfees1.value="";
	document.forms[0].prd_procfees2.value="";
}
function processpageDisableField(flag)
{
	document.forms[0].prd_procrangefrom.disabled=flag;
	document.forms[0].prd_procrangeto.disabled=flag;
	document.forms[0].prd_procfees.disabled=flag;
	document.forms[0].prd_procfees1.disabled=flag;
	document.forms[0].prd_procfees2.disabled=flag;
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
	if(varPrdCode!=""||varPrdCode!="0"){
		document.forms[0].sel_prd.value=varPrdCode;
	}
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
		
			processpageDisableButtons(false,true,true,true,false);			
		
	}
	processpageDisableField(true);
}

function getValue()
{	
	if(	document.forms[0].sel_prd.value==""||document.forms[0].sel_prd.value=="0"){
	 ShowAlert(111,'Product Code');
	  document.forms[0].sel_prd.focus();
	  return;
	}
	document.forms[0].hidBeanGetMethod.value="getProcessData";
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
				processpageDisableField(false);
				
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value=selindex;
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="comsolvency";
			document.forms[0].hidBeanMethod.value="getProcessData";
			document.forms[0].hidSourceUrl.value="/action/solvencyprodprocesscharges.jsp";
			document.forms[0].submit();
		}
}
function onNew()
{	
	isnew="true";
	
		processpageDisableField(false);
		processpageDisableButtons(true,false,false,true,true);
	
}
function doEdit()
{
	document.forms[0].prdRangeFrom.readOnly=true;
	 document.forms[0].prdRangeTo.readOnly=true;
	
	processpageDisableField(false);
	processpageDisableButtons(true,false,false,false,true);
	 document.forms[0].prdRangeFrom.readOnly=true;
	 document.forms[0].prdRangeTo.readOnly=true;
}
function doSave()
{	
	
	if(checktrim(document.forms[0].prd_procrangefrom.value)=="")
	{
		ShowAlert('121','Range From');
		return false;
	}
	if(checktrim(document.forms[0].prd_procrangefrom.value)=="0.00")
	{
		ShowAlert('121','Range From');
		return false;
	}
	if(checktrim(document.forms[0].prd_procrangeto.value)=="")
	{
		ShowAlert('121','Range To');
		return false;
	}
	if(checktrim(document.forms[0].prd_procrangeto.value)=="0.00")
	{
		ShowAlert('121','Range To');
		return false;
	}
	if(checktrim(document.forms[0].prd_procfees.value)=="")
	{
		ShowAlert('121','Processing Fees (%) ');
		return false;
	}
	
	if(checktrim(document.forms[0].prd_procfees1.value)=="")
	{
		ShowAlert('121','Min Processing Fees / Flat Processing fee  ');
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
		
	if(checktrim(document.forms[0].prd_procfees.value)=="")
	{
		document.forms[0].prd_procfees.value ="0.00";
		document.forms[0].prd_procfees2.value ="0.00";
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
		document.forms[0].action=path+"controllerservlet";		
		document.forms[0].hidBeanId.value="comsolvency";
		document.forms[0].hidBeanGetMethod.value="updateProcessChargesData";
		document.forms[0].hidSourceUrl.value="/action/solvencyprodprocesscharges.jsp";
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
		document.forms[0].action=path+"controllerservlet";
	
		document.forms[0].hidBeanId.value="comsolvency";
		document.forms[0].hidBeanGetMethod.value="updateProcessChargesData";
		document.forms[0].hidSourceUrl.value="/action/solvencyprodprocesscharges.jsp";
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
			processpageDisableField(false);
				
			document.forms[0].hidId.value = 
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
			document.forms[0].hiddesc.value="";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="comsolvency";
			document.forms[0].hidBeanGetMethod.value="getProcessData";
			document.forms[0].hidSourceUrl.value="/action/solvencyprodprocesscharges.jsp";
			document.forms[0].submit();	
	}
}
function doClose()
{
	
		document.forms[0].action =path+"action/setupnav.jsp";
		document.forms[0].submit();
	
}
function showper()
{
if(document.forms[0].prd_procfees.value >100)
   {
   alert("Processing Fees should be with in 100 Percentage")
   document.forms[0].prd_procfees.value=""; 
    document.forms[0].prd_procfees.focus(); 
   } 
}
function getproduct()
{
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].action=appURL+"action/solvencyprodprocesscharges.jsp";
	document.forms[0].submit();
}
function prodcharges(){
	var varprdcode=document.forms[0].sel_prd.value;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getProcessData";
	document.forms[0].action=appURL+"action/solvencyprodprocesscharges.jsp";
	document.forms[0].submit();
}
</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="documentsfrm" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="1"
	align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Solvency and Banker
		Certificate Charges & Delegated Power</td>
	</tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1 tableBg" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr>
						<td width="47%">Product code</td>
						<td width="29%"><select name="sel_prd" onchange="prodcharges()">
							<option value="0">&lt;---Select---&gt;</option>
							<option value="1">Solvency</option>
							<option value="6">Banker Certificate</option>
							<option value="7">Line of Credit</option>
						</select></td>
						<td width="24%"></td>
					</tr>
					<tr>
						<td width="25%"> Range From <span class="mantatory">*</span></td>
						<td width="20%"><lapschoice:CurrencyTag
							name="prdRangeFrom" maxlength="14" value='<%=Helper.correctNull((String) hshValues.get("STATIC_DATA_RANGE_FROM"))%>'
							tabindex="11" size="15" onBlur="roundtxt(this);" /></td>
						<td width="19%"> Range To<span class="mantatory">*</span></td>
						<td width="29%"><lapschoice:CurrencyTag
							name="prdRangeTo" maxlength="14" value='<%=Helper.correctNull((String) hshValues.get("STATIC_DATA_RANGE_TO"))%>'
							tabindex="12" size="15" onBlur="roundtxt(this);" /></td>
					</tr>

				</table>
				</td>
			</tr>
			</table>
			</td>
			</tr>
		</table>
		<table width="37%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">

			<tr>
				<jsp:include page="../set/solvencyurltab.jsp" flush="true">
					<jsp:param name="tabid" value="01" />
				</jsp:include>
			</tr>
		</table>



		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1 tableBg">
	<tr>
		<td colspan="4">
		<table width="98%" border="0" cellspacing="0" cellpadding="2"
			align="center" class="outertable">
			<tr>
				<td colspan="6">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td colspan="6">Charges</td>
					</tr>
					<tr>
						<td width="25%">Select Processing Amount Range</td>
						<td width="4%">&nbsp;</td>
						<td width="20%"><select name="selectterm" onChange="getValue()"
							tabindex="10">
							<lapschoice:SolProcessChargeTag appvalue='<%=Helper.correctNull((String) hshValues.get("strPrdCode"))%>'/>
						</select></td>
						<td width="19%">&nbsp;</td>
					</tr>
					<tr>
						<td width="25%">Amount Range From <span class="mantatory">*</span></td>

						<td width="4%">&nbsp;</td>
						<td width="20%"><lapschoice:CurrencyTag
							name="prd_procrangefrom" maxlength="14" value='<%=strrangefrom%>'
							tabindex="11" size="15" onBlur="roundtxt(this);" /></td>
						<td width="19%">Amount Range To<span class="mantatory">*</span></td>
						<td width="3%"></td>
						<td width="29%"><lapschoice:CurrencyTag
							name="prd_procrangeto" maxlength="14" value='<%=strrangeto%>'
							tabindex="12" size="15" onBlur="roundtxt(this);" /></td>
					</tr>
					<tr>
						<td width="25%">Processing Fees (%)<span class="mantatory">*</span></td>
						<td width="4%">&nbsp;</td>
						<td width="20%"><lapschoice:CurrencyTag name="prd_procfees"
							maxlength="5" value='<%=strpercentcharge%>' tabindex="13" size="15" onBlur="showper()" /></td>
						<td width="19%">Min Processing Fees / Flat Processing fee <span
							class="mantatory">*</span></td>
						<td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
						<td width="29%"><lapschoice:CurrencyTag name="prd_procfees1"
							maxlength="15" value='<%=strminactualcharge%>' tabindex="14" size="20" /></td>
					</tr>
					<tr>
						<td width="25%">Max Processing Fees</td>
						<td width="4%"><b><%=ApplicationParams.getCurrency()%></b></td>
						<td width="20%"><lapschoice:CurrencyTag name="prd_procfees2"
							maxlength="15" value='<%=strmaxactualcharge%>' tabindex="15" size="20" /></td>
						<td width="19%">&nbsp;</td>
						<td width="3%"></td>
						<td width="29%"></td>
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

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidSeldInsti" value=""> <input type="hidden"
	name="prd_code"
	value="<%=Helper.correctNull((String)hshValues.get("sel_prd")) %>" />
<input type="hidden" name="checkApp"
	value="<%=Helper.correctNull((String)request.getParameter("checkApp"))%>">
<input type="hidden" name="hidId"
	value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>">
<input type="hidden" name="hiddesc" value=""> <input
	type="hidden" name="hidProductType"
	value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>






