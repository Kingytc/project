<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<%
%>
<html>
<head>
<title>Personal - Loan History Of Applicant</title>
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
a:hover {  color: #FF6600}
</STYLE>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/perloanhist.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menus.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
var appURL = "<%=ApplicationParams.getAppUrl()%>";
//-->
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onLoad="">
<jsp:include page="../share/help.jsp" flush="true"/> 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr> 
          <td valign="top" colSpan=5> 
            <jsp:include page="../share/menus.jsp" flush="true"/> 
          </td>
        </tr>
        <tr>
          <td valign="top" colSpan=5><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
            -&gt; Retail </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b>-&gt; 
            </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
            <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i><%= (String)session.getAttribute("pageType")%></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></td>
        </tr>
      </table>		
      </td>
    </tr>
 </table>
<form name="loanHistory" method="post">
  <div align="center">
<table width="100%" border="1" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
      <tr> 
        <td valign="top"> 
          <div align="left"></div>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
            <tr> 
              <td> 
                <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                  <tr> 
                    <td valign="top"> 
                      <table width="57%" border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td width="48%">&nbsp;</td>
                          <td width="0%">&nbsp;</td>
                          <td width="21%">&nbsp;</td>
                          <td width="0%">&nbsp;</td>
                          <td width="19%">&nbsp;</td>
                          <td width="1%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="48%"> 
                            <div align="center"><font size="1" face="MS Sans Serif">Applied 
                              for retail loan before?</font></div>
                          </td>
                          <td width="0%"> <font size="1" face="MS Sans Serif"> 
                            <input type="radio" name="radLoan" value="Y" style="border-style:none" onClick="callOld()">
                            </font></td>
                          <td width="21%"><font size="1" face="MS Sans Serif">Yes</font></td>
                          <td width="0%"> <font size="1" face="MS Sans Serif"> 
                            <input type="radio" name="radLoan" value="N" style="border-style:none" onClick="callNew()">
                            </font></td>
                          <td width="19%"><font size="1" face="MS Sans Serif">No</font></td>
                          <td width="1%"> <font size="1" face="MS Sans Serif"> 
                            </font></td>
                        </tr>
                      </table>
                      <div align="center"><br>
                        <table width="100%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td width="50%" valign="top"> 
                              <table width="50%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"align="center">
                                <tr> 
                                  <td valign="top"> 
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                      <tr> 
                                        <td width="50%" valign="top"> 
                                          <table width="100%" border="0" cellspacing="0" cellpadding="4">
                                            <tr> 
                                              <td colspan="2"><font size="1" face="MS Sans Serif"><b>Search 
                                                By</b> </font></td>
                                              <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr> 
                                              <td width="8%"><font size="1" face="MS Sans Serif"> 
                                                <input type="radio" name="radSearch" value="A" style="border-style:none" disabled onClick="searchByAppno()">
                                                </font></td>
                                              <td width="41%"><font size="1" face="MS Sans Serif">Application 
                                                No.</font></td>
                                              <td width="8%"><font size="1" face="MS Sans Serif"> 
                                                <input type="radio" name="radSearch" value="P" style="border-style:none" disabled onClick="searchByPanno()">
                                                </font></td>
										      <td width="43%"><font size="1" face="MS Sans Serif">PAN/GIR 
                                                No.</font></td>
                                            </tr>
                                            <tr align="center"> 
                                              <td colspan="4"> 
                                                <input type="text" name="txtSearch" size="35" disabled onKeyPress="allowEntry()" maxlength="25">
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="50%" align="right"> 
                                          <table width="100%" border="0" cellspacing="0" cellpadding="4">
                                            <tr> 
                                              <td colspan="4"><font size="1" face="MS Sans Serif"><b>Check 
                                                the details you want to retain</b></font></td>
                                            </tr>
                                            <tr> 
                                              <td width="5%"> 
                                                <input type="checkbox" name="chkApp" value="Y" disabled style="border-style:none" checked>
                                              </td>
                                              <td width="45%"><font size="1" face="MS Sans Serif">Primary 
                                                Applicant Details</font></td>
                                              <td width="5%"> <font size="1" face="MS Sans Serif"> 
                                                <input type="checkbox" name="chkColl" value="Y" disabled style="border-style:none">
                                                </font></td>
                                              <td width="45%"><font size="1" face="MS Sans Serif">Collateral 
                                                Details </font></td>
                                            </tr>
                                            <tr> 
                                              <td width="5%"><font size="1" face="MS Sans Serif">
                                                <input type="checkbox" name="chkCoApp" value="Y" disabled style="border-style:none" checked>
                                                </font> </td>
                                              <td width="45%"><font size="1" face="MS Sans Serif">Co-Applicant 
                                                Details </font></td>
                                              <td width="5%"> <font size="1" face="MS Sans Serif"> 
                                                <input type="checkbox" name="chkFin" value="Y" disabled style="border-style:none">
                                                </font></td>
                                              <td width="45%"><font size="1" face="MS Sans Serif">Financial 
                                                Details </font></td>
                                            </tr>
                                            <tr> 
                                              <td width="5%">&nbsp; </td>
                                              <td width="45%">&nbsp;</td>
                                              <td colspan="2"><font size="1" face="MS Sans Serif"></font></td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="50%" align="center" height="32"> 
                                          <input type="button" name="cmdOK" value="OK" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" disabled onClick="callApply('New')"> 
                                          <input type="button" name="cmdCancel" value="Cancel" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" disabled onClick="callCancel()">
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top"> 
                              <table width="50%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                                <tr> 
                                  <td height="30"> 
                                    <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                      <tr> 
                                        <td> 
                                          <div align="center"><font size="1" face="MS Sans Serif" color="#CC0000">To 
                                            update internet applications click 
                                            the button below</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td> 
                                          <div align="center"><font size="1" face="MS Sans Serif"> 
                                            <input type="button" name="inetAppln" value="Internet Appln." style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;font-weight:bold;width:100" disabled>
                                            </font> </div>
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
    <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="2">
            <tr valign="top"> 
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" 
onClick="doHelp('pernew.htm')">
                </div>
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>

	<input type="hidden" name="hidBeanGetMethod" >
	<iframe  height="0" width="0" id="hidframe" frameborder=0 style="border:0">  </iframe>

</form>
</body>
</html>
