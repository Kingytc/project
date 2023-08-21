<%@include file="../share/directives.jsp"%>
<%    String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	  String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
	  String strright= Helper.correctNull(request.getParameter("readFlag"));
	  String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));
%>
<HTML>
<HEAD>
<TITLE>POSTDISBBURSAL</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varStatus = "<%=Helper.correctNull((String)hshValues.get("status"))%>";
var varright = "<%=strright%>";
var varproposal='<%=strProposal%>';
var varproposal='<%=strProposal%>';
function callUsersHelp()
{
	{
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?usr_class=10&org_code="+"<%=strOrgCode%>";
		window.open(url,"hai",prop);
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doAssign()
{
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(112,'Recipient');	
		return;
	}
	else
	{
		document.forms[0].hidAction.value="assign";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="updatedata";
		document.forms[0].action=appURL+"action/inwardworflowaction.jsp";
		document.forms[0].submit();
	}
}
function doAction(valaction,inwardno,sector,appliedfor)
{
	document.forms[0].hidAction.value=valaction;
	if(valaction=="send" && "<%=strIsSaral%>"!="Y")
	{ 
		if(document.forms[0].hidconfirm.value=="")  
		{
			document.all.ifrm.src="<%=ApplicationParams.getAppUrl()%>action/iframeinwardsend.jsp?hidBeanGetMethod=checkBranchworks&hidBeanId=inwardRegister&inwardno="+inwardno+"&sector="+sector+"&appliedfor="+appliedfor+"&proposal="+varproposal;
		}
		else if(document.forms[0].hidconfirm.value=="Y")
		{ 
			doSend(inwardno,valaction);
		}
	}
	else if(valaction=="send" && "<%=strIsSaral%>"=="Y")
	{ 
		if(document.forms[0].hidconfirm.value=="")
		{
			if(document.forms[0].hidmail_tousrid.value=="")
			{
				alert('Select Recipient');
				return;
			}
			else
			{
		   		document.forms[0].remarksFlag.value=true;
				doSend(inwardno,valaction);	
			}
		}
		else if(document.forms[0].hidconfirm.value=="Y")
		{
			doSend(inwardno,valaction);
		}
	}
	else if(valaction=="reject")
	{
		if(document.forms[0].hidconfirm.value=="")
		{
			if(confirm("Resend will cancel all the attachments. Do you want to proceed ? "))
			{
		   		document.forms[0].remarksFlag.value=true;
				doSend(inwardno,valaction);	
			}
		}
		else if(document.forms[0].hidconfirm.value=="Y")
		{
			doSend(inwardno,valaction);
		}
	}
	else
	{		
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/inwardworflowaction.jsp?inwradno="+inwardno+"&hidBeanId=inwardRegister&hidBeanGetMethod=ActionInward&sector="+sector+"&appliedfor="+appliedfor;
			document.forms[0].submit();
	}
}
function doSend(varinwardno,valaction)
{
	if(document.forms[0].remarksFlag.value=="true" && document.forms[0].hidconfirm.value=="")
	{			
			var varsector = document.forms[0].hidsector.value;
			var varappname = document.forms[0].appname.value;
			var vartouser = document.forms[0].hidmail_tousrid.value;
			var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	        var url=appURL+"action/saralworkflow_comments.jsp?inwardno="+varinwardno+"&hidsector="+varsector+"&appname="+varappname+"&editoption="+document.forms[0].hideditoption.value+"&hidBeanId=inwardRegister&hidBeanGetMethod=getInwardremarks&hidmail_tousrid="+vartouser;
        	window.open(url,"remarks",prop);
	}
	if(document.forms[0].hidconfirm.value=="Y")
	{
		var varsector = document.forms[0].hidsector.value;
	    document.forms[0].hidAction.value=valaction;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/inwardworflowaction.jsp?inwradno="+varinwardno+"&sector="+varsector+"&hidBeanId=inwardRegister&hidBeanGetMethod=ActionInward";
		document.forms[0].submit();
	}
}
function onLoading()
{
	//Added By Zahoorunnisa.S in order to hide buttons for zonal and central office is not saral user 
	//...below conditions will overrides this condition if otherwise
	if(document.forms[0].hidappassign.value!="<%=strUserId%>"){
	
		document.all.idRecipient1.style.visibility="hidden";
	 	document.all.idRecipient1.style.position="absolute";
	 	document.all.idRecipient2.style.visibility="hidden";
	 	document.all.idRecipient2.style.position="absolute";
	 	document.all.idAssign.style.position="absolute";
	 	document.all.idAssign.style.visibility="hidden";
		document.all.idAccept.style.visibility="hidden";
		document.all.idAccept.style.position="absolute";
		document.all.idResend.style.visibility="hidden";
		document.all.idResend.style.position="absolute";
		document.all.idSend.style.visibility="hidden";
	 	document.all.idSend.style.position="absolute";
	}

	if("<%=strOrgLevel%>"=="A")
	{	
		if(document.forms[0].hidstatus.value=='O')
		{
			document.all.idSend.style.visibility="visible";
		 	document.all.idSend.style.position="relative";
		 	
		 	if(document.forms[0].isorghead.value=='Y')
		 	{
		 		document.forms[0].cmdAction.disabled=false;
		 	}
		 	else
		 	{
		 		document.forms[0].cmdAction.disabled=true;
		 	}		 	
			document.all.idRecipient1.style.visibility="hidden";
		 	document.all.idRecipient1.style.position="absolute";
		 	document.all.idRecipient2.style.visibility="hidden";
		 	document.all.idRecipient2.style.position="absolute";
		 	document.all.idAssign.style.position="absolute";
		 	document.all.idAssign.style.visibility="hidden";
			document.all.idAccept.style.visibility="hidden";
			document.all.idAccept.style.position="absolute";
			document.all.idResend.style.visibility="hidden";
			document.all.idResend.style.position="absolute";
		}
	}
	if("<%=strIsSaral%>"=="Y")
	{
		if(document.forms[0].hidappatached.value=="Y")
		{
			if(document.forms[0].hidappassign.value=="<%=strUserId%>" && document.forms[0].hidstatus.value=='P')
			{
				document.all.idRecipient1.style.visibility="hidden";
		 		document.all.idRecipient1.style.position="absolute";
		 		document.all.idRecipient2.style.visibility="hidden";
		 		document.all.idRecipient2.style.position="absolute";
		 		document.all.idAssign.style.position="absolute";
		 		document.all.idAssign.style.visibility="hidden";
				document.all.idSend.style.visibility="hidden";
			 	document.all.idSend.style.position="absolute";
			 	document.all.idResend.style.visibility="hidden";
			 	document.all.idResend.style.position="absolute";
			 	document.all.idAccept.style.visibility="visible";
				document.all.idAccept.style.position="relative";				
				document.forms[0].cmdAccept.disabled=false;
				document.forms[0].cmdReject.disabled=true;		
			}
			else
			{
				document.all.idRecipient1.style.visibility="hidden";
		 		document.all.idRecipient1.style.position="absolute";
		 		document.all.idRecipient2.style.visibility="hidden";
		 		document.all.idRecipient2.style.position="absolute";
		 		document.all.idAssign.style.position="absolute";
		 		document.all.idAssign.style.visibility="hidden";
				document.all.idSend.style.visibility="hidden";
				document.all.idSend.style.position="absolute";
				document.all.idResend.style.visibility="hidden";
			 	document.all.idResend.style.position="absolute";
				document.all.idAccept.style.visibility="visible";
				document.all.idAccept.style.position="relative";					
				document.forms[0].cmdAccept.disabled=true;
				document.forms[0].cmdReject.disabled=true;
			}
		}
		else if(document.forms[0].hidappatached.value=="N")
		{
		   if(document.forms[0].issaralhead.value=="Y" && document.forms[0].hidappassign.value=="<%=strUserId%>")
			{
				document.all.idRecipient1.style.visibility="visible";
		 		document.all.idRecipient1.style.position="relative";
		 		document.all.idRecipient2.style.visibility="visible";
		 		document.all.idRecipient2.style.position="relative";
		 		document.all.idAssign.style.position="relative";
		 		document.all.idAssign.style.visibility="visible";				 	
				document.all.idSend.style.visibility="hidden";
			 	document.all.idSend.style.position="absolute";			 	
			 	document.all.idAccept.style.visibility="hidden";
				document.all.idAccept.style.position="absolute";				
				document.all.idResend.style.visibility="visible";
			 	document.all.idResend.style.position="relative";				
				document.forms[0].cmdAccept.disabled=false;
				document.forms[0].cmdReject.disabled=false;	
			}
			else if(document.forms[0].issaralhead.value=="Y" && document.forms[0].hidstatus.value=="P")
			{
				document.all.idRecipient1.style.visibility="visible";
		 		document.all.idRecipient1.style.position="relative";
		 		document.all.idRecipient2.style.visibility="visible";
		 		document.all.idRecipient2.style.position="relative";
		 		document.all.idAssign.style.position="relative";
		 		document.all.idAssign.style.visibility="visible";				 	
				document.all.idSend.style.visibility="hidden";
			 	document.all.idSend.style.position="absolute";			 	
			 	document.all.idAccept.style.visibility="hidden";
				document.all.idAccept.style.position="absolute";				
				document.all.idResend.style.visibility="hidden";
			 	document.all.idResend.style.position="absolute";				
				document.forms[0].cmdAccept.disabled=true;
				document.forms[0].cmdReject.disabled=false;	
			}
			else if((document.forms[0].hidstatus.value=="P") && document.forms[0].hidappassign.value=="<%=strUserId%>")
			{
				document.all.idRecipient1.style.visibility="visible";
		 		document.all.idRecipient1.style.position="relative";
		 		document.all.idRecipient2.style.visibility="visible";
		 		document.all.idRecipient2.style.position="relative";
		 		document.all.idAssign.style.position="relative";
		 		document.all.idAssign.style.visibility="visible";				 	
				document.all.idSend.style.visibility="hidden";
			 	document.all.idSend.style.position="absolute";			 	
			 	document.all.idAccept.style.visibility="hidden";
				document.all.idAccept.style.position="absolute";				
				document.all.idResend.style.visibility="hidden";
			 	document.all.idResend.style.position="absolute";				
				document.forms[0].cmdAccept.disabled=true;
				document.forms[0].cmdReject.disabled=false;	
			}
		}
	}
	
	if(varStatus.toUpperCase()=="DATASUCCESS")
	{
		alert("Your Datas has been sent successfully");
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}	
	if(varright=="r")
	{
		document.all.idSend.style.visibility="hidden";
		document.all.idSend.style.position="absolute";		
		document.all.idAccept.style.visibility="hidden";
		document.all.idAccept.style.position="absolute";		
		document.all.idResend.style.visibility="hidden";
		document.all.idResend.style.position="absolute";		
		document.all.idAssign.style.visibility="hidden";
		document.all.idAssign.style.position="absolute";		
	}
}
function callRemarks()
{
	var varinwardno = document.forms[0].inwardno.value;
	var varsector = document.forms[0].hidsector.value;
	var varappname = document.forms[0].appname.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appURL+"action/saralworkflow_comments.jsp?hidtoUser="+document.forms[0].mail_tousrid.value+"&inwardno="+varinwardno+"&hidsector="+varsector+"&appname="+varappname+"&editoption=N"+"&hidBeanId=inwardRegister&hidBeanGetMethod=getInwardremarks";
	window.open(url,"remarks",prop);
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
</HEAD>
<BODY onLoad="onLoading()">
<form name="myform" method="post" class="normal">
<lapschoice:saralreportTag tabid="1" sector='<%=strSector%>' applied='<%=strappliedfor%>'  proposal='<%=strProposal%>'/> 
<lapschoice:inward />
<lapstab:SaralworkflowTag tabid="2"/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td align="center">
		<table width="50%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td id="idRecipient1"><b>Select Recipient</b></td>
				<td id="idRecipient2">
				<input type="text" name="mail_tousrid" size="37" readonly="readonly"> <input
					type="hidden" name="hidmail_tousrid"> <a href="#"
					onClick="javascript:callUsersHelp()"> <img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"> </a>
				</td>
				<td id="idAssign"> <input type="button" name="cmdAssign" value="Assign"
					class="buttonStyle" onClick="doAssign()"></td>
			</tr>
		</table>
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td align="center" valign="top">&nbsp;</td>
			</tr>
			<tr align="center">
				<td align="center">
					<table width="50%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr align="center">
						<td id="idSend">
						<input type="button" name="cmdAction" value="Send" class="buttonStyle"
							onclick="doAction('send','<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','<%=Helper.correctNull((String)request.getParameter("hidsector"))%>','<%=Helper.correctNull((String)request.getParameter("appliedfor"))%>')">
						</td>
						<td id="idAccept"><input type="button" name="cmdAccept" value="Attach to Application" class="buttonStyle"
							style="width:150"
							onclick="doAction('accept','<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','<%=Helper.correctNull((String)request.getParameter("hidsector"))%>','<%=Helper.correctNull((String)request.getParameter("appliedfor"))%>')">
						</td>
						<td id="idResend"><input type="button" name="cmdReject" value="Resend to Branch"
							class="buttonStyle" style="width:150"
							onclick="doAction('reject','<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','<%=Helper.correctNull((String)request.getParameter("hidsector"))%>','<%=Helper.correctNull((String)request.getParameter("appliedfor"))%>')">
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
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="mail_touserclass">
 <input type="hidden" name="hidconfirm" >
 <input type="hidden" name="remarksFlag">
 <input type="hidden" name="hideditoption" > 
 <iframe name="ifrm" width="0" height="0"></iframe>
</form>
</BODY>
</HTML>