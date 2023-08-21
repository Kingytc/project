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
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function disableCommandButtons(valedit,valsave,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;	
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
	if(document.forms[0].hidpostins_no.value == "")
	{
		disableCommandButtons(true,false,true,true,false); 	
		disableFields(false);
	}
	else if(document.forms[0].statusflag.value=="P")
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
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatePostInspectionReport";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidSourceUrl.value="action/followupInspectionReport.jsp";	
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
		document.forms[0].action=appURL +"action/followupInspectionReport.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
	if(trim(document.forms[0].txt_dateinspec.value)=="")
	{
		ShowAlert('121','Inspection Date');
		return;
	}
	if(trim(document.forms[0].txt_officialname1.value)=="")
	{
		ShowAlert('121','Inspecting Official Name');
		return;
	}
	if(trim(document.forms[0].txtarea_officialobser.value)=="")
	{
		ShowAlert('121','Inspecting Official Observations');
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
	document.forms[0].action=appURL+"action/followupInspectionReport.jsp";
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
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();		
	}
}
function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled!=false)
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
</script>
</head>
<body onload="onLoading()">
<form name="frminspection" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_active">Inspection Report</td>
						<td align="center" class="sub_tab_inactive"><b> <a
							href="JavaScript:callLink1('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"
							>Facility Enjoyed</a> </b></td>
						<td align="center" class="sub_tab_inactive"><a
							href="JavaScript:callLink1('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Post/Follow Up
		Inspection -&gt; Inspection Report -&gt; Follow-up Inspection Report</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td><b>CBS ID</b></td>
		<td><%=strcbsid%>
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">
		</td>
		<td><b> Borrower Name</b></td>
		<td><%=Helper.decodeAmpersand(cbsname)%>
		<input type="hidden" name="cbsname" value="<%=cbsname%>"></td>
		<td><b>Month</b></td>
		<td><%=month%>
		<input type="hidden" name="month" value="<%=month%>">&nbsp; </td>
		<td><b>Year</b></td>
		<td> <%=year%> 
		<input type="hidden" name="year" readonly value="<%=year%>">&nbsp; </td>
		
	</tr>
		<tr class="applicationheader">
		<td><b>Inspection Number</b></td>
		<td> <%=postins_no%><input type="hidden" name="hidpostins_no" value="<%=postins_no%>">&nbsp; </td>
		<td><b>App. Recd. from</b></td>
		<td> <%=strAppOrgName%> <input type="hidden" name="apporgname" value="<%=strAppOrgName%>">&nbsp; </td>
		<td><b>Application Holder</b></td>
		<td><%=strAppHolder%> <input type="hidden" name="appholder" value="<%=strAppHolder%>">&nbsp;</td>
		<td align="center"><b>Status</b></td>
		<td><%=(statusflag.equals("P")?"Pending":"Closed")%>
		<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
		<input type="hidden" name="statusflag" value="<%=statusflag%>">
		<input type="hidden" name="type" value="<%=type%>">
		<input type="hidden" name="btnenable" value="<%=strBtnenable%>"></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr>
						<td class="sub_tab_active" align="center">Follow-up Inspection Report</td>
						<td class="sub_tab_inactive" align="center"><b> 
						<a href="javascript:callLink1('standingCrops.jsp','monitoringletters','getStandingCrops')">Standing Crops</a></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable border1">
	<tr>
	<td>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
	<tr>
		<td width="20%">Date of present inspection<span class="mantatory">*</span></td>
		<td width="30%" >
		<table border="0" cellspacing="1" cellpadding="2" class="outertable">
			<tr>
				<td>
				<input type="hidden" name="hidvalue" value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>">
				<input type="text" name="txt_dateinspec" size="15" maxlength="25" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
					value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>">
				</td>
				<td><a href="#" onClick="callCalender('txt_dateinspec')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2"
					width="0" border="0"></a></td>
			</tr>
		</table>
		</td>
		<td width="20%">Name of Inspection official<span class="mantatory">*</span></td>
		<td width="30%"><input type="text" name="txt_officialname1"
			tabindex="1" maxlength="25" size="25"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_official1"))%>">
		</td>
	</tr>
	<tr>
		<td>Date of previous inspection</td>
		<td >
		<table border="0" cellspacing="1" cellpadding="2" class="outertable">
			<tr>
				<td><input type="text" name="txt_previousdate" size="15"
					maxlength="25"
					onBlur="checkDate(this);checkmaxdate(this,currentDate)"
					value="<%=Helper.correctNull((String)hshValues.get("previous_inspecdate"))%>">
				</td>
				<td><a href="#" onClick="callCalender('txt_previousdate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2"
					width="0" border="0"></a></td>
			</tr>
		</table>
		</td>
		<td>Name of Inspection offical</td>
		<td><input type="text" name="txt_officialname2"
			tabindex="1" maxlength="25" size="25"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_official2"))%>">
		</td>
	</tr>
	<tr>
		<td colspan="2">Has the amount been utilised for the purpose/s for
		which it was advanced? If not, mention the deviations.<span class="mantatory">*</span></td>
		<td colspan="2"><textarea rows="4" name="txtarea_officialobser"
			cols="100" tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("official_observation"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">In case of loan for development purposes like
		reclamation, levelling and bunding of land, laying of pipelines,
		construction of storage tank etc., mention whether the required work
		has been carried out in full and whether the outlay incurred is
		realistic and keeping with the estimates</td>
		<td colspan="2"><textarea rows="4" name="text_development" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("development"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">In case of loan for sinking of, or repairs to, well,
		verify and give particulars of the work done, with your comments on
		the availability of adequate water etc.</td>
		<td colspan="2"><textarea rows="4" name="text_sinking" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("sinking"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">In case of loan for purpose of machinery like
		tractors, pumpsets etc. verify the make, H.P., etc. and state whether
		it is same as given in the application. State whether the machinery is
		recently purchased and is in working condition.</td>
		<td colspan="2"><textarea rows="4" name="text_purpose" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("machinery"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">In case of loans for seasonal operations, check up
		whether the crops and acreage under various crops tally with the
		cropping pattern for which we have sanctioned crop loan. Give comments</td>
		<td colspan="2"><textarea rows="4" name="text_seasonal" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("seasonalcrops"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">If the borrower has availed of only medium term loan
		from us, mention the arrangements he has made to meet the cultivation
		expenses.</td>
		<td colspan="2"><textarea rows="4" name="text_availed" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("mediumtermloan"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">Give comments on any other aspect observed during the
		inspection:</td>
		<td colspan="2"><textarea rows="4" name="txtarea_features" cols="100"
			tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("shortfall"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td>Place :</td>
		<td ><input type="text" name="txt_place" tabindex="1"
			maxlength="25" size="25"
			value="<%=Helper.correctNull((String)hshValues.get("from_place"))%>">
		</td>
		<td>Name:</td>
		<td><input type="text" name="txt_name" tabindex="1"
			maxlength="25" size="25"
			value="<%=Helper.correctNull((String)hshValues.get("user_name"))%>">
		</td>
	</tr>
	<tr>
		<td>Date :</td>
		<td>
		<table border="0" cellspacing="1" cellpadding="2" class="outertable">
			<tr>
				<td><input type="text" name="txt_date" size="15" maxlength="25"
					onBlur="checkDate(this);checkmaxdate(this,currentDate)"
					value="<%=Helper.correctNull((String)hshValues.get("filled_date"))%>">
				</td>
				<td><a href="#" onClick="callCalender('txt_date')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2"
					width="0" border="0"></a></td>
			</tr>
		</table>
		</td>
		<td>Designation:</td>
		<td><input type="text" name="txt_desig" tabindex="1"
			maxlength="25" size="25"
			value="<%=Helper.correctNull((String)hshValues.get("user_desig"))%>">
		</td>
	</tr>

</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidreviewtype" value="<%=strReviewtype%>" />
</form>
</body>
</html>

