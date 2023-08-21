<%@include file="../share/directives.jsp"%>
<HTML>
<HEAD>
<TITLE>Laps Corporate Navigation</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1"> 
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
<form name="navigation" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
  <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
     <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
          <tr> 
            <td> 
              <TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
              	<%if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A"))){%>
              	<tr>
              		<td>&nbsp;</td>
              	</tr>
             	<TR>            
                <TD class="menubackflow">
                    <A HREF="javascript:callFunction('combstmastersearch.jsp')">Customer Information</A> 
                </TD>                   
                </TR>
                 <%} %>
                <TR> 
                  <TD class="menubackflow">
                    <A HREF="javascript:callFunction('combstsearch.jsp')">Broad Terms of Proposal</A>
                  </TD>
                </TR>
                </TABLE>
              </td>
             </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
    </tr>
        </table>
  <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</BODY>
</HTML>
