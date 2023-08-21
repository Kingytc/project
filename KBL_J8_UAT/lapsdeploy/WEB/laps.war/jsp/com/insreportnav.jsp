<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />


<html>
<head>
<title>Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function callNew()
{
	document.forms[0].action=appUrl+"action/comappmaster.jsp";
	document.forms[0].submit();
}

function callOffline()
{
	document.forms[0].action=appUrl+"action/offline.jsp?fileid=companydtls";
	document.forms[0].submit();
}


function resetme()
	{
		document.forms[0].reset();
		document.all.result.src=appUrl+'action/blank.jsp';
	}

function doSearch()
{
	var appid="%";
	var appname="%";
	for(var k=0;k<2;k++)
	{
		if(document.forms[0].srchtype[k].checked)
		{
			if(document.forms[0].txtvalue.value == "")
			{
				ShowAlert(121,'Search Criteria');
				document.forms[0].txtvalue.focus();
				return false;
			}
		}
	}
	
	if(document.forms[0].srchtype[0].checked && document.forms[0].txtvalue.value!="" )
	{
		appname=document.forms[0].txtvalue.value;
	}
	if(document.forms[0].srchtype[1].checked && document.forms[0].txtvalue.value!="")
	{
		appid=document.forms[0].txtvalue.value;
	}
	document.all.result.src=appUrl+"action/insresult.jsp?hidBeanGetMethod=getApplicantList&comapp_id="+appid+"&comapp_companyname="+appname;
	
}

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/appmasternav.jsp";
		 document.forms[0].submit();
	 }
}

</script>
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onLoad="">
<form name="loanHistory" method="post">
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
          <tr>
            <td valign="top" colSpan=5><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
              -&gt; Commercial(Applicant Master)</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
              -&gt; Customer Master Details</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <div align="center"><br>
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
                      <div align="left"><font size="1" face="MS Sans Serif"><b>Customer 
                        Master Details</b></font><br>
                      </div>
                      <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="4">
                                    <tr> 
                                      <td colspan="2"><font size="1" face="MS Sans Serif"><b>Search 
                                        By</b> </font></td>
                                      <td colspan="6">&nbsp; </td>
                                    </tr>
                                    <tr> 
                                      <td width="3%"> 
                                        <input type="radio" name="srchtype" value="radiobutton"  style="border-style:none" >
                                      </td>
                                      <td width="15%"><font face="MS Sans Serif" size="1">Company 
                                        Name</font></td>
                                      <td width="2%"><font size="1" face="MS Sans Serif"> 
                                        <input type="radio" name="srchtype" value="radiobutton" style="border-style:none">
                                        </font></td>
                                      <td width="13%"><font size="1" face="MS Sans Serif">Company 
                                        ID</font></td>
                                      <td width="24%"> 
                                        <input type="text" name="txtvalue" onKeyPress="notAllowSplChar()">
                                      </td>
                                      <td width="12%" align="center"> 
                                        <input type="button" name="search" value="Search" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:75" onClick="doSearch()">
                                      </td>
                                      <td width="12%" align="center">
                                        <input type="button" name="cmdOK22" value="New Applicant" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100" onClick="callNew()" >
                                      </td>
                                      <td width="20%"> 
                                        <input type="button" name="offline" value="Offline" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="callOffline()">
                                      </td>
                                    </tr>
                                    <tr> 
                                      <td colspan="8"> 
                                        <table width="70%" border="0" cellspacing="0" cellpadding="5" align="center">
                                          <tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8"> 
                                            <td width="50%"> 
                                              <div align="center"><font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">Company 
                                                Name</font></b></font></div>
                                            </td>
                                            <td width="50%"> 
                                              <div align="center"><font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">Company 
                                                ID</font></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                      </td>
                                    </tr>
                                    <tr align="center"> 
                                      <td colspan="8"> <iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/comappresult.jsp?hidBeanGetMethod=getApplicantList" width=70% height=240> 
                                        </iframe> </td>
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
    <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"bgcolor="#DEDACF" align="center">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3">
            <tr valign="top">
              <td height="2">
                <input type="button" name="cmdreset" value="Reset" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="resetme()">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doHelp('cappmaster.htm')">
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
  <input type=hidden name="comapp_id">
  <input type=hidden name="comapp_companyname">
</form>
</body>
</html>
