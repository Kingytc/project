<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>


<html>
<head>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
	var strAppUrl="<%=ApplicationParams.getAppUrl()%>";
</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</style>

<script>
function getSelectedValue()
	{
	  
	  window.opener.document.forms[0].txtDiv.value=document.forms[0].selUsers.value;
	  window.close();
	}

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
</script>

<title>Division</title></head>
<body bgcolor="#EEEAE3">

<form name="divForm" method="post">
  <table width="45%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
          <tr> 
            <td align="left" bgcolor="#71694F"><font size="2" face="MS Sans Serif" color="#FFFFFF"><b>Select 
              Division </b></font></td>
          </tr>
          <tr> 
            <td align="center"> 
              <select name="selUsers" size=10 style="width:250" onDblClick="getSelectedValue()">
                <laps:divlist/> 
              </select>
            </td>
          </tr>
          <tr> 
            <td height="17">&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table border="0" cellspacing="0" cellpadding="3" align="center">
                <tr> 
                  <!--<td align="center"> 
                    <input type="button" value="Ok" name="cmdOk"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="getSelectedValue()">
                  </td>-->
                  <td align="center"> 
                    <input type="button" value="Close" name="cmdOk2" onClick="window.close()" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>