<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror/>

<%
String strNCGTCFg=Helper.correctNull((String)session.getAttribute("strncgtcflag")).trim();
String strncgtcbankscheme=Helper.correctNull((String)session.getAttribute("strncgtcbankscheme")).trim();
out.println(strNCGTCFg);
out.println(strncgtcbankscheme);
%>

<html>
<head>
<title>Setup-Organization</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setorg.js">
</script>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript1.2"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strNCGTCFg="<%=strNCGTCFg%>";
var strncgtcbankscheme="<%=strncgtcbankscheme%>";
</script>
<script>
function doNew()
{
	enableButton(true,true,false,false,true,false);
	document.forms[0].hidAction.value="new";
		
}
function doEdit()
{
	enableButton(true,true,false,false,true,false);
	document.forms[0].hidAction.value="edit";
}
function doSave()
{
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidBeanMethod.value="updateScreenData";
			document.forms[0].hidBeanGetMethod.value="";
			document.forms[0].hidBeanId.value="setglpoptions";
			document.forms[0].hidSourceUrl.value="/action/setscreens.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		
		
}
function enableButton(newBut,editBut,appBut,canBut,delBut,helpBut)
{
	document.forms[0].cmdadd.disabled = newBut;
	document.forms[0].cmdedit.disabled = editBut;
	document.forms[0].cmdsave.disabled = appBut;
	document.forms[0].cmdcancel.disabled = canBut;
	document.forms[0].cmddel.disabled = delBut;
	document.forms[0].cmdhelp.disabled = helpBut;
}
function doDelete()
{
		if (ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="del";
			document.forms[0].hidBeanMethod.value="updateScreenData";
			document.forms[0].hidBeanGetMethod.value="";
			document.forms[0].hidBeanId.value="setglpoptions";
			document.forms[0].hidSourceUrl.value="/action/setscreens.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}	

}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		enableButton(false,true,true,true,true,false);
		
		
	}	
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
 function callOnload()
 {	
	enableButton(false,false,true,true,false,false);
	if((strncgtcbankscheme=="069" || strncgtcbankscheme=="69") && strNCGTCFg=="N")
	{
		alert("Please Fill the KBL NCGTC page");
		return;
	}
	else
	{
		
		document.all.ifrm.src="<%=ApplicationParams.getAppUrl()%>action/ifr_screen.jsp?hidBeanId=setglpoptions&hidBeanMethod=&hidBeanGetMethod=getScreenData";
	}
}
//-->
</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</style>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" link="#000000" vlink="#000000" alink="#FF3300" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload ="callOnload()">

<form name="org" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr> 
      <td valign="top" colSpan=5>
	  <jsp:include page="../share/help.jsp" flush="true"/> 
	
	  <jsp:include page="../share/menus.jsp" flush="true"/> 

		</td>
	    </tr>
 		</table>		
      </td>
    </tr>
 </table>
<br> <br> <br> <br>
  <div align="center"> 
    <table >
     <tr>
      	<td colspan="2"><font size="1" face="MS Sans Serif">Screen Module</font></td>
           <td width="40%"> <font size="1" face="MS Sans Serif"> 
              <select name ="sel_scrmod">
               <option value="1">Retail</option>
               <option value="2">Corprate</option>
               <option value="3">Tertiary</option>
              </select>
        </font></td>
        </tr>
      <tr>
      	<td colspan="2"><font size="1" face="MS Sans Serif">Screen Name</font></td>
           <td width="40%"> <font size="1" face="MS Sans Serif"> 
               <input type="text" name="txtscr_name" size="40" maxlength="20" onKeyPress="notAllowSplChar()">
        </font></td>
        </tr>
        <tr>
        <td colspan="2"><font size="1" face="MS Sans Serif">Screen JSP Page Name</font></td>
           <td width="40%"> <font size="1" face="MS Sans Serif"> 
 				<textarea name="txtmsg_jspname" cols="40" rows="3" onKeyPress="notAllowSplChar();textlimit(this,49)" onKeyUp="textlimit(this,49)"></textarea>
        </font></td>
        </tr>
        <tr>
        <td colspan="2"><font size="1" face="MS Sans Serif">Screen Sequence Number</font></td>
           <td width="40%"> <font size="1" face="MS Sans Serif"> 
               <input type="text" name="txtseq_number" size="20" maxlength="40"  onKeyPress="notAllowSplChar()">
        </font></td>
        </tr>
        <tr>
         <td colspan="2"><font size="1" face="MS Sans Serif">Screen Image</font></td>
           <td width="40%"> <font size="1" face="MS Sans Serif"> 
             <textarea name="txtmsg_scrimage" cols="40" rows="3"  onKeyPress="notAllowSplChar();textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea>
        </font></td>
      </tr>
    </table>
     <table width="15%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
      <tr> 
        <td> 
          <table width="77" border="0" cellspacing="0" cellpadding="3" align="center">
            <tr> 
              <td valign="top"> 
                <input type="button" name="cmdadd" value="New" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doNew()">
              </td>
              <td> 
                <input type="button" name="cmdedit" value="Edit"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick ="doEdit()">
              </td>
              <td valign="top"> 
                <input type="button" name="cmdsave" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick ="doSave()">
              </td>
              <td> 
                <input type="button" name="cmdcancel" value="Cancel" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick = "doCancel()">
              </td>
              <td> 
                <input type="button" name="cmddel" value="Delete"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doDelete()">
              </td>
              <td> 
                <div align="center"> 
                  <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;cursor:help" onClick="dohlp()">
                </div>
              </td>
              <td valign="top"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onclick = "doClose()">
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
    <td>
	      <table  width="100%" border="0" cellpadding="5"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" cellspacing="1">
            <tr> 
              <td width="5%" ></td>
              <td width="30%" >Screen Module</td>
              <td width="30%">Screen Name</td>
              <td width="35%">Sequence Number</td>
            </tr>
 </table>
	
	</td>
  </tr>
  <tr>
    <td><iframe id="ifrm"  width="100%"  height=300 > </iframe> </td>
  </tr>
</table>
    
    <br>
   
  </div>
  
 <input type="hidden" name="hidAction">
<input type=hidden name="hidBeanId" value="setglpoptions">
<input type=hidden name="hidBeanMethod"  >
<input type=hidden name="hidBeanGetMethod" >
<input type=hidden name="hidSourceUrl" value=>
 <input type="hidden" name="scrId">

</form>
</body>
</html>
