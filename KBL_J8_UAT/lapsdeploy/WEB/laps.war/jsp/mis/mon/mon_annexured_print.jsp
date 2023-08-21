<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%

String Org_Name = (String)request.getParameter("Org_Name");
%>
<script>

var AppUrl="<%=ApplicationParams.getAppUrl()%>";
function doNext()
{
	document.forms[0].action=AppUrl+"action/mon_annexurec_print.jsp";
	document.forms[0].hidMethod.value="getMonitoringReport";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value=AppUrl+"action/mon_annexurec_print.jsp";
	document.body.style.display="none";
	document.forms[0].submit();
		
	//window.open(AppUrl+"action/mon_annexurec_print.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMonitoringReport&sellevel="+sellevel+"&accountclasssel="+accountclasssel+"&rpselect1="+rpselect1+"&parameterselect="+parameterselect+"&txtlimitfrom="+txtlimitfrom+"&txtlimitto="+txtlimitto+"&txtoutstandingfrom="+txtoutstandingfrom+"&txtoutstandingto="+txtoutstandingto+"&txtexcessfrom="+txtexcessfrom+"&txtexcessto="+txtexcessto+"&limit="+limit+"&offset="+offset+"&tempTableCheck="+tempTableCheck,"","scrollbars=Yes,toolbars=No,menubar=no ,width=900 , height=800,top=10,left=10");
}

function doPrintPreview()
{
	document.forms[0].hidBeanId.value="perrepappstatus";
	var tempRowcount = "<%=(String)request.getParameter("tempRowcount")%>"
	window.open(AppUrl+"action/mon_annexurec_print_outpage.jsp?tempRowcount="+tempRowcount,"","scrollbars=Yes,toolbars=No,menubar=yes ,width=900, height=750,top=10,left=10");
	
}
function doClose()
{
	window.close();
}
</script>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body  >

<form name= "orgfrm" method="post" class="normal">
<div class="cellContainer">
  <table class="outertable"  width="100%" border="0">
  <tr>
          
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="30" height="20"></td>          		
        </tr>
   <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
  <tr> 
          <td align="center"><b> <%=Helper.correctNull((String)hshValues.get("org_name"))%></b></td>
        </tr> 
  <!--tr>
     <td><center><%//=Helper.correctNull((String)hshValues.get("selLevel"))%>  ANNEXURE-D as of <%//=Helper.getCurrentDateTime()%></center></td>
  </tr-->
  <%if(Helper.correctNull((String)hshValues.get("accstatus")).equalsIgnoreCase("NONRS")){%>
  <tr>
     <td align="center">CONSOLIDATED STRESSED ACCOUNTS ASSETS ABOVE Rs. <%=Helper.correctNull((String)hshValues.get("LimitFrom"))%> AND UPTO Rs. <%=Helper.correctNull((String)hshValues.get("LimitTo"))%></td>
  </tr>
  <%}
  else
  { %>
  <tr>
     <td align="center">CONSOLIDATED STRESSED ACCOUNTS (Restructured) ASSETS ABOVE Rs. <%=Helper.correctNull((String)hshValues.get("LimitFrom"))%> AND UPTO Rs. <%=Helper.correctNull((String)hshValues.get("LimitTo"))%></td>
  </tr>
  <%} %>
  <tr>
  <td align="RIGHT">&nbsp;(All Values are in Lacs)</td>
  </tr>
