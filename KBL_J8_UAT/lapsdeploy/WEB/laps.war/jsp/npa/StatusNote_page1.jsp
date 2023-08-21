<%@include file="../share/directives.jsp"%>
<%	String strbankarrangement = Helper.correctNull((String) hshValues.get("bankarrangement"));
	String sta_unit = Helper.correctNull((String) hshValues.get("unitstatus"));
	String sta_working = Helper.correctNull((String) hshValues.get("unitrunfor"));
	String status_note = Helper.correctNull((String) hshValues.get("propfor"));
	String flag = Helper.correctNull((String) hshValues.get("flag"));
	HashMap hshAppdata = new HashMap();
	hshAppdata = (HashMap) hshValues.get("hshAppdata");

	String strAppno = "";
	String strcbsid = "";
	String appname = "";
	String strAppstatus = "";
	String stryear = "";
	String strQua = "";
	String appstatus = "";
	String strAppname = "";
	String applicantid = "";
	String readFlag = "";
	String strBorrowertype = "";
	String strmoduletype = "";
	String strBTNEnable = "";
	String strquarter = "";
	String npaorgscode = "";
	String strAppholder = "";
	String strOrgname = "";
	strAppno = Helper.correctNull((String) hshAppdata.get("npaappno"));
	strcbsid = Helper.correctNull((String) hshAppdata.get("cbsid"));
	appname = Helper.correctNull((String) hshAppdata.get("customername"));
	strAppname = Helper.encodeAmpersand(appname);
	appstatus = Helper.correctNull((String) hshAppdata.get("status"));
	stryear = Helper.correctNull((String) hshAppdata.get("year"));
	strquarter = Helper.correctNull((String) hshAppdata.get("quarter"));
	strBorrowertype = Helper.correctNull((String) hshAppdata.get("demoapptype"));
	strmoduletype = Helper.correctNull((String) hshAppdata.get("moduletype"));
	strBTNEnable = Helper.correctNull((String) hshAppdata.get("btnenable"));
	readFlag = Helper.correctNull((String) hshAppdata.get("readflag"));
	npaorgscode = Helper.correctNull((String) hshAppdata.get("createorgscode"));
	strAppholder = Helper.correctNull((String) hshAppdata.get("holduserid"));
	strOrgname = Helper.correctNull((String) hshAppdata.get("apporgname"));
	strQua = strquarter.equals("1") ? "First"
			: strquarter.equals("2") ? "Second" : strquarter.equals("3") ? "Third"
					: strquarter.equals("4") ? "Fourth" : "";
	strAppstatus = (appstatus.equalsIgnoreCase("OP") || appstatus
			.equalsIgnoreCase("PP")) ? "Open" : appstatus
			.equalsIgnoreCase("CA") ? "Closed" : "";
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var sta_bankarrangement="<%=strbankarrangement%>";
var sta_unit="<%=sta_unit%>";
var sta_working="<%=sta_working%>";
var sta_note="<%=status_note%>";
var flag="<%=flag%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varfacpremises="<%=Helper.correctNull((String) hshValues
									.get("facpremises"))%>";
var varsancauth="<%=Helper.correctNull((String) hshValues.get("sancauth"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function showinfo()
{
	if(document.forms[0].sel_unitstatus.value=="1")
	{
		document.all.work.style.visibility="visible";
		document.all.no1.style.visibility="hidden";
		document.all.no11.style.visibility="hidden";
		document.all.no2.style.visibility="hidden";
		document.all.no22.style.visibility="hidden";
		document.forms[0].txt_unitclosedsince.value="";
		document.forms[0].txt_srclivehood.value="";
	}
	else if(document.forms[0].sel_unitstatus.value=="2")
	{
		document.all.work.style.visibility="hidden";
		document.all.no1.style.visibility="visible";
		document.all.no11.style.visibility="visible";
		document.all.no2.style.visibility="visible";
		document.all.no22.style.visibility="visible";
		document.forms[0].sel_unitrunfor.value="0";
	}
	else
	{
		document.all.work.style.visibility="hidden";
		document.all.no1.style.visibility="hidden";
		document.all.no11.style.visibility="hidden";
		document.all.no2.style.visibility="hidden";
		document.all.no22.style.visibility="hidden";
		document.forms[0].txt_unitclosedsince.value="";
		document.forms[0].txt_srclivehood.value="";
	}	
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="new")
	{
		document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose.disabled=false;	 
		 disableFields(false);
	}
}

