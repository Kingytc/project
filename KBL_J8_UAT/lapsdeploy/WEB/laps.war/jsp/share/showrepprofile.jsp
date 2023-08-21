<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%

	ArrayList vecLabel = new ArrayList();
	ArrayList vecValue = new ArrayList();
	vecLabel=(ArrayList)objValues.get("vecLabel");
	vecValue=(ArrayList)objValues.get("vecValue");
	
%>

<html>
<head>
<title>Report Profile</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
function callFun()
{
	window.close();	
}
</script>

</head>

<body bgcolor="#EEEAE3" text="#000000" >
<div >
<div ></div>
</div>

<form name="frmshowprof" method= "post">
  <div align="center"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="5" height="200" class="outertable border1" align="center">
      <tr> 
        <td valign="top" height="2"> <font size="1" face="MS Sans Serif">Parameters:</font><br>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" class="outertable border1" align="center">
            <%
				for (int i=0;i<vecLabel.size();i++)
				{
			%>
            <tr> 
              <td width="25%"><font size="1" face="MS Sans Serif">&nbsp;<%=vecLabel.get(i)%></font></td>
              <td width="75%"><font size="1" face="MS Sans Serif">&nbsp;<%=vecValue.get(i)%></font></td>
            </tr>
            <%
				}
			%>
          </table>
          <div align="center"> <br>
            <input type="button" name="cmdclos" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onclick="JavaScript:callFun()">
          </div>
        </td>
      </tr>
    </table>
    <br>
  </div>
  
</form>
</body>
</html>
