<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Borrowers List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
input {  font-family: "MS Sans Serif"; color: #003399; border-style: groove; font-size: 10px}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepborlist.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="orgfrm" method="post">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        -&gt; </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Corporate 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Reports 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i></i></b></font><font face="Times New Roman" size="3"><b><i>Borrowers 
        List</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <table border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" width="70%">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="75%" valign="top"><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif">Organisation 
                          Level</font></td>
                        <td align="center" width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <select name="sellevel" style="width:100"  onChange="selectValues()" >
                            <option selected value="select">---Select---</option>
                            <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                          </font></td>
                        <td align="center" width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font face="MS Sans Serif" size="1">Select 
                          Organisation </font></td>
                        <td align="center" width="50%"><font face="MS Sans Serif" size="1">Select 
                          Output Fields </font></td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect1" size="11" style="width:150" multiple>
                          </select>
                          </font></td>
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect2" size="11" style="width:150" multiple>
                            <!-- <option value="demo_appno" selected>Application Number</option>
                            <option value="comapp_companyname">Applicant Name</option>
                            <option value="convert(varchar(10),app_createdate,103) as appdate">Applied 
                            Date</option>
                            <option value="prd_desc">Product Name</option>
                            <option value="loan_amtreqd">Amount Requested</option>
                            <option value="loan_terms">Term Requested</option>
                            <option value="org_name">Organisation</option>
                            <option value="loan_modintrate">Interest</option>
                            <option value="app_status">Process Status</option>
                            <option value="app_delusrid">Deleted By</option>
                            <option value="convert(varchar(10),app_deldate,103) as deldate">Deletion 
                            Date</option> -->
							<option value="demo_appno" selected>Application Number</option>
							<option value="comapp_companyname" selected>Borrower Name</option>
							<option value="org_name" selected>Organisation</option>
							<option value="loan_amtreqd" selected>Amount Requested</option>
							<option value="convert(varchar(10),app_createdate,103) as appdate" selected>Applied Date</option>
							<option value="convert(varchar(10),app_processdate,103) as appdate" selected>Approved/Rejected Date</option>
                          </select>
                          </font></td>
                      </tr>
                      <tr> 
                        <td align="right" colspan="2"> <font face="MS Sans Serif" size="1"> 
                          </font><font face="MS Sans Serif" size="1"> </font> 
                          <table width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="22%" align="center"><font face="MS Sans Serif" size="1">Period 
                                      </font></td>
                                    <td width="78%" align="center"><font face="MS Sans Serif" size="1"> 
                                      <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="JavaScript:showPeriod()" class="blackfont"><b>?</b></a> 
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
  <input type="hidden" name="hidBeanId" value="comrepborlist">
  <input type="hidden" name="hidOrgCode"  >
  <input type="hidden" name="hidOpFields"  >
  <input type="hidden" name="hidSelFields"  >
  <input type="hidden" name="repname" value ="Borrowers List">
  <input type="hidden" name="txtprofile_name" >
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="comrunborlist.jsp">
  <input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
