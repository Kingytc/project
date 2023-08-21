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
    
    
    <table width="100%" border="0" class="border1" cellspacing="0" cellpadding="0"  align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable linebor1">
           	<tr class="dataheader">
        	<td rowspan="2"  style="font-weight: bold">Customer Id</td>
        	<td rowspan="2"  style="font-weight: bold">Borrower Name</td>
        	<td rowspan="2"  style="font-weight: bold">MSME Proposal No</td>
        	<td rowspan="2"  style="font-weight: bold">Proposal No</td>
        	<td rowspan="2"  style="font-weight: bold">Fac Sl No</td>
        	<td colspan="4"  style="font-weight: bold">Present Classification</td>
        	<td colspan="4"  style="font-weight: bold">New Classification</td>
        	<td colspan="4"  style="font-weight: bold">Entered User Details</td>
        	<td colspan="4"  style="font-weight: bold">Verifier User Details</td>
        	</tr>
        	<tr class="dataheader" align="center">
        	<td  style="font-weight: bold">P/M Value</td>
        	<td  style="font-weight: bold">Equipment Value</td>
        	<td  style="font-weight: bold">Sales Turnover of the Applicant with date</td>
        	<td  style="font-weight: bold">MIS Classification</td>
        	<td  style="font-weight: bold">P/M Value</td>
        	<td  style="font-weight: bold">Equipment Value</td>
        	<td  style="font-weight: bold">Sales Turnover of the Applicant with date</td>
        	<td  style="font-weight: bold">MIS Classification</td>
        	<td  style="font-weight: bold">Date</td>
        	<td  style="font-weight: bold">Staff Id</td>
        	<td  style="font-weight: bold">Sol ID</td>
        	<td  style="font-weight: bold">Dept.</td>
        	<td  style="font-weight: bold">Date</td>
        	<td  style="font-weight: bold">Staff Id</td>
        	<td  style="font-weight: bold">Sol ID</td>
        	<td  style="font-weight: bold">Dept.</td>
        	</tr>
        	
        	<%if(arrRow!=null && arrRow.size()>0){
        		for(int i=0;i<arrRow.size();i++){
        		arrCol=(ArrayList)arrRow.get(i);%>
        		<tr class="datagrid">
        		<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(34)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(6)) %> - <%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
        		<td>Activity Code : <%=Helper.correctNull((String)arrCol.get(32)) %><br/>
        		Agriculture/Industry/Service Category type : <%=Helper.correctNull((String)arrCol.get(8)) %><br/>
        		Sector : <%=Helper.correctNull((String)arrCol.get(9)) %><br/>
        		Sub Sector : <%=Helper.correctNull((String)arrCol.get(10)) %><br/>
        		Sensitive Sector : <%=Helper.correctNull((String)arrCol.get(11)) %><br/>
        		Stand Up India: <%=Helper.correctNull((String)arrCol.get(13)) %><br/>
        		Govt. Announced scheme : <%=Helper.correctNull((String)arrCol.get(12)) %><br/>&nbsp;</td>
        		
        		<td><%=Helper.correctNull((String)arrCol.get(15)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(16)) %> - <%=Helper.correctNull((String)arrCol.get(17)) %>&nbsp;</td>
        		
        		
        		<td>Activity Code : <%=Helper.correctNull((String)arrCol.get(33)) %><br/>
        		Agriculture/Industry/Service Category type : <%=Helper.correctNull((String)arrCol.get(18)) %><br/>
        		Sector : <%=Helper.correctNull((String)arrCol.get(19)) %><br/>
        		Sub Sector : <%=Helper.correctNull((String)arrCol.get(20)) %><br/>
        		Sensitive Sector : <%=Helper.correctNull((String)arrCol.get(21)) %><br/>
        		Stand Up India: <%=Helper.correctNull((String)arrCol.get(23)) %><br/>
        		Govt. Announced scheme : <%=Helper.correctNull((String)arrCol.get(22)) %><br/>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(25)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(24)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(26)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(27)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(29)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(28)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(30)) %>&nbsp;</td>
        		<td><%=Helper.correctNull((String)arrCol.get(31)) %>&nbsp;</td>
        		
        		</tr>
        	
        	<%}}else{%>
        	<tr>
        	<td colspan="20" align="center"> -- No Record Found --</td>
        	</tr>
        	<%} %>
          </table>
         
        </td>
      </tr>
    </table>
<br>

 	<lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
 
</form>
</body>
</html>
