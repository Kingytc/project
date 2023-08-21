<%@ page import="com.sai.laps.helper.*" %>
<html>
<head>
<title>LAPS- Products </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
	 <script language="JavaScript1.2"> 
	 var appURL = "<%=ApplicationParams.getAppUrl()%>";
	 </script>
<script language="javascript">
 

function dohlp()     
{
  
}
function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowNPA";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	
}
function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callFunction1(page,bean,method)
{
	 
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
a:hover {  color: #CC0000}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<script language="JavaScript1.2">
/*if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}*/
</script>
<script language="JavaScript1.2">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].submit();
}
</script>
<form name="frmloanrpt">
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
          <tr>
            <td valign="top" colSpan=5><font face="Times New Roman" size="3"><b><i>Home 
              </i><font face="MS Sans Serif"> -&gt;</font> <i>Setup </i><font face="MS Sans Serif">-&gt;</font> 
              <i>Monitoring module</i> </b></font></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td>&nbsp;</td>
  </tr>
</table>
  <br>
  <br>
  <br>
  <table width="40%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
    <tr> 
    <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="0">
          <tr> 
            <td width="64%" height="0" valign="top"> <br>
              <center>
                <fieldset style="width:270;height:177;background-color:#DEDACF"> 
                <legend><font size="1" face="MS Sans Serif"><b><font color="#CC3300">MONITORING 
                MODULE </font></b></font></legend><br>
                <fieldset style="width:180;height:140" background-color:"#E4E2ED"><br>
                <table width="88%" border="0" cellspacing="0" cellpadding="15">
                  <tr> 
                    <td><font size="1" face="MS Sans Serif"><b> 
                      <a href="javascript:callWorkflow('setprdworkflowcommon.jsp')" class="blackfont"><font
					size="1" face="MS Sans Serif"><b>Flowpoints</b></font></a></b></font></td>
                  </tr>
                  
				  
				  
				 
				  
				  
				  
                </table>
                </fieldset> <br>  
                <br>
                </fieldset> 
              </center>
              <br>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
  <br>
  <div align="center">
    <table border="0" cellspacing="0" cellpadding="4" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
      <tr>
      <td height="22"><fieldset> 
          <table border="0" cellspacing="0" cellpadding="3" align="center">
            <tr>
              <td width="54%"> 
                <div align="center"><font size="1" face="MS Sans Serif"> 
                  <input type="button" name="Button23311237" value="Help" class="buttonHelp" onClick="dohlp()" >
                </font></div>
            </td>
              <td width="46%"> 
                <div align="center"><font size="1" face="MS Sans Serif"> 
                  <input type="button" name="cmdexit" value="Close" class="buttonClose" onClick="callPage('setupnav.jsp')">
                </font></div>
            </td>
          </tr>
        </table>
        </fieldset></td>
    </tr>
  </table></div>
 <input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidSourceUrl"> 
</form>
</body>
</html>
