<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","BANK_DETAILS");
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
<form name="docVerForm" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="../crlink/PSB59ApplicationDetails.jsp" flush="true" /> 
    </td>
  </tr>
</table>
</form>
<form name="appform" method="post" action="">
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>BANK DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td><b>ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_ROW_ID"))%></td>
			<td><b>Application Reference ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_APPLICATIONREFERENCEID"))%></td>
			<td><b>Have Bank Account</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_HAVEBANKACCOUNT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Bank Details Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_BANKDETAILSTYPE"))%></td>
			<td><b>Account Holder Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_ACCOUNTHOLDERNAME"))%></td>
			<td><b>Account Since</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_ACCOUNTSINCE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Bank Account Number</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_BANKACCOUNTNUMBER"))%></td>
			<td><b>Confirm Bank Account Number</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_CONFIRMBANKACCOUNTNUMBER"))%></td>
			<td><b>IFSC Code</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_IFSCCODE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BDL_TYPE"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Bank Statement List</b></td>
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
			<td><%=Helper.correctNull((String) hshValues.get("BSL_APPLICATIONREFERENCEID"))%></td>
			<td><b>Year</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BSL_YEAR"))%></td>
			<td><b>Month</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BSL_MONTH"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Bank</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BSL_BANK"))%></td>
			<td><b>Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BSL_TYPE"))%></td>
			<td><b>Co-App ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("BSL_COAPPLICANTID"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Customer Information</b></td>
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
			<td><b>ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_ID"))%></td>
			<td><b>Application Reference ID</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_APPLICATIONID"))%></td>
			<td><b>Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Address</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_ADDRESS"))%></td>
			<td><b>Landline</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_LANDIINE"))%></td>
			<td><b>Mobile</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_MOBILE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Email</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_EMAIL"))%></td>
			<td><b>PAN</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_PAN"))%></td>
			<td><b>Bank</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_BANK"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>InstId</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_INSTID"))%></td>
			<td><b>Check Bounce For Last Six Month</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_CHKBOUNCEFRLASTSIXMON"))%></td>
			<td><b>CheckBounce For Last One Month</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_CHKBOUNCEFRLASTONEMON"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Credit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("CI_TOTCREDIT"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Month Wise Details</b></td>
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
			<td><b>Application Reference Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total No Of Credit Transactions</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total Amount Of Credit Transactions</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total No Of Debit Transactions</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total No Of Cash Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total Amount Of Cash Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total No Of Cash Withdrawals</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total Amount Of Cash Withdrawals</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total No Of Cheque Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Amount Of Cheque Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total No Of Cheque Issues</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total Amount Of Cheque Issues</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total No Of Inward Cheque Bounces</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Total No Of Outward Cheque Bounces</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Min Eod Balance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Max Eod Balance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Average Eod Balance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Average Bank Balance</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Month Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Start Date</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Summary Info</b></td>
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
			<td><b>Application Reference Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_APPLICATIONREFERENCEID"))%></td>
			<td><b>Inst Name</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_INSTNAME"))%></td>
			<td><b>Acc No</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_ACCNO"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Acc Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_ACCTYPE"))%></td>
			<td><b>Full Month Count</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_FULLMONTHCOUNT"))%></td>
			<td><b>Bal Max</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_BALMAX"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Bal Min</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_BALMIN"))%></td>
			<td><b>Cash Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_CASHDEPOSITE"))%></td>
			<td><b>Cash Withdrawals</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_CASHWITHDRAW"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Chq Deposits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_CHQDEPOSITS"))%></td>
			<td><b>Chq Issues</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_CHQISSUE"))%></td>
			<td><b>Credits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_CHEDITS"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Debits</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_DEBITS"))%></td>
			<td><b>Inward Bounces</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_INWBOUNCES"))%></td>
			<td><b>Outward Bounces</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_OUTWBOUNCES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Cash Deposit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTCASHDEP"))%></td>
			<td><b>Total Cash Withdrawal</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTCASHWITHDRAW"))%></td>
			<td><b>Total Chq Deposit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTCHQDEP"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Total Chq Issue</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTCHQISSUE"))%></td>
			<td><b>Total Credit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTCREDIT"))%></td>
			<td><b>Total Debit</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_TOTDEBIT"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Summary Type</b></td>
			<td><%=Helper.correctNull((String) hshValues.get("SI_SUMMARYTYPE"))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Top Five Fund Received List</b></td>
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
			<td><b>Application Reference Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Month</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Description</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Top Five Fund Transfered List</b></td>
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
			<td><b>Application Reference Id</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Month</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td><b>Description</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Amount</b></td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
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

