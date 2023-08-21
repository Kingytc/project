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
			String statusflag = "";
			String strBtnenable="";
			String Months[] = { "", "January", "February", "March", "April",
					"May", "June", "July", "August", "September", "October",
					"November", "December" };
			strcbsid = Helper.correctNull((String) hshValues.get("postins_cbsid"));
			cbsname = Helper.correctNull((String) request.getParameter("cbsname"));
			month = Helper.correctNull((String) hshValues.get("postins_month"));
			postins_no = Helper.correctNull((String) hshValues.get("postins_no"));
			type = Helper.correctNull((String) hshValues.get("postins_type"));
			year = Helper.correctNull((String) hshValues.get("postins_year"));
			statusflag = Helper.correctNull((String) hshValues.get("postins_status"));
			strBtnenable=Helper.correctNull((String) hshValues.get("btnenable"));
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
var insbanknameboard="<%=Helper.correctNull((String)hshValues.get("banknameboard"))%>";
var insborrowernamebord="<%=Helper.correctNull((String)hshValues.get("borrnameboard"))%>";
var insmaintanance="<%=Helper.correctNull((String)hshValues.get("bookmaintanance"))%>";

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
	if(insbanknameboard!=="")
	{
	  document.forms[0].sel_banknameboard.value=insbanknameboard;	
	}
	else
	{
		document.forms[0].sel_banknameboard.value='0'
	}
	if(insborrowernamebord!=="")
	{
	  document.forms[0].sel_borrowernamebord.value=insborrowernamebord;	
	}
	else
	{
		document.forms[0].sel_borrowernamebord.value='0'
	}
	if(insmaintanance!=="")
	{
	  document.forms[0].sel_maintanance.value=insmaintanance;	
	}
	else
	{
		document.forms[0].sel_maintanance.value='0'
	}
	
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
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatePostInspectionReport";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidSourceUrl.value="action/mon_inspectionreport.jsp";	
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
		document.forms[0].action=appURL +"action/mon_inspectionreport.jsp";
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
	if(trim(document.forms[0].txt_primarysecurity.value)=="")
	{
		ShowAlert('121','Observations / Comments of Inspecting officer on Primary Security');
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
	document.forms[0].action=appURL+"action/mon_inspectionreport.jsp";
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
		
			document.forms[0].elements[i].disabled=val;			
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
	var hidpostins_no = document.forms[0].hidpostins_no.value;
	var cbsid = document.forms[0].cbsid.value;
	var purl = appURL+"action/followupInspectionPrint_Corporate.jsp?hidBeanGetMethod=getPostInspectionPrint&hidBeanId=postinspection&hidpostins_no="+hidpostins_no+"&cbsid="+cbsid;
	prop = "scrollbars=yes,width=700,height=450,statusbar=no,menubar=yes,location=no,toolbar=no";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print";
	window.open(purl,title,prop);
}
</script>
</head>
<body onload="onLoading()">
<form name="frminspection" method="post" class="normal">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr>
			
						<td align="center" class="sub_tab_active">Inspection Report</td>
						<td align="center" class="sub_tab_inactive">
						<a href="JavaScript:callLink('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"><b>Facility Enjoyed</b></a></td>
						<td align="center" class="sub_tab_inactive">
						<a href="JavaScript:callLink('postinspection_annexure.jsp','postinspection','getPostInspectionAnnexure')"><b>Facility Annexure</b></a></td>						
						<td align="center" class="sub_tab_inactive">
						<a href="JavaScript:callLink('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Inspection</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td width="12%"><b> CBS ID: </b></td>
		<td width="15%"><%=strcbsid%>  
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">&nbsp; </td>
		<td width="12%"><b> Borrower Name: </b></td>
		<td width="20%"><%=Helper.decodeAmpersand(cbsname)%>
		<input type="hidden" name="cbsname" value="<%=cbsname%>">&nbsp; </td>
		<td width="12%"><b>Month:</b></td>
		<td width="8%"><%=month%> 
		<input type="hidden" name="month" value="<%=month%>">&nbsp;  </td>
		<td width="4%"><b> Year:</b></td>
		<td width="6%"> <%=year%>  
		<input type="hidden" name="year" readonly value="<%=year%>">&nbsp; </td>
	
	</tr>
	<tr class="applicationheader">
		<td><b>Inspection Number</b></td>
		<td> <%=postins_no%> 
			<input type="hidden" name="hidpostins_no" value="<%=postins_no%>">&nbsp; </td>
		<td><b>App. Recd. from</b></td>
		<td> <%=strAppOrgName%>  <input
			type="hidden" name="apporgname" value="<%=strAppOrgName%>">&nbsp; </td>
		<td><b>Application Holder</b></td>
		<td><%=strAppHolder%>  <input
			type="hidden" name="appholder" value="<%=strAppHolder%>">&nbsp; </td>
		<td><b>Status:</b></td>
		<td><%=(statusflag.equals("P")?"Pending":"Closed")%>
		<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
		<input type="hidden" name="statusflag" value="<%=statusflag%>">
		<input type="hidden" name="type" value="<%=type%>">
		<input type="hidden" name="btnenable" value="<%=strBtnenable%>"></td>

	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td colspan="4"><b>Inspection</b></td>
		<tr>
		<td>Date of visit<span class="mantatory">*</span></td>
		<td colspan="3"><input type="text" name="txt_dateinspec" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>"
			onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a href="#"
			onClick="callCalender('txt_dateinspec')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2"
			width="0" border="0"></a></td>
	</tr>
	<tr>
		<td width="20%">Visited by</td>
		<td width="13%">Name</td>
		<td width="27%">Designation</td>
	</tr>
	<tr>
		<td width="20%">&nbsp;</td>
		<td width="13%"><input type="text" name="txt_officialname1" size="35"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_official1"))%>">
		</td>
		<td width="27%"><input type="text" name="txt_officialdesig1" size="35"
			maxlength="25" tabindex="3"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig1"))%>">
		</td>
	</tr>
	<tr>
		<td width="20%">&nbsp;</td>
		<td width="13%"><input type="text" name="txt_officialname2" size="35"
			maxlength="25" tabindex="4"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_official2"))%>">
		</td>
		<td width="27%"><input type="text" name="txt_officialdesig2" size="35"
			maxlength="25" tabindex="5"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig2"))%>">
		</td>
	</tr>
	<tr>
		<td width="20%">&nbsp;</td>
		<td width="13%"><input type="text" name="txt_officialname3" size="35"
			maxlength="25" tabindex="6"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_official3"))%>">
		</td>
		<td width="27%"><input type="text" name="txt_officialdesig3" size="35"
			maxlength="25" tabindex="7"
			value="<%=Helper.correctNull((String)hshValues.get("inspec_officialdesig3"))%>">
		</td>
	</tr>
	<tr>
		<td>Due for review</td>
		<td><input type="text" name="txt_reviewdue" size="20"
			maxlength="15" tabindex="6"
			value="<%=Helper.correctNull((String)hshValues.get("reviewdue"))%>"></td>
		<td></td>
		
	</tr>
	<tr>
		<td colspan="3">Nearby LandMark for identification</td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td width="15%">North</td>
				<td width="32%"><textarea rows="4" name="txt_north" cols="55"
					tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("landmarknorth"))%></textarea></td>
				<td width="18%">East</td>
				<td width="35%"><textarea rows="4" name="txt_east" cols="55"
					tabindex="9" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("landmarkeast"))%></textarea></td>
			</tr>
			<tr>
				<td width="15%">West</td>
				<td width="32%"><textarea rows="4" name="txt_west" cols="55"
					tabindex="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("landmarkwest"))%></textarea></td>
				<td width="18%">South</td>
				<td width="35%"><textarea rows="4" name="txt_south" cols="55"
					tabindex="11" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("landmarksouth"))%></textarea></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td width="15%">Observations / Comments of Inspecting officer:</td>
				<td width="32%">&nbsp;</td>
			</tr>
			<tr>
				<td width="15%">Primary Security: <span class="mantatory">*</span></td>
				<td width="32%"><textarea rows="4" name="txt_primarysecurity"
					cols="55" tabindex="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("primesecurity"))%></textarea>
				<td width="19%">Collateral Security:</td>
				<td width="34%"><textarea rows="4" name="txt_collsecurity" cols="55"
					tabindex="13" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("collateralsecurity"))%></textarea></td>
			</tr>
			<tr>
				<td width="15%">Present status of business activity <br>
				of borrower:</td>
				<td width="32%"><textarea rows="4" name="txt_presentstatus"
					cols="55" tabindex="14" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("presentstatus"))%></textarea></td>
				<td width="19%">Comments on operations in the account:</td>
				<td width="34%"><textarea rows="4" name="txt_accntoperations"
					cols="55" tabindex="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("operations"))%></textarea></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td width="15%">Whether Bank&#146;s name board is displayed:</td>
				<td width="32%"><select name="sel_banknameboard" tabindex="16">
					<option value="0">--select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select></td>
			</tr>
			<tr>
				<td width="15%">Whether borrower&#146;s name board is displayed:</td>
				<td width="32%"><select name="sel_borrowernamebord" tabindex="17">
					<option value="0">--select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select></td>
			</tr>
			<tr>
				<td width="15%">Proper maintenance of books of accounts:</td>
				<td width="32%"><select name="sel_maintanance" tabindex="18">
					<option value="0">--select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				</select></td>
			</tr>
			<tr>
				<td width="15%">Documentation and its validity:</td>
				<td width="32%"><textarea rows="4" name="txt_document" cols="55"
					tabindex="19" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("documentvalidity"))%></textarea></td>
				<td width="19%">Any other features observed during visit:</td>
				<td width="34%"><textarea rows="4" name="txtarea_features" cols="55"
					tabindex="20" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("shortfall"))%></textarea></td>
			</tr>
			<tr>
				<td width="5%"><strong>Place:</strong></td>
				<td width="26%"><input type="text" name="txt_place"
					size="40" maxlength="50" tabindex="10"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("from_place"))%>">
				</td>
				<td align="right" colspan="2"><strong>Name:</strong></td>
				<td width="39%"><input type="text" name="txt_name"
					size="40" maxlength="50" tabindex="10"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String)hshValues.get("user_name"))%>">
				</td>
			</tr>
			<tr>
				<td width="5%"><strong> Date:</strong></td>
				<td width="26%">
				<table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable">
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
				<td align="right" colspan="2"><strong>Designation:</strong>
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
<input type="hidden" name="hidvalue" value="<%=Helper.correctNull((String)hshValues.get("inspec_date"))%>"> 
<input type="hidden" name="hidreviewtype" value="<%=strReviewtype%>" />
</form>
</body>
</html>

