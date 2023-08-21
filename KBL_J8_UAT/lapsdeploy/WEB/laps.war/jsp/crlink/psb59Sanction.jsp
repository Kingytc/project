<%@include file="../share/directives.jsp"%>
<%
String strRem = Helper.correctNull((String) hshValues.get("REMARKS"));
session.setAttribute("REFERENCE_ID",Helper.correctNull((String) hshValues.get("APPREFID")));
session.removeAttribute("SANCTION_FLAG");
session.setAttribute("SANCTION_FLAG",Helper.correctNull((String) hshValues.get("SANCFLAG")));

 strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
String strBranchHead=Helper.correctNull((String)hshValues.get("strBranchHead")); 
String showDisbMsg = Helper.correctNull((String)hshValues.get("showDisbMsg")); 
String APIresp=Helper.correctNull((String)hshValues.get("respmesg"));
session.removeAttribute("SANDISREFIF");
String strRefId = Helper.correctNull((String)hshValues.get("strRefId"));
session.setAttribute("SANDISREFIF",strRefId);
String	strSchemeName= Helper.correctNull((String) hshValues.get("hidschemeName"));

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strRemarks = "<%=strRem%>";
var varOrgLevel="<%=strOrgLevel%>";
var varBranchHead="<%=strBranchHead%>";
var showDisbMsg = "<%=showDisbMsg%>";
var refId = "<%=strRefId%>";
var varSchemeName = "<%=strSchemeName%>";

function callclose()
{
	window.close();
}
function callOnLoad()
{
	
	var status="<%=APIresp%>";
	if(status!=""){
	alert(status);
	document.forms[1].cmdupdate.disabled = true;
	}
	var Buttondisable="<%=Helper.correctNull((String) hshValues.get("ButtondisableFalg"))%>";
	if(Buttondisable =="Y"){
	document.forms[1].cmdupdate.disabled = true;
	}

	if(showDisbMsg!="")
	{
		alert(showDisbMsg);
		document.forms[1].cmdsave.style.visibility="hidden";
		document.forms[1].cmdupdate.style.visibility="hidden";
	}
	
	document.forms[1].hidReferId.value="<%=strRefId%>";
	document.forms[1].hidSchName.value=varSchemeName;

	document.forms[1].apprefid.value = "<%=strRefId%>";
	document.forms[1].appschname.value = varSchemeName;
	document.forms[1].txtremarks.value = strRemarks;

	
		
	
}

function callsave()
{
	if(document.forms[1].txtsanamount.value=="")
	{
		alert("Sanction amount is required");
		document.forms[1].txtsanamount.focus();
		return false;
	}
	if(document.forms[1].txtroi.value=="")
	{
		alert("Rate of interest is required");
		document.forms[1].txtroi.focus();
		return false;
	}
	if(document.forms[1].txtprocfees.value=="")
	{
		alert("Processing Fees is required");
		document.forms[1].txtprocfees.focus();
		return false;
	}
	if(document.forms[1].txttenure.value=="")
	{
		alert("Tenure (In Months) is required");
		document.forms[1].txttenure.focus();
		return false;
	}
	if(document.forms[1].txtsandate.value=="")
	{
		alert("Sanction Date is required");
		document.forms[1].txtsandate.focus();
		return false;
	}
	if(document.forms[1].txtemi.value=="")
	{
		alert("EMI is required");
		document.forms[1].txtemi.focus();
		return false;
	}
	document.forms[1].hidSchName.value=varSchemeName;
	
	document.forms[1].hidschemeName.value = varSchemeName;
	document.forms[1].hidBeanId.value="NationalPortal";
   	document.forms[1].hidSourceUrl.value="/action/psb59Sanction.jsp";
	document.forms[1].hidBeanMethod.value="updatePSB59SanctionDetails";
	document.forms[1].hidBeanGetMethod.value="getPSB59SanctionDetails";
	document.forms[1].action=appURL+"controllerservlet";
	document.forms[1].submit();

	alert("Saved Successfully");
}

function callsearch()
{

}
function doSearch()
{
 	var appno= document.forms[1].txtappnum.value; 
	document.all.ifrmexistdata.src=appURL+"action/NP_applicationsearch.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=NPAppnoSearch&appno="+appno;
	alert(appno);
}
function callupdate(){
	document.forms[1].hidschemeName.value = varSchemeName;
	document.forms[1].hidSchName.value=varSchemeName;
	
	document.forms[1].cmdupdate.disabled = true;
	document.forms[1].hidBeanId.value="NationalPortal";
	document.forms[1].hidBeanGetMethod.value="invokeUpdateSanctionAPI";
	document.forms[1].action = appURL+"action/psb59Sanction.jsp";
	document.forms[1].submit();

	alert("Saved Successfully");
}
</script>

