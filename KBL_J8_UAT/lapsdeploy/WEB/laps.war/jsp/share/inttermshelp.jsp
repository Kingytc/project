<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<%
	String strPrdCode=Helper.correctNull(request.getParameter("prdCode"));
%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">



function getSelectedValue()
{
	
	var termval = document.forms[0].appidhelp.value;

	if(termval!=null)
	{
	var val1 =termval.split('$');
	window.opener.document.forms[0].txtloan_termrange.value=val1[0];
	window.opener.document.forms[0].txtloan_intrate.value=val1[1];
	window.opener.document.forms[0].txtloan_modintrate.value=val1[1];
	}
	else
	{
		alert("Select the Terms and Interest rate");
		return false;
	}
	window.close();
	
}

	</SCRIPT>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
</head>
<body bgcolor="#EEEAE3">
<form name="productlisthelp" method="post">
  <table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="45%" border="0" cellspacing="1" cellpadding="5" align="center">
          <tr> 
            <td bgcolor="#71694F"><font size="2" face="MS Sans Serif"><b><font color="#FFFFFF">Select 
              Applicant</font></b></font></td>
          </tr>
          <tr> 
            <td> 
              <table align="center">
                <tr> 
                  <td> 
                    <select name="appidhelp" size="10" onDblClick="getSelectedValue()" style="width:200">
                      <laps:termsintidhelp  appid='<%=strPrdCode%>'/> 
                    </select>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
                <tr valign="top"> 
                  <td width="20%"> 
                    <input type=button style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="OK" name="createbtn" tabindex="21" onClick="getSelectedValue()">
                  </td>
                  <td width="20%"> 
                    <input type=button style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
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
