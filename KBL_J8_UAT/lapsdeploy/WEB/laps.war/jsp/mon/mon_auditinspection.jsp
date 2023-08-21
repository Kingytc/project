<%@include file="../share/directives.jsp"%>
<html>
<%
ArrayList arrRow=null;
ArrayList arrCol=new ArrayList(); %>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varAudittype="<%=Helper.correctNull((String)hshValues.get("audittype"))%>";
var varorglevel="<%=strOrgLevel%>";

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
	
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidBeanGetMethod.value="getAuditorsInspection";
	document.forms[0].hidSourceUrl.value="/action/mon_auditinspection.jsp"
	document.forms[0].submit();
}

function onLoading()
{
	disableFields(true);
	if(varAudittype!="")
	{
		document.forms[0].sel_audittype.value=varAudittype;
	}

	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	else
	{
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
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
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_auditinspection.jsp";
		document.forms[0].hidBeanId.value="Register";
		//document.forms[0].hidBeanMethod.value="updateAuditorsInspection";
		document.forms[0].hidBeanGetMethod.value="getAuditorsInspection";
		document.forms[0].action=appUrl+"action/mon_auditinspection.jsp";
		document.forms[0].submit();
	}	
	
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidSourceUrl.value="/action/mon_auditinspection.jsp";
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidBeanMethod.value="updateAuditorsInspection";
	document.forms[0].hidBeanGetMethod.value="getAuditorsInspection";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/mon_auditinspection.jsp";
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidBeanMethod.value="updateAuditorsInspection";
	document.forms[0].hidBeanGetMethod.value="getAuditorsInspection";
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
	document.forms[0].txt_auditdate.readOnly=true;
}
function doClose()
	{
	  if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/mainnav.jsp";
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



/*function PrintReport()
{		
		var npa_appno=document.forms[0].npa_appno.value;
		var hidmoduletype="STAT";
		var selPrint="Get";
		var CompanyName="<%//=request.getParameter("appname")%>";						
		var purl ="<%//=ApplicationParams.getAppUrl()%>action/NPA_statuspage_print.jsp?hidBeanGetMethod=getNPAStatuspagePrint&hidBeanId=npa&npa_appno="+npa_appno+"&borrowername="+CompanyName+"&hidmoduletype="+hidmoduletype+"&cbsid="+document.forms[0].cbsid.value+"&sel_audittype="+document.forms[0].sel_audittype.value+"&selPrint="+selPrint;;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}	*/	
		

</script>
</head>
<body  onload="onLoading();">
<form name="prudential_auditirregularities" method="post" class="normal">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="9"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt;Monitoring-&gt; Monthly Monitoring Reports-&gt; Auditor Inspection</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonthlyMonitor />
					</td>
				</tr>
			</table>
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
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="LEFT" class="outertable">
                      <tr>                      
                        <td width="9%">Type</td>
                        <td width="17%"> 
                          <select name="sel_audittype" tabindex="1" onChange="calGetData()">
                            <option value="0" selected>----Select----</option>
                            <option value="1">Stock Audit</option>
                            <option value="2">Concurrent Audit</option>
                            <option value="3">Internal Audit</option>
							<option value="4">RBI Inspection</option>
							<option value="5">Statutory Audit</option>
                          </select>
                        </td>
                        <td width="17%">DATE OF AUDIT</td>
                        <td width="57%"> 
                          <table width="20%">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_auditdate" size="12" maxlength="10"  
			                          value="<%=Helper.correctNull((String)hshValues.get("auditdate"))%>"
	    		                      onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                              </td>
                              <td> <a href="#" onClick="callCalender('txt_auditdate')"
										title="Click to view calender" border=0> 
                                <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
										width="0" border="0" tabindex="3"> </a> </td>
                            </tr>
                          </table>
                        </td>
                      <tr> 
                        <td colspan="6"><b>Auditors 
                          Observation </b></td>
                      </tr>
                      <tr> 
                        <td colspan="6"> 
                          <textarea name="txt_auditor"  cols="100" rows="10" tabindex="4" wrap="VIRTUAL" onKeyPress="textlimit(document.forms[0].txt_auditor,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("auditorscomments"))%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="6"><b>Branch 
                          Comments</b></td>
                      </tr>
                      <tr> 
                        <td colspan="6"> 
                          <textarea name="txt_officer" cols="100" rows="10" wrap="VIRTUAL" tabindex="5" onKeyPress="textlimit(document.forms[0].txt_officer,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("officercomments"))%></textarea>
                        </td>
                      </tr>
                    </table>
                   
                  </td>
                </tr>
              </table>
            </td>
        </tr>
      
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<br/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 	
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
