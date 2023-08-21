<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	//out.println(hshValues);
	String strfacility = Helper.correctNull((String) hshValues
			.get("strfacility"));
	String facilit = "";
	if (!strfacility.equalsIgnoreCase("")) {
		facilit = strfacility;
	} else {
		facilit = "0";
	}
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType"));
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	//ArrayList arrtlfac = new ArrayList();
	ArrayList arrtlrec = new ArrayList();
	String strAppno = Helper.correctNull((String) hshValues
			.get("strAppno"));
	String strstrfacamt = Helper.correctDouble((String) hshValues
			.get("strfacamt"));
	String strRepaymentPeriod= Helper.correctNull((String) hshValues.get("strRepaymentperiod"));
	String COM_BANKSCHEME = Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"));
	if (hshValues != null) {
		//arrtlfac =(ArrayList)hshValues.get("arrtlfac");
		arrtlrec = (ArrayList) hshValues.get("arrtlrec");
	}

	double dblTotalInstAmt = 0.000;
	double dblTotalInstPeriod = 0.000;
	String strCatName = "";
	if (strCategoryType.equals("CORPORATE")
			|| strCategoryType.equals("CORP")) {
		strCategoryType = "CORP";
		strCatName = "Corporate";

	} else if (strCategoryType.equals("OPS")) {
		strCatName = "Tertiary";
	} else if (strCategoryType.equals("SME")
			|| strCategoryType.equals("SSI")) {
		strCatName = "Corporate";
	}
%>
<html>
<head>
<title>Repayment Schedule for Non EMI</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path ="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var varFACILITY_WHETHEREMI="<%=Helper.correctNull((String) hshValues
							.get("FACILITY_WHETHEREMI"))%>";
var varFacInstall="";

var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varEditFlag="<%=Helper.correctNull((String) hshValues.get("strEditFlag"))%>";
function onloading()
{

	varFacInstall=document.forms[0].hidfacinstall.value
	if(varFacInstall!="")
	{
		document.forms[0].sel_frequency.value = varFacInstall.toUpperCase();
	}else
	{
		document.forms[0].sel_frequency.value ="S";
	}
	document.forms[0].txt_noofinst.disabled = true;
	document.forms[0].sel_frequency.disabled = true;
	document.forms[0].txt_instamt.disabled = true;
	document.forms[0].txt_totamt.readonly = true;
	document.forms[0].select_facility.disabled=false;
	document.forms[0].select_facility.value="<%=facilit%>";

	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(document.forms[0].select_facility.value=="0")
		{
			enableButtons(true,true,true,true,true,false);
		}
		else
		{
			enableButtons(false,true,true,true,true,false);
		}

		if(varPostSanc=="P")
		{
			var boolflag=false;
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "MRS")
				{
					boolflag=true;
				}
				
			}
			if(varEditFlag=="N" &&  document.forms[0].hidPostSancParams.value=="" && document.forms[0].select_facility.value!="0")
			{
				boolflag=true;
			}
			if(boolflag)
			{
				enableButtons(false,true,true,true,false,true);
			}
			else
			{
				enableButtons(true,true,true,true,true,true);
			}
		}
	}
	else
	{	
		disableFields(true);
		enableButtons(true,true,true,true,true,false);
	}
	}
	if(document.forms[0].select_facility.value=="0")
		   document.forms[0].cmdannexture.disabled=true;
		else
			document.forms[0].cmdannexture.disabled=false;
	/*if(varFACILITY_WHETHEREMI=="3" || varFACILITY_WHETHEREMI=="4")
	{
		document.all.idnoofins.innerText="*";
		document.all.idinsamt.innerText="*";
	}
	else
	{
		document.all.idnoofins.innerText="";
		document.all.idinsamt.innerText="";
	}*/
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
	document.forms[0].cmdannexture.disabled=bool7;
	//document.forms[0].cmdhelp.disabled=true;
}

