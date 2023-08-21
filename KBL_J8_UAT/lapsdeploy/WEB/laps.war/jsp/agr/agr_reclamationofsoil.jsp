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

HashMap hshSoil = new HashMap();
if (hshValues != null) {
	hshSoil = (HashMap) hshValues.get("hshSoil");
}
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<%String strschemetypeno=Helper.getfacilitySno(schemetype); %>
<html>
<head>
<title>Soil Reclamation</title>
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
var varsoil_type = "<%=Helper.correctNull((String)hshValues.get("SoilType"))%>";
var varschemetype="<%=schemetype%>";


var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
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
function change_soiltype()
{
		if(document.forms[0].sel_soilType.value!="s")
		{
	    document.forms[0].hidBeanId.value="agrcrops";
	    document.forms[0].hidBeanGetMethod.value="getSoilReclamation";
	    document.forms[0].action=appUrl+"/action/agr_reclamationofsoil.jsp";
		document.forms[0].submit();
		}
}
function computeTotal()
{
	document.forms[0].txt_limetotcost.value	=	roundVal(NanNumber(NanNumber(parseFloat(document.forms[0].txt_limepertonne.value))
												*NanNumber(parseFloat(document.forms[0].txt_nooftonnes.value))));

	document.forms[0].txt_totalcost.value = roundVal(NanNumber(NanNumber(parseFloat(document.forms[0].txt_limetotcost.value))
										+NanNumber(parseFloat(document.forms[0].txt_labour.value))
										+NanNumber(parseFloat(document.forms[0].txt_incorporation.value))
										+NanNumber(parseFloat(document.forms[0].txt_flooring.value))));
}
function doSave()
{   
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanMethod.value="updateSoilReclamation";
	document.forms[0].hidBeanGetMethod.value="getSoilReclamation";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_reclamationofsoil.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	
	
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disableEditButtons(true, false, false, false,  false);		
	document.forms[0].txt_limetotcost.readOnly=true;
	document.forms[0].txt_totalcost.readOnly=true;
	document.forms[0].sel_soilType.disabled=true;
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSoilReclamation";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action=appUrl+"action/agr_reclamationofsoil.jsp";
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
		document.forms[0].hidSourceUrl.value="action/agr_reclamationofsoil.jsp";	
		document.forms[0].hidBeanMethod.value="updateSoilReclamation";
		document.forms[0].hidBeanGetMethod.value="getSoilReclamation";
		document.forms[0].submit();		
	}

}	

function onloading()
{	
	
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	if(varsoil_type=="")
	{
		document.forms[0].sel_soilType.value="s";
	    alert("Please Fill the Land Development Details ");
	}
	else
	{
		document.forms[0].sel_soilType.value=varsoil_type;
	}

	if(document.forms[0].sel_soilType.value=="1")
	{
		document.getElementById('id1').innerHTML = 'Cost of Limestone for';
	}
	else if(document.forms[0].sel_soilType.value=="2")
	{
		document.getElementById('id1').innerHTML = 'Proper Treatment Material';
	}
	
	document.forms[0].sel_soilType.disabled=false;
	
	document.all.sel_scheme.disabled=true;
	document.all.sel_scheme.value=varschemetype;
	
		disableEditButtons(false,true,true,true,false);	
		disabledFields(true);
	
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	
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
	<td class="page_flow">Home -> Agriculture -> Application ->Soil Reclamation </td>
	
	</tr>
	</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="88" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="75%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" >

	<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
			<tr>
				    <td width="36%"> Soil Type </td>
				    <td width="27%"> 
		              <select name="sel_soilType" onChange="change_soiltype()" tabindex="1">
						<option value="s" selected>--Select--</option>
						<option value="1" >Acidic</option>
						<option value="2" >Alkaline</option>
					  </select>
					</td>
			</tr>
			
			<tr>
				<td><label id="id1">Cost of Limestone for </label> <input type="text" maxlength="5" name="txt_nooftonnes"  onKeyPress="allowNumber(this)"
							 size="8"  onblur="roundtxt(this);computeTotal();"  style="text-align: right" tabindex="2"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("limenooftonnes"))))%>"> tonnes per acres at Rs.
					<input type="text" maxlength="10" name="txt_limepertonne"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeTotal();" size="15"   style="text-align: right" tabindex="3"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("limepertone"))))%>">per tonne
				</td>
				<td><input type="text" maxlength="10" name="txt_limetotcost"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeTotal();" size="15"   
							 style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("limetotcost"))))%>"></td>
					 
			</tr>
			
			<tr>
				<td>Labour charges-spreading of lime stone</td>
				<td> <input type="text" maxlength="10" name="txt_labour"  onKeyPress="allowNumber(this)" tabindex="4"
							 onBlur="roundtxt(this);computeTotal();" size="15"   style="text-align: right"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("labour"))))%>">
				</td>
			</tr>
			<tr>
				<td>Incorporation of lime stone by ploughing with tractors/plough bullocks (2 ploughings)</td>
				<td> <input type="text" maxlength="10" name="txt_incorporation"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeTotal();" size="15"   style="text-align: right" tabindex="5"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("incorporation"))))%>">
				</td>
			</tr>
			<tr>
				<td>Flooring-charges</td>
				<td> <input type="text" maxlength="10" name="txt_flooring"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeTotal();" size="15"   style="text-align: right" tabindex="5"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("flooring"))))%>">
				</td>
			</tr>
			<tr>
				<td>Total cost per acres</td>
				<td> <input type="text" maxlength="10" name="txt_totalcost"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeTotal();" size="15"   
							 style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
							 value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshSoil.get("totalcost"))))%>">
				</td>
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
	name="hidSourceUrl" value=""> <input type="hidden" name="page"
	value="">  <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
	<input type="hidden" name="soil_type" value="<%=Helper.correctNull((String)hshValues.get("SoilType"))%>"></input>
	 <input type="hidden" name="strschemetypeno" value="<%=strschemetypeno%>"> 
</form>
</body>
</html>

