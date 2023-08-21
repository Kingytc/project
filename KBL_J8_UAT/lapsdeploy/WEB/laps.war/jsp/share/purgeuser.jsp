<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />


<html>
<head>
<title>LAPS</title>
<style type="text/css">
<!--
.text_area
		{
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:11px;
		color:#0279cd;
		}
.btn
		{
		height:22px;
		background-color:#05519C;
	    color:#fff;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:.8em;
		margin:1px 2px 8px 4px;
		font-weight:bold;
		}

-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
function entsub(myform) 
{
  if (window.event && window.event.keyCode == 13)
    Validate();
  else
    return true;
}

function Validate()
{		
		var bstate = true;
		var password = checktrim(document.forms[0].txtusr_password.value);
		var userid = checktrim(document.forms[0].txtusr_id.value);
		if(userid == "")
		{
			bstate = false;
			alert("Enter User Name");
			document.forms[0].txtusr_id.focus();
		}
		else if(password == "")
		{
			bstate = false;
			alert("Enter Password");
			document.forms[0].txtusr_password.focus();
		}
		if(bstate)
		{
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidPage.value="PurgeUser";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/hidlogin.jsp";
		document.forms[0].submit();
		}

}
function loadFocus()
{
	//document.forms[0].txtusr_password.focus();
	document.forms[0].txtusr_id.focus();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onload="loadFocus()" 
leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
	<div class="menuitems" url="">
    	<script language="JavaScript1.2">
			if (document.all && window.print)
				{
				ie5menu.className = menuskin;
				document.oncontextmenu = showmenuie5;
				document.body.onclick = hidemenuie5;
				}
		</script>
	</div>
</div>
<form name="purge" action="" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" 
  align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5">
          <tr bgcolor="#E21E07"> 
            <td colspan="2"><font color="#FFFFFF" size="1"><b><font face="MS Sans Serif">Purge 
              User</font></b></font></td>
          </tr>
            <tr> 
            <td width="72%"><b><font size="1" face="MS Sans Serif">Enter Your 
              User Name</font></b></td>
            <td width="28%"><b><font size="1" face="MS Sans Serif"> 
              <input type="text" name="txtusr_id" size="15" maxlength="15" 
               onkeypress="notAllowSingleQuote();return entsub(this.form)" 
                            autocomplete="off" oncopy="return false" ondrag="return false"  
                            ondrop="return false" onpaste="return false" 
                            class="text_area">
              </font></b></td>
          </tr>
          <tr> 
            <td width="72%"><b><font size="1" face="MS Sans Serif">Enter Your 
              Password </font></b></td>
            <td width="28%"><b><font size="1" face="MS Sans Serif"> 
              <input type="password" name="txtusr_password" size="15" maxlength="20" 
             class="text_area"
               onkeypress="notAllowSingleQuote();return entsub(this.form)" 
                            autocomplete="off" oncopy="return false" ondrag="return false"  
                            ondrop="return false" onpaste="return false" 
                            onKeyPress="notAllowSingleQuote();return entsub(this.form)">
              </font></b></td>
          </tr>
        
          <tr> 
            <td colspan="2"> 
              <table width="0%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td> 
                          <div align="center"> 
                            <input type="button" name="cmdOk" value="Purge" 
                            class="btn"
                            onClick="Validate()">
                          </div>
                        </td>
                        <td> 
                          <div align="center"> 
                            <input type="reset" name="cmdCancel" value="Close" 
                            class="buttonClose" onclick="window.close()">
                          </div>
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
    <input type=hidden name="hidBeanMethod">
    <input type="hidden" name="hidPage">
  </table></form>
</body>
</html>
