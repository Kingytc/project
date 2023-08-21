<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
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
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
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
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strpersanction="<%=Helper.correctNull((String)hshValues.get("Sanction_Flag"))%>";
var Sanction_ref="<%=Helper.correctNull((String)hshValues.get("Sanction_ref"))%>";
function callAGRIEMI()
{
	if(document.forms[0].cmdapply.disabled)
	{			
		document.forms[0].hidBeanId.value="appraisal";		
		document.forms[0].hidBeanGetMethod.value="getEMIAGRIData";
		document.forms[0].action=appURL+"action/agriEMICalculation.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callLoanDetails()
{
	if(document.forms[0].cmdapply.disabled)
	{	
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].action=appURL+"action/loandetailsagr.jsp";	
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
		document.forms[0].action=appURL+"action/apptermsandcondagr.jsp";	
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
		document.forms[0].action=appURL+"action/appraisalconfirmagr.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

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
	//document.forms[0].cmdclose.disabled=bool5;
}

function callonLoad()
{
	disablefields(true);
	enableButtons(false, true, true, false, false);	
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
	document.forms[0].hidAction.value="Edit";
	enableButtons(true, false, false, true, true);
	disablefields(false);
}
function callDelete()
{
if( ConfirmMsg(101))
	{

    document.forms[0].hidAction.value="Delete"
    document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/recommenauthorityagr.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	enableButtons(true, true, false, false, true);
	}
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
	document.forms[0].hidSourceUrl.value="/action/recommenauthorityagr.jsp";
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
		document.forms[0].hidSourceUrl.value="/action/recommenauthorityagr.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post" action="">
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					align="center" class="outertable border1">
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
                                          <td><input type="button" name="cmdedit"
															value="Edit"
															style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="callEdit()"></td>
                                          <td><input type="button" name="cmdapply"
															value="Save"
															style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="doSave()"></td>
                                          <td><input type="button" name="cmdcancel"
															value="Cancel"
															style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="callCancel()"></td>
                                          <td><input type="button" name="cmddel"
															value="Delete"
															style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="callDelete()"></td>
                                         
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
<lapschoice:agrihiddentag/>
<%-- 
<input type="HIDDEN" name="hid_pagename" value="RA">
--%>
</form>
</body>
</html>
