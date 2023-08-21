<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>OTS TERMS &amp; CONDITIONS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varsancauth="<%=Helper.correctNull((String)hshValues.get("sancauth"))%>";

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function disableCommandButtons(val)
{
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
	//disableCommandButtons("load");
	if(varsancauth!="")
	{
		document.forms[0].selsancauth.value=varsancauth;
	}
	changemcmdetails();
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
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getsignatories";
		document.forms[0].action=appURL +"action/npa_sarfisignatories.jsp";
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_sarfisignatories.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatesignatories";
		document.forms[0].hidBeanGetMethod.value="getsignatories";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}


}
function doSave()
{
	document.forms[0].hidSourceUrl.value="/action/npa_sarfisignatories.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatesignatories";
	document.forms[0].hidBeanGetMethod.value="getsignatories";
	document.forms[0].action=appURL+"controllerservlet";
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
		else if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			  document.forms[0].elements[i].disabled=val;		  
		}	  
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appURL+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function changemcmdetails()
{
	if(document.forms[0].selsancauth.value=='7')
	{
		document.all.idmcm.style.visibility="visible";
		document.all.idmcm.style.position="relative";
	}
	else
	{
		document.all.idmcm.style.visibility="hidden";
		document.all.idmcm.style.position="absolute";
		document.forms[0].txt_agenda.value="";
		document.forms[0].txt_mcmof.value="";
	}
}
</script>

</head>
<body onload="onLoading()">
<form name="otstermscond" method="post" class="normal">
<lapstab:sarfiurltag pageid="9"/>
           <span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt; Signatories  
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		<br>		
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
  <tr> 
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
          <tr> 
            <td><b>Ref. No. CRLD</b></td>
            <td> 
              <input type="text" name="txt_refno" value="<%=Helper.correctNull((String)hshValues.get("refno"))%>" size="25" maxlength="25">
            </td>
            <td><b>Date of Compromise Proposal</b>
            </td>
            <td> 
              <input type="text" name="txt_propdate" value="<%=Helper.correctNull((String)hshValues.get("propdate"))%>" size="12" maxlength="10">
              <a alt="Select date from calender"  
              href="javascript:callCalender('txt_propdate')">
              <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
            </td>
            
          </tr>
          <tr> 
            <td width="31%">Sanctioning Authority</td>
            <td width="21%"> 
              <select name="selsancauth" onChange="changemcmdetails()">
                <option value="0" selected>&lt;---Select---&gt;</option>
                <option value="1">Branch Head</option>
                <option value="2">Regional Head</option>
                <option value="3">FGMO</option>
                <option value="4">CO GM</option>
                <option value="5">Executive Director</option>
                <option value="6">Managing Director</option>
                <option value="7">MCM</option>
                <option value="8">SAC</option>
              </select>
            </td>
            <td>&nbsp;</td>
            <td align="center">&nbsp;</td>
          </tr>
          <tr id="idmcm"> 
            <td>Agenda Item No:&nbsp;&nbsp;</td>
            <td valign="top"> 
              <input type="text" name="txt_agenda" size="15" maxlength="10"  
              value="<%=Helper.correctNull((String)hshValues.get("agendano"))%>" onKeyPress="notAllowSplChar()">
            </td>
            <td valign="top">MCM of &nbsp;</td>
            <td valign="top"> 
              <input type="text" name="txt_mcmof" size="12" maxlength="10"  
              value="<%=Helper.correctNull((String)hshValues.get("mcmof"))%>">
              <a alt="Select date from calender"  
              href="javascript:callCalender('txt_mcmof')">
              <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a> 
            </td>
          </tr>
          <tr>
         	<td colspan="4"> MCM Resolution</td>
          </tr>
          <tr>
          	<td colspan="4"> 
                <textarea name="txt_mcmresolution" cols="95" 
                  rows="7" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mcmresolution"))%></textarea>
                  </td>
              
          </tr>
          <tr>
          	<td valign="top" colspan="4"> Committee Resolution</td>
          	</tr>
          <tr>
          	<td colspan="4">
              <textarea name="txt_commobservations" size="40" cols="95" rows="5" 
              							onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("commobservations"))%></textarea>
            </td>
          </tr>
          <tr> 
                  <td colspan="4"> Signatures</td>
                  </tr>
          <tr>
          	<td colspan="4">
                    <textarea name="txt_signatures" cols="95" rows="10" 
                  					onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("signatures"))%></textarea>
                  </td>
                </tr>
        </table>
    </td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  
</form>
</body>
</html>
