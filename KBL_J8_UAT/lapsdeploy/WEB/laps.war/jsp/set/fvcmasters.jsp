<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
int intsize=0;
if (hshValues != null) {
	arrRow = (ArrayList) hshValues.get("arrRow");
}
%>
<html>
<head>
<title>FVC Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varchkbox="<%=Helper.correctNull((String)hshValues.get("strChkbox"))%>";
var varstrsel="<%=Helper.correctNull((String)hshValues.get("strTenor"))%>";
function onload()
{
	disablefields(true);
	if(varchkbox=="TP")
	{
		document.forms[0].rad[1].checked=true;
	}else if(varchkbox=="RP")
	{
		document.forms[0].rad[2].checked=true;
	}else
	{
		document.forms[0].rad[0].checked=true;
	}
	if(varstrsel!="")
	{
		document.forms[0].seltenor_range.value=varstrsel;
	}
	if(document.forms[0].rad[0].checked==true)
	{
		document.all.iddefault.style.visibility="visible";
		document.all.iddefault.style.position="relative";
		document.all.idtenor.style.visibility="hidden";
		document.all.idtenor.style.position="absolute";
		document.all.idrating.style.visibility="hidden";
		document.all.idrating.style.position="absolute";
	}
	else if(document.forms[0].rad[1].checked==true)
	{
		document.all.idtenor.style.visibility="visible";
		document.all.idtenor.style.position="relative";
		document.all.iddefault.style.visibility="hidden";
		document.all.iddefault.style.position="absolute";
		document.all.idrating.style.visibility="hidden";
		document.all.idrating.style.position="absolute";
	}
	else 
	{
		document.all.idrating.style.visibility="visible";
		document.all.idrating.style.position="relative";
		document.all.iddefault.style.visibility="hidden";
		document.all.iddefault.style.position="absolute";
		document.all.idtenor.style.visibility="hidden";
		document.all.idtenor.style.position="absolute";
	}
	document.forms[0].seltenor_range.disabled=false;
	
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getFVCMaster";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].action=appURL+"action/fvcmasters.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
		 	document.forms[0].submit();
	 	}
}

