<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String strReviewtype = Helper.correctNull((String) request.getParameter("hidreviewtype"));
			String strcbsid = "";
			String cbsname = "";
			String month = "";
			String postins_no = "";
			String type = "";
			String year = "";
			String strBtnenable="";
			String statusflag = "";
			String Months[] = { "", "January", "February", "March", "April",
					"May", "June", "July", "August", "September", "October",
					"November", "December" };
			strcbsid = Helper.correctNull((String) hshValues.get("postins_cbsid"));
			cbsname = Helper.correctNull((String) request.getParameter("cbsname"));
			month = Helper.correctNull((String) hshValues.get("postins_month"));
			postins_no = Helper.correctNull((String) hshValues.get("postins_no"));
			type = Helper.correctNull((String) hshValues.get("postins_type"));
			year = Helper.correctNull((String) hshValues.get("postins_year"));
			strBtnenable=Helper.correctNull((String) hshValues.get("btnenable"));
			statusflag = Helper.correctNull((String) hshValues.get("postins_status"));
			if (statusflag.equalsIgnoreCase("")) {
				statusflag = "P";
			}
			if (strcbsid.equalsIgnoreCase("")) {
				strcbsid = Helper.correctNull((String) request.getParameter("cbsid"));
			}
			if (type.equalsIgnoreCase("")) {
				type = Helper.correctNull((String) request.getParameter("type"));
			}
			if (!month.equals("")) {
				int mon = Integer.parseInt(month);
				month = Months[mon];
			}
			ArrayList gridData = (ArrayList) hshValues.get("arrRow");
			String strAppOrgName = Helper.correctNull((String)hshValues.get("org_name"));
			String strAppHolder = Helper.correctNull((String)hshValues.get("postins_holder"));%>
<html>
<head>
<title>Post Inspection Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script><!--
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function callCalender(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{	
		showCal(appURL,name);
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}
function onLoading()
{
	if(document.forms[0].hidpostins_no.value == "")
	{
		disableCommandButtons(true,false,true,true,false); 	
		disableFields(false);
	}
	else if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(false,true,true,true,false);
		disableFields(true);
	}
	else
	{
		disableCommandButtons(true,true,true,true,false);
		disableFields(true);
	}
}

function disableCommandButtons(valedit,valsave,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;	
}


function doDelete()
{
	if(ConfirmMsg(101))
	{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updatePostInspectionReport";
			document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
			document.forms[0].hidBeanId.value="postinspection";
			document.forms[0].hidSourceUrl.value="action/post_monthlyinspection.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
	}
}

function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
    document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,false,true);	
}


function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
		document.forms[0].action=appURL+"action/postinspection_retail_report.jsp";
	    document.forms[0].submit();	
	}	
}

