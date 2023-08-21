<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%	
	//String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
//	out.println("str==>"+strLevelOrgCode);
	//String strUserName=(String)session.getAttribute("strUserName");
//	out.println("str==>"+strUserName);
	//String strUserId=(String)session.getAttribute("strUserId");
//	out.println("str==>"+strUserId);
%>
<html>
<head>
<title>User Tracking</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappsanction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
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
function callCalender(name)
{
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
		showCal(appURL,name);
	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="repapp" method="post" class="normal">
 
 
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home-&gt;Retail-&gt;Reports-&gt;Userwise Retails and Staff or Agriculture  Applications Sanctioned/Rejection/Pending </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable border1"  width="100%" border="0" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1"  width="60%" border="0" cellspacing="0" cellpadding="5" align="center" >
            <tr> 
              <td> 
                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center" height="248">
                  <tr> 
                    <td width="75%" valign="top">
                      <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center" width="35%"> 
                            Organisation Level</td>
                          <td align="center" colspan="2"> 
                            <table class="outertable"  width="100%" border="0">
                              <tr> 
                                <td width="51%" height="25">Loan 
                                  Type</td>
                                <td width="49%" height="25">Process 
                                  Status</td>
                              </tr>
                            </table>
                              
                            </td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="35%"> 
                            <p> 
                              <select name="sellevel" style="width:100" onChange="selectValues()" >
                                <option selected>--Select--</option>
                                <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                              </select>
                            </p>
                          </td>
                          <td align="center" valign="top" colspan="2"> 
                            <table class="outertable"  width="100%" border="0">
                              <tr> 
                                <td height="26"> 
                                  <select name="selprodtype" style="width:100" tabindex="1" >
                                    <option selected value="S">---Select---</option>
                                    <option value="P">Retail</option>
                                    <option value="A">Agriculture</option>
                                  </select>
                                </td>
                                <td height="26"> 
                                  <select name="cmbstatus" style="width:100" tabindex="2"  >
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
                          <td align="center" width="35%"> 
                            Select Organisation </td>
                          <td align="center" colspan="2">Name 
                            of User</td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top" width="35%"> 
                            <div align="center"> 
                              <select name="rpselect1" size="11" style="width:230" onChange="refreshAppno()">
                              </select>
                            </div>
                          </td>
                          <td align="center" valign="top" width="75%"> 
                            <div align="center"> 
                              <select name="selappno"  accesskey=""style="width:200" size="11" >
                              </select>
                              </div>
                          </td>
                          <td align="center" valign="top" width="1%" style="visibility: hidden;"> 
                            <select name="rpselect2" size="11" style="width:10" multiple>
                              <option value="app_no">Application Number</option>
                              <option value="perapp_fname,perapp_lname">Applicant 
                              Name</option>
                              <option value="to_char(loan_receivedate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'DD/MM/YYYY') as inward_date">Applied 
                              Date</option>
                              <option value="loan_recmdamt as loan_recmdamt">Amount</option>
                              <option value="org_name">Branch</option>
                              <!--<option value="app_status">Application Status</option>-->
                              <option value="cat2.cat_name,cat1.cat_name as scatname,prd_desc">Product 
                              Name</option>
                              <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate"> 
                              Date</option>
                            </select>
                          </td>
                        </tr>
                        <tr align="center"> 
                          <td align="center" colspan="3"> 
                            <div align="center"> 
                              <table class="outertable border1"  width="60%" border="0" cellspacing="0" cellpadding="3" align="center" >
                                <tr> 
                                  <td> 
                                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                      <tr> 
                                        <td width="21%" align="center">Period 
                                        </td>
                                        <td width="79%" align="center"> 
                                          <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].cmdrunreport.focus();">
                                          <a href="#" onClick="showPeriod()"  tabindex="6" >?</a> 
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                                </div>
                          </td>
                        </tr>
                        <tr> 
                          <td align="center" colspan="3"> 
                            <div align="center"></div>
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
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
 
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal Application Sanction Report">
  <input type="hidden" name="hidParam">
   <input type="hidden" name="hidOrgName">
  <input type="hidden" name="hidPage" value="perrunapptrack.jsp">
  <input type="hidden" name="hidAppName">
<!--   <input type="hidden" name="txtDate" value='<%//=Helper.getCurrentDateTime()%>'>  -->
 <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
</form>
</body>
</html>