function doNew()
{
	//disableFields(false);
	document.forms[0].txt_noofinst.disabled = false;
	document.forms[0].txt_instamt.disabled = false;
	document.forms[0].sel_frequency.disabled = true;
	document.forms[0].txt_totamt.readonly = true;
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
	
	//document.forms[0].select_facility.value="s";

	
	document.forms[0].txt_instamt.value="0.00";
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].sel_frequency.disabled = true;
	document.forms[0].txt_noofinst.disabled = false;
	document.forms[0].txt_instamt.disabled = false;
	document.forms[0].txt_totamt.readonly = true;
	document.forms[0].select_facility.disabled=false;
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function callcopmof()
{
	document.forms[0].method="post";
	document.forms[0].action=appUrl+"action/com_termloanassesment.jsp";
	document.forms[0].submit();
}

function callcomments()
{	
	var appno="<%=(String) request.getParameter("appno")%>";
	var pagetype = "repaymentschedule";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=getDataComments&hidBeanId=comassestsliab&pagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;				
	var prop = 'scrollbars=yes,menubar=no,width=650,height=355';	
	var xpos = (screen.width - 600) / 2;
	var ypos = (screen.height - 450) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);	
}
function doSave()
{
	document.forms[0].sel_frequency.disabled = false;
	if(document.forms[0].select_facility.value=="0")
	{
		alert("Select Facility");
		document.forms[0].select_facility.focus();
		return;
	}
	if(document.forms[0].sel_frequency.value=="S")
	{
		alert("Select Frequency");
		document.forms[0].sel_frequency.focus();
		return;
	}
	
	if(document.forms[0].txt_noofinst.value=="" || document.forms[0].txt_noofinst.value=="0" || document.forms[0].txt_noofinst.value=="0.00")
	{
		alert("Enter No. of Installments");
		document.forms[0].txt_noofinst.value="";
		document.forms[0].txt_noofinst.focus();
		return false;
	}
	if(document.forms[0].txt_instamt.value=="" || document.forms[0].txt_instamt.value=="0" || document.forms[0].txt_instamt.value=="0.00")
	{
		alert("Enter Installment Amount");
		document.forms[0].txt_instamt.value="";
		document.forms[0].txt_instamt.focus();
		return false;
	}
	var Sancamt=document.forms[0].hidFacsancamt.value;
	var Total= parseFloat(document.forms[0].hidTotalsancamt.value)+parseFloat(document.forms[0].txt_totamt.value);

	var varvalue=parseFloat(document.forms[0].txt_noofinst.value)+eval(document.forms[0].hidNoofInstallments.value);
	if(document.forms[0].sel_frequency.value=="Q")
	{
		varvalue=eval(varvalue)*3;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%3!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%3)+3;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}
	else if(document.forms[0].sel_frequency.value=="H")
	{
		varvalue=eval(varvalue)*6;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%6!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%6)+6;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}
	else if(document.forms[0].sel_frequency.value=="Y")
	{
		varvalue=eval(varvalue)*12;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%12!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%12)+12;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}

	if(parseFloat(varvalue)>parseFloat(document.forms[0].hidStaffPrincipalRepay.value))
	{
		alert("Total no of Installments cannot be greater than "+document.forms[0].hidStaffPrincipalRepay.value);
		return false;
	}
	if(parseFloat(Total)>parseFloat(Sancamt))
	{
		alert("Total value cannot be greater than Sanction amount");
		return false;
	}

	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/com_fac_repaymentnonemi.jsp";
	document.forms[0].hidBeanMethod.value="updateFacNonEMIRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
		document.forms[0].hidBeanId.value="comrepayschedule";
		document.forms[0].action=appURL+"action/com_fac_repaymentnonemi.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/com_fac_repaymentnonemi.jsp";
	document.forms[0].hidBeanMethod.value="updateFacNonEMIRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";	
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}


