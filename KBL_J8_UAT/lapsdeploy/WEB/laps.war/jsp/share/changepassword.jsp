<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />

<html>
<head>
<title>LAS</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

function loadFocus()
{
	document.forms[0].txtusr_id.focus();
}


function Validate()
{		
		var bstate = true;
		var password = checktrim(document.forms[0].txtusr_password.value);
		var userid = checktrim(document.forms[0].txtusr_id.value);
		var newpassword = checktrim(document.forms[0].txtusr_newpassword.value);
		var cfmpassword = checktrim(document.forms[0].txtusr_cfmpassword.value);

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
		else if(newpassword == "")
		{
			bstate = false;
			alert("Enter New Password");
			document.forms[0].txtusr_newpassword.focus();
	
		}
		else if(cfmpassword == "")
		{
			bstate = false;
			alert("Enter Confirm Password");
			document.forms[0].txtusr_cfmpassword.focus();
	
		}
		else if(newpassword.toUpperCase() != cfmpassword.toUpperCase())
		{
			bstate = false;
			alert("Mismatch password");
		}
		else if((newpassword.toUpperCase() == cfmpassword.toUpperCase()) && (password.toUpperCase() == newpassword.toUpperCase()))
		{
			bstate = false;
			alert("Old and new password should not be the same");
			document.forms[0].txtusr_newpassword.value="";
			document.forms[0].txtusr_cfmpassword.value="";
			document.forms[0].txtusr_newpassword.focus();
		}
		else if(newpassword.length < 6)
		{
		 	alert('Password should be minimum 6 characters in length');
		 	document.forms[0].txtusr_newpassword.value = "";
		 	document.forms[0].txtusr_cfmpassword.value = "";
		 	document.forms[0].txtusr_newpassword.focus();
			return;
		 }
		if(bstate)
		{		
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidPage.value="ChangePassword";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/hidlogin.jsp";
		document.forms[0].submit();
		}

}
//By.venu - Password should contain Alpha Numeric value
/*function chkAlphaNumeric(chkVal)
{
	var chk = chkVal;
	var val =/[a-z]/ ;
	var num =/[0-9]/;
	var cap =/[A-Z]/;
	if ((val.test(chk) || cap.test(chk)) && num.test(chk))
	{
		return true;
	}
	else
	{
		alert('Field should contain Alpha Numeric value - Ex: [abc123]');
		document.forms[0].txtusr_newpassword.value="";
		document.forms[0].txtusr_newpassword.focus();
	}
}*/

function chkAlphaNumeric(obj)
{
	if(obj.value!="")
	{
		if (obj.value.match(/[a-z]/g) && obj.value.match( 
                /[A-Z]/g) && obj.value.match( 
                /[0-9]/g) && obj.value.match( 
                /[^a-zA-Z\d]/g) && obj.value.length >= 6) 
		{
			return true;
		}
		else
		{
			alert("Invalid Format.\nPassword should be minimum of 6 characters.\nPassword should contain 1 uppercase character,1 lowercase character,1 numeric and 1 special character like !@#$%^&*");
			obj.value="";
			obj.focus();
			return false;
		}
	}
	
}
</script>
</head>

<body  onload="loadFocus()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="normal">
<form name="chpass" action="">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5">
          <tr class="dataHeader"> 
            <td colspan="3"><font size="1"><b><font face="MS Sans Serif">CHANGE 
              PASSWORD </font></b></font></td>
          </tr>
          <tr class="datagrid"> 
            <td width="7%"><b></b></td>
            <td width="50%"><b><font size="1" face="MS Sans Serif">User Name</font></b></td>
            <td width="43%"><b><font size="1" face="MS Sans Serif"> 
              <input type="text" name="txtusr_id" size="20" maxlength="15" style="color:blue;border-style:groove;font-face:mssansserif">
              </font></b></td>
          </tr>
          <tr class="datagrid"> 
            <td width="7%"><b></b></td>
            <td width="50%"><b><font size="1" face="MS Sans Serif">Old Password</font></b></td>
            <td width="43%"><b><font size="1" face="MS Sans Serif"> 
              <input type="password" name="txtusr_password" size="20" maxlength="20" style="color:blue;border-style:groove;font-face:mssansserif" onKeyPress="notAllowSingleQuote()">
              </font></b></td>
          </tr>
          <tr class="datagrid"> 
            <td width="7%"><b></b></td>
            <td width="50%"><b><font size="1" face="MS Sans Serif">New Password</font></b></td>
            <td width="43%"><b><font size="1" face="MS Sans Serif"> 
              <input type="password" name="txtusr_newpassword" size="20" maxlength="15" style="color:blue;border-style:groove;font-face:mssansserif" onKeyPress="notAllowSingleQuote()" onblur="chkAlphaNumeric(this)">
              </font></b></td>
          </tr>
          <tr class="datagrid"> 
            <td width="7%"><b></b></td>
            <td width="50%"><b><font size="1" face="MS Sans Serif">Confirm Password</font></b></td>
            <td width="43%"><b><font size="1" face="MS Sans Serif"> 
              <input type="password" name="txtusr_cfmpassword" size="20"  maxlength="15" style="color:blue;border-style:groove;font-face:mssansserif" onKeyPress="notAllowSingleQuote()">
              </font></b></td>
          </tr>
          <tr > 
            <td colspan="3"> 
              <table width="0%" border="0" cellspacing="0" class="outertable border1" cellpadding="2" align="center"  onKeyPress="allowAlphabets()">
                <tr> 
                  <td> 
                    <table width="2%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td> 
                          <div align="center"> 
                            <input type="button" name="cmdOK" value="OK" style="background-color:#05519C;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onclick="Validate()">
                          </div>
                        </td>
                        <td> 
                          <div align="center"> 
                            <input type="button" name="reset" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onclick="window.close()">
                          </div>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table></td>
          </tr>
        </table>
      </td>
    </tr>
  </table><input type=hidden name="hidBeanMethod">
 <input type="hidden" name="hidPage">
</form>
</body>
</html>
