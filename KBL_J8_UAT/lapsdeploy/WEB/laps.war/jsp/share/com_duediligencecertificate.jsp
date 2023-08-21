<%@include file="../share/directives.jsp"%>
<%
	String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String appstatus = (String) request.getParameter("appstatus");
	String strappholder = Helper.correctNull((String) request.getParameter("appholder"));
	String strloanType = Helper.correctNull((String) request.getParameter("apploantype"));
	String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
	String strProposal = Helper.correctNull((String) request.getParameter("hidproposal"));
	String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	//Added by Zahoorunnisa.S for button functionality
    
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
	    strstatus = Helper.correctNull((String) hshValues.get("status"));

	//end
%>

<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var appstatus="<%=appstatus%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var varstrapplevel = "<%=strapplevel%>";

function selectValues(val1,val2,val3)
{
	document.forms[0].selnaturefac.value=val2;
	document.forms[0].txt_limitapplied.value=val3;
	document.forms[0].hid_slno.value=val1;
	if("<%=strSaral%>"=="saral")
	{
		disableCommandButtons(true,true,true,false,false);
	}
	else
	{
		disableCommandButtons(true,true,true,true,false);
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons(valedit,valapply,valcancel,valdel)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
}
function onloading()
{	  
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			disableCommandButtons(false,true,true,true,false,false);
		}else{
			disableCommandButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
	//End

	disableFields(true);
  
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);
	document.forms[0].due_comments.focus();
}

function doSave()
{
	if(document.forms[0].txt_date.value=='')
	{
	ShowAlert(112,'Date');
	document.forms[0].txt_date.focus();
	return;
	}
	if(document.forms[0].txt_officername.value=='')
	{
	ShowAlert(112,'Name of Officers');
	document.forms[0].txt_officername.focus();
	return;
	}
	if(document.forms[0].txt_designation.value=='')
	{
	ShowAlert(112,'Designation');
	document.forms[0].txt_designation.focus();
	return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="lapsReport";		
	document.forms[0].hidSourceUrl.value="/action/com_duediligencecertificate.jsp";
	document.forms[0].hidBeanMethod.value="updateComDueDiligenceCertificate";
	document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateComDueDiligenceCertificate";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidSourceUrl.value="action/com_duediligencecertificate.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
		document.forms[0].action=appURL+"action/com_duediligencecertificate.jsp";
		document.forms[0].submit();
	}
}
   
function disableCommandButtons(cmdedit,cmdsave,cmddelete,cmdcancel,cmdclose)
{  
  document.forms[0].cmdedit.disabled=cmdedit;	  
  document.forms[0].cmdsave.disabled=cmdsave;
  document.forms[0].cmddelete.disabled=cmddelete;
  document.forms[0].cmdcancel.disabled=cmdcancel;
  document.forms[0].cmdclose.disabled=cmdclose;
}
 function doClose()
{
	if(ConfirmMsg(100))
	{
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			if("<%=strloanType%>"=="C")
			{
				document.forms[0].method="post";	
				document.forms[0].action=appURL+"action/corppge.jsp";
				document.forms[0].submit();
			}
			else if("<%=strloanType%>"=="P")
			{
				document.forms[0].action=appURL+"action/retailpge.jsp";
				document.forms[0].submit();
			}
		}
	}
}

