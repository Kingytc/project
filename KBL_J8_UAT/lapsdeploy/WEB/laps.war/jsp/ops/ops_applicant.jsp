<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
			String tempProfile = "";
			if (strProfilestatus.equalsIgnoreCase("Y")) {
				tempProfile = "Completed";
			} else {
				tempProfile = " Not Completed";
			}
			String strModuleName = Helper.correctNull(request.getParameter("hidModuleName"));%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/ops/ops_applicant.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varcategory= "t";
function doramdetails()
{
	var varQryString = appURL+"action/ramparameters.jsp?controllerservlet&hidBeanGetMethod=getRAMParameters&hidBeanId=LapsToRam&comapp_id="+document.forms[0].hidDemoId.value+"&comapp_companyid="+document.forms[0].hidDemoId.value+"&type=OPS";
 	var title = "Ramdetails_tertiary";
	var prop = "scrollbars=yes,menubar=yes,width=900,height=550";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();enableSince();showBranch();getlocationvalues();showres();showcoun();shownri();showStaffBox()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Customer Profile -&gt;Demographics</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="75%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td class="main_tab_active" align="center"><b>Demographics</b></td>
				<td class="main_tab_inactive" align="center"><b><a
					href="JavaScript:callKYCNorms()" >KYC Norms</a></b></td>
				<td class="main_tab_inactive" align="center"><b><a
					href="JavaScript:callIncomeExpenses()" >Income &amp; Expenses</a></b></td>
				<td class="main_tab_inactive" id="employertdbtn1" align="center"><b><a
					href="JavaScript:callEmployer()" >Employment/Occupation Details</a></b></td>
				<td class="main_tab_active" align="center"><b>Profile Status :<%=tempProfile%></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<%@include file="../per/per_commoncustdemographics.jsp"%><br>
<table width="20%" border="1" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
		<table width="43%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td><input type="button" name="cmdedit" value="Edit" tabindex="89"
					class="buttonStyle" onClick="callEdit()"></td>
				<td><input type="button" name="cmdsave" value="Save" tabindex="95"
					class="buttonStyle" onClick="doSave()"></td>
				<td><input type="button" name="cmdcancel" value="Cancel"
					tabindex="96" class="buttonStyle" onClick="callCancel()"></td>
				<td><input type="button" name="cmddelete" value="Delete"
					tabindex="97" class="buttonStyle" onClick="callDelete()"></td>
				<td><input type="button" name="cmdmodify" value="Modify"
					tabindex="93" class="buttonStyle" onClick="callModify()" disabled>
				</td>		
			<!-- 	<td><input type="button" name="cmdaudittrial" value="Audit Trail"
					tabindex="93" class="buttonOthers" onClick="doAuditTrial()" >
				</td>	 -->					
				<td><input type="button" name="cmdclose" value="Close" tabindex="99"
					onClick="callClose()" class="buttonClose"></td>
				<td id="n1"><input type="button" name="cmdNridetails"
					value="NRI Details" tabindex="100" onClick="callNRI()"
					class="buttonStyle" style="width:100"></td>
				<td><input type="button" name="cmdreferences" value="References"
					tabindex="101" onClick="callReferences()" class="buttonStyle"
					style="width:100"></td>
				<td id="m1" width="0"><input type="button" name="cmdpartners"
					tabindex="102" value="Partners/Co-Parceners/Trustees/SHG/Directors"
					onClick="callDirectors()" class="buttonStyle"
					style="width:280;visibility:hidden;position:absolute"></td>
			<!-- 	<td width=0><input type="button" name="ramdetails"
					value="SEND TO RAM" tabindex="87" onClick="doramdetails()"
					class="buttonOthers">
				</td>-->
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAppType" value='A'> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hidCBSId" value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> 
<input type="hidden" name="hidOldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="OldAppId" value="<%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>">
<input type="hidden" name="scode" value="yyy"> 
<input type="hidden" name="txt_flag" value="<%=txt_flag%>"> 
<input type="hidden" name="Branch" value="Branch"> 
<input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hid_comappid2" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="txt_employment" value="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>">
<input type="hidden" name="applnt" value="T"> 
<input type="hidden" name="hidphotoid" value="<%=Helper.correctNull((String)hshValues.get("perapp_photo"))%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
<input type="hidden" name="hidzip1" value="">
<input type="hidden" name="hidzip2" value="">
<input type="hidden" name="hidres1" value="">
<input type="hidden" name="hidres2" value="">
<input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
<input type="hidden" name="usr_mname" value=""> 
<input type="hidden" name="hidModuleName" value="T"> 
<input type="hidden" name="hid_inwardno" value = "">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<script>
if(id.toUpperCase()=="NEW")
{
	//document.forms[0].ramdetails.disabled=true;
}
</script></form>
</body>
</html>