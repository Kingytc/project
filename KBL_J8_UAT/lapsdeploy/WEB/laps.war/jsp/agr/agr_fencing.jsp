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

	document.forms[0].txt_fincostbw.readOnly=true;
	
	
}
function doSave()
{   
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanMethod.value="updateFencingdet";
		document.forms[0].hidBeanGetMethod.value="getFencingdet";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_fencing.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();	
	
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disableEditButtons(true, false, false, false, false);
	document.forms[0].txt_totareaval.readOnly=false;
	document.forms[0].txt_costpits.readOnly=false;
	document.forms[0].txt_costpoles.readOnly=false;
	document.forms[0].txt_costbw.readOnly=false;
	document.forms[0].txt_costlabour.readOnly=false;
	document.forms[0].txt_fincostbw.readOnly=true;
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getFencingdet";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action=appUrl+"action/agr_fencing.jsp";
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
		document.forms[0].hidSourceUrl.value="action/agr_fencing.jsp";	
		document.forms[0].hidBeanMethod.value="updateFencingdet";
		document.forms[0].hidBeanGetMethod.value="getFencingdet";
		document.forms[0].submit();	
			
	}

}	

function onloading()
{	 
	disabledFields(true);
	disableEditButtons(false, true, true, true,false);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
}
function Assignfinvalue()
{
	
	//var vartxtareaval = parseFloat(document.forms[0].txt_totareaval.value);
	//document.forms[0].txt_fincostbw.value= roundVal(NanNumber(parseFloat(vartxtareaval)));	

	var vartxtareaval = parseFloat(document.forms[0].txt_totareaval.value);
	var varfincostbw = 	parseFloat(document.forms[0].txt_fincostbw.value);
	var varhidfinval =  parseFloat(document.forms[0].hidfinalval.value);
	var varhidacreval =  parseFloat(document.forms[0].hidacreval.value);
	

	if(varhidacreval!=vartxtareaval)
	{
		document.forms[0].txt_fincostbw.value = vartxtareaval;
		document.forms[0].hidfinalval.value = vartxtareaval;
		document.forms[0].hidacreval.value = vartxtareaval;
	}

	if(vartxtareaval=="")
	{
		vartxtareaval="0.00";
	}
	 document.forms[0].txt_fincostbw.value=parseFloat(vartxtareaval)*4046;
	 roundtxt(document.forms[0].txt_fincostbw);
	 Areafinalvalcal();
	 
	
	
	
}
function Areafinalvalcal()
{
	var vartotal="";
	var vartxtareaval = parseFloat(document.forms[0].txt_totareaval.value);
	var varfincostbw = 	parseFloat(document.forms[0].txt_fincostbw.value);
	var varhidfinval =  parseFloat(document.forms[0].hidfinalval.value);
	var varhidacreval =  parseFloat(document.forms[0].hidacreval.value);
	if(parseFloat(varfincostbw)!=parseFloat(varhidfinval))
	{
		//vartotal =  roundVal(NanNumber(parseFloat(vartxtareaval) * parseFloat(varfincostbw)));
		vartotal=roundVal(document.forms[0].txt_fincostbw.value);
		document.forms[0].hidfinalval.value = vartotal;
		//document.forms[0].txt_fincostbw.value = vartotal;
		var varsqrtval = Math.sqrt(vartotal);
		document.forms[0].txt_fincostlabour.value = Math.round(varsqrtval);
		var varroundval = Math.round(varsqrtval);
		var varsubtot = roundVal(NanNumber(parseFloat(varroundval) * 4 )); 
		document.forms[0].txt_misfinval.value = roundVal(NanNumber(parseFloat(varsubtot)));
		var vartotal = roundVal(NanNumber(parseFloat(varsubtot) * 4 )); 
		document.forms[0].txt_mismainfintotvalue.value = roundVal(NanNumber(parseFloat(vartotal)));
		document.forms[0].txt_areacovbw.value=roundVal(NanNumber(parseFloat(vartotal)));
		//For Area Covered No of pitch value
		document.forms[0].txt_areacovpits.value = roundVal(NanNumber(parseFloat(varsubtot) / 2 )); 
		document.forms[0].txt_areacovpoles.value = roundVal(NanNumber(parseFloat(varsubtot) / 2 )); 
		document.forms[0].txt_areacovlabour.value = Math.round(roundVal(NanNumber(parseFloat(document.forms[0].txt_areacovpoles.value) / parseFloat(16))));
		roundtxt(document.forms[0].txt_areacovlabour);
		
	}
}
function caltotcost()
{
	//Total cost 1st Column
	var varareapits = document.forms[0].txt_areacovpits.value;
	var varcostpits = document.forms[0].txt_costpits.value;
	var vartotcostpits = roundVal(NanNumber(parseFloat(varareapits) * parseFloat(varcostpits)));
	document.forms[0].txt_totcostpits.value = roundVal(NanNumber(parseFloat(vartotcostpits)));
	//Total cost 2nd Column
	var varareapoles = document.forms[0].txt_areacovpoles.value;
	var varcostpoles = document.forms[0].txt_costpoles.value;
	var vartotcostpoles = roundVal(NanNumber(parseFloat(varareapoles) * parseFloat(varcostpoles)));
	document.forms[0].txt_totcostpoles.value = roundVal(NanNumber(parseFloat(vartotcostpoles)));
	//Total cost 3rd Column
	var varareabw = document.forms[0].txt_areacovbw.value;
	var varcostbw = document.forms[0].txt_costbw.value;
	var vartotcostbw = roundVal(NanNumber(parseFloat(varareabw) * parseFloat(varcostbw)));
	document.forms[0].txt_totcostbw.value = roundVal(NanNumber(parseFloat(vartotcostbw)));
	//Total cost 4th Column
	var vararealab = document.forms[0].txt_areacovlabour.value;
	var varcostlab = document.forms[0].txt_costlabour.value;
	var vartotcostlab  = roundVal(NanNumber(parseFloat(vararealab) * parseFloat(varcostlab)));
	document.forms[0].txt_totcostlabour.value = roundVal(NanNumber(parseFloat(vartotcostlab)));
	//Final Total Calculation
	document.forms[0].txt_misfintotvalue.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_totcostpits.value) + 
												 		   			parseFloat(document.forms[0].txt_totcostpoles.value)+
												 				 	parseFloat(document.forms[0].txt_totcostbw.value) +
												  					parseFloat(document.forms[0].txt_totcostlabour.value)));
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
			<jsp:param name="pageid" value="208" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>




