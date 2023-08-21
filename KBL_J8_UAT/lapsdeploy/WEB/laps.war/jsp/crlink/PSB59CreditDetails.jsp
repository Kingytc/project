<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%

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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
</head>
<body onload=callOnLoad()>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table>
</form>
<form name="appform" method="post" action="">
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="90%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>CREDIT DETAILS</b></font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td><b>Application Reference ID</b></td>
			<td></td>
			<td><b>Lender Name</b></td>
			<td></td>
			<td><b>Account Type</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Sanctioned Amount</b></td>
			<td></td>
			<td><b>Current Balance</b></td>
			<td></td>
			<td><b>Cash Limit</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Amount Overdue</b></td>
			<td></td>
			<td><b>ROI</b></td>
			<td></td>
			<td><b>Tenure</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>EMI Amount</b></td>
			<td></td>
			<td><b>Payment Frequency</b></td>
			<td></td>
			<td><b>Actual Payment Amount</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Date Closed</b></td>
			<td></td>
			<td><b>Date Of Last Payment</b></td>
			<td></td>
			<td><b>Date Reported And Certified</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Payment Start Date</b></td>
			<td></td>
			<td><b>Payment End Date</b></td>
			<td></td>
			<td><b>DPD Details Month Or Year Wise</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Amount</b></td>
			<td></td>
			<td><b>Loan Date</b></td>
			<td></td>
			<td><b>Loan Type</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Account No</b></td>
			<td></td>
			<td><b>Collateral Value</b></td>
			<td></td>
			<td><b>Collateral Type</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Co-Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr></tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Employment Info Requests</b></td>
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
			<td></td>
			<td><b>Occupation</b></td>
			<td></td>
			<td><b>Income</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Account Type</b></td>
			<td></td>
			<td><b>Frequency</b></td>
			<td></td>
			<td><b>Income Indicator</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Date Reported</b></td>
			<td></td>
			<td><b>Co-Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Contact Info Requests</b></td>
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
			<td></td>
			<td><b>LandMark</b></td>
			<td></td>
			<td><b>Street Name</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Premise Number</b></td>
			<td></td>
			<td><b>City</b></td>
			<td></td>
			<td><b>District</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Sub District</b></td>
			<td></td>
			<td><b>Town Village Taluka</b></td>
			<td></td>
			<td><b>Category</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>State</b></td>
			<td></td>
			<td><b>Country</b></td>
			<td></td>
			<td><b>Pincode</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Date Reported</b></td>
			<td></td>
			<td><b>Contact Number</b></td>
			<td></td>
			<td><b>Email Address</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Co-Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Enquiry Info Requests</b></td>
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
			<td></td>
			<td><b>Member Name</b></td>
			<td></td>
			<td><b>Date Of Enquiry</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Enquiry Purpose</b></td>
			<td></td>
			<td><b>Enquiry Amount</b></td>
			<td></td>
			<td><b>Credit Lender</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Credit Type</b></td>
			<td></td>
			<td><b>Co-Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Address Info Requests</b></td>
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
			<td></td>
			<td><b>LandMark</b></td>
			<td></td>
			<td><b>Street Name</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Premise Number</b></td>
			<td></td>
			<td><b>City</b></td>
			<td></td>
			<td><b>District</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Sub District</b></td>
			<td></td>
			<td><b>Town Village Taluka</b></td>
			<td></td>
			<td><b>Category</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>State</b></td>
			<td></td>
			<td><b>Country</b></td>
			<td></td>
			<td><b>Pincode</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Co-Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%"><b>Personal Info Requests</b></td>
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
			<td></td>
			<td><b>Full Name</b></td>
			<td></td>
			<td><b>DOB</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="10px">
			<td><b>Gender</b></td>
			<td></td>
			<td><b>PAN Number</b></td>
			<td></td>
			<td><b>Driving License No</b></td>
			<td></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td><b>Passport</b></td>
			<td></td>
			<td><b>Co Applicant Id</b></td>
			<td></td>
			<td><b>Co-Applicant Type</b></td>
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

