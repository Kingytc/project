<%@include file="../share/directives.jsp"%>
<%
	String strsaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String appstatus = (String) request.getParameter("appstatus");
	String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
	ArrayList arrCol = new ArrayList();
	String strValuesin = Helper.correctNull((String) request.getParameter("valuesin"));
	if (strValuesin.equals("L")) {
		strValuesin = " in Lacs";
	} else if (strValuesin.equals("C")) {
		strValuesin = " in Crores";
	}else{
		strValuesin = "";
	}
	String strappholder = Helper.correctNull((String) request.getParameter("appholder"));
	String strloanType = Helper.correctNull((String) request.getParameter("apploantype"));
	String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
	String strProposal = Helper.correctNull((String) request.getParameter("hidproposal"));
    //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	//End
	String strright = "";
	if (strGroupRights.length() > 0) {
		int len = strGroupRights.length();
		strright = strGroupRights.substring(18,19);
		
	}%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var insbanknameboard="<%=Helper.correctNull((String) hshValues.get("mmr_insbanknameboard"))%>";
var insborrowernamebord="<%=Helper.correctNull((String) hshValues.get("borrower_name"))%>";
var insmaintanance="<%=Helper.correctNull((String) hshValues.get("proper_main"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varsaral="<%=strsaral%>";
var appstatus="<%=appstatus%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";

function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
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
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			
		    enableButtons(false,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
			}
	}

	
	//End
	
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateComDueDiligenceReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidSourceUrl.value="action/com_duediligencereport.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
	 disableCommandButtons(true,false,false,false,true);	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
		document.forms[0].action=appURL +"action/com_duediligencereport.jsp";
	    document.forms[0].submit();	
	}	
}

