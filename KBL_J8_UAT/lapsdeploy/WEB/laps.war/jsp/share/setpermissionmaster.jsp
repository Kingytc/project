<%@ include file="../share/directives.jsp"%>
<html>
<head>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");

	}
	int intarrSize1 = 0;
	if (arrRow != null) {
		intarrSize1 = arrRow.size();
	}
%>
<title>Permission Master</title>
<script LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var var_approval="<%=Helper.correctNull((String) hshValues.get("prd_approval"))%>";
var var_reject="<%=Helper.correctNull((String) hshValues.get("prd_reject"))%>";
var var_status="<%=Helper.correctNull((String) hshValues.get("PER_STATUS"))%>";
var var_interest="<%=Helper.correctNull((String) hshValues.get("PER_INTEREST"))%>";
var var_finance="<%=Helper.correctNull((String) hshValues.get("PER_FINANCE"))%>";

function loadPage(){

	disablefields(true);
	document.forms[0].prd_approval.value=var_approval;
	document.forms[0].prd_skip.value=var_reject;
	document.forms[0].sel_status.value=var_status;
	document.forms[0].sel_interest.value=var_interest;
	document.forms[0].sel_financial.value=var_finance;
	document.forms[0].prd_skip_value.style.visibility="hidden";
	document.forms[0].prd_skip_value.style.position="absolute";
	
	document.forms[0].sel_perType.disabled=false;
	document.forms[0].sel_classification.disabled=false;
	document.forms[0].txt_details.disabled=false;
	
}
function getValue()
{
	
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
	}
}
function showDetails(){
	 if(document.forms[0].cmdedit.disabled){

		
			var type=document.forms[0].sel_classification.value;
			
			var purl = "<%=ApplicationParams.getAppUrl()%>action/permissionmastersearch.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionMaster&secType="+type;		
			var title = "ListofPermissions";
			var prop = "scrollbars=no,width=600,height=400";	
			var xpos = (screen.width - 600) / 2;
			var ypos = (screen.height - 400) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,title,prop);
	 }
}
function callDisableControls(cmdNew,cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	//document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function doClose()
{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
}
function doCancel()
{
   		document.forms[0].hidBeanGetMethod.value="getPermissionMaster";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/setpermissionmaster.jsp";	
		document.forms[0].submit();
}

function doNew()
{	
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,true,false,true);
	disablefields(false);
}

function doEdit()
{  
    document.forms[0].hidAction.value="update";	
    callDisableControls(true,true,false,false,false,false);
    disablefields(false);
}

function doSave()
{
	
	if(document.forms[0].sel_perType.value=="0")
	{
		alert("Select Permission Type");
		return;
	}
	if(document.forms[0].sel_classification.value=="0")
	{
		alert("Select Permission  Classification");
		return;
	}
	if(document.forms[0].txt_details.value=="")
	{
		alert("Enter Name ");
		return;
	}
	if(document.forms[0].prd_approval.value==""){alert("Select Minimum Class for Approval ");return;}
	if(document.forms[0].prd_skip.value==""){alert("Select Minimum Class for Rejection ");return;}
	if(document.forms[0].sel_orgapp.value=="0"){alert("Select Minimum Organisation for Approval ");return;}
	if(document.forms[0].sel_orgrej.value=="0"){alert("Select Minimum Organisation for Rejection ");return;}
	if(document.forms[0].sel_termid.value==""){alert("Select Terms and Conditions ");return;}
	if(document.forms[0].sel_status.value==""){alert("Select Active Status ");return;}
	if(document.forms[0].sel_interest.value==""){alert("Select Whether Interest Concession tab Required?");return;}
	if(document.forms[0].sel_financial.value==""){alert("Select Whether Financial tab Required?");return;}
	
	disablefields(false);
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatePermissionMaster";
    document.forms[0].hidBeanGetMethod.value="getPermissionMaster";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setpermissionmaster.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		disablefields(false);
     	document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updatePermissionMaster";
	    document.forms[0].hidBeanGetMethod.value="getPermissionMaster";
		document.forms[0].hidSourceUrl.value="/action/setpermissionmaster.jsp";
		document.forms[0].submit();
	}
}
function callperType() {
	var varType = document.forms[0].sel_perType.options[document.forms[0].sel_perType.selectedIndex].value;
	document.all.iframepermission.src = appURL
			+ "action/iframepermission.jsp?hidBeanGetMethod=getPermissionClassification&hidBeanId=perDeviation&classificationtype="+ varType;
}
function showDescSkip(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_skip_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}

function showDescApp(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_app_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}
</script>
</head>
<body onLoad="loadPage()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Other Setup -&gt;
		Permission Master</td>
	</tr>
