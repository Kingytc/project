<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror/>
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

String strapptype = "";
String apptype = "";
String app_status = Helper.correctNull((String) hshValues.get("app_status"));
	
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));

HashMap hshTobaccoDetails = new HashMap();
if (hshValues != null) {
	hshTobaccoDetails = (HashMap) hshValues.get("hshTobaccoDet");

}
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>
<html>
<head>
<title>Cost of rising up to sale point per plant</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var is_tieup	=	"<%=Helper.correctNull((String) hshTobaccoDetails
	.get("istieup"))%>";
var barren	=	"<%=Helper.correctNull((String) hshTobaccoDetails
	.get("barrenshare"))%>";

	function onloading()
	{	  
		disabledFields(true);
		if(is_tieup!="")
			document.forms[0].sel_tieup.value=is_tieup;
		else
			document.forms[0].sel_tieup.value="s";
		if(barren!="")
			document.forms[0].sel_barrenshare.value=barren;
		else
			document.forms[0].sel_barrenshare.value="s";
		document.all.sel_scheme.disabled=false;
		document.all.sel_scheme.value="<%=schemetype%>";
		
	}
	function disabledFields(one)
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
			if(document.forms[0].elements[i].type=="checkbox")
			{
				document.forms[0].elements[i].disabled=one;		  
			}
			if(document.forms[0].elements[i].type=="select-multiple" )
			{
				document.forms[0].elements[i].disabled=one;
			}
		}
	}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5, bool6)
	{
		document.forms[0].cmdedit.disabled=bool1;
		document.forms[0].cmdsave.disabled=bool2;
		document.forms[0].cmdcancel.disabled=bool3;
		document.forms[0].cmddelete.disabled=bool4;
		//document.forms[0].cmdHelp.disabled=bool5;
		document.forms[0].cmdclose.disabled=bool6;
	}
function doSave()
{   
	if(document.forms[0].txt_licensedate.value=="")
	{
		ShowAlert(121,'Date of License');
		document.forms[0].txt_licensedate.focus();
		return;
	}
	if(document.forms[0].txt_validupto.value=="")
	{
		ShowAlert(121,'License valid upto');
		document.forms[0].txt_validupto.focus();
		return;
	}
	disableEditButtons(true, true, true,true, true, false);	
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidBeanMethod.value="updateTobaccoDetails";
	document.forms[0].hidBeanGetMethod.value="getTobaccoDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agrtobaccodetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disableEditButtons(true, false, false,false, false, false);		

}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getTobaccoDetails";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].action=appUrl+"action/agrtobaccodetails.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="action/agrtobaccodetails.jsp";	
		document.forms[0].hidBeanMethod.value="updateTobaccoDetails";
		document.forms[0].hidBeanGetMethod.value="getTobaccoDetails";
		document.forms[0].submit();		
	}

}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
} 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Tobacco Details</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="58" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

<br>
<table width="80%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable border1">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr>
		    <td width="20%"> Date of License &nbsp;<span
					class="mantatory">*</span> </td>
		    <td width="17%" colspan="2"> <input type="text"
					name="txt_licensedate"
					value="<%=Helper.correctNull((String) hshTobaccoDetails
									.get("txt_licensedate"))%>"
					size="13" maxlength="10" tabindex="1"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
				<a alt="Select date from calender"
					href="javascript:callCalender('txt_licensedate')"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" tabindex="2">
              
		</td>
		<td width="20%">&nbsp;</td>
		    <td width="23%">License valid upto &nbsp;<span
					class="mantatory">*</span></td>
		    <td width="20%"><input type="text"
					name="txt_validupto"
					value="<%=Helper.correctNull((String) hshTobaccoDetails
									.get("txt_validupto"))%>"
					size="13" maxlength="10" tabindex="3"
					onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_licensedate.value)">
				<a alt="Select date from calender"
					href="javascript:callCalender('txt_validupto')"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" tabindex="4">
		 </td>
		 </tr>
		 </table>
		 </td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
			<tr>
			<td width="20%" colspan="2">Tobacco board grower's registration number</td> 
		
			<td width="20%"> 
              <input type="text" name="txt_tobaccoregnumber" size="20"  maxlength="20"  tabindex="5" 
				value="<%=Helper.correctNull((String) hshTobaccoDetails
														.get("regnumber"))%>" onKeyPress="notAllowSingleAndDoubleQuote()"></td>
		
			<td width="23%">No of barrens</td>
			<td width="20%"> 
              <input type="text" name="txt_noofbarrens" size="15" style="text-align: left;" maxlength="20"  tabindex="6" 
				value="<%=Helper.correctNull((String) hshTobaccoDetails
														.get("noofbarrens"))%>" onKeyPress="allowInteger()"></td>
				</tr>
				<tr>
			<td width="20%" colspan="2">Tobacco barren Number</td>
			<td width="20%"> 
              <input type="text" name="txt_tobaccobarrenno" size="20"  maxlength="20"  tabindex="7" 
				value="<%=Helper.correctNull((String) hshTobaccoDetails
														.get("barrennum"))%>" onKeyPress="notAllowSingleAndDoubleQuote()"></td>
			<td width="23%"> Barren Share </td>
			 
            <td width="20%"> 
              <select name="sel_barrenshare"  tabindex="8">
		<option value="s" selected>--Select--</option>
		<option value="1">Owned</option>
		<option value="2">Leased</option>
		
		</select>
		</td>
		</tr>
		<tr>
		    <td width="20%" colspan="2"> Quantity authroised in Kgs </td>
		    <td width="20%"> 
              <input type="text" name="txt_quantity" size="20" style="text-align: left" maxlength="15"  tabindex="9" 
				value="<%=Helper.correctNull((String) hshTobaccoDetails
														.get("quantity"))%>" onKeyPress="allowInteger()" onblur="roundtxt(this)"></td>
			<td width="23%"> If there is any tie up or not </td>
		    <td width="20%"> <select name="sel_tieup"  tabindex="10">
		<option value="s" selected>--Select--</option>
		<option value="1" >Yes</option>
		<option value="2" >No</option>
		</select>
		 </td>
			</tr>
			<tr>
			<td width="20%">&nbsp;</td> 
			<td width="17%">&nbsp;</td>
			<td width="20%">&nbsp;</td>		
			<td width="23%">&nbsp;</td>
			<td width="20%">&nbsp;</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<%
	String strappno = Helper.correctNull((String) request
			.getParameter("appno"));
%> <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<table width="98%" border="1" align="center" cellspacing="0"
	cellpadding="1" bordercolorlight="#FFFFFF" bordercolordark="#C3CCF3">
	<tr>
	</tr>
</table>
<input type="hidden" name="hidAction" value=""> <input
	type="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden" name="page"
	value=""> <INPUT TYPE="hidden" name="trapEdit"
	value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues
									.get("hidEditMode"))%>">
 <input
	type="hidden" name="hidDemoId"
	value="<%=request.getParameter("hidDemoId")%>"> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
</form>
</body>
</html>




