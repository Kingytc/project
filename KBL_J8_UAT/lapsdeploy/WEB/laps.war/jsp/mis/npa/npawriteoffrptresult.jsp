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
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
function printpreview()
{
	var org_level="<%=Helper.correctNull((String)hshValues.get("strOrglevel"))%>";
	var orgcode="<%=Helper.correctNull((String)hshValues.get("strOrgcode"))%>";
	var period="<%=Helper.correctNull((String)hshValues.get("strPeriod"))%>";
	var fromamt="<%=Helper.correctNull((String)hshValues.get("strAmtfrom"))%>";
	var toamt="<%=Helper.correctNull((String)hshValues.get("strToamt"))%>";
	var schemes="<%=Helper.correctNull((String)hshValues.get("strSchemes"))%>";
	var writeofftype="<%=Helper.correctNull((String)hshValues.get("writeofftype"))%>";
	var processstatus="<%=Helper.correctNull((String)hshValues.get("processstatus"))%>";
	var varPrint = "Y";
	var orgname = "<%=Helper.correctNull((String)hshValues.get("hidorgname"))%>";
	window.open(appUrl+"action/npawriteoffrptresult.jsp?hidBeanId=npaapprep&hidMethod=getWriteoff&hidBeanGetMethod=getData&hidorgcode="+orgcode+"&hidperiod="+period+"&hidfromamt="+fromamt+"&hidtoamt="+toamt+"&hidlevel="+org_level+"&hidSchemes="+schemes+"&hidorgname="+orgname+"&hidwriteofftype="+writeofftype+"&hidprocessstatus="+processstatus+"&hidPrint="+varPrint,"statPrint","scrollbars=Yes,toolbars=No,menubar=no ,width=800 , height=500,top=10,left=10");
}
</script>
</head>

<body>
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
        <%
        String strStatus= "";
        if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("P")){
          strStatus = "Pending";
          }else if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("A")){
          strStatus = "Approved";
          }else if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("R")){
          strStatus = "Rejected";
          }%>
        <tr class="font_style"> 
          <td align="center"><b>NPA Application <%=strStatus %> Status Report</b></td>
        </tr>
        <tr class="font_style"> 
          <td align="center"><b>Write Off Proposals</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table  width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3"  >
            <tr class="font_style"> 
              <td width="4%"><b>Sno</b></td>
              <td width="12%"><b>Account Number</b></td>
              <td width="12%"><b>Name of Account</b></td>
              <td width="8%"><b>Details of Write off</b></td>
              <td width="9%"><b>Running Ledger Amt</b></td>
              <td width="9%"><b>Total Dues</b></td>
              <td width="9%"><b>DICGC Amount</b></td>
              <td width="9%"><b>Legal Expenses</b></td>
              <td width="9%"><b>Amount Write off</b></td>
              <td width="9%"><b>Interest waived</b></td>
              <td width="10%"><b>Name of the D A </b></td>
            </tr>
             <%if(arrRow!=null && arrRow.size()>0)
                            {
                            	for(int i=0;i<arrRow.size();i++)
                            	{
                            		arrCol =(ArrayList)arrRow.get(i);
                            	%>
            <tr class="font_style"> 
               
              <td width="4%">&nbsp;<%=i+1%></td>
               
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
               
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
               
              <td width="8%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
              <td width="9%">&nbsp;<%=Helper.correctNull((String) arrCol.get(8))%></td>
              <td width="10%">&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%></td>
            </tr>
              <%
                            	}
                            }
			 else
			 {
            %>
            <tr class="font_style"> 
               <td colspan="11" align="center" >No Data Found</td>
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
        <%
        String strStatus= "";
        if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("P")){
          strStatus = "Pending";
          }else if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("A")){
          strStatus = "Approved";
          }else if(Helper.correctNull((String)hshValues.get("status")).equalsIgnoreCase("R")){
          strStatus = "Rejected";
          }%>
        <tr> 
          <td align="center"><b>NPA Application <%=strStatus %> Status Report</b></td>
        </tr>
        <tr> 
          <td align="center"><b>Write Off Proposals</b></td>
        </tr>
</table>
<div class="cellContainer">
  
          <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"  >
            <tr class="dataHeader" > 
              <td width="4%">Sno</td>
              <td width="12%">Account Number</td>
              <td width="12%">Name of Account</td>
              <td width="8%">Details of Write off</td>
              <td width="9%">Running Ledger Amt</td>
              <td width="9%">Total Dues</td>
              <td width="9%">DICGC Amount</td>
              <td width="9%">Legal Expenses</td>
              <td width="9%">Amount Write off</td>
              <td width="9%">Interest waived</td>
              <td width="10%">Name of the D A </td>
            </tr>
             <%if(arrRow!=null && arrRow.size()>0)
                            {
                            	for(int i=0;i<arrRow.size();i++)
                            	{
                            		arrCol =(ArrayList)arrRow.get(i);
                            	%>
            <tr class="dataGrid"> 
               
              <td width="4%">&nbsp;<%=i+1%></td>
               
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
               
              <td width="12%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
               
              <td width="8%">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
               
              <td width="9%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
              <td width="9%">&nbsp;<%=Helper.correctNull((String) arrCol.get(8))%></td>
              <td width="10%">&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%></td>
            </tr>
              <%
                            	}
                            }
			 else
			 {
            %>
            <tr> 
               <td colspan="11" align="center" >No Data Found</td>
            </tr>
             <%} %>
            
          </table>
      
    
</div>
<br>
  <table class="outertable" border="0" cellspacing="0" cellpadding="0" align="center">
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