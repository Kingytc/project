<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror/>
<%
String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
%>
<html>
<head>
<title>Proposal</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varsancauth="<%=Helper.correctNull((String)hshValues.get("sancauth"))%>";
function placeValues()
{
	disableFields(true);
	if(varsancauth!="")
	{
		document.forms[0].sel_level.value=varsancauth;
	}
	else
	{
		document.forms[0].sel_level.value="0";
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
	
	document.forms[0].comments[1].readOnly=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="refno','datebst','signatures";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadgeneralcomments.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="broadsancterms"
	 	document.forms[0].hidpagedesc.value="refno','datebst','signatures";
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadgeneralcomments.jsp";
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
	enableButtons(true,true,true,true,false);
	document.forms[0].hidAction.value="update"
	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidpagedesc.value="refno','datebst','signatures";
	document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
	document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_broadgeneralcomments.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}

function callLink1(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidpagedesc.value="loanpolicy','customerprofitability";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="placeValues()">

<form name="frmpri" method=post>
<lapstab:applurllinkbst pageid='10' category='bst' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td class=page_flow>
Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; General Comments
</td>
</tr>
</table>
<laps:BST/>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td colspan="6">&nbsp;</td>
    </tr>
    <tr> 
      <td width="15%">Reference No</td>
      <td width="20%" > 
        <input type="text" name="comments" size="35" maxlength='30' value="<%=Helper.correctNull((String)hshValues.get("refno"))%>">
      </td>
      <td width="20%" >Date of Broad Terms Proposal</td>
      <td width="45%" >
        <input type="text" name="comments" size="12" maxlength='10' value="<%=Helper.correctNull((String)hshValues.get("datebst"))%>"
        onblur="checkDate(this);checkmaxdate(this,currentDate)">
        <a alt="Select date from calender" href="#"
					onClick="callCalender('comments[1]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;">&nbsp;<img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender"></a>
      </td>
    </tr>
    <tr>
      <td width="15%" >Sanctioning Authority</td>
      <td width="20%" > 
        <select name="sel_level">
          <option value="0" selected>&lt;---Select---&gt;</option>
          <option value="1">Branch</option>
          <option value="2">Regional</option>
          <option value="3">FGMO</option>
          <option value="4">CO GM</option>
          <option value="5">Executive Director</option>
          <option value="6">Managing Director</option>
          <option value="7">MCM</option>
        </select>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">Signatures</td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <textarea name="comments" cols="95" rows="10" 
           onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("signatures"))%></textarea>
      </td>
    </tr>
  </table>
                              
<br>
		<laps:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<laps:hiddentag/>
<input type="hidden" name="hidpagedesc" > 
</form>
</body>
</html>

