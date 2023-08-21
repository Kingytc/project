<%@include file="../../share/directives.jsp"%>
<%

String str_report=(String)request.getParameter("report");
String str_multiple="";
if(str_report.equalsIgnoreCase("C"))
{
	str_multiple="multiple";
}
else
{
	str_multiple="";
}
%>
<html>
<head>
<title>Application Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/mis/opsrepappstatus.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="callonLoad()">
<form name="perappstat" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>Home 
        -&gt; Tertiary -&gt;Reports-&gt; 
        Application Status </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  
        <table class="outertable border1" border="0" cellspacing="0" cellpadding="3" align="center" width="65%">
          <tr> 
            <td> 
              <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="3" height="30"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="50%" align="center">Organisation Level</td>
                        <td width="50%" align="center">Process Status</td>
                      </tr>
                      <tr> 
                        <%if("C".equals((String)request.getParameter("report"))){ %>
                        <td width="27%" align="center"  ><font size="1" face="MS Sans Serif"> 
                          <select name="sellevel" style="width:120" onChange="LoadValues()" >
                            <option value="" selected>---Select---</option>
                            <option value="State">State</option>
                            <option value="City">City</option>
                            <option value="S/C">City within a State</option>
                          </select>
                          </font> </td>
                        <%}else{ %>
                        <td width="50%" align="center"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1" >
                            <option selected>---Select---</option>
                            <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                        </td>
                        <%} %>
                        <td width="50%" align="center"> 
                          <select name="cmbstatus" style="width:100" tabindex="2">
                            <option selected>---Select---</option>
                            <option value="P">Pending</option>
                            <option value="A">Approved</option>
                            <option value="R">Rejected</option>
                          </select>
                        </td>
                      </tr>
                      <%if("C".equals((String)request.getParameter("report"))){ %>
                      <tr id="state"> 
                        <td align="center" width="33%" > 
                          <select name="sel_state" onchange="LoadcityValues()">
                            <option value="0">--Select--</option>
                            <lapschoice:stateflexmaster /> 
                          </select>
                        </td>
                        
                      </tr>
                      <%} %>
                    </table>
                  </td>
                </tr>
               
                <tr> 
                  <td valign="top" colspan="3"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center" width="93%">Select Organisation </td>
                        <td align="center" width="7%">&nbsp;</td>
                      </tr>
                      <tr align="center"> 
                        <td width="93%"> 
                          <select name="rpselect1" size="11"  style="width:230" tabindex="3" <%=str_multiple%> >
                          </select>
                        </td>
                        <td width="7%"  style="visibility:hidden;"> 
                          <select name="rpselect2" size="11"  style="width:10" tabindex="4" multiple id="acctclass">
                            <option value="app_no">Application Number</option>
                            <option value="perapp_fname,perapp_lname">Applicant 
                            Name</option>
                            <option value="sum(facility_proposed) as facility_proposed">Amount</option>
                            <option value="to_char(app_createdate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'dd/mm/yyyy') as inward_date">Applied 
                            Date</option>
                            
                            <option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
                            <option value="org_name">Branch</option>
                          </select>
                         
                        </td>
                      </tr>
                      <tr align="center"> 
                        <td align="center" colspan="2"> 
                          <table class="outertable" width="80%" border="0" cellspacing="0" cellpadding="6" align="center" >
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="6" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period </td>
                                    <td width="79%" align="center">&nbsp; 
                                      <input type="text" name="txtDate" maxlength="21" readonly size="27" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a> 
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="21%" align="center" nowrap> Amount 
                                      From </td>
                                    <td width="79%" align="center"> <lapschoice:CurrencyTag  name="txtfromamt" maxlength="15" size="18" tabindex="6"/> 
                                   &nbsp;&nbsp;  To&nbsp; &nbsp;<lapschoice:CurrencyTag name="txttoamt" maxlength="15" size="18" tabindex="7"/> 
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
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()" tabindex="8">
              </div>
            </td>
        
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()" tabindex="9">
              </div>
            </td>
         
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeData()" tabindex="11">
              </div>
            </td>
          </tr>
        </table>
        </td>
        </tr>
        </table>
        <br>
  <input type="hidden" name="hidBeanId" value="perrepappstatus" >
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidStatus"  >
<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Personal Application Status Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="perrunappstatus.jsp">
<input type="hidden" name="hidusr_id" >
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
 <input type="hidden" name="hidOrgName">

</form>
</body>
</html>
