<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Status of Application Received Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #605FAF}
a:hover {  color: #FF3300}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/com/comrepappsoar.js">
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
</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadData()">
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
        </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>Status of Application Received 
        Report (SOAR)</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <table width="83%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="24%"><font size="1" face="MS Sans Serif">Organisation 
                    Level</font></td>
                  <td rowspan="10"><font size="1" face="MS Sans Serif"> </font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="35%"><font face="MS Sans Serif" size="1">Select 
                          Organisation</font></td>
                        <td align="center"><font face="MS Sans Serif" size="1"> 
                          Select Product </font></td>
                        <td align="center"><font face="MS Sans Serif" size="1"> 
                          Select Output Fields</font></td>
                      </tr>
                      <tr align="center"> 
                        <td width="35%"><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect1" size="11"  style="width:130" onChange="selectProd()" >
                          </select>
                          </font></td>
                        <td width="39%"><font size="1" face="MS Sans Serif"> 
                          <select name="rpprod" size="11" style="width:130" multiple>
                          </select>
                          </font></td>
                        <td width="26%"><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect2" size="11"  style="width:130"  multiple>
                            <option value="1">Product</option>
                            <option value="2">No. of Loans Applied</option>
                            <option value="3">No. of Loans Sanctioned</option>
                            <option value="4">No. of Loans Rejected</option>
                            <option value="5">No. of Loans in Process</option>
                          </select>
                          </font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="24%" height="41"><font size="1" face="MS Sans Serif"> 
                    <select name="sellevel" style="width:130" onChange="selectValues()" >
                      <option selected>---Select---</option>
                      <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                    </select>
                    </font></td>
                </tr>
				<tr>
				  <td align="left" height="26" width="31%"><font size="1" face="MS Sans Serif">Product 
                    Type </font></td>
				</tr>
                <tr> 
                  <td width="24%" align="left"><font size="1" face="MS Sans Serif">
                    <select name="prodopt" style="width:130" onChange="selectPrdType()" >
                      <option selected value="0">---Select---</option>
                    </select>
                    </font></td>
                </tr>
				<tr> 
                  <td width="24%"><font size="1" face="MS Sans Serif">Category 
                    </font></td>
                </tr>
                <tr> 
                  <td width="24%"><font size="1" face="MS Sans Serif"> <iframe  height="0" width="0" id="ifrmp" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=prod&prodtype=p"></iframe> 
                    <select name="prodcat" style="width:130" onChange="selectSubCat()" >
                      <option selected value="0">---Select---</option>
                    </select>
                    </font></td>
                </tr>
                <tr> 
                  <td width="24%"><font face="MS Sans Serif" size="1">Sub Category</font></td>
                </tr>
                <tr> 
                  <td width="24%"> 
                    <select name="product" style="width:130" onChange="onsel()">
                      <option selected value="0">---Select---</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1"> Period </font> </td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1"> 
                    <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                    <a href="#" onClick="JavaScript:showPeriod()"><b class="fontstyle">?</b></a> 
                    </font></td>
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
  <input type="hidden" name="hidBeanId" value="repappsoar" >
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidCatFields"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Commercial SOAR Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="comrunappsoar.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
