<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","SCASCO_DETAILS");
ArrayList arrData = new ArrayList();
ArrayList arrRow = new ArrayList();
int vecsize = 0;
if (hshValues != null) {
	arrData = (ArrayList) hshValues.get("arrRow");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{
}
</script>
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<%-- <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> --%>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

</head>
<body onload=callOnLoad()>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
       <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table>
</form>
<form name="docVerForm" method="post" action="" class="normal">
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>SCORING & SCALING DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Scoring Details</b></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<tr height="30px">
			<td align="center"><b>Parameter</b></td>
			<td align="center"><b>Actual Range</b></td>
			<td align="center"><b>Actual Value from Borrower</b></td>
			<td align="center"><b>Score Actual</b></td>
			<td align="center"><b>Score Out Of</b></td>
			<td align="center"><b>Type</b></td>
			</tr>
							
		
		<%
										if (arrData != null) {
									
										vecsize = arrData.size();
										}for (int i = 0; i < vecsize; i++) {
											arrRow = (ArrayList) arrData.get(i);
											
											if (arrRow != null) {
									%>
									<tr  height="30px">
										<td align="center"><%=Helper.correctNull((String) arrRow.get(1))%></td>
										<td align="center"><%=Helper.correctNull((String) arrRow.get(2))%></td>
										<td align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(3))%></td>
										<td align="center">&nbsp; <%=Helper.correctNull((String) arrRow.get(4))%></td>
										<td align="center">&nbsp;<%=Helper.correctNull((String) arrRow.get(5))%></td>
										<td align="center">&nbsp; <%=Helper.correctNull((String) arrRow.get(6))%></td>
										</tr>
									<%
										}
										}
									%>
		
		
		
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Scaling Details</b></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td><b>Application Reference ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_APP_REF_ID"))%></td>
			<td><b>Effective ROI Calc Method</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_EFFECTIVE_ROI_CALC"))%></td>
			<td><b>Scoring Model</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_SCORING_MODEL"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>PF Based On</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_PF_BASEON"))%></td>
			<td><b>Tenure Based On</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_TENORE_BASEON"))%></td>
			<td><b>Margin Based On</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_MARGIN_BASEON"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>ROI Based On</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_ROI_BASEON"))%></td>
			<td><b>Interpretation</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_INTERPRETATION"))%></td>
			<td><b>Scale</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_SCALE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Score Range</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_SCORE_RANGE"))%></td>
			<td><b>Min Pf</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_MIN_PF"))%></td>
			<td><b>Max Pf</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_MAX_PF"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Processing Fees</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_PROCESSING_FEES"))%></td>
			<td><b>Margin</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_MARGIN"))%></td>
			<td><b>Spread</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_SPREAD"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Effective ROI</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_EFFECTIVE_ROI"))%></td>
			<td><b>Tenure</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_TENORE"))%></td>
			<td><b>Co-Applicant Min Score</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_CO_APP_MIN_SCORE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Applicant Min Score</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("NSM_APP_MIN_SCORE"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr></tr>
		</table>
		</td></tr>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
      <!--  <td>  
            <input type="button" name="cmdsave" value="Save" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callsave()"> 
        </td>--> 
       <td>  
            <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callclose()"> 
        </td>
      </tr>
</table>

<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod">
 <input type="hidden"name="hidBeanId"> 
 <input type="hidden" name="hidSourceUrl"> 
 <input type="hidden" name="hidBeanGetMethod">
</form>
</body>
</html>

