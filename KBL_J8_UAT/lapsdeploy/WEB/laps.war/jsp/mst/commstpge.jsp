<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<HTML>
<HEAD>
<TITLE>Laps Corporate Navigation</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1"> 
<style  type="text/css">
#inner
		{
		margin:75px 10px 18px 10px;
		border-top:#e12500 10px solid;
		border-bottom:#e12500 10px solid;
		background-color:#fff;
		}
.btn
		{
		height:22px;
 		width:50px;
		border:#ffffff 1px solid;
		background-color:#2d6193;
	    color:#fff;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:.9em;
		margin:1px 2px 8px 4px;
		font-weight:bold;
		}
</style>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,pagetype,getmethod)
{
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</HEAD>

<BODY BGCOLOR="#FFFFFF" TEXT="#000000" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">
<form name="navigation">
<div id="inner">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
          <tr> 
            <td> 
              <TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="4" ALIGN="center">
             	<TR> 
                  <TD HEIGHT="0"><B> 
                    <A HREF="javascript:txtLoad('Corporate & SME');callFunction('combstmastersearch.jsp','NEW')" CLASS="blackfont">Customer Information</A> 
                    </B></TD>
                </TR>
                <TR> 
                  <TD HEIGHT="0"><B> 
                    <A HREF="javascript:txtLoad('Corporate & SME');callFunction('combstsearch.jsp','NEW')" CLASS="blackfont">New Broad Sanction Terms</A> 
                    </B></TD>
                </TR>
                <TR> 
                  <TD HEIGHT="0"><B> 
                    <A HREF="javascript:txtLoad('Corporate & SME');callFunction('combstsearch.jsp','EXI')" CLASS="blackfont">Existing Broad Sanction Terms</A> 
                    </B></TD>
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
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>
        <table width="10%" border="0" cellspacing="0" cellpadding="0" align="right" >
          <tr align="center" bgcolor="#FFFFFF"> 
            <td width="20%"><input name="cmdClose" type="button" class="btn" value="Close" onclick="callFunction('mainnav.jsp','','')"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
 
<input type="hidden" name="hidPage">
<input type="hidden" name="hidPageType" value="">
<input type="hidden" name="hidBeanId" value="modsancterms"/>
<input type="hidden" name="hidBeanGetMethod"/>
</form>
</BODY>
</HTML>
