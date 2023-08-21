<%@include file="../share/directives.jsp"%>
<%
String strStatus=Helper.correctNull((String)hshValues.get("STATUS"));
String strRemarks=Helper.correctNull((String)hshValues.get("REMARKS"));
String strAuthFlag=Helper.correctNull((String)hshValues.get("AUTH_FLAG"));
String strBranchHead=Helper.correctNull((String)hshValues.get("strBranchHead"));
String strSegType= (String) session.getAttribute("SegType");
String strLapsStatus=Helper.correctNull((String)hshValues.get("HidLapsStatus"));
String APIresp=Helper.correctNull((String)hshValues.get("respmesg"));
String showDisbMsg = Helper.correctNull((String)hshValues.get("showDisbMsg"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setglp.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varStatus="<%=strStatus%>";
var varRemarks="<%=strRemarks%>";
var varBranchHead="<%=strBranchHead%>";
var varOrgLevel="<%=strOrgLevel%>";
var varAuthFlag="<%=strAuthFlag%>";
var varLapsStatus="<%=strLapsStatus%>";
var showDisbMsg = "<%=showDisbMsg%>";

function callclose()
{
	window.opener.document.forms[0].action = appURL+"action/npInbox.jsp";
	window.opener.document.forms[0].hidBeanGetMethod.value="PSB59getApplicationDetailsList";
	window.opener.document.forms[0].hidBeanId.value="NationalPortal";
	window.opener.document.forms[0].submit();
	window.close();
}

function callOnLoad()
{
	

	var status="<%=APIresp%>";
	if(status!=""){
	alert(status);
	document.forms[1].cmdupdate.disabled = true;
	}	

	var Buttondisable="<%=Helper.correctNull((String) hshValues.get("FlagDisSTATUS"))%>";
	if(Buttondisable=="N"){
	document.forms[1].cmdAuthorize.disabled = true;
	}


	var hidLapStatus = parent.frames.window.opener.document.forms[0].hidlapstatus.value;
	document.forms[0].hidlapstatus.value = hidLapStatus;

	if(showDisbMsg!="")
	{
		alert(showDisbMsg);
		document.forms[0].txt_oldremarks.disabled=true;
		document.forms[0].sel_nsdlStatus.disabled=true;
		document.forms[0].txt_remarks.disabled=true;

		if(varOrgLevel == "A")
		{
		document.forms[0].cmdEdit.style.visibility="hidden";
		document.forms[0].cmdSave.style.visibility="hidden";
		document.forms[0].cmdCancel.style.visibility="hidden";
		}
		else if(varOrgLevel == "R" || varOrgLevel == "C")
		{
		document.forms[0].cmdEdit.style.visibility="hidden";
		document.forms[0].cmdAuthorize.style.visibility="hidden";
		document.forms[0].cmdCancel.style.visibility="hidden";
		}
	}
	
	document.forms[0].txt_oldremarks.disabled=true;
	document.forms[0].sel_nsdlStatus.disabled=true;
	document.forms[0].txt_remarks.disabled=true;
	document.forms[0].hidOldStatus.value = varStatus;
	
	if(varStatus==null || varStatus=="")
	{
	

	document.forms[0].sel_nsdlStatus.value="S";
	}
	else
	{
	
		
	document.forms[0].sel_nsdlStatus.value = varStatus;
	}
	
	
	document.forms[0].txt_oldremarks.value = varRemarks;
	

	/*if((varOrgLevel=="A" && varBranchHead == "Y") && (document.forms[0].hidlapstatus.value=="Rejection Recommended for RO" || document.forms[0].hidlapstatus.value=="Rejected"))
	{
		document.forms[0].cmdAuthorize.disabled = true;
	}*/
	callDisableButtons(false,true,true,false);
	
}
function callDisableButtons(cmdEdit,cmdSave,cmdCancel,cmdClose)
{
	
	document.forms[0].cmdEdit.disabled=cmdEdit;
	document.forms[0].cmdSave.disabled=cmdSave;	
	document.forms[0].cmdCancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function callEdit()
{
	document.forms[0].sel_nsdlStatus.disabled=false;
	document.forms[0].txt_remarks.disabled=false;
	callDisableButtons(true,false,false,false);
}

function callCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].txt_remarks.value = "";
	callOnLoad();
	}
}
function callSave()
{
	if(document.forms[0].sel_nsdlStatus.value=="S" || document.forms[0].sel_nsdlStatus.value=="")
	{
       alert("Please Select the National Portal Status");
       return false;
	}

	if(document.forms[0].txt_remarks.value=="")
	{
       alert("Please Enter the Remarks");
       return false;
	}

	if(document.forms[0].hidlapstatus.value=="Hold" && document.forms[0].sel_nsdlStatus.value=="104")
	{
       alert("Hold Applications cannot be done as Authorize Reject");
       return false;
	}

	if(document.forms[0].hidlapstatus.value=="Reject" && document.forms[0].sel_nsdlStatus.value=="105")
	{
       alert("Reject Applications cannot be done as Hold");
       return false;
	}

	
	document.forms[0].hidBeanId.value="NationalPortal";
   	document.forms[0].hidSourceUrl.value="/action/psb59HoldReject.jsp";
	document.forms[0].hidBeanMethod.value="updatePSB59HoldRejStatus";
	document.forms[0].hidBeanGetMethod.value="PSB59getHoldRejStatus";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

	alert("Saved Successfully");

	callOnLoad();
}

