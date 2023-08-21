<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<html>
<head>
<title>Appraisal - Recommendations/Notes to the Sanctioning Authority</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
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
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callonLoad()
{
	disablefields(true);
}

function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, false, false, false, true);
	disablefields(false);
}

function doSave()
{
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/backgroundagr.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].action=appURL+"action/backgroundagr.jsp";
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
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="updateAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/backgroundagr.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";			
		document.forms[0].submit();	
		enableButtons(true, true, false, false, true);
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();

	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callonLoad()">

<form class="normal" name="appform" method="post" action="">

						<table align="center" class="outertable" width="95%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td valign="top"><b>Comments On the Application</b></td>
							</tr>
							<tr>
								<td valign="top">
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td valign="middle">Enter the Comments here</td>
                              <td align="center" valign="top"><textarea name="txt_comments"
											cols="100" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("Comments"))%></textarea></td>
                            </tr>
           	
                          
                          </table>
								</td>
							</tr>
						</table>
						<br>
						 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
						 <br>
<input type="hidden" name="radLoan" value="Y">
<input type="HIDDEN" name="sel_comments" value="BG">
<%-- 
<input type="HIDDEN" name="hid_pagename" value="BG">
<input type="hidden" name="comappid" value= "<%=session.getAttribute("comappid")%>">
<input type="hidden" name="bowid" value= "<%=session.getAttribute("comappid")%>">
<input type="hidden" name="appno1" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
--%>
<lapschoice:agrihiddentag />
</form>
</body>
</html>
