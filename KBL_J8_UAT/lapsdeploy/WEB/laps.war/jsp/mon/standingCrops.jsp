<%@include file="../share/directives.jsp"%>
<%	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strReviewtype = Helper.correctNull((String) request.getParameter("hidreviewtype"));%>

<html>
<head>
<title>Consortium</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";

function doNew()
{
	disableCommandButtons(true,true,true,false,false,true);
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	
	document.forms[0].txt_crop.value="";
	document.forms[0].txt_acerage.value="";
	document.forms[0].txt_condition.value="";	
}

function doEdit()
{ 
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,true,false,false,true);
	disableFields(false);
}
function doSave()
{
if(document.forms[0].txt_crop.value=="")
	{
		alert("Enter name of the crop");
	}
else
	{
		document.forms[0].hidBeanId.value="monitoringletters";
		document.forms[0].hidSourceUrl.value="/action/standingCrops.jsp";
		document.forms[0].hidBeanMethod.value="updateStandingCrops";
		document.forms[0].hidBeanGetMethod.value="getStandingCrops";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getStandingCrops";
		document.forms[0].hidBeanId.value="monitoringletters";
		document.forms[0].action=appURL+"action/standingCrops.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="monitoringletters";
	document.forms[0].hidSourceUrl.value="/action/standingCrops.jsp";
	document.forms[0].hidBeanMethod.value="updateStandingCrops";
	document.forms[0].hidBeanGetMethod.value="getStandingCrops";	
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}

function selectValues(val1,val2, val3, val4)
{
 
	document.forms[0].txt_crop.value =val2;
	document.forms[0].txt_acerage.value=val3;
	document.forms[0].txt_condition.value=val4;
	document.forms[0].hidsno.value =val1;
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(true,false,false,true,true,false);
	}
}

function disableCommandButtons(cmdnew,cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{	 
	 document.forms[0].cmdnew.disabled =cmdnew;
	 document.forms[0].cmdedit.disabled=cmdedit;
	 document.forms[0].cmddelete.disabled=cmddelete;
	 document.forms[0].cmdsave.disabled=cmdsave;
	 document.forms[0].cmdcancel.disabled=cmdcancel;		 
	 document.forms[0].cmdclose.disabled=cmdclose;		
}	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function callCalender(fname)
{
	 showCal(appURL,fname);
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
	var cbsid = document.forms[0].cbsid.value;
	var hidpostins_no = document.forms[0].hidpostins_no.value;
	var purl = appURL+"action/followupInspectionPrint.jsp?hidBeanGetMethod=getPostInspectionPrint&hidBeanId=postinspection&hidpostins_no="+hidpostins_no+"&cbsid="+cbsid;
				prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print";
	window.open(purl,title,prop);
}

function onLoading()
{
	disableFields(true);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoading()">
<form name="frmdocumentregister" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr>
						<td align="center" class="sub_tab_active">Inspection Report</td>
						<td align="center" class="sub_tab_inactive"><b> <a
							href="JavaScript:callLink('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"
							>Facility Enjoyed</a> </b></td>
						<td align="center" class="sub_tab_inactive"><a
							href="JavaScript:callLink('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>					
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Post/Follow Up
		Inspection -&gt; Inspection Report -&gt; Standing Crops</td>
	</tr>
</table>
<lapschoice:PostInspection/>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<td class="sub_tab_inactive" align="center"><b> <a
									href="javascript:callLink('followupInspectionReport.jsp','postinspection','getPostInspectionReport')">Follow-up
								Inspection Report</a></b></td>
								<td class="sub_tab_active" align="center"><b>Standing Crops</b></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable linebor">
					<tr>
						<td colspan="3" class="dataheader"><b>Give particulars of the standing
						crops on the borrower's farm in the following table</b></td>
					</tr>
					<tr class="dataheader" align="center">
						<td width="14%">Name of the crop <span class="mantatory">*</span> </td>
						<td width="14%">Approximate acerage</td>
						<td width="5%">condition of the crop</td>
					</tr>
					<tr class="datagrid" align="center">
						<td width="14%"><input type="text" name="txt_crop" size="30" maxlength="30"></td>
						<td width="14%"><input type="text" name="txt_acerage" maxlength="20" size="20"></td>
						<td width="5%"><textarea rows="3" name="txt_condition" cols="50" tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
					</tr>

				</table></td></tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="98.3%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
					<tr class="dataheader">
						<td width="3%" align="center"></td>
						<td width="13%" align="center"><b>Name of the crop</b></td>
						<td width="14%" align="center"><b>Approximate acerage</b></td>
						<td width="14%" align="center"><B>condition of the crop</B></td>
					</tr>
				<%arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);%>
					<tr class="datagrid">
						<td width="3%" align="center"><input type="radio"
							style="border:none" name="radiobutton" value="radiobutton"
							onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',											
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>')">
						</td>
						<td width="13%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
						<td width="14%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
						<td width="14%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
					</tr>
					<%}}%>
					<tr>
						<td width="3%" align="center">&nbsp;</td>
						<td width="13%" align="left">&nbsp;</td>
						<td width="14%" align="left">&nbsp;</td>
						<td width="14%" align="left">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno"> 
<input type="hidden" name="hidreviewtype" value="<%=strReviewtype%>"/>
</form>
</body>
</html>
