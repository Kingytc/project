<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Setup Organisation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
a:hover {  color: #FF3300}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/repsupuser.js">
</script>
<script>
<!--




var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
//-->
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</style>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<div class="menuitems" url=""></div>
</div>
<script language="JavaScript1.2">
if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}
</script>
<form name="orgfrm" method="post">
  <iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframeorgrep.jsp?hidBeanMethod=getData&hidMethod=getListValues&hidBeanId=setupreport&bnklevel="+bnkname></iframe> 
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        <font face="Times New Roman" size="3"><b><font face="MS Sans Serif">-&gt;</font> 
        <i> Setup</i><font face="MS Sans Serif"></font></b></font> -&gt; Reports 
        </i></b></font><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></font></b></font> 
        <font face="Times New Roman" size="3"><b><i>Supervisors and Users</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; 
	  		<jsp:include page="../share/help.jsp" flush="true"/> 
		</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="20" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table width="60%" border="0" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="77%"><font size="1" face="MS Sans Serif"> </font><font size="1" face="MS Sans Serif"> 
                      </font> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                        <tr> 
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif">Organisation
                            Level </font></td>
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif"></font></td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif"> 
                            <select name="sellevel" style="width:150" onChange="selectValues()" >
                              <option selected>--Select--</option>
                              <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                            </select>
                            </font> </td>
                          <td width="34%" align="center">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif">Select 
                            Organisation </font></td>
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif">Select 
                            Output Fields </font></td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center"> <font size="1" face="MS Sans Serif"> 
                            <select name="rpselect1" size="11"  style="width:150" multiple >
                            </select>
                            </font></td>
                          <td width="34%" align="center"><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font> 
                            <font size="1" face="MS Sans Serif"> 
                            <select name="rpselect2" size="11"  style="width:150" multiple  
							>
                              <option value="org_name">Organisation</option>
                              <option value="usr_id">User Id</option>
                              <option value="usr_fname">First Name</option>
                              <option value="usr_lname">Last Name</option>
                              <option value="usr_supid">Supervisor Name</option>
                              <option value="usr_class">Class</option>
                              <option value="usr_avail">Availability</option>
                              <option value="grp_name">Group Name</option>
                            </select>
                            </font></td>
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
  <table width="1%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="69%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:80" onClick="runrep()">
              </div>
            </td>
        <!--      <td height="0" width="16%"> 
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
                <input type="reset" name="rpreset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="JavaScript:resetValues()">
              </div>
            </td>
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" onClick="doHelp('setreports.htm#supervisorandusers')">
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
  <input type="hidden" name="hidBeanId" value="supuser">
<input type="hidden" name="hidSourceUrl" >
<input type="hidden" name="hidBeanGetMethod" >
<input type="hidden" name="hidBeanMethod" >

<input type="hidden" name="bnklevel"  >
<input type="hidden" name="hidAction">
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidMethod" >

<input type="hidden" name="userid" >
<input type="hidden" name="repname" value ="Supervisor and Users Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="runsupuserrep.jsp">
<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
