<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Applicant Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}

-->
</style>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappstatus.js">
</script>
<script>
<!--
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

function MM_timelineGoto(tmLnName, fNew, numGotos) { //v2.0
  //Copyright 1997 Macromedia, Inc. All rights reserved.
  var i,j,tmLn,props,keyFrm,sprite,numKeyFr,firstKeyFr,lastKeyFr,propNum,theObj;
  if (document.MM_Time == null) MM_initTimelines(); //if *very* 1st time
  tmLn = document.MM_Time[tmLnName];
  if (numGotos != null)
    if (tmLn.gotoCount == null) tmLn.gotoCount = 1;
    else if (tmLn.gotoCount++ >= numGotos) {tmLn.gotoCount=0; return}
  jmpFwd = (fNew > tmLn.curFrame);
  for (i = 0; i < tmLn.length; i++) {
    sprite = (jmpFwd)? tmLn[i] : tmLn[(tmLn.length-1)-i]; //count bkwds if jumping back
    if (sprite.charAt(0) == "s") {
      numKeyFr = sprite.keyFrames.length;
      firstKeyFr = sprite.keyFrames[0];
      lastKeyFr = sprite.keyFrames[numKeyFr - 1];
      if ((jmpFwd && fNew<firstKeyFr) || (!jmpFwd && lastKeyFr<fNew)) continue; //skip if untouchd
      for (keyFrm=1; keyFrm<numKeyFr && fNew>=sprite.keyFrames[keyFrm]; keyFrm++);
      for (j=0; j<sprite.values.length; j++) {
        props = sprite.values[j];
        if (numKeyFr == props.length) propNum = keyFrm-1 //keyframes only
        else propNum = Math.min(Math.max(0,fNew-firstKeyFr),props.length-1); //or keep in legal range
        if (sprite.obj != null) {
          if (props.prop2 == null) sprite.obj[props.prop] = props[propNum];
          else        sprite.obj[props.prop2][props.prop] = props[propNum];
      } }
    } else if (sprite.charAt(0)=='b' && fNew == sprite.frame) eval(sprite.value);
  }
  tmLn.curFrame = fNew;
  if (tmLn.ID == 0) eval('MM_timelinePlay(tmLnName)');
}
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

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="perappstat" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Applicant 
        Status </i></b></font></td>
    </tr>
    <tr> 
      <td align="right"><a href="javascript:;" onMouseDown="MM_timelineGoto('**** no timelines found ******\n            ','15');MM_swapImage('menubut','','<%=ApplicationParams.getAppUrl()%>img/menuopen.gif',1);sholyr()"><img src="<%=ApplicationParams.getAppUrl()%>img/menuclose.gif" width="90" height="24" border="0" name="menubut"></a> 
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="20" height="400" class="outertable border1">
    <tr> 
      <td valign="middle"> 
        <table border="0" cellspacing="0" cellpadding="3" align="center" width="60%" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                <tr> 
                  <td colspan="2" height="30"><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="25%" align="center"><font size="1" face="MS Sans Serif">Organizational 
                          Level</font><font size="1" face="MS Sans Serif"> </font></td>
                        <td width="25%" align="center"><font size="1" face="MS Sans Serif">Process 
                          Status</font></td>
                      </tr>
                      <tr> 
                        <td width="24%" align="center"><font size="1" face="MS Sans Serif"> 
                          <select name="sellevel" style="width:100" onChange="selectValues()" >
                            <option selected>--Select--</option>
                            <laps:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                          </select>
                          </font></td>
                        <td width="25%" align="center"> 
                          <select name="cmbstatus" style="width:100">
                            <option selected>----Select----</option>
                            <option value="p">Pending</option>
                            <option value="a">Approved</option>
                            <option value="r">Rejected</option>
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="75%" valign="top" colspan="2"><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"> 
                    </font> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr align="center"> 
                        <td align="center"><font face="MS Sans Serif" size="1">Select 
                          Organization </font></td>
                        <td align="center"><font face="MS Sans Serif" size="1">Select 
                          Output Fields </font></td>
                      </tr>
                      <tr align="center"> 
                        <td><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect1" size="11"  style="width:150" multiple >
                          </select>
                          </font></td>
                        <td><font size="1" face="MS Sans Serif"> 
                          <select name="rpselect2" size="11"  style="width:150"  multiple>
                            <option value="app_no">Application Number</option>
                            <option value="perapp_fname,perapp_lname">Applicant 
                            Name</option>
                            <option value="convert(varchar,app_createdate,103) as app_date">Applied 
                            Date</option>
                            <option value="app_status">Application Status</option>
                            <option value="mail_toflowpoint">Current Flowpoint</option>
                            <option value="convert(varchar,mail_date,103) as mail_date">Flowpoint 
                            Received Date</option>
                            <option value="wrk_flowname">Current Flowpoint Action</option>
                          </select>
                          </font></td>
                      </tr>
                      <tr align="center"> 
                        <td align="center"><font face="MS Sans Serif" size="1"> 
                          Period </font> </td>
                        <td><font face="MS Sans Serif" size="1"> 
                          <input type="text" name="txtDate" maxlength="21" readonly size="25" onFocus="document.forms[0].rprunreport.focus();">
                          <a href="JavaScript:showPeriod()" class="fontstyle"><b>?</b></a> 
                          </font></td>
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
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
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
                <input type="button" name="rphelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;width:50" >
              </div>
            </td>
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeData()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
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
</form>
</body>
</html>
