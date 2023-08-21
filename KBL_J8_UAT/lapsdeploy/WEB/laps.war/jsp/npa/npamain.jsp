<%@ page import="com.sai.laps.helper.*" %>
<html>
<head>
<title>NPA Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function menuOptionDivMouseDown (url)
		{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
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
<jsp:include page="../share/help.jsp" flush="true"/> 

<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>
<script language="JavaScript1.2">
function callPage(page)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
	document.forms[0].hidMethod.value="getNpaDefReport";
	//alert(document.forms[0].action);
	document.forms[0].submit();
}
function callNPAPage(page,tabname)
{
	var p="<%=ApplicationParams.getAppUrl()%>action/"+page+"	?hidBeanMethod=getData&hidBeanId=npaaction";
	document.forms[0].hidTabName.value=tabname;
	document.forms[0].action=p;
	document.forms[0].submit();
}

function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=450,left=60,top=40");
}
</script>
<form name="frmloanrpt">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr> 
      <td valign="top" colSpan=5>
	  <jsp:include page="../share/menus.jsp" flush="true"/> 

		</td>
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
                <fieldset style="width:260;height:177;background-color:#DEDACF"> 
                <legend><font size="1" face="MS Sans Serif"><b><font color="#CC3300">NPA Management</font></b></font></legend><br>
                <fieldset style="width:180;height:177" background-color:#E4E2ED"><br>
                <table width="81%" border="0" cellspacing="0" cellpadding="15">
                  <tr> 
                    <td><font size="1" face="MS Sans Serif"><b><a href="javascript:callPage('npasearch.jsp')" class="blackfont">NPA 
                      Master</a></b></font></td>
                  <tr> </tr>
                  <tr> 
                    <td><font size="1" face="MS Sans Serif"><b><a href="javascript:callNPAPage('npaactions.jsp','npaaction')" class="blackfont">NPA 
                      Actions </a></b></font></td>
                  </tr>
                  <tr> 
                    <td height="0"><font size="1" face="MS Sans Serif"><b><a href="javascript:callNPAPage('npaletters.jsp','npaletters')" class="blackfont">NPA 
                      Letters</a></b></font></td>
                  </tr>
                  <tr> 
                    <td height="0"><font size="1" face="MS Sans Serif"><b><a href="javascript:callPage('nparepnav.jsp')" class="blackfont">Reports</a></b></font></td>
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
                  <input type="button" name="Button23311237" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="doHelp('npa.htm')">
                </font></div>
            </td>
              <td width="46%"> 
                <div align="center"><font size="1" face="MS Sans Serif"> 
                  <input type="button" name="cmdexit" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callPage('corppge.jsp')">
                </font></div>
            </td>
          </tr>
        </table>
        </fieldset></td>
    </tr>
  </table></div>
     <input type="hidden" name="hidTabName" >
     <input type="hidden" name="hidMethod" >
</form>
</body>
</html>
