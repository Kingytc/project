<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.ArrayList"%>
<laps:handleerror />
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();

if(hshValues!=null)
	arrRow=(ArrayList)hshValues.get("arrRow");
String strPrint = Helper.correctNull((String)hshValues.get("strPrint"));
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<style>
.font_style{
font-family: Trebuchet MS;
	font-size:11px;
	height:25px
	}
</style>
<script language="javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function printpreview()
{
	var varorglevel="<%=Helper.correctNull((String)hshValues.get("strOrglevel"))%>";
	var varorgcode="<%=Helper.correctNull((String)hshValues.get("strOrgcode"))%>";
	var varfrmamt="<%=Helper.correctNull((String)hshValues.get("strAmtfrom"))%>";
	var vartoamt="<%=Helper.correctNull((String)hshValues.get("strToamt"))%>";
	var varperiod="<%=Helper.correctNull((String)hshValues.get("strPeriod"))%>";
	var varschemes="<%=Helper.correctNull((String)hshValues.get("strSchemes"))%>";
	var varcompromisetype="<%=Helper.correctNull((String)hshValues.get("strCompromisetype"))%>";
	var varPrint = "Y";
	window.open(appUrl+"action/npaotscorptresult.jsp?hidBeanId=npaapprep&hidBeanGetMethod=getData&hidMethod=getCompromiseSettlement&hidOrgLevel="+varorglevel+"&hidOrgcode="+varorgcode+"&hidSchemes="+varschemes+"&hidotstype="+varcompromisetype+"&txtfromamt="+varfrmamt+"&txttoamt="+vartoamt+"&hidPeriod="+varperiod+"&hidPrint="+varPrint,"DecreedcasesPrint","scrollbars=Yes,toolbars=No,menubar=no ,width=800 , height=600,top=10,left=10");
}
</script>
</head>

<body >
<%if(strPrint.equalsIgnoreCase("Y")){ %>
<form  name= "orgfrm" method="post">
 <table  width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr class="font_style">
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr class="font_style"> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
        <tr class="font_style"> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("orgname"))%></td>
        </tr> 
        <tr class="font_style"> 
          <td align="center"><b>NPA Application <%=Helper.correctNull((String)hshValues.get("status"))%> Status Report</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table  width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
           
            <tr class="font_style"> 
              <td><b>Sno</b></td>
              <td><b>Account Number</b></td>
              <td><b>Name of Account</b></td>
              <td><b>Running Ledger Amount</b></td>
              <td><b>Total Dues</b></td>
              <td><b>DICGC Amount</b></td>
			  <td><b>Legal Expenses</b></td>
			  <td><b>Amount payable As per module</b></td>
			 <td><b>Settlement Amount offered</b> </td>
			  <td><b>Amount Write off</b></td>
			   <td><b>Interest waived</b></td>
			 <td><b>Name of the D A </b></td>
			</tr>
			<%
				if(arrRow!=null && arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
					arrCol=(ArrayList)arrRow.get(i);
			%>
			<tr class="font_style">
				<td><%=(i+1)%>.</td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></td>
				<td>&nbsp;</td>
			</tr>
			<%
					}
				}else{
			%>
			
			<tr class="font_style">
				<td colspan="12" align="center">No Record Found</td>
			</tr>
			
			<%} %>
         </table>
        
</div>
</form>
<%}else{ %>
<form class="normal" name= "orgfrm" method="post">
 <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
        <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("orgname"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b>NPA Application <%=Helper.correctNull((String)hshValues.get("status"))%> Status Report</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table class="outertable" width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
           
            <tr class="dataHeader"> 
              <td>Sno</td>
              <td>Account Number</td>
              <td>Name of Account</td>
              <td>Running Ledger Amount</td>
              <td>Total Dues</td>
              <td>DICGC Amount</td>
			  <td>Legal Expenses</td>
			  <td>Amount payable As per module</td>
			 <td>Settlement Amount offered </td>
			  <td>Amount Write off</td>
			   <td>Interest waived</td>
			 <td>Name of the D A </td>
			</tr>
			<%
				if(arrRow!=null && arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
					arrCol=(ArrayList)arrRow.get(i);
			%>
			<tr class="dataGrid">
				<td><%=(i+1)%>.</td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></td>
				<td>&nbsp;</td>
			</tr>
			<%
					}
				}else{
			%>
			
			<tr>
				<td colspan="12" align="center">No Record Found</td>
			</tr>
			
			<%} %>
         </table>
        
</div>
<br>
  <table class="outertable" border="0" cellspacing="0" cellpadding="0"   align="center">
    <tr> 
      <td height="17"> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="45%"> 
                <input type="button" name="Button232253" value="Close" class="buttonclose" onClick="window.close()">
            </td>
            <td width="55%"> 
                <input type="button" name="Button2322532" value="Print Preview" class="buttonothers" onclick="printpreview()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
</form>
<%} %>
</body>
</html>