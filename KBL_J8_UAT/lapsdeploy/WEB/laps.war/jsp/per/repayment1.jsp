<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%

 String val =request.getParameter("index");
//out.println(val);
%>

<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>


<script>
function loadval(val)
{
var index = val;
var index1;
var monthfrom = document.forms[0].monthfrom.value; 
var monthto = document.forms[0].monthto.value; 
var returnval;
//window.opener.document.forms[0].hidmonthsfrom.value = monthfrom;
//window.opener.document.forms[0].hidmonthsto.value = monthto;
//window.opener.document.forms[0].hidtotalamt.value = document.forms[0].atctotalamt.value;
returnval = monthfrom+","+monthto+","+document.forms[0].atctotalamt.value;

window.returnValue = returnval;
for(var i=monthfrom;i<=monthto;i++)
//{
//index1 = i;
//alert(index1);
//}

window.close();

}


function dohlp(select_loc)
{
//window.opener.document.forms[0].org_name.value=document.forms[0].select_loc.value;
	//window.returnValue =document.forms[0].select_loc.value;
if (select_loc.options[select_loc.selectedIndex].value == 'S') {

		alert("Please Select Location");

} 
else {
	window.returnValue =select_loc.options[select_loc.selectedIndex].value;
	
	window.close();	
}
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="">
<form name="appform" method="post" action="">
	<br>
	<table width="90%" align="center" border="1" cellpadding="0" cellspacing="0">
		<tr > 
		
		
     <td >
     
	<table width="100%" align="center" border="0" cellpadding="3" cellspacing="0">
		<tr>
		 <td width="50%"  align="center"><font size="1" face="MS Sans Serif">Month from </font></td>
		  <td width="10"> 
             <input name="monthfrom" type="text" value="" size="8">
             </td>
		</tr>
		
		<tr > 
     <td width="50%"  align="center"><font size="1" face="MS Sans Serif">Month to</font>
       </td>
    <td width="10"> 
             <input name="monthto" type="text" value="" size="8">
             </td>
       </tr>
       <tr > 
     <td width="50%"  align="center"><font size="1" face="MS Sans Serif">Total Amount</font>
       </td>
    <td width="10"> 
             <input name="atctotalamt" type="text" value="" size="8">
             </td>
       </tr>
      
</table>

</td>
    </tr>
</table>
<br>

<table width="0%" align="center" border="1" cellpadding="3" cellspacing="0">
<tr>
<%

 String val1 =request.getParameter("index");

%>
<td height="0" align="center"> 
                <input type="button" name="cmdHelp" value="Ok" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="loadval(<%=val1%>)">
            
                  <input type="button" name="cmdClose" value="Close" onClick="window.close()" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
         </td>  
      </tr>
      </table>
  </form>
</body>
</html>