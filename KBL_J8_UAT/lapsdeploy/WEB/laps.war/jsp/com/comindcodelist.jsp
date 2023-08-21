<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
function getSelectedlistValue()
{
	if(document.forms[0].seltdoc_docs.length > 0 )
	{
		if(document.forms[0].seltdoc_docs.selectedIndex==-1)
		{
			return;
		}
		window.opener.document.forms[0].demo_industrycode.value=document.forms[0].seltdoc_docs.value;
		window.close();
	}
}


</script>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399;width:200}
-->
</style>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body bgcolor="#EEEAE3" text="#000000">
<form name="myfrm">
  <table width="30%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td bgcolor="#71694F"><font size="2" face="MS Sans Serif" color="#FFFFFF"><b>Select 
              Industrial Code</b></font></td>
          </tr>
          <tr> 
            <td><laps:dochelp value='BS' /> </td>
          </tr>
          <tr> 
            <td> 
              <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
                <tr valign="top"> 
                  <td width="20%"> 
                    <input type=button style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="OK" name="createbtn" tabindex="21" onClick="getSelectedlistValue()">
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
</form>
<p>&nbsp;</p>
</body>
</html>
