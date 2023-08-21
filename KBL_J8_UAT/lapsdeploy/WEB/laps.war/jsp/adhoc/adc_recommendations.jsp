<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<laps:handleerror/>
<%
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
%>
<html>
<head>
<title></title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorg_level="<%=Helper.correctNull((String)hshValues.get("remarksorglevel"))%>";
var varOrgLevel="<%=strOrgLevel%>";

function placeValues()
{
	disableFields(true);
	
	if(varorg_level!="")
	{
		document.forms[0].sel_level.value=varorg_level;
	}
	else
	{
		document.forms[0].sel_level.value="S";
	}
	
	if(varOrgLevel==varorg_level)
	{
		enableButtons(false,true,true,true,false);
	}
	else
	{
	  enableButtons(true,true,true,true,false);
	}
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="text")
			{
				document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_recommendations.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanMethod.value="updateRecommendations";
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_recommendations.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
}
function doSave()
{
		
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanMethod.value="updateRecommendations";
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_recommendations.jsp";
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

function getValues()
{
		document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_recommendations.jsp";
		document.forms[0].submit();
}

function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function doPrint()
{		
	var appno="<%=request.getParameter("appno")%>";
	var comappid ="<%=request.getParameter("com_id")%>";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/adc_printout.jsp?hidBeanGetMethod=getADCApprovalprint&hidBeanId=adhoc&appno="+appno+"&comappid="+comappid;
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="placeValues()">
<form name="remarks" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="8" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home-&gt;Corporate &amp; SME -&gt; Ad hoc Limit -&gt; Recommendations</td>
	</tr>
</table>
<span style="visibility:visible;"><laps:borrowertype /></span> <laps:application/>

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="14%">Select Organisation </td>
      <td> 
        <select name="sel_level" onChange="getValues()" tabindex="1">
          <option value="S" selected="selected">&lt;---Select---&gt;</option>
          <option value="C">Central Office</option>
          <option value="R">FGMO</option>
          <option value="D">Region</option>
          <option value="A">Branch</option>
        </select>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="14%">Ref No.</td>
      <td width="37%"> 
        <input type="text" name="txt_refno" size="30" maxlength="18" value="<%=Helper.correctNull((String)hshValues.get("recommrefno"))%>" tabindex="2">
      </td>
      <td width="19%">Date :</td>
      <td width="30%"> 
        <input type="text" name="txt_date" size="12" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("recommdate"))%>" onBlur="checkDate(this)" tabindex="3">
        <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;">&nbsp;<img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="4"> Recommendation</td>
    </tr>
    <tr> 
      <td  colspan="4"> 
        <textarea name="txt_recommendation" cols="100" wrap="VIRTUAL" rows="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("recommcomments"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="4">Signatures</td>
    </tr>
    <tr> 
      <td  colspan="4"> 
        <textarea name="txt_signatures" cols="105" wrap="VIRTUAL" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="5"><%=Helper.correctNull((String)hshValues.get("recommsignatures"))%></textarea>
      </td>
    </tr>
  </table>
                              
<br>
<laps:combutton btntype="EP" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<laps:hiddentag/>
</form>
</body>
</html>

