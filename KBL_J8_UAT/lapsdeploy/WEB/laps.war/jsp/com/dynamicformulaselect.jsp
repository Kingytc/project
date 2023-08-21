<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String strvalue="";
//strvalue =request.getParameter("val");
//String par =Helper.correctNull((String)request.getParameter("par"));
%>
<HTML>
<HEAD>
<TITLE> List Of  </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdadd.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdapply.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;

}


function show_submit()
{
var val="";
var id="";

if (document.forms[0].cho_rate.value != "")
	{
	val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;

	id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
	
			
			window.opener.document.forms[0].formula.value = val;	
			window.opener.document.forms[0].formulano.value = id;
			
						
		window.close();
}

 else 
	{
		alert("Select a value");
		return;
	}

}

function call_page()
{
	window.close();
	
}

</script>
</HEAD>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="selection" method="post" action="">
    
  <table border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" width="300" align="center">
    <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr bgcolor="#71694F"> 
              <td colspan="2"><font color="#FFFFFF"><b><font size="2" face="MS Sans Serif">
               Select  </font></b></font></td>
            </tr>
			<tr> 
                                <td align=center> <font size="1" face="MS Sans Serif"> 
                                  
              <select name="cho_rate" size=15 style="width:400" >
                <option value = "0">----Deselect-----</option>
                                    <laps:comdynamicformula /> 
									
								</select>
                                  </font></td>
                              </tr></table></td></tr></table>
							  <br>
							  
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
	<td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top">
            <td width="0">
				<input type="button" name="cmdok" value="OK" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="show_submit()">
            </td>
			<td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="javascript:window.close()">
              </div>
            </td>
			</tr>
        </table>
      </td>
    </tr>
  </table>
			
</form>
<INPUT TYPE="hidden" name="val" value="category">
</BODY>
</HTML>
