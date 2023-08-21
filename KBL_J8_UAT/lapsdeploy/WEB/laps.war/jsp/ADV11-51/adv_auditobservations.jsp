<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<%
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

if(strCategoryType.equals("CORPORATE"))
{
	strCategoryType ="CORP";
}

%>
<html>
<head>
<title>Audit observations</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varAudittype="<%=Helper.correctNull((String)hshValues.get("audittype"))%>";

function doEdit()
{
	if(document.forms[0].sel_audittype.value=="0")
	{
		ShowAlert(111,'Audit Type');
		document.forms[0].sel_audittype.focus();
	}
	else
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		disableCommandButtons("edit");	
	}

}

function changeAuditType()
{	
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getAuditObservations";
	document.forms[0].hidSourceUrl.value="/action/adv_auditobservations.jsp"
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/adv_auditobservations.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateAuditObservations";
		document.forms[0].hidBeanGetMethod.value="getAuditObservations";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}	
	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/adv_auditobservations.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateAuditObservations";
		document.forms[0].hidBeanGetMethod.value="getAuditObservations";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function doSave()
{
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanMethod.value="updateAuditObservations";
	document.forms[0].hidBeanGetMethod.value="getAuditObservations";
	document.forms[0].hidSourceUrl.value="/action/adv_auditobservations.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		 
	}
	document.forms[0].txt_dateaudited.readOnly=true;
	
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		if(document.forms[0].appstatus.value=="Open/Pending")
    		document.forms[0].cmdedit.disabled=false;
    	else
    		document.forms[0].cmdedit.disabled=true;
		
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddel.disabled=true;		
		document.forms[0].cmdclose.disabled=false;
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmddel.disabled=false;		 		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}
function onLoading()
{
	disableCommandButtons("load");
	if(varAudittype!="")
	{
		document.forms[0].sel_audittype.value=varAudittype;
	}
}

function callLink(page,bean,method)
{		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
}

function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body class="bgcolor" onload="onLoading()">
<form name="frmteraudit" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i> Home -&gt;
Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Audit Observations</i></b>
<br>
<span style="display:none"><laps:borrowertype /></span> <laps:application />
  <table width="100%" border="0" cellspacing="0" cellpadding="3"  
	class="outertable border1 shadow"  align="center">
    <tr> 
      <td align="center" colspan="4"><b>AUDIT OBSERVATIONS</b></td>
    </tr>
    <tr> 
      <td width="23%">Type of Audit</td>
      <td width="28%"> 
        <select name="sel_audittype" onChange="changeAuditType()" tabindex="1">
          <option value="0" selected="selected">--Select--</option>
          <option value="1">Internal Audit</option>
          <option value="2">RBI audit</option>
          <option value="3">Concurrent Audit</option>
          <option value="4">Statutory audit</option>
          <option value="5">Stock Audit</option>
        </select>
      </td>
      <td width="10%">Date of Audit</td>
      <td width="39%"> 
         <table border="0" width="10%" cellspacing="0" cellpadding="3">
         	<tr> 
            	<td> 
                	<input type="text" name="txt_dateaudited" size="11"
					value="<%=Helper.correctNull((String)hshValues.get("dateaudited"))%>"
					onBlur="checkDate(this);checkmaxdate(this,currentDate)"
					maxlength="12">
               </td>
               <td><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_dateaudited')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
					alt="Select date from calender" tabindex="29"></a>
				</td>
			</tr>
		</table>
      </td>
    </tr>
    <tr> 
      <td width="23%">Auditors Observations</td>
      <td colspan="8"> 
        <textarea  name="txt_auditorsobservations" cols="50" rows="5" tabindex="2" 
        	onKeyPress="textlimit(this,3998)" 
           	onkeyup="textlimit(this,3998)"><%=Helper.correctNull((String)hshValues.get("auditorsobservations"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="23%">Branch Comments</td>
      <td colspan="3"> 
        <textarea rows="5" name="txt_branchcomments" cols="50" tabindex="3"
        onKeyPress="textlimit(this,3998)" 
           	onkeyup="textlimit(this,3998)"><%=Helper.correctNull((String)hshValues.get("branchcomments"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="23%">Replies/Action Taken/ PresentPosition</td>
      <td colspan="3"> 
        <textarea rows="5" name="txt_replies" cols="50" tabindex="4" 
        onKeyPress="textlimit(this,3998)" 
           	onkeyup="textlimit(this,3998)"><%=Helper.correctNull((String)hshValues.get("replies"))%></textarea>
      </td>
    </tr>
  </table>
<br>
<table width="12%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center" dwcopytype="CopyTableRow">
	<tr> 
    	<td> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="2">
        		<tr>
					<td align="center"><input type="button" name="cmdedit" value="Edit" tabindex="5"
						class="buttonStyle" onclick="doEdit()"></td>
					<td align="center"><input type="button" name="cmdapply"
						value="Save" tabindex="6" class="buttonStyle" onclick="doSave()"></td>
					<td align="center"><input type="button" name="cmdcancel"
						value="Cancel" tabindex="7" class="buttonStyle" onclick="doCancel()"></td>
					<td align="center"><input type="button" name="cmddel"
						value="Delete" tabindex="8" class="buttonStyle" onclick="doDelete()"></td>				
					<td align="center"><input type="button" name="cmdclose"
						value="Close" tabindex="9" class="buttonClose" onclick="doClose()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr> 
       <td width="20%" align="left"><b>&nbsp;
        <a href="javascript:callLink('adv_borrowerexp.jsp','ADV1151','getADVBorrowerExp')" class="blackfont"> 
           &lt;&lt; Previous </a>&nbsp;</b>
      </td>
      <td width="60%" align="center"><b>
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.18/20&nbsp;
        <a href="javascript:callLink('adv_termloancomments.jsp','ADV1151','gettermloancomments')" class="blackfont"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>

<laps:hiddentag/>
</form>
</body>
</html>
