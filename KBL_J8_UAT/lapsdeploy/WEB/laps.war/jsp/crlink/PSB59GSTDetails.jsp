<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","GST_DETAILS");
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
	<font size="2">GST DETAILS</font></td></tr>
	<tr class="datagrid">
		<td>
		<div id="top2">
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<col width="6%">
		<col width="10%">
		<tr height="30px">
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_APP_REF_ID"))%></td>
			<td>GstIn</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_GST_IN"))%></td>
			<td>Gst Type</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_GST_TYPE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Gst Sub Type</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_GST_SUB_TYPE"))%></td>
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
			<td width="20%">Gst Credit Debit Note Info List</td>
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
			<td>Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_ID"))%></td>
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_APP_REF_ID"))%></td>
			<td>Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_MONTHS"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>CreditNote</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_CREDIT_NOTE"))%></td>
			<td>Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_SALES"))%></td>
			<td>Debit Note</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_DEBIT_NOTE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Purchase</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_PURCHASE"))%></td>
			<td>Total</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGCDI_TOTAL"))%></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Gst Inward Supply Description List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_APP_REF_ID"))%></td>
			<td>Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_MONTHS"))%></td>
			<td>Get GST</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_GET_GST"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Get NON GST</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_GET_NONGST"))%></td>
			<td>Total</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_TOTAL"))%></td>
			<td>Inter State Supplier Gst</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_INTER_ST_SPPLIER_GST"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Intra State Supplier Gst</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_INTRA_ST_SPPLIER_GST"))%></td>
			<td>Inter State Supplier Non Gst</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_INTER_ST_SPPLIER_NONGST"))%></td>
			<td>Intra State Supplier Non Gst</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGISD_INTRA_ST_SPPLIER_NONGST"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Gst Key Observation List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_APP_REF_ID"))%></td>
			<td>Out Of Total Sales Highe Stsales In Terms</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_OUTOF_TOTAL_SALES"))%></td>
			<td>Margin Sales Minus Purchase Of The Total Sales Amount In Terms</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_MARGIN_SALES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Customer Concentration Top</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_CUST_CONCENTRATION"))%></td>
			<td>Supplier Concentration Top</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_SUPPLIER_CONCENTRATION"))%></td>
			<td>Out Of Total Inward Supplies Inter GST State Supply Is Highest In Terms</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_OUTOF_TOTAL_INWARD"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Average Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_AVERAGE_SALES"))%></td>
			<td>Median Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_MEDIAM_SALES"))%></td>
			<td>Average Purchase</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_AVERAGE_PURCHASE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Median Purchase</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_MEDIAM_PURCHASE"))%></td>
			<td>Highest Sales Are In The Month Of</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_HIGHEST_SALES"))%></td>
			<td>Highest Purchase Are In The Month Of</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_HIGHEST_PURCHASE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total CreditNote Vs Total Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_TOTAL_CREDIT"))%></td>
			<td>Total DebitNote Vs Total Purchase</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_TOTAL_DEBIT"))%></td>
			<td>Organisation Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGKO_ORGANISATION_NAME"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Gst MonthWise Purchase List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWP_APP_REF_ID"))%></td>
			<td>Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWP_MONTHS"))%></td>
			<td>PB</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWP_B2B"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWP_TOTAL"))%></td>
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
			<td width="20%">Gst MonthWise Sale List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_APP_REF_ID"))%></td>
			<td>Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_MONTHS"))%></td>
			<td>PB</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_B2B"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>BCL</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_B2CL"))%></td>
			<td>BCS</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_B2CS"))%></td>
			<td>Exports</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_EXPORTS"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Nil Rated Goods</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_NILRATED_GOODS"))%></td>
			<td>Exempted Goods</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_EXEMPTED_GOODS"))%></td>
			<td>Non GST Outward Supplies</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_NONGST_OUTWARD_SUPPLIES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_TOTAL"))%></td>
			<td>Inter Company Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGMWS_INTER_COMPANY_SALES"))%></td>
			<td></td>
			<td></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Gst Overview List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_APP_REF_ID"))%></td>
			<td>Months</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_TOTAL_MONTHS"))%></td>
			<td>Total No Of Customers</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_TOTAL_CUSTOMERS"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total No Of Suppliers</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_TOTAL_SUPLIERS"))%></td>
			<td>Total Sales Invoice Value</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_TOTAL_SALES_INVOICE"))%></td>
			<td>BB</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_B2B"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>BCL</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_B2CL"))%></td>
			<td>BCS</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_B2CS"))%></td>
			<td>Exports</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_EXPORTS"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Nil Rated Good</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_NILRATED_GOODS"))%></td>
			<td>Exempted Goods</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_EXEMPTED_GOODS"))%></td>
			<td>Non GST Outward Supplies</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_NONGST_OUT_SUPPLIES"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total Purchases</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_TOTAL_PURCHASER"))%></td>
			<td>Difference Sales Minus Purchase</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_DIFF_SALES_MIN_PUR"))%></td>
			<td>Margin In Percentage</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGO_MARGIN_INPERCENTAGE"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">Gst Top Five Customer List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_APP_REF_ID"))%></td>
			<td>Get GST IN</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_GST_IN"))%></td>
			<td>State Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_STATE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total Invoice</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_TOTAL_INVOICE"))%></td>
			<td>Invoice Value</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_INVOICE_VALUE"))%></td>
			<td>Taxable Value</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_TAXABLE_VALUE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Percentage Of Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFC_PERCENTAGE_SALES"))%></td>
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
			<td width="20%">Gst Top Five Supplier List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_APP_REF_ID"))%></td>
			<td>Get GST IN</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_GST_IN"))%></td>
			<td>State Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_STATE_NAME"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Total Invoice</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_INVOICE_VALUE"))%></td>
			<td>Taxable Value</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_TAXABLE_VALUE"))%></td>
			<td>Percentage Of Sales</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGTFS_PERCENTAGE_PURCHASE"))%></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td width="20%">No Gst (Or) Composite Gsts List</td>
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
			<td>Application Reference Id</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_APP_REF_ID"))%></td>
			<td>Month</td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td>Sales Amount</td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Is Manual Entry False</td>
			<td><%=Helper.correctNull((String) hshValues.get(""))%></td>
			<td>Registration Date</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_REG_DATE"))%></td>
			<td>Entity Name</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_ENTITY_NAME"))%></td>
		</tr>
		<tr height="30px">
			<td>Pan</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_PAN"))%></td>
			<td>City</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_CITY"))%></td>
			<td>State</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_STATE"))%></td>
		</tr>
		<tr></tr>
		<tr height="30px">
			<td>Constitution</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_CONTITUTION"))%></td>
			<td>Highest Sales To One Customer</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_HIGHEST_SALES_CUST"))%></td>
			<td>Number Of Customer</td>
			<td><%=Helper.correctNull((String) hshValues.get("NGD_NUM_CUST"))%></td>
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

