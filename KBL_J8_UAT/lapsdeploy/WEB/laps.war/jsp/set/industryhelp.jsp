<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>

<html>
<head>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">

	function getSelectedValue()
	{
		window.opener.document.forms[0].hid_indcode.value = document.forms[0].grouphelp.value;
		window.opener.document.forms[0].txt_inddesc.value = document.forms[0].grouphelp.options[document.forms[0].grouphelp.selectedIndex].text;
		window.close();
			
	}

	</SCRIPT>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
-->
</style>
<title>Group</title></head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="grouphelp" method="post">
  <table width="30%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td bgcolor="#71694F"><font size="2" face="MS Sans Serif" color="#FFFFFF"><b>Select 
              Group </b></font></td>
          </tr>
          <tr> 
            <td> 
              <select name="grouphelp" size="15" onDblClick="getSelectedValue()" style="width:400">
                <option value=""><--- None ---></option>
				<laps:industryhelp/> 
              </select>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
                <tr valign="top"> 
                  <td width="20%"> 
                    <input type=button class="buttonStyle" value="OK" name="createbtn" tabindex="21" onClick="getSelectedValue()">
                  </td>
                  <td width="20%"> 
                    <input type=button class="buttonClose" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <!--These hidden variable need to be  in the parent form -->
</form>
</body>
</html>