</table>
    <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr> 
        <td height="3"> 
          <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="3"  >
           
            <tr class="dataheader"> 
              <td rowspan="2" width="14%">Nature of Default</td>
              <td colspan="2" align="center">EAS - I</td>
              <td colspan="2" align="center">EAS - II</td>
              <td colspan="2" align="center">SMA</td>
              <!--td Colspan="2">TOTAL</td-->
         	</tr>
			<tr class="dataheader">
			  <td width="11%" align="center">No. of A/cs.</td>
              <td width="14%" align="center">Total O/s.</td>
              <td width="15%" align="center">No. of A/cs.</td>
              <td width="16%" align="center">Total O/s.</td>
              <td width="13%" align="center">No. of A/cs.</td>
              <td width="17%" align="center">Total O/s.</td>
              <!--td width="10%">No. of A/cs.</td-->
              <!--td width="11%">Total O/s.</td-->
          	</tr>
			
			
			<tr class="datagrid">
			  <td width="14%">Loan</td>
              <td width="11%">&nbsp; <%=Helper.correctNull((String)hshValues.get("E1LDCOUNT"))%></td>
              <td width="14%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E1LDOSAMT")))))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)hshValues.get("E2LDCOUNT"))%></td>
              <td width="16%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E2LDOSAMT")))))%></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("SMALDCOUNT"))%></td>
              <td width="17%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SMALDOSAMT")))))%></td>
              <!--td width="10%">&nbsp;</td-->
			   
              <!--td width="11%">&nbsp;</td-->			
           </tr>
		   <tr class="datagrid">
			  <td width="14%">Renewal</td>
              <td width="11%">&nbsp; <%=Helper.correctNull((String)hshValues.get("E1NRCOUNT"))%></td>
              <td width="14%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E1NROSAMT")))))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)hshValues.get("E2NRCOUNT"))%></td>
              <td width="16%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E2NROSAMT")))))%></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("SMANRCOUNT"))%></td>
              <td width="17%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SMANROSAMT")))))%></td>
              <!--td width="10%">&nbsp;</td>
			   
              <td width="11%">&nbsp;</td-->
			</tr>
		   <tr class="datagrid">
			  <td width="14%">Doc / EM / Vetting</td>
              <td width="11%">&nbsp; <%=Helper.correctNull((String)hshValues.get("E1DDCOUNT"))%></td>
              <td width="14%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E1DDOSAMT")))))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)hshValues.get("E2DDCOUNT"))%></td>
              <td width="16%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E2DDOSAMT")))))%></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("SMADDCOUNT"))%></td>
              <td width="17%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SMADDOSAMT")))))%></td>
              <!--td width="10%">&nbsp;</td>
			   
              <td width="11%">&nbsp;</td-->			
           </tr>
		   <tr class="datagrid">
			  <td width="14%">Inspection</td>
              <td width="11%">&nbsp; <%=Helper.correctNull((String)hshValues.get("E1NICOUNT"))%></td>
              <td width="14%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E1NIOSAMT")))))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)hshValues.get("E2NICOUNT"))%></td>
              <td width="16%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E2NIOSAMT")))))%></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("SMANICOUNT"))%></td>
              <td width="17%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SMANIOSAMT")))))%></td>
              <!--td width="10%">&nbsp;</td>
			   
              <td width="11%">&nbsp;</td-->			
           </tr>
		   <tr class="datagrid">
			  <td width="14%">Others</td>
              <td width="11%">&nbsp; <%=Helper.correctNull((String)hshValues.get("E1ODCOUNT"))%></td>
              <td width="14%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E1ODOSAMT")))))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)hshValues.get("E2ODCOUNT"))%></td>
              <td width="16%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("E2ODOSAMT")))))%></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("SMAODCOUNT"))%></td>
              <td width="17%" align="right">&nbsp;<%=Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SMAODOSAMT")))))%></td>
              <!--td width="10%">&nbsp;</td>
			   
              <td width="11%">&nbsp;</td-->			
           </tr>
		   <!--tr bordercolor="#DEDACF">
			  <td width="9%">Total</td>
              <td width="10%">&nbsp;</td>
              <td width="11%">&nbsp;</td>
              <td width="12%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
              <td width="10%">&nbsp;</td>
              <td width="14%">&nbsp;</td>
              <td width="10%">&nbsp;</td>
              <td width="11%">&nbsp;</td>			
           </tr-->
			
		  </table>
        </td>
      </tr>
    </table>
	</div>
  
	<lapschoice:combuttonnew 
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    <lapschoice:hiddentag pageid='<%=PageId%>'/>
 
 
  
 <input type="hidden" name="sellevel" value="<%=(String)request.getParameter("sellevel")%>">
 <input type="hidden" name="txtlimitfrom" value="<%=(String)request.getParameter("txtlimitfrom")%>">
 <input type="hidden" name="txtlimitto" value="<%=(String)request.getParameter("txtlimitto")%>">

</form>
</body>
</html>