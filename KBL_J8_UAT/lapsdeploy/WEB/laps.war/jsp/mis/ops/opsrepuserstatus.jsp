<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<%	
	String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
	String strUserName=(String)session.getAttribute("strUserName");
	String strUserId=(String)session.getAttribute("strUserId");
%>
<html>
<head>
<title>User Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}

</STYLE>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/mis/opsrepuserstatus.js">
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

<form name="repapp" method="post">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home 
        -&gt; Tertiary -&gt; Reports -&gt; Userwise Status of Pending/Approved/Rejected </i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table width="60%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" height="248">
                  <tr> 
                    <td width="75%" valign="top"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center" width="44%">Organisation Level</td>
                          <td align="center" width="53%">Process Status</td>
                          <td align="center" width="3%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="44%"> 
                            <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected>--Select--</option>
                                <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                              </select>
                          </td>
                          <td align="center" valign="top" width="53%"> 
                            <select name="cmbstatus" style="width:100" tabindex="2"  >
                              <option selected>---Select---</option>
                              <option value="P">Pending</option>
                              <option value="A">Approved</option>
                              <option value="R">Rejected</option>
                            </select>
                          </td>
                          <td align="center" valign="top" width="3%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td align="center" width="44%"> Select Organisation 
                          </td>
                          <td align="center" width="53%">Name of User</td>
                          <td align="center" width="3%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="44%"> 
                            <select name="rpselect1" size="11" style="width:250" onChange="refreshAppno()" tabindex="3" >
                            </select>
                            </td>
                          <td align="center" valign="top" width="53%"> 
                            <select name="selappno"  accesskey=""style="width:200"  size="11" tabindex="4" >
                            </select>
                            </td>
                           
                          <td align="center" valign="top" style="visibility:hidden;" width="3%"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="5" >
	                      <option value="app_no">Application   Number</option>
	                      <option value="perapp_fname,perapp_lname">Applicant  Name</option>
	                      <option value="to_char(app_createdate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'dd/mm/yyyy') as inward_date">Applied  Date</option>
	                      <option value="sum(facility_proposed) as facility_proposed">Amount</option>
	                      <option value="org_name">Branch</option>
	                      <!-- <option value="app_status">Application  Status</option>-->
	                      <!-- option value="facmst.facility_catdesc as facheaddesc,facility_master.facility_catdesc as facdesc">Product Name</option-->
	                      <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
	                      <!--<option value="app_approvedby">Approved/Rejected By</option>-->
                    </select>
                  </td>
                        </tr>
                        
                                              <tr align="center"> 
                        <td align="center" colspan="2">
                          <table width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center">
                                      <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="6" ><b>?</b></a> 
                                      </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                          
                        </td>
                      </tr>
                        
                        <tr> 
                          <td align="center" colspan="3">&nbsp; </td>
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
  <table border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()" tabindex="7" >
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
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()" tabindex="8" >
              </div>
            </td>
           <%-- <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" 
onClick="doHelp('perrep.htm#applicationtracking')" tabindex="9" >
              </div>
            </td>--%>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:nav()" tabindex="10" >
              </div>
            </td>
			<!--
			<td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Click" onclick="fun()">
              </div>
			  <Script language="javascript">
			  function fun(){
				  alert(document.forms[0].hidOrgCode.value);
				}

			  </script>
            </td>
			-->
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="perrepapptrack">
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
  <input type="hidden" name="hidStatus">
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal User Status Tracking Report">
  <input type="hidden" name="hidParam" value="">
  <input type="hidden" name="hidPage" value="perrunapptrack.jsp">
  <input type="hidden" name="hidOrgName">
   <input type="hidden" name="hidAppName">
<!--   <input type="hidden" name="txtDate" value='<%//=Helper.getCurrentDateTime()%>'>  -->
</form>
</body>
</html>
