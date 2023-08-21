<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<lapschoice:handleerror/>
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
String strapptype = "";
String apptype = "";
String app_status = Helper.correctNull((String) hshValues.get("app_status"));
	
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));
//String str=Helper.correctNull((String) hshValues.get("Hidpage"));
session.setAttribute("pagehiden",Helper.correctNull((String) hshValues.get("Hidpage")));

HashMap hshLand = new HashMap();
if (hshValues != null) {
	hshLand = (HashMap) hshValues.get("hshAssessmentParam");
}

String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
String strschemetypeno=Helper.getfacilitySno(schemetype);

%>
<html>
<head>
<title>Land Development</title>
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
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varlevel = "<%=Helper.correctNull((String)hshLand.get("agr_landdevelop_slope"))%>";
var varsandcasting = "<%=Helper.correctNull((String)hshLand.get("agr_landdevelop_inches"))%>";
var varreclamation = "<%=Helper.correctNull((String)hshLand.get("agr_landdevelop_soiltype"))%>";
var varschemetype="<%=schemetype%>";

function disableEditButtons(bool1, bool2, bool3, bool4, bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	
	document.forms[0].cmdclose.disabled=bool6;
}
function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	
	
}
function doSave()
{   
	
	if(trim(document.forms[0].txt_landdeveloped.value) == "")
	{
		alert("Enter no. of acres to be developed");
		document.forms[0].txt_landdeveloped.value= "";
		document.forms[0].txt_landdeveloped.focus();
		return ;
	}
	if(trim(document.forms[0].txt_noofhectare.value) == "")
	{
		alert("Enter no. of acres to be leveled the land");
		document.forms[0].txt_noofhectare.value= "";
		document.forms[0].txt_noofhectare.focus();
		return ;
	}
	if((trim(document.forms[0].txt_maintenance.value) == "") || (parseFloat(document.forms[0].txt_maintenance.value) == 0))
	{
		alert("Enter the maintenance cost");
		document.forms[0].txt_maintenance.value= "";
		document.forms[0].txt_maintenance.focus();
		return ;
	}
	if(document.forms[0].sel_slope.value=="S")
	{
		alert("Enter the Slopes to level the land");
		document.forms[0].sel_slope.focus();
		return;
	}
	if(document.forms[0].sel_inches.value=="S" )
	{
		alert("Enter the inches or feet for Reclamation Of Sand");
		document.forms[0].sel_inches.focus();
		return;
	}
	if(document.forms[0].sel_soil.value=="S")
	{
		alert("Ente Type of Soil Reclamation");
		document.forms[0].sel_soil.focus();
		return;
	}

		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanMethod.value="updateLandDevelopment";
		document.forms[0].hidBeanGetMethod.value="getLandDevelopment";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_landdevelopmentdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();	
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disableEditButtons(true, false, false, false,  false);		
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getLandDevelopment";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action=appUrl+"action/agr_landdevelopmentdetails.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	
	if(ConfirmMsg(181))
	{
		
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agr_landdevelopmentdetails.jsp";	
		document.forms[0].hidBeanMethod.value="updateLandDevelopment";
		document.forms[0].hidBeanGetMethod.value="getLandDevelopment";
		document.forms[0].submit();	
			
	}

}	

