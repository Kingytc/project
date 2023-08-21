<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
int intsize=0;
if (hshValues != null) {
	arrRow = (ArrayList) hshValues.get("arrRow");
}
String LoginType=Helper.correctNull((String)session.getAttribute("Logintype"));
String strUserID=Helper.correctNull((String)session.getAttribute("strUserId")) ;
%>
<html>
<head>
<title>AFO set Branch </title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgCode="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>";
var varPendingProp="<%=Helper.correctNull((String)hshValues.get("mailboxcount"))%>";
var varKalyptoPending="<%=Helper.correctNull((String)hshValues.get("strKalyptoFlag"))%>";
var varHomeFlag="<%=Helper.correctNull((String)hshValues.get("strHomeFlag"))%>";
var varClusterFlag="<%=Helper.correctNull((String)hshValues.get("strClusterFlag"))%>";
function onload()
{
	var varFlag=true;
	for(var i=0;i<document.forms[0].selcluster_name.options.length;i++)
	{
		if(document.forms[0].selcluster_name.options[i].value==varOrgCode)
	  	{	
			 document.forms[0].selcluster_name.options[i].selected=true;
			 varFlag=false;
			 break;
		}
	}
	if(varFlag)
	{
		document.forms[0].selcluster_name.options[0].selected=true;
	}
	if(varHomeFlag=="Y")
	{
		alert("The User Location Successfully changed back to Home Branch.Please Login Again to Access LAPS");
		 callLogout();
	}
	if(varClusterFlag=="Y")
	{
		alert("The User Location Successfully changed to Cluster Branch.Please Login Again to Access LAPS");
		callLogout();
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
function doChangeLocation()
{
	if(varPendingProp=="N")
	{
		if(varKalyptoPending=="N")
		{
			if(confirm("Do you want to change the Location"))
			{
				document.forms[0].hidAction.value="ClusterBranch";
				document.forms[0].hidBeanId.value="staticdata";
				document.forms[0].hidBeanGetMethod.value="updateAFOClusterBranchSelection";
				document.forms[0].action=appURL+"action/afosetbranch.jsp";
				document.forms[0].submit();
			}
		}
		else
		{
			alert("Some proposals are Pending in Kalypto.You can't Change the Location");
		    return;
		}
	}
	else
	{
		alert("User Location cannot be modified as there some proposals in the user login. Kindly transfer the same");
	    return;
	}
}
function doGoBackToHomeBranch()
{
	if(varPendingProp=="N")
	{
		if(varKalyptoPending=="N")
		{
			if(confirm("Do you want to change the Location back to Home branch"))
			{
				document.forms[0].hidAction.value="HomeBranch";
				document.forms[0].hidBeanId.value="staticdata";
				document.forms[0].hidBeanGetMethod.value="updateAFOClusterBranchSelection";
				document.forms[0].action=appURL+"action/afosetbranch.jsp";
				document.forms[0].submit();
			}
		}
		else
		{
			alert("Some proposals are Pending in Kalypto.You can't change the Location  back to Home Branch");
		    return;
		}
	}
	else
	{
		alert("User Location cannot be modified as there some proposals in the user login. Kindly transfer the same");
	    return;
	}
}
function callLogout()
{
	parent.topFrame.callLogout();
}
</script>
</head>
<body onload=" onload();">
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; AFO Probationary</td>
	</tr>
</table>

<br>
<table width="90%" border="0" cellspacing="1" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="80%" border="0" cellspacing="1" cellpadding="5"
			class="outertable" align="center" height="200px">
			<tr>
				<td>
				<table width="50%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
					<tr  class="dataheader">
					<td colspan="2" align="center">&nbsp;APO Branch Selection</td>
					</tr>
					<tr  class="datagrid">
					<td width="10%">Select Cluster Branch Name </td>
					<td width="10%" align="center"><select name="selcluster_name">
					<option value=""><--Select--></option>
					<lapschoice:afoclusterbranch  apptype="<%=strUserID%>"/>
					</select>
					 </td>
					</tr>
					<tr>
					<td colspan="2"><lapschoice:combuttonnew btnnames="Change Location_Go Back to Home Branch"
						btnenable='<%=Helper.correctNull((String) request
										.getParameter("btnenable"))%>' />
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
