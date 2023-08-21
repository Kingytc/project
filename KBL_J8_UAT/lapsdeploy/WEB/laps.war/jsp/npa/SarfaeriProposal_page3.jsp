<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var select1="<%=Helper.correctNull((String)hshValues.get("sec_disposed"))%>";
var select2="<%=Helper.correctNull((String)hshValues.get("sec_possible"))%>";
var select3="<%=Helper.correctNull((String)hshValues.get("ots_account"))%>";
var select4="<%=Helper.correctNull((String)hshValues.get("ots_overdue"))%>";
var select5="<%=Helper.correctNull((String)hshValues.get("defaulter"))%>";
var select6="<%=Helper.correctNull((String)hshValues.get("account"))%>";
var bank="<%=Helper.correctNull((String)hshValues.get("borr_disputed"))%>";

function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;	
	document.forms[0].cmdclose.disabled=cmdclose;
}

function onLoading()
{
	if(select1!="")
	{
	    document.forms[0].select1.value=select1;	
		
	}
	else
	{
	    document.forms[0].select1.value="n";	
	}
	if(select2!="")
	{
	    document.forms[0].select2.value=select2;	
		
	}
	else
	{
	    document.forms[0].select2.value='n'	
	}
	if(select3!="")
	{
	    document.forms[0].select3.value=select3;	
		
	}
	else
	{
	    document.forms[0].select3.value='n'	
	}
	if(select4!="")
	{
	    document.forms[0].select4.value=select4;	
		
	}
	else
	{
	    document.forms[0].select4.value='n'	
	}
	if(select5!="")
	{
	    document.forms[0].select5.value=select5;	
		
	}
	else
	{
	    document.forms[0].select5.value='n'	
	}
	if(select6!="")
	{
	    document.forms[0].select6.value=select6;	
		
	}
	else
	{
	    document.forms[0].select6.value='n'	
	}
	if(bank!="")
	{
	    document.forms[0].bank1.value=bank;	
		
	}
	else
	{
	    document.forms[0].bank1.value='n'	
	}
	showDisposed();
	showPossession();
	showOTSAccount();
	showOTSRecovery();
	showBorrower();
	showDecisions();
	showBank();
	disableFields(true);	
}
function doDelete()
{
if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatesarfaeripage3Data";
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage3Data";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidSourceUrl.value="action/SarfaeriProposal_page3.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    disableCommandButtons(true,false,false,false,false);
	document.forms[0].select1.focus();	
}
	
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="getsarfaeripage3Data";
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage3Data";
		document.forms[0].action=appURL +"/action/SarfaeriProposal_page3.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons(false,true,true,true,false);
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatesarfaeripage3Data";
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage3Data";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SarfaeriProposal_page3.jsp";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}
function callLink(page,bean,method)
{
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidmoduletype.value="SARFI";
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
		}
		else
		{
		ShowAlert(103);
		}
}
function showDisposed()
{
	if(document.forms[0].select1.value=="y")
	{
		document.all.a1.style.visibility="visible";
		document.all.a1.style.position="relative";
	}
	else
	{
		document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		document.forms[0].txt_security.value="";
	}
}
function showPossession()
{
	if(document.forms[0].select2.value=="y")
	{
		document.all.a2.style.visibility="visible";
		document.all.a2.style.position="relative";
	}
	else
	{
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		document.forms[0].txt_peacefulposiion.value="";
	}
}
function showBank()
{
	if(document.forms[0].bank1.value=="y")
	{
		document.all.b1.style.visibility="visible";
		document.all.b1.style.position="relative";
	}
	else
	{
		document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
		document.forms[0].txt_borrower.value="";
	}
}
function showOTSAccount()
{
	if(document.forms[0].select3.value=="y")
	{
		document.all.a3.style.visibility="visible";
		document.all.a3.style.position="relative";
	}
	else
	{
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		document.forms[0].txt_securitydisposed1.value="";		
	}
}
function showOTSRecovery()
{
	if(document.forms[0].select4.value=="y")
	{
		document.all.a4.style.visibility="visible";
		document.all.a4.style.position="relative";
	}
	else
	{
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		document.forms[0].txt_OTSoverdue.value="";
	}
}
function showBorrower()
{
	if(document.forms[0].select5.value=="y")
	{
		document.all.a5.style.visibility="visible";
		document.all.a5.style.position="relative";
	}
	else
	{
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		document.forms[0].txt_Borrweridentified.value="";
	}
}
function showDecisions()
{
	if(document.forms[0].select6.value=="y")
	{
		document.all.a6.style.visibility="visible";
		document.all.a6.style.position="relative";
	}
	else
	{
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		document.forms[0].txt_bankerdecision.value="";
	}
}
</script>
</head> 
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<lapstab:sarfiurltag pageid="5"/>
           <span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Disposal of Securities</span>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable linebor datagrid">
                <tr> 
                  <td width="42%">F) ASPECTS ON DISPOSAL OF SECURITIES</td>
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="42%">WHETHER SECURITIES CAN BE EASILY DISPOSED</td>
                  <td width="7%"> 
                    <select name="select1" onChange="showDisposed()" tabindex="1">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="51%" id="a1"> 
                    <textarea rows="4" name="txt_security" cols="50" tabindex="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sec_disposedetails"))%></textarea>
                  </td>
                </tr>
				
                <tr>
                  <td width="42%">HAS THE BORROWER DISPUTED BANK'S DUES .IF SO 
                    DETAILS </td>
                  <td><select name="bank1" onChange="showBank()" tabindex="3">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select></td>
                  <td id="b1"><textarea rows="4" name="txt_borrower" tabindex="4" cols="50" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("borr_disputedetails"))%></textarea></td>
                </tr>
                <tr> 
                  <td width="42%">WHETHER PEACEFUL POSSESSION OF SECURITIES POSSIBLE</td>
                  <td> 
                    <select name="select2" onChange="showPossession()" tabindex="5">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td id="a2"> 
                    <textarea rows="4" name="txt_peacefulposiion" tabindex="6" cols="50" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sec_possibledetails"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="42%">APPROXIMATE TIME FRAME FOR DISPOSAL FOR SECURITIES</td>
                  <td colspan="2"> 
                    <input type="text" maxlength="15" name="txt_approximate" tabindex="7" value="<%=Helper.correctNull((String)hshValues.get("approxtime"))%>">
                  </td>
                </tr>
                <tr> 
                  <td width="42%">WHETHER OTS ITS APPROVED IN THIS ACCOUNT AND 
                    IF SO DETAILS THEREOF</td>
                  <td width="7%"> 
                    <select name="select3" onChange="showOTSAccount()" tabindex="8">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="51%" id="a3"> 
                    <textarea rows="4" name="txt_securitydisposed1" cols="50" tabindex="9" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("ots_accountdetails"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="42%">IF OTS APPROVED IS OVERDUE IN PAYMENTS , CHANCES 
                    OF RECOVERY OF AMOUNT AS PER OTS</td>
                  <td width="7%"> 
                    <select name="select4" onChange="showOTSRecovery()" tabindex="10">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="51%" id="a4"> 
                    <textarea rows="4" name="txt_OTSoverdue" cols="50" tabindex="11" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("ots_overduedetails"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="42%">WHETHER BORROWER IS IDENTIFIED AS WILFUL DEFAULTER 
                    IF SO DETAILS</td>
                  <td width="7%"> 
                    <select name="select5" onChange="showBorrower()" tabindex="12">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="51%" id="a5"> 
                    <textarea rows="4" name="txt_Borrweridentified" cols="50" tabindex="13" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("defaulter_details"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="42%">IF THE ACCOUNT IS UNDER CONSORITUM / MULTIPLE 
                    BANKING ARRANGEMENT , WHETHER BANKER'S MEETING CALLED FOR 
                    AND IF SO DETAILS THEREOF INCLUDING DECISIONS TAKEN</td>
                  <td width="7%"> 
                    <select name="select6" onChange="showDecisions()" tabindex="14">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="51%" id="a6"> 
                    <textarea rows="4" name="txt_bankerdecision" cols="50" tabindex="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("account_details"))%></textarea>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
