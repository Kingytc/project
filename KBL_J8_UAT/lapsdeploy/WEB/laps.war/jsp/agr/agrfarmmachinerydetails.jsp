<%@include file="../share/directives.jsp"%>

<%	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String schemetype="";	
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));

	HashMap hshFarmMachinery = new HashMap();
	if (hshValues != null) {
		hshFarmMachinery = (HashMap) hshValues.get("hshFarmMachinery");

	}	
	double dblProjectCost=Double.parseDouble(Helper.correctDouble(Helper.correctDouble((String) hshValues.get("PROJECTCOST"))));
	String strAgrScheme = Helper.correctNull((String) request.getParameter("agrscheme"));
	
	if(!strAgrScheme.equalsIgnoreCase(""))
	{
		//dblProjectCost = dblProjectCost * 100000;
	}
	
	String strschemetype="",strfacsno="",stragrschemetype="";
	HashMap hshScheme = new HashMap();
	hshScheme = Helper.splitScheme(schemetype);
	if(hshScheme!=null)
	{
		strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
		if(strfacsno.equalsIgnoreCase(""))
			strfacsno = Helper.correctNull((String)hshFarmMachinery.get("facsno"));
		stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		if(stragrschemetype.equalsIgnoreCase(""))
			stragrschemetype = Helper.correctNull((String)hshFarmMachinery.get("schemetype"));
	}
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	
%>

<html>
<head>
<title>Agriculture - Farm Machineries Details</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varprojectcost="<%=nf.format(dblProjectCost)%>";
var state_name = "<%=Helper.correctNull((String) hshFarmMachinery.get("state"))%>";
var varschemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callonLoad()
{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		if(appstatus=="Open/Pending")
		{
			disablebuttons(false,true,true,true,false);
			
		}
		else
		{
			disablebuttons(true,true,true,true,false);
		}
	}
	else
	{
		disablebuttons(true,true,true,true,false);
	}
	disabledFields(true);

	document.forms[0].sel_typeofvehicle.value="<%=Helper.correctNull((String)hshFarmMachinery.get("vehicleType"))%>";
	document.forms[0].sel_authoriseddealer.value="<%=Helper.correctNull((String)hshFarmMachinery.get("authoriseddealer"))%>";
	if(state_name!="")
	{
		document.forms[0].txt_state.value=state_name;
	}	
	document.forms[0].txt_costoftractor.value="<%=Helper.correctDouble((String)hshFarmMachinery.get("costoftractor"))%>";
	document.forms[0].txt_costofimplements.value="<%=Helper.correctDouble((String) hshFarmMachinery.get("costofimpliment"))%>";
	document.forms[0].txt_totalcost.value="<%=Helper.correctDouble((String) hshFarmMachinery.get("totalcost"))%>";
	document.forms[0].txt_othercost.value="<%=Helper.correctDouble((String) hshFarmMachinery.get("othercost"))%>";
	roundtxt(document.forms[0].txt_costoftractor);
	roundtxt(document.forms[0].txt_costofimplements);
	roundtxt(document.forms[0].txt_totalcost);
	roundtxt(document.forms[0].txt_othercost);
	
	document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value=varschemetype;
}

function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function showFields()
{
	if(document.forms[0].sel_typeofvehicle.value=="N")
	{
		document.forms[0].txt_dateofvaluation.readOnly=true;
		document.forms[0].txt_dateofvaluation.value="";
	}
	else if(document.forms[0].sel_typeofvehicle.value=="O")
	{
		document.forms[0].txt_dateofvaluation.readOnly=false;
	}
}

function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disablebuttons(true, false, false, false, true);
	document.forms[0].txt_totalcost.readOnly=true;
	document.forms[0].txt_brandname.readOnly=true;
	//document.forms[0].sel_typeofvehicle.value="N";
	document.forms[0].sel_typeofvehicle.disabled=false;
	showFields();
}

