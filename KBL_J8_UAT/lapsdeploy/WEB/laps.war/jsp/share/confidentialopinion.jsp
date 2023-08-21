<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
%>
<html>
<head>
<title>Appraisal - Confidential Opinion</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strper_appid="<%=Helper.correctNull((String)hshValues.get("strper_appid"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";



function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
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
	document.forms[0].chk_apptype.disabled=false;
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callonLoad()
{
	disablefields(true);
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	enableButtons(true, true, true, true, false);	
	}
	else
	{
	enableButtons(false, true, true, true, false);	
	}
	if(strper_appid!="")
	{
		document.forms[0].chk_apptype.value=strper_appid;
	}
	else
	{
		document.forms[0].chk_apptype.value="";
	}
}

function callEdit()
{
	document.forms[0].hidAction.value="Edit"
	enableButtons(true, false, false,false, true);
	disablefields(false);
}

function doSave()
{
	if(document.forms[0].chk_apptype.value == "0")
	{
		alert("Select the Applicant Type");
		return;
	}
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	document.forms[0].cmdapply.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/confidentialopinion.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	enableButtons(true, true, false, false, true);
}

function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="getAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/confidentialopinion.jsp";
		document.forms[0].submit();
	}
}
function callDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	   document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/confidentialopinion.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}
function callClose()
{
	var con = ConfirmMsg('100');
	var id="<%=Helper.correctNull((String)hshValues.get("applicantid"))%>";
	var comappname="<%=Helper.correctNull((String)hshValues.get("appname"))%>";
	
	if(con)
	{
	 document.forms[0].action=appURL+"action/retailpge.jsp";
	  document.forms[0].submit();
	}
}

function getValues()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="getAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/confidentialopinion.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}



</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post" action="">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Confidential Opinion</i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF" align="center">
	<tr>
		<td colspan="2" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
          <tr align="center"> 
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callLoanDetails()"
					class="blackfont">Loan Details</a></font></b></td>
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callIncomeExpenses()"
					class="blackfont">Income &amp; Expenses</a></font></b></td>
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="javascript:callExperienceservices()"
					class="blackfont">Experience &amp; Services</a></font></b></td>
            <td width="13%" height="16" bgcolor="#71694F"><b><font size="1"
					face="MS Sans Serif" color="#FFFFFF">Confidential Opinion</font></b></td>
            <!--<td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="ms sans serif"><a href="javascript:callEMI()"
					class="blackfont">EMI Calculation</a></font></b></td>
				<td width="11%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="ms sans serif"><a href="javascript:callProfitStatement()" class="blackfont">Profitability Statement</a></font></b></td>
				<td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callShortFall()"
					class="blackfont">Short Fall </a></font></b></td>--    >
            <td width="11%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="JavaScript:callTermsandConditions()" class="blackfont">Terms 
              and Conditions</a></font></b></td>
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callRecommendations()"
					class="blackfont">Recommendations/Notes</a></font></b></td>
            <td width="15%" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="javascript:callOtherTab('checklist')" class="blackfont">Check 
              List</a></font></b></td>
            <td width="15%" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="javascript:callOtherTab('sanction')" class="blackfont">Pre 
              Sanction Report</a></font></b></td>
          </tr>
        </table>
		</td>
	</tr>
</table> -->

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="4" />
		</jsp:include></td>
	</tr>
</table>


<table width="100%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1" class=""
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2"
					align="center">
					<tr>
						<td>
						<table width="98%" border="0" cellspacing="0" cellpadding="2"
							align="center" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top"><b><font size="1" face="MS Sans Serif">Comments
										on Confidential opinion from Bankers</font></b></td>
									</tr>
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="2"
											bordercolor="#EEEEEE">
											<tr>
												<td valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td valign="top"><font size="1" face="MS Sans Serif">Applicant
												Type : </font>
												<select name="chk_apptype" style="width:150" onchange="getValues()">
                                                	<option value="" >--Select--</option>
                                                	<lapschoice:fincoappguarantor/>
                                              	</select>
												</td>
											</tr>
											<tr>
												<td valign="top" align="center"><textarea name="txt_comments"
													cols="100" rows="10" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("Comments"))%></textarea></td>
											</tr>
											<tr>
												<td valign="top" align="center">&nbsp;</td>
											</tr>
											<tr>
												<td valign="top" align="center">
												<table width="12%" border="0" align="center" cellpadding="0"
													cellspacing="0"  class="blackfont outertable border1">
													<tr>
														<td>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="2">
															<tr valign="top">
																<td width="0"><input type="button" name="cmdedit"
																	value="Edit"
																	style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="callEdit()"></td>
																<td width="0"><input type="button" name="cmdapply"
																	value="Save"
																	style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="doSave()"></td>
																<td width="0"><input type="button" name="cmdcancel"
																	value="Cancel"
																	style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="callCancel()"></td>
																<td width="0"><input type="button" name="cmddel"
																	value="Delete"
																	style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="callDelete()"></td>
																<td width="0"><input type="button" name="cmdhelp2"
																	value="Help"
																	style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="callhelp()" disabled></td>
																<td width="0"><input type="button" name="cmdclose"
																	value="Close"
																	style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
																	onClick="callClose()"></td>
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
<lapschoice:hiddentag/>
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="comappid" value= "<%=session.getAttribute("comappid")%>">
<input type="hidden" name="bowid" value= "<%=session.getAttribute("comappid")%>">
<INPUT type="hidden" name="appno1" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
</form>
</body>
</html>
