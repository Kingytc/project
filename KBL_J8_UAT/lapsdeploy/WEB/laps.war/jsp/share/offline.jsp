<%@ page import="com.sai.laps.helper.*,java.io.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="session"/>
<laps:handleerror />

<%
	
	
	//String strFile = ApplicationParams.getFtpPath()+"\\"+ "\\" + strUserId + "\\" + "\\" + request.getParameter("fileid");
	//boolean b = false;

	//File f = new File(strFile);
	//if(f.exists())
	//{
		//b = true;
	//}

	
%>

<html>
<head>
<title>Ofline</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 if("<%=request.getParameter("fileid")%>"=="companydtls")
		 {
		 document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comappmastersearch.jsp";
		 }
		 if("<%=request.getParameter("fileid")%>"=="collateral")	
		 {
		  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commcollateral.jsp?hidBeanGetMethod=getCollateral";
		 }
		 document.forms[0].submit();
	 }
}

function onLoading()
{
	if("<%//=b%>"=="false")
	{
		document.forms[0].offline.disabled = true;
	}
}
function callUpdate()
{
var fileid = "<%=request.getParameter("fileid")%>";
document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/showofflinefile.jsp?hidBeanGetMethod=getFileData&hidBeanId=offlinedata&filetype="+fileid;
}
function callUpload()
{
var appno="<%=request.getParameter("appno")%>";
var dirname="<%=request.getParameter("fileid")%>";
//var username="<%=request.getParameter("username")%>";

document.all.ifrmofflineupload.src="<%=ApplicationParams.getAppUrl()%>/action/offlineupload.jsp?appno="+appno+"&dirname="+dirname;
}

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onLoading()">
<jsp:include page="../share/help.jsp" flush="true"/> 


<form name="offline" method="post">
<br>
<%
if(!request.getParameter("fileid").equals("companydtls"))
{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top">
			<laps:application />
		</td>
      </tr>
      <tr> 
        <td valign="top">&nbsp; </td>
      </tr>
    </table>
	<%
}
%>
<br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <div align="left"><font size="1" face="MS Sans Serif"><b>Offline</b></font><br>
                    </div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
                            <tr> 
                              <td> 
                                <table width="80%" border="0" cellspacing="0" cellpadding="4" align="center">
                                  <tr> 
                                    <td width="50%" align="center"> 
                                      <input type="button" name="search" value="Upload" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:75" onClick="callUpload()">
                                    </td>
                                    <td width="50%" align="center"> 
                                      <input type="button" name="offline" value="Update" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="callUpdate()">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"> 
                                      <table width="100%" cellspacing="0" cellpadding="5" align="center">
                                        <tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8"> 
                                          <td width="15%" align="center"><font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">Select 
                                            File </font></b></font></td>
                                          <td width="51%" align="center"><font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">File 
                                            Name </font></b></font></td>
                                          <td width="34%" align="center"> <font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">File 
                                            User </font></b></font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr align="center"> 
                                    <td colspan="2"> 
									<iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/showofflinefile.jsp" width=100% height=240> 
                                    </iframe> 
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
      </td>
    </tr>
  </table>
  <br>
<table border="0" cellspacing="0" cellpadding="4" bordercolorlight="#EBEBF8" bordercolordark="#82829F" align="center">
  <tr> 
    <td><fieldset> 
      <table border="0" cellspacing="0" cellpadding="3" align="center">
        <tr> 
          <td width="54%"> 
            <div align="center"><font size="1" face="MS Sans Serif"> 
                <input type="button" name="Button23311237" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="doHelp('offline.htm')">
              </font></div>
          </td>
          <td width="46%" bordercolor="#993300"> 
            <div align="center"><font size="1" face="MS Sans Serif"> 
                <input type="button" name="cmdexit" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="doClose()">
              </font></div>
          </td>
        </tr>
      </table>
      </fieldset></td>
  </tr>
</table>
<input type="hidden" name="hidBeanId" value="rbixml">
<input type=hidden name="hidBeanMethod" value="updateData">
<input type="hidden" name="hidSourceUrl" value="/action/xml.jsp" >
<iframe  height="0" width="0" id="ifrmofflineupload" frameborder=0 style="border:0">  </iframe>
</form>
</body>
</html>
