<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Organisation Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/reporgdetails.js">
</script>
<script>
<!--




var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
var curdate="<%=(String)Helper.getCurrentDateTime()%>";

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

function doClose()
{
	document.forms[0].action=path+"action/setuprepnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body >
<form name="orgfrm" method="post" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt;Setup -&gt; Reports 
        -&gt;Organisation 
        Details </td>
    </tr>
    
  </table>
  <br>
  
          <table class="outertable border1 tableBg" width="50%" border="0" cellspacing="0" cellpadding="5" align="center"  height="100%">
            <tr> 
              <td> 
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="77%"><font size="1" face="MS Sans Serif"> </font> 
                      </font> 
                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                        <tr> 
                          <td width="34%" align="center">Organisation 
                            Level </td>
                          <td width="34%" align="center"></td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center"> 
                            <select name="sellevel" style="width:150" onChange="selectValues()" >
                              <option selected>--Select--</option>
                              <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                            </select>
                             </td>
                          <td width="34%" align="center">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center">Select 
                            Organisation </td>
                          <td width="34%" align="center">Select 
                            Output Fields </td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center">  
                            <select name="rpselect1" size="11"  style="width:150"  >
                            </select>
                            </td>
                          <td width="34%" align="center"> 
                             
                            <select name="rpselect2" size="11"  style="width:150" multiple  
							>
                              <option value="org_name">Organisation Name</option>
                              <option value="org_add1">Address1</option>
                              <option value="org_add2">Address2</option>
                              <option value="org_city">City</option>
                              <option value="org_state">State</option>
                              <option value="org_zip">Pin Code</option>
                              <option value="org_phone">Phone No</option>
                              <option value="org_fax">Fax</option>
                              <option value="org_url">Email</option>
                            </select>
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
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
                  <td width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
   <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="bnklevel"  >
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="repname" value ="Organisation Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="runorgdetails.jsp">
</form>
</body>
</html>
