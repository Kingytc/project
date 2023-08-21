<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<!--<lapschoice:handleerror />-->
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%Vector vecRow = (Vector) hshValues.get("vecRow");
			Vector vecCol = null;
			Vector v = null;
			String zero = "", one = "", two = "", three = "", four = "", five = "";
			String ss = Integer.toString(vecRow.size() + 1);

			%>

<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 400%;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varselcurrentscope="<%=Helper.correctNull((String)hshValues.get("fir_currentscope"))%>";
var varselexperience="<%=Helper.correctNull((String)hshValues.get("fir_borrexp"))%>";
function ShowStates(stateval)
{
		
			var purl = appURL+"action/stateslist.jsp?stateval="+stateval;
			prop = "scrollbars=yes,width=300,height=650,statusbar=yes,menubar=no";	
			xpos = 400;
			ypos = 5;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
			window.open(purl,title,prop);
}
function callhelp()
{
		   var varQryString = appURL+"/jsp/perhlp/hlp_setfirmdetails.jsp"
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}
function onloadingdata()
{

if(varselcurrentscope!="")
			{
				document.forms[0].selcurrentscope.value=varselcurrentscope;
				
				
			}
			else 
			{
				document.forms[0].selcurrentscope.value=0;
			}
		
		if(varselexperience!="")
			{
				document.forms[0].selexperience.value=varselexperience;
				
				
			}
			else 
			{
				document.forms[0].selexperience.value=0;
			}
	

if(document.forms[0].txt_name.value != "")
	{
	document.forms[0].cmdApply.disabled =true;
	document.forms[0].cmdCancel.disabled =true;
	disableFields(true);
	}
	else
	{		
	document.forms[0].cmdApply.disabled =false;
	document.forms[0].cmdEdit.disabled =true;
	}
	document.forms[0].txt_rstate.disabled = true;
	document.forms[0].txt_fstate.disabled = true;
	
}

function checktot(val)
{
	alert(val);
	if(val > 100)
	{
		alert("Not more than 100%");
		//document.forms[0].share[0].focus();
return false;
	}
}
function alerttotal()
{
	var share1=0,share2=0,share3=0,share4=0,share5=0;
	if(trim(document.forms[0].share[0].value) != "")
	{
		
		share1 =trim(document.forms[0].share[0].value);
	}
	
	if(trim(document.forms[0].share[1].value) != "")
	{
		share2 = trim(document.forms[0].share[1].value);
	}
	if(trim(document.forms[0].share[2].value) != "")
	{
		share3 = trim(document.forms[0].share[2].value);		
	}
		if(trim(document.forms[0].share[3].value) != "")
	{
		share4 = trim(document.forms[0].share[3].value);		
	}

	if(trim(document.forms[0].share[4].value) != "")
	{
		share5 = trim(document.forms[0].share[4].value);		
	}

//var  total = parseInt(document.forms[0].share[0].value)+parseInt(document.forms[0].share[1].value)+parseInt(document.forms[0].share[2].value)+	parseInt(document.forms[0].share[3].value)+parseInt(document.forms[0].share[4].value)
	var  total = parseInt(share1)+parseInt(share2)+parseInt(share3)+	parseInt(share4)+parseInt(share5);
	
	
   if(parseInt(total)>100)
	{
			alert("Share in business % Cannot be more then 100% ! ! !");
	}
}

function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		   if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
	  }
	  
  }
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}

}

