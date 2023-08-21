<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//out.print(hshValues);

	String DEV_TYPE=Helper.correctNull((String) hshValues.get("DEV_TYPE"));
	String DEV_SUBTYPE=Helper.correctNull((String) hshValues.get("DEV_SUBTYPE"));
	String DEV_WHTCUSAVAIL=Helper.correctNull((String) hshValues.get("DEV_WHTCUSAVAIL"));
	String DEV_CBSID=Helper.correctNull((String) hshValues.get("DEV_CBSID"));
	String DEV_DEVPARAM=Helper.correctNull((String) hshValues.get("DEV_TYPE"));

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Deviation Parameters</title>
<SCRIPT LANGUAGE="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
var strOrgcode="<%=Helper.correctNull((String) session.getAttribute("strOrgCode"))%>";
var DEV_TYPE="<%=DEV_TYPE%>";
var DEV_SUBTYPE="<%=DEV_SUBTYPE%>";
var DEV_WHTCUSAVAIL="<%=DEV_WHTCUSAVAIL%>";
var DEV_DEVPARAM="<%=DEV_DEVPARAM%>";

function loadPermSubtype()
{
	var varpermissionType = document.forms[0].sel_perm_type.options[document.forms[0].sel_perm_type.selectedIndex].value;
	document.all.ifrmpermissiontype.src = appURL
			+ "action/ifrmDeviationdataload.jsp?hidBeanGetMethod=getPermissiontypeData&hidBeanId=perDeviation&permtype="
			+ varpermissionType+"&pagefrom=permParam1";

	document.forms[0].sel_devSubType.value="S";
	loadPermParameter();
	if(varpermissionType=="1")
	{
		document.all.id_cusID.style.display="table-row";
		document.all.id_wthCusAvail.style.display="none";
	}
	else if(varpermissionType=="2")
	{
		document.all.id_cusID.style.display="none";
		document.all.id_wthCusAvail.style.display="table-row";
	}
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?hidPagename=DeviationParameter";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}

function chngeCusAvail()
{
	var varcusavail= document.forms[0].sel_cus_available.value; 
	if(varcusavail=="Y")	
	{	
		document.all.id_cusID.style.display="table-row";
	}
	else
	{
		document.all.id_cusID.style.display="none";
	}
	
}

function onload()
{
	document.all.id_cusID.style.display="none";
	document.all.id_wthCusAvail.style.display="none";

	 document.forms[0].cmdsave.disabled=false;
	
}
function loadPermParameter()
{
	var devsubtype=document.forms[0].sel_devSubType.value; 
	document.all.ifrmpermissionSubtype.src = appURL
	+ "action/ifrmDeviationdataload.jsp?hidBeanGetMethod=getPermissiontypeData&hidBeanId=perDeviation&devsubtype="+devsubtype+"&pagefrom=permParam2";

	
}
function clearrows(tabid)
{
	var table=document.getElementById(tabid);
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
}

function callFacsnoChk()
{
	var varParam="";
	var varParameters="";
	if(document.forms[0].chkFac.length!=undefined)
	{
		var vararrsize=eval(document.forms[0].chkFac.length);
		for(var j=0;j<vararrsize;j++)
		{
			var vartemp2="document.forms[0].chkFac"+"["+j+"]";
			if(eval(vartemp2).checked)
			{
				varParam1=eval(vartemp2).value;
				varParameters=varParameters+varParam1+"@";
			}
		}
	}
	else
	{
		if(document.forms[0].chkFac.checked)
		{
			varParameters=document.forms[0].chkFac.value+"@";
		}
	}
	if(varParameters=="")
	{
		alert("Please Select Any one Parameter");
		document.forms[0].hidParameter.value="";
		return false;
	}
	document.forms[0].hidParameter.value=varParameters;
}


function doSave()
{
	

	if(document.forms[0].sel_perm_type.value=="S")
	{
		ShowAlert('121',"Permission Type");
		document.forms[0].sel_perm_type.focus();
		return false;
	}
	if(document.forms[0].sel_devSubType.value=="S")
	{
		ShowAlert('121',"Permission Subtype");
		document.forms[0].sel_devSubType.focus();
		return false;
	}

	if(document.forms[0].sel_perm_type.value=="2")
	{
		if(document.forms[0].sel_cus_available.value=="S")
		{
			ShowAlert('121',"Whether customer id available");
			document.forms[0].sel_cus_available.focus();
			return false;
		}

		if(document.forms[0].sel_cus_available.value=="Y")
		{
			if(document.forms[0].txt_cbscustid.value=="")
			{
				ShowAlert('111',"Customer ID");
				document.forms[0].txt_cbscustid.focus();
				return false;
			}
		}
	}
	if(document.forms[0].sel_perm_type.value=="1")
	{
		if(document.forms[0].txt_cbscustid.value=="")
		{
			ShowAlert('111',"Customer ID");
			document.forms[0].txt_cbscustid.focus();
			return false;
		}
	}
	
	var varpara=document.forms[0].hidParameter.value;
	if(document.forms[0].hidParameter.value=="")
	{
		alert("Please select atleast one Parameter");
		return;
	}
	document.forms[0].hidAction.value = "new";
	document.forms[0].hidBeanGetMethod.value="updatePermissionData";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].action=appURL+"action/permission_gist.jsp";	
	document.forms[0].submit();	
}
function doClose()
{
	var varconfirm=ConfirmMsg('100');
	if(varconfirm)
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload()">
<form method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">  
		Home -&gt; Permission -&gt; New Permission
		</td>
	</tr>
</table>

<table width="100%"  border="0" cellspacing="0" cellpadding="0"  class="outertable border1 tableBg">
		<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	class="outertable">
				<tr>
				<td valign="top">
					<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td width="25%">Permission Type </td>		
						<td width="25%">
							<select name="sel_perm_type" onchange="loadPermSubtype()">
									<option selected value="S">--Select--</option>
										<%
							String parentType="0";
							%>
							<lapschoice:PermPmayMaster  value='<%=parentType %>'/>
							</select>
						</td>
					</tr>
					<tr>
						<td>Permission Subtype </td>
						<td>
							<select name="sel_devSubType" onchange="loadPermParameter()">
								<option selected value="S">--Select--</option>
							</select>
						</td>
					</tr>
					<tr id="id_wthCusAvail">
						<td>Whether customer id available </td>
						<td><select name="sel_cus_available" onchange="chngeCusAvail()">
									<option selected value="S">--Select--</option>
									<option value="Y">Yes </option>
									<option value="N">No</option>
					 		</select>
						</td>
					</tr>
					<tr id="id_cusID">
						<td>Customer ID </td>
						<td width="34%" id="custid1"><input type="text"
						name="txt_cbscustid" size="12" maxlength="10" readOnly="readOnly" 
						value="<%=Helper.correctNull((String)hshValues.get("DEV_CBSID"))%>">
						<b><span onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0"></span></b></td>
						
					</tr>
					</table>
				</td>
				</tr>
			</table>
		</td>
	 </tr>
</table>


<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
	<td valign="middle"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3" id="tab_permParam">
			<tr class="dataheader">
				<td colspan="8">PERMISSION PARAMETERS&nbsp;&nbsp;<input type="hidden"  name="hidSno" value=""></td>
			</tr>
						
				
						
						
						
		</table>
	</td>
</tr>
</table>

<br>
<input type="hidden" name="hidParameter" value="<%=Helper.correctNull((String)hshValues.get("strSanctionTerms"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />


<lapschoice:combuttonnew btnnames='Save' btnenable='N' />

<iframe	height="0" width="0" id="ifrmpermissiontype" frameborder=0 style="border: 0"></iframe>
<iframe	height="0" width="0" id="ifrmpermissionSubtype" frameborder=0 style="border: 0"></iframe>

</form>
</body>
</html>