function doSave()
{
	if(trim(document.forms[0].txt_inspect.value)=="")
	{
		alert('Enter Inspected Date');
		document.forms[0].txt_inspect.focus();
		return;
	}
	if(trim(document.forms[0].txt_name.value)=="")
	{
		alert("Visited Officer Name");
		document.forms[0].txt_name.focus();
		return;
	}
	if(trim(document.forms[0].txt_designation.value)=="")
	{
		alert("Visited Officer Designation");
		document.forms[0].txt_designation.focus();
		return;
	}
	if(trim(document.forms[0].txt_docs.value)=="")
	{
		alert("Enter List of documents submitted");
		document.forms[0].txt_docs.focus();
		return;
	}
	if(trim(document.forms[0].txt_plot.value)=="")
	{
		alert("Enter Plot No. / Survery No");
		document.forms[0].txt_plot.focus();
		return;
	}
	if(trim(document.forms[0].txt_residential.value)=="")
	{
		alert("Enter Whether residential / commercial or industrial / Agriculture");
		document.forms[0].txt_residential.focus();
		return;
	}
	if(trim(document.forms[0].txt_mortrelation.value)=="")
	{
		alert("Enter Relationship of the borrower with the mortgager");
		document.forms[0].txt_mortrelation.focus();
		return;
	}
	if(trim(document.forms[0].txt_market.value)=="")
	{
		alert("Enter Comments on the marketablity of the property");
		document.forms[0].txt_market.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateComDueDiligenceReport";
	document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_duediligencereport.jsp";
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
		if(document.forms[0].elements[i].type=='textarea') {
		
			document.forms[0].elements[i].readOnly=val;
		} 	  
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
    	if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
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

function doPrint()
{
	if(trim(document.forms[0].hid_slno.value)!="")
	{
		var varvaluesin ="<%=strValuesin%>";
		if (("<%=strsaral%>"=="saral"))
		{
			var inwardno=document.forms[0].inwardno.value;
			var varsaral="<%=strsaral%>";
			var appname=document.forms[0].appname.value;
			var hidsector=document.forms[0].hidsector.value;
			var hidslno=document.forms[0].hid_slno.value;
			var purl = appURL+"action/com_duediligencereportprint.jsp?hidBeanGetMethod=getComDueDiligenceReportPrint&hidBeanId=lapsReport&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector+"&hidslno="+hidslno+"&valuesin="+varvaluesin;
		}
		else
		{
			var appno = document.forms[0].appno.value;
			var hidslno=document.forms[0].hid_slno.value;
			var appname=document.forms[0].appname.value;
			var inwardno=document.forms[0].inwardno.value;
			var varcategory=document.forms[0].hidCategoryType.value;
			var purl = appURL+"action/com_duediligencereportprint.jsp?hidBeanGetMethod=getComDueDiligenceReportPrint&hidBeanId=lapsReport&appno="+appno+"&hidslno="+hidslno+"&applicantname="+appname+"&inwardno="+inwardno+"&hidCategoryType="+varcategory+"&valuesin="+varvaluesin;
		}
		prop = "scrollbars=yes,width=800,height=650,statusbar=no,menubar=yes,location=no,toolbar=no";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Corporate_preinspectionreport";
		window.open(purl,title,prop);
	}
	else
	{
		alert("Select a Property");
		return;
	}
}

function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hid_slno.value='';
	document.forms[0].txt_inspect.value='';
	document.forms[0].txt_name.value='';
	document.forms[0].txt_designation.value='';
	document.forms[0].txt_docs.value='';
	document.forms[0].txt_address.value='';
	document.forms[0].txt_property.value='';
	document.forms[0].txt_plot.value='';
	document.forms[0].txt_door.value='';
	document.forms[0].txt_TSNo.value='';
	document.forms[0].txt_ward.value='';
	document.forms[0].txt_mandal.value='';
	document.forms[0].txt_others.value='';
	document.forms[0].txt_residential.value='';
	document.forms[0].txt_corporation.value='';
	document.forms[0].txt_state.value='';
	document.forms[0].txt_plotsize.value='';
	document.forms[0].txt_owners.value='';
	document.forms[0].txt_sincewhen.value='';
	document.forms[0].txt_civic.value='';
	document.forms[0].txt_boundaries.value='';
	document.forms[0].txt_surrounding.value='';
	document.forms[0].txt_certificate.value='';
	document.forms[0].txt_mortrelation.value='';
	document.forms[0].txt_enquiry.value='';
	document.forms[0].txt_propertyvalue.value='';
	document.forms[0].txt_market.value='';
	enableButtons(true,true,false,false,true,true);
}

function selOption(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29)
{
	document.forms[0].txt_appno.value=val1;
	document.forms[0].hid_slno.value=val3;
	document.forms[0].txt_inspect.value=val4;
	document.forms[0].txt_name.value=val5;
	document.forms[0].txt_designation.value=val6;
	document.forms[0].txt_docs.value=val7;
	document.forms[0].txt_address.value=val8;
	document.forms[0].txt_property.value=val9;
	document.forms[0].txt_plot.value=val10;
	document.forms[0].txt_door.value=val11;
	document.forms[0].txt_TSNo.value=val12;
	document.forms[0].txt_ward.value=val13;
	document.forms[0].txt_mandal.value=val14;
	document.forms[0].txt_others.value=val15;
	document.forms[0].txt_residential.value=val16;
	document.forms[0].txt_corporation.value=val17;
	document.forms[0].txt_state.value=val18;
	document.forms[0].txt_plotsize.value=val19;
	document.forms[0].txt_owners.value=val20;
	document.forms[0].txt_sincewhen.value=val21;
	document.forms[0].txt_civic.value=val22;
	document.forms[0].txt_boundaries.value=val23;
	document.forms[0].txt_surrounding.value=val24;
	document.forms[0].txt_certificate.value=val25;
	document.forms[0].txt_mortrelation.value=val26;
	document.forms[0].txt_enquiry.value=val27;
	document.forms[0].txt_propertyvalue.value=val28;
	document.forms[0].txt_market.value=val29;

	if(document.forms[0].btnenable && document.forms[0].btnenable.value=="Y")
   	{
		enableButtons(true,false,true,true,true,true);
   	}
	
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			
		    enableButtons(true,false,true,true,true,true);
		}else{
			enableButtons(true,true,true,true,true,true);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,true);
	}
	else{
		
		 //If access through the Application wise
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,true);
		}else{
				if(document.forms[0].btnenable.value=="Y"){
					enableButtons(true,false,true,true,true,false);
					
				}else {
					
					enableButtons(true,true,true,true,true,false);
				}
		}
				
	}

	
	//End
	
}
</script>
</head>
<body 
	onload="onLoading()">
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
<form name="frminspection" method="post" class="normal">
<%if (strsaral.equalsIgnoreCase("saral")) {%> 
<lapschoice:saralreportTag tabid="4" sector="<%=strSector%>"
	applied="<%=strappliedfor%>" proposal="<%=strProposal%>" /> 
	<lapschoice:inward />
<%} else {
if (strloanType.equalsIgnoreCase("P")) { %> 

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence of Properties </td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<%} else {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="14" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
	<td class="page_flow">Home -&gt; Corporate &SME -&gt; Proposal -&gt; Credit / Inspection Report -&gt; Due Diligence -&gt; Due Diligence of Properties 
	</td>
	</tr>	
</table>
<lapschoice:application /> <span style="display: none"><lapschoice:borrowertype /></span>
<lapstab:ComReportTab tabid="5"
	applevel='<%=Helper.correctNull((String) request.getParameter("applevel"))%>'
	applied='<%=strappliedfor%>' /> <%
 	}
 	}
 %>
