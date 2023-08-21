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
      <td align="center"><b>Loan application Register - <%=Helper.correctNull((String)hshValues.get("processat")) %></b></td>
    </tr>
  </table>

	
  <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td  width="5%" rowspan=2 valign="top"><b>Sr No</b></td>
      <td  width="8%" rowspan=2 valign="top"><b>Inward No</b></td>
      <td width="9%" rowspan=2 valign="top"> 
        <div align="center"><b>Applicant Name</b></div>
      </td>
      <td  width="7%" rowspan=2 valign="top"> 
        <div align="center"><b>Sector</b></div>
      </td>
      <td  colspan="3" align="center" valign="top" height="49"><b>Amount Requested</b></td>
      <td  width="7%" rowspan=2 valign="top"> 
        <div align="center"><b>Date Applied</b></div>
      </td>
      <td  width="12%" rowspan=2 valign="top"> 
        <div align="center"><b>Documents Submitted Date</b></div>
      </td>
      <td  width="7%" rowspan=2 valign="top"> 
        <div align="center"><b>Status</b></div>
      </td>
      <%if(!Helper.correctNull((String)hshValues.get("orglevel")).equals("A")){ %>
      <td  width="16%" rowspan=2 valign="top"> 
        <div align="center"><b>Branch Name</b></div>
      </td>
      <%} %>
    </tr>
    <tr> 
      <td width="11%" height="2"> 
        <div align="center"><b>Fund based - WC</b></div>
      </td>
      <td width="9%" height="2"> 
        <div align="center"><b>Fund Based - TL</b></div>
      </td>
      <td width="9%" height="2"> 
        <div align="center"><b>Non Fund Based - WC</b></div>
      </td>
    </tr>
    <%
      if(arrRow != null && arrRow.size()>0){
    	  for(int i=0;i<arrRow.size();i++){
    		  arrCol = (ArrayList)arrRow.get(i);
    	 
    %>
    <tr> 
      <td width="5%"><%=i+1%>&nbsp;</td>
      <td width="8%" align="right"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
      <td width="9%"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
      <td width="7%"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
      <td width="11%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>&nbsp;</td>
      <td width="9%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>&nbsp;</td>
      <td width="9%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>&nbsp;</td>
      <td width="7%"><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</td>
      <td width="12%"><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</td>
      <td width="7%"><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
       <%if(!Helper.correctNull((String)hshValues.get("orglevel")).equals("A")){%>
      <td width="16%"><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
      <%} } %>
    </tr>
    <%}else{ %>
    <tr> 
      <td colspan="11"> 
        <div align="center">No Data Found</div>
      </td>
    </tr>
    <%} %>
  </table>

	  
 
  <br>
</form>
</body>
</html>
