<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	ArrayList arrRow=new ArrayList();
	if (hshValues!=null && hshValues.size()>0)
	{
		arrRow =(ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RBI Guidelines for Restructuring</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varModule="<%=Helper.correctNull((String)hshValues.get("strModule"))%>";
var varCompliance="<%=Helper.correctNull((String)hshValues.get("strCompliance"))%>";
var mode="";
function callOnLoad()
{
	if(varModule!="")
	{
		document.forms[0].sel_Module.value=varModule;
	}
	else
	{
		document.forms[0].sel_Module.value="S";		
	}
	if(varCompliance!="")
	{
		document.forms[0].sel_compliances.value=varCompliance;
	}
	else
	{
		document.forms[0].sel_compliances.value="";		
	}
	disableFields(true);
	document.forms[0].sel_Module.disabled=false;
	document.forms[0].sel_compliances.disabled=false;
	disableButtons(false, true, true, true, true, false);
}
function doNew()
{	mode="N";
	document.forms[0].sel_Module.value="S";	
	document.forms[0].sel_compliances.value="";
	document.forms[0].sel_active.value="";	
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	disableButtons(true, true, false, false, true, true);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	document.forms[0].sel_Module.disabled=true;
	document.forms[0].sel_compliances.disabled=true;
	disableButtons(true, true, false, false, true, true);
}
function doSave()
{
	if(document.forms[0].sel_active.value=="")
	{
		ShowAlert('111','Active');
		document.forms[0].sel_active.focus();
		return;
	}
	document.forms[0].sel_Module.disabled=false;
	document.forms[0].sel_compliances.disabled=false;
	document.forms[0].sel_active.disabled=false;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setmodtermscond";
	document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
	document.forms[0].hidSourceUrl.value="/action/setrbiguidelines_restructuring.jsp";
	disableButtons(true, true, true, true, true, true);
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].action=appURL+"action/setrbiguidelines_restructuring.jsp";
		disableButtons(true, true, true, true, true, true);
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].sel_Module.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
		document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].hidSourceUrl.value="/action/setrbiguidelines_restructuring.jsp";
		disableButtons(true, true, true, true, true, true);
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function placeValues(sno,norm,selectvalue)
{
	document.forms[0].hidSNo.value=sno;
	document.forms[0].txt_guideliness.value=norm;
	document.forms[0].sel_active.value=selectvalue;
	disableButtons(true, false, true, true, false, true);
}
function disableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function getRBIGuidelines()
{
	if(document.forms[0].sel_Module.value!="" && document.forms[0].sel_Module.value!="S")
	{	
		if(mode!="N"){
		if(document.forms[0].sel_compliances.value!="")
		{
			document.forms[0].hidBeanId.value="setmodtermscond";
			document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
			document.forms[0].action=appURL+"action/setrbiguidelines_restructuring.jsp";
			document.forms[0].submit();
		}
		else
		{
			alert("Please Select Compliance");
			return;
		}
		}
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		 if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; General Setup -&gt; RBI Guidelines for Restructuring</td>
	</tr>
</table>
<br>
<table class="outertable" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
<tr>
	<td>
	<table class="outertable border1 tableBg" width="80%" border="0" cellpadding="5" cellspacing="1" align="center">
	<tr>
		<td>
			<table class="outertable" width="98%" border="0" cellpadding="12" cellspacing="5" align="center">
			<tr>
				<td width="50%" align="right">Loan Type</td>
				<td width="50%" align="left">
					<select name="sel_Module" onChange="getRBIGuidelines();" style="width: 120px">
						<option value="S">&nbsp;---Select---</option>
						<option value="P">&nbsp;Retail</option>
						<option value="A">&nbsp;AGRICULTURE</option>
						<option value="C">&nbsp;CORPORATE</option>
					</select>
				</td>
				<td width="50%" align="right">Compliances</td>
				<td width="50%" align="left">
					<select name="sel_compliances" onChange="getRBIGuidelines();" style="width: 120px">
						<option value="">&nbsp;---Select---</option>
						<option value="G">&nbsp;General Principles</option>
						<option value="S">&nbsp;Special Regulatory Norms</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<textarea name="txt_guideliness" cols="140" wrap="VIRTUAL" rows="5" onKeyPress="notAllowSingleQuote();NoallowEnterandDoubleQuote();textlimit(document.forms[0].txt_guideliness,'3999');" onKeyUp="textlimit(this,3999)"></textarea>
				</td>
			</tr>
			<tr>
			<td width="50%" align="right">Active</td>
				<td><select name="sel_active" style="width: 120px">
				<option value="">--Select--</option>
				<option value="E">Enable</option>
				<option value="D">Disable</option>
				</select>
				</td> 
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td>
		<table class="outertable" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
		<tr>
			<td>
			<br>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
				<tr>
					<td valign="top">
					<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete"
									btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
					</td>
				</tr>
				</table>
				<br>
				<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" height="100%">
				<tr>
					<td colspan="2" align="center" class="dataheader"><b>TAKE OVER NORMS</b></td>
				</tr>
				<%if(arrRow!=null && arrRow.size()>0){
					for(int i=0;i<arrRow.size();i++){
						ArrayList arrCol=new ArrayList();
						arrCol=(ArrayList)arrRow.get(i);
				%>
				<tr class="datagrid">
					<td width="5%" align="center">
						<input type="radio" name="termsel" value="radiobutton" style="border-style: none"
							onClick="placeValues('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>')">
					</td>
					<td width="95%">&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
				</tr>
				<%}}
				else{
				%>
				<tr class="datagrid">
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr class="datagrid">
					<td colspan="2" align="center"><b>--- No Records to display ---</b></td>
				</tr>
				<tr class="datagrid">
					<td colspan="2">&nbsp;</td>
				</tr>
				<%} %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidSNo" value="">
</form>
</body>
</html>