function doApply()
{
	var share1=0,share2=0,share3=0,share4=0,share5=0;
	
	
	if(document.forms[0].firmflagStatus.value == "Edit")
	{
			document.forms[0].firmflag.value = "Edit"
	}
	else
	{
					document.forms[0].firmflag.value = "Insert"
	}

	if(trim(document.forms[0].share[0].value) != "")
	{
		
		share1 =trim(document.forms[0].share[0].value);
	}
	
	if(trim(document.forms[0].share[1].value) != "")
	{
		share2 = trim(document.forms[0].share[1].value);
	}
	if(trim(document.forms[0].share[2].value) != "")
	{
		share3 = trim(document.forms[0].share[2].value);		
	}
		if(trim(document.forms[0].share[3].value) != "")
	{
		share4 = trim(document.forms[0].share[3].value);		
	}

	if(trim(document.forms[0].share[4].value) != "")
	{
		share5 = trim(document.forms[0].share[4].value);		
	}

	var  total = parseInt(share1)+parseInt(share2)+parseInt(share3)+	parseInt(share4)+parseInt(share5);
   if(parseInt(total)>100)
	{
			alert("Share in business % Cannot be more then 100% ! ! !");
	}
	else
	{
	document.forms[0].txt_rstate.disabled = false;
	document.forms[0].txt_fstate.disabled = false;
			document.forms[0].method="post";
			document.forms[0].hidBeanId.value="setfirmdetails";
			document.forms[0].hidBeanMethod.value="updateFirmData";
			document.forms[0].hidBeanGetMethod.value="getFirmData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/setfirmdetails.jsp";
			document.forms[0].submit();
	}
}
function doEdit()
{			document.forms[0].trapEdit.value="TE"
			document.forms[0].firmflagStatus.value = "Edit"
			document.forms[0].cmdApply.disabled =false;
			document.forms[0].cmdEdit.disabled =true;
			document.forms[0].cmdCancel.disabled =false;
			disableFields(false);
			document.forms[0].txt_rstate.disabled = true;
			document.forms[0].txt_fstate.disabled = true;
			document.forms[0].txt_name.focus();
}

function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	
		document.forms[0].hidBeanGetMethod.value="getFirmData";
		document.forms[0].hidBeanId.value="setfirmdetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/setfirmdetails.jsp";
		document.forms[0].submit();
	}
}

	
	//for links employ 
	function callEmployer()
{
	  if(document.forms[0].trapEdit.value!="TE")
    	{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
			}
	 else
	 {
	 	ShowAlert('103');
	 }
}