function selectValues(val1,val2,val3,val4,val5,val6,val7)
{	
	document.forms[0].hidsno.value =val1;
	document.forms[0].select_facility.value = val2;
	document.forms[0].sel_frequency.value = val3;
	document.forms[0].txt_noofinst.value = val4;
	document.forms[0].txt_instamt.value = val5;
	document.forms[0].txt_totamt.value = val6;
	document.forms[0].hidTotalsancamt.value=parseFloat(document.forms[0].hidTotalsancamt.value)-parseFloat(val6);
	document.forms[0].hidNoofInstallments.value=parseFloat(document.forms[0].hidNoofInstallments1.value)-parseFloat(val4);
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	if(appstatus=="Open/Pending")
	{
		disableCommandButtons("radioselect");
	}
	else if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	disableCommandButtons("disableall");
	 	disableFields(true);	 	
	}

	if(varPostSanc=="P")
	{
		var boolflag=false;
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "MRS")
			{
				boolflag=true;
			}
			
		}
		if(varEditFlag=="N" && document.forms[0].hidPostSancParams.value=="" && document.forms[0].select_facility.value!="0")
		{
			boolflag=true;
		}
		if(boolflag)
		{
			enableButtons(true,false,true,true,false,true);
		}
		else
		{
			enableButtons(true,true,true,true,true,true);
		}
	}
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		enableButtons(false,true,true,true,true,true,true);
	}
	if(val=="edit")
	{	 
		enableButtons(true,true,false,false,true,true,true);
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		enableButtons(true,false,true,false,false,true,true);
	}	  
	if(val=="disableall")
	{
		enableButtons(true,true,true,true,true,true,true);
		disableFields(true);

	}
}  
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		/*if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	*/  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		/*if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}*/
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}

function calltotal()
{
	var tot=0.00;
	tot=document.forms[0].txt_noofinst.value*document.forms[0].txt_instamt.value;
	document.forms[0].txt_totamt.value=tot;
}

function callfacility()
{
	var facility=document.forms[0].select_facility.value;
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
	document.forms[0].action = appURL+"action/com_fac_repaymentnonemi.jsp?facility="+facility;
	document.forms[0].submit();
}

