<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<html>
<head>
<title>Statuswise Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappstatuswise.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="perappstat" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt; Retail -&gt;Reports-&gt;Disposal of applications Summary 
      </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20" height="400" >
    <tr> 
      <td valign="middle"> 
        <table class="outertable"  border="1" cellspacing="0" cellpadding="3" align="center" width="65%"  >
          <tr> 
            <td> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td width="73%" valign="top" colspan="2"> 
                     
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="32%">Organisation 
                          Level </td>
                        <td align="center" width="39%">Process 
                          Status</td>
                        <td align="center" width="29%">Loan 
                          Type</td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" width="32%"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1">
                            <option selected>---Select---</option>
                            <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                          </td>
                        <td align="center" width="39%"> 
                          <select name="cmbstatus" style="width:100" tabindex="2">
                            <option selected>---Select---</option>
                            <option value="P">Pending</option>
                            <option value="A">Approved</option>
                            <option value="R">Rejected</option>
                             <option value="L">Lodged</option>
                          </select>
                        </td>
                        <td align="center" width="29%"> 
                          <select name="selloantype" style="width:100" tabindex="2">
                            <option value="" selected>---Select---</option>
                            <option value="P">Retail</option>
                          </select>
                        </td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="3">Select 
                          Organisation </td>
                      </tr>
                      <tr align="center"> 
                        <td colspan="3"> 
                          <table class="outertable"  width="100%" border="0">
                            <tr> 
                              <td width="98%" align="center"> 
                                <select name="rpselect1" size="11"  style="width:250" tabindex="3" >
                                </select>
                                </td>
                              <td style="visibility: hidden;" width="2%"> 
                                <select name="rpselect2" size="11"  style="width:10"  multiple tabindex="4">
                                  <option value="(case when LOAN_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) when app_orglevel='D' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) else org_name end) else organisations.org_name end )as org_name">Branch</option>
                                  <option value="app_status">Application Status</option>
                                  <option value="count(app_no)">No Of Applications</option>
                                  <option value="sum(loan_recmdamt),sum(loan_recmdamt)">Loan 
                                  Amount</option>
                                </select>
                                </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr align="center"> 
                        <td colspan="3"> 
                          <table class="outertable"  width="60%" border="1" cellspacing="0" cellpadding="3" align="center" >
                            <tr> 
                              <td> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center"> 
                                      <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].cmdrunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a> 
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
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidStatus"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Personal Application Statuswise Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappstatuswise.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
<input type="hidden" name="hidOrgName">
</form>
</body>
</html>