function callAuthorize()
{
	if(document.forms[0].sel_nsdlStatus.value=="S" || document.forms[0].sel_nsdlStatus.value=="")
	{
       alert("Please Select the National Portal Status");
       return false;
	}

	else if(document.forms[0].txt_remarks.value=="")
	{
       alert("Please Enter the Remarks");
       return false;
	}

	else if(document.forms[0].hidlapstatus.value=="Rejection" && document.forms[0].sel_nsdlStatus.value=="105")
	{
       alert("Application has been Marked as Reject, Kindly Authorize Reject");
       return false;
	}

	else if(document.forms[0].hidlapstatus.value=="Hold" && document.forms[0].sel_nsdlStatus.value=="104")
	{
       alert("Hold Applications cannot be done as Authorize Reject");
       return false;
	}

	
	else if(document.forms[0].hidlapstatus.value=="Hold" && varAuthFlag == "Y")
	{
       alert("Application has already been Hold");
       return false;
	}
	
	
// Status Updation for Online Portal
	
	if(document.forms[0].sel_nsdlStatus.value=="104" && (varOrgLevel=="C" || varOrgLevel=="R"))//Reject
	{
		document.forms[0].hidAppStatus.value = "04";
		document.forms[0].hidOnlinestatus.value = "Y";
	}
	else if(document.forms[0].hidlapstatus.value=="Hold")//Hold
	{
		document.forms[0].hidAppStatus.value = "05";
		document.forms[0].hidHoldAuth.value = "Y";
		document.forms[0].hidOnlinestatus.value = "Y";
	}
	else
	{
	}
	
	
	alert(document.forms[0].hidApplicantId.value);
	document.forms[0].hidBeanId.value="NationalPortal";
   	document.forms[0].hidSourceUrl.value="/action/psb59HoldReject.jsp";
	document.forms[0].hidBeanMethod.value="updatePSB59HoldRejStatus";
	document.forms[0].hidBeanGetMethod.value="PSB59getHoldRejStatus";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

	alert("Saved Successfully");

	callOnLoad();
}
</script>
<style>

</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
</head>
<body onload=callOnLoad() >
<form name="appform" method="post" action=""> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
  <td>
   <table width="80%" border="0">
		<tr>
		<td>
		National Portal Status</td>
		<td>
		<select name="sel_nsdlStatus" style="text-align: center">
		    <option value="S">--Select--</option>
		    <option value="105">Hold</option>
		    <option value="102">Rejection</option>
		</select>
		
		</td>
		</tr>
	</table>
  </td>
</tr>
<tr>
  <td>
	<table width="100%" border="0">
	<tr class="dataheader" align="center">
	  <td><font size="2" face="Trebuchet MS"><b>Remarks </b></font></td>
	</tr>
	<tr>
		<td align="center">
		 <TEXTAREA name="txt_remarks" COLS="120"  ROWS="8"></TEXTAREA>		
		</td>
	</tr>
	<tr>
		<td>Previous Remarks</td>
	</tr>
	<tr>
		<td align="center">
		  <TEXTAREA name="txt_oldremarks" COLS="120" ROWS="8"></TEXTAREA>
		</td>
	</tr>
	</table>
 </td>
</tr>
<tr>
 <td>
   <table width="20%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
       <tr>
			<td><input type="button" name="cmdEdit" value="Edit"
			class="buttonStyle"  onClick="javascript:callEdit();"></td>
			<%if(strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R") || (strBranchHead.equalsIgnoreCase("Y") && strLapsStatus.equalsIgnoreCase("Hold"))){%>
			<td><input type="button" name="cmdAuthorize" value="Authorize"
		 class="buttonStyle"  onClick="javascript:callAuthorize();"></td>
			<%}%>
			<%if(!(strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R"))){%>
			<%if(!(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("Y") && strLapsStatus.equalsIgnoreCase("Hold"))) {%>
			<td><input type="button" name="cmdSave" value="Save"
			class="buttonstyle"  onClick="javascript:callSave();"></td>
			<%}}%>
			<td><input type="button" name="cmdCancel" value="Cancel"
			class="buttonstyle"  onClick="javascript:callCancel();"></td>
			<td><input type="button" name="cmdClose" value="Close"
			class="buttonClose" onClick="callclose();"></td>
		</tr>
   </table>
  </td>
</tr>


</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanMethod" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidApplicantId" value="<%=Helper.correctNull((String) hshValues.get("hidApplicantId"))%>">
    <input type="hidden" name="hidSourceUrl" value="">
    <input type="hidden" name="hidOldStatus" value="">
    <input type="hidden" name="hidOldRemarks" value="">
    <input type="hidden" name="hidAppStatus" value="">
    <input type="hidden" name="hidlapstatus" value="">
    <input type="hidden" name="hidOnlinestatus" value="">
    <input type="hidden" name="hidHoldAuth" value="">
</form>
</body>
</html>

