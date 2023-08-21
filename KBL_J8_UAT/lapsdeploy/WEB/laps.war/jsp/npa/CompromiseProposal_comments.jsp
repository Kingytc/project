<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function onLoading()
{
   	disableFields(true);
}
function doEdit()
{ 	
	disableCommandButtons(true,false,false,false,true);
    disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	document.forms[0].txt_settlementproposal.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getcompromisecomments";
		document.forms[0].action=appUrl +"action/CompromiseProposal_comments.jsp";
		document.forms[0].submit(); 		
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_comments.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatecompromisecomments";
		document.forms[0].hidBeanGetMethod.value="getcompromisecomments";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}
}
function doSave()
{
	if(document.forms[0].txt_claimdetails.value=="")
	{
		alert("Enter ECGC/DICGC/CGFT Claim");
		document.forms[0].txt_claimdetails.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_comments.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updatecompromisecomments";
	document.forms[0].hidBeanGetMethod.value="getcompromisecomments";
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

<body class="bgcolor" onload="onLoading()">
<form name="comp1" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:otscourltag pageid="6"/>
					</td>
				</tr>
				  <tr> 
           <td valign="top" class="page_flow">Home -&gt; NPA -&gt; Compromise Proposal -&gt; Comments   
</td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication /><br>
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />		
  <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
    <tr class="dataheader"> 
      <td  align="center"><b>SETTLEMENT PROPOSAL</b></td>
      <td  align="center"><b>SCHEDULE OF PAYMENT</b></td>
    </tr>
    <tr class="datagrid"> 
      <td align="center"> 
        <textarea name="txt_settlementproposal" cols="80" rows="10" tabindex="1"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()" onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("settlementproposal"))%></textarea>
      </td>
      <td align="center"> 
        <textarea name="txt_paymentschedule" cols="80" rows="10" tabindex="2"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()"  onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("paymentschedule"))%></textarea>
      </td>
    </tr>
   
    <tr class="dataheader"> 
      <td  align="center"><b>SOURCE OF PAYMENT</b></td>
      <td  align="center"><b>ECGC/DICGC/CGFT CLAIM <span class="mantatory">*&nbsp;</span></b></td>
    </tr>
    <tr class="datagrid"> 
      <td align="center"> 
        <textarea name="txt_paymentsource" cols="80" rows="10" tabindex="3"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()" onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("paymentsource"))%></textarea>
      </td>
      <td align="center">  
        <textarea name="txt_claimdetails" cols="80" rows="10" tabindex="4"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()" onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("claimdetails"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td  align="center"><b>BIFR STATUS</b></td>
      <td  align="center"><b>NON FUND BASED DUES AND PROPOSED TREATMENT</b></td>
    </tr>
    <tr class="datagrid"> 
      <td align="center"> 
        <textarea name="txt_bifrstatus" cols="80" rows="10" tabindex="5"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()" onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("bifrstatus"))%></textarea>
      </td>
      <td align="center"> 
        <textarea name="txt_nfbduestreatment" cols="80" rows="10" tabindex="6"
		onKeyPress="textlimit(this,3950);notAllowSingleQuote()" onKeyUp="textlimit(this,3950)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("nfbduestreatment"))%></textarea>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
