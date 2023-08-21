<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Borrower Experience</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
	function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
function disableFields(one)
{
	document.forms[0].area_borrowerexp.readOnly=one;
	document.forms[0].txt_restriction.readOnly=one;
}	

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateADVBorrowerExp";
		document.forms[0].hidBeanGetMethod.value="getADVBorrowerExp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_borrowerexp.jsp";	
		document.forms[0].action=appURL+"action/controllerServlet";	
		document.forms[0].submit();		
	} 
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	document.forms[0].area_borrowerexp.focus();
	enableButtons(true, false, false, false, true);
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanMethod.value="updateADVBorrowerExp";
	document.forms[0].hidBeanGetMethod.value="getADVBorrowerExp";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidSourceUrl.value="/action/adv_borrowerexp.jsp";	
	document.forms[0].action=appURL+"action/controllerServlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_borrowerexp.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getADVBorrowerExp";
		document.forms[0].action=appURL+"action/controllerservlet";
		document.forms[0].submit(); 	
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
function onloading()
{
	disableFields(true);
}
</script>
</head>
<body onload="onloading()">
<form name="advdocument" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt;ADV1151 -&gt; Borrower Experience
		</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<TR class="dataheader">
<TD ALIGN="CENTER"><B>BORROWER EXPERIENCE</B>
</TD>
</TR>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
 
 					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
						<tr>
							<td valign="bottom">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
									<tr>
										<td  width="50%" align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" valign="bottom">
												<tr valign="bottom">
													<td valign="bottom">
														<table width="100%" border="0"  valign="bottom" class="outertable">
															<tr>											  
                              <td width="40%" align="center">Experience of borrowers dealings and operation</td>
															  <td width="60%"> 
																<textarea name="area_borrowerexp" cols="70" rows="5" tabindex="1" wrap="VIRTUAL" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("BorrowerExp"))%></textarea>
															  </td>
															</tr>
															<tr>															  
                              <td width="40%" align="center">Restrictions, conditions to be imposed on borrower</td>
															  <td width="60%"> 
																<textarea name="txt_restriction" cols="70" rows="5" tabindex="2" wrap="VIRTUAL" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("Borrowerrestriction"))%></textarea>
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
		<br/>
	  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 	
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%"><b>&nbsp; 
        <a href="javascript:callLink('adv_document.jsp','ADV1151','getADVDocument')"> 
        &lt;&lt; Previous </a>&nbsp;</b></td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.17/19  &nbsp;
        <a href="javascript:callLink('adv_termloancomments.jsp','ADV1151','gettermloancomments')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
