<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix ="lapstab" uri="/WEB-INF/lapstab.tld" %>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varAudittype="<%=Helper.correctNull((String)hshValues.get("audittype"))%>";


function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

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
function calGetData()
{
	
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
	document.forms[0].hidSourceUrl.value="/action/prudential_auditirregularities.jsp"
	document.forms[0].submit();
}

function onLoading()
{
	//disableCommandButtons("load");
	if(varAudittype!="")
	{
		document.forms[0].sel_audittype.value=varAudittype;
	}
	disableFields(true);
}
function doEdit()
{ 	
	if(document.forms[0].sel_audittype.value=="0")
	{
		ShowAlert(111,'Audit Type');
		document.forms[0].sel_audittype.focus();
		return;
	}
	else
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		disableCommandButtons("edit");
		document.forms[0].txt_auditdate.focus();	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/prudential_auditirregularities.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_auditirregularities.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateAuditorsObservation";
		document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function doSave()
{
	if(trim(document.forms[0].txt_auditor.value)=="")
	{
		ShowAlert('121','Auditors Comments');
		document.forms[0].txt_auditor.focus();
		return;
	}
	if(trim(document.forms[0].txt_officer.value)=="")
	{
		ShowAlert('121','Officers Comments');
		document.forms[0].txt_officer.focus();
		return;
	}
	if(trim(document.forms[0].txt_auditdate.value)=="")
	{
		ShowAlert('121','Date of Audit');
		document.forms[0].txt_auditdate.focus();
		return;
	}
	
	document.forms[0].hidSourceUrl.value="/action/prudential_auditirregularities.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateAuditorsObservation";
	document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
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
	if (document.forms[0].cmdsave.disabled)
			{
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



</script>
</head>
<body onload="onLoading();">

<form name="prudential_auditirregularities" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:pwourltag pageid="7"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
           <td class="page_flow">Home -&gt; NPA-&gt; Prudential Write Off -&gt;Audit Details</td>
          </tr>
        </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><laps:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr> 
            <td><b>AUDIT IRREGULARITIES</b></td>
        </tr>
        <tr> 
          <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="LEFT" class="outertable">
                      <tr> 
                        <td width="20%">Type</td> 
                        <td width="25%">
                          <select name="sel_audittype" tabindex="1" onChange="calGetData()">
                            <option value="0" selected>----Select----</option>
                            <option value="1">Internal Audit</option>
                            <option value="2">Concurrent Audit</option>
                            <option value="3">RBI Inspection</option>
                            <option value="4">Statutory Audit</option>
                            <option value="5">Stock Audit</option>
                          </select></td>
                        <td width="20%">DATE OF AUDIT</td>
                        <td width="35%">
	                        <table width="20%" class="outertable">
	                        	<tr>
	                        		<td>
	                        			<input type="text" name="txt_auditdate" size="12" maxlength="10" tabindex="2"
			                          value="<%=Helper.correctNull((String)hshValues.get("auditdate"))%>" 
	    		                      onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
	    		                    </td>
									<td>
										<a href="#" onClick="callCalender('txt_auditdate')"
										title="Click to view calender" border=0> 
										<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2"
										width="0" border="0"> </a>
									</td>
								</tr>
							</table>
                        </td>
                        
                      <tr> 
                        <td colspan="4"><b>Auditors 
                          Comments</b></td>
                      </tr>
                      <tr> 
                        <td colspan="4"> 
                          <textarea name="txt_auditor"  cols="100" rows="10" wrap="VIRTUAL" tabindex="3" onBlur="textlimit(document.forms[0].txt_auditor,3999)" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("auditorscomments"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="4"><b>Officers 
                          Comments</b></td>
                      </tr>
                      <tr> 
                        <td colspan="4"> 
                          <textarea name="txt_officer" cols="100" rows="10" tabindex="4" wrap="VIRTUAL" onKeyPress="textlimit(document.forms[0].txt_officer,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("officercomments"))%></textarea>
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

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'	 />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>"/>
</form>
</body>
</html>
