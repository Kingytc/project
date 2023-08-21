<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
String strProfilestatus = Helper.correctNull((String) hshValues
		.get("strProfilestatus"));
String tempProfile = "";
if (strProfilestatus.equalsIgnoreCase("Y")) {
	tempProfile = "Completed";
} else {
	tempProfile = "Partial";
}
String strUserId=Helper.correctNull((String)session.getAttribute("strUserId"));
String strCustCat = Helper.correctNull((String) hshValues.get("PERAPP_CUST_CATEGORY"));
String moduletype=Helper.correctNull((String)session.getAttribute("moduletype"));

%>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 400;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/psb59perincexpenses.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var varTypeProfession="<%=Helper.correctNull((String)hshValues.get("perinc_selfincometype"))%>";
var varempstatus="<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
var varselroute="<%=Helper.correctNull((String)hshValues.get("sel_routed"))%>";
var varsurityinclude="<%=Helper.correctNull((String)hshValues.get("perinc_surityinclude"))%>";
var varsel_seperateInc="<%=Helper.correctNull((String)hshValues.get("PERINC_SEPERATINC"))%>";

var varincomstability="<%=Helper.correctNull((String)hshValues.get("perapp_incomstability"))%>";
var appstatus = "<%=Helper.correctNull((String)request.getParameter("hidappstatus"))%>";
//var varincomeproof="<%=Helper.correctNull((String)hshValues.get("perapp_incomstability"))%>";
var varCustCategory="<%=Helper.correctNull((String)hshValues.get("PERAPP_CUST_CATEGORY"))%>";
var varModuletype="<%=moduletype%>";

function placeproofvalue()
{
var strincome_proof="<%=Helper.correctNull((String)hshValues.get("INCOME_PROOF"))%>";
var strturn_over="<%=Helper.correctNull((String)hshValues.get("TURN_OVER"))%>";
var sel_pigmy="<%=Helper.correctNull((String)hshValues.get("sel_pigmy"))%>";

//alert(strincome_proof);
	
	if(strincome_proof!="")
	{
	document.forms[0].selincproof.value=strincome_proof;
	}
	else
	{
	document.forms[0].selincproof.value="S";
	}
	
	if(strturn_over!="")
	{
	document.forms[0].selturnovervalues.value=strturn_over;
	}
	else
	{
	document.forms[0].selturnovervalues.value="S";
	}
	if(sel_pigmy!="")
	{
	document.forms[0].sel_pigmy.value=sel_pigmy;
	}
	else
	{
	document.forms[0].sel_pigmy.value="S";
	}
disablesalbusiness();
}

function disablesalbusiness()
{
	//Salaried   ,MNC=11,LISTED PVT SECTOR COMPANIES=12,GOVT/PUBLIC SECTOR=13
	if(varempstatus=="1"||varempstatus=="2"||varempstatus=="3"||varempstatus=="5"||varempstatus=="11"||varempstatus=="12"||varempstatus=="13"||varempstatus=="14")
		{
			document.forms[0].year3.readOnly=true;
			document.forms[0].year3.value="";
			
			document.forms[0].year2.readOnly=true;
			document.forms[0].year2.value="";
			
			document.forms[0].year1.readOnly=true;
			document.forms[0].year1.value="";
			
			document.forms[0].latest.readOnly=true;
			document.forms[0].latest.value="";
			
			document.forms[0].total.value="";
			document.forms[0].average.value="";
			
		}
		//business   ,others (option =15)
//		if(varempstatus=="4"||varempstatus=="6"||varempstatus=="7"||varempstatus=="8"||varempstatus=="9" ||varempstatus=="15")
	    if(varempstatus=="4"||varempstatus=="6"||varempstatus=="8"||varempstatus=="9" ||varempstatus=="15")
		{
				document.forms[0].txtperinc_monsalary.readOnly=true;
				document.forms[0].txtperinc_monsalary.value="";
				document.forms[0].txtperinc_autoloanexp.readOnly=false;
	
				document.forms[0].txtperinc_rentexp.readOnly=false;
				
				document.forms[0].txtperinc_otherexp.readOnly=false;
				
				
				document.forms[0].txtperinc_takehome.value="";
				document.forms[0].txtperinc_deduc.value="";
				document.forms[0].txtperinc_otherincome.value="";
				
				//document.forms[0].txtperinc_otherdesc.value="";
				//document.forms[0].txtperinc_otherdesc.readOnly=true;
				document.forms[0].txtperinc_secdesc.value="";
				document.forms[0].txtperinc_secdesc.readOnly=true;
				
				document.forms[0].txtperinc_rent.value="";
				document.forms[0].txtperinc_rent.readOnly=true;
				document.forms[0].txtperinc_agriculture.value="";
				document.forms[0].txtperinc_agriculture.readOnly=true;
				document.forms[0].txtperinc_others.value="";
				document.forms[0].txtperinc_others.readOnly=true;
				
				
				document.forms[0].txtperinc_totincome.value="";
				document.forms[0].txtperinc_annualgross.value="";
				document.forms[0].txtperinc_annualnet.value="";
				//document.forms[0].txtperinc_total.value="";
		}
}


