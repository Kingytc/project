<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%

%>

<html>
<head>
<title>National Portal Inbox - CBS ID Fetch</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{

}

function callSearch()
{
	document.all.isearch.src=appURL+"action/psb59SearchResults.jsp";
	
	//alert(document.forms[0].txtsearch.value);
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style>
DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
a:hover {color: #FF6600}
</style>
</head>
<body onload="">
<form name="" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"><br>
    <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
      <tr> 
        <td valign="top"> 
          <div align="left"></div>
          <table width="100%" border="0" cellspacing="0" cellpadding="10" height="100%">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="2" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                  <tr> 
                    <td valign="top">
                      <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                    <tr> 
                                      <td colspan="9" width="65%"><font size="1" face="MS Sans Serif"><b>Search 
                                        By</b> </font></td>
                                      <td width="10%"><font size="1" face="MS Sans Serif">Customer ID 
                                        </font> </td>
                                      <td width="10%"> 
                                        <input type="text" name="txtsearch" size="15" maxlength="15" onKeyPress="allowInteger('this')" onPaste="return true">
                                        <input type="hidden" name="hid_sectr" value=""></td>             
                                       
                                      <td width="10%"> 
                                        <input type="button" name="cmdOK" value="Search" style="width:75" style="background-color:#ee6b2f" onClick="javascript:callSearch()" >
                                      </td>
                                      <td width="5%">&nbsp;</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="13"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                          <tr> 
                                            <td width="31%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Applicant 
                                                Name</font></font></b></div>
                                            </td>
                                            <td width="18%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Customer ID </font></font></b></div>
                                            </td>
                                            <td width="31%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Home Branch 
                                                Name</font></b></div>
                                            </td>
                                          </tr>
                                        </table>
                                      </td>
                                    </tr>
                                    <tr> 
                                      <td colspan="13"> 
                                        <div align="left"><iframe   id="isearch" width="100%" height="340"  src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"></iframe> 
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
                      <br>
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
    <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3">
            <tr valign="top">
              <!-- <td height="2">
                <input type="reset" name="getforms2" value="Reset" style="width:80" class="buttoncolor" onClick="resetme()">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
                </div>
              </td>-->
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callclose()">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidUserId" value="">

</form>
</body>
</html>