</table>
<br>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="10"
	align="center" class="outertable border1 tableBg">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" class="outertable">

			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr height="40px">
						<td colspan="3" class="dataheader" align="center"><b>Permission
						Master</b></td>
					</tr>
					<tr>
						<td colspan="3">
					</tr>
					<tr  height="40px">
						<td width="35%">Permission Type<b><span
							class="mantatory">*&nbsp;</span></b></td>

						<td width="65%"><select name="sel_perType" style="width: 300"
							onchange="callperType();">
							<option selected value="0">--Select--</option>
							<%
							String parentType="0";
							%>
							<lapschoice:PermPmayMaster  value='<%=parentType %>'/>
					</select></td>
					</tr>
					<tr  height="40px">
						<td width="35%">Permission Classification<b><span
							class="mantatory">*&nbsp;</span></b></td>

						<td width="65%"><select name="sel_classification"
							style="width: 300">
							<option selected value="0">--Select--</option>

						</select></td>
					</tr>
					<tr id="categ"  height="40px">
						<td width="35%" id="catlab">Name<b><span
							class="mantatory">*&nbsp;</span></b></td>

						<td width="65%"><input type="text" name="txt_details"
							size="75" style="width: 300" maxlength="75"
							onKeyPress="notAllowSplChar1(this);"> <b><span
							onClick="showDetails()" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					</tr>
					<tr  height="40px">
						<td width="35%">Active Status<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="65%"><select name="sel_status">
							<option value="">&lt;---Select---&gt;</option>
							<option value="E">Enable</option>
							<option value="D">Disable</option>
						</select></td>
					</tr>
					<tr  height="40px">
						<td width="35%">Minimum Class for Approval<b><span
							class="mantatory">*&nbsp;</span></b></td>

						<td width="65%"><input type="hidden" name="prd_approval1"
							size="12" maxlength="4" disabled onKeyPress="allowInteger()"
							style="text-align: right"> <select name="prd_approval"
							onChange="showDescApp(document.forms[0].prd_approval.value)">
							<option value="">&lt;---Select---&gt;</option>
							<lapschoice:usersclass />
						</select>&emsp;&emsp;
						<input type="text" name="prd_app_descr"
							size="33" maxlength="4" style="text-align: left" readonly="readonly"
							onmouseover="showDescApp(document.forms[0].prd_approval.value)">
						</td>
					</tr>
					<tr  height="40px">
						<td width="35%">Minimum Organisation for Approval<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="65%"><select name="sel_orgapp">
							<option value="0">&lt;---Select---&gt;</option>
							<option value="C">HeadOffice</option>
							<option value="R">RegionalOffice</option>
							<option value="D">CLPU</option>
							<option value="A">Branch</option>
						</select></td>
					</tr>
					<tr  height="40px">
						<td width="35%">Minimum Class for Rejection<b><span
							class="mantatory">*&nbsp;</span></b></td>

						<td width="65%"><input type="hidden" name="prd_skip1"
							size="12" maxlength="4" disabled onKeyPress="allowInteger()"
							style="text-align: right"> <select name="prd_skip"
							onChange=showDescSkip(document.forms[0].prd_skip.value)>
							<option value="">&lt;---Select---&gt;</option>
							<lapschoice:usersclass />
						</select>&emsp;&emsp;
						<input type="text" name="prd_skip_descr"
							size="33" maxlength="4" style="text-align: left"
							onmouseover="showDescSkip(document.forms[0].prd_skip.value)">

						</td>
					</tr>
					<tr  height="40px">
						<td width="35%">Minimum Organisation for Rejection<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="65%"><select name="sel_orgrej">
							<option value="0">&lt;---Select---&gt;</option>
							<option value="C">HeadOffice</option>
							<option value="R">RegionalOffice</option>
							<option value="D">CLPU</option>
							<option value="A">Branch</option>
						</select></td>
					</tr>
					<tr  height="40px">
						<td>Select Terms and Conditions&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="sel_termid" tabindex="18" style="width: 300">
							<option value="" selected="selected">---- Select ----</option>
							<lapschoice:prodtermcond />
						</select></td>
					</tr>
							<tr  height="40px">
						<td width="35%">Whether Interest Concession tab Required?<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="65%"><select name="sel_interest">
							<option value="">&lt;---Select---&gt;</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
							<tr  height="40px">
						<td width="35%">Whether Financial tab Required? <b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="65%"><select name="sel_financial">
							<option value="">&lt;---Select---&gt;</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="3"><select name="prd_skip_value"
							style="width: 100">
							<option value="">&lt;---Select---&gt;</option>
							<lapschoice:usersclassdesc />
						</select></td>
					</tr>

				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>

<lapschoice:combuttonnew
	btnnames='New_Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid="<%=PageId%>" /> <input type="hidden"
	name="hidsno" value=""> <input type="hidden" name="hidinstype"
	value=""> <iframe height="0" width="0" id="iframepermission"
	frameborder=0 style="border: 0"></iframe></form>
</body>
</html>