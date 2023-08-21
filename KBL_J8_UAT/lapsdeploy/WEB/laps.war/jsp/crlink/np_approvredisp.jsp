<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
String strStatus=Helper.correctNull((String)hshValues.get("STATUS"));
String strRemarks=Helper.correctNull((String)hshValues.get("REMARKS"));
String strAuthFlag=Helper.correctNull((String)hshValues.get("AUTH_FLAG"));
String strBranchHead=Helper.correctNull((String)hshValues.get("strBranchHead"));
String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
String strSegType= (String) session.getAttribute("SegType");
String strLapsStatus=Helper.correctNull((String)hshValues.get("HidLapsStatus"));
String showAlerMsg = Helper.correctNull((String)hshValues.get("showAlerMsg"));
String showDisbMsg = Helper.correctNull((String)hshValues.get("showDisbMsg"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varStatus="<%=strStatus%>";
var varRemarks="<%=strRemarks%>";
var varBranchHead="<%=strBranchHead%>";
var varOrgLevel="<%=strOrgLevel%>";
var varAuthFlag="<%=strAuthFlag%>";
var varLapsStatus="<%=strLapsStatus%>";
var showAlertMsg = "<%=showAlerMsg%>";
var showDisbMsg = "<%=showDisbMsg%>";

function callclose()
{
	window.opener.document.forms[0].hidBeanId.value="PSB59";
	window.opener.document.forms[0].hidBeanGetMethod.value="getNPInboxDetails";
	window.opener.document.forms[0].action = appURL+"action/psb59Inbox.jsp";
	window.opener.document.forms[0].submit();
	window.close();
}

function callOnLoad()
{	
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
}

function callEdit()
{
	document.forms[0].sel_nsdlStatus.disabled=false;
	document.forms[0].txt_remarks.disabled=false;
}

function callCancel()
{
	document.forms[0].txt_remarks.value = "";
	callOnLoad();
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

	if(document.forms[0].hidlapstatus.value=="Rejection Recommended for RO" && document.forms[0].sel_nsdlStatus.value=="105")
	{
       alert("Reject Applications cannot be done as Hold");
       return false;
	}

	if(document.forms[0].sel_nsdlStatus.value=="105" && (document.forms[0].hidlapstatus.value=="" || document.forms[0].hidlapstatus.value=="Hold") && varOrgLevel=="A" && varBranchHead == "Y")
	{
       alert("Application has not been Marked as Hold");
       return false;
	}

	if(document.forms[0].sel_nsdlStatus.value=="105" && (document.forms[0].hidlapstatus.value=="" || document.forms[0].hidlapstatus.value=="Hold") && (varOrgLevel=="C" || varOrgLevel=="R"))
	{
       alert("HO/RO/CO Users cannot Hold the Application");
       return false;
	}
	
	if(document.forms[0].sel_nsdlStatus.value=="104" && varAuthFlag == "")
	{
       alert("Application has not been marked as Reject");
       return false;
	}
	
	if(document.forms[0].sel_nsdlStatus.value=="105" && document.forms[0].hidlapstatus.value=="" && (varOrgLevel=="C" || varOrgLevel=="R"))
	{
       alert("HO/RO/CO Users cannot Hold the Application");
       return false;
	}

	if(document.forms[0].sel_nsdlStatus.value=="104" && varOrgLevel=="A" && varBranchHead == "Y" && varAuthFlag == "Y")
	{
       alert("Application has already been Authorized");
       return false;
	}

	var hidValue = parent.frames.window.opener.document.forms[0].hidApplicantId.value;
	document.forms[0].hidApplicantId.value = hidValue;
		
	document.forms[0].hidBeanId.value="PSB59";
   	document.forms[0].hidSourceUrl.value="/action/np_approvredisp.jsp";
	document.forms[0].hidBeanMethod.value="updatePSB59HoldRejStatus";
	document.forms[0].hidBeanGetMethod.value="PSB59getHoldRejStatus";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

	alert("Saved Successfully");

	callOnLoad();
}

function callDisb()
{
	//document.forms[0].action = appURL+"action/np_disbursement.jsp";
	//document.forms[0].submit();
	
	if(showAlertMsg!="")
	{
    alert(showAlertMsg);
    return;
	}
	
	var hidValue = parent.frames.window.opener.document.forms[0].hidApplicantId.value;
	document.forms[0].hidApplicantId.value = hidValue;
	var hidschName = parent.frames.window.opener.document.forms[0].hidschemeName.value;
	document.forms[0].hidschemeName.value = hidschName;

	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getNP_Dsibursment";
	document.forms[0].action = appURL+"action/np_disbursement.jsp";
	document.forms[0].submit();

	
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

	else if(document.forms[0].hidlapstatus.value=="Rejection Recommended for RO" && document.forms[0].sel_nsdlStatus.value=="105")
	{
       alert("Application has been Marked as Reject, Kindly Authorize Reject");
       return false;
	}

	else if(document.forms[0].hidlapstatus.value=="Hold" && document.forms[0].sel_nsdlStatus.value=="104")
	{
       alert("Hold Applications cannot be done as Authorize Reject");
       return false;
	}

	else if(document.forms[0].sel_nsdlStatus.value=="104" && varOrgLevel=="A" && varBranchHead == "Y" && varAuthFlag == "Y")
	{
       alert("Application has already been Authorized");
       return false;
	}
	
	else if(document.forms[0].hidlapstatus.value=="Hold" && (varOrgLevel=="C" || varBranchHead == "R") && varAuthFlag == "Y")
	{
       alert("Application has already been Authorized");
       return false;
	}
	else if(document.forms[0].hidlapstatus.value=="Hold" && varAuthFlag == "Y")
	{
       alert("Application has already been Hold");
       return false;
	}

	else if(document.forms[0].hidlapstatus.value=="")
	{
       alert("Application has not been Marked as Hold / Reject");
       return false;
	}

	else if(document.forms[0].hidlapstatus.value=="Rejected")
	{
       alert("Application has already been Rejected");
       return false;
	}

	else if(document.forms[0].sel_nsdlStatus.value=="104" && (varOrgLevel=="C" || varOrgLevel=="R") && varAuthFlag=="N")
	{
       alert("UnAuthorized Applications from Branch cannot be Rejected");
       return false;
	}

	else 
	{

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
	var hidValue = parent.frames.window.opener.document.forms[0].hidApplicantId.value;
	document.forms[0].hidApplicantId.value = hidValue;

	document.forms[0].hidBeanId.value="PSB59";
   	document.forms[0].hidSourceUrl.value="/action/np_approvredisp.jsp";
	document.forms[0].hidBeanMethod.value="updatePSB59HoldRejStatus";
	document.forms[0].hidBeanGetMethod.value="PSB59getHoldRejStatus";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

	alert("Saved Successfully");

	callOnLoad();
}
</script>
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
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
		<%if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("N")){ %>
		<select name="sel_nsdlStatus" style="text-align: center">
		    <option value="S">--Select--</option>
		    <option value="105">Hold</option>
		    <option value="102">Rejection Recommended for RO</option>
		</select>
		<%}else if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("Y")){%>
		<select name="sel_nsdlStatus" style="text-align: center">
		    <option value="S">--Select--</option>
		    <option value="105">Authorize Hold</option>
		    <option value="104">Authorize Reject</option>
		</select>
		<%}else if(strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R")){%>
		<select name="sel_nsdlStatus" style="text-align: center">
		    <option value="S">--Select--</option>
		    <option value="105">Authorize Hold</option>
		    <option value="104">Authorize Reject</option>
		</select>
		<%}%>
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
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="javascript:callEdit();"></td>
			<%if(strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R") || (strBranchHead.equalsIgnoreCase("Y") && strLapsStatus.equalsIgnoreCase("Hold"))){%>
			<td><input type="button" name="cmdAuthorize" value="Authorize"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:70" onClick="javascript:callAuthorize();"></td>
			<%}%>
			<%if(!(strOrgLevel.equalsIgnoreCase("C") || strOrgLevel.equalsIgnoreCase("R"))){%>
			<%if(!(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("Y") && strLapsStatus.equalsIgnoreCase("Hold"))){%>
			<td><input type="button" name="cmdSave" value="Save"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="javascript:callSave();"></td>
			<%}}%>
			<td><input type="button" name="cmdCancel" value="Cancel"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="javascript:callCancel();"></td>
			<td><input type="button" name="cmdClose" value="Close"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="callclose();"></td>
		    <td><input type="button" name="cmdDisb" value="Disbursement"
			style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80" onClick="javascript:callDisb();"></td>
		</tr>
   </table>
  </td>
</tr>
</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanMethod" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidApplicantId" value="">
    <input type="hidden" name="hidSourceUrl" value="">
    <input type="hidden" name="hidOldStatus" value="">
    <input type="hidden" name="hidOldRemarks" value="">
    <input type="hidden" name="hidAppStatus" value="">
    <input type="hidden" name="hidlapstatus" value="">
    <input type="hidden" name="hidOnlinestatus" value="">
    <input type="hidden" name="hidHoldAuth" value="">
    <input type="hidden" name="hidschemeName" value="">
    <input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)hshValues.get("hidApplicationNo"))%>">
</form>
</body>
</html>

