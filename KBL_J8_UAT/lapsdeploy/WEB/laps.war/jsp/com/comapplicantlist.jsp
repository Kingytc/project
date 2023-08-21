<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
function placeValues()
{
	if(document.forms[0].applicant.selectedIndex==-1)
	{
		return;
	}
	window.opener.document.forms[0].comapp_id.value=document.forms[0].applicant.value;
	var compval = document.forms[0].applicant[document.forms[0].applicant.selectedIndex].text;
	var comp = compval.split('--');
	window.opener.document.forms[0].demo_companyname.value=comp[0];
	window.close();
}


</script>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; border-style: groove}
-->
</style>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body bgcolor="#EEEAE3" text="#000000">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>

<form name="myfrm">
  <table width="45%" border="1" cellspacing="0" cellpadding="1" height="100" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" height="240"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center">
          <tr> 
            <td height="7"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="4" height="2"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="10"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="0" height="67" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                            <tr> 
                              <td height="257"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                                  <tr bgcolor="#71694F"> 
                                    <td height="15" colspan="2"><font color="#FFFFFF"><b><font size="2" face="MS Sans Serif">Commercial Applicant</font></b></font></td>
                                  </tr>
                                  <tr> 
                                    <td height="201" colspan="2"> 
                                      <div align="center"> 
                                        <select name="applicant" size="15" style="width:400" onclick="document.forms[0].ok.disabled=false" onDblclick="placeValues()">
                                          <laps:commapplicantlist /> 
                                        </select>
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="49%"> 
                                      <div align="right"> 
                                        <input type="button" name="ok" value="OK" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" disabled onclick="placeValues()">
                                      </div>
                                    </td>
                                    <td width="51%"> 
                                      <input type="button" name="close" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onclick="window.close()">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
</form>
<p>&nbsp;</p></body>
</html>
