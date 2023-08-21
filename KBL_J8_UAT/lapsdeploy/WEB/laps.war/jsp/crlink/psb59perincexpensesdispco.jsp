<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String pageid = request.getParameter("pageid");
	String strApplnt = request.getParameter("applnt");
		
		if(strApplnt.equals("C"))
		{
		strApplnt = "CoApplicant";
		}
		else
		{
		strApplnt = "Guarantor";
		}
		
java.text.DecimalFormat nf = new java.text.DecimalFormat();
nf.setGroupingUsed(true);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String pageType=Helper.correctNull((String) session.getAttribute("pageType"));
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/nationalportal/psb59perincexpensesdispco.js"> </script>
<SCRIPT LANGUAGE="JavaScript">

var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var varTypeProfession="<%=Helper.correctNull((String)hshValues.get("perinc_selfincometype"))%>";
var vartakegross="<%=Helper.correctNull((String)hshValues.get("pertakegross"))%>";
var vargetemp="<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varselroute="<%=Helper.correctNull((String)hshValues.get("sel_routed"))%>";
var varempstatus="<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
var varsurityinclude="<%=Helper.correctNull((String)hshValues.get("perinc_surityinclude"))%>";
var varincomstability="<%=Helper.correctNull((String)hshValues.get("perapp_incomstability"))%>";
var strincome_proof="<%=Helper.correctNull((String)hshValues.get("INCOME_PROOF"))%>";
var strturn_over="<%=Helper.correctNull((String)hshValues.get("TURN_OVER"))%>";
var varsel_seperateInc="<%=Helper.correctNull((String)hshValues.get("PERINC_SEPERATINC"))%>";
function callhelp()
{
		   var varQryString = appURL+"/jsp/perhlp/hlp_perincexpensesdispco.jsp"
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
function hidesurities()
{
	if(document.forms[0].sel_surityinclude.value=="1")
	{
		document.all.sur1.style.visibility="visible";
		document.all.sur2.style.visibility="visible";
		document.all.sur3.style.visibility="visible";
		document.all.sur4.style.visibility="visible";
		document.all.sur5.style.visibility="visible";
		document.all.sur6.style.visibility="visible";
		document.all.sur7.style.visibility="visible";
		document.all.sur8.style.visibility="visible";
		document.all.sur9.style.visibility="visible";
		document.all.sur10.style.visibility="visible";
		document.all.sur11.style.visibility="visible";
		document.all.sur12.style.visibility="visible";
		document.all.sur13.style.visibility="hidden";
		document.all.sur14.style.visibility="hidden";
		document.all.sur15.style.visibility="hidden";
		document.all.sur16.style.visibility="hidden";
	}
	else
	{
		document.all.sur1.style.visibility="hidden";
		document.all.sur2.style.visibility="hidden";
		document.all.sur3.style.visibility="hidden";
		document.all.sur4.style.visibility="hidden";
		document.all.sur5.style.visibility="hidden";
		document.all.sur6.style.visibility="hidden";
		document.all.sur7.style.visibility="hidden";
		document.all.sur8.style.visibility="hidden";
		document.all.sur9.style.visibility="hidden";
		document.all.sur10.style.visibility="hidden";
		document.all.sur11.style.visibility="hidden";
		document.all.sur12.style.visibility="hidden";
		document.all.sur13.style.visibility="hidden";
		document.all.sur14.style.visibility="hidden";
		document.all.sur15.style.visibility="hidden";
		document.all.sur16.style.visibility="hidden";
	}
}
function placeproofvalue()
{
var strincome_proof="<%=Helper.correctNull((String)hshValues.get("INCOME_PROOF"))%>";
var strturn_over="<%=Helper.correctNull((String)hshValues.get("TURN_OVER"))%>";
var sel_pigmy="<%=Helper.correctNull((String)hshValues.get("sel_pigmy"))%>";
	
	if(varsel_seperateInc=="0")
	{			
		document.forms[0].sel_seperateInc.value=0;
	}
	else if(varsel_seperateInc=="1")
	{
		document.forms[0].sel_seperateInc.value=1;
	}
	else if(varsel_seperateInc=="2")
	{
		document.forms[0].sel_seperateInc.value=2;
	}	
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
		if(varempstatus=="4"||varempstatus=="6"||varempstatus=="7"||varempstatus=="8"||varempstatus=="9" ||varempstatus=="15")
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
if(year2=="0" || year2=="0.0" || year2=="0.00")
{
	year2="";
}
if(year1=="0" || year1=="0.0" || year1=="0.00")
{
	year1="";
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


</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body class="bgcolor" text="#000000"  vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad();calDeduction();callOnlyDeduction();placeproofvalue()">
<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>
<div id="dover" style="position:absolute; left:286px; top:195px; width:89px; height:13px; z-index:1; visibility: hidden"> 
  <table width="100" border="1" cellspacing="0" cellpadding="0" bgcolor="#FFFFCC">
    <tr> 
      <td align="center"><font size="1" face="Arial, Helvetica, sans-serif">PF 
        + IT + Prof. Tax + Deductions for LIC / ULIP etc.</font></td>
    </tr>
  </table>
</div>
<div id="dover2" style="position:absolute; left:286px; top:221px; width:89px; height:13px; z-index:1; visibility: hidden"> 
  <table width="100" border="1" cellspacing="0" cellpadding="0" bgcolor="#FFFFCC">
    <tr> 
      <td align="center"><font size="1" face="Arial, Helvetica, sans-serif">PF 
        + IT + Prof. Tax + Deductions for LIC / ULIP + Total Loan Repayment + 
        Rent Paid </font></td>
    </tr>
  </table>
</div>
<jsp:include page="../share/help.jsp" flush="true"> </jsp:include>
<form name="appform" method="post" action="">
  <div align="center"> </div>
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td>
		<%if(!pageType.equals("agri")){ %>
		<jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include>
		
		<%}else{ %>
		<jsp:include page="../agri/Applurllinkagri.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include>
		<%} %>
		</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>  	<%if(pageType.equals("agri")){%>
    <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Agriculture <span class="bredcrumbArw"> &gt; </span> &nbsp;<%= (String)session.getAttribute("pgeLabel")%> <span class="bredcrumbArw"> &gt; </span> &nbsp;  <%=strApplnt%></td>
    <%} else{%>
		  <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Retail <span class="bredcrumbArw"> &gt; </span> &nbsp; <%= (String)session.getAttribute("pgeLabel")%> <span class="bredcrumbArw"> &gt; </span> &nbsp;  <%=strApplnt%></td>
		<%} %>
     </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td >
              <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertablecolor">
    <tr> 
      <td colspan="2"> 
        <table width="55%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="30%" class="tabinactive"><b><font size="1" face="ms sans serif"><a href="JavaScript:callDemographics()" class="blackfont">Demographics</a></font></b></td>
            <td width="35%" class="tabactive"><b><font size="1" face="ms sans serif" color="#FFFFFF">Income 
              &amp; Deductions</font></b></td>
            <td width="35%" class="tabinactive" id="employertdbtn1" ><b><font size="1" face="ms sans serif"><a href="JavaScript:callEmployer()" class="blackfont">Employment 
              Details </a></font></b></td>
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
		<div class="cellContainer">
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
													onBlur=""
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
											<tr>
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
											<tr>
												<td width="25%" nowrap colspan="2"><font size="1" face="MS Sans Serif">Whether Income from Spouse/Surity/Co-Borrower to be Included for calculating Loan Eligibility</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td width="5%" align="left"><select
															name="sel_surityinclude" onChange=hidesurities()>
															<option value="0" selected>Select</option>
															<option value="1">Yes</option>
															<option value="2" selected>No</option>
														</select></td>
												</tr>

										</table>
										<table width="100%" border="1" cellspacing="0" cellpadding="4"
											bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
											height="100%">
											<tr>
												<td valign="top"> 
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3">

													<tr>
														<td width="25%" colspan="3" nowrap id="sur1"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 1</font></td>
														<td width="5%" align="right" id="sur2"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("txtperinc_relative"))%>"
															onKeyPress="txtperinc_relative" onBlur="roundtxt(txtperinc_relative)"></font></td>
														<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td></tr>
														<tr>
														<td width="25%" colspan="3" nowrap id="sur3"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 2</font></td>
														<td width="5%" align="right" id="sur4"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative2" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome2"))%>"
															onKeyPress="txtperinc_relative2" onBlur="roundtxt(txtperinc_relative2)"></font></td>
														<td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td></tr>
														<tr>
														<td width="25%" colspan="3" nowrap id="sur5"><font face="MS Sans Serif" size="1">Monthly Gross Income
														from Relative/Spouse, standing as Co-Borrower/Guarantor 3</font></td>
														<td width="5%" align="right" id="sur6"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative3" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome3"))%>"
															onKeyPress="txtperinc_relative3" onBlur="roundtxt(txtperinc_relative3)"></font></td>
														<td width="50%">&nbsp;<font size="1" face="MS Sans Serif">
														</font></td></tr>
														
														<tr>
														<td width="25%" colspan="3" nowrap id="sur15"><font face="MS Sans Serif" size="1">Monthly Gross 
														Income from Spouse(Having separate income from regular employment), standing as Co-Borrower
														(FOR 70% Cutback-applicable for Product code 962/963/979)</font></td>
														<td width="5%" align="right" id="sur16"><font size="1"
															face="MS Sans Serif"><%=ApplicationParams.getCurrency()%><input
															type="text" name="txtperinc_relative4" size="12"
															maxlength="12" style="text-align:right"
															value="<%=Helper.correctNull((String)hshValues.get("perinc_relincome4"))%>"
															onKeyPress="txtperinc_relative4" onBlur="roundtxt(txtperinc_relative4)"></font></td>
														<td width="50%">&nbsp;<font size="1" face="MS Sans Serif">
														</font></td></tr>

															
												
													
							<tr>
                                <td width="25%" colspan="3" id="sur7">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 1 </font>
                                         </td>
                                         
                                         <td width="5%" id="sur8"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome"))%>">
                                      </td>
                                      <td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>
                          </tr>
                          	 	<tr>
                                <td width="25%" colspan="3" id="sur9">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 2 </font>
                                         </td>
                                         
                                         <td width="5%" id="sur10"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome2" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome2)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome2"))%>">
                                      </td>
                                      <td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>
                          </tr>
                          	<tr>
                                <td width="25%" colspan="3" id="sur11">
                              <font size="1" face="MS Sans Serif"> 
                                     	Surety/Co-Borrower's Monthly Deductions 3</font>
                                         </td>
                                         
                                         <td width="5%" id="sur12"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome3" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome3)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome3"))%>">
                                      </td>
                                      <td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>
                          </tr>
                          
                          <tr>
                                <td width="25%" colspan="3" id="sur13">
                              <font size="1" face="MS Sans Serif"> 
                                     	Deduction from Spouse(Having separate income from regular employment), standing as Co-Borrower
                                     	(FOR 70% Cutback-applicable for Product code 962/963/979) </font>
                                         </td>
                                         
                                         <td width="5%" id="sur14"><%=ApplicationParams.getCurrency()%><input type="text" name="txtperapp_spincome4" size="12" maxlength="12"   onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onBlur="roundtxt(txtperapp_spincome4)" value="<%=Helper.correctNull((String)hshValues.get("perinc_jointincome4"))%>">
                                      </td>
                                      <td width="50%">&nbsp;<font size="1" face="MS Sans Serif"></font></td>
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

												</table>

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
                                          <input type="text" name="year3" onBlur="calcaverage();roundtxt(year3);allowDecimals(this.value)"  onKeyPress="allowNumber(this.value)" size="10"  maxlength="10"   value="<%=Helper.correctNull((String)hshValues.get("YEAR3_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="13%"> <div align="center"> 
                                          <input type="text" name="year2" onBlur="calcaverage();roundtxt(year2)" onKeyPress="allowDecimals(this.value)" size="10"  maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("YEAR2_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="15%"> <div align="center"> 
                                          <input type="text" name="year1" onBlur="calcaverage();roundtxt(year1)" onKeyPress="allowDecimals(this.value)" size="10"  maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("YEAR1_INCOME"))%>" style="text-align:right">
                                        </div></td>
                                      <td width="20%"> <div align="center"> 
                                          <input type="text" name="total"  size="10"  maxlength="10"  onBlur="roundtxt(total)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctNull((String)hshValues.get("TOTAL_INCOME"))%>" style="text-align:right" disabled>
                                        </div></td>
                                      <td width="18%"> <div align="center"> 
                                          <input type="text" name="average" size="10"  maxlength="10" onBlur="roundtxt(average)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctDouble((String)hshValues.get("AVERAGE_INCOME"))%>" style="text-align:right" disabled>
                                        </div></td>
                                      <td width="21%"> <div align="center"> 
                                          <input type="text" name="latest" size="10"    maxlength="10" onBlur="roundtxt(latest)" onKeyPress="allowDecimals(this.value)" value="<%=Helper.correctDouble((String)hshValues.get("LATEST_INCOME"))%>" style="text-align:right">
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
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" bgcolor="#DEDACF" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0"> 
              <input type="button" name="cmdEdit" value="Edit" style="width:50" class="buttoncolor" onClick="callEdit()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdapply" value="Apply" style="width:50" class="buttoncolor" onClick="callApply()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdCancel" value="Cancel" style="width:50"  class="buttoncolor">
            </td>
            <td height="0"> 
              <input type="button" name="cmdDelete" value="Delete" style="width:50" class="buttoncolor" disabled>
            </td>
            <td height="0"> 
              <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
            </td>
            <td height="0"> 
              <div align="center"> 
                <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hidApp_type" value="A">
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidBeanGetMethod" >
  
  <!-- <INPUT TYPE="hidden" name="appno" value="<%=request.getParameter("appno")%>"> -->
  <INPUT TYPE="hidden" name="page" value="ep">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <font size="1" face="MS Sans Serif">
  <input type="hidden" name="txtperinc_secincome" size="12" maxlength="12" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("perinc_secincome"))%>" onKeyPress="allowDecimals()" onBlur="roundtxt(document.forms[0].txtperinc_secincome)">
  </font> 

<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
<input type="hidden" name="hidCoDemoId" value="<%=(String)request.getParameter("hidCoDemoId")%>">
<INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=(String)request.getParameter("hidGuaDemoId")%>">

<INPUT TYPE="hidden" name="hiPgDist" value="P">
<INPUT TYPE="hidden" name="pageid" value="<%=pageid%>">

<INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>" >

</form>
</body>
</html>
 