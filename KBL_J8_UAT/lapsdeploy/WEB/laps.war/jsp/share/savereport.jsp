<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%

	String strFrom =Helper.correctNull((String)hshValues.get("fromwhichpage"));
	String strAction =(String)hshValues.get("action");
	if (strFrom == null)
	{
		strFrom ="";
	}
	
%>
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/savereport.js">
</script>
<script language="javascript">
var path="<%=ApplicationParams.getAppUrl()%>";
var from ="<%=strFrom%>";
var userid="<%=(String)session.getAttribute("strUserId")%>";
var repname=window.opener.document.forms[0].repname.value;
var param="<%=(String)request.getParameter("param")%>";
var action = "<%=strAction%>";
var txtfromamt=window.opener.document.forms[0].txtfromamt.value;

var txttoamt=window.opener.document.forms[0].txttoamt.value;

 

function getFocus()
{
		document.forms[0].txtprofile_name.focus();
	 if (action == "failed" )
	 {
		 alert("Profile Name already exists");
		 document.forms[0].txtprofile_name.focus();
	 }	
	 else if (action == "done")
	 {
		 window.close();
	 }
	 document.forms[0].txtfromamt.value=txtfromamt;
    document.forms[0].txttoamt.value=txttoamt;

}
</script>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="getFocus()">
<form name="savefrm" method="post">
  <div align="center"><br>
    <table width="300" border="0" cellspacing="0" cellpadding="0" class="outertable border1" height="200">
      <tr> 
        <td valign="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" height="100%">
            <tr bgcolor="#605FAF"> 
              <td valign="middle" height="28" bgcolor="#71694F"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF" size="2">Name 
                the Report Profile</font></b></font></td>
            </tr>
            <tr> 
              <td width="56%" height="52"> 
                <div align="center"> 
                  <input type="text" name="txtprofile_name" size="25" maxlength="60"  onKeyPress="allowAlphabetsAndNumber()">
                </div>
              </td>
            </tr>
            <tr> 
              <td height="19"> 
                <div align="center"><font size="1" face="MS Sans Serif">(Give 
                  descriptive profile name based on fields selected )</font></div>
              </td>
            </tr>
            <tr> 
              <td> <br>
                <br>
                <table width="69%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable border1">
                  <tr> 
                    <td> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="5"  align="center">
                        <tr valign="top"> 
                          <td height="5" width="12%"> 
                            <div align="center"> 
                              <input type="button" name="saveok" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"onClick="saveData()">
                            </div>
                          </td>
                          <td height="5" width="12%"> 
                            <div align="center"> 
                              <input type="button" name="cancelok" value="Cancel" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="window.close()">
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
  </div>
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidSourceUrl" >
<input type="hidden" name="hidBeanGetMethod" >
<input type="hidden" name="hidBeanMethod" >
<input type="hidden" name="hidAction" >
<input type="hidden" name="userid">
<input type="hidden" name="repname">
<input type="hidden" name="hidParam">
<input type="hidden" name="txtfromamt" value="">
  <input type="hidden" name="txttoamt" value="" >
</form>
</body>
</html>
