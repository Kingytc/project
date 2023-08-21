<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<%
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strappholder = Helper.correctNull((String) request
			.getParameter("appholder"));
	
	 //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	//End
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var varOrgLevel="<%=strOrgLevel%>";		
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmdclose)
{
		 	document.forms[0].cmdedit.disabled=cmdedit;
			document.forms[0].cmdsave.disabled=cmdsave;
			document.forms[0].cmdcancel.disabled=cmdcancel;
			document.forms[0].cmdclose.disabled=cmdclose;
}
function onLoading()
{
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,false,false);
		}else{
			enableButtons(true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,false);
		}
	}

  
	//End
	disableFields(true);
}
function doEdit()
{ 	
	document.forms[0].hidAction.value ="U";
	disableCommandButtons(true,false,false,true);
	disableFields(false);	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/Duediligence3.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		//document.forms[0].hidBeanMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")
	{
		disableFields(true);
		disableCommandButtons(true,true,true,false);
	}	
	else
	{
			disableFields(true);
			disableCommandButtons(false,true,true,false);
	}
}

function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/Duediligence3.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateDueDiligence3";
	document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{	
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=true;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		document.forms[0].txt_palce.readOnly=false;  
		//document.forms[0].txt_inspectingdesign.readOnly=false;  
		 
	}
}

function callLink(page,bean,method)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
		}

function doClose()
{
if(ConfirmMsg('100'))
	{
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/persearch.jsp?&id="+document.forms[0].id.value+"&comapp_compname="+document.forms[0].comapp_compname.value;
			document.forms[0].submit();
		}
	}
}
	
function doPrint()
{
	if(("<%=strSaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var varsaral="<%=strSaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var purl=appURL+"action/Duediligence_print.jsp?hidBeanGetMethod=getDueDiligenceRetail&hidBeanId=lapsReport&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
	}
	else
	{
		var inwardno=document.forms[0].inwardno.value;
		var appno="<%=request.getParameter("appno")%>";
		var apploantype=document.forms[0].apploantype.value;
		var purl=appURL+"action/Duediligence_print.jsp?hidBeanGetMethod=getDueDiligenceRetail&hidBeanId=lapsReport&appno="+appno+"&apploantype="+apploantype+"&inwardno="+inwardno;
	}
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'title',prop);
}
function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	//document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled!=true)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
</script>
</head>
<body onload="onLoading()">
<form name="form1" action="" method="post" class="normal">
<%
	if (strSaral.equalsIgnoreCase("saral")) {
%> <laps:saralreportTag
	tabid="4" sector="<%=strSector%>" /> <laps:inward /> <%
 	} else {
 %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable linebor">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="pagepathheader"><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%>
		-&gt; Appraisal -&gt; Due Diligence Report </i></b></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="1" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<%
	}
