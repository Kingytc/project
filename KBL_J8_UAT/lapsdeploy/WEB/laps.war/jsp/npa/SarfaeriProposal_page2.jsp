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
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var document_complete="<%=Helper.correctNull((String)hshValues.get("document_complete"))%>";
var complaint_rec="<%=Helper.correctNull((String)hshValues.get("COMPLAINT_REC"))%>";
var suit_filed="<%=Helper.correctNull((String)hshValues.get("SUIT_FILED"))%>";
var bifr_acct="<%=Helper.correctNull((String)hshValues.get("BIFR_ACCT"))%>";

function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;	
}
function doDelete()
{
  if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatesarfaeripage2Data";
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage2Data";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidSourceUrl.value="action/SarfaeriProposal_page2.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function onLoading()
{	
	if(complaint_rec=="y")
	{
		  document.forms[0].complaint_rec.value='y'	
		  document.all.row2.style.visibility="visible";
		  document.all.row2.style.position="relative";
		  document.all.row3.style.visibility="visible";
		  document.all.row3.style.position="relative";		
	}
	else if(complaint_rec=="n")
	{		
		document.forms[0].complaint_rec.value='n'	
		document.all.row2.style.visibility="hidden";
		document.all.row2.style.position="absolute";
		document.all.row3.style.visibility="hidden";
		document.all.row3.style.position="absolute";
	}
	else
	{
		document.forms[0].complaint_rec.value='s'
	}
	if(suit_filed=="y")
	{
		  document.forms[0].suit_filed.value='y'	
		  document.all.row2.style.visibility="visible";
		  document.all.row2.style.position="relative";
		  document.all.row3.style.visibility="visible";
		  document.all.row3.style.position="relative";		
	}
	else if(suit_filed=="n")
	{		
		document.forms[0].suit_filed.value='n'	
		document.all.row2.style.visibility="hidden";
		document.all.row2.style.position="absolute";
		document.all.row3.style.visibility="hidden";
		document.all.row3.style.position="absolute";
	}
	else
	{
		document.forms[0].suit_filed.value='s'
	}
	if(bifr_acct=="y")
	{
		  document.forms[0].bifr_acct.value='y'	
		  document.all.row2.style.visibility="visible";
		  document.all.row2.style.position="relative";
		  document.all.row3.style.visibility="visible";
		  document.all.row3.style.position="relative";		
	}
	else if(bifr_acct=="n")
	{		
		document.forms[0].bifr_acct.value='n'	
		document.all.row2.style.visibility="hidden";
		document.all.row2.style.position="absolute";
		document.all.row3.style.visibility="hidden";
		document.all.row3.style.position="absolute";
	}
	else
	{
		document.forms[0].bifr_acct.value='s'
	}
	showrow();
	showdate();
	showbifr();
	disableFields(true);
}
function showdate()
{
	if(document.forms[0].suit_filed.value=='y')
	{
		document.all.col1.style.visibility="visible";
		document.all.col1.style.position="relative";
		document.all.col2.style.visibility="visible";
		document.all.col2.style.position="relative";		
	}
	else 
	{		
		document.all.col1.style.visibility="hidden";
		document.all.col1.style.position="absolute";
		document.all.col2.style.visibility="hidden";
		document.all.col2.style.position="absolute";
		document.forms[0].txt_suitdate.value="";		
	}
}

function showbifr()
{
	if(document.forms[0].bifr_acct.value=='y')
	{
		document.all.b1.style.visibility="visible";
		document.all.b1.style.position="relative";
		document.all.b2.style.visibility="visible";
		document.all.b2.style.position="relative";		
	}
	else 
	{		
		document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
		document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
		document.forms[0].txt_lasthearing.value="";		
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false);	
	document.forms[0].complaint_rec.focus();
}
function doCancel()
{  
if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="SarfaeriProposal_page2.jsp";
		document.forms[0].hidBeanId.value="npa";
		
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage2Data";
		document.forms[0].action=appURL +"action/SarfaeriProposal_page2.jsp";
	    document.forms[0].submit();	
	}	
disableCommandButtons(false,true,true,true);
}
function doSave()
	{
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatesarfaeripage2Data";
		document.forms[0].hidBeanGetMethod.value="getsarfaeripage2Data";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/SarfaeriProposal_page2.jsp";
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
function showrow()
{	
	if(document.forms[0].complaint_rec.value=='y')
	{
		document.all.row2.style.visibility="visible";
		document.all.row2.style.position="relative";
		document.all.row3.style.visibility="visible";
		document.all.row3.style.position="relative";		
	}
	else 
	{		
		document.all.row2.style.visibility="hidden";
		document.all.row2.style.position="absolute";
		document.all.row3.style.visibility="hidden";
		document.all.row3.style.position="absolute";
		document.forms[0].complaint_received.value="";
		document.forms[0].complaint_disposal.value="";
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
						<lapstab:sarfiurltag pageid="4"/>					
           <span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Compliance </span>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable border1">        
        <tr> 
          <td>
              <table border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
                <tr> 
                  <td width="44%">WHETHER ANY COMPLAINT WAS RECIEVED BY THE BRANCH REGARDING THIS ADVANCE.</td>
                  <td colspan="2"> 
                    <select name="complaint_rec" onchange="showrow()" tabindex="1">
                      <option value="s">--Select--</option>
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                </tr>
                <tr id="row2"> 
                  <td width="44%">IF SO, DETAILS OF THE COMPLAINT</td>
                  <td colspan="3"> 
                    <textarea rows="4" name="complaint_received" cols="50" tabindex="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMPLAINT_RECEIVED"))%></textarea>
                  </td>
                </tr>
                <tr id="row3"> 
                  <td width="44%">DETAILS OF DISPOSAL OF THE COMPLAINT</td>
                  <td colspan="3"> 
                    <textarea rows="4" name="complaint_disposal" cols="50" tabindex="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COMPLAINT_DISPOSAL"))%></textarea>
                  </td>
                </tr>
                <tr > 
                  <td width="44%">WHETHER SUIT FILED</td>
                  <td width="7%"> 
                    <select name="suit_filed" onchange="showdate()" tabindex="4">
                      <option value="s">--Select--</option>
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="25%" id="col1">DATE OF SUIT FILED</td>
                  <td width="24%" id="col2">&nbsp; 
                    <input type="text" name="txt_suitdate" size="15"
				maxlength="10" tabindex="5" 
				value="<%=Helper.correctNull((String)hshValues.get("SUIT_DATE"))%>" onBlur="checkDate(this)">
                    <a href="#" onClick="callCalender('txt_suitdate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="5"></a></td>
                </tr>
                <tr> 
                  <td width="44%">WHETHER BIFR ACCOUNT REFERRED</td>
                  <td width="7%"> 
                    <select name="bifr_acct" onchange="showbifr()" tabindex="6">
                      <option value="s">--Select--</option>
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select></td>
                  <td width="25%" id="b1">LAST HEARING HELD ON</td>
                  <td width="24%" id="b2">&nbsp; 
                    <input type="text" name="txt_lasthearing" size="15"
				maxlength="10" tabindex="7" 
				value="<%=Helper.correctNull((String)hshValues.get("HEARING_DATE"))%>" onBlur="checkDate(this)">
                    <a href="#" onClick="callCalender('txt_lasthearing')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="7"></a></td>
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
