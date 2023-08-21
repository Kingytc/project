<%@include file="../share/directives.jsp"%>
<%	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	 nf.setGroupingUsed(false);
	  nf.setMaximumFractionDigits(2);
	  nf.setMinimumFractionDigits(2);
	  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function enableButtons(valnew,valedit,valsave,valcancel,valdelete,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdelete;
	document.forms[0].cmdclose.disabled=valclose;
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	
	document.forms[0].txtsecdesc.readOnly=true;
}

function onLoad()
{
	disableFields(true);
	if(document.forms[0].hidCategoryType.value=="OPS")
	{
		document.all.opsfld.style.visibility="visible";
		document.all.opsfld.style.position="relative";
		document.all.corpsme.style.visibility="hidden";
		document.all.corpsme.style.position="absolute";
		document.all.idops.style.visibility="visible";
		document.all.idops.style.position="relative";
	}
	else
	{
		document.all.opsfld.style.visibility="hidden";
		document.all.opsfld.style.position="absolute";
		document.all.corpsme.style.visibility="visible";
		document.all.corpsme.style.position="relative";		
		document.all.idops.style.visibility="hidden";
		document.all.idops.style.position="absolute";
	}
}
function doNew()
{
	document.forms[0].hidAction.value="Insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}
function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doSave()
{
	if(document.forms[0].txtsecdesc.value=="")
	{
		ShowAlert(111,'Security');
		document.forms[0].txtsecdesc.focus();
		return true;
	}
	if(trim(document.forms[0].txtsecdetails.value)=="")
	{
		ShowAlert(121,'Security Details');
		document.forms[0].txtsecdetails.focus();
		return true;
	}
	if(document.forms[0].selsectype.value=="S")
	{
		ShowAlert(111,'Security Type');
		document.forms[0].selsectype.focus();
		return true;
	}
	if(document.forms[0].selsectype.value=="Primary" && document.forms[0].selfacility.value=="S")
	{
		ShowAlert(111,'Facility Details');
		document.forms[0].selfacility.focus();
		return true;
	}
	if(document.forms[0].txtsecvalue.value=="" || document.forms[0].txtsecvalue.value=="0.00")
	{
		ShowAlert(121,'Security Value');
		document.forms[0].txtsecvalue.focus();
		return true;
	}
	if(document.forms[0].txtsecvaldate.value=="")
	{
		ShowAlert(121,'Security Value as On ');
		document.forms[0].txtsecvaldate.focus();
		return true;
	}
	if(document.forms[0].selcharge.value=="s")
	{
		ShowAlert(111,'Nature of Charge');
		document.forms[0].selcharge.focus();
		return true;
	}
	if(trim(document.forms[0].txtsectenor.value)=="")
	{
		ShowAlert(121,'Security Tenor');
		document.forms[0].txtsectenor.focus();
		return true;
	}
	if(document.forms[0].selsectype.value=="Primary" && trim(document.forms[0].txtsecmargin.value)=="")
	{
		ShowAlert(121,'Margin');
		document.forms[0].txtsecmargin.focus();
		return true;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hid_txt_facility_head.value =  document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].text;
	document.forms[0].hid_txt_nature_charge.value = document.forms[0].selcharge[document.forms[0].selcharge.selectedIndex].text;
	document.forms[0].hidBeanId.value="comsecurities";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/com_securities.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comsecurities";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/com_securities.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
	 	{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].hidBeanId.value="comsecurities";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/com_securities.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		 }
	}
	else
	{
		
		ShowAlert(158);
	}
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled &&  document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var varQryString = appURL+"action/staticdatahelp.jsp?id="+id;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function palceValues(val1,val2,val3,val4,val5,val6,val7,val8, val9,val10, val11,val12,val13,val14)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].hidsecid.value=val2;
	document.forms[0].txtsecdesc.value=val3;
	document.forms[0].txtsecdetails.value=document.getElementById("hidsecdesc"+val4).value;
	document.forms[0].txtsecvalue.value=val5;
	document.forms[0].txtsecvaldate.value=val6;
	document.forms[0].txtsectenor.value=val7;
	document.forms[0].selsectype.value=val8;
	
	document.forms[0].txtvaluername.value=val9;
	document.forms[0].txtinsuranceamt.value=val10;
	document.forms[0].txtinsexpdate.value=val11;
	document.forms[0].txtremarks.value=document.getElementById("hidsecremarks"+val4).value;
	document.forms[0].txt_propertyownded.value=document.getElementById("hidowned"+val4).value;
	document.forms[0].txt_legalopinion.value=document.getElementById("hidlegal"+val4).value;
	
	if(val8=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
		document.forms[0].selfacility.value=val12;
		document.forms[0].txtsecmargin.value=val13;
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].selfacility.value="S";
		document.forms[0].txtsecmargin.value="";
	}
	document.forms[0].selcharge.value=val14;	
	if(document.forms[0].btnenable.value=="Y")
	enableButtons(true,false,true,false,false,false);
}
function callFacilities()
{
	if(document.forms[0].selsectype.value=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].selfacility.value="S";
		document.forms[0].txtsecmargin.value="";
	}
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function doSecurityTypeChange(){

	if(document.forms[0].selsectype.value == 'Primary'){
		document.all.facility.style.visibility="visible";
		document.all.facility.style.position="relative";
		document.all.margin.style.visibility="visible";
		document.all.margin.style.position="relative";	
	}else{
		document.all.facility.style.visibility="hidden";
		document.all.facility.style.position="absolute";
		document.all.margin.style.visibility="hidden";
		document.all.margin.style.position="absolute";
	}
	
}
</script>
</head>
<body onload="onLoad();callFacilities();doSecurityTypeChange()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<%if (strCategoryType.equalsIgnoreCase("SRE")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; Facilities &amp; Charges</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Term Loan -&gt; Security</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc
		Limit -&gt; Security</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("CORP") && strSessionModuleType.equalsIgnoreCase("CORP")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt;
		Application -&gt; Securities -&gt; Details of Charges on Security/s</td>
	</tr>
	<%} else if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt;
		Application -&gt; Securities -&gt; Details of Charges on Security/s</td>
	</tr>
	<%}
	else if (strCategoryType.equalsIgnoreCase("OPS")) {%>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Application -&gt;
		Securities -&gt; Details of Charges on Security/s</td>

	</tr>
	<%}%>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
