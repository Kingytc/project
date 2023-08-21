<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />


<html>
<head>
<title>Primary Applicant details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepdoc.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
//-->

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

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="prim" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 

  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        -&gt; Retail</i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font> <font face="Times New Roman" size="3"><b><i>Reports</i></b></font> 
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>Document Review</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table width="70%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td rowspan="4" width="75%" valign="top"> 
                      <table width="101%" border="0" cellspacing="0" cellpadding="5" height="196">
                        <tr align="center"> 
                          <td colspan="2" height="21" valign="top"><font size="1" face="MS Sans Serif">Organisation
                            Level</font></td>
                          <td colspan="2" height="21" valign="top"><font size="1" face="MS Sans Serif">Select 
                            By </font></td>
                        </tr>
                        <tr align="center"> 
                          <td colspan="2" height="21" valign="top"><font size="1" face="MS Sans Serif"> 
                            <select name="sellevel" style="width:100" onChange="selectValues()" >
                              <option selected>---Select---</option>
                              <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                            </select>
                            </font></td>
                          <td colspan="2" height="21" valign="top"><b><font face="MS Sans Serif" size="1"> 
                            <select name="selopt" style="width:100" onChange="selectData()">
                              <option selected>--- Select ----</option>
                              <option value="app_no">Application No</option>
                              <option value="perapp_panno">PAN No</option>
                              <option value="perapp_lname">LastName</option>
                            </select>
                            </font></b></td>
                        </tr>
                        <tr align="center"> 
                          <td colspan="2" height="21" valign="top"><font size="1" face="MS Sans Serif">Select 
                            Organisation</font></td>
                          <td colspan="2" height="21" valign="top"> 
                            <p><font size="1" face="MS Sans Serif">Select </font></p>
                          </td>
                        </tr>
                        <tr align="center"> 
                          <td colspan="2" height="209" valign="top"><font size="1" face="MS Sans Serif"> 
                            <select name="rpselect1" size="12" style="width:150"  multiple onChange="resetData()">
                            </select>
                            </font></td>
                          <td colspan="2" height="209" valign="top"><font size="1" face="MS Sans Serif"> 
                            <select name="selappno" size="12" style="width:150"  multiple>
                            </select>
                            </font></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr> </tr>
                  <tr> </tr>
                  <tr> </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table width="1%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="69%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpsave" value="Save" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" disabled>
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpbrowse" value="Browse" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" disabled>
              </div>
            </td>
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="doHelp('perrep.htm#documentreview')">
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
</form>
</body>
</html>
