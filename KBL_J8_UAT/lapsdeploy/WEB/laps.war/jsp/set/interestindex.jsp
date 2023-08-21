
<%@ page import="com.sai.laps.helper.*" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<title>LAPS(Interest Index)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
</style>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
	 <script language="JavaScript1.2"> 
	 var appURL = "<%=ApplicationParams.getAppUrl()%>";
	 </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/set/interestindex.js"></script>
<script language="JavaScript">
	
	var mdrlabel1='';
	var mdrlabel2='';
	var madrlabel3='';


	function loadValues()
	{
		mdrlabel1 = "<%=Helper.correctNull((String)hshValues.get("mdrlabel1"))%>";
		mdrlabel2 = "<%=Helper.correctNull((String)hshValues.get("mdrlabel2"))%>";
		mdrlabel3 = "<%=Helper.correctNull((String)hshValues.get("mdrlabel3"))%>";
		mdrrate1 = "<%=Helper.correctNull((String)hshValues.get("mdrrate1"))%>";
		mdrrate2 = "<%=Helper.correctNull((String)hshValues.get("mdrrate2"))%>";
		mdrrate3 = "<%=Helper.correctNull((String)hshValues.get("mdrrate3"))%>";
		type1label = "<%=Helper.correctNull((String)hshValues.get("type1label"))%>";
		type2label = "<%=Helper.correctNull((String)hshValues.get("type2label"))%>";
		type3label = "<%=Helper.correctNull((String)hshValues.get("type3label"))%>";
		typerate1 = "<%=Helper.correctNull((String)hshValues.get("typerate1"))%>";
		typerate2 = "<%=Helper.correctNull((String)hshValues.get("typerate2"))%>";
		typerate3 = "<%=Helper.correctNull((String)hshValues.get("typerate3"))%>";
		wclabel1 = "<%=Helper.correctNull((String)hshValues.get("wclabel1"))%>";
		wcrate1 = "<%=Helper.correctNull((String)hshValues.get("wcrate1"))%>";
		wclabel2 = "<%=Helper.correctNull((String)hshValues.get("wclabel2"))%>"; 
		wcrate2 = "<%=Helper.correctNull((String)hshValues.get("wcrate2"))%>";
		wclabel3 = "<%=Helper.correctNull((String)hshValues.get("wclabel3"))%>";
		wcrate3 = "<%=Helper.correctNull((String)hshValues.get("wcrate3"))%>";
		wclabel4 = "<%=Helper.correctNull((String)hshValues.get("wclabel4"))%>";
		wcrate4 = "<%=Helper.correctNull((String)hshValues.get("wcrate4"))%>";
		wclabel5 = "<%=Helper.correctNull((String)hshValues.get("wclabel5"))%>";
		wcrate5 = "<%=Helper.correctNull((String)hshValues.get("wcrate5"))%>";
		wclabel6 = "<%=Helper.correctNull((String)hshValues.get("wclabel6"))%>";
		wcrate6 = "<%=Helper.correctNull((String)hshValues.get("wcrate6"))%>";
		placeValues();
	}


	function placeValues()
	{
		document.frm1.mdrlabel1.value = mdrlabel1;
		document.frm1.mdrlabel2.value = mdrlabel2;
		document.frm1.mdrlabel3.value = mdrlabel3;
		document.frm1.mdrrate1.value = mdrrate1;
		document.frm1.mdrrate2.value = mdrrate2;
		document.frm1.mdrrate3.value = mdrrate3;
		document.frm1.type1label.value = type1label;
		document.frm1.type2label.value = type2label;
		document.frm1.type3label.value = type3label;
		document.frm1.typerate1.value = typerate1;
		document.frm1.typerate2.value = typerate2;
		document.frm1.typerate3.value = typerate3;
		document.frm1.wclabel1.value = wclabel1;
		document.frm1.wclabel2.value = wclabel2;
		document.frm1.wclabel3.value = wclabel3;
		document.frm1.wcrate1.value = wcrate1;
		document.frm1.wcrate2.value = wcrate2;
		document.frm1.wcrate3.value = wcrate3;
		document.frm1.wclabel4.value = wclabel4;
		document.frm1.wclabel5.value = wclabel5;
		document.frm1.wclabel6.value = wclabel6;
		document.frm1.wcrate4.value = wcrate4;
		document.frm1.wcrate5.value = wcrate5;
		document.frm1.wcrate6.value = wcrate6;
		if("<%=hshValues.get("moddate")%>"!="null")
		{
			document.frm1.moddate.value = "<%=hshValues.get("moddate")%>";
			document.frm1.hidModDate.value = "<%=hshValues.get("moddate")%>";
		}
		else
		{
			document.frm1.moddate.value = "<%=Helper.getCurrentDateTime()%>";
			document.frm1.hidModDate.value = "<%=Helper.getCurrentDateTime()%>";
		}

	}


