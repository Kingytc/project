<%
/**
*@author: S.SATHYA MOORTHY
*@since :17/12/2008
*@todo  :For Renewal Details(deposits)
*
*/
%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror/>
<html>
<head>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";	
function onloading()
{
  disableFields(true);
  document.forms[0].cmdsave.disabled=true;	
  document.forms[0].cmdcancel.disabled=true;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=val
		}
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=(val);
		}	 
	}
}

function doEdit()
{
    disableFields(false);
    document.forms[0].cmdedit.disabled=true;
    document.forms[0].cmdclose.disabled=true;
    document.forms[0].cmddelete.disabled=false;
    document.forms[0].cmdsave.disabled=false;
    document.forms[0].cmdcancel.disabled=false;
    document.forms[0].hidAction.value="update";
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
  	document.forms[0].action=appURL+"controllerservlet";	
    document.forms[0].hidSourceUrl.value="/action/per_renewal_details.jsp";
	document.forms[0].hidBeanMethod.value="updateRenewalDetails";
	document.forms[0].hidBeanGetMethod.value="getRenewalDetails";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].method="post";			
	document.forms[0].submit();	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
	    document.forms[0].action=appURL+"controllerservlet";	
	    document.forms[0].hidSourceUrl.value="/action/per_renewal_details.jsp";
		document.forms[0].hidBeanMethod.value="updateRenewalDetails";
		document.forms[0].hidBeanGetMethod.value="getRenewalDetails";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
	    document.forms[0].action=appURL+"action/per_renewal_details.jsp";	
	    document.forms[0].hidBeanGetMethod.value="getRenewalDetails";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doClose()
{
  if(confirm("Do you want to close this window"))
  {
     window.close();
  }
}
</script>
</head>
<body  onload="onloading()">
<form class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><laps:application /></td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="2" align="center"><b>Renewal Details</b></td>
    </tr>
    <tr> 
      <td width="32%">Compliance to Term of Sanction</td>
      <td width="60%"> 
        <textarea cols=90 rows=6 name="txtarea_compliance" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txtarea_compliance"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="32%">Whether Documents valid and In Force</td>
      <td width="60%"> 
        <textarea cols=90 rows=6 name="txtarea_documents" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txtarea_documents"))%></textarea>
    </tr>
    <tr> 
      <td width="32%">Whether FDR/DRCs/CUMULATIVE DEPOSTS etc .are renewed and duly discharged along with letter of Lien</td>
      <td width="60%"> 
        <textarea cols=90 rows=6 name="txtarea_fdr" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txtarea_fdr"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="32%">Audit Observations and Compliance </td>
      <td width="60%"> 
        <textarea cols=90 rows=6 name="txtarea_audit" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txtarea_audit"))%></textarea>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <laps:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
      </table>
<laps:hiddentag/>
</form>
</body>
</html>



