<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String strAppno = "";
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;

			}
			String applicantid = "";
			String appstatus = "";
			String appname = "";
			String Valuesin = "";
			String strValuesin = "";
			String strAppstatus = "";
			String strbtnenable = "";
			String strpropappno = "";

			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			applicantid = Helper.correctNull((String) hshValues
					.get("applicantid"));
			appstatus = Helper
					.correctNull((String) hshValues.get("appstatus"));
			appname = Helper.correctNull((String) hshValues.get("app_name"));
			Valuesin = Helper.correctNull((String) hshValues.get("valuesin"));
			strbtnenable = Helper.correctNull((String) hshValues
					.get("btnenable"));
			strpropappno = Helper.correctNull((String) hshValues
					.get("propappno"));

			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) request
						.getParameter("appno"));
			}
			if (appstatus.equalsIgnoreCase("")) {
				appstatus = Helper.correctNull((String) request
						.getParameter("appstatus"));
			}
			if (appstatus.equalsIgnoreCase("op")
					|| strAppno.equalsIgnoreCase("new")) {
				strAppstatus = "Open/Pending";
			} else if (appstatus.equalsIgnoreCase("pa")) {
				strAppstatus = "Processed/Approved";

			} else if (appstatus.equalsIgnoreCase("pr")) {
				strAppstatus = "Processed/Rejected";
			} else if (appstatus.equalsIgnoreCase("ca")) {
				strAppstatus = "Closed/Approved";
			} else if (appstatus.equalsIgnoreCase("cr")) {
				strAppstatus = "Closed/Rejected";
			}
			if (appname.equalsIgnoreCase("")) {
				appname = Helper.correctNull((String) request
						.getParameter("appname"));
			}
			if (applicantid.equalsIgnoreCase("")) {
				applicantid = Helper.correctNull((String) request
						.getParameter("comapp_id"));
			}

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (Valuesin.equalsIgnoreCase("")) {
				Valuesin = Helper.correctNull((String) request
						.getParameter("valuesin"));
			}
			if (Valuesin.equals("L")) {
				strValuesin = " in Lacs";
			} else {
				strValuesin = "";
			}
			String strAppOrgName = Helper.correctNull((String)hshValues.get("org_name"));
			String strAppHolder = Helper.correctNull((String)hshValues.get("applnholder"));
%>

