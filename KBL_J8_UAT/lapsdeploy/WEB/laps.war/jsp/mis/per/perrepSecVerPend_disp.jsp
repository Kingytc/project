<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrCol = null;
	ArrayList arrRow  =  (ArrayList)hshValues.get("arrRow");
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setGroupingUsed(false);
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
 %>
 <html>
 <head>
 <title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
 
<script>

var AppUrl="<%=ApplicationParams.getAppUrl()%>";

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name= "orgfrm" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="3">

    <tr> 
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
    </tr>
    <tr> 
      <td align="center"><b> <%=Helper.correctNull((String)hshValues.get("branch_name")) %></b> 
    </tr>
    <tr> 
      <td align="center"><b> Securities Pending for Verification in <%=Helper.correctNull((String)hshValues.get("hidOrgName")) %>  </b></td>
    </tr>
  </table>

	
  <table width="90%" border="0" cellspacing="2" cellpadding="0" align="center" class="outertable border1">
    <tr>
      <td><b>Sl.no</b> </td>
      <td><b>Security Owner Customer ID</b></td>
      <td><b>Security Owner Name</b></td>
      <td> <b>Security ID </b></td>
      <td> <b>Type of Security </b> </td>
   	  <td> <b> Modified By </b> </td>
      <td> <b> Modified On </b> </td>
    </tr>
    <%
      if(arrRow != null && arrRow.size()>0){
    	  for(int i=0;i<arrRow.size();i++){
    		  arrCol = (ArrayList)arrRow.get(i);
    %>
    <tr valign="top"> 
      <td><%=i+1%>. &nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
      <td><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
       </tr>
      <% } %>
  
    <%} else{ %>
    <tr> 
      <td colspan="7"> 
        <div align="center">No Data Found</div>
      </td>
    </tr>
    <%} %>
  </table>

	  
 
  <br>
</form>
</body>
</html>