function disablebuttons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled = bool1;
	document.forms[0].cmdsave.disabled = bool2;
	document.forms[0].cmdcancel.disabled = bool3;
	document.forms[0].cmddelete.disabled = bool4;
	document.forms[0].cmdclose.disabled = bool5;
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
	if(document.forms[0].txt_brandname.value=="")
	{
		 alert('Select Brand Name');
		 document.forms[0].txt_brandname.focus();
		 return;
	}
	disablebuttons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrfarmmachinery";
	document.forms[0].hidBeanMethod.value="updateFarmMachineryDetails";
	document.forms[0].hidBeanGetMethod.value="getFarmMachineryDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agrfarmmachinerydetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doDelete()
{	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanMethod.value="updateFarmMachineryDetails";
		document.forms[0].hidBeanGetMethod.value="getFarmMachineryDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agrfarmmachinerydetails.jsp";
		document.forms[0].submit();
	 }
}

function calculateTotal()
{
	document.forms[0].txt_totalcost.value=parseFloat(document.forms[0].txt_costoftractor.value)+
											parseFloat(document.forms[0].txt_costofimplements.value)+
											parseFloat(document.forms[0].txt_othercost.value);
	roundtxt(document.forms[0].txt_totalcost);
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {

	    document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanGetMethod.value="getFarmMachineryDetails";
	    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfarmmachinerydetails.jsp";
		document.forms[0].hidSourceUrl.value="/action/agrfarmmachinerydetails.jsp";
		document.forms[0].method="post";	
		document.forms[0].submit();
	 }	
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
}
function callBrandHelp(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		   	var varQryString =appURL+"action/searchbrandnamehelp.jsp?hidBeanId=staticdata&hidBeanGetMethod=getData&seldataheadtype="+val;
			var title="Brandname";
			var prop = "scrollbars=no,width=500,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);
			
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonLoad()">
<!-- <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
				if (document.all && window.print)
				{
					ie5menu.className = menuskin;
					document.oncontextmenu = showmenuie5;
					document.body.onclick = hidemenuie5;
				}
				</script></div>
</div>-->
<form name="frmimp" method="post" class="normal">
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
      <td class="page_flow">Home -> Agriculture -> Farm Mechanism Implements</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="59" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<jsp:include page="../share/help.jsp" flush="true" />
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe> 
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<TR>
				<TD WIDTH="50%" VALIGN="top" HEIGHT="91">
				<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
					<TR  CLASS="dataheader">
						<TD COLSPAN="6" align="Center">Machinery</TD>
					</TR>
					<TR>
						<TD WIDTH="22%" nowrap ID="res1">Category<B></B></TD>
						<TD ID="res2" WIDTH="32%"><INPUT TYPE="text"
							NAME="txt_category" SIZE="40" MAXLENGTH="50" TABINDEX="1"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("category"))%>"></TD>
						<TD ID="res2" WIDTH="23%">Type of Machinery<B></B></TD>
						<TD ID="res2" COLSPAN="2"><SELECT NAME="sel_typeofvehicle"
							tabindex="2" onChange="">
							<option value="" selected>----Select----</option>
							<option value="N">New</option>
							<option value="O">Used</option>
						</SELECT></TD>
					</TR>
					<tr>
						<Td WIDTH="22%"></td>
					</tr>
					<TR>
						<TD WIDTH="22%" >Brand Name <span id="id_brandname" class="mantatory">*</span></TD>
						<TD VALIGN="top" WIDTH="32%"><INPUT TYPE="text"
							NAME="txt_brandname" SIZE="40" MAXLENGTH="50" TABINDEX="3"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("brandname"))%>">&nbsp;<span onClick="callBrandHelp('151')" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span></TD>
						<TD VALIGN="top" WIDTH="23%">Make &amp; Model<B></B></TD>
						<TD VALIGN="top" WIDTH="16%"><INPUT TYPE="text" TABINDEX="4"
							NAME="txt_make" MAXLENGTH="50"
							value="<%=Helper.correctNull((String) hshFarmMachinery
									.get("make"))%>"></TD>
						<TD VALIGN="top" WIDTH="7%"><INPUT TYPE="text" TABINDEX="5"
							value="<%=Helper.correctNull((String) hshFarmMachinery
									.get("model"))%>"
							NAME="txt_model" size="8" MAXLENGTH="4"
							onKeyPress="allowDecimals(this)"></TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<TR>
				<TD WIDTH="50%" VALIGN="top">
				<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
					<TR CLASS="dataheader">
						<TD COLSPAN="5">Machinery Cost Details</TD>
					</TR>
					<TR>
						<TD WIDTH="22%" ID="res1">Cost of Machinery</TD>
						<TD ID="res2" WIDTH="32%">&nbsp;<lapschoice:CurrencyTag
							name="txt_costoftractor" maxlength="15" tabindex="6" size="15"
							onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="roundtxt(this);calculateTotal()" other="readOnly" /></TD>
						<TD WIDTH="19%">Cost of Implements<B><FONT COLOR=red></FONT></B></TD>
						<TD VALIGN="top" WIDTH="32%">&nbsp;<lapschoice:CurrencyTag
							name="txt_costofimplements" maxlength="15" tabindex="8" size="15"
							onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="roundtxt(this);calculateTotal()" other="readOnly" /></TD>
						<TD VALIGN="top" WIDTH="23%">&nbsp;<B></B></TD>
						<TD VALIGN="top" WIDTH="23%">
						<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
							<TR>
								<TD><INPUT TYPE="hidden" SIZE="11" NAME="txt_dateofvaluation"
									TABINDEX="14" ONBLUR="checkDate(this);"
									VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("dateofvaluation"))%>"></TD>
								
							</TR>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD WIDTH="22%">Others (if any)<br><INPUT TYPE="text"
							NAME="txt_others" SIZE="35" MAXLENGTH="50" TABINDEX="9"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("others"))%>"></TD>
						<TD VALIGN="bottom" WIDTH="32%">&nbsp;<lapschoice:CurrencyTag
							name="txt_othercost" maxlength="15" tabindex="10" size="15"
							onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="roundtxt(this);calculateTotal()" other="readOnly" /></TD>
						<TD WIDTH="22%">Total Cost</TD>
						<TD VALIGN="top" WIDTH="32%">&nbsp;<lapschoice:CurrencyTag
							name="txt_totalcost" maxlength="15"  size="15"
							onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="roundtxt(this);" other="readOnly" /></TD>
						<TD WIDTH="23%">&nbsp;</TD>
						<TD WIDTH="23%">&nbsp;</TD>
					</TR>
					
					<TR>
						<TD WIDTH="22%">Date of Proforma Invoice<B></B></TD>
						<TD WIDTH="32%">
						<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
							<TR>
								<TD><INPUT TYPE="text" SIZE="11" NAME="txt_dateofproforma"
									value="<%=Helper.correctNull((String) hshFarmMachinery
							.get("proformadate"))%>"
									TABINDEX="11" ONBLUR="checkDate(this);"></TD>
								<TD><A HREF="#"
									ONCLICK="callCalender('txt_dateofproforma')"
									TITLE="Click to view calender" BORDER=0><IMG
									SRC="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									BORDER="0" tabindex="12"></A></TD>
							</TR>
						</TABLE>
						</TD>
						<TD WIDTH="23%">Depreciation %</TD>
						<TD WIDTH="32%"><INPUT TYPE="text" SIZE="11" NAME="txt_deprciation" TABINDEX="11" onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="checkPercentage(this)" other="readOnly" value="<%=Helper.correctNull((String) hshFarmMachinery.get("agr_fam_depriciation"))%>">
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<TR>
				<TD WIDTH="50%" VALIGN="top">
				<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
					<TR>
						<TD COLSPAN="5" CLASS="dataheader">Communication Address</TD>
					</TR>
					<TR>
						<TD WIDTH="23%" nowrap ID="res1">Name of the Dealer / Seller<B></B></TD>
						<TD ID="res2" WIDTH="31%"><INPUT TYPE="text"
							NAME="txt_nameofdealer" SIZE="40" MAXLENGTH="45" TABINDEX="16"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("nameofdealer"))%>"></TD>
						<TD ID="res2" WIDTH="23%">Authorised Delaer<B></B></TD>
						<TD ID="res2" WIDTH="23%"><SELECT NAME="sel_authoriseddealer"
							TABINDEX="17">
							<option value="">----Select----</option>
							<OPTION VALUE="Y">Yes</OPTION>
							<OPTION VALUE="N">No</OPTION>
						</SELECT></TD>
					</TR>
					<tr>
						<Td WIDTH="23%"></td>
					</tr>
					<TR>
						<TD WIDTH="23%">Dealer Since</TD>
						<TD VALIGN="top" WIDTH="31%"><INPUT TYPE="text"
							NAME="txt_dealersince" SIZE="8" MAXLENGTH="4" TABINDEX="18"
							onKeyPress="allowDecimals(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("dealersince"))%>"></TD>
						<TD VALIGN="top" WIDTH="23%">Expected Date of Delivery<B></B></TD>
						<TD VALIGN="top" WIDTH="23%">
						<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
							<TR>
								<TD><INPUT TYPE="text" SIZE="11" NAME="txt_dateofdelivery"
									VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("dateofdelivery"))%>"
									tabindex="19" onBlur="checkDate(this);"></TD>
								<TD><A HREF="#"
									ONCLICK="callCalender('txt_dateofdelivery')"
									TITLE="Click to view calender" BORDER=0><IMG
									SRC="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									BORDER="0" TABINDEX="20" ></A></TD>
							</TR>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD WIDTH="23%">Address 1&nbsp;<B></B></TD>
						<TD VALIGN="top" WIDTH="31%"><INPUT TYPE="text"
							NAME="txt_address1" SIZE="40" MAXLENGTH="45" TABINDEX="21"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("address1"))%>">
						</TD>
						<TD WIDTH="23%">District <B></B></TD>
						<TD WIDTH="31%">
							<INPUT TYPE="text" NAME="txt_district" SIZE="30" MAXLENGTH="60" TABINDEX="24"
								ONKEYPRESS="allowAlphabetsAndSpaceInt(this)" 
								VALUE="<%=Helper.correctNull((String) hshFarmMachinery.get("district"))%>">
						</TD>
					</TR>
					<TR>
						<TD WIDTH="23%">Address 2</TD>
						<TD VALIGN="top" WIDTH="31%"><INPUT TYPE="text"
							NAME="txt_address2" SIZE="40" MAXLENGTH="45" TABINDEX="22"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("address2"))%>">
						</TD>
						<TD WIDTH="23%">State<B></B></TD>
						<TD WIDTH="23%"><INPUT TYPE="hidden" NAME="txt_commstatecode"
							SIZE="18" MAXLENGTH="20"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("state"))%>"
							ONKEYPRESS="allowAlphabets_alt()"> <SELECT
							NAME="txt_state" TABINDEX="25">
							<OPTION VALUE="0" selected>---Select ---</OPTION>
							<lapschoice:statemaster/>
					</SELECT></TD>
					</TR>
					<TR>
					<TD VALIGN="top" WIDTH="23%">City / Town / Village<B></B></TD>
						<TD VALIGN="top" WIDTH="23%"><INPUT TYPE="hidden"
							NAME="txt_commcitycode" SIZE="18" MAXLENGTH="20"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("pc_comuncity_code"))%>"
							ONKEYPRESS="allowAlphabets_alt()"> <INPUT TYPE="text"
							NAME="txt_city" SIZE="40" MAXLENGTH="60" TABINDEX="23"
							ONKEYPRESS="allowAlphabetsAndSpaceInt(this)"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
									.get("city"))%>"></TD>
						
						<TD WIDTH="23%">Pin Code<B></B></TD>
						<TD WIDTH="23%"><INPUT TYPE="text" NAME="txt_pincode"
							SIZE="12" MAXLENGTH="6" STYLE="text-align: left" TABINDEX="26"
							VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("pincode"))%>"
							ONBLUR="zipvalidate(this,6)" ONKEYPRESS="allowNumber(this)"></TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		<TABLE WIDTH="662">
			<TR>
				<TD WIDTH="577"><B>Remarks</B></TD>
			</TR>
			<TR>
				<TD WIDTH="577"><TEXTAREA NAME="txtarea_comments" COLS="150"
					ROWS="3" TABINDEX="27" ONKEYUP="textlimit(this,3900);"
					ONKEYDOWN="textlimit(this,3900);" ONKEYPRESS="textlimit(this,3999);notAllowSingleAndDoubleQuote()" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String) hshFarmMachinery
							.get("comments"))%></TEXTAREA></TD>
			</TR>
		</TABLE>
		<tr><td>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>">
<INPUT TYPE="hidden" NAME="hidOtherMethod" VALUE="">
<INPUT TYPE="hidden" NAME="hidAppType" VALUE="">
<INPUT TYPE="hidden" NAME="hidfacsno" VALUE="<%=strfacsno%>">
<INPUT TYPE="hidden" NAME="hidscheme" VALUE="<%=stragrschemetype%>">
</form>
</body>
</html>