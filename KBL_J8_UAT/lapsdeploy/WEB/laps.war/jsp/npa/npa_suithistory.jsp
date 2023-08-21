<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
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
	document.forms[0].txt_briefhistory.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appUrl+"action/npa_suithistory.jsp";
		document.forms[0].submit();	
	}	
}
function doSave()
{
	if(document.forms[0].txt_briefhistory.value=="")
	{
		alert("Enter the brief History");
		document.forms[0].txt_briefhistory.focus();
		return;
	}
	if(document.forms[0].txt_irregularreasons.value=="")
	{
		alert("Enter the Reasons for irregularity");
		document.forms[0].txt_irregularreasons.focus();
		return;
	}
	if(document.forms[0].txt_recoverduesteps.value=="")
	{
		alert("Enter the action plan for recovering the securities");
		document.forms[0].txt_recoverduesteps.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/npa_suithistory.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
	document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_suithistory.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
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

</script>
</head>
<body onload="onLoading()">
<form name="frmsuithistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:suiturltag pageid="15"/>
					</td>
				</tr>
				<tr> 
           <td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing of Suit -&gt;History 
 </td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <tr> 
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td>Brief History of the account from the date of availing facilities first with dates and detailed particulars of the changes in constitution. together with a renewals of the limit (s) from time
to time and security documents taken. etc. <span class="mantatory">*&nbsp;</span>
</td>
          </tr>
          <tr> 
                  <td> 
                    <textarea name="txt_briefhistory" cols=90 rows=7  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("briefhistory"))%></textarea>
                  </td>
                </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>When and what were the signs and symptoms of the
				irregularities/ sickness. etc. in the account first observed and the
				remedial measures taken <span class="mantatory">*&nbsp;</span></td>
          </tr>
          <tr> 
                  <td> 
                    <textarea name="txt_irregularreasons" cols=90 rows=7 onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("irregularreasons"))%></textarea>
                  </td>
                </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          
         
          <tr> 
            <td>Please elaborate the actions taken by your branch for the
				safeguard of the securities held and the recovery of the outstanding
				advance granted to the borrower <span class="mantatory">*&nbsp;</span></td>
          </tr>
          <tr> 
                        <td width="57%"> 
                          <textarea name="txt_recoverduesteps" rows="7" cols="90" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("recoverduesteps"))%></textarea>
                        </td>
                      </tr>
        </table>
    </td>
  </tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>

