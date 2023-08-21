<%@include file="../../share/directives.jsp"%>
<%	
	String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
	String strUserName=(String)session.getAttribute("strUserName");
%>
<html>
<head>
<title>Application Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/mis/opsrepapptrack.js">
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
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body >
<form name="repapp" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>Home 
        -&gt; Tertiary Reports 
       Application 
        Tracking</td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
 
          <table class="outertable border1" width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
            <tr> 
              <td> 
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center" >
                  <tr> 
                   
                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center" width="62%">Organisation 
                            Level</td>
                          
                          <td align="center" width="36%">Process 
                            Status</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="62%"> 
                            <p> 
                              <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                                <option selected>--Select--</option>
                                <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                              </select>
                              </p>
                          </td>
                         
                          <td align="center" valign="top" width="36%"> 
                            <select name="cmbstatus" style="width:100" onChange="resetData()" tabindex="2" >
                              <option selected>---Select---</option>
                              <option value="P">Pending</option>
                              <option value="A">Approved</option>
                              <option value="R">Rejected</option>
                            </select>
                            </td>
                        </tr>
                        <tr> 
                          <td align="center" width="62%"> 
                            Select Organisation </td>
                          <td align="center" width="36%">Application 
                            No </td>
                          <td align="center" width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="62%"> 
                            <select name="rpselect1" size="11" style="width:250" onChange="refreshAppno()" tabindex="3" >
                            </select>
                            </td>
                          <td align="center" valign="top" width="36%"> 
                            <select name="selappno"  accesskey=""style="width:130"  multiple size="11" tabindex="4"  >
                            </select>
                            </td>
                           
                          <td align="center" valign="top" style="visibility:hidden;" width="2%"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="5" >
                      <option value="app_no">Application Number</option>
                      <option value="perapp_fname,perapp_lname">Applicant Name</option>
                      <option value="to_char(app_createdate,'DD/MM/YYYY') as app_date,to_char(INWARD_DOCRECEIVEDON,'DD/MM/YYYY') as inward_date">Applied Date</option>
                      <option value="sum(facility_proposed) as facility_proposed">Amount</option>
                      <option value="org_name">Branch</option>
                    </select>
                  </td>
                        </tr>
                        
                           <tr align="center" style="visibility: hidden;"> 
                        <td align="center" colspan="2"> 
                           
                          <table class="outertable border1" width="60%" border="0" cellspacing="0" cellpadding="3" align="center">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
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
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()" tabindex="7" >
              </div>
            </td>
         
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()" tabindex="8" >
              </div>
            </td>
          
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:nav()" tabindex="10" >
              </div>
            </td>
			
          </tr>
       
  </table>
  </td>
  </tr>
  </table>
  <br>
  <input type="hidden" name="hidBeanId" value="perrepapptrack">
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
  <input type="hidden" name="hidStatus">
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal Application Tracking Report">
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="perrunapptrack1.jsp">
  <input type="hidden" name="hidOrgName">
</form>
</body>
</html>