function calnotzero()
{
	var year3=	document.forms[0].year3.value;
	var year2=	document.forms[0].year2.value;
	var year1=	document.forms[0].year1.value;
	var zero="0";
	
	/*if(year3=="")
	{
		alert("Enter Value");
		document.forms[0].year3.focus();
	}*/
	if(eval(year3) <= eval(zero) || year3=="")
		{
			//alert("Enter Value > Zero in Pre Year3");
			document.forms[0].year3.focus();
			return false;
		}	

	
	if(eval(year2) <= eval(zero) ||year2=="")
	{
		//alert("Enter Value > Zero in Pre Year2");
		document.forms[0].year2.focus();
		return false;
	}	
	
	if(eval(year1) <= eval(zero) || year1=="")
	{
		//alert("Enter Value > Zero in Pre Year1");
		document.forms[0].year1.focus();
		return false;
	}	

}	
function calcaverage()
{	
var year3=	document.forms[0].year3.value;
var year2=	document.forms[0].year2.value;
var year1=	document.forms[0].year1.value;
if(year3=="0" || year3=="0.0" || year3=="0.00")
{
	year3="";
}
else
{
	document.forms[0].year3.value=Math.round(year3);
}
if(year2=="0" || year2=="0.0" || year2=="0.00")
{
	year2="";
}
else
{
	document.forms[0].year2.value=Math.round(year2);
}
if(year1=="0" || year1=="0.0" || year1=="0.00")
{
	year1="";
}
else
{
	document.forms[0].year1.value=Math.round(year1);
}

var total="0";
var average="0";
	if(year3!="" && year2==""&& year1=="")
	{
		total=eval(total)+eval(year3);
		average=total;
	}
	if(year3=="" && year2!=""&& year1=="")
	{
		total=eval(total)+eval(year2);
		average=total;
	}
	if(year3=="" && year2==""&& year1!="")
	{
		total=eval(total)+eval(year1);
		average=total;
	}
	if(year3!="" && year2!=""&& year1=="")
	{
		total=eval(year2)+eval(year3);
		average=eval(total)/2;
	}
	if(year3!="" && year2==""&& year1!="")
	{
		total=eval(year1)+eval(year3);
		average=eval(total)/2;
	}
	if(year3=="" && year2!=""&& year1!="")
	{
		total=eval(year1)+eval(year2);
		average=eval(total)/2;
	}
	if(year3!="" && year2!=""&& year1!="")
	{
		total=eval(year1)+eval(year2)+eval(year3);
		average=eval(total)/3;
	}
	document.forms[0].total.value=Math.round(total);
	document.forms[0].average.value=Math.round(average);
}
function calcaverage1()
{
	var latest=document.forms[0].latest.value;
	document.forms[0].latest.value=Math.round(latest);
}

function hidFields(){
	if(varempstatus == "7"){
		document.all.id_inc1.style.display="none";
		document.all.id_inc2.style.display="none";
		document.all.id_agrInc.style.display="table-row";
	}else{
		document.all.id_agrInc.style.display="none";
	}
}

</SCRIPT>
<%
%>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function checkbusiness()
{
//alert(document.forms[0].choperinc_selfincometype);
	if(document.forms[0].choperinc_selfincometype.disabled==false)
	{
			alert("Gross Annual Income for Non-Salaried to be entered below in Non Salaried Section. Here You may Enter Gross Income from Relative/Spouse, standing as Co-Borrower/Guarantor, Surity/Co-Borrower's Monthly Deductions & Applicant Salary routed through our Bank & Select Self Employment Details" );
			document.forms[0].txtperinc_monsalary.disabled=true;
			document.forms[0].txtperinc_monsalary.value="";
			document.forms[0].txtperinc_autoloanexp.disabled=false;
		
			document.forms[0].txtperinc_rentexp.disabled=false;

			document.forms[0].txtperinc_otherexp.disabled=false;
	
			
			document.forms[0].txtperinc_takehome.value="";
			document.forms[0].txtperinc_deduc.value="";
			document.forms[0].txtperinc_otherincome.value="";
			
			document.forms[0].txtperinc_rent.value="";
			document.forms[0].txtperinc_rent.disabled=true;
			document.forms[0].txtperinc_agriculture.value="";
			document.forms[0].txtperinc_agriculture.disabled=true;
			document.forms[0].txtperinc_others.value="";
			document.forms[0].txtperinc_others.disabled=true;
			
			calDeduction();
			
			
			
			
	}	
}

