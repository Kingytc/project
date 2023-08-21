<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Reviewer Exception</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}

-->
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepapprevexcep.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

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
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<jsp:include page="../share/help.jsp" flush="true"/> 


<form name="perappstat" method="post">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="2" face="Times New Roman"><b><i><font size="3"> 
        </font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        -&gt; </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Corporate 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Reports 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i></i></b></font><font size="3">Reviewer 
        Exception</font></i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <table border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"   width="70%">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="2" height="30"><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="24%" align="center"><font size="1" face="MS Sans Serif">Organisation 
                          Level</font><font size="1" face="MS Sans Serif"> </font></td>
                        <td width="25%" align="center"><font size="1" face="MS Sans Serif">Process 
                          Status</font></td>
                      </tr>
                      <tr align="center"> 
                        <td width="24%"><font size="1" face="MS Sans Serif"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" >
                            <option selected>---Select---</option>
                            <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                          </font></td>
                        <td width="25%"> 
                          <select name="cmbstatus" style="width:100">
                            <option selected>---Select---</option>
                            <option value="P">Pending</option>
                            <option value="A">Approved</option>
                            <option value="R">Rejected</option>
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2"><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center"><font face="MS Sans Serif" size="1">Select 
                          Organisation </font></td>
                        <td align="center"><font face="MS Sans Serif" size="1">Select 
                          Output Fields </font></td>
                      </tr>
                      <tr align="center"> 
                        <td><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect1" size="11"  style="width:150" multiple >
                          </select>
                          </font></td>
                        <td><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect2" size="11"  style="width:150"  multiple>
                            <option value="org_name"><font size="1" face="MS Sans Serif">Organisation 
                            Name</font></option>
                            <option value="app_no"><font size="1" face="MS Sans Serif">Application 
                            Number</font></option>
                            <option value="app_status"><font size="1" face="MS Sans Serif">Application 
                            Status</font></option>
                            <option value="app_createdate"><font size="1" face="MS Sans Serif">Applied 
                            Date</font></option>
                            <option value="wrk_flowname"><font size="1" face="MS Sans Serif">Work 
                            Action</font></option>
                            <option value="app_status"><font size="1" face="MS Sans Serif">Passed 
                            By</font></option>
                            <option value="app_status"><font size="1" face="MS Sans Serif">Passed 
                            To</font></option>
                            <option value="app_prdcode"><font size="1" face="MS Sans Serif">Time 
                            Taken</font></option>
                          </select>
                          </font></td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"><font face="MS Sans Serif" size="1"> 
                          </font> 
                          <table width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td height="37"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center"><font face="MS Sans Serif" size="1">Period 
                                      </font></td>
                                  <td><font face="MS Sans Serif" size="1"> 
                          <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                          <a href="#" onClick="JavaScript:showPeriod()" class="fontstyle"><b>?</b></a> 
                          </font></td>
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
  <table width="1%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpsave" value="Save" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="save()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpbrowse" value="Browse" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="browse()">
              </div>
            </td>
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="doHelp('commreport.htm')">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="repapprevexcep" >
  <input type="hidden" name="hidOrgCode"  >
  <input type="hidden" name="hidOpFields"  >
  <input type="hidden" name="hidSelFields"  >
  <input type="hidden" name="hidStatus"  >
  <input type="hidden" name="userid" >
  <input type="hidden" name="repname" value ="Commercial Reviewer Exception Report">
  <input type="hidden" name="txtprofile_name" >
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="comrunapprevexcep.jsp">
  <input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
