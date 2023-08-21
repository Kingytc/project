<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>DOVE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappdove.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
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

<form name="orgfrm" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        -&gt; Retail</i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font> <font face="Times New Roman" size="3"><b><i>Reports</i></b></font> 
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font><font face="Times New Roman" size="3"><b><i>Document 
        Overdue (DOVE) Report </i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" width="65%">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="71%"><font size="1" face="MS Sans Serif"> </font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"> 
                      </font> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr align="center"> 
                          <td align="center" width="95%"><font size="1" face="MS Sans Serif">Organisation 
                            Level</font></td>
                          <td align="center" width="5%">&nbsp;</td>
                        </tr>
                        <tr align="center"> 
                          <td align="center" width="95%"><font size="1" face="MS Sans Serif"> 
                            <select name="sellevel" style="width:100"  onChange="selectValues()" tabindex="1" >
                              <option selected value="select">---Select---</option>
                              <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                            </select>
                            </font></td>
                          <td align="center" width="5%">&nbsp;</td>
                        </tr>
                        <tr align="center"> 
                          <td align="center" width="95%"><font face="MS Sans Serif" size="1">Select 
                            Organisation </font></td>
                          <td align="center" width="5%">&nbsp;</td>
                        </tr>
                        <tr align="center"> 
                          <td width="95%"><font size="1" face="MS Sans Serif"> 
                            <select name="rpselect1" size="11" style="width:150" tabindex="2">
                            </select>
                            </font></td>
                          <td style="visibility: hidden;" width="5%"><font size="1" face="MS Sans Serif"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="3">
                              <option value="app_no" ><font size="1" face="MS Sans Serif">Application 
                              Number</font></option>
                              <option value="perapp_fname,perapp_lname"><font size="1" face="MS Sans Serif">Applicant 
                              Name</font></option>
                              <option value="c1.cat_name as category"><font size="1" face="MS Sans Serif">Category 
                              </font></option>
                              <option value="c2.cat_name as subcategory"><font size="1" face="MS Sans Serif">Sub 
                              Category</font></option>
                              <option value="prd_desc"><font size="1" face="MS Sans Serif">Product 
                              Name</font></option>
                              <option value="to_char(app_processdate,'dd/mm/yyyy') as appdate"><font size="1" face="MS Sans Serif">Approved 
                              Date</font></option>
                              <option value="loan_recmdamt as appamt"><font size="1" face="MS Sans Serif">Loan 
                              Amount</font></option>
                              <option value="doc_desc"><font size="1" face="MS Sans Serif">Document 
                              Not Obtained</font></option>
                              <option value="doc_type"><font size="1" face="MS Sans Serif">Document 
                              Type</font></option>
                              <option value="round(to_date(sysdate,'dd/mm/yyyy')-to_date(app_createdate,'dd/mm/yyyy')) as
		days"><font size="1" face="MS Sans Serif">Overdue 
                              by days</font></option>
                            </select>
                            </font></td>
                        </tr>
                        <tr align="center"> 
                          <td colspan="2"> 
                            <table width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                    <tr> 
                                      <td width="21%" align="center"><font face="MS Sans Serif" size="1">Period 
                                        </font></td>
                                      <td width="79%" align="center"><font face="MS Sans Serif" size="1"> 
                                        <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                                        <a href="#" onClick="showPeriod()" class="blackfont" tabindex="4"><b>?</b></a> 
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
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table width="1%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="69%" border="0" cellspacing="0" cellpadding="3">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()" tabindex="5">
              </div>
            </td>
           <!--   <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpsave" value="Save" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="save()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rpbrowse" value="Browse" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="browse()">
              </div>
            </td>-->
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()"tabindex="6">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()" tabindex="8">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="repappdove">
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="repname" value ="Personal DOVE Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappdove.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
