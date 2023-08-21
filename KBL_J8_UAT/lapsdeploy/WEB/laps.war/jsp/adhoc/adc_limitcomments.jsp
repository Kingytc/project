<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function placevalues()
{
	disableFields(true);
}

function doCancel(url,method)
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getLimitSought";
		document.forms[0].action=appURL+"action/adc_limitcomments.jsp";
		document.forms[0].submit();
	}
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
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateLimitSought";
	document.forms[0].hidBeanGetMethod.value="getLimitSought"
	document.forms[0].hidSourceUrl.value="/action/adc_limitcomments.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanMethod.value="updateLimitSought";
		document.forms[0].hidBeanGetMethod.value="getLimitSought"
		document.forms[0].hidSourceUrl.value="/action/adc_limitcomments.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
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

<body  onload="placevalues()">

<form name="frmprojectedsales" method ="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="11" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
</tr>
<tr>
		<td class="page_flow">Home-&gt;Corporate &amp; SME -&gt; Ad hoc Limit-&gt; Limit Sought</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                       <tr>
					  <td width="60%" valign="top" >
					  <textarea name="txtarea_limitcomment" cols="110" rows="30" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("limit_comment"))%></textarea>
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
	<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
<script language="javascript1.2">
editor_generate('txtarea_limitcomment');
</script> 
</html>
