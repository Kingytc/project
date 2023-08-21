<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
	//System.out.println("Application Number in presanction: "+request.getParameter("appno"));
	String appno = (String)request.getParameter("appno");
%>



<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript">
function gotoCreditInfo()
{
	document.myform.hidBeanGetMethod.value="getCreditHistory";
	document.myform.action="<%=ApplicationParams.getAppUrl()%>action/comcredithistory.jsp";
	document.myform.submit();
}

function gotoCollateral()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commcollateral.jsp?hidBeanGetMethod=getCollateral";
	document.myform.submit();
}

</script>


</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="myform" method="post" action="<%=ApplicationParams.getAppUrl()%>action/comcredithistory.jsp?hidBeanGetMethod=getCreditHistory">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp; </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td align="center"><a href="javascript:gotoCreditInfo()"><img src="<%=ApplicationParams.getAppUrl()%>img/appraisal.jpg" border="0"></a></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><font size="3"></font></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><font size="3"></font></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><font size="3"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><font size="3"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><font size="3"><b><a href="javascript:gotoCollateral()"><img src="<%=ApplicationParams.getAppUrl()%>img/back.jpg" border=0></a></b></font></td>
    </tr>
  </table>

<input type="hidden" name="appno" value="<%=appno%>">
  <input type="hidden" name="appstatus" value="<%=request.getParameter("appstatus")%>">
  <input type="hidden" name="hidBeanGetMethod" value="">
</form>
</body>
</html>
