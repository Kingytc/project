<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>SOAR</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappsoar.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";


function callCalender(fname)
 {
	 showCal(path,fname);
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
        -&gt; Retail</i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font> <font face="Times New Roman" size="3"><b><i>Reports</i></b></font> 
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font><font face="Times New Roman" size="3"><b><i>Status 
        of Application Received Report(SOAR)</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <table width="90%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="24%">Organisation Level</td>
                  <td rowspan="8"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="35%">Select Organisation</td>
                        <td align="center"> Select Product </td>
                        <td align="center"> Select Output Fields</td>
                      </tr>
                      <tr align="center"> 
                        <td width="45%"> 
                          <select name="rpselect1" size="11"  style="width:180" onChange="selectProd()" tabindex="4">
                          </select>
                        </td>
                        <td width="50%"> 
                          <select name="rpprod" size="11" style="width:300" multiple tabindex="5">
                          </select>
                        </td>
                        <td width="26%"> 
                          <select name="rpselect2" size="11"  style="width:130"  multiple tabindex="6">
                            <option value="1">No of Loans Applied</option>
                            <option value="2">No of loans Sanctioned</option>
                            <option value="3">No of Loans Rejected</option>
                            <option value="4">No of Loans in Process</option>
                            <!-- <option value="5">Loan Availed</option>
                            <option value="6">Interest Rate(%)</option> -->
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="24%"> 
                    <select name="sellevel" style="width:250" onChange="selectValues()" tabindex="1">
                      <option selected>---Select---</option>
                      <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="24%" align="left">Category</td>
                </tr>
                <tr> 
                  <td width="24%"> <iframe  height="0" width="0" id="ifrmp" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=prod&prodtype=p"></iframe> 
                    <select name="prodcat" style="width:250" onChange="selectSubCat()" tabindex="2">
                      <option selected value="0">---Select---</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td width="24%">Sub Category</td>
                </tr>
                <tr> 
                  <td width="24%"> 
                    <select name="product" style="width:250" onChange="onsel()" tabindex="3">
                      <option selected value="0">---Select---</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td> Period </td>
                </tr>
                <tr> 
                  <td> 
                    <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                    <a href="#" onClick="showPeriod()"><b class="fontstyle">?</b></a> 
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
  <table border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()" tabindex="7">
              </div>
            </td>
          <!--    <td height="0" width="16%"> 
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
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()" tabindex="8">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="doHelp('perrep.htm#soar')" tabindex="9">
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()" tabindex="10">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="repappsoar" >
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidCatFields"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Personal SOAR Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappsoar.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