<%if (!strCategoryType.equalsIgnoreCase("SRE")
			&& !strCategoryType.equalsIgnoreCase("STL")
			&& !strCategoryType.equalsIgnoreCase("ADC")) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td align="center" nowrap class="sub_tab_active"><b>Details of Charges on Security/s</b></td>
				<%if (strCategoryType.equalsIgnoreCase("OPS")) {%>
				<td align="center" nowrap class="sub_tab_inactive">
				<b><a href="#" onClick="javascript:gotoTab(appURL,'comrepayschedule','getTermFinanceFac','com_fac_repayment.jsp')">Repayment Schedule</a></b></td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}%> 
<lapschoice:hiddentag pageid='<%=PageId%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>Security Type <span class="mantatory"><b>*</b></span></td>
						<td><select name="selsectype" onchange="callFacilities();doSecurityTypeChange()">
							<option value="S" selected>&lt;---Select---&gt;</option>
							<option value="Primary">Primary</option>
							<option value="Collateral">Collateral</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr id="idfacility">
						<td>Facility<span id="facility" class="mantatory"><b>*</b></span></td>
						<td><select name="selfacility">
							<option value="S" selected>&lt;---Select---&gt;</option>
							<lapschoice:comtermscond />
						</select></td>
						<td>Margin<span id="margin" class="mantatory"><b>*</b></span></td>
						<td><lapschoice:CurrencyTag name="txtsecmargin" size="7" maxlength="5" onBlur="checkPercentage(this)" /></td>
					</tr>
					<tr>
						<td valign="top">Security <span class="mantatory"><b>*</b></span></td>
						<td><input type="text" name="txtsecdesc" size="70"
							maxlength="100" /> <input type="hidden" name="hidsecid" /> <span
							onClick="callDescHelp('12')" style="cursor: hand"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></td>
						<td width="15%">Nature of Charge<span class="mantatory"><b>*</b></span></td>
						<td width="28%"><select name="selcharge">
							<option value="s" selected>&lt;--Select--&gt;</option>
							<option value="1">Exclusive</option>
							<option value="2">First &amp; Parri-passu</option>
							<option value="3">Second &amp; Exclusive</option>
							<option value="4">Second &amp; Parri-passu</option>
							<option value="5">Subservient &amp; Exclusive</option>
							<option value="6">Subservient &amp; Parri-passu</option>
							<option value="7">Unsecured</option>
						</select></td>
					</tr>
					<tr>
						<td valign="top">Security Details<span class="mantatory"><b>*</b></span></td> 
						<td valign="top"><textarea name="txtsecdetails" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
						<td valign="top"></td>
						<td></td>
					</tr>
					<tr>
						<td valign="top">Security Value <span class="mantatory"><b>*</b></span></td>
						<td valign="top"><lapschoice:CurrencyTag name="txtsecvalue" size="15" maxlength="12" onBlur="roundtxt(this)"/></td>
						<td>Security Value as On <span class="mantatory"><b>*</b></span></td>
						<td><input type="text" name="txtsecvaldate" size="12"
							maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)">
						<a alt="Select date from calender" href="#"
							onClick="callCalender('txtsecvaldate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
					</tr>
					<tr>
						<td>Valuers Name</td>
						<td><input type="text" name="txtvaluername" onKeyPress="allowAlphabetsForName()" size="70" maxlength="80"></td>
						<td>Security Tenor<span class="mantatory"><b>*</b></span><br>(In Months)
						</td>
						<td><input type="text" name="txtsectenor" size="5" maxlength="3" onKeyPress="allowNumber(this)" /></td>
					</tr>
					<tr>
						<td>Insurance Amount</td>
						<td><lapschoice:CurrencyTag name="txtinsuranceamt" size="15" maxlength="10" onBlur="roundtxt(this)"/></td>
						<td>Insurance Expiry Date</td>
						<td><input type="text" name="txtinsexpdate" size="12"
							maxlength="10"
							onBlur="checkDate(this);checkmindate(this,currentDate)">
						<a alt="Select date from calender" href="#"
							onClick="callCalender('txtinsexpdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
					</tr>
					<tr id="opsfld">
						<td>Owned By</td>
						<td><textarea rows="4" name="txt_propertyownded" cols="25" tabindex="2" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea></td>
						<td>Legal Opinion</td>
						<td><textarea rows="4" name="txt_legalopinion" cols="50" tabindex="5" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)"></textarea></td>
					</tr>
					<tr>
						<td valign="top"><span id="corpsme">Remarks</span>&nbsp;<span
							id="idops">Encumbrance if any</span></td>
						<td><textarea name="txtremarks" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
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
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<tr class="dataheader">
		<td>&nbsp;</td>
		<td><b>Security</b></td>
		<td><b>Security Details</b></td>
		<td><b>Security Value</b></td>
		<td><b>Value as On</b></td>
		<td><b>Security Tenor(In Months)</b></td>
	</tr>
	<%
		if (arrRow != null && arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
	%>
	<tr valign="top"  class="datagrid">
		<td width="3%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String) arrCol.get(0))%>',
			'<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>',
			'<%=i%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>',
			'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>',
			'<%=Helper.correctNull((String) arrCol.get(7))%>', '<%=Helper.replaceForJavaScriptString((String) arrCol
									.get(8))%>',
			'<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(9))))%>', '<%=Helper.correctNull((String) arrCol.get(10))%>',
			'<%=Helper.correctNull((String) arrCol.get(12))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(13))))%>',
			'<%=Helper.correctNull((String) arrCol.get(14))%>')"
			style="border: none"> <input type="hidden"
			name="hidsecdesc<%=i%>"
			value="<%=Helper.correctNull((String) arrCol.get(3))%>"> <input
			type="hidden" name="hidsecremarks<%=i%>"
			value="<%=Helper.correctNull((String) arrCol.get(11))%>"> <input
			type="hidden" name="hidowned<%=i%>"
			value="<%=Helper.correctNull((String) arrCol.get(15))%>"> <input
			type="hidden" name="hidlegal<%=i%>"
			value="<%=Helper.correctNull((String) arrCol.get(16))%>"></td>
		<td width="31%"><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
		<td width="34%"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
		<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>&nbsp;</td>
		<td width="10%"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
		<td width="10%"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
	</tr>
	<%}}%>
</table>
<input type="hidden" name="hidsno" /> 
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hid_txt_facility_head" value ="">
<input type="hidden" name="hid_txt_nature_charge" value="">
</form>
</body>
</html>


