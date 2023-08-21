<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<html>
<head>
<title>Signal Points</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
	<!--
	input {  font-family: "ms sans serif"; font-size: 9px; color: #003399; border-style: groove}
	-->
</style>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>

<script language="JavaScript">
var ind = <%= request.getParameter("index") %>
	function getData()
	{
		
//		alert("ind ="+ind +"hid value="+ window.opener.document.forms[0].hidValue[ind].value);
		var myval = window.opener.document.forms[0].hidValue[ind].value;

		var myarr = myval.split("/");
		for(i=0;i<myarr.length;i++)
		{
			if(myarr[i] != 'null')
			{
				var myarr1 = myarr[i].split("~");
				document.forms[0].txtfrom[i].value = myarr1[0];
				document.forms[0].txtto[i].value = myarr1[1];
				document.forms[0].txtpoints[i].value = myarr1[2];
			}
		}
	}

	function chkData()
	{
		flag=0;
		for(i=0;i<4;i++)
		{
			val1 = document.forms[0].txtfrom[i].value;
			val2 = document.forms[0].txtto[i].value;
			val3 = document.forms[0].txtpoints[i].value;

			if(val1!='' && val2=='')
				flag=1;
			if(val2=='' && val2!='')
				flag=1;
		}
		return flag;
	}

	function closeme()
	{
		fl = chkData();
		if(fl==0)
		{
			var tmp;
			if( document.forms[0].txtfrom[0].value==''&&
				document.forms[0].txtto[0].value==''&&
				document.forms[0].txtpoints[0].value=='' )
			{
				tmp = "0.00" + "~" + "0.00" + "~" + "0.00";
			}
			else
			{
				tmp = document.forms[0].txtfrom[0].value + "~" + document.forms[0].txtto[0].value + "~" + document.forms[0].txtpoints[0].value;
			}

			for(i=1;i<4;i++)
			{
				if( document.forms[0].txtfrom[i].value==''&&
					document.forms[0].txtto[i].value==''&&
					document.forms[0].txtpoints[i].value=='' )
				{
					tmp = tmp + "/" + "0.00" + "~" + "0.00" + "~" + "0.00";
				}
				else
				{
					tmp = tmp + "/" + document.forms[0].txtfrom[i].value + "~" + document.forms[0].txtto[i].value + "~" + document.forms[0].txtpoints[i].value;
				}
			}
			window.opener.document.forms[0].hidValue[ind].value = tmp;
//			alert(window.opener.document.forms[0].hidValue[ind].value);
			window.close();
		}
		else
		{
			alert("Fill in the proper range");
		}
	}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="getData()">
<form name="signalpoints" method="post" action="">
<br><br>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="6" align="center" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                <tr> 
                  <td width="25%" height="14" bgcolor="#71694F">&nbsp;</td>
                  <td width="25%" height="14" align="center" bgcolor="#71694F"> 
                    <font color="#FFFFFF"><b><font size="1" face="ms sans serif">From</font></b> 
                    </font></td>
                  <td width="25%" height="14" align="center" bgcolor="#71694F"> 
                    <font color="#FFFFFF"><b><font size="1" face="ms sans serif">To</font> 
                    </b> </font></td>
                  <td width="25%" height="14" align="center" bgcolor="#71694F"> 
                    <font color="#FFFFFF"><b><font size="1" face="ms sans serif">Points</font></b> 
                    </font></td>
                </tr>
                <tr> 
                  <td width="25%" align="center"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Range1 
                    </font></b> </font></td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtfrom" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                  <td width="25%" align="center"> <font size="1" face="MS Sans Serif"> 
                    <input type="text" name="txtto" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                    </font> </td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtpoints" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                </tr>
                <tr> 
                  <td width="25%" align="center"> <font color="#000000"><b><font face="MS Sans Serif" size="1">Range 
                    2</font></b> </font></td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtfrom" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                  <td width="25%" align="center"> <font size="1" face="MS Sans Serif"> 
                    <input type="text" name="txtto" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                    </font> </td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtpoints" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                </tr>
                <tr> 
                  <td width="25%" align="center"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Range 
                    3</font></b> </font></td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtfrom" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                  <td width="25%" align="center"> <font size="1" face="MS Sans Serif"> 
                    <input type="text" name="txtto" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                    </font> </td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtpoints" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                </tr>
                <tr> 
                  <td width="25%" align="center"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Range 
                    4</font></b> </font></td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtfrom" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                  </td>
                  <td width="25%" align="center"> <font size="1" face="MS Sans Serif"> 
                    <input type="text" name="txtto" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
                    </font> </td>
                  <td width="25%" align="center"> 
                    <input type="text" name="txtpoints" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" style="text-align:right">
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
<br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="3">
          <tr valign="top"> 
            <td height="0"> 
              <input type="button" name="cmdok" value="OK" class="buttonStyle" onClick="closeme()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
