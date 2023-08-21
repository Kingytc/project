<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<laps:handleerror />
<%
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function placevalues()
{
	//enableButtons(false,true,true,true,false);
	disableFields(true);
	
}

function doCancel()
{
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanGetMethod.value="getGuaranteeData"
	document.forms[0].action=appURL+"action/adc_guaranteecomments.jsp";
	document.forms[0].submit();
	
}

function doClose()
{
   	if(ConfirmMsg(100))
 	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
 	}
}

function doEdit()
{		
	enableButtons(true,false,false,false,true);
	disableFields(false);
	document.forms[0].hidAction.value="Update";
}

function doSave()
{
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateGuaranteeData";
	document.forms[0].hidBeanGetMethod.value="getGuaranteeData"
	document.forms[0].hidSourceUrl.value="/action/adc_guaranteecomments.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateGuaranteeData";
	document.forms[0].hidBeanGetMethod.value="getGuaranteeData"
	document.forms[0].hidSourceUrl.value="/action/adc_guaranteecomments.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}

}
</script>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="placevalues()">
<form name="frmprojectedsales" method = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="4" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class=page_flow>Home-&gt;Corporate &amp; SME -&gt; Ad hoc Limit-&gt; Guarantee</td>
	</tr>
</table>
<span style="visibility:visible;"><laps:borrowertype /></span> <laps:application/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="5" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                       <tr>
					  <td width="60%" valign="top" >
					  <textarea name="txtarea_guarantee" width="550" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("guarantee_comment"))%></textarea>
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
	<laps:combutton	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btntype="EO" /> 
<laps:hiddentag />
</form>
</body>
<script language="javascript1.2">
editor_generate('txtarea_guarantee');
</script> 
</html>