function doSave()
{
	if(document.forms[0].txt_dateinspec.value=="")
	{
		ShowAlert('121','Date of Inspection');
		return;
	}
	if(document.forms[0].txt_officialname1.value=="" ) 
	{
		alert("Enter atleast one official name");
		document.forms[0].txt_officialname1.focus();
		return;
	}
	if(document.forms[0].txt_officialdesig1.value=="")
	{
		alert("Enter atleast one official designation");
		document.forms[0].txt_officialdesig1.focus();	
		return;
		
	}
	if(document.forms[0].hidpostins_no.value == "")
    {
	    <%
        if(gridData != null && gridData.size() >0)
        {
        	for(int i=0;i<=gridData.size()-1;i++)
        	{ 
           		ArrayList data=(ArrayList)gridData.get(i);  
        %>
        		var val= document.forms[0].txt_dateinspec.value;
        		var date = val.substring(0,2);
        		var month =val.substring(3,5);
           		var year = val.substring(6,10);
           		if("<%=data.get(0)%>" == month && "<%=data.get(1)%>" == year && "<%=data.get(2)%>" == date)
           		{
	           		alert("Duplicate !!! - Already details is Entered");
           			return;
           		}
        <%}}%>
	}
    if(document.forms[0].hidpostins_no.value != "" && document.forms[0].hidvalue.value != "")
    {
    	var val= document.forms[0].txt_dateinspec.value;
    	var date =val.substring(0,2);
       	var month =val.substring(3,5);
        var year = val.substring(6,10);
        
        var val1= document.forms[0].hidvalue.value;
        var date1 =val1.substring(0,2);
        var month1 =val1.substring(3,5);
        var year1 = val1.substring(6,10);
        	
	    if(month!=month1 || year!=year1 || date!=date1)
       {
            
        	<%
        	if(gridData != null && gridData.size() >0)
        	{
        		for(int i=0;i<=gridData.size()-1;i++)
        		{ 
	           		ArrayList data=(ArrayList)gridData.get(i);  %>
           			var val= document.forms[0].txt_dateinspec.value;
           		   var date = val.substring(0,2);
           		   var month =val.substring(3,5);
		           var year = val.substring(6,10);
		           if("<%=data.get(0)%>" == month && "<%=data.get(1)%>" == year && "<%=data.get(2)%>" == date)
	    	       {
		           		alert("Duplicate !!! - Already details is Entered");
	           			return;
	           		}
	        <%}}%>
        }
	}
	document.forms[0].hidBeanId.value="postinspection";
	document.forms[0].hidBeanGetMethod.value="updatePostInspectionReport";
	document.forms[0].action=appURL+"action/postinspection_retail_report.jsp"; 
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
			document.forms[0].elements[i].readOnly=val;
		}		 
	}	
}
function callLink1(page,bean,method)
{	if(document.forms[0].cmdsave.disabled!=false)
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
//function oldvalue(obj)
//{	
//	if(document.forms[0].txt_dateinspec.value !="")
//	{
//		document.forms[0].hidvalue.value=document.forms[0].txt_dateinspec.value;
//	}	
//}
function doPrint()
{		
	var hidpostins_no = document.forms[0].hidpostins_no.value;
	var cbsid = document.forms[0].cbsid.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/postinspection_print.jsp?hidBeanGetMethod=getPostInspectionPrint&hidBeanId=postinspection&hidpostins_no="+hidpostins_no+"&cbsid="+cbsid;
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);	
}
</script>
</head>
<body onload="onLoading()">
<form name="postreport" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr>
						<td align="center" class="sub_tab_active">Inspection Report</td>
						<td align="center" class="sub_tab_inactive"><b><a href="JavaScript:callLink1('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')">Facility Enjoyed</a></b></td>
						<td align="center" class="sub_tab_inactive"><a href="JavaScript:callLink1('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Post / Followup Inspection -&gt; Inspection Report</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td width="12%"><b> CBS ID</b></td>
		<td width="15%"><%=strcbsid%>  
		<input type="hidden" name="cbsid" value="<%=strcbsid%>"></td>
		<td width="12%"><b> Borrower Name</b></td>
		<td width="20%"><%=Helper.decodeAmpersand(cbsname)%>
		<input type="hidden" name="cbsname" value="<%=cbsname%>"></td>
		<td width="12%"><b>Month:</b></td>
		<td width="8%"><%=month%>  
		<input type="hidden" name="month" value="<%=month%>">&nbsp; </td>
		<td width="4%"><b> Year</b></td>
		<td width="6%"> <%=year%>  
		<input type="hidden" name="year" readonly value="<%=year%>">&nbsp; </td>
	</tr>
	<tr class="applicationheader">
		<td><b>Inspection Number</b></td>
		<td> <%=postins_no%>  
		<input type="hidden" name="hidpostins_no" value="<%=postins_no%>">&nbsp; </td>
		<td><b>App. Recd. from</b></td>
		<td> <%=strAppOrgName%>  
		<input type="hidden" name="apporgname" value="<%=strAppOrgName%>">&nbsp; </td>
		<td><b>Application Holder</b></td>
		<td><%=strAppHolder%>  
		<input type="hidden" name="appholder" value="<%=strAppHolder%>">&nbsp; </td>
		<td><b>Status</b></td>
		<td><%=(statusflag.equals("P")?"Pending":"Closed")%>
		<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
		<input type="hidden" name="statusflag" value="<%=statusflag%>"> 
		<input type="hidden" name="type" value="<%=type%>"> 
		<input type="hidden" name="btnenable" value="<%=strBtnenable%>"></td>
	</tr>
