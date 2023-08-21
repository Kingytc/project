<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%
	ArrayList arryCol = null;
	ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
	ArrayList arryFeedRow = (ArrayList) hshValues.get("arryFeedRow");
	String strappno = FwHelper.correctNull((String) request.getParameter("appno"));
	if(strappno.equalsIgnoreCase(""))
		strappno=FwHelper.correctNull((String) hshValues.get("strAppno"));
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	String strFacSNo=Helper.getfacilitySno(schemetype);
	int strPeriod=Integer.parseInt(Helper.correctInt((String)hshValues.get("strPeriod")));
	String strPoultryType=Helper.correctNull((String)hshValues.get("strPoultry"));
	String strtableegg=Helper.correctNull((String)hshValues.get("strtableegg"));
	String strfertileegg=Helper.correctNull((String)hshValues.get("strfertileegg"));
	String strtableeggincome=Helper.correctNull((String)hshValues.get("strtableeggincome")) ;
	String strfertileeggincome=Helper.correctNull((String)hshValues.get("strfertileeggincome"));
	String strbrooderexp=Helper.correctNull((String)hshValues.get("strbrooderexp"));
	String strgrowererexp=Helper.correctNull((String)hshValues.get("strgrowererexp"));
	String strlayerexp=Helper.correctNull((String)hshValues.get("strlayerexp"));
%>

<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=FwHelper.correctNull((String) hshValues.get("strid"))%>";
var  strAction="<%=FwHelper.correctNull((String) hshValues
									.get("strAction"))%>";
var strUserMode="<%=FwHelper.correctNull((String) hshValues
							.get("strUserMode"))%>";
var schemetype="<%=schemetype%>";							
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varappno="<%=strappno%>";
function doClose()
{
if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}

function disableFields(one)
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
	}	
}

