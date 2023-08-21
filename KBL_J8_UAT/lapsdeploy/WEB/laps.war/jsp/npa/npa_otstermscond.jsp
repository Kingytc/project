<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>OTS TERMS &amp; CONDITIONS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

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

function onLoading()
{
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/npa_otstermscond.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getcompromisetermscond";
		document.forms[0].hidBeanMethod.value="getcompromisetermscond";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_otstermscond.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatecompromisetermscond";
		document.forms[0].hidBeanGetMethod.value="getcompromisetermscond";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}


}
function doSave()
{
	document.forms[0].hidSourceUrl.value="/action/npa_otstermscond.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updatecompromisetermscond";
	document.forms[0].hidBeanGetMethod.value="getcompromisetermscond";
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
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

</script>

</head>


<body onload="onLoading()">
<form name="otstermscond" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:otscourltag pageid="12"/>
					</td>
				</tr>
				<tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Compromise Proposal   -&gt; Terms &amp; condition    
 </td>
          </tr>
          <tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
  <tr> 
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td  align="center"><b>TERMS AND CONDITIONS</b></td>
          </tr>
          <tr> 
            <td align="center"> 
              <textarea name="txt_termscond" rows="10" cols="80" tabindex="4"
			  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("termscond"))%></textarea>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
