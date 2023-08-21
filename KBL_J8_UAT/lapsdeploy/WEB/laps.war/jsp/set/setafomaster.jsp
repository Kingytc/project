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
<title>AFO set Branch Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varAFOName="<%=Helper.correctNull((String)hshValues.get("strAFOUserID"))%>";
var varAFOHeadBranch="<%=Helper.correctNull((String)hshValues.get("strAFOHomeBranch"))%>";
var varAFOClusterBranch="<%=Helper.correctNull((String)hshValues.get("strClusterBranch"))%>";
function onload()
{
	if(varAFOName!="")
	{
		document.forms[0].selafo_name.value=varAFOName;
	}
	else
	{
		document.forms[0].selafo_name.value="";
	}
	if(varAFOHeadBranch!="")
	{
		document.forms[0].selafo_homebranch.value=varAFOHeadBranch;
	}
	else
	{
		document.forms[0].selafo_homebranch.value="";
	}

	if(varAFOClusterBranch!="")
	{
		var arrAFOClusterBranch =varAFOClusterBranch.split("@");
		for(var i=0;i<arrAFOClusterBranch.length-1;i++)
		{
			var varoption=arrAFOClusterBranch[i];
			for(var m=0;m<document.forms[0].selafo_clusterbranch.options.length;m++)
			{
				if(document.forms[0].selafo_clusterbranch.options[m].value==varoption)
			  	{	
					 document.forms[0].selafo_clusterbranch.options[m].selected=true;
					 break;
				}
			}
		}
	}
	disablefields(true);
	document.forms[0].selafo_name.disabled=false;
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
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
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
	document.forms[0].hidBeanGetMethod.value="getAFOSetBranchMaster";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].action=appURL+"action/setafomaster.jsp";
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

function doEdit()
{
	if(document.forms[0].selafo_name.value=="")
	{
		alert("Select the AFO user ID");
		return;
	}
	disablefields(false);
	document.forms[0].hidAction.value="insert";
	enableButtons(true,false,false,false,true);
	document.forms[0].selafo_name.disabled=true;
}

function doSave()
{
	if(document.forms[0].selafo_homebranch.value=="")
	{
		alert("Select the Home Branch Name");
		document.forms[0].selafo_homebranch.focus();
		return false;
	}

	var varcode ="";
	for(var i=0;i<document.forms[0].selafo_clusterbranch.options.length;i++)
	{
		if(document.forms[0].selafo_clusterbranch.options[i].selected)
		{				
			varcode=varcode+document.forms[0].selafo_clusterbranch.options[i].value+"@";
		}		
	}
	
	if(varcode=="")
	{
		alert("Select the Cluster Branch Name");
		return false;
	}
	disablefields(false);
	document.forms[0].hidClusterOrgcode.value=varcode;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateAFOSetBranchMaster";
	document.forms[0].hidBeanGetMethod.value="getAFOSetBranchMaster";
	document.forms[0].hidSourceUrl.value="/action/setafomaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(document.forms[0].selafo_name.value!="")
	{
		if(ConfirmMsg(101))
		{
			disablefields(false);
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanMethod.value="updateAFOSetBranchMaster";
			document.forms[0].hidBeanGetMethod.value="getAFOSetBranchMaster";
			document.forms[0].hidSourceUrl.value="/action/setafomaster.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
}
function funchange()
{
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getAFOSetBranchMaster";
	document.forms[0].action=appURL+"action/setafomaster.jsp";
	document.forms[0].submit();
}

</script>
</head>
<body onload=" onload();">
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Other Setup -&gt; AFO Set Branch Master</td>
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
				<table width="50%" border="0" cellspacing="1" cellpadding="5" align="center" style="border: 1px solid #dcbad8;">
				<tr class="dataheader">
				<td colspan="2">AFO Master&nbsp;</td>
				</tr>
					<tr class="datagrid">
					<td width="10%">AFO Name </td>
					<td width="10%"><select name="selafo_name" onchange="funchange();">
					<option value=""><--Select--></option>
					<lapschoice:afouserslist />
					</select>
					 </td>
					</tr>
					<tr  class="datagrid">
					<td>AFO Home Branch Name </td>
					<td><select name="selafo_homebranch">
					<option value=""><--Select--></option>
					<lapschoice:branchlist />
					</select>
					 </td>
					</tr>
					<tr  class="datagrid">
					<td>Cluster Branch </td>
					<td><select name="selafo_clusterbranch" multiple>
					<lapschoice:branchlist />
					</select><input type="hidden" name="hidClusterOrgcode" value="<%=Helper.correctNull((String)hshValues.get("hidRepaymentType")) %>">
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

 <lapschoice:hiddentag pageid="<%=PageId%>" /> 
<table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>