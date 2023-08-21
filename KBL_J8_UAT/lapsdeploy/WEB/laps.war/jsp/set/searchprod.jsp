<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean  id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");	
ArrayList arryCol;
%>

<html>
<head>
<title>Renewal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">

DIV.cellContainer {	
  width: 100%; height: 240;
  overflow: auto;
}
a:hover {  color: #FF6600}
</style>

<SCRIPT LANGUAGE="JavaScript">
var appurl="<%=ApplicationParams.getAppUrl()%>";
/*
*	Function called to getAll the products
*/
function getProducts()
{
	document.forms[0].hidGetProducts.value="Y";
	document.forms[0].hidBeanId.value="searchprod";
	document.forms[0].hidSourceUrl.value="laps/action/searchprod.jsp";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/searchprod.jsp"
	document.forms[0].submit();
}

/*
*	Function called to get New Products
*/
function getNew()
{
	document.forms[0].prd_code.value="New";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setproducts.jsp";
	document.forms[0].submit();
}

/*
*	Function called to get a particular product
*/
function callLink(pcode)
{
	document.forms[0].prd_code.value=pcode;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setproducts.jsp";
	document.forms[0].submit();
}
/*
*	Function called to close 
*/
function callClose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

/*
*	Function called to getHelp
*/
function callHelp()
{
	alert("Help not avaliable");
}
</SCRIPT>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</style>
</head>

<body bgcolor="#F4F4FF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="renew" method="post" action="">
  <br>
  <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#E8E8FF"><font face="Times New Roman" size="3"><b><i>Products</i></b></font></td>
    </tr>
    <tr> 
      <td> 
        <table width="25%" border="0" cellspacing="1" cellpadding="1" align="right">
          <tr> 
            <td width="33%" id="showbtntd" style="visibility:hidden"> 
              <input type="button" name="Button2332" value="Show Menu" style="background-color:#605FAF;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="hidefunc();MM_timelineGoto('Timeline1','15')">
            </td>
            <td width="34%" id="hidebtntd" style="visibility:hidden"> 
              <div align="center"> 
                <input type="button" name="Button232" value="Hide Menu" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="showfunc();MM_timelineGoto('Timeline1','1')">
              </div>
            </td>
            <td width="33%" id="mainbtntd"> 
              <div align="right"> 
                <input type="button" name="Button23" value="Show Menu" style="background-color:#605FAF;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="hidefunc();MM_timelineGoto('Timeline1','15')">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="800" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F" bgcolor="#E4E2ED" >
    <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400" bordercolor="#FFFFFF" >
        <tr> 
          <td valign="top"> <br>
              <table width="95%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="38%">&nbsp;</td>
                  <td width="12%"> <font size="1" face="MS Sans Serif"> </font><font size="1" face="MS Sans Serif"> 
                    <input type="button" name="cmdGetAppln2" value="New" style="background-color:#4382C0;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60;font-weight:bold" onClick="getNew()" >
                    </font></td>
                  <td width="32%"> <font size="1" face="MS Sans Serif"> 
                    <input type="button" name="cmdGetAppln22" value="Get Products" style="background-color:#4382C0;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold"   onClick="getProducts()" >
                    </font></td>
                  <td width="18%">&nbsp;</td>
                </tr>
              </table>
              <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                <tr> 
                  <td height="20" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td colspan="3"><font size="1" face="MS Sans Serif">Select 
                          Products For View</font></td>
                        <td width="33%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                                  <tr bgcolor="#003399"> 
                                    <td width="18%"> 
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif">ProducDescription</font></div>
                                    </td>
                                    <td width="13%">
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif"> 
                                        Category</font>.</div>
                                    </td>
                                    <td width="18%"> 
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif">Sub 
                                        Category </font></div>
                                    </td>
                                    <td width="16%"> 
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif">Range 
                                        From </font></div>
                                    </td>
                                    <td width="12%"> 
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif">Range 
                                        To </font></div>
                                    </td>
                                    <td width="12%"> 
                                      <div align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF">Product 
                                        Type </font></div>
                                    </td>
                                    <td width="11%"> 
                                      <div align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif">Save 
                                        Type </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="7" bgcolor="#FFFFFF"> 
                                      <div class="cellContainer"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
                                          <% 
										if(arryRow!=null)
										{
										for(int i=0;i<arryRow.size();i++)
											{
											arryCol=(ArrayList)arryRow.get(i);
										%>
                                          <tr bgcolor="#EBEBEB"> 
                                            <td 
											width="18%"><font size="1" face="MS Sans Serif"><a href="javaScript:callLink(<%=Helper.correctNull((String)arryCol.get(0))%>)" > 
                                              <%=Helper.correctNull((String)arryCol.get(2)
											)%></a> </font></td>
                                            <td width="14%" bgcolor="#EBEBEB" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(8))%></font></td>
                                            <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(7))%></font></td>
                                            <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(4))%></font></td>
                                            <td width="12%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(5))%></font></td>
                                            <td width="12%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(3))%></font></td>
                                            <td width="10%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)arryCol.get(6))%></font></td>
                                          </tr>
                                          <%
											}
										}
										  %>
                                        </table>
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
<br>
<table width="12%" border="0" cellspacing="0" cellpadding="0" height="20" bordercolorlight="#EBEBF8" bordercolordark="#82829F" align="center" >
  <tr> 
    <td> 
      <table width="0%" border="0" cellspacing="0" cellpadding="3" bgcolor="#E4E2ED">
        <tr valign="middle"> 
          <td width="52%"> 
            <div align="center"> 
                <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callHelp()">
            </div>
          </td>
          <td width="48%"> 
            <div align="center"> 
                <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callClose()">
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<input type="hidden" name="prd_code">
<input type="hidden" name="hidGetProducts" >
<input type="hidden" name="hidBeanId" >
<input type="hidden" name="hidSourceUrl" >
<input type="hidden" name="hidBeanGetMethod" >
</form>
</body>
</html>