function doSave()
{	

	if(document.forms[0].txtbirdsperbatch.value=="")
	{
		alert("Enter the No of birds per batch");
		return;
	}
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
    document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broiflockrep.jsp";
	document.forms[0].hidBeanGetMethod.value="updatebroiagrflock";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
	document.forms[0].txtbirdsperbatch.readOnly =false;
	document.all.txtbirdsperbatch.readOnly=true;
	document.forms[0].txtegg.readOnly =false;
	document.forms[0].txtegg1.readOnly =false;
	document.forms[0].txtegg2.readOnly =false;
	document.forms[0].txtegg3.readOnly =false;
	document.forms[0].txtbrooderfeedexp.readOnly =false;
	document.forms[0].txtgrowerfeedexp.readOnly =false;
	document.forms[0].txtlayerfeedexp.readOnly =false;
	document.forms[0].txtcostofbird.readOnly =false;
    document.forms[0].hidAction.value ="insert";
    enableButtons(true, false, false, false, false);	
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getbroiagrflock";
		document.forms[0].action=appUrl+"action/agr_poultry_broiflockrep.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanGetMethod.value="updatebroiagrflock";
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidSourceUrl.value="action/agr_poultry_broiflockrep.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function onloading()
{	  
	disableFields(true);
	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	       enableButtons(false, true, true, true, false);
		}
		else
		{
			enableButtons(true, true, true, true, false);
		}
	}
	else
	{
		enableButtons(true, true, true, true, false);
	}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	document.all.txtbirdsperbatch.readOnly=true;
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function funFlockreplacement()
{
	var varschemetype=document.forms[0].sel_scheme.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/agrreplacementchart.jsp?hidBeanGetMethod=getbroiagrflocknew&hidBeanId=agriloanassessment&strappno="+varappno+"&schemetype="+varschemetype+"&appno="+varappno;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}
function funIncome()
{
	<%for(int i=0;i<strPeriod;i++){
	if(strPeriod>1){%>
	if(document.forms[0].txtegg.value!="")
	{
		document.forms[0].txttegg[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)*parseFloat(document.forms[0].txtlayer[<%=i%>].value)));
	}
	if(document.forms[0].txtegg1.value!="")
	{
		document.forms[0].txtfegg[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg1.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)*parseFloat(document.forms[0].txtlayer[<%=i%>].value)));
	}
	if(document.forms[0].txtegg2.value!="")
	{
		document.forms[0].txttincome[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg2.value)*parseFloat(document.forms[0].txttegg[<%=i%>].value)));
	}
	if(document.forms[0].txtegg3.value!="")
	{
		document.forms[0].txtfincome[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg3.value)*parseFloat(document.forms[0].txtfegg[<%=i%>].value)));
	}
	document.forms[0].txttotalincome[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txttincome[<%=i%>].value)+parseFloat(document.forms[0].txtfincome[<%=i%>].value)));
	if(document.forms[0].txtbrooderfeedexp.value!="")
	{
		document.forms[0].txtbfeedingexp[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtbrooderfeedexp.value)*parseFloat(document.forms[0].txtbrood[<%=i%>].value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	if(document.forms[0].txtgrowerfeedexp.value!="")
	{
		document.forms[0].txtgfeedingexp[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtgrowerfeedexp.value)*parseFloat(document.forms[0].txtgrower[<%=i%>].value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	if(document.forms[0].txtlayerfeedexp.value!="")
	{
		document.forms[0].txtlfeedingexp[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtlayerfeedexp.value)*parseFloat(document.forms[0].txtlayer[<%=i%>].value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	document.forms[0].txttotalfeedingexp[<%=i%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txtbfeedingexp[<%=i%>].value)+parseFloat(document.forms[0].txtgfeedingexp[<%=i%>].value)+parseFloat(document.forms[0].txtlfeedingexp[<%=i%>].value)));
	<%}else if(strPeriod==1){%>
	if(document.forms[0].txtegg.value!="")
	{
		document.forms[0].txttegg.value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)*parseFloat(document.forms[0].txtlayer.value)));
	}
	if(document.forms[0].txtegg1.value!="")
	{
		document.forms[0].txtfegg.value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg1.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)*parseFloat(document.forms[0].txtlayer.value)));
	}
	if(document.forms[0].txtegg2.value!="")
	{
		document.forms[0].txttincome.value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg2.value)*parseFloat(document.forms[0].txttegg.value)));
	}
	if(document.forms[0].txtegg3.value!="")
	{
		document.forms[0].txtfincome.value=roundVal(NanNumber(parseFloat(document.forms[0].txtegg3.value)*parseFloat(document.forms[0].txtfegg.value)));
	}
	document.forms[0].txttotalincome.value=roundVal(NanNumber(parseFloat(document.forms[0].txttincome.value)+parseFloat(document.forms[0].txtfincome.value)));
	if(document.forms[0].txtbrooderfeedexp.value!="")
	{
		document.forms[0].txtbfeedingexp.value=roundVal(NanNumber(parseFloat(document.forms[0].txtbrooderfeedexp.value)*parseFloat(document.forms[0].txtbrood.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	if(document.forms[0].txtgrowerfeedexp.value!="")
	{
		document.forms[0].txtgfeedingexp.value=roundVal(NanNumber(parseFloat(document.forms[0].txtgrowerfeedexp.value)*parseFloat(document.forms[0].txtgrower.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	if(document.forms[0].txtlayerfeedexp.value!="")
	{
		document.forms[0].txtlfeedingexp.value=roundVal(NanNumber(parseFloat(document.forms[0].txtlayerfeedexp.value)*parseFloat(document.forms[0].txtlayer.value)*parseFloat(document.forms[0].txtbirdsperbatch.value)));
	}
	document.forms[0].txttotalfeedingexp.value=roundVal(NanNumber(parseFloat(document.forms[0].txtbfeedingexp.value)+parseFloat(document.forms[0].txtgfeedingexp.value)+parseFloat(document.forms[0].txtlfeedingexp.value)));
	<%}}%>
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(document.forms[0].elements[i].name=="txtbirdsperbatch")
			{}
			else
			{ document.forms[0].elements[i].value="";}		  
		}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
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
<form name="frmpri" class="normal" method=post>

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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Flock Replacement</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="101" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>


<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable border1"  align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="2" cellpadding="2">
					<tr>

						<td>
						<table width="90%" border="0" align="center" cellspacing="0" cellpadding="1" bordercolorlight="#FFFFFF" bordercolordark="#dleef">
							<tr>
								<td colspan="13">
								<table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											
											<tr>
												<td>
												<table width="99%" border="0" cellspacing="1"
													cellpadding="2">
													<tr>
														<td colspan="14" align="center" class="dataheader">Replacement
														Particulars</td>
													</tr>
													<tr class="dataheader">
														<td colspan="4" align="center" >No of birds per batch</td>
														<td colspan="4" align="center"><input type="text" name="txtbirdsperbatch"  style="text-align: right" value="<%=Helper.correctNull((String)hshValues.get("strnoofbirds")) %>" onBlur="funIncome();"></td>
														<td colspan="2" align="center" >Cost of one DOC</td>
														<td colspan="2" align="center"><input type="text" name="txtcostofbird"  style="text-align: right" value="<%=Helper.correctNull((String)hshValues.get("strcostofbird")) %>"></td>
													</tr>
													<tr class="dataheader">
														<td align="center" class="dataheader">Project Year&nbsp;</td>
														<td  align="center">No.of Batches Purchased</td>
														<td  align="center">Brooding weeks</td>
														<td  align="center">Grower weeks</td>
														<td  align="center">layer weeks</td>
														<td  align="center">No.of Batches Sold</td>
														<td  align="center">Table egg @<lapschoice:CurrencyTag name="txtegg" value="<%=strtableegg %>" size="10" onBlur="funIncome();"/> egg/bird/week</td>
														<td  align="center">Fertile egg@ <lapschoice:CurrencyTag name="txtegg1" value="<%=strfertileegg %>" size="10"  onBlur="funIncome();"/> Egg/bird/week</td>
														<td  align="center">Income from table egg@Rs <lapschoice:CurrencyTag
															name="txtegg2" value="<%=strtableeggincome%>" size="10" onBlur="funIncome();" />/egg</td>
														<td  align="center">Income from fertile egg @Rs <lapschoice:CurrencyTag name="txtegg3" value="<%=strfertileeggincome %>" size="10"  onBlur="funIncome();"/>/ per egg</td>
														<td  align="center">Total income from egg</td>
													</tr>
													<%
													if (arryRow != null && arryRow.size() > 0) {
														for (int i = 1; i <= arryRow.size(); i++) {
																arryCol = (ArrayList) arryRow.get(i - 1);
													%>
													<tr align="center" class="datagrid">
														<td height="27"><%=i%> year<input type="hidden" name="hidSno" value="<%=Helper.correctNull((String)arryCol.get(0))%>"></td>
														<td><input type="text" name="txt_batch"
															value="<%=Helper.correctNull((String)arryCol.get(1))%>" size="7"></td>
														<td  align="center"><input type="text" name="txtbrood" size="7" style="text-align: right" value="<%=Helper.correctNull((String)arryCol.get(2)) %>">&nbsp;</td>
														<td  align="center"><input type="text" name="txtgrower" size="7" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(3)) %>">&nbsp;</td>
														<td  align="center"><input type="text" name="txtlayer" size="7" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(4)) %>">&nbsp;</td>
														<td><input type="text" name="txt_broodermon"
															 value="<%=Helper.correctNull((String)arryCol.get(5)) %>" size="7" style="text-align: center"></td>
															<td  align="center"><lapschoice:CurrencyTag name="txttegg" size="15" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(6)) %>"/>&nbsp;</td>
															<td  align="center"><lapschoice:CurrencyTag name="txtfegg" size="15" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(7)) %>"/>&nbsp;</td>
															<td  align="center"><lapschoice:CurrencyTag name="txttincome" size="15" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(8)) %>"/>&nbsp;</td>
															<td  align="center"><lapschoice:CurrencyTag name="txtfincome" size="15" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(9)) %>"/>&nbsp;</td>
															<td  align="center"><lapschoice:CurrencyTag name="txttotalincome" size="15" style="text-align: right"  value="<%=Helper.correctNull((String)arryCol.get(10)) %>"/>&nbsp;</td>
													</tr>
													<%
														}} else {
															for (int i = 1; i <= strPeriod; i++) {
													%>
													<tr align="center" class="datagrid">
														<td><%=i %> year <input type="hidden" name="hidSno" value="<%=i %>"></td>
														<td><input type="text" name="txt_batch" size="7"
															onKeyPress="allowInteger()"></td>
														<td  align="center"><input type="text" name="txtbrood" size="7" style="text-align: right">&nbsp;</td>
														<td  align="center"><input type="text" name="txtgrower" size="7" style="text-align: right">&nbsp;</td>
														<td  align="center"><input type="text" name="txtlayer" size="7" style="text-align: right">&nbsp;</td>
														<td><input type="text" name="txt_broodermon"
															size="7" onKeyPress="allowInteger()" style="text-align: center"></td>
															<td  align="center"><input type="text" name="txttegg" size="15" style="text-align: right">&nbsp;</td>
															<td  align="center"><input type="text" name="txtfegg" size="15" style="text-align: right">&nbsp;</td>
															<td  align="center"><input type="text" name="txttincome" size="15" style="text-align: right">&nbsp;</td>
															<td  align="center"><input type="text" name="txtfincome" size="15" style="text-align: right">&nbsp;</td>
															<td  align="center"><input type="text" name="txttotalincome" size="15" style="text-align: right">&nbsp;</td>
													</tr>
													<%
															}//end of for loop
														}//end of else
													%>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>								
							</td></tr>
							<tr>
							<td>
							<table width="80%" border="0" cellspacing="3" cellpadding="0"  class="outertable" align="center">
							<tr class="dataheader"><td  colspan="5">FEEDING EXPENDITURE</td></tr>
							<tr class="dataheader">
							<td align="center">Project Year&nbsp;</td>
							<td  align="center">Feed expenditure brooder chicks@Rs <lapschoice:CurrencyTag name="txtbrooderfeedexp" value="<%=strbrooderexp %>" size="10"  onBlur="funIncome();"/> per bird</td>
							<td  align="center">Feed expenditure grower chicks@Rs <lapschoice:CurrencyTag name="txtgrowerfeedexp" value="<%=strgrowererexp %>" size="10"  onBlur="funIncome();"/> per bird</td>
							<td  align="center">Feed expenditure layer chicks@Rs <lapschoice:CurrencyTag name="txtlayerfeedexp" value="<%=strlayerexp %>" size="10"  onBlur="funIncome();"/> per bird</td>
							<td  align="center">Total Expenditure</td>
							</tr>
							<%
							if (arryFeedRow != null && arryFeedRow.size() > 0) {
							for (int i = 1; i <= arryFeedRow.size(); i++) {
								arryCol = (ArrayList) arryFeedRow.get(i - 1);%>
							<tr  class="datagrid">
							<td align="center"><%=i %>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtbfeedingexp" size="15" style="text-align: right" value="<%=Helper.correctNull((String)arryCol.get(0)) %>"/>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtgfeedingexp" size="15" style="text-align: right" value="<%=Helper.correctNull((String)arryCol.get(1)) %>"/>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtlfeedingexp" size="15" style="text-align: right" value="<%=Helper.correctNull((String)arryCol.get(2)) %>"/>&nbsp;</td>
							<td align="center"><lapschoice:CurrencyTag name="txttotalfeedingexp" size="15" style="text-align: right" value="<%=Helper.correctNull((String)arryCol.get(3)) %>"/>&nbsp;</td>
							</tr>
							<%}}else{
								for (int i = 1; i <= strPeriod; i++) {%>
							<tr  class="datagrid">
							<td align="center"><%=i %>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtbfeedingexp" size="15" style="text-align: right" value=""/>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtgfeedingexp" size="15" style="text-align: right" value=""/>&nbsp;</td>
							<td  align="center"><lapschoice:CurrencyTag name="txtlfeedingexp" size="15" style="text-align: right" value=""/>&nbsp;</td>
							<td align="center"><lapschoice:CurrencyTag name="txttotalfeedingexp" size="15" style="text-align: right" value=""/>&nbsp;</td>
							</tr>
							<%}} %>
							</table>
							</td>
							</tr>
						</table>
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
<lapschoice:combuttonnew
	btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<%if(!strPoultryType.equalsIgnoreCase("3")) {%>
<table width="99%" border="0" cellspacing="1" cellpadding="2">
<tr>
		<td  align="center" nowrap><input type="button" value="Flock Replacement Chart" onClick="funFlockreplacement()" class="buttonStyle"></td>
</tr>
</table>
<%} %>
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
<input type="hidden" name="hidstrPeriod" value="<%=strPeriod%>">
</form>
</body>
</html>