function onLoading()
{
	if(sta_note!="")
	{
		document.forms[0].selproptype.value=sta_note;
	}
	else
	{
		document.forms[0].selproptype.value="0";
	}
	if(sta_bankarrangement!="")
	{
		document.forms[0].sel_bankarrangement.value=sta_bankarrangement;
	}
	else
	{
		document.forms[0].sel_bankarrangement.value="0";
	}
	if(sta_unit!="")
	{
		document.forms[0].sel_unitstatus.value=sta_unit;
	}
	else
	{
		document.forms[0].sel_unitstatus.value="0";
	}
	if(sta_working!="")
	{
		document.forms[0].sel_unitrunfor.value=sta_working;
	}
	else
	{
		document.forms[0].sel_unitrunfor.value="0";
	}
	if(varfacpremises!="")
	{
		document.forms[0].sel_facpremises.value=varfacpremises;
	}
	else
	{
		document.forms[0].sel_facpremises.value=0;
	}
	if(varsancauth!="")
	{
		document.forms[0].sel_sancauth.value=varsancauth;
	}
	showinfo();	
	if(document.forms[0].appno.value=="NEW")
	{
		disableCommandButtons("new");
		disableFields(false);
	}
	else
	{
 		disableFields(true);
	}
	
	document.forms[0].cmddelete.disabled=true;
}

function doEdit()
{ 	
	disableFields(false);
	disableCommandButtons("edit");	
	document.forms[0].selproptype.focus();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page1.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].selproptype.value=="0")
	{
		ShowAlert('111','Status of Account');
		document.forms[0].selproptype.focus();
		return;
	}
	if(document.forms[0].sel_bankarrangement.value=="0")
	{
		ShowAlert('111','Banking Arrangement');
		document.forms[0].sel_bankarrangement.focus();
		return;
	}
	if(document.forms[0].txt_lastreview.value=="")
	{
		ShowAlert('121','Date of Last Review');
		document.forms[0].txt_lastreview.focus();
		return;
	}
	if(document.forms[0].sel_sancauth.value=="0")
	{
		ShowAlert('111','Last Reviewed Authority');
		document.forms[0].sel_sancauth.focus();
		return;
	}
	if(document.forms[0].txt_lastreviewby.value=="")
	{
		ShowAlert('121','Last Reviewed By');
		document.forms[0].txt_lastreviewby.focus();
		return;
	}
	document.forms[0].hidReviewAuth.value = document.forms[0].sel_sancauth[document.forms[0].sel_sancauth.selectedIndex].text;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidmoduletype.value="STAT";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
	document.forms[0].action=appUrl+"action/StatusNote_page1.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/StatusNote_page1.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatestatusnotepage1Data";
		document.forms[0].hidBeanGetMethod.value="getstatusnotepage1Data";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
	}
	   
	document.forms[0].txt_unitclosedsince.readOnly=true;
	document.forms[0].txt_npasince.readOnly=true;
	document.forms[0].txt_lastreview.readOnly=true;
	document.forms[0].txt_lastfinancedate.readOnly=true;
	document.forms[0].txt_excessdate.readOnly=true;
	document.forms[0].txt_banksince.readOnly=true;
	document.forms[0].txt_advancesince.readOnly=true;
	document.forms[0].txt_consititution.readOnly=true;
	document.forms[0].txt_activity.readOnly=true;
	document.forms[0].txt_preclassification.readOnly=true;
}

function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}	

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function clearAllFeilds()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}
		
		if(document.forms[0].elements[i].type=='text')
	 	{
				document.forms[0].elements[i].value="";
		}
		
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].value="0";
		}			  
	}
}
</script>
</head>


<body onload="onLoading()">
<form name="statusnotepage1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:staturltag pageid="1" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Status
				Note -&gt; General -&gt; Banking Details</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader"">
		<td nowrap="nowrap"><b>Application No :</b></td>
		<td nowrap="nowrap"><b><%=strAppno%></b></td>

		<td nowrap="nowrap"><b>Applicant Name:</b></td>
		<td nowrap="nowrap"><b><%=appname%></b></td>

		<td nowrap="nowrap"><b>CBS CUSTOMER ID:</b></td>
		<td nowrap="nowrap"><b><%=strcbsid%></b></td>

		<td nowrap="nowrap"><b>Status:</b></td>
		<td nowrap="nowrap"><b><%=strAppstatus%></b></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap="nowrap"><b>Application Holder:</b></td>
		<td nowrap="nowrap"><b><%=strAppholder%></b></td>

		<td nowrap="nowrap"><b>Application Recd. from:</b></td>
		<td nowrap="nowrap"><b><%=strOrgname%></b></td>

		<td><b>Year:</b></td>
		<td><b><%=stryear%></b></td>

		<td><b>Quarter:</b></td>
		<td><b><%=strQua%></b> <input
			type="hidden" name="appstatus" value="<%=appstatus%>"> <input
			type="hidden" name="appname" value="<%=strAppname%>"> <input
			type="hidden" name="cbsid" value="<%=strcbsid%>"> <input
			type="hidden" name="npaorgcode" value="<%=npaorgscode%>"> <input
			type="hidden" name="appno" value="<%=strAppno%>"> <input
			type="hidden" name="readFlag" value="<%=readFlag%>"> <input
			type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
		<input type="hidden" name="hidborrowertype"
			value="<%=strBorrowertype%>"> <input type="hidden"
			name="btnenable" value="<%=strBTNEnable%>"> <input
			type="hidden" name="year" value="<%=stryear%>"> <input
			type="hidden" name="quarter" value="<%=strquarter%>"> <input
			type="hidden" name="appholder" value="<%=strAppholder%>"> <input
			type="hidden" name="apporgname" value="<%=strOrgname%>"></td>
	</tr>