</table>
<br>
<table border="0" width="99%" cellspacing="0" align="center" cellpadding="0" class="outertable border1">
		<tr align="center">
		<td width="95%">
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="outertable" align="center">
		<tr align="center">
		<td valign="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td>Date of Inspection<span class="mantatory">*&nbsp;</span></td>
				<td width="25%">
				<table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="31%"><input type="text" name="txt_dateinspec" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);"
							maxlength="12"></td>
						<td width="69%"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_dateinspec')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender" tabindex="1"></a></td>
					</tr>
				</table>
				</td>
				<td width="29%">Date of Previous Inspection</td>
				<td width="27%">
				<table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="31%"><input type="text" name="txt_previousdate"
							size="11"
							value="<%=Helper.correctNull((String)hshValues.get("previous_inspecdate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							maxlength="12"></td>
						<td width="69%"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_previousdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender" tabindex="2"></a></td>
					</tr>
				</table>
				</td>
				</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="5">
		<table border="0" width="100%" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr align="center">
				<td colspan="2"><b>Name of Inspecting Officials</b></td>
			</tr>
			<tr align="center">
				<td width="50%">Name</td>
				<td width="50%">Designation</td>
			</tr>
			<tr align="center">
				<td width="50%">1 <input type="text"
					name="txt_officialname1" size="40" maxlength="50" tabindex="2"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_official1"))%>">
				</td>
				<td width="50%"><input type="text" name="txt_officialdesig1"
					size="40" maxlength="50" tabindex="3"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig1"))%>">
				</td>
			</tr>
			<tr align="center">
				<td width="50%">2 <input type="text"
					name="txt_officialname2" size="40" maxlength="50" tabindex="4"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_official2"))%>">
				</td>
				<td width="50%"><input type="text" name="txt_officialdesig2"
					size="40" maxlength="50" tabindex="5"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig2"))%>">
				</td>
			</tr>
			<tr align="center">
				<td width="50%">3 <input type="text"
					name="txt_officialname3" size="40" maxlength="50" tabindex="6"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_official3"))%>">
				</td>
				<td width="50%"><input type="text" name="txt_officialdesig3"
					size="40" maxlength="50" tabindex="7"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig3"))%>">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" >Observation of Inspecting
		Officials<br>
		 <textarea rows="30" name="txtarea_officialobser" cols="46"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("official_observation"))%></textarea></td>
		<td width="39%" >
		<ul>
			<li class="mantatory">(*accourding to selection of scheme
			)<br>
			Union Home: (Please Mark the applicable)<br>
			New House/Flat/Construction of
			the House/repairs of the House<br>
			Work in progress/Completed<br>
			Whether occupied by self/let out<br>
			If Let Out<br>
			Name of Tenant<br>
			Monthly Rent Amount <br>
			</li>
			<li class="mantatory">Union Miles<br>
			Type of Vehicle<br>
			Year of Purchase<br>
			R.T.O lien marked or Not(To be verified from Registration Book)<br>
			Present Condition of Vechile<br>
			Insurance Details</li>
			<li class="mantatory">Any Other Loans(Please Mark the
			applicable)<br>
			Observations<br>
			Union Mortgage<br>
			Union Education<br>
			Union Health<br>
			Any Other Loans <br>
			<br>
			</li>
		</ul>
		</td>
	</tr>
	<tr>
		<td>Any adverse features observed during visit:</td>
		<td colspan="5"> <textarea rows="3" name="txtarea_features" cols="83"
			wrap="VIRTUAL" onKeyPress="textlimit(this,3999)"
			onKeyUp="textlimit(this,3999)" tabindex="9"><%=Helper.correctNull((String) hshValues.get("shortfall"))%></textarea></td>
	</tr>
	<tr>
		<td  width="5%">Place:</td>
		<td  width="26%"><input type="text" name="txt_place"
			size="40" maxlength="50" tabindex="10" onKeyPress="notAllowSplChar()"
			value="<%=Helper.correctNull((String)hshValues.get("from_place"))%>">
		</td>
		<td  align="right" colspan="2">Name:</td>
		<td  width="39%"><input type="text" name="txt_name"
			size="40" maxlength="50" tabindex="10" onKeyPress="notAllowSplChar()"
			value="<%=Helper.correctNull((String)hshValues.get("user_name"))%>">
		</td>
	</tr>
	<tr>
		<td width="5%"> Date:</td>
		<td width="26%">
		<table border="0" width="100%" cellspacing="0" cellpadding="3">
			<tr>
				<td width="34%"><input type="text" name="txt_date" size="11"
					value="<%=Helper.correctNull((String)hshValues.get("filled_date"))%>"
					onBlur="checkDate(this);checkmaxdate(this,currentDate)"
					maxlength="12"></td>
				<td width="66%"><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="11"></a></td>
			</tr>
		</table>
		</td>
		<td  align="right" colspan="2">Designation:
		</td>
		<td width="39%"><input type="text" name="txt_desig" size="40"
			maxlength="50" tabindex="10" onKeyPress="notAllowSplChar()"
			value="<%=Helper.correctNull((String)hshValues.get("user_desig"))%>">
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidreviewtype" value="<%=strReviewtype%>" /> 
<input type="hidden" name="hidvalue" value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>">
</form>
</body>
<script language="javascript1.2">
editor_generate('txtarea_officialobser');
</script>
</html>
