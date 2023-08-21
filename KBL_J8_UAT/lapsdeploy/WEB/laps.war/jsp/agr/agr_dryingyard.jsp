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

String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<%String strschemetypeno=Helper.getfacilitySno(schemetype); %>
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
var varschemetype="<%=schemetype%>";
var vatsel_units="<%=Helper.correctNull((String) hshValues.get("agr_units"))%>";

function disableEditButtons(bool1, bool2, bool3, bool4,  bool6)
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

	if(document.forms[0].sel_units.value=="" )
	{
		alert("Select the Units");
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanMethod.value="updateDryingYard";
		document.forms[0].hidBeanGetMethod.value="getDryingYard";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_dryingyard.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();	
	}
	
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disableEditButtons(true, false, false, false, false);
	document.forms[0].txt_cost.readOnly=true;	
	document.forms[0].txt_area.readOnly=true;	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getDryingYard";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action=appUrl+"action/agr_dryingyard.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agr_dryingyard.jsp";	
		document.forms[0].hidBeanMethod.value="updateDryingYard";
		document.forms[0].hidBeanGetMethod.value="getDryingYard";
		document.forms[0].submit();	
			
	}

}	


function onloading()
{	 
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	
	disabledFields(true);
	
	disableEditButtons(false, true, true, true,false);

	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	document.forms[0].txt_cost.readOnly=true;
	document.forms[0].sel_typeflooring.value="<%=Helper.correctNull((String) hshValues.get("agr_Typefloor"))%>";
	

	

	if(vatsel_units!="")
	{
		document.forms[0].sel_units.value=vatsel_units;
	}
	else
	{
		document.forms[0].sel_units.value="";
	}
		
	funTypeflo();
}
function funtot()
{
	
	var vartxt_area=parseFloat(document.forms[0].txt_area.value);
	var vartxt_floor=parseFloat(document.forms[0].txt_floor.value);
	var vartot=(eval(vartxt_area)*eval(vartxt_floor));
	document.forms[0].txt_cost.value=vartot;
	
	
}

function funTypeflo()
{
	if(document.forms[0].sel_typeflooring.value=="5")
	{
	
	document.all.id2.style.visibility="visible";
	document.all.id2.style.position="relative";
    }
	else 
	{
		document.all.id2.style.visibility="hidden";
		document.all.id2.style.position="absolute";
	}
}

function funflooring()
{
	document.forms[0].hidBeanId.value="agrcrops";
	//document.forms[0].hidBeanMethod.value="updateDryingYard";
	document.forms[0].hidBeanGetMethod.value="getDryingYard";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_dryingyard.jsp";
	//document.forms[0].method="post";
	document.forms[0].submit();	
	
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
<form name="frmdy" method=post class="normal">

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
	<td class="page_flow">Home -> Agriculture ->  Application -> Drying Yard</td>
	
	</tr>
</table>

<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="120" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>




<br>
<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">

	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
					
			  	
			  	<!-- By Arsath as per the UAT new requirements
					 <tr  style="visibility: hidden;position: absolute">
				  		
			            <td width="40%"> Unit Area  </td>
						<td  width="20%" nowrap="nowrap" >
						
						<input type="text" name="txt_area" readonly="readonly" value="1" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);funtot();" size="12" maxlength="15" style="text-align: right">
						&nbsp;&nbsp;Units&nbsp; <span class="mantatory">*</span>
						<select name="sel_units">
						<option value="">---Select---</option>
						<lapschoice:StaticDataNewTag apptype="121"/>
						</td>
			 	    </tr>  -->
			 	    
			 	    
			 	     <tr>
			            <td width="40%">Units</td>
						<td  >
						<select name="sel_units">
						<option value="">---Select---</option>
						<lapschoice:StaticDataNewTag apptype="121"/>
						</td>
			 	    </tr>
			 	    
			 	     <tr>
					   
			            <td > Type of flooring</td>
						
						<td >
						<select name="sel_typeflooring" onchange="funTypeflo();funflooring()">
						<option value="">---select---</option>
						<option value="1">Concrete</option>
						<option value="2">Brick</option>
						<option value="3">Interlock</option>
						<option value="4">Mud</option>
						<option value="5">Other</option>
						</select>
						</td>
						<td>&nbsp;</td>
						
						</tr>
						
					   <tr id="id2" >
						  <td>Specify</td>
						  <td  ><input type="text" name="txt_otehr"    maxlength="30" size="25" value="<%=Helper.correctNull((String) hshValues
							.get("agr_Typeother"))%>" ></td>
					   <td>&nbsp;</td>
			 	     </tr>
			  	  
			  	
			  	  <tr>
						
						<td>Cost per Unit</td>
						<td  ><input type="text" name="txt_floor" value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues
							.get("agr_floor")))%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);funtot();" maxlength="15" style="text-align: right"></td>
							 <td>&nbsp;</td>
			 	   </tr>
			 	   
			 	    <tr style="visibility: hidden;position: absolute">
			 			
			             <td > Total Cost</td>
						 <td ><input type="text" name="txt_cost" value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues
							.get("agr_cost")))%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);" maxlength="35" style="text-align: right"></td>
						 <td>&nbsp;</td>
			  	  </tr>
			  	 
			  	 
			</table>
			<br>
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




