<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
  ArrayList arrRow=new ArrayList();
  ArrayList arrCol=new ArrayList();
  if(hshValues!=null){
  arrRow=(ArrayList)hshValues.get("arrRow");
  }

  
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<script>


		
function doClose()
{
	window.close();

}




</script>
</head>
<body>
<br>
<form name= "orgfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
                 
    </table>
    
    
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
      <tr> 
        <td > 
        <div>
          <table width="100%" border="1" cellspacing="1" cellpadding="0" >
          	    <td   style="font-weight: bold">S.No</td>
				<td   style="font-weight: bold">Branch Code</td>
				<td   style="font-weight: bold">Branch Name</td>
				<td   style="font-weight: bold">Region Code</td>
				<td   style="font-weight: bold">Region Name</td>
				<td   style="font-weight: bold">Borrower Name</td>
				<td   style="font-weight: bold">Customer ID</td>
				<td   style="font-weight: bold">Finacle Account Number</td>
				<td   style="font-weight: bold">Norm Status</td>
				<td   style="font-weight: bold">Date of NPA</td>
				<td   style="font-weight: bold">Balance Outstanding</td>
				<td   style="font-weight: bold">Unrealised Interest</td>
				<td   style="font-weight: bold">Other Charges</td>
				<td   style="font-weight: bold">Net Balance</td>
				<td   style="font-weight: bold">Provision</td>
				<td   style="font-weight: bold">Secured Value</td>
				<td   style="font-weight: bold">Unsecured Value</td>
				<td   style="font-weight: bold">Whether Partly secured</td>
				<td   style="font-weight: bold">CGC/ECGC/CGTMSE-Recd+Cover</td>
				<td   style="font-weight: bold">Ab-initio</td>
				<td   style="font-weight: bold">Date of AB-Initio</td>
				<td   style="font-weight: bold">Whether Restructured</td>
				<td   style="font-weight: bold">Date of Restructuring</td>
				<td   style="font-weight: bold">Whether written off</td>
				<td   style="font-weight: bold">Whether Fraud</td>
				<td   style="font-weight: bold">Date of Fraud</td>
				<td   style="font-weight: bold">Security Type</td>
				<td   style="font-weight: bold">Security ID</td>
				<td   style="font-weight: bold">Owner of security</td>
				<td   style="font-weight: bold">Consortium/ Multiple/Sole</td>
				<td   style="font-weight: bold">If Consortium,Charge (Paripassu/ first)</td>
				<td   style="font-weight: bold">Prime/ Collateral</td>
				<td   style="font-weight: bold">Valuation Date</td>
				<td   style="font-weight: bold">Security Value</td>
				<td   style="font-weight: bold">Out of which assigned secured value</td>
				<td   style="font-weight: bold">CBS Security Value</td>
        	
        	<%if(arrRow!=null && arrRow.size()>0){
        		for(int i=0;i<arrRow.size();i++){
        		arrCol=(ArrayList)arrRow.get(i);%>
        		<tr>
        		<td><%=i+1%>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(9)))%>&nbsp;</td>
 				<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(10)))%>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(11)))%>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(12)))%>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(13)))%>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(14)))%>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(15)))%>&nbsp;</td>       		        		
        		<td><%=Helper.correctNull((String)arrCol.get(16)) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(17)))%>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(18)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(19)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(20)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(21)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(22)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(23)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(24)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(25)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(26)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(27)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(28)) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(29))) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(30)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(31)) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(32))) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(33))) %>&nbsp;</td>
        		<td><%=Double.parseDouble(Helper.correctDouble((String)arrCol.get(34))) %>&nbsp;</td>
        	
        	<%}}else{%>
        	<tr>
        	<td colspan="20" align="center"> -- No Record Found --</td>
        	</tr>
        	<%} %>
          </table>
          </div>
        </td>
      </tr>
    </table>
<br>

 	<lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
 
</form>
</body>
</html>