</style>



<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<body onload=callOnLoad() >
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="psb59SancDisb.jsp"/>
    </td>
  </tr>
</table>
</form>
<form class="normal">
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>UPDATE SANCTION DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<col width="6%">
		<col width="25%">
		<col width="20%">
		<tr height="50px">
		  <td><b>Application No.</b></td>
		  <td><input type="text" name="txtappnum" value="<%=Helper.correctNull((String) hshValues.get("APPNO"))%>">
		  <%if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("N")){ %>
			<a href="javascript:doSearch()" id="search_icon" class="blackfont" tabindex="6"> 
				<img src="<%=ApplicationParams.getAppUrl()%>img/search_corp.gif" style="border: none" onclick="callsearch()" align="middle" > 
			</a>
			<%} %>
			</td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		    <tr height="30px">
				<td><b>Application Reference ID</b></td>
				<td><input type="text" name="apprefid" disabled="disabled"/></td>
				<td><b>Scheme</b></td>
				<td><input type="text" name="appschname" disabled="disabled"/></td>
			</tr>
			<tr height="30px">
				<td><b>Sanctioned Amount</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				<td><input type="text" name="txtsanamount" style="text-align:right;" onkeypress="allowInteger('this')" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String) hshValues.get("SANCTIONAMT"))%>"></td>
				<td><b>Rate of Interest</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				<td><input type="text" name="txtroi" style="text-align:right;" onkeypress="allowDecimals(this)" onBlur="roundtxt(this)" value="<%=Helper.correctNull((String) hshValues.get("ROI"))%>"/></td>
			</tr>
			<tr height="30px">
				<td><b>Processing Fees</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				<td><input type="text" name="txtprocfees" style="text-align:right;" onkeypress="allowInteger('this')"  onBlur="roundtxt(this)" value="<%=Helper.correctNull((String) hshValues.get("PROCESSFEE"))%>"/></td>
				<td><b>Tenure (In Months)</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				<td><input type="text" name="txttenure" style="text-align:right;" onkeypress="allowInteger('this')" value="<%=Helper.correctNull((String) hshValues.get("TENURE"))%>"/></td>
			</tr>
			<tr height="30px">
			    <td><b>Sanction Date</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
			  <%if(strOrgLevel.equalsIgnoreCase("A") && strBranchHead.equalsIgnoreCase("N")){ %>
				<td><input type="text" name="txtsandate" class="datepickerNorm" onkeypress="allowDate()" onBlur="checkDate(this);" onkeyup="todate(this)" value="<%=Helper.correctNull((String) hshValues.get("SANCTIONDATE"))%>"/></td>
				<%} else {%>
				<td><input type="text" name="txtsandate" value="<%=Helper.correctNull((String) hshValues.get("SANCTIONDATE"))%>"/></td>
				<%} %>
				<td><b>EMI</b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				<td><input type="text" name="txtemi" style="text-align:right;" onBlur="roundtxt(this)" onkeypress="allowInteger('this')" value="<%=Helper.correctNull((String) hshValues.get("EMI"))%>"/></td>
			</tr>
			</table>
			</td></tr>
			<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<col width="11%">
			<col width="5%">
			<col width="6%">
			<col width="9%">
			<tr>
			    <td><b>Remarks (If Any)</b></td>
				<td><TEXTAREA name="txtremarks" COLS="115" ROWS="8"></TEXTAREA></td>
				<td></td>
				<td></td>
			</tr>
			</table>
			</td></tr>
		
		</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
      <td>  
            <input type="button" name="cmdsave" value="Save" class="buttonStyle" onClick="callsave()"> 
        </td>
        <td>  
            <input type="button" name="cmdupdate" value="Authorize" class="buttonStyle" onClick="callupdate()"> 
        </td>
       
       <td>  
            <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose()"> 
        </td>
      </tr>
</table>
<iframe height="0" width="0" id="ifrmexistdata" frameborder="0"
	style="border: 0"></iframe>
<input type="hidden" name="hidUserId" value="">
<input type="hidden" name="hidSchId" value="">
<input type="hidden" name="hidSchName" value="">
<input type="hidden" name="hidReferId" value="<%=strRefId%>">
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod">
 <input type="hidden"name="hidBeanId"> 
 <input type="hidden" name="hidSourceUrl"> 
 <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidschemeName" value="">
   
</form>
</body>
</html>

