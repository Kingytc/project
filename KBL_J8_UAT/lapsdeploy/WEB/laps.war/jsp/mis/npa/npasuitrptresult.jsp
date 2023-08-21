<%@include file="../../share/directives.jsp"%><html xmlns="http://www.w3.org/1999/xhtml">
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();

if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
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
	var varcourt="<%=Helper.correctNull((String)hshValues.get("strCourt"))%>";
	var varPrint = "Y";
	window.open(appUrl+"action/npasuitrptresult.jsp?hidBeanId=npaapprep&hidBeanGetMethod=getData&hidMethod=getLegalCases&hidOrgLevel="+varorglevel+"&hidOrgcode="+varorgcode+"&hidSchemes="+varschemes+"&hidCourt="+varcourt+"&txtfromamt="+varfrmamt+"&txttoamt="+vartoamt+"&hidPeriod="+varperiod+"&hidPrint="+varPrint,"statPrint","scrollbars=Yes,toolbars=No,menubar=no ,width=800 , height=500,top=10,left=10");
}
</script>
</head>

<body >
<%if(strPrint.equalsIgnoreCase("Y")){ %>
<form name= "orgfrm" method="post" >
 <table width="100%" border="0" cellspacing="0" cellpadding="3" >
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
  <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
           
            <tr class="font_style"> 
              <td><b>Sno</b></td>
              <td><b>Name of Account</b></td>
              <td><b>Suit No.</b></td>
              <td><b>Date of Suit file</b></td>
              <td><b>Amount of suit</b></td>
			  <td><b>NPA Since</b></td>
			  <td><b>Running Ledger Amount account wise</b></td>
		      <td><b>Present Position of Suit</b></td>
			  <td><b>Name of advocate</b></td>
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
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
			</tr>
			<%
					}
				}else{
			%>
			<tr class="font_style">
				<td colspan="9">&nbsp;</td>
			</tr>
			<tr  class="font_style">
				<td colspan="9">No Record Found</td>
			</tr>
			<tr class="font_style">
				<td colspan="9">&nbsp;</td>
			</tr>
			<%} %>
         </table>
       </td>
      </tr>
   </table>
</div>
</form>
<%}else{ %>
<form name= "orgfrm" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
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
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" >
           
            <tr class="dataHeader"> 
              <td>Sno</td>
              <td>Name of Account</td>
              <td>Suit No.</td>
              <td>Date of Suit file</td>
              <td>Amount of suit</td>
			  <td>NPA Since</td>
			  <td>Running Ledger Amount account wise</td>
		      <td>Present Position of Suit</td>
			  <td>Name of advocate</td>
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
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
			</tr>
			<%
					}
				}else{
			%>
			<tr class="dataGrid">
				<td colspan="9">&nbsp;</td>
			</tr>
			<tr class="dataGrid">
				<td colspan="9">No Record Found</td>
			</tr>
			<tr class="dataGrid">
				<td colspan="9">&nbsp;</td>
			</tr>
			<%} %>
         </table>
       </td>
      </tr>
   </table>
</div>
  <table border="0" cellspacing="0" cellpadding="0"  class="outertable border1" align="center">
    <tr> 
      <td height="17"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr> 
            <td width="45%"> 
                <input type="button" name="Button232253" value="Close" 
                class="buttonclose" onClick="window.close()">
            </td>
            <td width="55%"> 
                <input type="button" name="Button2322532" value="Print Preview" 
               class="buttonothers" 
                onclick="printpreview()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%} %>
</body>
</html>