function doPrint()
{
	if (("<%=strSaral%>"=="saral"))
		{
			var inwardno=document.forms[0].inwardno.value;
			var varsaral="<%=strSaral%>";
			var appname=document.forms[0].appname.value;
			var hidsector=document.forms[0].hidsector.value;
			var hidslno=document.forms[0].hid_slno.value;
			var purl ="<%=ApplicationParams.getAppUrl()%>action/com_duediligencecertificateprint.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getComDueDiligenceCertificate&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
		}
		else
		{
			var appno = document.forms[0].appno.value;
			var appname=document.forms[0].appname.value;
			var inwardno=document.forms[0].inwardno.value;
			var purl ="<%=ApplicationParams.getAppUrl()%>action/com_duediligencecertificateprint.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getComDueDiligenceCertificate&appno="+appno+"&applicantname="+appname+"&inwardno="+inwardno;		
		}
		var prop = 'scrollbars=yes,menubar=yes,width=680,height=500';	
		var xpos = (screen.width - 200) / 2;
		var ypos = (screen.height - 6000) / 2;
		prop = prop + ",left=0,top=100";
		window.open(purl,'DueDiligenceCertificate',prop);
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
	 		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" name="frmbrrecmd" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="4" sector='<%=strSector%>' applied='<%=strappliedfor%>' proposal='<%=strProposal%>' /> 
<lapschoice:inward /> <%} else {
 		if (strloanType.equalsIgnoreCase("P")) {%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report - Others </td>
	</tr>
</table>
<lapschoice:application />
<jsp:include page='../share/apprlinktab.jsp' flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include>
<%} else {%>
<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="14" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate & SME -&gt; Proposal -&gt; Credit / Inspection Report -&gt; Due Diligence -&gt; Due Diligence Report - Others 
		</td>
	</tr>
</table>
<lapschoice:application /> 
<span style="display: none"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="5" applevel='<%=Helper.correctNull((String) request.getParameter("applevel"))%>' applied='<%=strappliedfor%>' /> 
<%}}%>
<table width="75%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<%String strother = "";
			if ((strSector.equalsIgnoreCase("Retail"))|| (strloanType.equalsIgnoreCase("P"))) {
				strother = " - Others";%>
		<td class="sub_tab_inactive" align="center" width="15%"> 
		<a href="JavaScript:gotoTab('','lapsReport','getDueDiligenceRetail','Duediligence1.jsp')" onMouseOut="window.status='';return true;" >
		Due Diligence Report - Salaried</a> </td>
		<%}%>
		<td class="sub_tab_active" align="center" width="15%"> Due Diligence Report <%=strother%> </td>
		<td class="sub_tab_inactive" align="center" width="15%"><a href="JavaScript:gotoTab('','lapsReport','getComDueDiligenceReport','com_duediligencereport.jsp')" onMouseOut="window.status='';return true;" >
		Due Diligence of Properties</a> </td>
	</tr>
</table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
							align="center">
							<tr>
								<td colspan="2">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td colspan="2"> Observations of inspecting official </td>
									</tr>
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="66%">
	<textarea name="due_comments" cols="120" wrap="VIRTUAL" rows="20" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("duecertificate_comments"))%></textarea>
										</td>
										<td width="45%" align="left">(Please offer your comments on the following aspects)
										<ul>
											<li>Interview / Discussion with applicant </li>
											<li>Credit Reports</li>
											<li>Industry Prospects</li>
											<li>Brief comments on financial position</li>
											<li>Market information</li>
											<li>Confidential opinion from existing bankers</li>
											<li>Presanction visit to applicants place</li>
											<li>CIBIL / ECGC caution list / RBI Defaulter
											list / No dues from sales Tax,Excise Duty etc.;</li>
											<li>Any other important aspect observed.</li>
										</ul>
										</td>
									</tr>
									<tr>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="61%">Certificate</td>
									</tr>
									<tr>
										<td colspan="2">" I have made enquiries from <input
											type="text" name="txt_enquiredby" size="35" maxlength="25"
											value="<%=Helper.correctNull((String) hshValues.get("duecertificate_enquriedby"))%>">
										about <%=Helper.correctNull((String) request.getParameter("appname"))%> / their partners /Directors. <input
											type="text" name="txt_enquired" size="35" maxlength="25"
											value="<%=Helper.correctNull((String) hshValues.get("duecertificate_enquried"))%>">
										have given a good report on the dealings and conduct of the
										aforesaid parties. "</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="7"> (This certificate is not required
								in respect of well-known listed Corporates, Central &amp; State
								Public Sector undertakings.)</td>
							</tr>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
							<tr>
								<td width="50%">Date <span class="mantatory">*</span>: &nbsp; <input type="text"
									name="txt_date" size="15" maxlength="25"
									value="<%=Helper.correctNull((String) hshValues.get("duedate"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate)">
								<a href="#" onClick="callCalender('txt_date')"
									title="Click to view calender"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									tabindex="2" width="0" border="0"></a></td>
								<td width="50%">Name of Officers <span class="mantatory">*</span>: &nbsp; <input
									type="text" name="txt_officername" size="35" maxlength="25"
									value="<%=Helper.correctNull((String) hshValues.get("dueofficername"))%>">
								</td>
							</tr>
							<tr>
								<td width="50%">&nbsp;</td>
								<td width="50%">Designation <span class="mantatory">*</span>: &nbsp; <input
									type="text" name="txt_designation" size="35" maxlength="25"
									value="<%=Helper.correctNull((String) hshValues.get("duedesignation"))%>">
								</td>
							</tr>
							<tr>
								<td width="50%">&nbsp;</td>
								<td width="50%">&nbsp;</td>
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
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="hid_slno" value="">
<input type="hidden" name="radLoan" value="Y"></form>

</body>
</html>
