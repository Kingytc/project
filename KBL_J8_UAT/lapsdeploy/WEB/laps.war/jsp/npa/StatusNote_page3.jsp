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
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
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
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appUrl+"action/StatusNote_page3.jsp";
		document.forms[0].submit();	
	}	
}

function doSave()
	{
		if(document.forms[0].txt_briefhistory.value=="")
		{
			alert("Enter the Brief History");
			document.forms[0].txt_briefhistory.focus();
			return;
		}	
		if(document.forms[0].txt_irregularreasons.value=="")
		{
			alert("Enter the reasons for Account Turning irregular");
			document.forms[0].txt_irregularreasons.focus();
			return;
		}
		if(document.forms[0].txt_staffaccountability.value=="")
		{
			alert("Enter the Staff Accountability");
			document.forms[0].txt_staffaccountability.focus();
			return;
		}
		if(document.forms[0].txt_recoverduesteps.value=="")
		{
			alert("Enter the Action Plans");
			document.forms[0].txt_recoverduesteps.focus();
			return;
		}
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page3.jsp";
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
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page3.jsp";
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
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}

</script>
</head>
<body onload="onLoading()">
<form name="statusnotepage3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="6"/>
					</td>
				</tr>
				  <tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Status Note -&gt;History 
 </td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
  <tr>
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td><u>BRIEF HISTORY <span class="mantatory">*</span></U></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td> 
                    <textarea name="txt_briefhistory" cols=90 rows=7 onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("briefhistory"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><u>REASONS FOR ACCOUNT TURNING IRREGULAR</u><span class="mantatory">*</span></td>
          </tr>
          <tr> 
            <td>(The Reason should be business related like diversion of funds,n 
              on-viability of venture, lack of demand, fradulent activities etc 
              and merely interest not serviced, installments not paid etc.)</td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td> 
                    <textarea name="txt_irregularreasons" cols=90 rows=7  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("irregularreasons"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><u>STAFF ACCOUNTABILITY :</u><span class="mantatory">*</span></td>
          </tr>
          <tr> 
            <td>(Specify date examined and sent to Reviewing Authority also. If 
              no accountability ia fixed, the basis on which the decision was 
              arrived at to be reported.)</td>
          </tr>
          <tr> 
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td> 
                    <textarea name="txt_staffaccountability" cols=90 rows=7 onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("staffaccountability"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><u>ACTION PLAN/PRESENT POSITION/REMARKS:</u><span class="mantatory">*</span></td>
          </tr>
          <tr> 
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                      <tr> 
                        <td width="57%"> 
                          <textarea name="txt_recoverduesteps" rows="7" cols="90" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("recoverduesteps"))%></textarea>
                        </td>
                        <td width="43%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                            <tr> 
                              <td colspan="2">Please ensure that the progress 
                                with respect to following points viz.</td>
                            </tr>
                            <tr> 
                              <td width="14%" align="center">(a)</td>
                              <td width="86%">Suit at DRT against the Co.</td>
                            </tr>
                            <tr> 
                              <td width="14%" align="center">(b)</td>
                              <td width="86%">BIFR hearing</td>
                            </tr>
                            <tr> 
                              <td width="14%" align="center">(c)</td>
                              <td width="86%">Action under 'SARFAESI' Act</td>
                            </tr>
                            <tr> 
                              <td width="14%" align="center">(d)</td>
                              <td width="86%">Whether recovery/enforcement agents 
                                etc are appointed</td>
                            </tr>
                            <tr>
                              <td width="14%" align="center">(e)</td>
                              <td width="86%">Consortium meeting details</td>
                            </tr>
                            <tr> 
                              <td width="14%" align="center">(f)</td>
                              <td width="86%">Recovery prospects and action planned 
                                etc. are included </td>
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

