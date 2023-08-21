<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<title>Terms and Conditions</title>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/termscond.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";

var strtermid = "";
var strtermdesc ="";
var strtermcont="";

 
</script>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
	          <jsp:include page="../share/help.jsp" flush="true"/>  
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom"><b><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="MS Sans Serif">-&gt;</font> <i>Global Options</i></b></font></b></td>
      <td width="280">&nbsp; </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td align="right"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="75%" valign="bottom"> 
              <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr> 
                  <td width="35%" align="center" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><font color="#000000"><a href="#" class="blackfont">Organisation</a></font></b></font></td>
                  <td width="30%" align="center" bgcolor="#EEEAE3"><b><font size="1" face="MS Sans Serif"><a href="javascript:callAudit()" class="blackfont">Audit 
                    Trail </a></font></b></td>
                  <td width="30%" align="center" bgcolor="#71694F"> <b><font  color="#FFFFFF">State 
                    Master </font></b></td>
                </tr>
              </table>
            </td>
            <td width="25%">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="400" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" align="center"> <br>
        <br>
        <br>
        <br>
        <table width="60%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="10">
                      <tr> 
                        <td width="29%"><font size="1" face="MS Sans Serif">Select 
                          State</font></td>
                        <td width="71%"> 
                          <select name="selectterm" onChange="getValue()" >
                            <laps:settermcond/> 
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="29%"><font size="1" face="MS Sans Serif">State 
                          Name </font></td>
                        <td width="71%"> 
                          <input type="text" name="txttrmdesc" size="25" maxlength="50" readOnly onKeyPress="check();notAllowSplChar()" value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("terms_desc"))%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="29%"><font size="1" face="MS Sans Serif">Country</font></td>
                        <td width="71%"> 
                          <input type="text" name="txttrmdesc2" size="25" maxlength="50" readOnly onKeyPress="check();notAllowSplChar()" value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("terms_desc"))%>">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit"  onClick="onEdit()" class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" onClick="doSave()" class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="onCancel()" class="buttonStyle">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" onClick="doHelp('products.htm')" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </form>
</body>
</html>