function selspouseinc()
{
	if(document.forms[0].choperinc_selfincometype.value!="S")
	{
		alert("Want to Include Relative/Spouse Income");
	}
}
function callhelp()
{
		   var varQryString = appURL+"/jsp/perhlp/hlp_perincexpenses.jsp"
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}
function showDedc(val)
{
	if(val=="y")
	{
	document.all.dover.style.visibility="visible";
	}
	else if(val =="n")
	{
	document.all.dover.style.visibility="hidden";
	}
	
}
function callEXPERIANPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getExperianPageDetails";
	document.forms[0].action=appURL+"action/ExperianReport.jsp?applnt=P";
	document.forms[0].submit();	
		
}
function callCRIFPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getCRIFHighMark";
	document.forms[0].action=appURL+"action/criffReports.jsp";
	document.forms[0].submit();
}
function callEquifaxPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getEquifaxPageDetails";
	document.forms[0].action=appURL+"action/equifaxReports.jsp";
	document.forms[0].submit();
}
function showTotDedc(val)
{
	if(val=="y")
	{
	document.all.dover2.style.visibility="visible";
	}
	else if(val =="n")
	{
	document.all.dover2.style.visibility="hidden";
	}
}

function callFirmDetails()
{

document.forms[0].method="post";
document.forms[0].hidBeanId.value="setfirmdetails";
document.forms[0].hidBeanGetMethod.value="getFirmData";
document.forms[0].action=appURL+"controllerservlet";
document.forms[0].action=appURL+"action/setfirmdetails.jsp?appno="+document.forms[0].hidDemoId.value;
document.forms[0].submit();
}
function hidesurities()
{
	if(document.forms[0].sel_surityinclude.value=="1")
	{
		document.all.sur1.style.display="table-row";
		document.all.sur2.style.display="table-row";
		document.all.sur3.style.display="table-row";
		document.all.sur4.style.display="table-row";
		document.all.sur5.style.display="table-row";
		document.all.sur6.style.display="table-row";
		document.all.sur7.style.display="table-row";
		document.all.sur8.style.display="table-row";
		document.all.sur9.style.display="table-row";
		document.all.sur10.style.display="table-row";
		document.all.sur11.style.display="table-row";
		document.all.sur12.style.display="table-row";

		//document.all.sur13.style.visibility="visible";
		//document.all.sur14.style.visibility="visible";
		//document.all.sur15.style.visibility="visible";
		//document.all.sur16.style.visibility="visible";
	}
	else
	{
		document.all.sur1.style.display="none";
		document.all.sur2.style.display="none";
		document.all.sur3.style.display="none";
		document.all.sur4.style.display="none";
		document.all.sur5.style.display="none";
		document.all.sur6.style.display="none";
		document.all.sur7.style.display="none";
		document.all.sur8.style.display="none";
		document.all.sur9.style.display="none";
		document.all.sur10.style.display="none";
		document.all.sur11.style.display="none";
		document.all.sur12.style.display="none";

		document.all.sur13.style.display="none";
		document.all.sur14.style.display="none";
		document.all.sur15.style.display="none";
		document.all.sur16.style.display="none";

		 
		document.forms[0].txtperinc_relative.value="0.00";
		document.forms[0].txtperinc_relative2.value="0.00";
		document.forms[0].txtperinc_relative3.value="0.00";
		//document.forms[0].txtperinc_relative4.value="0.00";

		document.forms[0].txtperapp_spincome.value="0.00";
		document.forms[0].txtperapp_spincome2.value="0.00";
		document.forms[0].txtperapp_spincome3.value="0.00";
		//document.forms[0].txtperapp_spincome4.value="0.00";

	}
}
function checkpreyrdisable()
{
	if(document.forms[0].selturnovervalues.value=="4")
	{	
			document.forms[0].year3.readOnly=true;
			document.forms[0].year3.value="";
			
			document.forms[0].year2.readOnly=true;
			document.forms[0].year2.value="";
			
			document.forms[0].year1.readOnly=true;
			document.forms[0].year1.value="";
			
			document.forms[0].latest.readOnly=true;
			document.forms[0].latest.value="";
			
			document.forms[0].total.value="";
			document.forms[0].average.value="";
	}else{
			document.forms[0].year3.readOnly=false;
			document.forms[0].year2.readOnly=false;
			document.forms[0].year1.readOnly=false;
			document.forms[0].latest.readOnly=false;
	
	
	}
}
function sumOfAgriIncome(){
	if(document.forms[0].txt_incAgri.value==""){
		document.forms[0].txt_incAgri.value = "0.00";
	}
	if(document.forms[0].txt_incAllied_Act.value==""){
		document.forms[0].txt_incAllied_Act.value = "0.00";
	}
	if(document.forms[0].txt_incOther.value==""){
		document.forms[0].txt_incOther.value = "0.00";
	}
	var varsum=eval(eval(document.forms[0].txt_incAgri.value)+eval(document.forms[0].txt_incAllied_Act.value)+eval(document.forms[0].txt_incOther.value));
	document.forms[0].txt_incTotal.value=varsum;
}
</script>
</head>

<body text="#000000" vlink="#330000" alink="#330000" leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad();calDeduction();placeproofvalue();"
	class="bgcolor">
<form name="appform" method="post" action="">
<div id="dover"
	style="position:absolute; left:286px; top:158px; width:89px; height:13px; z-index:1; visibility: hidden">
