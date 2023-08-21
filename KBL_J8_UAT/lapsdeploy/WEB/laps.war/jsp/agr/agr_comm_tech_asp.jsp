<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strAppValue = Helper.correctNull((String) hshValues.get("strAppValue"));

%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>


<script>
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var selappvalue = "<%=strAppValue%>";
var sel_value="<%=Helper.correctNull((String)hshValues.get("select_qualified"))%>";
var varloanfor="<%=Helper.correctNull((String)hshValues.get("agr_loanfor"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, false, false, false, true);	
}

function doSave()
{    
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanGetMethod.value="getTechData";
	document.forms[0].hidBeanMethod.value="updateTechData";
	document.forms[0].hidBeanId.value="agrcommon";
	document.forms[0].hidSourceUrl.value="action/agr_comm_tech_asp.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_comm_tech_asp.jsp";
		document.forms[0].hidBeanId.value="agrcommon";
		document.forms[0].hidBeanGetMethod.value="getTechData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doDelete()
{
if(varRecordFlag=="Y") {
   if(ConfirmMsg(101))
   {
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanGetMethod.value="getTechData";
	document.forms[0].hidBeanMethod.value="updateTechData";
	document.forms[0].hidBeanId.value="agrcommon";
	document.forms[0].hidSourceUrl.value="action/agr_comm_tech_asp.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}} else {
	
	ShowAlert(158);
}	
}

function onloading()
{	  
	
	if(sel_value!="" && sel_value!="0")
	{
	 	document.forms[0].select_qualified.value=sel_value;
	}
	else
	{
		document.forms[0].select_qualified.value=0;
	}
	if(varloanfor!="")
	{
		document.forms[0].sel_loanfor.value=varloanfor;
	}
	callLoanfor();
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
		
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=flag;		  
		}
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

function callLoanfor()
{
	if(document.forms[0].sel_loanfor.value=="1")
	{
		document.all.tissuse1.style.visibility="visible";
		document.all.tissuse1.style.position="relative";
		document.all.tissuse2.style.visibility="visible";
		document.all.tissuse2.style.position="relative";
	}
	else
	{
		document.all.tissuse1.style.visibility="hidden";
		document.all.tissuse1.style.position="absolute";
		document.all.tissuse2.style.visibility="hidden";
		document.all.tissuse2.style.position="absolute";
		document.all.avg_sales.value="";
		document.all.txt_avg_production.value="";
	}
}
</script>
</head>
<body onload="onloading()">
<form method="post" class="normal"> 
<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
	<tr>
		<td valign="top" >
		
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr class="dataheader">
		<td valign="top" COLSPAN="3"  align="center">
		<B>Technical Details </B>
		</td>
	</tr>
	<tr>
		<td valign="top" WIDTH="8%">&nbsp;</td>
		<td valign="top" WIDTH="48%">Loan For</td>
		<td valign="top" WIDTH="44%"><SELECT name="sel_loanfor" onchange="callLoanfor()">
			<option value="0">----Select-----</option>
			<option value="1">Tissue culture</option>
			<option value="2">Others</option>
		</SELECT></td>
	</tr>
	<tr>
		<td valign="top" WIDTH="8%">&nbsp;</td>
		<td valign="top" WIDTH="48%">Whether the borrower is technically
		qualified ?</td>
		<td valign="top" WIDTH="44%"><SELECT name="select_qualified">
			<option value="0">----Select-----</option>
			<option value="1">YES</option>
			<option value="2">NO</option>
		</SELECT></td>
	</tr>
	<tr>
		<td valign="top" WIDTH="8%">&nbsp;</td>
		<td valign="top" WIDTH="48%">Remarks</td>
		<td valign="top" WIDTH="44%"><textarea name="txtarea_variety_corp"
			cols="60" rows="6" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("txtarea_variety_corp"))%></textarea>
		</td>
	</tr>
	<tr id="tissuse1">
		<td valign="top" WIDTH="8%">&nbsp;</td>
		<td valign="top" WIDTH="48%">Average production of plant through
		Tissue culture per month/year</td>
		<td valign="top" WIDTH="44%"><INPUT TYPE="text"
			NAME="txt_avg_production" maxlength="20"
			value="<%=Helper.correctNull((String)hshValues.get("txt_avg_production"))%>">
		</td>
	</tr>
	<tr id="tissuse2">
		<td valign="top" WIDTH="8%">&nbsp;</td>
		<td valign="top" WIDTH="48%">Average sale price per plant</td>
		<td valign="top" WIDTH="44%"><lapschoice:CurrencyTag name="avg_sales"
			maxlength="15" value='<%=Helper.correctNull((String) hshValues.get("avg_sales"))%>'
			other="readOnly" /></td>
	</tr>
	<tr>
		<td valign="top" COLSPAN="3"><span class="mantatory">
		<B>Note : </B><FONT SIZE="4">This information is additional. No
		value will be taken for calculation of economics</FONT></span><BR>
		
		</td>
	</tr>
</table>
</td>
	</tr>
</table>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
	<input type="hidden" name="hidRecordflag" > 
</form>
</body>
</html>

