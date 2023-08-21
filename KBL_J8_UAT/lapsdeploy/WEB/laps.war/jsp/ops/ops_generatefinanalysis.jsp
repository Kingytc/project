<%@include file="../share/directives.jsp"%>
<%
			if (strBorrowerId.trim().equals("")) {
				strBorrowerId = Helper.correctNull((String) request.getParameter("comapp_id"));	
		}%>
<html>
<head>
<title>Security Master</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var status="<%=Helper.correctNull((String)hshValues.get("Status"))%>";
function onloading()
{
	if(status != "")
	{
		alert(status);
	}
}
function callAssess(page,flowtype)
{		
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDataFinancials";	
	document.forms[0].submit();	 
}
function generateexecutivesummary(pagetype)
{
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="updateFinData";
	document.forms[0].pageval.value=pagetype;
	document.forms[0].action=appURL+"action/ops_generatefinanalysis.jsp";
	document.forms[0].submit();
}
function doClose()
{	
 	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
	 	document.forms[0].submit();
	}
}			
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
			<jsp:param name="pageid" value="13" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; Generate Financials</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" colspan="2"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
          	<td class="sub_tab_active">
          		Generate Financial Analysis
          	</td>
            <td class="sub_tab_inactive"> 
              <b><a href="javascript:callAssess('adv_financials.jsp','FI')" >Financial Indicators</a></b>
            </td>
            <td class="sub_tab_inactive"> 
              <b><a href="javascript:callAssess('adv_financials.jsp','RA')" >Ratios</a></b>
            </td>
            <td class="sub_tab_inactive"> 
              <b><a href="javascript:callAssess('adv_financials.jsp','MPBF1')" >Working
				Capital</a></b>
            </td>
            <td class="sub_tab_inactive"> 
              <b><a href="javascript:callAssess('adv_fundflow.jsp','FU')" >Fund Flow</a></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>  
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable" align="center">
					<tr>
						<td height="289">
						<table width="30%" align="center" border="1" cellspacing="0" class="outertable" cellpadding="6">
							<tr>
								<td align="center" width="30%" height="25"><input type="button"
									name="cmd_charge" value="Financial Indicators"
									onClick="generateexecutivesummary('FI')"
									class="buttonOthers"></td>

							</tr>
							<tr>
								<td align="center" width="30%" height="25"><input type="button"
									name="cmd_charge" value="Ratios"
									onClick="generateexecutivesummary('RA')"
									class="buttonOthers"></td>

							</tr>
							<tr>
								<td align="center" width="30%" height="25"><input type="button"
									name="cmd_charge" value="Working Capital"
									onClick="generateexecutivesummary('MPBF1')"
									class="buttonOthers"></td>

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
<br>
<span style="visibility:hidden">
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<input type="hidden" name="pageval">
<input type="hidden" name="totvalue" value="<%//=totcount%>">
<input type="hidden" name="uptovalue" value="<%//=upto%>">
<input type="hidden" name="flowtype" value="TERCA">
<input type="hidden" name="yearfrom" value="1">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
