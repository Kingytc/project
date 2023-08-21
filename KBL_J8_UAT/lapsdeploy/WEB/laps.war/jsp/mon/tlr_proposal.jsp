<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sancAuth = "<%=Helper.correctNull((String)hshValues.get("tlr_sancauthority"))%>";

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
function callCalender(fname)
 {
	if(document.forms[0].cmdsave.disabled==false)
	 {  
	  showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 } 
 }


function onLoading()
{

	//disableCommandButtons("load");
	if("<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>" == "2")
	{
		if(sancAuth != "")
		{
		 document.forms[0].sel_sancauthority.value=sancAuth;
		}
		else
		{
		document.forms[0].sel_sancauthority.value="0";
		}
		changeMCMDetails();
	}	
	disableFields(true);
}

function doDelete()
{
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateProposalData";
			document.forms[0].hidBeanGetMethod.value="getProposalData";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/tlr_proposal.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Review of");
		return;
	}	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}
function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="tlr_proposal.jsp";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getProposalData";
		document.forms[0].action=appURL +"action/tlr_proposal.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{

        if(checktrim(document.forms[0].txt_proposaldate.value)=="")
		{
				alert("Enter Date of Proposal");
				document.forms[0].txt_proposaldate.focus();
				return false;
		}
		if(checktrim(document.forms[0].txt_refno.value)=="")
		{
				alert("Enter Reference No");
				document.forms[0].txt_refno.focus();
				return false;
		}
		if("<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>" == "2")
		{
			if(document.forms[0].sel_sancauthority.value=="0")
			{
				alert("Select Sanctioning Authority");
				document.forms[0].sel_sancauthority.focus();
				return false;
			}
		}	
		<%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")) { %>
	     document.forms[0].hidSancAuth.value = document.forms[0].sel_sancauthority[document.forms[0].sel_sancauthority.selectedIndex].text;
        <%}%>
        document.forms[0].hidBeanId.value="reviewtermloantwo";
	    document.forms[0].hidBeanMethod.value="updateProposalData";
		document.forms[0].hidBeanGetMethod.value="getProposalData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_proposal.jsp";
		document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}

	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}

function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}
function changeMCMDetails()
{
	if(document.forms[0].sel_sancauthority.value=='7')
	{
		document.all.mcm1.style.visibility="visible";
		document.all.mcm1.style.position="relative";
		document.all.mcm2.style.visibility="visible";
		document.all.mcm2.style.position="relative";
		document.all.mcm3.style.visibility="visible";
		document.all.mcm3.style.position="relative";
	}
	else
	{
		document.all.mcm1.style.visibility="hidden";
		document.all.mcm1.style.position="absolute";
		document.all.mcm2.style.visibility="hidden";
		document.all.mcm2.style.position="absolute";
		document.all.mcm3.style.visibility="hidden";
		document.all.mcm3.style.position="absolute";
		
		document.forms[0].txt_agendano.value="";
		document.forms[0].txt_mcmdate.value="";
		document.forms[0].txt_mcmresolution.value="";

	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="12" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Proposal</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<table width="73%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable border1" >
    <tr> 
      <td>
  <table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable" >
    <tr> 
      <td width="40%">Date of Proposal <b><span class="mantatory">&nbsp;*</span></b></td>
      <td> 
        <table class="outertable">
          <tr> 
            <td> 
              <input type="text" name="txt_proposaldate" size="12"
							maxlength="10"
							onBlur="checkDate(this)" value="<%=Helper.correctNull((String) hshValues
								.get("tlr_proposaldate"))%>">
            </td>
            <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_proposaldate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> </td>
          </tr>
        </table>
      </td>
    </tr>
     <tr> 
      <td>Reference No<b><span class="mantatory">&nbsp;*</span></b></td>
      <td> 
        <input type="text" name="txt_refno" size="30" maxlength="25"  
              value="<%=Helper.correctNull((String)hshValues.get("tlr_refno"))%>" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")) { %>
    <tr> 
      <td>Sanctioning Authority<b><span class="mantatory">&nbsp;*</span></b></td>
      <td> 
        <select name="sel_sancauthority" onChange="changeMCMDetails()">
                <option value="0" selected="selected">&lt;---Select---&gt;</option>
                <option value="1">Branch Head</option>
                <option value="2">Regional Head</option>
                <option value="8">SARAL Head</option>
                <option value="3">FGMO</option>
                <option value="4">CO GM</option>
                <option value="5">Executive Director</option>
                <option value="6">Managing Director</option>
                <option value="7">MCM</option>
        </select>
      </td>
    </tr>
    <tr id="mcm1"> 
      <td>Agenda Item no</td>
      <td> 
        <input type="text" name="txt_agendano" size="30" maxlength="50" value="<%=Helper.correctNull((String) hshValues
								.get("tlr_agendano"))%>">
      </td>
    </tr>
    
    
    <tr id="mcm2"> 
      <td>MCM of</td>
      <td> 
        <table class="outertable">
          <tr> 
            <td> 
              <input type="text" name="txt_mcmdate" size="12"
							maxlength="10"
							onBlur="checkDate(this)" value="<%=Helper.correctNull((String) hshValues
								.get("tlr_mcmdate"))%>">
            </td>
            <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_mcmdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> </td>
          </tr>
        </table>
      </td>
    </tr>
   
    <tr id="mcm3"> 
      <td>MCM resolution</td>
      <td> 
        <textarea name="txt_mcmresolution" cols="75" rows="4" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_mcmresolution"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td>Grid Meeting</td>
      <td> 
        <input type="text" name="txt_grid" size="30" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("tlr_gridmeeting")) %>">
      </td>
    </tr>
    <tr> 
      <td>Meeting Date</td>
      <td> 
        <table>
          <tr> 
            <td> 
              <input type="text" name="txt_meetingdate" size="12"
							maxlength="10"
							onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("tlr_meetingdate")) %>">
            </td>
            <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_meetingdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;">&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> </td>
          </tr>
        </table>
      </td>
    </tr>
    <%} %>
     <tr> 
      <td>Signatories</td>
      <td> 
        <textarea name="txt_signatories" cols="80" rows="7" 
				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_signatories"))%></textarea>
      </td>
    </tr>
    </table>
    </td>
    </tr></table>
     <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br><lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="hidSancAuth">
</form>
</body>
</html>

