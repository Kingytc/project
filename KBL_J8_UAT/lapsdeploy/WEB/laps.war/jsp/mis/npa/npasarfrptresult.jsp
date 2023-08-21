<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<laps:handleerror />
<%
ArrayList arrRow= new ArrayList();
ArrayList arrCol= new ArrayList();
arrRow =(ArrayList)hshValues.get("arrRow");

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
	var org_level="<%=Helper.correctNull((String)hshValues.get("strOrglevel"))%>";
	var orgcode="<%=Helper.correctNull((String)hshValues.get("strOrgcode"))%>";
	var period="<%=Helper.correctNull((String)hshValues.get("strPeriod"))%>";
	var fromamt="<%=Helper.correctNull((String)hshValues.get("strAmtfrom"))%>";
	var toamt="<%=Helper.correctNull((String)hshValues.get("strToamt"))%>";
	var schemes="<%=Helper.correctNull((String)hshValues.get("strSchemes"))%>";
	var orgname="<%=Helper.correctNull((String)hshValues.get("hidorgname"))%>";
	var varPrint = "Y";
	
	window.open(appUrl+"action/npasarfrptresult.jsp?hidBeanId=npaapprep&hidMethod=getSarfaesiCases&hidBeanGetMethod=getData&hidorgcode="+orgcode+"&hidperiod="+period+"&hidfromamt="+fromamt+"&hidtoamt="+toamt+"&hidlevel="+org_level+"&hidSchemes="+schemes+"&hidorgname="+orgname+"&hidPrint="+varPrint,"statPrint","scrollbars=Yes,toolbars=No,menubar=no ,width=800 , height=500,top=10,left=10");
}
</script>
</head>
<body>
<%if(strPrint.equalsIgnoreCase("Y")){ %>
<form name= "orgfrm" method="post">
 <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr class="font_style">
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr  class="font_style"> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
        <tr  class="font_style"> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("orgname"))%></td>
        </tr> 
        <tr  class="font_style"> 
          <td align="center"><b>Details of Sarfaesi cases</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
            <tr  class="font_style"> 
              <td width="4%"><b>Sno</b></td>
              <td width="15%"><b>Name of Account</b></td>
              <td width="9%"><b>NPA Since</b></td>
              <td width="14%"><b>Running Ledger Amount</b></td>
              <td width="13%"><b>A/C wise R&amp;L Outstanding</b></td>
              <td width="11%"><b>Whether BIFR</b></td>
              <td width="11%"><b>Date of BIFR</b></td>
              <td width="11%"><b>Date of demand notice</b></td>
              <td width="12%"><b>Date of Possession</b></td>
            </tr>
			 <%if(arrRow!=null && arrRow.size()>0)
                            {
                            	for(int i=0;i<arrRow.size();i++)
                            	{
                            		arrCol =(ArrayList)arrRow.get(i);
                            	%>
            <tr  class="font_style"> 
              <td width="4%">&nbsp;<%=i+1%></td>
              <!--  -->
              <td width="15%">&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%></td>
              <!--Name of A/C  -->
              <td width="9%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
              <!--NPA Since   -->
              <td width="14%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))%></td>
              <!--R/L Amt account wise  -->
              <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
              <!--A/C wise R&L Outstanding  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
              <!--Whether BIFR  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
              <!--Date of BIFR  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
              <!--Date of demand notice   -->
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
              <!--Date of position   -->              
            </tr>
            <%
                            	}
                            }
			 else
			 {
            %>
            <tr  class="font_style">
              <td colspan="9" align="center" >No Data Found</td>
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
          <td align="center"><b>Details of Sarfaesi cases</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"  >
            <tr class="dataHeader"> 
              <td width="4%">Sno</td>
              <td width="15%">Name of Account</td>
              <td width="9%">NPA Since</td>
              <td width="14%">Running Ledger Amount</td>
              <td width="13%">A/C wise R&amp;L Outstanding</td>
              <td width="11%">Whether BIFR</td>
              <td width="11%">Date of BIFR</td>
              <td width="11%">Date of demand notice</td>
              <td width="12%">Date of Possession</td>
            </tr>
			 <%if(arrRow!=null && arrRow.size()>0)
                            {
                            	for(int i=0;i<arrRow.size();i++)
                            	{
                            		arrCol =(ArrayList)arrRow.get(i);
                            	%>
            <tr class="dataGrid"> 
              <td width="4%">&nbsp;<%=i+1%></td>
              <!--  -->
              <td width="15%">&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%></td>
              <!--Name of A/C  -->
              <td width="9%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
              <!--NPA Since   -->
              <td width="14%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))%></td>
              <!--R/L Amt account wise  -->
              <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
              <!--A/C wise R&L Outstanding  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
              <!--Whether BIFR  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
              <!--Date of BIFR  -->
              <td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
              <!--Date of demand notice   -->
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
              <!--Date of position   -->              
            </tr>
            <%
                            	}
                            }
			 else
			 {
            %>
            <tr class="dataGrid">
              <td colspan="9" align="center" >No Data Found</td>
            </tr>
            <%} %>
          </table>
      
     	
  </div>
  <bR>
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0"    align="center">
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
  </table> <bR>
</form>
<%} %>
</body>
</html>