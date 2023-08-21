<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

%>

<html>
<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
function callOnLoad()
{

}

</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body onload=""  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" link="#000000" vlink="#000000" alink="#000000" class="bgcolor">
<form name="isearch" method="post">
  <table width="100%" border="0" cellpadding="1" cellspacing="2" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
    <tr class="outertablecolor"  > 
      <td width="37%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="JavaScript:callLink()" class="blackfont"><b><font size="1" face="MS SansSerif" >
	  </td>
      <td width="17%" align="left"><b><font size="1" face="MS Sans Serif"></font></b></td>
	  <td width="36%" align="center"> 
        <div align="left"><b><font size="1" face="MS Sans Serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%//=Helper.correctNull((String)arryCol.get(4))%><%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;</font></b></div>
      </td>
    </tr>
	 <tr> 
      <td width="37%"><a><font size="3" face="MS Sans Serif"><center><%out.println("-----NO DATA FOUND-----");%></center></font></a></td>
	  </tr>
  </table>
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hidBeanId">
  <INPUT TYPE="hidden" name="hidBeanGetMethod">

</form>
</body>
</html>
