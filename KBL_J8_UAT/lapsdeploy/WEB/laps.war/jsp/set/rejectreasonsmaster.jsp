<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}
ArrayList g1 = new ArrayList();%>
<html>
<head>
<title>Reject Reasons</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, true, false);	
}

function menuOptionDivMouseDown (url) 
{		
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}
		
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!one);		  
		}		
	}
}

function doSave()
{	
	if(trim(document.forms[0].txttrmcontent.value)=="")
	{		
		ShowAlert('121','Reasons For Rejection');
		document.forms[0].txttrmcontent.focus();
		return false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateRejectReasonMasterData";
	document.forms[0].hidBeanGetMethod.value="getRejectReasonMasterList";
	document.forms[0].hidSourceUrl.value="/action/rejectreasonsmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getRejectReasonMasterList";
		document.forms[0].hidSourceUrl.value="/action/rejectreasonsmaster.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons(true, true, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.forms[0].hidAction.value="Edit"
	enableButtons(true, true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function selectValues(val1,val2)
{
	document.forms[0].hidsno.value=val1;             
    document.forms[0].txttrmcontent.value=val2;
    enableButtons(true, false, true, false, false);
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Rejection Reasons </td></tr>
</table>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
	 <tr> 
      <td valign="top"> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
          <tr>
				<td valign="top">
				<table class="outertable" border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td width="69%" valign="top">
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td>
										<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
											<tr>
												<td width="8%" nowrap>Rejection Reasons</td>
												<td colspan="2" valign="middle">
												<table class="outertable" border="0" cellspacing="0" cellpadding="5" align="center">
													<tr>
													<td><textarea name="txttrmcontent" wrap="VIRTUAL" cols="85" rows="5" readOnly="readonly"
															onkeyPress="notAllowSplChar()"></textarea>
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
							</table><br>
							<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" >
                                  <tr> 
                                    <td valign="top"> 
                                      <table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" >
                                        <tr class="dataheader"> 
                                          <td width="5%" >&nbsp;</td>
                                          <td width="95%"><b>Rejection Reasons</b></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top" align="center"> 
                                        <table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="2" >
                                      <% 
						 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
										String inside="N";
										if(v!=null)
										{					
											int vecsize =v.size();
											for(int l=0;l<vecsize;l++)
											{	
												inside="Y";
												g1 = (ArrayList)v.get(l);
												%>
                                          <tr class="datagrid"> 
                                            <td width="5%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(1)))%>')">
                                            </td>
                                            <td width="95%"><%=Helper.correctNull((String)g1.get(1))%></td>
                                          </tr>
                                          <%
					                       }
										}
										 %>
                                          <tr class="datagrid">
                                            <td width="5%">&nbsp; </td>
                                            <td width="95%">&nbsp; </td>
                                          </tr>
                                          <%if(inside.equalsIgnoreCase("N")) {%>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr class="datagrid"> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <%} %>
                                        </table>
                                    </td>
                                  </tr>
                                </table>
        <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="strOrgCode" value="<%=session.getAttribute("strOrgCode")%>"> 
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("REJ_CODE"))%>">
<input type="hidden" name="hidkeyid" value="set">
</form>
</body>
</html>
