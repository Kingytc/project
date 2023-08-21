
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecData =(ArrayList)hshValues.get("vecRecords");
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF6600}
-->
</style>
<script>
function showPage(appno)
{
	var path="<%=ApplicationParams.getAppUrl()%>";
	window.open(path+"action/comruncashflow.jsp?hidBeanId=comrepcashflow&hidBeanMethod=getData&hidMethod=getRowsCols&hidAppno="+appno,"cash","scrollbars=Yes,toolbar=no,menubar=yes,width=750,height=550,top=10,left=10");
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3"  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="prnfrm" method="post">
  <table width="100%" border="0" cellspacing="2" cellpadding="1">
    <%
	ArrayList v = new ArrayList();
	ArrayList v1 = null;
	v=(ArrayList)hshValues.get("vecRecords");
if(v.size()==0)
{%>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr ><td>&nbsp;</td></tr>
<tr><td><center>No data found</center></td></tr>
<%}
	for (int i=0;i<v.size();i++)
	{
		v1 = new ArrayList();
		v1=(ArrayList)v.get(i);
%>
    <tr bgcolor="#FFFFFF" > 
      <td width="12%"> <a href="JavaScript:showPage('<%=Helper.correctNull((String)v1.get(0))%>')" class="blackfont"><font size="1" face="MS Sans Serif" color="darkblue"><b><%=Helper.correctNull((String)v1.get(0))%></b></font></a> 
      </td>
      <td width="15%"> <font size="1" face="MS Sans Serif" color="darkblue"><%=Helper.correctNull( (String)v1.get(1) )%></font> 
      </td>
      <td width="13%"> <font size="1" face="MS Sans Serif" color="darkblue"> 
        <%=Helper.correctNull((String)v1.get(2))%></font> </td>
      <td width="25%"> <font size="1" face="MS Sans Serif" color="darkblue"> <%=Helper.correctNull((String)v1.get(3))+"--"+Helper.correctNull((String)v1.get(4))+"("+ Helper.correctNull((String)v1.get(5))+"--"+Helper.correctNull((String)v1.get(6))+")"%></font> 
      </td>
      <td width="10%" align="center"> <font size="1" face="MS Sans Serif" color="darkblue"> 
        <%=Helper.correctNull((String)v1.get(7))%></font> </td>
      <td width="15%"> <font size="1" face="MS Sans Serif" color="darkblue"> <%=Helper.correctNull((String)v1.get(8))%></font> 
      </td>
    </tr>
    <%
}
%>
  </table>
</form>
</body>
</html>