function onloading()
{	  
	
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	if(varlevel=="")
		{document.forms[0].sel_slope.value="S";}
	else
		{document.forms[0].sel_slope.value=varlevel;}
	if(varsandcasting=="")
		{document.forms[0].sel_inches.value="S";}
	else
		{document.forms[0].sel_inches.value=varsandcasting;}
	if(varreclamation=="")
		{document.forms[0].sel_soil.value="S";}
	else{
		document.forms[0].sel_soil.value=varreclamation;}
	document.forms[0].cmdedit.disabled = true;
	disabledFields(true);
	
	
		disableEditButtons(false, true, true, true,  false);
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
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

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture -> Application -> Land Development Details </td>
	
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="95" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

<br>
<table width="75%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" >

	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable" align="center" >
				
					 <tr>
			 			 <td>&nbsp;</td>
			             <td>How many no. of acres to be developed &nbsp;<span
							class="mantatory">*</span></td>
                  <td align="center"> 
                    <input type="text" name="txt_landdeveloped" size="17"
							align="left" style="text-align: left" maxlength="15"
							value="<%=Helper.correctNull((String) hshLand.get("agr_landdeveloped"))%>"
							onKeyPress="allowNumber(this);notAllowSplChar();">
                  </td>
                  </tr>
                  <tr>
                  <td>&nbsp;</td>
                  <td nowrap>How many no. of acres to be leveled the land<SPAN
							CLASS="mantatory">*</SPAN></td>
                  <Td align="center"> 
                    <input type="text" name="txt_noofhectare" size="17"
							align="left" style="text-align: left" maxlength="15"
							value="<%=Helper.correctNull((String) hshLand.get("agr_noofhectare"))%>"
							onKeyPress="allowNumber(this);notAllowSplChar();">
                  </td>
			  	 </tr>
			  	 <tr>
                  <td>&nbsp;</td>
                  <td nowrap>Maintenance cost for land leveling(%)<SPAN
							CLASS="mantatory">*</SPAN></td>
                  <Td align="center"> 
                    <input type="text" name="txt_maintenance" size="17"
							align="left" style="text-align: right" 
							value="<%=Helper.correctNull((String) hshLand.get("agr_maintenance"))%>"
							maxlength="3" onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowNumber(this)">
                  </td>
			  	 </tr>
					<tr>
				  		<td>&nbsp;</td>
			            <td nowrap> Which Slopes you want used to Level the Land<span class="mantatory">*</span> &nbsp;</td>
						<td align="center"><SELECT NAME="sel_slope" style="width:100">
										<OPTION VALUE="S" selected>----Select----</OPTION>
										<OPTION VALUE="1">0 to 10%</OPTION>
										<OPTION VALUE="2">10.1 to 20%</OPTION>
										<OPTION VALUE="3">Above 20%</OPTION>
									</SELECT></td>
			 	   </tr>
			  	   <tr>
					    <td>&nbsp;</td>
			            <td nowrap> Which Inches or Feet want used to Reclamation Of Sand 
			              Casting<span class="mantatory">*</span>&nbsp;</td>
						<td align="center"><SELECT NAME="sel_inches" style="width:100">
										<OPTION VALUE="S" selected>----Select----</OPTION>
										<OPTION VALUE="1">6" to 12"</OPTION>
										<OPTION VALUE="2">12" to 18"</OPTION>
										<OPTION VALUE="3">18" to 24"</OPTION>
									</SELECT></td>
			 	  </tr>
			  	   <tr>
			 			 <td>&nbsp;</td>
			             <td nowrap> Which Type of Soil Reclamation used<span class="mantatory">*</span>&nbsp;</td>
						 <td align="center"><SELECT NAME="sel_soil" style="width:100">
										<OPTION VALUE="S" selected>----Select----</OPTION>
										<OPTION VALUE="1">Acidic</OPTION>
										<OPTION VALUE="2">Alkaline</OPTION>
									</SELECT></td>
			  	 </tr>
			  	 <tr>
			 			 <td>&nbsp;</td>
			             <td nowrap>Justification for investments&nbsp;</td>
						 <td align="center"><textarea name="txt_justification" rows="6" cols="70" onKeyPress="textlimit(this,'299')" onBlur="textlimit(this,'299')"><%=Helper.correctNull((String) hshLand.get("agr_landdevelop_justification"))%></textarea></td>
			  	 </tr>
			  	 
			  	  
			</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<br>
<input type="hidden" name="hidAction" value=""> <input
	type="hidden" name="hidBeanId" value=""> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl" value=""> 
 <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
	<input type="hidden" name="strschemetypeno" value="<%=strschemetypeno%>">
	
</form>
</body>
</html>