</table>

<lapstab:npabankingdetails module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="5" bankarrangement='<%=strbankarrangement%>'/>

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
         <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr>
                  <td valign="top">STATUS OF ACCOUNT<span class="mantatory">*&nbsp;</span></td>
                  <td valign="top"> 
                    <select name="selproptype" tabindex="2">
                      <option value="0" selected="selected">----Select----</option>
                      <option value="1">NPA</option>
                      <option value="2">PWO</option>
                    </select>
                  </td>
                  <td valign="top">NPAs AS ON </td>
                  <td>
                    <input type="text" name="txt_npasince" size="15"
						maxlength="10" tabindex="3"
						 value="<%=Helper.correctNull((String) hshValues.get("npasince"))%>" 
						 onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a href="#" onClick="callCalender('txt_npasince')"
						title="Click to view calender" border="0"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="4"></a> </td>
                </tr>
                <tr> 
                  <td valign="top">Registered Office Address</td>
                  <td valign="top"> 
                    <textarea name="txt_regoffaddr"  cols="50" rows="5" class="interfacefields" onKeyPress="textlimit(this,49)" onKeyUp="textlimit(this,49)"><%=Helper.correctNull((String) hshValues.get("regoffaddr"))%></textarea>
                  </td>
                  <td valign="top">&nbsp; </td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td valign="top">Factory Address</td>
                  <td valign="top"> 
                    <textarea name="txt_facaddr"  cols="50" rows="4" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)"><%=Helper.correctNull((String) hshValues.get("facoffaddr"))%></textarea>
                  </td>
                  <td valign="top">Factory premises </td>
                  <td> 
                    <select name="sel_facpremises">
                      <option value="0" selected="selected">&lt;---Select---&gt;</option>
                      <option value="1">Rented</option>
                      <option value="2">Owned</option>
                      <option value="3">Leased</option>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td valign="top">Banking since </td>
                  <td valign="top"> 
                    <input type="text" name="txt_banksince" size="15" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
						maxlength="20" tabindex="4" value="<%=Helper.correctNull((String) hshValues.get("banksince"))%>"  class="interfacefields">
                  </td>
                  <td valign="top">Advance since</td>
                  <td> 
                    <input type="text" name="txt_advancesince" size="15" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
						maxlength="20" tabindex="5" value="<%=Helper.correctNull((String) hshValues
									.get("advancesince"))%>">
                    <a href="#" onClick="callCalender('txt_advancesince')"
						title="Click to view calender" border="0"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="5"></a> </td>
                </tr>
                <tr> 
                  <td valign="top">Constitution</td>
                  <td valign="top"> 
                    <input type="text" name="txt_consititution" size="25"
						maxlength="20" tabindex="1" value="<%=Helper.correctNull((String) hshValues
									.get("constitution"))%>" class="interfacefields">
                  </td>
                  <td valign="top">Activity</td>
                  <td> 
                    <input type="text" name="txt_activity" size="35"
						maxlength="80" tabindex="1" value="<%=Helper.correctNull((String) hshValues.get("activity"))%>" class="interfacefields">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">(a) Banking arrangement <span class="mantatory">*&nbsp;</span></td>
                  <td valign="top"> 
                    <select name="sel_bankarrangement" tabindex="6">
                      <option value="0" selected="selected">----Select----</option>
                      <option value="1">Sole</option>
                      <option value="2">Consortium</option>
                      <option value="3">Multiple Banking</option>
                    </select>
                  </td>
                  <td valign="top">Present Asset Classification</td>
                  <td> 
                    <input type="text" name="txt_preclassification" size="30"
						maxlength="25" tabindex="1" value="<%=Helper.correctNull((String) hshValues
							.get("presentclassification"))%>" class="interfacefields">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">Provision held &nbsp; &nbsp; </td>
                  <td valign="top"> 
                    <lapschoice:CurrencyTag name="txt_provision" size="25" maxlength="20" 
					tabindex="36" value='<%=Helper.correctNull((String)hshValues.get("provision"))%>' />
                  </td>
                  <td valign="top">Date of last review <span class="mantatory">*&nbsp;</span></td>
                  <td> 
                    <input type="text" name="txt_lastreview" size="15"
						maxlength="10" tabindex="37" value="<%=Helper.correctNull((String) hshValues
									.get("lastrevdate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a href="#" onClick="callCalender('txt_lastreview')"
						title="Click to view calender" border="0"> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="37"></a> </td>
                </tr>
                <tr> 
                  <td valign="top">Last Reviewed Authority <span class="mantatory">*&nbsp;</span></td>
                  <td valign="top">
                    <select name="sel_sancauth"
						tabindex="4">
                      <option value="0" selected="selected">-----select-----</option>
                      <%
                      	String apptype = "21";
                      %>
                      <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                    </select>
                  </td>
                  <td valign="top">Last reviewed by <span class="mantatory">*&nbsp;</span></td>
                  <td> 
                    <input type="text" name="txt_lastreviewby" size="25" tabindex="38"
						maxlength="20" value="<%=Helper.correctNull((String) hshValues
									.get("sancauthname"))%>">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">Reviewed Officer Scale</td>
                  <td valign="top"> 
                    <input type="text" name="txt_scale" size="25" tabindex="40"
						maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("sta_scale"))%>">
                  </td>
                  <td valign="top"> Last financial statement held on record</td>
                  <td> 
                    <input type="text" name="txt_lastfinancedate" size="15"
						maxlength="10" tabindex="41" value="<%=Helper.correctNull((String) hshValues
							.get("sta_lastfinancedate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a href="#" onClick="callCalender('txt_lastfinancedate')"
						title="Click to view calender" border="0"> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="41"></a> </td>
                </tr>
                <tr> 
                  <td valign="top">Date since A/c., is in excess</td>
                  <td valign="top"> 
                    <input type="text" name="txt_excessdate" size="15"
						maxlength="10" tabindex="42" value="<%=Helper.correctNull((String) hshValues
							.get("sta_excessdate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a href="#" onClick="callCalender('txt_excessdate')"
						title="Click to view calender" border="0"> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="42"></a> </td>
                  <td valign="top">Maximum excess allowed</td>
                  <td> 
                    <input type="text" name="txt_maxexcessallowed" size="25"
						maxlength="20" tabindex="43" value="<%=Helper.correctNull((String) hshValues
							.get("sta_maxexcessallowed"))%>">
                  </td>
                </tr>
                <tr> 
                  <td valign="top">Steps taken for adjustment.</td>
                  <td valign="top"> 
                    <textarea name="txt_stepstaken" tabindex="44" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String) hshValues
							.get("sta_stepstaken"))%></textarea>
                  </td>
                  <td valign="top">&nbsp;</td>
                  <td>&nbsp; </td>
                </tr>
                <tr> 
                  <td valign="top">Whether unit is working/closed </td>
                  <td valign="top"> 
                    <select name="sel_unitstatus" onChange="showinfo()" tabindex="31">
                      <option value="0" selected="selected">----Select----</option>
                      <option value="1">Working</option>
                      <option value="2">Closed</option>
                    </select>
                  </td>
                  <td valign="top">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr id="work"> 
                  <td valign="top">Stautus of Working</td>
                  <td valign="top"> 
                    <select name="sel_unitrunfor" onChange="showinfo()" tabindex="32">
                      <option value="0" selected="selected">----Select----</option>
                      <option value="1">Own Account</option>
                      <option value="2">Doing Job Work</option>
                    </select>
                  </td>
                  <td valign="top">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td id="no1" valign="top">Date Since Unit is closed</td>
                  <td  id="no11" valign="top"> 
                    <input type="text" name="txt_unitclosedsince" size="12" tabindex="33" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
						maxlength="10"  value="<%=Helper.correctNull((String) hshValues
							.get("unitclosedsince"))%>" >
                    <a href="#" onClick="callCalender('txt_unitclosedsince')"
						title="Click to view calender"> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							width="0" border="0" tabindex="33"></a></td>
                  <td id="no2" valign="top">Sources of Livelihood : </td>
                  <td id="no22"> 
                    <textarea name="txt_srclivehood" tabindex="44" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String) hshValues
									.get("livehoodsrc"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidbankarrangement" value="<%=strbankarrangement%>">
<input type="hidden" name="hidReviewAuth">
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
</form>
</body>
</html>
