<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Reports - User Definition</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
a:hover {  color: #FF3300}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/repuserdef.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
<!--




var bnkname ="";
var path="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
//-->
</script>
</head>

<body >
<form name="orgfrm" method = "post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframeorgrep.jsp?hidBeanMethod=getData&hidMethod=getListValues&hidBeanId=setupreport&bnklevel="+bnkname></iframe> 
  <div align="center">
    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td>Home-&gt; Setup-&gt; Reports-&gt;User Definition </td>
      </tr>
    </table>
    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center" >
      <tr> 
        <td valign="top" height="0"> 
          <div align="left">
          <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr> 
              <td> 
                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" >
                  <tr> 
                    <td height="0" valign="top"> 
                      <div align="center"> 
                        <table class="outertable border1 tableBg"  width="55%" border="0" cellspacing="0" cellpadding="10" align="center">
                          <tr> 
                            <td> 
                              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                                <tr align="center" class="dataheader"> 
                                  <td width="26%" >Organisation 
                                    Level</td>
                                  
                                  <td width="26%" > 
                                    Availability</td>
                                </tr>
                                <tr align="center">
                                <td width="26%"> 
                                    <select name="sellevel" style="width:100;margin-bottom:8px;"
										  onChange="selectValues()" >
                                      <option selected>--Select--</option>
                                      <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                                    </select>                                </td>
                                <td width="26%"> 
                                    <select name="selavail" style="width:100;margin-bottom:8px;"
										  onChange="selectAvail()">
                                      <option selected>--Select-- </option>
                                      <option value="a">Available</option>
                                      <option value="u">Un Available</option>
                                    </select>                                </td>
                                </tr>
								<tr > 
                                  <td colspan="2" class="dataheader" >
								  <table  border="0" cellspacing="0" cellpadding="0" width="100%" class="outertable" >
                                  
                                  <tr align="center" style="color:#fff;"> 
                                        <td>Select 
                                          Organisation </td>
                                        <td>Select 
                                          Class</td>
                                        <td>Select 
                                          Output Fields</td>
                                      </tr>
                                      </table>
								  </td>
								  </tr>
                                <tr> 
                                  <td colspan="4">
                                    
                                    <table class="outertable"  border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                      <tr align="center"> 
                                        <td> 
                                          <select name="rpselect1" size="11"  style="width:150"  multiple>
                                          </select>                                          </td>
                                        <td> 
                                          <select name="selclass" size="11" style="width:135"  multiple>
                                            <lapschoice:reptag beanid="userdef" methodname="getUserClass" param="" /> 
                                          </select>                                          </td>
                                        <td> 
                                          <select name="rpselect2" size="11" style="width:135"  multiple>
                                            <option value="org_name">Organisation</option>
                                            <option value="usr_class">Class</option>
                                            <option value="usr_id">User Id</option>
                                            <option value="usr_fname">First Name</option>
                                            <option value="usr_lname">Last Name</option>
                                            <option value="usr_avail">Availability</option>
                                            <option value="grp_name">Group Name</option>
                                            <option value="user_designation">Designation</option>
                                            <!-- <option value="usr_supid">Supervisor 
                                            Name</option>
											<option value="usr_mname">Employee Code</option>-->
                                          </select>                                          </td>
                                      </tr>
                                    </table>
                                    <div align="center"></div>                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </div>
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
  </div>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidClass"  >
  <input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
    <input type="hidden" name="hidParam">
	<input type="hidden" name="repname" value ="User Definition Report">
	<input type="hidden" name="hidPage" value="runuserdefrep.jsp">
	<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
  </form>
</body>
</html>
