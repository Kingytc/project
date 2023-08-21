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
	function selectedUsers()
	{
	if(document.forms[0].selUsers.value!=null)
		{
		window.opener.document.forms[0].elements["appscan_verifyby"].value=document.forms[0].selUsers.value;
		window.close();
		}
	}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<form name="users" method="post" class="normal">
  <table width="45%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
          <tr> 
            <td align="left" ><b>Select 
              Users</b></td>
          </tr>
          <tr> 
            <td align="center"> 
              <select name="selUsers" size=10 style="width:250" multiple>
                <laps:mailusers/> 
              </select>
            </td>
          </tr>
          <tr> 
            <td height="17">&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor buttonbgcolor">
                <tr> 
                  <td align="center"> 
                    <input type="button" value="OK" name="cmdOk" onClick="selectedUsers()" class="buttonStyle">
                  </td>
                  <td align="center"> 
                    <input type="button" value="Close" name="cmdOk2" onClick="window.close()" class="buttonclose">
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