<table width="100" border="1" cellspacing="0" cellpadding="0"
	bgcolor="#FFFFCC">
	<tr>
		<td align="center"><font size="1" face="Arial, Helvetica, sans-serif">PF
		+ IT + Prof. Tax + Deductions for LIC / ULIP etc.</font></td>
	</tr>
</table>
</div>
<div id="dover2"
	style="position:absolute; left:286px; top:182px; width:89px; height:13px; z-index:1; visibility: hidden">
<table width="100" border="1" cellspacing="0" cellpadding="0"
	bgcolor="#FFFFCC">
	<tr>
		<td align="center"><font size="1" face="Arial, Helvetica, sans-serif">PF
		+ IT + Prof. Tax + Deductions for LIC / ULIP + Total Loan Repayment +
		Rent Paid </font></td>
	</tr>
</table>
</div>
<jsp:include page="../share/help.jsp" flush="true">
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home -&gt;


		Retail </i></b></font><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile Search </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font>
		</i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile </i></b></font><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Income & Expenses </i></b></font></td>
	</tr>
</table>

<div align="center"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td colspan="2">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr align="center">
				<td width="20%" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callDemographics()"
					class="blackfont">NP_Demographics</a></font></b></td>
				<td width="20%" class="tabactive"><b><font size="1"
					face="ms sans serif" color="#FFFFFF">NP_Income &amp; Deductions</font></b></td>
					<% if(!strCustCat.equalsIgnoreCase("C")){%>
				<td width="20%" id="employertdbtn1" class="tabinactive"><b><font
					size="1" face="ms sans serif"><a href="JavaScript:callEmployer()"
					class="blackfont">NP_Employment Details </a></font></b></td>
					<%} %>
					<!-- 
					<td width="10%" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCBIL()"
					class="blackfont">Customer CIC Score</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEXPERIANPage()"
					class="blackfont">Experian</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCRIFPage()"
					class="blackfont">CRIFF Highmark</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEquifaxPage()"
					class="blackfont">Equifax</a></font></b></td>
					-->
					<td class="tabactive"> 
					NP_Profile Status &nbsp; : &nbsp;<%=tempProfile%>
					</td>
				<!--  <td width="25%" id="firmdetails" align="center" class="tabinactive"><b><font
					size="2" face="ms sans serif"><a
					href="JavaScript:callFirmDetails()" class="blackfont"><font
					size="1"> Firm/Company Details </font></a></font></b></td>-->
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top"><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							align="center">
							<tr>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="100%">
									<tr>
										<td height="125" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="4">
											<tr bordercolor="#CCCCFF">
												<td height="10" colspan="3">
												<p><font size="1" face="MS Sans Serif"><b>Primary Monthly
												Income Details</b></font></p>
												</td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td width="39%"><font size="1" face="MS Sans Serif">Gross
												Income from Salary</font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_monsalary" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_monsalary"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_monsalary)"
													onBlur="roundtxt(document.forms[0].txtperinc_monsalary);calDeduction();checkbusiness()"></font></td>
											</tr>
											

											<tr bordercolor="#CCCCFF">
												<td width="39%"><span onMouseover="showTotDedc('y')"
													onMouseout="showTotDedc('n')"><font size="1"
													face="MS Sans Serif">Total Deduction (I+II+III below)</font></span></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_takehome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_takehome)"
													onBlur="calDeduction();calcdeduction();roundtxt(document.forms[0].txtperinc_takehome);calDeduction();calcdeduction()"
													name="txtperinc_takehome" readOnly
													onMouseover="showTotDedc('y')"
													onMouseout="showTotDedc('n')"></font></td>
											</tr>


											<tr bordercolor="#CCCCFF">
												<td width="39%"><font size="1" face="MS Sans Serif">Net
												Income </font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"> <%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_takehome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_takehome)"
													name="txtperinc_deduc" readOnly> </font></td>
											</tr>

											<tr bordercolor="#CCCCFF">
												<td width="39%"><font size="1" face="MS Sans Serif">Other
												Income </font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"> <%=ApplicationParams.getCurrency()%>
												</font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													readonly type="text" name="txtperinc_otherincome" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherincome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_otherincome)"
													onBlur="roundtxt(document.forms[0].txtperinc_otherincome)">
												</font></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td width="39%"><font size="1" face="MS Sans Serif">Total
												Income </font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_totincome" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherincome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_otherincome)"
													onBlur="roundtxt(document.forms[0].txtperinc_totincome)"> </font></td>
											</tr>
										</table>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="4">

											<tr bordercolor="#CCCCFF">
												<td width="39%"><font size="1" face="MS Sans Serif">Gross
												Annual Income from salary</font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_annualgross" size="12"
													maxlength="12" style="text-align:right" onKeyPress="allowNumber(document.forms[0].txtperinc_annualgross)"
													onBlur="roundtxt(document.forms[0].txtperinc_annualgross)"
													></font></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td width="39%"><span onMouseover="showDedc('y')"
													onMouseout="showDedc('n')"><font size="1"
													face="MS Sans Serif">Net Annual Income</font></span></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" size="12" maxlength="12"
													style="text-align:right" name="txtperinc_annualnet"
													readOnly onKeyPress="allowNumber(document.forms[0].txtperinc_annualnet)"
													onBlur="roundtxt(document.forms[0].txtperinc_annualnet)"> </font></td>
											</tr>
										</table>

										</td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="100%">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td colspan="3"><font size="1" face="MS Sans Serif"><b>Other
												sources of Income - Monthly</b> </font></td>
											</tr>
											<tr>
												<td width="25%"><font face="MS Sans Serif" size="1">a)&nbsp;Investments</font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="50%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_rent" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_rent"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_rent)"
													onBlur="calcdeduction();roundtxt(document.forms[0].txtperinc_rent);checkbusiness()">
												</font></td>
											</tr>
											<tr>
												<td width="25%"><font face="MS Sans Serif" size="1">b)&nbsp;Agriculture</font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="50%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_agriculture" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_agriculture"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_agriculture)"
													onBlur="calcdeduction();roundtxt(document.forms[0].txtperinc_agriculture);checkbusiness()">
												</font></td>
											</tr>
											<tr>
												<td width="25%"><font face="MS Sans Serif" size="1">c)&nbsp;Others</font></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="50%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_others" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_others"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_others)"
													onBlur="calcdeduction();roundtxt(document.forms[0].txtperinc_others);checkbusiness()">
												</font></td>
											</tr>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Description</font></td>
												<td width="5%" align="right">&nbsp;</td>
												<td width="50%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_secdesc" size="30"
													maxlength="30"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_secdesc"))%>"
													onKeyPress="allowAlphabetsAndSpace()"> </font></td>
											</tr>
											<tr id="id_inc1">
												<td width="25%" nowrap colspan="2"><font size="1" face="MS Sans Serif">Whether Spouse is having separate 
												income from regular employment and is to be included for 70 % cutback(Only for product codes 962/963/979)
												</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td width="5%" align="left"><select
															name="sel_seperateInc">
															<option value="0" selected>Select</option>
															<option value="1">Yes</option>
															<option value="2">No</option>
														</select></td>
												</tr>
												
												<tr id="id_inc2">
												<td width="25%" nowrap colspan="2"><font size="1" face="MS Sans Serif">Whether Income from Spouse/Surity/
												Co-Borrower to be Included for calculating Loan Eligibility</font>
												<b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td width="5%" align="left"><select
															name="sel_surityinclude" onChange="hidesurities();">
															<option value="0" selected>Select</option>
															<option value="1">Yes</option>
															<option value="2">No</option>
														</select></td>
												</tr>

										</table><br>
										<table width="100%" border="1" cellspacing="0" cellpadding="4"
											bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
											height="100%">
											<tr>
												<td valign="top"> 
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3">

													<tr>
														<td width="30%" colspan="3" nowrap id="sur1"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 1&nbsp;&nbsp;</font></td>
														<td width="10%" align="left" id="sur2"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("txtperinc_relative"))%>"
															onKeyPress="txtperinc_relative" onBlur="roundtxt(txtperinc_relative)"></font></td>
														<!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>--></tr>
														<tr>
														<td width="30%" colspan="3" nowrap id="sur3"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 2&nbsp;&nbsp;</font></td>
														<td width="10%" align="left" id="sur4"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative2" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome2"))%>"
															onKeyPress="txtperinc_relative2" onBlur="roundtxt(txtperinc_relative2)"></font></td>
														<!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>--></tr>
														<tr>
														<td width="30%" colspan="3" nowrap id="sur5"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 3&nbsp;&nbsp;</font></td>
														<td width="10%" align="left" id="sur6"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative3" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome3"))%>"
															onKeyPress="txtperinc_relative3" onBlur="roundtxt(txtperinc_relative3)"></font></td>
														<!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>--></tr>
														<tr style="visibility:  hidden;position: absolute;">
														<td width="30%" colspan="3" nowrap id="sur15"><font face="MS Sans Serif" size="1">
															Monthly Gross Income from Spouse(Having separate income from regular employment), 
															standing as Co-Borrower(FOR 70% Cutback-applicable for Product code 962/963/979)&nbsp;&nbsp; </font></td>
														<td width="10%" align="right" id="sur16"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative4" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome4"))%>"
															onKeyPress="txtperinc_relative4" onBlur="roundtxt(txtperinc_relative4)"></font></td>
														<!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>--></tr>

															
												
													
							<tr>
                                <td width="30%" colspan="3" id="sur7">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 1 &nbsp;&nbsp;</font>
                                         </td>
                                         
                                         <td width="10%" id="sur8"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome"))%>">
                                      </td>
                                      <!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>-->
                          </tr>
                          	<tr>
                                <td width="30%" colspan="3" id="sur9">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 2 &nbsp;&nbsp;</font>
                                         </td>
                                         
                                         <td width="10%" id="sur10"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome2" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome2)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome2"))%>">
                                      </td>
                                      <!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>-->
                          </tr>
                          	<tr>
                                <td width="25%" colspan="3" id="sur11">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 3 &nbsp;&nbsp;</font>
                                         </td>
                                         
                                         <td width="5%" id="sur12"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome3" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome3)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome3"))%>">
                                      </td>
                                      <!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>-->
                          </tr>
                          
                          <tr style="visibility:  hidden;position: absolute;">
                                <td width="25%" colspan="3" id="sur13">
                              <font size="1" face="MS Sans Serif"> 
                                     	Deduction from Spouse(Having separate income from regular employment), standing as Co-Borrower(FOR 70% 
                                     	Cutback-applicable for Product code 962/963/979) &nbsp;&nbsp;</font>
                                         </td>
                                         
                                         <td width="5%" id="sur14"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome4" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome4)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome4"))%>">
                                      </td>
                                      <!--<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>-->
                          </tr>
                          
                          <tr>
														<td width="25%" colspan="3" nowrap><font face="MS Sans Serif" size="1">Applicant Salary
														routed through our Bank<b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
														<td width="5%" align="left"><font size="1"
															face="MS Sans Serif"><select
															name="sel_routed">
															<option value="0" selected>Select</option>
															<option value="1">Yes</option>
															<option value="2">No</option>
														</select></font></td>
														<td width="50%"><font size="1" face="MS Sans Serif">&nbsp; </font></td>
														
													</tr>

												</table><br>

												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="100%">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td colspan="2"><font size="1" face="MS Sans Serif"><b>Deductions
												- Monthly</b></font></td>
												<td width="52%"><font size="1" face="MS Sans Serif">&nbsp; </font></td>
											</tr>
											<tr>
												<td width="39%"><font size="1" face="MS Sans Serif">(I)&nbsp;&nbsp;
												Towards loans and <br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Income tax etc.</font></td>
												<td width="9%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="52%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_autoloanexp" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_autoloanexp"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_autoloanexp)"
													onBlur="calDeduction();calcdeduction();roundtxt(document.forms[0].txtperinc_autoloanexp);calDeduction();calcdeduction()">
												</font></td>
											</tr>
											<tr>
												<td width="39%"><font size="1" face="MS Sans Serif">(II)&nbsp;&nbsp;Towards
												EPF/Addl.EPF/PPF/LIP</font></td>
												<td width="9%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="52%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_rentexp" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_rentexp"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_rentexp)"
													onBlur="calDeduction();calcdeduction();roundtxt(document.forms[0].txtperinc_rentexp);calDeduction();calcdeduction()">
												</font></td>
											</tr>
											<tr>
												<td width="39%"><font face="MS Sans Serif" size="1">(III)&nbsp;&nbsp;Others</font></td>
												<td width="9%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="52%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_otherexp" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherexp"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_otherexp)"
													onBlur="calDeduction();calcdeduction();roundtxt(document.forms[0].txtperinc_otherexp);calDeduction();calcdeduction()">
												</font></td>
											</tr>
											<tr>
												<td width="39%"><font size="1" face="MS Sans Serif">Total</font></td>
												<td width="9%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="52%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_total" size="12" maxlength="12"
													style="text-align:right"
													onKeyPress="allowNumber(document.forms[0].txtperinc_total)"
													onBlur="roundtxt(document.forms[0].txtperinc_total)"> </font></td>
											</tr>
											<tr>
												<td width="39%"><font size="1" face="MS Sans Serif">Description</font></td>
												<td width="9%" align="right">&nbsp;</td>
												<td width="52%"><textarea name="txtperinc_otherdesc"
													cols="20" rows="2"><%=Helper.correctNull((String) hshValues
							.get("perinc_otherdesc"))%></textarea>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="100%">
									<tr>
										<td valign="top" height="110">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td width="49%" colspan="2"><font size="1"
													face="MS Sans Serif"><b>Self Employment Details</b></font></td>
												<td width="51%"><font size="1" face="MS Sans Serif">&nbsp; </font></td>
											</tr>
											<tr>
												<td colspan="2"><font size="1" face="MS Sans Serif">Constitution
												</font></td>
												<td width="51%"><font size="1" face="MS Sans Serif"> <select
													name="choperinc_selfincometype">
												<!--  	<option value="S">---Select-----</option>
													<option value="1">Private Ltd</option>
													<option value="2">Partnership</option>
													<option value="3">Proprietorship</option>
													<option value="4">Others</option>-->
													<option value="0" selected> <----Select----> 
                                    				</option>
                                    				<lapschoice:StaticDataTag apptype="20"/> 
												</select> </font></td>
											</tr>
											
											<tr style="visibility:hidden">
												<td width="24%">Other Information</td>
												<td width="25%">&nbsp;</td>
												<td width="51%"><font size="1" face="MS Sans Serif">
												 <select name="sel_pigmy" tabindex="12">
                                    				<option value="0" selected> <----Select----> 
                                    				</option>
                                    				<lapschoice:StaticDataTag apptype="17"/> 
                                  				 </select> </font></td>
											</tr>
											
											<tr style="visibility:hidden">
												<td colspan="2"><font face="MS Sans Serif" size="1"> Years
												in Profession</font></td>
												<td width="51%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperinc_selfyrsprof" size="5"
													maxlength="4"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_selfyrsprof"))%>"
													onKeyPress="allowInteger()"> </font></td>
											</tr>
											
											<tr>
												<td width="24%">&nbsp;</td>
												<td width="25%">&nbsp;</td>
												<td width="51%">&nbsp;</td>
											</tr>
											<tr bordercolor="#CCCCFF" style="visibility:hidden">
												<td width="39%"><span onMouseover="showDedc('y')"
													onMouseout="showDedc('n')"><font size="1"
													face="MS Sans Serif">Deduction</font></span></td>
												<td width="5%" align="right"><font size="1"
													face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="49%"><font size="1" face="MS Sans Serif"> <input
													type="text" size="12" maxlength="12"
													style="text-align:right" name="txtperinc_deduction1"
													onKeyPress="allowNumber(document.forms[0].txtperinc_deduction1)"
													onBlur="calDeduction();calcdeduction();roundtxt(document.forms[0].txtperinc_deduction1);calDeduction();calcdeduction()"
													readOnly onMouseover="showDedc('y')"
													onMouseout="showDedc('n')"> </font></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						
                      <table width="100%" border="1" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td colspan="3" nowrap><font size="1"
													face="MS Sans Serif"><b>Non 
                                  Salaried Income Details</b></font></td>
                              </tr>
                              <tr align="left"> 
                                <td colspan="1" nowrap ><font size="1"
													face="MS Sans Serif">Income/Turnover 
                                  Criteria<br>
                                  (Incase of Synd Laghuudyami Loans) </font></td>
                                <td  height="35" align="left"><b><font size="1" face="MS Sans Serif"> 
                                  <select name="selturnovervalues" onChange="checkpreyrdisable()"
													tabindex="12">
                                    <option value="0" selected> ----Select---- 
                                    </option>
                                    <lapschoice:StaticDataTag apptype="16"/> 
                                  </select>
                                  </font> </b></td>
                                <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr> 
                                      <td width="13%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Pre 
                                          Year - 3</b></font></div></td>
                                      <td width="13%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Pre 
                                          Year - 2</b></font></div></td>
                                      <td width="15%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Pre 
                                          Year - 1</b></font></div></td>
                                      <td width="20%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Total 
                                          for last 3 years</b></font></div></td>
                                      <td width="18%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Average 
                                          Income </b></font></div></td>
                                      <td width="21%" nowrap> <div align="center"><font size="1" face="MS Sans Serif"><b>Latest 
                                          Income </b></font></div></td>
                                    </tr>
                                  </table></td>
                              </tr>
                              <tr align="left"> 
                                <td  nowrap height="35"><font size="1" face="MS Sans Serif">Proof 
                                  of Income </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                <td  height="35" align="left"><b><font size="1" face="MS Sans Serif"> 
                                  <select name="selincproof"
													tabindex="12">
                                    <option value="0" selected> ----Select---- 
                                    </option>
                                    <lapschoice:StaticDataTag apptype="3"/> 
                                  </select>
                                  </font> </b></td>
                                <td > <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr> 
                                      <td  width="13%" height="21"> <div align="center"> 
                                          <input type="text" name="year3" onBlur="calcaverage();roundtxt(this);allowDecimals(this.value)"  onKeyPress="allowNumber(this.value)" size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("YEAR3_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="13%"> <div align="center"> 
                                          <input type="text" name="year2" onBlur="calcaverage();roundtxt(this)" onKeyPress="allowDecimals(this.value)" size="10"  maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("YEAR2_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="15%"> <div align="center"> 
                                          <input type="text" name="year1" onBlur="calcaverage();roundtxt(this)" onKeyPress="allowDecimals(this.value)" size="10"  maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("YEAR1_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="20%"> <div align="center"> 
                                          <input type="text" name="total"  size="10"  maxlength="10"  onBlur="roundtxt(this)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("TOTAL_INCOME"))%>" style="text-align:right" disabled>
                                        </div></td>
                                      <td width="18%"> <div align="center"> 
                                          <input type="text" name="average" size="10"  maxlength="10" onBlur="roundtxt(this)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctDouble((String)hshValues.get("AVERAGE_INCOME"))%>" style="text-align:right" disabled>
                                        </div></td>
                                      <td width="21%"> <div align="center"> 
                                          <input type="text" name="latest" size="10"    maxlength="10" onBlur="calcaverage1();roundtxt(this)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctDouble((String)hshValues.get("LATEST_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                    </tr>
                                  </table></td>
                              </tr>
                              <tr align="left"> 
                                <td  nowrap height="35"><font size="1" face="MS Sans Serif">Stability 
                                  Of Income</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                <td colspan="2" align="left" ><font size="1"
													face="MS Sans Serif"> 
                                  <select name="sel_incstability"
													tabindex="12">
                                    <option value="0" selected> <----Select----> 
                                    </option>
                                    <lapschoice:StaticDataTag apptype="4"/> 
                                  </select>
                                  </font></td>
                              </tr>
                            </table> 
                          </td>
                        </tr>
                        <tr id="id_agrInc">
                          <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr align="center"> 
                                <td width="25%" align="left" height="10"><font size="2" face="MS Sans Serif"><b>Agricultural Income Details</b> </font></td>
                                <td width="5%" align="right"></td>
                                <td width="50%"  align="left"><font size="2" face="MS Sans Serif"><b>Gross Income</b> </font></td> 
                                </tr>
							 <tr>
								<td width="25%"><font face="MS Sans Serif" size="1">i)&nbsp;Agriculture</font></td>
								<td width="5%" align="right"><font size="1"
									face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
								<td width="50%"><font size="1" face="MS Sans Serif"> <input type="text" name="txt_incAgri" size="12" maxlength="12"
									style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("INC_AGRI"))%>"
									onKeyPress="allowNumber(document.forms[0].txt_incAgri);" onBlur="roundtxt(document.forms[0].txt_incAgri);sumOfAgriIncome();">
									</font></td>
											</tr>
							<tr>
								<td width="25%"><font face="MS Sans Serif" size="1">ii)&nbsp;Allied Activities</font></td>
								<td width="5%" align="right"><font size="1"
									face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
								<td width="50%"><font size="1" face="MS Sans Serif"> <input type="text" name="txt_incAllied_Act" size="12" maxlength="12"
									style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("INC_ALLIEDACT"))%>"
									onKeyPress="allowNumber(document.forms[0].txt_incAllied_Act);" onBlur="roundtxt(document.forms[0].txt_incAllied_Act);sumOfAgriIncome();">
									</font></td>
											</tr>
							<tr>
								<td width="25%"><font face="MS Sans Serif" size="1">iii)&nbsp;Other</font></td>
								<td width="5%" align="right"><font size="1"
									face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
								<td width="50%"><font size="1" face="MS Sans Serif"> <input type="text" name="txt_incOther" size="12" maxlength="12"
									style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("INC_OTHER"))%>"
									onKeyPress="allowNumber(document.forms[0].txt_incOther);" onBlur="roundtxt(document.forms[0].txt_incOther);sumOfAgriIncome();">
									</font></td>
											</tr>
							<tr>
								<td width="25%"><font face="MS Sans Serif" size="1">&nbsp;<b>Total</b></font></td>
								<td width="5%" align="right"><font size="1"
									face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
								<td width="50%"><font size="1" face="MS Sans Serif"> <input type="text" name="txt_incTotal" size="12" maxlength="12"
									style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("INC_TOTAL"))%>"
									onKeyPress="allowNumber(document.forms[0].txt_incTotal);" onBlur="roundtxt(document.forms[0].txt_incTotal);">
									</font></td>
											</tr>												
                                </table>
                               </td></tr> 
                      </table>
                      </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