function callReleasePattern(beanid,methodname,pagename)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callTermAssesement(beanid,methodname,pagename,type)
{			
	if(type=="COP")
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
	document.forms[0].submit();
	}
	else
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].flowtype.value=type;
	document.forms[0].submit();
	}
}
function doAnnexture()
{
	var varQryString = appURL+"action/Amortization_NonEmi.jsp?hidBeanGetMethod=getFacNonEMIRepayment&hidBeanId=comrepayschedule&hidrepaymenttype=amort&hiPgDist=C&pageFrom=Nonemi&appno="+document.forms[0].appno.value+"&select_facility="+document.forms[0].select_facility.value;
	var title = "Amortization";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="28" />
			<jsp:param name="subpageid" value="109" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<jsp:include
	page="../com/proposallinks.jsp" flush="true">
	<jsp:param name="pageid" value="28" />
	<jsp:param name="cattype" value="<%=strCategoryType%>" />
	<jsp:param name="ssitype" value="<%=strSSIType%>" />

</jsp:include>


<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<%
			if (strSessionModuleType.equalsIgnoreCase("AGR")) {
		%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal
		-&gt;Repayment Schedule -&gt; Repayment Schedule for Non-EMI</td>
		<%
			} else {
		%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME-&gt;Proposal
		-&gt;Repayment Schedule -&gt; Repayment Schedule for Non-EMI</td>
		<%
			}
		%>
	</tr>
</table>


<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="50%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="javascript:gotoTab(appURL,'comrepayschedule','getTermFinanceFac','com_fac_repayment.jsp')"><b>Repayment
		Schedule for EMI</b></a></td>
		<td class="sub_tab_active" align="center"><b>Repayment
		Schedule for Non-EMI</b></td>
		<%if(StrDigiLoanType.equals("") && COM_BANKSCHEME.equalsIgnoreCase("052")){%>	
		<td class="sub_tab_inactive" align="center"><a href="javascript:gotoTab(appUrl,'appraisal','getCreditSalesData','com_creditsales.jsp')"><b>Reason for Manual Processing</b></a></td>
		<%} %>	
		<td class="sub_tab_inactive" align="center"><a
			href="javascript:gotoTab(appURL,'comproposal','getDataComments','com_repaycomment.jsp')"><b>Terms of Repayment</b></a></td>
	</tr>
</table>
<%} %>
<TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="5"
	ALIGN="center" CLASS="outertable border1">
	<TR>
		<TD VALIGN="top">
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5"
			CLASS="outertable">
			<tr>
				<td class="mantatory"><b>Note : Enter all values in Rupees</b></td>
			</tr>
			<TR>
				<TD>
				<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1"
					CLASS="outertable border1">

					<TR>

						<TD>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							CLASS="outertable">
							<tr>
								<td width="9%" nowrap>Facility<span class="mantatory">*</span></td>
								<TD WIDTH="9%"><SELECT NAME="select_facility"
									onChange="callfacility()" TABINDEX="1" STYLE="width: 200">
									<option value="0" selected>---Select---</option>
									<lapschoice:termfinancefac pagename="NONEMI" />
								</SELECT></TD>
								<td width="13%" nowrap>Frequency <span class="mantatory">*</span></td>
								<td width="10%"><select name="sel_frequency">
									<option value="S"><--Select--></option>
									<option value="M">Monthly</option>
									<option value="Q">Quarterly</option>
									<option value="H">Half Yearly</option>
									<option value="Y">Yearly</option>
								</select></td>
							</tr>
							<tr>
								<td>No of Installments(Excluding Holiday Period)&nbsp;<span
									class="mantatory">*</span></td>
								<td><input type="text" name="txt_noofinst" size="15" maxlength="3"
									style="text-align: right" onKeyPress="allowNumber(this)"
									onBlur="calltotal();"></td>
								<td>Installment amount &nbsp;<span class="mantatory">*</span></td>
								<td><input type="text" name="txt_instamt" size="15"
									style="text-align: right" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this);calltotal();"></td>
							</tr>
							<tr>
								<td>Total</td>
								<td><input type="text" name="txt_totamt" size="15"
									style="text-align: right" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)" readonly></td>
							<tr>
							<tr><td colspan="3" class="mantatory">Sanction Amount : <%=nf.format(Double.parseDouble(strstrfacamt)) %></td></tr>
							<tr>
							<td colspan="3" class="mantatory">Facility Repayment period Excluding Holiday Period is  <%=strRepaymentPeriod %> months</td>
							<td>&nbsp;</td>
							</tr>
						</table>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
			<tr>
				<td>
				<table border="0" cellspacing="0" cellpadding="0" align="center"
					CLASS="outertable">
				    <tr> 
					     <!--  <td align="center">
					          <input type="button" name="Annexture" value="Annexture" class="buttonStyle"  onClick="doAnnexture();">
					      </td> -->
				      </tr>
					<tr>
						<td><lapschoice:combuttonnew
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Annexture'
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						</td>
					</tr>
				</table>

				</td>
			</tr>
			<TR>
				<TD>
				<TABLE WIDTH="80%" BORDER="0" align="center" CELLSPACING="0"
					CELLPADDING="1" CLASS="outertable border1">
					<TR>
						<TD>

						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2"
							CLASS="outertable">
							<TR CLASS="dataheader">
								<TD WIDTH="5%">&nbsp;</TD>
								<TD WIDTH="30%" ALIGN="center">Facility</TD>
								<TD WIDTH="20%" ALIGN="center">Frequency</TD>
								<TD WIDTH="15%" ALIGN="center">No of Installment</TD>
								<TD WIDTH="15%" ALIGN="center">Amount of Installment</TD>
								<TD ALIGN="center" colspan="2" WIDTH="15%">Total</TD>
							</TR>
							<%
								if (arrtlrec != null) {
									for (int i = 0; i < arrtlrec.size(); i++) {
										arrCol = new ArrayList();
										arrCol = (ArrayList) arrtlrec.get(i);
										//out.println("arrCol"+arrCol);
							%>
							<TR CLASS="datagrid">
								<TD ALIGN="center"><INPUT TYPE="radio" STYLE="border: none"
									NAME="radiobutton" VALUE="radiobutton"
									ONCLICK="javascript:selectValues(
												'<%=Helper.correctNull((String) arrCol.get(0))%>',
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
												'<%=Helper.correctNull((String) arrCol.get(3))%>',
												'<%=Helper.correctNull((String) arrCol.get(4))%>',
												'<%=Helper.correctNull((String) arrCol.get(5))%>',
												'<%=Helper.correctNull((String) arrCol.get(6))%>')">
								</TD>
								<TD ALIGN="left"><%=Helper.correctNull((String) arrCol.get(6))%></TD>
								<%
									String frq = Helper.correctNull((String) arrCol.get(2));
											if (frq.equalsIgnoreCase("M"))
												frq = "Monthly";
											else if (frq.equalsIgnoreCase("Y"))
												frq = "Yearly";
											else if (frq.equalsIgnoreCase("Q"))
												frq = "Quarterly";
											else if (frq.equalsIgnoreCase("H"))
												frq = "Half Yearly";
											else
												frq = "";
								%>
								<TD align="center"><%=frq%></TD>
								<TD align="center"><%=Helper.correctNull((String) arrCol.get(3))%></TD>
								<TD align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></TD>
								<TD align="right" colspan="2"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%></TD>
							</TR>
							<%
								dblTotalInstAmt += Double.parseDouble(Helper.correctDouble((String) arrCol.get(5)));
								dblTotalInstPeriod += Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
									}
								}
							%>
							<TR>
								<TD COLSPAN="5" ALIGN="right">
								<%
									double strSancAmt = Double.parseDouble(Helper
											.correctDouble(strstrfacamt));
									if (dblTotalInstAmt != 0.00) {
										if (strSancAmt == dblTotalInstAmt) {
								%> <span style="color: green">Tally with Sanction Amount</span>
								<%
									} else {
								%> <span style="color: red">Does not Tally with Sanction
								Amount</span> <% } } else { %> &nbsp; <% } %>
								</TD>
								<TD ALIGN="right" width="15%"><b>Total</b></TD>
								<TD ALIGN="right" width="15%"><INPUT TYPE="hidden" name="hidTotalsancamt" value="<%=dblTotalInstAmt%>">
								<b><%=nf.format(dblTotalInstAmt)%></b></TD>

							</TR>
						</TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
