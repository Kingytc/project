<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%	
	String strLevelOrgCode=(String)session.getAttribute("strOrgCode");
	String strUserName=(String)session.getAttribute("strUserName");
%>
<html>
<head>
<title>Individual User Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}

a:hover {  color: #FF3300}
</STYLE>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepusrcount.js">
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
</head>
<body>
<form name="repapp" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt; Retail-&gt;Reports-&gt;Individual User Disposal of loan Application</td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20" >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable"  width="60%" border="1" cellspacing="0" cellpadding="5" align="center" >
            <tr> 
              <td> 
                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="75%" valign="top"> 
                       
                      <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
                        <tr> 
                          <td align="center">Organisation Level</td>
                          <td align="center">Loan Type</td>
                        
                        </tr>
                        <tr align="center"> 
                          <td valign="top"> 
                            <p> 
                              <select name="sellevel" style="width:100" onChange="selectValues()" tabindex="1">
                                <option selected>--Select--</option>
                                <laps:reptag beanid="setupreport" methodname="getLevels" param="BRCLPU" /> 
                              </select>
                              </p>
                          </td>
                         <td>  
                                  <select name="selstatus" style="width:100" onChange="refreshAppno()" tabindex="1" >
                                    <option selected value="S">---Select---</option>
                                    <option value="P">Retail</option>
                                  </select>
                                </td>
                        
                        </tr>
                        <tr> 
                          <td align="center"> 
                            Select Organisation </td>
                          <td align="center">Name of User</td>
                        
                        </tr>
                        <tr> 
                          <td align="center" valign="top"> 
                            <select name="rpselect1" size="11" style="width:130" onChange="refreshAppno()" tabindex="2">
                            </select>
                            </td>
                          <td align="center" valign="top"> 
                            <select name="selappno"  accesskey="" style="width:200"  multiple size="11" tabindex="3">
                            </select>
                            </td>
                          <td align="center" valign="top"> 
                          
                            </td>
                        </tr>
                        
                         <tr align="center"> 
                        <td align="center" colspan="2"> 
                           
                          <table class="outertable"  width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center"> 
                                      <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].cmdrunreport.focus();">
                                      <a href="#" onClick="showPeriod()"  tabindex="4"><b>?</b></a> 
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
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidOrgCode">
  <input type="hidden" name="hidAppno">
  <input type="hidden" name="hidOpFields">
  <input type="hidden" name="hidStatus">
  <input type="hidden" name="hidSelFields">
  <input type="hidden" name="userid">
  <input type="hidden" name="repname" value ="Personal Application Tracking Report">
  <input type="hidden" name="hidParam">
  <input type="hidden" name="hidPage" value="perrepuserstatus.jsp">
     <input type="hidden" name="hidOrgName">
<!--   <input type="hidden" name="txtDate" value='<%//=Helper.getCurrentDateTime()%>'>  -->
</form>
</body>
</html>
