<%@include file="../share/directives.jsp"%>
<%HashMap hshRecord = (HashMap) hshValues.get("hshRecord");

String pageid = Helper.correctNull((String) request.getParameter("pageid"));
String strapptype = Helper.correctNull((String) request.getParameter("corp"));
if(strapptype.equalsIgnoreCase(""))
{
	strapptype = Helper.correctNull((String)request.getParameter("hidapptype"));
}
String strEmployment=(String)session.getAttribute("strEmployment");
String strModuleName = Helper.correctNull(request.getParameter("hidModuleName"));
String strModName = "";
if (strModuleName.equalsIgnoreCase("T")) {
	strModName = "Tertiary";
} else if (strModuleName.equalsIgnoreCase("P")) {
	strModName = "Retail";
} else {
	strModName = "Corporate & SME";
}
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Rating/Defaulter</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var selrbidefaulter="<%=Helper.correctNull((String) hshValues.get("DEF_RBIDEFIS"))%>";
var selECGCI ="<%=Helper.correctNull((String) hshValues.get("DEF_ECGSEPIS"))%>";
var selWillful ="<%=Helper.correctNull((String) hshValues.get("DEF_WILDEFIS"))%>";
var selExitPloicy ="<%=Helper.correctNull((String) hshValues.get("DEF_EXITPOLIS"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function callOnload()
{ 
	if(selrbidefaulter =="Y"){
		document.forms[0].sel_RBIDefaulter.value="Y";
	}else if(selrbidefaulter =="N"){
		document.forms[0].sel_RBIDefaulter.value="N";
	}else{
		document.forms[0].sel_RBIDefaulter.value="";
	}

	if(selECGCI =="Y"){
		document.forms[0].sel_ECGCIList.value="Y";
	}else if(selECGCI =="N"){
		document.forms[0].sel_ECGCIList.value="N";
	}else{
		document.forms[0].sel_ECGCIList.value="";
	}

	if(selWillful =="Y"){
		document.forms[0].sel_Willful.value="Y";
	}else if(selWillful =="N"){
		document.forms[0].sel_Willful.value="N";
	}else{
		document.forms[0].sel_Willful.value="";
	}

	if(selExitPloicy =="Y"){
		document.forms[0].sel_Identified.value="Y";
	}else if(selExitPloicy =="N"){
		document.forms[0].sel_Identified.value="N";
	}else{
		document.forms[0].sel_Identified.value="";
	}	
  	calldisable(true);
  	
	hidDate();
	var varrefcibil="<%=Helper.correctNull((String)hshValues.get("cibil_rat_status"))%>";
	document.forms[0].sel_refercibil.value=varrefcibil;
	if(varrefcibil=='Y')
	{
		cibildet();
	}
	else
	{		
		document.forms[0].txt_datecibil.value="";
		document.forms[0].txt_cibilComment.value="";
		document.forms[0].txt_cibilscore.value="";
		cibildet();
	}
}
function disablecontrols(edit,save,cancel,cdelete,close)
{
	document.forms[0].cmdedit.disabled = edit;
	document.forms[0].cmdsave.disabled = save;
	document.forms[0].cmdcancel.disabled = cancel;
	document.forms[0].cmddelete.disabled = cdelete;
	document.forms[0].cmdclose.disabled = close;
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{
	calldisable(false);
	disablecontrols(true,false,false,false,false);
	document.forms[0].hideditflag.value="Y";
}

function doSave()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDefaulter";
	document.forms[0].hidBeanGetMethod.value="getDefaulter";
	document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].action=appURL+"action/customerDefaulter.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateDefaulter";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(158);
	}			
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{	
		showCal(appURL,name);
	}
}