</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" onLoad="setButtons()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name=frm1 method=post action="<%=ApplicationParams.getAppUrl()%>controllerservlet">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr> 
      <td valign="top" colSpan=5>
	  		<jsp:include page="../share/help.jsp" flush="true"/> 
		</td>
	    </tr>
 		</table>		
      </td>
    </tr>
 </table>

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home </i><font face="MS Sans Serif">-&gt;</font> 
        <i>Setup </i><font face="MS Sans Serif">-&gt;</font> <i>Interest Index 
        </i></b></font></td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="400" class="outertable border1" >
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="48%" border="0" cellspacing="0" cellpadding="0" align="right">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Modified 
                                Date</font></td>
                              <td width="74%"> 
                                <input type="text" name="moddate" size="16" readonly  value="">
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"  >
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="89">
                            <tr> 
                              <td colspan="2" height="20"><font  color="#FFFFFF"><b><font color="#000000">&nbsp;Market 
                                Defined Rates</font></b></font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;MDR 
                                Label1</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrlabel1" size="25" maxlength="30" tabindex="1" value="" >
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrrate1" size="10" maxlength="6" 
								  value= "" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="2" style="text-align:right">
                                </font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;MDR 
                                Label2</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrlabel2" size="25" maxlength="30"  value="" tabindex="3">
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrrate2" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="4" style="text-align:right">
                                </font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;MDR 
                                Label3</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrlabel3" size="25" maxlength="30"  value="" tabindex="5">
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="mdrrate3" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="6" style="text-align:right">
                                </font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
                      <tr> 
                        <td height="111"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%">
                            <tr> 
                              <td colspan="4" height="20"><font  color="#FFFFFF"><b><font color="#000000">&nbsp;Bank 
                                Defined Rates</font></b></font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;Type1 
                                Label</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="type1label" size="25" maxlength="30"  value="" tabindex="7">
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="typerate1" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="8" style="text-align:right">
                                </font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;Type2 
                                Label</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="type2label" size="25" maxlength="30"  value="" tabindex="9">
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="typerate2" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="10" style="text-align:right">
                                </font></td>
                            </tr>
                            <tr> 
                              <td width="21%"><font size="1" face="MS Sans Serif">&nbsp;Type3 
                                Label</font></td>
                              <td width="31%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="type3label" size="25" maxlength="30"  value="" tabindex="11">
                                </font></td>
                              <td width="12%"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="36%"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="typerate3" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="12" style="text-align:right">
                                </font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="1" height="80" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"  >
                      <tr> 
                        <td valign="top"> 
                          <div align="left"></div>
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                            <tr> 
                              <td colspan="8" height="20"><font  color="#FFFFFF"><b><font color="#000000"> 
                                Priority Sector Rates</font></b></font></td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type1 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel1" size="25" maxlength="30"  value="" tabindex="13">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate1" size="10" maxlength="6" value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="14" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type2 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel2" size="25" maxlength="30"  value="" tabindex="15">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate2" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="16" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type3 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel3" size="25" maxlength="30"  value="" tabindex="17">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate3" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="18" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type4 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel4" size="25" maxlength="30"  value="" tabindex="19">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate4" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="20" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type5 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel5" size="25" maxlength="30"  value="" tabindex="21">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate5" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="22" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                            <tr bordercolor="#CCCCCC"> 
                              <td width="157"><font size="1" face="MS Sans Serif">&nbsp;Type6 
                                Label</font></td>
                              <td width="236"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wclabel6" size="25" maxlength="30"  value="" tabindex="23">
                                </font></td>
                              <td width="89"><font size="1" face="MS Sans Serif">Rate 
                                in %</font></td>
                              <td width="226"><font size="1" face="MS Sans Serif"> 
                                <input type="text" name="wcrate6" size="10" maxlength="6"  value="" onKeyPress="allowNumber(this)" onBlur="validatePer(this)" tabindex="24" style="text-align:right">
                                </font></td>
                              <td colspan="4" width="51">&nbsp;</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <input type=hidden name="hidBeanId" value="setintindex" >
              <input type=hidden name="hidBeanMethod" value="updateData" >
              <input type=hidden name="hidSourceUrl" value="/action/interestindex.jsp" >
              <input type=hidden name="hidModDate" value="">
        </table>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" >
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="2" align="center">
          <tr valign="middle"> 
            <td> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" class="buttonStyle" onClick="onEditMode()">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" class="buttonStyle" onClick="submitme()" tabindex="25">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" class="buttonStyle" onClick="onCancel()" tabindex="26">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" class="buttonHelp" tabindex="27" onClick="doHelp('intindex.htm')">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose"  onclick="windowclosing()">
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