<html>
<head>
<title>Modification in Sanction Terms</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varAppno ="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var varappstatus ="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selectValues(varsno, vargrp)
{
	if(vargrp=="0")
	{
		document.forms[0].facility_headdesc.value=document.forms[0].elements["hidfacheaddesc"+varsno].value;
		document.forms[0].facility_head.value=document.forms[0].elements["hidfachead"+varsno].value;
		document.forms[0].facilitydesc.value=document.forms[0].elements["hidfacdesc"+varsno].value;
		document.forms[0].facility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_sanclimit.value=document.forms[0].elements["hidsanclimit"+varsno].value;
		document.forms[0].txt_outstanding.value=document.forms[0].elements["hidoutstanding"+varsno].value;
		document.forms[0].txt_margin.value=document.forms[0].elements["hidmargin"+varsno].value;
		document.forms[0].txt_outstandingason.value=document.forms[0].elements["hidoutstandingason"+varsno].value;
		document.forms[0].txt_cbsno.value=document.forms[0].elements["hidcbsno"+varsno].value;
		document.forms[0].txt_appint.value=document.forms[0].elements["hidappint"+varsno].value;
		document.forms[0].txt_existint.value=document.forms[0].elements["hidexistint"+varsno].value;
		document.forms[0].txt_propint.value=document.forms[0].elements["hidpropint"+varsno].value;
		document.forms[0].txt_ROremd.value=document.forms[0].elements["hidROremd"+varsno].value;
		document.forms[0].txt_COremd.value=document.forms[0].elements["hidCOremd"+varsno].value;
		document.forms[0].txt_concession.value=document.forms[0].elements["hidconcession"+varsno].value;
		document.forms[0].txt_irregularties.value=document.forms[0].elements["hidirregularties"+varsno].value;
		document.forms[0].txt_ZOremd.value=document.forms[0].elements["hidZOremd"+varsno].value;
		
		document.forms[0].subfacility_head.value="";
		document.forms[0].subfacility_headdesc.value="";
		document.forms[0].subfacility.value="";
		document.forms[0].subfacilitydesc.value="";
		document.forms[0].txt_subsanclimit.value="";
		document.forms[0].txt_suboutstanding.value="";
		document.forms[0].txt_submargin.value="";
		document.forms[0].txt_suboutstandingason.value="";
		document.forms[0].txt_subcbsno.value="";
		document.forms[0].txt_subappint.value="";
		document.forms[0].txt_subexistint.value="";
		document.forms[0].txt_subpropint.value="";
		document.forms[0].txt_subROremd.value="";
		document.forms[0].txt_subCOremd.value="";
		document.forms[0].txt_subconcession.value="";
		document.forms[0].txt_subirregularties.value="";
		document.forms[0].txt_subZOremd.value="";
		document.forms[0].chksublimit.checked=false;
		document.forms[0].chksublimit.value="N";
		document.forms[0].hidfactype.value="limit";
		
	}
	else
	{
		document.forms[0].facility_headdesc.value=document.forms[0].elements["hidfacheaddesc"+vargrp].value;
		document.forms[0].facility_head.value=document.forms[0].elements["hidfachead"+vargrp].value;
		document.forms[0].facilitydesc.value=document.forms[0].elements["hidfacdesc"+vargrp].value;
		document.forms[0].facility.value=document.forms[0].elements["hidfacility"+vargrp].value;
		document.forms[0].txt_sanclimit.value=document.forms[0].elements["hidsanclimit"+vargrp].value;
		document.forms[0].txt_outstanding.value=document.forms[0].elements["hidoutstanding"+vargrp].value;
		document.forms[0].txt_margin.value=document.forms[0].elements["hidmargin"+vargrp].value;
		document.forms[0].txt_outstandingason.value=document.forms[0].elements["hidoutstandingason"+vargrp].value;
		document.forms[0].txt_cbsno.value=document.forms[0].elements["hidcbsno"+vargrp].value;
		document.forms[0].txt_appint.value=document.forms[0].elements["hidappint"+vargrp].value;
		document.forms[0].txt_existint.value=document.forms[0].elements["hidexistint"+vargrp].value;
		document.forms[0].txt_propint.value=document.forms[0].elements["hidpropint"+vargrp].value;
		document.forms[0].txt_ROremd.value=document.forms[0].elements["hidROremd"+vargrp].value;
		document.forms[0].txt_COremd.value=document.forms[0].elements["hidCOremd"+vargrp].value;
		document.forms[0].txt_concession.value=document.forms[0].elements["hidconcession"+vargrp].value;
		document.forms[0].txt_irregularties.value=document.forms[0].elements["hidirregularties"+vargrp].value;
	    document.forms[0].txt_ZOremd.value=document.forms[0].elements["hidZOremd"+vargrp].value;
	    
		
		document.forms[0].subfacility_headdesc.value=document.forms[0].elements["hidfacheaddesc"+varsno].value;
		document.forms[0].subfacility_head.value=document.forms[0].elements["hidfachead"+varsno].value;
		document.forms[0].subfacilitydesc.value=document.forms[0].elements["hidfacdesc"+varsno].value;
		document.forms[0].subfacility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_subsanclimit.value=document.forms[0].elements["hidsanclimit"+varsno].value;
		document.forms[0].txt_suboutstanding.value=document.forms[0].elements["hidoutstanding"+varsno].value;
		document.forms[0].txt_submargin.value=document.forms[0].elements["hidmargin"+varsno].value;
		document.forms[0].txt_suboutstandingason.value=document.forms[0].elements["hidoutstandingason"+varsno].value;
		document.forms[0].txt_subcbsno.value=document.forms[0].elements["hidcbsno"+varsno].value;
		document.forms[0].txt_subappint.value=document.forms[0].elements["hidappint"+varsno].value;
		document.forms[0].txt_subexistint.value=document.forms[0].elements["hidexistint"+varsno].value;
		document.forms[0].txt_subpropint.value=document.forms[0].elements["hidpropint"+varsno].value;
		document.forms[0].txt_subROremd.value=document.forms[0].elements["hidROremd"+varsno].value;
		document.forms[0].txt_subCOremd.value=document.forms[0].elements["hidCOremd"+varsno].value;
		document.forms[0].txt_subconcession.value=document.forms[0].elements["hidconcession"+varsno].value;
		document.forms[0].txt_subirregularties.value=document.forms[0].elements["hidirregularties"+varsno].value;
		document.forms[0].txt_subZOremd.value=document.forms[0].elements["hidZOremd"+varsno].value;
		
		document.forms[0].chksublimit.checked=true;
		document.forms[0].chksublimit.value="Y";
		document.forms[0].hidfactype.value="sublimit";
	}
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidfacgrp.value=vargrp;
	
	if(vargrp=="0")
	{
		if(document.forms[0].btnenable.value=='Y')
		{
			disableCommandButtons(false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,false);
		}
	}
	else
	{
		if(document.forms[0].btnenable.value=='Y')
		{
			disableCommandButtons(false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,false);
		}
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
	document.forms[0].facility_headdesc.readOnly=true;
	document.forms[0].facilitydesc.readOnly=true;
	document.forms[0].subfacility_headdesc.readOnly=true;
	document.forms[0].subfacilitydesc.readOnly=true;
	document.forms[0].txt_sanclimit.readOnly=true;
	document.forms[0].txt_subsanclimit.readOnly=true;
	
	if(varOrgLevel=="C")
	{
		document.forms[0].txt_submargin.readOnly=true;
		document.forms[0].txt_margin.readOnly=true;
		
		document.forms[0].txt_appint.readOnly=true;
		document.forms[0].txt_subappint.readOnly=true;
		
		document.forms[0].txt_existint.readOnly=true;
		document.forms[0].txt_subexistint.readOnly=true;
		
		document.forms[0].txt_propint.readOnly=true;
		document.forms[0].txt_subpropint.readOnly=true;
		
		document.forms[0].txt_ROremd.readOnly=true;
		document.forms[0].txt_subROremd.readOnly=true;
		
		document.forms[0].txt_ZOremd.readOnly=true;
		document.forms[0].txt_subZOremd.readOnly=true;
		
		document.forms[0].txt_COremd.readOnly=val;
		document.forms[0].txt_subCOremd.readOnly=val;
	}
	else if(varOrgLevel=="R")
	{
		document.forms[0].txt_submargin.readOnly=true;
		document.forms[0].txt_margin.readOnly=true;
		
		document.forms[0].txt_appint.readOnly=true;
		document.forms[0].txt_subappint.readOnly=true;
		
		document.forms[0].txt_existint.readOnly=true;
		document.forms[0].txt_subexistint.readOnly=true;
		
		document.forms[0].txt_propint.readOnly=true;
		document.forms[0].txt_subpropint.readOnly=true;
		
		document.forms[0].txt_ROremd.readOnly=true;
		document.forms[0].txt_subROremd.readOnly=true;
		
		document.forms[0].txt_ZOremd.readOnly=val;
		document.forms[0].txt_subZOremd.readOnly=val;
		
		document.forms[0].txt_COremd.readOnly=true;
		document.forms[0].txt_subCOremd.readOnly=true;
	}
	else if(varOrgLevel=="D")
	{
		document.forms[0].txt_submargin.readOnly=true;
		document.forms[0].txt_margin.readOnly=true;
		
		document.forms[0].txt_appint.readOnly=true;
		document.forms[0].txt_subappint.readOnly=true;
		
		document.forms[0].txt_existint.readOnly=true;
		document.forms[0].txt_subexistint.readOnly=true;
		
		document.forms[0].txt_propint.readOnly=true;
		document.forms[0].txt_subpropint.readOnly=true;
		
		document.forms[0].txt_ROremd.readOnly=val;
		document.forms[0].txt_subROremd.readOnly=val;
		
		document.forms[0].txt_ZOremd.readOnly=true;
		document.forms[0].txt_subZOremd.readOnly=true;

		document.forms[0].txt_COremd.readOnly=true;
		document.forms[0].txt_subCOremd.readOnly=true;
	}
	else if(varOrgLevel=="A")
	{
		document.forms[0].txt_submargin.readOnly=val;
		document.forms[0].txt_margin.readOnly=val;
		
		document.forms[0].txt_appint.readOnly=val;
		document.forms[0].txt_subappint.readOnly=val;
		
		document.forms[0].txt_existint.readOnly=val;
		document.forms[0].txt_subexistint.readOnly=val;
		
		document.forms[0].txt_propint.readOnly=val;
		document.forms[0].txt_subpropint.readOnly=val;
		
		document.forms[0].txt_ROremd.readOnly=true;
		document.forms[0].txt_subROremd.readOnly=true;
		
		document.forms[0].txt_ZOremd.readOnly=true;
		document.forms[0].txt_subZOremd.readOnly=true;
		
		document.forms[0].txt_COremd.readOnly=true;
		document.forms[0].txt_subCOremd.readOnly=true;
	}
}

function onloading()
{	
var varappcount="<%=Helper.correctNull((String)hshValues.get("appavailable"))%>";  
var varpropavail="<%=Helper.correctNull((String)hshValues.get("propavailable"))%>";  
var varalertmsg="<%=Helper.correctNull((String)hshValues.get("strMsg"))%>";  
	if(varappcount=='YES' || varpropavail=='No')
	{
		alert(varalertmsg);
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
	if(varAppno=='NEW')
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();	
	}
	else
	{
		disableCommandButtons(true,true,true,true,false);
		disableFields(true);
	}
	
}

function doSave()
{
	document.forms[0].hidBeanId.value="modsancterms";		
	document.forms[0].hidSourceUrl.value="/action/commst_facilities.jsp";
	document.forms[0].hidBeanMethod.value="updatefacilityData";
	document.forms[0].hidBeanGetMethod.value="getfacilityData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updatefacilityData";	
			document.forms[0].hidBeanGetMethod.value="getfacilityData";	
			document.forms[0].hidBeanId.value="modsancterms";
			document.forms[0].hidSourceUrl.value="action/commst_facilities.jsp";	
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();	
		}	
	}
	else
	{
		ShowAlert(158);
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
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].hidBeanGetMethod.value="getfacilityData";
		document.forms[0].action=appURL+"action/commst_facilities.jsp";
		document.forms[0].submit();
	}
}
   
 function disableCommandButtons(cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
 {  

	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdapply;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callSublimit()
{
	if(document.forms[0].chksublimit.checked && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Can't check in edit mode or add mode");			
		return;
	}
	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck");			
		return;
	}
	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hidfacgrp.value!="0")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck sublimit exists");			
		return;
	}
	
	
	if(document.forms[0].hidsno.value=="")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Select Main Limit");
		return;
	}
	
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>

