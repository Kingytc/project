<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="qis"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String strvalue="",val="",type="";
type=Helper.correctNull(request.getParameter("select_type"));
strvalue=request.getParameter("appno");
val=request.getParameter("val");
%>
<html>
<head>
<title>Quarterly Interest Statement</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
DIV.cellContainer {	  width: 100%; height: 75;  overflow: auto;}
</style>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399;border-style: groove}
a:hover {  color: #FF3300}
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";

function run_report()
{

	var count=0,j=0;
	for (i=0;i<document.forms[0].select_type.length;i++)
	{

		if (document.forms[0].select_type.options[i].selected == true)
			{
			j=j+1
			document.forms[0].qis[j-1].value=i+1;
			}
    }
	document.forms[0].len.value=j;
	qis1=document.forms[0].qis[0].value;
	qis2=document.forms[0].qis[1].value;
	qis3=document.forms[0].qis[2].value;
	qis4=document.forms[0].qis[3].value;
	appno=document.forms[0].hidappno.value;
	document.forms[0].action=appURL+"controllerservlet";
var purl = appURL+"controllerservlet?appno="+appno+"&id="+j+"&hidBeanId=QisBean&hidBeanMethod=showReport&hidSourceUrl=/action/run_report.jsp&qis1="+qis1+"&qis2="+qis2+"&qis3="+qis3+"&qis4="+qis4;

	var title1= "ListofRating";
	var prop = "scrollbars=yes,width=800,height=550,top=0,left=0";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	//prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title1,prop);
	
}

function onClose(url)
{
		
	if (ConfirmMsg(100))
		{
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
		}
	

}

</script>
</head>
<body bgcolor="#EEEAE3" text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="documentsfrm" method="post" >
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
 		</table>		
      </td>
    </tr>
 </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Quarterly 
        Interest Statement</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" height="133"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td height="7" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="4" height="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td colspan="10" valign="top">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="10" valign="top"> 
                          <table width="50%" border="1" cellspacing="0" cellpadding="10" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                                  <tr> 
                                    <td align="center">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td align="center"><font size="1" face="MS Sans Serif">Select 
                                      Quarter for Quarterly Interest Statement 
                                      </font></td>
                                  </tr>
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <select name="select_type" size="12" multiple style="width:200">
											<qis:qistag /> 
                                      </select>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top" align="center">&nbsp;</td>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td height="21"> 
        <table width="100%" cellspacing="0" cellpadding="2" align="center">
          <tr valign="top"> 
            <td width="9%"> 
              <div align="center"> 
                <input type="button" name="cancel" value="Run Report" onClick="run_report()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80">
              </div>
            </td>
            <td width="9%"> 
              <input type="button" name="help" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
            </td>
            <td width="10%"> 
              <div align="center"> 
                <input type="button" name="close" value="Close" onClick="onClose('qismain.jsp')" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
		<input type=hidden name="hidBeanId" >
			<input type=hidden name="hidBeanMethod"  >
			<input type=hidden name="hidBeanGetMethod" >
			<input type=hidden name="hidSourceUrl">
			<input type=hidden name="hidappno" value="<%=strvalue%>">
			<input type=hidden name="hidval">
			<input type=hidden name="id">
			<input type=hidden name="qis">
			<input type=hidden name="qis">
			<input type=hidden name="qis">
			<input type=hidden name="qis">
			<input type=hidden name="len">
</form>
</body>
 </html>
  