<br>
<table width="65%" border="0" cellspacing="2" cellpadding="0" align="center" class="outertable">

	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="2" cellpadding="0" align="center" class="outertable">
			
			
			<tr class="datagrid"> 
			<td colspan="7" align="left">&nbsp;Total Area in &nbsp;&nbsp; 
			<select name="sel_area" >
			<lapschoice:StaticDataNewTag apptype="121"/>
			</select>
			<lapschoice:CurrencyTag name="txt_totareaval"size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areaval"))%>' maxlength="13" onBlur="Assignfinvalue();"/>
			</td>
			</tr>
			
			<tr class="dataheader"> 
			<td width="4%"  align="center">S.No</td>
			<td width="15%" align="center">Activity</td>
			<td width="15%" align="center">Area Covered</td>
			<td width="15%" align="center">Cost/Unit</td>
			<td width="15%" align="center">Total Cost</td>
			<td width="15%" align="center">Final Value</td>
			</tr>
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">1</td>
			<td width="15%">&nbsp;No of Pits (1Cft)</td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_areacovpits" size="15"  onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areacovpits"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_costpits" size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_costpits"))%>' maxlength="13" /></td> 
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_totcostpits" size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_totcostpits"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><input type="hidden" name="txt_fincostpits" size="15" maxlength="13" /></td>
			</tr>
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">2</td>
			<td width="15%">&nbsp;No of poles required (Nos)</td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_areacovpoles"size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areacovpoles"))%>' maxlength="13" onBlur="caltotcost();"/></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_costpoles" size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_costpoles"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_totcostpoles"size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_totcostpoles"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><input type="hidden" name="txt_fincostpoles" size="15" maxlength="13" /></td>
			</tr>
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">3</td>
			<td width="25%">&nbsp;Barbed wire (running mts)</td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_areacovbw" size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areabw"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_costbw"size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_costbw"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_totcostbw"size="15"
					value='<%=Helper.correctDouble((String)hshValues.get("fen_totcostbw"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_fincostbw"size="15" 
					value='<%=Helper.correctDouble((String)hshValues.get("fen_fincostbw"))%>' maxlength="13" onBlur="Areafinalvalcal();roundtxt('document.forms[0].txt_fincostlabour.value')" /></td>
			</tr>
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">4</td>
			<td width="15%">&nbsp;Labour (Man days)</td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_areacovlabour" size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areacovlab"))%>' maxlength="13" /></td> 
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_costlabour" size="15" onBlur="caltotcost();"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_costlab"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_totcostlabour" size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_totcostlab"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_fincostlabour"size="15"
					value='<%=Helper.correctDouble((String)hshValues.get("fen_fincostlab"))%>' maxlength="13" /></td>
			</tr>
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">&nbsp;</td>
			<td width="15%">&nbsp;</td>
			<td width="15%" align="center">&nbsp;</td>
			<td width="15%" align="center">&nbsp;</td>
			<td width="15%" align="center">&nbsp;</td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_misfinval"size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_misfinval"))%>' maxlength="13" /></td>
			</tr>
			
			
			<tr class="datagrid"> 
			<td width="4%"  align="center">&nbsp;</td>
			<td width="15%">&nbsp;</td>
			<td width="15%" align="center">&nbsp;</td>
			<td width="15%" align="center"><b>Total</b></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_misfintotvalue" size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_misfintotval"))%>' maxlength="13" /></td>
			<td width="15%" align="center"><lapschoice:CurrencyTag name="txt_mismainfintotvalue"size="15"
					value='<%=Helper.correctDouble((String)hshValues.get("fen_mismainfintotal"))%>' maxlength="13" /></td>
			</tr>
			
			
			  	
			  	 
			</table>
			<br>
		</td>
	</tr>
</table>
<br>

<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<br>
<input type="hidden" name="hidAction" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidAppType"value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="strschemetypeno" value="<%=strschemetypeno%>"> 
<input type="hidden" name="hidfinalval" value=""> 
<input type="hidden" name="hidacreval" value=""> 
	
</form>
</body>
</html>