</TABLE>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hid_option"
	value="<%=Helper.correctNull((String) hshValues.get("strOption"))%>">
<INPUT TYPE="hidden" name="strAssessment"
	value="<%=request.getParameter("strAssessment")%>"> <INPUT
	TYPE="hidden" name="hidFacsancamt" value="<%=strstrfacamt%>"> <input
	type="hidden" name="pagetype" value="repaycomment"> 
	<input type="hidden" name="hidFacTotalamt" value="<%=Helper.correctDouble((String) hshValues.get("dblTotalfacRepayamt"))%>">
	<input type="hidden" name="hidFacTotalperiod" value="<%=Helper.correctInt((String) hshValues.get("dblTotalfacPeriod"))%>">
	<input
	type="hidden" name="hidsno" value="">
	<input type="hidden" name="hidfacinstall" value="<%=Helper.correctNull((String) hshValues.get("strFacinstallment"))%>">
	<input type="hidden" name="hidNoofInstallments" value="<%=dblTotalInstPeriod%>">
	<input type="hidden" name="hidNoofInstallments1" value="<%=dblTotalInstPeriod%>">
	<INPUT TYPE="hidden" name="hidStaffPrincipalRepay" value = "<%=Helper.correctNull((String) hshValues.get("strMaxRepaymentperiodPrin"))%>">
	<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
	</form>
</body>
</html>