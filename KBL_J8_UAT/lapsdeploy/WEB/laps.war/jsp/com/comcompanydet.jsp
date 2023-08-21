<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
ArrayList g1= new ArrayList();

%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	
}

function call_page(url)
{
	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	
}

function change_select()
{
	if(document.forms[0].select_asset.value != "Standard")
	{
		document.all.labelchange.innerText="NPA Since";
	}
	else
	{
		document.all.labelchange.innerText="Nil";
	}

}

</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="frmpri" method = post>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" >
    <tr> 
      
    </tr>
  </table>
  <b><i>Basic Information</i></b><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> <laps:application/> </td>
    </tr>
    <tr> 
      <td valign="bottom">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="380" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                          <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
                            <tr> 
                              <td width="25%"  align="center" bgcolor="#71694F" id="prin"><b><font  color="#FFFFFF">Company</font></b></td>
                              <td width="17%"  align="center" bgcolor="#EEEAE3" id="prin"><font size="1" face="MS Sans Serif"><b><a href="javascript:call_page('compromdet.jsp')" class="blackfont">Promoters</a></b></font></td>
                              <td width="17%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('comactivitydet.jsp')" class="blackfont">Activities</a></font></b></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                  <tr> 
                                    <td colspan="6" height="121"> 
                                      <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                        <tr align="center" bgcolor="#EEEAE3"> 
                                          <td width="28%"><font size="1" face="MS Sans Serif">Name 
                                            of the Account</font></td>
                                          <td width="18%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Group</font></td>
                                          <td width="18%"><font size="1" face="MS Sans Serif">Zone</font></td>
                                          <td width="18%"><font size="1" face="MS Sans Serif">Region</font></td>
                                          <td width="18%"><font size="1" face="MS Sans Serif">Branch</font></td>
                                        </tr>
                                        <tr> 
                                          <td width="28%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("companyname"))%>&nbsp;</font></td>
                                          <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("group"))%>&nbsp; 
                                            </font></td>
                                          <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("zone"))%>&nbsp;</font></td>
                                          <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("region"))%>&nbsp;</font></td>
                                          <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("branch"))%>&nbsp;</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="16%"><font size="1" face="MS Sans Serif"><b>Nature 
                                      of Activity</b></font></td>
                                    <td width="16%"><font size="1" face="MS Sans Serif">&nbsp; 
                                      </font></td>
                                    <td colspan="2" align="center"><font size="1" face="MS Sans Serif"><b>Credit 
                                      Rating </b></font><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                    <td width="21%"><font size="1" face="MS Sans Serif"><b>&nbsp;Asset 
                                      Classification </b></font></td>
                                    <td width="18%"><font size="1" face="MS Sans Serif">&nbsp; 
                                      <select name="select_asset" size="1" onchange="change_select()">
                                        <option value="Standard" selected><font size="1" face="MS Sans Serif">Standard</font></option>
                                        <option value="SubStandard"><font size="1" face="MS Sans Serif">SubStandard</font></option>
                                        <option value="Doubtful"><font size="1" face="MS Sans Serif">Doubtful</font></option>
                                        <option value="Loss"><font size="1" face="MS Sans Serif">Loss</font></option>
                                      </select>
                                      </font> </td>
                                  </tr>
                                  <tr> 
                                    <td width="16%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="16%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="16%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif">Last 
                                      Year </font></td>
                                    <td width="13%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif">Current 
                                      Year</font></td>
                                    <td width="21%"><font size="1" face="MS Sans Serif"> 
                                      <b>Remark</b></font></td>
                                    <td width="18%"><font size="1" face="MS Sans Serif"><span  id="labelchange">Nil 
                                      </span></font></td>
                                  </tr>
                                  <tr> 
                                    <td width="16%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="16%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="13%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="21%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="18%"><font size="1" face="MS Sans Serif"></font></td>
                                  </tr>
                                  <tr> 
                                    <td width="16%">&nbsp;</td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="13%">&nbsp;</td>
                                    <td width="21%">&nbsp;</td>
                                    <td width="18%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="16%"><font size="1" face="MS Sans Serif"><b>ADDRESS</b></font></td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="13%">&nbsp;</td>
                                    <td width="21%">&nbsp;</td>
                                    <td width="18%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b>Registered 
                                      Off.</b></font><font size="1" face="MS Sans Serif"></font></td>
                                    <td colspan="2" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b>Corporate 
                                      Off.</b></font><font size="1" face="MS Sans Serif"></font></td>
                                    <td colspan="2" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b>Factory</b></font><font size="1" face="MS Sans Serif"></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("regoffaddress"))%>&nbsp;<br>
                                      &nbsp;<%=Helper.correctNull((String)hshValues.get("companycity"))%><br>
                                      <%=Helper.correctNull((String)hshValues.get("companystate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("companypin"))%>&nbsp;<br>
                                      Ph:<%=Helper.correctNull((String)hshValues.get("companyphone"))%>&nbsp;<br>
                                      Fax:<%=Helper.correctNull((String)hshValues.get("companyfax"))%>&nbsp;<br>
                                      </font></td>
                                    <td colspan="2"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("corpoffaddress"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("regoffcity"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("regoffstate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("regoffpin"))%>&nbsp;<br>
                                      Ph:<%=Helper.correctNull((String)hshValues.get("regoffphone"))%>&nbsp;<br>
                                      </font></td>
                                    <td colspan="2"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("factoffaddress"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("factoffcity"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("factoffstate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("factoffpin"))%>&nbsp;<br>
                                      Ph:<%=Helper.correctNull((String)hshValues.get("factoffphone"))%>&nbsp;<br>
                                      </font></td>
                                  </tr>
                                  <tr> 
                                    <td width="16%"><font size="1" face="MS Sans Serif"><b>Date 
                                      of Incorporation</b></font></td>
                                    <td width="16%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("dateofincorp"))%>&nbsp;</font></td>
                                    <td width="16%"><font size="1" face="MS Sans Serif"><b>Constitution</b></font></td>
                                    <td width="13%"><%=Helper.correctNull((String)hshValues.get("constitution"))%>&nbsp;<font size="1" face="MS Sans Serif"></font></td>
                                    <td width="21%"><font size="1" face="MS Sans Serif"><b>Dealing 
                                      with our bank since</b></font></td>
                                    <td width="18%"><font size="1" face="MS Sans Serif"></font></td>
                                  </tr>
                                  <tr align="center"> 
								  <td><font size="1" face="MS Sans Serif">
									Enter Your Comments</font>
								  </td>
                                    <td colspan="6" valign="middle"> 
                                      <p>
                                        <textarea name="companydet_comments" rows="6">
										</textarea>
                                      </p>
                                      <p>&nbsp;</p>
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
  <br>
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top">
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="changlbl('e')">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="saveContent()" >
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="click_cancel()">
              </div>
            </td>
			<td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="javascript:doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
