<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<htmL>
<head>
<title>
Finacle Interface
</title>
<script>
 var appURL="<%=ApplicationParams.getAppUrl()%>";
function callFinacleCustomerProfile(TYPE)
{

	if(TYPE=="R")
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanMethod.value="CustomerProfile";
		document.forms[0].hidBeanGetMethod.value="CustomerProfile";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();	
		window.close();	
	}
	else
	{
	
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanMethod.value="CoporateCustomerProfile";
		document.forms[0].hidBeanGetMethod.value="CoporateCustomerProfile";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();		
		window.close();
	}
		
}

</script>
</head>
<body bgcolor="#EEEAE3">
<%
String applicationno=(String)request.getParameter("appno");
String type=(String)request.getParameter("hidAppType");
%>
<form name=form1>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table align="center" width="400" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
    <tr> 
      <td align="center" colspan=2 height="54"><strong>SEND CUSTOMER PROFILE TO 
        FINACLE<br>
        </strong></td>
    </tr>
    <tr> 
      <td align="center" colspan=2 height="69"> 
        <input type="button" name="btncustdata_finacle" value="Send Customer Profile" onClick="callFinacleCustomerProfile('<%=type%>')"
style="background-color:red;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:200" >
      </td>
    </tr>
    <tr> 
      <td align="center" colspan=2 height="78"> 
        <input type="button" name="btncustdata_finacle2" value="Close" onClick="if(confirm('Are you want to close this window'))window.close()"
style="background-color:red;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" >
      </td>
    </tr>
  </table>
<input type="hidden" name="appno" value="">
<input type="hidden" name="hidappno" value="<%=applicationno%>">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
</form>
</body>
</html>