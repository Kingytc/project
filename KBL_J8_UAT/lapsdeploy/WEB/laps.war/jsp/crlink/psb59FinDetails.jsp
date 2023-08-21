<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","FINANCIAL_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - Financial & ITR Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>

</head>
<body onload="callOnLoad()">
<form name="docVerForm" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colSpan="5"> 
      <jsp:include page="PSB59ApplicationDetails.jsp"> </jsp:include>
    </td>
  </tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0"  class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>FINANCIAL & ITR DETAILS</b></font></td></tr>
	<tr></tr>
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
		    <td width="10%" nowrap="nowrap"  align="center"> Gross Monthly Income</td>
			<td width="10%" nowrap="nowrap"  align="center"> Net Monthly Income</td>
        	<td width="10%" nowrap="nowrap"  align="center"> Salary Income</td>
			<td width="10%" nowrap="nowrap"  align="center"> House Property</td>
			<td width="10%" nowrap="nowrap"  align="center"> PGBP</td>
			<td width="10%" nowrap="nowrap"  align="center"> Capital Gain</td>
			<td width="10%" nowrap="nowrap"  align="center"> Other Source</td>
			<td width="10%" nowrap="nowrap"  align="center"> Gross Income</td>
			<td width="10%" nowrap="nowrap"  align="center"> Taxable Income</td>
			<td width="10%" nowrap="nowrap"  align="center"> Is Manual Filled</td>
	  </tr>
	  <% if(arrRow != null && arrRow.size() > 0){
       for(int i = 0; i < arrRow.size(); i++){
			arrCol = (ArrayList) arrRow.get(i);
			if (arrCol != null && arrCol.size() > 0) {%>
		<tr height="30px">
		    <td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(7)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(10)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(5)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(9)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(8)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(3)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(11)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(6)) %></td>
		</tr>
		<%}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="10" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
	</table>
	</td>
	</tr>
</table>
</td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
            
        </td></tr></table>
</table>
<input type="hidden" name="hidUserId" value="">

</form>
</body>
</html>