<table width="75%" border="0" cellspacing="1" cellpadding="5" class="outertable">
	<tr>
		<%
			String strother = "";
			if ((strSector.equalsIgnoreCase("Retail"))
					|| (strloanType.equalsIgnoreCase("P"))) {
				strother = " - Others";
		%>
		<td class="sub_tab_inactive" align="center" width="15%"> <a
			href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getDueDiligenceRetail','Duediligence1.jsp')"
			onMouseOut="window.status='';return true;">Due Diligence Report	- Salaried</a> </td>
		<%
			}
		%>
		<td class="sub_tab_inactive" align="center" width="15%"> <a
			href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')"
			onMouseOut="window.status='';return true;">Due Diligence Report
		<%=strother%></a> </td>
		<td class="sub_tab_active" align="center" width="15%"> Due Diligence of Properties </td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="28%">Date of Inspection<span class="mantatory">*</span></td>
		<td colspan="2"><input type="text" name="txt_inspect" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String) hshValues.get(""))%>"
			onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
			href="#" onClick="callCalender('txt_inspect')"
			title="Click to view calender"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0"></a></td>
	</tr>
	<tr>
		<td width="28%">Visited by<span class="mantatory">*</span></td>
		<td width="20%">Name</td>
		<td width="52%">Designation</td>
	</tr>
	<tr>
		<td width="28%">&nbsp;</td>
		<td width="20%"><input type="text" name="txt_name" size="35"
			maxlength="25"
			value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
		<td width="52%"><input type="text" name="txt_designation"
			size="35" maxlength="25"
			value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td width="28%">List of documents submitted<span class="mantatory">*</span></td>
				<td colspan="3"><textarea rows="4" name="txt_docs" cols="45"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</td>
			</tr>
			<tr>
				<td width="28%">Name of the owner of the property and full address with telephone no.</td>
				<td width="25%"><textarea rows="4" name="txt_address" cols="45"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</td>
				<td width="18%">Brief description of the property</td>
				<td width="29%"><textarea rows="4" name="txt_property"
					cols="45" onKeyPress="textlimit(this,3950)"
					onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td colspan="6">Location of the property </td>
			</tr>
			<tr>
				<td width="2%">a)</td>
				<td width="26%">Plot No. / Survery No.,<span class="mantatory">*</span></td>
				<td width="23%"><input type="text" name="txt_plot" size="35"`
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
				<td width="2%">b)</td>
				<td width="21%">Door No.</td>
				<td width="26%"><input type="text" name="txt_door" size="35"
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
			</tr>
			<tr>
				<td width="2%">c)</td>
				<td width="26%">T.S No. / Village ,</td>
				<td width="23%"><input type="text" name="txt_TSNo" size="35"
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get("visitname1"))%>">
				</td>
				<td width="2%">d)</td>
				<td width="21%">Ward / Taluka</td>
				<td width="26%"><input type="text" name="txt_ward" size="35"
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
			</tr>
			<tr>
				<td width="2%">e)</td>
				<td width="26%">Mandal / Disctrict</td>
				<td width="23%"><input type="text" name="txt_mandal" size="35"
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
				<td width="2%">f)</td>
				<td width="21%">Any Other</td>
				<td width="26%"><input type="text" name="txt_others" size="35"
					maxlength="25"
					value="<%=Helper.correctNull((String) hshValues.get(""))%>"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="29%">
				Whether residential / commercial or
				industrial / Agriculture<span class="mantatory">*</span>
				</td>
				<td width="23%">
				<div align="center"><textarea name="txt_residential" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%">
				</td>
				<td>
				Whether coming under Corporation limit
				village panchayat / Municipality
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_corporation" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td width="29%">
				Whether covered under any state / Cent.
				Govt. enactments or notified under agency area/ scheduled area /
				cantonment area.
				</td>
				<td width="23%">
				<div align="center"><textarea name="txt_state" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%">
				</td>
				<td >
				Size of the plot
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_plotsize" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td width="29%">
				Whether occupied by the owner or tenant
				</td>
				<td width="23%" align="center"><textarea name="txt_owners" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				
				</td>
				<td width="0%">				
				</td>
				<td width="17%">
				If occupied by tenant since how long and
				monthly rent
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_sincewhen" cols="35"
					onKeyUp="textlimit(this,350)" onKeyPress="textlimit(this,350)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
			</div>	
				</td>
			</tr>
			<tr>
				<td width="29%">
				Availability of Civic amenities like School
				,Hospital,Bus Stop,Marke
				</td>
				<td width="23%">
				<div align="center"><textarea name="txt_civic" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%">
				</td>
				<td >
				Boundaries of the property
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_boundaries" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td width="29%">
				Development of surrounding areas
				</td>
				<td width="23%">
				<div align="center"><textarea name="txt_surrounding" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%">
				</td>
				<td width="17%">
				Whether Non Agriculture Certificate is
				available
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_certificate" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td width="29%" height="41">
				In case a property belongs to third party,
				relationship of the borrower with the mortgager<span class="mantatory">*</span>
				</td>
				<td width="23%" height="41">
				<div align="center"><textarea name="txt_mortrelation"
					cols="35" onKeyUp="textlimit(this,3950)"
					onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%" height="41">
				</td>
				<td>
				Name of the persons with whom enquiry is
				made about the ownership of the property, position ,valuation and
				marketability and their views with their address,Telephone/Mobile
				No.etc.
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_enquiry" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td width="29%">
				Approx. value of the property
				</td>
				<td width="23%">
				<div align="center"><textarea name="txt_propertyvalue"
					cols="35" onKeyUp="textlimit(this,3950)"
					onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
				<td width="0%">
				</td>
				<td width="17%">
				Comments on the marketablity of the property<span class="mantatory">*</span>
				</td>
				<td width="31%">
				<div align="center"><textarea name="txt_market" cols="35"
					onKeyUp="textlimit(this,3950)" onKeyPress="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues.get(""))%></textarea>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="5">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr class="dataheader">
						<td width="4%"></td>
						<td width="15%" align="center" nowrap="nowrap">Date of Inspection </td>
						<td width="22%" align="center" nowrap="nowrap">Name of the Inspecting Officer</td>
						<td width="59%" align="center" nowrap="nowrap">Brief description of the property</td>
					</tr>
					<%if (arryRow.size() > 0) {
							for (int i = 0; i < arryRow.size(); i++) {
								arrCol = (ArrayList) arryRow.get(i);%>
					<tr class="datagrid">
						<td width="4%"><input type="radio" name="lopra"
							value="<%=arrCol.get(0)%>" style="border-style: NONE"
							onClick="selOption('<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(0))%>','<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(1))%>','<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(2))%>','<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(3))%>','<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(4))%>','<%=Helper.correctDoubleQuotesHtml((String) arrCol
									.get(5))%>','<%=Helper
											.correctDoubleQuotesHtml(Helper
													.replaceForJavaScriptString(Helper
															.correctNull((String) arrCol
																	.get(6))))%>','<%=Helper
											.correctDoubleQuotesHtml(Helper
													.replaceForJavaScriptString(Helper
															.correctNull((String) arrCol
																	.get(7))))%>','<%=Helper
											.correctDoubleQuotesHtml(Helper
													.replaceForJavaScriptString(Helper
															.correctNull((String) arrCol
																	.get(8))))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(9)))%>', '<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(10)))%>', '<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(11)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(12)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(13)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(14)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(15)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(16)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(17)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(18)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(19)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(20)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(21)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(22)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(23)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(24)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(25)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(26)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(27)))%>','<%=Helper.correctDoubleQuotesHtml(Helper
									.replaceForJavaScriptString((String) arrCol
											.get(28)))%>','<%//=Helper.correctNull((String)arrCol.get(29))%>')">
						</td>
						<td width="15%" align="center"><%=arrCol.get(3)%></td>
						<td width="22%">&nbsp; <%=arrCol.get(4)%></td>
						<td width="59%">&nbsp; <%=arrCol.get(8)%></td>
					</tr>
					<%}}%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="txt_appno" value="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<input type="hidden" name="hid_slno"> 
<input type="hidden" name="radLoan" value="Y">
</form>
</body>
</html>