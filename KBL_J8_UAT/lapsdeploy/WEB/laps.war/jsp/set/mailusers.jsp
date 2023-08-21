<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<html>
<head>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/mailbox.js">
</script>
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

</head>
<body bgcolor="#EEEAE3">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>
<form name="users" method="post">
  <table width="45%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
          <tr> 
            <td align="left" bgcolor="#71694F"><font size="2" face="MS Sans Serif" color="#FFFFFF"><b>Select 
              Users</b></font></td>
          </tr>
          <tr> 
            <td align="center"> 
              <select name="selUsers" size=15 style="width:400" multiple>
                <laps:mailusers/> 
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
                  <td align="center"> 
                    <input type="button" value="Ok" name="cmdOk" onClick="selectedUsers()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" >
                  </td>
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