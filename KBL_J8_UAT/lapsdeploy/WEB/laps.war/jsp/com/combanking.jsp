<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
            String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();	
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			int vecsize = 0;
			if (hshValues != null) {
				vecData = (ArrayList) hshValues.get("vecData");
			}
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			 
%>
<html>
<head>
<title>Commercial-Principal (s)</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
function callModFac(val)
{
	if(val=="s")
	{
		val="";
	}
	if(document.forms[0].sel_Bank.value!="")
	{
		 document.all.ifrFacilityDesc.src =appURL+"action/IframeFacilityDesc.jsp?hidBeanId=combanking&hidBeanGetMethod=getWCFacilitiesData&appno="+document.forms[0].hidappno.value+"&strModType="+document.forms[0].sel_Module.value+"&strFacType=1&val1="+val; 
	}
	
	
}
function calSelectBank()
{
	if(checktrim(document.forms[0].sel_Bank.value)=="")
	{
		alert("Select whether our bank or other bank");
		document.forms[0].txt_Bank.value="";
	}
}
function calBankFun()
{
	if(document.forms[0].sel_Bank.value=="Our")
	{
		document.forms[0].txt_Bank.value="Karnataka Bank";
		doHide("none");
	}
	else if(document.forms[0].sel_Bank.value=="Other")
	{
		document.forms[0].txt_Bank.value="";
		doHide("block");
	}
	else
	{
		document.forms[0].txt_Bank.value="";
		doHide("none");
	}
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20)
{
	document.forms[0].sel_Module.value=val20;
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno.value = val0;
	appno=document.forms[0].appno.value;
	document.forms[0].sel_Bank.value=val11;
	calBankFun();
	if(document.forms[0].sel_Bank.value=="Our")
	{
		callModFac(val1);
		document.forms[0].sel_Facility.value=val1;
		doHide("none");
	}
	else
	{
		document.forms[0].txt_Facility.value=val1;
		doHide("block");
	}
	document.forms[0].idno.value=val0;
	document.forms[0].txt_OSAsOnDate.value=val2;
	document.forms[0].sel_BnkType.value=val3;
	document.forms[0].sel_IntType.value=val4;
	document.forms[0].sel_CreditType.value=val5;
	document.forms[0].txt_SancRefNo.value=val6;
	document.forms[0].txt_SancDate.value=val7;
	document.forms[0].txt_DueDate.value=val8;
	document.forms[0].txtArea_Arrears.value=val9;
	document.forms[0].sel_CompName.value=val10;
	document.forms[0].txt_Bank.value=val12;
	document.forms[0].sel_Type.value=val13;
	document.forms[0].txt_Limit.value=val14;
	document.forms[0].txt_OS.value=val15;
	document.forms[0].txt_SpreadVal.value=val16;
	document.forms[0].txtarea_Remarks.value=val17;
	document.forms[0].hidFacSNo.value=val19;
	
	
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,true,true,true,false);
	}
}
function doSave()
{
	if(document.forms[0].sel_Bank.value=="")
	{
		ShowAlert(111,"Bank");
		document.forms[0].sel_Bank.focus();
		return;
	}
	else if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_Facility.value=="")
		{
			ShowAlert(111,"Facility");
			document.forms[0].sel_Facility.focus();
			return;
		}
	}
	else if(document.forms[0].sel_Bank.value=="Other")
	{
		if(document.forms[0].txt_Bank.value=="")
		{
			ShowAlert(121,"Name of the Bank");
			document.forms[0].txt_Bank.focus();
			return;
		}
		if(document.forms[0].sel_Type.value=="")
		{
			ShowAlert(111,"Type");
			document.forms[0].sel_Type.focus();
			return;
		}
		if(document.forms[0].txt_Facility.value=="")
		{
			ShowAlert(121,"Facility");
			document.forms[0].txt_Facility.focus();
			return;
		}
	}
	if(document.forms[0].txt_Limit.value=="")
	{
		ShowAlert(121,"Limit");
		document.forms[0].txt_Limit.focus();
		return;
	}
	if(document.forms[0].txt_OS.value=="")
	{
		ShowAlert(121,"Outstanding");
		document.forms[0].txt_OS.focus();
		return;
	}
	if(document.forms[0].txt_OSAsOnDate.value=="")
	{
		ShowAlert(121,"Outstanding as on Date");
		document.forms[0].txt_OSAsOnDate.focus();
		return;
	}
	if(document.forms[0].sel_BnkType.value=="")
	{
		ShowAlert(111,"Banking Type");
		document.forms[0].sel_BnkType.focus();
		return;
	}
	if(document.forms[0].sel_IntType.value=="")
	{
		ShowAlert(111,"Interest Type");
		document.forms[0].sel_IntType.focus();
		return;
	}
	if(document.forms[0].txt_SpreadVal.value=="")
	{
		ShowAlert(121,"Spread Value");
		document.forms[0].txt_SpreadVal.focus();
		return;
	}
	if(document.forms[0].sel_CreditType.value=="")
	{
		ShowAlert(111,"Type of Credit");
		document.forms[0].sel_CreditType.focus();
		return;
	}


	
	document.forms[0].sel_Bank.disabled=false;
	if(document.forms[0].sel_Bank.value=="Our")
	{
		 document.forms[0].sel_Module.disabled=false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].sel_CompName.disabled=false;
	document.forms[0].sel_Type.disabled=false;
	document.forms[0].sel_Facility.disabled=false;
	document.forms[0].sel_BnkType.disabled=false;
	document.forms[0].sel_IntType.disabled=false;
	document.forms[0].sel_CreditType.disabled=false;
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidSourceUrl.value="/action/combanking.jsp";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_CreditType.value=="P")
		{
			document.forms[0].txt_Bank.value="Karnataka Bank";
			document.forms[0].txt_Bank.readOnly=true;
			document.forms[0].sel_Bank.disabled=true;
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].txt_Limit.readOnly=true;
			document.forms[0].txt_OS.focus();
			document.forms[0].sel_Module.disabled=true;
			disableCommandButtons(true,true,false,false,true,true);
		}
		else
		{
			disableCommandButtons(true,true,false,false,false,true);
			document.forms[0].sel_Bank.focus();
		}
	}
	else
	{
		disableCommandButtons(true,true,false,false,false,true);
		document.forms[0].sel_Bank.focus();
	}
	document.forms[0].sel_CompName.disabled=true;
	document.forms[0].sel_CreditType.disabled=true;
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
	doHide("block");
	document.forms[0].txt_Bank.value="";	  
	document.forms[0].sel_Bank.value="";
	document.forms[0].sel_CompName.value="0";
	document.forms[0].sel_Type.value="";
	document.forms[0].txt_Facility.value="";
	document.forms[0].sel_Facility.value="";
	document.forms[0].txt_Limit.value="";
	document.forms[0].txt_OS.value="";
	document.forms[0].txt_SpreadVal.value="";
	document.forms[0].txt_OSAsOnDate.value="";
	document.forms[0].sel_BnkType.value="";
	document.forms[0].sel_IntType.value="";
	document.forms[0].sel_CreditType.value="";
	document.forms[0].txtarea_Remarks.value="";
	document.forms[0].hidflag.value ="new";
	document.forms[0].hidAction.value ="insert";	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}
	}
	document.forms[0].sel_Bank.value='Other';
	document.forms[0].sel_CreditType.value="E";
	document.forms[0].sel_CreditType.disabled=true;
	document.forms[0].sel_CompName.disabled=true;
	document.forms[0].sel_Bank.focus();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/combanking.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function disableFields(val)
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].sel_Bank.disabled=false;
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp"
			document.forms[0].hidBeanMethod.value="updateData";	
			document.forms[0].hidBeanGetMethod.value="getData";		
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="action/combanking.jsp";
			document.forms[0].submit();
		}
	}	
	else
	{
		ShowAlert(158);
	}
}
function onloading()
{
	disableFields(true);
	doHide("none");
	 
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function doHide(val)
{
	document.all.id_BnkNameLbl.style.display=val;
	document.all.id_BnkNameTxt.style.display=val;
	document.all.id_TypeLbl.style.display=val;
	document.all.id_TypeTxt.style.display=val;
	document.all.id_FacilityTxt.style.display=val;
	if(val=="block")
	{
		document.all.id_FacilitySel.style.display="none";
		document.all.id_Module.style.display="none";
		document.all.id_ModuleVal.style.display="none";
	}
	else if(val=="none")
	{
		document.all.id_FacilitySel.style.display="table-cell";
		document.all.id_Module.style.display="table-cell";
		document.all.id_ModuleVal.style.display="table-cell";
	} 
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<style>
.selectwidth
{
	width: 150px;
}
</style>
</head>
<body onLoad="onloading()">
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
<form name="frmpri" method="post" class="normal"><iframe height="0" width="0" id="ifrm"
	frameborder="0" style="border:0"></iframe>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" colSpan="5"><jsp:include
					page="../share/applurllinkscom.jsp" flush="true">
					<jsp:param name="pageid" value="3" />
					<jsp:param name="cattype" value="<%=strCategoryType%>" />
					<jsp:param name="ssitype" value="<%=strSSIType%>" />
				</jsp:include></td>
			</tr>
			<%if (strSessionModuleType.equalsIgnoreCase("AGR")) {
				%>
				<tr>
					<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Banking Arrangement -&gt; Banking Details</td>
				</tr>
				<%
				}else if (strCategoryType.equalsIgnoreCase("SRE")) {%>
			<tr>
				<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
				Review/Extension -&gt; Banking Arrangement -&gt; Working Capital</td>
			</tr>

			<%}else{
				%>
			<tr>
				<td class="page_flow">Home
				-&gt; Corporate &amp; SME -&gt; Application-&gt; Banking Arrangement
				-&gt; Working Capital</td>
			</tr>
			<%}

			%>
		</table>
		</td>
	</tr>
</table>

<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable"  width="60%">
			<tr align="center">
				<%if (!strCategoryType.equals("STL")) {%>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b> <a
					href="#" onclick="javascript:gotoTab(appURL,'comproposal','getBankingDetails','com_operdet.jsp')">Banking
				Arrangement </a> </b></td>
				<%}

			%>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Working Capital</b></td>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Term
				Finance </a></b></td>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Banking Details </a></b></td>
				<%if (strCategoryType.equals("CORP") || strCategoryType.equals("SME")) {

			%>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive" nowrap="nowrap"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'combanking','getRepayData','comrepayment.jsp')">
				Repayment of Existing loans</a></b></td>
			<%}%>

			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center">Company Name</td>
										<td align="center">Bank</td>
										<td align="center" id="id_Module">Module</td>
										<td align="center" id="id_BnkNameLbl">Name of the Bank</td>
										<td align="center" id="id_TypeLbl">Type</td>
										<td align="center" colspan="2">Facility</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center">
											<select name="sel_CompName" class="selectwidth">
												<%String name_company = request.getParameter("comapp_compname");%>
												<option value="0"><%=name_company%></option>
											</select>
										</td>
										<td align="center">
											<select name="sel_Bank" class="selectwidth" onChange="javascript:calBankFun()" tabindex="1">
												<option value="">--select--</option>
												<option value="Our">Karnataka Bank</option>
												<option value="Other">Other bank</option>
											</select>
										</td>
										<td align="center" id="id_ModuleVal">
											<select name="sel_Module" class="selectwidth" onChange="callModFac('s');" tabindex="1">
												<option value="s">--select--</option>
												<option value="c">Corporate</option>
												<option value="a">Agriculture</option>
											</select>
										</td>
										
										
										<td align="center" id="id_BnkNameTxt">
											<input type="text" name="txt_Bank" value="" size="30" readOnly="readonly"  tabindex="2"
												maxlength="50" onBlur="calSelectBank()"
												onKeyPress="notAllowSplChar()">
										</td>
										<td align="center" id="id_TypeTxt">
											<select name="sel_Type" tabindex="3">
												<option value="" selected="selected">---Select---</option>
												<option value="F">Funded</option>
												<option value="N">NonFunded</option>
											</select>
										</td>
										<td align="center" colspan="2" id="id_FacilityTxt">
											<input type="text" name="txt_Facility" value="" size="40" tabindex="4"
												maxlength="50" onBlur="calSelectBank()"
												onKeyPress="notAllowSplChar()">
										</td>
										<td align="center" colspan="2" id="id_FacilitySel">
											<select name="sel_Facility" tabindex="5" style="width:250px">
											<option value="" selected="selected">---Select---</option>
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Limit</td>
									<td align="center">Outstanding</td>
									<td align="center">Outstanding as on Date</td>
									<td align="center">Banking Type</td>
									<td align="center">Interest Type</td>
									<td align="center">Spread Value</td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<lapschoice:CurrencyTag name="txt_Limit"
											maxlength="15" size="12" tabindex="6"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_OS"
											maxlength="15" size="12" tabindex="7"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_OSAsOnDate" tabindex="9"
													onBlur="checkDate(this);checkmaxdate(this,currdate)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="8"
												href="javascript:callCalender('txt_OSAsOnDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center">
										<select name="sel_BnkType" tabindex="9">
											<option value="">--Select--</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple</option>
										</select>
									</td>
									<td align="center">
										<select name="sel_IntType" tabindex="10">
											<option value="">--Select--</option>
											<option value="BR">Base Rate</option>
											<option value="BPLR">BPLR</option>
										</select>
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_SpreadVal"
											maxlength="6" size="12" tabindex="11"
											style="text-align:right" onKeyPress="allowDecimals(this)"
											onBlur="roundtxt(this);checkPercentage(this);" />
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Type of Credit</td>
									<td align="center">Sanction Reference Number</td>
									<td align="center">Sanctioned Date</td>
									<td align="center">Due Date</td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<select name="sel_CreditType" disabled="disabled" tabindex="12">
											<option value="" selected="selected">--select--</option>
											<option value="E">Existing</option>
											<option value="P">Proposed</option>
										</select>
									</td>
									<td align="center">
										<input type="text" name="txt_SancRefNo" value="" size="30"
												tabindex="13" maxlength="30" onKeyPress="allowAlphaNumeric()">
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_SancDate" tabindex="15"
													onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_DueDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="14"
												href="javascript:callCalender('txt_SancDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_DueDate" tabindex="16"
													onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_SancDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="15"
												href="javascript:callCalender('txt_DueDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center">Arrears if any</td>
										<td align="center">Remarks</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center">
											<textarea name="txtArea_Arrears" cols="50" style="text-align:left" tabindex="16"
												rows="3" onKeyPress="textlimit(document.forms[0].txtArea_Arrears,499)" onKeyUp="textlimit(this,499)"></textarea>
										</td>
										<td align="center">
											<textarea name="txtarea_Remarks" cols="50" style="text-align:left" tabindex="17"
												rows="3" onKeyPress="textlimit(document.forms[0].txtarea_Remarks,499)" onKeyUp="textlimit(this,499)"></textarea>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="19%" align="center">Name of the Bank</td>
										<td width="21%" align="center">Facility</td>
										<td width="19%" align="center">Limit</td>
										<td width="19%" align="center">Banking Type</td>
										<td width="19%" align="center">Type of Credit</td>
									</tr>
									<%
									if (vecData != null)
									{
										vecsize = vecData.size();
									}
									String strSno = "";
									double strLFE = 0.00;
									double strLNFE = 0.00;
									double strLFP = 0.00;
									double strLNFP = 0.00;
									double strOSF = 0.00;
									double strOSNF = 0.00;
									for (int i = 0; i < vecsize; i++)
									{
										vecRow = (ArrayList) vecData.get(i);
										if (vecRow != null && vecRow.size() > 0)
										{
											strSno = Helper.correctDouble((String) vecRow.get(0));
											String strBank="";
											if(Helper.correctNull((String) vecRow.get(11)).equalsIgnoreCase("Our"))
											{
												strBank=Helper.correctNull((String)vecRow.get(18));
											}
											else
											{
												strBank=Helper.correctNull((String)vecRow.get(1));
											}
											String strBnkType=Helper.correctNull((String) vecRow.get(3));
											if(strBnkType.equalsIgnoreCase("S"))
											{
												strBnkType="Sole";
											}
											else if(strBnkType.equalsIgnoreCase("C"))
											{
												strBnkType="Consortium";
											}
											else if(strBnkType.equalsIgnoreCase("M"))
											{
												strBnkType="Multiple";
											}
											String strCreditType=Helper.correctNull((String) vecRow.get(5));
											if(strCreditType.equalsIgnoreCase("E"))
											{
												strCreditType="Existing";
											}
											else if(strCreditType.equalsIgnoreCase("P"))
											{
												strCreditType="Proposed";
											}
									%>
									<tr class="datagrid">
										<td align="center">
											<input type="radio" name="sno" style="border-style:none"
												onClick="selectValues('<%=Helper.correctInt((String)vecRow.get(0))%>',
														'<%=Helper.correctNull((String)vecRow.get(1))%>',
														'<%=Helper.correctNull((String)vecRow.get(2))%>',
														'<%=Helper.correctNull((String)vecRow.get(3))%>',
														'<%=Helper.correctNull((String)vecRow.get(4))%>',
														'<%=Helper.correctNull((String)vecRow.get(5))%>',
														'<%=Helper.correctNull((String)vecRow.get(6))%>',
														'<%=Helper.correctNull((String)vecRow.get(7))%>',
														'<%=Helper.correctNull((String)vecRow.get(8))%>',
														'<%=Helper.correctNull((String)vecRow.get(9))%>',
														'<%=Helper.correctNull((String)vecRow.get(10))%>',
														'<%=Helper.correctNull((String)vecRow.get(11))%>',
														'<%=Helper.correctNull((String)vecRow.get(12))%>',
														'<%=Helper.correctNull((String)vecRow.get(13))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(14))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(15))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(16))))%>',
														'<%=Helper.correctNull((String)vecRow.get(17))%>',
														'<%=Helper.correctNull((String)vecRow.get(18))%>',
														'<%=Helper.correctNull((String)vecRow.get(19))%>','<%=Helper.correctNull((String)vecRow.get(20))%>')">
											<input type="hidden" name="hid" value="<%=strSno%>">
										</td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(12))%></td>
										<td align="left">&nbsp;<%=strBank%></td>
										<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecRow.get(14))))%>&nbsp;</td>
										<td align="left">&nbsp;<%=strBnkType%></td>
										<td align="left">&nbsp;<%=strCreditType%></td>
									</tr>
									<%	}
									}
									if(vecsize<=0)
									{
									%>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td align="center">--No Records Found--</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
									}
									%>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidflag" value=""> 
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="hidval"> 
<input type="hidden" name="hiddesc"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="otherGenTable" value=""> 
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="tot_netlmtfundexist" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtfundexist"))%>">
<INPUT TYPE="hidden" NAME="tot_netlmtfundprop" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtfundprop"))%>">
<INPUT TYPE="hidden" NAME="tot_netnonlmtfundexist" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtnonfundexist"))%>">
<INPUT TYPE="hidden" NAME="tot_netnonlmtfundprop" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtnonfundprop"))%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>">
<input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
<input type="hidden" name="idno" value="">
<input type="hidden" name="type" value="W">
<input type="hidden" name="hidFacSNo" value="">
 <iframe height="0" width="0" id="ifrFacilityDesc" frameborder="0" style="border:0" ></iframe>
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
</form>
</body>
</html>