function doEdit()
{

	document.forms[0].hidAction.value="insert";
	enableButtons(true,false,false,false,true);
	document.forms[0].txtproposedpremiumdp.readOnly=false;
	document.forms[0].txtamtfrom.readOnly=false;
	document.forms[0].txtamtto.readOnly=false;
	document.forms[0].txtproposedpremiumtp.readOnly=false;
	for(j=0;j<7;j++){
	document.forms[0].txtproposedpremiumrp[j].readOnly=false;
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateFVCMaster";
	document.forms[0].hidBeanGetMethod.value="getFVCMaster";
	document.forms[0].hidSourceUrl.value="/action/fvcmasters.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateFVCMaster";
	document.forms[0].hidBeanGetMethod.value="getFVCMaster";
	document.forms[0].hidSourceUrl.value="/action/fvcmasters.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function funchange()
{
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getFVCMaster";
	document.forms[0].action=appURL+"action/fvcmasters.jsp";
	document.forms[0].submit();
}

function getValue()
{
	selindex=document.forms[0].seltenor_range[document.forms[0].seltenor_range.selectedIndex].value;
	if(selindex=='')		
	{	
		ClearValues();
		disablefields(true);
		enableButtons(false,true,true,true,false);
		document.forms[0].seltenor_range.disabled=false;
	}
	else if(selindex==0)
	{
		ClearValues();
		disablefields(false);
		enableButtons(true,false,false,false,true);
		document.forms[0].hidAction.value="new";
	}
	else
	{
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getFVCMaster";
		document.forms[0].action=appURL+"action/fvcmasters.jsp";
		document.forms[0].submit();
	}
}
function ClearValues()
{
	document.forms[0].txtproposedpremiumtp.value="";
	document.forms[0].txtamtfrom.value="";
	document.forms[0].txtamtto.value="";
}
</script>
</head>
<body onload=" onload();">
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; FVC Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="21" />
		</jsp:include></td>
	</tr>
</table>

<br>
<table width="90%" border="0" cellspacing="1" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="5"
					class="outertable">
					<tr>
						<td><input type="radio" name="rad" value="DP"
							onClick="funchange()" style="border-style: none"
							checked="checked">&nbsp;</td>
						<td>Default Premium</td>
						<td><input type="radio" name="rad" value="TP"
							onClick="funchange()" style="border-style: none">&nbsp;</td>
						<td>Tenor Premium</td>
						<td><input type="radio" name="rad" value="RP"
							onClick="funchange()" style="border-style: none">&nbsp;</td>
						<td>Rating Premium</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id="iddefault" style="visibility: hidden;position:absolute;">
		<td>
		<table width="80%" border="0px" cellspacing="1" cellpadding="5"
			class="outertable" align="center">
			<tr>
				<td>Proposed Premium (%)</td>
				<td><input type="text" name="txtproposedpremiumdp" maxlength="7" size="15" onkeypress="allowNumber(this);" style="text-align: right;" onblur="roundtxt(this);checkPercentage(this);" value="<%=Helper.correctNull((String)hshValues.get("strPremiumAmtDP")) %>">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id="idtenor" style="visibility: hidden;position:absolute;">
		<td>
		<table width="80%" border="0" cellspacing="1" cellpadding="5"
			class="outertable" align="center">
			<tr>
			<td width="25%">Select Tenor Range</td>
					<td width="75%" colspan="4">
						<select name="seltenor_range" style="width: 250px" onChange="getValue()">
						<%if(Helper.correctNull((String)hshValues.get("strChkbox")).equalsIgnoreCase("TP")){ %>
							<lapschoice:fvctenortag pageid='TP'/>
							<%}else{ %>
							<option value="0"><--Select--></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<td>Tenor From</td>
					<td>
						<input type="text" name="txtamtfrom" maxlength="4"
							size="10" onkeydown="allowNumber(this);"
							 value="<%=Helper.correctNull((String)hshValues.get("strTenorfrom")) %>">
					</td>
					<td>Tenor To</td>
					<td>
						<input type="text" name="txtamtto" maxlength="4"
							size="10" onkeydown="allowNumber(this);"
							 value="<%=Helper.correctNull((String)hshValues.get("strTenorto")) %>">
					</td>
				</tr>
			<tr>
				<td>Proposed Premium (%)</td>
				<td><input type="text" name="txtproposedpremiumtp" size="15"  maxlength="7" onkeypress="allowNumber(this);" style="text-align: right;" onblur="roundtxt(this);checkPercentage(this);"
				 value="<%=Helper.correctNull((String)hshValues.get("strPremiumAmtTP")) %>">
				</td>
				<td colspan="2">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id="idrating" style="visibility: hidden;position:absolute; ">
		<td>
		<%if(arrRow!=null && arrRow.size()>0){
		intsize=arrRow.size();%>
		<table width="80%" border="0" cellspacing="1" cellpadding="5"
			class="outertable" align="center">
			
				<%for(int i=0;i<arrRow.size();i++){
				arrCol=(ArrayList)arrRow.get(i);
				if(arrCol!=null && arrCol.size()>0){
				if(i==0){%>
				<tr align="center" class="dataheader">
				<td width="5%">S.No</td>
				<td  width="30%">Rating</td>
				<td  width="20%">Proposed Premium (%)</td>
				</tr>
				<%}%>
			<tr align="center"  class="datagrid">
				<td><%=i+1 %></td>
				<td><input type="text" name="txtratdescrp" size="30" value="<%=Helper.correctNull((String)arrCol.get(0)) %>" style="text-align: left;"></td>
				<td><input type="text" name="txtproposedpremiumrp" maxlength="7" size="15" onkeypress="allowNumber(this)" style="text-align: right;" onblur="roundtxt(this);checkPercentage(this);" value="<%=Helper.correctNull((String)arrCol.get(1)) %>">
				</td>
			</tr>
			<%}} %>
			
		</table>
		<%} else{
		for(int i=0;i<7;i++){%>
		<input type="hidden" name="txtproposedpremiumrp" >
		<%}} %>
		</td>
	</tr>
</table>

<br>

<input type="hidden" name="txtarrlen" value="<%=intsize %>">
 <lapschoice:hiddentag
	pageid="<%=PageId%>" /> 
<table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>