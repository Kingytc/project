<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<html>
<head>
<title>Product - Interest Rates</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}

-->
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="myfrm" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
            </td>
          </tr>
          <tr> 
            <td valign="top" colSpan=5><font face="Times New Roman" size="3"><b><i>Home 
              </i><font face="MS Sans Serif">-&gt;</font> <i>Products </i><font face="MS Sans Serif">-&gt;</font> 
              <i>Interest Rates</i></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="10" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="400">
    <tr> 
      <td> 
        <table width="70%" border="0" cellspacing="0" cellpadding="8" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center">
                <tr> 
                  <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr id="categ"> 
                        <td width="15%" id="catlab" align="center"><font size="1" face="MS Sans Serif">Product</font></td>
                        <td width="85%"> 
                          <input type="text" name="txtcat_name" size="48" maxlength="50">
                          <a href="#" onClick="showProduct()" class="blackfont"><b>?</b></a> 
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="5">
                      <tr bgcolor="#71694F" align="center"> 
                        <td width="10%"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">S. 
                          No</font></b></td>
                        <td colspan="2"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Term</font></b><font size="1" face="MS Sans Serif"></font></td>
                        <td width="25%"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Interest 
                          Rate</font></b></td>
                      </tr>
                      <tr> 
                        <td width="10%">&nbsp;</td>
                        <td width="25%" align="center"><font size="1" face="MS Sans Serif">From</font></td>
                        <td width="25%" align="center"><font size="1" face="MS Sans Serif">To</font></td>
                        <td width="25%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="10%" align="center"><font size="1" face="MS Sans Serif">1</font></td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield6" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield11" size="15">
                        </td>
                      </tr>
                      <tr> 
                        <td width="10%" align="center"><font size="1" face="MS Sans Serif">2</font></td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield2" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield7" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield12" size="15">
                        </td>
                      </tr>
                      <tr> 
                        <td width="10%" align="center"><font size="1" face="MS Sans Serif">3</font></td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield3" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield8" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield13" size="15">
                        </td>
                      </tr>
                      <tr> 
                        <td width="10%" align="center"><font size="1" face="MS Sans Serif">4</font></td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield4" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield9" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield14" size="15">
                        </td>
                      </tr>
                      <tr> 
                        <td width="10%" align="center"><font size="1" face="MS Sans Serif">5</font></td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield5" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield10" size="15">
                        </td>
                        <td width="25%" align="center"> 
                          <input type="text" name="textfield15" size="15">
                        </td>
                      </tr>
                    </table>
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
  <br>
  <table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td height="21"> 
        <table width="100%" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 
            <td width="9%"> 
              <div align="center"> 
                <input type="button" name="butnew" value="New" class="buttonStyle">
              </div>
            </td>
            <td width="9%"> 
              <div align="center"> 
                <input type="button" name="butedit" value="Edit" class="buttonStyle">
              </div>
            </td>
            <td width="12%"> 
              <div align="center"> 
                <input type="button" name="butapply" value="Save" class="buttonStyle">
              </div>
            </td>
            <td width="9%"> 
              <div align="center"> 
                <input type="button" name="butcancel" value="Cancel" class="buttonStyle">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="butdelete" value="Delete" class="buttonStyle">
              </div>
            </td>
            <td width="9%"> 
              <input type="button" name="buthelp" value="Help" class="buttonHelp" onClick="doHelp('products.htm#categorymaster')">
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="butclose" value="Close" class="buttonClose">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
</form>
<br>
</body>
</html>