%>
<table width="75%" border="0" cellspacing="3" cellpadding="5"
	class="outertable">
	<tr>
		<td class="sub_tab_active" align="center"><b> Due Diligence
		Report - Salaried </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')"
			onMouseOut="window.status='';return true;">Due Diligence Report
		- Others</a> </b></td>
		<td class="sub_tab_inactive" align="center"><b> <a
			href="JavaScript:gotoTab('<%//=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceReport','com_duediligencereport.jsp')"
			onMouseOut="window.status='';return true;">Due Diligence of Properties</a> </b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<!--  <tr>
    <td align="center">
      <strong>UNION  BANK OF INDIA</strong></td>

  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><strong>RETAIL BANKING DEPARTMENT<br />
      CENTRAL OFFICE<br />
    MUMBAI</strong></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>SALARIED PERSONS:</td>
  </tr>-->
	
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="2%">&nbsp;</td>
				<td width="33%">&nbsp;</td>
				<td width="65%">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">6.</td>
				<td valign="top">Whether the undertaking given by the employer
				for deduction of loan installment is verified and found genuine?</td>
				<td><textarea name="txtUndertakingVerified" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
							.get("strUndertakingVerified"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">7.</td>
				<td valign="top">(a)Whether the Authority who issued such
				letter of undertaking for deduction of loan installment is competent
				to issue such undertaking?<br />
				<br />
				(b)Whether the Organization normally issues such letters of
				undertaking ? <br />
				(Essentially this fact is to be enquired with the employer and if
				needed discretely as some of the Organizations do not issue such
				letters of undertaking, but applicants manage to get such
				undertaking from unauthorized Officials )<br />
				</td>
				<td><textarea name="txtUndertakingAuthority" cols="50" rows="9" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
							.get("strUndertakingAuthority"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">8.</td>
				<td valign="top">(a) Whether copies of IT Returns submitted by
				the applicant (s) are verified with the Originals?<br />
				<br />
				(b) Whether genuineness of IT returns is verified with I.T.
				Department? If so when ( mention the date ) and who has verified the
				same.<br />
				</td>
				<td><textarea name="txtITReturns" cols="50" rows="5"  onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
									.get("strITReturns"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">9.</td>
				<td valign="top">Whether identity of the applicant is verified
				based on PAN Number <br />
				( wherever applicable )</td>
				<td><textarea name="txtPANIdentity" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
							.get("strPANIdentity"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">10.</td>
				<td valign="top">Whether any of the following documents like
				Electricity Bill, LIC receipts, Voters ID, Telephone Bill , Society
				Rent Agreement, Credit Card Billing etc. are verified?</td>
				<td><textarea name="txtDocumentVerified" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
							.get("strDocumentVerified"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">11</td>
				<td valign="top">
				<p>Whether Bank Statement /extract Pass book (SB account or CD
				account ) is verified ( including first page of pass book )? If yes,
				given comment on the following:</p>
				<p>a.Whether the account is active or Dormant?<br />
				b.Nature of Debits/Credits<br />
				c.Abnormal Value Transactions<br />
				d.Average Balance<br />
				e.Repayments to other Institutions<br />
				f.Cheque Returns<br />
				g.ECS transactions<br />
				h.Incidence of OD</p>
				</td>
				<td><textarea name="txtBnkstmtVerified" cols="50" rows="15" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String) hshValues
							.get("strBnkstmtVerified"))%></textarea>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<!--<tr> 
            <td width="3%">&nbsp;</td>
            <td > 
              <table width="23%" border="0">
                <tr> 
                  <td width="6%">Date:</td>
                  <td width="20%"> 
                    <input type="text" name="txt_date"
									value="<%//=Helper.correctNull((String)hshValues.get("duedatevisit"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate)" />
                  </td>
                  <td width="6%"><a alt="Select date from calender" href="#"
									onClick="callCalender('txt_date')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"> 
                    <img
									src="<%//=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" /></a></td>
                </tr>
              </table>
            </td>
            <td width="65%">Name of the Inspecting officers: &nbsp; 
              <input type="text" name="txt_inspecting"
									value="<%//=Helper.correctNull((String)hshValues.get("dueinspectorname"))%>"
									 />
            </td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td></td>
            <td width="65%">Designation: &nbsp; 
              <input type="text" name="txt_inspectingdesign"
									value="<%//=Helper.correctNull((String)hshValues.get("dueinspectordesign"))%>" />
            </td>
          </tr>
    </table></td>

  </tr>-->
			<tr>
				<td>&nbsp;</td>
				<td>Date of Due Diligence</td>
				<td>
				<table width="23%" border="0" class="outertable">
					<tr>
						<td width="20%"><input type="text" name="txt_date"
							value="<%=Helper.correctNull((String) hshValues
									.get("duedatevisit"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)" /></td>
						<td width="6%"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"> <img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" /></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>Place</td>
				<td><input type="text" name="txt_palce"
					value="<%=Helper.correctNull((String) hshValues.get("dueplace"))%>"
					maxlength="30" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Print' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="33%" align="left"><b>&nbsp; <a
					href="javascript:callLink('Duediligence2.jsp','lapsReport','getDueDiligenceRetail')">
				&lt;&lt; Prev </a>&nbsp;Pg.3/3 </b></td>
				<td width="33%" align="center"><b><jsp:include
					page="../per/Duediligencelink.jsp" flush="true"/>
				</b></td>
				<td width="33%">&nbsp;</td>
			</tr>
		</table>
		<laps:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="radLoan" value="Y">
</table>
</form>
</body>
</html>