<body onload="onloading()">
<form method="post" name="facility" class="normal"><lapstab:applurllinksmst pageid="1" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Modification in sanction
		terms -&gt; Facilities</td>
	</tr>
</table>
<lapschoice:MSTApplications />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr>
												<td width="20%" align="left">Facility Head <span class="mantatory"><b>*</b></span></td>
												<td align="left" width="29%">
												<input type="hidden" name="facility_head"/>
												<input type="text" name="facility_headdesc" size="40"/>
												</td>
												<td align="left" width="25%">Facility <span class="mantatory"><b>*</b></span></td>
												<td align="left" colspan="2" width="26%">
												<input type="text" name="facilitydesc" size="75">
												<input type="hidden" name="facility"></td>
												</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Sanctioned Limits <span class="mantatory"><b>*</b></span>(<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
												<td width="29%"><lapschoice:CurrencyTag name="txt_sanclimit"
													size="13" maxlength="10" /></td>
												<td width="25%" nowrap="nowrap">Outstanding (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
												<td colspan="2" width="26%"><lapschoice:CurrencyTag
													name="txt_outstanding" size="13" maxlength="10" /></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Margin</td>
												<td width="29%"><lapschoice:CurrencyTag name="txt_margin"
													size="13" maxlength="10" /></td>
												<td width="25%" nowrap="nowrap">Out Standing as on</td>
												<td width="26%"><input type="text"
													name="txt_outstandingason" onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
													alt="Select date from calender" href="#"
													onClick="callCalender('txt_outstandingason')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;">&nbsp;<img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">CBS Account No</td>
												<td width="29%"><input type="text" name="txt_cbsno"
													size="50" maxlength="15"></td>
												<td width="25%" align="left">&nbsp;</td>
												<td align="left" width="26%">&nbsp;</td>
											</tr>
											<tr>
												<td colspan="5" nowrap="nowrap"><b>Interest / commission</b></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Applicable</td>
												<td width="29%"><input type="text" name="txt_appint"
													size="20" maxlength="18" onKeyPress="notAllowSplChar"></td>
												<td width="25%" align="left">Existing</td>
												<td align="left" colspan="2" width="26%"><input type="text"
													name="txt_existint" size="20" maxlength="18"
													onKeyPress="notAllowSplChar"></td>
											</tr>
											<tr>
												
                                    <td width="20%" nowrap="nowrap">Proposed by Branch</td>
												<td width="29%"><input type="text" name="txt_propint"
													size="20" maxlength="18" onKeyPress="notAllowSplChar"></td>
												
                                    <td width="25%" align="left">Recommended by 
                                      RO</td>
												<td align="left" colspan="2" width="26%"><input type="text"
													name="txt_ROremd" size="20" maxlength="18"
													onKeyPress="notAllowSplChar"></td>
											</tr>
											<tr>
											
                                    <td width="25%" align="left">Recommended by 
                                      FGMO</td>
												<td align="left"  width="26%"><input type="text"
													name="txt_ZOremd" size="20" maxlength="18"
													onKeyPress="notAllowSplChar"></td>
											
												<td width="20%" nowrap="nowrap">Recommended by CO</td>
												<td width="29%"><input type="text" name="txt_COremd"
													size="20" maxlength="18" onKeyPress="notAllowSplChar"></td>
												
											</tr>
											<tr>
											<td width="25%" align="left">Concession Involved</td>
												<td align="left"  width="26%"><input type="text"
													name="txt_concession" size="20" maxlength="18"
													onKeyPress="notAllowSplChar"></td>
												<td width="20%" nowrap="nowrap">Irregularities / Overdues, if any</td>
												<td ><textarea name="txt_irregularties"
													cols="40"
													onKeyPress="notAllowSplChar(this);textlimit(this,3999)"
													onKeyUp="textlimit(this,3999)"></textarea></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr>

												<td width="20%" nowrap="nowrap"><input type="checkbox"
													name="chksublimit" value="N" 
													onClick="callSublimit()"> Sub-Limits</td>
												<td colspan="4">&nbsp;</td>
											</tr>
											<tr>
												<td width="20%" align="left" nowrap="nowrap">Sub-Limit Head <span class="mantatory"><b>*</b></span></td>
												<td align="left" width="29%">
												<input type="hidden" name="subfacility_head"/>
												<input type="text" name="subfacility_headdesc" size="45"/>
												</td>
												<td width="25%" align="left">Sub-Limit <span class="mantatory"><b>*</b></span></td>
												<td align="left" colspan="2" width="26%">
												<input type="text" name="subfacilitydesc" size="75">
												<input type="hidden" name="subfacility">
												</td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Sanctioned Limits <span class="mantatory"><b>*</b></span>(<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
												<td width="29%"><lapschoice:CurrencyTag name="txt_subsanclimit"
													size="20" maxlength="20" /></td>
												<td width="25%" nowrap="nowrap">Outstanding (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</td>
												<td colspan="2" width="26%"><lapschoice:CurrencyTag
													name="txt_suboutstanding" size="13" maxlength="10" /></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Margin</td>
												<td width="29%"><lapschoice:CurrencyTag name="txt_submargin"
													size="13" maxlength="10" /></td>
												<td width="25%" nowrap="nowrap">Out Standing as on</td>
												<td width="26%"><input type="text"
													name="txt_suboutstandingason" onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
													alt="Select date from calender" href="#"
													onClick="callCalender('txt_suboutstandingason')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;">&nbsp;<img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">CBS Account No</td>
												<td width="29%"><input type="text" name="txt_subcbsno"
													size="50" maxlength="15"></td>
												<td width="25%" align="left">&nbsp;</td>
												<td align="left" width="26%">&nbsp;</td>
											</tr>
											<tr>
												<td colspan="5" nowrap="nowrap"><b>Interest / commission</b></td>
											</tr>
											<tr>
												<td width="20%" nowrap="nowrap">Applicable</td>
												<td width="29%"><input type="text" name="txt_subappint"
													size="20" maxlength="15" onKeyPress="notAllowSplChar"></td>
												<td width="25%" align="left">Existing</td>
												<td align="left" colspan="2" width="26%"><input type="text"
													name="txt_subexistint" size="20" maxlength="15"
													onKeyPress="notAllowSplChar"></td>
											</tr>
											<tr>
												
                                    <td width="20%" nowrap="nowrap">Proposed by Branch</td>
												<td width="29%"><input type="text" name="txt_subpropint"
													size="20" maxlength="15" onKeyPress="notAllowSplChar"></td>
												
                                    <td width="25%" align="left">Recommended by 
                                      RO</td>
												<td align="left" colspan="2" width="26%"><input type="text"
													name="txt_subROremd" size="20" maxlength="15"
													onKeyPress="notAllowSplChar"></td>
											</tr>
											<tr>
											
                                    <td width="25%" align="left">Recommended by 
                                      FGMO</td>
												<td align="left"  width="26%"><input type="text"
													name="txt_subZOremd" size="20" maxlength="15"
													onKeyPress="notAllowSplChar"></td>
											
												<td width="20%" nowrap="nowrap">Recommended by CO</td>
												<td width="29%"><input type="text" name="txt_subCOremd"
													size="20" maxlength="15" onKeyPress="notAllowSplChar"></td>
												</tr>
											<tr>
											<td width="25%" align="left">Concession Involved</td>
												<td align="left" width="26%"><input type="text"
													name="txt_subconcession" size="20" maxlength="15"
													onKeyPress="notAllowSplChar"></td>
											
												<td width="20%" nowrap="nowrap">Irregularities / Overdues, if any</td>
												<td><textarea name="txt_subirregularties"
													cols="40"
													onKeyPress="notAllowSplChar(this);textlimit(this,3999)"
													onKeyUp="textlimit(this,3999)"></textarea></td>
											</tr>
										</table>
										</td>
										</tr>
										
								</table>
								</td>
							</tr>
						</table><br>
						<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trial"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
					<tr>
						<td>

						<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="11%"><b>Nature
										of Limit</b></td>
										<td align="center" width="10%"><b>Amount</b></td>
										<td align="center" width="15%"><b>OutStanding
										as on </b></td>
										<td align="center" width="11%"><b>Margin</b></td>
										<td align="center" colspan="3"><b>Interest/Commission</b></td>
										<td align="center" width="15%"><b>Concession
										on Involved</b></td>
									</tr>
									<tr class="datagrid">
										<td width="5%">&nbsp;</td>
										<td align="center" colspan="4">&nbsp;</td>
										<td align="center" width="11%">Applicable</td>
										<td align="center" width="11%">Existing</td>
										<td align="center" width="11%">Proposed</td>
										<td align="center" width="15%">&nbsp;</td>
									</tr>
								</table>

								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<%String strSno = "";
			double dblamtsanc = 0.0;
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					int count = 0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						strSno = Helper.correctNull((String) arrCol.get(15));
						if (Helper.correctNull((String) arrCol.get(14))
								.equalsIgnoreCase("0")) {
							dblamtsanc = dblamtsanc
									+ Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2)));
							count = 0;

							%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(14))%>')">
										<input type="hidden" name="hidfachead<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>" /> 
										<input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> 
										<input type="hidden" name="hidsanclimit<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>" />
										<input type="hidden" name="hidoutstanding<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
										<input type="hidden" name="hidmargin<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(4))%>" /> 
										<input type="hidden" name="hidoutstandingason<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> 
										<input type="hidden" name="hidcbsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> 
										<input type="hidden" name="hidappint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>" /> 
										<input type="hidden" name="hidexistint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(8))%>" /> 
										<input type="hidden" name="hidpropint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(9))%>" /> 
										<input type="hidden" name="hidROremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(10))%>" /> 
										<input type="hidden" name="hidCOremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(11))%>" /> 
										<input type="hidden" name="hidconcession<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(12))%>" /> 
										<input type="hidden" name="hidirregularties<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(13))%>" /> 
										<input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(15))%>" /> 
										<input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(14))%>" />
										<input type="hidden" name="hidfacheaddesc<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(16))%>" />
										<input type="hidden" name="hidfacdesc<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(17))%>" />
										<input type="hidden" name="hidZOremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(18))%>" /> 
									</td>
										<td width="11%" align="left"> <%=Helper.correctNull((String) arrCol
											.get(17))%>&nbsp;</td>
										<td width="10%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(2))))%></td>
										<td width="15%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(3))))%></td>
										<td width="11%" align="right">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(4))%></td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(7))%>&nbsp;</td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(8))%>&nbsp;</td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(9))%>&nbsp;</td>
										<td align="right" width="15%"><%=Helper.correctNull((String) arrCol
											.get(12))%>&nbsp;</td>
									</tr>
									<%} else if (!Helper.correctNull((String) arrCol.get(14))
								.equalsIgnoreCase("0")) {

							%>
									<tr class="dataheader">
										<%if (count == 0) {

							%>
										<td width="5%">&nbsp;</td>
										<td colspan="8"><b>&gt;&gt;Sub Limit</b></td>
									</tr>
									<tr>
										<%}

							%>
										<td width="5%" align="center"><input
											type="radio" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(14))%>')">
										<input type="hidden" name="hidfachead<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>" /> 
										<input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> 
										<input type="hidden" name="hidsanclimit<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>" />
										<input type="hidden" name="hidoutstanding<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
										<input type="hidden" name="hidmargin<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(4))%>" /> 
										<input type="hidden" name="hidoutstandingason<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> 
										<input type="hidden" name="hidcbsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> 
										<input type="hidden" name="hidappint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>" /> 
										<input type="hidden" name="hidexistint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(8))%>" /> 
										<input type="hidden" name="hidpropint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(9))%>" /> 
										<input type="hidden" name="hidROremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(10))%>" /> 
										<input type="hidden" name="hidCOremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(11))%>" /> 
										<input type="hidden" name="hidconcession<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(12))%>" /> 
										<input type="hidden" name="hidirregularties<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(13))%>" /> 
										<input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(15))%>" /> 
										<input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(14))%>" />
										<input type="hidden" name="hidfacheaddesc<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(16))%>" />
										<input type="hidden" name="hidfacdesc<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(17))%>" />
										<input type="hidden" name="hidZOremd<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(18))%>" /> 
									</td>
										<td width="11%" align="left"><%=Helper.correctNull((String) arrCol
											.get(17))%></td>
										<td width="10%" align="right">(<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(2))))%>)</td>
										<td width="15%" align="right">(<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(3))))%>)</td>
										<td width="11%" align="right"><%=Helper
													.correctNull((String) arrCol
															.get(4))%></td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(8))%></td>
										<td align="left" width="11%"><%=Helper
													.correctNull((String) arrCol
															.get(9))%></td>
										<td align="right" width="15%"><%=Helper.correctNull((String) arrCol
											.get(12))%></td>
									</tr>
									<%count++;
						}
					}
				}

				%>
									<tr class="datagrid">
										<td colspan="2" align="right"><b>Total</b></td>
										<td align="right" width="10%"><input type="hidden"
											name="hidlimit"
											value="<%=Helper.formatDoubleValue(dblamtsanc)%>" /> <%=Helper.formatDoubleValue(dblamtsanc)%></td>
										<td width="15%">&nbsp;</td>
										<td width="11%">&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td align="right" width="15%">&nbsp;</td>
									</tr>
									<%} else {

			%>
									<tr>
										<td align="center" colspan="9">No Data Found</td>
									</tr>
									<%}

			%>
								</table>
								</td>
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
	</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidfacgrp" value=""> <input type="hidden"
	name="hidfactype"> <input type="hidden" name="hidGrpList">
<script>
var msg ="<%=Helper.correctNull((String)hshValues.get("msg"))%>";
if(msg!="")
{
  alert(msg);
}
</script></form>
</body>
</html>