function callLink(page,bean,method)
{ 
	document.forms[0].hidAction.value="";
 	document.forms[0].hidBeanGetMethod.value=method;
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page;
 	document.forms[0].submit();
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function hidDate()
{
	
if(document.forms[0].sel_RBIDefaulter.value=="Y"){
	document.all.hid1.style.visibility="visible";
	document.all.hid1.style.position="relative";
	document.all.hid2.style.visibility="visible";
	document.all.hid2.style.position="relative";
	document.all.hid3.style.visibility="visible";
	document.all.hid3.style.position="relative";
	document.all.hid4.style.visibility="visible";
	document.all.hid4.style.position="relative";
	document.all.hid5.style.visibility="visible";
	document.all.hid5.style.position="relative";
	document.all.hid6.style.visibility="visible";
	document.all.hid6.style.position="relative";
	document.all.hid19.style.visibility="visible";
	document.all.hid19.style.position="relative";
}
else
{
	document.all.hid1.style.visibility="hidden";
	document.all.hid2.style.visibility="hidden";
	document.all.hid3.style.visibility="hidden";
	document.all.hid4.style.visibility="hidden";
	document.all.hid5.style.visibility="hidden";
	document.all.hid6.style.visibility="hidden";
	document.all.hid19.style.visibility="hidden";
}
if(document.forms[0].sel_ECGCIList.value=="Y"){
	document.all.hid7.style.visibility="visible";
	document.all.hid7.style.position="relative";
	document.all.hid8.style.visibility="visible";
	document.all.hid8.style.position="relative";
	document.all.hid9.style.visibility="visible";
	document.all.hid9.style.position="relative";
	document.all.hid10.style.visibility="visible";
	document.all.hid10.style.position="relative";
	document.all.hid11.style.visibility="visible";
	document.all.hid11.style.position="relative";
	document.all.hid12.style.visibility="visible";
	document.all.hid12.style.position="relative";
	document.all.hid20.style.visibility="visible";
	document.all.hid20.style.position="relative";
}
else{
	document.all.hid7.style.visibility="hidden";
	document.all.hid8.style.visibility="hidden";
	document.all.hid9.style.visibility="hidden";
	document.all.hid10.style.visibility="hidden";
	document.all.hid11.style.visibility="hidden";
	document.all.hid12.style.visibility="hidden";
	document.all.hid20.style.visibility="hidden";
}
if(document.forms[0].sel_Willful.value=="Y"){

	document.all.hid13.style.visibility="visible";
	document.all.hid13.style.position="relative";
	document.all.hid14.style.visibility="visible";
	document.all.hid14.style.position="relative";
	document.all.hid15.style.visibility="visible";
	document.all.hid15.style.position="relative";
	document.all.hid16.style.visibility="visible";
	document.all.hid16.style.position="relative";
	document.all.hid17.style.visibility="visible";
	document.all.hid17.style.position="relative";
	document.all.hid18.style.visibility="visible";
	document.all.hid18.style.position="relative";
	document.all.hid21.style.visibility="visible";
	document.all.hid21.style.position="relative";
}
else{
	document.all.hid13.style.visibility="hidden";
	document.all.hid14.style.visibility="hidden";
	document.all.hid15.style.visibility="hidden";
	document.all.hid16.style.visibility="hidden";
	document.all.hid17.style.visibility="hidden";
	document.all.hid18.style.visibility="hidden";
	document.all.hid21.style.visibility="hidden";
}

if(document.forms[0].sel_Identified.value=="Y"){
	
	document.all.hid22.style.visibility="visible";
	document.all.hid22.style.position="relative";
}
else{
	
	document.all.hid22.style.visibility="hidden";
}
		
}

function cibildet()
{
	
	if(document.forms[0].sel_refercibil.value=="Y")
	{
		document.all.hidcibil.style.visibility="visible";
		document.all.hidcibil.style.position="relative";
		document.all.hidcibil1.style.visibility="visible";
		document.all.hidcibil1.style.position="relative";
	}
	else
	{
		
		document.all.hidcibil.style.visibility="hidden";
		document.all.hidcibil.style.position="absolute";
		document.all.hidcibil1.style.visibility="hidden";
		document.all.hidcibil1.style.position="absolute";
		
	}
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload()">
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
<form name="colForm" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="24" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
       <%if(strapptype.equalsIgnoreCase("C")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   <%
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Rating/Defaulter</td>
	</tr>
	
  </table>
	<%}}else if(strapptype.equalsIgnoreCase("R")){%>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
    </tr>
  </table>
  <%} %>
<lapschoice:application />
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="24"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
	<%}} %>