<br>
<table width="12%" border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center"
	class="outertablecolor">
	<tr>
		<td>
		<table width="43%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td height="0"><input type="button" name="cmdEdit" value="Edit"
					style="width:50" class="buttoncolor" onClick="callEdit()"></td>
				<td height="0"><input type="button" name="cmdApply" value="Apply"
					style="width:50" class="buttoncolor" onClick="callApply()"></td>
				<td height="0"><input type="button" name="cmdCancel" value="Cancel"
					style="width:50" class="buttoncolor" onClick="callCancel()"></td>
				<td height="0"><input type="button" name="cmdDelete" value="Delete"
					style="width:50" class="buttoncolor" onClick="callDelete()"></td>
				<td height="0"><input type="button" name="cmdHelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onClick="callhelp()"></td>
				<td height="0">
				<div align="center"><input type="button" name="cmdClose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onClick="callClose()"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<INPUT TYPE="hidden" name="hidAppType"> <INPUT TYPE="hidden"
	name="hidApp_type" value="A"> <input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanId" value="mastapplicant"> <input
	type="hidden" name="hidSourceUrl"> <input type="hidden"
	name="hidBeanGetMethod"> <input type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>"> <input
	type="hidden" name="trapEdit" value=""> <font size="1"
	face="MS Sans Serif"> <input type="hidden" name="txtperinc_secincome"
	size="12" maxlength="12" style="text-align:right"
	value="<%=Helper.correctNull((String)hshValues.get("perinc_secincome"))%>"
	onKeyPress="allowNumber(document.forms[0].txtperinc_secincome)"
	onBlur="roundtxt(document.forms[0].txtperinc_secincome)"> </font> <input
	type="hidden" name="hidDOB"
	value="<%=Helper.correctNull((String)request.getParameter("hidDOB"))%>">
	
<input type="hidden" name="hidappstatus"
	value="<%=Helper.correctNull((String)request.getParameter("hidappstatus"))%>">
<input type="hidden" name="scode" value="yyy">
<input type="hidden" name="closeFlag" value="">
</form>
</body>
</html>
