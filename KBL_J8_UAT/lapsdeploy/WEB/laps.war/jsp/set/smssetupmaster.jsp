<%@ include file="../share/directives.jsp"%>
<%
String strPageFrom=Helper.correctNull((String)request.getParameter("hidPageFrom"));
//out.println(hshValues);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varType="<%=Helper.correctNull((String)hshValues.get("strType"))%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}	
}

function callonload()
{
	disablefields(true);
	if(document.forms[0].hidPageFrom.value=="L")
	{
		if(varType!="")
		{
			document.forms[0].seltype.value=varType;
		}
	}
}

function doSave()
{
	 	document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateSMSMaster";
		document.forms[0].hidBeanGetMethod.value="getSMSMaster";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/smssetupmaster.jsp";
		document.forms[0].submit();
}
function doEdit()
{
	disablefields(false);
	enableButtons(true,false,false,true);
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getSMSMaster";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/smssetupmaster.jsp";
		document.forms[0].submit();
	}
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function getValues()
{
	if(document.forms[0].seltype.value!="")
	{
		document.forms[0].hidBeanGetMethod.value="getSMSMaster";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/smssetupmaster.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>
<body onload="callonload()">
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Admin Level Controls -&gt;  SMS Configuration </td>
          </tr>
        </table>
         <table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable border1 tableBg" align="center">
         <tr>
         <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr>
          <td colspan="3" align="center" class="dataheader"> SMS Configuration Master</td>
          </tr>
          <%if(strPageFrom.equalsIgnoreCase("O")){ %>
          <tr>
          <td>LAR Submission Message for CLPH Proposals</td>
          <td><textarea name="txt_LARSubmission"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strProcessMsg"))%> 
			</textarea></td>
			<td rowspan="3" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr>
          <td><b>Keywords for Mapping:</b></td>
          </tr>
          <tr><td>@CName -> Customer Name</td></tr><tr><td>@LARNO -> LAR Number</td></tr><tr><td>@Appref -> Sanction Reference Number  </td></tr>
          <tr><td>@SAMT -> Sanction Amount</td></tr><tr><td>@REJRSON -> Rejection Reason</td></tr><tr><td>@Organddep -> Organisation name - Department Name</td></tr>
          <tr><td>@Branch -> Branch Name</td></tr><tr><td>@PRono -> Proposal No</td></tr>
          <tr><td>@securityid -> Security Id Number</td></tr>
          <tr><td>@revdate -> revaluation date</td></tr>
          </table>
			</td>
          </tr>
          <tr>
          <td>Approval Message for CLPH Proposals</td>
          <td><textarea name="txt_approval"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strApprovedMsg"))%> 
			</textarea></td>
          </tr>
          <tr>
          <td>Rejection Message for CLPH Proposals</td>
          <td><textarea name="txt_rejectionmsg"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strRejectMsg"))%> 
			</textarea></td>
          </tr>
		<td>CBS ID Creation</td>
          <td><textarea name="txt_CBSIdCreation"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strCBSIdMsg"))%> 
			</textarea></td>
          </tr>
         
		<tr>
          <td>CBS Account Creation</td>
          <td><textarea name="txt_AccountCreation"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strAccountMsg"))%> 
			</textarea></td>
          </tr>
          
          <tr>
          <td>Field Investigation Completed</td>
          <td><textarea name="txt_FieldInvestigation"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strMessage"))%> 
			</textarea></td>
          </tr>
          <tr>
           <td>KYC not Completed</td>
          <td><textarea name="txt_KycNotCompleted"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strKycNotComptdMsg"))%> 
			</textarea></td>
          </tr>
          <%}else if(strPageFrom.equalsIgnoreCase("L")){ %>
          <tr>
          <td colspan="3">Agent Type:&nbsp;&nbsp;&nbsp;
          <select name="seltype" onchange="getValues();">
          <option value="">&lt;--select--&gt;</option>
          <option value="BSA">Business Sourcing Agents</option>
		  <option value="DSA">Direct Sales Agents</option>
		  <lapschoice:StaticDataTag apptype="218" />
          </select>
          </td>
          </tr>
          <tr>
          <td>Sending SMS:&nbsp;&nbsp;&nbsp;
          <select name="sel_sendsms" onchange="getValues();">

          <option>15 days After Sanction</option>
          <option>30 days After Sanction</option>
          <option>45 days After Sanction</option>
          </select>
          <!--<select name="sel_sms">
          <option>&lt;--select--&gt;</option>
          <option>SMS1</option>
          <option>SMS2</option>
          <option>SMS3</option>
          </select>
          --></td>
          </tr>
          <tr>
          <td>LAR Submission Message</td>
          <td><textarea name="txt_LARCreation"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strLARProcess"))%> 
			</textarea></td>
			<td rowspan="3" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr>
          <td><b>Keywords for Mapping:</b></td>
          </tr>
          <tr><td>@CName -> Customer Name</td></tr><tr><td>@LARNO -> LAR Number</td></tr>
          <tr><td>@SAMT -> Sanction Amount</td></tr><tr><td>@REJRSON -> Rejection Reason</td></tr>
          <tr><td>@AgentName -> BSA/DSA/Other Agent Name</td></tr>
          </table>
			</td>
          </tr>
          <tr>
          <td>Approval Message</td>
          <td><textarea name="txt_LARApproval"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strLARApproval"))%> 
			</textarea></td>
          </tr>
          <tr>
          <td>Rejection Message</td>
          <td><textarea name="txt_LARRejection"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("strLARRejection"))%> 
			</textarea></td>
          </tr><!--
          <tr>
          <td>Provision Message</td>
          <td><textarea name="txt_ProvisionMessage"
                   cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)" >
                   Dear Sir/Madam,
                   Your request for Car Loan has been sanctioned; kindly contact your branch for immediate disbursement. 

                     Regards
                     Karnataka Bank Ltd
                   </textarea></td>
          </tr>
		--><tr>
          
          <%} %>
           <tr>
           <td>SMS for Car loan sanctioned and pending for disbursement</td>
          <td><textarea name="txt_smsforcar"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_CARLOAN"))%> 
			</textarea></td>
          </tr>
          <tr>
           <td>Branch head and ABM of raised queries</td>
          <td><textarea name="txt_smsforabm"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_ABMQUERY"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Permission Proposal Approval</td>
          <td><textarea name="txt_smsforppa"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_PERMIS_APPROVED"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Post Sanction Proposal Approval</td>
          <td><textarea name="txt_smsforpspa"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_POST_APPROVED"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Permission Proposal Rejection</td>
          <td><textarea name="txt_smsforppr"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_PERMIS_REJECT"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Post Sanction Proposal Rejection</td>
          <td><textarea name="txt_smsforpspr"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_POST_REJECT"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Permission Proposal SENDING</td>
          <td><textarea name="txt_smsforpps"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_PERMIS_SEND"))%> 
			</textarea></td>
          </tr>
             <tr>
           <td>SMS Template for Post Sanction SENDING</td>
          <td><textarea name="txt_smsforpsps"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_POST_SEND"))%> 
			</textarea></td>
          </tr>
          
          <tr>
           <td>SMS Template for security revaluation of 90 days prior to the due date</td>
          <td><textarea name="txt_security_90"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_SECURITY_90"))%>
			</textarea></td>
          </tr>
          
          <tr>
           <td>SMS Template for security revaluation of 60 days prior to the due date</td>
          <td><textarea name="txt_security_60"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_SECURITY_60"))%>
			</textarea></td>
          </tr>
          
          <tr>
           <td>SMS Template for security revaluation of 30 days prior to the due date</td>
          <td><textarea name="txt_security_30"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_SECURITY_30"))%>
			</textarea></td>
          </tr>
          
          <tr>
           <td>SMS Template for security revaluation of 07 days prior to the due date</td>
          <td><textarea name="txt_security_07"
					cols="100" rows="5" onKeyPress="textlimit(this,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String) hshValues.get("SMS_SECURITY_07"))%>
			</textarea></td>
          </tr>
          
		</table> 
		</td>
          </tr>
          </table> 
		<br/><br/>
		<lapschoice:combuttonnew btnnames='Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
	

<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidPageFrom" value="<%=strPageFrom %>">
</form>
</body>
</html>