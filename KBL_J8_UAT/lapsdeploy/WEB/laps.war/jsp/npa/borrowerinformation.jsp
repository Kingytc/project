 <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"/>
<laps:handleerror/>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
	out.println(hshValues);
 %>


<html>
<head>
<title>NPA - Borrower</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
-->
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
a:hover {  color: #FF3300}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<script language="JavaScript">
var id="<%=Helper.correctNull((String)hshValues.get("npa_no"))%>";
var strappno="<%=Helper.correctNull((String)hshValues.get("app_no"))%>";
var groupval="<%=hshValues.get("npa_action_group")%>";
var cancelflag="N";
var editlockflag="<%=hshValues.get("editlock")%>";
	var editflag = 1;
	var eFlag=false;
	var path="<%=ApplicationParams.getAppUrl()%>";
	var editcheck = "<%= request.getParameter("hideditflag")%>";


</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr> 
      <td valign="top" colSpan=5>
	  <jsp:include page="../share/menus.jsp" flush="true"/> 

		</td>
	    </tr>
		          <tr>
            <td valign="top" colSpan=5><b><i>NPA 
              Master</i></b></td>
          </tr>

 		</table>		
      </td>
    </tr>
 </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3">
          <tr align="center"> 
            <td width="20%" bgcolor="#71694F"> <b><font size="1" face="MS Sans Serif"><font color="#FFFFFF">Borrower 
              Info. </font> </font></b></td>
           
			  
       <!--       <td width="23%" bgcolor="#EEEAE3"> <b><font size="1" face="MS Sans Serif"><a href="JavaScript:gotoPage('npaworkhistory.jsp','getHistory')" class="blackfont">NPA 
              Workflow </a></font></b></td>-->
          </tr>
        </table>
      </td>
      <td width="280">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="400" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolor="#FFFFFF" align="center" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td colspan="2"> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr> 
                              <td width="15%"><font size="1" face="MS Sans Serif">NPA 
                                No. </font></td>
                              <td width="23%"> 
                                <input type="text" name="npano" value="<%=Helper.correctNull((String)hshValues.get("npa_no"))%>" size="15" readonly>
                              </td>
                              <td width="11%"><font size="1" face="MS Sans Serif">Branch</font></td>
                              <td width="25%"> 
                                <input type="text" name="branch" value="<%=Helper.correctNull((String)hshValues.get("org_name"))%>" size="15" readonly>
                              </td>
                              <td width="11%"><font size="1" face="MS Sans Serif">Zone</font></td>
                              <td width="18%"> 
                                <input type="text" name="zone" value="<%=Helper.correctNull((String)hshValues.get("org_level"))%>" size="15" readonly>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="5">
                            <tr> 
                              <td width="12%"><font size="1" face="MS Sans Serif">Borrower 
                                Name </font></td>
                              <td width="33%"> 
                                <input type="text" name="compname" value="<%=Helper.correctNull((String)hshValues.get("CBSAPP_NAME"))%>" size="25" readonly>
                              </td>
                              <td width="29%"><font size="1" face="MS Sans Serif">Loan 
                                Account No.</font></td>
                              <td width="26%"> 
                                <input type="text" name="loanno" size="15" value="<%//=Helper.correctNull((String)hshValues.get("VERIFY_DONEBY"))%>" readonly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="12%"><font size="1" face="MS Sans Serif">Address</font></td>
                              <td width="33%"> 
                                <input type="text" name="address1" size="25"
								value="<%=Helper.correctNull((String)hshValues.get("CBSAPP_ADDRESS"))%>" readonly>
                              </td>
                              <td><font size="1" face="MS Sans Serif">City</font></td>
                              <td>
                                <input type="text" name="city" size="25" value="<%//=Helper.correctNull((String)hshValues.get("VERIFY_DONEBY"))%>" readonly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="12%" height="34">&nbsp;</td>
                              <td width="33%" height="34"> 
                                <input type="text" name="address2" size="25" value="" readonly>
                              </td>
                              <td width="29%" height="34">&nbsp;</td>
                              <td width="26%" height="34">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td width="12%" height="34"><font size="1" face="MS Sans Serif">Pincode</font></td>
                              <td width="33%" height="34">
                                <input type="text" name="pin" size="12" value="<%//=Helper.correctNull((String)hshValues.get("VERIFY_DONEBY"))%>" readonly>
                              </td>
                              <td width="29%" height="34"><font size="1" face="MS Sans Serif">State</font></td>
                              <td width="26%" height="34"> 
                                <input type="text" name="state" size="15" value="<%//=Helper.correctNull((String)hshValues.get("VERIFY_DONEBY"))%>" readonly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="12%" height="34"><font size="1" face="MS Sans Serif">Phone 
                                Number </font></td>
                              <td width="33%" height="34">
                                <input type="text" name="phone" size="12" value="" readonly>
                              </td>
                              <td width="29%" height="34"><font size="1" face="MS Sans Serif">Nature 
                                of Industry</font></td>
                              <td width="26%" height="34"> 
                                <input type="text" name="nature" size="25" value="<%=Helper.correctNull((String)hshValues.get("CBSAPP_CONSTITUTION"))%>" readonly>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> 
                          <table width="60%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
   
                              <td width="5%"> 
                                <input type="checkbox" border="0" name="chk_action_group" value="" style="border-style:none">
                              </td>
                              <td width="17%"><font size="1" face="MS Sans Serif">
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
      </td>
    </tr>
  </table>

  <br>

  <table width="12%" border="1" cellspacing="0" cellpadding="0"
	align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	bgcolor="#DEDACF"> <tr> <td> <table width="43%" border="0" cellspacing="0" cellpadding="2"> 
<tr valign="top"> <td><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onClick="doEdit()"></td><td><input type="button" name="cmdapply" value="Save"
					class="buttonStyle"
					onClick="doSave()"></td><td><input type="button" name="cmdcancel" value="Cancel"
					class="buttonStyle"
					onClick="doCancel()"></td><td><input type="button" name="cmddel" value="Delete"
					class="buttonStyle"
					onClick="doDelete()"></td><td><input type="button" name="cmdhelp" value="Help"
					class="buttonHelp"
					onClick="dohlp()"></td><td><input type="button" name="cmdclose" value="Close"
					class="buttonClose"
					onClick="doClose()"> </td></tr> </table></td></tr> 
</table>
   
 
  <input type="hidden" name="npaoption" >

   <input type="hidden" name="hidBeanId" >
   <input type="hidden" name="hidTabName" >
   <!--  <input type="hidden" name="appno" >-->
   <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidMethod" >
  <input type="hidden" name="hidBeanGetMethod" >
  <input type="hidden" name="hideditflag">
<input type="hidden" name="hidcount" value="0">
</form>
</body>
</html>