<table width="30%" border="0" cellpadding="1" cellspacing="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="#" 
		onclick="javascript:callLink('customerRatingdisp.jsp','mastapplicant','getRating')">
		Rating</a></b></td>
		<td class="sub_tab_active" align="center"><b>Defaulter</b></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr valign="top" class="applicationheader"><td width="50%" colspan="9"><b>Defaulter</b></td></tr>
		<tr>
		<td>Whether RBI Defaulter</td>
						<td><select name="sel_RBIDefaulter" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td id="hid19">
		
		<textarea name="txt_RBIDefaulter" cols="25"  rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("DEF_RBIDEFCOMM"))%></textarea></td>
		<td id="hid1">From Date </td>										
		<td id="hid2"><input type="text" name="txt_fromdate1" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_RBIFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid3"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate1')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid4">Deleted on Date </td>										
		<td id="hid5"><input type="text" name="txt_deleteondate1" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_RBIDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid6"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate1')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		</tr>
		<tr>
		<td>Whether ECGCI Specific list</td>
						<td><select name="sel_ECGCIList" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td id="hid20">
		<textarea name="txt_ECGCIList" cols="25"  rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_ECGSEPCOMM"))%></textarea></td>
					
		<td id="hid7">From Date </td>										
		<td id="hid8"><input type="text" name="txt_fromdate2" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid9"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate2')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid10">Deleted on Date </td>										
		<td id="hid11"><input type="text" name="txt_deleteondate2" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid12"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate2')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
		</tr>
		
		<tr>
		<td>Whether Willful Defaulter</td>
						<td><select name="sel_Willful" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td id="hid21">
		<textarea name="txt_Willful" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("DEF_WILDDEFCOMM"))%></textarea></td>
							
		<td id="hid13">From Date </td>										
		<td id="hid14"><input type="text" name="txt_fromdate3" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_WILFRMDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid15"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_fromdate3')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		<td id="hid16">Deleted on Date </td>										
		<td id="hid17"><input type="text" name="txt_deleteondate3" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_WILDELDAT"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
		<td id="hid18"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_deleteondate3')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
		</tr>
	
	<tr>
		<td>Whether Identified under EXIT policy</td>
						<td><select name="sel_Identified" onchange="hidDate()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td id="hid22"><textarea name="txt_Identified" cols="25"  rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("DEF_EXITPOLCOMM"))%></textarea></td>
											
		
		</tr>
		
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
		<tr valign="top" class="applicationheader">
            <td colspan="4"><b>CIBIL Details</b></td>
        </tr>
		
		<tr>
		<td width="14%" nowrap="nowrap">Whether Refered to CIBIL</td>
		<td colspan="" width="20%">
							<select name="sel_refercibil" onchange="cibildet()">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td></td>
		<td></td>
		</tr>
		<tr id="hidcibil">		
            <td width="14%">CIBIL Score</td>						
            <td colspan="" ><input type="text" name="txt_cibilscore" size="15" maxlength="5"
			 value='<%=Helper.correctNull((String)hshValues.get("cibil_score"))%>' onKeyPress="allowNumber(document.forms[0].txt_cibilscore)"  tabindex="9" style="text-align:right"></td>
		    <td width="14%">Reported Date</td>
		    <td ><input type="text" name="txt_datecibil" size="10" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("cibil_reporteddate")) %>">
		    <a style="vertical-align: middle;" alt="Select date from calender" href="#"
							onClick="callCalender('txt_datecibil')" onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" ></a></td>
		</tr>
		<tr id="hidcibil1">		
            <td width="14%">CIBIL Details</td>						
            <td colspan="3" ><textarea name="txt_cibilComment" cols="140"  rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("cibil_details"))%></textarea>
            </td>
		</tr>				
	  </table>		
		<td>
	</tr>
</table>
<br>
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		<input type="button" name="cmdsave" disabled style="display:none">
<br>
<%String strappno = request.getParameter("appno");%> 
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("applicantId"))%>"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">   
<input type="hidden" name="hidFromPage" value="Defaulter">
<input type="hidden" name="hidapptype" value="<%=strapptype%>">    
</form>
</body>
</html>