// for link demo
function callIncomeExpenses()
{
	if(document.forms[0].trapEdit.value!="TE")
	{
			document.forms[0].hidAppType.value="";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callDemographics()
{

	if(document.forms[0].trapEdit.value!="TE")
	{
			document.forms[0].hidAppType.value="";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body text="#000000" vlink="#330000" alink="#330000" leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0" onload="onloadingdata()"
	class="bgcolor">
<jsp:include page="../share/help.jsp" flush="true">
</jsp:include>
<form name="appform" method="post" action="">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="outertablecolor"><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b><i>Home -&gt; Retail </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile Search </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font>
		</i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile </i></b></font><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Set Firm/Company Details </i></b></font></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td colspan="2" valign="bottom">
		<table width="90%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>
				<td width="25%" class="tabinactive" align="center"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callDemographics()"
					class="blackfont">Demographics</a></font></b></td>
				<td width="25%" align="center" class="tabinactive"><b><font size="2"
					face="ms sans serif"><a href="JavaScript:callIncomeExpenses()"
					class="blackfont"><font size="1">Income &amp; Deductions</font></a></font></b></td>
				<td width="25%" id="employertdbtn1" align="center"
					class="tabinactive"><b><font size="2" face="ms sans serif"><a
					href="JavaScript:callEmployer()" class="blackfont"><font size="1">Employment
				Details </font></a></font></b></td>
				<td width="25%" class="tabactive" align="center"><b><font size="1"
					face="ms sans serif" color="#FFFFFF">Firm/Company Details</font></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

	<tr>
		<td valign="top">
		<div align="left"></div>
		
			<tr>
				<td>

				
					<tr>
						<td valign="top" colspan="5">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="30%" valign="top">

								<table width="100%" border="1" cellspacing="0" cellpadding="1"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td valign="top" width="30%">

										<table width="100%" border="0" cellspacing="0">
											<tr>
												<td width="8%"><font size="1" face="MS Sans Serif">Name </font><b><font
													size="1" face="MS Sans Serif" color="#FF0000"></font></b></td>
												<td valign="top" width="43%"><font size="1"
													face="MS Sans Serif"> <input type="text" name="txt_name"
													size="50" maxlength="50" tabindex="1"
													value="<%=Helper.correctNull((String)hshValues.get("txt_name"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
												<td width="11%"><font size="1" face="MS Sans Serif">Constitution</font></td>
												<td width="38%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txt_const" size="50" maxlength="50"
													tabindex="2"
													value="<%=Helper.correctNull((String)hshValues.get("txt_const"))%>">
												<font size="2"></font> </font></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">

								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td width="30%">
										
                  <table width="100%" border="0" cellspacing="0" cellpadding="1">
                    <tr> 
                      <td colspan="2"><font size="1" face="MS Sans Serif"><b>Registered 
                        Office Address</b></font></td>
                      <td width="8%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                      <td colspan="2"><font size="1" face="MS Sans Serif"><b>Factory 
                        Address</b></font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">Address</font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_radd1" size="30" maxlength="50"
													tabindex="3"
													value="<%=Helper.correctNull((String)hshValues.get("txt_radd1"))%>"
													onKeyPress="notAllowedDouble()">
                        </font></td>
                      <td width="8%">&nbsp;</td>
                      <td width="16%"><font size="1" face="MS Sans Serif">Address</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fadd1" size="30" maxlength="50"
													tabindex="11"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fadd1"))%>">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_radd2" size="30" maxlength="50"
													tabindex="4"
													value="<%=Helper.correctNull((String)hshValues.get("txt_radd2"))%>"
													onKeyPress="notAllowedDouble()">
                        </font></td>
                      <td width="8%">&nbsp;</td>
                      <td width="16%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fadd2" size="30" maxlength="50"
													tabindex="12"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fadd2"))%>">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_rcity" size="18" maxlength="30"
													tabindex="5"
													value="<%=Helper.correctNull((String)hshValues.get("txt_rcity"))%>"
													onKeyPress="allowAlphabetsAndSpace()">
                        </font></td>
                      <td width="8%">&nbsp;</td>
                      <td width="16%"><font size="1" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fcity" size="18" maxlength="30"
													tabindex="13"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fcity"))%>"
													onKeyPress="allowAlphabetsAndSpace()">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">State</font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_rstate" size="18" maxlength="20"
													tabindex="6"
													value="<%=Helper.correctNull((String)hshValues.get("txt_rstate"))%>"
													onKeyPress="allowAlphabets()">
                        </font><a
													href="javascript:ShowStates('4')" class="blackfont">?</a></td>
                      <td width="8%"></td>
                      <td width="16%"><font size="1" face="MS Sans Serif">State</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fstate" size="18" maxlength="20"
													tabindex="14"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fstate"))%>"
													onKeyPress="allowAlphabets()">
                        </font><a
													href="javascript:ShowStates('5')" class="blackfont">?</a></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_rzip" size="12" maxlength="6"
													tabindex="7"
													value="<%=Helper.correctNull((String)hshValues.get("txt_rzip"))%>"
													onKeyPress="allowInteger()">
                        </font></td>
                      <td width="8%">&nbsp;</td>
                      <td width="16%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fzip" size="12" maxlength="6"
													tabindex="15"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fzip"))%>"
													onKeyPress="allowInteger()">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">Phone 
                        No</font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_rphone" size="18" maxlength="30"
													tabindex="8"
													value="<%=Helper.correctNull((String)hshValues.get("txt_rphone"))%>">
                        </font></td>
                      <td width="8%"></td>
                      <td width="16%"><font size="1" face="MS Sans Serif">Phone 
                        No</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_fphone" size="18" maxlength="30"
													tabindex="16"
													value="<%=Helper.correctNull((String)hshValues.get("txt_fphone"))%>">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%"><font size="1" face="MS Sans Serif">Fax 
                        No </font></td>
                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_rfax" size="18" maxlength="20"
													tabindex="9"
													value="<%=Helper.correctNull((String)hshValues.get("txt_rfax"))%>">
                        </font></td>
                      <td width="8%"></td>
                      <td width="16%"><font size="1" face="MS Sans Serif">Fax 
                        No</font></td>
                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_ffax" size="18" maxlength="20"
													tabindex="17"
													value="<%=Helper.correctNull((String)hshValues.get("txt_ffax"))%>">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%" height="17"><font size="1" face="MS Sans Serif">Email</font></td>
                      <td width="30%" height="17"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_remail" size="25" maxlength="50"
													tabindex="10"
													value="<%=Helper.correctNull((String)hshValues.get("txt_remail"))%>">
                        </font></td>
                      <td width="8%" height="17"></td>
                      <td width="16%" height="17"><font size="1" face="MS Sans Serif">Email</font></td>
                      <td width="34%" height="17"><font size="1" face="MS Sans Serif"> 
                        <input
													type="text" name="txt_femail" size="18" maxlength="50"
													tabindex="18"
													value="<%=Helper.correctNull((String)hshValues.get("txt_femail"))%>">
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="12%" height="17"><font size="1" face="MS Sans Serif">Current 
                        Scope</font></td>
                      <td width="30%" height="38"><b><font size="1" face="MS Sans Serif"> 
                        <select name="selcurrentscope"
													tabindex="12">
                          <option value="0" selected> <font size="1" face="MS Sans Serif"><----Select----> 
                          </font></option>
                          <lapschoice:StaticDataTag apptype="9"/> 
                        </select>
                        </font></b></td>
                      <td width="8%" height="38"></td>
                      <td width="12%" height="17"><font face="MS Sans Serif" size="1">Experience 
                        of the borrower</font></td>
                      <td width="30%" height="38"><b><font size="1" face="MS Sans Serif"> 
                        <select name="selexperience"
													tabindex="12">
                          <option value="0" selected> <font size="1" face="MS Sans Serif"><----Select----> 
                          </font></option>
                          <lapschoice:StaticDataTag apptype="10"/> 
                        </select>
                        </font></b></td>
                    </tr>
                  </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">
											<tr>
											<tr valign="top">
												<td colspan="7">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="3" bordercolorlight="#8F8369"
													bordercolordark="#FFFFFB">
													<tr align="center" class="tabactive">
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Name </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Age. </font></td>
														<td width="8%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Qualification </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Relation</font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Share in business %</font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Net Worth</font></td>
													</tr>
													<%int j = 0;
			for (int i = 0; i < 5; i++) {
				if (vecRow.size() > 0) {
					j = vecRow.size();
					if (i < j) {
						v = (Vector) vecRow.get(i);
						zero = Helper.correctNull((String) v.elementAt(0));
						one = Helper.correctNull((String) v.elementAt(1));
						two = Helper.correctNull((String) v.elementAt(2));
						three = Helper.correctNull((String) v.elementAt(3));
						four = Helper.correctNull((String) v.elementAt(4));
						five = Helper.correctNull((String) v.elementAt(5));

						%>
													<tr align="center">
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="name" value="<%=zero%>" maxlength="30" tabindex="18"
															onKeyPress="allowAlphabetsAndSpace()"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="age" value="<%=one%>" maxlength="3" tabindex="18"
															onKeyPress="allowInteger()"> </font></td>
														<td width="8%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="qul" value="<%=two%>" maxlength="40" tabindex="18"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="rela" value="<%=three%>" maxlength="30" tabindex="18"
															onKeyPress="allowAlphabetsAndSpace()"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="share" value="<%=four%>" onBlur=" alerttotal()"
															onKeyPress="allowInteger()" maxlength="5" tabindex="18"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="net" value="<%=five%>" onKeyPress="allowInteger()" tabindex="18"
															maxlength="10" style="text-align:right"> </font></td>
													</tr>

													<%} else {

					%>
													<tr align="center">
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="name" value=""
															onKeyPress="allowAlphabetsAndSpace()" maxlength="30" tabindex="18"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="age" value="" onKeyPress="allowInteger()"
															maxlength="3">. </font></td>
														<td width="8%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="qul" value="" maxlength="40"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="rela" value=""
															onKeyPress="allowAlphabetsAndSpace()" maxlength="30"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="share" value="" onKeyPress="allowInteger()" 
															maxlength="5"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="net" value="" onKeyPress="allowInteger()"
															maxlength="10" style="text-align:right"> </font></td>
													</tr>
													<%}
				} else {

				%>
													<tr align="center">
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text"
															name="name" value=""
															onKeyPress="allowAlphabetsAndSpace()" maxlength="30" tabindex="18"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="age" value="" onKeyPress="allowInteger()"
															maxlength="3"> </font></td>
														<td width="8%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="qul" value="" maxlength="40"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="rela" value=""
															onKeyPress="allowAlphabetsAndSpace()" maxlength="30"> </font></td>
														<td width="20%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="share" value="" onKeyPress="allowInteger()" onBlur="checktot(this.value)"
															maxlength="5"> </font></td>
														<td width="18%" height="0"><font size="1"
															face="MS Sans Serif" color="#FFFFFF"><input type="text" tabindex="18"
															name="net" value="" onKeyPress="allowInteger()"
															maxlength="10" style="text-align:right"> </font></td>
													</tr>
													<%}
			}

			%>
													
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">
											<tr>
												<td align="right" width="10%" nowrap><font size="1"
													face="MS Sans Serif">Nature of Dealings</font></td>
												<td width="10%"><font size="1" face="MS Sans Serif"
													color="#FFFFFF"><input type="text" size="60" name="txt_nod" tabindex="18"
													value="<%=Helper.correctNull((String)hshValues.get("txt_nod"))%>">
												<td width="10%" align="right" nowrap><font size="1"
													face="MS Sans Serif">Date of Commencement of Business</font></td>
												<td width="10%"><font size="1" face="MS Sans Serif"
													color="#FFFFFF"><input type="text" size="11" tabindex="18"
													name="txt_commencedate" onBlur="checkDate(this)"
													value="<%=Helper.correctNull((String)hshValues.get("txt_commencedate"))%>">
											</tr>
											
										</table>
										</td>
									</tr>
								</table>
						</table>
						<br>
						<div align="center">
						<table width="12%" border="1" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
							class="outertablecolor">
							<tr align="center">
								<td align="center">
								<table width="43%" border="0" cellspacing="0" cellpadding="2">
									<tr valign="top">
										<td height="0"><input type="button" name="cmdEdit"
											value="Edit" style="width:50" class="buttoncolor"
											onClick="doEdit()"></td>
										<td height="0"><input type="button" name="cmdApply"
											value="Apply" style="width:50" class="buttoncolor"
											onClick="doApply()"></td>
										<td height="0"><input type="button" name="cmdCancel"
											value="Cancel" style="width:50" class="buttoncolor"
											onClick="callCancel()"></td>
									  <td height="0"><input type="button" name="cmdDelete"
											value="Delete" style="width:50" class="buttoncolor"
											onClick="callDelete()" disabled></td>

										<td height="0"><input type="button" name="cmdHelp"
											value="Help"
											style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="callhelp()"></td>
										<td height="0">
										<div align="center"><input type="button" name="cmdClose"
											value="Close" onClick="doClose()"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
										</div>
										</td>
									</tr>
								</table>

								</td>
							</tr>
						</table>
						</div>
						<INPUT TYPE="hidden" name="hidAppType">
						<INPUT TYPE="hidden" name="hidApp_type" value='A'> <input
							type="hidden" name="hidBeanMethod" value=""> <input type="hidden"
							name="hidBeanId"> <input type="hidden" name="hidSourceUrl"> <input
							type="hidden" name="hidBeanGetMethod"> 
							<input type="hidden" name="hidappstatus"
							value="<%//=Helper.correctNull((String)hshValues.get("appstatus"))%>">
						<input type="hidden" name="hidOldAppId"
							value="<%//=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
						<input type="hidden" name="firmflag" value=""> <input
							type="hidden" name="firmflagStatus" value="0"> <input
							type="hidden" name="app_id"
							value="<%=session.getAttribute("sessionapp_id")%>"> <input
							type="hidden" name="trapEdit" value=""> <input type="hidden"
							name="hidDemoId"
							value="<%=session.getAttribute("sessionapp_id")%>">

</form>
</body>
</html>
