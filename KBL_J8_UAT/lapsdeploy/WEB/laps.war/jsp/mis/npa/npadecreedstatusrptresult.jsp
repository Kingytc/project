<%@include file="../../share/directives.jsp"%><%
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
	var varPrint = "Y";
	window.open(appUrl+"action/npadecreedstatusrptresult.jsp?hidBeanId=npaapprep&hidBeanGetMethod=getData&hidMethod=getDecreedEP&hidOrgLevel="+varorglevel+"&hidOrgcode="+varorgcode+"&hidSchemes="+varschemes+"&txtfromamt="+varfrmamt+"&txttoamt="+vartoamt+"&hidPeriod="+varperiod+"&hidPrint="+varPrint,"DecreedEPPrint","scrollbars=Yes,toolbars=No,menubar=no ,width=800 , height=500,top=10,left=10");
}
</script>
</head>

<body >
<%if(strPrint.equalsIgnoreCase("Y")){ %>
<form  name= "orgfrm" method="post">
 <table width="100%" border="0" cellspacing="0" cellpadding="3">
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
          <td align="center"><b>Status of Decree execution petition </b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
           
            <tr class="font_style"> 
              <td><b>Sno</b></td>
              <td><b>Name of Account</b></td>
              <td><b>Suit No.</b></td>
              <td><b>Amount of Decreed</b></td>
              <td><b>Date of Decreed</b></td>
              <td><b>Date of filling Execution petition</b></td>
			  <td><b>Present Position of Suit</b></td>
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
			</tr>
			<%
					}
				}else{
			%>
			<tr class="font_style">
				<td colspan="9" align="center">No Record Found</td>
			</tr>
			<%} %>
         </table>
      <br>
     	
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
          <td align="center"><b>Status of Decree execution petition </b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"  >
           
            <tr class="dataHeader"> 
              <td>Sno</td>
              <td>Name of Account</td>
              <td>Suit No.</td>
              <td>Amount of Decreed</td>
              <td>Date of Decreed</td>
              <td>Date of filling Execution petition</td>
			  <td>Present Position of Suit</td>
			</tr>
			<%
				if(arrRow!=null && arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
					arrCol=(ArrayList)arrRow.get(i);
			%>
			<tr class="daatGrid">
				<td><%=(i+1)%>.</td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
			</tr>
			<%
					}
				}else{
			%>
			<tr class="daatGrid">
				<td colspan="9" align="center">No Record Found</td>
			</tr>
			<%} %>
         </table>
      <br>
     	
  </div>
  <table class="outertable" border="0" cellspacing="0" cellpadding="0"    align="center">
    <tr> 
      <td height="17"> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="45%"> 
                <input type="button" name="Button232253" value="Close" 
                class="buttonClose" onClick="window.close()">
            </td>
            <td width="55%"> 
                <input type="button" name="Button2322532" value="Print Preview" 
               class="buttonOthers"
                onclick="printpreview()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>  <br>
</form>
<%} %>
</body>
</html>