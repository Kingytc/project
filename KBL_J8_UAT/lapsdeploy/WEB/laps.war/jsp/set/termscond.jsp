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
      <td valign="bottom"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="Times New Roman" size="3"><b><font face="MS Sans Serif">-&gt;</font> 
        <i>Setup</i></b></font> <font face="MS Sans Serif">-&gt;</font> </b></font></i><font face="Times New Roman" size="3"><b> 
        </b></font><i> Terms and Conditions</i></b></td>
      <td width="280">&nbsp; </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="400" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td align="right" colspan="5">&nbsp; </td>
                      </tr>
                      <tr> 
                        <td width="18%"><font size="1" face="MS Sans Serif">Select 
                          Existing Terms </font></td>
                        <td width="17%"> 
                          <select name="selectterm" onChange="getValue()" >
                            <laps:settermcond/>
                          </select>
                        </td>
                        <td width="22%" align="center">&nbsp;</td>
                        <td width="16%"><font size="1" face="MS Sans Serif">Terms 
                          Description</font></td>
                        <td width="27%"> 
                          <input type="text" name="txttrmdesc" size="25" maxlength="50" readOnly onKeyPress="check();notAllowSingleQuote()" value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("terms_desc"))%>">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"><font size="1" face="MS Sans Serif"><b>Terms 
                    and Conditions</b></font></td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
                      <tr> 
                        <td> 
                          <textarea name="txttrmcontent" wrap="VIRTUAL" cols="100" rows="25" readOnly  ><%=Helper.correctDoubleQuotesHtml((String)hshValues.get("terms_content"))%>
</textarea>
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
              <input type="button" name="cmddelete" value="Delete" onClick="onDelete()" class="buttonStyle">
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
  <input type="hidden" name="hiddesc">
<input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
</form>
</body>
</html>
