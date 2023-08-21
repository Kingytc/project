<%@include file="../share/directives.jsp"%>
<%String category = Helper.correctNull((String) request.getParameter("hidcatory"));
String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }
 }
function onLoading()
{
	disableCommandButtons("load");	
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateDefaultersListData";
			document.forms[0].hidBeanGetMethod.value="getDefaultersListData";
			document.forms[0].hidBeanId.value="broadsancterms";
			document.forms[0].hidSourceUrl.value="action/combst_defaulterslist.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{		
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanGetMethod.value="getDefaultersListData";
		document.forms[0].action=appUrl +"action/combst_defaulterslist.jsp";
	    document.forms[0].submit();	
	}	
}
	function doSave()
	{
		document.forms[0].cmdsave.disabled=true;
	    document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanMethod.value="updateDefaultersListData";
		document.forms[0].hidBeanGetMethod.value="getDefaultersListData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/combst_defaulterslist.jsp";
		document.forms[0].submit();
	}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}	
}
function doClose()
{
   if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<lapstab:applurllinkbst pageid='12' category='<%=category%>' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Defaulters List</td>
	</tr>
</table>
<lapschoice:BST />
<br>
    <table width="73%" border="0" cellspacing="1" cellpadding="5" align="center" class="outertable border1">
      <tr> 
        <td align="center"> 
          <textarea name="txt_defaulterslist" cols="120" rows="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("cd_comments"))%></textarea>          
        </td>
        </tr>
        </table>
        <br>
        <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
  </form>
</body>
<script language="javascript1.2">
editor_generate('txt_defaulterslist');
</script>
</html>

