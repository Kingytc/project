<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
%>
<html>
<head>
<title>Appraisal - Recommendations/Notes to the Sanctioning Authority</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}
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
var strpersanction="<%=Helper.correctNull((String)hshValues.get("Sanction_Flag"))%>";
var Sanction_ref="<%=Helper.correctNull((String)hshValues.get("Sanction_ref"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
/*function callLoanDetails()
{
	if(document.forms[0].cmdapply.disabled)
	{	
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].action=appURL+"action/loandetails.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callProfitStatement()
{
	if(document.forms[0].cmdapply.disabled)
	{		
		document.forms[0].hidBeanId.value="mastapplicant";		
		document.forms[0].hidBeanGetMethod.value="getFinProfitData";
		document.forms[0].action=appURL+"action/per_fin_profit_stat.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');

	}
}

function callTermsandConditions()
{
	if(document.forms[0].cmdapply.disabled)
	{			
		document.forms[0].hidBeanId.value="apptermscond";		
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"action/apptermsandcond.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callAppraisalConfirm()
{
	if(document.forms[0].cmdapply.disabled)
	{			
		document.forms[0].hidBeanId.value="appraisal";		
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action=appURL+"action/appraisalconfirm.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
*/
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
	if(strpersanction!="")
	{
		document.forms[0].chk_sanction.value=strpersanction;
	}
	else
	{
		document.forms[0].chk_sanction.value="1";
	}
	if(Sanction_ref!="")
	{
		document.forms[0].chk_recombranch.value=Sanction_ref;
	}
	else
	{
		document.forms[0].chk_recombranch.value="1";
	}
}

function callEdit()
{
	document.forms[0].hidAction.value="Edit"
	enableButtons(true, false, false, true, true);
	disablefields(false);
}

function doSave()
{
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/recommenauthority.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/recommenauthority.jsp";
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
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
<jsp:include page="../share/help.jsp" flush="true"/>
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
		<td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Recommendations/Notes for Sanction</i></b></font></td>
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
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="javascript:callConfidentialOpinion()"
					class="blackfont">Confidential Opinion</a></font></b></td>
            <!--<td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callEMI()"
					class="blackfont">EMI Calculation</a></font></b></td>
				<td width="11%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="ms sans serif"><a href="javascript:callProfitStatement()" class="blackfont">Profitability Statement</a></font></b></td>
				<td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callShortFall()"
					class="blackfont">Short Fall</a></font></b></td>-   ->
            <td width="11%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="JavaScript:callTermsandConditions()" class="blackfont">Terms 
              and Conditions</a></font></b></td>
            <td width="13%" height="16" bgcolor="#71694F"><b><font size="1"
					face="MS Sans Serif" color="#FFFFFF">Recommendations/Notes</font></b></td>
            <td width="15%" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="javascript:callOtherTab('checklist')" class="blackfont">Check 
              List </a></font></b></td>
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
			<jsp:param name="tabid" value="6" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1"
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
						<td><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top"><b><font size="1" face="MS Sans Serif">Recommendations
								/ Notes to the Sanctioning Authority</font></b></td>
							</tr>
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="2"
									bordercolor="#EEEEEE">
                            <tr> 
                              <td width="100%" valign="top">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td valign="top"><table width="70%" border="0" cellspacing="0" cellpadding="3">
                                  <tr> 
                                    <td width="45%">Recomending for Sanction </td>
                                    <td width="25%"><select name="chk_sanction" style="width:80">
                                        <option value="1" >Yes</option>
                                        <option value="2" >No</option>
                                      </select></td>
                                  </tr>
                                  <tr> 
                                    <td>Recommended by the Branch Manager </td>
                                    <td><select name="chk_recombranch" style="width:80">
                                        <option value="1" >Yes</option>
                                        <option value="2" >No</option>
                                      </select></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                            </tr>
                            <tr> 
                              <td align="center" valign="top"><textarea name="txt_comments"
											cols="100" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("Comments"))%></textarea></td>
                            </tr>
                            <tr> 
                              <td align="center" valign="top"><br> <table width="12%" border="0" align="center" cellpadding="0"
											cellspacing="0" class="blackfont outertable border1">
                                  <tr> 
                                    <td> <table width="100%" border="0" cellspacing="0"
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
                                      </table></td>
                                  </tr>
                                </table></td>
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
</form>
</body>
</html>
